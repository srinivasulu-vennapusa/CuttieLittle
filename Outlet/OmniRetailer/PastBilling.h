//
//  PastBilling.h
//  OmniRetailer
//
//  Created by Bangaru.Raju on 11/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//


//#import "SDZSalesService.h"
#import "SalesServiceSvc.h"
#import <UIKit/UIKit.h>
#import "MIRadioButtonGroup.h"
#import "SKPSMTPMessage.h"
#import "MBProgressHUD.h"
#import <MessageUI/MessageUI.h>
#import "QImageView.h"
#import "SwipeController.h"
#include <AudioToolbox/AudioToolbox.h>
#include <CoreBluetooth/CoreBluetooth.h>
#import "MswipeWisepadController.h"
#import "WisePadController.h"
#import "MerchantSettings.h"
#import "CardSaleData.h"
#import "CardSaleResults.h"
#import <PowaPOSSDK/PowaPOSSDK.h>
#import "CustomNavigationController.h"
#import "DenominationView.h"
#import "CustomTextField.h"
#import "OfflineBillingServices.h"
#import "ReturnDenomination.h"
#import "WebServiceController.h"
#import "WebServiceController.h"

#import "CustomLabel.h"


typedef enum
{
    //when the transaction is approved online after submitting to the gatway for further
    //processing
    CardSale_TRXState_ApprovedOnline_,
    //when on the screen swiper and the card swiper routines are in process then ignore the back key untill any routines that
    //has stopped the card process.
    CardSale_TRXState_Processing_,
    //the rest of the time other then the above the state of the transaction will be in
    //completed state, this can be also intepreted as the transaction as not yest started
    CardSale_TRXState_Completed_,
    
}CardSale_TRXState_;

typedef enum

{
    WisePadConnectionState_connecting_,
    WisePadConnectionState_scanning_,
    WisePadConnectionState_disconnected_,
    WisePadConnectionState_connected_,
    
} WisePadConnectionState_;

typedef enum
{
    ALERT_AMOUNT_,
    ALERT_ERROR_,
    ALERT_TRXCLOSE_,
    HTTP_PROCESS_CARDSALE_,
    NEW_CARDSALE_,
    AUTO_REVERSAL_VOID_,
    HTTP_PROCESS_AUTOVOID_,
    DEVICE_LIST_DISPLAY_,
    FALL_BACK_,
    
} ProcessMode_ ;


typedef enum
{
    //the default state it will always be submiting to the online
    CardSale_TRXType_Online_,
    //[[WisePadController sharedController] sendOnlineProcessResult:@""] this is called the
    // auto reversal is triggered and then consider performing the auto void onlye
    //when the transaction state is in CardSale_TRXState_ApprovedOnline, this suggests that
    //the transaction can be void if the its was approved and for the other states just ignore
    //the autorevesal
    CardSale_TRXType_Reversal_,
    CardSale_TRXType_AUTOVOID_,
}CardSale_TRXType_;

@interface UIPopoverController (iPhone)
+ (BOOL)_popoversDisabled;
@end
@class OmniRetailerAppDelegate;
@class EposPrint;
@protocol OpenPrinterDelegate
- (void)onOpenPrinter:(EposPrint*)prn
       connectionType:(int)connectionType
            ipaddress:(NSString*)ipaddress
          printername:(NSString*)printername
             language:(int)language;
@end
@interface PastBilling : CustomNavigationController <UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate,UIPopoverControllerDelegate,MFMessageComposeViewControllerDelegate,UINavigationControllerDelegate,UIPopoverControllerDelegate,UIActionSheetDelegate,CBCentralManagerDelegate,WisePadControllerDelegate,MswiepWisePadControllerDelegate,UITextViewDelegate,UIAlertViewDelegate,PowaTSeriesObserver,PowaPrinterObserver,GetBillsDelegate,UpdateBillingDelegate,ReturnBillingDelegate,GetSKUDetailsDelegate,SearchProductsDelegate,GetDealsAndOffersDelegate,NSXMLParserDelegate,GiftVoucherServicesDelegate,GiftCouponServicesDelegate,LoyaltycardServicesDelegate,CustomerServiceDelegate>{
    
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    
    id<OpenPrinterDelegate> delegate_;
    OmniRetailerAppDelegate *myAppDelegate;
    
