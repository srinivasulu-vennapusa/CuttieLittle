//
//  ColorSwatchView.h
//  ColorPicker
//
//

#import <UIKit/UIKit.h>


@interface ColorSwatchView : UIView {
    UIColor *swatchColor;
}

@property (readwrite, strong, nonatomic) UIColor *swatchColor;

@end
