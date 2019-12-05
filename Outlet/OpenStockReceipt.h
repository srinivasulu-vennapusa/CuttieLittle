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
#import "CustomNavigationController.h"
#import "CustomLabel.h"
#import "MBProgressHUD.h"

@interface OpenStockReceipt :CustomNavigationController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,StockReceiptServiceDelegate,ZoneMasterDelegate,utilityMasterServiceDelegate,OutletMasterDelegate,ModelMasterDelegate,RolesServiceDelegate> {
    
    //changed by Srinivasulu on 25/05/2017....
    //changed the order.... reason is for easy understanding....
    //added some of the new filed's....
    
    //used to store the device os version....
    float version;
    
    //used to store the device Orientation.......
    UIDeviceOrientation currentOrientation;
    
    //it is used to show the process/progress bar....
    MBProgressHUD * HUD;
    
    //it is used as main view....
    UIView * StockReceiptView;
    
    
    //changed by Srinivasulu on 25/05/2017.... from UITextField to CustomTextFields....
    //used in first column....
    CustomTextField * outletIdTxt;
    CustomTextField * zoneIdTxt;
    
    //used in second column....
    CustomTextField * categoryTxt;
    CustomTextField * subCategoryTxt;
    
    
    //used in third column....
    CustomTextField * brandTxt;
    CustomTextField * modelTxt;
    
    
    //used in fourth column....
    CustomTextField * startDateTxt;
    CustomTextField * endDateTxt;
    
    CustomTextField * statusTxt;
    CustomTextField * toOutletsTxt;
    
    
    //added by Bhargav on 10/05/2017....
    


    
    
    //used for displaying location as well as the zoneId....
    NSMutableArray *locationArr;
    NSMutableOrderedSet *zoneListArr;
    NSMutableDictionary *zoneWiseLocationDic;
    
    UITableView *locationTbl;
    
    
    //used in zoneId selection....
    NSString *outLetStoreName;
    NSString *zoneName;
    
    //Used for Displaying the soreageUnits.....
    UITableView * categoriesListTbl;
    NSMutableArray * categoriesListArr;
    
    //Used for Displaying the soreageUnits.....
    UITableView * subCategoriesListTbl;
    NSMutableArray * subCategoriesListArr;
    
    //Used for Displaying the soreageUnits.....
    UITableView * brandListTbl;
    NSMutableArray * brandListArray;
    
    NSMutableDictionary *dept_SubDeptDic;
    
    //Used for Displaying the soreageUnits.....
    UITableView * modelListTbl;
    NSMutableArray * ModelListArray;
    
    //used for searching the id....
    UITextField * receiptIdTxt;

    //used for filter's search....
    UIButton * searchBtn;
    
    
    //used for items scrollView....
    UIScrollView * stockReceiptScrollView;

    
    
    
    //this are used for dispalying warning message....
    UILabel *userAlertMessageLbl;
    NSTimer *fadOutTime;
    
    //used as table header....
    CustomLabel * sNoLbl;
    CustomLabel * RefNoLbl;
    CustomLabel * dateLbl;
    CustomLabel * receivedByLbl;
    CustomLabel * requestedQtyLbl;
    CustomLabel * issuedByLbl;
    CustomLabel * issuedQtyLbl;
    CustomLabel * weightedQtyLbl;
    CustomLabel * receivedQtyLbl;
    CustomLabel * statusLbl;
    CustomLabel * actionLbl;

  //Labels for the calculation...
    UILabel * totalNoOfItemsValueLbl;
    UILabel * totalItemsQtyValueLbl;


    
    UIPopoverController * catPopOver;
    UIView * pickView;
    UIAlertView * warning;
    UIDatePicker *myPicker;
    
    
    
    
    NSMutableArray * stockReceiptsArr;
    
    UITableView * workFlowListTbl;
    NSMutableArray * workFlowsArr;
 
    
    UITableView * StockReceiptTbl;
    
    UIButton * newButton;
    UIButton * openButton;
    UIButton * viewListOfItemsBtn;
    
    int startIndexint;
    
    NSString * dateString;
    
    //Grid Level UIElements...
    
    UITableView * requestedItemsTbl;
    NSMutableArray * requestedItemsInfoArr;
    UIView * requestedItemsTblHeaderView;

    NSMutableDictionary * updateDictionary;
    BOOL isInEditableState;

    
    CustomLabel * itemNoLbl;
    CustomLabel * itemCodeLbl;
    CustomLabel * itemNameLbl;
    CustomLabel * itemGradeLbl;
    CustomLabel * itemReqstQtyLbl;
    CustomLabel * itemIssueQtyLbl;
    
    //Added By Bhargav on 26/10/2017...
    
    UIView * totalInventoryView;
    CustomTextField * pagenationTxt;
    NSMutableArray  * pagenationArr;
    UITableView * pagenationTbl;
    

    
}
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property (assign)BOOL isOpen;
@property (nonatomic,retain)NSIndexPath * selectIndex;
@property (nonatomic,retain)NSIndexPath * buttonSelectIndex;
@property (nonatomic,retain)NSIndexPath * selectSectionIndex;


@end
