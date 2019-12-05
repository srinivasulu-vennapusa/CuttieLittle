//
//  IStarIoExtFunction.h
//  ObjectiveC SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL (^StarIoExtFunctionCompletionHandler)(uint8_t *buffer, int *length);

@interface IStarIoExtFunction : NSObject

@property (nonatomic, copy) StarIoExtFunctionCompletionHandler completionHandler;

- (NSData *)createCommands;

@end
