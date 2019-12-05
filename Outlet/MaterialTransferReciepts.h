//
//  ReceiptGoodsProcurement.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 2/19/15.
//
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"
#import "WebServiceConstants.h"
#import "WebServiceController.h"
#import "CustomNavigationController.h"
#import "CustomLabel.h"

@interface MaterialTransferReciepts : CustomNavigationController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MBProgressHUDDelegate,GetSKUDetailsDelegate,SearchProductsDelegate,StockIssueDelegate,StockReceiptServiceDelegate,utilityMasterServiceDelegate,SkuServiceDelegate>
{
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
    UIView *createReceiptView;

    
    //used for taking input's from the user....
    //changed by Srinivasulu on 29/*05/2017....
    //reason for changing UITextField to CustomTextField is to reduce the coding....
    
    //used in first column...
    CustomTextField * location;
    CustomTextField * issueRef;
    CustomTextField * toOutletTxt;
    CustomTextField * requestRefTxt;
    CustomTextField * deliveredBy;

    CustomTextField * date;
    CustomTextField * inspectedBy;
    CustomTextField * shippedBy;
    CustomTextField * receivedByTxt;
    CustomTextField * shipmentModeTxt;
    
    //    UISegmentedControl *mainSegmentedControl;
    UIButton *submitBtn;
    UIButton *saveBtn;
    UIButton *cancelButton;
    
    
    
    NSMutableArray *rawMaterialDetails;
    NSMutableArray * skuArrayList;
    
    NSMutableArray *locationArr;
    UITableView *locationTable;
    
    UIAlertView *warning;
    //    new gui fields
    UILabel *totalQuantity;
    UILabel *totalCost;
    UITextField *searchItem;
    UITextField * qtyChangeTxt;
    
    UIButton * selectCategoriesBtn;
    
    //used to move the view when keyboard appear.......
    float offSetViewTo;
    
    bool reloadTableData;
    
    
    //used at top of the table as headerfiles....
    CustomLabel * sNoLbl;
    CustomLabel * sKuidLbl;
    CustomLabel * descLbl;
    CustomLabel * uomLbl;
    CustomLabel * priceLbll;
    
    //added by Srinivasulu on 27/05/2017....
    CustomLabel * requestedQtyLbl;
    CustomLabel * issuedQtyLbl;
    CustomLabel * weightedQtyLbl;
    
    CustomLabel * acceptedQtyLbl;
    CustomLabel * rejectedQtyLbl;

    CustomLabel * actionLbl;

    //upto here on 27/05/2017...

    CustomLabel * costLbl;
    
    
    
    NSMutableArray * productListArr;
    NSMutableArray * issueRefIdsArr;
    NSMutableArray * shipModesArr;
    
    UITableView * issueRefIdTbl;
    UITableView * cartTable;
    UITableView * skListTable;
    UITableView * shipModeTable;
    
    UIPopoverController * catPopOver;
    
    UIView * pickView;
    UIDatePicker * myPicker;
    NSString * dateString;
    
    int totalNumberOfRecords;
    NSString * IssueId;
    
    UILabel *userAlertMessageLbl;
    NSTimer *fadeOutTime;
    
    
    CustomLabel *descLabl;
    CustomLabel *priceLbl;
    CustomLabel *mrpLbl;
    
    UITableView *priceTable;
    NSMutableArray *priceArr;
    NSMutableArray *descArr;
    NSMutableArray *itemScanCode;
    NSMutableArray *priceDic;
    UIButton *closeBtn;
    UIView *priceView;
    UIDeviceOrientation *currentOriention;
    UIView *transparentView;
    
    
    //used in cell for row indexPath....
    UITextField * suppliedQtyTxt;
    UITextField * receivedQtyTxt;
    UITextField * weightedQtyTxt;
    UITextField * acceptedQtyTxt;
    UITextField * rejectedQtyTxt;
    
    //added by Srinivasulu on 27/05/2017....
 
    UIScrollView * stockReceiptItemsScrollView;
    
    //upto here on 27/05/2017....
    
    
    //Used for the Categories List Creation....
    NSMutableArray *categoriesArr;
    UITableView * categoriesTbl;
    UIView * categoriesView;
    UIPopoverController * categoriesPopOver;
    
    
    NSMutableArray * checkBoxArr;
    UIButton *selectAllCheckBoxBtn;
    UIButton *checkBoxsBtn;
   
//To Display the Location Details...
  
    UIButton * selectFromLocBtn;

    
    //Added On 31/10/2017...By Bhargav.v
    
    UILabel * requestQtyValueLbl;
    UILabel * issueQtyValueLbl;
    UILabel * weighedQtyValueLbl;
    UILabel * acceptedQtyValueLbl;
    UILabel * rejectedQtyValueLbl;
    
    NSMutableDictionary * stockReceiptDic;
    NSString  * presentStatus;

    BOOL isDraft;

    //moved from .h to .m by srinivasulu on 02/08/2018.. due to errors..

//    float version;

}
@property (strong, nonatomic) NSString * receiptId;

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;


@end
