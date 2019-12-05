//
//  WebServiceController.h
//  SampleWebServices
//  
//  Created by Chandrasekhar on 9/1/15.
//  Copyright (c) 2015 Technolabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceConstants.h"
#import "WebServiceUtility.h"
#import "SupplierServiceSvc.h"
#import "EmployeesSvc.h"
#import "ProductsServiceSvc.h"
#import "ProductMasterServiceSvc.h"

//added by Srinivasulu on 10/05/2017....

#import "ZoneMasterServiceSvc.h"
#import "OrderServiceSvc.h"

//written by Srinivasulu on 13/06/2017....
//requeired mehod has to be changed to optional in order to reduce the warning the project....
//@optional


//upto here on 10/05/2017....

@protocol CreateBillingDelegate

- (void)createBillingSuccessResponse:(NSDictionary *)successDictionary;
- (void)createBillingErrorResponse;

@end
@protocol UpdateBillingDelegate

- (void)updateBillingSuccessResponse:(NSDictionary *)successDictionary;
- (void)updateBillingErrorResponse;

@end
@protocol GetBillsDelegate


//written by Srinivasulu on 13/06/2017....
//requeired mehod has to be changed to optional in order to reduce the warning the project....
@optional

//@required
- (void)getBillsSuccesResponse:(NSDictionary *)successDictionary;
//@required
- (void)getBillsFailureResponse:(NSString *)failureString;
//@required
- (void)getBillDetailsSuccesResponse:(NSDictionary *)successDictionary;
- (void)getBillIdsSuccessResponse:(NSDictionary *)successDictionary;

-(void)searchBillsSuccesssResponse:(NSDictionary *)successDictionary;
-(void)searchBillsErrorResponse:(NSString *)errorResponse;


//added by Srinivasulu on 21/05/2018....

-(void)getCustomerPurchasesSuccesssResponse:(NSDictionary *)successDictionary;
-(void)getCustomerPurchasesErrorResponse:(NSString *)errorResponse;

//upto here on 21/05/2018....


@end

@protocol ReturnBillingDelegate

- (void)returnBillingSuccessResponse:(NSDictionary *)successDictionary;
- (void)returnBillingErrorResponse;

@end

@protocol ExchangeBillingDelegate

- (void)exchangeBillingSuccessResponse:(NSDictionary *)successDictionary;
- (void)exchangeBillingErrorResponse;

@end

@protocol SearchProductsDelegate

- (void)searchProductsSuccessResponse:(NSDictionary *)successDictionary;
- (void)searchProductsErrorResponse;

@end

@protocol GetSKUDetailsDelegate

- (void)getSkuDetailsSuccessResponse:(NSDictionary *)successDictionary;
- (void)getSkuDetailsErrorResponse:(NSString*)failureString;

@end
@protocol GetDealsAndOffersDelegate

- (void)getDealsAndOffersSuccessResponse:(NSDictionary *)successDictionary;
- (void)getDealsAndOffersErrorResponse;

@end

@protocol GetAllDealsDelegate

@optional
- (void)getAllDealsSuccessResponse:(NSDictionary *)successDictionary;
- (void)getAllDealsErrorResponse:(NSString *)errorResponse;

- (BOOL)getAllDealsSuccessResponseAndReturnSaveStatus:(NSDictionary *)successDictionary;
- (BOOL)getAllDealsErrorResponseAndReturnSaveStatus:(NSString *)errorResponse;

@end

@protocol SearchDealsDelegate

- (void)searchDealsSuccessResponse:(NSDictionary *)successDictionary;
- (void)searchDealsErrorResponse;

@end

@protocol GetAllOffersDelegate

@optional
- (void)getAllOffersSuccessResponse:(NSDictionary *)successDictionary;
- (void)getAllOffersErrorResponse:(NSString *)errorResponse;

- (BOOL)getAllOffersSuccessResponseAndReturnSaveStatus:(NSDictionary *)successDictionary;
- (BOOL)getAllOffersErrorResponseAndReturnSaveStatus:(NSString *)errorResponse;

@end

@protocol GetScrapStockDelegate

- (void)getScrapStockSuccessResponse:(NSDictionary *)successDictionary;
- (void)getScrapStockErrorResponse:(NSString *)responseMessage;

@end

@protocol GetStockDetailsbyFilter

- (void)getStockDetailsByFilterSuccessResponse:(NSDictionary *)successDictionary;
- (void)getStockDetailsByFilterErrorResponse;

@end

@protocol GetStockLedgerReport

- (void)getStockLedgerReportSuccessResponse:(NSDictionary *)successDictionary;
- (void)getStockLedgerReportErrorResponse;

@end

@protocol ProductGroupMasterServiceDelegate

- (void)productGroupMasterSuccessResponse:(NSDictionary *)successDictionary;
- (void)productGroupMasterErrorResponse;

@end


@protocol  SkuServiceDelegate

//written by Srinivasulu on 13/06/2017....
//requeired mehod has to be changed to optional in order to reduce the warning the project....
@optional

//@required
-(BOOL)getSkuDetailsSuccessResponse:(NSDictionary *)sucess;
-(BOOL)getSkuDetailsFailureResponse:(NSString*)failure;
-(BOOL)getPriceListSuccessResponse:(NSDictionary *)success;
- (BOOL)getSkuEanssSuccessResponse:(NSDictionary *)successDictionary;
- (BOOL)getSkuEansErrorResponse:(NSString*)failure;

//added by Bhargav.v on 24/08/2017 && 14/06/2017....

-(void)getProductClassSuccessResponse:(NSDictionary*)successDictionary;
-(void)getProductClassErrorResponse:(NSString*)errorResponse;

-(void)getCategoriesByLocationSuccessResponse:(NSDictionary *)successDictionary;
-(void)getCategoriesByLocationErrorResponse:(NSString *)errorResponse;

-(void)getBrandsByLocationSuccessResponse:(NSDictionary *)successDictionary;
-(void)getBrandsByLocationErrorResponse:(NSString *)errorResponse;


-(void)getPriceListSkuDetailsSuccessResponse:(NSDictionary*)successDictionary;
-(void)getPriceListSKuDetailsErrorResponse:(NSString*)errorResponse;

//upto here on 24/08/2017....

@end

//added by Srinivasulu on 29/08/2018 && 10/09/2018 && 11/09/2018....

@protocol  AppSettingServicesDelegate

@optional
-(void)generateBuildOTPSuccessResponse:(NSDictionary *)successDictionary;
-(void)generateBuildOTPErrorResponse:(NSString *)errorResponse;

-(void)validateBuildOTPSuccessResponse:(NSDictionary *)successDictionary;
-(void)validateBuildOTPErrorResponse:(NSString *)errorResponse;

// added by roja on 17/10/2019..
// At the time of converting SOAP call's to REST
-(void)getAppSettingsSuccessResponse:(NSDictionary *)successDictionary;
-(void)getAppSettingsErrorResponse:(NSString *)errorResponse;


@end

@protocol MemberServiceDelegate

@optional
- (void)getAllMembersDetailsSuccessResponse:(NSDictionary *)successDictionary;
- (void)getAllMembersDetailsErrorResponse:(NSString *)errorResponse;

- (BOOL)getAllMembersDetailsSuccessResponseAndReturnSaveStatus:(NSDictionary *)successDictionary;
- (BOOL)getAllMembersDetailsErrorResponseAndReturnSaveStatus:(NSString *)errorResponse;

- (void)getAllMemberShipUsersSuccessResponse:(NSDictionary *)successDictionary;
- (void)getAllMemberShipUsersErrorResponse:(NSString *)errorResponse;

- (BOOL)getAllMemberShipUsersSuccessResponseAndReturnSaveStatus:(NSDictionary *)successDictionary;
- (BOOL)getAllMemberShipUsersErrorResponseAndReturnSaveStatus:(NSString *)errorResponse;

// Added By Roja on 17/10/2019.... // At the time of converting SOAP call's to REST
- (void)authenticateUserSuccessResponse:(NSDictionary *)successDictionary;
- (void)authenticateUserErrorResponse:(NSString *)errorResponse;

- (void)changePasswordSuccessResponse:(NSDictionary *)successDictionary;
- (void)changePasswordErrorResponse:(NSString *)errorResponse;

- (void)userRegistrationSuccessResponse:(NSDictionary *)successDictionary;
- (void)userRegistrationErrorResponse:(NSString *)errorResponse;

@end

@protocol RoleServiceDelegate

@optional
- (void)getAllRolesDetailsSuccessResponse:(NSDictionary *)successDictionary;
- (void)getAllRolesDetailsErrorResponse:(NSString *)errorResponse;

- (BOOL)getAllRolesDetailsSuccessResponseAndReturnSaveStatus:(NSDictionary *)successDictionary;
- (BOOL)getAllRolesDetailsErrorResponseAndReturnSaveStatus:(NSString *)errorResponse;

