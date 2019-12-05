//
//  NormalStock.h
//  OmniRetailer
//
//  Created by technolabs on 05/11/12.
//  Copyright 2012 __techolabssoftware.com__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CellView_Stock.h"
#import "MBProgressHUD.h"
#include <AudioToolbox/AudioToolbox.h>

@interface NormalStock : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate,MBProgressHUDDelegate,UINavigationControllerDelegate>{
   
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    
    UIView *criticalStockView;
    UIView *normalStockView;
    
    UISearchBar *criticalStockSearchBar;
    UISearchBar *normalStockSearchBar;
    NSMutableArray *normalCopyListOfItems;
    NSMutableArray *criticalListOfItems;
    UITableView* criticalstockTable;
    UITableView *normalstockTable;
    NSString *criticalSearchString;
    NSString *normalSearchString;
    
    BOOL criticalSearching;
    BOOL criticalLetUserSelectRow;
    
    BOOL normalSearching;
    BOOL normalLetUserSelectRow;
    
    IBOutlet CellView_Stock* stockCellView;
    
    NSMutableArray *nameArray_;
    NSMutableArray *descArray_;
    NSMutableArray *avaiArray_;
    NSMutableArray *unitArray_;
    NSMutableArray *reorArray_;
    NSMutableArray *skuIdArr_;
    NSMutableArray *sizeArr_;
    NSMutableArray *colorArr_;
    
    NSMutableArray *nameArray1;
    NSMutableArray *descArray1;
    NSMutableArray *avaiArray1;
    NSMutableArray *unitArray1;
    NSMutableArray *reorArray1;
    NSMutableArray *skuIdArr1;
    NSMutableArray *sizeArr1;
    NSMutableArray *colorArr1;
    NSMutableArray *skuStockId;
    
    MBProgressHUD *HUD;
    
    UIButton *criticalfirstBtn;
    UIButton *criticallastBtn;
    UIButton *criticalpreviousButton;
    UIButton *criticalnextButton;
    
    UIButton *normalfirstBtn;
    UIButton *normallastBtn;
    UIButton *normalpreviousButton;
    UIButton *normalnextButton;
    
    
    UISegmentedControl *mainSegmentedControl;
    
    
    UILabel *criticalrecStart1;
    UILabel *criticalrecEnd1;
    UILabel *criticaltotalRec1;
    UILabel *criticallabel11;
    UILabel *criticallabel22;
    
    UILabel *normalrecStart1;
    UILabel *normalrecEnd1;
    UILabel *normaltotalRec1;
    UILabel *normallabel11;
    UILabel *normallabel22;
    float version;

}

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

- (void) searchTableView:(NSString *)tableType;


@end
