//
//  OutBoundViewStockRequest.h
//  OmniRetailer
//
//  Created by Technolabs on 5/21/18.
//

#import <UIKit/UIKit.h>
#import "CustomNavigationController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "WebServiceUtility.h"
#import "WebServiceConstants.h"
#import "WebServiceController.h"
#import "RequestHeader.h"
#import "PopOverViewController.h"
#import "CustomTextField.h"
#import "CustomLabel.h"
#import "MBProgressHUD.h"
#import <QuartzCore/QuartzCore.h>

@interface OutBoundViewStockRequest : CustomNavigationController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MBProgressHUDDelegate,UIPopoverControllerDelegate,UIActionSheetDelegate,StockRequestDelegate,GetSKUDetailsDelegate,SearchProductsDelegate,SkuServiceDelegate,utilityMasterServiceDelegate,OutletMasterDelegate>
{
    //to get the device version.......
    float version;
    BOOL isInEditableState;
    
    //used to store the device Orientation.......
    UIDeviceOrientation currentOrientation;
    
    
    //used for HUD..(processing bar).......
    MBProgressHUD *HUD;
    
    //used to create completeView.....
    UIView *stockRequestView;
    
    
    UILabel * toLocationLbl;

    
    CustomTextField *toLocationTxt;
    CustomTextField *locationtxt;
    CustomTextField *requestIdTxt;
    CustomTextField *RequestedBy;
    CustomTextField *deliveryDateTxt;
    CustomTextField *RequestDteTxt;
    CustomTextField *shipmentModeTxt;
    CustomTextField *priorityTxt;
    CustomTextField * submittedByTxt;
    CustomTextField * actionRequiredTxt;
    CustomTextField * outletIdTxt;
    CustomTextField * zoneIdTxt;
    
    CustomTextField * searchItemTxt;
    
    float offSetViewTo;
    UIView  * workFlowView;
    bool reloadTableData;
    
    
    //Used on TopOfTable.......
    CustomLabel  * S_No;
    CustomLabel  * skuId;
    CustomLabel  * descriptionLbl;
    CustomLabel  * uomLbl;
    CustomLabel  * gradeLbl;
    CustomLabel  * priceLbl;
    CustomLabel  * qohLbl;
    CustomLabel  * prvIndentQtyLbl;
    CustomLabel  * projQtyLbl;
    CustomLabel  * qtyLbl;
    CustomLabel  * appQtyLbl;
    CustomLabel  * actionLbl;
    
    
    
    //    These fields are not in existence per UI Changes
    UILabel  * costLbl;
    UILabel  * colorLbl;
    UILabel  * modelLbl;
    UILabel  * sizeLbl;
    
    //added by Srinivasulu on 11/05/2017....
    
    UILabel  * estCostLbl;
    
    //upto here on 11/05/2017....
    
    
    
    //added by Srinivasulu on 14/04/2017....
    UILabel  * availableQtyLbl;
    
    //upto here on 14/04/2017....
    
    UILabel * receivedQuantity;
    UILabel * rejectedQuantity;
    //     UP To Here on 23/05/2017
    
    
    UILabel * totalItemsValueLbl;
    UILabel * totalQtyValueLbl;
    
    //Used to show dataSelectionPopUp.......
    UIView *pickView;
    UIDatePicker *myPicker;
    NSString *dateString;
    NSString * requestReceipt;
    
    UIPopoverController *catPopOver;
    
    UIAlertView *successAlert;
    
    NSMutableArray * productList;
    NSMutableArray * priceDic;
    NSMutableArray  *rawMaterialDetails;
    NSMutableArray  * shipModesArr;
    NSMutableArray  * locationArr;
    
    NSMutableArray * warehouseLocationArr;
    NSMutableArray * priorityArr;
    
    
    UITableView * productListTbl;
    UITableView * priceTable;
    UITableView *  requestedItemsTbl;
    UITableView * shipModeTable;
    UITableView * locationTable;
    UITableView * priorityTbl;
    
    UIButton * submitBtn;
    UIButton * cancelButton;
    UIButton * saveBtn;
    
    UITableView *nextActivitiesTbl;
    NSMutableArray *nextActivitiesArr;
    
    UITextField * qtyChangeTxt;
    UITextField * appQtyField;
    
    UIScrollView * stockRequestScrollView;
    UIView *adjustableView;
    
    UILabel *userAlertMessageLbl;
    NSTimer *fadeOutTime;
    
    UILabel *descLabl;
    UILabel *priceLabl;
    UILabel *mrpLbl;
    NSMutableArray *priceArr;
    NSMutableArray *descArr;
    NSMutableArray *itemScanCode;
    UIButton *closeBtn;
    UIView *priceView;
    UIDeviceOrientation *currentOriention;
    UIView *transparentView;
    
    
    NSDictionary * requestViewReceiptJSON;
    
    UIView * categoriesView;
    UIButton * selectCategoriesBtn;
    UITableView * categoriesTbl;
    UIPopoverController *categoriesPopOver;
    
    NSMutableArray * categoriesArr;
    
    UIButton * actionbtn;
    
    
    NSMutableArray * checkBoxArr;
    UIButton *selectAllCheckBoxBtn;
    UIButton *checkBoxsBtn;
    
    // UILabel For Displaying Totals Values...
    
    UILabel * quantityOnHandValueLbl;
    UILabel * previousQtyValueLbl;
    UILabel * projectedQtyValueLbl;
    UILabel * requestedQtyvalueLbl;
    UILabel * approvedQtyValueLbl;
    
    UIAlertView * conformationAlert;
    UIAlertView * delItemAlert;
    
    UIButton * delrowbtn;
    
    //for checking the is Packed Items..
    NSMutableArray * isPacked;
    
}
@property (strong, nonatomic) NSString * requestID;

@property (strong, nonatomic) UIPopoverController * popOver;
@property (nonatomic,retain)NSIndexPath * selectIndex;

@property (readwrite)    CFURLRef        soundFileURLRef;
@property (readonly)    SystemSoundID    soundFileObject;



@end
