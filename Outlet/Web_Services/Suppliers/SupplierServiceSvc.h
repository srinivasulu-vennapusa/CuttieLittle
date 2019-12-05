#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class SupplierServiceSvc_createSupplier;
@class SupplierServiceSvc_createSupplierResponse;
@class SupplierServiceSvc_deleteSupplier;
@class SupplierServiceSvc_deleteSupplierResponse;
@class SupplierServiceSvc_getSuppliers;
@class SupplierServiceSvc_getSuppliersResponse;
@class SupplierServiceSvc_updateSupplier;
@class SupplierServiceSvc_updateSupplierResponse;
@interface SupplierServiceSvc_createSupplier : NSObject {
	
/* elements */
	NSString * supplierDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupplierServiceSvc_createSupplier *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * supplierDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupplierServiceSvc_createSupplierResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupplierServiceSvc_createSupplierResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupplierServiceSvc_deleteSupplier : NSObject {
	
/* elements */
	NSString * supplierDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupplierServiceSvc_deleteSupplier *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * supplierDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupplierServiceSvc_deleteSupplierResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupplierServiceSvc_deleteSupplierResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupplierServiceSvc_getSuppliers : NSObject {
	
/* elements */
	NSString * supplierDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupplierServiceSvc_getSuppliers *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * supplierDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupplierServiceSvc_getSuppliersResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupplierServiceSvc_getSuppliersResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupplierServiceSvc_updateSupplier : NSObject {
	
/* elements */
	NSString * supplierDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupplierServiceSvc_updateSupplier *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * supplierDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SupplierServiceSvc_updateSupplierResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SupplierServiceSvc_updateSupplierResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "SupplierServiceSvc.h"
@class SupplierServiceSoapBinding;
@interface SupplierServiceSvc : NSObject {
	
}
+ (SupplierServiceSoapBinding *)SupplierServiceSoapBinding;
@end
@class SupplierServiceSoapBindingResponse;
@class SupplierServiceSoapBindingOperation;
@protocol SupplierServiceSoapBindingResponseDelegate <NSObject>
- (void) operation:(SupplierServiceSoapBindingOperation *)operation completedWithResponse:(SupplierServiceSoapBindingResponse *)response;
@end
@interface SupplierServiceSoapBinding : NSObject <SupplierServiceSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(SupplierServiceSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (SupplierServiceSoapBindingResponse *)getSuppliersUsingParameters:(SupplierServiceSvc_getSuppliers *)aParameters ;
- (void)getSuppliersAsyncUsingParameters:(SupplierServiceSvc_getSuppliers *)aParameters  delegate:(id<SupplierServiceSoapBindingResponseDelegate>)responseDelegate;
- (SupplierServiceSoapBindingResponse *)updateSupplierUsingParameters:(SupplierServiceSvc_updateSupplier *)aParameters ;
- (void)updateSupplierAsyncUsingParameters:(SupplierServiceSvc_updateSupplier *)aParameters  delegate:(id<SupplierServiceSoapBindingResponseDelegate>)responseDelegate;
- (SupplierServiceSoapBindingResponse *)createSupplierUsingParameters:(SupplierServiceSvc_createSupplier *)aParameters ;
- (void)createSupplierAsyncUsingParameters:(SupplierServiceSvc_createSupplier *)aParameters  delegate:(id<SupplierServiceSoapBindingResponseDelegate>)responseDelegate;
- (SupplierServiceSoapBindingResponse *)deleteSupplierUsingParameters:(SupplierServiceSvc_deleteSupplier *)aParameters ;
- (void)deleteSupplierAsyncUsingParameters:(SupplierServiceSvc_deleteSupplier *)aParameters  delegate:(id<SupplierServiceSoapBindingResponseDelegate>)responseDelegate;
@end
@interface SupplierServiceSoapBindingOperation : NSOperation {
	SupplierServiceSoapBinding *binding;
	SupplierServiceSoapBindingResponse * response;
	id<SupplierServiceSoapBindingResponseDelegate>  delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (strong) SupplierServiceSoapBinding *binding;
@property (  readonly) SupplierServiceSoapBindingResponse *response;



@property (  nonatomic) id<SupplierServiceSoapBindingResponseDelegate> delegate;





@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(SupplierServiceSoapBinding *)aBinding delegate:(id<SupplierServiceSoapBindingResponseDelegate>)aDelegate;
@end
@interface SupplierServiceSoapBinding_getSuppliers : SupplierServiceSoapBindingOperation {
	SupplierServiceSvc_getSuppliers * parameters;
}
@property (strong) SupplierServiceSvc_getSuppliers * parameters;
- (id)initWithBinding:(SupplierServiceSoapBinding *)aBinding delegate:(id<SupplierServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(SupplierServiceSvc_getSuppliers *)aParameters
;
@end
@interface SupplierServiceSoapBinding_updateSupplier : SupplierServiceSoapBindingOperation {
	SupplierServiceSvc_updateSupplier * parameters;
}
@property (strong) SupplierServiceSvc_updateSupplier * parameters;
- (id)initWithBinding:(SupplierServiceSoapBinding *)aBinding delegate:(id<SupplierServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(SupplierServiceSvc_updateSupplier *)aParameters
;
@end
@interface SupplierServiceSoapBinding_createSupplier : SupplierServiceSoapBindingOperation {
	SupplierServiceSvc_createSupplier * parameters;
}
@property (strong) SupplierServiceSvc_createSupplier * parameters;
- (id)initWithBinding:(SupplierServiceSoapBinding *)aBinding delegate:(id<SupplierServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(SupplierServiceSvc_createSupplier *)aParameters
;
@end
@interface SupplierServiceSoapBinding_deleteSupplier : SupplierServiceSoapBindingOperation {
	SupplierServiceSvc_deleteSupplier * parameters;
}
@property (strong) SupplierServiceSvc_deleteSupplier * parameters;
- (id)initWithBinding:(SupplierServiceSoapBinding *)aBinding delegate:(id<SupplierServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(SupplierServiceSvc_deleteSupplier *)aParameters
;
@end
@interface SupplierServiceSoapBinding_envelope : NSObject {
}
+ (SupplierServiceSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface SupplierServiceSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end
