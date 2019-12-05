//
//  NewBooking.h
//  OmniRetailer
//
//  Created by Sonali on 12/5/15.
//
//

#import <UIKit/UIKit.h>
#import "CustomNavigationController.h"
#import "MBProgressHUD.h"
#import <AudioToolbox/AudioToolbox.h>
#import "WebServiceUtility.h"
#import "WebServiceController.h"
#import "CheckWifi.h"
#import "RequestHeader.h"
#import "PopOverViewController.h"
//#import "OrderService.h"
#import "OmniHomePage.h"
//#import "RestBookingServices.h"
#import "OfflineBillingServices.h"

@interface NewRestBooking : CustomNavigationController <MBProgressHUDDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,CustomerServiceDelegate,UIAlertViewDelegate,BookingRestServiceDelegate,UITextViewDelegate>
{
    NSMutableArray *slotIdsArr;
    NSMutableArray *modeOfResrvArr;
    MBProgressHUD *HUD;
    
   
    UIPopoverPresentationController *presentationPopOverController;
    
    UIView *pickView;
    UIDatePicker *myPicker;
    UITableView *reservationModeTbl;
    UITableView *slotIdsTbl;
    UITableView *occasionsTbl;
    NSMutableArray *listOfOccasions;
    NSString *custCategory;
    UIAlertView *success;
    UIAlertView *warning;
    UILabel *customerDetails;
    UIDeviceOrientation currentOrientation;
    NSDictionary *customerInfoDic;
    BOOL isVeg;
    CGRect *actualFrame;
    NSDictionary *occasionsDic;
    UIButton *customerInfoEnable;
    NSString *gender;
    NSArray *genderArr;
    UITableView *genderTbl;
    NSString *reservationDateStr;
    UILabel * userAlertMessageLbl;
    NSTimer * fadeOutTime;
    
    BOOL isDirectTableBooking; 
    BOOL isDetailsNotSharing;
}

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property (retain, nonatomic) IBOutlet UIView *registrationView;

@property (retain, nonatomic) IBOutlet UITextField *mobileNo;

@property (retain, nonatomic) IBOutlet UITextField *slotId;

@property (retain, nonatomic) IBOutlet UIButton *slotIdSelectionBtn;
- (IBAction)selectSlot:(UIButton *)sender;

@property (retain, nonatomic) IBOutlet UITextField *reservationModeTxt;
@property (retain, nonatomic) IBOutlet UIButton *reservModeSelectionBtn;
- (IBAction)selectReservationMode:(UIButton *)sender;


@property (retain, nonatomic) IBOutlet UIButton *submitDetails;
@property (retain, nonatomic) IBOutlet UIButton *cancel;

@property (retain, nonatomic) IBOutlet UITextField *noOfCustTxt;

@property (retain, nonatomic) IBOutlet UITextField *reservationDate;

@property (retain, nonatomic) IBOutlet UITextField *reservationStatusTxt;
- (IBAction)textFieldDidChange:(UITextField *)sender;

@property (retain, nonatomic) IBOutlet UITextField *custName;

- (IBAction)selectDate:(UIButton *)sender;

@property (retain, nonatomic) IBOutlet UIButton *selectOccasion;
@property (retain, nonatomic) IBOutlet UITextField *occasionTxt;

- (IBAction)selectOccasionType:(UIButton *)sender;


- (IBAction)placeOrder:(UIButton *)sender;

- (IBAction)clearDetails:(UIButton *)sender;

@property (retain, nonatomic) IBOutlet UITextField *noOfAdultsTxt;

@property (retain, nonatomic) IBOutlet UITextField *noOfChildsTxt;
@property (retain, nonatomic) IBOutlet UITextField *specialInstrTxt;

@property (retain, nonatomic) IBOutlet UITextField *customerEmailTxt;

@property (retain, nonatomic) IBOutlet UIButton *isVegBtn;
- (IBAction)isVegetarian:(UIButton *)sender;

@property (retain, nonatomic) IBOutlet UITextView *specialInstructionsTxtView;

@property (retain, nonatomic) IBOutlet UIButton *drinkReqBtn;
- (IBAction)drinkRequired:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIButton *radioBtn1;
//- (IBAction)selectRadioBtn1:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIButton *radioBtn2;
@property (retain, nonatomic) IBOutlet UITextField *vehicleNo;
@property (retain, nonatomic) IBOutlet UITextField *genderTxt;

@property (retain, nonatomic) IBOutlet UIButton *selectGenderBtn;
- (IBAction)selectGender:(UIButton *)sender;

@property (retain, nonatomic) IBOutlet UITextField *vegCountTxt;
@property (retain, nonatomic) IBOutlet UITextField *nonvegCountTxt;
@property (retain, nonatomic) IBOutlet UITextField *alcoholCountTxt;
@property (retain, nonatomic) IBOutlet UITextField *nonAlcoholCountTxt;
@property (retain, nonatomic) IBOutlet UITextField *childrenVegCount;
@property (retain, nonatomic) IBOutlet UITextField *childrenNonVegCount;

@property (weak, nonatomic) IBOutlet UITextField *lastNameTxt;


- (IBAction)checkBoxBtn1Action:(UIButton *)sender;
- (IBAction)checkBoxBtn2Action:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *custNotSharingDetailsLbl;
@property (weak, nonatomic) IBOutlet UILabel *directTableBookingLbl;
@property (weak, nonatomic) IBOutlet UIButton *checkBoxButton1;

@property (weak, nonatomic) IBOutlet UIButton *checkBoxButton2;





@end
