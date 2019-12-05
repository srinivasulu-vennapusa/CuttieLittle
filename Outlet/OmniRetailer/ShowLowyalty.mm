//
//  ShowLowyalty.m
//  OmniRetailer
//
//  Created by Bangaru.Raju on 1/3/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "ShowLowyalty.h"
#import "Global.h"
#import "OmniHomePage.h"
//#import "SDZLoyaltycardService.h"
#import "LoyaltycardServiceSvc.h"
#import "RequestHeader.h"
#import "WebServiceController.h"
#ifndef ZXQR
#define ZXQR 1
#endif


//#if ZXQR
//#import "MultiFormatOneDReader.h"
//#endif


#ifndef ZXAZ
#define ZXAZ 0
#endif


@implementation ShowLowyalty

@synthesize soundFileURLRef,soundFileObject;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    
    loyaltyNumtxt = nil;
    
    username =nil;
    phNo = nil;
    email = nil;
    idType = nil;
    validFrom = nil;
    validThru =nil;
    availPoints = nil;
    amount = nil;
    
    
    usernameData =nil;
    phNoData = nil;
    emailData = nil;
    idNo = nil;
    validFromData = nil;
    validThruData =nil;
    phNoData = nil;
    amountData = nil;
    
}

#pragma  -mark start of ViewLifeCycle mehods....

