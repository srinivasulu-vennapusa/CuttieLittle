//
//  VoidItemsReport.h
//  OmniRetailer
//
//  Created by Bhargav.v on 8/28/17.
//
//

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"
#import "CustomNavigationController.h"
#import "CustomTextField.h"
#import "CustomLabel.h"
#import "WebServiceController.h"

@interface VoidItemsReport : CustomNavigationController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate,SalesServiceDelegate,OutletMasterDelegate,utilityMasterServiceDelegate,ModelMasterDelegate,SkuServiceDelegate>{
    
    //to get the device version.......
    float version;
    
    //allocating the int value...
    
    int startIndexInt;
    int totalNumberOfReports;
    
    //used to store the device Orientation.......
    UIDeviceOrientation currentOrientation;
    
    
    //used for HUD..(processing bar).......
    MBProgressHUD *HUD;

    //used to create completeView.....
    UIView * voidItemsReportView;
    
    
    //used to take customerInputs selection.....
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
    
    //used for items scrollView....
    UIScrollView * voidItemsScrollView;
    
    //used as table header....
    CustomLabel * sNoLbl;
    CustomLabel * dateTimeLbl;
    CustomLabel * userNameLbl;
    CustomLabel * categoryLbl;
    CustomLabel * subCatLbl;
    CustomLabel * sectionLbl;
    CustomLabel * departmentLbl;
    CustomLabel * locationLbl;
    CustomLabel * zoneLbl;
    CustomLabel * skuIdLbl;
    CustomLabel * descriptionLbl;
    CustomLabel * eanLbl;
    CustomLabel * voidItemQtyLbl;
    CustomLabel * originalPriceLbl;
    
    UIButton * searchBtn;
    
    UITextField * searchItemsTxt;
    
    UITableView * voidItemsTbl;
    
    UITableView * categoriesListTbl;
    UITableView * subCategoriesListTbl;
    UITableView * departmentListTbl;
    UITableView * subDepartmentListTbl;
    UITableView * brandListTbl;
    UITableView * sectionTbl;
    UITableView * modelTbl;
    UITableView * classTbl;
    
    
    NSMutableArray * voidReportsArr;
    
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
    
    UILabel *userAlertMessageLbl;
    NSTimer *fadOutTime;
    
    //To Display the PopOver....
    UIPopoverController *catPopOver;
    
    UIView *pickView;
    UIDatePicker *myPicker;
    NSString *dateString;

    
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;

    
}

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;



@end
