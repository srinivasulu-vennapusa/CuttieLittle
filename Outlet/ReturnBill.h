//
//  ReturnBill.h
//  OmniRetailer
//
//  Created by Bhargav Ram on 11/16/16.
//
//


#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "CustomNavigationController.h"
#import "WebServiceController.h"
#import "MBProgressHUD.h"



@interface ReturnBill : CustomNavigationController<MBProgressHUDDelegate,GetBillsDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate> {
    
    
    float version;
    
    MBProgressHUD *HUD;
    UIDeviceOrientation  currentOrientation;
    UIView * returnBillView;
    
    
    UITextField * returnBillField;
    UITextField * startDateField;
    UITextField * endDateField;
    UITextField * userMobileNoFld;

    UILabel * SnoLbl;
    UILabel * BillIdLbl;
    UILabel * dateLbl;
    UILabel * counterLbl;
    UILabel * userNameLbl;
    UILabel * billDueLbl;
    
    UITableView * returnBillIdTbl;
    UITableView * billIdsTbl;
    
    int  totalNumberOfRecords;
    NSString *saleId;
    
    
    UIDatePicker * myPicker;
    UIView *pickView;
    UIPopoverController *catPopOver;
    NSString * dateString;


    NSMutableArray * returnBillIdsArr;
    NSMutableArray * filteredSkuArrayList;
    NSMutableArray * salesIdArray;
    UIButton * submitBtn;
    
    //added by Srinivasulu on 08/06/2017....
    //this are used for dispalying warning message....
    UILabel *userAlertMessageLbl;
    NSTimer *fadOutTime;
    
    
    //added by Srinivasulu on 07/08/2017....
    
    UIScrollView * itemsScrollView;
    
    UILabel * billAmountLbl;
    UILabel * syncStatusLbl;
    
    //upto here on 07/08/2017....
    
    //added by Srinivasulu on 17/10/2017....
    
    UILabel * billDoneModeLbl;
    
    //upto here on 17/10/2017....
    
    
    // Added by Bhargav.v on 20/02/2018....
    
    CustomTextField * pagenationTxt;
    NSMutableArray  * pagenationArr;
    UITableView  * pagenationTbl;
    
    UIView  *totalRecordsView;
    UILabel *totalRecordsValueLabel;
}


@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;


@end
