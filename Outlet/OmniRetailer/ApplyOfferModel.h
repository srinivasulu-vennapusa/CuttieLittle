//
//  ApplyOfferModel.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 5/27/16.
//
//

#import <Foundation/Foundation.h>

@interface ApplyOfferModel : NSObject
{
    NSString * offerID;
    
    NSString * offerName;
    NSString * offerDescription;
    NSString * offerCategory;
    int claimCoupons_int;
    int claimLoyaltypoints_int;
    int claimgiftvouchers_int;
    NSString * sellProducts;
    NSString * rewardType;
    NSString * sellSkuids;
    NSMutableArray * offerRangesList;
    BOOL repeat;
    NSString * sellGroupID;
    BOOL allowMultipleDiscounts;
    
    BOOL combo;
    BOOL lowestPriceItem;
    
    /* for sorting the offers based on the quantity and  */
    float minimumPurchaseQty;
    float minimumPurchaseAmt;
    float rewardValue;
    int priority_int;
    BOOL employeeSpecific;
    
    
    //added by Srinivasulu on 08/09/2017....
    
    BOOL priceBasedConfigurationFlag;
    BOOL isProductSpecificFlag;
    NSMutableArray * offerProductsList;
    //upto here on 08/09/2017....

}
@property (nonatomic, strong) NSString * offerID;
@property (nonatomic, strong) NSString * offerName;
@property (nonatomic, strong) NSString * offerDescription;
@property (nonatomic, strong) NSString * offerCategory;
@property (nonatomic) int claimCoupons_int;
@property (nonatomic) int claimLoyaltypoints_int;
@property (nonatomic) int claimgiftvouchers_int;
@property (nonatomic, strong) NSString * sellProducts;
@property (nonatomic, strong) NSString * rewardType;
@property (nonatomic, strong) NSString * sellSkuids;
@property (nonatomic, strong) NSMutableArray * offerRangesList;
@property (nonatomic, strong) NSMutableArray * sellSkusList;
@property (nonatomic) BOOL repeat;
@property (nonatomic, strong) NSString * sellGroupID;
@property (nonatomic) BOOL allowMultipleDiscounts;

@property (nonatomic) BOOL combo;
@property (nonatomic) BOOL lowestPriceItem;

/* for sorting the offers based on the quantity and  */
@property (nonatomic) float minimumPurchaseQty;
@property (nonatomic) float minimumPurchaseAmt;
@property (nonatomic) float rewardValue;
@property (nonatomic) int priority_int;
@property(nonatomic) BOOL employeeSpecific;


@property (nonatomic, strong) NSString*storeLocation;

@property (nonatomic, strong) NSString*productCategory;
@property (nonatomic, strong) NSString*sellPluCode;

@property (nonatomic, strong) NSString*productSubCategory;
@property (nonatomic, strong) NSString*updated_date;
@property (nonatomic, strong) NSString*offerStartDate;
@property (nonatomic, strong) NSString*offerEndDate;
@property (nonatomic, strong) NSString*startIndex;
@property (nonatomic, strong) NSString*priority;
@property (nonatomic, strong) NSString*offerStatus;
@property (nonatomic, strong) NSString*claimCoupons;
@property (nonatomic, strong) NSString*claimLoyaltypoints;
@property (nonatomic, strong) NSString*claimgiftvouchers;
@property (nonatomic, strong) NSString*datesExclusive;
@property (nonatomic, strong) NSString*searchText;
@property (nonatomic, strong) NSString*searchCriteria;
@property (nonatomic) int totalRecords;
@property (nonatomic, strong) NSString*skuId;
@property (nonatomic, strong) NSString*itemName;
@property (nonatomic) float price;
@property (nonatomic, strong) NSString*offerImageText;
@property (nonatomic, strong) NSString*offerImageTextFont;
@property (nonatomic, strong) NSString*offerImageSize;
@property (nonatomic, strong) NSString*offerImageColor;
@property (nonatomic, strong) NSString*salePriceText;
@property (nonatomic, strong) NSString*salePriceFont;
@property (nonatomic, strong) NSString*salePriceSize;
@property (nonatomic, strong) NSString*salePriceColor;
@property (nonatomic, strong) NSString*offerPriceText;
@property (nonatomic, strong) NSString*offerPriceFont;
@property (nonatomic, strong) NSString*offerPriceSize;
@property (nonatomic, strong) NSString*offerPriceColor;

@property (nonatomic, strong) NSString*authorisedBy;
@property (nonatomic, strong) NSString*closedBy;
@property (nonatomic, strong) NSString*closedReason;


@property (nonatomic, strong) NSString*offerStartTime;
@property (nonatomic, strong) NSString*offerEndTime;
@property (nonatomic) BOOL day1;
@property (nonatomic) BOOL day2;
@property (nonatomic) BOOL day3;
@property (nonatomic) BOOL day4;
@property (nonatomic) BOOL day5;
@property (nonatomic) BOOL day6;
@property (nonatomic) BOOL day7;
@property (nonatomic,strong) NSString*sellGroupId;

@property (nonatomic, strong) NSString*closedOnStr;
@property (nonatomic, strong) NSString*offerStartTimeStr;
@property (nonatomic, strong) NSString*offerEndTimeStr;



//added by Srinivasulu on 08/09/2017....

//private boolean priceBasedConfigurationFlag;
@property (nonatomic) BOOL priceBasedConfigurationFlag;
@property (nonatomic) BOOL isProductSpecificFlag;
@property (nonatomic, strong) NSMutableArray * offerProductsList;
//upto here on 08/09/2017....






@end
