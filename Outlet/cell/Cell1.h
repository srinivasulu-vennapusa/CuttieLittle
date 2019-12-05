
#import <UIKit/UIKit.h>

@interface Cell1 : UITableViewCell


@property (nonatomic,strong)IBOutlet UILabel *titleLabel;
@property (nonatomic,strong)IBOutlet UILabel *priceModel;
@property (nonatomic,strong)IBOutlet UIImageView *arrowImageView;
@property (nonatomic,strong)IBOutlet UILabel *itemPrice;
@property (nonatomic,strong)IBOutlet UILabel *bookQuantity;
@property (nonatomic,strong)IBOutlet UILabel *prvVerifiedQty;
@property (nonatomic,strong)IBOutlet UILabel *physicalQty;
@property (nonatomic,strong)IBOutlet UILabel *quantityLoss;
@property (nonatomic,strong)IBOutlet UILabel *lossType;
@property (nonatomic,strong)IBOutlet UILabel *itemDesc;

- (void)changeArrowWithUp:(BOOL)up;
@end
