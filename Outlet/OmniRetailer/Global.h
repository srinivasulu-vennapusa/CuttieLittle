//
//  Global.h
//  Feests
//
//  Created by Satya Siva Saradhi on 02/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PowaPOSSDK/PowaPOSSDK.h>
#import <ExternalAccessory/ExternalAccessory.h>

//added by Srinivasulu on 19/06/2017....
//reason is used for starIO_print....

#import "Communication.h"
#import "ModelCapability.h"

//upto here on 19/06/2017....

@interface Global : UIViewController {

}

extern int pageNo;
extern NSString *amountPaid;
extern NSMutableArray *finalTaxDetails;
extern NSString *billCustomerName;
extern NSString *billChangeReturn;
extern NSString *user_name;
extern NSString *userPassword;
extern NSString *cardNumber;
extern NSString *cvvNumber;
extern NSString *host_name;
extern NSString *port_no;
extern NSString *tax_Value;
extern NSString *swipe_Status;     // while going to swipe view check whether payment is done ..
extern NSMutableArray *selectedColor;
extern NSString *originalDomain;
extern NSString *originalPortNumber;
extern NSString *dealTotalBillValue;
extern NSString *custID;
extern NSString *password_;
extern NSString *mail_;
extern NSString *typeBilling;
extern BOOL loginStatus;
extern BOOL billTypeStatus;
extern BOOL changeReturnStatus;
extern BOOL exchangingBillingStatus;
extern BOOL billingStatus;
extern NSMutableArray *finalLicencesDetails;
extern NSString *presentLocation;
extern NSString *counterName;
extern NSString *firstName;
extern NSString *roleName;
extern NSString *zone;


extern BOOL isOfflineService;
extern BOOL tableStatus;
extern BOOL waiterStatus;
extern BOOL skuStatus;
extern BOOL taxStatus;
extern BOOL dealStatus;
extern BOOL offerStatus;
extern BOOL employeeStatus;
extern BOOL denominationStatus;
extern BOOL customerDownLoadStatus;
extern BOOL memberDetailsDownLoad;


extern BOOL syncStatus;
extern PowaPOS *powaPOS;
extern PowaTSeries *printer;
extern PowaTSeries *cashDrawer;
extern PowaS10Scanner *scanner;

extern NSString *shiftId;
extern NSString *shiftStart;
extern NSString *shiftEnd;

extern int totalAvailSkuRecords;
extern int totalAvailPriceRecords;
extern int totalAvailSkuEans;
extern BOOL barcodeFlag_newbill;
extern BOOL barcodeFlag_pendingbill;
extern BOOL barcodeFlag_exchbill;
extern NSMutableArray *discountReasons;
extern NSMutableArray *accessControlActivityArr;
extern NSMutableArray *accessControlArr;
extern NSMutableArray *roleNameLists;

extern int acessPermissionVal;
extern int totalAvailEmployees;

extern BOOL isFoodCouponsAvail;
extern float minPayAmt;
extern BOOL isEmployeeSaleId;
extern NSString *deviceId;

extern int totalAvailDenominations;
extern NSString *cashierId;
extern BOOL isBarcodeType ;
//extern int currentSelection;

//Global.h

extern BOOL categoryStatus;
extern BOOL subCategoruStatus;
extern BOOL productStatus;

extern BOOL giftCouponStatus;
extern BOOL giftVoucherStatus;
extern BOOL loyaltyCardsStatus;



//int
extern int totalAvailableCategories;
extern int totalAvailableSubCategories;
extern int totalAvailableProducts;


//cheking the flag
extern BOOL isProductsMenu;

extern NSString *discCalcOn;
extern NSString *discTaxation;
extern BOOL isCustomerBillId;
extern NSString *zone;
extern BOOL isRoundingRequired;







//Added By Bhargav.v on 11/11/2017

extern NSString * wareHouseIdStr;


//upto here

//upto here on 30/04/2017....

//added by Bhargav.v on 26/06/2017...

extern BOOL isHubLevel;

// upto here on 26/06/2017...

//Added By Bhargav.v on 02/08/2017...

extern NSString * zoneID;
extern NSString * counterIdStr;
//upto Here on 02/08/2017..


//added by Srinivasulu on   29/04/2017 -- 30/04/2017 -- 07/09/2017 -- 18/09/2017 -- 20/09/2017 -- 12/11/2017 -- 19/04/2018 -- 02/07/2018 -- 23/08/2018 -- 31/09/2018....

extern NSMutableArray * returnReasonsArr;

extern NSString * outletTollFreeNumberStr;
extern NSString * StoreAddressStr;
extern NSString * storeCodeStr;
extern NSString * currencyCodeStr;

extern BOOL isWifiSelectionChanged;
extern BOOL isZreportHasTaken;
extern BOOL zeroStockCheckAtOutletLevel;
extern BOOL isManualDiscounts;
extern BOOL isEnforceDenominations;
extern BOOL isEnforceVoidItemsReason;
extern BOOL isEnforceBillCancelReason;
extern BOOL applyLatestCampaigns;
extern BOOL allowItemPriceEdit;
extern BOOL isDayStartWithSync;
extern BOOL isToCallApplyCampaigns;
extern BOOL isToShowOnlineOrders;

extern BOOL isMasterCounter;
extern BOOL isFileDownload;
extern BOOL isHybirdMode;
extern NSString * serviceURLTypeStr;
extern BOOL isToSaveOnlineBill;

//which are used for startPrinter....
extern NSString * portSettings;
extern StarIoExtEmulation emulation;
extern BOOL isPrinted;

extern NSString * barcodeTypeStr;

extern NSString * businessCategoryStr;

//upto here on 30/04/2017 -- 07/09/2017 -- 18/09/2017 -- 20/09/2017 -- 12/11/2017 -- 19/04/2018 -- 02/07/2018 -- 23/08/2018 -- 31/09/2018....

@end
