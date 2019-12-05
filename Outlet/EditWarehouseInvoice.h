//
//  EditWarehouseInvoice.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/24/15.
//
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"

@interface EditWarehouseInvoice : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MBProgressHUDDelegate,UISearchBarDelegate>
{
    UIScrollView *shipmentView;
    MBProgressHUD *HUD;
    UILabel *shipmentId;
    UILabel *orderId;
    UILabel *shipmentNoteId;
    UILabel *customerName;
    UILabel *buildingNo;
    UILabel *streetName;
    UILabel *city;
    UILabel *country;
    UILabel *zip_code;
    UILabel *shipmentAgency;
    UILabel *totalItemCost;
    UILabel *shipmentCost;
    UILabel *tax;
    UILabel *insuranceCost;
    UILabel *paymentTerms;
    UILabel *remarks;
    UILabel *invoiceDate;
    
    UITextField *shipmentIdValue;
    UITextField *orderIdValue;
    UITextField *shipmentNoteIdValue;
    UITextField *customerNameValue;
    UITextField *buildingNoValue;
    UITextField *streetNameValue;
    UITextField *cityValue;
    UITextField *countryValue;
    UITextField *zip_codeValue;
    UITextField *shipmentAgencyValue;
    UITextField *totalItemCostValue;
    UITextField *shipmentCostValue;
    UILabel *taxValue;
    UITextField *insuranceCostValue;
    UITextField *paymentTermsValue;
    UITextField *remarksValue;
    UITextField *invoiceDateValue;
    
    NSMutableArray *serchOrderItemArray;
    UIButton *delButton;
    UIButton *qtyChange;
    UIView *qtyChangeDisplyView;
    NSMutableArray *shipmentIdList;
    UITableView *shipIdTable;
    UITextField *qtyFeild;
    UIButton *okButton;
    UIButton *qtyCancelButton;
    NSInteger qtyOrderPosition;
    int totalAmount;
    
    UITableView *serchOrderItemTable;
    UIButton *orderButton;
    UIButton *cancelButton;
    
    NSMutableArray *ItemArray;
    NSMutableArray *skuIdArray;
    NSMutableArray *ItemDiscArray;
    NSMutableArray *totalQtyArray;
    NSMutableArray *priceArray;
    NSMutableArray *QtyArray;
    NSMutableArray *totalArray;
    UITableView *orderItemsTable;
    
    UILabel *subTotalData;
    UILabel *taxData;
    UILabel *totAmountData;
    NSMutableArray *itemIdArray;
}
@property (strong, nonatomic) UIPopoverController* popOver;
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;
-(id) initWithInvoiceID:(NSString *)invoiceID;

@end
