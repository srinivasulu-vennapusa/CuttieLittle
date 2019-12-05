//
//  ExchangingBillingHome.h
//  OmniRetailer
//
//  Created by Satya Siva Saradhi on 23/10/12.
//  Copyright 2012 __techolabssoftware.com__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SDZSkuService.h"
#import "SkuServiceSvc.h"
#import "MIRadioButtonGroup.h"
#import "SKPSMTPMessage.h"
#import "MBProgressHUD.h"
#import "ColorPickerViewController.h"
#import "QImageView.h"
#import <MessageUI/MessageUI.h>
#include <AudioToolbox/AudioToolbox.h>
//#import <MailCore/MailCore.h>
//#import "ZXingWidgetController.h"
#import "MswipeWisepadController.h"
#import "WisePadController.h"
#import "MerchantSettings.h"
#import "CardSaleData.h"
#import "CardSaleResults.h"
#import "CheckWifi.h"
#import "CustomTextField.h"
#import <PowaPOSSDK/PowaPOSSDK.h>
#import <ExternalAccessory/ExternalAccessory.h>
#import "CustomNavigationController.h"
#import "DenominationView.h"
#import "ReturnDenomination.h"
#import "WebServiceController.h"
#import "OfflineBillingServices.h"
#import "OmniRetailerViewController.h"
#import "DealModel.h"
#import "OfferModel.h"
#import "ApplyDealModel.h"
#import "ApplyOfferModel.h"

//added by Srinivasulu on 22/11/2017....

#import "CustomLabel.h"

//upto here on 22/11/2017....

typedef enum
{
    //when the transaction is approved online after submitting to the gatway for further
    //processing
    CardSale_TRXState_ApprovedOnlineExch,
    //when on the screen swiper and the card swiper routines are in process then ignore the back key untill any routines that
    //has stopped the card process.
    CardSale_TRXState_Processing1Exch,
    //the rest of the time other then the above the state of the transaction will be in
    //completed state, this can be also intepreted as the transaction as not yest started
    CardSale_TRXState_Completed1Exch,
    
}CardSale_TRXStateExch;

typedef enum

{
    WisePadConnectionState_connectingExch,
    WisePadConnectionState_scanningExch,
    WisePadConnectionState_disconnectedExch,
    WisePadConnectionState_connectedExch,
    
} WisePadConnectionStateExch;

typedef enum
{
    ALERT_AMOUNTExch,
    ALERT_ERRORExch,
    ALERT_TRXCLOSEExch,
    HTTP_PROCESS_CARDSALEExch,
    NEW_CARDSALEExch,
    AUTO_REVERSAL_VOIDExch,
    HTTP_PROCESS_AUTOVOIDExch,
    DEVICE_LIST_DISPLAYExch,
    FALL_BACKExch,
    
} ProcessModeExch ;


typedef enum
{
    //the default state it will always be submiting to the online
    CardSale_TRXType_OnlineExch,
    //[[WisePadController sharedController] sendOnlineProcessResult:@""] this is called the
    // auto reversal is triggered and then consider performing the auto void onlye
    //when the transaction state is in CardSale_TRXState_ApprovedOnline, this suggests that
    //the transaction can be void if the its was approved and for the other states just ignore
    //the autorevesal
    CardSale_TRXType_ReversalExch,
    CardSale_TRXType_AUTOVOIDExch,
}CardSale_TRXTypeExch;

//#import "ZBarSDK.h"

@interface ExchangingBillingHome : CustomNavigationController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, MBProgressHUDDelegate,ColorPickerViewControllerDelegate,UIGestureRecognizerDelegate,MFMessageComposeViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,WisePadControllerDelegate,MswiepWisePadControllerDelegate,CBCentralManagerDelegate,UIPopoverControllerDelegate,SearchProductsDelegate,GetSKUDetailsDelegate,GetDealsAndOffersDelegate,CreateBillingDelegate,ExchangeBillingDelegate,OutletMasterDelegate,UITextViewDelegate,CustomerServiceDelegate,GiftVoucherServicesDelegate,GiftCouponServicesDelegate,LoyaltycardServicesDelegate,GetBillsDelegate, EmployeeServiceDelegate, SalesServiceDelegate> 
{
    
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    
    UITextField *BillField;
    UITableView* cartTable;
    UIScrollView* scrollView;
    NSMutableArray *skuArrayList;
    NSMutableArray *filteredSkuArrayList;
    NSMutableArray *transactionArray1;
    UITableView *skListTable;
    NSMutableArray *cartItem;
    UISegmentedControl *segmentedControl;
    NSString *dealSkuId;
    UITextField *dealoroffersTxt;
    UITextField *giftVoucherTxt;
    UITextField *subtotalTxt;
    UITextField *taxTxt;
    UITextField *creditsTxt;
    UITextField *totalTxt;
    UITextField *billToBePaidTxt;
    UITextField *exchCredidsTxt;
    UILabel *exchCredidsLbl;
    CustomTextField *otherDiscountTxt;

    
    
