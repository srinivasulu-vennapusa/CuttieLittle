//
//  OfferProducts.h
//  OmniRetailer
//
//  Created by Technolabs on 10/23/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OfferProducts : NSObject
{
   
    NSString * offerId;
    NSString * skuId;
    NSString * plucode;
    NSString * itemDesc;
    NSString * category;
    NSString * subCategory;
    NSString * brand;
    NSString * section;
    NSString * department;
    NSString * model;
    NSString * ean;
    NSString * size;
    NSString * discountType;
    
    float rewardValue;
    float rewardQty;
    float minPurchaseQty;
}
@property (nonatomic, strong) NSString * offerId;
@property (nonatomic, strong) NSString * skuId;
@property (nonatomic, strong) NSString * plucode;
@property (nonatomic, strong) NSString * itemDesc;
@property (nonatomic, strong) NSString * category;
@property (nonatomic, strong) NSString * subCategory;
@property (nonatomic, strong) NSString * brand;
@property (nonatomic, strong) NSString * section;
@property (nonatomic, strong) NSString * department;
@property (nonatomic, strong) NSString * model;
@property (nonatomic, strong) NSString * ean;
@property (nonatomic, strong) NSString * size;
@property (nonatomic, strong) NSString * discountType;

@property (nonatomic) float rewardValue;
@property (nonatomic) float rewardQty;
@property (nonatomic) float minPurchaseQty;


@end

NS_ASSUME_NONNULL_END
