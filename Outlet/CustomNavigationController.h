//
//  CustomNavigationController.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 8/17/15.
//
//

#import <UIKit/UIKit.h>

#import "UIBarButtonItem+Badge.h"
#import "UIButton+Badge.h"

#import "MBProgressHUD.h"


@interface CustomNavigationController : UIViewController <MBProgressHUDDelegate,HideTheHUDViewDelegate_>

//added by Srinivasulu on 27/04/2017....
//sonail has implemented in other project....
{
    
    UISwitch *modeSwitch;
    UIAlertView *offlineModeAlert;
    UIButton *refreshBtn;
    
    UIButton *logOutBtn;
    
    //added by Srinivasulu on 29/04/2017....
    
    UIAlertView *uploadConfirmationAlert;
    
    UIImageView *wifiView;
    
    //added by Srinivasulu on 01/05/2017....

    MBProgressHUD * SHUD;

    
    NSString *billSaveStatus;

    NSMutableArray *itemsArr;
    
    NSMutableArray *transactionArr;

    NSString *uploodedBillId;
    
    NSMutableDictionary *denominationDic;


    //upto here on 01/05/2017....
    
    //upto here on 29/04/2017....



}


//upto here on 27/04/2017....

@property (nonatomic, strong) UILabel *titleLabel;

-(void)changeOperationMode:(NSInteger)statusNo;

-(void)syncOfflinebillsToOnline:(NSInteger)statusNo;



@end
