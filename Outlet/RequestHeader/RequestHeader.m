//
//  RequestHeader.m
//  MobiShopping
//
//  Created by MACPC on 4/27/15.
//  Copyright (c) 2015 MACPC. All rights reserved.
//

#import "RequestHeader.h"
#import "GDataXMLNode.h"
#import "Global.h"
#import "WebServiceConstants.h"

NSDictionary *requestHeader;

@implementation RequestHeader

+(NSDictionary *)getRequestHeader {
    
    @try {
        NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        NSArray *str = [time componentsSeparatedByString:@" "];
        NSString *date = [str[0] componentsSeparatedByString:@","][0];
        NSArray *headerKeys = @[ACCESS_KEY,CUSTOMER_ID,APPLICATION_NAME,USERNAME,CORRELATION_ID,DATE,kFirstName,kUserRole,kRequestChannel,kLocation,kDeviceId,kAppName,LOGIN_ID];
        
        if ([firstName isKindOfClass:[NSNull class]]) {
            
            firstName = @"";
        }
        
        if ([roleName isKindOfClass:[NSNull class]]) {
            
            roleName = @"";
        }
        
        if ([mail_ isKindOfClass:[NSNull class]]) {
            
            mail_ = @"";
        }
        
        NSArray *headerObjects = @[custID,custID,APPLICATION_NAME_VALUE,mail_,@"-",date,firstName,roleName,@"IOS-Outlet",presentLocation,deviceId,APPLICATION_NAME_VALUE,mail_];
        requestHeader = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    return requestHeader;
    
}


@end
