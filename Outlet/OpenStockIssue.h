//
//  OmniRetailer
//
//  Created by Chandrasekhar on 2/24/15.
//
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"
#import "CustomNavigationController.h"
#import "CustomLabel.h"


@interface OpenStockIssue : CustomNavigationController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MBProgressHUDDelegate,UIPopoverControllerDelegate,UIActionSheetDelegate,StockIssueDelegate,GetSKUDetailsDelegate,SearchProductsDelegate,SkuServiceDelegate,utilityMasterServiceDelegate>
{
    MBProgressHUD *HUD;
    float version;
    UIDeviceOrientation currentOrientation;

    UIView *createReceiptView;
    
    CustomTextField *searchItemsTxt;
    
    //Used on TopOfTable.......
    CustomLabel  *sNoLbl;
    CustomLabel  *skuIdLbl;
    CustomLabel  *descriptionLbl;
    CustomLabel  *uomLbl;
    CustomLabel  *rangeLbl;
    CustomLabel  *gradeLbl;
    CustomLabel  *priceLabel;
    CustomLabel  *availQtyLbl;
    CustomLabel  *stockQtyLbl;
    CustomLabel  *issueQtyLbl;
    CustomLabel  *scanCodeLabel;
    CustomLabel  *balanceQtyLbl;
    CustomLabel  *make_Lbl;
    CustomLabel  *actionLbl;
    
    //upto here on 14/04/2017....
    
    UILabel * totalIssuesValueLbl;
    UILabel * totalSaleCostValueCost;
    
    UIButton * editBtn;
    UIButton * cancelBtn;
    
    /** creation of UITextField*/
    CustomTextField * fromLocTxt;
    CustomTextField * toStoreCodeTxt;
    
    CustomTextField * issueDateTxt;
    CustomTextField * deliveryDteTxt;

    CustomTextField * requestRefNoTxt;
    CustomTextField * requestDateTxt;

    CustomTextField * shipmentModeTxt;
    CustomTextField * shipmentRefTxt;
    
    CustomTextField * issuedByTxt;
    CustomTextField * carriedByTxt;
    CustomTextField * ActionReqTxt;
   
    UITextField * issueQtyText;
    UITextField * balanceQtyTxt;
    UITextField * scanCodeText;

    // To Select multiple Stores..
    UIScrollView * stockIssueScrollView;
    
    UITableView * requestedItemsTbl;
    NSMutableArray * requestedItemsInfoArr;
    
    UITableView * productListTbl;
    NSMutableArray * productList;
    
    UITableView * nextActivityTbl;
    NSMutableArray * nextActivitiesArr;
    
    UITableView * shipModeTable;
    NSMutableArray * shipModesArr;
    
    UIPopoverController * catPopOver;
    
    UIView * adjustableView;
    UIView * workFlowView;
    int  startIndexInt;
    
    NSMutableDictionary *updateStockIssueDic;
   
    //alert message:
    
    UILabel *userAlertMessageLbl;
    NSTimer *fadeOutTime;
    
    //used to move the view when keyboard appear.......
    float offSetViewTo;
    
    bool reloadTableData;
    
    UITableView *priceTable;
    NSMutableArray *priceArr;
    NSMutableArray *descArr;
    NSMutableArray *priceDic;
    
    UIView *priceView;
    UIView *transparentView;
    UIButton *closeBtn;
    UILabel *descLabl;
    UILabel *mrpLbl;
    UILabel *priceLbl;
    

    //Creation of Select Categories Button...
    UIButton * selectCategoriesBtn;
    NSMutableArray * categoriesArr;
    UITableView * categoriesTbl;
    UIView * categoriesView;
    UIPopoverController *categoriesPopOver;
    
    //used to check and uncheck the check boxes...
    NSMutableArray * checkBoxArr;
    UIButton *selectAllCheckBoxBtn;
    UIButton *checkBoxsBtn;
    
    //item Level Value Labels....
    UILabel * priceValueLbl;
    UILabel * stockQtyValueLbl;
    UILabel * issueQtyValueLbl;
    UILabel * balanceQtyValueLbl;
    
    //Recently Added By Bhargav...on 1/08/2017
    
    NSMutableArray * locationArr;
    NSMutableArray * locationCheckBoxArr;
    UIView         * multipleIssuesView;
    UITableView    * locationTable;
    UIButton       * locationCloseBtn;
    
    
    //For Calendar PopOVer Purpose...
    
    UIView * pickView;
    UIDatePicker * myPicker;
    NSString * dateString;
    
    
    NSMutableArray * isPacked;
    
}


@property (strong, nonatomic) NSString * IssueId;


@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;
@property (nonatomic,retain)NSIndexPath * selectIndex;


@end
