//
//  CreateAndViewGoodsReceiptNote.h
//  OmniRetailer
//
//  Created by Srinivasulu on 10/21/16.
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
#import "CustomNavigationController.h"


@interface CreateAndViewGoodsReceiptNote : CustomNavigationController<MBProgressHUDDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,WarehouseGoodsReceipNoteServiceDelegate,UITextFieldDelegate,SearchProductsDelegate,GetSKUDetailsDelegate,UIAlertViewDelegate,NSXMLParserDelegate,UIGestureRecognizerDelegate,EmployeeServiceDelegate,PurchaseOrderSvcDelegate,SupplierServiceSvcDelegate>
{
    
    //to get the device version.......
    float version;
    
    //used to store the device Orientation.......
    UIDeviceOrientation currentOrientation;
    
    
    //used for HUD..(processing bar).......
    MBProgressHUD *HUD;
    
    
    //used to create completeView.....
    UIView *purchaseOrderView;
    
    
    //used for workFlowView.......
    UIView *workFlowView;
    
    
    //used to scroll completeView.......
    UIScrollView *purchaseOrderScrollView;
    
    
    //used to take customerInputs selection.......
    CustomTextField *poRefNoTxt;
    CustomTextField *dueDateTxt;
    CustomTextField *deliveredDateTxt;
    
    CustomTextField *vendorIdTxt;
    CustomTextField *supplierNameTxt;
    
    CustomTextField *inspectedByTxt;
    CustomTextField *receivedByTxt;
    CustomTextField *deliveredByTxt;
    CustomTextField *locationTxt;
    CustomTextField *submitedByTxt;
    CustomTextField *approvedByTxt;
  
    
    CustomTextField *actionRequiredTxt;

    
    CustomTextField *searchItemsTxt;
    
    //To Select Categories
    UIButton * selectCategoriesBtn;

    
    
    NSString *searchString;
    NSMutableArray *searchResultItemsArr;
    NSMutableArray *searchDisplayItemsArr;
    
    UITableView *searchOrderItemTbl;

    
    //UILabel used here....
    UILabel *wareHouseIdLbl;
    
    //Used on TopOfTable.......
    CustomLabel  *sNoLbl;
    CustomLabel  *skuIdLbl;
    CustomLabel  *descriptionLbl;
    CustomLabel  *uomLbl;
    
    //Added Recently By Bhargav.v on 12/06/2018..
    CustomLabel  * BatchNoLabel;
    CustomLabel  * expDateLabel;
    CustomLabel  * itemCodeLabel;
    CustomLabel  * hsnCodeLabel;
    CustomLabel  * discountLabel;
    CustomLabel  * flatDiscountLbl;
    CustomLabel  * taxLabel;
    
    //upto here....

    CustomLabel  * poQtyLbl;
    CustomLabel  * poPriceLbl;
    CustomLabel  * freeQtyLbl;
    CustomLabel  * delveredQtyLbl;
    CustomLabel  * noOfUnitsLbl;
    CustomLabel  * mrpLbl;
    CustomLabel  * delveredPriceLbl;
    CustomLabel  * netCostLbl;
    CustomLabel  * itemHandledByLbl;
    CustomLabel  * actionLbl;
    //UITableView .......
    UITableView    * requestedItemsTbl;
    NSMutableArray * requestedItemsInfoArr;
    
    //used to move the scrollView.......
    UIView *adjustableView;
  
    
    float shipmentCost;
    float totalTax;
    float totalDiscounts;
    
    UIImageView *starRat;
  
    NSMutableDictionary *goodsReceiptNoteInfoDic;

    //Used to display the all VendorIds.......
    NSMutableArray *vendorIdArr;
    NSMutableDictionary *vendorIdDic;
    UITableView *vendorIdsTbl;
    int vendorRating;
    
    //Used to display all popUp view.......
    UIPopoverController *catPopOver;
    
    //Used to show dataSelectionPopUp.......
    UIView *pickView;
    UIDatePicker *myPicker;
    NSString *dateString;

    //used for keyboard apperance.......
    float offSetViewTo;

    UIAlertView *successAlert;
    
    UIButton *saveBtn;
    UIButton *editBtn;
    UIButton *cancelBtn ;

    UITableView *nextActivitiesTbl;
    NSMutableArray *nextActivitiesArr;
    
    //Newly added TextFields...
    UITextField * batchNoText;
    UITextField * expDateText;
    UITextField * itemCodeText;
    UITextField * hsnCodeText;
    UITextField * discountText;
    UITextField * flatDiscountTxt;
    UITextField * taxValueTxt;
    UITextField * divrdQtyTxt;
    UITextField * freeQtyTxt;
    UITextField * noOfUnitsTxt;
    UITextField * mrpValueTxt;
    UITextField  * itemHandledByTxt;

    BOOL didTableDataEditing;
 
    UILabel *userAlertMessageLbl;
    NSTimer *fadOutTime;

    UIButton *vendorIdBtn;
    
    UIButton *dueDateBtn;
    UIButton *deliveryDateBtn;
    
    //used for parser the xml data....
    NSXMLParser *parserXml;
    NSMutableDictionary *xmlViewCategotriesInfoDic;
    
    //added by srinivasulu on 07/02/2017...
    
    UIButton *items_Save_R_Delete_Btn;
    
    //upto here on 07/02/2017....
    
    //added on 07/02/2017....
    UITextField *divrdPriceTxt;

    //used to show dropDowns....
    UIButton *inspectdByBtn;
    UIButton *receivedByBtn;
    
    //Used to display the all VendorIds.......
    NSMutableArray *employeesListArr;
    UITableView *employeesListTbl;
    
    //used in table hander's....
    UILabel * item_Handled_By_Lbl;
    
    //used to take input from user....
    CustomTextField *invoiceNumberTxt;

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

    //Newly added to check the Boolean Declarations...
    NSMutableArray * isItemTrackingRequiredArray;
    NSMutableArray * costPriceEditableArray;
    
    //Collapse Button to collapse  the view to show the items List...
    
    UIButton * collapseButton;

    //related to bottam display....
    UIView * totalInventoryView;
    UIView * taxView;
    UIView * bottamDispalyView;
    
    //used for calcuation part.......
    UILabel * subTotalValueLbl;
    UILabel * itemLevelDiscountValueLbl;
    UILabel * taxValueLbl;
    
    UITextField * shipmentValueTxt;
    UITextField * totalDiscountValueTxt;
    UILabel * totalInvoiceDiscountValLbl;
    
    UILabel * totalCostValueLbl;
    UITextField * totalInvoiceValueTxt;
    UILabel * totalInvoiceGrossValueLbl;
//    UITextField  * shipmentValueTxt;
//    UITextField  * totalDiscountValueTxt;

}


@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property (nonatomic,strong)NSString *goodsReceiptRefID;
@property (nonatomic,strong)NSString *selectedString;


@end