/**
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date
 * @method       ViewDidLoad
 * @author
 * @param
 * @param
 *
 * @return
 *
 * @modified By Srinivasulu on 16/12/2017....
 * @reason      added the comments and     .... not completed....
 *
 * @verified By
 * @verified On
 *
 */

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    self.navigationController.navigationBarHidden = NO;
    
    
    
    //main view bakgroung setting...
    self.view.backgroundColor = [UIColor blackColor];
    
    float  version1 =  [UIDevice currentDevice].systemVersion.floatValue;
    
    self.titleLabel.text = @"Loyalty Card Details";
    count = 16;
    
    // BackGround color on top of the view ..
    //UILabel *topbar = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 31)] autorelease];
    //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"plain-background-home-send-ecard-leatherholes-color-border-font-2210890" ofType:@"jpg"];
    //UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images2.jpg"]];
    //    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.PNG"]];
    //
    //    // label header on top of the view...
    //    UILabel *label = [[UILabel alloc] init] ;
    //    label.text = @"Show Loyalty";
    //    label.font = [UIFont boldSystemFontOfSize:17];
    //    label.textColor = [UIColor whiteColor];
    //    label.textColor = [UIColor whiteColor];
    //    label.textAlignment = NSTextAlignmentLeft;
    //    label.backgroundColor = [UIColor clearColor];
    //
    //    // login button on top of the view...
    //    UIButton *backbutton = [[UIButton alloc] init] ;
    //    [backbutton addTarget:self action:@selector(goHomePage) forControlEvents:UIControlEventTouchUpInside];
    //    backbutton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
    //    UIImage *image = [UIImage imageNamed:@"go-back-icon.png"];
    //    [backbutton setBackgroundImage:image    forState:UIControlStateNormal];
    
    // IssueLowaltyView Design....
    //    showLoyaltyView = [[UIView  alloc] init];
    //    showLoyaltyView.backgroundColor = [UIColor colorWithRed:188.0/255.0 green:233.0/255.0 blue:84.0/255.0 alpha:1.0];
    //    showLoyaltyView.layer.borderColor = [UIColor colorWithRed:5.0/255.0 green:77.0/255.0 blue:119.0/255.0 alpha:1.0].CGColor;
    //    showLoyaltyView.layer.borderWidth = 3.0f;
    //    showLoyaltyView.layer.cornerRadius = 15.0f;
    
    //    //Backgroud layer creation...
    //    NSString *filePath1 = [[NSBundle mainBundle] pathForResource:@"showlayaltybackground" ofType:@"jpg"];
    //    UIImageView *img1 = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:filePath1]];
    //    img1.layer.cornerRadius = 15.0f;
    //    img1.layer.masksToBounds = YES;
    //
    //    // layer header view....
    //    UIView *view = [[UIView  alloc] init];
    //    view.backgroundColor = [UIColor colorWithRed:107.0/255.0 green:105.0/255.0 blue:104.0/255.0 alpha:1.0];
    //    view.layer.cornerRadius = 15.0f;
    //    view.layer.masksToBounds = YES;
    //
    //    // layer header image setting...
    //    NSString *filePath2 = [[NSBundle mainBundle] pathForResource:@"showlpyabackgd" ofType:@"png"];
    //    UIImageView *img2 = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:filePath2]];
    //    img2.layer.masksToBounds = YES;
    //    img2.layer.cornerRadius = 15.0f;
    
    // Scanner Button for barcode scannig ..
    
    self.view.backgroundColor =  [UIColor blackColor];
    
    //    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.view.frame];
    //    backImage.image = [UIImage imageNamed:@"omni_home_bg.png"];
    //    [self.view addSubview:backImage];
    
    barcodeBtn  = [[UIButton alloc] init] ;
    [barcodeBtn setImage:[UIImage imageNamed:@"scan_icon.png"] forState:UIControlStateNormal];
    [barcodeBtn addTarget:self action:@selector(barcodeScanner:) forControlEvents:UIControlEventTouchUpInside];
    barcodeBtn.tag = 1;
    barcodeBtn.enabled = YES;
    
    loyaltyNumtxt = [[UITextField alloc] init];
    loyaltyNumtxt.borderStyle = UITextBorderStyleRoundedRect;
    loyaltyNumtxt.textColor = [UIColor colorWithRed:78.0/255.0 green:76.0/255.0 blue:76.0/255.0 alpha:1.0];
    loyaltyNumtxt.placeholder = @"Scan or enter loyalty no";  //place holder
    loyaltyNumtxt.backgroundColor = [UIColor whiteColor];
    loyaltyNumtxt.autocorrectionType = UITextAutocorrectionTypeNo;
    loyaltyNumtxt.backgroundColor = [UIColor whiteColor];
    loyaltyNumtxt.keyboardType = UIKeyboardTypeDefault;
    loyaltyNumtxt.returnKeyType = UIReturnKeyDone;
    loyaltyNumtxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    loyaltyNumtxt.delegate = self;
    
    label = [[UILabel alloc] init];
    label.font = [UIFont fontWithName:@"Arial-Italic" size:16];
    label.textColor = [UIColor redColor];
    label.text = @" Please Enter Loyalty Number";
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.font = [UIFont fontWithName:@"Arial-Italic" size:16];
    label1.textColor = [UIColor colorWithRed:0.0/255.0 green:158.0/255.0 blue:187.0/255.0 alpha:1.0];
    label1.text = @"Scan";
    
    submitBtn = [[UIButton alloc] init];
    [submitBtn addTarget:self
                  action:@selector(orderButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [submitBtn setTitle:@"Update" forState:UIControlStateNormal];
    submitBtn.layer.cornerRadius = 3.0f;
    submitBtn.backgroundColor = [UIColor grayColor];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    username = [[UILabel alloc] init];
    username.font = [UIFont boldSystemFontOfSize:16];
    username.textColor = [UIColor whiteColor];
    username.textAlignment = NSTextAlignmentLeft;
    username.backgroundColor = [UIColor clearColor];
    
    phNo = [[UILabel alloc] init];
    phNo.font = [UIFont boldSystemFontOfSize:16];
    phNo.textColor = [UIColor whiteColor];
    phNo.textAlignment = NSTextAlignmentLeft;
    phNo.backgroundColor = [UIColor clearColor];
    
    email = [[UILabel alloc] init];
    email.font = [UIFont boldSystemFontOfSize:16];
    email.textColor = [UIColor whiteColor];
    email.textAlignment = NSTextAlignmentLeft;
    email.backgroundColor = [UIColor clearColor];
    
    idType = [[UILabel alloc] init];
    idType.font = [UIFont boldSystemFontOfSize:16];
    idType.textColor = [UIColor whiteColor];
    idType.textAlignment = NSTextAlignmentLeft;
    idType.backgroundColor = [UIColor clearColor];
    
    validFrom = [[UILabel alloc] init];
    validFrom.font = [UIFont boldSystemFontOfSize:16];
    validFrom.textColor = [UIColor whiteColor];
    validFrom.textAlignment = NSTextAlignmentLeft;
    validFrom.backgroundColor = [UIColor clearColor];
    
    validThru = [[UILabel alloc] init];
    validThru.font = [UIFont boldSystemFontOfSize:16];
    validThru.textColor = [UIColor whiteColor];
    validThru.textAlignment = NSTextAlignmentLeft;
    validThru.backgroundColor = [UIColor clearColor];
    
    availPoints = [[UILabel alloc] init];
    availPoints.font = [UIFont boldSystemFontOfSize:16];
    availPoints.textColor = [UIColor whiteColor];
    availPoints.textAlignment = NSTextAlignmentLeft;
    availPoints.backgroundColor = [UIColor clearColor];
    
    amount = [[UILabel alloc] init];
    amount.font = [UIFont boldSystemFontOfSize:16];
    amount.textColor = [UIColor whiteColor];
    amount.textAlignment = NSTextAlignmentLeft;
    amount.backgroundColor = [UIColor clearColor];
    
    usernameData = [[UILabel alloc] init];
    usernameData.textColor = [UIColor whiteColor];
    usernameData.textAlignment = NSTextAlignmentLeft;
    usernameData.backgroundColor = [UIColor clearColor];
    
    phNoData = [[UILabel alloc] init];
    phNoData.textColor = [UIColor whiteColor];
    phNoData.textAlignment = NSTextAlignmentLeft;
    phNoData.backgroundColor = [UIColor clearColor];
    
    emailData = [[UILabel alloc] init];
    emailData.numberOfLines = 2;
    emailData.lineBreakMode = NSLineBreakByWordWrapping;
    emailData.textAlignment = NSTextAlignmentLeft;
    emailData.backgroundColor = [UIColor clearColor];
    emailData.textColor = [UIColor whiteColor];
    
    
    idNo = [[UILabel alloc] init];
    idNo.textColor = [UIColor whiteColor];
    idNo.textAlignment = NSTextAlignmentLeft;
    idNo.backgroundColor = [UIColor clearColor];
    
    validFromData = [[UILabel alloc] init];
    validFromData.textColor = [UIColor whiteColor];
    validFromData.textAlignment = NSTextAlignmentLeft;
    validFromData.backgroundColor = [UIColor clearColor];
    
    validThruData = [[UILabel alloc] init];
    validThruData.textColor = [UIColor whiteColor];
    validThruData.textAlignment = NSTextAlignmentLeft;
    validThruData.backgroundColor = [UIColor clearColor];
    
    pointsData = [[UILabel alloc] init];
    pointsData.textColor = [UIColor whiteColor];
    pointsData.textAlignment = NSTextAlignmentLeft;
    pointsData.backgroundColor = [UIColor clearColor];
    
    amountData = [[UILabel alloc] init];
    amountData.textColor = [UIColor whiteColor];
    amountData.textAlignment = NSTextAlignmentLeft;
    amountData.backgroundColor = [UIColor clearColor];
    
    
    blockedCharacters = [NSCharacterSet alphanumericCharacterSet].invertedSet;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        //        img.frame = CGRectMake(0, 0, 778, 50);
        //        label.frame = CGRectMake(5, 5, 220, 40);
        //        label.font = [UIFont boldSystemFontOfSize:25];
        //        backbutton.frame = CGRectMake(690.0, 5.0, 40.0, 40.0);
        showLoyaltyView.frame = CGRectMake(20, 60, 738, 900);
        // img1.frame = CGRectMake(0, 0, 738, 900);
        //view.frame = CGRectMake(0, 0, 738, 200);
        // img2.frame = CGRectMake(20, 30, 90, 70);
        
        loyaltyNumtxt.frame = CGRectMake(130, 100.0, 360, 50);
        loyaltyNumtxt.font = [UIFont systemFontOfSize:30.0];
        label1.frame = CGRectMake(530, 40, 80, 80);
        label1.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0];
        barcodeBtn.frame = CGRectMake(520, 90, 80, 80);
        label.frame = CGRectMake(180, 150, 250, 50);
        
        username.font = [UIFont boldSystemFontOfSize:30];
        username.frame = CGRectMake(120, 180, 250, 50);
        phNo.font = [UIFont boldSystemFontOfSize:30];
        phNo.frame = CGRectMake(120, 250, 250, 50);
        email.font = [UIFont boldSystemFontOfSize:30];
        email.frame = CGRectMake(120, 320, 250, 50);
        idType.font = [UIFont boldSystemFontOfSize:30];
        idType.frame = CGRectMake(120, 400, 250, 50);
        validFrom.font = [UIFont boldSystemFontOfSize:30];
        validFrom.frame = CGRectMake(120, 470, 250, 50);
        validThru.font = [UIFont boldSystemFontOfSize:30];
        validThru.frame = CGRectMake(120, 540, 250, 50);
        availPoints.font = [UIFont boldSystemFontOfSize:30];
        availPoints.frame = CGRectMake(120, 610, 250, 50);
        amount.font = [UIFont boldSystemFontOfSize:30];
        amount.frame = CGRectMake(120, 680, 250, 50);
        
        usernameData.font = [UIFont systemFontOfSize:30];
        usernameData.frame = CGRectMake(420, 180, 300, 50);
        phNoData.font = [UIFont systemFontOfSize:30];
        phNoData.frame = CGRectMake(420, 250, 300, 50);
        emailData.font = [UIFont systemFontOfSize:30];
        emailData.frame = CGRectMake(420, 320, 500, 50);
        idNo.font = [UIFont systemFontOfSize:30];
        idNo.frame = CGRectMake(420, 400, 300, 50);
        validFromData.font = [UIFont systemFontOfSize:30];
        validFromData.frame = CGRectMake(420, 470, 300, 50);
        validThruData.font = [UIFont systemFontOfSize:30];
        validThruData.frame = CGRectMake(420, 540, 300, 50);
        pointsData.font = [UIFont systemFontOfSize:30];
        pointsData.frame = CGRectMake(420, 610, 300, 50);
        amountData.font = [UIFont systemFontOfSize:30];
        amountData.frame = CGRectMake(420, 680, 300, 50);
        
        submitBtn.frame = CGRectMake(350.0f, 800,450.0f, 50.0f);
        
        
    }
    else {
        
        if (version1 >= 8.0) {
            showLoyaltyView.frame = CGRectMake(8, 39, 305, 400);
            // img1.frame = CGRectMake(0, 0, 305, 400);
            // view.frame = CGRectMake(0, 0, 305, 68);
            // img2.frame = CGRectMake(10, 5, 60, 55);
            
            loyaltyNumtxt.frame = CGRectMake(20, 80, 200, 30);
            loyaltyNumtxt.font = [UIFont systemFontOfSize:17.0];
            submitBtn.frame = CGRectMake(226.0f, 80,36.0f, 36.0f);
            barcodeBtn.frame = CGRectMake(268, 80, 40, 40);
            label.frame = CGRectMake(20, 120, 250, 30);
            label.backgroundColor = [UIColor clearColor];
            
            username.frame = CGRectMake(20, 140, 130, 30);
            phNo.frame = CGRectMake(20, 175, 130, 30);
            email.frame = CGRectMake(20, 210, 130, 30);
            idType.frame = CGRectMake(20, 245, 130, 30);
            validFrom.frame = CGRectMake(20, 280, 130, 30);
            validThru.frame = CGRectMake(20, 315, 130, 30);
            availPoints.frame = CGRectMake(20, 350, 130, 30);
            amount.frame = CGRectMake(20, 385, 130, 30);
            
            usernameData.frame = CGRectMake(140, 140, 130, 30);
            phNoData.frame = CGRectMake(140, 175, 130, 30);
            emailData.frame = CGRectMake(140, 210, 200, 30);
            idNo.frame = CGRectMake(140, 245, 130, 30);
            validFromData.frame = CGRectMake(140, 280, 130, 30);
            validThruData.frame = CGRectMake(140, 315, 130, 30);
            pointsData.frame = CGRectMake(140, 350, 130, 30);
            amountData.frame = CGRectMake(140, 385, 130, 30);
            
            
            usernameData.font = [UIFont systemFontOfSize:16];
            phNoData.font = [UIFont systemFontOfSize:16];
            emailData.font = [UIFont systemFontOfSize:16];
            idNo.font = [UIFont systemFontOfSize:16];
            validFromData.font = [UIFont systemFontOfSize:16];
            validThruData.font = [UIFont systemFontOfSize:16];
            pointsData.font = [UIFont systemFontOfSize:16];
            amountData.font = [UIFont systemFontOfSize:16];
            
        }
        else{
            showLoyaltyView.frame = CGRectMake(8, 39, 305, 400);
            // img1.frame = CGRectMake(0, 0, 305, 400);
            // view.frame = CGRectMake(0, 0, 305, 68);
            // img2.frame = CGRectMake(10, 5, 60, 55);
            
            loyaltyNumtxt.frame = CGRectMake(20, 10, 200, 30);
            loyaltyNumtxt.font = [UIFont systemFontOfSize:17.0];
            submitBtn.frame = CGRectMake(226.0f, 6.0f,36.0f, 36.0f);
            barcodeBtn.frame = CGRectMake(268, 4, 40, 40);
            label.frame = CGRectMake(20, 40, 250, 30);
            label.backgroundColor = [UIColor clearColor];
            
            username.frame = CGRectMake(20, 50, 130, 30);
            phNo.frame = CGRectMake(20, 85, 130, 30);
            email.frame = CGRectMake(20, 120, 130, 30);
            idType.frame = CGRectMake(20, 155, 130, 30);
            validFrom.frame = CGRectMake(20, 190, 130, 30);
            validThru.frame = CGRectMake(20, 225, 130, 30);
            availPoints.frame = CGRectMake(20, 260, 130, 30);
            amount.frame = CGRectMake(20, 295, 130, 30);
            
            usernameData.frame = CGRectMake(140, 50, 130, 30);
            phNoData.frame = CGRectMake(140, 85, 130, 30);
            emailData.frame = CGRectMake(140, 120, 200, 30);
            idNo.frame = CGRectMake(140, 155, 130, 30);
            validFromData.frame = CGRectMake(140, 190, 130, 30);
            validThruData.frame = CGRectMake(140, 225, 130, 30);
            pointsData.frame = CGRectMake(140, 260, 130, 30);
            amountData.frame = CGRectMake(140, 295, 130, 30);
            
            
            usernameData.font = [UIFont systemFontOfSize:16];
            phNoData.font = [UIFont systemFontOfSize:16];
            emailData.font = [UIFont systemFontOfSize:16];
            idNo.font = [UIFont systemFontOfSize:16];
            validFromData.font = [UIFont systemFontOfSize:16];
            validThruData.font = [UIFont systemFontOfSize:16];
            pointsData.font = [UIFont systemFontOfSize:16];
            amountData.font = [UIFont systemFontOfSize:16];
            
        }
    }
    
    //[topbar addSubview:img];
    //    [self.view addSubview:img];
    //    [self.view addSubview:label];
    //    [self.view addSubview:backbutton];
    //    [showLoyaltyView addSubview:img1];
    //    [showLoyaltyView addSubview:view];
    //    [showLoyaltyView addSubview:img2];
    //    [self.view addSubview:submitBtn];
    [self.view addSubview:barcodeBtn];
    [self.view addSubview:loyaltyNumtxt];
    [self.view addSubview:label];
    [self.view addSubview:username];
    [self.view addSubview:phNo];
    [self.view addSubview:email];
    [self.view addSubview:idType];
    [self.view addSubview:validFrom];
    [self.view addSubview:validThru];
    [self.view addSubview:availPoints];
    [self.view addSubview:amount];
    [self.view addSubview:usernameData];
    [self.view addSubview:phNoData];
    [self.view addSubview:emailData];
    [self.view addSubview:idNo];
    [self.view addSubview:validFromData];
    [self.view addSubview:validThruData];
    [self.view addSubview:pointsData];
    [self.view addSubview:amountData];
    [self.view addSubview:showLoyaltyView];
    [self.view addSubview:label1];
    
    
    //ProgressBar creation...
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    // Show the HUD
    [HUD show:YES];
    [HUD setHidden:YES];
    
}

