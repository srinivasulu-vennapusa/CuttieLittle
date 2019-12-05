//
//  EditWarehouseShipment.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/22/15.
//
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"

@interface EditWarehouseShipment : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MBProgressHUDDelegate,UISearchBarDelegate>
{
    UIScrollView *shipmentView;
    MBProgressHUD *HUD;
    UILabel *shipmentId;
    UILabel *orderId;
    UILabel *shipmentNote;
    UILabel *gatePassRef;
    UILabel *shipmentDate;
    UILabel *shipmentMode;
    UILabel *shipmentAgency;
    UILabel *shipmentAgencyContact;
    UILabel *inspectedBy;
    UILabel *shippedBy;
    UILabel *rfidTagNo;
    UILabel *packagesDescription;
    UILabel *shipmentCost;
    UILabel *shipmentStreet;
    UILabel *shipmentLocation;
    UILabel *shipmentCity;
    
    UIButton *shipoModeButton;
    NSMutableArray *shipmodeList;
    UITableView *shipModeTable;
    UITextField *shipmentIdValue;
    UITextField *orderIdValue;
    UITextField *shipmentNoteValue;
    UITextField *gatePassRefValue;
    UITextField *shipmentDateValue;
    UITextField *shipmentModeValue;
    UITextField *shipmentAgencyValue;
    UITextField *shipmentAgencyContactValue;
    UITextField *inspectedByValue;
    UITextField *shippedByValue;
    UITextField *rfidTagNoValue;
    UITextField *packagesDescriptionValue;
    UITextField *shipmentCostValue;
    UITextField *shipmentStreetValue;
    UITextField *shipmentLocationValue;
    UITextField *shipmentCityValue;
    UITextField *searchItem;
    
    NSMutableArray *serchOrderItemArray;
    NSMutableArray *ItemArray;
    NSMutableArray *skuIdArray;
    NSMutableArray *ItemDiscArray;
    NSMutableArray *totalQtyArray;
    NSMutableArray *priceArray;
    NSMutableArray *QtyArray;
    NSMutableArray *totalArray;
    NSMutableArray *itemIdArray;
    UITableView *orderItemsTable;
    UITableView *serchOrderItemTable;
    NSString *seardhOrderItem;
    UILabel *subTotalData;
    UILabel *taxData;
    UILabel *totAmountData;
    UIButton *searchBtton;
    UITableView *cartTable;
    UIButton *qtyChange;
    UIButton *orderButton;
    UIButton *cancelButton;
    UIButton *delButton;
    UITextField *qtyFeild;
    UIButton *okButton;
    UIButton *qtyCancelButton;
    int totalAmount;
    UIView *qtyChangeDisplyView;
    NSInteger qtyOrderPosition;
    
}
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;
-(id) initWithShipmentID:(NSString *)shipmentID;

@end
