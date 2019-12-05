// 
//  WebServiceController.m
//  SampleWebServices
//
//  Created by Chandrasekhar on 9/1/15.
//  Copyright (c) 2015 Technolabs. All rights reserved.
//

#import "WebServiceController.h"
#import "RequestHeader.h"
#import "Global.h"
#import "DepartmentServiceSvc.h"
#import "BrandMasterServiceSvc.h"
#import "UtilityMasterServiceSvc.h"

//added by Bhargav on 24/05/2017....

#import "StoreStockVerificationServiceSvc.h"
#import "SalesServiceSvc.h"
#import "OfferServiceSvc.h"
#import "StoreServiceSvc.h"

//upto here on 24/05/2017....

#import "StoreTaxationService.h"
#import "OfflineBillingServices.h"

#import "GiftVoucherServices.h"
#import "GiftCouponServicesSvc.h"
#import "LoyaltycardServiceSvc.h"

@implementation WebServiceController

@synthesize createBillingDelegate,updateBillingDelegate,getBillsDelegate,getSkuDetailsDelegate,getDealsAndOffersDelegate,returningBillDelegate,searchProductDelegate,skuServiceDelegate,exchangingBillDelegate,getAllDealsDelegate,getStockDetailsByFilterDelegate,getStockLedgerReportDelegate,employeeServiceDelegate,customerWalkoutDelegate,outletMasterDelegate,getScrapStockDelegate,getMessageBoardDelegate,stockIssueDelegate,stockReturnDelegate,stockReceiptDelegate,getSizeAndColorsDelegate,searchDealsDelegate,productGroupMasterDelegate,utilityMasterDelegate,warehouseGoodsReceipNoteServiceDelegate,zoneMasterDelegate,storeStockVerificationDelegate,purchaseOrderSvcDelegate,modelMasterDelegate,getCategoriesDelegate,stockVerificationDelegate,bomMasterSvcDelegate,stockMovementDelegate,productMasterDelegate,DenominationDelegate,storeTaxationDelegate,rolesServiceDelegate,salesServiceDelegate,customerServiceDelegate,giftVoucherServicesDelegate,giftCouponServicesDelegate,loyaltycardServicesDelegate,outletGRNServiceDelegate,shipmentReturnDelegate,getOrderDelegate,offerMasterDelegate,outletOrderServiceDelegate,storeServiceDelegate,menuServiceDelegate,getAllOffersDelegate,dayOpenServiceDelegate,appSettingServicesDelegate,memberServiceDelegate,roleServiceDelegate,restaurantBookingServiceDelegate,fbOrderServiceDelegate,getMenuServiceDelegate,outletServiceDelegate,kotServiceDelegate,giftVoucherSrvcDelegate,routingServiceDelegate, loyaltyCardServcDelegate, giftCouponServcDelegate,voucherServiceDelegate;//storeStockVerificationServiceDelegate

-(void)createBillWithData:(NSData *)requestString {
    
	    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:CREATE_BILLING_WITH_BODY];
        serviceUrl = [NSString stringWithFormat:@"%@",serviceUrl];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        request.HTTPBody = requestString;
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 
                 //added by Srinivasulu on 01/02/2018....
//                 NSDictionary * billingResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                 
//                 NSDictionary * billingResponseLocDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                 NSMutableDictionary * billingResponse = [[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL] mutableCopy];

//                 if( ([billingResponse.allKeys containsObject:RESPONSE_HEADER] && ![[billingResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]] && billingResponse != nil))
//                 if([billingResponse.allKeys containsObject:RESPONSE_HEADER]  && ([[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue] != 0))
//                     if(([[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE] caseInsensitiveCompare:DUPLICATE_BILL_ID_RESOPNSE_FROM_SERVICES] == NSOrderedSame) || ([[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue] == -DUPLICATE_BILL_ID_RESOPNSE_CODE)){
//
////                         NSString * billingRequestStr = [[NSString alloc] initWithData:requestString encoding:NSUTF8StringEncoding];
//                         NSDictionary * billingRequestDic = [NSJSONSerialization JSONObjectWithData:requestString options:0 error:NULL];
//
//                         if( [billingRequestDic.allKeys containsObject:kSerialBillId] &&  ![[billingRequestDic valueForKey:kSerialBillId]  isKindOfClass: [NSNull class]])
//                                [billingResponse setValue:[billingRequestDic valueForKey:kSerialBillId] forKey:BILL_ID];
//
//                         NSMutableDictionary  *dic = [[billingResponse valueForKey:RESPONSE_HEADER] mutableCopy];
//                         [dic setValue:@"0" forKey:RESPONSE_CODE];
//
//                         [billingResponse setValue:dic forKey:RESPONSE_HEADER];
//
//                     }
                 
                 
                 //chagned on 18/09/2018....
                 if( ([billingResponse.allKeys containsObject:RESPONSE_HEADER] && ![[billingResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]] && billingResponse != nil)){
                     if([billingResponse.allKeys containsObject:RESPONSE_HEADER]  && ([[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue] != 0)){
                         if(([[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE] caseInsensitiveCompare:DUPLICATE_BILL_ID_RESOPNSE_FROM_SERVICES] == NSOrderedSame) || ([[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue] == -DUPLICATE_BILL_ID_RESOPNSE_CODE)){
                             
                             //                         NSString * billingRequestStr = [[NSString alloc] initWithData:requestString encoding:NSUTF8StringEncoding];
                             NSDictionary * billingRequestDic = [NSJSONSerialization JSONObjectWithData:requestString options:0 error:NULL];
                             
                             if( [billingRequestDic.allKeys containsObject:kSerialBillId] &&  ![[billingRequestDic valueForKey:kSerialBillId]  isKindOfClass: [NSNull class]])
                                 [billingResponse setValue:[billingRequestDic valueForKey:kSerialBillId] forKey:BILL_ID];
                             
                             NSMutableDictionary  *dic = [[billingResponse valueForKey:RESPONSE_HEADER] mutableCopy];
                             [dic setValue:@"0" forKey:RESPONSE_CODE];
                             
                             [billingResponse setValue:dic forKey:RESPONSE_HEADER];
                             
                         }
                         
                         
                     }
                     else if([billingResponse.allKeys containsObject:RESPONSE_HEADER]  && ([[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue] == 0) && isToSaveOnlineBill){
                         
                         //                         NSString * billingRequestStr = [[NSString alloc] initWithData:requestString encoding:NSUTF8StringEncoding];dueAmount
                         NSMutableDictionary * billingRequestDic = [[NSJSONSerialization JSONObjectWithData:requestString options:0 error:NULL] mutableCopy];
                         
                         NSString * billIdStr = [billingResponse valueForKey:BILL_ID];
                         //STANDARD_BILL_ID
                         
                         if( [billingRequestDic.allKeys containsObject:STANDARD_BILL_ID] &&  ![[billingRequestDic valueForKey:STANDARD_BILL_ID]  isKindOfClass: [NSNull class]])
                             billIdStr = [billingResponse valueForKey:STANDARD_BILL_ID];
                         
                         [billingRequestDic setValue:billIdStr  forKey:BILL_ID];
                         [billingRequestDic setValue:SUCCESS  forKey:SYNC_STATUS];
                         [billingRequestDic setValue:@"0"  forKey:IS_OFFLINE_BILL];
                         
                         
                         NSError * err;
                         NSData * jsonData = [NSJSONSerialization dataWithJSONObject:billingRequestDic options:0 error:&err];
                         NSString * createBillingJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                         
                         OfflineBillingServices * offline = [[OfflineBillingServices alloc]init];
                         NSString *result = [offline createBilling:createBillingJsonString isToGenerateBillID:false];
                         //                         NSString *result = [offline updateBilling:[billingResponse valueForKey:BILL_ID] bill_details:billingRequestDic due:[billingResponse valueForKey:BILL_DUE]];
                         
                         if(result.length){}
                         
                     }
                 }
                 
                 //upto here on 18/09/2018....
                 //upto here on 01/02/2018....
                 
                 
                 [self.createBillingDelegate createBillingSuccessResponse:billingResponse];
             }
             else {
                 NSLog(@"%@",connectionError.localizedDescription);
                 [self.createBillingDelegate createBillingErrorResponse];
             }
         }];

    } @catch (NSException *exception) {
        
        [self.createBillingDelegate createBillingErrorResponse];
    } @finally {
        
    }
}

-(void)updateBillWithData:(NSData *)requestString {
    
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:UPDATE_BILLING_WITH_BODY];
        serviceUrl = [NSString stringWithFormat:@"%@",serviceUrl];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        request.HTTPBody = requestString;
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *billingResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                 options:0
                                                                                   error:NULL];
                 
                 
                 //added by Srinivasulu on 18/09/2018....
                 if( ([billingResponse.allKeys containsObject:RESPONSE_HEADER] && ![[billingResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]] && billingResponse != nil) && isToSaveOnlineBill){

                     if([billingResponse.allKeys containsObject:RESPONSE_HEADER]  && ([[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue] == 0)){

                         NSMutableDictionary * billingRequestDic = [[NSJSONSerialization JSONObjectWithData:requestString options:0 error:NULL] mutableCopy];
                         [billingRequestDic setValue:[billingResponse valueForKey:BILL_ID]  forKey:BILL_ID];
                         [billingRequestDic setValue:SUCCESS  forKey:SYNC_STATUS];
                         [billingRequestDic setValue:@"0"  forKey:IS_OFFLINE_BILL];

                         OfflineBillingServices * offline = [[OfflineBillingServices alloc]init];
                         NSString *result = [offline updateBilling:[billingResponse valueForKey:BILL_ID] bill_details:billingRequestDic due:[billingResponse valueForKey:BILL_DUE]];

                         if(result.length){}

                     }
                 }

                 //upto here on 18/09/2018....
                 
                 
                 
                 [self.updateBillingDelegate updateBillingSuccessResponse:billingResponse];
             }
             else {
                 [self.updateBillingDelegate updateBillingErrorResponse];
             }
         }];

    } @catch (NSException *exception) {
        
        [self.updateBillingDelegate updateBillingErrorResponse];
        NSLog(@"%@",exception);
        
    } @finally {
        
        
    }
    
}

-(void)returnBillWithData:(NSString *)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:RETURN_BILLING];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                         timeoutInterval:60.0];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *billingResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:0
                                                                               error:NULL];
             
             //added by Srinivasulu on 18/09/2018....
             if( ([billingResponse.allKeys containsObject:RESPONSE_HEADER] && ![[billingResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]] && billingResponse != nil) && isToSaveOnlineBill){

                 if([billingResponse.allKeys containsObject:RESPONSE_HEADER]  && ([[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue] == 0)){

                     NSData * simpleData =  [requestString dataUsingEncoding:NSUTF8StringEncoding];

                     NSMutableDictionary * billingRequestDic = [[NSJSONSerialization JSONObjectWithData:simpleData options:0 error:NULL] mutableCopy];

                     OfflineBillingServices * offlineService = [[OfflineBillingServices alloc]init];

                     BOOL exchangeItemStatus = [offlineService saveReturnedItems:[billingRequestDic valueForKey:BILL_RETURN_ITEMS] bill_id:[billingRequestDic valueForKey:BILL_ID]];
                     if (exchangeItemStatus) {

                         [offlineService updateBillingStatus:[billingRequestDic valueForKey:BILL_STATUS] billId:[billingRequestDic valueForKey:BILL_ID]];

                         if ([[billingRequestDic allKeys] containsObject:BILLING_TRANSACTIONS] && ![[billingRequestDic valueForKey:BILLING_TRANSACTIONS] isKindOfClass:[NSNull class]]) {
                             if([[billingRequestDic valueForKey:BILLING_TRANSACTIONS] count]){
                                 NSDictionary * dic = @{BILLING_TRANSACTIONS: [billingRequestDic valueForKey:BILLING_TRANSACTIONS]};
                                 [offlineService saveTransactionsTemp:[billingRequestDic valueForKey:BILL_ID] transactionDetails:dic];
                             }
                         }
                         
                         
                         if([billingResponse.allKeys containsObject:Credit_Note] && ![[billingResponse valueForKey:Credit_Note]  isKindOfClass: [NSNull class]]){
                            
//                             NSMutableDictionary * transDic = [NSMutableDictionary new];
//
//                             NSString * phoneNumberStr = [self checkGivenValueIsNullOrNil:[billingRequestDic valueForKey:PHONE_NUMBER] defaultReturn:@""];
//                             float  creditNoteAmount = [[self checkGivenValueIsNullOrNil:[billingRequestDic valueForKey:CREDIT_AMOUNT] defaultReturn:@"0.00"] floatValue];
//                             NSString * creditRemarkStr = [self checkGivenValueIsNullOrNil:[billingRequestDic valueForKey:CREDIT_REMARKS] defaultReturn:@""];
//
//                             NSString * dateStr = [self checkGivenValueIsNullOrNil:[billingResponse valueForKey:DATE] defaultReturn:@""];
//                             int  noteStatus = [[self checkGivenValueIsNullOrNil:[billingResponse valueForKey:PHONE_NUMBER] defaultReturn:@"0"] intValue];
//                             NSString * storeLocationStr = [self checkGivenValueIsNullOrNil:[billingResponse valueForKey:STORELOCATION] defaultReturn:presentLocation];
//                             NSString * conterIdStr = [self checkGivenValueIsNullOrNil:[billingResponse valueForKey:COUNTER] defaultReturn:counterName];
//                             NSString * customerIdStr = [self checkGivenValueIsNullOrNil:[billingResponse valueForKey:CUSTOMER_ID] defaultReturn:custID];
//
//                             float  balnceAmount = [[self checkGivenValueIsNullOrNil:[billingResponse valueForKey:BALANCE_AMT] defaultReturn:@"0.00"] floatValue];
//
//                             NSString * expireDateStr = [self checkGivenValueIsNullOrNil:[billingResponse valueForKey:EXPIRY_DATE] defaultReturn:@""];
//
//
//                             [transDic setValue:[billingResponse valueForKey:CREDIT_NOTE_NO] forKey:CREDIT_NOTE_NO];
//                             [transDic setValue:[billingRequestDic valueForKey:BILL_ID] forKey:CARD_INFO];
//                             [transDic setValue:phoneNumberStr forKey:CARD_INFO];
//                             [transDic setValue:[NSNumber numberWithFloat:creditNoteAmount] forKey:CREDIT_AMOUNT];
//                             [transDic setValue:creditRemarkStr forKey:CREDIT_REMARKS];
//                             [transDic setValue:dateStr forKey:DATE];
//                             [transDic setValue:[NSNumber numberWithInt:noteStatus] forKey:STATUS];
//                             [transDic setValue:storeLocationStr forKey:STORELOCATION];
//                             [transDic setValue:conterIdStr forKey:COUNTER];
//                             [transDic setValue:customerIdStr forKey:CUSTOMER_ID];
//                             [transDic setValue:[NSNumber numberWithFloat:balnceAmount] forKey:BALANCE_AMT];
//                             [transDic setValue:expireDateStr forKey:EXPIRY_DATE];
//
                             NSArray * tempArr = [NSArray arrayWithObjects:[billingResponse valueForKey:Credit_Note], nil];
                             
                             [offlineService saveCreditNoteInfo:tempArr];
                         }
                         
                         
                     }
                 }
             }
             
             //upto here on 18/09/2018....
             
             [self.returningBillDelegate returnBillingSuccessResponse:billingResponse];
         }
         else {
             [self.returningBillDelegate returnBillingErrorResponse];
         }
     }];
    
}
-(void)exchangeBillWithData:(NSString *)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:Exchange_BILLING];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                         timeoutInterval:60.0];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *billingResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:0
                                                                               error:NULL];
             
             
             //added by Srinivasulu on 18/09/2018....
             if( ([billingResponse.allKeys containsObject:RESPONSE_HEADER] && ![[billingResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]] && billingResponse != nil) && isToSaveOnlineBill){

                 if([billingResponse.allKeys containsObject:RESPONSE_HEADER]  && ([[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue] == 0)){

                    NSData * simpleData =  [requestString dataUsingEncoding:NSUTF8StringEncoding] ;

                     NSMutableDictionary * billingRequestDic = [[NSJSONSerialization JSONObjectWithData:simpleData options:0 error:NULL] mutableCopy];

                     OfflineBillingServices * offlineService = [[OfflineBillingServices alloc]init];

                     BOOL exchangeItemStatus = [offlineService saveExchangedItems:[billingRequestDic valueForKey:BILL_EXCHANGED_ITEMS] bill_id:[billingRequestDic valueForKey:BILL_ID]];
                     if (exchangeItemStatus) {

                         [offlineService updateBillingStatus:[billingRequestDic valueForKey:BILL_STATUS] billId:[billingRequestDic valueForKey:BILL_ID]];
                     }
                     
                     
                     if([billingResponse.allKeys containsObject:CREDIT_NOTE_NO] && ![[billingResponse valueForKey:CREDIT_NOTE_NO]  isKindOfClass: [NSNull class]]){
                         
//                         NSMutableDictionary * transDic = [NSMutableDictionary new];
//
//                         NSString * phoneNumberStr = [self checkGivenValueIsNullOrNil:[billingRequestDic valueForKey:PHONE_NUMBER] defaultReturn:@""];
//                         float  creditNoteAmount = [[self checkGivenValueIsNullOrNil:[billingRequestDic valueForKey:CREDIT_AMOUNT] defaultReturn:@"0.00"] floatValue];
//                         NSString * creditRemarkStr = [self checkGivenValueIsNullOrNil:[billingRequestDic valueForKey:CREDIT_REMARKS] defaultReturn:@""];
//
//                         NSString * dateStr = [self checkGivenValueIsNullOrNil:[billingResponse valueForKey:DATE] defaultReturn:@""];
//                         int  noteStatus = [[self checkGivenValueIsNullOrNil:[billingResponse valueForKey:PHONE_NUMBER] defaultReturn:@"0"] intValue];
//                         NSString * storeLocationStr = [self checkGivenValueIsNullOrNil:[billingResponse valueForKey:STORELOCATION] defaultReturn:presentLocation];
//                         NSString * conterIdStr = [self checkGivenValueIsNullOrNil:[billingResponse valueForKey:COUNTER] defaultReturn:counterName];
//                         NSString * customerIdStr = [self checkGivenValueIsNullOrNil:[billingResponse valueForKey:CUSTOMER_ID] defaultReturn:custID];
//
//                         float  balnceAmount = [[self checkGivenValueIsNullOrNil:[billingResponse valueForKey:BAL_AMOUNT] defaultReturn:@"0.00"] floatValue];
//
//                         NSString * expireDateStr = [self checkGivenValueIsNullOrNil:[billingResponse valueForKey:EXPIRY_DATE] defaultReturn:@""];
//
//
//                         [transDic setValue:[billingResponse valueForKey:CREDIT_NOTE_NO] forKey:CREDIT_NOTE_NO];
//                         [transDic setValue:[billingRequestDic valueForKey:BILL_ID] forKey:CARD_INFO];
//                         [transDic setValue:phoneNumberStr forKey:CARD_INFO];
//                         [transDic setValue:[NSNumber numberWithFloat:creditNoteAmount] forKey:CREDIT_AMOUNT];
//                         [transDic setValue:creditRemarkStr forKey:CREDIT_REMARKS];
//                         [transDic setValue:dateStr forKey:DATE];
//                         [transDic setValue:[NSNumber numberWithInt:noteStatus] forKey:STATUS];
//                         [transDic setValue:storeLocationStr forKey:STORELOCATION];
//                         [transDic setValue:conterIdStr forKey:COUNTER];
//                         [transDic setValue:customerIdStr forKey:CUSTOMER_ID];
//                         [transDic setValue:[NSNumber numberWithFloat:balnceAmount] forKey:BAL_AMOUNT];
//                         [transDic setValue:expireDateStr forKey:EXPIRY_DATE];
                         
                         
                         NSArray * tempArr = [NSArray arrayWithObjects:[billingResponse valueForKey:Credit_Note], nil];

                         [offlineService saveCreditNoteInfo:tempArr];
                     }

                 }
             }
             
             //upto here on 18/09/2018....
             
             
             [self.exchangingBillDelegate exchangeBillingSuccessResponse:billingResponse];
         }
         else {
             [self.exchangingBillDelegate exchangeBillingErrorResponse];
         }
     }];
    
}

- (void)getStockDetailsByFilter:(NSString *)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_STOCK_DETAILS_BY_FILTER];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                         timeoutInterval:60.0];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *billingResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:0
                                                                               error:NULL];
             
             [self.getStockDetailsByFilterDelegate getStockDetailsByFilterSuccessResponse:billingResponse];
         }
         else {
             [self.getStockDetailsByFilterDelegate getStockDetailsByFilterErrorResponse];
         }
     }];

}

- (void)getStockLedgerReport:(NSString *)requestString {
    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_STOCK_LEDGER_REPORT];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                         timeoutInterval:60.0];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     
     
     
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *billingResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:0
                                                                               error:NULL];
             
             [self.getStockLedgerReportDelegate getStockLedgerReportSuccessResponse:billingResponse];
         }
         else {
             [self.getStockLedgerReportDelegate getStockLedgerReportErrorResponse];
         }
     }];

}

- (void)getScrapStockDetails:(NSString *)requestString {
    
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_SCRAP_STOCK_DETAILS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        NSLog(@"%@",[NSDate date]);
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSLog(@"%@",[NSDate date]);

                 NSDictionary *billingResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                 options:0
                                                                                   error:NULL];
                 if ([[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     
                     [self.getScrapStockDelegate getScrapStockSuccessResponse:billingResponse];
                 }
                 else {
                     [self.getScrapStockDelegate getScrapStockErrorResponse:[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.getScrapStockDelegate getScrapStockErrorResponse:@""];
             }
         }];

    } @catch (NSException *exception) {

        NSLog(@"%@",exception);
        
    } @finally {
        
        
    }

}

//commented on 17/02/2017.. because this method is change recently regards to requestment in deals view by bhargav..

//-(void)getAllDealsWithData:(NSString *)requestString {
//    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_ALL_DEALS];
//    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
//    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
//
//    NSURL *url = [NSURL URLWithString:serviceUrl];
//    NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
//                                                         timeoutInterval:60.0];
//    [request setHTTPMethod: @"GET"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [request setValue:[NSString stringWithFormat:@"%lu", [[serviceUrl dataUsingEncoding:NSUTF8StringEncoding] length]] forHTTPHeaderField:@"Content-Length"];
//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:[NSOperationQueue mainQueue]
//                           completionHandler:^(NSURLResponse *response,
//                                               NSData *data, NSError *connectionError)
//     {
//         if (data.length > 0 && connectionError == nil)
//         {
//             NSDictionary *billingResponse = [NSJSONSerialization JSONObjectWithData:data
//                                                                             options:0
//                                                                               error:NULL];
//             if ([[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
//
//
//             [self.getAllDealsDelegate getAllDealsSuccessResponse:billingResponse];
//             }
//             else {
//                 [self.getAllDealsDelegate getAllDealsErrorResponse];
//             }
//         }
//         else {
//             [self.getAllDealsDelegate getAllDealsErrorResponse];
//         }
//     }];
//}

-(void)searchDealsWithData:(NSString *)requestString {
    NSString *serviceUrl = [WebServiceUtility getURLFor:SEARCH_DEALS];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                         timeoutInterval:60.0];
    request.HTTPMethod = @"GET";
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *billingResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:0
                                                                               error:NULL];
             if ([[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                 
                 
                 [self.searchDealsDelegate searchDealsSuccessResponse:billingResponse];
             }
             else {
                 [self.searchDealsDelegate searchDealsErrorResponse];
             }
         }
         else {
             [self.searchDealsDelegate searchDealsErrorResponse];
         }
     }];
}

-(void)searchProductsWithData:(NSString *)requestString {
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:SEARCH_PRODUCTS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                            timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *billingResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                 options:0
                                                                                   error:NULL];
                 if ([billingResponse.allKeys containsObject:RESPONSE_HEADER] && ![[billingResponse valueForKey:RESPONSE_HEADER] isKindOfClass:[NSNull class]] && [[[billingResponse valueForKey:RESPONSE_HEADER] allKeys] containsObject:RESPONSE_CODE] && ![[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] isKindOfClass:[NSNull class]] && [[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     [self.searchProductDelegate searchProductsSuccessResponse:billingResponse];
                 }
                 else {
                     [self.searchProductDelegate searchProductsErrorResponse];
                 }
             }
             else {
                 [self.searchProductDelegate searchProductsErrorResponse];
             }
         }];

    }
    @catch (NSException *exception) {
        [self.searchProductDelegate searchProductsErrorResponse];
    }
    @finally {
        
    }
    
}

/**
 * @description   here we are calling the getSkuDetails for getting item details....
 * @date
 * @method        getSkuDetailsWithData:
 * @author
 * @param         NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 * @modified By  Srinivasulu
 * @reason       new key has to be added which has to added in every service call..... this change has t o be removed....
 *
 *
 */


-(void)getSkuDetailsWithData:(NSString *)requestString {
    
    @try {
        
        //added by Srinivasulu on 07/06/2017....
        //reason to change new key was addeed......
        //it has to be added in calling page itself...
        
        NSMutableDictionary * reqDic = [[NSJSONSerialization JSONObjectWithData:[requestString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL] mutableCopy];
        
        reqDic[ZERO_STOCK_CHECK_AT_OUTLET_LEVEL] = @(zeroStockCheckAtOutletLevel);
        
        reqDic[SCAN_CODE] = @1;

        
//        if([barcodeTypeStr caseInsensitiveCompare:@"sku id"] == NSOrderedSame){
//
//            [reqDic setObject:[NSNumber numberWithInteger:1] forKey:SCAN_CODE];
//        }
//        else
        
        if([barcodeTypeStr caseInsensitiveCompare:@"ean"] == NSOrderedSame){
            
            reqDic[SCAN_CODE] = @2;
        }
        else if([barcodeTypeStr caseInsensitiveCompare:@"both"] == NSOrderedSame){
            
            reqDic[SCAN_CODE] = @3;
        }

        //else {
//
//[reqDic setObject:[NSNumber numberWithInteger:1] forKey:SCAN_CODE];
//}
        

        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
        requestString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        //upto here on 07/06/2017....
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_SKU_DETAILS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                            timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *billingResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                 options:0
                                                                                   error:NULL];

                 if( ([billingResponse.allKeys containsObject:RESPONSE_HEADER] && [[billingResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (billingResponse == nil)){
                     
                     [self.getSkuDetailsDelegate getSkuDetailsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else  if ([[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.getSkuDetailsDelegate getSkuDetailsSuccessResponse:billingResponse];
                 }
                 else {
                     [self.getSkuDetailsDelegate getSkuDetailsErrorResponse:[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.getSkuDetailsDelegate getSkuDetailsErrorResponse:@"Product Not Available"];
             }
         }];
    } @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
        [self.getSkuDetailsDelegate getSkuDetailsErrorResponse:@"Product Not Available"];

    } @finally {
        
    }
}

-(void)getDealsAndOffersWithData:(NSString *)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:APPLY_CAMPAIGNS];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                        timeoutInterval:60.0];
    request.HTTPMethod = @"GET";
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *billingResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:0
                                                                               error:NULL];
             
             if ([[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                 
                 [self.getDealsAndOffersDelegate getDealsAndOffersSuccessResponse:billingResponse];
             }
             else {

                 [self.getDealsAndOffersDelegate getDealsAndOffersErrorResponse];
             }
         }
         else {
             [self.getDealsAndOffersDelegate getDealsAndOffersErrorResponse];
         }
     }];
    
}


-(void)getBills:(int)startIndex deliveryType:(NSString *)deliveryType status:(NSString *)status{
    
    __block NSDictionary *JSON = [NSDictionary new];
    
    
    @try {
        
        //changing by Srinivasulu on 08/07/2017....
        //undo by Srinivasulu on10/07/2017.... reason service modification are done....

        NSMutableDictionary *orderDetails = [NSMutableDictionary dictionaryWithObjects:@[[RequestHeader getRequestHeader],[NSString stringWithFormat:@"%d",startIndex],presentLocation,deliveryType,status,@(isCustomerBillId),THIRTEEN] forKeys:@[REQUEST_HEADER,START_INDEX,STORE_LOCATION,DELIVERY_TYPE,STATUS,kCustomerBillId,MAX_RECORDS]];
        
//        NSMutableDictionary *orderDetails = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[RequestHeader getRequestHeader],[NSString stringWithFormat:@"%d",startIndex],presentLocation,deliveryType,status,[NSNumber numberWithBool:false], nil] forKeys:[NSArray arrayWithObjects:REQUEST_HEADER,START_INDEX,STORE_LOCATION,DELIVERY_TYPE,STATUS,kCustomerBillId, nil]];

        //upto here on 08/07/2017....

        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:orderDetails options:0 error:&err];
        NSString * orderJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_BILLS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,orderJsonString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 JSON = [NSJSONSerialization JSONObjectWithData:data
                                                        options:0
                                                          error:NULL];
//                 NSLog(@"response :%@",JSON);
             }
             else {
                 NSLog(@"Error %@",connectionError.localizedDescription);
                 
             }
             if (JSON.count) {
                 
                 if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.getBillsDelegate getBillsSuccesResponse:JSON];
                     
                 }
                 else {
                     [self.getBillsDelegate getBillsFailureResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             
             else {
                 
                 [self.getBillsDelegate getBillsFailureResponse:connectionError.localizedDescription];
             }
         }];
        
        
    }
    @catch (NSException *exception) {
        
        [self.getBillsDelegate getBillsFailureResponse:exception.description];
        
    }
    
}
-(void)getBillIds:(int)startIndex deliveryType:(NSString *)deliveryType status:(NSString *)status searchCriteria:(NSString *)searchCriteria{
    
    __block NSDictionary *JSON = [NSDictionary new];
    
    
    @try {
        
        //changing by Srinivasulu on 08/07/2017....
        //undo by Srinivasulu on10/07/2017.... reason service modification are done....

        NSMutableDictionary *orderDetails = [NSMutableDictionary dictionaryWithObjects:@[[RequestHeader getRequestHeader],[NSString stringWithFormat:@"%d",startIndex],presentLocation,deliveryType,status,searchCriteria,@(isCustomerBillId)] forKeys:@[REQUEST_HEADER,START_INDEX,STORE_LOCATION,DELIVERY_TYPE,STATUS,BILL_ID,kCustomerBillId]];
        
//        NSMutableDictionary *orderDetails = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[RequestHeader getRequestHeader],[NSString stringWithFormat:@"%d",startIndex],presentLocation,deliveryType,status,searchCriteria,[NSNumber numberWithBool:false], nil] forKeys:[NSArray arrayWithObjects:REQUEST_HEADER,START_INDEX,STORE_LOCATION,DELIVERY_TYPE,STATUS,BILL_ID,kCustomerBillId, nil]];

        
        //changing by Srinivasulu on 08/07/2017....

        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:orderDetails options:0 error:&err];
        NSString * getIdsJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_BILL_ID];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,getIdsJson];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:60.0];
        
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%ld", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 JSON = [NSJSONSerialization JSONObjectWithData:data
                                                        options:0
                                                          error:NULL];
//                 NSLog(@"response :%@",JSON);
             }
             else {
                 NSLog(@"Error %@",connectionError.localizedDescription);
                 
             }
             if (JSON.count) {
                 
                 if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.getBillsDelegate getBillIdsSuccessResponse:JSON];
                     
                 }
                 else {
                     [self.getBillsDelegate getBillsFailureResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             
             else {
                 
                 [self.getBillsDelegate getBillsFailureResponse:connectionError.localizedDescription];
             }
         }];
        
        
    }
    @catch (NSException *exception) {
        
        [self.getBillsDelegate getBillsFailureResponse:exception.description];
        
    }
    
}
-(void)getBillDetails:(NSString *)billId {
    
    __block NSDictionary *JSON = [NSDictionary new];
    
    
    @try {
//        NSMutableDictionary *orderDetails = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[RequestHeader getRequestHeader],billId,[NSNumber numberWithBool:isCustomerBillId], nil] forKeys:[NSArray arrayWithObjects:REQUEST_HEADER,BILL_ID,kCustomerBillId, nil]];
        
        //printResponseRequired
       
        //changed by Srinivasulu on 08/07/2017....
        //undo by Srinivasulu on10/07/2017.... reason service modification are done....

        NSMutableDictionary *orderDetails = [NSMutableDictionary dictionaryWithObjects:@[[RequestHeader getRequestHeader],billId,@(isCustomerBillId),@YES] forKeys:@[REQUEST_HEADER,BILL_ID,kCustomerBillId,@"printResponseRequired"]];

        //upto here on 08/07/2017....
        
        
//        NSMutableDictionary *orderDetails = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[RequestHeader getRequestHeader],billId,[NSNumber numberWithBool:false],[NSNumber numberWithBool:YES], nil] forKeys:[NSArray arrayWithObjects:REQUEST_HEADER,BILL_ID,kCustomerBillId,@"printResponseRequired", nil]];

        
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:orderDetails options:0 error:&err];
        NSString * orderJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_BILL_DETAILS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,orderJsonString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 JSON = [NSJSONSerialization JSONObjectWithData:data
                                                        options:0
                                                          error:NULL];
//                 NSLog(@"response :%@",JSON);
                 
             }
             else {
                 NSLog(@"Error %@",connectionError.localizedDescription);
                 
             }
             if (JSON.count) {
                 
                 if ([[[JSON valueForKey:RESPONSE_HEADER] allKeys] containsObject:RESPONSE_CODE] && ![[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] isKindOfClass:[NSNull class]] && [[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.getBillsDelegate getBillDetailsSuccesResponse:JSON];
                     
                 }
                 else {
                     [self.getBillsDelegate getBillsFailureResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             
             else {
                 
                 [self.getBillsDelegate getBillsFailureResponse:connectionError.localizedDescription];
             }
         }];
        
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"Exception %@",exception);
    }
    
}

-(void)getDuplicateBillDetails:(NSString *)billId {
    
    __block NSDictionary *JSON = [NSDictionary new];
    
    
    @try {
        //        NSMutableDictionary *orderDetails = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[RequestHeader getRequestHeader],billId,[NSNumber numberWithBool:isCustomerBillId], nil] forKeys:[NSArray arrayWithObjects:REQUEST_HEADER,BILL_ID,kCustomerBillId, nil]];
        
        //printResponseRequired
        
        //changed by Srinivasulu on 08/07/2017....
        //undo by Srinivasulu on10/07/2017.... reason service modification are done....
        
        NSMutableDictionary *orderDetails = [NSMutableDictionary dictionaryWithObjects:@[[RequestHeader getRequestHeader],billId,[NSNumber numberWithBool:true],@YES] forKeys:@[REQUEST_HEADER,BILL_ID,kCustomerBillId,@"printResponseRequired"]];
        
        //upto here on 08/07/2017....
        
        
        //        NSMutableDictionary *orderDetails = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[RequestHeader getRequestHeader],billId,[NSNumber numberWithBool:false],[NSNumber numberWithBool:YES], nil] forKeys:[NSArray arrayWithObjects:REQUEST_HEADER,BILL_ID,kCustomerBillId,@"printResponseRequired", nil]];
        
        
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:orderDetails options:0 error:&err];
        NSString * orderJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_BILL_DETAILS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,orderJsonString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 JSON = [NSJSONSerialization JSONObjectWithData:data
                                                        options:0
                                                          error:NULL];
//                 NSLog(@"response :%@",JSON);
                 
             }
             else {
                 NSLog(@"Error %@",connectionError.localizedDescription);
                 
             }
             if (JSON.count) {
                 
                 if ([[[JSON valueForKey:RESPONSE_HEADER] allKeys] containsObject:RESPONSE_CODE] && ![[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] isKindOfClass:[NSNull class]] && [[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.getBillsDelegate getBillDetailsSuccesResponse:JSON];
                     
                 }
                 else {
                     [self.getBillsDelegate getBillsFailureResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             
             else {
                 
                 [self.getBillsDelegate getBillsFailureResponse:connectionError.localizedDescription];
             }
         }];
        
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"Exception %@",exception);
    }
    
}

-(BOOL)getSkuDetails:(NSString *)requestParam {
    
    BOOL status = false;
    
    @try {
        
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_SKU_DETAILS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestParam];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        //  [NSURLConnection sendAsynchronousRequest:request
        //                                           queue:[NSOperationQueue mainQueue]
        //                               completionHandler:^(NSURLResponse *response,
        //                                                   NSData *data, NSError *connectionError)
        //{
        if (data.length > 0 && connectionError == nil)
        {
            NSError *err;
            
            NSDictionary *JSON  = [NSJSONSerialization JSONObjectWithData:data
                                                                  options:kNilOptions
                                                                    error:&err];
            
            
            if (JSON.count) {
                
                if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                    
                 status =  [self.skuServiceDelegate getSkuDetailsSuccessResponse:JSON];
                    
                }
                else {
                    status = [self.skuServiceDelegate getSkuDetailsFailureResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                    NSLog(@"sku becomes false in downloading producst");
                }
            }
            else {
                status = [self.skuServiceDelegate getSkuDetailsFailureResponse:@""];
                NSLog(@"sku becomes false in due to empty response");

            }
            
        }
        
        else {
            
            status = [self.skuServiceDelegate getSkuDetailsFailureResponse:connectionError.localizedDescription];
            NSLog(@"sku becomes false in due to connection error");

        }
        //         }];
        
        
    }
    @catch (NSException *exception) {
        
        //added by Srinivasulu on 03/07/2017....
        
        status = [self.skuServiceDelegate getSkuDetailsFailureResponse:exception.description];

        //upto here on 03/07/2017....
        
        
        NSLog(@"Exception %@",exception);
    }
    
    return status;
}
-(BOOL)getPriceList:(NSString *)requestParam {
    
    BOOL status = FALSE;
    @try {
        
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_PRICE_LIST];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestParam];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  * request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        //        [NSURLConnection sendAsynchronousRequest:request
        //                                           queue:[NSOperationQueue mainQueue]
        //                               completionHandler:^(NSURLResponse *response,
        //                                                   NSData *data, NSError *connectionError)
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        //         {
        if (data.length > 0 && connectionError == nil)
        {
            NSError *err;
            
            NSDictionary *JSON  = [NSJSONSerialization JSONObjectWithData:data
                                                                  options:kNilOptions
                                                                    error:&err];
            
            
            if (JSON.count) {
                
                if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                    
                  status =  [self.skuServiceDelegate getPriceListSuccessResponse:JSON];
                    
                }
                else {
                    NSLog(@"%@",JSON);
                    status = [self.skuServiceDelegate getSkuDetailsFailureResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                    NSLog(@"skuprice becomes false in downloading products");

                }
            }
            else {
                status = [self.skuServiceDelegate getSkuDetailsFailureResponse:@""];
                NSLog(@"skuprice becomes false in due to empty response");
            }
            
        }
        
        else {
            
            status = [self.skuServiceDelegate getSkuDetailsFailureResponse:connectionError.localizedDescription];
            NSLog(@"skuprice becomes false in due to connection error");

        }
        //         }];
        
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"Exception %@",exception);
    }
    
}