    UIView* paymentView;
    UIView* smsView;
    UIView* mailView;
    UIView* printView;
    UIView* giftView;
    
    
    NSTimer *aTimer;
    
    MIRadioButtonGroup *group;
    
    UILabel *billStatusLabel;
    UILabel *billStatusLabelValue;
    
    UITextField* payTxt1;
    UITextField* payTxt2;
    UITextField* payTxt3;
    UILabel *denominationLabel;
    UIActivityIndicatorView * spinner;
    UIImageView * bgimage;
    IBOutlet UILabel * loadingLabel;
    UIButton *denominationBackbutton;
    NSString *saleID;
    NSString *selected_price;
    UIButton *barcodeBtn;
    
    NSString *selected_SKID;
    NSString *selected_desc;
    
    UITextField *giftType;
    UITextField *giftNo;
    UITextField *giftValidFrom;
    UITextField *giftValidTo;
    UITextField *giftAmt;
    NSString *giftTypeString;
    
    UIButton *mainBackbutton;
    
    UILabel *amtLabel;
    UILabel *avai_points_label;
    UILabel *recash_label;
    UILabel *paymentViewlabel;
    UIButton *paymentViewBackButton;
    UIButton *giftScannerBtn;
    UITextField *avai_points;
    UITextField *recash;
    
    UITableView *giftTypeTableView;
    NSMutableArray *giftTypeArrayList;
    
    MBProgressHUD *HUD;
    
    UITextField *presentTextField;
    UIToolbar* numberToolbar;
    
    UIButton *priceButton;
    UIView *qtyChangeDisplyView;
    
    UITextField *qtyFeild;
    UIButton *okButton;
    UIButton *qtyCancelButton;
    NSInteger qtyOrderPosition;
    int totalAmount;
    UITextField *newPriceField;
    UIButton *okEditPriceButton;
    
    UIView *detailsView;
    
    
    QImageView *signView;
    OfflineBillingServices *offline;
    UIView *backview;
    
    UIButton *okbtn;
    UIButton *cancelbtn;
    UIButton *color;
    UILabel *tlabel;
    
    NSString *totalReceivedAmt;
    NSString *foodCouponTypeStr;
    NSString *changeReturnStr;
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
    NSMutableArray *sellSkuIds;
    NSMutableArray *dealItemsCount;
    NSMutableArray *filteredPriceArr;
    NSString *billIDValue;
    UIView *baseView;
    UITextField *smsField;
    UIView *addCustView;
    
    UITextField *phnotext;
    UITextField *emailtext;
    UITextField *nametext;
    UITextField *streettext;
    UITextField *locltytext;
    UITextField *citytext;
    UITextField *pintext;
    
    //added by Srinivauslu on 02/05/2017....
    
    UITextField * lastNameTxt;
    UITextField * doorNoTxt;
    UITextField * landMarkTxt;
    
    
    //upto here on 04/05/2017....
    
    UIButton *savebtn;
    UIButton *skipbtn;
    
    
    UILabel *label_1;
    UILabel *label_2;
    
    NSMutableArray *dealDataItemsExch;
    NSMutableArray *cartItemDetails;
    NSMutableArray *textFieldData;
    NSString *amount;
    UIButton *eraseButton;
    NSMutableString *typeOfPayment;
    
    UIView *cardPayment;
    
    UIPopoverController *editPricePopOver;

    CardSale_TRXStateExch mCardSale_TRXState;
    CardSale_TRXTypeExch mCardSale_TRXType;
    CardSaleResults *mcardSaleResults;
    MCRCardResults mCardResults;
    CardSaleData *mcardSaleData;
    WisePadConnectionStateExch mConnesctionState;
    BOOL isEmvSwiper;
    ProcessModeExch processMode;
    NSString *lastConnectedBTv4DeviceName;
    
    BOOL bluetoothEnabled;
    CBCentralManager *bluetoothManager;
    
    UIButton *radioBtn1;
    UIButton *radioBtn2;
    
    NSString *turnOverDis;
    NSString *offerDescStr;
    NSString *turnOverDealDes;
    NSMutableArray *turnOverDealVal;
    NSMutableDictionary *offerDic;
    float dealTempVal;
    
    UIAlertView *saveAlert;
    
