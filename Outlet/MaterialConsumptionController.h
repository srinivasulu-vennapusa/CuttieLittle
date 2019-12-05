//
//  MaterialConsumptionController.h
//  OmniRetailer
//
//  Created by Bhargav on 2/24/17.
//
//


#import "CustomNavigationController.h"
#import "MBProgressHUD.h"
#import <AudioToolbox/AudioToolbox.h>
#import "WebServiceUtility.h"
#import "WebServiceConstants.h"
#import "WebServiceController.h"
#import "RequestHeader.h"
#import "CustomTextField.h"
#import <QuartzCore/QuartzCore.h>
#import "PopOverViewController.h"

@interface MaterialConsumptionController : CustomNavigationController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate,BomMasterSvcDelegate>{
  
    
    //to get the device version.......
    float version;
    int startIndexInt;
    
    
//    creation of UIView for the calendar popOver
    
    UIView * pickView;
    UIDatePicker * myPicker;
    UIPopoverController *catPopOver;
    NSString * dateString;
    UIButton * goButton;
    
    //used to store the device Orientation.......
    UIDeviceOrientation currentOrientation;
    
    
    //used for HUD..(processing bar).......
    MBProgressHUD *HUD;
    
    
//    creation of UIView
    
    UIView * materialConsumptionView;
    UITextField * startDateTxt;
    UITextField * endDateTxt;
    
 
//    creation of UILables:
    
    UILabel * snoLbl;
    UILabel * itemCodeLbl;
    UILabel * itemDescLbl;
    UILabel * uomLbl;
    UILabel * CategoryLbl;
    UILabel * unitPriceLbl;
    UILabel * soldQtyLbl;
    UILabel * totalSaleLbl;
    UILabel * actionLbl;
    
    
    UITableView * consumptionTbl;
    
    
    NSMutableArray * materialConsumptionArr;
    NSMutableArray * BomChildsArr;
    UIButton * viewChildBtn;
    
    NSMutableArray *BornChildsArr;
    
    int totalRecordsInt;
    
}


@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;





@end
