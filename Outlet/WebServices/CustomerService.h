#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class CustomerService_createCustomer;
@class CustomerService_createCustomerResponse;
@class CustomerService_deleteCustomer;
@class CustomerService_deleteCustomerResponse;
@class CustomerService_updateCustomer;
@class CustomerService_updateCustomerResponse;
@class CustomerService_getCustomer;
@class CustomerService_getCustomerResponse;
@class CustomerService_getPhoneDetails;
@class CustomerService_getPhoneDetailsResponse;
@class CustomerService_getCustomerDetails;
@class CustomerService_getCustomerDetailsResponse;
@class CustomerService_getExistedPhoneNumbers;
@class CustomerService_getExistedPhoneNumbersResponse;
@class CustomerService_getExistedEmail;
@class CustomerService_getExistedEmailResponse;
@interface CustomerService_createCustomer : NSObject {
	
/* elements */
	NSString * phone;
	NSString * name;
	NSString * email;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (CustomerService_createCustomer *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * phone;
@property (retain) NSString * name;
@property (retain) NSString * email;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface CustomerService_createCustomerResponse : NSObject {
	
/* elements */
	USBoolean * createCustomerReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (CustomerService_createCustomerResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) USBoolean * createCustomerReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface CustomerService_deleteCustomer : NSObject {
	
/* elements */
	NSMutableArray *phoneIds;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (CustomerService_deleteCustomer *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addPhoneIds:(NSString *)toAdd;
@property (readonly) NSMutableArray * phoneIds;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface CustomerService_deleteCustomerResponse : NSObject {
	
/* elements */
	USBoolean * deleteCustomerReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (CustomerService_deleteCustomerResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) USBoolean * deleteCustomerReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface CustomerService_updateCustomer : NSObject {
	
/* elements */
	NSString * phone;
	NSString * name;
	NSString * email;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (CustomerService_updateCustomer *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * phone;
@property (retain) NSString * name;
@property (retain) NSString * email;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface CustomerService_updateCustomerResponse : NSObject {
	
/* elements */
	USBoolean * updateCustomerReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (CustomerService_updateCustomerResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) USBoolean * updateCustomerReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface CustomerService_getCustomer : NSObject {
	
/* elements */
	NSString * phone;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (CustomerService_getCustomer *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * phone;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface CustomerService_getCustomerResponse : NSObject {
	
/* elements */
	NSString * getCustomerReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (CustomerService_getCustomerResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * getCustomerReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface CustomerService_getPhoneDetails : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (CustomerService_getPhoneDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface CustomerService_getPhoneDetailsResponse : NSObject {
	
/* elements */
	NSString * getPhoneDetailsReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (CustomerService_getPhoneDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * getPhoneDetailsReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface CustomerService_getCustomerDetails : NSObject {
	
/* elements */
	NSString * mail;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (CustomerService_getCustomerDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * mail;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface CustomerService_getCustomerDetailsResponse : NSObject {
	
/* elements */
	NSString * getCustomerDetailsReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (CustomerService_getCustomerDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * getCustomerDetailsReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface CustomerService_getExistedPhoneNumbers : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (CustomerService_getExistedPhoneNumbers *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface CustomerService_getExistedPhoneNumbersResponse : NSObject {
	
/* elements */
	NSString * getExistedPhoneNumbersReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (CustomerService_getExistedPhoneNumbersResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * getExistedPhoneNumbersReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface CustomerService_getExistedEmail : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (CustomerService_getExistedEmail *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface CustomerService_getExistedEmailResponse : NSObject {
	
/* elements */
	NSString * getExistedEmailReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (CustomerService_getExistedEmailResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * getExistedEmailReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "ns1.h"
#import "CustomerService.h"
@class CustomerSoapBinding;
@interface CustomerService : NSObject {
	
}
+ (CustomerSoapBinding *)CustomerSoapBinding;
@end
@class CustomerSoapBindingResponse;
@class CustomerSoapBindingOperation;
@protocol CustomerSoapBindingResponseDelegate <NSObject>
- (void) operation:(CustomerSoapBindingOperation *)operation completedWithResponse:(CustomerSoapBindingResponse *)response;
@end
@interface CustomerSoapBinding : NSObject <CustomerSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(CustomerSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (CustomerSoapBindingResponse *)createCustomerUsingParameters:(CustomerService_createCustomer *)aParameters ;
- (void)createCustomerAsyncUsingParameters:(CustomerService_createCustomer *)aParameters  delegate:(id<CustomerSoapBindingResponseDelegate>)responseDelegate;
- (CustomerSoapBindingResponse *)deleteCustomerUsingParameters:(CustomerService_deleteCustomer *)aParameters ;
- (void)deleteCustomerAsyncUsingParameters:(CustomerService_deleteCustomer *)aParameters  delegate:(id<CustomerSoapBindingResponseDelegate>)responseDelegate;
- (CustomerSoapBindingResponse *)updateCustomerUsingParameters:(CustomerService_updateCustomer *)aParameters ;
- (void)updateCustomerAsyncUsingParameters:(CustomerService_updateCustomer *)aParameters  delegate:(id<CustomerSoapBindingResponseDelegate>)responseDelegate;
- (CustomerSoapBindingResponse *)getCustomerUsingParameters:(CustomerService_getCustomer *)aParameters ;
- (void)getCustomerAsyncUsingParameters:(CustomerService_getCustomer *)aParameters  delegate:(id<CustomerSoapBindingResponseDelegate>)responseDelegate;
- (CustomerSoapBindingResponse *)getPhoneDetailsUsingParameters:(CustomerService_getPhoneDetails *)aParameters ;
- (void)getPhoneDetailsAsyncUsingParameters:(CustomerService_getPhoneDetails *)aParameters  delegate:(id<CustomerSoapBindingResponseDelegate>)responseDelegate;
- (CustomerSoapBindingResponse *)getCustomerDetailsUsingParameters:(CustomerService_getCustomerDetails *)aParameters ;
- (void)getCustomerDetailsAsyncUsingParameters:(CustomerService_getCustomerDetails *)aParameters  delegate:(id<CustomerSoapBindingResponseDelegate>)responseDelegate;
- (CustomerSoapBindingResponse *)getExistedPhoneNumbersUsingParameters:(CustomerService_getExistedPhoneNumbers *)aParameters ;
- (void)getExistedPhoneNumbersAsyncUsingParameters:(CustomerService_getExistedPhoneNumbers *)aParameters  delegate:(id<CustomerSoapBindingResponseDelegate>)responseDelegate;
- (CustomerSoapBindingResponse *)getExistedEmailUsingParameters:(CustomerService_getExistedEmail *)aParameters ;
- (void)getExistedEmailAsyncUsingParameters:(CustomerService_getExistedEmail *)aParameters  delegate:(id<CustomerSoapBindingResponseDelegate>)responseDelegate;
@end
@interface CustomerSoapBindingOperation : NSOperation {
	CustomerSoapBinding *binding;
	CustomerSoapBindingResponse *response;
	id<CustomerSoapBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) CustomerSoapBinding *binding;
@property (readonly) CustomerSoapBindingResponse *response;
@property (nonatomic, assign) id<CustomerSoapBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(CustomerSoapBinding *)aBinding delegate:(id<CustomerSoapBindingResponseDelegate>)aDelegate;
@end
@interface CustomerSoapBinding_createCustomer : CustomerSoapBindingOperation {
	CustomerService_createCustomer * parameters;
}
@property (retain) CustomerService_createCustomer * parameters;
- (id)initWithBinding:(CustomerSoapBinding *)aBinding delegate:(id<CustomerSoapBindingResponseDelegate>)aDelegate
	parameters:(CustomerService_createCustomer *)aParameters
;
@end
@interface CustomerSoapBinding_deleteCustomer : CustomerSoapBindingOperation {
	CustomerService_deleteCustomer * parameters;
}
@property (retain) CustomerService_deleteCustomer * parameters;
- (id)initWithBinding:(CustomerSoapBinding *)aBinding delegate:(id<CustomerSoapBindingResponseDelegate>)aDelegate
	parameters:(CustomerService_deleteCustomer *)aParameters
;
@end
@interface CustomerSoapBinding_updateCustomer : CustomerSoapBindingOperation {
	CustomerService_updateCustomer * parameters;
}
@property (retain) CustomerService_updateCustomer * parameters;
- (id)initWithBinding:(CustomerSoapBinding *)aBinding delegate:(id<CustomerSoapBindingResponseDelegate>)aDelegate
	parameters:(CustomerService_updateCustomer *)aParameters
;
@end
@interface CustomerSoapBinding_getCustomer : CustomerSoapBindingOperation {
	CustomerService_getCustomer * parameters;
}
@property (retain) CustomerService_getCustomer * parameters;
- (id)initWithBinding:(CustomerSoapBinding *)aBinding delegate:(id<CustomerSoapBindingResponseDelegate>)aDelegate
	parameters:(CustomerService_getCustomer *)aParameters
;
@end
@interface CustomerSoapBinding_getPhoneDetails : CustomerSoapBindingOperation {
	CustomerService_getPhoneDetails * parameters;
}
@property (retain) CustomerService_getPhoneDetails * parameters;
- (id)initWithBinding:(CustomerSoapBinding *)aBinding delegate:(id<CustomerSoapBindingResponseDelegate>)aDelegate
	parameters:(CustomerService_getPhoneDetails *)aParameters
;
@end
@interface CustomerSoapBinding_getCustomerDetails : CustomerSoapBindingOperation {
	CustomerService_getCustomerDetails * parameters;
}
@property (retain) CustomerService_getCustomerDetails * parameters;
- (id)initWithBinding:(CustomerSoapBinding *)aBinding delegate:(id<CustomerSoapBindingResponseDelegate>)aDelegate
	parameters:(CustomerService_getCustomerDetails *)aParameters
;
@end
@interface CustomerSoapBinding_getExistedPhoneNumbers : CustomerSoapBindingOperation {
	CustomerService_getExistedPhoneNumbers * parameters;
}
@property (retain) CustomerService_getExistedPhoneNumbers * parameters;
- (id)initWithBinding:(CustomerSoapBinding *)aBinding delegate:(id<CustomerSoapBindingResponseDelegate>)aDelegate
	parameters:(CustomerService_getExistedPhoneNumbers *)aParameters
;
@end
@interface CustomerSoapBinding_getExistedEmail : CustomerSoapBindingOperation {
	CustomerService_getExistedEmail * parameters;
}
@property (retain) CustomerService_getExistedEmail * parameters;
- (id)initWithBinding:(CustomerSoapBinding *)aBinding delegate:(id<CustomerSoapBindingResponseDelegate>)aDelegate
	parameters:(CustomerService_getExistedEmail *)aParameters
;
@end
@interface CustomerSoapBinding_envelope : NSObject {
}
+ (CustomerSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface CustomerSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
