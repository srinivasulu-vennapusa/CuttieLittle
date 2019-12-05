#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class appSettingsSvc_getAppSettings;
@class appSettingsSvc_getAppSettingsResponse;
@interface appSettingsSvc_getAppSettings : NSObject {
	
/* elements */
	NSString * customerInfo;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (appSettingsSvc_getAppSettings *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * customerInfo;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface appSettingsSvc_getAppSettingsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (appSettingsSvc_getAppSettingsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "xs.h"
#import "appSettingsSvc.h"
@class appSettingsSoapBinding;
@interface appSettingsSvc : NSObject {
	
}
+ (appSettingsSoapBinding *)appSettingsSoapBinding;
@end
@class appSettingsSoapBindingResponse;
@class appSettingsSoapBindingOperation;
@protocol appSettingsSoapBindingResponseDelegate <NSObject>
- (void) operation:(appSettingsSoapBindingOperation *)operation completedWithResponse:(appSettingsSoapBindingResponse *)response;
@end
@interface appSettingsSoapBinding : NSObject <appSettingsSoapBindingResponseDelegate> {
	NSURL *address;
	NSTimeInterval defaultTimeout;
	NSMutableArray *cookies;
	BOOL logXMLInOut;
	BOOL synchronousOperationComplete;
	NSString *authUsername;
	NSString *authPassword;
}
@property (copy) NSURL *address;
@property (assign) BOOL logXMLInOut;
@property (assign) NSTimeInterval defaultTimeout;
@property (nonatomic, strong) NSMutableArray *cookies;
@property (nonatomic, strong) NSString *authUsername;
@property (nonatomic, strong) NSString *authPassword;
- (id)initWithAddress:(NSString *)anAddress;
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(appSettingsSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (appSettingsSoapBindingResponse *)getAppSettingsUsingParameters:(appSettingsSvc_getAppSettings *)aParameters ;
- (void)getAppSettingsAsyncUsingParameters:(appSettingsSvc_getAppSettings *)aParameters  delegate:(id<appSettingsSoapBindingResponseDelegate>)responseDelegate;
@end
@interface appSettingsSoapBindingOperation : NSOperation {
	appSettingsSoapBinding *binding;
	appSettingsSoapBindingResponse * response;
	id<appSettingsSoapBindingResponseDelegate>  delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (strong) appSettingsSoapBinding *binding;
@property (  readonly) appSettingsSoapBindingResponse *response;
@property (nonatomic ) id<appSettingsSoapBindingResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(appSettingsSoapBinding *)aBinding delegate:(id<appSettingsSoapBindingResponseDelegate>)aDelegate;
@end
@interface appSettingsSoapBinding_getAppSettings : appSettingsSoapBindingOperation {
	appSettingsSvc_getAppSettings * parameters;
}
@property (strong) appSettingsSvc_getAppSettings * parameters;
- (id)initWithBinding:(appSettingsSoapBinding *)aBinding delegate:(id<appSettingsSoapBindingResponseDelegate>)aDelegate
	parameters:(appSettingsSvc_getAppSettings *)aParameters
;
@end
@interface appSettingsSoapBinding_envelope : NSObject {
}
+ (appSettingsSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface appSettingsSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end
