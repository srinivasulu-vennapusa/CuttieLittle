//
//  OmniHomePage.h
//  OmniRetailer
//
//  Created by Satya Siva Saradhi on 05/10/12.
//  Copyright 2012 __techolabssoftware.com__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellView.h"
#include <AudioToolbox/AudioToolbox.h>
#import "PopOverViewController.h"
#import "MBProgressHUD.h"
#import <PowaPOSSDK/PowaPOSSDK.h>
#import "CustomNavigationController.h"
#import "WebServiceController.h"
#import "XReportController.h"
#import "XReportView.h"
#import "CustomTextField.h"
#import "DenominationView.h"
#import "WebServiceUtility.h"
#import "GDataXMLNode.h"
#import "CancelledBills.h"
#import "ViewWalkoutCustomer.h"
#import "ListViewCustomCell.h"
#import "PastBillsList.h"
#import "ReturnBill.h"
#import "ExchangeBill.h"
#import "StockVerificationView.h"
#import "NewStockRequest.h"
#import "ViewStockRequest.h"
#import "MessageTableCellViewTableViewCell.h"
#import "OpenStockReceipt.h"
#import "StockRequest.h"
#import "PastBillsList.h"
#import "CategoryWiseReports.h"
#import "SkuWiseReport.h"
#import "SuppliesReports.h"
#import "MaterialConsumptionController.h"
#import "GoodsReceiptNoteView.h"
#import "TaxWiseReports.h"


//.. CAAnimationDelegate .... was -------------- added by Srinivasulu on 20/07/2017....

@class OmniRetailerAppDelegate;

@interface OmniHomePage : CustomNavigationController <UITableViewDelegate, UITableViewDataSource, UITabBarDelegate, UITabBarControllerDelegate,UINavigationControllerDelegate,UIPopoverControllerDelegate,NSXMLParserDelegate,MBProgressHUDDelegate,UIAlertViewDelegate,PowaTSeriesObserver,PowaScannerObserver,CreateBillingDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,GetMessageBoardDelegate,CAAnimationDelegate,HideTheHUDViewDelegate_, CounterServiceDelegate, SalesServiceDelegate> {
    
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    
    OmniRetailerAppDelegate *myAppDelegate;
    IBOutlet CellView *cellView;
    IBOutlet UITableView *homeTable;
    NSMutableArray* prod_img_array;
    NSMutableArray* sub_prod1_array;
    NSMutableArray* sub_prod2_array;
    UISegmentedControl *segmentedControl;
    
    NSMutableArray* subModuleArry1;
    NSMutableArray* subModuleArry2;
    
    UIImageView *cellBackground;
    UIImageView *cellBackground1;
    
    UIButton *newBillButton;
    UIButton *cancelledButton;
    UIButton *oldBillButton;
    UIButton *deliveryIcon;
    UIButton *pendingIcon;
    UIButton *criticalStock;
    UIButton *normalStock;
    UIButton *reorderStock;
    UIButton *verifyStock;
    UIButton *stockDelivery;
    UIButton *dealsButton;
    UIButton *offersButton;
    UIButton *newOrders;
    UIButton *oldOrders;
    UIButton *dOrder;
    UIButton *complaints;
    UIButton *newReports;
    UIButton *oldReports;
    UIButton *issueCard;
    UIButton *viewCard;
    UIButton *loyaltyEdit;
    UIButton *XZreport;

    UIButton *issueGiftVoucher;
    UIButton *viewGiftVoucher;
    UIButton *editGiftVoucher;
    UIImageView *issueGVView;
    UIImageView *viewGVView;
    UIImageView *editGVView;

    UIButton *stockReceipt;
    UIImageView *stockReceiptView;
    UIButton *stockIssue;
    UIImageView *stockIssueView;
    //UIButton *stockRequest;
    UIImageView *stockRequestView;
    UIButton *stockReturn;
    UIImageView *stockReturnView;
    UIButton *purchases;
    UIImageView *purchaseView;
    UIButton *shipments;
    UIImageView *shipmentView;
    UIButton *receipts;
    UIImageView *receiptView;
    UIButton *orders;
    UIButton *shipments_;
    
