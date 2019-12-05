//
//  SwipeController.m
//  OmniRetailer
//
//  Created by Mac on 7/18/13.
//
//

#import "SwipeController.h"
#import "Global.h"
#import "BillingHome.h"

#include <unistd.h>
#include <time.h>

#include "SReaderDriver.h"
#include "SReaderUtility.h"


@interface SwipeController ()

@end

@implementation SwipeController

@synthesize m_textview;
@synthesize m_sndDemoShow;
@synthesize name, card_no, valid, amt, cvv;
@synthesize statusMsg;


#define kOutputBus 0
#define kInputBus 1

OSStatus status=0;
extern AudioComponentInstance audioUnit;

SwipeController* THIS = NULL;

NSString *Decryption_data = NULL;

NSString *snd_demo = NULL;
char snd_str[1024] = {0};

extern int DEBUG_MIC;



void checkStatus(OSStatus status)
{
    //NSLog(@"HELLO: Status=%ld", status);
    return;
}


static int callback_lock = 0;

static OSStatus playbackCallback(void *inRefCon,
                                 AudioUnitRenderActionFlags *ioActionFlags,
                                 const AudioTimeStamp *inTimeStamp,
                                 UInt32 inBusNumber,
                                 UInt32 inNumberFrames,
                                 AudioBufferList *ioData)
{
    // Notes: ioData contains buffers (may be more than one!)
    // Fill them up as much as you can. Remember to set the size value in each buffer to match how
    // much data is in the buffer.
    
    if (callback_lock == 1) {
        NSLog(@"===> playback is overflow!!!");
        return noErr;
    } else {
        callback_lock = 1;
    }
    
    THIS = (__bridge SwipeController*)inRefCon;
    
    //NSLog(@"playback inBusNumber:%ld, inNumberFrames:%ld, ioData:0x%08x",inBusNumber, inNumberFrames, ioData);
    if (ioData == NULL) {
        NSLog(@"playback AudioBuffer is NULL");
        return noErr;
    }
    
    //NSLog(@"AudioBuffer mData[0] Byte Size%ld", ioData->mBuffers[0].mDataByteSize);
    //NSLog(@"AudioBuffer mData[1] Byte Size%ld", ioData->mBuffers[1].mDataByteSize);
    
    
    OSStatus status = AudioUnitRender(audioUnit,
                                      ioActionFlags,
                                      inTimeStamp,
                                      kInputBus,//1,
                                      inNumberFrames,
                                      ioData);
    checkStatus(status);
    
    short *readBuffer = (short *)ioData->mBuffers[0].mData;
    UART_Decode(inNumberFrames, readBuffer);
    
    //int range = MIN(abs(readBuffer[0])/100, 1023);
    //NSLog(@"sound demo  value ========= %d =========", range);
    
    /*******************/
    /* for testing...  */
    /* log mic data    *
     //DEBUG_MIC = 0;
     if (DEBUG_MIC) {
     char *str = snd_str;
     NSLog(@"MIC CallBack Log:\n");
     for (int i=0; i<inNumberFrames; i++) {
     sprintf(str, "%d,", readBuffer[i]);
     str += strlen(str);
     if ((i+1)%8 == 0) {
     str = snd_str;
     NSLog(@"%s\n", str);
     }
     }
     DEBUG_MIC = 0;
     }
     //*/
    
    //writeBufferl = (short *)ioData->mBuffers[0].mData;
    //writeBufferr = (short *)ioData->mBuffers[1].mData;
    
    short *writeBufferl = (short *)ioData->mBuffers[0].mData;
    short *writeBufferr = (short *)ioData->mBuffers[1].mData;
    
    UART_Encode(inNumberFrames, writeBufferl, writeBufferr);
    
    /*******************/
    /* for testing...  *
     snd_str[0] = '@';
     range++;
     for (int i=1; i<range; i++) {
     snd_str[i] = '=';
     }
     snd_str[range] = 0;
     NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
     snd_demo = [[NSString alloc] initWithFormat:@"%s", snd_str];
     [pool release];
     [THIS->m_sndDemoShow performSelectorOnMainThread:@selector(setText:) withObject:snd_demo waitUntilDone:NO];
     /*/
    
    callback_lock = 0;
    
    return noErr;
}


- (void) goBack: (id) sender {
     //[self.navigationController popViewControllerAnimated:YES];
    
    swipe_Status = @"";
    [self doSetKey];
    [self dismissViewControllerAnimated:NO
                             completion:^{
                                 // instantiate and initialize the new controller
                                 SwipeController *newViewController = [[SwipeController alloc] init];
                                 [self.presentingViewController presentViewController:newViewController
                                                                               animated:YES
                                                                             completion:nil];
                             }];
}


- (BOOL)hasMicphone {
    return [AVAudioSession sharedInstance].inputIsAvailable;
}

