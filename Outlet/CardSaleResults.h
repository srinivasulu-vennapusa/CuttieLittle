//
//  CardSaleResults.h
//  mSwipe
//
//  Created by satish nalluru on 05/01/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>


@interface CardSaleResults : NSObject 
{
	
}
@property(nonatomic,strong) NSString*       statusMsg;
@property(nonatomic,assign) BOOL            status;

@property (nonatomic, strong) NSString                                  *mISEMVTrx;
@property (nonatomic, strong) NSString                                  *mTotAmount;


@property (nonatomic, strong) NSString                                  *mStanID;
@property (nonatomic, strong) NSString                                  *mAuthCode;
@property (nonatomic, strong) NSString                                  *mRRNo;
@property (nonatomic, strong) NSString                                  *mDate;


@property (nonatomic, strong) NSString                                  *mVoucherSale;
@property (nonatomic, strong) NSString                                  *mExpiryDate;

@property (nonatomic, strong) NSString                                  *mF055tag;
@property (nonatomic, strong) NSString                                  *mIssuerAuthCode;
@property (nonatomic, strong) NSString                                  *mFO39Tag;

@property (nonatomic, strong) NSString                                  *mEmvCardExpdate;
@property (nonatomic, strong) NSString                                  *mSwitchCardType;
@property (nonatomic, strong) NSString                                  *mReceiptEnabledForAutoVoid;

@end

