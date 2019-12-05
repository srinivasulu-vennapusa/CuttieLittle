//
//  ServiceConfigView.h
//  OmniRetailer
//
//  Created by Satya Siva Saradhi on 22/10/12.
//  Copyright 2012 __techolabssoftware.com__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>

#import "PopOverViewController.h"
#import "MBProgressHUD.h"

@interface ServiceConfigView : UIView <UITextFieldDelegate,NSURLConnectionDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,MBProgressHUDDelegate>{//UIPopoverControllerDelegate
   
    UITextField *domainTxt;
    UITextField *portTxt;
    

    UIView * StatusView;
    
    CFURLRef		soundFileURLRef;
	SystemSoundID	soundFileObject;
    
    
    UITextField * serviceProtocolTxt;
    UIPopoverController * popOver;
    UITableView * protocolListTbl;
    NSArray * protocolListArr;

    MBProgressHUD * testHUD;
}
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property (nonatomic, strong)UITextField * domainTxt;
@property (nonatomic, strong)UITextField * portTxt;
//@property (nonatomic, retain)UITextField *usrTxt;
//@property (nonatomic, retain)UITextField *pswTxt;


- (void) closeServiceConfigView:(id) sender;


@end
