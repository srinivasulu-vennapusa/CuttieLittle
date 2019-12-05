//
//  CommonServices.m
//  OmniRetailer
//
//  Created by MACPC on 8/10/15.
//
//

#import "CommonServices.h"
#import "SkuServiceSvc.h"
#import "Global.h"
#import "DealServicesSvc.h"
#import "RequestHeader.h"

@implementation CommonServices

-(NSString *)getSkuDetails:(NSString *)skuId {
    SkuServiceSoapBinding *skuService = [[SkuServiceSvc SkuServiceSoapBinding] ];
    
    SkuServiceSvc_getSkuDetails *getSkuid = [[SkuServiceSvc_getSkuDetails alloc] init];
    
    
    
    NSError * err_;
    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:[RequestHeader getRequestHeader] options:0 error:&err_];
    NSString * requestHeaderString_ = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
    
    NSArray *keys = [NSArray arrayWithObjects:@"skuId",@"requestHeader",@"storeLocation", nil];
    NSArray *objects = [NSArray arrayWithObjects:skuId,requestHeaderString_,presentLocation, nil];
    
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err];
    NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    getSkuid.skuID = salesReportJsonString;
    @try {
        
        SkuServiceSoapBindingResponse *response = [skuService getSkuDetailsUsingParameters:(SkuServiceSvc_getSkuDetails *)getSkuid];
        if (![response.error isKindOfClass:[NSError class]]) {
            
            NSArray *responseBodyParts = response.bodyParts;
            for (id bodyPart in responseBodyParts) {
                if ([bodyPart isKindOfClass:[SkuServiceSvc_getSkuDetailsResponse class]]) {
                    SkuServiceSvc_getSkuDetailsResponse *body = (SkuServiceSvc_getSkuDetailsResponse *)bodyPart;
                    printf("\nresponse=%s",[body.return_ UTF8String]);
                    
                    return body.return_;
                    
                }
            }
        }
        else {
            return [response.error localizedDescription];
        }
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
    }

    
    
}

-(NSString *) callOffersForScanning:(NSString *)skuid qty:(NSString *)quantity total:(NSString *)total itemPrice:(NSString *)item_price{
    
    // [HUD setHidden:NO];
    
    //Play Audio for button touch....
    
    
    DealServicesSoapBinding *deals = [DealServicesSvc DealServicesSoapBinding];
    DealServicesSvc_applyDealsAndOffers *applyDeals = [[DealServicesSvc_applyDealsAndOffers alloc]init];
    
    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"storeLocation",@"requestHeader",@"quantity",@"totalBillAmount",@"sku_id",@"item_total_price", nil];
    
    NSArray *loyaltyObjects = [NSArray arrayWithObjects:presentLocation,[RequestHeader getRequestHeader],quantity,total,skuid,item_price, nil];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
    
    NSError * err_;
    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
    NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
    
    applyDeals.dealDetails = loyaltyString;
    
    NSDictionary *JSON1 = [[NSDictionary alloc]init];
    
    @try {
        
        DealServicesSoapBindingResponse *response = [deals applyDealsAndOffersUsingParameters:applyDeals];
        
        if (![response.error isKindOfClass:[NSError class]]) {
            
            NSArray *responseBodyParts1 = response.bodyParts;
            
            for (id bodyPart in responseBodyParts1) {
                
                if ([bodyPart isKindOfClass:[DealServicesSvc_applyDealsAndOffersResponse class]]) {
                    
                    DealServicesSvc_applyDealsAndOffersResponse *body = (DealServicesSvc_applyDealsAndOffersResponse *)bodyPart;
                    printf("\nresponse=%s",[body.return_ UTF8String]);
                    
                    NSError *e;
                    JSON1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                            options: NSJSONReadingMutableContainers
                                                              error: &e];
                    return body.return_;
                    
                }
            }
        }
        
        else {
            
            return [response.error localizedDescription];
        }

        
        
    }
    @catch (NSException *exception) {
       
        NSLog(@"%@",exception);
        
    }
    
}

@end
