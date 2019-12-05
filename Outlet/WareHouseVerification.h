//
//  WareHouseVerification.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/15/15.
//
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#include <AudioToolbox/AudioToolbox.h>

@interface WareHouseVerification : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate,MBProgressHUDDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    MBProgressHUD *HUD;
    
    UITextField *searchItem;
    UITableView *itemTable;
    UITableView *skListTable;
    UITableView *supplierTable;

    UITableView *lossTypeTable;
    NSMutableArray *itemArray;
    NSMutableArray *itemSubArray;
    NSMutableArray *productID;
    NSMutableArray *rawMaterials;
    
    UITextField *location;
    UITextField *verifiedDate;
    UITextField *verifiedBy;
    UITextField *storageUnit;
    UITextField *rejecQtyField;
    UITextField *lossTypeField;
    
    UIButton *okButton;
    UIButton *qtyCancelButton;
    
    UIButton *submitBtn;
    UIButton *cancelButton;
    
    UIButton *lossTypeButton;
    
    NSMutableArray *lossTypeList;
    
    UIView *rejectQtyChangeDisplayView;
    
    UIView *transparentView;
    UITextView *remarkTextView;
    
    UIButton *selectLocation;
    
    NSMutableArray *locationArr;
    UITableView *locationTable;
}
@property (assign)BOOL isOpen;
@property (nonatomic,retain)NSIndexPath *selectIndex;
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@end
