//
//  CustomTextField.m
//  OmniRetailer
//
//  Created by MACPC on 6/18/15.
//
//

#import "CustomTextField.h"

@implementation CustomTextField

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(void)awakeFromNib {
    
    [super awakeFromNib];
    
    @try {
        
        //added on 17/10/2016....
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
        self.layer.borderWidth = 1.0f;
        
        
        //changed by Srinivasulu on 14/09/2016
        self.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        
        //        self.borderStyle = UITextBorderStyleRoundedRect;
        self.borderStyle = UITextBorderStyleNone;
        
        (self.layer).cornerRadius = 3.0f;
        
        self.layer.masksToBounds = YES;
        
//        self.textAlignment = NSTextAlignmentCenter;
        
        
        //     self setbor
        
        //    self.textColor =  [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0];
        //upto here.......
        
        if(self.placeholder.length > 0){
            self.placeholder = [NSString stringWithFormat:@"%@%@",@"  ",self.placeholder];
            self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor whiteColor]colorWithAlphaComponent:0.4]}];
        }
        
//        else
//            NSLog(@"----condition failed...*");
        
    } @catch (NSException *exception) {
        
        NSLog(@"---- exception while setting the customProperties----%@",exception);
    }
    
    
}

@end
