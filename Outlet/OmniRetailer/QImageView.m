//
//  QImageView.m
//  Sample
//
//  Created by Satya Siva Saradhi on 04/07/12.
//  Copyright 2012 technolabssoftware.com. All rights reserved.
//

#import "QImageView.h"
#import "Global.h"
 

@implementation QImageView

@synthesize signatureDrawn;

/*- (id)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}*/


- (void)drawRect:(CGRect)rect {
    // Drawing code
}



-(void)clear {
    
    self.image = nil;
    [self setNeedsDisplay];
}

// Handles the start of a touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.signatureDrawn = YES;
    UITouch *touch = [touches anyObject];
    
    if (touch.tapCount == 2)
    {
        self.image = nil;
        return;
    }
    
    lastPoint = [touch locationInView:self];
    //lastPoint.y -= 20;
}

// Handles the continuation of a touch.
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.signatureDrawn = YES;
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    //currentPoint.y -= 20;
    
    UIGraphicsBeginImageContext(self.frame.size);
    [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5.0);
    
    
    if (selectedColor != nil) {
        
        float red   = [selectedColor[0] floatValue];
        float green = [selectedColor[1] floatValue];
        float blue  = [selectedColor[2] floatValue];
        
         CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);

    }
    
    else {
        
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 255.0, 255.0, 255.0, 1.0);
    }
    
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    lastPoint = currentPoint;
}

// Handles the end of a touch event when the touch is a tap.
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    if (touch.tapCount == 2)
    {
        self.image = nil;
        return;
    }
    
    
    if(!self.signatureDrawn) {
        
        UIGraphicsBeginImageContext(self.frame.size);
        [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5.0);
        // getting the selected color by using global value ..
        if (selectedColor != nil) {
            
            float red   = [selectedColor[0] floatValue];
            float green = [selectedColor[1] floatValue];
            float blue  = [selectedColor[2] floatValue];
            
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
            
        }
        
        else {
            
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 255.0, 255.0, 255.0, 1.0);
        }
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
}

-(NSData*) renderImageData
{
    CGRect bounds = self.frame;
    //180/2, 360-
    
    UIGraphicsBeginImageContextWithOptions(bounds.size,false,1) ;
    
    //[self drawContent:bounds color:[UIColor blackColor]];
//    if(!isPinVerified)
//        [bezier stroke];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
    
    CGSize sacleSize = CGSizeMake(180, 90);
    UIGraphicsBeginImageContextWithOptions(sacleSize, NO, 0.0);
    [self.image drawInRect:CGRectMake(0, 0, sacleSize.width, sacleSize.height)];
    UIImage * resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *fullimageData = UIImageJPEGRepresentation(resizedImage, .6);                    
    return fullimageData;
    
}

@end
