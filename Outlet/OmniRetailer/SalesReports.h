//
//  OrderReports.h
//  OmniRetailer
//
//  Created by Bangaru.Raju on 11/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#include <AudioToolbox/AudioToolbox.h>
#import "NTChartView.h"
#import "CustomNavigationController.h"
#import "BillSummary.h"
#import "CountersServiceSvc.h"
#import "CustomLabel.h"
#import "WebServiceController.h"


@interface SalesReports : CustomNavigationController <UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate,MBProgressHUDDelegate, EmployeeServiceDelegate, CounterServiceDelegate, SalesServiceDelegate>{
    
    CFURLRef		soundFileURLRef;
	SystemSoundID	soundFileObject;
    
    //used to store the device Orientation.......
    UIDeviceOrientation currentOrientation;
    
    MBProgressHUD * HUD;

    float version;

    UIView * dateWiseReportView;

    
    //Creation of Custom TextFields...
    
    CustomTextField * startDateTxt;
    CustomTextField * endDateTxt;
    CustomTextField * counterIDTxt;
    CustomTextField * salesPersonTxt;
    
    CustomLabel * snoLbl;
    CustomLabel * dateLbl;
    CustomLabel * totalBillsLbl;
    CustomLabel * soldQtyLbl;
    CustomLabel * cashTotalLbl;
    CustomLabel * cardTotalLbl;
    CustomLabel * returnAmntLbl;
    CustomLabel * exchangeAmntLbl;
    CustomLabel * sodexoTotlLbl;
    CustomLabel * ticketTotlLbl;
    CustomLabel * loyaltyClaimLbl;
    CustomLabel * creditNoteLbl;
    CustomLabel * discountLbl;
    CustomLabel * giftVouchersLbl;
    CustomLabel * couponsLbl;
    CustomLabel * creditsAmntLbl;
    CustomLabel * creditSalesLbl;
    CustomLabel * dayTurnOverLbl;
    CustomLabel * actionLbl;
    
    //Creation of UIButton for filter purpose..
    UIButton * goButton;
    UIButton * viewButton;
    UIButton * searchBtn;
    

    UIScrollView *scrollView;
    UITableView  *salesTableView;
    UITableView  *counterIDTbl;
    UITableView  *salesPersonIdTbl;
    
    UILabel * soldQtyValueLbl;
    UILabel * cashTotalValueLbl;
    UILabel * cardTotalValueLbl;
    UILabel * returnedAmtValueLbl;
    UILabel * exchangeAmtValueLbl;
    UILabel * sodexoAmtvalueLbl;
    UILabel * ticketTotalValueLbl;
    UILabel * loyaltyValueLbl;
    UILabel * creditNoteValueLbl;
    UILabel * discountValueLbl;
    UILabel * giftVouchersValueLbl;
    UILabel * couponsValueLbl;
    UILabel * creditAmtValueLbl;
    UILabel * creditSalesValueLbl;
    UILabel * dayTurnOverValueLbl;
    
    UIView  * totalReportsView;
    UILabel * totalReportsValueLbl;
    
    //this are used for dispalying warning message....
    UILabel * userAlertMessageLbl;
    NSTimer * fadOutTime;

    
    UIView *pickView;
    UIDatePicker *myPicker;
    UILabel *tag;
    NSString *dateString;
    
    
    NSMutableArray *dateWiseArr;
    NSMutableArray *couterIdArr;
    NSMutableArray * employeeIdsArr;

    UIPopoverController *catPopOver;
    


}
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property(nonatomic,strong)UITextField *fromOrder;
@property(nonatomic,strong)UITextField *toOrder;
@property(nonatomic,strong)UITextField *bill;
@property(nonatomic,strong)UITableView *salesTableView;

-(void) callingSalesServiceforRecords;

@end
