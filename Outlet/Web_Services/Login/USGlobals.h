#import <Foundation/Foundation.h>

@interface USGlobals : NSObject {
	NSMutableDictionary *wsdlStandardNamespaces;
}

@property (strong) NSMutableDictionary *wsdlStandardNamespaces;

+ (USGlobals *)sharedInstance;

@end
