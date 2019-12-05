#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class WHStockIssueServices_createStockIssue;
@class WHStockIssueServices_createStockIssueResponse;
@class WHStockIssueServices_getStockIssue;
@class WHStockIssueServices_getStockIssueIds;
@class WHStockIssueServices_getStockIssueIdsResponse;
@class WHStockIssueServices_getStockIssueResponse;
@class WHStockIssueServices_getStockIssues;
@class WHStockIssueServices_getStockIssuesResponse;
@class WHStockIssueServices_updateStockIssue;
@class WHStockIssueServices_updateStockIssueResponse;
@interface WHStockIssueServices_createStockIssue : NSObject {
	
/* elements */
	NSString * stockIssueDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHStockIssueServices_createStockIssue *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * stockIssueDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHStockIssueServices_createStockIssueResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHStockIssueServices_createStockIssueResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHStockIssueServices_getStockIssue : NSObject {
	
/* elements */
	NSString * issueID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHStockIssueServices_getStockIssue *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * issueID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHStockIssueServices_getStockIssueIds : NSObject {
	
/* elements */
	NSString * searchCriteria;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHStockIssueServices_getStockIssueIds *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * searchCriteria;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHStockIssueServices_getStockIssueIdsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHStockIssueServices_getStockIssueIdsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHStockIssueServices_getStockIssueResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHStockIssueServices_getStockIssueResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHStockIssueServices_getStockIssues : NSObject {
	
/* elements */
	NSString * searchCriteria;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHStockIssueServices_getStockIssues *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * searchCriteria;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHStockIssueServices_getStockIssuesResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHStockIssueServices_getStockIssuesResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHStockIssueServices_updateStockIssue : NSObject {
	
/* elements */
	NSString * stockIssueDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHStockIssueServices_updateStockIssue *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * stockIssueDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHStockIssueServices_updateStockIssueResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHStockIssueServices_updateStockIssueResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "WHStockIssueServices.h"
@class WHStockIssueServicesSoapBinding;
@interface WHStockIssueServices : NSObject {
	
}
+ (WHStockIssueServicesSoapBinding *)WHStockIssueServicesSoapBinding;
@end
@class WHStockIssueServicesSoapBindingResponse;
@class WHStockIssueServicesSoapBindingOperation;
@protocol WHStockIssueServicesSoapBindingResponseDelegate <NSObject>
- (void) operation:(WHStockIssueServicesSoapBindingOperation *)operation completedWithResponse:(WHStockIssueServicesSoapBindingResponse *)response;
@end
@interface WHStockIssueServicesSoapBinding : NSObject <WHStockIssueServicesSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(WHStockIssueServicesSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (WHStockIssueServicesSoapBindingResponse *)getStockIssueIdsUsingParameters:(WHStockIssueServices_getStockIssueIds *)aParameters ;
- (void)getStockIssueIdsAsyncUsingParameters:(WHStockIssueServices_getStockIssueIds *)aParameters  delegate:(id<WHStockIssueServicesSoapBindingResponseDelegate>)responseDelegate;
- (WHStockIssueServicesSoapBindingResponse *)getStockIssueUsingParameters:(WHStockIssueServices_getStockIssue *)aParameters ;
- (void)getStockIssueAsyncUsingParameters:(WHStockIssueServices_getStockIssue *)aParameters  delegate:(id<WHStockIssueServicesSoapBindingResponseDelegate>)responseDelegate;
- (WHStockIssueServicesSoapBindingResponse *)createStockIssueUsingParameters:(WHStockIssueServices_createStockIssue *)aParameters ;
- (void)createStockIssueAsyncUsingParameters:(WHStockIssueServices_createStockIssue *)aParameters  delegate:(id<WHStockIssueServicesSoapBindingResponseDelegate>)responseDelegate;
- (WHStockIssueServicesSoapBindingResponse *)getStockIssuesUsingParameters:(WHStockIssueServices_getStockIssues *)aParameters ;
- (void)getStockIssuesAsyncUsingParameters:(WHStockIssueServices_getStockIssues *)aParameters  delegate:(id<WHStockIssueServicesSoapBindingResponseDelegate>)responseDelegate;
- (WHStockIssueServicesSoapBindingResponse *)updateStockIssueUsingParameters:(WHStockIssueServices_updateStockIssue *)aParameters ;
- (void)updateStockIssueAsyncUsingParameters:(WHStockIssueServices_updateStockIssue *)aParameters  delegate:(id<WHStockIssueServicesSoapBindingResponseDelegate>)responseDelegate;
@end
@interface WHStockIssueServicesSoapBindingOperation : NSOperation {
	WHStockIssueServicesSoapBinding *binding;
	WHStockIssueServicesSoapBindingResponse *response;
	id<WHStockIssueServicesSoapBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) WHStockIssueServicesSoapBinding *binding;
@property (readonly) WHStockIssueServicesSoapBindingResponse *response;
@property (nonatomic, assign) id<WHStockIssueServicesSoapBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(WHStockIssueServicesSoapBinding *)aBinding delegate:(id<WHStockIssueServicesSoapBindingResponseDelegate>)aDelegate;
@end
@interface WHStockIssueServicesSoapBinding_getStockIssueIds : WHStockIssueServicesSoapBindingOperation {
	WHStockIssueServices_getStockIssueIds * parameters;
}
@property (retain) WHStockIssueServices_getStockIssueIds * parameters;
- (id)initWithBinding:(WHStockIssueServicesSoapBinding *)aBinding delegate:(id<WHStockIssueServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(WHStockIssueServices_getStockIssueIds *)aParameters
;
@end
@interface WHStockIssueServicesSoapBinding_getStockIssue : WHStockIssueServicesSoapBindingOperation {
	WHStockIssueServices_getStockIssue * parameters;
}
@property (retain) WHStockIssueServices_getStockIssue * parameters;
- (id)initWithBinding:(WHStockIssueServicesSoapBinding *)aBinding delegate:(id<WHStockIssueServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(WHStockIssueServices_getStockIssue *)aParameters
;
@end
@interface WHStockIssueServicesSoapBinding_createStockIssue : WHStockIssueServicesSoapBindingOperation {
	WHStockIssueServices_createStockIssue * parameters;
}
@property (retain) WHStockIssueServices_createStockIssue * parameters;
- (id)initWithBinding:(WHStockIssueServicesSoapBinding *)aBinding delegate:(id<WHStockIssueServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(WHStockIssueServices_createStockIssue *)aParameters
;
@end
@interface WHStockIssueServicesSoapBinding_getStockIssues : WHStockIssueServicesSoapBindingOperation {
	WHStockIssueServices_getStockIssues * parameters;
}
@property (retain) WHStockIssueServices_getStockIssues * parameters;
- (id)initWithBinding:(WHStockIssueServicesSoapBinding *)aBinding delegate:(id<WHStockIssueServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(WHStockIssueServices_getStockIssues *)aParameters
;
@end
@interface WHStockIssueServicesSoapBinding_updateStockIssue : WHStockIssueServicesSoapBindingOperation {
	WHStockIssueServices_updateStockIssue * parameters;
}
@property (retain) WHStockIssueServices_updateStockIssue * parameters;
- (id)initWithBinding:(WHStockIssueServicesSoapBinding *)aBinding delegate:(id<WHStockIssueServicesSoapBindingResponseDelegate>)aDelegate
	parameters:(WHStockIssueServices_updateStockIssue *)aParameters
;
@end
@interface WHStockIssueServicesSoapBinding_envelope : NSObject {
}
+ (WHStockIssueServicesSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface WHStockIssueServicesSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
