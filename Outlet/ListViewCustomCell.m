//
//  ListViewCustomCell.m
//  OmniRetailer
//
//  Created by admin on 15/11/16.
//
//

#import "ListViewCustomCell.h"

@implementation ListViewCustomCell

@synthesize flowIconImg,pendingDocsLbl,flowDocumentLbl,noOfDocsLbl,lastSubmittedDate;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
