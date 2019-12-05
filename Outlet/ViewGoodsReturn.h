//
//  OmniRetailer
//
//  Created by Chandrasekhar on 2/24/15.
//
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"
#import "CustomNavigationController.h"
#import "WebServiceUtility.h"
#import "WebServiceConstants.h"
#import "WebServiceController.h"
#import "CustomTextField.h"
#import "CustomLabel.h"

@interface ViewGoodsReturn : CustomNavigationController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MBProgressHUDDelegate,UIPopoverControllerDelegate,UIActionSheetDelegate,UITextViewDelegate,StockReturnServiceDelegate,ZoneMasterDelegate,utilityMasterServiceDelegate,OutletMasterDelegate,ModelMasterDelegate,RolesServiceDelegate>
{

    //to get the device version.......
    float version;
    
    //used to store the device Orientation.......
    UIDeviceOrientation currentOrientation;
    
    //used for HUD..(processing bar).......
    MBProgressHUD * HUD;
    
    //Creation of UIView(goodsReturnView)
    UIView *goodsReturnView;

    //Creation of UIpopOverController..
    UIPopoverController *catPopOver;

    
    
    //Creation of CustomTextField...
    CustomTextField * outletIdTxt;
    CustomTextField * zoneIdTxt;
    CustomTextField * startDateTxt;
    CustomTextField * endDateTxt;
    CustomTextField * statusTxt;
    
    CustomTextField * categoryTxt;
    CustomTextField * subCategoryTxt;
    CustomTextField * brandTxt;
    CustomTextField * modelTxt;
    
    //for searching the return ID ..
    CustomTextField * returnIDTxt;
    
    //for Displaying the paginatin Data..
    CustomTextField * pagenationTxt;
    
    // creation of searchBtn for the filter puropose....
    UIButton * searchBtn;
    
    //Creation of UIScrollView..
    UIScrollView * stockReturnScrollView;
    
    //Creation of CustomLabels...
    CustomLabel * sNoLbl;
    CustomLabel * returnRefNoLbl;
    CustomLabel * dateOfReturnLbl;
    CustomLabel * returnedByLbl;
    CustomLabel * shipmentModeLbl;
    CustomLabel * toLocationLbl;
    CustomLabel * returnQtyLbl;
    CustomLabel * totalValueLbl;
    CustomLabel * statusLbl;
    CustomLabel * actionLbl;
    
    //Creation of StockReturnTbl..
    UITableView * stockReturnTbl;
    
    //Creation of totalInventoryView...
    UIView * totalInventoryView;
    
    
    
    NSMutableArray * stockReturnArr;
    NSMutableArray * pagenationArr;
    
    UIButton * newButton;
    UIButton * openButton;
    
    UIDatePicker * myPicker;
    UIView * pickView;
    NSString * dateString;
    
    UILabel *userAlertMessageLbl;
    NSTimer *fadeOutTime;
    
    
    int startIndexint;
    int totalNoOfStockReturn;
    
    
    UITableView * locationTbl;
    UITableView * categoriesListTbl;
    UITableView * subCategoriesListTbl;
    UITableView * departmentListTbl;
    UITableView * subDepartmentListTbl;
    UITableView * brandListTbl;
    UITableView * modelListTbl;
    UITableView * workFlowListTbl;
    UITableView * pagenationTbl;
    
    NSMutableArray * locationArr;
    NSMutableArray * categoriesListArr;
    NSMutableArray * subCategoriesListArr;
    NSMutableArray * brandListArray;
    NSMutableArray * ModelListArray;
    NSMutableArray * workFlowsArr;
    NSMutableArray * departmentListArr;
    
    NSMutableDictionary * zoneWiseLocationDic;
    NSMutableDictionary * dept_SubDeptDic;

    NSMutableOrderedSet * zoneListArr;

    NSString * outLetStoreName;
    
    
    UILabel * totalStockReturnValueLbl;
    UILabel * totalReturnQtyValueLbl;
    

}


@property (strong, nonatomic) UIPopoverController* popOver;
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;
@end
