//
//  ExchangeItem.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 11/28/14.
//
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface ExchangeItem : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,UITextFieldDelegate,UITextViewDelegate>{
    UILabel *billID;
    UILabel *billIDValue;
    UILabel *label_1;
    UILabel *label_2;
    UILabel *label_3;
    UILabel *label_4;
    UILabel *label_5;
    UITableView *itemTable;
    NSMutableArray *selectedItems;
    UIImage *on;
    UIImage *off;
    UILabel *total_Bill;
    UILabel *total_Bill_Value;
    UILabel *reason;
    UITextView *reasonTextField;
    UITextField *qty1;
    UIButton *submitButton;
    UIView *qtyChangeDisplyView;
    UITextField *qtyFeild;
    UIButton *okButton;
    UIButton *qtyCancelButton;
    MBProgressHUD *HUD;
    UITextField * presentTextField;
    UILabel *exchangingTotalBill;
    UILabel *exchangingTotalBillValue;
    
}
@property (nonatomic ) UITextField *presentTextField;
-(id) initWithBillType:(NSString *)typeOfBill exchangingItems:(NSMutableArray *)exchangingItems totalBill:(NSString *)totalBill billStatus:(NSString *)billStatus;

@end