    UITextField *pastBillField;
    NSString *saleId;
    NSMutableArray *salesIdArray;
    NSMutableArray *selectedSalesIdArray;
    UITableView *salesIdTable;
    UITableView *selectedSaleIdTable;
    UITableView *paymentDetailsTable;
    UITableView *returnDetailsTable;
    UITableView *exchangeDetailsTable;
    UIScrollView *scrollView;
    UIScrollView *scrollView1;
    UIScrollView *scrollView2;
    UIScrollView *scrollView3;
    UIScrollView *billingScrollView;
    UIScrollView *paymentScrollView;
    UIScrollView *exchangeScrollView;
    UIScrollView *returnScrollView;
    
    UIScrollView *denomScrollView;

    NSMutableArray *tempArrayItems;
    NSMutableArray *tempPaymentDetails;
    NSMutableArray *tempExchangeDetails;
    NSMutableArray *tempReturnDetails;
    NSMutableArray *tempReturnItems;
    NSMutableArray *tempExchangeItems;
    NSMutableArray *denominations;
    
    NSMutableArray *filteredSkuArrayList;
    NSMutableArray *paymentTransactionArray;
    
    UISegmentedControl *segmentedControl;
    UISegmentedControl *mainSegmentedControl;
    
    UIView* paymentView;
    UIView* smsView;
    UIView* mailView;
    UIView* printView;
    UIView* giftView;
    NSString *dealSkuId;

    UILabel *label_1;
    UILabel *label_2;
    UILabel *label_3;
    UILabel *label_4;
    UILabel *label_5;
    UILabel *itemDiscLbl;
    UILabel *label_6;
    UILabel *label_7;
    UILabel *label_8;
    UILabel *label_9;
    UILabel *label_10;
    UILabel *label_11;
    UILabel *label_12;
    UILabel *label_13;
    UILabel *label_14;
    UILabel *label_15;
    UILabel *label_16;
    UILabel *label_17;
    UILabel *label_18;
    UILabel *label_19;
    UILabel *label_20;
    
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    UILabel *label4;
    UILabel *label5;
    UILabel *cellItemDiscLbl;
    
    UILabel *curTax;
    
    NSTimer *aTimer;
    MIRadioButtonGroup *group;
    
    UITextField* payTxt1;
    UITextField* payTxt2;
    
    NSMutableArray *cartItem;
    UITableView* cartTable;
    
    UIActivityIndicatorView * spinner;
    UIImageView * bgimage;
    IBOutlet UILabel * loadingLabel;
    
    MBProgressHUD *HUD;
    
    UILabel *subTotalBill;
    UILabel *taxlbl;
    
    UILabel *billStatusLabel;
    UILabel *billStatusLabelValue;
    UILabel *customerName;
    UILabel *customerPhone;
    UIButton *quickPayBtn;
    UILabel *changeReturnLabel;
    UILabel *changeReturnLabelValue;
    UILabel *billID;
    UILabel *billDate;
    UILabel *billDone;
    UILabel *mpayment;
    UILabel *transeId;
    UILabel *customerNameValue;
    UILabel *customerPhoneValue;

    UILabel*billIDValue;
    UILabel *billDateValue;
    UILabel *billDoneValue;
    UILabel *mpaymentValue;
    UILabel *transeIdValue;
    UILabel *totalBill;
    UILabel *billDue;
    UILabel *billDetails;
    UILabel *transactionDetails;
    UILabel *exchangeDetails;
    UILabel *returnDetails;
    UILabel *totalBillValue;
    UILabel *billDueValue;
    UILabel *discount;
    UILabel *discountValue;
    UILabel *paymentType;
    UILabel *paymentTypeVal;
    UILabel *bill_status;
    UILabel *bill_status_val;
    UILabel *totalPaymentLbl;
    UILabel *totalPaymentVal;
    UILabel *giftAmtLbl;
    UILabel *giftVoucherTxt;
    
    
    
