//
//  BookingWorkFlow.h
//  OmniRetailer
//
//  Created by MACPC on 12/4/15.
//
//

#import <UIKit/UIKit.h>
#import "CustomNavigationController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "WebServiceUtility.h"
#import "WebServiceController.h"
#import "MBProgressHUD.h"
#import "RequestHeader.h"
#import "OmniHomePage.h"
#import "BillingHome.h"
#import "Global.h"
#import "CheckWifi.h"
#import "ServiceOrders.h"
//commented by roja on 09/01/2019. Related to offile
//#import "RestBookingServices.h"

@interface BookingWorkFlow : CustomNavigationController <UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,BookingRestServiceDelegate,OutletServiceDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate,UITextViewDelegate,UIGestureRecognizerDelegate,UIAlertViewDelegate,StoreServiceDelegate>
{//GetMenuServiceDelegate // or // MenuServiceDelegate
    NSArray *statusArr;
    UIDeviceOrientation currentOrientation;
    MBProgressHUD *HUD;
    UIButton *status;
    float xposition_f;
    float yposition_f;
    float version;
    BOOL isVeg;
    BOOL isDrinkReq;
    NSMutableArray *itemDetailsArr;
    NSUserDefaults *defaults;

    UIButton *previousOrders_takeaway;
    UIButton *nextOrders_takeaway;
    UIButton *firstOrders_takeaway;
    UIButton *lastOrders_takeaway;
    UILabel *orderStart_takeaway;
    UILabel *orderEnd_takeaway;
    UILabel *totalOrder_takeaway;
    UILabel *label11;
    UILabel *label22;
    UIView *pastOrdersView;
    
    NSMutableArray *bookingDetails;
    UITextField *searchTxt;
    UICollectionView *collectionView;
    int noOfTables;
    NSMutableArray *tableDetails;
    UITextField *levelTxt;
    NSMutableArray *levelsArr;
    UIButton *selectLevels;
    UITableView *levelsTbl;
    UIPopoverController *popOver;
    
    NSMutableArray *tableStatusArr;
    int past_order_no;
    int tablePositionInt;
    UITapGestureRecognizer *singletap;
    UITextField *availableChairsTxt;
    UIView *tableLayout;
    UIButton *allotTblBtn;
    UIAlertView *confirm;
    UIScrollView  *workFlowScroll;
    NSMutableArray *selectedTablesArr;
    UIAlertView *success;
    NSDictionary *occasionsDic;
    NSString *workFlowStateStr;
    BOOL isTableAllocated;
    NSString *gender;
    // Commented by roja on 10/01/2019...
//    RestBookingServices *offlineService;
    UIAlertView *cancellationConfirmAlert;
    NSString *tableNo;
    BOOL isCancellation;
    UIAlertView *allotTableAlert;
    
    NSMutableDictionary * orderDetailsInfoDic;
    NSString * bookingTypeStr;

    // added by roja on 05/03/2019...
    UIView * levelsDisplayView;
    UITextField * totalSeatsValueTF;
    UITextField * bookedSeatsValueTF;
    UITextField * occupiedSeatsValueTF;
    
    UILabel * userAlertMessageLbl;
    NSTimer * fadeOutTime;
    //upto here  added by roja on 05/03/2019...

}
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;
@property (retain, nonatomic) IBOutlet UISegmentedControl *segment;

@property (retain, nonatomic) IBOutlet UITableView *statusTable;
@property (retain, nonatomic) IBOutlet UIScrollView *scollView;
@property (retain, nonatomic) IBOutlet UITextField *custNameTxt;

@property (retain, nonatomic) IBOutlet UITextField *phoneTxt;

@property (retain, nonatomic) IBOutlet UITextField *roomNoTxt;
@property (retain, nonatomic) IBOutlet UIButton *selectRoomBtn;

- (IBAction)generateBill:(UIButton *)sender;

- (IBAction)editBooking:(UIButton *)sender;

- (IBAction)printReceipt:(UIButton *)sender;
- (IBAction)cancelBooking:(id)sender;

@property (retain, nonatomic) IBOutlet UIButton *billBtn;
@property (retain, nonatomic) IBOutlet UIButton *editBookingBtn;
@property (retain, nonatomic) IBOutlet UIButton *printBtn;
@property (retain, nonatomic) IBOutlet UIButton *cancelBtn;

@property(retain,readwrite) NSString* orderRef;
@property BOOL isDirectTableBooking;





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

-(IBAction)selectDate:(UIButton *)sender;

@property (retain, nonatomic) IBOutlet UITextField *bookingIdTxt;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;

@property (retain, nonatomic) IBOutlet UISegmentedControl *segmentControl;
- (IBAction)segmentAction:(UISegmentedControl *)sender;
@property (retain, nonatomic) IBOutlet UILabel *bookingIdLbl;
@property (retain, nonatomic) IBOutlet UILabel *mobileNoLbl;
@property (retain, nonatomic) IBOutlet UILabel *customerNameLbl;
@property (retain, nonatomic) IBOutlet UILabel *customerEmailLbl;
@property (retain, nonatomic) IBOutlet UIButton *radioBtn1;
- (IBAction)selectRadioBtn1:(UIButton *)sender;
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
@property (weak, nonatomic) IBOutlet UITextField *lastNameTF;

@property (weak, nonatomic) IBOutlet UILabel *lastNameLbl;




@end
