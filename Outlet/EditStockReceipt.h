//
//  EditStockReceipt.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 2/14/15.
//
//

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"
#import "CustomTextField.h"
#import "WebServiceController.h"
#import "WebServiceConstants.h"
#import "CustomNavigationController.h"
#import "CustomLabel.h"

@interface EditStockReceipt : CustomNavigationController<MBProgressHUDDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,StockReceiptServiceDelegate,GetSKUDetailsDelegate,SearchProductsDelegate,SkuServiceDelegate> {
    
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
    UIView * stockReceiptView;
    
    //    UITExtField Creation
    
    CustomTextField * locationTxt;
    CustomTextField * dateTxt;
    CustomTextField * receiptRefTxt;
      
    CustomTextField * issueRefTxt;
    CustomTextField * requestRefTxt;
    CustomTextField * deliveredByTxt;
    
    CustomTextField * shipmentDateTxt;
    CustomTextField * inspectedByTxt;
    CustomTextField * receivedByTxt;
    
    CustomTextField * toOutletTxt;
    CustomTextField * issuedByTxt;
    CustomTextField * shipmentModeTxt;
    CustomTextField * actionReqTxt;
    
    UIView * workFlowView;
    
    UITextField * searchItemTxt;
    UITextField * qtyChangeTxt;
    
    //used at top of the table as headerfiles....
    CustomLabel * sNoLbl;
    CustomLabel * sKuidLbl;
    CustomLabel * descLbl;
    CustomLabel * uomLbl;
    CustomLabel * priceLbll;
    CustomLabel * requestedQtyLbl;
    CustomLabel * issuedQtyLbl;
    CustomLabel * receivedQtyLabel;
    CustomLabel * acceptedQtyLbl;
    CustomLabel * diffQtyLabel;
    CustomLabel * itemScanCodeLabel;
    CustomLabel * actionLbl;
    
    //upto here on 27/05/2017...
    
    UILabel * costLbl;
    
    UITableView * skListTable;
    UITableView * cartTable;
    UITableView * nextActivityTbl;
    UITableView * shipModeTable;
    
    
    UIButton * submitBtn;
    UIButton  * saveButton;
    UIButton * cancelButton;
    
    NSMutableArray * productListArr;
    NSMutableArray * rawMaterialDetails;
    NSMutableArray * nextActivitiesArr;
    NSMutableArray * shipModesArr;
    
    NSMutableDictionary * updateStockReceiptDic;
    
    //used to move the view when keyboard appear.......
    int goodsReceiptInt;
    float offSetViewTo;
    bool reloadTableData;
    
    
    UILabel *userAlertMessageLbl;
    NSTimer *fadeOutTime;
    
//    NSString *status ;
    
    UILabel *descLabl;
    
    UILabel *priceLbl;
    
    UILabel *mrpLbl;
    UITableView *priceTable;
    NSMutableArray *priceArr;
    NSMutableArray *descArr;
    NSMutableArray *itemScanCode;
    NSMutableArray *priceDic;
    UIButton *closeBtn;
    UIView *priceView;
    UIDeviceOrientation *currentOriention;
    
    UIView *transparentView;

    NSString *presentStatus;
    
    UIPopoverController * catPopOver;
    
    UITextField * receivedQtyTxt;
    UITextField * acceptedQtyTxt;
    UITextField * diffQtyText;
    UITextField * scanCodeText;
    
    //added by Srinivasulu on 27/05/2017....
    
    UIScrollView * stockReceiptItemsScrollView;
    
    UIButton * selectCategoriesBtn;
    NSMutableArray * categoriesArr;
    UITableView * categoriesTbl;
    UIView * categoriesView;
    UIPopoverController * categoriesPopOver;

    //upto here on 27/05/2017....
    NSMutableArray * checkBoxArr;
    UIButton * selectAllCheckBoxBtn;
    UIButton * checkBoxsBtn;

    //Added On 31/10/2017...By Bhargav.v
    
    UILabel * requestQtyValueLbl;
    UILabel * issueQtyValueLbl;
    UILabel * receivedQtyValueLbl;
    UILabel * acceptedQtyValueLbl;
    UILabel * diffQtyValueLabel;
    
    //UIButtons used as subviews in cell....
    UIButton * delrowbtn;
    UIButton * moreBtn;

}

@property (strong, nonatomic) NSString * receiptId;

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;



@end
