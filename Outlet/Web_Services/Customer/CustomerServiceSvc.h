#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class CustomerServiceSvc_createCustomer;
@class CustomerServiceSvc_createCustomerResponse;
@class CustomerServiceSvc_getCustomerDetails;
@class CustomerServiceSvc_getCustomerDetailsResponse;
@class CustomerServiceSvc_updateCustomer;
@class CustomerServiceSvc_updateCustomerResponse;
@interface CustomerServiceSvc_createCustomer : NSObject {
	
/* elements */
	NSString * customerDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (CustomerServiceSvc_createCustomer *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * customerDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface CustomerServiceSvc_createCustomerResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (CustomerServiceSvc_createCustomerResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface CustomerServiceSvc_getCustomerDetails : NSObject {
	
/* elements */
	NSString * phone;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (CustomerServiceSvc_getCustomerDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * phone;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface CustomerServiceSvc_getCustomerDetailsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (CustomerServiceSvc_getCustomerDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface CustomerServiceSvc_updateCustomer : NSObject {
	
/* elements */
	NSString * customerDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (CustomerServiceSvc_updateCustomer *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * customerDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface CustomerServiceSvc_updateCustomerResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (CustomerServiceSvc_updateCustomerResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "CustomerServiceSvc.h"
@class CustomerServiceSoapBinding;
@interface CustomerServiceSvc : NSObject {
	
}
+ (CustomerServiceSoapBinding *)CustomerServiceSoapBinding;
@end
@class CustomerServiceSoapBindingResponse;
@class CustomerServiceSoapBindingOperation;
@protocol CustomerServiceSoapBindingResponseDelegate <NSObject>
- (void) operation:(CustomerServiceSoapBindingOperation *)operation completedWithResponse:(CustomerServiceSoapBindingResponse *)response;
@end
@interface CustomerServiceSoapBinding : NSObject <CustomerServiceSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(CustomerServiceSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (CustomerServiceSoapBindingResponse *)updateCustomerUsingParameters:(CustomerServiceSvc_updateCustomer *)aParameters ;
- (void)updateCustomerAsyncUsingParameters:(CustomerServiceSvc_updateCustomer *)aParameters  delegate:(id<CustomerServiceSoapBindingResponseDelegate>)responseDelegate;
- (CustomerServiceSoapBindingResponse *)createCustomerUsingParameters:(CustomerServiceSvc_createCustomer *)aParameters ;
- (void)createCustomerAsyncUsingParameters:(CustomerServiceSvc_createCustomer *)aParameters  delegate:(id<CustomerServiceSoapBindingResponseDelegate>)responseDelegate;
- (CustomerServiceSoapBindingResponse *)getCustomerDetailsUsingParameters:(CustomerServiceSvc_getCustomerDetails *)aParameters ;
- (void)getCustomerDetailsAsyncUsingParameters:(CustomerServiceSvc_getCustomerDetails *)aParameters  delegate:(id<CustomerServiceSoapBindingResponseDelegate>)responseDelegate;
@end
@interface CustomerServiceSoapBindingOperation : NSOperation {
	CustomerServiceSoapBinding *binding;
	CustomerServiceSoapBindingResponse * response;
	id<CustomerServiceSoapBindingResponseDelegate>  delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (strong) CustomerServiceSoapBinding *binding;
@property (  readonly) CustomerServiceSoapBindingResponse *response;
@property (nonatomic ) id<CustomerServiceSoapBindingResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(CustomerServiceSoapBinding *)aBinding delegate:(id<CustomerServiceSoapBindingResponseDelegate>)aDelegate;
@end
@interface CustomerServiceSoapBinding_updateCustomer : CustomerServiceSoapBindingOperation {
	CustomerServiceSvc_updateCustomer * parameters;
}
@property (strong) CustomerServiceSvc_updateCustomer * parameters;
- (id)initWithBinding:(CustomerServiceSoapBinding *)aBinding delegate:(id<CustomerServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(CustomerServiceSvc_updateCustomer *)aParameters
;
@end
@interface CustomerServiceSoapBinding_createCustomer : CustomerServiceSoapBindingOperation {
	CustomerServiceSvc_createCustomer * parameters;
}
@property (strong) CustomerServiceSvc_createCustomer * parameters;
- (id)initWithBinding:(CustomerServiceSoapBinding *)aBinding delegate:(id<CustomerServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(CustomerServiceSvc_createCustomer *)aParameters
;
@end
@interface CustomerServiceSoapBinding_getCustomerDetails : CustomerServiceSoapBindingOperation {
	CustomerServiceSvc_getCustomerDetails * parameters;
}
@property (strong) CustomerServiceSvc_getCustomerDetails * parameters;
- (id)initWithBinding:(CustomerServiceSoapBinding *)aBinding delegate:(id<CustomerServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(CustomerServiceSvc_getCustomerDetails *)aParameters
;
@end
@interface CustomerServiceSoapBinding_envelope : NSObject {
}
+ (CustomerServiceSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface CustomerServiceSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end
