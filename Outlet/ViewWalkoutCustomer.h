//  Created by Bhargav Ram on 10/6/16.
//
//



#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "CustomNavigationController.h"
#import "WebServiceController.h"
#import "MBProgressHUD.h"
#import "RequestHeader.h"


@interface ViewWalkoutCustomer : CustomNavigationController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,CustomerWalkOutDelegate,OutletMasterDelegate,MBProgressHUDDelegate > {
  
    MBProgressHUD *HUD;
    UIView * viewWalkout;
    UIView * pickView;
    UIPopoverController *catPopOver;
    UIDatePicker * myPicker;

    UILabel * sNoLbl;
    UILabel * cstmrName;
    UILabel * cstmrMoble;
    UILabel * date;
    UILabel * inTime;
    UILabel * outTime;
    UILabel * departmnt;
    UILabel * walkoutRsn;
    UILabel * action;
    
    
    UITextField * departmentFld;
    UITextField * brandFld;
    UITextField * strtDteFld;
    UITextField * endDteFld;
    
   UITableView * viewWalkOutTbl;
    UITableView * deprtmntTbl;
    UITableView * brandTbl;

    UIButton * selctDprtmnt;
    UIButton * selctBrand;
    UIButton * selctStrtDte;
    UIButton * selectEndDte;
    UIButton * newBtn;
    UIButton * viewBtn;
    
    NSMutableArray * walkoutLIstArr;
    NSMutableArray * brandListArr;
    NSMutableArray * departmentArr;
    NSString *dateString;
    
    //moved from .h to .m by srinivasulu on 02/08/2018.. due to errors..
    float version;
    int startIndexint_;
}

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@end
