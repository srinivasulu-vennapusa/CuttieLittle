#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class StocksDetailsServiceSvc_getStockDetailsPurchaseTransaction;
@class StocksDetailsServiceSvc_getStockDetailsPurchaseTransactionResponse;
@class StocksDetailsServiceSvc_getStockDetailsTransaction;
@class StocksDetailsServiceSvc_getStockDetailsTransactionResponse;
@class StocksDetailsServiceSvc_helloworld;
@class StocksDetailsServiceSvc_helloworldResponse;
@interface StocksDetailsServiceSvc_getStockDetailsPurchaseTransaction : NSObject {
	
/* elements */
	NSString * skuID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StocksDetailsServiceSvc_getStockDetailsPurchaseTransaction *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * skuID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StocksDetailsServiceSvc_getStockDetailsPurchaseTransactionResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StocksDetailsServiceSvc_getStockDetailsPurchaseTransactionResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StocksDetailsServiceSvc_getStockDetailsTransaction : NSObject {
	
/* elements */
	NSString * skuID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StocksDetailsServiceSvc_getStockDetailsTransaction *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * skuID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StocksDetailsServiceSvc_getStockDetailsTransactionResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StocksDetailsServiceSvc_getStockDetailsTransactionResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StocksDetailsServiceSvc_helloworld : NSObject {
	
/* elements */
	NSString * testString;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StocksDetailsServiceSvc_helloworld *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * testString;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StocksDetailsServiceSvc_helloworldResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StocksDetailsServiceSvc_helloworldResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "StocksDetailsServiceSvc.h"
@class StocksDetailsServiceSoapBinding;
@interface StocksDetailsServiceSvc : NSObject {
	
}
+ (StocksDetailsServiceSoapBinding *)StocksDetailsServiceSoapBinding;
@end
@class StocksDetailsServiceSoapBindingResponse;
@class StocksDetailsServiceSoapBindingOperation;
@protocol StocksDetailsServiceSoapBindingResponseDelegate <NSObject>
- (void) operation:(StocksDetailsServiceSoapBindingOperation *)operation completedWithResponse:(StocksDetailsServiceSoapBindingResponse *)response;
@end
@interface StocksDetailsServiceSoapBinding : NSObject <StocksDetailsServiceSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(StocksDetailsServiceSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (StocksDetailsServiceSoapBindingResponse *)getStockDetailsPurchaseTransactionUsingParameters:(StocksDetailsServiceSvc_getStockDetailsPurchaseTransaction *)aParameters ;
- (void)getStockDetailsPurchaseTransactionAsyncUsingParameters:(StocksDetailsServiceSvc_getStockDetailsPurchaseTransaction *)aParameters  delegate:(id<StocksDetailsServiceSoapBindingResponseDelegate>)responseDelegate;
- (StocksDetailsServiceSoapBindingResponse *)getStockDetailsTransactionUsingParameters:(StocksDetailsServiceSvc_getStockDetailsTransaction *)aParameters ;
- (void)getStockDetailsTransactionAsyncUsingParameters:(StocksDetailsServiceSvc_getStockDetailsTransaction *)aParameters  delegate:(id<StocksDetailsServiceSoapBindingResponseDelegate>)responseDelegate;
- (StocksDetailsServiceSoapBindingResponse *)helloworldUsingParameters:(StocksDetailsServiceSvc_helloworld *)aParameters ;
- (void)helloworldAsyncUsingParameters:(StocksDetailsServiceSvc_helloworld *)aParameters  delegate:(id<StocksDetailsServiceSoapBindingResponseDelegate>)responseDelegate;
@end
@interface StocksDetailsServiceSoapBindingOperation : NSOperation {
	StocksDetailsServiceSoapBinding *binding;
	StocksDetailsServiceSoapBindingResponse * response;
	id<StocksDetailsServiceSoapBindingResponseDelegate>  delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (strong) StocksDetailsServiceSoapBinding *binding;
@property (  readonly) StocksDetailsServiceSoapBindingResponse *response;
@property (nonatomic ) id<StocksDetailsServiceSoapBindingResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(StocksDetailsServiceSoapBinding *)aBinding delegate:(id<StocksDetailsServiceSoapBindingResponseDelegate>)aDelegate;
@end
@interface StocksDetailsServiceSoapBinding_getStockDetailsPurchaseTransaction : StocksDetailsServiceSoapBindingOperation {
	StocksDetailsServiceSvc_getStockDetailsPurchaseTransaction * parameters;
}
@property (strong) StocksDetailsServiceSvc_getStockDetailsPurchaseTransaction * parameters;
- (id)initWithBinding:(StocksDetailsServiceSoapBinding *)aBinding delegate:(id<StocksDetailsServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(StocksDetailsServiceSvc_getStockDetailsPurchaseTransaction *)aParameters
;
@end
@interface StocksDetailsServiceSoapBinding_getStockDetailsTransaction : StocksDetailsServiceSoapBindingOperation {
	StocksDetailsServiceSvc_getStockDetailsTransaction * parameters;
}
@property (strong) StocksDetailsServiceSvc_getStockDetailsTransaction * parameters;
- (id)initWithBinding:(StocksDetailsServiceSoapBinding *)aBinding delegate:(id<StocksDetailsServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(StocksDetailsServiceSvc_getStockDetailsTransaction *)aParameters
;
@end
@interface StocksDetailsServiceSoapBinding_helloworld : StocksDetailsServiceSoapBindingOperation {
	StocksDetailsServiceSvc_helloworld * parameters;
}
@property (strong) StocksDetailsServiceSvc_helloworld * parameters;
- (id)initWithBinding:(StocksDetailsServiceSoapBinding *)aBinding delegate:(id<StocksDetailsServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(StocksDetailsServiceSvc_helloworld *)aParameters
;
@end
@interface StocksDetailsServiceSoapBinding_envelope : NSObject {
}
+ (StocksDetailsServiceSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface StocksDetailsServiceSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end
