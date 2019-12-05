//
//  CellView_Stock.h
//  OmniRetailer
//
//  Created by Satya Siva Saradhi on 05/11/12.
//  Copyright 2012 __techolabssoftware.com__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CellView_Stock : UITableViewCell {
    
    IBOutlet UILabel* itemName;
    
    IBOutlet UILabel* itemDesc;
    
    IBOutlet UILabel* itemAvail;
    
    IBOutlet UIProgressView* itemprice;
    
    IBOutlet UILabel* itemReorder;
    
    IBOutlet UILabel* numberOfUnits;
    
    IBOutlet UILabel *color;
    
    IBOutlet UILabel *size;
    
    IBOutlet UIButton * Ledger;
    
}

@property (nonatomic, strong) UILabel* itemName;
@property (nonatomic, strong) UILabel* itemDesc;
@property (nonatomic, strong) UILabel* itemAvail;
@property (nonatomic, strong) UIProgressView* itemprice;
@property (nonatomic, strong) UILabel* itemReorder;
@property (nonatomic, strong) UILabel* numberOfUnits;
@property (nonatomic,strong) UILabel *color;
@property (nonatomic,strong) UILabel *size;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UIButton * Ledger;

@property (strong, nonatomic) IBOutlet UILabel *sNoLbl;

- (void) setItemProperties:(NSString *)_iN _itemDesc:(NSString *)_iD _itemAvail:(NSString*)_iA _itemprice:(float)_iP _itemReorder:(NSString*)_iR _color:(NSString *)_color _size:(NSString *)_size;


@end
