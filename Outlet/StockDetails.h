
//  StockDetails.h
//  OmniRetailer
//  Created by Technolabs
//  Created by Bhargav.v on 5/15/18.

#import <UIKit/UIKit.h>
#import "CustomNavigationController.h"
#import "CustomTextField.h"
#import "WebServiceConstants.h"
#import "WebServiceController.h"
#import "Global.h"
#import "CustomLabel.h"

#include <AudioToolbox/AudioToolbox.h>
#include "MBProgressHUD.h"


@interface StockDetails:CustomNavigationController<MBProgressHUDDelegate,GetStockLedgerReport,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,SalesServiceDelegate>{

    //Creation of Progress Bar...
    MBProgressHUD * HUD;
    
    //UI Device Orientiation....
    UIDeviceOrientation currentOrientation;
    
    //Supported Version...
    float version;
    
    //allocation of UIView....
    UIView * stockDetailsView;

    //creation of CustomTextFields...
    CustomTextField * skuidTxt;
    CustomTextField * productDescTxt;
    CustomTextField * eanTxt;
    CustomTextField * uomTxt;
    CustomTextField * categoryTxt;
    CustomTextField * subCategoryTxt;
    CustomTextField * departmentTxt;
    CustomTextField * subDepartmentTxt;
    CustomTextField * classTxt;
    CustomTextField * subClassTxt;
    CustomTextField * sizeText;
    CustomTextField * colorText;
    
    //Creation of UISegmentedControl....
    UISegmentedControl * segmentedControl;
    UIScrollView *stockDetailsScrollView;
    UITableView * stockDetailsTbl;


    //creation od CustomLabels....
    
    CustomLabel * snoLbl;
    CustomLabel * dateLbl;
    CustomLabel * soldQtyLbl;
    CustomLabel * returnQtyLbl;
    CustomLabel * exchangeQtyLbl;
    CustomLabel * transferredQtyLbl;
    CustomLabel * stockReceiptsLbl;
    CustomLabel * stockReturnLbl;
    CustomLabel * grnQtyLbl;
    CustomLabel * dumpQtyLbl;
    CustomLabel * netStockLbl;

    UILabel * soldQtyValueLbl;
    UILabel * returnQtyValueLbl;
    UILabel * exchangeQtyValueLbl;
    UILabel * transferredQtyValueLbl;
    UILabel * stockReceiptsValueLbl;
    UILabel * stockReturnQtyValuLbl;
    UILabel * grnQtyValueLbl;
    UILabel * dumpQtyValueLbl;
    UILabel * netStockValueLbl;

    //this are used for dispalying warning message....
    UILabel *userAlertMessageLbl;
    NSTimer *fadeOutTime;

    NSMutableArray * salesDetailsArray;
    NSMutableArray * dailyStockArray;
    
    BOOL callServiceCall;
    int totalNoOfRecords;
    int dailyStockTotalNoOfRecords;
    
    int startIndexInt;
    int dailyStockIndexInt;
    
    //Added on 14/05/2018 by Bhargav.v....
    
    UIView * itemTrackerView;
    UITableView * itemTrackerTable;
    NSMutableArray * itemTrackerListArray;
    CustomLabel * itemTrackSnoLabel;
    CustomLabel * itemTrackIdLabel;
    


}

@property (readwrite)    CFURLRef        soundFileURLRef;
@property (readonly)    SystemSoundID    soundFileObject;

@property (nonatomic,retain)NSMutableDictionary * stockDetailsDic;


@end
