//
//  PowaScannerInfo.h
//  PowaPOSSDK
//
//  Created by Abel Duarte on 8/15/14.
//  Copyright (c) 2014 Powa. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PowaDeviceInfo.h"

@interface PowaScannerInfo : PowaDeviceInfo
{
}

@property (nonatomic, retain) NSString *macAddress;
@property (nonatomic, retain) NSString *manufacturingDate;

@end
