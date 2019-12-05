//
//  PowaReceiptBuilder.h
//  PowaPOSSDK
//
//  Created by Abel Duarte on 2/25/15.
//  Copyright (c) 2015 Powa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PowaReceiptBuilder : NSObject
{
}

/*!
 * @brief Adds text to the receipt
 * @discussion Adds text to the receipt
 * @updated 01-09-2015
 */

- (void)addText:(NSString *)text alignment:(NSTextAlignment)alignment font:(UIFont *)font;

/*!
 * @brief Adds an image to the receipt
 * @discussion Adds an image to the receipt
 * @updated 01-09-2015
 */

- (void)addImage:(UIImage *)image;

/*!
 * @brief Adds a base64 encoded image to the receipt
 * @discussion Adds a base64 encoded image to the receipt
 * @updated 01-09-2015
 */

- (void)addBase64Image:(NSString *)base64;

/*!
 * @brief Returns a receipt image that can be printed with the printImage method
 * @discussion Returns a receipt image that can be printed with the printImage method
 * @updated 01-09-2015
 */

- (UIImage *)receiptImage;

/*!
 * @brief Resets the receipt builder so it can be reused
 * @discussion Resets the receipt builder so it can be reused
 * @updated 01-09-2015
 */

- (void)reset;

@end