    UILabel *subTotalBillValue;
    UILabel *taxlblValue;
    
    SwipeController *swipeController;
    
    UIView *baseView;
    UITextField *smsField;
    
    UIButton *priceButton;
    
    UITextField *BillField;
    UIButton *openDetails;
    UIButton *closeDetails;
    UIButton *okbtn;
    UIButton *cancelbtn;
    UIButton *mainBackbutton;
    UIButton *color;
    UILabel *tlabel;
    QImageView *signView;
    UIView *backview;
    NSMutableArray *swiperMsgs;
    
    UIView *cardPayment;
    UIView *amountView;
    UILabel *label22;
    UILabel *sale;
    UILabel *host1;
    UILabel *inr;
    UILabel *amt;
    UILabel *totalAmt1;
    UILabel *phoneNo;
    UIButton *nextBtn;
    UIButton *cancelBtn;
    NSString *status_mswipe;;
    UIView *cardDetails;
    UIAlertView *signature;
    UIView *transactionView;
    UITextView *info;
    UIButton *startBtn;
    UILabel *card_holder;
    UILabel *amount1;
    UILabel * expiry_date;
    UILabel *last_digits;
    UIButton *continue_transaction;
    UIImageView *signature_view;
    UIView *buttonView;
    UIView *receipt_view;
    UIButton *clearSign;
    UIButton *signSubmit;
    UITextField *phoneTxt;
    UITextField *emailTxt;
    //    UITextField *giftType;
    //    UITextField *giftNo;
    //    UITextField *giftValidFrom;
    //    UITextField *giftValidTo;
    //    UITextField *giftAmt;
    //
    //    UILabel *amtLabel;
    //    UILabel *avai_points_label;
    //    UILabel *recash_label;
    BOOL bluetoothEnabled;
    CBCentralManager *bluetoothManager;
    
    CardSale_TRXState_ mCardSale_TRXState;
    CardSale_TRXType_ mCardSale_TRXType;
    CardSaleResults *mcardSaleResults;
    MCRCardResults mCardResults;
    CardSaleData *mcardSaleData;
    WisePadConnectionState_ mConnesctionState;
    BOOL isEmvSwiper;
    ProcessMode_ processMode;
    NSString *lastConnectedBTv4DeviceName;
    
    UIButton *cardradioBtn1;
    UIButton *cardradioBtn2;
    
    UITextField *newPriceField;
    UIButton *okEditPriceButton;
    
    NSString *cardPaymentSelection;
    
    UIScrollView *returnView;
    UIScrollView *exchangeView;
    UIScrollView *returnDetailsView;
    UIScrollView *exchDetailsView;

    
    UILabel *returnBillID;
    UILabel *returnBillIDValue;
//    UILabel *label_1;
//    UILabel *label_2;
//    UILabel *label_3;
//    UILabel *label_4;
//    UILabel *label_5;
    UITableView *itemTable;
    UITableView *itemTableExchg;
    
    UIScrollView *itemScroll;
    UIScrollView *itemExchScroll;

    NSMutableArray *selectedItems;
    UIImage *on;
    UIImage *off;
    UILabel *total_Bill;
    UILabel *total_Bill_Value;
    
    UILabel *subtotal;
    UILabel *subtotal_value;
    
    UILabel *deals;
    UILabel *deals_value;
    
    UILabel *reason;
//    UITextView *reasonTextField;
    UIButton *qty1;
    UIButton *submitButton;
    UIView *qtyChangeDisplyView;
    UITextField *qtyFeild;
    UIButton *okButton;
    UIButton *qtyCancelButton;
    UITextField *presentTextField;
    UILabel *returningTotalBill;
    UILabel *returningTotalBillValue;
    UILabel *exchangeTotalBillValue;
    UILabel *exchgBillID;
    UILabel *exchgBillIDValue;
    UILabel *returnedTotalBill;
    UILabel *returnedTotalBillValue;
    UILabel *exchangedTotalBill;
    UILabel *exchangedTotalBillValue;

