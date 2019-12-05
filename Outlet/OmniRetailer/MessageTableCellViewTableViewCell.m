//
//  MessageTableCellViewTableViewCell.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 11/16/15.
//
//

#import "MessageTableCellViewTableViewCell.h"
#import "WebServiceConstants.h"

@implementation MessageTableCellViewTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addMessageDetails:(NSDictionary *)messageDic {
    mainMessageView.layer.cornerRadius = mainMessageView.frame.size.height/2;
    messageBodyLbl.text = [messageDic valueForKey:MESSAGE_BODY];
    messageSubLbl.text = [messageDic valueForKey:MESSAGE_SUBJECT];
    mainMessageLbl.text = [[messageDic valueForKey:MESSAGE_SUBJECT] substringToIndex:1].uppercaseString;
    messageDateLbl.text = [messageDic valueForKey:MESSAGE_DATE];
}

@end
