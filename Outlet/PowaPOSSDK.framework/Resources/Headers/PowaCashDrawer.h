//
//  POWACashDrawer.h
//  POWAPeripheralsSDK
//
//  Created by Abel Duarte on 8/6/14.
//  Copyright (c) 2014 Powa. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^POWATSeriesCashDrawerStateHandler)(BOOL isOpen);

@protocol PowaCashDrawer <NSObject>

/*!
 * @brief Opens the cash drawer
 * @discussion This method opens the cash drawer
 * @updated 01-09-2015
 */

- (void)openCashDrawer;

/*!
 * @brief Requests the state of the cash drawer
 * @discussion Requests the state of the cash drawer
 * @param handler the handler block to receive the cash drawer state
 * @updated 01-09-2015
 */

- (void)requestCashDrawerStatusWithCompletionHandler:(POWATSeriesCashDrawerStateHandler)handler;

@end
