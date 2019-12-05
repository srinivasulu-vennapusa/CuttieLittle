//
//  SwipeController.h
//  OmniRetailer
//
//  Created by Mac on 7/18/13.
//
//

#import <UIKit/UIKit.h>

#import "AudioUnit/AudioUnit.h"
#import "AudioUnit/AUComponent.h"

#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

#import <MediaPlayer/MPMusicPlayerController.h>

@interface SwipeController : UIViewController <UITextFieldDelegate> {
    
    UITextView *m_textview;
	UITextField *m_sndDemoShow;
    UITextField *name;
    UITextField *card_no;
    UITextField *valid;
    UITextField *cvv;
    UITextField *amt;
    
	UIButton *m_bSwipw, *m_bDetect, *m_bSetKey;
    UIButton *okbtn, *cancelbtn;
    
    UITextField *statusMsg;
    
	NSString *m_strLog;

    
#define		MSG_CMD_IDLE	1001
#define		MSG_CMD_DETECT	1002
#define		MSG_CMD_SWIPE	1003
#define		MSG_CMD_STOP	1004
#define		MSG_CMD_GET 	1005
#define		MSG_CMD_QUIT	1111
	int m_CommandMsg;
	NSLock *m_CommandLock;
    

    //moved from .h to .m by srinivasulu on 02/08/2018.. due to errors..
//    AudioComponentInstance audioUnit;

    
}

@property (nonatomic, strong) IBOutlet UITextView *m_textview;
@property (nonatomic, strong) IBOutlet UITextField *m_sndDemoShow;
@property (nonatomic, strong) IBOutlet UITextField *name;
@property (nonatomic, strong) IBOutlet UITextField *statusMsg;
@property (nonatomic, strong) IBOutlet UITextField *cvv;
@property (nonatomic, strong) IBOutlet UITextField *card_no;
@property (nonatomic, strong) IBOutlet UITextField *valid;
@property (nonatomic, strong) IBOutlet UITextField *amt;


/*
 @property (nonatomic, retain) IBOutlet UIButton *m_bSwipe;
 @property (nonatomic, retain) IBOutlet UIButton *m_bDetect;
 @property (nonatomic, retain) IBOutlet UIButton *m_bSetKey;
 */

static OSStatus playbackCallback(void *inRefCon,
								 AudioUnitRenderActionFlags *ioActionFlags,
								 const AudioTimeStamp *inTimeStamp,
								 UInt32 inBusNumber,
								 UInt32 inNumberFrames,
								 AudioBufferList *ioData);

- (BOOL)hasMicphone;
- (BOOL)hasHeadset;

void audioRouteChangeListenerCallback(
									  void                      *inUserData,
									  AudioSessionPropertyID    inPropertyID,
									  UInt32                    inPropertyValueSize,
									  const void                *inPropertyValue);


//- (IBAction)doDetect;
- (void)doGet;
- (void)doSetKey;
//- (void)doSwipe;
//- (void)goBack;
//- (void) finish;

- (void) goBack: (id) sender;
- (void) finish: (id) sender;
- (void) doSwipe: (id) sender;

void SReader_Init(void);
void SReader_Release(void);
void SReader_Start(void);
void SReader_Stop(void);
void CloseSinWave(void);

- (BOOL)SReader_Detect;
- (BOOL)SReader_Swipe;
- (BOOL)SReader_Get;
- (void)Prompt:(NSString *)str;
- (void)Display:(NSString *)str;
- (BOOL)postCommand:(int)command;
- (void)processCommand:(id)param;


- (void) cancel;

@end
