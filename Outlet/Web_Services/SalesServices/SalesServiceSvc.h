#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class SalesServiceSvc_exchangingItem;
@class SalesServiceSvc_exchangingItemResponse;
@class SalesServiceSvc_getAvailableStock;
@class SalesServiceSvc_getAvailableStockResponse;
@class SalesServiceSvc_getBillingDetails;
@class SalesServiceSvc_getBillingDetailsResponse;
@class SalesServiceSvc_getBills;
@class SalesServiceSvc_getBillsDetails;
@class SalesServiceSvc_getBillsDetailsResponse;
@class SalesServiceSvc_getBillsResponse;
@class SalesServiceSvc_getExistedSaleID;
@class SalesServiceSvc_getExistedSaleIDResponse;
@class SalesServiceSvc_getHomeDeliveryBills;
@class SalesServiceSvc_getHomeDeliveryBillsResponse;
@class SalesServiceSvc_getHourWiseReport;
@class SalesServiceSvc_getHourWiseReportResponse;
@class SalesServiceSvc_getPendingBillsByPage;
@class SalesServiceSvc_getPendingBillsByPageResponse;
@class SalesServiceSvc_getProcurementReport;
@class SalesServiceSvc_getProcurementReportResponse;
@class SalesServiceSvc_getSalesReport;
@class SalesServiceSvc_getSalesReportResponse;
@class SalesServiceSvc_getSalesReports;
@class SalesServiceSvc_getSalesReportsResponse;
@class SalesServiceSvc_getStockDetailsByStockType;
@class SalesServiceSvc_getStockDetailsByStockTypeResponse;
@class SalesServiceSvc_getXZreportDetails;
@class SalesServiceSvc_getXZreportDetailsResponse;
@class SalesServiceSvc_getXZreports;
@class SalesServiceSvc_getXZreportsResponse;
@class SalesServiceSvc_returningItem;
@class SalesServiceSvc_returningItemResponse;
@class SalesServiceSvc_searchSalesReportWithPagination;
@class SalesServiceSvc_searchSalesReportWithPaginationResponse;
@class SalesServiceSvc_searchStockWithPagination;
@class SalesServiceSvc_searchStockWithPaginationResponse;
@class SalesServiceSvc_updateBilling;
@class SalesServiceSvc_updateBillingResponse;
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
@property (strong) NSString * exchanging_item_details;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_exchangingItemResponse : NSObject {
	
/* elements */
	NSString * return_;
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
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getAvailableStock : NSObject {
	
/* elements */
	NSString * requestHeader;
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
@property (strong) NSString * requestHeader;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getAvailableStockResponse : NSObject {
	
/* elements */
	NSString * return_;
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
@property (strong) NSString * return_;
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
@property (strong) NSString * saleID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getBillingDetailsResponse : NSObject {
	
/* elements */
	NSString * return_;
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
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getBills : NSObject {
	
/* elements */
	NSString * searchCriteria;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_getBills *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * searchCriteria;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getBillsDetails : NSObject {
	
/* elements */
	NSString * billDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_getBillsDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * billDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getBillsDetailsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_getBillsDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getBillsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_getBillsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
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
@property (strong) NSString * saleID;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getExistedSaleIDResponse : NSObject {
	
/* elements */
	NSString * return_;
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
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getHomeDeliveryBills : NSObject {
	
/* elements */
	NSString * billDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_getHomeDeliveryBills *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * billDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getHomeDeliveryBillsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_getHomeDeliveryBillsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getHourWiseReport : NSObject {
	
/* elements */
	NSString * searchCriteria;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_getHourWiseReport *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * searchCriteria;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getHourWiseReportResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_getHourWiseReportResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getPendingBillsByPage : NSObject {
	
/* elements */
	NSString * filterInfo;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_getPendingBillsByPage *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * filterInfo;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getPendingBillsByPageResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_getPendingBillsByPageResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getProcurementReport : NSObject {
	
/* elements */
	NSString * report;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_getProcurementReport *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * report;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getProcurementReportResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_getProcurementReportResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
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
@property (strong) NSString * reportByDate;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getSalesReportResponse : NSObject {
	
/* elements */
	NSString * return_;
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
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getSalesReports : NSObject {
	
/* elements */
	NSString * searchCriteria;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_getSalesReports *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * searchCriteria;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getSalesReportsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_getSalesReportsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getStockDetailsByStockType : NSObject {
	
/* elements */
	NSString * stockType;
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
@property (strong) NSString * stockType;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getStockDetailsByStockTypeResponse : NSObject {
	
/* elements */
	NSString * return_;
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
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getXZreportDetails : NSObject {
	
/* elements */
	NSString * searchCriteria;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_getXZreportDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * searchCriteria;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getXZreportDetailsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_getXZreportDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getXZreports : NSObject {
	
/* elements */
	NSString * searchCriteria;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_getXZreports *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * searchCriteria;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_getXZreportsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_getXZreportsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
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
@property (strong) NSString * returning_item_details;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_returningItemResponse : NSObject {
	
/* elements */
	NSString * return_;
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
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_searchSalesReportWithPagination : NSObject {
	
/* elements */
	NSString * SearchCriteria;
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
@property (strong) NSString * SearchCriteria;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_searchSalesReportWithPaginationResponse : NSObject {
	
/* elements */
	NSString * return_;
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
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_searchStockWithPagination : NSObject {
	
/* elements */
	NSString * stockSearchInput;
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
@property (strong) NSString * stockSearchInput;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_searchStockWithPaginationResponse : NSObject {
	
/* elements */
	NSString * return_;
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
@property (strong) NSString * return_;
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
@property (strong) NSString * bill_details;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface SalesServiceSvc_updateBillingResponse : NSObject {
	
/* elements */
	NSString * return_;
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
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "xs.h"
#import "SalesServiceSvc.h"
@class SalesServiceSvcSoapBinding;
@interface SalesServiceSvc : NSObject {
	
}
+ (SalesServiceSvcSoapBinding *)SalesServiceSvcSoapBinding;
@end
@class SalesServiceSvcSoapBindingResponse;
@class SalesServiceSvcSoapBindingOperation;
@protocol SalesServiceSvcSoapBindingResponseDelegate <NSObject>
- (void) operation:(SalesServiceSvcSoapBindingOperation *)operation completedWithResponse:(SalesServiceSvcSoapBindingResponse *)response;
@end
@interface SalesServiceSvcSoapBinding : NSObject <SalesServiceSvcSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(SalesServiceSvcSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (SalesServiceSvcSoapBindingResponse *)updateBillingUsingParameters:(SalesServiceSvc_updateBilling *)aParameters ;
- (void)updateBillingAsyncUsingParameters:(SalesServiceSvc_updateBilling *)aParameters  delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)responseDelegate;
- (SalesServiceSvcSoapBindingResponse *)getBillsDetailsUsingParameters:(SalesServiceSvc_getBillsDetails *)aParameters ;
- (void)getBillsDetailsAsyncUsingParameters:(SalesServiceSvc_getBillsDetails *)aParameters  delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)responseDelegate;
- (SalesServiceSvcSoapBindingResponse *)exchangingItemUsingParameters:(SalesServiceSvc_exchangingItem *)aParameters ;
- (void)exchangingItemAsyncUsingParameters:(SalesServiceSvc_exchangingItem *)aParameters  delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)responseDelegate;
- (SalesServiceSvcSoapBindingResponse *)getPendingBillsByPageUsingParameters:(SalesServiceSvc_getPendingBillsByPage *)aParameters ;
- (void)getPendingBillsByPageAsyncUsingParameters:(SalesServiceSvc_getPendingBillsByPage *)aParameters  delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)responseDelegate;
- (SalesServiceSvcSoapBindingResponse *)getSalesReportUsingParameters:(SalesServiceSvc_getSalesReport *)aParameters ;
- (void)getSalesReportAsyncUsingParameters:(SalesServiceSvc_getSalesReport *)aParameters  delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)responseDelegate;
- (SalesServiceSvcSoapBindingResponse *)getExistedSaleIDUsingParameters:(SalesServiceSvc_getExistedSaleID *)aParameters ;
- (void)getExistedSaleIDAsyncUsingParameters:(SalesServiceSvc_getExistedSaleID *)aParameters  delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)responseDelegate;
- (SalesServiceSvcSoapBindingResponse *)getStockDetailsByStockTypeUsingParameters:(SalesServiceSvc_getStockDetailsByStockType *)aParameters ;
- (void)getStockDetailsByStockTypeAsyncUsingParameters:(SalesServiceSvc_getStockDetailsByStockType *)aParameters  delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)responseDelegate;
- (SalesServiceSvcSoapBindingResponse *)searchSalesReportWithPaginationUsingParameters:(SalesServiceSvc_searchSalesReportWithPagination *)aParameters ;
- (void)searchSalesReportWithPaginationAsyncUsingParameters:(SalesServiceSvc_searchSalesReportWithPagination *)aParameters  delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)responseDelegate;
- (SalesServiceSvcSoapBindingResponse *)getHomeDeliveryBillsUsingParameters:(SalesServiceSvc_getHomeDeliveryBills *)aParameters ;
- (void)getHomeDeliveryBillsAsyncUsingParameters:(SalesServiceSvc_getHomeDeliveryBills *)aParameters  delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)responseDelegate;
- (SalesServiceSvcSoapBindingResponse *)searchStockWithPaginationUsingParameters:(SalesServiceSvc_searchStockWithPagination *)aParameters ;
- (void)searchStockWithPaginationAsyncUsingParameters:(SalesServiceSvc_searchStockWithPagination *)aParameters  delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)responseDelegate;
- (SalesServiceSvcSoapBindingResponse *)getProcurementReportUsingParameters:(SalesServiceSvc_getProcurementReport *)aParameters ;
- (void)getProcurementReportAsyncUsingParameters:(SalesServiceSvc_getProcurementReport *)aParameters  delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)responseDelegate;
- (SalesServiceSvcSoapBindingResponse *)getXZreportDetailsUsingParameters:(SalesServiceSvc_getXZreportDetails *)aParameters ;
- (void)getXZreportDetailsAsyncUsingParameters:(SalesServiceSvc_getXZreportDetails *)aParameters  delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)responseDelegate;
- (SalesServiceSvcSoapBindingResponse *)getSalesReportsUsingParameters:(SalesServiceSvc_getSalesReports *)aParameters ;
- (void)getSalesReportsAsyncUsingParameters:(SalesServiceSvc_getSalesReports *)aParameters  delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)responseDelegate;
- (SalesServiceSvcSoapBindingResponse *)returningItemUsingParameters:(SalesServiceSvc_returningItem *)aParameters ;
- (void)returningItemAsyncUsingParameters:(SalesServiceSvc_returningItem *)aParameters  delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)responseDelegate;
- (SalesServiceSvcSoapBindingResponse *)getXZreportsUsingParameters:(SalesServiceSvc_getXZreports *)aParameters ;
- (void)getXZreportsAsyncUsingParameters:(SalesServiceSvc_getXZreports *)aParameters  delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)responseDelegate;
- (SalesServiceSvcSoapBindingResponse *)getHourWiseReportUsingParameters:(SalesServiceSvc_getHourWiseReport *)aParameters ;
- (void)getHourWiseReportAsyncUsingParameters:(SalesServiceSvc_getHourWiseReport *)aParameters  delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)responseDelegate;
- (SalesServiceSvcSoapBindingResponse *)getBillsUsingParameters:(SalesServiceSvc_getBills *)aParameters ;
- (void)getBillsAsyncUsingParameters:(SalesServiceSvc_getBills *)aParameters  delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)responseDelegate;
- (SalesServiceSvcSoapBindingResponse *)getAvailableStockUsingParameters:(SalesServiceSvc_getAvailableStock *)aParameters ;
- (void)getAvailableStockAsyncUsingParameters:(SalesServiceSvc_getAvailableStock *)aParameters  delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)responseDelegate;
- (SalesServiceSvcSoapBindingResponse *)getBillingDetailsUsingParameters:(SalesServiceSvc_getBillingDetails *)aParameters ;
- (void)getBillingDetailsAsyncUsingParameters:(SalesServiceSvc_getBillingDetails *)aParameters  delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)responseDelegate;
@end
@interface SalesServiceSvcSoapBindingOperation : NSOperation {
	SalesServiceSvcSoapBinding *binding;
	SalesServiceSvcSoapBindingResponse * response;
	id<SalesServiceSvcSoapBindingResponseDelegate>  delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (strong) SalesServiceSvcSoapBinding *binding;
@property (  readonly) SalesServiceSvcSoapBindingResponse *response;
@property (nonatomic ) id<SalesServiceSvcSoapBindingResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(SalesServiceSvcSoapBinding *)aBinding delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)aDelegate;
@end
@interface SalesServiceSvcSoapBinding_updateBilling : SalesServiceSvcSoapBindingOperation {
	SalesServiceSvc_updateBilling * parameters;
}
@property (strong) SalesServiceSvc_updateBilling * parameters;
- (id)initWithBinding:(SalesServiceSvcSoapBinding *)aBinding delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)aDelegate
	parameters:(SalesServiceSvc_updateBilling *)aParameters
;
@end
@interface SalesServiceSvcSoapBinding_getBillsDetails : SalesServiceSvcSoapBindingOperation {
	SalesServiceSvc_getBillsDetails * parameters;
}
@property (strong) SalesServiceSvc_getBillsDetails * parameters;
- (id)initWithBinding:(SalesServiceSvcSoapBinding *)aBinding delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)aDelegate
	parameters:(SalesServiceSvc_getBillsDetails *)aParameters
;
@end
@interface SalesServiceSvcSoapBinding_exchangingItem : SalesServiceSvcSoapBindingOperation {
	SalesServiceSvc_exchangingItem * parameters;
}
@property (strong) SalesServiceSvc_exchangingItem * parameters;
- (id)initWithBinding:(SalesServiceSvcSoapBinding *)aBinding delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)aDelegate
	parameters:(SalesServiceSvc_exchangingItem *)aParameters
;
@end
@interface SalesServiceSvcSoapBinding_getPendingBillsByPage : SalesServiceSvcSoapBindingOperation {
	SalesServiceSvc_getPendingBillsByPage * parameters;
}
@property (strong) SalesServiceSvc_getPendingBillsByPage * parameters;
- (id)initWithBinding:(SalesServiceSvcSoapBinding *)aBinding delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)aDelegate
	parameters:(SalesServiceSvc_getPendingBillsByPage *)aParameters
;
@end
@interface SalesServiceSvcSoapBinding_getSalesReport : SalesServiceSvcSoapBindingOperation {
	SalesServiceSvc_getSalesReport * parameters;
}
@property (strong) SalesServiceSvc_getSalesReport * parameters;
- (id)initWithBinding:(SalesServiceSvcSoapBinding *)aBinding delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)aDelegate
	parameters:(SalesServiceSvc_getSalesReport *)aParameters
