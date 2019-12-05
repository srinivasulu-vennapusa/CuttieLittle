#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class SalesServiceSvc_createBilling;
@class SalesServiceSvc_createBillingResponse;
@class SalesServiceSvc_updateBilling;
@class SalesServiceSvc_updateBillingResponse;
@class SalesServiceSvc_getBillingDetails;
@class SalesServiceSvc_getBillingDetailsResponse;
@class SalesServiceSvc_getAvailableStock;
@class SalesServiceSvc_getAvailableStockResponse;
@class SalesServiceSvc_getStockDetailsByStockType;
@class SalesServiceSvc_getStockDetailsByStockTypeResponse;
@class SalesServiceSvc_getSalesReport;
@class SalesServiceSvc_getSalesReportResponse;
@class SalesServiceSvc_getExistedSaleID;
@class SalesServiceSvc_getExistedSaleIDResponse;
@class SalesServiceSvc_searchSalesReportWithPagination;
@class SalesServiceSvc_searchSalesReportWithPaginationResponse;
@class SalesServiceSvc_searchStockWithPagination;
@class SalesServiceSvc_searchStockWithPaginationResponse;
@class SalesServiceSvc_returningItem;
@class SalesServiceSvc_returningItemResponse;
@class SalesServiceSvc_exchangingItem;
@class SalesServiceSvc_exchangingItemResponse;
@interface SalesServiceSvc_createBilling : NSObject {
	
/* elements */
	NSString * bill_details;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_createBilling *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * bill_details;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_createBillingResponse : NSObject {
	
/* elements */
	NSString * createBillingReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_createBillingResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * createBillingReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_updateBilling : NSObject {
	
/* elements */
	NSString * bill_details;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_updateBilling *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * bill_details;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_updateBillingResponse : NSObject {
	
/* elements */
	NSString * updateBillingReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_updateBillingResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * updateBillingReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getBillingDetails : NSObject {
	
/* elements */
	NSString * saleID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_getBillingDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * saleID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getBillingDetailsResponse : NSObject {
	
/* elements */
	NSString * getBillingDetailsReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_getBillingDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * getBillingDetailsReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getAvailableStock : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_getAvailableStock *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getAvailableStockResponse : NSObject {
	
/* elements */
	NSString * getAvailableStockReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_getAvailableStockResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * getAvailableStockReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getStockDetailsByStockType : NSObject {
	
/* elements */
	NSString * stockType;
	NSString * pageNumber;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_getStockDetailsByStockType *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * stockType;
@property (retain) NSString * pageNumber;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getStockDetailsByStockTypeResponse : NSObject {
	
/* elements */
	NSString * getStockDetailsByStockTypeReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_getStockDetailsByStockTypeResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * getStockDetailsByStockTypeReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getSalesReport : NSObject {
	
/* elements */
	NSString * reportByDate;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_getSalesReport *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * reportByDate;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getSalesReportResponse : NSObject {
	
/* elements */
	NSString * getSalesReportReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_getSalesReportResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * getSalesReportReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getExistedSaleID : NSObject {
	
/* elements */
	NSString * saleID;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_getExistedSaleID *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * saleID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getExistedSaleIDResponse : NSObject {
	
/* elements */
	NSString * getExistedSaleIDReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_getExistedSaleIDResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * getExistedSaleIDReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_searchSalesReportWithPagination : NSObject {
	
/* elements */
	NSString * jsonSearchCriteria;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_searchSalesReportWithPagination *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * jsonSearchCriteria;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_searchSalesReportWithPaginationResponse : NSObject {
	
/* elements */
	NSString * searchSalesReportWithPaginationReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_searchSalesReportWithPaginationResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * searchSalesReportWithPaginationReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_searchStockWithPagination : NSObject {
	
/* elements */
	NSString * stockType;
	NSString * searchCriteria;
	NSString * pageNumber;
	NSString * dropDown;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_searchStockWithPagination *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * stockType;
@property (retain) NSString * searchCriteria;
@property (retain) NSString * pageNumber;
@property (retain) NSString * dropDown;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_searchStockWithPaginationResponse : NSObject {
	
/* elements */
	NSString * searchStockWithPaginationReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_searchStockWithPaginationResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * searchStockWithPaginationReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_returningItem : NSObject {
	
/* elements */
	NSString * returning_item_details;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_returningItem *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * returning_item_details;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_returningItemResponse : NSObject {
	
/* elements */
	NSString * returningItemReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_returningItemResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * returningItemReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_exchangingItem : NSObject {
	
/* elements */
	NSString * exchanging_item_details;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_exchangingItem *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * exchanging_item_details;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_exchangingItemResponse : NSObject {
	
/* elements */
	NSString * exchangingItemReturn;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_exchangingItemResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * exchangingItemReturn;
/* attributes */
- (NSDictionary *)attributes;
@end
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "ns1.h"
#import "SalesServiceSvc.h"
@class SalesSoapBinding;
@interface SalesServiceSvc : NSObject {
	
}
+ (SalesSoapBinding *)SalesSoapBinding;
@end
@class SalesSoapBindingResponse;
@class SalesSoapBindingOperation;
@protocol SalesSoapBindingResponseDelegate <NSObject>
- (void) operation:(SalesSoapBindingOperation *)operation completedWithResponse:(SalesSoapBindingResponse *)response;
@end
@interface SalesSoapBinding : NSObject <SalesSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(SalesSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (SalesSoapBindingResponse *)createBillingUsingParameters:(SalesServiceSvc_createBilling *)aParameters ;
- (void)createBillingAsyncUsingParameters:(SalesServiceSvc_createBilling *)aParameters  delegate:(id<SalesSoapBindingResponseDelegate>)responseDelegate;
- (SalesSoapBindingResponse *)updateBillingUsingParameters:(SalesServiceSvc_updateBilling *)aParameters ;
- (void)updateBillingAsyncUsingParameters:(SalesServiceSvc_updateBilling *)aParameters  delegate:(id<SalesSoapBindingResponseDelegate>)responseDelegate;
- (SalesSoapBindingResponse *)getBillingDetailsUsingParameters:(SalesServiceSvc_getBillingDetails *)aParameters ;
- (void)getBillingDetailsAsyncUsingParameters:(SalesServiceSvc_getBillingDetails *)aParameters  delegate:(id<SalesSoapBindingResponseDelegate>)responseDelegate;
- (SalesSoapBindingResponse *)getAvailableStockUsingParameters:(SalesServiceSvc_getAvailableStock *)aParameters ;
- (void)getAvailableStockAsyncUsingParameters:(SalesServiceSvc_getAvailableStock *)aParameters  delegate:(id<SalesSoapBindingResponseDelegate>)responseDelegate;
- (SalesSoapBindingResponse *)getStockDetailsByStockTypeUsingParameters:(SalesServiceSvc_getStockDetailsByStockType *)aParameters ;
- (void)getStockDetailsByStockTypeAsyncUsingParameters:(SalesServiceSvc_getStockDetailsByStockType *)aParameters  delegate:(id<SalesSoapBindingResponseDelegate>)responseDelegate;
- (SalesSoapBindingResponse *)getSalesReportUsingParameters:(SalesServiceSvc_getSalesReport *)aParameters ;
- (void)getSalesReportAsyncUsingParameters:(SalesServiceSvc_getSalesReport *)aParameters  delegate:(id<SalesSoapBindingResponseDelegate>)responseDelegate;
- (SalesSoapBindingResponse *)getExistedSaleIDUsingParameters:(SalesServiceSvc_getExistedSaleID *)aParameters ;
- (void)getExistedSaleIDAsyncUsingParameters:(SalesServiceSvc_getExistedSaleID *)aParameters  delegate:(id<SalesSoapBindingResponseDelegate>)responseDelegate;
- (SalesSoapBindingResponse *)searchSalesReportWithPaginationUsingParameters:(SalesServiceSvc_searchSalesReportWithPagination *)aParameters ;
- (void)searchSalesReportWithPaginationAsyncUsingParameters:(SalesServiceSvc_searchSalesReportWithPagination *)aParameters  delegate:(id<SalesSoapBindingResponseDelegate>)responseDelegate;
- (SalesSoapBindingResponse *)searchStockWithPaginationUsingParameters:(SalesServiceSvc_searchStockWithPagination *)aParameters ;
- (void)searchStockWithPaginationAsyncUsingParameters:(SalesServiceSvc_searchStockWithPagination *)aParameters  delegate:(id<SalesSoapBindingResponseDelegate>)responseDelegate;
- (SalesSoapBindingResponse *)returningItemUsingParameters:(SalesServiceSvc_returningItem *)aParameters ;
- (void)returningItemAsyncUsingParameters:(SalesServiceSvc_returningItem *)aParameters  delegate:(id<SalesSoapBindingResponseDelegate>)responseDelegate;
- (SalesSoapBindingResponse *)exchangingItemUsingParameters:(SalesServiceSvc_exchangingItem *)aParameters ;
- (void)exchangingItemAsyncUsingParameters:(SalesServiceSvc_exchangingItem *)aParameters  delegate:(id<SalesSoapBindingResponseDelegate>)responseDelegate;
@end
@interface SalesSoapBindingOperation : NSOperation {
	SalesSoapBinding *binding;
	SalesSoapBindingResponse *response;
	id<SalesSoapBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) SalesSoapBinding *binding;
@property (readonly) SalesSoapBindingResponse *response;
@property (nonatomic, assign) id<SalesSoapBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(SalesSoapBinding *)aBinding delegate:(id<SalesSoapBindingResponseDelegate>)aDelegate;
@end
@interface SalesSoapBinding_createBilling : SalesSoapBindingOperation {
	SalesServiceSvc_createBilling * parameters;
}
@property (retain) SalesServiceSvc_createBilling * parameters;
- (id)initWithBinding:(SalesSoapBinding *)aBinding delegate:(id<SalesSoapBindingResponseDelegate>)aDelegate
	parameters:(SalesServiceSvc_createBilling *)aParameters
;
@end
@interface SalesSoapBinding_updateBilling : SalesSoapBindingOperation {
	SalesServiceSvc_updateBilling * parameters;
}
@property (retain) SalesServiceSvc_updateBilling * parameters;
- (id)initWithBinding:(SalesSoapBinding *)aBinding delegate:(id<SalesSoapBindingResponseDelegate>)aDelegate
	parameters:(SalesServiceSvc_updateBilling *)aParameters
;
@end
@interface SalesSoapBinding_getBillingDetails : SalesSoapBindingOperation {
	SalesServiceSvc_getBillingDetails * parameters;
}
@property (retain) SalesServiceSvc_getBillingDetails * parameters;
- (id)initWithBinding:(SalesSoapBinding *)aBinding delegate:(id<SalesSoapBindingResponseDelegate>)aDelegate
	parameters:(SalesServiceSvc_getBillingDetails *)aParameters
;
@end
@interface SalesSoapBinding_getAvailableStock : SalesSoapBindingOperation {
	SalesServiceSvc_getAvailableStock * parameters;
}
@property (retain) SalesServiceSvc_getAvailableStock * parameters;
- (id)initWithBinding:(SalesSoapBinding *)aBinding delegate:(id<SalesSoapBindingResponseDelegate>)aDelegate
	parameters:(SalesServiceSvc_getAvailableStock *)aParameters
;
@end
@interface SalesSoapBinding_getStockDetailsByStockType : SalesSoapBindingOperation {
	SalesServiceSvc_getStockDetailsByStockType * parameters;
}
@property (retain) SalesServiceSvc_getStockDetailsByStockType * parameters;
- (id)initWithBinding:(SalesSoapBinding *)aBinding delegate:(id<SalesSoapBindingResponseDelegate>)aDelegate
	parameters:(SalesServiceSvc_getStockDetailsByStockType *)aParameters
;
@end
@interface SalesSoapBinding_getSalesReport : SalesSoapBindingOperation {
	SalesServiceSvc_getSalesReport * parameters;
}
@property (retain) SalesServiceSvc_getSalesReport * parameters;
- (id)initWithBinding:(SalesSoapBinding *)aBinding delegate:(id<SalesSoapBindingResponseDelegate>)aDelegate
	parameters:(SalesServiceSvc_getSalesReport *)aParameters
;
@end
@interface SalesSoapBinding_getExistedSaleID : SalesSoapBindingOperation {
	SalesServiceSvc_getExistedSaleID * parameters;
}
@property (retain) SalesServiceSvc_getExistedSaleID * parameters;
- (id)initWithBinding:(SalesSoapBinding *)aBinding delegate:(id<SalesSoapBindingResponseDelegate>)aDelegate
	parameters:(SalesServiceSvc_getExistedSaleID *)aParameters
;
@end
@interface SalesSoapBinding_searchSalesReportWithPagination : SalesSoapBindingOperation {
	SalesServiceSvc_searchSalesReportWithPagination * parameters;
}
@property (retain) SalesServiceSvc_searchSalesReportWithPagination * parameters;
- (id)initWithBinding:(SalesSoapBinding *)aBinding delegate:(id<SalesSoapBindingResponseDelegate>)aDelegate
	parameters:(SalesServiceSvc_searchSalesReportWithPagination *)aParameters
;
@end
@interface SalesSoapBinding_searchStockWithPagination : SalesSoapBindingOperation {
	SalesServiceSvc_searchStockWithPagination * parameters;
}
@property (retain) SalesServiceSvc_searchStockWithPagination * parameters;
- (id)initWithBinding:(SalesSoapBinding *)aBinding delegate:(id<SalesSoapBindingResponseDelegate>)aDelegate
	parameters:(SalesServiceSvc_searchStockWithPagination *)aParameters
;
@end
@interface SalesSoapBinding_returningItem : SalesSoapBindingOperation {
	SalesServiceSvc_returningItem * parameters;
}
@property (retain) SalesServiceSvc_returningItem * parameters;
- (id)initWithBinding:(SalesSoapBinding *)aBinding delegate:(id<SalesSoapBindingResponseDelegate>)aDelegate
	parameters:(SalesServiceSvc_returningItem *)aParameters
;
@end
@interface SalesSoapBinding_exchangingItem : SalesSoapBindingOperation {
	SalesServiceSvc_exchangingItem * parameters;
}
@property (retain) SalesServiceSvc_exchangingItem * parameters;
- (id)initWithBinding:(SalesSoapBinding *)aBinding delegate:(id<SalesSoapBindingResponseDelegate>)aDelegate
	parameters:(SalesServiceSvc_exchangingItem *)aParameters
;
@end
@interface SalesSoapBinding_envelope : NSObject {
}
+ (SalesSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface SalesSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
