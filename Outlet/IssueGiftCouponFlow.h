//
//  IssueGiftCouponFlow.h
//  OmniRetailer
//
//  Created by Technolabs on 6/13/19.
//

#import <UIKit/UIKit.h>
#import "CustomNavigationController.h"
#include <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"
#import "WebServiceUtility.h"
#import "WebServiceConstants.h"
#import "WebServiceController.h"
#import "PopOverViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface IssueGiftCouponFlow : CustomNavigationController<UITextFieldDelegate,UITableViewDelegate,MBProgressHUDDelegate,CustomerServiceDelegate,GiftCouponServicesDelegate, UITableViewDelegate, UITableViewDataSource>{
    
    
    NSMutableArray * giftCouponDetailsArr;

    CFURLRef        soundFileURLRef;
    SystemSoundID    soundFileObject;
    
    MBProgressHUD *HUD;
    
    UIPopoverController * couponProgramPopOver;
    UIPopoverController * couponCodePopOver;

    UITableView * giftCouponDetailsTable;
    int selectedCouponNoPosition;
    NSString * couponPromoCodeStr;
    
    NSMutableArray * giftCouponCodeDetailsArray;
    UITableView * giftCouponCodeDetailsTable;
    
    NSMutableArray *selectGiftCouponArr;

    UILabel * userAlertMessageLbl;
    NSTimer * fadeOutTime;
    

}

@property (strong, nonatomic) IBOutlet UIView *mainView;


@property (weak, nonatomic) IBOutlet UIScrollView *giftCouponScrollView;
@property (weak, nonatomic) IBOutlet UITableView *giftCouponTableView;

@property (weak, nonatomic) IBOutlet UITextField *mobileNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *customerIdTF;

@property (weak, nonatomic) IBOutlet UITextField *firstNameTF;

@property (weak, nonatomic) IBOutlet UITextField *lastNameTF;
@property (weak, nonatomic) IBOutlet UITextField *localityTF;
@property (weak, nonatomic) IBOutlet UITextField *customerCategoryTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextField *cityTF;

@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *couponProgramTF;

@property (weak, nonatomic) IBOutlet UITextField *couponValueTF;

@property (weak, nonatomic) IBOutlet UITextField *couponCodeTF;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;


@property (weak, nonatomic) IBOutlet UILabel *couponValueTableLbl;
@property (weak, nonatomic) IBOutlet UILabel *couponNumTableLbl;
@property (weak, nonatomic) IBOutlet UILabel *issueDateLbl;
@property (weak, nonatomic) IBOutlet UILabel *expryDateLbl;
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UILabel *actionLbl;

@property (weak, nonatomic) IBOutlet UILabel *snoLbl;

- (IBAction)addGiftCouponBtnAction:(id)sender;

- (IBAction)submitBtn:(id)sender;
- (IBAction)cancelBtn:(id)sender;

- (IBAction)couponProgramBtnAction:(id)sender;


@property (readwrite)    CFURLRef        soundFileURLRef;
@property (readonly)    SystemSoundID    soundFileObject;

@end

NS_ASSUME_NONNULL_END
