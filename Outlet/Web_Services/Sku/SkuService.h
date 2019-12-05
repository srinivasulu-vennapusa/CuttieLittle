#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class SkuService_getSkuDetails;
@class SkuService_getSkuDetailsResponse;
@class SkuService_getSkuDetailsForStocks;
@class SkuService_getSkuDetailsForStocksResponse;
@class SkuService_getProductDetails;
@class SkuService_getProductDetailsResponse;
@class SkuService_getSkuID;
@class SkuService_getSkuIDResponse;
@class SkuService_getProductNames;
@class SkuService_getProductNamesResponse;
@class SkuService_updateQuantity;
@class SkuService_updateQuantityResponse;
@class SkuService_getSkuIDForGivenProductName;
@class SkuService_getSkuIDForGivenProductNameResponse;
@class SkuService_searchProduct;
@class SkuService_searchProductResponse;
@interface SkuService_getSkuDetails : NSObject {
	
/* elements */
	NSString * skuID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuService_getSkuDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * skuID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuService_getSkuDetailsResponse : NSObject {
	
/* elements */
	NSString * getSkuDetailsReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuService_getSkuDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * getSkuDetailsReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuService_getSkuDetailsForStocks : NSObject {
	
/* elements */
	NSString * skuID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuService_getSkuDetailsForStocks *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * skuID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuService_getSkuDetailsForStocksResponse : NSObject {
	
/* elements */
	NSString * getSkuDetailsForStocksReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuService_getSkuDetailsForStocksResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * getSkuDetailsForStocksReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuService_getProductDetails : NSObject {
	
/* elements */
	NSString * productName;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuService_getProductDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * productName;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuService_getProductDetailsResponse : NSObject {
	
/* elements */
	NSString * getProductDetailsReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuService_getProductDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * getProductDetailsReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuService_getSkuID : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuService_getSkuID *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuService_getSkuIDResponse : NSObject {
	
/* elements */
	NSString * getSkuIDReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuService_getSkuIDResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * getSkuIDReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuService_getProductNames : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuService_getProductNames *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuService_getProductNamesResponse : NSObject {
	
/* elements */
	NSString * getProductNamesReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuService_getProductNamesResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * getProductNamesReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuService_updateQuantity : NSObject {
	
/* elements */
	NSString * skuID;
	NSString * quantity;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuService_updateQuantity *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * skuID;
@property (strong) NSString * quantity;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuService_updateQuantityResponse : NSObject {
	
/* elements */
	USBoolean * updateQuantityReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuService_updateQuantityResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) USBoolean * updateQuantityReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuService_getSkuIDForGivenProductName : NSObject {
	
/* elements */
	NSString * productName;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuService_getSkuIDForGivenProductName *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * productName;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuService_getSkuIDForGivenProductNameResponse : NSObject {
	
/* elements */
	NSString * getSkuIDForGivenProductNameReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuService_getSkuIDForGivenProductNameResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * getSkuIDForGivenProductNameReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuService_searchProduct : NSObject {
	
/* elements */
	NSString * searchCriteria;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuService_searchProduct *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * searchCriteria;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuService_searchProductResponse : NSObject {
	
/* elements */
	NSString * searchProductReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuService_searchProductResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * searchProductReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "ns1.h"
#import "SkuService.h"
@class SkuSoapBinding;
@interface SkuService : NSObject {
	
}
+ (SkuSoapBinding *)SkuSoapBinding;
@end
@class SkuSoapBindingResponse;
@class SkuSoapBindingOperation;
@protocol SkuSoapBindingResponseDelegate <NSObject>
- (void) operation:(SkuSoapBindingOperation *)operation completedWithResponse:(SkuSoapBindingResponse *)response;
@end
@interface SkuSoapBinding : NSObject <SkuSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(SkuSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (SkuSoapBindingResponse *)getSkuDetailsUsingParameters:(SkuService_getSkuDetails *)aParameters ;
- (void)getSkuDetailsAsyncUsingParameters:(SkuService_getSkuDetails *)aParameters  delegate:(id<SkuSoapBindingResponseDelegate>)responseDelegate;
- (SkuSoapBindingResponse *)getSkuDetailsForStocksUsingParameters:(SkuService_getSkuDetailsForStocks *)aParameters ;
- (void)getSkuDetailsForStocksAsyncUsingParameters:(SkuService_getSkuDetailsForStocks *)aParameters  delegate:(id<SkuSoapBindingResponseDelegate>)responseDelegate;
- (SkuSoapBindingResponse *)getProductDetailsUsingParameters:(SkuService_getProductDetails *)aParameters ;
- (void)getProductDetailsAsyncUsingParameters:(SkuService_getProductDetails *)aParameters  delegate:(id<SkuSoapBindingResponseDelegate>)responseDelegate;
- (SkuSoapBindingResponse *)getSkuIDUsingParameters:(SkuService_getSkuID *)aParameters ;
- (void)getSkuIDAsyncUsingParameters:(SkuService_getSkuID *)aParameters  delegate:(id<SkuSoapBindingResponseDelegate>)responseDelegate;
- (SkuSoapBindingResponse *)getProductNamesUsingParameters:(SkuService_getProductNames *)aParameters ;
- (void)getProductNamesAsyncUsingParameters:(SkuService_getProductNames *)aParameters  delegate:(id<SkuSoapBindingResponseDelegate>)responseDelegate;
- (SkuSoapBindingResponse *)updateQuantityUsingParameters:(SkuService_updateQuantity *)aParameters ;
- (void)updateQuantityAsyncUsingParameters:(SkuService_updateQuantity *)aParameters  delegate:(id<SkuSoapBindingResponseDelegate>)responseDelegate;
- (SkuSoapBindingResponse *)getSkuIDForGivenProductNameUsingParameters:(SkuService_getSkuIDForGivenProductName *)aParameters ;
- (void)getSkuIDForGivenProductNameAsyncUsingParameters:(SkuService_getSkuIDForGivenProductName *)aParameters  delegate:(id<SkuSoapBindingResponseDelegate>)responseDelegate;
- (SkuSoapBindingResponse *)searchProductUsingParameters:(SkuService_searchProduct *)aParameters ;
- (void)searchProductAsyncUsingParameters:(SkuService_searchProduct *)aParameters  delegate:(id<SkuSoapBindingResponseDelegate>)responseDelegate;
@end
@interface SkuSoapBindingOperation : NSOperation {
	SkuSoapBinding *binding;
	SkuSoapBindingResponse * response;
	id<SkuSoapBindingResponseDelegate>  delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (strong) SkuSoapBinding *binding;
@property (  readonly) SkuSoapBindingResponse *response;
@property (nonatomic ) id<SkuSoapBindingResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(SkuSoapBinding *)aBinding delegate:(id<SkuSoapBindingResponseDelegate>)aDelegate;
@end
@interface SkuSoapBinding_getSkuDetails : SkuSoapBindingOperation {
	SkuService_getSkuDetails * parameters;
}
@property (strong) SkuService_getSkuDetails * parameters;
- (id)initWithBinding:(SkuSoapBinding *)aBinding delegate:(id<SkuSoapBindingResponseDelegate>)aDelegate
	parameters:(SkuService_getSkuDetails *)aParameters
;
@end
@interface SkuSoapBinding_getSkuDetailsForStocks : SkuSoapBindingOperation {
	SkuService_getSkuDetailsForStocks * parameters;
}
@property (strong) SkuService_getSkuDetailsForStocks * parameters;
- (id)initWithBinding:(SkuSoapBinding *)aBinding delegate:(id<SkuSoapBindingResponseDelegate>)aDelegate
	parameters:(SkuService_getSkuDetailsForStocks *)aParameters
;
@end
@interface SkuSoapBinding_getProductDetails : SkuSoapBindingOperation {
	SkuService_getProductDetails * parameters;
}
@property (strong) SkuService_getProductDetails * parameters;
- (id)initWithBinding:(SkuSoapBinding *)aBinding delegate:(id<SkuSoapBindingResponseDelegate>)aDelegate
	parameters:(SkuService_getProductDetails *)aParameters
;
@end
@interface SkuSoapBinding_getSkuID : SkuSoapBindingOperation {
	SkuService_getSkuID * parameters;
}
@property (strong) SkuService_getSkuID * parameters;
- (id)initWithBinding:(SkuSoapBinding *)aBinding delegate:(id<SkuSoapBindingResponseDelegate>)aDelegate
	parameters:(SkuService_getSkuID *)aParameters
;
@end
@interface SkuSoapBinding_getProductNames : SkuSoapBindingOperation {
	SkuService_getProductNames * parameters;
}
@property (strong) SkuService_getProductNames * parameters;
- (id)initWithBinding:(SkuSoapBinding *)aBinding delegate:(id<SkuSoapBindingResponseDelegate>)aDelegate
	parameters:(SkuService_getProductNames *)aParameters
;
@end
@interface SkuSoapBinding_updateQuantity : SkuSoapBindingOperation {
	SkuService_updateQuantity * parameters;
}
@property (strong) SkuService_updateQuantity * parameters;
- (id)initWithBinding:(SkuSoapBinding *)aBinding delegate:(id<SkuSoapBindingResponseDelegate>)aDelegate
	parameters:(SkuService_updateQuantity *)aParameters
;
@end
@interface SkuSoapBinding_getSkuIDForGivenProductName : SkuSoapBindingOperation {
	SkuService_getSkuIDForGivenProductName * parameters;
}
@property (strong) SkuService_getSkuIDForGivenProductName * parameters;
- (id)initWithBinding:(SkuSoapBinding *)aBinding delegate:(id<SkuSoapBindingResponseDelegate>)aDelegate
	parameters:(SkuService_getSkuIDForGivenProductName *)aParameters
;
@end
@interface SkuSoapBinding_searchProduct : SkuSoapBindingOperation {
	SkuService_searchProduct * parameters;
}
@property (strong) SkuService_searchProduct * parameters;
- (id)initWithBinding:(SkuSoapBinding *)aBinding delegate:(id<SkuSoapBindingResponseDelegate>)aDelegate
	parameters:(SkuService_searchProduct *)aParameters
;
@end
@interface SkuSoapBinding_envelope : NSObject {
}
+ (SkuSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface SkuSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end
