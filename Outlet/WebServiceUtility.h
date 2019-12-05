//
//  WebServiceUtility.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 9/2/15.
//
//

#import <Foundation/Foundation.h>

@interface WebServiceUtility : NSObject
{
    NSString *turnOverFreeItem;
    int unAppliedDealId;
}
+ (NSString *)getURLFor:(int)type;
+ (NSString *)addPercentEscapesFor:(NSString *)inputString;

//changed by Srinivasulu on 27/09/2017....
//reason otherDiscount need to be handled....

//+ (NSMutableArray *)getBillingItemsFrom:(NSString *)itemString itemDiscountArr:(NSMutableArray *)itemDiscountArr itemDiscountDescArr:(NSMutableArray *)itemDiscountDescArr offerPriceArray:(NSMutableArray *)offerPriceArray dealPriceArray:(NSMutableArray *)dealPriceArray itemScanCode:(NSMutableArray *)itemScanCode turnOverOffer:(float)turnOverOfferVal totalPriceBeforeTurnOver:(float)totalPriceBeforeTurnOver salesPersonInfo:(NSDictionary*)salesPersonInfo manufacturedItems:(NSArray*)manufacturedItemsArr packagedItemsArr:(NSArray*)packagedItemsArr productInfoArr:(NSArray*)productInfoArr;

+ (NSMutableArray *)getBillingItemsFrom:(NSString *)itemString itemDiscountArr:(NSMutableArray *)itemDiscountArr itemDiscountDescArr:(NSMutableArray *)itemDiscountDescArr offerPriceArray:(NSMutableArray *)offerPriceArray dealPriceArray:(NSMutableArray *)dealPriceArray itemScanCode:(NSMutableArray *)itemScanCode turnOverOffer:(float)turnOverOfferVal totalPriceBeforeTurnOver:(float)totalPriceBeforeTurnOver salesPersonInfo:(NSDictionary*)salesPersonInfo manufacturedItems:(NSArray*)manufacturedItemsArr packagedItemsArr:(NSArray*)packagedItemsArr productInfoArr:(NSArray*)productInfoArr  otherDiscountValue:(NSString *)otherDiscountValueStr;


//upto here on 27/09/2017.....

+ (NSString *)getCurrentDate;
+ (NSString *)addDays:(NSInteger)days toDate:(NSDate *)originalDate;
+ (NSString *)updateBussinessDate;

+ (NSString *)getStoreAddress;
+ (NSString *)getServiceURL;
+(void)setFontFamily:(NSString*)fontFamily forView:(UIView*)view andSubViews:(BOOL)isSubViews fontSize:(float)fontSize cornerRadius:(float)cornerRadius;

+ (BOOL)checkEditPriceEnabled;
+ (BOOL)checkDateValidity:(NSString *)startDate secondDate:(NSString *)endDate;
+ (BOOL)checkIsCardPayment:(UIView *)cardView;
+ (NSInteger)numberOfDaysDifference:(NSDate *)aDate;
+ (NSMutableArray *)getBillingItemsTaxDetails:(NSMutableArray *)itemArray taxArr:(NSMutableArray *)taxArr currentDate:(NSString *)currentDate offerPriceArray:(NSMutableArray *)offerPriceArray dealPriceArray:(NSMutableArray *)dealPriceArray;
+(NSMutableArray *)getBillingItemTaxes:(NSMutableArray *)itemArray taxArr:(NSMutableArray *)taxArr;
+ (int)calculateNumberOfSecondsfor:(NSString *)startDate and:(NSString *)endDate;
+(int)getTodayWeekDayNumber;
+(BOOL)checkOfferAvailabilityBetween:(NSString *)startTime endTime:(NSString *)endTime;
+ (BOOL)checkWhetherItemSpecificItemContainsInCart:(NSMutableArray *)itemDiscountArr isVoidedArray:(NSMutableArray *)isVoidedArray;
+ (NSMutableArray *)getBillingItemsCampaignsInfo:(NSString *)itemString  offerPriceArray:(NSMutableArray *)offerPriceArray dealPriceArray:(NSMutableArray *)dealPriceArray dealIdsArr:(NSArray*)dealIdsArr offerIdsArr:(NSArray*)offerIdsArr turnOverOffer:(float)turnOverOfferVal totalPriceBeforeTurnOver:(float)totalPriceBeforeTurnOver;

+ (NSMutableArray *)getMessagesFromPositon:(int)position fromArray:(NSMutableArray *)messageArray;
+ (int)getTotalNumberOfPages:(int)totalRecords;

+(BOOL)checkAcessControlForMain:(NSString*)appFlow;
+(int)checkAccessPermissionsFor:(NSString*)appDoc subFlow:(NSString*)subFlow mainFlow:(NSString*)mainFlow;
+(int)checkAccessibilityFor:(NSString*)activity appDocument:(NSString*)appDocument ;
+(NSString*)getFooter;


//method added by Srinivasulu on 07/02/2017....
+ (UIImage *)getLogoImage;


+(NSString *)getPreviousDate:(double)timeInterval;


// added by roja on 09/01/2019...
+(id)getPropertyFromProperties:(NSString*)key;
+(CGRect)setTableViewheightOfTable :(UITableView *)tableView ByArrayName:(NSArray *)array;
+(BOOL)validateEmail: (NSString *) email;
+(UIColor *)UIColorFromNSString:(NSString*)string;


// upto here added by roja on 09/01/2019...

@end