    BOOL giftClaimStatus;
    UIButton *giftTypeBtn;
    
    BOOL backAction;
    UIButton *cardradioBtn1;
    UIButton *cardradioBtn2;
    UIButton *giftSearchBtn;
    NSString *cardPaymentSelection;
    UILabel *creditsLabel;
    
    UIDeviceOrientation currentOriention;
    NSMutableArray *textLabel;
    float yposition;
    UILabel *taxLbl;
    
    UILabel *label11;
    UILabel *label22;
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
    CustomTextField *otherDiscountValueTxt;

    //upto here 12/09/2017....
    
    
    UILabel *dealoroffersTitle;
    UILabel *giftVoucherTitle;
    UILabel *otherDiscountTitle;
    UILabel *subtotalTitle;
    UILabel *totalTitle;
    UILabel *taxTitle;
    UILabel *billPaidLbl;
    
    UITableView *priceTable;
    NSMutableArray *priceArr;
    NSMutableArray *descArr;
    NSMutableArray *priceDic;
    
    UIView *priceView;
    UIView *transparentView;
    
    UILabel *descLabl;
    UILabel *priceLbl;
    UILabel *mrpLbl;
    
    NSMutableArray *tempSkuArrayList;

    NSMutableArray *taxArr;

//    NSMutableDictionary *denominationDic;
    NSMutableDictionary *denominationCoinDic;
    NSMutableDictionary *returnDenominationCoinDic;
 
    NSMutableDictionary *returnDenominationDic;
    
    NSMutableArray *cartTotalItems;
    NSMutableArray *isVoidedArray;
    UIScrollView* paymentScrollView;
    UILabel *paidVal;
    UILabel *changeReturnVal;
    UILabel *totalItemsLabel;
    UILabel *totalItemsLabelValue;


    
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
    
    UIAlertView *offlineMode;

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
    
    NSMutableArray *couponArr;
    NSMutableArray *couponValArr;
    NSMutableArray *couponTotalArr;
    NSMutableArray *couponIdArr;
    NSMutableArray *cupon_type;
    NSMutableArray *value_arr;
    UIButton *valueBtn;
    
    NSMutableArray *paymentTransactionArray;
    NSMutableArray *editedPriceArr;
    NSString *otherDiscountValue;
    NSString *searchString;

    UIView *headerView;
    UILabel *dateVal ;
    UILabel   *powaStatusLblVal;
    NSTimer *timer;
    NSUserDefaults *defaults;
    UILabel   *billCountLblVal;
    UILabel   *lastBillTotalLblVal;
    
    UISwitch *isSearch;
    UIButton *searchBarcodeBtn;

    UILabel *newCust;
    UILabel *cardNumber;
    UILabel *cardID;
    CustomTextField *giftID;
    NSMutableArray *giftVoucherArr;
    BOOL billingErrorStatus;
    CustomTextField *custmerPhNum;
    UIImageView *starRat;
    NSMutableDictionary *deletedTaxDic;
    UIButton *customerInfoEnable;
    
    BOOL isItemEmpl;
    UITextField *salesPersonNameFld;
    
    UIPopoverController *salesInfoPopUp;
    NSMutableDictionary *discountIdsArr;
    
    NSMutableArray *isPackagedItem;
    
    UIButton *isFlatDiscBtn;
    UIButton *isPercentileDiscBtn;
    
    BOOL isFlatDisc;
    UIButton * viewListOfItemsBtn;
    UITextField *denomValueTxt;
    NSMutableArray *denomValTxtArr;
    NSMutableArray *denomCountArr;
    UIView *denominationView;
    
    UITextField *returnDenomValueTxt;
    NSMutableArray *returnDenomValTxtArr;
    NSMutableArray *returnDenomCountArr;
    UIView *returnDenominationView;
    
    BOOL isReturnDenom;
    
    NSMutableArray *productInfoArr;
    
    BOOL isItemUnVoided;
    
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
    
    BOOL customerStatus;
    UIButton *quickPayBtn;

    UILabel *cardInfoLbl;
    UILabel *approvalCodeLbl;
    UILabel *bankNameLbl;
    
    UITextField *cardInfoTxt;
    UITextField *approvalCodeTxt;
    UITextField *bankNameTxt;
    UILabel *suggestion;
    UIButton *payBtn ;

    NSString *itemScanStartTime;
    NSString *itemScanEndTime;
    BOOL editPriceStatus;
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
    UIButton   *closeBtn ;
    UILabel *label66;
    int startIndexint_;
    BOOL isSearchingItem;
    BOOL isScanningItem;
    BOOL isItemScanned;
    NSMutableArray *isPriceEditableArr;
    UIButton *qty1;
    
