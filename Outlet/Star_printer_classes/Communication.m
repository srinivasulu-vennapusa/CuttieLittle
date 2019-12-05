//
//  Communication.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright (c) 2015年 Star Micronics. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Communication.h"

@implementation Communication

+ (BOOL)sendCommands:(NSData *)commands
                port:(SMPort *)port
   completionHandler:(SendCompletionHandler)completionHandler {
    BOOL result = NO;
    
    NSString *title   = @"";
    NSString *message = @"";
    
    uint32_t commandLength = (uint32_t) commands.length;
    
    unsigned char *commandsBytes = (unsigned char *) commands.bytes;
    
    @try {
        while (YES) {
            if (port == nil) {
                title = @"Fail to Open Port";
                break;
            }
            
            StarPrinterStatus_2 printerStatus;
            
            [port beginCheckedBlock:&printerStatus :2];
            
            if (printerStatus.offline == SM_TRUE) {
                title   = @"Printer Error";
                message = @"Printer is offline (BeginCheckedBlock)";
                break;
            }
            
            NSDate *startDate = [NSDate date];
            
            uint32_t total = 0;
            
            while (total < commandLength) {
                uint32_t written = [port writePort:commandsBytes :total :commandLength - total];
                
                total += written;
                
                if ([[NSDate date] timeIntervalSinceDate:startDate] >= 30.0) {     // 30000mS!!!
                    break;
                }
            }
            
            if (total < commandLength) {
                title   = @"Printer Error";
                message = @"Write port timed out";
                break;
            }
            
            port.endCheckedBlockTimeoutMillis = 30000;     // 30000mS!!!
            
            [port endCheckedBlock:&printerStatus :2];
            
            if (printerStatus.offline == SM_TRUE) {
                title   = @"Printer Error";
                message = @"Printer is offline (EndCheckedBlock)";
                break;
            }
            
            title   = @"Send Commands";
            message = @"Success";
            
            result = YES;
            break;
        }
    }
    @catch (PortException *exc) {
        title   = @"Printer Error";
        message = @"Write port timed out (PortException)";
    }
    
    if (completionHandler != nil) {
        completionHandler(result, title, message);
    }
    
    return result;
}

+ (BOOL)sendCommandsDoNotCheckCondition:(NSData *)commands
                                   port:(SMPort *)port
                      completionHandler:(SendCompletionHandler)completionHandler {
    BOOL result = NO;
    
    NSString *title   = @"";
    NSString *message = @"";
    
    uint32_t commandLength = (uint32_t) commands.length;
    
    unsigned char *commandsBytes = (unsigned char *) commands.bytes;
    
    @try {
        while (YES) {
            if (port == nil) {
                title = @"Fail to Open Port";
                break;
            }
            
            StarPrinterStatus_2 printerStatus;
            
            [port getParsedStatus:&printerStatus :2];
            
//          if (printerStatus.offline == SM_TRUE) {     // Do not check condition.
//              title   = @"Printer Error";
//              message = @"Printer is offline (GetParsedStatus)";
//              break;
//          }
            
            NSDate *startDate = [NSDate date];
            
            uint32_t total = 0;
            
            while (total < commandLength) {
                uint32_t written = [port writePort:commandsBytes :total :commandLength - total];
                
                total += written;
                
                if ([[NSDate date] timeIntervalSinceDate:startDate] >= 30.0) {     // 30000mS!!!
                    break;
                }
            }
            
            if (total < commandLength) {
                title   = @"Printer Error";
                message = @"Write port timed out";
                break;
            }
            
            [port getParsedStatus:&printerStatus :2];
            
//          if (printerStatus.offline == SM_TRUE) {     // Do not check condition.
//              title   = @"Printer Error";
//              message = @"Printer is offline (GetParsedStatus)";
//              break;
//          }
            
            title   = @"Send Commands";
            message = @"Success";
            
            result = YES;
            break;
        }
    }
    @catch (PortException *exc) {
        title   = @"Printer Error";
        message = @"Write port timed out (PortException)";
    }
    
    if (completionHandler != nil) {
        completionHandler(result, title, message);
    }
    
    return result;
}

