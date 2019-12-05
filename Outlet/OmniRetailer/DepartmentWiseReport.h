//  DepartmentWiseReport.h
//  OmniRetailer

//  Created by Bhargav.v on 9/22/17.

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"
#import "CustomNavigationController.h"
#import "CustomTextField.h"
#import "CustomLabel.h"
#import "WebServiceController.h"

@interface DepartmentWiseReport :CustomNavigationController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate,OutletMasterDelegate,utilityMasterServiceDelegate, SalesServiceDelegate> {
 
    //    New frame Design By Bhargav.v on 07/08/2017
    
    //used to store the device Orientation.......
    UIDeviceOrientation currentOrientation;
    
    //
    float version;
    int reportStartIndex;
    int totalRecordsInt;
    MBProgressHUD * HUD;
    
    UIView * departmentWiseReportView;
    UIView * totalReportsView;
    
    //Creation of CustomTextFields...
    
    CustomTextField * zoneTxt;
    CustomTextField * locationTxt;
    CustomTextField * categoryTxt;
    CustomTextField * subCategoryTxt;
    CustomTextField * departmentTxt;
    CustomTextField * subDepartmentTxt;
    CustomTextField * brandTxt;
    CustomTextField * sectionTxt;
    CustomTextField * startDateTxt;
    CustomTextField * endDateTxt;

    
    
    //Creation of UIButton...
    UIButton * searchBtn;
    
    
    //UIScrollView
    
    UIScrollView * departmentWiseScrollView;
    
   //Creation Of CustomLabel
    
    
    CustomLabel * snoLbl;
    CustomLabel * dateLbl;
    CustomLabel * categoryLbl;
    CustomLabel * subCategoryLbl;
    CustomLabel * sectionLbl;
    CustomLabel * departmentLbl;
    CustomLabel * departmentDescLbl;
    CustomLabel * quantityLbl;
    CustomLabel * totalSaleLbl;
    
    
    NSMutableArray * departmentWiseArr;
    UITableView    * departmentWiseTbl;
    
    //this are used for dispalying warning message....
    UILabel * userAlertMessageLbl;
    NSTimer * fadOutTime;
    
    //UILabels Used for Displaying the totalValues....
    UILabel * quantityValueLbl;
    UILabel * totalSaleValueLbl;
    
    UITableView    * categoriesListTbl;
    UITableView    * subCategoriesListTbl;
    UITableView    * departmentListTbl;
    UITableView    * subDepartmentListTbl;
    UITableView    * brandListTbl;
    UITableView    * sectionTbl;
    
    NSMutableArray * categoriesListArr;
    NSMutableArray * subCategoriesListArr;
    NSMutableArray * departmentArr;
    NSMutableArray * subDepartmentArr;
    NSMutableArray * brandListArray;
    NSMutableArray * sectionArr;
    
    NSMutableDictionary * dept_SubDeptDic;
   
    UIPopoverController * catPopOver;
    UIView * pickView;
    UIDatePicker * myPicker;
    NSString * dateString;

}


@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;


@end
