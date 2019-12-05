#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class UtilityMasterServiceSvc_createCurrency;
@class UtilityMasterServiceSvc_createCurrencyResponse;
@class UtilityMasterServiceSvc_createLocation;
@class UtilityMasterServiceSvc_createLocationResponse;
@class UtilityMasterServiceSvc_createProductCategory;
@class UtilityMasterServiceSvc_createProductCategoryResponse;
@class UtilityMasterServiceSvc_createProductSubCategory;
@class UtilityMasterServiceSvc_createProductSubCategoryResponse;
@class UtilityMasterServiceSvc_createTax;
@class UtilityMasterServiceSvc_createTaxResponse;
@class UtilityMasterServiceSvc_deleteCurrency;
@class UtilityMasterServiceSvc_deleteCurrencyResponse;
@class UtilityMasterServiceSvc_deleteLocation;
@class UtilityMasterServiceSvc_deleteLocationResponse;
@class UtilityMasterServiceSvc_deleteProductCategory;
@class UtilityMasterServiceSvc_deleteProductCategoryResponse;
@class UtilityMasterServiceSvc_deleteProductSubCategory;
@class UtilityMasterServiceSvc_deleteProductSubCategoryResponse;
@class UtilityMasterServiceSvc_deleteTaxDetails;
@class UtilityMasterServiceSvc_deleteTaxDetailsResponse;
@class UtilityMasterServiceSvc_getCategories;
@class UtilityMasterServiceSvc_getCategoriesResponse;
@class UtilityMasterServiceSvc_getCurrency;
@class UtilityMasterServiceSvc_getCurrencyResponse;
@class UtilityMasterServiceSvc_getLanguages;
@class UtilityMasterServiceSvc_getLanguagesResponse;
@class UtilityMasterServiceSvc_getLocation;
@class UtilityMasterServiceSvc_getLocationResponse;
@class UtilityMasterServiceSvc_getProductCategory;
@class UtilityMasterServiceSvc_getProductCategoryResponse;
@class UtilityMasterServiceSvc_getProductSubCategory;
@class UtilityMasterServiceSvc_getProductSubCategoryResponse;
@class UtilityMasterServiceSvc_getTaxes;
@class UtilityMasterServiceSvc_getTaxesResponse;
@class UtilityMasterServiceSvc_getWareHouses;
@class UtilityMasterServiceSvc_getWareHousesResponse;
@class UtilityMasterServiceSvc_updateCurrency;
@class UtilityMasterServiceSvc_updateCurrencyResponse;
@class UtilityMasterServiceSvc_updateLocation;
@class UtilityMasterServiceSvc_updateLocationResponse;
@class UtilityMasterServiceSvc_updateProductCategory;
@class UtilityMasterServiceSvc_updateProductCategoryResponse;
@class UtilityMasterServiceSvc_updateProductSubCategory;
@class UtilityMasterServiceSvc_updateProductSubCategoryResponse;
@class UtilityMasterServiceSvc_updateTaxDetails;
@class UtilityMasterServiceSvc_updateTaxDetailsResponse;
@interface UtilityMasterServiceSvc_createCurrency : NSObject {
	
/* elements */
	NSString * currencyDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_createCurrency *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * currencyDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_createCurrencyResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_createCurrencyResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_createLocation : NSObject {
	
/* elements */
	NSString * locationDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_createLocation *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * locationDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_createLocationResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_createLocationResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_createProductCategory : NSObject {
	
/* elements */
	NSString * productCategoryDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_createProductCategory *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * productCategoryDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_createProductCategoryResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_createProductCategoryResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_createProductSubCategory : NSObject {
	
/* elements */
	NSString * productSubCategoryDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_createProductSubCategory *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * productSubCategoryDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_createProductSubCategoryResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_createProductSubCategoryResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_createTax : NSObject {
	
/* elements */
	NSString * taxDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_createTax *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * taxDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_createTaxResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_createTaxResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_deleteCurrency : NSObject {
	
/* elements */
	NSString * currency;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_deleteCurrency *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * currency;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_deleteCurrencyResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_deleteCurrencyResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_deleteLocation : NSObject {
	
/* elements */
	NSString * locationDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_deleteLocation *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * locationDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_deleteLocationResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_deleteLocationResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_deleteProductCategory : NSObject {
	
/* elements */
	NSString * categoryDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_deleteProductCategory *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * categoryDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_deleteProductCategoryResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_deleteProductCategoryResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_deleteProductSubCategory : NSObject {
	
/* elements */
	NSString * categoryDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_deleteProductSubCategory *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * categoryDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_deleteProductSubCategoryResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_deleteProductSubCategoryResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_deleteTaxDetails : NSObject {
	
/* elements */
	NSString * taxDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_deleteTaxDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * taxDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_deleteTaxDetailsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_deleteTaxDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_getCategories : NSObject {
	
/* elements */
	NSString * userId;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_getCategories *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * userId;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_getCategoriesResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_getCategoriesResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_getCurrency : NSObject {
	
/* elements */
	NSString * currency;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_getCurrency *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * currency;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_getCurrencyResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_getCurrencyResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_getLanguages : NSObject {
	
/* elements */
	NSString * language;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_getLanguages *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * language;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_getLanguagesResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_getLanguagesResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_getLocation : NSObject {
	
/* elements */
	NSString * locationDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_getLocation *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * locationDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_getLocationResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_getLocationResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_getProductCategory : NSObject {
	
/* elements */
	NSString * categoryDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_getProductCategory *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * categoryDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_getProductCategoryResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_getProductCategoryResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_getProductSubCategory : NSObject {
	
/* elements */
	NSString * categoryDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_getProductSubCategory *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * categoryDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_getProductSubCategoryResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_getProductSubCategoryResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_getTaxes : NSObject {
	
/* elements */
	NSString * userId;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_getTaxes *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * userId;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_getTaxesResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_getTaxesResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_getWareHouses : NSObject {
	
/* elements */
	NSString * wareHouse;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_getWareHouses *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * wareHouse;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_getWareHousesResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_getWareHousesResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_updateCurrency : NSObject {
	
/* elements */
	NSString * currency;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_updateCurrency *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * currency;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_updateCurrencyResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_updateCurrencyResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_updateLocation : NSObject {
	
/* elements */
	NSString * locationDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_updateLocation *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * locationDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_updateLocationResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_updateLocationResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_updateProductCategory : NSObject {
	
/* elements */
	NSString * categoryDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_updateProductCategory *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * categoryDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_updateProductCategoryResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_updateProductCategoryResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_updateProductSubCategory : NSObject {
	
/* elements */
	NSString * categoryDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_updateProductSubCategory *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * categoryDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_updateProductSubCategoryResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_updateProductSubCategoryResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_updateTaxDetails : NSObject {
	
/* elements */
	NSString * taxDetails;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_updateTaxDetails *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (strong) NSString * taxDetails;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface UtilityMasterServiceSvc_updateTaxDetailsResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (UtilityMasterServiceSvc_updateTaxDetailsResponse *)deserializeNode:(xmlNodePtr)cur;
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
#import "UtilityMasterServiceSvc.h"
@class UtilityMasterServiceSoapBinding;
@interface UtilityMasterServiceSvc : NSObject {
	
}
+ (UtilityMasterServiceSoapBinding *)UtilityMasterServiceSoapBinding;
@end
@class UtilityMasterServiceSoapBindingResponse;
@class UtilityMasterServiceSoapBindingOperation;
@protocol UtilityMasterServiceSoapBindingResponseDelegate <NSObject>
- (void) operation:(UtilityMasterServiceSoapBindingOperation *)operation completedWithResponse:(UtilityMasterServiceSoapBindingResponse *)response;
@end
@interface UtilityMasterServiceSoapBinding : NSObject <UtilityMasterServiceSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(UtilityMasterServiceSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (UtilityMasterServiceSoapBindingResponse *)updateTaxDetailsUsingParameters:(UtilityMasterServiceSvc_updateTaxDetails *)aParameters ;
- (void)updateTaxDetailsAsyncUsingParameters:(UtilityMasterServiceSvc_updateTaxDetails *)aParameters  delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)responseDelegate;
- (UtilityMasterServiceSoapBindingResponse *)createLocationUsingParameters:(UtilityMasterServiceSvc_createLocation *)aParameters ;
- (void)createLocationAsyncUsingParameters:(UtilityMasterServiceSvc_createLocation *)aParameters  delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)responseDelegate;
- (UtilityMasterServiceSoapBindingResponse *)getLocationUsingParameters:(UtilityMasterServiceSvc_getLocation *)aParameters ;
- (void)getLocationAsyncUsingParameters:(UtilityMasterServiceSvc_getLocation *)aParameters  delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)responseDelegate;
- (UtilityMasterServiceSoapBindingResponse *)createTaxUsingParameters:(UtilityMasterServiceSvc_createTax *)aParameters ;
- (void)createTaxAsyncUsingParameters:(UtilityMasterServiceSvc_createTax *)aParameters  delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)responseDelegate;
- (UtilityMasterServiceSoapBindingResponse *)getProductSubCategoryUsingParameters:(UtilityMasterServiceSvc_getProductSubCategory *)aParameters ;
- (void)getProductSubCategoryAsyncUsingParameters:(UtilityMasterServiceSvc_getProductSubCategory *)aParameters  delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)responseDelegate;
- (UtilityMasterServiceSoapBindingResponse *)updateCurrencyUsingParameters:(UtilityMasterServiceSvc_updateCurrency *)aParameters ;
- (void)updateCurrencyAsyncUsingParameters:(UtilityMasterServiceSvc_updateCurrency *)aParameters  delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)responseDelegate;
- (UtilityMasterServiceSoapBindingResponse *)createProductSubCategoryUsingParameters:(UtilityMasterServiceSvc_createProductSubCategory *)aParameters ;
- (void)createProductSubCategoryAsyncUsingParameters:(UtilityMasterServiceSvc_createProductSubCategory *)aParameters  delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)responseDelegate;
- (UtilityMasterServiceSoapBindingResponse *)deleteProductSubCategoryUsingParameters:(UtilityMasterServiceSvc_deleteProductSubCategory *)aParameters ;
- (void)deleteProductSubCategoryAsyncUsingParameters:(UtilityMasterServiceSvc_deleteProductSubCategory *)aParameters  delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)responseDelegate;
- (UtilityMasterServiceSoapBindingResponse *)getLanguagesUsingParameters:(UtilityMasterServiceSvc_getLanguages *)aParameters ;
- (void)getLanguagesAsyncUsingParameters:(UtilityMasterServiceSvc_getLanguages *)aParameters  delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)responseDelegate;
- (UtilityMasterServiceSoapBindingResponse *)updateLocationUsingParameters:(UtilityMasterServiceSvc_updateLocation *)aParameters ;
- (void)updateLocationAsyncUsingParameters:(UtilityMasterServiceSvc_updateLocation *)aParameters  delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)responseDelegate;
- (UtilityMasterServiceSoapBindingResponse *)getTaxesUsingParameters:(UtilityMasterServiceSvc_getTaxes *)aParameters ;
- (void)getTaxesAsyncUsingParameters:(UtilityMasterServiceSvc_getTaxes *)aParameters  delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)responseDelegate;
- (UtilityMasterServiceSoapBindingResponse *)getCurrencyUsingParameters:(UtilityMasterServiceSvc_getCurrency *)aParameters ;
- (void)getCurrencyAsyncUsingParameters:(UtilityMasterServiceSvc_getCurrency *)aParameters  delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)responseDelegate;
- (UtilityMasterServiceSoapBindingResponse *)getWareHousesUsingParameters:(UtilityMasterServiceSvc_getWareHouses *)aParameters ;
- (void)getWareHousesAsyncUsingParameters:(UtilityMasterServiceSvc_getWareHouses *)aParameters  delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)responseDelegate;
- (UtilityMasterServiceSoapBindingResponse *)createProductCategoryUsingParameters:(UtilityMasterServiceSvc_createProductCategory *)aParameters ;
- (void)createProductCategoryAsyncUsingParameters:(UtilityMasterServiceSvc_createProductCategory *)aParameters  delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)responseDelegate;
- (UtilityMasterServiceSoapBindingResponse *)getProductCategoryUsingParameters:(UtilityMasterServiceSvc_getProductCategory *)aParameters ;
- (void)getProductCategoryAsyncUsingParameters:(UtilityMasterServiceSvc_getProductCategory *)aParameters  delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)responseDelegate;
- (UtilityMasterServiceSoapBindingResponse *)deleteProductCategoryUsingParameters:(UtilityMasterServiceSvc_deleteProductCategory *)aParameters ;
- (void)deleteProductCategoryAsyncUsingParameters:(UtilityMasterServiceSvc_deleteProductCategory *)aParameters  delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)responseDelegate;
- (UtilityMasterServiceSoapBindingResponse *)deleteCurrencyUsingParameters:(UtilityMasterServiceSvc_deleteCurrency *)aParameters ;
- (void)deleteCurrencyAsyncUsingParameters:(UtilityMasterServiceSvc_deleteCurrency *)aParameters  delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)responseDelegate;
- (UtilityMasterServiceSoapBindingResponse *)getCategoriesUsingParameters:(UtilityMasterServiceSvc_getCategories *)aParameters ;
- (void)getCategoriesAsyncUsingParameters:(UtilityMasterServiceSvc_getCategories *)aParameters  delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)responseDelegate;
- (UtilityMasterServiceSoapBindingResponse *)updateProductCategoryUsingParameters:(UtilityMasterServiceSvc_updateProductCategory *)aParameters ;
- (void)updateProductCategoryAsyncUsingParameters:(UtilityMasterServiceSvc_updateProductCategory *)aParameters  delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)responseDelegate;
- (UtilityMasterServiceSoapBindingResponse *)updateProductSubCategoryUsingParameters:(UtilityMasterServiceSvc_updateProductSubCategory *)aParameters ;
- (void)updateProductSubCategoryAsyncUsingParameters:(UtilityMasterServiceSvc_updateProductSubCategory *)aParameters  delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)responseDelegate;
- (UtilityMasterServiceSoapBindingResponse *)deleteTaxDetailsUsingParameters:(UtilityMasterServiceSvc_deleteTaxDetails *)aParameters ;
- (void)deleteTaxDetailsAsyncUsingParameters:(UtilityMasterServiceSvc_deleteTaxDetails *)aParameters  delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)responseDelegate;
- (UtilityMasterServiceSoapBindingResponse *)deleteLocationUsingParameters:(UtilityMasterServiceSvc_deleteLocation *)aParameters ;
- (void)deleteLocationAsyncUsingParameters:(UtilityMasterServiceSvc_deleteLocation *)aParameters  delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)responseDelegate;
- (UtilityMasterServiceSoapBindingResponse *)createCurrencyUsingParameters:(UtilityMasterServiceSvc_createCurrency *)aParameters ;
- (void)createCurrencyAsyncUsingParameters:(UtilityMasterServiceSvc_createCurrency *)aParameters  delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)responseDelegate;
@end
@interface UtilityMasterServiceSoapBindingOperation : NSOperation {
	UtilityMasterServiceSoapBinding *binding;
	UtilityMasterServiceSoapBindingResponse * response;
	id<UtilityMasterServiceSoapBindingResponseDelegate>  delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (strong) UtilityMasterServiceSoapBinding *binding;
@property (  readonly) UtilityMasterServiceSoapBindingResponse *response;
@property (nonatomic ) id<UtilityMasterServiceSoapBindingResponseDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *urlConnection;
- (id)initWithBinding:(UtilityMasterServiceSoapBinding *)aBinding delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)aDelegate;
@end
@interface UtilityMasterServiceSoapBinding_updateTaxDetails : UtilityMasterServiceSoapBindingOperation {
	UtilityMasterServiceSvc_updateTaxDetails * parameters;
}
@property (strong) UtilityMasterServiceSvc_updateTaxDetails * parameters;
- (id)initWithBinding:(UtilityMasterServiceSoapBinding *)aBinding delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(UtilityMasterServiceSvc_updateTaxDetails *)aParameters
;
@end
@interface UtilityMasterServiceSoapBinding_createLocation : UtilityMasterServiceSoapBindingOperation {
	UtilityMasterServiceSvc_createLocation * parameters;
}
@property (strong) UtilityMasterServiceSvc_createLocation * parameters;
- (id)initWithBinding:(UtilityMasterServiceSoapBinding *)aBinding delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(UtilityMasterServiceSvc_createLocation *)aParameters
;
@end
@interface UtilityMasterServiceSoapBinding_getLocation : UtilityMasterServiceSoapBindingOperation {
	UtilityMasterServiceSvc_getLocation * parameters;
}
@property (strong) UtilityMasterServiceSvc_getLocation * parameters;
- (id)initWithBinding:(UtilityMasterServiceSoapBinding *)aBinding delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(UtilityMasterServiceSvc_getLocation *)aParameters
;
@end
@interface UtilityMasterServiceSoapBinding_createTax : UtilityMasterServiceSoapBindingOperation {
	UtilityMasterServiceSvc_createTax * parameters;
}
@property (strong) UtilityMasterServiceSvc_createTax * parameters;
- (id)initWithBinding:(UtilityMasterServiceSoapBinding *)aBinding delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(UtilityMasterServiceSvc_createTax *)aParameters
;
@end
@interface UtilityMasterServiceSoapBinding_getProductSubCategory : UtilityMasterServiceSoapBindingOperation {
	UtilityMasterServiceSvc_getProductSubCategory * parameters;
}
@property (strong) UtilityMasterServiceSvc_getProductSubCategory * parameters;
- (id)initWithBinding:(UtilityMasterServiceSoapBinding *)aBinding delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(UtilityMasterServiceSvc_getProductSubCategory *)aParameters
;
@end
@interface UtilityMasterServiceSoapBinding_updateCurrency : UtilityMasterServiceSoapBindingOperation {
	UtilityMasterServiceSvc_updateCurrency * parameters;
}
@property (strong) UtilityMasterServiceSvc_updateCurrency * parameters;
- (id)initWithBinding:(UtilityMasterServiceSoapBinding *)aBinding delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(UtilityMasterServiceSvc_updateCurrency *)aParameters
;
@end
@interface UtilityMasterServiceSoapBinding_createProductSubCategory : UtilityMasterServiceSoapBindingOperation {
	UtilityMasterServiceSvc_createProductSubCategory * parameters;
}
@property (strong) UtilityMasterServiceSvc_createProductSubCategory * parameters;
- (id)initWithBinding:(UtilityMasterServiceSoapBinding *)aBinding delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(UtilityMasterServiceSvc_createProductSubCategory *)aParameters
;
@end
@interface UtilityMasterServiceSoapBinding_deleteProductSubCategory : UtilityMasterServiceSoapBindingOperation {
	UtilityMasterServiceSvc_deleteProductSubCategory * parameters;
}
@property (strong) UtilityMasterServiceSvc_deleteProductSubCategory * parameters;
- (id)initWithBinding:(UtilityMasterServiceSoapBinding *)aBinding delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(UtilityMasterServiceSvc_deleteProductSubCategory *)aParameters
;
@end
@interface UtilityMasterServiceSoapBinding_getLanguages : UtilityMasterServiceSoapBindingOperation {
	UtilityMasterServiceSvc_getLanguages * parameters;
}
@property (strong) UtilityMasterServiceSvc_getLanguages * parameters;
- (id)initWithBinding:(UtilityMasterServiceSoapBinding *)aBinding delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(UtilityMasterServiceSvc_getLanguages *)aParameters
;
@end
@interface UtilityMasterServiceSoapBinding_updateLocation : UtilityMasterServiceSoapBindingOperation {
	UtilityMasterServiceSvc_updateLocation * parameters;
}
@property (strong) UtilityMasterServiceSvc_updateLocation * parameters;
- (id)initWithBinding:(UtilityMasterServiceSoapBinding *)aBinding delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(UtilityMasterServiceSvc_updateLocation *)aParameters
;
@end
@interface UtilityMasterServiceSoapBinding_getTaxes : UtilityMasterServiceSoapBindingOperation {
	UtilityMasterServiceSvc_getTaxes * parameters;
}
@property (strong) UtilityMasterServiceSvc_getTaxes * parameters;
- (id)initWithBinding:(UtilityMasterServiceSoapBinding *)aBinding delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(UtilityMasterServiceSvc_getTaxes *)aParameters
;
@end
@interface UtilityMasterServiceSoapBinding_getCurrency : UtilityMasterServiceSoapBindingOperation {
	UtilityMasterServiceSvc_getCurrency * parameters;
}
@property (strong) UtilityMasterServiceSvc_getCurrency * parameters;
- (id)initWithBinding:(UtilityMasterServiceSoapBinding *)aBinding delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(UtilityMasterServiceSvc_getCurrency *)aParameters
;
@end
@interface UtilityMasterServiceSoapBinding_getWareHouses : UtilityMasterServiceSoapBindingOperation {
	UtilityMasterServiceSvc_getWareHouses * parameters;
}
@property (strong) UtilityMasterServiceSvc_getWareHouses * parameters;
- (id)initWithBinding:(UtilityMasterServiceSoapBinding *)aBinding delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(UtilityMasterServiceSvc_getWareHouses *)aParameters
;
@end
@interface UtilityMasterServiceSoapBinding_createProductCategory : UtilityMasterServiceSoapBindingOperation {
	UtilityMasterServiceSvc_createProductCategory * parameters;
}
@property (strong) UtilityMasterServiceSvc_createProductCategory * parameters;
- (id)initWithBinding:(UtilityMasterServiceSoapBinding *)aBinding delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(UtilityMasterServiceSvc_createProductCategory *)aParameters
;
@end
@interface UtilityMasterServiceSoapBinding_getProductCategory : UtilityMasterServiceSoapBindingOperation {
	UtilityMasterServiceSvc_getProductCategory * parameters;
}
@property (strong) UtilityMasterServiceSvc_getProductCategory * parameters;
- (id)initWithBinding:(UtilityMasterServiceSoapBinding *)aBinding delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(UtilityMasterServiceSvc_getProductCategory *)aParameters
;
@end
@interface UtilityMasterServiceSoapBinding_deleteProductCategory : UtilityMasterServiceSoapBindingOperation {
	UtilityMasterServiceSvc_deleteProductCategory * parameters;
}
@property (strong) UtilityMasterServiceSvc_deleteProductCategory * parameters;
- (id)initWithBinding:(UtilityMasterServiceSoapBinding *)aBinding delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(UtilityMasterServiceSvc_deleteProductCategory *)aParameters
;
@end
@interface UtilityMasterServiceSoapBinding_deleteCurrency : UtilityMasterServiceSoapBindingOperation {
	UtilityMasterServiceSvc_deleteCurrency * parameters;
}
@property (strong) UtilityMasterServiceSvc_deleteCurrency * parameters;
- (id)initWithBinding:(UtilityMasterServiceSoapBinding *)aBinding delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(UtilityMasterServiceSvc_deleteCurrency *)aParameters
;
@end
@interface UtilityMasterServiceSoapBinding_getCategories : UtilityMasterServiceSoapBindingOperation {
	UtilityMasterServiceSvc_getCategories * parameters;
}
@property (strong) UtilityMasterServiceSvc_getCategories * parameters;
- (id)initWithBinding:(UtilityMasterServiceSoapBinding *)aBinding delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(UtilityMasterServiceSvc_getCategories *)aParameters
;
@end
@interface UtilityMasterServiceSoapBinding_updateProductCategory : UtilityMasterServiceSoapBindingOperation {
	UtilityMasterServiceSvc_updateProductCategory * parameters;
}
@property (strong) UtilityMasterServiceSvc_updateProductCategory * parameters;
- (id)initWithBinding:(UtilityMasterServiceSoapBinding *)aBinding delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(UtilityMasterServiceSvc_updateProductCategory *)aParameters
;
@end
@interface UtilityMasterServiceSoapBinding_updateProductSubCategory : UtilityMasterServiceSoapBindingOperation {
	UtilityMasterServiceSvc_updateProductSubCategory * parameters;
}
@property (strong) UtilityMasterServiceSvc_updateProductSubCategory * parameters;
- (id)initWithBinding:(UtilityMasterServiceSoapBinding *)aBinding delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(UtilityMasterServiceSvc_updateProductSubCategory *)aParameters
;
@end
@interface UtilityMasterServiceSoapBinding_deleteTaxDetails : UtilityMasterServiceSoapBindingOperation {
	UtilityMasterServiceSvc_deleteTaxDetails * parameters;
}
@property (strong) UtilityMasterServiceSvc_deleteTaxDetails * parameters;
- (id)initWithBinding:(UtilityMasterServiceSoapBinding *)aBinding delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(UtilityMasterServiceSvc_deleteTaxDetails *)aParameters
;
@end
@interface UtilityMasterServiceSoapBinding_deleteLocation : UtilityMasterServiceSoapBindingOperation {
	UtilityMasterServiceSvc_deleteLocation * parameters;
}
@property (strong) UtilityMasterServiceSvc_deleteLocation * parameters;
- (id)initWithBinding:(UtilityMasterServiceSoapBinding *)aBinding delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(UtilityMasterServiceSvc_deleteLocation *)aParameters
;
@end
@interface UtilityMasterServiceSoapBinding_createCurrency : UtilityMasterServiceSoapBindingOperation {
	UtilityMasterServiceSvc_createCurrency * parameters;
}
@property (strong) UtilityMasterServiceSvc_createCurrency * parameters;
- (id)initWithBinding:(UtilityMasterServiceSoapBinding *)aBinding delegate:(id<UtilityMasterServiceSoapBindingResponseDelegate>)aDelegate
	parameters:(UtilityMasterServiceSvc_createCurrency *)aParameters
;
@end
@interface UtilityMasterServiceSoapBinding_envelope : NSObject {
}
+ (UtilityMasterServiceSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface UtilityMasterServiceSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (strong) NSArray *headers;
@property (strong) NSArray *bodyParts;
@property (strong) NSError *error;
@end
