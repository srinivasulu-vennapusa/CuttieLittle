//
//  XReportController.h
//  OmniRetailer
//
//  Created by MACPC on 9/28/15.
//
//

#import <UIKit/UIKit.h>
#import "SalesServiceSvc.h"
#import "CheckWifi.h"
#import "Global.h"
#import "MBProgressHUD.h"
#import "CustomNavigationController.h"
#import "WebServiceConstants.h"
#import "OmniHomePage.h"
#import "WebServiceController.h"

@interface ZReportController : CustomNavigationController<MBProgressHUDDelegate,UITextViewDelegate,UITextFieldDelegate,PowaTSeriesObserver,PowaScannerObserver,CustomerWalkOutDelegate,UITableViewDelegate,UITableViewDataSource, SalesServiceDelegate>
{
    MBProgressHUD *HUD;
    UIDeviceOrientation currentOrientation;
    UITextField *reportDateTxt;
    UIButton *selectDateBtn;
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    UIView *pickView;
    UIDatePicker *myPicker;
    NSString *dateString;
    UIButton *goButton;
    NSUserDefaults *defaults;
   
    
    UIAlertView * businessDateAlert;
    
    UIPopoverController *catPopOver;
    
    UITableView * shiftsTbl;
    NSMutableArray * shiftsArr;
    
    NSString *cardAmt;
    NSString *cashAmt;
    NSString *couponAmt;
    NSString *ticketAmt;
    NSDictionary *JSON ;
    NSMutableArray *denomArray;
    
}


@property (readwrite)    CFURLRef        soundFileURLRef;
@property (readonly)    SystemSoundID    soundFileObject;

@property(nonatomic,strong)NSString * totalCustomerWalkOuts;
@property(nonatomic,strong)NSString * walkOutReason;

//retain or strong attuibute must be of object type.......... ******
//@property(nonatomic,strong)Boolean callWalkinService; ---- week also....

//below two will work....
//@property(nonatomic,readwrite)BOOL callWalkinService;
@property (assign)BOOL callWalkinService;

//upto here on 16/10/2017....


@property (strong, nonatomic) IBOutlet UILabel * currenDateLbl;
@property (strong, nonatomic) IBOutlet UILabel * businessDateLbl;

@property (strong, nonatomic) IBOutlet UILabel * currenDateValueLbl;
@property (strong, nonatomic) IBOutlet UILabel * businessDateValueLbl;

@property (strong, nonatomic) IBOutlet UILabel * locationLbl;
@property (strong, nonatomic) IBOutlet UILabel * counterLbl;

@property (strong, nonatomic) IBOutlet UILabel * locationValueLbl;
@property (strong, nonatomic) IBOutlet UILabel * counterValueLbl;

@property (retain, nonatomic) IBOutlet UIView * shiftsView;
@property (retain, nonatomic) IBOutlet UILabel* shiftsLbl;
@property (retain, nonatomic) IBOutlet UIScrollView * shiftDisplayScrollView;

@property (strong, nonatomic) IBOutlet UITextField * dateTxt;

@property (retain, nonatomic) IBOutlet UIButton * showCalenderBtn;
- (IBAction)DateButtonPressed:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIButton * goButton;
- (IBAction)generateReport:(UIButton *)sender;

@property (retain, nonatomic) IBOutlet UIButton * printButton;
- (IBAction)printCompleteZReport:(id)sender;

@property (retain, nonatomic) IBOutlet UIButton * emailBtn;
- (IBAction)emailbtn:(UIButton *)sender;





@property (strong, nonatomic) IBOutlet UIScrollView *zReportsScrollView;

@property (strong, nonatomic) IBOutlet UIButton *validateReportBtn;

@property (retain, nonatomic) IBOutlet UITextView * instructionsTxtView;

@property (strong, nonatomic) IBOutlet UITextView * zReportTxtView;





//commented by Srinivasulu . V on 21/10/2017....
//reason this methods are not in use.. inorder to remove warnings....

//- (IBAction)validatePrint:(UIButton *)sender;
//- (IBAction)printXReport:(UIButton *)sender;

//upto here on 21/10/2017....

@end
