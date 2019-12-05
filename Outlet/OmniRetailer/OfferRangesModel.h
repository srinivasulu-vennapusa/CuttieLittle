//
//  OfferRangesModel.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 5/27/16.
//
//

#import <Foundation/Foundation.h>

@interface OfferRangesModel : NSObject

{
    NSString * offerId;
    NSString * range;
    float minimumPurchaseQuantity;
    float minimumPurchaseamount;
    float rewardValue;
    NSString * groupId;
    NSString * itemId;
    NSString * rangeRewardType;
    NSString * rangeMode;
    float rewardQty;
    NSString * minimumPurchaseQuantityString;
    NSString * minimumPurchaseamountString;
    NSString * rewardValueString;
    NSMutableArray *itemsList;
    
    
    //added by Srinivasulu on 17/08/2017....
    
    float startRangePrice;
    float endRangePrice;
    
    //upto here on 17/08/2017....
    
    //added by Srinivasulu on 08/09/2017....
   
    NSMutableArray * groupItemsList;

    //upto here on 08/09/2017....

}

@property (nonatomic, strong) NSString * offerId;
@property (nonatomic, strong) NSString * range;
@property (nonatomic) float minimumPurchaseQuantity;
@property (nonatomic) float minimumPurchaseamount;
@property (nonatomic) float rewardValue;
@property (nonatomic, strong) NSString * groupId;
@property (nonatomic, strong) NSString * itemId;
@property (nonatomic, strong) NSString * rangeRewardType;
@property (nonatomic, strong) NSString * rangeMode;
@property (nonatomic) float rewardQty;
@property (nonatomic, strong) NSString * minimumPurchaseQuantityString;
@property (nonatomic, strong) NSString * minimumPurchaseamountString;
@property (nonatomic, strong) NSString * rewardValueString;
@property (nonatomic, strong) NSMutableArray *itemsList;

//added by Srinivasulu on 17/08/2017....

@property (nonatomic) float startRangePrice;
@property (nonatomic) float endRangePrice;

//upto here on 17/08/2017....


//added by Srinivasulu on 08/09/2017....

@property (nonatomic, strong) NSMutableArray *  groupItemsList;

//upto here on 08/09/2017....

@end
