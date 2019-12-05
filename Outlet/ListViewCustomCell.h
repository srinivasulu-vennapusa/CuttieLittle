//
//  ListViewCustomCell.h
//  OmniRetailer
//
//  Created by admin on 15/11/16.
//
//

#import <UIKit/UIKit.h>

@interface ListViewCustomCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *flowIconImg;
@property (strong, nonatomic) IBOutlet UILabel *flowDocumentLbl;
@property (strong, nonatomic) IBOutlet UILabel *noOfDocsLbl;
@property (strong, nonatomic) IBOutlet UILabel *pendingDocsLbl;
@property (strong, nonatomic) IBOutlet UILabel *lastSubmittedDate;

@end
