#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
#import "Global.h"
@class StockIssueServiceSvc_createStockIssue;
@class StockIssueServiceSvc_createStockIssueResponse;
@class StockIssueServiceSvc_getStockIssue;
@class StockIssueServiceSvc_getStockIssueIds;
@class StockIssueServiceSvc_getStockIssueIdsResponse;
@class StockIssueServiceSvc_getStockIssueResponse;
@class StockIssueServiceSvc_getStockIssues;
@class StockIssueServiceSvc_getStockIssuesResponse;
@class StockIssueServiceSvc_helloworld;
@class StockIssueServiceSvc_helloworldResponse;
@class StockIssueServiceSvc_updateStockIssue;
@class StockIssueServiceSvc_updateStockIssueResponse;
@interface StockIssueServiceSvc_createStockIssue : NSObject {
    
    /* elements */
    NSString * stockIssueDetails;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockIssueServiceSvc_createStockIssue *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * stockIssueDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockIssueServiceSvc_createStockIssueResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockIssueServiceSvc_createStockIssueResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockIssueServiceSvc_getStockIssue : NSObject {
    
    /* elements */
    NSString * issueID;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockIssueServiceSvc_getStockIssue *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * issueID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockIssueServiceSvc_getStockIssueIds : NSObject {
    
    /* elements */
    NSString * searchCriteria;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockIssueServiceSvc_getStockIssueIds *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * searchCriteria;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockIssueServiceSvc_getStockIssueIdsResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockIssueServiceSvc_getStockIssueIdsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockIssueServiceSvc_getStockIssueResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockIssueServiceSvc_getStockIssueResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockIssueServiceSvc_getStockIssues : NSObject {
    
    /* elements */
    NSString * searchCriteria;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockIssueServiceSvc_getStockIssues *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * searchCriteria;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockIssueServiceSvc_getStockIssuesResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockIssueServiceSvc_getStockIssuesResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockIssueServiceSvc_helloworld : NSObject {
    
    /* elements */
    NSString * testString;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockIssueServiceSvc_helloworld *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * testString;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockIssueServiceSvc_helloworldResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockIssueServiceSvc_helloworldResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockIssueServiceSvc_updateStockIssue : NSObject {
    
    /* elements */
    NSString * stockIssueDetails;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockIssueServiceSvc_updateStockIssue *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * stockIssueDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockIssueServiceSvc_updateStockIssueResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockIssueServiceSvc_updateStockIssueResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "StockIssueServiceSvc.h"
@class StockIssueServiceSoapBinding;
@interface StockIssueServiceSvc : NSObject {
    
}
+ (StockIssueServiceSoapBinding *)StockIssueServiceSoapBinding;
@end
@class StockIssueServiceSoapBindingResponse;
@class StockIssueServiceSoapBindingOperation;
@protocol StockIssueServiceSoapBindingResponseDelegate <NSObject>
- (void) operation:(StockIssueServiceSoapBindingOperation *)operation completedWithResponse:(StockIssueServiceSoapBindingResponse *)response;
@end
@interface StockIssueServiceSoapBinding : NSObject <StockIssueServiceSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(StockIssueServiceSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (StockIssueServiceSoapBindingResponse *)getStockIssueIdsUsingParameters:(StockIssueServiceSvc_getStockIssueIds *)aParameters ;
- (void)getStockIssueIdsAsyncUsingParameters:(StockIssueServiceSvc_getStockIssueIds *)aParameters  delegate:(id<StockIssueServiceSoapBindingResponseDelegate>)responseDelegate;
- (StockIssueServiceSoapBindingResponse *)getStockIssueUsingParameters:(StockIssueServiceSvc_getStockIssue *)aParameters ;
- (void)getStockIssueAsyncUsingParameters:(StockIssueServiceSvc_getStockIssue *)aParameters  delegate:(id<StockIssueServiceSoapBindingResponseDelegate>)responseDelegate;
- (StockIssueServiceSoapBindingResponse *)updateStockIssueUsingParameters:(StockIssueServiceSvc_updateStockIssue *)aParameters ;
- (void)updateStockIssueAsyncUsingParameters:(StockIssueServiceSvc_updateStockIssue *)aParameters  delegate:(id<StockIssueServiceSoapBindingResponseDelegate>)responseDelegate;
- (StockIssueServiceSoapBindingResponse *)helloworldUsingParameters:(StockIssueServiceSvc_helloworld *)aParameters ;
- (void)helloworldAsyncUsingParameters:(StockIssueServiceSvc_helloworld *)aParameters  delegate:(id<StockIssueServiceSoapBindingResponseDelegate>)responseDelegate;
- (StockIssueServiceSoapBindingResponse *)createStockIssueUsingParameters:(StockIssueServiceSvc_createStockIssue *)aParameters ;
- (void)createStockIssueAsyncUsingParameters:(StockIssueServiceSvc_createStockIssue *)aParameters  delegate:(id<StockIssueServiceSoapBindingResponseDelegate>)responseDelegate;
- (StockIssueServiceSoapBindingResponse *)getStockIssuesUsingParameters:(StockIssueServiceSvc_getStockIssues *)aParameters ;
- (void)getStockIssuesAsyncUsingParameters:(StockIssueServiceSvc_getStockIssues *)aParameters  delegate:(id<StockIssueServiceSoapBindingResponseDelegate>)responseDelegate;
@end
@interface StockIssueServiceSoapBindingOperation : NSOperation {
    StockIssueServiceSoapBinding *binding;
    StockIssueServiceSoapBindingResponse * response;
    id<StockIssueServiceSoapBindingResponseDelegate>  delegate;
    NSMutableData *responseData;
    NSURLConnection *urlConnection;
}
@property (strong) StockIssueServiceSoapBinding *binding;
@property (  readonly) StockIssueServiceSoapBindingResponse *response;
@property (nonatomic ) id<StockIssueServiceSoapBindingResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(StockIssueServiceSoapBinding *)aBinding delegate:(id<StockIssueServiceSoapBindingResponseDelegate>)aDelegate;
@end
@interface StockIssueServiceSoapBinding_getStockIssueIds : StockIssueServiceSoapBindingOperation {
    StockIssueServiceSvc_getStockIssueIds * parameters;
}
@property (strong) StockIssueServiceSvc_getStockIssueIds * parameters;
- (id)initWithBinding:(StockIssueServiceSoapBinding *)aBinding delegate:(id<StockIssueServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(StockIssueServiceSvc_getStockIssueIds *)aParameters
;
@end
@interface StockIssueServiceSoapBinding_getStockIssue : StockIssueServiceSoapBindingOperation {
    StockIssueServiceSvc_getStockIssue * parameters;
}
@property (strong) StockIssueServiceSvc_getStockIssue * parameters;
- (id)initWithBinding:(StockIssueServiceSoapBinding *)aBinding delegate:(id<StockIssueServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(StockIssueServiceSvc_getStockIssue *)aParameters
;
@end
@interface StockIssueServiceSoapBinding_updateStockIssue : StockIssueServiceSoapBindingOperation {
    StockIssueServiceSvc_updateStockIssue * parameters;
}
@property (strong) StockIssueServiceSvc_updateStockIssue * parameters;
- (id)initWithBinding:(StockIssueServiceSoapBinding *)aBinding delegate:(id<StockIssueServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(StockIssueServiceSvc_updateStockIssue *)aParameters
;
@end
@interface StockIssueServiceSoapBinding_helloworld : StockIssueServiceSoapBindingOperation {
    StockIssueServiceSvc_helloworld * parameters;
}
@property (strong) StockIssueServiceSvc_helloworld * parameters;
- (id)initWithBinding:(StockIssueServiceSoapBinding *)aBinding delegate:(id<StockIssueServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(StockIssueServiceSvc_helloworld *)aParameters
;
@end
@interface StockIssueServiceSoapBinding_createStockIssue : StockIssueServiceSoapBindingOperation {
    StockIssueServiceSvc_createStockIssue * parameters;
}
@property (strong) StockIssueServiceSvc_createStockIssue * parameters;
- (id)initWithBinding:(StockIssueServiceSoapBinding *)aBinding delegate:(id<StockIssueServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(StockIssueServiceSvc_createStockIssue *)aParameters
;
@end
@interface StockIssueServiceSoapBinding_getStockIssues : StockIssueServiceSoapBindingOperation {
    StockIssueServiceSvc_getStockIssues * parameters;
}
@property (strong) StockIssueServiceSvc_getStockIssues * parameters;
- (id)initWithBinding:(StockIssueServiceSoapBinding *)aBinding delegate:(id<StockIssueServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(StockIssueServiceSvc_getStockIssues *)aParameters
;
@end
@interface StockIssueServiceSoapBinding_envelope : NSObject {
}
+ (StockIssueServiceSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface StockIssueServiceSoapBindingResponse : NSObject {
    NSArray *headers;
    NSArray *bodyParts;
    NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end