+ (BOOL)sendFunctionDoNotCheckCondition:(IStarIoExtFunction *)function
                                   port:(SMPort *)port
                      completionHandler:(SendCompletionHandler)completionHandler {
    BOOL result = NO;
    
    NSString *title   = @"";
    NSString *message = @"";
    
    NSData *commands = [function createCommands];
    
    uint32_t commandLength = (uint32_t) commands.length;
    
    unsigned char *commandsBytes = (unsigned char *) commands.bytes;
    
    @try {
        while (YES) {
            if (port == nil) {
                title = @"Fail to Open Port";
                break;
            }
            
            StarPrinterStatus_2 printerStatus;
            
            [port getParsedStatus:&printerStatus :2];
            
//          if (printerStatus.offline == SM_TRUE) {     // Do not check condition.
//              title   = @"Printer Error";
//              message = @"Printer is offline (GetParsedStatus)";
//              break;
//          }
            
            NSDate *startDate = [NSDate date];
            
            uint32_t total = 0;
            
            while (total < commandLength) {
                uint32_t written = [port writePort:commandsBytes :total :commandLength - total];
                
                total += written;
                
                if ([[NSDate date] timeIntervalSinceDate:startDate] >= 30.0) {     // 30000mS!!!
                    break;
                }
            }
            
            if (total < commandLength) {
                title   = @"Printer Error";
                message = @"Write port timed out";
                break;
            }
            
            int length;
            
            uint8_t buffer[1024 + 8];
            
            length = 1024;
            
            [NSThread sleepForTimeInterval:0.1];     // Break time.
            
            startDate = [NSDate date];     // Restart
            
            int amount = 0;
            
            while (YES) {
                if ([[NSDate date] timeIntervalSinceDate:startDate] >= 1.0) {     // 1000mS!!!
                    title   = @"Printer Error";
                    message = @"Read port timed out";
                    break;
                }
                
                int readLength = [port readPort:buffer :amount :length - amount];
                
//              NSLog(@"readPort:%d", readLength);
//
//              for (int i = 0; i < readLength; i++) {
//                  NSLog(@"%02x", buffer[amount + i]);
//              }
                
                amount += readLength;
                
                if (function.completionHandler(buffer, &amount) == YES) {
                    length = amount;
                    
                    title   = @"Send Commands";
                    message = @"Success";
                    
                    result = YES;
                    break;
                }
            }
            
            break;
        }
    }
    @catch (PortException *exc) {
        title   = @"Printer Error";
        message = @"Write port timed out (PortException)";
    }
    
    if (completionHandler != nil) {
        completionHandler(result, title, message);
    }
    
    return result;
}

+ (BOOL)sendCommands:(NSData *)commands
            portName:(NSString *)portName
        portSettings:(NSString *)portSettings
             timeout:(NSInteger)timeout
   completionHandler:(SendCompletionHandler)completionHandler {
    BOOL result = NO;
    
    NSString *title   = @"";
    NSString *message = @"";
    
    if (timeout > UINT32_MAX) {
        timeout = UINT32_MAX;
    }
    
    uint32_t commandLength = (uint32_t) commands.length;
    
    unsigned char *commandsBytes = (unsigned char *) commands.bytes;
    
    SMPort *port = nil;
    
    @try {
        while (YES) {
            port = [SMPort getPort:portName :portSettings :(uint32_t) timeout];
            
            if (port == nil) {
                title = @"Fail to Open Port";
                break;
            }
            
            StarPrinterStatus_2 printerStatus;
            
            [port beginCheckedBlock:&printerStatus :2];
            
            if (printerStatus.offline == SM_TRUE) {
                title   = @"Printer Error";
                message = @"Printer is offline (BeginCheckedBlock)";
                break;
            }
            
            NSDate *startDate = [NSDate date];
            
            uint32_t total = 0;
            
            while (total < commandLength) {
                uint32_t written = [port writePort:commandsBytes :total :commandLength - total];
                
                total += written;
                
                if ([[NSDate date] timeIntervalSinceDate:startDate] >= 30.0) {     // 30000mS!!!
                    break;
                }
            }
            
            if (total < commandLength) {
                title   = @"Printer Error";
                message = @"Write port timed out";
                break;
            }
            
            port.endCheckedBlockTimeoutMillis = 30000;     // 30000mS!!!
            
            [port endCheckedBlock:&printerStatus :2];
            
            if (printerStatus.offline == SM_TRUE) {
                title   = @"Printer Error";
                message = @"Printer is offline (EndCheckedBlock)";
                break;
            }
            
            title   = @"Send Commands";
            message = @"Success";
            
            result = YES;
            break;
        }
    }
    @catch (PortException *exc) {
        title   = @"Printer Error";
        message = @"Write port timed out (PortException)";
    }
    @finally {
        if (port != nil) {
            [SMPort releasePort:port];
            
            port = nil;
        }
    }
    
    if (completionHandler != nil) {
        completionHandler(result, title, message);
    }
    
    return result;
}

