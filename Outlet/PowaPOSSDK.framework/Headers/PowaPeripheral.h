//
//  POWAPeripheral.h
//  POWAPeripheralsSDK
//
//  Created by Abel Duarte on 8/6/14.
//  Copyright (c) 2014 Powa. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PowaDeviceInfo.h"

enum
{
    PowaPeripheralConnectionStateDisconnected,
    PowaPeripheralConnectionStateConnected,
    PowaPeripheralConnectionStateConnecting
};
typedef NSUInteger PowaPeripheralConnectionState;

@protocol PowaPeripheral <NSObject>

#pragma mark - Device info

/*!
 * @discussion Returns the device info for this device
 * @brief Returns an object with properties containing information about the peripheral
 * @return An object inheriting from PowaDeviceInfo
 * @updated 01-09-2015
*/

- (PowaDeviceInfo *)deviceInfo;

#pragma mark - Device discovery

/*!
 * @discussion Returns a list of connected devices of this type
 * @brief Returns a list of connected devices of this type
 * @return Returns an array of connected devices
 * @updated 01-09-2015
*/

+ (NSArray *)connectedDevices;

#pragma mark - Connection handling

@property (nonatomic, readonly) PowaPeripheralConnectionState connectionState;

/*!
 * @brief Opens a session with the device
 * @discussion Opens a session with the device
 * @updated 01-09-2015
 */

- (void)connect;

/*!
 * @brief Closes a session with the device
 * @discussion Closes a session with the device
 * @updated 01-09-2015
 */

- (void)disconnect;

#pragma mark - Observer

/*!
 * @brief Register as an observer
 * @discussion Register to receive events from this device. You must implement the observer protocol for the specific device.
 * @param observer the object that wants to receive events from this device
 * @updated 01-09-2015
 */

- (void)addObserver:(id)observer;

/*!
 * @brief Remove observer
 * @discussion Stop receiving events from this device
 * @param observer the object that wants to stop receiving events from this device
 * @updated 01-09-2015
 */

- (void)removeObserver:(id)observer;

@end

@protocol PowaPeripheralObserver <NSObject>
@optional
- (void)peripheral:(id <PowaPeripheral>)peripheral connectionStateChanged:(PowaPeripheralConnectionState)connectionState;
@end
