//
//  CellView_ServiceOrder.h
//  OmniRetailer
//
//  Created by Sonali on 2/24/15.
//
//

#import <UIKit/UIKit.h>

@interface CellView_ServiceOrder : UITableViewCell {
    
    IBOutlet UILabel* orderId;
    IBOutlet UILabel *tableNo;
    IBOutlet UILabel *waiterName;
    IBOutlet UILabel *totalBill;
    IBOutlet UILabel *orderDate;
    
}

@property(nonatomic,strong)UILabel *orderId;
@property(nonatomic,strong)UILabel *tableNo;
@property(nonatomic,strong)UILabel *waiterName;
@property(nonatomic,strong)UILabel *totalBill;
@property(nonatomic,strong)UILabel *orderDate;

// added by roja on 23/02/2019..
//@property(nonatomic,strong)UILabel * openBtn;


@property (retain, nonatomic) IBOutlet UILabel *slotId;
@property (retain, nonatomic) IBOutlet UIButton *statusBtn;
- (IBAction)changeStatus:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *openBtn;
- (IBAction)openBookingDetailsView:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *orderChannelLbl;



@end
