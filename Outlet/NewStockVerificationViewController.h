//
//  NewStockVerificationViewController.h
//  OmniRetailer
//
//  Created by Technolabs on 17/05/17.
//
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"
#import "CustomTextField.h"
#import "CustomLabel.h"
#import "WebServiceController.h"
#import "CustomNavigationController.h"
#import "RequestHeader.h"
#import "PopOverViewController.h"



@interface NewStockVerificationViewController:CustomNavigationController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,OutletMasterDelegate,StoreStockVerificationDelegate,StockVerificationSvcDelegate,utilityMasterServiceDelegate,RolesServiceDelegate> {
    
    MBProgressHUD * HUD;
    float version;
    UIDeviceOrientation currentOrientation;
    
    UIView * stockVerificationView;
    
    UIView * requestedItemsTblHeaderView;

    UIView * pickView;
    UIPopoverController * catPopOver;
    UIDatePicker * myPicker;
    NSString * dateString;
    
    CustomTextField * zoneTxt;
    CustomTextField * categoryTxt;
    CustomTextField * startDteTxt;
    CustomTextField * outletIDTxt;
    CustomTextField * subCategoryTxt;
    CustomTextField * endDateTxt;
    CustomTextField * statusTxt;
    
    UIButton * startVerificationBtn;
    
//    Header Section:
    
    UIScrollView * stockVerificationScrollView;
    
    CustomLabel * snoLbl;
    CustomLabel * dateLbl;
    CustomLabel * outletIdLbl;
    CustomLabel * openStockLbl;
    CustomLabel * saleQtyLbl;
    CustomLabel * bookStockLbl;
    CustomLabel * declaredStockLbl;
    CustomLabel * stockDumpLbl;
    CustomLabel * dumpCostLbl;
    CustomLabel * stockLossLbl;
    CustomLabel * lossCostLbl;
    CustomLabel * closeStockLbl;
    CustomLabel * statusLbl;
    CustomLabel * actionLbl;
    
//    customLables for the Grid Level:
    
    CustomLabel * itemNoLbl;
    CustomLabel * categoryLbl;
    CustomLabel * itemSaleQtyLbl;
    CustomLabel * itemSaleLbl;
    CustomLabel * openStock;
    CustomLabel * dumpLbl;
    CustomLabel * dumpVal;
    CustomLabel * itemlevelStockLossLbl;
    CustomLabel * itemLevelLossCostLbl;
    CustomLabel * lossLbl;
    CustomLabel * dumpPercentLbl;
    
    
    //UILabels for displaying the inventory item total values...
    
    UILabel * openStockValueLbl;
    UILabel * saleQtyValueLbl;
    UILabel * bookStockValueLbl;
    UILabel * declaredQtyValueLbl;
    UILabel * stockDumpValueLbl;
    UILabel * dumpCostValueLbl;
    UILabel * stockLossValueLbl;
    UILabel * lossCostValueLbl;
    UILabel * closeStockValueLbl;

   // UIButton for  the filters...
    
    UIButton *  searchBtn;
    
//    UITable View
    
    NSMutableArray * subCategoryArr;
    NSMutableArray * categoriesArr;
    NSMutableArray * stockVerificationArr;
    NSMutableArray * itemsListArr;
    NSMutableArray * verificationMasterChildListArr;
    NSMutableArray * workFlowsArr;
    
    BOOL isInEditableState;

    NSMutableDictionary * categoryAndSubcategoryInfoDic;
    NSMutableDictionary * itemDetailsDic ;
    
    UITableView * categoriesTbl;
    UITableView * subCategorytbl;
    UITableView * stockVerificationTbl;
    UITableView * itemsListTbl;
    UITableView * workFlowListTbl;
    
    UIButton * viewButton;
    UIButton * viewListOfItemsBtn;
    
    int verificationIndex;
    int totalRecords;

    UITableView * locationTable;
    NSMutableArray * locationArr;
    NSMutableArray * warehouseLocationArr;
    
    UILabel *userAlertMessageLbl;
    NSTimer *fadeOutTime;

    //Added on 1/11/2017 By BHargav.v
    
    CustomTextField * pagenationTxt;
    NSMutableArray  * pagenationArr;
    UITableView     *pagenationTbl;
}

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;


@property (assign)BOOL isOpen;
@property (nonatomic,retain)NSIndexPath *selectIndex;
@property (nonatomic,retain)NSIndexPath *buttonSelectIndex;

@property (nonatomic,retain)NSIndexPath *selectSectionIndex;







@end
