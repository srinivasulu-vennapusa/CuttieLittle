//
//  PaymentView.h
//  OmniRetailer
//
//  Created by Satya Siva Saradhi on 22/10/12.
//  Copyright 2012 __techolabssoftware.com__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>

@interface PaymentView : UIView <UITextFieldDelegate>{
    
    UITextField *usrTxt;
    UITextField *pswTxt;
    
    UIView *StatusView;
    
    CFURLRef		soundFileURLRef;
	SystemSoundID	soundFileObject;
}
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property (nonatomic, strong)UITextField *usrTxt;
@property (nonatomic, strong)UITextField *pswTxt;

- (void) closePaymentView:(id) sender;

@end
