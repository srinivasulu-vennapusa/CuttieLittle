//
//  EditOrder.h
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/1/15.
//
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import <AudioToolbox/AudioToolbox.h>
#import "CustomNavigationController.h"
#import "CustomTextField.h"
#import "CustomLabel.h"
#import "WebServiceUtility.h"
#import "WebServiceConstants.h"
#import "WebServiceController.h"
#import "RequestHeader.h"


@interface EditOrder : CustomNavigationController <MBProgressHUDDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,StoreServiceDelegate,SearchProductsDelegate,GetSKUDetailsDelegate,OutletOrderServiceDelegate,RoutingServiceDelegate, CustomerServiceDelegate> {
    
    // Object Declaration for HUD..(processing bar).......
    MBProgressHUD * HUD;
    
    //to get the device version.......
    float version;
    float offSetViewTo;
    bool reloadTableData;
    
    // added by roja on 25-09-2018..
    float otherDiscPercentageValue;
    float totalCostBeforeDisc;
    
    // upto here added by roja on 25-09-2018..
    
    //used to store the device Orientation.......
    UIDeviceOrientation currentOrientation;
    
    // Creation of UIView...
    UIView * createOrderView;
    
    // Creation of UIScrollView...
    UIScrollView * createOrderScrollView;
    
    /*Creation of textField used in this page*/
    // Row 1....
    CustomTextField * orderDateText;
    CustomTextField * deliveryDateText;
    CustomTextField * confirmDateText;
    CustomTextField * paymentModeText;
    CustomTextField * paymentTypeText;
    
    //Row 2....
    CustomTextField * locationText;
    CustomTextField * customerEmailIdText;
    CustomTextField * customerMobileNoText;
    CustomTextField * paymentRefText;
    
    //row3....
    CustomTextField * streetText;
    CustomTextField * customerLocationText;
    CustomTextField * customerCityText;
    
    //row4
    CustomTextField * doorNoText;
    CustomTextField  * contactNoText;
    CustomTextField  * googleMapLinkText;
    CustomTextField  * pinNoText;
    
    //row5
    CustomTextField * billingStreetText;
    CustomTextField * billingLocationText;
    CustomTextField * billingCityText;
    
    //row6
    CustomTextField * billingDoorNoText;
    CustomTextField * billingContactNoText;
    CustomTextField * billingGoogleMapLinkText;
    CustomTextField * billingPinNoText;
    
    //row7
    CustomTextField * shipmentContactNoText;
    CustomTextField * shipmentDoorNoText;
    CustomTextField * shipmentStreetNoText;
    
    //row8
    CustomTextField * shipmentNameText;
    CustomTextField * shipmentLocationText;
    CustomTextField * shipmentCityText;
    CustomTextField * shipmentStateText;
    
    //row9
    CustomTextField * orderChannelText;
    CustomTextField * shipmentTypeText;
    CustomTextField * salesExecutiveIdText;
    CustomTextField * salesExecutiveNameText;
    CustomTextField * refferedByText;
    
    //row10..
    CustomTextField * deliveryTypeText;
    CustomTextField * shipmentModeText;
    //    CustomTextField * specialDiscPercentageTxt;
    //    CustomTextField * specialDiscAmountTxt;
    
    // changed by roja on 21-09-2018...
    CustomTextField * otherDiscPercentageTxt;
    CustomTextField * otherDiscAmountTxt;
    
    //For the Tax Calaulations...
    CustomTextField * shippingCostText;
    
    
    
    CustomTextField * otherDiscountText;
    CustomTextField * totalTaxTxt;
    CustomTextField * subTotalText;
    
    UIView * orderTotalsView;
    
    
    UITextField * totalCostText;
    UITextField * amountPaidText;
    UITextField * amountDueText;
    
    UITextField * orderQuantityText;
    
    
    //
    UITextField  * searchItemsText;
    
    UIScrollView * orderItemsScrollView;
    UIScrollView * buttonScrollView;
    
