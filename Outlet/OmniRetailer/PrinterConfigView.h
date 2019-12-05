//
//  PrinterConfigView.h
//  OmniRetailer
//
//  Created by Satya Siva Saradhi on 22/10/12.
//  Copyright 2012 __techolabssoftware.com__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>

@interface PrinterConfigView : UIView <UITextFieldDelegate>{
    
    UITextField *ipTxt;
    UITextField *portTxt;
    
     UIView *StatusView;
    
    CFURLRef		soundFileURLRef;
	SystemSoundID	soundFileObject;
}

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property (nonatomic, strong)UITextField *ipTxt;
@property (nonatomic, strong)UITextField *portTxt;

- (void) closePrinterConfigView:(id) sender;


@end
