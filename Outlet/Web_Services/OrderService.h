#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class OrderService_createOrder;
@class OrderService_createOrderResponse;
@class OrderService_getOrderDetails;
@class OrderService_getOrderDetailsResponse;
@class OrderService_getOrdersByPage;
@class OrderService_getOrdersByPageResponse;
@interface OrderService_createOrder : NSObject {
	
/* elements */
	NSString * OrderDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OrderService_createOrder *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * OrderDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OrderService_createOrderResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OrderService_createOrderResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OrderService_getOrderDetails : NSObject {
	
/* elements */
	NSString * arg0;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OrderService_getOrderDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * arg0;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OrderService_getOrderDetailsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OrderService_getOrderDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OrderService_getOrdersByPage : NSObject {
	
/* elements */
	NSString * arg0;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OrderService_getOrdersByPage *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * arg0;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OrderService_getOrdersByPageResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OrderService_getOrdersByPageResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "OrderService.h"
@class OrderServiceSoapBinding;
@interface OrderService : NSObject {
	
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
- (OrderServiceSoapBindingResponse *)getOrderDetailsUsingParameters:(OrderService_getOrderDetails *)aParameters ;
- (void)getOrderDetailsAsyncUsingParameters:(OrderService_getOrderDetails *)aParameters  delegate:(id<OrderServiceSoapBindingResponseDelegate>)responseDelegate;
- (OrderServiceSoapBindingResponse *)getOrdersByPageUsingParameters:(OrderService_getOrdersByPage *)aParameters ;
- (void)getOrdersByPageAsyncUsingParameters:(OrderService_getOrdersByPage *)aParameters  delegate:(id<OrderServiceSoapBindingResponseDelegate>)responseDelegate;
- (OrderServiceSoapBindingResponse *)createOrderUsingParameters:(OrderService_createOrder *)aParameters ;
- (void)createOrderAsyncUsingParameters:(OrderService_createOrder *)aParameters  delegate:(id<OrderServiceSoapBindingResponseDelegate>)responseDelegate;
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
@property (nonatomic, assign) id<OrderServiceSoapBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(OrderServiceSoapBinding *)aBinding delegate:(id<OrderServiceSoapBindingResponseDelegate>)aDelegate;
@end
@interface OrderServiceSoapBinding_getOrderDetails : OrderServiceSoapBindingOperation {
	OrderService_getOrderDetails * parameters;
}
@property (retain) OrderService_getOrderDetails * parameters;
- (id)initWithBinding:(OrderServiceSoapBinding *)aBinding delegate:(id<OrderServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(OrderService_getOrderDetails *)aParameters
;
@end
@interface OrderServiceSoapBinding_getOrdersByPage : OrderServiceSoapBindingOperation {
	OrderService_getOrdersByPage * parameters;
}
@property (retain) OrderService_getOrdersByPage * parameters;
- (id)initWithBinding:(OrderServiceSoapBinding *)aBinding delegate:(id<OrderServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(OrderService_getOrdersByPage *)aParameters
;
@end
@interface OrderServiceSoapBinding_createOrder : OrderServiceSoapBindingOperation {
	OrderService_createOrder * parameters;
}
@property (retain) OrderService_createOrder * parameters;
- (id)initWithBinding:(OrderServiceSoapBinding *)aBinding delegate:(id<OrderServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(OrderService_createOrder *)aParameters
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
