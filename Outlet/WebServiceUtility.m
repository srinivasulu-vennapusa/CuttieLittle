// 
//  WebServiceUtility.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 9/2/15.
//
//

#import "WebServiceUtility.h"
#import "WebServiceConstants.h"
#import "Global.h"
#import "GDataXMLNode.h"
#import "DealModel.h"
#import "DealRangesModel.h"

@implementation WebServiceUtility


+ (NSString *)getURLFor:(int)type {
    
    NSMutableString *serviceUrl = [[NSMutableString alloc] initWithString:[self getServiceURL]];
    
    switch (type) {
        case CREATE_BILLING:
            [serviceUrl appendString:CREATE_BILLING_PARAM];
            break;
        case UPDATE_BILLING:
            [serviceUrl appendString:UPDATE_BILLING_PARAM];
            break;
        case RETURN_BILLING:
            [serviceUrl appendString:RETURN_BILLING_PARAM];
            break;
        case SEARCH_PRODUCTS:
            [serviceUrl appendString:SEARCH_PRODUCTS_PARAM];
            break;
        case GET_SKU_DETAILS:
            [serviceUrl appendString:GET_SKU_DETAILS_PARAM];
            break;
        case GET_DEALS_AND_OFFERS:
            [serviceUrl appendString:GET_DEALS_AND_OFFERS_PARAM];
            break;
        case GET_BILL_ID:
            [serviceUrl appendString:GET_BILL_IDS_PARAM];
            break;
        case GET_BILL_DETAILS:
            [serviceUrl appendString:GET_BILL_DETAILS_PARAM];
            break;
        case GET_PRICE_LIST:
            [serviceUrl appendString:GET_PRICE_LIST_PARAM];
            break;
        case GET_BILLS:
            [serviceUrl appendString:GET_BILLS_PARAM];
            break;
        case Exchange_BILLING:
            [serviceUrl appendString:EXCHANGE_BILLING_PARAM];
            break;
        case GET_ALL_DEALS:
            [serviceUrl appendString:GET_ALL_DEALS_PARAM];
            break;
        case GET_STOCK_DETAILS_BY_FILTER:
            [serviceUrl appendString:GET_STOCK_DETAILS_BY_FILTER_PARAM];
            break;
        case GET_STOCK_LEDGER_REPORT:
            [serviceUrl appendString:GET_STOCK_LEDGER_REPORT_PARAM];
            break;
        case GET_VERIFIED_STOCK_REPORT:
            [serviceUrl appendString:GET_STOCK_VERIFIED_REPORT_PARAM];
            break;
        case GET_SCRAP_STOCK_DETAILS:
            [serviceUrl appendString:GET_SCRAP_STOCK_DEATILS_PARAM];
            break;
        case GET_SKU_EANS:
            [serviceUrl appendString:GET_SKU_EANS_PARAM];
            break;
        case SEARCH_DEALS:
            [serviceUrl appendString:SEARCH_DEALS_PARAM];
            break;
        case GET_PRODUCT_GROUPS:
            [serviceUrl appendString:GET_PRODUCT_GROUPS_PARAM];
            break;
        case GET_CREDIT_NOTE:
            [serviceUrl appendString:GET_CREDIT_NOTE_PARAM];
            break;
        case APPLY_CAMPAIGNS:
            [serviceUrl appendString:APPLY_CAMPAIGNS_PARAM];
            break;
        case CREATE_BILLING_WITH_BODY:
            [serviceUrl appendString:CREATE_BILLING_WITH_BODY_PARAM];
            break;
        case GET_GROUP_ITEMS:
            [serviceUrl appendString:GET_PRODUCT_GROUP_ITEMS_PARAM];
            break;
        case UPDATE_BILLING_WITH_BODY:
            [serviceUrl appendString:UPDATE_BILLING_WITH_BODY_PARAM];
            break;
            
        case CREATE_CUSTOMER_WALKOUT:
            [serviceUrl appendString:CREATE_CUSTOMER_WALKOUT_PARAM];
            break;
            
        case GET_CUSTOMER_WALKOUT:
            [serviceUrl appendString:GET_CUSTOMER_WALKOUT_PARAM];
            break;
            
        case SEARCH_BILLS:
            [serviceUrl appendString:SEARCH_BILLS_PARAM];
            break;
            
        case GET_VERIFICATION_CODE:
            [serviceUrl appendString:GET_VERIFICATION_CODE_PARAM];
            break;
        case STOCK_WRITE_OFF:
            [serviceUrl appendString:STOCK_WRITE_OFF_PARAM];
            break;
        case CLOSE_STOCK_VERIFICATION:
            [serviceUrl appendString:CLOSE_STOCK_VERIFICATION_PARAM];
            break;
        case SEARCH_VERIFICATION_ITEMS:
            [serviceUrl appendString:SEARCH_VERIFICATION_ITEMS_PARAM];
            break;
            
        case GET_STOCK_REQUESTS:
            [serviceUrl appendString:GET_STOCK_REQUESTS_PARAM];
            break;
            
        case CREATE_STOCK_REQUEST:
            [serviceUrl appendString:CREATE_STOCK_REQUEST_PARAM];
            break;
            
        case UPDATE_STOCK_REQUEST:
            [serviceUrl appendString:UPDATE_STOCK_REQUEST_PARAM];
            break;
        case GET_MESSAGE_BOARD_DETAILS:
            [serviceUrl appendString:GET_MESSAGE_BOARD_DETAILS_PARAM];
            break;
        case GET_SIZE_AND_COLORS:
            [serviceUrl appendString:GET_SIZE_AND_COLORS_PARAM];
            break;
            
        case CREATE_STOCK_ISSUE:
            [serviceUrl appendString:CREATE_STOCK_ISSUE_PARAM];
            break;
            
        case GET_STOCK_ISSUE:
            [serviceUrl appendString:GET_STOCK_ISSUE_PARAM];
            break;
            
        case GET_STOCK_ISSUES:
            [serviceUrl appendString:GET_STOCK_ISSUES_PARAM];
            break;
            
        case UPDATE_STOCK_ISSUE:
            [serviceUrl appendString:UPDATE_STOCK_ISSUE_PARAM];
            break;
            
        case GET_STOCK_ISSUE_SEARCH_CRITERIA:
            [serviceUrl appendString:GET_STOCK_ISSUE_SEARCH_CRITERIA_PARAM];
            break;
            
        case GET_STOCK_RECEIPT:
            [serviceUrl appendString:GET_STOCK_RECEIPT_PARAM];
            break;
            
        case GET_STOCK_ISSUE_ID:
            [serviceUrl appendString:GET_STOCK_ISSUE_ID_PARAM];
            break;
        case CREATE_STOCK_RECEIPT:
            [serviceUrl appendString:CREATE_STOCK_RECEIPT_PARAM];
            break;
            
        case GET_STOCK_RECEIPT_DETAILS:
            [serviceUrl appendString:GET_STOCK_RECEIPT_DETAILS_PARAM];
            break;
            
        case UPDATE_STOCK_RECEIPT:
            [serviceUrl appendString:UPDATE_STOCK_RECEIPT_PARAM];
            break;
        case GET_STOCK_RETURN:
            [serviceUrl appendString:GET_STOCK_RETURN_PARAM];
            break;
            
        case CREATE_STOCK_RETURN:
            [serviceUrl appendString:CREATE_STOCK_RETURN_PARAM];
            break;
        case UPDATE_STOCK_RETURN:
            [serviceUrl appendString:UPDATE_STOCK_RETURN_PARAM];
            break;
        case GET_WAREHOUSE_ISSUEIDS:
            [serviceUrl appendString:GET_WAREHOUSE_ISSUEIDS_PARAM];
            break;
        case GET_WAREHOUSE_ISSUE_DETAILS:
            [serviceUrl appendString:GET_WAREHOUSE_ISSUE_DETAILS_PARAM];
            break;
        case GET_STOCK_RECEIPT_IDS:
            [serviceUrl appendString:GET_STOCK_RECEIPT_IDS_PARAM];
            break;
        case GET_STOCK_ISSUE_DETAILS:
            [serviceUrl appendString:GET_STOCK_ISSUE_DETAILS_PARAM];
            break;
        case GET_DENOMINATIONS:
            [serviceUrl appendString:GET_DENOMINATIONS_PARAM];
            break;
        case GET_PRODUCTS_BY_CATEGORY:
            [serviceUrl appendString:GET_PRODUCTS_BY_CATEGORY_PARAM];
            break;
        case GET_STOCK_VERIFICATION_SUMMARY:
            [serviceUrl appendString:GET_STOCK_VERIFICATION_SUMMARY_PARAM];
            break;
        case GET_SUPPLIES_REPORT:
            [serviceUrl appendString:GET_SUPPLIES_REPORT_PARAM];
            break;
        case GET_MATERIAL_CONSUMPTION:
            [serviceUrl appendString:GET_MATERIAL_CONSUMPTION_PARAM];
            break;
        case CREATE_GOODS_RECEIPT_NOTE:
            [serviceUrl appendString:CREATE_GOODS_RECEIPT_NOTE_PARAM];
            break;
        case UPDATE_GOODS_RECEIPT_NOTE:
            [serviceUrl appendString:UPDATE_GOODS_RECEIPT_NOTE_PARAM];
            break;
        case GET_GOODS_RECEIPT_NOTE:
            [serviceUrl appendString:GET_GOODS_RECEIPT_NOTE_PARAM];
            break;
        case GET_GOODS_RECEIPT_NOTE_SUMMARY:
            [serviceUrl appendString:GET_GOODS_RECEIPT_NOTE_SUMMARY_PARAM];
            break;
        case GENERATE_GRN:
            [serviceUrl appendString:GENERATE_GRN_PARAM];
            break;
        case GET_PO_IDS_IDS:
            [serviceUrl appendString: GET_PO_IDS_IDS_PARAM];
            break;
            
        case GET_PURCHASE_ORDERS:
            [serviceUrl appendString: GET_PURCHASE_ORDERS_PARAM];
            break;
        case SEARCH_WREHOUSE_PRODUCTS:
            [serviceUrl appendString: SEARCH_WAREHOUSE_PRODUCTS_PARAM];
            break;
            
        case GET_WAREHOUSE_PRODUCT_DETAILS:
            [serviceUrl appendString: GET_WAREHOUSE_PRODUCT_DETAILS_PARAM];
            break;
            
        case GET_PURCHASE_ORDER_DETAILS:
            [serviceUrl appendString: GET_PURCHASE_ORDER_DETAILS_PARAM];
            break;
        case GET_STOCK_REQUEST_IDS:
            [serviceUrl appendString:GET_STOCK_REQUEST_IDS_PARAM];
            break;
        case GET_STOCK_MOVEMENT_DETAILS:
            [serviceUrl appendString:GET_STOCK_MOVEMENT_DETAILS_PARAM];
            break;
            
            
        case GET_MODEL_DETAILS:
            [serviceUrl appendString:GET_MODEL_DETAILS_PARAM];
            break;
            
            
        case GET_STOCKREQUEST_SUMMARY:
            [serviceUrl appendString:GET_STOCKREQUEST_SUMMARY_PARAM];
            break;
            
        case GET_STORE_TAX_DETAILS:
            [serviceUrl appendString:GET_STORE_TAX_DETAILS_PARAM];
            break;
            
            
        case GET_STOCKVERIFICATION_MASTER_CHILDS:
            [serviceUrl appendFormat:GET_STOCKVERIFICATION_MASTER_CHILDS_PARAM];
            break;
            
        case GET_PRICELIST_SKU_DETAILS:
            [serviceUrl appendFormat:GET_PRICELIST_SKU_DETAILS_PARAM];
            break;
            
        case GET_WORKFLOWS:
            [serviceUrl appendFormat:GET_WORKFLOWS_PARAM];
            break;
            
        case GET_PRODUCT_CLASSES:
            [serviceUrl appendFormat:GET_PRODUCT_CLASSES_PARAM];
            break;
            
        case GET_SALES_VOID_ITEM_REPORTS:
            [serviceUrl appendFormat:GET_SALES_VOID_ITEM_REPORTS_PARAM];
            break;
            
        case GET_SALESPRICE_OVERRIDE_REPORT:
            [serviceUrl appendFormat:GET_SALESPRICE_OVERRIDE_REPORT_PARAM];
            break;
            
            
        case GET_SALESMEN_COMMISSION_REPORT:
            [serviceUrl appendFormat:GET_SALESMEN_COMMISSION_REPORT_PARAM];
            break;
            
        case CREATE_NEW_CUSTOMER_WALKINS:
            [serviceUrl appendFormat:CREATE_NEW_CUSTOMER_WALKINS_PARAM];
            break;
            
        case GET_DAILY_STOCK_REPORT:
            [serviceUrl appendFormat:GET_DAILY_STOCK_REPORT_PARAM];
            break;
            
        case GET_CATEGORIES_BY_LOCATION:
            [serviceUrl appendFormat:GET_CATEGORIES_BY_LOCATION_PARAM];
            break;
            
        case GET_BRANDS_BY_LOCATION:
            [serviceUrl appendFormat:GET_BRANDS_BY_LOCATION_PARAM];
            break;
            
        case GENERATE_CUSTOMER_OTP:
            [serviceUrl appendFormat:GENERATE_CUSTOMER_OTP_PARAM];
            break;
            
        case VALIDATE_CUSTOMER_OTP:
            [serviceUrl appendFormat:VALIDATE_CUSTOMER_OTP_PARAM];
            break;
            
        case GET_SHIPMENT_RETURN:
            [serviceUrl appendFormat:GET_SHIPMENT_RETURN_PARAM];
            break;
            
        case CREATE_SHIPMENT_RETURN:
            [serviceUrl appendFormat:CREATE_SHIPMENT_RETURN_PARAM];
            break;
            
        case UPDATE_SHIPMENT_RETURN:
            [serviceUrl appendFormat:UPDATE_SHIPMENT_RETURN_PARAM];
            break;
            
        case GET_OUTLET_GOODS_RECEIPT_IDS:
            [serviceUrl appendFormat:GET_OUTLET_GOODS_RECEIPT_IDS_PARAM];
            break;
            
        case GET_OUTLET_ORDERS:
            [serviceUrl appendFormat:GET_OUTLET_ORDERS_PARAM];
            break;
            
        case GET_OUTLET_ORDER_DETAILS:
            [serviceUrl appendFormat:GET_OUTLET_ORDER_DETAILS_PARAM];
            break;
            
        case CREATE_OUTLET_ORDER:
            [serviceUrl appendFormat:CREATE_OUTLET_ORDER_PARAM];
            break;
            
        case UPDATE_OUTLET_ORDER:
            [serviceUrl appendFormat:UPDATE_OUTLET_ORDER_PARAM];
            break;
            
        case GET_CUSTOMER_PURCHASES:
            [serviceUrl appendFormat:GET_CUSTOMER_PURCHASES_PARAM];
            break;
            
        case GET_TRACKER_ITEM_DETAILS:
            [serviceUrl appendFormat:GET_TRACKER_ITEM_DETAILS_PARAM];
            break;
            
        case GET_MENU_DETAILS:
            [serviceUrl appendFormat:GET_MENU_DETAILS_PARAM];
            break;
            
        case GET_MENU_CATEGORY_DETAILS:
            [serviceUrl appendFormat:GET_MENU_CATEGORY_DETAILS_PARAM];
            break;
            
        case GET_SKU_STOCK_INFORMATION:
            [serviceUrl appendFormat:GET_SKU_STOCK_INFORMATION_PARAM];
            break;
            
        case CREATE_DAY_OPEN_SUMMARY:
            [serviceUrl appendFormat:CREATE_DAY_OPEN_SUMMARY_PARAM];
            break;
            
        case GET_DAY_CLOSURE:
            [serviceUrl appendFormat:GET_DAY_CLOSURE_PARAM];
            break;
            
        case CREATE_DAY_CLOSURE:
            [serviceUrl appendFormat:CREATE_DAY_CLOSURE_PARAM];
            break;
            
        case GET_COUPON_DETAILS:
            [serviceUrl appendFormat:GET_COUPON_DETAILS_PARAM];
            break;
            
        case GENERATE_BUILD_OTP:
            [serviceUrl appendFormat:GENERATE_BUILD_OTP_PARAM];
            break;
            
        case VALIDATE_BUILD_OTP:
            [serviceUrl appendFormat:VALIDATE_BUILD_OTP_PARAM];
            break;
            
        case GET_CUSTOMER_DETAILS:
            [serviceUrl appendFormat:GET_CUSTOMER_DETAILS_PARAM];
            break;
            
        case UPDATE_CUSTOMER_DETAILS:
            [serviceUrl appendFormat:UPDATE_CUSTOMER_DETAILS_PARAM];
            break;
            
        case GET_MEMBERS:
            [serviceUrl appendString:GET_MEMBERS_PARAM];
            break;
            
        case GET_ROLES:
            [serviceUrl appendString:GET_ROLES_PARAM];
            break;
            
        case GET_MEMBERSHIP_USERS:
            [serviceUrl appendString:GET_MEMBERSHIP_USERS_PARAM];
            break;
            
        case GET_GIFT_COUPONS_MASTER:
            [serviceUrl appendString:GET_GIFT_COUPONS_MASTER_PARAM];
            break;
            
            // added by roja on 09/01/2019...
        case CREATE_NEW_REST_BOOKING:
            [serviceUrl appendString:CREATE_NEW_REST_BOOKINGS_PARAM];
            break;
            
        case GET_CUSTOMER_DETAILS_D_1:
            [serviceUrl appendString:GET_CUSTOMER_DETAILS_D_1_PARAM];
            break;
            
        case GET_PHONE_NOS:
            [serviceUrl appendString:GET_PHONE_NOS_PARAM];
            break;
            
        case GET_ORDER_DETAILS:
            [serviceUrl appendString:GET_ORDER_DETAILS_PARAM];
            break;
            
        case GET_ORDERS_BY_PAGE:
            [serviceUrl appendString:GET_ORDERS_BY_PAGE_PARAM];
            break;
            
        case GET_ALL_REST_BOOKINGS:
            [serviceUrl appendString:GET_ALL_REST_BOOKINGS_PARAM];
            break;
            
        case GET_AVAILABEL_LEVELS:
            [serviceUrl appendString:GET_AVAILABEL_LEVELS_PARAM];
            break;
            
        case GET_MENU_ITEMS:
            [serviceUrl appendString:GET_MENU_ITEMS_PARAM];
            break;
            
        case GET_ALL_LAYOUT_TABLES:
            [serviceUrl appendString:GET_ALL_LAYOUT_TABLES_PARAM];
            break;
            
        case UPDATE_REST_BOOKING:
            [serviceUrl appendString:UPDATE_REST_BOOKING_PARAM];
            break;
            
        case UPDATE_KOT_STATUS:
            [serviceUrl appendString:UPDATE_KOT_STATUS_PARAM];
            break;
            
        case  GET_MENU_CATEGIORE_DETAILS:
            [serviceUrl appendString:GET_MENU_CATEGIORE_DETAILS_PARAM];
            break;
            
        case ITEM_DETAILS_IN_KOT:
            [serviceUrl appendString:ITEM_DETAILS_IN_KOT_PARAM];
            break;
            
        case GET_GIFT_VOUCHERS:
            [serviceUrl appendString:GET_GIFT_VOUCHERS_PARAM];
            break;
            
        case GET_GIFT_VOUCHERS_BY_SEARCH_CRITERIA:
            [serviceUrl appendString:GET_GIFT_VOUCHERS_BY_SEARCH_CRITERIA_PARAM];
            break;
            
        case ISSUE_GIFT_VOUCHER_TO_CUSTOMER:
            [serviceUrl appendString:ISSUE_GIFT_VOUCHER_TO_CUSTOMER_PARAM];
            break;
            
        case GET_AVAILABLE_TABLES:
            [serviceUrl appendString:GET_AVAILABLE_TABLES_PARAM];
            break;
            
        case GET_EATING_HABITS:
            [serviceUrl appendString:GET_EATING_HABITS_PARAM];
            break;
            
        case GET_PRODUCT_VERIFICATION:
            [serviceUrl appendString:GET_PRODUCT_VERIFICATION_PARAM];
            break;
            
        case CREATE_STOCK_VERIFICATION:
            [serviceUrl appendString:CREATE_STOCK_VERIFICATION_PARAM];
            break;
            
        case UPDATE_STOCK_VERIFICATION:
            [serviceUrl appendString:UPDATE_STOCK_VERIFICATION_PARAM];
            break;
            
        case GET_ROUTE_MASTER:
            [serviceUrl appendString:GET_ROUTE_MASTER_PARAM];
            break;
            
        case GET_LOYALTY_CARD_SERVICE:
            [serviceUrl appendString:GET_LOYALTY_CARD_SERVICE_PARAM];
            break;
            
        case ISSUE_LOYALTY_CARD:
            [serviceUrl appendString:ISSUE_LOYALTY_CARD_PARAM];
            break;
            
        case GET_GIFT_COUPONS_SERVICE:
            [serviceUrl appendString:GET_GIFT_COUPONS_SERVICE_PARAM];
            break;
            
        case GET_VOUCHER_SERVICE:
            [serviceUrl appendString:GET_VOUCHER_SERVICE_PARAM];
            break;
            
        case GET_GIFT_COUPONS_BY_SEARCH_CRITERIA:
            [serviceUrl appendString:GET_GIFT_COUPONS_BY_SEARCH_CRITERIA_PARAM];
            break;
            
        case ISSUE_GIFT_COUPON_TO_CUSTOMER:
            [serviceUrl appendString:ISSUE_GIFT_COUPON_TO_CUSTOMER_PARAM];
            break;
            
        case GET_EMPLOYEE_DETAILS:
            [serviceUrl appendString:GET_EMPLOYEE_DETAILS_PARAM];
            break;
            
        case GET_LEDGER_BALANCE:
            [serviceUrl appendString:GET_LEDGER_BALANCE_PARAM];
            break;
            
        case CREATE_WALLET_TRANSACTION:
            [serviceUrl appendString:CREATE_WALLET_TRANSACTION_PARAM];
            break;
            
        case AUTHENTICATE_USER:
            [serviceUrl appendString:AUTHENTICATE_USER_PARAM];
            break;
            
        case GET_APP_SETTINGS:
            [serviceUrl appendString:GET_APP_SETTINGS_PARAM];
            break;
            
        case CHANGE_PASSWORD:
            [serviceUrl appendString:CHANGE_PASSWORD_PARAM];
            break;
            
        case USER_REGISTRATION:
            [serviceUrl appendString:USER_REGISTRATION_PARAM];
            break;
            
        case GET_STORES:
            [serviceUrl appendString:GET_STORES_PARAM];
            break;
            
        case GENERATE_OTP:
            [serviceUrl appendString:GENERATE_OTP_PARAM];
            break;
            
        case VALIDATE_OTP:
            [serviceUrl appendString:VALIDATE_OTP_PARAM];
            break;
            
        case RESET_PASSWORD:
            [serviceUrl appendString:RESET_PASSWORD_PARAM];
            break;
            
        case CREATE_CUSTOMER:
            [serviceUrl appendString:CREATE_CUSTOMER_PARAM];
            break;
            
        case GET_STOCK_PROCUREMENT_RECEIPT:
            [serviceUrl appendString:GET_STOCK_PROCUREMENT_RECEIPT_PARAM];
            break;
            
        case GET_STOCK_PROCUREMENT_RECEIPTS:
            [serviceUrl appendString:GET_STOCK_PROCUREMENT_RECEIPTS_PARAM];
            break;
            
        case GET_STOCK_PROCUREMENT_RECEIPT_IDS:
            [serviceUrl appendString:GET_STOCK_PROCUREMENT_RECEIPT_IDS_PARAM];
            break;
            
        case GET_ISSUED_LOYALTY_CARD:
            [serviceUrl appendString:GET_ISSUED_LOYALTY_CARD_PARAM];
            break;
            
            
        case GET_AVAILABLE_LOYALTY_PROGRAMS:
            [serviceUrl appendString:GET_AVAILABLE_LOYALTY_PROGRAMS_PARAM];
            break;
            
        case UPDATE_ISSUED_LOYALTY_CARD:
            [serviceUrl appendString:UPDATE_ISSUED_LOYALTY_CARD_PARAM];
            break;
            
        case CREATE_PURCHASE_ORDER:
            [serviceUrl appendString:CREATE_PURCHASE_ORDER_PARAM];
            break;
            
        case GET_PURCHASE_ORDER:
            [serviceUrl appendString:GET_PURCHASE_ORDER_PARAM];
            break;
            
        case GET_PURCHASE_ORDER_DETAILS_OUTLET:
            [serviceUrl appendString:GET_PURCHASE_ORDER_DETAILS_OUTLET_PARAM];
            break;
            
        case UPDATE_PURCHASE_ORDER:
            [serviceUrl appendString:UPDATE_PURCHASE_ORDER_PARAM];
            break;
            
        case GET_STORE_LOCATION:
            [serviceUrl appendString:GET_STORE_LOCATION_PARAM];
            break;
            
        case GET_STORE_UNIT:
            [serviceUrl appendString:GET_STORE_UNIT_PARAM];
            break;
            
        case GET_GIFT_VOUCHER_DETAILS:
            [serviceUrl appendString:GET_GIFT_VOUCHER_DETAILS_PARAM];
            break;
            
        case UPDATE_SYNC_DOWNLOAD_STATUS:
            [serviceUrl appendString:UPDATE_SYNC_DOWNLOAD_STATUS_PARAM];
            break;
            
        case UPDATE_COUNTER:
            [serviceUrl appendString:UPDATE_COUNTER_PARAM];
            break;
            
        case GET_COUNTERS:
            [serviceUrl appendString:GET_COUNTERS_PARAM];
            break;
            
        case GET_BRAND:
            [serviceUrl appendString:GET_BRAND_PARAM];
            break;
            
        case GET_DEPARTMENTS:
            [serviceUrl appendString:GET_DEPARTMENTS_PARAM];
            break;
            
        case GET_SUPPLIERS:
            [serviceUrl appendString:GET_SUPPLIERS_PARAM];
            break;
            
        case GET_CATEGORIES:
            [serviceUrl appendString:GET_CATEGORIES_PARAM];
            break;
            
        case GET_LOCATION:
            [serviceUrl appendString:GET_LOCATION_PARAM];
            break;
            
        case GET_PRODUCT_CATEGORY:
            [serviceUrl appendString:GET_PRODUCT_CATEGORY_PARAM];
            break;
            
        case GET_PRODUCT_SUB_CATEGORY:
            [serviceUrl appendString:GET_PRODUCT_SUB_CATEGORY_PARAM];
            break;
            
        case GET_TAXES:
            [serviceUrl appendString:GET_TAXES_PARAM];
            break;
            
        case GET_ZONES:
            [serviceUrl appendString:GET_ZONES_PARAM];
            break;
            
        case GET_SALES_REPORTS:
            [serviceUrl appendString:GET_SALES_REPORTS_PARAM];
            break;
            
        case GET_RETURNING_ITEM:
            [serviceUrl appendString:GET_RETURNING_ITEM_PARAM];
            break;
            
        case GET_BILLING_DETAILS:
            [serviceUrl appendString:GET_BILLING_DETAILS_PARAM];
            break;
            
        case GET_HOUR_WISE_REPORT:
            [serviceUrl appendString:GET_HOUR_WISE_REPORT_PARAM];
            break;
            
        case GET_XZ_REPORTS:
            [serviceUrl appendString:GET_XZ_REPORTS_PARAM];
            break;
            
        case GET_OFFER:
            [serviceUrl appendString:GET_OFFER_PARAM];
            break;
            
        case GET_LOYALITY_CARD_BY_SEARCH_CRITERIA:
            [serviceUrl appendString:GET_LOYALITY_CARD_BY_SEARCH_CRITERIA_PARAM];
            break;
            
        default:
            break;
    }
    return serviceUrl;
}

