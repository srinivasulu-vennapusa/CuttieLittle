//
//  SkuWiseReport.h
//  OmniRetailer
//
//  Created by technolans on 16/02/17.
//
//

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"
#import "CustomNavigationController.h"
#import "CustomTextField.h"
#import "CustomLabel.h"
#import "WebServiceController.h"

@interface SkuWiseReport :CustomNavigationController <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,OutletMasterDelegate,utilityMasterServiceDelegate,ModelMasterDelegate,SkuServiceDelegate, SalesServiceDelegate> {
    
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    
    float version;
    
    UIView * skuWiseReportView;
    
    //used in to show header....
    UILabel * headerNameLbl;

    UILabel *location;
    UITextField *locationText;
    UIButton *locationBtn;
    UIImage *locationBtnImage;
    NSMutableArray * dateArr;
    
    UILabel *startDate;
    UIButton *startOrderButton;
    UIImage *startImageDate;
    
    UILabel *endDate;
    UIButton *endOrderButton;
    UIImage *endImageDate;
    
    UIView * totalReportsView;
    UILabel *totalReportsValueLbl;
   
    
    //Creation of CustomTextFields...
    CustomTextField * categoryTxt;
    CustomTextField * subCategoryTxt;
    CustomTextField * departmentTxt;
    CustomTextField * subDepartmentTxt;
    CustomTextField * brandTxt;
    CustomTextField * sectionTxt;
    CustomTextField * startDateTxt;
    CustomTextField * endDateTxt;
    CustomTextField * modelTxt;
    CustomTextField * classTxt;

    //added by Saikrishna Kumbhoji as on 03/08/2017.........
   // UILabel *categoryLbl;
    UIButton *categoryButton;
    UIImage *categoryImage;
    
   // UILabel *subCategoryLbl;
    UIButton *subCategoryButton;
    UIImage *subCategoryImage;
    
   // UILabel *departmentLbl;
    UIButton *departmentButton;
    UIImage *departmentImage;
    
   // UILabel *subDepartmentLbl;
    UIButton *subDepartmentButton;
    UIImage *subDepartmentImage;
    
   // UILabel *brandLbl;
    UIButton *brandButton;
    UIImage *brandImage;
    
   // UILabel *sectionLbl;
    UIButton *sectionButton;
    UIImage *sectionImage;
    
    CustomTextField *searchFieldTxt;
    
    //Used for Displaying the soreageUnits.....
    UITableView * categoryTbl;
    NSMutableArray * categoryArr;
    
    UITableView * subCategoryTbl;
    NSMutableArray * subCategoryArr;
    
    UITableView * departmentTbl;
    NSMutableArray * departmentArr;
    
    UITableView * subDepartmentTbl;
    NSMutableArray * subDepartmentArr;
    
    NSMutableDictionary *dept_SubDeptDic;
    
    UITableView * brandTbl;
    NSMutableArray * brandArr;
    
    UITableView * sectionTbl;
    NSMutableArray * sectionArr;
    
    UITableView * modelTbl;
    NSMutableArray * modelListArr;
    
    UITableView * classTbl;
    NSMutableArray * classArr;
    
    int requestStartNumber;
    NSMutableArray * stockRequestInfoArr;
    NSMutableArray * requestedItemsInfoArr;
    
    
    //upto here as on 03/08/2017...........
    UIButton * generateReport;
    //added by Saikrishna Kumbhoji as on 04/08/2017.........
    UIButton * cancelBtn;
    
    //upto here as on 04/08/2017............
    
    CustomLabel *slno;
    CustomLabel *skuId;
    CustomLabel *itemDes;
    
    //added the below labels by Saikrishna Kumbhoji on 01/08/2017.....
    CustomLabel *ean;
    CustomLabel *colour;
    CustomLabel *size;
    CustomLabel *grade;
    CustomLabel *model;
    CustomLabel *category;
    CustomLabel *subCategory;
    CustomLabel *section;
    CustomLabel *brand;
    
    UIScrollView * horizontalScrollView;
    //upto here as on 01/08/2017.........
    UILabel *price;
    UILabel *soldQty;
    //added by Saikrishna Kumbhoji on 02/08/2017........
    UILabel *returnQty;
    UILabel *exchangeQty;
    
    UILabel *totalSoldQty;
    UILabel *totalSoldValue;
    
    UILabel *totalSoldQty_1;
    UILabel *totalSoldValue_1;
    
    //upto here as on 02/08/2017.......
    UILabel *totalSale;
    
   UITableView *skuReportTable;
    MBProgressHUD *HUD;
    NSMutableArray *skuWiseArr;
    
    NSMutableArray *counterArray;

    
    UITableView *counterTable;
    //added by Saikrishna Kumbhoji as on 05/08/2017.......
    
    //this are used for dispalying warning message....
    
    UILabel *userAlertMessageLbl;
    NSTimer *fadOutTime;
    
    BOOL *didTableDataEditing;
    float offSetViewTo;
    NSString *searchString;
    int startIndexNumber;
    
    //upto here as on 05/08/2017.......
    
    
    UIPopoverController *catPopOver;
    UIView *pickView;
    UIDatePicker *myPicker;
    NSString *dateString;
    UIButton *selectCounter;
    UIScrollView *scrollView;
    
    
    
    //----for calling responce------//
    
    
    CustomTextField *counterId;
    int reportStartIndex;
     NSMutableArray *item;
    int totalRecordsInt;
     

        
}

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property(nonatomic,strong)UITextField *bill;
@property(nonatomic,strong)UITableView *skuReportTable;
@property(nonatomic,strong)NSString *dateStr;



@end
