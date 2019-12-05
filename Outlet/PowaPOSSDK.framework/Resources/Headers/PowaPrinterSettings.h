//
//  PowaPrinterSettings.h
//  PowaPOSSDK
//
//  Created by Abel Duarte on 4/21/15.
//  Copyright (c) 2015 Powa. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(UInt8, PowaPrinterSpeed)
{
    PowaPrinterSpeedAuto = 0x00,
    PowaPrinterSpeedFast = 0x60,
    PowaPrinterSpeedMedium = 0x73,
    PowaPrinterSpeedSlow = 0x74
};

@interface PowaPrinterSettings : NSObject
{
}

#pragma mark - Printer Setting Properties

@property (nonatomic, assign) UInt8 quality;
@property (nonatomic, assign) UInt16 leftMargin;
@property (nonatomic, assign) UInt16 area;
@property (nonatomic, assign) PowaPrinterSpeed speed;
@property (nonatomic, assign) UInt8 narrowWidth;
@property (nonatomic, assign) UInt8 wideWidth;

#pragma mark - Default Settings

/*!
 * @brief Returns a new settings object with the default printer settings
 * @discussion Returns the default settings for the printer
 * @updated 01-09-2015
 */

+ (PowaPrinterSettings *)defaultSettings;

@end
