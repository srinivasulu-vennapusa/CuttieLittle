#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class DealServicesSvc_applyDealsAndOffers;
@class DealServicesSvc_applyDealsAndOffersResponse;
@class DealServicesSvc_createDeal;
@class DealServicesSvc_createDealResponse;
@class DealServicesSvc_deleteDeals;
@class DealServicesSvc_deleteDealsResponse;
@class DealServicesSvc_getDeals;
@class DealServicesSvc_getDealsResponse;
@class DealServicesSvc_searchDeals;
@class DealServicesSvc_searchDealsResponse;
@class DealServicesSvc_updateDeal;
@class DealServicesSvc_updateDealResponse;
@interface DealServicesSvc_applyDealsAndOffers : NSObject {
    
    /* elements */
    NSString * dealDetails;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (DealServicesSvc_applyDealsAndOffers *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * dealDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface DealServicesSvc_applyDealsAndOffersResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (DealServicesSvc_applyDealsAndOffersResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface DealServicesSvc_createDeal : NSObject {
    
    /* elements */
    NSString * dealDetails;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (DealServicesSvc_createDeal *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * dealDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface DealServicesSvc_createDealResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (DealServicesSvc_createDealResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface DealServicesSvc_deleteDeals : NSObject {
    
    /* elements */
    NSString * dealDetails;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (DealServicesSvc_deleteDeals *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * dealDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface DealServicesSvc_deleteDealsResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (DealServicesSvc_deleteDealsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface DealServicesSvc_getDeals : NSObject {
    
    /* elements */
    NSString * dealDetails;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (DealServicesSvc_getDeals *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * dealDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface DealServicesSvc_getDealsResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (DealServicesSvc_getDealsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface DealServicesSvc_searchDeals : NSObject {
    
    /* elements */
    NSString * searchCriteria;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (DealServicesSvc_searchDeals *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * searchCriteria;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface DealServicesSvc_searchDealsResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (DealServicesSvc_searchDealsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface DealServicesSvc_updateDeal : NSObject {
    
    /* elements */
    NSString * dealDetails;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (DealServicesSvc_updateDeal *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * dealDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface DealServicesSvc_updateDealResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (DealServicesSvc_updateDealResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "DealServicesSvc.h"
@class DealServicesSoapBinding;
@interface DealServicesSvc : NSObject {
    
}
+ (DealServicesSoapBinding *)DealServicesSoapBinding;
@end
@class DealServicesSoapBindingResponse;
@class DealServicesSoapBindingOperation;
@protocol DealServicesSoapBindingResponseDelegate <NSObject>
- (void) operation:(DealServicesSoapBindingOperation *)operation completedWithResponse:(DealServicesSoapBindingResponse *)response;
@end
@interface DealServicesSoapBinding : NSObject <DealServicesSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(DealServicesSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (DealServicesSoapBindingResponse *)updateDealUsingParameters:(DealServicesSvc_updateDeal *)aParameters ;
- (void)updateDealAsyncUsingParameters:(DealServicesSvc_updateDeal *)aParameters  delegate:(id<DealServicesSoapBindingResponseDelegate>)responseDelegate;
- (DealServicesSoapBindingResponse *)getDealsUsingParameters:(DealServicesSvc_getDeals *)aParameters ;
- (void)getDealsAsyncUsingParameters:(DealServicesSvc_getDeals *)aParameters  delegate:(id<DealServicesSoapBindingResponseDelegate>)responseDelegate;
- (DealServicesSoapBindingResponse *)applyDealsAndOffersUsingParameters:(DealServicesSvc_applyDealsAndOffers *)aParameters ;
- (void)applyDealsAndOffersAsyncUsingParameters:(DealServicesSvc_applyDealsAndOffers *)aParameters  delegate:(id<DealServicesSoapBindingResponseDelegate>)responseDelegate;
- (DealServicesSoapBindingResponse *)createDealUsingParameters:(DealServicesSvc_createDeal *)aParameters ;
- (void)createDealAsyncUsingParameters:(DealServicesSvc_createDeal *)aParameters  delegate:(id<DealServicesSoapBindingResponseDelegate>)responseDelegate;
- (DealServicesSoapBindingResponse *)searchDealsUsingParameters:(DealServicesSvc_searchDeals *)aParameters ;
- (void)searchDealsAsyncUsingParameters:(DealServicesSvc_searchDeals *)aParameters  delegate:(id<DealServicesSoapBindingResponseDelegate>)responseDelegate;
- (DealServicesSoapBindingResponse *)deleteDealsUsingParameters:(DealServicesSvc_deleteDeals *)aParameters ;
- (void)deleteDealsAsyncUsingParameters:(DealServicesSvc_deleteDeals *)aParameters  delegate:(id<DealServicesSoapBindingResponseDelegate>)responseDelegate;
@end
@interface DealServicesSoapBindingOperation : NSOperation {
    DealServicesSoapBinding *binding;
    DealServicesSoapBindingResponse *response;
    id<DealServicesSoapBindingResponseDelegate> delegate;
    NSMutableData *responseData;
    NSURLConnection *urlConnection;
}
@property (retain) DealServicesSoapBinding *binding;
@property (readonly) DealServicesSoapBindingResponse *response;
@property (nonatomic, assign) id<DealServicesSoapBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(DealServicesSoapBinding *)aBinding delegate:(id<DealServicesSoapBindingResponseDelegate>)aDelegate;
@end
@interface DealServicesSoapBinding_updateDeal : DealServicesSoapBindingOperation {
    DealServicesSvc_updateDeal * parameters;
}
@property (retain) DealServicesSvc_updateDeal * parameters;
- (id)initWithBinding:(DealServicesSoapBinding *)aBinding delegate:(id<DealServicesSoapBindingResponseDelegate>)aDelegate
           parameters:(DealServicesSvc_updateDeal *)aParameters
;
@end
@interface DealServicesSoapBinding_getDeals : DealServicesSoapBindingOperation {
    DealServicesSvc_getDeals * parameters;
}
@property (retain) DealServicesSvc_getDeals * parameters;
- (id)initWithBinding:(DealServicesSoapBinding *)aBinding delegate:(id<DealServicesSoapBindingResponseDelegate>)aDelegate
           parameters:(DealServicesSvc_getDeals *)aParameters
;
@end
@interface DealServicesSoapBinding_applyDealsAndOffers : DealServicesSoapBindingOperation {
    DealServicesSvc_applyDealsAndOffers * parameters;
}
@property (retain) DealServicesSvc_applyDealsAndOffers * parameters;
- (id)initWithBinding:(DealServicesSoapBinding *)aBinding delegate:(id<DealServicesSoapBindingResponseDelegate>)aDelegate
           parameters:(DealServicesSvc_applyDealsAndOffers *)aParameters
;
@end
@interface DealServicesSoapBinding_createDeal : DealServicesSoapBindingOperation {
    DealServicesSvc_createDeal * parameters;
}
@property (retain) DealServicesSvc_createDeal * parameters;
- (id)initWithBinding:(DealServicesSoapBinding *)aBinding delegate:(id<DealServicesSoapBindingResponseDelegate>)aDelegate
           parameters:(DealServicesSvc_createDeal *)aParameters
;
@end
@interface DealServicesSoapBinding_searchDeals : DealServicesSoapBindingOperation {
    DealServicesSvc_searchDeals * parameters;
}
@property (retain) DealServicesSvc_searchDeals * parameters;
- (id)initWithBinding:(DealServicesSoapBinding *)aBinding delegate:(id<DealServicesSoapBindingResponseDelegate>)aDelegate
           parameters:(DealServicesSvc_searchDeals *)aParameters
;
@end
@interface DealServicesSoapBinding_deleteDeals : DealServicesSoapBindingOperation {
    DealServicesSvc_deleteDeals * parameters;
}
@property (retain) DealServicesSvc_deleteDeals * parameters;
- (id)initWithBinding:(DealServicesSoapBinding *)aBinding delegate:(id<DealServicesSoapBindingResponseDelegate>)aDelegate
           parameters:(DealServicesSvc_deleteDeals *)aParameters
;
@end
@interface DealServicesSoapBinding_envelope : NSObject {
}
+ (DealServicesSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface DealServicesSoapBindingResponse : NSObject {
    NSArray *headers;
    NSArray *bodyParts;
    NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
