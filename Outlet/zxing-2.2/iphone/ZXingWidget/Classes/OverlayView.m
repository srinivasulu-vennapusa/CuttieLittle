//
//  OverlayView.m
//
//  Created by Satya Siva Saradhi on 11/10/11.
//  Copyright 2011 __technolabssoftware__. All rights reserved.
//


#import "OverlayView.h"

static const CGFloat kPadding = 20;
static CGRect redrect;
static CGContextRef redc;

@implementation OverlayView

@synthesize delegate, oneDMode;
@synthesize points = _points;
@synthesize cancelButton;
@synthesize instructionsLabel;
@synthesize cropRect;
@synthesize timer;
UIButton *cancel_Button;

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id) initWithFrame:(CGRect)theFrame cancelEnabled:(BOOL)isCancelEnabled oneDMode:(BOOL)isOneDModeEnabled {
    if( self == [super initWithFrame:theFrame] ) {
        
        self.oneDMode = isOneDModeEnabled;
        //CGFloat rectSize = self.frame.size.width - kPadding * 2;
        //CGFloat rectSize2 = self.frame.size.height - kPadding * 2;
        // it effects cropping
        // 1st param effect the border line of rect and second param effects left vertical of rect 3rd param effects width and 4th param effects the height..
        
        
        
        
        self.backgroundColor = [UIColor clearColor];
        //self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self                                                     selector:@selector(mytimer)                                                    userInfo:Nil repeats:YES];
        
        // logo ..
        UILabel *logo = [[UILabel alloc] init];
        
        UIImageView *img = [[UIImageView alloc]
                            initWithImage:[UIImage imageNamed:@"Technolabs.PNG"]];
        [logo addSubview:img];
        [img release];
        logo.backgroundColor = [UIColor clearColor];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            cropRect = CGRectMake(kPadding * 4, kPadding * 4, self.frame.size.width - (kPadding*20) , self.frame.size.height - (kPadding * 6));
            
            [logo setFrame:CGRectMake(50, 425, 218, 53)];
        }
        else{
            cropRect = CGRectMake(kPadding * 2, kPadding * 3, self.frame.size.width - (kPadding*4) , self.frame.size.height - (kPadding * 6));
            [self.cancelButton setFrame:CGRectMake(260, 40, 50, 50)];
            [logo setFrame:CGRectMake(10, 225, 80, 203)];
        }
        
        [self addSubview:logo];
        
        if (isCancelEnabled){
            
        cancel_Button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //[cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        if (oneDMode) {
            UIImage *img = [UIImage imageNamed:@"closebutton.png"];
            [cancel_Button setImage:img forState:UIControlStateNormal];
            [img release];
            //[cancelButton setTransform:CGAffineTransformMakeRotation(M_PI/2)];
            [cancel_Button setFrame:CGRectMake(660, 800, 50, 50)];
        }
        }
        
        [cancel_Button addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        cancel_Button.enabled = YES;
        cancel_Button.userInteractionEnabled = YES;
        [self addSubview:cancel_Button];
        
        //cancel_Button.highlighted = YES;
        
        
//        UIButton *cancel_Button = [[UIButton alloc] init];
//        UIImage *img1 = [UIImage imageNamed:@"closes.png"];
//        [cancel_Button setImage:img1 forState:UIControlStateNormal];
//        cancel_Button.frame = CGRectMake(300.0, 100, 50, 50);
//        cancel_Button.hidden = NO;
//        cancel_Button.backgroundColor = [UIColor clearColor];
//        [cancel_Button addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpOutside];
//        //[self addSubview:cancel_Button];
    }
    
    self.userInteractionEnabled = YES;
    self.clipsToBounds = YES;
    return self;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    
    if([[touch valueForKey:@"view"] isKindOfClass:[UILabel class]])
    {
        //UIImageView *viewSelected=(UIImageView *)[touch valueForKey:@"view"]; //it returns touched object
        //for further differences can user viewSelected.tag
        NSLog(@"Image  touched");
    }
}

- (void)cancel {
    // call delegate to cancel this scanner
    if (delegate != nil) {
        [delegate cancelled];
    }
    
    NSLog(@"cancel clicked");
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc {
    [imageView release];
    [_points release];
    [super dealloc];
    [timer release];
}


- (void)drawRect:(CGRect)rect inContext:(CGContextRef)context {
    
    // this entire blocks effect only for drawing rectangle .. but not cropping .. so we take another rect to draw
    
    //CGFloat rectSize = self.frame.size.width - kPadding * 2;
    //CGFloat rectSize2 = self.frame.size.height - kPadding * 2;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        rect = CGRectMake(kPadding * 10, kPadding * 4, self.frame.size.width - (kPadding*20) , self.frame.size.height - (kPadding * 6));
    }
    else{
        rect = CGRectMake(kPadding * 4, kPadding * 3, self.frame.size.width - (kPadding*8) , self.frame.size.height - (kPadding * 6));
    }
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y);
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
    CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height);
    CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y);
    CGContextStrokePath(context);
    
    
    /*int x = (rectSize2 / 4) + ((self.frame.size.height - rectSize) / 2) ;
     CGRect toprect = CGRectMake(x, -5 , self.frame.size.width - x, self.frame.size.height + kPadding);
     
     CGRect bottomrect = CGRectMake(0, -5, rectSize2 / 4 , self.frame.size.height + kPadding);
     
     
     //fill the rect with color ..
     [[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.4] set];
     UIRectFill(toprect);
     UIRectFill(bottomrect);*/
}

