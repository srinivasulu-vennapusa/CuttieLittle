//
//  CustomNavigationController.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 8/17/15.
//
//

#import "CustomNavigationController.h"
#import "OmniRetailerAppDelegate.h"
#import "OmniHomePage.h"
#import "BillingHome.h"

//added by Srinivauslu on 29/04/2017....

#import "DataBaseConnection.h"
#import "sqlite3.h"

#import "CustomerServiceSvc.h"


//upto here on 29/04/2017....

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController
@synthesize titleLabel;


//static sqlite3_stmt *insertStmt = nil;
//static sqlite3_stmt * deleteStmt = nil;
//static sqlite3_stmt * selectStmt = nil;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    OmniRetailerAppDelegate *tmpDelegate = (OmniRetailerAppDelegate *)[UIApplication sharedApplication].delegate;
    id myCurrentController = tmpDelegate.appController.topViewController;
    
    float version = [UIDevice currentDevice].systemVersion.floatValue;
    [self.navigationItem setHidesBackButton:YES animated:YES];
    self.navigationController.navigationBarHidden = NO;
    //self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gradient_navigation.png"]];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 600.0, 45.0)];
    titleView.backgroundColor = [UIColor clearColor];
    
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo_200.png"]];
    logoView.backgroundColor = [UIColor clearColor];
    logoView.frame = CGRectMake(0, 0.0, 45.0, 45.0);
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(55.0, -13.0,600, 70.0)];
    
    //cahnged Srinivauslu on 01/05/2017...
    //    self.titleLabel.text = @"Omni Retailer-Online";
    
    //    self.titleLabel.text = @"OMNI RETAILER-ONLINE";
    
    self.titleLabel.text = @"OMNI RETAILER";
    
    //upto here on 01/05/2017....
    self.titleLabel.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:25.0f];
    self.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25.0f];
    [titleView addSubview:logoView];
    [titleView addSubview:self.titleLabel];
    
    //added by Srinivasulu on 27/04/2017....
    
    UIView * rightView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 600.0, 45.0)];
    rightView.backgroundColor = [UIColor clearColor];
    
    rightView.tag = 2;
    
    
    //changed by Srinivasulu on 25/09/2017....
    refreshBtn = [[UIButton alloc] init];
    
    
    //refreshBtn = [[UIButton alloc] initWithFrame:CGRectMake( 300, 2, 45, 40)];
    
    //added by Srinivasulu on 25/09/2017....
    
    //    if((version == 11) && (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad))
    //    if(version == 11)
    
    if(version >= 11 && [myCurrentController isKindOfClass:[OmniHomePage class]] && refreshBtn.frame.origin.x != 50)
        refreshBtn.frame = CGRectMake( 50, 2, 45, 40);
    else
        refreshBtn.frame = CGRectMake( 300, 2, 45, 40);
    
    
    //upto here on 25/09/2017....
    
    //    [refreshBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [refreshBtn addTarget:self action:@selector(uploadLocalBills) forControlEvents:UIControlEventTouchUpInside];
    //    [refreshBtn setImage:[UIImage imageNamed:@"refresh-button-ico.png"] forState:UIControlStateNormal];
    [refreshBtn setImage:[UIImage imageNamed:@"Cloud_Sync_Color1.png"] forState:UIControlStateNormal];
    
    
    [rightView addSubview:refreshBtn];
    
    refreshBtn.badgeValue = [NSString stringWithFormat:@"%d",0];
    refreshBtn.badgeBGColor = [UIColor colorWithRed:60.0/255.0 green:179.0/255.0 blue:113.0/255.0 alpha:1.0];
    refreshBtn.badgeTextColor = [UIColor whiteColor];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        refreshBtn.badgeOriginX = 28;
        refreshBtn.badgeOriginY = -5;
        
        //added by Srinivasulu on 25/09/2017....
        
        if(version >= 11)
            refreshBtn.badgeOriginY = 0;
        
        //upto here on 25/09/2017....
        
    }
    
    
    
    wifiView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wifi-icon_Colour2.png"]];
    wifiView.backgroundColor = [UIColor clearColor];
    //    wifiView.frame = CGRectMake(refreshBtn.frame.origin.x + refreshBtn.frame.size.width + 10, 5, 30, 30);
    wifiView.frame = CGRectMake(refreshBtn.frame.origin.x + refreshBtn.frame.size.width + 70, 5, 30, 30);
    
    [rightView addSubview:wifiView];
    
    
    modeSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(wifiView.frame.origin.x + wifiView.frame.size.width + 10, 8, 45, 45)];
    [modeSwitch addTarget:self action:@selector(changeWifiSwitchAction:) forControlEvents:UIControlEventValueChanged];
    modeSwitch.onTintColor = [UIColor colorWithRed:76.0/255.0 green:217.0/255.0 blue:100.0/255.0 alpha:1.0];
    modeSwitch.tintColor = [UIColor colorWithRed:76.0/255.0 green:217.0/255.0 blue:100.0/255.0 alpha:1.0];
    
    
    //used to checking calls....
    modeSwitch.tag = 4;
    
    //    [modeSwitch setOnImage:[UIImage imageNamed:@"wifi_off.png"]];
    //    [modeSwitch setOffImage:[UIImage imageNamed:@"wifi_on.png"]];
    
    [modeSwitch setOn:YES];
    [rightView addSubview:modeSwitch];
    
    if (isOfflineService) {
        
        [modeSwitch setOn:false];
        
        modeSwitch.tintColor = [UIColor redColor];
        modeSwitch.layer.cornerRadius = 16;
        modeSwitch.backgroundColor = [UIColor redColor];
        
        wifiView.image = [UIImage imageNamed:@"wifi-icon_Colour1.png"];
        
        
    }
    
    logOutBtn = [[UIButton alloc] initWithFrame:CGRectMake( modeSwitch.frame.origin.x + modeSwitch.frame.size.width + 20, 5, 100, 45)];
    [logOutBtn setTitle:@"Back" forState:UIControlStateNormal];
    [logOutBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [logOutBtn setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    logOutBtn.titleLabel.font = [UIFont boldSystemFontOfSize:22];
    //    [rightView addSubview:logOutBtn];
    
    
    if ([myCurrentController isKindOfClass:[OmniHomePage class]]){
        [logOutBtn setTitle:@"Logout" forState:UIControlStateNormal];
        [logOutBtn addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
        //    [rightView addSubview:logOutBtn];
    }
    
    
    [rightView addSubview:logOutBtn];
    
    //upto here on 27/04/2017....
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
    }
    else{
        titleView.frame = CGRectMake(0.0, 0.0, 240.0, 45.0);
        logoView.frame = CGRectMake(10.0, 7.0, 30.0, 30.0);
        self.titleLabel.frame = CGRectMake(45.0, -12.0, 300, 70.0);
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
        if (version >= 8.0) {
            self.titleLabel.textColor = [UIColor blackColor];
        }
    }
    
    UIBarButtonItem *leftCustomView = [[UIBarButtonItem alloc] initWithCustomView:titleView];
    
    self.navigationItem.leftBarButtonItem = leftCustomView;
    
    //added by Srinivasulu on 27/04/2017....
    
    UIBarButtonItem *rightCustomView = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    
    self.navigationItem.rightBarButtonItem = rightCustomView;
    
    //    self.navigationItem.rightBarButtonItems = @[refreshBtn,wifiView,modeSwitch,logOutBtn];
    //upto here on 27/04/2017....
    
    if ([myCurrentController isKindOfClass:[OmniHomePage class]]) {
        //        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleDone target:self action:@selector(logOut)];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            [[UIBarButtonItem appearance] setTitleTextAttributes:@{UITextAttributeFont: [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0]} forState:UIControlStateNormal];
            
            
        }
        else {
            [[UIBarButtonItem appearance] setTitleTextAttributes:@{UITextAttributeFont: [UIFont fontWithName:@"ArialRoundedMTBold" size:17.0]} forState:UIControlStateNormal];
        }
    }
    else {
        
        //changed by Srinivasulu on 27/04/2017....
        
        //        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
        
        [logOutBtn setTitle:@"Back" forState:UIControlStateNormal];
        [logOutBtn removeTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
        [logOutBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        
        //upto here on 27/04/2017....
        
        [logoView setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *sinleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goToHome)];
        [logoView addGestureRecognizer:sinleTap];
    }
    
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
    
    //added by Srinivasulu on 20/09/2017....
    //reason for temperoy solutions.....
    
    //    if (([custID caseInsensitiveCompare:@"CID8995450"] == NSOrderedSame) && (!isOfflineService)) {
    //
    //        isCustomerBillId = TRUE;
    //    }
    
    //upto here on 20/09/2017.....
    
}

- (void)backAction {
    
//    NSLog(@"--%d",isOfflineService);
    
    
    
    OmniRetailerAppDelegate *tmpDelegate = (OmniRetailerAppDelegate *)[UIApplication sharedApplication].delegate;
    id myCurrentController = tmpDelegate.appController.topViewController;
    if (![myCurrentController isKindOfClass:[OmniHomePage class]])
        //    {
        //        [logOutBtn setTitle:@"Logout" forState:UIControlStateNormal];
        //        [logOutBtn addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
        //        [rightView addSubview:logOutBtn];
        //    }
        //changed by Srinivasulu on 10/10/2017...
        //reason is the navigation barItems are missplacing....
        //        [self.navigationController popViewControllerAnimated:YES];
        [self.navigationController popViewControllerAnimated:NO];
    
    
    //upto  here on 10/10/2017....
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


-(void)changeWifiSwitchAction:(UISwitch*)switchBtn {
    
    
    
    if ((!switchBtn.on) && (modeSwitch.tag == 4)) {
        
        modeSwitch.tag = 4;
        
        
        modeSwitch.layer.cornerRadius = 16;
        modeSwitch.tintColor = [UIColor redColor];
        modeSwitch.backgroundColor = [UIColor redColor];
        
        
        offlineModeAlert = [[UIAlertView alloc] initWithTitle:@"Do you want to switch over to offline mode" message:nil delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
        [offlineModeAlert show];
        
    }
    else if(modeSwitch.tag == 4){
        
        
        isWifiSelectionChanged = FALSE;
        
        
        CheckWifi *wifi = [[CheckWifi alloc] init];
        BOOL status = [wifi checkWifi];
        
        
        
        
        if (status) {
            
            modeSwitch.tag = 4;
            
            wifiView.image = [UIImage imageNamed:@"wifi-icon_Colour2.png"];
            [refreshBtn setImage:[UIImage imageNamed:@"Cloud_Sync_Color1.png"] forState:UIControlStateNormal];
            
            [modeSwitch setOn:true];
            
            isOfflineService = false;
        }
        else {
            
            
            UIAlertView * sampleAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"before_switch_to_online_code_please_enable_wifi", nil) message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [sampleAlert show];
            
            wifiView.image = [UIImage imageNamed:@"wifi-icon_Colour1.png"];
            
            
            [modeSwitch setOn:false];
            isOfflineService = true;
        }
    }
    else{
        modeSwitch.tag = 4;
        
    }
    
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (alertView == offlineModeAlert) {
        
        
        [self changeOperationMode:buttonIndex];
        
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
        
        
    }
    
    
    else if (alertView == uploadConfirmationAlert)
    {
        
        if (buttonIndex == 0)
            
            [self syncOfflinebillsToOnline:buttonIndex];
        
        else
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        //        if (buttonIndex == 0) {
        //
        //            isOfflineService = false;
        //            CheckWifi *wifi = [[CheckWifi alloc] init];
        //            BOOL status = [wifi checkWifi];
        //
        //            if (status && [shiftId length]>0) {
        //
        //                [self synchCustomerDetails];
        //                [self deleteUploadedBillsFromLocal];
        //                [self synchUpLocalBills];
        //
        //
        //
        //            }
        //
        //
        //        }
        //        else {
        //            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        //        }
    }
    
    
    
    
    
}

//added by Srinivasulu on 28/04/2017....


-(void)changeOperationMode:(NSInteger)statusNo{
    
    @try {
        
        if (statusNo == 0) {
            
            isOfflineService = YES;
            [modeSwitch setOn:false];
            wifiView.image = [UIImage imageNamed:@"wifi-icon_Colour1.png"];
            
            
            [refreshBtn setImage:[UIImage imageNamed:@"Cloud_Sync_Colour2.png"] forState:UIControlStateNormal];
            
            
            modeSwitch.tintColor = [UIColor redColor];
            modeSwitch.layer.cornerRadius = 16;
            modeSwitch.backgroundColor = [UIColor redColor];
            
            
            NSUserDefaults  *defaults = [[NSUserDefaults alloc]init];
            finalLicencesDetails = [defaults valueForKey:@"licence"];
            presentLocation = [[defaults valueForKey:@"location"] copy];
            counterName = [defaults valueForKey:@"counterName"];
            firstName = [defaults valueForKey:@"firstName"];
            isProductsMenu = [[defaults valueForKey:kproductsMenu] boolValue];
            isCustomerBillId = [[defaults valueForKey:kCustomerBillId] boolValue];
            isBarcodeType = [[defaults valueForKey:kBarCodeType] boolValue];
            isRoundingRequired = [[defaults valueForKey:kRoundingRequired] boolValue];
            
            //changed by Srinivasulu on 29/09/2017....
            
            //            if ([custID caseInsensitiveCompare:@"CID8995438"] != NSOrderedSame) {
            ////            if (([custID caseInsensitiveCompare:@"CID8995438"] != NSOrderedSame) && ([custID caseInsensitiveCompare:@"CID8995450"] != NSOrderedSame)) {
            //
            //                //upto her eon 20/09/2017....
            //
            //
            //
            //                isCustomerBillId = false;
            //            }
            
            
            
            
        }
        else {
            
            isWifiSelectionChanged = FALSE;
            
            
            CheckWifi *wifi = [[CheckWifi alloc] init];
            BOOL status = [wifi checkWifi];
            
            
            
            
            if ((status) && (modeSwitch.tag == 4)) {
                
                
                wifiView.image = [UIImage imageNamed:@"wifi-icon_Colour2.png"];
                
                [refreshBtn setImage:[UIImage imageNamed:@"Cloud_Sync_Color1.png"] forState:UIControlStateNormal];
                
                
                [modeSwitch setOn:true];
                
                isOfflineService = false;
                
            }
            else if(modeSwitch.tag == 4) {
                
                wifiView.image = [UIImage imageNamed:@"wifi-icon_Colou1.png"];
                
                [refreshBtn setImage:[UIImage imageNamed:@"Cloud_Sync_Colour2.png"] forState:UIControlStateNormal];
                
                UIAlertView * sampleAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"before_switch_to_online_code_please_enable_wifi", nil) message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [sampleAlert show];
                
                
                
                [modeSwitch setOn:false];
                
                isOfflineService = true;
            }
            else{
                modeSwitch.tag = 4;
                
            }
        }
        
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

#pragma -mark method to for upload loading the bills....

/**
 * @description  this method will be executed then upload bill button is cilcked....
 * @method       uploadLocalBills
 * @author
 * @param
 * @param
 * @return       void
 * @verified By
 * @verified On
 *
 */

-(void)uploadLocalBills{
    
    @try {
        
        
        if(isOfflineService){
            
            UIAlertView * wifiAlert = [[UIAlertView alloc] initWithTitle:@"Please, Enable your wifi" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [wifiAlert show];
            
        }
        
        else if ([self getLocalBillCount] > 0) {
            uploadConfirmationAlert = [[UIAlertView alloc] initWithTitle:@"Are you sure to synch the local bills" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
            
            [uploadConfirmationAlert show];
            
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"There are no bills to sync" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
    } @catch (NSException *exception) {
        NSLog(@"--exception in customNavigationContorller -- in  uploadLocalBills()--");
        NSLog(@"--exception is--%@",exception);
        
    }
    
}

/**
 * @description  this method will return the number bills has to be uploaded count....
 * @method       getLocalBillCount
 * @author
 * @param
 * @param
 * @return       int
 * @verified By
 * @verified On
 *
 */

-(int)getLocalBillCount{
    
    int count = 0;
    
    static sqlite3 * localDatabase = nil;
    static sqlite3_stmt * localSelectStmt = nil;
    
    
    @try {
        
        
        NSString* dbPath = [DataBaseConnection connection:@"RetailerBillingDataBase.sqlite"];
        
        if(sqlite3_open(dbPath.UTF8String, & localDatabase) == SQLITE_OK) {
            NSString *query;
            
            
            //changed by Srinivaslulu on 29/08/2017....
            //reason error status are also has to be uploaded....
            
            //            query = [NSString stringWithFormat:@"select count (*) from billing_table where save_status != 'Success' and save_status!='Error'"];
            
            query = [NSString stringWithFormat:@"select count (*) from billing_table where save_status != 'Success'"];
            
            //upto here on 29/08/2017....
            
            const char *sqlStatement = query.UTF8String;
            
            
            if(sqlite3_prepare_v2(localDatabase, sqlStatement, -1, &localSelectStmt, NULL) == SQLITE_OK) {
                //                        int count = sqlite3_column_count(selectStmt);
                
                //                NSLog(@"%i", sqlite3_column_count(localSelectStmt));
                if(sqlite3_column_count(localSelectStmt))
                    while (sqlite3_step(localSelectStmt) == SQLITE_ROW) {
                        
                        count = sqlite3_column_int(localSelectStmt, 0);
                        
                    }
                sqlite3_reset(localSelectStmt);
                sqlite3_finalize(localSelectStmt);
                //                localSelectStmt = nil;
            }
            else {
                NSLog(@"%s",sqlite3_errmsg(localDatabase)) ;
            }
            
        }
    }
    @catch (NSException *exception) {
        
        NSLog(@"--exception in customNavigationContorller -- in  getLocalBillCount()--");
        NSLog(@"--exception is--%@",exception);
    }
    @finally {
        sqlite3_close(localDatabase);
        
    }
    
    return count;
}

#pragma mark upload customer details
// This method is not using any where of the class..
-(void)synchCustomerDetails {
    
    //added by Srinivauslu on 01/05/2017....
    
    if(SHUD == nil){
        SHUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:SHUD];
        // Regiser for HUD callbacks so we can remove it from the window at the right time
        SHUD.delegate = self;
        SHUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
        SHUD.mode = MBProgressHUDModeCustomView;
    }
    
    SHUD.labelText= @"Customer Details....";
    [SHUD show:YES];
    [SHUD setHidden:NO];
    
    
    //upto here on 01/05/2017....
    
    
    static sqlite3 * localDatabase = nil;
    static sqlite3_stmt * localSelectStmt = nil;
    
    
    NSMutableDictionary * result = [NSMutableDictionary new];
    NSMutableArray *custArr = [NSMutableArray new];
    //    int count = 0;
    
    @try {
        
        NSString * dbPath = [DataBaseConnection connection:@"RetailerBillingDataBase.sqlite"];
        
        if(sqlite3_open(dbPath.UTF8String, &localDatabase) == SQLITE_OK) {
            NSString *query;
            
            query = [NSString stringWithFormat:@"select * from customer_details"];
            
            const char *sqlStatement = query.UTF8String;
            
            
            
            if(sqlite3_prepare_v2(localDatabase, sqlStatement, -1, &localSelectStmt, NULL) == SQLITE_OK) {
                
                
                if(sqlite3_column_count(localSelectStmt))
                    while (sqlite3_step(localSelectStmt) == SQLITE_ROW) {
                        //                    count = sqlite3_column_int(selectStmt, 0);
                        
                        NSString  *phone = @((char *)sqlite3_column_text(localSelectStmt, 3));
                        NSString  *email = @((char *)sqlite3_column_text(localSelectStmt, 2));
                        
                        NSString  *street = @((char *)sqlite3_column_text(localSelectStmt, 5));
                        NSString  *locality = @((char *)sqlite3_column_text(localSelectStmt,6));
                        NSString  *city = @((char *)sqlite3_column_text(localSelectStmt,7));
                        NSString  *pin_no = @((char *)sqlite3_column_text(localSelectStmt,8));
                        
                        NSString *name = @((char*)sqlite3_column_text(localSelectStmt,0));
                        
                        
                        //added by Srinivausulu on 04/05/2017....
                        
                        NSString * lastName = @"";
                        NSString * houseNo = @"";
                        NSString * landMark = @"";
                        
                        
                        if( (char *)sqlite3_column_text(localSelectStmt,1))
                            lastName = @((char*)sqlite3_column_text(localSelectStmt,1));
                        
                        if( (char *)sqlite3_column_text(localSelectStmt,18))
                            houseNo = @((char*)sqlite3_column_text(localSelectStmt,18));
                        
                        if( (char *)sqlite3_column_text(localSelectStmt,19))
                            landMark = @((char*)sqlite3_column_text(localSelectStmt,19));
                        
                        
                        //upto here on 03/05/2017....
                        
                        
                        //changed by Srinivasulu 04/05/2017....
                        
                        //                    result = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:phone,email,street,locality,city,pin_no,name, nil] forKeys:[NSArray arrayWithObjects:@"phone",@"email",@"street",@"locality",@"city",@"pin_no",@"name", nil]];
                        
                        result = [NSMutableDictionary dictionaryWithObjects:@[phone,email,street,locality,city,pin_no,name,lastName,houseNo,landMark] forKeys:@[@"phone",@"email",@"street",@"locality",@"city",@"pin_no",@"name",@"lastName",@"houseNo",@"landMark"]];
                        
                        
                        //upto here on04/05/2017....
                        
                        [custArr addObject:result];
                    }
                sqlite3_reset(localSelectStmt);
                sqlite3_finalize(localSelectStmt);
                localSelectStmt = nil;
                
            }
            else {
                NSLog(@"%s",sqlite3_errmsg(localDatabase)) ;
            }
            
        }
        
        if (custArr.count>0) {
            
            for (NSDictionary *dic in custArr) {
                
                CustomerServiceSoapBinding *custBindng =  [CustomerServiceSvc CustomerServiceSoapBinding] ;
                CustomerServiceSvc_updateCustomer *aParameters = [[CustomerServiceSvc_updateCustomer alloc] init];
                
                
                //changed by Srinivasulu on 04/05/2017....
                
                
                //                NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"phone", @"pin_no",@"status",@"email",@"name",@"street",@"locality",@"loyaltyCustomer",@"phoneIds",@"city",REQUEST_HEADER, nil];
                //
                //                NSArray *loyaltyObjects = [NSArray arrayWithObjects:[dic valueForKey:@"phone"],[dic valueForKey:@"pin_no"],@"false",[dic valueForKey:@"email"],[dic valueForKey:@"name"],[dic valueForKey:@"street"],[dic valueForKey:@"locality"],@"",@"",[dic valueForKey:@"city"],[RequestHeader getRequestHeader], nil];
                
                
                
                NSArray *loyaltyKeys = @[@"phone", @"pin_no",@"status",@"email",@"name",@"street",@"locality",@"loyaltyCustomer",@"phoneIds",@"city",REQUEST_HEADER,@"lastName",@"houseNo",@"landMark"];
                
                NSArray *loyaltyObjects = @[[dic valueForKey:@"phone"],[dic valueForKey:@"pin_no"],@"false",[dic valueForKey:@"email"],[dic valueForKey:@"name"],[dic valueForKey:@"street"],[dic valueForKey:@"locality"],@"",@"",[dic valueForKey:@"city"],[RequestHeader getRequestHeader],[dic valueForKey:@"lastName"],[dic valueForKey:@"houseNo"],[dic valueForKey:@"landMark"]];
                
                
                
                //upto here on 04/05/2017....
                
                NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
                
                NSError * err_;
                NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
                NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
                aParameters.customerDetails = loyaltyString;
                
                
                CustomerServiceSoapBindingResponse *response = [custBindng updateCustomerUsingParameters:(CustomerServiceSvc_updateCustomer *)aParameters];
                if (![response.error isKindOfClass:[NSError class]]) {
                    
                    NSArray *responseBodyParts = response.bodyParts;
                    for (id bodyPart in responseBodyParts) {
                        if ([bodyPart isKindOfClass:[CustomerServiceSvc_updateCustomerResponse class]]) {
                            CustomerServiceSvc_updateCustomerResponse *body = (CustomerServiceSvc_updateCustomerResponse *)bodyPart;
                            // printf("\nresponse=%d",[body.createCustomerReturn UTF8String]);
                            NSError *e;
                            
                            NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                                                  options: NSJSONReadingMutableContainers
                                                                                    error: &e];
                            if ([[[JSON1 valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                                
                                [self deleteLocalCustDetails:[dic valueForKey:@"phone"]];
                                
                            }
                        }
                    }
                }
                
            }
        }
    }
    @catch (NSException *exception) {
        
        
        
        [SHUD setHidden:YES];
        NSLog(@"%@",exception);
        
        
    }
    @finally {
        sqlite3_close(localDatabase);
        
    }
    
}
-(BOOL)deleteLocalCustDetails:(NSString*)phone_no {
    
    BOOL isDeleted = NO;
    static sqlite3 * localDatabase = nil;
    //    static sqlite3_stmt * localSelectStmt = nil;
    static sqlite3_stmt * localDelectStmt = nil;
    
    @try {
        
        
        NSString* dbPath = [DataBaseConnection connection:@"RetailerBillingDataBase.sqlite"];
        
        //  BOOL isExists = [self createTable:@"billing"];
        
        //  if (isExists) {
        
        
        if(sqlite3_open(dbPath.UTF8String, &localDatabase) == SQLITE_OK) {
            
            if (localDelectStmt == nil) {
                NSString *query = [NSString stringWithFormat:@"delete from customer_details where phone_number='%@'",phone_no];
                const char *sqlStatement = query.UTF8String;
                
                if(sqlite3_prepare_v2(localDatabase, sqlStatement, -1, &localDelectStmt, NULL) == SQLITE_OK) {
                    
                    if(SQLITE_DONE != sqlite3_step(localDelectStmt)){
                        isDeleted = NO;
                        NSLog(@"%s",sqlite3_errmsg(localDatabase));
                        NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(localDatabase));
                    }
                    else {
                        isDeleted = YES;
                        
                    }
                    sqlite3_reset(localDelectStmt);
                }
                localDelectStmt = nil;
                
            }
            
        }
        
    }
    @catch (NSException *exception) {
        //        [HUD hide:YES afterDelay:2.0];
        
        
        [SHUD hide:YES afterDelay:2.0];
        NSLog(@"%@",exception);
        
    }
    @finally {
        sqlite3_close(localDatabase);
        localDelectStmt = nil;
        localDatabase = nil;
        
    }
    
    return isDeleted;
    
}

-(void)deleteUploadedBillsFromLocal {
    
    NSMutableArray *billIdsArr=[NSMutableArray new];
    //    NSMutableArray *billDatesArr=[NSMutableArray new];
    BOOL isDeleted = NO;
    
    static sqlite3 * localDatabase = nil;
    static sqlite3_stmt * localSelectStmt = nil;
    static sqlite3_stmt * localDelectStmt = nil;
    
    
    @try {
        
        NSString* dbPath = [DataBaseConnection connection:@"RetailerBillingDataBase.sqlite"];
        
        
        if(sqlite3_open(dbPath.UTF8String, &localDatabase) == SQLITE_OK) {
            
            
            //        NSString *query = [NSString stringWithFormat:@"select * from sku_master where sku_id LIKE '%% %@ %%'",selected_SKID];
            
            NSString *query = [NSString stringWithFormat:@"select bill_id,date_and_time from billing_table where save_status=='%@'",SUCCESS];
            
            const char *sqlStatement = query.UTF8String;
            
            
            if(sqlite3_prepare_v2(localDatabase, sqlStatement, -1, &localSelectStmt, NULL) == SQLITE_OK) {
                //                        int count = sqlite3_column_count(selectStmt);
                if(sqlite3_column_count(localSelectStmt))
                    while (sqlite3_step(localSelectStmt) == SQLITE_ROW) {
                        
                        // NSString  *skuId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStmt, 0)];
                        NSString  *bill_id = @((char *)sqlite3_column_text(localSelectStmt, 0));
                        NSString  *bill_date = @((char *)sqlite3_column_text(localSelectStmt,1));
                        [billIdsArr addObject:@{@"billId": bill_id,@"billDate": bill_date}];
                        //  [billDatesArr addObject:bill_date];
                    }
            }
            else {
                NSLog(@"%s",sqlite3_errmsg(localDatabase)) ;
            }
            sqlite3_reset(localSelectStmt);
            sqlite3_finalize(localSelectStmt);
            
            sqlite3_close(localDatabase);
        }
        
        if (billIdsArr.count>0) {
            
            //compare the sync clear date in config...
            
            NSString *noOfDays;
            NSString *noOfHours;
            
            NSString* filePath = [[NSBundle mainBundle] pathForResource:@"Config"
                                                                 ofType:@"xml"];
            
            //    [document.XMLData writeToFile:@"/Users/chandrasekhar/Desktop/1.xml" atomically:YES];
            NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
            NSError *error;
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData
                                                                   options:0 error:&error];
            NSArray *ele=[doc.rootElement elementsForName:@"bills-clean"];
            
            for (GDataXMLElement *partyMember in ele) {
                NSArray *days = [partyMember elementsForName:@"days"];
                GDataXMLElement *nameValue = (GDataXMLElement *) days[0];
                NSArray *hours = [partyMember elementsForName:@"hours"];
                GDataXMLElement *hoursVal = (GDataXMLElement *) hours[0];
                noOfDays = [nameValue.stringValue copy];
                noOfHours = [hoursVal.stringValue copy];
            }
            
            for (NSDictionary *dic in billIdsArr) {
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                // this is imporant - we set our input date format to match our input string
                // if format doesn't match you'll get nil from your string, so be careful
                dateFormatter.dateFormat = @"dd/MM/yyyy HH:mm:ss";
                NSDate *dateFromString = [[NSDate alloc] init];
                // voila!
                dateFromString = [dateFormatter dateFromString:[dic valueForKey:@"billDate"]];
                int daysToAdd = noOfDays.intValue;
                NSDate *newDate1 = [dateFromString dateByAddingTimeInterval:60*60*24*daysToAdd];
                
                
                NSDate *now = [NSDate date];
                
                if ([now compare:newDate1]==NSOrderedDescending) {
                    if(sqlite3_open(dbPath.UTF8String, &localDatabase) == SQLITE_OK) {
                        
                        if (localDelectStmt == nil) {
                            NSString *query = [NSString stringWithFormat:@"delete from billing_table where bill_id='%@'",[dic valueForKey:@"billId"]];
                            const char *sqlStatement = query.UTF8String;
                            
                            if(sqlite3_prepare_v2(localDatabase, sqlStatement, -1, &localDelectStmt, NULL) == SQLITE_OK) {
                                
                                if(SQLITE_DONE != sqlite3_step(localDelectStmt)){
                                    isDeleted = NO;
                                    NSLog(@"%s",sqlite3_errmsg(localDatabase));
                                    NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(localDatabase));
                                }
                                else {
                                    isDeleted = YES;
                                    
                                }
                                sqlite3_reset(localDelectStmt);
                                sqlite3_finalize(localDelectStmt);
                            }
                            localDelectStmt = nil;
                            
                        }
                        if (localDelectStmt == nil) {
                            NSString *query = [NSString stringWithFormat:@"delete from billing_items where bill_id='%@'",[dic valueForKey:@"billId"]];
                            
                            const char *sqlStatement = query.UTF8String;
                            
                            if(sqlite3_prepare_v2(localDatabase, sqlStatement, -1, &localDelectStmt, NULL) == SQLITE_OK) {
                                
                                if(SQLITE_DONE != sqlite3_step(localDelectStmt)){
                                    NSLog(@"%s",sqlite3_errmsg(localDatabase));
                                    isDeleted = NO;
                                    NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(localDatabase));
                                }
                                else {
                                    isDeleted = YES;
                                }
                                sqlite3_reset(localDelectStmt);
                                sqlite3_finalize(localDelectStmt);
                            }
                            localDelectStmt = nil;
                            
                        }
                        if (localDelectStmt == nil) {
                            NSString *query = [NSString stringWithFormat:@"delete from billing_transactions where bill_id='%@'",[dic valueForKey:@"billId"]];
                            
                            const char *sqlStatement = query.UTF8String;
                            
                            if(sqlite3_prepare_v2(localDatabase, sqlStatement, -1, &localDelectStmt, NULL) == SQLITE_OK) {
                                
                                if(SQLITE_DONE != sqlite3_step(localDelectStmt)){
                                    isDeleted = NO;
                                    NSLog(@"%s",sqlite3_errmsg(localDatabase));
                                    NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(localDatabase));
                                }
                                else {
                                    isDeleted = YES;
                                }
                                sqlite3_reset(localDelectStmt);
                                sqlite3_finalize(localDelectStmt);
                            }
                            localDelectStmt = nil;
                            
                        }
                        if (localDelectStmt == nil) {
                            NSString *query = [NSString stringWithFormat:@"delete from billing_denomination where bill_id='%@'",[dic valueForKey:@"billId"]];
                            
                            const char *sqlStatement = query.UTF8String;
                            
                            if(sqlite3_prepare_v2(localDatabase, sqlStatement, -1, &localDelectStmt, NULL) == SQLITE_OK) {
                                
                                if(SQLITE_DONE != sqlite3_step(localDelectStmt)){
                                    isDeleted = NO;
                                    NSLog(@"%s",sqlite3_errmsg(localDatabase));
                                    NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(localDatabase));
                                }
                                else {
                                    isDeleted = YES;
                                }
                                sqlite3_reset(localDelectStmt);
                                sqlite3_finalize(localDelectStmt);
                            }
                            localDelectStmt = nil;
                            
                        }
                        if (localDelectStmt == nil) {
                            NSString *query = [NSString stringWithFormat:@"delete from billing_discounts where bill_id='%@'",[dic valueForKey:@"billId"]];
                            
                            const char *sqlStatement = query.UTF8String;
                            
                            if(sqlite3_prepare_v2(localDatabase, sqlStatement, -1, &localDelectStmt, NULL) == SQLITE_OK) {
                                
                                if(SQLITE_DONE != sqlite3_step(localDelectStmt)){
                                    isDeleted = NO;
                                    NSLog(@"%s",sqlite3_errmsg(localDatabase));
                                    NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(localDatabase));
                                }
                                else {
                                    isDeleted = YES;
                                }
                                sqlite3_reset(localDelectStmt);
                                sqlite3_finalize(localDelectStmt);
                            }
                            localDelectStmt = nil;
                            
                        }
                        if (localDelectStmt == nil) {
                            NSString *query = [NSString stringWithFormat:@"delete from billing_item_taxes where bill_id='%@'",[dic valueForKey:@"billId"]];
                            
                            const char *sqlStatement = query.UTF8String;
                            
                            if(sqlite3_prepare_v2(localDatabase, sqlStatement, -1, &localDelectStmt, NULL) == SQLITE_OK) {
                                
                                if(SQLITE_DONE != sqlite3_step(localDelectStmt)){
                                    isDeleted = NO;
                                    NSLog(@"%s",sqlite3_errmsg(localDatabase));
                                    NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(localDatabase));
                                }
                                else {
                                    isDeleted = YES;
                                }
                                sqlite3_reset(localDelectStmt);
                                sqlite3_finalize(localDelectStmt);
                            }
                            localDelectStmt = nil;
                            
                        }
                        if (localDelectStmt == nil) {
                            NSString *query = [NSString stringWithFormat:@"delete from billing_taxes where bill_id='%@'",[dic valueForKey:@"billId"]];
                            
                            const char *sqlStatement = query.UTF8String;
                            
                            if(sqlite3_prepare_v2(localDatabase, sqlStatement, -1, &localDelectStmt, NULL) == SQLITE_OK) {
                                
                                if(SQLITE_DONE != sqlite3_step(localDelectStmt)){
                                    isDeleted = NO;
                                    NSLog(@"%s",sqlite3_errmsg(localDatabase));
                                    NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(localDatabase));
                                }
                                else {
                                    isDeleted = YES;
                                }
                                sqlite3_reset(localDelectStmt);
                                sqlite3_finalize(localDelectStmt);
                            }
                            localDelectStmt = nil;
                            
                        }
                    }
                    
                }
            }
            
        }
        
    }
    
    @catch (NSException *exception) {
        //        [HUD hide:YES afterDelay:2.0];
        NSLog(@"%@",exception);
        
    }
    @finally {
        sqlite3_close(localDatabase);
        localDelectStmt = nil;
        //        selectStmt = nil;
        
    }
    
    
}