/**
 * @description  it is one of ViewLifeCylce Method which will be executed at end to view unloaded....
 * @date
 * @method       viewDidAppear
 * @author
 * @param
 * @param
 *
 * @return
 *
 * @modified By Srinivasulu on 16/12/2017....
 * @reason      added the comments and     .... not completed....
 *
 * @verified By
 * @verified On
 *
 */

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma -mark end of ViewLifeCylce Methods....

/**
 * @description  it will be executed when memory warning is receiveds.......
 * @date
 * @method       didReceiveMemoryWarning
 * @author
 * @param
 * @param
 *
 * @return
 *
 * @modified By Srinivasulu on 16/12/2017....
 * @reason      added the comments....
 *
 * @verified By
 * @verified On
 *
 */

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
- (void) goHomePage {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
   // [self.navigationController popViewControllerAnimated:YES];
    [UIView  transitionWithView:self.navigationController.view duration:0.8  options:UIViewAnimationOptionTransitionFlipFromRight
                     animations:^(void) {
                         BOOL oldState = [UIView areAnimationsEnabled];
                         [UIView setAnimationsEnabled:NO];
                         [self.navigationController popViewControllerAnimated:YES];
                         [UIView setAnimationsEnabled:oldState];
                     }
                     completion:nil];
}

