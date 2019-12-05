//
//  CellView_ServiceOrder.m
//  OmniRetailer
//
//  Created by Sonali on 2/24/15.
//
//

#import "CellView_ServiceOrder.h"

@implementation CellView_ServiceOrder
@synthesize tableNo,orderId,waiterName,totalBill,orderDate,slotId,orderChannelLbl;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)dealloc {
//    [_statusBtn release];
//    [super dealloc];
//}
- (IBAction)changeStatus:(UIButton *)sender {
}
- (IBAction)openBookingDetailsView:(id)sender {
}
@end
