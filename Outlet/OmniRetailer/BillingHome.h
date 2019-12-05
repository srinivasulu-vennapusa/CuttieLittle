//
//  BillingHome.h
//  OmniRetailer
//
//  Created by Satya Siva Saradhi on 23/10/12.
//  Copyright 2012 __techolabssoftware.com__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SkuServiceSvc.h"
#import "MIRadioButtonGroup.h"
#import "SKPSMTPMessage.h"
#import "MBProgressHUD.h"
#import "ColorPickerViewController.h"
#import "QImageView.h"
#import <MessageUI/MessageUI.h>
#include <AudioToolbox/AudioToolbox.h>
#import "MswipeWisepadController.h"
#import "WisePadController.h"
#import "MerchantSettings.h"
#import "CardSaleData.h"
#import "CardSaleResults.h"
//#import "ZBarSDK.h"
//#import "ZXingWidgetController.h"
#import "CustomTextField.h"
#import "OfflineBillingServices.h"
#import <PowaPOSSDK/PowaPOSSDK.h>
#import <ExternalAccessory/ExternalAccessory.h>
#import "DenominationView.h"
#import "CustomNavigationController.h"
#import "ReturnDenomination.h"
#import "WebServiceController.h"
#import "CustomIOSAlertView.h"
#import "KeychainItemWrapper.h"
#import "MemberServiceSvc.h"
#import "EmployeesSvc.h"
#import "Cell1.h"
#import "Cell2.h"
#import "BluetoothManager.h"
#import "BluetoothManagerHandler.h"

//added by Srinivasulu on 22/11/2017....

#import "CustomLabel.h"

//upto here on 22/11/2017....

typedef enum
{
    //when the transaction is approved online after submitting to the gatway for further
    //processing
    CardSale_TRXState_ApprovedOnline,
    //when on the screen swiper and the card swiper routines are in process then ignore the back key untill any routines that
    //has stopped the card process.
    CardSale_TRXState_Processing,
    //the rest of the time other then the above the state of the transaction will be in
    //completed state, this can be also intepreted as the transaction as not yest started
    CardSale_TRXState_Completed,
    
}CardSale_TRXState;

typedef enum

{
    WisePadConnectionState_connecting,
    WisePadConnectionState_scanning,
    WisePadConnectionState_disconnected,
    WisePadConnectionState_connected,
    
} WisePadConnectionState;

typedef enum
{
    ALERT_AMOUNT,
    ALERT_ERROR,
    ALERT_TRXCLOSE,
    HTTP_PROCESS_CARDSALE,
    NEW_CARDSALE,
    AUTO_REVERSAL_VOID,
    HTTP_PROCESS_AUTOVOID,
    DEVICE_LIST_DISPLAY,
    FALL_BACK,
    
} ProcessMode ;


typedef enum
{
    //the default state it will always be submiting to the online
    CardSale_TRXType_Online,
    //[[WisePadController sharedController] sendOnlineProcessResult:@""] this is called the
    // auto reversal is triggered and then consider performing the auto void onlye
    //when the transaction state is in CardSale_TRXState_ApprovedOnline, this suggests that
    //the transaction can be void if the its was approved and for the other states just ignore
    //the autorevesal
    CardSale_TRXType_Reversal,
    CardSale_TRXType_AUTOVOID,
}CardSale_TRXType;

@interface BillingHome : CustomNavigationController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, MBProgressHUDDelegate,ColorPickerViewControllerDelegate,UIGestureRecognizerDelegate,MFMessageComposeViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,WisePadControllerDelegate,MswiepWisePadControllerDelegate,CBCentralManagerDelegate,UIPopoverControllerDelegate,UIAlertViewDelegate,PowaTSeriesObserver,PowaScannerObserver,CreateBillingDelegate,SearchProductsDelegate,GetSKUDetailsDelegate,GetDealsAndOffersDelegate,CustomIOSAlertViewDelegate,GetBillsDelegate,UpdateBillingDelegate,OutletMasterDelegate,UICollectionViewDelegate,UICollectionViewDataSource,GetProductsByCategoryDelegate,UITextViewDelegate,CustomerServiceDelegate,GiftVoucherServicesDelegate,GiftCouponServicesDelegate,LoyaltycardServicesDelegate,GetOrderDelegate,OutletOrderServiceDelegate,MenuServiceDelegate,BookingRestServiceDelegate, EmployeeServiceDelegate, CustomerLedgerService, SalesServiceDelegate, GiftVoucherSrvcDelegate> {
     
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    
    UITextField *BillField;
    UITextField *custmerPhNum;
    UITableView* cartTable;
    
    //written by Srinivasulu on 12/09/2017....
    //reason this metthod is not in use/functionality implementation....
    
    UIScrollView* scrollView;
    CustomTextField *otherDiscountValueTxt;
    
    //upto here on 12/09/2017....
    
    
    NSMutableArray *skuArrayList;
    NSMutableArray *filteredSkuArrayList;
    NSMutableArray *filteredPriceArr;
    NSMutableArray *transactionArray; //added by sonali....
    UITableView *skListTable;
    NSMutableArray *cartItem;
    NSMutableArray *cartItemDetails;
    UISegmentedControl *segmentedControl;
    
