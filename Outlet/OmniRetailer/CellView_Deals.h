//
//  CellView_Deals.h
//  OmniRetailer
//
//  Created by Bangaru.Raju on 11/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CellView_Deals : UITableViewCell {
   
    IBOutlet UILabel* itemName;
    IBOutlet UILabel* offerId;    
    IBOutlet UILabel* OfferPrice;    
    IBOutlet UILabel* validFrom;    
    IBOutlet UILabel* validTo;
    IBOutlet UILabel* minAmt;
    IBOutlet UILabel* minQty;    
    IBOutlet UILabel* giftSKU;
    
    
}


@property (nonatomic, strong) UILabel* itemName;
@property (nonatomic, strong) UILabel* offerId;
@property (nonatomic, strong) UILabel* OfferPrice;
@property (nonatomic, strong) UILabel* validFrom;
@property (nonatomic, strong) UILabel* validTo;
@property (nonatomic, strong) UILabel* minAmt;
@property (nonatomic, strong) UILabel* minQty;
@property (nonatomic, strong) UILabel* giftSKU;
@property (strong, nonatomic) IBOutlet UILabel *minQtyLbl;
@property (strong, nonatomic) IBOutlet UILabel *dealSkuLbl;
@property (strong, nonatomic) IBOutlet UILabel *dealType;


- (void) setItemProperties:(NSString *)_iN _offerId:(NSString *)_OID _OfferPrice:(NSString*)_OP _validFrom:(NSString*)_VF _validTo:(NSString*)_TO _minQty:(NSString *)_MQ _giftSku:(NSString *)_giftSku _desc:(NSString *)_desc;

- (void) setItemProperties:(NSString *)_iN _offerId:(NSString *)_OID _OfferPrice:(NSString*)_OP _validFrom:(NSString*)_VF _validTo:(NSString*)_TO offerType:(NSString *)_OT _offerVal:(NSString *)_offerVal _desc:(NSString *)_desc;

@end