    UIDeviceOrientation currentOrientation;
    
    UILabel *phonelbl;
    UILabel *emaillbl;
    UILabel *namelbl;
    UILabel *label;
    UIButton *backbutton;
    UILabel *billLabel;
    UILabel *paidLbl;
    UIButton *payBtn ;
    UILabel *streetlbl;
    UILabel *localitylbl;
    UILabel *citylbl;
    UILabel *pinlbl;
    UILabel *taxTitle ;
    
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
    
    UIButton * fetchDataButton;
    
    UILabel * billValueLabel;
    CustomTextField  * minimumValueText;
    CustomTextField  * maximumValueText;
    //upto here on 02/05/2017....
    
    int tagid;
    NSString *turnOverDis ;
    NSString *offerDescStr ;
    NSString *turnOverDealDes ;
    NSMutableArray *turnOverDealVal;
    NSMutableDictionary *offerDic;
    
    
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
    UILabel *descLabl;
    UILabel *priceLabl;
    UILabel *mrpLbl;
    
    UITableView *priceTable;
    NSMutableArray *priceArr;
    NSMutableArray *descArr;
    NSMutableArray *priceDic;
    
    UIView *priceView;
    UIView *transparentView;
    NSMutableArray *skuArrayList;
    NSMutableArray *tempSkuArrayList;
    UITableView *skListTable;
    NSMutableArray *skListArr;
    NSString *selected_SKID;
    NSString *selected_desc;
    NSMutableArray *cartItemDetails;
    NSMutableArray *taxArr;
    NSMutableArray *isVoidedArray;
    NSMutableArray *cartTotalItems;

    DenominationView *denomination;
    NSMutableDictionary *returnDenominationDic;
    
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
    NSString *selected_price;
    
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
//    NSMutableDictionary *denominationDic;
    NSMutableDictionary *denominationCoinDic;
    NSMutableDictionary *returnDenominationCoinDic;
    UILabel *paidVal;
    UILabel *changeReturnVal;
    
    OfflineBillingServices *offline;
    
    UIView *couponView;
    UIScrollView *loyaltyScrollView;

    
    UITextField  *selectCouponType;
    UITextField *couponId;
    UITextField *couponValue;
    UITextField *couponQty;
    UILabel *totalCoupValue;
    UILabel *totalCoupBill;
    UILabel *billDueLbl;
    UITableView *couponDeatails;
    UITableView *couponType;
    UITableView *valueTable;
    UIButton *valueBtn;
    
    NSMutableArray *couponArr;
    NSMutableArray *couponValArr;
    NSMutableArray *couponTotalArr;
    NSMutableArray *couponIdArr;
    NSMutableArray *cupon_type;
    NSMutableArray *value_arr;
    NSMutableArray *editedPriceArr;

    
    UITextField *giftType;
    NSString *giftTypeString;
    CustomTextField *giftNo;
    CustomTextField *giftValidFrom;
    CustomTextField *giftValidTo;
    CustomTextField *giftAmt;
    UILabel *amtLabel;
    UILabel *avai_points_label;
    UILabel *recash_label;
    
    UIButton *giftScannerBtn;
    CustomTextField *avai_points;
    CustomTextField *recash;
    
    UITableView *giftTypeTableView;
    
    //changed by Srinivasulu on 24/05/2017....
    
//    NSMutableArray *giftTypeArrayList;
    NSMutableOrderedSet * giftTypeArrayList;
    
    //upto here on Srinivasulu on 24/05/2017....

    
    
