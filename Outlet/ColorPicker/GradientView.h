//
//  GradientView.h
//  ColorPicker
//
//
//

#import <UIKit/UIKit.h>


@interface GradientView : UIView {
	CGGradientRef gradient;
	UIColor *theColor;
}

@property (readwrite,nonatomic,strong) UIColor *theColor;
- (void) setupGradient;
@end
