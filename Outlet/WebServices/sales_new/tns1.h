#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class tns1_ReturningItemDetails;
#import "SalesServiceSvc.h"
@interface SalesServiceSvc_ArrayOf_xsd_anyType : NSObject {
	
/* elements */
	NSMutableArray *item;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (SalesServiceSvc_ArrayOf_xsd_anyType *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addItem:(NSString *)toAdd;
@property (readonly) NSMutableArray * item;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface tns1_ReturningItemDetails : NSObject {
	
/* elements */
	NSString * bill_id;
	SalesServiceSvc_ArrayOf_xsd_anyType * cost;
	NSString * counter_id;
	NSString * date_and_time;
	SalesServiceSvc_ArrayOf_xsd_anyType * item_Name;
	SalesServiceSvc_ArrayOf_xsd_anyType * price;
	SalesServiceSvc_ArrayOf_xsd_anyType * quantity;
	SalesServiceSvc_ArrayOf_xsd_anyType * reason;
	SalesServiceSvc_ArrayOf_xsd_anyType * sku_id;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (tns1_ReturningItemDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * bill_id;
@property (retain) SalesServiceSvc_ArrayOf_xsd_anyType * cost;
@property (retain) NSString * counter_id;
@property (retain) NSString * date_and_time;
@property (retain) SalesServiceSvc_ArrayOf_xsd_anyType * item_Name;
@property (retain) SalesServiceSvc_ArrayOf_xsd_anyType * price;
@property (retain) SalesServiceSvc_ArrayOf_xsd_anyType * quantity;
@property (retain) SalesServiceSvc_ArrayOf_xsd_anyType * reason;
@property (retain) SalesServiceSvc_ArrayOf_xsd_anyType * sku_id;
/* attributes */
- (NSDictionary *)attributes;
@end
