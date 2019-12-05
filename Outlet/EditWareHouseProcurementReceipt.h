//
//  EditWareHouseProcurementReceipt.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/17/15.
//
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"

@interface EditWareHouseProcurementReceipt : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MBProgressHUDDelegate,UIPopoverControllerDelegate>
{
    MBProgressHUD *HUD;
    UIButton *popButton;
    UIBarButtonItem *sendButton;
    UITextField *receiptRefNoValue;
    UITextField *supplierIDValue;
    UITextField *supplierNameValue;
    UITextField *locationValue;
    UITextField *deliveredBYValue;
    UITextField *inspectedBYValue;
    UITextField *dateValue;
    UITextField *poRefValue;
    UITextField *shipmentValue;
    UIScrollView *scrollView;
    UITableView *cartTable;
    UIScrollView *createReceiptView;
    
    UILabel *totalQuantity;
    UILabel *totalCost;
    
    NSMutableArray *itemDetails;
    NSMutableArray *rawMaterials;
    NSMutableArray *skuArrayList;
    
    UITextField *searchItem;
    UITableView *skListTable;
    
    UIView *rejectQtyChangeDisplayView;
    UIView *qtyChangeDisplayView;
    UITextField *qtyField;
    
    UIButton *okButton;
    UIButton *qtyCancelButton;
    
    UITextField *rejectQtyField;
    
    UIButton *rejectOkButton;
    UIButton *rejectCancelButton;
    
    UIButton *submitBtn;
    UIButton *cancelButton;
}

-(id) initWithReceiptID:(NSString *)receiptID;
@property (strong, nonatomic) UIPopoverController* popOver;
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@end
