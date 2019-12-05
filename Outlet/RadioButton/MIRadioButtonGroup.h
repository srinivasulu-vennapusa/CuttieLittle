/*
 
 Copyright (c) 2010, Mobisoft Infotech
 All rights reserved.
*/ 
 //
 //  Created by Satya Siva Saradhi on 9/20/12.
 //  Copyright 2012 __techolabssoftware.com__. All rights reserved.
 //

#import <UIKit/UIKit.h>
@interface MIRadioButtonGroup : UIView {
	NSMutableArray *radioButtons;

}

@property (nonatomic,strong) NSMutableArray *radioButtons;

- (id)initWithFrame:(CGRect)frame andOptions:(NSArray *)options andColumns:(int)columns;
-(IBAction) radioButtonClicked:(UIButton *) sender;
-(void) removeButtonAtIndex:(int)index;
-(void) setSelected:(int) index;
-(void)clearAll;
-(int) getSelected;
@end


