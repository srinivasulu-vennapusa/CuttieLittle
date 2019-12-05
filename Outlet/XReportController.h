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

@interface XReportController : CustomNavigationController<MBProgressHUDDelegate,UITextViewDelegate,UITextFieldDelegate,PowaTSeriesObserver,PowaScannerObserver, SalesServiceDelegate>
{
    MBProgressHUD *HUD;
    UIDeviceOrientation currentOrientation;
    UIButton *printButton;
    UITextField *reportDateTxt;
    UIButton *selectDateBtn;
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    UIView *pickView;
    UIDatePicker *myPicker;
    NSString *dateString;
    UIButton *goButton;
    
    
    //removed from .m and added in .h
    NSString *cardAmt;
    NSString *cashAmt;
    NSString *couponAmt;
    NSString *ticketAmt;
    NSDictionary *JSON ;
    NSMutableArray *denomArray;
    }
@property (strong, nonatomic) IBOutlet UIScrollView *xReportsScrollView;
@property (strong, nonatomic) IBOutlet UITextView *xReportTxtView;
@property (strong, nonatomic) IBOutlet UIButton *validateReportBtn;
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

- (IBAction)validatePrint:(UIButton *)sender;

- (IBAction)printXReport:(UIButton *)sender;
-(id)initWithValues:(NSString *)cardTotal cashTotal:(NSString *)cashTotal coupon:(NSString *)coupon ticket:(NSString *)ticket denomArr:(NSMutableArray*)denomArr;

@property (nonatomic, strong) NSMutableArray     * declaredTenderDeatailsArr;



@end
