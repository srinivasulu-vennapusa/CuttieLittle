//
//  WareHouseShipments.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/21/15.
//
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"

@interface WareHouseShipments : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MBProgressHUDDelegate,UISearchBarDelegate>
{
    UISegmentedControl *mainSegmentedControl;
    UIScrollView *shipmentView;
    MBProgressHUD *HUD;
    UITextField *shipmentId;
    UITextField *orderId;
    UITextField *shipmentNote;
    UITextField *gatePassRef;
    UITextField *shipmentDate;
    UITextField *shipmentMode;
    UITextField *shipmentAgency;
    UITextField *shipmentAgencyContact;
    UITextField *inspectedBy;
    UITextField *shippedBy;
    UITextField *rfidTagNo;
    UITextField *packagesDescription;
    UITextField *shipmentCost;
    UITextField *remarks;
    UITextField *shipmentStreet;
    UITextField *shipmentLocation;
    UITextField *shipmentCity;
    UITextField *searchItem;
    
    UIButton *searchBtton;
    NSString *seardhOrderItem;
    UIButton *shipoModeButton;
    
    NSMutableArray *serchOrderItemArray;
    NSMutableArray *ItemArray;
    NSMutableArray *skuIdArray;
    NSMutableArray *ItemDiscArray;
    NSMutableArray *totalQtyArray;
    NSMutableArray *priceArray;
    NSMutableArray *QtyArray;
    NSMutableArray *totalArray;
    UIButton *delButton;
    UIButton *qtyChange;
    UIView *qtyChangeDisplyView;
    NSMutableArray *shipmodeList;
    UITableView *shipModeTable;
    
    UITextField *qtyFeild;
    UIButton *okButton;
    UIButton *qtyCancelButton;
    NSInteger qtyOrderPosition;
    int totalAmount;

    UITableView *serchOrderItemTable;
    UITableView *orderItemsTable;
    
    UILabel *subTotalData;
    UILabel *taxData;
    UILabel *totAmountData;
    
    UIButton *orderButton;
    UIButton *cancelButton;
     UISearchBar *searchBar;
    BOOL searching;
    BOOL letUserSelectRow;
    // int count;
    UIButton *previousButton;
    UIButton *nextButton;
    UIButton *firstButton;
    UIButton *lastButton;
    NSMutableArray *itemIdArray;
    NSMutableArray *orderStatusArray;
    NSMutableArray *orderAmountArray;
    NSMutableArray *OrderedOnArray;
    NSMutableArray *copyListOfItems;
    UITableView* orderstockTable;
    
    UIAlertView *warning;
}
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@end