- (BOOL)hasHeadset {
#if TARGET_IPHONE_SIMULATOR
#warning *** Simulator mode: audio session code works only on a device
    return NO;
#else
    CFStringRef route;
    UInt32 propertySize = sizeof(CFStringRef);
    AudioSessionGetProperty(kAudioSessionProperty_AudioRoute, &propertySize, (void *)&route);
    
    if((route == NULL) || (CFStringGetLength(route) == 0)){
        // Silent Mode
        m_strLog = [[NSString alloc] initWithFormat:@"%@\n%@\n", m_strLog, @"AudioRoute: SILENT, do nothing!"];
    } else {
        NSString* routeStr = (__bridge NSString*)route;
        m_strLog = [[NSString alloc] initWithFormat:@"%@\nAudioRoute:\n%@\n", m_strLog, routeStr];
        
        /* Known values of route:
         * "Headset"
         * "Headphone"
         * "Speaker"
         * "SpeakerAndMicrophone"
         * "HeadphonesAndMicrophone"
         * "HeadsetInOut"
         * "ReceiverAndMicrophone"
         * "Lineout"
         */
        
        NSRange headsetRange = [routeStr rangeOfString : @"Headset"];
        if(headsetRange.location != NSNotFound) {
            return YES;
        }
    }
    return NO;
#endif
}

void rioInterruptionListener(void *inClientData, UInt32 inInterruption)
{
    NSLog(@"Session interrupted! --- %s ---", inInterruption == kAudioSessionBeginInterruption ? "Begin Interruption" : "End Interruption");
    
    //SReaderV1_0ViewController *_self = (SReaderV1_0ViewController *) inClientData;
    
    if (inInterruption == kAudioSessionEndInterruption) {
        // make sure we are again the active session
        AudioSessionSetActive(true);
        AudioOutputUnitStart(audioUnit);
    }
    
    if (inInterruption == kAudioSessionBeginInterruption) {
        AudioOutputUnitStop(audioUnit);
    }
}


void audioRouteChangeListenerCallback (
                                       void                      *inUserData,
                                       AudioSessionPropertyID    inPropertyID,
                                       UInt32                    inPropertyValueSize,
                                       const void                *inPropertyValue)
{
    if (inPropertyID != kAudioSessionProperty_AudioRouteChange)
        return;
    
    SwipeController *_self = (__bridge SwipeController *) inUserData;
    
    CFDictionaryRef    routeChangeDictionary = inPropertyValue;
    CFNumberRef routeChangeReasonRef = CFDictionaryGetValue (routeChangeDictionary,
                                                             CFSTR (kAudioSession_AudioRouteChangeKey_Reason));
    
    NSString *str = NULL;
    
    SInt32 routeChangeReason;
    CFNumberGetValue (routeChangeReasonRef, kCFNumberSInt32Type, &routeChangeReason);
    NSLog(@" ======================= RouteChangeReason : %d", (int)routeChangeReason);
    
    if (routeChangeReason == kAudioSessionRouteChangeReason_OldDeviceUnavailable) {
        //[_self resetSettings];
        _self->m_strLog = @"=======================\nkAudioRouteChangeReason:\n OldDeviceUnavailable!\n";
    } else if (routeChangeReason == kAudioSessionRouteChangeReason_NewDeviceAvailable) {
        //[_self resetSettings];
        _self->m_strLog = @"=======================\nkAudioRouteChangeReason:\n NewDeviceAvailable!\n";
    } else if (routeChangeReason == kAudioSessionRouteChangeReason_NoSuitableRouteForCategory) {
        //[_self resetSettings];
        _self->m_strLog = @"=======================\nkAudioRouteChangeReason:\n lostMicroPhone";
    }
    //else if (routeChangeReason == kAudioSessionRouteChangeReason_CategoryChange  ) {
    //}
    else {
        _self->m_strLog = @"=======================\nUnknown Reason:";
    }
    
    
    if ([_self hasHeadset]) {
        //has Headset
        str = @"Has Headset\n";
        [_self postCommand:MSG_CMD_DETECT];
    } else {
        //not has Headset
        str = @"No Headset\n";
        [_self postCommand:MSG_CMD_STOP];
    }
    
    _self->m_strLog = [[NSString alloc] initWithFormat:@"%@\n%@", _self->m_strLog, str];
    
    //    [[_self m_textview] setText:_self->m_strLog];
    NSLog(@"%@", _self->m_strLog);
    _self.m_sndDemoShow.text = str;
    
    _self->m_strLog = NULL;
    
    
}




 // The designated initializer. Override to perform setup that is required before the view is loaded.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization
 }
 return self;
 }





// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    [super loadView];
    m_textview.text = @"Load View...";
    m_sndDemoShow.text = @"@";
    //[name setText:@"Swipe the Card"];
    
    // for testing...
    hello();
    
    m_strLog = NULL;
    
    m_CommandMsg = MSG_CMD_IDLE;
    m_CommandLock = [[NSLock alloc] init];
    [NSThread detachNewThreadSelector:@selector(processCommand:) toTarget:self withObject:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    
    statusMsg.text = @"Detecting Device";
    [self doDetect];
    
}