+ (NSString *)addPercentEscapesFor:(NSString *)inputString {
    return [inputString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

/**
 * @description  here we are forming the billing items list....
 * @date
 * @method       getBillingItemsFrom:-- itemDiscountArr:-- itemDiscountDescArr:-- offerPriceArray:-- dealPriceArray:-- itemScanCode:-- turnOverOffer:-- totalPriceBeforeTurnOver:--  salesPersonInfo:-- manufacturedItems:-- packagedItemsArr:-- productInfoArr:--
 * @author       Srinivasulu
 * @param
 * @param        NSString
 * @param        NSMutableArray
 * @param        NSMutableArray
 * @param        NSMutableArray
 * @param        NSMutableArray
 * @param        NSMutableArray
 * @param        float
 * @param        float
 * @param        NSDictionary
 * @param        NSArray
 * @param        NSArray
 * @param        NSArray
 *
 * @return       NSMutableArray
 *
 * @modified By  Srinivasulu on 27/09/2017....
 * @reason       OtherDiscount are also need to handled....  So, Added the new field "otherDiscountValue"....  ---- otherDiscountValue:(NSString *)otherDiscountValueStr
 *
 * @verified By
 * @verified On
 *
 */

+ (NSMutableArray *)getBillingItemsFrom:(NSString *)itemString itemDiscountArr:(NSMutableArray *)itemDiscountArr itemDiscountDescArr:(NSMutableArray *)itemDiscountDescArr offerPriceArray:(NSMutableArray *)offerPriceArray dealPriceArray:(NSMutableArray *)dealPriceArray itemScanCode:(NSMutableArray *)itemScanCode turnOverOffer:(float)turnOverOfferVal totalPriceBeforeTurnOver:(float)totalPriceBeforeTurnOver salesPersonInfo:(NSDictionary*)salesPersonInfo manufacturedItems:(NSArray *)manufacturedItemsArr packagedItemsArr:(NSArray *)packagedItemsArr productInfoArr:(NSArray *)productInfoArr otherDiscountValue:(NSString *)otherDiscountValueStr{
    
    //added by srinivasulu on 07/02/2017..........
    NSMutableArray *itemArray = [NSMutableArray new];
    
    @try {
        
        NSArray *itemSubArray = [itemString componentsSeparatedByString:@"@"];
        
        //added by Srinivasulu on
        
        for (int i = 0; i < itemSubArray.count - 1; i++) {
            NSArray *itemDetails = [itemSubArray[i] componentsSeparatedByString:@"#"];
            NSMutableDictionary *itemDic = [NSMutableDictionary new];
            
            [itemDic setValue:itemDetails[0] forKey:@"sku_id"];
            [itemDic setValue:itemDetails[1] forKey:@"item_name"];
            [itemDic setValue:itemDetails[3] forKey:@"quantity"];
            float itemTotalPrice = [itemDetails[2] floatValue];
            
            //changed it from block variable....on 25/10/2017....
            //changed by Srinivasulu on 16/11/2017....  some time discount amount becomes double....
            //            float dealOfferDiscount = 0.0;
            
            float applliedItemDealAmount = 0.0;
            float applliedItemOfferAmount = 0.0;
            float applliedTurnOverAmount = 0.0;
            
            NSNumber * disCountPriceValue = 0;
            
            
            
            
            //changed by Srinivasulu on 27/07/2017....
            //reason in with out offer it has to be calculated....
            
            [itemDic setValue:[NSString stringWithFormat:@"%.2f",(itemTotalPrice / [itemDetails[3] floatValue])] forKey:@"itemUnitPrice"];
            
            //upto here on 27/07/2017....
            
            if (offerPriceArray.count > i && dealPriceArray.count > i) {
                itemTotalPrice = ([itemDetails[2] floatValue] - ([offerPriceArray[i] floatValue] + [dealPriceArray[i] floatValue]));
            }
            [itemDic setValue:[NSString stringWithFormat:@"%.2f",itemTotalPrice] forKey:@"item_total_price"];
            // if([[offerPriceArray objectAtIndex:i] floatValue] > 0){
            
            //commented by Srinivasulu on 27/07/2017....
            
            //            [itemDic setValue:[NSString stringWithFormat:@"%.2f",(itemTotalPrice / [[itemDetails objectAtIndex:3] floatValue])] forKey:@"itemUnitPrice"];
            
            //upto here on 27/07/2017....
            
            //            }
            //            else {
            //                [itemDic setValue:[NSString stringWithFormat:@"%.2f",([[itemDetails objectAtIndex:2] floatValue] / [[itemDetails objectAtIndex:3] floatValue])] forKey:@"itemUnitPrice"];
            //            }
            [itemDic setValue:itemDetails[6] forKey:@"taxRate"];
            
            //added by Srinivasulu on 08/06/2017....
            
            //            [itemDic setValue:[itemDetails objectAtIndex:6] forKey:@"taxCost"];
            
            //upto here on 08/06/2017....
            
            
            [itemDic setValue:itemDetails[5] forKey:@"taxCode"];
            [itemDic setValue:itemDetails[7] forKey:@"status"];
            [itemDic setValue:itemDetails[8] forKey:PLU_CODE];
            
            //            if ([[itemDetails objectAtIndex:9] floatValue] > 0) {
            //
            //                [itemDic setValue:[NSString stringWithFormat:@"%.2f",([[itemDetails objectAtIndex:9] floatValue]*[[itemDetails objectAtIndex:3] floatValue])] forKey:@"item_total_price"];
            //
            //            }
            [itemDic setValue:itemDetails[9] forKey:EDITED_PRICE];
            [itemDic setValue:itemDetails[10] forKey:MRP_Price];
            
            if (itemDetails.count > 15) {
                [itemDic setValue:itemDetails[17] forKey:@"promoItemFlag"];
            }
            else {
                [itemDic setValue:itemDetails[11] forKey:@"promoItemFlag"];
                
            }
            
            if (itemDiscountDescArr != nil && itemDiscountArr != nil) {
                
                float  itemDiscount = [itemDiscountArr[i] floatValue];
                
                
                //added by Srinivasulu on 31/07/2017....
                //manual discount should also be removed from the item totalprice....
                //changed by Srinivasulu on 11/10/2017....
                //reason added the equalto "=" symbol also....
                
                if(itemTotalPrice >= [itemDiscountArr[i] floatValue]){
                    
                    itemTotalPrice  = itemTotalPrice  - [itemDiscountArr[i] floatValue];
                    [itemDic setValue:[NSString stringWithFormat:@"%.2f",itemTotalPrice] forKey:@"item_total_price"];
                }
                //upto here on 31/07/2017....
                
                
                
                [itemDic setValue:@(itemDiscount) forKey:ITEM_DISCOUNT];
                [itemDic setValue:itemDiscountDescArr[i] forKey:ITEM_DISCOUNT_DESC];
                
            }
            else {
                [itemDic setValue:@"0.00" forKey:ITEM_DISCOUNT];
                [itemDic setValue:@"" forKey:ITEM_DISCOUNT_DESC];
            }
            
            
            
            
            
            if ((offerPriceArray != nil && dealPriceArray != nil) && (offerPriceArray.count > i && dealPriceArray.count > i) ) {
                [itemDic setValue:@([offerPriceArray[i] floatValue]) forKey:ITEM_OFFER_PRICE];
                [itemDic setValue:@([dealPriceArray[i] floatValue]) forKey:ITEM_DEAL_PRICE];
                if ([offerPriceArray[i] floatValue] > 0) {
                    
                    //                    dealOfferDiscount = dealOfferDiscount + [[offerPriceArray objectAtIndex:i] floatValue];
                    applliedItemOfferAmount = [offerPriceArray[i] floatValue];
                }
                if ([dealPriceArray[i] floatValue] > 0) {
                    
                    //                    dealOfferDiscount = dealOfferDiscount + [[dealPriceArray objectAtIndex:i] floatValue];
                    applliedItemDealAmount = [dealPriceArray[i] floatValue];
                }
                
                float turnOverDisc = 0.0;
                float fraction = 0;
                float itemPriceAfterDisc = ([[itemDic valueForKey:@"item_total_price"] floatValue]);
                if (turnOverOfferVal > 0) {
                    
                    fraction = (itemPriceAfterDisc / totalPriceBeforeTurnOver) * 100;
                    turnOverDisc = (turnOverOfferVal * fraction) / 100;
                }
                
                // applliedItemDealAmount  --  applliedItemOfferAmount --  applliedTurnOverAmount
                
                NSString * turnOverDiscStr = [NSString stringWithFormat:@"%.2f",turnOverDisc];
                //                dealOfferDiscount = dealOfferDiscount + [turnOverDiscStr floatValue];
                applliedTurnOverAmount = turnOverDiscStr.floatValue;
                
                //added by Srinivasulu on 23/08/2017....
                
                [itemDic setValue:[NSString stringWithFormat:@"%.2f",(itemTotalPrice  - turnOverDiscStr.floatValue)] forKey:@"item_total_price"];
                
                //upto here on 23/07/2017....
                
                // applliedItemDealAmount  --  applliedItemOfferAmount --  applliedTurnOverAmount
                
                //                [itemDic setValue:[NSNumber numberWithFloat:dealOfferDiscount] forKey:DISCOUNT_PRICE_1];
                //                [itemDic setValue:[NSNumber numberWithFloat:dealOfferDiscount] forKey:DISCOUNT_PRICE_2];
                //                [itemDic setValue:[NSNumber numberWithFloat:dealOfferDiscount] forKey:DISCOUNT_PRICE_3];
                
                disCountPriceValue = @(applliedItemDealAmount + applliedItemOfferAmount + applliedTurnOverAmount );
                
                [itemDic setValue:disCountPriceValue forKey:DISCOUNT_PRICE_1];
                [itemDic setValue:disCountPriceValue forKey:DISCOUNT_PRICE_2];
                [itemDic setValue:disCountPriceValue forKey:DISCOUNT_PRICE_3];
            }
            else {
                
                [itemDic setValue:@0.0f forKey:ITEM_OFFER_PRICE];
                [itemDic setValue:@0.0f forKey:ITEM_DEAL_PRICE];
            }
            
            //added by Srinivasulu on 27/09/2017....
            
            @try{
                
                if(otherDiscountValueStr != nil){
                    
                    if(otherDiscountValueStr.length && otherDiscountValueStr.floatValue > 0){
                        
                        if([[itemDic valueForKey:ITEM_TOTAL_PRICE] floatValue] > 0){
                            
                            float otherDiscountforItem = [[itemDic valueForKey:ITEM_TOTAL_PRICE] floatValue] * (otherDiscountValueStr.floatValue/100.0);
                            
                            if([[itemDic valueForKey:ITEM_TOTAL_PRICE] floatValue] >= otherDiscountforItem){
                                
                                NSString * tempStr = [NSString stringWithFormat:@"%.2f", ([[itemDic valueForKey:ITEM_DISCOUNT] floatValue] + otherDiscountforItem)];
                                [itemDic setValue:tempStr forKey:ITEM_DISCOUNT];
                                [itemDic setValue:[NSString stringWithFormat:@"%.2f",([[itemDic valueForKey:ITEM_TOTAL_PRICE] floatValue]  - otherDiscountforItem)] forKey:ITEM_TOTAL_PRICE];
                                
                            }//end of negative condition check..
                        }//end of totalPriceLoop....
                    }//end of otherDiscountStr
                }//end of otherDiscountValueStr == nil condition....
                
                float itemSalePrice =  [[itemDic valueForKey:ITEM_TOTAL_PRICE] floatValue] /  [[itemDic valueForKey:QUANTITY] floatValue];
                
                [itemDic setValue:[NSString stringWithFormat:@"%.2f",itemSalePrice] forKey:SALE_PRICE];
                
            }
            @catch(NSException * exception){
                
            }
            
            //upto here on 27/09/2017....
            
            
            if (itemScanCode !=nil) {
                @try {
                    [itemDic setValue:itemScanCode[i] forKey:@"itemScanCode"];
                }
                @catch (NSException *exception) {
                    [itemDic setValue:@"" forKey:@"itemScanCode"];
                }
            }
            
            //commented by Srinivasulu on 25/10/2017....
            //reason -- += operator is not working properly....
            
            //added by Srinivasulu on 25/07/2017....
            
            //            float itemDiscPrice = 0.0;
            
            //added by Srinivasulu on 26/07/2017...
            //            if(([[itemDic allKeys] containsObject:DISCOUNT_PRICE_2]) && (![[itemDic valueForKey:DISCOUNT_PRICE_2] isKindOfClass:[NSNull class]]) )
            //                itemDiscPrice =  [[itemDic valueForKey:DISCOUNT_PRICE_2] floatValue];
            
            //            else if(([[itemDic allKeys] containsObject:ITEM_DEAL_PRICE]) && (! [[itemDic valueForKey:ITEM_DEAL_PRICE] isKindOfClass:[NSNull class]]) )
            //                itemDiscPrice +=   [[itemDic valueForKey:ITEM_DEAL_PRICE] floatValue];
            //
            //            if(([[itemDic allKeys] containsObject:ITEM_OFFER_PRICE]) && (! [[itemDic valueForKey:ITEM_OFFER_PRICE] isKindOfClass:[NSNull class]]) )
            //                itemDiscPrice += [[itemDic valueForKey:ITEM_OFFER_PRICE] floatValue];
            
            //            [itemDic setValue:[NSString stringWithFormat:@"%.2f",dealOfferDiscount] forKey:@"discountPrice"];
            
            
            
            
            //upto here on 25/07/2017...
            //discountPrice
            
            // applliedItemDealAmount  --  applliedItemOfferAmount --  applliedTurnOverAmount
            
            [itemDic setValue:[NSString stringWithFormat:@"%.2f",disCountPriceValue.floatValue] forKey:@"discountPrice"];
            
            
            
            if (![[salesPersonInfo valueForKey:itemDetails[8]] isKindOfClass:[NSNull class]] && [salesPersonInfo.allKeys containsObject:itemDetails[8]]) {
                
                NSDictionary *tempDic = [salesPersonInfo valueForKey:itemDetails[8]];
                
                [itemDic setValue:[tempDic valueForKey:kItemDept] forKey:kItemDept];
                [itemDic setValue:[tempDic valueForKey:kItemSubDept] forKey:kItemSubDept];
                [itemDic setValue:[tempDic valueForKey:kItemSpecificEmplId] forKey:kItemSpecificEmplId];
                [itemDic setValue:[tempDic valueForKey:kItemSpecificEmplName] forKey:kItemSpecificEmplName];
            }
            
            //changed by Srinivasulu on 07/02/2017....
            @try{
                if (manufacturedItemsArr != nil) {
                    itemDic[kIsManuFacturedItem] = [NSNumber numberWithBool:false];
                    
                    if(manufacturedItemsArr.count > i && manufacturedItemsArr.count > i)
                        if( [manufacturedItemsArr[i] boolValue])
                            itemDic[kIsManuFacturedItem] = [NSNumber numberWithBool:true];
                }
                if (packagedItemsArr != nil) {
                    
                    //added by Srinivasulu on 07/02/2017.......
                    itemDic[kPackagedType] = [NSNumber numberWithBool:false];
                    
                    if(packagedItemsArr.count > i && packagedItemsArr.count > i)
                        if( [packagedItemsArr[i] boolValue])
                            itemDic[kPackagedType] = [NSNumber numberWithBool:true];
                }
            }
            @catch(NSException * exp){
                
            }
           
            //upto here on 15/10/2018....
            
            if (productInfoArr != nil && productInfoArr.count) {
                
                NSDictionary * productInfoDic = productInfoArr[i];
                
                
                //added by Srinivasulu on 12/07/2017.....
                
                //changed by Srinivasulu on 27/09/2017....
                //                if(([[itemDic valueForKey:ITEM_OFFER_PRICE] floatValue] > 0) || ([[itemDic valueForKey:ITEM_DEAL_PRICE] floatValue] > 0) || ([[itemDic valueForKey:ITEM_DISCOUNT] floatValue] > 0)){
                
                if((([[itemDic valueForKey:ITEM_OFFER_PRICE] floatValue] > 0) || (([[itemDic valueForKey:ITEM_DEAL_PRICE] floatValue] > 0) || ([[itemDic valueForKey:ITEM_DISCOUNT] floatValue] > 0))) && (! (discCalcOn.length > 0 && [discCalcOn caseInsensitiveCompare:@"Original Price"] == NSOrderedSame))){
                    
                    //upto here on 27/09/2017....
                    
                    if (discTaxation.length > 0 && [discTaxation caseInsensitiveCompare:@"Inclusive"] == NSOrderedSame) {
                        
                        [itemDic setValue:@YES forKey:TAX_INCLUSIVE];
                    }
                    else if(discTaxation.length > 0){
                        
                        [itemDic setValue:@NO forKey:TAX_INCLUSIVE];
                    }
                    else{
                        
                        [itemDic setValue:@YES forKey:TAX_INCLUSIVE];
                    }
                    
                    
                }
                else{
                    
                    if (([productInfoDic.allKeys containsObject:TAX_INCLUSIVE] && ![productInfoDic[TAX_INCLUSIVE] isKindOfClass:[NSNull class]])) {
                        
                        if([productInfoDic[TAX_INCLUSIVE] integerValue])
                            [itemDic setValue:@YES forKey:TAX_INCLUSIVE];
                        else
                            [itemDic setValue:@NO forKey:TAX_INCLUSIVE];
                    }
                    else
                        [itemDic setValue:@YES forKey:TAX_INCLUSIVE];
                    
                }
                
                //below department code has to be moved to bottam in this for loop....
                //upto here on 12/07/2017.....
                
                
                //added by Srinivasulu on 21/08/2017....
                
                if (([productInfoDic.allKeys containsObject:EDIT_PRICE_REASON] && ![productInfoDic[EDIT_PRICE_REASON] isKindOfClass:[NSNull class]])) {
                    
                    itemDic[EDIT_PRICE_REASON] = productInfoDic[EDIT_PRICE_REASON];
                }
                
                //upot here on 21/08/2017....
                
                if (([productInfoDic.allKeys containsObject:kProductCategory] && ![productInfoDic[kProductCategory] isKindOfClass:[NSNull class]])) {
                    
                    itemDic[kProductCategory] = productInfoDic[kProductCategory];
                }
                
                if (([productInfoDic.allKeys containsObject:kProductSubCategory] && ![productInfoDic[kProductSubCategory] isKindOfClass:[NSNull class]])) {
                    
                    itemDic[kProductSubCategory] = productInfoDic[kProductSubCategory];
                }
                if (([productInfoDic.allKeys containsObject:kProductRange] && ![productInfoDic[kProductRange] isKindOfClass:[NSNull class]])) {
                    
                    itemDic[kProductRange] = productInfoDic[kProductRange];
                }
                if (([productInfoDic.allKeys containsObject:kMeasureRange] && ![productInfoDic[kMeasureRange] isKindOfClass:[NSNull class]])) {
                    
                    itemDic[kMeasureRange] = productInfoDic[kMeasureRange];
                }
                
                if (([productInfoDic.allKeys containsObject:kProductBrand] && ![productInfoDic[kProductBrand] isKindOfClass:[NSNull class]])) {
                    
                    itemDic[kBrand] = productInfoDic[kProductBrand];
                }
                
                if (([productInfoDic.allKeys containsObject:kProductModel] && ![productInfoDic[kProductModel] isKindOfClass:[NSNull class]])) {
                    
                    itemDic[kProductModel] = productInfoDic[kProductModel];
                }
                
                //added by Srinivasulu on 11/05/2017...
                
                
                
                
                if (([productInfoDic.allKeys containsObject:kItemDept] && ![productInfoDic[kItemDept] isKindOfClass:[NSNull class]])) {
                    
                    itemDic[kItemDept] = productInfoDic[kItemDept];
                }
                
                if (([productInfoDic.allKeys containsObject:kItemSubDept] && ![productInfoDic[kItemSubDept] isKindOfClass:[NSNull class]])) {
                    
                    itemDic[kItemSubDept] = productInfoDic[kItemSubDept];
                }
                
                
                if (([productInfoDic.allKeys containsObject:SECTION] && ![productInfoDic[SECTION] isKindOfClass:[NSNull class]])) {
                    
                    itemDic[SECTION] = productInfoDic[SECTION];
                }
                
                //added by Srinivasulu on 27/06/2017 && 29/08/2018...
                
                if (([productInfoDic.allKeys containsObject:HSN_CODE] && ![productInfoDic[HSN_CODE] isKindOfClass:[NSNull class]])) {
                    
                    itemDic[HSN_CODE] = productInfoDic[HSN_CODE];
                }
                
                if (([productInfoDic.allKeys containsObject:Pack_Size] && ![productInfoDic[Pack_Size] isKindOfClass:[NSNull class]])) {
                    
                    itemDic[Pack_Size] = productInfoDic[Pack_Size];
                }
                
                if (([productInfoDic.allKeys containsObject:EXPIRY_DATE] && ![productInfoDic[EXPIRY_DATE] isKindOfClass:[NSNull class]])) {
                    
                    itemDic[EXPIRY_DATE] = productInfoDic[EXPIRY_DATE];
                }
                //upto here on 27/06/2017 && 29/08/2018....
                
                //newly added keys....
                //added by Srinivasulu on 05/07/2017....
                
                if (([productInfoDic.allKeys containsObject:COLOR] && ![productInfoDic[COLOR] isKindOfClass:[NSNull class]])) {
                    
                    itemDic[COLOR] = productInfoDic[COLOR];
                }
                
                if (([productInfoDic.allKeys containsObject:SIZE] && ![productInfoDic[SIZE] isKindOfClass:[NSNull class]])) {
                    
                    itemDic[SIZE] = productInfoDic[SIZE];
                }
                
                if (([productInfoDic.allKeys containsObject:PRODUCT_RANGE] && ![productInfoDic[PRODUCT_RANGE] isKindOfClass:[NSNull class]])) {
                    
                    itemDic[PRODUCT_RANGE] = productInfoDic[PRODUCT_RANGE];
                }
                
                if (([productInfoDic.allKeys containsObject:kMeasureRange] && ![productInfoDic[kMeasureRange] isKindOfClass:[NSNull class]])) {//MEASUREMENT_RANGE
                    
                    itemDic[kMeasureRange] = productInfoDic[kMeasureRange];
                }
                
                if (([productInfoDic.allKeys containsObject:ITEM_CATEGORY] && ![productInfoDic[ITEM_CATEGORY] isKindOfClass:[NSNull class]])) {
                    
                    itemDic[ITEM_CATEGORY] = productInfoDic[ITEM_CATEGORY];
                }
                
                if (([productInfoDic.allKeys containsObject:kProductBrand] && ![productInfoDic[kProductBrand] isKindOfClass:[NSNull class]])) {//kBrand
                    
                    itemDic[kProductBrand] = productInfoDic[kProductBrand];
                }
                
                if (([productInfoDic.allKeys containsObject:MODEL] && ![productInfoDic[MODEL] isKindOfClass:[NSNull class]])) {
                    
                    itemDic[MODEL] = productInfoDic[MODEL];
                }
                
                if (([productInfoDic.allKeys containsObject:SELL_UOM] && ![productInfoDic[SELL_UOM] isKindOfClass:[NSNull class]])) {
                    
                    itemDic[SELL_UOM] = productInfoDic[SELL_UOM];
                }
                
                //upto here on 05/07/2017....
                
                //added by Srinivasulu on 07/07/2017....
                
                if (([productInfoDic.allKeys containsObject:STYLE] && ![productInfoDic[STYLE] isKindOfClass:[NSNull class]])) {
                    
                    itemDic[STYLE] = productInfoDic[STYLE];
                }
                
                if (([productInfoDic.allKeys containsObject:PATTERN] && ![productInfoDic[PATTERN] isKindOfClass:[NSNull class]])) {//kBrand
                    
                    itemDic[PATTERN] = productInfoDic[PATTERN];
                }
                
                if (([productInfoDic.allKeys containsObject:BATCH] && ![productInfoDic[BATCH] isKindOfClass:[NSNull class]])) {
                    
                    itemDic[BATCH] = productInfoDic[BATCH];
                }
                
                if (([productInfoDic.allKeys containsObject:UTILITY] && ![productInfoDic[UTILITY] isKindOfClass:[NSNull class]])) {
                    
                    itemDic[UTILITY] = productInfoDic[UTILITY];
                    
                    
                }
                
                
                //added by Srinivasulu on 12/08/2017....
                
                if (([productInfoDic.allKeys containsObject:PRODUCT_CLASS] && ![productInfoDic[PRODUCT_CLASS] isKindOfClass:[NSNull class]])) {
                    
                    itemDic[PRODUCT_CLASS] = productInfoDic[PRODUCT_CLASS];
                }
                
                if (([productInfoDic.allKeys containsObject:PRODUCT_SUB_CLASS] && ![productInfoDic[PRODUCT_SUB_CLASS] isKindOfClass:[NSNull class]])) {
                    
                    itemDic[PRODUCT_SUB_CLASS] = productInfoDic[PRODUCT_SUB_CLASS];
                }
                
                if (([productInfoDic.allKeys containsObject:STYLE_RANGE] && ![productInfoDic[STYLE_RANGE] isKindOfClass:[NSNull class]])) {
                    
                    itemDic[STYLE_RANGE] = productInfoDic[STYLE_RANGE];
                    
                }
                //upot here on 12/08/2017....
                
                //upot here on 07/07/2017....
                
                //upto here on 11/05/2017....
                
                //added by Srinivasulu on 08/09/2017....
                
                if (([productInfoDic.allKeys containsObject:VOID_ITEM_REASON] && ![productInfoDic[VOID_ITEM_REASON] isKindOfClass:[NSNull class]])) {
                    
                    itemDic[VOID_ITEM_REASON] = productInfoDic[VOID_ITEM_REASON];
                }
                
                if (([productInfoDic.allKeys containsObject:TAXATION_ON_DISCOUNT_PRICE] && ![productInfoDic[TAXATION_ON_DISCOUNT_PRICE] isKindOfClass:[NSNull class]])) {
                    
                    itemDic[TAXATION_ON_DISCOUNT_PRICE] = productInfoDic[TAXATION_ON_DISCOUNT_PRICE];
                }
                else{
                    
                    [itemDic setValue:@YES forKey:TAXATION_ON_DISCOUNT_PRICE];
                }
                
                //added by Srinivasulu on 17/03/2018....
                [itemDic setValue:@(i) forKey:ITEM_NUMBER_IN_LIST];

                    
                //upto here on 08/09/2017....
                
            }
            
            [itemArray addObject:itemDic];
        }
        
        
        
    } @catch (NSException *exception) {
        
        
    } @finally {
        
        
        return itemArray;
        
        
    }
}

+ (NSMutableArray *)getBillingItemsCampaignsInfo:(NSString *)itemString  offerPriceArray:(NSMutableArray *)offerPriceArray dealPriceArray:(NSMutableArray *)dealPriceArray dealIdsArr:(NSArray*)dealIdsArr offerIdsArr:(NSArray*)offerIdsArr turnOverOffer:(float)turnOverOfferVal totalPriceBeforeTurnOver:(float)totalPriceBeforeTurnOver{
    
    NSMutableArray *itemArray = [NSMutableArray new];
    
    @try {
        NSArray *itemSubArray = [itemString componentsSeparatedByString:@"@"];
        
        
        
        for (int i = 0; i < itemSubArray.count - 1; i++) {
            NSArray *itemDetails = [itemSubArray[i] componentsSeparatedByString:@"#"];
            NSMutableDictionary *itemDic = [NSMutableDictionary new];
            
            
            
            if (dealPriceArray != nil && [dealPriceArray[i] floatValue] > 0) {
                
                [itemDic setValue:itemDetails[0] forKey:@"skuId"];
                [itemDic setValue:itemDetails[1] forKey:@"itemName"];
                float itemTotalPrice = [itemDetails[2] floatValue] ;
                //  [itemDic setValue:[NSString stringWithFormat:@"%.2f",itemTotalPrice] forKey:@"itemPrice"];
                
                //changed by Srinivasulu on 27/07/2017....
                //reason in with out offer it has to be calculated....
                
                [itemDic setValue:@(itemTotalPrice / [itemDetails[3] floatValue]) forKey:@"itemPrice"];
                
                //                if([[offerPriceArray objectAtIndex:i] floatValue] > 0){
                //                    [itemDic setValue:[NSNumber numberWithFloat:(itemTotalPrice / [[itemDetails objectAtIndex:3] floatValue])] forKey:@"itemPrice"];
                //                }
                //                else {
                //                    [itemDic setValue:[NSNumber numberWithFloat:([[itemDetails objectAtIndex:2] floatValue] / [[itemDetails objectAtIndex:3] floatValue])] forKey:@"itemPrice"];
                //                }
                
                //upto here on 27/07/2017....
                
                
                [itemDic setValue:itemDetails[8] forKey:PLU_CODE];
                //            [itemDic setValue:[NSNumber numberWithFloat:[[offerPriceArray objectAtIndex:i] floatValue]] forKey:ITEM_OFFER_PRICE];
                
                //calculate turn over disc value
                
                float turnOverDisc = 0.0;
                float fraction = 0;
                float itemPriceAfterDisc = ([[itemDic valueForKey:@"itemPrice"] floatValue] - [dealPriceArray[i] floatValue]);
                if (turnOverOfferVal > 0) {
                    
                    fraction = (itemPriceAfterDisc / totalPriceBeforeTurnOver);
                    turnOverDisc = (turnOverDisc * fraction);
                }
                
                //                NSString *turnOverDiscStr = [NSString stringWithFormat:@"%.2f",turnOverDisc];
                
                [itemDic setValue:@([dealPriceArray[i] floatValue]) forKey:@"discountPrice"];
                float dealOfferDiscount = 0;
                
                if ([dealPriceArray[i] floatValue] > 0) {
                    dealOfferDiscount = dealOfferDiscount + [dealPriceArray[i] floatValue];
                }
                
                [itemDic setValue:dealIdsArr[i] forKey:@"discountId"];
                [itemDic setValue:@"deal" forKey:@"discountType"];
                
                
                [itemArray addObject:itemDic];
                
            }
            
            if (offerPriceArray != nil && [offerPriceArray[i] floatValue] > 0) {
                
                [itemDic setValue:itemDetails[0] forKey:@"skuId"];
                [itemDic setValue:itemDetails[1] forKey:@"itemName"];
                //changed by Srinivasulu on 27/07/2017....
                //reason in with out offer it has to be calculated....
                
                float itemTotalPrice = [itemDetails[2] floatValue] ;
                
                [itemDic setValue:[NSString stringWithFormat:@"%.2f",(itemTotalPrice / [itemDetails[3] floatValue])] forKey:@"itemPrice"];
                
                //                float itemTotalPrice = ([[itemDetails objectAtIndex:2] floatValue] - ([[offerPriceArray objectAtIndex:i] floatValue] + [[dealPriceArray objectAtIndex:i] floatValue]));
                //                //  [itemDic setValue:[NSString stringWithFormat:@"%.2f",itemTotalPrice] forKey:@"itemPrice"];
                //                if([[offerPriceArray objectAtIndex:i] floatValue] > 0){
                //                    [itemDic setValue:[NSString stringWithFormat:@"%.2f",(itemTotalPrice / [[itemDetails objectAtIndex:3] floatValue])] forKey:@"itemPrice"];
                //                }
                //                else {
                //                    [itemDic setValue:[NSString stringWithFormat:@"%.2f",([[itemDetails objectAtIndex:2] floatValue] / [[itemDetails objectAtIndex:3] floatValue])] forKey:@"itemPrice"];
                //                }
                
                //upto here on 27/07/2017....
                
                
                
                [itemDic setValue:itemDetails[8] forKey:PLU_CODE];
                
                float turnOverDisc = 0.0;
                float fraction = 0;
                float itemPriceAfterDisc = ([[itemDic valueForKey:@"itemPrice"] floatValue] - [dealPriceArray[i] floatValue]);
                if (turnOverOfferVal > 0) {
                    
                    fraction = (itemPriceAfterDisc / totalPriceBeforeTurnOver);
                    turnOverDisc = (turnOverDisc * fraction);
                }
                
                //                NSString *turnOverDiscStr = [NSString stringWithFormat:@"%.2f",turnOverDisc];
                
                [itemDic setValue:@([offerPriceArray[i] floatValue]) forKey:@"discountPrice"];
                //            [itemDic setValue:[NSNumber numberWithFloat:[[dealPriceArray objectAtIndex:i] floatValue]] forKey:ITEM_DEAL_PRICE];
                //            float dealOfferDiscount = 0;
                //            if ([[offerPriceArray objectAtIndex:i] floatValue] > 0) {
                //                dealOfferDiscount += [[offerPriceArray objectAtIndex:i] floatValue];
                //            }
                //            if ([[dealPriceArray objectAtIndex:i] floatValue] > 0) {
                //                dealOfferDiscount += [[dealPriceArray objectAtIndex:i] floatValue];
                //            }
                
                [itemDic setValue:offerIdsArr[i] forKey:@"discountId"];
                [itemDic setValue:@"offer" forKey:@"discountType"];
                
                [itemArray addObject:itemDic];
                
            }
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    return itemArray;
}


+ (NSMutableArray *)getBillingItemsTaxDetails:(NSMutableArray *)itemArray taxArr:(NSMutableArray *)taxArr currentDate:(NSString *)currentDate offerPriceArray:(NSMutableArray *)offerPriceArray dealPriceArray:(NSMutableArray *)dealPriceArray{
    NSMutableArray *taxDetails = [NSMutableArray new];
    int taxPosition = 0;
    for (int i = 0; i < itemArray.count; i++) {
        NSMutableDictionary *itemDic = itemArray[i];
        NSMutableDictionary *taxDic = [NSMutableDictionary new];
        
        //changed by Srinivasulu on30/06/2017....
        
        float itemTotalPrice = [[itemDic valueForKey:@"item_total_price"] floatValue];
        float itemUnitPrice = [[itemDic valueForKey:@"itemUnitPrice"] floatValue];
        //upto here on 30/06/2017....
        
        
        
        //added and changed by Srinivasulu on 27/09/2017 &&  07/03/2018....
        
        Boolean isMrpRangeChecking = false;
        
        if (([itemDic.allKeys containsObject:TAXATION_ON_DISCOUNT_PRICE] && ![itemDic[TAXATION_ON_DISCOUNT_PRICE] isKindOfClass:[NSNull class]]))
            isMrpRangeChecking = [[itemDic valueForKey:TAXATION_ON_DISCOUNT_PRICE] boolValue];
        
//        if([discCalcOn length] > 0 && [discCalcOn caseInsensitiveCompare:@"Original Price"] == NSOrderedSame){
        if(discCalcOn.length > 0 && [discCalcOn caseInsensitiveCompare:@"Original Price"] == NSOrderedSame){

            itemTotalPrice =  itemUnitPrice *  [[itemDic valueForKey:QUANTITY] floatValue];
        }
        else if(([itemDic.allKeys containsObject:SALE_PRICE] && (![[itemDic valueForKey:SALE_PRICE]  isKindOfClass:[NSNull class]]))  &&  (isMrpRangeChecking)){
            
            itemUnitPrice = [[itemDic valueForKey:SALE_PRICE] floatValue];
        }
        
        //upto here on 27/09/2017  &&  07/03/2018....
        
        
        NSString *taxName = [itemDic valueForKey:TAX_CODE];
        if (!([[itemDic valueForKey:STATUS] isEqualToString:@"void"])) {
            NSArray *taxDetailsArr = taxArr[taxPosition];
            float taxValue = 0.0f;
            NSString *taxCategory = @"";
            for (NSDictionary *taxDic in taxDetailsArr) {
                
                //changed by Srinivasulu on 08/06/2017....
                
                //added by Srinivasulu on 28/06/2017....
                
                //                    if([offerPriceArray count] > i)
                //                        itemTotalPrice -= [[offerPriceArray objectAtIndex:i] floatValue];
                //
                //                    if([dealPriceArray count] > i)
                //                        itemTotalPrice -= [[dealPriceArray objectAtIndex:i] floatValue];
                
                //reducing deal amount....
                //                itemTotalPrice -= [[itemDic valueForKey:ITEM_DEAL_PRICE] floatValue];
                
                //reducing offer amount....
                //                itemTotalPrice -= [[itemDic valueForKey:ITEM_OFFER_PRICE] floatValue];
                
                //reducing manual discount amount....
                //                itemTotalPrice -= [[itemDic valueForKey:ITEM_DISCOUNT] floatValue];
                
                //upto here on 30/06/2017....
                
                
                float taxRateValue = [[taxDic valueForKey:@"taxRate"] floatValue];
                
                for(NSDictionary * saleRangeListDic in [taxDic valueForKey:SALE_RANGES_LIST]) {
                    
                    if( ([[saleRangeListDic valueForKey:SALE_VALUE_FROM] floatValue] <= itemUnitPrice) && ( itemUnitPrice <= [[saleRangeListDic valueForKey:SALE_VALUE_TO] floatValue])){
                        
                        taxRateValue = [[saleRangeListDic valueForKey:@"taxRate"] floatValue];
                        break;
                    }
                }
                
                //upto here on 28/06/2017....
                
                //changed by Srinivasulu on 12/07/2017....
                
                //                if ([discTaxation length] > 0 && [discTaxation caseInsensitiveCompare:@"Inclusive"] == NSOrderedSame) {
                
                if ([[itemDic valueForKey:TAX_INCLUSIVE] integerValue]) {
                    
                    //upto here on 12/07/2017....
                    
                    if([[taxDic valueForKey:@"taxType"] caseInsensitiveCompare:@"Percentage"] == NSOrderedSame){
                        
                        //need to be changed written on 23/11/2017....
                        //                        taxValue += (itemTotalPrice - (itemTotalPrice/(100 + taxRateValue * 2) * 100)) / 2;
                        taxValue += (itemTotalPrice - ((itemTotalPrice/(100 + taxRateValue * 2)) * 100)) / 2;
                        
                        //upto here on 23/11/2017....
                    }
                    else{
                        
                        taxValue += taxRateValue * [[itemDic valueForKey:@"quantity"] floatValue];
                    }
                }
                //                        else if ([discTaxation length] > 0 && [discTaxation caseInsensitiveCompare:@"Exclusive"] == NSOrderedSame) {
                else{
                    if([[taxDic valueForKey:@"taxType"] caseInsensitiveCompare:@"Percentage"] == NSOrderedSame){
                        
                        taxValue +=   ((itemTotalPrice * taxRateValue )/100);
                        
                    }
                    else{
                        
                        taxValue += taxRateValue * [[itemDic valueForKey:@"quantity"] floatValue];
                    }
                }
                
                //upto here on 08/06/2017....
   
                taxCategory = [taxDic valueForKey:@"taxCategory"];
            }
            if (taxDetails.count == 0) {
                [taxDic setValue:[NSString stringWithFormat:@"%.2f",taxValue] forKey:TAX_AMOUNT];
                [taxDic setValue:currentDate forKey:@"bill_date"];
                [taxDic setValue:taxName forKey:TAX_NAME];
                [taxDic setValue:taxCategory forKey:@"taxCategory"];
                
                //added by Srinivasulu on 17/03/2018....
                if (([itemDic.allKeys containsObject:ITEM_NUMBER_IN_LIST] && ![itemDic[ITEM_NUMBER_IN_LIST] isKindOfClass:[NSNull class]])) {

                    [taxDic setValue:itemDic[ITEM_NUMBER_IN_LIST] forKey:ITEM_NUMBER_IN_LIST];
                }
                //upto here on 17/03/2018....

                [taxDetails addObject:taxDic];
            }
            else {
                BOOL existingStatus = FALSE;
                int changePosition;
                NSMutableDictionary *existTaxDic = [NSMutableDictionary new];
                for (int j = 0; j < taxDetails.count; j++) {
                    NSDictionary *existingTaxDic = taxDetails[j];
                    NSArray*existingTaxDetails = existingTaxDic.allValues;
                    if ([existingTaxDetails containsObject:taxName]) {
                        existingStatus = TRUE;
                        existTaxDic = [existingTaxDic mutableCopy];
                        changePosition = j;
                    }
                }
                if (existingStatus) {
                    float taxAmount = [[existTaxDic valueForKey:TAX_AMOUNT] floatValue];
                    [existTaxDic setValue:[NSString stringWithFormat:@"%.2f",(taxAmount + taxValue)] forKey:TAX_AMOUNT];
                    taxDetails[changePosition] = existTaxDic;
                }
                else {
                    NSMutableDictionary *taxDic = [NSMutableDictionary new];
                    [taxDic setValue:[NSString stringWithFormat:@"%.2f",taxValue] forKey:TAX_AMOUNT];
                    [taxDic setValue:currentDate forKey:@"bill_date"];
                    [taxDic setValue:taxName forKey:TAX_NAME];
                    [taxDic setValue:taxCategory forKey:@"taxCategory"];
                    
                    //added by Srinivasulu on 17/03/2018....
                    if (([itemDic.allKeys containsObject:ITEM_NUMBER_IN_LIST] && ![itemDic[ITEM_NUMBER_IN_LIST] isKindOfClass:[NSNull class]])) {
                        
                        [taxDic setValue:itemDic[ITEM_NUMBER_IN_LIST] forKey:ITEM_NUMBER_IN_LIST];
                    }
                    //upto here on 17/03/2018....
                    
                    [taxDetails  addObject:taxDic];
                }
                
            }
            taxPosition++;
        }
    }
    return taxDetails;
}

+(NSMutableArray *)getBillingItemTaxes:(NSMutableArray *)itemArray taxArr:(NSMutableArray *)taxArr {
    NSMutableArray *billTaxDetails = [NSMutableArray new];
    int taxPosition = 0;
    
    for (int i = 0; i < itemArray.count; i++) {
        NSMutableDictionary *itemDic = itemArray[i];
        if (!([[itemDic valueForKey:STATUS] isEqualToString:@"void"])) {
            NSArray *taxDetailsArr = taxArr[taxPosition];
            
            float itemTotalPrice = [[itemDic valueForKey:@"item_total_price"] floatValue];
            float itemUnitPrice = [[itemDic valueForKey:@"itemUnitPrice"] floatValue];
            
            //added and changed by Srinivasulu on 27/09/2017 &&  07/03/2018....
            
            Boolean isMrpRangeChecking = false;
            
            if (([itemDic.allKeys containsObject:TAXATION_ON_DISCOUNT_PRICE] && ![itemDic[TAXATION_ON_DISCOUNT_PRICE] isKindOfClass:[NSNull class]]))
                isMrpRangeChecking = [[itemDic valueForKey:TAXATION_ON_DISCOUNT_PRICE] boolValue];
            
            //        if([discCalcOn length] > 0 && [discCalcOn caseInsensitiveCompare:@"Original Price"] == NSOrderedSame){
            if(discCalcOn.length > 0 && [discCalcOn caseInsensitiveCompare:@"Original Price"] == NSOrderedSame){
                
                itemTotalPrice =  itemUnitPrice *  [[itemDic valueForKey:QUANTITY] floatValue];
            }
//            else if([[itemDic allKeys] containsObject:SALE_PRICE] && (![[itemDic valueForKey:SALE_PRICE]  isKindOfClass:[NSNull class]])){
            else if( ([itemDic.allKeys containsObject:SALE_PRICE] && (![[itemDic valueForKey:SALE_PRICE]  isKindOfClass:[NSNull class]]))  && (isMrpRangeChecking)){

                
                itemUnitPrice = [[itemDic valueForKey:SALE_PRICE] floatValue];
            }
            
            //upto here on 27/09/2017 &&  07/03/2018....
            
            
            //added by Srinivasulu on 25/09/2017....
            
            //            float itemSalePrice =  [[itemDic valueForKey:ITEM_TOTAL_PRICE] floatValue] /  [[itemDic valueForKey:QUANTITY] floatValue];
            //
            //            [itemDic setValue:[NSString stringWithFormat:@"%.2f",itemSalePrice] forKey:SALE_PRICE];
            
            
            //upto here on 25/09/2017....
            
            //reducing manual discount amount....
            //            itemTotalPrice -= [[itemDic valueForKey:ITEM_DISCOUNT] floatValue];
            
            //reducing deal amount....
            //            itemTotalPrice -= [[itemDic valueForKey:ITEM_DEAL_PRICE] floatValue];
            
            //reducing offer amount....
            //            itemTotalPrice -= [[itemDic valueForKey:ITEM_OFFER_PRICE] floatValue];
            
            
            
            
            for (NSDictionary *taxDic in taxDetailsArr) {
                
                
                
                //added by Srinivasulu on 28/06/2017....
                float taxValue = 0;
                
                float taxRateValue = [[taxDic valueForKey:@"taxRate"] floatValue];
                
                for(NSDictionary * saleRangeListDic in [taxDic valueForKey:SALE_RANGES_LIST]) {
                    
                    
                    if( ([[saleRangeListDic valueForKey:SALE_VALUE_FROM] floatValue] <= itemUnitPrice) && ( itemUnitPrice <= [[saleRangeListDic valueForKey:SALE_VALUE_TO] floatValue])){
                        
                        taxRateValue = [[saleRangeListDic valueForKey:@"taxRate"] floatValue];
                        break;
                    }
                    
                }
                
                //changed by Srinivasulu on 12/07/2017....
                
                //                if ([discTaxation length] > 0 && [discTaxation caseInsensitiveCompare:@"Inclusive"] == NSOrderedSame) {
                
                if ([[itemDic valueForKey:TAX_INCLUSIVE] integerValue]) {
                    
                    //upto here on 12/07/2017....
                    
                    if([[taxDic valueForKey:@"taxType"] caseInsensitiveCompare:@"Percentage"] == NSOrderedSame){
                        
                        taxValue += (itemTotalPrice -(itemTotalPrice/(100 + taxRateValue * 2)*100)) / 2;
                    }
                    else{
                        
                        taxValue += taxRateValue * [[itemDic valueForKey:@"quantity"] floatValue];
                    }
                }
                
                //                        else if ([discTaxation length] > 0 && [discTaxation caseInsensitiveCompare:@"Exclusive"] == NSOrderedSame) {
                else{
                    if([[taxDic valueForKey:@"taxType"] caseInsensitiveCompare:@"Percentage"] == NSOrderedSame){
                        
                        taxValue +=   ((itemTotalPrice * taxRateValue )/100);
                        
                    }
                    else{
                        
                        taxValue += taxRateValue * [[itemDic valueForKey:@"quantity"] floatValue];
                        
                    }
                    
                }
                
                
                
                //upto here on 28/06/2017....
                
                
                
                NSMutableDictionary *billTaxDic = [NSMutableDictionary new];
                [billTaxDic setValue:[itemDic valueForKey:@"sku_id"] forKey:@"sku_id"];
                [billTaxDic setValue:[itemDic valueForKey:PLU_CODE] forKey:@"plu_code"];
                [billTaxDic setValue:[taxDic valueForKey:@"taxCategory"] forKey:@"tax_category"];
                [billTaxDic setValue:[taxDic valueForKey:@"taxCode"] forKey:@"tax_code"];
                [billTaxDic setValue:[taxDic valueForKey:@"taxType"] forKey:@"tax_type"];
                
                
                //added by Srinivasulu on 17/03/2018....
                if (([itemDic.allKeys containsObject:ITEM_NUMBER_IN_LIST] && ![itemDic[ITEM_NUMBER_IN_LIST] isKindOfClass:[NSNull class]])) {
                    
                    [billTaxDic setValue:itemDic[ITEM_NUMBER_IN_LIST] forKey:ITEM_NUMBER_IN_LIST];
                }
                //upto here on 17/03/2018....
                
                
                //changed by Srinivasulu on 28/06/2017....taxRateValue
                //                [billTaxDic setValue:[taxDic valueForKey:@"taxRate"] forKey:@"tax_rate"];
                [billTaxDic setValue:[NSString stringWithFormat:@"%.2f",taxRateValue] forKey:@"tax_rate"];
                
                //                [billTaxDic setValue:[taxDic valueForKey:@"0.0"] forKey:@"tax_value"];
                [billTaxDic setValue:[NSString stringWithFormat:@"%.2f",taxValue] forKey:@"tax_value"];
                
                
                
                //upto here on 28/06/2017....
                
                [billTaxDetails addObject:billTaxDic];
            }
            taxPosition++;
        }
    }
    
    return billTaxDetails;
}

+ (NSString *)getServiceURL {
    
    NSString *  urlTypeStr = [NSString stringWithFormat:@"%@%@",serviceURLTypeStr,@"://"];
    return [NSString stringWithFormat:@"%@%@%@%@%@",urlTypeStr,host_name,@":",port_no,@"/OmniRetailerServices/"];
}
+(NSString *)getCurrentDate {
    NSDate *today = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"dd/MM/yyyy HH:mm:ss";
    NSString* currentdate = [f stringFromDate:today];
    
    return currentdate;
}

+ (NSString *)addDays:(NSInteger)days toDate:(NSDate *)originalDate {
    NSDateComponents *components= [[NSDateComponents alloc] init];
    components.day = days;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"dd/MM/yyyy";
    NSString* bussiness_date = [f stringFromDate:[calendar dateByAddingComponents:components toDate:originalDate options:0]];
    
    return bussiness_date;
}
+ (NSString *)addDaysToEndDate:(NSInteger)days toDate:(NSDate *)originalDate {
    NSDateComponents *components= [[NSDateComponents alloc] init];
    components.day = days;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    f.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString* endDate = [f stringFromDate:[calendar dateByAddingComponents:components toDate:originalDate options:0]];
    
    return endDate;
}

+ (NSString *)updateBussinessDate {
    NSDate *today = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"dd/MM/yyyy";
    NSString* bussinessDate = [f stringFromDate:today];
    
    return bussinessDate;
}

+ (NSString *)getStoreAddress {
    //    NSString *storeAddress = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",@"VISHAL MEGA MART\n",@"(A Franchise Store Operated by Airplaza\n",@"Retail Holdings Pvt. Ltd.)\n",@"Khasara No.-735,L-10,Maharauli Road\n", @"Mahipalpur,New Delhi-110037\n",@"Tin : 7940388149, Mob : 9311132804\n\n",@"--------------------------------------------\n"];
    
    //changed by Srinivasulu on 12/05/2017....
    
    //   NSString *storeAddress = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",@"SAHYADRI AGRO RETAILS LTD.\n",@"RADHA KRISHNA COMPLEX\n",@"SHOP NO 28,PLOT NO - 29,\n", @"SECTOR 11,KHARGHAR,NAVI MUMBAI\n",@"Mumbai,Maharashtra,410210\n",@"#########IN-27741717\n",@"#########VAT:27380827952V\n",@"#############Invoice\n",@"--------------------------------------------\n"];
    
    //    NSString * storeAddress = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",@"SAHYADRI AGRO RETAILS LTD.\n",@"RADHA KRISHNA COMPLEX\n",@"SHOP NO 28,PLOT NO - 29,\n", @"SECTOR 11,KHARGHAR,NAVI MUMBAI\n",@"Mumbai,Maharashtra,410210\n",@"#########IN-27741717\n",@"#########VAT:27331105033V\n",@"#############Invoice\n",@"--------------------------------------------\n"];
    
    
    //    NSString *storeAddress = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",@"D-CHAMELEON\n",@"Jubliee Hills",@"Road No 36,",@"Hyderabad\n",@"Telangana,500033\n",@"#########IN-27741717\n",@"#########VAT:\n",@"#############Invoice\n",@"--------------------------------------------\n"];
    //upto here on 12/05/2017....
    
    //    NSString *storeAddress = [NSString stringWithFormat:@"%@%@%@%@%@%@",@"###########Sampoorna SuperMarket\n",@"#####Aparna Aura,",@"Shaikpet,#Hyderabad\n",@"#############Telangana -500008\n",@"############Ph#:+91 97059 73777\n\n",@"--------------------------------------------\n"];
    
    //    StoreAddressStr = [StoreAddressStr uppercaseString];
    
    return StoreAddressStr;
}

+(NSString*)getFooter {
    
    
    NSString * footer = [NSString stringWithFormat:@"%@%@%@%@%@",@"########Thank You.Visit Again.\n",@"########Inclusive of all taxes\n",@"########Toll Free##\n",@"########BeTheChange.KnowYourFood\n",@""];
    
    
    
    if(outletTollFreeNumberStr.length > 0){
        
        footer = [NSString stringWithFormat:@"%@%@%@%@%@%@",@"########Thank You.Visit Again.\n",@"########Inclusive of all taxes\n",@"########Toll Free##",outletTollFreeNumberStr,@"\n########BeTheChange.KnowYourFood\n",@""];
    }
    
    
    if ([custID caseInsensitiveCompare:@"CID8995450"] == NSOrderedSame){
        
        footer = [NSString stringWithFormat:@"%@%@%@%@%@%@",@"########Thank You.Visit Again.\n",@"########Inclusive of all taxes\n",@"########Toll Free##",outletTollFreeNumberStr,@"\n########No Exchange and No Refund\n########www.globusfashion.com\n",@""];
        
        if(outletTollFreeNumberStr.length > 0){
            
            footer = [NSString stringWithFormat:@"%@%@%@%@%@%@",@"########Thank You.Visit Again.\n",@"########Inclusive of all taxes\n",@"########Toll Free##",outletTollFreeNumberStr,@"\n########No Exchange and No Refund\n########www.globusfashion.com\n",@""];
        }
        
    }
    
    
    //upto here on 30/05/2017....
    
    
    return footer;
}

+(void)setFontFamily:(NSString*)fontFamily forView:(UIView*)view andSubViews:(BOOL)isSubViews fontSize:(float)fontSize cornerRadius:(float)cornerRadius
{
    if ([view isKindOfClass:[UILabel class]])
    {
        UILabel *label = (UILabel *)view;
        label.font = [UIFont fontWithName:fontFamily size:fontSize];
    }
    if ([view isKindOfClass:[UITextField class]])
    {
        UITextField *lbl = (UITextField *)view;
        lbl.font = [UIFont fontWithName:fontFamily size:fontSize];
        //        lbl.layer.cornerRadius = cornerRadius;
    }
    
    if (isSubViews)
    {
        for (UIView *sview in view.subviews)
        {
            [self setFontFamily:fontFamily forView:sview andSubViews:YES fontSize:fontSize cornerRadius:cornerRadius];
        }
    }
}

+ (BOOL)checkEditPriceEnabled {
    
    BOOL priceStatus = FALSE;
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"Config"
                                                         ofType:@"xml"];
    
    NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData
                                                           options:0 error:&error];
    
    NSArray *ele=[doc.rootElement elementsForName:@"edit-price"];
    
    for (GDataXMLElement *partyMember in ele) {
        NSArray *days = [partyMember elementsForName:@"enable"];
        GDataXMLElement *editPriceStatus = (GDataXMLElement *) days[0];
        priceStatus = (editPriceStatus.stringValue).boolValue;
    }
    return priceStatus;
}

+(NSDate *) dateFromString:(NSString *) dateInString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.dateFormat = @"yyyy-mm-dd";
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    
    dateFormatter.locale = [NSLocale currentLocale];
    
    NSDate *dateFromString = [dateFormatter dateFromString:dateInString];
    
    
    return dateFromString;
}


+ (BOOL)checkDateValidity:(NSString *)startDate secondDate:(NSString *)endDate {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    if ([startDate containsString:@"."]) {
        startDate = [startDate componentsSeparatedByString:@"."][0];
    }
    if ([endDate containsString:@"."]) {
        endDate = [endDate componentsSeparatedByString:@"."][0];
    }
    NSDate *startString = [formatter dateFromString:startDate];
    NSDate *endString = [formatter dateFromString:endDate];
    endString = [formatter dateFromString:[self addDaysToEndDate:1 toDate:endString]];
    NSDate* todayDateWithTime = [self getExactTodayDateandTime];
    
    if (([todayDateWithTime compare:startString] == NSOrderedDescending || [todayDateWithTime compare:startString] == NSOrderedSame) && ([todayDateWithTime compare:endString] == NSOrderedAscending || [todayDateWithTime compare:endString] == NSOrderedSame)) {
        return TRUE;
    }
    else {
        return FALSE;
    }
}

+(NSDate *)getExactTodayDateandTime {
    NSDate* sourceDate = [NSDate date];
    
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
    NSDate* today = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
    return today;
}

+ (BOOL)checkIsCardPayment:(UIView *)cardView {
    for (UILabel *viewLbl in cardView.subviews) {
        if ([viewLbl isKindOfClass:[UILabel class]]) {
            if ([viewLbl.text isEqualToString:@"POS"]) {
                return TRUE;
            }
        }
    }
    return FALSE;
}

/**
 * @description  here we are forming the billing items list....
 * @date
 * @method       numberOfDaysDifference:--
 * @author
 * @param
 * @param        NSDate
 *
 * @return       NSInteger
 *
 * @modified By  Srinivasulu on 06/10/2017....
 * @reason       replaced the NSGregorianCalander && NSDayCalendarUnit -- with --  NSCalendarIdentifierGregorian && NSCalendarUnitDay
 *
 * @verified By
 * @verified On
 *
 */

+ (NSInteger)numberOfDaysDifference:(NSDate *)aDate {
    
    //    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendar * gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDate * today = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd/MM/yyyy";
    NSString* currentdate = [formatter stringFromDate:today];
    NSDateFormatter * formatter1 = [[NSDateFormatter alloc] init];
    formatter1.dateFormat = @"dd/MM/yyyy";
    
    //    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit fromDate:[formatter1 dateFromString:currentdate] toDate:aDate options:0];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay fromDate:[formatter1 dateFromString:currentdate] toDate:aDate options:0];
    
    //changed by Srinivasulu on 18/10/2017....
    //reason we need only difference in positive....
    
    //    return [components day];
    return ABS([components day]);
    
    //upto here on 18/10/2017....
    
}

+ (int)calculateNumberOfSecondsfor:(NSString *)startDate and:(NSString *)endDate {
    
    NSDateFormatter *startDateFormatter = [[NSDateFormatter alloc] init];
    startDateFormatter.dateFormat = @"dd/MM/yyyy HH:mm:ss";
    NSDate *newStartDate = [startDateFormatter dateFromString:startDate];
    
    NSDateFormatter *endDateFormatter = [[NSDateFormatter alloc] init];
    endDateFormatter.dateFormat = @"dd/MM/yyyy HH:mm:ss";
    NSDate *endStartDate = [endDateFormatter dateFromString:endDate];
    
    NSTimeInterval secondsBetweenDates = [endStartDate timeIntervalSinceDate:newStartDate];
    
    return (int)secondsBetweenDates;
}

+(int)getTodayWeekDayNumber {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    int weekday = (int)comps.weekday;
    return weekday;
}

+(BOOL)checkOfferAvailabilityBetween:(NSString *)startTime endTime:(NSString *)endTime{
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:[NSDate date]];
    NSInteger currHr = components.hour;
    NSInteger currtMin = components.minute;
    
    
    int stHr = [startTime componentsSeparatedByString:@":"][0].intValue;
    int stMin = [startTime componentsSeparatedByString:@":"][1].intValue;
    int enHr = [endTime componentsSeparatedByString:@":"][0].intValue;
    int enMin = [endTime componentsSeparatedByString:@":"][1].intValue;
    
    int formStTime = (stHr*60)+stMin;
    int formEnTime = (enHr*60)+enMin;
    
    int nowTime = (int)((currHr*60)+currtMin);
    
    if(nowTime >= formStTime && nowTime <= formEnTime) {
        return YES;
    }
    else{
        return NO;
    }
    
}

