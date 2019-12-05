//
//  ViewWarehouseShipment.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/22/15.
//
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"

@interface ViewWarehouseShipment : UIViewController
<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MBProgressHUDDelegate,UISearchBarDelegate>
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
    UILabel *shipmentStatus;
    UILabel *shipmentStreet;
    UILabel *shipmentLocation;
    UILabel *shipmentCity;
    
    UILabel *shipmentIdValue;
    UILabel *orderIdValue;
    UILabel *shipmentNoteValue;
    UILabel *gatePassRefValue;
    UILabel *shipmentDateValue;
    UILabel *shipmentModeValue;
    UILabel *shipmentAgencyValue;
    UILabel *shipmentAgencyContactValue;
    UILabel *inspectedByValue;
    UILabel *shippedByValue;
    UILabel *rfidTagNoValue;
    UILabel *packagesDescriptionValue;
    UILabel *shipmentCostValue;
    UILabel *shipmentStatusValue;
    UILabel *shipmentStreetValue;
    UILabel *shipmentLocationValue;
    UILabel *shipmentCityValue;
    
    NSMutableArray *ItemArray;
    NSMutableArray *skuIdArray;
    NSMutableArray *ItemDiscArray;
    NSMutableArray *totalQtyArray;
    NSMutableArray *priceArray;
    NSMutableArray *QtyArray;
    NSMutableArray *totalArray;
    NSMutableArray *itemIdArray;
    UITableView *orderItemsTable;
    UIButton *popButton;
    UIBarButtonItem *sendButton;
    UILabel *totalQuantity;
    UILabel *totalCost;
    UILabel *totAmountData;
    
    UITableView *cartTable;
}
@property (strong, nonatomic) UIPopoverController* popOver;
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;
-(id) initWithShipmentID:(NSString *)shipmentID;
@end
