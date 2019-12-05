//
//  GoodsReceiptNoteView.h
//  OmniRetailer
//
//  Created by Srinivasulu on 10/10/16.
//
//


#import "CustomNavigationController.h"

#import "MBProgressHUD.h"
#import <AudioToolbox/AudioToolbox.h>


#import "WebServiceUtility.h"
#import "WebServiceConstants.h"
#import "WebServiceController.h"

#import "RequestHeader.h"
#import "PopOverViewController.h"

#import "CustomLabel.h"
#import "CustomTextField.h"


@interface GoodsReceiptNoteView : CustomNavigationController <MBProgressHUDDelegate,UITextFieldDelegate,utilityMasterServiceDelegate,UITableViewDelegate,UITableViewDataSource,StockReceiptServiceDelegate,WarehouseGoodsReceipNoteServiceDelegate,NSXMLParserDelegate,EmployeeServiceDelegate,SupplierServiceSvcDelegate,UIGestureRecognizerDelegate>
{

    //to get the device version.......
    float version;
    
    //used to store the device Orientation.......
    UIDeviceOrientation currentOrientation;
    
    
    //used for HUD..(processing bar).......
    MBProgressHUD *HUD;
    
    //used to create completeView.....
    UIView *goodsReceiptNoteView;

    
    //used for the titleText.......
    UILabel *headerNameLbl;
    
    
    
    //used to take customerInputs selection.......
    CustomTextField *vendorIdTxt;
    CustomTextField *itemWiseTxt;
    
    CustomTextField *startDateTxt;
    CustomTextField *endDateTxt;
    
    CustomTextField *searchItemsTxt;
    
    //Added on 30/01/2018... Bhargav.v
    
    UIScrollView * headerScrollView;
    
    //Used on TopOfTable.......
    CustomLabel  *snoLbl;
    CustomLabel  *grnRefNumberLbl;
    CustomLabel  *poRefNumberLbl;
    CustomLabel  *requestDateLbl;
    CustomLabel  *deliveredByLbl;
    
    CustomLabel  *statusLbl;
    
    CustomLabel  *vendorIdLbl;
    CustomLabel  *poQuantityLbl;
    CustomLabel  *deliveredQuantityLbl;
    CustomLabel  *actionLbl;
    
    
    
    
    //Used to display all popUp view.......
    UIPopoverController *catPopOver;
    
    //Used to show dataSelectionPopUp.......
    UIView *pickView;
    UIDatePicker *myPicker;
    NSString *dateString;
    
    
    //Used for vendor search.......
    UITableView *vendorIdsTbl;
    NSMutableArray *vendorIdArr;
    
    //used for sku search product......
    NSString * itemKeyString;
    NSString * searchItemNameString;
    NSMutableArray * itemWiseListArr;
    
    UITableView *itemWiseListTbl;

    //Used in serverCalling.......
    int requestStartNumber;
    int totalNoOfStockRequests;

    NSString *searchString;

    
    //Used for mainTable.......
    NSMutableArray *stockReceiptInfoArr;
    UITableView *stockReceiptTbl;
    
    //Used on TopOfTable.......
    UIView *requestedItemsTblHeaderView;
    
    //Used for innerTable hader part Displaying.......
    CustomLabel  *itemNoLbl;
    CustomLabel  *itemNameLbl;
    CustomLabel  *itemGradeLbl;
    CustomLabel  *itemRequestedQtyLbl;
    CustomLabel  *itemRequestedPriceLbl;
    CustomLabel  *itemApprrovedQtyLbl;
    CustomLabel  *itemApprrovedPriceLbl;
    CustomLabel  *itemsNetCostLbl;
    CustomLabel  *itemHandledByLbl;
   
    //Used for innerTableDisplaying.......
    NSMutableArray *requestedItemsInfoArr;
    NSMutableDictionary *requestedItemsInfoDic;
    UITableView *requestedItemsTbl;
    
    UITextField *qtyChangeTxt;
    UITextField *apporvedQtyTxt;
    UIButton *saveGrnButton;
    
    UITableView *searchStockRequestIdTbl;
    
    //Used in the tableDisplay.......
    UIButton *viewStockRequestBtn;
    
    UIButton *editStockRequestBtn;
    UIButton *viewListOfItemsBtn;
    
    
    NSMutableArray *goodsReceiptNoteSummaryInfoArr;
    
    float offSetViewTo;

    UILabel *userAlertMessageLbl;
    NSTimer *fadOutTime;
    
    
    NSXMLParser *parserXml;
    NSMutableDictionary *xmlViewCategotriesInfoDic;

    //Used to display the all VendorIds.......
    NSMutableArray *employeesListArr;
    UITableView *employeesListTbl;

    
    NSMutableDictionary *updateDictionary;
    BOOL didTableDataEditing;
    BOOL isInEditableState;
    
    UITextField * itemHandledByTxt;
    
    //added on 07/02/2017....
    UITextField *divrdPriceTxt;

    
    //added by Srinviasulu on 09/02/2017...
    CustomLabel  *totalGRNLbl;

    UIButton *summaryInfoBtn;

    CustomTextField * pagenationTxt;
    NSMutableArray  * pagenationArr;
    
    UITableView  * pagenationTbl;
    
    UIView  * totalInventoryView;
    
    UILabel * totalQuantityValueLabel;
    UILabel * totalGrnValueLabel;
    
    
    //changed this buttons local to global. By srinivauslu on 02/05/2018....
    //reason.. Need to stop user internation after servcie calls...
    
    UIButton * createGRNBtn;
    
    //upto here on 02/05/2018....

    
}


@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property (assign)BOOL isOpen;
@property (nonatomic,strong)NSIndexPath *selectIndex;

@property (nonatomic,strong)NSIndexPath *selectSectionIndex;


@end
