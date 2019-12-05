//
//  OfferModel.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 5/27/16.
//
//

#import "OfferModel.h"

@implementation OfferModel
@synthesize     offerID,
offerName,
offerDescription,
offerCategory,
storeLocation,
priority_int,
offerStatus_int,
claimCoupons_int,
claimLoyaltypoints_int,
claimgiftvouchers_int,
sellProducts,
sellSkuids,
productCategory,
rewardType,
sellPluCode,

productSubCategory,
lowestPriceItem,
updated_date,
offerStartDate,
offerEndDate,
startIndex,
priority,
offerStatus,
claimCoupons,
claimLoyaltypoints,
claimgiftvouchers,
datesExclusive,
offerRangesList,
//    private List<Offer> offerList,
//    private List<String> offerIdList,
//    imageRequired,
//    private CustomerFilter customerFilter,

searchText,
searchCriteria,
totalRecords,
skuId,
itemName,
price,
offerImageText,
offerImageTextFont,
offerImageSize,
offerImageColor,
//    integer offerImageBold,
//    integer offerImageItalic,
//    integer offerImageStrike,
salePriceText,
salePriceFont,
salePriceSize,
salePriceColor,
//    integer salePriceBold,
//    integer salePriceItalic,
//    integer salePriceStrike,
offerPriceText,
offerPriceFont,
offerPriceSize,
offerPriceColor,
//    integer offerPriceBold,
//    integer offerPriceItalic,
//    integer offerPriceStrike,
//    isBanner,

authorisedBy,
closedBy,
//    private Date closedOn,
closedReason,

allowMultipleDiscounts,

offerStartTime,
offerEndTime,
day1,
day2,
day3,
day4,
day5,
day6,
day7,
repeat,
sellGroupId,

closedOnStr,
offerStartTimeStr,
offerEndTimeStr,

//added by Srinivasulu on 08/09/2017....

//private boolean priceBasedConfigurationFlag;

priceBasedConfigurationFlag,
isProductSpecificFlag,
//upto here on 08/09/2017....

maxRecords,
searchKey,

//    private List<String> skusList,

webSiteRequest,
offerImageStr,
combo,
skusList,
employeeSpecific;


@end