@end
//upto here on 24/08/2017 && 10/09/2018 && 11/09/2018....



@protocol EmployeeServiceDelegate

@optional

-(BOOL)getEmployeeDetailsSucessResponse:(NSDictionary *)success; // used in offline
-(BOOL)getEmployeeErrorResponse:(NSString*)failure;

//added by Sai on 26/07/19
-(void)getEmployeeDetailsSucess:(NSDictionary*)successResponse;
-(void)getEmployeeDetailsFailure:(NSString*)successFailure;
//upto here added by Sai on 26/07/19

@end

//customer Walkout:

@protocol CustomerWalkOutDelegate

@optional

-(void)CreateCustomerWalkOutSuccessResponse:(NSDictionary*)sucessDictionary;
-(void)createCustomerWalkOutErrorResponse:(NSString*)error;
-(void)getCustomerWalkOutSuccessResponse:(NSDictionary*)sucessDictionary;
-(void)getCustomerWalkOutErrorResponse:(NSString*)error;

//added by Srinivasulu 10/10/2017....
//reason we need to create the customer walkins....

-(void)createCustomerWalkinsSuccessResponse:(NSDictionary *)sucessDictionary;
-(void)createCustomerWalkinsErrorResponse:(NSString *)error;

//upto here pm 10/10/2017....

@end


@protocol OffersMasterDelegate

@optional

-(void)getoffersSuccessResponse:(NSDictionary *) successDictionary;
-(void)getOffersErrorResponse:(NSString *)errorResponse;

@end

//Added By Bhargav.v on 06/02/2018
// Reason GetOffers is SOAP Call to avoid the complexity taking the delegate or protocol to make it restful functionality.....



@protocol OutletMasterDelegate

@optional
-(void)getCategorySuccessResponse:(NSDictionary*)sucessDictionary;
-(void)getCategoryErrorResponse:(NSString*)error;
-(void)getDepartmentSuccessResponse:(NSDictionary*)sucessDictionary;
-(void)getDepartmentErrorResponse:(NSString*)error;
-(void)getBrandMasterSuccessResponse:(NSDictionary*)sucessDictionary;
-(void)getBrandMasterErrorResponse:(NSString*)error;


@end

@protocol  StockRequestDelegate


@optional
- (void)createStockRequestsSuccessResponse:(NSDictionary *)successDictionary;
- (void)createStockRequestsErrorResponse:(NSString *)errorResponse;

@optional
- (void)getStockRequestsSuccessResponse:(NSDictionary *)successDictionary;
- (void)getStockRequestsErrorResponse:(NSString *)errorResponse;

@optional
- (void)updateStockRequestsSuccessResponse:(NSDictionary *)successDictionary;
- (void)updateStockRequestsErrorResponse:(NSString *)errorResponse;

@optional
- (void)getStockRequestSummarySuccessResponse:(NSDictionary *)successDictionary;
- (void)getStockRequestSummaryErrorResponse:(NSString *)errorResponse;

@optional

-(void)getStockRequestIdsSuccessResponse:(NSDictionary *)successDictionary;
-(void)getStockRequestIdsErrorResponse:(NSString *)errorResponse;

@end

@protocol utilityMasterServiceDelegate

//changed by Srinivasulu on 21/09/2017....
@optional

-(void)getLocationSuccessResponse:(NSDictionary*)sucessDictionary;
-(void)getLocationErrorResponse:(NSString*)error;

//@optional
-(BOOL)getProductCategoriesSuccessResponse:(NSDictionary*)successDictionary;
-(BOOL)getProductCategoriesErrorResponse:(NSString*)errorResponse;

//@optional
-(BOOL)getProductSubCategoriesSuccessResponse:(NSDictionary*)successDictionary;
-(BOOL)getProductSubCategoriesErrorResponse:(NSString*)errorResponse;


-(BOOL)getTaxesSuccessResponse:(NSDictionary*)successDictionary;
-(BOOL)getTaxesErrorResponse:(NSString*)errorResponse;

@end

//productMAster Service

@protocol ProductMasterSvcDelegate

-(BOOL)getProductsSuccessResponse:(NSDictionary*)successDictionary;

-(BOOL)getProductsErrorResponse:(NSString *)errorResponse;

@end


@protocol GetMessageBoardDelegate

- (void)getMessageBoardSuccessResponse:(NSDictionary *)successDictionary;
- (void)getMessageBoardErrorResponse;

@end

@protocol sizeAndColorsDelegate

-(void)getSizeAndColorsSuccessResponse:(NSDictionary *)successDictionary;
-(void)getSizeAndColorsErrorResponse:(NSString *)errorResponse;

@end

// STOCK ISSUE

@protocol StockIssueDelegate

@optional

-(void)createStockIssueSuccessResponse:(NSDictionary*)sucessDictionary;
-(void)createStockIssueErrorResponse:(NSString*)error;

@optional
-(void)getStockIssueSuccessResponse:(NSDictionary*)sucessDictionary;
-(void)getStockIssueErrorResponse:(NSString*)error;

@optional
-(void)getStockIssueDetailsSuccessResponse:(NSDictionary*)sucessDictionary;
-(void)getStockIssueDetailsErrorResponse:(NSString*)error;

@optional
-(void)getStockIssueSearchSuccessResponse:(NSDictionary*)sucessDictionary;
-(void)getStockissueSearchErrorResponse:(NSString*)error;

@optional

-(void)getStockIssueIdSuccessResponse:(NSDictionary*)sucessDictionary;
-(void)getStockIssueIdErrorResponse:(NSString*)error;


-(void)updateStockIssueSuccessResponse:(NSDictionary*)sucessDictionary;
-(void)updateStockIssueErrorResponse:(NSString*)error;


-(void)stockIssueIdsSuccessResponse:(NSDictionary*)successDictionary;
-(void)stockISsueIdsErrorResponse:(NSString *)error;

@end


@protocol StockReceiptServiceDelegate

@optional
-(void)getStockReceiptsSuccessResponse:(NSDictionary *)successDictionary;
-(void)getStockReceiptsErrorResponse:(NSString *)errorResponse;

@optional
-(void)createStockReceiptSuccessResponse:(NSDictionary *)successDictionary;
-(void)createStockReceiptErrorResponse:(NSString *)errorResponse;

@optional
-(void)getStockReceiptDetailsSuccessResponse:(NSDictionary *)successDictionary;
-(void)getStockReceiptDetailsErrorResponse:(NSString *)errorResponse;


@optional

-(void)upDateStockReceiptSuccessResponse:(NSDictionary *)successDictionary;
-(void)upDateStockReceiptErrorResponse:(NSString *)errorResponse;

@optional

-(void)getSuppliesReportSuccessResponse:(NSDictionary*)successDictionary;
-(void)getSuppliesReportErrorResponse:(NSString*)errorResponse;

// added by Roja on 17/10/2019….
// At the time of converting SOAP call's to REST
-(void)getStockProcurementReceiptSuccessResponse:(NSDictionary*)successDictionary;
-(void)getStockProcurementReceiptErrorResponse:(NSString*)errorResponse;

-(void)getStockProcurementReceiptsSuccessResponse:(NSDictionary*)successDictionary;
-(void)getStockProcurementReceiptsErrorResponse:(NSString*)errorResponse;

-(void)getStockProcurementReceiptIDSSuccessResponse:(NSDictionary*)successDictionary;
-(void)getStockProcurementReceiptIDSErrorResponse:(NSString*)errorResponse;

-(void)createNewStockProcurementReceiptSuccessResponse:(NSDictionary*)successDictionary;
-(void)createNewStockProcurementReceiptErrorResponse:(NSString*)errorResponse;

//Upto here added by Roja on 17/10/2019….

@end




@protocol StockReturnServiceDelegate

@optional
-(void)getStockReturnSuccessResponse:(NSDictionary*)successDictionary;
-(void)getStockReturnErrorResponse:(NSString*)errorResponse;


-(void)createStockReturnSuccessResponse:(NSDictionary*)successDictionary;
-(void)createStockReturnErrorResponse:(NSString*)errorResponse;


-(void)upDateStockReturnSuccessResponse:(NSDictionary*)successDictionary;
-(void)upDateStockReturnErrorResponse:(NSString *)errorResponse;


@end

@protocol DenominationMasterDelegate

@optional

-(BOOL)getDenominationsSuccessResponse:(NSDictionary*)successDictionary;
-(BOOL)getDenominationsErrorResponse:(NSString*)errorResponse;

@end

@protocol GetProductsByCategoryDelegate

-(void)getProductsByCategorySuccessResponse:(NSDictionary *)successDictionary;
-(void)getProductsByCategoryErrorResponse:(NSString *)errorResponse;

@end

@protocol StockVerificationSvcDelegate

@optional
-(void)getStockVerificationDetailsSuccessResponse:(NSDictionary *)successDictionary;
-(void)getStockVerificationDetailsErrorResponse:(NSString *)errorResponse;

