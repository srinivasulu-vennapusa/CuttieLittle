//
//  PowaFirmwareInfo.h
//  PowaPOSSDK
//
//  Created by Abel Duarte on 5/21/15.
//  Copyright (c) 2015 Powa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PowaFirmwareInfo : NSObject
{
}

#pragma mark - Firmware Information Properties

@property (nonatomic, retain) NSString *version;
@property (nonatomic, retain) NSString *versionInfo;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *updateFile;
@property (nonatomic, retain) NSString *md5;

@end
