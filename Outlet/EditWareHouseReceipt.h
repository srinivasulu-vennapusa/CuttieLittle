//
//  EditWareHouseReceipt.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/17/15.
//
//

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"

@interface EditWareHouseReceipt : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
{
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    
    UITextField *BillField;
    UITableView *skListTable;
    UITableView* cartTable;
    UITableView *fromLocation;
    UIScrollView* scrollView;
    UITextField *recieptNumberTxt;
    UITextField *fromLocationTxt;
    UILabel *totalQunatity;
    UILabel *totalCost;
    UITextField *location;
    UITextField *receiptRefNo;
    UITextField *deliveredBy;
    UITextField *inspectedBy;
    UITextField *date;
    
    
    UIButton *dropDownButton;
    UIButton *submitBtn;
    UIButton *cancelButton;
    
    NSMutableArray *rawMaterials;
    NSMutableArray *rawMaterialDetails;
    NSMutableArray *fromLocationDetails;
    
    UITextField *qty1;
    
    UIView *qtyChangeDisplyView;
    UITextField *rejectedQty;
    UIView *rejectQtyChangeDisplayView;
    UITextField *qtyFeild;
    UITextField *rejecQtyField;
    UIButton *okButton;
    UIButton *qtyCancelButton;
    UISegmentedControl *segmentedControl;
    
    NSMutableArray *skuArrayList;
    
    UITextField *toLocation;
    UITableView *locationTable;
    NSMutableArray *locationArr;
    
    UIButton *selectLocation;
    UILabel *dataStatus;
    
    
    
}

-(id) initWithReceiptID:(NSString *)receiptID;

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;


@end
