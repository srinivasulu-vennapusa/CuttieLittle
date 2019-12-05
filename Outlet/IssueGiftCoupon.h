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

@interface IssueGiftCoupon : CustomNavigationController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate,MFMessageComposeViewControllerDelegate,UINavigationControllerDelegate, LoyaltycardServicesDelegate> {
    
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
    CustomTextField *phNotxt;
    CustomTextField *emiltxt;
    CustomTextField *idTypetxt;
    CustomTextField *idNotxt;
    CustomTextField *loyaltyTypetxt;
    
    NSMutableArray *idslist;
    UITableView *idlistTableView;
    UITableView *selectGiftVoucherTable;
    
    NSMutableArray *loyalTypeList;
    NSMutableArray *loyaltyPgm;
    UITableView *loyaltyTypeTable;
    NSMutableArray *selectGiftVoucherArr;
    
    NSString *randomNum;
    
    UIButton *submitBtn;
    UIButton *cancelButton;
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
    UIPopoverController *editPricePopOver;
    int numberOfVouchers;
    int selectCashValuePosition;
    UILabel *cashValueLbl;
    UILabel *noOfVouchersLbl;
    UILabel *snoLbl;
    UILabel *expiryDateLbl;
    UIButton *addGVButton;
    UIImageView *starRat;
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
