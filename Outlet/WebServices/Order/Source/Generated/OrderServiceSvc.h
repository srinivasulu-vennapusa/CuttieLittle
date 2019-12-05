#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class OrderServiceSvc_createOrder;
@class OrderServiceSvc_createOrderResponse;
@class OrderServiceSvc_getPreviousOrders;
@class OrderServiceSvc_getPreviousOrdersResponse;
@class OrderServiceSvc_getOrderDetailsByOrderID;
@class OrderServiceSvc_getOrderDetailsByOrderIDResponse;
@class OrderServiceSvc_getOrdersReport;
@class OrderServiceSvc_getOrdersReportResponse;
@class OrderServiceSvc_searchOrdersReportWithPagination;
@class OrderServiceSvc_searchOrdersReportWithPaginationResponse;
@interface OrderServiceSvc_createOrder : NSObject {
	
/* elements */
	NSString * userID;
	NSString * orderDateTime;
	NSString * deliveryDate;
	NSString * deliveryTime;
	NSString * ordererEmail;
	NSString * ordererMobile;
	NSString * ordererAddress;
	NSString * orderTotalPrice;
	NSString * shipmentCharge;
	NSString * shipmentMode;
	NSString * paymentMode;
	NSString * orderItems;
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
@property (retain) NSString * userID;
@property (retain) NSString * orderDateTime;
@property (retain) NSString * deliveryDate;
@property (retain) NSString * deliveryTime;
@property (retain) NSString * ordererEmail;
@property (retain) NSString * ordererMobile;
@property (retain) NSString * ordererAddress;
@property (retain) NSString * orderTotalPrice;
@property (retain) NSString * shipmentCharge;
@property (retain) NSString * shipmentMode;
@property (retain) NSString * paymentMode;
@property (retain) NSString * orderItems;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OrderServiceSvc_createOrderResponse : NSObject {
	
/* elements */
	USBoolean * createOrderReturn;
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
@property (retain) USBoolean * createOrderReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OrderServiceSvc_getPreviousOrders : NSObject {
	
/* elements */
	NSString * userID;
	NSString * pageNumber;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OrderServiceSvc_getPreviousOrders *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * userID;
@property (retain) NSString * pageNumber;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OrderServiceSvc_getPreviousOrdersResponse : NSObject {
	
/* elements */
	NSString * getPreviousOrdersReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OrderServiceSvc_getPreviousOrdersResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * getPreviousOrdersReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OrderServiceSvc_getOrderDetailsByOrderID : NSObject {
	
/* elements */
	NSString * orderID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OrderServiceSvc_getOrderDetailsByOrderID *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * orderID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OrderServiceSvc_getOrderDetailsByOrderIDResponse : NSObject {
	
/* elements */
	NSString * getOrderDetailsByOrderIDReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OrderServiceSvc_getOrderDetailsByOrderIDResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * getOrderDetailsByOrderIDReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OrderServiceSvc_getOrdersReport : NSObject {
	
/* elements */
	NSString * reportByDate;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OrderServiceSvc_getOrdersReport *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * reportByDate;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OrderServiceSvc_getOrdersReportResponse : NSObject {
	
/* elements */
	NSString * getOrdersReportReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OrderServiceSvc_getOrdersReportResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * getOrdersReportReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OrderServiceSvc_searchOrdersReportWithPagination : NSObject {
	
/* elements */
	NSString * searchCriteria;
	NSString * pageNumber;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OrderServiceSvc_searchOrdersReportWithPagination *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * searchCriteria;
@property (retain) NSString * pageNumber;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OrderServiceSvc_searchOrdersReportWithPaginationResponse : NSObject {
	
/* elements */
	NSString * searchOrdersReportWithPaginationReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OrderServiceSvc_searchOrdersReportWithPaginationResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * searchOrdersReportWithPaginationReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "ns1.h"
#import "OrderServiceSvc.h"
@class OrderSoapBinding;
@interface OrderServiceSvc : NSObject {
	
}
+ (OrderSoapBinding *)OrderSoapBinding;
@end
@class OrderSoapBindingResponse;
@class OrderSoapBindingOperation;
@protocol OrderSoapBindingResponseDelegate <NSObject>
- (void) operation:(OrderSoapBindingOperation *)operation completedWithResponse:(OrderSoapBindingResponse *)response;
@end
@interface OrderSoapBinding : NSObject <OrderSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(OrderSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (OrderSoapBindingResponse *)createOrderUsingParameters:(OrderServiceSvc_createOrder *)aParameters ;
- (void)createOrderAsyncUsingParameters:(OrderServiceSvc_createOrder *)aParameters  delegate:(id<OrderSoapBindingResponseDelegate>)responseDelegate;
- (OrderSoapBindingResponse *)getPreviousOrdersUsingParameters:(OrderServiceSvc_getPreviousOrders *)aParameters ;
- (void)getPreviousOrdersAsyncUsingParameters:(OrderServiceSvc_getPreviousOrders *)aParameters  delegate:(id<OrderSoapBindingResponseDelegate>)responseDelegate;
- (OrderSoapBindingResponse *)getOrderDetailsByOrderIDUsingParameters:(OrderServiceSvc_getOrderDetailsByOrderID *)aParameters ;
- (void)getOrderDetailsByOrderIDAsyncUsingParameters:(OrderServiceSvc_getOrderDetailsByOrderID *)aParameters  delegate:(id<OrderSoapBindingResponseDelegate>)responseDelegate;
- (OrderSoapBindingResponse *)getOrdersReportUsingParameters:(OrderServiceSvc_getOrdersReport *)aParameters ;
- (void)getOrdersReportAsyncUsingParameters:(OrderServiceSvc_getOrdersReport *)aParameters  delegate:(id<OrderSoapBindingResponseDelegate>)responseDelegate;
- (OrderSoapBindingResponse *)searchOrdersReportWithPaginationUsingParameters:(OrderServiceSvc_searchOrdersReportWithPagination *)aParameters ;
- (void)searchOrdersReportWithPaginationAsyncUsingParameters:(OrderServiceSvc_searchOrdersReportWithPagination *)aParameters  delegate:(id<OrderSoapBindingResponseDelegate>)responseDelegate;
@end
@interface OrderSoapBindingOperation : NSOperation {
	OrderSoapBinding *binding;
	OrderSoapBindingResponse *response;
	id<OrderSoapBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) OrderSoapBinding *binding;
@property (readonly) OrderSoapBindingResponse *response;
@property (nonatomic, assign) id<OrderSoapBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(OrderSoapBinding *)aBinding delegate:(id<OrderSoapBindingResponseDelegate>)aDelegate;
@end
@interface OrderSoapBinding_createOrder : OrderSoapBindingOperation {
	OrderServiceSvc_createOrder * parameters;
}
@property (retain) OrderServiceSvc_createOrder * parameters;
- (id)initWithBinding:(OrderSoapBinding *)aBinding delegate:(id<OrderSoapBindingResponseDelegate>)aDelegate
	parameters:(OrderServiceSvc_createOrder *)aParameters
;
@end
@interface OrderSoapBinding_getPreviousOrders : OrderSoapBindingOperation {
	OrderServiceSvc_getPreviousOrders * parameters;
}
@property (retain) OrderServiceSvc_getPreviousOrders * parameters;
- (id)initWithBinding:(OrderSoapBinding *)aBinding delegate:(id<OrderSoapBindingResponseDelegate>)aDelegate
	parameters:(OrderServiceSvc_getPreviousOrders *)aParameters
;
@end
@interface OrderSoapBinding_getOrderDetailsByOrderID : OrderSoapBindingOperation {
	OrderServiceSvc_getOrderDetailsByOrderID * parameters;
}
@property (retain) OrderServiceSvc_getOrderDetailsByOrderID * parameters;
- (id)initWithBinding:(OrderSoapBinding *)aBinding delegate:(id<OrderSoapBindingResponseDelegate>)aDelegate
	parameters:(OrderServiceSvc_getOrderDetailsByOrderID *)aParameters
;
@end
@interface OrderSoapBinding_getOrdersReport : OrderSoapBindingOperation {
	OrderServiceSvc_getOrdersReport * parameters;
}
@property (retain) OrderServiceSvc_getOrdersReport * parameters;
- (id)initWithBinding:(OrderSoapBinding *)aBinding delegate:(id<OrderSoapBindingResponseDelegate>)aDelegate
	parameters:(OrderServiceSvc_getOrdersReport *)aParameters
;
@end
@interface OrderSoapBinding_searchOrdersReportWithPagination : OrderSoapBindingOperation {
	OrderServiceSvc_searchOrdersReportWithPagination * parameters;
}
@property (retain) OrderServiceSvc_searchOrdersReportWithPagination * parameters;
- (id)initWithBinding:(OrderSoapBinding *)aBinding delegate:(id<OrderSoapBindingResponseDelegate>)aDelegate
	parameters:(OrderServiceSvc_searchOrdersReportWithPagination *)aParameters
;
@end
@interface OrderSoapBinding_envelope : NSObject {
}
+ (OrderSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface OrderSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