    UIButton *giftTypeBtn;
    UIButton *giftSearchBtn;
    UIAlertView *saveAlert;
    NSMutableArray *filteredPriceArr;
    BOOL giftClaimStatus;
    NSString *giftNumber;
    
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
    UILabel *totalAmtVal;
    
    UIAlertView *cofirmAlert;
    UIAlertView *returnCofirmAlert;
    ReturnDenomination *returnDenomination;
    UILabel *returnedval;
    UILabel *returnAmtVal;
    UILabel *excessAmt;
//    NSMutableArray *itemsArr;
    UIButton *changeStatusBtn;
    UILabel *customerDetails;
    UILabel *customerDetailsVal;
    int segmentIndex;
    int mainsegmentIndex;
    
    UIView *cardDetailsView;
    UILabel *cardInfoLbl;
    UILabel *approvalCodeLbl;
    UILabel *bankNameLbl;
    
    UITextField *cardInfoTxt;
    UITextField *approvalCodeTxt;
    UITextField *bankNameTxt;
    NSString *printCount;
    
    NSString *appCode;
    NSString *bankName;
    
    NSMutableArray *isVegetable;
    NSString *foodCouponTypeStr;
    NSString *totalChangeReturnStr;

    NSString *changeReturnStr;
    NSString *totalReceivedAmt;
    UIButton   *closePriceViewBtn;
    
    UILabel *otherDiscVal;
    UILabel *otherDiscLbl;
    NSMutableArray *observedObjsArr;
    UILabel *newCust;
    UIPopoverController *editPricePopOver;

    UILabel *cardID;
    UILabel *giftNoLbl;
    CustomTextField *giftID;
    NSMutableArray *giftVoucherArr;
    NSMutableDictionary *deletedTaxDic;
    BOOL billingErrorStatus;
    NSMutableArray *finalTaxDetailsArr;
    
    UILabel *creditNoteTotalLbl;
    UILabel *creditNoteBalLbl;
    UILabel *creditNoteStatusLbl;
    UILabel *creditNoteLbl;
    UITextField *creditNoteTxt;

    UIButton* loginbut;
    UIButton *loginbut1;
    UIView *loginView;
    UILabel *password;
    UITextField *userIDtxt;
    UITextField *emailIDtxt;
    UITextField *passwordtxt;
    UIView *loginTransperentView;
    NSMutableArray *itemCampaigns;
    
    NSString *salesPersonIdStr;
    UITextField *salesPersonId;
    
    
    NSString *returnMode;
    
    //added by Srinivasulu on 24/05/2017....
    
    NSString * selectedReturnModeStr;
    
    //upto here on 24/05/2017....
    
    
    BOOL isItemEmpl;
    UIView *customerSpecificView;
    UITextField *departmentFld;
    UITextField *subDepartmentFld;
    UITextField *salesPersonIdFld;
    UITextField *salesPersonNameFld;
    UIPopoverController *salesInfoPopUp;
    NSString *appDoc;
    
    UITextField *denomValueTxt;
    NSMutableArray *denomValTxtArr;
    NSMutableArray *denomCountArr;
    UIView *denominationView;
    
    UITextField *returnDenomValueTxt;
    NSMutableArray *returnDenomValTxtArr;
    NSMutableArray *returnDenomCountArr;
    UIView *returnDenominationView;
    
    BOOL isReturnDenom;

    NSMutableArray *denomValCoinsTxtArr;
    NSMutableArray *denomCountCoinsArr;
    NSMutableArray *returnDenomValCoinsTxtArr;
    NSMutableArray *returnDenomCountCoinsArr;
    
    NSString *originalBillId;
    
    //added by Srinivasulu on 18/04/2017....
    
    
    UILabel * userAlertMessageLbl;
    NSTimer * fadeOutTime;
    
    NSMutableDictionary * customerObj;
    
    //added by Srinivasulu on 02/06/2017....
    NSMutableDictionary * printFormatMapObj;

    //added by Srinivasulu on 15/06/2017....
    UIPopoverController *catPopOver;

    
    UITextField * returnReasonTxt;

