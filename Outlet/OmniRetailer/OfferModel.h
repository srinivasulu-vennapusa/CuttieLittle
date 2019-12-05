//
//  OfferModel.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 5/27/16.
//
//

#import <Foundation/Foundation.h>

@interface OfferModel : NSObject
{
    NSString*offerID;
    NSString*offerName;
    NSString*offerDescription;
    NSString*offerCategory;
    NSString*storeLocation;
    int priority_int;
    int offerStatus_int;
    int claimCoupons_int;
    int claimLoyaltypoints_int;
    int claimgiftvouchers_int;
    NSString*sellProducts;
    NSString*sellSkuids;
    NSString*productCategory;
    NSString*rewardType;
    NSString*sellPluCode;
    
    NSString*productSubCategory;
    BOOL lowestPriceItem;
    BOOL combo;
    NSString*updated_date;
    NSString*offerStartDate;
    NSString*offerEndDate;
    NSString*startIndex;
    NSString*priority;
    NSString*offerStatus;
    NSString*claimCoupons;
    NSString*claimLoyaltypoints;
    NSString*claimgiftvouchers;
    NSString*datesExclusive;
    NSMutableArray * offerRangesList;
    //    private List<Offer> offerList;
    //    private List<String> offerIdList;
    //    BOOL imageRequired;
    //    private CustomerFilter customerFilter;
    
    NSString*searchText;
    NSString*searchCriteria;
    int totalRecords;
    NSString*skuId;
    NSString*itemName;
    float price;
    NSString*offerImageText;
    NSString*offerImageTextFont;
    NSString*offerImageSize;
    NSString*offerImageColor;
    //    integer offerImageBold;
    //    integer offerImageItalic;
    //    integer offerImageStrike;
    NSString*salePriceText;
    NSString*salePriceFont;
    NSString*salePriceSize;
    NSString*salePriceColor;
    //    integer salePriceBold;
    //    integer salePriceItalic;
    //    integer salePriceStrike;
    NSString*offerPriceText;
    NSString*offerPriceFont;
    NSString*offerPriceSize;
    NSString*offerPriceColor;
    //    integer offerPriceBold;
    //    integer offerPriceItalic;
    //    integer offerPriceStrike;
    //    BOOL isBanner;
    
    NSString*authorisedBy;
    NSString*closedBy;
    //    private Date closedOn;
    NSString*closedReason;
    
    BOOL allowMultipleDiscounts;
    
    NSString*offerStartTime;
    NSString*offerEndTime;
    BOOL day1;
    BOOL day2;
    BOOL day3;
    BOOL day4;
    BOOL day5;
    BOOL day6;
    BOOL day7;
    BOOL repeat;
    NSString*sellGroupId;
    
    NSString*closedOnStr;
    NSString*offerStartTimeStr;
    NSString*offerEndTimeStr;
    
    
    NSString* maxRecords;
    NSString*searchKey;
    
    NSMutableArray *skusList;
    
    BOOL webSiteRequest;
    NSString*offerImageStr;
    
    BOOL employeeSpecific;
    
    //    private List<SkuPriceList> skuPriceList;
    
    //added by Srinivasulu on 08/09/2017....
    
    BOOL priceBasedConfigurationFlag;
    BOOL isProductSpecificFlag;

    //upto here on 08/09/2017....
    
}

@property (nonatomic, strong) NSString*offerID;
@property (nonatomic, strong) NSString*offerName;
@property (nonatomic, strong) NSString*offerDescription;
@property (nonatomic, strong) NSString*offerCategory;
@property (nonatomic, strong) NSString*storeLocation;
@property (nonatomic) int priority_int;
@property (nonatomic) int offerStatus_int;
@property (nonatomic) int claimCoupons_int;
@property (nonatomic) int claimLoyaltypoints_int;
@property (nonatomic) int claimgiftvouchers_int;
@property (nonatomic, strong) NSString*sellProducts;
@property (nonatomic, strong) NSString*sellSkuids;
@property (nonatomic, strong) NSString*productCategory;
@property (nonatomic, strong) NSString*rewardType;
@property (nonatomic, strong) NSString*sellPluCode;

@property (nonatomic, strong) NSString*productSubCategory;
@property (nonatomic) BOOL lowestPriceItem;
@property (nonatomic) BOOL combo;
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

@property (nonatomic) BOOL allowMultipleDiscounts;

@property (nonatomic, strong) NSString*offerStartTime;
@property (nonatomic, strong) NSString*offerEndTime;
@property (nonatomic) BOOL day1;
@property (nonatomic) BOOL day2;
@property (nonatomic) BOOL day3;
@property (nonatomic) BOOL day4;
@property (nonatomic) BOOL day5;
@property (nonatomic) BOOL day6;
@property (nonatomic) BOOL day7;
@property (nonatomic) BOOL repeat;
@property (nonatomic,strong) NSString*sellGroupId;

@property (nonatomic, strong) NSString*closedOnStr;
@property (nonatomic, strong) NSString*offerStartTimeStr;
@property (nonatomic, strong) NSString*offerEndTimeStr;


@property (nonatomic, strong) NSString* maxRecords;
@property (nonatomic, strong) NSString*searchKey;
@property (nonatomic) BOOL webSiteRequest;
@property (nonatomic, strong) NSString*offerImageStr;
@property (nonatomic, strong) NSMutableArray * offerRangesList;
@property (nonatomic, strong) NSMutableArray * skusList;
@property(nonatomic) BOOL employeeSpecific;

//added by Srinivasulu on 08/09/2017....

//private boolean priceBasedConfigurationFlag;
@property (nonatomic) BOOL priceBasedConfigurationFlag;
@property (nonatomic) BOOL isProductSpecificFlag;

//upto here on 08/09/2017....


@end
