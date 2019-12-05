//
//  CellView.m
//  OmniRetailer
//
//  Created by technolabs on 05/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CellView.h"

#import <QuartzCore/QuartzCore.h>


@implementation CellView


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}




- (void)ProductImage:(NSString *)_text {
    
    productImg.image = [UIImage imageNamed:_text];
    
    productImg.tag = 2;
    
    CALayer * l = productImg.layer;
    [l setMasksToBounds:YES];
    l.cornerRadius = 10.0;
    
    // You can even add a border
    //[l setBorderWidth:1.0];
    //[l setBorderColor:[[UIColor whiteColor] CGColor]];
    
}

- (void)ProductLabel:(NSString *)_text {
    
    productLabel.text = _text;
    productLabel.textColor = [UIColor whiteColor];
}

- (void)celBackgroundImage:(BOOL)status{
    backgroundImage.hidden = status;
}

@end
