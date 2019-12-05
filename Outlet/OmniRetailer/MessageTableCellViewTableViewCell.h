//
//  MessageTableCellViewTableViewCell.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 11/16/15.
//
//

#import <UIKit/UIKit.h>

@interface MessageTableCellViewTableViewCell : UITableViewCell
{
    IBOutlet UIView *mainMessageView;
    IBOutlet UILabel *mainMessageLbl;
    IBOutlet UILabel *messageBodyLbl;
    IBOutlet UILabel *messageSubLbl;
    IBOutlet UILabel *deliveredByLbl;
    IBOutlet UILabel *messageDateLbl;
}

- (void)addMessageDetails:(NSDictionary *)messageDic;

@property (strong, nonatomic) IBOutlet UIView *mainMessageView;
@property (strong, nonatomic) IBOutlet UILabel *mainMessageLbl;
@property (strong, nonatomic) IBOutlet UILabel *messageBodyLbl;
@property (strong, nonatomic) IBOutlet UILabel *messageSubLbl;
@property (strong, nonatomic) IBOutlet UILabel *deliveredByLbl;
@property (strong, nonatomic) IBOutlet UILabel *messageDateLbl;

@end
