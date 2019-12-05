//
//  DealModel.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 5/27/16.
//
//

#import <Foundation/Foundation.h>

@interface DealModel : NSObject
{
    NSString * dealID;
    NSString * dealName;
    NSString * dealDescription;
    NSString * dealCategory;
    NSString * storeLocation;
    int priority_int;
    int dealStatus_int;
    int claimCoupons_int;
    int claimLoyaltypoints_int;
    int claimgiftvouchers_int;
    NSString * sellProducts;
    NSString * sellSkuids;
    NSString * dealSkus;
    NSString * dealProducts;
    NSString * dealPluCode;
    NSString * sellPluCode;
    NSString * dealImageText;
    NSString * dealImageTextFont;
    NSString * dealImageSize;
    NSString * dealImageColor;
    NSString * salePriceText;
    NSString * salePriceFont;
    NSString * salePriceSize;
    NSString * salePriceColor;
    NSString * dealPriceText;
    NSString * dealPriceFont;
    NSString * dealPriceSize;
    NSString * dealPriceColor;
    BOOL imageDeleted;
    BOOL isBanner;
    NSString * authorisedBy;
    NSString * closedBy;
    NSString * closedReason;
    BOOL allowMultipleDiscounts;
    NSString * dealGroupId;
    NSString * dealStartTime;
    NSString * dealEndTime;
    NSString * dealStartDate;
    NSString * dealEndDate;
    BOOL day1;
    BOOL day2;
    BOOL day3;
    BOOL day4;
    BOOL day5;
    BOOL day6;
    BOOL day7;
    BOOL repeat;
    NSString * sellGroupId;
    NSString * saleProductCategory;
    NSString * saleProductSubCategory;
    NSString * dealProductCategory;
    NSString * dealProductSubCategory;
    BOOL combo;
    BOOL lowestPriceItem;
    NSMutableArray * dealSkuList;
    NSString * searchKey;
    NSString *maxRecords;
    NSMutableArray * skusList;
    NSMutableArray * rangesList;
    
    BOOL employeeSpecific;
    
    //-*-*
    NSString * closedOnStr;
    BOOL ispluSpecificDeal;

}

@property (nonatomic, strong) NSString * dealID;
@property (nonatomic, strong) NSString * dealName;
@property (nonatomic, strong) NSString * dealDescription;
@property (nonatomic, strong) NSString * dealCategory;
@property (nonatomic, strong) NSString * storeLocation;
@property (nonatomic) int priority_int;
@property (nonatomic) int dealStatus_int;
@property (nonatomic) int claimCoupons_int;
@property (nonatomic) int claimLoyaltypoints_int;
@property (nonatomic) int claimgiftvouchers_int;
@property (nonatomic, strong) NSString * sellProducts;
@property (nonatomic, strong) NSString * sellSkuids;
@property (nonatomic, strong) NSString * dealSkus;
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
@property (nonatomic) BOOL allowMultipleDiscounts;
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
@property (nonatomic) BOOL repeat;
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
@property(nonatomic) BOOL employeeSpecific;

//-*-*
@property (nonatomic, strong) NSString * closedOnStr;
@property(nonatomic) BOOL ispluSpecificDeal;

@end
