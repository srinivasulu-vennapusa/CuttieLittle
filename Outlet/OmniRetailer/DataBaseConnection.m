//
//  DataBaseConnection.m
//  OmniRetailer
//
//  Created by Satya Siva Saradhi on 22/11/12.
//  Copyright 2012 __techolabssoftware.com__. All rights reserved.
//

#import "DataBaseConnection.h"


@implementation DataBaseConnection



+ (NSString *)connection:(NSString *)databaseName {
    
    
    // creating connection to local database ..
    
    @try {
        BOOL success;
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString *documentsDir = documentPaths[0];
        
        NSString* databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
        
        success = [fileManager fileExistsAtPath:databasePath];
        
        if(!success) {
            
            NSString *databasePathFromApp = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:databaseName];
            
            success = [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
            
        }
        
        if(success) {
            
            return databasePath;
        }

    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
    } @finally {
        
    }
    
    return NULL;
    
}


@end
