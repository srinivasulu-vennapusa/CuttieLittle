#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class WHInvoiceServicesSvc_createInvoice;
@class WHInvoiceServicesSvc_createInvoiceResponse;
@class WHInvoiceServicesSvc_getInvoiceDetails;
@class WHInvoiceServicesSvc_getInvoiceDetailsResponse;
@class WHInvoiceServicesSvc_getInvoices;
@class WHInvoiceServicesSvc_getInvoicesResponse;
@class WHInvoiceServicesSvc_updateInvoice;
@class WHInvoiceServicesSvc_updateInvoiceResponse;
@interface WHInvoiceServicesSvc_createInvoice : NSObject {
	
/* elements */
	NSString * invoiceDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHInvoiceServicesSvc_createInvoice *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * invoiceDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHInvoiceServicesSvc_createInvoiceResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHInvoiceServicesSvc_createInvoiceResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHInvoiceServicesSvc_getInvoiceDetails : NSObject {
	
/* elements */
	NSString * invoiceDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHInvoiceServicesSvc_getInvoiceDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * invoiceDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHInvoiceServicesSvc_getInvoiceDetailsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHInvoiceServicesSvc_getInvoiceDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHInvoiceServicesSvc_getInvoices : NSObject {
	
/* elements */
	NSString * invoiceDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHInvoiceServicesSvc_getInvoices *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * invoiceDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHInvoiceServicesSvc_getInvoicesResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHInvoiceServicesSvc_getInvoicesResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHInvoiceServicesSvc_updateInvoice : NSObject {
	
/* elements */
	NSString * invoiceDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHInvoiceServicesSvc_updateInvoice *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * invoiceDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHInvoiceServicesSvc_updateInvoiceResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHInvoiceServicesSvc_updateInvoiceResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "WHInvoiceServicesSvc.h"
@class WHInvoiceServicesSoapBinding;
@interface WHInvoiceServicesSvc : NSObject {
	
}
+ (WHInvoiceServicesSoapBinding *)WHInvoiceServicesSoapBinding;
@end
@class WHInvoiceServicesSoapBindingResponse;
@class WHInvoiceServicesSoapBindingOperation;
@protocol WHInvoiceServicesSoapBindingResponseDelegate <NSObject>
- (void) operation:(WHInvoiceServicesSoapBindingOperation *)operation completedWithResponse:(WHInvoiceServicesSoapBindingResponse *)response;
@end
@interface WHInvoiceServicesSoapBinding : NSObject <WHInvoiceServicesSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(WHInvoiceServicesSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (WHInvoiceServicesSoapBindingResponse *)getInvoiceDetailsUsingParameters:(WHInvoiceServicesSvc_getInvoiceDetails *)aParameters ;
- (void)getInvoiceDetailsAsyncUsingParameters:(WHInvoiceServicesSvc_getInvoiceDetails *)aParameters  delegate:(id<WHInvoiceServicesSoapBindingResponseDelegate>)responseDelegate;
- (WHInvoiceServicesSoapBindingResponse *)updateInvoiceUsingParameters:(WHInvoiceServicesSvc_updateInvoice *)aParameters ;
- (void)updateInvoiceAsyncUsingParameters:(WHInvoiceServicesSvc_updateInvoice *)aParameters  delegate:(id<WHInvoiceServicesSoapBindingResponseDelegate>)responseDelegate;
- (WHInvoiceServicesSoapBindingResponse *)getInvoicesUsingParameters:(WHInvoiceServicesSvc_getInvoices *)aParameters ;
- (void)getInvoicesAsyncUsingParameters:(WHInvoiceServicesSvc_getInvoices *)aParameters  delegate:(id<WHInvoiceServicesSoapBindingResponseDelegate>)responseDelegate;
- (WHInvoiceServicesSoapBindingResponse *)createInvoiceUsingParameters:(WHInvoiceServicesSvc_createInvoice *)aParameters ;
- (void)createInvoiceAsyncUsingParameters:(WHInvoiceServicesSvc_createInvoice *)aParameters  delegate:(id<WHInvoiceServicesSoapBindingResponseDelegate>)responseDelegate;
@end
@interface WHInvoiceServicesSoapBindingOperation : NSOperation {
	WHInvoiceServicesSoapBinding *binding;
	WHInvoiceServicesSoapBindingResponse *response;
	id<WHInvoiceServicesSoapBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) WHInvoiceServicesSoapBinding *binding;
@property (readonly) WHInvoiceServicesSoapBindingResponse *response;
@property (nonatomic, assign) id<WHInvoiceServicesSoapBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(WHInvoiceServicesSoapBinding *)aBinding delegate:(id<WHInvoiceServicesSoapBindingResponseDelegate>)aDelegate;
@end
@interface WHInvoiceServicesSoapBinding_getInvoiceDetails : WHInvoiceServicesSoapBindingOperation {
	WHInvoiceServicesSvc_getInvoiceDetails * parameters;
}
@property (retain) WHInvoiceServicesSvc_getInvoiceDetails * parameters;
- (id)initWithBinding:(WHInvoiceServicesSoapBinding *)aBinding delegate:(id<WHInvoiceServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(WHInvoiceServicesSvc_getInvoiceDetails *)aParameters
;
@end
@interface WHInvoiceServicesSoapBinding_updateInvoice : WHInvoiceServicesSoapBindingOperation {
	WHInvoiceServicesSvc_updateInvoice * parameters;
}
@property (retain) WHInvoiceServicesSvc_updateInvoice * parameters;
- (id)initWithBinding:(WHInvoiceServicesSoapBinding *)aBinding delegate:(id<WHInvoiceServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(WHInvoiceServicesSvc_updateInvoice *)aParameters
;
@end
@interface WHInvoiceServicesSoapBinding_getInvoices : WHInvoiceServicesSoapBindingOperation {
	WHInvoiceServicesSvc_getInvoices * parameters;
}
@property (retain) WHInvoiceServicesSvc_getInvoices * parameters;
- (id)initWithBinding:(WHInvoiceServicesSoapBinding *)aBinding delegate:(id<WHInvoiceServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(WHInvoiceServicesSvc_getInvoices *)aParameters
;
@end
@interface WHInvoiceServicesSoapBinding_createInvoice : WHInvoiceServicesSoapBindingOperation {
	WHInvoiceServicesSvc_createInvoice * parameters;
}
@property (retain) WHInvoiceServicesSvc_createInvoice * parameters;
- (id)initWithBinding:(WHInvoiceServicesSoapBinding *)aBinding delegate:(id<WHInvoiceServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(WHInvoiceServicesSvc_createInvoice *)aParameters
;
@end
@interface WHInvoiceServicesSoapBinding_envelope : NSObject {
}
+ (WHInvoiceServicesSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface WHInvoiceServicesSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
