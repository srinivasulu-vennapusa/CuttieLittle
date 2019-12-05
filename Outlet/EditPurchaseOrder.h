//
//  EditPurchaseOrder.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/10/15.
//
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#include <AudioToolbox/AudioToolbox.h>
#import "CustomTextField.h"
#import "WebServiceController.h"

@interface EditPurchaseOrder : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate,MBProgressHUDDelegate,UITextFieldDelegate,UINavigationControllerDelegate,UIPopoverControllerDelegate,SearchProductsDelegate,GetSKUDetailsDelegate,UITextViewDelegate, PurchaseOrderSvcDelegate>{
    
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    
    UITableView* orderstockTable;
    UISearchBar *searchBar;
    NSMutableArray *Items;
    NSMutableArray *copyListOfItems;
    NSString *searchString;
    
    BOOL searching;
    BOOL letUserSelectRow;
    
    NSMutableArray *itemIdArray;
    NSMutableArray *orderStatusArray;
    NSMutableArray *orderAmountArray;
    NSMutableArray *OrderedOnArray;
    
    MBProgressHUD *HUD;
    
    UIButton *previousButton;
    UIButton *nextButton;
    UIButton *firstButton;
    UIButton *lastButton;
    
    UITextField *receiptRefNoValue;
    UITextField *supplierIDValue;
    UITextField *supplierNameValue;
    UITextField *locationValue;
    UITextField *deliveredBYValue;
    UITextField *inspectedBYValue;
    UITextField *dateValue;
    UITextField *poRefValue;
    UITextField *shipmentValue;
    UITextField *statusValue;
    UIScrollView *scrollView;
    UITableView *cartTable;
    UIScrollView *createReceiptView;
    UILabel *totalQuantity;
    UILabel *totalCost;
    UILabel *status;
    UIButton *popButton;
    UIBarButtonItem *sendButton;
    UITextField *orderSubmittedByValue;
    UITextField *shippingTermsValue;
    UITextField *orderAppBy;
    UITextField *creditTermsValue;
    UITextField *shippmentCostValue;
    UITextField *payTermsValue;
    UITextView *remarksTextView;
    UIButton *orderButton;
    UIButton *cancelButton;
    UITextField *searchItem;
    NSString *seardhOrderItem;
    UIButton *searchBtton;
    
    NSMutableArray *serchOrderItemArray;
    NSMutableArray *skuIdArray;
    NSMutableArray *ItemArray;
    NSMutableArray *ItemDiscArray;
    NSMutableArray *totalQtyArray;
    NSMutableArray *priceArray;
    NSMutableArray *QtyArray;
    NSMutableArray *pluCodeArray;
    NSMutableArray *totalArray;
    
    UITableView *serchOrderItemTable;
    UITableView *orderItemsTable;
    UIScrollView *orderTableScrollView;
    UIButton*qtyChange;
    UIButton *delButton;
    UITextField *qtyFeild;
    UIView *qtyChangeDisplyView;
    float totalAmount;
    
    UILabel *subTotalData;
    UILabel *taxData;
    UILabel *totAmountData;
    NSInteger qtyOrderPosition;
    
    UIButton *okButton;
    UIButton *qtyCancelButton;
    UIButton *dueDateButton;
    UIButton *shipoModeButton;
    UIView *pickView;
    UIDatePicker *myPicker;
    NSMutableArray *shipmodeList;
    UITableView *shipModeTable;
    
    UIAlertView *warning;
    NSMutableArray *tempSkuArrayList;
    NSMutableArray *skuArrayList;
    
    float version;
    NSString *searchStringStock;
    NSString *rawMateialsSkuid;
    
    // added by roja on 17/10/2019.. // at the time of convering soap to rest...
    BOOL isCancelBtnSelected;
}
@property (strong, nonatomic) UIPopoverController* popOver;
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;
- (void) searchTableView;
-(id) initWithorderID:(NSString *)orderID;


@end
