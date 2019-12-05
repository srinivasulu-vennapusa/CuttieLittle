#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class VouchercouponServiceSvc_addFoodCouponDetails;
@class VouchercouponServiceSvc_addFoodCouponDetailsResponse;
@class VouchercouponServiceSvc_getCouponDetails;
@class VouchercouponServiceSvc_getCouponDetailsBySKU;
@class VouchercouponServiceSvc_getCouponDetailsBySKUResponse;
@class VouchercouponServiceSvc_getCouponDetailsResponse;
@class VouchercouponServiceSvc_getCurrentVouchercouponDetails;
@class VouchercouponServiceSvc_getCurrentVouchercouponDetailsResponse;
@class VouchercouponServiceSvc_getGiftVoucherIds;
@class VouchercouponServiceSvc_getGiftVoucherIdsResponse;
@class VouchercouponServiceSvc_getVoucherDetails;
@class VouchercouponServiceSvc_getVoucherDetailsResponse;
@class VouchercouponServiceSvc_helloworld;
@class VouchercouponServiceSvc_helloworldResponse;
@interface VouchercouponServiceSvc_addFoodCouponDetails : NSObject {
	
/* elements */
	NSString * food_coupon_details;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (VouchercouponServiceSvc_addFoodCouponDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * food_coupon_details;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface VouchercouponServiceSvc_addFoodCouponDetailsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (VouchercouponServiceSvc_addFoodCouponDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface VouchercouponServiceSvc_getCouponDetails : NSObject {
	
/* elements */
	NSString * voucherCouponCode;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (VouchercouponServiceSvc_getCouponDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * voucherCouponCode;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface VouchercouponServiceSvc_getCouponDetailsBySKU : NSObject {
	
/* elements */
	NSString * skuID;
	NSString * voucherCouponType;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (VouchercouponServiceSvc_getCouponDetailsBySKU *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * skuID;
@property (strong) NSString * voucherCouponType;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface VouchercouponServiceSvc_getCouponDetailsBySKUResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (VouchercouponServiceSvc_getCouponDetailsBySKUResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface VouchercouponServiceSvc_getCouponDetailsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (VouchercouponServiceSvc_getCouponDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface VouchercouponServiceSvc_getCurrentVouchercouponDetails : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (VouchercouponServiceSvc_getCurrentVouchercouponDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface VouchercouponServiceSvc_getCurrentVouchercouponDetailsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (VouchercouponServiceSvc_getCurrentVouchercouponDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface VouchercouponServiceSvc_getGiftVoucherIds : NSObject {
	
/* elements */
	NSString * searchCriteria;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (VouchercouponServiceSvc_getGiftVoucherIds *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * searchCriteria;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface VouchercouponServiceSvc_getGiftVoucherIdsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (VouchercouponServiceSvc_getGiftVoucherIdsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface VouchercouponServiceSvc_getVoucherDetails : NSObject {
	
/* elements */
	NSString * voucherCouponCode;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (VouchercouponServiceSvc_getVoucherDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * voucherCouponCode;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface VouchercouponServiceSvc_getVoucherDetailsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (VouchercouponServiceSvc_getVoucherDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface VouchercouponServiceSvc_helloworld : NSObject {
	
/* elements */
	NSString * testString;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (VouchercouponServiceSvc_helloworld *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * testString;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface VouchercouponServiceSvc_helloworldResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (VouchercouponServiceSvc_helloworldResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "VouchercouponServiceSvc.h"
@class VouchercouponServiceSoapBinding;
@interface VouchercouponServiceSvc : NSObject {
	
}
+ (VouchercouponServiceSoapBinding *)VouchercouponServiceSoapBinding;
@end
@class VouchercouponServiceSoapBindingResponse;
@class VouchercouponServiceSoapBindingOperation;
@protocol VouchercouponServiceSoapBindingResponseDelegate <NSObject>
- (void) operation:(VouchercouponServiceSoapBindingOperation *)operation completedWithResponse:(VouchercouponServiceSoapBindingResponse *)response;
@end
@interface VouchercouponServiceSoapBinding : NSObject <VouchercouponServiceSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(VouchercouponServiceSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (VouchercouponServiceSoapBindingResponse *)getGiftVoucherIdsUsingParameters:(VouchercouponServiceSvc_getGiftVoucherIds *)aParameters ;
- (void)getGiftVoucherIdsAsyncUsingParameters:(VouchercouponServiceSvc_getGiftVoucherIds *)aParameters  delegate:(id<VouchercouponServiceSoapBindingResponseDelegate>)responseDelegate;
- (VouchercouponServiceSoapBindingResponse *)getCurrentVouchercouponDetailsUsingParameters:(VouchercouponServiceSvc_getCurrentVouchercouponDetails *)aParameters ;
- (void)getCurrentVouchercouponDetailsAsyncUsingParameters:(VouchercouponServiceSvc_getCurrentVouchercouponDetails *)aParameters  delegate:(id<VouchercouponServiceSoapBindingResponseDelegate>)responseDelegate;
- (VouchercouponServiceSoapBindingResponse *)getCouponDetailsUsingParameters:(VouchercouponServiceSvc_getCouponDetails *)aParameters ;
- (void)getCouponDetailsAsyncUsingParameters:(VouchercouponServiceSvc_getCouponDetails *)aParameters  delegate:(id<VouchercouponServiceSoapBindingResponseDelegate>)responseDelegate;
- (VouchercouponServiceSoapBindingResponse *)addFoodCouponDetailsUsingParameters:(VouchercouponServiceSvc_addFoodCouponDetails *)aParameters ;
- (void)addFoodCouponDetailsAsyncUsingParameters:(VouchercouponServiceSvc_addFoodCouponDetails *)aParameters  delegate:(id<VouchercouponServiceSoapBindingResponseDelegate>)responseDelegate;
- (VouchercouponServiceSoapBindingResponse *)helloworldUsingParameters:(VouchercouponServiceSvc_helloworld *)aParameters ;
- (void)helloworldAsyncUsingParameters:(VouchercouponServiceSvc_helloworld *)aParameters  delegate:(id<VouchercouponServiceSoapBindingResponseDelegate>)responseDelegate;
- (VouchercouponServiceSoapBindingResponse *)getVoucherDetailsUsingParameters:(VouchercouponServiceSvc_getVoucherDetails *)aParameters ;
- (void)getVoucherDetailsAsyncUsingParameters:(VouchercouponServiceSvc_getVoucherDetails *)aParameters  delegate:(id<VouchercouponServiceSoapBindingResponseDelegate>)responseDelegate;
- (VouchercouponServiceSoapBindingResponse *)getCouponDetailsBySKUUsingParameters:(VouchercouponServiceSvc_getCouponDetailsBySKU *)aParameters ;
- (void)getCouponDetailsBySKUAsyncUsingParameters:(VouchercouponServiceSvc_getCouponDetailsBySKU *)aParameters  delegate:(id<VouchercouponServiceSoapBindingResponseDelegate>)responseDelegate;
@end
@interface VouchercouponServiceSoapBindingOperation : NSOperation {
	VouchercouponServiceSoapBinding *binding;
	VouchercouponServiceSoapBindingResponse * response;
	id<VouchercouponServiceSoapBindingResponseDelegate>  delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (strong) VouchercouponServiceSoapBinding *binding;
@property (  readonly) VouchercouponServiceSoapBindingResponse *response;
@property (nonatomic ) id<VouchercouponServiceSoapBindingResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(VouchercouponServiceSoapBinding *)aBinding delegate:(id<VouchercouponServiceSoapBindingResponseDelegate>)aDelegate;
@end
@interface VouchercouponServiceSoapBinding_getGiftVoucherIds : VouchercouponServiceSoapBindingOperation {
	VouchercouponServiceSvc_getGiftVoucherIds * parameters;
}
@property (strong) VouchercouponServiceSvc_getGiftVoucherIds * parameters;
- (id)initWithBinding:(VouchercouponServiceSoapBinding *)aBinding delegate:(id<VouchercouponServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(VouchercouponServiceSvc_getGiftVoucherIds *)aParameters
;
@end
@interface VouchercouponServiceSoapBinding_getCurrentVouchercouponDetails : VouchercouponServiceSoapBindingOperation {
	VouchercouponServiceSvc_getCurrentVouchercouponDetails * parameters;
}
@property (strong) VouchercouponServiceSvc_getCurrentVouchercouponDetails * parameters;
- (id)initWithBinding:(VouchercouponServiceSoapBinding *)aBinding delegate:(id<VouchercouponServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(VouchercouponServiceSvc_getCurrentVouchercouponDetails *)aParameters
;
@end
@interface VouchercouponServiceSoapBinding_getCouponDetails : VouchercouponServiceSoapBindingOperation {
	VouchercouponServiceSvc_getCouponDetails * parameters;
}
@property (strong) VouchercouponServiceSvc_getCouponDetails * parameters;
- (id)initWithBinding:(VouchercouponServiceSoapBinding *)aBinding delegate:(id<VouchercouponServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(VouchercouponServiceSvc_getCouponDetails *)aParameters
;
@end
@interface VouchercouponServiceSoapBinding_addFoodCouponDetails : VouchercouponServiceSoapBindingOperation {
	VouchercouponServiceSvc_addFoodCouponDetails * parameters;
}
@property (strong) VouchercouponServiceSvc_addFoodCouponDetails * parameters;
- (id)initWithBinding:(VouchercouponServiceSoapBinding *)aBinding delegate:(id<VouchercouponServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(VouchercouponServiceSvc_addFoodCouponDetails *)aParameters
;
@end
@interface VouchercouponServiceSoapBinding_helloworld : VouchercouponServiceSoapBindingOperation {
	VouchercouponServiceSvc_helloworld * parameters;
}
@property (strong) VouchercouponServiceSvc_helloworld * parameters;
- (id)initWithBinding:(VouchercouponServiceSoapBinding *)aBinding delegate:(id<VouchercouponServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(VouchercouponServiceSvc_helloworld *)aParameters
;
@end
@interface VouchercouponServiceSoapBinding_getVoucherDetails : VouchercouponServiceSoapBindingOperation {
	VouchercouponServiceSvc_getVoucherDetails * parameters;
}
@property (strong) VouchercouponServiceSvc_getVoucherDetails * parameters;
- (id)initWithBinding:(VouchercouponServiceSoapBinding *)aBinding delegate:(id<VouchercouponServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(VouchercouponServiceSvc_getVoucherDetails *)aParameters
;
@end
@interface VouchercouponServiceSoapBinding_getCouponDetailsBySKU : VouchercouponServiceSoapBindingOperation {
	VouchercouponServiceSvc_getCouponDetailsBySKU * parameters;
}
@property (strong) VouchercouponServiceSvc_getCouponDetailsBySKU * parameters;
- (id)initWithBinding:(VouchercouponServiceSoapBinding *)aBinding delegate:(id<VouchercouponServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(VouchercouponServiceSvc_getCouponDetailsBySKU *)aParameters
;
@end
@interface VouchercouponServiceSoapBinding_envelope : NSObject {
}
+ (VouchercouponServiceSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface VouchercouponServiceSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end
