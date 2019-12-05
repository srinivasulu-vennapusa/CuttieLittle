//
//  IssueLoyaltyCard.h
//  OmniRetailer
//
//  Created by Roja on 28/11/19.
//

#import "CustomNavigationController.h"
#include <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"
#import "WebServiceUtility.h"
#import "WebServiceConstants.h"
#import "WebServiceController.h"
#import "PopOverViewController.h"


#import "RequestHeader.h"
#import "Global.h"
#import "OmniHomePage.h"


NS_ASSUME_NONNULL_BEGIN

@interface IssueLoyaltyCard : CustomNavigationController<UITextFieldDelegate,MBProgressHUDDelegate,CustomerServiceDelegate, UITableViewDelegate, UITableViewDataSource, LoyaltycardServicesDelegate> {
    
    CFURLRef        soundFileURLRef;
    SystemSoundID    soundFileObject;
    MBProgressHUD *HUD;

    UITableView * loyaltyProgramDetailsTable;
    NSMutableArray * loyaltyProgramDetailsArr;

    int selectedLoyaltyNoPosition;
    NSString * loyaltyPromoCodeStr;
    
    NSMutableArray * loyaltyCodeDetailsArray;
    UITableView * loyaltyCodeDetailsTable;
    
    NSMutableArray *selectedLoyaltyCardsArr;

    UILabel * userAlertMessageLbl;
    NSTimer * fadeOutTime;
    
    UIPopoverController * loyaltyProgramPopOver;
    UIPopoverController * loyaltyCodePopOver;


    
}

@property (weak, nonatomic) IBOutlet UITextField *mobileNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *customerIdTF;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTF;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTF;
@property (weak, nonatomic) IBOutlet UITextField *localityTF;
@property (weak, nonatomic) IBOutlet UITextField *customerCategoryTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextField *cityTF;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *currentSchemeTF;
@property (weak, nonatomic) IBOutlet UITextField *basePointsTF;
@property (weak, nonatomic) IBOutlet UITextField *loyaltyCodeTF;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@property (weak, nonatomic) IBOutlet UILabel *snoLbl;
@property (weak, nonatomic) IBOutlet UILabel *basePointsLbl;

@property (weak, nonatomic) IBOutlet UILabel *loyaltyNumberLbl;
@property (weak, nonatomic) IBOutlet UILabel *issueDateLbl;
@property (weak, nonatomic) IBOutlet UILabel *expiryDateLbl;

@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UILabel *actionLbl;


- (IBAction)addLoyalty:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *loyaltyCardsTable;
- (IBAction)submitLoyalty:(id)sender;
- (IBAction)cancelLoyalty:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIView *mainView;


- (IBAction)loyaltyProgramBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *loyaltyProgBtn;



@property (readwrite)    CFURLRef        soundFileURLRef;
@property (readonly)    SystemSoundID    soundFileObject;

@end

NS_ASSUME_NONNULL_END