    //Used on TopOfTable.......
    CustomLabel * snoLabel;
    CustomLabel * itemIdLabel;
    CustomLabel * itemNameLabel;
    CustomLabel * makeLabel;
    CustomLabel * modelLabel;
    CustomLabel * colorLabel;
    CustomLabel * sizeLabel;
    CustomLabel * mrpLabel;
    CustomLabel * salePriceLabel;
    CustomLabel * quantityLabel;
    CustomLabel * costLabel;
    // added by roja on 21-09-2019...
    CustomLabel * promoIdLbl;
    CustomLabel * discountLbl;
    CustomLabel * uomLbl;
    CustomLabel * offerLbl;
    
    
    // upto here added by roja on 21-09-2018..
    CustomLabel * taxRateLabel;
    CustomLabel * taxLabel;
    CustomLabel * actionLabel;
    
    UILabel * orderIdValueLabel;
    
    //UITABLEVIEW...
    UITableView * orderItemsTable;
    
    //Table View's for the popup's
    UITableView * paymentModeTable;
    UITableView * paymentTypeTable;
    UITableView * virtualStoreTable;
    UITableView * orderChannelTable;
    UITableView * shipmentTypeTable;
    UITableView * deliveryTypeTable;
    UITableView * shipmentModeTable;
    
    UITableView * productListTable;
    UITableView * priceTable;
    
    //used for all popUp's....
    UIPopoverController * catPopOver;
    
    UIDatePicker * myPicker;
    UIView *pickView;
    NSString * dateString;
    
    // Used To display the Alert messages
    UILabel * userAlertMessageLbl;
    NSTimer * fadeOutTime;
    
    //Array Initialization...
    NSMutableArray * paymentModeArray;
    NSMutableArray * paymentTypeArray;
    NSMutableArray * virtualStoresArray;
    NSMutableArray * orderChannelArray;
    NSMutableArray * shipmentTypeArray;
    NSMutableArray * deliveryTypeArray;
    NSMutableArray * shipmentModeArray;
    
    NSMutableArray * productListArray;
    NSMutableArray * orderItemListArray;
    
    NSMutableArray * nextActivitiesArray;
    //Not In Use..
    UIView * transparentView;
    
    NSDictionary  * customerInfoDic;
    UITextField * itemSalePriceTxt;
    UILabel * itemCostLabel;
    
    // added by roja
    NSMutableDictionary * dealOffersDic;
    
    // added by roja on 13/02/2019
    CustomTextField * firstNameTF;
    CustomTextField * lastNameTF;
    CustomTextField * deliveryStartTimeTF;
    CustomTextField * deliveryEndTimeTF;

    CustomTextField * confirmStartTimeTF;
    CustomTextField * confirmEndTimeTF;
    CustomTextField * deliveryModelTF;
    
    UIButton * dropDownBtn;
    
    UIScrollView * customerDetailsScrollView;
    UIView * customerAddressView;
    UIView * billingAddressView;
    UIView * shipmentAddressView;
    UIView * otherDetailsView;
    
    UITextField * shipmentPinText;
    
    // added by roja on 10-09-2018...
    UILabel * subTotalLabel;
    UILabel * totalTaxLbl;
    UILabel * shippingCostLabel;
    UILabel * otherDiscountsLbl;
    UILabel * netValueLabel;
    UILabel * totalCostLabel;
    UILabel * amountPaidLabel;
    UILabel * amountDueLabel;
    
    UILabel * backGroudLbl1;
    UILabel * backGroudLbl2;
    UILabel * backGroudLbl3;
    UILabel * backGroudLbl4;
    
//    UIButton * backButton2;
    CustomTextField * netValueTF;
    
    NSMutableArray * deliveryModelArray;
    UITableView * deliveryModelTable;

    NSMutableArray * startTimedetailsArr;
    UITableView * startTimeTable;
    
    CustomLabel * availableQtyLbl;
    CustomLabel * confirmQtyLbl;
    
    UITextField * confirmQtyText;
    UIButton * submitBtn;
    UIButton * saveBtn;
    UIButton * cancelBtn;
    
    int selectedStatusTag;
    
    NSString * orderStatus;

    // upto here added by roja on 13/02/2019
}

@property (strong,nonatomic)NSString * orderId;

@property (readwrite)    CFURLRef        soundFileURLRef;
@property (readonly)    SystemSoundID    soundFileObject;




@end

