//
//  DealRangesModel.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 5/27/16.
//
//

#import <Foundation/Foundation.h>

@interface DealRangesModel : NSObject
{
    NSString * dealId;
    NSString * range;
    float minimumPurchaseQuantity_float;
    float minimumPurchaseamount_float;
    float dealQuantity_float;
    NSString * groupId;
    NSString * itemId;
    NSString * rangeRewardType;
    NSString * rangeMode;
    NSString * minimumPurchaseQuantity;
    NSString * minimumPurchaseamount;
    NSString * dealQuantity;
}
@property (nonatomic, strong) NSString * dealId;
@property (nonatomic, strong) NSString * range;
@property (nonatomic) float minimumPurchaseQuantity_float;
@property (nonatomic) float minimumPurchaseamount_float;
@property (nonatomic) float dealQuantity_float;
@property (nonatomic, strong) NSString * groupId;
@property (nonatomic, strong) NSString * itemId;
@property (nonatomic, strong) NSString * rangeRewardType;
@property (nonatomic, strong) NSString * rangeMode;
@property (nonatomic, strong) NSString * minimumPurchaseQuantity;
@property (nonatomic, strong) NSString * minimumPurchaseamount;
@property (nonatomic, strong) NSString * dealQuantity;

@end
