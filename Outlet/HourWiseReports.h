//
//  HourWiseReports.h
//  OmniRetailer
//
//  Created by Saikrishna Kumbhoji on 08/09/2017..
//
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "CustomNavigationController.h"
#import "CustomTextField.h"
#import "CustomLabel.h"
#import "WebServiceController.h"
#include <AudioToolbox/AudioToolbox.h>
#include "MBProgressHUD.h"

@interface HourWiseReports : CustomNavigationController<UITextFieldDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,SalesServiceDelegate>{


    
    //Creation of Progress Bar
    MBProgressHUD * HUD;
    
    //UI Device Orientiation
    UIDeviceOrientation currentOrientation;
    
    //Supported Version
    float version;
    int startIndexInt;
    int totalNumberOfReports;

    //creation of hourWiseReportView...
    UIView * hourWiseReportView;
    
    //creation of totalReportsView...
    UIView * totalReportsView;
    UILabel *totalReportsValueLbl;
    

    UIButton * searchBtn;
    UIButton * clearBtn;
    UIButton * goButton;
    CustomTextField * startDateTxt;
    CustomTextField * endDateTxt;
    
    //upto here as on 04/08/2017............
    
    CustomLabel * slnoLbl;
    CustomLabel * dateLbl;
    CustomLabel * timeLbl;
    CustomLabel * totalBillsLbl;
    CustomLabel * cashTotalLbl;
    CustomLabel * cardTotalLbl;
    CustomLabel * returnedAmtLbl;
    CustomLabel * exchangeAmtLbl;
    CustomLabel * sodexoTotalLbl;
    CustomLabel * ticketTotalLbl;
    CustomLabel * loyaltyTotalLbl;
    CustomLabel * creditNoteLbl;
    CustomLabel * giftVouchersLbl;
    CustomLabel * couponsLbl;
    CustomLabel * totalCostLbl;
    
    //added by Srinivasulu on 09/11/2017....
    
    CustomLabel * averageQuantityLbl;
    CustomLabel * averageValueLbl;
    
     UILabel * averageQuantityValueLbl;
     UILabel * averageSoledValueLbl;
    
    //upto here on 09/11/2017....
    
    UIScrollView * headerScrollView;

    UITableView * hourReportTable;
    
    NSMutableArray * hourWiseReportArr;
    
    UILabel * cashTotalValueLbl;
    UILabel * cardTotalValueLbl;
    UILabel * returnedAmtValueLbl;
    UILabel * exchangeAmtValueLbl;
    UILabel * sodexoTotalValueLbl;
    UILabel * ticketTotalValueLbl;
    UILabel * loyalityValueLbl;
    UILabel * creditNoteValueLbl;
    UILabel * giftVoucherValueLbl;
    UILabel * couponsValueLbl;
    UILabel * totalCostValueLbl;
    
    
    
    
    //this are used for dispalying warning message....
    
    UILabel *userAlertMessageLbl;
    NSTimer *fadOutTime;
    
    //upto here as on 05/08/2017.......
    
    UIPopoverController *catPopOver;
    UIView *pickView;
    UIDatePicker *myPicker;
    NSString *dateString;
    UIButton *selectCounter;
    UIScrollView *scrollView;
    
    //----for calling responce------//
    
    // Adding sound property...
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
}


@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property(nonatomic,strong)UITextField *bill;
@property(nonatomic,strong)UITableView *skuReportTable;
@property(nonatomic,strong)NSString *dateStr;

@end
