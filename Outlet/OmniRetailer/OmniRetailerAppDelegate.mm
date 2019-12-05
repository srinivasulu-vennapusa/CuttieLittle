
//
//  OmniRetailerAppDelegate.m
//  OmniRetailer
//
//  Created by Satya Siva Saradhi on 9/20/12.
//  Copyright 2012 __techolabssoftware.com__. All rights reserved.
//

#import "OmniRetailerAppDelegate.h"

#import "OmniRetailerViewController.h"
#import "DataBaseConnection.h"
#import "sqlite3.h"
#import "Global.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>


static sqlite3 *database = nil;
static sqlite3_stmt *selectStmt = nil;
//static sqlite3_stmt *insertStmt = nil;



@implementation OmniRetailerAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize appController;

//- (void)installUncaughtExceptionHandler
//{
   // InstallUncaughtExceptionHandler();
//}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
//    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationMaskLandscapeRight];
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    application.statusBarStyle = UIStatusBarStyleBlackOpaque;
    //self.window.rootViewController = self.viewController;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        self.viewController = [[OmniRetailerViewController alloc]init];
    }
    else {
        self.viewController = [[OmniRetailerViewController alloc]initWithNibName:@"OmniRetailerViewController-iPhone" bundle:nil];
    }
    appController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    appController.navigationBar.tintColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
    self.window.rootViewController = appController;
    [self.window addSubview:appController.view];
    (self.window).frame = [UIScreen mainScreen].bounds;
    [self.window makeKeyAndVisible];
    
    [UIBarButtonItem appearance].tintColor = [UIColor blackColor];
    [self loadDbpath];

    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        [UITextField appearance].backgroundColor = [UIColor clearColor];
        ([UITextField appearance].layer).borderWidth = 1.0;
        ([UITextField appearance].layer).borderColor = [UIColor lightGrayColor].CGColor;

        
        [[UITextField appearance].attributedPlaceholder initWithString:[UITextField appearance].placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor whiteColor]colorWithAlphaComponent:0.8]}];

    }
    
    //adding the notifications for powa device connection.....
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(accessoryDidConnect:)
//                                                 name:EAAccessoryDidConnectNotification
//                                               object:nil];
//    
//    [[EAAccessoryManager sharedAccessoryManager] registerForLocalNotifications];
//    
//    
//    
//    // Initialize the PowaPOS SDK
//    powaPOS = [[PowaPOS alloc] init];
//    
//
//    @try {
//     
//        NSArray *connectedTSeries = [PowaTSeries connectedDevices];
//        
//        // Select the first TSeries device available
//        if(connectedTSeries.count)
//        {
//            printer = connectedTSeries[0];
//            [powaPOS addPeripheral:printer];
//        }
//        
//        // Get the connected scanners
//        NSArray *connectedScanners = [PowaS10Scanner connectedDevices];
//        
//        // Select the first S10 scanner device available
//        if(connectedScanners.count)
//        {
//            scanner = connectedScanners[0];
//            
//            [powaPOS addPeripheral:scanner];
//        }
//
//    }
//    @catch (NSException *exception) {
//      
//        NSLog(@"exception %@",exception);
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Failed to connect the device" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//        
//    }
//  
//
    [Crashlytics sharedInstance].debugMode = YES;
    [Fabric with:@[[Crashlytics class]]];
    
    //added by Srinivasulu on 28/08/2017....
    //commented by Srinivasulu on 28/08.2017....
    //reason it has to be tested....
    
//    [self logUser];
    
    //upto here on 28/08/2017....
    
    return YES;
    
}

void uncaughtExceptionHandler(NSException *exception) {
    NSLog(@"CRASH: %@", exception);
    NSLog(@"Stack Trace: %@", exception.callStackSymbols);
}

- (void) loadDbpath {
    
    NSString *domainText = NULL;
    NSString *portNumber = NULL;
    
    //Get data from database
    // getting the present value's from database ..
    
    NSString* dbPath = [self getDBPath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *databasePathFromApp = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"RetailerConfigDataBase.sqlite"];
    
    [fileManager copyItemAtPath:databasePathFromApp toPath:dbPath error:nil];
    
    if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
        
        const char *sqlStatement = "select * from ServiceCredentials";
        
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &selectStmt, NULL) == SQLITE_OK) {
            while (sqlite3_step(selectStmt) == SQLITE_ROW) {
                
                domainText = @((char *)sqlite3_column_text(selectStmt, 0));
                portNumber = @((char *)sqlite3_column_text(selectStmt, 1));
            }
            sqlite3_finalize(selectStmt);
        }
    }
    
    host_name = [domainText copy];
    port_no   = [portNumber copy];
    
    selectStmt = nil;
    sqlite3_close(database);
//    if ([host_name rangeOfString:@"."].location == NSNotFound) {
//        [self addingConfigurationService];
//    }
    // setting the gloable variables for domain and port number
    // changed by saradhi on 5-12-12 ..
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    
    user_name = @"";
    userPassword = @"";
}