- (BOOL) enforceDeals :(NSMutableDictionary *)enforceDealDic{
    @try {
        
        NSMutableArray *availableDeals = [enforceDealDic valueForKey:@"availableDeals"];
        NSMutableArray *mProductStatusArrayList = [enforceDealDic valueForKey:@"mProductStatusArrayList"];
        NSMutableArray *mProductSkuIdArrayList = [enforceDealDic valueForKey:@"mProductSkuIdArrayList"];
        NSMutableArray *mProductIndividualQtyArrayList = [enforceDealDic valueForKey:@"mProductIndividualQtyArrayList"];
        NSMutableArray *dealDiscount = [enforceDealDic valueForKey:@"dealDiscount"];
        float total = [[enforceDealDic valueForKey:@"totalBill"] floatValue];
        float toGiveDealQuantity = [[enforceDealDic valueForKey:@"toGiveDealQuantity"] floatValue];
        for (int p = 0; p < availableDeals.count; p++) {
            
            if ([mProductStatusArrayList[p] containsString:@"void"]) {
                continue;
            } else {
                BOOL turnOverTest = false;
                for (NSMutableArray *applyDealList in availableDeals) {
                    for (int i = 0; i < applyDealList.count; i++) {
                        DealModel *applyDeal = applyDealList[i];
                        if ([(applyDeal.dealCategory).lowercaseString containsString:@"turn_over"]) {
                            DealRangesModel *dealRangeModel = (applyDeal.rangesList)[0];
                            if (dealRangeModel.minimumPurchaseamount_float <= total) {
                                turnOverTest = true;
                                
                                if (![mProductSkuIdArrayList containsObject:[applyDeal.dealSkus substringWithRange:NSMakeRange(0, (applyDeal.dealSkus).length - 1)]]) {
                                    
                                    turnOverFreeItem = applyDeal.dealSkus;
                                    unAppliedDealId = -1;
                                    return false;
                                } else if (
                                           [mProductIndividualQtyArrayList[[mProductSkuIdArrayList indexOfObject:[applyDeal.dealSkus substringWithRange:NSMakeRange(0, applyDeal.dealSkus.length - 1)]]] floatValue] < toGiveDealQuantity) {
                                    turnOverFreeItem = applyDeal. dealSkus ;
                                    unAppliedDealId = -1;
                                    return false;
                                } else {
                                    break;
                                }
                                
                            }
                        }
                        continue;
                    }
                    if ([dealDiscount[p] floatValue] > 0) {
                        continue;
                    } else if (!turnOverTest) {
                        unAppliedDealId = p;
                        return false;
                    }
                    
                }
            }
        }
    } @catch (NSException *e) {
        // TODO Auto-generated catch block
        
    }
    return true;
}

