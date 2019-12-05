//
//  ShipmentReturnEdit.h
//  OmniRetailer
//
//  Created by Technolabs on 12/7/17.
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

@interface ShipmentReturnEdit : CustomNavigationController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate,ShipmentReturnServiceDelegate,utilityMasterServiceDelegate,SearchProductsDelegate,GetSKUDetailsDelegate,SkuServiceDelegate> {
    
    //to get the device version.......
    float version;

    //used to store the device Orientation.......
    UIDeviceOrientation currentOrientation;
    
    //used for HUD..(processing bar).......
    MBProgressHUD * HUD;

    //Creation of ShipmentReturn View as main for the class.....
    UIView * shipmentReturnView;
    
    //To Display the Categories
    UIView * categoriesView;
    
    //To Display the price-List
    UIView * transparentView;
    
    //To Display the WorkFlow States....
    UIView * workFlowView;

    
    //Custom TextFields...
    CustomTextField * fromLocationText;
    CustomTextField * poReferenceText;
    CustomTextField * supplierShipmentRefText;
    CustomTextField * shippedOnText;

    CustomTextField * shippedByText;
    CustomTextField * shipmentModeText;
    CustomTextField * shipmentCarrierText;
    CustomTextField * invoiceNoText;
    
    CustomTextField * reasonText;
    CustomTextField * returnTimeText;
    CustomTextField * returnDateText;
    CustomTextField * returnedByText;
    
    CustomTextField * toSupplierText;
    CustomTextField * supplierAddressText;
    CustomTextField * streetLocalityText;
    CustomTextField * contactNoText;
    
    CustomTextField * actionRequiredText;
    
    
    //To Search SKU's
    UITextField * searchItemsTxt;
    
    //To Select Categories
    UIButton * selectCategoriesBtn;
    
    //Adding The Custom Labels To Scroll View For Future purpose in case the labels count might increase based on the Scope.....
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

    //UIButton for the Submit functinality...
    UIButton *  submitBtn;
    UIButton *  cancelBtn;
    
    // To Display the Total Values.....
    UILabel  * receivedQtyValueLbl;
    UILabel  * totalValueLbl;
    UILabel  * returnQtyValueLbl;

    //To Display the nextActivities Array....
    NSMutableArray * nextActivitiesArr;
    
    // store the Complete Data based on the purchaseStockReturnRef No.
    NSMutableDictionary * shipmentReturnDictionary;
    
    //NSMutable Array....
    NSMutableArray * skuListArray;
    NSMutableArray * rawMaterialDetails;
    NSMutableArray * categoriesArr;
    NSMutableArray * priceArr;
    NSMutableArray * shipmentModesArray;
    NSMutableArray * returnReasonArray;
    
    
    NSMutableArray * checkBoxArr;
    UIButton       * selectAllCheckBoxBtn;
    
    UITableView * categoriesTable;
    UITableView * skListTable;
    UITableView * priceListTable;
    UITableView * cartTable;
    UITableView * shipmentModeTable;
    UITableView * returnReasonTable;
    
    // Displaying alert message custom.
    UILabel *userAlertMessageLbl;
    NSTimer *fadeOutTime;
    
    
    UIPopoverController * categoriesPopOver;
    UIPopoverController * catPopOver;
    
    
    //Used to show dataSelectionPopUp.......
    UIView * pickView;
    UIDatePicker * myPicker;
    NSString * dateString;

    
    //Editable Fields In the Cart Level to Submit Reson for the return And Total number of Quantity to Return...
    UITextField * returnReasonText;
    UITextField * returnQtyTxt;
    UIButton * delRowBtn;
    
    UIButton * checkBoxsBtn;
    
    // To Display the Header labels for the PriceList Table....
    CustomLabel * descLabl;
    CustomLabel * mrpLbl;
    CustomLabel * priceLabl;
    
    UIButton * closeBtn;
    UIView   * priceView;
    
    //Boolean value to reload the Data in the cart after the specified changes....
    bool reloadTableData;
    float offSetViewTo;
    Boolean * status;
    
    UIAlertView * delItemAlert;
    NSString * supplierIdStr;
    
    

}

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property (strong, nonatomic) NSString * purchaseStockStr;


@end
