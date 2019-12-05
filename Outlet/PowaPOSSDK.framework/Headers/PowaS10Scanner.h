//
//  POWAS10Scanner.h
//  POWAPeripheralsSDK
//
//  Created by Abel Duarte on 8/7/14.
//  Copyright (c) 2014 Powa. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "POWAScanner.h"
#import "POWAPeripheral.h"

@class EAAccessory;

enum
{
	PowaS10ScannerBeepShort1BeepHigh = 0x00,
	PowaS10ScannerBeepShort2BeepHigh = 0x01,
	PowaS10ScannerBeepShort3BeepHigh = 0x02,
	PowaS10ScannerBeepShort4BeepHigh = 0x03,
	PowaS10ScannerBeepShort5BeepHigh = 0x04,
	PowaS10ScannerBeepShort1BeepLow = 0x05,
	PowaS10ScannerBeepShort2BeepLow = 0x06,
	PowaS10ScannerBeepShort3BeepLow = 0x07,
	PowaS10ScannerBeepShort4BeepLow = 0x08,
	PowaS10ScannerBeepShort5BeepLow = 0x09,
	PowaS10ScannerBeepLong1BeepHigh = 0x0A,
	PowaS10ScannerBeepLong2BeepHigh = 0x0B,
	PowaS10ScannerBeepLong3BeepHigh = 0x0C,
	PowaS10ScannerBeepLong4BeepHigh = 0x0D,
	PowaS10ScannerBeepLong5BeepHigh = 0x0E,
	PowaS10ScannerBeepLong1BeepLow = 0x0F,
	PowaS10ScannerBeepLong2BeepLow = 0x10,
	PowaS10ScannerBeepLong3BeepLow = 0x11,
	PowaS10ScannerBeepLong4BeepLow = 0x12,
	PowaS10ScannerBeepLong5BeepLow = 0x13,
	PowaS10ScannerBeepFastWarbleBeep4HiLoHiLo = 0x14,
	PowaS10ScannerBeepSlowWarbleBeep4HiLoHiLo = 0x15,
	PowaS10ScannerBeepMix1Beep2HiLo = 0x16,
	PowaS10ScannerBeepMix2Beep2LoHi = 0x17,
	PowaS10ScannerBeepMix3Beep3HiLoHi = 0x18,
	PowaS10ScannerBeepMix4Beep3LoHiLo = 0x19
};
typedef NSUInteger PowaS10ScannerBeep;

@interface PowaS10Scanner : NSObject <PowaPeripheral, PowaScanner>
{
}

#pragma mark - Scanner Properties

@property (nonatomic, readonly) CGFloat percentCharge;

#pragma mark - Initializers

/*!
 * @brief Initiates a new PowaS10Scanner
 * @discussion Initiates a PowaS10Scanner using an accessory object
 * @return returns a newly initialized PowaS10Scanner
 * @updated 01-09-2015
 */

- (id)initWithAccessory:(EAAccessory *)accessory;

#pragma mark - AutoScan

/*!
 * @brief Sets the scanner to always be scanning if on
 * @discussion Starts autoscan
 * @param autoscan Set to yes to start autoscan else set to no
 * @updated 01-09-2015
 */

- (void)setScannerAutoScan:(BOOL)autoscan;

#pragma mark - Beep

/*!
 * @brief Makes the scanner beep with the specified sound
 * @discussion Beeps
 * @param beep the sound to use when beeping
 * @updated 01-09-2015
 */

- (void)beep:(PowaS10ScannerBeep)beep;

@end
