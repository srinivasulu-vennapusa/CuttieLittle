//
//  mSwipeAppDelegate.m
//  mSwipe
//
//  Created by satish nalluru on 05/01/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "mSwipeAppDelegate.h"
#import <Security/Security.h>
//#import "MenuViewController.h"
#import "Constants.h"
#import "MerchantSettings.h"
#import "CardSaleResults.h"
//#import "CardSaleViewController.h"

#import "CardSaleData.h"
#define log_tab @"MswipeDelegate"

@implementation mSwipeAppDelegate


@synthesize window=_window;
@synthesize uiNavigationController;
@synthesize mMerchantSettings;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    UIWindow *tempwindow =[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window = tempwindow;
    self.mMerchantSettings = [[MerchantSettings alloc] init];
    [self showMainMenuScreen:nil];

    
    return YES;
}





-(void) initializeNavigationControllerScreen
{

}



- (void) showMainMenuScreen : (id) sender;
{
    [uiNavigationController.view removeFromSuperview];
    self.uiNavigationController = nil;
//    CardSaleViewController *menutabcontroller = [[CardSaleViewController alloc] init];
//    
//        
//        uiNavigationController = [[UINavigationController alloc] initWithRootViewController:menutabcontroller];
//        self.window.rootViewController = uiNavigationController;    
//        [self.window makeKeyAndVisible];  

  

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
}


@end