@optional
-(void)getStockVerificationMasterDetailsSuccessResponse:(NSDictionary*)sucessDictionary;
-(void)getStockVerificationMasterDetailsErrorResponse:(NSString *)requestString;

@optional
-(void)getStockVerificationMasterChildSuccessResponse:(NSDictionary*)successDictionary;
-(void)getStockVerificationMasterChildsErrorResponse:(NSString *)requestString;

@end

@protocol BomMasterSvcDelegate

-(void)getMaterialConsumptionSuccessResponse:(NSDictionary*)successDictionary;

-(void)getMaterialConsumptionErrorResponse:(NSString*)errorResponse;

@end

@protocol  WarehouseGoodsReceipNoteServiceDelegate

@optional

- (void)getWarehouseGoodsReceipNoteSuccessResponse:(NSDictionary *)successDictionary;
- (void)getWarehouseGoodsReceipNotErrorResponse:(NSString *)errorResponse;

- (void)getWarehouseGoodsReceipNoteWithDetailsSuccessResponse:(NSDictionary *)successDictionary;
- (void)getWarehouseGoodsReceipNoteWithDetailsErrorResponse:(NSString *)errorResponse;


- (void)updateWarehouseGoodsReceipNoteSuccessResponse:(NSDictionary *)successDictionary;
- (void)updateWarehouseGoodsReceipNoteErrorResponse:(NSString *)errorResponse;

- (void)getWarehouseGoodsReceipNoteSummarySuccessResponse:(NSDictionary *)successDictionary;
- (void)getWarehouseGoodsReceipNoteSummaryErrorResponse:(NSString *)errorResponse;


- (void)createWarehouseGoodsReceipNoteSuccessResponse:(NSDictionary *)successDictionary;
- (void)createWarehouseGoodsReceipNoteErrorResponse:(NSString *)errorResponse;


- (void)createGRNsSuccessResponse:(NSDictionary *)successDictionary;
- (void)createGRNsErrorResponse:(NSString *)errorResponse;
@end

@protocol  SupplierServiceSvcDelegate

@optional

- (void)getSuppliersSuccessResponse:(NSDictionary *)successDictionary;
- (void)getSuppliersErrorResponse:(NSString *)errorResponse;


@end

@protocol PurchaseOrderSvcDelegate
@optional
- (void)getPurchaseOrderDetailsSuccessResponse:(NSDictionary *)successDictionary;
- (void)getPurchaseOrderDetailsErrorResponse:(NSString *)errorResponse;

//added on 16/02/2017....
- (void)getPORefIdsSuccessResponse:(NSDictionary *)successDictionary;
- (void)getPORefIdsErrorResponse:(NSString *)errorResponse;

-(void)getPurchaseOrdersSuccessResponse:(NSDictionary*)successDictionary;
- (void)getPurchaseOrdersErrorResponse:(NSString *)errorResponse;

// added by Roja on 17/10/2019….
// At the time of converting SOAP call's to REST
-(void)createPurchaseOrderSuccessResponse:(NSDictionary*)successDictionary;
- (void)createPurchaseOrderErrorResponse:(NSString *)errorResponse;

-(void)updatePurchaseOrderSuccessResponse:(NSDictionary*)successDictionary;
- (void)updatePurchaseOrderErrorResponse:(NSString *)errorResponse;


@end



@protocol GetStockMovementDelegate
-(void)getStockMovementSuccessResponse:(NSDictionary *)successDictionary;
-(void)getStockMovementErrorResponse:(NSString *)errorResponse;
@end


//added by Srinivasulu on 10/05/2017....

@protocol  ZoneMasterDelegate

@optional

- (void)getZonesSuccessResponse:(NSDictionary *)successDictionary;
- (void)getZonesErrorResponse:(NSString *)errorResponse;

@end

@protocol GetOrderDelegate

@optional

- (void)getAllOrdersSuccessResponse:(NSDictionary *)successDictionary;
- (void)getAllOrdersErrorResponse:(NSString *)errorResponse;

@end
//upto here on 10/05/2017....

//added by Bhargav on 26/05/2017....

@protocol  ModelMasterDelegate

@optional

-(void)getModelSuccessResponse:(NSDictionary*)successDictionary;
-(void)getModelErrorResponse:(NSString *)errorResponse;


@end

//upto here on 26/05/2017....


//added by Bhargav.v on 06/05/2017...
@protocol StoreStockVerificationDelegate

@optional

-(void)getProductVerificationSuccessResponse:(NSDictionary *)successDictionary;
-(void)getProductVerificationErrorResponse:(NSString *)errorResponse;

@optional

-(void)createStockVerificationSuccessResponse:(NSDictionary *)successDictionary;
-(void)createStockVerificationErrorResponse:(NSString * )errorResponse;

@optional

-(void)getProductVerificationDetailsSuccessResponse:(NSDictionary*)successDictionary;
-(void)getProductVerificationDetailsErrorResponse:(NSString *)errorResponse;

@optional

-(void)updateStockVerificationSuccessResponse:(NSDictionary *)successDictionary;
-(void)updateStockVerificationErrorResponse:(NSString *)requestString;

// added by roja on 17/10/2019.. // at the time of converting SOAP to REST..
-(void)getStoreLocationSuccessResponse:(NSDictionary *)successDictionary;
-(void)getStoreLocationErrorResponse:(NSString *)requestString;

-(void)getStoreUnitSuccessResponse:(NSDictionary *)successDictionary;
-(void)getStoreUnitErrorResponse:(NSString *)requestString;
// Upto here added by roja on 17/10/2019..


@end




//upto here on  06/05/2017....

//added by Srinivasulu on 03/07/2017....

@protocol StoreTaxationDelegate

@optional

-(BOOL)getStoreTaxesInDetailSuccessResponse:(NSDictionary *)successDictionary;
-(BOOL)getStoreTaxesInDeatailErrorResponse:(NSString *)errorResponse;

@end

//upto here on 03/07/2017....

//Added By Bhargav.v on 03/08/2017 && 10/08/2017....
@protocol  RolesServiceDelegate

@optional

-(void)getWorkFlowsSuccessResponse:(NSDictionary*)successDictionary;
-(void)gerWorkFlowsErrorResponse:(NSString *)errorResponse;

@end


@protocol SalesServiceDelegate

@optional

-(void)getHourWiseReportsSuccessResponse:(NSDictionary *)successDictionary;
-(void)getHourWiseReportErrorResponse:(NSString *)errorResponse;

//@optional
-(void)getVoidItemReportsSuccessResponse:(NSDictionary *)successDictionary;
-(void)getVoidItemReportErrorResponse:(NSString *)errorResponse;

-(void)getSalesPriceOverrideReportSuccessReponse:(NSDictionary *)successDictionary;
-(void)getSalesPriceOverrideReportErrorResponse:(NSString*)errorResponse;

-(void)getSalesMenCommissionReportSuccessResponse:(NSDictionary *)successDictionary;
-(void)getSalesMenCommissionReportErrorResponse:(NSString *)errorResponse;

-(void)getDailyStockReportSuccessResponse:(NSDictionary*)successDictionary;
-(void)getDailyStockReportErrorResponse:(NSString *)errorResponse;

-(void)getTrackerItemsDetalilsSuccessResponse:(NSDictionary *)successDictionary;
-(void)getTrackerItemsDetailsErrorResponse:(NSString *)errorResponse;

// added by roja on 17/10/2019....
-(void)getSalesReportsSuccessResponse:(NSDictionary *)successDictionary;
-(void)getSalesReportsErrorResponse:(NSString *)errorResponse;

-(void)getReturningItemSuccessResponse:(NSDictionary *)successDictionary;
-(void)getReturningItemErrorResponse:(NSString *)errorResponse;

-(void)getBillingDetailsSuccessResponse:(NSDictionary *)successDictionary;
-(void)getBillingDetailsErrorResponse:(NSString *)errorResponse; 

-(void)getXZReportSuccessResponse:(NSDictionary *)successDictionary;
-(void)getXZReportErrorResponse:(NSString *)errorResponse;


//Upto here added by roja on 17/10/2019....

@end

// Added By Bhargav.v on 26/02/2018...
// For the Order Management....

@protocol OutletOrderServiceDelegate

@optional
-(void)getOutletOrdersSuccessResponse:(NSDictionary *)successDictinoary;
-(void)getOutletOrdersErrorResponse:(NSString *)errorResponse;

@optional
-(void)getOutletOrderDetailsSuccessResponse:(NSDictionary*)successDictionary;
-(void)getOutletOrderDetailsErrorResponse:(NSString *)errorResponse;

@optional
-(void)createOutletOrderSuccessResponse:(NSDictionary *)successDictionary;
-(void)createOutletOrderErrorResponse:(NSString * )errorResponse;

