#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class GiftCouponServicesSvc_createGiftCoupons;
@class GiftCouponServicesSvc_createGiftCouponsResponse;
@class GiftCouponServicesSvc_getCouponDetails;
@class GiftCouponServicesSvc_getCouponDetailsResponse;
@class GiftCouponServicesSvc_getGiftCoupons;
@class GiftCouponServicesSvc_getGiftCouponsMaster;
@class GiftCouponServicesSvc_getGiftCouponsMasterResponse;
@class GiftCouponServicesSvc_getGiftCouponsResponse;
@class GiftCouponServicesSvc_issueGiftCouponToCustomer;
@class GiftCouponServicesSvc_issueGiftCouponToCustomerResponse;
@interface GiftCouponServicesSvc_createGiftCoupons : NSObject {
	
/* elements */
	NSString * giftCouponDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (GiftCouponServicesSvc_createGiftCoupons *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * giftCouponDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface GiftCouponServicesSvc_createGiftCouponsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (GiftCouponServicesSvc_createGiftCouponsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface GiftCouponServicesSvc_getCouponDetails : NSObject {
	
/* elements */
	NSString * couponDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (GiftCouponServicesSvc_getCouponDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * couponDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface GiftCouponServicesSvc_getCouponDetailsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (GiftCouponServicesSvc_getCouponDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface GiftCouponServicesSvc_getGiftCoupons : NSObject {
	
/* elements */
	NSString * getGiftCouponsRequest;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (GiftCouponServicesSvc_getGiftCoupons *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * getGiftCouponsRequest;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface GiftCouponServicesSvc_getGiftCouponsMaster : NSObject {
	
/* elements */
	NSString * giftCouponDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (GiftCouponServicesSvc_getGiftCouponsMaster *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * giftCouponDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface GiftCouponServicesSvc_getGiftCouponsMasterResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (GiftCouponServicesSvc_getGiftCouponsMasterResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface GiftCouponServicesSvc_getGiftCouponsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (GiftCouponServicesSvc_getGiftCouponsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface GiftCouponServicesSvc_issueGiftCouponToCustomer : NSObject {
	
/* elements */
	NSString * issueCoupon;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (GiftCouponServicesSvc_issueGiftCouponToCustomer *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * issueCoupon;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface GiftCouponServicesSvc_issueGiftCouponToCustomerResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (GiftCouponServicesSvc_issueGiftCouponToCustomerResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "GiftCouponServicesSvc.h"
@class GiftCouponServicesSoapBinding;
@interface GiftCouponServicesSvc : NSObject {
	
}
+ (GiftCouponServicesSoapBinding *)GiftCouponServicesSoapBinding;
@end
@class GiftCouponServicesSoapBindingResponse;
@class GiftCouponServicesSoapBindingOperation;
@protocol GiftCouponServicesSoapBindingResponseDelegate <NSObject>
- (void) operation:(GiftCouponServicesSoapBindingOperation *)operation completedWithResponse:(GiftCouponServicesSoapBindingResponse *)response;
@end
@interface GiftCouponServicesSoapBinding : NSObject <GiftCouponServicesSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(GiftCouponServicesSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (GiftCouponServicesSoapBindingResponse *)getGiftCouponsMasterUsingParameters:(GiftCouponServicesSvc_getGiftCouponsMaster *)aParameters ;
- (void)getGiftCouponsMasterAsyncUsingParameters:(GiftCouponServicesSvc_getGiftCouponsMaster *)aParameters  delegate:(id<GiftCouponServicesSoapBindingResponseDelegate>)responseDelegate;
- (GiftCouponServicesSoapBindingResponse *)getGiftCouponsUsingParameters:(GiftCouponServicesSvc_getGiftCoupons *)aParameters ;
- (void)getGiftCouponsAsyncUsingParameters:(GiftCouponServicesSvc_getGiftCoupons *)aParameters  delegate:(id<GiftCouponServicesSoapBindingResponseDelegate>)responseDelegate;
- (GiftCouponServicesSoapBindingResponse *)getCouponDetailsUsingParameters:(GiftCouponServicesSvc_getCouponDetails *)aParameters ;
- (void)getCouponDetailsAsyncUsingParameters:(GiftCouponServicesSvc_getCouponDetails *)aParameters  delegate:(id<GiftCouponServicesSoapBindingResponseDelegate>)responseDelegate;
- (GiftCouponServicesSoapBindingResponse *)issueGiftCouponToCustomerUsingParameters:(GiftCouponServicesSvc_issueGiftCouponToCustomer *)aParameters ;
- (void)issueGiftCouponToCustomerAsyncUsingParameters:(GiftCouponServicesSvc_issueGiftCouponToCustomer *)aParameters  delegate:(id<GiftCouponServicesSoapBindingResponseDelegate>)responseDelegate;
- (GiftCouponServicesSoapBindingResponse *)createGiftCouponsUsingParameters:(GiftCouponServicesSvc_createGiftCoupons *)aParameters ;
- (void)createGiftCouponsAsyncUsingParameters:(GiftCouponServicesSvc_createGiftCoupons *)aParameters  delegate:(id<GiftCouponServicesSoapBindingResponseDelegate>)responseDelegate;
@end
@interface GiftCouponServicesSoapBindingOperation : NSOperation {
	GiftCouponServicesSoapBinding *binding;
	GiftCouponServicesSoapBindingResponse * response;
	id<GiftCouponServicesSoapBindingResponseDelegate>  delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (strong) GiftCouponServicesSoapBinding *binding;
@property (  readonly) GiftCouponServicesSoapBindingResponse *response;
@property (nonatomic ) id<GiftCouponServicesSoapBindingResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(GiftCouponServicesSoapBinding *)aBinding delegate:(id<GiftCouponServicesSoapBindingResponseDelegate>)aDelegate;
@end
@interface GiftCouponServicesSoapBinding_getGiftCouponsMaster : GiftCouponServicesSoapBindingOperation {
	GiftCouponServicesSvc_getGiftCouponsMaster * parameters;
}
@property (strong) GiftCouponServicesSvc_getGiftCouponsMaster * parameters;
- (id)initWithBinding:(GiftCouponServicesSoapBinding *)aBinding delegate:(id<GiftCouponServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(GiftCouponServicesSvc_getGiftCouponsMaster *)aParameters
;
@end
@interface GiftCouponServicesSoapBinding_getGiftCoupons : GiftCouponServicesSoapBindingOperation {
	GiftCouponServicesSvc_getGiftCoupons * parameters;
}
@property (strong) GiftCouponServicesSvc_getGiftCoupons * parameters;
- (id)initWithBinding:(GiftCouponServicesSoapBinding *)aBinding delegate:(id<GiftCouponServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(GiftCouponServicesSvc_getGiftCoupons *)aParameters
;
@end
@interface GiftCouponServicesSoapBinding_getCouponDetails : GiftCouponServicesSoapBindingOperation {
	GiftCouponServicesSvc_getCouponDetails * parameters;
}
@property (strong) GiftCouponServicesSvc_getCouponDetails * parameters;
- (id)initWithBinding:(GiftCouponServicesSoapBinding *)aBinding delegate:(id<GiftCouponServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(GiftCouponServicesSvc_getCouponDetails *)aParameters
;
@end
@interface GiftCouponServicesSoapBinding_issueGiftCouponToCustomer : GiftCouponServicesSoapBindingOperation {
	GiftCouponServicesSvc_issueGiftCouponToCustomer * parameters;
}
@property (strong) GiftCouponServicesSvc_issueGiftCouponToCustomer * parameters;
- (id)initWithBinding:(GiftCouponServicesSoapBinding *)aBinding delegate:(id<GiftCouponServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(GiftCouponServicesSvc_issueGiftCouponToCustomer *)aParameters
;
@end
@interface GiftCouponServicesSoapBinding_createGiftCoupons : GiftCouponServicesSoapBindingOperation {
	GiftCouponServicesSvc_createGiftCoupons * parameters;
}
@property (strong) GiftCouponServicesSvc_createGiftCoupons * parameters;
- (id)initWithBinding:(GiftCouponServicesSoapBinding *)aBinding delegate:(id<GiftCouponServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(GiftCouponServicesSvc_createGiftCoupons *)aParameters
;
@end
@interface GiftCouponServicesSoapBinding_envelope : NSObject {
}
+ (GiftCouponServicesSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface GiftCouponServicesSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end
