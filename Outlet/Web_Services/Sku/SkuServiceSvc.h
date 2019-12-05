#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class SkuServiceSvc_createSKU;
@class SkuServiceSvc_createSKUResponse;
@class SkuServiceSvc_getLastUpdatedDate;
@class SkuServiceSvc_getLastUpdatedDateResponse;
@class SkuServiceSvc_getProductDetails;
@class SkuServiceSvc_getProductDetailsResponse;
@class SkuServiceSvc_getProductNames;
@class SkuServiceSvc_getProductNamesResponse;
@class SkuServiceSvc_getProducts;
@class SkuServiceSvc_getProductsResponse;
@class SkuServiceSvc_getSKUDetails;
@class SkuServiceSvc_getSKUDetailsResponse;
@class SkuServiceSvc_getSkuDetails;
@class SkuServiceSvc_getSkuDetailsForStocks;
@class SkuServiceSvc_getSkuDetailsForStocksResponse;
@class SkuServiceSvc_getSkuDetailsResponse;
@class SkuServiceSvc_getSkuID;
@class SkuServiceSvc_getSkuIDForGivenProductName;
@class SkuServiceSvc_getSkuIDForGivenProductNameResponse;
@class SkuServiceSvc_getSkuIDResponse;
@class SkuServiceSvc_getSkuPriceList;
@class SkuServiceSvc_getSkuPriceListResponse;
@class SkuServiceSvc_searchProduct;
@class SkuServiceSvc_searchProductResponse;
@class SkuServiceSvc_searchProducts;
@class SkuServiceSvc_searchProductsResponse;
@class SkuServiceSvc_updateSKU;
@class SkuServiceSvc_updateSKUResponse;
@interface SkuServiceSvc_createSKU : NSObject {
    