-(void)synchUpLocalBills {
    
    int count = 0;
    BOOL billsAvailable = false;
    
    static sqlite3 * localDatabase = nil;
    static sqlite3_stmt * localSelectStmt = nil;
    
    
    @try {
        
        NSString* dbPath = [DataBaseConnection connection:@"RetailerBillingDataBase.sqlite"];
        
        
        
        
        
        
        if(sqlite3_open(dbPath.UTF8String, &localDatabase) == SQLITE_OK) {
            NSString *query;
            
            //changed by Srinivaslulu on 29/08/2017....
            //reason error status are also has to be uploaded....
            
            //            query = [NSString stringWithFormat:@"select count (*) from billing_table where save_status != 'Success' and save_status!='Error'"];
            
            query = [NSString stringWithFormat:@"select count (*) from billing_table where save_status != 'Success'"];
            
            //upto here on 29/08/2017....
            
            
            
            const char *sqlStatement = query.UTF8String;
            
            
            if(sqlite3_prepare_v2(localDatabase, sqlStatement, -1, &localSelectStmt, NULL) == SQLITE_OK) {
                //                        int count = sqlite3_column_count(selectStmt);
                
                if(sqlite3_column_count(localSelectStmt))
                    while (sqlite3_step(localSelectStmt) == SQLITE_ROW) {
                        
                        count = sqlite3_column_int(localSelectStmt, 0);
                        
                        
                    }
                sqlite3_reset(localSelectStmt);
                sqlite3_finalize(localSelectStmt);
                localSelectStmt = nil;
                if (count>0) {
                    billsAvailable = TRUE;
                    
                }
                
            }
            else {
                NSLog(@"%s",sqlite3_errmsg(localDatabase)) ;
            }
            
            
            
        }
        if (billsAvailable) {
            //            // syncStatus = billsAvailable;
            //            //            [self getBillsFromLocal];
            //            HUD.labelText= @"Uploading Bills....";
            //            [HUD show:YES];
            //            [HUD setHidden:NO];
            //
            //            // [self getBillsFromLocal];
            //            // [self performSelectorInBackground:@selector(getBillsFromLocal) withObject:nil];
            //
            //            [HUD showWhileExecuting:@selector(getBillsFromLocal) onTarget:self withObject:nil animated:YES];
            
            
            // syncStatus = billsAvailable;
            //            [self getBillsFromLocal];
            
            SHUD.labelText= @"Uploading Bills....";
            [SHUD show:YES];
            [SHUD setHidden:NO];
            [SHUD setDelegate:self];
            // [self getBillsFromLocal];
            // [self performSelectorInBackground:@selector(getBillsFromLocal) withObject:nil];
            
            [SHUD showWhileExecuting:@selector(getBillsFromLocal) onTarget:self withObject:nil animated:YES];
        }
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
        
    }
    @finally {
        {
            
            
            //added by Srinivasulu on 20/05/2017....
            
            //            @try {
            //                int count = [self getLocalBillCount];
            //
            //                refreshBtn.badgeValue = [NSString stringWithFormat:@"%d",count];
            //
            //                                for(UIView * view in self.navigationController.navigationBar.subviews){
            //
            //                                    if(view.tag == 2){
            //
            //                                        for(UIView * view1 in view.subviews){
            //
            //                                            if(view1.frame.origin.x == refreshBtn.frame.origin.x){
            //
            //                                                UIButton * btn = (UIButton *)view1;
            //
            //                                                btn.badgeValue = [NSString stringWithFormat:@"%d",count];
            //
            //                                                break;
            //
            //                                            }
            //
            //                                        }
            //                                        break;
            //
            //                                    }
            //
            //                                }
            //            } @catch (NSException *exception) {
            //
            //            }
            
            //upto here on 20/05/2017....
            
            sqlite3_close(localDatabase);
            
            
        }
    }
    
    
}



