//
//  ReturnDenomination.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 8/24/15.
//
//

#import <UIKit/UIKit.h>

@interface ReturnDenomination : UIView<UITextFieldDelegate>
- (IBAction)removeReturnTen:(id)sender;
- (IBAction)addReturnTen:(id)sender;
- (IBAction)removeReturnFifty:(id)sender;
- (IBAction)addReturnFifty:(id)sender;
- (IBAction)removeReturnsFiveHund:(id)sender;
- (IBAction)addReturnsFiveHund:(id)sender;
- (IBAction)removeReturnTwenty:(id)sender;
- (IBAction)addReturnTwenty:(id)sender;
- (IBAction)addReturnHund:(id)sender;
- (IBAction)removeReturnHund:(id)sender;
- (IBAction)addReturnthousand:(id)sender;
- (IBAction)removeReturnThousand:(id)sender;
- (IBAction)addReturnFive:(id)sender;
- (IBAction)removeReturnFive:(id)sender;
- (IBAction)addReturnTwo:(id)sender;
- (IBAction)removeReturnTwo:(id)sender;
- (IBAction)addReturnone:(id)sender;
- (IBAction)removeReturnone:(id)sender;

@end
