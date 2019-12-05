//
//  IssueLowyalty.h
//  OmniRetailer
//
//  Created by Bangaru.Raju on 1/3/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKPSMTPMessage.h"
#import "MBProgressHUD.h"
#import <UIKit/UIKit.h>
#import "MIRadioButtonGroup.h"
#import <MessageUI/MessageUI.h>
#include <AudioToolbox/AudioToolbox.h>
#import "CustomTextField.h"
#import "CustomNavigationController.h"
#import "WebServiceController.h"

@interface IssueLowyalty : CustomNavigationController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate,MFMessageComposeViewControllerDelegate,UINavigationControllerDelegate, GetBillsDelegate, CustomerServiceDelegate, LoyaltycardServicesDelegate> {
    
    CFURLRef		soundFileURLRef;
	SystemSoundID	soundFileObject;
    
    UIScrollView*scrollView;
    UIView *issueLoyaltyView;
    
    UILabel *username;
    UILabel *phNo;
    UILabel *email;
    UILabel *idType;
    UILabel *idNo;
    UILabel *loyaltyType;
    
    CustomTextField *usernametxt;
    CustomTextField *dateOfBirthTxt;
    CustomTextField *streetNameTxt;
    CustomTextField *localityTxt;
    CustomTextField *cityTxt;
    CustomTextField *zipCodeTxt;
    CustomTextField *professiontxt;
    CustomTextField *qualificationtxt;
    CustomTextField *gendertxt;
    CustomTextField *phNotxt;
    CustomTextField *emiltxt;
    CustomTextField *idTypetxt;
    CustomTextField *idNotxt;
    CustomTextField *loyaltyTypetxt;
    
    NSMutableArray *idslist;
    UITableView *idlistTableView;
    UITableView *purchaseHistoryTable;
    UIDatePicker *myPicker;
    UIView *pickView;
    NSMutableArray *loyalTypeList;
    NSMutableArray *loyaltyPgm;
    UITableView *loyaltyTypeTable;
    UIPopoverController *catPopOver;
    NSString *randomNum;
    NSString *dateString;
    UIButton *submitBtn;
    UIButton *cancelButton;
    UIButton *viewPurchasesBtn;
    NSTimer *aTimer;
    UIView* mailView;
    UIImageView * bgimage;
    IBOutlet UILabel * loadingLabel;
    UIActivityIndicatorView * spinner;
    
    NSCharacterSet *blockedCharacters;
    
    UILabel *resultId;
    
    MBProgressHUD *HUD;
    UIView *baseView;
    UITextField *smsField;
    
    UIAlertView *warning;
    UIAlertView *uiAlert;
    UIButton *loyaltyTypelist;
    NSString *loyaltyProgram;
    float version;

    UIImageView *starRat;
    NSMutableArray *purchasesHistory;
    UIPopoverController *editPricePopOver;
}

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property(nonatomic, strong)NSTimer *aTimer;
@property(nonatomic, strong)IBOutlet UILabel * loadingLabel;
@property(nonatomic, strong)UIImageView * bgimage;
@property(nonatomic, strong)UIActivityIndicatorView * spinner;

-(void)removeWaitOverlay;
-(void)createWaitOverlay;
-(void)stopSpinner;
-(void)startSpinner;

@end
