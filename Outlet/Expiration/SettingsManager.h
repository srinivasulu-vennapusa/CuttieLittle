//
#import <Foundation/Foundation.h>

@interface SettingsManager : NSObject {
	NSMutableDictionary* settings;
}

-(NSString *)getString:(NSString*)value;
-(int)getInt:(NSString*)value;
-(void)setValue:(NSString*)value newString:(NSString *)aValue;
-(NSString *)getValue:(NSString*)value;
-(void)setValue:(NSString*)value newInt:(int)aValue;
-(void)save;
-(void)load;
-(void)logSettings;

+(SettingsManager*)sharedSettingsManager;
@end