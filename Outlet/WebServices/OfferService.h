#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class OfferService_getOfferDetails;
@class OfferService_getOfferDetailsResponse;
@class OfferService_getCurrentOfferDetails;
@class OfferService_getCurrentOfferDetailsResponse;
@class OfferService_getOfferDetailsBySKU;
@class OfferService_getOfferDetailsBySKUResponse;
@interface OfferService_getOfferDetails : NSObject {
	
/* elements */
	NSString * offerType;
	NSString * pageNumber;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OfferService_getOfferDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * offerType;
@property (retain) NSString * pageNumber;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OfferService_getOfferDetailsResponse : NSObject {
	
/* elements */
	NSString * getOfferDetailsReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OfferService_getOfferDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * getOfferDetailsReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OfferService_getCurrentOfferDetails : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OfferService_getCurrentOfferDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OfferService_getCurrentOfferDetailsResponse : NSObject {
	
/* elements */
	NSString * getCurrentOfferDetailsReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OfferService_getCurrentOfferDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * getCurrentOfferDetailsReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OfferService_getOfferDetailsBySKU : NSObject {
	
/* elements */
	NSString * offerDetailsOfSku;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OfferService_getOfferDetailsBySKU *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * offerDetailsOfSku;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OfferService_getOfferDetailsBySKUResponse : NSObject {
	
/* elements */
	NSString * getOfferDetailsBySKUReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OfferService_getOfferDetailsBySKUResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * getOfferDetailsBySKUReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "ns1.h"
#import "OfferService.h"
@class OfferSoapBinding;
@interface OfferService : NSObject {
	
}
+ (OfferSoapBinding *)OfferSoapBinding;
@end
@class OfferSoapBindingResponse;
@class OfferSoapBindingOperation;
@protocol OfferSoapBindingResponseDelegate <NSObject>
- (void) operation:(OfferSoapBindingOperation *)operation completedWithResponse:(OfferSoapBindingResponse *)response;
@end
@interface OfferSoapBinding : NSObject <OfferSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(OfferSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (OfferSoapBindingResponse *)getOfferDetailsUsingParameters:(OfferService_getOfferDetails *)aParameters ;
- (void)getOfferDetailsAsyncUsingParameters:(OfferService_getOfferDetails *)aParameters  delegate:(id<OfferSoapBindingResponseDelegate>)responseDelegate;
- (OfferSoapBindingResponse *)getCurrentOfferDetailsUsingParameters:(OfferService_getCurrentOfferDetails *)aParameters ;
- (void)getCurrentOfferDetailsAsyncUsingParameters:(OfferService_getCurrentOfferDetails *)aParameters  delegate:(id<OfferSoapBindingResponseDelegate>)responseDelegate;
- (OfferSoapBindingResponse *)getOfferDetailsBySKUUsingParameters:(OfferService_getOfferDetailsBySKU *)aParameters ;
- (void)getOfferDetailsBySKUAsyncUsingParameters:(OfferService_getOfferDetailsBySKU *)aParameters  delegate:(id<OfferSoapBindingResponseDelegate>)responseDelegate;
@end
@interface OfferSoapBindingOperation : NSOperation {
	OfferSoapBinding *binding;
	OfferSoapBindingResponse *response;
	id<OfferSoapBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) OfferSoapBinding *binding;
@property (readonly) OfferSoapBindingResponse *response;
@property (nonatomic, assign) id<OfferSoapBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(OfferSoapBinding *)aBinding delegate:(id<OfferSoapBindingResponseDelegate>)aDelegate;
@end
@interface OfferSoapBinding_getOfferDetails : OfferSoapBindingOperation {
	OfferService_getOfferDetails * parameters;
}
@property (retain) OfferService_getOfferDetails * parameters;
- (id)initWithBinding:(OfferSoapBinding *)aBinding delegate:(id<OfferSoapBindingResponseDelegate>)aDelegate
	parameters:(OfferService_getOfferDetails *)aParameters
;
@end
@interface OfferSoapBinding_getCurrentOfferDetails : OfferSoapBindingOperation {
	OfferService_getCurrentOfferDetails * parameters;
}
@property (retain) OfferService_getCurrentOfferDetails * parameters;
- (id)initWithBinding:(OfferSoapBinding *)aBinding delegate:(id<OfferSoapBindingResponseDelegate>)aDelegate
	parameters:(OfferService_getCurrentOfferDetails *)aParameters
;
@end
@interface OfferSoapBinding_getOfferDetailsBySKU : OfferSoapBindingOperation {
	OfferService_getOfferDetailsBySKU * parameters;
}
@property (retain) OfferService_getOfferDetailsBySKU * parameters;
- (id)initWithBinding:(OfferSoapBinding *)aBinding delegate:(id<OfferSoapBindingResponseDelegate>)aDelegate
	parameters:(OfferService_getOfferDetailsBySKU *)aParameters
;
@end
@interface OfferSoapBinding_envelope : NSObject {
}
+ (OfferSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface OfferSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
