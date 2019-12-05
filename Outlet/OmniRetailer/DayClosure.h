//
//  DayClosure.h
//  OmniRetailer
//
//  Created by Technolabs on 8/10/18.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"
#import "CustomTextField.h"
#import "CustomLabel.h"
#import "WebServiceController.h"
#import "CustomNavigationController.h"
#import "RequestHeader.h"
#import "PopOverViewController.h"


@interface DayClosure : CustomNavigationController<MBProgressHUDDelegate,UITextFieldDelegate,DayOpenServiceDelgate> {
  
    //Creating the processing bar...
    MBProgressHUD * HUD;
    
    //to get the device version.......
    float version;
    float offSetViewTo;

    //used to store the device Orientation.......
    UIDeviceOrientation currentOrientation;

    //UIView to Design the complete specified UI ...
    UIView * dayClosureView;
    
    UILabel * loginNameLabel;
    UILabel * locationLabel;

    UILabel * dateLabel;
    UILabel * dateValueLabel;
    
    UILabel * declaredCashValueLabel;
    UILabel * separationLabel;
    
    UIView * declaredAmountView;
    UIView * denominationView;
    
    UITextField    * denomValueTxt;
    UITextField    * declaredDenomValueTxt;
    NSMutableArray * denomValTxtArr;
    NSMutableArray * denomCountArr;
    NSMutableArray * denomValCoinsTxtArr;
    NSMutableArray * denomCountCoinsArr;
    NSMutableDictionary * denominationCoinDic;
    
    int tensCount;
    int oneCount;
    
    UILabel *tenValue;
    UILabel *oneValue;

    CustomTextField *tensQty;
    CustomTextField *oneQty;

    UIScrollView  * denomScrollView;

    UILabel * userAlertMessageLbl;
    NSTimer * fadeOutTime;

}
@property (readwrite)    CFURLRef        soundFileURLRef;
@property (readonly)    SystemSoundID    soundFileObject;


@end
