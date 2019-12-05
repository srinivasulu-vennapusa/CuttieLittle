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
#import "CustomLabel.h"

@interface EditGoodsReturn : CustomNavigationController<MBProgressHUDDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UITextViewDelegate,GetSKUDetailsDelegate,SearchProductsDelegate,StockReturnServiceDelegate,OutletMasterDelegate,SkuServiceDelegate>
{
    MBProgressHUD *HUD;

    UIDeviceOrientation  currentOrientation;
    UIPopoverController * catPopOver;
    
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
    CustomTextField *actionReqTxt;
    
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
    CustomLabel * batchNo;
    CustomLabel * expiryDate;
    CustomLabel * scanCode;

    
    //to get the device version.......
    float version;
    
    int startIndexint;
    int totalNoOfStockReturn;
    
    UIView  * workFlowView;

    NSMutableArray * stockReturnArr;
    NSMutableArray * nextActivitiesArr;
    NSMutableArray *shipmodeList;
    
    NSMutableArray *rawMaterials;
    NSMutableArray *rawMaterialDetails;
    
    
    
    UIView * goodsReturnView;
    UIScrollView * stockReturnScrollView;
    
    UITableView *cartTable;
    UITableView *skListTable;
    UITableView *shipModeTable;
    UITableView * nextActivityTbl;
    
    UITextField *searchItem;

    UITextField * returnQtyTxt;
    UITextField * commentsTxt;
    UITextField * reasonsTxt;
    
    // added by roja 23-07-2018...
    UITextField *batchNoTxt;
    UITextField *expiryDateTxt;
    UITextField *scanCodeTxt;
    
    UITableView * stockReturnTbl;
    
    NSMutableDictionary * updateStockReturnDic;
    
    NSString *dateString;
    UIDatePicker * myPicker;
    UIView * pickView;

    
    bool reloadTableData;
    float offSetViewTo;
    

    UILabel *userAlertMessageLbl;
    NSTimer *fadeOutTime;
    UIAlertView * warning;
    
//  Updating Button
    UIButton *submitBtn;
    UIButton *cancelButton;
    
    UITextView *remarks;
    UILabel *totalQuantity;
    UILabel *totalCost;
    
    // views requried for price view
    
    UIButton * closeBtn;
    NSMutableArray * priceArr;
    UITableView * priceTable;
    UIView * transparentView;
    UIView * priceView;
    
    UIPopoverController * categoriesPopOver;
    UIView * categoriesView;
    UIButton * selectAllCheckBoxBtn;
    NSMutableArray * checkBoxArr;
    NSMutableArray * categoriesArr;
    UITableView * categoriesTbl;
    UIButton * selectCategoriesBtn;
    UIButton * checkBoxsBtn;
    
    UILabel * returnQtyValueLbl;
    UILabel * totalvalueLbl;
    
    //Custom Label for the priceList...
    
    CustomLabel * descLabl;
    CustomLabel * mrpLbl;
    CustomLabel * priceLabl;
    
    Boolean * status;

    // added by roja
    UIAlertView * conformationAlert;


}
@property (strong, nonatomic) NSString * returnID;

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@end
