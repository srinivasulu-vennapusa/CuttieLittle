//
//  CellView_Order.h
//  OmniRetailer
//
//  Created by Bangaru.Raju on 11/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CellView_Order : UITableViewCell {
   
    IBOutlet UILabel* itemId;
    
    IBOutlet UILabel* orderStatus;
    
    IBOutlet UILabel* orderAmount;
    
    IBOutlet UILabel* orderedOn;
    
}


@property (nonatomic, strong) UILabel* itemId;
@property (nonatomic, strong) UILabel* orderStatus;
@property (nonatomic, strong) UILabel* orderAmount;
@property (nonatomic, strong) UILabel* orderedOn;


- (void) setItemProperties:(NSString *)_ID _orderStatus:(NSString *)_OS _orderAmount:(NSString*)_OA _orderedOn:(NSString*)_OO;


@end
