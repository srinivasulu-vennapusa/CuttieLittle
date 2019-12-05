#import "SettingsManager.h"

@implementation SettingsManager

static SettingsManager* _sharedSettingsManager = nil;

-(NSString *)getString:(NSString*)value
{    
    return settings[value];
}

-(int)getInt:(NSString*)value {
    return [settings[value] intValue];
}

-(void)setValue:(NSString*)value newString:(NSString *)aValue {    
    settings[value] = aValue;
}

-(NSString *)getValue:(NSString*)value {    
    return settings[value];
}

-(void)setValue:(NSString*)value newInt:(int)aValue {
    settings[value] = [NSString stringWithFormat:@"%i",aValue];
}

-(void)save
{
    // NOTE: You should be replace "MyAppName" with your own custom application string.
    //
    [[NSUserDefaults standardUserDefaults] setObject:settings forKey:@"APP_Expiration"];
    [[NSUserDefaults standardUserDefaults] synchronize];    
}

-(void)load
{
    // NOTE: You should be replace "MyAppName" with your own custom application string.
    //
    [settings addEntriesFromDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"APP_Expiration"]];
}

// Logging function great for checkin out what keys/values you have at any given time
//
-(void)logSettings
{
    for(NSString* item in settings.allKeys)
    {
        NSLog(@"[SettingsManager KEY:%@ - VALUE:%@]", item, [settings valueForKey:item]);
    }
}

+(SettingsManager*)sharedSettingsManager
{
    @synchronized([SettingsManager class])
    {
        if (!_sharedSettingsManager)
            [[self alloc] init];
        
        return _sharedSettingsManager;
    }
    
    return nil;
}

+(id)alloc
{
    @synchronized([SettingsManager class])
    {
        NSAssert(_sharedSettingsManager == nil, @"Attempted to allocate a second instance of a singleton.");
        _sharedSettingsManager = [[super alloc] init];
        return _sharedSettingsManager;
    }
    
    return nil;
}

//commented by Srinivasulu on 19/09/2017.....
//reason is --  release, autorelease, dealloc -- will be managed by ARC ....

//-(id)autorelease {
//    return self;
//}

//upto here on 19/09/2017....

-(id)init {    
    settings = [[NSMutableDictionary alloc] initWithCapacity:5];    
    return [super init];
}

@end
