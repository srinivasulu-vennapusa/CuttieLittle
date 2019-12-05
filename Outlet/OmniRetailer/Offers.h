//
//  PastDeals.h
//  OmniRetailer
//
//  Created by Bangaru.Raju on 11/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CellView_Deals.h"
#import "MBProgressHUD.h"
#include <AudioToolbox/AudioToolbox.h>
#import "CustomNavigationController.h"
#import "CustomTextField.h"
#import "CustomLabel.h"
#import "WebServiceController.h"
@interface Offers : CustomNavigationController <MBProgressHUDDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,OffersMasterDelegate,SkuServiceDelegate,OutletMasterDelegate,utilityMasterServiceDelegate, ModelMasterDelegate> {
    
    //used for HUD..(processing bar).......
    MBProgressHUD * HUD;
    
    //to get the device version.......
    float version;
    int offerIndex;
    int totalOffers;

    bool isOffersSummary;

    //used to store the device Orientation.......
    UIDeviceOrientation currentOrientation;
    
    
    //Cration Of UIView....
    
    UIView * offersView;
    
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
    CustomTextField * searchOffersText;
    
    //To Display the the number of Records based on the pagenation (Making a service call for Every 10 Records)....
    CustomTextField * pagenationTxt;
    
    //Creation of UIScrollView for the Header Lables...
    //Reason: fileds might be increased in future as per specification and scope related Changes...
    
    UIScrollView * dealsScrollView;
    
    //Creation of CustomLabels...
    CustomLabel * snoLabel;
    CustomLabel * offerIdsLabel;
    CustomLabel * descriptionLabel;
    CustomLabel * startDateLabel;
    CustomLabel * endDateLabel;
    CustomLabel * statusLabel;
    CustomLabel * itemGroupLabel;
    CustomLabel * offerTypeLabel;
    CustomLabel * saleQtyLabel;
    CustomLabel * saleValueLabel;
    
    
    
    UILabel * userAlertMessageLbl;
    NSTimer * fadOutTime;
    
    //used for all popUp's....
    UIPopoverController  * catPopOver;
    
    //Creation of UITable View....
    UITableView * currentOffersTable;
    
    UITableView * categoriesListTbl;
    UITableView * subCategoriesListTbl;
    UITableView * departmentListTbl;
    UITableView * subDepartmentListTbl;
    UITableView * modelTable;
    UITableView * statusTable;
    UITableView * pagenationTbl;
    
    //Used for Displaying the soreageUnits.....
    
    NSMutableArray * offerDetailsArray;
    
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
  
    UIView  * transperentView;
    UIView  * offerDetailsView;
   
    UILabel * offerNameValueLabel;
    UILabel * createdOnValueLabel;
    UILabel * offerStatusValueLabel;
    
    
    
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
    
    NSMutableArray * offerIdDetailsArr;
    
    UITableView * itemDetailsTable;
    NSMutableArray * offerProductsArray;
    
    UITableView * locationsTable;
    NSMutableArray * locationsArr;
    
    
   //Exisisting Properties used to store  the offers in offline
    
   //Previuous initialization to save offers locally....
    NSMutableArray *itemNameArray;
    NSMutableArray *itemIDArray;
    NSMutableArray *OfferPriceArray;
    NSMutableArray *validFromArray;
    NSMutableArray *validToArray;
    NSMutableArray *minAmtArray;
    NSMutableArray *minQtyArray;
    NSMutableArray *giftSKUArray;
    NSMutableArray *offerDesc;
    NSMutableArray *offerValues;

    BOOL isSecondOfferServiceCal;

}
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property(nonatomic,assign)BOOL isSavingLocally;
-(NSString *)offerServiceCall:(int)startIndex isDownloading:(BOOL)isDownloading;

//- (void) searchTableView;

@end

