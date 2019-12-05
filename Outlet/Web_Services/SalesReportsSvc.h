#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class SalesReportsSvc_getSalesReportsCounter;
@class SalesReportsSvc_getSalesReportsCounterResponse;
@interface SalesReportsSvc_getSalesReportsCounter : NSObject {
	
/* elements */
	NSString * reportsInfo;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesReportsSvc_getSalesReportsCounter *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * reportsInfo;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesReportsSvc_getSalesReportsCounterResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesReportsSvc_getSalesReportsCounterResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "SalesReportsSvc.h"
@class SalesReportsSoapBinding;
@interface SalesReportsSvc : NSObject {
	
}
+ (SalesReportsSoapBinding *)SalesReportsSoapBinding;
@end
@class SalesReportsSoapBindingResponse;
@class SalesReportsSoapBindingOperation;
@protocol SalesReportsSoapBindingResponseDelegate <NSObject>
- (void) operation:(SalesReportsSoapBindingOperation *)operation completedWithResponse:(SalesReportsSoapBindingResponse *)response;
@end
@interface SalesReportsSoapBinding : NSObject <SalesReportsSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(SalesReportsSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (SalesReportsSoapBindingResponse *)getSalesReportsCounterUsingParameters:(SalesReportsSvc_getSalesReportsCounter *)aParameters ;
- (void)getSalesReportsCounterAsyncUsingParameters:(SalesReportsSvc_getSalesReportsCounter *)aParameters  delegate:(id<SalesReportsSoapBindingResponseDelegate>)responseDelegate;
@end
@interface SalesReportsSoapBindingOperation : NSOperation {
	SalesReportsSoapBinding *binding;
	SalesReportsSoapBindingResponse * response;
	id<SalesReportsSoapBindingResponseDelegate>  delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (strong) SalesReportsSoapBinding *binding;
@property (  readonly) SalesReportsSoapBindingResponse *response;
@property (nonatomic ) id<SalesReportsSoapBindingResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(SalesReportsSoapBinding *)aBinding delegate:(id<SalesReportsSoapBindingResponseDelegate>)aDelegate;
@end
@interface SalesReportsSoapBinding_getSalesReportsCounter : SalesReportsSoapBindingOperation {
	SalesReportsSvc_getSalesReportsCounter * parameters;
}
@property (strong) SalesReportsSvc_getSalesReportsCounter * parameters;
- (id)initWithBinding:(SalesReportsSoapBinding *)aBinding delegate:(id<SalesReportsSoapBindingResponseDelegate>)aDelegate
	parameters:(SalesReportsSvc_getSalesReportsCounter *)aParameters
;
@end
@interface SalesReportsSoapBinding_envelope : NSObject {
}
+ (SalesReportsSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface SalesReportsSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end
