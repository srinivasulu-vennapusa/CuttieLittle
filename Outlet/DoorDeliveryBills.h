//
//  DoorDeliveryBills.h
//  OmniRetailer
//
//  Created by MACPC on 9/1/15.
//
//

#import <UIKit/UIKit.h>
#import "CustomNavigationController.h"
#import "MBProgressHUD.h"
#include <AudioToolbox/AudioToolbox.h>
#import "WebServiceController.h"
#import "CustomTextField.h"


@interface DoorDeliveryBills : CustomNavigationController <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,UINavigationControllerDelegate,UISearchBarDelegate,GetBillsDelegate> {
    
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    
    UISearchBar *searchBar;
    UITableView *pendingBills;
    UISegmentedControl *mainSegmentedControl;
    
    UIView *doorDeliveryBillsView;
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
    
    //added by Srinivasulu on 06/08/2017....
    
    NSMutableArray * serialBillIdsArr;
    
    NSMutableArray * billAmountArr;
    NSMutableArray * syncStatusArr;
    
    //upto here on 06/08/2017....
    
    UITextField *pastBillField;
    UITextField * startDteField;
    UITextField *endDteField;
    UITextField * customerMoblFld;
    
    UIButton * submitBtn;
    
    UITableView *salesIdTable;
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
    
    UILabel * SnoLbl;
    UILabel *order_Id;
    UILabel *orderdOn;
    UILabel *cost;
    UILabel *counter;
    UILabel *billDoneBy;
    UILabel * statusLbl;
    
    
    
    UIDatePicker * myPicker;
    UIView *pickView;
    UIPopoverController *catPopOver;
    NSString * dateString;
    NSMutableArray * doorDeliveryBillsArr;
    int totalNumberOfRecords;
    
    
    //added by Srinivasulu on 08/06/2017....
    //this are used for dispalying warning message....
    UILabel *userAlertMessageLbl;
    NSTimer *fadOutTime;
    
    
    //added by Srinivasulu on 06/08/2017....

    UIScrollView * itemsScrollView;
    
    UILabel * billAmountLbl;
    UILabel * syncStatusLbl;
    
    //upto here on 06/08/2017....
    
    //added by Srinivasulu on 17/10/2017....
    
    UILabel * billDoneModeLbl;
    
    //upto here on 17/10/2017....
    
    //Added By Bhargav.v on 21/02/2018..
    
    CustomTextField * pagenationTxt;
    UITableView * pagenationTbl;
    NSMutableArray * pagenationArr;
    UIView * totalRecordsView;
    UILabel * totalRecordsValueLabel;

    
}
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;
@property(nonatomic,strong) NSString* orderType;



@end
