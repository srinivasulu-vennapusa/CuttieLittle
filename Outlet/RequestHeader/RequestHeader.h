//
//  RequestHeader.h
//  MobiShopping
//
//  Created by MACPC on 4/27/15.
//  Copyright (c) 2015 MACPC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestHeader : NSObject {
    
    NSString *custId;
    NSString *mailId;
    NSString *appName;
    
}
+(NSDictionary *)getRequestHeader ;
@end
