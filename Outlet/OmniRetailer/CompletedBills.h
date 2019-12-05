//
//  CompletedBills.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 10/30/15.
//
//

#import <UIKit/UIKit.h>
#import "CustomNavigationController.h"
#import "MBProgressHUD.h"
#include <AudioToolbox/AudioToolbox.h>
#import "WebServiceController.h"

@interface CompletedBills : CustomNavigationController <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,UINavigationControllerDelegate,UISearchBarDelegate,GetBillsDelegate> {
    
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    
    UISearchBar *searchBar;
    UITableView *completedBillsTable;
    UISegmentedControl *mainSegmentedControl;
    
    UIView *pendingHeaderView;
    MBProgressHUD *HUD;
    
    UIButton *previousOrders;
    UIButton *nextOrders;
    UIButton *firstOrders;
    UIButton *lastOrders;
    
    NSMutableArray *bill_ids;
    NSMutableArray *sodexoTotalsArr;
    NSMutableArray *cashTotalArr;
    NSMutableArray *cardTotalArr;
    NSMutableArray *totalPriceArr;
    NSMutableArray *ticketTotalArr;
    
    UITextField *pastBillField;
    UITableView *salesIdTable;
    NSString *saleId;
    
    NSMutableArray *filteredSkuArrayList;
    NSMutableArray *salesIdArray;
    
    
    UIDeviceOrientation currentOrientation;
    UILabel *cashAmtLbl;
    UILabel *cardAmtLbl;
    UILabel *ticketAmtLbl;
    
    float version;
    UILabel *orderStart;
    UILabel *orderEnd;
    UILabel *totalOrder;
    UILabel *label1;
    UILabel *label2;
    NSDictionary *JSON;
    
    UILabel *order_Id;
    UILabel *totalAmtLbl;
    UILabel *sodexoAmtLbl;
    
    UIButton *billSummaryButton;
    UIPopoverController *billSummaryPopOver;

    UILabel *totalBillAmtValue;
    UILabel *totalCashAmtVal;
    UILabel *totalCardAmtVal;
    UILabel *totalSodexoAmtVal;
    UILabel *totalTickAmtVal;
    
    UITextField *ordersDate;
    UIButton *orderDateButton;
    UIButton *getBillsBtn;
    
    UIView *pickView;
    UIDatePicker *myPicker;

}
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;
@property(nonatomic,strong) NSString* orderType;



@end