    UITableView * reasonTbl;
//    NSMutableArray * reasonArr;
    
    
    UIAlertView * printAlertView;
    
    
    
    NSMutableArray * taxDispalyArr;
    UIScrollView * taxDetailsScrollView;
    UIImageView * scrollViewBarImgView;
    
    //upto here on 18/04/2017....
    
    //added by Srinivasulu on  2017....
    
    NSMutableArray * offlinePrintFormatArr;
  
    Boolean isRootElement;
    Boolean isChildElement;
    
    
    //added by Srinivasulu on 29/08/2017....
    
    UITextField * returnAmountTxt;
    
    //upto here on 25/07/2017....
    

  
    
    //added by Srinivasulu on 20/09/2017....
    
    NSString * counterIdStr;
    NSString * serialBillIdStr;

    //upto here on 20/09/2017....
    
    //added by Srinivasulu on 13/10/2017....

    NSString * creditNoteNumberStr;

    //upto here on 13/10/2017....
    
    
    //added by Srnivasulu on 12/11/2017....
    
    UITextField * denominationTypeTxt;
    UITextField * conversionRatioTxt;
    UITextField * totalDenominationsCountTxt;
    
    NSMutableArray * denominationsTypeArr;
    UITableView * denominstaionsTypeTbl;
    
    float origingY;
    //upto her eon 12/11/2017....
    
    
    UITextField * cradTypeTxt;
    NSMutableArray * cardTypesArr;
    UITableView * cardTypesTbl;
 
    UIView * transperentView;

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
    
    //upto here on 21/11/2017.... 
 
    
    float offSetViewTo;

    NSMutableDictionary * offlineBillDeatilsInfoDic;

    NSMutableDictionary * offlineDynamicPrintDic;
    Boolean isObjectSequenceEnded;
    NSString * sequeceNameStr;
    NSString * sequeceContentStr;
    Boolean isToStoreSequeceContent;
    Boolean isKeyInSequeceContent;
    NSString * sequenceContentKeyNameStr;

    Boolean isParaMetersExistUnderPart;
    NSMutableArray * tempParaMetersArr;
    NSString * paraMetersExistUnderPartStr;

    Boolean isSubParaMetersExistUnderPart;
    NSMutableArray * tempSubParaMetersArr;
    NSString * subParaMetersExistUnderPartStr;

    NSMutableArray * tempPrintInfoArr;

    
    UIView * perviousPaymentTransantionView;

    //added by Srinivasulu on 23/12/2017....
    UIView * exchangeTransfers;
    
    CustomLabel * currentBilledItemLbl;
    CustomLabel * currentBilledtemPriceLbl;
    CustomLabel * currentBilledItemQtyLbl;
    CustomLabel * currentBilledItemDiscountLbl;
    CustomLabel * currentBilledItemTotalCostLbl;

    CustomLabel * exchangedItemSkuidLbl;
    CustomLabel * exchangedItemLbl;
    CustomLabel * exchangedDateLbl;
    CustomLabel * exchangedItemPriceLbl;
    CustomLabel * exchangedItemQtyLbl;
    CustomLabel * exchangedItemTotalCostLbl;
    
    UITableView * currentBilledItemsTbl;
    
    UITableView * exchangedBilledItemsTbl;
    NSMutableArray * exchangedItemsArr;
    
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
    UILabel * cardNumber;
    CustomTextField * phoneNumberText;

    UILabel * generateOtpBackGroundLbl;
    
    UIImage * buttonImageDD1;
    
    UIButton * giftOkBtn;
    UIButton * giftCancelBtn;
    
    UIButton * generateOtpBtn;
    
    NSString * defaultReturnTypeStr;

    UITextField * billRemarksTxt;

    //added by Srinivasulu on 24/03/2018 && 03/05/2017 && 28/06/2018....
    
    UILabel * billEnterRemarksLbl;
    UITextView * billRemarksTextView;
    
    NSString * salesOrderIdStr;
    
    NSMutableArray * returnBillItemsArr;
    
