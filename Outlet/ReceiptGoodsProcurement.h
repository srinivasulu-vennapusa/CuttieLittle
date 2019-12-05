//
//  ReceiptGoodsProcurement.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 2/19/15.
//
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"
#import "CustomTextField.h"
#import "WebServiceController.h"
#import "CustomNavigationController.h"

@interface ReceiptGoodsProcurement : CustomNavigationController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MBProgressHUDDelegate,SearchProductsDelegate,GetSKUDetailsDelegate, StockReceiptServiceDelegate, PurchaseOrderSvcDelegate, SupplierServiceSvcDelegate>
{
    CustomTextField *supplierID;
    CustomTextField *supplierName;
    CustomTextField *location;
    CustomTextField *receiptRefNo;
    CustomTextField *deliveredBy;
    CustomTextField *inspectedBy;
    CustomTextField *date;
    CustomTextField *poReference;
    CustomTextField *shipmentNote;
    UITextField *receiptTotal;
    UILabel *totalQuantity;
    UILabel *totalCost;
    UITextField *searchItem;
    UISegmentedControl *mainSegmentedControl;
    UIButton *submitBtn;
    UIButton *cancelButton;
    UIScrollView *createReceiptView;
    UIScrollView *scrollView;
    UITableView *cartTable;
    UITableView *normalstockTable;
    UITableView *skListTable;
    UITableView *supplierTable;

    UITableView *receiptIDTable;
    MBProgressHUD *HUD;
    
    UITextField *ReceiptID;
    
    UIView *viewReceiptView;
    
    NSMutableArray *rawMaterials;
    NSMutableArray *rawMaterialDetails;
    NSMutableArray *skuArrayList;
    
    NSMutableArray *receiptIDS;
    
    UIView *rejectQtyChangeDisplayView;
    
    UITextField *qtyField;
    UITextField *rejectQtyField;
    
    UIButton *okButton;
    UIButton *qtyCancelButton;
    UIButton *rejectOkButton;
    UIButton *rejectCancelButton;
    
    UIView *qtyChangeDisplayView;
    
    NSMutableArray *procurementReceipts;
    NSMutableArray *procuremnetReceiptDetails;
    
    UILabel *dataStatus;
    UIAlertView *warning;
    NSMutableArray * tempSkuArrayList;
    NSMutableArray * supplierList;
    NSMutableArray * supplierCode;
    NSMutableArray *poRefArr;
    UITableView *poRefTable;
    
    NSInteger index;

    UITableView *priceTable;
    UIView *transparentView;
    UIView *priceView;
    
    UILabel *descLabl;
    UILabel *priceLbl;
    
    NSMutableArray *priceArr;
    NSMutableArray *descArr;
    UIButton *closeBtn;
    NSString *searchStringStock;
    
    NSMutableArray *priceDic;
    NSString *rawMateialsSkuid;

    //moved from .h to .m by srinivasulu on 02/08/2018.. due to errors..

    int startPoint;
    NSString *receipt;
    float version;
    NSDictionary *JSON;


}
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@end
