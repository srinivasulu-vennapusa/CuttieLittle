//
//  CellView_Order.m
//  OmniRetailer
//
//  Created by Bangaru.Raju on 11/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CellView_Order.h"

@implementation CellView_Order

@synthesize itemId,orderStatus,orderAmount,orderedOn;

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


- (void) setItemProperties:(NSString *)_ID _orderStatus:(NSString *)_OS _orderAmount:(NSString*)_OA _orderedOn:(NSString*)_OO;{
    
    itemId.text = _ID;
    orderStatus.text = _OS;
    orderAmount.text = _OA;
    orderedOn.text = _OO;
    
}

@end
