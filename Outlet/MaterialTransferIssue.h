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
#import "CustomLabel.h"

@interface MaterialTransferIssue : CustomNavigationController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MBProgressHUDDelegate,StockIssueDelegate,OutletMasterDelegate,ModelMasterDelegate,utilityMasterServiceDelegate,RolesServiceDelegate,SkuServiceDelegate,ZoneMasterDelegate> {
    
    
    //changed by Srinivasulu on 05/06/2017....
    //changed the order.... reason is for easy understanding....
    //added some of the new filed's....
    
    //used to store the device os version....
    float version;
    
    //used to store the device Orientation.......
    UIDeviceOrientation currentOrientation;
    
    //it is used to show the process/progress bar....
    MBProgressHUD * HUD;
    
    
    //it is used as main view....
    UIView * goodsIssueView;
  
    
    CustomTextField * outletIdTxt;
    CustomTextField * startDateTxt;
    CustomTextField * endDateTxt;
    CustomTextField * zoneIdTxt;
    
    //newly added Fields on 18-05-2017 By bhargav
    CustomTextField * categoryTxt;
    CustomTextField * subCategoryTxt;
    CustomTextField * brandTxt;
    CustomTextField * modelTxt;
    CustomTextField * statusTxt;
    CustomTextField * toStoreTxt;
    
    
    //used for items scrollView....
    UIScrollView * stockIssueScrollView;
    
    //used as table header....
    CustomLabel * sNoLbl;
    CustomLabel * issueRefLbl;
    CustomLabel * issueFromLbl;
    CustomLabel * dateLbl;
    CustomLabel * issueToLbl;
    CustomLabel * noOfItemsLbl;
    CustomLabel * issueQtyLbl;
    CustomLabel * issuedByLbl;
    CustomLabel * valueLbl;
    CustomLabel * receivedQtyLbl;
    CustomLabel * statusLbl;
    CustomLabel * actionLbl;
    
    UIPopoverController * catPopOver;
    UIView * pickView;
    UIAlertView * warning;
    UIDatePicker *myPicker;
    
    UILabel * totalIssuesValueLbl;
    UILabel * totalSaleValueLbl;

    UITextField *searchItemsTxt;
    
    UIButton * selectWareHouseId;
    
    UIButton * newGoodsIssueBtn;
    UIButton * openGoodsIssueBtn;
    UIButton * viewListOfItemsBtn;
    
// For Searching Using Filters...
    
    UIButton * searchBtn;
    //used for displaying location as well as the zoneId....
    NSMutableArray *locationArr;
    NSMutableArray * toStoreLocationArr;
    NSMutableOrderedSet *zoneListArr;
    NSMutableDictionary *zoneWiseLocationDic;
    
    UITableView * locationTbl;
    UITableView * toStoreLocationTbl;

    NSString *outLetStoreName;
    NSString *zoneName;

    UITableView * receiptIdsTbl;
    UITableView * productListTbl;

    //Used for Displaying the soreageUnits.....
    UITableView * categoriesListTbl;
    NSMutableArray * categoriesListArr;
    
    //Used for Displaying the soreageUnits.....
    UITableView * subCategoriesListTbl;
    NSMutableArray * subCategoriesListArr;

    UITableView * brandListTbl;
    NSMutableArray * brandListArray;
    
    UITableView * modelListTbl;
    NSMutableArray * ModelListArray;
    
    NSString *dateString;
    NSMutableArray * receiptDetails;
    
    int  totalNumberOfRecords;
    
    //added by Srinivasulu on 13/04/2017....
    UILabel * userAlertMessageLbl;
    NSTimer * fadOutTime;
    
    //Uaed to display the Grid level items.... by Bhargav on 3/07/2017
    UITableView    *  requestedItemsTbl;
    NSMutableArray * requestedItemsInfoArr;
    UIView * requestedItemsTblHeaderView;
    
    NSMutableDictionary * updateDictionary;
    BOOL isInEditableState;
    
    CustomLabel * itemNoLbl;
    CustomLabel * itemSkuIDLbl;
    CustomLabel * itemDescLbl;
    CustomLabel * itemIssueQtyLbl;
    CustomLabel * itemPriceLbl;
    CustomLabel * itemGradeLbl;
    
    NSMutableArray *  workFlowsArr;
    UITableView    * workFlowListTbl;
    
    UIView   *  totalInventoryView;
 
    CustomTextField * pagenationTxt;
    NSMutableArray  * pagenationArr;
    UITableView     * pagenationTbl;
    NSMutableArray  * locationWiseBrandsArr;
    NSMutableArray  * locationWiseCategoriesArr;
    
    
    
}
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property (assign)BOOL isOpen;
@property (nonatomic,retain)NSIndexPath * selectIndex;
@property (nonatomic,retain)NSIndexPath * buttonSelectIndex;
@property (nonatomic,retain)NSIndexPath * selectSectionIndex;


@end