    UITextField *dealoroffersTxt;
    UITextField *giftVoucherTxt;
    CustomTextField *otherDiscountTxt;
    UITextField *subtotalTxt;
    UITextField *taxTxt;
    UITextField *totalTxt;
    UITextField *phoneTxt;
    UITextField *emailTxt;
    UILabel *totalItemsLabel;
    UILabel *totalItemsLabelValue;
    
    
    
    UIView* paymentView;
    UIView* smsView;
    UIView* mailView;
    UIView* printView;
    UIView* giftView;
    UIView *cardDetailsView;
    
    
    NSTimer *aTimer;
    
    MIRadioButtonGroup *group;
    
    UILabel *billStatusLabel;
    UILabel *billStatusLabelValue;
    
    UITextField* payTxt1;
    UITextField* payTxt2;
    UITextField* payTxt3;
    
    
    UIActivityIndicatorView * spinner;
    UIImageView * bgimage;
    IBOutlet UILabel * loadingLabel;
    
    NSString *saleID;
    
    UIButton *barcodeBtn;
    UIButton *eraseButton;
    
    NSString *selected_SKID;
    NSString *selected_desc;
    NSString *selected_price;
    NSString *selectedPluCode;
    
    UITextField *giftType;
    NSString *giftTypeString;
    CustomTextField *giftNo;
    CustomTextField *giftID;
    CustomTextField *giftValidFrom;
    CustomTextField *giftValidTo;
    CustomTextField *giftAmt;
    
    UIButton *mainBackbutton;
    
    UILabel *amtLabel;
    UILabel *avai_points_label;
    UILabel *recash_label;
    
    UIButton *giftScannerBtn;
    CustomTextField *avai_points;
    CustomTextField *recash;
    
    UITableView *giftTypeTableView;
    NSMutableArray *giftTypeArrayList;
    
    MBProgressHUD *HUD;
    
    UITextField *presentTextField;
    UIToolbar* numberToolbar;
    
    UIButton *qty1;
    UIButton *priceButton;
    UIView *qtyChangeDisplyView;
    
    UITextField *qtyFeild;
    UITextField *newPriceField;
    UITextField *percentageDiscTxt;
    UITextField *percentageDiscValTxt;
    UITextField *reasontextField;
    UIButton *okButton;
    UIButton *qtyCancelButton;
    NSInteger qtyOrderPosition;
    int totalAmount;
    int buttonTitleIndex;
    
    UIButton *okEditPriceButton;
    UITableView *reasonsTable;
    
    UIView *detailsView;
    UIView *reasonView;
    
    QImageView *signView;
    UIView *backview;
    
    UIButton *okbtn;
    UIButton *cancelbtn;
    UIButton *color;
    UILabel *tlabel;
    
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
    NSMutableArray *unitOfMeasurement;
    NSMutableArray *sellSkuIds;
    NSMutableArray *dealItemsCount;
    NSMutableArray *tempSkuArrayList;
    NSMutableArray *taxArr;
    
    UIView *couponView;
    
    UITextField  *selectCouponType;
    UITextField *couponId;
    UITextField *couponValue;
    UITextField *couponQty;
    UILabel *totalCoupValue;
    UILabel *totalBill;
    UILabel *billDueLbl;
    UITableView *couponDeatails;
    UITableView *couponType;
    UITableView *valueTable;
    UITableView *allDealsOffersTable;
    UITableView *unappliedDealsOffersTable;
    
    
    NSMutableArray *couponArr;
    NSMutableArray *couponValArr;
    NSMutableArray *couponTotalArr;
    NSMutableArray *couponIdArr;
    NSMutableArray *cupon_type;
    NSMutableArray *value_arr;
    
    
    NSMutableArray *paymentTransactionArray;
    
    UIView *baseView;
    UITextField *smsField;
    UIView *addCustView;
    
    UITextField *phnotext;
    UITextField *emailtext;
    UITextField *nametext;
    UITextField *creditNoteTxt;
    UITextField *streettext;
    UITextField *locltytext;
    UITextField *citytext;
    UITextField *pintext;
    
    //added by Srinivauslu on 02/05/2017....
    
    UITextField * lastNameTxt;
    UITextField * doorNoTxt;
    UITextField * landMarkTxt;
    
    
    //upto here on 02/05/2017....
    
    
    UIButton *savebtn;
    UIButton *skipbtn;
    
    
    UILabel *label_1;
    UILabel *label_2;
    
    UIView *cardPayment;
    
    CardSale_TRXState mCardSale_TRXState;
    CardSale_TRXType mCardSale_TRXType;
    CardSaleResults *mcardSaleResults;
    MCRCardResults mCardResults;
    CardSaleData *mcardSaleData;
    WisePadConnectionState mConnesctionState;
    BOOL isEmvSwiper;
    ProcessMode processMode;
    NSString *lastConnectedBTv4DeviceName;
    
    BOOL bluetoothEnabled;
    CBCentralManager *bluetoothManager;
    
    UIButton *radioBtn1;
    UIButton *radioBtn2;
    
    //added by Srinivasulu on 20/04/2017....
    
