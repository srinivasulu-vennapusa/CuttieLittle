//
//  BillSummary.h
//  OmniRetailer
//
//  Created by Sonali on 06/02/17.
//
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#include <AudioToolbox/AudioToolbox.h>
#import "NTChartView.h"
#import "CustomNavigationController.h"
#import "CustomTextField.h"
#import "CustomLabel.h"
#import "WebServiceController.h"

@interface BillSummary : CustomNavigationController <UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate,MBProgressHUDDelegate,UINavigationControllerDelegate, SalesServiceDelegate>{
    
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    
    //used to store the device Orientation.......
    UIDeviceOrientation currentOrientation;
    
    MBProgressHUD *HUD;
    
    UIView *billWiseReportView;
   
    CustomTextField *startDateTxt;
    
    UIScrollView *scrollView;
    
    CustomLabel * snoLbl;
    CustomLabel * billIDLbl;
    CustomLabel * totalAmtLbl;
    CustomLabel * cashAmtLbl;
    CustomLabel * cardAmtLbl;
    CustomLabel * returnedAmtLbl;
    CustomLabel * exchangedAmtLbl;
    CustomLabel * sodexoAmtLbl;
    CustomLabel * tickectAmtLbl;
    CustomLabel * creditNoteLbl;
    CustomLabel * giftVouchersLbl;
    CustomLabel * creditsAmtLbl;
    CustomLabel * actionLbl;
    
    UITableView *salesTableView;
    
    UIButton * viewButton;
    
    UIView * totalBillsView;
    UILabel * totalBillValueLbl;
    
    
    
//    NSMutableArray *item;
//    NSMutableArray *date;
//    NSMutableArray *transactions_;
//    NSMutableArray *totalAmount;
    
    UILabel *searchCriterialable;
    
    UIButton  *fromOrderButton;
    UIButton  *toOrderButton;
    UIButton *selectCounter;
    UITableView *counterTable;
    
    UIView *pickView;
    UIDatePicker *myPicker;
    UILabel *tag;
    NSString *dateString;
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
    
    NTChartView *v;
    float version;
    UIButton *getReportBtn;
    UILabel *rec_Start;
    UILabel *rec_End;
    UILabel *rec_total;
    int changeID ;
    NSArray *counterIds;
    int reportStartIndex;
    int totalRecordsInt;
    
//    UILabel *sNo;
//    UILabel *billedOn;
//    UILabel *transactions;
//    UILabel * totalBillAmount;
//    UILabel *totalCashAmt;
//    UILabel *paidAmount;
//    UILabel *amountDue;
//    UILabel *ticketAmtLbl;
//    UILabel *voucherTotal;
//    UILabel *couponTotal;
//    UILabel *creditNote;
//    UILabel *creditTotal;
//    UILabel *totalCostLbl;
//    UILabel *loyaltyPoints;
}
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property(nonatomic,strong)UITextField *fromOrder;
@property(nonatomic,strong)UITextField *toOrder;
@property(nonatomic,strong)UITextField *bill;
@property(nonatomic,strong)UITableView *salesTableView;
@property(nonatomic,strong)NSString *dateStr;

-(void) callingSalesServiceforRecords;
@property(nonatomic,strong) NSString *counterIdStr;
@end
