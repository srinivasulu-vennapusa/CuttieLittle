//
//  ExchangeBill.h
//  OmniRetailer
//
//  Created by Bhargav Ram  on 17/11/16.
//
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "CustomNavigationController.h"
#import "WebServiceController.h"
#import "MBProgressHUD.h"
#import "CustomTextField.h"



@interface ExchangeBill : CustomNavigationController<MBProgressHUDDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,GetBillsDelegate> {
    
    float version;
    int  totalNumberOfRecords;
    int exchange_bill_no;
    
    MBProgressHUD *HUD;
    UIDeviceOrientation  currentOrientation;
    UIView * exchangeBillView;
    
    UIDatePicker * myPicker;
    UIView *pickView;
    UIPopoverController *catPopOver;
    NSString * dateString;
    
    
    UITextField * exchangeBillField;
    CustomTextField * startDateField;
    CustomTextField * endDateField;
    CustomTextField * userMobileNoFld;
    
    UIButton * submitBtn;
    
    UILabel * SnoLbl;
    UILabel * BillIdLbl;
    UILabel * dateLbl;
    UILabel * counterLbl;
    UILabel * userNameLbl;
    UILabel * billDueLbl;
    
    UITableView * exchangeBillTbl;
    NSMutableArray * exchangeBillArr;
    
    NSString *saleId;
    NSMutableArray * returnBillIdsArr;
    NSMutableArray * filteredSkuArrayList;
    NSMutableArray * salesIdArray;
    UITableView * billIdsTbl;

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

    UIView * totalRecordsView;
    UILabel * totalRecordsValueLabel;

    
    
}

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;


@end