    UIButton  * radioBtn3;
    
    //upto here on 20/04/2017....
    
    
    
    UIButton *cardradioBtn1;
    UIButton *cardradioBtn2;
    
    NSString *cardPaymentSelection;
    UIAlertView *saveAlert;
    
    BOOL giftClaimStatus;
    UIButton *giftTypeBtn;
    UIScrollView  *uiscroll_gift_view;
    UIScrollView *loyaltyScrollView;
    
    BOOL backAction;
    OfflineBillingServices *offline;
    UILabel *titleLbl;
    
    UIDeviceOrientation currentOriention;
    UILabel *dealoroffersTitle;
    UILabel *giftVoucherTitle;
    UILabel *otherDiscountTitle;
    UILabel *subtotalTitle;
    UILabel *totalTitle;
    UILabel *netPayLbl;
    UILabel *netPayLblVal;
    UILabel *customerStatusLbl;
    UIImageView *starRat;
    
    UILabel *label11;
    UILabel *label22;
    UILabel *label66;
    UILabel *label33;
    UILabel *label44;
    UILabel *label55;
    
    //added by Srinivasulu on 03/08/2017....
    
    UILabel * label77;
    
    //upto here 03/08/2017....
    
    //added by Srinivasulu on 12/09/2017....
    UIScrollView * listBilledItemsScrollView;
    
    UILabel *label88;
    UILabel *label99;
    UILabel *label10;
    
    //upto here 12/09/2017....
    
    UILabel *descLabl;
    UILabel *priceLbl;
    UILabel *mrpLbl;
    
    UILabel *phonelbl;
    UILabel *emaillbl;
    UILabel *namelbl;
    UILabel *label;
    UIButton *backbutton;
    UILabel *billLabel;
    UILabel *creditNoteTotalLbl;
    UILabel *creditNoteBalLbl;
    UILabel *creditNoteStatusLbl;
    UILabel *creditNoteLbl;
    UILabel *paidLbl;
    UIButton *payBtn ;
    UILabel *streetlbl;
    UILabel *localitylbl;
    UILabel *citylbl;
    UILabel *pinlbl;
    UILabel *taxTitle ;
    
    UITableView *priceTable;
    NSMutableArray *priceArr;
    NSMutableArray *descArr;
    NSMutableArray *priceDic;
    
    UIView *priceView;
    UIView *transparentView;
    DenominationView *denomination;
    
    int tensCount;
    int twentyCount;
    int fiftyCount;
    int hundredCount;
    int fiveHundredCount;
    int thousandCount;
    long oneCount;
    int twoCount;
    int fiveCount;
    int tenCoinCount;
    
    CustomTextField *tensQty;
    CustomTextField *twentyQty;
    CustomTextField *fiftyQty;
    CustomTextField *hundredQty;
    CustomTextField *fiveHundredQty;
    CustomTextField *thousandQty;
    CustomTextField *oneQty;
    CustomTextField *twoQty;
    CustomTextField *fiveQty;
    CustomTextField *tenCoinQty;
    
    
    UILabel *paidVal;
    UILabel *changeReturnVal;
    //    NSMutableDictionary *denominationDic;
    NSMutableDictionary *returnDenominationDic;
    NSMutableDictionary *denominationCoinDic;
    NSMutableDictionary *returnDenominationCoinDic;
    
    
    NSMutableArray *cartTotalItems;
    NSMutableArray *isVoidedArray;
    UIScrollView* paymentScrollView;
    
    UIAlertView *offlineMode;
    UIButton *valueBtn ;
    CGPoint loyaltyScrollPoint;
    
    int tensReturnCount;
    int twentyReturnCount;
    int fiftyReturnCount;
    int hundredReturnCount;
    int fiveHundredReturnCount;
    int thousandReturnCount;
    int oneReturnCount;
    int twoReturnCount;
    int fiveReturnCount;
    CustomTextField *tensReturnQty;
    CustomTextField *twentyReturnQty;
    CustomTextField *fiftyReturnQty;
    CustomTextField *hundredReturnQty;
    CustomTextField *fiveHundredReturnQty;
    CustomTextField *thousandReturnQty;
    CustomTextField *oneReturnQty;
    CustomTextField *twoReturnQty;
    CustomTextField *fiveReturnQty;
    
    UILabel *thousandReturnValue;
    UILabel *fiveHundReturnValue;
    UILabel *hundReturnValue;
    UILabel *fiftyReturnValue;
    UILabel *twentyReturnValue;
    UILabel *tenReturnValue;
    UILabel *fiveReturnValue;
    UILabel *twoReturnValue;
    UILabel *oneReturnValue;
    
    UILabel *thousandValue;
    UILabel *fiveHundValue;
    UILabel *hundValue;
    UILabel *fiftyValue;
    UILabel *twentyValue;
    UILabel *tenValue;
    UILabel *fiveValue;
    UILabel *twoValue;
    UILabel *oneValue;
    
    
    UIAlertView *cofirmAlert;
    UIAlertView *returnCofirmAlert;
    ReturnDenomination *returnDenomination;
    UILabel *returnedval;
    UILabel *returnAmtVal;
    
