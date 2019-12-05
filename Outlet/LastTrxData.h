//
//  LastTrxData.h
//  MswipeWisepadSDK
//
//  Created by satish reddy on 1/3/15.
//  Copyright (c) 2015 Mswipe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LastTrxData : NSObject
{

}


@property(nonatomic,strong) NSString* mStatus;
@property(nonatomic,strong) NSString* mTrxDate;
@property(nonatomic,strong) NSString* mAmount;
@property(nonatomic,strong) NSString* mType;
@property(nonatomic,strong) NSString* mCardHolder;
@property(nonatomic,strong) NSString* mLastFrDigits;
@property(nonatomic,strong) NSString* mStanId;
@property(nonatomic,strong) NSString* mVoucher;
@property(nonatomic,strong) NSString* mAuthCode;
@property(nonatomic,strong) NSString* mRRNo;
@property(nonatomic,strong) NSString* mTrxMsg;
@property(nonatomic,strong) NSString* mNotes;


@property(nonatomic,strong) NSString*       statusMsg;
@property(nonatomic,assign) BOOL            status;

@end
