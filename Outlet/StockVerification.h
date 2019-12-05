//
//  StockVerification.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/4/15.
//
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#include <AudioToolbox/AudioToolbox.h>
#import "CustomTextField.h"
//#import "ZXingWidgetController.h"
#import "WebServiceController.h"
#import "WebServiceConstants.h"
#import "CustomNavigationController.h"
#import <PowaPOSSDK/PowaPOSSDK.h>
#import <ExternalAccessory/ExternalAccessory.h>
#import "Cell1.h"
#import "Cell2.h"

@interface StockVerification : CustomNavigationController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate,MBProgressHUDDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITextViewDelegate,UIAlertViewDelegate,SearchProductsDelegate,GetSKUDetailsDelegate,PowaTSeriesObserver,PowaScannerObserver, StoreStockVerificationDelegate, utilityMasterServiceDelegate>
{
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    MBProgressHUD *HUD;
    
    UITextField *searchItem;
    UITableView *itemTable;
    UITableView *skListTable;
    UITableView *lossTypeTable;
    NSMutableArray *itemArray;
    NSMutableArray *itemSubArray;
    NSMutableArray *productID;
    NSMutableArray *rawMaterials;
    
    CustomTextField *location;
    CustomTextField *verifiedDate;
    CustomTextField *verifiedBy;
    CustomTextField *storageUnit;
    CustomTextField *storageLocation;
    CustomTextField *rejecQtyField;
    CustomTextField *lossTypeField;
    
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
    
    UIAlertView *warning;
    
    UITableView *storageTable;
    UIButton *selectStorage;
    Cell1* cellStockView;
    NSMutableArray *storageUnits;
    NSMutableArray *tempSkuArrayList;
    NSMutableArray *skuArrayList;
    
    UIButton *barcodeBtn;
    NSString *selected_SKID;
    NSString *selected_SKID_pluCode;
    float version;
    UIScrollView *scrollView;
    
    NSString *searchStringStock;
    
    UITableView *priceTable;
    UIView *transparentPriceView;
    UIView *priceView;
    
    UILabel *descLabl;
    UILabel *priceLbl;
    
    NSMutableArray *priceArr;
    NSMutableArray *descArr;
    UIButton *closeBtn;
    
    NSMutableArray *priceDic;
    
    NSString *searchedString;
    CustomTextField *reorderedDate;
    UIButton *reorderedDateBtn;
    
    UIView *pickView;
    UIDatePicker *myPicker;
    UIPopoverController *catPopOver;
    UILabel *verificationCodeLblVal;
    UILabel *startDateLblVal;
    UILabel *endDateLblVal;
    NSMutableArray * priceArrayList;
    UITableView *storageLocations;
    NSMutableArray *storageLocationsArr;
    UIAlertView *qtyWarning;
    BOOL isVerifiable;
    NSMutableArray *productInfoArr;
}
@property (assign)BOOL isOpen;
@property (nonatomic,strong)NSIndexPath *selectIndex;
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;
@property (nonatomic, strong) PowaPOS *powaPOS;
@property (nonatomic, strong) PowaTSeries *tseries;
@property (nonatomic, strong) PowaS10Scanner *scanner;

@end
