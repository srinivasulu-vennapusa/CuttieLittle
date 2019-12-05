//
//  OmniRetailer
//
//  Created by Chandrasekhar on 2/14/15.
//
//

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>
#import "CustomTextField.h"
#import "WebServiceController.h"

@interface EditStockIssue : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,SearchProductsDelegate,GetSKUDetailsDelegate, StockIssueDelegate, utilityMasterServiceDelegate>
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
    
    CustomTextField *location;
    CustomTextField *receiptRefNo;
    CustomTextField *deliveredBy;
    CustomTextField *inspectedBy;
    CustomTextField *date;
    CustomTextField *toLocation;
    
    
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
    NSMutableArray *tempSkuArrayList;

    
    UITableView *locationTable;
    NSMutableArray *locationArr;
    
    UIButton *selectLocation;
    
    MBProgressHUD *HUD_;
    UIAlertView *warning;
    
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
    
    UIButton *rejectOkButton;
    UIButton *rejectCancelButton;
    float version;
    
    BOOL isCancelBtnSelected; // added by roja on 17/10/2019...

}

-(id) initWithReceiptID:(NSString *)receiptID;

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@end