+ (BOOL)sendCommandsDoNotCheckCondition:(NSData *)commands
                               portName:(NSString *)portName
                           portSettings:(NSString *)portSettings
                                timeout:(NSInteger)timeout
                      completionHandler:(SendCompletionHandler)completionHandler {
    BOOL result = NO;
    
    NSString *title   = @"";
    NSString *message = @"";
    
    if (timeout > UINT32_MAX) {
        timeout = UINT32_MAX;
    }
    
    uint32_t commandLength = (uint32_t) commands.length;
    
    unsigned char *commandsBytes = (unsigned char *) commands.bytes;
    
    SMPort *port = nil;
    
    @try {
        while (YES) {
            port = [SMPort getPort:portName :portSettings :(uint32_t) timeout];
            
            if (port == nil) {
                title = @"Fail to Open Port";
                break;
            }
            
            StarPrinterStatus_2 printerStatus;
            
            [port getParsedStatus:&printerStatus :2];
            
//          if (printerStatus.offline == SM_TRUE) {     // Do not check condition.
//              title   = @"Printer Error";
//              message = @"Printer is offline (GetParsedStatus)";
//              break;
//          }
            
            NSDate *startDate = [NSDate date];
            
            uint32_t total = 0;
            
            while (total < commandLength) {
                uint32_t written = [port writePort:commandsBytes :total :commandLength - total];
                
                total += written;
                
                if ([[NSDate date] timeIntervalSinceDate:startDate] >= 30.0) {     // 30000mS!!!
                    break;
                }
            }
            
            if (total < commandLength) {
                title   = @"Printer Error";
                message = @"Write port timed out";
                break;
            }
            
            [port getParsedStatus:&printerStatus :2];
            
//          if (printerStatus.offline == SM_TRUE) {     // Do not check condition.
//              title   = @"Printer Error";
//              message = @"Printer is offline (GetParsedStatus)";
//              break;
//          }
            
            title   = @"Send Commands";
            message = @"Success";
            
            result = YES;
            break;
        }
    }
    @catch (PortException *exc) {
        title   = @"Printer Error";
        message = @"Write port timed out (PortException)";
    }
    @finally {
        if (port != nil) {
            [SMPort releasePort:port];
            
            port = nil;
        }
    }
    
    if (completionHandler != nil) {
        completionHandler(result, title, message);
    }
    
    return result;
}

+ (void)connectBluetooth:(SendCompletionHandler)completionHandler {
    [[EAAccessoryManager sharedAccessoryManager] showBluetoothAccessoryPickerWithNameFilter:nil completion:^(NSError *error) {
        BOOL result;
        
        NSString *title   = @"";
        NSString *message = @"";
        
        if (error != nil) {
            NSLog(@"Error:%@", error.description);
            
            switch (error.code) {
                case EABluetoothAccessoryPickerAlreadyConnected :
                    title   = @"Success";
                    message = @"";
                    
                    result = YES;
                    break;
                case EABluetoothAccessoryPickerResultCancelled :
                case EABluetoothAccessoryPickerResultFailed    :
                    title   = nil;
                    message = nil;
                    
                    result = NO;
                    break;
                default                                       :
//              case EABluetoothAccessoryPickerResultNotFound :
                    title   = @"Fail to Connect";
                    message = @"";
                    
                    result = NO;
                    break;
            }
        }
        else {
            title   = @"Success";
            message = @"";
            
            result = YES;
        }
        
        if (completionHandler != nil) {
            completionHandler(result, title, message);
        }
    }];
}

+ (BOOL)disconnectBluetooth:(NSString *)modelName
                   portName:(NSString *)portName
               portSettings:(NSString *)portSettings
                    timeout:(NSInteger)timeout
          completionHandler:(SendCompletionHandler)completionHandler {
    BOOL result = NO;
    
    NSString *title   = @"";
    NSString *message = @"";
    
    SMPort *port = nil;
    
    @try {
        while (YES) {
            port = [SMPort getPort:portName :portSettings :(uint32_t) timeout];
            
            if (port == nil) {
                title = @"Fail to Open Port";
                break;
            }
            
            if ([modelName hasPrefix:@"TSP143IIIBI"]) {
                unsigned char commandBytes[] = {0x1b, 0x1c, 0x26, 0x49};     // Only TSP143IIIBI
                
                uint32_t commandLength = sizeof(commandBytes);
                
                StarPrinterStatus_2 printerStatus;
                
                [port beginCheckedBlock:&printerStatus :2];
                
                if (printerStatus.offline == SM_TRUE) {
                    title   = @"Printer Error";
                    message = @"Printer is offline (BeginCheckedBlock)";
                    break;
                }
                
                NSDate *startDate = [NSDate date];
                
                uint32_t total = 0;
                
                while (total < commandLength) {
                    uint32_t written = [port writePort:commandBytes :total :commandLength - total];
                    
                    total += written;
                    
                    if ([[NSDate date] timeIntervalSinceDate:startDate] >= 30.0) {     // 30000mS!!!
                        break;
                    }
                }
                
                if (total < commandLength) {
                    title   = @"Printer Error";
                    message = @"Write port timed out";
                    break;
                }
                
//              port.endCheckedBlockTimeoutMillis = 30000;     // 30000mS!!!
//
//              [port endCheckedBlock:&printerStatus :2];
//
//              if (printerStatus.offline == SM_TRUE) {
//                  title   = @"Printer Error";
//                  message = @"Printer is offline (EndCheckedBlock)";
//                  break;
//              }
            }
            else {
                if ([port disconnect] == NO) {
                    title   = @"Fail to Disconnect";
                    message = @"Note. Portable Printers is not supported.";
                    break;
                }
            }
            
            title   = @"Success";
            message = @"";
            
            result = YES;
            break;
        }
    }
    @catch (PortException *exc) {
        title   = @"Printer Error";
        message = @"Write port timed out (PortException)";
    }
    @finally {
        if (port != nil) {
            [SMPort releasePort:port];
            
            port = nil;
        }
    }
    
    if (completionHandler != nil) {
        completionHandler(result, title, message);
    }
    
    return result;
}

@end
