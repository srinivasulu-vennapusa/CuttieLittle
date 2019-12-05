//
//  ServiceStaff.h
//  OmniRetailer
//
//  Created by Sonali on 12/25/15.
//
//

#import <UIKit/UIKit.h>
#import "WebServiceController.h"
#import "WebServiceUtility.h"
#import "WebServiceConstants.h"
#import "CustomNavigationController.h"
#include <AudioToolbox/AudioToolbox.h>
#import "PopOverViewController.h"
#import "RequestHeader.h"
#import "Cell3.h"
#import "Cell4.h"
#import "DealsController.h"
#import "OmniHomePage.h"
#import "BillingHome.h"

@interface ServiceStaff :CustomNavigationController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,UINavigationControllerDelegate,UISearchBarDelegate,BookingRestServiceDelegate,GetMenuServiceDelegate,GetSKUDetailsDelegate,GetDealsAndOffersDelegate,OutletServiceDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIAlertViewDelegate,StoreServiceDelegate,MenuServiceDelegate,OutletOrderServiceDelegate,CustomerServiceDelegate,KOTServiceDelegate,OutletOrderServiceDelegate>
{
    NSMutableArray *itemDetailsArr;
    UIButton *menuItem;
    UIButton *qty;
    UIDeviceOrientation currentOrientation;
    NSMutableArray *menuItemsCategories ;
    NSMutableArray *itemCategoryImages ;
    NSMutableArray *totalItemsArray ;
    NSMutableArray *itemImageArray ;
    NSMutableArray *priceList;
    UITableView *menuTable;
    NSUserDefaults *defaults ;
    Cell4 *Cell4_;
    Cell3 *Cell3_;
    int itemsCount;
    UIView *customView ;
    UISegmentedControl *mainSegmentControl;
    int indexNo;
    NSString *selectedItem;
    UITableViewCell *selectedCell;
    UIPopoverController *catPopOver;
    MBProgressHUD *HUD;
    int selectedIndex;
    int itemTagInt;
    NSString *selected_SKID;
    NSMutableArray *priceDicArr;
    NSString *selected_desc;
    NSString *selected_price;
    UIView *transparentView;
    UITableView *priceTable;
    NSMutableArray *taxArr;
    NSMutableArray *cartTotalItems;
    NSMutableArray *isVoidedArray;
    NSString *turnOverDis;
    NSString *offerDescStr;
    NSString *turnOverDealDes;
    NSMutableArray *turnOverDealVal;
    NSMutableDictionary *offerDic;
    
    float dealTempVal ;
    NSMutableArray *dealSkuCount;
    NSMutableArray *dealSkuids;
    NSMutableArray *dealDataItems;
    NSMutableArray *offerItems;
    NSMutableArray *dealItems;
    NSMutableArray *productID;
    NSMutableArray *minimumQty;
    NSMutableArray *freeQty;
    NSMutableArray *offierPrice;
    NSMutableArray *validFrom;
    NSMutableArray *validTo;
    NSMutableArray *dealofferArry;
    NSMutableArray *offerType;
    UILabel *offerLabel;
    NSMutableArray *dealItemsCount;
    NSMutableArray *sellSkuIds;
    NSString *dealSkuId;
    NSMutableArray *cartItemDetails;
    NSMutableArray *cartItem;
    NSString *totalQtyInCart;
    NSMutableArray *textFieldData;
    NSMutableArray *textFieldTitle;
    float version ;
    NSString *amount;
    UITableView *menuItems;
    NSMutableArray *menuItemDescArr;
    UIView *rejectQtyChangeDisplayView;
    CustomTextField *rejecQtyField;
    CustomTextField *remarksTxt;
    UIButton *okButton;
    UIButton *qtyCancelButton; 
    int tagId;
    NSMutableArray *tableDetails;
    UIView *tableLayout;
    NSMutableArray *tableStatusArr;
    NSMutableArray *statusArr;
    UICollectionView *collectionView;
    UIPopoverController *customerInfoPopOver;
    NSDictionary *customerInfoDic;
    float yposition_f;
    UILabel *taxTitle;
    UITextField *taxTxt;
    NSString *orderRef;
    NSDictionary *bookingDetails;
    UIAlertView *sucess;
    UIAlertView *warning;
   UIImageView *starRat;
    
