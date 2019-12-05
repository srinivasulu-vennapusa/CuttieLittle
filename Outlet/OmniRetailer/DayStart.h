//
//  DayStart.h
//  OmniRetailer

//  Created by Bhargav.v on 3/13/18.


#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"
#import "CustomTextField.h"
#import "CustomLabel.h"
#import "WebServiceController.h"
#import "CustomNavigationController.h"
#import "RequestHeader.h"
#import "PopOverViewController.h"

@interface DayStart :CustomNavigationController<MBProgressHUDDelegate,UITextFieldDelegate,DayOpenServiceDelgate> {
    
    
    //Creating the processing bar...
    MBProgressHUD * HUD;
    
    //to get the device version.......
    float version;
    
    //used to store the device Orientation.......
    UIDeviceOrientation currentOrientation;
    
    //UIView to Design the complete specified UI ...
    UIView * dayStartView;
    
    UILabel * loginNameLabel;
    UILabel * locationLabel;
    
    UILabel * dateLabel;
    UILabel * floatingCashValueLabel;
    
    UILabel * closedByValueLabel;
    
    // Denomination view to Display the Currency notes and Coins......
    UIView * denominationView;
    
    UITextField    * denomValueTxt;
    UITextField    * declaredDenomValueTxt;
    NSMutableArray * denomValTxtArr;
    NSMutableArray * denomCountArr;
    NSMutableArray * denomValCoinsTxtArr;
    NSMutableArray * denomCountCoinsArr;
    NSMutableDictionary * denominationCoinDic;
    
    float offSetViewTo;
    
    int tensCount;
    int oneCount;
    
    CustomTextField *tensQty;
    CustomTextField *oneQty;

    
    UILabel * separationLabel;
    UIScrollView  * denomScrollView;
    
    UILabel * declaredCashValueLabel;
    UILabel * openingCashValueLabel;
    
    UILabel * userAlertMessageLbl;
    NSTimer * fadeOutTime;

    UILabel *tenValue;
    UILabel *oneValue;
   
    UIAlertView * conformationAlert;
    
}


@property (readwrite)    CFURLRef        soundFileURLRef;
@property (readonly)    SystemSoundID    soundFileObject;


@end




