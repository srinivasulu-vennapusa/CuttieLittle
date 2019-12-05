//
//  EditAndViewStockRequest.h
//  OmniRetailer
//
//  Created by    Bhargav Ram on 10/5/16.
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

@interface NewStockRequest : CustomNavigationController <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIAlertViewDelegate,SearchProductsDelegate,MBProgressHUDDelegate,GetSKUDetailsDelegate,StockRequestDelegate,utilityMasterServiceDelegate,SkuServiceDelegate,OutletMasterDelegate,SkuServiceDelegate>
{
    //used for HUD..(processing bar).......
    MBProgressHUD *HUD;
    
    //to get the device version.......
    float version;
    
    //used to store the device Orientation.......
    UIDeviceOrientation currentOrientation;
    
    //used to create completeView.....
    UIView *stockRequestView;
    UIView * adjustableView;
    UIScrollView * stockRequestScrollView;
    
   // Validating text fields before submiting the indent..
    
    CustomTextField * fromStoreTxt;
    CustomTextField * toLocationText;
    CustomTextField * requestedBy;
    CustomTextField * requestDteFld;
    CustomTextField * DeliveyDate;
    CustomTextField * shipmentModeTxt;
    CustomTextField * priorityTxt;
    CustomTextField * outletIdTxt;
    CustomTextField * zoneIdTxt;
    
    CustomTextField * searchItemTxt;
    
   
    //Used on TopOfTable.......
    CustomLabel  * S_No;
    CustomLabel  * skuId;
    CustomLabel  * descriptionLbl;
    
    //added by Srinivasulu on 11/05/2017....
    CustomLabel  * uomLbl;
    CustomLabel  * gradeLbl;

    //upto here on 11/05/2017....
    CustomLabel  * priceLbl;
    
    
    // added by Bhargav 22/05/2017
    
    CustomLabel  * qohLbl;
    CustomLabel  * prvIndentQtyLbl;
    CustomLabel  * projQtyLbl;
    CustomLabel  * qtyLbl;
    CustomLabel  * approvedQtyLbl;

    CustomLabel  * actionLbl;
    
    UILabel * taxesValueLbl;
    
    //Used to show dataSelectionPopUp.......
    UIView * pickView;
    UIDatePicker * myPicker;
    NSString * dateString;
    NSString * requestReceipt;
    
    UIPopoverController * catPopOver;
    
    UIAlertView * successAlert;
    
    
    NSMutableArray * productList;
    NSMutableArray * rawMaterialDetails;
    NSMutableArray * shipModesArr;
    NSMutableArray * locationArr;
    
    //added by Roja on 02-07-2018....
    NSMutableArray * businessActivityArr;
    NSString * businessActivityStr;
    
    
    NSMutableArray * warehouseLocationArr;
    NSMutableArray * priorityArr;
    
    UITableView * productListTbl;
    UITableView * priceTable;
    UITableView * requestedItemsTbl;
    UITableView * shipModeTable;
    UITableView * locationTable;
    UITableView * priorityTbl;
    
    //added by Srinivasulu on 11/05/2017...
    UIButton * saveBtn;
    //upto hereon 11/05/2017....
    
    UIButton * submitBtn;
    UIButton * cancelButton;
    
    // qty change GUI
    
    UITextField * qtyField;
    UITextField * appQtyField;
    

    //used for move the view when keyboard appear.......
    float offSetViewTo;
    
    bool reloadTableData;
    
    UILabel * userAlertMessageLbl;
    NSTimer * fadeOutTime;

    UITableView *newStockRequestTab;
    
    CustomLabel * descLabl;
    CustomLabel * priceLabl;
    CustomLabel * mrpLbl;
   
    NSMutableArray * priceArr;
    
    
    UIButton * closeBtn;
    
    UIView * priceView;
    
    UIView * transparentView;
    
    UITableView  * priceTableView;
    
    //added by Srinivausulu on 11/05/2017....
    UIScrollView * stockRequestItemsScrollView;
 
    NSMutableArray * categoriesArr;
    
    //Added By Bhargav on 25/05/2017....

    UIPopoverController * categoriesPopOver;
    UIView * categoriesView;
    UIButton * selectCategoriesBtn;
    UITableView * categoriesTbl;
    
    //new fields added by Bhargav on 24/05/2017...

    NSMutableArray * checkBoxArr;
    UIButton *selectAllCheckBoxBtn;
    UIButton *checkBoxsBtn;
    
    //UILabel For Displaying Totals Values...
    
    UILabel * quantityOnHandValueLbl;
    UILabel * previousQtyValueLbl;
    UILabel * projectedQtyValueLbl;
    UILabel * requestedQtyvalueLbl;
    UILabel * approvedQtyValueLbl;
    UIButton * selctWareHouse;
    
    UIAlertView * conformationAlert;
    
    UIView * sucessTransparentView;
    UIView * successView;
    
    UILabel * requestIdValueLbl;
    UILabel * outletIdValueLbl;
    UILabel * dateValueLbl;
    UILabel * statusValueLbl;
    UILabel * NoOfItemsValueLbl;
    UILabel * totalRequestedQtyValueLbl;
  
    // Used while we are chekiing Draft Status..
    NSDictionary * requestViewReceiptJSON;
    
    BOOL isDraft;
    NSMutableArray * isPacked;
    
    UIAlertView * delItemAlert;
    UIButton * delrowbtn;
    
    // added by roja on 30/04/2019..
    CustomLabel * productBatchNoLabel;

    
}

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;


@property (nonatomic,retain)NSIndexPath * selectIndex;

@property (strong, nonatomic) NSString * requestID;


@end
