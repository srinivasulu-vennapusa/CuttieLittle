//
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
#import "UtilityMasterServiceSvc.h"
#import "StocksDetailsServiceSvc.h"
#import "PopOverViewController.h"
#import "OmniHomePage.h"

@interface GoodsReturn : CustomNavigationController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MBProgressHUDDelegate,SearchProductsDelegate,GetSKUDetailsDelegate,UITextViewDelegate,utilityMasterServiceDelegate,StockReceiptServiceDelegate,StockReturnServiceDelegate,StockIssueDelegate,OutletMasterDelegate,SkuServiceDelegate>
{
    
    
    MBProgressHUD *HUD;

    UIView  * goodsReturnView;
    UIDeviceOrientation  currentOrientation;
    
    UIView *pickView;
    UIDatePicker *myPicker;
    NSString *dateString;
    UIPopoverController *catPopOver;
    
    
    float version;

    
    CustomTextField *toLocation;
    CustomTextField *fromLocation;
    CustomTextField *dateOfReturn;
    CustomTextField *receiptRefNo;
    CustomTextField *timeOfReturn;
    CustomTextField *issueRefNo;
    CustomTextField *returnedBy;
    CustomTextField *shippedBy;
    CustomTextField *shipmentMode;
    CustomTextField *shipmentOn;
    CustomTextField *shipmentCarrier;
    CustomTextField *receiptRef;
    CustomTextField *remarksTxt;
    
    //changed by Srinivasulu on 19/09/2017....
    //reason it not supported in ARC....
    
    Boolean * status;
    
    
    UIScrollView * stockReturnScrollView;
    
    //upto here on 19/09/2017....
    
    CustomLabel * sNoLbl;
    CustomLabel * sKuidLbl;
    CustomLabel * descLbl;
    CustomLabel * eanLbl;
    CustomLabel * uomLbl;
    CustomLabel * avlQtyLbl;
    CustomLabel * priceLbl;
    CustomLabel * returnQtyLbl;
    CustomLabel * valueLbl;
    CustomLabel * reasonLbl;
    CustomLabel * actionLbl;
    // added by  roja on 23-07-2018..
    CustomLabel * batchNo;
    CustomLabel * expiryDate;
    CustomLabel * scanCode;
    
    UILabel * returnQtyValueLbl;
    UILabel * totalvalueLbl;
    
 
    UIButton *submitBtn;
    UIButton *saveButton;
    UIButton *cancelButton;
    
    UILabel *totalQuantity;
    
    UILabel *totalCost;

    
//  Table View Creation.
    UITableView *skListTable;
    UITableView *cartTable;
    UITableView *shipModeTable;
    UITableView *receiptIDTable;
    UITableView *locationTable;
    UITableView *issueIdsTable;
    
    UITextField * ReceiptID;
    UITextField * returnQtyTxt;
    UITextField * commentsTxt;
    UITextField * reasonsTxt;
    // added by roja on 23-07-2018..
    UITextField *batchNoTxt;
    UITextField *expiryDateTxt;
    UITextField *scanCodeTxt;
    
    //used for move the view when keyboard appear.......
    int  startIndexInt;
    int  totalNumberOfStockReceipt;
    
    bool reloadTableData;
    bool isDraft;
    float offSetViewTo;

    
    UILabel *userAlertMessageLbl;
    NSTimer *fadeOutTime;
    UIAlertView * warning;
    
    
    
    

    UITableView *normalstockTable;
    UITableView *supplierTable;
 
    
    NSMutableArray *rawMaterials;
    NSMutableArray *rawMaterialDetails;
    NSMutableArray *skuArrayList;
    NSMutableArray *shipmodeList;
    NSMutableArray *receiptIDS;
    NSMutableArray *locationArr;

    
    

    UITextView *comments;
    UITextView *reason;
    UITextView *remarks;
    NSDictionary *viewReceiptJSON;
    NSString *receiptNoteRef;
    
    NSMutableArray *issueIdsArr;
    
    
    // views requried for price view
    
    NSMutableArray * priceArr;
    
    UIButton * closeBtn;
    UIView * priceView;
    UIView *transparentView;
    UITableView * priceTable;
    

    
    CustomLabel * descLabl;
    CustomLabel * mrpLbl;
    CustomLabel * priceLabl;

    UIView * categoriesView;
    UIButton * selectCategoriesBtn;
    UITableView * categoriesTbl;
    NSMutableArray * categoriesArr;
    NSMutableArray * checkBoxArr;
    
    UIButton * selectAllCheckBoxBtn;
    UIButton * checkBoxsBtn;
    UIPopoverController * categoriesPopOver;

    UIAlertView * delItemAlert;
    UIAlertView * conformationAlert;
    
    
}

@property (nonatomic,strong)NSIndexPath * selectIndex;

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property (strong, nonatomic) NSString * returnID;



@end
