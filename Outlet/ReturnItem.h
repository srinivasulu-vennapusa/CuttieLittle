//
//  ReturnItem.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 11/26/14.
//
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "CustomTextField.h"
#import "WebServiceController.h"


@interface ReturnItem : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,UITextFieldDelegate,UITextViewDelegate, SalesServiceDelegate>{
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
    
    UILabel *subtotal;
    UILabel *subtotal_value;
    
    UILabel *deals;
    UILabel *deals_value;
    
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
    UILabel *returningTotalBill;
    UILabel *returningTotalBillValue;
    
}
@property (nonatomic ) UITextField *presentTextField;
-(id) initWithBillType:(NSString *)typeOfBill returningItems:(NSMutableArray *)returningItems totalBill:(NSString *)totalBill billStatus:(NSString *)billStatus deals:(NSString *)deals1 subtotal:(NSString *)subtotal;

@end
