#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class OrderServiceSvc_cancelOrder;
@class OrderServiceSvc_cancelOrderResponse;
@class OrderServiceSvc_createOrder;
@class OrderServiceSvc_createOrderResponse;
@class OrderServiceSvc_getCustomerOrders;
@class OrderServiceSvc_getCustomerOrdersResponse;
@class OrderServiceSvc_getOrderDetails;
@class OrderServiceSvc_getOrderDetailsResponse;
@class OrderServiceSvc_getOrders;
@class OrderServiceSvc_getOrdersResponse;
@class OrderServiceSvc_getOrdersSummary;
@class OrderServiceSvc_getOrdersSummaryResponse;
@class OrderServiceSvc_searchOrders;
@class OrderServiceSvc_searchOrdersResponse;
@class OrderServiceSvc_updateOrder;
@class OrderServiceSvc_updateOrderResponse;
@interface OrderServiceSvc_cancelOrder : NSObject {
	
/* elements */
	NSString * orderDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OrderServiceSvc_cancelOrder *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * orderDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OrderServiceSvc_cancelOrderResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OrderServiceSvc_cancelOrderResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OrderServiceSvc_createOrder : NSObject {
	
/* elements */
	NSString * orderDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OrderServiceSvc_createOrder *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * orderDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OrderServiceSvc_createOrderResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OrderServiceSvc_createOrderResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OrderServiceSvc_getCustomerOrders : NSObject {
	
/* elements */
	NSString * customerDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OrderServiceSvc_getCustomerOrders *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * customerDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OrderServiceSvc_getCustomerOrdersResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OrderServiceSvc_getCustomerOrdersResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OrderServiceSvc_getOrderDetails : NSObject {
	
/* elements */
	NSString * orderDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OrderServiceSvc_getOrderDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * orderDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OrderServiceSvc_getOrderDetailsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OrderServiceSvc_getOrderDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OrderServiceSvc_getOrders : NSObject {
	
/* elements */
	NSString * orderDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OrderServiceSvc_getOrders *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * orderDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OrderServiceSvc_getOrdersResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OrderServiceSvc_getOrdersResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OrderServiceSvc_getOrdersSummary : NSObject {
	
/* elements */
	NSString * customerDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OrderServiceSvc_getOrdersSummary *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * customerDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OrderServiceSvc_getOrdersSummaryResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OrderServiceSvc_getOrdersSummaryResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OrderServiceSvc_searchOrders : NSObject {
	
/* elements */
	NSString * searchCriteria;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OrderServiceSvc_searchOrders *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * searchCriteria;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OrderServiceSvc_searchOrdersResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OrderServiceSvc_searchOrdersResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OrderServiceSvc_updateOrder : NSObject {
	
/* elements */
	NSString * orderDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OrderServiceSvc_updateOrder *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * orderDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OrderServiceSvc_updateOrderResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OrderServiceSvc_updateOrderResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "OrderServiceSvc.h"
@class OrderServiceSoapBinding;
@interface OrderServiceSvc : NSObject {
	
}
+ (OrderServiceSoapBinding *)OrderServiceSoapBinding;
@end
@class OrderServiceSoapBindingResponse;
@class OrderServiceSoapBindingOperation;
@protocol OrderServiceSoapBindingResponseDelegate <NSObject>
- (void) operation:(OrderServiceSoapBindingOperation *)operation completedWithResponse:(OrderServiceSoapBindingResponse *)response;
@end
@interface OrderServiceSoapBinding : NSObject <OrderServiceSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(OrderServiceSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (OrderServiceSoapBindingResponse *)updateOrderUsingParameters:(OrderServiceSvc_updateOrder *)aParameters ;
- (void)updateOrderAsyncUsingParameters:(OrderServiceSvc_updateOrder *)aParameters  delegate:(id<OrderServiceSoapBindingResponseDelegate>)responseDelegate;
- (OrderServiceSoapBindingResponse *)searchOrdersUsingParameters:(OrderServiceSvc_searchOrders *)aParameters ;
- (void)searchOrdersAsyncUsingParameters:(OrderServiceSvc_searchOrders *)aParameters  delegate:(id<OrderServiceSoapBindingResponseDelegate>)responseDelegate;
- (OrderServiceSoapBindingResponse *)getOrdersUsingParameters:(OrderServiceSvc_getOrders *)aParameters ;
- (void)getOrdersAsyncUsingParameters:(OrderServiceSvc_getOrders *)aParameters  delegate:(id<OrderServiceSoapBindingResponseDelegate>)responseDelegate;
- (OrderServiceSoapBindingResponse *)getOrderDetailsUsingParameters:(OrderServiceSvc_getOrderDetails *)aParameters ;
- (void)getOrderDetailsAsyncUsingParameters:(OrderServiceSvc_getOrderDetails *)aParameters  delegate:(id<OrderServiceSoapBindingResponseDelegate>)responseDelegate;
- (OrderServiceSoapBindingResponse *)createOrderUsingParameters:(OrderServiceSvc_createOrder *)aParameters ;
- (void)createOrderAsyncUsingParameters:(OrderServiceSvc_createOrder *)aParameters  delegate:(id<OrderServiceSoapBindingResponseDelegate>)responseDelegate;
- (OrderServiceSoapBindingResponse *)getCustomerOrdersUsingParameters:(OrderServiceSvc_getCustomerOrders *)aParameters ;
- (void)getCustomerOrdersAsyncUsingParameters:(OrderServiceSvc_getCustomerOrders *)aParameters  delegate:(id<OrderServiceSoapBindingResponseDelegate>)responseDelegate;
- (OrderServiceSoapBindingResponse *)getOrdersSummaryUsingParameters:(OrderServiceSvc_getOrdersSummary *)aParameters ;
- (void)getOrdersSummaryAsyncUsingParameters:(OrderServiceSvc_getOrdersSummary *)aParameters  delegate:(id<OrderServiceSoapBindingResponseDelegate>)responseDelegate;
- (OrderServiceSoapBindingResponse *)cancelOrderUsingParameters:(OrderServiceSvc_cancelOrder *)aParameters ;
- (void)cancelOrderAsyncUsingParameters:(OrderServiceSvc_cancelOrder *)aParameters  delegate:(id<OrderServiceSoapBindingResponseDelegate>)responseDelegate;
@end
@interface OrderServiceSoapBindingOperation : NSOperation {
	OrderServiceSoapBinding *binding;
	OrderServiceSoapBindingResponse *response;
	id<OrderServiceSoapBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) OrderServiceSoapBinding *binding;
@property (readonly) OrderServiceSoapBindingResponse *response;
@property (nonatomic, strong) id<OrderServiceSoapBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(OrderServiceSoapBinding *)aBinding delegate:(id<OrderServiceSoapBindingResponseDelegate>)aDelegate;
@end
@interface OrderServiceSoapBinding_updateOrder : OrderServiceSoapBindingOperation {
	OrderServiceSvc_updateOrder * parameters;
}
@property (retain) OrderServiceSvc_updateOrder * parameters;
- (id)initWithBinding:(OrderServiceSoapBinding *)aBinding delegate:(id<OrderServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(OrderServiceSvc_updateOrder *)aParameters
;
@end
@interface OrderServiceSoapBinding_searchOrders : OrderServiceSoapBindingOperation {
	OrderServiceSvc_searchOrders * parameters;
}
@property (retain) OrderServiceSvc_searchOrders * parameters;
- (id)initWithBinding:(OrderServiceSoapBinding *)aBinding delegate:(id<OrderServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(OrderServiceSvc_searchOrders *)aParameters
;
@end
@interface OrderServiceSoapBinding_getOrders : OrderServiceSoapBindingOperation {
	OrderServiceSvc_getOrders * parameters;
}
@property (retain) OrderServiceSvc_getOrders * parameters;
- (id)initWithBinding:(OrderServiceSoapBinding *)aBinding delegate:(id<OrderServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(OrderServiceSvc_getOrders *)aParameters
;
@end
@interface OrderServiceSoapBinding_getOrderDetails : OrderServiceSoapBindingOperation {
	OrderServiceSvc_getOrderDetails * parameters;
}
@property (retain) OrderServiceSvc_getOrderDetails * parameters;
- (id)initWithBinding:(OrderServiceSoapBinding *)aBinding delegate:(id<OrderServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(OrderServiceSvc_getOrderDetails *)aParameters
;
@end
@interface OrderServiceSoapBinding_createOrder : OrderServiceSoapBindingOperation {
	OrderServiceSvc_createOrder * parameters;
}
@property (retain) OrderServiceSvc_createOrder * parameters;
- (id)initWithBinding:(OrderServiceSoapBinding *)aBinding delegate:(id<OrderServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(OrderServiceSvc_createOrder *)aParameters
;
@end
@interface OrderServiceSoapBinding_getCustomerOrders : OrderServiceSoapBindingOperation {
	OrderServiceSvc_getCustomerOrders * parameters;
}
@property (retain) OrderServiceSvc_getCustomerOrders * parameters;
- (id)initWithBinding:(OrderServiceSoapBinding *)aBinding delegate:(id<OrderServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(OrderServiceSvc_getCustomerOrders *)aParameters
;
@end
@interface OrderServiceSoapBinding_getOrdersSummary : OrderServiceSoapBindingOperation {
	OrderServiceSvc_getOrdersSummary * parameters;
}
@property (retain) OrderServiceSvc_getOrdersSummary * parameters;
- (id)initWithBinding:(OrderServiceSoapBinding *)aBinding delegate:(id<OrderServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(OrderServiceSvc_getOrdersSummary *)aParameters
;
@end
@interface OrderServiceSoapBinding_cancelOrder : OrderServiceSoapBindingOperation {
	OrderServiceSvc_cancelOrder * parameters;
}
@property (retain) OrderServiceSvc_cancelOrder * parameters;
- (id)initWithBinding:(OrderServiceSoapBinding *)aBinding delegate:(id<OrderServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(OrderServiceSvc_cancelOrder *)aParameters
;
@end
@interface OrderServiceSoapBinding_envelope : NSObject {
}
+ (OrderServiceSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface OrderServiceSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