    UILabel *totalAmtVal;
    UILabel *excessAmt;
    UILabel *newCust;
    
    UILabel *cardInfoLbl;
    UILabel *approvalCodeLbl;
    UILabel *bankNameLbl;
    
    UITextField *cardInfoTxt;
    UITextField *approvalCodeTxt;
    UITextField *bankNameTxt;
    
    NSString *otherDiscountValue;
    
    NSMutableArray *isVegetable;
    
    UIView *headerView;
    UILabel *dateVal ;
    UILabel   *powaStatusLblVal;
    UILabel   *totalItemsLblVal;
    NSTimer *timer;
    
    //commented by Srinivasulu on 23/08/2017...
    //reason inorder to redue the crashs acrossed around this variable.. It has changed from class varible to local varible....
    
    // NSUserDefaults * defaults;
    
    //upto here on 23/08/2017....
    
    UILabel   *billCountLblVal;
    UILabel   *lastBillTotalLblVal;
    
    UISwitch *isSearch;
    UIButton *searchBarcodeBtn;
    NSString *foodCouponTypeStr;
    
    NSString *changeReturnStr;
    NSString *totalReceivedAmt;
    NSMutableDictionary *unAppliedDealItemDic;
    
    UILabel *suggestion;
    
    NSMutableArray *dealSkus;
    
    UIButton *customerInfoEnable;
    UIPopoverController *customerInfoPopOver;
    UIPopoverController *editPricePopOver;
    UIPopoverController *reasonPopOver;
    NSDictionary *customerInfoDic;
    NSMutableArray *observedObjsArr;
    NSMutableArray *isPriceEditableArr;
    NSMutableArray *editedPriceArr;
    UIButton *quickPayBtn;
    
    NSString *itemScanStartTime;
    NSString *itemScanEndTime;
    UILabel *cardNumber;
    UILabel *cardID;
    BOOL editPriceStatus;
    NSMutableDictionary *deletedTaxDic;
    NSMutableArray *giftVoucherArr;
    BOOL billingErrorStatus;
    NSMutableArray *itemDiscountArr;
    NSMutableArray *itemDiscountDescArr;
    NSMutableArray *itemScanCode;
    NSMutableArray *onlineOfferDiscountPriceArr;
    NSMutableArray *onlineDealDiscountPriceArr;
    NSMutableArray *totalDealsArr;
    NSMutableArray *totalOffersArr;
    NSMutableArray *itemWiseAvailableOffers;
    NSMutableArray *itemWiseAvailableDeals;
    NSMutableArray *displayingDealsOffersArr;
    NSMutableArray *totalDealSkusArr;
    NSMutableArray *appliedDealIdsArr;
    NSMutableArray *appliedOfferIdsArr;
    NSMutableArray *dealPromItemsList;
    
    
    NSMutableArray *manufacturedItemsArr;
    
    UITextField *phoneNumberText;
    float turnoverofferDiscount;
    int unAppliedDealIndex;
    NSString *turnOverFreeItems;
    NSArray *turnOverFreeItemsDesc;
    
    NSMutableArray *skuIdList;
    NSMutableArray *pluCodeList;
    NSMutableArray *unitPriceList;
    NSMutableArray *qtyList;
    NSMutableArray *totalPriceList;
    NSMutableArray *itemStatusList;
    NSMutableArray *itemDiscountList;
    NSMutableDictionary *bill_details;
    NSString *draftBillID;
    
    UIButton* loginbut;
    UIButton *loginbut1;
    UIView *loginView;
    UILabel *password;
    UITextField *userIDtxt;
    UITextField *emailIDtxt;
    UITextField *passwordtxt;
    UIView *loginTransperentView;
    UIView *loadingView;
    UILabel *loadingMsgLbl;
    BOOL isScanningItem;
    UIActivityIndicatorView *textFieldSpinner;
    BOOL isSearchingItem;
    NSMutableArray *itemPromoFlagArr;
    
    UITableView *freeItemsTbl;
    NSMutableArray *unappliedDealsSkuIdArr;
    NSMutableArray *unappliedDealsSkuDescArr;
    
    UITextField *salesPersonId;
    NSMutableArray *employeeIdsArr;
    UITableView *salesPersonTbl;
    
    NSString *salesPersonIdStr;
    
    UIView *transparentViewEmp;
    
    UITextField *empCodeTxt;
    UITextField *empNameTxt;
    UITextField *empLocTxt;
    
    UIView  *employeeView;
    NSMutableArray *departmentArr;
    UITableView *deprtmntTbl;
    UITextField *departmentFld;
    NSMutableArray *subDepartmentArr;
    
    //added by Srinivasulu on 22/06/2017....
    
    NSMutableDictionary * dept_SubDept_Dic;
    
    //upto here on 22/06/2017....
    
    UIView *customerSpecificView;
    UITableView *subDepartmentTbl;
    UITextField *subDepartmentFld;
    UITextField *salesPersonIdFld;
    
    NSMutableDictionary *employeeDic;
    
    BOOL isItemEmpl;
    UITextField *salesPersonNameFld;
    
    UIPopoverController *salesInfoPopUp;
    
