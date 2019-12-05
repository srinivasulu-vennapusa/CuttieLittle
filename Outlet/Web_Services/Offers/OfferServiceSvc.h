#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class OfferServiceSvc_createOffer;
@class OfferServiceSvc_createOfferResponse;
@class OfferServiceSvc_deleteOffers;
@class OfferServiceSvc_deleteOffersResponse;
@class OfferServiceSvc_getOffer;
@class OfferServiceSvc_getOfferResponse;
@class OfferServiceSvc_searchOffers;
@class OfferServiceSvc_searchOffersResponse;
@class OfferServiceSvc_updateOffer;
@class OfferServiceSvc_updateOfferResponse;
@interface OfferServiceSvc_createOffer : NSObject {
    
    /* elements */
    NSString * offerDetails;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OfferServiceSvc_createOffer *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * offerDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OfferServiceSvc_createOfferResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OfferServiceSvc_createOfferResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OfferServiceSvc_deleteOffers : NSObject {
    
    /* elements */
    NSString * offerIDs;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OfferServiceSvc_deleteOffers *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * offerIDs;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OfferServiceSvc_deleteOffersResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OfferServiceSvc_deleteOffersResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OfferServiceSvc_getOffer : NSObject {
    
    /* elements */
    NSString * offerID;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OfferServiceSvc_getOffer *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * offerID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OfferServiceSvc_getOfferResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OfferServiceSvc_getOfferResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OfferServiceSvc_searchOffers : NSObject {
    
    /* elements */
    NSString * searchCriteria;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OfferServiceSvc_searchOffers *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * searchCriteria;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OfferServiceSvc_searchOffersResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OfferServiceSvc_searchOffersResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OfferServiceSvc_updateOffer : NSObject {
    
    /* elements */
    NSString * offerDetails;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OfferServiceSvc_updateOffer *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * offerDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface OfferServiceSvc_updateOfferResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (OfferServiceSvc_updateOfferResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "OfferServiceSvc.h"
@class OfferServiceSoapBinding;
@interface OfferServiceSvc : NSObject {
    
}
+ (OfferServiceSoapBinding *)OfferServiceSoapBinding;
@end
@class OfferServiceSoapBindingResponse;
@class OfferServiceSoapBindingOperation;
@protocol OfferServiceSoapBindingResponseDelegate <NSObject>
- (void) operation:(OfferServiceSoapBindingOperation *)operation completedWithResponse:(OfferServiceSoapBindingResponse *)response;
@end
@interface OfferServiceSoapBinding : NSObject <OfferServiceSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(OfferServiceSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (OfferServiceSoapBindingResponse *)searchOffersUsingParameters:(OfferServiceSvc_searchOffers *)aParameters ;
- (void)searchOffersAsyncUsingParameters:(OfferServiceSvc_searchOffers *)aParameters  delegate:(id<OfferServiceSoapBindingResponseDelegate>)responseDelegate;
- (OfferServiceSoapBindingResponse *)updateOfferUsingParameters:(OfferServiceSvc_updateOffer *)aParameters ;
- (void)updateOfferAsyncUsingParameters:(OfferServiceSvc_updateOffer *)aParameters  delegate:(id<OfferServiceSoapBindingResponseDelegate>)responseDelegate;
- (OfferServiceSoapBindingResponse *)deleteOffersUsingParameters:(OfferServiceSvc_deleteOffers *)aParameters ;
- (void)deleteOffersAsyncUsingParameters:(OfferServiceSvc_deleteOffers *)aParameters  delegate:(id<OfferServiceSoapBindingResponseDelegate>)responseDelegate;
- (OfferServiceSoapBindingResponse *)getOfferUsingParameters:(OfferServiceSvc_getOffer *)aParameters ;
- (void)getOfferAsyncUsingParameters:(OfferServiceSvc_getOffer *)aParameters  delegate:(id<OfferServiceSoapBindingResponseDelegate>)responseDelegate;
- (OfferServiceSoapBindingResponse *)createOfferUsingParameters:(OfferServiceSvc_createOffer *)aParameters ;
- (void)createOfferAsyncUsingParameters:(OfferServiceSvc_createOffer *)aParameters  delegate:(id<OfferServiceSoapBindingResponseDelegate>)responseDelegate;
@end
@interface OfferServiceSoapBindingOperation : NSOperation {
    OfferServiceSoapBinding *binding;
    OfferServiceSoapBindingResponse * response;
    id<OfferServiceSoapBindingResponseDelegate> delegate;
    NSMutableData *responseData;
    NSURLConnection *urlConnection;
}
@property (strong) OfferServiceSoapBinding *binding;
@property (  readonly) OfferServiceSoapBindingResponse *response;
@property (nonatomic, strong) id<OfferServiceSoapBindingResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(OfferServiceSoapBinding *)aBinding delegate:(id<OfferServiceSoapBindingResponseDelegate>)aDelegate;
@end
@interface OfferServiceSoapBinding_searchOffers : OfferServiceSoapBindingOperation {
    OfferServiceSvc_searchOffers * parameters;
}
@property (strong) OfferServiceSvc_searchOffers * parameters;
- (id)initWithBinding:(OfferServiceSoapBinding *)aBinding delegate:(id<OfferServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(OfferServiceSvc_searchOffers *)aParameters
;
@end
@interface OfferServiceSoapBinding_updateOffer : OfferServiceSoapBindingOperation {
    OfferServiceSvc_updateOffer * parameters;
}
@property (strong) OfferServiceSvc_updateOffer * parameters;
- (id)initWithBinding:(OfferServiceSoapBinding *)aBinding delegate:(id<OfferServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(OfferServiceSvc_updateOffer *)aParameters
;
@end
@interface OfferServiceSoapBinding_deleteOffers : OfferServiceSoapBindingOperation {
    OfferServiceSvc_deleteOffers * parameters;
}
@property (strong) OfferServiceSvc_deleteOffers * parameters;
- (id)initWithBinding:(OfferServiceSoapBinding *)aBinding delegate:(id<OfferServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(OfferServiceSvc_deleteOffers *)aParameters
;
@end
@interface OfferServiceSoapBinding_getOffer : OfferServiceSoapBindingOperation {
    OfferServiceSvc_getOffer * parameters;
}
@property (strong) OfferServiceSvc_getOffer * parameters;
- (id)initWithBinding:(OfferServiceSoapBinding *)aBinding delegate:(id<OfferServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(OfferServiceSvc_getOffer *)aParameters
;
@end
@interface OfferServiceSoapBinding_createOffer : OfferServiceSoapBindingOperation {
    OfferServiceSvc_createOffer * parameters;
}
@property (strong) OfferServiceSvc_createOffer * parameters;
- (id)initWithBinding:(OfferServiceSoapBinding *)aBinding delegate:(id<OfferServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(OfferServiceSvc_createOffer *)aParameters
;
@end
@interface OfferServiceSoapBinding_envelope : NSObject {
}
+ (OfferServiceSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface OfferServiceSoapBindingResponse : NSObject {
    NSArray *headers;
    NSArray *bodyParts;
    NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end
