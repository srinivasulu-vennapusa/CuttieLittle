//
//  IStarIoExtFunction.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

#import "IStarIoExtFunction.h"

@implementation IStarIoExtFunction

- (id)init {
    self = [super init];
    
    if (!self){
        return nil;
    }
    
    _completionHandler = nil;
    
    return self;
}

- (NSData *)createCommands {
    return nil;
}

@end
