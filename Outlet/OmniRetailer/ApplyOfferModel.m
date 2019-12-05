//
//  ApplyOfferModel.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 5/27/16.
//
//

#import "ApplyOfferModel.h"

@implementation ApplyOfferModel
@synthesize     offerID,

offerName,
offerDescription,
offerCategory,
claimCoupons_int,
claimLoyaltypoints_int,
claimgiftvouchers_int,
sellProducts,
rewardType,
sellSkuids,
offerRangesList,
repeat,
sellGroupID,
allowMultipleDiscounts,

combo,
lowestPriceItem,


//added by Srinivasulu on 08/09/2017....
priority_int,
//private boolean priceBasedConfigurationFlag;

priceBasedConfigurationFlag,
isProductSpecificFlag,
offerProductsList,
//upto here on 08/09/2017....

minimumPurchaseQty,
minimumPurchaseAmt,
rewardValue,
sellSkusList,employeeSpecific;

@end
