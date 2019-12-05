#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class StockRequests_createStockRequest;
@class StockRequests_createStockRequestResponse;
@class StockRequests_getStockRequests;
@class StockRequests_getStockRequestsResponse;
@class StockRequests_updateStockRequest;
@class StockRequests_updateStockRequestResponse;
@interface StockRequests_createStockRequest : NSObject {
	
/* elements */
	NSString * stockRequestDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockRequests_createStockRequest *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * stockRequestDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockRequests_createStockRequestResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockRequests_createStockRequestResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockRequests_getStockRequests : NSObject {
	
/* elements */
	NSString * stockRequestDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockRequests_getStockRequests *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * stockRequestDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockRequests_getStockRequestsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockRequests_getStockRequestsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockRequests_updateStockRequest : NSObject {
	
/* elements */
	NSString * stockRequestDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockRequests_updateStockRequest *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * stockRequestDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockRequests_updateStockRequestResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockRequests_updateStockRequestResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "StockRequests.h"
@class StockRequestsSoapBinding;
@interface StockRequests : NSObject {
	
}
+ (StockRequestsSoapBinding *)StockRequestsSoapBinding;
@end
@class StockRequestsSoapBindingResponse;
@class StockRequestsSoapBindingOperation;
@protocol StockRequestsSoapBindingResponseDelegate <NSObject>
- (void) operation:(StockRequestsSoapBindingOperation *)operation completedWithResponse:(StockRequestsSoapBindingResponse *)response;
@end
@interface StockRequestsSoapBinding : NSObject <StockRequestsSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(StockRequestsSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (StockRequestsSoapBindingResponse *)createStockRequestUsingParameters:(StockRequests_createStockRequest *)aParameters ;
- (void)createStockRequestAsyncUsingParameters:(StockRequests_createStockRequest *)aParameters  delegate:(id<StockRequestsSoapBindingResponseDelegate>)responseDelegate;
- (StockRequestsSoapBindingResponse *)updateStockRequestUsingParameters:(StockRequests_updateStockRequest *)aParameters ;
- (void)updateStockRequestAsyncUsingParameters:(StockRequests_updateStockRequest *)aParameters  delegate:(id<StockRequestsSoapBindingResponseDelegate>)responseDelegate;
- (StockRequestsSoapBindingResponse *)getStockRequestsUsingParameters:(StockRequests_getStockRequests *)aParameters ;
- (void)getStockRequestsAsyncUsingParameters:(StockRequests_getStockRequests *)aParameters  delegate:(id<StockRequestsSoapBindingResponseDelegate>)responseDelegate;
@end
@interface StockRequestsSoapBindingOperation : NSOperation {
	StockRequestsSoapBinding *binding;
	StockRequestsSoapBindingResponse * response;
	id<StockRequestsSoapBindingResponseDelegate>  delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (strong) StockRequestsSoapBinding *binding;
@property (  readonly) StockRequestsSoapBindingResponse *response;
@property (nonatomic ) id<StockRequestsSoapBindingResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(StockRequestsSoapBinding *)aBinding delegate:(id<StockRequestsSoapBindingResponseDelegate>)aDelegate;
@end
@interface StockRequestsSoapBinding_createStockRequest : StockRequestsSoapBindingOperation {
	StockRequests_createStockRequest * parameters;
}
@property (strong) StockRequests_createStockRequest * parameters;
- (id)initWithBinding:(StockRequestsSoapBinding *)aBinding delegate:(id<StockRequestsSoapBindingResponseDelegate>)aDelegate
	parameters:(StockRequests_createStockRequest *)aParameters
;
@end
@interface StockRequestsSoapBinding_updateStockRequest : StockRequestsSoapBindingOperation {
	StockRequests_updateStockRequest * parameters;
}
@property (strong) StockRequests_updateStockRequest * parameters;
- (id)initWithBinding:(StockRequestsSoapBinding *)aBinding delegate:(id<StockRequestsSoapBindingResponseDelegate>)aDelegate
	parameters:(StockRequests_updateStockRequest *)aParameters
;
@end
@interface StockRequestsSoapBinding_getStockRequests : StockRequestsSoapBindingOperation {
	StockRequests_getStockRequests * parameters;
}
@property (strong) StockRequests_getStockRequests * parameters;
- (id)initWithBinding:(StockRequestsSoapBinding *)aBinding delegate:(id<StockRequestsSoapBindingResponseDelegate>)aDelegate
	parameters:(StockRequests_getStockRequests *)aParameters
;
@end
@interface StockRequestsSoapBinding_envelope : NSObject {
}
+ (StockRequestsSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface StockRequestsSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end
