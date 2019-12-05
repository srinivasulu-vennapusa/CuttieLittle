#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
#import "WebServiceUtility.h"

@class BrandMasterServiceSvc_createBrand;
@class BrandMasterServiceSvc_createBrandResponse;
@class BrandMasterServiceSvc_deleteBrand;
@class BrandMasterServiceSvc_deleteBrandResponse;
@class BrandMasterServiceSvc_getBrand;
@class BrandMasterServiceSvc_getBrandResponse;
@class BrandMasterServiceSvc_updateBrand;
@class BrandMasterServiceSvc_updateBrandResponse;
@interface BrandMasterServiceSvc_createBrand : NSObject {
	
/* elements */
	NSString * crate;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (BrandMasterServiceSvc_createBrand *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * crate;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface BrandMasterServiceSvc_createBrandResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (BrandMasterServiceSvc_createBrandResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface BrandMasterServiceSvc_deleteBrand : NSObject {
	
/* elements */
	NSString * delete;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (BrandMasterServiceSvc_deleteBrand *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * delete;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface BrandMasterServiceSvc_deleteBrandResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (BrandMasterServiceSvc_deleteBrandResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface BrandMasterServiceSvc_getBrand : NSObject {
	
/* elements */
	NSString * getBrands;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (BrandMasterServiceSvc_getBrand *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * getBrands;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface BrandMasterServiceSvc_getBrandResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (BrandMasterServiceSvc_getBrandResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface BrandMasterServiceSvc_updateBrand : NSObject {
	
/* elements */
	NSString * update;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (BrandMasterServiceSvc_updateBrand *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * update;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface BrandMasterServiceSvc_updateBrandResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (BrandMasterServiceSvc_updateBrandResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "BrandMasterServiceSvc.h"
@class BrandMasterServiceSoapBinding;
@interface BrandMasterServiceSvc : NSObject {
	
}
+ (BrandMasterServiceSoapBinding *)BrandMasterServiceSoapBinding;
@end
@class BrandMasterServiceSoapBindingResponse;
@class BrandMasterServiceSoapBindingOperation;
@protocol BrandMasterServiceSoapBindingResponseDelegate <NSObject>
- (void) operation:(BrandMasterServiceSoapBindingOperation *)operation completedWithResponse:(BrandMasterServiceSoapBindingResponse *)response;
@end
@interface BrandMasterServiceSoapBinding : NSObject <BrandMasterServiceSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(BrandMasterServiceSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (BrandMasterServiceSoapBindingResponse *)createBrandUsingParameters:(BrandMasterServiceSvc_createBrand *)aParameters ;
- (void)createBrandAsyncUsingParameters:(BrandMasterServiceSvc_createBrand *)aParameters  delegate:(id<BrandMasterServiceSoapBindingResponseDelegate>)responseDelegate;
- (BrandMasterServiceSoapBindingResponse *)getBrandUsingParameters:(BrandMasterServiceSvc_getBrand *)aParameters ;
- (void)getBrandAsyncUsingParameters:(BrandMasterServiceSvc_getBrand *)aParameters  delegate:(id<BrandMasterServiceSoapBindingResponseDelegate>)responseDelegate;
- (BrandMasterServiceSoapBindingResponse *)updateBrandUsingParameters:(BrandMasterServiceSvc_updateBrand *)aParameters ;
- (void)updateBrandAsyncUsingParameters:(BrandMasterServiceSvc_updateBrand *)aParameters  delegate:(id<BrandMasterServiceSoapBindingResponseDelegate>)responseDelegate;
- (BrandMasterServiceSoapBindingResponse *)deleteBrandUsingParameters:(BrandMasterServiceSvc_deleteBrand *)aParameters ;
- (void)deleteBrandAsyncUsingParameters:(BrandMasterServiceSvc_deleteBrand *)aParameters  delegate:(id<BrandMasterServiceSoapBindingResponseDelegate>)responseDelegate;
@end
@interface BrandMasterServiceSoapBindingOperation : NSOperation {
	BrandMasterServiceSoapBinding *binding;
	BrandMasterServiceSoapBindingResponse * response;
	id<BrandMasterServiceSoapBindingResponseDelegate>  delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (strong) BrandMasterServiceSoapBinding *binding;
@property (  readonly) BrandMasterServiceSoapBindingResponse *response;
@property (nonatomic ) id<BrandMasterServiceSoapBindingResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(BrandMasterServiceSoapBinding *)aBinding delegate:(id<BrandMasterServiceSoapBindingResponseDelegate>)aDelegate;
@end
@interface BrandMasterServiceSoapBinding_createBrand : BrandMasterServiceSoapBindingOperation {
	BrandMasterServiceSvc_createBrand * parameters;
}
@property (strong) BrandMasterServiceSvc_createBrand * parameters;
- (id)initWithBinding:(BrandMasterServiceSoapBinding *)aBinding delegate:(id<BrandMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(BrandMasterServiceSvc_createBrand *)aParameters
;
@end
@interface BrandMasterServiceSoapBinding_getBrand : BrandMasterServiceSoapBindingOperation {
	BrandMasterServiceSvc_getBrand * parameters;
}
@property (strong) BrandMasterServiceSvc_getBrand * parameters;
- (id)initWithBinding:(BrandMasterServiceSoapBinding *)aBinding delegate:(id<BrandMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(BrandMasterServiceSvc_getBrand *)aParameters
;
@end
@interface BrandMasterServiceSoapBinding_updateBrand : BrandMasterServiceSoapBindingOperation {
	BrandMasterServiceSvc_updateBrand * parameters;
}
@property (strong) BrandMasterServiceSvc_updateBrand * parameters;
- (id)initWithBinding:(BrandMasterServiceSoapBinding *)aBinding delegate:(id<BrandMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(BrandMasterServiceSvc_updateBrand *)aParameters
;
@end
@interface BrandMasterServiceSoapBinding_deleteBrand : BrandMasterServiceSoapBindingOperation {
	BrandMasterServiceSvc_deleteBrand * parameters;
}
@property (strong) BrandMasterServiceSvc_deleteBrand * parameters;
- (id)initWithBinding:(BrandMasterServiceSoapBinding *)aBinding delegate:(id<BrandMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(BrandMasterServiceSvc_deleteBrand *)aParameters
;
@end
@interface BrandMasterServiceSoapBinding_envelope : NSObject {
}
+ (BrandMasterServiceSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface BrandMasterServiceSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end