;
@end
@interface SalesServiceSvcSoapBinding_getExistedSaleID : SalesServiceSvcSoapBindingOperation {
	SalesServiceSvc_getExistedSaleID * parameters;
}
@property (strong) SalesServiceSvc_getExistedSaleID * parameters;
- (id)initWithBinding:(SalesServiceSvcSoapBinding *)aBinding delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)aDelegate
	parameters:(SalesServiceSvc_getExistedSaleID *)aParameters
;
@end
@interface SalesServiceSvcSoapBinding_getStockDetailsByStockType : SalesServiceSvcSoapBindingOperation {
	SalesServiceSvc_getStockDetailsByStockType * parameters;
}
@property (strong) SalesServiceSvc_getStockDetailsByStockType * parameters;
- (id)initWithBinding:(SalesServiceSvcSoapBinding *)aBinding delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)aDelegate
	parameters:(SalesServiceSvc_getStockDetailsByStockType *)aParameters
;
@end
@interface SalesServiceSvcSoapBinding_searchSalesReportWithPagination : SalesServiceSvcSoapBindingOperation {
	SalesServiceSvc_searchSalesReportWithPagination * parameters;
}
@property (strong) SalesServiceSvc_searchSalesReportWithPagination * parameters;
- (id)initWithBinding:(SalesServiceSvcSoapBinding *)aBinding delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)aDelegate
	parameters:(SalesServiceSvc_searchSalesReportWithPagination *)aParameters
