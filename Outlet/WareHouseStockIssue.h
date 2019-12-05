//
//  WareHouseStockIssue.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/17/15.
//
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"

@interface WareHouseStockIssue : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MBProgressHUDDelegate>
{
    UITextField *supplierID;
    UITextField *supplierName;
    UITextField *location;
    UITextField *fromLocation;
    UITextField *receiptRefNo;
    UITextField *deliveredBy;
    UITextField *inspectedBy;
    UITextField *date;
    UITextField *poReference;
    UITextField *shipmentNote;
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
    
    NSMutableArray *receiptsIdsArr;
    NSMutableArray *receiptDateArr;
    NSMutableArray *receiptStatusArr;
    NSMutableArray *receiptTotalArr;
    NSMutableArray *receiptDeliveredByArr;
    
    UIView *qtyChangeDisplayView;
    
    NSMutableArray *procurementReceipts;
    NSMutableArray *procuremnetReceiptDetails;
    
    UILabel *dataStatus;
    
    UIButton *selectLocation;
    NSMutableArray *locationArr;
    UITableView *locationTable;
}
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@end
