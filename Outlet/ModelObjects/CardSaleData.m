//
//  CardSaleData.m
//  SleepKeeper
//
//  Created by Satish on 25/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CardSaleData.h"


@implementation CardSaleData

@synthesize mTotAmount;
@synthesize mSno, mCreditCardNo, mCardHolderName, mExpiryDate;

@synthesize mStanID, mAuthCode, mRRNo, mDate;
@synthesize mAppIdentifier,mCertif,mTVR,mTSI;
@synthesize mApplicationName;
@synthesize mF055tag, mIssuerAuthCode, mFO39Tag,mEmvCardExpdate, mSwitchCardType;
@synthesize mAmexSecurityCode,mReceiptEnabledForAutoVoid,mISEMVTrx;

- (id)init {
    if ((self = [super init])) {
       //mEmvCardExpdate = @"";
       //mExpiryDate = @"";
       mCreditCardNo = @"";
       mCardHolderName = @"";
       mTotAmount = @"";
       
       
    }
    return self;
}

@end
