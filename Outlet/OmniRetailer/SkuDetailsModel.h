//
//  SkuDetailsModel.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 5/28/16.
//
//

#import <Foundation/Foundation.h>

@interface SkuDetailsModel : NSObject
{
    NSString * skuID;
    NSString * description;
    NSString * category;
    NSString * subCategory;
    float reorderPoint;
    BOOL skuItemStatus;
    NSString * productId;
    NSString * sell_UOM;
    float	buy_price;
    float price;
    NSString * taxCode;
    float stock;
    NSString * ean;
    NSString * productName;
    NSString * pluCode;
    NSString * model;
    NSString * status;
    NSString * make;
    float quantity;
    float cost;
    NSString *groupId;
    float offerPrice;
}

@property (nonatomic, strong) NSString * skuID;
@property (nonatomic, strong) NSString * category;
@property (nonatomic, strong) NSString * subCategory;
@property (nonatomic) float reorderPoint;
@property (nonatomic) BOOL skuItemStatus;
@property (nonatomic, strong) NSString * productId;
@property (nonatomic, strong) NSString * sell_UOM;
@property (nonatomic) float	buy_price;
@property (nonatomic) float price;
@property (nonatomic, strong) NSString * taxCode;
@property (nonatomic) float stock;
@property (nonatomic, strong) NSString * ean;
@property (nonatomic, strong) NSString * productName;
@property (nonatomic, strong) NSString * pluCode;
@property (nonatomic, strong) NSString * model;
@property (nonatomic, strong) NSString * status;
@property (nonatomic, strong) NSString * make;
@property (nonatomic) float quantity;
@property (nonatomic) float cost;
@property(nonatomic,strong) NSString *groupId;
@property(nonatomic) float offerPrice;
@end
