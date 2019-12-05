//
//  ConfigCellView.m
//  DOCMan
//
//  Created by Satya Siva Saradhi on 28/02/12.
//  Copyright 2012 technolabssoftware.com. All rights reserved.
//

#import "ConfigCellView.h"

#import <QuartzCore/QuartzCore.h>


@implementation ConfigCellView

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



- (void)LabelText:(NSString *)_text{
    cellText.text = _text;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7){
        cellText.textColor = [UIColor whiteColor];
    }
    else{
        cellText.textColor = [UIColor whiteColor];
    }
    
}

- (void)TextColor:(UIColor *)color {
    
    cellText.textColor = color;
}

- (void)ProductImage:(NSString *)_text{
    
    if ([_text.pathExtension isEqualToString:@"png"] && _text.length < 20) {
        productImg.image = [UIImage imageNamed:_text];
    }
    else {
        productImg.image = [UIImage imageWithContentsOfFile:_text];
    }
    
    
    CALayer * l = productImg.layer;
    [l setMasksToBounds:YES];
    l.cornerRadius = 10.0;
    
    // You can even add a border
    //[l setBorderWidth:1.0];
    //[l setBorderColor:[[UIColor whiteColor] CGColor]];
   
}

@end
