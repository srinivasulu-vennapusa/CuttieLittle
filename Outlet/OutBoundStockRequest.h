//
//  OutBoundStockRequest.h
//  OmniRetailer
//
//  Created by Technolabs on 5/18/18.
//

#import <UIKit/UIKit.h>
#import "CustomNavigationController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "WebServiceUtility.h"
#import "WebServiceConstants.h"
#import "WebServiceController.h"
#import "RequestHeader.h"
#import "PopOverViewController.h"
#import "CustomTextField.h"
#import "CustomLabel.h"
#import "MBProgressHUD.h"
#import <QuartzCore/QuartzCore.h>



@interface OutBoundStockRequest : CustomNavigationController<MBProgressHUDDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,StockRequestDelegate,ZoneMasterDelegate,utilityMasterServiceDelegate,OutletMasterDelegate,ModelMasterDelegate,RolesServiceDelegate,SkuServiceDelegate> {
    
    //used for HUD..(processing bar).......
    MBProgressHUD * HUD;
    
    //to get the device version.......
    float version;
    
    //used to store the device Orientation.......
    UIDeviceOrientation currentOrientation;
    
    //used to create completeView.....
    UIView * stockRequestView;
    
    
    //used to take customerInputs selection.......
    //first column....
    CustomTextField *outletIdTxt;
    CustomTextField *zoneIdTxt;
    
    //second column....
    CustomTextField * categoryTxt;
    CustomTextField * subCategoryTxt;
    
    //third column....
    CustomTextField * brandTxt;
    CustomTextField * modelTxt;
    
    //fourth column....
    CustomTextField *startDateTxt;
    CustomTextField *endDateTxt;
    
    //fifth column....
    CustomTextField *statusTxt;
    
    //used for searching the items....
    CustomTextField *searchItemsTxt;
    
    //Used on TopOfTable.......
    CustomLabel * snoLbl;
    CustomLabel * requestIDlbl;
    CustomLabel * outletIDLbl;
    CustomLabel * requestDateLbl;
    CustomLabel * requestedByLbl;
    CustomLabel * requestedQuantityLbl;
    CustomLabel * approvedQuantityLbl;
    CustomLabel * noOfItemslbl;
    CustomLabel * approvedItemsLbl;
    CustomLabel * deliveryDteLbl;
    CustomLabel * requestStatusLbl;
    CustomLabel * actionLbl;
    
    //used for displaying the RequestIds info....
    UITableView * stockRequestTbl;
    NSMutableArray * stockRequestsInfoArr;
    
    //used in the dispalying and navigating to other viewController....
    UIButton * viewStockRequestBtn;
    UIButton * editStockRequestBtn;
    
    UIButton * viewListOfItemsBtn;
    
    //used on displaying reuestItemsHeaders....
    UIView * requestedItemsTblHeaderView;
    
    //used for dispalying the requestItemsInfo....
    CustomLabel  * itemNoLbl;
    CustomLabel  * itemCodeLbl;
    CustomLabel  * itemNameLbl;
    CustomLabel  * itemGradeLbl;
    CustomLabel  * currentStockLbl;
    CustomLabel  * itemRequestedQtyLbl;
    CustomLabel  * itemApprrovedQtyLbl;
    CustomLabel  * itemApprovedTimeLbl;
    CustomLabel  * itemApprovedByLbl;
    
    //used for dispalying the requestItemsInfo....
    UITableView * requestedItemsTbl;
    NSMutableArray * requestedItemsInfoArr;
    
    //used in the dispalying the content of requestItemsInfo....
    UITextField * qtyChangeTxt;
    UITextField * apporvedQtyTxt;
    
    UIButton * saveStockRequestBtn;
    
    
    //used in the pagination service calls....
    int requestStartNumber;
    int totalNoOfStockRequests;
    
    //Used to show dataSelectionPopUp.......
    UIView * pickView;
    UIDatePicker * myPicker;
    NSString * dateString;
    
    
    //used for all popUps display....
    UIPopoverController * catPopOver;
    
    
    
    
    //used for SummaryDispaly....
    CustomLabel  * summaryLabel_1;
    CustomLabel  * summaryLabel_2;
    CustomLabel  * summaryLabel_3;
    CustomLabel  * summaryLabel_4;
    CustomLabel  * summaryLabel_5;
    CustomLabel  * summaryLabel_6;
    
    NSMutableArray * stockRequestSummaryInfoArr;
    UITableView * stockRequestSummaryInfoTbl;
    
    
    
    
    
    //used for displaying location as well as the zoneId....
    NSMutableArray * locationArr;
    NSMutableOrderedSet * zoneListArr;
    NSMutableDictionary * zoneWiseLocationDic;
    
    UITableView * locationTbl;
    
    //Used for Displaying the soreageUnits.....
    UITableView * categoriesListTbl;
    NSMutableArray * categoriesListArr;
    
    //Used for Displaying the soreageUnits.....
    UITableView * subCategoriesListTbl;
    NSMutableArray * subCategoriesListArr;
    
    //Used for Displaying the soreageUnits.....
    UITableView * departmentListTbl;
    NSMutableArray * departmentListArr;
    
    NSMutableDictionary *dept_SubDeptDic;
    
    //Used for Displaying the soreageUnits.....
    UITableView * subDepartmentListTbl;
    NSMutableArray * subDepartmentListArr;
    
    
    //used For Displaying the pagination count...
    
    UITableView  * pagenationTbl;
    NSMutableArray * pagenationArr;
    CustomTextField *pagenationTxt;
    
    
    //    new Mutable Array for the brand by Bhargav on 23/05/2017...
    
    UITableView * brandListTbl;
    NSMutableArray * brandListArray;
    
    UITableView * modelListTbl;
    NSMutableArray * ModelListArray;
    
    
    NSMutableArray * locationWiseBrandsArr;
    
    
    UIButton *searchBtn;
    UIButton * summaryInfoBtn;
    
    // UILabels for the Summary PopOver to show the values...
    
    UILabel * totalQtyValueLbl;
    UILabel * totalEstCostValueLbl;
    
    NSMutableDictionary * summaryFieldsDic;
    
    BOOL didTableDataEditing;
    
    
    NSMutableArray * workFlowsArr;
    UITableView * workFlowListTbl;
    
    NSMutableArray * locationWiseCategoriesArr;
    
    
    //UIView  to Display the  totalValues in Summary page...
    UIView * totalInventoryView;
    UIScrollView * stockRequestScrollView;
    
    
    //added by Srinivasulu on 09/05/2017....
    NSMutableDictionary * updateDictionary;
    BOOL isInEditableState;
    
    //used for keyboardmovement....
    float offSetViewTo;
    
    //this are used for dispalying warning message....
    UILabel * userAlertMessageLbl;
    NSTimer * fadOutTime;
    
    
    UILabel * totalOutletsValueLbl;
    UILabel * totalIndentsRequestValueLbl;
    
    UILabel * indentsOpenedValueLbl;
    
    UILabel * totalQuntityValueLbl;
    
    UIScrollView * detailsFooterScrollView;
    UIScrollView * detailsFooterView;
    
    UIImageView * scrollViewBarImgView;
    
}

@property (readwrite)    CFURLRef        soundFileURLRef;
@property (readonly)    SystemSoundID    soundFileObject;


@property (assign)BOOL isOpen;
@property (nonatomic,retain)NSIndexPath * selectIndex;
@property (nonatomic,retain)NSIndexPath * buttonSelectIndex;
@property (nonatomic,retain)NSIndexPath * selectSectionIndex;

@end