#pragma -mark start of textFields delegates...

/**
 * @description  it is an textFieldDelegate method it will be executed when text  Begin edititng........
 * @date         16/12/2017....
 * @method       textFieldShouldBeginEditing:
 * @author       Srinivasulu
 * @param        UITextField
 * @param
 * @param
 *
 * @return       BOOL
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    return YES;
}

/**
 * @description  it is an textFieldDelegate method it will be executed when text Begin edititng........
 * @date         16/12/2017....
 * @method       textFieldDidBeginEditing:
 * @author       Srinivasulu
 * @param        UITextField
 * @param
 * @param
 *
 * @return
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    
}

/**
 * @description  it is an textFieldDelegate method it will be executed for ever character change........
 * @date
 * @method       textField:  shouldChangeCharactersInRange:  replacementString:
 * @author
 * @param        UITextField
 * @param        NSRange
 * @param        NSString
 *
 * @return       BOOL
 *
 * @modified By  Srinivasulu by on 16/12/2017...
 * @reason       added the comments and need to change more
 *
 * @verified By
 * @verified On
 *
 */

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)characters
{
    
    if ([textField.text isEqualToString:loyaltyNumtxt.text]) {
        
        if ([characters isEqualToString:@""]) {
            label.text = [NSString  stringWithFormat:@" %d characters left", ++count];
        }
        else {
            
        label.text = [NSString  stringWithFormat:@" %d characters left", --count];
            
        }
        if (count == 0 ) {
            
            label.hidden = YES;
        }
        else{
            
            label.hidden = NO;
        }
     
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:nil];
        return ([characters rangeOfCharacterFromSet:blockedCharacters].location == NSNotFound);
    } 
    else{
        
       return YES;  
    }
}

/**
 * @description  it is an textFieldDelegate method it will be executed for ever character change........
 * @date
 * @method       textFieldDidChange:
 * @author
 * @param        UITextField
 * @param
 * @param
 *
 * @return       void
 *
 * @modified By  Srinivasulu by on 16/12/2017...
 * @reason       added the comments and need to change more
 *
 * @verified By
 * @verified On
 *
 */

