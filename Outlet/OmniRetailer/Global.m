    //
//  Global.m
//  Feests
//
//  Created by Satya Siva Saradhi on 02/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Global.h"


@implementation Global

NSString *dealTotalBillValue = @"0.0";
NSString *user_name = @"";
NSString *userPassword = @"";
NSString *host_name = @"";
NSString *port_no   = @"";
NSString *tax_Value = @"";
NSString *swipe_Status = @"";
NSString *cardNumber = @"";
NSString *amountPaid = @"";
NSString *cvvNumber = @"";
NSString *originalDomain = @"";
NSString *originalPortNumber = @"";
NSString *billCustomerName = @"";
NSString *billChangeReturn = @"";
NSString *custID = @"";
NSString *password_ = @"";
NSString *mail_ = @"";
NSString *typeBilling = @"";
NSString *presentLocation = @"";
BOOL loginStatus = TRUE;
BOOL billTypeStatus = FALSE;
BOOL changeReturnStatus = FALSE;
BOOL exchangingBillingStatus = FALSE;
BOOL billingStatus = FALSE;
NSString *counterName = @"";
NSString *firstName = @"";
NSString *roleName = @"";
NSString  * zone = @"";

BOOL isOfflineService = FALSE;
BOOL tableStatus = FALSE;
BOOL waiterStatus = FALSE;
BOOL skuStatus = FALSE;
BOOL taxStatus = FALSE;
BOOL dealStatus = FALSE;
BOOL offerStatus = FALSE;
BOOL employeeStatus = FALSE;
BOOL denominationStatus = FALSE;
BOOL customerDownLoadStatus = FALSE;
BOOL memberDetailsDownLoad = FALSE;


BOOL syncStatus = TRUE;
BOOL barcodeFlag_newbill = TRUE;
BOOL barcodeFlag_pendingbill = TRUE;
BOOL barcodeFlag_exchbill = TRUE;

NSMutableArray *discountReasons = nil;

NSMutableArray *finalLicencesDetails = nil;

int pageNo = 0;
//int currentSelection = -1;

NSMutableArray *selectedColor = nil;
NSMutableArray *finalTaxDetails = nil;

PowaPOS *powaPOS = nil;
PowaTSeries *printer = nil;
PowaTSeries *cashDrawer = nil;
PowaS10Scanner *scanner = nil;





NSString *shiftId = @"";
NSString *shiftStart = @"";
NSString *shiftEnd = @"";

int totalAvailSkuRecords = 0;
int totalAvailSkuEans = 0;
int totalAvailPriceRecords = 0;
NSMutableArray *accessControlActivityArr;
NSMutableArray *accessControlArr;
NSMutableArray *roleNameLists;
int acessPermissionVal = 0;

int totalAvailEmployees = 0;
int totalAvailDenominations = 0;

BOOL isFoodCouponsAvail = false;
BOOL isEmployeeSaleId = false;

float minPayAmt = 0;

NSString *deviceId = @"";
NSString *cashierId = @"";

BOOL categoryStatus = FALSE;
BOOL subCategoruStatus = FALSE;
BOOL productStatus = FALSE;

// added by roja on 06/06/2019
BOOL giftCouponStatus = FALSE;
BOOL giftVoucherStatus = FALSE;
BOOL loyaltyCardsStatus = FALSE;
//Upto here added by roja on 06/06/2019


int totalAvailableCategories = 0;
int totalAvailableSubCategories = 0;
int totalAvailableProducts = 0;



BOOL isProductsMenu = false;

BOOL isBarcodeType = false;

NSString *discCalcOn = @"";
NSString *discTaxation = @"";

BOOL isCustomerBillId = false;

BOOL isRoundingRequired = true;

//added by Srinivasulu on   29/04/2017 -- 30/04/2017 -- 20/06/2017.... 07/09/2017 -- 18/09/2017 -- 20/09/2017 -- 12/11/2017 -- 19/04/2018 -- 23/08/2018  -- 31/09/2018....

NSMutableArray * returnReasonsArr = nil;

NSString * outletTollFreeNumberStr = @"";
NSString * StoreAddressStr = @"";
NSString * storeCodeStr = @"";
NSString * currencyCodeStr = @"";

BOOL isWifiSelectionChanged = TRUE;
BOOL isZreportHasTaken = TRUE;
BOOL zeroStockCheckAtOutletLevel = true; 
BOOL isManualDiscounts = TRUE;
BOOL isEnforceDenominations = false;
BOOL isEnforceVoidItemsReason = false;
BOOL isEnforceBillCancelReason = false;
BOOL applyLatestCampaigns = false;
BOOL allowItemPriceEdit = true;
BOOL isDayStartWithSync = false;
BOOL isToCallApplyCampaigns = true;
BOOL isToShowOnlineOrders = true;

NSString * barcodeTypeStr = @"";

BOOL isMasterCounter = false;
BOOL isFileDownload = true;// false
BOOL isHybirdMode = false;
NSString * serviceURLTypeStr = @"http";
BOOL isToSaveOnlineBill = true;
//which are used for startPrinter....
NSString * portSettings = @"";
StarIoExtEmulation emulation = 0;
BOOL isPrinted = false;

NSString * businessCategoryStr = @"";
//upto here on 30/04/2017 -- 07/09/2017 -- 20/06/2017.... 18/09/2017 -- 20/09/2017 -- 12/11/2017 -- 19/04/2018 -- 23/08/2018 -- 31/09/2018....



//added by Bhargav on 03/07/2017 -- 02/08/2017 -- 11/10/2017 -- 06/02/2018....

BOOL  isHubLevel = false;
NSString * zoneID = @"";
NSString * wareHouseIdStr = @"";
NSString * counterIdStr = @"";

//upto here on 03/07/2017 -- 02/08/2017 --  20/09/2017 -- 06/02/2018....



- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}




@end
