//
//  TaxWiseReports.h
//  OmniRetailer
//
//  Created by Bhargav Ram on 3/13/17.



#import <AudioToolbox/AudioToolbox.h>
#import "CustomNavigationController.h"
#import "PopOverViewController.h"
#import "WebServiceController.h"
#import "WebServiceConstants.h"
#import "WebServiceUtility.h"
#import "RequestHeader.h"
#import "MBProgressHUD.h"
#import <UIKit/UIKit.h>

@interface TaxWiseReports : CustomNavigationController <MBProgressHUDDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate, SalesServiceDelegate> {
    
//    Creation of Progress Bar
    
      MBProgressHUD *HUD;
    
//    UI Device Orientiation
    
      UIDeviceOrientation currentOrientation;
    
//    Supported Version
    
      float version;
    
//    creartion of UIScroll View:
    
      UIView * TaxReportsView;
      UIScrollView * TaxReportsScrollView;
      UITableView * taxReportsTbl;
    
      UITextField * endDateTxt ;
      UITextField * startDteTxt;
    
    UIButton *  goButton;
    
    NSMutableArray * taxWiseLblsArr;
    NSMutableArray * taxWiseArray;
    
    UILabel * snoLbl;
    UILabel * taxWiseLabel;
    
//    UIDatePicker
    
    UIDatePicker * myPicker;
    UIView *pickView;
    UIPopoverController *catPopOver;
    NSString * dateString;
    
    int startIndex;
    
    //this are used for dispalying warning message....
    UILabel * userAlertMessageLbl;
    NSTimer * fadOutTime;

    
}



@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;





@end