;
@end
@interface SalesServiceSvcSoapBinding_getHomeDeliveryBills : SalesServiceSvcSoapBindingOperation {
	SalesServiceSvc_getHomeDeliveryBills * parameters;
}
@property (strong) SalesServiceSvc_getHomeDeliveryBills * parameters;
- (id)initWithBinding:(SalesServiceSvcSoapBinding *)aBinding delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)aDelegate
	parameters:(SalesServiceSvc_getHomeDeliveryBills *)aParameters
;
@end
@interface SalesServiceSvcSoapBinding_searchStockWithPagination : SalesServiceSvcSoapBindingOperation {
	SalesServiceSvc_searchStockWithPagination * parameters;
}
@property (strong) SalesServiceSvc_searchStockWithPagination * parameters;
- (id)initWithBinding:(SalesServiceSvcSoapBinding *)aBinding delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)aDelegate
	parameters:(SalesServiceSvc_searchStockWithPagination *)aParameters
;
@end
@interface SalesServiceSvcSoapBinding_getProcurementReport : SalesServiceSvcSoapBindingOperation {
	SalesServiceSvc_getProcurementReport * parameters;
}
@property (strong) SalesServiceSvc_getProcurementReport * parameters;
- (id)initWithBinding:(SalesServiceSvcSoapBinding *)aBinding delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)aDelegate
	parameters:(SalesServiceSvc_getProcurementReport *)aParameters