@optional
-(void)updateOutletOrderSucessResponse:(NSDictionary *)successDictionary;
-(void)updateOutletOrderErrorResponse:(NSString *)errorResponse;

@optional
-(void)getCustomerEatingHabitsSuccessRespose:(NSDictionary *)successDictionary;
-(void)getCustomerEatingHabitsErrorResponse:(NSString *)errorResponse;

@end

//Added By Bhargav.v on 26/03/2018...
//Reason:Added New Service to the project (StoreServiceSvc).
@protocol StoreServiceDelegate

@optional
-(void)getStoresSuccessResponse:(NSDictionary *)successDictionary;
-(void)getStoreErrorResponse:(NSString *)errorResponse;

// added by roja on 10/01/2019...
-(void)getAllLayoutTablesSuccessResponse:(NSDictionary *)successDictionary;
-(void)getAllLayoutTablesErrorResponse:(NSString *)errorResponse;

-(void)getAvailableTablesSuccessResponse:(NSDictionary *)successDictionary;
-(void)getAvailableTablesErrorResponse:(NSString *)errorResponse;

@end

//upto here on 26/12/2017....

//upto here on  03/08/2017 && 10/08/2017....

//addded by Srinivasulu on 26/12/2017 && 24/12/2018...

@protocol CustomerServiceDelegate

@optional

-(void)generateOtpForCustomerSuccessReponse:(NSDictionary*)sucessDictionary;
-(void)generateOtpForCustomerErrorResponse:(NSString*)error;

-(void)validateOtpForCustomerSuccessResponse:(NSDictionary*)sucessDictionary;
-(void)validateForCustomerErrorResponse:(NSString*)error;

-(void)getCustomerListSuccessResponse:(NSDictionary*)sucessDictionary;
-(void)getCustomerListErrorResponse:(NSString*)errorResponse;

-(BOOL)getCustomerListSuccessResponseReturnStatus:(NSDictionary*)sucessDictionary;
-(BOOL)getCustomerListErrorResponseReturnStatus:(NSString*)errorResponse;

-(void)updateCustomerDetailsSuccessResponse:(NSDictionary*)sucessDictionary;
-(void)updateCustomerDetailsErrorResponse:(NSString*)errorResponse;

-(BOOL)updateCustomerDetailsSuccessResponseReturnStatus:(NSDictionary*)sucessDictionary;
-(BOOL)updateCustomerDetailsErrorResponseReturnStatus:(NSString*)errorResponse;

// added by roja on 09/01/2019....
-(void)getCustomerDetailsSuccessResponse:(NSDictionary*)sucessDictionary;
-(void)getCustomerDetailsErrorResponse:(NSString*)errorResponse;
// added by roja on 17/10/2019.. // at the time of converting soap to rest 
-(void)createCustomerSuccessResponse:(NSDictionary*)sucessDictionary;
-(void)createCustomerErrorResponse:(NSString*)errorResponse;

@end

@protocol GiftVoucherServicesDelegate

@optional

-(void)getGiftVoucherDetailsSuccessReponse:(NSDictionary*)sucessDictionary;
-(void)getGiftVoucherDetailsErrorResponse:(NSString*)error;


@end

@protocol GiftCouponServicesDelegate

@optional

-(void)getGiftCouponDetailsSuccessReponse:(NSDictionary*)sucessDictionary;
-(void)getGiftCouponDetailsErrorResponse:(NSString*)error;

- (void)getAllGiftCouponsMasterSuccessResponse:(NSDictionary *)successDictionary;
- (void)getAllGiftCouponsMasterErrorResponse:(NSString *)errorResponse;

- (BOOL)getAllGiftCouponsMasterSuccessResponseAndReturnSaveStatus:(NSDictionary *)successDictionary;
- (BOOL)getAllGiftCouponsMasterErrorResponseAndReturnSaveStatus:(NSString *)errorResponse;
//added by roja on 18/06/2019..
- (void)getGiftCouponsBySearchSuccessResponse:(NSDictionary *)successDictionary;
- (void)getGiftCouponsSearchErrorResponse:(NSString *)errorResponse;

- (void)issueGiftCouponsToCustomerSuccessResponse:(NSDictionary *)successDictionary;
- (void)issueGiftCouponsToCustomerErrorResponse:(NSString *)errorResponse;
//upto here added by roja on 18/06/2019..

@end

@protocol LoyaltycardServicesDelegate

@optional

-(void)getLoyaltycardDetailsSuccessReponse:(NSDictionary*)sucessDictionary;
-(void)getLoyaltycardDetailsErrorResponse:(NSString*)error;

-(void)issueLoyaltyCardSuccessReponse:(NSDictionary*)sucessDictionary;
-(void)issueLoyaltyCardErrorResponse:(NSString*)error;

-(void)getAvailableLoyaltyProgramsSuccessReponse:(NSDictionary*)sucessDictionary;
-(void)getAvailableLoyaltyProgramsErrorResponse:(NSString*)error;

-(void)updateIssuedLoyaltyCardSuccessReponse:(NSDictionary*)sucessDictionary;
-(void)updateIssuedLoyaltyCardErrorResponse:(NSString*)error;

-(void)getLoyaltycardBySearchCriteriaSuccessReponse:(NSDictionary*)sucessDictionary;
-(void)getLoyaltycardBySearchCriteriaErrorResponse:(NSString*)error;


@end


@protocol ShipmentReturnServiceDelegate

@optional
-(void)getShipmentReturnSuccessResponse:(NSDictionary *)successDictionary;
-(void)getShipmentReturnErrorResponse:(NSString *)errorResponse;

-(void)createShipmentReturnSuccessReponse:(NSDictionary *)successDictionary;
-(void)createShipmentErrorResponse:(NSString *)errorResponse;

-(void)updateShipmentReturnSuccessResponse:(NSDictionary *)successDictionary;
-(void)updateShipmentErrorResponse:(NSString *)errorResponse;

@end


@protocol OutletGRNServiceDelegate

-(void)getOutletGoodsReceiptIdsSuccessResposne:(NSDictionary *)successDictionary;
-(void)getOutletGoodsReceiptIdsErrorResponse:(NSString*)errorResponse;

@end

// Added By Bhargav.v on 1/08/2018...
@protocol DayOpenServiceDelgate

@optional
-(void)createDayOpenSummarySuccessResponse:(NSDictionary*)successDictionary;
-(void)createDayOpenSummaryErrorResponse:(NSString *)errorResponse;

-(void)getDayClosureSummarySuccessResponse:(NSDictionary*)successDictionary;
-(void)getDayClosureSummaryErrorResponse:(NSString*)errorResponse;

-(void)createDayClosureSuccessResponse:(NSDictionary*)successDictionary;
-(void)createDayClosureErrorResponse:(NSString *)errorResponse;

@end


@protocol MenuServiceDelegate

@optional
-(void)getMenuDetailsSuccessResponse:(NSDictionary *)successDictionary;
-(void)getMenuDeatilsErrorResponse:(NSString *)errorResponse;

-(void)getMenuCategoryDetailsSuccessResponse:(NSDictionary *)successDictionary;
-(void)getMenuCategoryDeatilsErrorResponse:(NSString *)errorResponse;

@end
//upto here on 26/12/2017  && 23/05/2018....


// added by roja on 09/01/2019
@protocol  BookingRestServiceDelegate
@optional
-(void)getAllBookingsSuccess:(NSDictionary*)successDictionary;
-(void)getAllBookingsFailure:(NSString *)failureString;
-(void)createBookingsSuccess:(NSDictionary*)successDictionary;
-(void)createBookingsFailure:(NSString *)failureString;
-(void)getBookingDetailsSuccess:(NSDictionary*)successDictionary;
-(void)getBookingDetailsFailure:(NSString *)failureString;
-(void)updateBookingSuccess:(NSDictionary*)successDictionary;
-(void)updateBookingFailure:(NSString *)failureString;
-(void)getPhoneNosSuccess:(NSDictionary*)successDictionary;
-(void)getPhoneNosFailure:(NSString *)failureString;

@end

// added by roja on 10/01/2019
@protocol  FBOrderServiceDelegate

@optional
-(void)getOrdersByPageSuccessRespose:(NSDictionary *)successDictionary;
-(void)getOrdersByPageErrorResponse:(NSString *)errorResponse;
@end


// added by roja on 10/01/2019
@protocol OutletServiceDelegate
@optional
-(void)getOutletDetailsSuccessResponse:(NSDictionary*)successDictionary;
-(void)getOutletDetailsFailureResponse:(NSString *)failureString;
-(void)getOutletLevelsSuccessResponse:(NSDictionary*)successDictionary;
-(void)getOutletLevelsFailureResponse:(NSString *)failureString;
@end


// added by roja on 10/01/2019......
@protocol  GetMenuServiceDelegate
@optional
-(void)getCategorySuccessResponse:(NSDictionary *)sucess;
-(void)getCategoryFailureResponse:(NSString*)failure;

