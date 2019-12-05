//
//  ViewWarehouseInvoice.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/23/15.
//
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"

@interface ViewWarehouseInvoice : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MBProgressHUDDelegate,UISearchBarDelegate>
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
    
    UILabel *shipmentIdValue;
    UILabel *orderIdValue;
    UILabel *shipmentNoteIdValue;
    UILabel *customerNameValue;
    UILabel *buildingNoValue;
    UILabel *streetNameValue;
    UILabel *cityValue;
    UILabel *countryValue;
    UILabel *zip_codeValue;
    UILabel *shipmentAgencyValue;
    UILabel *totalItemCostValue;
    UILabel *shipmentCostValue;
    UILabel *insuranceCostValue;
    UILabel *paymentTermsValue;
    UILabel *remarksValue;
    UILabel *invoiceDateValue;
    
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
    UITableView *cartTable;
    UIButton *popButton;
    UIBarButtonItem *sendButton;
}
@property (strong, nonatomic) UIPopoverController* popOver;
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;
-(id) initWithInvoiceID:(NSString *)invoiceID;
@end
