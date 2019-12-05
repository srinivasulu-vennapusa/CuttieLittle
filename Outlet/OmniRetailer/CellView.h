//
//  CellView.h
//  OmniRetailer
//
//  Created by technolabs on 05/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CellView : UITableViewCell {
    
    IBOutlet UIImageView *productImg;
    IBOutlet UILabel     *productLabel;
    
    IBOutlet UIImageView *backgroundImage;
       
}

- (void)ProductImage:(NSString *)_text;
- (void)ProductLabel:(NSString *)_text;
- (void)celBackgroundImage:(BOOL)status;

@end




