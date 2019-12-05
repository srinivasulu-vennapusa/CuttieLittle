#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class StocksDetailsServiceSvc_getStockDetailsTransaction;
@class StocksDetailsServiceSvc_getStockDetailsTransactionResponse;
@class StocksDetailsServiceSvc_getStockDetailsPurchaseTransaction;
@class StocksDetailsServiceSvc_getStockDetailsPurchaseTransactionResponse;
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
@property (retain) NSString * skuID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StocksDetailsServiceSvc_getStockDetailsTransactionResponse : NSObject {
	
/* elements */
	NSString * getStockDetailsTransactionReturn;
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
@property (retain) NSString * getStockDetailsTransactionReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
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
@property (retain) NSString * skuID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StocksDetailsServiceSvc_getStockDetailsPurchaseTransactionResponse : NSObject {
	
/* elements */
	NSString * getStockDetailsPurchaseTransactionReturn;
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
@property (retain) NSString * getStockDetailsPurchaseTransactionReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "ns1.h"
#import "StocksDetailsServiceSvc.h"
@class StocksDetailsSoapBinding;
@interface StocksDetailsServiceSvc : NSObject {
	
}
+ (StocksDetailsSoapBinding *)StocksDetailsSoapBinding;
@end
@class StocksDetailsSoapBindingResponse;
@class StocksDetailsSoapBindingOperation;
@protocol StocksDetailsSoapBindingResponseDelegate <NSObject>
- (void) operation:(StocksDetailsSoapBindingOperation *)operation completedWithResponse:(StocksDetailsSoapBindingResponse *)response;
@end
@interface StocksDetailsSoapBinding : NSObject <StocksDetailsSoapBindingResponseDelegate> {
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
@property (nonatomic, retain) NSMutableArray *cookies;
@property (nonatomic, retain) NSString *authUsername;
@property (nonatomic, retain) NSString *authPassword;
- (id)initWithAddress:(NSString *)anAddress;
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(StocksDetailsSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (StocksDetailsSoapBindingResponse *)getStockDetailsTransactionUsingParameters:(StocksDetailsServiceSvc_getStockDetailsTransaction *)aParameters ;
- (void)getStockDetailsTransactionAsyncUsingParameters:(StocksDetailsServiceSvc_getStockDetailsTransaction *)aParameters  delegate:(id<StocksDetailsSoapBindingResponseDelegate>)responseDelegate;
- (StocksDetailsSoapBindingResponse *)getStockDetailsPurchaseTransactionUsingParameters:(StocksDetailsServiceSvc_getStockDetailsPurchaseTransaction *)aParameters ;
- (void)getStockDetailsPurchaseTransactionAsyncUsingParameters:(StocksDetailsServiceSvc_getStockDetailsPurchaseTransaction *)aParameters  delegate:(id<StocksDetailsSoapBindingResponseDelegate>)responseDelegate;
@end
@interface StocksDetailsSoapBindingOperation : NSOperation {
	StocksDetailsSoapBinding *binding;
	StocksDetailsSoapBindingResponse *response;
	id<StocksDetailsSoapBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) StocksDetailsSoapBinding *binding;
@property (readonly) StocksDetailsSoapBindingResponse *response;
@property (nonatomic, assign) id<StocksDetailsSoapBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(StocksDetailsSoapBinding *)aBinding delegate:(id<StocksDetailsSoapBindingResponseDelegate>)aDelegate;
@end
@interface StocksDetailsSoapBinding_getStockDetailsTransaction : StocksDetailsSoapBindingOperation {
	StocksDetailsServiceSvc_getStockDetailsTransaction * parameters;
}
@property (retain) StocksDetailsServiceSvc_getStockDetailsTransaction * parameters;
- (id)initWithBinding:(StocksDetailsSoapBinding *)aBinding delegate:(id<StocksDetailsSoapBindingResponseDelegate>)aDelegate
	parameters:(StocksDetailsServiceSvc_getStockDetailsTransaction *)aParameters
;
@end
@interface StocksDetailsSoapBinding_getStockDetailsPurchaseTransaction : StocksDetailsSoapBindingOperation {
	StocksDetailsServiceSvc_getStockDetailsPurchaseTransaction * parameters;
}
@property (retain) StocksDetailsServiceSvc_getStockDetailsPurchaseTransaction * parameters;
- (id)initWithBinding:(StocksDetailsSoapBinding *)aBinding delegate:(id<StocksDetailsSoapBindingResponseDelegate>)aDelegate
	parameters:(StocksDetailsServiceSvc_getStockDetailsPurchaseTransaction *)aParameters
;
@end
@interface StocksDetailsSoapBinding_envelope : NSObject {
}
+ (StocksDetailsSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface StocksDetailsSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
