//
//  PastBillsList.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 11/18/16.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "CustomNavigationController.h"
#import "WebServiceController.h"
#import "MBProgressHUD.h"
#import "CustomTextField.h"

@interface PastBillsList : CustomNavigationController<MBProgressHUDDelegate,GetBillsDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate> {
    
    float version;
    
    MBProgressHUD *HUD;
    UIDeviceOrientation  currentOrientation;
    UIView * pastBillView;

    UIDatePicker * myPicker;
    UIView *pickView;
    UIPopoverController *catPopOver;
    NSString * dateString;

    
    
    
    UITextField * pastBillField;
    CustomTextField * startDateField;
    CustomTextField * endDateField;
    CustomTextField * userMobileNoFld;
    
    UILabel * sNoLbl;
    UILabel * billIdLbl;
    UILabel * dateLbl;
    UILabel * counterLbl;
    UILabel * userNameLbl;
    UILabel * billDueLbl;
    
    NSMutableArray * pastBillsArr;
    UITableView * pastBillsTbl;

    NSMutableArray * filteredSkuArrayList;
    NSMutableArray * salesIdArray;
    UITableView * salesIdTable;
    
    int  totalNumberOfRecords;
    NSString *saleId;
    UIButton * submitBtn;
    
    
    //added by Srinivasulu on 08/06/2017....
    //this are used for dispalying warning message....
    UILabel *userAlertMessageLbl;
    NSTimer *fadOutTime;
    
    //added by Srinivasulu on 12/07/2017....
    UIScrollView * itemsScrollView;
    
    UILabel * syncStatusLbl;

    //added by Srinivasulu on 06/08/2017....

    UILabel * billAmountLbl;

    //upto here on 06/08/2017....
 
    //added by Srinivasulu on 16/10/2017....
    
    UILabel * billDoneModeLbl;
    
    //upto here on 16/10/2017....
    
    
    //Added by Bhargav.v on 20/02/2018....
    
    CustomTextField * pagenationTxt;
    NSMutableArray  * pagenationArr;
    UITableView  * pagenationTbl;
    UIView * totalRecordsView;
    UILabel * totalRecordsValueLabel;
    
    //upto here on 20/02/2018....
}


@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;


@end
