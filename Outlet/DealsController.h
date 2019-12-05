//
//  DealsController.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 1/6/15.
//
//

#import <Foundation/Foundation.h>

@interface DealsController : NSObject
{
    NSString *product_id;
    NSString *productCount;
    NSMutableDictionary *productData;
    NSMutableArray *dealItemPrice;
    NSMutableArray *dealSkuId;
    NSMutableArray *skuCount;
    BOOL isDealApplied;
}

@property (nonatomic, strong) NSString *product_id;
@property (nonatomic, strong) NSMutableDictionary *productData;
@property (nonatomic, strong) NSString *productCount;
@property (nonatomic, strong) NSMutableArray *dealItemPrice;
@property (nonatomic, strong) NSMutableArray *dealSkuId;
@property (nonatomic, strong) NSMutableArray *skuCount;
@property (nonatomic) BOOL isDealApplied;

@end