    UITableView *menuTable;
    UIButton *popButton;
    NSMutableArray *categoriesArr;
    NSMutableArray *subCategoriesArr;
    //    NSMutableArray *itemsArr;
    BOOL isGridView;
    UICollectionView *gridView;
    
    
    //added by Srinivasulu on 19/01/2017....
    
    
    BOOL  isItemScanned;
    
    NSMutableDictionary *discountIdsArr;
    
    NSMutableArray *isPackagedItem;
    
    NSMutableArray *taxTypeArr;
    
    UIButton *isFlatDiscBtn;
    UIButton *isPercentileDiscBtn;
    
    BOOL isFlatDisc;
    
    //upto here on 19/01/2016....
    
    //  added by Bhargav on 27/1/2017...
    
    UIPopoverController * productmenuInfoPopUp;
    UIButton * productMenuBtn;
    UILabel *menuHeaderView;
    UIView * productmenuView;
    UIButton * listViewBtn;
    UIButton * gridViewBtn;
    UITableView * productMenuTbl;
    UITableView * subCategoryTbl;
    
    UIButton * viewListOfItemsBtn;
    UITextField *denomValueTxt;
    NSMutableArray *denomValTxtArr;
    NSMutableArray *denomCountArr;
    NSMutableArray *denomValCoinsTxtArr;
    NSMutableArray *denomCountCoinsArr;
    UIView *denominationView;
    
    UITextField *returnDenomValueTxt;
    NSMutableArray *returnDenomValTxtArr;
    NSMutableArray *returnDenomCountArr;
    NSMutableArray *returnDenomValCoinsTxtArr;
    NSMutableArray *returnDenomCountCoinsArr;
    UIView *returnDenominationView;
    
    BOOL isReturnDenom;
    
    NSMutableArray *productInfoArr;
    
    BOOL isItemUnVoided;
    
    BOOL isSearchBool;
    
    NSMutableArray *zeroStockAvailInfoArr;
    
    BluetoothManager *btManager;
    
    NSString *originalBillId;
    
    UILabel *colorLbl;
    UILabel *sizeLbl;
    
    //added by Srinivasulu on 18/04/2017....
    
    
    UILabel * userAlertMessageLbl;
    NSTimer * fadeOutTime;
    
    //    NSMutableArray * hsnArr;
    
    NSMutableArray * taxDispalyArr;
    UIScrollView * taxDetailsScrollView;
    UIImageView * scrollViewBarImgView;
    //upto here on 18/04/2017....
    
    
    //added by Srinivasulu on  17/07/2017....
    
    UIAlertView * cancelBillAlertView;
    
    //added by Srinivasulu on 26/07/2017....
    NSMutableDictionary * turnOverOfferIdsDic;
    
    //upto here on 17/07/2017....
    
    
    
    //added by Saikrishna Kumbhoji on 25/07/2017....
    
    UIView * customerView1;
    UITextField * firstNameTxt;
    UITextField * lastNameTxt1;
    UITextField * gtinTxt;
    UITextField * emailAddressTxt;
    UITextField * addressTxt1;
    UITextField * addressTxt2;
    UITextField * addressTxt3;
    UITextField * addressTxt4;
    UITextField * addressTxt5;
    UITextField * addressTxt6;
    
    
    
    //    PopOverViewController * customerInfoPopUp;
    //UIPopoverController *customerInfoPopUp;
    
    
    UIButton * submitBtn;
    UIButton * cancelBtn1;
    
    //upto here as on 25/07/2017....
    
    //added by Srinivasulu on 10/08/2017....
    
    float offSetViewTo;
    
    
    
    //upto here on 10/08/2017....
    
    
    //added by Srinivasulu on 21/08/2017 && 24/08/2017 && 31/08/2017 && 06/09/2017....
    
    UIView * editPriceView;
    
    NSMutableArray * editPriceReasonArr;
    UITableView * editPriceReasonTbl;
    UITextField * editPriceReasonTxt;

    UITextField * returnAmountTxt;
    
    UIView * transperentView;

    UITableView * voidItemReasonsTbl;
    NSMutableArray * isVoidItemArr;
    NSMutableArray * itemVoidReasonsArr;
    UITextField * itemEditPriceTxt;
    UITextField * itemEditPriceReasonTxt;
    UITextField * itemEditQtyTxt;
    UITextField * isItemVoidTxt;
    UITextField * itemVoidReasonTxt;
    UITextField * itemFlatDiscountTxt;
    UITextField * itemPrecentageDiscountTxt;
    UITextField * itemPrecentageDiscountValueTxt;
    UITextField * itemsSalePersonTxt;
    UITextField * itemsSalePersonIdTxt;
    UITextField * itemsSalePersonDeptTxt;
    UITextField * itemsSalePersonSubDeptTxt;
    //view used to display all information....
    UIView * editItemDetailsView;
    UIView * cancelBillView;
    UITableView * itemCancelReasonsTbl;
    NSMutableArray * itemCancelReasonArr;
    UITextField * itemCancelReasonTxt;

    //upto here on 21/08/2017 && 24/08/2017 && 31/08/2017 && 06/09/2017....
    
    
    //changed by Srinivasulu on 08/09/2017....
    //reason is they are using as properties they are producting crash.... while changing from online to offline....
    