-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];
    
    @try {
        
        
        //changed by Srinivasulu on 20/04/2017....
        
        //changed by Srinivasulu on 11/05/2017....
        
        //        if(isOfflineService){
        //
        //            //        modeSwitch.tag = 2;
        //
        //            [modeSwitch setOn:false];
        //            [wifiView setImage:[UIImage imageNamed:@"wifi-icon_Colour1.png"]];
        //            [refreshBtn setImage:[UIImage imageNamed:@"Cloud_Sync_Colour2.png"] forState:UIControlStateNormal];
        //
        //            modeSwitch.layer.cornerRadius = 16;
        //            [modeSwitch setTintColor:[UIColor redColor]];
        //            modeSwitch.backgroundColor = [UIColor redColor];
        //
        //        }
        //        else{
        //            //        modeSwitch.tag = 2;
        //
        //            [modeSwitch setOn:true];
        //            [wifiView setImage:[UIImage imageNamed:@"wifi-icon_Colour2.png"]];
        //
        //            [refreshBtn setImage:[UIImage imageNamed:@"Cloud_Sync_Color1.png"] forState:UIControlStateNormal];
        //
        //        }
        
        if(!isOfflineService){
            isWifiSelectionChanged = FALSE;
            
            
            CheckWifi *wifi = [[CheckWifi alloc] init];
            isOfflineService =  ![wifi checkWifi];
        }
        
        
        if (isOfflineService){
            
            //        modeSwitch.tag = 2;
            
            [modeSwitch setOn:false];
            wifiView.image = [UIImage imageNamed:@"wifi-icon_Colour1.png"];
            [refreshBtn setImage:[UIImage imageNamed:@"Cloud_Sync_Colour2.png"] forState:UIControlStateNormal];
            
            modeSwitch.layer.cornerRadius = 16;
            modeSwitch.tintColor = [UIColor redColor];
            modeSwitch.backgroundColor = [UIColor redColor];
            
            
        }
        else{
            //        modeSwitch.tag = 2;
            
            [modeSwitch setOn:true];
            wifiView.image = [UIImage imageNamed:@"wifi-icon_Colour2.png"];
            
            [refreshBtn setImage:[UIImage imageNamed:@"Cloud_Sync_Color1.png"] forState:UIControlStateNormal];
            
            
            
        }
        
        //upto here on11/05/2017....
        
        //upto here on 29/04/2017.....
        
        int count = [self getLocalBillCount];
        
        //changed by Srinivasulu on 25/09/2017...
        
        //        for(UIView * view in self.navigationController.navigationBar.subviews){
        
        for(UIView * view in  self.navigationItem.rightBarButtonItem.customView.subviews){
            
            //            NSLog(@"------%@",self.navigationController.navigationBar.subviews);
            //
            //            //
            //            NSLog(@"---%li",view.tag);
            //         //upto here on 25/09/2017....
            //            if(view.tag == 2){
            //
            //
            //
            //                for(UIView * view1 in view.subviews){
            
            if(view.frame.origin.x == refreshBtn.frame.origin.x){
                
                UIButton * btn = (UIButton *)view;
                
                btn.badgeValue = [NSString stringWithFormat:@"%d",count];
                
                break;
                
            }
            
            //                }
            //                break;
            //
            //            }
            
        }
        
        
        
    } @catch (NSException *exception) {
        
    }
    
    
}