    /* elements */
    NSString * skuDetails;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuServiceSvc_createSKU *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * skuDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuServiceSvc_createSKUResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuServiceSvc_createSKUResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuServiceSvc_getLastUpdatedDate : NSObject {
    
    /* elements */
    NSString * tableName;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuServiceSvc_getLastUpdatedDate *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * tableName;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuServiceSvc_getLastUpdatedDateResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuServiceSvc_getLastUpdatedDateResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuServiceSvc_getProductDetails : NSObject {
    
    /* elements */
    NSString * productName;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuServiceSvc_getProductDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * productName;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuServiceSvc_getProductDetailsResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuServiceSvc_getProductDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuServiceSvc_getProductNames : NSObject {
    
    /* elements */
    NSString * requestHeader;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuServiceSvc_getProductNames *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * requestHeader;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuServiceSvc_getProductNamesResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuServiceSvc_getProductNamesResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuServiceSvc_getProducts : NSObject {
    
    /* elements */
    NSString * getProductsRequest;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuServiceSvc_getProducts *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * getProductsRequest;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuServiceSvc_getProductsResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuServiceSvc_getProductsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuServiceSvc_getSKUDetails : NSObject {
    
    /* elements */
    NSString * skuDetails;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuServiceSvc_getSKUDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * skuDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuServiceSvc_getSKUDetailsResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuServiceSvc_getSKUDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuServiceSvc_getSkuDetails : NSObject {
    
    /* elements */
    NSString * skuID;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuServiceSvc_getSkuDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * skuID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuServiceSvc_getSkuDetailsForStocks : NSObject {
    
    /* elements */
    NSString * skuID;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuServiceSvc_getSkuDetailsForStocks *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * skuID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuServiceSvc_getSkuDetailsForStocksResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuServiceSvc_getSkuDetailsForStocksResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuServiceSvc_getSkuDetailsResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuServiceSvc_getSkuDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuServiceSvc_getSkuID : NSObject {
    
    /* elements */
    NSString * requestHeader;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuServiceSvc_getSkuID *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * requestHeader;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuServiceSvc_getSkuIDForGivenProductName : NSObject {
    
    /* elements */
    NSString * productName;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuServiceSvc_getSkuIDForGivenProductName *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * productName;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuServiceSvc_getSkuIDForGivenProductNameResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuServiceSvc_getSkuIDForGivenProductNameResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuServiceSvc_getSkuIDResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuServiceSvc_getSkuIDResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuServiceSvc_getSkuPriceList : NSObject {
    
    /* elements */
    NSString * skuDetails;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuServiceSvc_getSkuPriceList *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * skuDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuServiceSvc_getSkuPriceListResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuServiceSvc_getSkuPriceListResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuServiceSvc_searchProduct : NSObject {
    
    /* elements */
    NSString * searchCriteria;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuServiceSvc_searchProduct *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * searchCriteria;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuServiceSvc_searchProductResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuServiceSvc_searchProductResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuServiceSvc_searchProducts : NSObject {
    
    /* elements */
    NSString * searchCriteria;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuServiceSvc_searchProducts *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * searchCriteria;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuServiceSvc_searchProductsResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuServiceSvc_searchProductsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuServiceSvc_updateSKU : NSObject {
    
    /* elements */
    NSString * skuDetails;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuServiceSvc_updateSKU *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * skuDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SkuServiceSvc_updateSKUResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SkuServiceSvc_updateSKUResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "SkuServiceSvc.h"
@class SkuServiceSoapBinding;
@interface SkuServiceSvc : NSObject {
    
}
+ (SkuServiceSoapBinding *)SkuServiceSoapBinding;
@end
@class SkuServiceSoapBindingResponse;
@class SkuServiceSoapBindingOperation;
@protocol SkuServiceSoapBindingResponseDelegate <NSObject>
- (void) operation:(SkuServiceSoapBindingOperation *)operation completedWithResponse:(SkuServiceSoapBindingResponse *)response;
@end
@interface SkuServiceSoapBinding : NSObject <SkuServiceSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(SkuServiceSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;

- (SkuServiceSoapBindingResponse *)getSkuPriceListUsingParameters:(SkuServiceSvc_getSkuPriceList *)aParameters ;
- (void)getSkuPriceListAsyncUsingParameters:(SkuServiceSvc_getSkuPriceList *)aParameters  delegate:(id<SkuServiceSoapBindingResponseDelegate>)responseDelegate;
- (SkuServiceSoapBindingResponse *)getSkuDetailsUsingParameters:(SkuServiceSvc_getSkuDetails *)aParameters ;
- (void)getSkuDetailsAsyncUsingParameters:(SkuServiceSvc_getSkuDetails *)aParameters  delegate:(id<SkuServiceSoapBindingResponseDelegate>)responseDelegate;

- (SkuServiceSoapBindingResponse *)getProductsUsingParameters:(SkuServiceSvc_getProducts *)aParameters ;
- (void)getProductsAsyncUsingParameters:(SkuServiceSvc_getProducts *)aParameters  delegate:(id<SkuServiceSoapBindingResponseDelegate>)responseDelegate;
- (SkuServiceSoapBindingResponse *)getSKUDetailsUsingParameters:(SkuServiceSvc_getSKUDetails *)aParameters ;
- (void)getSKUDetailsAsyncUsingParameters:(SkuServiceSvc_getSKUDetails *)aParameters  delegate:(id<SkuServiceSoapBindingResponseDelegate>)responseDelegate;
- (SkuServiceSoapBindingResponse *)getSkuIDForGivenProductNameUsingParameters:(SkuServiceSvc_getSkuIDForGivenProductName *)aParameters ;
- (void)getSkuIDForGivenProductNameAsyncUsingParameters:(SkuServiceSvc_getSkuIDForGivenProductName *)aParameters  delegate:(id<SkuServiceSoapBindingResponseDelegate>)responseDelegate;
- (SkuServiceSoapBindingResponse *)getSkuDetailsForStocksUsingParameters:(SkuServiceSvc_getSkuDetailsForStocks *)aParameters ;
- (void)getSkuDetailsForStocksAsyncUsingParameters:(SkuServiceSvc_getSkuDetailsForStocks *)aParameters  delegate:(id<SkuServiceSoapBindingResponseDelegate>)responseDelegate;
- (SkuServiceSoapBindingResponse *)getLastUpdatedDateUsingParameters:(SkuServiceSvc_getLastUpdatedDate *)aParameters ;
- (void)getLastUpdatedDateAsyncUsingParameters:(SkuServiceSvc_getLastUpdatedDate *)aParameters  delegate:(id<SkuServiceSoapBindingResponseDelegate>)responseDelegate;
- (SkuServiceSoapBindingResponse *)createSKUUsingParameters:(SkuServiceSvc_createSKU *)aParameters ;
- (void)createSKUAsyncUsingParameters:(SkuServiceSvc_createSKU *)aParameters  delegate:(id<SkuServiceSoapBindingResponseDelegate>)responseDelegate;
- (SkuServiceSoapBindingResponse *)searchProductsUsingParameters:(SkuServiceSvc_searchProducts *)aParameters ;
- (void)searchProductsAsyncUsingParameters:(SkuServiceSvc_searchProducts *)aParameters  delegate:(id<SkuServiceSoapBindingResponseDelegate>)responseDelegate;
- (SkuServiceSoapBindingResponse *)updateSKUUsingParameters:(SkuServiceSvc_updateSKU *)aParameters ;
- (void)updateSKUAsyncUsingParameters:(SkuServiceSvc_updateSKU *)aParameters  delegate:(id<SkuServiceSoapBindingResponseDelegate>)responseDelegate;
- (SkuServiceSoapBindingResponse *)getSkuIDUsingParameters:(SkuServiceSvc_getSkuID *)aParameters ;
- (void)getSkuIDAsyncUsingParameters:(SkuServiceSvc_getSkuID *)aParameters  delegate:(id<SkuServiceSoapBindingResponseDelegate>)responseDelegate;
- (SkuServiceSoapBindingResponse *)searchProductUsingParameters:(SkuServiceSvc_searchProduct *)aParameters ;
- (void)searchProductAsyncUsingParameters:(SkuServiceSvc_searchProduct *)aParameters  delegate:(id<SkuServiceSoapBindingResponseDelegate>)responseDelegate;
- (SkuServiceSoapBindingResponse *)getProductDetailsUsingParameters:(SkuServiceSvc_getProductDetails *)aParameters ;
- (void)getProductDetailsAsyncUsingParameters:(SkuServiceSvc_getProductDetails *)aParameters  delegate:(id<SkuServiceSoapBindingResponseDelegate>)responseDelegate;
- (SkuServiceSoapBindingResponse *)getProductNamesUsingParameters:(SkuServiceSvc_getProductNames *)aParameters ;
- (void)getProductNamesAsyncUsingParameters:(SkuServiceSvc_getProductNames *)aParameters  delegate:(id<SkuServiceSoapBindingResponseDelegate>)responseDelegate;
@end
@interface SkuServiceSoapBindingOperation : NSOperation {
    SkuServiceSoapBinding *binding;
    SkuServiceSoapBindingResponse * response;
    id<SkuServiceSoapBindingResponseDelegate>  delegate;
    NSMutableData *responseData;
    NSURLConnection *urlConnection;
}
@property (strong) SkuServiceSoapBinding *binding;
@property (  readonly) SkuServiceSoapBindingResponse *response;
@property (nonatomic ) id<SkuServiceSoapBindingResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(SkuServiceSoapBinding *)aBinding delegate:(id<SkuServiceSoapBindingResponseDelegate>)aDelegate;
@end
@interface SkuServiceSoapBinding_getSkuPriceList : SkuServiceSoapBindingOperation {
    SkuServiceSvc_getSkuPriceList * parameters;
}
@property (strong) SkuServiceSvc_getSkuPriceList * parameters;
- (id)initWithBinding:(SkuServiceSoapBinding *)aBinding delegate:(id<SkuServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(SkuServiceSvc_getSkuPriceList *)aParameters
;
@end
@interface SkuServiceSoapBinding_getSkuDetails : SkuServiceSoapBindingOperation {
    SkuServiceSvc_getSkuDetails * parameters;
}
@property (strong) SkuServiceSvc_getSkuDetails * parameters;
- (id)initWithBinding:(SkuServiceSoapBinding *)aBinding delegate:(id<SkuServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(SkuServiceSvc_getSkuDetails *)aParameters
;
@end
@interface SkuServiceSoapBinding_getProducts : SkuServiceSoapBindingOperation {
    SkuServiceSvc_getProducts * parameters;
}
@property (retain) SkuServiceSvc_getProducts * parameters;
- (id)initWithBinding:(SkuServiceSoapBinding *)aBinding delegate:(id<SkuServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(SkuServiceSvc_getProducts *)aParameters
;
@end
@interface SkuServiceSoapBinding_getSKUDetails : SkuServiceSoapBindingOperation {
    SkuServiceSvc_getSKUDetails * parameters;
}
@property (retain) SkuServiceSvc_getSKUDetails * parameters;
- (id)initWithBinding:(SkuServiceSoapBinding *)aBinding delegate:(id<SkuServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(SkuServiceSvc_getSKUDetails *)aParameters
;
@end
@interface SkuServiceSoapBinding_getSkuIDForGivenProductName : SkuServiceSoapBindingOperation {
    SkuServiceSvc_getSkuIDForGivenProductName * parameters;
}
@property (strong) SkuServiceSvc_getSkuIDForGivenProductName * parameters;
- (id)initWithBinding:(SkuServiceSoapBinding *)aBinding delegate:(id<SkuServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(SkuServiceSvc_getSkuIDForGivenProductName *)aParameters
;
@end
@interface SkuServiceSoapBinding_getSkuDetailsForStocks : SkuServiceSoapBindingOperation {
    SkuServiceSvc_getSkuDetailsForStocks * parameters;
}
@property (strong) SkuServiceSvc_getSkuDetailsForStocks * parameters;
- (id)initWithBinding:(SkuServiceSoapBinding *)aBinding delegate:(id<SkuServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(SkuServiceSvc_getSkuDetailsForStocks *)aParameters
;
@end
@interface SkuServiceSoapBinding_getLastUpdatedDate : SkuServiceSoapBindingOperation {
    SkuServiceSvc_getLastUpdatedDate * parameters;
}
@property (retain) SkuServiceSvc_getLastUpdatedDate * parameters;
- (id)initWithBinding:(SkuServiceSoapBinding *)aBinding delegate:(id<SkuServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(SkuServiceSvc_getLastUpdatedDate *)aParameters
;
@end
@interface SkuServiceSoapBinding_createSKU : SkuServiceSoapBindingOperation {
    SkuServiceSvc_createSKU * parameters;
}
@property (retain) SkuServiceSvc_createSKU * parameters;
- (id)initWithBinding:(SkuServiceSoapBinding *)aBinding delegate:(id<SkuServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(SkuServiceSvc_createSKU *)aParameters
;
@end
@interface SkuServiceSoapBinding_searchProducts : SkuServiceSoapBindingOperation {
    SkuServiceSvc_searchProducts * parameters;
}
@property (strong) SkuServiceSvc_searchProducts * parameters;
- (id)initWithBinding:(SkuServiceSoapBinding *)aBinding delegate:(id<SkuServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(SkuServiceSvc_searchProducts *)aParameters
;
@end
@interface SkuServiceSoapBinding_updateSKU : SkuServiceSoapBindingOperation {
    SkuServiceSvc_updateSKU * parameters;
}
@property (retain) SkuServiceSvc_updateSKU * parameters;
- (id)initWithBinding:(SkuServiceSoapBinding *)aBinding delegate:(id<SkuServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(SkuServiceSvc_updateSKU *)aParameters
;
@end
@interface SkuServiceSoapBinding_getSkuID : SkuServiceSoapBindingOperation {
    SkuServiceSvc_getSkuID * parameters;
}
@property (strong) SkuServiceSvc_getSkuID * parameters;
- (id)initWithBinding:(SkuServiceSoapBinding *)aBinding delegate:(id<SkuServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(SkuServiceSvc_getSkuID *)aParameters
;
@end
@interface SkuServiceSoapBinding_searchProduct : SkuServiceSoapBindingOperation {
    SkuServiceSvc_searchProduct * parameters;
}
@property (strong) SkuServiceSvc_searchProduct * parameters;
- (id)initWithBinding:(SkuServiceSoapBinding *)aBinding delegate:(id<SkuServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(SkuServiceSvc_searchProduct *)aParameters
;
@end
@interface SkuServiceSoapBinding_getProductDetails : SkuServiceSoapBindingOperation {
    SkuServiceSvc_getProductDetails * parameters;
}
@property (strong) SkuServiceSvc_getProductDetails * parameters;
- (id)initWithBinding:(SkuServiceSoapBinding *)aBinding delegate:(id<SkuServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(SkuServiceSvc_getProductDetails *)aParameters
;
@end
@interface SkuServiceSoapBinding_getProductNames : SkuServiceSoapBindingOperation {
    SkuServiceSvc_getProductNames * parameters;
}
@property (strong) SkuServiceSvc_getProductNames * parameters;
- (id)initWithBinding:(SkuServiceSoapBinding *)aBinding delegate:(id<SkuServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(SkuServiceSvc_getProductNames *)aParameters
;
@end
@interface SkuServiceSoapBinding_envelope : NSObject {
}
+ (SkuServiceSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface SkuServiceSoapBindingResponse : NSObject {
    NSArray *headers;
    NSArray *bodyParts;
    NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end
