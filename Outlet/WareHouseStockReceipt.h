//
//  WareHouseStockReceipt.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/17/15.
//
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"

@interface WareHouseStockReceipt : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MBProgressHUDDelegate>
{
    UITextField *supplierID;
    UITextField *supplierName;
    UITextField *location;
    UITextField *receiptRefNo;
    UITextField *deliveredBy;
    UITextField *inspectedBy;
    UITextField *date;
    UITextField *toLocation;
    UITextField *shipmentNote;
    UITextField *receiptTotal;
    UILabel *totalQuantity;
    UILabel *totalCost;
    UITextField *searchItem;
    UISegmentedControl *mainSegmentedControl;
    UIButton *submitBtn;
    UIButton *cancelButton;
    UIView *createReceiptView;
    UIScrollView *scrollView;
    UITableView *cartTable;
    UITableView *normalstockTable;
    UITableView *skListTable;
    UITableView *receiptIDTable;
    MBProgressHUD *HUD;
    
    UITextField *ReceiptID;
    
    UIView *viewReceiptView;
    
    NSMutableArray *rawMaterials;
    NSMutableArray *rawMaterialDetails;
    NSMutableArray * skuArrayList;
    
    NSMutableArray *receiptIDS;
    
    UIView *rejectQtyChangeDisplayView;
    
    UITextField *qtyField;
    UITextField *rejectQtyField;
    
    UIButton *okButton;
    UIButton *qtyCancelButton;
    UIButton *rejectOkButton;
    UIButton *rejectCancelButton;
    
    UIView *qtyChangeDisplayView;
    
    NSMutableArray *receiptsIdsArr;
    NSMutableArray *receiptDateArr;
    NSMutableArray *receiptStatusArr;
    NSMutableArray *receiptTotalArr;
    NSMutableArray *receiptDeliveredByArr;
    
    NSMutableArray *receiptDetails;
    
    UILabel *dataStatus;
    UIButton *selectLocation;
    
    NSMutableArray *locationArr;
    UITableView *locationTable;
    
}
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@end