-(void)getMenuItemsSuccessResponse:(NSDictionary *)sucess;
-(void)getMenuItemsFailureResponse:(NSString*)failure;
@end

@protocol KOTServiceDelegate
@optional
-(void)updateKotStatusSuccessResponse:(NSDictionary*)successDictionary;
-(void)updateKotStatusFailureResponse:(NSString *)failureString;
-(void)getItemsDetailsInKOTSuccessResponse:(NSDictionary*)successDictionary;
-(void)getItemsDetailsInKOTFailureResponse:(NSString *)failureString;
@end

@protocol GiftVoucherSrvcDelegate
@optional
-(void)getGiftVouchersSuccessResponse:(NSDictionary*)successDictionary;
-(void)getGiftVouchersFailureResponse:(NSString *)failureString;
-(void)getGiftVoucherBySearchCriteriaSuccessResponse:(NSDictionary*)successDictionary;
-(void)getGiftVoucherBySearchCriteriaFailureResponse:(NSString *)failureString;
-(void)issueGiftVoucherToCustomerSuccessResponse:(NSDictionary*)successDictionary;
-(void)issueGiftVoucherToCustomerFailureResponse:(NSString *)failureString;
@end

@protocol RoutingServiceDelegate
@optional
-(void)getRouteMastersSuccessResponse:(NSDictionary*)successDictionary;
-(void)getRouteMastersFailureResponse:(NSString *)failureString;
@end

// Protocol Related to Offline Downloads...
@protocol LoyaltyCardServcDelegate
@optional
-(BOOL)getLoyaltyCardDownloadDetailsSuccessResponse:(NSDictionary*)successDictionary;
-(BOOL)getLoyaltyCardDownloadDetailsErrorResponse:(NSString *)failureString;
-(BOOL)issueLoyaltyCardToCustomerSuccessResponse:(NSDictionary*)successDictionary;
-(BOOL)issueLoyaltyCardToCustomerErrorResponse:(NSString *)failureString;
@end

// Protocol Related to Offline Downloads...
@protocol GiftCouponServcDelegate
@optional
-(BOOL)getGiftCouponsDownloadDetailsSuccessResponse:(NSDictionary*)successDictionary;
-(BOOL)getGiftCouponsDownloadDetailsErrorResponse:(NSString *)failureString;
@end

// Protocol Related to Offline Downloads...
@protocol VoucherServiceDelegate
@optional
-(BOOL)getVoucherDownloadDetailsSuccessResponse:(NSDictionary*)successDictionary;
-(BOOL)getVoucherDownloadDetailsErrorResponse:(NSString *)failureString;
@end

@protocol CustomerLedgerService // roja on 29/07/2019...
@optional
-(void)getCustomerWalletBalanceDetailsSuccessResponse:(NSDictionary*)successDictionary;
-(void)getCustomerWalletBalanceErrorResponse:(NSString *)failureString;

-(void)createCustomerWalletSuccessResponse:(NSDictionary*)successDictionary;
-(void)createCustomerWalletErrorResponse:(NSString *)failureString;
@end

// added by roja on 06/03/2019.. && 16/04/2019...  && 10/05/2019... && 29/07/2019...


// added by roja on 17/10/2019,...
// At the time of converting SOAP call's to REST full service calls
@protocol LoginServiceDelegate
@optional
-(void)generateOTPSuccessResponse:(NSDictionary *)successDictionary;
-(void)generateOTPErrorResponse:(NSString *)errorString;

-(void)validateOTPSuccessResponse:(NSDictionary *)successDictionary;
-(void)validateOTPErrorResponse:(NSString *)errorString;

-(void)resetPasswordSuccessResponse:(NSDictionary *)successDictionary;
-(void)resetPasswordErrorResponse:(NSString *)errorString;

@end


@protocol CounterServiceDelegate
@optional

-(void)updateSyncDownloadStatusSuccessResponse:(NSDictionary *)successDictionary;
-(void)updateSyncDownloadStatusErrorResponse:(NSString *)errorString;

-(void)updateCounterSuccessResponse:(NSDictionary *)successDictionary;
-(void)updateCounterErrorResponse:(NSString *)errorString;

-(void)getCountersSuccessResponse:(NSDictionary *)successDictionary;
-(void)getCountersErrorResponse:(NSString *)errorString;

@end

// Upto here added by roja on 17/10/2019,...


//@protocol StoreStockVerificationServiceDelegate
//@optional
//
//-(void)storeStockVerificationServiceSuccessResponse:(NSDictionary*)successDictionary;
//-(void)storeStockVerificationServiceFailureResponse:(NSString *)failureString;
//
//@end





@interface WebServiceController : NSObject 
{
    id <CreateBillingDelegate> createBillingDelegate;
    id <UpdateBillingDelegate> updateBillingDelegate;
    id <GetBillsDelegate> getBillsDelegate;
    id <ReturnBillingDelegate> returningBillDelegate;
    id <ExchangeBillingDelegate> exchangingBillDelegate;
    id <SearchProductsDelegate> searchProductDelegate;
    id <GetSKUDetailsDelegate> getSkuDetailsDelegate;
    id <GetDealsAndOffersDelegate> getDealsAndOffersDelegate;
    id <SkuServiceDelegate> skuServiceDelegate;
    id <GetAllDealsDelegate> getAllDealsDelegate;
    id <GetAllOffersDelegate> getAllOffersDelegate;
    id <GetStockDetailsbyFilter> getStockDetailsByFilterDelegate;
    id <GetStockLedgerReport> getStockLedgerReportDelegate;
    id <GetScrapStockDelegate> getScrapStockDelegate;
    id <SearchDealsDelegate> searchDealsDelegate;
    id <ProductGroupMasterServiceDelegate> productGroupMasterDelegate;
    id <EmployeeServiceDelegate> employeeServiceDelegate;
    id <CustomerWalkOutDelegate>customerWalkoutDelegate;
    id <OutletMasterDelegate>outletMasterDelegate;
    id <StockRequestDelegate>getStockRequestDelegate;
    id <utilityMasterServiceDelegate>utilityMasterDelegate;
    id <GetMessageBoardDelegate> getMessageBoardDelegate;
    id <sizeAndColorsDelegate>getSizeAndColorsDelegate;
    id <StockIssueDelegate>stockIssueDelegate;
    id <StockReceiptServiceDelegate>stockReceiptDelegate;
    id<StockReturnServiceDelegate>stockReturnDelegate;
    
    id<DenominationMasterDelegate>DenominationDelegate;
    id<GetProductsByCategoryDelegate>getCategoriesDelegate;
    
    id<ProductMasterSvcDelegate>productMasterDelegate;
    id<StockVerificationSvcDelegate>stockVerificationDelegate;
    id<BomMasterSvcDelegate>bomMasterSvcDelegate;
    
    id<WarehouseGoodsReceipNoteServiceDelegate> warehouseGoodsReceipNoteServiceDelegate;
    
    id <SupplierServiceSvcDelegate> supplierServcieSvcDelegate;
    id <PurchaseOrderSvcDelegate> purchaseOrderSvcDelegate;
    //modified By Prabhu
    
    id<GetStockMovementDelegate>stockMovementDelegate;
    
    
    //added by Srinivasulu on 10/05/2017....
    
    id<ZoneMasterDelegate> zoneMasterDelegate;
    id<GetOrderDelegate> getOrderDelegate;
    
    //upto here on 10/05/2017....
    
    //added by Bhargav on 26/05/2017 && 26/03/2018 && 09/05/2018....
    
    id<ModelMasterDelegate>modelMasterDelegate;
    id <OutletOrderServiceDelegate>outletOrderServiceDelegate;
    
    id<StoreServiceDelegate>storeServiceDelegate;

    id<DayOpenServiceDelgate>dayOpenServiceDelegate;

    //upto here on 26/05/2017 && 26/03/2018 && 09/05/2018....
    
    //added By Bhargav on 25/5/2017....
    
    id<StoreStockVerificationDelegate>storeStockVerificationDelegate;
    
    id<OffersMasterDelegate>offerMasterDelegate;
    
    //upto here on 31/05/2017....
    
    //added by Srinivasulu on 03/07/2017 && 26/12/2017 && 29/12/2017 && 23/05/2018 && 29/08/2018 && 10/09/2018....
    
    id<StoreTaxationDelegate> storeTaxationDelegate;
    id<CustomerServiceDelegate> customerServiceDelegate;
    id<GiftVoucherServicesDelegate> giftVoucherServicesDelegate;
    id<GiftCouponServicesDelegate> giftCouponServicesDelegate;
    id<LoyaltycardServicesDelegate> loyaltycardServicesDelegate;
    
    id<MenuServiceDelegate> menuServiceDelegate;
    id<AppSettingServicesDelegate> appSettingServicesDelegate;
    id<MemberServiceDelegate> memberServiceDelegate;
    id<RoleServiceDelegate> roleServiceDelegate;
    //upto here on 03/07/2017 && 26/12/2017 && 29/12/2017 && 23/05/2018 && 29/08/2018  && 10/09/2018....
    
