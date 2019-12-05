//
//  ConfigCellView.h
//  DOCMan
//
//  Created by Satya Siva Saradhi on 28/02/12.
//  Copyright 2012 technolabssoftware.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ConfigCellView : UITableViewCell {
	IBOutlet UILabel *cellText;
	IBOutlet UIImageView *productImg;
    
}

- (void)LabelText:(NSString *)_text;
- (void)ProductImage:(NSString *)_text;
- (void)TextColor:(UIColor *)color;

@end
