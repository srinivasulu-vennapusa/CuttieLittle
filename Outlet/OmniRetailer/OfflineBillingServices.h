//
//  OfflineServices.h
//  OmniRetailer
//
//  Created by Sonali on 7/10/15.
//
//



#import <Foundation/Foundation.h>
#import "WebServiceController.h"
#import "CampaignRequestModel.h"

@interface OfflineBillingServices : NSObject<SkuServiceDelegate,GetAllDealsDelegate,EmployeeServiceDelegate,DenominationMasterDelegate,utilityMasterServiceDelegate,ProductMasterSvcDelegate,StoreTaxationDelegate,MenuServiceDelegate,GetAllOffersDelegate,CustomerServiceDelegate,MemberServiceDelegate,RoleServiceDelegate,GiftCouponServicesDelegate, LoyaltyCardServcDelegate,GiftCouponServcDelegate, VoucherServiceDelegate >{
    
    NSMutableArray *offerList;
    NSMutableArray *dealsList;
    
    NSMutableArray *itemsSkuIdList;
    NSMutableArray *itemsPluCodeList;
    NSMutableArray *itemsUnitPriceList;
    NSMutableArray *itemsIndividualQtyList;
    NSMutableArray *itemsTotalPriceList;
    NSMutableArray *itemsStatusList;
    NSMutableArray *itemsOptionalDiscountList;
    
    NSMutableArray *mFreeQtyArrayList;
    NSMutableArray *mProductDealQty;
    NSMutableArray *freeItemLists;
    NSMutableArray *freeItemQtyLists;
    NSMutableArray *dealDiscount;
    NSMutableArray *mProductDealDescription;
    NSMutableArray *mAllowMultipleDiscounts;
    NSMutableArray *repeatArrayList;
    NSMutableArray *appliedDealIdList;
    NSMutableArray *isDealApplied;
    NSMutableArray *discountTypeArrayList;
    NSMutableArray *discountIdArrayList;
    NSMutableArray *mProductOfferPrice;
    NSMutableArray *dealSkuListAll;
    NSMutableArray *mProductOfferDescription;
    NSMutableArray *mProductOfferType;
    NSMutableArray *availableOffers;
    
    
    //added by Srinivasulu on 08/09/2017....
    
    NSMutableArray * priceBasedOffersList;
    NSMutableArray * groupTurnOverOffersList;

    //upto here on 08/09/2017....
    
    
    //added by Srinivasulul on 17/08.2017....
    
//    static List<Integer> individualItemIndexes = new ArrayList<Integer>();
//    static List<ApplyOffer> priceBasedOffersList = new ArrayList<ApplyOffer>();
    
    NSMutableArray * individualItemsIndexesArr;
    NSMutableArray * mainPriceBasedOffersList;

    NSMutableDictionary * applyGroupTurnOverOffersDic;

    //upto here on 17/08/2017....
    
    NSMutableArray *comboOffersList;
    NSMutableArray *lowestPriceItemOfferList;
    NSMutableArray *individualItemIndexesInCombo;
    NSMutableArray *appliedOffers;
    NSMutableArray *turnOverOffersList;
    float turnOverDeal;
    float mtotalBill;
    float toGiveDealQuantity;
    float turnOverMinPurchaseAmt;
    float totalOfferDiscountGlobal;
    NSMutableDictionary *applyDealsAndOfferResponse;
    
    NSMutableArray *appliedOfferIdsArr;
    NSMutableArray *promoSkusArrList;
    
    
    NSMutableArray *prioritizedItemsArr;
    
    NSMutableArray *appliedOffersMinPurchaseQty;
    NSMutableArray *customerFilterArr;
    
    NSMutableDictionary *turnOverOffers;
    NSMutableDictionary *turnOverDeals;
    
    NSMutableArray *employeeCodeList;
    NSString *employeeCode;
    
    int dealsStartIndex;
    int totalDealRecordsCount;
    
    int offersStartIndex;
    int totalOffersRecordsCount;

    int customerStartIndex;
    int totalCustomerRecordsCount;
    
    int membersStartIndex;
    int totalMembersRecordsCount;
    
   
    
}

