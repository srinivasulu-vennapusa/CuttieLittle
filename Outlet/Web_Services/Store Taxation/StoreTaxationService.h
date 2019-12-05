#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class StoreTaxationService_createStoreTaxation;
@class StoreTaxationService_createStoreTaxationResponse;
@class StoreTaxationService_getStoreTaxation;
@class StoreTaxationService_getStoreTaxationResponse;
@class StoreTaxationService_updateStoreTaxation;
@class StoreTaxationService_updateStoreTaxationResponse;
@interface StoreTaxationService_createStoreTaxation : NSObject {
	
/* elements */
	NSString * createStoreTaxationStr;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StoreTaxationService_createStoreTaxation *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * createStoreTaxationStr;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StoreTaxationService_createStoreTaxationResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StoreTaxationService_createStoreTaxationResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StoreTaxationService_getStoreTaxation : NSObject {
	
/* elements */
	NSString * getStoreTaxationStr;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StoreTaxationService_getStoreTaxation *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * getStoreTaxationStr;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StoreTaxationService_getStoreTaxationResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StoreTaxationService_getStoreTaxationResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StoreTaxationService_updateStoreTaxation : NSObject {
	
/* elements */
	NSString * updateStoreTaxationStr;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StoreTaxationService_updateStoreTaxation *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * updateStoreTaxationStr;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StoreTaxationService_updateStoreTaxationResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StoreTaxationService_updateStoreTaxationResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "StoreTaxationService.h"
@class StoreTaxationServiceSoapBinding;
@interface StoreTaxationService : NSObject {
	
}
+ (StoreTaxationServiceSoapBinding *)StoreTaxationServiceSoapBinding;
@end
@class StoreTaxationServiceSoapBindingResponse;
@class StoreTaxationServiceSoapBindingOperation;
@protocol StoreTaxationServiceSoapBindingResponseDelegate <NSObject>
- (void) operation:(StoreTaxationServiceSoapBindingOperation *)operation completedWithResponse:(StoreTaxationServiceSoapBindingResponse *)response;
@end
@interface StoreTaxationServiceSoapBinding : NSObject <StoreTaxationServiceSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(StoreTaxationServiceSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (StoreTaxationServiceSoapBindingResponse *)getStoreTaxationUsingParameters:(StoreTaxationService_getStoreTaxation *)aParameters ;
- (void)getStoreTaxationAsyncUsingParameters:(StoreTaxationService_getStoreTaxation *)aParameters  delegate:(id<StoreTaxationServiceSoapBindingResponseDelegate>)responseDelegate;
- (StoreTaxationServiceSoapBindingResponse *)createStoreTaxationUsingParameters:(StoreTaxationService_createStoreTaxation *)aParameters ;
- (void)createStoreTaxationAsyncUsingParameters:(StoreTaxationService_createStoreTaxation *)aParameters  delegate:(id<StoreTaxationServiceSoapBindingResponseDelegate>)responseDelegate;
- (StoreTaxationServiceSoapBindingResponse *)updateStoreTaxationUsingParameters:(StoreTaxationService_updateStoreTaxation *)aParameters ;
- (void)updateStoreTaxationAsyncUsingParameters:(StoreTaxationService_updateStoreTaxation *)aParameters  delegate:(id<StoreTaxationServiceSoapBindingResponseDelegate>)responseDelegate;
@end
@interface StoreTaxationServiceSoapBindingOperation : NSOperation {
	StoreTaxationServiceSoapBinding *binding;
	StoreTaxationServiceSoapBindingResponse * response;
	id<StoreTaxationServiceSoapBindingResponseDelegate>  delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (strong) StoreTaxationServiceSoapBinding *binding;
@property (  readonly) StoreTaxationServiceSoapBindingResponse *response;
@property (nonatomic ) id<StoreTaxationServiceSoapBindingResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(StoreTaxationServiceSoapBinding *)aBinding delegate:(id<StoreTaxationServiceSoapBindingResponseDelegate>)aDelegate;
@end
@interface StoreTaxationServiceSoapBinding_getStoreTaxation : StoreTaxationServiceSoapBindingOperation {
	StoreTaxationService_getStoreTaxation * parameters;
}
@property (strong) StoreTaxationService_getStoreTaxation * parameters;
- (id)initWithBinding:(StoreTaxationServiceSoapBinding *)aBinding delegate:(id<StoreTaxationServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(StoreTaxationService_getStoreTaxation *)aParameters
;
@end
@interface StoreTaxationServiceSoapBinding_createStoreTaxation : StoreTaxationServiceSoapBindingOperation {
	StoreTaxationService_createStoreTaxation * parameters;
}
@property (strong) StoreTaxationService_createStoreTaxation * parameters;
- (id)initWithBinding:(StoreTaxationServiceSoapBinding *)aBinding delegate:(id<StoreTaxationServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(StoreTaxationService_createStoreTaxation *)aParameters
;
@end
@interface StoreTaxationServiceSoapBinding_updateStoreTaxation : StoreTaxationServiceSoapBindingOperation {
	StoreTaxationService_updateStoreTaxation * parameters;
}
@property (strong) StoreTaxationService_updateStoreTaxation * parameters;
- (id)initWithBinding:(StoreTaxationServiceSoapBinding *)aBinding delegate:(id<StoreTaxationServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(StoreTaxationService_updateStoreTaxation *)aParameters
;
@end
@interface StoreTaxationServiceSoapBinding_envelope : NSObject {
}
+ (StoreTaxationServiceSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface StoreTaxationServiceSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end
