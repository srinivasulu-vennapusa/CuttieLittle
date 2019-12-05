//
//  XReportView.h
//  OmniRetailer
//
//  Created by MACPC on 9/28/15.
//
//

#import <UIKit/UIKit.h>

@interface XReportView : UIView


@property (strong, nonatomic) IBOutlet UIButton *generateReportBtn;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;

- (IBAction)generateReport:(UIButton *)sender;
- (IBAction)cancel:(UIButton *)sender;

@end