;
@end
@interface SalesServiceSvcSoapBinding_getXZreportDetails : SalesServiceSvcSoapBindingOperation {
	SalesServiceSvc_getXZreportDetails * parameters;
}
@property (strong) SalesServiceSvc_getXZreportDetails * parameters;
- (id)initWithBinding:(SalesServiceSvcSoapBinding *)aBinding delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)aDelegate
	parameters:(SalesServiceSvc_getXZreportDetails *)aParameters
;
@end
@interface SalesServiceSvcSoapBinding_getSalesReports : SalesServiceSvcSoapBindingOperation {
	SalesServiceSvc_getSalesReports * parameters;
}
@property (strong) SalesServiceSvc_getSalesReports * parameters;
- (id)initWithBinding:(SalesServiceSvcSoapBinding *)aBinding delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)aDelegate
	parameters:(SalesServiceSvc_getSalesReports *)aParameters
;
@end
@interface SalesServiceSvcSoapBinding_returningItem : SalesServiceSvcSoapBindingOperation {
	SalesServiceSvc_returningItem * parameters;
}
@property (strong) SalesServiceSvc_returningItem * parameters;
- (id)initWithBinding:(SalesServiceSvcSoapBinding *)aBinding delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)aDelegate
	parameters:(SalesServiceSvc_returningItem *)aParameters
