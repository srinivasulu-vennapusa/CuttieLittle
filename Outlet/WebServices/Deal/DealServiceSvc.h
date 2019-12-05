#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class DealServiceSvc_getCurrentDealDetails;
@class DealServiceSvc_getCurrentDealDetailsResponse;
@class DealServiceSvc_getDealDetails;
@class DealServiceSvc_getDealDetailsResponse;
@class DealServiceSvc_getDealDetailsBySKU;
@class DealServiceSvc_getDealDetailsBySKUResponse;
@class DealServiceSvc_searchDealDetails;
@class DealServiceSvc_searchDealDetailsResponse;
@interface DealServiceSvc_getCurrentDealDetails : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (DealServiceSvc_getCurrentDealDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface DealServiceSvc_getCurrentDealDetailsResponse : NSObject {
	
/* elements */
	NSString * getCurrentDealDetailsReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (DealServiceSvc_getCurrentDealDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * getCurrentDealDetailsReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface DealServiceSvc_getDealDetails : NSObject {
	
/* elements */
	NSString * dealType;
	NSString * pageNumber;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (DealServiceSvc_getDealDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * dealType;
@property (retain) NSString * pageNumber;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface DealServiceSvc_getDealDetailsResponse : NSObject {
	
/* elements */
	NSString * getDealDetailsReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (DealServiceSvc_getDealDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * getDealDetailsReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface DealServiceSvc_getDealDetailsBySKU : NSObject {
	
/* elements */
	NSString * dealDetailsOfSku;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (DealServiceSvc_getDealDetailsBySKU *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * dealDetailsOfSku;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface DealServiceSvc_getDealDetailsBySKUResponse : NSObject {
	
/* elements */
	NSString * getDealDetailsBySKUReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (DealServiceSvc_getDealDetailsBySKUResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * getDealDetailsBySKUReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface DealServiceSvc_searchDealDetails : NSObject {
	
/* elements */
	NSString * dealType;
	NSString * searchCriteria;
	NSString * pageNumber;
	NSString * dropDown;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (DealServiceSvc_searchDealDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * dealType;
@property (retain) NSString * searchCriteria;
@property (retain) NSString * pageNumber;
@property (retain) NSString * dropDown;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface DealServiceSvc_searchDealDetailsResponse : NSObject {
	
/* elements */
	NSString * searchDealDetailsReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (DealServiceSvc_searchDealDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * searchDealDetailsReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "ns1.h"
#import "DealServiceSvc.h"
@class DealSoapBinding;
@interface DealServiceSvc : NSObject {
	
}
+ (DealSoapBinding *)DealSoapBinding;
@end
@class DealSoapBindingResponse;
@class DealSoapBindingOperation;
@protocol DealSoapBindingResponseDelegate <NSObject>
- (void) operation:(DealSoapBindingOperation *)operation completedWithResponse:(DealSoapBindingResponse *)response;
@end
@interface DealSoapBinding : NSObject <DealSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(DealSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (DealSoapBindingResponse *)getCurrentDealDetailsUsingParameters:(DealServiceSvc_getCurrentDealDetails *)aParameters ;
- (void)getCurrentDealDetailsAsyncUsingParameters:(DealServiceSvc_getCurrentDealDetails *)aParameters  delegate:(id<DealSoapBindingResponseDelegate>)responseDelegate;
- (DealSoapBindingResponse *)getDealDetailsUsingParameters:(DealServiceSvc_getDealDetails *)aParameters ;
- (void)getDealDetailsAsyncUsingParameters:(DealServiceSvc_getDealDetails *)aParameters  delegate:(id<DealSoapBindingResponseDelegate>)responseDelegate;
- (DealSoapBindingResponse *)getDealDetailsBySKUUsingParameters:(DealServiceSvc_getDealDetailsBySKU *)aParameters ;
- (void)getDealDetailsBySKUAsyncUsingParameters:(DealServiceSvc_getDealDetailsBySKU *)aParameters  delegate:(id<DealSoapBindingResponseDelegate>)responseDelegate;
- (DealSoapBindingResponse *)searchDealDetailsUsingParameters:(DealServiceSvc_searchDealDetails *)aParameters ;
- (void)searchDealDetailsAsyncUsingParameters:(DealServiceSvc_searchDealDetails *)aParameters  delegate:(id<DealSoapBindingResponseDelegate>)responseDelegate;
@end
@interface DealSoapBindingOperation : NSOperation {
	DealSoapBinding *binding;
	DealSoapBindingResponse *response;
	id<DealSoapBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) DealSoapBinding *binding;
@property (readonly) DealSoapBindingResponse *response;
@property (nonatomic, assign) id<DealSoapBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(DealSoapBinding *)aBinding delegate:(id<DealSoapBindingResponseDelegate>)aDelegate;
@end
@interface DealSoapBinding_getCurrentDealDetails : DealSoapBindingOperation {
	DealServiceSvc_getCurrentDealDetails * parameters;
}
@property (retain) DealServiceSvc_getCurrentDealDetails * parameters;
- (id)initWithBinding:(DealSoapBinding *)aBinding delegate:(id<DealSoapBindingResponseDelegate>)aDelegate
	parameters:(DealServiceSvc_getCurrentDealDetails *)aParameters
;
@end
@interface DealSoapBinding_getDealDetails : DealSoapBindingOperation {
	DealServiceSvc_getDealDetails * parameters;
}
@property (retain) DealServiceSvc_getDealDetails * parameters;
- (id)initWithBinding:(DealSoapBinding *)aBinding delegate:(id<DealSoapBindingResponseDelegate>)aDelegate
	parameters:(DealServiceSvc_getDealDetails *)aParameters
;
@end
@interface DealSoapBinding_getDealDetailsBySKU : DealSoapBindingOperation {
	DealServiceSvc_getDealDetailsBySKU * parameters;
}
@property (retain) DealServiceSvc_getDealDetailsBySKU * parameters;
- (id)initWithBinding:(DealSoapBinding *)aBinding delegate:(id<DealSoapBindingResponseDelegate>)aDelegate
	parameters:(DealServiceSvc_getDealDetailsBySKU *)aParameters
;
@end
@interface DealSoapBinding_searchDealDetails : DealSoapBindingOperation {
	DealServiceSvc_searchDealDetails * parameters;
}
@property (retain) DealServiceSvc_searchDealDetails * parameters;
- (id)initWithBinding:(DealSoapBinding *)aBinding delegate:(id<DealSoapBindingResponseDelegate>)aDelegate
	parameters:(DealServiceSvc_searchDealDetails *)aParameters
;
@end
@interface DealSoapBinding_envelope : NSObject {
}
+ (DealSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface DealSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
