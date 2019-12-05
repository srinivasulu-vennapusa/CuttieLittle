#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class StoreServiceSvc_createLayout;
@class StoreServiceSvc_createLayoutResponse;
@class StoreServiceSvc_createOutletSettings;
@class StoreServiceSvc_createOutletSettingsResponse;
@class StoreServiceSvc_createStore;
@class StoreServiceSvc_createStoreResponse;
@class StoreServiceSvc_editLayout;
@class StoreServiceSvc_editLayoutResponse;
@class StoreServiceSvc_getAllLayoutTables;
@class StoreServiceSvc_getAllLayoutTablesResponse;
@class StoreServiceSvc_getAvailableLevels;
@class StoreServiceSvc_getAvailableLevelsResponse;
@class StoreServiceSvc_getBillingCounters;
@class StoreServiceSvc_getBillingCountersResponse;
@class StoreServiceSvc_getLayout;
@class StoreServiceSvc_getLayoutResponse;
@class StoreServiceSvc_getStores;
@class StoreServiceSvc_getStoresResponse;
@class StoreServiceSvc_updateStore;
@class StoreServiceSvc_updateStoreResponse;
@interface StoreServiceSvc_createLayout : NSObject {
	
/* elements */
	NSString * layoutDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StoreServiceSvc_createLayout *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * layoutDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StoreServiceSvc_createLayoutResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StoreServiceSvc_createLayoutResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StoreServiceSvc_createOutletSettings : NSObject {
	
/* elements */
	NSString * outletSettings;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StoreServiceSvc_createOutletSettings *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * outletSettings;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StoreServiceSvc_createOutletSettingsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StoreServiceSvc_createOutletSettingsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StoreServiceSvc_createStore : NSObject {
	
/* elements */
	NSString * storeDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StoreServiceSvc_createStore *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * storeDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StoreServiceSvc_createStoreResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StoreServiceSvc_createStoreResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StoreServiceSvc_editLayout : NSObject {
	
/* elements */
	NSString * layoutDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StoreServiceSvc_editLayout *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * layoutDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StoreServiceSvc_editLayoutResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StoreServiceSvc_editLayoutResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StoreServiceSvc_getAllLayoutTables : NSObject {
	
/* elements */
	NSString * layoutDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StoreServiceSvc_getAllLayoutTables *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * layoutDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StoreServiceSvc_getAllLayoutTablesResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StoreServiceSvc_getAllLayoutTablesResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StoreServiceSvc_getAvailableLevels : NSObject {
	
/* elements */
	NSString * levelInfo;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StoreServiceSvc_getAvailableLevels *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * levelInfo;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StoreServiceSvc_getAvailableLevelsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StoreServiceSvc_getAvailableLevelsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StoreServiceSvc_getBillingCounters : NSObject {
	
/* elements */
	NSString * counterdetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StoreServiceSvc_getBillingCounters *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * counterdetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StoreServiceSvc_getBillingCountersResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StoreServiceSvc_getBillingCountersResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StoreServiceSvc_getLayout : NSObject {
	
/* elements */
	NSString * layoutDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StoreServiceSvc_getLayout *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * layoutDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StoreServiceSvc_getLayoutResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StoreServiceSvc_getLayoutResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StoreServiceSvc_getStores : NSObject {
	
/* elements */
	NSString * layoutDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StoreServiceSvc_getStores *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * layoutDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StoreServiceSvc_getStoresResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StoreServiceSvc_getStoresResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StoreServiceSvc_updateStore : NSObject {
	
/* elements */
	NSString * layoutDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StoreServiceSvc_updateStore *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * layoutDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StoreServiceSvc_updateStoreResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StoreServiceSvc_updateStoreResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "StoreServiceSvc.h"
@class StoreServiceSoapBinding;
@interface StoreServiceSvc : NSObject {
	
}
+ (StoreServiceSoapBinding *)StoreServiceSoapBinding;
@end
@class StoreServiceSoapBindingResponse;
@class StoreServiceSoapBindingOperation;
@protocol StoreServiceSoapBindingResponseDelegate <NSObject>
- (void) operation:(StoreServiceSoapBindingOperation *)operation completedWithResponse:(StoreServiceSoapBindingResponse *)response;
@end
@interface StoreServiceSoapBinding : NSObject <StoreServiceSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(StoreServiceSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (StoreServiceSoapBindingResponse *)createLayoutUsingParameters:(StoreServiceSvc_createLayout *)aParameters ;
- (void)createLayoutAsyncUsingParameters:(StoreServiceSvc_createLayout *)aParameters  delegate:(id<StoreServiceSoapBindingResponseDelegate>)responseDelegate;
- (StoreServiceSoapBindingResponse *)createStoreUsingParameters:(StoreServiceSvc_createStore *)aParameters ;
- (void)createStoreAsyncUsingParameters:(StoreServiceSvc_createStore *)aParameters  delegate:(id<StoreServiceSoapBindingResponseDelegate>)responseDelegate;
- (StoreServiceSoapBindingResponse *)getBillingCountersUsingParameters:(StoreServiceSvc_getBillingCounters *)aParameters ;
- (void)getBillingCountersAsyncUsingParameters:(StoreServiceSvc_getBillingCounters *)aParameters  delegate:(id<StoreServiceSoapBindingResponseDelegate>)responseDelegate;
- (StoreServiceSoapBindingResponse *)createOutletSettingsUsingParameters:(StoreServiceSvc_createOutletSettings *)aParameters ;
- (void)createOutletSettingsAsyncUsingParameters:(StoreServiceSvc_createOutletSettings *)aParameters  delegate:(id<StoreServiceSoapBindingResponseDelegate>)responseDelegate;
- (StoreServiceSoapBindingResponse *)getAvailableLevelsUsingParameters:(StoreServiceSvc_getAvailableLevels *)aParameters ;
- (void)getAvailableLevelsAsyncUsingParameters:(StoreServiceSvc_getAvailableLevels *)aParameters  delegate:(id<StoreServiceSoapBindingResponseDelegate>)responseDelegate;
- (StoreServiceSoapBindingResponse *)getLayoutUsingParameters:(StoreServiceSvc_getLayout *)aParameters ;
- (void)getLayoutAsyncUsingParameters:(StoreServiceSvc_getLayout *)aParameters  delegate:(id<StoreServiceSoapBindingResponseDelegate>)responseDelegate;
- (StoreServiceSoapBindingResponse *)getStoresUsingParameters:(StoreServiceSvc_getStores *)aParameters ;
- (void)getStoresAsyncUsingParameters:(StoreServiceSvc_getStores *)aParameters  delegate:(id<StoreServiceSoapBindingResponseDelegate>)responseDelegate;
- (StoreServiceSoapBindingResponse *)updateStoreUsingParameters:(StoreServiceSvc_updateStore *)aParameters ;
- (void)updateStoreAsyncUsingParameters:(StoreServiceSvc_updateStore *)aParameters  delegate:(id<StoreServiceSoapBindingResponseDelegate>)responseDelegate;
- (StoreServiceSoapBindingResponse *)getAllLayoutTablesUsingParameters:(StoreServiceSvc_getAllLayoutTables *)aParameters ;
- (void)getAllLayoutTablesAsyncUsingParameters:(StoreServiceSvc_getAllLayoutTables *)aParameters  delegate:(id<StoreServiceSoapBindingResponseDelegate>)responseDelegate;
- (StoreServiceSoapBindingResponse *)editLayoutUsingParameters:(StoreServiceSvc_editLayout *)aParameters ;
- (void)editLayoutAsyncUsingParameters:(StoreServiceSvc_editLayout *)aParameters  delegate:(id<StoreServiceSoapBindingResponseDelegate>)responseDelegate;
@end


@interface StoreServiceSoapBindingOperation : NSOperation {
	StoreServiceSoapBinding *binding;
	StoreServiceSoapBindingResponse * response;
	id<StoreServiceSoapBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) StoreServiceSoapBinding *binding;
@property (readonly) StoreServiceSoapBindingResponse *response;
@property (nonatomic) id<StoreServiceSoapBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(StoreServiceSoapBinding *)aBinding delegate:(id<StoreServiceSoapBindingResponseDelegate>)aDelegate;
@end
@interface StoreServiceSoapBinding_createLayout : StoreServiceSoapBindingOperation {
	StoreServiceSvc_createLayout * parameters;
}
@property (retain) StoreServiceSvc_createLayout * parameters;
- (id)initWithBinding:(StoreServiceSoapBinding *)aBinding delegate:(id<StoreServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(StoreServiceSvc_createLayout *)aParameters
;
@end
@interface StoreServiceSoapBinding_createStore : StoreServiceSoapBindingOperation {
	StoreServiceSvc_createStore * parameters;
}
@property (retain) StoreServiceSvc_createStore * parameters;
- (id)initWithBinding:(StoreServiceSoapBinding *)aBinding delegate:(id<StoreServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(StoreServiceSvc_createStore *)aParameters
;
@end
@interface StoreServiceSoapBinding_getBillingCounters : StoreServiceSoapBindingOperation {
	StoreServiceSvc_getBillingCounters * parameters;
}
@property (retain) StoreServiceSvc_getBillingCounters * parameters;
- (id)initWithBinding:(StoreServiceSoapBinding *)aBinding delegate:(id<StoreServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(StoreServiceSvc_getBillingCounters *)aParameters
;
@end
@interface StoreServiceSoapBinding_createOutletSettings : StoreServiceSoapBindingOperation {
	StoreServiceSvc_createOutletSettings * parameters;
}
@property (retain) StoreServiceSvc_createOutletSettings * parameters;
- (id)initWithBinding:(StoreServiceSoapBinding *)aBinding delegate:(id<StoreServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(StoreServiceSvc_createOutletSettings *)aParameters
;
@end
@interface StoreServiceSoapBinding_getAvailableLevels : StoreServiceSoapBindingOperation {
	StoreServiceSvc_getAvailableLevels * parameters;
}
@property (retain) StoreServiceSvc_getAvailableLevels * parameters;
- (id)initWithBinding:(StoreServiceSoapBinding *)aBinding delegate:(id<StoreServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(StoreServiceSvc_getAvailableLevels *)aParameters
;
@end
@interface StoreServiceSoapBinding_getLayout : StoreServiceSoapBindingOperation {
	StoreServiceSvc_getLayout * parameters;
}
@property (retain) StoreServiceSvc_getLayout * parameters;
- (id)initWithBinding:(StoreServiceSoapBinding *)aBinding delegate:(id<StoreServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(StoreServiceSvc_getLayout *)aParameters
;
@end
@interface StoreServiceSoapBinding_getStores : StoreServiceSoapBindingOperation {
	StoreServiceSvc_getStores * parameters;
}
@property (retain) StoreServiceSvc_getStores * parameters;
- (id)initWithBinding:(StoreServiceSoapBinding *)aBinding delegate:(id<StoreServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(StoreServiceSvc_getStores *)aParameters
;
@end
@interface StoreServiceSoapBinding_updateStore : StoreServiceSoapBindingOperation {
	StoreServiceSvc_updateStore * parameters;
}
@property (retain) StoreServiceSvc_updateStore * parameters;
- (id)initWithBinding:(StoreServiceSoapBinding *)aBinding delegate:(id<StoreServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(StoreServiceSvc_updateStore *)aParameters
;
@end
@interface StoreServiceSoapBinding_getAllLayoutTables : StoreServiceSoapBindingOperation {
	StoreServiceSvc_getAllLayoutTables * parameters;
}
@property (retain) StoreServiceSvc_getAllLayoutTables * parameters;
- (id)initWithBinding:(StoreServiceSoapBinding *)aBinding delegate:(id<StoreServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(StoreServiceSvc_getAllLayoutTables *)aParameters
;
@end
@interface StoreServiceSoapBinding_editLayout : StoreServiceSoapBindingOperation {
	StoreServiceSvc_editLayout * parameters;
}
@property (retain) StoreServiceSvc_editLayout * parameters;
- (id)initWithBinding:(StoreServiceSoapBinding *)aBinding delegate:(id<StoreServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(StoreServiceSvc_editLayout *)aParameters
;
@end
@interface StoreServiceSoapBinding_envelope : NSObject {
}
+ (StoreServiceSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface StoreServiceSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
