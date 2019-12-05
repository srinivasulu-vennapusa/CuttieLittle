//
//  ShipmentReturnNew.h
//  OmniRetailer
//
//  Created by Bharagav.v on 12/7/17.
//
//

#import <UIKit/UIKit.h>
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


@interface ShipmentReturnNew : CustomNavigationController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate,SearchProductsDelegate,GetSKUDetailsDelegate,SkuServiceDelegate,utilityMasterServiceDelegate,SupplierServiceSvcDelegate,OutletGRNServiceDelegate,WarehouseGoodsReceipNoteServiceDelegate,OutletMasterDelegate,ShipmentReturnServiceDelegate> {
  
    //to get the device version.......
    float version;
    
    //used to store the device Orientation.......
    UIDeviceOrientation currentOrientation;
    
    //used for HUD..(processing bar).......
    MBProgressHUD * HUD;
    
   
    //used to create completeView.....
    UIView * shipmentReturnView;
    
    //UIView for the Categories pop...
    
    UIView * categoriesView;
    
    //CustomTextFields...
    
    CustomTextField * fromLocationTxt;
    CustomTextField * poReferenceTxt;
    CustomTextField * supplierShipmntRefTxt;
    CustomTextField * shippedOnTxt;
    
    CustomTextField * shippedByTxt;
    CustomTextField * shipmentModeTxt;
    CustomTextField * shipmentCarrierTxt;
    CustomTextField * inVoiceNoTxt;
    
    CustomTextField * reasonTxt;
    CustomTextField * returnTimeTxt;
    CustomTextField * returnDateTxt;
    CustomTextField * returnedByTxt;
    
    CustomTextField * toSupplierTxt;
    CustomTextField * supplierAddressTxt;
    CustomTextField * streetLocalityTxt;
    CustomTextField * contactNoTxt;
    
    //Custom Text Field for the Searching Sku's...
    
    CustomTextField * searchItemsTxt;
    
    //UIButton for the catgory Selection...
    
    UIButton * selectCategoriesBtn;
    
    //UIScrollView For the Item Cart...
    
    UIScrollView * shipmentReturnScrollView;
    
    
    //Custom Labels to Display the Items Details...
    
    CustomLabel * sNoLbl;
    CustomLabel * skuIdLbl;
    CustomLabel * descLbl;
    CustomLabel * eanLbl;
    CustomLabel * reasonForReturnLbl;
    CustomLabel * uomLbl;
    CustomLabel * receivedQtyLbl;
    CustomLabel * priceLbl;
    CustomLabel * valueLbl;
    CustomLabel * returnQtyLbl;
    CustomLabel * actionLbl;
    
    
    //UITABLE VIEW....
    
    UITableView *  skListTable;
    UITableView *  cartTable;
    UITableView *  locationTable;
    UITableView *  returnReasonTable;
    UITableView *  shipmentModeTable;
    UITableView *  vendorIdsTable;
    UITableView *  grnReceiptIdsTable;
    UITableView *  categoriesTable;
    
    NSMutableArray * skuListArray;
    NSMutableArray * rawMaterialDetails;
    NSMutableArray * shipmentModesArray;
    NSMutableArray * returnReasonArray;
    NSMutableArray * locationArr;
    NSMutableArray * vendorIdsArray;
    NSMutableArray * grnReceiptIdsArray;
    NSMutableArray * grnReceiptDetailsArray;
    NSMutableArray * categoriesArr;
    NSMutableArray * checkBoxArr;
    
    
    //UIButton for the Submit functinality...
    
    UIButton * selectVendor;
    UIButton *  submitBtn;
    UIButton *  cancelBtn;
    
    UILabel  * receivedQtyValueLbl;
    UILabel  * totalValueLbl;
    UILabel  * returnQtyValueLbl;
    
    // Displaying alert message custom.
    UILabel *userAlertMessageLbl;
    NSTimer *fadeOutTime;

    UIPopoverController * catPopOver;
    UIPopoverController * categoriesPopOver;
    
    // views requried for price view
    UIView   *transparentView;
    UIView   * priceView;
    UITableView * priceListTable;
    NSMutableArray * priceArr;
    UIButton * closeBtn;
    
    CustomLabel * descLabl;
    CustomLabel * mrpLbl;
    CustomLabel * priceLabl;
    
    UIButton * selectAllCheckBoxBtn;
    UIButton * checkBoxsBtn;
    
    NSMutableDictionary * grnReceiptDetailsDic;
    
    UITextField * returnReasonText;
    UITextField * returnQtyTxt;
    
    //Boolean value to reload the Data in the cart after the specified changes....
    bool reloadTableData;
    float offSetViewTo;

    //Used to show dataSelectionPopUp.......
    UIView * pickView;
    UIDatePicker * myPicker;
    NSString * dateString;
    
    UIButton *  delRowBtn;
    UIAlertView * delItemAlert;
    
    NSString * supplierIdStr;
    
    Boolean * status;

    
}

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property (nonatomic,retain)NSIndexPath * selectIndex;

@end
