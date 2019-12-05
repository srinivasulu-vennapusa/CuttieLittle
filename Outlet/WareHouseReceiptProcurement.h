//
//  WareHouseReceiptProcurement.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/17/15.
//
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"
#import "CustomTextField.h"

@interface WareHouseReceiptProcurement : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MBProgressHUDDelegate>
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
    UITableView *receiptIDTable;
    MBProgressHUD *HUD;
    
    UITextField *ReceiptID;
    
    UIView *viewReceiptView;
    
    NSMutableArray *rawMaterials;
    NSMutableArray *rawMaterialDetails;
    NSMutableArray *skuArrayList;
    NSMutableArray *tempSkuArrayList;
    
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
    
    UIAlertView *warning;
    NSMutableArray * supplierList;
    NSMutableArray * supplierCode;
    UITableView *supplierTable;
    
    UILabel *dataStatus;
}
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;


@end
