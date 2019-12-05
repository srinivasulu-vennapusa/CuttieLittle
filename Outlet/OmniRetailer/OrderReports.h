//
//  SalesReports.h
//  OmniRetailer
//
//  Created by Bangaru.Raju on 11/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#include <AudioToolbox/AudioToolbox.h>

@interface OrderReports : UIViewController <UITextFieldDelegate, UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,UINavigationControllerDelegate>{
    
    CFURLRef		soundFileURLRef;
	SystemSoundID	soundFileObject;
    
    UITextField *fromOrder;
    UITextField *toOrder;
    UITextField *orderBy;
    UITextField *amount;
    
    UIScrollView *scrollView;
    UITableView *orderTableView;
    
    UIButton *goButton;
    
    NSMutableArray *item;
    
    UILabel *searchCriterialable;
    
    UIButton  *fromOrderButton;
    UIButton  *toOrderButton;
    
    UIView *pickView;
    UIDatePicker *myPicker;
    UILabel *tag;
    NSString *dateString;
    
    MBProgressHUD *HUD;
    
    
    UIButton *previousButton;
    UIButton *nextButton;
    UIButton *frstButton;
    UIButton *lastButton;
    UILabel *label_2;
    UILabel *label_3;
    
    
    NSCharacterSet *blockedCharacters;
}
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property(nonatomic,strong)UITextField *fromOrder;
@property(nonatomic,strong)UITextField *toOrder;
@property(nonatomic,strong)UITextField *orderBy;
@property(nonatomic,strong)UITextField *amount;

-(void) callingOrderServiceforRecords;

@end