- (void)accessoryDidConnect:(NSNotification *)notification
{
    if(!self.tseries)
    {
        // Get the connected TSeries devices
        NSArray *connectedTSeries = [PowaTSeries connectedDevices];
        
        // Select the first TSeries device available
        if(connectedTSeries.count)
        {
            self.tseries = connectedTSeries[0];
            [self.tseries addObserver:self];
            [self.powaPOS addPeripheral:self.tseries];
        }
    }
    
    if(!self.scanner)
    {
        // Get the connected scanners
        NSArray *connectedScanners = [PowaS10Scanner connectedDevices];
        
        // Select the first S10 scanner device available
        if(connectedScanners.count)
        {
            self.scanner = connectedScanners[0];
            [self.scanner addObserver:self];
            [self.powaPOS addPeripheral:self.scanner];
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


- (NSString *) getDBPath {
    
    //Search for standard documents using NSSearchPathForDirectoriesInDomains
    //First Param = Searching the documents directory
    //Second Param = Searching the Users directory and not the System
    //Expand any tildes and identify home directories.
    NSString* databaseName = @"RetailerConfigDataBase.sqlite";
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = documentPaths[0];
    NSString* databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    return databasePath;
    
}


#pragma -mark mehod used for star printer....


- (void)loadParam {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults registerDefaults:@{@"portName": @""}];
    [userDefaults registerDefaults:@{@"portSettings": @""}];
    [userDefaults registerDefaults:@{@"modelName": @""}];
    [userDefaults registerDefaults:@{@"macAddress": @""}];
    [userDefaults registerDefaults:@{@"emulation": @(StarIoExtEmulationStarPRNT)}];
    [userDefaults registerDefaults:@{@"cashDrawerOpenActiveHigh": @YES}];
    [userDefaults registerDefaults:@{@"allReceiptsSettings": @0x00000007}];
    
    _portName                 = [userDefaults stringForKey :@"portName"];
    _portSettings             = [userDefaults stringForKey :@"portSettings"];
    _modelName                = [userDefaults stringForKey :@"modelName"];
    _macAddress               = [userDefaults stringForKey :@"macAddress"];
    _emulation                = [userDefaults integerForKey:@"emulation"];
    _cashDrawerOpenActiveHigh = [userDefaults boolForKey   :@"cashDrawerOpenActiveHigh"];
    _allReceiptsSettings      = [userDefaults integerForKey:@"allReceiptsSettings"];
}

+ (NSString *)getPortName {
    OmniRetailerAppDelegate *delegate = (OmniRetailerAppDelegate *) [UIApplication sharedApplication].delegate;
    
    return delegate.portName;
}

+ (void)setPortName:(NSString *)portName {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    OmniRetailerAppDelegate *delegate = (OmniRetailerAppDelegate *) [UIApplication sharedApplication].delegate;
    
    delegate.portName = portName;
    
    [userDefaults setObject:delegate.portName forKey:@"portName"];
    
    [userDefaults synchronize];
}

+ (NSString*)getPortSettings {
    OmniRetailerAppDelegate *delegate = (OmniRetailerAppDelegate *) [UIApplication sharedApplication].delegate;
    
    return delegate.portSettings;
}

+ (void)setPortSettings:(NSString *)portSettings {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    OmniRetailerAppDelegate *delegate = (OmniRetailerAppDelegate *) [UIApplication sharedApplication].delegate;
    
    delegate.portSettings = portSettings;
    
    [userDefaults setObject :delegate.portSettings forKey:@"portSettings"];
    
    [userDefaults synchronize];
}

+ (NSString *)getModelName {
    OmniRetailerAppDelegate *delegate = (OmniRetailerAppDelegate *) [UIApplication sharedApplication].delegate;
    
    return delegate.modelName;
}

+ (void)setModelName:(NSString *)modelName {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    OmniRetailerAppDelegate *delegate = (OmniRetailerAppDelegate *) [UIApplication sharedApplication].delegate;
    
    delegate.modelName = modelName;
    
    [userDefaults setObject:delegate.modelName forKey:@"modelName"];
    
    [userDefaults synchronize];
}

+ (NSString *)getMacAddress {
    OmniRetailerAppDelegate *delegate = (OmniRetailerAppDelegate *) [UIApplication sharedApplication].delegate;
    
    return delegate.macAddress;
}

+ (void)setMacAddress:(NSString *)macAddress {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    OmniRetailerAppDelegate *delegate = (OmniRetailerAppDelegate *) [UIApplication sharedApplication].delegate;
    
    delegate.macAddress = macAddress;
    
    [userDefaults setObject:delegate.macAddress forKey:@"macAddress"];
    
    [userDefaults synchronize];
}

+ (StarIoExtEmulation)getEmulation {
    OmniRetailerAppDelegate *delegate = (OmniRetailerAppDelegate *) [UIApplication sharedApplication].delegate;
    
    return delegate.emulation;
}

+ (void)setEmulation:(StarIoExtEmulation)emulation {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    OmniRetailerAppDelegate *delegate = (OmniRetailerAppDelegate *) [UIApplication sharedApplication].delegate;
    
    delegate.emulation = emulation;
    
    [userDefaults setInteger:delegate.emulation forKey:@"emulation"];
    
    [userDefaults synchronize];
}


#pragma -mark mehod used for carshreport....

/**
 * @description  In this method we are configuring the email at ....
 * @date         28/08/2017..
 * @method       logUser
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void) logUser {
    // TODO: Use the current user's information
    // You can call any combination of these three methods
    [CrashlyticsKit setUserIdentifier:@"12345"];
    [CrashlyticsKit setUserEmail:@"srinivasulu.v@technolabssoftware.com"];
    [CrashlyticsKit setUserName:@"Test User"];
}


@end