    Boolean menuItemsStatus;
    
    
    NSMutableArray * menuItemsSkuIdArr;
    NSMutableArray * menuItemsPluCodeArr;
    
    
    // Used To display the Alert messages
    UILabel * userAlertMessageLbl;
    NSTimer * fadeOutTime;
    
    NSMutableDictionary * dealOffersDic;
    float totalCostBeforeDisc;
    float otherDiscPercentageValue;
    bool reloadTableData;
    bool isOrderUpdateCall;
    
    UICollectionView * menuCategoriesView;
    UICollectionView * menuCategoriesItemsCollectionView;
    NSMutableDictionary * menuCategoriesDic;
    UIPopoverController * productmenuInfoPopUp;
    
    
    NSMutableDictionary * mutOrderDetailsDic;
    Boolean isToCallUpdate;
    NSString * bookingTypeStr;
    
    // added by roja on 29/03/2019..
    UIButton * tasteRequirementBtn;
    UIView * tasteRequirementView;
    CustomTextField * tasteRequirmentTF;
    UIButton * tasteRequirementsCancelButton;

    UITableView * tasteRequirementsTbl;
//    UIPopoverPresentationController * presentationPopOverController;
    
    NSMutableArray * tasteRequirmntArray;
    
    UITableView * eatingHabitsTbl;
    BOOL isEatingHabitsDropDown;
    UIButton * ratingDetailsBtn;
    //Upto here added by roja

}

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;


@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;

@property (retain, nonatomic) IBOutlet UITextField *tableNoTxt;
@property (retain, nonatomic) IBOutlet UITextField *headCountTxt;
@property (retain, nonatomic) IBOutlet UITextField *mobileNoTxt;
@property (weak, nonatomic) IBOutlet UITextField *sectionTF;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTF;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTF;
@property (retain, nonatomic) IBOutlet UITextField *startTimeTxt;
@property (weak, nonatomic) IBOutlet UITextField *bookingTimeTF;
@property (weak, nonatomic) IBOutlet UITextField *eatingHabitsTF;

@property (retain, nonatomic) IBOutlet UIButton *customerInfoBtn;


@property (retain, nonatomic) IBOutlet UILabel *menuItemLbl;
@property (retain, nonatomic) IBOutlet UILabel *descriptionLbl;
@property (retain, nonatomic) IBOutlet UILabel *qtyLbl;
@property (retain, nonatomic) IBOutlet UILabel *tasteRecommendationsLbl;
@property (retain, nonatomic) IBOutlet UILabel *sNoLbl;
@property (retain, nonatomic) IBOutlet UILabel *priceLbl;
@property (retain, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UILabel *addOnLbl;
@property (retain, nonatomic) IBOutlet UITableView *itemsTbl;


@property (retain, nonatomic) IBOutlet UIButton *saveBtn;

@property (retain, nonatomic) IBOutlet UIButton *submitBtn;

@property (retain, nonatomic) IBOutlet UIButton *printBillBtn;



@property (retain, nonatomic) IBOutlet UILabel *billAmtValLbl;
@property (retain, nonatomic) IBOutlet UILabel *taxValLbl;
@property (retain, nonatomic) IBOutlet UILabel *discountValLbl;
@property (retain, nonatomic) IBOutlet UILabel *netPayValLbl;


@property (retain, nonatomic) IBOutlet UILabel *billAmtLbl;
@property (retain, nonatomic) IBOutlet UILabel *discountLbl;
@property (retain, nonatomic) IBOutlet UILabel *netPayLbl;

@property (retain, nonatomic) IBOutlet UIButton * productMenuBtn;


- (IBAction)displayNewProductMenu:(id)sender;
- (IBAction)getCustomerInfo:(UIButton *)sender;
- (IBAction)saveOrder:(UIButton *)sender;
- (IBAction)submitOrder:(UIButton *)sender;
- (IBAction)printBill:(UIButton *)sender;
- (IBAction)eatingHabitsDropDownBtn:(UIButton *)sender;


- (IBAction)orderItems:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextField *captainNameTF;


@property (assign)BOOL isOpen;
@property (nonatomic,retain)NSIndexPath *selectIndex;


@end
