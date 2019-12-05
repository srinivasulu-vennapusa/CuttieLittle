
//  EditStockVerificationController.h
//  OmniRetailer
//  Created by Technolabs on 05/06/17.


#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"
#import "CustomTextField.h"
#import "CustomLabel.h"
#import "WebServiceController.h"
#import "CustomNavigationController.h"
#import "RequestHeader.h"
#import "PopOverViewController.h"


@interface EditStockVerificationController : CustomNavigationController<MBProgressHUDDelegate,SearchProductsDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,StoreStockVerificationDelegate,GetSKUDetailsDelegate,SkuServiceDelegate,utilityMasterServiceDelegate,OutletMasterDelegate,PowaTSeriesObserver,PowaScannerObserver>{//StoreStockVerificationServiceDelegate
    
    MBProgressHUD * HUD;
    float version;
    UIDeviceOrientation currentOrientation;
    UIView * stockVerificationView;
    
    CustomTextField * zoneTxt;
    CustomTextField * outletIDTxt;
    
    CustomTextField * startDteTxt;
    CustomTextField * endDteTxt;
    CustomTextField *startTimeTxt;
    CustomTextField *endTimeTxt;
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

    
    UIButton * submitBtn;
    UIButton * saveBtn;
    UIButton * cancelButton;
    
    UITextField * searchItemTxt;
    
    UIScrollView * stockVerificationScrollView;
    
    NSMutableArray * productList;
    UITableView * productListTbl;
    UITableView * pricListTbl;
    UITableView * rawMaterialDetailsTbl;
    NSMutableArray * priceDic;
    
    
    NSMutableArray * rawMaterialDetails;
    UIView * transparentView;
    
    UILabel *userAlertMessageLbl;
    NSTimer *fadeOutTime;
    
    
    UITextField * actualStockTxt;
    UITextField * declaredStockTxt;

    UITextField * dumpTxt;
    UITextField * diffTxt;
    
    UIView * adjustableView;
    UIView * pickView;
    UIDatePicker * myPicker;
    UIPopoverController * catPopOver;
    NSString * dateString;
    NSString * verificationStr;
    NSString * masterVerificationStr;
    
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
    
    NSMutableArray * isPacked;
    
    UILabel * totalOpenStockVlueLbl;
    UILabel * totalSaleQtyValueLbl;
    UILabel * totalBookStockVlueLbl;
    UILabel * totalActualStockVlueLbl;
    UILabel * declaredStockValueLbl;
    UILabel * dumpValueLbl;
    UILabel * diffValueLbl;
    UILabel * stockLossValueLbl;
    UILabel * closeStockValueLbl;
    UILabel * itemScanCodeLabel;

    
    UITableView * losstypeTbl;
    NSMutableArray * lossTypeArr;
    UITextField * lossTypeTxt;
    UIButton * lossTypeBtn;

    
    //using to get the values from the dictionary while updating
    
    NSMutableDictionary * updateStockDic;
   
    //checking the next activities array
    
    UITableView * nextActivityTbl;
    NSMutableArray *  nextActivitiesArr;
    UIView   * workFlowView;
    UIButton * viewListOfItemsBtn;

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
    
    UITextField * itemLevelActualStockTxt;
    UITextField * gradeStockTxt;
    UITextField * dumpQtyTxt;
    UITextField * scanCodeText;
    
    UITableView * itemsListTbl;
    NSMutableArray * itemsListArr;
    UIAlertView * delItemAlert;
    UIAlertView * conformationAlert;
    
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

    //
    UIButton * itemSkuidButton;
    
    // added by roja on 03/04/2019...
    UIAlertView * cancellationAlert;
    int totalRecords;
    NSTimer * intervalTImer;
    //Upto here added by roja on 03/04/2019...

}

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property (strong, nonatomic) NSString * verificationId;

@property (assign)BOOL isOpen;
@property (nonatomic,retain)NSIndexPath *buttonSelectIndex;
@property (nonatomic,retain)NSIndexPath *selectIndex;
@property (nonatomic,retain)NSIndexPath *selectSectionIndex;

@end
