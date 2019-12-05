//
//  WarehouseInvoicing.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/23/15.
//
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"

@interface WarehouseInvoicing : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MBProgressHUDDelegate,UISearchBarDelegate>
{
    UISegmentedControl *mainSegmentedControl;
    UIScrollView *shipmentView;
    MBProgressHUD *HUD;
    UITextField *shipmentId;
    UITextField *orderId;
    UITextField *shipmentNoteId;
    UITextField *customerName;
    UITextField *buildingNo;
    UITextField *streetName;
    UITextField *city;
    UITextField *country;
    UITextField *zip_code;
    UITextField *shipmentAgency;
    UITextField *totalItemCost;
    UITextField *shipmentCost;
    UILabel *tax;
    UITextField *insuranceCost;
    UITextField *paymentTerms;
    UITextField *remarks;
    UITextField *invoiceDate;
    
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
    NSMutableArray *shipmentIdList;
    UITableView *shipIdTable;
    
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
}
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;
@end
