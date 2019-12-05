#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class RawMaterialServiceSvc_getAllFinishedProducts;
@class RawMaterialServiceSvc_getAllFinishedProductsResponse;
@class RawMaterialServiceSvc_getMaterialStockDetailsByStockType;
@class RawMaterialServiceSvc_getMaterialStockDetailsByStockTypeResponse;
@class RawMaterialServiceSvc_getRawMaterial;
@class RawMaterialServiceSvc_getRawMaterialDetails;
@class RawMaterialServiceSvc_getRawMaterialDetailsResponse;
@class RawMaterialServiceSvc_getRawMaterialResponse;
@class RawMaterialServiceSvc_getSkuDetailsForMaterialStock;
@class RawMaterialServiceSvc_getSkuDetailsForMaterialStockResponse;
@class RawMaterialServiceSvc_searchMaterialStockPagination;
@class RawMaterialServiceSvc_searchMaterialStockPaginationResponse;
@interface RawMaterialServiceSvc_getAllFinishedProducts : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (RawMaterialServiceSvc_getAllFinishedProducts *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface RawMaterialServiceSvc_getAllFinishedProductsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (RawMaterialServiceSvc_getAllFinishedProductsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface RawMaterialServiceSvc_getMaterialStockDetailsByStockType : NSObject {
	
/* elements */
	NSString * stockType;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (RawMaterialServiceSvc_getMaterialStockDetailsByStockType *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * stockType;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface RawMaterialServiceSvc_getMaterialStockDetailsByStockTypeResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (RawMaterialServiceSvc_getMaterialStockDetailsByStockTypeResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface RawMaterialServiceSvc_getRawMaterial : NSObject {
	
/* elements */
	NSString * searchCriteria;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (RawMaterialServiceSvc_getRawMaterial *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * searchCriteria;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface RawMaterialServiceSvc_getRawMaterialDetails : NSObject {
	
/* elements */
	NSString * skuId;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (RawMaterialServiceSvc_getRawMaterialDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * skuId;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface RawMaterialServiceSvc_getRawMaterialDetailsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (RawMaterialServiceSvc_getRawMaterialDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface RawMaterialServiceSvc_getRawMaterialResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (RawMaterialServiceSvc_getRawMaterialResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface RawMaterialServiceSvc_getSkuDetailsForMaterialStock : NSObject {
	
/* elements */
	NSString * skuID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (RawMaterialServiceSvc_getSkuDetailsForMaterialStock *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * skuID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface RawMaterialServiceSvc_getSkuDetailsForMaterialStockResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (RawMaterialServiceSvc_getSkuDetailsForMaterialStockResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface RawMaterialServiceSvc_searchMaterialStockPagination : NSObject {
	
/* elements */
	NSString * stockPagination;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (RawMaterialServiceSvc_searchMaterialStockPagination *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * stockPagination;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface RawMaterialServiceSvc_searchMaterialStockPaginationResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (RawMaterialServiceSvc_searchMaterialStockPaginationResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "RawMaterialServiceSvc.h"
@class RawMaterialServiceSoapBinding;
@interface RawMaterialServiceSvc : NSObject {
	
}
+ (RawMaterialServiceSoapBinding *)RawMaterialServiceSoapBinding;
@end
@class RawMaterialServiceSoapBindingResponse;
@class RawMaterialServiceSoapBindingOperation;
@protocol RawMaterialServiceSoapBindingResponseDelegate <NSObject>
- (void) operation:(RawMaterialServiceSoapBindingOperation *)operation completedWithResponse:(RawMaterialServiceSoapBindingResponse *)response;
@end
@interface RawMaterialServiceSoapBinding : NSObject <RawMaterialServiceSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(RawMaterialServiceSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (RawMaterialServiceSoapBindingResponse *)getSkuDetailsForMaterialStockUsingParameters:(RawMaterialServiceSvc_getSkuDetailsForMaterialStock *)aParameters ;
- (void)getSkuDetailsForMaterialStockAsyncUsingParameters:(RawMaterialServiceSvc_getSkuDetailsForMaterialStock *)aParameters  delegate:(id<RawMaterialServiceSoapBindingResponseDelegate>)responseDelegate;
- (RawMaterialServiceSoapBindingResponse *)getRawMaterialUsingParameters:(RawMaterialServiceSvc_getRawMaterial *)aParameters ;
- (void)getRawMaterialAsyncUsingParameters:(RawMaterialServiceSvc_getRawMaterial *)aParameters  delegate:(id<RawMaterialServiceSoapBindingResponseDelegate>)responseDelegate;
- (RawMaterialServiceSoapBindingResponse *)getMaterialStockDetailsByStockTypeUsingParameters:(RawMaterialServiceSvc_getMaterialStockDetailsByStockType *)aParameters ;
- (void)getMaterialStockDetailsByStockTypeAsyncUsingParameters:(RawMaterialServiceSvc_getMaterialStockDetailsByStockType *)aParameters  delegate:(id<RawMaterialServiceSoapBindingResponseDelegate>)responseDelegate;
- (RawMaterialServiceSoapBindingResponse *)getAllFinishedProductsUsingParameters:(RawMaterialServiceSvc_getAllFinishedProducts *)aParameters ;
- (void)getAllFinishedProductsAsyncUsingParameters:(RawMaterialServiceSvc_getAllFinishedProducts *)aParameters  delegate:(id<RawMaterialServiceSoapBindingResponseDelegate>)responseDelegate;
- (RawMaterialServiceSoapBindingResponse *)searchMaterialStockPaginationUsingParameters:(RawMaterialServiceSvc_searchMaterialStockPagination *)aParameters ;
- (void)searchMaterialStockPaginationAsyncUsingParameters:(RawMaterialServiceSvc_searchMaterialStockPagination *)aParameters  delegate:(id<RawMaterialServiceSoapBindingResponseDelegate>)responseDelegate;
- (RawMaterialServiceSoapBindingResponse *)getRawMaterialDetailsUsingParameters:(RawMaterialServiceSvc_getRawMaterialDetails *)aParameters ;
- (void)getRawMaterialDetailsAsyncUsingParameters:(RawMaterialServiceSvc_getRawMaterialDetails *)aParameters  delegate:(id<RawMaterialServiceSoapBindingResponseDelegate>)responseDelegate;
@end
@interface RawMaterialServiceSoapBindingOperation : NSOperation {
	RawMaterialServiceSoapBinding *binding;
	RawMaterialServiceSoapBindingResponse * response;
	id<RawMaterialServiceSoapBindingResponseDelegate>  delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (strong) RawMaterialServiceSoapBinding *binding;
@property (  readonly) RawMaterialServiceSoapBindingResponse *response;
@property (nonatomic ) id<RawMaterialServiceSoapBindingResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(RawMaterialServiceSoapBinding *)aBinding delegate:(id<RawMaterialServiceSoapBindingResponseDelegate>)aDelegate;
@end
@interface RawMaterialServiceSoapBinding_getSkuDetailsForMaterialStock : RawMaterialServiceSoapBindingOperation {
	RawMaterialServiceSvc_getSkuDetailsForMaterialStock * parameters;
}
@property (strong) RawMaterialServiceSvc_getSkuDetailsForMaterialStock * parameters;
- (id)initWithBinding:(RawMaterialServiceSoapBinding *)aBinding delegate:(id<RawMaterialServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(RawMaterialServiceSvc_getSkuDetailsForMaterialStock *)aParameters
;
@end
@interface RawMaterialServiceSoapBinding_getRawMaterial : RawMaterialServiceSoapBindingOperation {
	RawMaterialServiceSvc_getRawMaterial * parameters;
}
@property (strong) RawMaterialServiceSvc_getRawMaterial * parameters;
- (id)initWithBinding:(RawMaterialServiceSoapBinding *)aBinding delegate:(id<RawMaterialServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(RawMaterialServiceSvc_getRawMaterial *)aParameters
;
@end
@interface RawMaterialServiceSoapBinding_getMaterialStockDetailsByStockType : RawMaterialServiceSoapBindingOperation {
	RawMaterialServiceSvc_getMaterialStockDetailsByStockType * parameters;
}
@property (strong) RawMaterialServiceSvc_getMaterialStockDetailsByStockType * parameters;
- (id)initWithBinding:(RawMaterialServiceSoapBinding *)aBinding delegate:(id<RawMaterialServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(RawMaterialServiceSvc_getMaterialStockDetailsByStockType *)aParameters
;
@end
@interface RawMaterialServiceSoapBinding_getAllFinishedProducts : RawMaterialServiceSoapBindingOperation {
	RawMaterialServiceSvc_getAllFinishedProducts * parameters;
}
@property (strong) RawMaterialServiceSvc_getAllFinishedProducts * parameters;
- (id)initWithBinding:(RawMaterialServiceSoapBinding *)aBinding delegate:(id<RawMaterialServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(RawMaterialServiceSvc_getAllFinishedProducts *)aParameters
;
@end
@interface RawMaterialServiceSoapBinding_searchMaterialStockPagination : RawMaterialServiceSoapBindingOperation {
	RawMaterialServiceSvc_searchMaterialStockPagination * parameters;
}
@property (strong) RawMaterialServiceSvc_searchMaterialStockPagination * parameters;
- (id)initWithBinding:(RawMaterialServiceSoapBinding *)aBinding delegate:(id<RawMaterialServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(RawMaterialServiceSvc_searchMaterialStockPagination *)aParameters
;
@end
@interface RawMaterialServiceSoapBinding_getRawMaterialDetails : RawMaterialServiceSoapBindingOperation {
	RawMaterialServiceSvc_getRawMaterialDetails * parameters;
}
@property (strong) RawMaterialServiceSvc_getRawMaterialDetails * parameters;
- (id)initWithBinding:(RawMaterialServiceSoapBinding *)aBinding delegate:(id<RawMaterialServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(RawMaterialServiceSvc_getRawMaterialDetails *)aParameters
;
@end
@interface RawMaterialServiceSoapBinding_envelope : NSObject {
}
+ (RawMaterialServiceSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface RawMaterialServiceSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end