    UIButton *stockVerify;
    UIImageView *stockVerifyView;
    
    UIButton *verifiedStockReport;
    UIImageView *verifiedStockReportView;
    
    UIImageView *buttonView;
    UIImageView *oldBillView;
    UIImageView *deliveryView;
    UIImageView *pendingView;
    UIImageView *cancelledView;
    UIImageView *criticalView;
    UIImageView *normalView;
    UIImageView *reorderView;
    UIImageView *verifyView;
    UIImageView *sDeliveryView;
    UIImageView *dealsView;
    UIImageView *offersView;
    UIImageView *newOrderView;
    UIImageView *oldOrderView;
    UIImageView *dorderView;
    UIImageView *complaintView;
    UIImageView *newReportView;
    UIImageView *oldReportView;
    UIImageView *issueCardView;
    UIImageView *showCardView;
    UIImageView *editView;
    UIView *billingView;
    UIScrollView *scrollView;
    UIScrollView *loyaltyGiftVoucherScroll;
    UIImageView *xzView;
    
    UILabel *line;
    UIButton *wareHouseVerify;
    UIImageView *wareHouseVerifyView;
    UIButton *ware_house_purchases;
    UIImageView *ware_house_purchases_view;
    UIButton *ware_house_shipments;
    UIImageView *ware_house_shipments_view;
    UIButton *ware_house_reciepts;
    UIImageView *ware_house_receipts_view;
    
    UIScrollView *wareHouseScrollView;
    
    UIButton *wareStockReceipt;
    UIImageView *wareStockReceiptView;
    UIButton *wareStockIssue;
    UIImageView *wareStockIssueView;
    UIButton *warehouse_insp_receipt;
    UIImageView *warehouse_insp_view;
    UIButton *warehouse_invoice;
    UIImageView *warehouse_invoice_view;
    UIButton *warehouse_payment;
    UIImageView *warehouse_payment_view;
    
    UIButton *wareNewOrder;
    UIImageView *wareNewOrderView;
    UIButton *warePendingOrder;
    UIImageView *warePendingOrderView;
    UIButton *wareDeliveredOrder;
    UIImageView *wareDeliveredOrderView;
    
    UIButton *wareNewShipment;
    UIImageView *wareNewShipView;
    UIButton *warePendingShip;
    UIImageView *warePendingShipView;
    UIButton *wareDeliveredShip;
    UIImageView *wareDeliveredShipView;
    
    UIButton *wareNewVerify;
    UIImageView *wareNewVerifyView;
    UIButton *warePendingVerify;
    UIImageView *warePendingVerifyView;
    UIButton *warePastVerify;
    UIImageView *warePastVerifyView;
    
    MBProgressHUD *HUD;
    UIDeviceOrientation currentOrientation;
    
    UIButton *zreading;
    UIButton *zreadingcon;
    UIImageView *xView;
    UIImageView *zView;

  

     UITextField *cashTotalTxt;
    
     UITextField *couponTotalTxt;
     UITextField *ticketTotalTxt;
     UITextField *cardTotalTxt;
    XReportView *reportView;
    UIView *transparentView;

    UIButton *generateReportBtn;
    UIButton *cancelBtn;
    
    DenominationView *denomination;
    
    int tensCount;
    int twentyCount;
    int fiftyCount;
    int hundredCount;
    int fiveHundredCount;
    int thousandCount;
    int oneCount;
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
    
    UILabel *thousandValue;
    UILabel *fiveHundValue;
    UILabel *hundValue;
    UILabel *fiftyValue;
    UILabel *twentyValue;
    UILabel *tenValue;
    UILabel *fiveValue;
    UILabel *twoValue;
    UILabel *oneValue;

    UIView *messageBoardView;
    
    UIView *loadingView;
    UILabel *loadingMsgLbl;
    