-(BOOL)getSkuDetails:(int)startIndex totalRecords:(int)totalRecords;
-(NSMutableDictionary *)getProductDetails:(NSString *)skuId isEanSearch:(BOOL)isEanSearch;
-(BOOL)getDeals;
-(NSDictionary *)applyDealsAndOffers:(NSString *)skuid qty:(NSString *)quantity total:(NSString *)total itemPrice:(NSString *)item_price ;
-(NSMutableDictionary*)openBill:(NSString *)billId;
-(NSMutableArray *)getExistedOfflineBillIds:(NSString *)searchString;
-(NSString *)updateBilling:(NSString *)billId bill_details:(NSDictionary *)details due:(NSString *)bill_due;
-(NSMutableArray *)getPendingBills:(NSString *)searchString;
-(NSMutableArray *)getCompletedBills:(NSString *)searchString fromDate:(NSString *)fromDate;
//-(BOOL)saveOffers;
-(BOOL)getOffers;

-(NSMutableArray *)getLocalPriceLists:(NSString *)skuId ;
-(BOOL)getPriceLists:(int)startIndex totalRecords:(int)totalRecords;
-(BOOL)getTaxes;
-(NSMutableArray *)getTaxForSku:(NSString *)taxCode;
-(BOOL)clearSkuTable ;
-(NSMutableArray *)getDoorDeliveryBills:(NSString*)searchString;
-(void)saveCustomerDetails:(NSDictionary*)custDetails;
-(void)updateBillingStatus:(NSString*)status billId:(NSString *)billId;
-(NSDictionary *)getCustomerDetails:(NSString*)phoneNo;
-(NSMutableArray *)getCancelledBills:(NSString*)searchCriteria;
- (BOOL)saveReturnedItems:(NSArray *)items bill_id:(NSString *)bill_id;
- (BOOL)saveExchangedItems:(NSArray *)items bill_id:(NSString *)bill_id;
-(BOOL)saveTaxes:(NSArray *)taxArr;
-(BOOL)getSkuEanDetails:(int)startIndex totalRecords:(int)totalRecords;
-(BOOL)saveGroupsInfo;
-(NSMutableDictionary *)applyCampaignsOffline:(CampaignRequestModel *)campaignRequestModel;
-(NSArray*)getItemsCampaignsInfo:(NSString*)billId;
-(void)getGroupItems;
-(BOOL)getEmployeeDetails:(int)startIndex totalRecords:(int)totalRecords;
-(BOOL)getDenominationsDetails:(int)startIndex totalRecords:(int)totalRecords;

//changed by Srinivasulu on 12/11/2017....
//reason -- added the input parameter....


//-(NSMutableArray*)getDenominationDetails;
-(NSMutableArray*)getDenominationDetails:(NSString *)currencyTypeStr;

-(void)saveInformationInHybirdMode:(NSArray *)infoArr;

//upto here on 12/11/2017....



-(BOOL)getProductCategories:(int)startIndex totalRecords:(int)totalRecords;
-(BOOL)getSubCategories:(int)startIndex totalRecords:(int)totalRecords;
-(BOOL)getProducts:(int)startIndex totalRecords:(int)totalRecords;

-(NSMutableArray *)getCategoriesList;
-(NSMutableArray *)getSubCategories:(NSString*)subCategoryString;
-(NSMutableArray *)getProducts:(NSString*)categoryString subCat:(NSString*)subCategoryString;
-(NSMutableArray *)getSKuDetails:(NSString *)product;
-(NSMutableDictionary *)getProductCategory:(NSString*)productId;
-(NSMutableArray *)getExchangedBills:(NSString *)searchString;
-(NSMutableArray *)getReturnedBills:(NSString *)searchString ;


//method added by Srinviasulu on 24/04/2017....
-(NSMutableArray *)getCreditBills:(NSString *)searchString;
-(BOOL)getStoreTaxationDetails;
-(BOOL)getStoreTaxationDetailsThroughtSoapServices;



//added by Srinivasulu on 05/08/2016....

-(NSString *)saveTransactionsTemp:(NSString*)billId transactionDetails:(NSDictionary *)transactionDic;

-(NSMutableDictionary *)getScannedItemDetails:(NSString *)skuId isEanSearch:(BOOL)isEanSearch;
//upto here on 05/08/2017....



-(NSMutableArray *)getOfflineEmplooyeDetails;


//methods used for searching the bill's in offline....
//exising methods....
-(NSMutableArray *)geCompletedBillsList:(NSString *)searchString;