#pragma  -mark methods add on 01/05/2017....

-(void)getBillsFromLocal {
    
    NSMutableArray *bill_ids = [[NSMutableArray alloc]init];
    //    NSMutableDictionary *details = [[NSMutableDictionary alloc] init];
    BOOL isBillSaved = false;
    NSString* currentdate = [WebServiceUtility getCurrentDate];
    
    
    
    static sqlite3 * localDatabase = nil;
    static sqlite3_stmt * localSelectStmt =nil;
    
    
    //    loadingMsgLbl.text = @"Uploading Bills....";
    //    [loadingView setHidden:YES];
    NSString *save_status;
    
    @try {
        
        
        
        
        NSString* dbPath = [DataBaseConnection connection:@"RetailerBillingDataBase.sqlite"];
        
        if(sqlite3_open(dbPath.UTF8String, &localDatabase) == SQLITE_OK) {
            
            //        NSString *query = [NSString stringWithFormat:@"select * from sku_master where sku_id LIKE '%% %@ %%'",selected_SKID];
            
            //changed by Srinivaslulu on 29/08/2017....
            //reason error status are also has to be uploaded....
            
            //            NSString * query = [NSString stringWithFormat:@"select bill_id from billing_table where save_status!='%@' and save_status!='Error'",SUCCESS];
            
            NSString * query = [NSString stringWithFormat:@"select bill_id from billing_table where save_status!='%@'",SUCCESS];
            
            //upto here on 29/08/2017....
            
            
            //            NSString *query = [NSString stringWithFormat:@"select bill_id from billing_table where save_status!='%@' and save_status!='Error'",SUCCESS];
            
            
            // NSString *query = [NSString stringWithFormat:@"select bill_id from billing_table where bill_id like 'BL170403%%'"];
            
            
            const char *sqlStatement = query.UTF8String;
            
            
            if(sqlite3_prepare_v2(localDatabase, sqlStatement, -1, &localSelectStmt, NULL) == SQLITE_OK) {
                //                        int count = sqlite3_column_count(selectStmt);
                
                
                NSLog(@"-----------displaing --------------%i",sqlite3_column_count(localSelectStmt));
                
                if(sqlite3_column_count(localSelectStmt))
                    
                    if(sqlite3_column_count(localSelectStmt) )
                        while (sqlite3_step(localSelectStmt) == SQLITE_ROW) {
                            
                            // NSString  *skuId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStmt, 0)];
                            NSString  * bill_id = @((char *)sqlite3_column_text(localSelectStmt, 0));
                            [bill_ids addObject:bill_id];
                            
                        }
                sqlite3_finalize(localSelectStmt);
                localSelectStmt = nil;
            }
            else {
                NSLog(@"%s",sqlite3_errmsg(localDatabase)) ;
            }
            sqlite3_close(localDatabase);
        }
        
        if (bill_ids.count!=0) {
            
            for (int i=0; i<bill_ids.count; i++) {
                
                NSString  *bill_id;
                NSString  *date;
                NSString  *cashier_id;
                NSString  *counter_id;
                NSString  *Total_discount;
                NSString  *discount_type;
                NSString  *discount_type_id;
                NSString  *tax;
                NSString  *total_price;
                NSString  *due_amount;
                NSString  *status ;
                NSString  *email_id;
                NSString  *phone_number;
                NSString  *store_location;
                NSString  *customer_name;
                NSString *shift_id;
                NSString  *print_count;
                NSString *other_disc;
                NSString *bussiness_date;
                NSString *scan_start_date;
                NSString *scan_end_date;
                NSString *print_date;
                NSNumber *bill_duration_time;
                NSNumber *bill_duration_accept_print;
                NSString *serialBillId = @"";
                
                //added by Srinivasulu on 12/07/2017 && 03/08/2017 && 24/03/2018 && 28/06/2018....
                
                NSString * otherDiscDescriptionStr = @"";
                NSString * registerStr;
                NSString * employeeSaleIdStr;
                NSString * cashierNameStr = @"";
                NSString * subTotalStr = @"";
                NSString * lastUpdateDateStr;
                NSString * customerGstinStr;
                
                NSString * billAmountStr = @"";
                NSString * billCancelReasonStr = @"";
                
                NSString * billRemarksStr = @"";
                
                NSString * saleOrderIdStr = @"";
                NSString * shipmentChargesStr = @"";
                
                //upto here on 12/07/2017 && 03/08/2017 && 24/03/2018 && 28/06/2018....
                
                if(sqlite3_open(dbPath.UTF8String, &localDatabase) == SQLITE_OK) {
                    
                    
                    NSString *query = [NSString stringWithFormat:@"select * from billing_table where bill_id='%@'",bill_ids[i]];
                    
                    const char *sqlStatement = query.UTF8String;
                    
                    
                    if(sqlite3_prepare_v2(localDatabase, sqlStatement, -1, &localSelectStmt, NULL) == SQLITE_OK) {
                        //                        int count = sqlite3_column_count(selectStmt);
                        if(sqlite3_column_count(localSelectStmt))
                            while (sqlite3_step(localSelectStmt) == SQLITE_ROW) {
                                
                                bill_id = @((char *)sqlite3_column_text(localSelectStmt, 0));
                                date = @((char *)sqlite3_column_text(localSelectStmt, 1));
                                cashier_id = @((char *)sqlite3_column_text(localSelectStmt, 2));
                                counter_id = @((char *)sqlite3_column_text(localSelectStmt, 3));
                                Total_discount = @((char *)sqlite3_column_text(localSelectStmt, 4));
                                discount_type = @((char *)sqlite3_column_text(localSelectStmt, 5));
                                discount_type_id = @((char *)sqlite3_column_text(localSelectStmt,6));
                                tax = @((char *)sqlite3_column_text(localSelectStmt, 7));
                                total_price = @((char *)sqlite3_column_text(localSelectStmt, 8));
                                due_amount = @((char *)sqlite3_column_text(localSelectStmt, 9));
                                status = @((char *)sqlite3_column_text(localSelectStmt, 10));
                                email_id = @((char *)sqlite3_column_text(localSelectStmt, 11));
                                phone_number = @((char *)sqlite3_column_text(localSelectStmt, 12));
                                store_location = @((char *)sqlite3_column_text(localSelectStmt, 13));
                                customer_name = @((char *)sqlite3_column_text(localSelectStmt, 14));
                                shift_id = @((char *)sqlite3_column_text(localSelectStmt, 15));
                                
                                save_status = @((char *)sqlite3_column_text(localSelectStmt,16));
                                print_count = @((char *)sqlite3_column_text(localSelectStmt, 17));
                                other_disc = @((char *)sqlite3_column_text(localSelectStmt, 19));
                                bussiness_date = @((char *)sqlite3_column_text(localSelectStmt, 20));
                                scan_start_date = [WebServiceUtility getCurrentDate];
                                if (sqlite3_column_text(localSelectStmt, 21) != nil) {
                                    scan_start_date = @((char *)sqlite3_column_text(localSelectStmt, 21));
                                }
                                scan_end_date = [WebServiceUtility getCurrentDate];
                                if (sqlite3_column_text(localSelectStmt, 22) != nil) {
                                    scan_end_date = @((char *)sqlite3_column_text(localSelectStmt, 22));
                                }
                                print_date = [WebServiceUtility getCurrentDate];
                                if (sqlite3_column_text(localSelectStmt, 23) != nil) {
                                    print_date = @((char *)sqlite3_column_text(localSelectStmt, 23));
                                }
                                bill_duration_time = @(sqlite3_column_int(localSelectStmt, 24));
                                bill_duration_accept_print = @(sqlite3_column_int(localSelectStmt, 25));
                                
                                if (sqlite3_column_text(localSelectStmt, 26) != nil) {
                                    serialBillId = @((char *)sqlite3_column_text(localSelectStmt, 26));
                                }
                                
                                //added by Srinivasulu on 12/07/2017 && 03/08/2017 && 08/09/2017 && 24/03/2018  && 28/06/2018....
                                
                                if( (char *)sqlite3_column_text(localSelectStmt,27) &&  (sqlite3_column_text(localSelectStmt, 27) != nil))
                                    otherDiscDescriptionStr = @((char *)sqlite3_column_text(localSelectStmt, 27));
                                
                                if( (char *)sqlite3_column_text(localSelectStmt,28) &&  (sqlite3_column_text(localSelectStmt, 28) != nil))
                                    registerStr = @((char *)sqlite3_column_text(localSelectStmt, 28));
                                
                                if( (char *)sqlite3_column_text(localSelectStmt,29) &&  (sqlite3_column_text(localSelectStmt, 29) != nil))
                                    employeeSaleIdStr = @((char *)sqlite3_column_text(localSelectStmt, 29));
                                
                                if( (char *)sqlite3_column_text(localSelectStmt,30) &&  (sqlite3_column_text(localSelectStmt, 30) != nil))
                                    cashierNameStr = @((char *)sqlite3_column_text(localSelectStmt, 30));
                                
                                if( (char *)sqlite3_column_text(localSelectStmt,31) &&  (sqlite3_column_text(localSelectStmt, 31) != nil))
                                    subTotalStr = @((char *)sqlite3_column_text(localSelectStmt, 31));
                                
                                if( (char *)sqlite3_column_text(localSelectStmt,32) &&  (sqlite3_column_text(localSelectStmt, 32) != nil))
                                    lastUpdateDateStr = @((char *)sqlite3_column_text(localSelectStmt, 32));
                                
                                if( (char *)sqlite3_column_text(localSelectStmt,33) &&  (sqlite3_column_text(localSelectStmt, 33) != nil))
                                    customerGstinStr = @((char *)sqlite3_column_text(localSelectStmt, 33));
                                

                                if( (char *)sqlite3_column_text(localSelectStmt,34) &&  (sqlite3_column_text(localSelectStmt, 34) != nil))
                                    billAmountStr = @((char *)sqlite3_column_text(localSelectStmt, 34));
                                else
                                    billAmountStr = @((char *)sqlite3_column_text(localSelectStmt, 8));
                                
                                
                                if( (char *)sqlite3_column_text(localSelectStmt,35) &&  (sqlite3_column_text(localSelectStmt, 35) != nil))
                                    billCancelReasonStr = @((char *)sqlite3_column_text(localSelectStmt, 35));
                                
                                if( (char *)sqlite3_column_text(localSelectStmt,36) &&  (sqlite3_column_text(localSelectStmt, 36) != nil))
                                    billRemarksStr = @((char *)sqlite3_column_text(localSelectStmt, 36));
                               
                                if( (char *)sqlite3_column_text(localSelectStmt,37) &&  (sqlite3_column_text(localSelectStmt, 37) != nil))
                                    saleOrderIdStr = @((char *)sqlite3_column_text(localSelectStmt, 37));
                                
                                if( (char *)sqlite3_column_text(localSelectStmt,38) &&  (sqlite3_column_text(localSelectStmt, 38) != nil))
                                    shipmentChargesStr = @((char *)sqlite3_column_text(localSelectStmt, 38));
                                //upto here on 12/07/2017 && 03/08/2017 && 08/09/2017 && 24/03/2018  && 28/06/2018....
                                
                            }
                        sqlite3_finalize(localSelectStmt);
                        //                            selectStmt = nil;
                    }
                    else {
                        NSLog(@"%s",sqlite3_errmsg(localDatabase)) ;
                        return;
                    }
                    billSaveStatus = [save_status copy];
                    NSString *item_query = [NSString stringWithFormat:@"select * from billing_items where bill_id='%@'",bill_ids[i]];
                    
                    const char *sqlStatement1 = item_query.UTF8String;
                    
                    //changed by Srinivasulu on 12/07/2017....
                    
                    
                    //                    NSArray *totalBillItems = [[NSArray alloc] init];
                    NSMutableArray *totalBillItems = [[NSMutableArray alloc] init];
                    
                    //upto here on 12/07/2017....
                    
                    if(sqlite3_prepare_v2(localDatabase, sqlStatement1, -1, &localSelectStmt, NULL) == SQLITE_OK) {
                        itemsArr = [[NSMutableArray alloc]init];
                        NSMutableArray *itemDiscountArr = [NSMutableArray new];
                        NSMutableArray *itemDiscountDescArr = [NSMutableArray new];
                        NSMutableArray *itemScanCodeArr = [NSMutableArray new];
                        NSMutableArray *discountPriceArr = [NSMutableArray new];
                        NSMutableArray *manufacturedItemsArr = [NSMutableArray new];
                        NSMutableArray *packagedItemsArr = [NSMutableArray new];
                        NSMutableArray *productInfoArr = [NSMutableArray new];
                        
                        //added by Srinivasulu on 18/08/2017....
                        
                        NSMutableArray * itemUnitPriceArr = [NSMutableArray new];
                        NSMutableArray * itemsTotalCostArr = [NSMutableArray new];
                        
                        //upto here on 18/08/2017....
                        
                        if(sqlite3_column_count(localSelectStmt))
                            while (sqlite3_step(localSelectStmt) == SQLITE_ROW) {
                                
                                
                                NSString  *sku_id = @((char *)sqlite3_column_text(localSelectStmt, 2));
                                NSString  *item = @((char *)sqlite3_column_text(localSelectStmt, 3));
                                NSString  *quantity = @((char *)sqlite3_column_text(localSelectStmt, 4));
                                NSString  *total_price = @((char *)sqlite3_column_text(localSelectStmt, 5));
                                NSString  *tax_code = @((char *)sqlite3_column_text(localSelectStmt, 6));
                                NSString  *tax_value = @((char *)sqlite3_column_text(localSelectStmt,7));
                                NSString  *status = @((char *)sqlite3_column_text(localSelectStmt, 8));
                                NSString  *pluCode = @((char *)sqlite3_column_text(localSelectStmt, 9));
                                NSString  *editedPrice = @((char *)sqlite3_column_text(localSelectStmt, 10));
                                NSString  *mrpPrice = @((char *)sqlite3_column_text(localSelectStmt, 14));
                                NSString  *itemDiscount = @((char *)sqlite3_column_text(localSelectStmt, 15));
                                NSString  *itemDiscountDesc = @((char *)sqlite3_column_text(localSelectStmt, 16));
                                NSString *itemScanCode = @((char *)sqlite3_column_text(localSelectStmt, 17));
                                NSString *discountPrice = @((char *)sqlite3_column_text(localSelectStmt, 13));
                                NSString *itemFlag = @"N";
                                
                                if (sqlite3_column_text(localSelectStmt, 18) != nil) {
                                    itemFlag = @((char *)sqlite3_column_text(localSelectStmt, 18));
                                }
                                
                                int isManufacturedItem = sqlite3_column_int(localSelectStmt, 19);
                                
                                int isPackedItem = sqlite3_column_int(localSelectStmt, 20);
                                
                                NSString  *category = @"";
                                if (sqlite3_column_text(localSelectStmt, 21) != nil) {
                                    category = @((char *)sqlite3_column_text(localSelectStmt, 21));
                                }
                                
                                NSString  *subCategory = @"";
                                if (sqlite3_column_text(localSelectStmt, 22) != nil) {
                                    subCategory = @((char *)sqlite3_column_text(localSelectStmt, 22));
                                }
                                
                                NSString  *productRange = @"";
                                if (sqlite3_column_text(localSelectStmt, 23) != nil) {
                                    productRange = @((char *)sqlite3_column_text(localSelectStmt, 23));
                                }
                                
                                NSString  *measureRange = @"";
                                if (sqlite3_column_text(localSelectStmt, 24) != nil) {
                                    measureRange = @((char *)sqlite3_column_text(localSelectStmt, 24));
                                }
                                
                                NSString  *brand = @"";
                                if (sqlite3_column_text(localSelectStmt, 25) != nil) {
                                    brand = @((char *)sqlite3_column_text(localSelectStmt, 25));
                                }
                                NSString  *model = @"";
                                if (sqlite3_column_text(localSelectStmt, 26) != nil) {
                                    model = @((char *)sqlite3_column_text(localSelectStmt, 26));
                                }
                                
                                
                                //added by Srinivasulu on 18/08/2017....
                                
                                [itemsTotalCostArr addObject:total_price];
                                
                                if (sqlite3_column_text(localSelectStmt, 27) != nil) {
                                    
                                    [itemUnitPriceArr addObject:@((char *)sqlite3_column_text(localSelectStmt, 27))];
                                }
                                else{
                                    
                                    [itemUnitPriceArr addObject:@"0.0"];
                                }
                                //upto here on 18/08/2017....
                                
                                //added by Srinivaslulu on 12/07/2017....
                                //no need store && retrive the itemUnitPrice.... because in webUtilites we are calculating it....
                                
                                NSString  * itemScanFlagStr = @"";//29 -- 28
                                
                                NSString  * employeSaldIdStr = @"";//30 -- 39
                                
                                NSString  * departmentStr = @"";//31 -- 30
                                NSString  * subDepartmentStr = @"";//32 -- 31
                                
                                NSString  * employeeNameStr = @"";//33 -- 32
                                
                                NSString  * taxCostStr = @"";//34 -- 33 // notRequired
                                
                                NSString  * styleStr = @"";//35 -- 34
                                NSString  * patternStr = @"";//36 -- 35
                                NSString  * batchStr = @"";//37 -- 36
                                NSString  * colorStr = @"";//38 -- 37
                                NSString  * sizeStr = @"";//39 -- 38
                                NSString  * sectionStr = @"";//40 -- 39
                                NSString  * hsnCodeStr = @"";//41 -- 40
                                NSString  * utilityStr = @"";//42  -- 41
                                NSString  * isTaxInclusiveStr = @"0";//43  -- 42
                                
                                
                                //added by Srinivasulu on 12/08/2017....
                                
                                NSString  * productClassStr = @"";//44  -- 43
                                NSString  * productSubClassStr = @"";//45  -- 44
                                NSString  * styleRangeStr = @"";//46  -- 45
                                
                                //upto here on 12/08/2017....
                                
                                //added by Srinivasulu on 21/08/2017 && 08/09/2017 && 29/08/2018....
                                
                                NSString  * editPriceReasonStr = @"";//47  -- 46
                                NSString  * voidItemReasonStr = @"";//47  -- 48
                                NSString  * expiryDateStr = @"";//48  -- 49
                                NSString  * packSizeStr = @"1";//49  -- 50
                                
                                if (sqlite3_column_text(localSelectStmt, 46) != nil) {
                                    editPriceReasonStr = @((char *)sqlite3_column_text(localSelectStmt, 46));
                                }
                                
                                if (sqlite3_column_text(localSelectStmt, 47) != nil) {
                                    voidItemReasonStr = @((char *)sqlite3_column_text(localSelectStmt, 47));
                                }
                                
                                if (sqlite3_column_text(localSelectStmt, 48) != nil) {
                                    expiryDateStr = @((char *)sqlite3_column_text(localSelectStmt, 48));
                                }
                                if (sqlite3_column_text(localSelectStmt, 49) != nil) {
                                    packSizeStr = @((char *)sqlite3_column_text(localSelectStmt, 49));
                                }
                                
                                //upto here on 12/08/2017 && 08/09/2017 && 29/08/2018....
                                
                                
                                if (sqlite3_column_text(localSelectStmt, 28) != nil) {
                                    itemScanFlagStr = @((char *)sqlite3_column_text(localSelectStmt, 28));
                                }
                                
                                if (sqlite3_column_text(localSelectStmt, 29) != nil) {
                                    employeSaldIdStr = @((char *)sqlite3_column_text(localSelectStmt, 29));
                                }
                                
                                if (sqlite3_column_text(localSelectStmt, 30) != nil) {
                                    departmentStr = @((char *)sqlite3_column_text(localSelectStmt, 30));
                                }
                                
                                if (sqlite3_column_text(localSelectStmt, 31) != nil) {
                                    subDepartmentStr = @((char *)sqlite3_column_text(localSelectStmt, 31));
                                }
                                
                                if (sqlite3_column_text(localSelectStmt, 32) != nil) {
                                    employeeNameStr = @((char *)sqlite3_column_text(localSelectStmt, 32));
                                }
                                
                                if (sqlite3_column_text(localSelectStmt, 33) != nil) {
                                    taxCostStr = @((char *)sqlite3_column_text(localSelectStmt, 33));
                                }
                                
                                if (sqlite3_column_text(localSelectStmt, 34) != nil) {
                                    styleStr = @((char *)sqlite3_column_text(localSelectStmt, 34));
                                }
                                
                                if (sqlite3_column_text(localSelectStmt, 35) != nil) {
                                    patternStr = @((char *)sqlite3_column_text(localSelectStmt, 35));
                                }
                                
                                if (sqlite3_column_text(localSelectStmt, 36) != nil) {
                                    batchStr = @((char *)sqlite3_column_text(localSelectStmt, 36));
                                }
                                
                                if (sqlite3_column_text(localSelectStmt, 37) != nil) {
                                    colorStr = @((char *)sqlite3_column_text(localSelectStmt, 37));
                                }
                                
                                if (sqlite3_column_text(localSelectStmt, 38) != nil) {
                                    sizeStr = @((char *)sqlite3_column_text(localSelectStmt, 38));
                                }
                                
                                if (sqlite3_column_text(localSelectStmt, 39) != nil) {
                                    sectionStr = @((char *)sqlite3_column_text(localSelectStmt, 39));
                                }
                                
                                if (sqlite3_column_text(localSelectStmt, 40) != nil) {
                                    hsnCodeStr = @((char *)sqlite3_column_text(localSelectStmt, 40));
                                }
                                
                                if (sqlite3_column_text(localSelectStmt, 41) != nil) {
                                    utilityStr = @((char *)sqlite3_column_text(localSelectStmt, 41));
                                }
                                
                                if (sqlite3_column_text(localSelectStmt, 42) != nil) {
                                    isTaxInclusiveStr = @((char *)sqlite3_column_text(localSelectStmt, 42));
                                }
                                
                                
                                if (sqlite3_column_text(localSelectStmt, 43) != nil) {
                                    productClassStr = @((char *)sqlite3_column_text(localSelectStmt, 43));
                                }
                                
                                if (sqlite3_column_text(localSelectStmt, 44) != nil) {
                                    productSubClassStr = @((char *)sqlite3_column_text(localSelectStmt, 44));
                                }
                                
                                
                                if (sqlite3_column_text(localSelectStmt, 45) != nil) {
                                    styleRangeStr = @((char *)sqlite3_column_text(localSelectStmt, 45));
                                }
                                
                                //upto here on 12/07/2017....
                                //upto here on 12/07/2017....
                                
                                
                                NSDictionary *productInfoDic = @{kProductCategory: category,kProductSubCategory: subCategory,kProductRange: productRange,kMeasureRange: measureRange,kProductBrand: brand,kProductModel: model};
                                
                                NSString *temp = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@",sku_id,@"#",item,@"#",quantity,@"#",total_price,@"#",tax_code,@"#",tax_value,@"#",status,@"#",pluCode,@"#",editedPrice,@"#",mrpPrice,@"#",itemFlag];
                                
                                
                                //added by Srinivasulu on 12/04/2017 && 12/08/2017 && 21/08/2017 && 08/09/2017 && 29/08/2018....

                                NSMutableDictionary * productInfoMutDic = [productInfoDic mutableCopy];
                                
                                productInfoMutDic[kItemDept] = departmentStr;
                                productInfoMutDic[kItemSubDept] = subDepartmentStr;
                                
                                productInfoMutDic[STYLE] = styleStr;
                                productInfoMutDic[PATTERN] = patternStr;
                                productInfoMutDic[BATCH] = batchStr;
                                productInfoMutDic[COLOR] = colorStr;
                                productInfoMutDic[SIZE] = sizeStr;
                                productInfoMutDic[SECTION] = sectionStr;
                                productInfoMutDic[HSN_CODE] = hsnCodeStr;
                                productInfoMutDic[UTILITY] = utilityStr;
                                
                                if(isTaxInclusiveStr.integerValue)
                                    productInfoMutDic[TAX_INCLUSIVE] = @YES;
                                
                                else
                                    productInfoMutDic[TAX_INCLUSIVE] = @NO;
                                
                                productInfoMutDic[PRODUCT_CLASS] = productClassStr;
                                productInfoMutDic[PRODUCT_SUB_CLASS] = productSubClassStr;
                                productInfoMutDic[STYLE_RANGE] = styleRangeStr;
                                
                                productInfoMutDic[EDIT_PRICE_REASON] = editPriceReasonStr;
                                
                                productInfoMutDic[VOID_ITEM_REASON] = voidItemReasonStr;
                                
                                productInfoMutDic[EXPIRY_DATE] = expiryDateStr;
                                productInfoMutDic[Pack_Size] = packSizeStr;
                                
                                //                            [productInfoArr addObject:productInfoDic];
                                [productInfoArr addObject:productInfoMutDic];
                                
                                //upto here on 12/04/2017 && 12/08/2017 && 21/08/2017 && 08/09/2017 && 29/08/2018....

                                
                                [itemDiscountArr addObject:itemDiscount];
                                [itemDiscountDescArr addObject:itemDiscountDesc];
                                [itemScanCodeArr addObject:itemScanCode];
                                [discountPriceArr addObject:discountPrice];
                                [manufacturedItemsArr addObject:[NSNumber numberWithBool:isManufacturedItem]];
                                [packagedItemsArr addObject:[NSNumber numberWithBool:isPackedItem]];
                                
                                [itemsArr addObject:temp];
                                
                            }
                        sqlite3_finalize(localSelectStmt);
                        localSelectStmt = nil;
                        NSString *str = @"";
                        
                        for (int i = 0; i < itemsArr.count; i++) {
                            
                            NSArray *temp = [itemsArr[i] componentsSeparatedByString:@"#"];
                            str  = [NSString stringWithFormat:@"%@%@%@", str, temp[0],@"#"];
                            str  = [NSString stringWithFormat:@"%@%@%@", str, temp[1],@"#"];
                            
                            str  = [NSString stringWithFormat:@"%@%@%@", str, temp[3],@"#"];
                            str  = [NSString stringWithFormat:@"%@%@%@", str, temp[2],@"#"];
                            str  = [NSString stringWithFormat:@"%@%@%@", str, temp[1],@"#"];
                            str = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@", str, temp[4], @"#",temp[5] , @"#", temp[6], @"#", temp[7],@"#",temp[8],@"#", temp[9],@"#",temp[10],@"#@"];
                            
                            
                        }
                        totalBillItems = [[WebServiceUtility getBillingItemsFrom:str itemDiscountArr:itemDiscountArr itemDiscountDescArr:itemDiscountDescArr offerPriceArray:nil dealPriceArray:nil itemScanCode:itemScanCodeArr turnOverOffer:0 totalPriceBeforeTurnOver:0 salesPersonInfo:nil manufacturedItems:manufacturedItemsArr packagedItemsArr:packagedItemsArr productInfoArr:productInfoArr otherDiscountValue:@"0.00"] mutableCopy];
                        
                        for (int i = 0; i < totalBillItems.count; i++) {
                            NSMutableDictionary *itemDict = totalBillItems[i];
                            [itemDict setValue:@([discountPriceArr[i] floatValue]) forKey:DISCOUNT_PRICE_3];
                            
                            //added by Srinivasulu on 18/08/2017....
                            
                            if(discountPriceArr.count > i)
                                [itemDict setValue:@([discountPriceArr[i] floatValue]) forKey:@"discountPrice"];
                            
                            if(itemUnitPriceArr.count > i)
                                [itemDict setValue:[NSString stringWithFormat:@"%.2f",[itemUnitPriceArr[i] floatValue] ] forKey:@"itemUnitPrice"];
                            
                            if(itemsTotalCostArr.count > i)
                                [itemDict setValue:[NSString stringWithFormat:@"%.2f",[itemsTotalCostArr[i] floatValue] ] forKey:@"item_total_price"];
                            
                            totalBillItems[i] = itemDict;
                            
                            //upto here on on 18/08/2017....
                            
                        }
                    }
                    else {
                        NSLog(@"%s",sqlite3_errmsg(localDatabase)) ;
                        return;
                    }
                    
                    NSString *tax_query = [NSString stringWithFormat:@"select * from billing_taxes where bill_id='%@'",bill_ids[i]];
                    
                    const char *sqlTaxStatement1 = tax_query.UTF8String;
                    
                    NSMutableArray *totalTaxDetails = [[NSMutableArray alloc] init];
                    if(sqlite3_prepare_v2(localDatabase, sqlTaxStatement1, -1, &localSelectStmt, NULL) == SQLITE_OK) {
                        NSMutableDictionary *taxDic = [[NSMutableDictionary alloc]init];
                        
                        if(sqlite3_column_count(localSelectStmt))
                            while (sqlite3_step(localSelectStmt) == SQLITE_ROW) {
                                
                                NSString  *tax_name = @"";
                                
                                if (sqlite3_column_text(localSelectStmt, 2) != nil) {
                                    
                                    tax_name = @((char *)sqlite3_column_text(localSelectStmt, 2));
                                    
                                }
                                NSString  *tax_price = @"";
                                
                                if (sqlite3_column_text(localSelectStmt, 3) != nil) {
                                    
                                    tax_price = @((char *)sqlite3_column_text(localSelectStmt, 3));
                                    
                                }
                                
                                NSString  *bill_date = [WebServiceUtility getCurrentDate];
                                
                                if (sqlite3_column_text(localSelectStmt, 4) != nil) {
                                    
                                    bill_date = @((char *)sqlite3_column_text(localSelectStmt, 4));
                                    
                                }
                                
                                [taxDic setValue:tax_name forKey:TAX_NAME];
                                [taxDic setValue:tax_price forKey:TAX_AMOUNT];
                                [taxDic setValue:bill_date forKey:@"bill_date"];
                                [totalTaxDetails addObject:taxDic];
                                
                            }
                        sqlite3_finalize(localSelectStmt);
                        localSelectStmt = nil;
                        //                        NSString *str = @"";
                        
                    }
                    else {
                        NSLog(@"%s",sqlite3_errmsg(localDatabase)) ;
                        return;
                    }
                    
                    NSString *tax_item_query = [NSString stringWithFormat:@"select * from billing_item_taxes where bill_id='%@'",bill_ids[i]];
                    
                    const char *sqlTaxStatement7 = tax_item_query.UTF8String;
                    
                    NSMutableArray *itemTaxDetails = [[NSMutableArray alloc] init];
                    if(sqlite3_prepare_v2(localDatabase, sqlTaxStatement7, -1, &localSelectStmt, NULL) == SQLITE_OK) {
                        
                        
                        if(sqlite3_column_count(localSelectStmt))
                            while (sqlite3_step(localSelectStmt) == SQLITE_ROW) {
                                
                                //                            const char *sqlStatement = "create table if not exists billing_item_taxes (bill_id text, sku_id text, plu_code text,tax_category double,tax_code text,tax_type text,tax_rate text, text)";
                                
                                NSString  *sku_id = @"";
                                if (sqlite3_column_text(localSelectStmt, 1) != nil) {
                                    sku_id = @((char *)sqlite3_column_text(localSelectStmt, 1));
                                }
                                
                                NSString  *plu_code = @"";
                                if (sqlite3_column_text(localSelectStmt, 2) != nil) {
                                    plu_code = @((char *)sqlite3_column_text(localSelectStmt, 2));
                                }
                                
                                
                                NSString  *tax_category = @"";
                                if (sqlite3_column_text(localSelectStmt, 3) != nil) {
                                    tax_category = @((char *)sqlite3_column_text(localSelectStmt, 3));
                                }
                                NSString  *tax_code = @"";
                                if (sqlite3_column_text(localSelectStmt, 4) != nil) {
                                    tax_code = @((char *)sqlite3_column_text(localSelectStmt, 4));
                                }
                                NSString  *tax_type = @"";
                                if (sqlite3_column_text(localSelectStmt, 5) != nil) {
                                    tax_type = @((char *)sqlite3_column_text(localSelectStmt, 5));
                                }
                                NSString  *tax_rate = @"";
                                if (sqlite3_column_text(localSelectStmt, 6) != nil) {
                                    tax_rate = @((char *)sqlite3_column_text(localSelectStmt, 6));
                                }
                                NSString  *tax_value = @"";
                                if (sqlite3_column_text(localSelectStmt, 7) != nil) {
                                    tax_value = @((char *)sqlite3_column_text(localSelectStmt, 7));
                                }
                                NSMutableDictionary *taxDic = [[NSMutableDictionary alloc]init];
                                
                                [taxDic setValue:sku_id forKey:@"sku_id"];
                                [taxDic setValue:plu_code forKey:@"plu_code"];
                                [taxDic setValue:tax_category forKey:@"tax_category"];
                                [taxDic setValue:tax_code forKey:@"tax_code"];
                                [taxDic setValue:tax_type forKey:@"tax_type"];
                                [taxDic setValue:tax_rate forKey:@"tax_rate"];
                                [taxDic setValue:tax_value forKey:@"tax_value"];
                                [itemTaxDetails addObject:taxDic];
                                
                            }
                        sqlite3_finalize(localSelectStmt);
                        localSelectStmt = nil;
                        //                        NSString *str = @"";
                        
                    }
                    else {
                        NSLog(@"%s",sqlite3_errmsg(localDatabase)) ;
                        return;
                    }
                    
                    NSString *itransaction_query = [NSString stringWithFormat:@"select * from billing_transactions where bill_id='%@'",bill_ids[i]];
                    
                    const char *sqlStatement2 = itransaction_query.UTF8String;
                    
                    
                    if(sqlite3_prepare_v2(localDatabase, sqlStatement2, -1, &localSelectStmt, NULL) == SQLITE_OK) {
                        
                        transactionArr = [[NSMutableArray alloc]init];
                        
                        if(sqlite3_column_count(localSelectStmt))
                            while (sqlite3_step(localSelectStmt) == SQLITE_ROW) {
                                
                                NSString  *mode_of_payment = @"";
                                if (sqlite3_column_text(localSelectStmt, 1) != nil) {
                                    mode_of_payment = @((char *)sqlite3_column_text(localSelectStmt, 1));
                                    
                                }
                                NSString  *transaction_id = @"";
                                if (sqlite3_column_text(localSelectStmt, 2) != nil) {
                                    transaction_id = @((char *)sqlite3_column_text(localSelectStmt, 2));
                                }
                                NSString  *card_type = @"";
                                if (sqlite3_column_text(localSelectStmt, 3) != nil) {
                                    card_type = @((char *)sqlite3_column_text(localSelectStmt, 3));
                                }
                                //                                NSString  *card_subtype = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStmt, 4)];
                                
                                NSString  *card_no = @"";
                                if (sqlite3_column_text(localSelectStmt, 5) != nil) {
                                    card_no = @((char *)sqlite3_column_text(localSelectStmt, 5));
                                }
                                NSString  *paid_amt = @"";
                                if (sqlite3_column_text(localSelectStmt, 6) != nil) {
                                    paid_amt = @((char *)sqlite3_column_text(localSelectStmt, 6));
                                }
                                NSString  *date = @"";
                                if (sqlite3_column_text(localSelectStmt, 7) != nil) {
                                    date = @((char *)sqlite3_column_text(localSelectStmt, 7));
                                }
                                //NSString  *date = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStmt, 7)];
                                NSString  *bankInfo = @((char *)sqlite3_column_text(localSelectStmt, 8));
                                NSString  *appCode = @((char *)sqlite3_column_text(localSelectStmt, 9));
                                NSString  *bankname = @((char *)sqlite3_column_text(localSelectStmt, 10));
                                NSString  *changeReturn = @((char *)sqlite3_column_text(localSelectStmt, 11));
                                NSString  *receivedAmt = @((char *)sqlite3_column_text(localSelectStmt, 12));
                                
                                //added by Srinivasulu on 27/11/2017....
                                
                                NSString  * transactionModeStr  = @"";
                                NSString  * transactionsKey = @"0";
                                
                                if ((sqlite3_column_text(localSelectStmt, 13) != nil)  && ((char *)sqlite3_column_text(localSelectStmt,13))){
                                    
                                    transactionModeStr  = @((char *)sqlite3_column_text(localSelectStmt, 13));
                                }
                                if ((sqlite3_column_text(localSelectStmt, 14) != nil)  && ((char *)sqlite3_column_text(localSelectStmt,14))){
                                    
                                    transactionsKey  = @((char *)sqlite3_column_text(localSelectStmt, 14));
                                }
                                
                                //added by Srinivasulu on 31/03/2018....
                                
                                NSString  * transActionTypeStr = @"0";
                                
                                if( (char *)sqlite3_column_text(localSelectStmt, 15)  && (sqlite3_column_text(localSelectStmt, 15) != nil) ){
                                    
                                    transActionTypeStr = @((char *)sqlite3_column_text(localSelectStmt, 15));
                                }
                                
                                //upto here on 31/03/2018....
                                
                                //upto here on 27/11/2017....
                                
                                NSMutableDictionary *transDic = [NSMutableDictionary new];
                                [transDic setValue:mode_of_payment forKey:MODE_OF_PAY];
                                [transDic setValue:card_type forKey:CARD_TYPE];
                                [transDic setValue:card_no forKey:COUPON_NO];
                                [transDic setValue:paid_amt forKey:PAID_AMT];
                                [transDic setValue:transaction_id forKey:@"transactionId"];
                                
                                [transDic setValue:bankInfo forKey:CARD_INFO];
                                [transDic setValue:appCode forKey:APPROVAL_CODE];
                                [transDic setValue:bankname forKey:BANK_NAME];
                                
                                [transDic setValue:date forKey:@"dateTime"];
                                [transDic setValue:changeReturn forKey:CHANGE_RETURN];
                                [transDic setValue:receivedAmt forKey:RECEIVED_AMOUNT];
                                
                                //added by Srinivasulu on 27/11/2017 && 31/03/2018....
                                
                                [transDic setValue:transactionModeStr forKey:TENDER_MODE];
                                [transDic setValue:transactionsKey forKey:TENDER_KEY];
                                
                                if(transActionTypeStr.integerValue)
                                    [transDic setValue:@YES forKey:TRANSACTION_TYPE_FLAG];
                                else
                                    [transDic setValue:@NO forKey:TRANSACTION_TYPE_FLAG];
                                //upto here on 27/11/2017 && 31/03/2018....
                                
                                [transactionArr addObject:transDic];
                                
                            }
                        sqlite3_finalize(localSelectStmt);
                        localSelectStmt = nil;
                        
                        
                    }
                    else {
                        NSLog(@"%s",sqlite3_errmsg(localDatabase)) ;
                        return;
                    }
                    NSArray *denomination_req = [NSArray new];
                    for (int i = 0; i < transactionArr.count; i++) {
                        NSDictionary *dic = transactionArr[i];
                        denomination_req =[self getDenomination:bill_id transaction_id:[dic valueForKey:@"txID"]];
                        
                    }
                    
                    //added by Srinivasulu on 12/07/2017....
                    
                    for(int i = 0; i < totalBillItems.count; i++){
                        
                        
                        NSMutableDictionary * itemDic = totalBillItems[i];
                        
                        //                NSString * itemTotalPrice = [itemDic valueForKey:@"item_total_price"];
                        
                        float itemTaxValue = 0.00;
                        
                        for( NSDictionary * itemLevelTaxDic in itemTaxDetails ){
                            
                            if(([[itemDic valueForKey:SKU_ID] isEqualToString:[itemLevelTaxDic valueForKey:SKU_ID]]) && ([[itemDic valueForKey:PLU_CODE] isEqualToString:[itemLevelTaxDic valueForKey:@"plu_code"]])){
                                
                                itemTaxValue += [[itemLevelTaxDic valueForKey:@"tax_value"] floatValue];
                            }
                            
                        }
                        
                        
                        [itemDic setValue:[NSString stringWithFormat:@"%.2f",itemTaxValue] forKey:@"taxCost"];
                        
                        totalBillItems[i] = itemDic;
                        
                    }
                    
                    //upto here on 12/07/2017....
                    
                    
                    NSArray *itemCampaigns = [NSArray new];
                    OfflineBillingServices *offline = [OfflineBillingServices new];
                    itemCampaigns = [offline getItemsCampaignsInfo:bill_id];
                    
                    NSArray *keys = @[BILL_ID,REQUEST_HEADER,CASHIER_ID,COUNTER,TOTAL_BILL_DISCOUNT,DISCOUNT_TYPE,DISCOUNT_TYPE_ID,TAX,TOTAL_BILL_AMT,BILL_DUE,CUSTOMER_EMAIL,MOBILE_NO,STATUS,STORE_LOCATION,SHIFT_ID,BILL_ITEMS,BILLING_TRANSACTIONS,DENOMINATION,BILLING_DATE,CUSTOMER_NAME,PRINT_COUNT,OTHER_DISCOUNT,BUSSINESS_DATE,SCAN_START_TIME,SCAN_END_TIME,PRINT_TIME,BILL_TAXES,BILL_TIME_DURATION,BILL_TIME_DURATION_ACCEPT_PRINT,BILL_ITEM_TAXES,kItemCampigns,@"billingChannel",@"cashierName",@"subTotal",kCustomerBillId,kSerialBillId];
                    
                    NSArray *objects  = @[bill_id,[RequestHeader getRequestHeader],cashierId,counter_id,Total_discount,discount_type,discount_type_id,tax,total_price,due_amount, email_id,phone_number,status,presentLocation,[NSString stringWithFormat:@"%@",shiftId],totalBillItems,transactionArr,denomination_req,date,customer_name,print_count,other_disc,bussiness_date,scan_start_date,scan_end_date,print_date,totalTaxDetails,bill_duration_time,bill_duration_accept_print,itemTaxDetails,itemCampaigns,@"Direct",firstName,total_price,@(isCustomerBillId),serialBillId];
                    
                    //changed by Srinivasulu  on 12/07/2017 &&  03/08/2017 && 12/08/2017 && 08/09/2017 && 24/03/2018 && 28/06/2018....
                    
                    //                    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
                    NSMutableDictionary * dictionary = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
                    
                    dictionary[OTHER_DISCOUNT_DESC] = otherDiscDescriptionStr;
                    dictionary[CASHIER_NAME] = cashierNameStr;
                    
                    if(registerStr != nil)
                        dictionary[REGISTER] = registerStr;
                    
                    if(employeeSaleIdStr != nil)
                        dictionary[kEmployeeSaleId] = otherDiscDescriptionStr;
                    
                    if(subTotalStr != nil)
                        dictionary[@"subTotalStr"] = subTotalStr;
                    
                    if(lastUpdateDateStr != nil)
                        dictionary[@"lastUpdateDateStr"] = lastUpdateDateStr;
                    
                    if(customerGstinStr != nil)
                        dictionary[CUSTOMER_GSTIN] = customerGstinStr;
                    
                    dictionary[IS_OFFLINE_BILL] = [NSNumber numberWithBool:true];
                    dictionary[OFFLINE_BILL] = [NSNumber numberWithBool:true];
                    dictionary[BILL_AMOUNT] = billAmountStr;
                    dictionary[BILL_CANCEL_REASON] = billCancelReasonStr;
                    dictionary[kComments] = billRemarksStr;
                    
                    dictionary[SALES_ORDER_ID] = saleOrderIdStr;
                    dictionary[SHIPPING_CHARGES] = shipmentChargesStr;
                    //upto here on 12/07/2017 && 03/08/2017 && 12/08/2017 && 08/09/2017 && 24/03/2018 && 28/06/2018....
                    
                    
                    /*
                     NSString * otherDiscDescriptionStr = @"";
                     NSString * registerStr;
                     NSString * employeeSaleIdStr;
                     NSString * cashierNameStr;
                     NSString * subTotalStr = @"";
                     NSString * lastUpdateDateStr;
                     NSString * customerGstinStr;*/
                    
                    //upto here on 1207/2017....
                    
                    
                    NSError * err;
                    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
                    //                    NSString * createBillingJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                    
                    @try {
                        
                        NSString *serviceUrl = [WebServiceUtility getURLFor:CREATE_BILLING_WITH_BODY];
                        serviceUrl = [NSString stringWithFormat:@"%@",serviceUrl];
                        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
                        
                        NSURL *url = [NSURL URLWithString:serviceUrl];
                        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                                             timeoutInterval:60.0];
                        request.HTTPMethod = @"POST";
                        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
                        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
                        request.HTTPBody = jsonData;
                        
                        NSError *error = nil;
                        NSHTTPURLResponse *responseCode = nil;
                        
                        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
                        NSDictionary *billingResponse = [NSJSONSerialization JSONObjectWithData:data options:0
                                                                                          error:NULL];
                        
                        int responseCodeValue = 0;
                        
                        NSLog(@"BILL RESPONSE ---------- %@",billingResponse);
                        
                        if (data) {
                            
                            //changed by Srinivasulu on  11/08/2017 && on 02/02/2018....
                            if(!billingResponse.allKeys.count){
                                
                                isBillSaved = FALSE;
                            }
                            else if (([[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue] == 0) || ([[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE] caseInsensitiveCompare:DUPLICATE_BILL_ID_RESOPNSE_FROM_SERVICES] == NSOrderedSame)  || ([[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue] == -DUPLICATE_BILL_ID_RESOPNSE_CODE)) {
                                
                                //upto here on 11/08/2017 && on 02/02/2018....
                                
                                isBillSaved = TRUE;
                                
                            }
                            else {
                                
                                if([billingResponse.allKeys containsObject:RESPONSE_HEADER] && (![[billingResponse valueForKey:RESPONSE_HEADER] isKindOfClass:[NSNull class]]) )
                                    if([[[billingResponse valueForKey:RESPONSE_HEADER] allKeys] containsObject:RESPONSE_CODE] && (![[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] isKindOfClass:[NSNull class]]) ){
                                        responseCodeValue = [[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue];
                                
                                        //added by Srinivasulu on 28/04/2018 && 04/10/2018....
                                        if(([[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue] == -DUPLICATE_BILL_ID_RESOPNSE_CODE_WITH_AMOUNT_MISS_MATCH)){
                                            
                                            OfflineBillingServices *offline = [[OfflineBillingServices alloc]init];
                                            
                                            //bussiness_date -- dictionary
                                            if([bussiness_date componentsSeparatedByString:@" "].count){
                                                
                                                [offline changeSerialBuildIdLocally:[offline getAndReturnMaximumOfflineBillCount:[bussiness_date componentsSeparatedByString:@" "][0]  DefaultSerialBillId:serialBillId] originalBillId:bill_id];
                                            }
                                            
                                        }
                                        else if(([[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue] == -DUPLICATE_BILL_ID_RESOPNSE_CODE_DUE_TO_PRIMARY_CODE_MATCH)){
                                            
                                            @try {
                                                OfflineBillingServices * offline = [[OfflineBillingServices alloc]init];
                                                
                                                NSString * existBillIdStr = [dictionary valueForKey:BILL_ID];
                                                
                                                int changeNumber = [NSString stringWithFormat:@"%c", [existBillIdStr characterAtIndex: existBillIdStr.length - 1]].intValue;
                                                changeNumber = changeNumber + 1;
                                                int totalNumberOfTransactions = 0;
                                                //                                                NSRange range = NSMakeRange( existBillIdStr.length - 1,1);
                                                
                                                NSString * newBillIdStr = [NSString stringWithFormat:@"%@%i",[existBillIdStr substringToIndex:existBillIdStr.length - 1],changeNumber] ;
                                                
                                                if([dictionary.allKeys containsObject:TRANSACTION_DETAILS] && ! [[dictionary valueForKey:TRANSACTION_DETAILS] isKindOfClass:[NSNull class]])
                                                    totalNumberOfTransactions = (int)[[dictionary valueForKey:TRANSACTION_DETAILS] count];
                                                
                                                [offline changeOriginalBillIdLocally:newBillIdStr existingBillId:existBillIdStr numberOfPayment:totalNumberOfTransactions transactionInfo:[dictionary valueForKey:TRANSACTION_DETAILS]];
                                            } @catch (NSException *exception) {
                                                
                                            } @finally {
                                                
                                            }
                                        }
                                        
                                        //upto here on 28/04/2018 && 04/10/2018....
                                        
                                    }
                                isBillSaved = FALSE;
                            }
                        }
                        
                        else {
                            isBillSaved = FALSE;
                        }
                        
                        if (isBillSaved) {
                            
                            [self updateBillStatus:bill_id status:SUCCESS];
                            //                            [self deleteLocalBills:bill_id];
                            
                        }
                        else {
                            if (([billSaveStatus isEqualToString:TO_BE_UPLOADED]) && (responseCodeValue != 0)) {
                                
                                [self updateBillStatus:bill_id status:PENDING];
                            }
                            else if (([billSaveStatus isEqualToString:PENDING]) && (responseCodeValue != 0)) {
                                
                                [self updateBillStatus:bill_id status:ERROR];
                            }
                        }
                        syncStatus = FALSE;
                        
                    }
                    @catch (NSException *exception) {
                        
                        [SHUD hide:YES afterDelay:2.0];
                        isBillSaved = false;
                        
                    }
                    
                    uploodedBillId = [bill_id copy];
                    
                    sqlite3_close(localDatabase);
                    
                    [self uploadReturnedItems:bill_id date:currentdate];
                    [self uploadExchangedItems:bill_id date:currentdate];
                    
                }
                
                
            }
            //           [self synchCustomerDetails];
            
        }
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
        
    }
    @finally {
        syncStatus = FALSE;
        
        //added by Srinivasulu on 14/06/2017....
        
        @try {
            int count = [self getLocalBillCount];
            
            refreshBtn.badgeValue = [NSString stringWithFormat:@"%d",count];
            
            //for(UIView * view in self.navigationController.navigationBar.subviews){
            
            for(UIView * view in  self.navigationItem.rightBarButtonItem.customView.subviews){
                
                
                // if(view.tag == 2){
                
                for(UIView * view1 in view.subviews){
                    
                    if(view1.frame.origin.x == refreshBtn.frame.origin.x){
                        
                        UIButton * btn = (UIButton *)view1;
                        
                        btn.badgeValue = [NSString stringWithFormat:@"%d",count];
                        
                        break;
                        
                    }
                    
                }
                // break;
                
                //}
                
            }
        } @catch (NSException *exception) {
            
        }
        
        //upto here on 14/06/2017....
        
        sqlite3_close(localDatabase);
        return;
    }
    
}


- (void)closeHudView{
    
    [SHUD setHidden:YES];
    
}

- (void)uploadReturnedItems:(NSString *)bill_id date:(NSString *)currentDate
{
    NSString *return_status = @"";
    NSMutableArray *returnItems = [[NSMutableArray alloc]init];
    
    static sqlite3 * localDatabase = nil;
    static sqlite3_stmt * localSelectStmt = nil;
    
    @try {
        
        
        NSString* dbPath = [DataBaseConnection connection:@"RetailerBillingDataBase.sqlite"];
        
        
        if(sqlite3_open(dbPath.UTF8String, &localDatabase) == SQLITE_OK) {
            
            NSString *return_items_query = [NSString stringWithFormat:@"select * from return_items where bill_id='%@'",bill_id];
            
            const char *sqlStatement3 = return_items_query.UTF8String;
            if(sqlite3_prepare_v2(localDatabase, sqlStatement3, -1, &localSelectStmt, NULL) == SQLITE_OK) {
                
                if(sqlite3_column_count(localSelectStmt))
                    while (sqlite3_step(localSelectStmt) == SQLITE_ROW) {
                        
                        NSString  *billID = @((char *)sqlite3_column_text(localSelectStmt, 1));
                        NSString  *counterID = @((char *)sqlite3_column_text(localSelectStmt, 8));
                        NSString  *reason = @((char *)sqlite3_column_text(localSelectStmt, 9));
                        NSString  *status = @((char *)sqlite3_column_text(localSelectStmt, 10));
                        return_status = [status copy];
                        NSString  *item_name = @((char *)sqlite3_column_text(localSelectStmt, 3));
                        NSString *dateTime = @((char *)sqlite3_column_text(localSelectStmt, 7));
                        currentDate = [dateTime copy];
                        NSString  *item_price = @((char *)sqlite3_column_text(localSelectStmt, 5));
                        NSString  *cost = @((char *)sqlite3_column_text(localSelectStmt, 6));
                        NSString  *quantity = @((char *)sqlite3_column_text(localSelectStmt, 4));
                        NSString  *sku_id = @((char *)sqlite3_column_text(localSelectStmt, 2));
                        NSString  *taxCode = @((char *)sqlite3_column_text(localSelectStmt, 11));
                        NSString  *taxValue = @((char *)sqlite3_column_text(localSelectStmt, 12));
                        NSString  *pluCode = @((char *)sqlite3_column_text(localSelectStmt, 13));
                        
                        NSDictionary *temp = @{@"bill_id": billID,@"counter_id": counterID,@"reason": reason,@"status": status,ITEM_NAME: item_name,@"bill_date": dateTime,ITEM_UNIT_PRICE: item_price,COST: cost,QUANTITY: quantity,SKU_ID: sku_id,TAX_CODE: taxCode,TAX_RATE_STR: taxValue,PLU_CODE: pluCode};
                        
                        [returnItems addObject:temp];
                        
                    }
                sqlite3_finalize(localSelectStmt);
                localSelectStmt = nil;
                
            }
            else {
                
                NSLog(@"%s",sqlite3_errmsg(localDatabase));
            }
        }
        
        if (returnItems.count>0) {
            
            NSArray *headerKeys1 = @[@"billId",@"requestHeader", @"billReturnItems", @"denominations", @"status", @"bill_date", @"storeLocation"];
            
            NSArray *headerObjects1 = @[bill_id,[RequestHeader getRequestHeader],returnItems,[self prepareDenominationString:nil], return_status, currentDate, presentLocation];
            NSDictionary *dictionary1 = [NSDictionary dictionaryWithObjects:headerObjects1 forKeys:headerKeys1];
            
            NSError * err1;
            NSData * jsonData1 = [NSJSONSerialization dataWithJSONObject:dictionary1 options:0 error:&err1];
            NSString * jsonString = [[NSString alloc] initWithData:jsonData1 encoding:NSUTF8StringEncoding];
            
            NSString *serviceUrl = [WebServiceUtility getURLFor:RETURN_BILLING];
            serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,jsonString];
            serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
            
            NSURL *url = [NSURL URLWithString:serviceUrl];
            NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                                 timeoutInterval:60.0];
            request.HTTPMethod = @"POST";
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
            
            NSError *error = nil;
            NSHTTPURLResponse *responseCode = nil;
            
            NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
            NSDictionary *billingResponse = [NSJSONSerialization JSONObjectWithData:data options:0
                                             
                                                                              error:NULL];
            NSLog(@"%@",billingResponse);
            
        }
    }
    @catch (NSException *exception) {
        
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Problem occured while processing" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //        [alert show];
        NSLog(@"%@",exception.description);
        
        
    }
    @finally {
        sqlite3_close(localDatabase);
    }
}

- (void)uploadExchangedItems:(NSString *)bill_id date:(NSString *)currentDate
{
    NSString *exchange_status = @"";
    NSMutableArray *exchangeItems = [[NSMutableArray alloc]init];
    static sqlite3 * localDatabase = nil;
    static sqlite3_stmt * localSelectStmt = nil;
    
    @try {
        
        
        
        
        NSString* dbPath = [DataBaseConnection connection:@"RetailerBillingDataBase.sqlite"];
        
        
        if(sqlite3_open(dbPath.UTF8String, &localDatabase) == SQLITE_OK) {
            
            NSString *exchange_items_query = [NSString stringWithFormat:@"select * from exchange_items where bill_id='%@'",bill_id];
            
            const char *sqlStatement3 = exchange_items_query.UTF8String;
            if(sqlite3_prepare_v2(localDatabase, sqlStatement3, -1, &localSelectStmt, NULL) == SQLITE_OK) {
                
                if(sqlite3_column_count(localSelectStmt))
                    while (sqlite3_step(localSelectStmt) == SQLITE_ROW) {
                        
                        NSString  *billID = @((char *)sqlite3_column_text(localSelectStmt, 1));
                        NSString  *counterID = @((char *)sqlite3_column_text(localSelectStmt, 8));
                        NSString  *reason = @((char *)sqlite3_column_text(localSelectStmt, 9));
                        NSString  *status = @((char *)sqlite3_column_text(localSelectStmt, 11));
                        exchange_status = [status copy];
                        NSString  *item_name = @((char *)sqlite3_column_text(localSelectStmt, 3));
                        NSString *dateTime = @((char *)sqlite3_column_text(localSelectStmt, 7));
                        currentDate = [dateTime copy];
                        NSString  *item_price = @((char *)sqlite3_column_text(localSelectStmt, 5));
                        NSString  *cost = @((char *)sqlite3_column_text(localSelectStmt, 6));
                        NSString  *quantity = @((char *)sqlite3_column_text(localSelectStmt, 4));
                        NSString  *sku_id = @((char *)sqlite3_column_text(localSelectStmt, 2));
                        NSString  *exchanged_bill = @((char *)sqlite3_column_text(localSelectStmt, 10));
                        NSString  *taxCode = @((char *)sqlite3_column_text(localSelectStmt, 12));
                        NSString  *taxRate = @((char *)sqlite3_column_text(localSelectStmt, 13));
                        NSString  *pluCode = @((char *)sqlite3_column_text(localSelectStmt, 14));
                        
                        NSDictionary *temp = @{@"bill_id": billID,@"counter_id": counterID,@"reason": reason,@"status": status,ITEM_NAME: item_name,@"bill_date": dateTime,ITEM_UNIT_PRICE: item_price,COST: cost,QUANTITY: quantity,SKU_ID: sku_id,@"exchanged_bill_id": exchanged_bill,TAX_CODE: taxCode,TAX_RATE_STR: taxRate,PLU_CODE: pluCode};
                        
                        
                        [exchangeItems addObject:temp];
                        
                    }
                sqlite3_finalize(localSelectStmt);
                localSelectStmt = nil;
                
            }
            else {
                
                NSLog(@"%s",sqlite3_errmsg(localDatabase));
            }
        }
        if (exchangeItems.count>0) {
            
            NSArray *headerKeys1 = @[@"billId",@"requestHeader", @"billExchangedItems", @"denominations", @"status", @"bill_date", @"storeLocation"];
            
            NSArray *headerObjects1 = @[bill_id,[RequestHeader getRequestHeader],exchangeItems,[self prepareDenominationString:nil], exchange_status, currentDate, presentLocation];
            NSDictionary *dictionary1 = [NSDictionary dictionaryWithObjects:headerObjects1 forKeys:headerKeys1];
            
            NSError * err1;
            NSData * jsonData1 = [NSJSONSerialization dataWithJSONObject:dictionary1 options:0 error:&err1];
            NSString * jsonString = [[NSString alloc] initWithData:jsonData1 encoding:NSUTF8StringEncoding];
            
            NSString *serviceUrl = [WebServiceUtility getURLFor:Exchange_BILLING];
            serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,jsonString];
            serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
            
            NSURL *url = [NSURL URLWithString:serviceUrl];
            NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                                 timeoutInterval:60.0];
            request.HTTPMethod = @"POST";
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
            
            NSError *error = nil;
            NSHTTPURLResponse *responseCode = nil;
            
            NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
            NSDictionary *billingResponse = [NSJSONSerialization JSONObjectWithData:data options:0
                                                                              error:NULL];
            
        }
    }
    @catch (NSException *exception) {
        sqlite3_close(localDatabase);
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Problem occured while processing" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //        [alert show];
        
    }
    @finally {
        sqlite3_close(localDatabase);
    }
}

