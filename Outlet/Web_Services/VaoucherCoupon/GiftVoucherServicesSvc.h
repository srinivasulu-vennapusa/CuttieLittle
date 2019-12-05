#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class GiftVoucherServicesSvc_createGiftVouchers;
@class GiftVoucherServicesSvc_createGiftVouchersResponse;
@class GiftVoucherServicesSvc_getGiftVoucherDetails;
@class GiftVoucherServicesSvc_getGiftVoucherDetailsResponse;
@class GiftVoucherServicesSvc_getGiftVouchers;
@class GiftVoucherServicesSvc_getGiftVouchersResponse;
@interface GiftVoucherServicesSvc_createGiftVouchers : NSObject {
	
/* elements */
	NSString * giftVoucherDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (GiftVoucherServicesSvc_createGiftVouchers *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * giftVoucherDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface GiftVoucherServicesSvc_createGiftVouchersResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (GiftVoucherServicesSvc_createGiftVouchersResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface GiftVoucherServicesSvc_getGiftVoucherDetails : NSObject {
	
/* elements */
	NSString * giftVoucherDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (GiftVoucherServicesSvc_getGiftVoucherDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * giftVoucherDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface GiftVoucherServicesSvc_getGiftVoucherDetailsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (GiftVoucherServicesSvc_getGiftVoucherDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface GiftVoucherServicesSvc_getGiftVouchers : NSObject {
	
/* elements */
	NSString * giftVoucherDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (GiftVoucherServicesSvc_getGiftVouchers *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * giftVoucherDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface GiftVoucherServicesSvc_getGiftVouchersResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (GiftVoucherServicesSvc_getGiftVouchersResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "GiftVoucherServicesSvc.h"
@class GiftVoucherServicesSoapBinding;
@interface GiftVoucherServicesSvc : NSObject {
	
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
@property (nonatomic, retain) NSMutableArray *cookies;
@property (nonatomic, retain) NSString *authUsername;
@property (nonatomic, retain) NSString *authPassword;
- (id)initWithAddress:(NSString *)anAddress;
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(GiftVoucherServicesSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (GiftVoucherServicesSoapBindingResponse *)createGiftVouchersUsingParameters:(GiftVoucherServicesSvc_createGiftVouchers *)aParameters ;
- (void)createGiftVouchersAsyncUsingParameters:(GiftVoucherServicesSvc_createGiftVouchers *)aParameters  delegate:(id<GiftVoucherServicesSoapBindingResponseDelegate>)responseDelegate;
- (GiftVoucherServicesSoapBindingResponse *)getGiftVoucherDetailsUsingParameters:(GiftVoucherServicesSvc_getGiftVoucherDetails *)aParameters ;
- (void)getGiftVoucherDetailsAsyncUsingParameters:(GiftVoucherServicesSvc_getGiftVoucherDetails *)aParameters  delegate:(id<GiftVoucherServicesSoapBindingResponseDelegate>)responseDelegate;
- (GiftVoucherServicesSoapBindingResponse *)getGiftVouchersUsingParameters:(GiftVoucherServicesSvc_getGiftVouchers *)aParameters ;
- (void)getGiftVouchersAsyncUsingParameters:(GiftVoucherServicesSvc_getGiftVouchers *)aParameters  delegate:(id<GiftVoucherServicesSoapBindingResponseDelegate>)responseDelegate;
@end
@interface GiftVoucherServicesSoapBindingOperation : NSOperation {
	GiftVoucherServicesSoapBinding *binding;
	GiftVoucherServicesSoapBindingResponse *response;
	id<GiftVoucherServicesSoapBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) GiftVoucherServicesSoapBinding *binding;
@property (readonly) GiftVoucherServicesSoapBindingResponse *response;
@property (nonatomic, assign) id<GiftVoucherServicesSoapBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(GiftVoucherServicesSoapBinding *)aBinding delegate:(id<GiftVoucherServicesSoapBindingResponseDelegate>)aDelegate;
@end
@interface GiftVoucherServicesSoapBinding_createGiftVouchers : GiftVoucherServicesSoapBindingOperation {
	GiftVoucherServicesSvc_createGiftVouchers * parameters;
}
@property (retain) GiftVoucherServicesSvc_createGiftVouchers * parameters;
- (id)initWithBinding:(GiftVoucherServicesSoapBinding *)aBinding delegate:(id<GiftVoucherServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(GiftVoucherServicesSvc_createGiftVouchers *)aParameters
;
@end
@interface GiftVoucherServicesSoapBinding_getGiftVoucherDetails : GiftVoucherServicesSoapBindingOperation {
	GiftVoucherServicesSvc_getGiftVoucherDetails * parameters;
}
@property (retain) GiftVoucherServicesSvc_getGiftVoucherDetails * parameters;
- (id)initWithBinding:(GiftVoucherServicesSoapBinding *)aBinding delegate:(id<GiftVoucherServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(GiftVoucherServicesSvc_getGiftVoucherDetails *)aParameters
;
@end
@interface GiftVoucherServicesSoapBinding_getGiftVouchers : GiftVoucherServicesSoapBindingOperation {
	GiftVoucherServicesSvc_getGiftVouchers * parameters;
}
@property (retain) GiftVoucherServicesSvc_getGiftVouchers * parameters;
- (id)initWithBinding:(GiftVoucherServicesSoapBinding *)aBinding delegate:(id<GiftVoucherServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(GiftVoucherServicesSvc_getGiftVouchers *)aParameters
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
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
