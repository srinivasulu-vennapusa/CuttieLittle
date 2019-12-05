//
//  OmniRetailerViewController.h
//  OmniRetailer
//
//  Created by Satya Siva Saradhi on 9/20/12.
//  Copyright 2012 __techolabssoftware.com__. All rights reserved.
//

///Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS5.1.sdk/System/Library/PrivateFrameworks/BluetoothManager.framework

#import <UIKit/UIKit.h>

#import "MBProgressHUD.h"
//#import "SDZLoginService.h"
#import "LoginServiceSvc.h"
#include <AudioToolbox/AudioToolbox.h>
//#include "appSettingsSvc.h"
//#include "MemberServiceSvc.h"
#import "sqlite3.h"
#import "BluetoothManager.h"
#import "BluetoothDevice.h"
#import "BTListDevItem.h"

#import "WebServiceController.h"
//.. CAAnimationDelegate .... was -------------- added by Srinivasulu on 20/07/2017....

@interface OmniRetailerViewController : UIViewController <UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource, MBProgressHUDDelegate,UIActionSheetDelegate,UIAlertViewDelegate,UITextViewDelegate,CAAnimationDelegate,AppSettingServicesDelegate, MemberServiceDelegate,LoginServiceDelegate>  {
    
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    
    UIButton* regbut;
    UIButton* loginbut;
    UIButton *loginbut1;
    
    UIButton *backBut1;
    UIButton *registrationbtn;
    
    UITextField *userIDtxt;
    UITextField *otpTxt;
    UITextField *passwordtxt;
    UITextField *emailTxt;
    UITextField *confirmPasswordtxt;
    UITextField *emailIDtxt;
    UITextField *deviceIDtxt;
    UITextField *countrytxt;
    UITextField *firstNametxt;
    UITextField *lastNametxt;
    UITextView *businessInfo;
    
    NSString *deviceUDID;
    
    UIView *registrationView;
    UIView *loginView;
    UIView *otpView;
    UIView *resetPwdView;
    
    MBProgressHUD *HUD;
    UISegmentedControl *segmentedControl;
    
    UITableView *countrysTable;
    NSMutableArray *listOfCountries;
    
    UITextField *PswdTxt;
    UITextField *confPswdTxt;
  
    BluetoothManager *btManager;
    NSMutableArray *btDevItems;

    //added by Srinivasulu on 10/08/2017 && 06/10/2017 && 16/04/2018....
    
    float offSetViewTo;
    NSString * serverDateStr;
    UISwitch * changeModeSwitch;
    UIAlertView * changeToOfflineModeAlert;

    //upto here on 10/08/2017 && 06/10/2017 && 16/04/2018....

    
    UIAlertView * offlineMode;
    
    UILabel* lab1;
    UIImageView *imageview1;
    UILabel* lab2;
    UIImageView *imageview2;
    
    UIDeviceOrientation currentOrientation;
    UILabel *password ;
    UIButton *validateOtpbtn;
    UIButton *forgetPassword;
    UIButton *resendOtp ;
    UILabel *headerlabel;
    UIImageView *backgroundImageView;
    UIActionSheet *action;
    float height ;
    float version ;
    
    UIView * firtTimeInstallationOTPView;
    UIView * viewContollerTransperentView;
    UITextField * userEnteredOTPTxt;
    UILabel * userAlertMessageLbl;
    NSTimer * fadeOutTime;
}

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property (nonatomic, retain) IBOutlet UIButton* regbut;
@property (nonatomic, retain) IBOutlet UIButton* loginbut;


@property (nonatomic, retain) IBOutlet UITextField *userIDtxt;
@property (nonatomic, retain) IBOutlet UITextField *emailIDtxt;
@property (nonatomic, retain) IBOutlet UITextField *passwordtxt;
@property (nonatomic, retain) IBOutlet UITextField *confirmPasswordtxt;
@property (nonatomic, retain) IBOutlet UITextField *deviceIDtxt;
@property (nonatomic, retain) IBOutlet UITextField *countrytxt;
@property (nonatomic, retain) IBOutlet UITextField *firstNametxt;
@property (nonatomic, retain) IBOutlet UITextField *lastNametxt;


@property(nonatomic,retain)UISegmentedControl *segmentedControl;


@property (nonatomic, retain) IBOutlet UIView *registrationView;
@property (nonatomic, retain) IBOutlet UIView *loginView;

//-(OmniRetailerViewController *)initWithFrame:(CGRect)size;
- (IBAction)ButtonClicked:(id)sender;
- (void) registration;
- (void) logging;
- (BOOL) validateEmail: (NSString *) candidate;
- (void) keyboardHide;
- (IBAction)contrySelectionButtonPressed:(id)sender;
-(BOOL)checkDatabaseStatus;
-(void)initializePowaPeripherals;
@end
