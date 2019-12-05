#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class GiftVoucherServices_IssueVoucherToCustomer;
@class GiftVoucherServices_IssueVoucherToCustomerResponse;
@class GiftVoucherServices_createGiftVouchers;
@class GiftVoucherServices_createGiftVouchersResponse;
@class GiftVoucherServices_getAvailableVouchers;
@class GiftVoucherServices_getAvailableVouchersResponse;
@class GiftVoucherServices_getGiftVoucherDetails;
@class GiftVoucherServices_getGiftVoucherDetailsResponse;
@class GiftVoucherServices_getGiftVouchers;
@class GiftVoucherServices_getGiftVouchersResponse;
@interface GiftVoucherServices_IssueVoucherToCustomer : NSObject {
	
/* elements */
	NSString * createIssueDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (GiftVoucherServices_IssueVoucherToCustomer *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * createIssueDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface GiftVoucherServices_IssueVoucherToCustomerResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (GiftVoucherServices_IssueVoucherToCustomerResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface GiftVoucherServices_createGiftVouchers : NSObject {
	
/* elements */
	NSString * giftVoucherDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (GiftVoucherServices_createGiftVouchers *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * giftVoucherDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface GiftVoucherServices_createGiftVouchersResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (GiftVoucherServices_createGiftVouchersResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface GiftVoucherServices_getAvailableVouchers : NSObject {
	
/* elements */
	NSString * getVoucherDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (GiftVoucherServices_getAvailableVouchers *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * getVoucherDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface GiftVoucherServices_getAvailableVouchersResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (GiftVoucherServices_getAvailableVouchersResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface GiftVoucherServices_getGiftVoucherDetails : NSObject {
	
/* elements */
	NSString * giftVoucherDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (GiftVoucherServices_getGiftVoucherDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * giftVoucherDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface GiftVoucherServices_getGiftVoucherDetailsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (GiftVoucherServices_getGiftVoucherDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface GiftVoucherServices_getGiftVouchers : NSObject {
	
/* elements */
	NSString * giftVoucherDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (GiftVoucherServices_getGiftVouchers *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * giftVoucherDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface GiftVoucherServices_getGiftVouchersResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (GiftVoucherServices_getGiftVouchersResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "GiftVoucherServices.h"
@class GiftVoucherServicesSoapBinding;
@interface GiftVoucherServices : NSObject {
	
}
+ (GiftVoucherServicesSoapBinding *)GiftVoucherServicesSoapBinding;
@end
@class GiftVoucherServicesSoapBindingResponse;
@class GiftVoucherServicesSoapBindingOperation;
@protocol GiftVoucherServicesSoapBindingResponseDelegate <NSObject>
- (void) operation:(GiftVoucherServicesSoapBindingOperation *)operation completedWithResponse:(GiftVoucherServicesSoapBindingResponse *)response;
@end
@interface GiftVoucherServicesSoapBinding : NSObject <GiftVoucherServicesSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(GiftVoucherServicesSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (GiftVoucherServicesSoapBindingResponse *)createGiftVouchersUsingParameters:(GiftVoucherServices_createGiftVouchers *)aParameters ;
- (void)createGiftVouchersAsyncUsingParameters:(GiftVoucherServices_createGiftVouchers *)aParameters  delegate:(id<GiftVoucherServicesSoapBindingResponseDelegate>)responseDelegate;
- (GiftVoucherServicesSoapBindingResponse *)IssueVoucherToCustomerUsingParameters:(GiftVoucherServices_IssueVoucherToCustomer *)aParameters ;
- (void)IssueVoucherToCustomerAsyncUsingParameters:(GiftVoucherServices_IssueVoucherToCustomer *)aParameters  delegate:(id<GiftVoucherServicesSoapBindingResponseDelegate>)responseDelegate;
- (GiftVoucherServicesSoapBindingResponse *)getGiftVouchersUsingParameters:(GiftVoucherServices_getGiftVouchers *)aParameters ;
- (void)getGiftVouchersAsyncUsingParameters:(GiftVoucherServices_getGiftVouchers *)aParameters  delegate:(id<GiftVoucherServicesSoapBindingResponseDelegate>)responseDelegate;
- (GiftVoucherServicesSoapBindingResponse *)getAvailableVouchersUsingParameters:(GiftVoucherServices_getAvailableVouchers *)aParameters ;
- (void)getAvailableVouchersAsyncUsingParameters:(GiftVoucherServices_getAvailableVouchers *)aParameters  delegate:(id<GiftVoucherServicesSoapBindingResponseDelegate>)responseDelegate;
- (GiftVoucherServicesSoapBindingResponse *)getGiftVoucherDetailsUsingParameters:(GiftVoucherServices_getGiftVoucherDetails *)aParameters ;
- (void)getGiftVoucherDetailsAsyncUsingParameters:(GiftVoucherServices_getGiftVoucherDetails *)aParameters  delegate:(id<GiftVoucherServicesSoapBindingResponseDelegate>)responseDelegate;
@end
@interface GiftVoucherServicesSoapBindingOperation : NSOperation {
	GiftVoucherServicesSoapBinding *binding;
	GiftVoucherServicesSoapBindingResponse * response;
	id<GiftVoucherServicesSoapBindingResponseDelegate>  delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (strong) GiftVoucherServicesSoapBinding *binding;
@property (  readonly) GiftVoucherServicesSoapBindingResponse *response;
@property (nonatomic ) id<GiftVoucherServicesSoapBindingResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(GiftVoucherServicesSoapBinding *)aBinding delegate:(id<GiftVoucherServicesSoapBindingResponseDelegate>)aDelegate;
@end
@interface GiftVoucherServicesSoapBinding_createGiftVouchers : GiftVoucherServicesSoapBindingOperation {
	GiftVoucherServices_createGiftVouchers * parameters;
}
@property (strong) GiftVoucherServices_createGiftVouchers * parameters;
- (id)initWithBinding:(GiftVoucherServicesSoapBinding *)aBinding delegate:(id<GiftVoucherServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(GiftVoucherServices_createGiftVouchers *)aParameters
;
@end
@interface GiftVoucherServicesSoapBinding_IssueVoucherToCustomer : GiftVoucherServicesSoapBindingOperation {
	GiftVoucherServices_IssueVoucherToCustomer * parameters;
}
@property (strong) GiftVoucherServices_IssueVoucherToCustomer * parameters;
- (id)initWithBinding:(GiftVoucherServicesSoapBinding *)aBinding delegate:(id<GiftVoucherServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(GiftVoucherServices_IssueVoucherToCustomer *)aParameters
;
@end
@interface GiftVoucherServicesSoapBinding_getGiftVouchers : GiftVoucherServicesSoapBindingOperation {
	GiftVoucherServices_getGiftVouchers * parameters;
}
@property (strong) GiftVoucherServices_getGiftVouchers * parameters;
- (id)initWithBinding:(GiftVoucherServicesSoapBinding *)aBinding delegate:(id<GiftVoucherServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(GiftVoucherServices_getGiftVouchers *)aParameters
;
@end
@interface GiftVoucherServicesSoapBinding_getAvailableVouchers : GiftVoucherServicesSoapBindingOperation {
	GiftVoucherServices_getAvailableVouchers * parameters;
}
@property (strong) GiftVoucherServices_getAvailableVouchers * parameters;
- (id)initWithBinding:(GiftVoucherServicesSoapBinding *)aBinding delegate:(id<GiftVoucherServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(GiftVoucherServices_getAvailableVouchers *)aParameters
;
@end
@interface GiftVoucherServicesSoapBinding_getGiftVoucherDetails : GiftVoucherServicesSoapBindingOperation {
	GiftVoucherServices_getGiftVoucherDetails * parameters;
}
@property (strong) GiftVoucherServices_getGiftVoucherDetails * parameters;
- (id)initWithBinding:(GiftVoucherServicesSoapBinding *)aBinding delegate:(id<GiftVoucherServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(GiftVoucherServices_getGiftVoucherDetails *)aParameters
;
@end
@interface GiftVoucherServicesSoapBinding_envelope : NSObject {
}
+ (GiftVoucherServicesSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface GiftVoucherServicesSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end