-(NSArray*)getDenomination:(NSString *)bill_id transaction_id:(NSString *)transaction_id {
    
    NSMutableArray *denomArr = [[NSMutableArray alloc]init];
    
    NSString *denomination_query = [NSString stringWithFormat:@"select * from billing_denomination where bill_id='%@'",bill_id];
    
    const char *sqlStatement1 = denomination_query.UTF8String;
    
    static sqlite3 * localDatabase = nil;
    static sqlite3_stmt * localSelectStmt = nil;
    
    if(sqlite3_prepare_v2(localDatabase, sqlStatement1, -1, &localSelectStmt, NULL) == SQLITE_OK) {
        itemsArr = [[NSMutableArray alloc]init];
        
        
        if(sqlite3_column_count(localSelectStmt))
            while (sqlite3_step(localSelectStmt) == SQLITE_ROW) {
                
                
                NSString  *denom = @((char *)sqlite3_column_text(localSelectStmt, 1));
                NSString  *denomNo = @((char *)sqlite3_column_text(localSelectStmt, 2));
                NSString  *paidAmt = @((char *)sqlite3_column_text(localSelectStmt, 3));
                NSString  *returnDenomNo = @((char *)sqlite3_column_text(localSelectStmt, 4));
                NSString  *returnAmt = @((char *)sqlite3_column_text(localSelectStmt,5));
                NSString  *date = @((char *)sqlite3_column_text(localSelectStmt,6));
                transaction_id = @((char *)sqlite3_column_text(localSelectStmt,7));
                
                NSDictionary *temp = @{@"denomination": denom,@"paidDenominationNo": denomNo,@"transactionId": transaction_id,@"billId": bill_id,@"billDate": date,@"paidAmount": paidAmt,@"returnAmount": returnAmt,@"returnDenominationNo": returnDenomNo};
                
                [denomArr addObject:temp];
                
            }
        sqlite3_finalize(localSelectStmt);
        localSelectStmt = nil;
        
    }
    else {
        NSLog(@"%s",sqlite3_errmsg(localDatabase)) ;
    }
    return denomArr;
    
    
}

