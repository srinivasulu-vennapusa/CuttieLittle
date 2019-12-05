//
//  Configuration.h
//  OmniRetailer
//
//  Created by Satya Siva Saradhi on 11/10/12.
//  Copyright 2012 __techolabssoftware.com__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigCellView.h"
#include <AudioToolbox/AudioToolbox.h>

@interface Configuration : UIViewController <UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate> {
    
    CFURLRef		soundFileURLRef;
	SystemSoundID	soundFileObject;
    
    UITableView* configTable;
    
    NSMutableArray* listofConfigArray;
    
    NSMutableArray* imagesforListArray;
    
    IBOutlet ConfigCellView *configCell;
    
    // Creating Objects for required views
    UIView *barcodeView;
    UIView *mailView;
    UIView *smsView;
    UIView *paymentView;
    UIView *serviceConfigView;
    UIView *printerConfigView;
    UIView *changePasswordView;
    UIView *ftpConfigurationView;
    
    float version;

    
}

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@end