    NSString * totalBillAmountStr;
    NSString * customerGstinStr;
    
    
    //added by Srinivasulu on 28/09/2017 && 07/03/2018....
    
    NSMutableArray * isItemFlatDiscountedArr;
    
    NSMutableArray * isItemTrackingRequiredArr;
    
    
    //upto here on 28/09/2017 && 07/03/2018....
    
    UILabel  * completeBillDiscountValueLbl;
    
    //added by Srnivasulu on 12/11/2017....
    
    UITextField * denominationTypeTxt;
    UITextField * conversionRatioTxt;
    UITextField * totalDenominationsCountTxt;
    
    NSMutableArray * denominationsTypeArr;
    UITableView * denominstaionsTypeTbl;
    
    float origingY;
    
    //upto her eon 12/11/2017....
    
    
    //added by Srinivasulu on 21/11/2017....
    
    UITextField * cardTypeTxt;
    NSMutableArray * cardTypesArr;
    UITableView * cardTypesTbl;
    
    UITextField * otherPaymentTypeTxt;
    UITextField * otherPaymentReferenceNumTxt;
    UITextField * otherPaymentCountTxt;
    UITextField * otherPaymentAmountTxt;
    
    CustomLabel * paymentRefNoLbl;
    CustomLabel * paymentModeLbl;
    CustomLabel * paymentValueLbl;
    CustomLabel * paymentCountLbl;
    CustomLabel * paymentTotalLbl;
    
    UITableView * otherPaymentsDetailsTbl;
    NSMutableArray * otherPaymentsDeatilsArr;
    
    UITableView * otherPaymentsOptionsTbl;
    NSMutableArray * otherPaymentsOptionsArr;
    
    UILabel * otherPaymentTotalAmountLbl;
    
    
    NSMutableDictionary * billPaymentTendeInfoDic;
    
    CustomTextField * enterOtpTxt;
    
    CustomTextField * cardIssuedOnTxt;
    CustomTextField * cardIssuedToTxt;
    
    
    CustomTextField * cardStatusTxt;
    
    UILabel * giftViewHeaderLbl;
    UILabel * giftTypeLbl;
    UILabel * giftIssuedOnLbl;
    UILabel * giftIssuedToLbl;
    UILabel * giftStatusLbl;
    UILabel * giftValideFromLbl;
    UILabel * giftValideToLbl;
    //    UILabel * amtLabel;
    //    UILabel * recash_label;
    UILabel * generateOtpBackGroundLbl;
    
    UIImage * buttonImageDD1;
    
    UIButton * giftOkBtn;
    UIButton * giftCancelBtn;
    
    UIButton * generateOtpBtn;
    
    UIView * otpView;
    //upto here on 21/11/2017....
    
    NSTimer * intervalTImer;
    
    NSString * returnMode;
    
    
    UIButton * refreshOnlineOrderBtn;
    UITextField * billRemarksTxt;
    
    
    // Added By Bhargav.v on 26/02/2018...
    // Reason: Taking the UIElements for the Order functionality.....
    
    UIButton * onlineOrderBtn;
    UIButton * mobileOrderBtn;
    UIButton * telePhoneOrderBtn;
    
    NSMutableArray * onLineArray;
    NSMutableArray * mobileArray;
    NSMutableArray * telePhoneArray;
    NSMutableArray * itemListArray;
    
    UIView * orderDetailsTransparentView;
    UIView * orderDetailsView;
    
    CustomLabel * snoLabel;
    CustomLabel * skuidLabel;
    CustomLabel * descriptionLabel;
    CustomLabel * uomLabel;
    CustomLabel * quantityLabel;
    CustomLabel * mrpLabel;
    CustomLabel * discountLabel;
    CustomLabel * salePriceLabel;
    CustomLabel * costLabel;
    
    UITableView     * orderItemDetailsTable;
    NSDictionary    * OrderDetailsDictionary;
    CustomTextField * pagenationTxt;
    UITableView     * ordersPagenationTable;
    
    NSMutableArray  * orderListArr;
    
    BOOL isToDisplayOrderView;
    
    UILabel * orderIdValueLabel;
    UILabel * dateAndTimeValueLabel;
    UILabel * customerNameValueLabel;
    UILabel * contactNumberValueLabel;
    UILabel * paymentStatusValueLabel;
    UILabel * paymentModeValueLabel;
    UILabel * paidAmountValueLabel;
    UILabel * subTotalValueLabel;
    UILabel * taxValueLabel;
    UILabel * shipmentChargeValueLabel;
    UILabel * netBillAmountvalueLabel;
    
    
    
    BOOL isToScrollViewBillItemsAutomatically;
    
    //added by Srinivasulu on 02/05/2017 && 21/05/2018 && 26/06/2018....
    
    
    
    UIScrollView * verticalScrollView;
    
    UILabel * customerPurchasesLbl;
    UIButton * showCustomerPurchasesBtn;
    
    CustomLabel * customerPurchasedSkuIdLbl;
    CustomLabel * customerPurchasedSkuNameLbl;
    CustomLabel * customerPurchasedSkuQtyLbl;
    CustomLabel * customerPurchasedSkuValueLbl;
    
