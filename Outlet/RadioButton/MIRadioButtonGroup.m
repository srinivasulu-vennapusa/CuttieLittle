/*
 
 Copyright (c) 2010, Mobisoft Infotech
 All rights reserved.
 */ 
//
//  Created by Satya Siva Saradhi on 9/20/12.
//  Copyright 2012 __techolabssoftware.com__. All rights reserved.
//


#import "MIRadioButtonGroup.h"

// MODIFIED:
#define RADIO_UNSELECTED 0
#define RADIO_SELECTED 1

@implementation MIRadioButtonGroup
@synthesize radioButtons;

- (id)initWithFrame:(CGRect)frame andOptions:(NSArray *)options andColumns:(int)columns{
    
    NSMutableArray *arrTemp =[[NSMutableArray alloc]init];
    self.radioButtons =arrTemp;
    if (self = [super initWithFrame:frame]) {
        // Initialization code
        int framex =0;
        framex= frame.size.width/columns;
        int framey = 0;
        framey =frame.size.height/(options.count/(columns));
        int rem =options.count%columns;
        if(rem !=0){
            framey =frame.size.height/((options.count/columns)+1);
        }
        int k = 0;
        for(int i=0;i<(options.count/columns);i++){
            for(int j=0;j<columns;j++){
                
                int x = framex*0.25;
                int y = framey*0.25;
                UIButton *btTemp = [[UIButton alloc]initWithFrame:CGRectMake(framex*j+x, framey*i+y, framex/2+x, framey/2+y)];
                [btTemp addTarget:self action:@selector(radioButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                btTemp.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [btTemp setImage:[UIImage imageNamed:@"radio-off.png"] forState:UIControlStateNormal];
                [btTemp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                btTemp.titleLabel.font =[UIFont systemFontOfSize:14.f];
                [btTemp setTitle:options[k] forState:UIControlStateNormal];
                [self.radioButtons addObject:btTemp];
                [self addSubview:btTemp];
                k++;
        
            }
        }
        
            for(int j=0;j<rem;j++){
                
                int x = framex*0.25;
                int y = framey*0.25;
                UIButton *btTemp = [[UIButton alloc]initWithFrame:CGRectMake(framex*j+x, framey*(options.count/columns), framex/2+x, framey/2+y)];
                [btTemp addTarget:self action:@selector(radioButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                btTemp.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [btTemp setImage:[UIImage imageNamed:@"radio-off.png"] forState:UIControlStateNormal];
                [btTemp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                btTemp.titleLabel.font =[UIFont systemFontOfSize:14.f];
                [btTemp setTitle:options[k] forState:UIControlStateNormal];
                [self.radioButtons addObject:btTemp];
                [self addSubview:btTemp];
                k++;
                
            
        }    
        
    }
    return self;
}


-(IBAction) radioButtonClicked:(UIButton *) sender{
    for(int i=0;i<(self.radioButtons).count;i++){
        // MODIFIED:
        UIButton *btTemp = (self.radioButtons)[i];
        [btTemp setImage:[UIImage imageNamed:@"radio-off.png"] forState:UIControlStateNormal];
        // MODIFIED:
        if (btTemp == sender) {
            [btTemp setTag:RADIO_SELECTED];
        } else {
            [btTemp setTag:RADIO_UNSELECTED];
        }
    }
    [sender setImage:[UIImage imageNamed:@"radio-on.png"] forState:UIControlStateNormal];
    
}

-(void) removeButtonAtIndex:(int)index{
    [(self.radioButtons)[index] removeFromSuperview];

}

-(void) setSelected:(int) index{
    for(int i=0;i<(self.radioButtons).count;i++){
        // MODIFIED:
        UIButton *btTemp = (self.radioButtons)[i];
        [btTemp setImage:[UIImage imageNamed:@"radio-off.png"] forState:UIControlStateNormal];
        // MODIFIED:
        [btTemp setTag:RADIO_UNSELECTED];
    }
    // MODIFIED:
    UIButton *btSelected = (self.radioButtons)[index];
    // MODIFIED:
    [btSelected setTag:RADIO_SELECTED];
    [btSelected setImage:[UIImage imageNamed:@"radio-on.png"] forState:UIControlStateNormal];
}

// MODIFIED:
-(int) getSelected {
    for(int i=0;i<(self.radioButtons).count;i++){
        UIButton *btTemp = (self.radioButtons)[i];
        if (btTemp.tag == RADIO_SELECTED) {
            return i;
        }
    }
    return -1;
}

-(void)clearAll{
    for(int i=0;i<(self.radioButtons).count;i++){
        [(self.radioButtons)[i] setImage:[UIImage imageNamed:@"radio-off.png"] forState:UIControlStateNormal];
        
    }

}

@end