;
@end
@interface SalesServiceSvcSoapBinding_getXZreports : SalesServiceSvcSoapBindingOperation {
	SalesServiceSvc_getXZreports * parameters;
}
@property (strong) SalesServiceSvc_getXZreports * parameters;
- (id)initWithBinding:(SalesServiceSvcSoapBinding *)aBinding delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)aDelegate
	parameters:(SalesServiceSvc_getXZreports *)aParameters
;
@end
@interface SalesServiceSvcSoapBinding_getHourWiseReport : SalesServiceSvcSoapBindingOperation {
	SalesServiceSvc_getHourWiseReport * parameters;
}
@property (strong) SalesServiceSvc_getHourWiseReport * parameters;
- (id)initWithBinding:(SalesServiceSvcSoapBinding *)aBinding delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)aDelegate
	parameters:(SalesServiceSvc_getHourWiseReport *)aParameters
;
@end
@interface SalesServiceSvcSoapBinding_getBills : SalesServiceSvcSoapBindingOperation {
	SalesServiceSvc_getBills * parameters;
}
@property (strong) SalesServiceSvc_getBills * parameters;
- (id)initWithBinding:(SalesServiceSvcSoapBinding *)aBinding delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)aDelegate
	parameters:(SalesServiceSvc_getBills *)aParameters
;
@end
@interface SalesServiceSvcSoapBinding_getAvailableStock : SalesServiceSvcSoapBindingOperation {
	SalesServiceSvc_getAvailableStock * parameters;
}
@property (strong) SalesServiceSvc_getAvailableStock * parameters;
- (id)initWithBinding:(SalesServiceSvcSoapBinding *)aBinding delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)aDelegate
	parameters:(SalesServiceSvc_getAvailableStock *)aParameters
;
@end
@interface SalesServiceSvcSoapBinding_getBillingDetails : SalesServiceSvcSoapBindingOperation {
	SalesServiceSvc_getBillingDetails * parameters;
}
@property (strong) SalesServiceSvc_getBillingDetails * parameters;
- (id)initWithBinding:(SalesServiceSvcSoapBinding *)aBinding delegate:(id<SalesServiceSvcSoapBindingResponseDelegate>)aDelegate
	parameters:(SalesServiceSvc_getBillingDetails *)aParameters
;
@end
@interface SalesServiceSvcSoapBinding_envelope : NSObject {
}
+ (SalesServiceSvcSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface SalesServiceSvcSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end
