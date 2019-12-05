
//  StockvericationViewController.h
//  OmniRetailer
//  Created by Technolabs on 31/05/17.


#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"
#import "CustomTextField.h"
#import "CustomLabel.h"
#import "WebServiceController.h"
#import "CustomNavigationController.h"
#import "RequestHeader.h"
#import "PopOverViewController.h"
#import "BluetoothManager.h"
#import "BluetoothManagerHandler.h"
#import <PowaPOSSDK/PowaPOSSDK.h>
#import <ExternalAccessory/ExternalAccessory.h>


@interface StockverificationViewController:CustomNavigationController<MBProgressHUDDelegate,SearchProductsDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,StoreStockVerificationDelegate,GetSKUDetailsDelegate,SkuServiceDelegate,utilityMasterServiceDelegate,OutletMasterDelegate,PowaTSeriesObserver,PowaScannerObserver>{
    
    //used to store the device os version....
    float version;
    
    //used to store the device Orientation.......
    UIDeviceOrientation currentOrientation;
    
    //it is used to show the process/progress bar....
    MBProgressHUD * HUD;
    
    //it is used as main view....
    UIView * stockVerificationView;
    
    
    CustomTextField * zoneTxt;
    CustomTextField * outletIDTxt;
    CustomTextField * startDteTxt;
    CustomTextField * endDateTxt;
    CustomTextField * startTimeTxt;
    CustomTextField * endTimeTxt;
    CustomTextField * ActionReqTxt;
    
    
    
//    CustomLabels.....
    
    CustomLabel * snoLbl;
    CustomLabel * skuidLbl;
    CustomLabel * skuDescLbl;
    CustomLabel * uomLbl;
    CustomLabel * openStockLbl;
    CustomLabel * saleQtyLbl;
    CustomLabel * bookStockLbl;
    CustomLabel * actualStockLbl;
    CustomLabel * dumpLbl;
    CustomLabel * stockLossLbl;
    CustomLabel * declaredStockLbl;
    CustomLabel * closeStockLbl;
    CustomLabel * lossTypeLbl;
    CustomLabel * actionLbl;
    CustomLabel * diffLbl;
    // added by roja
    CustomLabel * openGridLbl;

    
//    labels For Price LIst..
    
    CustomLabel * descLbl;
    CustomLabel * mrpLbl;
    CustomLabel * priceLabel;
    
    // added by roja on 03/07/2019
    CustomLabel * pluCodeLabel;
    CustomLabel * eanLabel;
    CustomLabel * batchLabel;
    CustomLabel * measureRangeLabel;
    
    UITextField * actualStockValueTF;
    UITextField * dumpStockValueTF;
    //Upto here added by roja on 03/07/2019

    UIButton * submitBtn;
    UIButton * saveBtn;
    UIButton * cancelButton;

    //
    
    UITextField * searchItemTxt;
    
    
    UIScrollView * stockVerificationScrollView;
    
    NSMutableArray * productList;
    UITableView * productListTbl;
    UITableView *pricListTbl;
    UITableView * rawMaterialDetailsTbl;
    NSMutableArray * priceDic;
    UIButton * closeBtn;
    UIView * priceView;
    
    NSMutableArray* rawMaterialDetails;
    
    UIView * transparentView;

    UITextField * actualStockTxt;
    UITextField * declaredStockTxt;

    UITextField * dumpTxt;
    UITextField * diffTxt;
    UITextField * scanCodeText;
    
    UIView * adjustableView;
    UIView * pickView;
    UIDatePicker * myPicker;
    UIPopoverController *catPopOver;
    NSString * dateString;
    
    //used to diaplay alert message to user....
    UILabel *userAlertMessageLbl;
    NSTimer *fadeOutTime;
    
    float offSetViewTo;
    bool reloadTableData;
    
    
    UIButton * selectCategoriesBtn;
    NSMutableArray * categoriesArr;
    UITableView * categoriesTbl;
    UIView * categoriesView;
    UIPopoverController * categoriesPopOver;
    
    //check Box functionality...
    NSMutableArray * checkBoxArr;
    UIButton *selectAllCheckBoxBtn;
    UIButton *checkBoxsBtn;
    
    //Child Labels...
    UILabel * totalOpenStockVlueLbl;
    UILabel * totalSaleQtyValueLbl;
    UILabel * totalBookStockVlueLbl;
    UILabel * totalActualStockVlueLbl;
    UILabel * declaredStockValueLbl;
    UILabel * dumpValueLbl;
    UILabel * stockLossValueLbl;
    UILabel * diffValueLbl;
    UILabel * closeStockValueLbl;
    UILabel * itemScanCodeLabel;

//NSMutable array to store loss type values locally..
    NSMutableArray * lossTypeArr;
    UITableView * losstypeTbl;
    UITextField * lossTypeTxt;
    UIButton * lossTypeBtn;
  
   //Added On 07/08/2017....By Bhargav
    UITableView * locationTable;
    NSMutableArray * locationArr;
    
    UIButton * viewListOfItemsBtn;
    UITableView * itemsListTbl;
    NSMutableArray * itemsListArr;
    
    NSMutableArray * isPacked;
    
    UIView * requestedItemsTblHeaderView;

    CustomLabel * itemNoLbl;
    CustomLabel * itemDescLbl;
    CustomLabel * itemGradeLbl;
    CustomLabel * itemOpenStockLbl;
    CustomLabel * itemSaleQtyLbl;
    CustomLabel * itemActualStockLbl;
    CustomLabel * itemGradeStockLbl;
    CustomLabel * itemDumpQtyLbl;
    CustomLabel * itemStockLossLbl;
    CustomLabel * itemCloseStockLbl;
    CustomLabel * batchLbl;

    
    UITextField * itemLevelActualStockTxt;
    UITextField * gradeStockTxt;
    UITextField * dumpQtyTxt;
    
    BOOL isMultipleSection;
    UIAlertView * conformationAlert;
    UIAlertView * delItemAlert;
    
    UIButton * delrowbtn;
    
    
    // Added the UIElements And the Boolean properties
    // for Scanner Functionality....
    UISwitch * isSearch;
    UIButton * searchBarcodeBtn;
    
    //Checking the Whether the Item is Scanned....
    BOOL  isItemScanned;
    
    //Added By Bhargav.v to display the Scanner Status dynamically...
    UILabel  * powaStatusLblVal;
    
    //String Declaration To have the Manual Search when searchBarcodeBtn is in off mode.....
    NSString * selected_SKID;
    NSString * searchString;

    //making it global to display the popover...
    // To show sku and description
    UIView * transperentView;
    UIView * skuDescriptionView;
    UIButton * itemSkuidButton;
    // added by roja
    UIButton * openGridBtn;

    // added by roja on 03/04/2019..
    UIAlertView * cancellationAlert;
    NSTimer * intervalTImer;
    
    // when there is only 1 price list..
    UITextField * actualStockText;
    UITextField * dumpStockText;

    //Upto here added by roja on 03/04/2019...

  
}
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;
@property (nonatomic,retain) NSMutableDictionary * verificationCode;

@property (nonatomic,retain)NSIndexPath *selectIndex;
@property (assign)BOOL isOpen;

@property (nonatomic,retain)NSIndexPath *buttonSelectIndex;
@property (nonatomic,retain)NSIndexPath *selectSectionIndex;


@end
