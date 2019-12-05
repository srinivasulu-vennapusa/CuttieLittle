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


#import "WebServiceUtility.h"
#import "WebServiceConstants.h"
#import "WebServiceController.h"
#import "RequestHeader.h"



@interface IssueGiftVoucher : CustomNavigationController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate,MFMessageComposeViewControllerDelegate,UINavigationControllerDelegate,GiftVoucherSrvcDelegate,CustomerServiceDelegate> {
    
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
    UITableView *giftVoucherDetailsTable;
    UITableView *selectGiftVoucherTable;
    
    NSMutableArray *loyalTypeList;
//    NSMutableArray *loyaltyPgm;
    // commented by roja on 06/03/2019..
//    UITableView *loyaltyTypeTable;
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
    UIButton *selectVoucherValueBtn;
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
    
    // added by roja on 06/03/19
    UITextField * customerIdTF;
    UITextField * firstNameTF;
    UITextField * lastNameTF;
    UITextField * localityTF;
    UITextField * customerCategoryTF;
    UITextField * customerAddressTF;
    UITextField * customerCityTF;
    
    UITextField * giftVoucherTF;
    UITextField * giftVoucherValueTF;
    UITextField * giftVoucherCodeTF;

    UILabel * issuedDateLbl;
    UILabel * statusLbl;
    UILabel * actionLbl;
    
    NSMutableArray * giftVoucherDetailsArr;
    NSMutableArray * giftVoucherCodeDetailsArray;
    UITableView * giftVoucherCodeDetailsTable;
    NSString * voucherPromoCodeStr;
    int selectedVoucherNoPosition;
    
    // Used To display the Alert messages
    UILabel * userAlertMessageLbl;
    NSTimer * fadeOutTime;
    
    // upto here added by roja on 06/03/19...


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
