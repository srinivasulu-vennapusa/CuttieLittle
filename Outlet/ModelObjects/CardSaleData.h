//
//  CardSaleData.h
//  mSwipe
//
//  Created by satish nalluru on 05/01/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>


@interface CardSaleData : NSObject 
{
	NSString                                    *mTotAmount;
    
    NSString                                    *mSno;
    NSString                                    *mCreditCardNo;
    NSString                                    *mCardHolderName;
    NSString                                    *mExpiryDate;
    NSString                                    *mAmexSecurityCode;
    NSString                                    *mStanID;
    NSString                                    *mAuthCode;
    NSString                                    *mRRNo;
    NSString                                    *mDate;
    
      
    NSString                                    *mAppIdentifier;
    NSString                                    *mCertif;
    NSString                                    *mTVR;
    NSString                                    *mTSI;
    NSString                                    *mApplicationName;
    
    
    NSString                                    *mF055tag;
    NSString                                    *mIssuerAuthCode;
    NSString                                    *mFO39Tag;
    
    NSString                                    *mEmvCardExpdate;
    NSString                                    *mSwitchCardType;
    
    NSString                                   *mReceiptEnabledForAutoVoid;
    BOOL mISEMVTrx;
}
@property (nonatomic, assign) BOOL                                      mISEMVTrx;

@property (nonatomic, strong) NSString                                  *mTotAmount;

@property (nonatomic, strong) NSString                                  *mSno;
@property (nonatomic, strong) NSString                                  *mCreditCardNo;
@property (nonatomic, strong) NSString                                  *mCardHolderName;
@property (nonatomic, strong) NSString                                  *mExpiryDate;

@property (nonatomic, strong) NSString                                  *mStanID;
@property (nonatomic, strong) NSString                                  *mAuthCode;
@property (nonatomic, strong) NSString                                  *mRRNo;
@property (nonatomic, strong) NSString                                  *mDate;

@property (nonatomic, strong) NSString                                  *mVoucherSale;
@property (nonatomic, strong) NSString                                  *mAppIdentifier;
@property (nonatomic, strong) NSString                                  *mCertif;
@property (nonatomic, strong) NSString                                  *mTVR;
@property (nonatomic, strong) NSString                                  *mTSI;
@property (nonatomic, strong) NSString                                  *mApplicationName;

@property (nonatomic, strong) NSString                                  *mF055tag;
@property (nonatomic, strong) NSString                                  *mIssuerAuthCode;
@property (nonatomic, strong) NSString                                  *mFO39Tag;

@property (nonatomic, strong) NSString                                  *mEmvCardExpdate;
@property (nonatomic, strong) NSString                                  *mSwitchCardType;
@property (nonatomic, strong) NSString                                  *mAmexSecurityCode;
@property (nonatomic, strong) NSString                                  *mReceiptEnabledForAutoVoid;

@end