- (CGPoint)map:(CGPoint)point {
    CGPoint center;
    center.x = cropRect.size.width/2;
    center.y = cropRect.size.height/2;
    float x = point.x - center.x;
    float y = point.y - center.y;
    int rotation = 0;
    switch(rotation) {
        case 0:
            point.x = x;
            point.y = y;
            break;
        case 90:
            point.x = -y;
            point.y = x;
            break;
        case 180:
            point.x = -x;
            point.y = -y;
            break;
        case 270:
            point.x = y;
            point.y = -x;
            break;
    }
    point.x = point.x + center.x;
    point.y = point.y + center.y;
    return point;
}


// red line blinking...
float i = 1;
- (void)drawRect {
    
    CGFloat red[4] = {1.0f, 0.0f, 0.0f, 1.0f};
    CGContextSetStrokeColor(redc, red);
    CGContextSetFillColor(redc, red);
    CGContextSetLineWidth(redc, i);
    CGContextBeginPath(redc);
    int offset = redrect.size.width / 2;
    //		CGContextMoveToPoint(c, rect.origin.x + kPadding, rect.origin.y + offset);
    //		CGContextAddLineToPoint(c, rect.origin.x + rect.size.width - kPadding, rect.origin.y + offset);
    CGContextMoveToPoint(redc, redrect.origin.y + offset, redrect.origin.x);
    CGContextAddLineToPoint(redc, redrect.origin.y + offset, redrect.origin.x + redrect.size.height);
    CGContextStrokePath(redc);
    
    
    if (i == 2) i = i - 1.0f;
    else        i = i + 0.5f;
    
    
}

- (void) mytimer {
    [self setNeedsDisplay];
}



////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    if (nil != _points) {
        //		[imageView.image drawAtPoint:cropRect.origin];
    }
    
    CGFloat white[4] = {1.0f, 1.0f, 1.0f, 1.0f};
    CGContextSetStrokeColor(c, white);
    CGContextSetFillColor(c, white);
    [self drawRect:cropRect inContext:c];
    
    //	CGContextSetStrokeColor(c, white);
    CGContextSetStrokeColor(c, white);
    CGContextSetFillColor(c, white);
    CGContextSaveGState(c);
    if (oneDMode) {
        // text on camera modification
        //char *text = "Place the red line over a bar code to be scanned.";
        CGContextSelectFont(c, "Helvetica", 15, kCGEncodingMacRoman);
        CGContextScaleCTM(c, -1.0, 1.0);
        CGContextRotateCTM(c, M_PI/2);
        //CGContextShowTextAtPoint(c, 74.0, 285.0, text, 49);
        
        // text on camera ..
        char *text2 = "Powered by TECHNOLABS.";
        CGContextShowTextAtPoint(c, 10.0, 10.0, text2, 21);
    }
    else {
        char *text = "Place a barcode inside the";
        char *text2 = "viewfinder rectangle to scan it.";
        CGContextSelectFont(c, "Helvetica", 18, kCGEncodingMacRoman);
        CGContextScaleCTM(c, -1.0, 1.0);
        CGContextRotateCTM(c, M_PI);
        CGContextShowTextAtPoint(c, 48.0, -45.0, text, 26);
        CGContextShowTextAtPoint(c, 33.0, -70.0, text2, 32);
    }
    CGContextRestoreGState(c);
    int offset = rect.size.width / 2;
    if (oneDMode) {
        redrect = rect;
        redc = c;
        [self drawRect];
    }
    if( nil != _points ) {
        CGFloat blue[4] = {0.0f, 1.0f, 0.0f, 1.0f};
        CGContextSetStrokeColor(c, blue);
        CGContextSetFillColor(c, blue);
        if (oneDMode) {
            CGPoint val1 = [self map:[[_points objectAtIndex:0] CGPointValue]];
            CGPoint val2 = [self map:[[_points objectAtIndex:1] CGPointValue]];
            CGContextMoveToPoint(c, offset, val1.x);
            CGContextAddLineToPoint(c, offset, val2.x);
            CGContextStrokePath(c);
        }
        else {
            CGRect smallSquare = CGRectMake(0, 0, 10, 10);
            for( NSValue* value in _points ) {
                CGPoint point = [self map:[value CGPointValue]];
                smallSquare.origin = CGPointMake(
                                                 cropRect.origin.x + point.x - smallSquare.size.width / 2,
                                                 cropRect.origin.y + point.y - smallSquare.size.height / 2);
                [self drawRect:smallSquare inContext:c];
            }
        }
    }
}


////////////////////////////////////////////////////////////////////////////////////////////////////
/*
 - (void) setImage:(UIImage*)image {
 //if( nil == imageView ) {
 // imageView = [[UIImageView alloc] initWithImage:image];
 // imageView.alpha = 0.5;
 // } else {
 imageView.image = image;
 //}
 
 //CGRect frame = imageView.frame;
 //frame.origin.x = self.cropRect.origin.x;
 //frame.origin.y = self.cropRect.origin.y;
 //imageView.frame = CGRectMake(0,0, 30, 50);
 
 //[_points release];
 //_points = nil;
 //self.backgroundColor = [UIColor clearColor];
 
 //[self setNeedsDisplay];
 }
 */

////////////////////////////////////////////////////////////////////////////////////////////////////
- (UIImage*) image {
    return imageView.image;
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) setPoints:(NSMutableArray*)pnts {
    [pnts retain];
    [_points release];
    _points = pnts;
    
    if (pnts != nil) {
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.25];
    }
    [self setNeedsDisplay];
}

- (void) setPoint:(CGPoint)point {
    if (!_points) {
        _points = [[NSMutableArray alloc] init];
    }
    if (_points.count > 3) {
        [_points removeObjectAtIndex:0];
    }
    [_points addObject:[NSValue valueWithCGPoint:point]];
    [self setNeedsDisplay];
}


@end
