//
//  CellView_Deals.m
//  OmniRetailer
//
//  Created by Bangaru.Raju on 11/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CellView_Deals.h"


@implementation CellView_Deals

@synthesize itemName,offerId,OfferPrice,validFrom,validTo,minAmt,minQty,giftSKU;
@synthesize dealSkuLbl,minQtyLbl,dealType;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

//- (void)dealloc
//{
//    [super dealloc];
//    [itemName release];
//    [offerId release];
//    [OfferPrice release];
//    [validFrom release];
//    [validTo release];
//    [minAmt release];
//    [minQty release];
//    [giftSKU release];
//
//    
//}


- (void) setItemProperties:(NSString *)_iN _offerId:(NSString *)_OID _OfferPrice:(NSString*)_OP _validFrom:(NSString*)_VF _validTo:(NSString*)_TO _minQty:(NSString *)_MQ _giftSku:(NSString *)_giftSku _desc:(NSString *)_desc{
    
    
    itemName.text = _iN;
    offerId.text = _OID;
    OfferPrice.text = _OP;
    validFrom.text = _VF;
    validTo.text = _TO;
    minAmt.text = _giftSku;
    minQty.text = _MQ;
    giftSKU.text = _desc;
    
}
- (void) setItemProperties:(NSString *)_iN _offerId:(NSString *)_OID _OfferPrice:(NSString*)_OP _validFrom:(NSString*)_VF _validTo:(NSString*)_TO offerType:(NSString *)_OT _offerVal:(NSString *)_offerVal _desc:(NSString *)_desc{
    
    itemName.text = _iN;
    offerId.text = _OID;
    OfferPrice.text = _OP;
    validFrom.text = _VF;
    validTo.text = _TO;
    
    dealType.text = @"Offer Type";
    minQtyLbl.text = @"Offer Type";
    dealSkuLbl.text = @"Offer Value";
    
    minAmt.text = _offerVal;
    minQty.text = _OT;
    giftSKU.text = _desc;
    
}
@end
