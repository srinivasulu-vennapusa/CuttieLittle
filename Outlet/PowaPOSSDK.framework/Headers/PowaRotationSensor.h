//
//  POWARotationSensor.h
//  POWAPeripheralsSDK
//
//  Created by Abel Duarte on 8/6/14.
//  Copyright (c) 2014 Powa. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^POWATSeriesRotationSensorStateHandler)(BOOL isRotated);

@protocol PowaRotationSensor <NSObject>
@end

@protocol PowaRotationSensorObserver <NSObject>

@optional

/*!
 * @brief Called when the rotation sensor rotates
 * @discussion This event is called every time the rotation sensor rotates
 * @param rotationSensor the rotation sensor that rotated
 * @param rotated the position of the rotation sensor
 * @updated 01-09-2015
 */

- (void)rotationSensor:(id <PowaRotationSensor>)rotationSensor rotated:(BOOL)rotated;

@end
