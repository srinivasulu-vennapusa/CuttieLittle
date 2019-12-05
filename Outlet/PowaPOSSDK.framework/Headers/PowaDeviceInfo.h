//
//  PowaDeviceInfo.h
//  PowaPOSSDK
//
//  Created by Abel Duarte on 8/15/14.
//  Copyright (c) 2014 Powa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PowaDeviceInfo : NSObject
{
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *manufacturer;
@property (nonatomic, retain) NSString *modelNumber;
@property (nonatomic, retain) NSString *serialNumber;
@property (nonatomic, retain) NSString *firmwareVersion;
@property (nonatomic, retain) NSString *hardwareVersion;
@property (nonatomic, retain) NSArray *protocolStrings;

@end