-(void)updateBillStatus:(NSString *)bill_id status:(NSString *)status {
    
    static sqlite3 * localDatabase = nil;
    static sqlite3_stmt * localSelectStmt = nil;
    static sqlite3_stmt * localDelectStmt = nil;
    @try {
        
        
        
        
        NSString* dbPath = [DataBaseConnection connection:@"RetailerBillingDataBase.sqlite"];
        
        
        if(sqlite3_open(dbPath.UTF8String, &localDatabase) == SQLITE_OK) {
            
            if (localDelectStmt == nil) {
                NSString *query = [NSString stringWithFormat:@"update billing_table SET save_status='%@' where bill_id='%@'",status,bill_id];
                const char *sqlStatement = query.UTF8String;
                
                if(sqlite3_prepare_v2(localDatabase, sqlStatement, -1, &localDelectStmt, NULL) == SQLITE_OK) {
                    
                    if(SQLITE_DONE != sqlite3_step(localDelectStmt)){
                        NSLog(@"%s",sqlite3_errmsg(localDatabase));
                        NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(localDatabase));
                    }
                    
                    sqlite3_reset(localDelectStmt);
                    sqlite3_finalize(localDelectStmt);
                }
                localDelectStmt = nil;
                
            }
            
            
        }
        
        
        
    }
    @catch (NSException *exception) {
        [SHUD hide:YES afterDelay:2.0];
        NSLog(@"%@",exception);
        
        
    }
    @finally {
        sqlite3_close(localDatabase);
        localDelectStmt = nil;
        localSelectStmt = nil;
        
    }
    
}

