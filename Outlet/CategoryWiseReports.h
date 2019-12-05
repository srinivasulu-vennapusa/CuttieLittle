//
//  CategoryWiseReports.h
//  OmniRetailer
//  Created by Sonali on 08/02/17.

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#include <AudioToolbox/AudioToolbox.h>
#import "CustomNavigationController.h"
#import "CustomTextField.h"
#import "WebServiceController.h"
#import "CustomLabel.h"


@interface CategoryWiseReports:CustomNavigationController <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,MBProgressHUDDelegate,UINavigationControllerDelegate,OutletMasterDelegate,utilityMasterServiceDelegate,ModelMasterDelegate,SkuServiceDelegate, SalesServiceDelegate>{
    
    
//    New frame Design By Bhargav.v on 07/08/2017
    
    //used to store the device Orientation.......
    UIDeviceOrientation currentOrientation;
    
    UIView * categoryWiseReportView;
    UIView * totalReportsView;
    
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
 
    
    //Creation of UIButton...
     UIButton * searchBtn;

    
    //Creation Of CustomLabel
    CustomLabel * snoLbl;
    CustomLabel * dateLbl;
    CustomLabel * categoryLbl;
    CustomLabel * categoryDescLbl;
    CustomLabel * subCategoryLbl;
    CustomLabel * sectionLbl;
    CustomLabel * DepartmentLbl;
    CustomLabel * quantityLbl;
    CustomLabel * totalSaleLbl;

    
    //UILabel To show the totalValue
    
    UILabel * totalReportsValueLbl;
    UILabel * totalQuantityValueLbl;
    UILabel * totalSaleValueLbl;
    
    
    
    
    //Creation Of UIScrollView...
    UIScrollView * categoryWiseScrollView;

    //Creation Of UITableView...
    UITableView  * categoryWiseTableView;
    
    UITableView * categoriesListTbl;
    UITableView * subCategoriesListTbl;
    UITableView * departmentListTbl;
    UITableView * subDepartmentListTbl;
    UITableView * brandListTbl;
    UITableView * sectionTbl;
    UITableView * modelTbl;
    UITableView * classTbl;
    
    NSMutableArray * categoriesListArr;
    NSMutableArray * subCategoriesListArr;
    NSMutableArray * departmentArr;
    NSMutableArray * subDepartmentArr;
    NSMutableArray * brandListArray;
    NSMutableArray * sectionArr;
    NSMutableArray * modelListArr;
    NSMutableArray * classArr;
    
    NSMutableDictionary * dept_SubDeptDic;
    
    //this are used for dispalying warning message....
    UILabel * userAlertMessageLbl;
    NSTimer * fadOutTime;
    
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    
    float version;

    
    UITableView *salesTableView;
    
    NSMutableArray *item;
    NSMutableArray *date;
    NSMutableArray *transactions_;
    NSMutableArray *totalAmount;
    
    UILabel *searchCriterialable;
    
    UIButton  *fromOrderButton;
    UIButton  *toOrderButton;
    UIButton *selectCounter;
    UITableView *counterTable;
    
    UIView *pickView;
    UIDatePicker *myPicker;
    UILabel *tag;
    NSString *dateString;
    MBProgressHUD *HUD;
    UIButton *goButton;
    
    UIButton *previousButton;
    UIButton *nextButton;
    UIButton *frstButton;
    UIButton *lastButton;
    UILabel *label_2;
    UILabel *label_3;
    
    NSMutableArray *dateArr;
    NSMutableArray *totalBillArr;
    NSMutableArray *counterIdArr;
    NSMutableArray *cardTotal;
    NSMutableArray *discount;
    
    NSCharacterSet * blockedCharacters;
    
    UISegmentedControl *mainSegmentedControl;
    
    UIButton *getReportBtn;
    UILabel *rec_Start;
    UILabel *rec_End;
    UILabel *rec_total;
    int changeID ;
    NSArray *counterIds;
    int reportStartIndex;
    int totalRecordsInt;
    UIPopoverController *catPopOver;
    NSMutableArray *categoriesArr;
    
    UILabel  *sNo;
    UILabel *billedOn;
    UILabel *transactions;
    UILabel *totalBillAmount;
    UILabel *paidAmount;
    UILabel *amountDue;
    UITableView *categoriesTbl;
}
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property(nonatomic,strong)UITextField *fromOrder;
@property(nonatomic,strong)UITextField *toOrder;
@property(nonatomic,strong)UITextField *bill;
//@property(nonatomic,retain)UITableView *salesTableView;
@property(nonatomic,strong)NSString *dateStr;

-(void) callingSalesServiceforRecords;

@end