//new methods added by Srinivasulu on 21/10/2017....
-(NSMutableDictionary *)getBillInfo:(NSString *)billStatus  searchInfo:(NSString *)searchStr mobileNo:(NSString *)phoneNo startingDate:(NSString *)startDateStr endDate:(NSString *)endDateStr startIndex:(int)startIndexNo maxRecords:(int)maxRecordsNo;


//added by Srinivasul on 20/04/2018....
-(void)reduceTheBillingItemsStock:(NSArray *)items stockUpdationType:(NSString *)increase_or_reduce_str;

-(NSString *)getAndReturnMaximumOfflineBillCount:(NSString *)bussiness_date DefaultSerialBillId:(NSString *)defalutStr;// existDB:(sqlite3 )localDatabase;
-(void)changeSerialBuildIdLocally:(NSString *)newSerialBillId  originalBillId:(NSString *)originalBillIdStr;


-(void)callMenuDetails;
-(NSMutableDictionary *)getProductMenuDetailsFromfflineDB;

-(void)changeOriginalBillIdLocally:(NSString *)newOriginalBillIdStr  existingBillId:(NSString *)oldBillIdStr numberOfPayment:(int)noOfPayments  transactionInfo:(NSArray *)completeTranactionInfoArr;

-(BOOL)callGetCustomerList:(int)startIndex;
-(NSDictionary *)getCustomerDetailsBasedOnPhoneNo:(NSString *)phoneNo;
-(void)saveCustomerDetailsBasedOnPhone:(NSDictionary *)custDetails;
-(void)updateCustomerDetailsBasedOnStatus:(int)status;

-(BOOL)callGetMemberDetails:(int)startIndex;

-(NSDictionary *)isWhetherValideUserCredentials:(NSDictionary *)enteredInfoDic;

//changed by Srinivasulu on 18/09/2018....
-(NSString *)createBilling:(NSString *)json isToGenerateBillID:(Boolean)generateBillId;
-(void)saveCreditNoteInfo:(NSArray *)returnTransactionList;


// added by roja on 06/05/2019...

//                  <------ Start Of offline Loyalty card methods------>
-(BOOL)getLoyaltyCardDownloadDetailsInCSVFileForm; // For CSV

-(NSMutableDictionary *)fetchLoyaltyCardDetailsFromSqliteWithPhoneNumber:(NSString *)phoneNumberStr withGiftId:(NSString *)giftIdStr;
-(NSMutableArray *)getLoyaltyProgramPurchaseRangesFromSqlite:(NSString *)loyaltyProgramNumber;
-(void)updateCustomerLoyaltyTable:(NSString *)loyaltyCardNumber pointsEarnedValue:(int)pointsEarned pointsRemainingValue:(int)pointsRemaining pointsUsedValue:(int)pointsUsed cashValue:(float)cashVal;
-(BOOL)issueLoyaltyCardToTheCustomerWithPhoneNumber:(NSString *)customerMobileNum withEmailId:(NSString *)customerEmailId withName:(NSString *)customerNameStr netBillValue:(float)netValue;
-(void)loyaltyCardUpdatingToOnlineDbBasedOnStatus:(int)status; // issuing to Online

//                  <------ Start Of offline Coupon methods------>
-(BOOL)getCouponsDownloadDetailsInCSVFileForm; // For CSV
-(NSMutableDictionary *)fetchGiftCouponDetailsFromSqliteWithPhoneNumber:(NSString *)customerPhnNo enteredCouponCode:(NSString *)givenCouponCodeStr;
-(void)updateCustomerCouponDetailsTableForPhoneNum:(NSString *)customerPhnNum noOfClaimsToUpdate:(int)noOfClaims setClaimStatus:(BOOL)claimStatus forCouponCode:(NSString *)couponCode totalNumberOfClaims:(int)totalClaimsLimit forBillReference:(NSString *)billRefStr ;


//                  <------ Start Of offline voucher methods------>
-(BOOL)getVoucherDownloadDetailsInCSVFileForm; // For CSV

-(NSMutableDictionary *)fetchGiftVoucherDetailsFromSqliteWithVoucherCodeStr:(NSString *)voucherCodeStr;
-(void)updateGiftVoucherDetailsTableForVoucherCode:(NSString *)voucherCodeStr  setClaimStatusTo:(int)claimStatus forBillRef:(NSString *)billRefStr;


//Upto here added by roja on 06/05/2019  && 21/05/2019...


@end