-(NSArray *)prepareDenominationString:(NSString *)total{
    
    NSDate *today = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"dd/MM/yyyy HH:mm:ss";
    NSString* currentdate = [f stringFromDate:today];
    
    NSMutableArray *tempArr = [[NSMutableArray alloc]init];
    NSArray *keys = @[@"denomination",@"paidDenominationNo",@"transactionId",@"billId",@"billDate",@"paidAmount",@"returnAmount",@"returnDenominationNo"];
    @try {
        
        for (int i=0; i<denominationDic.allKeys.count; i++) {
            
            
            NSArray *objects = @[denominationDic.allKeys[i],[denominationDic valueForKey:denominationDic.allKeys[i]],@"",@"",currentdate,[NSString stringWithFormat:@"%.2f",[denominationDic.allKeys[i] floatValue]*[[denominationDic valueForKey:denominationDic.allKeys[i]] intValue]],@"0.00",@"0"];
            NSDictionary *dic = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            [tempArr addObject:dic];
            
        }
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
    }
    
    
    
    return tempArr;
    
}

-(void)syncOfflinebillsToOnline:(NSInteger)statusNo{
    
    @try {
        
        if (statusNo == 0) {
            
            isOfflineService = false;
            CheckWifi *wifi = [[CheckWifi alloc] init];
            BOOL status = [wifi checkWifi];
            
            if (status && shiftId.length>0) {
                
                //changed by Srinivasulu on 06/09/2018...
                //                [self synchCustomerDetails];
                
                if(SHUD == nil){
                    SHUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
                    [self.navigationController.view addSubview:SHUD];
                    // Regiser for HUD callbacks so we can remove it from the window at the right time
                    SHUD.delegate = self;
                    SHUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
                    SHUD.mode = MBProgressHUDModeCustomView;
                    SHUD.hideDelegate = self;
                }
                
                SHUD.labelText= @"Customer Details....";
                [SHUD show:YES];
                [SHUD setHidden:NO];
                
                OfflineBillingServices * offline = [[OfflineBillingServices alloc] init];
                [offline updateCustomerDetailsBasedOnStatus:1];

                //                            [self deleteUploadedBillsFromLocal];
                [self synchUpLocalBills];
            }
            
            int count = [self getLocalBillCount];
            
            //            for(UIView * view in self.navigationController.navigationBar.subviews){
            
            for(UIView * view in  self.navigationItem.rightBarButtonItem.customView.subviews){
                
                //                if(view.tag == 2){
                
                for(UIView * view1 in view.subviews){
                    
                    if(view1.frame.origin.x == refreshBtn.frame.origin.x){
                        
                        UIButton * btn = (UIButton *)view1;
                        
                        btn.badgeValue = [NSString stringWithFormat:@"%d",count];
                        
                        break;
                        
                    }
                    
                }
                //                    break;
                
                //                }
                
            }
            
        }else{
            
            
        }
    } @catch (NSException *exception) {
        [SHUD setHidden:YES];
    } @finally {
        
    }
}


//written by Srinivauslu on 14/08/2017......



//upto here on  14/08/2017....


@end
