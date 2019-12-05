#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class StockReceiptServiceSvc_createNewStockProcurementReceipt;
@class StockReceiptServiceSvc_createNewStockProcurementReceiptResponse;
@class StockReceiptServiceSvc_createStockReciept;
@class StockReceiptServiceSvc_createStockRecieptResponse;
@class StockReceiptServiceSvc_getStockProcurementReceipt;
@class StockReceiptServiceSvc_getStockProcurementReceiptIds;
@class StockReceiptServiceSvc_getStockProcurementReceiptIdsResponse;
@class StockReceiptServiceSvc_getStockProcurementReceiptResponse;
@class StockReceiptServiceSvc_getStockProcurementReceipts;
@class StockReceiptServiceSvc_getStockProcurementReceiptsResponse;
@class StockReceiptServiceSvc_getStockReceipt;
@class StockReceiptServiceSvc_getStockReceiptIds;
@class StockReceiptServiceSvc_getStockReceiptIdsResponse;
@class StockReceiptServiceSvc_getStockReceiptResponse;
@class StockReceiptServiceSvc_getStockReceipts;
@class StockReceiptServiceSvc_getStockReceiptsResponse;
@class StockReceiptServiceSvc_helloworld;
@class StockReceiptServiceSvc_helloworldResponse;
@class StockReceiptServiceSvc_updateStockReciept;
@class StockReceiptServiceSvc_updateStockRecieptResponse;
@interface StockReceiptServiceSvc_createNewStockProcurementReceipt : NSObject {
	
/* elements */
	NSString * procurement_details;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockReceiptServiceSvc_createNewStockProcurementReceipt *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * procurement_details;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockReceiptServiceSvc_createNewStockProcurementReceiptResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockReceiptServiceSvc_createNewStockProcurementReceiptResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockReceiptServiceSvc_createStockReciept : NSObject {
	
/* elements */
	NSString * stockRecieptDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockReceiptServiceSvc_createStockReciept *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * stockRecieptDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockReceiptServiceSvc_createStockRecieptResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockReceiptServiceSvc_createStockRecieptResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockReceiptServiceSvc_getStockProcurementReceipt : NSObject {
	
/* elements */
	NSString * receiptId;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockReceiptServiceSvc_getStockProcurementReceipt *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * receiptId;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockReceiptServiceSvc_getStockProcurementReceiptIds : NSObject {
	
/* elements */
	NSString * searchCriteria;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockReceiptServiceSvc_getStockProcurementReceiptIds *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * searchCriteria;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockReceiptServiceSvc_getStockProcurementReceiptIdsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockReceiptServiceSvc_getStockProcurementReceiptIdsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockReceiptServiceSvc_getStockProcurementReceiptResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockReceiptServiceSvc_getStockProcurementReceiptResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockReceiptServiceSvc_getStockProcurementReceipts : NSObject {
	
/* elements */
	NSString * start;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockReceiptServiceSvc_getStockProcurementReceipts *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * start;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockReceiptServiceSvc_getStockProcurementReceiptsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockReceiptServiceSvc_getStockProcurementReceiptsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockReceiptServiceSvc_getStockReceipt : NSObject {
	
/* elements */
	NSString * receiptID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockReceiptServiceSvc_getStockReceipt *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * receiptID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockReceiptServiceSvc_getStockReceiptIds : NSObject {
	
/* elements */
	NSString * searchCriteria;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockReceiptServiceSvc_getStockReceiptIds *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * searchCriteria;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockReceiptServiceSvc_getStockReceiptIdsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockReceiptServiceSvc_getStockReceiptIdsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockReceiptServiceSvc_getStockReceiptResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockReceiptServiceSvc_getStockReceiptResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockReceiptServiceSvc_getStockReceipts : NSObject {
	
/* elements */
	NSString * searchCriteria;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockReceiptServiceSvc_getStockReceipts *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * searchCriteria;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockReceiptServiceSvc_getStockReceiptsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockReceiptServiceSvc_getStockReceiptsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockReceiptServiceSvc_helloworld : NSObject {
	
/* elements */
	NSString * testString;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockReceiptServiceSvc_helloworld *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * testString;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockReceiptServiceSvc_helloworldResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockReceiptServiceSvc_helloworldResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockReceiptServiceSvc_updateStockReciept : NSObject {
	
/* elements */
	NSString * stockRecieptDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockReceiptServiceSvc_updateStockReciept *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * stockRecieptDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface StockReceiptServiceSvc_updateStockRecieptResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (StockReceiptServiceSvc_updateStockRecieptResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "StockReceiptServiceSvc.h"
@class StockReceiptServiceSoapBinding;
@interface StockReceiptServiceSvc : NSObject {
	
}
+ (StockReceiptServiceSoapBinding *)StockReceiptServiceSoapBinding;
@end
@class StockReceiptServiceSoapBindingResponse;
@class StockReceiptServiceSoapBindingOperation;
@protocol StockReceiptServiceSoapBindingResponseDelegate <NSObject>
- (void) operation:(StockReceiptServiceSoapBindingOperation *)operation completedWithResponse:(StockReceiptServiceSoapBindingResponse *)response;
@end
@interface StockReceiptServiceSoapBinding : NSObject <StockReceiptServiceSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(StockReceiptServiceSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (StockReceiptServiceSoapBindingResponse *)createNewStockProcurementReceiptUsingParameters:(StockReceiptServiceSvc_createNewStockProcurementReceipt *)aParameters ;
- (void)createNewStockProcurementReceiptAsyncUsingParameters:(StockReceiptServiceSvc_createNewStockProcurementReceipt *)aParameters  delegate:(id<StockReceiptServiceSoapBindingResponseDelegate>)responseDelegate;
- (StockReceiptServiceSoapBindingResponse *)getStockReceiptIdsUsingParameters:(StockReceiptServiceSvc_getStockReceiptIds *)aParameters ;
- (void)getStockReceiptIdsAsyncUsingParameters:(StockReceiptServiceSvc_getStockReceiptIds *)aParameters  delegate:(id<StockReceiptServiceSoapBindingResponseDelegate>)responseDelegate;
- (StockReceiptServiceSoapBindingResponse *)getStockProcurementReceiptUsingParameters:(StockReceiptServiceSvc_getStockProcurementReceipt *)aParameters ;
- (void)getStockProcurementReceiptAsyncUsingParameters:(StockReceiptServiceSvc_getStockProcurementReceipt *)aParameters  delegate:(id<StockReceiptServiceSoapBindingResponseDelegate>)responseDelegate;
- (StockReceiptServiceSoapBindingResponse *)getStockProcurementReceiptsUsingParameters:(StockReceiptServiceSvc_getStockProcurementReceipts *)aParameters ;
- (void)getStockProcurementReceiptsAsyncUsingParameters:(StockReceiptServiceSvc_getStockProcurementReceipts *)aParameters  delegate:(id<StockReceiptServiceSoapBindingResponseDelegate>)responseDelegate;
- (StockReceiptServiceSoapBindingResponse *)updateStockRecieptUsingParameters:(StockReceiptServiceSvc_updateStockReciept *)aParameters ;
- (void)updateStockRecieptAsyncUsingParameters:(StockReceiptServiceSvc_updateStockReciept *)aParameters  delegate:(id<StockReceiptServiceSoapBindingResponseDelegate>)responseDelegate;
- (StockReceiptServiceSoapBindingResponse *)getStockReceiptsUsingParameters:(StockReceiptServiceSvc_getStockReceipts *)aParameters ;
- (void)getStockReceiptsAsyncUsingParameters:(StockReceiptServiceSvc_getStockReceipts *)aParameters  delegate:(id<StockReceiptServiceSoapBindingResponseDelegate>)responseDelegate;
- (StockReceiptServiceSoapBindingResponse *)createStockRecieptUsingParameters:(StockReceiptServiceSvc_createStockReciept *)aParameters ;
- (void)createStockRecieptAsyncUsingParameters:(StockReceiptServiceSvc_createStockReciept *)aParameters  delegate:(id<StockReceiptServiceSoapBindingResponseDelegate>)responseDelegate;
- (StockReceiptServiceSoapBindingResponse *)helloworldUsingParameters:(StockReceiptServiceSvc_helloworld *)aParameters ;
- (void)helloworldAsyncUsingParameters:(StockReceiptServiceSvc_helloworld *)aParameters  delegate:(id<StockReceiptServiceSoapBindingResponseDelegate>)responseDelegate;
- (StockReceiptServiceSoapBindingResponse *)getStockProcurementReceiptIdsUsingParameters:(StockReceiptServiceSvc_getStockProcurementReceiptIds *)aParameters ;
- (void)getStockProcurementReceiptIdsAsyncUsingParameters:(StockReceiptServiceSvc_getStockProcurementReceiptIds *)aParameters  delegate:(id<StockReceiptServiceSoapBindingResponseDelegate>)responseDelegate;
- (StockReceiptServiceSoapBindingResponse *)getStockReceiptUsingParameters:(StockReceiptServiceSvc_getStockReceipt *)aParameters ;
- (void)getStockReceiptAsyncUsingParameters:(StockReceiptServiceSvc_getStockReceipt *)aParameters  delegate:(id<StockReceiptServiceSoapBindingResponseDelegate>)responseDelegate;
@end
@interface StockReceiptServiceSoapBindingOperation : NSOperation {
	StockReceiptServiceSoapBinding *binding;
	StockReceiptServiceSoapBindingResponse * response;
	id<StockReceiptServiceSoapBindingResponseDelegate>  delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (strong) StockReceiptServiceSoapBinding *binding;
@property (  readonly) StockReceiptServiceSoapBindingResponse *response;
@property (nonatomic ) id<StockReceiptServiceSoapBindingResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(StockReceiptServiceSoapBinding *)aBinding delegate:(id<StockReceiptServiceSoapBindingResponseDelegate>)aDelegate;
@end
@interface StockReceiptServiceSoapBinding_createNewStockProcurementReceipt : StockReceiptServiceSoapBindingOperation {
	StockReceiptServiceSvc_createNewStockProcurementReceipt * parameters;
}
@property (strong) StockReceiptServiceSvc_createNewStockProcurementReceipt * parameters;
- (id)initWithBinding:(StockReceiptServiceSoapBinding *)aBinding delegate:(id<StockReceiptServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(StockReceiptServiceSvc_createNewStockProcurementReceipt *)aParameters
;
@end
@interface StockReceiptServiceSoapBinding_getStockReceiptIds : StockReceiptServiceSoapBindingOperation {
	StockReceiptServiceSvc_getStockReceiptIds * parameters;
}
@property (strong) StockReceiptServiceSvc_getStockReceiptIds * parameters;
- (id)initWithBinding:(StockReceiptServiceSoapBinding *)aBinding delegate:(id<StockReceiptServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(StockReceiptServiceSvc_getStockReceiptIds *)aParameters
;
@end
@interface StockReceiptServiceSoapBinding_getStockProcurementReceipt : StockReceiptServiceSoapBindingOperation {
	StockReceiptServiceSvc_getStockProcurementReceipt * parameters;
}
@property (strong) StockReceiptServiceSvc_getStockProcurementReceipt * parameters;
- (id)initWithBinding:(StockReceiptServiceSoapBinding *)aBinding delegate:(id<StockReceiptServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(StockReceiptServiceSvc_getStockProcurementReceipt *)aParameters
;
@end
@interface StockReceiptServiceSoapBinding_getStockProcurementReceipts : StockReceiptServiceSoapBindingOperation {
	StockReceiptServiceSvc_getStockProcurementReceipts * parameters;
}
@property (strong) StockReceiptServiceSvc_getStockProcurementReceipts * parameters;
- (id)initWithBinding:(StockReceiptServiceSoapBinding *)aBinding delegate:(id<StockReceiptServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(StockReceiptServiceSvc_getStockProcurementReceipts *)aParameters
;
@end
@interface StockReceiptServiceSoapBinding_updateStockReciept : StockReceiptServiceSoapBindingOperation {
	StockReceiptServiceSvc_updateStockReciept * parameters;
}
@property (strong) StockReceiptServiceSvc_updateStockReciept * parameters;
- (id)initWithBinding:(StockReceiptServiceSoapBinding *)aBinding delegate:(id<StockReceiptServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(StockReceiptServiceSvc_updateStockReciept *)aParameters
;
@end
@interface StockReceiptServiceSoapBinding_getStockReceipts : StockReceiptServiceSoapBindingOperation {
	StockReceiptServiceSvc_getStockReceipts * parameters;
}
@property (strong) StockReceiptServiceSvc_getStockReceipts * parameters;
- (id)initWithBinding:(StockReceiptServiceSoapBinding *)aBinding delegate:(id<StockReceiptServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(StockReceiptServiceSvc_getStockReceipts *)aParameters
;
@end
@interface StockReceiptServiceSoapBinding_createStockReciept : StockReceiptServiceSoapBindingOperation {
	StockReceiptServiceSvc_createStockReciept * parameters;
}
@property (strong) StockReceiptServiceSvc_createStockReciept * parameters;
- (id)initWithBinding:(StockReceiptServiceSoapBinding *)aBinding delegate:(id<StockReceiptServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(StockReceiptServiceSvc_createStockReciept *)aParameters
;
@end
@interface StockReceiptServiceSoapBinding_helloworld : StockReceiptServiceSoapBindingOperation {
	StockReceiptServiceSvc_helloworld * parameters;
}
@property (strong) StockReceiptServiceSvc_helloworld * parameters;
- (id)initWithBinding:(StockReceiptServiceSoapBinding *)aBinding delegate:(id<StockReceiptServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(StockReceiptServiceSvc_helloworld *)aParameters
;
@end
@interface StockReceiptServiceSoapBinding_getStockProcurementReceiptIds : StockReceiptServiceSoapBindingOperation {
	StockReceiptServiceSvc_getStockProcurementReceiptIds * parameters;
}
@property (strong) StockReceiptServiceSvc_getStockProcurementReceiptIds * parameters;
- (id)initWithBinding:(StockReceiptServiceSoapBinding *)aBinding delegate:(id<StockReceiptServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(StockReceiptServiceSvc_getStockProcurementReceiptIds *)aParameters
;
@end
@interface StockReceiptServiceSoapBinding_getStockReceipt : StockReceiptServiceSoapBindingOperation {
	StockReceiptServiceSvc_getStockReceipt * parameters;
}
@property (strong) StockReceiptServiceSvc_getStockReceipt * parameters;
- (id)initWithBinding:(StockReceiptServiceSoapBinding *)aBinding delegate:(id<StockReceiptServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(StockReceiptServiceSvc_getStockReceipt *)aParameters
;
@end
@interface StockReceiptServiceSoapBinding_envelope : NSObject {
}
+ (StockReceiptServiceSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface StockReceiptServiceSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end
