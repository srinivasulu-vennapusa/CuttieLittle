//
//  MailView.h
//  OmniRetailer
//
//  Created by Satya Siva Saradhi on 16/10/12.
//  Copyright 2012 __techolabssoftware.com__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>

@interface MailView : UIView <UITextFieldDelegate> {
    
    UITextField *mailTxt;
    UITextField *pswdTxt;
    UITextField *hostTxt;
    //UITextField *portTxt;
    
    UIView *StatusView;
    
    CFURLRef		soundFileURLRef;
	SystemSoundID	soundFileObject;
}

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property (nonatomic, strong)UITextField *mailTxt;
@property (nonatomic, strong)UITextField *pswdTxt;
@property (nonatomic, strong)UITextField *hostTxt;
//@property (nonatomic, retain)UITextField *portTxt;


- (void) closeMailView:(id) sender;

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;

@end
