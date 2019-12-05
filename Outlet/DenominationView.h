//
//  DenominationView.h
//  OmniRetailer
//
//  Created by MACPC on 8/17/15.
//
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"

@interface DenominationView : UIView <UITextFieldDelegate>

- (IBAction)addTens:(UIButton *)sender;
- (IBAction)removeTens:(UIButton *)sender;

- (IBAction)addTwenty:(UIButton *)sender;
- (IBAction)removeTwenty:(UIButton *)sender;
- (IBAction)addFifty:(UIButton *)sender;
- (IBAction)removeFifty:(UIButton *)sender;
- (IBAction)addHundred:(UIButton *)sender;
- (IBAction)removeHundred:(UIButton *)sender;
- (IBAction)addFiveHundred:(UIButton *)sender;
- (IBAction)removeFiveHundred:(UIButton *)sender;
- (IBAction)addThousand:(UIButton *)sender;
- (IBAction)removeThousand:(UIButton *)sender;
- (IBAction)removeRupee:(UIButton *)sender;
- (IBAction)addRupee:(UIButton *)sender;
- (IBAction)removeTwo:(UIButton *)sender;
- (IBAction)addTwoCoin:(UIButton *)sender;
- (IBAction)removeFiveCoin:(UIButton *)sender;
- (IBAction)addFiveCoin:(UIButton *)sender;
- (IBAction)removeTenCoin:(UIButton *)sender;
- (IBAction)addTenCoin:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UITextField *noOfTens;





@end