-(BOOL)getSkuEans:(NSString *)requestParam {
    
    BOOL status = false;
    
    @try {
        
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_SKU_EANS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestParam];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        if (data.length > 0 && connectionError == nil)
        {
            NSError *err;
            
            NSDictionary *JSON  = [NSJSONSerialization JSONObjectWithData:data
                                                                  options:kNilOptions
                                                                    error:&err];
            
            
            if (JSON.count) {
                
                if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                    
                    status =  [self.skuServiceDelegate getSkuEanssSuccessResponse:JSON];
                    
                }
                else {
                    NSLog(@"%@",JSON);
                    status = [self.skuServiceDelegate getSkuEansErrorResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                    NSLog(@"sku becomes false in downloading producst");
                }
            }
            else {
                status = [self.skuServiceDelegate getSkuEansErrorResponse:@""];
                NSLog(@"sku becomes false in due to empty response");
                
            }
            
        }
        
        else {
            
            status = [self.skuServiceDelegate getSkuEansErrorResponse:connectionError.localizedDescription];
            NSLog(@"sku becomes false in due to connection error");
            
        }
        //         }];
        
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"Exception %@",exception);
    }
    
    return status;
}

-(void)getProductGroupMaster:(NSString *)requestParam {
    
    
    @try {
        
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_PRODUCT_GROUPS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestParam];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        if (data.length > 0 && connectionError == nil)
        {
            NSError *err;
            
            NSDictionary *JSON  = [NSJSONSerialization JSONObjectWithData:data
                                                                  options:kNilOptions
                                                                    error:&err];
            
            
            if (JSON.count) {
                
                if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                    
                    [self.productGroupMasterDelegate productGroupMasterSuccessResponse:JSON];
                    
                }
                else {
                    [self.productGroupMasterDelegate productGroupMasterErrorResponse];
                }
            }
            else {
                [self.productGroupMasterDelegate productGroupMasterErrorResponse];
            }
            
        }
        
        else {
            
            [self.productGroupMasterDelegate productGroupMasterErrorResponse];
            
        }
        //         }];
        
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"Exception %@",exception);
    }
    
}


// Commented by roja on 17/10/2019.. // reason :- getEmployeeMaster: method contains SOAP Service call .. so taken new method with same name(getEmployeeMaster:) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//-(BOOL)getEmployeeMaster:(NSString *)requestParam {
//
//    BOOL status = false;
//
//    @try {
//
//        EmployeesSoapBinding *custBindng =  [EmployeesSvc EmployeesSoapBinding] ;
//        EmployeesSvc_getEmployees *aParameters = [[EmployeesSvc_getEmployees alloc] init];
//
//
//        aParameters.employeeDetails = requestParam;
//
//
//        EmployeesSoapBindingResponse *response = [custBindng getEmployeesUsingParameters:(EmployeesSvc_getEmployees *)aParameters];
//        NSArray *responseBodyParts = response.bodyParts;
//        for (id bodyPart in responseBodyParts) {
//            if ([bodyPart isKindOfClass:[EmployeesSvc_getEmployeesResponse class]]) {
//                EmployeesSvc_getEmployeesResponse *body = (EmployeesSvc_getEmployeesResponse *)bodyPart;
////                printf("\nresponse=%s",[body.return_ UTF8String]);
//                NSError *e;
//
//                NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                      options: NSJSONReadingMutableContainers
//                                                                        error: &e];
//
//                NSDictionary *dictionary = [JSON1 valueForKey:RESPONSE_HEADER];
//                if ([[dictionary valueForKey:RESPONSE_CODE] intValue] == 0) {
//
//                    status =  [employeeServiceDelegate getEmployeeDetailsSucessResponse:JSON1];
//
//                }
//                else {
//                    status = [employeeServiceDelegate getEmployeeErrorResponse:[[JSON1 valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
//
//                }
//
//            }
//            else {
//                status = [employeeServiceDelegate getEmployeeErrorResponse:@""];
//
//            }
//        }
//    }
//    @catch (NSException *exception) {
//
//        NSLog(@"%@",exception);
//    }
//    @finally {
//
//    }
//
//    return status;
//}


//added by bhargav