+ (BOOL)checkWhetherItemSpecificItemContainsInCart:(NSMutableArray *)itemDiscountArr isVoidedArray:(NSMutableArray *)isVoidedArray {
    BOOL itemSpecificStatus = FALSE;
    @try {
        for (int i = 0; i < itemDiscountArr.count; i++) {
            if (![isVoidedArray[i] boolValue]) {
                if ([itemDiscountArr[i] floatValue] > 0) {
                    itemSpecificStatus = TRUE;
                    break;
                }
                else {
                    itemSpecificStatus = FALSE;
                }
            }
        }
        
    }
    @catch (NSException *exception) {
        
    }
    return itemSpecificStatus;
}

+ (NSMutableArray *)getMessagesFromPositon:(int)position fromArray:(NSMutableArray *)messageArray {
    
    @try {
        
        NSMutableArray *messagesArray = [NSMutableArray new];
        for (int i = (position * RECORDS_PER_PAGE); i < (RECORDS_PER_PAGE * (position +1)); i++) {
            @try {
                [messagesArray addObject:messageArray[i]];
                
            }
            @catch (NSException *exception) {
                return messagesArray;
            }
        }
        return messagesArray;
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

+ (int)getTotalNumberOfPages:(int)totalRecords {
    
    @try {
        float totalNumberOfPages = totalRecords / kRecordsPerPage;
        totalNumberOfPages = ceilf(totalNumberOfPages);
        return totalNumberOfPages;
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        
    }
}

/**
 * @description     check acess permissions at main flow
 * @date            1/7/16
 * @method          checkAcessControlForMain
 * @author          Sonali
 * @param           appFlow
 * @param           <#param#>
 * @return          <#return#>
 * @verified By     <#veridied by#>
 * @verified On     <#verified On#>
 * @modified On     <#modified On#>
 * @modified By     <#modified By#>
 * @modified reason  <#reason#>
 */


+(BOOL)checkAcessControlForMain:(NSString*)appFlow{
    
    
    @try {
        for (NSDictionary *dic in accessControlArr) {
            
            if (![[dic valueForKey:kAppFlow] isKindOfClass:[NSNull class]]) {
                
                if ([[dic valueForKey:kAppFlow] isEqualToString:appFlow]) {
                    
                    return true;
                }
            }
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    // Default should return false... but temperorly changed to true.
//    return false;
    return true;

}

/**
 * @description     check the acess permissions at  document level
 * @date            1/7/16
 * @method          checkAccessPermissionsFor
 * @author          Sonali
 * @param           appDoc
 * @param           subFlow
 * @return          mainFlow
 * @verified By     <#veridied by#>
 * @verified On     <#verified On#>
 * @modified On     <#modified On#>
 * @modified By     <#modified By#>
 * @modified reason  <#reason#>
 */


+(int)checkAccessPermissionsFor:(NSString*)appDoc subFlow:(NSString*)subFlow mainFlow:(NSString*)mainFlow{
    
    int accessval = 0;
    
    @try {
        for (NSDictionary *accessControlDic in accessControlArr) {

            if (![[accessControlDic valueForKey:kAppFlow] isKindOfClass:[NSNull class]] && ![[accessControlDic valueForKey:kAppSubFlow] isKindOfClass:[NSNull class]] && ![[accessControlDic valueForKey:kAppDocument] isKindOfClass:[NSNull class]]) {


                if ([[accessControlDic valueForKey:kAppFlow] caseInsensitiveCompare:mainFlow] == NSOrderedSame && [[accessControlDic valueForKey:kAppSubFlow] caseInsensitiveCompare:subFlow] == NSOrderedSame && [[accessControlDic valueForKey:kAppDocument] caseInsensitiveCompare:appDoc] == NSOrderedSame) {

                    if([[accessControlDic valueForKey:@"read"] boolValue]) {

                        accessval = kReadVal;
                    }
                    if ([[accessControlDic valueForKey:@"write"] boolValue]) {

                        if (accessval == kReadVal) {

                            accessval = kReadWrite;
                            return accessval;
                        }
                        else {
                            accessval = kWriteVal;
                            return accessval;
                        }
                    }
                    else if(![[accessControlDic valueForKey:@"read"] boolValue] && ![[accessControlDic valueForKey:@"write"] boolValue]) {

                        accessval = kAcessDenied;
                    }
                }
            }
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        // changing the accessval to kReadWrite for temporary purpose.
        accessval = kReadWrite;
        
    }
    
    return accessval;
}

+(int)checkAccessibilityFor:(NSString*)activity appDocument:(NSString*)appDocument {
    
    int accessval = 0;
    
    @try {
        for (NSDictionary *accessControlDic in accessControlActivityArr) {
            
            if (![[accessControlDic valueForKey:kAppDocument] isKindOfClass:[NSNull class]] && ![[accessControlDic valueForKey:kAppDocActivity] isKindOfClass:[NSNull class]]) {
                
                
                if (([[accessControlDic valueForKey:kAppDocument] caseInsensitiveCompare:appDocument] == NSOrderedSame) && ([[accessControlDic valueForKey:kAppDocActivity] caseInsensitiveCompare:activity] == NSOrderedSame)) {
                    
                    if([[accessControlDic valueForKey:kActivityRead] boolValue]) {
                        
                        accessval = kReadVal;
                    }
                    if ([[accessControlDic valueForKey:kActivityWrite] boolValue]) {
                        
                        if (accessval == kReadVal) {
                            
                            accessval = kReadWrite;
                            return accessval;
                        }
                        else {
                            accessval = kWriteVal;
                            return accessval;
                        }
                    }
                    else if(![[accessControlDic valueForKey:kActivityRead] boolValue] && ![[accessControlDic valueForKey:kActivityWrite] boolValue]) {
                        
                        accessval = kAcessDenied;
                    }
                    
                }
            }
            
        }
        
    }
    @catch (NSException *exception) {
        
        
    }
    @finally {
        
    }
    
    
    
    return accessval;
}

/**
 * @description
 * @date         07/05/2017....
 * @method       getLogoImage
 * @author       Srinivasulu
 * @param        UIImage
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

+ (UIImage *)getLogoImage{
    
    UIImage * logoImg;
    
    @try {
        
        
        //this is for Sampoora.....
        //logoImg = [UIImage imageNamed:@"sampoorna.jpg"];
        
        
        //this for Sahyadri.... Customer Id -- 52
        logoImg = [UIImage imageNamed:@"sahyadri_logo.png"];
        
        
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        return logoImg;
    }
    
}


+(NSString *)getPreviousDate:(double)timeInterval{
    
    NSString * previousDateStr = @"";
    
    @try {
        
        // Right now, you can remove the seconds into the day if you want
        NSDate *today = [NSDate date];
        
        // All intervals taken from Google
        NSDate * previousDate = [today dateByAddingTimeInterval: -timeInterval];
        
        NSDateFormatter * requeiredDateFormat = [[NSDateFormatter alloc] init];
        requeiredDateFormat.dateFormat = @"dd/MM/yyyy";
        previousDateStr = [requeiredDateFormat stringFromDate:previousDate];
    } @catch (NSException *exception) {
        
    } @finally {
        
        return  previousDateStr;
    }
    
}

// added by roja on 09/01/2019

+(id)getPropertyFromProperties:(NSString*)key {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Configurations" ofType:@"plist"];
    NSDictionary *properties = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    return [properties valueForKey:key];
    
}

+(CGRect)setTableViewheightOfTable :(UITableView *)tableView ByArrayName:(NSArray *)array{
    
    
    CGFloat height = tableView.rowHeight;
    height *= array.count;
    
    CGRect tableFrame = tableView.frame;
    tableFrame.size.height = height+10;
    return tableFrame;
}

+(BOOL)validateEmail: (NSString *) email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+(UIColor *)UIColorFromNSString:(NSString*)string
{
    NSString *componentsString = [[string stringByReplacingOccurrencesOfString:@"[" withString:@""] stringByReplacingOccurrencesOfString:@"]" withString:@""];
    NSArray *components = [componentsString componentsSeparatedByString:@", "];
    return [UIColor colorWithRed:[(NSString*)components[0] floatValue]
                           green:[(NSString*)components[1] floatValue]
                            blue:[(NSString*)components[2] floatValue]
                           alpha:[(NSString*)components[3] floatValue]];
    
}




@end