    //added By Bhargav.v on 03/08/2017
    
    id<RolesServiceDelegate>rolesServiceDelegate;
    
    //upto here on 03/08/2017....
    
    //Added By Bhargav.v on 10/08/2017 && 10/08/2017.......
    
    id<SalesServiceDelegate>salesServiceDelegate;
    
    //Added By Bhargav.v on 8/12/2017..
    
    id<ShipmentReturnServiceDelegate>shipmentReturnDelegate;
    
    
    id<OutletGRNServiceDelegate>outletGRNServiceDelegate;
    //up to here on 11/12/2017
    
    //upto here on 10/08/2017....
    
    // added by roja on 09/01/2019
    
    id<BookingRestServiceDelegate>restaurantBookingServiceDelegate;
    id<FBOrderServiceDelegate>fbOrderServiceDelegate;
    id<OutletServiceDelegate>outletServiceDelegate;
    id <GetMenuServiceDelegate>getMenuServiceDelegate;
    id<KOTServiceDelegate>kotServiceDelegate;
    id<GiftVoucherSrvcDelegate>giftVoucherSrvcDelegate;
    id<RoutingServiceDelegate> routingServiceDelegate;
//    id<StoreStockVerificationServiceDelegate>storeStockVerificationServiceDelegate;

    // related to Offline downloads
    id<LoyaltyCardServcDelegate> loyaltyCardServcDelegate;
    id<GiftCouponServcDelegate> giftCouponServcDelegate;

    //upto here added by roja on  09/01/2019.. && 10/05/2019..
    
    
}

@property (nonatomic, strong) id <CreateBillingDelegate> createBillingDelegate;
@property (nonatomic, strong) id <UpdateBillingDelegate> updateBillingDelegate;
@property (nonatomic, strong) id <GetBillsDelegate> getBillsDelegate;
@property (nonatomic, strong) id <ReturnBillingDelegate> returningBillDelegate;
@property (nonatomic, strong) id <ExchangeBillingDelegate> exchangingBillDelegate;
@property (nonatomic, strong) id <SearchProductsDelegate> searchProductDelegate;
@property (nonatomic, strong) id <GetSKUDetailsDelegate> getSkuDetailsDelegate;
@property (nonatomic, strong) id <GetDealsAndOffersDelegate> getDealsAndOffersDelegate;
@property (nonatomic, strong) id <SkuServiceDelegate> skuServiceDelegate;
@property (nonatomic, strong) id <GetAllDealsDelegate> getAllDealsDelegate;
@property (nonatomic, strong) id <GetAllOffersDelegate> getAllOffersDelegate;
@property (nonatomic, strong) id <GetStockDetailsbyFilter> getStockDetailsByFilterDelegate;
@property (nonatomic, strong) id <GetStockLedgerReport> getStockLedgerReportDelegate;
@property (nonatomic, strong) id <GetScrapStockDelegate> getScrapStockDelegate;
@property (nonatomic, strong) id <SearchDealsDelegate> searchDealsDelegate;
@property (nonatomic, strong) id <ProductGroupMasterServiceDelegate> productGroupMasterDelegate;
@property (nonatomic, strong) id <EmployeeServiceDelegate> employeeServiceDelegate;
@property (nonatomic, strong) id <CustomerWalkOutDelegate> customerWalkoutDelegate;
@property (nonatomic, strong) id <OutletMasterDelegate> outletMasterDelegate;
@property (nonatomic, strong) id <StockRequestDelegate>stockRequestDelegate;
@property (nonatomic, strong) id <utilityMasterServiceDelegate>utilityMasterDelegate;
@property (nonatomic, strong) id <GetMessageBoardDelegate> getMessageBoardDelegate;
@property (nonatomic, strong) id <sizeAndColorsDelegate>getSizeAndColorsDelegate;
@property (nonatomic, strong) id <StockIssueDelegate>stockIssueDelegate;
@property (nonatomic, strong) id <StockReceiptServiceDelegate>stockReceiptDelegate;
@property (nonatomic, strong) id <StockReturnServiceDelegate>stockReturnDelegate;
@property (nonatomic, strong) id <DenominationMasterDelegate>DenominationDelegate;
@property (nonatomic, strong) id<GetProductsByCategoryDelegate>getCategoriesDelegate;
@property (nonatomic, strong) id<ProductMasterSvcDelegate>productMasterDelegate;
@property (nonatomic, strong) id<StockVerificationSvcDelegate>stockVerificationDelegate;
@property (nonatomic, strong) id<BomMasterSvcDelegate>bomMasterSvcDelegate;
@property ( nonatomic, strong) id <WarehouseGoodsReceipNoteServiceDelegate> warehouseGoodsReceipNoteServiceDelegate;
@property (nonatomic, strong) id <SupplierServiceSvcDelegate> supplierServiceSvcDelegate;
@property (nonatomic, strong) id <PurchaseOrderSvcDelegate> purchaseOrderSvcDelegate;
@property (nonatomic, strong) id <GetStockMovementDelegate>stockMovementDelegate;

//added by Srinivasulu on 10/05/2017 &&  03/07/2017 && 26/12/2017 && 23/05/2018 && 29/08/2018 && 10/09/2018....customerServiceDelegate

@property (nonatomic, strong) id <ZoneMasterDelegate> zoneMasterDelegate;
@property (nonatomic,strong)  id<StoreTaxationDelegate> storeTaxationDelegate;
@property (nonatomic, strong) id <CustomerServiceDelegate> customerServiceDelegate;
@property (nonatomic, strong) id <GiftVoucherServicesDelegate> giftVoucherServicesDelegate;
@property (nonatomic, strong) id <GiftCouponServicesDelegate> giftCouponServicesDelegate;
@property (nonatomic, strong) id <LoyaltycardServicesDelegate> loyaltycardServicesDelegate;
@property (nonatomic, strong) id <GetOrderDelegate> getOrderDelegate;

@property (nonatomic, strong) id <MenuServiceDelegate> menuServiceDelegate;
@property (nonatomic, strong) id <AppSettingServicesDelegate> appSettingServicesDelegate;
@property (nonatomic, strong) id <MemberServiceDelegate> memberServiceDelegate;
@property (nonatomic, strong) id <RoleServiceDelegate> roleServiceDelegate;

//upto here on 10/05/2017 && 03/07/2017 && 26/12/2017 && 29/12/2017 && 23/05/2018 && 29/08/2018 && 10/09/2018....

//added by Bhargav on 26/05/2017 && 26/03/2018 && 09/05/2018....

@property (nonatomic, strong) id <ModelMasterDelegate> modelMasterDelegate;
@property (nonatomic,strong) id <OutletOrderServiceDelegate>outletOrderServiceDelegate;

@property (nonatomic,strong) id<StoreServiceDelegate>storeServiceDelegate;

@property(nonatomic,strong) id<DayOpenServiceDelgate>dayOpenServiceDelegate;

//upto here on 26/05/2017 && 26/03/2018 && 09/05/2018....

//added By Bhargav on 25/5/2017...

@property (nonatomic,strong)  id<StoreStockVerificationDelegate>storeStockVerificationDelegate;
@property (nonatomic,strong) id<OffersMasterDelegate>offerMasterDelegate;

//upto here on 25/05/2017....



//added By Bhargav.v on 03/08/2017

@property (nonatomic,strong)  id<RolesServiceDelegate>rolesServiceDelegate;

//up to here Bhargav.v on 03/08/2017



//Added By Bhargav.v on 10/08/2017...

@property (nonatomic,strong) id<SalesServiceDelegate>salesServiceDelegate;
@property (nonatomic,strong) id<ShipmentReturnServiceDelegate>shipmentReturnDelegate;
@property (nonatomic,strong) id<OutletGRNServiceDelegate>outletGRNServiceDelegate;

//upto here on 10/08/2017....

//Added By roja on 09/01/2019....
@property (nonatomic,strong) id<BookingRestServiceDelegate>restaurantBookingServiceDelegate;
@property (nonatomic,strong) id<FBOrderServiceDelegate>fbOrderServiceDelegate;
@property (nonatomic,strong) id<OutletServiceDelegate>outletServiceDelegate;
@property (nonatomic,strong) id <GetMenuServiceDelegate>getMenuServiceDelegate;
@property(nonatomic,strong)   id<KOTServiceDelegate>kotServiceDelegate;
@property (nonatomic, strong) id <GiftVoucherSrvcDelegate>giftVoucherSrvcDelegate;
// related to Order Management flow(Edit Order)
@property (nonatomic, strong) id <RoutingServiceDelegate> routingServiceDelegate;
// related to Offline Download's
@property (nonatomic, strong) id <LoyaltyCardServcDelegate> loyaltyCardServcDelegate;
@property (nonatomic, strong) id <GiftCouponServcDelegate> giftCouponServcDelegate;
@property (nonatomic, strong) id <VoucherServiceDelegate> voucherServiceDelegate;
@property (nonatomic, strong) id <CustomerLedgerService> customerLedgerService; //roja on 29/07/2019
// related to Edit Stock Verfication Flow
//@property (nonatomic, strong) id<StoreStockVerificationServiceDelegate>storeStockVerificationServiceDelegate;
// added by roja on 09/01/2019.... && on 06/03/2019... 03/04/2019... 29/07/2019...


