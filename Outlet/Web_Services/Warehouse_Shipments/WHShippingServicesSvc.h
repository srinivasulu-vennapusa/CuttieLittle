#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class WHShippingServicesSvc_createShipment;
@class WHShippingServicesSvc_createShipmentResponse;
@class WHShippingServicesSvc_getShipmentDetails;
@class WHShippingServicesSvc_getShipmentDetailsResponse;
@class WHShippingServicesSvc_getShipmentIds;
@class WHShippingServicesSvc_getShipmentIdsResponse;
@class WHShippingServicesSvc_getShipments;
@class WHShippingServicesSvc_getShipmentsResponse;
@class WHShippingServicesSvc_updateShipment;
@class WHShippingServicesSvc_updateShipmentResponse;
@interface WHShippingServicesSvc_createShipment : NSObject {
	
/* elements */
	NSString * shipmentDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHShippingServicesSvc_createShipment *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * shipmentDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHShippingServicesSvc_createShipmentResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHShippingServicesSvc_createShipmentResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHShippingServicesSvc_getShipmentDetails : NSObject {
	
/* elements */
	NSString * shipmentDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHShippingServicesSvc_getShipmentDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * shipmentDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHShippingServicesSvc_getShipmentDetailsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHShippingServicesSvc_getShipmentDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHShippingServicesSvc_getShipmentIds : NSObject {
	
/* elements */
	NSString * shipmentDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHShippingServicesSvc_getShipmentIds *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * shipmentDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHShippingServicesSvc_getShipmentIdsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHShippingServicesSvc_getShipmentIdsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHShippingServicesSvc_getShipments : NSObject {
	
/* elements */
	NSString * shipmentDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHShippingServicesSvc_getShipments *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * shipmentDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHShippingServicesSvc_getShipmentsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHShippingServicesSvc_getShipmentsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHShippingServicesSvc_updateShipment : NSObject {
	
/* elements */
	NSString * shipmentDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHShippingServicesSvc_updateShipment *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * shipmentDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHShippingServicesSvc_updateShipmentResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHShippingServicesSvc_updateShipmentResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "WHShippingServicesSvc.h"
@class WHShippingServicesSoapBinding;
@interface WHShippingServicesSvc : NSObject {
	
}
+ (WHShippingServicesSoapBinding *)WHShippingServicesSoapBinding;
@end
@class WHShippingServicesSoapBindingResponse;
@class WHShippingServicesSoapBindingOperation;
@protocol WHShippingServicesSoapBindingResponseDelegate <NSObject>
- (void) operation:(WHShippingServicesSoapBindingOperation *)operation completedWithResponse:(WHShippingServicesSoapBindingResponse *)response;
@end
@interface WHShippingServicesSoapBinding : NSObject <WHShippingServicesSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(WHShippingServicesSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (WHShippingServicesSoapBindingResponse *)getShipmentDetailsUsingParameters:(WHShippingServicesSvc_getShipmentDetails *)aParameters ;
- (void)getShipmentDetailsAsyncUsingParameters:(WHShippingServicesSvc_getShipmentDetails *)aParameters  delegate:(id<WHShippingServicesSoapBindingResponseDelegate>)responseDelegate;
- (WHShippingServicesSoapBindingResponse *)createShipmentUsingParameters:(WHShippingServicesSvc_createShipment *)aParameters ;
- (void)createShipmentAsyncUsingParameters:(WHShippingServicesSvc_createShipment *)aParameters  delegate:(id<WHShippingServicesSoapBindingResponseDelegate>)responseDelegate;
- (WHShippingServicesSoapBindingResponse *)updateShipmentUsingParameters:(WHShippingServicesSvc_updateShipment *)aParameters ;
- (void)updateShipmentAsyncUsingParameters:(WHShippingServicesSvc_updateShipment *)aParameters  delegate:(id<WHShippingServicesSoapBindingResponseDelegate>)responseDelegate;
- (WHShippingServicesSoapBindingResponse *)getShipmentsUsingParameters:(WHShippingServicesSvc_getShipments *)aParameters ;
- (void)getShipmentsAsyncUsingParameters:(WHShippingServicesSvc_getShipments *)aParameters  delegate:(id<WHShippingServicesSoapBindingResponseDelegate>)responseDelegate;
- (WHShippingServicesSoapBindingResponse *)getShipmentIdsUsingParameters:(WHShippingServicesSvc_getShipmentIds *)aParameters ;
- (void)getShipmentIdsAsyncUsingParameters:(WHShippingServicesSvc_getShipmentIds *)aParameters  delegate:(id<WHShippingServicesSoapBindingResponseDelegate>)responseDelegate;
@end
@interface WHShippingServicesSoapBindingOperation : NSOperation {
	WHShippingServicesSoapBinding *binding;
	WHShippingServicesSoapBindingResponse *response;
	id<WHShippingServicesSoapBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) WHShippingServicesSoapBinding *binding;
@property (readonly) WHShippingServicesSoapBindingResponse *response;
@property (nonatomic, assign) id<WHShippingServicesSoapBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(WHShippingServicesSoapBinding *)aBinding delegate:(id<WHShippingServicesSoapBindingResponseDelegate>)aDelegate;
@end
@interface WHShippingServicesSoapBinding_getShipmentDetails : WHShippingServicesSoapBindingOperation {
	WHShippingServicesSvc_getShipmentDetails * parameters;
}
@property (retain) WHShippingServicesSvc_getShipmentDetails * parameters;
- (id)initWithBinding:(WHShippingServicesSoapBinding *)aBinding delegate:(id<WHShippingServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(WHShippingServicesSvc_getShipmentDetails *)aParameters
;
@end
@interface WHShippingServicesSoapBinding_createShipment : WHShippingServicesSoapBindingOperation {
	WHShippingServicesSvc_createShipment * parameters;
}
@property (retain) WHShippingServicesSvc_createShipment * parameters;
- (id)initWithBinding:(WHShippingServicesSoapBinding *)aBinding delegate:(id<WHShippingServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(WHShippingServicesSvc_createShipment *)aParameters
;
@end
@interface WHShippingServicesSoapBinding_updateShipment : WHShippingServicesSoapBindingOperation {
	WHShippingServicesSvc_updateShipment * parameters;
}
@property (retain) WHShippingServicesSvc_updateShipment * parameters;
- (id)initWithBinding:(WHShippingServicesSoapBinding *)aBinding delegate:(id<WHShippingServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(WHShippingServicesSvc_updateShipment *)aParameters
;
@end
@interface WHShippingServicesSoapBinding_getShipments : WHShippingServicesSoapBindingOperation {
	WHShippingServicesSvc_getShipments * parameters;
}
@property (retain) WHShippingServicesSvc_getShipments * parameters;
- (id)initWithBinding:(WHShippingServicesSoapBinding *)aBinding delegate:(id<WHShippingServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(WHShippingServicesSvc_getShipments *)aParameters
;
@end
@interface WHShippingServicesSoapBinding_getShipmentIds : WHShippingServicesSoapBindingOperation {
	WHShippingServicesSvc_getShipmentIds * parameters;
}
@property (retain) WHShippingServicesSvc_getShipmentIds * parameters;
- (id)initWithBinding:(WHShippingServicesSoapBinding *)aBinding delegate:(id<WHShippingServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(WHShippingServicesSvc_getShipmentIds *)aParameters
;
@end
@interface WHShippingServicesSoapBinding_envelope : NSObject {
}
+ (WHShippingServicesSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface WHShippingServicesSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
