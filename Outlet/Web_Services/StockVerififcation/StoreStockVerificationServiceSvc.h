#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class storeStockVerificationServicesSvc_createStock;
@class storeStockVerificationServicesSvc_createStockResponse;
@class storeStockVerificationServicesSvc_getProductVerification;
@class storeStockVerificationServicesSvc_getProductVerificationDetails;
@class storeStockVerificationServicesSvc_getProductVerificationDetailsResponse;
@class storeStockVerificationServicesSvc_getProductVerificationResponse;
@class storeStockVerificationServicesSvc_getRawMaterialVerification;
@class storeStockVerificationServicesSvc_getRawMaterialVerificationDetails;
@class storeStockVerificationServicesSvc_getRawMaterialVerificationDetailsResponse;
@class storeStockVerificationServicesSvc_getRawMaterialVerificationResponse;
@class storeStockVerificationServicesSvc_getRawMaterials;
@class storeStockVerificationServicesSvc_getRawMaterialsResponse;
@class storeStockVerificationServicesSvc_getSkuDetails;
@class storeStockVerificationServicesSvc_getSkuDetailsResponse;
@class storeStockVerificationServicesSvc_getStorageLocation;
@class storeStockVerificationServicesSvc_getStorageLocationResponse;
@class storeStockVerificationServicesSvc_getStorageUnit;
@class storeStockVerificationServicesSvc_getStorageUnitResponse;
@class storeStockVerificationServicesSvc_updateRawMaterial;
@class storeStockVerificationServicesSvc_updateRawMaterialResponse;
@class storeStockVerificationServicesSvc_updateStock;
@class storeStockVerificationServicesSvc_updateStockResponse;
@interface storeStockVerificationServicesSvc_createStock : NSObject {
	
/* elements */
	NSString * stockVerificationDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (storeStockVerificationServicesSvc_createStock *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * stockVerificationDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface storeStockVerificationServicesSvc_createStockResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (storeStockVerificationServicesSvc_createStockResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface storeStockVerificationServicesSvc_getProductVerification : NSObject {
	
/* elements */
	NSString * getProductVerificationRequest;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (storeStockVerificationServicesSvc_getProductVerification *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * getProductVerificationRequest;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface storeStockVerificationServicesSvc_getProductVerificationDetails : NSObject {
	
/* elements */
	NSString * getProductVerificationDetailsRequest;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (storeStockVerificationServicesSvc_getProductVerificationDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * getProductVerificationDetailsRequest;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface storeStockVerificationServicesSvc_getProductVerificationDetailsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (storeStockVerificationServicesSvc_getProductVerificationDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface storeStockVerificationServicesSvc_getProductVerificationResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (storeStockVerificationServicesSvc_getProductVerificationResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface storeStockVerificationServicesSvc_getRawMaterialVerification : NSObject {
	
/* elements */
	NSString * getVerificationRequest;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (storeStockVerificationServicesSvc_getRawMaterialVerification *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * getVerificationRequest;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface storeStockVerificationServicesSvc_getRawMaterialVerificationDetails : NSObject {
	
/* elements */
	NSString * getVerificationDetailsRequest;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (storeStockVerificationServicesSvc_getRawMaterialVerificationDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * getVerificationDetailsRequest;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface storeStockVerificationServicesSvc_getRawMaterialVerificationDetailsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (storeStockVerificationServicesSvc_getRawMaterialVerificationDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface storeStockVerificationServicesSvc_getRawMaterialVerificationResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (storeStockVerificationServicesSvc_getRawMaterialVerificationResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface storeStockVerificationServicesSvc_getRawMaterials : NSObject {
	
/* elements */
	NSString * productId;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (storeStockVerificationServicesSvc_getRawMaterials *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * productId;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface storeStockVerificationServicesSvc_getRawMaterialsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (storeStockVerificationServicesSvc_getRawMaterialsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface storeStockVerificationServicesSvc_getSkuDetails : NSObject {
	
/* elements */
	NSString * productId;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (storeStockVerificationServicesSvc_getSkuDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * productId;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface storeStockVerificationServicesSvc_getSkuDetailsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (storeStockVerificationServicesSvc_getSkuDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface storeStockVerificationServicesSvc_getStorageLocation : NSObject {
	
/* elements */
	NSString * storage_unit;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (storeStockVerificationServicesSvc_getStorageLocation *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * storage_unit;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface storeStockVerificationServicesSvc_getStorageLocationResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (storeStockVerificationServicesSvc_getStorageLocationResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface storeStockVerificationServicesSvc_getStorageUnit : NSObject {
	
/* elements */
	NSString * store_location;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (storeStockVerificationServicesSvc_getStorageUnit *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * store_location;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface storeStockVerificationServicesSvc_getStorageUnitResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (storeStockVerificationServicesSvc_getStorageUnitResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface storeStockVerificationServicesSvc_updateRawMaterial : NSObject {
	
/* elements */
	NSString * stockVerificationDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (storeStockVerificationServicesSvc_updateRawMaterial *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * stockVerificationDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface storeStockVerificationServicesSvc_updateRawMaterialResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (storeStockVerificationServicesSvc_updateRawMaterialResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface storeStockVerificationServicesSvc_updateStock : NSObject {
	
/* elements */
	NSString * stockVerificationDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (storeStockVerificationServicesSvc_updateStock *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * stockVerificationDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface storeStockVerificationServicesSvc_updateStockResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (storeStockVerificationServicesSvc_updateStockResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "StoreStockVerificationServiceSvc.h"
@class storeStockVerificationServicesSoapBinding;
@interface storeStockVerificationServicesSvc : NSObject {
	
}
+ (storeStockVerificationServicesSoapBinding *)storeStockVerificationServicesSoapBinding;
@end
@class storeStockVerificationServicesSoapBindingResponse;
@class storeStockVerificationServicesSoapBindingOperation;
@protocol storeStockVerificationServicesSoapBindingResponseDelegate <NSObject>
- (void) operation:(storeStockVerificationServicesSoapBindingOperation *)operation completedWithResponse:(storeStockVerificationServicesSoapBindingResponse *)response;
@end
@interface storeStockVerificationServicesSoapBinding : NSObject <storeStockVerificationServicesSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(storeStockVerificationServicesSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (storeStockVerificationServicesSoapBindingResponse *)getSkuDetailsUsingParameters:(storeStockVerificationServicesSvc_getSkuDetails *)aParameters ;
- (void)getSkuDetailsAsyncUsingParameters:(storeStockVerificationServicesSvc_getSkuDetails *)aParameters  delegate:(id<storeStockVerificationServicesSoapBindingResponseDelegate>)responseDelegate;
- (storeStockVerificationServicesSoapBindingResponse *)getStorageLocationUsingParameters:(storeStockVerificationServicesSvc_getStorageLocation *)aParameters ;
- (void)getStorageLocationAsyncUsingParameters:(storeStockVerificationServicesSvc_getStorageLocation *)aParameters  delegate:(id<storeStockVerificationServicesSoapBindingResponseDelegate>)responseDelegate;
- (storeStockVerificationServicesSoapBindingResponse *)updateRawMaterialUsingParameters:(storeStockVerificationServicesSvc_updateRawMaterial *)aParameters ;
- (void)updateRawMaterialAsyncUsingParameters:(storeStockVerificationServicesSvc_updateRawMaterial *)aParameters  delegate:(id<storeStockVerificationServicesSoapBindingResponseDelegate>)responseDelegate;
- (storeStockVerificationServicesSoapBindingResponse *)updateStockUsingParameters:(storeStockVerificationServicesSvc_updateStock *)aParameters ;
- (void)updateStockAsyncUsingParameters:(storeStockVerificationServicesSvc_updateStock *)aParameters  delegate:(id<storeStockVerificationServicesSoapBindingResponseDelegate>)responseDelegate;
- (storeStockVerificationServicesSoapBindingResponse *)getRawMaterialsUsingParameters:(storeStockVerificationServicesSvc_getRawMaterials *)aParameters ;
- (void)getRawMaterialsAsyncUsingParameters:(storeStockVerificationServicesSvc_getRawMaterials *)aParameters  delegate:(id<storeStockVerificationServicesSoapBindingResponseDelegate>)responseDelegate;
- (storeStockVerificationServicesSoapBindingResponse *)getStorageUnitUsingParameters:(storeStockVerificationServicesSvc_getStorageUnit *)aParameters ;
- (void)getStorageUnitAsyncUsingParameters:(storeStockVerificationServicesSvc_getStorageUnit *)aParameters  delegate:(id<storeStockVerificationServicesSoapBindingResponseDelegate>)responseDelegate;
- (storeStockVerificationServicesSoapBindingResponse *)getRawMaterialVerificationDetailsUsingParameters:(storeStockVerificationServicesSvc_getRawMaterialVerificationDetails *)aParameters ;
- (void)getRawMaterialVerificationDetailsAsyncUsingParameters:(storeStockVerificationServicesSvc_getRawMaterialVerificationDetails *)aParameters  delegate:(id<storeStockVerificationServicesSoapBindingResponseDelegate>)responseDelegate;
- (storeStockVerificationServicesSoapBindingResponse *)getProductVerificationDetailsUsingParameters:(storeStockVerificationServicesSvc_getProductVerificationDetails *)aParameters ;
- (void)getProductVerificationDetailsAsyncUsingParameters:(storeStockVerificationServicesSvc_getProductVerificationDetails *)aParameters  delegate:(id<storeStockVerificationServicesSoapBindingResponseDelegate>)responseDelegate;
- (storeStockVerificationServicesSoapBindingResponse *)createStockUsingParameters:(storeStockVerificationServicesSvc_createStock *)aParameters ;
- (void)createStockAsyncUsingParameters:(storeStockVerificationServicesSvc_createStock *)aParameters  delegate:(id<storeStockVerificationServicesSoapBindingResponseDelegate>)responseDelegate;
- (storeStockVerificationServicesSoapBindingResponse *)getProductVerificationUsingParameters:(storeStockVerificationServicesSvc_getProductVerification *)aParameters ;
- (void)getProductVerificationAsyncUsingParameters:(storeStockVerificationServicesSvc_getProductVerification *)aParameters  delegate:(id<storeStockVerificationServicesSoapBindingResponseDelegate>)responseDelegate;
- (storeStockVerificationServicesSoapBindingResponse *)getRawMaterialVerificationUsingParameters:(storeStockVerificationServicesSvc_getRawMaterialVerification *)aParameters ;
- (void)getRawMaterialVerificationAsyncUsingParameters:(storeStockVerificationServicesSvc_getRawMaterialVerification *)aParameters  delegate:(id<storeStockVerificationServicesSoapBindingResponseDelegate>)responseDelegate;
@end
@interface storeStockVerificationServicesSoapBindingOperation : NSOperation {
	storeStockVerificationServicesSoapBinding *binding;
	storeStockVerificationServicesSoapBindingResponse * response;
	id<storeStockVerificationServicesSoapBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (strong) storeStockVerificationServicesSoapBinding *binding;
@property (  readonly) storeStockVerificationServicesSoapBindingResponse *response;
@property (nonatomic, strong) id<storeStockVerificationServicesSoapBindingResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(storeStockVerificationServicesSoapBinding *)aBinding delegate:(id<storeStockVerificationServicesSoapBindingResponseDelegate>)aDelegate;
@end
@interface storeStockVerificationServicesSoapBinding_getSkuDetails : storeStockVerificationServicesSoapBindingOperation {
	storeStockVerificationServicesSvc_getSkuDetails * parameters;
}
@property (strong) storeStockVerificationServicesSvc_getSkuDetails * parameters;
- (id)initWithBinding:(storeStockVerificationServicesSoapBinding *)aBinding delegate:(id<storeStockVerificationServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(storeStockVerificationServicesSvc_getSkuDetails *)aParameters
;
@end
@interface storeStockVerificationServicesSoapBinding_getStorageLocation : storeStockVerificationServicesSoapBindingOperation {
	storeStockVerificationServicesSvc_getStorageLocation * parameters;
}
@property (strong) storeStockVerificationServicesSvc_getStorageLocation * parameters;
- (id)initWithBinding:(storeStockVerificationServicesSoapBinding *)aBinding delegate:(id<storeStockVerificationServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(storeStockVerificationServicesSvc_getStorageLocation *)aParameters
;
@end
@interface storeStockVerificationServicesSoapBinding_updateRawMaterial : storeStockVerificationServicesSoapBindingOperation {
	storeStockVerificationServicesSvc_updateRawMaterial * parameters;
}
@property (strong) storeStockVerificationServicesSvc_updateRawMaterial * parameters;
- (id)initWithBinding:(storeStockVerificationServicesSoapBinding *)aBinding delegate:(id<storeStockVerificationServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(storeStockVerificationServicesSvc_updateRawMaterial *)aParameters
;
@end
@interface storeStockVerificationServicesSoapBinding_updateStock : storeStockVerificationServicesSoapBindingOperation {
	storeStockVerificationServicesSvc_updateStock * parameters;
}
@property (strong) storeStockVerificationServicesSvc_updateStock * parameters;
- (id)initWithBinding:(storeStockVerificationServicesSoapBinding *)aBinding delegate:(id<storeStockVerificationServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(storeStockVerificationServicesSvc_updateStock *)aParameters
;
@end
@interface storeStockVerificationServicesSoapBinding_getRawMaterials : storeStockVerificationServicesSoapBindingOperation {
	storeStockVerificationServicesSvc_getRawMaterials * parameters;
}
@property (strong) storeStockVerificationServicesSvc_getRawMaterials * parameters;
- (id)initWithBinding:(storeStockVerificationServicesSoapBinding *)aBinding delegate:(id<storeStockVerificationServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(storeStockVerificationServicesSvc_getRawMaterials *)aParameters
;
@end
@interface storeStockVerificationServicesSoapBinding_getStorageUnit : storeStockVerificationServicesSoapBindingOperation {
	storeStockVerificationServicesSvc_getStorageUnit * parameters;
}
@property (strong) storeStockVerificationServicesSvc_getStorageUnit * parameters;
- (id)initWithBinding:(storeStockVerificationServicesSoapBinding *)aBinding delegate:(id<storeStockVerificationServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(storeStockVerificationServicesSvc_getStorageUnit *)aParameters
;
@end
@interface storeStockVerificationServicesSoapBinding_getRawMaterialVerificationDetails : storeStockVerificationServicesSoapBindingOperation {
	storeStockVerificationServicesSvc_getRawMaterialVerificationDetails * parameters;
}
@property (strong) storeStockVerificationServicesSvc_getRawMaterialVerificationDetails * parameters;
- (id)initWithBinding:(storeStockVerificationServicesSoapBinding *)aBinding delegate:(id<storeStockVerificationServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(storeStockVerificationServicesSvc_getRawMaterialVerificationDetails *)aParameters
;
@end
@interface storeStockVerificationServicesSoapBinding_getProductVerificationDetails : storeStockVerificationServicesSoapBindingOperation {
	storeStockVerificationServicesSvc_getProductVerificationDetails * parameters;
}
@property (strong) storeStockVerificationServicesSvc_getProductVerificationDetails * parameters;
- (id)initWithBinding:(storeStockVerificationServicesSoapBinding *)aBinding delegate:(id<storeStockVerificationServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(storeStockVerificationServicesSvc_getProductVerificationDetails *)aParameters
;
@end
@interface storeStockVerificationServicesSoapBinding_createStock : storeStockVerificationServicesSoapBindingOperation {
	storeStockVerificationServicesSvc_createStock * parameters;
}
@property (strong) storeStockVerificationServicesSvc_createStock * parameters;
- (id)initWithBinding:(storeStockVerificationServicesSoapBinding *)aBinding delegate:(id<storeStockVerificationServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(storeStockVerificationServicesSvc_createStock *)aParameters
;
@end
@interface storeStockVerificationServicesSoapBinding_getProductVerification : storeStockVerificationServicesSoapBindingOperation {
	storeStockVerificationServicesSvc_getProductVerification * parameters;
}
@property (strong) storeStockVerificationServicesSvc_getProductVerification * parameters;
- (id)initWithBinding:(storeStockVerificationServicesSoapBinding *)aBinding delegate:(id<storeStockVerificationServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(storeStockVerificationServicesSvc_getProductVerification *)aParameters
;
@end
@interface storeStockVerificationServicesSoapBinding_getRawMaterialVerification : storeStockVerificationServicesSoapBindingOperation {
	storeStockVerificationServicesSvc_getRawMaterialVerification * parameters;
}
@property (strong) storeStockVerificationServicesSvc_getRawMaterialVerification * parameters;
- (id)initWithBinding:(storeStockVerificationServicesSoapBinding *)aBinding delegate:(id<storeStockVerificationServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(storeStockVerificationServicesSvc_getRawMaterialVerification *)aParameters
;
@end
@interface storeStockVerificationServicesSoapBinding_envelope : NSObject {
}
+ (storeStockVerificationServicesSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface storeStockVerificationServicesSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end
