
#import <UIKit/UIKit.h>

@interface MenuCell1 : UITableViewCell


@property (nonatomic,retain)IBOutlet UILabel *titleLabel;
@property (nonatomic,retain)IBOutlet UIImageView *arrowImageView;
@property (nonatomic,retain)IBOutlet UIImageView *itemImageView;
@property (nonatomic,retain)IBOutlet UILabel *orderedQuantity;

- (void)changeArrowWithUp:(BOOL)up;
@end
