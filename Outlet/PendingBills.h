//
//  Pending Bills.h
//  OmniRetailer
//
//  Created by Sonali on 3/14/15.
//
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#include <AudioToolbox/AudioToolbox.h>
#import "CustomNavigationController.h"
#import "WebServiceController.h"
#import "CustomTextField.h"

@interface PendingBills : CustomNavigationController <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,UINavigationControllerDelegate,UISearchBarDelegate,GetBillsDelegate> {
    
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    
    UISearchBar *searchBar;
    UITableView *pendingBills;
    UISegmentedControl *mainSegmentedControl;
    
    UIDatePicker * myPicker;
    UIView *pickView;
    UIPopoverController *catPopOver;
    NSString * dateString;
    
    MBProgressHUD *HUD;
    
    UIButton *previousOrders;
    UIButton *nextOrders;
    UIButton *firstOrders;
    UIButton *lastOrders;
    
    NSMutableArray * orderId;
    NSMutableArray * billDue;
    NSMutableArray * counterArr;
    NSMutableArray * billDone;
    NSMutableArray * order_date;
    NSMutableArray * statusArr;
    
    //added by Srinivasulu on 06/08/2017....

    NSMutableArray * billAmountArr;
    NSMutableArray * syncStatusArr;
    
    //upto here on 06/08/2017....

    
    //added by Srinivasulu on 10/07/2017....
    
    NSMutableArray * serialBillIdsArr;
    
    //upto here on 10/07/2017....
    
    UITextField *pastBillField;
    UITextField * startDteField;
    UITextField * customerMoblFld;
    UITextField * endDteField;
    UITableView *salesIdTable;
    NSString *saleId;
    UIButton * submitBtn;
    
    NSMutableArray *filteredSkuArrayList;
    NSMutableArray *salesIdArray;
    
    
    UIDeviceOrientation currentOrientation;
    UILabel *counter;
    UILabel *billDoneBy;
    
    NSMutableArray *draftBillsArray;
    
    // added on 30/11/2016:
    NSMutableArray * pendingBillsArr;
    int  totalNumberOfRecords;
    int pending_bill_no;
    float version;
    
    
    
    //added by Srinivasulu on 08/06/2017....
    //this are used for dispalying warning message....
    UILabel *userAlertMessageLbl;
    NSTimer *fadOutTime;
    
    
    NSMutableArray * offlineBillsArr;
    
    //added by Srinivasulu on 06/08/2017....
    
    //commented by Srinivasulu on 06/08/2017....
    //reason this view not in use....

//    UIView * pendingHeaderView;

    
    UIScrollView * itemsScrollView;
    
    UILabel * billAmountLbl;
    UILabel * syncStatusLbl;
    
    //upto here on 06/08/2017....
    
    //added by Srinivasulu on 16/10/2017....
    
    UILabel * billDoneModeLbl;
    NSMutableArray * billDoneModeArr;

    //upto here on 16/10/2017....
    
    // Added by Bhargav.v on 20/02/2018....
    
    CustomTextField * pagenationTxt;
    NSMutableArray  * pagenationArr;
    UITableView     * pagenationTbl;
    
    UIView * totalRecordsView;
    UILabel * totalRecordsValueLabel;
    
    //moved from .h to .m by srinivasulu on 02/08/2018.. due to errors..

    UILabel * orderStart;
    UILabel * orderEnd;
    UILabel * totalOrder;
    UILabel * label1;
    UILabel * label2;
    NSDictionary * JSON;
    
    UILabel * snoLbl;
    UILabel * order_Id;
    UILabel * orderdOn;
    UILabel * statusLbl;
    UILabel * cost;
}
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;
@property(nonatomic,strong) NSString* orderType;


//added by Srinivasulu on 24/04/2017....

@property(nonatomic,strong) NSString * billStatusStr;
@property(nonatomic,strong) NSString * billIdStr;

//upto here on 24/04/201....


@end
