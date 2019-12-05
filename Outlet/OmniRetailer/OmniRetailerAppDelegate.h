//
//  OmniRetailerAppDelegate.h
//  OmniRetailer
//
//  Created by Satya Siva Saradhi on 9/20/12.
//  Copyright 2012 __techolabssoftware.com__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PowaPOSSDK/PowaPOSSDK.h>
#import <ExternalAccessory/ExternalAccessory.h>
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import "OmniHomePage.h"


//added by Srinivasulu on 19/06/2017....
//reason is used for starIO_print....

#import <StarIO_Extension/StarIoExt.h>

//upto here on 19/06/2017....



@class OmniRetailerViewController;

@interface OmniRetailerAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    OmniRetailerViewController *viewController;
    UINavigationController *appController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet OmniRetailerViewController *viewController;
@property (nonatomic, retain) UINavigationController *appController;

@property (nonatomic, retain) PowaPOS *powaPOS;
@property (nonatomic, retain) PowaTSeries *tseries;
@property (nonatomic, retain) PowaS10Scanner *scanner;

- (void) loadDbpath;
- (NSString *) getDBPath;
//- (void) resetApp;


//added by Srinivasulu on 19/06/2017....
//reason is used for starIO_print....


+ (NSString *)getPortName;

+ (void)setPortName:(NSString *)portName;

+ (NSString *)getPortSettings;

+ (void)setPortSettings:(NSString *)portSettings;

+ (NSString *)getModelName;

+ (void)setModelName:(NSString *)modelName;

+ (NSString *)getMacAddress;

+ (void)setMacAddress:(NSString *)macAddress;

+ (StarIoExtEmulation)getEmulation;

+ (void)setEmulation:(StarIoExtEmulation)emulation;


@property (nonatomic, copy) NSString *portName;
@property (nonatomic, copy) NSString *portSettings;
@property (nonatomic, copy) NSString *modelName;
@property (nonatomic, copy) NSString *macAddress;

@property (nonatomic) StarIoExtEmulation emulation;
@property (nonatomic) BOOL               cashDrawerOpenActiveHigh;
@property (nonatomic) NSInteger          allReceiptsSettings;
@property (nonatomic) NSInteger          selectedIndex;
- (void)loadParam;


@end
