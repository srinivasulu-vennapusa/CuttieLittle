//
//  POWAPrinter.h
//  POWAPeripheralsSDK
//
//  Created by Abel Duarte on 8/6/14.
//  Copyright (c) 2014 Powa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class PowaPrinterSettings;

typedef NS_ENUM(NSUInteger, PowaPrintFormat)
{
    PowaPrintFormatReversedStart = 0,
    PowaPrintFormatReversedStop = 1,
    PowaPrintFormatUnderlinedStart = 2,
    PowaPrintFormatUnderlinedTwoStart = 3,
    PowaPrintFormatUnderlinedStop = 4,
    PowaPrintFormatRotateStart = 5,
    PowaPrintFormatRotateStop = 6,
    PowaPrintFormatUpsideDownStart = 7,
    PowaPrintFormatUpsideDownStop = 8,
    PowaPrintFormatMagnificationNone = 9,
    PowaPrintFormatMagnification2x = 10,
    PowaPrintFormatMagnification3x = 11,
    PowaPrintFormatMagnification4x = 12,
    PowaPrintFormatNone = 13
};

typedef NS_ENUM(NSUInteger, PowaFont)
{
    PowaFontAnk8X16 = 0,
    PowaFontAnk12x24 = 1,
    PowaFontAnk16x16 = 2,
    PowaFontAnk24x24 = 3,
    PowaFontAnk32x16 = 4,
    PowaFontAnk16x32 = 5,
    PowaFontAnk32x32 = 6,
    PowaFontAnk48x24 = 7,
    PowaFontAnk24x48 = 8,
    PowaFontAnk48x48 = 9
};

typedef NS_ENUM(NSUInteger, PowaCodePage)
{
    PowaCodePageUSA = 0,
    PowaCodePageFrench = 1,
    PowaCodePageGerman = 2,
    PowaCodePageUK = 3,
    PowaCodePageDenmark = 4,
    PowaCodePageSweden = 5,
    PowaCodePageItaly = 6,
    PowaCodePageSpain = 7,
    PowaCodePageJapan = 8,
    PowaCodePageNorway = 9,
    PowaCodePageDenmark2 = 10,
    PowaCodePageSpain2 = 11,
    PowaCodePageLatinAmerica = 12,
    PowaCodePageJapan2 = 13,
    PowaCodePageDefault = 14,
    PowaCodePageAdditional = 15
};

typedef NS_ENUM(UInt8, PowaBarcodeType)
{
    PowaBarcodeTypeUPCA = 65,
    PowaBarcodeTypeUPCE = 66,
    PowaBarcodeTypeJAN_EAN_13 = 67,
    PowaBarcodeTypeJAN_EAN_8 = 68,
    PowaBarcodeTypeCode39 = 69,
    PowaBarcodeTypeITF = 70,
    PowaBarcodeTypeCodaBar = 71,
    PowaBarcodeTypeUndefine = 72,
    PowaBarcodeTypeCode128_A = 73,
    PowaBarcodeTypeCode128_B = 74,
    //PowaBarcodeTypeCode128_C = 75,
};

typedef NS_ENUM(UInt8, PowaQRCodeMode)
{
    PowaQRCodeModeNumeric = 16,
    PowaQRCodeModeAlphaNumeric = 17,
    PowaQRCodeModeLatinJapanese = 18
};

typedef NS_ENUM(UInt8, PowaQRCodeErrorCorrection)
{
    PowaQRCodeErrorCorrectionHigh = 0,
    PowaQRCodeErrorCorrectionGood = 4,
    PowaQRCodeErrorCorrectionMedium = 8,
    PowaQRCodeErrorCorrectionLow = 12
};

typedef NS_ENUM(UInt8, PowaQRCodeMagnification)
{
    PowaQRCodeMagnificationTriple = 2,
    PowaQRCodeMagnificationQuadruple = 3
};

@protocol PowaPrinter <NSObject>

#pragma mark - Printer Formatting

/*!
 * @brief Sets the print format when printing
 * @discussion Sets the print format when printing
 * @param format the formatting to use when printing
 * @updated 01-09-2015
 */

- (void)setFormat:(PowaPrintFormat)format;

