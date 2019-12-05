//
//  VerifiedStockReceipts.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 9/14/15.
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
#import "PopOverViewController.h"

@interface VerifiedStockReceipts : CustomNavigationController<MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    UILabel *label_1;
    UILabel *label_2;
    UILabel *label_3;
    UILabel *label_4;
    UILabel *label_5;
    UILabel *label_6;
    UILabel *label_7;
    UILabel *label_8;
    UILabel *label_9;
    UILabel *label_10;
    UILabel *label_11;
    UILabel *label_12;
    UILabel *label_13;
    UILabel *label_14;
    UILabel *label_15;
    UILabel *label_16;
    UILabel *label_17;
    UIScrollView *salesDetailsView;
    UITableView *salesDetailsTable;
    NSMutableArray *salesDetailsArray;
    NSMutableArray *purchaseDetailsArray;
    MBProgressHUD *HUD;
    BOOL stockReportScrollStatus;
    UILabel *dataStatus;
    int serialNo;
    UIAlertView *sucess;
    UIButton  *writeOffBtn;
    UIButton  *closeBtn ;
    NSString *approvedBy;
    UITextField *searchCriteria;
    NSArray *searchOptionsArr;
    UITextField *searchTxt;
    UIPopoverController *catPopOver;
    UITableView *searchCriteriaTbl;
    
    //moved from .h to .m by srinivasulu on 02/08/2018.. due to errors..

    int requiredVerifiedRecords;
    int stockVerifiedStartIndex;
}
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;
@property(atomic,strong) NSString *verficationCodeStr;
@end