// added by roja on 17/10/2019...
// At the time of converting SOAP to REST full service call
@property (nonatomic, strong) id <LoginServiceDelegate> loginServiceDelegate; //roja on 29/07/2019
@property (nonatomic, strong) id <CounterServiceDelegate> counterServiceDelegate; //roja on 29/07/2019


-(void)createBillWithData:(NSData *)requestString;
-(void)updateBillWithData:(NSData *)requestString;
-(void)getBills:(int)startIndex deliveryType:(NSString *)deliveryType status:(NSString *)status;
-(void)getBillIds:(int)startIndex deliveryType:(NSString *)deliveryType status:(NSString *)status searchCriteria:(NSString*)searchCriteria;
-(void)getBillDetails:(NSString *)billId;
-(void)returnBillWithData:(NSString *)requestString;
-(void)searchProductsWithData:(NSString *)requestString;
-(void)getSkuDetailsWithData:(NSString *)requestString;
-(void)getDealsAndOffersWithData:(NSString *)requestString;
-(BOOL)getSkuDetails:(NSString*)requestParam;
-(BOOL)getPriceList:(NSString*)requestParam;
-(void)exchangeBillWithData:(NSString *)requestString;
-(void)getAllDealsWithData:(NSString *)requestString;
-(void)getStockDetailsByFilter:(NSString *)requestString ;
-(void)getStockLedgerReport:(NSString *)requestString ;
-(void)getScrapStockDetails:(NSString *)requestString ;
-(BOOL)getSkuEans:(NSString *)requestParam;
-(void)searchDealsWithData:(NSString *)requestString;
-(void)getProductGroupMaster:(NSString *)requestParam;
-(BOOL)getEmployeeMaster:(NSString *)requestParam;
-(void)createCustomerWalkOutWithData:(NSData *)requestData;
-(void)getCustomerWalkout:(NSString *)requestStirng;
-(void)getProductCategory:(NSString *)requestStirng;
-(void)getDepartmentList:(NSString *)requestStirng;
-(void)getBrandList:(NSString *)requestStirng;
-(void)searchBills:(NSString *)requestString;
-(void)getAllStockRequest:(NSString *)requestString;
-(void)createStockRequest:(NSString *)requestString;
-(void)updateStockRequest:(NSData *)requestData;
-(void)getAllLocationDetailsData:(NSString *)requestStirng;
- (void)getMessageBoardDetails:(NSString *)requestString ;
-(void)getSizeAndColors:(NSString *)requestString;

-(BOOL)getAllDealsWithDataThroughSynchronousRequest:(NSString *)requestString;

//stock Issue

-(void)createStockIssue:(NSString *)requestString;
-(void)getStockIssue:(NSString *)requestString;
-(void)getStockIssueId:(NSString *)requestString;
-(void)getStockIssueIdSearchCritera:(NSString *)requestring;
-(void)upDateStockIssue:(NSData *)reqData;
-(void)stockIssueIds:(NSString *)requestString;
//stockReceipt:

-(void)getStockReceipts:(NSString*)requestString;
-(void)createStockReceipt:(NSData*)requestData;
-(void)getStockReceiptDetails:(NSString *)requestString;
-(void)updateStockReceipt:(NSData *)requestData;

//Stock Return:

-(void)getStockReturn:(NSString*)requestString;
-(void)createStockReturn:(NSData *)requestData;
-(void)upDateStockReturn:(NSData*)requestData;


-(void)getWarehouseIssueIds:(NSString*)requestString;
-(void)getWarehouseIssueDetails:(NSString*)requestString;
-(void)getStockReceiptIds:(NSString*)requestString;
-(void)getStockIssueId:(NSString *)requestString;
-(void)getStockIssueDetails:(NSString*)requestString;

-(BOOL)getdenominations:(NSString*)requestString;
//getProductsByCategories

-(void)getProductsByCategory:(NSString *)requestString;

//Utility Master Service
-(BOOL)getProductCategories:(NSString *)requestString;
-(BOOL)getProductSubCategories:(NSString*)requestString;

//ProductMasterServices

-(BOOL)getProducts:(NSString*)requestString;

-(void)getStockVericationSummaryDetails:(NSString*)requestString;

-(void)getSuppliesReport:(NSString*)requestString;
-(void)getMaterialConsumption:(NSString *)requestString;


-(void)createWarehouseGoodsReceiptNote:(NSString *)requestString;


-(void)updateWarehouseGoodsReceiptNote:(NSString *)requestString;

//added on 31/10/2016
-(void)getAllWarehouseGoodsReceiptNotes:(NSString *)requestString;

-(void)getWarehouseGoodsReceiptNoteWithDetails:(NSString *)requestString;
-(void)getWarehouseGoodsReceiptNoteWithDetailsWithSynchronousRequest:(NSString *)requestString;


-(void)getWarehouseGoodsReceiptNoteSummaryData:(NSString *)requestString;

-(void)getWarehouseGoodsReceiptNoteSummaryDataWithSynchronousRequest:(NSString *)requestString;

-(void)generateGRNs:(NSString *)requestString;
-(void)getSupplierDetailsData:(NSString *)requestString;
-(void)getAllPurchaseOrdersRefIds:(NSString *)requestString;


-(void)getAllPurchaseOrdersDetailsData:(NSString *)requestString;

-(void)warehouseSearchProducts:(NSString*)requestString;
-(void)getWarehouseSkuDetailsWithData:(NSString *)requestString;
-(void)getPurchaseOrderDetails:(NSString *)requestString;
-(void)getStockRequestIDs:(NSString *)requestString;
-(void)getStockMovementDetails:(NSString *)requestString;


//added by Srinivasulu on 10/05/2017....

-(void)getZoneIdsRequest:(NSString *)requestString;

//upto here on 10/05/2017....





//added by Bhargav on 24/05/2017....

-(void)getModelDetails:(NSString *)requestString;

//upto here on 24/05/2017....

-(BOOL)getPriceListThroughAsynchronousCall:(NSString *)requestParam;

//added on 29/05/2017...

-(void)getStockRequestSummaryInfo:(NSString*)requestString;








#pragma - mark method used under the StoreStockVerificationDelegate....

//added on 31/05/2017 by Bhargav.v...

-(void)getStockVerificationMasterDetails:(NSString *)requestString;

-(void)getProductVerification:(NSString * )requestString;

//-(void)getStockVerificationDetails:(NSString *)requestString;

//-(void)createStockVerification:(NSString*)requestString; // commented by roja on 17/10/2019...

//-(void)getproductVerificationDetails:(NSString *)requestString; // commented by roja on 17/10/2019...

-(void)upDateStockVerification:(NSString *)requestString;

//upto Here....

#pragma -mark method used under storeTaxationDelegate....

-(BOOL)getStoreTaxesInDetail:(NSString *)requestString;
-(BOOL)getStoreTaxesInDetailThroughSoapServiceCall:(NSString *)requestString;



// added by Bhargav.v on 14/06/2017....

-(void)doWriteOfStockVerification:(NSString *)requestString;
-(void)getStockVerificationMasterChildDetails:(NSString *)requestString;
-(void)getPriceListSkuDetails:(NSString *)requestString;


//Upto Here on 14/06/2017....

// Added By Bhargav on 03/08/2017....
// Roles Service

-(void)getWorkFlows:(NSString*)requestString;

//SalesService
//Added By Bhargav.v on 10/08/2017 && 14/05/2018....

-(void)getHourWiseReports:(NSString*)requestString;

//SkuService
-(void)getProductClass:(NSString*)requestString;

-(void)getVoidItemsReport:(NSString*)requestString;

-(void)getOverrideSales:(NSString *)requestString;

-(void)getSalesMenCommission:(NSString*)requestString;

-(void)getTrackerItemsDetails:(NSString *)requestString;

//upto Here...


//Added By Bharagv.v on 28/11/2017 &&  20/12/2017....

-(void)getDailyStockReport:(NSString *)requestString;

-(void)getCategoriesByLocation:(NSString *)requesString;

-(void)getBrandsByLocation:(NSString *)requestString;

//up to here on 20/12/2017 &&  20/12/2017....


//upto here..

//added by Srinivasulu 10/10/2017....
//reason we need to create the customer walkins....

-(void)createNewCustomerWalkinsInfo:(NSString *)requestString;

//upto here pm 10/10/2017....

