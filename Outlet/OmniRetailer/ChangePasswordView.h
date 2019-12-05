//
//  ChangePasswordView.h
//  OmniRetailer
//
//  Created by Satya Siva Saradhi on 22/10/12.
//  Copyright 2012 __techolabssoftware.com__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>
#import "WebServiceController.h"
#import "MBProgressHUD.h"


@interface ChangePasswordView : UIView<UITextFieldDelegate,MBProgressHUDDelegate,MemberServiceDelegate> {
    
    UITextField *currentPswdTxt;
    UITextField *PswdTxt;
    UITextField *confPswdTxt;
    
    CFURLRef		soundFileURLRef;
	SystemSoundID	soundFileObject;
    
    MBProgressHUD *HUD;
    
}

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property (nonatomic, strong)UITextField *currentPswdTxt;
@property (nonatomic, strong)UITextField *PswdTxt;
@property (nonatomic, strong)UITextField *confPswdTxt;

- (void) closeChangePasswordView:(id) sender;

@end
