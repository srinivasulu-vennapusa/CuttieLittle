//
//  POWAScanner.h
//  POWAPeripheralsSDK
//
//  Created by Abel Duarte on 8/6/14.
//  Copyright (c) 2014 Powa. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PowaPeripheral.h"

@protocol PowaScanner <NSObject>
@end

@protocol PowaScannerObserver <NSObject>

@optional

/*!
 * @brief Called when the scanner finishes initializing
 * @discussion You will receive this event after calling connect on a scanner when it finishes initializing. Parts of the device info object might not be filled in prior to receiving this event. You should wait until you receive this event prior to calling methods on the scanner.
 * @param scanner the scanner that finished initializing
 * @updated 01-09-2015
 */

- (void)scannerDidFinishInitializing:(id <PowaScanner>)scanner;

/*!
 * @brief Called when the scanner connects or disconnects
 * @updated 01-09-2015
 */

- (void)scanner:(id <PowaScanner>)scanner connectionStateChanged:(PowaPeripheralConnectionState)connectionState;

/*!
 * @brief Called when the scanner scans a barcode
 * @discussion You will receive this event when the scanner scans a barcode
 * @param scanner the scanner that scanned the barcode
 * @param barcode the barcode data
 * @updated 01-09-2015
 */

- (void)scanner:(id <PowaScanner>)scanner scannedBarcodeData:(NSData *)data;

/*!
 * @brief Called when the scanner scans a barcode
 * @discussion You will receive this event when the scanner scans a barcode
 * @param scanner the scanner that scanned the barcode
 * @param barcode the barcode data as a string
 * @updated 01-09-2015
 */

- (void)scanner:(id <PowaScanner>)scanner scannedBarcode:(NSString *)barcode;


@end