    NSMutableArray *denomValCoinsTxtArr;
    NSMutableArray *denomCountCoinsArr;    
    
    BOOL isSearchBool;
    
    NSMutableArray *zeroStockAvailInfoArr;
    NSInteger segment_index ;

    NSMutableArray *skuIdList;
    NSMutableArray *pluCodeList;
    NSMutableArray *unitPriceList;
    NSMutableArray *qtyList;
    NSMutableArray *totalPriceList;
    NSMutableArray *itemStatusList;
    NSMutableArray *itemDiscountList;
    
    UITableView *allDealsOffersTable;
    UITableView *unappliedDealsOffersTable;
    
    NSString *turnOverFreeItems;
    NSArray *turnOverFreeItemsDesc;
    int unAppliedDealIndex;
    UILabel *label;
    UIButton *backbutton;
    UIScrollView *loyaltyScrollView;
    NSMutableDictionary *unAppliedDealItemDic;
    UIView *loginTransperentView;
    UIView *loginView;
    UIPopoverController *customerInfoPopOver;

    UIButton* loginbut;
    UIButton *loginbut1;
    UILabel *password;
    UITextField *userIDtxt;
    UITextField *emailIDtxt;
    UITextField *passwordtxt;
    UIView *loadingView;
    UILabel *loadingMsgLbl;
    
    NSMutableArray *returnDenomValCoinsTxtArr;
    NSMutableArray *returnDenomCountCoinsArr;
    NSMutableArray *taxTypeArr;
    NSString *originalBillId;
    float turnoverofferDiscount;
    NSMutableArray *dealSkus;
    float totalBeforeTurnOver;
    
    int tagid;
    UIScrollView  *uiscroll_gift_view;
    UILabel *phonelbl;
    UILabel *emaillbl;
    UILabel *namelbl;

    UILabel *billLabel;
    UILabel *paidLbl;
    UILabel *streetlbl;
    UILabel *localitylbl;
    UILabel *citylbl;
    UILabel *pinlbl;

    UITableView *reasonsTable;
    BOOL isFreeItemAdded;
    UIView *cardDetailsView;
    UILabel *creditNoteTotalLbl;
    UILabel *creditNoteBalLbl;
    UILabel *creditNoteStatusLbl;
    UILabel *creditNoteLbl;
    UITextField *creditNoteTxt;
    UITextField *phoneNumberText;
    
    UILabel *colorLbl;
    UILabel *sizeLbl;
    NSDictionary *customerInfoDic;
    UITextField *reasontextField;
    UIPopoverController *reasonPopOver;
    UIView *reasonView;
    UITextField *percentageDiscTxt;
    UITextField *percentageDiscValTxt;
    NSString *selectedPluCode;

    //added by Srinivasulu on 18/04/2017....
    
    
    UILabel * userAlertMessageLbl;
    NSTimer * fadeOutTime;
    
    NSString * exchangeTypeMode;
    NSString * selectedExchangeMode;
    
    UIAlertView * returnSuccessAlert;
    
    UIAlertView * confirmationAlertView;
    //upto here on 18/04/2017....
    
    
    NSMutableArray * taxDispalyArr;
    UIScrollView * taxDetailsScrollView;
    UIImageView * scrollViewBarImgView;
    
    
    
    //added by Srinivasulu on  17/07/2017....
    
    UIAlertView * cancelBillAlertView;
    
    //added by Srinivasulu on 26/07/2017....
    
    NSMutableDictionary * turnOverOfferIdsDic;
    
    //upto here on 27/07/2017....
    
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
    
    //added by Srinivasulu on 10/08/2017....
    
    float offSetViewTo;
    
    
    //upto here on 10/08/2017....
    
    //upto here as on 25/07/2017....
    
    
    //added by Srinivasulu on 21/08/2017....
    
    UIView * editPriceView;
    
    NSMutableArray * editPriceReasonArr;
    UITableView * editPriceReasonTbl;
    UITextField * editPriceReasonTxt;
    
    //upto here on 21/08/2017....
    
    
    //added by Srinivasulu on 24/08/2017....
    
    UITextField * returnAmountTxt;
    
    //upto here on 24/08/2017....
    
    
    //added by Srinivasulu on 08/09/2017....
    
    UIView * transperentView;
    
    UIView * cancelBillView;
    
    UITableView * itemCancelReasonsTbl;
    NSMutableArray * itemCancelReasonArr;
    UITextField * itemCancelReasonTxt;

    //upto here on 08/09/2017....
    
    //added by Srinivasulu on 09/09/2017....

