#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class WHStockReceiptService_createNewStockProcurementReceipt;
@class WHStockReceiptService_createNewStockProcurementReceiptResponse;
@class WHStockReceiptService_createStockReciept;
@class WHStockReceiptService_createStockRecieptResponse;
@class WHStockReceiptService_getStockProcurementReceipt;
@class WHStockReceiptService_getStockProcurementReceiptIds;
@class WHStockReceiptService_getStockProcurementReceiptIdsResponse;
@class WHStockReceiptService_getStockProcurementReceiptResponse;
@class WHStockReceiptService_getStockProcurementReceipts;
@class WHStockReceiptService_getStockProcurementReceiptsResponse;
@class WHStockReceiptService_getStockReceipt;
@class WHStockReceiptService_getStockReceiptIds;
@class WHStockReceiptService_getStockReceiptIdsResponse;
@class WHStockReceiptService_getStockReceiptResponse;
@class WHStockReceiptService_getStockReceipts;
@class WHStockReceiptService_getStockReceiptsResponse;
@class WHStockReceiptService_updateStockReciept;
@class WHStockReceiptService_updateStockRecieptResponse;
@interface WHStockReceiptService_createNewStockProcurementReceipt : NSObject {
	
/* elements */
	NSString * procurement_details;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHStockReceiptService_createNewStockProcurementReceipt *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * procurement_details;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHStockReceiptService_createNewStockProcurementReceiptResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHStockReceiptService_createNewStockProcurementReceiptResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHStockReceiptService_createStockReciept : NSObject {
	
/* elements */
	NSString * stockRecieptDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHStockReceiptService_createStockReciept *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * stockRecieptDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHStockReceiptService_createStockRecieptResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHStockReceiptService_createStockRecieptResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHStockReceiptService_getStockProcurementReceipt : NSObject {
	
/* elements */
	NSString * receiptId;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHStockReceiptService_getStockProcurementReceipt *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * receiptId;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHStockReceiptService_getStockProcurementReceiptIds : NSObject {
	
/* elements */
	NSString * searchCriteria;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHStockReceiptService_getStockProcurementReceiptIds *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * searchCriteria;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHStockReceiptService_getStockProcurementReceiptIdsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHStockReceiptService_getStockProcurementReceiptIdsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHStockReceiptService_getStockProcurementReceiptResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHStockReceiptService_getStockProcurementReceiptResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHStockReceiptService_getStockProcurementReceipts : NSObject {
	
/* elements */
	NSString * start;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHStockReceiptService_getStockProcurementReceipts *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * start;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHStockReceiptService_getStockProcurementReceiptsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHStockReceiptService_getStockProcurementReceiptsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHStockReceiptService_getStockReceipt : NSObject {
	
/* elements */
	NSString * receiptID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHStockReceiptService_getStockReceipt *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * receiptID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHStockReceiptService_getStockReceiptIds : NSObject {
	
/* elements */
	NSString * searchCriteria;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHStockReceiptService_getStockReceiptIds *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * searchCriteria;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHStockReceiptService_getStockReceiptIdsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHStockReceiptService_getStockReceiptIdsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHStockReceiptService_getStockReceiptResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHStockReceiptService_getStockReceiptResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHStockReceiptService_getStockReceipts : NSObject {
	
/* elements */
	NSString * searchCriteria;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHStockReceiptService_getStockReceipts *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * searchCriteria;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHStockReceiptService_getStockReceiptsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHStockReceiptService_getStockReceiptsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHStockReceiptService_updateStockReciept : NSObject {
	
/* elements */
	NSString * stockRecieptDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHStockReceiptService_updateStockReciept *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * stockRecieptDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface WHStockReceiptService_updateStockRecieptResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (WHStockReceiptService_updateStockRecieptResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "WHStockReceiptService.h"
@class WHStockReceiptServiceSoapBinding;
@interface WHStockReceiptService : NSObject {
	
}
+ (WHStockReceiptServiceSoapBinding *)WHStockReceiptServiceSoapBinding;
@end
@class WHStockReceiptServiceSoapBindingResponse;
@class WHStockReceiptServiceSoapBindingOperation;
@protocol WHStockReceiptServiceSoapBindingResponseDelegate <NSObject>
- (void) operation:(WHStockReceiptServiceSoapBindingOperation *)operation completedWithResponse:(WHStockReceiptServiceSoapBindingResponse *)response;
@end
@interface WHStockReceiptServiceSoapBinding : NSObject <WHStockReceiptServiceSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(WHStockReceiptServiceSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (WHStockReceiptServiceSoapBindingResponse *)createNewStockProcurementReceiptUsingParameters:(WHStockReceiptService_createNewStockProcurementReceipt *)aParameters ;
- (void)createNewStockProcurementReceiptAsyncUsingParameters:(WHStockReceiptService_createNewStockProcurementReceipt *)aParameters  delegate:(id<WHStockReceiptServiceSoapBindingResponseDelegate>)responseDelegate;
- (WHStockReceiptServiceSoapBindingResponse *)getStockReceiptIdsUsingParameters:(WHStockReceiptService_getStockReceiptIds *)aParameters ;
- (void)getStockReceiptIdsAsyncUsingParameters:(WHStockReceiptService_getStockReceiptIds *)aParameters  delegate:(id<WHStockReceiptServiceSoapBindingResponseDelegate>)responseDelegate;
- (WHStockReceiptServiceSoapBindingResponse *)getStockProcurementReceiptUsingParameters:(WHStockReceiptService_getStockProcurementReceipt *)aParameters ;
- (void)getStockProcurementReceiptAsyncUsingParameters:(WHStockReceiptService_getStockProcurementReceipt *)aParameters  delegate:(id<WHStockReceiptServiceSoapBindingResponseDelegate>)responseDelegate;
- (WHStockReceiptServiceSoapBindingResponse *)getStockProcurementReceiptsUsingParameters:(WHStockReceiptService_getStockProcurementReceipts *)aParameters ;
- (void)getStockProcurementReceiptsAsyncUsingParameters:(WHStockReceiptService_getStockProcurementReceipts *)aParameters  delegate:(id<WHStockReceiptServiceSoapBindingResponseDelegate>)responseDelegate;
- (WHStockReceiptServiceSoapBindingResponse *)updateStockRecieptUsingParameters:(WHStockReceiptService_updateStockReciept *)aParameters ;
- (void)updateStockRecieptAsyncUsingParameters:(WHStockReceiptService_updateStockReciept *)aParameters  delegate:(id<WHStockReceiptServiceSoapBindingResponseDelegate>)responseDelegate;
- (WHStockReceiptServiceSoapBindingResponse *)getStockReceiptsUsingParameters:(WHStockReceiptService_getStockReceipts *)aParameters ;
- (void)getStockReceiptsAsyncUsingParameters:(WHStockReceiptService_getStockReceipts *)aParameters  delegate:(id<WHStockReceiptServiceSoapBindingResponseDelegate>)responseDelegate;
- (WHStockReceiptServiceSoapBindingResponse *)createStockRecieptUsingParameters:(WHStockReceiptService_createStockReciept *)aParameters ;
- (void)createStockRecieptAsyncUsingParameters:(WHStockReceiptService_createStockReciept *)aParameters  delegate:(id<WHStockReceiptServiceSoapBindingResponseDelegate>)responseDelegate;
- (WHStockReceiptServiceSoapBindingResponse *)getStockProcurementReceiptIdsUsingParameters:(WHStockReceiptService_getStockProcurementReceiptIds *)aParameters ;
- (void)getStockProcurementReceiptIdsAsyncUsingParameters:(WHStockReceiptService_getStockProcurementReceiptIds *)aParameters  delegate:(id<WHStockReceiptServiceSoapBindingResponseDelegate>)responseDelegate;
- (WHStockReceiptServiceSoapBindingResponse *)getStockReceiptUsingParameters:(WHStockReceiptService_getStockReceipt *)aParameters ;
- (void)getStockReceiptAsyncUsingParameters:(WHStockReceiptService_getStockReceipt *)aParameters  delegate:(id<WHStockReceiptServiceSoapBindingResponseDelegate>)responseDelegate;
@end
@interface WHStockReceiptServiceSoapBindingOperation : NSOperation {
	WHStockReceiptServiceSoapBinding *binding;
	WHStockReceiptServiceSoapBindingResponse *response;
	id<WHStockReceiptServiceSoapBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) WHStockReceiptServiceSoapBinding *binding;
@property (readonly) WHStockReceiptServiceSoapBindingResponse *response;
@property (nonatomic, assign) id<WHStockReceiptServiceSoapBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(WHStockReceiptServiceSoapBinding *)aBinding delegate:(id<WHStockReceiptServiceSoapBindingResponseDelegate>)aDelegate;
@end
@interface WHStockReceiptServiceSoapBinding_createNewStockProcurementReceipt : WHStockReceiptServiceSoapBindingOperation {
	WHStockReceiptService_createNewStockProcurementReceipt * parameters;
}
@property (retain) WHStockReceiptService_createNewStockProcurementReceipt * parameters;
- (id)initWithBinding:(WHStockReceiptServiceSoapBinding *)aBinding delegate:(id<WHStockReceiptServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(WHStockReceiptService_createNewStockProcurementReceipt *)aParameters
;
@end
@interface WHStockReceiptServiceSoapBinding_getStockReceiptIds : WHStockReceiptServiceSoapBindingOperation {
	WHStockReceiptService_getStockReceiptIds * parameters;
}
@property (retain) WHStockReceiptService_getStockReceiptIds * parameters;
- (id)initWithBinding:(WHStockReceiptServiceSoapBinding *)aBinding delegate:(id<WHStockReceiptServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(WHStockReceiptService_getStockReceiptIds *)aParameters
;
@end
@interface WHStockReceiptServiceSoapBinding_getStockProcurementReceipt : WHStockReceiptServiceSoapBindingOperation {
	WHStockReceiptService_getStockProcurementReceipt * parameters;
}
@property (retain) WHStockReceiptService_getStockProcurementReceipt * parameters;
- (id)initWithBinding:(WHStockReceiptServiceSoapBinding *)aBinding delegate:(id<WHStockReceiptServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(WHStockReceiptService_getStockProcurementReceipt *)aParameters
;
@end
@interface WHStockReceiptServiceSoapBinding_getStockProcurementReceipts : WHStockReceiptServiceSoapBindingOperation {
	WHStockReceiptService_getStockProcurementReceipts * parameters;
}
@property (retain) WHStockReceiptService_getStockProcurementReceipts * parameters;
- (id)initWithBinding:(WHStockReceiptServiceSoapBinding *)aBinding delegate:(id<WHStockReceiptServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(WHStockReceiptService_getStockProcurementReceipts *)aParameters
;
@end
@interface WHStockReceiptServiceSoapBinding_updateStockReciept : WHStockReceiptServiceSoapBindingOperation {
	WHStockReceiptService_updateStockReciept * parameters;
}
@property (retain) WHStockReceiptService_updateStockReciept * parameters;
- (id)initWithBinding:(WHStockReceiptServiceSoapBinding *)aBinding delegate:(id<WHStockReceiptServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(WHStockReceiptService_updateStockReciept *)aParameters
;
@end
@interface WHStockReceiptServiceSoapBinding_getStockReceipts : WHStockReceiptServiceSoapBindingOperation {
	WHStockReceiptService_getStockReceipts * parameters;
}
@property (retain) WHStockReceiptService_getStockReceipts * parameters;
- (id)initWithBinding:(WHStockReceiptServiceSoapBinding *)aBinding delegate:(id<WHStockReceiptServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(WHStockReceiptService_getStockReceipts *)aParameters
;
@end
@interface WHStockReceiptServiceSoapBinding_createStockReciept : WHStockReceiptServiceSoapBindingOperation {
	WHStockReceiptService_createStockReciept * parameters;
}
@property (retain) WHStockReceiptService_createStockReciept * parameters;
- (id)initWithBinding:(WHStockReceiptServiceSoapBinding *)aBinding delegate:(id<WHStockReceiptServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(WHStockReceiptService_createStockReciept *)aParameters
;
@end
@interface WHStockReceiptServiceSoapBinding_getStockProcurementReceiptIds : WHStockReceiptServiceSoapBindingOperation {
	WHStockReceiptService_getStockProcurementReceiptIds * parameters;
}
@property (retain) WHStockReceiptService_getStockProcurementReceiptIds * parameters;
- (id)initWithBinding:(WHStockReceiptServiceSoapBinding *)aBinding delegate:(id<WHStockReceiptServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(WHStockReceiptService_getStockProcurementReceiptIds *)aParameters
;
@end
@interface WHStockReceiptServiceSoapBinding_getStockReceipt : WHStockReceiptServiceSoapBindingOperation {
	WHStockReceiptService_getStockReceipt * parameters;
}
@property (retain) WHStockReceiptService_getStockReceipt * parameters;
- (id)initWithBinding:(WHStockReceiptServiceSoapBinding *)aBinding delegate:(id<WHStockReceiptServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(WHStockReceiptService_getStockReceipt *)aParameters
;
@end
@interface WHStockReceiptServiceSoapBinding_envelope : NSObject {
}
+ (WHStockReceiptServiceSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface WHStockReceiptServiceSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