    float orderShipmentCharges;
    //upto here on 24/03/2018 && 03/05/2018 && 28/06/2018....
    
    
    //moved from .h to .m by srinivasulu on 02/08/2018.. due to errors..
    UIButton *barCodeImage;
    UIBarButtonItem *sendButton;
    
    NSMutableArray *finalItems;
    UIActionSheet *action;
    NSMutableString *type_Of_Payment;
    
    CGPoint returnScroll;
    CGPoint exchangeScroll;
    UIAlertView *returnSuccessAlert ;
    
    
    float due;
    float version;
    //NSString *curTax;
    NSArray *temp1;
    
    MerchantSettings *settings;
//    CardSaleData *mcardSaleData;
    NSMutableArray *availQtyArr;
    
    float maxPrintLength;
    float couponUnitCashPercentageValue;
    
    BOOL isCustomrDetailDoorDelCall;

    
}


//added by Srinivasulu on 02/08/2017....

@property(nonatomic,strong) NSString * totalBillAmountStr;

//added by Srinivasulu on 09/08/2017....

@property(nonatomic,strong) NSString * syncStatusStr;


@property(nonatomic,strong) NSString * customerGstinStr;

//upto here on 09/08/2017....

//upto here on 02/08/2017....


@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property(nonatomic,retain)IBOutlet UITextField *pastBillField;
@property(nonatomic, retain)NSTimer *aTimer;
@property(nonatomic, retain)IBOutlet UITextField *payTxt1;
@property(nonatomic, retain)IBOutlet UITextField *payTxt2;
@property (nonatomic, retain) OmniRetailerAppDelegate *myAppDelegate;
@property(nonatomic,strong)CBCentralManager *bluetoothManager;
@property(nonatomic, retain)IBOutlet UILabel * loadingLabel;
@property(nonatomic, retain)UIImageView * bgimage;
@property(nonatomic, retain)UIActivityIndicatorView * spinner;
@property (nonatomic, retain) UIPopoverController *poc;
@property (nonatomic,assign) UIButton *popButton;
@property (strong, nonatomic) UIPopoverController* popOver;
@property(nonatomic,strong)UIView *amountView;
@property(nonatomic,strong)UILabel *amt;
@property(nonatomic,strong)UILabel *phoneNo;
@property(nonatomic,strong)UILabel *emailId;
@property(nonatomic,strong)NSString *total;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *email;
@property (nonatomic, strong) NSString   *mstrEMVProcessTaskType;
@property (nonatomic, strong) NSString   *mAmexSecurityCode;
@property(nonatomic,strong)MerchantSettings *mSettings;
@property (nonatomic, strong) CardSaleData       *mCardSaleData;
@property (nonatomic, strong) CardSaleResults     *mCardSaleResults;
@property(nonatomic,strong) NSString *lastConnectedBTv4DeviceName;
@property(nonatomic,strong) NSString *billingType;
@property(nonatomic,assign)BOOL isPrinterConnected;
@property (nonatomic,strong) NSString * pastBillId;
@property(readwrite,assign) BOOL isBillSummery;


- (NSString *) saveBill;

-(void)removeWaitOverlay;
-(void)createWaitOverlay;
-(void)stopSpinner;
-(void)startSpinner;
- (NSString *) emailBill:(NSString *)imageId;
- (BOOL) validateEmail: (NSString *) candidate;
- (void) continueFurther:(id) sender;
- (void) continuePay1;
-(id) initWithBillType:(NSString *)typeOfBill;
-(id) initWithNewBill:(NSString *)newBill oldBill:(NSString *)oldBill exchangedItems:(NSMutableArray *)exchangedItems;



//added by Srinivasulu on 24/04/2017....

@property(nonatomic,strong) NSString * billStatusStr;

//added by Srinivasulu on 21/07/2017....

@property(nonatomic,strong) NSString * billTypeStr;

//upto here on 21/07/2017....

//upto here on 24/04/201....




@end


