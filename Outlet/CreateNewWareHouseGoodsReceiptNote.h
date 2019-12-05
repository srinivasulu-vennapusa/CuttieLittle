//
//  ViewController.h
//  OmniRetailer
//
//  Created by TLMac on 11/8/16.
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


@interface CreateNewWareHouseGoodsReceiptNote : CustomNavigationController<MBProgressHUDDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,WarehouseGoodsReceipNoteServiceDelegate,UITextFieldDelegate,SearchProductsDelegate,GetSKUDetailsDelegate,UIAlertViewDelegate,NSXMLParserDelegate,UIGestureRecognizerDelegate,EmployeeServiceDelegate,PurchaseOrderSvcDelegate,SupplierServiceSvcDelegate>
{
    //to get the device version.......
    float version;
    
    //used to store the device Orientation.......
    UIDeviceOrientation currentOrientation;
    
    
    //used for HUD..(processing bar).......
    MBProgressHUD *HUD;
    
    
    //used to create completeView.....
    UIView *purchaseOrderView;
    
    
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
    
    CustomTextField *submitedByTxt;
    CustomTextField *approvedByTxt;
    CustomTextField *locationTxt;
    
    CustomTextField *searchItemsTxt;
    
    NSString *searchString;
    NSMutableArray *searchResultItemsArr;
    NSMutableArray *searchDisplayItemsArr;
    
    UITableView *searchOrderItemTbl;
    
    //UILabel used here.......
    UILabel *wareHouseIdLbl;
    
    
    //Used on TopOfTable.......
    CustomLabel  * sNoLbl;
    CustomLabel  * skuIdLbl;
    CustomLabel  * descriptionLbl;
    CustomLabel  * uomLbl;
   
    //Added Recently By Bhargav.v on 12/06/2018.. //-*-*-*-*
    CustomLabel  * BatchNoLabel;
    CustomLabel  * expDateLabel;
    CustomLabel  * itemCodeLabel;
    CustomLabel  * hsnCodeLabel;
    CustomLabel  * discountLabel;
    CustomLabel  * flatDiscountLbl;
    CustomLabel  * taxLabel;

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

    UILabel * item_Handled_By_Lbl;


    //Newly added TextFields... //-*-*-*
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
    
    UITextField * itemHandledByTxt;
    
    
    //UITableView .......
    UITableView *requestedItemsTbl;
    NSMutableArray *requestedItemsInfoArr;
    
    //used to move the scrollView.......
    UIView *adjustableView;
    
    float shipmentCost;
    float totalDiscounts;
    
    UIImageView *starRat;
    
    NSMutableDictionary *goodsReceiptNoteInfoDic;
    
    
    //Used to display the all VendorIds.......
    NSMutableArray *vendorIdArr;
    NSMutableDictionary *vendorIdDic;
    UITableView *vendorIdsTbl;
    
    
    //Used to display all popUp view.......
    UIPopoverController *catPopOver;
    
    
    //Used to show dataSelectionPopUp.......
    UIView *pickView;
    UIDatePicker *myPicker;
    NSString *dateString;
    
    //used for keyboard apperance.......
    float offSetViewTo;
    
    UIAlertView *successAlert;
    
    
    //UITableView .......
    UITableView *purchaseOrderRefNoTbl;
    NSMutableArray *purchaseOrderRefNoArr;
    
    NSDictionary *populateDic;
    

    
    BOOL didTableDataEditing;
    
    UILabel *userAlertMessageLbl;
    NSTimer *fadOutTime;
    
    UIButton *vendorIdBtn;
    
    UIButton *dueDateBtn;
    UIButton *deliveryDateBtn;
    
    UIButton * inspectdByBtn;
    UIButton * receivedByBtn;
    
    //used for parser the xml data....
    NSXMLParser *parserXml;
    NSMutableDictionary *xmlViewCategotriesInfoDic;
    
    //added on 07/02/2017....
    UITextField *divrdPriceTxt;
    
    //added by srinivasulu on 08/02/2017...
    //used to show dropDowns....
    
    //Used to display the all VendorIds.......
    NSMutableArray *employeesListArr;
    UITableView *employeesListTbl;
    
    //used to take input from user....
    CustomTextField * invoiceNumberTxt;
    CustomTextField * indentRefNumberTxt;

    UIButton * selectCategoriesBtn;
    

    int vendorRating;
    
    BOOL isDraft;
    
 
    //changed this buttons local to global. By srinivauslu on 02/05/2018....
    //reason.. Need to stop user internation after servcie calls...
    
    UIButton * submitBtn;
    UIButton * saveBtn;

    //upto here on 02/05/2018....
    
    
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
    
    //Newly added to check the Boolean Declarations -- by bhargav
    NSMutableArray * isItemTrackingRequiredArray;
    NSMutableArray * costPriceEditableArray;
    
    //related to bottam display....
//    UIView * totalInventoryView;
//    UIView * taxView;
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

}


@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property (nonatomic,strong)NSString *goodsReceiptRefID;
@property (nonatomic,strong)NSString *selectedString;

@end
