//
//  ServiceOrders.h
//  OmniRetailer
//
//  Created by Sonali on 2/23/15.
//
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#include <AudioToolbox/AudioToolbox.h>
#import "CustomNavigationController.h"
#import "WebServiceController.h"
#import "RequestHeader.h"
#import "BookingWorkFlow.h"
#import "PopOverViewController.h"


@interface ServiceOrders :  CustomNavigationController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, MBProgressHUDDelegate, UINavigationControllerDelegate, UISearchBarDelegate, BookingRestServiceDelegate, UICollectionViewDataSource, UICollectionViewDelegate, OutletServiceDelegate, UIAlertViewDelegate, FBOrderServiceDelegate, StoreServiceDelegate,RolesServiceDelegate> {
    
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    
    UITextField *tableNo;
    UITextField *waiterName;
    UITextField *custPhone;
    UITextField *custEmail;
    
    UITableView *pendingOrdersTbl;
    UITableView *pastOrders;
    
    UISearchBar *searchBar1;
    UISearchBar *searchBar2;
    
    NSMutableArray *copyListOfItems;
    NSString *searchString;
    UISegmentedControl *mainSegmentedControl;
    
    UIView *pendingHeaderView;
    UIView *pastHeaderView;
    
    BOOL searching;
    BOOL letUserSelectRow;
    
    UIView *pendingOrdersView;
    UIView *pastOrdersView;
    
    
    MBProgressHUD *HUD;
    
    UIButton *previousOrders;
    UIButton *nextOrders;
    UIButton *firstOrders;
    UIButton *lastOrders;
    
    UIButton *previousOrders_takeaway;
    UIButton *nextOrders_takeaway;
    UIButton *firstOrders_takeaway;
    UIButton *lastOrders_takeaway;
    
    UILabel *orderStart_takeaway;
    UILabel *orderEnd_takeaway;
    UILabel *totalOrder_takeaway;
    UILabel *label11;
    UILabel *label22;

    
    NSMutableArray *orderId;
    NSMutableArray *waiterList;
    NSMutableArray *tableId;
    NSMutableArray *totalCost;
    NSMutableArray *order_date;
    NSMutableArray *pastorder_date;
    
    NSMutableArray *orderId_pastOrders;
    NSMutableArray *waiterList_pastOrders;
    NSMutableArray *tableId_pastOrders;
    NSMutableArray *totalCost_pastOrders;
    
    UIDeviceOrientation currentOrientation;
    
    NSMutableArray *bookingDetails;
    UITextField *searchTxt;
    NSMutableArray *statusArr;
    UICollectionView *collectionView;
    int noOfTables;
    NSMutableArray *tableDetails;
    UITextField *levelTxt;
    NSMutableArray *levelsArr;
    UIButton *selectLevels;
    UITableView *levelsTbl;
//    UIPopoverController *popOver;
    
    // added by roja on 22/01/2019.
    UIPopoverPresentationController * presentationPopOverController;

   
    NSMutableArray *tableStatusArr;
//    UITextField *startDate;
//    UIButton *selectStartDate;
    
    // changed by roja on 22/09/2019..
    UITextField * slotTextField;
    UIButton *selectSlotBtn;

    UITextField *endDate;
    UIButton* selectEndDate;
    UIButton *goButton;
    UITableView *salesIdTable;
    UIView *pickView;
    UIDatePicker *myPicker;
    NSString *dateString;
//    UIPopoverController *catPopOver;
    
    // added by roja on 22/01/2019.
    UIPopoverPresentationController * categoryPopOverController;

    UITableView *slotIdsTbl;
    NSMutableArray *slotIdsArr;
    UILabel *todayLbl;
    NSMutableArray *mobileNosArr;
    UITableView *mobilesTbl;
    int buttonTitleIndex;
    int messageStartIndex;
    int buttonIndex;
    int pageIndex;
    UIButton *popButton;
    UIAlertView *refreshAlert;
    NSTimer *dateTimer;
    BOOL isRefresh;
    int selectedCollectionCell;
    UICollectionViewCell *selectedCell;
    UIView *tableLayout;
    UIButton * newTableOrderBtn;

    
    float version;
    int pending_order_no;

    int past_order_no;
    UILabel *orderStart;
    UILabel *orderEnd;
    UILabel *totalOrder;
    UILabel *label1;
    UILabel *label2;
    
    
    NSDictionary *JSON;
    NSDictionary *JSON_pastOrders;
    
    NSInteger segmentIndex;
    
    // added by roja on 05/03/2019...
    UIView * levelsDisplayView;
    UITextField * totalSeatsValueTF;
    UITextField * bookedSeatsValueTF;
    UITextField * occupiedSeatsValueTF;
    UITextField * firstNameTF;
    UITextField * lastNameTF;
    UITextField * startDateTF;
    UITextField * endDateTF;
    UITextField * statusTF;
    UIButton * statusPopUpBtn;
    UITextField * bookingChannelTF;
    UIButton * bookingChannelPopUpBtn;
    UIButton * searchButton;
    UITextField * totalBookingsValueTF;
    UITextField * pagenationText;
    UITextField * searchOrdersText;
    int totalOrders;
    NSMutableArray * pagenationArray;
    int orderStartIndex;
    UITableView * pagenationTable;
    UILabel * userAlertMessageLbl;
    NSTimer * fadeOutTime;
    UIPopoverController *catPopOver;
    NSMutableArray * statusPopUpArr;
    UITableView * statusDropDownTbl;
    UITableView * bookingChannelDropDownTbl;
    NSMutableArray * bookingChannelPopUpArr;

    NSString * slotIdStr;
    NSString * statusStr;
    NSString * bookingChannelStr;


    //upto here  added by roja on 05/03/2019...
}

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;
@property(nonatomic,strong) NSString* orderType;
@property BOOL isDirectTableBooking;

@end
