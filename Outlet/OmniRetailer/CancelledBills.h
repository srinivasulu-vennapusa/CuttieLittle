//
//  CancelledBills.h
//  OmniRetailer
//
//  Created by Sonali on 10/24/15.
//
//

#import <UIKit/UIKit.h>
#import "CustomNavigationController.h"
#import "WebServiceController.h"
#import "MBProgressHUD.h"
#import "OfflineBillingServices.h"
#import "Global.h"
#import "CellView_TakeAwayOrder.h"
#import "PastBilling.h"
#import "OmniHomePage.h"

@interface CancelledBills : CustomNavigationController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,UINavigationControllerDelegate,UISearchBarDelegate,GetBillsDelegate> {
    
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    
    
    MBProgressHUD *HUD;
    
    UIButton *previousOrders;
    UIButton *nextOrders;
    UIButton *firstOrders;
    UIButton *lastOrders;
    
    NSMutableArray *orderId;
    NSMutableArray *billDue;
    NSMutableArray *counterArr;
    NSMutableArray *billDone;
    NSMutableArray *order_date;
    
    //added by Srinivasulu on 10/07/2017....
    
    NSMutableArray * serialBillIdsArr;
    
    
    //added by Srinivasulu on 06/08/2017....
    
    NSMutableArray * billAmountArr;
    NSMutableArray * syncStatusArr;
    
    //upto here on 06/08/2017....
    
    //upto here on 10/07/2017....
    
    UITextField *pastBillField;
    UITextField * startDateField;
    UITextField * endDateField;
    UITextField * userMobileNoFld;
    UIButton * submitBtn;
    
    UITableView *salesIdTable;
    UITableView *cancelledBills;

    NSString *saleId;
    
    NSMutableArray *filteredSkuArrayList;
    NSMutableArray *salesIdArray;
    
    
    UIDeviceOrientation currentOrientation;
    float version;
    UILabel *orderStart;
    UILabel *orderEnd;
    UILabel *totalOrder;
    UILabel *label1;
    UILabel *label2;
    NSDictionary *JSON;
    
    UILabel * sNoLbl;
    UILabel * order_Id;
    UILabel * orderdOn;
    UILabel * cost;
    UILabel * counter;
    UILabel * billDoneBy;
    
    UIDatePicker * myPicker;
    UIView *pickView;
    UIPopoverController *catPopOver;
    NSString * dateString;
    
    
    //added by Srinivasulu on 08/06/2017....
    //this are used for dispalying warning message....
    UILabel *userAlertMessageLbl;
    NSTimer *fadOutTime;
    
    
    //added by Srinivasulu on 07/08/2017....
    
    UIScrollView * itemsScrollView;
    
    UILabel * billAmountLbl;
    UILabel * syncStatusLbl;
    
    //upto here on 07/08/2017....
    
    
    //added by Srinivasulu on 17/10/2017....
    
    UILabel * billDoneModeLbl;
    NSMutableArray * billDoneModeArr;

    //upto here on 17/10/2017....
    
    
    //Added By Bhargav.v on 21/02/2018..
    
    CustomTextField * pagenationTxt;
    UITableView * pagenationTbl;
    NSMutableArray * pagenationArr;
    
    int  totalNumberOfRecords;
   
    // Adding the UIView and totalRecordsValueLabel...
    UIView  * totalRecordsView;
    UILabel * totalRecordsValueLabel;

    
    
   //up to here....
    
}
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;
@property(nonatomic,strong) NSString* orderType;



@end
