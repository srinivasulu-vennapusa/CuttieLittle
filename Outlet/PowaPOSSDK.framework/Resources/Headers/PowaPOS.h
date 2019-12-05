//
//  POWAPeripherals.h
//  POWAPeripheralsSDK
//
//  Created by Abel Duarte on 8/6/14.
//  Copyright (c) 2014 Powa. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PowaPrinter.h"
#import "PowaScanner.h"
#import "PowaPeripheral.h"
#import "PowaCashDrawer.h"
#import "PowaRotationSensor.h"

@interface PowaPOS : NSObject
{
}

- (NSString *)frameworkVersion;

/**
 Returns a peripheral that implements the protocol PowaPrinter that you can use to print

 @return printer an object that implements the protocol PowaPrinter
*/

@property (nonatomic, retain, readonly) id <PowaPrinter> printer;

/**
 Returns a peripheral that implements the protocol PowaScanner that you can use to scan barcodes

 @return scanner an object that implements the protocol PowaScanner
*/

@property (nonatomic, retain, readonly) id <PowaScanner> scanner;

/**
 Returns a peripheral that implements the protocol PowaCashDrawer that you can use to manage a cash drawer

 @return cashDrawer an object that implements the protocol PowaCashDrawer
*/

@property (nonatomic, retain, readonly) id <PowaCashDrawer> cashDrawer;

/**
 Returns a peripheral that implements the protocol PowaRotationSensor that you can use to determine the rotation of the device

 @return rotationSensor an object that implements the protocol PowaRotationSensor
*/

@property (nonatomic, retain, readonly) id <PowaRotationSensor> rotationSensor;


/**
 Configures a new peripheral to work with the PowaPOSSDK. If you have not called connect on the peripheral this method will. For devices that take time to initialize wait until you receive the initialize event prior to calling methods on them.

 @param the peripheral to manage using the PowaPOSSDK
*/

- (void)addPeripheral:(id <PowaPeripheral>)peripheral;

@end
