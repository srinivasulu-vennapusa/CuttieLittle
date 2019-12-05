//
//  SalesPriceOverrideReport.h
//  OmniRetailer

//  Created by Bhargav.v on  on 9/15/17.


#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"
#import "CustomNavigationController.h"
#import "CustomTextField.h"
#import "CustomLabel.h"
#import "WebServiceController.h"



@interface SalesPriceOverrideReport : CustomNavigationController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate,SalesServiceDelegate,OutletMasterDelegate,utilityMasterServiceDelegate> {
    
    
    // device Orientation (LandScape).......
    UIDeviceOrientation currentOrientation;
    
    //Device Version...
    float version;
    int startIndexInt;
    int totalNumberOfReports;
    
    // Sound File Object...
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    
    //creation Of progress Bar....
    MBProgressHUD * HUD;
    
    //creation of UIView (OverrideReportView)....
    UIView * overrideReportview;
    
    //Allocation Of UIScrollView...
    UIScrollView * overrideSalesScrollView;
    
    //Creation Of CustomTextFields...
    
    CustomTextField * zoneTxt;
    CustomTextField * counterTxt;

    CustomTextField * categoryTxt;
    CustomTextField * subCategoryTxt;
    CustomTextField * departmentTxt;
    CustomTextField * subDepartmentTxt;
    CustomTextField * sectionTxt;
    CustomTextField * startDateTxt;
    CustomTextField * endDateTxt;

    //Creation of UIButton...
    UIButton * goButton;
    
    //Creation Of CustomLabels....
    CustomLabel * snoLbl;
    CustomLabel * dateLbl;
    CustomLabel * skuiDLbl;
    CustomLabel * descriptionLbl;
    CustomLabel * categoryLbl;
    CustomLabel * subCategoryLbl;
    CustomLabel * sectionLbl;
    CustomLabel * departmentLbl;
    CustomLabel * soldQtyLbl;
    CustomLabel * originalPriceLbl;
    CustomLabel * editedPriceLbl;
    CustomLabel * totalSaleCostLbl;
    CustomLabel * locationLbl;
    CustomLabel * cashierNameLbl;
    

    //cration of UIButton...
    
    UITableView * salesPriceOverrideTbl;
    NSMutableArray * overrideSalesArr;
    
    UIView  * totalOverrideSalesView;
    UILabel * totalQuantityValueLbl;
    UILabel * totalPriceValueLbl;
    
    
    
    UIPopoverController * catPopOver;
    UIView *pickView;
    UIDatePicker *myPicker;
    NSString *dateString;
    
    
    //this are used for dispalying warning message....
    UILabel * userAlertMessageLbl;
    NSTimer * fadOutTime;
    
    //Allocation of UIButton...
     UIButton * searchBtn;
     UITextField * searchItemsTxt;

    UITableView * categoriesListTbl;
    UITableView * subCategoriesListTbl;
    UITableView * departmentListTbl;
    UITableView * sectionTbl;
    NSMutableArray * categoriesListArr;
    NSMutableArray * subCategoriesListArr;
    NSMutableArray * departmentArr;
    NSMutableArray * sectionArr;
}

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@end
