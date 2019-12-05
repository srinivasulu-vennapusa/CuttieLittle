//
//  SmsProviderView.h
//  OmniRetailer
//
//  Created by Satya Siva Saradhi on 22/10/12.
//  Copyright 2012 __techolabssoftware.com__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>

@interface SmsProviderView : UIView <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {

    CFURLRef		soundFileURLRef;
	SystemSoundID	soundFileObject;
    
    UITableView* smsProviderTable;
    NSMutableArray* listofProvidersArray;
    
    UITextField *usrTxt;
    UITextField *pswTxt;
    //UITextField *providerType;
    
    UILabel *providerlabel;
    
    UIView *StatusView;
   
}
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property (nonatomic, strong)UITableView* smsProviderTable;
@property (nonatomic, strong)NSMutableArray* listofProvidersArray;
@property (nonatomic, strong)UITextField *usrTxt;
@property (nonatomic, strong)UITextField *pswTxt;
@property (nonatomic, strong)UITextField *providerType;

- (void) closeSMSView:(id) sender;

@end