    UIButton *issueGiftCoupon;
    UIButton *viewGiftCoupon;
    UIImageView *issueGCView;
    UIImageView *viewGCView;
    
    UIButton *customerWalkOut;
    UIImageView * customerWalkOutView;
  
    UIView *gridView;
    UIView *listView;
    
    UICollectionView *gridCollectionView;
    
    NSMutableArray *gridImagesArr;
    NSMutableArray *gridImageNamesArr;
    
    int selectedTableRowNumber;
    
    UIButton *showListViewBtn;
    UIButton *showgridViewBtn;
    
    UITableView *listTableView;
    
    NSMutableArray *noOfDocsArr;
    NSMutableArray * noOfPendingDocsArr;
    NSMutableArray *lastUpdatedDate;
    
    BOOL isListView;
    UIView *headerView;
    UIPopoverController* popOver;
    UIButton *messageIcon;
    int messageStartIndex;

    UITableView *messageTable;
    NSMutableArray *messageDetailsArr;
    UILabel *msgTotalRcrdsLbl;
    UILabel *noMessagesLbl;
    UIView *totalRecordsView;
    NSMutableArray *messagesPerPageArr;
    int recordPosition;
    int buttonTitleIndex;
    int pageIndex;
    int buttonIndex;
    UIPopoverController *messagePopOver;
    
    UITextField *denomValueTxt;
    NSMutableArray *denomValTxtArr;
    NSMutableArray *denomCountArr;
    NSMutableArray *denomValCoinsTxtArr;
    NSMutableArray *denomCountCoinsArr;
    UIView *denominationView;
    NSMutableDictionary *denominationCoinDic;

    UIButton *backBtn;
    int saleNo;
    
    NSString *selectedFlowStr;
    
    int selectedFlowPosInt;
    UIAlertView *downloadConfirmationAlert;
    
    

 //added by Srinivasulu on 30/08/2017....
    
    float offSetViewTo;

    
    //upto here on 30/08/2017....
    
    UIView * transperentView;
    UITextField * totalNoOfWalkinsTxt;
    UITextField * remarksTxt;

    UIAlertView * zReportAlert;
    
    UIAlertView *  offlineBillDeleteConfirmationAlert;


    NSMutableArray * paymentModesArr;
    NSMutableArray * paymentModesAmountArr;
    UITextField * paymentModesAmountTxt;
    UILabel  * userEnteredTotalsValueLbl;

    UIView * tenderModesView;

    NSString * showDefaultCurrencyCode;

    //moved from .h to .m by srinivasulu on 02/08/2018.. due to errors..
    UILabel *stocks;
    UILabel *goodsTransfer;
    UILabel *goodsProcurement;
    UILabel *delivers;
    UILabel *stock;
    float version;
    NSXMLParser *parser;
    
    UIAlertView *confirmation;
    
    NSUserDefaults *defaults;
    //NSMutableArray *itemsArr;
    NSMutableArray *billDetails;
    //NSMutableArray *transactionArr;
    //NSString *uploodedBillId;
    //NSString *billSaveStatus;
    
    CALayer *offersBottomBorder;
    CALayer *complaintsBottomBorder;
    CALayer *orderBottomBorder;
    CALayer *editBottomBorder;
    CALayer *pendingBottomBorder ;
    CALayer *cancelledBottomBorder ;
    
    
    NSString * reportTypeStr;  // added by roja on 17/10/2019..
}


@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;
@property (nonatomic, retain) UIActivityIndicatorView *spinner;
@property (nonatomic, retain) OmniRetailerAppDelegate *myAppDelegate;
@property (nonatomic, retain) UITableView *homeTable;
@property (nonatomic, retain) NSMutableArray *prod_img_array;
@property (nonatomic, retain) NSMutableArray *sub_prod1_array;
@property (nonatomic, retain) NSMutableArray *sub_prod2_array;
@property (strong, nonatomic) UIPopoverController* popOver;


- (void) logOut ;
-(NSArray*)getDenomination:(NSString *)bill_id transaction_id:(NSString *)transaction_id;


@end