//added by Srinivasulu on 26/12/2017....
#pragma -mark strat methods used under CustomerServiceDelegate..

-(void)generateCustomerOtp:(NSString *)requestString;
-(void)validateCustomerOtp:(NSString *)requestString;

-(BOOL)getCustomerListThroughSynchronousRequest:(NSString *)requestString;
-(void)getCustomerListThroughAsynchronousRequest:(NSString *)requestString;

-(BOOL)updateCustomerDetailsThroughSynchronousRequest:(NSString *)requestString;
-(void)updateCustomerDetailsAsynchronousRequest:(NSString *)requestString;

-(void)generateBuildOTP:(NSString *)requestString;
-(void)validateBuildOTP:(NSString *)requestString;

#pragma -mark strat methods used under memberServiceDelegate..

-(BOOL)getAllMembersDetailsThroughSynchronousRequest:(NSString *)requestString;
-(void)getAllMembersDetailsAsynchronousRequest:(NSString *)requestString;

-(BOOL)getAllMemberShipUsersThroughSynchronousRequest:(NSString *)requestString;
-(void)getAllMemberShipUsersAsynchronousRequest:(NSString *)requestString;
#pragma -mark strat methods used under RoleServiceDelegate..

-(BOOL)getAllRolesDetailsThroughSynchronousRequest:(NSString *)requestString;
-(void)getAllRolesDetailsAsynchronousRequest:(NSString *)requestString;

#pragma -mark strat methods used under GiftVoucherServicesDelegate..

-(void)getGiftVoucherDetails:(NSString *)requestString;

#pragma -mark strat methods used under  GiftCouponServicesDelegate

-(void)getGiftCouponDetails:(NSString *)requestString;
-(BOOL)getAllGiftCouponsMasterThroughSynchronousRequest:(NSString *)requestString;
-(void)getAllGiftCouponsMasterAsynchronousRequest:(NSString *)requestString;

#pragma -mark strat methods used under  LoyaltycardServicesDelegate

-(void)getLoyaltycardDetails:(NSString *)requestString;

//upto here on 10/05/2017 && 03/07/2017 && 26/12/2017....




//Added By Bhargav.v on 11/12/2017
-(void)getOutletGrnReceiptIDs:(NSString *)requestString;
//up to here on 20/12/2017...


//Added By Bhargav.v on 08/12/2017....

-(void)getShipmentReturn:(NSString *)requestString;

-(void)createShipmentReturn:(NSString *)requestString;

-(void)updateShipmentReturn:(NSString *)requestString;

//upto Here on 08/12/2017...


-(void)getDuplicateBillDetails:(NSString *)billId;

-(void)getAllOrders:(NSString *)requestString;


-(void)getOffersDetails:(NSString *)requestString;

// Methods Under Order Management....
// outletOrderServiceDelegate...
// Added By Bhargav.v on 26/02/2018...

-(void)getOutletOrders:(NSString *)requestString;

-(void)getOutleOrderDetails:(NSString*)requestString;
-(void)createOutletOrder:(NSString *)requestString;

-(void)updateOutletOrder:(NSString *)requestString;
//Added on 28/03/2018...
-(void)getStores:(NSString*)requestString;

-(void)getCustomerPurchases:(NSString *)requestString;


//getMenuDetailsSuccessResponse --  getMenuCategoryDetailsSuccessResponse
-(void)getMenuDetailsInfo:(NSString *)requestString;
-(void)getMenuCategoryDetailsInfo:(NSString *)requestString;

-(BOOL)getMenuDetailsInfoThroughSynchronousRequest:(NSString *)requestString;
-(BOOL)getMenuCategoryDetailsInfoThroughSynchronousRequest:(NSString *)requestString;

-(void)getSKUStockInformation:(NSString *)requestString;

-(BOOL)getAllOffersWithDataThroughSoapSynchronousRequest:(NSString *)requestString;
-(BOOL)getAllOffersWithDataThroughSynchronousRequest:(NSString *)requestString;


//Added By Bhargav.v on 09/05/2018....
-(void)createDayOpenSummary:(NSString*)requestString;
-(void)getDayClosureSummary:(NSString*)requestString;
-(void)createDayClosure:(NSString*)requestString;



//added by roja on 09/01/2019....
-(void)createRestBooking:(NSString*)requestString;
-(void)getCustomerDetails:(NSString *)requestString;
-(void)getPhoneNos:(NSString *)requestString;
-(void)getRestBookingDetails:(NSString*)requestString;
-(void)getOrdersByPage:(NSString *)requestString;
-(void)getListOfBookings:(NSString*)requestString;
-(void)getTheAvailableLevelsWithRestFullService:(NSString *)requestString;
-(void)getLayoutDetails:(NSString*)requestString;
-(void)updateRestBooking:(NSString *)requestString;


-(void)updateKotStatus:(NSString *)requestString;

-(void)getMenuItemsWithRestFullServiceSynchrousRequest:(NSString *)requestString;
-(void)getMenuCategoriesWithRestFullServiceSynchrousRequest:(NSString *)requestString;

-(void)getItemDetailsInKOT:(NSString *)requestString;

// added by roja on 05/03/2019...
-(void)getAvailableGiftCouponDetails:(NSString *)requestString;

-(void)getAvailableGiftVouchers:(NSString *)requestString;
-(void)getGiftVouchersBySearchCriteria:(NSString *)requestString;
-(void)issueGiftVoucherToCustomer:(NSString *)requestString;
-(void)getGiftCouponsBySearchCriteria:(NSString *)requestString;
-(void)issueGiftCouponToCustomer:(NSString *)requestString;
-(void)getAvailableTables:(NSString *)requestString;
-(void)getCustomerEatingHabits:(NSString *)requestString;
-(void)getProductVerificationRestFullService:(NSString *)requestString;
-(void)createStockVerificationRestFullService:(NSString *)requestString;
-(void)upDateStockVerificationRestFullService:(NSString *)requestString;
-(void)getRouteMasters:(NSString *)requestString;

//below methods related to offline downloads..
-(BOOL)getLoyaltyCardDownloadsDetails:(NSString *)requestString;
-(BOOL)issueLoyaltyCardToCustomer:(NSString *)requestString;
-(BOOL)getGiftCouponsDownloadsDetails:(NSString *)requestString;
-(BOOL)getVoucherDownloadsDetails:(NSString *)requestString;

-(void)getCustomerWalletBalanceDetails:(NSString *)requestString; // 29/07/2019...
-(void)createOrUpdateCustomerWalletServices:(NSString *)requestString; // 29/07/2019...

// added by roja on  05/03/2019 && 27/03/2019 && 05/05/2019 && 29/07/2019......

// added by sai prashanth
-(void)getEmployeeDetails:(NSString *)requestString;
// added by sai prashanth

// Added by roja on 17/10/2019....
// At the time of converting SOAP call's to REST
-(void)authenticateUserForLogIn:(NSString *)requestString;
-(void)getAppSettings:(NSString *)requestString;
-(void)changePassword:(NSString *)requestString;
-(void)userRegistration:(NSString *)requestString;
-(void)generateLoginOTP:(NSString *)requestString;
-(void)validateForLoginOTP:(NSString *)requestString;
-(void)resetPassword:(NSString *)requestString;
-(void)createCustomer:(NSString *)requestString;
//-(void)updateCustomerDetailsSynchronously:(NSString *)requestString;
-(void)getStockProcurementReceipt:(NSString *)requestString;
-(void)getStockProcurementReceiptsCall:(NSString *)requestString;
-(void)getStockProcurementReceiptIDS:(NSString *)requestString;
-(void)createNewStockProcurementReceipt:(NSString *)requestString;
-(void)issueLoyaltyCard:(NSString *)requestString;
-(void)getAvailableLoyaltyPrograms:(NSString *)requestString;
-(void)updateIssuedLoyaltyCard:(NSString *)requestString;
-(void)createPurchaseOrder:(NSString *)requestString;
-(void)getPurchaseOrders:(NSString *)requestString;
-(void)getPurchaseOrderDetailsInOutlet:(NSString *)requestString;
-(void)updatePurchaseOrder:(NSString *)requestString;
-(void)getStoreLocation:(NSString *)requestString;
-(void)getStoreUnit:(NSString *)requestString;
-(void)updateSyncDownloadStatus:(NSString *)requestString;
-(void)updateCounter:(NSString *)requestString;
-(void)getCounters:(NSString *)requestString;
-(BOOL)getTaxes:(NSString *)requestString;
-(void)getSalesReport:(NSString *)requestString;
-(void)getReturningItem:(NSString *)requestStirng;
-(void)getBillingDetails:(NSString *)requestString;
-(void)getXZReports:(NSString *)requestString;
-(BOOL)getAllOffersWithData:(NSString *)requestString;
-(void)getLoyaltyCardsBySearch:(NSString *)requestString;

    //Upto here Added by roja on 17/10/2019....

@end
