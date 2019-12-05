#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class ProductMasterServiceSvc_createProduct;
@class ProductMasterServiceSvc_createProductResponse;
@class ProductMasterServiceSvc_deleteProducts;
@class ProductMasterServiceSvc_deleteProductsResponse;
@class ProductMasterServiceSvc_getProductDetails;
@class ProductMasterServiceSvc_getProductDetailsResponse;
@class ProductMasterServiceSvc_getProducts;
@class ProductMasterServiceSvc_getProductsResponse;
@class ProductMasterServiceSvc_updateProduct;
@class ProductMasterServiceSvc_updateProductResponse;
@interface ProductMasterServiceSvc_createProduct : NSObject {
	
/* elements */
	NSString * productDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ProductMasterServiceSvc_createProduct *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * productDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ProductMasterServiceSvc_createProductResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ProductMasterServiceSvc_createProductResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ProductMasterServiceSvc_deleteProducts : NSObject {
	
/* elements */
	NSString * productIds;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ProductMasterServiceSvc_deleteProducts *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * productIds;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ProductMasterServiceSvc_deleteProductsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ProductMasterServiceSvc_deleteProductsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ProductMasterServiceSvc_getProductDetails : NSObject {
	
/* elements */
	NSString * productIds;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ProductMasterServiceSvc_getProductDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * productIds;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ProductMasterServiceSvc_getProductDetailsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ProductMasterServiceSvc_getProductDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ProductMasterServiceSvc_getProducts : NSObject {
	
/* elements */
	NSString * productMasterSearchCriteria;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ProductMasterServiceSvc_getProducts *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * productMasterSearchCriteria;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ProductMasterServiceSvc_getProductsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ProductMasterServiceSvc_getProductsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ProductMasterServiceSvc_updateProduct : NSObject {
	
/* elements */
	NSString * productDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ProductMasterServiceSvc_updateProduct *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * productDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ProductMasterServiceSvc_updateProductResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ProductMasterServiceSvc_updateProductResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "ProductMasterServiceSvc.h"
@class ProductMasterServiceSoapBinding;
@interface ProductMasterServiceSvc : NSObject {
	
}
+ (ProductMasterServiceSoapBinding *)ProductMasterServiceSoapBinding;
@end
@class ProductMasterServiceSoapBindingResponse;
@class ProductMasterServiceSoapBindingOperation;
@protocol ProductMasterServiceSoapBindingResponseDelegate <NSObject>
- (void) operation:(ProductMasterServiceSoapBindingOperation *)operation completedWithResponse:(ProductMasterServiceSoapBindingResponse *)response;
@end
@interface ProductMasterServiceSoapBinding : NSObject <ProductMasterServiceSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(ProductMasterServiceSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (ProductMasterServiceSoapBindingResponse *)deleteProductsUsingParameters:(ProductMasterServiceSvc_deleteProducts *)aParameters ;
- (void)deleteProductsAsyncUsingParameters:(ProductMasterServiceSvc_deleteProducts *)aParameters  delegate:(id<ProductMasterServiceSoapBindingResponseDelegate>)responseDelegate;
- (ProductMasterServiceSoapBindingResponse *)createProductUsingParameters:(ProductMasterServiceSvc_createProduct *)aParameters ;
- (void)createProductAsyncUsingParameters:(ProductMasterServiceSvc_createProduct *)aParameters  delegate:(id<ProductMasterServiceSoapBindingResponseDelegate>)responseDelegate;
- (ProductMasterServiceSoapBindingResponse *)getProductDetailsUsingParameters:(ProductMasterServiceSvc_getProductDetails *)aParameters ;
- (void)getProductDetailsAsyncUsingParameters:(ProductMasterServiceSvc_getProductDetails *)aParameters  delegate:(id<ProductMasterServiceSoapBindingResponseDelegate>)responseDelegate;
- (ProductMasterServiceSoapBindingResponse *)getProductsUsingParameters:(ProductMasterServiceSvc_getProducts *)aParameters ;
- (void)getProductsAsyncUsingParameters:(ProductMasterServiceSvc_getProducts *)aParameters  delegate:(id<ProductMasterServiceSoapBindingResponseDelegate>)responseDelegate;
- (ProductMasterServiceSoapBindingResponse *)updateProductUsingParameters:(ProductMasterServiceSvc_updateProduct *)aParameters ;
- (void)updateProductAsyncUsingParameters:(ProductMasterServiceSvc_updateProduct *)aParameters  delegate:(id<ProductMasterServiceSoapBindingResponseDelegate>)responseDelegate;
@end
@interface ProductMasterServiceSoapBindingOperation : NSOperation {
	ProductMasterServiceSoapBinding *binding;
	ProductMasterServiceSoapBindingResponse * response;
	id<ProductMasterServiceSoapBindingResponseDelegate>  delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (strong) ProductMasterServiceSoapBinding *binding;
@property (  readonly) ProductMasterServiceSoapBindingResponse *response;
@property (nonatomic ) id<ProductMasterServiceSoapBindingResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(ProductMasterServiceSoapBinding *)aBinding delegate:(id<ProductMasterServiceSoapBindingResponseDelegate>)aDelegate;
@end
@interface ProductMasterServiceSoapBinding_deleteProducts : ProductMasterServiceSoapBindingOperation {
	ProductMasterServiceSvc_deleteProducts * parameters;
}
@property (strong) ProductMasterServiceSvc_deleteProducts * parameters;
- (id)initWithBinding:(ProductMasterServiceSoapBinding *)aBinding delegate:(id<ProductMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(ProductMasterServiceSvc_deleteProducts *)aParameters
;
@end
@interface ProductMasterServiceSoapBinding_createProduct : ProductMasterServiceSoapBindingOperation {
	ProductMasterServiceSvc_createProduct * parameters;
}
@property (strong) ProductMasterServiceSvc_createProduct * parameters;
- (id)initWithBinding:(ProductMasterServiceSoapBinding *)aBinding delegate:(id<ProductMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(ProductMasterServiceSvc_createProduct *)aParameters
;
@end
@interface ProductMasterServiceSoapBinding_getProductDetails : ProductMasterServiceSoapBindingOperation {
	ProductMasterServiceSvc_getProductDetails * parameters;
}
@property (strong) ProductMasterServiceSvc_getProductDetails * parameters;
- (id)initWithBinding:(ProductMasterServiceSoapBinding *)aBinding delegate:(id<ProductMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(ProductMasterServiceSvc_getProductDetails *)aParameters
;
@end
@interface ProductMasterServiceSoapBinding_getProducts : ProductMasterServiceSoapBindingOperation {
	ProductMasterServiceSvc_getProducts * parameters;
}
@property (strong) ProductMasterServiceSvc_getProducts * parameters;
- (id)initWithBinding:(ProductMasterServiceSoapBinding *)aBinding delegate:(id<ProductMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(ProductMasterServiceSvc_getProducts *)aParameters
;
@end
@interface ProductMasterServiceSoapBinding_updateProduct : ProductMasterServiceSoapBindingOperation {
	ProductMasterServiceSvc_updateProduct * parameters;
}
@property (strong) ProductMasterServiceSvc_updateProduct * parameters;
- (id)initWithBinding:(ProductMasterServiceSoapBinding *)aBinding delegate:(id<ProductMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(ProductMasterServiceSvc_updateProduct *)aParameters
;
@end
@interface ProductMasterServiceSoapBinding_envelope : NSObject {
}
+ (ProductMasterServiceSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface ProductMasterServiceSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end
