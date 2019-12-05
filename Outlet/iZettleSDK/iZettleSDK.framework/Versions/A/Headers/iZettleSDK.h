//
//  iZettleSDK.h
//
//  Copyright (c) 2014 iZettle. All rights reserved.

#import <UIKit/UIKit.h>


@interface iZettleSDK : NSObject

+ (iZettleSDK *)shared;

- (NSString *)sdkVersion;

- (void)startWithAPIKey:(NSString *)apiKey;


- (void)chargeAmount:(NSDecimalNumber *)amount reference:(NSString *)reference presentFromViewController:(UIViewController *)viewController completion:(void (^)(NSDictionary *paymentInfo, NSError *error))completion;



- (void)presentLoginFromViewController:(UIViewController *)viewController completion:(void (^)(NSDictionary *userInfo, NSError *error))completion;

- (void)logoutCompletion:(void (^)(NSDictionary *userInfo, NSError *error))completion;

- (void)userInfoCompletion:(void (^)(NSDictionary *userInfo, NSError *error))completion;


/*!
 Will try to abort the ongoing payment. Only use this if absolutely necessary. The state of the payment will be unknown to the SDK user after this call. 
 */
- (void)abortOngoingPayment;

@end

