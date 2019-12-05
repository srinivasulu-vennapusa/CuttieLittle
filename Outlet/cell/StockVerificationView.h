//
//  StockVerificationView.h
//  OmniRetailer
//
//  Created by Sonali on 7/16/16.
//
//

#import <UIKit/UIKit.h>
#import "WebServiceConstants.h"
#import "WebServiceController.h"
#import "CustomNavigationController.h"
#include <AudioToolbox/AudioToolbox.h>
#include "MBProgressHUD.h"
#import "Global.h"
#import "CriticalStock.h"
#import "RequestHeader.h"
#import "VerifiedStockReceipts.h"

@interface StockVerificationView : CustomNavigationController<MBProgressHUDDelegate,StockVerificationSvcDelegate,OutletMasterDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    UILabel *label_1;
    UILabel *label_2;
    UILabel *label_3;
    UILabel *label_4;
    UILabel *label_5;
    UILabel *label_6;
    UIScrollView *salesDetailsView;
    UITableView *salesDetailsTable;
    NSMutableArray *salesDetailsArray;
    NSMutableArray *purchaseDetailsArray;
    MBProgressHUD *HUD;
    BOOL stockReportScrollStatus;
    UILabel *dataStatus;
    int serialNo;
    
//    summmary Details view
    
    
    UIButton * viewBtn;
    UIPopoverController * detailsViewPopOver;
    UIPopoverController * catPopOver;
    UIView * detailsView;
    UIView * pickView;
    UIDatePicker * myPicker;
    NSString * dateString;
    
    
    UILabel * snoLabel;
    UILabel * categoryLabel;
    UILabel * skuidLabel;
    UILabel * dateLabel;
    UILabel * dumpQtyLbl;
    UILabel * costPriceLbl;
    UILabel * costValLbl;
    UILabel * salePriceLbl;
    UILabel * saleValueLbl;
    
    
//    Header View
    
    UILabel * headerLbl;
    
    
    UITextField * startDateTxt;
    UITextField * endDateTxt;
    UITextField * brandTxt;
    UITextField * categoryTxt;
    UITextField * subCatTxt;
    UITextField * modelTxt;
    
    NSMutableArray * summaryInfoArr;
    NSMutableArray * categoriesArr;
    NSMutableArray * subCategoryArr;
    NSMutableArray * brandListArr;
    
    NSMutableDictionary * categoryAndSubcategoryInfoDic;
    UITableView * detailsTbl;
    UITableView * categoriesTbl;
    UITableView * subcategoriesTbl;
    UITableView * brandTbl;
    
    NSString *verificationCodeStr;
    
    int requestStartNumber;
    int totalRecords;
    
    //moved from .h to .m by srinivasulu on 02/08/2018.. due to errors..

    int requiredVerifiedRecords;
    int stockVerifiedStartIndex;
}
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@end
