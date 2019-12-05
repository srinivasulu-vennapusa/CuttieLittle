#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class ProductsServiceSvc_getAllProductsWithCategory;
@class ProductsServiceSvc_getAllProductsWithCategoryResponse;
@class ProductsServiceSvc_getProductDetails;
@class ProductsServiceSvc_getProductDetailsResponse;
@class ProductsServiceSvc_getProductsByCategory;
@class ProductsServiceSvc_getProductsByCategoryResponse;
@class ProductsServiceSvc_helloworld;
@class ProductsServiceSvc_helloworldResponse;
@interface ProductsServiceSvc_getAllProductsWithCategory : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ProductsServiceSvc_getAllProductsWithCategory *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ProductsServiceSvc_getAllProductsWithCategoryResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ProductsServiceSvc_getAllProductsWithCategoryResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ProductsServiceSvc_getProductDetails : NSObject {
	
/* elements */
	NSString * product;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ProductsServiceSvc_getProductDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * product;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ProductsServiceSvc_getProductDetailsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ProductsServiceSvc_getProductDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ProductsServiceSvc_getProductsByCategory : NSObject {
	
/* elements */
	NSString * category;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ProductsServiceSvc_getProductsByCategory *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * category;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ProductsServiceSvc_getProductsByCategoryResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ProductsServiceSvc_getProductsByCategoryResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ProductsServiceSvc_helloworld : NSObject {
	
/* elements */
	NSString * testString;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ProductsServiceSvc_helloworld *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * testString;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ProductsServiceSvc_helloworldResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ProductsServiceSvc_helloworldResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "ProductsServiceSvc.h"
@class ProductsServiceSoapBinding;
@interface ProductsServiceSvc : NSObject {
	
}
+ (ProductsServiceSoapBinding *)ProductsServiceSoapBinding;
@end
@class ProductsServiceSoapBindingResponse;
@class ProductsServiceSoapBindingOperation;
@protocol ProductsServiceSoapBindingResponseDelegate <NSObject>
- (void) operation:(ProductsServiceSoapBindingOperation *)operation completedWithResponse:(ProductsServiceSoapBindingResponse *)response;
@end
@interface ProductsServiceSoapBinding : NSObject <ProductsServiceSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(ProductsServiceSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (ProductsServiceSoapBindingResponse *)getProductsByCategoryUsingParameters:(ProductsServiceSvc_getProductsByCategory *)aParameters ;
- (void)getProductsByCategoryAsyncUsingParameters:(ProductsServiceSvc_getProductsByCategory *)aParameters  delegate:(id<ProductsServiceSoapBindingResponseDelegate>)responseDelegate;
- (ProductsServiceSoapBindingResponse *)helloworldUsingParameters:(ProductsServiceSvc_helloworld *)aParameters ;
- (void)helloworldAsyncUsingParameters:(ProductsServiceSvc_helloworld *)aParameters  delegate:(id<ProductsServiceSoapBindingResponseDelegate>)responseDelegate;
- (ProductsServiceSoapBindingResponse *)getProductDetailsUsingParameters:(ProductsServiceSvc_getProductDetails *)aParameters ;
- (void)getProductDetailsAsyncUsingParameters:(ProductsServiceSvc_getProductDetails *)aParameters  delegate:(id<ProductsServiceSoapBindingResponseDelegate>)responseDelegate;
- (ProductsServiceSoapBindingResponse *)getAllProductsWithCategoryUsingParameters:(ProductsServiceSvc_getAllProductsWithCategory *)aParameters ;
- (void)getAllProductsWithCategoryAsyncUsingParameters:(ProductsServiceSvc_getAllProductsWithCategory *)aParameters  delegate:(id<ProductsServiceSoapBindingResponseDelegate>)responseDelegate;
@end
@interface ProductsServiceSoapBindingOperation : NSOperation {
	ProductsServiceSoapBinding *binding;
	ProductsServiceSoapBindingResponse * response;
	id<ProductsServiceSoapBindingResponseDelegate>  delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (strong) ProductsServiceSoapBinding *binding;
@property (  readonly) ProductsServiceSoapBindingResponse *response;
@property (nonatomic ) id<ProductsServiceSoapBindingResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(ProductsServiceSoapBinding *)aBinding delegate:(id<ProductsServiceSoapBindingResponseDelegate>)aDelegate;
@end
@interface ProductsServiceSoapBinding_getProductsByCategory : ProductsServiceSoapBindingOperation {
	ProductsServiceSvc_getProductsByCategory * parameters;
}
@property (strong) ProductsServiceSvc_getProductsByCategory * parameters;
- (id)initWithBinding:(ProductsServiceSoapBinding *)aBinding delegate:(id<ProductsServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(ProductsServiceSvc_getProductsByCategory *)aParameters
;
@end
@interface ProductsServiceSoapBinding_helloworld : ProductsServiceSoapBindingOperation {
	ProductsServiceSvc_helloworld * parameters;
}
@property (strong) ProductsServiceSvc_helloworld * parameters;
- (id)initWithBinding:(ProductsServiceSoapBinding *)aBinding delegate:(id<ProductsServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(ProductsServiceSvc_helloworld *)aParameters
;
@end
@interface ProductsServiceSoapBinding_getProductDetails : ProductsServiceSoapBindingOperation {
	ProductsServiceSvc_getProductDetails * parameters;
}
@property (strong) ProductsServiceSvc_getProductDetails * parameters;
- (id)initWithBinding:(ProductsServiceSoapBinding *)aBinding delegate:(id<ProductsServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(ProductsServiceSvc_getProductDetails *)aParameters
;
@end
@interface ProductsServiceSoapBinding_getAllProductsWithCategory : ProductsServiceSoapBindingOperation {
	ProductsServiceSvc_getAllProductsWithCategory * parameters;
}
@property (strong) ProductsServiceSvc_getAllProductsWithCategory * parameters;
- (id)initWithBinding:(ProductsServiceSoapBinding *)aBinding delegate:(id<ProductsServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(ProductsServiceSvc_getAllProductsWithCategory *)aParameters
;
@end
@interface ProductsServiceSoapBinding_envelope : NSObject {
}
+ (ProductsServiceSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface ProductsServiceSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end