    //view used to display all information....
    UIView * editItemDetailsView;
    
    
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
    
    //upto here on 09/09/2017....

    
    
    //changed by Srinivasulu on 08/09/2017....
    //reason is they are using as properties they are producting crash.... while changing from online to offline....
    
    NSString * totalBillAmountStr;
    NSString * customerGstinStr;

    
    //added by Srinivasulu on 03/10/2017 && 12/03/2018....
    
    NSMutableArray * isItemFlatDiscountedArr;
    
    NSMutableArray * isItemTrackingRequiredArr;

    //upto here on 03/10/2017 && 12/03/2018....
    
    //added by Srnivasulu on 12/11/2017....
    
    UITextField * denominationTypeTxt;
    UITextField * conversionRatioTxt;
    UITextField * totalDenominationsCountTxt;
    
    NSMutableArray * denominationsTypeArr;
    UITableView * denominstaionsTypeTbl;
    
    float origingY;
    
    UILabel  * completeBillDiscountValueLbl;

    //upto her eon 12/11/2017....
    
    //added by Srnivasulu on 25/11/2017....

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
    UILabel * generateOtpBackGroundLbl;
    
    UIImage * buttonImageDD1;
    
    UIButton * giftOkBtn;
    UIButton * giftCancelBtn;
    
    UIButton * generateOtpBtn;
    
    
    UITextField * billRemarksTxt;

    BOOL isToScrollViewBillItemsAutomatically;

    
    NSMutableArray  * itemsFromCartArr;
    UILabel   * totalItemsLblVal;
    
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
    
    
    UIScrollView * verticalScrollView;
 
    UILabel * customerPurchasesLbl;
    UIButton * showCustomerPurchasesBtn;
    
    Boolean isMemberShipItemAdded;
    Boolean isFirstTimeMemberShip;
    Boolean customerMemberShipStatus;
    Boolean isToCreateNewMemberShip;
    
    CustomLabel * customerPurchasedSkuIdLbl;
    CustomLabel * customerPurchasedSkuNameLbl;
    CustomLabel * customerPurchasedSkuQtyLbl;
    CustomLabel * customerPurchasedSkuValueLbl;
    
    NSMutableArray * listOfCustomerPurchasesArr; 
    UITableView * listOfCustomerPurchasesTbl;
    
    // added by roja on 29-08-2018....
    UIView * cardPaymentView;
    
    NSMutableArray * addCardPaymentDetailsArr;
    NSMutableArray * cardPaymentButtonArr;
    
    UILabel * completePaidAmtLbl;
    UILabel * netBillAmountValueLbl;
    UILabel * completePaidAmtValueLbl;
    
    UITextField * cardHolderPhoneNumTxt;
    UITextField * paidAmtTxt;

    
    UIButton * fetchDataButton;
    
    UILabel * billValueLabel;
    CustomTextField  * minimumValueText;
    CustomTextField  * maximumValueText;
    
    float couponUnitCashPercentageValue;
    
    // added by roja on 29/07/2019...
    UIButton * senderBtn;

}

//added by Srinivasulu on 02/08/2017....

//@property(nonatomic,strong) NSString * totalBillAmountStr;


//added by Srinivasulu on 12/08/2017....

//@property(nonatomic,strong) NSString * customerGstinStr;

//upto here on 12/08/2017....
//upto here on 02/08/2017....

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

@property(nonatomic,strong)MerchantSettings *mSettings;
@property (nonatomic, strong) CardSaleData       *mCardSaleData;
@property (nonatomic, strong) CardSaleResults     *mCardSaleResults;
@property(nonatomic,strong) NSString *lastConnectedBTv4DeviceName;



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
@property (nonatomic, retain) UITextField *presentTextField;
@property (strong, nonatomic) UIPopoverController* popOver;

@property (nonatomic, retain) PowaPOS *powaPOS;
@property (nonatomic, retain) PowaTSeries *tseries;
@property (nonatomic, retain) PowaS10Scanner *scanner;

- (id)initWithCreditValue:(NSString *)creditsAvailable oldBillId:(NSString *)oldBillId exchangingItems:(NSMutableArray *)exchangingItems billStatus:(NSString *)billStatus reason:(NSString *)reason;
//- (void) continuePay1;
- (void) barcodeScanner:(id)sender;
- (NSString *) saveBill;
- (NSString *) emailBill:(NSString *)imgid;
- (BOOL) validateEmail: (NSString *) candidate;

- (void) showgiftView;
- (void) giftContinue:(id) sender;
- (void) continuePay:(id) sender ;
- (void) continuePay1:(id) sender ;


@property (assign)BOOL isDirectExchangeBill;

@end