    NSMutableArray * listOfCustomerPurchasesArr;
    UITableView * listOfCustomerPurchasesTbl;
    
    UICollectionView * menuCategoriesView;
    UICollectionView * menuCategoriesItemsCollectionView;
    NSMutableDictionary * menuCategoriesDic;
    
    float orderShipmentCharges;
    //upto here on 03/05/2018 && 21/05/2018 && 26/06/2018....
    
    
    //moved from .h to .m by srinivasulu on 02/08/2018.. due to errors..
    
    int startIndexint_;
    NSString *amount;
    NSString *giftNumber;
    NSMutableString *typeOfPayment;
    NSMutableArray *textFieldData;
    NSMutableArray *textLabel;
    
    
    float version ;
    UIButton *newbill;
    UIButton *pastBill;
    UIButton *giftSearchBtn;
    
    MerchantSettings *settings;
    //    CardSaleData *mcardSaleData;
    
    float yposition ;
    
    
    UILabel *host1;
    UILabel *inr;
    UIButton *nextBtn;
    UIButton *cancelBtn;
    UILabel *sale;
    UIView *transactionView;
    UIView *cardDetails;
    UITextView *info;
    NSMutableArray *swiperMsgs;
    UIButton   *startBtn;
    UIButton *continue_transaction;
    UILabel *card_holder;
    UILabel *expiry_date;
    UILabel *amount1;
    UILabel *last_digits;
    UIImageView *signature_view;
    UIButton *clearSign;
    UIButton *signSubmit;
    UIAlertView *approved;
    UIView *receipt_view;
    UIView *buttonView;
    UIAlertView *signature;
    NSString *status_mswipe;
    UIView *amountView;
    UILabel *amt;
    UILabel *totalAmt1;
    NSString *deliveryType;
    NSString *doorDeliveryType;
    NSString *delStatus;
    NSString *searchString;
    NSString *dealSkuId;
    
    NSInteger segment_index ;
    
    NSMutableArray *turnOverDealVal;
    NSMutableDictionary *offerDic;
    
    UIButton   * closeBtn ;

    //upto here...

    UIButton * fetchDataButton;
    
    UILabel * billValueLabel;
    CustomTextField  * minimumValueText;
    CustomTextField  * maximumValueText;
    float couponUnitCashPercentageValue;
    float couponUnitCashValue;

    //added on 28/08/2018 && 03/09/2018....
    BOOL isHybirdCallFailed;
    
    NSMutableArray * memberShipTypeArr;
    UITableView * memberShipTypeTbl;
    
    UITextField * mobileNumberText;
    UITextField * memberShipText;
    UIButton * memberShipCheckBoxBtn;
    UIButton * houseCheckBtn;
    UIButton * flatCheckBtn;
    UIButton * showmemberShipOptionsBtn;

    Boolean isMemberShipItemAdded;
    Boolean isFirstTimeMemberShip;
    Boolean customerMemberShipStatus;
    Boolean isToCreateNewMemberShip;
    
    // added by roja on 29-08-2018....
    UIView * cardPaymentView;
    
    NSMutableArray * addCardPaymentDetailsArr;
    NSMutableArray * cardPaymentButtonArr;
    
    UILabel * completePaidAmtLbl;
    UILabel * netBillAmountValueLbl;
    UILabel * completePaidAmtValueLbl;
    
    UITextField * cardHolderPhoneNumTxt;
    UITextField * paidAmtTxt;
    
    //added by Srinivasulu on 15/10/2018....
    UILabel * amountToBePaidValLbl;

    Boolean isF_B_OrderBill;
    UISegmentedControl * topSegmentControl;
//    int selectedTopSegmentControlIndex;
    
    UIView * tableOrdersMenuView;


    NSMutableDictionary * FBOrderDetailsInfoDic;
    
    // added by roja on 10/05/2019.. // To store Offline Customer Loyalty details...
//    NSDictionary * customerLoyaltyCardDic;
    
    // added by roja on 29/07/2019...
    UIButton * senderBtn;
    
    // for wallet..
    UILabel * walletUserFirstNameLbl;
    UILabel * walletUserHouseNoLbl;
    UILabel * walletUserLocalityLbl;
    UILabel * walletUserCityLbl;
    UILabel * walletUserEmailIdLbl;
    UILabel * walletAmountLbl;
    UILabel * walletPhoneNobl;

    CustomTextField * walletUserFirstNameTF;
    CustomTextField * walletUserLastNameTF;
    CustomTextField * walletUserHouseNoTF;
    CustomTextField * walletUserLocalityTF;
    CustomTextField * walletUserCityTF;
    CustomTextField * walletUserEmailIdTF;
    CustomTextField * walletAmountValueTF;
    
    UIButton * checkWalletBalanceBtn;
    Boolean isWalletItemAdded;
    Boolean isToCallCreateWalletService;
    float walletCreditAmt;
    float walletDebitAmt;
    // upto here added by roja on 29/07/2019...