/*!
 * @brief Sets the font to use when printing
 * @discussion Sets the font to use when printing
 * @param font the font to use when printing
 * @updated 01-09-2015
 */

- (void)setFont:(PowaFont)font;

/*!
 * @brief Sets the code page to use when printing international characters
 * @discussion Sets the code page to use when printing international characters
 * @param codePage the code page to use with international characters
 * @updated 01-09-2015
 */

- (void)setCodePage:(PowaCodePage)codePage;

/*!
 * @brief Sets the printer settings to use when printing (quality, margins, etc)
 * @discussion Sets the printer settings to use when printing (quality, margins, etc)
 * @param settings the printer settings to use when printing
 * @updated 01-09-2015
 */

- (void)setPrinterSettings:(PowaPrinterSettings *)settings;

/*!
 * @brief Resets the printer to its original font, format, and settings
 * @discussion Resets the printer to its original font, format, and settings
 * @updated 01-09-2015
 */

- (void)resetPrinter;

#pragma mark - Receipt Buffering

/*!
 * @brief Starts a new receipt
 * @discussion Starts a new receipt queue
 * @updated 01-09-2015
 */

- (void)startReceipt;

/*!
 * @brief Makes the printer print the data inside the receipt queue
 * @discussion Prints the current receipt queue
 * @updated 01-09-2015
 */

- (void)printReceipt;

#pragma mark - Standard Printing Methods

/*!
 * @brief Prints a string of text
 * @discussion Prints a string of text
 * @param text the text to print
 * @updated 01-09-2015
 */

- (void)printText:(NSString *)text;

/*!
 * @brief Sends raw data to the printer (can be used to print or for advanced commands)
 * @discussion Sends raw data to the printer (can be used to print or for advanced commands)
 * @param data the chunk of data to send to the printer
 * @warning Using this method without consideration can overflow the printer's buffer. Some delays might be necessary when sending too much data.
 * @updated 01-09-2015
 */

- (void)printData:(NSData *)data;

/*!
 * @brief Converts an image into black and white and prints it. Image must be 576px in width and any height.
 * @discussion Converts an image into black and white and prints it. Image must be 576px in width and any height.
 * @param image the image to print
 * @updated 01-09-2015
 */

- (void)printImage:(UIImage *)image;

/*!
 * @brief Converts an image into black and white and prints it. Image must be 576px in width and any height.
 * @discussion Converts an image into black and white and prints it. Image must be 576px in width and any height.
 * @param image the image to print
 * @param threshold a value between 0.0 and 1.0 used to determine which colors to turn into black or white. Default is 0.5.
 * @updated 01-09-2015
 */

- (void)printImage:(UIImage *)image threshold:(CGFloat)threshold;

/*!
 * @brief Converts a Base64 encoded image into a black and white image for the printer to print
 * @discussion Converts an image into black and white and prints it. Image must be 576px in width and any height.
 * @param base64 the base64 encoded image to print
 * @updated 01-09-2015
 */

- (void)printImageFromBase64String:(NSString *)base64;

#pragma mark - Barcode Printing

/*!
 * @brief Prints a barcode
 * @discussion Prints a barcode
 * @updated 01-09-2015
 */


- (void)printBarcodeWithData:(NSData *)barcode type:(PowaBarcodeType)type;

/*!
 * @brief Prints a barcode
 * @discussion Prints a barcode
 * @updated 01-09-2015
 */

- (void)printBarcode:(NSString *)barcode type:(PowaBarcodeType)type;

#pragma mark - QR Code Printing

/*!
 * @brief Prints a QR code
 * @discussion Prints a QR code
 * @updated 01-09-2015
 */

- (void)printQRCodeWithData:(NSData *)data
					   mode:(PowaQRCodeMode)mode
			  magnification:(PowaQRCodeMagnification)magnification
			errorCorrection:(PowaQRCodeErrorCorrection)errorCorrection;

/*!
 * @brief Prints a QR code
 * @discussion Prints a QR code
 * @updated 01-09-2015
 */

- (void)printQRCode:(NSString *)data
			   mode:(PowaQRCodeMode)mode
	  magnification:(PowaQRCodeMagnification)magnification
	errorCorrection:(PowaQRCodeErrorCorrection)errorCorrection;

@end

@protocol PowaPrinterObserver <NSObject>
@end
