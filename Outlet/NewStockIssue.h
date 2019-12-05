//
//  NewStockIssue.h
//  OmniRetailer
//
//  Created by bhargav on 11/1/16.
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



@interface NewStockIssue : CustomNavigationController<UITextFieldDelegate,MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate,SearchProductsDelegate,GetSKUDetailsDelegate,utilityMasterServiceDelegate,StockRequestDelegate,StockIssueDelegate,OutletMasterDelegate,SkuServiceDelegate> {
    
    //to get the device version.......
    float version;
    
    //used to store the device Orientation.......
    UIDeviceOrientation currentOrientation;
    
    
    //used for HUD..(processing bar).......
    MBProgressHUD *HUD;
    
    
    //used to create completeView.....
    UIView *stockIssueView;
    UIView * pickView;
    UIDatePicker * myPicker;
    UIPopoverController *catPopOver;
    NSString * dateString;
    
    
    
    //used to scroll completeView.......
    UIScrollView *stockIssueScrollView;
    
    
    //used to take customerInputs selection.......
    CustomTextField *currentLocationTxt;
    CustomTextField *shipmentRefNoTxt;
    CustomTextField *issueDateTxt;
    
    CustomTextField *toStoreCodeTxt;
    CustomTextField *issuedByTxt;
    CustomTextField *carriedByTxt;
    
    CustomTextField *requestRefNoTxt;
    CustomTextField *reqeustDateTxt;
    CustomTextField *requestedByTxt;
    
    CustomTextField *shipmentModeTxt;
    CustomTextField *pickUpByTxt;
    CustomTextField *deliveredDateTxt;
    CustomTextField *multipleIssuesTxt;
    
    CustomTextField * searchItemsTxt;
    UITextField * issueQtyText;
    UITextField * balanceQtyTxt;
    UITextField * scanCodeText;

    //Used on TopOfTable.......
    CustomLabel  *sNoLbl;
    CustomLabel  *skuIdLbl;
    CustomLabel  *descriptionLbl;
    CustomLabel  *uomLbl;
    CustomLabel  *rangeLbl;
    CustomLabel  *gradeLbl;
    CustomLabel  * priceLabel;
    CustomLabel  *requestedQtyLabel;
    CustomLabel  *scanCodeLabel;
    CustomLabel  *stockQtyLbl;
    CustomLabel  *issueQtyLbl;
    CustomLabel  *balanceQtyLbl;
    CustomLabel  *make_Lbl;
    CustomLabel  *actionLbl;

    
    
    
    //added by Srinivasulu on 14/04/2017....
//    UILabel  * availableQtyLbl;
    
    //upto here on 14/04/2017....
    

    //UITableView .......
    UITableView * requestedItemsTbl;
    NSMutableArray *requestedItemsInfoArr;
    
    NSMutableArray * productList;
    UITableView  *  productListTbl;
    
    
    NSMutableArray * locationArr;
    UITableView * locationTable;
    
    NSMutableArray  * shipModesArr;
    UITableView * shipModeTable;
    
    NSMutableArray * requestRefId;
    UITableView * reqRefTable;

    
    //used to move the scrollView.......
    UIView * adjustableView;
    
    //used for calcuation part.......
    UILabel *totalIssuesValueLbl;
    UILabel *totalSaleCostValueCost;

    /**creating UIButton*/
    UIButton *submitBtn;
    UIButton * saveBtn;
    UIButton *cancelBtn ;

    UILabel * userAlertMessageLbl;
    NSTimer * fadeOutTime;

    //used to move the view when keyboard appear.......
    float offSetViewTo;
    
    bool reloadTableData;
    
    
// views requried for price view
    
    NSMutableArray * priceDic;
    
    UIButton * closeBtn;
    UIView * priceView;
    UIView *transparentView;
    UITableView * priceTable;
    
    UILabel * descLabl;
    UILabel * mrpLbl;
    UILabel * priceLbl;
    
    UIButton * selectCategoriesBtn;
    NSMutableArray * categoriesArr;
    UITableView * categoriesTbl;
    UIView * categoriesView;
    UIPopoverController *categoriesPopOver;
    
    //used to check and uncheck the check boxes...
    NSMutableArray * checkBoxArr;
    UIButton * selectAllCheckBoxBtn;
    UIButton * checkBoxsBtn;
    
    //Used  to display the multiple store locations....
    //Added  0n 13/07/2017 By Bhargav
    UIView   * multipleStoresTransparentView;
    UIView   * multipleIssuesView;
    UIButton * locationCloseBtn;
    NSMutableArray * locationCheckBoxArr;
    
   
    //item Level Value Labels....
    UILabel * priceValueLbl;
    UILabel * stockQtyValueLbl;
    UILabel * issueQtyValueLbl;
    UILabel * balanceQtyValueLbl;
    
    UIButton * viewListOfItemsBtn;
    
    //Used on TopOfTable.......
    UIView         * requestedItemsTblHeaderView;
    UITableView    * itemsListTableView;
    NSMutableArray * itemsListArr;
    
    NSMutableArray * locationWiseItemArr;
    NSMutableDictionary * multipleIssueDic;
    
    NSMutableArray *  isPacked;

     BOOL isDraft;
}
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;
@property (strong, nonatomic) NSString * IssueId;

@property (assign)BOOL isOpen;
@property (nonatomic,retain)NSIndexPath *selectIndex;
@property (nonatomic,retain)NSIndexPath * selectSectionIndex;


@end
