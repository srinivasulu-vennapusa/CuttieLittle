#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class WHPurchaseOrders_createPurchaseOrder;
@class WHPurchaseOrders_createPurchaseOrderResponse;
@class WHPurchaseOrders_deletePurchaseOrder;
@class WHPurchaseOrders_deletePurchaseOrderResponse;
@class WHPurchaseOrders_getPurchaseOrderDetails;
@class WHPurchaseOrders_getPurchaseOrderDetailsResponse;
@class WHPurchaseOrders_getPurchaseOrders;
@class WHPurchaseOrders_getPurchaseOrdersResponse;
@class WHPurchaseOrders_updatePurchaseOrder;
@class WHPurchaseOrders_updatePurchaseOrderResponse;
@interface WHPurchaseOrders_createPurchaseOrder : NSObject {
	
/* elements */
	NSString * orderDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHPurchaseOrders_createPurchaseOrder *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * orderDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHPurchaseOrders_createPurchaseOrderResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHPurchaseOrders_createPurchaseOrderResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHPurchaseOrders_deletePurchaseOrder : NSObject {
	
/* elements */
	NSString * orderDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHPurchaseOrders_deletePurchaseOrder *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * orderDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHPurchaseOrders_deletePurchaseOrderResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHPurchaseOrders_deletePurchaseOrderResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHPurchaseOrders_getPurchaseOrderDetails : NSObject {
	
/* elements */
	NSString * orderDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHPurchaseOrders_getPurchaseOrderDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * orderDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHPurchaseOrders_getPurchaseOrderDetailsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHPurchaseOrders_getPurchaseOrderDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHPurchaseOrders_getPurchaseOrders : NSObject {
	
/* elements */
	NSString * orderDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHPurchaseOrders_getPurchaseOrders *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * orderDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHPurchaseOrders_getPurchaseOrdersResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHPurchaseOrders_getPurchaseOrdersResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHPurchaseOrders_updatePurchaseOrder : NSObject {
	
/* elements */
	NSString * orderDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHPurchaseOrders_updatePurchaseOrder *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * orderDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHPurchaseOrders_updatePurchaseOrderResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHPurchaseOrders_updatePurchaseOrderResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "xs.h"
#import "WHPurchaseOrders.h"
@class WHPurchaseOrdersSoapBinding;
@interface WHPurchaseOrders : NSObject {
	
}
+ (WHPurchaseOrdersSoapBinding *)WHPurchaseOrdersSoapBinding;
@end
@class WHPurchaseOrdersSoapBindingResponse;
@class WHPurchaseOrdersSoapBindingOperation;
@protocol WHPurchaseOrdersSoapBindingResponseDelegate <NSObject>
- (void) operation:(WHPurchaseOrdersSoapBindingOperation *)operation completedWithResponse:(WHPurchaseOrdersSoapBindingResponse *)response;
@end
@interface WHPurchaseOrdersSoapBinding : NSObject <WHPurchaseOrdersSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(WHPurchaseOrdersSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (WHPurchaseOrdersSoapBindingResponse *)getPurchaseOrdersUsingParameters:(WHPurchaseOrders_getPurchaseOrders *)aParameters ;
- (void)getPurchaseOrdersAsyncUsingParameters:(WHPurchaseOrders_getPurchaseOrders *)aParameters  delegate:(id<WHPurchaseOrdersSoapBindingResponseDelegate>)responseDelegate;
- (WHPurchaseOrdersSoapBindingResponse *)deletePurchaseOrderUsingParameters:(WHPurchaseOrders_deletePurchaseOrder *)aParameters ;
- (void)deletePurchaseOrderAsyncUsingParameters:(WHPurchaseOrders_deletePurchaseOrder *)aParameters  delegate:(id<WHPurchaseOrdersSoapBindingResponseDelegate>)responseDelegate;
- (WHPurchaseOrdersSoapBindingResponse *)createPurchaseOrderUsingParameters:(WHPurchaseOrders_createPurchaseOrder *)aParameters ;
- (void)createPurchaseOrderAsyncUsingParameters:(WHPurchaseOrders_createPurchaseOrder *)aParameters  delegate:(id<WHPurchaseOrdersSoapBindingResponseDelegate>)responseDelegate;
- (WHPurchaseOrdersSoapBindingResponse *)getPurchaseOrderDetailsUsingParameters:(WHPurchaseOrders_getPurchaseOrderDetails *)aParameters ;
- (void)getPurchaseOrderDetailsAsyncUsingParameters:(WHPurchaseOrders_getPurchaseOrderDetails *)aParameters  delegate:(id<WHPurchaseOrdersSoapBindingResponseDelegate>)responseDelegate;
- (WHPurchaseOrdersSoapBindingResponse *)updatePurchaseOrderUsingParameters:(WHPurchaseOrders_updatePurchaseOrder *)aParameters ;
- (void)updatePurchaseOrderAsyncUsingParameters:(WHPurchaseOrders_updatePurchaseOrder *)aParameters  delegate:(id<WHPurchaseOrdersSoapBindingResponseDelegate>)responseDelegate;
@end
@interface WHPurchaseOrdersSoapBindingOperation : NSOperation {
	WHPurchaseOrdersSoapBinding *binding;
	WHPurchaseOrdersSoapBindingResponse *response;
	id<WHPurchaseOrdersSoapBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) WHPurchaseOrdersSoapBinding *binding;
@property (readonly) WHPurchaseOrdersSoapBindingResponse *response;
@property (nonatomic, assign) id<WHPurchaseOrdersSoapBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(WHPurchaseOrdersSoapBinding *)aBinding delegate:(id<WHPurchaseOrdersSoapBindingResponseDelegate>)aDelegate;
@end
@interface WHPurchaseOrdersSoapBinding_getPurchaseOrders : WHPurchaseOrdersSoapBindingOperation {
	WHPurchaseOrders_getPurchaseOrders * parameters;
}
@property (retain) WHPurchaseOrders_getPurchaseOrders * parameters;
- (id)initWithBinding:(WHPurchaseOrdersSoapBinding *)aBinding delegate:(id<WHPurchaseOrdersSoapBindingResponseDelegate>)aDelegate
	parameters:(WHPurchaseOrders_getPurchaseOrders *)aParameters
;
@end
@interface WHPurchaseOrdersSoapBinding_deletePurchaseOrder : WHPurchaseOrdersSoapBindingOperation {
	WHPurchaseOrders_deletePurchaseOrder * parameters;
}
@property (retain) WHPurchaseOrders_deletePurchaseOrder * parameters;
- (id)initWithBinding:(WHPurchaseOrdersSoapBinding *)aBinding delegate:(id<WHPurchaseOrdersSoapBindingResponseDelegate>)aDelegate
	parameters:(WHPurchaseOrders_deletePurchaseOrder *)aParameters
;
@end
@interface WHPurchaseOrdersSoapBinding_createPurchaseOrder : WHPurchaseOrdersSoapBindingOperation {
	WHPurchaseOrders_createPurchaseOrder * parameters;
}
@property (retain) WHPurchaseOrders_createPurchaseOrder * parameters;
- (id)initWithBinding:(WHPurchaseOrdersSoapBinding *)aBinding delegate:(id<WHPurchaseOrdersSoapBindingResponseDelegate>)aDelegate
	parameters:(WHPurchaseOrders_createPurchaseOrder *)aParameters
;
@end
@interface WHPurchaseOrdersSoapBinding_getPurchaseOrderDetails : WHPurchaseOrdersSoapBindingOperation {
	WHPurchaseOrders_getPurchaseOrderDetails * parameters;
}
@property (retain) WHPurchaseOrders_getPurchaseOrderDetails * parameters;
- (id)initWithBinding:(WHPurchaseOrdersSoapBinding *)aBinding delegate:(id<WHPurchaseOrdersSoapBindingResponseDelegate>)aDelegate
	parameters:(WHPurchaseOrders_getPurchaseOrderDetails *)aParameters
;
@end
@interface WHPurchaseOrdersSoapBinding_updatePurchaseOrder : WHPurchaseOrdersSoapBindingOperation {
	WHPurchaseOrders_updatePurchaseOrder * parameters;
}
@property (retain) WHPurchaseOrders_updatePurchaseOrder * parameters;
- (id)initWithBinding:(WHPurchaseOrdersSoapBinding *)aBinding delegate:(id<WHPurchaseOrdersSoapBindingResponseDelegate>)aDelegate
	parameters:(WHPurchaseOrders_updatePurchaseOrder *)aParameters
;
@end
@interface WHPurchaseOrdersSoapBinding_envelope : NSObject {
}
+ (WHPurchaseOrdersSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface WHPurchaseOrdersSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
