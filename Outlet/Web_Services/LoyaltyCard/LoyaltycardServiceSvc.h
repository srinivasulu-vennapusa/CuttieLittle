#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class LoyaltycardServiceSvc_createLoyaltyCards;
@class LoyaltycardServiceSvc_createLoyaltyCardsResponse;
@class LoyaltycardServiceSvc_getAvailableLoyaltyPrograms;
@class LoyaltycardServiceSvc_getAvailableLoyaltyProgramsResponse;
@class LoyaltycardServiceSvc_getLoyaltyCards;
@class LoyaltycardServiceSvc_getLoyaltyCardsResponse;
@class LoyaltycardServiceSvc_getissuedLoyaltycard;
@class LoyaltycardServiceSvc_getissuedLoyaltycardResponse;
@class LoyaltycardServiceSvc_getloyaltyCardIds;
@class LoyaltycardServiceSvc_getloyaltyCardIdsResponse;
@class LoyaltycardServiceSvc_getloyaltyCardNumber;
@class LoyaltycardServiceSvc_getloyaltyCardNumberResponse;
@class LoyaltycardServiceSvc_issueLoyaltyCard;
@class LoyaltycardServiceSvc_issueLoyaltyCardResponse;
@class LoyaltycardServiceSvc_updateIssuedLoyaltyCards;
@class LoyaltycardServiceSvc_updateIssuedLoyaltyCardsResponse;
@interface LoyaltycardServiceSvc_createLoyaltyCards : NSObject {
    
