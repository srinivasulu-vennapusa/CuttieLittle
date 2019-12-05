#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class shipmentInspectionServicesSvc_UpdateInspection;
@class shipmentInspectionServicesSvc_UpdateInspectionResponse;
@class shipmentInspectionServicesSvc_getInspection;
@class shipmentInspectionServicesSvc_getInspectionDetails;
@class shipmentInspectionServicesSvc_getInspectionDetailsResponse;
@class shipmentInspectionServicesSvc_getInspectionResponse;
@class shipmentInspectionServicesSvc_newInspection;
@class shipmentInspectionServicesSvc_newInspectionResponse;
@interface shipmentInspectionServicesSvc_UpdateInspection : NSObject {
	
/* elements */
	NSString * UpdateInspectionRequest;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (shipmentInspectionServicesSvc_UpdateInspection *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * UpdateInspectionRequest;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface shipmentInspectionServicesSvc_UpdateInspectionResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (shipmentInspectionServicesSvc_UpdateInspectionResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface shipmentInspectionServicesSvc_getInspection : NSObject {
	
/* elements */
	NSString * getInspectionRequest;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (shipmentInspectionServicesSvc_getInspection *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * getInspectionRequest;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface shipmentInspectionServicesSvc_getInspectionDetails : NSObject {
	
/* elements */
	NSString * getInspectionDetailsRequest;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (shipmentInspectionServicesSvc_getInspectionDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * getInspectionDetailsRequest;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface shipmentInspectionServicesSvc_getInspectionDetailsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (shipmentInspectionServicesSvc_getInspectionDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface shipmentInspectionServicesSvc_getInspectionResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (shipmentInspectionServicesSvc_getInspectionResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface shipmentInspectionServicesSvc_newInspection : NSObject {
	
/* elements */
	NSString * newInspectionRequest;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (shipmentInspectionServicesSvc_newInspection *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * newInspectionRequest;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface shipmentInspectionServicesSvc_newInspectionResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (shipmentInspectionServicesSvc_newInspectionResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "shipmentInspectionServicesSvc.h"
@class shipmentInspectionServicesSoapBinding;
@interface shipmentInspectionServicesSvc : NSObject {
	
}
+ (shipmentInspectionServicesSoapBinding *)shipmentInspectionServicesSoapBinding;
@end
@class shipmentInspectionServicesSoapBindingResponse;
@class shipmentInspectionServicesSoapBindingOperation;
@protocol shipmentInspectionServicesSoapBindingResponseDelegate <NSObject>
- (void) operation:(shipmentInspectionServicesSoapBindingOperation *)operation completedWithResponse:(shipmentInspectionServicesSoapBindingResponse *)response;
@end
@interface shipmentInspectionServicesSoapBinding : NSObject <shipmentInspectionServicesSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(shipmentInspectionServicesSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (shipmentInspectionServicesSoapBindingResponse *)getInspectionUsingParameters:(shipmentInspectionServicesSvc_getInspection *)aParameters ;
- (void)getInspectionAsyncUsingParameters:(shipmentInspectionServicesSvc_getInspection *)aParameters  delegate:(id<shipmentInspectionServicesSoapBindingResponseDelegate>)responseDelegate;
- (shipmentInspectionServicesSoapBindingResponse *)UpdateInspectionUsingParameters:(shipmentInspectionServicesSvc_UpdateInspection *)aParameters ;
- (void)UpdateInspectionAsyncUsingParameters:(shipmentInspectionServicesSvc_UpdateInspection *)aParameters  delegate:(id<shipmentInspectionServicesSoapBindingResponseDelegate>)responseDelegate;
- (shipmentInspectionServicesSoapBindingResponse *)newInspectionUsingParameters:(shipmentInspectionServicesSvc_newInspection *)aParameters ;
- (void)newInspectionAsyncUsingParameters:(shipmentInspectionServicesSvc_newInspection *)aParameters  delegate:(id<shipmentInspectionServicesSoapBindingResponseDelegate>)responseDelegate;
- (shipmentInspectionServicesSoapBindingResponse *)getInspectionDetailsUsingParameters:(shipmentInspectionServicesSvc_getInspectionDetails *)aParameters ;
- (void)getInspectionDetailsAsyncUsingParameters:(shipmentInspectionServicesSvc_getInspectionDetails *)aParameters  delegate:(id<shipmentInspectionServicesSoapBindingResponseDelegate>)responseDelegate;
@end
@interface shipmentInspectionServicesSoapBindingOperation : NSOperation {
	shipmentInspectionServicesSoapBinding *binding;
	shipmentInspectionServicesSoapBindingResponse *response;
	id<shipmentInspectionServicesSoapBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) shipmentInspectionServicesSoapBinding *binding;
@property (readonly) shipmentInspectionServicesSoapBindingResponse *response;
@property (nonatomic, assign) id<shipmentInspectionServicesSoapBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(shipmentInspectionServicesSoapBinding *)aBinding delegate:(id<shipmentInspectionServicesSoapBindingResponseDelegate>)aDelegate;
@end
@interface shipmentInspectionServicesSoapBinding_getInspection : shipmentInspectionServicesSoapBindingOperation {
	shipmentInspectionServicesSvc_getInspection * parameters;
}
@property (retain) shipmentInspectionServicesSvc_getInspection * parameters;
- (id)initWithBinding:(shipmentInspectionServicesSoapBinding *)aBinding delegate:(id<shipmentInspectionServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(shipmentInspectionServicesSvc_getInspection *)aParameters
;
@end
@interface shipmentInspectionServicesSoapBinding_UpdateInspection : shipmentInspectionServicesSoapBindingOperation {
	shipmentInspectionServicesSvc_UpdateInspection * parameters;
}
@property (retain) shipmentInspectionServicesSvc_UpdateInspection * parameters;
- (id)initWithBinding:(shipmentInspectionServicesSoapBinding *)aBinding delegate:(id<shipmentInspectionServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(shipmentInspectionServicesSvc_UpdateInspection *)aParameters
;
@end
@interface shipmentInspectionServicesSoapBinding_newInspection : shipmentInspectionServicesSoapBindingOperation {
	shipmentInspectionServicesSvc_newInspection * parameters;
}
@property (retain) shipmentInspectionServicesSvc_newInspection * parameters;
- (id)initWithBinding:(shipmentInspectionServicesSoapBinding *)aBinding delegate:(id<shipmentInspectionServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(shipmentInspectionServicesSvc_newInspection *)aParameters
;
@end
@interface shipmentInspectionServicesSoapBinding_getInspectionDetails : shipmentInspectionServicesSoapBindingOperation {
	shipmentInspectionServicesSvc_getInspectionDetails * parameters;
}
@property (retain) shipmentInspectionServicesSvc_getInspectionDetails * parameters;
- (id)initWithBinding:(shipmentInspectionServicesSoapBinding *)aBinding delegate:(id<shipmentInspectionServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(shipmentInspectionServicesSvc_getInspectionDetails *)aParameters
;
@end
@interface shipmentInspectionServicesSoapBinding_envelope : NSObject {
}
+ (shipmentInspectionServicesSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface shipmentInspectionServicesSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
