//
//  SalemenCommissionReport.h
//  OmniRetailer
//
//  Created by TLMac on 9/18/17.
//
//

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"
#import "CustomNavigationController.h"
#import "CustomTextField.h"
#import "CustomLabel.h"
#import "WebServiceController.h"
#import "CountersServiceSvc.h"


@interface SalemenCommissionReport : CustomNavigationController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate,SalesServiceDelegate, EmployeeServiceDelegate, CounterServiceDelegate>{
 
    // device Orientation (LandScape).......
    UIDeviceOrientation currentOrientation;
    
    //Device Version...
    float version;
    
    // Sound File Object...
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;

 
    //intialising the value as 0...
    int startIndexInt;
    int totalNumberOfReports;

    //creation Of progress Bar....
    MBProgressHUD * HUD;

    
    //creation of NSMuatbleArray....
    NSMutableArray * salesManCommissionArr;
    
   
    //Creation Of CustomTextFields...
    CustomTextField * startDateTxt;
    CustomTextField * endDateTxt;
    
    CustomTextField *  locationTxt;
    CustomTextField *  salesperonTxt;
    CustomTextField *  counterTxt;
    
    //Creation  Custom Labels
    
    CustomLabel * snoLbl;
    CustomLabel * salesmanNameLbl;
    CustomLabel * salesmenIdLbl;
    CustomLabel * bussinessDateLbl;
    CustomLabel * shiftIdLbl;
    CustomLabel * counterIdLbl;
    CustomLabel * transactionCountLbl;
    CustomLabel * quantityLbl;
    CustomLabel * amountLbl;
    CustomLabel * averagQtyTxnLbl;
    CustomLabel * averageAmountTxnLbl;
    
   //Allocation of UIView(salesmenReportView)..
    
    UIView *  salesmenReportView;
    UIScrollView * salemenReportScrollView;
    UITableView * salesmenReportTbl;
 
    //this are used for dispalying warning message....
    UILabel * userAlertMessageLbl;
    NSTimer * fadOutTime;
    
    UIPopoverController * catPopOver;
    UIView * pickView;
    UIDatePicker * myPicker;
    NSString * dateString;

    //Creation of UIButton...
    UIButton * goButton;
    UIButton * searchBtn;
    
    NSMutableArray * employeeIdsArr;
    NSMutableArray * couterIdArr;
    UITableView * salesPersonIdTbl;
    UITableView * counterIDTbl;
    
    
    UIView * totalsalesmenReportView;
    
    UILabel * totalQtyValueLbl;
    UILabel * totalAmtValueLbl;
    UILabel * totalTxnValueLbl;
    
    NSString * salesPersonIdStr;
    
}




@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;


@end
