#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class WarehouseStockVerificationSvc_getSkuDetails;
@class WarehouseStockVerificationSvc_getSkuDetailsResponse;
@class WarehouseStockVerificationSvc_updateStock;
@class WarehouseStockVerificationSvc_updateStockResponse;
@interface WarehouseStockVerificationSvc_getSkuDetails : NSObject {
	
/* elements */
	NSString * productId;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WarehouseStockVerificationSvc_getSkuDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * productId;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WarehouseStockVerificationSvc_getSkuDetailsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WarehouseStockVerificationSvc_getSkuDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WarehouseStockVerificationSvc_updateStock : NSObject {
	
/* elements */
	NSString * stockVerificationDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WarehouseStockVerificationSvc_updateStock *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * stockVerificationDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WarehouseStockVerificationSvc_updateStockResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WarehouseStockVerificationSvc_updateStockResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "WarehouseStockVerificationSvc.h"
@class WarehouseStockVerificationSoapBinding;
@interface WarehouseStockVerificationSvc : NSObject {
	
}
+ (WarehouseStockVerificationSoapBinding *)WarehouseStockVerificationSoapBinding;
@end
@class WarehouseStockVerificationSoapBindingResponse;
@class WarehouseStockVerificationSoapBindingOperation;
@protocol WarehouseStockVerificationSoapBindingResponseDelegate <NSObject>
- (void) operation:(WarehouseStockVerificationSoapBindingOperation *)operation completedWithResponse:(WarehouseStockVerificationSoapBindingResponse *)response;
@end
@interface WarehouseStockVerificationSoapBinding : NSObject <WarehouseStockVerificationSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(WarehouseStockVerificationSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (WarehouseStockVerificationSoapBindingResponse *)updateStockUsingParameters:(WarehouseStockVerificationSvc_updateStock *)aParameters ;
- (void)updateStockAsyncUsingParameters:(WarehouseStockVerificationSvc_updateStock *)aParameters  delegate:(id<WarehouseStockVerificationSoapBindingResponseDelegate>)responseDelegate;
- (WarehouseStockVerificationSoapBindingResponse *)getSkuDetailsUsingParameters:(WarehouseStockVerificationSvc_getSkuDetails *)aParameters ;
- (void)getSkuDetailsAsyncUsingParameters:(WarehouseStockVerificationSvc_getSkuDetails *)aParameters  delegate:(id<WarehouseStockVerificationSoapBindingResponseDelegate>)responseDelegate;
@end
@interface WarehouseStockVerificationSoapBindingOperation : NSOperation {
	WarehouseStockVerificationSoapBinding *binding;
	WarehouseStockVerificationSoapBindingResponse *response;
	id<WarehouseStockVerificationSoapBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) WarehouseStockVerificationSoapBinding *binding;
@property (readonly) WarehouseStockVerificationSoapBindingResponse *response;
@property (nonatomic, assign) id<WarehouseStockVerificationSoapBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(WarehouseStockVerificationSoapBinding *)aBinding delegate:(id<WarehouseStockVerificationSoapBindingResponseDelegate>)aDelegate;
@end
@interface WarehouseStockVerificationSoapBinding_updateStock : WarehouseStockVerificationSoapBindingOperation {
	WarehouseStockVerificationSvc_updateStock * parameters;
}
@property (retain) WarehouseStockVerificationSvc_updateStock * parameters;
- (id)initWithBinding:(WarehouseStockVerificationSoapBinding *)aBinding delegate:(id<WarehouseStockVerificationSoapBindingResponseDelegate>)aDelegate
	parameters:(WarehouseStockVerificationSvc_updateStock *)aParameters
;
@end
@interface WarehouseStockVerificationSoapBinding_getSkuDetails : WarehouseStockVerificationSoapBindingOperation {
	WarehouseStockVerificationSvc_getSkuDetails * parameters;
}
@property (retain) WarehouseStockVerificationSvc_getSkuDetails * parameters;
- (id)initWithBinding:(WarehouseStockVerificationSoapBinding *)aBinding delegate:(id<WarehouseStockVerificationSoapBindingResponseDelegate>)aDelegate
	parameters:(WarehouseStockVerificationSvc_getSkuDetails *)aParameters
;
@end
@interface WarehouseStockVerificationSoapBinding_envelope : NSObject {
}
+ (WarehouseStockVerificationSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface WarehouseStockVerificationSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
