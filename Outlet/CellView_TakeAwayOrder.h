//
//  CellView_ServiceOrder.h
//  OmniRetailer
//
//  Created by Sonali on 2/24/15.
//
//

#import <UIKit/UIKit.h>

@interface CellView_TakeAwayOrder : UITableViewCell {
    
    IBOutlet UILabel *SNo;
    IBOutlet UILabel* orderId;
   // IBOutlet UILabel *tableNo;
   // IBOutlet UILabel *waiterName;
    IBOutlet UILabel *totalBill;
    IBOutlet UILabel *orderDate;
    IBOutlet UILabel *status;
    IBOutlet UILabel *ticketTotal;

}

@property(nonatomic,strong)UILabel *orderId;
//@property(nonatomic,strong)UILabel *tableNo;
//@property(nonatomic,strong)UILabel *waiterName;
@property(nonatomic,strong)UILabel *totalBill;
@property(nonatomic,strong)UILabel *orderDate;
@property (strong, nonatomic) IBOutlet UILabel *counter;
@property (strong, nonatomic) IBOutlet UILabel *ticketTotal;
@property (strong, nonatomic) IBOutlet UILabel *billDone;
@property (strong,nonatomic) IBOutlet  UILabel *SNo;

@property (strong,nonatomic) IBOutlet  UILabel *status;

@end
