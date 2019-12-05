//
//  ViewOrders.h
//  OmniRetailer

//  Created by Chandrasekhar on 4/3/15.

// Modified By Bhargav.v on 22/03/2018

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#include <AudioToolbox/AudioToolbox.h>
#import "CellView_Order.h"
#import "CustomNavigationController.h"
#import "CustomTextField.h"
#import "CustomLabel.h"
#import "WebServiceUtility.h"
#import "WebServiceConstants.h"
#import "WebServiceController.h"
#import "RequestHeader.h"

@interface ViewOrders : CustomNavigationController <MBProgressHUDDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,OutletOrderServiceDelegate,ZoneMasterDelegate>  {
    
    // Object Declaration for HUD..(processing bar).......
    MBProgressHUD * HUD;
    
    //to get the device version.......
    float version;
    int orderStartIndex;
    int totalOrders;
    
    //used to store the device Orientation.......
    UIDeviceOrientation currentOrientation;
    
    //used to create completeView.....
    UIView * orderSummaryView;
    
    /*Creation of textField used in this page*/
    CustomTextField * outletIdText;
    CustomTextField * zoneIdText;
    CustomTextField * orderStartValueText;
    CustomTextField * orderEndValueText;
    CustomTextField * orderStatusText;
    CustomTextField * orderChannelText;
    CustomTextField * startDateText;
    CustomTextField * endDateText;
    CustomTextField * pagenationText;
    
  
    //search Button used to make the service call for filter puropse...
    UIButton    * searchButton;
    //To search the  Orders based on Order ID...
    UITextField * searchOrdersText;
    
    //Creating a UIScrollView For Future use if There is any Fields Added For the HeaderLabels.....
    UIScrollView * oredersHeaderScrollView;
    
    //Used on TopOfTable.......
    CustomLabel * snoLabel;
    CustomLabel * orderIDLabel;
    CustomLabel * orderDateLabel;
    CustomLabel * deliveryDateLabel;
    CustomLabel * paymentTypeLabel;
    CustomLabel * orderChannelLabel;
    CustomLabel * orderStatusLabel;
    CustomLabel * orderAmountLabel;
    CustomLabel * actionLabel;
    
    // Creation of orderSummaryTable....
    UITableView * orderListTable;
    UITableView * locationTable;
    UITableView * orderChannelTable;
    UITableView * pagenationTable;
    UITableView * orderStatusTable;
    
    //Creation of NSMutableArray....
    
    NSMutableArray * orderListArray;
    NSMutableArray * locationArray;
    NSMutableOrderedSet * orderedSet;
    NSMutableArray * orderChannelArray;
    NSMutableArray * pagenationArray;
    
    UILabel * userAlertMessageLbl;
    NSTimer * fadeOutTime;
    
    UIButton * openButton;
    
    UIButton * trackOrderBtn; // added by roja on 04/12/2019..

    
    //used for all popUp's....
    UIPopoverController *catPopOver;
    
    UIDatePicker * myPicker;
    UIView *pickView;
    NSString * dateString;
    
    // added by roja on 16/04/2019..
    CustomTextField * deliveryTypeText;
    CustomTextField * deliveryModelText;
    CustomTextField * startTimeText;
    CustomTextField * endTimeText;
    
    NSMutableArray * deliveryTypeArray;
    UITableView * deliveryTypeTable;
    UITableView * deliveryModelTable;
    
    NSMutableArray * deliveryModelArray;
    
    CustomLabel * timeSlotLbl;
    CustomLabel * payModeLbl;
    CustomLabel * deliveryTypeLbl;
    CustomLabel * deliveryModelLbl;

    //Upto here added by roja on 16/04/2019..

    
}

@property (readwrite)    CFURLRef        soundFileURLRef;
@property (readonly)    SystemSoundID    soundFileObject;

@end
