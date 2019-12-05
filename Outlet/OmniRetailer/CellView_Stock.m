//
//  CellView_Stock.m
//  OmniRetailer
//
//  Created by Satya Siva Saradhi on 05/11/12.
//  Copyright 2012 __techolabssoftware.com__. All rights reserved.
//

#import "CellView_Stock.h"


@implementation CellView_Stock

@synthesize itemName, itemDesc, itemAvail, itemprice, itemReorder,numberOfUnits,color,size,timer,Ledger;


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


- (void) setItemProperties:(NSString *)_iN _itemDesc:(NSString *)_iD _itemAvail:(NSString*)_iA _itemprice:(float)_iP _itemReorder:(NSString*)_iR _color:(NSString *)_color _size:(NSString *)_size {
    
    
    itemName.text = _iN;
    itemDesc.text = _iD;
    itemAvail.text = _iA;
//    itemprice.maximumValue = 1000.0;
//    itemprice.value = _iP;
    itemprice.progress = _iP;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        itemprice.transform = CGAffineTransformMakeScale(1.0, 10.0);
    }
    else{
         itemprice.transform = CGAffineTransformMakeScale(1.0, 3.0);
    }
   
    itemReorder.text = _iR;
    _iP = _iP * 100.0;
    numberOfUnits.text = [[NSString stringWithFormat:@"%f",_iP] componentsSeparatedByString:@"."][0];
    if ([numberOfUnits.text isEqualToString:@"0"]) {
       
//        itemName.textColor = [UIColor redColor];
//        CABasicAnimation *basic=[CABasicAnimation animationWithKeyPath:@"transform"];
//        [basic setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.06, 1.06, 1.08)]];
//        [basic setAutoreverses:YES];
//        [basic setRepeatCount:MAXFLOAT];
//        [basic setDuration:0.45];
//        [numberOfUnits.layer addAnimation:basic forKey:@"transform"];
//        [itemName.layer addAnimation:basic forKey:@"transform"];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(labelEffect) userInfo:nil repeats:YES];

        
    }
    
    color.text = _color;
    size.text = _size;
}
-(void)labelEffect {
    
    numberOfUnits.hidden = (!numberOfUnits.hidden);
}

@end