-(void)textChange:(NSNotification *)notification {
    
    UITextField *textfield = notification.object;
    
    
    if (textfield == loyaltyNumtxt) {
        
        if (loyaltyNumtxt.text.length == 16) {
            [loyaltyNumtxt resignFirstResponder];
            [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
//            [self submitButtonPressed:(UIButton *)submitBtn.tag];
            
            //changed by Srinivasulu on 19/09/2017....
            //reason is -- NSInteger cann't typeCast to UIButton....
            
            //    [self submitButtonPressed:(UIButton *)submitBtn.tag];
            [self submitButtonPressed:submitBtn];
            
            
            //upto here on 19/09/2017....
            
        }
    }
        
}

/**
 * @description  It is tableFieldDelegates Method. It will executed when textFieldEndEditing....
 * @date         16/12/2017
 * @method       textFieldDidEndEditing:
 * @author       Srinivasulu
 * @param        UITextField
 * @param
 *
 * @return       void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    
}

/**
 * @description  It is tableFieldDelegates Method. It will executed when user started entering input....
 * @date         16/12/2017....
 * @method       textFieldShouldBeginEditing:
 * @author       Srinivasulu
 * @param        UITextField
 * @param
 *
 * @return       BOOL
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [loyaltyNumtxt resignFirstResponder];
    return YES;
}

#pragma -mark actions used in the page...

/**
 * @description  It will be executed the user cilcked the submitbutton....
 * @date         
 * @method       submitButtonPressed:
 * @author       Srinivasulu
 * @param        id
 * @param
 *
 *
 * @return      void
 *
 * @modified By Srinivasulu on 16/12/2017....
 * @reason      added the comments and     .... not completed....
 *
 * @verified By
 * @verified On
 *
 */


// Commented by roja on 17/10/2019.. // reason : submitButtonPressed method contains SOAP Service call .. so taken new method with same name(submitButtonPressed) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//- (void) submitButtonPressed:(id) sender {
//
//    //Play Audio for button touch....
//    AudioServicesPlaySystemSound (soundFileObject);
//
//    NSString *value = [loyaltyNumtxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//
//    if (value.length == 0){
//
//        username.text = @"";
//        phNo.text = @"";
//        email.text = @"";
//        validFrom.text = @"";
//        validThru.text = @"";
//        availPoints.text = @"";
//        amount.text = @"";
//
//        usernameData.text = @"";
//        phNoData.text = @"";
//        emailData.text = @"";
//        idType.text = @"";
//        idNo.text = @"";
//        validFromData.text = @"";
//        validThruData.text = @"";
//        pointsData.text = @"";
//        amountData.text = @"";
//
//        UIAlertView *validalert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Invalid Loyalty Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [validalert show];
//    }
//
//    else {
//
//        // Create the service
//        //        SDZLoyaltycardService* service = [SDZLoyaltycardService service];
//        //        service.logging = YES;
//        //
//        //        // showing HUD ..
//        //        [HUD setHidden:NO];
//        //
//        //        // Returns NSString*.
//        //        [service getissuedLoyaltycard:self action:@selector(getissuedLoyaltycardHandler:) loyaltyCardNumber: loyaltyNumtxt.text];
//
//        LoyaltycardServiceSoapBinding *skuService = [LoyaltycardServiceSvc LoyaltycardServiceSoapBinding];
//
//        LoyaltycardServiceSvc_getissuedLoyaltycard *getSkuid = [[LoyaltycardServiceSvc_getissuedLoyaltycard alloc] init];
//
//
//        NSArray *loyaltyKeys = @[@"loyaltyCardNumber", @"requestHeader"];
//
//        NSArray *loyaltyObjects = @[loyaltyNumtxt.text,[RequestHeader getRequestHeader]];
//        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
//
//        NSError * err_;
//        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
//        NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//
//        getSkuid.loyaltyCardNumber = loyaltyString;
//        @try {
//
//            LoyaltycardServiceSoapBindingResponse *response = [skuService getissuedLoyaltycardUsingParameters:(LoyaltycardServiceSvc_getissuedLoyaltycard *)getSkuid];
//            NSArray *responseBodyParts = response.bodyParts;
//            for (id bodyPart in responseBodyParts) {
//                if ([bodyPart isKindOfClass:[LoyaltycardServiceSvc_getissuedLoyaltycardResponse class]]) {
//                    LoyaltycardServiceSvc_getissuedLoyaltycardResponse *body = (LoyaltycardServiceSvc_getissuedLoyaltycardResponse *)bodyPart;
//                    printf("\nresponse=%s",(body.return_).UTF8String);
//                    if (body.return_ != nil) {
//                        [self getissuedLoyaltycardHandler:body.return_];
//                    }
//                    else {
//                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Invalid loyalty number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                        [alert show];
//                    }
//                }
//            }
//        }
//        @catch (NSException *exception) {
//
//            [HUD setHidden:YES];
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Problem occured while processing" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//        }
//
//
//    }
//}

//submitButtonPressed: method changed by roja on 17/10/2019.. // reason : removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST

- (void) submitButtonPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    NSString *value = [loyaltyNumtxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (value.length == 0){
        
        username.text = @"";
        phNo.text = @"";
        email.text = @"";
        validFrom.text = @"";
        validThru.text = @"";
        availPoints.text = @"";
        amount.text = @"";
        
        usernameData.text = @"";
        phNoData.text = @"";
        emailData.text = @"";
        idType.text = @"";
        idNo.text = @"";
        validFromData.text = @"";
        validThruData.text = @"";
        pointsData.text = @"";
        amountData.text = @"";
        
        UIAlertView *validalert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Invalid Loyalty Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [validalert show];
    }
    
    else {
        [HUD setHidden:NO];
        NSArray *loyaltyKeys = @[@"loyaltyCardNumber", @"requestHeader"];
        
        NSArray *loyaltyObjects = @[loyaltyNumtxt.text,[RequestHeader getRequestHeader]];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        WebServiceController * services  =  [[WebServiceController alloc] init];
        services.loyaltycardServicesDelegate = self;
        [services getLoyaltycardDetails:loyaltyString];
    }
}

// added by Roja on 17/10/2019….
- (void)getLoyaltycardDetailsSuccessReponse:(NSDictionary *)sucessDictionary{
    
    @try {
        [self getissuedLoyaltycardHandler:sucessDictionary];

    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}

// added by Roja on 17/10/2019….
- (void)getLoyaltycardDetailsErrorResponse:(NSString *)error{
    
    @try {
        
        username.text = @"";
        phNo.text = @"";
        email.text = @"";
        validFrom.text = @"";
        validThru.text = @"";
        availPoints.text = @"";
        amount.text = @"";
        
        usernameData.text = @"";
        phNoData.text = @"";
        emailData.text = @"";
        idType.text = @"";
        idNo.text = @"";
        validFromData.text = @"";
        validThruData.text = @"";
        pointsData.text = @"";
        amountData.text = @"";
        
        SystemSoundID    soundFileObject1;
        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
        self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
        AudioServicesPlaySystemSound (soundFileObject1);
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Invalid loyalty number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}




#pragma -mark alertview delegates

/**
 * @description  it wi....
 * @date
 * @method       alertView:--  clickedButtonAtIndex:--
 * @author
 * @param
 * @param
 * @param
 * @return       void
 *
 * @modified By  Srinivasulu on 16/12/2017....
 * @reason       added comments and exception handling and change the defaults as local varible  && some more change are done before itself....
 *
 * @verified By
 * @verified On
 *
 */

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
}

#pragma -mark methods used to navigate to other viewController....

/**
 * @description  in this method we are navigating to homepage....
 * @date
 * @method       homeButonClicked:
 * @author
 * @param
 * @param
 * @param
 * @return       void
 *
 * @modified By  Srinivasulu on 16/12/2017....
 * @reason       added comments and exception handling ....
 *
 * @verified By
 * @verified On
 *
 */

-(void)homeButonClicked {
    
    @try {
     
        OmniHomePage *home = [[OmniHomePage alloc]init];
        [self.navigationController pushViewController:home animated:YES];
    } @catch (NSException *exception) {
        
    }
}

/**
 * @description  in this method we are navigating to homepage....
 * @date
 * @method       goToHome
 * @author
 * @param
 * @param
 * @param
 * @return       void
 *
 * @modified By  Srinivasulu on 16/12/2017....
 * @reason       added comments and exception handling ....
 *
 * @verified By
 * @verified On
 *
 */

- (void)goToHome {
    
    @try {
        
        [self.navigationController popViewControllerAnimated:YES];
    } @catch (NSException *exception) {
        
    }
}

#pragma -mark below methods which are not is use. written by srinivasulu on 16/12/2017....



// Handle the response from getissuedLoyaltycard.

//- (void) getissuedLoyaltycardHandler: (NSString *) value {
//
//    [HUD setHidden:YES];
//
//    label.text = @"";
//
//    // Handle errors
//    if([value isKindOfClass:[NSError class]]) {
//        NSLog(@"%@", value);
//        return;
//    }
//
//    // Handle faults
//    //    if([value isKindOfClass:[SoapFault class]]) {
//    //        NSLog(@"%@", value);
//    //
//    //        UIAlertView *validalert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Invalid Loyalty Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    //        [validalert show];
//    //        [validalert release];
//    //        return;
//    //    }
//
//    // hiding the HUD ..
//    [HUD setHidden:YES];
//
//    // Do something with the NSString* result
//    NSString* result = (NSString*)value;
//    //NSLog(@"getissuedLoyaltycard returned the value: %@", result);
//    NSError *e;
//    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [result dataUsingEncoding:NSUTF8StringEncoding]
//                                                         options: NSJSONReadingMutableContainers
//                                                           error: &e];
//    [self.view resignFirstResponder];
//    if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue] == 0 && [[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE] isEqualToString:@"Success"]) {
//
//        // NSArray *temp = [result componentsSeparatedByString:@"#"];
//
//        //loyaltyNumtxt.text = nil;
//
//        username.text = @"Customer Name";
//        phNo.text = @"Mobile Number";
//        email.text = @"Email";
//        validFrom.text = @"Valid From";
//        validThru.text = @"Valid To";
//        availPoints.text = @"Avail Points";
//        amount.text = @"Amount";
//        //idType.text = @"Id Card";
//
//        SystemSoundID    soundFileObject1;
//        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
//    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
//        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
//        AudioServicesPlaySystemSound (soundFileObject1);
//
//        NSDictionary *loyaltyDic = [JSON valueForKey:@"customerLoyaltyCards"];
//
//        usernameData.text = [NSString stringWithFormat:@"%@",loyaltyDic[@"customerName"]];
//        phNoData.text = [NSString stringWithFormat:@"%@",loyaltyDic[@"phoneNum"]];
//        emailData.text = [NSString stringWithFormat:@"%@",loyaltyDic[@"email"]];
//
//
//
//        if ([loyaltyDic[@"idCardType"] isKindOfClass:[NSNull class]] || loyaltyDic[@"idCardType"] == nil) {
//
//            idType.text = @"-";
//            idNo.text = @"-";
//        }
//        else {
//            idType.text = [NSString stringWithFormat:@"%@",loyaltyDic[@"idCardType"]];
//            idNo.text = [NSString stringWithFormat:@"%@",loyaltyDic[@"loyaltyProgramNumber"]];
//        }
//
//        //        if ([[temp objectAtIndex:7] isEqualToString:@"null"]) {
//        //            validFromData.text = @"-";
//        //        }
//        //        else{
//        validFromData.text = [NSString stringWithFormat:@"%@",[loyaltyDic[@"validFrom"] componentsSeparatedByString:@" "][0]];
//        //        }
//        //         if ([[temp objectAtIndex:6] isEqualToString:@"null"]) {
//        //
//        //             validThruData.text = @"-";
//        //        }
//        //        else{
//        validThruData.text = [NSString stringWithFormat:@"%@",[loyaltyDic[@"validTo"] componentsSeparatedByString:@" "][0]];
//        //        }
//        if ([loyaltyDic[@"pointsRemaining"] isKindOfClass:[NSNull class]] || loyaltyDic[@"pointsRemaining"] == nil) {
//
//            pointsData.text = @"0.0";
//
//        }
//        else {
//            pointsData.text = [NSString stringWithFormat:@"%@",loyaltyDic[@"pointsRemaining"]];
//
//        }
//        if ([loyaltyDic[@"cash"] isKindOfClass:[NSNull class]] || loyaltyDic[@"cash"] == nil) {
//
//            amountData.text = @"0.00";
//
//        }
//        else {
//            amountData.text = [NSString stringWithFormat:@"%@",loyaltyDic[@"cash"]];
//
//        }
//
//    }
//    else{
//
//        username.text = @"";
//        phNo.text = @"";
//        email.text = @"";
//        validFrom.text = @"";
//        validThru.text = @"";
//        availPoints.text = @"";
//        amount.text = @"";
//
//        usernameData.text = @"";
//        phNoData.text = @"";
//        emailData.text = @"";
//        idType.text = @"";
//        idNo.text = @"";
//        validFromData.text = @"";
//        validThruData.text = @"";
//        pointsData.text = @"";
//        amountData.text = @"";
//
//        SystemSoundID    soundFileObject1;
//        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
//    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
//        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
//        AudioServicesPlaySystemSound (soundFileObject1);
//
//        UIAlertView *validalert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Invalid Loyalty Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [validalert show];
//    }
//
//}



//getissuedLoyaltycardHandler method changed by roja on 17/10/2019.. // reason : AFter converting SOAP to REST service call (in submitButton:), THE
// At the time of converting SOAP call's to REST

- (void) getissuedLoyaltycardHandler: (NSDictionary *) successResponse {

    label.text = @"";

    [HUD setHidden:YES];
    [self.view resignFirstResponder];
    
    if(successResponse != nil){
        
        username.text = @"Customer Name";
        phNo.text = @"Mobile Number";
        email.text = @"Email";
        validFrom.text = @"Valid From";
        validThru.text = @"Valid To";
        availPoints.text = @"Avail Points";
        amount.text = @"Amount";
        //idType.text = @"Id Card";
        
        SystemSoundID    soundFileObject1;
        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
        self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
        AudioServicesPlaySystemSound (soundFileObject1);
        
        NSDictionary *loyaltyDic = [successResponse valueForKey:@"customerLoyaltyCards"];
        
        usernameData.text = [NSString stringWithFormat:@"%@",loyaltyDic[@"customerName"]];
        phNoData.text = [NSString stringWithFormat:@"%@",loyaltyDic[@"phoneNum"]];
        emailData.text = [NSString stringWithFormat:@"%@",loyaltyDic[@"email"]];
        
        
        if ([loyaltyDic[@"idCardType"] isKindOfClass:[NSNull class]] || loyaltyDic[@"idCardType"] == nil) {
            
            idType.text = @"-";
            idNo.text = @"-";
        }
        else {
            idType.text = [NSString stringWithFormat:@"%@",loyaltyDic[@"idCardType"]];
            idNo.text = [NSString stringWithFormat:@"%@",loyaltyDic[@"loyaltyProgramNumber"]];
        }
        
        //        if ([[temp objectAtIndex:7] isEqualToString:@"null"]) {
        //            validFromData.text = @"-";
        //        }
        //        else{
        validFromData.text = [NSString stringWithFormat:@"%@",[loyaltyDic[@"validFrom"] componentsSeparatedByString:@" "][0]];
        //        }
        //         if ([[temp objectAtIndex:6] isEqualToString:@"null"]) {
        //
        //             validThruData.text = @"-";
        //        }
        //        else{
        validThruData.text = [NSString stringWithFormat:@"%@",[loyaltyDic[@"validTo"] componentsSeparatedByString:@" "][0]];
        //        }
        if ([loyaltyDic[@"pointsRemaining"] isKindOfClass:[NSNull class]] || loyaltyDic[@"pointsRemaining"] == nil) {
            
            pointsData.text = @"0.0";
        }
        else {
            pointsData.text = [NSString stringWithFormat:@"%@",loyaltyDic[@"pointsRemaining"]];
        }
        if ([loyaltyDic[@"cash"] isKindOfClass:[NSNull class]] || loyaltyDic[@"cash"] == nil) {
            
            amountData.text = @"0.00";
        }
        else {
            amountData.text = [NSString stringWithFormat:@"%@",loyaltyDic[@"cash"]];
        }
        
    }
    else{
        
        username.text = @"";
        phNo.text = @"";
        email.text = @"";
        validFrom.text = @"";
        validThru.text = @"";
        availPoints.text = @"";
        amount.text = @"";
        
        usernameData.text = @"";
        phNoData.text = @"";
        emailData.text = @"";
        idType.text = @"";
        idNo.text = @"";
        validFromData.text = @"";
        validThruData.text = @"";
        pointsData.text = @"";
        amountData.text = @"";
        
        SystemSoundID    soundFileObject1;
        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
        self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
        AudioServicesPlaySystemSound (soundFileObject1);
        
        UIAlertView *validalert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Invalid Loyalty Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [validalert show];
    }
    
}

// BarcodeScanner handler....
- (void) barcodeScanner:(id) sender {
    
    [loyaltyNumtxt resignFirstResponder];
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
//    // ADD: present a barcode reader that scans from the camera feed
//    ZBarReaderViewController *reader = [ZBarReaderViewController new];
//    reader.readerDelegate = self;
//    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
//    
//    ZBarImageScanner *scanner = reader.scanner;
//    reader.showsZBarControls = NO;
//    
//    [scanner setSymbology: ZBAR_I25
//                   config: ZBAR_CFG_ENABLE
//                       to: 0];
//    // present and release the controller
//    [self presentModalViewController: reader
//                            animated: YES];
//    reader.cameraOverlayView = [self CommomOverlay];
//    [reader release];

    
//    ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:YES];
//    
//    NSMutableSet *readers = [[NSMutableSet alloc ] init];
//    
//#if ZXQR
//    //QRCodeReader* qrcodeReader = [[QRCodeReader alloc] init];
//    //[readers addObject:qrcodeReader];
//    //[qrcodeReader release];
//    MultiFormatOneDReader *reader = [[MultiFormatOneDReader alloc] init];
//    [readers addObject:reader];
//    [reader release];
//#endif
//    
//    widController.readers = readers;
//    [readers release];
//    
//    NSBundle *mainBundle = [NSBundle mainBundle];
//    widController.soundToPlay =
//    [NSURL fileURLWithPath:[mainBundle pathForResource:@"beep-beep" ofType:@"aiff"] isDirectory:NO];
//    [self presentModalViewController:widController animated:YES];   // deprecated in ios 6.0
//    //[self presentViewController:widController animated:YES completion:nil];
//    [widController release];
    
//    ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self theFrame:[UIScreen mainScreen].bounds showCancel:YES OneDMode:YES];
//    
//    NSMutableSet *readers = [[NSMutableSet alloc ] init];
//    
//    MultiFormatOneDReader* reader = [[MultiFormatOneDReader alloc] init];
//    [readers addObject:reader];
//    [reader release];
//    
//    widController.readers = readers;
//    [readers release];
//    
//    //    NSBundle *mainBundle = [NSBundle mainBundle];
//    //    widController.soundToPlay =
//    //    [NSURL fileURLWithPath:[mainBundle pathForResource:@"beep-beep" ofType:@"aiff"] isDirectory:NO];
//    
//    [self presentModalViewController:widController animated:YES];
//    ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:YES];
//    NSMutableSet *readers = [[NSMutableSet alloc ] init];
//    
//    MultiFormatOneDReader *reader;
//#if ZXQR
//    //QRCodeReader* qrcodeReader = [[QRCodeReader alloc] init];
//    //[readers addObject:qrcodeReader];
//    //[qrcodeReader release];
//    reader = [[[MultiFormatOneDReader alloc] init] autorelease];
//    [readers addObject:reader];
//    //[reader release];
//#endif
//    
//    widController.readers = readers;
//    // [readers release];
//    
//    //    NSBundle *mainBundle = [NSBundle mainBundle];
//    //    widController.soundToPlay =
//    //    [NSURL fileURLWithPath:[mainBundle pathForResource:@"beep-beep" ofType:@"aiff"] isDirectory:NO];
//    //[self presentModalViewController:widController animated:YES];   // deprecated in ios 6.0
//    //    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:widController];
//    //    nc.navigationBar.tintColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
//    [self presentViewController:widController animated:YES completion:nil];
}


#pragma mark -
#pragma mark ScanDelegateMethods

//- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result {
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
//    [self dismissViewControllerAnimated:YES completion:nil];
//    if ([result length] > 0) {
//        
//        loyaltyNumtxt.text = result;
//
//        username.text = @"";
//        phNo.text = @"";
//        email.text = @"";
//        validFrom.text = @"";
//        validThru.text = @"";
//        availPoints.text = @"";
//        amount.text = @"";
//        
//        usernameData.text = @"";
//        phNoData.text = @"";
//        emailData.text = @"";
//        idType.text = @"";
//        idNo.text = @"";
//        validFromData.text = @"";
//        validThruData.text = @"";
//        pointsData.text = @"";
//        amountData.text = @"";
//        
//        HUD.labelText = @"Searching..";
//        [HUD setHidden:NO];
//        
////        SDZLoyaltycardService* service = [SDZLoyaltycardService service];
////        service.logging = YES;
////        // Returns NSString*.
////        [service getissuedLoyaltycard:self action:@selector(getissuedLoyaltycardHandler:) loyaltyCardNumber:result];
//        LoyaltycardServiceSoapBinding *skuService = [[LoyaltycardServiceSvc LoyaltycardServiceSoapBinding] retain];
//        
//        LoyaltycardServiceSvc_getissuedLoyaltycard *getSkuid = [[LoyaltycardServiceSvc_getissuedLoyaltycard alloc] init];
//        
//        NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
//        NSArray *str = [time componentsSeparatedByString:@" "];
//        NSString *date_ = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
//        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
//        
//        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
//        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
//        
//        
//        NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"loyaltyCardNumber", @"requestHeader", nil];
//        
//        NSArray *loyaltyObjects = [NSArray arrayWithObjects:loyaltyNumtxt.text,dictionary, nil];
//        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
//        
//        NSError * err_;
//        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
//        NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//        
//        getSkuid.loyaltyCardNumber = loyaltyString;
//        LoyaltycardServiceSoapBindingResponse *response = [skuService getissuedLoyaltycardUsingParameters:(LoyaltycardServiceSvc_getissuedLoyaltycard *)getSkuid];
//        NSArray *responseBodyParts = response.bodyParts;
//        for (id bodyPart in responseBodyParts) {
//            if ([bodyPart isKindOfClass:[LoyaltycardServiceSvc_getissuedLoyaltycardResponse class]]) {
//                LoyaltycardServiceSvc_getissuedLoyaltycardResponse *body = (LoyaltycardServiceSvc_getissuedLoyaltycardResponse *)bodyPart;
//                printf("\nresponse=%s",[body.return_ UTF8String]);
//                [self getissuedLoyaltycardHandler:body.return_];
//            }
//        }
//
//    }
//    
//}
//
//- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller {
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
//    [self dismissViewControllerAnimated:YES completion:nil];
//    
//}

//- (void) imagePickerController: (UIImagePickerController*) reader
// didFinishPickingMediaWithInfo: (NSDictionary*) info
//{
//    // ADD: get the decode results
//    id<NSFastEnumeration> results =
//    [info objectForKey: ZBarReaderControllerResults];
//    ZBarSymbol *symbol = nil;
//    for(symbol in results)
//        // EXAMPLE: just grab the first barcode
//        break;
//    
//    // EXAMPLE: do something useful with the barcode data
//    //resultText.text = symbol.data;
//    
//    // EXAMPLE: do something useful with the barcode image
//    //resultImage.image = [info objectForKey: UIImagePickerControllerOriginalImage];
//    
//    // ADD: dismiss the controller (NB dismiss from the *reader*!)
//    [reader dismissViewControllerAnimated:YES completion:nil];
//    
//    if ([symbol.data length] > 0) {
//        
//        loyaltyNumtxt.text = symbol.data;
//        
//        username.text = @"";
//        phNo.text = @"";
//        email.text = @"";
//        validFrom.text = @"";
//        validThru.text = @"";
//        availPoints.text = @"";
//        amount.text = @"";
//        
//        usernameData.text = @"";
//        phNoData.text = @"";
//        emailData.text = @"";
//        idType.text = @"";
//        idNo.text = @"";
//        validFromData.text = @"";
//        validThruData.text = @"";
//        pointsData.text = @"";
//        amountData.text = @"";
//        
//        HUD.labelText = @"Searching";
//        [HUD setHidden:NO];
//        
//        SDZLoyaltycardService* service = [SDZLoyaltycardService service];
//        service.logging = YES;
//        // Returns NSString*.
////        [service getLoyalcardDetails:self action:@selector(getissuedLoyaltycardHandler:) loyaltyCardNumber: symbol.data];
//        [service getissuedLoyaltycard:self action:@selector(getissuedLoyaltycardHandler:) loyaltyCardNumber:symbol.data];
//        
//    }
//
//}

-(UIView*)CommomOverlay{
    UIView* view = [[UIView alloc] init];
    UIImageView *FrameImg = [[UIImageView alloc] init];
    FrameImg.image = [UIImage imageNamed:@"technolabslogo.png"];
    
    UIButton *cancelButton  = [[UIButton alloc] init];
    [cancelButton setImage:[UIImage imageNamed:@"closebutton.png"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(closeBarcodeView) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *technolabsLabel = [[UIImageView alloc] init];
    technolabsLabel.image = [UIImage imageNamed:@"technolabslogo1.png"];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        view.frame = CGRectMake(0,0,760.0,1024);
        FrameImg.frame = CGRectMake(670.0,20.0,60.0,190.0);
        cancelButton.frame = CGRectMake(670.0, 900.0, 50.0, 50.0);
        technolabsLabel.frame = CGRectMake(-90.0, 20.0, 300.0, 300.0);
    }
    else{
        view.frame = CGRectMake(0,0,320,480);
        FrameImg.frame = CGRectMake(260.0,10.0,50.0,130.0);
        cancelButton.frame = CGRectMake(270.0, 415.0, 40.0, 40.0);
        technolabsLabel.frame = CGRectMake(-60.0, 10.0, 180.0, 200.0);
    }
    [view addSubview:FrameImg];
    [view addSubview:technolabsLabel];
    [view addSubview:cancelButton];
    return view;
}

-(void)closeBarcodeView{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