    /* elements */
    NSString * loyaltyCardDetails;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LoyaltycardServiceSvc_createLoyaltyCards *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * loyaltyCardDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoyaltycardServiceSvc_createLoyaltyCardsResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LoyaltycardServiceSvc_createLoyaltyCardsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoyaltycardServiceSvc_getAvailableLoyaltyPrograms : NSObject {
    
    /* elements */
    NSString * loyaltyCardDetails;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LoyaltycardServiceSvc_getAvailableLoyaltyPrograms *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * loyaltyCardDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoyaltycardServiceSvc_getAvailableLoyaltyProgramsResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LoyaltycardServiceSvc_getAvailableLoyaltyProgramsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoyaltycardServiceSvc_getLoyaltyCards : NSObject {
    
    /* elements */
    NSString * loyaltyCardDetails;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LoyaltycardServiceSvc_getLoyaltyCards *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * loyaltyCardDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoyaltycardServiceSvc_getLoyaltyCardsResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LoyaltycardServiceSvc_getLoyaltyCardsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoyaltycardServiceSvc_getissuedLoyaltycard : NSObject {
    
    /* elements */
    NSString * loyaltyCardNumber;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LoyaltycardServiceSvc_getissuedLoyaltycard *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * loyaltyCardNumber;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoyaltycardServiceSvc_getissuedLoyaltycardResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LoyaltycardServiceSvc_getissuedLoyaltycardResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoyaltycardServiceSvc_getloyaltyCardIds : NSObject {
    
    /* elements */
    NSString * searchCriteria;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LoyaltycardServiceSvc_getloyaltyCardIds *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * searchCriteria;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoyaltycardServiceSvc_getloyaltyCardIdsResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LoyaltycardServiceSvc_getloyaltyCardIdsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoyaltycardServiceSvc_getloyaltyCardNumber : NSObject {
    
    /* elements */
    NSString * requestHeader;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LoyaltycardServiceSvc_getloyaltyCardNumber *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * requestHeader;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoyaltycardServiceSvc_getloyaltyCardNumberResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LoyaltycardServiceSvc_getloyaltyCardNumberResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoyaltycardServiceSvc_issueLoyaltyCard : NSObject {
    
    /* elements */
    NSString * loyaltyCardDetails;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LoyaltycardServiceSvc_issueLoyaltyCard *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * loyaltyCardDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoyaltycardServiceSvc_issueLoyaltyCardResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LoyaltycardServiceSvc_issueLoyaltyCardResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoyaltycardServiceSvc_updateIssuedLoyaltyCards : NSObject {
    
    /* elements */
    NSString * loyaltyCardDetails;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LoyaltycardServiceSvc_updateIssuedLoyaltyCards *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * loyaltyCardDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface LoyaltycardServiceSvc_updateIssuedLoyaltyCardsResponse : NSObject {
    
    /* elements */
    NSString * return_;
    /* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (LoyaltycardServiceSvc_updateIssuedLoyaltyCardsResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "LoyaltycardServiceSvc.h"
@class LoyaltycardServiceSoapBinding;
@interface LoyaltycardServiceSvc : NSObject {
    
}
+ (LoyaltycardServiceSoapBinding *)LoyaltycardServiceSoapBinding;
@end
@class LoyaltycardServiceSoapBindingResponse;
@class LoyaltycardServiceSoapBindingOperation;
@protocol LoyaltycardServiceSoapBindingResponseDelegate <NSObject>
- (void) operation:(LoyaltycardServiceSoapBindingOperation *)operation completedWithResponse:(LoyaltycardServiceSoapBindingResponse *)response;
@end
@interface LoyaltycardServiceSoapBinding : NSObject <LoyaltycardServiceSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(LoyaltycardServiceSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (LoyaltycardServiceSoapBindingResponse *)getloyaltyCardNumberUsingParameters:(LoyaltycardServiceSvc_getloyaltyCardNumber *)aParameters ;
- (void)getloyaltyCardNumberAsyncUsingParameters:(LoyaltycardServiceSvc_getloyaltyCardNumber *)aParameters  delegate:(id<LoyaltycardServiceSoapBindingResponseDelegate>)responseDelegate;
- (LoyaltycardServiceSoapBindingResponse *)updateIssuedLoyaltyCardsUsingParameters:(LoyaltycardServiceSvc_updateIssuedLoyaltyCards *)aParameters ;
- (void)updateIssuedLoyaltyCardsAsyncUsingParameters:(LoyaltycardServiceSvc_updateIssuedLoyaltyCards *)aParameters  delegate:(id<LoyaltycardServiceSoapBindingResponseDelegate>)responseDelegate;
- (LoyaltycardServiceSoapBindingResponse *)getLoyaltyCardsUsingParameters:(LoyaltycardServiceSvc_getLoyaltyCards *)aParameters ;
- (void)getLoyaltyCardsAsyncUsingParameters:(LoyaltycardServiceSvc_getLoyaltyCards *)aParameters  delegate:(id<LoyaltycardServiceSoapBindingResponseDelegate>)responseDelegate;
- (LoyaltycardServiceSoapBindingResponse *)createLoyaltyCardsUsingParameters:(LoyaltycardServiceSvc_createLoyaltyCards *)aParameters ;
- (void)createLoyaltyCardsAsyncUsingParameters:(LoyaltycardServiceSvc_createLoyaltyCards *)aParameters  delegate:(id<LoyaltycardServiceSoapBindingResponseDelegate>)responseDelegate;
- (LoyaltycardServiceSoapBindingResponse *)getAvailableLoyaltyProgramsUsingParameters:(LoyaltycardServiceSvc_getAvailableLoyaltyPrograms *)aParameters ;
- (void)getAvailableLoyaltyProgramsAsyncUsingParameters:(LoyaltycardServiceSvc_getAvailableLoyaltyPrograms *)aParameters  delegate:(id<LoyaltycardServiceSoapBindingResponseDelegate>)responseDelegate;
- (LoyaltycardServiceSoapBindingResponse *)issueLoyaltyCardUsingParameters:(LoyaltycardServiceSvc_issueLoyaltyCard *)aParameters ;
- (void)issueLoyaltyCardAsyncUsingParameters:(LoyaltycardServiceSvc_issueLoyaltyCard *)aParameters  delegate:(id<LoyaltycardServiceSoapBindingResponseDelegate>)responseDelegate;
- (LoyaltycardServiceSoapBindingResponse *)getloyaltyCardIdsUsingParameters:(LoyaltycardServiceSvc_getloyaltyCardIds *)aParameters ;
- (void)getloyaltyCardIdsAsyncUsingParameters:(LoyaltycardServiceSvc_getloyaltyCardIds *)aParameters  delegate:(id<LoyaltycardServiceSoapBindingResponseDelegate>)responseDelegate;
- (LoyaltycardServiceSoapBindingResponse *)getissuedLoyaltycardUsingParameters:(LoyaltycardServiceSvc_getissuedLoyaltycard *)aParameters ;
- (void)getissuedLoyaltycardAsyncUsingParameters:(LoyaltycardServiceSvc_getissuedLoyaltycard *)aParameters  delegate:(id<LoyaltycardServiceSoapBindingResponseDelegate>)responseDelegate;
@end
@interface LoyaltycardServiceSoapBindingOperation : NSOperation {
    LoyaltycardServiceSoapBinding *binding;
    LoyaltycardServiceSoapBindingResponse * response;
    id<LoyaltycardServiceSoapBindingResponseDelegate>  delegate;
    NSMutableData *responseData;
    NSURLConnection *urlConnection;
}
@property (strong) LoyaltycardServiceSoapBinding *binding;
@property (  readonly) LoyaltycardServiceSoapBindingResponse *response;
@property (nonatomic ) id<LoyaltycardServiceSoapBindingResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(LoyaltycardServiceSoapBinding *)aBinding delegate:(id<LoyaltycardServiceSoapBindingResponseDelegate>)aDelegate;
@end
@interface LoyaltycardServiceSoapBinding_getloyaltyCardNumber : LoyaltycardServiceSoapBindingOperation {
    LoyaltycardServiceSvc_getloyaltyCardNumber * parameters;
}
@property (strong) LoyaltycardServiceSvc_getloyaltyCardNumber * parameters;
- (id)initWithBinding:(LoyaltycardServiceSoapBinding *)aBinding delegate:(id<LoyaltycardServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(LoyaltycardServiceSvc_getloyaltyCardNumber *)aParameters
;
@end
@interface LoyaltycardServiceSoapBinding_updateIssuedLoyaltyCards : LoyaltycardServiceSoapBindingOperation {
    LoyaltycardServiceSvc_updateIssuedLoyaltyCards * parameters;
}
@property (strong) LoyaltycardServiceSvc_updateIssuedLoyaltyCards * parameters;
- (id)initWithBinding:(LoyaltycardServiceSoapBinding *)aBinding delegate:(id<LoyaltycardServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(LoyaltycardServiceSvc_updateIssuedLoyaltyCards *)aParameters
;
@end
@interface LoyaltycardServiceSoapBinding_getLoyaltyCards : LoyaltycardServiceSoapBindingOperation {
    LoyaltycardServiceSvc_getLoyaltyCards * parameters;
}
@property (strong) LoyaltycardServiceSvc_getLoyaltyCards * parameters;
- (id)initWithBinding:(LoyaltycardServiceSoapBinding *)aBinding delegate:(id<LoyaltycardServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(LoyaltycardServiceSvc_getLoyaltyCards *)aParameters
;
@end
@interface LoyaltycardServiceSoapBinding_createLoyaltyCards : LoyaltycardServiceSoapBindingOperation {
    LoyaltycardServiceSvc_createLoyaltyCards * parameters;
}
@property (strong) LoyaltycardServiceSvc_createLoyaltyCards * parameters;
- (id)initWithBinding:(LoyaltycardServiceSoapBinding *)aBinding delegate:(id<LoyaltycardServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(LoyaltycardServiceSvc_createLoyaltyCards *)aParameters
;
@end
@interface LoyaltycardServiceSoapBinding_getAvailableLoyaltyPrograms : LoyaltycardServiceSoapBindingOperation {
    LoyaltycardServiceSvc_getAvailableLoyaltyPrograms * parameters;
}
@property (strong) LoyaltycardServiceSvc_getAvailableLoyaltyPrograms * parameters;
- (id)initWithBinding:(LoyaltycardServiceSoapBinding *)aBinding delegate:(id<LoyaltycardServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(LoyaltycardServiceSvc_getAvailableLoyaltyPrograms *)aParameters
;
@end
@interface LoyaltycardServiceSoapBinding_issueLoyaltyCard : LoyaltycardServiceSoapBindingOperation {
    LoyaltycardServiceSvc_issueLoyaltyCard * parameters;
}
@property (strong) LoyaltycardServiceSvc_issueLoyaltyCard * parameters;
- (id)initWithBinding:(LoyaltycardServiceSoapBinding *)aBinding delegate:(id<LoyaltycardServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(LoyaltycardServiceSvc_issueLoyaltyCard *)aParameters
;
@end
@interface LoyaltycardServiceSoapBinding_getloyaltyCardIds : LoyaltycardServiceSoapBindingOperation {
    LoyaltycardServiceSvc_getloyaltyCardIds * parameters;
}
@property (strong) LoyaltycardServiceSvc_getloyaltyCardIds * parameters;
- (id)initWithBinding:(LoyaltycardServiceSoapBinding *)aBinding delegate:(id<LoyaltycardServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(LoyaltycardServiceSvc_getloyaltyCardIds *)aParameters
;
@end
@interface LoyaltycardServiceSoapBinding_getissuedLoyaltycard : LoyaltycardServiceSoapBindingOperation {
    LoyaltycardServiceSvc_getissuedLoyaltycard * parameters;
}
@property (strong) LoyaltycardServiceSvc_getissuedLoyaltycard * parameters;
- (id)initWithBinding:(LoyaltycardServiceSoapBinding *)aBinding delegate:(id<LoyaltycardServiceSoapBindingResponseDelegate>)aDelegate
           parameters:(LoyaltycardServiceSvc_getissuedLoyaltycard *)aParameters
;
@end
@interface LoyaltycardServiceSoapBinding_envelope : NSObject {
}
+ (LoyaltycardServiceSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface LoyaltycardServiceSoapBindingResponse : NSObject {
    NSArray *headers;
    NSArray *bodyParts;
    NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end
