#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class purchaseOrdersSvc_createPurchaseOrder;
@class purchaseOrdersSvc_createPurchaseOrderResponse;
@class purchaseOrdersSvc_deletePurchaseOrder;
@class purchaseOrdersSvc_deletePurchaseOrderResponse;
@class purchaseOrdersSvc_getPurchaseOrderDetails;
@class purchaseOrdersSvc_getPurchaseOrderDetailsResponse;
@class purchaseOrdersSvc_getPurchaseOrders;
@class purchaseOrdersSvc_getPurchaseOrdersResponse;
@class purchaseOrdersSvc_updatePurchaseOrder;
@class purchaseOrdersSvc_updatePurchaseOrderResponse;
@interface purchaseOrdersSvc_createPurchaseOrder : NSObject {
	
/* elements */
	NSString * orderDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (purchaseOrdersSvc_createPurchaseOrder *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * orderDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface purchaseOrdersSvc_createPurchaseOrderResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (purchaseOrdersSvc_createPurchaseOrderResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface purchaseOrdersSvc_deletePurchaseOrder : NSObject {
	
/* elements */
	NSString * orderDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (purchaseOrdersSvc_deletePurchaseOrder *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * orderDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface purchaseOrdersSvc_deletePurchaseOrderResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (purchaseOrdersSvc_deletePurchaseOrderResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface purchaseOrdersSvc_getPurchaseOrderDetails : NSObject {
	
/* elements */
	NSString * orderDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (purchaseOrdersSvc_getPurchaseOrderDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * orderDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface purchaseOrdersSvc_getPurchaseOrderDetailsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (purchaseOrdersSvc_getPurchaseOrderDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface purchaseOrdersSvc_getPurchaseOrders : NSObject {
	
/* elements */
	NSString * orderDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (purchaseOrdersSvc_getPurchaseOrders *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * orderDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface purchaseOrdersSvc_getPurchaseOrdersResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (purchaseOrdersSvc_getPurchaseOrdersResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface purchaseOrdersSvc_updatePurchaseOrder : NSObject {
	
/* elements */
	NSString * orderDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (purchaseOrdersSvc_updatePurchaseOrder *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * orderDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface purchaseOrdersSvc_updatePurchaseOrderResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (purchaseOrdersSvc_updatePurchaseOrderResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "purchaseOrdersSvc.h"
@class purchaseOrdersSoapBinding;
@interface purchaseOrdersSvc : NSObject {
	
}
+ (purchaseOrdersSoapBinding *)purchaseOrdersSoapBinding;
@end
@class purchaseOrdersSoapBindingResponse;
@class purchaseOrdersSoapBindingOperation;
@protocol purchaseOrdersSoapBindingResponseDelegate <NSObject>
- (void) operation:(purchaseOrdersSoapBindingOperation *)operation completedWithResponse:(purchaseOrdersSoapBindingResponse *)response;
@end
@interface purchaseOrdersSoapBinding : NSObject <purchaseOrdersSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(purchaseOrdersSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (purchaseOrdersSoapBindingResponse *)getPurchaseOrdersUsingParameters:(purchaseOrdersSvc_getPurchaseOrders *)aParameters ;
- (void)getPurchaseOrdersAsyncUsingParameters:(purchaseOrdersSvc_getPurchaseOrders *)aParameters  delegate:(id<purchaseOrdersSoapBindingResponseDelegate>)responseDelegate;
- (purchaseOrdersSoapBindingResponse *)deletePurchaseOrderUsingParameters:(purchaseOrdersSvc_deletePurchaseOrder *)aParameters ;
- (void)deletePurchaseOrderAsyncUsingParameters:(purchaseOrdersSvc_deletePurchaseOrder *)aParameters  delegate:(id<purchaseOrdersSoapBindingResponseDelegate>)responseDelegate;
- (purchaseOrdersSoapBindingResponse *)createPurchaseOrderUsingParameters:(purchaseOrdersSvc_createPurchaseOrder *)aParameters ;
- (void)createPurchaseOrderAsyncUsingParameters:(purchaseOrdersSvc_createPurchaseOrder *)aParameters  delegate:(id<purchaseOrdersSoapBindingResponseDelegate>)responseDelegate;
- (purchaseOrdersSoapBindingResponse *)getPurchaseOrderDetailsUsingParameters:(purchaseOrdersSvc_getPurchaseOrderDetails *)aParameters ;
- (void)getPurchaseOrderDetailsAsyncUsingParameters:(purchaseOrdersSvc_getPurchaseOrderDetails *)aParameters  delegate:(id<purchaseOrdersSoapBindingResponseDelegate>)responseDelegate;
- (purchaseOrdersSoapBindingResponse *)updatePurchaseOrderUsingParameters:(purchaseOrdersSvc_updatePurchaseOrder *)aParameters ;
- (void)updatePurchaseOrderAsyncUsingParameters:(purchaseOrdersSvc_updatePurchaseOrder *)aParameters  delegate:(id<purchaseOrdersSoapBindingResponseDelegate>)responseDelegate;
@end
@interface purchaseOrdersSoapBindingOperation : NSOperation {
	purchaseOrdersSoapBinding *binding;
	purchaseOrdersSoapBindingResponse * response;
	id<purchaseOrdersSoapBindingResponseDelegate>  delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (strong) purchaseOrdersSoapBinding *binding;
@property (  readonly) purchaseOrdersSoapBindingResponse *response;
@property (nonatomic ) id<purchaseOrdersSoapBindingResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(purchaseOrdersSoapBinding *)aBinding delegate:(id<purchaseOrdersSoapBindingResponseDelegate>)aDelegate;
@end
@interface purchaseOrdersSoapBinding_getPurchaseOrders : purchaseOrdersSoapBindingOperation {
	purchaseOrdersSvc_getPurchaseOrders * parameters;
}
@property (strong) purchaseOrdersSvc_getPurchaseOrders * parameters;
- (id)initWithBinding:(purchaseOrdersSoapBinding *)aBinding delegate:(id<purchaseOrdersSoapBindingResponseDelegate>)aDelegate
	parameters:(purchaseOrdersSvc_getPurchaseOrders *)aParameters
;
@end
@interface purchaseOrdersSoapBinding_deletePurchaseOrder : purchaseOrdersSoapBindingOperation {
	purchaseOrdersSvc_deletePurchaseOrder * parameters;
}
@property (strong) purchaseOrdersSvc_deletePurchaseOrder * parameters;
- (id)initWithBinding:(purchaseOrdersSoapBinding *)aBinding delegate:(id<purchaseOrdersSoapBindingResponseDelegate>)aDelegate
	parameters:(purchaseOrdersSvc_deletePurchaseOrder *)aParameters
;
@end
@interface purchaseOrdersSoapBinding_createPurchaseOrder : purchaseOrdersSoapBindingOperation {
	purchaseOrdersSvc_createPurchaseOrder * parameters;
}
@property (strong) purchaseOrdersSvc_createPurchaseOrder * parameters;
- (id)initWithBinding:(purchaseOrdersSoapBinding *)aBinding delegate:(id<purchaseOrdersSoapBindingResponseDelegate>)aDelegate
	parameters:(purchaseOrdersSvc_createPurchaseOrder *)aParameters
;
@end
@interface purchaseOrdersSoapBinding_getPurchaseOrderDetails : purchaseOrdersSoapBindingOperation {
	purchaseOrdersSvc_getPurchaseOrderDetails * parameters;
}
@property (strong) purchaseOrdersSvc_getPurchaseOrderDetails * parameters;
- (id)initWithBinding:(purchaseOrdersSoapBinding *)aBinding delegate:(id<purchaseOrdersSoapBindingResponseDelegate>)aDelegate
	parameters:(purchaseOrdersSvc_getPurchaseOrderDetails *)aParameters
;
@end
@interface purchaseOrdersSoapBinding_updatePurchaseOrder : purchaseOrdersSoapBindingOperation {
	purchaseOrdersSvc_updatePurchaseOrder * parameters;
}
@property (strong) purchaseOrdersSvc_updatePurchaseOrder * parameters;
- (id)initWithBinding:(purchaseOrdersSoapBinding *)aBinding delegate:(id<purchaseOrdersSoapBindingResponseDelegate>)aDelegate
	parameters:(purchaseOrdersSvc_updatePurchaseOrder *)aParameters
;
@end
@interface purchaseOrdersSoapBinding_envelope : NSObject {
}
+ (purchaseOrdersSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface purchaseOrdersSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end