    //Added by sai on 29/07/2019
    NSMutableArray *salesPersonIDArr;
    NSMutableArray *deliveryPersonIDArr;
    UITextField *deliveryPersonId;
    UITableView *deliveryPersonTbl;
    //Upto here by sai on 29/07/2019
    
    
    // added by roja on 17/10/2019
    BOOL isCustomerDetailsCall;
    BOOL isWalletBtnSelected;
    float minRedeemPoints;
    // Upto here added by roja on 17/10/2019

    
    
    
    
    
}

//added by Srinivasulu on 02/08/2017 && 12/08/2017 && 30/01/2018....

//@property(nonatomic,strong) NSString * totalBillAmountStr;
//@property(nonatomic,strong) NSString * customerGstinStr;


    
    
@property (nonatomic, strong) NSMutableArray     * itemsFromCartArr;
@property (nonatomic, strong) NSString * salesOrderIdStr;
@property (nonatomic, strong) NSString * salesOrderBookingTypeStr;
@property (assign)BOOL isOrderedBill;

//@property(nonatomic,strong) NSString * isNewReturnBill;
@property (assign)BOOL isNewReturnBill;
@property (assign)BOOL isDuplicateBillIdResponse;
//- (void) continuePay1;

//upto here on 02/08/2017 && 12/08/2017 && 30/01/2018....

@property(nonatomic,strong)UIView *amountView;
@property(nonatomic,strong)UILabel *amt;
@property(nonatomic,strong)UILabel *phoneNo;
@property(nonatomic,strong)UILabel *emailId;
@property(nonatomic,strong)NSString *total;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)CBCentralManager *bluetoothManager;

@property (nonatomic, strong) NSString   *mstrEMVProcessTaskType;
@property (nonatomic, strong) NSString   *mAmexSecurityCode;
@property (nonatomic, strong) NSString   *draftBillID;

@property(nonatomic,strong)MerchantSettings *mSettings;
@property (nonatomic, strong) CardSaleData       *mCardSaleData;
@property (nonatomic, strong) CardSaleResults     *mCardSaleResults;
@property(nonatomic,strong) NSString *lastConnectedBTv4DeviceName;

@property (nonatomic,retain)NSIndexPath *selectIndex;
@property (nonatomic,retain)NSIndexPath *selectSectionIndex;
@property (assign)BOOL isOpen;

-(void)nextAction:(id)sender;

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property(nonatomic, retain)IBOutlet UITextField *BillField;
@property(nonatomic, retain)IBOutlet UITextField *payTxt1;
@property(nonatomic, retain)IBOutlet UITextField *payTxt2;
@property(nonatomic, retain)IBOutlet UITextField *payTxt3;
@property(nonatomic, retain)NSTimer *aTimer;
@property(nonatomic, retain)NSMutableArray* skuArrayList;
@property(nonatomic, retain)NSMutableArray* filteredSkuArrayList;
@property(nonatomic, retain)IBOutlet UILabel * loadingLabel;
@property(nonatomic, retain)UIImageView * bgimage;
@property(nonatomic, retain)UIActivityIndicatorView * spinner;
@property(nonatomic, retain)NSMutableArray* giftTypeArrayList;
@property (nonatomic, strong) UITextField *presentTextField;
@property (strong, nonatomic) UIPopoverController* popOver;

- (void) barcodeScanner:(id)sender;
- (NSString *) saveBill;
-(NSString *) emailBill:(NSString *)imgId;
- (BOOL) validateEmail: (NSString *) candidate;

- (void) showgiftView;
- (void) giftContinue:(id) sender;
- (void) continuePay:(id) sender ;
- (void) continuePay2;

- (IBAction)addTens:(UIButton *)sender;
- (IBAction)removeTens:(UIButton *)sender;

- (IBAction)addTwenty:(UIButton *)sender;
- (IBAction)removeTwenty:(UIButton *)sender;
- (IBAction)addFifty:(UIButton *)sender;
- (IBAction)removeFifty:(UIButton *)sender;
- (IBAction)addHundred:(UIButton *)sender;
- (IBAction)removeHundred:(UIButton *)sender;
- (IBAction)addFiveHundred:(UIButton *)sender;
- (IBAction)removeFiveHundred:(UIButton *)sender;
- (IBAction)addThousand:(UIButton *)sender;
- (IBAction)removeThousand:(UIButton *)sender;
- (IBAction)removeRupee:(UIButton *)sender;
- (IBAction)addRupee:(UIButton *)sender;
- (IBAction)removeTwo:(UIButton *)sender;
- (IBAction)addTwoCoin:(UIButton *)sender;
- (IBAction)removeFiveCoin:(UIButton *)sender;
- (IBAction)addFiveCoin:(UIButton *)sender;
- (IBAction)removeTenCoin:(UIButton *)sender;
- (IBAction)addTenCoin:(UIButton *)sender;
-(BOOL)isSegmentAcessible:(NSString*)segmentActivity appDocument:(NSString*)appDocument;

// added by roja on 03/12/2019..


@property (assign)BOOL isPaidVoucher;
@property(nonatomic,strong) NSString * issueVoucherDetailsStr;
@property (nonatomic, strong) NSDictionary * paidVoucherItemDetailsDic;


@end



