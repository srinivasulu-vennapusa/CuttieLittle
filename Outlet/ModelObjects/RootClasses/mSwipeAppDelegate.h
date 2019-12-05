//
//  mSwipeAppDelegate.h
//  mSwipe
//
//  Created by satish nalluru on 05/01/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonCryptor.h>
@class MerchantSettings;
@class CardSaleResults;
@class CardSaleData;
@interface mSwipeAppDelegate : NSObject <UIApplicationDelegate> 
{
    
    UINavigationController                      *uiNavigationController;
    
    
}

@property (nonatomic, strong)  UIWindow                                 *window;
@property (nonatomic, strong)  UINavigationController                   *uiNavigationController;
@property (nonatomic, strong)  MerchantSettings                         *mMerchantSettings;
@property (nonatomic, strong)  CardSaleResults                          *mCardSaleResults;
@property (nonatomic, strong)  CardSaleData                             *mCardSaleData;

- (void) showMainMenuScreen : (id) sender;

@end
