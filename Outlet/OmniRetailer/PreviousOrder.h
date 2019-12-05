//
//  PreviousOrder.h
//  OmniRetailer
//
//  Created by Bangaru.Raju on 11/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellView_Order.h"
#import "MBProgressHUD.h"
#include <AudioToolbox/AudioToolbox.h>

@interface PreviousOrder : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate,MBProgressHUDDelegate,UITextFieldDelegate,UINavigationControllerDelegate,UIPopoverControllerDelegate,UIActionSheetDelegate>{
    
    CFURLRef		soundFileURLRef;
	SystemSoundID	soundFileObject;
    
    UITableView* orderstockTable;
    UISearchBar *searchBar;
    NSMutableArray *Items;
    NSMutableArray *copyListOfItems;
    NSString *searchString;
    
    BOOL searching;
    BOOL letUserSelectRow; 
    IBOutlet CellView_Order* orderCellView;  
    
    NSMutableArray *itemIdArray;
    NSMutableArray *orderStatusArray;
    NSMutableArray *orderAmountArray;
    NSMutableArray *OrderedOnArray;
    
    MBProgressHUD *HUD;
    
    UIButton *previousButton;
    UIButton *nextButton;
    UIButton *firstButton;
    UIButton *lastButton;
    
    UILabel *receiptRefNoValue;
    UILabel *supplierIDValue;
    UILabel *supplierNameValue;
    UILabel *locationValue;
    UILabel *deliveredBYValue;
    UILabel *inspectedBYValue;
    UILabel *dateValue;
    UILabel *poRefValue;
    UILabel *shipmentValue;
    UILabel *statusValue;
    UIScrollView *scrollView;
    UITableView *cartTable;
    UIScrollView *createReceiptView;
    UILabel *totalQuantity;
    UILabel *totalCost;
    UILabel *status;
    UIButton *popButton;
    UIBarButtonItem *sendButton;
    
   int stockQuantity ;
    float stockMaterialCost ;
    UIActionSheet *action;
    
    //moved from .h to .m by srinivasulu on 02/08/2018.. due to errors..
    UILabel *recStart;
    UILabel *recEnd;
    UILabel *totalRec;
    UILabel *label1;
    UILabel *label2;

}
@property (strong, nonatomic) UIPopoverController* popOver;
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;
- (void) searchTableView;
-(id) initWithorderID:(NSString *)orderID;
@end


