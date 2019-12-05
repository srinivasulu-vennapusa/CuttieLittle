#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
#import "WebServiceUtility.h"
#import "Global.h"
@class StockReturnServiceSvc_createStockReturn;
@class StockReturnServiceSvc_createStockReturnResponse;
@class StockReturnServiceSvc_getStockReturn;
@class StockReturnServiceSvc_getStockReturnResponse;
@class StockReturnServiceSvc_updateStockReturn;
@class StockReturnServiceSvc_updateStockReturnResponse;
@interface StockReturnServiceSvc_createStockReturn : NSObject {
	
/* elements */
	NSString * createStock;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockReturnServiceSvc_createStockReturn *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * createStock;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockReturnServiceSvc_createStockReturnResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockReturnServiceSvc_createStockReturnResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockReturnServiceSvc_getStockReturn : NSObject {
	
/* elements */
	NSString * getStock;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockReturnServiceSvc_getStockReturn *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * getStock;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockReturnServiceSvc_getStockReturnResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockReturnServiceSvc_getStockReturnResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockReturnServiceSvc_updateStockReturn : NSObject {
	
/* elements */
	NSString * updateStock;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockReturnServiceSvc_updateStockReturn *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * updateStock;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockReturnServiceSvc_updateStockReturnResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockReturnServiceSvc_updateStockReturnResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "StockReturnServiceSvc.h"
@class StockReturnServiceSoapBinding;
@interface StockReturnServiceSvc : NSObject {
	
}
+ (StockReturnServiceSoapBinding *)StockReturnServiceSoapBinding;
@end
@class StockReturnServiceSoapBindingResponse;
@class StockReturnServiceSoapBindingOperation;
@protocol StockReturnServiceSoapBindingResponseDelegate <NSObject>
- (void) operation:(StockReturnServiceSoapBindingOperation *)operation completedWithResponse:(StockReturnServiceSoapBindingResponse *)response;
@end
@interface StockReturnServiceSoapBinding : NSObject <StockReturnServiceSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(StockReturnServiceSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (StockReturnServiceSoapBindingResponse *)createStockReturnUsingParameters:(StockReturnServiceSvc_createStockReturn *)aParameters ;
- (void)createStockReturnAsyncUsingParameters:(StockReturnServiceSvc_createStockReturn *)aParameters  delegate:(id<StockReturnServiceSoapBindingResponseDelegate>)responseDelegate;
- (StockReturnServiceSoapBindingResponse *)updateStockReturnUsingParameters:(StockReturnServiceSvc_updateStockReturn *)aParameters ;
- (void)updateStockReturnAsyncUsingParameters:(StockReturnServiceSvc_updateStockReturn *)aParameters  delegate:(id<StockReturnServiceSoapBindingResponseDelegate>)responseDelegate;
- (StockReturnServiceSoapBindingResponse *)getStockReturnUsingParameters:(StockReturnServiceSvc_getStockReturn *)aParameters ;
- (void)getStockReturnAsyncUsingParameters:(StockReturnServiceSvc_getStockReturn *)aParameters  delegate:(id<StockReturnServiceSoapBindingResponseDelegate>)responseDelegate;
@end
@interface StockReturnServiceSoapBindingOperation : NSOperation {
	StockReturnServiceSoapBinding *binding;
	StockReturnServiceSoapBindingResponse * response;
	id<StockReturnServiceSoapBindingResponseDelegate>  delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (strong) StockReturnServiceSoapBinding *binding;
@property (  readonly) StockReturnServiceSoapBindingResponse *response;
@property (nonatomic ) id<StockReturnServiceSoapBindingResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(StockReturnServiceSoapBinding *)aBinding delegate:(id<StockReturnServiceSoapBindingResponseDelegate>)aDelegate;
@end
@interface StockReturnServiceSoapBinding_createStockReturn : StockReturnServiceSoapBindingOperation {
	StockReturnServiceSvc_createStockReturn * parameters;
}
@property (strong) StockReturnServiceSvc_createStockReturn * parameters;
- (id)initWithBinding:(StockReturnServiceSoapBinding *)aBinding delegate:(id<StockReturnServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(StockReturnServiceSvc_createStockReturn *)aParameters
;
@end
@interface StockReturnServiceSoapBinding_updateStockReturn : StockReturnServiceSoapBindingOperation {
	StockReturnServiceSvc_updateStockReturn * parameters;
}
@property (strong) StockReturnServiceSvc_updateStockReturn * parameters;
- (id)initWithBinding:(StockReturnServiceSoapBinding *)aBinding delegate:(id<StockReturnServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(StockReturnServiceSvc_updateStockReturn *)aParameters
;
@end
@interface StockReturnServiceSoapBinding_getStockReturn : StockReturnServiceSoapBindingOperation {
	StockReturnServiceSvc_getStockReturn * parameters;
}
@property (strong) StockReturnServiceSvc_getStockReturn * parameters;
- (id)initWithBinding:(StockReturnServiceSoapBinding *)aBinding delegate:(id<StockReturnServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(StockReturnServiceSvc_getStockReturn *)aParameters
;
@end
@interface StockReturnServiceSoapBinding_envelope : NSObject {
}
+ (StockReturnServiceSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface StockReturnServiceSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end
