//
//  WarehouseInspectionReceipt.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/29/15.
//
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"

@interface WarehouseInspectionReceipt : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MBProgressHUDDelegate,UISearchBarDelegate>
{
    UISegmentedControl *mainSegmentedControl;
    UIScrollView *shipmentView;
    MBProgressHUD *HUD;
    UITextField *po_ref;
    UITextField *shipment_note_ref;
    UITextField *inspected_by;
    UITextField *inspection_summary;
    UITextField *received_on;
    UITextField *inspection_status;
    UITextField *remarks;
    UITextField *searchItem;
    
    UITableView *skListTable;
    UITableView *itemTable;
    
    NSMutableArray *itemArray;
    NSMutableArray *itemSubArray;
    NSMutableArray *rawMaterials;
    
    UIButton *qtyChange;
    UIButton *delButton;
    
    UIButton *orderButton;
    UIButton *cancelButton;
    
    UISearchBar *searchBar;
    
    BOOL searching;
    BOOL letUserSelectRow;
    // int count;
    UIButton *previousButton;
    UIButton *nextButton;
    UIButton *firstButton;
    UIButton *lastButton;
    NSMutableArray *itemIdArray;
    NSMutableArray *orderStatusArray;
    NSMutableArray *orderAmountArray;
    NSMutableArray *OrderedOnArray;
    NSMutableArray *copyListOfItems;
    UITableView* orderstockTable;
}
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@end
