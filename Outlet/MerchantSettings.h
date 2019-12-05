//
//  MerchantSettings.h
//  MswipeWisepadSDK
//
//  Created by satish reddy on 12/29/14.
//  Copyright (c) 2014 Mswipe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MerchantSettings :NSObject 
{
}
@property(nonatomic,strong) NSString*       mSessionToken;
@property(nonatomic,strong) NSString*       mFirstName;
@property(nonatomic,strong) NSString*       mCurrencyDenominator;
@property(nonatomic,strong) NSString*       isFirstTimeLogin;
@property(nonatomic,strong) NSString*       isReceiptRequired;
@property(nonatomic,strong) NSString*       mMerchantId;
@property(nonatomic,assign) BOOL            status;
@property(nonatomic,strong) NSString*       statusMsg;








@end
