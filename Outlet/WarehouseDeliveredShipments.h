//
//  WarehouseDeliveredShipments.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/22/15.
//
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"

@interface WarehouseDeliveredShipments : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,UISearchBarDelegate>
{
    MBProgressHUD *HUD;
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