- (void)viewDidLoad    {
    
    [super viewDidLoad];

    m_bSwipw = [UIButton buttonWithType:UIButtonTypeCustom];
    [m_bSwipw addTarget:self action:@selector(doSwipe:) forControlEvents:UIControlEventTouchUpInside];
    //m_bSwipw.tag = 1;
    [m_bSwipw setTitle:@"Swipe"    forState:UIControlStateNormal];
    m_bSwipw.titleLabel.textAlignment = NSTextAlignmentCenter;
    m_bSwipw.backgroundColor = [UIColor grayColor];
    m_bSwipw.titleLabel.textColor = [UIColor whiteColor];
    m_bSwipw.frame = CGRectMake(10.0, 365.0, 300.0, 30.0);
    m_bSwipw.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    m_bSwipw.layer.cornerRadius = 15.0f;
    [self.view addSubview:m_bSwipw];
    
    okbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [okbtn addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
    //okbtn.tag = 1;
    [okbtn setTitle:@"OK"    forState:UIControlStateNormal];
    okbtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    okbtn.backgroundColor = [UIColor grayColor];
    okbtn.titleLabel.textColor = [UIColor whiteColor];
    okbtn.frame = CGRectMake(10.0, 400.0, 147.0, 30.0);
    okbtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    okbtn.layer.cornerRadius = 15.0f;
    [self.view addSubview:okbtn];
    
    cancelbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelbtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    //cancelbtn.tag = 1;
    [cancelbtn setTitle:@"Cancel"    forState:UIControlStateNormal];
    cancelbtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    cancelbtn.backgroundColor = [UIColor grayColor];
    cancelbtn.titleLabel.textColor = [UIColor whiteColor];
    cancelbtn.frame = CGRectMake(162.0, 400.0, 147.0, 30.0);
    cancelbtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    cancelbtn.layer.cornerRadius = 15.0f;
    [self.view addSubview:cancelbtn];
    
    m_textview.text = @"Plugin CardReader to Start...";
    statusMsg.text = @"Plugin CardReader to Start ...";
    
    amt.text = swipe_Status;

    [m_bDetect setEnabled:NO];
    [name setEnabled:NO];
    //[cvv setEnabled:NO];
    cvv.delegate = self;
    [card_no setEnabled:NO];
    [valid setEnabled:NO];
    [amt setEnabled:YES];
    amt.delegate = self;
    
    [statusMsg setEnabled:NO];
 
    // Describe audio component
    AudioComponentDescription desc;
    desc.componentType = kAudioUnitType_Output;
    desc.componentSubType = kAudioUnitSubType_RemoteIO;
    desc.componentFlags = 0;
    desc.componentFlagsMask = 0;
    desc.componentManufacturer = kAudioUnitManufacturer_Apple;
    
    // Get component
    AudioComponent inputComponent = AudioComponentFindNext(NULL, &desc);
    
    // Get audio units
    status = AudioComponentInstanceNew(inputComponent, &audioUnit);
    checkStatus(status);
    
    // Enable IO for recording
    UInt32 flag = 1;
    status = AudioUnitSetProperty(audioUnit,
                                  kAudioOutputUnitProperty_EnableIO,
                                  kAudioUnitScope_Input,
                                  kInputBus,
                                  &flag,
                                  sizeof(flag));
    checkStatus(status);
    
    
    // Enable IO for playback
    flag = 1;
    status = AudioUnitSetProperty(audioUnit,
                                  kAudioOutputUnitProperty_EnableIO,
                                  kAudioUnitScope_Output,
                                  kOutputBus,
                                  &flag,
                                  sizeof(flag));
    checkStatus(status);
    
    
    AURenderCallbackStruct callbackStruct;
    
    // Set output callback
    callbackStruct.inputProc = playbackCallback;
    callbackStruct.inputProcRefCon = (__bridge void * _Nullable)(self);
    
    NSLog(@"Set Render callback");
    status = AudioUnitSetProperty(audioUnit,
                                  kAudioUnitProperty_SetRenderCallback,
                                  kAudioUnitScope_Global, //kAudioUnitScope_Input,//kAudioUnitScope_Global,
                                  kOutputBus,
                                  &callbackStruct,
                                  sizeof(callbackStruct));
    checkStatus(status);
    
    
    // Describe format
    AudioStreamBasicDescription audioFormat;
    audioFormat.mSampleRate            = 44100.00;
    audioFormat.mFormatID            = kAudioFormatLinearPCM;
    audioFormat.mFormatFlags        = kAudioFormatFlagsCanonical | kAudioFormatFlagIsNonInterleaved;
    //kAudioFormatFlagIsSignedInteger | kAudioFormatFlagIsPacked
    audioFormat.mFramesPerPacket    = 1;
    audioFormat.mChannelsPerFrame    = 2;
    audioFormat.mBitsPerChannel        = 16;
    audioFormat.mBytesPerPacket        = 2;
    audioFormat.mBytesPerFrame        = 2;
    
    // Apply format
    status = AudioUnitSetProperty(audioUnit,
                                  kAudioUnitProperty_StreamFormat,
                                  kAudioUnitScope_Input,
                                  kOutputBus,
                                  &audioFormat,
                                  sizeof(audioFormat));
    checkStatus(status);
    
    status = AudioUnitSetProperty(audioUnit,
                                  kAudioUnitProperty_StreamFormat,
                                  kAudioUnitScope_Output,
                                  kInputBus,
                                  &audioFormat,
                                  sizeof(audioFormat));
    checkStatus(status);
    
    SInt32 hwSampleRate;
    UInt32 size = sizeof(hwSampleRate);
    status = AudioSessionGetProperty(kAudioSessionProperty_CurrentHardwareSampleRate, &size, &hwSampleRate);
    checkStatus(status);
    NSLog(@"Hardware Sample Rate = %d", (int)hwSampleRate);
    
    size = sizeof(audioFormat);
    status = AudioUnitGetProperty(audioUnit,
                                  kAudioUnitProperty_StreamFormat,
                                  kAudioUnitScope_Input,
                                  kOutputBus,
                                  &audioFormat,
                                  &size);
    checkStatus(status);
    NSLog(@"AudioUnit Sample Rate = %lf", audioFormat.mSampleRate);
    
    // set numbers per Frame
    UInt32 numFrames = 4096;
    status = AudioUnitSetProperty(audioUnit,
                                  kAudioUnitProperty_MaximumFramesPerSlice,
                                  kAudioUnitScope_Global,
                                  kOutputBus,
                                  &numFrames,
                                  sizeof(numFrames));
    checkStatus(status);
    status = AudioUnitSetProperty(audioUnit,
                                  kAudioUnitProperty_MaximumFramesPerSlice,
                                  kAudioUnitScope_Global,
                                  kInputBus,
                                  &numFrames,
                                  sizeof(numFrames));
    checkStatus(status);
    
    // set what ??????
    Float32 preferredBufferSize = 0.1;
    status = AudioSessionSetProperty(kAudioSessionProperty_PreferredHardwareIOBufferDuration, sizeof(preferredBufferSize), &preferredBufferSize);
    checkStatus(status);
    
    UInt32 maxFPS;
    size = sizeof(maxFPS);
    status = AudioUnitGetProperty(audioUnit, kAudioUnitProperty_MaximumFramesPerSlice, kAudioUnitScope_Global, kOutputBus, &maxFPS, &size);
    checkStatus(status);
    NSLog(@"max Maximum Frames PerSlice = %d", (unsigned int)maxFPS);
    
    // Disable buffer allocation for the recorder (optional - do this if we want to pass in our own)
    /*
     flag = 0;
     status = AudioUnitSetProperty(audioUnit,
     kAudioUnitProperty_ShouldAllocateBuffer,
     kAudioUnitScope_Output,
     kInputBus,
     &flag,
     sizeof(flag));
     */
    
    
    // Initialise
    NSLog(@"AudioUnitInitialize");
    status = AudioUnitInitialize(audioUnit);
    checkStatus(status);
    
    /* to Start untile press DETECT button
     // to Start
     NSLog(@"AudioOutputUnitStart");
     status = AudioOutputUnitStart(audioUnit);
     checkStatus(status);
     */
    
    
    AudioSessionInitialize(NULL, NULL, rioInterruptionListener, (__bridge void *)(self));
    UInt32 audioCategory = kAudioSessionCategory_PlayAndRecord;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(audioCategory), &audioCategory);
    AudioSessionAddPropertyListener (kAudioSessionProperty_AudioRouteChange,
                                     audioRouteChangeListenerCallback,
                                     (__bridge void *)(self));
    AudioSessionSetActive(true);
    //[[AVAudioSession sharedInstance] setActive: YES error:NULL];
    
    return;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) finish: (id) sender {
    
    
    NSLog(@"%d",swipe_Status.intValue);
    NSLog(@"%d",(amt.text).intValue);
    
    if ([name.text isEqualToString:@""] || [cvv.text isEqualToString:@""] || [card_no.text isEqualToString:@""] || [valid.text isEqualToString:@""] || [amt.text isEqualToString:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"All Fields are mandatory" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    else if(swipe_Status.intValue < (amt.text).intValue){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Enter Valid Amount." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else {
        // close the audio connection ..
       // swipe_Status = @"PAID";   // global variable ..
        
        //swipe_Status = amt.text;
        swipe_Status =   [[NSString stringWithFormat:@"%d",swipe_Status.intValue-(amt.text).intValue] copy];
        [self doSetKey];
        //SReader_Stop();
        
        //[self.navigationController popViewControllerAnimated:NO];
        
        [self dismissViewControllerAnimated:NO
                                 completion:^{
                                     // instantiate and initialize the new controller
                                     SwipeController *newViewController = [[SwipeController alloc] init];
                                     [self.presentingViewController presentViewController:newViewController
                                                                                   animated:YES
                                                                                 completion:nil];
                                 }];
    }
    
}

- (IBAction)cancel {
    
    // close the audio connection ..
    [self doSetKey];
    //SReader_Stop();
    [self.navigationController popViewControllerAnimated:NO];
    
}


- (void)processCommand:(id)param {
    
    SReader_Init();
    
    while (m_CommandMsg != MSG_CMD_QUIT) {
        [m_CommandLock lock];
        int comStatus = m_CommandMsg;
        //m_CommandMsg = MSG_CMD_IDLE; //hold on...
        [m_CommandLock unlock];
        
        switch (comStatus) {
                
            case MSG_CMD_IDLE:
                usleep(100000);
                continue;
                break;
            case MSG_CMD_DETECT:
                if ([self SReader_Detect] == YES)
                    //[self Prompt:@"\nPress SWIPE to Swipe card..."];
                    [self Status:@"\nPress SWIPE to Swipe card..."];
                break;
            case MSG_CMD_GET:
                if ([self SReader_Get] == YES)
                    //[self Prompt:@"\nPress SWIPE to Swipe card..."];
                    [self Status:@"\nPress SWIPE to Swipe card..."];
                break;
            case MSG_CMD_SWIPE:
                [self SReader_Swipe];
                //[self Prompt:@"\nPress SWIPE to Swipe card again..."];
                [self Status:@"\nPress SWIPE to Swipe card..."];
                break;
            case MSG_CMD_STOP:
                [self Prompt:@"to stop audiounit..."];
                SReader_Stop();
                [self Prompt:@"\nPress DETECT to Start..."];
                break;
            default:
                break;
        }
        
        [m_CommandLock lock];
        // clear the command ID
        m_CommandMsg = MSG_CMD_IDLE;
        [m_CommandLock unlock];
    }
    
    return;
}

- (BOOL)SReader_Detect {
    NSString* str = NULL;
    
    [self Prompt:@"Start to detect..."];
    
    SReader_Start();
    
    [self Prompt:@"Hold 5 seconds!"];
    [self Status:@"Hold 5 seconds!"];
    sleep(5);
    
    [self Prompt:@"to Initial Card Reader..."];
    [self Status:@"to Initial Card Reader..."];
    
    unsigned char *AA = SReader_Initial();
    for (int i=0; i<3; i++) {
        if (AA != NULL)
            break;
        else {
            AA = SReader_Initial();
        }
        
    }
    if (AA == NULL) {
        [self Prompt:@"time out ..."];
        [self Status:@"Time out ..."];
        
        [self Prompt:@"to close sin wave"];
        CloseSinWave();
        return NO;
    } else {
        str = [[NSString alloc] initWithFormat:@"Card Reader answer = %s", AA];
        NSLog(@"%@", str);
        [self Prompt:str];
    }
    
    /*
     usleep(1000000);
     [self Prompt:@"to get Version..."];
     unsigned char *Version = SReader_GetVersion();
     if (Version == NULL) {
     [self Prompt:@"time out ..."];
     [self Prompt:@"to close sin wave"];
     CloseSinWave();
     return NO;
     } else {
     str = [[NSString alloc] initWithFormat:@"Version = %s", Version];
     NSLog(@"%@", str);
     [self Prompt:str];
     }
     */
    
    usleep(1500000);
    [self Prompt:@"to get KSN..."];
    unsigned char *KSN = SReader_GetKSN();
    if (KSN == NULL) {
        [self Prompt:@"time out ..."];
        [self Prompt:@"to close sin wave"];
        CloseSinWave();
        return NO;
    } else {
        str = [[NSString alloc] initWithFormat:@"KSN = %s", get_CurrentKSN()];
        NSLog(@"%@", str);
        [self Prompt:str];
    }
    
    /*
     usleep(1000000);
     [self Prompt:@"to get Random..."];
     unsigned char *Random = SReader_GetRandom();
     if (Random == NULL) {
     [self Prompt:@"time out ..."];
     [self Prompt:@"to close sin wave"];
     CloseSinWave();
     return NO;
     } else {
     str = [[NSString alloc] initWithFormat:@"Random = %s", get_CurrentRandom()];
     NSLog(@"%@", str);
     [self Prompt:str];
     }
     
     [self Prompt:@"to generate WorkingKey..."];
     unsigned char *WorkingKey = SReader_GenerateWorkingKey();
     if (WorkingKey == NULL) {
     [self Prompt:@"Failed to generate WorkingKey"];
     return NO;
     } else {
     str = [[NSString alloc] initWithFormat:@"Counter = %s", get_CurrentCounter()];
     NSLog(@"%@", str);
     //[self Prompt:str];
     
     str = [[NSString alloc] initWithFormat:@"WorkingKey = %s", get_CurrentWorkingKey()];
     NSLog(@"%@", str);
     //[self Prompt:str];
     }
     */
    
    return YES;
}

- (BOOL)SReader_Get {
    NSString* str = NULL;
    
    NSString *prompt = [[NSString alloc] initWithFormat:@"%@\n",
                        Decryption_data];
    
    [self Prompt:@"Start to get infomation..."];
    
    [self Prompt:@"to get T1_PAN..."];
    unsigned char *T1_PAN = SReader_T1_PAN();
    if (T1_PAN == NULL) {
        [self Prompt:@"EMPTY ..."];
        T1_PAN = (unsigned char *)"EMPTY";
    } else {
        str = [[NSString alloc] initWithFormat:@"T1_PAN = %s", T1_PAN];
        NSLog(@"%@", str);
        [self Prompt:str];
    }
    prompt = [[NSString alloc] initWithFormat:@"%@\nT1PAN:%s", prompt, T1_PAN];
    
    usleep(1000000);
    [self Prompt:@"to get T1 Name_ExD..."];
    unsigned char *T1_ExD = SReader_T1_ExD();
    if (T1_ExD == NULL) {
        [self Prompt:@"EMPTY ..."];
        T1_ExD = (unsigned char *)"EMPTY";
    } else {
        str = [[NSString alloc] initWithFormat:@"T1_ExD = %s", T1_ExD];
        NSLog(@"%@", str);
        [self Prompt:str];
    }
    prompt = [[NSString alloc] initWithFormat:@"%@\nT1Name_Exd:%s", prompt, T1_ExD];
    
    usleep(1000000);
    [self Prompt:@"to get T2_PAN..."];
    unsigned char *T2_PAN = SReader_T2_PAN();
    if (T2_PAN == NULL) {
        [self Prompt:@"EMPTY ..."];
        T2_PAN = (unsigned char *)"EMPTY";
    } else {
        str = [[NSString alloc] initWithFormat:@"T2_PAN = %s", T2_PAN];
        NSLog(@"%@", str);
        [self Prompt:str];
    }
    prompt = [[NSString alloc] initWithFormat:@"%@\nT2PAN:%s", prompt, T2_PAN];
    
    usleep(1000000);
    [self Prompt:@"to get T2 ExD..."];
    unsigned char *T2_ExD = SReader_T2_ExD();
    if (T2_ExD == NULL) {
        [self Prompt:@"EMPTY ..."];
        T2_ExD = (unsigned char *)"EMPTY";
    } else {
        str = [[NSString alloc] initWithFormat:@"T2_ExD = %s", T2_ExD];
        NSLog(@"%@", str);
        [self Prompt:str];
    }
    prompt = [[NSString alloc] initWithFormat:@"%@\nT2Exd:%s", prompt, T2_ExD];
    
    sleep(3);
    
    [self Prompt:NULL];
    [self Prompt:prompt];
    
    return YES;
}


- (BOOL)SReader_Swipe {
    NSString* str = NULL;
    
    [self Prompt:@"to get Random..."];
    unsigned char *Random = SReader_GetRandom();
    if (Random == NULL) {
        [self Prompt:@"time out ..."];
        [self Prompt:@"to close sin wave"];
        CloseSinWave();
        return NO;
    } else {
        str = [[NSString alloc] initWithFormat:@"Random = %s", get_CurrentRandom()];
        NSLog(@"%@", str);
        [self Prompt:str];
    }
    
    [self Prompt:@"to generate WorkingKey..."];
    unsigned char *WorkingKey = SReader_GenerateWorkingKey();
    if (WorkingKey == NULL) {
        [self Prompt:@"Failed to generate WorkingKey"];
        return NO;
    } else {
        str = [[NSString alloc] initWithFormat:@"Counter = %s", get_CurrentCounter()];
        NSLog(@"%@", str);
        //[self Prompt:str];
        
        str = [[NSString alloc] initWithFormat:@"WorkingKey = %s", get_CurrentWorkingKey()];
        NSLog(@"%@", str);
        //[self Prompt:str];
    }
    
    //==================================================================================================
    int recvDataLen = 0;
    unsigned char *recvData = SReader_ReadCard(&recvDataLen);
    
    if (recvData != NULL && recvDataLen > 0)
    {
        NSLog(@"read card success!");
        [self Prompt:@"read card success!"];
    } else {
        [self Prompt:@"Read card failed!"];
        
        if (recvDataLen == -1) {
            [self Prompt:@"time out..."];
        } else {
            unsigned char *data = get_rawData();
            int len = get_rawDataLen();
            NSString *rawString = Hex2NSString(data, len);
            [self Prompt:@"raw data:"];
            [self Prompt:rawString];
            
            int err = get_errcode();
            switch (err) {
                case ERR_NODATA:
                    [self Prompt:@"ERR:no data buffer"];
                    break;
                case ERR_NOSTART1C:
                    [self Prompt:@"ERR:not start with 0x1c"];
                    break;
                case ERR_LARGEDATALEN:
                    [self Prompt:@"ERR:get data length larger then buffer"];
                    break;
                case ERR_SMALLDATALEN:
                    [self Prompt:@"ERR:get data length less then 2"];
                    break;
                case ERR_WRONGETX:
                    [self Prompt:@"ERR:the etx data is wrong"];
                    break;
                case ERR_WRONGEDC:
                    [self Prompt:@"ERR:the edc data is wrong"];
                    break;
                case ERR_FUNCFAILED: {
                    int sw1, sw2;
                    get_swcode(&sw1, &sw2);
                    
                    NSString *str = [[NSString alloc] initWithFormat:
                                     @"ERR:the reader just give\n sw1=%02x, sw2=%02x\n",
                                     (unsigned char)sw1, (unsigned char)sw2];
                    [self Prompt:str];
                    
                    if (sw1 == 0x6f) {
                        str = @"Decryption data";
                        [self Prompt:str];
                        
                        str = @"";
                        switch (sw2) {
                            case 0x01:
                                str = @"T1 Error";
                                break;
                            case 0x02:
                                str = @"T2 Error";
                                break;
                            case 0x04:
                                str = @"T3 Error";
                                break;
                            case 0x03:
                                str = @"T1 Error & T2 Error";
                                break;
                            case 0x05:
                                str = @"T1 Error & T3 Error";
                                break;
                            case 0x06:
                                str = @"T2 Error & T3 Error";
                                break;
                            case 0x07:
                                str = @"T1 Error & T2 Error & T3 Error";
                                break;
                            default:
                                str = @"unknown Error";
                                break;
                        }
                        
                        [self Prompt:str];
                    }
                    break;
                }
                default:
                    [self Prompt:@"ERR:unknown"];
                    break;
            }
        }
        
        [self Prompt:@"\nto cancel..."];
        SReader_Cancel();
        usleep(10000);
        
        return NO;
    }
    
    NSString *encString = Hex2NSString((unsigned char *)recvData, recvDataLen);
    [self Prompt:encString];
    
    unsigned char *outbuff = (unsigned char *)malloc(recvDataLen+8);
    
    size_t retNum = 0;
    BOOL ret = TriDesDecryptio((void *)recvData, recvDataLen, (void *)outbuff, recvDataLen+1, &retNum);
    if (ret == TRUE && retNum > recvDataLen) {
        retNum = recvDataLen;
    }
    outbuff[retNum] = 0;
    free(recvData);
    
    TrimePaddingData(outbuff, &retNum);
    
    NSString *decString = Hex2NSString((unsigned char *)outbuff, retNum);
    [self Prompt:decString];
    
    char * T1 = strchr((char *)outbuff, 0xa1);
    char * T2 = strchr((char *)outbuff, 0xa2);
    char * T3 = strchr((char *)outbuff, 0xa3);
    if (T1 != NULL) {
        *T1 = 0;
        T1++;
    } else {
        T1 = "";
    }
    if (T2 != NULL) {
        *T2 = 0;
        T2++;
    } else {
        T2 = "";
    }
    if (T3 != NULL) {
        *T3 = 0;
        T3++;
    } else {
        T3 = "";
    }
    
    if (*T1 == 0)
        T1 = "T1 Empty";
    if (*T2 == 0)
        T2 = "T2 Empty";
    if (*T3 == 0)
        T3 = "T3 Empty";
    
    /*
     int sw1=0, sw2=0;
     get_swcode(&sw1, &sw2);
     if (sw1 == 0x6f) {
     switch (sw2) {
     case 0x01:
     T1 = "T1 Error";
     break;
     case 0x02:
     T2 = "T2 Error";
     break;
     case 0x04:
     T3 = "T3 Error";
     break;
     case 0x03:
     T1 = "T1 Error";
     T2 = "T2 Error";
     break;
     case 0x05:
     T1 = "T1 Error";
     T3 = "T3 Error";
     break;
     case 0x06:
     T2 = "T2 Error";
     T3 = "T3 Error";
     break;
     case 0x07:
     T1 = "T1 Error";
     T2 = "T2 Error";
     T3 = "T3 Error";
     break;
     default:
     break;
     }
     }
     */
    
    NSString *formatString = [[NSString alloc] initWithFormat:@"\tT1=%s\n\tT2=%s\n\tT3=%s\n", T1, T2, T3];
    Decryption_data = [[NSString alloc] initWithFormat:@"Decryption data\n%@",
                       formatString];
    
    NSString *prompt = [[NSString alloc] initWithFormat:@"%s\nEncryption data\n%@\nDecryption data\n%@",
                        get_CurrentVersion(),
                        encString,
                        formatString];
    
    //Track2 data length test
    if (strcmp(T2, "T2 Error") && strcmp(T2, "T2 Empty")) {
        int t2_len = strlen(T2);
        if (t2_len > 0 && t2_len < 24)
            prompt = [[NSString alloc] initWithFormat:@"%@\nTrack2 Length Error = %dbyte.", prompt, t2_len];
    }
    
    
    NSLog(@" T1=%s",T1);
    NSLog(@" T2=%s",T2);
    
    
    NSArray *temp;
    NSArray *temp2;
    if (T1 != NULL) {
         temp  = [[NSString stringWithFormat:@"%s",T1] componentsSeparatedByString:@"^"];
         temp2 = [[NSString stringWithFormat:@"%s",T2] componentsSeparatedByString:@"="];
    }
        
    
    NSLog(@" %@",temp2);
    
    NSString *param;
    
    if (temp[1] != NULL && temp2 != NULL) {
        param= [NSString stringWithFormat:@"%@%@%@%@%@%@%@",temp[1],@"^",temp[0],@"^",temp2[0],@"^",temp2[1]];
    }
    
    free(outbuff);
    
    // generate workingkey for next swipe
    /*
     sleep(1);
     [self Prompt:@"to get Random..."];
     unsigned char *Random = SReader_GetRandom();
     if (Random == NULL) {
     [self Prompt:@"time out ..."];
     [self Prompt:@"to close sin wave"];
     CloseSinWave();
     return NO;
     } else {
     NSString *str = [[NSString alloc] initWithFormat:@"Random = %s", get_CurrentRandom()];
     NSLog(@"%@", str);
     [self Prompt:str];
     }
     
     [self Prompt:@"to generate WorkingKey..."];
     unsigned char *WorkingKey = SReader_GenerateWorkingKey();
     if (WorkingKey == NULL) {
     [self Prompt:@"Failed to generate WorkingKey"];
     return NO;
     } else {
     NSString *str = [[NSString alloc] initWithFormat:@"Counter = %s", get_CurrentCounter()];
     NSLog(@"%@", str);
     //[self Prompt:str];
     
     str = [[NSString alloc] initWithFormat:@"WorkingKey = %s", get_CurrentWorkingKey()];
     NSLog(@"%@", str);
     //[self Prompt:str];
     }
     [self Prompt:@"\n over!"];
     */
    
    sleep(2);
    
    [self Prompt:NULL]; 

    if (param != NULL && ![param isEqualToString:@""]) {
        [self Display:param];
    }
//    [self Prompt:prompt];
    
    return YES;
}

void SReader_Stop(void)
{
    // to Stop audiounit
    NSLog(@"AudioOutputUnitStop");
    
    status = AudioOutputUnitStop(audioUnit);
    checkStatus(status);
    
    usleep(20000);
    
    initialize_buffer();
}

- (void)Display:(NSString *)str {
    
    [m_CommandLock lock];
    
    NSArray *temp;
    if (str != NULL && ![str isEqualToString:@""]) {
        
        temp  = [str componentsSeparatedByString:@"^"];
        
        NSArray *tmpArray = [[NSString stringWithFormat:@"%@",temp[0]] componentsSeparatedByString:@"   "];
        
         NSString *dateStr = [NSString stringWithFormat:@"%c%c%@%c%c",[temp[3] characterAtIndex:2], [temp[3] characterAtIndex:3], @"/",[temp[3] characterAtIndex:0],[temp[3] characterAtIndex:1]];
        
        [name performSelectorOnMainThread:@selector(setText:) withObject:tmpArray[0] waitUntilDone:NO];
        //[cvv performSelectorOnMainThread:@selector(setText:) withObject:temp[1] waitUntilDone:NO];
        [card_no performSelectorOnMainThread:@selector(setText:) withObject:temp[2] waitUntilDone:NO];
        [valid performSelectorOnMainThread:@selector(setText:) withObject:dateStr waitUntilDone:NO];
        [amt performSelectorOnMainThread:@selector(setText:) withObject:swipe_Status waitUntilDone:NO];
        
    }
    
    [m_CommandLock unlock];
    return;
}

- (void)Status:(NSString *)str {
    
    [m_CommandLock lock];
    
    //
    [statusMsg performSelectorOnMainThread:@selector(setText:) withObject:str waitUntilDone:NO];
    
    [m_CommandLock unlock];
    return;
}

- (void)Prompt:(NSString *)str {
    
    [m_CommandLock lock];
    
    if (str == NULL) {
        m_strLog = NULL;
    } else {
        if (m_strLog == NULL)
            m_strLog = str;
        else
            m_strLog = [[NSString alloc] initWithFormat:@"%@\n%@", m_strLog, str];
        
        NSLog(@" m_strLog %@",m_strLog);
        [m_textview performSelectorOnMainThread:@selector(setText:) withObject:m_strLog waitUntilDone:NO];
        
    }

    [m_CommandLock unlock];
    return;
}


void TrimePaddingData(unsigned char *outbuff, size_t *retNum)
{
    int len = (int)*retNum;
    
    int nStatus = 0;
    
    for (int i=len-1; i>=0; i--) {
        if (outbuff[i] == 0xff)
            nStatus++;
        else {
            if (nStatus > 0) {
                outbuff[i+1] = 0;
                *retNum = i+1;
                break;
            }
        }
    }
    
    return;
}

void SReader_Start(void)
{
    // to Start audiounit
    NSLog(@"AudioOutputUnitStart");
    
    //setup volume
    MPMusicPlayerController *mpc = [MPMusicPlayerController applicationMusicPlayer];
    mpc.volume = 1.0;  //0.0~1.0
    
    initialize_buffer();
    
    status = AudioOutputUnitStart(audioUnit);
    checkStatus(status);
}

void CloseSinWave(void)
{
    SReader_Stop();
}

void SReader_Init(void)
{
    
    setMainKey("SingularSINGULAR");
    
    initialize_buffer();
    
    return;
}

- (BOOL)postCommand:(int) command {
    BOOL ret = YES;
    
    [m_CommandLock lock];
    if (m_CommandMsg == MSG_CMD_IDLE)
        m_CommandMsg = command;
    else
        ret = NO;
    [m_CommandLock unlock];
    
    return ret;
}

void SReader_Release(void)
{
    status = AudioOutputUnitStop(audioUnit);
    checkStatus(status);
    
    AudioUnitUninitialize(audioUnit);
}

/**********************
 * button events
 **********************/

- (void) doSwipe: (id) sender {
    
    [self Prompt:NULL];
    m_textview.text = @"To Swipe...";
    statusMsg.text = @"Swipe ....";
    [self postCommand:MSG_CMD_SWIPE];
    
    return;
}

- (void)doDetect {
    
    [self Prompt:NULL];
    m_textview.text = @"To Detect";
    statusMsg.text = @"Detect";
    
    if ([self hasHeadset]) {
        [self postCommand:MSG_CMD_DETECT];
    } else {
        m_textview.text = @"No Device";
        statusMsg.text = @"No Device";
    }
    
    
    return;
}

- (void)doGet {
    
    [self Prompt:NULL];
    m_textview.text = @"To Get";
    statusMsg.text = @"Geting Details";
    
    if ([self hasHeadset]) {
        [self postCommand:MSG_CMD_GET];
    } else {
        m_textview.text = @"No Device";
        statusMsg.text = @"No Device";
    }
    
    
    return;
}

- (void)doSetKey {
    
    [self Prompt:NULL];
    m_textview.text = @"To Stop";
    statusMsg.text = @"Stop";
    
    [self postCommand:MSG_CMD_STOP];
    
    DEBUG_MIC = 0;//====================
    
    return;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == cvv) {
        [cvv resignFirstResponder];
    }
    else if(textField == amt){
        [amt resignFirstResponder]; 
    }
    
    return YES;
}




@end
