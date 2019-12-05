//
//  OmniRetailer
//
//  Created by Chandrasekhar on 2/24/15.
//
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "CustomTextField.h"
#import "WebServiceController.h"
#import "WebServiceConstants.h"
#import "MBProgressHUD.h"

@interface EditReceiptGoodsProcurement : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MBProgressHUDDelegate,UIPopoverControllerDelegate,UIActionSheetDelegate,GetSKUDetailsDelegate,SearchProductsDelegate, StockReceiptServiceDelegate>
{
    MBProgressHUD *HUD;
    UIButton *popButton;
    UIBarButtonItem *sendButton;
    UIActionSheet *action;
    CustomTextField *receiptRefNoValue;
    CustomTextField *supplierIDValue;
    CustomTextField *supplierNameValue;
    CustomTextField *locationValue;
    CustomTextField *deliveredBYValue;
    CustomTextField *inspectedBYValue;
    CustomTextField *dateValue;
    CustomTextField *poRefValue;
    CustomTextField *shipmentValue;
    UIScrollView *scrollView;
    UITableView *cartTable;
    UIScrollView *createReceiptView;
    
    UILabel *totalQuantity;
    UILabel *totalCost;
    
    NSMutableArray *itemDetails;
    NSMutableArray *rawMaterials;
    NSMutableArray *skuArrayList;
    NSMutableArray *tempSkuArrayList;

    
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
    
    float version;
// added by roja on 17/10/2019... // at the time of converting SOAP to REST call's...
    BOOL isCancelBtnSelected;
}

-(id) initWithReceiptID:(NSString *)receiptID;
@property (strong, nonatomic) UIPopoverController* popOver;
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@end
