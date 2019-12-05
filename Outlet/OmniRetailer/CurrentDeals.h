//
//  CurrentDeals.h
//  OmniRetailer
//
//  Created by Bangaru.Raju on 11/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellView_Deals.h"
#import "MBProgressHUD.h"
#include <AudioToolbox/AudioToolbox.h>
#import "WebServiceController.h"
#import "CustomNavigationController.h"
#import "CustomTextField.h"
#import "CustomLabel.h"

@interface CurrentDeals : CustomNavigationController <MBProgressHUDDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,GetAllDealsDelegate,SkuServiceDelegate,OutletMasterDelegate,utilityMasterServiceDelegate, ModelMasterDelegate,ZoneMasterDelegate> {
   
    //used for HUD..(processing bar).......
    MBProgressHUD * HUD;
    
    //to get the device version.......
    float version;
    int   startIndex;
    int   totalDeals;
    
    //used to store the device Orientation.......
    UIDeviceOrientation currentOrientation;

    
    //Cration Of UIView....
    
    UIView * dealsView;
    
    //used to take customerInputs selection.......
   
    //used in first column....
    CustomTextField * zoneTxt;
    CustomTextField * locationTxt;
   
    //used in second column....
    CustomTextField * categoryTxt;
    CustomTextField * subCategoryTxt;
    
    //used in third column....
    CustomTextField * departmentTxt;
    CustomTextField * subDepartmentTxt;
    
   
    //used in fourth column....
    CustomTextField * startDteTxt;
    CustomTextField * endDteTxt;
    
    //used in fifth column....
    CustomTextField * modelTxt;
    CustomTextField * statusTxt;
    
    
    //Creation of UIButton To make the Service call for Filter Purpose....
    UIButton * searchBtn;
    
    //To Search Deal IDs And The Created Information....
    CustomTextField * dealIDsTxt;
    
    //To Display the the number of Records based on the pagenation (Making a service call for Every 10 Records)....
    CustomTextField * pagenationTxt;
    
    //Creation of UIScrollView for the Header Lables...
    //Reason: fileds might be increased in future as per specification and scope related Changes...
    
    UIScrollView * dealsScrollView;
    
    //Creation of CustomLabels...
    CustomLabel * snoLabel;
    CustomLabel * dealIdsLabel;
    CustomLabel * descriptionLabel;
    CustomLabel * startDateLabel;
    CustomLabel * endDateLabel;
    CustomLabel * statusLabel;
    CustomLabel * itemGroupLabel;
    CustomLabel * dealTypeLabel;
    CustomLabel * saleQtyLabel;
    CustomLabel * saleValueLabel;
    
    
    
    UILabel * userAlertMessageLbl;
    NSTimer * fadOutTime;

    //used for all popUp's....
    UIPopoverController  * catPopOver;
    
    //Creation of UITable View....
    UITableView * currentDealsTable;

    UITableView * categoriesListTbl;
    UITableView * subCategoriesListTbl;
    UITableView * departmentListTbl;
    UITableView * subDepartmentListTbl;
    UITableView * modelTable;
    UITableView * statusTable;
    UITableView * pagenationTbl;
    
    //Used for Displaying the soreageUnits.....
    
    NSMutableArray * dealDetailsArray;

    NSMutableArray * locationWiseCategoriesArr;
    NSMutableArray * subCategoriesListArr;
    
    NSMutableArray * departmentListArr;
    NSMutableArray * subDepartmentListArr;
    
    NSMutableDictionary * dept_SubDeptDic;
    
    NSMutableArray * modelListArr;
    NSMutableArray * statusArr;
    
    NSMutableArray * pagenationArr;

    
    // Using it for Calenndar...
    UIView *pickView;
    UIDatePicker *myPicker;
    NSString *dateString;
    
    
    // Deal Details View...
    
    UIView *  transperentView;
    
    UIView * dealDetailsView;
    
    UILabel * dealNameValueLabel;
    UILabel * createdOnValueLabel;
    UILabel * dealStatusValueLabel;
    
    UITextField * startDateText;
    UITextField * endDateText;
    UITextField * startTimeText;
    UITextField * endTimeText;
    
    
    UITextField * rewardTypeText;
    UITextField * rewardCriteriaText;
    UITextField * startPriceText;
    
    UITextField * minimumQtyText;
    UITextField * minAmtText;
    UITextField * endPriceText;
    
    UITextField * rewardValueText;
    UITextField * rangeModeText;
    
    UILabel * skuidLabel;
    UILabel * productDescriptionLabel;
    UILabel * eanLabel;
    UILabel * rangeLabel;
    UILabel * mrpLabel;
    UILabel * salePriceLabel;
    
    bool isDealsSummary;
    
    NSMutableArray * dealIdDetailsArray;
    
    UITableView * locationsTable;
    NSMutableArray * locationArr;
    
    UITableView * itemDetailsTable;
    NSMutableArray * itemDetailsArr;
    
    
    
    
    
    
    
    
    
    
    

}

@property (readwrite)CFURLRef		soundFileURLRef;
@property (readonly)SystemSoundID	soundFileObject;


@end


