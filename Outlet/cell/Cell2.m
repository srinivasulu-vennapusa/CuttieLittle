//
//  DiYuCell2.m
//  IYLM
//
//  Created by JianYe on 13-1-11.
//  Copyright (c) 2013年 Jian-Ye. All rights reserved.
//

#import "Cell2.h"

@implementation Cell2
@synthesize titleLabel;
@synthesize priceLabel;
@synthesize titleImage;
@synthesize piecesLabel,orderedQtyLabel;
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

@end
