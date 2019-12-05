

//
//  OmniRetailerViewController.m
//  OmniRetailer
//
//  Created by Satya Siva Saradhi on 9/20/12.
//  Copyright 2012 __techolabssoftware.com__. All rights reserved.
//

#import "OmniRetailerViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "OmniHomePage.h"
#import "ServiceConfigView.h"
#import "WebViewController.h"
#import "Global.h"
#import "SettingsManager.h"
#import "SalesServiceSvc.h"
#import "Reachability.h"
#import "LoginServiceSvc.h"
#import "MemberServiceSvc.h"
#import "memberServicesSvc.h"
#import "appSettingsSvc.h"
#import "ChangePasswordView.h"
#import "CheckWifi.h"
#import "DataBaseConnection.h"
#import "sqlite3.h"
#import "CheckWifi.h"
#import "WCAlertView.h"
#import "KeychainItemWrapper.h"
#import "RequestHeader.h"
#import "WebServiceConstants.h"
#import <sys/utsname.h>


//commented by Srinivasulu on 22/08/2017...
//reason inorder to redue the crashs acrossed around this variable.. It has changed from class varible to local varible....

//NSUserDefaults * defaults;


static sqlite3 *database = nil;
//static sqlite3_stmt *insertStmt = nil;
//static sqlite3_stmt *deleteStmt = nil;
static sqlite3_stmt *selectStmt = nil;

ServiceConfigView *serviceConfigView1;

@implementation OmniRetailerViewController

@synthesize regbut ,loginbut;//
@synthesize userIDtxt, passwordtxt, confirmPasswordtxt, emailIDtxt, firstNametxt, lastNametxt,deviceIDtxt,countrytxt;
@synthesize segmentedControl;
@synthesize registrationView,loginView;
@synthesize soundFileURLRef,soundFileObject;




NSString* machineName()
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    return @(systemInfo.machine);
}
/*- (void)dealloc
 {
 [super dealloc];
 
 [regbut release];
 [loginbut release];
 
 [userIDtxt release];
 [passwordtxt release];
 [confirmPasswordtxt release];
 [emailIDtxt release];
 [deviceIDtxt release];
 [countrytxt release];
 [firstNametxt release];
 [lastNametxt release];
 
 [registrationView release];
 [loginView release];
 [HUD release];
 [segmentedControl release];
 
 
 listOfCountries = nil;
 [listOfCountries release];
 
 [countrysTable release];
 
 }*/


// verified by chandhu, shiva

#pragma  -mark start of ViewLifeCycle mehods....

/**
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date
 * @method       ViewDidLoad
 * @author
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 20/07/2017...
 * @reason      added comments....
 *
 */

- (void)viewDidLoad{
    
    //    version = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    //    btManager = [BluetoothManager sharedInstance];
    btDevItems = [[NSMutableArray alloc] init];
    
    //    UIDevice *myDevice = [UIDevice currentDevice];
    //
    //    deviceUDID = [[myDevice identifierForVendor] UUIDString];
    //
    //    NSLog(@"Device ID is >>>>>>>>>> %@",deviceUDID);
    
    NSUserDefaults * defaults = [[NSUserDefaults alloc] init];
    
    if ([[defaults valueForKey:@"lastPriceUpdated"] isKindOfClass:[NSNull class]] || [[defaults valueForKey:@"lastPriceUpdated"] length] == 0) {
        [defaults setValue:[defaults valueForKey:@"lastSkuUpdated"] forKey:@"lastPriceUpdated"];
    }
    
    
    
    if (!([[defaults valueForKey:IS_URL_SSL] isKindOfClass:[NSNull class]] || [defaults valueForKey:IS_URL_SSL] == nil)){
        if([[defaults valueForKey:IS_URL_SSL] boolValue])
            serviceURLTypeStr = HTTPS;
        else
            serviceURLTypeStr = HTTP;
    }
    
    
    
    
    //adding the notifications for powa device connection.....
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(accessoryDidConnect:)
                                                 name:EAAccessoryDidConnectNotification
                                               object:nil];
    
    [[EAAccessoryManager sharedAccessoryManager] registerForLocalNotifications];
    
    
    // [[NSNotificationCenter defaultCenter] addObserver: self selector:@selector(deviceOrientationDidChange:) name: UIDeviceOrientationDidChangeNotification object: nil];
    
    syncStatus = TRUE;
    
    currentOrientation = [UIDevice currentDevice].orientation;
    
    
    //added by Srinivasulu on 26/03/2018....
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && !(currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight))
        currentOrientation = UIDeviceOrientationLandscapeRight;
    
    
    //upto here on 26/03/2018....
    
    
    
    float version = [UIDevice currentDevice].systemVersion.floatValue;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        NSArray *views = self.view.subviews;
        backgroundImageView = views[0];
    }
    else{
        NSArray *views = self.view.subviews;
        //  NSArray *views1 = [[views objectAtIndex:0] subviews];
        backgroundImageView = views[0];
    }
    
    
    
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    //    menubar.tintColor=[UIColor colorWithRed:145.0/255.0 green:145.0/255.0 blue:145.0/255.0 alpha:1.0];
    
    loginbut = [UIButton buttonWithType:UIButtonTypeCustom];
    regbut = [UIButton buttonWithType:UIButtonTypeCustom];
    
    lab1 = [[UILabel alloc] init];
    
    lab2 = [[UILabel alloc] init];
    
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (__bridge CFURLRef) tapSound;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    UIImage *toolsImage;
    UIImage *usersImage;
    UIImage *helpImage;
    
    NSArray *imgArry;
    
    float width = (self.view.frame.size.width + 20) / 3;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        //        toolsImage = [[UIImage imageNamed:@"Toolss@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //        usersImage = [[UIImage imageNamed:@"Users@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //        helpImage = [[UIImage imageNamed:@"Help@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        
        toolsImage = [[self  imageFromImage:[UIImage imageNamed:@"Toolss@2x.png"]
                       imageBackGroundColor:[UIColor blackColor]
                                     string:NSLocalizedString(@"cloud_config", nil)
                                      color:[UIColor colorWithRed:0  green:230 blue:230 alpha:0.7]
                                       font:16
                                      width:width
                                     height:16
                                   fontType:TEXT_FONT_NAME
                                 imageWidth:40
                                imageHeight:40] imageWithRenderingMode:
                      UIImageRenderingModeAlwaysOriginal];
        
        usersImage = [[self  imageFromImage:[UIImage imageNamed:@"Users@2x.png"]
                       imageBackGroundColor:[UIColor blackColor]
                                     string:NSLocalizedString(@"about_us", nil)
                                      color:[UIColor colorWithRed:0  green:230 blue:230 alpha:0.7]
                                       font:16
                                      width:width
                                     height:16
                                   fontType:TEXT_FONT_NAME
                                 imageWidth:40
                                imageHeight:40] imageWithRenderingMode:
                      UIImageRenderingModeAlwaysOriginal];
        
        helpImage = [[self  imageFromImage:[UIImage imageNamed:@"Help@2x.png"]
                      imageBackGroundColor:[UIColor blackColor]
                                    string:NSLocalizedString(@"help", nil)
                                     color:[UIColor colorWithRed:0  green:255 blue:230 alpha:0.7]
                                      font:16
                                     width:width
                                    height:16
                                  fontType:TEXT_FONT_NAME
                                imageWidth:40
                               imageHeight:40] imageWithRenderingMode:
                     UIImageRenderingModeAlwaysOriginal];
        
        imgArry = @[toolsImage,usersImage,helpImage];
    }
    else{
        if (version >= 8.0) {
            imgArry = @[[[UIImage imageNamed:@"Toolss@iphone.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],[[UIImage imageNamed:@"Users@iphone.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],[[UIImage imageNamed:@"Help@iphone.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        }
        else{
            imgArry = @[[UIImage imageNamed:@"Toolss@iphone.png"],[UIImage imageNamed:@"Users@iphone.png"],[UIImage imageNamed:@"Help@iphone.png"]];
        }
        
    }
    
    segmentedControl = [[UISegmentedControl alloc] initWithItems:imgArry];
    
    CGSize cgsize = CGSizeMake(0.0, 0.0);
    
    
    for (int i = 0; i < imgArry.count; i++) {
        [segmentedControl setContentOffset:cgsize forSegmentAtIndex:i];
    }
    
    //    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    
    [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7){
        segmentedControl.tintColor = [UIColor colorWithRed:145.0/255.0 green:145.0/255.0 blue:145.0/255.0 alpha:1.0];
        //segmentedControl.backgroundColor = [UIColor colorWithRed:0.61176f green:0.61176f  blue:0.61176f  alpha:1.0f];
    }
    else{
        segmentedControl.tintColor = [UIColor clearColor];
    }
    segmentedControl.tintColor = [UIColor clearColor];
    segmentedControl.backgroundColor = [UIColor blackColor];
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        
        if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
            
            //added by Srinivasulu on 23/09/2017....
            
            
            self.view.frame = CGRectMake(0, 0, [UIScreen mainScreen ].bounds .size.width, [UIScreen mainScreen ].bounds .size.height);
            //upto here on 23/09/2017....
            
            
            backgroundImageView.image = [UIImage imageNamed:@"SplashScreen.png"];
            backgroundImageView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height - 58);
            
            loginbut = [UIButton buttonWithType:UIButtonTypeCustom];
            loginbut.frame = CGRectMake(183,480,350,60);
            //[loginbut setTitle:@"Login" forState:(UIControlStateNormal)];
            [loginbut setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            [loginbut addTarget:self action:@selector(ButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *shapePath = [UIBezierPath bezierPathWithRoundedRect:loginbut.bounds
                                                            byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft
                                                                  cornerRadii:CGSizeMake(25.0, 25.0)];
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            shapeLayer.frame = loginbut.bounds;
            shapeLayer.path = shapePath.CGPath;
            shapeLayer.fillColor = [UIColor whiteColor].CGColor;
            [loginbut.layer addSublayer:shapeLayer];
            [self.view addSubview:loginbut];
            
            lab1 = [[UILabel alloc] init];
            lab1.frame = CGRectMake(320,480,150,60);
            lab1.text = @"Login";
            lab1.font = [UIFont systemFontOfSize:25];
            [self.view addSubview:lab1];
            
            imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(200, 480, 60, 60)];
            UIImage *img1 = [UIImage imageNamed:@"LoginIcon@2x.png"];
            imageview1.image = img1;
            [self.view addSubview:imageview1];
            
            
            
            
            regbut = [UIButton buttonWithType:UIButtonTypeCustom];
            regbut.frame = CGRectMake(535,480,350,60);
            //[regbut setTitle:@"Register" forState:(UIControlStateNormal)];
            [regbut setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            [regbut addTarget:self action:@selector(ButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            UIBezierPath *shapePath1 = [UIBezierPath bezierPathWithRoundedRect:regbut.bounds
                                                             byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight
                                                                   cornerRadii:CGSizeMake(25.0, 25.0)];
            
            CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
            shapeLayer1.frame = regbut.bounds;
            shapeLayer1.path = shapePath1.CGPath;
            shapeLayer1.fillColor = [UIColor whiteColor].CGColor;
            [regbut.layer addSublayer:shapeLayer1];
            [self.view addSubview:regbut];
            
            
            lab2 = [[UILabel alloc] init];
            lab2.frame = CGRectMake(670,480,150,60);
            lab2.text = @"Register";
            lab2.font = [UIFont systemFontOfSize:25];
            [self.view addSubview:lab2];
            
            
            imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(550, 480, 60, 60)];
            UIImage *img2 = [UIImage imageNamed:@"Registration@2x.png"];
            imageview2.image = img2;
            [self.view addSubview:imageview2];
            //            segmentedControl.frame = CGRectMake(-6,720,self.view.frame.size.width+20, 80);
            segmentedControl.frame = CGRectMake( -6, self.view.frame.size.height - 60, self.view.frame.size.width + 20, 60);
        }
        else {
            backgroundImageView.image = [UIImage imageNamed:@"Background.png"];
            backgroundImageView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.height,self.view.frame.size.width);
            
            loginbut = [UIButton buttonWithType:UIButtonTypeCustom];
            loginbut.frame = CGRectMake(33,780,350,60);
            //[loginbut setTitle:@"Login" forState:(UIControlStateNormal)];
            [loginbut setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            [loginbut addTarget:self action:@selector(ButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *shapePath = [UIBezierPath bezierPathWithRoundedRect:loginbut.bounds
                                                            byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft
                                                                  cornerRadii:CGSizeMake(25.0, 25.0)];
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            shapeLayer.frame = loginbut.bounds;
            shapeLayer.path = shapePath.CGPath;
            shapeLayer.fillColor = [UIColor whiteColor].CGColor;
            [loginbut.layer addSublayer:shapeLayer];
            [self.view addSubview:loginbut];
            
            lab1 = [[UILabel alloc] init];
            lab1.frame = CGRectMake(170,780,150,60);
            lab1.text = @"Login";
            lab1.font = [UIFont systemFontOfSize:25];
            [self.view addSubview:lab1];
            
            imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 780, 60, 60)];
            UIImage *img1 = [UIImage imageNamed:@"LoginIcon@2x.png"];
            imageview1.image = img1;
            [self.view addSubview:imageview1];
            
            
            regbut = [UIButton buttonWithType:UIButtonTypeCustom];
            regbut.frame = CGRectMake(385,780,350,60);
            //[regbut setTitle:@"Register" forState:(UIControlStateNormal)];
            [regbut setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            [regbut addTarget:self action:@selector(ButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            UIBezierPath *shapePath1 = [UIBezierPath bezierPathWithRoundedRect:regbut.bounds
                                                             byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight
                                                                   cornerRadii:CGSizeMake(25.0, 25.0)];
            
            CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
            shapeLayer1.frame = regbut.bounds;
            shapeLayer1.path = shapePath1.CGPath;
            shapeLayer1.fillColor = [UIColor whiteColor].CGColor;
            [regbut.layer addSublayer:shapeLayer1];
            [self.view addSubview:regbut];
            
            
            lab2 = [[UILabel alloc] init];
            lab2.frame = CGRectMake(520,780,150,60);
            lab2.text = @"Register";
            lab2.font = [UIFont systemFontOfSize:25];
            [self.view addSubview:lab2];
            
            
            imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(400, 780, 60, 60)];
            UIImage *img2 = [UIImage imageNamed:@"Registration@2x.png"];
            imageview2.image = img2;
            [self.view addSubview:imageview2];
            segmentedControl.frame = CGRectMake(-6,965,780,60);
        }
        
        
        //segmentedControl.tintColor=[UIColor colorWithRed:125.0/255.0 green:125.0/255.0 blue:125.0/255.0 alpha:1.0];
        
    }
    else {
        
        if (version >= 8.0) {
            backgroundImageView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width+30, self.view.frame.size.height+40);
            loginbut = [UIButton buttonWithType:UIButtonTypeCustom];
            loginbut.frame = CGRectMake(20,self.view.frame.size.height-80,140,35);
            [loginbut setTitle:@"Login" forState:(UIControlStateNormal)];
            [loginbut setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            //loginbut.titleLabel.font = [UIFont boldSystemFontOfSize:10.0];
            //loginbut.layer.masksToBounds = YES;
            [loginbut addTarget:self action:@selector(ButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:loginbut];
            UIBezierPath *shapePath = [UIBezierPath bezierPathWithRoundedRect:loginbut.bounds
                                                            byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft
                                                                  cornerRadii:CGSizeMake(15.0, 15.0)];
            
            
            imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(25, self.view.frame.size.height-80, 33, 35)];
            UIImage *img1 = [UIImage imageNamed:@"LoginIcon@2x.png"];
            imageview1.image = img1;
            [self.view addSubview:imageview1];
            
            
            
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            shapeLayer.frame = loginbut.bounds;
            shapeLayer.path = shapePath.CGPath;
            shapeLayer.fillColor = [UIColor whiteColor].CGColor;
            //shapeLayer.strokeColor = [UIColor blackColor].CGColor;
            //shapeLayer.lineWidth = 2;
            [loginbut.layer addSublayer:shapeLayer];
            
            
            regbut = [UIButton buttonWithType:UIButtonTypeCustom];
            regbut.frame = CGRectMake(161,self.view.frame.size.height-80,140,35);
            [regbut setTitle:@"Register" forState:(UIControlStateNormal)];
            [regbut setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            //regbut.titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
            //regbut.backgroundColor = [UIColor whiteColor];
            //regbut.layer.masksToBounds = YES;
            [regbut addTarget:self action:@selector(ButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            UIBezierPath *shapePath1 = [UIBezierPath bezierPathWithRoundedRect:regbut.bounds
                                                             byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight
                                                                   cornerRadii:CGSizeMake(15.0, 15.0)];
            
            CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
            shapeLayer1.frame = regbut.bounds;
            shapeLayer1.path = shapePath1.CGPath;
            shapeLayer1.fillColor = [UIColor whiteColor].CGColor;
            //shapeLayer1.strokeColor = [UIColor blackColor].CGColor;
            //shapeLayer1.lineWidth = 2;
            [regbut.layer addSublayer:shapeLayer1];
            [self.view addSubview:regbut];
            
            
            imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(162, self.view.frame.size.height-80, 33, 35)];
            UIImage *img2 = [UIImage imageNamed:@"Registration@2x.png"];
            imageview2.image = img2;
            [self.view addSubview:imageview2];
            
            segmentedControl.frame = CGRectMake(-2,(self.view.frame.size.height+40),324,47);
            
        }
        else{
            backgroundImageView.image = [UIImage imageNamed:@"Background.png"];
            backgroundImageView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width+10, self.view.frame.size.height-20.0);
            loginbut = [UIButton buttonWithType:UIButtonTypeCustom];
            loginbut.frame = CGRectMake(20,330,140,35);
            [loginbut setTitle:@"Login" forState:(UIControlStateNormal)];
            [loginbut setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            //loginbut.titleLabel.font = [UIFont boldSystemFontOfSize:10.0];
            //loginbut.layer.masksToBounds = YES;
            [loginbut addTarget:self action:@selector(ButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:loginbut];
            UIBezierPath *shapePath = [UIBezierPath bezierPathWithRoundedRect:loginbut.bounds
                                                            byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft
                                                                  cornerRadii:CGSizeMake(15.0, 15.0)];
            
            
            imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(25, 330, 33, 35)];
            UIImage *img1 = [UIImage imageNamed:@"LoginIcon@2x.png"];
            imageview1.image = img1;
            [self.view addSubview:imageview1];
            
            
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            shapeLayer.frame = loginbut.bounds;
            shapeLayer.path = shapePath.CGPath;
            shapeLayer.fillColor = [UIColor whiteColor].CGColor;
            //shapeLayer.strokeColor = [UIColor blackColor].CGColor;
            //shapeLayer.lineWidth = 2;
            [loginbut.layer addSublayer:shapeLayer];
            
            
            regbut = [UIButton buttonWithType:UIButtonTypeCustom];
            regbut.frame = CGRectMake(161,330,140,35);
            [regbut setTitle:@"Register" forState:(UIControlStateNormal)];
            [regbut setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            //regbut.titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
            //regbut.backgroundColor = [UIColor whiteColor];
            //regbut.layer.masksToBounds = YES;
            [regbut addTarget:self action:@selector(ButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            UIBezierPath *shapePath1 = [UIBezierPath bezierPathWithRoundedRect:regbut.bounds
                                                             byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight
                                                                   cornerRadii:CGSizeMake(15.0, 15.0)];
            
            CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
            shapeLayer1.frame = regbut.bounds;
            shapeLayer1.path = shapePath1.CGPath;
            shapeLayer1.fillColor = [UIColor whiteColor].CGColor;
            //shapeLayer1.strokeColor = [UIColor blackColor].CGColor;
            //shapeLayer1.lineWidth = 2;
            [regbut.layer addSublayer:shapeLayer1];
            [self.view addSubview:regbut];
            
            imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(162, 330, 33, 35)];
            UIImage *img2 = [UIImage imageNamed:@"Registration@2x.png"];
            imageview2.image = img2;
            [self.view addSubview:imageview2];
            segmentedControl.frame = CGRectMake(-2,417,324,47);
        }
        
    }
    [self.view addSubview:segmentedControl];
    
    //    regbut.enabled = FALSE;
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    //    [menubar addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    //Initialize the array.
    listOfCountries = [[NSMutableArray alloc] init];
    
    //Add items
    [listOfCountries addObject:@"Evolution"];
    [listOfCountries addObject:@"Registered Customer"];
    
    // Country Table inilaization....
    countrysTable = [[UITableView alloc] init];
    countrysTable.bounces = FALSE;
    countrysTable.layer.borderWidth = 1.0;
    countrysTable.layer.cornerRadius = 4.0;
    countrysTable.layer.borderColor = [UIColor blackColor].CGColor;
    countrysTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    countrysTable.dataSource = self;
    countrysTable.delegate = self;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        countrysTable.frame = CGRectMake(250, 310, 300, 360);
    }
    else {
        countrysTable.frame = CGRectMake(70, 85, 185, 230);
    }
    [self.view addSubview:countrysTable];
    countrysTable.hidden = YES;
    
    //added by Srinivasulu on 16/04/2018....
    
    changeModeSwitch = [[UISwitch alloc] init];
    [changeModeSwitch setOn:true];
    changeModeSwitch.tag = 4;
    [changeModeSwitch addTarget:self action:@selector(changeWifiSwitchAction:) forControlEvents:UIControlEventValueChanged];
    changeModeSwitch.onTintColor = [UIColor colorWithRed:76.0/255.0 green:217.0/255.0 blue:100.0/255.0 alpha:1.0];
    changeModeSwitch.tintColor = [UIColor colorWithRed:76.0/255.0 green:217.0/255.0 blue:100.0/255.0 alpha:1.0];
    
    changeModeSwitch.frame = CGRectMake( regbut.frame.origin.x + regbut.frame.size.width/2, 40, 45, 45);
    
    [self.view addSubview:changeModeSwitch];
    
    //upto here on 16/04/2018....
    
    [self setFontFamily:@"ArialRoundedMTBold" forView:self.view andSubViews:YES];
    
    
    //
}

/**
 * @description  it is one of ViewLifeCylce Method which will be executed after execution of
 viewDidAppear.......
 * @date
 * @method       viewWillAppear
 * @author
 * @param        BOOL
 * @param
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 20/07/2017...
 * @reason      added comments....
 *
 */

-(void)viewDidAppear:(BOOL)animated{
    
    UILabel * deviceIdLbl;
    
    @try {
        
        [super viewDidAppear:YES];
        
        //    NSNumber *number = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
        //    [[UIDevice currentDevice]setValue:number forKey:@"orientation"];
        
        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        animation.duration = 3.5f;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = @"rippleEffect" ;
        [backgroundImageView.layer addAnimation:animation forKey:NULL];
        
        SystemSoundID    soundFileObject1;
        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"water" withExtension: @"mp3"];
        self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
        AudioServicesPlaySystemSound (soundFileObject1);
        
        //added by Srinivasulu on 20/07/2017....
        //it is bring and pasted here for logging service call....
        //in bellow commented code....
        
        //        UIDevice * myDevice = [UIDevice currentDevice];
        
        //        custID = [userIDtxt.text copy];
        //        custID = @"Technolabs----";
        
        //        KeychainItemWrapper * keyChainItem = [[KeychainItemWrapper alloc] initWithIdentifier:custID accessGroup:nil];
        //        if ([[keyChainItem objectForKey:(__bridge id)(kSecAttrAccount)] length] == 0) {
        //
        //            deviceUDID = [[myDevice identifierForVendor] UUIDString];
        //            //            deviceUDID = DEVICE_ID;
        //            [keyChainItem setObject:deviceUDID forKey:(__bridge id)(kSecAttrAccount)];
        //            deviceId = deviceUDID;
        //        }
        //        else {
        //
        //            deviceId = [keyChainItem objectForKey:(__bridge id)(kSecAttrAccount)];
        //        }
        //
        
        UIDevice * myDevice = [UIDevice currentDevice];
        
        deviceUDID = myDevice.identifierForVendor.UUIDString;
        deviceId = deviceUDID;
        
        //if we want static device id....
        //while giving the build this line of code should be commented.. written by Srinivasulu on 21/08/2017....
        
        deviceId = DEVICE_ID;
        
        //upto here on  21/08/2017....
        
        deviceIdLbl = [[UILabel alloc] init];
        deviceIdLbl.text = [NSString stringWithFormat:@"%@%@", NSLocalizedString(@"device_id_:", nil), deviceId];
        deviceIdLbl.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
        deviceIdLbl.backgroundColor = [UIColor clearColor];
        deviceIdLbl.layer.cornerRadius = 10.0f;
        deviceIdLbl.layer.masksToBounds = YES;
        deviceIdLbl.textAlignment = NSTextAlignmentCenter;
        deviceIdLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20];
        
        [self.view addSubview:deviceIdLbl];
        
        deviceIdLbl.frame = CGRectMake( (self.view.frame.size.width - 700)/2, 120, 700, 74);
        
        //upto here on 20/07/2017....
        
        
        //added by Srinivasulu on 16/04/2018....
        
        isWifiSelectionChanged = FALSE;
        
        CheckWifi *wifi = [[CheckWifi alloc] init];
        BOOL status = [wifi checkWifi];
        
        if (status){
            
            changeModeSwitch.tag = 4;
            [changeModeSwitch setOn:true];
            isOfflineService = false;
        }
        else{
            
            [changeModeSwitch setOn:false];
            isOfflineService = true;
            changeModeSwitch.tintColor = [UIColor redColor];
            changeModeSwitch.layer.cornerRadius = 16;
            changeModeSwitch.backgroundColor = [UIColor redColor];
        }
        
        //upto here on 16/04/2018....
    } @catch (NSException *exception) {
        
        deviceId = DEVICE_ID;
        
        if(deviceIdLbl != nil)
            deviceIdLbl.text = [NSString stringWithFormat:@"%@%@", NSLocalizedString(@"device_id_:", nil), deviceId];
        
    } @finally {
        
    }
}

/**
 * @description  it is one of ViewLifeCylce Method which will be executed when complete view was disappering.......
 * @date
 * @method       viewDidUnload
 * @author
 * @param
 * @param
 *
 * @return
 *
 *
 * @modified By Srinivasulu on 20/07/2017...
 * @reason      added comments and added the try and catch blocks  && commented by Srinivasulu on 21/10/2017  this method is deprecated in iOS 6.0....
 *
 * @verified By
 * @verified On
 *
 */

//- (void)viewDidUnload
//{
//
//    @try {
//
//        [super viewDidUnload];
//        // Release any retained subviews of the main view.
//        // e.g. self.myOutlet = nil;
//
//        [self setUserIDtxt:nil];
//        [self setPasswordtxt:nil];
//        [self setConfirmPasswordtxt:nil];
//        [self setEmailIDtxt:nil];
//        [self setFirstNametxt:nil];
//        [self setLastNametxt:nil];
//
//    } @catch (NSException *exception) {
//
//    } @finally {
//
//    }
//
//}

#pragma -mark end of ViewLifeCylce Methods....

/**
 * @description  it will be executed when memory warning is receiveds.......
 * @date
 * @method       didReceiveMemoryWarning
 * @author
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 20/07/2017...
 * @reason      added comments....
 *
 */

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


// global notification callback
void MyCallBack (CFNotificationCenterRef center,
                 void *observer,
                 CFStringRef name,
                 const void *object,
                 CFDictionaryRef userInfo) {
    NSLog(@"CFN Name:%@ Data:%@", name, userInfo);
}


//- (void)viewDidAppear:(BOOL)animated {
//
//
//    [[SettingsManager sharedSettingsManager] load];
//    NSString *LastDate = [[SettingsManager sharedSettingsManager] getValue:@"Installed"];
//    NSString *daysfinish = [[SettingsManager sharedSettingsManager] getValue:@"Counter"];
//
//    if(LastDate) {
//
//        int mycount = [daysfinish intValue];
//
//        // getting the values ..
//        NSString *getdate = [LastDate copy];
//        NSDateFormatter *f = [[NSDateFormatter alloc] init];
//        [f setDateFormat:@"yyyyMMdd"];
//
//        // install date ..
//        NSDate* installedDate = [f dateFromString:getdate];
//
//        // current date ..
//        NSDate *presentdate = [NSDate date];
//        presentdate = [f dateFromString:[f stringFromDate:presentdate]];
//
//        // comparing days between dates ..
//        int i = [installedDate timeIntervalSince1970];
//        int j = [presentdate timeIntervalSince1970];
//
//        double X = j-i;
//
//        int days=(int)((double)X/(3600.0*24.00));
//
//        mycount = mycount + abs(days);
//
//        // updating the file with new values ..
//        [[SettingsManager sharedSettingsManager] setValue:@"Installed" newString:[f stringFromDate:presentdate]];
//        [[SettingsManager sharedSettingsManager] setValue:@"Counter" newString:[NSString stringWithFormat:@"%d",mycount]];
//        [[SettingsManager sharedSettingsManager] save];
//
//        [f release];
//
//        // check the validation .. if the counter value is more than 15 then exit the app ..
//        if (mycount >= 30) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Expired" message:[NSString stringWithFormat:@"%@",@"Trial version Expired "] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//            [alert release];
//            exit(0);
//        }
//        else if (mycount < 30) {
//
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:[NSString stringWithFormat:@"%@%d%@",@"Trial version: Will expire in ",(30 - mycount),@" days"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//            [alert release];
//
//        }
//    }
//    else {
//
//        // first object is date ..
//        NSDate *installdate = [NSDate date];
//        NSDateFormatter *f = [[NSDateFormatter alloc] init];
//        [f setDateFormat:@"yyyyMMdd"];
//        NSString* filename = [f stringFromDate:installdate];
//        [f release];
//
//        // second object is counter value of zero ..
//        NSString *countervalue = [NSString stringWithFormat:@"%d",0];
//
//        // Adding the two values to a file ..
//        [[SettingsManager sharedSettingsManager] setValue:@"Installed" newString:filename];
//        [[SettingsManager sharedSettingsManager] setValue:@"Counter" newString:countervalue];
//        [[SettingsManager sharedSettingsManager] save];
//
//    }
//
//
//}

#pragma -mark methods related to login button cilck....


- (void) gobackView {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    registrationView.hidden = YES;
    loginView.hidden        = YES;
    
    loginbut.enabled = TRUE;
    regbut.enabled   = TRUE;
    segmentedControl.userInteractionEnabled = TRUE;
    
    [self keyboardHide];
    
}

- (void) keyboardHide {
    
    [userIDtxt resignFirstResponder];
    [passwordtxt resignFirstResponder];
    [confirmPasswordtxt resignFirstResponder];
    [emailIDtxt resignFirstResponder];
    [firstNametxt resignFirstResponder];
    [lastNametxt resignFirstResponder];
}


- (IBAction)ButtonClicked:(id)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    //serviceConfigView1.hidden = YES;
    if ((UIButton *) sender == regbut) {
        
        [self registration];
    }
    else {
        [self logging];
    }
    
}


// registration screen ..
- (void) registration {
    
    loginbut.enabled = FALSE;
    regbut.enabled   = FALSE;
    segmentedControl.userInteractionEnabled = FALSE;
    
    registrationView = [[UIView alloc] init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        registrationView.frame = CGRectMake(200, 10, 668, 700);
    } else {
        registrationView.frame = CGRectMake(10, 20, 300, 460);
    }
    
    registrationView.backgroundColor = [UIColor blackColor];
    registrationView.layer.borderColor = [UIColor blackColor].CGColor;
    registrationView.layer.borderWidth = 1.0f;
    registrationView.layer.cornerRadius = 10;
    registrationView.clipsToBounds = YES;
    registrationView.hidden = NO;
    
    UIImageView *headerimg  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.PNG"]];
    
    UIImageView *headerlogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Registratin.png"]];
    
    
    UILabel *headerlabel = [[UILabel alloc] init];
    headerlabel.text = @"Register";
    (headerlabel.layer).borderColor = [UIColor blackColor].CGColor;
    headerlabel.textColor = [UIColor whiteColor];
    headerlabel.backgroundColor = [UIColor clearColor];
    
    backBut1 = [[UIButton alloc] init];
    [backBut1 setImage:[UIImage imageNamed:@"go-back-icon.png"] forState:UIControlStateNormal];
    [backBut1 addTarget:self action:@selector(gobackView) forControlEvents:UIControlEventTouchDown];
    
    
    
    UILabel *user      = [[UILabel alloc] init];
    UILabel *email     = [[UILabel alloc] init];
    UILabel *diviceID  = [[UILabel alloc] init];
    UILabel *country   = [[UILabel alloc] init];
    UILabel *Fname     = [[UILabel alloc] init];
    UILabel *Lname     = [[UILabel alloc] init];
    UILabel *businessType     = [[UILabel alloc] init];
    
    user.backgroundColor      = [UIColor clearColor];
    email.backgroundColor     = [UIColor clearColor];
    diviceID.backgroundColor  = [UIColor clearColor];
    country.backgroundColor   = [UIColor clearColor];
    Fname.backgroundColor     = [UIColor clearColor];
    Lname.backgroundColor     = [UIColor clearColor];
    businessType.backgroundColor = [UIColor clearColor];
    user.text      = @"Name *";
    email.text     = @"Email *";
    diviceID.text  = @"Device Id";
    country.text   = @"Licence Type *";
    Fname.text     = @"Phone Number *";
    Lname.text     = @"Customer ID *";
    businessType.text = @"Business Info";
    
    user.textColor = [UIColor whiteColor];
    email.textColor = [UIColor whiteColor];
    diviceID.textColor = [UIColor whiteColor];
    country.textColor = [UIColor whiteColor];
    Fname.textColor = [UIColor whiteColor];
    Lname.textColor = [UIColor whiteColor];
    businessType.textColor = [UIColor whiteColor];
    
    userIDtxt          = [[UITextField alloc] init];
    emailIDtxt         = [[UITextField alloc] init];
    deviceIDtxt        = [[UITextField alloc] init];
    countrytxt         = [[UITextField alloc] init];
    firstNametxt       = [[UITextField alloc] init];
    lastNametxt        = [[UITextField alloc] init];
    businessInfo = [[UITextView alloc] init];
    
    //Find Uniqe Iphone DeviceId...
    //    deviceIDtxt.userInteractionEnabled = NO;
    
    //commented by Srinivasulu on 20/07/2017....
    
    
    //    UIDevice *myDevice = [UIDevice currentDevice];
    //    deviceUDID = [[myDevice identifierForVendor] UUIDString];
    //    deviceIDtxt.text   =  deviceUDID;
    
    //changed by Srinivasulu on 20/07/2017....
    
    deviceIDtxt.text   =  deviceId;
    
    
    [deviceIDtxt resignFirstResponder];
    
    //upto here on 20/07/2017...
    
    
    // country selection....
    [countrytxt addTarget:self action:@selector(contrySelectionButtonPressed:) forControlEvents:UIControlEventTouchDown];
    
    UIImageView* imageview1 = [[UIImageView alloc] init];
    UIImage *img1 = [UIImage imageNamed:@"combo.png"];
    imageview1.image = img1;
    [countrytxt addSubview:imageview1];
    
    
    
    userIDtxt.layer.masksToBounds=YES;
    userIDtxt.layer.borderColor=[UIColor grayColor].CGColor;
    userIDtxt.layer.borderWidth= 1.0f;
    
    passwordtxt.layer.masksToBounds=YES;
    passwordtxt.layer.borderColor=[UIColor grayColor].CGColor;
    passwordtxt.layer.borderWidth= 1.0f;
    
    confirmPasswordtxt.layer.masksToBounds=YES;
    confirmPasswordtxt.layer.borderColor=[UIColor grayColor].CGColor;
    confirmPasswordtxt.layer.borderWidth= 1.0f;
    
    emailIDtxt.layer.masksToBounds=YES;
    emailIDtxt.layer.borderColor=[UIColor grayColor].CGColor;
    emailIDtxt.keyboardType = UIKeyboardTypeEmailAddress;
    emailIDtxt.layer.borderWidth= 1.0f;
    
    deviceIDtxt.layer.masksToBounds=YES;
    deviceIDtxt.layer.borderColor=[UIColor grayColor].CGColor;
    deviceIDtxt.layer.borderWidth= 1.0f;
    
    countrytxt.layer.masksToBounds=YES;
    countrytxt.layer.borderColor=[UIColor grayColor].CGColor;
    countrytxt.layer.borderWidth= 1.0f;
    
    firstNametxt.layer.masksToBounds=YES;
    firstNametxt.layer.borderColor=[UIColor grayColor].CGColor;
    firstNametxt.layer.borderWidth= 1.0f;
    
    lastNametxt.layer.masksToBounds=YES;
    lastNametxt.layer.borderColor=[UIColor grayColor].CGColor;
    lastNametxt.layer.borderWidth= 1.0f;
    
    businessInfo.layer.masksToBounds=YES;
    businessInfo.layer.borderColor=[UIColor grayColor].CGColor;
    businessInfo.layer.borderWidth= 1.0f;
    
    userIDtxt.delegate          = self;
    passwordtxt.delegate        = self;
    confirmPasswordtxt.delegate = self;
    emailIDtxt.delegate         = self;
    deviceIDtxt.delegate       = self;
    countrytxt.delegate        = self;
    firstNametxt.delegate       = self;
    lastNametxt.delegate        = self;
    businessInfo.delegate = self;
    
    
    userIDtxt.font = [UIFont fontWithName:@"Arial" size:18.0];
    passwordtxt.font = [UIFont fontWithName:@"Arial" size:18.0];
    confirmPasswordtxt.font = [UIFont fontWithName:@"Arial" size:18.0];
    emailIDtxt.font = [UIFont fontWithName:@"Arial" size:18.0];
    deviceIDtxt.font = [UIFont fontWithName:@"Arial" size:15.0];
    countrytxt.font = [UIFont fontWithName:@"Arial" size:18.0];
    firstNametxt.font = [UIFont fontWithName:@"Arial" size:18.0];
    lastNametxt.font = [UIFont fontWithName:@"Arial" size:18.0];
    businessInfo.font = [UIFont fontWithName:@"Arial" size:18.0];
    
    userIDtxt.backgroundColor          = [UIColor whiteColor];
    passwordtxt.backgroundColor        = [UIColor whiteColor];
    confirmPasswordtxt.backgroundColor = [UIColor whiteColor];
    emailIDtxt.backgroundColor         = [UIColor whiteColor];
    deviceIDtxt.backgroundColor        = [UIColor whiteColor];
    countrytxt.backgroundColor         = [UIColor whiteColor];
    firstNametxt.backgroundColor       = [UIColor whiteColor];
    lastNametxt.backgroundColor        = [UIColor whiteColor];
    businessInfo.backgroundColor        = [UIColor whiteColor];
    
    userIDtxt.layer.cornerRadius           = 4.0f;
    userIDtxt.layer.masksToBounds          = YES;
    passwordtxt.layer.cornerRadius         = 4.0f;
    passwordtxt.layer.masksToBounds        = YES;
    confirmPasswordtxt.layer.cornerRadius  = 4.0f;
    confirmPasswordtxt.layer.masksToBounds = YES;
    emailIDtxt.layer.cornerRadius          = 4.0f;
    emailIDtxt.layer.masksToBounds         = YES;
    deviceIDtxt.layer.cornerRadius        = 4.0f;
    deviceIDtxt.layer.masksToBounds       = YES;
    countrytxt.layer.cornerRadius         = 4.0f;
    countrytxt.layer.masksToBounds        = YES;
    firstNametxt.layer.cornerRadius        = 4.0f;
    firstNametxt.layer.masksToBounds       = YES;
    lastNametxt.layer.cornerRadius         = 4.0f;
    lastNametxt.layer.masksToBounds        = YES;
    businessInfo.layer.cornerRadius         = 4.0f;
    businessInfo.layer.masksToBounds        = YES;
    
    userIDtxt.autocorrectionType = UITextAutocorrectionTypeNo;
    userIDtxt.autocapitalizationType = YES;
    passwordtxt.secureTextEntry        = TRUE;
    passwordtxt.autocapitalizationType = YES;
    confirmPasswordtxt.secureTextEntry = TRUE;
    confirmPasswordtxt.autocapitalizationType = YES;
    emailIDtxt.autocorrectionType = NO;
    emailIDtxt.autocapitalizationType = NO;
    countrytxt.text = @"Evolution";
    lastNametxt.text = @"demofmcg";
    businessInfo.text = @"Please Describe About Your Business";
    businessInfo.textColor = [UIColor lightGrayColor];
    
    registrationbtn = [[UIButton alloc] init];
    [registrationbtn addTarget:self action:@selector(registerClicked:) forControlEvents:UIControlEventTouchDown];
    [registrationbtn setTitle:@"Register" forState:UIControlStateNormal];
    [registrationbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registrationbtn.backgroundColor = [UIColor grayColor];
    registrationbtn.layer.borderColor = [UIColor whiteColor].CGColor;
    registrationbtn.clipsToBounds = YES;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        headerimg.frame = CGRectMake(0, 0, 666, 100);
        
        headerlogo.frame = CGRectMake(40, 25, 60, 60);
        
        headerlabel.font = [UIFont boldSystemFontOfSize:30];
        headerlabel.frame = CGRectMake(280, 30, 250, 60);
        
        backBut1.frame = CGRectMake(600, 25, 70, 70);
        
        user.font = [UIFont systemFontOfSize:20];
        email.font = [UIFont systemFontOfSize:20];
        diviceID.font = [UIFont systemFontOfSize:20];
        country.font = [UIFont systemFontOfSize:20];
        Fname.font = [UIFont systemFontOfSize:20];
        Lname.font = [UIFont systemFontOfSize:20];
        businessType.font = [UIFont systemFontOfSize:20];
        
        user.frame = CGRectMake(40, 115, 200, 50);
        //        password.frame = CGRectMake(40, 175, 200, 50);
        //        con_passw.frame = CGRectMake(40, 240, 200, 50);
        email.frame = CGRectMake(40, 175, 200, 50);
        diviceID.frame = CGRectMake(40, 415, 200, 50);
        country.frame = CGRectMake(40, 295, 200, 50);
        Fname.frame = CGRectMake(40, 235, 200, 50);
        Lname.frame = CGRectMake(40, 355, 200, 50);
        businessType.frame = CGRectMake(40, 475, 200, 50);
        
        userIDtxt.font = [UIFont systemFontOfSize:20];
        passwordtxt.font = [UIFont systemFontOfSize:20];
        confirmPasswordtxt.font = [UIFont systemFontOfSize:20];
        emailIDtxt.font = [UIFont systemFontOfSize:20];
        deviceIDtxt.font = [UIFont systemFontOfSize:15];
        countrytxt.font = [UIFont systemFontOfSize:20];
        firstNametxt.font = [UIFont systemFontOfSize:20];
        lastNametxt.font = [UIFont systemFontOfSize:20];
        
        userIDtxt.frame = CGRectMake(250, 120, 350, 40);
        passwordtxt.frame = CGRectMake(250, 180, 350, 40);
        confirmPasswordtxt.frame = CGRectMake(250, 240, 350, 40);
        emailIDtxt.frame = CGRectMake(250, 180, 350, 40);
        deviceIDtxt.frame = CGRectMake(250, 420, 350, 40);
        countrytxt.frame = CGRectMake(250, 300, 350, 40);
        imageview1.frame = CGRectMake(312, -5, 50, 55);
        firstNametxt.frame = CGRectMake(250, 240, 350, 40);
        lastNametxt.frame = CGRectMake(250, 360, 350, 40);
        businessInfo.frame = CGRectMake(250, 480, 350, 100);
        registrationbtn.frame = CGRectMake(30, 620, 608, 60);
        registrationbtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        registrationbtn.layer.cornerRadius = 25.0f;
        
    } else {
        
        headerimg.frame = CGRectMake(0, 0, 300, 50);
        headerlogo.frame = CGRectMake(20, 7, 40, 40);
        headerlabel.frame = CGRectMake(120, 10, 100, 30);
        backBut1.frame = CGRectMake(260, 10, 30, 30);
        
        user.frame = CGRectMake(10, 60, 150, 30);
        email.frame = CGRectMake(10, 95, 150, 30);
        diviceID.frame = CGRectMake(10, 240, 150, 30);
        country.frame = CGRectMake(10, 170, 150, 30);
        Fname.frame = CGRectMake(10, 130, 150, 30);
        Lname.frame = CGRectMake(10, 205, 150, 30);
        businessType.frame = CGRectMake(10, 275, 150, 30);
        
        user.font = [UIFont systemFontOfSize:12];
        email.font = [UIFont systemFontOfSize:12];
        diviceID.font = [UIFont systemFontOfSize:12];
        country.font = [UIFont systemFontOfSize:12];
        Fname.font = [UIFont systemFontOfSize:12];
        Lname.font = [UIFont systemFontOfSize:12];
        businessType.font = [UIFont systemFontOfSize:12];
        
        userIDtxt.frame = CGRectMake(130, 60, 150, 30);
        passwordtxt.frame = CGRectMake(130, 95, 150, 30);
        confirmPasswordtxt.frame = CGRectMake(130, 130, 150, 30);
        emailIDtxt.frame = CGRectMake(130, 95, 150, 30);
        deviceIDtxt.frame = CGRectMake(130, 240, 150, 30);
        countrytxt.frame = CGRectMake(130, 170, 150, 30);
        imageview1.frame = CGRectMake(127, -4, 30, 40);
        firstNametxt.frame = CGRectMake(130, 130, 150, 30);
        lastNametxt.frame = CGRectMake(130, 205, 150, 30);
        businessInfo.frame = CGRectMake(130, 275, 150, 100);
        
        userIDtxt.font = [UIFont systemFontOfSize:15];
        passwordtxt.font = [UIFont systemFontOfSize:15];
        confirmPasswordtxt.font = [UIFont systemFontOfSize:15];
        emailIDtxt.font = [UIFont systemFontOfSize:15];
        deviceIDtxt.font = [UIFont systemFontOfSize:15];
        countrytxt.font = [UIFont systemFontOfSize:15];
        firstNametxt.font = [UIFont systemFontOfSize:15];
        lastNametxt.font = [UIFont systemFontOfSize:15];
        businessInfo.font = [UIFont systemFontOfSize:15];
        
        registrationbtn.frame = CGRectMake(20, 400, 260, 35);
        registrationbtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        registrationbtn.layer.cornerRadius = 15.0f;
        
    }
    
    [registrationView addSubview:headerimg];
    [registrationView addSubview:headerlogo];
    [registrationView addSubview:headerlabel];
    [registrationView addSubview:backBut1];
    
    [registrationView addSubview:user];
    //    [registrationView addSubview:password];
    //    [registrationView addSubview:con_passw];
    [registrationView addSubview:email];
    [registrationView addSubview:diviceID];
    [registrationView addSubview:country];
    [registrationView addSubview:Fname];
    [registrationView addSubview:Lname];
    [registrationView addSubview:businessType];
    
    [registrationView addSubview:userIDtxt];
    [registrationView addSubview:passwordtxt];
    [registrationView addSubview:confirmPasswordtxt];
    [registrationView addSubview:emailIDtxt];
    [registrationView addSubview:deviceIDtxt];
    [registrationView addSubview:countrytxt];
    [registrationView addSubview:firstNametxt];
    [registrationView addSubview:lastNametxt];
    [registrationView addSubview:businessInfo];
    
    [registrationView addSubview:registrationbtn];
    
    [self.view addSubview:registrationView];
    
}


//registerClicked method Commented  by roja on 17/10/2019.. (changes are done in same method name which is available next to this method)
//Commented reason - need to convert SOAP call's to REST call's

//- (void) registerClicked:(id) sender {
//
//    //Play Audio for button touch....
//    AudioServicesPlaySystemSound (soundFileObject);
//
//    if ((userIDtxt.text).length == 0 ||  (emailIDtxt.text).length == 0 || (firstNametxt.text).length == 0 || (countrytxt.text).length == 0 || (lastNametxt.text).length == 0) {
//
//        UIAlertView *validation_alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please enter all \nmandatory fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [validation_alert show];
//
//    }
//    else if (![self validateEmail:emailIDtxt.text]) {
//        UIAlertView *validation_alert = [[UIAlertView alloc] initWithTitle:@"Validation" message:@"Please Enter Valid \nEmail ID" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [validation_alert show];
//    }
//    else {
//
//        HUD.dimBackground = YES;
//        HUD.labelText = @"Registering ..";
//
//        // Show the HUD
//        [HUD show:YES];
//        [HUD setHidden:NO];
//
//        memberServicesSoapBinding *service = [memberServicesSvc memberServicesSoapBinding];
//        memberServicesSvc_userRegistration *aparams = [[memberServicesSvc_userRegistration alloc] init];
//
//        NSArray *registerKeys = @[@"userId", @"email",@"contactOffice",@"contactPersonnel",@"userType",@"deviceId",@"customerId",@"requestHeader",@"workLocation",@"firstName", @"remarks"];
//
//        if ([businessInfo.text isEqualToString:@"Please Describe About Your Business"] || (businessInfo.text).length == 0) {
//            businessInfo.text = @"";
//        }
//
//        NSArray *registerObjects = @[userIDtxt.text,emailIDtxt.text,firstNametxt.text,firstNametxt.text,countrytxt.text,deviceIDtxt.text,lastNametxt.text,[RequestHeader getRequestHeader],@"Jubilee Hills - Hyderabad", userIDtxt.text, businessInfo.text];
//        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:registerObjects forKeys:registerKeys];
//
//        NSError * err_;
//        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
//        NSString * registrationReqString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//
//        aparams.userDetails = registrationReqString;
//        memberServicesSoapBindingResponse *response = [service userRegistrationUsingParameters:(memberServicesSvc_userRegistration *)aparams];
//
//        NSArray *responseBodyParts = response.bodyParts;
//
//        for (id bodyPart in responseBodyParts) {
//            if ([bodyPart isKindOfClass:[memberServicesSvc_userRegistrationResponse class]]) {
//                memberServicesSvc_userRegistrationResponse *body = (memberServicesSvc_userRegistrationResponse *)bodyPart;
//                //printf("\nresponse=%s",body.return_);
//                [self createMemberHandler:body.return_];
//            }
//        }
//
//
//    }
//
//}

//callLoginServices method changed by roja on 17/10/2019.. // reason removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST

- (void) registerClicked:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    if ((userIDtxt.text).length == 0 ||  (emailIDtxt.text).length == 0 || (firstNametxt.text).length == 0 || (countrytxt.text).length == 0 || (lastNametxt.text).length == 0) {
        
        UIAlertView *validation_alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please enter all \nmandatory fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [validation_alert show];
        
    }
    else if (![self validateEmail:emailIDtxt.text]) {
        UIAlertView *validation_alert = [[UIAlertView alloc] initWithTitle:@"Validation" message:@"Please Enter Valid \nEmail ID" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [validation_alert show];
    }
    else {
        
        HUD.dimBackground = YES;
        HUD.labelText = @"Registering ..";
        
        // Show the HUD
        [HUD show:YES];
        [HUD setHidden:NO];
        
//        memberServicesSoapBinding *service = [memberServicesSvc memberServicesSoapBinding];
//        memberServicesSvc_userRegistration *aparams = [[memberServicesSvc_userRegistration alloc] init];
        
        NSArray *registerKeys = @[@"userId", @"email",@"contactOffice",@"contactPersonnel",@"userType",@"deviceId",@"customerId",@"requestHeader",@"workLocation",@"firstName", @"remarks",@"lastName",@"employeeId"];
        
        if ([businessInfo.text isEqualToString:@"Please Describe About Your Business"] || (businessInfo.text).length == 0) {
            businessInfo.text = @"";
        }
        
        NSArray *registerObjects = @[userIDtxt.text,emailIDtxt.text,firstNametxt.text,firstNametxt.text,countrytxt.text,deviceIDtxt.text,lastNametxt.text,[RequestHeader getRequestHeader],@"TEST", userIDtxt.text, businessInfo.text, @"test2", @"EMP0000"]; //workLocation --> @"Jubilee Hills - Hyderabad"
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:registerObjects forKeys:registerKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * registrationReqString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        WebServiceController * webService = [[WebServiceController alloc] init];
        webService.memberServiceDelegate = self;
        [webService userRegistration:registrationReqString];
        
        
        
        
//        aparams.userDetails = registrationReqString;
//        memberServicesSoapBindingResponse *response = [service userRegistrationUsingParameters:(memberServicesSvc_userRegistration *)aparams];
//
//        NSArray *responseBodyParts = response.bodyParts;
//
//        for (id bodyPart in responseBodyParts) {
//            if ([bodyPart isKindOfClass:[memberServicesSvc_userRegistrationResponse class]]) {
//                memberServicesSvc_userRegistrationResponse *body = (memberServicesSvc_userRegistrationResponse *)bodyPart;
//                //printf("\nresponse=%s",body.return_);
//                [self createMemberHandler:body.return_];
//            }
//        }
        
        
    }
    
}

// email id validation method  ..

- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

//Added by roja on 17/10/2019..
- (void)userRegistrationSuccessResponse:(NSDictionary *)successDictionary{

    @try {
        
            registrationView.hidden = YES;
            loginbut.enabled = TRUE;
            regbut.enabled   = TRUE;
            
            UIAlertView *successMessage = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Registration Successful" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [successMessage show];
            
            tax_Value = @"0.0";
            
            custID = [lastNametxt.text copy];
            mail_ = [emailIDtxt.text copy];
            
            // setting the global variable ..
            user_name = [userIDtxt.text copy];
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setValue:deviceIDtxt.text forKey:@"deviceID"];
            [userDefaults setValue:emailIDtxt.text forKey:@"loginEmailID"];
            [userDefaults setValue:lastNametxt.text forKey:@"loginCustID"];
            [self ButtonClicked:loginbut];
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
    
}
//Added by roja on 17/10/2019..
- (void)userRegistrationErrorResponse:(NSString *)errorResponse{
    
    @try {

        UIAlertView *WebResponse = [[UIAlertView alloc] initWithTitle:@"Failed" message:errorResponse delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [WebResponse show];
        
        registrationView.hidden = YES;
        [self ButtonClicked:regbut];
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}



- (void) createMemberHandler: (NSString *) value {
    
    [HUD setHidden:YES];
    
    // Handle errors
    if([value isKindOfClass:[NSError class]]) {
        
        UIAlertView *domainerror = [[UIAlertView alloc] initWithTitle:@"Registration Failed" message:@"The host is not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [domainerror show];
        
        return;
    }
    
    
    // Do something with the NSString* result
    NSString* result = (NSString*)value;
    NSError *error;
    NSDictionary *registrationSucessDic = [[NSJSONSerialization JSONObjectWithData: [result dataUsingEncoding:NSUTF8StringEncoding]
                                                                           options: NSJSONReadingMutableContainers
                                                                             error: &error] copy];
    
    if ([[[registrationSucessDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE] isEqualToString:@"User Registered Successfully"]) {
        
        registrationView.hidden = YES;
        
        loginbut.enabled = TRUE;
        regbut.enabled   = TRUE;
        
        
        UIAlertView *successMessage = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Registration Successful" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [successMessage show];
        
        tax_Value = @"0.0";
        
        custID = [lastNametxt.text copy];
        mail_ = [emailIDtxt.text copy];
        
        // setting the global variable ..
        user_name = [userIDtxt.text copy];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setValue:deviceIDtxt.text forKey:@"deviceID"];
        [userDefaults setValue:emailIDtxt.text forKey:@"loginEmailID"];
        [userDefaults setValue:lastNametxt.text forKey:@"loginCustID"];
        [self ButtonClicked:loginbut];
    }
    else {
        result = [[registrationSucessDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE];
        UIAlertView *WebResponse = [[UIAlertView alloc] initWithTitle:@"Failed" message:result delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [WebResponse show];
        
        registrationView.hidden = YES;
        [self ButtonClicked:regbut];
    }
}






// Use below commented callLoginServices (method) if the latest  callLoginServices (method) don't work...
//callLoginServices method Commented  by roja on 17/10/2019.. (changes are done in same method name which is available 2methods below)
// At the time of converting SOAP call's to REST

//-(NSString *)callLoginServices {
//
//    isWifiSelectionChanged = FALSE;
//
//
//    CheckWifi *wifi = [[CheckWifi alloc] init];
//    BOOL status = [wifi checkWifi];
//
//
//
//    if (status) {
//
//        BOOL status = FALSE;
//
//
//
//        //        NSUUID *udid = [NSUUID UUID];
//        //        deviceUDID = [udid UUIDString];
//
//        //        KeychainItemWrapper* keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"KeychainTest" accessGroup:nil];
//        //        if ([keychain objectForKey:(__bridge id)(kSecAttrAccount)]) {
//        //            // existing value
//        //        } else {
//        //            // no existing value
//        //        }
//        @try {
//
//            //changed by Srinivasulu on 20/07/2017....
//            //commented by Srinivasulu on 20/07/2017....
//
//            //            UIDevice *myDevice = [UIDevice currentDevice];
//            //
//            //            NSString *deviceTechnoId = @"";
//            //            KeychainItemWrapper *keyChainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"Technolabs" accessGroup:nil];
//            //            if ([[keyChainItem objectForKey:(__bridge id)(kSecAttrAccount)] length] == 0) {
//            //                deviceUDID = [[myDevice identifierForVendor] UUIDString];
//            //                //            deviceUDID = DEVICE_ID;
//            //                [keyChainItem setObject:deviceUDID forKey:(__bridge id)(kSecAttrAccount)];
//            //                deviceId = deviceUDID;
//            //            }
//            //            else {
//            //                deviceId = [keyChainItem objectForKey:(__bridge id)(kSecAttrAccount)];
//            //            }
//            //            deviceId = DEVICE_ID;
//            //            ////        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//            //            ////        if ([[userDefaults valueForKey:@"deviceID"] isKindOfClass:[NSNull class]]) {
//            //            //            deviceUDID = DEVICE_ID;
//            //            //
//            //            ////        }
//            //            ////        else {
//            //            ////            deviceUDID = [userDefaults valueForKey:@"deviceID"];
//            //            ////        }
//            //
//            //
//            //            custID = [userIDtxt.text copy];
//            //            mail_ = [emailIDtxt.text copy];
//            //
//            //            if ([custID caseInsensitiveCompare:@"CID8995453"]==NSOrderedSame || [custID caseInsensitiveCompare:@"CID8995455"]==NSOrderedSame) {
//            //
//            //                deviceId = @"C25B90129AEFC3F9171D9A3AF57068A666E25B9D";
//            //            }
//            //            else if ([custID caseInsensitiveCompare:@"CID8995454"] == NSOrderedSame) {
//            //                deviceId = @"90f839bab41395956e642d4c0a313aa07292185d";
//            //
//            //            }
//            //            else {
//            //
//            //                //changed by Srinivasulu on 12/06/2017....
//            //
//            //                //                deviceId = @"FFFFFFFF6E6EA64DDD504BB2B980CBCE33A53D05";
//            //
//            //                deviceId = DEVICE_ID;
//            //
//            //                //D-CHAMELEON CLIENT DEVICES ID....
//            //                //                deviceId = @"944cf5de35f63d3289738b845779e070651ff249";
//            //                //upto here on 12/06/2017....
//            //            }
//            //
//
//
//            //upto here on 20/07/2017....
//
//            //added by Srinivasulu on 20/07/2017....
//
//            custID = [userIDtxt.text copy];
//            mail_ = [emailIDtxt.text copy];
//
//            //upot here on 20/07/2017....
//
//            MemberServiceSoapBinding * memberParam =  [MemberServiceSvc MemberServiceSoapBinding];
//            memberParam.logXMLInOut = NO;
//
//            NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
//            NSArray *str = [time componentsSeparatedByString:@" "];
//            NSString * date = [str[0] componentsSeparatedByString:@","][0];
//
//            NSString * bussinessDateStr = @"";
//
//            NSUserDefaults * defaults  = [[NSUserDefaults alloc] init];
//
//            if(defaults != nil)
//                if ((![[defaults valueForKey:BUSSINESS_DATE] isKindOfClass:[NSNull class]]) && ([defaults valueForKey:BUSSINESS_DATE] != nil)) {
//
//                    bussinessDateStr = [defaults valueForKey:BUSSINESS_DATE];
//                }
//
//            NSArray *headerKeys = @[@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime",@"businessDate"];
//
//            NSArray *headerObjects = @[userIDtxt.text,userIDtxt.text,@"Omni Retailer-outlet",emailIDtxt.text,@"-",date,bussinessDateStr];
//
//
//
//            NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
//
//            NSArray *loyaltyKeys = @[@"userId", @"emailId",@"password",@"deviceId",REQUEST_HEADER];
//
//            NSArray *loyaltyObjects = @[userIDtxt.text,emailIDtxt.text,passwordtxt.text,deviceId,dictionary];
//            NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
//
//            NSError * err_;
//            NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
//            NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//
//            //            NSLog(@"login req string %@",loyaltyString);
//
//            MemberServiceSvc_authenticateUser *authenticate = [[MemberServiceSvc_authenticateUser alloc] init];
//            authenticate.loginDetails = loyaltyString;
//
//            MemberServiceSoapBindingResponse *response_ = [memberParam authenticateUserUsingParameters:(MemberServiceSvc_authenticateUser *)authenticate];
//
//
//            //added by Srinivasulu on 19/09/2017.....
//
//            if(response_ == nil){
//
//                return @"Failed to connect";
//            }
//
//            //upto here on 19/09/2017....
//
//
//
//            if (![response_.error isKindOfClass:[NSError class]]) {
//
//                NSArray *responseBodyParts1_ = response_.bodyParts;
//                NSDictionary *JSON1;
//                for (id bodyPart in responseBodyParts1_) {
//
//                    if ([bodyPart isKindOfClass:[MemberServiceSvc_authenticateUserResponse class]]) {
//                        status = TRUE;
//                        MemberServiceSvc_authenticateUserResponse *body = (MemberServiceSvc_authenticateUserResponse *)bodyPart;
//                        //                        printf("\nresponse=%s",[body.return_ UTF8String]);
//
//                        //status = body.return_;
//                        NSError *e;
//                        JSON1 = [[NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                 options: NSJSONReadingMutableContainers
//                                                                   error: &e] copy];
//
//                        if (status) {
//                            // NSError *e_;
//                            NSDictionary *responseJSON ;
//                            //            responseJSON = [NSJSONSerialization JSONObjectWithData: [[JSON1 objectForKey:@"response"] dataUsingEncoding:NSUTF8StringEncoding]
//                            //
//                            //                                                           options: NSJSONReadingMutableContainers
//                            //                                                             error: &e_];
//                            responseJSON = [JSON1 valueForKey:RESPONSE_HEADER];
//
//                            // NSError *err;
//
//                            if ([[responseJSON valueForKey:RESPONSE_CODE] integerValue]==0) {
//
//                                NSArray *response_arr = JSON1[@"licenseDetails"];
//                                NSDictionary * counter_dic = JSON1[@"counterDetails"];
//                                firstName = [JSON1[@"firstName"] copy];
//                                if (![JSON1[EMPLOYEE_ID] isKindOfClass:[NSNull class]]) {
//
//                                    cashierId = [JSON1[EMPLOYEE_ID] copy];
//                                }
//                                roleName = [JSON1[@"role"] copy];
//                                NSMutableArray *roles = [JSON1 valueForKey:@"roles"];
//
//                                accessControlActivityArr = [[NSMutableArray alloc] init];
//                                accessControlArr = [NSMutableArray new];
//                                roleNameLists = [[NSMutableArray alloc] init];
//                                for (NSDictionary *rolesDic in roles) {
//
//                                    [accessControlArr addObjectsFromArray:[rolesDic valueForKey:kAccessControl]];
//                                    [accessControlActivityArr addObjectsFromArray:[rolesDic valueForKey:kAccessControlActivity]];
//                                    [roleNameLists addObject:[rolesDic valueForKey:@"roleName"]];
//                                }
//
//
//
//                                //added by Srinivasulu on 09/11/2017....
//                                NSMutableArray * denominationOptionArr = [NSMutableArray new];
//                                NSMutableArray * couponOptionsArr = [NSMutableArray new];
//                                NSMutableArray * cardOptionsArr = [NSMutableArray new];
//
//
//                                if ([JSON1.allKeys containsObject:TENDER_LIST] && ![[JSON1 valueForKey:TENDER_LIST] isKindOfClass:[NSNull class]]) {
//
//                                    currencyCodeStr = @"";
//
//                                    for(NSDictionary * dic in [JSON1 valueForKey:TENDER_LIST]){
//
//                                        NSMutableDictionary * tenderInfoDic = [NSMutableDictionary new];
//
//                                        NSString * str = [self checkGivenValueIsNullOrNil:[dic valueForKey:TENDER_NAME] defaultReturn:@""];
//
//                                        tenderInfoDic[COUNTRY_CODE] = [self checkGivenValueIsNullOrNil:[dic valueForKey:COUNTRY_CODE] defaultReturn:@""];
//                                        tenderInfoDic[TENDER_CODE] = [self checkGivenValueIsNullOrNil:[dic valueForKey:TENDER_CODE] defaultReturn:@""];
//                                        tenderInfoDic[TENDER_KEY] = [self checkGivenValueIsNullOrNil:[dic valueForKey:TENDER_KEY] defaultReturn:@""];
//
//
//                                        //added by Sriniasulu on 09/03/2018.. reason is new specu....
//
//                                        tenderInfoDic[ALLOW_OTHER_RETURN_TENDER] = [self checkGivenValueIsNullOrNil:[dic valueForKey:ALLOW_OTHER_RETURN_TENDER] defaultReturn:@"0"];
//                                        tenderInfoDic[RETURN_TENDER] = [self checkGivenValueIsNullOrNil:[dic valueForKey:RETURN_TENDER] defaultReturn:@"0"];
//                                        tenderInfoDic[MODE_OF_PAY] = [self checkGivenValueIsNullOrNil:[dic valueForKey:MODE_OF_PAY] defaultReturn:@""];
//
//                                        //upto here on 09/03/2018....
//
//
//
//                                        tenderInfoDic[TENDER_NAME] = str;
//
//
//                                        if([[self checkGivenValueIsNullOrNil:[dic valueForKey:MODE_OF_PAY] defaultReturn:@""] caseInsensitiveCompare:CASH]  == NSOrderedSame){
//
//
//                                            if([str caseInsensitiveCompare:INR] == NSOrderedSame)
//                                                currencyCodeStr = str;
//
//                                            [denominationOptionArr addObject:tenderInfoDic];
//                                        }
//                                        else if([[self checkGivenValueIsNullOrNil:[dic valueForKey:MODE_OF_PAY] defaultReturn:@""] caseInsensitiveCompare:CARD]  == NSOrderedSame){
//
//                                            [cardOptionsArr addObject:tenderInfoDic];
//                                        }
//                                        else if([[self checkGivenValueIsNullOrNil:[dic valueForKey:MODE_OF_PAY] defaultReturn:@""] caseInsensitiveCompare:COUPON]  == NSOrderedSame){
//
//                                            [couponOptionsArr addObject:tenderInfoDic];
//                                        }
//
//                                    }
//
//                                    if( (!currencyCodeStr.length) && denominationOptionArr.count){
//                                        if([denominationOptionArr[0] isKindOfClass:[NSDictionary class]]){
//                                            currencyCodeStr = [self checkGivenValueIsNullOrNil:[denominationOptionArr[0] valueForKey:TENDER_NAME] defaultReturn:@""];
//                                        }
//                                        else
//                                            currencyCodeStr = INR;
//                                    }
//                                    else if(!currencyCodeStr.length)
//                                        currencyCodeStr = INR;
//
//                                }
//
//                                [defaults setObject:denominationOptionArr forKey:DENOMNINATION_OPTIONS];
//                                [defaults setObject:couponOptionsArr forKey:COUPON_OPTIONS];
//                                [defaults setObject:cardOptionsArr forKey:CARD_OPTIONS];
//
//                                //upto here on 09/11/2017....
//
//
//
//                                //changed by Srinivaulu on 09/08/2017....
//
//                                finalLicencesDetails = [[NSMutableArray alloc] init];
//
//                                for (int j = 0; j < response_arr.count; j++) {
//
//                                    NSDictionary *JSON = response_arr[j];
//                                    [finalLicencesDetails addObject:[JSON valueForKey:@"licenseType"]];
//                                }
//
//                                if(defaults == nil)
//                                    defaults = [[NSUserDefaults alloc] init];
//
//                                [defaults setObject:finalLicencesDetails forKey:@"licence"];
//
//                                //added by Srinivasulu on 18/09/2017....
//                                //reason below condition check will result in exception. if counter_details are null....
//                                //commented by Srinivasulu because conter details are mandator....
//
//                                //if(![counter_dic isKindOfClass:[NSNull class]])
//
//                                //upto here on 18/09/2017....
//
//
//                                //added by Bhargav on 09/08/2017....
//
//                                if(![counter_dic isKindOfClass:[NSNull class]])
//                                    if (![[counter_dic valueForKey:@"counterDetails"] isEqualToString:@"<null>"])
//
//                                        //upto here on 09/08/2017....
//
//                                        if (counter_dic.count!= 0) {
//
//                                            //commented by Srinivaulu on 09/08/2017....
//
//
//                                            //                                        finalLicencesDetails = [[NSMutableArray alloc] init];
//                                            //
//                                            //                                        for (int j = 0; j < [response_arr count]; j++) {
//                                            //                                            NSDictionary *JSON = [response_arr objectAtIndex:j];
//                                            //                                            [finalLicencesDetails addObject:[JSON valueForKey:@"licenseType"]];
//                                            //                                        }
//
//                                            counterName = [[counter_dic valueForKey:@"counterName"] copy];
//                                            counterIdStr = [[counter_dic valueForKey:@"counterId"] copy];
//
//
//                                            //added by Srinivasulu on 06/10/2017 -- 19/04/2018....
//
//                                            if ([counter_dic.allKeys containsObject:SERVER_DATE_STR] && ![[counter_dic valueForKey:SERVER_DATE_STR] isKindOfClass:[NSNull class]]) {
//
//                                                serverDateStr = [counter_dic valueForKey:SERVER_DATE_STR];
//                                            }
//
//                                            isMasterCounter = [[self checkGivenValueIsNullOrNil:[counter_dic valueForKey:MASTER_COUNTER]  defaultReturn:@"0"] boolValue];
//
//                                            //upto here on 06/10/2017 -- 19/04/2018....
//
//
//                                            //                                        defaults = [[NSUserDefaults alloc]init];
//
//                                            // get the latest serial bill_id... added on 9-03-17 by sonali
//
//                                            NSString *lastSavedId = @"0";
//
//                                            NSString *maxNo = @"0";
//
//                                            if (![[defaults valueForKey:kLatestSerialBillId] isKindOfClass:[NSNull class]] && [defaults valueForKey:kLatestSerialBillId] != nil) {
//                                                lastSavedId = [NSString stringWithFormat:@"%@",@([[defaults valueForKey:kLatestSerialBillId] longLongValue])] ;
//                                            }
//
//                                            if ([JSON1.allKeys containsObject:kLatestSerialBillId] && ![[JSON1 valueForKey:kLatestSerialBillId] isKindOfClass:[NSNull class]]) {
//
//                                                //  NSComparisonResult result = [lastSavedId compare:[NSNumber numberWithInt:[[JSON1 valueForKey:kLatestSerialBillId] integerValue]]];
//
//                                                //  maxNo = (result==NSOrderedDescending)?[JSON1 valueForKey:kLatestSerialBillId] :lastSavedId;
//
//                                                NSLog(@"%lld",[[JSON1 valueForKey:kLatestSerialBillId] longLongValue]);
//                                                maxNo = [NSString stringWithFormat:@"%lld",MAX([lastSavedId longLongValue], [[JSON1 valueForKey:kLatestSerialBillId] longLongValue])] ;
//
//                                            }
//                                            //added by Srinivasulu on 06/0/2017....
//                                            //reason is used for serialBillIdNo....
//
//
//                                            //commented by Srinivasulu on 20/09/2017....
//                                            //reason -- changed the scope..  Bill id should be save in local only....
//
//                                            //                                        if ([[counter_dic allKeys] containsObject:@"runningBillSerialNum"] && ![[counter_dic valueForKey:@"runningBillSerialNum"] isKindOfClass:[NSNull class]]) {
//                                            //                                            NSString * runbillNoStr = [counter_dic valueForKey:@"runningBillSerialNum"];
//                                            //
//                                            //                                            if(![runbillNoStr isEqualToString:@""] && (runbillNoStr.length < 6))
//                                            //                                                [defaults setObject:runbillNoStr forKey:LAST_BILL_COUNT];
//                                            //                                            else
//                                            //                                                [defaults setObject:@"0000" forKey:LAST_BILL_COUNT];
//                                            //
//                                            //
//                                            //                                        }
//                                            //                                        else{
//                                            //
//                                            //                                            [defaults setObject:@"0000" forKey:LAST_BILL_COUNT];
//                                            //                                        }
//                                            //
//                                            //upto here on 20/09/2017....
//
//                                            //upto here on 06/07/2017....
//
//
//
//                                            //                                        [defaults setObject:finalLicencesDetails forKey:@"licence"];
//
//
//
//                                            [defaults setObject:counterName forKey:@"counterName"];
//
//                                            [defaults setObject:firstName forKey:@"firstName"];
//
//
//
//
//                                            [defaults setObject:cashierId forKey:EMPLOYEE_ID];//added by Srinivasulu on 10/04/2018....it not saving for offline login..
//
//
//                                            if ([custID caseInsensitiveCompare:@"CID8995438"] == NSOrderedSame) {
//                                                [defaults setObject:maxNo forKey:kLatestSerialBillId];
//
//                                            }
//
//
//                                            [defaults synchronize];
//
//                                            if (![[JSON1 valueForKey:@"syncSettings"] isKindOfClass:[NSNull class]]) {
//
//                                                tableStatus = [[[JSON1 valueForKey:@"syncSettings"]valueForKey:@"tableStatus"] boolValue];
//                                                waiterStatus = [[[JSON1 valueForKey:@"syncSettings"]valueForKey:@"waitersStatus"] boolValue];
//                                                skuStatus = [[[JSON1 valueForKey:@"syncSettings"]valueForKey:@"skuStatus"] boolValue];
//                                                taxStatus = [[[JSON1 valueForKey:@"syncSettings"]valueForKey:@"taxStatus"] boolValue];
//                                                offerStatus = [[[JSON1 valueForKey:@"syncSettings"]valueForKey:@"offerStatus"] boolValue];
//                                                dealStatus = [[[JSON1 valueForKey:@"syncSettings"]valueForKey:@"dealStatus"] boolValue];
//                                                employeeStatus = [[[JSON1 valueForKey:@"syncSettings"]valueForKey:@"employeeStatus"] boolValue];
//                                                denominationStatus = [[[JSON1 valueForKey:@"syncSettings"]valueForKey:@"denominationMasterStatus"] boolValue];
//
//                                                //commented by  Srinivasulu on 27/06/2017....
//
//                                                //                                        shiftId = [[NSString stringWithFormat:@"%@",[[[JSON1 valueForKey:@"shifts"] valueForKey:@"shiftId"] stringValue]] copy] ;
//                                                //                                        shiftStart = [NSString stringWithFormat:@"%@",[[JSON1 valueForKey:@"start_time"] valueForKey:@"shiftId"] ] ;
//                                                //                                        shiftEnd = [NSString stringWithFormat:@"%@",[[JSON1 valueForKey:@"shifts"] valueForKey:@"end_time"] ] ;
//
//                                                //added by  Srinivasulu on 27/06/2017....
//
//                                                categoryStatus = [[[JSON1 valueForKey:@"syncSettings"]valueForKey:@"productCategoryStatus"] boolValue];
//                                                subCategoruStatus = [[[JSON1 valueForKey:@"syncSettings"] valueForKey:@"productSubCategoryStatus"] boolValue];
//
//                                                productStatus  = [[[JSON1 valueForKey:@"syncSettings"] valueForKey:@"productMasterStatus"] boolValue];
//
//                                                // added by roja on 06/06/2019...
//                                                giftCouponStatus  = [[[JSON1 valueForKey:@"syncSettings"] valueForKey:@"giftCouponStatus"] boolValue];
//
//                                                giftVoucherStatus  = [[[JSON1 valueForKey:@"syncSettings"] valueForKey:@"giftVoucherStatus"] boolValue];
//
//                                                loyaltyCardsStatus  = [[[JSON1 valueForKey:@"syncSettings"] valueForKey:@"loyaltyCardsStatus"] boolValue];
//                                                //Upto here added by roja on 06/06/2019...
//
//                                            }
//
//                                        }
//
//                                //added by  Srinivasulu on 27/07/2017....
//
//                                if(([JSON1.allKeys containsObject:@"shifts"]) && (! [[JSON1 valueForKey:@"shifts"]  isKindOfClass:[NSNull class]])){
//
//                                    if(([[[JSON1 valueForKey:@"shifts"] allKeys] containsObject:@"shiftId"]) && (! [[[JSON1 valueForKey:@"shifts"] valueForKey:@"shiftId"]  isKindOfClass:[NSNull class]]))
//
//                                        shiftId = [[NSString stringWithFormat:@"%@",[[[JSON1 valueForKey:@"shifts"] valueForKey:@"shiftId"] stringValue]] copy] ;
//
//                                    if(([[[JSON1 valueForKey:@"shifts"] allKeys] containsObject:@"start_time"]) && (! [[[JSON1 valueForKey:@"shifts"] valueForKey:@"start_time"]  isKindOfClass:[NSNull class]]))
//
//                                        shiftStart = [NSString stringWithFormat:@"%@",[[JSON1 valueForKey:@"shifts"] valueForKey:@"start_time"] ] ;
//
//                                    if(([[[JSON1 valueForKey:@"shifts"] allKeys] containsObject:@"end_time"]) && (! [[[JSON1 valueForKey:@"shifts"] valueForKey:@"end_time"]  isKindOfClass:[NSNull class]]))
//
//                                        shiftEnd = [NSString stringWithFormat:@"%@",[[JSON1 valueForKey:@"shifts"] valueForKey:@"end_time"] ] ;
//
//                                }
//
//
//                                //added by Srinivasulu on 17/10/2017 && 19/04/2018....
//
//                                if ([JSON1.allKeys containsObject:SERVER_DATE_STR] && ![[JSON1 valueForKey:SERVER_DATE_STR] isKindOfClass:[NSNull class]]) {
//
//                                    serverDateStr = [JSON1 valueForKey:SERVER_DATE_STR];
//                                }
//
//                                [defaults setObject:@(isMasterCounter) forKey:MASTER_COUNTER];
//
//                                //upto here on 17/10/2017 && 19/04/2018....
//
//                                if(defaults == nil)
//                                    defaults = [[NSUserDefaults alloc]init];
//
//                                if(([JSON1.allKeys containsObject:@"hubUser"]) && (! [[JSON1 valueForKey:@"hubUser"]  isKindOfClass:[NSNull class]]))
//                                    isHubLevel = [[JSON1 valueForKey:@"hubUser"]boolValue];
//
//                                //upto here on 27/07/2017....
//
//                                //added by  Srinivasulu on 07/06/2017....
//
//                                //added by  Srinivasulu on 18/08/2017....
//
//                                StoreAddressStr = @"";
//
//                                //upto here on 18/08/2017....
//
//
//
//                                if(([JSON1.allKeys containsObject:BUSINESS_NAME]) && (! [[JSON1 valueForKey:BUSINESS_NAME]  isKindOfClass:[NSNull class]])){
//
//                                    StoreAddressStr = [NSString stringWithFormat:@"%@%@%@",[JSON1 valueForKey:BUSINESS_NAME],@",",@"\n" ];
//
//                                    [defaults setObject:[JSON1 valueForKey:BUSINESS_NAME] forKey:CUSTOMER_DEFAULT_LANDMARK];
//                                }
//
//                                //added by  Bhargav on 07/08/2017....
//
//                                if(([JSON1.allKeys containsObject:MASTER_OBJ]) && (![[JSON1 valueForKey:MASTER_OBJ]  isKindOfClass:[NSNull class]])){
//
//                                    zoneID = [NSString stringWithFormat:@"%@",[[JSON1 valueForKey:MASTER_OBJ] valueForKey:ZONE_ID]];
//                                }
//
//
//                                //upto here on 27/08/2017....
//
//
//
//
//
//                                if(([JSON1.allKeys containsObject:LOGO_URL]) && (! [[JSON1 valueForKey:LOGO_URL]  isKindOfClass:[NSNull class]])){
//
//
//                                    NSString * string = [JSON1 valueForKey:LOGO_URL];
//
//                                    string = [string stringByReplacingOccurrencesOfString:@"\\" withString:@"/" ];
//
//                                    string = [string stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
//
//                                    [defaults setObject:string forKey:LOGO_URL];
//
//                                }
//                                else{
//                                    [defaults setObject:@"" forKey:LOGO_URL];
//
//                                }
//
//                                //added by  Srinivasulu on 22/07/2017....
//
//                                //commented by Srinivasulu on 25/07/2017....
//
//
//                                if(([JSON1.allKeys containsObject:PRINT_BILL_URL]) && (! [[JSON1 valueForKey:PRINT_BILL_URL]  isKindOfClass:[NSNull class]])){
//
//
//                                    NSString * string = [JSON1 valueForKey:PRINT_BILL_URL];
//
//                                    string = [string stringByReplacingOccurrencesOfString:@"\\" withString:@"/" ];
//
//                                    string = [string stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
//
//
//                                    //                                    NSString * match = @"Configurations";
//                                    //                                    NSString * unWantedString;
//                                    //
//                                    //
//                                    //                                    NSScanner *scanner = [NSScanner scannerWithString:string];
//                                    //                                    [scanner scanUpToString:match intoString:&unWantedString];
//                                    //
//                                    //                                    [scanner scanString:match intoString:nil];
//                                    //                                    string = [string substringFromIndex:scanner.scanLocation];
//
//                                    //                                    string = string stringByAppendingString:(nonnull NSStr52"ing *)
//
//                                    [defaults setObject:string forKey:PRINT_BILL_URL];
//
//                                }
//                                else{
//                                    [defaults setObject:@"" forKey:PRINT_BILL_URL];
//
//                                }
//
//                                //upto here on 23/07/2017....
//
//                                if([[defaults valueForKey:LOGO_URL] length]){
//
//                                    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[defaults valueForKey:LOGO_URL]]];
//
//                                    if (imgData != nil) {
//
//                                        NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation([UIImage imageWithData:imgData])];
//
//                                        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//                                        NSString *documentsDirectory = paths[0];
//
//                                        NSString *imageName = [[defaults valueForKey:LOGO_URL] componentsSeparatedByString:@"/"].lastObject;
//
//                                        NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:imageName];
//                                        [imageData writeToFile:savedImagePath atomically:NO];
//
//                                    }
//
//                                }
//
//                                if([[defaults valueForKey:PRINT_BILL_URL] length]){
//
//                                    NSData * billPrintFormatData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[defaults valueForKey:PRINT_BILL_URL]]];
//
//                                    if (billPrintFormatData != nil) {
//
//                                        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//                                        NSString *documentsDirectory = paths[0];
//
//
//                                        NSString * billPrintFormatStr = [[defaults valueForKey:PRINT_BILL_URL] componentsSeparatedByString:@"/"].lastObject;
//                                        //                                        NSString * billPrintFormatStr = OFFLINE_PRINT_XML;
//
//                                        NSString * billPrintFormatFilePath = [documentsDirectory stringByAppendingPathComponent:billPrintFormatStr];
//                                        [billPrintFormatData writeToFile:billPrintFormatFilePath atomically:NO];
//                                    }
//                                }
//
//                                //upto here on 25/07/2017 && 07/06/2017....
//                                return [NSString stringWithFormat:@"%@",responseJSON[@"responseMessage"]];
//                            }
//                            else {
//                                return [NSString stringWithFormat:@"%@",responseJSON[@"responseMessage"]];
//                            }
//
//                        }
//                    }
//                    else {
//
//                        [HUD setHidden:YES];
//                        //            UIAlertView *timeOut = [[UIAlertView alloc] initWithTitle:@"Unable to connect" message:@"Failed to connect" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                        //            [timeOut show];
//                        //            [timeOut release];
//                        return @"Failed to connect";
//                    }
//                }
//            }
//            else {
//
//                NSError *err = response_.error;
//                return err.localizedDescription;
//            }
//
//        }
//
//        @catch (NSException *exception) {
//
//            return @"";
//        }
//    }
//    else {
//        isOfflineService = YES;
//
//        return @"Please enable wifi/mobile data";
//
//    }
//}





// Use below commented loginClicked (method) if the latest  loginClicked (method) don't work...
//loginClicked method Commented  by roja on 17/10/2019.. (changes are done in same method name which is available 2methods below)
// At the time of converting SOAP call's to REST

// verified by chandhu, shiva
// login button clicked ..
//- (void) loginClicked:(id)sender {
//
//
//    //Play Audio for button touch....
//    AudioServicesPlaySystemSound (soundFileObject);
//
//    [self keyboardHide];
//
//    isWifiSelectionChanged = FALSE;
//
//
//    CheckWifi *wifi = [[CheckWifi alloc] init];
//    BOOL status = [wifi checkWifi];
//
//
//    //    offlineMode = [[UIAlertView alloc] initWithTitle:@"Offline Mode" message:@"Do you want to continue with the offline mode" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
//    //    [offlineMode show];
//    //    isOfflineService = TRUE;
//    //
//    //    return;
//
//    if ([sender tag]!=10) {
//
//        if ((userIDtxt.text).length == 0 ||  (passwordtxt.text).length == 0 || (emailIDtxt.text).length  == 0)
//        {
//
//            UIAlertView *validation_alert = [[UIAlertView alloc] initWithTitle:@"Validation" message:@"Please enter the \nmandatory fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [validation_alert show];
//        }
//        else if(!status || isOfflineService)
//        {
//
//            offlineMode = [[UIAlertView alloc] initWithTitle:@"Offline Mode" message:@"Do you want to continue with the offline mode" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
//            [offlineMode show];
//        }
//        else {
//            isOfflineService = FALSE;
//
//            HUD.dimBackground = YES;
//            HUD.labelText = @"Authenticating..";
//
//            // Show the HUD
//            [HUD show:YES];
//            [HUD setHidden:NO];
//
//            //user_name = [userIDtxt.text copy];
//            userPassword = [passwordtxt.text copy];
//
//            //Find Uniqe Iphone DeviceId...
//            deviceIDtxt.userInteractionEnabled = NO;
//
//            NSString *string = [self callLoginServices];
//            @try {
//                if ([string isEqualToString:@"Success"])
//                {
//
//                    //added by Srinivasulu on 06/10/2017....
//                    NSUserDefaults * defaults  = [NSUserDefaults standardUserDefaults];
//
//                    if (serverDateStr != nil && serverDateStr.length > 0) {
//
//
//                        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
//                        dateFormatter.dateFormat = @"dd/MM/yyyy";
//                        //
//                        //                            NSDate * dataFromServerStr = [[NSDate alloc] init];
//                        //                            dataFromServerStr = [dateFormatter dateFromString:serverDateStr];
//                        //
//                        //                            NSDate *today = [NSDate date];
//                        //                            NSString * currentdate = [dateFormatter stringFromDate:today];
//                        //
//                        //                            NSDate * now = [[NSDate alloc] init];
//                        //                            now = [dateFormatter dateFromString:currentdate];
//                        //
//                        //                            if(!([now compare:dataFromServerStr] == NSOrderedSame)) {
//                        //
//                        //                                [HUD setHidden:YES];
//                        //                                UIAlertView *invalid = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"Please, Check device date" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                        //                                [invalid show];
//                        //                                return;
//                        //                            }
//
//                        NSDate * dateFromServer = [dateFormatter dateFromString:serverDateStr];
//                        NSDate * dateFromDevice = [dateFormatter dateFromString:[dateFormatter stringFromDate:[NSDate date]]];
//
//                        if ([[defaults valueForKey:BUSSINESS_DATE] isKindOfClass:[NSNull class]] || [defaults valueForKey:BUSSINESS_DATE] == nil) {
//
//                            //changed by Srinivasulu on 21/10/2017....
//                            //reason we need to sent the server date not device date....
//
//                            if(serverDateStr.length){
//
//                                [defaults setValue:serverDateStr forKey:BUSSINESS_DATE];
//                            }
//                            else{
//
//                                NSString *currentDate = [WebServiceUtility getCurrentDate];
//                                [defaults setValue:[currentDate componentsSeparatedByString:@" "][0] forKey:BUSSINESS_DATE];
//                            }
//
//                            //upto here on 21/10/2017....
//                            [defaults setValue:@"0000" forKey:LAST_BILL_COUNT];
//                            [defaults setValue:@"0.00" forKey:LAST_BILL_TOTAL];
//                        }
//
//                        if (!([dateFromDevice compare:dateFromServer] == NSOrderedSame)) {
//
//                            [HUD setHidden:YES];
//                            UIAlertView *invalid = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"message", nil) message:NSLocalizedString(@"device_date_alert", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil];
//                            [invalid show];
//                            return;
//                        }
//
//                        //commented by Srinivasulu on 18/10/2017....
//                        //reason -- Issue raised by Sir.... in z report only date has to be changed....
//
//                        //                            else if([WebServiceUtility numberOfDaysDifference:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@",[defaults valueForKey:BUSSINESS_DATE]]]] > 1){
//                        //
//                        //                                [defaults setValue:serverDateStr forKey:BUSSINESS_DATE];
//                        //                                [defaults setValue:@"0000" forKey:LAST_BILL_COUNT];
//                        //                            }
//
//                        //upto here on 18/10/2017....
//
//                    }
//                    //upto here on 06/10/2017....
//
//
//                    mail_ = [emailIDtxt.text copy];
//                    custID = [userIDtxt.text copy];
//
//                    //below variable name has to be changed.  written by Srinivasulu on 30/08/2017....
//
//                    //
//                    [defaults setValue:passwordtxt.text forKey:@"loginPassword"];
//
//                    //added by Srinivasulu on 24/04/2017....
//
//                    [defaults setValue:userIDtxt.text forKey:@"customerId"];
//                    [defaults setValue:passwordtxt.text forKey:@"password"];
//                    [defaults setValue:emailIDtxt.text forKey:@"emailId"];
//
//
//
//                    //if we want static device id....
//                    //while giving the build this lines of code should be commented.. writeen by Srinivasulu on 21/08/2017....
//                    //when giving without offline DB....
//
//
//
//                    //added by Srinivasulu on 20/07/2017....
//                    //it will be executed. When offline data in not loaded for atleast one time....
//                    //used for coding processing....
//                    //while giving the build this line of code should be commented.. writeen by Srinivasulu on 21/08/2017....
//
//                    //                                        [defaults setObject:@"" forKey:LAST_SKU_UPDATED];
//                    //                                        [defaults setObject:@"" forKey:LAST_SKU_UPDATED_DATE];
//                    //                                        [defaults setObject:@"" forKey:LAST_SKU_EAN_UPDATED];
//                    //                                        [defaults setObject:@"" forKey:LAST_PRICE_UPDATED];
//                    //                                        [defaults setObject:@"" forKey:UPDATED_DATE_STR];
//                    //
//                    //                                        [defaults setObject:@"" forKey:LAST_DEALS_UPDATED];
//                    //                                        [defaults setObject:@"" forKey:LAST_OFFERS_UPDATED];
//                    //                                        [defaults setObject:@"" forKey:LAST_GROUPS_UPDATED];
//                    //                                        [defaults setObject:@"" forKey:LAST_GROUP_CHILDS_UPDATED];
//                    //                                        [defaults setObject:@"" forKey:LAST_EMPL_UPDATED_DATE];
//                    //                                        [defaults setObject:@"" forKey:LAST_DENOMINATIONS_UPDATE_DATE];
//                    //
//                    //                                        skuStatus = true;
//                    //                                        dealStatus = true;
//                    //                                        offerStatus = true;
//                    //                                        taxStatus = true;
//                    //                                        employeeStatus = true;
//                    //                                        productStatus = true;
//                    //                                        denominationStatus = true;
//
//
//
//                    //                        //sku_master_table....
//                    //                        if ([[defaults valueForKey:LAST_SKU_UPDATED] length]==0)
//                    //                            [defaults setObject:@"22/09/2017 00:00:00" forKey:LAST_SKU_UPDATED];
//                    //
//                    //                        //sku_master_table....
//                    //                        if ([[defaults valueForKey:LAST_SKU_UPDATED_DATE] length]==0)
//                    //                            [defaults setObject:@"22/09/2017 00:00:00" forKey:LAST_SKU_UPDATED_DATE];
//                    //
//                    //                        //sku_eans_table....
//                    //                        if ([[defaults valueForKey:LAST_SKU_EAN_UPDATED] length]==0)
//                    //                            [defaults setObject:@"22/09/2017 00:00:00" forKey:LAST_SKU_EAN_UPDATED];
//                    //
//                    //                        //price_list_table....
//                    //                        if ([[defaults valueForKey:LAST_PRICE_UPDATED] length]==0)
//                    //                            [defaults setObject:@"22/09/2017 00:00:00" forKey:LAST_PRICE_UPDATED];
//                    //
//                    //                        //product_master_table....
//                    //                        if ([[defaults valueForKey:UPDATED_DATE_STR] length]==0)
//                    //                            [defaults setObject:@"22/09/2017 00:00:00" forKey:UPDATED_DATE_STR];
//                    //
//                    //                        //deals_table....
//                    //                        if ([[defaults valueForKey:LAST_DEALS_UPDATED] length]==0)
//                    //                            [defaults setObject:@"18/08/2016 05:34:37" forKey:LAST_DEALS_UPDATED];
//                    //
//                    //                        //offers_table....
//                    //                        if ([[defaults valueForKey:LAST_OFFERS_UPDATED] length]==0)
//                    //                            [defaults setObject:@"18/08/2016 05:34:37" forKey:LAST_OFFERS_UPDATED];
//                    //
//                    //                        //groups_table....
//                    //                        if ([[defaults valueForKey:LAST_GROUPS_UPDATED] length]==0)
//                    //                            [defaults setObject:@"26/09/2016 05:34:37" forKey:LAST_GROUPS_UPDATED];
//                    //
//                    //                        //group_Chlid_table
//                    //                        if ([[defaults valueForKey:LAST_GROUP_CHILDS_UPDATED] length]==0)
//                    //                            [defaults setObject:@"26/09/2016 01:34:37" forKey:LAST_GROUP_CHILDS_UPDATED];
//                    //
//                    //                        //empolyee_table....
//                    //                        if ([[defaults valueForKey:LAST_EMPL_UPDATED_DATE] length]==0)
//                    //                            [defaults setObject:@"26/09/2016 01:34:37" forKey:LAST_EMPL_UPDATED_DATE];
//                    //
//                    //                        //denominations_table....
//                    //                        if ([[defaults valueForKey:LAST_DENOMINATIONS_UPDATE_DATE] length]==0)
//                    //                            [defaults setObject:@"18/09/2016 01:34:37" forKey:LAST_DENOMINATIONS_UPDATE_DATE];
//
//
//
//
//                    //                        NSString * time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
//                    //                        NSArray * str = [time componentsSeparatedByString:@" "];
//                    //                        NSString * dateStr = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
//                    //
//                    //                        //sku_master_table....
//                    //                        if ([[defaults valueForKey:LAST_SKU_UPDATED] length]==0)
//                    //                            [defaults setValue:dateStr forKey:LAST_SKU_UPDATED];
//                    //
//                    //                        //sku_master_table....
//                    //                        if ([[defaults valueForKey:LAST_SKU_UPDATED_DATE] length]==0)
//                    //                            [defaults setObject:dateStr forKey:LAST_SKU_UPDATED_DATE];
//                    //
//                    //                        //sku_eans_table....
//                    //                        if ([[defaults valueForKey:LAST_SKU_EAN_UPDATED] length]==0)
//                    //                            [defaults setValue:dateStr forKey:LAST_SKU_EAN_UPDATED];
//                    //
//                    //                        //price_list_table....
//                    //                        if ([[defaults valueForKey:LAST_PRICE_UPDATED] length]==0)
//                    //                            [defaults setValue:dateStr forKey:LAST_PRICE_UPDATED];
//                    //
//                    //                        //product_master_table....
//                    //                        if ([[defaults valueForKey:UPDATED_DATE_STR] length]==0)
//                    //                            [defaults setValue:dateStr forKey:UPDATED_DATE_STR];
//                    //
//                    //                        //deals_table....
//                    //                        if ([[defaults valueForKey:LAST_DEALS_UPDATED] length]==0)
//                    //                            [defaults setValue:dateStr forKey:LAST_DEALS_UPDATED];
//                    //
//                    //                        //offers_table....
//                    //                        if ([[defaults valueForKey:LAST_OFFERS_UPDATED] length]==0)
//                    //                            [defaults setValue:dateStr forKey:LAST_OFFERS_UPDATED];
//                    //
//                    //                        //groups_table....
//                    //                        if ([[defaults valueForKey:LAST_GROUPS_UPDATED] length]==0)
//                    //                            [defaults setValue:dateStr forKey:LAST_GROUPS_UPDATED];
//                    //
//                    //                        //group_Chlid_table
//                    //                        if ([[defaults valueForKey:LAST_GROUP_CHILDS_UPDATED] length]==0)
//                    //                            [defaults setValue:dateStr forKey:LAST_GROUP_CHILDS_UPDATED];
//                    //
//                    //                        //empolyee_table....
//                    //                        if ([[defaults valueForKey:LAST_EMPL_UPDATED_DATE] length]==0)
//                    //                            [defaults setValue:dateStr forKey:LAST_EMPL_UPDATED_DATE];
//                    //
//                    //                        //denominations_table....
//                    //                        if ([[defaults valueForKey:LAST_DENOMINATIONS_UPDATE_DATE] length]==0)
//                    //                            [defaults setValue:dateStr forKey:LAST_DENOMINATIONS_UPDATE_DATE];
//
//
//
//                    //upto here on 21/08/2017....
//
//
//                    //sku_master_table....  -- note :-- LAST_SKU_UPDATED_DATE and LAST_SKU_UPDATED both are using for sku_master download need to be removed....
//                    if ([[defaults valueForKey:LAST_SKU_UPDATED_DATE] isKindOfClass:[NSNull class]] || [defaults valueForKey:LAST_SKU_UPDATED_DATE] == nil) {
//
//                        if(![[defaults valueForKey:LAST_SKU_UPDATED_DATE] length]){
//
//                            skuStatus = true;
//                        }
//                    }
//
//                    //sku_eans_table....
//                    if ([[defaults valueForKey:LAST_SKU_EAN_UPDATED] isKindOfClass:[NSNull class]] || [defaults valueForKey:LAST_SKU_EAN_UPDATED] == nil) {
//
//                        if(![[defaults valueForKey:LAST_SKU_EAN_UPDATED] length]){
//
//                            skuStatus = true;
//                        }
//                    }
//
//                    //price_list_table....
//                    if ([[defaults valueForKey:LAST_PRICE_UPDATED] isKindOfClass:[NSNull class]] || [defaults valueForKey:LAST_PRICE_UPDATED] == nil) {
//
//                        if(![[defaults valueForKey:LAST_PRICE_UPDATED] length]){
//
//                            skuStatus = true;
//                        }
//                    }
//
//                    //product_master_table....
//                    if ([[defaults valueForKey:UPDATED_DATE_STR] isKindOfClass:[NSNull class]] || [defaults valueForKey:UPDATED_DATE_STR] == nil)
//                        if(![[defaults valueForKey:UPDATED_DATE_STR] length]){
//
//                            productStatus = true;
//                            categoryStatus = true;
//                            subCategoruStatus = true;
//                        }
//
//                    //deals_table....
//                    if ([[defaults valueForKey:LAST_DEALS_UPDATED] isKindOfClass:[NSNull class]] || [defaults valueForKey:LAST_DEALS_UPDATED] == nil)
//                        if(![[defaults valueForKey:LAST_DEALS_UPDATED] length])
//                            dealStatus = true;
//
//
//                    //offers_table....
//                    if ([[defaults valueForKey:LAST_OFFERS_UPDATED] isKindOfClass:[NSNull class]] || [defaults valueForKey:LAST_OFFERS_UPDATED] == nil)
//                        if(![[defaults valueForKey:LAST_OFFERS_UPDATED] length])
//                            offerStatus = true;
//
//
//                    //employee_table....
//                    if ([[defaults valueForKey:LAST_EMPL_UPDATED_DATE] isKindOfClass:[NSNull class]] || [defaults valueForKey:LAST_EMPL_UPDATED_DATE] == nil)
//                        if(![[defaults valueForKey:LAST_EMPL_UPDATED_DATE] length])
//                            employeeStatus = true;
//
//                    //denominations_table....
//                    if ([[defaults valueForKey:LAST_DENOMINATIONS_UPDATE_DATE] isKindOfClass:[NSNull class]] || [defaults valueForKey:LAST_DENOMINATIONS_UPDATE_DATE] == nil)
//                        if(![[defaults valueForKey:LAST_DENOMINATIONS_UPDATE_DATE] length])
//                            denominationStatus = true;
//
//                    //customer_table....
//                    if ([[defaults valueForKey:LAST_CUSTOMERS_LIST_UPDATE_DATE] isKindOfClass:[NSNull class]] || [defaults valueForKey:LAST_CUSTOMERS_LIST_UPDATE_DATE] == nil)
//                        if(![[defaults valueForKey:LAST_CUSTOMERS_LIST_UPDATE_DATE] length])
//                            customerDownLoadStatus = true;
//
//                    //member_details, roles....
//                    if ([[defaults valueForKey:LAST_MEMBER_DETAILS_UPDATE_DATE] isKindOfClass:[NSNull class]] || [defaults valueForKey:LAST_MEMBER_DETAILS_UPDATE_DATE] == nil)
//                        if(![[defaults valueForKey:LAST_MEMBER_DETAILS_UPDATE_DATE] length])
//                            memberDetailsDownLoad = true;
//
//                    if(skuStatus &&  dealStatus &&  offerStatus && employeeStatus && denominationStatus && customerDownLoadStatus && memberDetailsDownLoad){
//
//                        taxStatus = true;
//                        //                            isDayStartWithSync = false;
//                    }
//                    //lastDealsUpdated
//                    //upto here o 18/07/2017....
//                    //upto here on 24/04/2017....
//
//                    // added by roja on 06/06/2019...
//
//                    //gift_coupons status....
//                    if ([[defaults valueForKey:LAST_GIFT_COUPONS_UPDATED_DATE] isKindOfClass:[NSNull class]] || [defaults valueForKey:LAST_GIFT_COUPONS_UPDATED_DATE] == nil)
//                        if(![[defaults valueForKey:LAST_GIFT_COUPONS_UPDATED_DATE] length])
//                            giftCouponStatus = true;
//
//                    //gift_vouchers status....
//                    if ([[defaults valueForKey:LAST_VOUCHERS_UPDATED_DATE] isKindOfClass:[NSNull class]] || [defaults valueForKey:LAST_VOUCHERS_UPDATED_DATE] == nil)
//                        if(![[defaults valueForKey:LAST_VOUCHERS_UPDATED_DATE] length])
//                            giftVoucherStatus = true;
//
//                    //loyalty_card status....
//                    if ([[defaults valueForKey:LAST_LOYALTY_CARDS_UPDATED_DATE] isKindOfClass:[NSNull class]] || [defaults valueForKey:LAST_LOYALTY_CARDS_UPDATED_DATE] == nil)
//                        if(![[defaults valueForKey:LAST_LOYALTY_CARDS_UPDATED_DATE] length])
//                            loyaltyCardsStatus = true;
//                    // Upto here added by roja on 06/06/2019...
//
//
//                    [self callAppSettings];
//
//                    user_name = [userIDtxt.text copy];
//                    //                    [HUD setHidden:YES];
//                    //                    OmniHomePage *homepage = [[[OmniHomePage alloc] init] autorelease];
//                    //                    [self.navigationController pushViewController:homepage animated:YES];
//                }
//                else if ([string isEqualToString:@"Unauthorized"]){
//
//                    [HUD setHidden:YES];
//                    UIAlertView *invalid = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"Please Check Credentials" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                    [invalid show];
//                }
//                else if ([string isEqualToString:@"Invalid Customer Id"]){
//
//                    [HUD setHidden:YES];
//                    UIAlertView *invalid = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:string delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                    [invalid show];
//                }
//                else if ([string isEqualToString:@"Given Customer Id Is Inactive"]){
//
//                    [HUD setHidden:YES];
//                    UIAlertView *invalid = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:string delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                    [invalid show];
//                }
//                else if ([string isEqualToString:@"Invalid EmailId or Password"]){
//
//                    [HUD setHidden:YES];
//                    UIAlertView *invalid = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:string delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                    [invalid show];
//                }
//                else if ([string isEqualToString:@"Your Account Is Inactive"]){
//
//                    [HUD setHidden:YES];
//                    UIAlertView *invalid = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:string delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                    [invalid show];
//                }
//                else{
//
//                    [HUD setHidden:YES];
//                    UIAlertView *invalid = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:string delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                    [invalid show];
//                    return;
//                }
//                [HUD setHidden:YES];
//
//            }
//            @catch (NSException *exception) {
//
//                [HUD setHidden:YES];
//                NSLog(@"%@",exception);
//                UIAlertView *invalid = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:string delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                [invalid show];
//                return;
//
//            }
//
//            //changed by Srinivasulu on 20/07/2017....
//
//            //                UIDevice *myDevice = [UIDevice currentDevice];
//            //                deviceUDID = [[myDevice identifierForVendor] UUIDString];
//
//            //upto here on 20/07/2017....
//
//            // Create the service
//            //            SDZLoginService* service = [SDZLoginService service];
//            //            service.logging = YES;
//            //
//            //            // Returns NSString*.
//            //            //[service authenticateUser:self action:@selector(authenticateUserHandler:) userID: userIDtxt.text password: passwordtxt.text];
//            //
//            //            [service authenticateUser:self action:@selector(authenticateUserHandler:) userID: userIDtxt.text password: passwordtxt.text imei: deviceUDID];
//            //
//            //            LoginServiceSoapBinding *service = [[LoginServiceSvc LoginServiceSoapBinding] retain];
//            //            LoginServiceSvc_authenticateUser *aparams = [[LoginServiceSvc_authenticateUser alloc] init];
//            //            aparams.userID = userIDtxt.text;
//            //            aparams.password = passwordtxt.text;
//            //            aparams.imei = deviceUDID;
//            //            //aparams.imei = @"123456";
//            //
//            //            LoginServiceSoapBindingResponse *response = [service authenticateUserUsingParameters:(LoginServiceSvc_authenticateUser *)aparams];
//            //
//            //            NSArray *responseBodyParts = response.bodyParts;
//            //
//            //            for (id bodyPart in responseBodyParts) {
//            //                if ([bodyPart isKindOfClass:[LoginServiceSvc_authenticateUserResponse class]]) {
//            //                    LoginServiceSvc_authenticateUserResponse *body = (LoginServiceSvc_authenticateUserResponse *)bodyPart;
//            //                    //printf("\nresponse=%s",body.return_);
//            //                    [self authenticateUserHandler:body.return_];
//            //                }
//            //            }
//
//
//        }
//    }
//
//    else {
//
//        if ((userIDtxt.text).length!=0 && (emailIDtxt.text).length!=0) {
//
//            if ([self validateEmail:emailIDtxt.text]) {
//
//                //[self viewOtpScreen];
//                [self callOtpServices];
//
//            }
//
//        }
//
//    }
//
//    //    OmniHomePage *homepage = [[[OmniHomePage alloc] init] autorelease];
//    //    [self.navigationController pushViewController:homepage animated:YES];
//    //
//    //    // setting the global variable ..
//    //user_name = userIDtxt.text;
//    //    OmniHomePage *homepage = [[[OmniHomePage alloc] init] autorelease];
//    //    [self.navigationController pushViewController:homepage animated:YES];
//
//}



//callAppSettings method Commented  by roja on 17/10/2019.. (changes are done in same method name which is available next to this method)
// At the time of converting SOAP call's to REST
//-(void)callAppSettings {
//
//    BOOL status = FALSE;
//
//    //changed by Srinivasulu on 20/07/2017....
//
//    //    UIDevice *myDevice = [UIDevice currentDevice];
//    //    deviceUDID = [[myDevice identifierForVendor] UUIDString];
//
//    //upto here on 20/07/2017....
//
//    @try {
//
//        NSArray *loyaltyKeys = @[@"userId", @"emailId",REQUEST_HEADER];
//
//        NSArray *loyaltyObjects = @[custID,mail_,[RequestHeader getRequestHeader]];
//        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
//
//        NSError * err_;
//        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
//        NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//
//
//        appSettingsSoapBinding *param =  [appSettingsSvc appSettingsSoapBinding] ;
//
//        appSettingsSoapBinding_getAppSettings *order1 = [[appSettingsSoapBinding_getAppSettings alloc] init];
//
//        appSettingsSvc_getAppSettings *orderString = [[appSettingsSvc_getAppSettings alloc]init];
//
//        orderString.customerInfo = loyaltyString;
//
//        order1.parameters = orderString;
//
//
//        appSettingsSoapBindingResponse *response = [param getAppSettingsUsingParameters:orderString];
//
//        NSDictionary *JSON1 = [NSDictionary new];
//
//        if (![response.error isKindOfClass:[NSError class]]) {
//
//            NSArray *responseBodyParts1 = response.bodyParts;
//
//
//            for (id bodyPart in responseBodyParts1) {
//
//                if ([bodyPart isKindOfClass:[appSettingsSvc_getAppSettingsResponse class]]) {
//                    status = TRUE;
//                    appSettingsSvc_getAppSettingsResponse *body = (appSettingsSvc_getAppSettingsResponse *)bodyPart;
//                    //                    printf("\nresponse=%s",(body.return_).UTF8String);
//
//                    status = body.return_;
//                    NSError *e;
//                    JSON1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                            options: NSJSONReadingMutableContainers
//                                                              error: &e];
//                }
//            }
//
//            NSDictionary  *json1 = JSON1[RESPONSE_HEADER];
//
//            //changed by Srinivasulu on 04/12/2017....
//            //reason -- changed the deceleation outside the block....
//            NSUserDefaults * defaults  = [[NSUserDefaults alloc] init];
//
//            Boolean isCounterRequiredOTP = false;
//
//            if ([json1[RESPONSE_CODE] intValue] == 0) {
//                discountReasons = [NSMutableArray new];
//
//                //added by Srinivasulu on 15/06/2017....
//                returnReasonsArr = [NSMutableArray new];
//
//                if (![[JSON1 valueForKey:PRODUCT_RETURN_REASONS] isKindOfClass:[NSNull class]]) {
//                    NSArray *discReasons = [JSON1 valueForKey:PRODUCT_RETURN_REASONS];
//                    for (NSDictionary *resonDic in discReasons) {
//                        [returnReasonsArr addObject:[resonDic valueForKey:REASON_DESCRIPTION]];
//                    }
//                }
//
//
//                //upto here on 15/06/2017....
//
//
//
//                if (![[JSON1 valueForKey:PRODUCT_DISCOUNT_REASONS] isKindOfClass:[NSNull class]]) {
//                    NSArray *discReasons = [JSON1 valueForKey:PRODUCT_DISCOUNT_REASONS];
//                    for (NSDictionary *resonDic in discReasons) {
//                        [discountReasons addObject:[resonDic valueForKey:REASON_DESCRIPTION]];
//                    }
//                }
//
//                if ([JSON1.allKeys containsObject:@"zone"] && ![[JSON1 valueForKey:@"zone"] isKindOfClass:[NSNull class]]) {
//                    zone = [[JSON1 valueForKey:@"zone"] copy];
//                }
//
//                //added by Srinivasulu on 31/05/2017 && 22/06/2017....
//
//
//                if ([JSON1.allKeys containsObject:LOCATION_OBJ] && ![[JSON1 valueForKey:LOCATION_OBJ] isKindOfClass:[NSNull class]]) {
//
//                    NSDictionary * locObj = [JSON1 valueForKey:LOCATION_OBJ];
//
//                    if(([locObj.allKeys containsObject:ADDRESS]) && (! [[locObj valueForKey:ADDRESS]  isKindOfClass:[NSNull class]])){
//
//                        StoreAddressStr =  [NSString stringWithFormat:@"%@%@%@%@", StoreAddressStr,[locObj valueForKey:ADDRESS],@",",@"\n" ];
//                        [defaults setObject:[locObj valueForKey:ADDRESS] forKey:ADDRESS];
//                    }
//
//                    if(([locObj.allKeys containsObject:AREA]) && (! [[locObj valueForKey:AREA]  isKindOfClass:[NSNull class]])){
//
//                        StoreAddressStr =  [NSString stringWithFormat:@"%@%@%@%@", StoreAddressStr,[locObj valueForKey:AREA],@",",@"\n" ];
//                        [defaults setObject:[locObj valueForKey:AREA] forKey:CUSTOMER_DEFAULT_AREA];
//                    }
//
//                    if(([locObj.allKeys containsObject:CUSTOMER_CITY]) && (! [[locObj valueForKey:CUSTOMER_CITY]  isKindOfClass:[NSNull class]])){
//
//                        StoreAddressStr =  [NSString stringWithFormat:@"%@%@%@%@", StoreAddressStr,[locObj valueForKey:CUSTOMER_CITY],@",",@"\n" ];
//                        [defaults setObject:[locObj valueForKey:CUSTOMER_CITY] forKey:CUSTOMER_DEFAULT_CITY];
//                    }
//
//                    if(([locObj.allKeys containsObject:STATE]) && (! [[locObj valueForKey:STATE]  isKindOfClass:[NSNull class]])){
//
//                        StoreAddressStr =  [NSString stringWithFormat:@"%@%@%@", StoreAddressStr,[locObj valueForKey:STATE],@"" ];
//                        [defaults setObject:[locObj valueForKey:STATE] forKey:CUSTOMER_DEFAULT_STATE];
//                    }
//
//                    if(([locObj.allKeys containsObject:PIN]) && (! [[locObj valueForKey:PIN]  isKindOfClass:[NSNull class]])){
//
//                        StoreAddressStr =  [NSString stringWithFormat:@"%@%@%@%@%@",StoreAddressStr, @"-",[locObj valueForKey:PIN],@".",@"\n" ];
//                        [defaults setObject:[locObj valueForKey:PIN] forKey:CUSTOMER_DEFAULT_PIN];
//                    }
//
//                    //                   if(([[locObj allKeys] containsObject:OFFICE_PHONE]) && (! [[locObj valueForKey:OFFICE_PHONE]  isKindOfClass:[NSNull class]])){
//                    //
//                    //                        StoreAddressStr =  [NSString stringWithFormat:@"%@%@%@%@%@", StoreAddressStr,@"Phone : ",[locObj valueForKey:OFFICE_PHONE],@".",@"\n" ];
//                    //                    }
//                    //
//                    //                    //added by Srinivasulu on 23/08/2107.....
//                    //
//                    //                    else{
//                    //
//                    //                        StoreAddressStr =  [NSString stringWithFormat:@"%@%@%@", StoreAddressStr,@"Phone : ",@"\n" ];
//                    //                    }
//
//
//
//                    //                    StoreAddressStr = [NSString stringWithFormat:@"%@%@%@",StoreAddressStr,@"\n                 Invoice\n",@"--------------------------------------------\n" ];
//                }
//
//                //upto here on 31/05/2017 &&22/06/2017 && 22/08/2017 && 23/08/2017........
//
//
//                //                NSArray * outletDetails = [JSON1 objectForKey:@"outletDetails"];
//
//                //added by Bhargav on 09/08/2017....
//
//                NSArray * outletDetails;
//
//
//                if ([JSON1[@"outletDetails"] count]) {
//
//                    outletDetails = JSON1[@"outletDetails"];
//                }
//
//                if ((outletDetails!= nil) && (outletDetails.count)) {
//
//
//                    //upto here on 09/08/2017....
//
//                    NSDictionary * location_details = outletDetails[0];
//
//                    //check for dicount taxation...
//
//                    if ([location_details.allKeys containsObject:@"discountCalculatedOn"] && ![[location_details valueForKey:@"discountCalculatedOn"] isKindOfClass:[NSNull class]]) {
//
//                        discCalcOn = [[location_details valueForKey:@"discountCalculatedOn"] copy];
//                    }
//
//                    if ([location_details.allKeys containsObject:@"discountTaxation"] && ![[location_details valueForKey:@"discountTaxation"] isKindOfClass:[NSNull class]]) {
//
//                        discTaxation = [[location_details valueForKey:@"discountTaxation"] copy];
//                    }
//
//
//                    //added by Srinivasulu on  30/05/2017 && 07/06/2017 &&  22/08/2017 && 20/09/2017 && 23/08/2107 && 02/07/2018 && 28/08/2018....
//
//                    if([location_details.allKeys containsObject:ENFORCE_DENOMINATIONS] && (![[location_details valueForKey:ENFORCE_DENOMINATIONS] isKindOfClass:[NSNull class]])) {
//
//                        isEnforceDenominations = [[location_details  valueForKey:ENFORCE_DENOMINATIONS] boolValue];
//                    }
//
//                    if([location_details.allKeys containsObject:ENFORCE_VOID_ITEMS_REASON] && (![[location_details valueForKey:ENFORCE_VOID_ITEMS_REASON] isKindOfClass:[NSNull class]])) {
//
//                        isEnforceVoidItemsReason = [[location_details  valueForKey:ENFORCE_VOID_ITEMS_REASON] boolValue];
//                    }
//
//                    if([location_details.allKeys containsObject:ENFORCE_BILL_CANCEL_REASON] && (![[location_details valueForKey:ENFORCE_BILL_CANCEL_REASON] isKindOfClass:[NSNull class]])) {
//
//                        isEnforceBillCancelReason = [[location_details  valueForKey:ENFORCE_BILL_CANCEL_REASON] boolValue];
//                    }
//
//
//                    if(([location_details.allKeys containsObject:CUSTOMER_PHONE]) && (! [[location_details valueForKey:CUSTOMER_PHONE]  isKindOfClass:[NSNull class]])){
//
//                        StoreAddressStr =  [NSString stringWithFormat:@"%@%@%@%@%@", StoreAddressStr,@"Phone : ",[location_details valueForKey:CUSTOMER_PHONE],@".",@"\n" ];
//                        [defaults setObject:[location_details valueForKey:CUSTOMER_PHONE] forKey:CUSTOMER_PHONE];
//                    }
//                    else{
//
//                        StoreAddressStr =  [NSString stringWithFormat:@"%@%@%@", StoreAddressStr,@"Phone : ",@"\n" ];
//                    }
//
//
//                    if(([location_details.allKeys containsObject:GST_IN]) && (! [[location_details valueForKey:GST_IN]  isKindOfClass:[NSNull class]])){
//
//                        StoreAddressStr =  [NSString stringWithFormat:@"%@%@%@%@%@", StoreAddressStr,@"GSTIN : ",[location_details valueForKey:GST_IN],@".",@"\n" ];
//                    }
//                    else{
//
//                        StoreAddressStr =  [NSString stringWithFormat:@"%@%@%@", StoreAddressStr,@"GSTIN : ",@"\n" ];
//                    }
//
//
//
//                    presentLocation = [location_details[@"location"] copy];
//
//                    minPayAmt = [[location_details valueForKey:kMinPayment] floatValue];
//                    isFoodCouponsAvail = [[location_details valueForKey:kFoodCoupons] boolValue];
//                    isEmployeeSaleId = [[location_details valueForKey:kEmployeeSaleId] boolValue];
//
//                    if ([location_details.allKeys containsObject:@"barcodeType"] && ![[location_details valueForKey:@"barcodeType"] isKindOfClass:[NSNull class]]) {
//
//                        //changed by Srinivasulu on 31/01/2017....
//                        //reason scanned items are not adding for shaydrifarms.. irrespect
//
//                        barcodeTypeStr = [[location_details valueForKey:kBarCodeType] copy];
//
//                        if (([[location_details valueForKey:kBarCodeType] caseInsensitiveCompare:@"ean"] == NSOrderedSame) || ([[location_details valueForKey:kBarCodeType] caseInsensitiveCompare:@"both"] == NSOrderedSame)) {
//
//                            isBarcodeType = true;
//                        }
//                        else
//                            isBarcodeType = false;
//
//                    }
//
//                    if([location_details.allKeys containsObject:kproductsMenu] && ![[location_details valueForKey:kproductsMenu] isKindOfClass:[NSNull class]]) {
//                        isProductsMenu  = [[location_details  valueForKey:kproductsMenu]boolValue];
//
//                    }
//
//                    if([location_details.allKeys containsObject:@"billId"] && ![[location_details valueForKey:@"billId"] isKindOfClass:[NSNull class]]) {
//                        isCustomerBillId = [[location_details  valueForKey:@"billId"]boolValue];
//                    }
//
//                    if([location_details.allKeys containsObject:kRoundingRequired] && ![[location_details valueForKey:kRoundingRequired] isKindOfClass:[NSNull class]]) {
//                        isRoundingRequired = [[location_details  valueForKey:kRoundingRequired]boolValue];
//                    }
//
//
//                    //                if([[location_details allKeys] containsObject:TOLL_FREE_NUM] && ![[location_details valueForKey:TOLL_FREE_NUM] isKindOfClass:[NSNull class]]) {
//
//                    if([location_details.allKeys containsObject:TOLL_FREE_NUM] && (![[location_details valueForKey:TOLL_FREE_NUM] isKindOfClass:[NSNull class]]  && (![[location_details valueForKey:TOLL_FREE_NUM] isEqualToString:@"<null>"]) )) {
//
//                        outletTollFreeNumberStr = [location_details  valueForKey:TOLL_FREE_NUM];
//                    }
//
//
//                    if([location_details.allKeys containsObject:STORE_CODE_ID] && (![[location_details valueForKey:TOLL_FREE_NUM] isKindOfClass:[NSNull class]]  && (![[location_details valueForKey:STORE_CODE_ID] isEqualToString:STORE_CODE_ID]) )) {
//
//                        storeCodeStr = [[location_details valueForKey:STORE_CODE_ID] copy];
//                    }
//
//
//                    if([location_details.allKeys containsObject:ZERO_STOCK] && (![[location_details valueForKey:ZERO_STOCK] isKindOfClass:[NSNull class]])) {
//
//                        zeroStockCheckAtOutletLevel = [[location_details  valueForKey:ZERO_STOCK] boolValue];
//                    }
//
//                    if([location_details.allKeys containsObject:CAMPAIGN_EXISTS] && (![[location_details valueForKey:CAMPAIGN_EXISTS] isKindOfClass:[NSNull class]])) {
//
//                        isToCallApplyCampaigns = [[location_details  valueForKey:CAMPAIGN_EXISTS] boolValue];
//                    }
//
//
//                    if ([location_details.allKeys containsObject:ITEM_CATEGORY] && ![[location_details valueForKey:ITEM_CATEGORY] isKindOfClass:[NSNull class]]){
//
//                        businessCategoryStr = [location_details valueForKey:ITEM_CATEGORY];
//                    }
//
//
//                    if([location_details.allKeys containsObject:COUNTER_OTP] && (![[location_details valueForKey:COUNTER_OTP] isKindOfClass:[NSNull class]])) {
//
//                        isCounterRequiredOTP = [[location_details  valueForKey:COUNTER_OTP] boolValue];
//                    }
//
//                    //upto here on 30/05/2017 && 07/06/2017 && 22/08/2017 && 07/09/2017 &&  20/09/2017 && 31/01/2018 && 02/07/2018....
//
//                    NSArray *taxDetails = JSON1[@"taxDetails"];
//
//                    finalTaxDetails = [[NSMutableArray alloc] init];
//                    for (int i = 0; i < taxDetails.count; i++) {
//
//                        [finalTaxDetails addObject:taxDetails[i]];
//                    }
//
//
//                    [defaults setObject:@([location_details[kDoorDelivery]boolValue]) forKey:kDoorDelivery];
//                    [defaults setObject:@([location_details[kExchange]boolValue]) forKey:kExchange];
//                    [defaults setObject:@([location_details[kReturnAvailable]boolValue]) forKey:kReturnAvailable];
//                    [defaults setObject:@([location_details[kproductsMenu] boolValue]) forKey:kproductsMenu];
//                    if (![location_details[kReturnMode] isKindOfClass:[NSNull class]]) {
//                        [defaults setObject:location_details[kReturnMode] forKey:kReturnMode];
//                    }
//                    [defaults setObject:@([location_details[kPrinting]boolValue]) forKey:kPrinting];
//                    [defaults setObject:@([location_details[kRemoteBilling]boolValue]) forKey:kRemoteBilling];
//                    [defaults setObject:@(isBarcodeType) forKey:kBarCodeType];
//                    [defaults setObject:@(isToCallApplyCampaigns)  forKey:CAMPAIGN_EXISTS];
//                    [defaults setObject:@(zeroStockCheckAtOutletLevel)  forKey:ZERO_STOCK];
//                    [defaults setObject:businessCategoryStr  forKey:ITEM_CATEGORY];
//
//                    [defaults setObject:barcodeTypeStr  forKey:kBarCodeType];
//
//                    //added by Srinivasulu on 22/06/2017....
//
//                    if([location_details.allKeys containsObject:MANUAL_DISCOUNTS] && (![[location_details valueForKey:MANUAL_DISCOUNTS] isKindOfClass:[NSNull class]])) {
//
//                        isManualDiscounts = [[location_details  valueForKey:MANUAL_DISCOUNTS]  boolValue];
//                    }
//
//                    if([location_details.allKeys containsObject:HYBRID_MODE] && (![[location_details valueForKey:HYBRID_MODE] isKindOfClass:[NSNull class]])) {
//
//                        isHybirdMode = [[location_details  valueForKey:HYBRID_MODE]  boolValue];
//                    }
//
//                    [defaults setObject:@(isManualDiscounts) forKey:MANUAL_DISCOUNTS];
//                    [defaults setObject:@(isHybirdMode) forKey:HYBRID_MODE];
//
//                    //upto here on 22/06/2017....
//
//
//
//                    //added by Bhargav.v on 20/09/2017....
//
//                    if([location_details.allKeys containsObject:ZONE_Id] && (![[location_details valueForKey:ZONE_Id] isKindOfClass:[NSNull class]]  && (![[location_details valueForKey:ZONE_Id] isEqualToString:ZONE_Id]) )) {
//
//                        zoneID = [[location_details valueForKey:ZONE_Id] copy];
//                    }
//
//                    if([location_details.allKeys containsObject:@"warehouseId"] && (![[location_details valueForKey:@"warehouseId"] isKindOfClass:[NSNull class]]  && (![[location_details valueForKey:@"warehouseId"] isEqualToString:@"warehouseId"]) )) {
//
//                        wareHouseIdStr = [[location_details valueForKey:@"warehouseId"] copy];
//                    }
//
//                    NSString * storeEmailStr = @"";
//                    if([location_details.allKeys containsObject:CUSTOMER_MAIL] && (![[location_details valueForKey:CUSTOMER_MAIL] isKindOfClass:[NSNull class]])) {
//
//                        storeEmailStr = [[location_details valueForKey:CUSTOMER_MAIL] copy];
//                    }
//                    [defaults setObject:storeEmailStr forKey:STORE_EMAIL];
//
//                    //added by Srinivasulu on 20/04/2017....
//
//                    [defaults setObject:discTaxation forKey:DISCOUNT_TAXATION];
//                    [defaults setObject:discCalcOn forKey:DISCOUNT_CALCULATED_ON];
//
//
//
//                    [defaults setObject:storeCodeStr forKey:STORE_CODE_ID];
//
//                    //added by Srinivasulu on 22/05/2017....
//
//
//                    //added by Srinivasulu on 20/04/2017....
//
//                    if((returnReasonsArr != nil) && returnReasonsArr.count)
//                        [defaults setObject:returnReasonsArr forKey:PRODUCT_RETURN_REASONS];
//
//                    if((discountReasons != nil) && discountReasons.count)
//                        [defaults setObject:discountReasons forKey:PRODUCT_DISCOUNT_REASONS];
//
//
//                    //upto here on 20/04/2017.....
//
//                    //added by Srinivasulu on 22/05/2017....
//
//                    if (([location_details.allKeys containsObject:EXCHANGE_MODE]) &&   (![location_details[EXCHANGE_MODE] isKindOfClass:[NSNull class]])) {
//
//                        [defaults setObject:location_details[EXCHANGE_MODE] forKey:EXCHANGE_MODE];
//                    }
//
//                    //upto here on 22/05/2017.....
//
//
//                    //added by Srinivasulu on 18/09/2017 && 06/02/2017....
//
//                    if([location_details.allKeys containsObject:LATEST_CAMPAIGNS] && (![[location_details valueForKey:LATEST_CAMPAIGNS] isKindOfClass:[NSNull class]])) {
//
//                        applyLatestCampaigns = [[location_details  valueForKey:LATEST_CAMPAIGNS]  boolValue];
//                    }
//
//                    [defaults setObject:@(applyLatestCampaigns) forKey:LATEST_CAMPAIGNS];
//
//
//
//                    if([location_details.allKeys containsObject:EDIT_PRICE] && (![[location_details valueForKey:EDIT_PRICE] isKindOfClass:[NSNull class]])) {
//
//                        allowItemPriceEdit = [[location_details  valueForKey:EDIT_PRICE] boolValue];
//                    }
//
//
//                    if([location_details.allKeys containsObject:DAY_START_SYNC] && (![[location_details valueForKey:DAY_START_SYNC] isKindOfClass:[NSNull class]]) && !isDayStartWithSync) {
//
//                        isDayStartWithSync = [[location_details  valueForKey:DAY_START_SYNC] boolValue];
//                    }
//
//                    [defaults setObject:@(allowItemPriceEdit) forKey:EDIT_PRICE];
//
//                    //upto here on 18/09/2017 && 06/02/2017....
//
//                    //added by Srinivasulu on 05/12/2017....
//
//                    if (([location_details.allKeys containsObject:OFFLINE_DATA_TIME_OUT_DAYS]) &&   (![location_details[OFFLINE_DATA_TIME_OUT_DAYS] isKindOfClass:[NSNull class]])) {
//
//                        [defaults setObject:location_details[OFFLINE_DATA_TIME_OUT_DAYS] forKey:OFFLINE_DATA_TIME_OUT_DAYS];
//                    }
//                    else{
//
//                        [defaults setObject:@"0.00" forKey:OFFLINE_DATA_TIME_OUT_DAYS];
//                    }
//
//                    if (([location_details.allKeys containsObject:OFFLINE_DATA_TIME_OUT_HOURS]) &&   (![location_details[OFFLINE_DATA_TIME_OUT_HOURS] isKindOfClass:[NSNull class]])) {
//
//                        [defaults setObject:location_details[OFFLINE_DATA_TIME_OUT_HOURS] forKey:OFFLINE_DATA_TIME_OUT_HOURS];
//                    }
//                    else{
//
//                        [defaults setObject:@"0.00" forKey:OFFLINE_DATA_TIME_OUT_HOURS];
//                    }
//
//                    //upto here on 05/12/2017.....
//
//                }
//                //upto here by Bharagav on 09/08/2017....
//
//
//                StoreAddressStr = StoreAddressStr.uppercaseString;
//
//                [defaults setObject:StoreAddressStr forKey:STORE_ADDRESS_STR];
//
//                [defaults setObject:emailIDtxt.text forKey:@"emailId"];
//                [defaults setObject:passwordtxt.text forKey:@"password"];
//                [defaults setObject:@(isCustomerBillId) forKey:kCustomerBillId];
//                [defaults setObject:@(isRoundingRequired) forKey:kRoundingRequired];
//                [defaults setObject:presentLocation forKey:@"location"];
//                [defaults synchronize];
//
//                //added by Srinivasulu on 04/04/2018 && 07/04/2018....
//
//                if ([JSON1.allKeys containsObject:SETTINGS_RESPONSE] && ![[JSON1 valueForKey:SETTINGS_RESPONSE] isKindOfClass:[NSNull class]]) {
//
//                    NSDictionary * settingResDic = [JSON1 valueForKey:SETTINGS_RESPONSE];
//                    if ([settingResDic.allKeys containsObject:REGIONAL_SETTINGS] && ![[settingResDic valueForKey:REGIONAL_SETTINGS] isKindOfClass:[NSNull class]]) {
//
//                        NSDictionary * regionalSettingsDic = [settingResDic valueForKey:REGIONAL_SETTINGS];
//                        if ([regionalSettingsDic.allKeys containsObject:CURRENCY] && ![[regionalSettingsDic valueForKey:CURRENCY] isKindOfClass:[NSNull class]]) {
//
//                            NSString * defaultCurrencyCodeStr = [regionalSettingsDic valueForKey:CURRENCY];
//                            if([defaultCurrencyCodeStr componentsSeparatedByString:@"-"]){
//
//                                [defaults setObject:[[defaultCurrencyCodeStr componentsSeparatedByString:@"-"][1] stringByReplacingOccurrencesOfString:@" " withString:@""] forKey:DEFAULT_CURRENCY_CODE];
//                                //                                [defaults setObject:[[[defaultCurrencyCodeStr componentsSeparatedByString:@"-"] objectAtIndex:1] stringByTrimmingCharactersInSet:
//                                //                                                     [NSCharacterSet punctuationCharacterSet]] forKey:DEFAULT_CURRENCY_CODE];
//                            }
//                        }
//                    }
//                }
//
//                //upto here on 04/04/2018 && 07/04/2018....
//
//                //                if ([[defaults valueForKey:@"zone"] length]==0) {
//                //
//                //                    [defaults setObject:zone forKey:@"zone"];
//                //                    [defaults synchronize];
//                //                }
//
//
//                [HUD setHidden:YES];
//                [self initializePowaPeripherals];
//
//                //changed by Srinivasulu on 24/10/2017....
//                //reason -- changed from YES to NO -- reason is if animated YES the the custom navigation header in changing....
//                //added by Srinivasulu on 29/08/2018....
//                if ( ([[defaults valueForKey:BUSINESS_DATE_UPDATED] isKindOfClass:[NSNull class]] || [defaults valueForKey:BUSINESS_DATE_UPDATED] == nil) && isCounterRequiredOTP ) {
//
//                    [self formOTPView];
//                }
//                else{
//                    OmniHomePage *homepage = [[OmniHomePage alloc] init];
//                    [self.navigationController pushViewController:homepage animated:NO];
//                }
//                //upto here on 29/08/2018....
//            }
//            else{
//
//                [HUD setHidden:YES];
//                UIAlertView *timeOut = [[UIAlertView alloc] initWithTitle:[json1 valueForKey:@"responseMessage"] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                [timeOut show];
//                return;
//            }
//        }
//        else {
//
//            NSLog(@"%@",(response.error).localizedDescription);
//            UIAlertView *timeOut = [[UIAlertView alloc] initWithTitle:(response.error).localizedDescription message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [timeOut show];
//            return;
//        }
//
//    }
//    @catch (NSException *exception) {
//
//        NSLog(@"%@",exception.description);
//        [HUD setHidden:YES];
//        UIAlertView *timeOut = [[UIAlertView alloc] initWithTitle:@"Unable to connect" message:@"Time Out or Domain Error\nCheck the configuration" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [timeOut show];
//        return;
//
//    }
//
//}


#pragma -mark it will be called when login button cilcked....

/**
 * @description  In this method will be executed when logging button with customer iCon is clicked..
 * @date
 * @method       logging
 * @author
 * @param
 *
 * @return       void
 *
 * @modified By  Srinivasul on 04/07/2018 and before..
 * @reason       added comments and complete code alignment..
 *
 * @verified By
 * @verified On
 *
 */
- (void) logging {
    
    loginbut.enabled = FALSE;
    regbut.enabled   = FALSE;
    segmentedControl.userInteractionEnabled = FALSE;
    
    loginView = [[UIView alloc] init];
    loginView.layer.borderColor = [UIColor whiteColor].CGColor;
    loginView.layer.borderWidth = 1.0f;
    loginView.layer.cornerRadius = 10;
    //    loginView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"MessageBox.png"]];
    loginView.clipsToBounds = YES;
    loginView.hidden = NO;
    
    UIImageView * headerimg;
    UIImageView * headerlogo;
    UIButton * backBut;
    UILabel * user;
    UILabel * emailId;
    
    //UIImageView Creations..
    headerimg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PopUp_header.png"]];
    headerlogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"User_Gray.png"]];
    
    //UILabel creations....
    headerlabel = [[UILabel alloc] init];
    headerlabel.textColor = [UIColor whiteColor];
    headerlabel.backgroundColor = [UIColor clearColor];
    
    user = [[UILabel alloc] init];
    user.backgroundColor = [UIColor clearColor];
    user.textColor = [UIColor whiteColor];
    
    emailId = [[UILabel alloc] init];
    emailId.backgroundColor = [UIColor clearColor];
    emailId.textColor = [UIColor whiteColor];
    
    password = [[UILabel alloc] init];
    password.backgroundColor = [UIColor clearColor];
    password.textColor = [UIColor whiteColor];
    
    //UITextField Creations..
    userIDtxt = [[UITextField alloc] init];
    userIDtxt.borderStyle = UITextBorderStyleRoundedRect;
    userIDtxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    userIDtxt.autocorrectionType = UITextAutocorrectionTypeNo;
    userIDtxt.layer.masksToBounds = YES;
    userIDtxt.layer.borderColor = [UIColor grayColor].CGColor;
    userIDtxt.layer.borderWidth= 1.0f;
    userIDtxt.delegate = self;
    userIDtxt.autocapitalizationType = UITextAutocapitalizationTypeNone;
    userIDtxt.autocorrectionType = UITextAutocorrectionTypeNo;
    userIDtxt.backgroundColor   = [UIColor whiteColor];
    
    emailIDtxt = [[UITextField alloc] init];
    emailIDtxt.borderStyle = UITextBorderStyleRoundedRect;
    emailIDtxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    emailIDtxt.autocorrectionType = UITextAutocorrectionTypeNo;
    emailIDtxt.layer.masksToBounds = YES;
    emailIDtxt.layer.borderColor = [UIColor grayColor].CGColor;
    emailIDtxt.layer.borderWidth= 1.0f;
    emailIDtxt.delegate = self;
    emailIDtxt.autocapitalizationType = UITextAutocapitalizationTypeNone;
    emailIDtxt.autocorrectionType = UITextAutocorrectionTypeNo;
    emailIDtxt.backgroundColor = [UIColor whiteColor];
    
    passwordtxt = [[UITextField alloc] init];
    passwordtxt.borderStyle = UITextBorderStyleRoundedRect;
    passwordtxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordtxt.autocorrectionType = UITextAutocorrectionTypeNo;
    passwordtxt.layer.masksToBounds = YES;
    passwordtxt.layer.borderColor = [UIColor grayColor].CGColor;
    passwordtxt.layer.borderWidth= 1.0f;
    passwordtxt.delegate = self;
    passwordtxt.autocapitalizationType = UITextAutocapitalizationTypeNone;
    passwordtxt.autocorrectionType = UITextAutocorrectionTypeNo;
    passwordtxt.backgroundColor = [UIColor whiteColor];
    passwordtxt.secureTextEntry = TRUE;
    
    //commented by Srinivasulu on 10/08/2017....
    
    //    [userIDtxt addTarget:self action:@selector(textfieldTouched:) forControlEvents:UIControlEventTouchDown];
    //    [passwordtxt addTarget:self action:@selector(textfieldTouched:) forControlEvents:UIControlEventTouchDown];
    //    [emailIDtxt addTarget:self action:@selector(textfieldTouched:) forControlEvents:UIControlEventTouchDown];
    
    //upto here on 10/08/2017....
    
    //UIButton Creations..
    backBut = [[UIButton alloc] init];
    [backBut setImage:[UIImage imageNamed:@"go-back-icon.png"] forState:UIControlStateNormal];
    [backBut addTarget:self action:@selector(gobackView) forControlEvents:UIControlEventTouchDown];
    
    loginbut1 = [[UIButton alloc] init];
    [loginbut1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginbut1 setBackgroundImage:[UIImage imageNamed:@"Button.png"] forState:UIControlStateNormal];
    loginbut1.backgroundColor = [UIColor clearColor];
    [loginbut1 addTarget:self action:@selector(loginClicked:)forControlEvents:UIControlEventTouchDown];
    loginbut1.layer.borderColor = [UIColor grayColor].CGColor;
    loginbut1.clipsToBounds = YES;
    
    forgetPassword = [[UIButton alloc] init];
    //    [forgetPassword setBackgroundImage:[UIImage imageNamed:@"Button.png"] forState:UIControlStateNormal];
    [forgetPassword setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    forgetPassword.backgroundColor = [UIColor clearColor];
    forgetPassword.layer.cornerRadius = 4.0f;
    [forgetPassword addTarget:self action:@selector(forgetpasswordClicked:) forControlEvents:UIControlEventTouchDown];
    forgetPassword.clipsToBounds = YES;
    
    @try{
        
        headerlabel.text = NSLocalizedString(@"login", nil);
        
        user.text = NSLocalizedString(@"customer_id", nil);
        emailId.text = NSLocalizedString(@"user_id", nil);
        password.text = NSLocalizedString(@"password", nil);
        
        userIDtxt.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0];
        passwordtxt.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0];
        emailIDtxt.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0];
        
        [loginbut1 setTitle:NSLocalizedString(@"login", nil) forState:UIControlStateNormal];
        [forgetPassword setTitle:NSLocalizedString(@"forgot_password_?", nil) forState:UIControlStateNormal];
        
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        
        if ([defaults valueForKey:@"customerId"]!=nil && [defaults valueForKey:@"emailId"]!=nil && [defaults valueForKey:@"password"]!=nil) {
            
            userIDtxt.text = [defaults valueForKey:@"customerId"];
            passwordtxt.text = [defaults valueForKey:@"password"];
            emailIDtxt.text = [defaults valueForKey:@"emailId"];
        }
        else {
            
            userIDtxt.text = @"";
            emailIDtxt.text = @"";
            passwordtxt.text = @"";
            
            [defaults setObject:@(false)  forKey:IS_DAY_CLOSURE_TAKEN];
            [defaults setObject:@(false)  forKey:IS_DAY_OPEN];
            
            //        //This is for  client....
            //        userIDtxt.text = @"CID8995433";
            //        emailIDtxt.text = @"prasad@sampoorna.com";
            //        passwordtxt.text = @"Prasad123#";
            //
            //        //This is for  client....
            //        userIDtxt.text = @"CID8995435";
            //        emailIDtxt.text = @"shiva.pothuluru@technolabssoftware.com";
            //        passwordtxt.text = @"Shiva123#";
            //
            //        //This is for  client....
            //        userIDtxt.text = @"CID8995438";
            //        emailIDtxt.text = @"shiva.pothuluru@technolabssoftware.com";
            //        passwordtxt.text = @"Shiva123#";
            //
            //        //This is for GoodSeeds client....
            //        userIDtxt.text = @"CID8995444";
            //        emailIDtxt.text = @"jeevaorganic@gmail.com";
            //        passwordtxt.text = @"Jeeva123#";
            //
            //        //This is for FreshWorld client....
            //        userIDtxt.text = @"CID8995446";
            //        emailIDtxt.text = @"preetesh.dutt@freshworld.in";
            //        passwordtxt.text = @"Password123#";
            //
            //        emailIDtxt.text = @"suraj@gmail.com";
            //        passwordtxt.text = @"Password123#";
            //
            //        emailIDtxt.text = @"fwsmartcart01@gmail.com";
            //        passwordtxt.text = @"Password123#";
            //
            //        //This is for Globus client....
            //        userIDtxt.text = @"CID8995450";
            //        emailIDtxt.text = @"pooraan@globusmail.com";
            //        passwordtxt.text = @"Pooraan123#";
            //        passwordtxt.text = @"Globus123#";
            //
            //        emailIDtxt.text = @"tgowtham@globusmail.com";
            //        passwordtxt.text = @"Gowtham123#";
            //
            //        emailIDtxt.text = @"sm105@globusmail.com";
            //        passwordtxt.text = @"Password123#";
            //
            //        //This is for SahyadriFarms client....
            //        userIDtxt.text = @"CID8995452";
            //        emailIDtxt.text = @"satish.mishra@sahyadrifarms.com";
            //        passwordtxt.text = @"Password123#";
            //
            //        emailIDtxt.text = @"omkar.mahajan@sahyadrifarms.com";
            //        passwordtxt.text = @"Password123#";
            //
            //        emailIDtxt.text = @"akshay.shinde@sahyadrifarms.com";
            //        passwordtxt.text = @"Sarl@123";
            //
            //        emailIDtxt.text = @"preetiprasad000@gmail.com";
            //        passwordtxt.text = @"Sarl@123";
            //
            //        emailIDtxt.text = @"abhijit.nagmoti@sahyadrifarms.com";
            //        passwordtxt.text = @"Abhi@123";
            //        passwordtxt.text = @"abhijit@2790";
            //
            //        //This is for D-Chameleon client....
            //        userIDtxt.text = @"CID8995458";
            //        emailIDtxt.text = @"rajesh@d-chameleon.com";
            //        passwordtxt.text = @"Password123#";
            //
            //        emailIDtxt.text = @"kiranmadduri@d-chameleon.com";
            //        passwordtxt.text = @"Password123#";
            //
            //        //This is for client....
            //        userIDtxt.text = @"CID8995459";
            //        emailIDtxt.text = @"shiva.pothuluru@technolabssoftware.com";
            //        passwordtxt.text = @"Shiva123#";
            //
            //        //This is for   client....
            //        userIDtxt.text = @"CID8995461";
            //        emailIDtxt.text = @"chirag_boonlia@virtuousretail.com";
            //        passwordtxt.text = @"Password123#";
            //
            //        emailIDtxt.text = @"ashok_kumar@virtuousretail.com";
            //        passwordtxt.text = @"Password123#";
        }
    }
    @catch(NSException * excpection){
        
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
            
            loginView.frame = CGRectMake(180, 150, 668, 550);
            
            headerimg.frame = CGRectMake(0, 0, 668, 100);
            
            headerlogo.frame = CGRectMake(80, 25, 60, 60);
            
            headerlabel.font = [UIFont boldSystemFontOfSize:30];
            headerlabel.frame = CGRectMake(300, 30, 250, 60);
            
            
            backBut.frame = CGRectMake(590, 15, 70, 70);
            
            user.font = [UIFont systemFontOfSize:30];
            password.font = [UIFont systemFontOfSize:30];
            emailId.font = [UIFont systemFontOfSize:30];
            user.frame = CGRectMake(40, 130, 200, 60);
            emailId.frame = CGRectMake(40, 230, 200, 60);
            password.frame = CGRectMake(40, 330, 200, 60);
            
            userIDtxt.font = [UIFont systemFontOfSize:30];
            passwordtxt.font = [UIFont systemFontOfSize:30];
            emailIDtxt.font = [UIFont systemFontOfSize:30];
            userIDtxt.frame = CGRectMake(250, 130, 350, 60);
            emailIDtxt.frame = CGRectMake(250, 230, 350, 60);
            passwordtxt.frame = CGRectMake(250, 330, 350, 60);
            
            loginbut1.frame = CGRectMake(30, 420, 600, 60);
            loginbut1.titleLabel.font = [UIFont boldSystemFontOfSize:30.0];
            //            loginbut1.layer.cornerRadius = 25.0f;
            
            forgetPassword.frame = CGRectMake(200, 490, 300, 60);
            forgetPassword.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        }
        else {
            loginView.frame = CGRectMake(50, 200, 668, 550);
            
            headerimg.frame = CGRectMake(0, 0, 668, 100);
            
            headerlogo.frame = CGRectMake(80, 25, 60, 60);
            
            headerlabel.font = [UIFont boldSystemFontOfSize:30];
            headerlabel.frame = CGRectMake(300, 30, 250, 60);
            
            
            backBut.frame = CGRectMake(590, 15, 70, 70);
            
            user.font = [UIFont systemFontOfSize:30];
            password.font = [UIFont systemFontOfSize:30];
            emailId.font = [UIFont systemFontOfSize:30];
            user.frame = CGRectMake(40, 130, 200, 60);
            emailId.frame = CGRectMake(40, 230, 200, 60);
            password.frame = CGRectMake(40, 330, 200, 60);
            
            userIDtxt.font = [UIFont systemFontOfSize:30];
            passwordtxt.font = [UIFont systemFontOfSize:30];
            emailIDtxt.font = [UIFont systemFontOfSize:30];
            userIDtxt.frame = CGRectMake(250, 130, 350, 60);
            emailIDtxt.frame = CGRectMake(250, 230, 350, 60);
            passwordtxt.frame = CGRectMake(250, 330, 350, 60);
            
            loginbut1.frame = CGRectMake(30, 420, 600, 60);
            loginbut1.titleLabel.font = [UIFont boldSystemFontOfSize:30.0];
            loginbut1.layer.cornerRadius = 25.0f;
            
            forgetPassword.frame = CGRectMake(200, 490, 300, 60);
            forgetPassword.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        }
    }
    else {
        if (version>=8.0) {
            
            loginView.frame = CGRectMake(10, 90, 300, 300);
            
            headerimg.frame = CGRectMake(0, 0, 300, 50);
            
            headerlogo.frame = CGRectMake(20, 7, 40, 40);
            
            headerlabel.frame = CGRectMake(130, 10, 100, 30);
            
            backBut.frame = CGRectMake(260, 10, 30, 30);
            
            user.frame = CGRectMake(10, 70, 100, 30);
            user.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0];
            password.frame = CGRectMake(10, 170, 100, 30);
            password.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0];
            emailId.frame = CGRectMake(10, 120, 100, 30);
            emailId.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0];
            
            userIDtxt.frame = CGRectMake(100, 70, 180, 30);
            userIDtxt.font = [UIFont fontWithName:@"ArialRoundedMT" size:15.0];
            passwordtxt.frame = CGRectMake(100, 170, 180, 30);
            passwordtxt.font = [UIFont fontWithName:@"ArialRoundedMT" size:15.0];
            emailIDtxt.frame = CGRectMake(100, 120, 180, 30);
            emailIDtxt.font = [UIFont fontWithName:@"ArialRoundedMT" size:15.0];
            
            loginbut1.frame = CGRectMake(20, 218, 260, 35);
            loginbut1.layer.cornerRadius = 15.0f;
            
            forgetPassword.frame = CGRectMake(75, 269, 150, 20);
            forgetPassword.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0];
        }
        else {
            loginView.frame = CGRectMake(10, 90, 300, 300);
            
            headerimg.frame = CGRectMake(0, 0, 300, 50);
            
            headerlogo.frame = CGRectMake(20, 7, 40, 40);
            
            headerlabel.frame = CGRectMake(130, 10, 100, 30);
            
            backBut.frame = CGRectMake(260, 10, 30, 30);
            
            user.frame = CGRectMake(10, 70, 100, 30);
            user.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0];
            password.frame = CGRectMake(10, 170, 100, 30);
            password.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0];
            emailId.frame = CGRectMake(10, 120, 100, 30);
            emailId.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0];
            
            userIDtxt.frame = CGRectMake(100, 70, 180, 30);
            userIDtxt.font = [UIFont fontWithName:@"ArialRoundedMT" size:15.0];
            passwordtxt.frame = CGRectMake(100, 170, 180, 30);
            passwordtxt.font = [UIFont fontWithName:@"ArialRoundedMT" size:15.0];
            emailIDtxt.frame = CGRectMake(100, 120, 180, 30);
            emailIDtxt.font = [UIFont fontWithName:@"ArialRoundedMT" size:15.0];
            
            loginbut1.frame = CGRectMake(20, 218, 260, 35);
            loginbut1.layer.cornerRadius = 15.0f;
            
            forgetPassword.frame = CGRectMake(75, 269, 150, 20);
            forgetPassword.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0];
        }
    }
    UIGraphicsBeginImageContext(loginView.frame.size);
    [[UIImage imageNamed:@"MessageBox.png"] drawInRect:loginView.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    loginView.backgroundColor = [UIColor colorWithPatternImage:image];
    
    
    [loginView addSubview:headerimg];
    [loginView addSubview:headerlogo];
    [loginView addSubview:headerlabel];
    [loginView addSubview:backBut];
    [loginView addSubview:user];
    [loginView addSubview:password];
    [loginView addSubview:userIDtxt];
    [loginView addSubview:passwordtxt];
    [loginView addSubview: loginbut1];
    [loginView addSubview:emailIDtxt];
    [loginView addSubview:emailId];
    [loginView addSubview:forgetPassword];
    
    [self.view addSubview:loginView];
}



//loginClicked method changed by roja on 17/10/2019.. // reason removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST

- (void) loginClicked:(id)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    [self keyboardHide];
    
    isWifiSelectionChanged = FALSE;
    
    CheckWifi *wifi = [[CheckWifi alloc] init];
    BOOL status = [wifi checkWifi];
    
    
    //    offlineMode = [[UIAlertView alloc] initWithTitle:@"Offline Mode" message:@"Do you want to continue with the offline mode" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
    //    [offlineMode show];
    //    isOfflineService = TRUE;
    //
    //    return;
    
    if ([sender tag]!=10) {
        
        if ((userIDtxt.text).length == 0 ||  (passwordtxt.text).length == 0 || (emailIDtxt.text).length  == 0)
        {
            
            UIAlertView *validation_alert = [[UIAlertView alloc] initWithTitle:@"Validation" message:@"Please enter the \nmandatory fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [validation_alert show];
        }
        else if(!status || isOfflineService)
        {
            
            offlineMode = [[UIAlertView alloc] initWithTitle:@"Offline Mode" message:@"Do you want to continue with the offline mode" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
            [offlineMode show];
        }
        else {
            isOfflineService = FALSE;
            
            HUD.dimBackground = YES;
            HUD.labelText = @"Authenticating..";
            
            // Show the HUD
            [HUD show:YES];
            [HUD setHidden:NO];
            
            //user_name = [userIDtxt.text copy];
            userPassword = [passwordtxt.text copy];
            
            //Find Uniqe Iphone DeviceId...
            deviceIDtxt.userInteractionEnabled = NO;
            
             [self callLoginServices];
            

            //changed by Srinivasulu on 20/07/2017....
            
            //                UIDevice *myDevice = [UIDevice currentDevice];
            //                deviceUDID = [[myDevice identifierForVendor] UUIDString];
            
            //upto here on 20/07/2017....
            
            // Create the service
            //            SDZLoginService* service = [SDZLoginService service];
            //            service.logging = YES;
            //
            //            // Returns NSString*.
            //            //[service authenticateUser:self action:@selector(authenticateUserHandler:) userID: userIDtxt.text password: passwordtxt.text];
            //
            //            [service authenticateUser:self action:@selector(authenticateUserHandler:) userID: userIDtxt.text password: passwordtxt.text imei: deviceUDID];
            //
            //            LoginServiceSoapBinding *service = [[LoginServiceSvc LoginServiceSoapBinding] retain];
            //            LoginServiceSvc_authenticateUser *aparams = [[LoginServiceSvc_authenticateUser alloc] init];
            //            aparams.userID = userIDtxt.text;
            //            aparams.password = passwordtxt.text;
            //            aparams.imei = deviceUDID;
            //            //aparams.imei = @"123456";
            //
            //            LoginServiceSoapBindingResponse *response = [service authenticateUserUsingParameters:(LoginServiceSvc_authenticateUser *)aparams];
            //
            //            NSArray *responseBodyParts = response.bodyParts;
            //
            //            for (id bodyPart in responseBodyParts) {
            //                if ([bodyPart isKindOfClass:[LoginServiceSvc_authenticateUserResponse class]]) {
            //                    LoginServiceSvc_authenticateUserResponse *body = (LoginServiceSvc_authenticateUserResponse *)bodyPart;
            //                    //printf("\nresponse=%s",body.return_);
            //                    [self authenticateUserHandler:body.return_];
            //                }
            //            }
            
            
        }
    }
    
    else {
        
        if ((userIDtxt.text).length!=0 && (emailIDtxt.text).length!=0) {
            
            if ([self validateEmail:emailIDtxt.text]) {
                
                //[self viewOtpScreen];
                [self callOtpServices];
                
            }
            
        }
        
    }
    
    //    OmniHomePage *homepage = [[[OmniHomePage alloc] init] autorelease];
    //    [self.navigationController pushViewController:homepage animated:YES];
    //
    //    // setting the global variable ..
    //user_name = userIDtxt.text;
    //    OmniHomePage *homepage = [[[OmniHomePage alloc] init] autorelease];
    //    [self.navigationController pushViewController:homepage animated:YES];
    
}


//callLoginServices method changed by roja on 17/10/2019.. // reason removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST

//-(NSString *)callLoginServices {
-(void)callLoginServices {

    isWifiSelectionChanged = FALSE;
    
    CheckWifi *wifi = [[CheckWifi alloc] init];
    BOOL status = [wifi checkWifi];
    
    
    if (status) {
        
        BOOL status = FALSE;
        
        //        NSUUID *udid = [NSUUID UUID];
        //        deviceUDID = [udid UUIDString];
        
        //        KeychainItemWrapper* keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"KeychainTest" accessGroup:nil];
        //        if ([keychain objectForKey:(__bridge id)(kSecAttrAccount)]) {
        //            // existing value
        //        } else {
        //            // no existing value
        //        }
        @try {
            
            //changed by Srinivasulu on 20/07/2017....
            //commented by Srinivasulu on 20/07/2017....
            
            //            UIDevice *myDevice = [UIDevice currentDevice];
            //
            //            NSString *deviceTechnoId = @"";
            //            KeychainItemWrapper *keyChainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"Technolabs" accessGroup:nil];
            //            if ([[keyChainItem objectForKey:(__bridge id)(kSecAttrAccount)] length] == 0) {
            //                deviceUDID = [[myDevice identifierForVendor] UUIDString];
            //                //            deviceUDID = DEVICE_ID;
            //                [keyChainItem setObject:deviceUDID forKey:(__bridge id)(kSecAttrAccount)];
            //                deviceId = deviceUDID;
            //            }
            //            else {
            //                deviceId = [keyChainItem objectForKey:(__bridge id)(kSecAttrAccount)];
            //            }
            //            deviceId = DEVICE_ID;
            //            ////        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            //            ////        if ([[userDefaults valueForKey:@"deviceID"] isKindOfClass:[NSNull class]]) {
            //            //            deviceUDID = DEVICE_ID;
            //            //
            //            ////        }
            //            ////        else {
            //            ////            deviceUDID = [userDefaults valueForKey:@"deviceID"];
            //            ////        }
            //
            //
            //            custID = [userIDtxt.text copy];
            //            mail_ = [emailIDtxt.text copy];
            //
            //            if ([custID caseInsensitiveCompare:@"CID8995453"]==NSOrderedSame || [custID caseInsensitiveCompare:@"CID8995455"]==NSOrderedSame) {
            //
            //                deviceId = @"C25B90129AEFC3F9171D9A3AF57068A666E25B9D";
            //            }
            //            else if ([custID caseInsensitiveCompare:@"CID8995454"] == NSOrderedSame) {
            //                deviceId = @"90f839bab41395956e642d4c0a313aa07292185d";
            //
            //            }
            //            else {
            //
            //                //changed by Srinivasulu on 12/06/2017....
            //
            //                //                deviceId = @"FFFFFFFF6E6EA64DDD504BB2B980CBCE33A53D05";
            //
            //                deviceId = DEVICE_ID;
            //
            //                //D-CHAMELEON CLIENT DEVICES ID....
            //                //                deviceId = @"944cf5de35f63d3289738b845779e070651ff249";
            //                //upto here on 12/06/2017....
            //            }
            //
            
            
            //upto here on 20/07/2017....
            
            //added by Srinivasulu on 20/07/2017....
            
            custID = [userIDtxt.text copy];
            mail_ = [emailIDtxt.text copy];
            
            //upot here on 20/07/2017....
            
            
            NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
            NSArray *str = [time componentsSeparatedByString:@" "];
            NSString * date = [str[0] componentsSeparatedByString:@","][0];
            
            NSString * bussinessDateStr = @"";
            
            NSUserDefaults * defaults  = [[NSUserDefaults alloc] init];
            
            if(defaults != nil)
                if ((![[defaults valueForKey:BUSSINESS_DATE] isKindOfClass:[NSNull class]]) && ([defaults valueForKey:BUSSINESS_DATE] != nil)) {
                    
                    bussinessDateStr = [defaults valueForKey:BUSSINESS_DATE];
                }
            
            NSArray *headerKeys = @[@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime",@"businessDate"];
            
            NSArray *headerObjects = @[userIDtxt.text,userIDtxt.text,@"Omni Retailer-outlet",emailIDtxt.text,@"-",date,bussinessDateStr];
            
            
            
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
            
            NSArray *loyaltyKeys = @[@"userId", @"emailId",@"password",@"deviceId",REQUEST_HEADER];
            
            NSArray *loyaltyObjects = @[userIDtxt.text,emailIDtxt.text,passwordtxt.text,deviceId,dictionary];
            NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
            
            NSError * err_;
            NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
            NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
            
            //            NSLog(@"login req string %@",loyaltyString);
            
            WebServiceController * webServiceController = [[WebServiceController alloc] init];
            webServiceController.memberServiceDelegate = self;
            [webServiceController authenticateUserForLogIn:loyaltyString];
            
            
        }
        
        @catch (NSException *exception) {
            
            
            UIAlertView *invalid = [[UIAlertView alloc] initWithTitle:@"" message:exception.description delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [invalid show];
//            return @"";
        }
    }
    else {
        isOfflineService = YES;
        
        // show alert
        UIAlertView *invalid = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enable wifi/mobile data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [invalid show];

//        return @"Please enable wifi/mobile data";
        
    }
}

// Added by roja on 17/10/2019....
// At the time of converting SOAP call's to REST
- (void)authenticateUserSuccessResponse:(NSDictionary *)successDictionary{

    @try {
        
        NSArray *response_arr = successDictionary[@"licenseDetails"];
        NSDictionary * counter_dic = successDictionary[@"counterDetails"];
        firstName = [successDictionary[@"firstName"] copy];
        if (![successDictionary[EMPLOYEE_ID] isKindOfClass:[NSNull class]]) {
            
            cashierId = [successDictionary[EMPLOYEE_ID] copy];
        }
        roleName = [successDictionary[@"role"] copy];
        NSMutableArray *roles = [successDictionary valueForKey:@"roles"];
        
        accessControlActivityArr = [[NSMutableArray alloc] init];
        accessControlArr = [NSMutableArray new];
        roleNameLists = [[NSMutableArray alloc] init];
        for (NSDictionary *rolesDic in roles) {
            
            [accessControlArr addObjectsFromArray:[rolesDic valueForKey:kAccessControl]];
            [accessControlActivityArr addObjectsFromArray:[rolesDic valueForKey:kAccessControlActivity]];
            [roleNameLists addObject:[rolesDic valueForKey:@"roleName"]];
        }
        
        
        //added by Srinivasulu on 09/11/2017....
        NSMutableArray * denominationOptionArr = [NSMutableArray new];
        NSMutableArray * couponOptionsArr = [NSMutableArray new];
        NSMutableArray * cardOptionsArr = [NSMutableArray new];
        
        
        if ([successDictionary.allKeys containsObject:TENDER_LIST] && ![[successDictionary valueForKey:TENDER_LIST] isKindOfClass:[NSNull class]]) {
            
            currencyCodeStr = @"";
            
            for(NSDictionary * dic in [successDictionary valueForKey:TENDER_LIST]){
                
                NSMutableDictionary * tenderInfoDic = [NSMutableDictionary new];
                
                NSString * str = [self checkGivenValueIsNullOrNil:[dic valueForKey:TENDER_NAME] defaultReturn:@""];
                
                tenderInfoDic[COUNTRY_CODE] = [self checkGivenValueIsNullOrNil:[dic valueForKey:COUNTRY_CODE] defaultReturn:@""];
                tenderInfoDic[TENDER_CODE] = [self checkGivenValueIsNullOrNil:[dic valueForKey:TENDER_CODE] defaultReturn:@""];
                tenderInfoDic[TENDER_KEY] = [self checkGivenValueIsNullOrNil:[dic valueForKey:TENDER_KEY] defaultReturn:@""];
                
                
                //added by Sriniasulu on 09/03/2018.. reason is new specu....
                
                tenderInfoDic[ALLOW_OTHER_RETURN_TENDER] = [self checkGivenValueIsNullOrNil:[dic valueForKey:ALLOW_OTHER_RETURN_TENDER] defaultReturn:@"0"];
                tenderInfoDic[RETURN_TENDER] = [self checkGivenValueIsNullOrNil:[dic valueForKey:RETURN_TENDER] defaultReturn:@"0"];
                tenderInfoDic[MODE_OF_PAY] = [self checkGivenValueIsNullOrNil:[dic valueForKey:MODE_OF_PAY] defaultReturn:@""];
                
                //upto here on 09/03/2018....
                
                
                
                tenderInfoDic[TENDER_NAME] = str;
                
                
                if([[self checkGivenValueIsNullOrNil:[dic valueForKey:MODE_OF_PAY] defaultReturn:@""] caseInsensitiveCompare:CASH]  == NSOrderedSame){
                    
                    
                    if([str caseInsensitiveCompare:INR] == NSOrderedSame)
                        currencyCodeStr = str;
                    
                    [denominationOptionArr addObject:tenderInfoDic];
                }
                else if([[self checkGivenValueIsNullOrNil:[dic valueForKey:MODE_OF_PAY] defaultReturn:@""] caseInsensitiveCompare:CARD]  == NSOrderedSame){
                    
                    [cardOptionsArr addObject:tenderInfoDic];
                }
                else if([[self checkGivenValueIsNullOrNil:[dic valueForKey:MODE_OF_PAY] defaultReturn:@""] caseInsensitiveCompare:COUPON]  == NSOrderedSame){
                    
                    [couponOptionsArr addObject:tenderInfoDic];
                }
                
            }
            
            if( (!currencyCodeStr.length) && denominationOptionArr.count){
                if([denominationOptionArr[0] isKindOfClass:[NSDictionary class]]){
                    currencyCodeStr = [self checkGivenValueIsNullOrNil:[denominationOptionArr[0] valueForKey:TENDER_NAME] defaultReturn:@""];
                }
                else
                    currencyCodeStr = INR;
            }
            else if(!currencyCodeStr.length)
                currencyCodeStr = INR;
            
        }
        
        NSUserDefaults * defaults  = [[NSUserDefaults alloc] init];
        
        if(defaults != nil){
        [defaults setObject:denominationOptionArr forKey:DENOMNINATION_OPTIONS];
        [defaults setObject:couponOptionsArr forKey:COUPON_OPTIONS];
        [defaults setObject:cardOptionsArr forKey:CARD_OPTIONS];
        }
        //upto here on 09/11/2017....
        
        
        
        //changed by Srinivaulu on 09/08/2017....
        
        finalLicencesDetails = [[NSMutableArray alloc] init];
        
        for (int j = 0; j < response_arr.count; j++) {
            
            NSDictionary *JSON = response_arr[j];
            [finalLicencesDetails addObject:[JSON valueForKey:@"licenseType"]];
        }
        
        if(defaults == nil)
            defaults = [[NSUserDefaults alloc] init];
        
        [defaults setObject:finalLicencesDetails forKey:@"licence"];
        
        //added by Srinivasulu on 18/09/2017....
        //reason below condition check will result in exception. if counter_details are null....
        //commented by Srinivasulu because conter details are mandator....
        
        //if(![counter_dic isKindOfClass:[NSNull class]])
        
        //upto here on 18/09/2017....
        
        
        //added by Bhargav on 09/08/2017....
        
        if(![counter_dic isKindOfClass:[NSNull class]])
            if (![[counter_dic valueForKey:@"counterDetails"] isEqualToString:@"<null>"])
                
                //upto here on 09/08/2017....
                
                if (counter_dic.count!= 0) {
                    
                    //commented by Srinivaulu on 09/08/2017....
                    
                    
                    //                                        finalLicencesDetails = [[NSMutableArray alloc] init];
                    //
                    //                                        for (int j = 0; j < [response_arr count]; j++) {
                    //                                            NSDictionary *JSON = [response_arr objectAtIndex:j];
                    //                                            [finalLicencesDetails addObject:[JSON valueForKey:@"licenseType"]];
                    //                                        }
                    
                    counterName = [[counter_dic valueForKey:@"counterName"] copy];
                    counterIdStr = [[counter_dic valueForKey:@"counterId"] copy];
                    
                    
                    //added by Srinivasulu on 06/10/2017 -- 19/04/2018....
                    
                    if ([counter_dic.allKeys containsObject:SERVER_DATE_STR] && ![[counter_dic valueForKey:SERVER_DATE_STR] isKindOfClass:[NSNull class]]) {
                        
                        serverDateStr = [counter_dic valueForKey:SERVER_DATE_STR];
                    }
                    
                    isMasterCounter = [[self checkGivenValueIsNullOrNil:[counter_dic valueForKey:MASTER_COUNTER]  defaultReturn:@"0"] boolValue];
                    
                    //upto here on 06/10/2017 -- 19/04/2018....
                    
                    
                    //                                        defaults = [[NSUserDefaults alloc]init];
                    
                    // get the latest serial bill_id... added on 9-03-17 by sonali
                    
                    NSString *lastSavedId = @"0";
                    
                    NSString *maxNo = @"0";
                    
                    if (![[defaults valueForKey:kLatestSerialBillId] isKindOfClass:[NSNull class]] && [defaults valueForKey:kLatestSerialBillId] != nil) {
                        lastSavedId = [NSString stringWithFormat:@"%@",@([[defaults valueForKey:kLatestSerialBillId] longLongValue])] ;
                    }
                    
                    if ([successDictionary.allKeys containsObject:kLatestSerialBillId] && ![[successDictionary valueForKey:kLatestSerialBillId] isKindOfClass:[NSNull class]]) {
                        
                        //  NSComparisonResult result = [lastSavedId compare:[NSNumber numberWithInt:[[successDictionary valueForKey:kLatestSerialBillId] integerValue]]];
                        
                        //  maxNo = (result==NSOrderedDescending)?[successDictionary valueForKey:kLatestSerialBillId] :lastSavedId;
                        
                        NSLog(@"%lld",[[successDictionary valueForKey:kLatestSerialBillId] longLongValue]);
                        maxNo = [NSString stringWithFormat:@"%lld",MAX([lastSavedId longLongValue], [[successDictionary valueForKey:kLatestSerialBillId] longLongValue])] ;
                        
                    }
                    //added by Srinivasulu on 06/0/2017....
                    //reason is used for serialBillIdNo....
                    
                    
                    //commented by Srinivasulu on 20/09/2017....
                    //reason -- changed the scope..  Bill id should be save in local only....
                    
                    //                                        if ([[counter_dic allKeys] containsObject:@"runningBillSerialNum"] && ![[counter_dic valueForKey:@"runningBillSerialNum"] isKindOfClass:[NSNull class]]) {
                    //                                            NSString * runbillNoStr = [counter_dic valueForKey:@"runningBillSerialNum"];
                    //
                    //                                            if(![runbillNoStr isEqualToString:@""] && (runbillNoStr.length < 6))
                    //                                                [defaults setObject:runbillNoStr forKey:LAST_BILL_COUNT];
                    //                                            else
                    //                                                [defaults setObject:@"0000" forKey:LAST_BILL_COUNT];
                    //
                    //
                    //                                        }
                    //                                        else{
                    //
                    //                                            [defaults setObject:@"0000" forKey:LAST_BILL_COUNT];
                    //                                        }
                    //
                    //upto here on 20/09/2017....
                    
                    //upto here on 06/07/2017....
                    
                    
                    
                    //                                        [defaults setObject:finalLicencesDetails forKey:@"licence"];
                    
                    
                    
                    [defaults setObject:counterName forKey:@"counterName"];
                    
                    [defaults setObject:firstName forKey:@"firstName"];
                    
                    [defaults setObject:cashierId forKey:EMPLOYEE_ID];//added by Srinivasulu on 10/04/2018....it not saving for offline login..
                    
                    if ([custID caseInsensitiveCompare:@"CID8995438"] == NSOrderedSame) {
                        [defaults setObject:maxNo forKey:kLatestSerialBillId];
                        
                    }
                    
                    [defaults synchronize];
                    
                    if (![[successDictionary valueForKey:@"syncSettings"] isKindOfClass:[NSNull class]]) {
                        
                        tableStatus = [[[successDictionary valueForKey:@"syncSettings"]valueForKey:@"tableStatus"] boolValue];
                        waiterStatus = [[[successDictionary valueForKey:@"syncSettings"]valueForKey:@"waitersStatus"] boolValue];
                        skuStatus = [[[successDictionary valueForKey:@"syncSettings"]valueForKey:@"skuStatus"] boolValue];
                        taxStatus = [[[successDictionary valueForKey:@"syncSettings"]valueForKey:@"taxStatus"] boolValue];
                        offerStatus = [[[successDictionary valueForKey:@"syncSettings"]valueForKey:@"offerStatus"] boolValue];
                        dealStatus = [[[successDictionary valueForKey:@"syncSettings"]valueForKey:@"dealStatus"] boolValue];
                        employeeStatus = [[[successDictionary valueForKey:@"syncSettings"]valueForKey:@"employeeStatus"] boolValue];
                        denominationStatus = [[[successDictionary valueForKey:@"syncSettings"]valueForKey:@"denominationMasterStatus"] boolValue];
                        
                        //commented by  Srinivasulu on 27/06/2017....
                        
                        //                                        shiftId = [[NSString stringWithFormat:@"%@",[[[successDictionary valueForKey:@"shifts"] valueForKey:@"shiftId"] stringValue]] copy] ;
                        //                                        shiftStart = [NSString stringWithFormat:@"%@",[[successDictionary valueForKey:@"start_time"] valueForKey:@"shiftId"] ] ;
                        //                                        shiftEnd = [NSString stringWithFormat:@"%@",[[successDictionary valueForKey:@"shifts"] valueForKey:@"end_time"] ] ;
                        
                        //added by  Srinivasulu on 27/06/2017....
                        
                        categoryStatus = [[[successDictionary valueForKey:@"syncSettings"]valueForKey:@"productCategoryStatus"] boolValue];
                        subCategoruStatus = [[[successDictionary valueForKey:@"syncSettings"] valueForKey:@"productSubCategoryStatus"] boolValue];
                        
                        productStatus  = [[[successDictionary valueForKey:@"syncSettings"] valueForKey:@"productMasterStatus"] boolValue];
                        
                        // added by roja on 06/06/2019...
                        giftCouponStatus  = [[[successDictionary valueForKey:@"syncSettings"] valueForKey:@"giftCouponStatus"] boolValue];
                        
                        giftVoucherStatus  = [[[successDictionary valueForKey:@"syncSettings"] valueForKey:@"giftVoucherStatus"] boolValue];
                        
                        loyaltyCardsStatus  = [[[successDictionary valueForKey:@"syncSettings"] valueForKey:@"loyaltyCardsStatus"] boolValue];
                        //Upto here added by roja on 06/06/2019...
                        
                    }
                    
                }
        
        //added by  Srinivasulu on 27/07/2017....
        
        if(([successDictionary.allKeys containsObject:@"shifts"]) && (! [[successDictionary valueForKey:@"shifts"]  isKindOfClass:[NSNull class]])){
            
            if(([[[successDictionary valueForKey:@"shifts"] allKeys] containsObject:@"shiftId"]) && (! [[[successDictionary valueForKey:@"shifts"] valueForKey:@"shiftId"]  isKindOfClass:[NSNull class]]))
                
                shiftId = [[NSString stringWithFormat:@"%@",[[[successDictionary valueForKey:@"shifts"] valueForKey:@"shiftId"] stringValue]] copy] ;
            
            if(([[[successDictionary valueForKey:@"shifts"] allKeys] containsObject:@"start_time"]) && (! [[[successDictionary valueForKey:@"shifts"] valueForKey:@"start_time"]  isKindOfClass:[NSNull class]]))
                
                shiftStart = [NSString stringWithFormat:@"%@",[[successDictionary valueForKey:@"shifts"] valueForKey:@"start_time"] ] ;
            
            if(([[[successDictionary valueForKey:@"shifts"] allKeys] containsObject:@"end_time"]) && (! [[[successDictionary valueForKey:@"shifts"] valueForKey:@"end_time"]  isKindOfClass:[NSNull class]]))
                
                shiftEnd = [NSString stringWithFormat:@"%@",[[successDictionary valueForKey:@"shifts"] valueForKey:@"end_time"] ] ;
            
        }
        
        //added by Srinivasulu on 17/10/2017 && 19/04/2018....
        if ([successDictionary.allKeys containsObject:SERVER_DATE_STR] && ![[successDictionary valueForKey:SERVER_DATE_STR] isKindOfClass:[NSNull class]]) {
            
            serverDateStr = [successDictionary valueForKey:SERVER_DATE_STR];
        }
        
        [defaults setObject:@(isMasterCounter) forKey:MASTER_COUNTER];
        
        //upto here on 17/10/2017 && 19/04/2018....
        
        if(defaults == nil)
            defaults = [[NSUserDefaults alloc]init];
        
        if(([successDictionary.allKeys containsObject:@"hubUser"]) && (! [[successDictionary valueForKey:@"hubUser"]  isKindOfClass:[NSNull class]]))
            isHubLevel = [[successDictionary valueForKey:@"hubUser"]boolValue];
        
        //upto here on 27/07/2017....
        //added by  Srinivasulu on 07/06/2017....
        
        //added by  Srinivasulu on 18/08/2017....
        StoreAddressStr = @"";
        //upto here on 18/08/2017....
        
        
        if(([successDictionary.allKeys containsObject:BUSINESS_NAME]) && (! [[successDictionary valueForKey:BUSINESS_NAME]  isKindOfClass:[NSNull class]])){
            
            StoreAddressStr = [NSString stringWithFormat:@"%@%@%@",[successDictionary valueForKey:BUSINESS_NAME],@",",@"\n" ];
            
            [defaults setObject:[successDictionary valueForKey:BUSINESS_NAME] forKey:CUSTOMER_DEFAULT_LANDMARK];
        }
        
        //added by  Bhargav on 07/08/2017....
        
        if(([successDictionary.allKeys containsObject:MASTER_OBJ]) && (![[successDictionary valueForKey:MASTER_OBJ]  isKindOfClass:[NSNull class]])){
            
            zoneID = [NSString stringWithFormat:@"%@",[[successDictionary valueForKey:MASTER_OBJ] valueForKey:ZONE_ID]];
        }
        
        //upto here on 27/08/2017....
        
        
        if(([successDictionary.allKeys containsObject:LOGO_URL]) && (! [[successDictionary valueForKey:LOGO_URL]  isKindOfClass:[NSNull class]])){
            
            
            NSString * string = [successDictionary valueForKey:LOGO_URL];
            
            string = [string stringByReplacingOccurrencesOfString:@"\\" withString:@"/" ];
            
            string = [string stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            
            [defaults setObject:string forKey:LOGO_URL];
            
        }
        else{
            [defaults setObject:@"" forKey:LOGO_URL];
            
        }
        
        //added by  Srinivasulu on 22/07/2017....
        
        //commented by Srinivasulu on 25/07/2017....
        
        
        if(([successDictionary.allKeys containsObject:PRINT_BILL_URL]) && (! [[successDictionary valueForKey:PRINT_BILL_URL]  isKindOfClass:[NSNull class]])){
            
            
            NSString * string = [successDictionary valueForKey:PRINT_BILL_URL];
            
            string = [string stringByReplacingOccurrencesOfString:@"\\" withString:@"/" ];
            
            string = [string stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            
            
            //                                    NSString * match = @"Configurations";
            //                                    NSString * unWantedString;
            //
            //
            //                                    NSScanner *scanner = [NSScanner scannerWithString:string];
            //                                    [scanner scanUpToString:match intoString:&unWantedString];
            //
            //                                    [scanner scanString:match intoString:nil];
            //                                    string = [string substringFromIndex:scanner.scanLocation];
            
            //                                    string = string stringByAppendingString:(nonnull NSStr52"ing *)
            
            [defaults setObject:string forKey:PRINT_BILL_URL];
            
        }
        else{
            [defaults setObject:@"" forKey:PRINT_BILL_URL];
            
        }
        
        //upto here on 23/07/2017....
        
        if([[defaults valueForKey:LOGO_URL] length]){
            
            NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[defaults valueForKey:LOGO_URL]]];
            
            if (imgData != nil) {
                
                NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation([UIImage imageWithData:imgData])];
                
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectory = paths[0];
                
                NSString *imageName = [[defaults valueForKey:LOGO_URL] componentsSeparatedByString:@"/"].lastObject;
                
                NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:imageName];
                [imageData writeToFile:savedImagePath atomically:NO];
                
            }
            
        }
        
        if([[defaults valueForKey:PRINT_BILL_URL] length]){
            
            NSData * billPrintFormatData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[defaults valueForKey:PRINT_BILL_URL]]];
            
            if (billPrintFormatData != nil) {
                
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectory = paths[0];
                
                
                NSString * billPrintFormatStr = [[defaults valueForKey:PRINT_BILL_URL] componentsSeparatedByString:@"/"].lastObject;
                //                                        NSString * billPrintFormatStr = OFFLINE_PRINT_XML;
                
                NSString * billPrintFormatFilePath = [documentsDirectory stringByAppendingPathComponent:billPrintFormatStr];
                [billPrintFormatData writeToFile:billPrintFormatFilePath atomically:NO];
            }
        }
        
        //upto here on 25/07/2017 && 07/06/2017....
        
        [self loginDetailsHandling];
       
    }

    @catch (NSException *exception) {

        NSLog(@"%@",exception);
        UIAlertView *invalid = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:exception.description delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [invalid show];
        return;

    }
    @finally{
        
        [self callAppSettings];

        [HUD setHidden:YES];
    }
}

// Added by roja on 17/10/2019....
// At the time of converting SOAP call's to REST
- (void)authenticateUserErrorResponse:(NSString *)errorResponse{
    
    @try {

        if ([errorResponse isEqualToString:@"Unauthorized"]){
            
            errorResponse = @"Please Check Credentials";
//            UIAlertView *invalid = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"Please Check Credentials" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [invalid show];
        }
       
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        if(errorResponse != nil){
            
            UIAlertView *invalid = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:errorResponse delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [invalid show];
        }

        [HUD setHidden:YES];
    }
    
}

// Below method is latest one added by roja on 17/10/2019...
// At the time of converting SOAP call's to REST
-(void)loginDetailsHandling{
    
        //added by Srinivasulu on 06/10/2017....
        NSUserDefaults * defaults  = [NSUserDefaults standardUserDefaults];
        
        if (serverDateStr != nil && serverDateStr.length > 0) {
            
            
            NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"dd/MM/yyyy";
            //
            //                            NSDate * dataFromServerStr = [[NSDate alloc] init];
            //                            dataFromServerStr = [dateFormatter dateFromString:serverDateStr];
            //
            //                            NSDate *today = [NSDate date];
            //                            NSString * currentdate = [dateFormatter stringFromDate:today];
            //
            //                            NSDate * now = [[NSDate alloc] init];
            //                            now = [dateFormatter dateFromString:currentdate];
            //
            //                            if(!([now compare:dataFromServerStr] == NSOrderedSame)) {
            //
            //                                [HUD setHidden:YES];
            //                                UIAlertView *invalid = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"Please, Check device date" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            //                                [invalid show];
            //                                return;
            //                            }
            
            NSDate * dateFromServer = [dateFormatter dateFromString:serverDateStr];
            NSDate * dateFromDevice = [dateFormatter dateFromString:[dateFormatter stringFromDate:[NSDate date]]];
            
            if ([[defaults valueForKey:BUSSINESS_DATE] isKindOfClass:[NSNull class]] || [defaults valueForKey:BUSSINESS_DATE] == nil) {
                
                //changed by Srinivasulu on 21/10/2017....
                //reason we need to sent the server date not device date....
                
                if(serverDateStr.length){
                    
                    [defaults setValue:serverDateStr forKey:BUSSINESS_DATE];
                }
                else{
                    
                    NSString *currentDate = [WebServiceUtility getCurrentDate];
                    [defaults setValue:[currentDate componentsSeparatedByString:@" "][0] forKey:BUSSINESS_DATE];
                }
                
                //upto here on 21/10/2017....
                [defaults setValue:@"0000" forKey:LAST_BILL_COUNT];
                [defaults setValue:@"0.00" forKey:LAST_BILL_TOTAL];
            }
            
            if (!([dateFromDevice compare:dateFromServer] == NSOrderedSame)) {
                
                [HUD setHidden:YES];
                UIAlertView *invalid = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"message", nil) message:NSLocalizedString(@"device_date_alert", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil];
                [invalid show];
                return;
            }
            
            //commented by Srinivasulu on 18/10/2017....
            //reason -- Issue raised by Sir.... in z report only date has to be changed....
            
            //                            else if([WebServiceUtility numberOfDaysDifference:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@",[defaults valueForKey:BUSSINESS_DATE]]]] > 1){
            //
            //                                [defaults setValue:serverDateStr forKey:BUSSINESS_DATE];
            //                                [defaults setValue:@"0000" forKey:LAST_BILL_COUNT];
            //                            }
            
            //upto here on 18/10/2017....
            
        }
        //upto here on 06/10/2017....
        
        
        mail_ = [emailIDtxt.text copy];
        custID = [userIDtxt.text copy];
        
        //below variable name has to be changed.  written by Srinivasulu on 30/08/2017....
        
        //
        [defaults setValue:passwordtxt.text forKey:@"loginPassword"];
        
        //added by Srinivasulu on 24/04/2017....
        
        [defaults setValue:userIDtxt.text forKey:@"customerId"];
        [defaults setValue:passwordtxt.text forKey:@"password"];
        [defaults setValue:emailIDtxt.text forKey:@"emailId"];
        
        
        
        //if we want static device id....
        //while giving the build this lines of code should be commented.. writeen by Srinivasulu on 21/08/2017....
        //when giving without offline DB....
        
        
        
        //added by Srinivasulu on 20/07/2017....
        //it will be executed. When offline data in not loaded for atleast one time....
        //used for coding processing....
        //while giving the build this line of code should be commented.. writeen by Srinivasulu on 21/08/2017....
        
        //                                        [defaults setObject:@"" forKey:LAST_SKU_UPDATED];
        //                                        [defaults setObject:@"" forKey:LAST_SKU_UPDATED_DATE];
        //                                        [defaults setObject:@"" forKey:LAST_SKU_EAN_UPDATED];
        //                                        [defaults setObject:@"" forKey:LAST_PRICE_UPDATED];
        //                                        [defaults setObject:@"" forKey:UPDATED_DATE_STR];
        //
        //                                        [defaults setObject:@"" forKey:LAST_DEALS_UPDATED];
        //                                        [defaults setObject:@"" forKey:LAST_OFFERS_UPDATED];
        //                                        [defaults setObject:@"" forKey:LAST_GROUPS_UPDATED];
        //                                        [defaults setObject:@"" forKey:LAST_GROUP_CHILDS_UPDATED];
        //                                        [defaults setObject:@"" forKey:LAST_EMPL_UPDATED_DATE];
        //                                        [defaults setObject:@"" forKey:LAST_DENOMINATIONS_UPDATE_DATE];
        //
        //                                        skuStatus = true;
        //                                        dealStatus = true;
        //                                        offerStatus = true;
        //                                        taxStatus = true;
        //                                        employeeStatus = true;
        //                                        productStatus = true;
        //                                        denominationStatus = true;
        
        
        
        //                        //sku_master_table....
        //                        if ([[defaults valueForKey:LAST_SKU_UPDATED] length]==0)
        //                            [defaults setObject:@"22/09/2017 00:00:00" forKey:LAST_SKU_UPDATED];
        //
        //                        //sku_master_table....
        //                        if ([[defaults valueForKey:LAST_SKU_UPDATED_DATE] length]==0)
        //                            [defaults setObject:@"22/09/2017 00:00:00" forKey:LAST_SKU_UPDATED_DATE];
        //
        //                        //sku_eans_table....
        //                        if ([[defaults valueForKey:LAST_SKU_EAN_UPDATED] length]==0)
        //                            [defaults setObject:@"22/09/2017 00:00:00" forKey:LAST_SKU_EAN_UPDATED];
        //
        //                        //price_list_table....
        //                        if ([[defaults valueForKey:LAST_PRICE_UPDATED] length]==0)
        //                            [defaults setObject:@"22/09/2017 00:00:00" forKey:LAST_PRICE_UPDATED];
        //
        //                        //product_master_table....
        //                        if ([[defaults valueForKey:UPDATED_DATE_STR] length]==0)
        //                            [defaults setObject:@"22/09/2017 00:00:00" forKey:UPDATED_DATE_STR];
        //
        //                        //deals_table....
        //                        if ([[defaults valueForKey:LAST_DEALS_UPDATED] length]==0)
        //                            [defaults setObject:@"18/08/2016 05:34:37" forKey:LAST_DEALS_UPDATED];
        //
        //                        //offers_table....
        //                        if ([[defaults valueForKey:LAST_OFFERS_UPDATED] length]==0)
        //                            [defaults setObject:@"18/08/2016 05:34:37" forKey:LAST_OFFERS_UPDATED];
        //
        //                        //groups_table....
        //                        if ([[defaults valueForKey:LAST_GROUPS_UPDATED] length]==0)
        //                            [defaults setObject:@"26/09/2016 05:34:37" forKey:LAST_GROUPS_UPDATED];
        //
        //                        //group_Chlid_table
        //                        if ([[defaults valueForKey:LAST_GROUP_CHILDS_UPDATED] length]==0)
        //                            [defaults setObject:@"26/09/2016 01:34:37" forKey:LAST_GROUP_CHILDS_UPDATED];
        //
        //                        //empolyee_table....
        //                        if ([[defaults valueForKey:LAST_EMPL_UPDATED_DATE] length]==0)
        //                            [defaults setObject:@"26/09/2016 01:34:37" forKey:LAST_EMPL_UPDATED_DATE];
        //
        //                        //denominations_table....
        //                        if ([[defaults valueForKey:LAST_DENOMINATIONS_UPDATE_DATE] length]==0)
        //                            [defaults setObject:@"18/09/2016 01:34:37" forKey:LAST_DENOMINATIONS_UPDATE_DATE];
        
        
        
        
        //                        NSString * time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        //                        NSArray * str = [time componentsSeparatedByString:@" "];
        //                        NSString * dateStr = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
        //
        //                        //sku_master_table....
        //                        if ([[defaults valueForKey:LAST_SKU_UPDATED] length]==0)
        //                            [defaults setValue:dateStr forKey:LAST_SKU_UPDATED];
        //
        //                        //sku_master_table....
        //                        if ([[defaults valueForKey:LAST_SKU_UPDATED_DATE] length]==0)
        //                            [defaults setObject:dateStr forKey:LAST_SKU_UPDATED_DATE];
        //
        //                        //sku_eans_table....
        //                        if ([[defaults valueForKey:LAST_SKU_EAN_UPDATED] length]==0)
        //                            [defaults setValue:dateStr forKey:LAST_SKU_EAN_UPDATED];
        //
        //                        //price_list_table....
        //                        if ([[defaults valueForKey:LAST_PRICE_UPDATED] length]==0)
        //                            [defaults setValue:dateStr forKey:LAST_PRICE_UPDATED];
        //
        //                        //product_master_table....
        //                        if ([[defaults valueForKey:UPDATED_DATE_STR] length]==0)
        //                            [defaults setValue:dateStr forKey:UPDATED_DATE_STR];
        //
        //                        //deals_table....
        //                        if ([[defaults valueForKey:LAST_DEALS_UPDATED] length]==0)
        //                            [defaults setValue:dateStr forKey:LAST_DEALS_UPDATED];
        //
        //                        //offers_table....
        //                        if ([[defaults valueForKey:LAST_OFFERS_UPDATED] length]==0)
        //                            [defaults setValue:dateStr forKey:LAST_OFFERS_UPDATED];
        //
        //                        //groups_table....
        //                        if ([[defaults valueForKey:LAST_GROUPS_UPDATED] length]==0)
        //                            [defaults setValue:dateStr forKey:LAST_GROUPS_UPDATED];
        //
        //                        //group_Chlid_table
        //                        if ([[defaults valueForKey:LAST_GROUP_CHILDS_UPDATED] length]==0)
        //                            [defaults setValue:dateStr forKey:LAST_GROUP_CHILDS_UPDATED];
        //
        //                        //empolyee_table....
        //                        if ([[defaults valueForKey:LAST_EMPL_UPDATED_DATE] length]==0)
        //                            [defaults setValue:dateStr forKey:LAST_EMPL_UPDATED_DATE];
        //
        //                        //denominations_table....
        //                        if ([[defaults valueForKey:LAST_DENOMINATIONS_UPDATE_DATE] length]==0)
        //                            [defaults setValue:dateStr forKey:LAST_DENOMINATIONS_UPDATE_DATE];
        
        
        
        //upto here on 21/08/2017....
        
        
        //sku_master_table....  -- note :-- LAST_SKU_UPDATED_DATE and LAST_SKU_UPDATED both are using for sku_master download need to be removed....
        if ([[defaults valueForKey:LAST_SKU_UPDATED_DATE] isKindOfClass:[NSNull class]] || [defaults valueForKey:LAST_SKU_UPDATED_DATE] == nil) {
            
            if(![[defaults valueForKey:LAST_SKU_UPDATED_DATE] length]){
                
                skuStatus = true;
            }
        }
        
        //sku_eans_table....
        if ([[defaults valueForKey:LAST_SKU_EAN_UPDATED] isKindOfClass:[NSNull class]] || [defaults valueForKey:LAST_SKU_EAN_UPDATED] == nil) {
            
            if(![[defaults valueForKey:LAST_SKU_EAN_UPDATED] length]){
                
                skuStatus = true;
            }
        }
        
        //price_list_table....
        if ([[defaults valueForKey:LAST_PRICE_UPDATED] isKindOfClass:[NSNull class]] || [defaults valueForKey:LAST_PRICE_UPDATED] == nil) {
            
            if(![[defaults valueForKey:LAST_PRICE_UPDATED] length]){
                
                skuStatus = true;
            }
        }
        
        //product_master_table....
        if ([[defaults valueForKey:UPDATED_DATE_STR] isKindOfClass:[NSNull class]] || [defaults valueForKey:UPDATED_DATE_STR] == nil)
            if(![[defaults valueForKey:UPDATED_DATE_STR] length]){
                
                productStatus = true;
                categoryStatus = true;
                subCategoruStatus = true;
            }
        
        //deals_table....
        if ([[defaults valueForKey:LAST_DEALS_UPDATED] isKindOfClass:[NSNull class]] || [defaults valueForKey:LAST_DEALS_UPDATED] == nil)
            if(![[defaults valueForKey:LAST_DEALS_UPDATED] length])
                dealStatus = true;
        
        
        //offers_table....
        if ([[defaults valueForKey:LAST_OFFERS_UPDATED] isKindOfClass:[NSNull class]] || [defaults valueForKey:LAST_OFFERS_UPDATED] == nil)
            if(![[defaults valueForKey:LAST_OFFERS_UPDATED] length])
                offerStatus = true;
        
        
        //employee_table....
        if ([[defaults valueForKey:LAST_EMPL_UPDATED_DATE] isKindOfClass:[NSNull class]] || [defaults valueForKey:LAST_EMPL_UPDATED_DATE] == nil)
            if(![[defaults valueForKey:LAST_EMPL_UPDATED_DATE] length])
                employeeStatus = true;
        
        //denominations_table....
        if ([[defaults valueForKey:LAST_DENOMINATIONS_UPDATE_DATE] isKindOfClass:[NSNull class]] || [defaults valueForKey:LAST_DENOMINATIONS_UPDATE_DATE] == nil)
            if(![[defaults valueForKey:LAST_DENOMINATIONS_UPDATE_DATE] length])
                denominationStatus = true;
        
        //customer_table....
        if ([[defaults valueForKey:LAST_CUSTOMERS_LIST_UPDATE_DATE] isKindOfClass:[NSNull class]] || [defaults valueForKey:LAST_CUSTOMERS_LIST_UPDATE_DATE] == nil)
            if(![[defaults valueForKey:LAST_CUSTOMERS_LIST_UPDATE_DATE] length])
                customerDownLoadStatus = true;
        
        //member_details, roles....
        if ([[defaults valueForKey:LAST_MEMBER_DETAILS_UPDATE_DATE] isKindOfClass:[NSNull class]] || [defaults valueForKey:LAST_MEMBER_DETAILS_UPDATE_DATE] == nil)
            if(![[defaults valueForKey:LAST_MEMBER_DETAILS_UPDATE_DATE] length])
                memberDetailsDownLoad = true;
        
        if(skuStatus &&  dealStatus &&  offerStatus && employeeStatus && denominationStatus && customerDownLoadStatus && memberDetailsDownLoad){
            
            taxStatus = true;
            //                            isDayStartWithSync = false;
        }
        //lastDealsUpdated
        //upto here o 18/07/2017....
        //upto here on 24/04/2017....
        
        // added by roja on 06/06/2019...
        
        //gift_coupons status....
        if ([[defaults valueForKey:LAST_GIFT_COUPONS_UPDATED_DATE] isKindOfClass:[NSNull class]] || [defaults valueForKey:LAST_GIFT_COUPONS_UPDATED_DATE] == nil)
            if(![[defaults valueForKey:LAST_GIFT_COUPONS_UPDATED_DATE] length])
                giftCouponStatus = true;
        
        //gift_vouchers status....
        if ([[defaults valueForKey:LAST_VOUCHERS_UPDATED_DATE] isKindOfClass:[NSNull class]] || [defaults valueForKey:LAST_VOUCHERS_UPDATED_DATE] == nil)
            if(![[defaults valueForKey:LAST_VOUCHERS_UPDATED_DATE] length])
                giftVoucherStatus = true;
        
        //loyalty_card status....
        if ([[defaults valueForKey:LAST_LOYALTY_CARDS_UPDATED_DATE] isKindOfClass:[NSNull class]] || [defaults valueForKey:LAST_LOYALTY_CARDS_UPDATED_DATE] == nil)
            if(![[defaults valueForKey:LAST_LOYALTY_CARDS_UPDATED_DATE] length])
                loyaltyCardsStatus = true;
        // Upto here added by roja on 06/06/2019...
        
        
//        [self callAppSettings]; // instead of calling here, better to call in successResponse of authenticateUser 
    
        user_name = [userIDtxt.text copy];
        //                    [HUD setHidden:YES];
        //                    OmniHomePage *homepage = [[[OmniHomePage alloc] init] autorelease];
        //                    [self.navigationController pushViewController:homepage animated:YES];
}






//callAppSettings method changed by roja on 17/10/2019..
// At the time of converting SOAP call's to REST
-(void)callAppSettings {

    BOOL status = FALSE;

    //changed by Srinivasulu on 20/07/2017....

    //    UIDevice *myDevice = [UIDevice currentDevice];
    //    deviceUDID = [[myDevice identifierForVendor] UUIDString];

    //upto here on 20/07/2017....

    @try {

        NSArray *loyaltyKeys = @[@"userId", @"emailId",REQUEST_HEADER];

        NSArray *loyaltyObjects = @[custID,mail_,[RequestHeader getRequestHeader]];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];

        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];

        WebServiceController *webService = [[WebServiceController alloc] init];
        webService.appSettingServicesDelegate = self;
        [webService getAppSettings:loyaltyString];


    }
    @catch (NSException *exception) {

        NSLog(@"%@",exception.description);
        [HUD setHidden:YES];
        UIAlertView *timeOut = [[UIAlertView alloc] initWithTitle:@"Unable to connect" message:@"Time Out or Domain Error\nCheck the configuration" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [timeOut show];
        return;

    }

}

- (void)getAppSettingsSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        Boolean isCounterRequiredOTP = false;
        
        discountReasons = [NSMutableArray new];
        //added by Srinivasulu on 15/06/2017....
        returnReasonsArr = [NSMutableArray new];
        NSUserDefaults * defaults  = [[NSUserDefaults alloc] init];

        if (![[successDictionary valueForKey:PRODUCT_RETURN_REASONS] isKindOfClass:[NSNull class]]) {
            NSArray *discReasons = [successDictionary valueForKey:PRODUCT_RETURN_REASONS];
            for (NSDictionary *resonDic in discReasons) {
                [returnReasonsArr addObject:[resonDic valueForKey:REASON_DESCRIPTION]];
            }
        }
        //upto here on 15/06/2017....
        
        if (![[successDictionary valueForKey:PRODUCT_DISCOUNT_REASONS] isKindOfClass:[NSNull class]]) {
            NSArray *discReasons = [successDictionary valueForKey:PRODUCT_DISCOUNT_REASONS];
            for (NSDictionary *resonDic in discReasons) {
                [discountReasons addObject:[resonDic valueForKey:REASON_DESCRIPTION]];
            }
        }
        
        if ([successDictionary.allKeys containsObject:@"zone"] && ![[successDictionary valueForKey:@"zone"] isKindOfClass:[NSNull class]]) {
            zone = [[successDictionary valueForKey:@"zone"] copy];
        }
        //added by Srinivasulu on 31/05/2017 && 22/06/2017....
        
        if ([successDictionary.allKeys containsObject:LOCATION_OBJ] && ![[successDictionary valueForKey:LOCATION_OBJ] isKindOfClass:[NSNull class]]) {
            
            NSDictionary * locObj = [successDictionary valueForKey:LOCATION_OBJ];
            
            if(([locObj.allKeys containsObject:ADDRESS]) && (! [[locObj valueForKey:ADDRESS]  isKindOfClass:[NSNull class]])){
                
                StoreAddressStr =  [NSString stringWithFormat:@"%@%@%@%@", StoreAddressStr,[locObj valueForKey:ADDRESS],@",",@"\n" ];
                [defaults setObject:[locObj valueForKey:ADDRESS] forKey:ADDRESS];
            }
            
            if(([locObj.allKeys containsObject:AREA]) && (! [[locObj valueForKey:AREA]  isKindOfClass:[NSNull class]])){
                
                StoreAddressStr =  [NSString stringWithFormat:@"%@%@%@%@", StoreAddressStr,[locObj valueForKey:AREA],@",",@"\n" ];
                [defaults setObject:[locObj valueForKey:AREA] forKey:CUSTOMER_DEFAULT_AREA];
            }
            
            if(([locObj.allKeys containsObject:CUSTOMER_CITY]) && (! [[locObj valueForKey:CUSTOMER_CITY]  isKindOfClass:[NSNull class]])){
                
                StoreAddressStr =  [NSString stringWithFormat:@"%@%@%@%@", StoreAddressStr,[locObj valueForKey:CUSTOMER_CITY],@",",@"\n" ];
                [defaults setObject:[locObj valueForKey:CUSTOMER_CITY] forKey:CUSTOMER_DEFAULT_CITY];
            }
            
            if(([locObj.allKeys containsObject:STATE]) && (! [[locObj valueForKey:STATE]  isKindOfClass:[NSNull class]])){
                
                StoreAddressStr =  [NSString stringWithFormat:@"%@%@%@", StoreAddressStr,[locObj valueForKey:STATE],@"" ];
                [defaults setObject:[locObj valueForKey:STATE] forKey:CUSTOMER_DEFAULT_STATE];
            }
            
            if(([locObj.allKeys containsObject:PIN]) && (! [[locObj valueForKey:PIN]  isKindOfClass:[NSNull class]])){
                
                StoreAddressStr =  [NSString stringWithFormat:@"%@%@%@%@%@",StoreAddressStr, @"-",[locObj valueForKey:PIN],@".",@"\n" ];
                [defaults setObject:[locObj valueForKey:PIN] forKey:CUSTOMER_DEFAULT_PIN];
            }
            
            //                   if(([[locObj allKeys] containsObject:OFFICE_PHONE]) && (! [[locObj valueForKey:OFFICE_PHONE]  isKindOfClass:[NSNull class]])){
            //
            //                        StoreAddressStr =  [NSString stringWithFormat:@"%@%@%@%@%@", StoreAddressStr,@"Phone : ",[locObj valueForKey:OFFICE_PHONE],@".",@"\n" ];
            //                    }
            //
            //                    //added by Srinivasulu on 23/08/2107.....
            //
            //                    else{
            //
            //                        StoreAddressStr =  [NSString stringWithFormat:@"%@%@%@", StoreAddressStr,@"Phone : ",@"\n" ];
            //                    }
            
            
            
            //                    StoreAddressStr = [NSString stringWithFormat:@"%@%@%@",StoreAddressStr,@"\n                 Invoice\n",@"--------------------------------------------\n" ];
        }
        
        //upto here on 31/05/2017 &&22/06/2017 && 22/08/2017 && 23/08/2017........
        
        
        //                NSArray * outletDetails = [successDictionary objectForKey:@"outletDetails"];
        
        //added by Bhargav on 09/08/2017....
        
        NSArray * outletDetails;
        
        
        if ([successDictionary[@"outletDetails"] count]) {
            
            outletDetails = successDictionary[@"outletDetails"];
        }
        
        if ((outletDetails!= nil) && (outletDetails.count)) {
            
            
            //upto here on 09/08/2017....
            
            NSDictionary * location_details = outletDetails[0];
            
            //check for dicount taxation...
            
            if ([location_details.allKeys containsObject:@"discountCalculatedOn"] && ![[location_details valueForKey:@"discountCalculatedOn"] isKindOfClass:[NSNull class]]) {
                
                discCalcOn = [[location_details valueForKey:@"discountCalculatedOn"] copy];
            }
            
            if ([location_details.allKeys containsObject:@"discountTaxation"] && ![[location_details valueForKey:@"discountTaxation"] isKindOfClass:[NSNull class]]) {
                
                discTaxation = [[location_details valueForKey:@"discountTaxation"] copy];
            }
            
            
            //added by Srinivasulu on  30/05/2017 && 07/06/2017 &&  22/08/2017 && 20/09/2017 && 23/08/2107 && 02/07/2018 && 28/08/2018....
            
            if([location_details.allKeys containsObject:ENFORCE_DENOMINATIONS] && (![[location_details valueForKey:ENFORCE_DENOMINATIONS] isKindOfClass:[NSNull class]])) {
                
                isEnforceDenominations = [[location_details  valueForKey:ENFORCE_DENOMINATIONS] boolValue];
            }
            
            if([location_details.allKeys containsObject:ENFORCE_VOID_ITEMS_REASON] && (![[location_details valueForKey:ENFORCE_VOID_ITEMS_REASON] isKindOfClass:[NSNull class]])) {
                
                isEnforceVoidItemsReason = [[location_details  valueForKey:ENFORCE_VOID_ITEMS_REASON] boolValue];
            }
            
            if([location_details.allKeys containsObject:ENFORCE_BILL_CANCEL_REASON] && (![[location_details valueForKey:ENFORCE_BILL_CANCEL_REASON] isKindOfClass:[NSNull class]])) {
                
                isEnforceBillCancelReason = [[location_details  valueForKey:ENFORCE_BILL_CANCEL_REASON] boolValue];
            }
            
            
            if(([location_details.allKeys containsObject:CUSTOMER_PHONE]) && (! [[location_details valueForKey:CUSTOMER_PHONE]  isKindOfClass:[NSNull class]])){
                
                StoreAddressStr =  [NSString stringWithFormat:@"%@%@%@%@%@", StoreAddressStr,@"Phone : ",[location_details valueForKey:CUSTOMER_PHONE],@".",@"\n" ];
                [defaults setObject:[location_details valueForKey:CUSTOMER_PHONE] forKey:CUSTOMER_PHONE];
            }
            else{
                
                StoreAddressStr =  [NSString stringWithFormat:@"%@%@%@", StoreAddressStr,@"Phone : ",@"\n" ];
            }
            
            
            if(([location_details.allKeys containsObject:GST_IN]) && (! [[location_details valueForKey:GST_IN]  isKindOfClass:[NSNull class]])){
                
                StoreAddressStr =  [NSString stringWithFormat:@"%@%@%@%@%@", StoreAddressStr,@"GSTIN : ",[location_details valueForKey:GST_IN],@".",@"\n" ];
            }
            else{
                
                StoreAddressStr =  [NSString stringWithFormat:@"%@%@%@", StoreAddressStr,@"GSTIN : ",@"\n" ];
            }
            
            
            
            presentLocation = [location_details[@"location"] copy];
            
            minPayAmt = [[location_details valueForKey:kMinPayment] floatValue];
            isFoodCouponsAvail = [[location_details valueForKey:kFoodCoupons] boolValue];
            isEmployeeSaleId = [[location_details valueForKey:kEmployeeSaleId] boolValue];
            
            if ([location_details.allKeys containsObject:@"barcodeType"] && ![[location_details valueForKey:@"barcodeType"] isKindOfClass:[NSNull class]]) {
                
                //changed by Srinivasulu on 31/01/2017....
                //reason scanned items are not adding for shaydrifarms.. irrespect
                
                barcodeTypeStr = [[location_details valueForKey:kBarCodeType] copy];
                
                if (([[location_details valueForKey:kBarCodeType] caseInsensitiveCompare:@"ean"] == NSOrderedSame) || ([[location_details valueForKey:kBarCodeType] caseInsensitiveCompare:@"both"] == NSOrderedSame)) {
                    
                    isBarcodeType = true;
                }
                else
                    isBarcodeType = false;
                
            }
            
            if([location_details.allKeys containsObject:kproductsMenu] && ![[location_details valueForKey:kproductsMenu] isKindOfClass:[NSNull class]]) {
                isProductsMenu  = [[location_details  valueForKey:kproductsMenu]boolValue];
                
            }
            
            if([location_details.allKeys containsObject:@"billId"] && ![[location_details valueForKey:@"billId"] isKindOfClass:[NSNull class]]) {
                isCustomerBillId = [[location_details  valueForKey:@"billId"]boolValue];
            }
            
            if([location_details.allKeys containsObject:kRoundingRequired] && ![[location_details valueForKey:kRoundingRequired] isKindOfClass:[NSNull class]]) {
                isRoundingRequired = [[location_details  valueForKey:kRoundingRequired]boolValue];
            }
            
            
            //                if([[location_details allKeys] containsObject:TOLL_FREE_NUM] && ![[location_details valueForKey:TOLL_FREE_NUM] isKindOfClass:[NSNull class]]) {
            
            if([location_details.allKeys containsObject:TOLL_FREE_NUM] && (![[location_details valueForKey:TOLL_FREE_NUM] isKindOfClass:[NSNull class]]  && (![[location_details valueForKey:TOLL_FREE_NUM] isEqualToString:@"<null>"]) )) {
                
                outletTollFreeNumberStr = [location_details  valueForKey:TOLL_FREE_NUM];
            }
            
            
            if([location_details.allKeys containsObject:STORE_CODE_ID] && (![[location_details valueForKey:TOLL_FREE_NUM] isKindOfClass:[NSNull class]]  && (![[location_details valueForKey:STORE_CODE_ID] isEqualToString:STORE_CODE_ID]) )) {
                
                storeCodeStr = [[location_details valueForKey:STORE_CODE_ID] copy];
            }
            
            
            if([location_details.allKeys containsObject:ZERO_STOCK] && (![[location_details valueForKey:ZERO_STOCK] isKindOfClass:[NSNull class]])) {
                
                zeroStockCheckAtOutletLevel = [[location_details  valueForKey:ZERO_STOCK] boolValue];
            }
            
            if([location_details.allKeys containsObject:CAMPAIGN_EXISTS] && (![[location_details valueForKey:CAMPAIGN_EXISTS] isKindOfClass:[NSNull class]])) {
                
                isToCallApplyCampaigns = [[location_details  valueForKey:CAMPAIGN_EXISTS] boolValue];
            }
            
            
            if ([location_details.allKeys containsObject:ITEM_CATEGORY] && ![[location_details valueForKey:ITEM_CATEGORY] isKindOfClass:[NSNull class]]){
                
                businessCategoryStr = [location_details valueForKey:ITEM_CATEGORY];
            }
            
            
            if([location_details.allKeys containsObject:COUNTER_OTP] && (![[location_details valueForKey:COUNTER_OTP] isKindOfClass:[NSNull class]])) {
                
                isCounterRequiredOTP = [[location_details  valueForKey:COUNTER_OTP] boolValue];
            }
            
            //upto here on 30/05/2017 && 07/06/2017 && 22/08/2017 && 07/09/2017 &&  20/09/2017 && 31/01/2018 && 02/07/2018....
            
            NSArray *taxDetails = successDictionary[@"taxDetails"];
            
            finalTaxDetails = [[NSMutableArray alloc] init];
            for (int i = 0; i < taxDetails.count; i++) {
                
                [finalTaxDetails addObject:taxDetails[i]];
            }
            
            
            [defaults setObject:@([location_details[kDoorDelivery]boolValue]) forKey:kDoorDelivery];
            [defaults setObject:@([location_details[kExchange]boolValue]) forKey:kExchange];
            [defaults setObject:@([location_details[kReturnAvailable]boolValue]) forKey:kReturnAvailable];
            [defaults setObject:@([location_details[kproductsMenu] boolValue]) forKey:kproductsMenu];
            if (![location_details[kReturnMode] isKindOfClass:[NSNull class]]) {
                [defaults setObject:location_details[kReturnMode] forKey:kReturnMode];
            }
            [defaults setObject:@([location_details[kPrinting]boolValue]) forKey:kPrinting];
            [defaults setObject:@([location_details[kRemoteBilling]boolValue]) forKey:kRemoteBilling];
            [defaults setObject:@(isBarcodeType) forKey:kBarCodeType];
            [defaults setObject:@(isToCallApplyCampaigns)  forKey:CAMPAIGN_EXISTS];
            [defaults setObject:@(zeroStockCheckAtOutletLevel)  forKey:ZERO_STOCK];
            [defaults setObject:businessCategoryStr  forKey:ITEM_CATEGORY];
            
            [defaults setObject:barcodeTypeStr  forKey:kBarCodeType];
            
            //added by Srinivasulu on 22/06/2017....
            
            if([location_details.allKeys containsObject:MANUAL_DISCOUNTS] && (![[location_details valueForKey:MANUAL_DISCOUNTS] isKindOfClass:[NSNull class]])) {
                
                isManualDiscounts = [[location_details  valueForKey:MANUAL_DISCOUNTS]  boolValue];
            }
            
            if([location_details.allKeys containsObject:HYBRID_MODE] && (![[location_details valueForKey:HYBRID_MODE] isKindOfClass:[NSNull class]])) {
                
                isHybirdMode = [[location_details  valueForKey:HYBRID_MODE]  boolValue];
            }
            
            [defaults setObject:@(isManualDiscounts) forKey:MANUAL_DISCOUNTS];
            [defaults setObject:@(isHybirdMode) forKey:HYBRID_MODE];
            
            //upto here on 22/06/2017....
            
            
            
            //added by Bhargav.v on 20/09/2017....
            
            if([location_details.allKeys containsObject:ZONE_Id] && (![[location_details valueForKey:ZONE_Id] isKindOfClass:[NSNull class]]  && (![[location_details valueForKey:ZONE_Id] isEqualToString:ZONE_Id]) )) {
                
                zoneID = [[location_details valueForKey:ZONE_Id] copy];
            }
            
            if([location_details.allKeys containsObject:@"warehouseId"] && (![[location_details valueForKey:@"warehouseId"] isKindOfClass:[NSNull class]]  && (![[location_details valueForKey:@"warehouseId"] isEqualToString:@"warehouseId"]) )) {
                
                wareHouseIdStr = [[location_details valueForKey:@"warehouseId"] copy];
            }
            
            NSString * storeEmailStr = @"";
            if([location_details.allKeys containsObject:CUSTOMER_MAIL] && (![[location_details valueForKey:CUSTOMER_MAIL] isKindOfClass:[NSNull class]])) {
                
                storeEmailStr = [[location_details valueForKey:CUSTOMER_MAIL] copy];
            }
            [defaults setObject:storeEmailStr forKey:STORE_EMAIL];
            
            //added by Srinivasulu on 20/04/2017....
            
            [defaults setObject:discTaxation forKey:DISCOUNT_TAXATION];
            [defaults setObject:discCalcOn forKey:DISCOUNT_CALCULATED_ON];
            
            
            
            [defaults setObject:storeCodeStr forKey:STORE_CODE_ID];
            
            //added by Srinivasulu on 22/05/2017....
            
            
            //added by Srinivasulu on 20/04/2017....
            
            if((returnReasonsArr != nil) && returnReasonsArr.count)
                [defaults setObject:returnReasonsArr forKey:PRODUCT_RETURN_REASONS];
            
            if((discountReasons != nil) && discountReasons.count)
                [defaults setObject:discountReasons forKey:PRODUCT_DISCOUNT_REASONS];
            
            
            //upto here on 20/04/2017.....
            
            //added by Srinivasulu on 22/05/2017....
            
            if (([location_details.allKeys containsObject:EXCHANGE_MODE]) &&   (![location_details[EXCHANGE_MODE] isKindOfClass:[NSNull class]])) {
                
                [defaults setObject:location_details[EXCHANGE_MODE] forKey:EXCHANGE_MODE];
            }
            
            //upto here on 22/05/2017.....
            
            
            //added by Srinivasulu on 18/09/2017 && 06/02/2017....
            
            if([location_details.allKeys containsObject:LATEST_CAMPAIGNS] && (![[location_details valueForKey:LATEST_CAMPAIGNS] isKindOfClass:[NSNull class]])) {
                
                applyLatestCampaigns = [[location_details  valueForKey:LATEST_CAMPAIGNS]  boolValue];
            }
            
            [defaults setObject:@(applyLatestCampaigns) forKey:LATEST_CAMPAIGNS];
            
            
            
            if([location_details.allKeys containsObject:EDIT_PRICE] && (![[location_details valueForKey:EDIT_PRICE] isKindOfClass:[NSNull class]])) {
                
                allowItemPriceEdit = [[location_details  valueForKey:EDIT_PRICE] boolValue];
            }
            
            
            if([location_details.allKeys containsObject:DAY_START_SYNC] && (![[location_details valueForKey:DAY_START_SYNC] isKindOfClass:[NSNull class]]) && !isDayStartWithSync) {
                
                isDayStartWithSync = [[location_details  valueForKey:DAY_START_SYNC] boolValue];
            }
            
            [defaults setObject:@(allowItemPriceEdit) forKey:EDIT_PRICE];
            
            //upto here on 18/09/2017 && 06/02/2017....
            
            //added by Srinivasulu on 05/12/2017....
            
            if (([location_details.allKeys containsObject:OFFLINE_DATA_TIME_OUT_DAYS]) &&   (![location_details[OFFLINE_DATA_TIME_OUT_DAYS] isKindOfClass:[NSNull class]])) {
                
                [defaults setObject:location_details[OFFLINE_DATA_TIME_OUT_DAYS] forKey:OFFLINE_DATA_TIME_OUT_DAYS];
            }
            else{
                
                [defaults setObject:@"0.00" forKey:OFFLINE_DATA_TIME_OUT_DAYS];
            }
            
            if (([location_details.allKeys containsObject:OFFLINE_DATA_TIME_OUT_HOURS]) &&   (![location_details[OFFLINE_DATA_TIME_OUT_HOURS] isKindOfClass:[NSNull class]])) {
                
                [defaults setObject:location_details[OFFLINE_DATA_TIME_OUT_HOURS] forKey:OFFLINE_DATA_TIME_OUT_HOURS];
            }
            else{
                
                [defaults setObject:@"0.00" forKey:OFFLINE_DATA_TIME_OUT_HOURS];
            }
            
            //upto here on 05/12/2017.....
            
        }
        //upto here by Bharagav on 09/08/2017....
        
        
        StoreAddressStr = StoreAddressStr.uppercaseString;
        
        [defaults setObject:StoreAddressStr forKey:STORE_ADDRESS_STR];
        
        [defaults setObject:emailIDtxt.text forKey:@"emailId"];
        [defaults setObject:passwordtxt.text forKey:@"password"];
        [defaults setObject:@(isCustomerBillId) forKey:kCustomerBillId];
        [defaults setObject:@(isRoundingRequired) forKey:kRoundingRequired];
        [defaults setObject:presentLocation forKey:@"location"];
        [defaults synchronize];
        
        //added by Srinivasulu on 04/04/2018 && 07/04/2018....
        
        if ([successDictionary.allKeys containsObject:SETTINGS_RESPONSE] && ![[successDictionary valueForKey:SETTINGS_RESPONSE] isKindOfClass:[NSNull class]]) {
            
            NSDictionary * settingResDic = [successDictionary valueForKey:SETTINGS_RESPONSE];
            if ([settingResDic.allKeys containsObject:REGIONAL_SETTINGS] && ![[settingResDic valueForKey:REGIONAL_SETTINGS] isKindOfClass:[NSNull class]]) {
                
                NSDictionary * regionalSettingsDic = [settingResDic valueForKey:REGIONAL_SETTINGS];
                if ([regionalSettingsDic.allKeys containsObject:CURRENCY] && ![[regionalSettingsDic valueForKey:CURRENCY] isKindOfClass:[NSNull class]]) {
                    
                    NSString * defaultCurrencyCodeStr = [regionalSettingsDic valueForKey:CURRENCY];
                    if([defaultCurrencyCodeStr componentsSeparatedByString:@"-"]){
                        
                        [defaults setObject:[[defaultCurrencyCodeStr componentsSeparatedByString:@"-"][1] stringByReplacingOccurrencesOfString:@" " withString:@""] forKey:DEFAULT_CURRENCY_CODE];
                        //                                [defaults setObject:[[[defaultCurrencyCodeStr componentsSeparatedByString:@"-"] objectAtIndex:1] stringByTrimmingCharactersInSet:
                        //                                                     [NSCharacterSet punctuationCharacterSet]] forKey:DEFAULT_CURRENCY_CODE];
                    }
                }
            }
        }
        
        //upto here on 04/04/2018 && 07/04/2018....
        
        //                if ([[defaults valueForKey:@"zone"] length]==0) {
        //
        //                    [defaults setObject:zone forKey:@"zone"];
        //                    [defaults synchronize];
        //                }
        
        
        [HUD setHidden:YES];
        [self initializePowaPeripherals];
        
        //changed by Srinivasulu on 24/10/2017....
        //reason -- changed from YES to NO -- reason is if animated YES the the custom navigation header in changing....
        //added by Srinivasulu on 29/08/2018....
        if ( ([[defaults valueForKey:BUSINESS_DATE_UPDATED] isKindOfClass:[NSNull class]] || [defaults valueForKey:BUSINESS_DATE_UPDATED] == nil) && isCounterRequiredOTP ) {
            
            [self formOTPView];
        }
        else{
            OmniHomePage *homepage = [[OmniHomePage alloc] init];
            [self.navigationController pushViewController:homepage animated:NO];
        }
        //upto here on 29/08/2018....
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
    
}

- (void)getAppSettingsErrorResponse:(NSString *)errorResponse{
    
    @try {
        
        NSLog(@"%@",errorResponse);
        UIAlertView *alertMsg = [[UIAlertView alloc] initWithTitle:@"" message:errorResponse delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertMsg show];
        return;
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
    }
    
}

// Handle the response from authenticateUser.
- (void) authenticateUserHandler: (id) value {
    
    [HUD setHidden:YES];
    
    // Handle errors
    if([value isKindOfClass:[NSError class]]) {
        //NSLog(@"%@", value);
        UIAlertView *timeOut = [[UIAlertView alloc] initWithTitle:@"Unable to connect" message:@"Time Out or Domain Error\nCheck the configuration" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [timeOut show];
        return;
    }
    
    // Handle faults
    //    if([value isKindOfClass:[SoapFault class]]) {
    //        //NSLog(@"%@", value);
    //        UIAlertView *timeOut = [[UIAlertView alloc] initWithTitle:@"Unable to connect" message:@"Server is not Responding \nCheck the configuration" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //        [timeOut show];
    //        [timeOut release];
    //        return;
    //    }
    
    if ([value isEqualToString:@"Username Incorrect"]) {
        
        UIAlertView *invalid = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"Incorrect User Name \n Please Enter correct User Name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [invalid show];
    }
    
    else if ([value isEqualToString:@"Password Incorrect"]) {
        
        UIAlertView *invalid = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"Incorrect Password \n Please Enter correct Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [invalid show];
    }
    
    else if ([value isEqualToString:@"Invalid Imei"]){
        
        UIAlertView *invalid = [[UIAlertView alloc] initWithTitle:@"New User" message:@"Please Register" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [invalid show];
    }
    // Do something with the NSString* result
    else {
        NSString* result = (NSString*)value;
        
        if (result.length >= 1) {
            
            
            NSArray *temp = [result componentsSeparatedByString:@"#"];
            
            tax_Value = [temp[1] copy];
            
            // setting the global variable ..
            user_name = [userIDtxt.text copy];
            
            //changed by Srinivasulu on 24/10/2017....
            //reason -- changed from YES to NO -- reason is if animated YES the the custom navigation header in changing....
            
            OmniHomePage * homepage = [[OmniHomePage alloc] init] ;
            [self.navigationController pushViewController:homepage animated:NO];
        }
        else {
            UIAlertView *check = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"Please check \nUserID & Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [check show];
        }
    }
}


// user forget the password ..

- (void) forgetpasswordClicked:(id)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    //    action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Generate OTP",@"Cancel", nil];
    //    action.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    //    [action showInView:self.view];
    
    
    //    [self viewOtpScreen];
    
    headerlabel.text = @"Generate OTP";
    
    loginView.hidden = NO;
    password.hidden = YES;
    forgetPassword.hidden = YES;
    passwordtxt.hidden = YES;
    [ loginbut1 setTitle:@"Generate OTP" forState:UIControlStateNormal];
    
    loginbut1.tag = 10;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
            
            loginbut1.frame = CGRectMake(30, 360, 600, 60);
            loginView.frame = CGRectMake(150, 100, 668, 480);
        }
        else {
            loginbut1.frame = CGRectMake(30, 360, 600, 60);
            loginView.frame = CGRectMake(50, 200, 668, 480);
        }
        
    }
    else {
        loginbut1.frame = CGRectMake(20, 218, 260, 35);
        loginView.frame = CGRectMake(10, 90, 300, 300);
    }
    
}

-(void)willPresentActionSheet:(UIActionSheet *)actionSheet {
    
    if (actionSheet == action) {
        action.layer.backgroundColor = [UIColor blackColor].CGColor;
    }
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex  {
    
    if (buttonIndex == 0) {
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
            // > iOS7
            //
            //            UIAlertView *forgetpasswordalert = [[UIAlertView alloc] initWithTitle:@"Forgot Password" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"cancel",nil];
            //
            //            UIView *forgetPwdAlertViewlayer = [[UIView alloc] initWithFrame:CGRectMake(0,0, 270,90)];
            //            forgetPwdAlertViewlayer.backgroundColor = [UIColor clearColor];
            //            [forgetpasswordalert setValue:forgetPwdAlertViewlayer forKey:@"accessoryView"];
            //
            //            UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(10,-30.0, 260, 90)];
            //            message.text = @"   Please Enter Your Mobile Number";
            //            //message.numberOfLines      = 2;
            //            message.font               = [UIFont fontWithName:@"Arial" size:16];
            //            message.backgroundColor    = [UIColor clearColor];
            //            message.layer.cornerRadius = 8.0f;
            //            message.textColor          = [UIColor blackColor];
            //            [forgetPwdAlertViewlayer addSubview:message];
            //
            //            // Username text box ..
            //            emailIDtxt = [[UITextField alloc] initWithFrame:CGRectMake(20,40,240, 30)];
            //            [emailIDtxt setFont: [UIFont fontWithName:@"Arial" size:20.0]];
            //            emailIDtxt.layer.cornerRadius  = 4.0f;
            //            emailIDtxt.layer.masksToBounds = YES;
            //            emailIDtxt.backgroundColor     = [UIColor whiteColor];
            //            emailIDtxt.keyboardType        = UIKeyboardTypeEmailAddress;
            //
            //            [forgetPwdAlertViewlayer addSubview:emailIDtxt];
            //
            //            [forgetpasswordalert show];
            //            [forgetpasswordalert release];
            loginView.hidden = NO;
            password.hidden = YES;
            forgetPassword.hidden = YES;
            passwordtxt.hidden = YES;
            [ loginbut1 setTitle:@"Generate OTP" forState:UIControlStateNormal];
            loginbut1.tag = 10;
            loginbut1.frame = CGRectMake(30, 360, 600, 60);
            loginView.frame = CGRectMake(50, 200, 668, 480);
            
        }
        else{
            
            UIAlertView *forgetpasswordalert = [[UIAlertView alloc] initWithTitle:@"Forgot Password \n\n\n\n\n\n" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"cancel",nil];
            
            UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 260, 90)];
            message.text = @"   Enter Your Registered Email-ID .";
            message.numberOfLines      = 2;
            message.font               = [UIFont fontWithName:@"Arial" size:16];
            message.backgroundColor    = [UIColor clearColor];
            message.layer.cornerRadius = 8.0f;
            message.textColor          = [UIColor whiteColor];
            [forgetpasswordalert addSubview:message];
            
            // Username text box ..
            emailIDtxt = [[UITextField alloc] initWithFrame:CGRectMake(20,110,240, 30)];
            emailIDtxt.font = [UIFont fontWithName:@"Arial" size:20.0];
            emailIDtxt.layer.cornerRadius  = 4.0f;
            emailIDtxt.layer.masksToBounds = YES;
            emailIDtxt.backgroundColor     = [UIColor whiteColor];
            emailIDtxt.keyboardType        = UIKeyboardTypeEmailAddress;
            
            [forgetpasswordalert addSubview:emailIDtxt];
            
            [forgetpasswordalert show];
        }
    }
    //    else if (buttonIndex == 1){
    //        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
    //            // > iOS7
    //
    //            UIAlertView *forgetpasswordalert = [[UIAlertView alloc] initWithTitle:@"Forgot Password" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"cancel",nil];
    //
    //            UIView *forgetPwdAlertViewlayer = [[UIView alloc] initWithFrame:CGRectMake(0,0, 270,90)];
    //            forgetPwdAlertViewlayer.backgroundColor = [UIColor clearColor];
    //            [forgetpasswordalert setValue:forgetPwdAlertViewlayer forKey:@"accessoryView"];
    //
    //            UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(10,-30.0, 260, 90)];
    //            message.text = @"   Enter Your Registered Email-ID";
    //            //message.numberOfLines      = 2;
    //            message.font               = [UIFont fontWithName:@"Arial" size:16];
    //            message.backgroundColor    = [UIColor clearColor];
    //            message.layer.cornerRadius = 8.0f;
    //            message.textColor          = [UIColor blackColor];
    //            [forgetPwdAlertViewlayer addSubview:message];
    //
    //            // Username text box ..
    //            emailIDtxt = [[UITextField alloc] initWithFrame:CGRectMake(20,40,240, 30)];
    //            [emailIDtxt setFont: [UIFont fontWithName:@"Arial" size:20.0]];
    //            emailIDtxt.layer.cornerRadius  = 4.0f;
    //            emailIDtxt.layer.masksToBounds = YES;
    //            emailIDtxt.backgroundColor     = [UIColor whiteColor];
    //            emailIDtxt.keyboardType        = UIKeyboardTypeEmailAddress;
    //
    //            [forgetPwdAlertViewlayer addSubview:emailIDtxt];
    //
    //            [forgetpasswordalert show];
    //            [forgetpasswordalert release];
    //        }
    //        else{
    //
    //            UIAlertView *forgetpasswordalert = [[UIAlertView alloc] initWithTitle:@"Forgot Password \n\n\n\n\n\n" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"cancel",nil];
    //
    //            UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 260, 90)];
    //            message.text = @"   Enter Your Registered Email-ID .";
    //            message.numberOfLines      = 2;
    //            message.font               = [UIFont fontWithName:@"Arial" size:16];
    //            message.backgroundColor    = [UIColor clearColor];
    //            message.layer.cornerRadius = 8.0f;
    //            message.textColor          = [UIColor whiteColor];
    //            [forgetpasswordalert addSubview:message];
    //
    //            // Username text box ..
    //            emailIDtxt = [[UITextField alloc] initWithFrame:CGRectMake(20,110,240, 30)];
    //            [emailIDtxt setFont: [UIFont fontWithName:@"Arial" size:20.0]];
    //            emailIDtxt.layer.cornerRadius  = 4.0f;
    //            emailIDtxt.layer.masksToBounds = YES;
    //            emailIDtxt.backgroundColor     = [UIColor whiteColor];
    //            emailIDtxt.keyboardType        = UIKeyboardTypeEmailAddress;
    //
    //            [forgetpasswordalert addSubview:emailIDtxt];
    //
    //            [forgetpasswordalert show];
    //            [forgetpasswordalert release];
    //        }
    //    }
    else{
        [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
    }
}
// forget password entered clicked ok button ..

#pragma mark alertview delegates

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    if ([alertView.title isEqualToString:@"Forgot Password \n\n\n\n\n\n" ]) {
        
        if (buttonIndex==0) {
            
            if ([self validateEmail:emailIDtxt.text]) {
                
                HUD.dimBackground = YES;
                HUD.labelText = @"Sending ..";
                
                // Show the HUD
                [HUD show:YES];
                
                // Create the service
                //                SDZLoginService* service = [SDZLoginService service];
                //                service.logging = YES;
                //
                //                // Returns BOOL.
                //                [service forgetPassword:self action:@selector(forgetPasswordHandler:) emailId: emailIDtxt.text];
                //                LoginServiceSoapBinding *service = [[LoginServiceSvc LoginServiceSoapBinding] retain];
                //                LoginServiceSvc_forgetPassword *aparams = [[LoginServiceSvc_forgetPassword alloc] init];
                //                aparams.emailId = emailIDtxt.text;
                
                //                LoginServiceSoapBindingResponse *response = [service forgetPasswordUsingParameters:(LoginServiceSvc_forgetPassword *)aparams];
                
                //NSArray *responseBodyParts = response.bodyParts;
                
                //                for (id bodyPart in responseBodyParts) {
                //                    if ([bodyPart isKindOfClass:[LoginServiceSvc_forgetPasswordResponse class]]) {
                //                        LoginServiceSvc_forgetPasswordResponse *body = (LoginServiceSvc_forgetPasswordResponse *)bodyPart;
                //                        //printf("\nresponse=%s",body.return_);
                //                        [self forgetPasswordHandler:body.return_];
                //                    }
                //                }
                
                
            }
            else {
                UIAlertView *validation_alert = [[UIAlertView alloc] initWithTitle:@"Validation" message:@"Enter Valid \nEmail" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [validation_alert show];
            }
            
        }
        
    }
    else if ([alertView.title isEqualToString:@"Forgot Password"]){
        if (buttonIndex==0) {
            alertView.hidden = YES;
            if ((emailIDtxt.text).length == 10) {
                
                HUD.dimBackground = YES;
                HUD.labelText = @"Sending Message..";
                
                // Show the HUD
                [HUD show:YES];
                
                //
                //                // Create the service
                //                SDZLoginService* service = [SDZLoginService service];
                //                service.logging = YES;
                //
                //                // Returns BOOL.
                //                [service forgetPassword:self action:@selector(forgetPasswordHandler:) emailId: emailIDtxt.text];
                //                UIDevice *myDevice = [UIDevice currentDevice];
                //                NSString *deviceUDID_ = [myDevice uniqueIdentifier];
                //
                //                LoginSoapBinding *loginBindng =  [[LoginServiceSvc LoginSoapBinding] retain];
                //                LoginServiceSvc_generateOTP *aParameters =  [[LoginServiceSvc_generateOTP alloc] init];
                //
                //                aParameters.imei = deviceUDID_;
                //                aParameters.mobileNumber = emailIDtxt.text;
                //
                //                LoginSoapBindingResponse *response = [loginBindng generateOTPUsingParameters:(LoginServiceSvc_generateOTP *)aParameters];
                //                NSArray *responseBodyParts = response.bodyParts;
                //
                //                for (id bodyPart in responseBodyParts) {
                //                    if ([bodyPart isKindOfClass:[LoginServiceSvc_generateOTPResponse class]]) {
                //                        LoginServiceSvc_generateOTPResponse *body = (LoginServiceSvc_generateOTPResponse *)bodyPart;
                //                        //printf("\nresponse=%s",body.generateOTPReturn);
                //
                //                        USBoolean *value = body.generateOTPReturn;
                //                        NSLog(@"%hhd",value.boolValue);
                //
                //                        if (value.boolValue) {
                //                            [HUD setHidden:YES];
                //                            UIAlertView *validation_alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Message Sent Successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                //                            [validation_alert show];
                //                            [validation_alert release];
                //                        }
                //                        else{
                //                            [HUD setHidden:YES];
                //                            UIAlertView *validation_alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Send Failed \n Please check Mobile Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                //                            [validation_alert show];
                //                            [validation_alert release];
                //                        }
                //
                //                    }
                //                }
                
            }
            else {
                
                UIAlertView *validation_alert = [[UIAlertView alloc] initWithTitle:@"Validation" message:@"Enter Valid \n Mobile Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [validation_alert show];
            }
            
        }
    }
    else  if ([alertView.title isEqualToString:@"Expired"]) {
        
        exit(0);
    }
    if ([alertView.message isEqualToString:@"Password reset successfully"]) {
        
        [resetPwdView removeFromSuperview];
        loginbut.enabled = TRUE;
        loginbut.userInteractionEnabled = TRUE;
        [self logging];
        passwordtxt.text = @"";
        
    }
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (alertView==offlineMode) {
        
        if (buttonIndex == 0) {
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            
            if(!(([userIDtxt.text caseInsensitiveCompare:[defaults valueForKey:CUSTOMER_ID]] == NSOrderedSame) && ([emailIDtxt.text caseInsensitiveCompare:[defaults valueForKey:CUSTOMER_EMAIL]] == NSOrderedSame) && ([passwordtxt.text isEqualToString:[defaults valueForKey:PASSWORD]])) || true){
                
                //changed and added by Srinivasulu on 18/09/2018.. reason is multiple login implemented..
                
                NSDictionary *  userInfoDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:userIDtxt.text,emailIDtxt.text,passwordtxt.text, nil] forKeys:[NSArray arrayWithObjects:CUSTOMER_ID,CUSTOMER_EMAIL,PASSWORD,  nil]];
                
                OfflineBillingServices * offlineServiceClass = [[OfflineBillingServices alloc] init];
                
                NSDictionary *  rolesInfoDic  = [offlineServiceClass isWhetherValideUserCredentials:userInfoDic];
                
                if([[rolesInfoDic valueForKey:IS_VALIDE_USER] boolValue]){
                    
                    [defaults setValue:[rolesInfoDic valueForKey:FIRST_NAME] forKey:FIRST_NAME];
                    [defaults setValue:[rolesInfoDic valueForKey:EMPLOYEE_ID] forKey:EMPLOYEE_ID];
                    
                    accessControlActivityArr = [[NSMutableArray alloc] init];
                    accessControlArr = [NSMutableArray new];
                    roleNameLists = [[NSMutableArray alloc] init];
                    for (NSDictionary *rolesDic in [rolesInfoDic valueForKey:ROLES]) {
                        
                        [accessControlArr addObjectsFromArray:[rolesDic valueForKey:kAccessControl]];
                        [accessControlActivityArr addObjectsFromArray:[rolesDic valueForKey:kAccessControlActivity]];
                        [roleNameLists addObject:[rolesDic valueForKey:kRoleName]];
                    }
                }
                else{
                    UIAlertView * invalid = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"login_failed", nil) message:NSLocalizedString(@"please_check_credentials", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil];
                    [invalid show];
                    return;
                }
            }
            
            isOfflineService = YES;
            [HUD setHidden:NO];
            
            
            
            //added by Srinivasulu on 06/10/2017....
            //commented by Srinivasulu on 18/10/20107....
            //reason -- due specifications changes....
            
            //            NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
            //            [dateFormatter setDateFormat:@"dd/MM/yyyy"];
            //
            //            NSLog(@"--%ld",[WebServiceUtility numberOfDaysDifference:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@",[defaults valueForKey:BUSSINESS_DATE]]]]);
            //
            //
            //            if([WebServiceUtility numberOfDaysDifference:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@",[defaults valueForKey:BUSSINESS_DATE]]]] > 1){
            //
            //                [HUD setHidden:YES];
            //                UIAlertView *invalid = [[UIAlertView alloc] initWithTitle:@"Security Issues" message:@"Your are not using this app more then a day. Please, Login in online once." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            //                [invalid show];
            //                return;
            //            }
            
            
            //upto here on 16/10/2017....
            //upto here on 06/10/2017....
            
            
            custID = [userIDtxt.text copy];
            mail_ = [emailIDtxt.text copy];
            
            
            
            defaults = [[NSUserDefaults alloc]init];
            finalLicencesDetails = [defaults valueForKey:@"licence"];
            presentLocation = [[defaults valueForKey:@"location"] copy];
            counterName = [defaults valueForKey:@"counterName"];
            firstName = [defaults valueForKey:@"firstName"];
            cashierId = [defaults objectForKey:EMPLOYEE_ID];
            isProductsMenu = [[defaults valueForKey:kproductsMenu] boolValue];
            isCustomerBillId = [[defaults valueForKey:kCustomerBillId] boolValue];
            isBarcodeType = [[defaults valueForKey:kBarCodeType] boolValue];
            isRoundingRequired = [[defaults valueForKey:kRoundingRequired] boolValue];
            
            //added by Srinivauslu on 20/04/2017 && 22/06/2017 && 26/10/2017 && 03/10/2017  && 19/04/2018 && 18/09/2017 && 06/02/2017 && 15/06/2017 && 19/04/2018....
            
            discTaxation = [[defaults valueForKey:@"discountTaxation"] copy];
            discCalcOn = [[defaults valueForKey:@"discountCalculatedOn"] copy];
            isToCallApplyCampaigns = [[defaults valueForKey:CAMPAIGN_EXISTS] boolValue];
            barcodeTypeStr = [[defaults valueForKey:kBarCodeType] copy];
            
            StoreAddressStr = [[defaults valueForKey:STORE_ADDRESS_STR] copy];
            isManualDiscounts = [[defaults valueForKey:MANUAL_DISCOUNTS] boolValue];
            storeCodeStr = [[defaults valueForKey:STORE_CODE_ID] copy];
            isHybirdMode = [[defaults valueForKey:HYBRID_MODE] boolValue];
            
            isEmployeeSaleId = false;
            
            //reason in offline it should ture....
            zeroStockCheckAtOutletLevel = true;
            isMasterCounter = [[defaults valueForKey:MASTER_COUNTER] boolValue];
            //            zeroStockCheckAtOutletLevel = [[defaults valueForKey:ZERO_STOCK] boolValue];
            
            applyLatestCampaigns = [[defaults valueForKey:LATEST_CAMPAIGNS] boolValue];
            allowItemPriceEdit = [[defaults valueForKey:EDIT_PRICE] boolValue];
            
            businessCategoryStr = [defaults valueForKey:ITEM_CATEGORY];
            
            if ( [[defaults dictionaryRepresentation].allKeys containsObject:PRODUCT_RETURN_REASONS] && ![[defaults valueForKey:PRODUCT_RETURN_REASONS] isKindOfClass:[NSNull class]])
                returnReasonsArr = [[defaults valueForKey:PRODUCT_RETURN_REASONS] mutableCopy];
            if ( [[defaults dictionaryRepresentation].allKeys containsObject:PRODUCT_DISCOUNT_REASONS] && ![[defaults valueForKey:PRODUCT_DISCOUNT_REASONS] isKindOfClass:[NSNull class]])
                discountReasons = [[defaults valueForKey:PRODUCT_DISCOUNT_REASONS] mutableCopy];
            
            //upto here on 20/04/2017 && 22/06/2017 && 26/10/2017 && 03/10/2017  && 19/04/2018 && 18/09/2017 && 06/02/2017 && 15/06/2017 && 19/04/2018....
            
            //commented by Srinivasulu on 25/09/2017....
            //reason it has to work for all customer....
            
            //            if ([custID caseInsensitiveCompare:@"CID8995438"] != NSOrderedSame) {
            //
            //                isCustomerBillId = false;
            //            }
            
            //upto here on 25/09/2017.....
            
            BOOL status = FALSE;
            status =  [self checkDatabaseStatus];
            [HUD setHidden:YES];
            
            if (status && ![finalLicencesDetails isKindOfClass:[NSNull class]] && finalLicencesDetails.count) {
                [self initializePowaPeripherals];
                
                //changed by Srinivasulu on 24/10/2017....
                //reason -- changed from YES to NO -- reason is if animated YES the the custom navigation header in changing....
                
                OmniHomePage *homepage = [[OmniHomePage alloc] init] ;
                [self.navigationController pushViewController:homepage animated:NO];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"You need to first login with the internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            
        }
        else {
            //exit(0);
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        }
    }
    
    else   if (alertView == changeToOfflineModeAlert) {
        
        [self changeOperationMode:buttonIndex];
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
    }
}
// Handle the response from forgetPassword.

- (void) forgetPasswordHandler: (BOOL) value {
    
    [HUD setHidden:YES];
    // Do something with the BOOL result
    
    if (value) {
        UIAlertView *passwordSend = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Your Password will be sent to your \nEmail" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [passwordSend show];
    }
    else {
        UIAlertView *passwordSend = [[UIAlertView alloc] initWithTitle:@"Failed" message:@"Please check your \nConfiguration" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [passwordSend show];
    }
    
}



// Action for the buttons on segmented control ..
- (void) segmentAction: (id) sender  {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    loginbut.enabled = TRUE;
    regbut.enabled   = TRUE;
    
    segmentedControl = (UISegmentedControl *)sender;
    NSInteger index = segmentedControl.selectedSegmentIndex;
    
    segmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment;
    
    if(serviceConfigView1 == nil){
        serviceConfigView1 = [[ServiceConfigView alloc] init];
        serviceConfigView1.hidden = YES;
    }
    
    //    if((!serviceConfigView1.isHidden && serviceConfigView1.frame.origin.x > 0) || (!loginView.isHidden && loginView != nil)  || (!registrationView.isHidden && registrationView != nil))
    //        return;
    
    
    switch (index) {
        case 0:
        {
            if(![self.view.subviews containsObject:serviceConfigView1]  || serviceConfigView1.hidden){
                registrationView.hidden = YES;
                loginView.hidden = YES;
                
                //[registrationView setHidden:YES];
                //[loginView setHidden:YES];
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
                        
                        serviceConfigView1.frame = CGRectMake(180, 150, 660, 500);
                        
                    }
                    else {
                        serviceConfigView1.frame = CGRectMake(60, 165, 660, 500);
                        
                    }
                } else {
                    if (version>=8.0) {
                        
                        serviceConfigView1.frame = CGRectMake(20, 40, 280, 250);
                        
                    }
                    else {
                        serviceConfigView1.frame = CGRectMake(20, 20, 280, 250);
                        
                    }
                }
                
                if (![self.view.subviews containsObject:serviceConfigView1]) {
                    [self.view addSubview:serviceConfigView1];
                    
                    serviceConfigView1.layer.borderWidth = 1.0f;
                    serviceConfigView1.layer.cornerRadius= 10;
                    serviceConfigView1.layer.borderColor = [UIColor blackColor].CGColor;
                    serviceConfigView1.clipsToBounds = YES;
                }
                serviceConfigView1.hidden = NO;
                //[serviceConfigView1 release];
            }
            break;
        }
        case 1:
        {
            registrationView.hidden = YES;
            loginView.hidden = YES;
            serviceConfigView1.hidden = YES;
            
            NSURL *url = [NSURL URLWithString:@"aboutUs.html"];
            WebViewController *webViewController = [[WebViewController alloc] initWithURL:url andTitle:@"aboutUs"];
            //[self.navigationController pushViewController:webViewController animated:YES];
            //            [UIView  transitionWithView:self.navigationController.view duration:0.8  options:UIViewAnimationOptionTransitionFlipFromBottom
            //                             animations:^(void) {
            //                                 BOOL oldState = [UIView areAnimationsEnabled];
            //                                 [UIView setAnimationsEnabled:NO];
            //                                 [self.navigationController pushViewController:webViewController animated:YES];
            //                                 [UIView setAnimationsEnabled:oldState];
            //                             }
            //                             completion:nil];
            
            UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:webViewController];
            nc.navigationBar.tintColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
            [self presentViewController:nc animated:YES completion:nil];
            
            
            break;
        }
        case 2:
        {
            registrationView.hidden = YES;
            loginView.hidden = YES;
            serviceConfigView1.hidden = YES;
            
            NSURL *url = [NSURL URLWithString:@"billing.html"];
            WebViewController *webViewController = [[WebViewController alloc] initWithURL:url andTitle:@"billing"];
            //[self.navigationController pushViewController:webViewController animated:YES];
            //            [UIView  transitionWithView:self.navigationController.view duration:0.8  options:UIViewAnimationOptionTransitionFlipFromBottom
            //                             animations:^(void) {
            //                                 BOOL oldState = [UIView areAnimationsEnabled];
            //                                 [UIView setAnimationsEnabled:NO];
            //                                 [self.navigationController pushViewController:webViewController animated:YES];
            //                                 [UIView setAnimationsEnabled:oldState];
            //                             }
            //                             completion:nil];
            
            UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:webViewController];
            nc.navigationBar.tintColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
            [self presentViewController:nc animated:YES completion:nil];
        }
            
    }
}


//ContrySelectionButtonPressed Handler....
- (IBAction)contrySelectionButtonPressed:(id)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    userIDtxt.enabled = NO;
    passwordtxt.enabled = NO;
    confirmPasswordtxt.enabled = NO;
    emailIDtxt.enabled = NO;
    countrytxt.enabled = NO;
    firstNametxt.enabled = NO;
    lastNametxt.enabled = NO;
    backBut1.enabled = NO;
    //    menubar.enabled = NO;
    registrationbtn.enabled = NO;
    
    countrysTable.hidden = NO;
    [self.view bringSubviewToFront:countrysTable];
    [countrysTable reloadData];
}


#pragma mark Table view methods

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return listOfCountries.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return 50;
    }
    else {
        return 33;
    }
    
}

//Table HeaderImage for Cancel view settting....
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == countrysTable) {
        
        UIView* headerView = [[UIView alloc] init] ;
        headerView.backgroundColor = [UIColor whiteColor];
        
        //UIImageView *headerimg  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.PNG"]];
        
        
        UILabel *label1 = [[UILabel alloc] init] ;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            label1.font = [UIFont boldSystemFontOfSize:20.0];
        }
        else{
            label1.font = [UIFont boldSystemFontOfSize:12.0];
        }
        label1.backgroundColor = [UIColor clearColor];
        label1.text = @"Select Licence Type";
        label1.textColor = [UIColor blackColor];
        
        UIButton *closeBtn = [[UIButton alloc] init] ;
        [closeBtn addTarget:self action:@selector(serchOrderItemTableCancel:) forControlEvents:UIControlEventTouchUpInside];
        UIImage *image = [UIImage imageNamed:@"delete.png"];
        [closeBtn setBackgroundImage:image    forState:UIControlStateNormal];
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            headerView.frame = CGRectMake(0.0, 0.0, 300.0, 58.0);
            label1.frame = CGRectMake(20, 5, 200, 35);
            closeBtn.frame = CGRectMake(250, 5, 30, 30);
        }
        else {
            headerView.frame = CGRectMake(0.0, 0.0, 320.0, 69.0);
            label1.frame = CGRectMake(5, 3, 150, 30);
            closeBtn.frame = CGRectMake(152, 4, 25, 25);
        }
        [headerView addSubview:label1];
        [headerView addSubview:closeBtn];
        return headerView;
    }
    else{
        return [[UIView alloc] init];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return 60;
    }
    else {
        return 33;
    }
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if ((cell.contentView).subviews){
        for (UIView *subview in (cell.contentView).subviews) {
            [subview removeFromSuperview];
        }
    }
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
        cell.frame = CGRectZero;
    }
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        cell.textLabel.font = [UIFont boldSystemFontOfSize:25];
    }
    else {
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    //    if (cell == nil) {
    //        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    //    }
    
    // Set up the cell...
    cell.textLabel.text = listOfCountries[indexPath.row];
    cell.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    return cell;
    
}

// select the row handler....
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    countrytxt.text = listOfCountries[indexPath.row];
    countrysTable.hidden = YES;
    if ([countrytxt.text isEqualToString:@"Evolution"]) {
        lastNametxt.text = @"demofmcg";
    }
    else {
        lastNametxt.text = nil;
    }
    userIDtxt.enabled = YES;
    passwordtxt.enabled = YES;
    confirmPasswordtxt.enabled = YES;
    emailIDtxt.enabled = YES;
    countrytxt.enabled = YES;
    firstNametxt.enabled = YES;
    lastNametxt.enabled = YES;
    
    backBut1.enabled = YES;
    //    menubar.enabled = YES;
    registrationbtn.enabled = YES;
    
    
}
/** table closed ...*/

// Handle serchOrderItemTableCancel Pressed....
-(IBAction) serchOrderItemTableCancel:(id) sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    countrysTable.hidden = YES;
    userIDtxt.enabled = YES;
    passwordtxt.enabled = YES;
    confirmPasswordtxt.enabled = YES;
    emailIDtxt.enabled = YES;
    countrytxt.enabled = YES;
    firstNametxt.enabled = YES;
    lastNametxt.enabled = YES;
    backBut1.enabled = YES;
    //    menubar.enabled = YES;
    registrationbtn.enabled = YES;
    
}

#pragma -mark start of methods exist in UIResponse delegate methods...

/**
 * @description  it will be executed then the user touches the screen....
 * @date
 * @method       touchesBegan:-- withEvent:--
 * @author
 * @param        NSSet
 * @param        UIEvent
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 20/07/2017...
 * @reason      added comments....
 *
 */

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    @try {
        
        
        UITouch *touch=[touches anyObject];
        
        if(touch.view == backgroundImageView)
        {
            CATransition *animation = [CATransition animation];
            animation.delegate = self;
            animation.duration = 3.5f;
            animation.timingFunction = UIViewAnimationCurveEaseInOut;
            animation.type = @"rippleEffect" ;
            [backgroundImageView.layer addAnimation:animation forKey:NULL];
        }
        SystemSoundID    soundFileObject1;
        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"water" withExtension: @"mp3"];
        self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
        AudioServicesPlaySystemSound (soundFileObject1);
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}


#pragma mark OTP methods

-(void)cancelOtp {
    
    headerlabel.text = @"Login";
    loginView.hidden = NO;
    password.hidden = NO;
    forgetPassword.hidden = NO;
    passwordtxt.hidden = NO;
    [ loginbut1 setTitle:@"Login" forState:UIControlStateNormal];
    loginbut1.frame = CGRectMake(30, 420, 600, 60);
    loginView.frame = CGRectMake(50, 200, 668, 550);
    otpView.hidden = YES;
    resetPwdView.hidden = YES;
    loginbut1.enabled = FALSE;
    regbut.enabled   = FALSE;
    segmentedControl.userInteractionEnabled = FALSE;
    
    
}
-(void)cancelView {
    //otpView.hidden = YES;
    resetPwdView.hidden = YES;
    loginView.hidden = YES;
    loginbut1.enabled = FALSE;
    regbut.enabled   = FALSE;
    segmentedControl.userInteractionEnabled = FALSE;
    
}

-(void)viewOtpScreen {
    
    loginView.hidden = YES;
    loginbut1.enabled = FALSE;
    regbut.enabled   = FALSE;
    segmentedControl.userInteractionEnabled = FALSE;
    
    UIImageView *headerimg  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.PNG"]];
    UIImageView *headerlogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"User_Gray.png"]];
    headerlabel = [[UILabel alloc] init];
    headerlabel.text = @"Enter OTP";
    headerlabel.textColor = [UIColor whiteColor];
    headerlabel.backgroundColor = [UIColor clearColor];
    
    otpView = [[UIView alloc] init];
    otpView.layer.borderColor = [UIColor whiteColor].CGColor;
    otpView.layer.borderWidth = 1.0f;
    otpView.layer.cornerRadius = 10;
    otpView.backgroundColor = [UIColor blackColor];
    otpView.clipsToBounds = YES;
    otpView.hidden = NO;
    
    UIButton *backBut = [[UIButton alloc] init];
    [backBut setImage:[UIImage imageNamed:@"go-back-icon.png"] forState:UIControlStateNormal];
    [backBut addTarget:self action:@selector(cancelOtp) forControlEvents:UIControlEventTouchDown];
    
    UILabel *otp  = [[UILabel alloc] init];
    otp.backgroundColor      = [UIColor clearColor];
    otp.text = @"Enter OTP";
    otp.textColor = [UIColor whiteColor];
    
    //    UIButton *backBut = [[UIButton alloc] init];
    //    [backBut setImage:[UIImage imageNamed:@"go-back-icon.png"] forState:UIControlStateNormal];
    //    [backBut addTarget:self action:@selector(gobackView) forControlEvents:UIControlEventTouchDown];
    
    otpTxt = [[UITextField alloc] init];
    
    otpTxt.layer.masksToBounds=YES;
    otpTxt.layer.borderColor=[UIColor grayColor].CGColor;
    otpTxt.layer.borderWidth= 1.0f;
    otpTxt.font = [UIFont fontWithName:@"Arial" size:18.0];
    otpTxt.backgroundColor   = [UIColor whiteColor];
    
    otpTxt.layer.cornerRadius    = 4.0f;
    otpTxt.layer.masksToBounds   = YES;
    
    otpTxt.autocapitalizationType = UITextAutocapitalizationTypeNone;
    otpTxt.autocorrectionType     = UITextAutocorrectionTypeNo;
    otpTxt.secureTextEntry = TRUE;
    otpTxt.delegate = self;
    
    validateOtpbtn = [[UIButton alloc] init];
    [validateOtpbtn setTitle:@"OK" forState:UIControlStateNormal];
    validateOtpbtn.backgroundColor = [UIColor grayColor];
    [validateOtpbtn addTarget:self action:@selector(validateOLP:)forControlEvents:UIControlEventTouchDown];
    validateOtpbtn.layer.borderColor = [UIColor whiteColor].CGColor;
    validateOtpbtn.clipsToBounds = YES;
    validateOtpbtn.tag = 0;
    
    resendOtp = [[UIButton alloc] init];
    [resendOtp setTitle:@"Resend OTP" forState:UIControlStateNormal];
    resendOtp.backgroundColor = [UIColor grayColor];
    [resendOtp addTarget:self action:@selector(validateOLP:)forControlEvents:UIControlEventTouchDown];
    resendOtp.layer.borderColor = [UIColor whiteColor].CGColor;
    resendOtp.clipsToBounds = YES;
    resendOtp.tag = 1;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
            
            otpView.frame = CGRectMake(180, 150, 550, 350);
            
        }
        else {
            otpView.frame = CGRectMake(110, 270, 550, 350);
            
        }
        
        
        headerimg.frame = CGRectMake(0, 0, 550, 80);
        
        headerlogo.frame = CGRectMake(60, 15, 60, 60);
        
        headerlabel.font = [UIFont boldSystemFontOfSize:30];
        headerlabel.frame = CGRectMake(255, 20, 250, 60);
        
        
        backBut.frame = CGRectMake(480, 15, 70, 70);
        
        otp.font = [UIFont systemFontOfSize:30];
        otp.frame = CGRectMake(40, 130, 200, 60);
        
        otpTxt.font = [UIFont systemFontOfSize:30];
        otpTxt.frame = CGRectMake(210, 130, 300, 60);
        
        validateOtpbtn.frame = CGRectMake(30, 260, 230, 50);
        validateOtpbtn.titleLabel.font = [UIFont boldSystemFontOfSize:30.0];
        validateOtpbtn.layer.cornerRadius = 22.0f;
        
        resendOtp.frame = CGRectMake(300, 260, 230, 50);
        resendOtp.titleLabel.font = [UIFont boldSystemFontOfSize:30.0];
        resendOtp.layer.cornerRadius = 22.0f;
        
        
        
    }
    else {
        
    }
    
    [otpView addSubview:headerimg];
    [otpView addSubview:headerlogo];
    [otpView addSubview:headerlabel];
    [otpView addSubview:otp];
    [otpView addSubview:otpTxt];
    [otpView addSubview:validateOtpbtn];
    [otpView addSubview:resendOtp];
    [otpView addSubview:backBut];
    
    [self.view addSubview:otpView];
    
    
    
}

//callOtpServices method Commented  by roja on 17/10/2019.. (changes are done in same method name which is available next to this method)
// At the time of converting SOAP call's to REST

//-(void)callOtpServices {
//
//    isWifiSelectionChanged = FALSE;
//
//
//    CheckWifi *wifi = [[CheckWifi alloc] init];
//    BOOL status = [wifi checkWifi];
//
//
//
//    if (status) {
//
//        [HUD show:YES];
//        HUD.labelText = @"Sending OTP...";
//
//        NSDictionary *reqDic = @{@"requestHeader": [RequestHeader getRequestHeader]};
//
//        NSError * err_;
//        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err_];
//        NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//
//
//        WebServiceController *service = [[WebServiceController alloc] init];
//        service.loginServiceDelegate = self;
//        [service generateLoginOTP:loyaltyString];
//
//
//        LoginServiceSoapBinding *loginSvc = [LoginServiceSvc LoginServiceSoapBinding];
//        loginSvc.logXMLInOut = YES;
//
//        LoginServiceSvc_generateOTP *genOtp = [[LoginServiceSvc_generateOTP alloc]init];
//        genOtp.userDetails = loyaltyString;
//
//        @try {
//
//            LoginServiceSoapBindingResponse *response = [loginSvc generateOTPUsingParameters:genOtp];
//            NSArray *responseBodyParts1_ = response.bodyParts;
//
//            NSDictionary *JSON1;
//            [HUD setHidden:YES];
//
//            if (![response.error isKindOfClass:[NSError class]]) {
//
//
//                for (id bodyPart in responseBodyParts1_) {
//
//                    if ([bodyPart isKindOfClass:[LoginServiceSvc_generateOTPResponse class]]) {
//
//                        LoginServiceSvc_generateOTPResponse *body = (LoginServiceSvc_generateOTPResponse *)bodyPart;
//                        printf("\nresponse=%s",(body.return_).UTF8String);
//
//                        //status = body.return_;
//                        NSError *e;
//                        JSON1 = [[NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//
//                                                                 options: NSJSONReadingMutableContainers
//                                                                   error: &e] copy];
//                        // NSString * booleanString = ([JSON1 valueForKey:@"smsStatus"]) ? @"true" : @"false";
//
//                        if ([JSON1 valueForKey:@"smsStatus"]) {
//                            custID = [userIDtxt.text copy];
//                            mail_ = [emailIDtxt.text copy];
//
//                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"OTP has been sent to your registered mobile number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                            [alert show];
//
//                            [self viewOtpScreen];
//                        }
//
//                        else {
//
//                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Failed to send SMS" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                            [alert show];
//                        }
//
//                    }
//                    else {
//
//                        //  NSError *err = response.error;
//                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Problem occured while processing" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                        [alert show];
//                    }
//                }
//            }
//            else {
//
//                NSError *err = response.error;
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:err.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                [alert show];
//            }
//
//        }
//        @catch (NSException *exception) {
//
//            [HUD setHidden:YES];
//
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Failed to send the OTP" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//
//        }
//    }
//    else {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Please enable wifi/mobile data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    }
//}


//callOtpServices method changed by roja on 17/10/2019.. // reason removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST

-(void)callOtpServices {
    
    isWifiSelectionChanged = FALSE;
    
    CheckWifi *wifi = [[CheckWifi alloc] init];
    BOOL status = [wifi checkWifi];
    
    if (status) {
        
        [HUD show:YES];
        HUD.labelText = @"Sending OTP...";
        
        NSDictionary *reqDic = @{@"requestHeader": [RequestHeader getRequestHeader]};
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err_];
        NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        [HUD setHidden:YES];

        WebServiceController *service = [[WebServiceController alloc] init];
        service.loginServiceDelegate = self;
        [service generateLoginOTP:loyaltyString];
        
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Please enable wifi/mobile data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

 // added by roja on 17/10/2019..
- (void)generateOTPSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        if ([successDictionary valueForKey:@"smsStatus"]) {
            custID = [userIDtxt.text copy];
            mail_ = [emailIDtxt.text copy];
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"OTP has been sent to your registered mobile number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
            [self viewOtpScreen];
        }
        
        else {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Failed to send SMS" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }

    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}

// added by roja on 17/10/2019..
- (void)generateOTPErrorResponse:(NSString *)errorString{
    
    @try {

        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
    
}

// Commented by roja on 17/10/2019.. // reason validateOLP method contains SOAP Service call .. so taken new method with same(validateOLP) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//-(void)validateOLP:(id)sender {
//
//    if (sender == (UIButton *)validateOtpbtn) {
//
//        NSMutableDictionary *reqDic = [[NSMutableDictionary alloc] init];
//        reqDic[@"requestHeader"] = [RequestHeader getRequestHeader];
//        reqDic[@"otpCode"] = otpTxt.text;
//
//        NSError * err_;
//        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err_];
//        NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//
//
//
//
//        LoginServiceSoapBinding *loginSvc = [LoginServiceSvc LoginServiceSoapBinding];
//        // loginSvc.logXMLInOut = YES;
//
//        LoginServiceSvc_validateOTP *genOtp = [[LoginServiceSvc_validateOTP alloc]init];
//        genOtp.otpDetails = loyaltyString;
//
//        @try {
//
//            LoginServiceSoapBindingResponse *response = [loginSvc validateOTPUsingParameters:genOtp];
//            NSArray *responseBodyParts1_ = response.bodyParts;
//
//            NSDictionary *JSON1;
//            if (![response isKindOfClass:[NSError class]]) {
//
//                for (id bodyPart in responseBodyParts1_) {
//
//                    if ([bodyPart isKindOfClass:[LoginServiceSvc_validateOTPResponse class]]) {
//
//                        LoginServiceSvc_validateOTPResponse *body = (LoginServiceSvc_validateOTPResponse *)bodyPart;
//                        printf("\nresponse=%s",(body.return_).UTF8String);
//
//                        //status = body.return_;
//                        NSError *e;
//                        JSON1 = [[NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//
//                                                                 options: NSJSONReadingMutableContainers
//                                                                   error: &e] copy];
//                        // NSString * booleanString = ([JSON1 valueForKey:@"smsStatus"]) ? @"true" : @"false";
//
//                        NSDictionary *responseDic = [JSON1 valueForKey:@"responseHeader"];
//
//                        if ([[responseDic valueForKey:@"responseCode"] isEqualToString:@"0"] && [[responseDic valueForKey:@"responseMessage"] isEqualToString:@"Success"] && [[JSON1 valueForKey:@"status"] boolValue] == TRUE) {  // Change Password View ..
//
//                            if ([(self.view).subviews containsObject:otpView]) {
//
//                                [otpView removeFromSuperview];
//                            }
//
//                            //                        ChangePasswordView  *changePasswordView = [[ChangePasswordView alloc] initWithFrame:CGRectMake(30, 150, 260, 260) status:@"reset"];
//                            //
//                            //                        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//                            //
//                            //                            changePasswordView.frame = CGRectMake(50, 230, 668, 450);
//                            //
//                            //                        } else {
//                            //                            if (version >= 8.0) {
//                            //                                changePasswordView.frame = CGRectMake(30, 150, 260, 260);
//                            //                            }else{
//                            //                                changePasswordView.frame = CGRectMake(30, 40, 260, 260);
//                            //                            }
//                            //                        }
//                            //
//                            //                        [self.view addSubview:changePasswordView];
//                            //
//                            //                        changePasswordView.layer.borderWidth = 3.0f;
//                            //                        changePasswordView.layer.cornerRadius= 15;
//                            //                        changePasswordView.layer.borderColor = [UIColor whiteColor].CGColor;
//                            //                        changePasswordView.clipsToBounds = YES;
//
//                            resetPwdView = [[UIView alloc] init];
//                            resetPwdView.layer.borderColor = [UIColor whiteColor].CGColor;
//                            resetPwdView.layer.borderWidth = 1.0f;
//                            resetPwdView.layer.cornerRadius = 10;
//                            resetPwdView.backgroundColor = [UIColor blackColor];
//                            resetPwdView.clipsToBounds = YES;
//                            resetPwdView.hidden = NO;
//
//                            UIButton *backBut = [[UIButton alloc] init];
//                            [backBut setImage:[UIImage imageNamed:@"go-back-icon.png"] forState:UIControlStateNormal];
//                            [backBut addTarget:self action:@selector(cancelView) forControlEvents:UIControlEventTouchDown];
//
//                            UIImageView *headerimg  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.PNG"]];
//
//                            UILabel *title = [[UILabel alloc] init];
//
//                            title.text = @"Reset Password";
//
//                            title.backgroundColor = [UIColor clearColor];
//                            title.textColor = [UIColor whiteColor];
//
//
//                            UILabel *newpswd   = [[UILabel alloc] init];
//                            UILabel *conpswd   = [[UILabel alloc] init];
//
//                            newpswd.text   = @"New Password";
//                            conpswd.text   = @"Confirm Password";
//
//                            newpswd.textColor = [UIColor whiteColor];
//                            conpswd.textColor = [UIColor whiteColor];
//
//                            newpswd.backgroundColor   = [UIColor clearColor];
//                            conpswd.backgroundColor   = [UIColor clearColor];
//
//                            PswdTxt     = [[UITextField alloc] init];
//                            confPswdTxt    = [[UITextField alloc] init];
//
//                            PswdTxt.layer.masksToBounds=YES;
//                            PswdTxt.layer.borderColor=[UIColor grayColor].CGColor;
//                            PswdTxt.layer.borderWidth= 1.0f;
//                            PswdTxt.secureTextEntry = TRUE;
//
//                            confPswdTxt.layer.masksToBounds=YES;
//                            confPswdTxt.layer.borderColor=[UIColor grayColor].CGColor;
//                            confPswdTxt.layer.borderWidth= 1.0f;
//                            confPswdTxt.secureTextEntry = TRUE;
//
//                            PswdTxt.backgroundColor = [UIColor whiteColor];
//                            confPswdTxt.backgroundColor = [UIColor whiteColor];
//
//                            PswdTxt.layer.cornerRadius = 5;
//                            confPswdTxt.layer.cornerRadius = 5;
//
//                            PswdTxt.delegate = self;
//                            confPswdTxt.delegate = self;
//
//                            UIButton *submitBtn = [[UIButton alloc] init] ;
//                            [submitBtn addTarget:self action:@selector(closeChangePasswordView:) forControlEvents:UIControlEventTouchUpInside];
//                            submitBtn.tag = 0;
//                            [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
//                            submitBtn.backgroundColor = [UIColor grayColor];
//                            submitBtn.layer.cornerRadius = 3.0f;
//
//                            // button to cancel with out saving the changes ..
//                            UIButton *cancelBtn = [[UIButton alloc] init] ;
//                            [cancelBtn addTarget:self action:@selector(closeChangePasswordView:) forControlEvents:UIControlEventTouchUpInside];
//                            cancelBtn.tag = 1;
//                            [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
//                            cancelBtn.backgroundColor = [UIColor grayColor];
//                            cancelBtn.layer.cornerRadius = 3.0f;
//
//                            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)  {
//
//                                resetPwdView.frame = CGRectMake(50, 230, 668, 450);
//                                backBut.frame = CGRectMake(510, 15, 70, 70);
//
//                                title.textColor = [UIColor whiteColor];
//                                title.font = [UIFont boldSystemFontOfSize:30.0f];
//                                headerimg.frame = CGRectMake(0, 0, 668, 80);
//                                title.frame = CGRectMake(230, 15, 400, 50);
//
//                                //            curpswd.font = [UIFont systemFontOfSize:25];
//                                //            curpswd.frame = CGRectMake(40, 140, 250, 50);
//                                newpswd.font = [UIFont systemFontOfSize:25];
//                                newpswd.frame = CGRectMake(40, 140, 250, 50);
//                                conpswd.font = [UIFont systemFontOfSize:25];
//                                conpswd.frame = CGRectMake(40, 240, 250, 50);
//                                //            currentPswdTxt.font = [UIFont systemFontOfSize:25];
//                                //            currentPswdTxt.frame = CGRectMake(270, 140, 330, 60);
//                                PswdTxt.font = [UIFont systemFontOfSize:25];
//                                PswdTxt.frame = CGRectMake(270, 140, 330, 60);
//                                confPswdTxt.font = [UIFont systemFontOfSize:25];
//                                confPswdTxt.frame = CGRectMake(270, 240, 330, 60);
//
//                                submitBtn.frame = CGRectMake(50, 350, 275, 60);
//                                submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
//                                submitBtn.layer.cornerRadius = 25.0f;
//
//                                [cancelBtn setTitle:@"Reset" forState:UIControlStateNormal];
//                                cancelBtn.frame = CGRectMake(335, 350, 275, 60);
//                                cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
//                                cancelBtn.layer.cornerRadius = 25.0f;
//
//                            }
//                            else {
//
//                            }
//
//                            [resetPwdView addSubview:headerimg];
//                            [resetPwdView addSubview:backBut];
//                            [resetPwdView addSubview:title];
//                            [resetPwdView addSubview:newpswd];
//                            [resetPwdView addSubview:conpswd];
//                            [resetPwdView addSubview:PswdTxt];
//                            [resetPwdView addSubview:confPswdTxt];
//                            [resetPwdView addSubview:submitBtn];
//                            [resetPwdView addSubview:cancelBtn];
//                            [self.view addSubview:resetPwdView];
//
//                        }
//
//                        else {
//
//                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Invalid code" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                            [alert show];
//                        }
//
//                    }
//                }
//
//            }
//            else {
//
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:(response.error).localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                [alert show];
//            }
//        }
//        @catch (NSException *exception) {
//
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Invalid Code" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//
//        }
//
//    }
//
//    else {
//
//        [self callOtpServices];
//    }
//
//}


//validateOLP method changed by roja on 17/10/2019.. // reason removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST

-(void)validateOLP:(id)sender {
    
    if (sender == (UIButton *)validateOtpbtn) {
        
        if([otpTxt.text length] == 0){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter the received OTP" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        else {
            
            NSMutableDictionary *reqDic = [[NSMutableDictionary alloc] init];
            reqDic[@"requestHeader"] = [RequestHeader getRequestHeader];
            reqDic[@"otpCode"] = otpTxt.text;
            
            NSError * err_;
            NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err_];
            NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
            
            WebServiceController * services = [[WebServiceController alloc] init];
            services.loginServiceDelegate = self;
            [services validateForLoginOTP:loyaltyString];
        }
    }
    
    else {
        [self callOtpServices];
    }
    
}


// added by roja on 17/10/2019..
- (void)validateOTPSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {  // Change Password View ..
        
        if ([(self.view).subviews containsObject:otpView]) {
            
            [otpView removeFromSuperview];
        }
        
        resetPwdView = [[UIView alloc] init];
        resetPwdView.layer.borderColor = [UIColor whiteColor].CGColor;
        resetPwdView.layer.borderWidth = 1.0f;
        resetPwdView.layer.cornerRadius = 10;
        resetPwdView.backgroundColor = [UIColor blackColor];
        resetPwdView.clipsToBounds = YES;
        resetPwdView.hidden = NO;
        
        UIButton *backBut = [[UIButton alloc] init];
        [backBut setImage:[UIImage imageNamed:@"go-back-icon.png"] forState:UIControlStateNormal];
        [backBut addTarget:self action:@selector(cancelView) forControlEvents:UIControlEventTouchDown];
        
        UIImageView *headerimg  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.PNG"]];
        
        UILabel *title = [[UILabel alloc] init];
        title.text = @"Reset Password";
        title.backgroundColor = [UIColor clearColor];
        title.textColor = [UIColor whiteColor];
        
        UILabel *newpswd   = [[UILabel alloc] init];
        UILabel *conpswd   = [[UILabel alloc] init];
        
        newpswd.text   = @"New Password";
        conpswd.text   = @"Confirm Password";
        
        newpswd.textColor = [UIColor whiteColor];
        conpswd.textColor = [UIColor whiteColor];
        
        newpswd.backgroundColor   = [UIColor clearColor];
        conpswd.backgroundColor   = [UIColor clearColor];
        
        PswdTxt     = [[UITextField alloc] init];
        confPswdTxt    = [[UITextField alloc] init];
        
        PswdTxt.layer.masksToBounds=YES;
        PswdTxt.layer.borderColor=[UIColor grayColor].CGColor;
        PswdTxt.layer.borderWidth= 1.0f;
        PswdTxt.secureTextEntry = TRUE;
        
        confPswdTxt.layer.masksToBounds=YES;
        confPswdTxt.layer.borderColor=[UIColor grayColor].CGColor;
        confPswdTxt.layer.borderWidth= 1.0f;
        confPswdTxt.secureTextEntry = TRUE;
        
        PswdTxt.backgroundColor = [UIColor whiteColor];
        confPswdTxt.backgroundColor = [UIColor whiteColor];
        
        PswdTxt.layer.cornerRadius = 5;
        confPswdTxt.layer.cornerRadius = 5;
        
        PswdTxt.delegate = self;
        confPswdTxt.delegate = self;
        
        UIButton *submitBtn = [[UIButton alloc] init] ;
        [submitBtn addTarget:self action:@selector(closeChangePasswordView:) forControlEvents:UIControlEventTouchUpInside];
        submitBtn.tag = 0;
        [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
        submitBtn.backgroundColor = [UIColor grayColor];
        submitBtn.layer.cornerRadius = 3.0f;
        
        // button to cancel with out saving the changes ..
        UIButton *cancelBtn = [[UIButton alloc] init] ;
        [cancelBtn addTarget:self action:@selector(closeChangePasswordView:) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.tag = 1;
        [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
        cancelBtn.backgroundColor = [UIColor grayColor];
        cancelBtn.layer.cornerRadius = 3.0f;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)  {
            
            resetPwdView.frame = CGRectMake(50, 230, 668, 450);
            backBut.frame = CGRectMake(510, 15, 70, 70);
            
            title.textColor = [UIColor whiteColor];
            title.font = [UIFont boldSystemFontOfSize:30.0f];
            headerimg.frame = CGRectMake(0, 0, 668, 80);
            title.frame = CGRectMake(230, 15, 400, 50);
            
            //            curpswd.font = [UIFont systemFontOfSize:25];
            //            curpswd.frame = CGRectMake(40, 140, 250, 50);
            newpswd.font = [UIFont systemFontOfSize:25];
            newpswd.frame = CGRectMake(40, 140, 250, 50);
            conpswd.font = [UIFont systemFontOfSize:25];
            conpswd.frame = CGRectMake(40, 240, 250, 50);
            //            currentPswdTxt.font = [UIFont systemFontOfSize:25];
            //            currentPswdTxt.frame = CGRectMake(270, 140, 330, 60);
            PswdTxt.font = [UIFont systemFontOfSize:25];
            PswdTxt.frame = CGRectMake(270, 140, 330, 60);
            confPswdTxt.font = [UIFont systemFontOfSize:25];
            confPswdTxt.frame = CGRectMake(270, 240, 330, 60);
            
            submitBtn.frame = CGRectMake(50, 350, 275, 60);
            submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            submitBtn.layer.cornerRadius = 25.0f;
            
            [cancelBtn setTitle:@"Reset" forState:UIControlStateNormal];
            cancelBtn.frame = CGRectMake(335, 350, 275, 60);
            cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            cancelBtn.layer.cornerRadius = 25.0f;
            
        }
        else {
            
        }
        
        [resetPwdView addSubview:headerimg];
        [resetPwdView addSubview:backBut];
        [resetPwdView addSubview:title];
        [resetPwdView addSubview:newpswd];
        [resetPwdView addSubview:conpswd];
        [resetPwdView addSubview:PswdTxt];
        [resetPwdView addSubview:confPswdTxt];
        [resetPwdView addSubview:submitBtn];
        [resetPwdView addSubview:cancelBtn];
        [self.view addSubview:resetPwdView];
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}

// added by roja on 17/10/2019..
- (void)validateOTPErrorResponse:(NSString *)errorString{
    
    @try {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}


-(BOOL)checkDatabaseStatus{
    
    int count = 0;
    BOOL success = FALSE;
    
    @try {
        
        NSString* dbPath = [DataBaseConnection connection:@"RetailerBillingDataBase.sqlite"];
        
        if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
            NSString *query;
            
            query = [NSString stringWithFormat:@"select count (*) from sku_master"];
            const char *sqlStatement = query.UTF8String;
            
            
            if(sqlite3_prepare_v2(database, sqlStatement, -1, &selectStmt, NULL) == SQLITE_OK) {
                //                        int count = sqlite3_column_count(selectStmt);
                while (sqlite3_step(selectStmt) == SQLITE_ROW) {
                    
                    count = sqlite3_column_int(selectStmt, 0);
                    
                    
                    
                }
                sqlite3_finalize(selectStmt);
                selectStmt = nil;
                
            }
            else {
                NSLog(@"%s",sqlite3_errmsg(database)) ;
            }
        }
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
        
        //        UIAlertView *alert=  [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Problem occured while processing" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //        [alert show];
        //        [alert release];
        
    }
    @finally {
        sqlite3_close(database);
        
    }
    if (count>0) {
        success = TRUE;
    }
    else {
        success = FALSE;
    }
    return success;
    
}

// Commented by roja on 17/10/2019.. // reason closeChangePasswordView method contains SOAP Service call .. so taken new method with same(closeChangePasswordView) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//- (void) closeChangePasswordView:(id) sender {
//
//    if ([sender tag] == 0) {
//
//        NSString *value2 = [PswdTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//        NSString *value3 = [confPswdTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//
//        if (value2.length==0 || value3.length==0){
//
//            UIAlertView *ip = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please Provide Details in All Fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] ;
//            [ip show];
//        }
//        else if (value2.length < 8 && value3.length < 8){
//
//            UIAlertView *ip = [[UIAlertView alloc] initWithTitle:@"Password Too short" message:@"Min. password length is 8 characters" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] ;
//            [ip show];
//        }
//        else if (![value2 isEqualToString:value3]){
//
//            UIAlertView *ip = [[UIAlertView alloc] initWithTitle:@"Password Mis-Match" message:@"New & Confirm Password must be same" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] ;
//            [ip show];
//        }
//
//        else {
//
//            NSMutableDictionary *reqDic = [[NSMutableDictionary alloc] init];
//            reqDic[@"requestHeader"] = [RequestHeader getRequestHeader];
//            reqDic[@"emailId"] = mail_;
//            reqDic[@"password"] = PswdTxt.text;
//
//            NSError * err_;
//            NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err_];
//            NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//
//            LoginServiceSoapBinding *login = [LoginServiceSvc LoginServiceSoapBinding] ;
//            login.logXMLInOut = YES;
//            LoginServiceSvc_resetPassword *reset = [[LoginServiceSvc_resetPassword alloc]init];
//            reset.passwordDetails = loyaltyString;
//
//            @try {
//
//                [confirmPasswordtxt resignFirstResponder];
//                [PswdTxt resignFirstResponder];
//
//                LoginServiceSoapBindingResponse *response = [login resetPasswordUsingParameters:reset];
//
//                NSArray *responseBodyparts = response.bodyParts;
//
//                for (id bodyPart in responseBodyparts) {
//                    if ([bodyPart isKindOfClass:[LoginServiceSvc_resetPasswordResponse class]]) {
//                        LoginServiceSvc_resetPasswordResponse *body = (LoginServiceSvc_resetPasswordResponse *)bodyPart;
//                        NSLog(@"\nresponse=%@",body.return_);
//
//                        NSError *e;
//                        NSDictionary   *JSON1 = [[NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//
//                                                                                 options: NSJSONReadingMutableContainers
//                                                                                   error: &e] copy];
//                        NSDictionary *responseDic = [JSON1 valueForKey:@"responseHeader"];
//
//                        if ([[responseDic valueForKey:@"responseCode"] isEqualToString:@"0"] && [[responseDic valueForKey:@"responseMessage"] isEqualToString:@"Your Password is changed"] && [[JSON1 valueForKey:@"status"] boolValue] == TRUE) {
//
//                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Password reset successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                            [alert show];
//                        }
//                        else {
//
//                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Failed to reset the password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                            [alert show];
//
//                        }
//
//                    }
//                }
//            }
//            @catch (NSException *exception) {
//
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Failed to reset the password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                [alert show];
//
//            }
//
//        }
//
//
//    }
//
//    else {
//
//        PswdTxt.text = @"";
//        confPswdTxt.text = @"";
//    }
//}

//closeChangePasswordView method changed by roja on 17/10/2019.. // reason removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST
- (void) closeChangePasswordView:(id) sender {
    
    if ([sender tag] == 0) {
        
        NSString *value2 = [PswdTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString *value3 = [confPswdTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        if (value2.length==0 || value3.length==0){
            
            UIAlertView *ip = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please Provide Details in All Fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] ;
            [ip show];
        }
        else if (value2.length < 8 && value3.length < 8){
            
            UIAlertView *ip = [[UIAlertView alloc] initWithTitle:@"Password Too short" message:@"Min. password length is 8 characters" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] ;
            [ip show];
        }
        else if (![value2 isEqualToString:value3]){
            
            UIAlertView *ip = [[UIAlertView alloc] initWithTitle:@"Password Mis-Match" message:@"New & Confirm Password must be same" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] ;
            [ip show];
        }
        
        else {
            
            NSMutableDictionary *reqDic = [[NSMutableDictionary alloc] init];
            reqDic[@"requestHeader"] = [RequestHeader getRequestHeader];
            reqDic[@"emailId"] = mail_;
            reqDic[@"password"] = PswdTxt.text;
            
            NSError * err_;
            NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err_];
            NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
            
            [confirmPasswordtxt resignFirstResponder];
            [PswdTxt resignFirstResponder];

            WebServiceController * services  = [[WebServiceController alloc] init];
            services.loginServiceDelegate = self;
            [services resetPassword:loyaltyString];
        }
    }
    
    else {
        
        PswdTxt.text = @"";
        confPswdTxt.text = @"";
    }
}

// added by roja on 17/10/2019..
- (void)resetPasswordSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Password changed successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}

// added by roja on 17/10/2019..
- (void)resetPasswordErrorResponse:(NSString *)errorString{
    
    @try {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Failed to reset the password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}




//commented by Srinivasulu on 25/07/2017....
//-(NSUInteger)supportedInterfaceOrientations {
//
////    return UIInterfaceOrientationLandscapeLeft|UIInterfaceOrientationLandscapeRight|UIInterfaceOrientationPortrait;
//    return UIInterfaceOrientationLandscapeLeft|UIInterfaceOrientationLandscapeRight;
//
//    //|UIInterfaceOrientationPortrait;
//
//}

//upto here on 25/05/2017.....

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
    
}

-(void)setFontFamily:(NSString*)fontFamily forView:(UIView*)view andSubViews:(BOOL)isSubViews
{
    if ([view isKindOfClass:[UILabel class]])
    {
        UILabel *lbl = (UILabel *)view;
        lbl.font = [UIFont fontWithName:fontFamily size:lbl.font.pointSize];
    }
    
    if (isSubViews)
    {
        for (UIView *sview in view.subviews)
        {
            [self setFontFamily:fontFamily forView:sview andSubViews:YES];
        }
    }
}

#pragma mark powa initialization

-(void)initializePowaPeripherals{
    
    //check the bluetooth connection....
    @try {
        if (![btManager powered]) {
            
            [btManager setPowered:YES];
            [btManager setEnabled:YES];
        }
        
        btDevItems = btManager.pairedDevices;
        if ([btDevItems.description rangeOfString:@"PowaPOS"].location == NSNotFound) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"scanner_status_message", nil) message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else {
            
            for (BluetoothDevice *btDev in btDevItems) {
                if ([btDev.description rangeOfString:@"PowaPOS"].location != NSNotFound) {
                    if(![btDev connected]) {
                        [btDev connect];
                    }
                    break;
                }
            }
            
            
        }
        
        
        //        //adding the notifications for powa device connection.....
        //
        //        [[NSNotificationCenter defaultCenter] addObserver:self
        //                                                 selector:@selector(accessoryDidConnect:)
        //                                                     name:EAAccessoryDidConnectNotification
        //                                                   object:nil];
        //
        //        [[EAAccessoryManager sharedAccessoryManager] registerForLocalNotifications];
        //
        
        
        // Initialize the PowaPOS SDK
        powaPOS = [[PowaPOS alloc] init];
        
        if (printer == nil) {
            
            NSArray *connectedTSeries = [PowaTSeries connectedDevices];
            
            if(connectedTSeries.count)
            {
                printer = connectedTSeries[0];
                cashDrawer = connectedTSeries[0];
                [powaPOS addPeripheral:printer];
                [powaPOS addPeripheral:cashDrawer];
            }
        }
        
        
        if (scanner == nil) {
            // Get the connected scanners
            
            NSArray *connectedScanners = [PowaS10Scanner connectedDevices];
            
            // Select the first S10 scanner device available
            if(connectedScanners.count)
            {
                scanner = connectedScanners[0];
                
                [powaPOS addPeripheral:scanner];
            }
        }
    }
    @catch (NSException *exception) {
        
        NSLog(@"exception %@",exception);
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Failed to connect the device" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
    
}
/* Bluetooth notifications */
- (void)bluetoothAvailabilityChanged:(NSNotification *)notification {
    
    NSLog(@"NOTIFICATION:bluetoothAvailabilityChanged called. BT State: %d", [btManager enabled]);
}

- (void)deviceDiscovered:(NSNotification *) notification {
    
    BluetoothDevice *bt = notification.object;
    
    //create a new list item
    BTListDevItem *item = [[BTListDevItem alloc] initWithName:bt.name description:bt.address type:0 btdev:bt];
    
    //add it to list
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:btDevItems];
    [tempArray addObject:(item)];
    btDevItems = tempArray;
    
    for (BluetoothDevice *btDev in btDevItems) {
        if ([btDev.description rangeOfString:@"PowaPOS"].location != NSNotFound) {
            
            if(![btDev connected]) {
                [btDev connect];
            }
            break;
        }
    }
}

/* Bluetooth connectivity */
- (void)deviceConnect:(NSInteger)index {
    
    BTListDevItem *item = (BTListDevItem *)btDevItems[index];
    NSLog(@"deviceConnect to %@", item.name);
    [item.btdev connect];
}
- (void)accessoryDidConnect:(NSNotification *)notification
{
    if(!printer)
    {
        // Get the connected TSeries devices
        NSArray *connectedTSeries = [PowaTSeries connectedDevices];
        
        // Select the first TSeries device available
        if(connectedTSeries.count)
        {
            printer = connectedTSeries[0];
            [powaPOS addPeripheral:printer];
        }
    }
    
    if(!scanner)
    {
        // Get the connected scanners
        NSArray *connectedScanners = [PowaS10Scanner connectedDevices];
        
        // Select the first S10 scanner device available
        if(connectedScanners.count)
        {
            scanner = connectedScanners[0];
            [powaPOS addPeripheral:scanner];
        }
    }
}

- (void)tseries:(PowaTSeries *)tseries deviceConnectedAtPort:(NSUInteger)port;
{
    NSString *string = [NSString stringWithFormat:@"Connected device in port: %i", (int)port];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Device Connected"
                                                        message:string
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)tseries:(PowaTSeries *)tseries deviceDisconnectedAtPort:(NSUInteger)port
{
    NSString *string = [NSString stringWithFormat:@"Disconnected device in port: %i", (int)port];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Device Disconnected"
                                                        message:string
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)tseriesDidFinishInitializing:(PowaTSeries *)tseries
{
    NSString *string = [NSString stringWithFormat:@"Initialized"];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Init"
                                                        message:string
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)peripheral:(id <PowaPeripheral>)peripheral connectionStateChanged:(PowaPeripheralConnectionState)connectionState
{
    NSString *string = nil;
    
    
    if(connectionState == PowaPeripheralConnectionStateConnected)
    {
        string = @"Device Connected";
    }
    else
    {
        string = @"Device Disconnected";
    }
    
    //    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Connection Change"
    //                                                        message:string
    //                                                       delegate:self
    //                                              cancelButtonTitle:@"Cancel"
    //                                              otherButtonTitles:nil, nil];
    //    [alertView show];
}

#pragma  -mark end of POWA delegate methods....

#pragma -mark which are used when device was rotated && this methods may not be in use they need to be removed....

/**
 * @description  I hope this mehod are not in used the need to be removed....
 * @date
 * @method       deviceOrientationDidChange:
 * @author
 * @param        NSNotification
 * @param
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 20/07/2017...
 * @reason      added comments....
 *
 */

- (void)deviceOrientationDidChange:(NSNotification *)notification {
    //Obtaining the current device orientation
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    
    //Ignoring specific orientations
    if (orientation == UIDeviceOrientationFaceUp || orientation == UIDeviceOrientationFaceDown || orientation == UIDeviceOrientationUnknown) {
        return;
    }
    
    if ((UIDeviceOrientationIsPortrait(orientation) ||UIDeviceOrientationIsPortrait(orientation)) ||
        (UIDeviceOrientationIsLandscape(orientation) || UIDeviceOrientationIsLandscape(orientation))) {
        //still saving the current orientation
        currentOrientation = orientation;
    }
    
    //added by Srinivasulu on 26/03/2018....
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && !(currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight))
        currentOrientation = UIDeviceOrientationLandscapeRight;
    
    
    //upto here on 26/03/2018....
    
    [self performSelector:@selector(orientationChangedMethod) withObject:nil afterDelay:0];
}

/**
 * @description  I hope this mehod are not in used the need to be removed....
 * @date
 * @method       orientationChangedMethod:
 * @author
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 20/07/2017...
 * @reason      added comments....
 *
 */

-(void)orientationChangedMethod {
    
    
    if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            backgroundImageView.image = [UIImage imageNamed:@"SplashScreen.png"];
            backgroundImageView.frame = CGRectMake(0.0, 0.0,self.view.frame.size.width,self.view.frame.size.height-40);
            
            loginbut.frame = CGRectMake(183,480,350,60);
            
            lab1.frame = CGRectMake(320,480,150,60);
            imageview1.image = [UIImage imageNamed:@"LoginIcon@2x.png"];
            imageview2.image = [UIImage imageNamed:@"Registration@2x.png"];
            
            imageview1.frame = CGRectMake(200, 480, 60, 60);
            imageview2.frame = CGRectMake(550, 480, 60, 60);
            
            //            imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(80, 480, 60, 60)];
            //            imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(430, 480, 60, 60)];
            
            
            
            regbut.frame = CGRectMake(535,480,350,60);
            
            
            
            lab2.frame = CGRectMake(670,480,150,60);
            
            segmentedControl.frame = CGRectMake(-6,720,self.view.frame.size.width+20,60);
            
            loginView.frame = CGRectMake(180, 150, 668, 550);
            otpView.frame = CGRectMake(180, 150, 550, 350);
            
            serviceConfigView1.frame = CGRectMake(180, 150, 660, 500);
            
            
            
            //segmentedControl.tintColor=[UIColor colorWithRed:125.0/255.0 green:125.0/255.0 blue:125.0/255.0 alpha:1.0];
            
        }
    }
    else {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            backgroundImageView.image = [UIImage imageNamed:@"Background.png"];
            backgroundImageView.frame = CGRectMake(0.0, 0.0,776,1024);
            
            // backgroundImageView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width+30, self.view.frame.size.height+40);
            
            
            loginbut.frame = CGRectMake(33,780,350,60);
            //[loginbut setTitle:@"Login" forState:(UIControlStateNormal)];
            [loginbut setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            [loginbut addTarget:self action:@selector(ButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *shapePath = [UIBezierPath bezierPathWithRoundedRect:loginbut.bounds
                                                            byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft
                                                                  cornerRadii:CGSizeMake(25.0, 25.0)];
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            shapeLayer.frame = loginbut.bounds;
            shapeLayer.path = shapePath.CGPath;
            shapeLayer.fillColor = [UIColor whiteColor].CGColor;
            [loginbut.layer addSublayer:shapeLayer];
            //  [self.view addSubview:loginbut];
            
            //  lab1 = [[UILabel alloc] init];
            lab1.frame = CGRectMake(170,780,150,60);
            lab1.text = @"Login";
            lab1.font = [UIFont systemFontOfSize:25];
            //   [self.view addSubview:lab1];
            
            //  imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 780, 60, 60)];
            imageview1.frame = CGRectMake(50, 780, 60, 60);
            
            UIImage *img1 = [UIImage imageNamed:@"LoginIcon@2x.png"];
            imageview1.image = img1;
            //  [self.view addSubview:imageview1];
            
            
            
            regbut.frame = CGRectMake(385,780,350,60);
            //[regbut setTitle:@"Register" forState:(UIControlStateNormal)];
            [regbut setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            [regbut addTarget:self action:@selector(ButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            UIBezierPath *shapePath1 = [UIBezierPath bezierPathWithRoundedRect:regbut.bounds
                                                             byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight
                                                                   cornerRadii:CGSizeMake(25.0, 25.0)];
            
            CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
            shapeLayer1.frame = regbut.bounds;
            shapeLayer1.path = shapePath1.CGPath;
            shapeLayer1.fillColor = [UIColor whiteColor].CGColor;
            [regbut.layer addSublayer:shapeLayer1];
            //   [self.view addSubview:regbut];
            
            
            // lab2 = [[UILabel alloc] init];
            lab2.frame = CGRectMake(520,780,150,60);
            lab2.text = @"Register";
            lab2.font = [UIFont systemFontOfSize:25];
            //  [self.view addSubview:lab2];
            
            
            //  imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(400, 780, 60, 60)];
            imageview2.frame = CGRectMake(400, 780, 60, 60);
            UIImage *img2 = [UIImage imageNamed:@"Registration@2x.png"];
            imageview2.image = img2;
            //  [self.view addSubview:imageview2];
            
            segmentedControl.frame = CGRectMake(-6,965,780,60);
            //segmentedControl.tintColor=[UIColor colorWithRed:125.0/255.0 green:125.0/255.0 blue:125.0/255.0 alpha:1.0];
            
            loginView.frame = CGRectMake(50, 200, 668, 550);
            otpView.frame = CGRectMake(110, 270, 550, 350);
            
            serviceConfigView1.frame = CGRectMake(60, 165, 660, 500);
            
            
        }
    }
    
}

// change the cursor to next text box ..
#pragma -mark Start of TextFieldDelegates.......

// Login location changed to top when the user clicked the textfield on the alertview ..

/**
 * @description  it is an textFieldDelegate method it will be executed when text  Begin edititng........
 * @date
 * @method       textfieldTouched:
 * @author
 * @param        id
 * @param
 * @param
 * @return
 *
 * @modified By  Srinivasulu on 10/08/2017....
 * @reason       added the comment's  && this was not in used && myself commented the code existing in this page....
 *
 * @verified By
 * @verified On
 *
 */

- (void) textfieldTouched:(id)sender {
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
            
            loginView.frame = CGRectMake(180, -20, 668, 550);
            otpView.frame = CGRectMake(180, 80, 550, 350);
            
            
        }
        else {
            loginView.frame = CGRectMake(50, 200, 668, 550);
            otpView.frame = CGRectMake(110, 270, 550, 350);
            
            
        }
    }
    else {
        loginView.frame = CGRectMake(10, 10, 300, 260);
    }
    
}


/**
 * @description  it is an textFieldDelegate method it will be executed when text  Begin edititng........
 * @date
 * @method       textFieldShouldBeginEditing:
 * @author
 * @param        UITextField
 * @param
 * @param
 * @return
 *
 * @modified By  Srinivasulu on 10/08/2017....
 * @reason       added the comment's....
 *
 * @verified By
 * @verified On
 *
 */

- (BOOL)textFieldShouldBeginEditing:(UITextField *)theTextField {
    
    //    if(theTextField == userIDtxt) {
    //        //[passwordtxt becomeFirstResponder];
    //        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    //            registrationView.frame = CGRectMake(50, 50, 668, 900);
    //        }
    //        else {
    //            registrationView.frame = CGRectMake(10, 20, 300, 420);
    //        }
    //    }
    //    else if(theTextField == passwordtxt && confirmPasswordtxt) {
    //        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    //            registrationView.frame = CGRectMake(50, 50, 668, 900);
    //        }
    //        else {
    //            registrationView.frame = CGRectMake(10, 20, 300, 420);
    //        }
    //    }
    //    else if(theTextField == confirmPasswordtxt) {
    //        //[emailIDtxt becomeFirstResponder];
    //        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    //            registrationView.frame = CGRectMake(50, -50, 668, 900);
    //        }
    //        else {
    //            registrationView.frame = CGRectMake(10, -20, 300, 420);
    //        }
    //    }
    //    else if(theTextField == emailIDtxt) {
    //        //[firstNametxt becomeFirstResponder];
    //        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    //            registrationView.frame = CGRectMake(50, -150, 668, 900);
    //        }
    //        else {
    //            registrationView.frame = CGRectMake(10, -120, 300, 420);
    //        }
    //    }
    //    else if(theTextField == deviceIDtxt) {
    //        //[firstNametxt becomeFirstResponder];
    //        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    //            registrationView.frame = CGRectMake(50, -150, 668, 900);
    //        }
    //        else {
    //            registrationView.frame = CGRectMake(10, -120, 300, 420);
    //        }
    //    }
    //    else if(theTextField == countrytxt) {
    //        //[lastNametxt becomeFirstResponder];
    //        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    //            registrationView.frame = CGRectMake(50, -280, 668, 900);
    //        }
    //        else {
    //            registrationView.frame = CGRectMake(10, -160, 300, 420);
    //        }
    //    }
    //    if(theTextField == firstNametxt) {
    //        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    //            registrationView.frame = CGRectMake(200, -20, 668, 700);
    //        }
    //        else {
    //            registrationView.frame = CGRectMake(10, 20, 300, 460);
    //        }
    //    }
    
    
    //    else if(theTextField == lastNametxt) {
    //        //[deviceIDtxt becomeFirstResponder];
    //        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    //            registrationView.frame = CGRectMake(50, -280, 668, 900);
    //        }
    //        else {
    //            registrationView.frame = CGRectMake(10, -120, 300, 420);
    //        }
    //    }
    //
    //
    //
    //    else {
    //
    //        //[self keyboardHide];
    //
    //        //loginView.frame        = CGRectMake(10, 100, 300, 260);
    //        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    //            registrationView.frame = CGRectMake(50, 50, 668, 900);
    //        }
    //        else {
    //            registrationView.frame = CGRectMake(10, 20, 300, 420);
    //        }
    //
    //    }
    
    //userIDtxt -- passwordtxt -- emailIDtxt
    
    return YES;
}

/**
 * @description  it is an textFieldDelegate method it will be executed when text Begin edititng........
 * @date         10/08/2017
 * @method       textFieldDidBeginEditing:
 * @author       Srinivasulu
 * @param        UITextField
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    @try{
        
        //userIDtxt -- passwordtxt -- confirmPasswordtxt -- emailIDtxt -- deviceIDtxt -- countrytxt -- firstNametxt -- lastNametxt -- businessInfo
        
        if ( textField.frame.origin.x == userIDtxt.frame.origin.x || textField.frame.origin.x == passwordtxt.frame.origin.x || textField.frame.origin.x == emailIDtxt.frame.origin.x || textField.frame.origin.x == confirmPasswordtxt.frame.origin.x || textField.frame.origin.x == deviceIDtxt.frame.origin.x || textField.frame.origin.x == countrytxt.frame.origin.x || textField.frame.origin.x == firstNametxt.frame.origin.x || textField.frame.origin.x == lastNametxt.frame.origin.x || textField.frame.origin.x == businessInfo.frame.origin.x){
            //        if ( textField.frame.origin.x == passwordtxt.frame.origin.x || textField.frame.origin.x == emailIDtxt.frame.origin.x){
            
            [textField selectAll:nil];
            if(!loginView.isHidden)
                offSetViewTo = textField.frame.origin.y + 2 * textField.frame.size.height - loginView.frame.origin.y  ;
            else
                offSetViewTo = textField.frame.origin.y - registrationView.frame.origin.x;
            
            
            if(offSetViewTo < 0)
                offSetViewTo = -offSetViewTo;
            
            [self keyboardWillShow];
            
        }
        
    }@catch (NSException *exception) {
        
    }
    
}

/**
 * @description  it is an textFieldDelegate method it will be executed for ever character change........
 * @date
 * @method       textField:  shouldChangeCharactersInRange:  replacementString:
 * @author
 * @param        UITextField
 * @param        NSRange
 * @param        NSString
 * @return       BOOL
 *
 * @modified By  Srinivasulu on 10/08/2017....
 * @reason       added the comment's....
 *
 * @verified By
 * @verified On
 *
 */

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == otpTxt) {
        
        // Check for non-numeric characters
        NSUInteger lengthOfString = string.length;
        for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {
            unichar character = [string characterAtIndex:loopIndex];
            if (character < 48) return NO; // 48 unichar for 0
            if (character > 57) return NO; // 57 unichar for 9
        }
        // Check for total length
        NSUInteger proposedNewLength = textField.text.length - range.length + string.length;
        if (proposedNewLength > 5) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Enter valid code" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return NO;
            
        }
    }
    
    
    else if(textField == deviceIDtxt){
        
        return NO;
        
    }
    
    
    return YES;
}

/**
 * @description  it is an textFieldDelegate method it will be executed for ever character change........
 * @date         10/08/2017
 * @method       textFieldDidChange:
 * @author       Srinivasulu
 * @param        UITextField
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)textFieldDidChange:(UITextField *)textField {
    
    
}

/**
 * @description  It is tableFieldDelegates Method. It will executed when textFieldEndEditing....
 * @date
 * @method       textFieldDidEndEditing:
 * @author
 * @param        UITextField
 * @param
 * @return
 * @verified By
 * @verified On
 *
 * @modified By  Srinivasulu on 10/08/2017....
 * @reason       added the comment's....
 *
 *
 */

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    //    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    //        registrationView.frame = CGRectMake(50, 50, 668, 900);
    //    }
    //    else {
    //        registrationView.frame = CGRectMake(10, 20, 300, 420);
    //    }
    
    //    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    //        if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
    //
    //            loginView.frame = CGRectMake(180, 80, 668, 550);
    //            otpView.frame = CGRectMake(180, 80, 550, 350);
    //
    //        }
    //        else {
    //            loginView.frame = CGRectMake(50, 200, 668, 550);
    //            otpView.frame = CGRectMake(110, 270, 550, 350);
    //
    //
    //        }
    //    }
    //    else {
    //        loginView.frame = CGRectMake(10, 10, 300, 260);
    //    }
    
    return YES;
}

/**
 * @description  It is tableFieldDelegates Method. It will executed when textFieldEndEditing....
 * @date         10/08/2017....
 * @method       textFieldDidEndEditing:
 * @author       Srinivasulu
 * @param        UITextField
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    @try {
        [self keyboardWillHide];
        offSetViewTo = 0;
    } @catch (NSException *exception) {
        
        NSLog(@"----exception while moving the frame----%@",exception);
    }
    
}
/**
 * @description  It is tableFieldDelegates Method. It will executed when user resin this response....
 * @date
 * @method       textFieldShouldReturn:
 * @author
 * @param        UITextField
 * @param
 * @return       BOOL
 *
 * @modified By  Srinivasulu on 10/08/2017....
 * @reason       added the comment's....
 *
 * @verified By
 * @verified On
 *
 */

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    //    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    //        registrationView.frame = CGRectMake(200, 10, 668, 700);
    //    }
    //    else {
    //        registrationView.frame = CGRectMake(10, 20, 300, 460);
    //    }
    return YES;
}

#pragma -mark start of UITextViewDelegate methods.....


/**
 * @description  it is an textFieldDelegate method it will be executed when text Begin edititng........
 * @date
 * @method       textViewDidBeginEditing:
 * @author
 * @param        UITextView
 * @param
 * @param
 * @return
 *
 * @modified By  Srinivasulu on 10/08/2017....
 * @reason       added the comment's....
 *
 * @verified By
 * @verified On
 *
 */

-(void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"Please Describe About Your Business"]) {
        textView.text = nil;
    }
    textView.textColor = [UIColor blackColor];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        registrationView.frame = CGRectMake(200, -200, 668, 700);
    }
    else {
        registrationView.frame = CGRectMake(10, -160, 300, 420);
    }
    
}

/**
 * @description  it is an textFieldDelegate method it will be executed when text Begin edititng........
 * @date
 * @method       textView:-- shouldChangeTextInRange:-- replacementText:--
 * @author
 * @param        UITextView
 * @param        NSRange
 * @param        NSString
 *
 * @return       BOOL
 *
 * @modified By  Srinivasulu on 10/08/2017....
 * @reason       added the comment's....
 *
 * @verified By
 * @verified On
 *
 */

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView == businessInfo) {
        if ([text isEqualToString:@"\n"]) {
            if (text.length == 0) {
                businessInfo.text = @"Please Describe About Your Business";
                businessInfo.textColor = [UIColor lightGrayColor];
            }
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                registrationView.frame = CGRectMake(200, -100, 668, 700);
            }
            else {
                registrationView.frame = CGRectMake(10, -160, 300, 420);
            }
            [textView resignFirstResponder];
            return NO;
        }
    }
    return YES;
}

/**
 * @description  it is an textFieldDelegate method it will be executed when text Begin edititng........
 * @date
 * @method       textViewDidEndEditing:
 * @author
 * @param        UITextView
 * @param
 * @param
 *
 * @return       void
 *
 * @modified By  Srinivasulu on 10/08/2017....
 * @reason       added the comment's....
 *
 * @verified By
 * @verified On
 *
 */

-(void)textViewDidEndEditing:(UITextView *)textView {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        registrationView.frame = CGRectMake(200, 10, 668, 700);
    }
    else {
        registrationView.frame = CGRectMake(10, -160, 300, 420);
    }
    
}

#pragma -mark keyboard notification methods

/**
 * @description  called when keyboard is displayed
 * @date         10/08/2017
 * @method       keyboardWillShow
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)keyboardWillShow {
    // Animate the current view out of the way
    @try {
        
        [self setViewMovedUp:YES];
    } @catch (NSException *exception) {
        NSLog(@"-------exception while changing frame self.view---------%@",exception);
        
    }
}

/**
 * @description  called when keyboard is dismissed
 * @date         10/08/2017
 * @method       keyboardWillHide
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)keyboardWillHide {
    @try {
        
        [self setViewMovedUp:NO];
    } @catch (NSException *exception) {
        
        NSLog(@"-------exception while changing frame self.view---------%@",exception);
    }
}

/**
 * @description  method to move the view up/down whenever the keyboard is shown/dismissed
 * @date         10/08/2017
 * @method       setViewMovedUp
 * @author       Srinivasulu
 * @param        BOOL
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)setViewMovedUp:(BOOL)movedUp
{
    @try {
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3]; // if you want to slide up the view
        
        CGRect rect = self.view.frame;
        
        //    CGRect rect = scrollView.frame;
        
        if (movedUp)
        {
            // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
            rect.origin.y = (rect.origin.y -(rect.origin.y + offSetViewTo));
        }
        else
        {
            // revert back to the normal state.
            rect.origin.y +=  offSetViewTo;
        }
        self.view.frame = rect;
        //   scrollView.frame = rect;
        
        [UIView commitAnimations];
        
        /* offSetViewTo = 80;
         [self keyboardWillShow];*/
        
    } @catch (NSException *exception) {
        
        NSLog(@"-------exception while changing frame self.view---------%@",exception);
    } @finally {
        
    }
    
}

/**
 * @description  here we are checking whether the object is null or not
 * @date         09/11/2017
 * @method       checkGivenValueIsNullOrNil
 * @author       Bhargav
 * @paramØ
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (id)checkGivenValueIsNullOrNil:(id)inputValue defaultReturn:(NSString *)returnStirng {
    
    @try {
        if ([inputValue isKindOfClass:[NSNull class]] || inputValue == nil) {
            return returnStirng;
        }
        else {
            return inputValue;
        }
    } @catch (NSException *exception) {
        return @"--";
    }
    
}



-(id) imageFromImage:(UIImage*)image  imageBackGroundColor:(UIColor*)backGroundColor  string:(NSString*)string  color:(UIColor*)color  font:(int)fontSize   width:(float)labelWidth height:(float)labelHeight fontType:(NSString *)fontType imageWidth:(float)imageWidth imageHeight:(float)imageHeight{
    
    @try {
        UIImageView  *returnView =  [[UIImageView alloc] init];
        
        UIImageView  *imageView =  [[UIImageView alloc] init];
        
        /*[self  imageFromImage:[UIImage imageNamed:@"Users@2x.png"]
         imageBackGroundColor:[UIColor blackColor]
         string:@"cloud"
         color:[UIColor blueColor]
         font:12
         width:width
         height:15
         fontType:TEXT_FONT_NAME
         imageWidth:100
         imageHeight:height - 15]];*/
        //added by Srinivasulu on 29/08/2016....
        UIGraphicsBeginImageContext(CGSizeMake(imageWidth, imageHeight));
        [image drawInRect:CGRectMake(0, 0, imageWidth, imageHeight)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        imageView.image = newImage;
        imageView.contentMode = UIViewContentModeCenter;
        
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor =[UIColor clearColor];
        label.textAlignment =  NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        label.font = [UIFont fontWithName:fontType size:fontSize];
        label.text = string;
        label.textColor = color;
        
        
        //frame setting.....
        returnView.frame = CGRectMake(0, 0, labelWidth, imageHeight + labelHeight);
        imageView.frame = CGRectMake( (labelWidth - imageWidth)/2, 0,  imageWidth, imageHeight);
        label.frame = CGRectMake(0, imageHeight,labelWidth, labelHeight);
        
        
        //        if (! (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && [[[UIDevice currentDevice] systemVersion] floatValue] < 8.0))
        imageView.backgroundColor = backGroundColor;//[UIColor clearColor];
        
        
        [returnView addSubview:imageView];
        [returnView addSubview:label];
        
        UIGraphicsBeginImageContextWithOptions(returnView.bounds.size, false, 0);
        
        [returnView.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *imageWithText = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return imageWithText;
        
    }
    @catch (NSException *exception) {
        
        return nil;
    }
    @finally {
        
    }
    
}


-(void)changeOperationMode:(NSInteger)statusNo{
    
    @try {
        
        if (statusNo == 0) {
            
            isOfflineService = YES;
            
            changeModeSwitch.tintColor = [UIColor redColor];
            changeModeSwitch.layer.cornerRadius = 16;
            changeModeSwitch.backgroundColor = [UIColor redColor];
        }
        else {
            
            isWifiSelectionChanged = FALSE;
            
            CheckWifi *wifi = [[CheckWifi alloc] init];
            BOOL status = [wifi checkWifi];
            
            if ((status) && (changeModeSwitch.tag == 4)) {
                
                [changeModeSwitch setOn:true];
                isOfflineService = false;
            }
            else if(changeModeSwitch.tag == 4) {
                
                UIAlertView * sampleAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"before_switch_to_online_code_please_enable_wifi", nil) message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [sampleAlert show];
                
                [changeModeSwitch setOn:false];
                isOfflineService = true;
            }
            else{
                
                changeModeSwitch.tag = 4;
            }
        }
        
    } @catch (NSException *exception) {
        
    }
}

-(void)changeWifiSwitchAction:(UISwitch*)switchBtn {
    
    if ((!switchBtn.on) && (changeModeSwitch.tag == 4)) {
        
        changeModeSwitch.tag = 4;
        
        changeModeSwitch.layer.cornerRadius = 16;
        changeModeSwitch.tintColor = [UIColor redColor];
        changeModeSwitch.backgroundColor = [UIColor redColor];
        
        changeToOfflineModeAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"do_you_want_to_switch_over_to_offline_mode", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"yes", nil) otherButtonTitles:NSLocalizedString(@"no", nil), nil];
        [changeToOfflineModeAlert show];
    }
    else if(changeModeSwitch.tag == 4){
        
        isWifiSelectionChanged = FALSE;
        
        CheckWifi *wifi = [[CheckWifi alloc] init];
        BOOL status = [wifi checkWifi];
        
        if (status) {
            
            changeModeSwitch.tag = 4;
            [changeModeSwitch setOn:true];
            
            isOfflineService = false;
        }
        else {
            
            UIAlertView * sampleAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"before_switch_to_online_code_please_enable_wifi", nil) message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [sampleAlert show];
            
            [changeModeSwitch setOn:false];
            isOfflineService = true;
        }
    }
    else{
        
        changeModeSwitch.tag = 4;
    }
}

#pragma -mark start of OTP mentions..

/**
 * @description  in this method we are froming the OTP screen..
 * @date         29/08/2018
 * @method       formOTPView
 * @author       Srinivasulu
 * @param
 * @param
 *
 * @return      Void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)formOTPView{
    
    @try {
        
        if(viewContollerTransperentView == nil){
            
            //UILabel used for displaying header information...
            UILabel * headerlabel;
            UIButton * closeBtn;
            
            UIButton * resendOTPBtn;
            UIButton * okValidateEnteredOTPBtn;
            
            viewContollerTransperentView = [[UIView alloc] init];
            viewContollerTransperentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
            
            firtTimeInstallationOTPView = [[UIView alloc] init];
            firtTimeInstallationOTPView.opaque = NO;
            firtTimeInstallationOTPView.backgroundColor = [UIColor blackColor];
            firtTimeInstallationOTPView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            firtTimeInstallationOTPView.layer.borderWidth = 2.0f;
            
            headerlabel = [[UILabel alloc] init];
            headerlabel.textColor = [UIColor whiteColor];
            headerlabel.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
            headerlabel.textAlignment = NSTextAlignmentCenter;
            
            // close button to close the view ..
            UIImage * image = [UIImage imageNamed:@"delete.png"];
            
            closeBtn = [[UIButton alloc] init] ;
            [closeBtn addTarget:self action:@selector(formOTPView) forControlEvents:UIControlEventTouchUpInside];
            [closeBtn setBackgroundImage:image    forState:UIControlStateNormal];
            
            userEnteredOTPTxt = [[UITextField alloc] init];
            userEnteredOTPTxt.borderStyle = UITextBorderStyleBezel;
            userEnteredOTPTxt.textColor = [UIColor blackColor];
            userEnteredOTPTxt.delegate = self;
            userEnteredOTPTxt.keyboardType = UIKeyboardTypeNumberPad;
            userEnteredOTPTxt.backgroundColor = [UIColor whiteColor];
            
            resendOTPBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
            [resendOTPBtn addTarget:self action:@selector(resendOTP:) forControlEvents:UIControlEventTouchDown];
            resendOTPBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
            resendOTPBtn.layer.cornerRadius = 0.0f;
            resendOTPBtn.backgroundColor = [UIColor clearColor];
            
            okValidateEnteredOTPBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [okValidateEnteredOTPBtn addTarget:self action:@selector(validateEnteredOTP:) forControlEvents:UIControlEventTouchDown];
            okValidateEnteredOTPBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
            okValidateEnteredOTPBtn.layer.cornerRadius = 0.0f;
            okValidateEnteredOTPBtn.backgroundColor = [UIColor grayColor];
            
            [firtTimeInstallationOTPView addSubview:headerlabel];
            [firtTimeInstallationOTPView addSubview:closeBtn];
            [firtTimeInstallationOTPView addSubview:userEnteredOTPTxt];
            [firtTimeInstallationOTPView addSubview:resendOTPBtn];
            [firtTimeInstallationOTPView addSubview:okValidateEnteredOTPBtn];
            
            [viewContollerTransperentView addSubview:firtTimeInstallationOTPView];
            [self.view addSubview:viewContollerTransperentView];
            
            @try{
                
                headerlabel.text = NSLocalizedString(@"login_otp_alert", nil);
                userEnteredOTPTxt.placeholder = NSLocalizedString(@"enter_otp", nil);
                resendOTPBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
                [resendOTPBtn setTitle:NSLocalizedString(@"resend_otp", nil) forState:UIControlStateNormal];
                [okValidateEnteredOTPBtn setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
                
                [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:firtTimeInstallationOTPView andSubViews:YES fontSize:20 cornerRadius:0];
                
                headerlabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:24];
                userEnteredOTPTxt.font = [UIFont fontWithName:TEXT_FONT_NAME size:20];
                //                resendOTPBtn.font = [UIFont fontWithName:TEXT_FONT_NAME size:20];
                //                okValidateEnteredOTPBtn.font = [UIFont fontWithName:TEXT_FONT_NAME size:20];
                
            } @catch (NSException *exception) {
                
            }
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
                    
                }
                else{
                }
                
                viewContollerTransperentView.frame = self.view.frame;
                
                headerlabel.frame = CGRectMake( 0, 0, viewContollerTransperentView.frame.size.width/2, 50);
                closeBtn.frame =  CGRectMake( headerlabel.frame.size.width - 60, 0, 50, 50);
                
                userEnteredOTPTxt.frame = CGRectMake( (headerlabel.frame.size.width - (headerlabel.frame.size.width/3))/2, headerlabel.frame.size.height + 10, headerlabel.frame.size.width/3, headerlabel.frame.size.height);
                
                resendOTPBtn.frame = CGRectMake( userEnteredOTPTxt.frame.origin.x, userEnteredOTPTxt.frame.origin.y + userEnteredOTPTxt.frame.size.height + 10, userEnteredOTPTxt.frame.size.width, userEnteredOTPTxt.frame.size.height);
                
                okValidateEnteredOTPBtn.frame = CGRectMake( resendOTPBtn.frame.origin.x, resendOTPBtn.frame.origin.y + resendOTPBtn.frame.size.height + 10, resendOTPBtn.frame.size.width, resendOTPBtn.frame.size.height);
                
                firtTimeInstallationOTPView.frame = CGRectMake( (viewContollerTransperentView.frame.size.width - headerlabel.frame.size.width) / 2, (viewContollerTransperentView.frame.size.height - (okValidateEnteredOTPBtn.frame.origin.y + okValidateEnteredOTPBtn.frame.size.height + 10)) / 2, headerlabel.frame.size.width, okValidateEnteredOTPBtn.frame.origin.y + okValidateEnteredOTPBtn.frame.size.height + 10);
            }
            else{
            }
        }
        else if(viewContollerTransperentView.isHidden){
            [viewContollerTransperentView setHidden:NO];
        }
        else{
            [viewContollerTransperentView setHidden:YES];
        }
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}


/**
 * @description  here we are calling the service for resendt the OTP....
 * @date
 * @method       resendOTP:
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 *
 * @return
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)resendOTP:(UIButton *)sender{
    
    @try {
        [self generatedCustomerOtp];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  here we are vadliating user entered otp....
 * @date
 * @method       validateEnteredOTP:
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 *
 * @return
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)validateEnteredOTP:(UIButton *)sender{
    
    @try {
        if([userEnteredOTPTxt.text length]){
            
            [self valideCustomerOtp];
        }
        else{
            
            float y_axis = self.view.frame.size.height - 120;
            
            y_axis = viewContollerTransperentView.frame.origin.y;
            
            NSString * mesg = NSLocalizedString(@"please_enter_otp", nil);
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        }
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  in this method we calling generate otp servives....
 * @date         29/08/2018....
 * @method       generatedCustomerOtp
 * @author
 * @param
 * @param        UIButton
 * @param
 *
 * @return       void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)generatedCustomerOtp{
    
    @try {
        
        //showing the hud....
        [HUD setHidden:NO];
        
        //text format of the HUD...
        [HUD setLabelText:NSLocalizedString(@"please_wait..", nil)];
        
        
        NSMutableDictionary * generateOtpDetailsDic = [[NSMutableDictionary alloc] init];
        
        //setting requestHeader....
        generateOtpDetailsDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:generateOtpDetailsDic options:0 error:&err];
        NSString * quoteRequestJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.appSettingServicesDelegate = self;
        [webServiceController generateBuildOTP:quoteRequestJsonString];
    } @catch (NSException * exception) {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"----exception in Service Call---%@",exception);
    }
}

/**
 * @description  in this method we calling validate otp servives....
 * @date         29/12/2017....
 * @method       valideCustomerOtp
 * @author
 * @param
 * @param        UIButton
 * @param
 *
 * @return       void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)valideCustomerOtp{
    
    @try {
        
        //showing the hud....
        [HUD setHidden:NO];
        
        //text format of the HUD...
        [HUD setLabelText:NSLocalizedString(@"please_wait..", nil)];
        
        NSMutableDictionary  * valideOtpDetailsDic = [[NSMutableDictionary alloc] init];
        
        //setting requestHeader....
        valideOtpDetailsDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        
        //setting for phoneNumber....
        valideOtpDetailsDic[OTP_CODE] = userEnteredOTPTxt.text;
        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:valideOtpDetailsDic options:0 error:&err];
        NSString * quoteRequestJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.appSettingServicesDelegate = self;
        [webServiceController validateBuildOTP:quoteRequestJsonString];
    } @catch (NSException * exception) {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"----exception in Service Call---%@",exception);
    }
}

#pragma -mark start service call response handling  in the GiftVouchers, GiftCoupons && LoylityCard

/**
 * @description  in this method will be executed when success resposne is received from service for gernerateOtp service call....
 * @date         29/12/2017....
 * @method       generateOtpForCustomerSuccessReponse:--
 * @author       Srinivasulu
 * @param
 * @param        NSDictionary
 * @param
 *
 * @return       void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)generateBuildOTPSuccessResponse:(NSDictionary *)sucessDictionary{
    @try {
        float y_axis = self.view.frame.size.height - 120;
        
        y_axis = viewContollerTransperentView.frame.origin.y;
        
        NSString * mesg = NSLocalizedString(@"otp_has_been_sent", nil);
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}

/**
 * @description  in this method will be executed when success resposne is received from service for gernerateOtp service call....
 * @date         29/12/2017....
 * @method       generateOtpForCustomerErrorResponse:--
 * @author       Srinivasulu
 * @param
 * @param        NSString
 * @param
 *
 * @return       void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)generateBuildOTPErrorResponse:(NSString *)error{
    @try {
        
        float y_axis = self.view.frame.size.height - 120;
        
        y_axis = viewContollerTransperentView.frame.origin.y;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",error];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}

/**
 * @description  in this method will be executed when success resposne is received from service for gernerateOtp service call....
 * @date         29/12/2017....
 * @method       validateOtpForCustomerSuccessResponse:--
 * @author       Srinivasulu
 * @param
 * @param        NSDictionary
 * @param
 *
 * @return       void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)validateBuildOTPSuccessResponse:(NSDictionary *)sucessDictionary{
    @try {
        [HUD setHidden:YES];
        OmniHomePage *homepage = [[OmniHomePage alloc] init];
        [self.navigationController pushViewController:homepage animated:NO];
    } @catch (NSException *exception) {
        
    } @finally {
    }
}

/**
 * @description  in this method will be executed when success resposne is received from service for gernerateOtp service call....
 * @date         29/08/2018....
 * @method       validateBuildOTPErrorResponse:--
 * @author       Srinivasulu
 * @param
 * @param        NSString
 * @param
 *
 * @return       void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)validateBuildOTPErrorResponse:(NSString *)error{
    @try {
        
        
        float y_axis = self.view.frame.size.height - 120;
        
        y_axis = viewContollerTransperentView.frame.origin.y;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",error];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
    
}

#pragma -mark method used to display alert/warning messages....

/**
 * @description  adding the  alertMessage's based on input
 * @date         15/03/2017
 * @method       displayAlertMessage
 * @author       Srinivasulu
 * @param        NSString
 * @param        float
 * @param        float
 * @param        NSString
 * @param        float
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)displayAlertMessage:(NSString *)message    horizontialAxis:(float)xPostion  verticalAxis:(float)yPosition msgType:(NSString *)messageType   conentWidth:(float )labelWidth contentHeight:(float)labelHeight   isSoundRequired:(BOOL)soundStatus  timming:(float)noOfSecondsToDisplay    noOfLines:(int)noOfLines{
    
    
    //    [self displayAlertMessage: @"No Products Avaliable" horizontialAxis:segmentedControl.frame.origin.x   verticalAxis:segmentedControl.frame.origin.y  msgType:@"warning" timming:2.0];
    
    @try {
        AudioServicesPlayAlertSound(soundFileObject);
        
        if ([userAlertMessageLbl isDescendantOfView:self.view] ) {
            [userAlertMessageLbl removeFromSuperview];
            
        }
        
        userAlertMessageLbl = [[UILabel alloc] init];
        userAlertMessageLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20];
        userAlertMessageLbl.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        userAlertMessageLbl.layer.cornerRadius = 5.0f;
        userAlertMessageLbl.text =  message;
        userAlertMessageLbl.textAlignment = NSTextAlignmentCenter;
        userAlertMessageLbl.numberOfLines = noOfLines;
        
        
        userAlertMessageLbl.tag = 2;
        
        if ([messageType caseInsensitiveCompare:@"SUCCESS"] == NSOrderedSame) {
            userAlertMessageLbl.tag = 4;
            
            userAlertMessageLbl.textColor = [UIColor colorWithRed:114.0/255.0 green:203.0/255.0 blue:158.0/255.0 alpha:1.0];
            
            if(soundStatus){
                
                SystemSoundID    soundFileObject1;
                NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
                self.soundFileURLRef = (__bridge CFURLRef) tapSound;
                AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                AudioServicesPlaySystemSound (soundFileObject1);
            }
            
            
        }
        else{
            userAlertMessageLbl.textColor = [UIColor redColor];
            
            if(soundStatus){
                SystemSoundID    soundFileObject1;
                NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
                self.soundFileURLRef = (__bridge CFURLRef) tapSound;
                AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                AudioServicesPlaySystemSound (soundFileObject1);
            }
            
            
        }
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            //            if(searchItemsTxt.isEditing)
            //                yPosition = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height;
            
            
            userAlertMessageLbl.frame = CGRectMake(xPostion, yPosition, labelWidth, labelHeight);
            
        }
        else{
            if (version > 8.0) {
                userAlertMessageLbl.frame = CGRectMake(xPostion + 75, yPosition-35, 200, 30);
                userAlertMessageLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
                
            }
            else{
                userAlertMessageLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
                userAlertMessageLbl.frame = CGRectMake(xPostion + 75, yPosition-35, 200, 30);
                
            }
            
        }
        
        //added by Srinivasulu on 11/12/2017....
        
        userAlertMessageLbl.backgroundColor = [UIColor whiteColor];
        userAlertMessageLbl.textColor = [UIColor blackColor];
        
        //upto here on 11/12/2017....
        
        [self.view addSubview:userAlertMessageLbl];
        fadeOutTime = [NSTimer scheduledTimerWithTimeInterval:noOfSecondsToDisplay target:self selector:@selector(removeAlertMessages) userInfo:nil repeats:NO];
        
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        
        NSLog(@"--------exception in the stockReceiptView in displayAlertMessage---------%@",exception);
        NSLog(@"----exception while creating the useralertMesssageLbl------------%@",exception);
        
    }
}

/**
 * @description  here we are removing the existing label....
 * @date         18//04/2017....
 * @method       remoeAlertMessage
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)removeAlertMessages{
    @try {
        
        if(userAlertMessageLbl.tag == 4){
            
            //            [self gobackView];
        }
        
        else if ([userAlertMessageLbl isDescendantOfView:self.view])
            [userAlertMessageLbl removeFromSuperview];
        
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"----exception in removing userAlertMessageLbl label------------%@",exception);
        
    }
}

//added by Srinivasulu on 30/08/2018.. reason inorder to access the https service call also....
-(void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    
    NSLog(@"This will execute successfully!");
    if ([[challenge protectionSpace] authenticationMethod] == NSURLAuthenticationMethodServerTrust) {
        
        [[challenge sender] useCredential:[NSURLCredential credentialForTrust:[[challenge protectionSpace] serverTrust]] forAuthenticationChallenge:challenge];
    }
}

@end
