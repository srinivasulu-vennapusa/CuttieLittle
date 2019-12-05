//
//  OverlayView.h
//
//  Created by Satya Siva Saradhi on 11/10/11.
//  Copyright 2011 __technolabssoftware__. All rights reserved.
//




#import <UIKit/UIKit.h>

@protocol CancelDelegate;

@interface OverlayView : UIView {
    UIImageView *imageView;
    NSMutableArray *_points;
    UIButton *cancelButton;
    UILabel *instructionsLabel;
    id<CancelDelegate> delegate;
    BOOL oneDMode;
    CGRect cropRect;
    
    NSTimer *timer;
}

@property (nonatomic, retain) NSMutableArray*  points;
@property (nonatomic, assign) id<CancelDelegate> delegate;
@property (nonatomic, assign) BOOL oneDMode;
@property (nonatomic, assign) UIButton *cancelButton;
@property (nonatomic, assign) UILabel *instructionsLabel;
@property (nonatomic, assign) CGRect cropRect;
@property (nonatomic, retain) NSTimer *timer;

- (id)initWithFrame:(CGRect)theFrame cancelEnabled:(BOOL)isCancelEnabled oneDMode:(BOOL)isOneDModeEnabled;

- (void)setPoint:(CGPoint)point;

@end

@protocol CancelDelegate
- (void)cancelled;
@end
