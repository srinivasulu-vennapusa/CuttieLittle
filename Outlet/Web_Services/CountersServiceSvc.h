#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
#import "Global.h"
#import "WebServiceUtility.h"
#import "Global.h"
@class CountersServiceSvc_createCounter;
@class CountersServiceSvc_createCounterResponse;
@class CountersServiceSvc_deleteCounter;
@class CountersServiceSvc_deleteCounterResponse;
@class CountersServiceSvc_getCounters;
@class CountersServiceSvc_getCountersResponse;
@class CountersServiceSvc_updateCounter;
@class CountersServiceSvc_updateCounterResponse;
@class CountersServiceSvc_updateSyncDownloadStatus;
@class CountersServiceSvc_updateSyncDownloadStatusResponse;
@interface CountersServiceSvc_createCounter : NSObject {
	
/* elements */
	NSString * counterDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (CountersServiceSvc_createCounter *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * counterDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface CountersServiceSvc_createCounterResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (CountersServiceSvc_createCounterResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface CountersServiceSvc_deleteCounter : NSObject {
	
/* elements */
	NSString * counterDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (CountersServiceSvc_deleteCounter *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * counterDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface CountersServiceSvc_deleteCounterResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (CountersServiceSvc_deleteCounterResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface CountersServiceSvc_getCounters : NSObject {
	
/* elements */
	NSString * counterDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (CountersServiceSvc_getCounters *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * counterDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface CountersServiceSvc_getCountersResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (CountersServiceSvc_getCountersResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface CountersServiceSvc_updateCounter : NSObject {
	
/* elements */
	NSString * counterDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (CountersServiceSvc_updateCounter *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * counterDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface CountersServiceSvc_updateCounterResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (CountersServiceSvc_updateCounterResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface CountersServiceSvc_updateSyncDownloadStatus : NSObject {
	
/* elements */
	NSString * syncDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (CountersServiceSvc_updateSyncDownloadStatus *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * syncDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface CountersServiceSvc_updateSyncDownloadStatusResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (CountersServiceSvc_updateSyncDownloadStatusResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "CountersServiceSvc.h"
@class CountersServiceSoapBinding;
@interface CountersServiceSvc : NSObject {
	
}
+ (CountersServiceSoapBinding *)CountersServiceSoapBinding;
@end
@class CountersServiceSoapBindingResponse;
@class CountersServiceSoapBindingOperation;
@protocol CountersServiceSoapBindingResponseDelegate <NSObject>
- (void) operation:(CountersServiceSoapBindingOperation *)operation completedWithResponse:(CountersServiceSoapBindingResponse *)response;
@end
@interface CountersServiceSoapBinding : NSObject <CountersServiceSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(CountersServiceSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (CountersServiceSoapBindingResponse *)updateSyncDownloadStatusUsingParameters:(CountersServiceSvc_updateSyncDownloadStatus *)aParameters ;
- (void)updateSyncDownloadStatusAsyncUsingParameters:(CountersServiceSvc_updateSyncDownloadStatus *)aParameters  delegate:(id<CountersServiceSoapBindingResponseDelegate>)responseDelegate;
- (CountersServiceSoapBindingResponse *)deleteCounterUsingParameters:(CountersServiceSvc_deleteCounter *)aParameters ;
- (void)deleteCounterAsyncUsingParameters:(CountersServiceSvc_deleteCounter *)aParameters  delegate:(id<CountersServiceSoapBindingResponseDelegate>)responseDelegate;
- (CountersServiceSoapBindingResponse *)createCounterUsingParameters:(CountersServiceSvc_createCounter *)aParameters ;
- (void)createCounterAsyncUsingParameters:(CountersServiceSvc_createCounter *)aParameters  delegate:(id<CountersServiceSoapBindingResponseDelegate>)responseDelegate;
- (CountersServiceSoapBindingResponse *)getCountersUsingParameters:(CountersServiceSvc_getCounters *)aParameters ;
- (void)getCountersAsyncUsingParameters:(CountersServiceSvc_getCounters *)aParameters  delegate:(id<CountersServiceSoapBindingResponseDelegate>)responseDelegate;
- (CountersServiceSoapBindingResponse *)updateCounterUsingParameters:(CountersServiceSvc_updateCounter *)aParameters ;
- (void)updateCounterAsyncUsingParameters:(CountersServiceSvc_updateCounter *)aParameters  delegate:(id<CountersServiceSoapBindingResponseDelegate>)responseDelegate;
@end
@interface CountersServiceSoapBindingOperation : NSOperation {
	CountersServiceSoapBinding *binding;
	CountersServiceSoapBindingResponse * response;
	id<CountersServiceSoapBindingResponseDelegate>  delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (strong) CountersServiceSoapBinding *binding;
@property (  readonly) CountersServiceSoapBindingResponse *response;
@property (nonatomic ) id<CountersServiceSoapBindingResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(CountersServiceSoapBinding *)aBinding delegate:(id<CountersServiceSoapBindingResponseDelegate>)aDelegate;
@end
@interface CountersServiceSoapBinding_updateSyncDownloadStatus : CountersServiceSoapBindingOperation {
	CountersServiceSvc_updateSyncDownloadStatus * parameters;
}
@property (strong) CountersServiceSvc_updateSyncDownloadStatus * parameters;
- (id)initWithBinding:(CountersServiceSoapBinding *)aBinding delegate:(id<CountersServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(CountersServiceSvc_updateSyncDownloadStatus *)aParameters
;
@end
@interface CountersServiceSoapBinding_deleteCounter : CountersServiceSoapBindingOperation {
	CountersServiceSvc_deleteCounter * parameters;
}
@property (strong) CountersServiceSvc_deleteCounter * parameters;
- (id)initWithBinding:(CountersServiceSoapBinding *)aBinding delegate:(id<CountersServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(CountersServiceSvc_deleteCounter *)aParameters
;
@end
@interface CountersServiceSoapBinding_createCounter : CountersServiceSoapBindingOperation {
	CountersServiceSvc_createCounter * parameters;
}
@property (strong) CountersServiceSvc_createCounter * parameters;
- (id)initWithBinding:(CountersServiceSoapBinding *)aBinding delegate:(id<CountersServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(CountersServiceSvc_createCounter *)aParameters
;
@end
@interface CountersServiceSoapBinding_getCounters : CountersServiceSoapBindingOperation {
	CountersServiceSvc_getCounters * parameters;
}
@property (strong) CountersServiceSvc_getCounters * parameters;
- (id)initWithBinding:(CountersServiceSoapBinding *)aBinding delegate:(id<CountersServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(CountersServiceSvc_getCounters *)aParameters
;
@end
@interface CountersServiceSoapBinding_updateCounter : CountersServiceSoapBindingOperation {
	CountersServiceSvc_updateCounter * parameters;
}
@property (strong) CountersServiceSvc_updateCounter * parameters;
- (id)initWithBinding:(CountersServiceSoapBinding *)aBinding delegate:(id<CountersServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(CountersServiceSvc_updateCounter *)aParameters
;
@end
@interface CountersServiceSoapBinding_envelope : NSObject {
}
+ (CountersServiceSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface CountersServiceSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end
