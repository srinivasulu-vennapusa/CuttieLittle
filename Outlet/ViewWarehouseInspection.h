//
//  ViewWarehouseInspection.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 5/1/15.
//
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"

@interface ViewWarehouseInspection : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MBProgressHUDDelegate,UISearchBarDelegate>
{
    UIScrollView *shipmentView;
    MBProgressHUD *HUD;
    
    UILabel *po_ref;
    UILabel *shipment_note_ref;
    UILabel *inspected_by;
    UILabel *inspection_summary;
    UILabel *received_on;
    UILabel *inspection_status;
    UILabel *remarks;
    
    UILabel *po_refValue;
    UILabel *shipment_note_refValue;
    UILabel *inspected_byValue;
    UILabel *inspection_summaryValue;
    UILabel *received_onValue;
    UILabel *inspection_statusValue;
    UILabel *remarksValue;
    
    UITableView *itemTable;
    NSMutableArray *itemArray;
    
    UIButton *popButton;
    UIBarButtonItem *sendButton;
    UIButton *qtyChange;
}
@property (strong, nonatomic) UIPopoverController* popOver;
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;
-(id) initWithInspectionID:(NSString *)inspectionID;

@end