-(void)createCustomerWalkOutWithData:(NSData *)reqData{
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:CREATE_CUSTOMER_WALKOUT];
        serviceUrl = [NSString stringWithFormat:@"%@",serviceUrl];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = reqData;
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *walkOutResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                 options:0
                                                                                   error:NULL];
                 if ([[[walkOutResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     
                     [self.customerWalkoutDelegate CreateCustomerWalkOutSuccessResponse:walkOutResponse];
                 }
                 else {
                     [self.customerWalkoutDelegate createCustomerWalkOutErrorResponse:[[walkOutResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.customerWalkoutDelegate createCustomerWalkOutErrorResponse:@""];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.customerWalkoutDelegate createCustomerWalkOutErrorResponse:exception.description];
    }
    
}

/**
 * @description
 * @date
 * @method
 * @author
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 * @modified By  Srinivasulu on 10/06/2017....
 * @reason       addded the response null handling....
 *
 */

- (void)getCustomerWalkout:(NSString *)requestString {
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_CUSTOMER_WALKOUT];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * walkoutResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                 options:0
                                                                                   error:NULL];
                 
                 if( ([walkoutResponse.allKeys containsObject:walkoutResponse] && [[walkoutResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (walkoutResponse == nil)){
                     
                     [self.customerWalkoutDelegate getCustomerWalkOutErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                     
                 }
                 
                 else  if ([[[walkoutResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     
                     [self.customerWalkoutDelegate getCustomerWalkOutSuccessResponse:walkoutResponse];
                 }
                 else {
                     [self.customerWalkoutDelegate getCustomerWalkOutErrorResponse:[[walkoutResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.customerWalkoutDelegate getCustomerWalkOutErrorResponse:@"unable_to_process_your_request"];
             }
         }];
        
    }
    @catch (NSException *exception) {
        [self.customerWalkoutDelegate getCustomerWalkOutErrorResponse:exception.description];
        
        
    }
    @finally {
        
    }
    
    
}

/**
 * @description
 * @date
 * @method
 * @author
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 * @modified By  Srinivasulu on 10/06/2017....
 * @reason       addded the response null handling....
 *
 */

// Commented by roja on 17/10/2019.. // reason :- getProductCategory: method contains SOAP Service call .. so taken new method with same name(getProductCategory:) method name which contains REST service call....
// At the time of converting SOAP call's to REST


//-(void)getProductCategory:(NSString *)requestStirng {
//
//    @try {
//        UtilityMasterServiceSoapBinding *utility =  [UtilityMasterServiceSvc UtilityMasterServiceSoapBinding];
//        utility.logXMLInOut = YES;
//
//        UtilityMasterServiceSvc_getCategories *category = [[UtilityMasterServiceSvc_getCategories alloc] init];
//
//        category.userId = requestStirng;
//
//
//        UtilityMasterServiceSoapBindingResponse *response = [utility getCategoriesUsingParameters:category];
//
//
//        if (![response.error isKindOfClass:[NSError class]]) {
//            NSArray *responseBodyparts = response.bodyParts;
//
//
//            if (responseBodyparts != nil) {
//                for (id bodyPart in responseBodyparts) {
//                    if ([bodyPart isKindOfClass:[UtilityMasterServiceSvc_getCategoriesResponse class]]) {
//                        UtilityMasterServiceSvc_getCategoriesResponse *body = (UtilityMasterServiceSvc_getCategoriesResponse *)bodyPart;
//                        // NSLog(@"response = %@",body.return_);
//                        NSError *e;
//
//                        NSDictionary * JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                             options: NSJSONReadingMutableContainers
//                                                                               error: &e];
//
//
//
//                        if( ([JSON.allKeys containsObject:RESPONSE_HEADER] && [[JSON valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (JSON == nil)){
//
//                            [self.outletMasterDelegate getCategoryErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
//
//                        }
//
//                        else  if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue]==0) {
//
//                            [self.outletMasterDelegate getCategorySuccessResponse:JSON];
//
//                        }
//                        else{
//                            [self.outletMasterDelegate getCategoryErrorResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
//
//                        }
//
//                    }
//                    else {
//                        [self.outletMasterDelegate getCategoryErrorResponse:@"unable_to_process_your_request"];
//                    }
//                }
//
//            }
//            else
//                [self.outletMasterDelegate getCategoryErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
//        }
//        else{
//
//            [self.outletMasterDelegate getCategoryErrorResponse:response.error.localizedDescription];
//        }
//
//    }
//    @catch (NSException *exception) {
//
//        [self.outletMasterDelegate getCategoryErrorResponse:exception.description];
//
//    }
//}



/**
 * @description
 * @date
 * @method
 * @author
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 * @modified By  Srinivasulu on 10/06/2017....
 * @reason       addded the response null handling....
 *
 */

// Commented by roja on 17/10/2019.. // reason :- getDepartmentList: method contains SOAP Service call .. so taken new method with same name(getDepartmentList) method name which contains REST service call....
// At the time of converting SOAP call's to REST


//-(void)getDepartmentList:(NSString *)requestStirng {
//
//    @try {
//        DepartmentServiceSoapBinding * department  = [DepartmentServiceSvc DepartmentServiceSoapBinding];
//
//        department.logXMLInOut = YES;
//
//        DepartmentServiceSvc_getDepartments * list = [[DepartmentServiceSvc_getDepartments alloc ]init];
//
//        list.departmentDetails = requestStirng;
//
//        DepartmentServiceSoapBindingResponse *response = [department getDepartmentsUsingParameters:list];
//        if (![response.error isKindOfClass:[NSError class]]) {
//            NSArray *responseBodyparts = response.bodyParts;
//
//
//            if (responseBodyparts != nil) {
//                for (id bodyPart in responseBodyparts) {
//                    if ([bodyPart isKindOfClass:[DepartmentServiceSvc_getDepartmentsResponse class]]) {
//                        DepartmentServiceSvc_getDepartmentsResponse *body = (DepartmentServiceSvc_getDepartmentsResponse *)bodyPart;
//                        // NSLog(@"response = %@",body.return_);
//                        NSError *e;
//
//                        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                             options: NSJSONReadingMutableContainers
//                                                                               error: &e];
//
//
//                        if( ([JSON.allKeys containsObject:RESPONSE_HEADER] && [[JSON valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (JSON == nil)){
//
//                            [self.outletMasterDelegate getDepartmentErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
//
//                        }
//
//                        else if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue]==0) {
//
//                            [self.outletMasterDelegate getDepartmentSuccessResponse:JSON];
//                        }
//                        else{
//                            [self.outletMasterDelegate getDepartmentErrorResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
//
//                        }
//
//                    }
//                }
//
//            }
//            else
//                [self.outletMasterDelegate getDepartmentErrorResponse:NSLocalizedString(@"request_time_out", nil)];
//        }
//        else{
//
//            [self.outletMasterDelegate getDepartmentErrorResponse:response.error.localizedDescription];
//        }
//
//
//
//    }
//    @catch (NSException *exception) {
//        [self.outletMasterDelegate getDepartmentErrorResponse:exception.description];
//
//    }
//    @finally {
//
//    }
//}

/**
 * @description
 * @date
 * @method
 * @author
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 * @modified By  Srinivasulu on 10/06/2017....
 * @reason       addded the response null handling....
 *
 */

// Commented by roja on 17/10/2019.. // reason :- getBrandList: method contains SOAP Service call .. so taken new method with same name(getBrandList:) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//-(void)getBrandList:(NSString *)requestStirng {
//
//    @try {
//
//        BrandMasterServiceSoapBinding * brand = [BrandMasterServiceSvc BrandMasterServiceSoapBinding];
//        brand.logXMLInOut = YES;
//
//        BrandMasterServiceSvc_getBrand * List = [[BrandMasterServiceSvc_getBrand alloc ]init ];
//
//        List.getBrands = requestStirng;
//
//        BrandMasterServiceSoapBindingResponse * response = [brand getBrandUsingParameters:List];
//
//        if (![response.error isKindOfClass:[NSError class]]) {
//            NSArray *responseBodyparts = response.bodyParts;
//
//
//            if (responseBodyparts != nil) {
//                for (id bodyPart in responseBodyparts) {
//                    if ([bodyPart isKindOfClass:[BrandMasterServiceSvc_getBrandResponse class]]) {
//                        BrandMasterServiceSvc_getBrandResponse *body = (BrandMasterServiceSvc_getBrandResponse *)bodyPart;
//                        // NSLog(@"response = %@",body.return_);
//                        NSError *e;
//
//                        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                             options: NSJSONReadingMutableContainers
//                                                                               error: &e];
//
//                        if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue]==0) {
//                            [self.outletMasterDelegate getBrandMasterSuccessResponse:JSON];
//
//                        }
//                        else{
//                            [self.outletMasterDelegate getBrandMasterErrorResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
//
//                        }
//
//                    }
//                }
//
//            }
//            else
//                [self.outletMasterDelegate getBrandMasterErrorResponse:NSLocalizedString(@"request_time_out", nil)];
//        }
//        else{
//
//            [self.outletMasterDelegate getBrandMasterErrorResponse:response.error.localizedDescription];
//        }
//
//
//    }
//    @catch (NSException *exception) {
//        [self.outletMasterDelegate getBrandMasterErrorResponse:exception.description];
//
//    }
//
//}

-(void)searchBills:(NSString *)requestString {
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:SEARCH_BILLS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        //        [request setHTTPBody:requestData];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *searchResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                options:0
                                                                                  error:NULL];
                 
                 NSLog(@"service Response%@",searchResponse);
                 
                 if( ([searchResponse.allKeys containsObject:RESPONSE_HEADER] && [[searchResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (searchResponse == nil)){
                     
                     [self.getBillsDelegate searchBillsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                     
                 }
                 else if ([[[searchResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     
                     [self.getBillsDelegate searchBillsSuccesssResponse:searchResponse];
                 }
                 else {
                     [self.getBillsDelegate searchBillsErrorResponse:[[searchResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.getBillsDelegate searchBillsErrorResponse:@"unable_to_process_your_request"];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.getBillsDelegate searchBillsErrorResponse:exception.description];
    }
    
}


-(void)getAllStockRequest:(NSString *)requestString{
    
    
    // RestFullCall.........
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_STOCK_REQUESTS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * stockRequestResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                      options:0
                                                                                        error:NULL];
                 
                 if( ([stockRequestResponse.allKeys containsObject:RESPONSE_HEADER] && [[stockRequestResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (stockRequestResponse == nil)){
                     
                     [self.stockRequestDelegate getStockRequestsErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                     
                 }
                 
                 else  if ([[[stockRequestResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.stockRequestDelegate getStockRequestsSuccessResponse:stockRequestResponse];
                 }
                 else {
                     [self.stockRequestDelegate getStockRequestsErrorResponse:[[stockRequestResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.stockRequestDelegate getStockRequestsErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException *exception) {
        [self.stockRequestDelegate getStockRequestsErrorResponse:exception.description];
        
    }
    
}
/**
 * @description
 * @date
 * @method
 * @author
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified By  Srinivasulu on 01/06/2017....
 * @reason       added the comments and added code to check nill
 *
 */


-(void)createStockRequest:(NSString *)requestString  {
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:CREATE_STOCK_REQUEST];
        serviceUrl = [NSString stringWithFormat:@"%@",serviceUrl];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
 
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%ld", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * customerResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                  options:0
                                                                                    error:NULL];
                 
                 
                 if( ([customerResponse.allKeys containsObject:RESPONSE_HEADER] && [[customerResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (customerResponse == nil)){
                     
                     [self.stockRequestDelegate createStockRequestsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                     
                 }
                 else  if ([[[customerResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     
                     [self.stockRequestDelegate createStockRequestsSuccessResponse:customerResponse];
                 }
                 else {
                     [self.stockRequestDelegate createStockRequestsErrorResponse:[[customerResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.stockRequestDelegate createStockRequestsErrorResponse:@""];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.stockRequestDelegate createStockRequestsErrorResponse:exception.description];
    }
    
}


/**
 * @description   here we are calling the updateStockRequest to update the items....
 * @date
 * @method        updateStockRequest:
 * @author
 * @param         NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 * @modified By
 * @reason
 *
 *
 */


-(void)updateStockRequest:(NSData *)requestData {
    
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:UPDATE_STOCK_REQUEST];
        serviceUrl = [NSString stringWithFormat:@"%@",serviceUrl];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = requestData;
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData * data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *customerResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                  options:0
                                                                                    error:NULL];
                 NSLog(@"-- service Call------%@",customerResponse);
                 
                 if( ( [customerResponse.allKeys containsObject:RESPONSE_HEADER] && [[customerResponse valueForKey:RESPONSE_HEADER] isKindOfClass:[NSNull class]] ) || (customerResponse == nil) ) {
                     
                     [self.stockRequestDelegate updateStockRequestsErrorResponse:NSLocalizedString(@"unable_to_process_your_request" , nil)];
                 }
                 
                 else if ( [[[customerResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue] == 0 ) {
                     
                     [self.stockRequestDelegate updateStockRequestsSuccessResponse:customerResponse];
                 }
                 else {
                     
                     [self.stockRequestDelegate updateStockRequestsErrorResponse:[[customerResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.stockRequestDelegate updateStockRequestsErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.stockRequestDelegate updateStockRequestsErrorResponse:exception.description];
    }
    @finally {
        
    }
}



// Commented by roja on 17/10/2019.. // reason :- getAllLocationDetailsData: method contains SOAP Service call .. so taken new method with same name(getAllLocationDetailsData:) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//-(void)getAllLocationDetailsData:(NSString *)requestStirng {
//
//    @try {
//
//        UtilityMasterServiceSoapBinding *utility =  [UtilityMasterServiceSvc UtilityMasterServiceSoapBinding];
//
//        UtilityMasterServiceSvc_getLocation *location1 = [[UtilityMasterServiceSvc_getLocation alloc] init];
//        location1.locationDetails = requestStirng;
//
//
//        UtilityMasterServiceSoapBindingResponse *response = [utility getLocationUsingParameters:location1];
//
//
//        if (![response.error isKindOfClass:[NSError class]]) {
//            NSArray *responseBodyparts = response.bodyParts;
//
//
//            if (responseBodyparts != nil) {
//                for (id bodyPart in responseBodyparts) {
//                    if ([bodyPart isKindOfClass:[UtilityMasterServiceSvc_getLocationResponse class]]) {
//                        UtilityMasterServiceSvc_getLocationResponse *body = (UtilityMasterServiceSvc_getLocationResponse *)bodyPart;
//                        // NSLog(@"response = %@",body.return_);
//                        NSError *e;
//                        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                             options: NSJSONReadingMutableContainers
//                                                                               error: &e];
//
//                        if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue]==0) {
//                            [self.utilityMasterDelegate getLocationSuccessResponse:JSON];
//
//                        }
//                        else{
//                            [self.utilityMasterDelegate getLocationErrorResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
//                        }
//
//                    }
//                }
//
//            }
//            else
//                [self.utilityMasterDelegate getLocationErrorResponse:NSLocalizedString(@"request_time_out", nil)];
//        }
//        else{
//
//            [self.utilityMasterDelegate getLocationErrorResponse:response.error.localizedDescription];
//        }
//
//    } @catch (NSException *exception) {
//
//    } @finally {
//
//    }
//
//}



- (void)getMessageBoardDetails:(NSString *)requestString
{
    @try {
        
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_MESSAGE_BOARD_DETAILS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
//        NSError *connectionError=nil;
//        NSURLResponse *response=nil;
//        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
        {
        
        if (data.length > 0 && connectionError == nil)
        {
            NSError *err;
            
            NSDictionary *JSON  = [NSJSONSerialization JSONObjectWithData:data
                                                                  options:kNilOptions
                                                                    error:&err];
            
            
            if (JSON.count) {
                
                if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                    
                    [self.getMessageBoardDelegate getMessageBoardSuccessResponse:JSON];
                    
                }
                else {
                    [self.getMessageBoardDelegate getMessageBoardErrorResponse];
                    
                }
            }
            else {
                [self.getMessageBoardDelegate getMessageBoardErrorResponse];
            }
            
        }
        
        else {
            
            [self.getMessageBoardDelegate getMessageBoardErrorResponse];
            
        }
         
         }];
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"Exception %@",exception);
    }
    
}


-(void)getSizeAndColors:(NSString *)requestString{
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_SIZE_AND_COLORS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];

         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *sizeAndColorsResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:0
                                                                                         error:NULL];
                 if ([[[sizeAndColorsResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     
                     [self.getSizeAndColorsDelegate getSizeAndColorsSuccessResponse:sizeAndColorsResponse];
                 }
                 else {
                     [self.getSizeAndColorsDelegate getSizeAndColorsErrorResponse:[[sizeAndColorsResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.getSizeAndColorsDelegate getSizeAndColorsErrorResponse:@""];
             }
         }
        
    }
    @catch (NSException *exception) {
        [self.getSizeAndColorsDelegate getSizeAndColorsErrorResponse:exception.description];
        
        
    }
    @finally {
        
    }
    
}


#pragma mark StockIssue:

-(void)getStockIssue:(NSString *)requestString{
    
    //  RestFullCall.........
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_STOCK_ISSUES];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *stockRequestResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                      options:0
                                                                                        error:NULL];
                 if ([[[stockRequestResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.stockIssueDelegate getStockIssueSuccessResponse:stockRequestResponse];
                 }
                 else {
                     [self.stockIssueDelegate getStockIssueErrorResponse:[[stockRequestResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.stockIssueDelegate getStockIssueErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException *exception) {
        [self.stockIssueDelegate
         
         getStockIssueErrorResponse:exception.description];
        
    }
}

-(void)getStockIssueId:(NSString *)requestString{
    
    
    //  RestFullCall.........
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_STOCK_ISSUE];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *stockIssueResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                    options:0
                                                                                      error:NULL];
                 if ([[[stockIssueResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.stockIssueDelegate getStockIssueIdSuccessResponse:stockIssueResponse];
                 }
                 else {
                     [self.stockIssueDelegate getStockIssueIdErrorResponse:[[stockIssueResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.stockIssueDelegate getStockIssueIdErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException *exception) {
        [self.stockIssueDelegate getStockIssueIdErrorResponse:exception.description];
        
    }
}


-(void)stockIssueIds:(NSString *)requestString {
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_STOCK_ISSUE_ID];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *stockRequestResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                      options:0
                                                                                        error:NULL];
                 if ([[[stockRequestResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.stockIssueDelegate stockIssueIdsSuccessResponse:stockRequestResponse];
                 }
                 else {
                     [self.stockIssueDelegate stockISsueIdsErrorResponse:[[stockRequestResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.stockIssueDelegate stockISsueIdsErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException *exception) {
        [self.stockIssueDelegate stockISsueIdsErrorResponse:exception.description];
        
    }
}

-(void)createStockIssue:(NSString *)requestString {
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:CREATE_STOCK_ISSUE];
        serviceUrl = [NSString stringWithFormat:@"%@",serviceUrl];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];

        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *customerResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                  options:0
                                                                                    error:NULL];
                 
                 NSLog(@"-------------%@",customerResponse);
                 
                 if ([[[customerResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     
                     [self.stockIssueDelegate createStockIssueSuccessResponse:customerResponse];
                 }
                 else {
                     [self.stockIssueDelegate createStockIssueErrorResponse:[[customerResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.stockIssueDelegate createStockIssueErrorResponse:@""];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.stockIssueDelegate createStockIssueErrorResponse:exception.description];
    }
}

-(void)upDateStockIssue:(NSData *)reqData {
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:UPDATE_STOCK_ISSUE];
        serviceUrl = [NSString stringWithFormat:@"%@",serviceUrl];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = reqData;
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *customerResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                  options:0
                                                                                    error:NULL];
                 NSLog(@"________%@", customerResponse);
                 
                 if ([[[customerResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.stockIssueDelegate updateStockIssueSuccessResponse:customerResponse];
                 }
                 else {
                     [self.stockIssueDelegate updateStockIssueErrorResponse:[[customerResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.stockIssueDelegate updateStockIssueErrorResponse:@""];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.stockIssueDelegate updateStockIssueErrorResponse:exception.description];
    }
    
}

-(void)getStockIssueIdSearchCritera:(NSString *)requestring {
    
    //  RestFullCall.........
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_STOCK_ISSUE_SEARCH_CRITERIA];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestring];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData * data,NSError * connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *searchResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                 
                 if ([[[searchResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.stockIssueDelegate getStockIssueSearchSuccessResponse:searchResponse];
                 }
                 else {
                     [self.stockIssueDelegate getStockissueSearchErrorResponse:[[searchResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.stockIssueDelegate getStockissueSearchErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException *exception) {
        [self.stockIssueDelegate getStockissueSearchErrorResponse:exception.description];
        
    }
}
#pragma mark Stock Receipt Service calls

/**
 * @description  here we are call the get Stock Receipts  services.......
 * @date
 * @method       getStockReceipts:
 * @author       Bhargav Ram
 * @param        NSString
 * @param
 * @return
 *
 * @modified BY  Srinivasulu on 312/05/2017
 * @reason       changed the reason handling....
 *
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getStockReceipts:(NSString *)requestString {
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_STOCK_RECEIPT];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  * request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                            timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *stockReceiptResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                      options:0
                                                                                        error:NULL];
//                 NSLog(@"%@",stockReceiptResponse);
                 
                     if( ([stockReceiptResponse.allKeys containsObject:RESPONSE_HEADER] && [[stockReceiptResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (stockReceiptResponse == nil)){
                 
                         [self.stockReceiptDelegate getStockReceiptsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                     }
                     else if ([[[stockReceiptResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue] == 0){
                 
                         [self.stockReceiptDelegate getStockReceiptsSuccessResponse:stockReceiptResponse];

                     }
            
                 
                 else {
                     [self.stockReceiptDelegate getStockReceiptsErrorResponse:[[stockReceiptResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.stockReceiptDelegate getStockReceiptsErrorResponse:connectionError.localizedDescription];
             }
         }];
        
        
    } @catch (NSException *exception) {
        [self.stockReceiptDelegate getStockReceiptsErrorResponse:exception.description];
        
    }
    
}

-(void)createStockReceipt:(NSData *)requestData {
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:CREATE_STOCK_RECEIPT];
        serviceUrl = [NSString stringWithFormat:@"%@",serviceUrl];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = requestData;
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *stockReceiptResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                      options:0
                                                                                        error:NULL];
                 NSLog(@"-----serviceCall response-------%@",stockReceiptResponse);
                 
                 if ([[[stockReceiptResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                                         
                     [self.stockReceiptDelegate createStockReceiptSuccessResponse:stockReceiptResponse];
                 }
                 else {
                     [self.stockReceiptDelegate createStockReceiptErrorResponse:[[stockReceiptResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.stockReceiptDelegate createStockReceiptErrorResponse:@""];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.stockReceiptDelegate createStockReceiptErrorResponse:exception.description];
    }
    
}




-(void)getStockReceiptDetails:(NSString *)requestString {
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_STOCK_RECEIPT_DETAILS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *stockReceiptResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                      options:0
                                                                                        error:NULL];
                 NSLog(@"%@",stockReceiptResponse);
                 if ([[[stockReceiptResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.stockReceiptDelegate getStockReceiptDetailsSuccessResponse:stockReceiptResponse];
                 }
                 else {
                     [self.stockReceiptDelegate getStockReceiptDetailsErrorResponse:[[stockReceiptResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.stockReceiptDelegate getStockReceiptDetailsErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException * exception) {
        [self.stockReceiptDelegate getStockReceiptDetailsErrorResponse:exception.description];
    }
    
}

-(void)updateStockReceipt:(NSData *)requestData {
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:UPDATE_STOCK_RECEIPT];
        serviceUrl = [NSString stringWithFormat:@"%@",serviceUrl];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = requestData;
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * stockReceiptResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:0
                                                                                         error:NULL];
                 NSLog(@"-----serviceCall response-------%@",stockReceiptResponse);
                 
                 if ([[[stockReceiptResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     
                     [self.stockReceiptDelegate upDateStockReceiptSuccessResponse:stockReceiptResponse];
                 }
                 else {
                     [self.stockReceiptDelegate upDateStockReceiptErrorResponse:[[stockReceiptResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.stockReceiptDelegate upDateStockReceiptErrorResponse:@""];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.stockReceiptDelegate upDateStockReceiptErrorResponse:exception.description];
    }
}


#pragma mark Stock Return:

-(void)getStockReturn:(NSString *)requestString {
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_STOCK_RETURN];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *stockReturnResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                      options:0
                                                                                        error:NULL];
                 if ([[[stockReturnResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.stockReturnDelegate getStockReturnSuccessResponse:stockReturnResponse];
                 }
                 else {
                     [self.stockReturnDelegate getStockReturnErrorResponse:[[stockReturnResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.stockReturnDelegate getStockReturnErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException *exception) {
        [self.stockReturnDelegate getStockReturnErrorResponse:exception.description];
        
    }
}


-(void)createStockReturn:(NSData *)requestData {
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:CREATE_STOCK_RETURN];
        serviceUrl = [NSString stringWithFormat:@"%@",serviceUrl];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = requestData;
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *stockReturnResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                      options:0
                                                                                        error:NULL];
                 NSLog(@"----serviceCall response---%@",stockReturnResponse);
                 
                 if ([[[stockReturnResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     
                     [self.stockReturnDelegate createStockReturnSuccessResponse:stockReturnResponse];
                 }
                 else {
                     [self.stockReturnDelegate createStockReturnErrorResponse:[[stockReturnResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.stockReturnDelegate createStockReturnErrorResponse:@""];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.stockReturnDelegate createStockReturnErrorResponse:exception.description];
    }

}


-(void)upDateStockReturn:(NSData *)requestData {
    @try {
        
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:UPDATE_STOCK_RETURN];
        serviceUrl = [NSString stringWithFormat:@"%@",serviceUrl];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = requestData;
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * stockReturnResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:0
                                                                                         error:NULL];
                 NSLog(@"-----serviceCall response-------%@",stockReturnResponse);
                 
                 if ([[[stockReturnResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     
                     [self.stockReturnDelegate upDateStockReturnSuccessResponse:stockReturnResponse];
                 }
                 else {
                     [self.stockReturnDelegate upDateStockReturnErrorResponse:[[stockReturnResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.stockReturnDelegate upDateStockReturnErrorResponse:@""];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.stockReturnDelegate upDateStockReturnErrorResponse:exception.description];
    }
}


-(void)getWarehouseIssueIds:(NSString *)requestString {
    
    
    //  RestFullCall.........
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_WAREHOUSE_ISSUEIDS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *stockIssueResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                    options:0
                                                                                      error:NULL];
                    if (![[stockIssueResponse valueForKey:RESPONSE_HEADER] isKindOfClass:[NSNull class]] && [[[stockIssueResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue] == 0) {
                     
                     [self.stockIssueDelegate getStockIssueSuccessResponse:stockIssueResponse];
                 }
                 else {
                     [self.stockIssueDelegate getStockIssueErrorResponse:[[stockIssueResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.stockIssueDelegate getStockIssueErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException *exception) {
        [self.stockIssueDelegate getStockIssueErrorResponse:exception.description];
        
    }
}

-(void)getWarehouseIssueDetails:(NSString*)requestString {
    
    
    //  RestFullCall.........
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_WAREHOUSE_ISSUE_DETAILS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *stockIssueResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                    options:0
                                                                                      error:NULL];
                 if ([[[stockIssueResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.stockIssueDelegate getStockIssueIdSuccessResponse:stockIssueResponse];
                 }
                 else {
                     [self.stockIssueDelegate getStockIssueIdErrorResponse:[[stockIssueResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.stockIssueDelegate getStockIssueIdErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException *exception) {
        [self.stockIssueDelegate getStockIssueIdErrorResponse:exception.description];
        
    }
}

-(void)getStockReceiptIds:(NSString*)requestString{
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_STOCK_RECEIPT_IDS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                            timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *stockReceiptResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                      options:0
                                                                                        error:NULL];
                 NSLog(@"%@",stockReceiptResponse);
                 
                 
                 if( ([stockReceiptResponse.allKeys containsObject:RESPONSE_HEADER] && [[stockReceiptResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (stockReceiptResponse == nil)){
                     
                     [self.stockReceiptDelegate getStockReceiptsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if([[[stockReceiptResponse valueForKey:RESPONSE_HEADER] allKeys] containsObject:RESPONSE_CODE] &&   ![[[stockReceiptResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE ] isKindOfClass: [NSNull class]] && [[[stockReceiptResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE ] intValue] == 0){
                     
                     [self.stockReceiptDelegate getStockReceiptsSuccessResponse:stockReceiptResponse];
                     
                 }
                 
                 
                 else {
                     [self.stockReceiptDelegate getStockReceiptsErrorResponse:[[stockReceiptResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.stockReceiptDelegate getStockReceiptsErrorResponse:connectionError.localizedDescription];
             }
         }];
        
        
    } @catch (NSException *exception) {
        [self.stockReceiptDelegate getStockReceiptsErrorResponse:exception.description];
        
    }
    
}

-(void)getStockIssueDetails:(NSString*)requestString {
    
    //  RestFullCall.........
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_STOCK_ISSUE_DETAILS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *stockRequestResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                      options:0
                                                                                        error:NULL];
                 if ([[[stockRequestResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.stockIssueDelegate getStockIssueDetailsSuccessResponse:stockRequestResponse];
                 }
                 else {
                     [self.stockIssueDelegate getStockIssueDetailsErrorResponse:[[stockRequestResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.stockIssueDelegate getStockIssueDetailsErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException *exception) {
        [self.stockIssueDelegate getStockIssueDetailsErrorResponse:exception.description];
        
    }
}

-(BOOL)getdenominations:(NSString *)requestString{
    
    //  RestFullCall.........
    BOOL  status = false;

    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_DENOMINATIONS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        if (data.length > 0 && connectionError == nil)
        {
            NSDictionary *stockRequestResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                 options:0
                                                                                   error:NULL];
            if ([[[stockRequestResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                
                status = [self.DenominationDelegate getDenominationsSuccessResponse:stockRequestResponse];
            }
            else {
                status = [self.DenominationDelegate getDenominationsErrorResponse:[[stockRequestResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
            }
        }
        else {
            status = [self.DenominationDelegate getDenominationsErrorResponse:connectionError.localizedDescription];
        }
        
        return status;
        
    } @catch (NSException *exception) {
       status = [self.DenominationDelegate getDenominationsErrorResponse:exception.description];
        
    }
}

//added by Bhargav:

-(void)getProductsByCategory:(NSString *)requestString {
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_PRODUCTS_BY_CATEGORY];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *stockReturnResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                     options:0
                                                                                       error:NULL];
                 if ([[[stockReturnResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.getCategoriesDelegate getProductsByCategorySuccessResponse:stockReturnResponse];
                 }
                 else {
                     [self.getCategoriesDelegate getProductsByCategoryErrorResponse:[[stockReturnResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.getCategoriesDelegate getProductsByCategoryErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException *exception) {
        [self.getCategoriesDelegate getProductsByCategoryErrorResponse:exception.description];
        
    }
}



// Commented by roja on 17/10/2019.. // reason :- getProductCategories: method contains SOAP Service call .. so taken new method with same name(getProductCategories:) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//-(BOOL)getProductCategories:(NSString *)requestString {
//
//    @try {
//
//        BOOL status = false;
//
//
//        UtilityMasterServiceSoapBinding *utility =  [UtilityMasterServiceSvc UtilityMasterServiceSoapBinding];
//
//        UtilityMasterServiceSvc_getProductCategory *category = [[UtilityMasterServiceSvc_getProductCategory alloc] init];
//        category.categoryDetails = requestString;
//
//        UtilityMasterServiceSoapBindingResponse *response = [utility getProductCategoryUsingParameters:category];
//
//        if (![response.error isKindOfClass:[NSError class]]) {
//            NSArray *responseBodyparts = response.bodyParts;
//
//
//            if (responseBodyparts != nil) {
//                for (id bodyPart in responseBodyparts) {
//                    if ([bodyPart isKindOfClass:[UtilityMasterServiceSvc_getProductCategoryResponse class]]) {
//                        UtilityMasterServiceSvc_getProductCategoryResponse *body = (UtilityMasterServiceSvc_getProductCategoryResponse *)bodyPart;
//                        // NSLog(@"response = %@",body.return_);
//                        NSError *e;
//
//                        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                             options: NSJSONReadingMutableContainers
//                                                                               error: &e];
//
//                        if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue]==0) {
//                         status =  [self.utilityMasterDelegate getProductCategoriesSuccessResponse:JSON];
//
//                        }
//                        else{
//                          status =   [self.utilityMasterDelegate getProductCategoriesErrorResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
//                        }
//
//                    }
//                    else {
//                      status =   [self.utilityMasterDelegate getProductCategoriesErrorResponse:@""];
//                    }
//                }
//
//            }
//            else {
//                status =    [self.utilityMasterDelegate getProductCategoriesErrorResponse:NSLocalizedString(@"request_time_out", nil)];
//            }
//        }
//        return  status;
//
//    }
//    @catch (NSException *exception) {
//
//        NSLog(@"%@----service call exception",exception);
//
//    }
//    @finally {
//
//    }
//}



// Commented by roja on 17/10/2019.. // reason :- getProductSubCategories: method contains SOAP Service call .. so taken new method with same name(getProductSubCategories:) method name which contains REST service call....
// At the time of converting SOAP call's to REST
//-(BOOL)getProductSubCategories:(NSString *)requestString {
//
//    @try {
//        BOOL status = false;
//
//        UtilityMasterServiceSoapBinding *utility =  [UtilityMasterServiceSvc UtilityMasterServiceSoapBinding];
//      //  utility.logXMLInOut = YES;
//
//        UtilityMasterServiceSvc_getProductSubCategory *category = [[UtilityMasterServiceSvc_getProductSubCategory alloc] init];
//
//        category.categoryDetails = requestString;
//        UtilityMasterServiceSoapBindingResponse *response = [utility getProductSubCategoryUsingParameters:category];
//
//
//        if (![response.error isKindOfClass:[NSError class]]) {
//            NSArray *responseBodyparts = response.bodyParts;
//
//
//            if (responseBodyparts != nil) {
//                for (id bodyPart in responseBodyparts) {
//                    if ([bodyPart isKindOfClass:[UtilityMasterServiceSvc_getProductSubCategoryResponse class]]) {
//                        UtilityMasterServiceSvc_getProductSubCategoryResponse *body = (UtilityMasterServiceSvc_getProductSubCategoryResponse *)bodyPart;
//                        // NSLog(@"response = %@",body.return_);
//                        NSError *e;
//
//                        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                             options: NSJSONReadingMutableContainers
//                                                                               error: &e];
//
//                        if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue]==0) {
//                          status = [self.utilityMasterDelegate getProductSubCategoriesSuccessResponse:JSON];
//
//                        }
//                        else{
//                         status =   [self.utilityMasterDelegate getProductSubCategoriesErrorResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
//                        }
//                    }
//                    else {
//                      status=  [self.utilityMasterDelegate getProductSubCategoriesErrorResponse:@""];
//                    }
//                }
//            }
//            else
//               status = [self.utilityMasterDelegate getProductSubCategoriesErrorResponse:NSLocalizedString(@"request_time_out", nil)];
//        }
//        return  status;
//    }
//    @catch (NSException *exception) {
//
//    }
//    @finally {
//
//    }
//
//}


-(BOOL)getProducts:(NSString *)requestString {
    
    BOOL status = false;
    
    @try {
        ProductMasterServiceSoapBinding * product  = [ProductMasterServiceSvc ProductMasterServiceSoapBinding];
        
      //  product.logXMLInOut = YES;
        
        ProductMasterServiceSvc_getProducts *products = [[ProductMasterServiceSvc_getProducts alloc] init];
        
        products.productMasterSearchCriteria = requestString;
        
        ProductMasterServiceSoapBindingResponse *response =[product getProductsUsingParameters:products];
        
        if (![response.error isKindOfClass:[NSError class]]) {
            NSArray *responseBodyparts = response.bodyParts;
            
            
            if (responseBodyparts != nil) {
                for (id bodyPart in responseBodyparts) {
                    if ([bodyPart isKindOfClass:[ProductMasterServiceSvc_getProductsResponse class]]) {
                        ProductMasterServiceSvc_getProductsResponse *body = (ProductMasterServiceSvc_getProductsResponse *)bodyPart;
                        // NSLog(@"response = %@",body.return_);
                        NSError *e;
                        
                        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                                             options: NSJSONReadingMutableContainers
                                                                               error: &e];
                        
                        if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue]==0) {
                          status =  [self.productMasterDelegate getProductsSuccessResponse:JSON];
                            
                        }
                        else{
                          status  = [self.productMasterDelegate getProductsErrorResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                        }
                    }
                    else {
                        
                      status =  [self.productMasterDelegate getProductsErrorResponse:@""];
                    }
                }
            }
            else
               status = [self.productMasterDelegate getProductsErrorResponse:NSLocalizedString(@"request_time_out", nil)];
        }
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@---exception while calling service call",exception);
    }
    @finally {
        
    }
    
    
    
    return status;
}



-(void)getStockVericationSummaryDetails:(NSString *)requestString {
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_STOCK_VERIFICATION_SUMMARY];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *summaryResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                 options:0
                                                                                   error:NULL];
                 if ([[[summaryResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.stockVerificationDelegate getStockVerificationDetailsSuccessResponse:summaryResponse];
                 }
                 else {
                     [self.stockVerificationDelegate getStockVerificationDetailsErrorResponse:[[summaryResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.stockVerificationDelegate getStockVerificationDetailsErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException *exception) {
        [self.stockVerificationDelegate getStockVerificationDetailsErrorResponse:exception.description];
        
    }
}

-(void)getSuppliesReport:(NSString*)requestString {
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_SUPPLIES_REPORT];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *summaryResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                 options:0
                                                                                   error:NULL];
                 if (![[[summaryResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] isKindOfClass:[NSNull class]] && [[[summaryResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.stockReceiptDelegate getSuppliesReportSuccessResponse:summaryResponse];
                 }
                 else {
                     [self.stockReceiptDelegate getSuppliesReportErrorResponse:[[summaryResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.stockReceiptDelegate getSuppliesReportErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException *exception) {
        [self.stockReceiptDelegate getSuppliesReportErrorResponse:exception.description];
        
    }
}

-(void)getMaterialConsumption:(NSString *)requestString {
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_MATERIAL_CONSUMPTION];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *material = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 if ([[[material valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.bomMasterSvcDelegate getMaterialConsumptionSuccessResponse:material];
                 }
                 else {
                     [self.bomMasterSvcDelegate getMaterialConsumptionErrorResponse:[[material valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.bomMasterSvcDelegate getMaterialConsumptionErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException *exception) {
        [self.bomMasterSvcDelegate getMaterialConsumptionErrorResponse:exception.description];
        
    }
}

#pragma -mark mehods used for GoodReceiptNote under warehouseGoodsReceipNoteServiceDelegate  -- for WareHouse level.......


/**
 * @description    here we are calling createGRN service calls to create new GRN through Asynchronous request....
 * @date           06/02/2017..
 * @method         createWarehouseGoodsReceiptNote
 * @author         Srinivasulu . V
 * @param          NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)createWarehouseGoodsReceiptNote:(NSString *)requestString{
    
    //resetFull Service calls......
    
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:CREATE_GOODS_RECEIPT_NOTE];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%ld", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];
        
        
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSError *err;
                 
                 NSDictionary *JSON  = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:kNilOptions
                                                                         error:&err];
                 
                 
                 if (JSON.count) {
                     
                     if( ([JSON.allKeys containsObject:RESPONSE_HEADER] && [[JSON valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (JSON == nil)){
                         
                         [self.warehouseGoodsReceipNoteServiceDelegate createWarehouseGoodsReceipNoteErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                         
                     }
                     else if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                         
                         [self.warehouseGoodsReceipNoteServiceDelegate createWarehouseGoodsReceipNoteSuccessResponse:JSON];
                         
                     }
                     else {
                         [self.warehouseGoodsReceipNoteServiceDelegate createWarehouseGoodsReceipNoteErrorResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                         
                     }
                 }
                 else {
                     [self.warehouseGoodsReceipNoteServiceDelegate createWarehouseGoodsReceipNoteErrorResponse:NSLocalizedString(@"request_timeOut", nil)];
                     
                 }
                 
             }
             
             else {
                 
                 [self.warehouseGoodsReceipNoteServiceDelegate createWarehouseGoodsReceipNoteErrorResponse:connectionError.localizedDescription];
                 
             }
             
         }];
        
    }
    @catch (NSException *exception) {
        [self.warehouseGoodsReceipNoteServiceDelegate createWarehouseGoodsReceipNoteErrorResponse:exception.description];
    }
    
}

/**
 * @description  here we are calling updateWarehouseGoodsReceiptNote services.......
 * @date         24/11/2016
 * @method       updateWarehouseGoodsReceiptNote
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)updateWarehouseGoodsReceiptNote:(NSString *)requestString{
    
    //resetFull Service calls......
    
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:UPDATE_GOODS_RECEIPT_NOTE];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%ld", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];
        
        
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSError *err;
                 
                 NSDictionary *JSON  = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:kNilOptions
                                                                         error:&err];
                 
                 
                 if (JSON.count) {
                     
                     if( ([JSON.allKeys containsObject:RESPONSE_HEADER] && [[JSON valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (JSON == nil)){
                         
                         [self.warehouseGoodsReceipNoteServiceDelegate updateWarehouseGoodsReceipNoteErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                         
                     }
                     else if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                         
                         [self.warehouseGoodsReceipNoteServiceDelegate updateWarehouseGoodsReceipNoteSuccessResponse:JSON];
                         
                     }
                     else {
                         [self.warehouseGoodsReceipNoteServiceDelegate updateWarehouseGoodsReceipNoteErrorResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                         
                     }
                 }
                 else {
                     [self.warehouseGoodsReceipNoteServiceDelegate updateWarehouseGoodsReceipNoteErrorResponse:NSLocalizedString(@"request_timeOut", nil)];
                     
                 }
                 
             }
             
             else {
                 
                 [self.warehouseGoodsReceipNoteServiceDelegate updateWarehouseGoodsReceipNoteErrorResponse:connectionError.localizedDescription];
                 
             }
             
         }];
        
    }
    @catch (NSException *exception) {
        [self.warehouseGoodsReceipNoteServiceDelegate updateWarehouseGoodsReceipNoteErrorResponse:exception.description];
    }
    
}



/**
 * @description  in this method we are calling the service to get all StockReceiptDetails Data.......
 * @date         31/10/2016
 * @method       getStockReceiptWithDetails:
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getWarehouseGoodsReceiptNoteWithDetailsWithSynchronousRequest:(NSString *)requestString{
    
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:UPDATE_GOODS_RECEIPT_NOTE];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        if (data.length > 0 && connectionError == nil)
        {
            NSError *err;
            
            NSDictionary *JSON  = [NSJSONSerialization JSONObjectWithData:data
                                                                  options:kNilOptions
                                                                    error:&err];
            
            
            if (JSON.count) {
                if( ([JSON.allKeys containsObject:RESPONSE_HEADER] && [[JSON valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (JSON == nil)){
                    
                    [self.warehouseGoodsReceipNoteServiceDelegate getWarehouseGoodsReceipNoteWithDetailsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                    
                }
                else if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                    
                    [self.warehouseGoodsReceipNoteServiceDelegate getWarehouseGoodsReceipNoteWithDetailsSuccessResponse:JSON];
                    
                }
                else {
                    [self.warehouseGoodsReceipNoteServiceDelegate getWarehouseGoodsReceipNoteWithDetailsErrorResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                    
                }
            }
            else {
                [self.warehouseGoodsReceipNoteServiceDelegate getWarehouseGoodsReceipNoteWithDetailsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                
            }
            
        }
        
        else {
            
            [self.warehouseGoodsReceipNoteServiceDelegate getWarehouseGoodsReceipNoteWithDetailsErrorResponse:connectionError.localizedDescription];
            
        }
        
    }
    @catch (NSException *exception) {
        
        [self.warehouseGoodsReceipNoteServiceDelegate getWarehouseGoodsReceipNoteWithDetailsErrorResponse:exception.description];
    }
    
}

/**
 * @description  in this method we are calling the service to get all StockReceiptDetails Data.......
 * @date         31/10/2016
 * @method       getStockReceiptWithDetails:
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getWarehouseGoodsReceiptNoteWithDetails:(NSString *)requestString{
    
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_GOODS_RECEIPT_NOTE];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *stockReceiptsResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:0
                                                                                         error:NULL];
                 
                 if( ([stockReceiptsResponse.allKeys containsObject:RESPONSE_HEADER] && [[stockReceiptsResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (stockReceiptsResponse == nil)){
                     
                     [self.warehouseGoodsReceipNoteServiceDelegate getWarehouseGoodsReceipNoteWithDetailsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                     
                 }
                 else  if ([[[stockReceiptsResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.warehouseGoodsReceipNoteServiceDelegate getWarehouseGoodsReceipNoteWithDetailsSuccessResponse:stockReceiptsResponse];
                 }
                 else {
                     [self.warehouseGoodsReceipNoteServiceDelegate getWarehouseGoodsReceipNoteWithDetailsErrorResponse:[[stockReceiptsResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.warehouseGoodsReceipNoteServiceDelegate getWarehouseGoodsReceipNoteWithDetailsErrorResponse:connectionError.localizedDescription];
             }
             
             
         }];
        
    }
    @catch (NSException *exception) {
        [self.warehouseGoodsReceipNoteServiceDelegate getWarehouseGoodsReceipNoteWithDetailsErrorResponse:exception.description];
    }
    
}

/**
 * @description  in this method we are calling the service to get all StockReceipt Data.......
 * @date         31/10/2016
 * @method       getAllStockReceipt:
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getAllWarehouseGoodsReceiptNotes:(NSString *)requestString{
    
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_GOODS_RECEIPT_NOTE];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             
             
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *stockReceiptsResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:0
                                                                                         error:NULL];
                 
                 if( ([stockReceiptsResponse.allKeys containsObject:RESPONSE_HEADER] && [[stockReceiptsResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (stockReceiptsResponse == nil)){
                     
                     [self.warehouseGoodsReceipNoteServiceDelegate getWarehouseGoodsReceipNotErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                     
                 }
                 else if ([[[stockReceiptsResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.warehouseGoodsReceipNoteServiceDelegate getWarehouseGoodsReceipNoteSuccessResponse:stockReceiptsResponse];
                 }
                 else {
                     [self.warehouseGoodsReceipNoteServiceDelegate getWarehouseGoodsReceipNotErrorResponse:[[stockReceiptsResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.warehouseGoodsReceipNoteServiceDelegate getWarehouseGoodsReceipNotErrorResponse:connectionError.localizedDescription];
             }
             
         }];
        
    }
    @catch (NSException *exception) {
        [self.warehouseGoodsReceipNoteServiceDelegate getWarehouseGoodsReceipNotErrorResponse:exception.description];
    }
    
}

/**
 * @description  here we are calling gerWarehouseGoodsReceiptNoteSummary.......
 * @date         24/11/2016
 * @method       getWarehouseGoodsReceiptNoteSummaryData
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getWarehouseGoodsReceiptNoteSummaryData:(NSString *)requestString{
    
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_GOODS_RECEIPT_NOTE_SUMMARY];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        if (data.length > 0 && connectionError == nil)
        {
            NSError *err;
            
            NSDictionary *JSON  = [NSJSONSerialization JSONObjectWithData:data
                                                                  options:kNilOptions
                                                                    error:&err];
            
            
            if (JSON.count) {
                
                if( ([JSON.allKeys containsObject:RESPONSE_HEADER] && [[JSON valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (JSON == nil)){
                    
                    [self.warehouseGoodsReceipNoteServiceDelegate getWarehouseGoodsReceipNoteSummaryErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                    
                }
                else if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                    
                    [self.warehouseGoodsReceipNoteServiceDelegate getWarehouseGoodsReceipNoteSummarySuccessResponse:JSON];
                    
                }
                else {
                    [self.warehouseGoodsReceipNoteServiceDelegate getWarehouseGoodsReceipNoteSummaryErrorResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                    
                }
            }
            else {
                [self.warehouseGoodsReceipNoteServiceDelegate getWarehouseGoodsReceipNoteSummaryErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                
            }
            
        }
        
        else {
            
            [self.warehouseGoodsReceipNoteServiceDelegate getWarehouseGoodsReceipNoteSummaryErrorResponse:connectionError.localizedDescription];
            
        }
        
    }
    @catch (NSException *exception) {
        
        [self.warehouseGoodsReceipNoteServiceDelegate getWarehouseGoodsReceipNoteSummaryErrorResponse:exception.description];
    }
    
}



/**
 * @description  here we are calling gerWarehouseGoodsReceiptNoteSummary.......
 * @date         24/11/2016
 * @method       getWarehouseGoodsReceiptNoteSummaryData
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */
-(void)getWarehouseGoodsReceiptNoteSummaryDataWithSynchronousRequest:(NSString *)requestString{
    
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_GOODS_RECEIPT_NOTE_SUMMARY];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        if (data.length > 0 && connectionError == nil)
        {
            NSError *err;
            
            NSDictionary *JSON  = [NSJSONSerialization JSONObjectWithData:data
                                                                  options:kNilOptions
                                                                    error:&err];
            
            //            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:JSON options:0 error:&err];
            //            NSString * quoteRequestJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            if (JSON.count) {
                if( ([JSON.allKeys containsObject:RESPONSE_HEADER] && [[JSON valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (JSON == nil)){
                    
                    [self.warehouseGoodsReceipNoteServiceDelegate getWarehouseGoodsReceipNoteSummaryErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                    
                }
                else if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                    
                    [self.warehouseGoodsReceipNoteServiceDelegate getWarehouseGoodsReceipNoteSummarySuccessResponse:JSON];
                    
                }
                else {
                    [self.warehouseGoodsReceipNoteServiceDelegate getWarehouseGoodsReceipNoteSummaryErrorResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                    
                }
            }
            else {
                [self.warehouseGoodsReceipNoteServiceDelegate getWarehouseGoodsReceipNoteSummaryErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                
            }
            
        }
        
        else {
            
            [self.warehouseGoodsReceipNoteServiceDelegate getWarehouseGoodsReceipNoteSummaryErrorResponse:connectionError.localizedDescription];
            
        }
        
    }
    @catch (NSException *exception) {
        
        [self.warehouseGoodsReceipNoteServiceDelegate getWarehouseGoodsReceipNoteSummaryErrorResponse:exception.description];
    }
    
}

#pragma -mark mehods used for generateGRNs  -- for WareHouse level.......

/**
 * @description  here we are calling updateWarehouseGoodsReceiptNote services.......
 * @date         24/11/2016
 * @method       generateGRNs
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)generateGRNs:(NSString *)requestString{
    
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GENERATE_GRN];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *purchaseOrderDic = [NSJSONSerialization JSONObjectWithData:data
                                                                                  options:0
                                                                                    error:NULL];
                 //                 NSLog(@"-------%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                 //                 [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                 
                 if( ([purchaseOrderDic.allKeys containsObject:RESPONSE_HEADER] && [[purchaseOrderDic valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (purchaseOrderDic == nil)){
                     
                     [self.warehouseGoodsReceipNoteServiceDelegate createGRNsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                     
                 }
                 
                 else if ([[[purchaseOrderDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.warehouseGoodsReceipNoteServiceDelegate createGRNsSuccessResponse:purchaseOrderDic];
                 }
                 else {
                     [self.warehouseGoodsReceipNoteServiceDelegate createGRNsErrorResponse:[[purchaseOrderDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
                 
             }
             else {
                 [self.warehouseGoodsReceipNoteServiceDelegate createGRNsErrorResponse:connectionError.localizedDescription];
                 
             }
         }];
        
    }
    @catch (NSException *exception) {
        [self.warehouseGoodsReceipNoteServiceDelegate createGRNsErrorResponse:exception.description];
    }
    
}


#pragma -mark soap service call used in the file

/**
 * @description  Here are calling the getSupplier
 * @date         25/08/2016
 * @method       getSupplierDetailsData:
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

// Commented by roja on 17/10/2019.. // reason:-  getSupplierDetailsData: method contains SOAP Service call .. so taken new method with same name(getSupplierDetailsData:) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//-(void)getSupplierDetailsData:(NSString *)requestString{
//
//    @try {
//
//        SupplierServiceSoapBinding *skuService = [SupplierServiceSvc SupplierServiceSoapBinding];
//        SupplierServiceSvc_getSuppliers *getSkuid = [[SupplierServiceSvc_getSuppliers alloc] init];
//
//        getSkuid.supplierDetails = requestString;
//
//        SupplierServiceSoapBindingResponse *response = [skuService getSuppliersUsingParameters:getSkuid];
//
//        if (![response.error isKindOfClass:[NSError class]]) {
//            NSArray *responseBodyparts = response.bodyParts;
//
//
//            if (responseBodyparts != nil) {
//                for (id bodyPart in responseBodyparts) {
//                    if ([bodyPart isKindOfClass:[SupplierServiceSvc_getSuppliersResponse class]]) {
//                        SupplierServiceSvc_getSuppliersResponse *body = (SupplierServiceSvc_getSuppliersResponse *)bodyPart;
//                        // NSLog(@"response = %@",body.return_);
//                        NSError *e;
//                        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                             options: NSJSONReadingMutableContainers
//                                                                               error: &e];
//
//                        if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue]==0) {
//                            [self.supplierServiceSvcDelegate getSuppliersSuccessResponse:JSON];
//
//                        }
//                        else{
//                            [self.supplierServiceSvcDelegate getSuppliersErrorResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
//
//                        }
//
//                    }
//                }
//
//            }
//            else
//                [self.supplierServiceSvcDelegate getSuppliersErrorResponse:NSLocalizedString(@"request_time_out", nil)];
//        }
//        else{
//
//            [self.supplierServiceSvcDelegate getSuppliersErrorResponse:response.error.localizedDescription];
//        }
//
//    }
//    @catch (NSException *exception) {
//        [self.supplierServiceSvcDelegate getSuppliersErrorResponse:exception.description];
//    }
//}



/**
 * @description  here we are calling getpurchaseOrdersRefIds to all reference id numbers....
 * @date         16/02/2017..
 * @method       getAllPurchaseOrdersRefIds
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getAllPurchaseOrdersRefIds:(NSString *)requestString{
    
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_PO_IDS_IDS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSError *err;
                 
                 NSDictionary *JSON  = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:kNilOptions
                                                                         error:&err];
                 
                 
                 if (JSON.count) {
                     
                     if( ([JSON.allKeys containsObject:RESPONSE_HEADER] && [[JSON valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (JSON == nil)){
                         
                         [self.purchaseOrderSvcDelegate getPORefIdsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                         
                     }
                     else if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                         
                         [self.purchaseOrderSvcDelegate getPORefIdsSuccessResponse:JSON];
                         
                     }
                     else {
                         [self.purchaseOrderSvcDelegate getPORefIdsErrorResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                         
                     }
                 }
                 else {
                     [self.purchaseOrderSvcDelegate getPORefIdsErrorResponse:NSLocalizedString(@"request_timeOut", nil)];
                     
                 }
                 
             }
             
             else {
                 
                 [self.purchaseOrderSvcDelegate getPORefIdsErrorResponse:connectionError.localizedDescription];
                 
             }
             
             
         }];
        
    }
    @catch (NSException *exception) {
        [self.purchaseOrderSvcDelegate getPORefIdsErrorResponse:exception.description];
    }
}


/**
 * @description  Here are calling the getPurchaseOrderDetails
 * @date         29/09/2016
 * @method       getAllPurchaseOrdersDetailsData:
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getAllPurchaseOrdersDetailsData:(NSString *)requestString{
    
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_PURCHASE_ORDERS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSError *err;
                 
                 NSDictionary *JSON  = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:kNilOptions
                                                                         error:&err];
                 
                 
                 if (JSON.count) {
                     
                     if( ([JSON.allKeys containsObject:RESPONSE_HEADER] && [[JSON valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (JSON == nil)){
                         
                         [self.purchaseOrderSvcDelegate getPurchaseOrdersErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                         
                     }
                     else if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                         
                         [self.purchaseOrderSvcDelegate getPurchaseOrdersSuccessResponse:JSON];
                         
                     }
                     else {
                         [self.purchaseOrderSvcDelegate getPurchaseOrdersErrorResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                         
                     }
                 }
                 else {
                     [self.purchaseOrderSvcDelegate getPurchaseOrdersErrorResponse:NSLocalizedString(@"request_timeOut", nil)];
                     
                 }
                 
             }
             
             else {
                 
                 [self.purchaseOrderSvcDelegate getPurchaseOrdersErrorResponse:connectionError.localizedDescription];
                 
             }
             
             
         }];
        
    }
    @catch (NSException *exception) {
        [self.purchaseOrderSvcDelegate getPurchaseOrdersErrorResponse:exception.description];
    }
}

-(void)warehouseSearchProducts:(NSString*)requestString {
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:SEARCH_PRODUCTS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                            timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *billingResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                 options:0
                                                                                   error:NULL];
                 if ([billingResponse.allKeys containsObject:RESPONSE_HEADER] && ![[billingResponse valueForKey:RESPONSE_HEADER] isKindOfClass:[NSNull class]] && [[[billingResponse valueForKey:RESPONSE_HEADER] allKeys] containsObject:RESPONSE_CODE] && ![[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] isKindOfClass:[NSNull class]] && [[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     [self.searchProductDelegate searchProductsSuccessResponse:billingResponse];
                 }
                 else {
                     [self.searchProductDelegate searchProductsErrorResponse];
                 }
             }
             else {
                 [self.searchProductDelegate searchProductsErrorResponse];
             }
         }];
        
    }
    @catch (NSException *exception) {
        [self.searchProductDelegate searchProductsErrorResponse];
    }
    @finally {
        
    }
    
}

-(void)getWarehouseSkuDetailsWithData:(NSString *)requestString {
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_SKU_DETAILS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                            timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *billingResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                 options:0
                                                                                   error:NULL];
                 if ([[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.getSkuDetailsDelegate getSkuDetailsSuccessResponse:billingResponse];
                 }
                 else {
                     [self.getSkuDetailsDelegate getSkuDetailsErrorResponse:[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.getSkuDetailsDelegate getSkuDetailsErrorResponse:@"Product Not Available"];
             }
         }];
        
    } @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
        [self.getSkuDetailsDelegate getSkuDetailsErrorResponse:@"Product Not Available"];
        
    } @finally {
        
    }
    
    
}

/**
 * @description  Here are calling the getPurchaseOrderDetails
 * @date         28/09/2016
 * @method       getPurchaseOrdersDetailsData:
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getPurchaseOrderDetails:(NSString *)requestString{
    
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_PURCHASE_ORDER_DETAILS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *purchaseOrderDic = [NSJSONSerialization JSONObjectWithData:data
                                                                                  options:0
                                                                                    error:NULL];
                 //                 NSLog(@"-------%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                 //                 [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                 
                 if( ([purchaseOrderDic.allKeys containsObject:RESPONSE_HEADER] && [[purchaseOrderDic valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (purchaseOrderDic == nil)){
                     
                     [self.purchaseOrderSvcDelegate getPurchaseOrderDetailsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                     
                 }
                 else  if ([[[purchaseOrderDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.purchaseOrderSvcDelegate getPurchaseOrderDetailsSuccessResponse:purchaseOrderDic];
                 }
                 else {
                     [self.purchaseOrderSvcDelegate getPurchaseOrderDetailsErrorResponse:[[purchaseOrderDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
                 
             }
             else {
                 [self.purchaseOrderSvcDelegate getPurchaseOrderDetailsErrorResponse:connectionError.localizedDescription];
                 
             }
         }];
        
    }
    @catch (NSException *exception) {
        [self.purchaseOrderSvcDelegate getPurchaseOrderDetailsErrorResponse:exception.description];
    }
    
}

-(void)getStockRequestIDs:(NSString *)requestString {
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_STOCK_REQUEST_IDS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *IDsResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:0
                                                                               error:NULL];
                 if ([[[IDsResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.stockRequestDelegate getStockRequestIdsSuccessResponse:IDsResponse];
                 }
                 else {
                     [self.stockRequestDelegate getStockRequestIdsErrorResponse:[[IDsResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.stockRequestDelegate getStockRequestIdsErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException *exception) {
        [self.stockRequestDelegate getStockRequestIdsErrorResponse:exception.description];
        
    }
}

-(void)getStockMovementDetails:(NSString *)requestString {
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_STOCK_MOVEMENT_DETAILS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *stockReturnResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                     options:0
                                                                                       error:NULL];
                 if ([[[stockReturnResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.stockMovementDelegate getStockMovementSuccessResponse:stockReturnResponse];
                 }
                 else {
                     [self.stockMovementDelegate getStockMovementErrorResponse:[[stockReturnResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.stockMovementDelegate getStockMovementErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException *exception) {
        [self.stockMovementDelegate getStockMovementErrorResponse:exception.description];
        
    }
}

#pragma -mark methods added by Srinivasulu from 10/05/2017 onwards....


/**
 * @description  here we are calling he zonemaster services to get all zones....
 * @date         10/05/2017....
 * @method       getZoneIdsRequest:
 * @author       Srinivasulu
 * @param        NSStirng
 * @param
 * @return       void
 * @verified By
 * @verified On
 *
 */

// Commented by roja on 17/10/2019.. // reason : getZoneIdsRequest: method contains SOAP Service call .. so taken new method with same name(getZoneIdsRequest:) method name which contains REST service call....
// At the time of converting SOAP call's to REST
//-(void)getZoneIdsRequest:(NSString *)requestString{
//
//    @try {
//
//
//        ZoneMasterServiceSoapBinding *materialBinding = [ZoneMasterServiceSvc ZoneMasterServiceSoapBinding];
//
//        ZoneMasterServiceSvc_getZones *aparams = [[ZoneMasterServiceSvc_getZones alloc] init];
//
//        aparams.zoneID = requestString;
//
//
//        ZoneMasterServiceSoapBindingResponse *response = [materialBinding getZonesUsingParameters:aparams];
//        NSArray *responseBodyParts = response.bodyParts;
//
//        //        - (void)updateStockRequestsSuccessResponse:(NSDictionary *)successDictionary;
//        //        - (void)updateStockRequestsErrorResponse:(NSString *)errorResponse;
//
//        if (responseBodyParts == nil) {
//            [self.zoneMasterDelegate getZonesErrorResponse:NSLocalizedString(@"request_timeOut", nil)];
//        }
//        else{
//
//            for (id bodyPart in responseBodyParts) {
//                if ([bodyPart isKindOfClass:[ZoneMasterServiceSvc_getZonesResponse class]]) {
//
//                    ZoneMasterServiceSvc_getZonesResponse *body = (ZoneMasterServiceSvc_getZonesResponse *)bodyPart;
//                    NSError *e;
//
//                    NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                          options: NSJSONReadingMutableContainers
//                                                                            error: &e];
//                    if (![JSON1 isKindOfClass:[NSNull class]] && [[[JSON1 valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue] == 0) {
//
//                        [self.zoneMasterDelegate  getZonesSuccessResponse:JSON1];
//
//                    }
//                    else{
//
//                        [self.zoneMasterDelegate getZonesErrorResponse:[[JSON1 valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
//
//                    }
//
//                }
//                else{
//                    [self.zoneMasterDelegate getZonesErrorResponse:NSLocalizedString(@"soap_fault", nil)];
//
//                    //                    break;
//                }
//
//            }
//
//        }
//
//    } @catch (NSException *exception) {
//        [self.zoneMasterDelegate getZonesErrorResponse:exception.description];
//
//    }
//
//}





/**
 * @description  here we are calling the getmodels services to get all models....
 * @date         26/05/2017....
 * @method       getModelDetails:
 * @author       Bhargav
 * @param        NSStirng
 * @param
 * @return       void
 * @verified By
 * @verified On
 *
 */

-(void)getModelDetails:(NSString *)requestString {
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_MODEL_DETAILS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError * connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * modelResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                options:0
                                                                                  error:NULL];
                 
                 if( ([modelResponse.allKeys containsObject:RESPONSE_HEADER] && [[modelResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (modelResponse == nil)){
                     
                     [self.modelMasterDelegate getModelErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                     
                 }
                 else  if ([[[modelResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.modelMasterDelegate getModelSuccessResponse:modelResponse];
                 }
                 else {
                     [self.modelMasterDelegate getModelErrorResponse:[[modelResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.modelMasterDelegate getModelErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException *exception) {
        [self.modelMasterDelegate getModelErrorResponse:exception.description];
        
    }
}








-(BOOL)getPriceListThroughAsynchronousCall:(NSString *)requestParam {
    
    
    // RestFullCall.........
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_PRICE_LIST];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestParam];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *stockVerificationMasterResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                                 options:0
                                                                                                   error:NULL];
                 if ([[[stockVerificationMasterResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.skuServiceDelegate getPriceListSuccessResponse:stockVerificationMasterResponse];
                 }
                 else {
                     [self.skuServiceDelegate getSkuDetailsFailureResponse:[[stockVerificationMasterResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.skuServiceDelegate getSkuDetailsFailureResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException *exception) {
        [self.skuServiceDelegate getSkuDetailsFailureResponse:exception.description];
        
    }
    
}

#pragma - mark method used under the StoreStockVerificationDelegate....

//added on 31/05/2015... By Bhargav.v

//Commented by roja Use getProductVerificationRestFullService method for Get Product Verification Service...NO need to use this method(bcoz its in soap call)..


//-(void)getProductVerification:(NSString * )requestString {
//
//    @try {
//
//        storeStockVerificationServicesSoapBinding * utility =  [storeStockVerificationServicesSvc  storeStockVerificationServicesSoapBinding];
//        utility.logXMLInOut = YES;
//
//        storeStockVerificationServicesSvc_getProductVerification * category = [[storeStockVerificationServicesSvc_getProductVerification alloc] init];
//
//        category.getProductVerificationRequest = requestString;
//
//        storeStockVerificationServicesSoapBindingResponse * response = [utility getProductVerificationUsingParameters:category];
//
//
//        if (![response.error isKindOfClass:[NSError class]]) {
//            NSArray * responseBodyparts = response.bodyParts;
//
//            if (responseBodyparts != nil) {
//                for (id bodyPart in responseBodyparts) {
//
//                    if ([bodyPart isKindOfClass:[storeStockVerificationServicesSvc_getProductVerificationResponse class]]) {
//                        storeStockVerificationServicesSvc_getProductVerificationResponse *body = (storeStockVerificationServicesSvc_getProductVerificationResponse *)bodyPart;
////                        NSLog(@"response = %@",body.return_);
//                        NSError *e;
//
//                        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                             options: NSJSONReadingMutableContainers
//                                                                               error: &e];
//
//
//                        if( ([JSON.allKeys containsObject:RESPONSE_HEADER] && [[JSON valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (JSON == nil)){
//
//                            [self.storeStockVerificationDelegate getProductVerificationErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
//
//                        }
//
//                        else  if ( [[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue] == 0) {
//                            [self.storeStockVerificationDelegate getProductVerificationSuccessResponse:JSON];
//
//                        }
//                        else{
//                            [self.storeStockVerificationDelegate getProductVerificationErrorResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
//                        }
//                    }
//                    else {
//                        [self.storeStockVerificationDelegate getProductVerificationErrorResponse:@"unable_to_process_your_request"];
//                    }
//
//                }
//            }
//            else
//                [self.storeStockVerificationDelegate getProductVerificationErrorResponse:NSLocalizedString(@"request_time_out", nil)];
//        }
//        else{
//
//            [self.storeStockVerificationDelegate getProductVerificationErrorResponse:response.error.localizedDescription];
//        }
//
//    }
//    @catch (NSException *exception) {
//
//    }
//    @finally {
//
//    }
//
//}



/**
 * @description
 * @date         03/04/2019..
 * @method       getProductVerificationRestFullService:--
 * @author       Roja
 * @param
 * @param        NSString
 *
 * @return       Void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)getProductVerificationRestFullService:(NSString * )requestString {
    
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_PRODUCT_VERIFICATION];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        [request setHTTPMethod: @"GET"];
    
        @try {
            [NSURLConnection sendAsynchronousRequest:request
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:^(NSURLResponse *response,
                                                       NSData *data, NSError *connectionError)
             {
                 if (data.length > 0 && connectionError == nil)
                 {
                     NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                              options:0
                                                                                error:NULL];
                     
                     if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                         
                         [self.storeStockVerificationDelegate getProductVerificationErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                     }
                     else if ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                         
                         [self.storeStockVerificationDelegate getProductVerificationSuccessResponse:response];
                     }
                     else {
                         [self.storeStockVerificationDelegate getProductVerificationErrorResponse:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                     }
                 }
                 else {
                     [self.storeStockVerificationDelegate getProductVerificationErrorResponse:connectionError.localizedDescription];
                 }
             }];
        }
        @catch (NSException *exception) {
            
            [self.storeStockVerificationDelegate getProductVerificationErrorResponse:exception.description];
        }
}

// Commented by roja on 17/10/2019.. // reason :-  This method is not using anywhere of this file...

//-(void)getproductVerificationDetails:(NSString *)requestString{
//
//    @try {
//
//        storeStockVerificationServicesSoapBinding * productVerification =  [storeStockVerificationServicesSvc  storeStockVerificationServicesSoapBinding];
//
//        productVerification.logXMLInOut = YES;
//
//        storeStockVerificationServicesSvc_getProductVerificationDetails * details = [[storeStockVerificationServicesSvc_getProductVerificationDetails alloc] init];
//
//
//        details.getProductVerificationDetailsRequest = requestString;
//
//
//        storeStockVerificationServicesSoapBindingResponse * response = [productVerification getProductVerificationDetailsUsingParameters:details];
//
//
//        if (![response.error isKindOfClass:[NSError class]]) {
//            NSArray * responseBodyparts = response.bodyParts;
//
//            if (responseBodyparts != nil) {
//                for (id bodyPart in responseBodyparts) {
//
//                    if ([bodyPart isKindOfClass:[storeStockVerificationServicesSvc_getProductVerificationDetailsResponse class]]) {
//                        storeStockVerificationServicesSvc_getProductVerificationDetailsResponse *body = (storeStockVerificationServicesSvc_getProductVerificationDetailsResponse *)bodyPart;
////                        NSLog(@"response = %@",body.return_);
//                        NSError * e;
//
//                        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                             options: NSJSONReadingMutableContainers
//                                                                               error: &e];
//
//                        if( ([JSON.allKeys containsObject:RESPONSE_HEADER] && [[JSON valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (JSON == nil)){
//
//                            [self.storeStockVerificationDelegate getProductVerificationDetailsErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
//
//                        }
//
//                        else  if ( [[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue] == 0) {
//                            [self.storeStockVerificationDelegate getProductVerificationDetailsSuccessResponse:JSON];
//
//                        }
//                        else{
//                            [self.storeStockVerificationDelegate getProductVerificationDetailsErrorResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
//                        }
//                    }
//                    else {
//                        [self.storeStockVerificationDelegate getProductVerificationDetailsErrorResponse:@"unable_to_process_your_request"];
//                    }
//
//                }
//            }
//            else
//                [self.storeStockVerificationDelegate getProductVerificationDetailsErrorResponse:NSLocalizedString(@"request_time_out", nil)];
//        }
//        else{
//
//            [self.storeStockVerificationDelegate getProductVerificationDetailsErrorResponse:response.error.localizedDescription];
//        }
//
//    }
//    @catch (NSException *exception) {
//
//    }
//    @finally {
//
//    }
//    
//}



// Commented  by roja on 17/10/2019... // Reason: below method is not using anywhere of this file...

//-(void)createStockVerification:(NSString*)requestString{
//
//
//    storeStockVerificationServicesSoapBinding * utility =  [storeStockVerificationServicesSvc  storeStockVerificationServicesSoapBinding];
//    utility.logXMLInOut = YES;
//
//    storeStockVerificationServicesSvc_createStock * stock = [[storeStockVerificationServicesSvc_createStock alloc] init];
//
//    stock.stockVerificationDetails = requestString;
//
//    storeStockVerificationServicesSoapBindingResponse * response = [utility createStockUsingParameters:stock];
//
//
//    if (![response.error isKindOfClass:[NSError class]]) {
//        NSArray * responseBodyparts = response.bodyParts;
//
//        if (responseBodyparts != nil) {
//            for (id bodyPart in responseBodyparts) {
//
//                if ([bodyPart isKindOfClass:[storeStockVerificationServicesSvc_createStockResponse class]]) {
//                    storeStockVerificationServicesSvc_createStockResponse *body = (storeStockVerificationServicesSvc_createStockResponse *)bodyPart;
////                    NSLog(@"response = %@",body.return_);
//                    NSError *e;
//
//                    NSDictionary * JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                          options: NSJSONReadingMutableContainers
//                                                                            error: &e];
//
//                    if( ([JSON.allKeys containsObject:RESPONSE_HEADER] && [[JSON valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (JSON == nil)){
//
//                        [self.storeStockVerificationDelegate createStockVerificationErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
//
//                    }
//
//                    else  if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue]==0) {
//                        [self.storeStockVerificationDelegate createStockVerificationSuccessResponse:JSON];
//
//                    }
//                    else{
//                        [self.storeStockVerificationDelegate createStockVerificationErrorResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
//                    }
//                }
//                else {
//                    [self.storeStockVerificationDelegate createStockVerificationErrorResponse:@"unable_to_process_your_request"];
//                }
//
//            }
//        }
//        else
//            [self.storeStockVerificationDelegate createStockVerificationErrorResponse:NSLocalizedString(@"request_time_out", nil)];
//    }
//
//}


/**
 * @description
 * @date         03/04/2019..
 * @method       createStockVerificationRestFullService:--
 * @author       Roja
 * @param
 * @param        NSString
 *
 * @return       Void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */
-(void)createStockVerificationRestFullService:(NSString * )requestString {
    
    @try {
        
        NSString * serviceUrl = [WebServiceUtility getURLFor:CREATE_STOCK_VERIFICATION];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  * request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                              timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * walkOutResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                  options:0
                                                                                    error:NULL];
                 
                 if( ([walkOutResponse.allKeys containsObject:RESPONSE_HEADER] && [[walkOutResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (walkOutResponse == nil)){
                     
                     [self.storeStockVerificationDelegate createStockVerificationErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else  if ([[[walkOutResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.storeStockVerificationDelegate createStockVerificationSuccessResponse:walkOutResponse];
                 }
                 else {
                     
                     [self.storeStockVerificationDelegate createStockVerificationErrorResponse:[[walkOutResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 
                 [self.storeStockVerificationDelegate createStockVerificationErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.storeStockVerificationDelegate createStockVerificationErrorResponse:exception.description];
    }
    
}

/**
 * @description
 * @date         03/04/2019..
 * @method       upDateStockVerificationRestFullService:--
 * @author       Roja
 * @param
 * @param        NSString
 *
 * @return       Void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */
-(void)upDateStockVerificationRestFullService:(NSString *)requestString{
    
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:UPDATE_STOCK_VERIFICATION];
        serviceUrl = [NSString stringWithFormat:@"%@",serviceUrl];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * customerResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                   options:0
                                                                                     error:NULL];
                 
                 if( ([customerResponse.allKeys containsObject:RESPONSE_HEADER] && [[customerResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (customerResponse == nil)){
                     
                     [self.storeStockVerificationDelegate updateStockVerificationErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                     
                 }
                 else  if ([[[customerResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     
                     [self.storeStockVerificationDelegate updateStockVerificationSuccessResponse:customerResponse];
                 }
                 else {
                     [self.storeStockVerificationDelegate updateStockVerificationSuccessResponse:[[customerResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.storeStockVerificationDelegate updateStockVerificationErrorResponse:@""];
             }
         }];
    }
    @catch (NSException * exception) {
        
        [self.storeStockVerificationDelegate updateStockVerificationErrorResponse:exception.description];
    }
    
}


-(void)upDateStockVerification:(NSString *)requestString{
    
    storeStockVerificationServicesSoapBinding * utility =  [storeStockVerificationServicesSvc  storeStockVerificationServicesSoapBinding];
    utility.logXMLInOut = YES;
    
    storeStockVerificationServicesSvc_updateStock * stock = [[storeStockVerificationServicesSvc_updateStock alloc] init];
    
    stock.stockVerificationDetails = requestString;
    
    storeStockVerificationServicesSoapBindingResponse * response = [utility updateStockUsingParameters:stock];
    
    
    if (![response.error isKindOfClass:[NSError class]]) {
        NSArray * responseBodyparts = response.bodyParts;
        
        if (responseBodyparts != nil) {
            for (id bodyPart in responseBodyparts) {
                
                if ([bodyPart isKindOfClass:[storeStockVerificationServicesSvc_updateStockResponse class]]) {
                    storeStockVerificationServicesSvc_updateStockResponse *body = (storeStockVerificationServicesSvc_updateStockResponse *)bodyPart;
//                    NSLog(@"response = %@",body.return_);
                    NSError *e;
                    
                    NSDictionary * JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                                          options: NSJSONReadingMutableContainers
                                                                            error: &e];
                    
                    if( ([JSON.allKeys containsObject:RESPONSE_HEADER] && [[JSON valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (JSON == nil)){
                        
                        [self.storeStockVerificationDelegate updateStockVerificationErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                        
                    }
                    
                    else if ( [[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue] == 0) {
                        [self.storeStockVerificationDelegate updateStockVerificationSuccessResponse:JSON];
                        
                    }
                    else{
                        [self.storeStockVerificationDelegate updateStockVerificationErrorResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                    }
                }
                else {
                    [self.storeStockVerificationDelegate updateStockVerificationErrorResponse:@"unable_to_process_your_request"];
                }
                
            }
        }
        else
            [self.storeStockVerificationDelegate updateStockVerificationErrorResponse:NSLocalizedString(@"request_time_out", nil)];
    }
    
}




/**
 * @description
 * @date
 * @method
 * @author
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 * @modified By  Srinivasulu on 10/06/2017....
 * @reason       addded the response null handling....
 *
 */

-(void)getStockRequestSummaryInfo:(NSString *)requestString {
    
    // RestFullCall.........
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_STOCKREQUEST_SUMMARY];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * stockRequestResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                      options:0
                                                                                        error:NULL];
                 
                 
                 
                 if( ([stockRequestResponse.allKeys containsObject:RESPONSE_HEADER] && [[stockRequestResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (stockRequestResponse == nil)){
                     
                     [self.stockRequestDelegate getStockRequestSummaryErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                     
                 }
                 
                 else if ([[[stockRequestResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.stockRequestDelegate getStockRequestSummarySuccessResponse:stockRequestResponse];
                 }
                 else {
                     
                     [self.stockRequestDelegate getStockRequestSummaryErrorResponse:[[stockRequestResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 
                 [self.stockRequestDelegate getStockRequestSummaryErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException *exception) {
      
        [self.stockRequestDelegate getStockRequestSummaryErrorResponse:exception.description];
    }
    
}

/**
 * @description
 * @date
 * @method
 * @author
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 * @modified By  Srinivasulu on 13/06/2017....
 * @reason       addded the response null handling....
 *
 */

-(void)getStockVerificationMasterDetails:(NSString *)requestString {
    
    @try {
        
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_VERIFICATION_CODE];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             
             if (data.length > 0 && connectionError == nil)
             {
                 
                 NSDictionary * stockVerificationMasterResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                                  options:0
                                                                                                    error:NULL];
                 
                 
                 if( ([stockVerificationMasterResponse.allKeys containsObject:RESPONSE_HEADER] && [[stockVerificationMasterResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (stockVerificationMasterResponse == nil)){
                     
                     [self.stockVerificationDelegate getStockVerificationMasterDetailsErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                     
                 }
                 
                 else  if ([[[stockVerificationMasterResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.stockVerificationDelegate getStockVerificationMasterDetailsSuccessResponse:stockVerificationMasterResponse];
                 }
                 else {
                     [self.stockVerificationDelegate getStockVerificationMasterDetailsErrorResponse:[[stockVerificationMasterResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.stockVerificationDelegate getStockVerificationMasterDetailsErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException * exception) {
        [self.stockRequestDelegate getStockRequestSummaryErrorResponse:exception.description];
        
    }
    
}

#pragma -mark method implemented under the storeTaxationDelegate....

/**
 * @description  here we are calling the service to get all taxes in an store and then storing them in local.......
 * @date         03/07/2017....
 * @method       getStoreTaxesInDetail:--
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return       BOOL
 * @verified By
 * @verified On
 *
 *
 */

-(BOOL)getStoreTaxesInDetail:(NSString *)requestString{

    
    BOOL status = false;

    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_STORE_TAX_DETAILS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        //  [NSURLConnection sendAsynchronousRequest:request
        //                                           queue:[NSOperationQueue mainQueue]
        //                               completionHandler:^(NSURLResponse *response,
        //                                                   NSData *data, NSError *connectionError)
        //{
        
        //------ below code has to be here if service are called throught Asynchronous call....
        
        //         }];

        if (data.length > 0 && connectionError == nil)
        {
            NSError *err;
            
            NSDictionary * taxDetailResponseDic  = [NSJSONSerialization JSONObjectWithData:data
                                                                  options:kNilOptions
                                                                    error:&err];
            
            
            if (taxDetailResponseDic.count) {
                
                if( ([taxDetailResponseDic.allKeys containsObject:RESPONSE_HEADER] && [[taxDetailResponseDic valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (taxDetailResponseDic == nil)){
                    
                status = [self.storeTaxationDelegate getStoreTaxesInDeatailErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                    
                }
                
                else if ([[[taxDetailResponseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                    
                    status =  [self.storeTaxationDelegate getStoreTaxesInDetailSuccessResponse:taxDetailResponseDic];
                }
                else {
                    
                    status = [self.storeTaxationDelegate getStoreTaxesInDeatailErrorResponse:[[taxDetailResponseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                }
            }
            else {
                
                status = [self.storeTaxationDelegate getStoreTaxesInDeatailErrorResponse:@"no_data_found"];
            }
            
        }
        else {
            
            status = [self.storeTaxationDelegate getStoreTaxesInDeatailErrorResponse:connectionError.localizedDescription];
        }
        
    } @catch (NSException *exception) {
        
        status = [self.storeTaxationDelegate getStoreTaxesInDeatailErrorResponse:exception.description];
    } @finally {
        
        return status;
    }

}

/**
 * @description  here we are calling the service to get all taxes in an store and then storing them in local.......
 * @date         03/07/2017....
 * @method       getStoreTaxesInDetail:--
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return       BOOL
 * @verified By
 * @verified On
 *
 *
 */


// Commented by roja on 17/10/2019.. // reason :- getStoreTaxesInDetailThroughSoapServiceCall: method contains SOAP Service call .. so taken new method with same name(getStoreTaxesInDetailThroughSoapServiceCall:) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//-(BOOL)getStoreTaxesInDetailThroughSoapServiceCall:(NSString *)requestString{
//
//
//    BOOL status = false;
//
//    @try {
//
//
//        StoreTaxationServiceSoapBinding * utility = [StoreTaxationService StoreTaxationServiceSoapBinding];
//        utility.logXMLInOut = NO;
//
//        StoreTaxationService_getStoreTaxation * storeTaxation = [[StoreTaxationService_getStoreTaxation alloc] init];
//        storeTaxation.getStoreTaxationStr = requestString;
//
//        StoreTaxationServiceSoapBindingResponse * response = [utility getStoreTaxationUsingParameters:storeTaxation];
//
//        if (![response.error isKindOfClass:[NSError class]]) {
//            NSArray * responseBodyparts = response.bodyParts;
//
//            if (responseBodyparts != nil) {
//                for (id bodyPart in responseBodyparts) {
//
//                    if ([bodyPart isKindOfClass:[StoreTaxationService_getStoreTaxationResponse class]]) {
//                        StoreTaxationService_getStoreTaxationResponse *body = (StoreTaxationService_getStoreTaxationResponse *)bodyPart;
//
//                        NSError *e;
//
//                        NSDictionary * JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                              options: NSJSONReadingMutableContainers
//                                                                                error: &e];
//
//                        if( ([JSON.allKeys containsObject:RESPONSE_HEADER] && [[JSON valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (JSON == nil)){
//
//                            status = [self.storeTaxationDelegate getStoreTaxesInDeatailErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
//
//                        }
//
//                        else  if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue]==0) {
//                           status =  [self.storeTaxationDelegate getStoreTaxesInDetailSuccessResponse:JSON];
//
//                        }
//                        else{
//                           status = [self.storeTaxationDelegate getStoreTaxesInDeatailErrorResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
//                        }
//
//                    }
//                }
//            }
//            else
//                status = [self.storeTaxationDelegate getStoreTaxesInDeatailErrorResponse:@"no_data_found"];
//
//        }
//        else
//            status = [self.storeTaxationDelegate getStoreTaxesInDeatailErrorResponse:@"no_data_found"];
//
//
//    } @catch (NSException *exception) {
//
//        status = [self.storeTaxationDelegate getStoreTaxesInDeatailErrorResponse:exception.description];
//    } @finally {
//
//        return status;
//    }
//
//}

/**
 * @description  This Method is used when the verification is in writeOff State...
 * @date         15/07/2017
 * @method       doWriteOfStockVerification
 * @author       Bhargav
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)doWriteOfStockVerification:(NSString *)requestString {
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:STOCK_WRITE_OFF];
        serviceUrl = [NSString stringWithFormat:@"%@",serviceUrl];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * customerResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                   options:0
                                                                                     error:NULL];
                 
                 if( ([customerResponse.allKeys containsObject:RESPONSE_HEADER] && [[customerResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (customerResponse == nil)){
                     
                     [self.storeStockVerificationDelegate updateStockVerificationErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                     
                 }
                 else  if ([[[customerResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     
                     [self.storeStockVerificationDelegate updateStockVerificationSuccessResponse:customerResponse];
                 }
                 else {
                     [self.storeStockVerificationDelegate updateStockVerificationSuccessResponse:[[customerResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.storeStockVerificationDelegate updateStockVerificationErrorResponse:@""];
             }
         }];
    }
    @catch (NSException * exception) {
        
        [self.storeStockVerificationDelegate updateStockVerificationErrorResponse:exception.description];
    }
    
}

/**
 * @description  This Method is used to get the Master Details When we select StartVerification Button
 * @date         18/07/2017
 * @method       getStockVerificationMasterChildDetails
 * @author       Bhargav
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getStockVerificationMasterChildDetails:(NSString *)requestString {
    
    
    
    @try {
        NSString * serviceUrl = [WebServiceUtility getURLFor:GET_STOCKVERIFICATION_MASTER_CHILDS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * stockVerificationMasterResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                                  options:0
                                                                                                    error:NULL];
                 if ([[[stockVerificationMasterResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.stockVerificationDelegate getStockVerificationMasterChildSuccessResponse:stockVerificationMasterResponse];
                 }
                 else {
                     [self.stockVerificationDelegate getStockVerificationMasterChildsErrorResponse:[[stockVerificationMasterResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.stockVerificationDelegate getStockVerificationMasterChildsErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException * exception) {
        [self.stockVerificationDelegate
         
         getStockVerificationMasterChildsErrorResponse:exception.description];
        
    }
    
}

//Added By Bhargav.v on 14/06/2017.....
/*
 * @description  we are calling the skuDetails for the particular category
 * @date         14/06/2017...
 * @method       getPriceListSkuDetails
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 */


-(void)getPriceListSkuDetails:(NSString *)requestString{
    
    // RestFullCall.........
    
    @try {
        NSString * serviceUrl = [WebServiceUtility getURLFor:GET_PRICELIST_SKU_DETAILS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * skuDetailsResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                     options:0
                                                                                       error:NULL];
                 
                 if( ([skuDetailsResponse.allKeys containsObject:RESPONSE_HEADER] && [[skuDetailsResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (skuDetailsResponse == nil)){
                     
                     [self.skuServiceDelegate getPriceListSKuDetailsErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 
                 else if ([[[skuDetailsResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.skuServiceDelegate getPriceListSkuDetailsSuccessResponse:skuDetailsResponse];
                 }
                 else {
                     
                     [self.skuServiceDelegate getPriceListSKuDetailsErrorResponse:[[skuDetailsResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 
                 [self.skuServiceDelegate getPriceListSKuDetailsErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException *exception) {
        
        [self.skuServiceDelegate getPriceListSKuDetailsErrorResponse:exception.description];
    }
    
}


/**
 * @description
 * @date         07/08/2017
 * @method       getWorkFlows
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getWorkFlows:(NSString*)requestString {
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_WORKFLOWS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        {
            if (data.length > 0 && connectionError == nil)
            {
                NSError * err;
                NSDictionary * workFlowDetailsDic  = [NSJSONSerialization JSONObjectWithData:data
                                                                                     options:0
                                                                                       error:&err];
                if (workFlowDetailsDic.count) {
                    
                    if( ([workFlowDetailsDic.allKeys containsObject:RESPONSE_HEADER] && [[workFlowDetailsDic valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (workFlowDetailsDic == nil)){
                        
                        [self.rolesServiceDelegate gerWorkFlowsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                    }
                    else if ([[[workFlowDetailsDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                        
                        [self.rolesServiceDelegate getWorkFlowsSuccessResponse:workFlowDetailsDic];
                    }
                    else {
                        [self.rolesServiceDelegate gerWorkFlowsErrorResponse:[[workFlowDetailsDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                    }
                }
                else {
                    [self.rolesServiceDelegate gerWorkFlowsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                }
            }
            else {
                
                [self.rolesServiceDelegate gerWorkFlowsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
            }
            
        }
        
    }
    @catch (NSException *exception) {
        [self.rolesServiceDelegate gerWorkFlowsErrorResponse:exception.description];
        
    }
    @finally {
        
    }
    
}


/**
 * @description  here we are sending the requeest to service to get the hourwise reports...
 * @date         24/08/2017....
 * @method       getHourWiseReports..
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 *
 * @modified By Srinivasul on 21/09/2017....
 * @reason      added the exception handling....
 *
 * @verified By
 * @verified On
 *
 */

// Commented by roja on 17/10/2019.. // reason :- getHourWiseReports: method contains SOAP Service call .. so taken new method with same name(getHourWiseReports:) method name which contains REST service call....
// At the time of converting SOAP call's to REST


//-(void)getHourWiseReports:(NSString *)requestString{
//
//    @try {
//
//        SalesServiceSvcSoapBinding * utility =  [SalesServiceSvc  SalesServiceSvcSoapBinding];
//        utility.logXMLInOut = YES;
//
//        SalesServiceSvc_getHourWiseReport * stock = [[SalesServiceSvc_getHourWiseReport alloc] init];
//
//        stock.searchCriteria = requestString;
//
//        SalesServiceSvcSoapBindingResponse * response = [utility getHourWiseReportUsingParameters:stock];
//
//
//        if (![response.error isKindOfClass:[NSError class]]) {
//            NSArray * responseBodyparts = response.bodyParts;
//
//            if (responseBodyparts != nil) {
//                for (id bodyPart in responseBodyparts) {
//
//                    if ([bodyPart isKindOfClass:[SalesServiceSvc_getHourWiseReportResponse class]]) {
//                         SalesServiceSvc_getHourWiseReportResponse *body = (SalesServiceSvc_getHourWiseReportResponse *)bodyPart;
//                        //                    NSLog(@"response = %@",body.return_);
//                        NSError * e;
//
//                        NSDictionary * JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                              options: NSJSONReadingMutableContainers
//                                                                                error: &e];
//
//                        if( ([JSON.allKeys containsObject:RESPONSE_HEADER] && [[JSON valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (JSON == nil)){
//
//                            [self.salesServiceDelegate getHourWiseReportErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
//
//                        }
//
//                        else if ( [[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue] == 0) {
//                            [self.salesServiceDelegate getHourWiseReportsSuccessResponse:JSON];
//
//                        }
//
//                        else if (( [[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue] == -1)){
//                            [self.salesServiceDelegate getHourWiseReportErrorResponse:@""];
//
//                        }
//
//                        else{
//                            [self.salesServiceDelegate getHourWiseReportsSuccessResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
//                        }
//                    }
//                    else {
//                        [self.salesServiceDelegate getHourWiseReportErrorResponse:@"unable_to_process_your_request"];
//                    }
//
//                }
//            }
//            else
//                [self.salesServiceDelegate getHourWiseReportErrorResponse:NSLocalizedString(@"request_time_out", nil)];
//        }
//        else
//            [self.salesServiceDelegate getHourWiseReportErrorResponse:NSLocalizedString(@"request_time_out", nil)];
//    } @catch (NSException *exception) {
//
//        [self.salesServiceDelegate getHourWiseReportErrorResponse:exception.description];
//    }
//
//}


/**
 * @description  we are sending the request to get the product classes from sku Service....
 * @date         24/08/2017...
 * @method       getProductClass
 * @author       Bhargav.v
 * @param        requestString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getProductClass:(NSString *)requestString {
    
    // RestFullCall.........
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_PRODUCT_CLASSES];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * productResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                  options:0
                                                                                    error:NULL];
                 
                 if( ([productResponse.allKeys containsObject:RESPONSE_HEADER] && [[productResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (productResponse == nil)){
                     
                     [self.skuServiceDelegate getProductClassErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else  if ([[[productResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.skuServiceDelegate getProductClassSuccessResponse:productResponse];
                 }
                 else {
                     
                     [self.skuServiceDelegate getProductClassSuccessResponse:[[productResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 
                 [self.skuServiceDelegate getProductClassErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException *exception) {
        [self.skuServiceDelegate getProductClassErrorResponse:exception.description];
        
    }
}

/**
 * @description  we are sending the request to get the product classes from sku Service....
 * @date         28/08/2017
 * @method       getProductClass
 * @author       Bhargav.v
 * @param        requestString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getVoidItemsReport:(NSString*)requestString{
    
    // RestFullCall.........
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_SALES_VOID_ITEM_REPORTS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * productResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                  options:0
                                                                                    error:NULL];
                 
                 if( ([productResponse.allKeys containsObject:RESPONSE_HEADER] && [[productResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (productResponse == nil)){
                     
                     [self.salesServiceDelegate getVoidItemReportErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else  if ([[[productResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.salesServiceDelegate getVoidItemReportsSuccessResponse:productResponse];
                 }
                 else {
                     [self.salesServiceDelegate getVoidItemReportErrorResponse:[[productResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 
                 [self.salesServiceDelegate getVoidItemReportErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException *exception) {
        
        [self.salesServiceDelegate getVoidItemReportErrorResponse:exception.description];
    }
}


/**
 * @description  we are sending the request  ....
 * @date         28/08/2017
 * @method       getOverrideSales
 * @author       Bhargav.v
 * @param        requestString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getOverrideSales:(NSString *)requestString{
    
    // RestFullCall.........
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_SALESPRICE_OVERRIDE_REPORT];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * productResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                  options:0
                                                                                    error:NULL];
                 
                 if( ([productResponse.allKeys containsObject:RESPONSE_HEADER] && [[productResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (productResponse == nil)){
                     
                     [self.salesServiceDelegate getSalesPriceOverrideReportErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                     
                 }
                 
                 else  if ([[[productResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.salesServiceDelegate getSalesPriceOverrideReportSuccessReponse:productResponse];
                 }
                 else {
                     
                     [self.salesServiceDelegate getSalesPriceOverrideReportErrorResponse:[[productResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 
                 [self.salesServiceDelegate getSalesPriceOverrideReportErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException *exception) {
       
        [self.salesServiceDelegate getSalesPriceOverrideReportErrorResponse:exception.description];
    }
}

/**
 * @description  we are sending the request  ....
 * @date         18/09/2017
 * @method       getSalesMenCommission
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getSalesMenCommission:(NSString *)requestString{
    
    // RestFullCall.........
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_SALESMEN_COMMISSION_REPORT];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * productResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                  options:0
                                                                                    error:NULL];
                 
                 if( ([productResponse.allKeys containsObject:RESPONSE_HEADER] && [[productResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (productResponse == nil)){
                     
                     [self.salesServiceDelegate getSalesMenCommissionReportErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else  if ([[[productResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.salesServiceDelegate getSalesMenCommissionReportSuccessResponse:productResponse];
                 }
                 else {
                     
                     [self.salesServiceDelegate getSalesMenCommissionReportErrorResponse:[[productResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 
                 [self.salesServiceDelegate getSalesMenCommissionReportErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException * exception) {
        
        [self.salesServiceDelegate getSalesMenCommissionReportErrorResponse:exception.description];
    }
}

/**
 * @description  here we are calling Z - report Service call....
 * @date         10/10/2017....
 * @method       createNewCustomerWalkinsInfo:--
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @param
 *
 * @return       void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)createNewCustomerWalkinsInfo:(NSString *)requestString{
    
    @try {
        
        NSString * serviceUrl = [WebServiceUtility getURLFor:CREATE_NEW_CUSTOMER_WALKINS];
        serviceUrl = [NSString stringWithFormat:@"%@",serviceUrl];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  * request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                              timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * walkOutResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                 options:0
                                                                                   error:NULL];
                 
                 if( ([walkOutResponse.allKeys containsObject:RESPONSE_HEADER] && [[walkOutResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (walkOutResponse == nil)){
                     
                     [self.customerWalkoutDelegate createCustomerWalkinsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else  if ([[[walkOutResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.customerWalkoutDelegate createCustomerWalkinsSuccessResponse:walkOutResponse];
                 }
                 else {
                     
                     [self.customerWalkoutDelegate createCustomerWalkinsErrorResponse:[[walkOutResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 
                 [self.customerWalkoutDelegate createCustomerWalkinsErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.customerWalkoutDelegate createCustomerWalkinsErrorResponse:exception.description];
    }
    
}


/**
 * @description  here we are sending the requeest to DB to get the Daily Stock report...
 * @date         28/11/2017....
 * @method       getDailyStockReport..
 * @author       Bhargav.v
 * @param        NSString
 * @param
 *
 * @return
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)getDailyStockReport:(NSString *)requestString {
    
    // RestFullCall.........
    
    @try {
        NSString * serviceUrl = [WebServiceUtility getURLFor:GET_DAILY_STOCK_REPORT];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * dailyStockResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                     options:0
                                                                                       error:NULL];
                 
                 if( ([dailyStockResponse.allKeys containsObject:RESPONSE_HEADER] && [[dailyStockResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (dailyStockResponse == nil)){
                     
                     [self.salesServiceDelegate getDailyStockReportErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else  if ([[[dailyStockResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE]intValue] == 0) {
                     
                     [self.salesServiceDelegate getDailyStockReportSuccessResponse:dailyStockResponse];
                 }
                 else {
                     
                     [self.salesServiceDelegate getDailyStockReportErrorResponse:[[dailyStockResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 
                 [self.salesServiceDelegate getDailyStockReportErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException * exception) {
        
        [self.salesServiceDelegate getDailyStockReportErrorResponse:exception.description];
    }
}
/**
 * @description  calling the Categories Based on Location...
 * @date         20/12/2017
 * @method       getCategoriesByLocation
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)getCategoriesByLocation:(NSString *)requesString {
    
    // RestFullCall.........
    
    @try {
        
        NSString * serviceUrl = [WebServiceUtility getURLFor:GET_CATEGORIES_BY_LOCATION];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requesString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * categoriesDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:0
                                                                                         error:NULL];
                 
                 if( ([categoriesDictionary.allKeys containsObject:RESPONSE_HEADER] && [[categoriesDictionary valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (categoriesDictionary == nil)){
                     
                     [self.skuServiceDelegate getCategoriesByLocationErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else  if ([[[categoriesDictionary valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE]intValue] == 0) {
                     
                     [self.skuServiceDelegate getCategoriesByLocationSuccessResponse:categoriesDictionary];
                 }
                 else {
                     
                     [self.skuServiceDelegate getCategoriesByLocationErrorResponse:[[categoriesDictionary valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 
                 [self.skuServiceDelegate getCategoriesByLocationErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException * exception) {
        
        [self.skuServiceDelegate getCategoriesByLocationErrorResponse:exception.description];
    }
    
}

/**
 * @description  calling the Categories Based on Location...
 * @date         20/12/2017
 * @method       getCategoriesByLocation
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)getBrandsByLocation:(NSString *)requestString {
    
    // RestFullCall.........
    
    @try {
        
        NSString * serviceUrl = [WebServiceUtility getURLFor:GET_BRANDS_BY_LOCATION];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * brandDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                                  options:0
                                                                                    error:NULL];
                 
                 if( ([brandDictionary.allKeys containsObject:RESPONSE_HEADER] && [[brandDictionary valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (brandDictionary == nil)){
                     
                     [self.skuServiceDelegate getBrandsByLocationErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else  if ([[[brandDictionary valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE]intValue] == 0) {
                     
                     [self.skuServiceDelegate getBrandsByLocationSuccessResponse:brandDictionary];
                 }
                 else {
                     
                     [self.skuServiceDelegate getBrandsByLocationErrorResponse:[[brandDictionary valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 
                 [self.skuServiceDelegate getBrandsByLocationErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException * exception) {
        
        [self.skuServiceDelegate getBrandsByLocationErrorResponse:exception.description];
    }
    
}

/**
 * @description  here we are calling the generateOtp for customer....
 * @date         26/12/2017....
 * @method       generateCustomerOtp:--
 * @author       Srinivasulu
 * @param
 * @param        NSString
 *
 * @return       void
 *
 * @modified By  
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)generateCustomerOtp:(NSString *)requestString{
    
    @try {
        
        NSString * serviceUrl = [WebServiceUtility getURLFor:GENERATE_CUSTOMER_OTP];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  * request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                              timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * walkOutResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                  options:0
                                                                                    error:NULL];
                 
                 if( ([walkOutResponse.allKeys containsObject:RESPONSE_HEADER] && [[walkOutResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (walkOutResponse == nil)){
                     
                     [self.customerServiceDelegate generateOtpForCustomerErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else  if ([[[walkOutResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.customerServiceDelegate generateOtpForCustomerSuccessReponse:walkOutResponse];
                 }
                 else {
                     
                     [self.customerServiceDelegate generateOtpForCustomerErrorResponse:[[walkOutResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 
                 [self.customerServiceDelegate generateOtpForCustomerErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.customerServiceDelegate generateOtpForCustomerErrorResponse:exception.description];
    }
    
}

/**
 * @description  here we are calling the validate OTPService to validate user enter OTP is correct or not....
 * @date         26/12/2017....
 * @method       validateCustomerOtp:--
 * @author       Srinivasulu
 * @param
 * @param        NSString
 *
 * @return       void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)validateCustomerOtp:(NSString *)requestString{
    
    @try {
        
        NSString * serviceUrl = [WebServiceUtility getURLFor:VALIDATE_CUSTOMER_OTP];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  * request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                              timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * walkOutResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                  options:0
                                                                                    error:NULL];
                 
                 if( ([walkOutResponse.allKeys containsObject:RESPONSE_HEADER] && [[walkOutResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (walkOutResponse == nil)){
                     
                     [self.customerServiceDelegate validateForCustomerErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else  if ([[[walkOutResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.customerServiceDelegate validateOtpForCustomerSuccessResponse:walkOutResponse];
                 }
                 else {
                     
                     [self.customerServiceDelegate validateForCustomerErrorResponse:[[walkOutResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 
                 [self.customerServiceDelegate validateForCustomerErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.customerServiceDelegate validateForCustomerErrorResponse:exception.description];
    }
    
}

/**
 * @description  here we are calling the validate OTPService to validate user enter OTP is correct or not....
 * @date         29/12/2017....
 * @method       getGiftVoucherDetails:--
 * @author       Srinivasulu
 * @param
 * @param        NSString
 *
 * @return       void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */
// Commented by roja on 17/10/2019.. // reason :- getGiftVoucherDetails: method contains SOAP Service call .. so taken new method with same name(getGiftVoucherDetails:) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//-(void)getGiftVoucherDetails:(NSString *)requestString{
//
//    @try {
//
//        GiftVoucherServicesSoapBinding * skuService = [GiftVoucherServices GiftVoucherServicesSoapBinding] ;
//        GiftVoucherServices_getGiftVoucherDetails * voucher = [[GiftVoucherServices_getGiftVoucherDetails alloc] init];
//        voucher.giftVoucherDetails = requestString;
//
//
//        GiftVoucherServicesSoapBindingResponse *response = [skuService getGiftVoucherDetailsUsingParameters:voucher];
//        if (![response.error isKindOfClass:[NSError class]]) {
//            NSArray * responseBodyParts = response.bodyParts;
//
//            if (responseBodyParts != nil) {
//                for (id bodyPart in responseBodyParts) {
//                    if ([bodyPart isKindOfClass:[GiftVoucherServices_getGiftVoucherDetailsResponse class]]) {
//                        GiftVoucherServices_getGiftVoucherDetailsResponse * body = (GiftVoucherServices_getGiftVoucherDetailsResponse *)bodyPart;
//                        // NSLog(@"response = %@",body.return_);
//                        NSError *e;
//
//                        NSDictionary * JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers
//                                                                                error: &e];
//
//
//
//                        if( ([JSON.allKeys containsObject:RESPONSE_HEADER] && [[JSON valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (JSON == nil)){
//
//                            [self.giftVoucherServicesDelegate getGiftVoucherDetailsErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
//
//                        }
//
//                        else  if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue]==0) {
//
//                            [self.giftVoucherServicesDelegate getGiftVoucherDetailsSuccessReponse:JSON];
//                        }
//                        else{
//                            [self.giftVoucherServicesDelegate getGiftVoucherDetailsErrorResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
//                        }
//
//                    }
//                    else {
//                        [self.giftVoucherServicesDelegate getGiftVoucherDetailsErrorResponse:@"unable_to_process_your_request"];
//                    }
//                }
//
//            }
//            else
//                [self.giftVoucherServicesDelegate getGiftVoucherDetailsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
//
//        }
//        else{
//
//            [self.giftVoucherServicesDelegate getGiftVoucherDetailsErrorResponse:response.error.localizedDescription];
//        }
//
//    } @catch (NSException *exception) {
//
//        [self.giftVoucherServicesDelegate getGiftVoucherDetailsErrorResponse:exception.description];
//    }
//
//}




/**
 * @description  here we are calling the validate OTPService to validate user enter OTP is correct or not....
 * @date         29/12/2017....
 * @method       getGiftCouponDetails:--
 * @author       Srinivasulu
 * @param
 * @param        NSString
 *
 * @return       void
 *
 * @modified By  Bhargav on 22/08/2018
 * @reason       changed to restfull services..
 *
 * @verified By
 * @verified On
 *
 */

-(void)getGiftCouponDetails:(NSString *)requestString{
    
    @try {
        NSString * serviceUrl = [WebServiceUtility getURLFor:GET_COUPON_DETAILS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        [request setHTTPMethod: @"GET"];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * couponDetailsResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:0
                                                                                          error:NULL];
                 
                 if( ([[couponDetailsResponse allKeys] containsObject:RESPONSE_HEADER] && [[couponDetailsResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (couponDetailsResponse == nil)){
                     
                     [self.giftCouponServicesDelegate getGiftCouponDetailsErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else  if ([[[couponDetailsResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE]intValue] == 0) {
                     
                     [self.self.giftCouponServicesDelegate getGiftCouponDetailsSuccessReponse:couponDetailsResponse];
                 }
                 else {
                     
                     [self.giftCouponServicesDelegate getGiftCouponDetailsErrorResponse:[[couponDetailsResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 
                 [self.giftCouponServicesDelegate getGiftCouponDetailsErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException * exception) {
        
        [self.giftCouponServicesDelegate getGiftCouponDetailsErrorResponse:exception.description];
    }
}

/**
 * @description  here we are send the request string to access the server and getting couponsMaster information..
 * @date         21/11/2018
 * @method       getAllGiftCouponsMasterThroughSynchronousRequest:--
 * @author
 * @param        NSString
 * @param
 * @return       BOOL
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(BOOL)getAllGiftCouponsMasterThroughSynchronousRequest:(NSString *)requestString{
    BOOL serviceCallStatus = false;
    
    @try {
        
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_GIFT_COUPONS_MASTER];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  * request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        if (data.length > 0 && connectionError == nil)
        {
            NSError * err;
            
            NSDictionary * couponsDetailsResponseDic  = [NSJSONSerialization JSONObjectWithData:data
                                                                                     options:kNilOptions
                                                                                       error:&err];
            
            
            if (couponsDetailsResponseDic.count) {
                
                if( ([couponsDetailsResponseDic.allKeys containsObject:RESPONSE_HEADER] && [[couponsDetailsResponseDic valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (couponsDetailsResponseDic == nil)){
                    
                    [self.giftCouponServicesDelegate getAllGiftCouponsMasterErrorResponseAndReturnSaveStatus:NSLocalizedString(@"unable_to_process_your_request", nil)];
                }
                else if ([[[couponsDetailsResponseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                    
                    [self.giftCouponServicesDelegate getAllGiftCouponsMasterSuccessResponseAndReturnSaveStatus:couponsDetailsResponseDic];
                    serviceCallStatus = true;
                }
                else {
                    
                    NSString * responseMsg = [[couponsDetailsResponseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE];
                    [self.giftCouponServicesDelegate getAllGiftCouponsMasterErrorResponseAndReturnSaveStatus:responseMsg];
                    if ([responseMsg isEqualToString:NO_RECORDS_FOUND]) {
                        serviceCallStatus = true;
                    }
                }
            }
            else {
                [self.giftCouponServicesDelegate getAllGiftCouponsMasterErrorResponseAndReturnSaveStatus:NSLocalizedString(@"unable_to_process_your_request", nil)];
            }
        }
        else {
            
            [self.giftCouponServicesDelegate getAllGiftCouponsMasterErrorResponseAndReturnSaveStatus:NSLocalizedString(@"unable_to_process_your_request", nil)];
        }
 
    } @catch (NSException *exception) {
        [self.giftCouponServicesDelegate getAllGiftCouponsMasterErrorResponseAndReturnSaveStatus:NSLocalizedString(@"unable_to_process_your_request", nil)];
    } @finally {
        return serviceCallStatus;
    }
}

/**
 * @description  here we are send the request string to access the server and getting couponsMaster information..
 * @date         21/11/2018
 * @method       getAllGiftCouponsMasterAsynchronousRequest:--
 * @author
 * @param        NSString
 * @param
 * @return       void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)getAllGiftCouponsMasterAsynchronousRequest:(NSString *)requestString{
    
    @try {
        
        NSString * serviceUrl = [WebServiceUtility getURLFor:GET_GIFT_COUPONS_MASTER];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  * request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                              timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * couponsDetailsResponseDic = [NSJSONSerialization JSONObjectWithData:data
                                                                                  options:0
                                                                                    error:NULL];
                 
                 if( ([couponsDetailsResponseDic.allKeys containsObject:RESPONSE_HEADER] && [[couponsDetailsResponseDic valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (couponsDetailsResponseDic == nil)){
                     
                     [self.giftCouponServicesDelegate getAllGiftCouponsMasterErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else  if ([[[couponsDetailsResponseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.giftCouponServicesDelegate getAllGiftCouponsMasterSuccessResponse:couponsDetailsResponseDic];
                 }
                 else {
                     
                     [self.giftCouponServicesDelegate getAllGiftCouponsMasterErrorResponse:[[couponsDetailsResponseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 
                 [self.giftCouponServicesDelegate getAllGiftCouponsMasterErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.giftCouponServicesDelegate getAllGiftCouponsMasterErrorResponse:exception.description];
    }
}

/**
 * @description  here we are calling the ....
 * @date         29/12/2017....
 * @method       getLoyaltycardDetails:--
 * @author       Srinivasulu
 * @param
 * @param        NSString
 *
 * @return       void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */



// Commented by roja on 17/10/2019.. // reason : getLoyaltycardDetails method contains SOAP Service call .. so taken new method with same (validateOLP) method name which contains REST service call....
// At the time of converting SOAP call's to REST



//-(void)getLoyaltycardDetails:(NSString *)requestString{
//
//    @try {
//
//        LoyaltycardServiceSoapBinding *skuService = [LoyaltycardServiceSvc LoyaltycardServiceSoapBinding] ;
//        LoyaltycardServiceSvc_getissuedLoyaltycard *getSkuid = [[LoyaltycardServiceSvc_getissuedLoyaltycard alloc] init];
//
//        getSkuid.loyaltyCardNumber = requestString;
//
//        LoyaltycardServiceSoapBindingResponse * response = [skuService getissuedLoyaltycardUsingParameters:(LoyaltycardServiceSvc_getissuedLoyaltycard *)getSkuid];
//        if (![response.error isKindOfClass:[NSError class]]) {
//            NSArray * responseBodyParts = response.bodyParts;
//
//            if (responseBodyParts != nil) {
//                for (id bodyPart in responseBodyParts) {
//                    if ([bodyPart isKindOfClass:[LoyaltycardServiceSvc_getissuedLoyaltycardResponse class]]) {
//                        LoyaltycardServiceSvc_getissuedLoyaltycardResponse *body = (LoyaltycardServiceSvc_getissuedLoyaltycardResponse *)bodyPart;
//                        // NSLog(@"response = %@",body.return_);
//                        NSError *e;
//
//                        NSDictionary * JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                              options: NSJSONReadingMutableContainers
//                                                                                error: &e];
//
//                        if( ([JSON.allKeys containsObject:RESPONSE_HEADER] && [[JSON valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (JSON == nil)){
//
//                            [self.loyaltycardServicesDelegate getLoyaltycardDetailsErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
//
//                        }
//
//                        else  if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue]==0) {
//
//                            [self.loyaltycardServicesDelegate getLoyaltycardDetailsSuccessReponse:JSON];
//
//                        }
//                        else{
//                            [self.loyaltycardServicesDelegate getLoyaltycardDetailsErrorResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
//
//                        }
//
//                    }
//                    else {
//                        [self.loyaltycardServicesDelegate getLoyaltycardDetailsErrorResponse:@"unable_to_process_your_request"];
//                    }
//                }
//
//            }
//            else
//                [self.loyaltycardServicesDelegate getLoyaltycardDetailsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
//
//        }
//        else{
//
//            [self.loyaltycardServicesDelegate getLoyaltycardDetailsErrorResponse:response.error.localizedDescription];
//        }
//
//    } @catch (NSException *exception) {
//
//        [self.giftCouponServicesDelegate getGiftCouponDetailsErrorResponse:exception.description];
//    }
//
//}



/**
 * @description  Sending the requeest to DB to get OutletGrnReceiptIDs...
 * @date         11/12/2017
 * @method       getOutletGrnReceiptIDs
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */
-(void)getOutletGrnReceiptIDs:(NSString *)requestString {
    
    // RestFullCall.........
    
    @try {
        
        NSString * serviceUrl = [WebServiceUtility getURLFor:GET_OUTLET_GOODS_RECEIPT_IDS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * grnIDsRespopnse = [NSJSONSerialization JSONObjectWithData:data
                                                                                  options:0
                                                                                    error:NULL];
                 
                 if( ([grnIDsRespopnse.allKeys containsObject:RESPONSE_HEADER] && [[grnIDsRespopnse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (grnIDsRespopnse == nil)){
                     
                     [self.outletGRNServiceDelegate getOutletGoodsReceiptIdsErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else  if ([[[grnIDsRespopnse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE]intValue] == 0) {
                     
                     [self.outletGRNServiceDelegate getOutletGoodsReceiptIdsSuccessResposne:grnIDsRespopnse];
                 }
                 else {
                     
                     [self.outletGRNServiceDelegate getOutletGoodsReceiptIdsErrorResponse:[[grnIDsRespopnse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 
                 [self.outletGRNServiceDelegate getOutletGoodsReceiptIdsErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException * exception) {
        
        [self.outletGRNServiceDelegate getOutletGoodsReceiptIdsErrorResponse:exception.description];
    }
}


/**
 * @description  here we are sending the requeest to DB to get the Daily Stock report...
 * @date         28/11/2017....
 * @method       getDailyStockReport..
 * @author       Bhargav.v
 * @param        NSString
 * @param
 *
 * @return
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)getShipmentReturn:(NSString *)requestString {
    
    // RestFullCall.........
    
    @try {
        NSString * serviceUrl = [WebServiceUtility getURLFor:GET_SHIPMENT_RETURN];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * shipmentReturnResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                         options:0
                                                                                           error:NULL];
                 
                 if( ([shipmentReturnResponse.allKeys containsObject:@"ResponseHeader"] && [[shipmentReturnResponse valueForKey:@"ResponseHeader"]  isKindOfClass: [NSNull class]]) || (shipmentReturnResponse == nil)){
                     
                     [self.shipmentReturnDelegate getShipmentReturnErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else  if ([[[shipmentReturnResponse valueForKey:@"ResponseHeader"] valueForKey:RESPONSE_CODE]intValue] == 0) {
                     
                     [self.shipmentReturnDelegate getShipmentReturnSuccessResponse:shipmentReturnResponse];
                 }
                 else {
                     
                     [self.shipmentReturnDelegate getShipmentReturnErrorResponse:[[shipmentReturnResponse valueForKey:@"ResponseHeader"] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 
                 [self.shipmentReturnDelegate getShipmentReturnErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException * exception) {
        
        [self.shipmentReturnDelegate getShipmentReturnErrorResponse:exception.description];
    }
}


/**
 * @description  We Are Calling createShipmentReturn Service Call
 * @date         28/12/2017....
 * @method       createShipmentReturn:--
 * @author       Bhargav.v
 * @param        NSString
 * @return       void
 * @modified By
 * @reason
 * @verified By
 * @verified On
 */


-(void)createShipmentReturn:(NSString *)requestString {
    
    @try {
        
        NSString * serviceUrl = [WebServiceUtility getURLFor:CREATE_SHIPMENT_RETURN];
        serviceUrl = [NSString stringWithFormat:@"%@",serviceUrl];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request  queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
         
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * shipmentReturnResponse = [NSJSONSerialization JSONObjectWithData:data  options:0 error:NULL];
                 
                 if( ([shipmentReturnResponse.allKeys containsObject:@"ResponseHeader"] && [[shipmentReturnResponse valueForKey:@"ResponseHeader"]  isKindOfClass: [NSNull class]]) || (shipmentReturnResponse == nil)){
                     
                     [self.shipmentReturnDelegate createShipmentErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else  if ([[[shipmentReturnResponse valueForKey:@"ResponseHeader"] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.shipmentReturnDelegate createShipmentReturnSuccessReponse:shipmentReturnResponse];
                 }
                 else {
                     
                     [self.shipmentReturnDelegate createShipmentErrorResponse:[[shipmentReturnResponse valueForKey:@"ResponseHeader"] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 
                 [self.shipmentReturnDelegate createShipmentErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.shipmentReturnDelegate createShipmentErrorResponse:exception.description];
    }
    
}


/**
 * @description  We Are Calling createShipmentReturn Service Call
 * @date         28/12/2017....
 * @method       createShipmentReturn:--
 * @author       Bhargav.v
 * @param        NSString
 * @return       void
 * @modified By
 * @reason
 * @verified By
 * @verified On
 */


-(void)updateShipmentReturn:(NSString *)requestString {
    
    @try {
        
        NSString * serviceUrl = [WebServiceUtility getURLFor:UPDATE_SHIPMENT_RETURN];
        serviceUrl = [NSString stringWithFormat:@"%@",serviceUrl];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request  queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
         
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * shipmentReturnResponse = [NSJSONSerialization JSONObjectWithData:data  options:0 error:NULL];
                 
                 if( ([shipmentReturnResponse.allKeys containsObject:@"ResponseHeader"] && [[shipmentReturnResponse valueForKey:@"ResponseHeader"]  isKindOfClass: [NSNull class]]) || (shipmentReturnResponse == nil)){
                     
                     [self.shipmentReturnDelegate updateShipmentErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else  if ([[[shipmentReturnResponse valueForKey:@"ResponseHeader"] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.shipmentReturnDelegate updateShipmentReturnSuccessResponse:shipmentReturnResponse];
                 }
                 else {
                     
                     [self.shipmentReturnDelegate updateShipmentErrorResponse:[[shipmentReturnResponse valueForKey:@"ResponseHeader"] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 
                 [self.shipmentReturnDelegate updateShipmentErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.shipmentReturnDelegate updateShipmentErrorResponse:exception.description];
    }
    
}





/**
 * @description  Here we are calling the get allOrders service call....
 * @date         14/02/2018...
 * @method       getAllOrders
 * @author       Srinivasulu
 * @param        NSString
 * @param
 *
 * @return       void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */


-(void)getAllOrders:(NSString *)requestString{
    
    @try {
        OrderServiceSoapBinding *utility =  [OrderServiceSvc OrderServiceSoapBinding];
        utility.logXMLInOut = YES;
        
        OrderServiceSvc_getOrders *category = [[OrderServiceSvc_getOrders alloc] init];
        
        category.orderDetails = requestString;
        
        
        OrderServiceSoapBindingResponse *response = [utility getOrdersUsingParameters:category];
        
        
        if (![response.error isKindOfClass:[NSError class]]) {
            NSArray *responseBodyparts = response.bodyParts;
            
            
            if (responseBodyparts != nil) {
                for (id bodyPart in responseBodyparts) {
                    if ([bodyPart isKindOfClass:[OrderServiceSvc_getOrdersResponse class]]) {
                        OrderServiceSvc_getOrdersResponse *body = (OrderServiceSvc_getOrdersResponse *)bodyPart;
                        // NSLog(@"response = %@",body.return_);
                        NSError *e;
                        
                        NSDictionary * JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                                              options: NSJSONReadingMutableContainers
                                                                                error: &e];
                        
                        
                        if( ([JSON.allKeys containsObject:RESPONSE_HEADER] && [[JSON valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (JSON == nil)){
                            
                            [self.getOrderDelegate getAllOrdersErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                            
                        }
                        
                        else  if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue]==0) {
                            
                            [self.getOrderDelegate getAllOrdersSuccessResponse:JSON];
                            
                        }
                        else{
                            [self.getOrderDelegate getAllOrdersErrorResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                            
                        }
                        
                    }
                    else {
                        [self.getOrderDelegate getAllOrdersErrorResponse:@"unable_to_process_your_request"];
                    }
                }
                
            }
            else
                [self.getOrderDelegate getAllOrdersErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
        }
        else{
            
            [self.getOrderDelegate getAllOrdersErrorResponse:response.error.localizedDescription];
        }
        
    }
    @catch (NSException *exception) {
        
        [self.getOrderDelegate getAllOrdersErrorResponse:exception.description];
    }
    
}

/**
 * @description  sending the Request String to the Server to Get The Response
 * @date         05/02/2018
 * @method       getAllDealsWithData
 * @author       -----
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *@modified By  Bhargav .v.....
 *
 */


// Commented by roja on 17/10/2019.. // reason :- getOffersDetails: method contains SOAP Service call .. so taken new method with same name(getOffersDetails:) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//-(void)getOffersDetails:(NSString *)requestString {
//
//
//    // RestFullCall.........
//
//    @try {
//
//        OfferServiceSoapBinding  * service = [OfferServiceSvc OfferServiceSoapBinding] ;
//
//        OfferServiceSvc_getOffer * aparams = [[OfferServiceSvc_getOffer alloc] init];
//
//        aparams.offerID = requestString;
//
//        OfferServiceSoapBindingResponse * response = [service getOfferUsingParameters:aparams];
//
//        NSArray * responseBodyParts = response.bodyParts;
//
//        if (responseBodyParts == nil) {
//
//            [self.offerMasterDelegate getOffersErrorResponse:NSLocalizedString(@"request_timeOut", nil)];
//        }
//        else {
//
//            for (id bodyPart in responseBodyParts) {
//                if ([bodyPart isKindOfClass:[OfferServiceSvc_getOfferResponse class]]) {
//
//                    OfferServiceSvc_getOfferResponse *body = (OfferServiceSvc_getOfferResponse *)bodyPart;
//
//                    NSError *e;
//
//                    NSDictionary * JSON1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                           options: NSJSONReadingMutableContainers
//                                                                             error: &e];
//                    if (![JSON1 isKindOfClass:[NSNull class]] && [[[JSON1 valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue] == 0) {
//
//                        [self.offerMasterDelegate  getoffersSuccessResponse:JSON1];
//
//                    }
//                    else {
//
//                        [self.offerMasterDelegate getOffersErrorResponse:[[JSON1 valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
//
//                    }
//                }
//                else {
//                    [self.offerMasterDelegate getOffersErrorResponse:NSLocalizedString(@"soap_fault", nil)];
//
//                }
//            }
//        }
//
//    } @catch (NSException * exception) {
//
//        [self.offerMasterDelegate getOffersErrorResponse:exception.description];
//
//    }
//}


/**
 * @description  here we are sending the requeest to DB to get the Daily Stock report...
 * @date         27/02/2018....
 * @method       getOutletOrders..
 * @author       Bhargav.v
 * @param        NSString
 * @param
 *
 * @return
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)getOutletOrders:(NSString *)requestString {
    
    // RestFullCall.........
    
    @try {
        
        NSString   * serviceUrl = [WebServiceUtility getURLFor:GET_OUTLET_ORDERS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        
        request.HTTPMethod = @"GET";
        
        [NSURLConnection sendAsynchronousRequest:request  queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData * data, NSError *connectionError) {
            
            if (data.length > 0 && connectionError == nil) {
                
                NSDictionary * ordersSuccessResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                
                if( ([ordersSuccessResponse.allKeys containsObject:RESPONSE_HEADER] && [[ordersSuccessResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (ordersSuccessResponse == nil)){
                    
                    [self.outletOrderServiceDelegate getOutletOrdersErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                }
                else  if ([[[ordersSuccessResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE]intValue] == 0) {
                    
                    [self.outletOrderServiceDelegate getOutletOrdersSuccessResponse:ordersSuccessResponse];
                }
                else {
                    
                    [self.outletOrderServiceDelegate getOutletOrdersErrorResponse:[[ordersSuccessResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                }
            }
            else {
                
                [self.outletOrderServiceDelegate getOutletOrdersErrorResponse:connectionError.localizedDescription];
            }
        }];
        
    } @catch (NSException * exception) {
        
        [self.outletOrderServiceDelegate getOutletOrdersErrorResponse:exception.description];
    }
}



/**
 * @description  here we are sending the requeest to DB to get the Daily Stock report...
 * @date         27/02/2018....
 * @method       getOutletOrders..
 * @author       Bhargav.v
 * @param        NSString
 * @param
 *
 * @return
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)getOutleOrderDetails:(NSString *)requestString {
    
    // RestFullCall.........
    
    @try {
        
        NSString   * serviceUrl = [WebServiceUtility getURLFor:GET_OUTLET_ORDER_DETAILS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  * request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy  timeoutInterval:60.0];
        
        request.HTTPMethod = @"GET";
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]  completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)  {
            
            if (data.length > 0 && connectionError == nil) {
                
                NSDictionary * orderDetailsResponse = [NSJSONSerialization JSONObjectWithData:data  options:0  error:NULL];
                
                if( ([orderDetailsResponse.allKeys containsObject:RESPONSE_HEADER] && [[orderDetailsResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (orderDetailsResponse == nil)){
                    
                    [self.outletOrderServiceDelegate getOutletOrderDetailsErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                }
                else  if ([[[orderDetailsResponse valueForKey:RESPONSE_HEADER] allKeys] containsObject:RESPONSE_CODE] && [[[orderDetailsResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue] == 0) {
                    
                    [self.outletOrderServiceDelegate getOutletOrderDetailsSuccessResponse:orderDetailsResponse];
                }
                else {
                    
                    [self.outletOrderServiceDelegate getOutletOrderDetailsErrorResponse:[[orderDetailsResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                }
            }
            else {
                
                [self.outletOrderServiceDelegate getOutletOrderDetailsErrorResponse:connectionError.localizedDescription];
            }
        }];
        
    } @catch (NSException * exception) {
        
        [self.outletOrderServiceDelegate getOutletOrderDetailsErrorResponse:exception.description];
    }
}

/**
 * @description  Sending the Request to Server to place Order in Preferred Location...
 * @date         02/04/2018
 * @method       createOutletOrder
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */
-(void)createOutletOrder:(NSString*)requestString {
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:CREATE_OUTLET_ORDER];
        serviceUrl = [NSString stringWithFormat:@"%@",serviceUrl];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%ld", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
        {
            if (data.length > 0 && connectionError == nil)
            {
                NSDictionary * createOrderResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                     options:0
                                                                                       error:NULL];
                
                if( ([createOrderResponse.allKeys containsObject:RESPONSE_HEADER] && [[createOrderResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (createOrderResponse == nil)){
                    
                    [self.outletOrderServiceDelegate createOutletOrderErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                    
                }
                else  if ([[[createOrderResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                    
                    [self.outletOrderServiceDelegate createOutletOrderSuccessResponse:createOrderResponse];
                }
                else {
                    [self.outletOrderServiceDelegate createOutletOrderErrorResponse:[[createOrderResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                }
            }
            else {
                [self.outletOrderServiceDelegate createOutletOrderErrorResponse:@""];
            }
        }];
    }
    @catch (NSException *exception) {
        
        [self.outletOrderServiceDelegate createOutletOrderErrorResponse:exception.description];
    }
    
}

/**
 * @description  Sending the Request to Server to update the  placed  Order with(Next Work Flow State) in Preferred Location...
 * @date         06/04/2018
 * @method       updateOutletOrder
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)updateOutletOrder:(NSString *)requestString {
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:UPDATE_OUTLET_ORDER];
        serviceUrl = [NSString stringWithFormat:@"%@",serviceUrl];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%ld", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
        {
            if (data.length > 0 && connectionError == nil)
            {
                NSDictionary * createOrderResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                     options:0
                                                                                       error:NULL];
                
                if( ([createOrderResponse.allKeys containsObject:RESPONSE_HEADER] && [[createOrderResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (createOrderResponse == nil)){
                    
                    [self.outletOrderServiceDelegate updateOutletOrderErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                    
                }
                else  if ([[[createOrderResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                    
                    [self.outletOrderServiceDelegate updateOutletOrderSucessResponse:createOrderResponse];
                }
                else {
                    [self.outletOrderServiceDelegate updateOutletOrderErrorResponse:[[createOrderResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                }
            }
            else {
                [self.outletOrderServiceDelegate updateOutletOrderErrorResponse:@""];
            }
        }];
    }
    @catch (NSException *exception) {
        
        [self.outletOrderServiceDelegate updateOutletOrderErrorResponse:exception.description];
    }
}


/**
 * @description  calling getStores To Get the locations (Virtual Stores).....
 * @date         26/03/2018
 * @method       getStores
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return       void
 * @verified By
 * @verified On
 *
 */
//getStores: method Commented  by roja on 17/10/2019.. (changes are done in same method name which is available next to this method)
// At the time of converting SOAP call's to REST

//-(void)getStores:(NSString*)requestString {
//
//    @try {
//
//        StoreServiceSoapBinding  * service = [StoreServiceSvc StoreServiceSoapBinding] ;
//
//        service.logXMLInOut = YES;
//
//        StoreServiceSvc_getStores * aparams = [[StoreServiceSvc_getStores alloc] init];
//
//        aparams.layoutDetails = requestString;
//
//        StoreServiceSoapBindingResponse * response = [service getStoresUsingParameters:aparams];
//
//        NSArray * responseBodyParts = response.bodyParts;
//
//        if (responseBodyParts == nil) {
//
//            [self.storeServiceDelegate getStoreErrorResponse:NSLocalizedString(@"request_timeOut", nil)];
//        }
//        else {
//
//            for (id bodyPart in responseBodyParts) {
//                if ([bodyPart isKindOfClass:[StoreServiceSvc_getStoresResponse class]]) {
//
//                    StoreServiceSvc_getStoresResponse *body = (StoreServiceSvc_getStoresResponse *)bodyPart;
//
//                    NSError * e;
//
//                    NSDictionary * JSON1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                           options: NSJSONReadingMutableContainers
//                                                                             error: &e];
//                    if (![JSON1 isKindOfClass:[NSNull class]] && [[[JSON1 valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue] == 0) {
//
//                        [self.storeServiceDelegate  getStoresSuccessResponse:JSON1];
//
//                    }
//                    else {
//
//                        [self.storeServiceDelegate getStoreErrorResponse:[[JSON1 valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
//
//                    }
//                }
//                else {
//                    [self.storeServiceDelegate getStoreErrorResponse:NSLocalizedString(@"soap_fault", nil)];
//
//                }
//            }
//        }
//
//    } @catch (NSException * exception) {
//
//        [self.storeServiceDelegate getStoreErrorResponse:exception.description];
//
//    }
//}
//



/**
 * @description  here we are calling the ....
 * @date         29/12/2017....
 * @method       getLoyaltycardDetails:--
 * @author       Srinivasulu
 * @param
 * @param        NSString
 *
 * @return       void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

// This method is not using anywhere of this file so commenting it (commented by roja on 17/10/2019)...
//-(void)getLoyaltycardDetailsByRestFullService:(NSString *)requestString{
//
//    @try {
//
//        LoyaltycardServiceSoapBinding *skuService = [LoyaltycardServiceSvc LoyaltycardServiceSoapBinding] ;
//        LoyaltycardServiceSvc_getissuedLoyaltycard *getSkuid = [[LoyaltycardServiceSvc_getissuedLoyaltycard alloc] init];
//
//        getSkuid.loyaltyCardNumber = requestString;
//
//        LoyaltycardServiceSoapBindingResponse * response = [skuService getissuedLoyaltycardUsingParameters:(LoyaltycardServiceSvc_getissuedLoyaltycard *)getSkuid];
//        if (![response.error isKindOfClass:[NSError class]]) {
//            NSArray * responseBodyParts = response.bodyParts;
//
//            if (responseBodyParts != nil) {
//                for (id bodyPart in responseBodyParts) {
//                    if ([bodyPart isKindOfClass:[LoyaltycardServiceSvc_getissuedLoyaltycardResponse class]]) {
//                        LoyaltycardServiceSvc_getissuedLoyaltycardResponse *body = (LoyaltycardServiceSvc_getissuedLoyaltycardResponse *)bodyPart;
//                        // NSLog(@"response = %@",body.return_);
//                        NSError *e;
//
//                        NSDictionary * JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                              options: NSJSONReadingMutableContainers
//                                                                                error: &e];
//
//                        if( ([JSON.allKeys containsObject:RESPONSE_HEADER] && [[JSON valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (JSON == nil)){
//
//                            [self.loyaltycardServicesDelegate getLoyaltycardDetailsErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
//                        }
//                        else  if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue]==0) {
//
//                            [self.loyaltycardServicesDelegate getLoyaltycardDetailsSuccessReponse:JSON];
//
//                        }
//                        else{
//                            [self.loyaltycardServicesDelegate getLoyaltycardDetailsErrorResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
//                        }
//                    }
//                    else {
//                        [self.loyaltycardServicesDelegate getLoyaltycardDetailsErrorResponse:@"unable_to_process_your_request"];
//                    }
//                }
//            }
//            else
//
//                [self.loyaltycardServicesDelegate getLoyaltycardDetailsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
//        }
//        else{
//
//            [self.loyaltycardServicesDelegate getLoyaltycardDetailsErrorResponse:response.error.localizedDescription];
//        }
//
//    } @catch (NSException *exception) {
//
//        [self.giftCouponServicesDelegate getGiftCouponDetailsErrorResponse:exception.description];
//    }
//}

/**
 * @description  in this method we are calling the service to get all customer pervious purchases details.......
 * @date         21/05/2018
 * @method       getCustomerPurchases:
 * @author       Srinivasulu
 * @param        NSString
 * @param
 *
 * @return       void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)getCustomerPurchases:(NSString *)requestString{
    
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_CUSTOMER_PURCHASES];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * customerPurchasesResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:0
                                                                                         error:NULL];
                 
                 if( ([customerPurchasesResponse.allKeys containsObject:RESPONSE_HEADER] && [[customerPurchasesResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (customerPurchasesResponse == nil)){
                     
                     [self.getBillsDelegate getCustomerPurchasesErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[[customerPurchasesResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.getBillsDelegate getCustomerPurchasesSuccesssResponse:customerPurchasesResponse];
                 }
                 else {
                     
                     [self.getBillsDelegate getCustomerPurchasesErrorResponse:[[customerPurchasesResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.getBillsDelegate getCustomerPurchasesErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.getBillsDelegate getCustomerPurchasesErrorResponse:exception.description];
    }
}

/**
 * @description  Sending the RequestString to call TrackerItemsDetails....
 * @date         14/05/2018
 * @method       getTrackerItemsDetails
 * @author       Bhargav.v
 * @param        NSString
 * @param
 *
 * @return       void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)getTrackerItemsDetails:(NSString *)requestString {
    
    // RestFullCall...
    
    @try {
        
        NSString   * serviceUrl = [WebServiceUtility getURLFor:GET_TRACKER_ITEM_DETAILS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  * request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy  timeoutInterval:60.0];
        
        request.HTTPMethod = @"GET";
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]  completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)  {
            
            if (data.length > 0 && connectionError == nil) {
                
                NSDictionary * trackerItemsDetailsResponse = [NSJSONSerialization JSONObjectWithData:data  options:0  error:NULL];
                
                if( ([trackerItemsDetailsResponse.allKeys containsObject:RESPONSE_HEADER] && [[trackerItemsDetailsResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (trackerItemsDetailsResponse == nil)){
                    
                    [self.salesServiceDelegate getTrackerItemsDetailsErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                }
                else  if ([[[trackerItemsDetailsResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE]intValue] == 0) {
                    
                    [self.salesServiceDelegate getTrackerItemsDetalilsSuccessResponse:trackerItemsDetailsResponse];
                }
                else {
                    
                    [self.salesServiceDelegate getTrackerItemsDetailsErrorResponse:[[trackerItemsDetailsResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                }
            }
            else {
                
                [self.salesServiceDelegate getTrackerItemsDetailsErrorResponse:connectionError.localizedDescription];
            }
        }];
    } @catch (NSException * exception) {
        
        [self.salesServiceDelegate getTrackerItemsDetailsErrorResponse:exception.description];
    }
}

/**
 * @description  Here we are sending to requst to get the product menu details....
 * @date         24/05/2018
 * @method       getMenuDetailsInfo:--
 * @author       Srinivasulu
 * @param        NSString
 * @param
 *
 * @return       void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)getMenuDetailsInfo:(NSString *)requestString{
    
    // RestFullCall...
    
    @try {
        
        NSString   * serviceUrl = [WebServiceUtility getURLFor:GET_MENU_DETAILS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  * request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy  timeoutInterval:60.0];
        
        request.HTTPMethod = @"GET";
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]  completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)  {
            
            if (data.length > 0 && connectionError == nil) {
                
                NSDictionary * menuDetailsInfoDic = [NSJSONSerialization JSONObjectWithData:data  options:0  error:NULL];
                
                if( ([menuDetailsInfoDic.allKeys containsObject:RESPONSE_HEADER] && [[menuDetailsInfoDic valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (menuDetailsInfoDic == nil)){
                    
                    [self.menuServiceDelegate getMenuDeatilsErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                }
                else  if ([[[menuDetailsInfoDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE]intValue] == 0) {
                    
                    [self.menuServiceDelegate getMenuDetailsSuccessResponse:menuDetailsInfoDic];
                }
                else {
                    
                    [self.menuServiceDelegate getMenuDeatilsErrorResponse:[[menuDetailsInfoDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                }
            }
            else {
                
                [self.menuServiceDelegate getMenuDeatilsErrorResponse:connectionError.localizedDescription];
            }
        }];
    } @catch (NSException * exception) {
        
        [self.menuServiceDelegate getMenuDeatilsErrorResponse:exception.description];
    }
}

/**
 * @description  Here we are sending to requst to get the product menu category details....
 * @date         24/05/2018
 * @method       getMenuCategoryDetailsInfo:--
 * @author       Srinivasulu
 * @param        NSString
 * @param
 *
 * @return       void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)getMenuCategoryDetailsInfo:(NSString *)requestString{
    
    // RestFullCall...
    
    @try {
        
        NSString   * serviceUrl = [WebServiceUtility getURLFor:GET_MENU_CATEGORY_DETAILS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  * request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy  timeoutInterval:60.0];
        
        request.HTTPMethod = @"GET";
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]  completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)  {
            
            if (data.length > 0 && connectionError == nil) {
                
                NSDictionary * menuDetailsResponseDic = [NSJSONSerialization JSONObjectWithData:data  options:0  error:NULL];
                
                if( ([menuDetailsResponseDic.allKeys containsObject:RESPONSE_HEADER] && [[menuDetailsResponseDic valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (menuDetailsResponseDic == nil)){
                    
                    [self.menuServiceDelegate getMenuCategoryDeatilsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                }
                else  if ([[[menuDetailsResponseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE]intValue] == 0) {
                    
                    [self.menuServiceDelegate getMenuCategoryDetailsSuccessResponse:menuDetailsResponseDic];
                }
                else {
                    
                    [self.menuServiceDelegate getMenuCategoryDeatilsErrorResponse:[[menuDetailsResponseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                }
            }
            else {
                
                [self.menuServiceDelegate getMenuCategoryDeatilsErrorResponse:connectionError.localizedDescription];
            }
        }];
    } @catch (NSException * exception) {
        
        [self.menuServiceDelegate getMenuCategoryDeatilsErrorResponse:exception.description];
    }
}

-(BOOL)getMenuDetailsInfoThroughSynchronousRequest:(NSString *)requestString{
    BOOL serviceCallStatus = false;
    
    @try {
        
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_MENU_CATEGORY_DETAILS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  * request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
 
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];

        if (data.length > 0 && connectionError == nil)
        {
            NSError * err;
            
            NSDictionary * menuDetailsResponseDic  = [NSJSONSerialization JSONObjectWithData:data
                                                                  options:kNilOptions
                                                                    error:&err];
            
            
            if (menuDetailsResponseDic.count) {
               
                if( ([menuDetailsResponseDic.allKeys containsObject:RESPONSE_HEADER] && [[menuDetailsResponseDic valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (menuDetailsResponseDic == nil)){
                    
                    [self.menuServiceDelegate getMenuDeatilsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                }
                else if ([[[menuDetailsResponseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                    
                    [self.menuServiceDelegate getMenuDetailsSuccessResponse:menuDetailsResponseDic];
                    serviceCallStatus = true;
                }
                else {
                    
                    NSString * responseMsg = [[menuDetailsResponseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE];
                    [self.menuServiceDelegate getMenuDeatilsErrorResponse:responseMsg];
                    if ([responseMsg isEqualToString:NO_RECORDS_FOUND]) {
                        serviceCallStatus = true;
                    }
                }
            }
            else {
                [self.menuServiceDelegate getMenuDeatilsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
            }
        }
        else {
            
            [self.menuServiceDelegate getMenuDeatilsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
        }
        
        
    } @catch (NSException *exception) {
        [self.menuServiceDelegate getMenuDeatilsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
    } @finally {
        return serviceCallStatus;
    }
}
-(BOOL)getMenuCategoryDetailsInfoThroughSynchronousRequest:(NSString *)requestString{
    BOOL serviceCallStatus = false;
    
    @try {
        
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_MENU_CATEGORY_DETAILS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        if (data.length > 0 && connectionError == nil)
        {
            NSError * err;
            
            NSDictionary * menuDetailsResponseDic  = [NSJSONSerialization JSONObjectWithData:data
                                                                                     options:kNilOptions
                                                                                       error:&err];
            
            if (menuDetailsResponseDic.count) {
                
                if( ([menuDetailsResponseDic.allKeys containsObject:RESPONSE_HEADER] && [[menuDetailsResponseDic valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (menuDetailsResponseDic == nil)){
                    
                    [self.menuServiceDelegate getMenuCategoryDeatilsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                }
                else if ([[[menuDetailsResponseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                    
                    [self.menuServiceDelegate getMenuCategoryDetailsSuccessResponse:menuDetailsResponseDic];
                    serviceCallStatus = true;
                }
                else {
                    NSString * responseMsg = [[menuDetailsResponseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE];
                    [self.menuServiceDelegate getMenuCategoryDeatilsErrorResponse:responseMsg];
                    if ([responseMsg isEqualToString:NO_RECORDS_FOUND]) {
                        serviceCallStatus = true;
                    }
                }
            }
            else {
                [self.menuServiceDelegate getMenuCategoryDeatilsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
            }
        }
        else {
            
            [self.menuServiceDelegate getMenuCategoryDeatilsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
        }
        
        
    } @catch (NSException *exception) {
        [self.menuServiceDelegate getMenuCategoryDeatilsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
    } @finally {
        return serviceCallStatus;
    }
}

/**
 * @description  here we are calling the getSKUStockInformation for getting item details....
 * @date         22/06/2018
 * @method       getSKUStockInformation:--
 * @author       Roja
 * @param        NSString
 * @param
 *
 * @return       void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)getSKUStockInformation:(NSString *)requestString {
    
    @try {
        
        NSMutableDictionary * reqDic = [[NSJSONSerialization JSONObjectWithData:[requestString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL] mutableCopy];
        
        reqDic[ZERO_STOCK_CHECK_AT_OUTLET_LEVEL] = @(zeroStockCheckAtOutletLevel);
        
        reqDic[SCAN_CODE] = @1;
        
        
        if([barcodeTypeStr caseInsensitiveCompare:@"ean"] == NSOrderedSame){
            
            reqDic[SCAN_CODE] = @2;
        }
        else if([barcodeTypeStr caseInsensitiveCompare:@"both"] == NSOrderedSame){
            
            reqDic[SCAN_CODE] = @3;
        }
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
        requestString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_SKU_STOCK_INFORMATION];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                            timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *billingResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                 options:0
                                                                                   error:NULL];
                 if ([[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.getSkuDetailsDelegate getSkuDetailsSuccessResponse:billingResponse];
                 }
                 else {
                     [self.getSkuDetailsDelegate getSkuDetailsErrorResponse:[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.getSkuDetailsDelegate getSkuDetailsErrorResponse:@"Product Not Available"];
             }
         }];
        
    } @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
        [self.getSkuDetailsDelegate getSkuDetailsErrorResponse:@"Product Not Available"];
        
    } @finally {
        
    }
}

/**
 * @description  sending the Request String to the Server to Get The Response
 * @date         05/02/2018
 * @method       getAllDealsWithData
 * @author
 * @param        NSString
 * @param
 * @return       void
 *
 * @modified By Bhargav .v.
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)getAllDealsWithData:(NSString *)requestString {
    
    // RestFullCall.........
    @try {
        
        NSString * serviceUrl = [WebServiceUtility getURLFor:GET_ALL_DEALS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL  * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  * request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                              timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * shipmentReturnResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                         options:0
                                                                                           error:NULL];
                 
                 if( ([shipmentReturnResponse.allKeys containsObject:RESPONSE_HEADER] && [[shipmentReturnResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (shipmentReturnResponse == nil)){
                     
                     [self.getAllDealsDelegate getAllDealsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else  if ([[[shipmentReturnResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE]intValue] == 0) {
                     
                     [self.getAllDealsDelegate getAllDealsSuccessResponse:shipmentReturnResponse];
                 }
                 else {
                     
                     [self.getAllDealsDelegate getAllDealsErrorResponse:[[shipmentReturnResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 
                 [self.getAllDealsDelegate getAllDealsErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    } @catch (NSException * exception) {
        
        [self.getAllDealsDelegate getAllDealsErrorResponse:exception.description];
    }
}

/**
 * @description  here we are send the request string to access the server and getting deals information..
 * @date         11/10/2018
 * @method       getAllDealsWithDataThroughSynchronousRequest:--
 * @author
 * @param        NSString
 * @param
 * @return       BOOL
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(BOOL)getAllDealsWithDataThroughSynchronousRequest:(NSString *)requestString{
    
    BOOL isAllDealsSaved = false;
    
    @try {
        
        NSString * serviceUrl = [WebServiceUtility getURLFor:GET_ALL_DEALS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        
        if (data.length > 0 && connectionError == nil)
        {
            NSError *err;
            
            NSDictionary *JSON  = [NSJSONSerialization JSONObjectWithData:data
                                                                  options:kNilOptions
                                                                    error:&err];
            
            if( ([JSON.allKeys containsObject:RESPONSE_HEADER] && [[JSON valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (JSON == nil)){
                
                isAllDealsSaved = [self.getAllDealsDelegate getAllDealsErrorResponseAndReturnSaveStatus:NSLocalizedString(@"unable_to_process_your_request", nil)];
            }
            else if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                
                isAllDealsSaved =  [self.getAllDealsDelegate getAllDealsSuccessResponseAndReturnSaveStatus:JSON];
                
            }
            else {
                isAllDealsSaved = [self.getAllDealsDelegate getAllDealsErrorResponseAndReturnSaveStatus:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                NSLog(@"deals becomes false in downloading producst");
            }
        }
        else {
            
            isAllDealsSaved = [self.getAllDealsDelegate getAllDealsErrorResponseAndReturnSaveStatus:connectionError.localizedDescription];
            NSLog(@"deals becomes false in due to connection error");
        }
    }
    @catch (NSException *exception) {
        
        isAllDealsSaved = [self.getAllDealsDelegate getAllDealsErrorResponseAndReturnSaveStatus:exception.description];
        NSLog(@"Exception -- in Deals download service call --  %@",exception);
    }
    @finally{
        
        return isAllDealsSaved;
    }
}

/**
 * @description  here we are send the request string to access the server and getting offers information..
 * @date         11/10/2018
 * @method       getAllOffersWithDataThroughSynchronousRequest:--
 * @author
 * @param        NSString
 * @param
 * @return       BOOL
 *
 * @modified By
 * @reason 
 *
 * @verified By
 * @verified On
 *
 */



// Commented by roja on 17/10/2019... // Reason: As per Latest REST service call below method handling also changes..
// so, latest changes done in another method with different method name(getAllOffersWithData:)

//-(BOOL)getAllOffersWithDataThroughSoapSynchronousRequest:(NSString *)requestString{
//
//    BOOL isAllDealsSaved = false;
//
//    @try {
//
//        OfferServiceSoapBinding  * service = [OfferServiceSvc OfferServiceSoapBinding] ;
//        service.logXMLInOut = NO;
//
//        OfferServiceSvc_getOffer * aparams = [[OfferServiceSvc_getOffer alloc] init];
//        aparams.offerID = requestString;
//
//        OfferServiceSoapBindingResponse * response = [service getOfferUsingParameters:aparams];
//
//        if (![response.error isKindOfClass:[NSError class]]) {
//            NSArray * responseBodyparts = response.bodyParts;
//
//            if (responseBodyparts != nil) {
//                for (id bodyPart in responseBodyparts) {
//
//                    if ([bodyPart isKindOfClass:[OfferServiceSvc_getOfferResponse class]]) {
//                        OfferServiceSvc_getOfferResponse *body = (OfferServiceSvc_getOfferResponse *)bodyPart;
//
//                        NSError * e;
//
//                        NSDictionary * JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers error: &e];
//
//                        if( ([JSON.allKeys containsObject:RESPONSE_HEADER] && [[JSON valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (JSON == nil)){
//
//                            isAllDealsSaved = [self.getAllOffersDelegate getAllOffersErrorResponseAndReturnSaveStatus:NSLocalizedString(@"unable_to_process_your_request", nil)];
//
//                        }
//                        else  if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue]==0) {
//                            isAllDealsSaved =  [self.getAllOffersDelegate getAllOffersSuccessResponseAndReturnSaveStatus:JSON];
//
//                        }
//                        else{
//                            isAllDealsSaved = [self.getAllOffersDelegate getAllOffersErrorResponseAndReturnSaveStatus:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
//                        }
//                    }
//                }
//            }
//            else
//                isAllDealsSaved = [self.getAllOffersDelegate getAllOffersErrorResponseAndReturnSaveStatus:@"no_data_found"];
//
//        }
//        else
//            isAllDealsSaved = [self.getAllOffersDelegate getAllOffersErrorResponseAndReturnSaveStatus:@"no_data_found"];
//
//    }
//    @catch (NSException *exception) {
//
//        isAllDealsSaved = [self.getAllOffersDelegate getAllOffersErrorResponseAndReturnSaveStatus:exception.description];
//        NSLog(@"Exception -- in Deals download service call --  %@",exception);
//    }
//    @finally{
//
//        return isAllDealsSaved;
//    }
//}

/**
 * @description  here we are send the request string to access the server and getting offers information..
 * @date         11/10/2018
 * @method       getAllOffersWithDataThroughSynchronousRequest:--
 * @author
 * @param        NSString
 * @param
 * @return       BOOL
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(BOOL)getAllOffersWithDataThroughSynchronousRequest:(NSString *)requestString{

    BOOL isAllDealsSaved = false;
    
    @try {
        
        NSString * serviceUrl = [WebServiceUtility getURLFor:GET_ALL_DEALS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        
        if (data.length > 0 && connectionError == nil)
        {
            NSError *err;
            
            NSDictionary *JSON  = [NSJSONSerialization JSONObjectWithData:data
                                                                  options:kNilOptions
                                                                    error:&err];
            
            if( ([JSON.allKeys containsObject:RESPONSE_HEADER] && [[JSON valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (JSON == nil)){
                
                isAllDealsSaved = [self.getAllOffersDelegate getAllOffersErrorResponseAndReturnSaveStatus:NSLocalizedString(@"unable_to_process_your_request", nil)];
            }
            else if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                
                isAllDealsSaved =  [self.getAllOffersDelegate getAllOffersSuccessResponseAndReturnSaveStatus:JSON];
                
            }
            else {
                isAllDealsSaved = [self.getAllOffersDelegate getAllOffersErrorResponseAndReturnSaveStatus:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                NSLog(@"deals becomes false in downloading producst");
            }
        }
        else {
            
            isAllDealsSaved = [self.getAllOffersDelegate getAllOffersErrorResponseAndReturnSaveStatus:connectionError.localizedDescription];
            NSLog(@"deals becomes false in due to connection error");
        }
    }
    @catch (NSException *exception) {
        
        isAllDealsSaved = [self.getAllOffersDelegate getAllOffersErrorResponseAndReturnSaveStatus:exception.description];
        NSLog(@"Exception -- in Deals download service call --  %@",exception);
    }
    @finally{
        
        return isAllDealsSaved;
    }
}


/**
 * @description  Creating Day Open Summary...
 * @date         09/05/2018
 * @method       createDayOpenSummary
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)createDayOpenSummary:(NSString*)requestString {
    @try {
        
        NSString * serviceUrl = [WebServiceUtility getURLFor:CREATE_DAY_OPEN_SUMMARY];
        serviceUrl = [NSString stringWithFormat:@"%@",serviceUrl];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  * request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                              timeoutInterval:60.0];
        [request setHTTPMethod: @"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%ld", [[serviceUrl dataUsingEncoding:NSUTF8StringEncoding] length]] forHTTPHeaderField:@"Content-Length"];
        
        [request setHTTPBody:[requestString dataUsingEncoding:NSUTF8StringEncoding]];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError) {
                                   
                                   if (data.length > 0 && connectionError == nil) {
                                       
                                       NSDictionary * createDayOpenResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                                              options:0
                                                                                                                error:NULL];
                                       
                                       if( ([[createDayOpenResponse allKeys] containsObject:RESPONSE_HEADER] && [[createDayOpenResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (createDayOpenResponse == nil)){
                                           
                                           [self.dayOpenServiceDelegate createDayOpenSummaryErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                                           
                                       }
                                       else  if ([[[createDayOpenResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                                           
                                           [self.dayOpenServiceDelegate createDayOpenSummarySuccessResponse:createDayOpenResponse];
                                       }
                                       
                                       else {
                                           
                                           [self.dayOpenServiceDelegate createDayOpenSummaryErrorResponse:[[createDayOpenResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                                       }
                                   }
                                   else {
                                       [self.dayOpenServiceDelegate createDayOpenSummaryErrorResponse:connectionError.localizedDescription];
                                   }
                               }];
    }
    @catch (NSException * exception) {
        
        [self.dayOpenServiceDelegate createDayOpenSummaryErrorResponse:exception.description];
    }
}

/**
 * @description  Method is used to get the Day Closure Details..
 * @date         03/08/2018
 * @method       getDayClosureSummary
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getDayClosureSummary:(NSString *)requestString {
    
    // RestFullCall...
    
    @try {
        
        NSString   * serviceUrl = [WebServiceUtility getURLFor:GET_DAY_CLOSURE];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  * request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy  timeoutInterval:60.0];
        
        [request setHTTPMethod: @"GET"];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]  completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)  {
            
            if (data.length > 0 && connectionError == nil) {
                
                NSDictionary * dayClosureDic = [NSJSONSerialization JSONObjectWithData:data  options:0  error:NULL];
                
                if(([[dayClosureDic allKeys] containsObject:RESPONSE_HEADER] && [[dayClosureDic valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (dayClosureDic == nil)){
                    
                    [self.dayOpenServiceDelegate getDayClosureSummaryErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                }
                else  if ([[[dayClosureDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE]intValue] == 0) {
                    
                    [self.dayOpenServiceDelegate getDayClosureSummarySuccessResponse:dayClosureDic];
                }
                else {
                    
                    [self.dayOpenServiceDelegate getDayClosureSummaryErrorResponse:[[dayClosureDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                }
            }
            else {
                
                [self.dayOpenServiceDelegate getDayClosureSummaryErrorResponse:connectionError.localizedDescription];
            }
        }];
    } @catch (NSException * exception) {
        
        [self.dayOpenServiceDelegate getDayClosureSummaryErrorResponse:exception.description];
    }
}


/**
 * @description  Creating Day Open Summary...
 * @date         09/05/2018
 * @method       createDayOpenSummary
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)createDayClosure:(NSString*)requestString {
    @try {
        
        NSString * serviceUrl = [WebServiceUtility getURLFor:CREATE_DAY_CLOSURE];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  * request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                              timeoutInterval:60.0];
        
        [request setHTTPMethod: @"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%ld", [[serviceUrl dataUsingEncoding:NSUTF8StringEncoding] length]] forHTTPHeaderField:@"Content-Length"];
        
        //[request setHTTPBody:[requestString dataUsingEncoding:NSUTF8StringEncoding]];
        //[request setHTTPBody:requestData];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError) {
                                   
                                   if (data.length > 0 && connectionError == nil) {
                                       
                                       NSDictionary * createDayClosureResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                 options:0
                                                                                                                   error:NULL];
                                       
                                       if( ([[createDayClosureResponse allKeys] containsObject:RESPONSE_HEADER] && [[createDayClosureResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (createDayClosureResponse == nil)){
                                           
                                           [self.dayOpenServiceDelegate createDayClosureErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                                           
                                       }
                                       else  if ([[[createDayClosureResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                                           
                                           [self.dayOpenServiceDelegate createDayClosureSuccessResponse:createDayClosureResponse];
                                       }
                                       
                                       else {
                                           
                                           [self.dayOpenServiceDelegate createDayClosureErrorResponse:[[createDayClosureResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                                       }
                                   }
                                   else {
                                       [self.dayOpenServiceDelegate createDayClosureErrorResponse:connectionError.localizedDescription];
                                   }
                               }];
    }
    @catch (NSException * exception) {
        
        [self.dayOpenServiceDelegate createDayClosureErrorResponse:exception.description];
    }
}


/**
 * @description  here we are calling the generateOtp for customer....
 * @date         26/12/2017....
 * @method       generateCustomerOtp:--
 * @author       Srinivasulu
 * @param
 * @param        NSString
 *
 * @return       void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)generateBuildOTP:(NSString *)requestString{
    
    @try {

        NSString * serviceUrl = [WebServiceUtility getURLFor:GENERATE_BUILD_OTP];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  * request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                              timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * walkOutResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                  options:0
                                                                                    error:NULL];
                 
                 if( ([walkOutResponse.allKeys containsObject:RESPONSE_HEADER] && [[walkOutResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (walkOutResponse == nil)){
                     
                     [self.appSettingServicesDelegate generateBuildOTPErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else  if ([[[walkOutResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.appSettingServicesDelegate generateBuildOTPSuccessResponse:walkOutResponse];
                 }
                 else {
                     
                     [self.appSettingServicesDelegate generateBuildOTPErrorResponse:[[walkOutResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 
                 [self.appSettingServicesDelegate generateBuildOTPErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.appSettingServicesDelegate generateBuildOTPErrorResponse:exception.description];
    }
    
}

/**
 * @description  here we are calling the validate OTPService to validate user enter OTP is correct or not....
 * @date         26/12/2017....
 * @method       validateCustomerOtp:--
 * @author       Srinivasulu
 * @param
 * @param        NSString
 *
 * @return       void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)validateBuildOTP:(NSString *)requestString{
    
    @try {
   
        NSString * serviceUrl = [WebServiceUtility getURLFor:VALIDATE_BUILD_OTP];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  * request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                              timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * walkOutResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                  options:0
                                                                                    error:NULL];
                 
                 if( ([walkOutResponse.allKeys containsObject:RESPONSE_HEADER] && [[walkOutResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (walkOutResponse == nil)){
                     
                     [self.appSettingServicesDelegate validateBuildOTPErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else  if ([[[walkOutResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.appSettingServicesDelegate validateBuildOTPSuccessResponse:walkOutResponse];
                 }
                 else {
                     
                     [self.appSettingServicesDelegate validateBuildOTPErrorResponse:[[walkOutResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 
                 [self.appSettingServicesDelegate validateBuildOTPErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.appSettingServicesDelegate validateBuildOTPErrorResponse:exception.description];
    }
}

/**
 * @description  here we are calling the generateOtp for customer.... (Using in Offline classes)
 * @date         26/12/2017....
 * @method       getCustomerList:--
 * @author       Srinivasulu
 * @param
 * @param        NSString
 *
 * @return       BOOL
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(BOOL)getCustomerListThroughSynchronousRequest:(NSString *)requestString{
    
    BOOL savedStatus = false;
    @try {
        
        NSString * serviceUrl = [WebServiceUtility getURLFor:GET_CUSTOMER_DETAILS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  * request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                              timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        if (data.length > 0 && connectionError == nil)
        {
            NSError *err;
            NSDictionary *JSON  = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
            
            if( ([JSON.allKeys containsObject:RESPONSE_HEADER] && [[JSON valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (JSON == nil)){
                
                savedStatus = [self.customerServiceDelegate updateCustomerDetailsErrorResponseReturnStatus:NSLocalizedString(@"unable_to_process_your_request", nil)];
            }
            else if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                
                savedStatus = [self.customerServiceDelegate updateCustomerDetailsSuccessResponseReturnStatus:JSON];
            }
            else {
                savedStatus = [self.customerServiceDelegate updateCustomerDetailsErrorResponseReturnStatus:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
            }
        }
        else {
            
            savedStatus = [self.customerServiceDelegate updateCustomerDetailsErrorResponseReturnStatus:connectionError.localizedDescription];
        }
    }
    @catch (NSException *exception) {
        
        savedStatus =[self.customerServiceDelegate updateCustomerDetailsErrorResponseReturnStatus:exception.description];
    }
    @finally{
        
        return savedStatus;
    }
}

/**
 * @description  here we are calling the generateOtp for customer....
 * @date         26/12/2017....
 * @method       getCustomerListThroughAsynchronousRequest:--
 * @author       Srinivasulu
 * @param
 * @param        NSString
 *
 * @return       void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */
// *********** Below method is not using anywhere in our project **********
-(void)getCustomerListThroughAsynchronousRequest:(NSString *)requestString{
    
    @try {
        
        NSString * serviceUrl = [WebServiceUtility getURLFor:GET_CUSTOMER_DETAILS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  * request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                              timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * walkOutResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                  options:0
                                                                                    error:NULL];
                 
                 if( ([walkOutResponse.allKeys containsObject:RESPONSE_HEADER] && [[walkOutResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (walkOutResponse == nil)){
                     
                     [self.customerServiceDelegate getCustomerListErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else  if ([[[walkOutResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.customerServiceDelegate getCustomerListSuccessResponse:walkOutResponse];
                 }
                 else {
                     
                     [self.customerServiceDelegate getCustomerListErrorResponse:[[walkOutResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 
                 [self.customerServiceDelegate getCustomerListErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.customerServiceDelegate getCustomerListErrorResponse:exception.description];
    }
}

/**
 * @description  here we are calling the generateOtp for customer....
 * @date         26/12/2017....
 * @method       getCustomerList:--
 * @author       Srinivasulu
 * @param
 * @param        NSString
 *
 * @return       BOOL
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */
// *******************************  Below method is not using anywhere in this project*******************************
-(BOOL)updateCustomerDetailsThroughSynchronousRequest:(NSString *)requestString{
    
    BOOL savedStatus = false;
    @try {
        
        NSString * serviceUrl = [WebServiceUtility getURLFor:GET_CUSTOMER_DETAILS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  * request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                              timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        if (data.length > 0 && connectionError == nil)
        {
            NSError *err;
            NSDictionary *JSON  = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
            
            if( ([JSON.allKeys containsObject:RESPONSE_HEADER] && [[JSON valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (JSON == nil)){
                
                savedStatus = [self.customerServiceDelegate updateCustomerDetailsErrorResponseReturnStatus:NSLocalizedString(@"unable_to_process_your_request", nil)];
            }
            else if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                
                savedStatus = [self.customerServiceDelegate updateCustomerDetailsSuccessResponseReturnStatus:JSON];
            }
            else {
                savedStatus = [self.customerServiceDelegate updateCustomerDetailsErrorResponseReturnStatus:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
            }
        }
        else {
            
            savedStatus = [self.customerServiceDelegate updateCustomerDetailsErrorResponseReturnStatus:connectionError.localizedDescription];
        }
    }
    @catch (NSException *exception) {
        
        savedStatus =[self.customerServiceDelegate updateCustomerDetailsErrorResponseReturnStatus:exception.description];
    }
    @finally{
        
        return savedStatus;
    }
}

/**
 * @description  here we are calling the generateOtp for customer....
 * @date         26/12/2017....
 * @method       updateCustomerDetailsAsynchronousRequest:--
 * @author       Srinivasulu
 * @param
 * @param        NSString
 *
 * @return       void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)updateCustomerDetailsAsynchronousRequest:(NSString *)requestString{
    
    @try {
        
        NSString * serviceUrl = [WebServiceUtility getURLFor:UPDATE_CUSTOMER_DETAILS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  * request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * walkOutResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                  options:0
                                                                                    error:NULL];
                 
                 if( ([walkOutResponse.allKeys containsObject:RESPONSE_HEADER] && [[walkOutResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (walkOutResponse == nil)){
                     
                     [self.customerServiceDelegate updateCustomerDetailsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else  if ([[[walkOutResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.customerServiceDelegate updateCustomerDetailsSuccessResponse:walkOutResponse];
                 }
                 else {
                     
                     [self.customerServiceDelegate updateCustomerDetailsErrorResponse:[[walkOutResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 
                 [self.customerServiceDelegate updateCustomerDetailsErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.customerServiceDelegate updateCustomerDetailsErrorResponse:exception.description];
    }
}



/**
 * @description  here we are calling the getmember details in Synchronous manner....
 * @date         10/09/2018....
 * @method       getAllMembersDetailsThroughSynchronousRequest:--
 * @author       Srinivasulu
 * @param
 * @param        NSString
 *
 * @return       BOOL
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(BOOL)getAllMembersDetailsThroughSynchronousRequest:(NSString *)requestString{
    
    BOOL savedStatus = false;
    @try {
        
        NSString * serviceUrl = [WebServiceUtility getURLFor:GET_MEMBERS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  * request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                              timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        if (data.length > 0 && connectionError == nil)
        {
            NSError *err;
            NSDictionary *JSON  = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
            
            if( ([JSON.allKeys containsObject:RESPONSE_HEADER] && [[JSON valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (JSON == nil)){
                
                savedStatus = [self.memberServiceDelegate getAllMembersDetailsErrorResponseAndReturnSaveStatus:NSLocalizedString(@"unable_to_process_your_request", nil)];
            }
            else if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                
                savedStatus = [self.memberServiceDelegate getAllMembersDetailsSuccessResponseAndReturnSaveStatus:JSON];
            }
            else {
                savedStatus = [self.memberServiceDelegate getAllMembersDetailsErrorResponseAndReturnSaveStatus:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
            }
        }
        else {
            
            savedStatus = [self.memberServiceDelegate getAllMembersDetailsErrorResponseAndReturnSaveStatus:connectionError.localizedDescription];
        }
    }
    @catch (NSException *exception) {
        
        savedStatus =[self.memberServiceDelegate getAllMembersDetailsErrorResponseAndReturnSaveStatus:exception.description];
    }
    @finally{
        
        return savedStatus;
    }
}

/**
 * @description  here we are calling the getmember details in Asynchronous manner....
 * @date         10/09/2018....
 * @method       getAllMembersDetailsAsynchronousRequest:--
 * @author       Srinivasulu
 * @param
 * @param        NSString
 *
 * @return       Void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)getAllMembersDetailsAsynchronousRequest:(NSString *)requestString{
    
    @try {
        
        NSString * serviceUrl = [WebServiceUtility getURLFor:GET_MEMBERS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  * request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                              timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * walkOutResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                  options:0
                                                                                    error:NULL];
                 
                 if( ([walkOutResponse.allKeys containsObject:RESPONSE_HEADER] && [[walkOutResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (walkOutResponse == nil)){
                     
                     [self.memberServiceDelegate getAllMembersDetailsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else  if ([[[walkOutResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.memberServiceDelegate getAllMembersDetailsSuccessResponse:walkOutResponse];
                 }
                 else {
                     
                     [self.memberServiceDelegate getAllMembersDetailsErrorResponse:[[walkOutResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 
                 [self.memberServiceDelegate getAllMembersDetailsErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.memberServiceDelegate getAllMembersDetailsErrorResponse:exception.description];
    }
}

/**
 * @description  here we are calling the getMemberShipUsers in Synchronous manner....
 * @date         16/11/2018....
 * @method       getAllMemberShipUsersThroughSynchronousRequest:--
 * @author       Srinivasulu
 * @param
 * @param        NSString
 *
 * @return       BOOL
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(BOOL)getAllMemberShipUsersThroughSynchronousRequest:(NSString *)requestString{
    
    BOOL savedStatus = false;
    @try {
        
        NSString * serviceUrl = [WebServiceUtility getURLFor:GET_MEMBERSHIP_USERS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  * request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                              timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        if (data.length > 0 && connectionError == nil)
        {
            NSError *err;
            NSDictionary *JSON  = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
            
            if( ([JSON.allKeys containsObject:RESPONSE_HEADER] && [[JSON valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (JSON == nil)){
                
                savedStatus = [self.memberServiceDelegate getAllMemberShipUsersErrorResponseAndReturnSaveStatus:NSLocalizedString(@"unable_to_process_your_request", nil)];
            }
            else if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                
                savedStatus = [self.memberServiceDelegate getAllMemberShipUsersSuccessResponseAndReturnSaveStatus:JSON];
            }
            else {
                savedStatus = [self.memberServiceDelegate getAllMemberShipUsersErrorResponseAndReturnSaveStatus:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
            }
        }
        else {
            
            savedStatus = [self.memberServiceDelegate getAllMemberShipUsersErrorResponseAndReturnSaveStatus:connectionError.localizedDescription];
        }
    }
    @catch (NSException *exception) {
        
        savedStatus =[self.memberServiceDelegate getAllMemberShipUsersErrorResponseAndReturnSaveStatus:exception.description];
    }
    @finally{
        
        return savedStatus;
    }
}

/**
 * @description  here we are calling the getMemberShipUsers in Asynchronous manner....
 * @date         16/11/2018....
 * @method       getAllMemberShipUsersAsynchronousRequest:--
 * @author       Srinivasulu
 * @param
 * @param        NSString
 *
 * @return       Void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)getAllMemberShipUsersAsynchronousRequest:(NSString *)requestString{
    
    @try {
        
        NSString * serviceUrl = [WebServiceUtility getURLFor:GET_MEMBERSHIP_USERS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  * request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                              timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * walkOutResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                  options:0
                                                                                    error:NULL];
                 
                 if( ([walkOutResponse.allKeys containsObject:RESPONSE_HEADER] && [[walkOutResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (walkOutResponse == nil)){
                     
                     [self.memberServiceDelegate getAllMemberShipUsersErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else  if ([[[walkOutResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.memberServiceDelegate getAllMemberShipUsersSuccessResponse:walkOutResponse];
                 }
                 else {
                     
                     [self.memberServiceDelegate getAllMemberShipUsersErrorResponse:[[walkOutResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 
                 [self.memberServiceDelegate getAllMemberShipUsersErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.memberServiceDelegate getAllMemberShipUsersErrorResponse:exception.description];
    }
}


/**
 * @description  here we are calling the getmember details in Synchronous manner....
 * @date         10/09/2018....
 * @method       getAllMembersDetailsThroughSynchronousRequest:--
 * @author       Srinivasulu
 * @param
 * @param        NSString
 *
 * @return       BOOL
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(BOOL)getAllRolesDetailsThroughSynchronousRequest:(NSString *)requestString{
    
    BOOL savedStatus = false;
    @try {
        
        NSString * serviceUrl = [WebServiceUtility getURLFor:GET_ROLES];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  * request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                              timeoutInterval:60.0];
        request.HTTPMethod = @"GET";

        
        request.HTTPBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        if (data.length > 0 && connectionError == nil)
        {
            NSError *err;
            NSDictionary *JSON  = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
            
            if( ([JSON.allKeys containsObject:RESPONSE_HEADER] && [[JSON valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (JSON == nil)){
                
                savedStatus = [self.roleServiceDelegate getAllRolesDetailsErrorResponseAndReturnSaveStatus:NSLocalizedString(@"unable_to_process_your_request", nil)];
            }
            else if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                
                savedStatus = [self.roleServiceDelegate getAllRolesDetailsSuccessResponseAndReturnSaveStatus:JSON];
            }
            else {
                savedStatus = [self.roleServiceDelegate getAllRolesDetailsErrorResponseAndReturnSaveStatus:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
            }
        }
        else {
            
            savedStatus = [self.roleServiceDelegate getAllRolesDetailsErrorResponseAndReturnSaveStatus:connectionError.localizedDescription];
        }
    }
    @catch (NSException *exception) {
        
        savedStatus =[self.roleServiceDelegate getAllRolesDetailsErrorResponseAndReturnSaveStatus:exception.description];
    }
    @finally{
        
        return savedStatus;
    }
}

/**
 * @description  here we are calling the getmember details in Asynchronous manner....
 * @date         10/09/2018....
 * @method       getAllMembersDetailsAsynchronousRequest:--
 * @author       Srinivasulu
 * @param
 * @param        NSString
 *
 * @return       Void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)getAllRolesDetailsAsynchronousRequest:(NSString *)requestString{
    
    @try {
        
        NSString * serviceUrl = [WebServiceUtility getURLFor:GET_MEMBERS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  * request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                              timeoutInterval:60.0];
        request.HTTPMethod = @"GET";

        
        request.HTTPBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * walkOutResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                  options:0
                                                                                    error:NULL];
                 
                 if( ([walkOutResponse.allKeys containsObject:RESPONSE_HEADER] && [[walkOutResponse valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (walkOutResponse == nil)){
                     
                     [self.roleServiceDelegate getAllRolesDetailsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else  if ([[[walkOutResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.roleServiceDelegate getAllRolesDetailsSuccessResponse:walkOutResponse];
                 }
                 else {
                     
                     [self.roleServiceDelegate getAllRolesDetailsErrorResponse:[[walkOutResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 
                 [self.roleServiceDelegate getAllRolesDetailsErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.roleServiceDelegate getAllRolesDetailsErrorResponse:exception.description];
    }
}


- (id)checkGivenValueIsNullOrNil:(id)inputValue defaultReturn:(NSString *)returnStirng{
    
    @try {
        if ([inputValue isKindOfClass:[NSNull class]] || (inputValue == nil)) {
            return returnStirng;
        }
        else {
            
            if(![inputValue isKindOfClass:[NSString class]]){
                if([inputValue isEqualToString:@"<null>"])
                    return returnStirng;
                
            }
            
            return inputValue;
        }
    } @catch (NSException *exception) {
        return @"--";
    }
}

/**
 * @description  here we are calling createRestBooking method to Create Order ....
 * @date         09/01/2019....
 * @method       createRestBooking:--
 * @author       Roja
 * @param
 * @param        NSString
 *
 * @return       Void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */
-(void)createRestBooking:(NSString*)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:CREATE_NEW_REST_BOOKING];
    
    
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                         timeoutInterval:60.0];
    [request setHTTPMethod: @"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", [[serviceUrl dataUsingEncoding:NSUTF8StringEncoding] length]] forHTTPHeaderField:@"Content-Length"];
    
    @try {
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * response = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                 
                 
                 if( ([response.allKeys containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (response == nil)) {
                     
                     [self.restaurantBookingServiceDelegate createBookingsFailure:NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] && ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0)) {
                     
                     [self.restaurantBookingServiceDelegate createBookingsSuccess:response];
                 }
                 else {
                     
                     [self.restaurantBookingServiceDelegate createBookingsFailure:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 
                 [self.restaurantBookingServiceDelegate createBookingsFailure:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.restaurantBookingServiceDelegate createBookingsFailure:exception.description];
        //NSLocalizedString(@"CheckOutFailed", nil)
    }
}


/**
 * @description  here we are calling getCustomerDetails method to Create Order ....
 * @date         09/01/2019....
 * @method       getCustomerDetails:--
 * @author       Roja
 * @param
 * @param        NSString
 *
 * @return       Void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)getCustomerDetails:(NSString *)requestString{
    
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_CUSTOMER_DETAILS_D_1];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy  timeoutInterval:60.0];
        [request setHTTPMethod: @"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%ld", [[serviceUrl dataUsingEncoding:NSUTF8StringEncoding] length]] forHTTPHeaderField:@"Content-Length"];
        
        
        [request setHTTPBody:[requestString dataUsingEncoding:NSUTF8StringEncoding]];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * responceDic = [NSJSONSerialization JSONObjectWithData:data  options:0 error:NULL];
                 
                 
                 NSError * err_;
                 NSData * jsonData = [NSJSONSerialization dataWithJSONObject:responceDic options:0 error:&err_];
                 NSString * responce = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                 
                 if(([[responceDic allKeys] containsObject:RESPONSE_HEADER] && [[responceDic valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (responceDic == nil)){
                     
                     [self.customerServiceDelegate getCustomerDetailsErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                     
                 }
                 else if ([[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue] == 0) {
                     [self.customerServiceDelegate getCustomerDetailsSuccessResponse:responceDic];
                 }
                 else{
                     [self.customerServiceDelegate getCustomerDetailsErrorResponse:[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.customerServiceDelegate getCustomerDetailsErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    }
    @catch (NSException *exception) {
        [self.customerServiceDelegate getCustomerDetailsErrorResponse:exception.description];
    }
}

-(void)getPhoneNos:(NSString *)requestString {
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_PHONE_NOS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        
        [request setHTTPMethod: @"GET"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,NSData *data, NSError*connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 
                 if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                     
                     [self.restaurantBookingServiceDelegate getPhoneNosFailure: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE]&& ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0)) {
                     
                     [self.restaurantBookingServiceDelegate getPhoneNosSuccess:response];
                 }
                 else {
                     [self.restaurantBookingServiceDelegate getPhoneNosFailure:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.restaurantBookingServiceDelegate getPhoneNosFailure:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        [self.restaurantBookingServiceDelegate getPhoneNosFailure:NSLocalizedString(@"CheckOutFailed", nil)];
    }
}



-(void)getRestBookingDetails:(NSString*)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_ORDER_DETAILS];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [request setHTTPMethod: @"GET"];
    
    
    @try {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 if (![response isKindOfClass:[NSNull class]]) {
                     
                     if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                         
                         [self.restaurantBookingServiceDelegate getBookingDetailsFailure: NSLocalizedString(@"unable_to_process_your_request", nil)];
                     }
                     else if([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                         
                         [self.restaurantBookingServiceDelegate getBookingDetailsSuccess:response];
                     }
                     else {
                         [self.restaurantBookingServiceDelegate getBookingDetailsFailure:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                     }
                 }
                 else {
                     [self.restaurantBookingServiceDelegate getBookingDetailsFailure:@"Problem occured while processing"];
                 }
             }
             else {
                 [self.restaurantBookingServiceDelegate getBookingDetailsFailure:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        [self.restaurantBookingServiceDelegate getBookingDetailsFailure:exception.name];
    }
}


/**
 * @description  here we are calling getOrdersByPage method....
 * @date         09/01/2019....
 * @method       getOrdersByPage:--
 * @author       Roja
 * @param
 * @param        NSString
 *
 * @return       Void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)getOrdersByPage:(NSString *)requestString{
    
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_ORDERS_BY_PAGE];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        [request setHTTPMethod: @"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%ld", [[serviceUrl dataUsingEncoding:NSUTF8StringEncoding] length]] forHTTPHeaderField:@"Content-Length"];
        
        
        [request setHTTPBody:[requestString dataUsingEncoding:NSUTF8StringEncoding]];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * responceDic = [NSJSONSerialization JSONObjectWithData:data  options:0 error:NULL];
                 
                 
                 NSError * err_;
                 NSData * jsonData = [NSJSONSerialization dataWithJSONObject:responceDic options:0 error:&err_];
                 NSString * responce = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                 
                 if(([[responceDic allKeys] containsObject:RESPONSE_HEADER] && [[responceDic valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (responceDic == nil)){
                     
                     [self.fbOrderServiceDelegate getOrdersByPageErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                     
                 }
                 else if ([[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue] == 0) {
                     [self.fbOrderServiceDelegate getOrdersByPageSuccessRespose:responceDic];
                 }
                 else{
                     [self.fbOrderServiceDelegate getOrdersByPageErrorResponse:[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.fbOrderServiceDelegate getOrdersByPageErrorResponse:connectionError.localizedDescription];
             }
         }];
        
    }
    @catch (NSException *exception) {
        [self.fbOrderServiceDelegate getOrdersByPageErrorResponse:exception.description];
    }
}


-(void)getListOfBookings:(NSString*)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_ALL_REST_BOOKINGS];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                         timeoutInterval:60.0];
    [request setHTTPMethod: @"GET"];
    
    
    @try {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 
                 if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                     
                     [self.restaurantBookingServiceDelegate getAllBookingsFailure: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 
                 else if ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.restaurantBookingServiceDelegate getAllBookingsSuccess:response];
                 }
                 else {
                     [self.restaurantBookingServiceDelegate getAllBookingsFailure:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.restaurantBookingServiceDelegate getAllBookingsFailure:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.restaurantBookingServiceDelegate getAllBookingsFailure:exception.description];
    }
}



-(void)getTheAvailableLevelsWithRestFullService:(NSString *)requestString {
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_AVAILABEL_LEVELS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                            timeoutInterval:60.0];
        [request setHTTPMethod: @"GET"];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError) {
                                   
                                   if (data.length > 0 && connectionError == nil) {
                                       
                                       NSDictionary * responceDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                                       
                                       if(([[responceDic allKeys] containsObject:RESPONSE_HEADER] && [[responceDic valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (responceDic == nil)){
                                           
                                           [self.outletServiceDelegate getOutletLevelsFailureResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                                       }
                                       else  if ([[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]== 0) {
                                           
                                           [self.outletServiceDelegate getOutletLevelsSuccessResponse:responceDic];
                                       }
                                       else {
                                           
                                           [self.outletServiceDelegate getOutletLevelsFailureResponse:[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                                       }
                                   }
                                   else {
                                       [self.outletServiceDelegate getOutletLevelsFailureResponse:connectionError.localizedDescription];
                                   }
                               }];
    }
    
    @catch (NSException *exception) {
        [self.outletServiceDelegate getOutletLevelsFailureResponse:exception.description];
        
    }
    @finally {
        
    }
}





-(void)getLayoutDetails:(NSString*)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_ALL_LAYOUT_TABLES];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod: @"GET"];
    
    
    @try {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 
                 if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                     
                     [self.storeServiceDelegate getAllLayoutTablesErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.storeServiceDelegate getAllLayoutTablesSuccessResponse:response];
                 }
                 else {
                     [self.storeServiceDelegate getAllLayoutTablesErrorResponse:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.storeServiceDelegate getAllLayoutTablesErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.storeServiceDelegate getAllLayoutTablesErrorResponse:exception.description];
    }
}



-(void)updateRestBooking:(NSString *)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:UPDATE_REST_BOOKING];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                         timeoutInterval:60.0];
    [request setHTTPMethod: @"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", [[serviceUrl dataUsingEncoding:NSUTF8StringEncoding] length]] forHTTPHeaderField:@"Content-Length"];
    
    @try {
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 if ([[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE]&& ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0)) {
                     
                     [self.restaurantBookingServiceDelegate updateBookingSuccess:response];
                 }
                 else {
                     [self.restaurantBookingServiceDelegate updateBookingFailure:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.restaurantBookingServiceDelegate updateBookingFailure:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        [self.restaurantBookingServiceDelegate updateBookingFailure:NSLocalizedString(@"CheckOutFailed", nil)];
    }
}


-(void)updateKotStatus:(NSString *)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:UPDATE_KOT_STATUS];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                         timeoutInterval:60.0];

    [request setHTTPMethod: @"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld", [[serviceUrl dataUsingEncoding:NSUTF8StringEncoding] length]] forHTTPHeaderField:@"Content-Length"];
    
    NSMutableDictionary * reqDic = [[NSJSONSerialization JSONObjectWithData:[requestString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL] mutableCopy];
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
    
    request.HTTPBody = jsonData;
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError) {
                               
                               if (data.length > 0 && connectionError == nil) {
                                   
                                   NSDictionary * responceDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                                   
                                   if(([[responceDic allKeys] containsObject:RESPONSE_HEADER] && [[responceDic valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (responceDic == nil)){
                                       
                                       [self.kotServiceDelegate updateKotStatusFailureResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                                   }
                                   else  if ([[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]== 0) {
                                       
                                       [self.kotServiceDelegate updateKotStatusSuccessResponse:responceDic];
                                   }
                                   else {
                                       
                                       [self.kotServiceDelegate updateKotStatusFailureResponse:[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                                   }
                               }
                               else {
                                   [self.kotServiceDelegate updateKotStatusFailureResponse:connectionError.localizedDescription];
                               }
                           }];
}


//-(void)getItemDetailsInKOT:(NSString *)requestString {
//
//    NSString *serviceUrl = [WebServiceUtility getURLFor:ITEM_DETAILS_IN_KOT];
//    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
//    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
//
//    NSURL *url = [NSURL URLWithString:serviceUrl];
//    NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
//                                                         timeoutInterval:60.0];
//    [request setHTTPMethod: @"POST"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [request setValue:[NSString stringWithFormat:@"%ld", [[serviceUrl dataUsingEncoding:NSUTF8StringEncoding] length]] forHTTPHeaderField:@"Content-Length"];
//
//    NSMutableDictionary * reqDic = [[NSJSONSerialization JSONObjectWithData:[requestString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL] mutableCopy];
//    NSError * err;
//    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
//
//    request.HTTPBody = jsonData;
//
//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:[NSOperationQueue mainQueue]
//                           completionHandler:^(NSURLResponse *response,
//                                               NSData *data, NSError *connectionError) {
//
//                               if (data.length > 0 && connectionError == nil) {
//
//                                   NSDictionary * responceDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
//
//
//                                   NSError * err_;
//                                   NSData * jsonData = [NSJSONSerialization dataWithJSONObject:responceDic options:0 error:&err_];
//                                   NSString * responce = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//                                   if(([[responceDic allKeys] containsObject:RESPONSE_HEADER] && [[responceDic valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (responceDic == nil)){
//
//                                       [self.kotServiceDelegate getItemsDetailsInKOTFailureResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
//                                   }
//                                   else  if ([[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]== 0) {
//
//                                       [self.kotServiceDelegate getItemsDetailsInKOTSuccessResponse:responceDic];
//                                   }
//                                   else {
//
//                                       [self.kotServiceDelegate getItemsDetailsInKOTFailureResponse:[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
//                                   }
//                               }
//                               else {
//                                   [self.kotServiceDelegate getItemsDetailsInKOTFailureResponse:connectionError.localizedDescription];
//                               }
//                           }];
//}

-(void)getItemDetailsInKOT:(NSString *)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:ITEM_DETAILS_IN_KOT];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod: @"GET"];
    
    
    @try {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 
                 if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                     
                     [self.kotServiceDelegate getItemsDetailsInKOTFailureResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.kotServiceDelegate getItemsDetailsInKOTSuccessResponse:response];
                 }
                 else {
                     [self.kotServiceDelegate getItemsDetailsInKOTFailureResponse:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.kotServiceDelegate getItemsDetailsInKOTFailureResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.kotServiceDelegate getItemsDetailsInKOTFailureResponse:exception.description];
    }
}

-(void)getMenuItemsWithRestFullServiceSynchrousRequest:(NSString *)requestString{
    
    @try {
        
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_MENU_ITEMS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        if (data.length > 0 && connectionError == nil)
        {
            NSError * err;
            
            NSDictionary * menuDetailsResponseDic  = [NSJSONSerialization JSONObjectWithData:data
                                                                                     options:kNilOptions
                                                                                       error:&err];
            
            if (menuDetailsResponseDic.count) {
                
                if( ([menuDetailsResponseDic.allKeys containsObject:RESPONSE_HEADER] && [[menuDetailsResponseDic valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (menuDetailsResponseDic == nil)){
                    
                    [self.getMenuServiceDelegate getMenuItemsFailureResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                }
                else if ([[[menuDetailsResponseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                    
                    [self.getMenuServiceDelegate getMenuItemsSuccessResponse:menuDetailsResponseDic];
                }
                else {
                    NSString * responseMsg = [[menuDetailsResponseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE];
                    [self.getMenuServiceDelegate getMenuItemsFailureResponse:responseMsg];
                }
            }
            else {
                [self.getMenuServiceDelegate getMenuItemsFailureResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
            }
        }
        else {
            
            [self.getMenuServiceDelegate getMenuItemsFailureResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
        }
        
    }
    
    @catch (NSException *exception) {
        [self.getMenuServiceDelegate getMenuItemsFailureResponse:exception.description];
        
    }
    @finally {
        
    }
}

-(void)getMenuCategoriesWithRestFullServiceSynchrousRequest:(NSString *)requestString{
    
    @try {
        
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_MENU_CATEGIORE_DETAILS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        if (data.length > 0 && connectionError == nil)
        {
            NSError * err;
            
            NSDictionary * menuDetailsResponseDic  = [NSJSONSerialization JSONObjectWithData:data
                                                                                     options:kNilOptions
                                                                                       error:&err];
            
            if (menuDetailsResponseDic.count) {
                
                if( ([menuDetailsResponseDic.allKeys containsObject:RESPONSE_HEADER] && [[menuDetailsResponseDic valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (menuDetailsResponseDic == nil)){
                    
                    [self.getMenuServiceDelegate getCategoryFailureResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                }
                else if ([[[menuDetailsResponseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                    
                    [self.getMenuServiceDelegate getCategorySuccessResponse:menuDetailsResponseDic];
                }
                else {
                    NSString * responseMsg = [[menuDetailsResponseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE];
                    [self.getMenuServiceDelegate getCategoryFailureResponse:responseMsg];
                }
            }
            else {
                [self.getMenuServiceDelegate getCategoryFailureResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
            }
        }
        else {
            
            [self.getMenuServiceDelegate getCategoryFailureResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
        }
        
    }
    
    @catch (NSException *exception) {
        [self.getMenuServiceDelegate getCategoryFailureResponse:exception.description];
        
    }
    @finally {
        
    }
}


/**
 * @description
 * @date         16/04/2019....
 * @method       getAvailableGiftVouchers:--
 * @author       Roja
 * @param
 * @param        NSString
 *
 * @return       Void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)getAvailableGiftVouchers:(NSString *)requestString {
    
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_GIFT_VOUCHERS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];

        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        request.HTTPMethod = @"GET";

        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        
        if (data.length > 0 && connectionError == nil)
        {
            NSError * err;
            
            NSDictionary * menuDetailsResponseDic  = [NSJSONSerialization JSONObjectWithData:data
                                                                                     options:kNilOptions
                                                                                       error:&err];
            
            if (menuDetailsResponseDic.count) {
                
                if( ([menuDetailsResponseDic.allKeys containsObject:RESPONSE_HEADER] && [[menuDetailsResponseDic valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (menuDetailsResponseDic == nil)){
                    
                    [self.giftVoucherSrvcDelegate getGiftVouchersFailureResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                }
                else if ([[[menuDetailsResponseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                    
                    [self.giftVoucherSrvcDelegate getGiftVouchersSuccessResponse:menuDetailsResponseDic];
                }
                else {
                    NSString * responseMsg = [[menuDetailsResponseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE];
                    [self.giftVoucherSrvcDelegate getGiftVouchersFailureResponse:responseMsg];
                }
            }
            else {
                [self.giftVoucherSrvcDelegate getGiftVouchersFailureResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
            }
        }
        else {
            [self.giftVoucherSrvcDelegate getGiftVouchersFailureResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
        }
        
    }
    @catch (NSException *exception) {
        [self.giftVoucherSrvcDelegate getGiftVouchersFailureResponse:exception.description];
        
    }
    @finally {
        
    }
}

/**
 * @description
 * @date         16/04/2019....
 * @method       getGiftVouchersBySearchCriteria:--
 * @author       Roja
 * @param
 * @param        NSString
 *
 * @return       Void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)getGiftVouchersBySearchCriteria:(NSString *)requestString {
    
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_GIFT_VOUCHERS_BY_SEARCH_CRITERIA];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        if (data.length > 0 && connectionError == nil)
        {
            NSError * err;
            
            NSDictionary * menuDetailsResponseDic  = [NSJSONSerialization JSONObjectWithData:data
                                                                                     options:kNilOptions
                                                                                       error:&err];
            
            if (menuDetailsResponseDic.count) {
                
                if( ([menuDetailsResponseDic.allKeys containsObject:RESPONSE_HEADER] && [[menuDetailsResponseDic valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (menuDetailsResponseDic == nil)){
                    
                    [self.giftVoucherSrvcDelegate getGiftVoucherBySearchCriteriaFailureResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                }
                else if ([[[menuDetailsResponseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                    
                    [self.giftVoucherSrvcDelegate getGiftVoucherBySearchCriteriaSuccessResponse:menuDetailsResponseDic];
                }
                else {
                    NSString * responseMsg = [[menuDetailsResponseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE];
                    [self.giftVoucherSrvcDelegate getGiftVoucherBySearchCriteriaFailureResponse:responseMsg];
                }
            }
            else {
                [self.giftVoucherSrvcDelegate getGiftVoucherBySearchCriteriaFailureResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
            }
        }
        else {
            [self.giftVoucherSrvcDelegate getGiftVoucherBySearchCriteriaFailureResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
        }
        
    }
    @catch (NSException *exception) {
        [self.giftVoucherSrvcDelegate getGiftVoucherBySearchCriteriaFailureResponse:exception.description];
        
    }
    @finally {
        
    }
}

/**
 * @description
 * @date         16/06/2019....
 * @method       getGiftCouponsBySearchCriteria:--
 * @author       Roja
 * @param
 * @param        NSString
 *
 * @return       Void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)getGiftCouponsBySearchCriteria:(NSString *)requestString { 
    
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_GIFT_COUPONS_BY_SEARCH_CRITERIA];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        if (data.length > 0 && connectionError == nil)
        {
            NSError * err;
            
            NSDictionary * menuDetailsResponseDic  = [NSJSONSerialization JSONObjectWithData:data
                                                                                     options:kNilOptions
                                                                                       error:&err];
            
            if (menuDetailsResponseDic.count) {
                
                if( ([menuDetailsResponseDic.allKeys containsObject:RESPONSE_HEADER] && [[menuDetailsResponseDic valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (menuDetailsResponseDic == nil)){
                  
                    [self.giftCouponServicesDelegate getGiftCouponsSearchErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                }
                else if ([[[menuDetailsResponseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0 || [menuDetailsResponseDic valueForKey:RESPONSE_CODE] == 0) {
                    
                    [self.giftCouponServicesDelegate getGiftCouponsBySearchSuccessResponse:menuDetailsResponseDic];
                }
                else {
                    NSString * responseMsg = [[menuDetailsResponseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE];
                    [self.giftCouponServicesDelegate getGiftCouponsSearchErrorResponse:responseMsg];
                }
            }
            else {
                [self.giftCouponServicesDelegate getGiftCouponsSearchErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
            }
        }
        else {
            [self.giftCouponServicesDelegate getGiftCouponsSearchErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
        }
        
    }
    @catch (NSException *exception) {
        [self.giftCouponServicesDelegate getGiftCouponsSearchErrorResponse:exception.description];
        
    }
    @finally {
        
    }
}


/**
 * @description  here we are calling issueGiftVoucherToCustomer method to issue gift voucher to customer ....
 * @date         07/03/2019....
 * @method       getCustomerDetails:--
 * @author       Roja
 * @param
 * @param        NSString
 *
 * @return       Void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)issueGiftVoucherToCustomer:(NSString *)requestString{
    
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:ISSUE_GIFT_VOUCHER_TO_CUSTOMER];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy  timeoutInterval:60.0];
        [request setHTTPMethod: @"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%ld", [[serviceUrl dataUsingEncoding:NSUTF8StringEncoding] length]] forHTTPHeaderField:@"Content-Length"];
        
        
        [request setHTTPBody:[requestString dataUsingEncoding:NSUTF8StringEncoding]];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary * responceDic = [NSJSONSerialization JSONObjectWithData:data  options:0 error:NULL];
                 
                 
                 NSError * err_;
                 NSData * jsonData = [NSJSONSerialization dataWithJSONObject:responceDic options:0 error:&err_];
                 NSString * responce = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                 
                 if(([[responceDic allKeys] containsObject:RESPONSE_HEADER] && [[responceDic valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (responceDic == nil)){
                     
                     [self.giftVoucherSrvcDelegate issueGiftVoucherToCustomerFailureResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                     
                 }
                 else if ([[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue] == 0) {
                     [self.giftVoucherSrvcDelegate issueGiftVoucherToCustomerSuccessResponse:responceDic];
                 }
                 else{
                     [self.giftVoucherSrvcDelegate issueGiftVoucherToCustomerFailureResponse:[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.giftVoucherSrvcDelegate issueGiftVoucherToCustomerFailureResponse:connectionError.localizedDescription];
             }
         }];
        
    }
    @catch (NSException *exception) {
        [self.giftVoucherSrvcDelegate issueGiftVoucherToCustomerFailureResponse:exception.description];
    }
}




/**
 * @description  here we are calling issueGiftVoucherToCustomer method to issue gift voucher to customer ....
 * @date         07/06/2019....
 * @method       issueGiftCouponToCustomer:--
 * @author       Roja
 * @param
 * @param        NSString
 *
 * @return       Void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)issueGiftCouponToCustomer:(NSString *)requestString{
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:ISSUE_GIFT_COUPON_TO_CUSTOMER];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod: @"GET"];
    
    
    @try {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 
                 if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                     
                     [self.giftCouponServicesDelegate issueGiftCouponsToCustomerErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.giftCouponServicesDelegate issueGiftCouponsToCustomerSuccessResponse:response];
                 }
                 else {
                     [self.giftCouponServicesDelegate issueGiftCouponsToCustomerErrorResponse:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.giftCouponServicesDelegate issueGiftCouponsToCustomerErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.giftCouponServicesDelegate issueGiftCouponsToCustomerErrorResponse:exception.description];
    }
    
}


/**
 * @description
 * @date         25/03/2019....
 * @method       getAvailableTables:--
 * @author       Roja
 * @param
 * @param        NSString
 *
 * @return       Void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */
-(void)getAvailableTables:(NSString *)requestString{
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_AVAILABLE_TABLES];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod: @"GET"];
    
    
    @try {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 
                 if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                     
                     [self.storeServiceDelegate getAvailableTablesErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.storeServiceDelegate getAvailableTablesSuccessResponse:response];
                 }
                 else {
                     [self.storeServiceDelegate getAvailableTablesErrorResponse:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.storeServiceDelegate getAvailableTablesErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.storeServiceDelegate getAvailableTablesErrorResponse:exception.description];
    }
}
    

/**
 * @description
 * @date         25/03/2019....
 * @method       getCustomerEatingHabits:--
 * @author       Roja
 * @param
 * @param        NSString
 *
 * @return       Void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */
-(void)getCustomerEatingHabits:(NSString *)requestString{
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_EATING_HABITS];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod: @"GET"];
    
    @try {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 
                 if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                     
                     [self.outletOrderServiceDelegate getCustomerEatingHabitsErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.outletOrderServiceDelegate getCustomerEatingHabitsSuccessRespose:response];
                 }
                 else {
                     [self.outletOrderServiceDelegate getCustomerEatingHabitsErrorResponse:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.outletOrderServiceDelegate getCustomerEatingHabitsErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.outletOrderServiceDelegate getCustomerEatingHabitsErrorResponse:exception.description];
    }
}



/**
 * @description
 * @date         16/04/2019....
 * @method       getRouteMasters:--
 * @author       Roja
 * @param
 * @param        NSString
 *
 * @return       Void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */
-(void)getRouteMasters:(NSString *)requestString{
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_ROUTE_MASTER];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod: @"GET"];
    
    @try {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 
                 if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                     
                     [self.routingServiceDelegate getRouteMastersFailureResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.routingServiceDelegate getRouteMastersSuccessResponse:response];
                 }
                 else {
                     [self.routingServiceDelegate getRouteMastersFailureResponse:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.routingServiceDelegate getRouteMastersFailureResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.routingServiceDelegate getRouteMastersFailureResponse:exception.description];
    }
}



/**
 * @description
 * @date         10/05/2019....
 * @method       getLoyaltyCardDownloadsDetails:--
 * @author       Roja
 * @param
 * @param        NSString
 *
 * @return       Void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

//              ****** Doing Syncronus Service call  ******
-(BOOL)getLoyaltyCardDownloadsDetails:(NSString *)requestString{
    
    BOOL status = false;

    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_LOYALTY_CARD_SERVICE];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        if (data.length > 0 && connectionError == nil)
        {
            NSError * err;
            
            NSDictionary * responseDic  = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:kNilOptions
                                                                            error:&err];
            
            if (responseDic.count) {
                
                if( ([responseDic.allKeys containsObject:RESPONSE_HEADER] && [[responseDic valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (responseDic == nil)){
                    
                    status = [self.loyaltyCardServcDelegate getLoyaltyCardDownloadDetailsErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                }
                else if ([[[responseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                    
                    status = [self.loyaltyCardServcDelegate getLoyaltyCardDownloadDetailsSuccessResponse:responseDic];
                }
                else {
                    status = [self.loyaltyCardServcDelegate getLoyaltyCardDownloadDetailsErrorResponse:[[responseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                }
            }
            else {
                status = [self.loyaltyCardServcDelegate getLoyaltyCardDownloadDetailsErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
            }
        }
        else {
            status = [self.loyaltyCardServcDelegate getLoyaltyCardDownloadDetailsErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
        }
    }
    @catch (NSException *exception) {
        status = [self.loyaltyCardServcDelegate getLoyaltyCardDownloadDetailsErrorResponse:exception.description];
        
    }
    @finally {
        
        return status;
    }
}



/**
 * @description  This method is used to issue loyalty card to customer ....
 * @date         10/05/2019....
 * @method       issueLoyaltyCardToCustomer:--
 * @author       Roja
 * @param
 * @param        NSString
 *
 * @return       Void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

//              ****** Doing Syncronus Service call  ******
-(BOOL)issueLoyaltyCardToCustomer:(NSString *)requestString{
    
    BOOL savedStatus = false;
    @try {
        
        NSString * serviceUrl = [WebServiceUtility getURLFor:ISSUE_LOYALTY_CARD];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL * url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  * request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                              timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
        
        request.HTTPBody = [requestString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        if (data.length > 0 && connectionError == nil)
        {
            NSError *err;
            NSDictionary *JSON  = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
            
            if( ([JSON.allKeys containsObject:RESPONSE_HEADER] && [[JSON valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (JSON == nil)){
                
                savedStatus = [self.loyaltyCardServcDelegate issueLoyaltyCardToCustomerErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
            }
            else if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                
                savedStatus = [self.loyaltyCardServcDelegate issueLoyaltyCardToCustomerSuccessResponse:JSON];
            }
            else {
                savedStatus = [self.loyaltyCardServcDelegate issueLoyaltyCardToCustomerErrorResponse:[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
            }
        }
        else {
            savedStatus =[self.loyaltyCardServcDelegate issueLoyaltyCardToCustomerErrorResponse:connectionError.localizedDescription];
        }
    }
    @catch (NSException *exception) {
        
        savedStatus = [self.loyaltyCardServcDelegate issueLoyaltyCardToCustomerErrorResponse:exception.description];
    }
    @finally{
        
        return savedStatus;
    }
}





/**
 * @description  In this method we get all gift coupons tables url's
 * @date         21/05/2019....
 * @method       getGiftCouponsDownloadsDetails:--
 * @author       Roja
 * @param
 * @param        NSString
 *
 * @return       Void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

//              ****** Doing Syncronus Service call  ******
-(BOOL)getGiftCouponsDownloadsDetails:(NSString *)requestString{
    
    BOOL status = false;
    
    @try {
       
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_GIFT_COUPONS_SERVICE];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        if (data.length > 0 && connectionError == nil)
        {
            NSError * err;
            
            NSDictionary * responseDic  = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:kNilOptions
                                                                            error:&err];
            
            if (responseDic.count) {
                
                if( ([responseDic.allKeys containsObject:RESPONSE_HEADER] && [[responseDic valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (responseDic == nil)){
                    
                    status = [self.giftCouponServcDelegate getGiftCouponsDownloadDetailsErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                }
                else if ([[[responseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                    
                    status = [self.giftCouponServcDelegate getGiftCouponsDownloadDetailsSuccessResponse:responseDic];
                }
                else {
                    status = [self.giftCouponServcDelegate getGiftCouponsDownloadDetailsErrorResponse:[[responseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                }
            }
            else {
                status = [self.giftCouponServcDelegate getGiftCouponsDownloadDetailsErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
            }
        }
        else {
            status = [self.giftCouponServcDelegate getGiftCouponsDownloadDetailsErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
        }
    }
    @catch (NSException *exception) {
        
        status = [self.giftCouponServcDelegate getGiftCouponsDownloadDetailsErrorResponse:exception.description];
    }
    @finally {
        return status;
    }
}



/**
 * @description
 * @date         27/05/2019....
 * @method       getVoucherDownloadsDetails:--
 * @author       Roja
 * @param
 * @param        NSString
 *
 * @return       Void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */
//              ****** Doing Syncronus Service call  ******

-(BOOL)getVoucherDownloadsDetails:(NSString *)requestString{
    
    BOOL status = false;
    
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_VOUCHER_SERVICE];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        if (data.length > 0 && connectionError == nil)
        {
            NSError * err;
            
            NSDictionary * responseDic  = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:kNilOptions
                                                                            error:&err];
            
            if (responseDic.count) {
                
                if( ([responseDic.allKeys containsObject:RESPONSE_HEADER] && [[responseDic valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (responseDic == nil)){
                    
                    status = [self.voucherServiceDelegate getVoucherDownloadDetailsErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                }
                else if ([[[responseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                    
                    status = [self.voucherServiceDelegate getVoucherDownloadDetailsSuccessResponse:responseDic];
                }
                else {
                    status = [self.voucherServiceDelegate getVoucherDownloadDetailsErrorResponse:[[responseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                }
            }
            else {
                status = [self.voucherServiceDelegate getVoucherDownloadDetailsErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
            }
        }
        else {
            status = [self.voucherServiceDelegate getVoucherDownloadDetailsErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
        }
    }
    @catch (NSException *exception) {
        
        status = [self.voucherServiceDelegate getVoucherDownloadDetailsErrorResponse:exception.description];
    }
    @finally {
        return status;
    }
}


/**
 * @description
 * @date         16/06/2019....
 * @method       getAvailableGiftCouponDetails:--
 * @author       Roja
 * @param
 * @param        NSString
 *
 * @return       Void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */
//              ****** Doing Syncronus Service call  ******
-(void)getAvailableGiftCouponDetails:(NSString *)requestString {
    
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_GIFT_COUPONS_MASTER];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        if (data.length > 0 && connectionError == nil)
        {
            NSError * err;
            
            NSDictionary * menuDetailsResponseDic  = [NSJSONSerialization JSONObjectWithData:data
                                                                                     options:kNilOptions
                                                                                       error:&err];
            
            if (menuDetailsResponseDic.count) {
                
                if( ([menuDetailsResponseDic.allKeys containsObject:RESPONSE_HEADER] && [[menuDetailsResponseDic valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (menuDetailsResponseDic == nil)){
                    
                    [self.giftCouponServicesDelegate getGiftCouponDetailsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                }
                else if ([[[menuDetailsResponseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                    
                    [self.giftCouponServicesDelegate getGiftCouponDetailsSuccessReponse:menuDetailsResponseDic];
                }
                else {
                    NSString * responseMsg = [[menuDetailsResponseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE];
                    [self.giftCouponServicesDelegate getGiftCouponDetailsErrorResponse:responseMsg];
                }
            }
            else {
                [self.giftCouponServicesDelegate getGiftCouponDetailsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
            }
        }
        else {
            [self.giftCouponServicesDelegate getGiftCouponDetailsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
        }
        
    }
    @catch (NSException *exception) {
        
        [self.giftCouponServicesDelegate getGiftCouponDetailsErrorResponse:exception.description];
    }
    @finally {
        
    }
}

/**
 * @description
 * @date         26/07/2019....
 * @method       getEmployeeDetails:--
 * @author       sai prashanth
 * @param
 * @param        NSString
 *
 * @return       Void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */
//Added by Sai on 26/07/2019

//              ****** Doing Syncronus Service call  ******
-(void)getEmployeeDetails:(NSString *)requestString {
    
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_EMPLOYEE_DETAILS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        if (data.length > 0 && connectionError == nil)
        {
            NSError * err;
            
            NSDictionary * menuDetailsResponseDic  = [NSJSONSerialization JSONObjectWithData:data
                                                                                     options:kNilOptions
                                                                                       error:&err];
            
            if (menuDetailsResponseDic.count) {
                
                if( ([menuDetailsResponseDic.allKeys containsObject:RESPONSE_HEADER] && [[menuDetailsResponseDic valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (menuDetailsResponseDic == nil)){
                    
                    [self.employeeServiceDelegate getEmployeeDetailsFailure:NSLocalizedString(@"unable_to_process_your_request", nil)];
                }
                else if ([[[menuDetailsResponseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                    
                    [self.employeeServiceDelegate getEmployeeDetailsSucess:menuDetailsResponseDic];
                }
                else {
                    NSString * responseMsg = [[menuDetailsResponseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE];
                    [self.employeeServiceDelegate getEmployeeDetailsFailure:responseMsg];
                }
            }
            else {
                [self.employeeServiceDelegate getEmployeeDetailsFailure:NSLocalizedString(@"unable_to_process_your_request", nil)];
            }
        }
        else {
            [self.employeeServiceDelegate getEmployeeDetailsFailure:NSLocalizedString(@"unable_to_process_your_request", nil)];
        }
        
    }
    @catch (NSException *exception) {
        
        [self.employeeServiceDelegate getEmployeeDetailsFailure:exception.description];
    }
    @finally {
        
    }
}



/**
 * @description  Here we are calling customerLedgerServices to get customer wallet details
 * @date         29/07/2019....
 * @method       getEmployeeDetails:--
 * @author       Roja
 * @param
 * @param        NSString
 *
 * @return       Void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)getCustomerWalletBalanceDetails:(NSString *)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_LEDGER_BALANCE];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod: @"GET"];
    
    @try {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 
                 if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                     
                     [self.customerLedgerService getCustomerWalletBalanceErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.customerLedgerService getCustomerWalletBalanceDetailsSuccessResponse:response];
                 }
                 else {
                     [self.customerLedgerService getCustomerWalletBalanceErrorResponse:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.customerLedgerService getCustomerWalletBalanceErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.customerLedgerService getCustomerWalletBalanceErrorResponse:exception.description];
    }
}


/**
 * @description  Here we are calling customerLedgerServices to create customer wallet...
 * @date         29/07/2019....
 * @method       createOrUpdateCustomerWalletServices--
 * @author       Roja
 * @param
 * @param        NSString
 *
 * @return       Void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)createOrUpdateCustomerWalletServices:(NSString *)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:CREATE_WALLET_TRANSACTION];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                         timeoutInterval:60.0];
    
    [request setHTTPMethod: @"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld", [[serviceUrl dataUsingEncoding:NSUTF8StringEncoding] length]] forHTTPHeaderField:@"Content-Length"];
    
    NSMutableDictionary * reqDic = [[NSJSONSerialization JSONObjectWithData:[requestString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL] mutableCopy];
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
    
    request.HTTPBody = jsonData;
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError) {
                               
                               if (data.length > 0 && connectionError == nil) {
                                   
                                   NSDictionary * responceDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                                   
                                   if(([[responceDic allKeys] containsObject:RESPONSE_HEADER] && [[responceDic valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (responceDic == nil)){
                                       
                                       [self.customerLedgerService createCustomerWalletErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                                   }
                                   else  if ([[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]== 0) {
                                       
                                       [self.customerLedgerService createCustomerWalletSuccessResponse:responceDic];
                                   }
                                   else {
                                       
                                       [self.customerLedgerService createCustomerWalletErrorResponse:[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                                   }
                               }
                               else {
                                   [self.customerLedgerService createCustomerWalletErrorResponse:connectionError.localizedDescription];
                               }
                           }];
}




// Added by roja on 17/10/2019....
// Start of converting SOAP call's to REST

-(void)authenticateUserForLogIn:(NSString *)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:AUTHENTICATE_USER];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                         timeoutInterval:60.0];
    
    [request setHTTPMethod: @"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld", [[serviceUrl dataUsingEncoding:NSUTF8StringEncoding] length]] forHTTPHeaderField:@"Content-Length"];
    
    NSMutableDictionary * reqDic = [[NSJSONSerialization JSONObjectWithData:[requestString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL] mutableCopy];
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
    
    request.HTTPBody = jsonData;
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError) {
                               
                               if (data.length > 0 && connectionError == nil) {
                                   
                                   NSDictionary * responceDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                                   
                                   if(([[responceDic allKeys] containsObject:RESPONSE_HEADER] && [[responceDic valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (responceDic == nil)){
                                       
                                       [self.memberServiceDelegate authenticateUserErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                                   }
                                   else  if ([[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]== 0) {
                                       
                                       [self.memberServiceDelegate authenticateUserSuccessResponse:responceDic];
                                   }
                                   else {
                                       
                                       [self.memberServiceDelegate authenticateUserErrorResponse:[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                                   }
                               }
                               else {
                                   [self.memberServiceDelegate authenticateUserErrorResponse:connectionError.localizedDescription];
                               }
                           }];
}

// added by roja on 17/10/2019...

-(void)getAppSettings:(NSString *)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_APP_SETTINGS];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod: @"GET"];
    
    @try {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 
                 if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                     
                     [self.appSettingServicesDelegate getAppSettingsErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.appSettingServicesDelegate getAppSettingsSuccessResponse:response];
                 }
                 else {
                     [self.appSettingServicesDelegate getAppSettingsErrorResponse:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.appSettingServicesDelegate getAppSettingsErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.appSettingServicesDelegate getAppSettingsErrorResponse:exception.description];
    }
}


// added by roja on 17/10/2019...

-(void)changePassword:(NSString *)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:CHANGE_PASSWORD];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [request setHTTPMethod: @"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld", [[serviceUrl dataUsingEncoding:NSUTF8StringEncoding] length]] forHTTPHeaderField:@"Content-Length"];
    
    NSMutableDictionary * reqDic = [[NSJSONSerialization JSONObjectWithData:[requestString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL] mutableCopy];
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
    
    request.HTTPBody = jsonData;
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError) {
                               
                               if (data.length > 0 && connectionError == nil) {
                                   
                                   NSDictionary * responceDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                                   
                                   if(([[responceDic allKeys] containsObject:RESPONSE_HEADER] && [[responceDic valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (responceDic == nil)){
                                       
                                       [self.memberServiceDelegate changePasswordErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                                   }
                                   else  if ([[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]== 0) {
                                       
                                       [self.memberServiceDelegate changePasswordSuccessResponse:responceDic];
                                   }
                                   else {
                                       
                                       [self.memberServiceDelegate changePasswordErrorResponse:[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                                   }
                               }
                               else {
                                   [self.memberServiceDelegate changePasswordErrorResponse:connectionError.localizedDescription];
                               }
                           }];
}

// added by roja on 17/10/2019...
-(void)userRegistration:(NSString *)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:USER_REGISTRATION];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [request setHTTPMethod: @"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld", [[serviceUrl dataUsingEncoding:NSUTF8StringEncoding] length]] forHTTPHeaderField:@"Content-Length"];
    
    NSMutableDictionary * reqDic = [[NSJSONSerialization JSONObjectWithData:[requestString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL] mutableCopy];
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
    
    request.HTTPBody = jsonData;
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError) {
                               
                               if (data.length > 0 && connectionError == nil) {
                                   
                                   NSDictionary * responceDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                                   
                                   if(([[responceDic allKeys] containsObject:RESPONSE_HEADER] && [[responceDic valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (responceDic == nil)){
                                       
                                       [self.memberServiceDelegate userRegistrationErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                                   }
                                   else  if ([[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]== 0) {
                                       
                                       [self.memberServiceDelegate userRegistrationSuccessResponse:responceDic];
                                   }
                                   else {
                                       
                                       [self.memberServiceDelegate userRegistrationErrorResponse:[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                                   }
                               }
                               else {
                                   [self.memberServiceDelegate userRegistrationErrorResponse:connectionError.localizedDescription];
                               }
                           }];
}

// added by roja on 17/10/2019...
-(void)getStores:(NSString*)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_STORES];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod: @"GET"];
    
    @try {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 
                 if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                     
                     [self.storeServiceDelegate getStoreErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.storeServiceDelegate getStoresSuccessResponse:response];
                 }
                 else {
                     [self.storeServiceDelegate getStoreErrorResponse:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.storeServiceDelegate getStoreErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.storeServiceDelegate getStoreErrorResponse:exception.description];
    }
}


// added by roja on 17/10/2019...
-(void)generateLoginOTP:(NSString *)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:GENERATE_OTP];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [request setHTTPMethod: @"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld", [[serviceUrl dataUsingEncoding:NSUTF8StringEncoding] length]] forHTTPHeaderField:@"Content-Length"];
    
    NSMutableDictionary * reqDic = [[NSJSONSerialization JSONObjectWithData:[requestString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL] mutableCopy];
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
    
    request.HTTPBody = jsonData;
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError) {
                               
                               if (data.length > 0 && connectionError == nil) {
                                   
                                   NSDictionary * responceDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                                   
                                   if(([[responceDic allKeys] containsObject:RESPONSE_HEADER] && [[responceDic valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (responceDic == nil)){
                                       
                                       [self.loginServiceDelegate generateOTPErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                                   }
                                   else  if ([[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]== 0) {
                                       
                                       [self.loginServiceDelegate generateOTPSuccessResponse:responceDic];
                                   }
                                   else {
                                       
                                       [self.loginServiceDelegate generateOTPErrorResponse:[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                                   }
                               }
                               else {
                                   [self.loginServiceDelegate  generateOTPErrorResponse:connectionError.localizedDescription];
                               }
                           }];
}



// added by roja on 17/10/2019...
-(void)validateForLoginOTP:(NSString *)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:VALIDATE_OTP];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [request setHTTPMethod: @"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld", [[serviceUrl dataUsingEncoding:NSUTF8StringEncoding] length]] forHTTPHeaderField:@"Content-Length"];
    
    NSMutableDictionary * reqDic = [[NSJSONSerialization JSONObjectWithData:[requestString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL] mutableCopy];
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
    
    request.HTTPBody = jsonData;
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError) {
                               
                               if (data.length > 0 && connectionError == nil) {
                                   
                                   NSDictionary * responceDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                                   
                                   if(([[responceDic allKeys] containsObject:RESPONSE_HEADER] && [[responceDic valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (responceDic == nil)){
                                       
                                       [self.loginServiceDelegate validateOTPErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                                   }
                                   else  if ([[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]== 0) {
                                       
                                       [self.loginServiceDelegate validateOTPSuccessResponse:responceDic];
                                   }
                                   else {
                                       
                                       [self.loginServiceDelegate validateOTPErrorResponse:[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                                   }
                               }
                               else {
                                   [self.loginServiceDelegate validateOTPErrorResponse:connectionError.localizedDescription];
                               }
                           }];
}


// added by roja on 17/10/2019...
-(void)resetPassword:(NSString *)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:RESET_PASSWORD];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [request setHTTPMethod: @"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld", [[serviceUrl dataUsingEncoding:NSUTF8StringEncoding] length]] forHTTPHeaderField:@"Content-Length"];
    
    NSMutableDictionary * reqDic = [[NSJSONSerialization JSONObjectWithData:[requestString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL] mutableCopy];
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
    
    request.HTTPBody = jsonData;
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError) {
                               
                               if (data.length > 0 && connectionError == nil) {
                                   
                                   NSDictionary * responceDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                                   
                                   if(([[responceDic allKeys] containsObject:RESPONSE_HEADER] && [[responceDic valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (responceDic == nil)){
                                       
                                       [self.loginServiceDelegate resetPasswordErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                                   }
                                   else  if ([[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]== 0) {
                                       
                                       [self.loginServiceDelegate resetPasswordSuccessResponse:responceDic];
                                   }
                                   else {
                                       
                                       [self.loginServiceDelegate resetPasswordErrorResponse:[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                                   }
                               }
                               else {
                                   [self.loginServiceDelegate resetPasswordErrorResponse:connectionError.localizedDescription];
                               }
                           }];
}


// added by roja on 17/10/2019...
-(void)createCustomer:(NSString *)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:CREATE_CUSTOMER];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [request setHTTPMethod: @"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld", [[serviceUrl dataUsingEncoding:NSUTF8StringEncoding] length]] forHTTPHeaderField:@"Content-Length"];
    
    NSMutableDictionary * reqDic = [[NSJSONSerialization JSONObjectWithData:[requestString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL] mutableCopy];
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
    
    request.HTTPBody = jsonData;
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError) {
                               
                               if (data.length > 0 && connectionError == nil) {
                                   
                                   NSDictionary * responceDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                                   
                                   if(([[responceDic allKeys] containsObject:RESPONSE_HEADER] && [[responceDic valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (responceDic == nil)){
                                       
                                       [self.customerServiceDelegate createCustomerErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                                   }
                                   else  if ([[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]== 0) {
                                       
                                       [self.customerServiceDelegate createCustomerSuccessResponse:responceDic];
                                   }
                                   else {
                                       
                                       [self.customerServiceDelegate createCustomerErrorResponse:[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                                   }
                               }
                               else {
                                   [self.customerServiceDelegate createCustomerErrorResponse:connectionError.localizedDescription];
                               }
                           }];
}

// added by roja on 17/10/2019...
// Here, below method is taken as synchrously... which is required in some places..
//-(void)updateCustomerDetailsSynchronously:(NSString *)requestString {
//
//    @try {
//        NSString *serviceUrl = [WebServiceUtility getURLFor:UPDATE_CUSTOMER_DETAILS];
//        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
//        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
//
//        NSURL *url = [NSURL URLWithString:serviceUrl];
//        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
//                                                             timeoutInterval:60.0];
//        request.HTTPMethod = @"GET";
//
//        NSError *connectionError=nil;
//        NSURLResponse *response=nil;
//
//        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
//
//        {
//            if (data.length > 0 && connectionError == nil)
//            {
//                NSError * err;
//                NSDictionary * updateCustomerDic  = [NSJSONSerialization JSONObjectWithData:data
//                                                                                     options:0
//                                                                                       error:&err];
//                if (updateCustomerDic.count) {
//
//                    if( ([updateCustomerDic.allKeys containsObject:RESPONSE_HEADER] && [[updateCustomerDic valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (updateCustomerDic == nil)){
//
//                        [self.customerServiceDelegate updateCustomerDetailsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
//                    }
//                    else if ([[[updateCustomerDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
//
//                        [self.customerServiceDelegate updateCustomerDetailsSuccessResponse:updateCustomerDic];
//                    }
//                    else {
//                        [self.customerServiceDelegate updateCustomerDetailsErrorResponse:[[updateCustomerDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
//                    }
//                }
//                else {
//                    [self.customerServiceDelegate updateCustomerDetailsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
//                }
//            }
//            else {
//
//                [self.customerServiceDelegate updateCustomerDetailsErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
//            }
//        }
//    }
//    @catch (NSException *exception) {
//        [self.customerServiceDelegate updateCustomerDetailsErrorResponse:exception.description];
//
//    }
//}

// added by roja on 17/10/2019...
-(void)getStockProcurementReceipt:(NSString *)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_STOCK_PROCUREMENT_RECEIPT];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod: @"GET"];
    
    @try {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 
                 if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                     
                     [self.stockReceiptDelegate getStockProcurementReceiptErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.stockReceiptDelegate getStockProcurementReceiptSuccessResponse:response];
                 }
                 else {
                     [self.stockReceiptDelegate getStockProcurementReceiptErrorResponse:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.stockReceiptDelegate getStockProcurementReceiptErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.stockReceiptDelegate getStockProcurementReceiptErrorResponse:exception.description];
    }
}



// added by roja on 17/10/2019...
-(void)getStockProcurementReceiptsCall:(NSString *)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_STOCK_PROCUREMENT_RECEIPTS];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod: @"GET"];
    
    @try {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 
                 if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                     
                     [self.stockReceiptDelegate getStockProcurementReceiptsErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.stockReceiptDelegate getStockProcurementReceiptsSuccessResponse:response];
                 }
                 else {
                     [self.stockReceiptDelegate getStockProcurementReceiptsErrorResponse:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.stockReceiptDelegate getStockProcurementReceiptsErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.stockReceiptDelegate getStockProcurementReceiptsErrorResponse:exception.description];
    }
}

// added by roja on 17/10/2019...
-(void)getStockProcurementReceiptIDS:(NSString *)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_STOCK_PROCUREMENT_RECEIPT_IDS];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod: @"GET"];
    
    @try {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 
                 if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                     
                     [self.stockReceiptDelegate getStockProcurementReceiptIDSErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.stockReceiptDelegate getStockProcurementReceiptIDSSuccessResponse:response];
                 }
                 else {
                     [self.stockReceiptDelegate getStockProcurementReceiptIDSErrorResponse:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.stockReceiptDelegate getStockProcurementReceiptIDSErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.stockReceiptDelegate getStockProcurementReceiptIDSErrorResponse:exception.description];
    }
}


// added by roja on 17/10/2019...
-(void)createNewStockProcurementReceipt:(NSString *)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:CREATE_NEW_STOCK_PROCUREMENT_RECEIPT];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [request setHTTPMethod: @"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld", [[serviceUrl dataUsingEncoding:NSUTF8StringEncoding] length]] forHTTPHeaderField:@"Content-Length"];
    
    NSMutableDictionary * reqDic = [[NSJSONSerialization JSONObjectWithData:[requestString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL] mutableCopy];
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
    
    request.HTTPBody = jsonData;
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError) {
                               
                               if (data.length > 0 && connectionError == nil) {
                                   
                                   NSDictionary * responceDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                                   
                                   if(([[responceDic allKeys] containsObject:RESPONSE_HEADER] && [[responceDic valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (responceDic == nil)){
                                       
                                       [self.stockReceiptDelegate createNewStockProcurementReceiptErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                                   }
                                   else  if ([[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]== 0) {
                                       
                                       [self.stockReceiptDelegate createNewStockProcurementReceiptSuccessResponse:responceDic];
                                   }
                                   else {
                                       
                                       [self.stockReceiptDelegate createNewStockProcurementReceiptErrorResponse:[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                                   }
                               }
                               else {
                                   [self.stockReceiptDelegate createNewStockProcurementReceiptErrorResponse:connectionError.localizedDescription];
                               }
                           }];
}


// added by roja on 17/10/2019...
-(void)getLoyaltycardDetails:(NSString *)requestString{

    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_ISSUED_LOYALTY_CARD];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod: @"GET"];
    
    @try {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 
                 if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                     
                     [self.loyaltycardServicesDelegate getLoyaltycardDetailsErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.loyaltycardServicesDelegate getLoyaltycardDetailsSuccessReponse:response];
                 }
                 else {
                     [self.loyaltycardServicesDelegate getLoyaltycardDetailsErrorResponse:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.loyaltycardServicesDelegate getLoyaltycardDetailsErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.loyaltycardServicesDelegate getLoyaltycardDetailsErrorResponse:exception.description];
    }
}


// added by roja on 17/10/2019...
-(void)issueLoyaltyCard:(NSString *)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:ISSUE_LOYALTY_CARD];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [request setHTTPMethod: @"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld", [[serviceUrl dataUsingEncoding:NSUTF8StringEncoding] length]] forHTTPHeaderField:@"Content-Length"];
    
    NSMutableDictionary * reqDic = [[NSJSONSerialization JSONObjectWithData:[requestString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL] mutableCopy];
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
    
    request.HTTPBody = jsonData;
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError) {
                               
                               if (data.length > 0 && connectionError == nil) {
                                   
                                   NSDictionary * responceDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                                   
                                   if(([[responceDic allKeys] containsObject:RESPONSE_HEADER] && [[responceDic valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (responceDic == nil)){
                                       
                                       [self.loyaltycardServicesDelegate issueLoyaltyCardErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                                   }
                                   else  if ([[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]== 0) {
                                       
                                       [self.loyaltycardServicesDelegate issueLoyaltyCardSuccessReponse:responceDic];
                                   }
                                   else {
                                       
                                       [self.loyaltycardServicesDelegate issueLoyaltyCardErrorResponse:[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                                   }
                               }
                               else {
                                   [self.loyaltycardServicesDelegate issueLoyaltyCardErrorResponse:connectionError.localizedDescription];
                               }
                           }];
}



// added by roja on 17/10/2019...
-(void)getAvailableLoyaltyPrograms:(NSString *)requestString{
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_AVAILABLE_LOYALTY_PROGRAMS];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod: @"GET"];
    
    @try {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 
                 if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                     
                     [self.loyaltycardServicesDelegate getAvailableLoyaltyProgramsErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.loyaltycardServicesDelegate getAvailableLoyaltyProgramsSuccessReponse:response];
                 }
                 else {
                     [self.loyaltycardServicesDelegate getAvailableLoyaltyProgramsErrorResponse:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.loyaltycardServicesDelegate getAvailableLoyaltyProgramsErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.loyaltycardServicesDelegate getAvailableLoyaltyProgramsErrorResponse:exception.description];
    }
}


// added by roja on 17/10/2019...
-(void)updateIssuedLoyaltyCard:(NSString *)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:UPDATE_ISSUED_LOYALTY_CARD];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [request setHTTPMethod: @"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld", [[serviceUrl dataUsingEncoding:NSUTF8StringEncoding] length]] forHTTPHeaderField:@"Content-Length"];
    
    NSMutableDictionary * reqDic = [[NSJSONSerialization JSONObjectWithData:[requestString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL] mutableCopy];
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
    
    request.HTTPBody = jsonData;
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError) {
                               
                               if (data.length > 0 && connectionError == nil) {
                                   
                                   NSDictionary * responceDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                                   
                                   if(([[responceDic allKeys] containsObject:RESPONSE_HEADER] && [[responceDic valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (responceDic == nil)){
                                       
                                       [self.loyaltycardServicesDelegate updateIssuedLoyaltyCardErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                                   }
                                   else  if ([[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]== 0) {
                                       
                                       [self.loyaltycardServicesDelegate updateIssuedLoyaltyCardSuccessReponse:responceDic];
                                   }
                                   else {
                                       
                                       [self.loyaltycardServicesDelegate updateIssuedLoyaltyCardErrorResponse:[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                                   }
                               }
                               else {
                                   [self.loyaltycardServicesDelegate updateIssuedLoyaltyCardErrorResponse:connectionError.localizedDescription];
                               }
                           }];
}

// added by Roja on 17/10/2019….
-(BOOL)getEmployeeMaster:(NSString *)requestParam{
    
    BOOL status = false;
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_EMPLOYEE_DETAILS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestParam];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        if (data.length > 0 && connectionError == nil)
        {
            NSError * err;
            
            NSDictionary * responseDic  = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:kNilOptions
                                                                            error:&err];
            
            if (responseDic.count) {
                
                if( ([responseDic.allKeys containsObject:RESPONSE_HEADER] && [[responseDic valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (responseDic == nil)){
                    
                    status = [self.employeeServiceDelegate getEmployeeErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                }
                else if ([[[responseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                    
                    status = [self.employeeServiceDelegate getEmployeeDetailsSucessResponse:responseDic];
                }
                else {
                    status = [self.employeeServiceDelegate getEmployeeErrorResponse:[[responseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                }
            }
            else {
                status = [self.employeeServiceDelegate getEmployeeErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
            }
        }
        else {
            status = [self.employeeServiceDelegate getEmployeeErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
        }
    }
    @catch (NSException *exception) {
        
        status = [self.employeeServiceDelegate getEmployeeErrorResponse:exception.description];
    }
    @finally {
        return status;
    }
}


// added by roja on 17/10/2019...
-(void)createPurchaseOrder:(NSString *)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:CREATE_PURCHASE_ORDER];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [request setHTTPMethod: @"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld", [[serviceUrl dataUsingEncoding:NSUTF8StringEncoding] length]] forHTTPHeaderField:@"Content-Length"];
    
    NSMutableDictionary * reqDic = [[NSJSONSerialization JSONObjectWithData:[requestString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL] mutableCopy];
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
    
    request.HTTPBody = jsonData;
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError) {
                               
                               if (data.length > 0 && connectionError == nil) {
                                   
                                   NSDictionary * responceDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                                   
                                   if(([[responceDic allKeys] containsObject:RESPONSE_HEADER] && [[responceDic valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (responceDic == nil)){
                                       
                                       [self.purchaseOrderSvcDelegate createPurchaseOrderErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                                   }
                                   else  if ([[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]== 0) {
                                       
                                       [self.purchaseOrderSvcDelegate createPurchaseOrderSuccessResponse:responceDic];
                                   }
                                   else {
                                       
                                       [self.purchaseOrderSvcDelegate createPurchaseOrderErrorResponse:[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                                   }
                               }
                               else {
                                   [self.purchaseOrderSvcDelegate createPurchaseOrderErrorResponse:connectionError.localizedDescription];
                               }
                           }];
}



// added by roja on 17/10/2019...
-(void)getPurchaseOrders:(NSString *)requestString{
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_PURCHASE_ORDER];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod: @"GET"];
    
    @try {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 
                 if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                     
                     [self.purchaseOrderSvcDelegate getPurchaseOrdersErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.purchaseOrderSvcDelegate getPurchaseOrdersSuccessResponse:response];
                 }
                 else {
                     [self.purchaseOrderSvcDelegate getPurchaseOrdersErrorResponse:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.purchaseOrderSvcDelegate getPurchaseOrdersErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.purchaseOrderSvcDelegate getPurchaseOrdersErrorResponse:exception.description];
    }
}

// added by roja on 17/10/2019...
-(void)getPurchaseOrderDetailsInOutlet:(NSString *)requestString{
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_PURCHASE_ORDER_DETAILS_OUTLET];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod: @"GET"];
    
    @try {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 
                 if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                     
                     [self.purchaseOrderSvcDelegate getPurchaseOrderDetailsErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.purchaseOrderSvcDelegate getPurchaseOrderDetailsSuccessResponse:response];
                 }
                 else {
                     [self.purchaseOrderSvcDelegate getPurchaseOrderDetailsErrorResponse:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.purchaseOrderSvcDelegate getPurchaseOrderDetailsErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.purchaseOrderSvcDelegate getPurchaseOrderDetailsErrorResponse:exception.description];
    }
}



// added by roja on 17/10/2019...
-(void)updatePurchaseOrder:(NSString *)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:UPDATE_PURCHASE_ORDER];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [request setHTTPMethod: @"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld", [[serviceUrl dataUsingEncoding:NSUTF8StringEncoding] length]] forHTTPHeaderField:@"Content-Length"];
    
    NSMutableDictionary * reqDic = [[NSJSONSerialization JSONObjectWithData:[requestString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL] mutableCopy];
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
    
    request.HTTPBody = jsonData;
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError) {
                               
                               if (data.length > 0 && connectionError == nil) {
                                   
                                   NSDictionary * responceDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                                   
                                   if(([[responceDic allKeys] containsObject:RESPONSE_HEADER] && [[responceDic valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (responceDic == nil)){
                                       
                                       [self.purchaseOrderSvcDelegate updatePurchaseOrderErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                                   }
                                   else  if ([[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]== 0) {
                                       
                                       [self.purchaseOrderSvcDelegate updatePurchaseOrderSuccessResponse:responceDic];
                                   }
                                   else {
                                       
                                       [self.purchaseOrderSvcDelegate updatePurchaseOrderErrorResponse:[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                                   }
                               }
                               else {
                                   [self.purchaseOrderSvcDelegate updatePurchaseOrderErrorResponse:connectionError.localizedDescription];
                               }
                           }];
}

// added by roja on 17/10/2019...
-(void)getStoreLocation:(NSString *)requestString{
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_STORE_LOCATION];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod: @"GET"];
    
    @try {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 
                 if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                     
                     [self.storeStockVerificationDelegate getStoreLocationErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.storeStockVerificationDelegate getStoreLocationSuccessResponse:response];
                 }
                 else {
                     [self.storeStockVerificationDelegate getStoreLocationErrorResponse:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.storeStockVerificationDelegate getStoreLocationErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.storeStockVerificationDelegate getStoreLocationErrorResponse:exception.description];
    }
}

//
// added by roja on 17/10/2019...
-(void)getStoreUnit:(NSString *)requestString{
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_STORE_UNIT];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod: @"GET"];
    
    @try {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 
                 if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                     
                     [self.storeStockVerificationDelegate getStoreUnitErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.storeStockVerificationDelegate getStoreUnitSuccessResponse:response];
                 }
                 else {
                     [self.storeStockVerificationDelegate getStoreUnitErrorResponse:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.storeStockVerificationDelegate getStoreUnitErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.storeStockVerificationDelegate getStoreUnitErrorResponse:exception.description];
    }
}



// added by Roja on 17/10/2019….
-(void)getGiftVoucherDetails:(NSString *)requestString{
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_GIFT_VOUCHER_DETAILS];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod: @"GET"];
    
    @try {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 
                 if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                     
                     [self.giftVoucherServicesDelegate getGiftVoucherDetailsErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.giftVoucherServicesDelegate getGiftVoucherDetailsSuccessReponse:response];
                 }
                 else {
                     [self.giftVoucherServicesDelegate getGiftVoucherDetailsErrorResponse:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.giftVoucherServicesDelegate getGiftVoucherDetailsErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.giftVoucherServicesDelegate getGiftVoucherDetailsErrorResponse:exception.description];
    }
}



// added by roja on 17/10/2019...
-(void)updateSyncDownloadStatus:(NSString *)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:UPDATE_SYNC_DOWNLOAD_STATUS];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [request setHTTPMethod: @"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld", [[serviceUrl dataUsingEncoding:NSUTF8StringEncoding] length]] forHTTPHeaderField:@"Content-Length"];
    
    NSMutableDictionary * reqDic = [[NSJSONSerialization JSONObjectWithData:[requestString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL] mutableCopy];
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
    
    request.HTTPBody = jsonData;
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError) {
                               
                               if (data.length > 0 && connectionError == nil) {
                                   
                                   NSDictionary * responceDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                                   
                                   if(([[responceDic allKeys] containsObject:RESPONSE_HEADER] && [[responceDic valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (responceDic == nil)){
                                       
                                       [self.counterServiceDelegate updateSyncDownloadStatusErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                                   }
                                   else  if ([[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]== 0) {
                                       
                                       [self.counterServiceDelegate updateSyncDownloadStatusSuccessResponse:responceDic];
                                   }
                                   else {
                                       
                                       [self.counterServiceDelegate updateSyncDownloadStatusErrorResponse:[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                                   }
                               }
                               else {
                                   [self.counterServiceDelegate updateSyncDownloadStatusErrorResponse:connectionError.localizedDescription];
                               }
                           }];
}


// added by roja on 17/10/2019...
-(void)updateCounter:(NSString *)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:UPDATE_COUNTER];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [request setHTTPMethod: @"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld", [[serviceUrl dataUsingEncoding:NSUTF8StringEncoding] length]] forHTTPHeaderField:@"Content-Length"];
    
    NSMutableDictionary * reqDic = [[NSJSONSerialization JSONObjectWithData:[requestString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL] mutableCopy];
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
    
    request.HTTPBody = jsonData;
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError) {
                               
                               if (data.length > 0 && connectionError == nil) {
                                   
                                   NSDictionary * responceDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                                   
                                   if(([[responceDic allKeys] containsObject:RESPONSE_HEADER] && [[responceDic valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (responceDic == nil)){
                                       
                                       [self.counterServiceDelegate updateCounterErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                                   }
                                   else  if ([[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]== 0) {
                                       
                                       [self.counterServiceDelegate updateCounterSuccessResponse:responceDic];
                                   }
                                   else {
                                       
                                       [self.counterServiceDelegate updateCounterErrorResponse:[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                                   }
                               }
                               else {
                                   [self.counterServiceDelegate updateCounterErrorResponse:connectionError.localizedDescription];
                               }
                           }];
}



// added by Roja on 17/10/2019….
-(void)getCounters:(NSString *)requestString{
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_COUNTERS];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod: @"GET"];
    
    @try {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 
                 if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                     
                     [self.counterServiceDelegate getCountersErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.counterServiceDelegate getCountersSuccessResponse:response];
                 }
                 else {
                     [self.counterServiceDelegate getCountersErrorResponse:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.counterServiceDelegate getCountersErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.counterServiceDelegate getCountersErrorResponse:exception.description];
    }
}

// added by Roja on 17/10/2019….
-(BOOL)getStoreTaxesInDetailThroughSoapServiceCall:(NSString *)requestString{
    
    BOOL status = false;
    
    @try {
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_STORE_TAXATION];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        if (data.length > 0 && connectionError == nil)
        {
            NSError * err;
            
            NSDictionary * responseDic  = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:kNilOptions
                                                                            error:&err];
            
            if (responseDic.count) {
                
                if( ([responseDic.allKeys containsObject:RESPONSE_HEADER] && [[responseDic valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (responseDic == nil)){
                    
                    status = [self.storeTaxationDelegate getStoreTaxesInDeatailErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                }
                else if ([[[responseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                    
                    status = [self.storeTaxationDelegate getStoreTaxesInDetailSuccessResponse:responseDic];
                }
                else {
                    status = [self.storeTaxationDelegate getStoreTaxesInDeatailErrorResponse:[[responseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                }
            }
            else {
                status = [self.storeTaxationDelegate getStoreTaxesInDeatailErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
            }
        }
        else {
            status = [self.storeTaxationDelegate getStoreTaxesInDeatailErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
        }
    }
    @catch (NSException *exception) {
        
        status = [self.storeTaxationDelegate getStoreTaxesInDeatailErrorResponse:exception.description];
    }
    @finally {
        return status;
    }
}

// added by Roja on 17/10/2019….
-(void)getBrandList:(NSString *)requestStirng {

    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_BRAND];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestStirng];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod: @"GET"];
    
    @try {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 
                 if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                     
                     [self.outletMasterDelegate getBrandMasterErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.outletMasterDelegate getBrandMasterSuccessResponse:response];
                 }
                 else {
                     [self.outletMasterDelegate getBrandMasterErrorResponse:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.outletMasterDelegate getBrandMasterErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.outletMasterDelegate getBrandMasterErrorResponse:exception.description];
    }
}


// added by Roja on 17/10/2019….
-(void)getDepartmentList:(NSString *)requestStirng {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_DEPARTMENTS];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestStirng];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [request setHTTPMethod: @"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld", [[serviceUrl dataUsingEncoding:NSUTF8StringEncoding] length]] forHTTPHeaderField:@"Content-Length"];
    
    NSMutableDictionary * reqDic = [[NSJSONSerialization JSONObjectWithData:[requestStirng dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL] mutableCopy];
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
    
    request.HTTPBody = jsonData;
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError) {
                               
                               if (data.length > 0 && connectionError == nil) {
                                   
                                   NSDictionary * responceDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                                   
                                   if(([[responceDic allKeys] containsObject:RESPONSE_HEADER] && [[responceDic valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (responceDic == nil)){
                                       
                                       [self.outletMasterDelegate getDepartmentErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                                   }
                                   else  if ([[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]== 0) {
                                       
                                       [self.outletMasterDelegate getDepartmentSuccessResponse:responceDic];
                                   }
                                   else {
                                       
                                       [self.outletMasterDelegate getDepartmentErrorResponse:[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                                   }
                               }
                               else {
                                   [self.outletMasterDelegate getDepartmentErrorResponse:connectionError.localizedDescription];
                               }
                           }];
}

//
// added by Roja on 17/10/2019….
-(void)getSupplierDetailsData:(NSString *)requestString{
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_SUPPLIERS];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod: @"GET"];
    
    @try {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 
                 if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                     
                     [self.supplierServiceSvcDelegate getSuppliersErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.supplierServiceSvcDelegate getSuppliersSuccessResponse:response];
                 }
                 else {
                     [self.supplierServiceSvcDelegate getSuppliersErrorResponse:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.supplierServiceSvcDelegate getSuppliersErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.supplierServiceSvcDelegate getSuppliersErrorResponse:exception.description];
    }
}



// added by Roja on 17/10/2019….
-(void)getProductCategory:(NSString *)requestStirng {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_CATEGORIES];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestStirng];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod: @"GET"];
    
    @try {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 
                 if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                     
                     [self.outletMasterDelegate getCategoryErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.outletMasterDelegate getCategorySuccessResponse:response];
                 }
                 else {
                     [self.outletMasterDelegate getCategoryErrorResponse:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.outletMasterDelegate getCategoryErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.outletMasterDelegate getCategoryErrorResponse:exception.description];
    }
}


// added by Roja on 17/10/2019….
-(void)getAllLocationDetailsData:(NSString *)requestStirng {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_LOCATION];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestStirng];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [request setHTTPMethod: @"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld", [[serviceUrl dataUsingEncoding:NSUTF8StringEncoding] length]] forHTTPHeaderField:@"Content-Length"];
    
    NSMutableDictionary * reqDic = [[NSJSONSerialization JSONObjectWithData:[requestStirng dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL] mutableCopy];
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
    
    request.HTTPBody = jsonData;
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError) {
                               
                               if (data.length > 0 && connectionError == nil) {
                                   
                                   NSDictionary * responceDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                                   
                                   if(([[responceDic allKeys] containsObject:RESPONSE_HEADER] && [[responceDic valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (responceDic == nil)){
                                       
                                       [self.utilityMasterDelegate getLocationErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                                   }
                                   else  if ([[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]== 0) {
                                       
                                       [self.utilityMasterDelegate getLocationSuccessResponse:responceDic];
                                   }
                                   else {
                                       
                                       [self.utilityMasterDelegate getLocationErrorResponse:[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                                   }
                               }
                               else {
                                   [self.utilityMasterDelegate getLocationErrorResponse:connectionError.localizedDescription];
                               }
                           }];
}

// added by Roja on 17/10/2019….
-(BOOL)getProductCategories:(NSString *)requestString {
    
    BOOL status = false;
    
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_PRODUCT_CATEGORY];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        if (data.length > 0 && connectionError == nil)
        {
            NSError * err;
            
            NSDictionary * responseDic  = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:kNilOptions
                                                                            error:&err];
            
            if (responseDic.count) {
                
                if( ([responseDic.allKeys containsObject:RESPONSE_HEADER] && [[responseDic valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (responseDic == nil)){
                    
                    status = [self.utilityMasterDelegate getProductCategoriesErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                }
                else if ([[[responseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                    
                    status = [self.utilityMasterDelegate getProductCategoriesSuccessResponse:responseDic];
                }
                else {
                    status = [self.utilityMasterDelegate getProductCategoriesErrorResponse:[[responseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                }
            }
            else {
                status = [self.utilityMasterDelegate getProductCategoriesErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
            }
        }
        else {
            status = [self.utilityMasterDelegate getProductCategoriesErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
        }
    }
    @catch (NSException *exception) {
        
        status = [self.utilityMasterDelegate getProductCategoriesErrorResponse:exception.description];
    }
    @finally {
        return status;
    }
}

// added by Roja on 17/10/2019….
-(BOOL)getProductSubCategories:(NSString *)requestString {
    
    BOOL status = false;
    
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_PRODUCT_SUB_CATEGORY];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        if (data.length > 0 && connectionError == nil)
        {
            NSError * err;
            
            NSDictionary * responseDic  = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:kNilOptions
                                                                            error:&err];
            
            if (responseDic.count) {
                
                if( ([responseDic.allKeys containsObject:RESPONSE_HEADER] && [[responseDic valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (responseDic == nil)){
                    
                    status = [self.utilityMasterDelegate getProductSubCategoriesErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                }
                else if ([[[responseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                    
                    status = [self.utilityMasterDelegate getProductSubCategoriesSuccessResponse:responseDic];
                }
                else {
                    status = [self.utilityMasterDelegate getProductSubCategoriesErrorResponse:[[responseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                }
            }
            else {
                status = [self.utilityMasterDelegate getProductSubCategoriesErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
            }
        }
        else {
            status = [self.utilityMasterDelegate getProductSubCategoriesErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
        }
    }
    @catch (NSException *exception) {
        
        status = [self.utilityMasterDelegate getProductSubCategoriesErrorResponse:exception.description];
    }
    @finally {
        return status;
    }
}

//

// added by Roja on 17/10/2019….
-(BOOL)getTaxes:(NSString *)requestString {
    
    BOOL status = false;
    
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_TAXES];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        if (data.length > 0 && connectionError == nil)
        {
            NSError * err;
            
            NSDictionary * responseDic  = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:kNilOptions
                                                                            error:&err];
            
            if (responseDic.count) {
                
                if( ([responseDic.allKeys containsObject:RESPONSE_HEADER] && [[responseDic valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (responseDic == nil)){
                    
                    status = [self.utilityMasterDelegate getTaxesErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                }
                else if ([[[responseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                    
                    status = [self.utilityMasterDelegate getTaxesSuccessResponse:responseDic];
                }
                else {
                    status = [self.utilityMasterDelegate getTaxesErrorResponse:[[responseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                }
            }
            else {
                status = [self.utilityMasterDelegate getTaxesErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
            }
        }
        else {
            status = [self.utilityMasterDelegate getTaxesErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
        }
    }
    @catch (NSException *exception) {
        
        status = [self.utilityMasterDelegate getTaxesErrorResponse:exception.description];
    }
    @finally {
        return status;
    }
}


// added by Roja on 17/10/2019….
-(void)getZoneIdsRequest:(NSString *)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_ZONES];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod: @"GET"];
    
    @try {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 
                 if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                     
                     [self.zoneMasterDelegate getZonesErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.zoneMasterDelegate getZonesSuccessResponse:response];
                 }
                 else {
                     [self.zoneMasterDelegate getZonesErrorResponse:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.zoneMasterDelegate getZonesErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.zoneMasterDelegate getZonesErrorResponse:exception.description];
    }
}


// added by Roja on 17/10/2019….
-(void)getSalesReport:(NSString *)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_SALES_REPORTS];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod: @"GET"];
    
    @try {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 
                 if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                     
                     [self.salesServiceDelegate getSalesReportsErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.salesServiceDelegate getSalesReportsSuccessResponse:response];
                 }
                 else {
                     [self.salesServiceDelegate getSalesReportsErrorResponse:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.salesServiceDelegate getSalesReportsErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.salesServiceDelegate getSalesReportsErrorResponse:exception.description];
    }
}


// added by Roja on 17/10/2019….
-(void)getReturningItem:(NSString *)requestStirng {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_RETURNING_ITEM];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestStirng];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [request setHTTPMethod: @"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%ld", [[serviceUrl dataUsingEncoding:NSUTF8StringEncoding] length]] forHTTPHeaderField:@"Content-Length"];
    
    NSMutableDictionary * reqDic = [[NSJSONSerialization JSONObjectWithData:[requestStirng dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL] mutableCopy];
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
    
    request.HTTPBody = jsonData;
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError) {
                               
                               if (data.length > 0 && connectionError == nil) {
                                   
                                   NSDictionary * responceDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                                   
                                   if(([[responceDic allKeys] containsObject:RESPONSE_HEADER] && [[responceDic valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (responceDic == nil)){
                                       
                                       [self.salesServiceDelegate getReturningItemErrorResponse:NSLocalizedString(@"unable_to_process_your_request", nil)];
                                   }
                                   else  if ([[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]== 0) {
                                       
                                       [self.salesServiceDelegate getReturningItemSuccessResponse:responceDic];
                                   }
                                   else {
                                       
                                       [self.salesServiceDelegate getReturningItemErrorResponse:[[responceDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                                   }
                               }
                               else {
                                   [self.salesServiceDelegate getReturningItemErrorResponse:connectionError.localizedDescription];
                               }
                           }];
}


// added by Roja on 17/10/2019….
-(void)getBillingDetails:(NSString *)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_BILLING_DETAILS];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod: @"GET"];
    
    @try {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 
                 if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                     
                     [self.salesServiceDelegate getBillingDetailsErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.salesServiceDelegate getBillingDetailsSuccessResponse:response];
                 }
                 else {
                     [self.salesServiceDelegate getBillingDetailsErrorResponse:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.salesServiceDelegate getBillingDetailsErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.salesServiceDelegate getBillingDetailsErrorResponse:exception.description];
    }
}



// added by Roja on 17/10/2019….
-(void)getHourWiseReports:(NSString *)requestString{

    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_HOUR_WISE_REPORT];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];

    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod: @"GET"];

    @try {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];

                 if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){

                     [self.salesServiceDelegate getHourWiseReportErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {

                     [self.salesServiceDelegate getHourWiseReportsSuccessResponse:response];
                 }
                 else {
                     [self.salesServiceDelegate getHourWiseReportErrorResponse:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.salesServiceDelegate getHourWiseReportErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {

        [self.salesServiceDelegate getHourWiseReportErrorResponse:exception.description];
    }
}


// added by Roja on 17/10/2019….
-(void)getXZReports:(NSString *)requestString{
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_XZ_REPORTS];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod: @"GET"];
    
    @try {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 
                 if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                     
                     [self.salesServiceDelegate getXZReportErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.salesServiceDelegate getXZReportSuccessResponse:response];
                 }
                 else {
                     [self.salesServiceDelegate getXZReportErrorResponse:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.salesServiceDelegate getXZReportErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.salesServiceDelegate getXZReportErrorResponse:exception.description];
    }
}


// added by Roja on 17/10/2019….
//-(BOOL)getAllOffersWithDataThroughSoapSynchronousRequest:(NSString *)requestString{
-(BOOL)getAllOffersWithData:(NSString *)requestString{
    
    BOOL status = false;
    
    @try {
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_OFFER];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        
        NSError *connectionError=nil;
        NSURLResponse *response=nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
        
        if (data.length > 0 && connectionError == nil)
        {
            NSError * err;
            
            NSDictionary * responseDic  = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:kNilOptions
                                                                            error:&err];
            
            if (responseDic.count) {
                
                if( ([responseDic.allKeys containsObject:RESPONSE_HEADER] && [[responseDic valueForKey:RESPONSE_HEADER]  isKindOfClass: [NSNull class]]) || (responseDic == nil)){
                    
                    status = [self.getAllOffersDelegate getAllOffersErrorResponseAndReturnSaveStatus: NSLocalizedString(@"unable_to_process_your_request", nil)];
                }
                else if ([[[responseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                    
                    status = [self.getAllOffersDelegate getAllOffersSuccessResponseAndReturnSaveStatus:responseDic];
                }
                else {
                    status = [self.getAllOffersDelegate getAllOffersErrorResponseAndReturnSaveStatus:[[responseDic valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                }
            }
            else {
                status = [self.getAllOffersDelegate getAllOffersErrorResponseAndReturnSaveStatus: NSLocalizedString(@"unable_to_process_your_request", nil)];
            }
        }
        else {
            status = [self.getAllOffersDelegate getAllOffersErrorResponseAndReturnSaveStatus: NSLocalizedString(@"unable_to_process_your_request", nil)];
        }
    }
    @catch (NSException *exception) {
        
        status = [self.getAllOffersDelegate getAllOffersErrorResponseAndReturnSaveStatus:exception.description];
    }
    @finally {
        return status;
    }
}


// added by Roja on 17/10/2019….
-(void)getOffersDetails:(NSString *)requestString {
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_OFFER];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod: @"GET"];
    
    @try {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 
                 if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                     
                     [self.offerMasterDelegate getOffersErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.offerMasterDelegate getoffersSuccessResponse:response];
                 }
                 else {
                     [self.offerMasterDelegate getOffersErrorResponse:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.offerMasterDelegate getOffersErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.offerMasterDelegate getOffersErrorResponse:exception.description];
    }
}



// added by roja on 29/11/2019...
-(void)getLoyaltyCardsBySearch:(NSString *)requestString{
    
    NSString *serviceUrl = [WebServiceUtility getURLFor:GET_LOYALITY_CARD_BY_SEARCH_CRITERIA];
    serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,requestString];
    serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
    
    NSURL *url = [NSURL URLWithString:serviceUrl];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod: @"GET"];
    
    @try {
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 
                 if(([[response allKeys] containsObject:RESPONSE_HEADER] && [[response valueForKey:RESPONSE_HEADER] isKindOfClass: [NSNull class]]) || (response == nil)){
                     
                     [self.loyaltycardServicesDelegate getLoyaltycardBySearchCriteriaErrorResponse: NSLocalizedString(@"unable_to_process_your_request", nil)];
                 }
                 else if ([[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [self.loyaltycardServicesDelegate getLoyaltycardBySearchCriteriaSuccessReponse:response];
                 }
                 else {
                     [self.loyaltycardServicesDelegate getLoyaltycardBySearchCriteriaErrorResponse:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]];
                 }
             }
             else {
                 [self.loyaltycardServicesDelegate getLoyaltycardBySearchCriteriaErrorResponse:connectionError.localizedDescription];
             }
         }];
    }
    @catch (NSException *exception) {
        
        [self.loyaltycardServicesDelegate getLoyaltycardBySearchCriteriaErrorResponse:exception.description];
    }
}




//

@end
