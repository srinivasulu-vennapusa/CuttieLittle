//
//  SuppliesReports.h
//  OmniRetailer
//
//  Created by Sonali Maharana on 24/02/17.
//
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#include <AudioToolbox/AudioToolbox.h>
#import "CustomNavigationController.h"
#import "Global.h"
#import "OmniHomePage.h"
#import "RequestHeader.h"
#import "SuppliesReports.h"
#import "WebServiceController.h"

@interface SuppliesReports : CustomNavigationController <UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate,MBProgressHUDDelegate,UINavigationControllerDelegate,StockReceiptServiceDelegate>{
    
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    
    UITextField *fromOrder;
    UITextField *toOrder;
    //UITextField *bill;
    UITextField *counterId;
    
    
    UIScrollView *scrollView;
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
    
    NSCharacterSet *blockedCharacters;
    
    UISegmentedControl *mainSegmentedControl;
    
    float version;
    UIButton *getReportBtn;
    UILabel *cashTotalVal;
    UILabel *cardTotalVal;
    UILabel *sodexoTotalVal;
    UILabel *ticketTotalVal;
    UILabel *loyaltyTotalVal;
    UILabel *discountTotalVal;
    UILabel *totalBillAmtVal;
    UIPopoverController *catPopOver;
    
    UIView *dateWiseReportView;
    UILabel *sNo;
    UILabel *billedOn;
    UILabel *transactions;
    UILabel *totalBillAmount;
    UILabel *paidAmount;
    UILabel *amountDue;
    UILabel *totalCashAmt;
    UILabel *ticketAmtLbl;
    UILabel *discountLbl;
    UILabel *voucherTotal;
    UILabel *couponTotal;
    UILabel *creditNote;
    UILabel *creditTotal;
    UILabel *totalCostLbl;
    int reportStartIndex ;
    int totalRecordsInt;

    
}
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property(nonatomic,strong)UITextField *fromOrder;
@property(nonatomic,strong)UITextField *toOrder;
@property(nonatomic,strong)UITextField *bill;
@property(nonatomic,strong)UITableView *salesTableView;

-(void) callingSalesServiceforRecords;

@end
