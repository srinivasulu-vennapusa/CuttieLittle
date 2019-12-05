//
//  CustomLabel.m
//  OmniRetailer
//
//  Created by TLMac on 9/17/16.
//
//

#import "CustomLabel.h"

@implementation CustomLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/**
 * @description  here we setting the cusome properties to UILabel.......
 * @date         08/10/2016
 * @method       awakeFromNib
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)awakeFromNib {
    
    @try {
        self.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        self.layer.cornerRadius = 10.0f;
        [self setTextAlignment:NSTextAlignmentCenter];
        self.layer.masksToBounds = YES;
        self.numberOfLines = 2;
//        self.lineBreakMode = NSLineBreakByWordWrapping;
        self.lineBreakMode = NSLineBreakByTruncatingTail;

        //    self.layer.borderWidth = 1.0f;
        //    self.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
        
    } @catch (NSException *exception) {
   
        NSLog(@"---- exception while setting the customProperties----%@",exception);
    }
    
}


/**
 * @description  here we setting the cusome properties to UILabel.......
 * @date         08/10/2016
 * @method       awakeFromNib
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void) labelColor:(UIColor *)backGroundColor   labelTextColor:(UIColor *)textColor{

    @try {
        
        self.textColor = textColor;
        self.backgroundColor = backGroundColor;
        self.layer.cornerRadius = 10.0f;
        [self setTextAlignment:NSTextAlignmentCenter];
        self.layer.masksToBounds = YES;
        self.numberOfLines = 2;

        self.lineBreakMode = NSLineBreakByTruncatingTail;
        
        
    } @catch (NSException *exception) {
        
        NSLog(@"---- exception while setting the customProperties----%@",exception);

    }

    
}

@end
