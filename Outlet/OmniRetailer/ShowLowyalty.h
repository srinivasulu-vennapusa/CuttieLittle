//
//  ShowLowyalty.h
//  OmniRetailer
//
//  Created by Bangaru.Raju on 1/3/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ZBarSDK.h"
#include <AudioToolbox/AudioToolbox.h>
//#import "ZXingWidgetController.h"
#import "CustomNavigationController.h"
#import "MBProgressHUD.h"
#import "WebServiceController.h"

@interface ShowLowyalty : CustomNavigationController<UITextFieldDelegate, MBProgressHUDDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, LoyaltycardServicesDelegate> {
    
    CFURLRef		soundFileURLRef;
	SystemSoundID	soundFileObject;
    
    UIView *showLoyaltyView;
    UITextField *loyaltyNumtxt;
    
    UILabel *username;
    UILabel *phNo;
    UILabel *email;
    UILabel *idType;
    UILabel *validFrom;
    UILabel *validThru;
    UILabel *availPoints;
    UILabel *amount;
    UILabel *label;
    
    UILabel *usernameData;
    UILabel *phNoData;
    UILabel *emailData;
    UILabel *idNo;
    UILabel *validFromData;
    UILabel *validThruData;
    UILabel *pointsData;
    UILabel *amountData;
    
    UIButton *barcodeBtn;
    UIButton *submitBtn;
    
    MBProgressHUD* HUD;
    
    NSCharacterSet *blockedCharacters;

    int count;
}

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@end


