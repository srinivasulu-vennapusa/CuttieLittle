//
//  CampaignRequestModel.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 5/27/16.
//
//

#import <Foundation/Foundation.h>

@interface CampaignRequestModel : NSObject
{
    NSMutableArray* skuIdArrList;
    NSMutableArray* pluCodeArrList;
    NSMutableArray* unitPriceArrList;
    NSMutableArray* qtyArrList;
    NSMutableArray* totalPriceArrList;
    NSMutableArray* itemStatusArrList;
    NSMutableArray* mFreeQtyArrayList;
    NSMutableArray* mProductDealQty;
    //    private List<ArrayList<String>> freeItemLists;
    //    private List<ArrayList<Float>> freeItemQtyLists;
    NSMutableArray* dealDiscount;
    NSMutableArray* mProductDealDescription;
    NSMutableArray* mAllowMultipleDiscounts;
    NSMutableArray* repeatArrayList;
    NSMutableArray* appliedDealIdList;
    NSMutableArray* isDealApplied;
    NSMutableArray* discountPriceStrArrayList;
    NSMutableArray* discountTypeArrayList;
    NSMutableArray* productOptionalDiscountArr;
    NSMutableArray* discountIdArrayList;
    NSMutableArray* mProductOptionalDiscount;
    //    private List<List<ApplyOffer>> mItemOffersList;
    NSMutableArray* mProductOfferPrice;
    //    private List<ApplyOffer> comboList;
    //    private List<ApplyOffer> appliedOffers;
    NSMutableArray* dealSkuListAll;
    NSMutableArray* mProductOfferDescription;
    NSMutableArray* mProductOfferType;
    //    private List<List<Offer>> availableOffers;
    NSMutableArray* isComboApplied;
    NSMutableArray* comboDiscount;
    
    NSString* item_total_price;
    NSString* quantity;
    NSString* totalBillAmount;
    NSString* storeLocation;
    NSString* sku_id;
    NSString* productID;
    NSString* phonenumber;
    NSString* purchaseChannel;
    NSString *employeeCode;
    
    //-*-*
    NSMutableArray * flatOfferForAllItemsList;
    
}

@property (nonatomic, strong) NSMutableArray* skuIdArrList;
@property (nonatomic, strong) NSMutableArray* pluCodeArrList;
@property (nonatomic, strong) NSMutableArray* unitPriceArrList;
@property (nonatomic, strong) NSMutableArray* qtyArrList;
@property (nonatomic, strong) NSMutableArray* totalPriceArrList;
@property (nonatomic, strong) NSMutableArray* itemStatusArrList;
@property (nonatomic, strong) NSMutableArray* mFreeQtyArrayList;
@property (nonatomic, strong) NSMutableArray* mProductDealQty;
//    private List<ArrayList<String>> freeItemLists;
//    private List<ArrayList<Float>> freeItemQtyLists;
@property (nonatomic, strong) NSMutableArray* dealDiscount;
@property (nonatomic, strong) NSMutableArray* mProductDealDescription;
@property (nonatomic, strong) NSMutableArray* mAllowMultipleDiscounts;
@property (nonatomic, strong) NSMutableArray* repeatArrayList;
@property (nonatomic, strong) NSMutableArray* appliedDealIdList;
@property (nonatomic, strong) NSMutableArray* isDealApplied;
@property (nonatomic, strong) NSMutableArray* discountPriceStrArrayList;
@property (nonatomic, strong) NSMutableArray* discountTypeArrayList;
@property (nonatomic, strong) NSMutableArray* productOptionalDiscountArr;
@property (nonatomic, strong) NSMutableArray* discountIdArrayList;
@property (nonatomic, strong) NSMutableArray* mProductOptionalDiscount;
//    private List<List<ApplyOffer>> mItemOffersList;
@property (nonatomic, strong) NSMutableArray* mProductOfferPrice;
//    private List<ApplyOffer> comboList;
//    private List<ApplyOffer> appliedOffers;
@property (nonatomic, strong) NSMutableArray* dealSkuListAll;
@property (nonatomic, strong) NSMutableArray* mProductOfferDescription;
@property (nonatomic, strong) NSMutableArray* mProductOfferType;
//    private List<List<Offer>> availableOffers;
@property (nonatomic, strong) NSMutableArray* isComboApplied;
@property (nonatomic, strong) NSMutableArray* comboDiscount;

@property (nonatomic, strong) NSString* item_total_price;
@property (nonatomic, strong) NSString* quantity;
@property (nonatomic, strong) NSString* totalBillAmount;
@property (nonatomic, strong) NSString* storeLocation;
@property (nonatomic, strong) NSString* sku_id;
@property (nonatomic, strong) NSString* productID;
@property (nonatomic, strong) NSString* phonenumber;
@property (nonatomic, strong) NSString* purchaseChannel;

@property(nonatomic,strong) NSString *department;
@property(nonatomic,strong) NSString *subDepartment;

@property(nonatomic,strong) NSString *skuId;

@property(nonatomic,strong) NSString *employeeCode;
//-*-*
@property(nonatomic,strong) NSString * pluCodeStr;
@property (nonatomic, strong) NSMutableArray * flatOfferForAllItemsList;

@end
