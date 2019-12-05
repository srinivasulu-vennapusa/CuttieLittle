//
//  CustomerWalkOut.h
//  OmniRetailer
//
//  Created by Bhargav Ram on 10/6/16.
//
//



#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "CustomNavigationController.h"
#import "WebServiceController.h"
#import "MBProgressHUD.h"
#import "RequestHeader.h"


@interface CustomerWalkOut :  CustomNavigationController<MBProgressHUDDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,CustomerWalkOutDelegate,OutletMasterDelegate,sizeAndColorsDelegate, CustomerServiceDelegate> {
    
    UIView * walkOutView;
    UIView * pickView;
    UIDatePicker *myPicker;
    
    UIScrollView * scrollView;
    
    UIPopoverController *catPopOver;
    
    MBProgressHUD *HUD;
    

    
    
    
    UILabel * phoneLbl;
    UILabel * firstNameLbl;
    UILabel * emailLbl;
    UILabel * lastNameLbl;
    UILabel * professionLbl;
    UILabel * ageLbl;
    UILabel * dobLbl;
    UILabel * genderLbl;
    UILabel * verticalLbl;
    UILabel * streetLbl;
    UILabel * localityLbl;
    UILabel * cityLbl;
    UILabel * pinLbl;
    UILabel * departmentLbl;
    UILabel * brandLbl;
    UILabel * colour;
    UILabel * size;
    UILabel * categoryLbl;
    UILabel * priceRngLbl;
    UILabel * horiaontalLbl;
    
    UILabel * brandLbl1;
    UILabel * colorLbl1;
    UILabel * sizeLbl1;
    UILabel * dlvryDteLbl;
    UILabel * horizntal1;
    UILabel * custmerRjections;
    UILabel * custmrRqrment;
    UILabel * reasonLbl;
    UILabel * inTimeLbl;
    UILabel * outTimeLbl;
    
    
    
    UITextField * phoneNoFld;
    UITextField * firstNameFld;
    UITextField * emailFld;
    UITextField * lastNameFld;
    UITextField * profsnlFld;
    UITextField * ageFld;
    UITextField * dobFld;
    UITextField * genderFld;
    UITextField * streetFld;
    UITextField * localityFld;
    UITextField * cityFld;
    UITextField * pinFld;
    UITextField * deprtmntFld;
    UITextField * brandFld;
    UITextField * colourFld;
    UITextField * sizeFld;
    UITextField * categoryFld;
    UITextField * priceFld;
    UITextField * brandFld1;
    UITextField * colorFld1;
    UITextField * sizeFld1;
    UITextField * dlvryDteFld;
    UITextField * reasonFld;
    UITextField * inTimeFld;
    UITextField * outTimeFld;
    
    UIButton * submitBtn;
    UIButton * cancelButton;
    UIButton * dobBtn;
    UIButton * brandBtn;
    UIButton * inTmeBtn;
    UIButton  * ageBttn;
    
    
    NSMutableArray * genderArr;
    NSMutableArray * categoriesArr;
    NSMutableArray * departmentArr;
    NSMutableArray * brandListArr;
    NSMutableArray * reasonArr;
    NSMutableArray * ageArr;
    
    UITableView  *   genderTbl;
    UITableView  *   categoryTbl;
    UITableView  *   deprtmntTbl;
    UITableView  *   brandTbl;
    UITableView  *   reasonTbl;
    UITableView  *   ageTbl;
    
    NSString * walkout;
    
    
    NSMutableArray *colorArr;
    NSMutableArray *sizeArr;
    UITableView *sizeTbl;
    UITableView  *colorTbl;
    
    
    float version;

    
}

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@end


