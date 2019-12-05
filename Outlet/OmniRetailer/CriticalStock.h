
//  ViewWareHouseCompleteStock.h
//  OmniRetailer
//
//  Created by Bhargav.v . V on 3/30/17.

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

@interface CriticalStock : CustomNavigationController <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UITextViewDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate,MBProgressHUDDelegate,GetScrapStockDelegate,OutletMasterDelegate,ModelMasterDelegate,utilityMasterServiceDelegate,SalesServiceDelegate,ZoneMasterDelegate,GetSKUDetailsDelegate,SkuServiceDelegate , SupplierServiceSvcDelegate> {

     float version;
    int selectedRowNo;
    //used to store the device Orientation.......
    UIDeviceOrientation currentOrientation;
    
    
    //used for HUD..(processing bar).......
    MBProgressHUD *HUD;
    
    //used to create completeView.....
    UIView *normalStockVeiw;
    
    //used to show the add the header labels under the scrolll view...
    
    UIScrollView * stockScrollView;
    
    //used in to show header....
    UILabel *headerNameLbl;
    
    
    //used to show sideView....
    UIView *transparentView;
    UIView *sideMenu;
    UITableView *sideMenuTable;
    NSMutableArray *sidemenuTitles;
    NSString * typeOfStock;
    NSMutableArray *sidemenuImages;
    
    UITapGestureRecognizer *tap;
    
    
    //used to take customerInputs selection.......
    //used in first column....
    CustomTextField * categoryTxt;
    CustomTextField * subCategoryTxt;
    
    //used in second column....
    CustomTextField * departmentTxt;
    CustomTextField * subDepartmentTxt;
    
    //used in third column....
    CustomTextField * brandTxt;
    CustomTextField * modelTxt;
    //
    CustomTextField * startDteTxt;
    CustomTextField * endDteTxt;
    
    //
    CustomTextField * sectionTxt;
    CustomTextField * supplierTxt;
    
    CustomTextField * zoneTxt;
    CustomTextField * locationTxt;
    
    
    //used in searching items....
    CustomTextField * searchItemsTxt;
    NSString *searchString;

    //used for all popUp's....
    UIPopoverController *catPopOver;
    
    //this are used for dispalying warning message....
    UILabel *userAlertMessageLbl;
    NSTimer *fadOutTime;
    
    //used to move the self.view when keyboard appear's.....
    float offSetViewTo;
   
    int totalRecords;
    int totalQuantity;
    
    
    //Used for Displaying the soreageUnits.....
    UITableView * departmentListTbl;
    NSMutableArray * departmentListArr;
    
    NSMutableDictionary *dept_SubDeptDic;
    
    //Used for Displaying the soreageUnits.....
    UITableView * subDepartmentListTbl;
    NSMutableArray * subDepartmentListArr;
    
    //Used for Displaying the soreageUnits.....
    UITableView * categoriesListTbl;
    NSMutableArray * categoriesListArr;
    
    //    NSMutableDictionary *cat_SubCatDic;
    
    //Used for Displaying the soreageUnits.....
    UITableView * subCategoriesListTbl;
    NSMutableArray * subCategoriesListArr;
    
    //Used for Displaying the soreageUnits.....
    UITableView * brandsTbl;
    NSMutableArray * brandsArr;
    
    
    UITableView * supplierListTbl;
    NSMutableArray * supplierListArr;
    
    UITableView * modelTable;
    NSMutableArray * modelListArr;
    
    UITableView * sectionTbl;
    NSMutableArray * sectionArr;
    
    
    UITableView * locationTable;
    NSMutableArray * locationArr;
    NSMutableOrderedSet * zoneListArr;
    NSMutableDictionary * zoneWiseLocationDic;
    
    
    
    //used o dispaly dynamic table header label's....
    UIView * tableLabelsHeaderView;
    
    //used to display the entire content in the table....
    UITableView * commonDisplayTbl;
    NSMutableArray * commonDisplayArr;

    NSMutableArray * locationWiseCategoriesArr;
    NSMutableArray * locationWiseBrandsArr;
    
    
    //used in service calls....
    int startIndexNumber;

    BOOL isBoneYard;
    
    NSArray * labelSidesArr;
    
    UIButton * searchBtn;
    
    
    UIView *pickView;
    UIDatePicker *myPicker;
    NSString *dateString;
    
    
    //UIView to display the totalInventory cost and totalQuantity...
    UIView * totalInventoryView;
    UIView * totalInventoryView_1;
    
    UILabel * totalQtyValuelbl;
    UILabel * totalInventoryValueLbl;
    
    // Added By Bhargav.v on 21/10/2017..
    
    CustomTextField * pagenationTxt;
    NSMutableArray * pagenationArr;
    UITableView * pagenationTbl;
    
    UILabel * packQtyValueLbl;
    UILabel * stockQtyValueLbl;
    UILabel * stockValueLbl;
    UILabel * closePackQtyValueLbl;
    UILabel * closeStockQtyValueLbl;
    
    //Added By Bhargav.v on 13/12/2017...
    
    UIView * skuTransparentView;
    
    UIView * skuDetailsView;
    UIImageView * productImageView;
    NSMutableArray * skuListsArr;
    UITextView * descriptionView;
    
    UILabel * itemDescriptionLbl;
    UILabel * itemSkuValueLabel;
    UILabel * measureRangeValueLbl;
    UILabel * styleValueLbl;
    UILabel * sizeValueLbl;
    UILabel * colorValueLbl;
    UILabel * patternValueLbl;
    UILabel * locationValueLbl;
    UILabel * priceValueLabel;
    UILabel * quantityValueLabel;
    UILabel * batchNoValueLabel;
    
    UITextField * itemText;
    
    NSString *outLetStoreName;
    NSString *zoneName;
    
    UIButton * previousButton;
    UIScrollView * skuVariantScrollView;
    UITableView * quantityTblView;
    NSMutableArray * quantityArr;
    
    //added on 23/01/2018 By Bhargav...
    
    UIButton * cartBtn;
    NSMutableArray * CartItemsArray;
    BOOL highlighted;
    UIButton * nextButton;

}


//porperties for sound file objects....
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property (nonatomic,retain) NSString * selectedStockTypeStr;
@property (nonatomic,retain) NSString * serviceCallStr;
@property (nonatomic,retain) NSIndexPath * selectIndex;



@end
