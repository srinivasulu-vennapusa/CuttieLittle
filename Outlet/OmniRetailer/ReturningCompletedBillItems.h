//
//  ReturningCompletedBillItems.h
//  OmniRetailer
//
//  Created by apple on 29/01/18.
//

#import "CustomNavigationController.h"


#include <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"

#import "CustomTextField.h"

@interface ReturningCompletedBillItems : CustomNavigationController <MBProgressHUDDelegate,UITextFieldDelegate> {
    
    MBProgressHUD * HUD;

    UIDeviceOrientation currentOrientation;
    float version;
    
//    CFURLRef        soundFileURLRef;
//    SystemSoundID    soundFileObject;
    
    CustomTextField * searchItemsTxt;
    UIButton * searchBarcodeBtn;

    CustomTextField * custmerPhNum;

    float offSetViewTo;

    
}

@property (readwrite)    CFURLRef        soundFileURLRef;
@property (readonly)    SystemSoundID    soundFileObject;

@end
