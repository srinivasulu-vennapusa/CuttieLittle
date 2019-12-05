//
//  NSObject+MswipeWisepadController.h
//  MswipeWisepadSDK
//
//  Created by satish reddy on 12/29/14.
//  Copyright (c) 2014 Mswipe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WisePadController.h"

typedef enum {
    MCRCardResults_SWIPERESULTSOK =0,
    MCRCardResults_PIN_REQUIRED =1,
    MCRCardResults_USE_CHIPCARD = 2 ,
    MCRCardResults_BAD_SWIPE = 4 ,
    MCRCardResults_AMEX_CARD = 8,
    
    
} MCRCardResults;


@protocol MswiepWisePadControllerDelegate <NSObject>

-(void) onResponseMswipeControllerResults :(id) obj;


@end

@interface MswipeWisepadController : NSObject
{

}
-(NSString*) getDeviceId;
+ (id)sharedInstance;

-(void) processLoginAuthentication :(NSString*) stUserId stPassord:(NSString*) stPassword
    responsehadnler:(id) responsehadnler;

-(void) processLastTrxStatus :(NSString*) merchantID sessionToken:(NSString*) sessionToken
    responsehadnler:(id) responsehadnler;
-(void) processResendReceipt :(NSString*) merchantID sessionToken:(NSString*) sessionToken
    trxAmount:(NSString*) trxAmount cardLast4Digits :(NSString*) cardLast4Digits
    stanId :(NSString*) stanId
    responsehadnler:(id) responsehadnler;

-(void) processChangePassword:(NSString*) merchantID sessionToken:(NSString*) sessionToken
            password: (NSString*)password newPassword : (NSString*) newPassword
            responsehadnler:(id) responsehadnler;
 
        
-(void) processCardSale_MCR:(NSString*)merchantID sessionToken:(NSString*) sessionToken 
    receipt:(NSString*) receipt
    phoneNo : (NSString*) phoneNo email :(NSString*) email
    notes:(NSString*) notes amount :(NSString*) amount
    amexCardPinCode:(NSString*) amexCardPinCode responsehadnler:(id) responsehadnler;

-(void) processCardSale_EMV:(NSString*)merchantID sessionToken:(NSString*) sessionToken receipt:(NSString*) receipt
    phoneNo : (NSString*) phoneNo email :(NSString*) email
    notes:(NSString*) notes amount :(NSString*) amount responsehadnler:(id) responsehadnler;

-(void) processReversalSale:(NSString*)merchantID sessionToken:(NSString*) sessionToken 
trxAmount:(NSString*) trxAmount trxDate:(NSString*) trxDate stanid:(NSString*) stanid 
F055tag:(NSString*) F055tag responsehadnler:(id) responsehadnler;


-(void) processSignature:(NSString*)merchantID sessionToken:(NSString*) sessionToken 
signatureData:(NSData*) signatureData creditCardNo:(NSString*) creditCardNo
standId :(NSString*) standId trxAmount :(NSString*) trxAmount TSI :(NSString*) TSI
TVR:(NSString*) TVR responsehadnler:(id)responsehadnler;

-(MCRCardResults) processMCRCardResults:(WisePadCheckCardResult)result cardDataDict:(NSDictionary *)cardDataDict;
-(void) processPinEntryResult:(WisePadPinEntryResult)result epb:(NSString *)epb ksn:(NSString *)ksn;
-(NSDictionary*) processOnRequestOnlineProcess:(NSString*)tlv;
-(NSDictionary*) processOnReturnBatchData:(NSString*)tlv;
-(void) processOnReturnTransactionResult:(WisePadTransactionResult)result data:(NSDictionary *)data;


@end
