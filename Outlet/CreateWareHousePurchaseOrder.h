//
//  CreateWareHousePurchaseOrder.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/17/15.
//
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#include <AudioToolbox/AudioToolbox.h>
#import "CustomTextField.h"

@interface CreateWareHousePurchaseOrder : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,UINavigationControllerDelegate,UISearchBarDelegate, UISearchDisplayDelegate,UIAlertViewDelegate> {
    
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    
    CustomTextField *customerCode;
    CustomTextField *customerName;
    CustomTextField *executiveName;
    UITextField *searchItem;
    CustomTextField *address;
    CustomTextField *phNo;
    CustomTextField *email;
    CustomTextField *dueDate;
    CustomTextField *orderDate;
    CustomTextField *time;
    CustomTextField *shipment_location;
    CustomTextField *shipment_city;
    CustomTextField *shipment_street;
    CustomTextField *billing_location;
    CustomTextField *billing_city;
    CustomTextField *billing_street;
    CustomTextField *customer_location;
    CustomTextField *customer_city;
    CustomTextField *customer_street;
    CustomTextField *orderChannel;
    CustomTextField *orderDeliveryType;
    CustomTextField *shipCharges;
    CustomTextField *paymentMode;
    CustomTextField *paymentType;
    CustomTextField *shipoMode;
    CustomTextField *shipmentID;
    CustomTextField *saleLocation;
    NSString *searchString;
    
    UIButton *searchBtton;
    UIScrollView *scrollView;
    UIView *barcodeView;
    NSMutableArray *copyListOfItems;
    UIButton *orderButton;
    UIButton *cancelButton;
    UIView *pickView;
    
    UITableView *orderChannelTable;
    UITableView *orderDeliveryTable;
    UITableView *paymentTypeTable;
    UITableView* orderstockTable;
    
    UITableView *paymentTable;
    NSMutableArray *listOfItems;
    
    UITableView *shipModeTable;
    NSMutableArray *shipmodeList;
    
    NSString *seardhOrderItem;
    NSMutableArray *serchOrderItemArray;
    //NSMutableArray *orderItemsArray;
    
    UITableView *serchOrderItemTable;
    UITableView *orderItemsTable;
    UIScrollView *orderTableScrollView;
    
    UILabel *subTotalData;
    UILabel *taxData;
    UILabel *totAmountData;
    UISearchBar *searchBar;
    
    
    NSMutableArray *skuIdArray;
    NSMutableArray *ItemArray;
    NSMutableArray *ItemDiscArray;
    NSMutableArray *totalQtyArray;
    NSMutableArray *priceArray;
    NSMutableArray *QtyArray;
    NSMutableArray *totalArray;
    UIButton *delButton;
    UIButton *qtyChange;
    UIView *qtyChangeDisplyView;
    
    UITextField *qtyFeild;
    UIButton *okButton;
    UIButton *qtyCancelButton;
    NSInteger qtyOrderPosition;
    int totalAmount;
    UISegmentedControl *mainSegmentedControl;
    
    MBProgressHUD *HUD;
    
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
    
    UIAlertView *warning;
    
    NSMutableArray *tempSkuArrayList;
    NSMutableArray *skuArrayList;
    
    UITableView *supplierTable;
    NSMutableArray * supplierList;
    NSMutableArray * supplierCode;
}
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;
@property(nonatomic,retain) UITextField *customerCode;
@property(nonatomic,retain)UITextField *customerName;
@property(nonatomic,retain)UITextField *phNo;


@end
