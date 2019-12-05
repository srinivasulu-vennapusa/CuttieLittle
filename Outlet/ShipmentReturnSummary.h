//
//  ShipmentReturnSummary.h
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

@interface ShipmentReturnSummary : CustomNavigationController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate,ShipmentReturnServiceDelegate,SkuServiceDelegate,OutletMasterDelegate,SupplierServiceSvcDelegate> {
    
    //to get the device version.......
    float version;
    
    //Intetger Data type to assign startIndex as 0
    
    int startIndex;
    int totalShipmentReturns;
    
    //used to store the device Orientation.......
    UIDeviceOrientation currentOrientation;
    
    //used for HUD..(processing bar).......
    MBProgressHUD * HUD;
    
    //Creation of ShipmentReturn View as main for the class.....
    UIView * shipmentReturnView;
    
    //Creation of Custom TextFields...
    
    /*Creation of textField used in this page*/
    
    //changed by Srinivasulu on 10/05/2017....
    
    CustomTextField * outletIdTxt;
    CustomTextField * zoneIdTxt;
    CustomTextField * categoryTxt;
    CustomTextField * subCategoryTxt;
    CustomTextField * supplierNameTxt;
    CustomTextField * itemWiseTxt;
    CustomTextField * startDateTxt;
    CustomTextField * endDateTxt;
    
    //for searching the returned bills Summary..
    CustomTextField * shipmentReturnTxt;
    CustomTextField * pagenationTxt;
    
    //Creation of UIButton..
    UIButton *  searchBtn;
    
    //Creation of UIView..
    UIView * totalInventoryView;
    
    //Creation of UIScrollView...
    UIScrollView * shipmentReturnScrollView;
    
    
    //Header Labels...
    CustomLabel * snoLbl;
    CustomLabel * shipmentReturnRefLbl;
    CustomLabel * createdDateLbl;
    CustomLabel * shipmentDateLbl;
    CustomLabel * supplierNameLbl;
    CustomLabel * shipmentModeLbl;
    CustomLabel * receivedQtyLbl;
    CustomLabel * returnQtyLbl;
    CustomLabel * totalValueLbl;
    CustomLabel * statusLbl;
    CustomLabel * actionLbl;
    
    UITableView * shipmentReturnTable;
    UITableView * categoriesListTbl;
    UITableView * subCategoriesListTbl;
    UITableView * supplierListTbl;
    UITableView * itemWiseListTbl;
    UITableView * vendorIdsTable;
    UITableView * pagenationTbl;
    
    
    //Creation of NSMUTABLE ARRAY..
    
    NSMutableArray * shipmentReturnArray;
    NSMutableArray * locationWiseCategoriesArr;
    NSMutableArray * subCategoriesListArr;
    NSMutableArray * vendorIdsArray;
    NSMutableArray * itemWiseListArr;
    NSMutableArray * pagenationArr;
    //Creation of UIButton for the Navigation...
    UIButton * newButton;
    
    UIButton * openButton;
    
    // Displaying alert message custom mode.
    
    UILabel *userAlertMessageLbl;
    NSTimer *fadeOutTime;
    
    //used to Display the popover for filter purpose...
    UIPopoverController * catPopOver;

    //Used to show dataSelectionPopUp.......
    UIView * pickView;
    UIDatePicker * myPicker;
    NSString * dateString;
    
    UILabel  * receivedQtyValueLbl;
    UILabel  * returnQtyValueLbl;
    UILabel  * totalQtyValueLbl;

    

}


@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@end
