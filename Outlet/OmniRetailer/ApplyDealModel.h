//
//  ApplyDealModel.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 5/27/16.
//
//

#import <Foundation/Foundation.h>
@interface ApplyDealModel : NSObject

{
    NSString * dealID;
    NSString * dealName;
    NSString * dealDescription;
    NSString * dealCategory;
    int claimCoupons_int;
    int claimLoyaltypoints_int;
    int claimgiftvouchers_int;
    NSString * sellProducts;
    NSString * sellSkuids;
    NSString * dealSkus;
    NSMutableArray * rangeList;
    BOOL repeat;
    NSString * sellGroupID;
    BOOL allowMultipleDiscounts;
    float minimumPurchaseQty;
    float minimumPurchaseAmt;
    float rewardValue;
    BOOL employeeSpecific;
    
    //-*-*
    NSString * dealPluCode;
    NSString * sellPluCode;
    BOOL ispluSpecificDeal;

}

@property (nonatomic, strong) NSString * dealID;
@property (nonatomic, strong) NSString * dealName;
@property (nonatomic, strong) NSString * dealDescription;
@property (nonatomic, strong) NSString * dealCategory;
@property (nonatomic) int claimCoupons_int;
@property (nonatomic) int claimLoyaltypoints_int;
@property (nonatomic) int claimgiftvouchers_int;
@property (nonatomic, strong) NSString * sellProducts;
@property (nonatomic, strong) NSString * sellSkuids;
@property (nonatomic, strong) NSString * dealSkus;
@property (nonatomic, strong) NSMutableArray * rangeList;
@property (nonatomic) BOOL repeat;
@property (nonatomic, strong) NSString * sellGroupID;
@property (nonatomic) BOOL allowMultipleDiscounts;
@property (nonatomic) float minimumPurchaseQty;
@property (nonatomic) float minimumPurchaseAmt;
@property (nonatomic) float rewardValue;
@property (nonatomic) int priority_int;
@property(nonatomic) BOOL employeeSpecific;

@property (nonatomic, strong) NSString * storeLocation;
@property (nonatomic, strong) NSString * dealProducts;
@property (nonatomic, strong) NSString * dealPluCode;
@property (nonatomic, strong) NSString * sellPluCode;
@property (nonatomic, strong) NSString * dealImageText;
@property (nonatomic, strong) NSString * dealImageTextFont;
@property (nonatomic, strong) NSString * dealImageSize;
@property (nonatomic, strong) NSString * dealImageColor;
@property (nonatomic, strong) NSString * salePriceText;
@property (nonatomic, strong) NSString * salePriceFont;
@property (nonatomic, strong) NSString * salePriceSize;
@property (nonatomic, strong) NSString * salePriceColor;
@property (nonatomic, strong) NSString * dealPriceText;
@property (nonatomic, strong) NSString * dealPriceFont;
@property (nonatomic, strong) NSString * dealPriceSize;
@property (nonatomic, strong) NSString * dealPriceColor;
@property (nonatomic) BOOL imageDeleted;
@property (nonatomic) BOOL isBanner;
@property (nonatomic, strong) NSString * authorisedBy;
@property (nonatomic, strong) NSString * closedBy;
@property (nonatomic, strong) NSString * closedReason;
@property (nonatomic, strong) NSString * dealGroupId;
@property (nonatomic, strong) NSString * dealStartTime;
@property (nonatomic, strong) NSString * dealEndTime;
@property (nonatomic, strong) NSString * dealStartDate;
@property (nonatomic, strong) NSString * dealEndDate;
@property (nonatomic) BOOL day1;
@property (nonatomic) BOOL day2;
@property (nonatomic) BOOL day3;
@property (nonatomic) BOOL day4;
@property (nonatomic) BOOL day5;
@property (nonatomic) BOOL day6;
@property (nonatomic) BOOL day7;
@property (nonatomic, strong) NSString * sellGroupId;
@property (nonatomic, strong) NSString * saleProductCategory;
@property (nonatomic, strong) NSString * saleProductSubCategory;
@property (nonatomic, strong) NSString * dealProductCategory;
@property (nonatomic, strong) NSString * dealProductSubCategory;
@property (nonatomic) BOOL combo;
@property (nonatomic) BOOL lowestPriceItem;
@property (nonatomic, strong) NSMutableArray * dealSkuList;
@property (nonatomic, strong) NSString * searchKey;
@property (nonatomic, strong) NSString *maxRecords;
@property (nonatomic, strong) NSMutableArray * skusList;
@property (nonatomic, strong) NSMutableArray * rangesList;

//-*-*
@property(nonatomic) BOOL ispluSpecificDeal;

@end
