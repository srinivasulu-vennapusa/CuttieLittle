
//
//  OmniHomePage.m
//  OmniRetailer
//
//  Created by Satya Siva Saradhi on 05/10/12.
//  Copyright 2012 __techolabssoftware.com__. All rights reserved.
//

#import "OmniHomePage.h"
#import "OmniRetailerViewController.h"
#import "OmniRetailerAppDelegate.h"

#import "Configuration.h"
#import "BillingHome.h"
#import "WebViewController.h"
//#import "NormalStock.h"
#import "PastBilling.h"
#import "CurrentDeals.h"
#import "Offers.h"
#import "NewOrder.h"
//#import "PreviousOrder.h"
#import "OrderReports.h"
#import "SalesReports.h"
#import "CriticalStock.h"
#import "IssueLowyalty.h"
#import "ShowLowyalty.h"
#import "Global.h"
#import "SalesServiceSvc.h"
#import "GDataXMLNode.h"
#import "PendingBills.h"
#import "MaterialTransferReciepts.h"
#import "MaterialTransferIssue.h"
//#import "ReceiptGoodsProcurement.h"
#import "ViewOrders.h"
#import "StockVerification.h"
#import "CreatePurchaseOrder.h"
#import "EditLoyalty.h"
#import "CheckWifi.h"
#import "OfflineBillingServices.h"
#import "sqlite3.h"
#import "DataBaseConnection.h"
#import "CountersServiceSvc.h"
#import "SalesServiceSvc.h"
#import "DoorDeliveryBills.h"
#import "CustomerServiceSvc.h"
#import "RequestHeader.h"
#import "VerifiedStockReceipts.h"
#import "CompletedBills.h"
#import "ZReportController.h"
#import "ViewGoodsReturn.h"
#import "IssueGiftVoucher.h"
#import "ViewGiftVoucher.h"
#import "StockRequest.h"
#import "KeychainItemWrapper.h"
#import "IssueGiftCoupon.h"
#import "IssueGiftCouponFlow.h"
#import "ViewGiftCoupon.h"
#import "SalesPriceOverrideReport.h"
#import "ReturningCompletedBillItems.h"
#import "HourWiseReports.h"
#import "VoidItemsReport.h"
#import "SalemenCommissionReport.h"

#import "NewStockVerificationViewController.h"
#import "DepartmentWiseReport.h"
#import "ShipmentReturnSummary.h"
#import "OutBoundStockRequest.h"


#import "ExchangingBillingHome.h"

#import "DayStart.h"
#import "DayClosure.h"


#import "NewRestBooking.h"
#import "ServiceOrders.h"

#import "KitchenOrderToken.h"
#import "ServiceStaff.h"
#import "IssueLoyaltyCard.h"

@implementation OmniHomePage

@synthesize soundFileURLRef,soundFileObject;
@synthesize myAppDelegate;
@synthesize homeTable;
@synthesize prod_img_array;
@synthesize sub_prod1_array;
@synthesize sub_prod2_array;

//@synthesize hideDelegate;

//below one is added by Srinivasulu on 29/01/2019....
//reason inorder to remove the warning && still is unused variable....
@synthesize popOver;



static sqlite3 *database = nil;
//static sqlite3_stmt *insertStmt = nil;
static sqlite3_stmt *deleteStmt = nil;
static sqlite3_stmt *selectStmt = nil;

int skuStartIndex = 0;
int skuEanIndex = 0;
int totalRecords = 0;
int skuPriceStartIndex = 0;
int totalPriceRecords = 0;
int employeeStartIndex = 0;
int denominationStartIndex = 0;
int categoryStartIndex = 0;
int subCategoryStartIndex = 0;
int productStartIndex = 0;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


//- (void)dealloc
//{
//
//    [super dealloc];
//
//    [cellView release];
//    [homeTable release];
//    [prod_img_array release];
//    [sub_prod1_array release];
//    [sub_prod2_array release];
//    [segmentedControl release];
//
//    [subModuleArry1 release];
//    [subModuleArry2 release];
//}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
    
    prod_img_array  = nil;
    sub_prod1_array = nil;
    sub_prod2_array = nil;
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    //    selectStmt = nil;
    //    deleteStmt = nil;
    //    sqlite3_close(database);
    
    // Release any cached data, images, etc that aren't in use.
}


- (void) logOut {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    
    
    //added by Srinivasulu on 29/04/2017....
    
    firstName = @"";
    presentLocation = @"";
    //upto here on 29/04/2017....
    
    
    OmniRetailerViewController *omniRetailerViewController;
    //exit(0);
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        omniRetailerViewController = [[OmniRetailerViewController alloc] init];
        
    }
    else {
        omniRetailerViewController =[[OmniRetailerViewController alloc]initWithNibName:@"OmniRetailerViewController-iPhone" bundle:nil];
        
    }
    barcodeFlag_exchbill = TRUE;
    barcodeFlag_pendingbill = TRUE;
    barcodeFlag_newbill = TRUE;
    
    myAppDelegate = (OmniRetailerAppDelegate*)[UIApplication sharedApplication].delegate;
    [myAppDelegate.appController pushViewController:omniRetailerViewController animated:YES];
    
}
-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (alertView == confirmation) {
        
        if (buttonIndex == 0) {
            
            
        }
        else {
            
            OmniRetailerViewController *omniRetailerViewController;
            //exit(0);
            if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
                omniRetailerViewController = [[OmniRetailerViewController alloc] init];
                
            }
            else {
                omniRetailerViewController =[[OmniRetailerViewController alloc]initWithNibName:@"OmniRetailerViewController-iPhone" bundle:nil];
                
            }
            myAppDelegate = (OmniRetailerAppDelegate*)[UIApplication sharedApplication].delegate;
            [myAppDelegate.appController pushViewController:omniRetailerViewController animated:YES];
        }
    }
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex_ {
    
    if (alertView == downloadConfirmationAlert) {
        
        if (buttonIndex_ == 0) {
            
            //added by Srinivasulu on 03/10/2017....
            //reason -- is view should be show in mainthread only....
            
            loadingView.hidden = NO;
            
            //upto here on 03/10/2017....
            
            [HUD setHidden:NO];
            [HUD show:YES];
            HUD.labelText = @"Downloading data\n Please wait...";
            // [self performSelectorInBackground:@selector(backGroundProcess) withObject:nil];
            
            //written by Srinivasulu on 03/10/2017....
            //reason -- this type of method  calling has to be stopped from my point of view.... because getting runtime warning will hidding and showing view related pages....
           
            [HUD showWhileExecuting:@selector(backGroundProcess) onTarget:self withObject:nil animated:true];
        }
        else {
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            syncStatus = false;
            
            //added by Srinivasulu on 15/12/2017....
            //                if([[self isThereAnyBillsToDelete] count]){
            //
            //                    offlineBillDeleteConfirmationAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"do_want_to_delete_offline_bills_?", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"yes", nil) otherButtonTitles:NSLocalizedString(@"no", nil), nil];
            //                    [offlineBillDeleteConfirmationAlert show];
            //                }
            //upto here on 15/12/2017....
        }
    }
    
    //added by Srinivasulu on 15/12/2017....
    else if(alertView == offlineBillDeleteConfirmationAlert){
        
        if (buttonIndex_ == 0) {
            
            @try {
                
                //                [HUD setHidden:NO];
                //
                //                for(NSString * billIdStr in [self isThereAnyBillsToDelete]){
                //
                //                    [self deleteCompleteBillInformationFromLocalDB:billIdStr];
                //                }
                
                [HUD setHidden:YES];
            } @catch (NSException *exception) {
                [HUD setHidden:YES];
                
            }
            
            
        }
        else{
            //            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        }
        
    }
    //upto here on 15/12/2017....
    
    else if (alertView == uploadConfirmationAlert)
    {
        if (buttonIndex_ == 0) {
            
            isOfflineService = false;
            
            CheckWifi *wifi = [[CheckWifi alloc] init];
            BOOL status = [wifi checkWifi];
            
            if (status && shiftId.length>0) {
                
                //changed by Srinivasulu on 06/09/2018...
//                [self synchCustomerDetails];
                OfflineBillingServices * offline = [[OfflineBillingServices alloc] init];
                [offline updateCustomerDetailsBasedOnStatus:1];
                
                
                //                    [self deleteUploadedBillsFromLocal];
                [self synchUpLocalBills];
                
                // added  by roja on 21/05/2019..
                [offline loyaltyCardUpdatingToOnlineDbBasedOnStatus:1];

                
                //  [self viewWillAppear:YES];
                //            [self performSelectorInBackground:@selector(synchCustomerDetails) withObject:nil];
            }
            
            
        }
        else {
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        }
    }
    //added  by Srinivasulu on 20/04/2017....
    else if(alertView == offlineModeAlert){
        
        [alertView dismissWithClickedButtonIndex:buttonIndex_ animated:YES];
        
        [self changeOperationMode:buttonIndex_];
        //[super alertView:alertView didDismissWithButtonIndex:buttonIndex_];
    }
    //upto here on 28/04/2017...
    
    //added by Srinivasulu on 18/10/2017....
    
    else if(alertView == zReportAlert){
        
        [self showCustomerWalkOutScreen];
    }
    
    //upto here on 18/10/2017....
    
}
#pragma mark - View lifecycle

/**
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date
 * @method       ViewDidLoad
 * @author
 * @param
 * @param
 *
 * @return
 *
 * @modified By Srinivasulu on 09/10/2017....
 * @reason      added the comments and     .... not completed....  need to delegate the unused code which is used before grid view implementation....
 *
 * @verified By
 * @verified On
 *
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isListView = true;
    
    //added by Srinivasulu on 27/04/2017....
    
    //    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 600.0, 45.0)];
    //    rightView.backgroundColor = [UIColor clearColor];
    //
    //    refreshBtn = [[UIButton alloc] initWithFrame:CGRectMake(320, 5, 45, 45)];
    //    [refreshBtn addTarget:self action:@selector(uploadLocalBills) forControlEvents:UIControlEventTouchUpInside];
    //    [refreshBtn setImage:[UIImage imageNamed:@"refresh-button-ico.png"] forState:UIControlStateNormal];
    //    [rightView addSubview:refreshBtn];
    //
    //
    //    UIImageView *wifiView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wifi_PNG12.png"]];
    //    wifiView.backgroundColor = [UIColor clearColor];
    //    wifiView.frame = CGRectMake(refreshBtn.frame.origin.x + refreshBtn.frame.size.width + 30, 5, 35, 35);
    //    [rightView addSubview:wifiView];
    //
    //
    //    modeSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(wifiView.frame.origin.x + wifiView.frame.size.width + 10, 8, 45, 45)];
    //    [modeSwitch addTarget:self action:@selector(changeWifiSwitchAction:) forControlEvents:UIControlEventValueChanged];
    //    [modeSwitch setOnTintColor:[UIColor colorWithRed:76.0/255.0 green:217.0/255.0 blue:100.0/255.0 alpha:1.0]];
    //    [modeSwitch setTintColor:[UIColor colorWithRed:76.0/255.0 green:217.0/255.0 blue:100.0/255.0 alpha:1.0]];
    //    [modeSwitch setOn:YES];
    //    [rightView addSubview:modeSwitch];
    //
    //
    //
    //    UIButton *navBackBtn = [[UIButton alloc] initWithFrame:CGRectMake(modeSwitch.frame.origin.x + modeSwitch.frame.size.width + 20, 5, 100, 45)];
    //    [navBackBtn setTitle:@"Logout" forState:UIControlStateNormal];
    //    [navBackBtn addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
    //    [navBackBtn setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    //    navBackBtn.titleLabel.font = [UIFont boldSystemFontOfSize:22];
    //    [rightView addSubview:navBackBtn];
    //
    //    UIBarButtonItem *rightCustomView = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    //
    //    self.navigationItem.rightBarButtonItem = rightCustomView;
    
    //upto here on 27/04/2017....
    
    
    NSString* dbPath = [DataBaseConnection connection:@"RetailerBillingDataBase.sqlite"];
    NSLog(@"DBPATH---------%@",dbPath);
    
    //  [self updateTable:@"billing_table" columnName:@"serial_billId" value:@"2"];
    
    
    //commented by Srinivasulu on 18/05/2017....
    //reason already modifications are not....
    
    //    [self alterTable:@"sku_master" column:@"is_tax_exclusive"];
    
    //upto here on 18/05/2017....
    
    
    // [self deleteFromTable:@"billing_table"];
    // [self deleteFromTable:@"offer_ranges"];
    
    //    [self dropTable:@"billing_item_taxes"];
    //    [self dropTable:@"billing_items"];
    //    [self dropTable:@"billing_table"];
    //    [self dropTable:@"billing_taxes"];
    // [self dropTable:@"denomination_master"];
    
    
    //commented by Srinivasulu on 18/05/2017....
    //reason it is used to variable....
    
    //    NSDate *today = [NSDate date];
    //    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    //    [f setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    //    NSString * currentdate = [f stringFromDate:today];
    
    //upto here on 18/05/2017....
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //it is also using for OTP.. before only it exist..
    if ([[defaults valueForKey:BUSINESS_DATE_UPDATED] isKindOfClass:[NSNull class]] || [defaults valueForKey:BUSINESS_DATE_UPDATED] == nil) {
        
        [defaults setValue:[[WebServiceUtility getCurrentDate] componentsSeparatedByString:@" "][0] forKey:BUSSINESS_DATE];
        
        [defaults setObject:[NSNumber numberWithBool:true] forKey:BUSINESS_DATE_UPDATED];
    }
    
    //this lines need to commented written by Srinivasulu on 04/07/2017....
    //this type of hard coding should not be there....
    //it is existing code....
    
    
    //        if ([[defaults valueForKey:@"lastSkuUpdated"] length]==0) {
    //            [defaults setObject:@"04/04/2017 00:00:00" forKey:@"lastSkuUpdated"];
    //        }
    //        if ([[defaults valueForKey:@"lastSkuEanUpdated"] length]==0) {
    //            [defaults setObject:@"04/04/2017 00:00:00" forKey:@"lastSkuEanUpdated"];
    //        }
    //        if ([[defaults valueForKey:@"lastPriceUpdated"] length]==0) {
    //            [defaults setObject:@"04/04/2017 00:00:00" forKey:@"lastPriceUpdated"];
    //        }
    
    //        [defaults setObject:@"04/04/2016 00:00:00" forKey:@"lastSkuUpdated"];
    //        [defaults setObject:@"04/04/2016 00:00:00" forKey:@"lastSkuEanUpdated"];
    //        [defaults setObject:@"04/04/2016 00:00:00" forKey:@"lastPriceUpdated"];
    //
    
    //    if ([[defaults valueForKey:@"lastSkuUpdated"] length]==0)
    //        [defaults setObject:@"21/07/2017 00:00:00" forKey:@"lastSkuUpdated"];
    //
    //    if ([[defaults valueForKey:@"lastSkuEanUpdated"] length]==0)
    //        [defaults setObject:@"21/07/2017 00:00:00" forKey:@"lastSkuEanUpdated"];
    //
    //    if ([[defaults valueForKey:@"lastPriceUpdated"] length]==0)
    //        [defaults setObject:@"21/07/2017 00:00:00" forKey:@"lastPriceUpdated"];
    //
    //    if ([[defaults valueForKey:@"lastGroupsUpdated"] length]==0)
    //        [defaults setObject:@"21/07/2017 00:00:00" forKey:@"lastGroupsUpdated"];
    //
    //    if ([[defaults valueForKey:@"lastGroupChildsUpdated"] length]==0)
    //        [defaults setObject:@"21/07/2017 00:00:00" forKey:@"lastGroupChildsUpdated"];
    //
    //    if ([[defaults valueForKey:@"lastPriceUpdated"] length]==0)
    //        [defaults setObject:@"21/07/2017 00:00:00" forKey:@"lastPriceUpdated"];
    //    if ([[defaults valueForKey:@"lastEmplUpdatedDate"] length]==0)
    //        [defaults setObject:@"21/07/2017 00:00:00" forKey:@"lastEmplUpdatedDate"];
    //
    //    if ([[defaults valueForKey:@"lastDenominationsUpdatedDate"] length]==0)
    //        [defaults setObject:@"21/07/2017 00:00:00" forKey:@"lastDenominationsUpdatedDate"];
    //
    //    if ([[defaults valueForKey:@"updatedDateStr"] length]==0)
    //        [defaults setObject:@"21/07/2017 00:00:00" forKey:@"updatedDateStr"];
    
    
    
    
    
    
    //upto here on 04/07/2017.....
    
    
    
    
    //    if ([[defaults valueForKey:@"lastGroupsUpdated"] length]==0) {
    //        [defaults setObject:@"6/12/2016 00:00:00" forKey:@"lastGroupsUpdated"];
    //    }
    //    if ([[defaults valueForKey:@"lastGroupChildsUpdated"] length]==0) {
    //        [defaults setObject:@"6/12/2016 00:00:00" forKey:@"lastGroupChildsUpdated"];
    //    }
    //
    //    if ([[defaults valueForKey:@"lastDealsUpdated"] length]==0) {
    //        [defaults setObject:@"6/12/2016 00:00:00" forKey:@"lastDealsUpdated"];
    //    }
    //
    //    if ([[defaults valueForKey:@"lastOffersUpdated"] length]==0) {
    //        [defaults setObject:@"6/12/2016 00:00:00" forKey:@"lastOffersUpdated"];
    //    }
    
    
    [defaults synchronize];
    
    
    
    //        if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
    //
    //            if (deleteStmt == nil) {
    //                char *errMsg;
    //                const char *sqlStatement = "CREATE INDEX IF NOT EXISTS price_list ON sku_price_list(ean)";
    //
    //                if (sqlite3_exec(database, sqlStatement, NULL, NULL, &errMsg)
    //                    == SQLITE_OK) {
    //
    //                    NSLog(@"Success");
    //
    //                }
    //                else {
    //                    NSLog(@"%s",sqlite3_errmsg(database));
    //
    //                }
    //
    //            }
    //
    //        }
    //    [self alterTable:@"billing_items" column:@"promo_item_flag"];
    //    [self alterTable:@"offers" column:@"priority" type:@"int"];
    //    [self alterTable:@"deals" column:@"priority" type:@"int"];
    //    [self alterTable:@"offers" column:@"is_customer_specific" type:@"int"];
    //    [self alterTable:@"deals" column:@"is_customer_specific" type:@"int"];
    
    //    [self updateTable:@"groups_child" columnName:@"status" value:[NSNumber numberWithInt:1]];
    
    //    [self dropTable:@"offers"];
    //    [self dropTable:@"offer_ranges"];
    //    [self dropTable:@"deals"];
    //    [self dropTable:@"deals_ranges"];
    //    [self dropTable:@"billing_items"];
    //    [self dropTable:@"billing_table"];
    //    [self dropTable:@"billing_taxes"];
    //    [self dropTable:@"billing_transactions"];
    //    [self alterTable:@"billing_items" column:@"item_scan_code" type:@"text"];
    //    [self alterTable:@"billing_table" column:@"scan_end_time" type:@"text"];
    //    [self alterTable:@"billing_table" column:@"print_time" type:@"text"];
    //    [self alterTable:@"billing_table" column:@"bill_time_duration" type:@"int"];
    //    [self alterTable:@"billing_table" column:@"bill_time_duration_accept_print" type:@"int"];
    //
    //
    //    [self alterTable:@"billing_items" column:@"discount_type" type:@"text"];
    //    [self alterTable:@"billing_items" column:@"discount_id" type:@"text"];
    //    [self alterTable:@"billing_items" column:@"discount_price" type:@"double"];
    //    [self alterTable:@"billing_items" column:@"mrpPrice" type:@"double"];
    
    
    
    //    NSFileManager *fileManager = [NSFileManager defaultManager];
    //    NSError *error;
    ////    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    ////    NSString *documentsDirectory = [paths objectAtIndex:0];
    ////
    ////    NSString *txtPath = [documentsDirectory stringByAppendingPathComponent:@"txtFile.txt"];
    //
    ////    if ([fileManager fileExistsAtPath:txtPath] == NO) {
    //        NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"RetailerBillingDataBase" ofType:@"sqlite"];
    //        [fileManager copyItemAtPath:resourcePath toPath:dbPath error:&error];
    ////    }
    
    
    //    [self deleteLocalBills:@""];
    
    //    BOOL saveStatus = false;
    //    static sqlite3_stmt *insertStmt;
    //    NSString* dbPath = [DataBaseConnection connection:@"RetailerBillingDataBase.sqlite"];
    //
    //
    //        @try {
    //
    //            if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
    //                NSString *query ;
    //
    //                query = [NSString stringWithFormat:@"update billing_table SET save_status='to be uploaded'"];
    //
    //
    //
    //                const char *sqlStatement = [query UTF8String];
    //
    //
    //                if(sqlite3_prepare_v2(database, sqlStatement, -1, &insertStmt, NULL) == SQLITE_OK) {
    //                    //                        int count = sqlite3_column_count(selectStmt);
    //                    if (sqlite3_step(insertStmt) == SQLITE_DONE) {
    //
    //                        saveStatus = true;
    //
    //                    }
    //                    else {
    //                        NSLog(@"%s",sqlite3_errmsg(database)) ;
    //
    //                    }
    //
    //                    sqlite3_finalize(insertStmt);
    //                    insertStmt = nil;
    //                }
    //                else {
    //                    NSLog(@"%s",sqlite3_errmsg(database)) ;
    //                }
    //
    //
    //            }
    //
    //        }
    //        @catch (NSException *exception) {
    //            NSLog(@"%@",exception);
    //            UIAlertView *alert=  [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Problem occured while processing" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //            [alert show];
    //            [alert release];
    //        }
    //        @finally {
    //            sqlite3_close(database);
    //            deleteStmt = nil;
    //            selectStmt = nil;
    //        }
    
    
    
    //
    //    OfflineBillingServices *offline = [[OfflineBillingServices alloc]init];
    //    [offline saveTaxes:finalTaxDetails];
    
    //////    [offline clearSkuTable];
    //    [offline getPriceLists:skuPriceStartIndex totalRecords:DOWNLOAD_RATE];
    //    skuPriceStartIndex = skuPriceStartIndex+DOWNLOAD_RATE;
    //    while (skuPriceStartIndex<=totalAvailPriceRecords) {
    //       [offline getPriceLists:skuPriceStartIndex totalRecords:DOWNLOAD_RATE];
    //        skuPriceStartIndex = skuPriceStartIndex+DOWNLOAD_RATE;
    //
    //    }
    //    if (skuPriceStartIndex >= totalAvailPriceRecords) {
    //        NSDate *today = [NSDate date];
    //        NSDateFormatter *f = [[NSDateFormatter alloc] init];
    //        [f setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    //        NSString* currentdate = [f stringFromDate:today];
    //
    //        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    //
    //        [defaults setObject:currentdate forKey:@"lastPriceUpdated"];
    //
    //        [defaults synchronize];
    //    }
    
    //    [offline getDeals];
    //    [offline saveOffers];
    //    [offline saveGroupsInfo];
    
    //    [offline getSkuEanDetails:skuEanIndex totalRecords:DOWNLOAD_RATE];
    //    skuEanIndex = skuEanIndex+DOWNLOAD_RATE;
    //    while (skuEanIndex<=totalAvailSkuEans) {
    //        [offline getSkuEanDetails:skuEanIndex totalRecords:DOWNLOAD_RATE];
    //        skuEanIndex = skuEanIndex+DOWNLOAD_RATE;
    //    }
    //    if (skuEanIndex >= totalAvailSkuEans) {
    //        NSDate *today = [NSDate date];
    //        NSDateFormatter *f = [[NSDateFormatter alloc] init];
    //        [f setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    //        NSString* currentdate = [f stringFromDate:today];
    //
    //        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //        [defaults setObject:currentdate forKey:@"lastSkuEanUpdated"];
    //
    //        [defaults synchronize];
    //    }
    
    skuStartIndex = 0;
    totalRecords = 0;
    skuEanIndex = 0;
    skuPriceStartIndex = 0;
    totalPriceRecords = 0;
    denominationStartIndex = 0;
    productStartIndex = 0;
    categoryStartIndex = 0;
    subCategoryStartIndex = 0;
    
    //    presentLocation = @"Hyderabad";
    loadingView = [[UIView alloc] initWithFrame:self.view.frame];
    loadingView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    loadingView.hidden = YES;
    
    loadingMsgLbl = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/4+250, self.view.frame.size.height/2, 200, 30)];
    loadingMsgLbl.text = @"Loading...";
    loadingMsgLbl.textColor = [UIColor whiteColor];
    loadingMsgLbl.backgroundColor = [UIColor clearColor];
    loadingMsgLbl.font = [UIFont boldSystemFontOfSize:25];
    [loadingView addSubview:loadingMsgLbl];
    
    loadingMsgLbl.alpha = 0;
    
    [UIView animateWithDuration:0.2 delay:0.5 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
        loadingMsgLbl.alpha = 1;
    } completion:nil];
    
    version = [UIDevice currentDevice].systemVersion.floatValue;
    self.view.backgroundColor = [UIColor blackColor];
    
    // NSLog(@"device Id %@",[[MswipeWisepadController sharedInstance] getDeviceId]);
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    //    [self.navigationItem setHidesBackButton:YES animated:YES];
    //    self.navigationController.navigationBarHidden = NO;
    //    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gradient_navigation.png"]];
    
    
    //    NSDate *today = [NSDate date];
    //    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    //    [f setDateFormat:@"dd/MM/yyyy"];
    //    NSString* currentdate = [f stringFromDate:today];
    
    defaults = [[NSUserDefaults alloc] init];
    //    [defaults setObject:currentdate forKey:@"lastSkuUpdated"];
    //    [defaults setObject:currentdate forKey:@"lastPriceUpdated"];
    //    [defaults setObject:currentdate forKey:@"lastTaxUpdated"];
    //    [defaults setObject:currentdate forKey:@"lastDealsUpdated"];
    //    [defaults setObject:currentdate forKey:@"lastOffersUpdated"];
    [defaults synchronize];
    
    
    //  UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:titleView];
    
    // self.navigationItem.leftBarButtonItem = left;
    
    itemsArr = [[NSMutableArray alloc]init];
    transactionArr = [[NSMutableArray alloc]init];
    
    
    //changed by Srinivasulu on 20/04/2017....
    
    //    if(!isOfflineService){
    
    CheckWifi *wifi = [[CheckWifi alloc]init];
    BOOL status = [wifi checkWifi];
    if (status) {
        
        isOfflineService = FALSE;
    }
    else {
        isOfflineService = TRUE;
    }
    
    if (isOfflineService) {
        
        
        
        //cahnged Srinivauslu on 01/05/2017...
        
        
        //        self.titleLabel.text = @"Omni Retailer-Offline";
        
        self.titleLabel.text = @"OMNI RETAILER";
        
        //upto here on 01/05/2017....
        
        
    }
    //    }
    //    else{
    //
    //        self.titleLabel.text = @"Omni Retailer-Offline";
    //
    //    }
    
    
    //upto here on 29/04/2017.....
    
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.hideDelegate = self;
    
    
    UIImage *background = [UIImage imageNamed:@"omni_home_bg.png"];
    UIImageView *backImage = [[UIImageView alloc] initWithImage:background];
    
    
    
    homeTable = [[UITableView alloc] init];
    //homeTable.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"images34.jpg"]];[UIColor groupTableViewBackgroundColor];
    homeTable.backgroundColor = [UIColor clearColor];
    //homeTable.backgroundColor = [UIColor colorWithRed: 251.0/255.0 green: 255.0/255.0 blue: 249.0/255.0 alpha:1];
    homeTable.dataSource = self;
    homeTable.delegate = self;
    
    
    
    // Loading homepage icon images into an array ..
    prod_img_array = [[NSMutableArray alloc] init];
    
    //    [prod_img_array addObject:@"Stocks1.png"];
    
    
    if ([finalLicencesDetails containsObject:@"Billing and MPOS"] && ![finalLicencesDetails containsObject:@"Inventory Management"]) {
        [prod_img_array addObject:@"Billing1.png"];
        [prod_img_array addObject:@"Stocks1.png"];
        [prod_img_array addObject:@"Deals1.png"];
    }
    else if (![finalLicencesDetails containsObject:@"Billing and MPOS"] && [finalLicencesDetails containsObject:@"Inventory Management"]){
        [prod_img_array addObject:@"Stocks1.png"];
        [prod_img_array addObject:@"Deals1.png"];
    }
    else if ([finalLicencesDetails containsObject:@"Billing and MPOS"] && [finalLicencesDetails containsObject:@"Inventory Management"]){
        [prod_img_array addObject:@"Billing1.png"];
        [prod_img_array addObject:@"Stocks1.png"];
        [prod_img_array addObject:@"Deals1.png"];
        
        // added by roja just for testing (used while connected to production) remove it...
//        [prod_img_array addObject:@"Orders1.png"];

    }
    else if (![finalLicencesDetails containsObject:@"Billing and MPOS"] && ![finalLicencesDetails containsObject:@"Inventory Management"]){
        [prod_img_array addObject:@"Deals1.png"];
    }
    if ([finalLicencesDetails containsObject:@"Mobi Sales"]) {
        [prod_img_array addObject:@"Orders1.png"];
        [prod_img_array addObject:@"Table.png"]; //staff_service.png  added by roja
    }
    if ([finalLicencesDetails containsObject:@"CRM and Loyalty Cards"]) {
        [prod_img_array addObject:@"Loyalty1.png"];
    }
    if ([finalLicencesDetails containsObject:@"Analytics"]) {
        [prod_img_array addObject:@"Reports1.png"];
    }
    
    //added by Srinivauslu on 14/08/2018....
        if (![finalLicencesDetails containsObject:@"Campaign Management"]) {
        isToCallApplyCampaigns = false;
    }
    //upto here on 14/08/2018....
    
    selectedFlowStr = @"Billing";
    
    //    [prod_img_array addObject:@"Billing1.png"];
    //    [prod_img_array addObject:@"Stocks1.png"];
    //    [prod_img_array addObject:@"Deals1.png"];
    //    [prod_img_array addObject:@"Orders1.png"];
    //    [prod_img_array addObject:@"Loyalty1.png"];
    //    [prod_img_array addObject:@"Reports1.png"];
    // Loading homepage sub icons of a cell into an array ..
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        //
        //        [self.navigationController.navigationBar setBarTintColor:[UIColor lightGrayColor]];
        //        [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIFont boldSystemFontOfSize:20], UITextAttributeFont,nil] forState:UIControlStateNormal];
        
        sub_prod1_array = [[NSMutableArray alloc] init];
        [sub_prod1_array addObject:@"NewBill.png"];
        [sub_prod1_array addObject:@"stock request_out.png"]; // Critical@2x.png
        [sub_prod1_array addObject:@"CurrentDeals@2x.png"];
        [sub_prod1_array addObject:@"NewOrder@2x.png"];
        [sub_prod1_array addObject:@"SalesReport@2x.png"];
        [sub_prod1_array addObject:@"Loyalty_New@2x.png"];
        
        sub_prod2_array = [[NSMutableArray alloc] init];
        [sub_prod2_array addObject:@"OpenBill.png"];
        [sub_prod2_array addObject:@"NormalStock@2x.png"];
        [sub_prod2_array addObject:@"PastDeals@2x.png"];
        [sub_prod2_array addObject:@"OldOrder@2x.png"];
        [sub_prod2_array addObject:@"Order_Reports@2x.png"];
        [sub_prod2_array addObject:@"Loyalty@2x.png"];
    }
    else{
        
        sub_prod1_array = [[NSMutableArray alloc] init];
        [sub_prod1_array addObject:@"NewBill.png"];
        [sub_prod1_array addObject:@"Critical.png"];
        [sub_prod1_array addObject:@"CurrentDeals.png"];
        [sub_prod1_array addObject:@"NewOrder.png"];
        [sub_prod1_array addObject:@"SalesReport.png"];
        [sub_prod1_array addObject:@"Loyalty_New.png"];
        
        sub_prod2_array = [[NSMutableArray alloc] init];
        [sub_prod2_array addObject:@"OpenBill.png"];
        [sub_prod2_array addObject:@"NormalStock.png"];
        [sub_prod2_array addObject:@"PastDeals.png"];
        [sub_prod2_array addObject:@"OldOrder.png"];
        [sub_prod2_array addObject:@"Order_Reports.png"];
        [sub_prod2_array addObject:@"showlaoyalty.png"];
        
    }
    
    UIImage *toolsImage;
    UIImage *usersImage;
    UIImage *helpImage;
    
    
    float width = (self.view.frame.size.width + 20) / 3;
    
    // bottombar ..
    NSArray *segmentText1;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        //        toolsImage = [[UIImage imageNamed:@"Toolss@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //        usersImage = [[UIImage imageNamed:@"Users@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //        helpImage = [[UIImage imageNamed:@"Help@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        
        toolsImage = [[self  imageFromImage:[UIImage imageNamed:@"Toolss@2x.png"]
                       imageBackGroundColor:[UIColor blackColor]
                                     string:NSLocalizedString(@"cloud_config", nil)
                                      color:[UIColor colorWithRed:0  green:230 blue:230 alpha:0.7]
                                       font:16
                                      width:width
                                     height:16
                                   fontType:TEXT_FONT_NAME
                                 imageWidth:40
                                imageHeight:40] imageWithRenderingMode:
                      UIImageRenderingModeAlwaysOriginal];
        
        usersImage = [[self  imageFromImage:[UIImage imageNamed:@"Users@2x.png"]
                       imageBackGroundColor:[UIColor blackColor]
                                     string:NSLocalizedString(@"about_us", nil)
                                      color:[UIColor colorWithRed:0  green:230 blue:230 alpha:0.7]
                                       font:16
                                      width:width
                                     height:16
                                   fontType:TEXT_FONT_NAME
                                 imageWidth:40
                                imageHeight:40] imageWithRenderingMode:
                      UIImageRenderingModeAlwaysOriginal];
        
        helpImage = [[self  imageFromImage:[UIImage imageNamed:@"Help@2x.png"]
                      imageBackGroundColor:[UIColor blackColor]
                                    string:NSLocalizedString(@"help", nil)
                                     color:[UIColor colorWithRed:0  green:255 blue:230 alpha:0.7]
                                      font:16
                                     width:width
                                    height:16
                                  fontType:TEXT_FONT_NAME
                                imageWidth:40
                               imageHeight:40] imageWithRenderingMode:
                     UIImageRenderingModeAlwaysOriginal];
        
        segmentText1 = @[toolsImage,usersImage,helpImage];
    }
    else{
        if (version >= 8.0) {
            segmentText1 = @[[[UIImage imageNamed:@"Toolss@iphone.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                             [[UIImage imageNamed:@"Users@iphone.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                             [[UIImage imageNamed:@"Help@iphone.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        }
        else{
            segmentText1 = @[[UIImage imageNamed:@"Toolss@iphone.png"],
                             [UIImage imageNamed:@"Users@iphone.png"],
                             [UIImage imageNamed:@"Help@iphone.png"]];
        }
        
    }
    //segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"config",@"aboutus",@"help",nil]];
    segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentText1];
    segmentedControl.tintColor=[UIColor clearColor];
    segmentedControl.backgroundColor = [UIColor blackColor];
    //segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    //segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    //segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
    
    //UIColor *tintcolor=[UIColor colorWithRed:63.0/255.0 green:127.0/255.0 blue:187.0/255.0 alpha:1.0];
    //[[segmentedControl.subviews objectAtIndex:0] setTintColor:tintcolor];
    
    [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    
    billingView = [[UIView alloc] init];
    billingView.backgroundColor = [UIColor blackColor];
    billingView.layer.borderWidth = 2.0f;
    billingView.layer.cornerRadius = 10.0f;
    billingView.layer.borderColor = [UIColor grayColor].CGColor;
    
    listView = [[UIView alloc] init];
    listView.backgroundColor = [UIColor clearColor];
    
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    //    [[NSNotificationCenter defaultCenter] addObserver: self selector:@selector(deviceOrientationDidChange:) name: UIDeviceOrientationDidChangeNotification object: nil];
    
    currentOrientation = [UIDevice currentDevice].orientation;
    
    //added by Srinivasulu on 26/03/2018....
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && !(currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight))
        currentOrientation = UIDeviceOrientationLandscapeRight;
    
    //upto here on 26/03/2018....
    
    line = [[UILabel alloc] init];
    line.backgroundColor = [UIColor clearColor];
    line.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
    line.font = [UIFont boldSystemFontOfSize:25.0f];
    line.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25.0f];
    line.text = @"BILLING";
    line.textAlignment = NSTextAlignmentCenter;
    //line.layer.borderColor = [UIColor grayColor].CGColor;
    //line.layer.borderWidth = 2.0f;
    
    
    listTableView = [[UITableView alloc] init];
    //homeTable.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"images34.jpg"]];[UIColor groupTableViewBackgroundColor];
    listTableView.backgroundColor = [UIColor clearColor];
    //homeTable.backgroundColor = [UIColor colorWithRed: 251.0/255.0 green: 255.0/255.0 blue: 249.0/255.0 alpha:1];
    listTableView.dataSource = self;
    listTableView.delegate = self;
    
    //creation of UIButtons.......
    UIImage *selctedListImage = [UIImage imageNamed:@"list_select.png"];
    UIImage *selectedGirdImage = [UIImage imageNamed:@"grid_brown.png"];
    
    
    showListViewBtn = [[UIButton alloc] init];
    [showListViewBtn setImage:selctedListImage forState:UIControlStateNormal];
    //    [showListViewBtn setBackgroundImage:selctedListImage  forState:UIControlStateNormal];
    [showListViewBtn addTarget:self
                        action:@selector(showRespectiveView:) forControlEvents:UIControlEventTouchDown];
    showListViewBtn.tag = 4;
    
    showgridViewBtn = [[UIButton alloc] init];
    [showgridViewBtn setImage:selectedGirdImage forState:UIControlStateNormal];
    //    [showListViewBtn setBackgroundImage:selectedGirdImage  forState:UIControlStateNormal];
    [showgridViewBtn addTarget:self
                        action:@selector(showRespectiveView:) forControlEvents:UIControlEventTouchDown];
    showgridViewBtn.tag = 2;
    
    
    
    messageIcon = [[UIButton alloc] init];
    [messageIcon setImage:[UIImage imageNamed:@"sms_bill@2x.png"] forState:UIControlStateNormal];
    [messageIcon addTarget:self
                    action:@selector(messageBoard) forControlEvents:UIControlEventTouchDown];
    
    
    CALayer *bottomBorder = [CALayer layer];
    
    bottomBorder.frame = CGRectMake(0.0f, 60.0f, line.frame.size.width, 1.0f);
    
    bottomBorder.backgroundColor = [UIColor grayColor].CGColor;
    bottomBorder.opacity = 5.0f;
    [line.layer addSublayer:bottomBorder];
    //    CAGradientLayer *mainGradient = [CAGradientLayer layer];
    //    mainGradient.frame = line.bounds;
    //    mainGradient.colors = [NSArray arrayWithObjects:(id)[[UIColor grayColor] CGColor], (id)[[UIColor blackColor] CGColor], nil];
    //    mainGradient.cornerRadius = 10.0f;
    //    [billingView.layer addSublayer:mainGradient];
    line.layer.cornerRadius = 10.0f;
    line.layer.masksToBounds = YES;
    line.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gradient.png"]];
    [billingView addSubview:line];
    
    newBillButton = [[UIButton alloc] init];
    buttonView = [[UIImageView alloc] init];
    buttonView.image = [UIImage imageNamed:@"NewBill.png"];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
            
            //added by Srinivasulu on 23/09/2017....
            
            
            self.view.frame = CGRectMake(0, 0, [ UIScreen mainScreen ].bounds .size.width, [ UIScreen mainScreen ].bounds .size.height);
            //upto here on 23/09/2017....
            
            line.frame = CGRectMake(0.0, 0.0, 820, 50.0);
            
            newBillButton.frame = CGRectMake(0.0, 0, line.frame.size.width, 90.0);
            buttonView.frame = CGRectMake(20.0, 10.0, 70, 70);
            newBillButton.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
            newBillButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            newBillButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            newBillButton.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            newBillButton.layer.borderWidth = 0.5f;
            newBillButton.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
            newBillButton.titleLabel.alpha = 0.7f;
            
        }
        else {
            line.frame = CGRectMake(0.0, 0.0, 560.0, 50.0);
            
            newBillButton.frame = CGRectMake(0.0, 65.0, 560.0, 90.0);
            buttonView.frame = CGRectMake(20.0, 10.0, 70, 70);
            newBillButton.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
            newBillButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            newBillButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            newBillButton.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            newBillButton.layer.borderWidth = 0.5f;
            newBillButton.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
            newBillButton.titleLabel.alpha = 0.7f;
        }
        
        
        
    }
    else{
        buttonView.image = [UIImage imageNamed:@"NewBill-iPhone.png"];
        
        line.frame = CGRectMake(0.0, 0.0, 200.0, 50.0);
        bottomBorder.frame = CGRectMake(0.0, 60.0,line.frame.size.width, 1.0);
        line.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
        newBillButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        newBillButton.frame = CGRectMake(0.0, 50.0, 200.0, 50.0);
        buttonView.frame = CGRectMake(5.0, 5.0, 45.0, 45.0);
        newBillButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        newBillButton.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        [newBillButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        newBillButton.layer.borderWidth = 0.5f;
        newBillButton.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
        newBillButton.titleLabel.alpha = 0.7f;
        
        if (version >= 8.0) {
            line.frame = CGRectMake(0.0, 0.0, 200.0, 50.0);
            bottomBorder.frame = CGRectMake(0.0, 60.0,line.frame.size.width, 1.0);
            line.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
            newBillButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
            newBillButton.frame = CGRectMake(0.0, 40.0, 200.0, 50.0);
            buttonView.frame = CGRectMake(5.0, 5.0, 45.0, 45.0);
            newBillButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            newBillButton.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
            [newBillButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            newBillButton.layer.borderWidth = 0.5f;
            newBillButton.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
            newBillButton.titleLabel.alpha = 0.7f;
        }
    }
    newBillButton.hidden = NO;
    newBillButton.backgroundColor = [UIColor clearColor];
    [newBillButton setTitle:@"New Bill" forState:UIControlStateNormal];
    
    [newBillButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [newBillButton addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [newBillButton addSubview:buttonView];
    
    oldBillButton = [[UIButton alloc] init];
    oldBillView = [[UIImageView alloc] init];
    oldBillView.image = [UIImage imageNamed:@"OpenBill.png"];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
            
            oldBillButton.frame = CGRectMake(0.0, newBillButton.frame.origin.y + newBillButton.frame.size.height, line.frame.size.width, 90.0);
            oldBillView.frame = CGRectMake(20.0, 10.0, 70, 70);
            oldBillButton.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
            oldBillButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            oldBillButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            oldBillButton.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            oldBillButton.layer.borderWidth = 0.5f;
            oldBillButton.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
            oldBillButton.titleLabel.alpha = 0.7f;
        }
        else {
            
            oldBillButton.frame = CGRectMake(0.0, 160.0, 560.0, 90.0);
            oldBillView.frame = CGRectMake(20.0, 10.0, 70, 70);
            oldBillButton.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
            oldBillButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            oldBillButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            oldBillButton.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            oldBillButton.layer.borderWidth = 0.5f;
            oldBillButton.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
            oldBillButton.titleLabel.alpha = 0.7f;
        }
    }
    else{
        oldBillView.image = [UIImage imageNamed:@"OpenBill-iPhone.png"];
        
        oldBillButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
        oldBillButton.frame = CGRectMake(0.0, 110.0, 200.0, 50.0);
        oldBillView.frame = CGRectMake(5.0, 5.0, 45.0, 45.0);
        oldBillButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        oldBillButton.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        oldBillButton.layer.borderWidth = 0.5f;
        oldBillButton.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
        oldBillButton.titleLabel.alpha = 0.7f;
        if (version >= 8.0) {
            oldBillButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
            oldBillButton.frame = CGRectMake(0.0, 90.0, 200.0, 50.0);
            oldBillView.frame = CGRectMake(5.0, 5.0, 45.0, 45.0);
            oldBillButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            oldBillButton.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
            oldBillButton.layer.borderWidth = 0.5f;
            oldBillButton.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
            oldBillButton.titleLabel.alpha = 0.7f;
        }
    }
    oldBillButton.hidden = NO;
    oldBillButton.backgroundColor = [UIColor clearColor];
    [oldBillButton setTitle:@"Open Bill" forState:UIControlStateNormal];
    [oldBillButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [oldBillButton addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [oldBillButton addSubview:oldBillView];
    
    pendingIcon = [[UIButton alloc] init];
    pendingView = [[UIImageView alloc] init];
    pendingView.image = [UIImage imageNamed:@"billing_pendingbill_icon.png"];
    pendingBottomBorder = [CALayer layer];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
            
            pendingIcon.frame = CGRectMake(0.0, oldBillButton.frame.origin.y + oldBillButton.frame.size.height, line.frame.size.width, 90.0);
            
            pendingView.frame = CGRectMake(20.0, 10.0, 70, 70);
            pendingIcon.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
            pendingIcon.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            pendingIcon.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            pendingIcon.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            pendingIcon.layer.borderWidth = 0.5f;
            pendingIcon.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
            pendingIcon.titleLabel.alpha = 0.7f;
            pendingBottomBorder.frame = CGRectMake(0.0f, 100.0f, pendingIcon.frame.size.width, 1.0f);
            pendingBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            pendingBottomBorder.opacity = 0.3f;
            
        }
        else {
            pendingIcon.frame = CGRectMake(0.0, 255, 560.0, 90.0);
            
            pendingView.frame = CGRectMake(20.0, 10.0, 70, 70);
            pendingIcon.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
            pendingIcon.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            pendingIcon.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            pendingIcon.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            pendingIcon.layer.borderWidth = 0.5f;
            pendingIcon.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
            pendingIcon.titleLabel.alpha = 0.7f;
            pendingBottomBorder.frame = CGRectMake(0.0f, 100.0f, pendingIcon.frame.size.width, 1.0f);
            pendingBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            pendingBottomBorder.opacity = 0.3f;
        }
        
    }
    else{
        pendingIcon.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
        pendingIcon.frame = CGRectMake(0.0, 230.0, 200.0, 50.0);
        pendingView.frame = CGRectMake(5.0, 5.0, 45.0, 45.0);
        pendingIcon.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        pendingIcon.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        pendingIcon.titleLabel.alpha = 0.7f;
        pendingBottomBorder.frame = CGRectMake(0.0f, 60.0f, pendingIcon.frame.size.width, 1.0f);
        pendingBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        pendingBottomBorder.opacity = 0.3f;
        if (version >= 8.0) {
            pendingIcon.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
            pendingIcon.frame = CGRectMake(0.0, 200.0, 200.0, 50.0);
            pendingView.frame = CGRectMake(5.0, 5.0, 45.0, 45.0);
            pendingIcon.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            pendingIcon.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
            pendingIcon.titleLabel.alpha = 0.7f;
            pendingBottomBorder.frame = CGRectMake(0.0f, 55.0f, pendingIcon.frame.size.width, 1.0f);
            pendingBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            pendingBottomBorder.opacity = 0.15f;
        }
    }
    //    [pendingIcon.layer addSublayer:pendingBottomBorder];
    pendingIcon.hidden = NO;
    pendingIcon.backgroundColor = [UIColor clearColor];
    [pendingIcon setTitle:@"Pending Bills" forState:UIControlStateNormal];
    [pendingIcon setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [pendingIcon addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [pendingIcon addSubview:pendingView];
    
    
    
    deliveryIcon = [[UIButton alloc] init];
    deliveryView = [[UIImageView alloc] init];
    deliveryView.image = [UIImage imageNamed:@"billing_doordelivery_icon.png"];
    CALayer *deliBottomBorder = [CALayer layer];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
            deliveryIcon.frame = CGRectMake(0.0, pendingIcon.frame.origin.y + pendingIcon.frame.size.height, line.frame.size.width, 90.0);
            deliveryView.frame = CGRectMake(20.0, 10.0, 70, 70);
            deliveryIcon.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
            deliveryIcon.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            deliveryIcon.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            deliveryIcon.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            // deliveryIcon.layer.borderWidth = 0.5f;
            //  deliveryIcon.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
            deliveryIcon.titleLabel.alpha = 0.7f;
            
            deliBottomBorder.frame = CGRectMake(0.0f, 100.0f, pendingIcon.frame.size.width, 1.0f);
            deliBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            deliBottomBorder.opacity = 0.3f;
        }
        else {
            deliveryIcon.frame = CGRectMake(0.0, 350, 560.0, 90.0);
            deliveryView.frame = CGRectMake(20.0, 10.0, 70, 70);
            deliveryIcon.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
            deliveryIcon.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            deliveryIcon.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            deliveryIcon.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            // deliveryIcon.layer.borderWidth = 0.5f;
            //  deliveryIcon.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
            deliveryIcon.titleLabel.alpha = 0.7f;
            deliBottomBorder.frame = CGRectMake(0.0f, 100.0f, pendingIcon.frame.size.width, 1.0f);
            deliBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            deliBottomBorder.opacity = 0.3f;
        }
    }
    else {
        
        if (version >= 8.0) {
            
            deliveryIcon.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
            deliveryIcon.frame = CGRectMake(0.0, 140.0, 200.0, 50.0);
            deliveryView.frame = CGRectMake(5.0, 5.0, 45.0, 45.0);
            deliveryIcon.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            deliveryIcon.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
            deliveryIcon.layer.borderWidth = 0.5f;
            deliveryIcon.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
            deliveryIcon.titleLabel.alpha = 0.7f;
        }
        else{
            deliveryIcon.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
            deliveryIcon.frame = CGRectMake(0.0, 170.0, 200.0, 50.0);
            deliveryView.frame = CGRectMake(5.0, 5.0, 45.0, 45.0);
            deliveryIcon.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            deliveryIcon.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
            deliveryIcon.layer.borderWidth = 0.5f;
            deliveryIcon.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
            deliveryIcon.titleLabel.alpha = 0.7f;
            deliBottomBorder.frame = CGRectMake(0.0f, 60.0f, deliveryIcon.frame.size.width, 1.0f);
            deliBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            deliBottomBorder.opacity = 0.3f;
        }
    }
    [deliveryIcon.layer addSublayer:deliBottomBorder];
    deliveryIcon.hidden = NO;
    deliveryIcon.backgroundColor = [UIColor clearColor];
    [deliveryIcon setTitle:@"Door Delivery" forState:UIControlStateNormal];
    
    [deliveryIcon setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [deliveryIcon addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [deliveryIcon addSubview:deliveryView];
    
    
    cancelledButton = [[UIButton alloc] init];
    cancelledView = [[UIImageView alloc] init];
    cancelledView.image = [UIImage imageNamed:@"billing_pendingbill_icon.png"];
    cancelledBottomBorder = [CALayer layer];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
            
            cancelledButton.frame = CGRectMake(0.0,  deliveryIcon.frame.origin.y + deliveryIcon.frame.size.height, line.frame.size.width, 90.0);
            
            cancelledView.frame = CGRectMake(20.0, 10.0, 70, 70);
            cancelledButton.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
            cancelledButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            cancelledButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            cancelledButton.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            cancelledButton.layer.borderWidth = 0.5f;
            cancelledButton.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
            cancelledButton.titleLabel.alpha = 0.7f;
            //            pendingBottomBorder.frame = CGRectMake(0.0f, 100.0f, pendingIcon.frame.size.width, 1.0f);
            //            pendingBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            //            pendingBottomBorder.opacity = 0.3f;
            
        }
        else {
            cancelledButton.frame = CGRectMake(0.0, 445, 560.0, 90.0);
            
            cancelledView.frame = CGRectMake(20.0, 10.0, 70, 70);
            cancelledButton.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
            cancelledButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            cancelledButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            cancelledButton.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            cancelledButton.layer.borderWidth = 0.5f;
            cancelledButton.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
            cancelledButton.titleLabel.alpha = 0.7f;
            cancelledBottomBorder.frame = CGRectMake(0.0f, 100.0f, pendingIcon.frame.size.width, 1.0f);
            cancelledBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            cancelledBottomBorder.opacity = 0.3f;
        }
        
    }
    else{
        cancelledButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
        cancelledButton.frame = CGRectMake(0.0, 230.0, 200.0, 50.0);
        cancelledView.frame = CGRectMake(5.0, 5.0, 45.0, 45.0);
        cancelledButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        cancelledButton.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        cancelledButton.titleLabel.alpha = 0.7f;
        cancelledBottomBorder.frame = CGRectMake(0.0f, 60.0f, pendingIcon.frame.size.width, 1.0f);
        cancelledBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        cancelledBottomBorder.opacity = 0.3f;
        if (version >= 8.0) {
            cancelledButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
            cancelledButton.frame = CGRectMake(0.0, 260.0, 200.0, 50.0);
            cancelledView.frame = CGRectMake(5.0, 5.0, 45.0, 45.0);
            cancelledButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            cancelledButton.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
            cancelledButton.titleLabel.alpha = 0.7f;
            cancelledBottomBorder.frame = CGRectMake(0.0f, 55.0f, pendingIcon.frame.size.width, 1.0f);
            cancelledBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            cancelledBottomBorder.opacity = 0.15f;
        }
    }
    [cancelledButton.layer addSublayer:cancelledBottomBorder];
    cancelledButton.hidden = NO;
    cancelledButton.backgroundColor = [UIColor clearColor];
    [cancelledButton setTitle:@"Cancelled Bills" forState:UIControlStateNormal];
    [cancelledButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelledButton addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [cancelledButton addSubview:cancelledView];
    
    
    //    added on 04/10/2016:
    
    customerWalkOut = [[UIButton alloc] init];
    customerWalkOutView = [[UIImageView alloc] init];
    customerWalkOutView.image = [UIImage imageNamed:@"NewBill.png"];
    //    customerWalkOutBottomBorder = [CALayer layer];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
            
            customerWalkOut.frame = CGRectMake(0.0,  cancelledButton.frame.origin.y + cancelledButton.frame.size.height, line.frame.size.width, 90.0);
            
            customerWalkOutView.frame = CGRectMake(20.0, 10.0, 70, 70);
            customerWalkOut.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
            customerWalkOut.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            customerWalkOut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            customerWalkOut.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            customerWalkOut.layer.borderWidth = 0.5f;
            customerWalkOut.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
            customerWalkOut.titleLabel.alpha = 0.7f;
        }
        
        else {
            customerWalkOut.frame = CGRectMake(0.0, 445, 560.0, 90.0);
            customerWalkOut.frame = CGRectMake(20.0, 10.0, 70, 70);
            customerWalkOut.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
            customerWalkOut.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            customerWalkOut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            customerWalkOut.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            customerWalkOut.layer.borderWidth = 0.5f;
            customerWalkOut.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
            customerWalkOut.titleLabel.alpha = 0.7f;
            customerWalkOut.frame = CGRectMake(0.0f, 100.0f, cancelledButton.frame.size.width, 1.0f);
        }
        
    }
    else{
        customerWalkOut.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
        customerWalkOut.frame = CGRectMake(0.0, 230.0, 200.0, 50.0);
        customerWalkOutView.frame = CGRectMake(5.0, 5.0, 45.0, 45.0);
        customerWalkOut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        customerWalkOut.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        customerWalkOut.titleLabel.alpha = 0.7f;
        customerWalkOutView.frame = CGRectMake(0.0f, 60.0f, cancelledButton.frame.size.width, 1.0f);
        if (version >= 8.0) {
            customerWalkOut.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
            customerWalkOut.frame = CGRectMake(0.0, 260.0, 200.0, 50.0);
            customerWalkOutView.frame = CGRectMake(5.0, 5.0, 45.0, 45.0);
            customerWalkOut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            customerWalkOut.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
            customerWalkOut.titleLabel.alpha = 0.7f;
        }
    }
    customerWalkOut.hidden = NO;
    customerWalkOut.backgroundColor = [UIColor clearColor];
    [customerWalkOut setTitle:@"Customer WalkOut" forState:UIControlStateNormal];
    [customerWalkOut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [customerWalkOut addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [customerWalkOut addSubview:customerWalkOutView];
    
    
    
    
    /** UIScrollView Design */
    scrollView = [[UIScrollView alloc] init];
    scrollView.hidden = YES;
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.bounces = FALSE;
    
    goodsTransfer = [[UILabel alloc] init];
    goodsTransfer.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.15f];
    goodsTransfer.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
    goodsTransfer.font = [UIFont boldSystemFontOfSize:25.0f];
    goodsTransfer.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
    goodsTransfer.text = @"     GOODS TRANSFER";
    goodsTransfer.textAlignment = NSTextAlignmentLeft;
    //line.layer.borderColor = [UIColor grayColor].CGColor;
    //line.layer.borderWidth = 2.0f;
    CALayer *GTBottomBorder = [CALayer layer];
    CALayer *SRBottomBorder = [CALayer layer];
    CALayer *SIBottomBorder = [CALayer layer];
    CALayer *SREBottomBorder = [CALayer layer];
    CALayer *SRETBottomBorder = [CALayer layer];
    stockReceipt = [[UIButton alloc] init];
    stockReceiptView = [[UIImageView alloc] init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
            
            goodsTransfer.frame = CGRectMake(0.0, 350, 750, 50.0);
            GTBottomBorder.frame = CGRectMake(-30.0f, 50.0f, goodsTransfer.frame.size.width, 1.0f);
            GTBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            GTBottomBorder.opacity = 0.3f;
            stockReceipt.frame = CGRectMake(0.0, 395, 750, 90.0);
            SRBottomBorder.frame = CGRectMake(0.0f, 100.0f, stockReceipt.frame.size.width, 1.0f);
            SRBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            SRBottomBorder.opacity = 0.3f;
            stockReceiptView.frame = CGRectMake(20.0, 10.0, 70, 70);
            stockReceiptView.image = [UIImage imageNamed:@"Receipts.png"];
            stockReceipt.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
            stockReceipt.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            stockReceipt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            stockReceipt.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            stockReceipt.titleLabel.alpha = 0.7f;
            
        }
        else {
            goodsTransfer.frame = CGRectMake(0.0, 255.0, 560.0, 50.0);
            GTBottomBorder.frame = CGRectMake(-30.0f, 50.0f, goodsTransfer.frame.size.width, 1.0f);
            GTBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            GTBottomBorder.opacity = 0.3f;
            stockReceipt.frame = CGRectMake(0.0, 305.0, 560.0, 90.0);
            SRBottomBorder.frame = CGRectMake(0.0f, 100.0f, stockReceipt.frame.size.width, 1.0f);
            SRBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            SRBottomBorder.opacity = 0.3f;
            stockReceiptView.frame = CGRectMake(20.0, 10.0, 70, 70);
            stockReceiptView.image = [UIImage imageNamed:@"Receipts.png"];
            stockReceipt.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
            stockReceipt.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            stockReceipt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            stockReceipt.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            stockReceipt.titleLabel.alpha = 0.7f;
        }
        
    }
    else{
        goodsTransfer.frame = CGRectMake(0.0, 190.0, 200.0, 30.0);
        goodsTransfer.font = [UIFont boldSystemFontOfSize:14.0];
        GTBottomBorder.frame = CGRectMake(0.0f, 60.0f, goodsTransfer.frame.size.width, 1.0f);
        GTBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        GTBottomBorder.opacity = 0.3f;
        stockReceipt.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        stockReceipt.frame = CGRectMake(0.0, 225.0, 200.0, 50.0);
        SRBottomBorder.frame = CGRectMake(0.0f, 55.0f, stockReceipt.frame.size.width, 1.0f);
        SRBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        SRBottomBorder.opacity = 0.3f;
        stockReceiptView.frame = CGRectMake(5.0, 5.0, 45.0, 45.0);
        stockReceiptView.image = [UIImage imageNamed:@"Receipts.png"];
        stockReceipt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        stockReceipt.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        stockReceipt.titleLabel.alpha = 0.7f;
        
    }
    goodsTransfer.layer.masksToBounds = YES;
    [goodsTransfer.layer addSublayer:GTBottomBorder];
    [stockReceipt.layer addSublayer:SRBottomBorder];
    stockReceipt.hidden = NO;
    stockReceipt.backgroundColor = [UIColor clearColor];
    [stockReceipt setTitle:@"Stock Receipt" forState:UIControlStateNormal];
    
    [stockReceipt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [stockReceipt addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [stockReceipt addSubview:stockReceiptView];
    
    stockIssue = [[UIButton alloc] init];
    stockIssueView = [[UIImageView alloc] init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
            
            stockIssue.frame = CGRectMake(0.0, 490.0, 750, 90.0);
            SIBottomBorder.frame = CGRectMake(0.0f, 100.0f, stockIssue.frame.size.width, 1.0f);
            SIBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            SIBottomBorder.opacity = 0.3f;
            stockIssueView.frame = CGRectMake(20.0, 10.0, 70, 70);
            stockIssueView.image = [UIImage imageNamed:@"Issue.png"];
            stockIssue.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            stockIssue.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            stockIssue.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            stockIssue.titleLabel.alpha = 0.7f;
            
        }
        else {
            stockIssue.frame = CGRectMake(0.0, 400.0, 560.0, 90.0);
            SIBottomBorder.frame = CGRectMake(0.0f, 100.0f, stockIssue.frame.size.width, 1.0f);
            SIBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            SIBottomBorder.opacity = 0.3f;
            stockIssueView.frame = CGRectMake(20.0, 10.0, 70, 70);
            stockIssueView.image = [UIImage imageNamed:@"Issue.png"];
            stockIssue.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            stockIssue.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            stockIssue.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            stockIssue.titleLabel.alpha = 0.7f;
        }
        
    }
    else{
        stockIssue.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
        stockIssue.frame = CGRectMake(0.0, 280.0, 200.0, 50.0);
        SIBottomBorder.frame = CGRectMake(0.0f, 55.0f, stockIssue.frame.size.width, 1.0f);
        SIBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        SIBottomBorder.opacity = 0.3f;
        stockIssueView.frame = CGRectMake(5.0, 5, 45, 45);
        stockIssueView.image = [UIImage imageNamed:@"Issue.png"];
        stockIssue.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        stockIssue.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        stockIssue.titleLabel.alpha = 0.7f;
        
    }
    [stockIssue.layer addSublayer:SIBottomBorder];
    stockIssue.hidden = NO;
    stockIssue.backgroundColor = [UIColor clearColor];
    [stockIssue setTitle:@"Stock Issue" forState:UIControlStateNormal];
    
    [stockIssue setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [stockIssue addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [stockIssue addSubview:stockIssueView];
    
    //    stockRequest = [[UIButton alloc] init];
    //    stockRequestView = [[UIImageView alloc] init];
    //
    //    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    //        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
    //
    //            stockRequest.frame = CGRectMake(0.0, 585.0, 750, 90.0);
    //            SREBottomBorder.frame = CGRectMake(0.0f, 100.0f, stockRequest.frame.size.width, 1.0f);
    //            SREBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
    //            SREBottomBorder.opacity = 0.3f;
    //            stockRequestView.frame = CGRectMake(20.0, 10.0, 70, 70);
    //            [stockRequestView setImage:[UIImage imageNamed:@"Issue.png"]];
    //            stockRequest.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
    //            stockRequest.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //            stockRequest.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
    //            stockRequest.titleLabel.alpha = 0.7f;
    //
    //        }
    //        else {
    //            stockRequest.frame = CGRectMake(0.0, 400.0, 560.0, 90.0);
    //            SREBottomBorder.frame = CGRectMake(0.0f, 100.0f, stockRequest.frame.size.width, 1.0f);
    //            SREBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
    //            SREBottomBorder.opacity = 0.3f;
    //            stockRequestView.frame = CGRectMake(20.0, 10.0, 70, 70);
    //            [stockRequestView setImage:[UIImage imageNamed:@"Issue.png"]];
    //            stockRequest.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
    //            stockRequest.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //            stockRequest.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
    //            stockRequest.titleLabel.alpha = 0.7f;
    //        }
    //
    //    }
    //    else{
    //        stockRequest.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
    //        stockRequest.frame = CGRectMake(0.0, 280.0, 200.0, 50.0);
    //        SREBottomBorder.frame = CGRectMake(0.0f, 55.0f, stockRequest.frame.size.width, 1.0f);
    //        SREBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
    //        SREBottomBorder.opacity = 0.3f;
    //        stockRequestView.frame = CGRectMake(5.0, 5, 45, 45);
    //        [stockRequestView setImage:[UIImage imageNamed:@"Issue.png"]];
    //        stockRequest.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //        stockRequest.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
    //        stockRequest.titleLabel.alpha = 0.7f;
    //
    //    }
    //    [stockRequest.layer addSublayer:SREBottomBorder];
    //    stockRequest.hidden = NO;
    //    stockRequest.backgroundColor = [UIColor clearColor];
    //    [stockRequest setTitle:@"Stock Request" forState:UIControlStateNormal];
    //
    //    [stockRequest setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [stockRequest addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    //    [stockRequest addSubview:stockRequestView];
    
    stockReturn = [[UIButton alloc] init];
    stockReturnView = [[UIImageView alloc] init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
            
            stockReturn.frame = CGRectMake(0.0, 680, 750, 90.0);
            SRETBottomBorder.frame = CGRectMake(0.0f, 100.0f, stockReturn.frame.size.width, 1.0f);
            SRETBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            SRETBottomBorder.opacity = 0.3f;
            stockReturnView.frame = CGRectMake(20.0, 10.0, 70, 70);
            stockReturnView.image = [UIImage imageNamed:@"Issue.png"];
            stockReturn.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            stockReturn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            stockReturn.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            stockReturn.titleLabel.alpha = 0.7f;
            
        }
        else {
            stockReturn.frame = CGRectMake(0.0, 400.0, 560.0, 90.0);
            SRETBottomBorder.frame = CGRectMake(0.0f, 100.0f, stockReturn.frame.size.width, 1.0f);
            SRETBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            SRETBottomBorder.opacity = 0.3f;
            stockReturnView.frame = CGRectMake(20.0, 10.0, 70, 70);
            stockReturnView.image = [UIImage imageNamed:@"Issue.png"];
            stockReturn.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            stockReturn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            stockReturn.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            stockReturn.titleLabel.alpha = 0.7f;
        }
        
    }
    else{
        stockReturn.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
        stockReturn.frame = CGRectMake(0.0, 280.0, 200.0, 50.0);
        SRETBottomBorder.frame = CGRectMake(0.0f, 55.0f, stockReturn.frame.size.width, 1.0f);
        SRETBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        SRETBottomBorder.opacity = 0.3f;
        stockReturnView.frame = CGRectMake(5.0, 5, 45, 45);
        stockReturnView.image = [UIImage imageNamed:@"Issue.png"];
        stockReturn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        stockReturn.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        stockReturn.titleLabel.alpha = 0.7f;
        
    }
    [stockReturn.layer addSublayer:SRETBottomBorder];
    stockReturn.hidden = NO;
    stockReturn.backgroundColor = [UIColor clearColor];
    [stockReturn setTitle:@"Stock Return" forState:UIControlStateNormal];
    
    [stockReturn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [stockReturn addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [stockReturn addSubview:stockReturnView];
    
    stocks = [[UILabel alloc] init];
    stocks.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.15f];
    stocks.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
    stocks.font = [UIFont boldSystemFontOfSize:25.0f];
    stocks.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
    stocks.text = @"     STOCK MANAGEMENT";
    stocks.textAlignment = NSTextAlignmentLeft;
    //line.layer.borderColor = [UIColor grayColor].CGColor;
    //line.layer.borderWidth = 2.0f;
    CALayer *SBottomBorder = [CALayer layer];
    CALayer *CBottomBorder = [CALayer layer];
    criticalStock = [[UIButton alloc] init];
    criticalView = [[UIImageView alloc] init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
            
            stocks.frame = CGRectMake(0.0, 10.0, 750, 50.0);
            SBottomBorder.frame = CGRectMake(0.0f, 50.0f, stocks.frame.size.width, 1.0f);
            SBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            SBottomBorder.opacity = 0.3f;
            criticalStock.frame = CGRectMake(0.0, 60.0, 750, 90.0);
            CBottomBorder.frame = CGRectMake(0.0f, 100.0f, criticalStock.frame.size.width, 1.0f);
            CBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            CBottomBorder.opacity = 0.3f;
            criticalView.frame = CGRectMake(20.0, 10.0, 70, 70);
            criticalView.image = [UIImage imageNamed:@"stock request_out.png"]; // Critical@2x.png
            criticalStock.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            criticalStock.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            criticalStock.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            criticalStock.titleLabel.alpha = 0.7f;
            
        }
        else {
            stocks.frame = CGRectMake(0.0, 10.0, 560.0, 50.0);
            SBottomBorder.frame = CGRectMake(0.0f, 50.0f, stocks.frame.size.width, 1.0f);
            SBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            SBottomBorder.opacity = 0.3f;
            criticalStock.frame = CGRectMake(0.0, 60.0, 560.0, 90.0);
            CBottomBorder.frame = CGRectMake(0.0f, 100.0f, criticalStock.frame.size.width, 1.0f);
            CBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            CBottomBorder.opacity = 0.3f;
            criticalView.frame = CGRectMake(20.0, 10.0, 70, 70);
            criticalView.image = [UIImage imageNamed:@"stock request_out.png"];// Critical@2x.png
            criticalStock.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            criticalStock.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            criticalStock.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            criticalStock.titleLabel.alpha = 0.7f;
        }
        
    }
    else{
        
        stocks.frame = CGRectMake(0.0, 2.0, 200.0, 30.0);
        stocks.font = [UIFont boldSystemFontOfSize:14];
        SBottomBorder.frame = CGRectMake(0.0f, 50.0f, stocks.frame.size.width, 1.0f);
        SBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        SBottomBorder.opacity = 0.3f;
        criticalStock.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
        criticalStock.frame = CGRectMake(0.0, 30.0, 200.0, 50.0);
        CBottomBorder.frame = CGRectMake(0.0f, 55.0f, criticalStock.frame.size.width, 1.0f);
        CBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        CBottomBorder.opacity = 0.3f;
        criticalView.frame = CGRectMake(5.0, 5.0, 45.0, 45.0);
        criticalView.image = [UIImage imageNamed:@"stock request_out.png"]; // Critical@2x.png
        criticalStock.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        criticalStock.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        criticalStock.titleLabel.alpha = 0.7f;
        
    }
    stocks.layer.masksToBounds = YES;
    [stocks.layer addSublayer:SBottomBorder];
    
    [criticalStock.layer addSublayer:CBottomBorder];
    criticalStock.hidden = NO;
    criticalStock.backgroundColor = [UIColor clearColor];
    [criticalStock setTitle:@"View Stocks" forState:UIControlStateNormal];
    [criticalStock setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [criticalStock addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [criticalStock addSubview:criticalView];
    //    normalStock = [[UIButton alloc] init];
    //    normalView = [[UIImageView alloc] init];
    //
    //    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    //        normalStock.frame = CGRectMake(0.0, 185.0, 560.0, 110.0);
    //        normalView.frame = CGRectMake(50.0, 10.0, 80, 80);
    //        [normalView setImage:[UIImage imageNamed:@"NormalStock@2x.png"]];
    //        normalStock.titleLabel.font = [UIFont boldSystemFontOfSize:25.0f];
    //    }
    //    else{
    //        normalStock.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    //        normalStock.frame = CGRectMake(0.0, 70.0, 180.0, 50.0);
    //        normalView.frame = CGRectMake(5.0, 10.0, 30.0, 30.0);
    //        [normalView setImage:[UIImage imageNamed:@"NormalStock.png"]];
    //    }
    //    normalStock.hidden = NO;
    //    normalStock.backgroundColor = [UIColor clearColor];
    //    [normalStock setTitle:@"Raw Materials" forState:UIControlStateNormal];
    //    [normalStock setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [normalStock addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    //    [normalStock addSubview:normalView];
    
    
    
    stock = [[UILabel alloc] init];
    stock.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1f];
    stock.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
    stock.font = [UIFont boldSystemFontOfSize:25.0f];
    stock.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
    stock.text = @"     VERIFICATION";
    CALayer *STBottomBorder = [CALayer layer];
    CALayer *SVBottomBorder = [CALayer layer];
    stockVerify = [[UIButton alloc] init];
    stockVerifyView = [[UIImageView alloc] init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
            
            STBottomBorder.frame = CGRectMake(-30.0f, 50.0f, stock.frame.size.width, 1.0f);
            STBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            STBottomBorder.opacity = 0.3f;
            stockVerify.frame = CGRectMake(0.0, 155.0, 750, 90.0);
            SVBottomBorder.frame = CGRectMake(0.0f, 100.0f, stockVerify.frame.size.width, 1.0f);
            SVBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            SVBottomBorder.opacity = 0.3f;
            stockVerifyView.frame = CGRectMake(20.0, 10.0, 70, 70);
            stockVerifyView.image = [UIImage imageNamed:@"StockVerification.png"];
            stockVerify.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
            stockVerify.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            stockVerify.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            stockVerify.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            stockVerify.titleLabel.alpha = 0.7f;
        }
        else {
            STBottomBorder.frame = CGRectMake(-30.0f, 50.0f, stock.frame.size.width, 1.0f);
            STBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            STBottomBorder.opacity = 0.3f;
            stockVerify.frame = CGRectMake(0.0, 155.0, 560.0, 90.0);
            SVBottomBorder.frame = CGRectMake(0.0f, 100.0f, stockVerify.frame.size.width, 1.0f);
            SVBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            SVBottomBorder.opacity = 0.3f;
            stockVerifyView.frame = CGRectMake(20.0, 10.0, 70, 70);
            stockVerifyView.image = [UIImage imageNamed:@"StockVerification.png"];
            stockVerify.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
            stockVerify.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            stockVerify.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            stockVerify.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            stockVerify.titleLabel.alpha = 0.7f;
        }
        // stock.frame = CGRectMake(0.0, 990.0, 560.0, 50.0);
        
    }
    else{
        
        STBottomBorder.frame = CGRectMake(0.0f, 50.0f, stock.frame.size.width, 1.0f);
        STBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        STBottomBorder.opacity = 0.3f;
        stockVerify.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
        stockVerify.frame = CGRectMake(0.0, 85.0, 200.0, 50.0);
        SVBottomBorder.frame = CGRectMake(0.0f, 55.0f, stockVerify.frame.size.width, 1.0f);
        SVBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        SVBottomBorder.opacity = 0.3f;
        stockVerifyView.frame = CGRectMake(5.0, 5, 45, 45);
        stockVerifyView.image = [UIImage imageNamed:@"StockVerification.png"];
        stockVerify.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        stockVerify.titleEdgeInsets = UIEdgeInsetsMake(0,60,0,0);
        stockVerify.titleLabel.alpha = 0.7f;
        
    }
    stock.layer.masksToBounds = YES;
    [stock.layer addSublayer:STBottomBorder];
    [stockVerify.layer addSublayer:SVBottomBorder];
    stockVerify.hidden = NO;
    stockVerify.backgroundColor = [UIColor clearColor];
    [stockVerify setTitle:@"Verify Stocks" forState:UIControlStateNormal];
    [stockVerify setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [stockVerify addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [stockVerify addSubview:stockVerifyView];
    // [scrollView addSubview:stock];
    [scrollView addSubview:stockVerify];
    
    CALayer *VSRBottomBorder = [CALayer layer];
    CALayer *VSRBottomBorder_ = [CALayer layer];
    verifiedStockReport = [[UIButton alloc] init];
    verifiedStockReportView = [[UIImageView alloc] init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
            
            VSRBottomBorder.frame = CGRectMake(-30.0f, 50.0f, stock.frame.size.width, 1.0f);
            VSRBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            VSRBottomBorder.opacity = 0.3f;
            verifiedStockReport.frame = CGRectMake(0.0, 250.0, 750, 90.0);
            VSRBottomBorder_.frame = CGRectMake(0.0f, 100.0f, verifiedStockReport.frame.size.width, 1.0f);
            VSRBottomBorder_.backgroundColor = [UIColor grayColor].CGColor;
            VSRBottomBorder_.opacity = 0.3f;
            verifiedStockReportView.frame = CGRectMake(20.0, 10.0, 70, 70);
            verifiedStockReportView.image = [UIImage imageNamed:@"StockVerification.png"];
            verifiedStockReport.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
            verifiedStockReport.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            verifiedStockReport.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            verifiedStockReport.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            verifiedStockReport.titleLabel.alpha = 0.7f;
        }
        else {
            VSRBottomBorder.frame = CGRectMake(-30.0f, 50.0f, stock.frame.size.width, 1.0f);
            VSRBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            VSRBottomBorder.opacity = 0.3f;
            stockVerify.frame = CGRectMake(0.0, 250.0, 560.0, 90.0);
            VSRBottomBorder_.frame = CGRectMake(0.0f, 100.0f, verifiedStockReport.frame.size.width, 1.0f);
            VSRBottomBorder_.backgroundColor = [UIColor grayColor].CGColor;
            VSRBottomBorder_.opacity = 0.3f;
            verifiedStockReportView.frame = CGRectMake(20.0, 10.0, 70, 70);
            verifiedStockReportView.image = [UIImage imageNamed:@"StockVerification.png"];
            verifiedStockReport.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
            verifiedStockReport.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            verifiedStockReport.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            verifiedStockReport.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            verifiedStockReport.titleLabel.alpha = 0.7f;
        }
        // stock.frame = CGRectMake(0.0, 990.0, 560.0, 50.0);
        
    }
    else{
        
        VSRBottomBorder.frame = CGRectMake(0.0f, 50.0f, stock.frame.size.width, 1.0f);
        VSRBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        VSRBottomBorder.opacity = 0.3f;
        verifiedStockReport.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
        verifiedStockReport.frame = CGRectMake(0.0, 135.0, 200.0, 50.0);
        VSRBottomBorder_.frame = CGRectMake(0.0f, 55.0f, verifiedStockReport.frame.size.width, 1.0f);
        VSRBottomBorder_.backgroundColor = [UIColor grayColor].CGColor;
        VSRBottomBorder_.opacity = 0.3f;
        verifiedStockReportView.frame = CGRectMake(5.0, 5, 45, 45);
        verifiedStockReportView.image = [UIImage imageNamed:@"StockVerification.png"];
        verifiedStockReport.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        verifiedStockReport.titleEdgeInsets = UIEdgeInsetsMake(0,60,0,0);
        verifiedStockReport.titleLabel.alpha = 0.7f;
        
    }
    stock.layer.masksToBounds = YES;
    [stock.layer addSublayer:VSRBottomBorder];
    [verifiedStockReport.layer addSublayer:VSRBottomBorder_];
    verifiedStockReport.hidden = NO;
    verifiedStockReport.backgroundColor = [UIColor clearColor];
    [verifiedStockReport setTitle:@"Verified Stock Report" forState:UIControlStateNormal];
    [verifiedStockReport setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [verifiedStockReport addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [verifiedStockReport addSubview:verifiedStockReportView];
    // [scrollView addSubview:stock];
    [scrollView addSubview:verifiedStockReport];
    
    
    goodsProcurement = [[UILabel alloc] init];
    goodsProcurement.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.15f];
    goodsProcurement.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
    goodsProcurement.font = [UIFont boldSystemFontOfSize:25.0f];
    goodsProcurement.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
    goodsProcurement.text = @"      GOODS PROCUREMENT";
    goodsProcurement.textAlignment = NSTextAlignmentLeft;
    goodsProcurement.shadowColor = [UIColor grayColor];
    goodsProcurement.shadowOffset = CGSizeMake(0, 0);
    //line.layer.borderColor = [UIColor grayColor].CGColor;
    //line.layer.borderWidth = 2.0f;
    CALayer *GPBottomBorder = [CALayer layer];
    CALayer *PBottomBorder = [CALayer layer];
    CALayer *SHIBottomBorder = [CALayer layer];
    CALayer *RBottomBorder = [CALayer layer];
    purchases = [[UIButton alloc] init];
    purchaseView = [[UIImageView alloc] init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
            
            goodsProcurement.frame = CGRectMake(0.0, 780, 750, 50.0);
            GPBottomBorder.frame = CGRectMake(0.0f, 50.0f, goodsProcurement.frame.size.width, 1.0f);
            GPBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            GPBottomBorder.opacity = 0.3f;
            purchases.frame = CGRectMake(0.0, 835, 750, 90.0);
            PBottomBorder.frame = CGRectMake(0.0f, 100.0f, purchases.frame.size.width, 1.0f);
            PBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            PBottomBorder.opacity = 0.3f;
            purchaseView.frame = CGRectMake(20.0, 10.0, 70, 70);
            purchaseView.image = [UIImage imageNamed:@"purchase_icon.png"];
            purchases.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
            purchases.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            purchases.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            purchases.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            purchases.titleLabel.alpha = 0.7f;
        }
        else {
            goodsProcurement.frame = CGRectMake(0.0, 500.0, 560.0, 50.0);
            GPBottomBorder.frame = CGRectMake(0.0f, 50.0f, goodsProcurement.frame.size.width, 1.0f);
            GPBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            GPBottomBorder.opacity = 0.3f;
            purchases.frame = CGRectMake(0.0, 550.0, 560.0, 90.0);
            PBottomBorder.frame = CGRectMake(0.0f, 100.0f, purchases.frame.size.width, 1.0f);
            PBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            PBottomBorder.opacity = 0.3f;
            purchaseView.frame = CGRectMake(20.0, 10.0, 70, 70);
            purchaseView.image = [UIImage imageNamed:@"purchase_icon.png"];
            purchases.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
            purchases.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            purchases.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            purchases.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            purchases.titleLabel.alpha = 0.7f;
        }
        
    }
    else{
        
        goodsProcurement.frame = CGRectMake(0.0, 335.0, 200.0, 30.0);
        goodsProcurement.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:14.0f];
        GPBottomBorder.frame = CGRectMake(0.0f, 50.0f, goodsProcurement.frame.size.width, 1.0f);
        GPBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        GPBottomBorder.opacity = 0.3f;
        purchases.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
        purchases.frame = CGRectMake(0.0, 370, 200.0, 50.0);
        PBottomBorder.frame = CGRectMake(0.0f, 55.0f, purchases.frame.size.width, 1.0f);
        PBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        PBottomBorder.opacity = 0.3f;
        purchaseView.frame = CGRectMake(5.0, 5.0, 45.0, 45.0);
        purchaseView.image = [UIImage imageNamed:@"purchase_icon.png"];
        purchases.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        purchases.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        purchases.titleLabel.alpha = 0.7f;
        
        if (version >= 8.0) {
            GPBottomBorder.frame = CGRectMake(0.0f, 30.0f, goodsProcurement.frame.size.width, 1.0f);
        }
    }
    [goodsProcurement.layer addSublayer:GPBottomBorder];
    [purchases.layer addSublayer:PBottomBorder];
    purchases.hidden = NO;
    purchases.backgroundColor = [UIColor clearColor];
    [purchases setTitle:@"Purchases" forState:UIControlStateNormal];
    //    purchases.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //    purchases.titleEdgeInsets = UIEdgeInsetsMake(0, 150, 0, 0);
    [purchases setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [purchases addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [purchases addSubview:purchaseView];
    
    shipments = [[UIButton alloc] init];
    shipmentView = [[UIImageView alloc] init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
            
            shipments.frame = CGRectMake(0.0, 930.0, 750, 90.0);
            SHIBottomBorder.frame = CGRectMake(0.0f, 100.0f, shipments.frame.size.width, 1.0f);
            SHIBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            SHIBottomBorder.opacity = 0.3f;
            shipmentView.frame = CGRectMake(20.0, 10.0, 70, 70);
            shipmentView.image = [UIImage imageNamed:@"shipment_icon.png"];
            shipments.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
            shipments.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            shipments.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            shipments.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            shipments.titleLabel.alpha = 0.7f;
        }
        else {
            shipments.frame = CGRectMake(0.0, 645.0, 560.0, 90.0);
            SHIBottomBorder.frame = CGRectMake(0.0f, 100.0f, shipments.frame.size.width, 1.0f);
            SHIBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            SHIBottomBorder.opacity = 0.3f;
            shipmentView.frame = CGRectMake(20.0, 10.0, 70, 70);
            shipmentView.image = [UIImage imageNamed:@"shipment_icon.png"];
            shipments.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
            shipments.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            shipments.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            shipments.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            shipments.titleLabel.alpha = 0.7f;
        }
        
    }
    else{
        shipments.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
        shipments.frame = CGRectMake(0.0, 425, 200.0, 50.0);
        SHIBottomBorder.frame = CGRectMake(0.0f, 55.0f, shipments.frame.size.width, 1.0f);
        SHIBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        SHIBottomBorder.opacity = 0.3f;
        shipmentView.frame = CGRectMake(5.0, 5, 45, 45);
        shipmentView.image = [UIImage imageNamed:@"shipment_icon.png"];
        shipments.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        shipments.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        shipments.titleLabel.alpha = 0.7f;
        
    }
    [shipments.layer addSublayer:SHIBottomBorder];
    shipments.hidden = NO;
    shipments.backgroundColor = [UIColor clearColor];
    [shipments setTitle:@"Shipments" forState:UIControlStateNormal];
    
    [shipments setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shipments addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [shipments addSubview:shipmentView];
    
    receipts = [[UIButton alloc] init];
    receiptView = [[UIImageView alloc] init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
            
            receipts.frame = CGRectMake(0.0, 1025, line.frame.size.width, 90.0);
            RBottomBorder.frame = CGRectMake(0.0f, 100.0f, receipts.frame.size.width, 1.0f);
            RBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            RBottomBorder.opacity = 0.3f;
            receiptView.frame = CGRectMake(20.0, 10.0, 70, 70);
            receiptView.image = [UIImage imageNamed:@"Receipts.png"];
            receipts.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
            receipts.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            receipts.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            receipts.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            receipts.titleLabel.alpha = 0.7f;
        }
        else {
            receipts.frame = CGRectMake(0.0, 740.0, 560.0, 90.0);
            RBottomBorder.frame = CGRectMake(0.0f, 100.0f, receipts.frame.size.width, 1.0f);
            RBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            RBottomBorder.opacity = 0.3f;
            receiptView.frame = CGRectMake(20.0, 10.0, 70, 70);
            receiptView.image = [UIImage imageNamed:@"Receipts.png"];
            receipts.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
            receipts.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            receipts.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            receipts.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            receipts.titleLabel.alpha = 0.7f;
        }
        
    }
    else{
        receipts.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
        receipts.frame = CGRectMake(0.0, 480, 200.0, 50.0);
        RBottomBorder.frame = CGRectMake(0.0f, 55.0f, receipts.frame.size.width, 1.0f);
        RBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        RBottomBorder.opacity = 0.3f;
        receiptView.frame = CGRectMake(5.0, 5.0, 45, 45);
        receiptView.image = [UIImage imageNamed:@"Receipts.png"];
        receipts.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        receipts.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        receipts.titleLabel.alpha = 0.7f;
        
    }
    [receipts.layer addSublayer:RBottomBorder];
    receipts.hidden = NO;
    receipts.backgroundColor = [UIColor clearColor];
    [receipts setTitle:@"Receipts" forState:UIControlStateNormal];
    
    [receipts setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [receipts addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [receipts addSubview:receiptView];
    
    delivers = [[UILabel alloc] init];
    delivers.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.15f];
    delivers.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
    delivers.font = [UIFont boldSystemFontOfSize:25.0f];
    delivers.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
    delivers.text = @"      DELIVERIES";
    delivers.textAlignment = NSTextAlignmentLeft;
    //line.layer.borderColor = [UIColor grayColor].CGColor;
    //line.layer.borderWidth = 2.0f;
    CALayer *DBottomBorder = [CALayer layer];
    CALayer *OBottomBorder = [CALayer layer];
    CALayer *SHBottomBorder = [CALayer layer];
    
    orders = [[UIButton alloc] init];
    reorderView = [[UIImageView alloc] init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
            
            delivers.frame = CGRectMake(0.0, 1125.0, line.frame.size.width, 50.0);
            DBottomBorder.frame = CGRectMake(0.0f, 50.0f, delivers.frame.size.width, 1.0f);
            DBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            DBottomBorder.opacity = 0.3f;
            orders.frame = CGRectMake(0.0, 1175, line.frame.size.width, 90.0);
            OBottomBorder.frame = CGRectMake(0.0f, 100.0f, orders.frame.size.width, 1.0f);
            OBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            OBottomBorder.opacity = 0.3f;
            [orders.layer addSublayer:OBottomBorder];
            reorderView.frame = CGRectMake(20.0, 10.0, 70, 70);
            reorderView.image = [UIImage imageNamed:@"ReOrders.png"];
            orders.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            orders.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            orders.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            orders.titleLabel.alpha = 0.7f;
        }
        else {
            delivers.frame = CGRectMake(0.0, 840.0, 560.0, 50.0);
            DBottomBorder.frame = CGRectMake(0.0f, 50.0f, delivers.frame.size.width, 1.0f);
            DBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            DBottomBorder.opacity = 0.3f;
            orders.frame = CGRectMake(0.0, 890.0, 560.0, 90.0);
            OBottomBorder.frame = CGRectMake(0.0f, 100.0f, orders.frame.size.width, 1.0f);
            OBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            OBottomBorder.opacity = 0.3f;
            [orders.layer addSublayer:OBottomBorder];
            reorderView.frame = CGRectMake(20.0, 10.0, 70, 70);
            reorderView.image = [UIImage imageNamed:@"ReOrders.png"];
            orders.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            orders.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            orders.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            orders.titleLabel.alpha = 0.7f;
        }
        
    }
    else{
        
        delivers.frame = CGRectMake(0.0, 535, 200.0, 30);
        delivers.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:14.0f];
        DBottomBorder.frame = CGRectMake(0.0f, 55.0f, delivers.frame.size.width, 1.0f);
        DBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        DBottomBorder.opacity = 0.3f;
        orders.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
        orders.frame = CGRectMake(0.0, 570, 200.0, 50.0);
        OBottomBorder.frame = CGRectMake(0.0f, 55.0f, orders.frame.size.width, 1.0f);
        OBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        OBottomBorder.opacity = 0.3f;
        reorderView.frame = CGRectMake(5.0, 5.0, 45, 45.0);
        reorderView.image = [UIImage imageNamed:@"ReOrders.png"];
        orders.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        orders.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        orders.titleLabel.alpha = 0.7f;
        
    }
    delivers.layer.masksToBounds = YES;
    [delivers.layer addSublayer:DBottomBorder];
    [orders.layer addSublayer:OBottomBorder];
    orders.hidden = NO;
    orders.backgroundColor = [UIColor clearColor];
    [orders setTitle:@"Orders" forState:UIControlStateNormal];
    
    [orders setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [orders addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [orders addSubview:reorderView];
    
    shipments_ = [[UIButton alloc] init];
    verifyView = [[UIImageView alloc] init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
            
            shipments_.frame = CGRectMake(0.0, 1270.0, line.frame.size.width, 90.0);
            SHBottomBorder.frame = CGRectMake(0.0f, 100.0f, shipments_.frame.size.width, 1.0f);
            SHBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            SHBottomBorder.opacity = 0.3f;
            verifyView.frame = CGRectMake(20.0, 10.0, 70, 70);
            verifyView.image = [UIImage imageNamed:@"shipment_icon.png"];
            shipments_.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
            shipments_.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            shipments_.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            shipments_.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            shipments_.titleLabel.alpha = 0.7f;
        }
        else {
            shipments_.frame = CGRectMake(0.0, 985.0, 560.0, 90.0);
            SHBottomBorder.frame = CGRectMake(0.0f, 100.0f, shipments_.frame.size.width, 1.0f);
            SHBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            SHBottomBorder.opacity = 0.3f;
            verifyView.frame = CGRectMake(20.0, 10.0, 70, 70);
            verifyView.image = [UIImage imageNamed:@"shipment_icon.png"];
            shipments_.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
            shipments_.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            shipments_.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            shipments_.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            shipments_.titleLabel.alpha = 0.7f;
        }
        
    }
    else{
        shipments_.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        shipments_.frame = CGRectMake(0.0, 625, 200.0, 50.0);
        SHBottomBorder.frame = CGRectMake(0.0f, 55.0f, shipments_.frame.size.width, 1.0f);
        SHBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        SHBottomBorder.opacity = 0.3f;
        verifyView.frame = CGRectMake(5.0, 5, 45, 45);
        verifyView.image = [UIImage imageNamed:@"shipment_icon.png"];
        shipments_.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        shipments_.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        shipments_.titleLabel.alpha = 0.7f;
        
    }
    [shipments_.layer addSublayer:SHBottomBorder];
    shipments_.hidden = NO;
    shipments_.backgroundColor = [UIColor clearColor];
    [shipments_ setTitle:@"Shipments" forState:UIControlStateNormal];
    
    [shipments_ setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shipments_ addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [shipments_ addSubview:verifyView];
    
    
    
    dealsButton = [[UIButton alloc] init];
    dealsView = [[UIImageView alloc] init];
    dealsView.image = [UIImage imageNamed:@"CurrentDeals_New.png"];
    CALayer *dealsBottomBorder = [CALayer layer];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
            
            dealsButton.frame = CGRectMake(0.0, 0, line.frame.size.width, 90.0);
            dealsView.frame = CGRectMake(20.0, 10.0, 70, 70);
            dealsView.image = [UIImage imageNamed:@"CurrentDeals_New.png"];
            dealsButton.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
            dealsButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            dealsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            dealsButton.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            dealsButton.layer.borderWidth = 0.5f;
            dealsButton.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
            dealsButton.titleLabel.alpha = 0.7f;
        }
        else {
            dealsButton.frame = CGRectMake(0.0, 65.0, 560.0, 90.0);
            dealsView.frame = CGRectMake(20.0, 10.0, 70, 70);
            dealsView.image = [UIImage imageNamed:@"CurrentDeals_New.png"];
            dealsButton.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
            dealsButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            dealsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            dealsButton.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            dealsButton.layer.borderWidth = 0.5f;
            dealsButton.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
            dealsButton.titleLabel.alpha = 0.7f;
        }
        
    }
    else{
        dealsButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        dealsButton.frame = CGRectMake(0.0, 50.0, 200.0, 50.0);
        dealsView.frame = CGRectMake(5.0, 5.0, 45, 45);
        dealsView.image = [UIImage imageNamed:@"CurrentDeals_New.png"];
        dealsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        dealsButton.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        dealsButton.layer.borderWidth = 0.5f;
        dealsButton.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
        dealsButton.titleLabel.alpha = 0.7f;
        dealsBottomBorder.frame = CGRectMake(0.0f, 55.0f, dealsButton.frame.size.width, 1.0f);
        dealsBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        dealsBottomBorder.opacity = 0.5f;
        dealsButton.titleLabel.alpha = 0.7f;
        
    }
    [dealsButton.layer addSublayer:dealsBottomBorder];
    dealsButton.hidden = YES;
    dealsButton.backgroundColor = [UIColor clearColor];
    [dealsButton setTitle:@"Deals" forState:UIControlStateNormal];
    
    [dealsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [dealsButton addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [dealsButton addSubview:dealsView];
    
    offersButton = [[UIButton alloc] init];
    offersView = [[UIImageView alloc] init];
    offersView.image = [UIImage imageNamed:@"Offers_New.png"];
    offersBottomBorder = [CALayer layer];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
            
            offersButton.frame = CGRectMake(0.0, dealsButton.frame.origin.y + dealsButton.frame.size.height, line.frame.size.width, 90.0);
            offersView.frame = CGRectMake(20.0, 10.0, 70, 70);
            offersView.image = [UIImage imageNamed:@"Offers_New.png"];
            offersButton.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
            offersButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            offersButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            offersButton.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            offersButton.layer.borderWidth = 0.5f;
            offersButton.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
            offersButton.titleLabel.alpha = 0.7f;
            offersBottomBorder.frame = CGRectMake(0.0f, 100.0f, offersButton.frame.size.width, 1.0f);
            offersBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            offersBottomBorder.opacity = 0.3f;
        }
        else {
            offersButton.frame = CGRectMake(0.0, 160.0, 560.0, 90.0);
            offersView.frame = CGRectMake(20.0, 10.0, 70, 70);
            offersView.image = [UIImage imageNamed:@"Offers_New.png"];
            offersButton.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
            offersButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            offersButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            offersButton.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            offersButton.layer.borderWidth = 0.5f;
            offersButton.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
            offersButton.titleLabel.alpha = 0.7f;
            offersBottomBorder.frame = CGRectMake(0.0f, 100.0f, offersButton.frame.size.width, 1.0f);
            offersBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            offersBottomBorder.opacity = 0.3f;
        }
        
    }
    else{
        offersButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        offersButton.frame = CGRectMake(0.0, 110.0, 200.0, 50.0);
        offersView.frame = CGRectMake(5.0, 5, 45, 45);
        offersView.image = [UIImage imageNamed:@"Offers_New.png"];
        offersButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        offersButton.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        offersBottomBorder.frame = CGRectMake(0.0f, 55.0f, offersButton.frame.size.width, 1.0f);
        offersBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        offersBottomBorder.opacity = 0.5f;
        offersButton.titleLabel.alpha = 0.7f;
        
    }
    [offersButton.layer addSublayer:offersBottomBorder];
    offersButton.hidden = YES;
    offersButton.backgroundColor = [UIColor clearColor];
    [offersButton setTitle:@"Offers" forState:UIControlStateNormal];
    
    [offersButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [offersButton addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [offersButton addSubview:offersView];
    
    newOrders = [[UIButton alloc] init];
    newOrderView = [[UIImageView alloc] init];
    newOrderView.image = [UIImage imageNamed:@"NewOrder.png"];
    CALayer *dOrdersBottomBorder_ = [CALayer layer];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
            
            newOrders.frame = CGRectMake(0.0, 0, line.frame.size.width, 90.0);
            newOrderView.frame = CGRectMake(20.0, 10.0, 70, 70);
            newOrderView.image = [UIImage imageNamed:@"Orders_New.png"];
            newOrders.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            newOrders.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            newOrders.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            newOrders.layer.borderWidth = 0.5f;
            newOrders.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
            newOrders.titleLabel.alpha = 0.7f;
            
        }
        else {
            newOrders.frame = CGRectMake(0.0, 65.0, 560.0, 90.0);
            newOrderView.frame = CGRectMake(20.0, 10.0, 70, 70);
            newOrderView.image = [UIImage imageNamed:@"Orders_New.png"];
            newOrders.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            newOrders.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            newOrders.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            newOrders.layer.borderWidth = 0.5f;
            newOrders.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
            newOrders.titleLabel.alpha = 0.7f;
        }
        
    }
    else{
        newOrders.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
        newOrders.frame = CGRectMake(0.0, 50.0, 200.0, 50.0);
        newOrderView.frame = CGRectMake(5.0, 5.0, 45, 45);
        newOrderView.image = [UIImage imageNamed:@"Orders_New.png"];
        newOrders.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        newOrders.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        newOrders.layer.borderWidth = 0.5f;
        // newOrders.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
        newOrders.titleLabel.alpha = 0.7f;
        if (version >= 8.0) {
            dOrdersBottomBorder_.frame = CGRectMake(0.0f, 55.0f, newOrders.frame.size.width, 1.0f);
            // dOrdersBottomBorder_.backgroundColor = [UIColor grayColor].CGColor;
            dOrdersBottomBorder_.opacity = 0.5f;
            [newOrders.layer addSublayer:dOrdersBottomBorder_];
            
        }
        newOrders.titleLabel.alpha = 0.7f;
        
    }
    newOrders.hidden = YES;
    newOrders.backgroundColor = [UIColor clearColor];
    [newOrders setTitle:@"Orders" forState:UIControlStateNormal];
    [newOrders setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [newOrders addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [newOrders addSubview:newOrderView];
    
    oldOrders = [[UIButton alloc] init];
    oldOrderView = [[UIImageView alloc] init];
    oldOrderView.image = [UIImage imageNamed:@"OldOrder.png"];
    CALayer *oOrdersBottomBorder = [CALayer layer];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
            
            oldOrders.frame = CGRectMake(0.0, newOrders.frame.origin.y + newOrders.frame.size.height, line.frame.size.width, 90.0);
            oldOrderView.frame = CGRectMake(20.0, 10.0, 70, 70);
            oldOrderView.image = [UIImage imageNamed:@"Orders_Pending.png"];
            oldOrders.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            oldOrders.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            oldOrders.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            oldOrders.layer.borderWidth = 0.5f;
            oldOrders.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
            oldOrders.titleLabel.alpha = 0.7f;
            
        }
        else {
            oldOrders.frame = CGRectMake(0.0, 160.0, 560.0, 90.0);
            oldOrderView.frame = CGRectMake(20.0, 10.0, 70, 70);
            oldOrderView.image = [UIImage imageNamed:@"Orders_Pending.png"];
            oldOrders.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
            oldOrders.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            oldOrders.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
            oldOrders.layer.borderWidth = 0.5f;
            oldOrders.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
            oldOrders.titleLabel.alpha = 0.7f;
        }
        
    }
    else{
        oldOrders.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
        oldOrders.frame = CGRectMake(0.0, 110.0, 180.0, 50.0);
        oldOrderView.frame = CGRectMake(5.0, 5.0, 45, 45);
        oldOrderView.image = [UIImage imageNamed:@"Orders_Pending.png"];
        oldOrders.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        oldOrders.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        oldOrders.titleLabel.alpha = 0.7f;
        
    }
    oldOrders.hidden = YES;
    oldOrders.backgroundColor = [UIColor clearColor];
    [oldOrders setTitle:@"Pending Orders" forState:UIControlStateNormal];
    
    [oldOrders.layer addSublayer:oOrdersBottomBorder];
    
    [oldOrders setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [oldOrders addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [oldOrders addSubview:oldOrderView];
    
    dOrder = [[UIButton alloc] init];
    dorderView = [[UIImageView alloc] init];
    dorderView.image = [UIImage imageNamed:@"NewOrder.png"];
    CALayer *dOrdersBottomBorder = [CALayer layer];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        dOrder.frame = CGRectMake(0.0,  oldOrders.frame.origin.y + oldOrders.frame.size.height, line.frame.size.width, 90.0);
        dorderView.frame = CGRectMake(20.0, 10.0, 70, 70);
        dorderView.image = [UIImage imageNamed:@"Orders_Delivered.png"];
        dOrder.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
        dOrder.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        dOrder.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
        dOrder.layer.borderWidth = 0.5f;
        dOrder.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
        dOrder.titleLabel.alpha = 0.7f;
    }
    else{
        dOrder.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
        dOrder.frame = CGRectMake(0.0, 170.0, 200, 50.0);
        dorderView.frame = CGRectMake(5.0, 5, 45, 45);
        dorderView.image = [UIImage imageNamed:@"Orders_Delivered.png"];
        dOrder.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        dOrder.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        dOrder.layer.borderWidth = 0.5f;
        dOrder.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
        dOrder.titleLabel.alpha = 0.7f;
        dOrdersBottomBorder.frame = CGRectMake(0.0f, 55.0f, dOrder.frame.size.width, 1.0f);
        //        dOrdersBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        dOrdersBottomBorder.opacity = 0.5f;
        dOrder.titleLabel.alpha = 0.7f;
        
    }
    [dOrder.layer addSublayer:dOrdersBottomBorder];
    dOrder.hidden = YES;
    dOrder.backgroundColor = [UIColor clearColor];
    [dOrder setTitle:@"Delivered Orders" forState:UIControlStateNormal];
    
    [dOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [dOrder addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [dOrder addSubview:dorderView];
    
    complaints = [[UIButton alloc] init];
    complaintView = [[UIImageView alloc] init];
    complaintView.image = [UIImage imageNamed:@"Complaints_Order.png"];
    complaintsBottomBorder = [CALayer layer];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        complaints.frame = CGRectMake(0.0, dOrder.frame.origin.y + dOrder.frame.size.height, line.frame.size.width, 90.0);
        complaintView.frame = CGRectMake(20.0, 10.0, 70, 70);
        complaintView.image = [UIImage imageNamed:@"Orders_Complaints.png"];
        complaints.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
        complaints.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        complaints.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
        complaints.layer.borderWidth = 0.5f;
        complaints.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
        complaints.titleLabel.alpha = 0.7f;
        complaintsBottomBorder.frame = CGRectMake(0.0f, 100.0f, complaints.frame.size.width, 1.0f);
        complaintsBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        complaintsBottomBorder.opacity = 0.3f;
    }
    else{
        complaints.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
        complaints.frame = CGRectMake(0.0, 230.0, 200.0, 50.0);
        complaintView.frame = CGRectMake(5.0, 5, 45, 45);
        complaintView.image = [UIImage imageNamed:@"Orders_Complaints.png"];
        complaints.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        complaints.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        complaintsBottomBorder.frame = CGRectMake(0.0f, 55.0f, complaints.frame.size.width, 1.0f);
        complaintsBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        complaintsBottomBorder.opacity = 0.5f;
        complaints.titleLabel.alpha = 0.7f;
        
    }
    [complaints.layer addSublayer:complaintsBottomBorder];
    complaints.hidden = YES;
    complaints.backgroundColor = [UIColor clearColor];
    [complaints setTitle:@"Complaints" forState:UIControlStateNormal];
    
    [complaints setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [complaints addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [complaints addSubview:complaintView];
    
    newReports = [[UIButton alloc] init];
    newReportView = [[UIImageView alloc] init];
    newReportView.image = [UIImage imageNamed:@"SalesReport.png"];
    CALayer *nReportBottomBorder = [CALayer layer];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        newReports.frame = CGRectMake(0.0, 0, line.frame.size.width, 90.0);
        newReportView.frame = CGRectMake(20.0, 10.0, 70, 70);
        newReportView.image = [UIImage imageNamed:@"SalesReport@2x.png"];
        newReports.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
        newReports.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
        newReports.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        newReports.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
        newReports.layer.borderWidth = 0.5f;
        newReports.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
        newReports.titleLabel.alpha = 0.7f;
    }
    else{
        newReports.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
        newReports.frame = CGRectMake(0.0, 50.0, 200.0, 50.0);
        newReportView.frame = CGRectMake(5.0, 5.0, 45.0, 45.0);
        newReportView.image = [UIImage imageNamed:@"SalesReport.png"];
        newReports.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        newReports.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        newReports.layer.borderWidth = 0.5f;
        newReports.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
        newReports.titleLabel.alpha = 0.7f;
        nReportBottomBorder.frame = CGRectMake(0.0f, 55.0f, newReports.frame.size.width, 1.0f);
        nReportBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        nReportBottomBorder.opacity = 0.3f;
        newReports.titleLabel.alpha = 0.7f;
        
    }
    [newReports.layer addSublayer:nReportBottomBorder];
    newReports.hidden = YES;
    newReports.backgroundColor = [UIColor clearColor];
    [newReports setTitle:@"Sales Reports" forState:UIControlStateNormal];
    
    [newReports setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [newReports addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [newReports addSubview:newReportView];
    
    oldReports = [[UIButton alloc] init];
    oldReportView = [[UIImageView alloc] init];
    oldReportView.image = [UIImage imageNamed:@"Order_Reports.png"];
    orderBottomBorder = [CALayer layer];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        oldReports.frame = CGRectMake(0.0,  newReports.frame.origin.y + newReports.frame.size.height, line.frame.size.width, 90.0);
        oldReportView.frame = CGRectMake(20.0, 10.0, 70, 70);
        oldReportView.image = [UIImage imageNamed:@"Order_Reports@2x.png"];
        oldReports.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
        oldReports.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
        oldReports.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        oldReports.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
        oldReports.layer.borderWidth = 0.5f;
        oldReports.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
        oldReports.titleLabel.alpha = 0.7f;
        orderBottomBorder.frame = CGRectMake(0.0f, 100.0f, oldReports.frame.size.width, 1.0f);
        orderBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        orderBottomBorder.opacity = 0.3f;
    }
    else{
        oldReports.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
        oldReports.frame = CGRectMake(0.0, 110.0, 200.0, 50.0);
        oldReportView.frame = CGRectMake(5.0, 5.0, 45.0, 45.0);
        oldReportView.image = [UIImage imageNamed:@"Order_Reports.png"];
        oldReports.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        oldReports.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        orderBottomBorder.frame = CGRectMake(0.0f, 55.0f, oldReports.frame.size.width, 1.0f);
        orderBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        orderBottomBorder.opacity = 0.5f;
        oldReports.titleLabel.alpha = 0.7f;
        
    }
    [oldReports.layer addSublayer:orderBottomBorder];
    oldReports.hidden = YES;
    oldReports.backgroundColor = [UIColor clearColor];
    [oldReports setTitle:@"Order Reports" forState:UIControlStateNormal];
    [oldReports setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [oldReports addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [oldReports addSubview:oldReportView];
    
    XZreport = [[UIButton alloc] init];
    xzView = [[UIImageView alloc] init];
    xzView.image = [UIImage imageNamed:@"Order_Reports.png"];
    orderBottomBorder = [CALayer layer];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        XZreport.frame = CGRectMake(0.0,  oldReports.frame.origin.y + oldReports.frame.size.height, line.frame.size.width, 90.0);
        xzView.frame = CGRectMake(20.0, 10.0, 70, 70);
        xzView.image = [UIImage imageNamed:@"Order_Reports@2x.png"];
        XZreport.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
        XZreport.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
        XZreport.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        XZreport.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
        XZreport.layer.borderWidth = 0.5f;
        XZreport.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
        XZreport.titleLabel.alpha = 0.7f;
        orderBottomBorder.frame = CGRectMake(0.0f, 100.0f, XZreport.frame.size.width, 1.0f);
        orderBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        orderBottomBorder.opacity = 0.3f;
    }
    else{
        oldReports.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
        oldReports.frame = CGRectMake(0.0, 110.0, 200.0, 50.0);
        oldReportView.frame = CGRectMake(5.0, 5.0, 45.0, 45.0);
        oldReportView.image = [UIImage imageNamed:@"Order_Reports.png"];
        oldReports.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        oldReports.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        orderBottomBorder.frame = CGRectMake(0.0f, 55.0f, oldReports.frame.size.width, 1.0f);
        orderBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        orderBottomBorder.opacity = 0.5f;
        oldReports.titleLabel.alpha = 0.7f;
        
    }
    [XZreport.layer addSublayer:orderBottomBorder];
    XZreport.hidden = YES;
    XZreport.backgroundColor = [UIColor clearColor];
    [XZreport setTitle:@"X Reading" forState:UIControlStateNormal];
    [XZreport setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [XZreport addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [XZreport addSubview:xzView];
    
    zreading = [[UIButton alloc] init];
    xView = [[UIImageView alloc] init];
    xView.image = [UIImage imageNamed:@"Order_Reports.png"];
    orderBottomBorder = [CALayer layer];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        zreading.frame = CGRectMake(0.0,  XZreport.frame.origin.y + XZreport.frame.size.height, line.frame.size.width, 90.0);
        xView.frame = CGRectMake(20.0, 10.0, 70, 70);
        xView.image = [UIImage imageNamed:@"Order_Reports@2x.png"];
        zreading.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
        zreading.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
        zreading.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        zreading.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
        zreading.layer.borderWidth = 0.5f;
        zreading.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
        zreading.titleLabel.alpha = 0.7f;
        orderBottomBorder.frame = CGRectMake(0.0f, 100.0f, zreading.frame.size.width, 1.0f);
        orderBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        orderBottomBorder.opacity = 0.3f;
    }
    else{
        oldReports.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
        oldReports.frame = CGRectMake(0.0, 110.0, 200.0, 50.0);
        oldReportView.frame = CGRectMake(5.0, 5.0, 45.0, 45.0);
        oldReportView.image = [UIImage imageNamed:@"Order_Reports.png"];
        oldReports.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        oldReports.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        orderBottomBorder.frame = CGRectMake(0.0f, 55.0f, oldReports.frame.size.width, 1.0f);
        orderBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        orderBottomBorder.opacity = 0.5f;
        oldReports.titleLabel.alpha = 0.7f;
        
    }
    [zreading.layer addSublayer:orderBottomBorder];
    zreading.hidden = YES;
    zreading.backgroundColor = [UIColor clearColor];
    [zreading setTitle:@"Z Reading" forState:UIControlStateNormal];
    [zreading setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [zreading addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [zreading addSubview:xView];
    
    zreadingcon = [[UIButton alloc] init];
    zView = [[UIImageView alloc] init];
    zView.image = [UIImage imageNamed:@"Order_Reports.png"];
    orderBottomBorder = [CALayer layer];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        zreadingcon.frame = CGRectMake(0.0,  zreading.frame.origin.y + zreading.frame.size.height, line.frame.size.width, 90.0);
        zView.frame = CGRectMake(20.0, 10.0, 70, 70);
        zView.image = [UIImage imageNamed:@"Order_Reports@2x.png"];
        zreadingcon.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
        zreadingcon.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
        zreadingcon.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        zreadingcon.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
        zreadingcon.layer.borderWidth = 0.5f;
        zreadingcon.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
        zreadingcon.titleLabel.alpha = 0.7f;
        orderBottomBorder.frame = CGRectMake(0.0f, 100.0f, zreadingcon.frame.size.width, 1.0f);
        orderBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        orderBottomBorder.opacity = 0.3f;
    }
    else{
        oldReports.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
        oldReports.frame = CGRectMake(0.0, 110.0, 200.0, 50.0);
        oldReportView.frame = CGRectMake(5.0, 5.0, 45.0, 45.0);
        oldReportView.image = [UIImage imageNamed:@"Order_Reports.png"];
        oldReports.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        oldReports.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        orderBottomBorder.frame = CGRectMake(0.0f, 55.0f, oldReports.frame.size.width, 1.0f);
        orderBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        orderBottomBorder.opacity = 0.5f;
        oldReports.titleLabel.alpha = 0.7f;
        
    }
    [zreadingcon.layer addSublayer:orderBottomBorder];
    zreadingcon.hidden = YES;
    zreadingcon.backgroundColor = [UIColor clearColor];
    [zreadingcon setTitle:@"Z Reading Consolidate" forState:UIControlStateNormal];
    [zreadingcon setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [zreadingcon addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [zreadingcon addSubview:zView];
    
    loyaltyGiftVoucherScroll = [[UIScrollView alloc] init];
    loyaltyGiftVoucherScroll.hidden = YES;
    loyaltyGiftVoucherScroll.backgroundColor = [UIColor clearColor];
    loyaltyGiftVoucherScroll.bounces = FALSE;
    
    issueCard = [[UIButton alloc] init];
    issueCardView = [[UIImageView alloc] init];
    issueCardView.image = [UIImage imageNamed:@"Loyalty_New.png"];
    CALayer *issueBottomBorder = [CALayer layer];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        issueCard.frame = CGRectMake(0.0, 0.0, line.frame.size.width, 90.0);
        issueCardView.frame = CGRectMake(20.0, 10.0, 70, 70);
        issueCardView.image = [UIImage imageNamed:@"Loyalty_New1.png"];
        issueCard.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
        issueCard.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        issueCard.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
        issueCard.layer.borderWidth = 0.5f;
        issueCard.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
        issueCard.titleLabel.alpha = 0.7f;
    }
    else{
        issueCard.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        issueCard.frame = CGRectMake(0.0, 50.0, 200.0, 50.0);
        issueCardView.frame = CGRectMake(5.0, 5, 45, 45);
        issueCardView.image = [UIImage imageNamed:@"Loyalty_New1.png"];
        issueCard.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        issueCard.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        issueCard.layer.borderWidth = 0.5f;
        issueCard.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
        issueCard.titleLabel.alpha = 0.7f;
        if (version >= 8.0) {
            issueBottomBorder.frame = CGRectMake(0.0f, 55.0f, issueCard.frame.size.width, 1.0f);
            issueBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            issueBottomBorder.opacity = 0.3f;
            [issueCard.layer addSublayer:issueBottomBorder];
        }
        issueCard.titleLabel.alpha = 0.7f;
        
    }
    issueCard.backgroundColor = [UIColor clearColor];
    [issueCard setTitle:@"New Loyalty Card" forState:UIControlStateNormal];
    
    [issueCard setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [issueCard addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [issueCard addSubview:issueCardView];
    
    viewCard = [[UIButton alloc] init];
    showCardView = [[UIImageView alloc] init];
    showCardView.image = [UIImage imageNamed:@"showlaoyalty.png"];
    CALayer *viewBottomBorder = [CALayer layer];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        viewCard.frame = CGRectMake(0.0, 95.0, line.frame.size.width, 90.0);
        showCardView.frame = CGRectMake(20.0, 10.0, 70, 70);
        showCardView.image = [UIImage imageNamed:@"Loyalty_View.png"];
        viewCard.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
        viewCard.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        viewCard.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
        viewCard.layer.borderWidth = 0.5f;
        viewCard.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
        viewCard.titleLabel.alpha = 0.7f;
    }
    else{
        viewCard.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        viewCard.frame = CGRectMake(0.0, 110.0, 200.0, 50.0);
        showCardView.frame = CGRectMake(5.0, 5, 45, 45);
        showCardView.image = [UIImage imageNamed:@"showlaoyalty.png"];
        viewCard.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        viewCard.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        viewCard.layer.borderWidth = 0.5f;
        viewCard.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
        viewCard.titleLabel.alpha = 0.7f;
        viewBottomBorder.frame = CGRectMake(0.0f, 55.0f, viewCard.frame.size.width, 1.0f);
        viewBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        viewBottomBorder.opacity = 0.3f;
        viewCard.titleLabel.alpha = 0.7f;
        
    }
    [viewCard.layer addSublayer:viewBottomBorder];
    viewCard.backgroundColor = [UIColor clearColor];
    [viewCard setTitle:@"View Loyalty Card" forState:UIControlStateNormal];
    
    [viewCard setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [viewCard addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [viewCard addSubview:showCardView];
    
    loyaltyEdit = [[UIButton alloc] init];
    editView = [[UIImageView alloc] init];
    editView.image = [UIImage imageNamed:@"showlaoyalty.png"];
    editBottomBorder = [CALayer layer];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        loyaltyEdit.frame = CGRectMake(0.0, 190.0, line.frame.size.width, 90);
        editView.frame = CGRectMake(20.0, 10.0, 70, 70);
        editView.image = [UIImage imageNamed:@"Loyalty_Edit.png"];
        loyaltyEdit.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
        loyaltyEdit.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        loyaltyEdit.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
        loyaltyEdit.layer.borderWidth = 0.5f;
        loyaltyEdit.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
        loyaltyEdit.titleLabel.alpha = 0.7f;
        editBottomBorder.frame = CGRectMake(0.0f, 100.0f, loyaltyEdit.frame.size.width, 1.0f);
        editBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        editBottomBorder.opacity = 0.3f;
    }
    else{
        loyaltyEdit.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        loyaltyEdit.frame = CGRectMake(0.0, 170.0, 200.0, 50.0);
        editView.frame = CGRectMake(5.0, 5, 45, 45);
        editView.image = [UIImage imageNamed:@"EditLoyalty.png"];
        loyaltyEdit.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        loyaltyEdit.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        editBottomBorder.frame = CGRectMake(0.0f, 55.0f, loyaltyEdit.frame.size.width, 1.0f);
        editBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        editBottomBorder.opacity = 0.5f;
        loyaltyEdit.titleLabel.alpha = 0.7f;
        
    }
    [loyaltyEdit.layer addSublayer:editBottomBorder];
    loyaltyEdit.backgroundColor = [UIColor clearColor];
    [loyaltyEdit setTitle:@"Edit Loyalty Card" forState:UIControlStateNormal];
    
    [loyaltyEdit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loyaltyEdit addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [loyaltyEdit addSubview:editView];
    
    issueGiftVoucher = [[UIButton alloc] init];
    issueGVView = [[UIImageView alloc] init];
    issueGVView.image = [UIImage imageNamed:@"Loyalty_New.png"];
    CALayer *issueGVBottomBorder = [CALayer layer];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        issueGiftVoucher.frame = CGRectMake(0.0, 285.0, line.frame.size.width, 90.0);
        issueGVView.frame = CGRectMake(20.0, 10.0, 70, 70);
        issueGVView.image = [UIImage imageNamed:@"Loyalty_New1.png"];
        issueGiftVoucher.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
        issueGiftVoucher.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        issueGiftVoucher.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
        issueGiftVoucher.layer.borderWidth = 0.5f;
        issueGiftVoucher.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
        issueGiftVoucher.titleLabel.alpha = 0.7f;
    }
    else{
        issueGiftVoucher.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        issueGiftVoucher.frame = CGRectMake(0.0, 50.0, 200.0, 50.0);
        issueGVView.frame = CGRectMake(5.0, 5, 45, 45);
        issueGVView.image = [UIImage imageNamed:@"Loyalty_New1.png"];
        issueGiftVoucher.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        issueGiftVoucher.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        issueGiftVoucher.layer.borderWidth = 0.5f;
        issueGiftVoucher.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
        issueGiftVoucher.titleLabel.alpha = 0.7f;
        if (version >= 8.0) {
            issueGVBottomBorder.frame = CGRectMake(0.0f, 55.0f, issueGiftVoucher.frame.size.width, 1.0f);
            issueGVBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            issueGVBottomBorder.opacity = 0.3f;
            [issueGiftVoucher.layer addSublayer:issueBottomBorder];
        }
        issueGiftVoucher.titleLabel.alpha = 0.7f;
        
    }
    issueGiftVoucher.backgroundColor = [UIColor clearColor];
    [issueGiftVoucher setTitle:@"Issue Gift Voucher" forState:UIControlStateNormal];
    
    [issueGiftVoucher setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [issueGiftVoucher addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [issueGiftVoucher addSubview:issueGVView];
    
    viewGiftVoucher = [[UIButton alloc] init];
    viewGVView = [[UIImageView alloc] init];
    viewGVView.image = [UIImage imageNamed:@"showlaoyalty.png"];
    CALayer *viewGVBottomBorder = [CALayer layer];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        viewGiftVoucher.frame = CGRectMake(0.0, 380.0, line.frame.size.width, 90.0);
        viewGVView.frame = CGRectMake(20.0, 10.0, 70, 70);
        viewGVView.image = [UIImage imageNamed:@"Loyalty_View.png"];
        viewGiftVoucher.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
        viewGiftVoucher.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        viewGiftVoucher.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
        viewGiftVoucher.layer.borderWidth = 0.5f;
        viewGiftVoucher.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
        viewGiftVoucher.titleLabel.alpha = 0.7f;
    }
    else{
        viewGiftVoucher.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        viewGiftVoucher.frame = CGRectMake(0.0, 110.0, 200.0, 50.0);
        viewGVView.frame = CGRectMake(5.0, 5, 45, 45);
        viewGVView.image = [UIImage imageNamed:@"showlaoyalty.png"];
        viewGiftVoucher.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        viewGiftVoucher.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        viewGiftVoucher.layer.borderWidth = 0.5f;
        viewGiftVoucher.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
        viewGiftVoucher.titleLabel.alpha = 0.7f;
        viewGVBottomBorder.frame = CGRectMake(0.0f, 55.0f, viewGiftVoucher.frame.size.width, 1.0f);
        viewGVBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        viewGVBottomBorder.opacity = 0.3f;
        viewGiftVoucher.titleLabel.alpha = 0.7f;
        
    }
    [viewGiftVoucher.layer addSublayer:viewGVBottomBorder];
    viewGiftVoucher.backgroundColor = [UIColor clearColor];
    [viewGiftVoucher setTitle:@"View Gift Voucher" forState:UIControlStateNormal];
    
    [viewGiftVoucher setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [viewGiftVoucher addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [viewGiftVoucher addSubview:viewGVView];
    
    editGiftVoucher = [[UIButton alloc] init];
    editGVView = [[UIImageView alloc] init];
    editGVView.image = [UIImage imageNamed:@"showlaoyalty.png"];
    CALayer *editGVBottomBorder = [CALayer layer];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        editGiftVoucher.frame = CGRectMake(0.0, 475.0, line.frame.size.width, 90);
        editGVView.frame = CGRectMake(20.0, 10.0, 70, 70);
        editGVView.image = [UIImage imageNamed:@"Loyalty_Edit.png"];
        editGiftVoucher.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
        editGiftVoucher.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        editGiftVoucher.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
        editGiftVoucher.layer.borderWidth = 0.5f;
        editGiftVoucher.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
        editGiftVoucher.titleLabel.alpha = 0.7f;
        editGVBottomBorder.frame = CGRectMake(0.0f, 100.0f, editGiftVoucher.frame.size.width, 1.0f);
        editGVBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        editGVBottomBorder.opacity = 0.3f;
    }
    else{
        editGiftVoucher.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        editGiftVoucher.frame = CGRectMake(0.0, 170.0, 200.0, 50.0);
        editGVView.frame = CGRectMake(5.0, 5, 45, 45);
        editGVView.image = [UIImage imageNamed:@"EditLoyalty.png"];
        editGiftVoucher.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        editGiftVoucher.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        editGVBottomBorder.frame = CGRectMake(0.0f, 55.0f, editGiftVoucher.frame.size.width, 1.0f);
        editGVBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        editGVBottomBorder.opacity = 0.5f;
        editGiftVoucher.titleLabel.alpha = 0.7f;
        
    }
    [editGiftVoucher.layer addSublayer:editGVBottomBorder];
    editGiftVoucher.backgroundColor = [UIColor clearColor];
    [editGiftVoucher setTitle:@"Edit Gift Voucher" forState:UIControlStateNormal];
    
    [editGiftVoucher setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [editGiftVoucher addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [editGiftVoucher addSubview:editGVView];
    
    
    issueGiftCoupon = [[UIButton alloc] init];
    issueGCView = [[UIImageView alloc] init];
    issueGCView.image = [UIImage imageNamed:@"Loyalty_New.png"];
    CALayer *issueGCBottomBorder = [CALayer layer];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        issueGiftCoupon.frame = CGRectMake(0.0, 475, line.frame.size.width, 90.0);
        issueGCView.frame = CGRectMake(20.0, 10.0, 70, 70);
        issueGCView.image = [UIImage imageNamed:@"Loyalty_New1.png"];
        issueGiftCoupon.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
        issueGiftCoupon.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        issueGiftCoupon.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
        issueGiftCoupon.layer.borderWidth = 0.5f;
        issueGiftCoupon.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
        issueGiftCoupon.titleLabel.alpha = 0.7f;
    }
    else{
        issueGiftCoupon.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        issueGiftVoucher.frame = CGRectMake(0.0, 50.0, 200.0, 50.0);
        issueGCView.frame = CGRectMake(5.0, 5, 45, 45);
        issueGCView.image = [UIImage imageNamed:@"Loyalty_New1.png"];
        issueGiftCoupon.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        issueGiftCoupon.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        issueGiftCoupon.layer.borderWidth = 0.5f;
        issueGiftCoupon.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
        issueGiftCoupon.titleLabel.alpha = 0.7f;
        if (version >= 8.0) {
            issueGCBottomBorder.frame = CGRectMake(0.0f, 55.0f, issueGiftVoucher.frame.size.width, 1.0f);
            issueGCBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
            issueGCBottomBorder.opacity = 0.3f;
            [issueGiftCoupon.layer addSublayer:issueBottomBorder];
        }
        issueGiftCoupon.titleLabel.alpha = 0.7f;
        
    }
    issueGiftCoupon.backgroundColor = [UIColor clearColor];
    [issueGiftCoupon setTitle:@"Issue Gift Coupon" forState:UIControlStateNormal];
    
    [issueGiftCoupon setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [issueGiftCoupon addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [issueGiftCoupon addSubview:issueGCView];
    
    viewGiftCoupon = [[UIButton alloc] init];
    viewGCView = [[UIImageView alloc] init];
    viewGCView.image = [UIImage imageNamed:@"showlaoyalty.png"];
    CALayer *viewGCBottomBorder = [CALayer layer];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        viewGiftCoupon.frame = CGRectMake(0.0, 570, line.frame.size.width, 90.0);
        viewGCView.frame = CGRectMake(20.0, 10.0, 70, 70);
        viewGCView.image = [UIImage imageNamed:@"Loyalty_View.png"];
        viewGiftCoupon.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
        viewGiftCoupon.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        viewGiftCoupon.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
        viewGiftCoupon.layer.borderWidth = 0.5f;
        viewGiftCoupon.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
        viewGiftCoupon.titleLabel.alpha = 0.7f;
    }
    else{
        viewGiftCoupon.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        viewGiftCoupon.frame = CGRectMake(0.0, 110.0, 200.0, 50.0);
        viewGCView.frame = CGRectMake(5.0, 5, 45, 45);
        viewGCView.image = [UIImage imageNamed:@"showlaoyalty.png"];
        viewGiftCoupon.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        viewGiftCoupon.titleEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        viewGiftCoupon.layer.borderWidth = 0.5f;
        viewGiftCoupon.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
        viewGiftCoupon.titleLabel.alpha = 0.7f;
        viewGCBottomBorder.frame = CGRectMake(0.0f, 55.0f, viewGiftVoucher.frame.size.width, 1.0f);
        viewGCBottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        viewGCBottomBorder.opacity = 0.3f;
        viewGiftCoupon.titleLabel.alpha = 0.7f;
        
    }
    [viewGiftCoupon.layer addSublayer:viewGVBottomBorder];
    viewGiftCoupon.backgroundColor = [UIColor clearColor];
    [viewGiftCoupon setTitle:@"View Gift Coupon" forState:UIControlStateNormal];
    
    [viewGiftCoupon setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [viewGiftCoupon addTarget:self action:@selector(prduct1_method:) forControlEvents:UIControlEventTouchUpInside];
    [viewGiftCoupon addSubview:viewGCView];
    
    
    [listView addSubview:newBillButton];
    [listView addSubview:oldBillButton];
    [listView addSubview:deliveryIcon];
    [listView addSubview:pendingIcon];
    [listView addSubview:cancelledButton];
    [scrollView addSubview:goodsTransfer];
    [scrollView addSubview:stockReceipt];
    [scrollView addSubview:stockIssue];
    // [scrollView addSubview:stockRequest];
    [scrollView addSubview:stockReturn];
    [scrollView addSubview:stocks];
    [scrollView addSubview:criticalStock];
    [scrollView addSubview:normalStock];
    [scrollView addSubview:goodsProcurement];
    [scrollView addSubview:purchases];
    [scrollView addSubview:shipments];
    [scrollView addSubview:receipts];
    [scrollView addSubview:delivers];
    [scrollView addSubview:orders];
    [scrollView addSubview:shipments_];
    [scrollView addSubview:stock];
    [scrollView addSubview:stockVerify];
    
    
    [listView addSubview:scrollView];
    
    [listView addSubview:dealsButton];
    
    
    [listView addSubview:offersButton];
    [listView addSubview:newOrders];
    [listView addSubview:dOrder];
    [listView addSubview:complaints];
    
    [listView addSubview:oldOrders];
    
    [listView addSubview:newReports];
    
    
    [listView addSubview:oldReports];
    [listView addSubview:XZreport];
    [listView addSubview:zreading];
    [listView addSubview:zreadingcon];
    
    [loyaltyGiftVoucherScroll addSubview:issueCard];
    
    [loyaltyGiftVoucherScroll addSubview:viewCard];
    [loyaltyGiftVoucherScroll addSubview:loyaltyEdit];
    [loyaltyGiftVoucherScroll addSubview:issueGiftVoucher];
    
    [loyaltyGiftVoucherScroll addSubview:viewGiftVoucher];
    [loyaltyGiftVoucherScroll addSubview:issueGiftCoupon];
    
    [loyaltyGiftVoucherScroll addSubview:viewGiftCoupon];
    
    [listView addSubview:loyaltyGiftVoucherScroll];
    
    //[billingView addSubview:listView];
    
    
    //added for the grid view....
    
    gridView = [[UIView alloc] init];
    gridView.hidden = YES;
    
    
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 9, 10);
    layout.itemSize = CGSizeMake(20, 20);
    layout.minimumInteritemSpacing = 15;
    layout.minimumLineSpacing = 20.0;
    //    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    gridCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,65,670,60) collectionViewLayout:layout];
    gridCollectionView.dataSource = self;
    gridCollectionView.delegate = self;
    [gridCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"GridCollectionCellView"];
    gridCollectionView.backgroundColor = [UIColor clearColor];
    
    [gridCollectionView setHidden:NO];
    gridCollectionView.userInteractionEnabled = YES;
    
    
    [gridView addSubview:gridCollectionView];
    [billingView addSubview:gridView];
    
    [self reloadCollectionView:0];
    
    
    if (![finalLicencesDetails containsObject:@"Billing and MPOS"] && [finalLicencesDetails containsObject:@"Outlet Management"]){
        line.text = @"Store Management";
        newBillButton.hidden = YES;
        oldBillButton.hidden = YES;
        deliveryIcon.hidden = YES;
        pendingIcon.hidden = YES;
        scrollView.hidden = NO;
        dealsButton.hidden = YES;
        offersButton.hidden = YES;
        newOrders.hidden = YES;
        oldOrders.hidden = YES;
        dOrder.hidden = YES;
        complaints.hidden = YES;
        newReports.hidden = YES;
        oldReports.hidden = YES;
        loyaltyGiftVoucherScroll.hidden = YES;
    }
    else if (![finalLicencesDetails containsObject:@"Billing and MPOS"] && ![finalLicencesDetails containsObject:@"Outlet Management"]){
        line.text = @"Deals & Offers";
        newBillButton.hidden = YES;
        oldBillButton.hidden = YES;
        deliveryIcon.hidden = YES;
        pendingIcon.hidden = YES;
        scrollView.hidden = YES;
        dealsButton.hidden = NO;
        offersButton.hidden = NO;
        newOrders.hidden = YES;
        oldOrders.hidden = YES;
        dOrder.hidden = YES;
        complaints.hidden = YES;
        newReports.hidden = YES;
        oldReports.hidden = YES;
        loyaltyGiftVoucherScroll.hidden = YES;
    }
    
    
    headerView = [[UIView alloc] init];
    
    UILabel *docNameLbl = [[UILabel alloc] init] ;
    // docNameLbl.layer.cornerRadius = 14;
    docNameLbl.textAlignment = NSTextAlignmentCenter;
    docNameLbl.layer.masksToBounds = YES;
    docNameLbl.font = [UIFont boldSystemFontOfSize:14.0];
    docNameLbl.backgroundColor = [UIColor colorWithRed:48.0/255.0 green:48.0/255.0 blue:48.0/255.0 alpha:1.0];
    //    docNameLbl.textColor = [UIColor colorWithRed:159.0/255.0 green:142.0/255.0 blue:107.0/255.0 alpha:1.0];
    docNameLbl.textColor = [UIColor lightGrayColor];
    
    docNameLbl.text = @"Business Document";
    
    
    UILabel *noOfDocsLbl = [[UILabel alloc] init] ;
    // noOfDocsLbl.layer.cornerRadius = 12;
    noOfDocsLbl.textAlignment = NSTextAlignmentCenter;
    noOfDocsLbl.layer.masksToBounds = YES;
    noOfDocsLbl.font = [UIFont boldSystemFontOfSize:14.0];
    noOfDocsLbl.backgroundColor = [UIColor colorWithRed:48.0/255.0 green:48.0/255.0 blue:48.0/255.0 alpha:1.0];
    noOfDocsLbl.textColor = [UIColor lightGrayColor];
    noOfDocsLbl.text = @"No Of Docs";
    
    UILabel *pendingDocsLbl = [[UILabel alloc] init];
    // pendingDocsLbl.layer.cornerRadius = 14;
    pendingDocsLbl.textAlignment = NSTextAlignmentCenter;
    pendingDocsLbl.layer.masksToBounds = YES;
    pendingDocsLbl.font = [UIFont boldSystemFontOfSize:14.0];
    pendingDocsLbl.backgroundColor = [UIColor colorWithRed:48.0/255.0 green:48.0/255.0 blue:48.0/255.0 alpha:1.0];
    pendingDocsLbl.textColor = [UIColor lightGrayColor];
    pendingDocsLbl.text = @"Pending Docs";
    
    UILabel *updateDateLbl = [[UILabel alloc] init] ;
    // updateDateLbl.layer.cornerRadius = 14;
    updateDateLbl.textAlignment = NSTextAlignmentCenter;
    updateDateLbl.layer.masksToBounds = YES;
    updateDateLbl.font = [UIFont boldSystemFontOfSize:14.0];
    updateDateLbl.backgroundColor = [UIColor colorWithRed:48.0/255.0 green:48.0/255.0 blue:48.0/255.0 alpha:1.0];
    updateDateLbl.textColor = [UIColor lightGrayColor];
    updateDateLbl.text = @"Last Submitted";
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
            
            docNameLbl.font = [UIFont boldSystemFontOfSize:18];
            docNameLbl.frame = CGRectMake(10, 0, 270, 40);
            noOfDocsLbl .font = [UIFont boldSystemFontOfSize:18];
            noOfDocsLbl.frame = CGRectMake(docNameLbl.frame.origin.x + docNameLbl.frame.size.width + 10, 0, 150, 40);
            pendingDocsLbl.font = [UIFont boldSystemFontOfSize:18];
            pendingDocsLbl.frame = CGRectMake(noOfDocsLbl.frame.origin.x + noOfDocsLbl.frame.size.width + 10, 0, 150, 40);
            updateDateLbl.font = [UIFont boldSystemFontOfSize:18];
            updateDateLbl.frame = CGRectMake(pendingDocsLbl.frame.origin.x + pendingDocsLbl.frame.size.width + 10, 0, 180, 40);
            
        }
        else {
            
        }
        
        
        
    }
    else {
        
        
        
    }
    
    [headerView addSubview:docNameLbl];
    [headerView addSubview:noOfDocsLbl];
    [headerView addSubview:pendingDocsLbl];
    [headerView addSubview:updateDateLbl];
    [billingView addSubview:headerView];
    
    //listTableView.tableHeaderView = headerView;
    
    //modified at viewDidLoad for back button by prabhu
    backBtn = [[UIButton alloc] init] ;
    [backBtn addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.tag = 0;
    
    UIImage *image=[UIImage imageNamed:@"go-back-icon.png"];
    [backBtn setBackgroundImage:image    forState:UIControlStateNormal];
    backBtn.hidden = YES;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        //changed by Srinivasulu on 26/03/2018....
        //        if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight || [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft ) {
        if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
            
            //upto here on 26/03/2018....
            
            billingView.frame = CGRectMake(195.0, 80.0, line.frame.size.width, 600);
            
            listView.frame = CGRectMake( 0, line.frame.size.height + 10, billingView.frame.size.width, billingView.frame.size.height - (line.frame.size.height + 10));
            
            headerView.frame = CGRectMake(0, line.frame.size.height  + 10, billingView.frame.size.width,50);
            
            listTableView.frame = CGRectMake(0, line.frame.size.height + headerView.frame.size.height + 10, billingView.frame.size.width, billingView.frame.size.height - (line.frame.size.height + 60));
            
            backImage.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            homeTable.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
            homeTable.frame = CGRectMake(0, 60, 190, 620);
            //topbar.frame = CGRectMake(0, 0, 768, 50);
            
            //        label.font = [UIFont boldSystemFontOfSize:25];
            //        backbutton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            //
            //        label.frame = CGRectMake(10, 0, 240, 50);
            //        backbutton.frame = CGRectMake(640, 5, 100, 40);
            //            segmentedControl.frame = CGRectMake(-6,700,self.view.frame.size.width+20,60);
            segmentedControl.frame = CGRectMake( -6, self.view.frame.size.height - 60, self.view.frame.size.width + 20, 60);
            
            scrollView.frame = CGRectMake(0, 0, 600, 520);
            //            scrollView.backgroundColor = [UIColor purpleColor];
            scrollView.contentSize = CGSizeMake(605.0, 1400.0);
            wareHouseScrollView.frame = CGRectMake(0, 65, 600.0, 790.0);
            wareHouseScrollView.contentSize = CGSizeMake(605.0, 2000.0);
            loyaltyGiftVoucherScroll.frame = CGRectMake(0, 0, 800.0, 530.0);
            loyaltyGiftVoucherScroll.contentSize = CGSizeMake(605.0, 700.0);
            
            messageIcon.frame =  CGRectMake(line.frame.origin.x + line.frame.size.width - 170, line.frame.origin.y + 10, (line.frame.size.height/2) + 10 , (line.frame.size.height/2) + 10);
            
            
            showgridViewBtn.frame =  CGRectMake(line.frame.origin.x + line.frame.size.width - 80, line.frame.origin.y + 10, (line.frame.size.height/2) + 10 , (line.frame.size.height/2) + 10);
            
            showListViewBtn.frame =  CGRectMake( showgridViewBtn.frame.origin.x +  showgridViewBtn.frame.size.width + 10, showgridViewBtn.frame.origin.y,  showgridViewBtn.frame.size.width, showgridViewBtn.frame.size.height);
            
            gridView.frame  = CGRectMake(0, line.frame.size.height + 2, billingView.frame.size.width, billingView.frame.size.height - (line.frame.size.height + 2));
            
            gridCollectionView.frame = CGRectMake( 30, 10, gridView.frame.size.width - 60, gridView.frame.size.height - 10);
            
            backBtn.frame =  CGRectMake(line.frame.origin.x + line.frame.size.width - 120, line.frame.origin.y + 10, (line.frame.size.height/2) + 10 , (line.frame.size.height/2) + 10);
            
            
            //In this complete code has to changed.  Written by Srinivasulu on 07/08/2017....
            //changed by Srinivasulu on 07/08/2016....
            //contentSize frame dynamically....
            
            showgridViewBtn.frame =  CGRectMake(  line.frame.origin.x + line.frame.size.width - 70, line.frame.origin.y + 14, line.frame.size.height/2  , line.frame.size.height/2);
            
            showListViewBtn.frame =  CGRectMake(  showgridViewBtn.frame.origin.x +  showgridViewBtn.frame.size.width + 10, showgridViewBtn.frame.origin.y,  showgridViewBtn.frame.size.width, showgridViewBtn.frame.size.height);
            
            
            
            headerView.frame = CGRectMake(0, line.frame.size.height  + 10, listView.frame.size.width, 50);
            
            listView.frame = CGRectMake(0, line.frame.size.height + 70, billingView.frame.size.width, billingView.frame.size.height - (line.frame.size.height + 10));
            
            
            
            
            docNameLbl.font = [UIFont boldSystemFontOfSize:18];
            docNameLbl.frame = CGRectMake(10, 0, 270, 40);
            noOfDocsLbl .font = [UIFont boldSystemFontOfSize:18];
            noOfDocsLbl.frame = CGRectMake(docNameLbl.frame.origin.x + docNameLbl.frame.size.width + 10, 0, 150, 40);
            pendingDocsLbl.font = [UIFont boldSystemFontOfSize:18];
            pendingDocsLbl.frame = CGRectMake(noOfDocsLbl.frame.origin.x + noOfDocsLbl.frame.size.width + 10, 0, 150, 40);
            updateDateLbl.font = [UIFont boldSystemFontOfSize:18];
            updateDateLbl.frame = CGRectMake(pendingDocsLbl.frame.origin.x + pendingDocsLbl.frame.size.width + 10, 0, headerView.frame.size.width - ( pendingDocsLbl.frame.origin.x + pendingDocsLbl.frame.size.width + 20 ), 40);
            
            listTableView.frame = CGRectMake( 0, line.frame.size.height + 70, headerView.frame.size.width, listView.frame.size.height - (headerView.frame.size.height + 10));
            
            
            
            gridView.frame  = CGRectMake(0, line.frame.size.height + 2, billingView.frame.size.width, billingView.frame.size.height - (line.frame.size.height + 2));
            
            gridCollectionView.frame = CGRectMake( 30, 2, gridView.frame.size.width - 60, gridView.frame.size.height - 2);
            
            
            
            //upto here on 07/08/2016.....
            
        }
        else {
            billingView.frame = CGRectMake(195.0, 80.0, 560.0, 870.0);
            
            backImage.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            homeTable.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
            homeTable.frame = CGRectMake(0, 60, 190, 900);
            //topbar.frame = CGRectMake(0, 0, 768, 50);
            
            //        label.font = [UIFont boldSystemFontOfSize:25];
            //        backbutton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            //
            //        label.frame = CGRectMake(10, 0, 240, 50);
            //        backbutton.frame = CGRectMake(640, 5, 100, 40);
            segmentedControl.frame = CGRectMake(-6,963,780,60);
            scrollView.frame = CGRectMake(0, 65, 600.0, 790.0);
            scrollView.contentSize = CGSizeMake(605.0, 1180.0);
            wareHouseScrollView.frame = CGRectMake(0, 65, 600.0, 790.0);
            wareHouseScrollView.contentSize = CGSizeMake(605.0, 2000.0);
            loyaltyGiftVoucherScroll.frame = CGRectMake(0, 65, 600.0, 500.0);
            loyaltyGiftVoucherScroll.contentSize = CGSizeMake(605.0, 1000.0);
        }
        
    }
    else {
        
        backImage.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        homeTable.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
        if (version >= 8.0) {
            billingView.frame = CGRectMake(115.0, 80.0, 200.0, 430.0);
            segmentedControl.frame = CGRectMake(-2,(self.view.frame.size.height-48),324,47);
            homeTable.frame = CGRectMake(0, 60, 110, (self.view.frame.size.height-100));
            scrollView.frame = CGRectMake(0, 50, 200, 380.0);
            scrollView.contentSize = CGSizeMake(505.0, 700.0);
            wareHouseScrollView.frame = CGRectMake(0, 50.0, 250.0, 350.0);
            wareHouseScrollView.contentSize = CGSizeMake(250, 1200);
        }
        else{
            billingView.frame = CGRectMake(115.0, 15.0, 200.0, 350.0);
            segmentedControl.frame = CGRectMake(-2,370,324,47);
            homeTable.frame = CGRectMake(0, 0, 110, 370);
            scrollView.frame = CGRectMake(0, 50.0, 250.0, 290.0);
            scrollView.contentSize = CGSizeMake(250, 700.0);
            wareHouseScrollView.frame = CGRectMake(0, 50.0, 250.0, 290.0);
            wareHouseScrollView.contentSize = CGSizeMake(250, 1200);
        }
        
    }
    //homeTable.backgroundColor = [UIColor redColor];
    
    //[self.view addSubview:topbar];
    
    //    [self.view addSubview:label];
    //    [self.view addSubview:backbutton];
    
    [billingView addSubview:messageIcon];
    
    [billingView addSubview:showgridViewBtn];
    [billingView addSubview:showListViewBtn];
    [billingView addSubview:listTableView];
    [billingView addSubview:backBtn];
    
    [self.view addSubview:backImage];
    [self.view addSubview:homeTable];
    [self.view addSubview:segmentedControl];
    [self.view addSubview:billingView];
    subModuleArry1 = [[NSMutableArray alloc] init];
    [subModuleArry1 addObject:@"New Billng"];
    [subModuleArry1 addObject:@"Critical Stock"];
    [subModuleArry1 addObject:@"Current Deals"];
    [subModuleArry1 addObject:@"New Order"];
    [subModuleArry1 addObject:@"Sale Reports"];
    [subModuleArry1 addObject:@"Issue Loyalty"];
    
    subModuleArry2 = [[NSMutableArray alloc] init];
    [subModuleArry2 addObject:@"Past Bills"];
    [subModuleArry2 addObject:@"Normal Stock"];
    [subModuleArry2 addObject:@"Past Deals"];
    [subModuleArry2 addObject:@"Previous Orders"];
    [subModuleArry2 addObject:@"Order Reports"];
    [subModuleArry2 addObject:@"Show Loyalty"];
    
    
    [self.view addSubview:loadingView];
    
    
    //[self messageBoard];
    
    messageStartIndex = 0;
    
    selectedFlowPosInt = 0;
    
    //added by Srinivasulu on 07/08/2017...
    
    [self showRespectiveView:showgridViewBtn];
    
    //upto here on 07/08/2017....
    
    //added by Srinivasulu on 15/11/2017.... 27/11/2017 && 24/03/2018.... 31/03/2018....28/06/2018....
    //it can be remove after 04/04/2018....05/05/2018  && 07/07/2018....10/07/2018....28/10/2018....
    
    //    [self alterTable:@"denomination_master" column:@"currency_code" type:@"text"];
    //
    //    [self alterTable:@"billing_transactions" column:@"tender_Mode" type:@"text"];
    //    [self alterTable:@"billing_transactions" column:@"tender_key" type:@"INT"];
    //
    //    //category, sub_category -- is_tax_on_discounted_price, tracking_required
    //
    //    [self alterTable:@"sku_master" column:@"category" type:@"CHAR(100)"];
    //    [self alterTable:@"sku_master" column:@"sub_category" type:@"CHAR(100)"];
    //    [self alterTable:@"sku_master" column:@"is_tax_on_discounted_price" type:@"TINYINT(4)"];
    //    [self alterTable:@"sku_master" column:@"tracking_required" type:@"TINYINT(4)"];
    //
    //    [self alterTable:@"billing_table" column:@"comments" type:@"text"];
    //
    //    [self alterTable:@"billing_transactions" column:@"transaction_type" type:@"text"];
    //
    //    [self alterTable:@"billing_table" column:@"sales_order_id" type:@"text"];
    //    [self alterTable:@"billing_table" column:@"shipping_charges" type:@"text"];
    
    //it is written by Srinivasulu on 28/02/2018.... commented on 12/03/2018.. but are resolved...10/07/2018....
    //reason is it has to be tested properly we are facing issues in productions....
    
    //    isToCallApplyCampaigns = false;
    
    //upto here on 28/02/2018....
    //    hideDelegate = self;
    
    
    //upto here on 15/11/2017.... 27/11/2017....
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    
//    dealStatus = true; // commented by roja on 19/04/2019
    
    
    //    // Un	select the selected row if anyxao
    //    NSIndexPath*    selection = [self.homeTable indexPathForSelectedRow];
    //    if (selection) {
    //        [self.homeTable deselectRowAtIndexPath:selection animated:YES];
    //    }
    [self.homeTable deselectRowAtIndexPath:(self.homeTable).indexPathForSelectedRow animated:YES];
    [homeTable reloadData];
    
    skuStartIndex = 0;
    skuEanIndex = 0;
    totalRecords = 0;
    
    skuPriceStartIndex = 0;
    totalPriceRecords = 0;
    
    //added by Srinivasulu on 27/04/2017....
    
    //    if (isOfflineService) {
    //
    //        [modeSwitch setOn:false];
    //
    //        [modeSwitch setTintColor:[UIColor redColor]];
    //        modeSwitch.layer.cornerRadius = 16;
    //        modeSwitch.backgroundColor = [UIColor redColor];
    //
    //    }
    //
    //    int count = [self getLocalBillCount];
    //
    //
    //
    //    refreshBtn.badgeValue = [NSString stringWithFormat:@"%d",count];
    //    refreshBtn.badgeBGColor = [UIColor colorWithRed:60.0/255.0 green:179.0/255.0 blue:113.0/255.0 alpha:1.0];
    //    refreshBtn.badgeTextColor = [UIColor whiteColor];
    //
    //
    //    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    //        refreshBtn.badgeOriginX = 28;
    //        refreshBtn.badgeOriginY = -10;
    //
    //    }
    
    
    //upto here on 27/04/2017....
    
    
    
    //added by Srinivasulu on 07/04/2018....
    
    @try {
        
        if(defaults == nil)
            defaults = [NSUserDefaults standardUserDefaults];
        
        NSString * savedDefaultCurrencyCode = INR;
        
        if ( ! ([[defaults valueForKey:DEFAULT_CURRENCY_CODE] isKindOfClass:[NSNull class]] || [defaults valueForKey:DEFAULT_CURRENCY_CODE] == nil))
            savedDefaultCurrencyCode = [defaults valueForKey:DEFAULT_CURRENCY_CODE];
        
        if ( ! ([[defaults valueForKey:DENOMNINATION_OPTIONS] isKindOfClass:[NSNull class]] || [defaults valueForKey:DENOMNINATION_OPTIONS] == nil)) {
            
            for(NSDictionary * payDic in [defaults valueForKey:DENOMNINATION_OPTIONS]){
                
                if([[payDic valueForKey:TENDER_NAME] caseInsensitiveCompare:savedDefaultCurrencyCode] == NSOrderedSame){
                    currencyCodeStr = savedDefaultCurrencyCode;
                    break;
                }
            }
        }
    } @catch (NSException *exception) {
        
    }
    
    //upto here on  07/04/2018....
    
    [UIView  transitionWithView:billingView duration:2.0  options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^(void) {
                         BOOL oldState = [UIView areAnimationsEnabled];
                         [UIView setAnimationsEnabled:NO];
                         [UIView setAnimationsEnabled:oldState];
                     }
                     completion:nil];
    //    CheckWifi *wifi = [[CheckWifi alloc]init];
    
    //commented by Srinivasulu on 29/04/2017.....
    
    //    BOOL status = [wifi checkWifi];
    //    if (status) {
    //
    //        isOfflineService = FALSE;
    //    }
    //    else {
    //        isOfflineService = TRUE;
    //    }
    //
    //    if (isOfflineService) {
    //
    //        self.titleLabel.text = @"Omni Retailer-Offline";
    //
    //
    //    }
    //    else {
    //        self.titleLabel.text = @"Omni Retailer-Online";
    //
    //    }
    //upto here on 29/04/2017....
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [homeTable selectRowAtIndexPath:indexPath animated:YES  scrollPosition:UITableViewScrollPositionBottom];
    CATransition * animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 2.0f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"rippleEffect" ;
    [billingView.layer addAnimation:animation forKey:NULL];
    
    skuStartIndex = 0;
    skuEanIndex = 0;
    totalRecords = 0;
    
    skuPriceStartIndex = 0;
    totalPriceRecords = 0;
    
    
    SystemSoundID    soundFileObject1;
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"water" withExtension: @"mp3"];
    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
    AudioServicesPlaySystemSound (soundFileObject1);
    
    
    //commented by Srinivasulu on 29/04/2017.....
    
    //    CheckWifi *wifi = [[CheckWifi alloc]init];
    //    BOOL status = [wifi checkWifi];
    //    if (status) {
    //
    //        isOfflineService = FALSE;
    //    }
    //    else {
    //        isOfflineService = TRUE;
    //    }
    
    //upto here on 29/04/2017....
    
    //added by Srinivasulu on 19/04/2017....
    
    //        dealStatus = true;
    //        offerStatus = true;
    //        taxStatus = true;
    //    skuStatus = true;
    //    employeeStatus = true;
    //    productStatus = true;
    //        denominationStatus = true;
    //
    //
    //    [defaults setObject:@"14/08/2016 05:34:37" forKey:LAST_SKU_UPDATED];
    //    [defaults setObject:@"14/08/2016 05:34:37" forKey:LAST_SKU_EAN_UPDATED];
    //    [defaults setObject:@"14/08/2016 01:34:37" forKey:LAST_PRICE_UPDATED];
    //    [defaults setObject:@"14/08/2016 01:34:37" forKey:UPDATED_DATE_STR];
    //
    //    [defaults setObject:@"14/08/2016 05:34:37" forKey:LAST_DEALS_UPDATED];
    //    [defaults setObject:@"14/08/2016 05:34:37" forKey:LAST_OFFERS_UPDATED];
    //    [defaults setObject:@"14/08/2016 05:34:37" forKey:LAST_GROUPS_UPDATED];
    //    [defaults setObject:@"14/08/2016 01:34:37" forKey:LAST_GROUP_CHILDS_UPDATED];
    //    [defaults setObject:@"14/08/2016 01:34:37" forKey:LAST_EMPL_UPDATED_DATE];
    //    [defaults setObject:@"14/08/2016 01:34:37" forKey:LAST_DENOMINATIONS_UPDATE_DATE];
    
    
    //reason to donw load data......
    
    if (!isOfflineService && syncStatus) {
        if (shiftId.length>0) {
            
            //added by Srinivasulu on 20/04/2017....
            
            //showing the HUD on 20/04/2017....
            //            HUD.labelText= @"Uploading ....";
            //            [HUD setHidden:NO];
            
            //commented by Srinivasulu on  01/05/2017....
            
            //            [self synchCustomerDetails];
            //            [self deleteUploadedBillsFromLocal];
            //            [self synchUpLocalBills];
            
            
            //upto here on 01/05/2017....
            
            
            //showing the HUD on 20/04/2017....
            //            [HUD setHidden:YES];
            
            
            
            //upto here on 20/04/2017.....
            //            [self performSelectorInBackground:@selector(synchCustomerDetails) withObject:nil];
        }
        if (syncStatus) {
            
            //            [self getLocalErrorBills];
        }
        
        //        if (skuStatus || taxStatus || dealStatus || offerStatus || employeeStatus || categoryStatus || subCategoruStatus ||productStatus || denominationStatus) {
        //
        
        // Here loyaltyCardStatus, giftCouponStatus && giftVoucherStatus added by roja on 06/05/2019...

        if (skuStatus || taxStatus || dealStatus || offerStatus || employeeStatus ||productStatus || denominationStatus || customerDownLoadStatus || memberDetailsDownLoad || loyaltyCardsStatus || giftCouponStatus || giftVoucherStatus) {

            [HUD setHidden:NO];
            //           // [HUD show:YES];
            //            [HUD setLabelText:@"Downloading data\n Please wait..."];
            //            //[self performSelectorInBackground:@selector(backGroundProcess) withObject:nil];
            //            [HUD showWhileExecuting:@selector(backGroundProcess) onTarget:self withObject:nil animated:true];
            
            
            
            if(isDayStartWithSync){
                
                downloadConfirmationAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"updates_are_available_please_download_them_and_move_further", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
                [downloadConfirmationAlert show];
            }
            else
            {
                
                downloadConfirmationAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"updates_are_available_do_you_wnat_to_download_them_", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"yes", nil) otherButtonTitles:NSLocalizedString(@"no", nil), nil];
                [downloadConfirmationAlert show];
            }
        }
        
        //added by Srinivasulu on 15/12/2017....
        else{
            
            //            if([[self isThereAnyBillsToDelete] count]){
            //
            //                offlineBillDeleteConfirmationAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"do_want_to_delete_offline_bills_?", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"yes", nil) otherButtonTitles:NSLocalizedString(@"no", nil), nil];
            //                [offlineBillDeleteConfirmationAlert show];
            //            }
        }
        //upto here on 15/12/2017....
        
    }
    //added by Srinivasulu on 15/12/2017....
    else{
        
        //        if([[self isThereAnyBillsToDelete] count]){
        //
        //            offlineBillDeleteConfirmationAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"do_want_to_delete_offline_bills_?", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"yes", nil) otherButtonTitles:NSLocalizedString(@"no", nil), nil];
        //            [offlineBillDeleteConfirmationAlert show];
        //        }
    }
    //upto here on 15/12/2017....
    
    
    //added by Srinivasulu on 18/10/2017....
    
    if(defaults == nil)
        defaults = [NSUserDefaults standardUserDefaults];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd/MM/yyyy";
    NSString * bussinessDateStr = [defaults valueForKey:BUSSINESS_DATE];
    
    NSDate * dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:bussinessDateStr];
    
    NSDate * today = [NSDate date];
    
    NSDate * todayDate = [[NSDate alloc] init];
    todayDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:today]];
    
    isZreportHasTaken = TRUE;
    
    if([dateFromString compare:todayDate] == NSOrderedAscending){
        
        isZreportHasTaken = FALSE;
    }
    
    //upto here on 18/10/2017....
    
    //added by Srinivasulu on 24/03/2018....
    
    @try {
        
        NSArray* tempVCA = (self.navigationController).viewControllers;
        
        //        NSLog(@"%@",self.navigationController.viewControllers);
        int homeRepeated = 0;
        int rootViewRepeated = 0;
        //        [tempVCA reverseObjectEnumerator]
        //        for(UIViewController *tempVC in tempVCA)
        
        for(UIViewController *tempVC in [tempVCA reverseObjectEnumerator])
        {
            
            if([tempVC isKindOfClass:[OmniHomePage class]])
            {
                if(homeRepeated > 0)
                    [tempVC removeFromParentViewController];
                else
                    homeRepeated = homeRepeated + 1;
            }
            else  if([tempVC isKindOfClass:[OmniRetailerViewController class]])
            {
                if(rootViewRepeated > 0)
                    [tempVC removeFromParentViewController];
                else
                    rootViewRepeated = rootViewRepeated + 1;
            }
            else
            {
                
                [tempVC removeFromParentViewController];
            }
            
        }
        
        //        NSLog(@"%@",self.navigationController.viewControllers);
        
        
    } @catch (NSException *exception) {
        
    }
    //upto here on 24/03/2018....
    
    
}



- (void)deviceOrientationDidChange:(NSNotification *)notification {
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    
    if ((UIDeviceOrientationIsPortrait(orientation) ||UIDeviceOrientationIsPortrait(orientation)) ||
        (UIDeviceOrientationIsLandscape(orientation) || UIDeviceOrientationIsLandscape(orientation))) {
        //still saving the current orientation
        currentOrientation = orientation;
    }
    
    //added by Srinivasulu on 26/03/2018....
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && !(currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight))
        currentOrientation = UIDeviceOrientationLandscapeRight;
    
    //upto here on 26/03/2018....
    
    [self setFrames];
    
}

- (void)messageBoard {
    
    AudioServicesPlaySystemSound(soundFileObject);
    
    PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
    
    
    messageBoardView = [[UIView alloc] init];
    messageBoardView.backgroundColor = [UIColor blackColor];
    messageBoardView.layer.cornerRadius = 10.0f;
    messageBoardView.frame = CGRectMake(440.0, 80.0, 400.0, 400.0);
    messageBoardView.layer.borderColor = [UIColor grayColor].CGColor;
    messageBoardView.layer.borderWidth = 3.0f;
    
    messageTable = [[UITableView alloc] init];
    messageTable.backgroundColor = [UIColor clearColor];
    messageTable.dataSource = self;
    messageTable.delegate = self;
    
    messageDetailsArr = [NSMutableArray new];
    
    UILabel * messageHeader = [[UILabel alloc] init];
    messageHeader.text = @"Message Board";
    messageHeader.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
    messageHeader.backgroundColor = [UIColor grayColor];
    messageHeader.layer.cornerRadius = 10.0f;
    messageHeader.layer.masksToBounds = YES;
    messageHeader.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gradient.png"]];
    messageHeader.textAlignment = NSTextAlignmentCenter;
    messageHeader.font = [UIFont boldSystemFontOfSize:20.0f];
    messageHeader.frame = CGRectMake(0.0, 0.0, messageBoardView.frame.size.width, 50.0);
    
    messageTable.frame = CGRectMake(0.0, 50.0, messageBoardView.frame.size.width, 270.0);
    
    totalRecordsView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 340, messageBoardView.frame.size.width, 60.0)];
    totalRecordsView.backgroundColor = [UIColor clearColor];
    
    msgTotalRcrdsLbl = [[UILabel alloc] init];
    msgTotalRcrdsLbl.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
    msgTotalRcrdsLbl.layer.cornerRadius = 10.0f;
    msgTotalRcrdsLbl.layer.masksToBounds = YES;
    msgTotalRcrdsLbl.backgroundColor = [UIColor clearColor];
    msgTotalRcrdsLbl.textAlignment = NSTextAlignmentCenter;
    msgTotalRcrdsLbl.font = [UIFont boldSystemFontOfSize:20.0f];
    msgTotalRcrdsLbl.frame = CGRectMake(0.0, 5.0, messageBoardView.frame.size.width, 50.0);
    
    noMessagesLbl = [[UILabel alloc] init];
    noMessagesLbl.textColor = [UIColor blackColor];
    noMessagesLbl.layer.cornerRadius = 10.0f;
    noMessagesLbl.layer.masksToBounds = YES;
    noMessagesLbl.backgroundColor = [UIColor clearColor];
    noMessagesLbl.textAlignment = NSTextAlignmentCenter;
    noMessagesLbl.font = [UIFont boldSystemFontOfSize:20.0f];
    noMessagesLbl.frame = CGRectMake(0.0, 200.0, messageBoardView.frame.size.width, 50.0);
    noMessagesLbl.hidden = NO;
    noMessagesLbl.text = @"NO MESSAGES TO DISPLAY";
    
    
    UIButton  * closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(messageHeader.frame.size.width - 40, 0, 40, 40)] ;
    [closeBtn addTarget:self action:@selector(closeMessagePopUp) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.tag = 11;
    
    UIImage * image = [UIImage imageNamed:@"delete.png"];
    [closeBtn setBackgroundImage:image    forState:UIControlStateNormal];
    [messageBoardView addSubview:closeBtn];
    
    
    [messageBoardView addSubview:messageHeader];
    [messageBoardView addSubview:messageTable];
    [messageBoardView addSubview:totalRecordsView];
    [messageBoardView addSubview:noMessagesLbl];
    
    
    customerInfoPopUp.view = messageBoardView;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        customerInfoPopUp.preferredContentSize =  CGSizeMake(messageBoardView.frame.size.width, messageBoardView.frame.size.height);
        
        UIPopoverController * popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        [popover presentPopoverFromRect:messageIcon.frame inView:billingView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        
        
        popOver= popover;
        
    }
    
    else {
        
        customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        // popover.contentViewController.view.alpha = 0.0;
        popover.contentViewController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        popOver = popover;
        
    }
    
    [messageTable setHidden:YES];
    
    
    if (!isOfflineService) {
        [HUD show:YES];
        [HUD setHidden:NO];
        
        //        if (messageBoardStatus) {
        
        [self getMessageDetails];
        
        //        }
    }
    else {
        [messageTable setHidden:YES];
        [HUD setHidden:YES];
        noMessagesLbl.hidden = NO;
    }
    
    
    //    UIGraphicsBeginImageContext(messageBoardView.frame.size);
    //    [[UIImage imageNamed:@"CustomerView.png"] drawInRect:messageBoardView.bounds];
    //    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    //    messageBoardView.backgroundColor = [UIColor colorWithPatternImage:image];
    
    
    //[billingView addSubview:messageBoardView];
}


/**
 * @description  getting message Details from server
 * @date         16/11/15
 * @method       getMessageDetails
 * @author       Chandhu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */
- (void)getMessageDetails {
    @try {
        
        [HUD setHidden:NO];
        
        NSMutableDictionary * orderDetails = [NSMutableDictionary dictionaryWithObjects:@[[RequestHeader getRequestHeader],[NSString stringWithFormat:@"%d",messageStartIndex], presentLocation,roleName,@"15"] forKeys:@[REQUEST_HEADER,START_INDEX,@"storeLocation",ROLE,MAX_RECORDS]];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:orderDetails options:0 error:&err];
        NSString * messageBoardJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        WebServiceController * serviceController = [WebServiceController new];
        serviceController.getMessageBoardDelegate = self;
        [serviceController getMessageBoardDetails:messageBoardJsonString];
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception.name);
        noMessagesLbl.hidden = NO;
    }
}

/**
 * @description  delegate method for getting message details after success
 * @date         16/11/15
 * @method       getMessageBoardSuccessResponse
 * @author       Chandhu
 * @param        successDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 */
- (void)getMessageBoardSuccessResponse:(NSDictionary *)successDictionary {
    
    
    if (![successDictionary isKindOfClass:[NSNull class]]) {
        @try {
            
            
            NSDictionary *responseHeader = [successDictionary valueForKey:RESPONSE_HEADER];
            NSString *responseCode = [responseHeader valueForKey:RESPONSE_CODE];
            NSString *responseMessage = [responseHeader valueForKey:RESPONSE_MESSAGE];
            int totalRecords = [[successDictionary valueForKey:TOTAL_MESSAGES] intValue];
            if (responseCode.integerValue == 0 && [responseMessage isEqualToString:SUCCESS]) {
                if (![[successDictionary valueForKey:MESSAGE_BOARDS] isKindOfClass:[NSNull class]]) {
                    messageDetailsArr = [NSMutableArray new];
                    NSArray *messageArray = [successDictionary valueForKey:MESSAGE_BOARDS];
                    [messageDetailsArr addObjectsFromArray:messageArray];
                    NSUserDefaults *appDefaults = [NSUserDefaults standardUserDefaults];
                    [appDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:messageDetailsArr] forKey:MESSAGE_DETAILS];
                }
                [self addPaginationButtons:totalRecords];
                messagesPerPageArr = [WebServiceUtility getMessagesFromPositon:0 fromArray:messageDetailsArr];
                [messageTable setHidden:NO];
                [messageTable reloadData];
            }
            else {
                [messageTable setHidden:YES];
                noMessagesLbl.hidden = NO;
            }
            
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception.name);
            [messageTable setHidden:YES];
            noMessagesLbl.hidden = NO;
        }
        @finally {
            [HUD setHidden:YES];
        }
    }
    else {
        [messageTable setHidden:YES];
        [HUD setHidden:YES];
        noMessagesLbl.hidden = NO;
    }
}

/**
 * @description  delegate method for getting message details after failure
 * @date         16/11/15
 * @method       getMessageBoardErrorResponse
 * @author       Chandhu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */
- (void)getMessageBoardErrorResponse {
    
    
    [messageTable setHidden:YES];
    [HUD setHidden:YES];
    noMessagesLbl.hidden = NO;
}

/**
 * @description  adding pagination buttons based on the totalRecords
 * @date         17/11/15
 * @method       addPaginationButtons
 * @author       Chandhu
 * @param        totalRecords
 * @param
 * @return
 * @verified By
 * @verified On
 */
- (void)addPaginationButtons:(int)totalRecords {
    
    @try {
        float btnXposition = 15.0;
        int totalPages = [WebServiceUtility getTotalNumberOfPages:totalRecords];
        int presentPages = [WebServiceUtility getTotalNumberOfPages:messageStartIndex];
        if (totalRecordsView.subviews){
            for (UIButton *subview in totalRecordsView.subviews) {
                [subview removeFromSuperview];
            }
        }
        if (presentPages > 0) {
            UIButton *paginationButton = [[UIButton alloc] init];
            
            [paginationButton setBackgroundImage:[UIImage imageNamed:@"Button1.png"] forState:UIControlStateNormal] ;
            
            paginationButton.backgroundColor = [UIColor clearColor];
            paginationButton.frame = CGRectMake(btnXposition, 0.0, 50.0, 50.0);
            paginationButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            [paginationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            paginationButton.layer.cornerRadius = paginationButton.frame.size.height/2.0;
            [paginationButton addTarget:self action:@selector(showNextMessages:) forControlEvents:UIControlEventTouchUpInside];
            [paginationButton setEnabled:TRUE];
            paginationButton.tag = -2;
            [paginationButton setTitle:@"<<" forState:UIControlStateNormal];
            [totalRecordsView addSubview:paginationButton];
            btnXposition = btnXposition + 60.0;
        }
        for (int i = 0; i < totalPages - presentPages; i++) {
            
            UIButton *paginationButton = [[UIButton alloc] init];
            
            [paginationButton setBackgroundImage:[UIImage imageNamed:@"Button1.png"] forState:UIControlStateNormal] ;
            
            paginationButton.backgroundColor = [UIColor clearColor];
            [paginationButton setTitle:[NSString stringWithFormat:@"%d",buttonTitleIndex + 1] forState:UIControlStateNormal];
            paginationButton.frame = CGRectMake(btnXposition, 0.0, 50.0, 50.0);
            paginationButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            [paginationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            paginationButton.layer.cornerRadius = paginationButton.frame.size.height/2.0;
            [paginationButton addTarget:self action:@selector(showNextMessages:) forControlEvents:UIControlEventTouchUpInside];
            [paginationButton setEnabled:TRUE];
            if (i >= BUTTONS_PER_PAGE) {
                paginationButton.tag = -1;
                [paginationButton setTitle:@">>" forState:UIControlStateNormal];
                [totalRecordsView addSubview:paginationButton];
                break;
            }
            paginationButton.tag = i;
            
            [totalRecordsView addSubview:paginationButton];
            buttonTitleIndex++;
            btnXposition = btnXposition + 60.0;
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

/**
 * @description  getting the next page messages and displaying in table
 * @date         17/11/15
 * @method       showNextMessages
 * @author       Chandhu
 * @param        UIButton(sender)
 * @param
 * @return
 * @verified By
 * @verified On
 */
- (void) showNextMessages :(UIButton *) sender {
    [sender setSelected:YES];
    AudioServicesPlaySystemSound (soundFileObject);
    if (sender.tag == -1) {
        pageIndex++;
        buttonIndex++;
        buttonTitleIndex = buttonIndex * 5;
        messageStartIndex = pageIndex * 15;
        [self getMessageDetails];
    }
    else if (sender.tag == -2) {
        pageIndex--;
        buttonIndex--;
        buttonTitleIndex = buttonIndex * 5;
        messageStartIndex = pageIndex * 15;
        [self getMessageDetails];
    }
    else {
        messagesPerPageArr = [WebServiceUtility getMessagesFromPositon:(int)sender.tag fromArray:messageDetailsArr];
        [messageTable reloadData];
    }
}

/**
 * @description  populating message details of particular message
 * @date         17/11/15
 * @method       populateMessageView
 * @author       Chandhu
 * @param        messageDic
 * @param        position
 * @return
 * @verified By
 * @verified On
 */
-(void)populateMessageView:(NSDictionary *)messageDic position:(NSInteger)position{
    
    PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
    
    UIView *messageView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 375, 350)];
    messageView.opaque = NO;
    messageView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5f];
    messageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    messageView.layer.borderWidth = 2.0f;
    [messageView setHidden:NO];
    
    @try {
        
        
        UILabel *messageTypeLbl = [[UILabel alloc] init];
        messageTypeLbl.textColor = [UIColor blackColor];
        messageTypeLbl.font = [UIFont boldSystemFontOfSize:20.0];
        messageTypeLbl.text  = @"Message Type";
        
        UILabel *messageTypeLblValue = [[UILabel alloc] init];
        messageTypeLblValue.textColor = [UIColor blackColor];
        messageTypeLblValue.font = [UIFont boldSystemFontOfSize:20.0];
        messageTypeLblValue.text = [messageDic valueForKey:MESSAGE_TYPE];
        
        UILabel *subjectLabl = [[UILabel alloc] init];
        subjectLabl.textColor = [UIColor blackColor];
        subjectLabl.font = [UIFont boldSystemFontOfSize:18.0];
        subjectLabl.text  = @"Subject";
        
        UILabel *subjectLablValue = [[UILabel alloc] init];
        subjectLablValue.textColor = [UIColor blackColor];
        subjectLablValue.font = [UIFont boldSystemFontOfSize:18.0];
        subjectLablValue.text  = [messageDic valueForKey:MESSAGE_SUBJECT];
        
        
        UITextView *messageTextView = [[UITextView alloc] init];
        [messageTextView sizeToFit];
        messageTextView.text = [messageDic valueForKey:MESSAGE_BODY];
        messageTextView.showsVerticalScrollIndicator = YES;
        messageTextView.backgroundColor = [UIColor clearColor];
        messageTextView.scrollEnabled = YES;
        messageTextView.editable = NO;
        messageTextView.selectable = NO;
        messageTextView.bounces = YES;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
                
                messageTypeLbl.frame =  CGRectMake(10, 10, 150, 30);
                messageTypeLblValue.frame =  CGRectMake(180.0, 10, 200, 30);
                subjectLabl.frame =  CGRectMake(10, 50.0, 150, 30);
                subjectLablValue.frame = CGRectMake(180.0, 40.0, 150, 50);
                messageTextView.frame = CGRectMake(5.0, 80.0, messageView.frame.size.width - 10.0, 210.0);
                messageTextView.font = [UIFont boldSystemFontOfSize:15.0];
            }
        }
        [messageView addSubview:messageTypeLbl];
        [messageView addSubview:messageTypeLblValue];
        [messageView addSubview:subjectLabl];
        [messageView addSubview:subjectLablValue];
        [messageView addSubview:messageTextView];
        
        customerInfoPopUp.view = messageView;
        
        NSIndexPath *selectedRow = [NSIndexPath indexPathForRow:position inSection:0];
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(messageView.frame.size.width, messageView.frame.size.height);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            [popover presentPopoverFromRect:[messageTable cellForRowAtIndexPath:selectedRow].frame inView:messageTable permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
            
            
            messagePopOver= popover;
            
        }
        
        else {
            
            customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            // popover.contentViewController.view.alpha = 0.0;
            popover.contentViewController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
            [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            messagePopOver = popover;
            
        }
        
    }
    @catch (NSException *exception) {
        [messagePopOver dismissPopoverAnimated:YES];
        NSLog(@"%@",exception.name);
    }
    @finally {
    }
}



// Action for the buttons on segmented control ..
- (void) segmentAction: (id) sender  {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    segmentedControl = (UISegmentedControl *)sender;
    NSInteger index = segmentedControl.selectedSegmentIndex;
    
    segmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment;
    
    switch (index) {
        case 0:
        {
            Configuration *config = [[Configuration alloc] init] ;
            
            UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:config];
            nc.navigationBar.tintColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
            [self presentViewController:nc animated:YES completion:nil];
            
            break;
        }
        case 1:
        {
            NSURL *url = [NSURL URLWithString:@"aboutUs.html"];
            WebViewController *webViewController = [[WebViewController alloc] initWithURL:url andTitle:@"aboutUs"];
            UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:webViewController];
            nc.navigationBar.tintColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
            [self presentViewController:nc animated:YES completion:nil];
            
            break;
        }
        case 2:
        {
            NSURL *url = [NSURL URLWithString:@"billing.html"];
            WebViewController *webViewController = [[WebViewController alloc] initWithURL:url andTitle:@"billing"];
            UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:webViewController];
            nc.navigationBar.tintColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
            [self presentViewController:nc animated:YES completion:nil];
            
        }
    }
    
}






#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == homeTable) {
        return prod_img_array.count;
    }
    else if (tableView == listTableView) {
        return gridImagesArr.count;
    }
    else if (tableView == messageTable) {
        NSLog(@"%lu",(unsigned long)messagesPerPageArr.count);
        
        return messagesPerPageArr.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == homeTable) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            
            return ceilf(148.0);
        }
        else {
            return 90.0;
        }
    }
    else if (tableView == messageTable) {
        return 95.0;
    }
    else {
        return 80;
    }
    
    
}

//int currentSelection = -1;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    tableView.separatorColor = [UIColor clearColor];
    
    if (tableView == homeTable) {
        static NSString *MyIdentifier = @"MyIdentifier";
        MyIdentifier = @"TableView";
        CellView *cell = (CellView *)[tableView dequeueReusableCellWithIdentifier: MyIdentifier];
        
        if(cell == nil) {
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                [[NSBundle mainBundle] loadNibNamed:@"CellView" owner:self options:nil];
                cell = cellView;
            }
            else {
                
                [[NSBundle mainBundle] loadNibNamed:@"CellView-iPhone" owner:self options:nil];
                cell = cellView;
            }
        }
        cell.backgroundColor = [UIColor clearColor];
        
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
            
            cell.contentView.backgroundColor = [UIColor clearColor];
        }
        
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = bgColorView;
        
        [cell celBackgroundImage:YES];
        
        [cell ProductImage:prod_img_array[indexPath.row]];
        [cell ProductLabel:@""];
        
        
        UILabel *lbl2 = [[UILabel alloc] init];
        //    lbl2.text= [subModuleArry2 objectAtIndex:indexPath.row];
        lbl2.text = @"";
        lbl2.textAlignment = NSTextAlignmentCenter;
        
        
        cellBackground.hidden = NO;
        
        cellBackground1.hidden = YES;
        //    }
        
        
        UILabel *line1 = [[UILabel alloc] init];
        line1.backgroundColor = [UIColor clearColor];
        line1.textColor = [UIColor whiteColor];
        line1.hidden = YES;
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            line1.text = @"-------------";
            line1.frame = CGRectMake(590.0, 87, 280, 5);
            lbl2.textColor = [UIColor grayColor];
            lbl2.backgroundColor=[UIColor clearColor];
            lbl2.font = [UIFont boldSystemFontOfSize:20];
            //        lbl1.frame = CGRectMake(450, 30, 200, 30);
            lbl2.frame = CGRectMake(450, 105, 200, 60);
            
        }
        else {
            
            line1.text = @"-------";
            line1.frame = CGRectMake(245, 52, 138, 4);
            lbl2.textColor = [UIColor grayColor];
            lbl2.backgroundColor=[UIColor clearColor];
            lbl2.font = [UIFont boldSystemFontOfSize:11];
            lbl2.frame = CGRectMake(160.0, 75, 100, 12);
            
        }
        
        [cell.contentView addSubview:line1];
        
        [cell.contentView addSubview:lbl2];
        
        return cell;
    }
    else if (tableView == listTableView) {
        
        @try {
            static NSString *MyIdentifier = @"MyIdentifier";
            ListViewCustomCell *cell = (ListViewCustomCell *)[tableView dequeueReusableCellWithIdentifier: MyIdentifier];
            
            if(cell == nil) {
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    
                    cell = [[NSBundle mainBundle] loadNibNamed:@"ListViewCustomCell" owner:self options:nil][0];
                    
                    //                cell = cellView;
                }
                else {
                    //                [[NSBundle mainBundle] loadNibNamed:@"CellView-iPhone" owner:self options:nil];
                    //                cell = cellView;
                }
            }
            
            cell.backgroundColor = [UIColor clearColor];
            
            cell.flowIconImg.image = [UIImage imageNamed:gridImagesArr[indexPath.row]];
            cell.flowDocumentLbl.text = gridImageNamesArr[indexPath.row];
            cell.noOfDocsLbl.text = [NSString stringWithFormat:@"(%@)",noOfDocsArr[indexPath.row]];
            cell.pendingDocsLbl.text = [NSString stringWithFormat:@"(%@)",noOfPendingDocsArr[indexPath.row]];
            cell.lastSubmittedDate.text = lastUpdatedDate[indexPath.row];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            
            
        } @catch (NSException *exception) {
            NSLog(@"%@",exception);
            
        } @finally {
            
            
        }
        
    }
    
    else  {
        
        MessageTableCellViewTableViewCell *messageCell;
        
        @try {
            
            tableView.separatorColor = [UIColor clearColor];
            static NSString *MyIdentifier = @"MyIdentifier";
            MyIdentifier = @"TableView";
            messageCell = (MessageTableCellViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier: MyIdentifier];
            
            NSDictionary *messageDic = messagesPerPageArr[indexPath.row];
            
            if(messageCell == nil) {
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    
                    messageCell =  [[NSBundle mainBundle] loadNibNamed:@"MessageTableCellViewTableViewCell" owner:self options:nil][0];
                    
                    //messageCell = [[MessageTableCellViewTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MyIdentifier];
                    
                }
                else {
                    messageCell =  [[NSBundle mainBundle] loadNibNamed:@"CellView-iPhone" owner:self options:nil][0];
                    //messageCellView = messageCell;
                }
                
            }
            
            messageCell.mainMessageView.layer.cornerRadius = messageCell.mainMessageView.frame.size.height/2;
            messageCell.messageBodyLbl.text = [messageDic valueForKey:MESSAGE_BODY];
            messageCell.messageSubLbl.text = [messageDic valueForKey:MESSAGE_SUBJECT];
            messageCell.mainMessageLbl.text = [[messageDic valueForKey:MESSAGE_SUBJECT] substringToIndex:1].uppercaseString;
            messageCell.messageDateLbl.text = [messageDic valueForKey:MESSAGE_DATE];
            
            // [messageCell addMessageDetails:[messagesPerPageArr objectAtIndex:indexPath.row]];
            
            messageCell.backgroundColor = [UIColor clearColor];
            if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
                
                messageCell.contentView.backgroundColor = [UIColor clearColor];
            }
            
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception.name);
        }
        
        return messageCell;
    }
    
}

int pos = -1;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == homeTable) {
        int pos1 = (int)indexPath.row;
        
        if (pos != pos1) {
            //Play Audio for button touch....
            AudioServicesPlaySystemSound (soundFileObject);
            pos = pos1;
        }
        
        //currentSelection = indexPath.row;
        CellView *cell = (CellView *)[tableView cellForRowAtIndexPath:indexPath];
        tableView.separatorColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        // float version = [[[UIDevice currentDevice] systemVersion] floatValue];
        UIImageView *imageView;
        
        //= [[cell.contentView subviews] objectAtIndex:2];
        
        for(id view in (cell.contentView).subviews){
            
            if([view tag] == 2){
                
                imageView = (UIImageView *)view;
                imageView.layer.borderWidth = 3.5f;
                imageView.layer.cornerRadius = 18.0f;
                imageView.layer.borderColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0].CGColor;
            }
            
        }
        
        //imageView.backgroundColor = [UIColor whiteColor];
        
        [cell celBackgroundImage:YES];
        
        
        
        
        
        
        //NSLog(@"%@",[cell.contentView subviews]);
        
        
        //commented by srinivasulu on 29/04/2019...
        
        //        CheckWifi *wifi = [[CheckWifi alloc]init];
        //        BOOL status = [wifi checkWifi];
        //        if (status) {
        //
        //            isOfflineService = FALSE;
        //        }
        //        else {
        //            isOfflineService = TRUE;
        //        }
        //
        //        if (isOfflineService) {
        //
        //            self.titleLabel.text = @"Omni Retailer-Offline";
        //
        //
        //        }
        //        else {
        //            self.titleLabel.text = @"Omni Retailer-Online";
        //
        //        }
        
        //upto here on 29/04/2017....
        
        
        //  [self viewDidAppear:YES];
        
        NSString *str = prod_img_array[pos1];
        
        if ([str isEqualToString:@"Billing1.png"]) {
            
            
            if (!isOfflineService && ![WebServiceUtility checkAcessControlForMain:@"Billing"]) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
            
            //commented by Srinivasulu on 21/10/2017....
            //reason -- animation is not required in this page....
            
            
            //            SystemSoundID    soundFileObject1;
            //            NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"page-flip" withExtension: @"mp3"];
            //            self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
            //            AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
            //            AudioServicesPlaySystemSound (soundFileObject1);
            
            
            //            [UIView  transitionWithView:billingView duration:1.2  options:UIViewAnimationOptionTransitionCurlUp
            //                             animations:^(void) {
            //                                 BOOL oldState = [UIView areAnimationsEnabled];
            //                                 [UIView setAnimationsEnabled:NO];
            //                                 [UIView setAnimationsEnabled:oldState];
            //                             }
            //                             completion:nil];
            
            
            //upto here on 21/10/2017..
            
            line.text = @"BILLING";
            newBillButton.hidden = NO;
            oldBillButton.hidden = NO;
            deliveryIcon.hidden = NO;
            cancelledButton.hidden = NO;
            pendingIcon.hidden = NO;
            scrollView.hidden = YES;
            dealsButton.hidden = YES;
            offersButton.hidden = YES;
            newOrders.hidden = YES;
            oldOrders.hidden = YES;
            dOrder.hidden = YES;
            complaints.hidden = YES;
            newReports.hidden = YES;
            oldReports.hidden = YES;
            loyaltyGiftVoucherScroll.hidden = YES;
            wareHouseScrollView.hidden = YES;
            XZreport.hidden = YES;
            zreadingcon.hidden = YES;
            zreading.hidden = YES;
            
            
            selectedFlowStr = @"Billing";
            
            selectedFlowPosInt = 0;
        }
        //    else {
        //        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature is not available with this edition" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //        [alert show];
        //        return;
        //    }
        else if ([str isEqualToString:@"Stocks1.png"]){
            CheckWifi *wifi = [[CheckWifi alloc]init];
            BOOL status = [wifi checkWifi];
            if (status) {
                
                isOfflineService = FALSE;
            }
            else {
                isOfflineService = TRUE;
            }
            
            if (isOfflineService) {
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"message", nil) message:NSLocalizedString(@"this_feature_can_only_be_used_with_internet_connectivity", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                [alert show];
                
            }
            else  if (![WebServiceUtility checkAcessControlForMain:@"StockManagement"]) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
            else {
                
                //commented by Srinivasulu on 21/10/2017....
                //reason -- animation is not required in this page....
                
                //                SystemSoundID    soundFileObject1;
                //                NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"page-flip" withExtension: @"mp3"];
                //                self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
                //                AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                //                AudioServicesPlaySystemSound (soundFileObject1);
                
                //                [UIView  transitionWithView:billingView duration:1.2  options:UIViewAnimationOptionTransitionCurlUp
                //                                 animations:^(void) {
                //                                     BOOL oldState = [UIView areAnimationsEnabled];
                //                                     [UIView setAnimationsEnabled:NO];
                //                                     [UIView setAnimationsEnabled:oldState];
                //                                 }
                //                                 completion:nil];
                
                //upto here on 21/10/2017....
                
                line.text = @"STOCK MANAGEMENT";
                newBillButton.hidden = YES;
                oldBillButton.hidden = YES;
                deliveryIcon.hidden = YES;
                pendingIcon.hidden = YES;
                scrollView.hidden = NO;
                dealsButton.hidden = YES;
                offersButton.hidden = YES;
                newOrders.hidden = YES;
                oldOrders.hidden = YES;
                dOrder.hidden = YES;
                complaints.hidden = YES;
                newReports.hidden = YES;
                oldReports.hidden = YES;
                loyaltyGiftVoucherScroll.hidden = YES;
                wareHouseScrollView.hidden = YES;
                XZreport.hidden = YES;
                zreadingcon.hidden = YES;
                zreading.hidden = YES;
                cancelledButton.hidden = YES;
                
            }
            
            selectedFlowStr = @"Stocks";
            
            selectedFlowPosInt = 1;
            
        }
        else if ([str isEqualToString:@"Deals1.png"]){
            CheckWifi *wifi = [[CheckWifi alloc]init];
            BOOL status = [wifi checkWifi];
            if (status) {
                
                isOfflineService = FALSE;
            }
            else {
                isOfflineService = TRUE;
            }
            
            if (isOfflineService) {
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"message", nil) message:NSLocalizedString(@"this_feature_can_only_be_used_with_internet_connectivity", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                [alert show];
                
            }
            else  if (![WebServiceUtility checkAcessControlForMain:@"DealsAndOffers"]) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
            else {
                
                //commented by Srinivasulu on 21/10/2017....
                //reason -- animation is not required in this page....
                
                //                SystemSoundID    soundFileObject1;
                //                NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"page-flip" withExtension: @"mp3"];
                //                self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
                //                AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                //                AudioServicesPlaySystemSound (soundFileObject1);
                //
                //                [UIView  transitionWithView:billingView duration:1.2  options:UIViewAnimationOptionTransitionCurlUp
                //                                 animations:^(void) {
                //                                     BOOL oldState = [UIView areAnimationsEnabled];
                //                                     [UIView setAnimationsEnabled:NO];
                //                                     [UIView setAnimationsEnabled:oldState];
                //                                 }
                //                                 completion:nil];
                
                //upto here on 21/10/2017....
                
                
                line.text = @"DEALS & OFFERS";
                newBillButton.hidden = YES;
                oldBillButton.hidden = YES;
                deliveryIcon.hidden = YES;
                pendingIcon.hidden = YES;
                scrollView.hidden = YES;
                dealsButton.hidden = NO;
                offersButton.hidden = NO;
                newOrders.hidden = YES;
                oldOrders.hidden = YES;
                dOrder.hidden = YES;
                complaints.hidden = YES;
                newReports.hidden = YES;
                oldReports.hidden = YES;
                loyaltyGiftVoucherScroll.hidden = YES;
                wareHouseScrollView.hidden = YES;
                XZreport.hidden = YES;
                zreadingcon.hidden = YES;
                zreading.hidden = YES;
                cancelledButton.hidden = YES;
                
            }
            
            selectedFlowStr = @"Deals and Offers";
            
            selectedFlowPosInt = 2;
            
        }
        else if ([str isEqualToString:@"Orders1.png"]){
            CheckWifi *wifi = [[CheckWifi alloc]init];
            BOOL status = [wifi checkWifi];
            if (status) {
                
                isOfflineService = FALSE;
            }
            else {
                isOfflineService = TRUE;
            }
            
            if (isOfflineService) {
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"message", nil) message:NSLocalizedString(@"this_feature_can_only_be_used_with_internet_connectivity", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                [alert show];
                
            }

            else  if (![WebServiceUtility checkAcessControlForMain:@"Orders"]) {

                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
            else {
                
                //commented by Srinivasulu on 21/10/2017....
                //reason -- animation is not required in this page....
                
                //                SystemSoundID    soundFileObject1;
                //                NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"page-flip" withExtension: @"mp3"];
                //                self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
                //                AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                //                AudioServicesPlaySystemSound (soundFileObject1);
                //
                //                [UIView  transitionWithView:billingView duration:1.2  options:UIViewAnimationOptionTransitionCurlUp
                //                                 animations:^(void) {
                //                                     BOOL oldState = [UIView areAnimationsEnabled];
                //                                     [UIView setAnimationsEnabled:NO];
                //                                     [UIView setAnimationsEnabled:oldState];
                //                                 }
                //                                 completion:nil];
                
                //upto here on 21/10/2017....
                
                line.text = @"ORDERS";
                
                newBillButton.hidden = YES;
                oldBillButton.hidden = YES;
                deliveryIcon.hidden = YES;
                pendingIcon.hidden = YES;
                scrollView.hidden = YES;
                dealsButton.hidden = YES;
                offersButton.hidden = YES;
                newOrders.hidden = NO;
                oldOrders.hidden = NO;
                dOrder.hidden = NO;
                complaints.hidden = NO;
                newReports.hidden = YES;
                oldReports.hidden = YES;
                loyaltyGiftVoucherScroll.hidden = YES;
                wareHouseScrollView.hidden = YES;
                XZreport.hidden = YES;
                zreadingcon.hidden = YES;
                zreading.hidden = YES;
                cancelledButton.hidden = YES;
                
            }
            
            selectedFlowStr = @"Orders";
            
            selectedFlowPosInt = 3;
            
        }
        else if ([str isEqualToString:@"Loyalty1.png"]){
            
            CheckWifi *wifi = [[CheckWifi alloc]init];
            BOOL status = [wifi checkWifi];
            if (status) {
                
                isOfflineService = FALSE;
            }
            else {
                isOfflineService = TRUE;
            }
            
            if (isOfflineService) {
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"message", nil) message:NSLocalizedString(@"this_feature_can_only_be_used_with_internet_connectivity", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                [alert show];
                
            }
            else  if (![WebServiceUtility checkAcessControlForMain:@"LoyaltyCards"]) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
            else {
                
                //commented by Srinivasulu on 21/10/2017....
                //reason -- animation is not required in this page....
                
                //                SystemSoundID    soundFileObject1;
                //                NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"page-flip" withExtension: @"mp3"];
                //                self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
                //                AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                //                AudioServicesPlaySystemSound (soundFileObject1);
                //
                //                [UIView  transitionWithView:billingView duration:1.2  options:UIViewAnimationOptionTransitionCurlUp
                //                                 animations:^(void) {
                //                                     BOOL oldState = [UIView areAnimationsEnabled];
                //                                     [UIView setAnimationsEnabled:NO];
                //                                     [UIView setAnimationsEnabled:oldState];
                //                                 }
                //                                 completion:nil];
                
                //upto here on 21/10/2017....
                
                line.text = @"LOYALTY CARD";
                
                newBillButton.hidden = YES;
                oldBillButton.hidden = YES;
                deliveryIcon.hidden = YES;
                pendingIcon.hidden = YES;
                scrollView.hidden = YES;
                dealsButton.hidden = YES;
                offersButton.hidden = YES;
                newOrders.hidden = YES;
                oldOrders.hidden = YES;
                dOrder.hidden = YES;
                complaints.hidden = YES;
                newReports.hidden = YES;
                oldReports.hidden = YES;
                loyaltyGiftVoucherScroll.hidden = NO;
                wareHouseScrollView.hidden = YES;
                XZreport.hidden = YES;
                zreadingcon.hidden = YES;
                zreading.hidden = YES;
                cancelledButton.hidden = YES;
                
            }
            
            selectedFlowStr = @"Loyalty";
            
            selectedFlowPosInt = 4;
            
        }
        else if ([str isEqualToString:@"Reports1.png"]){
            CheckWifi *wifi = [[CheckWifi alloc]init];
            BOOL status = [wifi checkWifi];
            if (status) {
                
                isOfflineService = FALSE;
            }
            else {
                isOfflineService = TRUE;
            }
            
            if (![WebServiceUtility checkAcessControlForMain:@"Reports"]) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
            
            
            //        if (isOfflineService) {
            //
            //            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            //            [alert show];
            //
            //        }
            //        else {
            
            
            //commented by Srinivasulu on 21/10/2017....
            //reason -- animation is not required in this page....
            
            //            SystemSoundID    soundFileObject1;
            //            NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"page-flip" withExtension: @"mp3"];
            //            self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
            //            AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
            //            AudioServicesPlaySystemSound (soundFileObject1);
            //
            //            [UIView  transitionWithView:billingView duration:1.2  options:UIViewAnimationOptionTransitionCurlUp
            //                             animations:^(void) {
            //                                 BOOL oldState = [UIView areAnimationsEnabled];
            //                                 [UIView setAnimationsEnabled:NO];
            //                                 [UIView setAnimationsEnabled:oldState];
            //                             }
            //                             completion:nil];
            
            //upto here on 21/10/2017....
            
            line.text = @"REPORTS";
            newBillButton.hidden = YES;
            oldBillButton.hidden = YES;
            deliveryIcon.hidden = YES;
            pendingIcon.hidden = YES;
            scrollView.hidden = YES;
            dealsButton.hidden = YES;
            offersButton.hidden = YES;
            newOrders.hidden = YES;
            oldOrders.hidden = YES;
            dOrder.hidden = YES;
            complaints.hidden = YES;
            newReports.hidden = NO;
            oldReports.hidden = NO;
            XZreport.hidden = NO;
            zreadingcon.hidden = NO;
            zreading.hidden = NO;
            loyaltyGiftVoucherScroll.hidden = YES;
            wareHouseScrollView.hidden = YES;
            cancelledButton.hidden = YES;
            //        }
            
            selectedFlowStr = @"Reports";
            
            selectedFlowPosInt = 5;
            
        }
        else if([str isEqualToString:@"Table.png"]){ // staff_service.png
            
            selectedFlowStr = @"Services";
            selectedFlowPosInt = 7;
            
        }
        
        [self reloadCollectionView:selectedFlowPosInt];
        
    }
    
    
    else if(tableView == messageTable)
    {
        UITableViewCell* theCell = [tableView cellForRowAtIndexPath:indexPath];
        //theCell.contentView.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:232.0/255.0 blue:124.0/255.0 alpha:1.0];
        theCell.contentView.backgroundColor=[UIColor clearColor];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        @try {
            [self populateMessageView:messagesPerPageArr[indexPath.row] position:indexPath.row];
            
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception.name);
        }
        @finally {
            
        }
    }
    else {
        
        @try {
            UIButton *btn = [[UIButton alloc] init];
            btn.tag = indexPath.row;
            
            [self prduct1_method:btn];
            
            
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
    
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if(tableView == homeTable){
        CellView *cell = (CellView *)[tableView cellForRowAtIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor clearColor];
        tableView.separatorColor = [UIColor clearColor];
        version = [UIDevice currentDevice].systemVersion.floatValue;
        UIImageView *imageView;
        //        = [[cell.contentView subviews] objectAtIndex:2];
        //        imageView.layer.borderColor = [UIColor clearColor].CGColor;
        
        for(id view in (cell.contentView).subviews){
            
            if([view tag] == 2){
                
                imageView = (UIImageView *)view;
                imageView.layer.borderColor = [UIColor clearColor].CGColor;
            }
            
        }
        
        
        UIImageView *backImage = (cell.contentView).subviews[0];
        backImage.image = [UIImage imageNamed:@"bgc1.png"];
        
        [cell celBackgroundImage:YES];
    }
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == homeTable) {
        
        // setup initial state (e.g. before animation)
        cell.layer.shadowColor = [UIColor blackColor].CGColor;
        cell.layer.shadowOffset = CGSizeMake(10, 10);
        cell.alpha = 0;
        cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5);
        cell.layer.anchorPoint = CGPointMake(0, 0.5);
        //!!!FIX for issue #1 Cell position wrong------------
        if(cell.layer.position.x != 0){
            cell.layer.position = CGPointMake(0, cell.layer.position.y);
        }
        // define final state (e.g. after animation) & commit animation
        [UIView beginAnimations:@"scaleTableViewCellAnimationID" context:NULL];
        [UIView setAnimationDuration:1.0];
        cell.layer.shadowOffset = CGSizeMake(0, 0);
        cell.alpha = 1;
        cell.layer.transform = CATransform3DIdentity;
        [UIView commitAnimations];
        
    }
}


- (void) prduct1_method:(id)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    //    self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
    //    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] ;
    
    Boolean isToCheckAccessInOffline = true;
    
    if(!isZreportHasTaken && ([selectedFlowStr isEqualToString:@"Billing"] && [sender tag] == 0) && (!isOfflineService)){
        
        zReportAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"previous_day_z_report_alert", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
        [zReportAlert show];
        [HUD setHidden:YES];
        return;
    }
    
    if ([selectedFlowStr isEqualToString:@"Billing"] && [sender tag] == 0) {
        
        if (!isOfflineService || isToCheckAccessInOffline) {
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"NewBill"subFlow:@"NewBill" mainFlow:@"Billing"];
            if (accessVal == kWriteVal || accessVal == kReadWrite) {
                
                BOOL isDayOpened  = [[NSUserDefaults standardUserDefaults] boolForKey:IS_DAY_OPEN];
                
                if(!isDayOpened && !isOfflineService) {
                    
                    DayStart * dayOpen = [[DayStart alloc] init];
                    [self.navigationController pushViewController:dayOpen animated:YES];
                    
                } else {
                    
                    BillingHome *bh = [[BillingHome alloc] init] ;
                    [self.navigationController pushViewController:bh animated:YES];
                }
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }
            
        }
        else {
            BillingHome *bh = [[BillingHome alloc] init] ;
            [self.navigationController pushViewController:bh animated:YES];
            
        }
        //
        
    }
    
    else if ([selectedFlowStr isEqualToString:@"Billing"] && [sender tag] == 1) {
        
        if (!isOfflineService || isToCheckAccessInOffline) {
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"NewBill"subFlow:@"NewBill" mainFlow:@"Billing"];
            if (accessVal == kWriteVal || accessVal == kReadWrite) {
                
                BillingHome *bh = [[BillingHome alloc] init] ;
                bh.isNewReturnBill = true;
                [self.navigationController pushViewController:bh animated:YES];
                
                //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"This feature is not available for this edition" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                //                [alert show];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }
            
        }
        else {
            BillingHome *bh = [[BillingHome alloc] init] ;
            bh.isNewReturnBill = true;
            [self.navigationController pushViewController:bh animated:YES];
            
            //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"This feature is not available for this edition" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            //            [alert show];
        }
        
    }
    
    else if ([selectedFlowStr isEqualToString:@"Billing"] && [sender tag] == 2) {
        
        if (!isOfflineService || isToCheckAccessInOffline) {
            
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"NewBill"subFlow:@"NewBill" mainFlow:@"Billing"];
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                PastBillsList *pb = [[PastBillsList alloc] init] ;
                [self.navigationController pushViewController:pb animated:YES];
                
            }
        }
        
        else {
            PastBillsList *pb = [[PastBillsList alloc] init] ;
            [self.navigationController pushViewController:pb animated:YES];
        }
        
        //        typeBilling = @"past";
    }
    
    
    //added by Srinivasulu on 25/04/2017....
    
    
    
    else if ([selectedFlowStr isEqualToString:@"Billing"] && [sender tag] == 3) {
        
        if (!isOfflineService || isToCheckAccessInOffline) {
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"PendigBill"subFlow:@"PendigBill" mainFlow:@"Billing"];
            
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                
                PendingBills *pb = [[PendingBills alloc] init] ;
                
                //added by Srinivasulu on 24/04/2017....
                
                pb.billStatusStr = OPEN;
                
                //upto here on 24/04/2017....
                
                [self.navigationController pushViewController:pb animated:YES];
                
            }
            
        }
        else {
            
            PendingBills *pb = [[PendingBills alloc] init];
            
            //added by Srinivasulu on 24/04/2017....
            
            pb.billStatusStr = OPEN;
            
            //upto here on 24/04/2017....
            
            [self.navigationController pushViewController:pb animated:YES];
        }
    }
    
    
    //upto here on 24/04/2017.....
    
    else if ([selectedFlowStr isEqualToString:@"Billing"] && [sender tag] == 4) {
        
        if (!isOfflineService || isToCheckAccessInOffline) {
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"PendigBill"subFlow:@"PendigBill" mainFlow:@"Billing"];
            
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                
                PendingBills *pb = [[PendingBills alloc] init] ;
                pb.billStatusStr = @"pending";
                [self.navigationController pushViewController:pb animated:YES];
            }
            
        }
        else {
            PendingBills *pb = [[PendingBills alloc] init];
            
            
            //added by Srinivasulu on 24/04/2017....
            
            pb.billStatusStr = @"pending";
            
            //upto here on 24/04/2017....
            
            [self.navigationController pushViewController:pb animated:YES];
        }
    }
    else if ([selectedFlowStr isEqualToString:@"Billing"] && [sender tag] == 5) {
        
        if (!isOfflineService || isToCheckAccessInOffline) {
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"PendigBill"subFlow:@"PendigBill" mainFlow:@"Billing"];
            
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                
                PendingBills * pb = [[PendingBills alloc] init] ;
                pb.billStatusStr = @"draft";
                [self.navigationController pushViewController:pb animated:YES];
            }
            
        }
        else {
            
            PendingBills * pb = [[PendingBills alloc] init];
            pb.billStatusStr = @"draft";
            [self.navigationController pushViewController:pb animated:YES];
        }
    }
    
    else if ([selectedFlowStr isEqualToString:@"Billing"] && [sender tag] == 6) {
        
        if (!isOfflineService || isToCheckAccessInOffline) {
            
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"HomeDeliveryBill"subFlow:@"HomeDeliveryBill" mainFlow:@"Billing"];
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                DoorDeliveryBills *door = [[DoorDeliveryBills alloc] init] ;
                [self.navigationController pushViewController:door animated:YES];
                
            }
        }
        else {
            DoorDeliveryBills *door = [[DoorDeliveryBills alloc] init] ;
            [self.navigationController pushViewController:door animated:YES];
        }
        
        
    }
    else if ([selectedFlowStr isEqualToString:@"Billing"] && [sender tag] == 7) {
        
        if (!isOfflineService || isToCheckAccessInOffline) {
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"CancelledBill"subFlow:@"CancelledBill" mainFlow:@"Billing"];
            
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                CancelledBills *cancelled = [[CancelledBills alloc] init] ;
                [self.navigationController pushViewController:cancelled animated:YES];
                
            }
            
        }
        else {
            CancelledBills *cancelled = [[CancelledBills alloc] init] ;
            [self.navigationController pushViewController:cancelled animated:YES];
            
        }
    }
    
    else if ([selectedFlowStr isEqualToString:@"Billing"] && [sender tag] == 8) {
        ReturnBill *returnBills = [[ReturnBill alloc] init] ;
        [self.navigationController pushViewController:returnBills animated:YES];
    }
    
    else if ([selectedFlowStr isEqualToString:@"Billing"] && [sender tag] == 9) {
        ExchangeBill *exchangeBills = [[ExchangeBill alloc] init] ;
        [self.navigationController pushViewController:exchangeBills animated:YES];
    }
    
    else if ([selectedFlowStr isEqualToString:@"Billing"] && [sender tag] == 10) {
        if (!isOfflineService) {
            
            ViewWalkoutCustomer *walkOut = [[ViewWalkoutCustomer alloc] init] ;
            [self.navigationController pushViewController:walkOut animated:YES];
        }
        else {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    
    
    else if ([selectedFlowStr isEqualToString:@"Billing"] && [sender tag] == 11) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"This feature is not available for this edition" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        //        if (!isOfflineService) {
        //            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"NewBill"subFlow:@"NewBill" mainFlow:@"Billing"];
        //            if (accessVal == kWriteVal || accessVal == kReadWrite) {
        //
        //                ExchangingBillingHome *bh = [[ExchangingBillingHome alloc] init] ;
        //                bh.isDirectExchangeBill = true;
        //                [self.navigationController pushViewController:bh animated:YES];
        //            }
        //            else {
        //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //                [alert show];
        //
        //            }
        //
        //        }
        //        else {
        //            ExchangingBillingHome *bh = [[ExchangingBillingHome alloc] init] ;
        //            bh.isDirectExchangeBill = true;
        //            [self.navigationController pushViewController:bh animated:YES];
        //
        //        }
        
        
    }
    else if ([selectedFlowStr isEqualToString:@"Billing"] && [sender tag] == 12) {
        
        if (!isOfflineService) {
            
            BOOL isDayOpened  = [[NSUserDefaults standardUserDefaults] boolForKey:IS_DAY_OPEN];
            
            if(!isDayOpened) {
                
                DayStart * dayOpen = [[DayStart alloc] init];
                [self.navigationController pushViewController:dayOpen animated:YES];
                
            } else {
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:NSLocalizedString(@"day_open_is_already_created",nil) delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        else {
            
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
    // Stock Transfer Flow:
    
    else if ([selectedFlowStr isEqualToString:@"Stocks"] && [sender tag] == 0) {
        if (!isOfflineService) {
            
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"StockmanagementViewStocks"subFlow:@"StockmanagementViewStocks" mainFlow:@"StockManagement"];
            
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                CriticalStock * ns = [[CriticalStock alloc] init] ;
                [self.navigationController pushViewController:ns animated:YES];
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
    else if ([selectedFlowStr isEqualToString:@"Stocks"] && [sender tag] == 1) {
        if (!isOfflineService) {
            
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"StockReceipt"subFlow:@"GoodsTransfer" mainFlow:@"StockManagement"];
            
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                
                NewStockVerificationViewController * ns = [[NewStockVerificationViewController alloc] init] ;
                [self.navigationController pushViewController:ns animated:YES];
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    
    else if ([selectedFlowStr isEqualToString:@"Stocks"] && [sender tag] == 2){
        if (!isOfflineService) {
            
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"StockRequest"subFlow:@"GoodsTransfer" mainFlow:@"StockManagement"];
            
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                
                
                stockRequest *sr = [[stockRequest alloc] init] ;
                [self.navigationController pushViewController:sr animated:YES];
                
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    
    else if ([selectedFlowStr isEqualToString:@"Stocks"] && [sender tag] == 3){
        if (!isOfflineService) {
            
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"StockRequest"subFlow:@"GoodsTransfer" mainFlow:@"StockManagement"];
            
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                
                
                OutBoundStockRequest *sr = [[OutBoundStockRequest alloc] init] ;
                [self.navigationController pushViewController:sr animated:YES];
                
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    
    else if ([selectedFlowStr isEqualToString:@"Stocks"] && [sender tag] == 4){
        
        if (!isOfflineService) {
            
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"StockIssue"subFlow:@"GoodsTransfer" mainFlow:@"StockManagement"];
            
            if (accessVal == kAcessDenied) {
                
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                MaterialTransferIssue * ns = [[MaterialTransferIssue alloc] init];
                [self.navigationController pushViewController:ns animated:YES];
                
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    else if ([selectedFlowStr isEqualToString:@"Stocks"] && [sender tag] == 5){
        
        if (!isOfflineService) {
            
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"StockReceipt"subFlow:@"GoodsTransfer" mainFlow:@"StockManagement"];
            
            
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                
                OpenStockReceipt *osr = [[OpenStockReceipt alloc] init] ;
                [self.navigationController pushViewController:osr animated:YES];
                
                
            }
            
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
    else if ([selectedFlowStr isEqualToString:@"Stocks"] && [sender tag] == 6){
        
        if (!isOfflineService) {
            
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"StockReturn"subFlow:@"GoodsTransfer" mainFlow:@"StockManagement"];
            
            if (accessVal == kAcessDenied) {
                
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                ViewGoodsReturn *goodsReturn = [[ViewGoodsReturn alloc] init];
                [self.navigationController pushViewController:goodsReturn animated:YES];
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
    // Commented By Bhargav.v on 18/05/2018...
    //Reason Currently we dont have purchase order in Outlet Level
    // As per the Specification....
    
    //    else if ([selectedFlowStr isEqualToString:@"Stocks"] && [sender tag] == 6){
    //        if (!isOfflineService) {
    //
    //            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"Receipts"subFlow:@"GoodsProcurement" mainFlow:@"StockManagement"];
    //            if (accessVal == kAcessDenied) {
    //
    //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //                [alert show];
    //            }
    //            else {
    //                CreatePurchaseOrder *cs = [[CreatePurchaseOrder alloc] init ];
    //                [self.navigationController pushViewController:cs animated:YES];
    //            }
    //        }
    //        else {
    //            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //            [alert show];
    //        }
    //    }
    
    else if ([selectedFlowStr isEqualToString:@"Stocks"] && [sender tag] == 7){
        if (!isOfflineService) {
            
            //            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"Receipts"subFlow:@"GoodsProcurement" mainFlow:@"StockManagement"];
            //            if (accessVal == kAcessDenied) {
            //
            //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            //                [alert show];
            //            }
            //            else {
            
            GoodsReceiptNoteView * cs = [[GoodsReceiptNoteView alloc] init ];
            [self.navigationController pushViewController:cs animated:YES];
            //            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    
    else if ([selectedFlowStr isEqualToString:@"Stocks"] && [sender tag] == 8){
        if (!isOfflineService) {
            
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"ShipmentReturn"subFlow:@"GoodsProcurement" mainFlow:@"StockManagement"];
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                ShipmentReturnSummary * shr = [[ShipmentReturnSummary alloc] init ];
                [self.navigationController pushViewController:shr animated:YES];
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    //End of Stock Management Flows
    //Deals and Offers:
    
    else if ([selectedFlowStr isEqualToString:@"Deals and Offers"] && [sender tag] == 0){
        if (!isOfflineService) {
            
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"Deals"subFlow:@"Deals" mainFlow:@"DealsAndOffers"];
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                CurrentDeals *cd = [[CurrentDeals alloc] init];
                [self.navigationController pushViewController:cd animated:YES];
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    
    else if ([selectedFlowStr isEqualToString:@"Deals and Offers"] && [sender tag] == 1){
        if (!isOfflineService) {
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"Offers"subFlow:@"Offers" mainFlow:@"DealsAndOffers"];
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                Offers *pd = [[Offers alloc] init ];
                [self.navigationController pushViewController:pd animated:YES];
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
    //    End of Deals and Offers:
    
    // Orders:
    
    else if ([selectedFlowStr isEqualToString:@"Orders"] && [sender tag] == 0){
        
        if (!isOfflineService) {
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"Order"subFlow:@"Order" mainFlow:@"Orders"];
            if (accessVal == kAcessDenied) {

                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                ViewOrders *vo = [[ViewOrders alloc] init ];
                [self.navigationController pushViewController:vo animated:YES];
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
    else if ([selectedFlowStr isEqualToString:@"Orders"] && [sender tag] == 1){
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"This feature is not available for this edition" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    
    
    else if ([selectedFlowStr isEqualToString:@"Orders"] && [sender tag] == 2){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"This feature is not available for this edition" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    
    
    else if ([selectedFlowStr isEqualToString:@"Orders"] && [sender tag] == 3){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"This feature is not available for this edition" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    // added by roja on 09/01/2019...
    // commented by roja on 23/02/2019...
    // reason this flow is included in View Booking(ServiceOrders) flow..
//    else if ([selectedFlowStr isEqualToString:@"Orders"] && [sender tag] == 4){
//
//        if (!isOfflineService) {
//
//            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"Order"subFlow:@"Order" mainFlow:@"Orders"];
//
//            if (accessVal == kAcessDenied) {
//
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                [alert show];
//
//            }
//            else {
//                NewRestBooking *restBooking = [[NewRestBooking alloc] init];
//                [self.navigationController pushViewController:restBooking animated:YES];
//            }
//        }
//        else {
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//        }
//    }
    
    // added by roja on 09/01/2019...
    else if ([selectedFlowStr isEqualToString:@"Orders"] && [sender tag] == 4){
        
        if (!isOfflineService) {

            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"Order"subFlow:@"Order" mainFlow:@"Orders"];

            if (accessVal == kAcessDenied) {

                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                ServiceOrders *no = [[ServiceOrders alloc] init] ;
                no.orderType = @"immediate";
                [self.navigationController pushViewController:no animated:YES];
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    //    end of orders:
    // Upto here added by roja on 09/01/2019...
    
    //    Loyality Cards:
    else if ([selectedFlowStr isEqualToString:@"Loyalty"] && [sender tag] == 0){
        if (!isOfflineService) {
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"Offers"subFlow:@"Offers" mainFlow:@"DealsAndOffers"];
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                IssueLowyalty *pd = [[IssueLowyalty alloc] init ];
                [self.navigationController pushViewController:pd animated:YES];
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
    
    else if ([selectedFlowStr isEqualToString:@"Loyalty"] && [sender tag] == 1){
        if (!isOfflineService) {
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"Offers"subFlow:@"Offers" mainFlow:@"DealsAndOffers"];
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                ShowLowyalty *pd = [[ShowLowyalty alloc] init ];
                [self.navigationController pushViewController:pd animated:YES];
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
    else if ([selectedFlowStr isEqualToString:@"Loyalty"] && [sender tag] == 2){
        if (!isOfflineService) {
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"Offers"subFlow:@"Offers" mainFlow:@"DealsAndOffers"];
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                EditLoyalty *pd = [[EditLoyalty alloc] init ];
                [self.navigationController pushViewController:pd animated:YES];
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
    else if ([selectedFlowStr isEqualToString:@"Loyalty"] && [sender tag] == 3){
        if (!isOfflineService) {
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"Offers"subFlow:@"Offers" mainFlow:@"DealsAndOffers"];
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                IssueGiftVoucher *pd = [[IssueGiftVoucher alloc] init ];
                [self.navigationController pushViewController:pd animated:YES];
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
    else if ([selectedFlowStr isEqualToString:@"Loyalty"] && [sender tag] == 4){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"This feature is not available for this edition" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    
    else if ([selectedFlowStr isEqualToString:@"Loyalty"] && [sender tag] == 5){
        if (!isOfflineService) {
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"Offers"subFlow:@"Offers" mainFlow:@"DealsAndOffers"];
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                ViewGiftVoucher *pd = [[ViewGiftVoucher alloc] init ];
                [self.navigationController pushViewController:pd animated:YES];
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
    else if ([selectedFlowStr isEqualToString:@"Loyalty"] && [sender tag] == 6){
        if (!isOfflineService) {
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"Offers"subFlow:@"Offers" mainFlow:@"DealsAndOffers"];
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                // Commented by roja on 14/06/2019
//                IssueGiftCoupon *giftCoupon = [[IssueGiftCoupon alloc] init ];
                
                IssueGiftCouponFlow * giftCoupon = [[IssueGiftCouponFlow alloc] init];
                [self.navigationController pushViewController:giftCoupon animated:YES];
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
    else if ([selectedFlowStr isEqualToString:@"Loyalty"] && [sender tag] == 7){
        if (!isOfflineService) {
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"Offers"subFlow:@"Offers" mainFlow:@"DealsAndOffers"];
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                ViewGiftCoupon *pd = [[ViewGiftCoupon alloc] init ];
                [self.navigationController pushViewController:pd animated:YES];
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
    // added by roja on 28/11/2019....
    else if ([selectedFlowStr isEqualToString:@"Loyalty"] && [sender tag] == 8){
        
        if (!isOfflineService) {
            
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"Offers"subFlow:@"Offers" mainFlow:@"DealsAndOffers"];
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                IssueLoyaltyCard *pd = [[IssueLoyaltyCard alloc] init ];
                [self.navigationController pushViewController:pd animated:YES];
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    // Upto here added by roja on 28/11/2019....
    //  End  Loyality Cards
    
    
    
    //   Reports:
    
    
    else if ([selectedFlowStr isEqualToString:@"Reports"] && [sender tag] == 0){
        if (!isOfflineService) {
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"SalesReports"subFlow:@"SalesReports" mainFlow:@"Reports"];
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                //                SalesReports *pd = [[SalesReports alloc] init ];
                //                [self.navigationController pushViewController:pd animated:YES];
                
                saleNo = selectedTableRowNumber;
                
                [self reloadCollectionView:6];
                
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
    
    
    
    else if ([selectedFlowStr isEqualToString:@"Reports"] && [sender tag] == 1){
        
        //        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"This feature is not available for this edition" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //        [alert show];
        
        if (!isOfflineService) {
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"SalesReports"subFlow:@"SalesReports" mainFlow:@"Reports"];
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                //                CategoryWiseReports *pd = [[CategoryWiseReports alloc] init ];
                //                [self.navigationController pushViewController:pd animated:YES];
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        
    }
    
    
    else if ([selectedFlowStr isEqualToString:@"Reports"] && [sender tag] ==2){
        if (!isOfflineService) {
            
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"XReport"subFlow:@"XReport" mainFlow:@"Reports"];
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
                
            }
            else {
                
                [self populateDenominations];
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    else if ([selectedFlowStr isEqualToString:@"Reports"] && [sender tag] ==3){
        if (!isOfflineService) {
            
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"ZReport"subFlow:@"ZReport" mainFlow:@"Reports"];
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
                
            }
            else {
                
                ZReportController *report = [[ZReportController alloc] init];
                [self.navigationController pushViewController:report animated:YES];
            }
            
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    else if ([selectedFlowStr isEqualToString:@"Reports"] && [sender tag] ==4){
        if (!isOfflineService) {
            
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"ZReportConsolidate"subFlow:@"ZReportConsolidate" mainFlow:@"Reports"];
            
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }
            else {
                [self getXZReports:@"xz"];
            }
            
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    
    else if ([selectedFlowStr isEqualToString:@"Reports1"] && [sender tag] == 0){
        if (!isOfflineService) {
            
            //changed by Srinivasulu on on 01/05/2017...
            //            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"SalesReports"subFlow:@"SalesReports" mainFlow:@"Reports"];
            
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"XReport"subFlow:@"XReport" mainFlow:@"Reports"];
            
            //upto here on 01/05/2017...
            
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                [self populateDenominations];
                
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
    
    /*DateWise
     CounterWise
     CategoryWise
     DepartmentWise
     SkuWise
     HourWise
     BrandWise
     SectionWise
     SupplierWise
     TaxWise
     DueCollection
     CreditSales*/
    
    else if ([selectedFlowStr isEqualToString:@"Reports1"] && [sender tag] == 1){
        
        if (!isOfflineService) {
            //changed by Srinivasulu on on 01/05/2017...
            //            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"SalesReports"subFlow:@"SalesReports" mainFlow:@"Reports"];
            
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"ZReport"subFlow:@"ZReport" mainFlow:@"Reports"];
            
            //upto here on 01/05/2017...
            
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                
                //changed by Srinivasulu on 09/10/2017....
                
                [self showCustomerWalkOutScreen];
                //                ZReportController * report = [[ZReportController alloc] init];
                //                [self.navigationController pushViewController:report animated:YES];
                
                //upto here on 09/10/2017....
                
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        
    }
    
    else if ([selectedFlowStr isEqualToString:@"Reports1"] && [sender tag] ==2){
        if (!isOfflineService) {
            
            //changed by Srinivasulu on on 01/05/2017...
            
            //            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"XReport"subFlow:@"XReport" mainFlow:@"Reports"];
            
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"DateWise"subFlow:@"DateWise" mainFlow:@"Reports"];
            
            //upto here on 01/05/2017...
            
            
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
                
            }
            else {
                
                SalesReports *pd = [[SalesReports alloc] init ];
                [self.navigationController pushViewController:pd animated:YES];
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    else if ([selectedFlowStr isEqualToString:@"Reports1"] && [sender tag] ==3){
        if (!isOfflineService) {
            
            //changed by Srinivasulu on on 01/05/2017...
            
            //            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"ZReport"subFlow:@"ZReport" mainFlow:@"Reports"];
            
            
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"CategoryWise"subFlow:@"CategoryWise" mainFlow:@"Reports"];
            
            
            //upto here on 01/05/2017...
            
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
                
            }
            else {
                CategoryWiseReports *pd = [[CategoryWiseReports alloc] init ];
                [self.navigationController pushViewController:pd animated:YES];
                
            }
            
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    else if ([selectedFlowStr isEqualToString:@"Reports1"] && [sender tag] ==4){
        if (!isOfflineService) {
            
            //changed by Srinivasulu on on 01/05/2017...
            
            
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"SkuWise"subFlow:@"SkuWise" mainFlow:@"Reports"];
            
            //upto here on 01/05/2017...
            
            
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }
            else {
                
                SkuWiseReport *skuWiseReport=[[SkuWiseReport alloc]init];
                [self.navigationController pushViewController: skuWiseReport animated:YES];
            }
            
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    else if ([selectedFlowStr isEqualToString:@"Reports1"] && [sender tag] ==5){
        if (!isOfflineService) {
            
            //changed by Srinivasulu on on 01/05/2017....
            
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"MaterialConsumption"subFlow:@"MaterialConsumption" mainFlow:@"Reports"];
            
            //upto here on 01/05/2017....
            
            
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }
            else {
                
                MaterialConsumptionController *materialConsumption=[[MaterialConsumptionController alloc]init];
                [self.navigationController pushViewController:materialConsumption animated:YES];
            }
            
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    else if ([selectedFlowStr isEqualToString:@"Reports1"] && [sender tag] ==6){
        if (!isOfflineService) {
            
            //changed by Srinivasulu on on 01/05/2017...
            
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"SupplierWise"subFlow:@"SupplierWise" mainFlow:@"Reports"];
            
            //upto here on 01/05/2017...
            
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }
            else {
                
                SuppliesReports *suppliesReport=[[SuppliesReports alloc]init];
                [self.navigationController pushViewController: suppliesReport animated:YES];
            }
            
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    else if ([selectedFlowStr isEqualToString:@"Reports1"] && [sender tag] ==7){
        if (!isOfflineService) {
            
            //changed by Srinivasulu on on 01/05/2017...
            
            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"TaxWise"subFlow:@"TaxWise" mainFlow:@"Reports"];
            
            //upto here on 01/05/2017...
            
            if (accessVal == kAcessDenied) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }
            else {
                
                TaxWiseReports *taxWiseReport=[[TaxWiseReports alloc]init];
                [self.navigationController pushViewController: taxWiseReport animated:YES];
            }
            
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    
    else if ([selectedFlowStr isEqualToString:@"Reports1"] && [sender tag] ==8){
        if (!isOfflineService) {
            
            //changed by Srinivasulu on on 01/05/2017...
            
            
            //            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"SkuWise"subFlow:@"SkuWise" mainFlow:@"Reports"];
            
            //upto here on 01/05/2017...
            
            
            //            if (accessVal == kAcessDenied) {
            //
            //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            //                [alert show];
            //
            //            }
            //            else {
            
            HourWiseReports * hourWiseReport = [[HourWiseReports alloc]init];
            [self.navigationController pushViewController:hourWiseReport animated:YES];
            //            }
            
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    
    else if ([selectedFlowStr isEqualToString:@"Reports1"] && [sender tag] ==9){
        if (!isOfflineService) {
            
            //changed by Srinivasulu on on 01/05/2017...
            
            //            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"SkuWise"subFlow:@"SkuWise" mainFlow:@"Reports"];
            
            //upto here on 01/05/2017...
            
            
            //            if (accessVal == kAcessDenied) {
            //
            //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            //                [alert show];
            //
            //            }
            //            else {
            
            VoidItemsReport * voidItemsReport = [[VoidItemsReport alloc]init];
            [self.navigationController pushViewController:voidItemsReport animated:YES];
            //            }
            
        }
        else {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
    else if ([selectedFlowStr isEqualToString:@"Reports1"] && [sender tag] ==10){
        if (!isOfflineService) {
            
            //changed by Srinivasulu on on 01/05/2017...
            
            //            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"SkuWise"subFlow:@"SkuWise" mainFlow:@"Reports"];
            
            //upto here on 01/05/2017...
            
            
            //            if (accessVal == kAcessDenied) {
            //
            //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            //                [alert show];
            //
            //            }
            //            else {
            
            SalesPriceOverrideReport * ovverideReport = [[SalesPriceOverrideReport alloc]init];
            [self.navigationController pushViewController:ovverideReport animated:YES];
            //            }
            
        }
        else {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
    else if ([selectedFlowStr isEqualToString:@"Reports1"] && [sender tag] ==11){
        if (!isOfflineService) {
            
            //changed by Srinivasulu on on 01/05/2017...
            
            //            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"SkuWise"subFlow:@"SkuWise" mainFlow:@"Reports"];
            
            //upto here on 01/05/2017...
            
            
            //            if (accessVal == kAcessDenied) {
            //
            //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            //                [alert show];
            //
            //            }
            //            else {
            
            SalemenCommissionReport * ovverideReport = [[SalemenCommissionReport alloc]init];
            [self.navigationController pushViewController:ovverideReport animated:YES];
            //            }
            
        }
        else {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else if ([selectedFlowStr isEqualToString:@"Reports1"] && [sender tag] ==12){
        if (!isOfflineService) {
            
            //changed by Srinivasulu on on 01/05/2017...
            
            //            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"SkuWise"subFlow:@"SkuWise" mainFlow:@"Reports"];
            
            //upto here on 01/05/2017...
            
            
            //            if (accessVal == kAcessDenied) {
            //
            //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            //                [alert show];
            //
            //            }
            //            else {
            
            DepartmentWiseReport * departmentReport = [[DepartmentWiseReport alloc]init];
            [self.navigationController pushViewController:departmentReport animated:YES];
            //            }
            
        }
        else {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else if ([selectedFlowStr isEqualToString:@"Services"] && [sender tag] == 0){
        if (!isOfflineService) {
            
            //changed by Srinivasulu on on 01/05/2017...
            
            //            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"SkuWise"subFlow:@"SkuWise" mainFlow:@"Reports"];
            
            //upto here on 01/05/2017...
            
            
            //            if (accessVal == kAcessDenied) {
            //
            //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            //                [alert show];
            //
            //            }
            //            else {
            
            
            ServiceStaff *service = [[ServiceStaff alloc] init] ;
            [self.navigationController pushViewController:service animated:YES];
            //            }
            
        }
        else {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else if ([selectedFlowStr isEqualToString:@"Services"] && [sender tag] == 1){
        if (!isOfflineService) {
            
            //changed by Srinivasulu on on 01/05/2017...
            
            //            int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"SkuWise"subFlow:@"SkuWise" mainFlow:@"Reports"];
            
            //upto here on 01/05/2017...
            
            
            //            if (accessVal == kAcessDenied) {
            //
            //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            //                [alert show];
            //
            //            }
            //            else {
            
            
            KitchenOrderToken *kotFlow = [[KitchenOrderToken alloc] init] ;
            [self.navigationController pushViewController:kotFlow animated:YES];
            //            }
            
        }
        else {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature can  only be used with internet connectivity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    // End of Reports
    
}

/**
 * @description  In this method we are forming the item view along with edit price details....
 * @date
 * @method       backGroundProcess
 * @author
 * @param
 * @param
 * @param
 *
 * @return       void
 *
 * @modified By  Srinivasulu on 29/09/2017. and before also & 10/07/2018....
 * @reason       reason -- changing the download related code and replaced some of the string into from WebServiceConstant & in date saving removed time....
 *
 * @verified By
 * @verified On
 *
 */

-(void)backGroundProcess {
    
    //commented by Srinivasulu on 03/10/2017....
    //reason is view should should show in main thread only....
    
    //    loadingView.hidden = NO;
    
    //upto here on 03/10/2017....
    
    BOOL skuSaved = FALSE;
    BOOL taxSaved = FALSE;
    BOOL dealSaved = FALSE;
    BOOL offerSaved = FALSE;
    BOOL employeesSaved = FALSE;
    BOOL denominationsSaved = FALSE;
    BOOL categoriesSaved = FALSE;
    BOOL subCategorySaved = FALSE;
    BOOL productSaved =FALSE;
    BOOL customersListSaved =FALSE;
    
    // added by roja on 06/05/2019..
    BOOL loyaltyCardsDownloadSaved =FALSE;
    BOOL giftCouponsDownloadSaved =FALSE;
    BOOL vouchersDownloadSaved =FALSE;
// added by roja on 06/06/2019...
    
    OfflineBillingServices *offline = [[OfflineBillingServices alloc]init];
    @try {
        if (skuStatus) {
            
            skuSaved =[offline getSkuDetails:skuStartIndex totalRecords:DOWNLOAD_RATE];
            skuStartIndex = skuStartIndex + DOWNLOAD_RATE;
            
            while (skuStartIndex <= totalAvailSkuRecords) {
                
                NSLog(@"----Complete SKU_MASTER -- Count -- to download----%d",skuStartIndex);
                
                skuSaved = [offline getSkuDetails:skuStartIndex totalRecords:DOWNLOAD_RATE];
                skuStartIndex = skuStartIndex + DOWNLOAD_RATE;
            }
            
            if (skuStartIndex >= totalAvailSkuRecords && skuSaved) {
                
                NSDate *today = [NSDate date];
                NSDateFormatter * tempDateFormate = [[NSDateFormatter alloc] init];
                //                [tempDateFormate setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
                tempDateFormate.dateFormat = @"dd/MM/yyyy";
                NSString * currentdate = [tempDateFormate stringFromDate:today];
                
                currentdate = [NSString stringWithFormat:@"%@%@",currentdate,@" 00:00:00"];
                //sku_master_table....  -- note :-- LAST_SKU_UPDATED_DATE and LAST_SKU_UPDATED both are using for sku_master download need to be removed any one....
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:currentdate forKey:LAST_SKU_UPDATED];
                [defaults setObject:currentdate forKey:LAST_SKU_UPDATED_DATE];
                
                [defaults synchronize];
            }
            skuSaved = true;
            if (skuSaved) {
                skuSaved = [offline getSkuEanDetails:skuEanIndex totalRecords:DOWNLOAD_RATE];
                skuEanIndex = skuEanIndex + DOWNLOAD_RATE;
                while (skuEanIndex<=totalAvailSkuEans) {
                    
                    NSLog(@"----Complete SKU_EAN -- Count -- to download----%d",skuEanIndex);
                    
                    skuSaved =[offline getSkuEanDetails:skuEanIndex totalRecords:DOWNLOAD_RATE];
                    skuEanIndex = skuEanIndex + DOWNLOAD_RATE;
                }
                if (skuEanIndex >= totalAvailSkuEans && skuSaved) {
                    NSDate *today = [NSDate date];
                    NSDateFormatter * tempDateFormate = [[NSDateFormatter alloc] init];
                    //                [tempDateFormate setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
                    tempDateFormate.dateFormat = @"dd/MM/yyyy";
                    NSString * currentdate = [tempDateFormate stringFromDate:today];
                    
                    currentdate = [NSString stringWithFormat:@"%@%@",currentdate,@" 00:00:00"];
                    
                    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setObject:currentdate forKey:LAST_SKU_EAN_UPDATED];
                    
                    [defaults synchronize];
                }
            }
            skuSaved = true;
            if (skuSaved) {
                NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
                skuSaved =[offline getPriceLists:skuPriceStartIndex totalRecords:DOWNLOAD_RATE];
                skuPriceStartIndex = skuPriceStartIndex + DOWNLOAD_RATE;
                while (skuPriceStartIndex<=totalAvailPriceRecords) {
                    
                    NSLog(@"----Complete SKU_PRICE_LIST -- Count -- to download----%d",skuPriceStartIndex);
                    
                    skuSaved =[offline getPriceLists:skuPriceStartIndex totalRecords:DOWNLOAD_RATE];
                    skuPriceStartIndex = skuPriceStartIndex + DOWNLOAD_RATE;
                }
                if (skuPriceStartIndex >= totalAvailPriceRecords && skuSaved) {
                    NSDate *today = [NSDate date];
                    NSDateFormatter * tempDateFormate = [[NSDateFormatter alloc] init];
                    //                [tempDateFormate setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
                    tempDateFormate.dateFormat = @"dd/MM/yyyy";
                    NSString * currentdate = [tempDateFormate stringFromDate:today];
                    
                    currentdate = [NSString stringWithFormat:@"%@%@",currentdate,@" 00:00:00"];
                    
                    [defaults setObject:currentdate forKey:LAST_PRICE_UPDATED];
                    [defaults synchronize];
                }
            }
        }
        else {
            skuSaved = TRUE;
        }
        if (dealStatus) {
            
            
            //            [self deleteFromTable:@"deals"];
            //            [self deleteFromTable:@"deals_ranges"];
            
            dealSaved = [offline getDeals];
            
            
            if(dealSaved || ([[defaults valueForKey:LAST_DEALS_UPDATED] isKindOfClass:[NSNull class]] || [defaults valueForKey:LAST_DEALS_UPDATED] == nil)){
                
                NSDate *today = [NSDate date];
                NSDateFormatter * tempDateFormate = [[NSDateFormatter alloc] init];
                //                [tempDateFormate setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
                tempDateFormate.dateFormat = @"dd/MM/yyyy";
                NSString * currentdate = [tempDateFormate stringFromDate:today];
                
                currentdate = [NSString stringWithFormat:@"%@%@",currentdate,@" 00:00:00"];
                
                [defaults setObject:currentdate forKey:LAST_DEALS_UPDATED];
                [defaults synchronize];
            }
        }
        else {
            dealSaved = TRUE;
        }
        
        if (offerStatus) {
            
            //            [self deleteFromTable:@"offers"];
            //            [self deleteFromTable:@"offer_ranges"];
            
            offerSaved = [offline getOffers];
            
            
            //added by Srinivasulu on /09/2017....
            
            if(offerSaved || ([[defaults valueForKey:LAST_OFFERS_UPDATED] isKindOfClass:[NSNull class]] || [defaults valueForKey:LAST_OFFERS_UPDATED] == nil)) {
                
                NSDate *today = [NSDate date];
                NSDateFormatter * tempDateFormate = [[NSDateFormatter alloc] init];
                //                [tempDateFormate setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
                tempDateFormate.dateFormat = @"dd/MM/yyyy";
                NSString * currentdate = [tempDateFormate stringFromDate:today];
                
                currentdate = [NSString stringWithFormat:@"%@%@",currentdate,@" 00:00:00"];
                
                [defaults setObject:currentdate forKey:LAST_OFFERS_UPDATED];
                [defaults synchronize];
            }
            
            //upto here on 29/09/2017....
            
        }
        else {
            offerSaved = TRUE;
        }
        if (dealStatus || offerStatus) {
            //            [self dropTable:@"groups_master"];
            //
            //            [self dropTable:@"groups_child"];
            
            //commented by Srinivauslu on 19/04/2017.... just to stop the downLoad....and uncommented
            [offline getGroupItems];
            //upto here on 19/04/2017....
        }
        if (taxStatus) {
            
            //changed by Srinivasululu on 05/05/2017....
            //added the condition....
            //written the Srinivasul on 29/09/2017.... here need to handling the repeat calling.... and default key implementation as all....
            
            taxSaved = [offline getStoreTaxationDetailsThroughtSoapServices];
            
            //            NSArray * arr =  [offline getTaxForSku:@"Vat2"];
            //            NSLog(@"%@",arr);
            
            //            if([finalTaxDetails count])
            //                taxSaved = [offline saveTaxes:finalTaxDetails];
            //            else
            //                taxSaved = TRUE;
            
            
            //upto here on 05/05/2017.....
            
        }
        else {
            
            taxSaved = TRUE;
        }
        
        if (employeeStatus) {
            
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            employeesSaved =[offline getEmployeeDetails:employeeStartIndex totalRecords:DOWNLOAD_RATE];
            employeeStartIndex = employeeStartIndex + DOWNLOAD_RATE;
            while (employeeStartIndex<=totalAvailEmployees) {
                
                NSLog(@"%@",[defaults valueForKey:LAST_EMPL_UPDATED_DATE]);
                employeesSaved =[offline getEmployeeDetails:employeeStartIndex totalRecords:DOWNLOAD_RATE];
                employeeStartIndex = employeeStartIndex + DOWNLOAD_RATE;
            }
            
            //changed by Srinivasulu on 29/09/2017....
            //reason -- is in case of no records also date should to chnaged -- lastEmplUpdatedDate -- to --  LAST_EMPL_UPDATED_DATE
            //no need to handle null or nill in defaults....
            
            if (employeeStartIndex >= totalAvailEmployees) {
                
                employeesSaved = true;
            }
            
            
            if(employeesSaved || ([[defaults valueForKey:LAST_EMPL_UPDATED_DATE] isKindOfClass:[NSNull class]] || [defaults valueForKey:LAST_EMPL_UPDATED_DATE] == nil)){
                
                NSDate *today = [NSDate date];
                NSDateFormatter * tempDateFormate = [[NSDateFormatter alloc] init];
                //                [tempDateFormate setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
                tempDateFormate.dateFormat = @"dd/MM/yyyy";
                NSString * currentdate = [tempDateFormate stringFromDate:today];
                currentdate = [NSString stringWithFormat:@"%@%@",currentdate,@" 00:00:00"];
                
                [defaults setObject:currentdate forKey:LAST_EMPL_UPDATED_DATE];
                [defaults synchronize];
            }
            
            //upto here on 29/09/2017....
        }
        else {
            
            employeesSaved = true;
        }
        
        if (denominationStatus) {
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            denominationsSaved =[offline getDenominationsDetails:denominationStartIndex totalRecords:DOWNLOAD_RATE];
            denominationStartIndex = denominationStartIndex + DOWNLOAD_RATE;
            
            while (denominationStartIndex<=totalAvailDenominations) {
                
                NSLog(@"%@",[defaults valueForKey:LAST_DENOMINATIONS_UPDATE_DATE]);
                denominationsSaved =[offline getDenominationsDetails:denominationStartIndex totalRecords:DOWNLOAD_RATE];
                denominationStartIndex = denominationStartIndex + DOWNLOAD_RATE;
            }
            
            //changed by Srinivasulu on 29/09/2017....
            //reason -- is in case of no records also date should to chnaged -- lastDenominationsUpdatedDate -- to --  LAST_DENOMINATIONS_UPDATE_DATE
            //no need to handle null or nill in defaults....
            
            if (denominationStartIndex >= totalAvailDenominations) {
                
                denominationsSaved = true;
            }
            
            if(denominationsSaved || ([[defaults valueForKey:LAST_DENOMINATIONS_UPDATE_DATE] isKindOfClass:[NSNull class]] || [defaults valueForKey:LAST_DENOMINATIONS_UPDATE_DATE] == nil)){
                
                NSDate *today = [NSDate date];
                NSDateFormatter * tempDateFormate = [[NSDateFormatter alloc] init];
                //                [tempDateFormate setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
                tempDateFormate.dateFormat = @"dd/MM/yyyy";
                NSString * currentdate = [tempDateFormate stringFromDate:today];
                currentdate = [NSString stringWithFormat:@"%@%@",currentdate,@" 00:00:00"];
                
                [defaults setObject:currentdate forKey:LAST_DENOMINATIONS_UPDATE_DATE];
                [defaults synchronize];
            }
            
            //upto here on 29/09/2017....
            
        }
        else {
            
            denominationsSaved = true;
        }
        
        
        
        
        if (productStatus){
            
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            productSaved = [offline  getProducts:productStartIndex totalRecords:DOWNLOAD_RATE];
            productStartIndex = productStartIndex + DOWNLOAD_RATE;
            while (productStartIndex <= totalAvailableProducts) {
                
                NSLog(@"%@",[defaults valueForKey:UPDATED_DATE_STR]);
                productSaved =[offline getProducts:productStartIndex totalRecords:DOWNLOAD_RATE];
                productStartIndex = productStartIndex + DOWNLOAD_RATE;
            }
            
            //chnaged by Srinivasulu on 29/09/2017....
            //reason -- is in case of no records also date should to chnaged -- updatedDateStr -- to --  UPDATED_DATE_STR
            //Category and subCategory and product master complete there depending on Key....
            if (productStartIndex >= totalAvailableProducts) {
                
                productSaved = true;
            }
            //upto here on 29/09/2017....
        }
        else{
            
            productSaved = true;
        }
        
        if (categoryStatus){
            
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            categoriesSaved = [offline  getProductCategories:categoryStartIndex totalRecords:DOWNLOAD_RATE];
            categoryStartIndex = categoryStartIndex + DOWNLOAD_RATE;
            while (categoryStartIndex <= totalAvailableCategories) {
                
                NSLog(@"%@",[defaults valueForKey:UPDATED_DATE_STR]);
                categoriesSaved =[offline getProductCategories:categoryStartIndex totalRecords:DOWNLOAD_RATE];
                categoryStartIndex = categoryStartIndex + DOWNLOAD_RATE;
            }
            
            //chnaged by Srinivasulu on 29/09/2017....
            //reason -- is in case of no records also date should to chnaged -- updatedDateStr -- to --  UPDATED_DATE_STR
            //Category and subCategory and product master complete there depending on Key....
            
            if (categoryStartIndex >= totalAvailableCategories) {
                
                categoriesSaved = true;
            }
            //upto here on 29/09/2017....
        }
        else{
            
            categoriesSaved = true;
        }
        
        if (subCategoruStatus){
            
//            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            subCategorySaved = [offline  getSubCategories:subCategoryStartIndex totalRecords:DOWNLOAD_RATE];
            categoryStartIndex = categoryStartIndex + DOWNLOAD_RATE;
            while (subCategoryStartIndex <= totalAvailableSubCategories) {
                
//                NSLog(@"%@",[defaults valueForKey:UPDATED_DATE_STR]);
                subCategorySaved =[offline getSubCategories:subCategoryStartIndex totalRecords:DOWNLOAD_RATE];
                subCategoryStartIndex = subCategoryStartIndex + DOWNLOAD_RATE;
            }
            
            //chnaged by Srinivasulu on 29/09/2017....
            //reason -- is in case of no records also date should to chnaged -- updatedDateStr -- to --  UPDATED_DATE_STR
            //Category and subCategory and product master complete there depending on Key....
            
            if (subCategoryStartIndex >= totalAvailableSubCategories) {
                
                subCategorySaved = true;
            }
            //upto here on 29/09/2017....
        }
        else{
            
            subCategorySaved = true;
        }
        
        //it is added by Srinivasulu on 30/05/2018 && 06/09/2018....
        
        if(productStatus || categoryStatus || subCategoruStatus){
            
            [offline callMenuDetails];
        }
        
        if(customerDownLoadStatus){
            
            customersListSaved = [offline callGetCustomerList:0];
            
            if (customersListSaved){
                customerDownLoadStatus = false;
                NSUserDefaults * tempDefaults = [NSUserDefaults standardUserDefaults];

                NSDate * today = [NSDate date];
                NSDateFormatter * tempDateFormate = [[NSDateFormatter alloc] init];
                //                [tempDateFormate setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
                tempDateFormate.dateFormat = @"dd/MM/yyyy";
                NSString * currentdate = [tempDateFormate stringFromDate:today];
                currentdate = [NSString stringWithFormat:@"%@%@",currentdate,@" 00:00:00"];
                
                [tempDefaults setValue:currentdate forKey:LAST_CUSTOMERS_LIST_UPDATE_DATE];
                [tempDefaults synchronize];
            }
        }
        
        if(memberDetailsDownLoad){
            
            customersListSaved = [offline callGetMemberDetails:0];
            
            if (customersListSaved){
                memberDetailsDownLoad = false;
                NSUserDefaults * tempDefaults = [NSUserDefaults standardUserDefaults];
                
                NSDate * today = [NSDate date];
                NSDateFormatter * tempDateFormate = [[NSDateFormatter alloc] init];
                //                [tempDateFormate setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
                tempDateFormate.dateFormat = @"dd/MM/yyyy";
                NSString * currentdate = [tempDateFormate stringFromDate:today];
                currentdate = [NSString stringWithFormat:@"%@%@",currentdate,@" 00:00:00"];
                
                [tempDefaults setValue:currentdate forKey:LAST_MEMBER_DETAILS_UPDATE_DATE];
                [tempDefaults synchronize];
            }
        }
        
        
        //upto here on 30/05/2018 && 06/09/2018....
        
        //added by Srinivasulu on 29/09/2017....
        
        if((productSaved && categoriesSaved && subCategorySaved) || ([[defaults valueForKey:UPDATED_DATE_STR] isKindOfClass:[NSNull class]] || [defaults valueForKey:UPDATED_DATE_STR] == nil)){
            
            NSUserDefaults * tempDefaults = [NSUserDefaults standardUserDefaults];
            
            productSaved = true;
            categoriesSaved = true;
            subCategorySaved = true;
            
            NSDate *today = [NSDate date];
            NSDateFormatter * tempDateFormate = [[NSDateFormatter alloc] init];
            //                [tempDateFormate setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
            tempDateFormate.dateFormat = @"dd/MM/yyyy";
            NSString * currentdate = [tempDateFormate stringFromDate:today];
            currentdate = [NSString stringWithFormat:@"%@%@",currentdate,@" 00:00:00"];
            
            //changed by Srinivasulu on 03/10/2017....
            
            [tempDefaults setValue:currentdate forKey:UPDATED_DATE_STR];
            //[defaults setObject:currentdate forKey:UPDATED_DATE_STR];
            
            //upto here on 03/10/2017....
            
            [tempDefaults synchronize];
        }
        
        //upto here on 29/09/2017.....
        
        
        // added by roja on 06/05/2019..
        if(loyaltyCardsStatus){
            loyaltyCardsDownloadSaved = [offline getLoyaltyCardDownloadDetailsInCSVFileForm];
            
            if (loyaltyCardsDownloadSaved){
                
                loyaltyCardsStatus = false;
                NSUserDefaults * tempDefaults = [NSUserDefaults standardUserDefaults];
                
                NSDate * today = [NSDate date];
                NSDateFormatter * tempDateFormate = [[NSDateFormatter alloc] init];
                //                [tempDateFormate setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
                tempDateFormate.dateFormat = @"dd/MM/yyyy";
                NSString * currentdate = [tempDateFormate stringFromDate:today];
                currentdate = [NSString stringWithFormat:@"%@%@",currentdate,@" 00:00:00"];

                [tempDefaults setValue:currentdate forKey:LAST_LOYALTY_CARDS_UPDATED_DATE];
                [tempDefaults synchronize];
            }
        }
        if(giftCouponStatus){
            
            giftCouponsDownloadSaved = [offline getCouponsDownloadDetailsInCSVFileForm];
            
            if (giftCouponsDownloadSaved){
                
                giftCouponStatus = false;
                NSUserDefaults * tempDefaults = [NSUserDefaults standardUserDefaults];
                
                NSDate * today = [NSDate date];
                NSDateFormatter * tempDateFormate = [[NSDateFormatter alloc] init];
                //                [tempDateFormate setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
                tempDateFormate.dateFormat = @"dd/MM/yyyy";
                NSString * currentdate = [tempDateFormate stringFromDate:today];
                currentdate = [NSString stringWithFormat:@"%@%@",currentdate,@" 00:00:00"];

                [tempDefaults setValue:currentdate forKey:LAST_GIFT_COUPONS_UPDATED_DATE];
                [tempDefaults synchronize];
            }
        }
        if(giftVoucherStatus){
            
            vouchersDownloadSaved = [offline getVoucherDownloadDetailsInCSVFileForm];
            
            if (vouchersDownloadSaved){
                
                giftVoucherStatus = false;
                NSUserDefaults * tempDefaults = [NSUserDefaults standardUserDefaults];
                
                NSDate * today = [NSDate date];
                NSDateFormatter * tempDateFormate = [[NSDateFormatter alloc] init];

                tempDateFormate.dateFormat = @"dd/MM/yyyy";
                NSString * currentdate = [tempDateFormate stringFromDate:today];
                currentdate = [NSString stringWithFormat:@"%@%@",currentdate,@" 00:00:00"];
                
                [tempDefaults setValue:currentdate forKey:LAST_VOUCHERS_UPDATED_DATE];
                [tempDefaults synchronize];
            }
        }
        
        //Upto here added by roja on 06/05/2019..
       
        if (taxSaved || skuSaved || dealSaved || offerSaved || categoriesSaved || subCategorySaved ||productSaved || denominationsSaved || giftCouponsDownloadSaved || vouchersDownloadSaved || loyaltyCardsDownloadSaved) {
            
            [self updateSyncStatus:dealSaved skus:skuSaved offer:offerSaved tax:taxSaved employeeStatus:employeesSaved denomStatus:denominationsSaved categoryStatus:categoriesSaved subCategoryStatus:subCategorySaved productStatus:productSaved giftCouponStatus:giftCouponsDownloadSaved giftVoucherStatus:vouchersDownloadSaved loyaltyCardStatus:loyaltyCardsDownloadSaved];
        }
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
    }
    @finally {
        skuStatus = FALSE;
        dealStatus = FALSE;
        offerStatus = FALSE;
        taxStatus = FALSE;
        syncStatus = FALSE;
        productStatus = FALSE;
        categoryStatus = FALSE;
        subCategoruStatus = FALSE;
        customerDownLoadStatus = FALSE;
        memberDetailsDownLoad = FALSE;
        loyaltyCardsStatus = FALSE;
        giftCouponStatus = FALSE;
        giftVoucherStatus = FALSE;
        
        //     [hideDelegate closeHudView];
    }
}

- (void)closeHudView{
    
    [HUD setHidden:YES];
    loadingView.hidden = YES;
    skuStatus = FALSE;
    dealStatus = FALSE;
    offerStatus = FALSE;
    taxStatus = FALSE;
    syncStatus = false;
}

-(void)synchUpLocalBills {
    
    int count = 0;
    BOOL billsAvailable = false;
    
    
    @try {
        
        NSString* dbPath = [DataBaseConnection connection:@"RetailerBillingDataBase.sqlite"];
        
        if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
            NSString *query;
            
            
            //changed by Srinivaslulu on 29/08/2017....
            //reason error status are also has to be uploaded....
            
            //            query = [NSString stringWithFormat:@"select count (*) from billing_table where save_status != 'Success' and save_status!='Error'"];
            
            query = [NSString stringWithFormat:@"select count (*) from billing_table where save_status != 'Success'"];
            
            //upto here on 29/08/2017....
            
            // query = [NSString stringWithFormat:@"select count (*) from billing_table where save_status != 'Success' and save_status!='Error'"];
            
            const char *sqlStatement = query.UTF8String;
            
            
            if(sqlite3_prepare_v2(database, sqlStatement, -1, &selectStmt, NULL) == SQLITE_OK) {
                //                        int count = sqlite3_column_count(selectStmt);
                while (sqlite3_step(selectStmt) == SQLITE_ROW) {
                    
                    count = sqlite3_column_int(selectStmt, 0);
                    
                }
                sqlite3_reset(selectStmt);
                sqlite3_finalize(selectStmt);
                selectStmt = nil;
                if (count>0) {
                    billsAvailable = TRUE;
                    
                }
                
            }
            else {
                NSLog(@"%s",sqlite3_errmsg(database)) ;
            }
            
            
            
        }
        if (billsAvailable) {
            // syncStatus = billsAvailable;
            //            [self getBillsFromLocal];
            HUD.labelText= @"Uploading Bills....";
            [HUD show:YES];
            [HUD setHidden:NO];
            
            // [self getBillsFromLocal];
            // [self performSelectorInBackground:@selector(getBillsFromLocal) withObject:nil];
            
            [HUD showWhileExecuting:@selector(getBillsFromLocal) onTarget:self withObject:nil animated:YES];
            
        }
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
        
    }
    @finally {
        {
            
            //added by Srinivasulu on 20/05/2017....
            
            @try {
                //                int count = [self getLocalBillCount];
                //
                //                refreshBtn.badgeValue = [NSString stringWithFormat:@"%d",count];
                //
                //                for(UIView * view in self.navigationController.navigationBar.subviews){
                //
                //                    if(view.tag == 2){
                //
                //                        for(UIView * view1 in view.subviews){
                //
                //                            if(view1.frame.origin.x == refreshBtn.frame.origin.x){
                //
                //                                UIButton * btn = (UIButton *)view1;
                //
                //                                btn.badgeValue = [NSString stringWithFormat:@"%d",count];
                //
                //                                break;
                //
                //                            }
                //
                //                        }
                //                        break;
                //
                //                    }
                //
                //                }
            } @catch (NSException *exception) {
                
            }
            
            //upto here on 20/05/2017....
            
            sqlite3_close(database);
            
        }
    }
    
    
}
-(void)getLocalErrorBills {
    
    
    NSMutableArray *bill_ids = [[NSMutableArray alloc] init];
    
    @try {
        
        NSString* dbPath = [DataBaseConnection connection:@"RetailerBillingDataBase.sqlite"];
        
        if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
            NSString *query;
            
            query = [NSString stringWithFormat:@"select * from billing_table where save_status='Error' COLLATE NOCASE"];
            const char *sqlStatement = query.UTF8String;
            
            
            if(sqlite3_prepare_v2(database, sqlStatement, -1, &selectStmt, NULL) == SQLITE_OK) {
                //                        int count = sqlite3_column_count(selectStmt);
                while (sqlite3_step(selectStmt) == SQLITE_ROW) {
                    
                    NSString   *billId = @((char *)sqlite3_column_text(selectStmt,0));
                    
                    [bill_ids addObject:billId];
                    
                }
                sqlite3_finalize(selectStmt);
                selectStmt = nil;
                
                
            }
            else {
                NSLog(@"%s",sqlite3_errmsg(database)) ;
            }
            
            
        }
        if (bill_ids.count>0) {
            //            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:[NSString stringWithFormat:@"Following Bill Id(s) cannot be uploaded to the server\n%@",[bill_ids componentsJoinedByString:@" "]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            //            [alert show];
        }
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
        
    }
    @finally {
        sqlite3_close(database);
        syncStatus = FALSE;
        
    }
    
    
}
-(void)getBillsFromLocal {
    
    NSMutableArray *bill_ids = [[NSMutableArray alloc]init];
    
    //commented by Srinivaslulu on 29/08/2017...
    //reason not in use....
    
    //    NSMutableDictionary *details = [[NSMutableDictionary alloc] init];
    
    //upto here on 29/08/2018....
    
    BOOL isBillSaved = false;
    NSString* currentdate = [WebServiceUtility getCurrentDate];
    
    //    loadingMsgLbl.text = @"Uploading Bills....";
    //    [loadingView setHidden:YES];
    NSString *save_status;
    
    @try {
        
        NSString* dbPath = [DataBaseConnection connection:@"RetailerBillingDataBase.sqlite"];
        
        if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
            
            //        NSString *query = [NSString stringWithFormat:@"select * from sku_master where sku_id LIKE '%% %@ %%'",selected_SKID];
            
            
            //changed by Srinivaslulu on 29/08/2017....
            //reason error status are also has to be uploaded....
            
            //            NSString * query = [NSString stringWithFormat:@"select bill_id from billing_table where save_status!='%@' and save_status!='Error'",SUCCESS];
            
            NSString * query = [NSString stringWithFormat:@"select bill_id from billing_table where save_status!='%@'",SUCCESS];
            
            //upto here on 29/08/2017....
            
            
            
            //            NSString *query = [NSString stringWithFormat:@"select bill_id from billing_table where save_status!='%@' and save_status!='Error'",SUCCESS];
            
            
            // NSString *query = [NSString stringWithFormat:@"select bill_id from billing_table where bill_id like 'BL170403%%'"];
            
            
            const char *sqlStatement = query.UTF8String;
            
            
            if(sqlite3_prepare_v2(database, sqlStatement, -1, &selectStmt, NULL) == SQLITE_OK) {
                //                        int count = sqlite3_column_count(selectStmt);
                while (sqlite3_step(selectStmt) == SQLITE_ROW) {
                    
                    // NSString  *skuId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStmt, 0)];
                    NSString  *bill_id = @((char *)sqlite3_column_text(selectStmt, 0));
                    [bill_ids addObject:bill_id];
                    
                }
                sqlite3_finalize(selectStmt);
                selectStmt = nil;
            }
            else {
                NSLog(@"%s",sqlite3_errmsg(database)) ;
            }
            sqlite3_close(database);
        }
        
        if (bill_ids.count!=0) {
            
            for (int i=0; i<bill_ids.count; i++) {
                
                NSString  *bill_id;
                NSString  *date;
                NSString  *cashier_id;
                NSString  *counter_id;
                NSString  *Total_discount;
                NSString  *discount_type;
                NSString  *discount_type_id;
                NSString  *tax;
                NSString  *total_price;
                NSString  *due_amount;
                NSString  *status ;
                NSString  *email_id;
                NSString  *phone_number;
                NSString  *store_location;
                NSString  *customer_name;
                NSString *shift_id;
                NSString  *print_count;
                NSString *other_disc;
                NSString *bussiness_date;
                NSString *scan_start_date;
                NSString *scan_end_date;
                NSString *print_date;
                NSNumber *bill_duration_time;
                NSNumber *bill_duration_accept_print;
                NSString *serialBillId = @"";
                
                //added by Srinivasulu on 12/07/2017....
                
                
                NSString * otherDiscDescriptionStr = @"";
                NSString * registerStr;
                NSString * employeeSaleIdStr;
                NSString * cashierNameStr = @"";
                NSString * subTotalStr = @"";
                NSString * lastUpdateDateStr;
                NSString * customerGstinStr;
                
                //added by Srinivasulu on 03/08/2017 && 24/03/2018 && 28/06/2018....
                
                NSString * billAmountStr = @"";
                NSString * billCancelReasonStr = @"";
                NSString * billRemarksStr = @"";
                
                NSString * saleOrderIdStr = @"";
                NSString * shipmentChargesStr = @"";
                
                //upto here on 03/08/2017 && 24/03/2018 && 28/06/2018....
                
                //                if(([[JSON allKeys] containsObject:BILL_AMOUNT]) && (![[JSON valueForKey:BILL_AMOUNT] isKindOfClass:[NSNull class]]))
                //                sqlite3_bind_text(insertStmt, 35, [[JSON valueForKey:@""] UTF8String], -1, SQLITE_TRANSIENT);
                //                else
                //                    sqlite3_bind_text(insertStmt, 35, [[JSON valueForKey:TOTAL_BILL_AMT] UTF8String], -1, SQLITE_TRANSIENT);
                
                
                //upto here on 12/07/2017....
                
                if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
                    
                    
                    NSString *query = [NSString stringWithFormat:@"select * from billing_table where bill_id='%@'",bill_ids[i]];
                    
                    const char *sqlStatement = query.UTF8String;
                    
                    
                    if(sqlite3_prepare_v2(database, sqlStatement, -1, &selectStmt, NULL) == SQLITE_OK) {
                        //                        int count = sqlite3_column_count(selectStmt);
                        while (sqlite3_step(selectStmt) == SQLITE_ROW) {
                            
                            
                            bill_id = @((char *)sqlite3_column_text(selectStmt, 0));
                            date = @((char *)sqlite3_column_text(selectStmt, 1));
                            cashier_id = @((char *)sqlite3_column_text(selectStmt, 2));
                            counter_id = @((char *)sqlite3_column_text(selectStmt, 3));
                            Total_discount = @((char *)sqlite3_column_text(selectStmt, 4));
                            discount_type = @((char *)sqlite3_column_text(selectStmt, 5));
                            discount_type_id = @((char *)sqlite3_column_text(selectStmt,6));
                            tax = @((char *)sqlite3_column_text(selectStmt, 7));
                            total_price = @((char *)sqlite3_column_text(selectStmt, 8));
                            
                            
                            
                            due_amount = @((char *)sqlite3_column_text(selectStmt, 9));
                            status = @((char *)sqlite3_column_text(selectStmt, 10));
                            email_id = @((char *)sqlite3_column_text(selectStmt, 11));
                            phone_number = @((char *)sqlite3_column_text(selectStmt, 12));
                            store_location = @((char *)sqlite3_column_text(selectStmt, 13));
                            customer_name = @((char *)sqlite3_column_text(selectStmt, 14));
                            shift_id = @((char *)sqlite3_column_text(selectStmt, 15));
                            
                            save_status = @((char *)sqlite3_column_text(selectStmt,16));
                            print_count = @((char *)sqlite3_column_text(selectStmt, 17));
                            other_disc = @((char *)sqlite3_column_text(selectStmt, 19));
                            bussiness_date = @((char *)sqlite3_column_text(selectStmt, 20));
                            scan_start_date = [WebServiceUtility getCurrentDate];
                            if (sqlite3_column_text(selectStmt, 21) != nil) {
                                scan_start_date = @((char *)sqlite3_column_text(selectStmt, 21));
                            }
                            scan_end_date = [WebServiceUtility getCurrentDate];
                            if (sqlite3_column_text(selectStmt, 22) != nil) {
                                scan_end_date = @((char *)sqlite3_column_text(selectStmt, 22));
                            }
                            print_date = [WebServiceUtility getCurrentDate];
                            if (sqlite3_column_text(selectStmt, 23) != nil) {
                                print_date = @((char *)sqlite3_column_text(selectStmt, 23));
                            }
                            bill_duration_time = @(sqlite3_column_int(selectStmt, 24));
                            bill_duration_accept_print = @(sqlite3_column_int(selectStmt, 25));
                            
                            if (sqlite3_column_text(selectStmt, 26) != nil) {
                                serialBillId = @((char *)sqlite3_column_text(selectStmt, 26));
                            }
                            
                            //added by Srinivasulu on 12/07/2017 && 03/08/2017 && 08/09/2017 && 24/03/2018 && 28/06/2018....
                            
                            if( (char *)sqlite3_column_text(selectStmt,27) &&  (sqlite3_column_text(selectStmt, 27) != nil))
                                otherDiscDescriptionStr = @((char *)sqlite3_column_text(selectStmt, 27));
                            
                            if( (char *)sqlite3_column_text(selectStmt,28) &&  (sqlite3_column_text(selectStmt, 28) != nil))
                                registerStr = @((char *)sqlite3_column_text(selectStmt, 28));
                            
                            if( (char *)sqlite3_column_text(selectStmt,29) &&  (sqlite3_column_text(selectStmt, 29) != nil))
                                employeeSaleIdStr = @((char *)sqlite3_column_text(selectStmt, 29));
                            
                            if( (char *)sqlite3_column_text(selectStmt,30) &&  (sqlite3_column_text(selectStmt, 30) != nil))
                                cashierNameStr = @((char *)sqlite3_column_text(selectStmt, 30));
                            
                            if( (char *)sqlite3_column_text(selectStmt,31) &&  (sqlite3_column_text(selectStmt, 31) != nil))
                                subTotalStr = @((char *)sqlite3_column_text(selectStmt, 31));
                            
                            if( (char *)sqlite3_column_text(selectStmt,32) &&  (sqlite3_column_text(selectStmt, 32) != nil))
                                lastUpdateDateStr = @((char *)sqlite3_column_text(selectStmt, 32));
                            
                            if( (char *)sqlite3_column_text(selectStmt,33) &&  (sqlite3_column_text(selectStmt, 33) != nil))
                                customerGstinStr = @((char *)sqlite3_column_text(selectStmt, 33));
                            
                            
                            if( (char *)sqlite3_column_text(selectStmt,34) &&  (sqlite3_column_text(selectStmt, 34) != nil))
                                billAmountStr = @((char *)sqlite3_column_text(selectStmt, 34));
                            else
                                billAmountStr = @((char *)sqlite3_column_text(selectStmt, 8));
                            
                            
                            if( (char *)sqlite3_column_text(selectStmt,35) &&  (sqlite3_column_text(selectStmt, 35) != nil))
                                billCancelReasonStr = @((char *)sqlite3_column_text(selectStmt, 35));
                            
                            if( (char *)sqlite3_column_text(selectStmt,36) &&  (sqlite3_column_text(selectStmt, 36) != nil))
                                billRemarksStr = @((char *)sqlite3_column_text(selectStmt, 36));
                            
                            if( (char *)sqlite3_column_text(selectStmt,37) &&  (sqlite3_column_text(selectStmt, 37) != nil))
                                saleOrderIdStr = @((char *)sqlite3_column_text(selectStmt, 37));
                            
                            if( (char *)sqlite3_column_text(selectStmt,38) &&  (sqlite3_column_text(selectStmt, 38) != nil))
                                shipmentChargesStr = @((char *)sqlite3_column_text(selectStmt, 38));
                            
                            //upto here on 03/08/2017 && 12/07/2017 && 08/09/2017 && 24/03/2018 && 28/06/2018....
                        }
                        sqlite3_finalize(selectStmt);
                        //                            selectStmt = nil;
                    }
                    else {
                        NSLog(@"%s",sqlite3_errmsg(database)) ;
                        return;
                    }
                    billSaveStatus = [save_status copy];
                    NSString *item_query = [NSString stringWithFormat:@"select * from billing_items where bill_id='%@'",bill_ids[i]];
                    
                    const char *sqlStatement1 = item_query.UTF8String;
                    
                    //changed by Srinivasulu on 12/07/2017....
                    
                    
                    //                    NSArray *totalBillItems = [[NSArray alloc] init];
                    NSMutableArray *totalBillItems = [[NSMutableArray alloc] init];
                    
                    //upto here on 12/07/2017....
                    
                    if(sqlite3_prepare_v2(database, sqlStatement1, -1, &selectStmt, NULL) == SQLITE_OK) {
                        itemsArr = [[NSMutableArray alloc]init];
                        NSMutableArray *itemDiscountArr = [NSMutableArray new];
                        NSMutableArray *itemDiscountDescArr = [NSMutableArray new];
                        NSMutableArray *itemScanCodeArr = [NSMutableArray new];
                        NSMutableArray *discountPriceArr = [NSMutableArray new];
                        NSMutableArray *manufacturedItemsArr = [NSMutableArray new];
                        NSMutableArray *packagedItemsArr = [NSMutableArray new];
                        NSMutableArray *productInfoArr = [NSMutableArray new];
                        
                        //added by Srinivasulu on 18/08/2017....
                        
                        NSMutableArray * itemUnitPriceArr = [NSMutableArray new];
                        NSMutableArray * itemsTotalCostArr = [NSMutableArray new];
                        
                        //upto here on 18/08/2017....
                        
                        while (sqlite3_step(selectStmt) == SQLITE_ROW) {
                            
                            NSString  *sku_id = @((char *)sqlite3_column_text(selectStmt, 2));
                            NSString  *item = @((char *)sqlite3_column_text(selectStmt, 3));
                            NSString  *quantity = @((char *)sqlite3_column_text(selectStmt, 4));
                            NSString  *total_price = @((char *)sqlite3_column_text(selectStmt, 5));
                            NSString  *tax_code = @((char *)sqlite3_column_text(selectStmt, 6));
                            NSString  *tax_value = @((char *)sqlite3_column_text(selectStmt,7));
                            NSString  *status = @((char *)sqlite3_column_text(selectStmt, 8));
                            NSString  *pluCode = @((char *)sqlite3_column_text(selectStmt, 9));
                            NSString  *editedPrice = @((char *)sqlite3_column_text(selectStmt, 10));
                            NSString  *mrpPrice = @((char *)sqlite3_column_text(selectStmt, 14));
                            NSString  *itemDiscount = @((char *)sqlite3_column_text(selectStmt, 15));
                            NSString  *itemDiscountDesc = @((char *)sqlite3_column_text(selectStmt, 16));
                            NSString *itemScanCode = @((char *)sqlite3_column_text(selectStmt, 17));
                            NSString *discountPrice = @((char *)sqlite3_column_text(selectStmt, 13));
                            NSString *itemFlag = @"N";
                            
                            if (sqlite3_column_text(selectStmt, 18) != nil) {
                                itemFlag = @((char *)sqlite3_column_text(selectStmt, 18));
                            }
                            
                            int isManufacturedItem = sqlite3_column_int(selectStmt, 19);
                            
                            int isPackedItem = sqlite3_column_int(selectStmt, 20);
                            
                            NSString  *category = @"";
                            if (sqlite3_column_text(selectStmt, 21) != nil) {
                                category = @((char *)sqlite3_column_text(selectStmt, 21));
                            }
                            
                            NSString  *subCategory = @"";
                            if (sqlite3_column_text(selectStmt, 22) != nil) {
                                subCategory = @((char *)sqlite3_column_text(selectStmt, 22));
                            }
                            
                            NSString  *productRange = @"";
                            if (sqlite3_column_text(selectStmt, 23) != nil) {
                                productRange = @((char *)sqlite3_column_text(selectStmt, 23));
                            }
                            
                            NSString  *measureRange = @"";
                            if (sqlite3_column_text(selectStmt, 24) != nil) {
                                measureRange = @((char *)sqlite3_column_text(selectStmt, 24));
                            }
                            
                            NSString  *brand = @"";
                            if (sqlite3_column_text(selectStmt, 25) != nil) {
                                brand = @((char *)sqlite3_column_text(selectStmt, 25));
                            }
                            NSString  *model = @"";
                            if (sqlite3_column_text(selectStmt, 26) != nil) {
                                model = @((char *)sqlite3_column_text(selectStmt, 26));
                            }
                            
                            
                            //added by Srinivasulu on 18/08/2017....
                            
                            [itemsTotalCostArr addObject:total_price];
                            
                            if (sqlite3_column_text(selectStmt, 27) != nil) {
                                
                                [itemUnitPriceArr addObject:@((char *)sqlite3_column_text(selectStmt, 27))];
                            }
                            else{
                                
                                [itemUnitPriceArr addObject:@"0.0"];
                            }
                            //upto here on 18/08/2017....
                            
                            //added by Srinivaslulu on 12/07/2017....
                            //no need store && retrive the itemUnitPrice.... because in webUtilites we are calculating it....
                            
                            NSString  * itemScanFlagStr = @"";//29 -- 28
                            
                            NSString  * employeSaldIdStr = @"";//30 -- 39
                            
                            NSString  * departmentStr = @"";//31 -- 30
                            NSString  * subDepartmentStr = @"";//32 -- 31
                            
                            NSString  * employeeNameStr = @"";//33 -- 32
                            
                            NSString  * taxCostStr = @"";//34 -- 33 // notRequired
                            
                            NSString  * styleStr = @"";//35 -- 34
                            NSString  * patternStr = @"";//36 -- 35
                            NSString  * batchStr = @"";//37 -- 36
                            NSString  * colorStr = @"";//38 -- 37
                            NSString  * sizeStr = @"";//39 -- 38
                            NSString  * sectionStr = @"";//40 -- 39
                            NSString  * hsnCodeStr = @"";//41 -- 40
                            NSString  * utilityStr = @"";//42  -- 41
                            NSString  * isTaxInclusiveStr = @"0";//43  -- 42
                            
                            //added by Srinivasulu on 12/08/2017....
                            
                            NSString  * productClassStr = @"";//44  -- 43
                            NSString  * productSubClassStr = @"";//45  -- 44
                            NSString  * styleRangeStr = @"";//46  -- 45
                            
                            
                            //added by Srinivasulu on 21/08/2017 && 08/09/2017 && 29/08/2018....
                            
                            NSString  * editPriceReasonStr = @"";//47  -- 46
                            NSString  * voidItemReasonStr = @"";//47  -- 48
                            NSString  * expiryDateStr = @"";//48  -- 49
                            NSString  * packSizeStr = @"1";//49  -- 50
                            
                            if (sqlite3_column_text(selectStmt, 46) != nil) {
                                editPriceReasonStr = @((char *)sqlite3_column_text(selectStmt, 46));
                            }
                            
                            if (sqlite3_column_text(selectStmt, 47) != nil) {
                                voidItemReasonStr = @((char *)sqlite3_column_text(selectStmt, 47));
                            }
                            
                            if (sqlite3_column_text(selectStmt, 48) != nil) {
                                expiryDateStr = @((char *)sqlite3_column_text(selectStmt, 48));
                            }
                            if (sqlite3_column_text(selectStmt, 49) != nil) {
                                packSizeStr = @((char *)sqlite3_column_text(selectStmt, 49));
                            }
                            
                            //upto here on 12/08/2017 && 08/09/2017 && 29/08/2018....
                            
                            if (sqlite3_column_text(selectStmt, 28) != nil) {
                                itemScanFlagStr = @((char *)sqlite3_column_text(selectStmt, 28));
                            }
                            
                            if (sqlite3_column_text(selectStmt, 29) != nil) {
                                employeSaldIdStr = @((char *)sqlite3_column_text(selectStmt, 29));
                            }
                            
                            if (sqlite3_column_text(selectStmt, 30) != nil) {
                                departmentStr = @((char *)sqlite3_column_text(selectStmt, 30));
                            }
                            
                            if (sqlite3_column_text(selectStmt, 31) != nil) {
                                subDepartmentStr = @((char *)sqlite3_column_text(selectStmt, 31));
                            }
                            
                            if (sqlite3_column_text(selectStmt, 32) != nil) {
                                employeeNameStr = @((char *)sqlite3_column_text(selectStmt, 32));
                            }
                            
                            if (sqlite3_column_text(selectStmt, 33) != nil) {
                                taxCostStr = @((char *)sqlite3_column_text(selectStmt, 33));
                            }
                            
                            if (sqlite3_column_text(selectStmt, 34) != nil) {
                                styleStr = @((char *)sqlite3_column_text(selectStmt, 34));
                            }
                            
                            if (sqlite3_column_text(selectStmt, 35) != nil) {
                                patternStr = @((char *)sqlite3_column_text(selectStmt, 35));
                            }
                            
                            if (sqlite3_column_text(selectStmt, 36) != nil) {
                                batchStr = @((char *)sqlite3_column_text(selectStmt, 36));
                            }
                            
                            if (sqlite3_column_text(selectStmt, 37) != nil) {
                                colorStr = @((char *)sqlite3_column_text(selectStmt, 37));
                            }
                            
                            if (sqlite3_column_text(selectStmt, 38) != nil) {
                                sizeStr = @((char *)sqlite3_column_text(selectStmt, 38));
                            }
                            
                            if (sqlite3_column_text(selectStmt, 39) != nil) {
                                sectionStr = @((char *)sqlite3_column_text(selectStmt, 39));
                            }
                            
                            if (sqlite3_column_text(selectStmt, 40) != nil) {
                                hsnCodeStr = @((char *)sqlite3_column_text(selectStmt, 40));
                            }
                            
                            if (sqlite3_column_text(selectStmt, 41) != nil) {
                                utilityStr = @((char *)sqlite3_column_text(selectStmt, 41));
                            }
                            
                            if (sqlite3_column_text(selectStmt, 42) != nil) {
                                isTaxInclusiveStr = @((char *)sqlite3_column_text(selectStmt, 42));
                            }
                            
                            if (sqlite3_column_text(selectStmt, 43) != nil) {
                                productClassStr = @((char *)sqlite3_column_text(selectStmt, 43));
                            }
                            
                            if (sqlite3_column_text(selectStmt, 44) != nil) {
                                productSubClassStr = @((char *)sqlite3_column_text(selectStmt, 44));
                            }
                            
                            
                            if (sqlite3_column_text(selectStmt, 45) != nil) {
                                styleRangeStr = @((char *)sqlite3_column_text(selectStmt, 45));
                            }
                            
                            //upto here on 12/07/2017....
                            
                            NSDictionary *productInfoDic = @{kProductCategory: category,kProductSubCategory: subCategory,kProductRange: productRange,kMeasureRange: measureRange,kProductBrand: brand,kProductModel: model};
                            
                            NSString *temp = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@",sku_id,@"#",item,@"#",quantity,@"#",total_price,@"#",tax_code,@"#",tax_value,@"#",status,@"#",pluCode,@"#",editedPrice,@"#",mrpPrice,@"#",itemFlag];
                            
                            //added by Srinivasulu on 12/04/2017 && 12/08/2017 && 21/08/2017 && 08/09/2017 && 29/08/2018....
                            
                            NSMutableDictionary * productInfoMutDic = [productInfoDic mutableCopy];
                            
                            productInfoMutDic[kItemDept] = departmentStr;
                            productInfoMutDic[kItemSubDept] = subDepartmentStr;
                            
                            productInfoMutDic[STYLE] = styleStr;
                            productInfoMutDic[PATTERN] = patternStr;
                            productInfoMutDic[BATCH] = batchStr;
                            productInfoMutDic[COLOR] = colorStr;
                            productInfoMutDic[SIZE] = sizeStr;
                            productInfoMutDic[SECTION] = sectionStr;
                            productInfoMutDic[HSN_CODE] = hsnCodeStr;
                            productInfoMutDic[UTILITY] = utilityStr;
                            
                            productInfoMutDic[PRODUCT_CLASS] = productClassStr;
                            productInfoMutDic[PRODUCT_SUB_CLASS] = productSubClassStr;
                            productInfoMutDic[STYLE_RANGE] = styleRangeStr;
                            
                            if(isTaxInclusiveStr.integerValue)
                                productInfoMutDic[TAX_INCLUSIVE] = @YES;
                            
                            else
                                productInfoMutDic[TAX_INCLUSIVE] = @NO;
                            
                            productInfoMutDic[EDIT_PRICE_REASON] = editPriceReasonStr;
                            
                            productInfoMutDic[VOID_ITEM_REASON] = voidItemReasonStr;
                            
                            productInfoMutDic[EXPIRY_DATE] = expiryDateStr;
                            productInfoMutDic[Pack_Size] = packSizeStr;
                            
                            //                            [productInfoArr addObject:productInfoDic];
                            [productInfoArr addObject:productInfoMutDic];
                            
                            //upto here on 12/04/2017 && 12/08/2017 && 21/08/2017 && 08/09/2017 && 29/08/2018....
                            
                            [itemDiscountArr addObject:itemDiscount];
                            [itemDiscountDescArr addObject:itemDiscountDesc];
                            [itemScanCodeArr addObject:itemScanCode];
                            [discountPriceArr addObject:discountPrice];
                            [manufacturedItemsArr addObject:[NSNumber numberWithBool:isManufacturedItem]];
                            [packagedItemsArr addObject:[NSNumber numberWithBool:isPackedItem]];
                            
                            
                            
                            [itemsArr addObject:temp];
                            
                        }
                        sqlite3_finalize(selectStmt);
                        selectStmt = nil;
                        NSString *str = @"";
                        
                        for (int i = 0; i < itemsArr.count; i++) {
                            
                            NSArray *temp = [itemsArr[i] componentsSeparatedByString:@"#"];
                            str  = [NSString stringWithFormat:@"%@%@%@", str, temp[0],@"#"];
                            str  = [NSString stringWithFormat:@"%@%@%@", str, temp[1],@"#"];
                            
                            str  = [NSString stringWithFormat:@"%@%@%@", str, temp[3],@"#"];
                            str  = [NSString stringWithFormat:@"%@%@%@", str, temp[2],@"#"];
                            str  = [NSString stringWithFormat:@"%@%@%@", str, temp[1],@"#"];
                            str = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@", str, temp[4], @"#",temp[5] , @"#", temp[6], @"#", temp[7],@"#",temp[8],@"#", temp[9],@"#",temp[10],@"#@"];
                        }
                        
                        totalBillItems = [[WebServiceUtility getBillingItemsFrom:str itemDiscountArr:itemDiscountArr itemDiscountDescArr:itemDiscountDescArr offerPriceArray:nil dealPriceArray:nil itemScanCode:itemScanCodeArr turnOverOffer:0 totalPriceBeforeTurnOver:0 salesPersonInfo:nil manufacturedItems:manufacturedItemsArr packagedItemsArr:packagedItemsArr productInfoArr:productInfoArr otherDiscountValue:@"0.00"] mutableCopy];
                        
                        for (int i = 0; i < totalBillItems.count; i++) {
                            NSMutableDictionary *itemDict = totalBillItems[i];
                            [itemDict setValue:@([discountPriceArr[i] floatValue]) forKey:DISCOUNT_PRICE_3];
                            
                            //added by Srinivasulu on 18/08/2017....
                            
                            if(discountPriceArr.count > i)
                                [itemDict setValue:@([discountPriceArr[i] floatValue]) forKey:@"discountPrice"];
                            
                            if(itemUnitPriceArr.count > i)
                                [itemDict setValue:[NSString stringWithFormat:@"%.2f",[itemUnitPriceArr[i] floatValue] ] forKey:@"itemUnitPrice"];
                            
                            if(itemsTotalCostArr.count > i)
                                [itemDict setValue:[NSString stringWithFormat:@"%.2f",[itemsTotalCostArr[i] floatValue] ] forKey:@"item_total_price"];
                            
                            totalBillItems[i] = itemDict;
                            
                            //upto here on on 18/08/2017....
                        }
                    }
                    else {
                        NSLog(@"%s",sqlite3_errmsg(database)) ;
                        return;
                    }
                    
                    NSString *tax_query = [NSString stringWithFormat:@"select * from billing_taxes where bill_id='%@'",bill_ids[i]];
                    
                    const char *sqlTaxStatement1 = tax_query.UTF8String;
                    
                    NSMutableArray *totalTaxDetails = [[NSMutableArray alloc] init];
                    if(sqlite3_prepare_v2(database, sqlTaxStatement1, -1, &selectStmt, NULL) == SQLITE_OK) {
                        NSMutableDictionary *taxDic = [[NSMutableDictionary alloc]init];
                        
                        
                        while (sqlite3_step(selectStmt) == SQLITE_ROW) {
                            
                            NSString  *tax_name = @"";
                            
                            if (sqlite3_column_text(selectStmt, 2) != nil) {
                                
                                tax_name = @((char *)sqlite3_column_text(selectStmt, 2));
                                
                            }
                            NSString  *tax_price = @"";
                            
                            if (sqlite3_column_text(selectStmt, 3) != nil) {
                                
                                tax_price = @((char *)sqlite3_column_text(selectStmt, 3));
                                
                            }
                            
                            NSString  *bill_date = [WebServiceUtility getCurrentDate];
                            
                            if (sqlite3_column_text(selectStmt, 4) != nil) {
                                
                                bill_date = @((char *)sqlite3_column_text(selectStmt, 4));
                                
                            }
                            
                            [taxDic setValue:tax_name forKey:TAX_NAME];
                            [taxDic setValue:tax_price forKey:TAX_AMOUNT];
                            [taxDic setValue:bill_date forKey:@"bill_date"];
                            [totalTaxDetails addObject:taxDic];
                            
                        }
                        sqlite3_finalize(selectStmt);
                        selectStmt = nil;
                        NSString *str = @"";
                        
                    }
                    else {
                        NSLog(@"%s",sqlite3_errmsg(database)) ;
                        return;
                    }
                    
                    NSString *tax_item_query = [NSString stringWithFormat:@"select * from billing_item_taxes where bill_id='%@'",bill_ids[i]];
                    
                    const char *sqlTaxStatement7 = tax_item_query.UTF8String;
                    
                    NSMutableArray *itemTaxDetails = [[NSMutableArray alloc] init];
                    if(sqlite3_prepare_v2(database, sqlTaxStatement7, -1, &selectStmt, NULL) == SQLITE_OK) {
                        
                        
                        while (sqlite3_step(selectStmt) == SQLITE_ROW) {
                            
                            //                            const char *sqlStatement = "create table if not exists billing_item_taxes (bill_id text, sku_id text, plu_code text,tax_category double,tax_code text,tax_type text,tax_rate text, text)";
                            
                            NSString  *sku_id = @"";
                            if (sqlite3_column_text(selectStmt, 1) != nil) {
                                sku_id = @((char *)sqlite3_column_text(selectStmt, 1));
                            }
                            
                            NSString  *plu_code = @"";
                            if (sqlite3_column_text(selectStmt, 2) != nil) {
                                plu_code = @((char *)sqlite3_column_text(selectStmt, 2));
                            }
                            
                            
                            NSString  *tax_category = @"";
                            if (sqlite3_column_text(selectStmt, 3) != nil) {
                                tax_category = @((char *)sqlite3_column_text(selectStmt, 3));
                            }
                            NSString  *tax_code = @"";
                            if (sqlite3_column_text(selectStmt, 4) != nil) {
                                tax_code = @((char *)sqlite3_column_text(selectStmt, 4));
                            }
                            NSString  *tax_type = @"";
                            if (sqlite3_column_text(selectStmt, 5) != nil) {
                                tax_type = @((char *)sqlite3_column_text(selectStmt, 5));
                            }
                            NSString  *tax_rate = @"";
                            if (sqlite3_column_text(selectStmt, 6) != nil) {
                                tax_rate = @((char *)sqlite3_column_text(selectStmt, 6));
                            }
                            NSString  *tax_value = @"";
                            if (sqlite3_column_text(selectStmt, 7) != nil) {
                                tax_value = @((char *)sqlite3_column_text(selectStmt, 7));
                            }
                            NSMutableDictionary *taxDic = [[NSMutableDictionary alloc]init];
                            
                            [taxDic setValue:sku_id forKey:@"sku_id"];
                            [taxDic setValue:plu_code forKey:@"plu_code"];
                            [taxDic setValue:tax_category forKey:@"tax_category"];
                            [taxDic setValue:tax_code forKey:@"tax_code"];
                            [taxDic setValue:tax_type forKey:@"tax_type"];
                            [taxDic setValue:tax_rate forKey:@"tax_rate"];
                            [taxDic setValue:tax_value forKey:@"tax_value"];
                            [itemTaxDetails addObject:taxDic];
                            
                        }
                        sqlite3_finalize(selectStmt);
                        selectStmt = nil;
                        //                        NSString *str = @"";
                    }
                    else {
                        NSLog(@"%s",sqlite3_errmsg(database)) ;
                        return;
                    }
                    
                    NSString *itransaction_query = [NSString stringWithFormat:@"select * from billing_transactions where bill_id='%@'",bill_ids[i]];
                    
                    const char *sqlStatement2 = itransaction_query.UTF8String;
                    
                    
                    if(sqlite3_prepare_v2(database, sqlStatement2, -1, &selectStmt, NULL) == SQLITE_OK) {
                        
                        transactionArr = [[NSMutableArray alloc]init];
                        
                        while (sqlite3_step(selectStmt) == SQLITE_ROW) {
                            
                            NSString  *mode_of_payment = @"";
                            if (sqlite3_column_text(selectStmt, 1) != nil) {
                                mode_of_payment = @((char *)sqlite3_column_text(selectStmt, 1));
                                
                            }
                            NSString  *transaction_id = @"";
                            if (sqlite3_column_text(selectStmt, 2) != nil) {
                                transaction_id = @((char *)sqlite3_column_text(selectStmt, 2));
                            }
                            NSString  *card_type = @"";
                            if (sqlite3_column_text(selectStmt, 3) != nil) {
                                card_type = @((char *)sqlite3_column_text(selectStmt, 3));
                            }
                            //                                NSString  *card_subtype = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStmt, 4)];
                            
                            NSString  *card_no = @"";
                            if (sqlite3_column_text(selectStmt, 5) != nil) {
                                card_no = @((char *)sqlite3_column_text(selectStmt, 5));
                            }
                            NSString  *paid_amt = @"";
                            if (sqlite3_column_text(selectStmt, 6) != nil) {
                                paid_amt = @((char *)sqlite3_column_text(selectStmt, 6));
                            }
                            NSString  *date = @"";
                            if (sqlite3_column_text(selectStmt, 7) != nil) {
                                date = @((char *)sqlite3_column_text(selectStmt, 7));
                            }
                            //NSString  *date = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStmt, 7)];
                            NSString  *bankInfo = @((char *)sqlite3_column_text(selectStmt, 8));
                            NSString  *appCode = @((char *)sqlite3_column_text(selectStmt, 9));
                            NSString  *bankname = @((char *)sqlite3_column_text(selectStmt, 10));
                            NSString  *changeReturn = @((char *)sqlite3_column_text(selectStmt, 11));
                            NSString  *receivedAmt = @((char *)sqlite3_column_text(selectStmt, 12));
                            
                            //added by Srinivasulu on 27/11/2017....
                            
                            NSString  * transactionModeStr  = @"";
                            NSString  * transactionsKey = @"0";
                            
                            if ((sqlite3_column_text(selectStmt, 13) != nil)  && ((char *)sqlite3_column_text(selectStmt,13))){
                                
                                transactionModeStr  = @((char *)sqlite3_column_text(selectStmt, 13));
                            }
                            if ((sqlite3_column_text(selectStmt, 14) != nil)  && ((char *)sqlite3_column_text(selectStmt,14))){
                                
                                transactionsKey  = @((char *)sqlite3_column_text(selectStmt, 14));
                            }
                            
                            //added by Srinivasulu on 31/03/2018....
                            
                            NSString  * transActionTypeStr = @"0";
                            
                            if( (char *)sqlite3_column_text(selectStmt, 15)  && (sqlite3_column_text(selectStmt, 15) != nil) ){
                                
                                transActionTypeStr = @((char *)sqlite3_column_text(selectStmt, 15));
                            }
                            
                            //upto here on 31/03/2018....
                            
                            //upto here on 27/11/2017....
                            
                            NSMutableDictionary *transDic = [NSMutableDictionary new];
                            [transDic setValue:mode_of_payment forKey:MODE_OF_PAY];
                            [transDic setValue:card_type forKey:CARD_TYPE];
                            [transDic setValue:card_no forKey:COUPON_NO];
                            [transDic setValue:paid_amt forKey:PAID_AMT];
                            [transDic setValue:transaction_id forKey:TRANSACTION_ID];
                            
                            [transDic setValue:bankInfo forKey:CARD_INFO];
                            [transDic setValue:appCode forKey:APPROVAL_CODE];
                            [transDic setValue:bankname forKey:BANK_NAME];
                            
                            [transDic setValue:date forKey:@"dateTime"];
                            [transDic setValue:changeReturn forKey:CHANGE_RETURN];
                            [transDic setValue:receivedAmt forKey:RECEIVED_AMOUNT];
                            
                            //added by Srinivasulu on 27/11/2017 && 31/03/2018....
                            
                            [transDic setValue:transactionModeStr forKey:TENDER_MODE];
                            [transDic setValue:transactionsKey forKey:TENDER_KEY];
                            
                            
                            
                            if(transActionTypeStr.integerValue)
                                [transDic setValue:@YES forKey:TRANSACTION_TYPE_FLAG];
                            else
                                [transDic setValue:@NO forKey:TRANSACTION_TYPE_FLAG];
                            
                            
                            //upto here on 27/11/2017 && 31/03/2018....
                            
                            [transactionArr addObject:transDic];
                            
                        }
                        sqlite3_finalize(selectStmt);
                        selectStmt = nil;
                        
                        
                    }
                    else {
                        NSLog(@"%s",sqlite3_errmsg(database)) ;
                        return;
                    }
                    NSArray *denomination_req = [NSArray new];
                    for (int i = 0; i < transactionArr.count; i++) {
                        NSDictionary *dic = transactionArr[i];
                        denomination_req =[self getDenomination:bill_id transaction_id:[dic valueForKey:@"txID"]];
                        
                    }
                    
                    //added by Srinivasulu on 12/07/2017....
                    
                    
                    for(int i = 0; i < totalBillItems.count; i++){
                        
                        
                        NSMutableDictionary * itemDic = totalBillItems[i];
                        
                        //                NSString * itemTotalPrice = [itemDic valueForKey:@"item_total_price"];
                        
                        float itemTaxValue = 0.00;
                        
                        for( NSDictionary * itemLevelTaxDic in itemTaxDetails ){
                            
                            if(([[itemDic valueForKey:SKU_ID] isEqualToString:[itemLevelTaxDic valueForKey:SKU_ID]]) && ([[itemDic valueForKey:PLU_CODE] isEqualToString:[itemLevelTaxDic valueForKey:@"plu_code"]])){
                                
                                itemTaxValue += [[itemLevelTaxDic valueForKey:@"tax_value"] floatValue];
                            }
                            
                        }
                        
                        
                        [itemDic setValue:[NSString stringWithFormat:@"%.2f",itemTaxValue] forKey:@"taxCost"];
                        
                        totalBillItems[i] = itemDic;
                        
                    }
                    
                    //upto here on 12/07/2017....
                    
                    NSArray *itemCampaigns = [NSArray new];
                    OfflineBillingServices *offline = [OfflineBillingServices new];
                    itemCampaigns = [offline getItemsCampaignsInfo:bill_id];
                    
                    NSArray *keys = @[BILL_ID,REQUEST_HEADER,CASHIER_ID,COUNTER,TOTAL_BILL_DISCOUNT,DISCOUNT_TYPE,DISCOUNT_TYPE_ID,TAX,TOTAL_BILL_AMT,BILL_DUE,CUSTOMER_EMAIL,MOBILE_NO,STATUS,STORE_LOCATION,SHIFT_ID,BILL_ITEMS,BILLING_TRANSACTIONS,DENOMINATION,BILLING_DATE,CUSTOMER_NAME,PRINT_COUNT,OTHER_DISCOUNT,BUSSINESS_DATE,SCAN_START_TIME,SCAN_END_TIME,PRINT_TIME,BILL_TAXES,BILL_TIME_DURATION,BILL_TIME_DURATION_ACCEPT_PRINT,BILL_ITEM_TAXES,kItemCampigns,@"billingChannel",@"cashierName",@"subTotal",kCustomerBillId,kSerialBillId];
                    
                    NSArray *objects  = @[bill_id,[RequestHeader getRequestHeader],cashierId,counter_id,Total_discount,discount_type,discount_type_id,tax,total_price,due_amount, email_id,phone_number,status,presentLocation,[NSString stringWithFormat:@"%@",shiftId],totalBillItems,transactionArr,denomination_req,date,customer_name,print_count,other_disc,bussiness_date,scan_start_date,scan_end_date,print_date,totalTaxDetails,bill_duration_time,bill_duration_accept_print,itemTaxDetails,itemCampaigns,@"Direct",firstName,total_price,@(isCustomerBillId),serialBillId];
                    
                    
                    //changed by Srinivasulu  on 12/07/2017 && 03/08/2017 && 12/08/2017 && 08/09/2017 && 24/03/2018 && 28/06/2018....
                    
                    //                    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
                    NSMutableDictionary * dictionary = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
                    
                    dictionary[OTHER_DISCOUNT_DESC] = otherDiscDescriptionStr;
                    dictionary[CASHIER_NAME] = cashierNameStr;
                    
                    if(registerStr != nil)
                        dictionary[REGISTER] = registerStr;
                    
                    if(employeeSaleIdStr != nil)
                        dictionary[kEmployeeSaleId] = otherDiscDescriptionStr;
                    
                    if(subTotalStr != nil)
                        dictionary[@"subTotalStr"] = subTotalStr;
                    
                    if(lastUpdateDateStr != nil)
                        dictionary[@"lastUpdateDateStr"] = lastUpdateDateStr;
                    
                    if(customerGstinStr != nil)
                        dictionary[CUSTOMER_GSTIN] = customerGstinStr;
                    
                    
                    dictionary[IS_OFFLINE_BILL] = [NSNumber numberWithBool:true];
                    dictionary[OFFLINE_BILL] = [NSNumber numberWithBool:true];
                    dictionary[BILL_AMOUNT] = billAmountStr;
                    dictionary[BILL_CANCEL_REASON] = billCancelReasonStr;
                    dictionary[kComments] = billRemarksStr;
                    
                    
                    dictionary[SALES_ORDER_ID] = saleOrderIdStr;
                    dictionary[SHIPPING_CHARGES] = shipmentChargesStr;
                    //upto here on 12/07/2017 && 08/09/2017 && 12/08/2017  && 08/09/2017 && 24/03/2018 && 28/06/2018....
                    
                    /*
                     NSString * otherDiscDescriptionStr = @"";
                     NSString * registerStr;
                     NSString * employeeSaleIdStr;
                     NSString * cashierNameStr;
                     NSString * subTotalStr = @"";
                     NSString * lastUpdateDateStr;
                     NSString * customerGstinStr;*/
                    
                    //upto here on 1207/2017....
                    
                    NSError * err;
                    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
                    //                    NSString * createBillingJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                    
                    @try {
                        
                        NSString *serviceUrl = [WebServiceUtility getURLFor:CREATE_BILLING_WITH_BODY];
                        serviceUrl = [NSString stringWithFormat:@"%@",serviceUrl];
                        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
                        
                        NSURL *url = [NSURL URLWithString:serviceUrl];
                        NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                                             timeoutInterval:60.0];
                        request.HTTPMethod = @"POST";
                        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
                        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                        [request setValue:[NSString stringWithFormat:@"%lu", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
                        request.HTTPBody = jsonData;
                        
                        NSError *error = nil;
                        NSHTTPURLResponse *responseCode = nil;
                        
                        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
                        NSDictionary *billingResponse = [NSJSONSerialization JSONObjectWithData:data options:0
                                                                                          error:NULL];
                        
                        int responseCodeValue = 0;
                        
                        NSLog(@"BILL RESPONSE ---------- %@",billingResponse);
                        
                        if (data) {
                            
                            //changed by Srinivasulu on  11/08/2017 && on 02/02/2018....
                            if(!billingResponse.allKeys.count){
                                
                                isBillSaved = FALSE;
                            }
                            else if (([[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue] == 0)  || ([[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE] caseInsensitiveCompare:DUPLICATE_BILL_ID_RESOPNSE_FROM_SERVICES] == NSOrderedSame) || ([[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue] == -DUPLICATE_BILL_ID_RESOPNSE_CODE)) {
                                
                                //upto here on 11/08/2017 && on 02/02/2018....
                                
                                isBillSaved = TRUE;
                                
                            }
                            else {
                                
                                if([billingResponse.allKeys containsObject:RESPONSE_HEADER] && (![[billingResponse valueForKey:RESPONSE_HEADER] isKindOfClass:[NSNull class]]) )
                                    if([[[billingResponse valueForKey:RESPONSE_HEADER] allKeys] containsObject:RESPONSE_CODE] && (![[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] isKindOfClass:[NSNull class]]) ){
                                        responseCodeValue = [[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue];
                                        
                                        //added by Srinivasulu on 27/04/2018....
                                        if(([[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue] == -DUPLICATE_BILL_ID_RESOPNSE_CODE_WITH_AMOUNT_MISS_MATCH)){
                                            
                                            OfflineBillingServices *offline = [[OfflineBillingServices alloc]init];
                                            
                                            //bussiness_date -- dictionary
                                            if([bussiness_date componentsSeparatedByString:@" "].count){
                                                
                                                [offline changeSerialBuildIdLocally:[offline getAndReturnMaximumOfflineBillCount:[bussiness_date componentsSeparatedByString:@" "][0]  DefaultSerialBillId:serialBillId] originalBillId:bill_id];
                                            }
                                            
                                        }
                                        else if(([[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] integerValue] == -DUPLICATE_BILL_ID_RESOPNSE_CODE_DUE_TO_PRIMARY_CODE_MATCH)){
                                            
                                            @try {
                                                OfflineBillingServices * offline = [[OfflineBillingServices alloc]init];
                                                
                                                NSString * existBillIdStr = [dictionary valueForKey:BILL_ID];
                                                
                                                int changeNumber = [NSString stringWithFormat:@"%c", [existBillIdStr characterAtIndex: existBillIdStr.length - 1]].intValue;
                                                changeNumber = changeNumber + 1;
                                                int totalNumberOfTransactions = 0;
                                                //                                                NSRange range = NSMakeRange( existBillIdStr.length - 1,1);
                                                
                                                NSString * newBillIdStr = [NSString stringWithFormat:@"%@%i",[existBillIdStr substringToIndex:existBillIdStr.length - 1],changeNumber] ;
                                                
                                                if([dictionary.allKeys containsObject:TRANSACTION_DETAILS] && ! [[dictionary valueForKey:TRANSACTION_DETAILS] isKindOfClass:[NSNull class]])
                                                    totalNumberOfTransactions = (int)[[dictionary valueForKey:TRANSACTION_DETAILS] count];
                                                
                                                [offline changeOriginalBillIdLocally:newBillIdStr existingBillId:existBillIdStr numberOfPayment:totalNumberOfTransactions transactionInfo:[dictionary valueForKey:TRANSACTION_DETAILS]];
                                            } @catch (NSException *exception) {
                                                
                                            } @finally {
                                                
                                            }
                                        }
                                        
                                        //upto here on 27/04/2018....
                                        
                                    }
                                isBillSaved = FALSE;
                            }
                        }
                        
                        else {
                            isBillSaved = FALSE;
                        }
                        
                        if (isBillSaved) {
                            
                            [self updateBillStatus:bill_id status:SUCCESS];
                            //                            [self deleteLocalBills:bill_id];
                            
                        }
                        else {
                            if (([billSaveStatus isEqualToString:TO_BE_UPLOADED]) && (responseCodeValue != 0)) {
                                
                                [self updateBillStatus:bill_id status:PENDING];
                            }
                            else if (([billSaveStatus isEqualToString:PENDING]) && (responseCodeValue != 0)) {
                                
                                [self updateBillStatus:bill_id status:ERROR];
                            }
                        }
                        syncStatus = FALSE;
                        
                    }
                    @catch (NSException *exception) {
                        
                        [HUD hide:YES afterDelay:2.0];
                        
                        //added by Srinivasul on 01/05/2017....
                        isBillSaved = false;
                        
                    }
                    
                    uploodedBillId = [bill_id copy];
                    
                    sqlite3_close(database);
                    
                    if(isBillSaved){
                        [self uploadReturnedItems:bill_id date:currentdate];
                        [self uploadExchangedItems:bill_id date:currentdate];
                    }
                }
                
                
            }
            //           [self synchCustomerDetails];
            
        }
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
        
    }
    @finally {
        syncStatus = FALSE;
        
        
        
        //added by Srinivasulu on 14/06/2017....
        
        @try {
            int count = [self getLocalBillCount];
            
            refreshBtn.badgeValue = [NSString stringWithFormat:@"%d",count];
            
            // for(UIView * view in self.navigationController.navigationBar.subviews){
            
            for(UIView * view in  self.navigationItem.rightBarButtonItem.customView.subviews){
                
                // if(view.tag == 2){
                
                for(UIView * view1 in view.subviews){
                    
                    if(view1.frame.origin.x == refreshBtn.frame.origin.x){
                        
                        UIButton * btn = (UIButton *)view1;
                        
                        btn.badgeValue = [NSString stringWithFormat:@"%d",count];
                        
                        break;
                        
                    }
                    
                }
                //  break;
                
                // }
                
            }
        } @catch (NSException *exception) {
            
        }
        
        //upto here on 14/06/2017....
        
        sqlite3_close(database);
        return;
    }
    
}

- (void)uploadReturnedItems:(NSString *)bill_id date:(NSString *)currentDate
{
    NSString *return_status = @"";
    NSMutableArray *returnItems = [[NSMutableArray alloc]init];
    @try {
        
        NSString* dbPath = [DataBaseConnection connection:@"RetailerBillingDataBase.sqlite"];
        
        
        if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
            
            NSString *return_items_query = [NSString stringWithFormat:@"select * from return_items where bill_id='%@'",bill_id];
            
            const char *sqlStatement3 = return_items_query.UTF8String;
            if(sqlite3_prepare_v2(database, sqlStatement3, -1, &selectStmt, NULL) == SQLITE_OK) {
                
                while (sqlite3_step(selectStmt) == SQLITE_ROW) {
                    
                    NSString  *billID = @((char *)sqlite3_column_text(selectStmt, 1));
                    NSString  *counterID = @((char *)sqlite3_column_text(selectStmt, 8));
                    NSString  *reason = @((char *)sqlite3_column_text(selectStmt, 9));
                    NSString  *status = @((char *)sqlite3_column_text(selectStmt, 10));
                    return_status = [status copy];
                    NSString  *item_name = @((char *)sqlite3_column_text(selectStmt, 3));
                    NSString *dateTime = @((char *)sqlite3_column_text(selectStmt, 7));
                    currentDate = [dateTime copy];
                    NSString  *item_price = @((char *)sqlite3_column_text(selectStmt, 5));
                    NSString  *cost = @((char *)sqlite3_column_text(selectStmt, 6));
                    NSString  *quantity = @((char *)sqlite3_column_text(selectStmt, 4));
                    NSString  *sku_id = @((char *)sqlite3_column_text(selectStmt, 2));
                    NSString  *taxCode = @((char *)sqlite3_column_text(selectStmt, 11));
                    NSString  *taxValue = @((char *)sqlite3_column_text(selectStmt, 12));
                    NSString  *pluCode = @((char *)sqlite3_column_text(selectStmt, 13));
                    
                    NSDictionary *temp = @{@"bill_id": billID,@"counter_id": counterID,@"reason": reason,@"status": status,ITEM_NAME: item_name,@"bill_date": dateTime,ITEM_UNIT_PRICE: item_price,COST: cost,QUANTITY: quantity,SKU_ID: sku_id,TAX_CODE: taxCode,TAX_RATE_STR: taxValue,PLU_CODE: pluCode};
                    
                    [returnItems addObject:temp];
                    
                }
                sqlite3_finalize(selectStmt);
                selectStmt = nil;
                
            }
            else {
                
                NSLog(@"%s",sqlite3_errmsg(database));
            }
        }
        
        if (returnItems.count>0) {
            
            NSArray *headerKeys1 = @[@"billId",@"requestHeader", @"billReturnItems", @"denominations", @"status", @"bill_date", @"storeLocation"];
            
            NSArray *headerObjects1 = @[bill_id,[RequestHeader getRequestHeader],returnItems,[self prepareDenominationString:nil], return_status, currentDate, presentLocation];
            NSDictionary *dictionary1 = [NSDictionary dictionaryWithObjects:headerObjects1 forKeys:headerKeys1];
            
            NSError * err1;
            NSData * jsonData1 = [NSJSONSerialization dataWithJSONObject:dictionary1 options:0 error:&err1];
            NSString * jsonString = [[NSString alloc] initWithData:jsonData1 encoding:NSUTF8StringEncoding];
            
            NSString *serviceUrl = [WebServiceUtility getURLFor:RETURN_BILLING];
            serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,jsonString];
            serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
            
            NSURL *url = [NSURL URLWithString:serviceUrl];
            NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                                 timeoutInterval:60.0];
            request.HTTPMethod = @"POST";
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setValue:[NSString stringWithFormat:@"%ld", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
            
            NSError *error = nil;
            NSHTTPURLResponse *responseCode = nil;
            
            NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
            NSDictionary *billingResponse = [NSJSONSerialization JSONObjectWithData:data options:0
                                             
                                                                              error:NULL];
            NSLog(@"%@",billingResponse);
            
        }
    }
    @catch (NSException *exception) {
        
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Problem occured while processing" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //        [alert show];
        NSLog(@"%@",exception.description);
        
        
    }
    @finally {
        sqlite3_close(database);
    }
}

- (void)uploadExchangedItems:(NSString *)bill_id date:(NSString *)currentDate
{
    NSString *exchange_status = @"";
    NSMutableArray *exchangeItems = [[NSMutableArray alloc]init];
    @try {
        NSString* dbPath = [DataBaseConnection connection:@"RetailerBillingDataBase.sqlite"];
        
        
        if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
            
            NSString *exchange_items_query = [NSString stringWithFormat:@"select * from exchange_items where bill_id='%@'",bill_id];
            
            const char *sqlStatement3 = exchange_items_query.UTF8String;
            if(sqlite3_prepare_v2(database, sqlStatement3, -1, &selectStmt, NULL) == SQLITE_OK) {
                
                while (sqlite3_step(selectStmt) == SQLITE_ROW) {
                    
                    NSString  *billID = @((char *)sqlite3_column_text(selectStmt, 1));
                    NSString  *counterID = @((char *)sqlite3_column_text(selectStmt, 8));
                    NSString  *reason = @((char *)sqlite3_column_text(selectStmt, 9));
                    NSString  *status = @((char *)sqlite3_column_text(selectStmt, 11));
                    exchange_status = [status copy];
                    NSString  *item_name = @((char *)sqlite3_column_text(selectStmt, 3));
                    NSString *dateTime = @((char *)sqlite3_column_text(selectStmt, 7));
                    currentDate = [dateTime copy];
                    NSString  *item_price = @((char *)sqlite3_column_text(selectStmt, 5));
                    NSString  *cost = @((char *)sqlite3_column_text(selectStmt, 6));
                    NSString  *quantity = @((char *)sqlite3_column_text(selectStmt, 4));
                    NSString  *sku_id = @((char *)sqlite3_column_text(selectStmt, 2));
                    NSString  *exchanged_bill = @((char *)sqlite3_column_text(selectStmt, 10));
                    NSString  *taxCode = @((char *)sqlite3_column_text(selectStmt, 12));
                    NSString  *taxRate = @((char *)sqlite3_column_text(selectStmt, 13));
                    NSString  *pluCode = @((char *)sqlite3_column_text(selectStmt, 14));
                    
                    NSDictionary *temp = @{@"bill_id": billID,@"counter_id": counterID,@"reason": reason,@"status": status,ITEM_NAME: item_name,@"bill_date": dateTime,ITEM_UNIT_PRICE: item_price,COST: cost,QUANTITY: quantity,SKU_ID: sku_id,@"exchanged_bill_id": exchanged_bill,TAX_CODE: taxCode,TAX_RATE_STR: taxRate,PLU_CODE: pluCode};
                    
                    
                    [exchangeItems addObject:temp];
                    
                }
                sqlite3_finalize(selectStmt);
                selectStmt = nil;
                
            }
            else {
                
                NSLog(@"%s",sqlite3_errmsg(database));
            }
        }
        if (exchangeItems.count>0) {
            
            NSArray *headerKeys1 = @[@"billId",@"requestHeader", @"billExchangedItems", @"denominations", @"status", @"bill_date", @"storeLocation"];
            
            NSArray *headerObjects1 = @[bill_id,[RequestHeader getRequestHeader],exchangeItems,[self prepareDenominationString:nil], exchange_status, currentDate, presentLocation];
            NSDictionary *dictionary1 = [NSDictionary dictionaryWithObjects:headerObjects1 forKeys:headerKeys1];
            
            NSError * err1;
            NSData * jsonData1 = [NSJSONSerialization dataWithJSONObject:dictionary1 options:0 error:&err1];
            NSString * jsonString = [[NSString alloc] initWithData:jsonData1 encoding:NSUTF8StringEncoding];
            
            NSString *serviceUrl = [WebServiceUtility getURLFor:Exchange_BILLING];
            serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,jsonString];
            serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
            
            NSURL *url = [NSURL URLWithString:serviceUrl];
            NSMutableURLRequest  *request = [NSMutableURLRequest  requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                                 timeoutInterval:60.0];
            request.HTTPMethod = @"POST";
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setValue:[NSString stringWithFormat:@"%d", [serviceUrl dataUsingEncoding:NSUTF8StringEncoding].length] forHTTPHeaderField:@"Content-Length"];
            
            NSError *error = nil;
            NSHTTPURLResponse *responseCode = nil;
            
            NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
            NSDictionary *billingResponse = [NSJSONSerialization JSONObjectWithData:data options:0
                                                                              error:NULL];
            
        }
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Problem occured while processing" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //        [alert show];
        
    }
    @finally {
        sqlite3_close(database);
    }
}

-(NSArray*)getDenomination:(NSString *)bill_id transaction_id:(NSString *)transaction_id {
    
    NSMutableArray *denomArr = [[NSMutableArray alloc]init];
    
    NSString *denomination_query = [NSString stringWithFormat:@"select * from billing_denomination where bill_id='%@'",bill_id];
    
    const char *sqlStatement1 = denomination_query.UTF8String;
    
    
    if(sqlite3_prepare_v2(database, sqlStatement1, -1, &selectStmt, NULL) == SQLITE_OK) {
        itemsArr = [[NSMutableArray alloc]init];
        
        
        while (sqlite3_step(selectStmt) == SQLITE_ROW) {
            
            
            NSString  *denom = @((char *)sqlite3_column_text(selectStmt, 1));
            NSString  *denomNo = @((char *)sqlite3_column_text(selectStmt, 2));
            NSString  *paidAmt = @((char *)sqlite3_column_text(selectStmt, 3));
            NSString  *returnDenomNo = @((char *)sqlite3_column_text(selectStmt, 4));
            NSString  *returnAmt = @((char *)sqlite3_column_text(selectStmt,5));
            NSString  *date = @((char *)sqlite3_column_text(selectStmt,6));
            transaction_id = @((char *)sqlite3_column_text(selectStmt,7));
            
            NSDictionary *temp = @{@"denomination": denom,@"paidDenominationNo": denomNo,@"transactionId": transaction_id,@"billId": bill_id,@"billDate": date,@"paidAmount": paidAmt,@"returnAmount": returnAmt,@"returnDenominationNo": returnDenomNo};
            
            [denomArr addObject:temp];
            
        }
        sqlite3_finalize(selectStmt);
        selectStmt = nil;
        
    }
    else {
        NSLog(@"%s",sqlite3_errmsg(database)) ;
    }
    return denomArr;
    
    
}

#pragma mark - Create Billing Service Reposnse Delegates

- (void)createBillingSuccessResponse:(NSDictionary *)successDictionary {
    BOOL isBillSaved = false;
    
    if ([[[successDictionary valueForKey:@"responseHeader"] valueForKey:@"responseCode"] intValue]==0) {
        isBillSaved = TRUE;
        
    }
    else {
        isBillSaved = false;
    }
    
    if (isBillSaved) {
        
        //        [self deleteLocalBills:uploodedBillId];
        
    }
    else {
        if ([billSaveStatus isEqualToString:@"to be uploaded"]) {
            
            [self updateBillStatus:uploodedBillId status:@"Pending"];
            
            
        }
        else if ([billSaveStatus isEqualToString:@"Pending"]) {
            [self updateBillStatus:uploodedBillId status:@"Error"];
        }
    }
    [HUD hide:YES afterDelay:2.0];
    syncStatus = FALSE;
}

- (void)createBillingErrorResponse {
    
    [HUD setHidden:YES];
}


#pragma mark End of Create Billing Service Reposnse Delegates -


-(void)deleteLocalBills:(NSString *)bill_id{
    
    BOOL isDeleted = NO;
    
    @try {
        
        NSString* dbPath = [DataBaseConnection connection:@"RetailerBillingDataBase.sqlite"];
        
        //  BOOL isExists = [self createTable:@"billing"];
        
        //  if (isExists) {
        
        
        if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
            
            if (deleteStmt == nil) {
                NSString *query = [NSString stringWithFormat:@"delete from billing_table"];
                const char *sqlStatement = query.UTF8String;
                
                if(sqlite3_prepare_v2(database, sqlStatement, -1, &deleteStmt, NULL) == SQLITE_OK) {
                    
                    if(SQLITE_DONE != sqlite3_step(deleteStmt)){
                        isDeleted = NO;
                        NSLog(@"%s",sqlite3_errmsg(database));
                        NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(database));
                    }
                    else {
                        isDeleted = YES;
                        
                    }
                    sqlite3_reset(deleteStmt);
                }
                deleteStmt = nil;
                
            }
            if (deleteStmt == nil) {
                NSString *query = [NSString stringWithFormat:@"delete from billing_items"];
                
                const char *sqlStatement = query.UTF8String;
                
                if(sqlite3_prepare_v2(database, sqlStatement, -1, &deleteStmt, NULL) == SQLITE_OK) {
                    
                    if(SQLITE_DONE != sqlite3_step(deleteStmt)){
                        NSLog(@"%s",sqlite3_errmsg(database));
                        isDeleted = NO;
                        NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(database));
                    }
                    else {
                        isDeleted = YES;
                    }
                    sqlite3_reset(deleteStmt);
                }
                deleteStmt = nil;
                
            }
            if (deleteStmt == nil) {
                NSString *query = [NSString stringWithFormat:@"delete from billing_transactions "];
                
                const char *sqlStatement = query.UTF8String;
                
                if(sqlite3_prepare_v2(database, sqlStatement, -1, &deleteStmt, NULL) == SQLITE_OK) {
                    
                    if(SQLITE_DONE != sqlite3_step(deleteStmt)){
                        isDeleted = NO;
                        NSLog(@"%s",sqlite3_errmsg(database));
                        NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(database));
                    }
                    else {
                        isDeleted = YES;
                    }
                    sqlite3_reset(deleteStmt);
                }
                deleteStmt = nil;
                
            }
            if (deleteStmt == nil) {
                NSString *query = [NSString stringWithFormat:@"delete from billing_taxes"];
                
                const char *sqlStatement = query.UTF8String;
                
                if(sqlite3_prepare_v2(database, sqlStatement, -1, &deleteStmt, NULL) == SQLITE_OK) {
                    
                    if(SQLITE_DONE != sqlite3_step(deleteStmt)){
                        isDeleted = NO;
                        NSLog(@"%s",sqlite3_errmsg(database));
                        NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(database));
                    }
                    else {
                        isDeleted = YES;
                    }
                    sqlite3_reset(deleteStmt);
                }
                deleteStmt = nil;
                
            }
            
            if (deleteStmt == nil) {
                NSString *query = [NSString stringWithFormat:@"delete from billing_denomination"];
                
                const char *sqlStatement = query.UTF8String;
                
                if(sqlite3_prepare_v2(database, sqlStatement, -1, &deleteStmt, NULL) == SQLITE_OK) {
                    
                    if(SQLITE_DONE != sqlite3_step(deleteStmt)){
                        isDeleted = NO;
                        NSLog(@"%s",sqlite3_errmsg(database));
                        NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(database));
                    }
                    else {
                        isDeleted = YES;
                    }
                    sqlite3_reset(deleteStmt);
                }
                deleteStmt = nil;
                
            }
            
        }
        
    }
    @catch (NSException *exception) {
        [HUD hide:YES afterDelay:2.0];
        NSLog(@"%@",exception);
        
    }
    @finally {
        sqlite3_close(database);
        deleteStmt = nil;
        selectStmt = nil;
        
    }
    
}

-(void)updateBillStatus:(NSString *)bill_id status:(NSString *)status {
    
    @try {
        
        NSString* dbPath = [DataBaseConnection connection:@"RetailerBillingDataBase.sqlite"];
        
        if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
            
            if (deleteStmt == nil) {
                NSString *query = [NSString stringWithFormat:@"update billing_table SET save_status='%@' where bill_id='%@'",status,bill_id];
                const char *sqlStatement = query.UTF8String;
                
                if(sqlite3_prepare_v2(database, sqlStatement, -1, &deleteStmt, NULL) == SQLITE_OK) {
                    
                    if(SQLITE_DONE != sqlite3_step(deleteStmt)){
                        NSLog(@"%s",sqlite3_errmsg(database));
                        NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(database));
                    }
                    
                    sqlite3_reset(deleteStmt);
                    sqlite3_finalize(deleteStmt);
                }
                
                deleteStmt = nil;
            }
            
        }
        
    }
    @catch (NSException *exception) {
        
        [HUD hide:YES afterDelay:2.0];
        NSLog(@"%@",exception);
    }
    @finally {
        
        sqlite3_close(database);
        deleteStmt = nil;
        selectStmt = nil;
    }
    
}
#pragma mark upload customer details

// This method is not using anywhere in this class..
-(void)synchCustomerDetails {
    
    NSMutableDictionary * result = [NSMutableDictionary new];
    NSMutableArray *custArr = [NSMutableArray new];
    //    int count = 0;
    
    @try {
        
        NSString* dbPath = [DataBaseConnection connection:@"RetailerBillingDataBase.sqlite"];
        
        if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
            NSString *query;
            
            query = [NSString stringWithFormat:@"select * from customer_details"];
            
            const char *sqlStatement = query.UTF8String;
            
            
            if(sqlite3_prepare_v2(database, sqlStatement, -1, &selectStmt, NULL) == SQLITE_OK) {
                while (sqlite3_step(selectStmt) == SQLITE_ROW) {
                    //                    count = sqlite3_column_int(selectStmt, 0);
                    
                    NSString  *phone = @((char *)sqlite3_column_text(selectStmt, 3));
                    NSString  *email = @((char *)sqlite3_column_text(selectStmt, 2));
                    
                    NSString  *street = @((char *)sqlite3_column_text(selectStmt, 5));
                    NSString  *locality = @((char *)sqlite3_column_text(selectStmt,6));
                    NSString  *city = @((char *)sqlite3_column_text(selectStmt,7));
                    NSString  *pin_no = @((char *)sqlite3_column_text(selectStmt,8));
                    
                    NSString *name = @((char*)sqlite3_column_text(selectStmt,0));
                    
                    
                    //added by Srinivausulu on 04/05/2017....
                    
                    NSString * lastName = @"";
                    NSString * houseNo = @"";
                    NSString * landMark = @"";
                    
                    if( (char *)sqlite3_column_text(selectStmt,1))
                        lastName = @((char*)sqlite3_column_text(selectStmt,1));
                    
                    if( (char *)sqlite3_column_text(selectStmt,18))
                        houseNo = @((char*)sqlite3_column_text(selectStmt,18));
                    
                    if( (char *)sqlite3_column_text(selectStmt,19))
                        landMark = @((char*)sqlite3_column_text(selectStmt,19));
                    
                    
                    //upto here on 03/05/2017....
                    
                    
                    //changed by Srinivasulu 04/05/2017....
                    
                    //                    result = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:phone,email,street,locality,city,pin_no,name, nil] forKeys:[NSArray arrayWithObjects:@"phone",@"email",@"street",@"locality",@"city",@"pin_no",@"name", nil]];
                    
                    result = [NSMutableDictionary dictionaryWithObjects:@[phone,email,street,locality,city,pin_no,name,lastName,houseNo,landMark] forKeys:@[@"phone",@"email",@"street",@"locality",@"city",@"pin_no",@"name",@"lastName",@"houseNo",@"landMark"]];
                    
                    
                    //upto here on04/05/2017....
                    
                    //                    result = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:phone,email,street,locality,city,pin_no,name, nil] forKeys:[NSArray arrayWithObjects:@"phone",@"email",@"street",@"locality",@"city",@"pin_no",@"name", nil]];
                    [custArr addObject:result];
                }
                sqlite3_reset(selectStmt);
                sqlite3_finalize(selectStmt);
                selectStmt = nil;
                
            }
            else {
                NSLog(@"%s",sqlite3_errmsg(database)) ;
            }
            
        }
        
        if (custArr.count>0) {
            
            for (NSDictionary *dic in custArr) {
                
                CustomerServiceSoapBinding *custBindng =  [CustomerServiceSvc CustomerServiceSoapBinding] ;
                CustomerServiceSvc_updateCustomer *aParameters = [[CustomerServiceSvc_updateCustomer alloc] init];
                
                //changed by Srinivasulu on 04/05/2017....
                
                
                //                NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"phone", @"pin_no",@"status",@"email",@"name",@"street",@"locality",@"loyaltyCustomer",@"phoneIds",@"city",REQUEST_HEADER, nil];
                //
                //                NSArray *loyaltyObjects = [NSArray arrayWithObjects:[dic valueForKey:@"phone"],[dic valueForKey:@"pin_no"],@"false",[dic valueForKey:@"email"],[dic valueForKey:@"name"],[dic valueForKey:@"street"],[dic valueForKey:@"locality"],@"",@"",[dic valueForKey:@"city"],[RequestHeader getRequestHeader], nil];
                
                
                
                NSArray *loyaltyKeys = @[@"phone", @"pin_no",@"status",@"email",@"name",@"street",@"locality",@"loyaltyCustomer",@"phoneIds",@"city",REQUEST_HEADER,@"lastName",@"houseNo",@"landMark"];
                
                NSArray *loyaltyObjects = @[[dic valueForKey:@"phone"],[dic valueForKey:@"pin_no"],@"false",[dic valueForKey:@"email"],[dic valueForKey:@"name"],[dic valueForKey:@"street"],[dic valueForKey:@"locality"],@"",@"",[dic valueForKey:@"city"],[RequestHeader getRequestHeader],[dic valueForKey:@"lastName"],[dic valueForKey:@"houseNo"],[dic valueForKey:@"landMark"]];
                
                
                
                //upto here on 04/05/2017....
                //                NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"phone", @"pin_no",@"status",@"email",@"name",@"street",@"locality",@"loyaltyCustomer",@"phoneIds",@"city",REQUEST_HEADER, nil];
                //
                //                NSArray *loyaltyObjects = [NSArray arrayWithObjects:[dic valueForKey:@"phone"],[dic valueForKey:@"pin_no"],@"false",[dic valueForKey:@"email"],[dic valueForKey:@"name"],[dic valueForKey:@"street"],[dic valueForKey:@"locality"],@"",@"",[dic valueForKey:@"city"],[RequestHeader getRequestHeader], nil];
                NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
                
                NSError * err_;
                NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
                NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
                aParameters.customerDetails = loyaltyString;
                
                
                CustomerServiceSoapBindingResponse *response = [custBindng updateCustomerUsingParameters:(CustomerServiceSvc_updateCustomer *)aParameters];
                if (![response.error isKindOfClass:[NSError class]]) {
                    
                    NSArray *responseBodyParts = response.bodyParts;
                    for (id bodyPart in responseBodyParts) {
                        if ([bodyPart isKindOfClass:[CustomerServiceSvc_updateCustomerResponse class]]) {
                            CustomerServiceSvc_updateCustomerResponse *body = (CustomerServiceSvc_updateCustomerResponse *)bodyPart;
                            // printf("\nresponse=%d",[body.createCustomerReturn UTF8String]);
                            NSError *e;
                            
                            NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                                                  options: NSJSONReadingMutableContainers
                                                                                    error: &e];
                            if ([[[JSON1 valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                                
                                [self deleteLocalCustDetails:[dic valueForKey:@"phone"]];
                                
                            }
                        }
                    }
                }
                
            }
        }
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
        
        
    }
    @finally {
        sqlite3_close(database);
        
    }

}




-(BOOL)deleteLocalCustDetails:(NSString*)phone_no {
    
    BOOL isDeleted = NO;
    
    @try {
        
        NSString* dbPath = [DataBaseConnection connection:@"RetailerBillingDataBase.sqlite"];
        
        //  BOOL isExists = [self createTable:@"billing"];
        
        //  if (isExists) {
        
        
        if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
            
            if (deleteStmt == nil) {
                NSString *query = [NSString stringWithFormat:@"delete from customer_details where phone_number='%@'",phone_no];
                const char *sqlStatement = query.UTF8String;
                
                if(sqlite3_prepare_v2(database, sqlStatement, -1, &deleteStmt, NULL) == SQLITE_OK) {
                    
                    if(SQLITE_DONE != sqlite3_step(deleteStmt)){
                        isDeleted = NO;
                        NSLog(@"%s",sqlite3_errmsg(database));
                        NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(database));
                    }
                    else {
                        isDeleted = YES;
                        
                    }
                    sqlite3_reset(deleteStmt);
                }
                deleteStmt = nil;
                
            }
            
        }
        
    }
    @catch (NSException *exception) {
        [HUD hide:YES afterDelay:2.0];
        NSLog(@"%@",exception);
        
    }
    @finally {
        sqlite3_close(database);
        deleteStmt = nil;
        selectStmt = nil;
        
    }
    
    return isDeleted;
    
}

// Commented by roja on 17/10/2019.. // reason :- updateSyncStatus: method contains SOAP Service call .. so taken new method with same name(updateSyncStatus:) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//-(void)updateSyncStatus:(BOOL)deals skus:(BOOL)sku offer:(BOOL)offer tax:(BOOL)tax employeeStatus:(BOOL)employeeStatus denomStatus:(BOOL)denomStatus categoryStatus:(BOOL)category subCategoryStatus:(BOOL)subCategory productStatus:(BOOL)product giftCouponStatus:(BOOL)giftCoupon giftVoucherStatus:(BOOL)giftVoucher loyaltyCardStatus:(BOOL)loyaltyCard {
//
//    @try {
//
//        //commented by Srinivasulu on 20/07/2017....
//
//        //        NSString *deviceUDID = @"";
//        //        UIDevice *myDevice = [UIDevice currentDevice];
//        //        KeychainItemWrapper *keyChainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"Technolabs" accessGroup:nil];
//        //        if ([[keyChainItem objectForKey:(__bridge id)(kSecAttrAccount)] length] == 0) {
//        //            NSString* deviceId = [[myDevice identifierForVendor] UUIDString];
//        //            [keyChainItem setObject:deviceId forKey:(__bridge id)(kSecAttrAccount)];
//        //            deviceUDID = deviceId;
//        //        }
//        //        else {
//        //            deviceUDID = [keyChainItem objectForKey:(__bridge id)(kSecAttrAccount)];
//        //        }
//        //
//        //        deviceUDID = DEVICE_ID;
//        //
//        //        if ([custID caseInsensitiveCompare:@"CID8995453"]==NSOrderedSame || [custID caseInsensitiveCompare:@"CID8995455"]==NSOrderedSame) {
//        //
//        //            deviceUDID = @"C25B90129AEFC3F9171D9A3AF57068A666E25B9D";
//        //        }
//        //        else if ([custID caseInsensitiveCompare:@"CID8995454"] == NSOrderedSame) {
//        //            deviceUDID = @"90f839bab41395956e642d4c0a313aa07292185d";
//        //
//        //        }
//        //        else {
//        //
//        //            //changed by Srinivasulu on 12/06/2017....
//        //
//        //            //            deviceUDID = @"FFFFFFFF6E6EA64DDD504BB2B980CBCE33A53D05";
//        //
//        //            deviceUDID = DEVICE_ID;
//        //            //D-CHAMELEON CLIENT DEVICES ID....
//        //            //            deviceUDID = @"944cf5de35f63d3289738b845779e070651ff249";
//        //            //upto here on 12/06/2017....
//        //
//        //        }
//
//
//        //upto here on 20/07/2017....
//
//
//        NSArray *keys = @[@"requestHeader",@"dealStatus",@"taxStatus",@"skuStatus",@"offer_status",@"tables_status",@"waiters_status",@"employeeStatus",@"denominationMasterStatus",@"productCategoryStatus",@"productSubCategoryStatus",@"productMasterStatus",@"giftCouponStatus",@"giftVoucherStatus",@"loyaltyCardsStatus",@"deviceId"];
//
//        //commented by Srinivasulu on 20/07/2017....
//        //reason changed the deviceId....
//
//        //        NSArray *objects = [NSArray arrayWithObjects:[RequestHeader getRequestHeader],[NSString stringWithFormat:@"%@",deals?@"false":@"true"],[NSString stringWithFormat:@"%@",tax?@"false":@"true"],[NSString stringWithFormat:@"%@",sku?@"false":@"false"],[NSString stringWithFormat:@"%@",offer?@"false":@"true"],@"true",@"true",[NSString stringWithFormat:@"%@",employeeStatus?@"false":@"true"],[NSNumber numberWithBool:!denomStatus],[NSNumber numberWithBool:!category],[NSNumber numberWithBool:!subCategory],[NSNumber numberWithBool:!product],deviceUDID, nil];
//
//
//        NSArray *objects = @[[RequestHeader getRequestHeader],[NSString stringWithFormat:@"%@",deals?@"false":@"true"],[NSString stringWithFormat:@"%@",tax?@"false":@"true"],[NSString stringWithFormat:@"%@",sku?@"false":@"false"],[NSString stringWithFormat:@"%@",offer?@"false":@"true"],@"true",@"true",[NSString stringWithFormat:@"%@",employeeStatus?@"false":@"true"],[NSNumber numberWithBool:!denomStatus],[NSNumber numberWithBool:!category],[NSNumber numberWithBool:!subCategory],[NSNumber numberWithBool:!product], [NSNumber numberWithBool:!giftCoupon], [NSNumber numberWithBool:!giftVoucher], [NSNumber numberWithBool:!loyaltyCard], deviceId];
//
//
//        isDayStartWithSync = false;
//
//        //upto here on 20/07/2017....
//
//        CountersServiceSoapBinding *custBindng =  [CountersServiceSvc CountersServiceSoapBinding] ;
//        CountersServiceSvc_updateSyncDownloadStatus *aParameters = [[CountersServiceSvc_updateSyncDownloadStatus alloc] init];
//
//        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
//
//        NSError * err;
//        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
//        NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//        aParameters.syncDetails = jsonString;
//
//        CountersServiceSoapBindingResponse *response = [custBindng updateSyncDownloadStatusUsingParameters:aParameters];
//        NSArray *responseBodyParts = response.bodyParts;
//        for (id bodyPart in responseBodyParts) {
//
//            if ([bodyPart isKindOfClass:[CountersServiceSvc_updateSyncDownloadStatusResponse class]]) {
//                CountersServiceSvc_updateSyncDownloadStatusResponse * body = (CountersServiceSvc_updateSyncDownloadStatusResponse *)bodyPart;
//                break;
//                printf("\nresponse=%s",(body.return_).UTF8String);
//                NSLog(@"\nresponse=%s",(body.return_).UTF8String);
//
//
//            }
//        }
//    }
//    @catch (NSException *exception) {
//
//        NSLog(@"exception %@",exception);
//    }
//    @finally {
//
//        //commented by Srinivasulu on 03/10/2017....
//        //reason it should in main thread only....
//
//        //        [HUD setHidden:YES];
//
//        //upto here on 03/10/2017....
//    }
//
//}


//updateSyncStatus: method changed by roja on 17/10/2019.. // reason : removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST
-(void)updateSyncStatus:(BOOL)deals skus:(BOOL)sku offer:(BOOL)offer tax:(BOOL)tax employeeStatus:(BOOL)employeeStatus denomStatus:(BOOL)denomStatus categoryStatus:(BOOL)category subCategoryStatus:(BOOL)subCategory productStatus:(BOOL)product giftCouponStatus:(BOOL)giftCoupon giftVoucherStatus:(BOOL)giftVoucher loyaltyCardStatus:(BOOL)loyaltyCard {
    
    @try {
        
        NSArray *keys = @[@"requestHeader",@"dealStatus",@"taxStatus",@"skuStatus",@"offer_status",@"tables_status",@"waiters_status",@"employeeStatus",@"denominationMasterStatus",@"productCategoryStatus",@"productSubCategoryStatus",@"productMasterStatus",@"giftCouponStatus",@"giftVoucherStatus",@"loyaltyCardsStatus",@"deviceId"];
        
        NSArray *objects = @[[RequestHeader getRequestHeader],[NSString stringWithFormat:@"%@",deals?@"false":@"true"],[NSString stringWithFormat:@"%@",tax?@"false":@"true"],[NSString stringWithFormat:@"%@",sku?@"false":@"false"],[NSString stringWithFormat:@"%@",offer?@"false":@"true"],@"true",@"true",[NSString stringWithFormat:@"%@",employeeStatus?@"false":@"true"],[NSNumber numberWithBool:!denomStatus],[NSNumber numberWithBool:!category],[NSNumber numberWithBool:!subCategory],[NSNumber numberWithBool:!product], [NSNumber numberWithBool:!giftCoupon], [NSNumber numberWithBool:!giftVoucher], [NSNumber numberWithBool:!loyaltyCard], deviceId];
        
        isDayStartWithSync = false;
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * services = [[WebServiceController alloc] init];
        services.counterServiceDelegate = self;
        [services updateSyncDownloadStatus:jsonString];
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"exception %@",exception);
    }
    @finally {
        
        //commented by Srinivasulu on 03/10/2017....
        //reason it should in main thread only....
        
        //        [HUD setHidden:YES];
        
        //upto here on 03/10/2017....
    }
}

// added by Roja on 17/10/2019….
- (void)updateSyncDownloadStatusSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        NSLog(@"updateSyncDownloadStatusSuccessResponse in  OmniHomePage: %@",successDictionary);
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}

// added by Roja on 17/10/2019….
- (void)updateSyncDownloadStatusErrorResponse:(NSString *)errorString{
    
    @try {
        NSLog(@"updateSyncDownloadStatusErrorResponse in  OmniHomePage: %@",errorString);
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}



-(void)setFrames {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
            
            line.frame = CGRectMake(0.0, 0.0, 750, 50.0);
            billingView.frame = CGRectMake(195.0, 80.0, line.frame.size.width, 600);
            
            homeTable.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
            homeTable.frame = CGRectMake(0, 60, 190, 620);
            segmentedControl.frame = CGRectMake(-6,700,self.view.frame.size.width+20,60);
            scrollView.frame = CGRectMake(0, 65, 600, 520);
            //            scrollView.backgroundColor = [UIColor purpleColor];
            scrollView.contentSize = CGSizeMake(605.0, 1200);
        }
        else {
            line.frame = CGRectMake(0.0, 0.0, 560, 50.0);
            billingView.frame = CGRectMake(195.0, 80.0, 560.0, 870.0);
            
            homeTable.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
            homeTable.frame = CGRectMake(0, 60, 190, 900);
            //topbar.frame = CGRectMake(0, 0, 768, 50);
            
            //        label.font = [UIFont boldSystemFontOfSize:25];
            //        backbutton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            //
            //        label.frame = CGRectMake(10, 0, 240, 50);
            //        backbutton.frame = CGRectMake(640, 5, 100, 40);
            segmentedControl.frame = CGRectMake(-6,963,self.view.frame.size.width,60);
            scrollView.frame = CGRectMake(0, 65, 600.0, 790.0);
            scrollView.contentSize = CGSizeMake(605.0, 1180.0);
            
        }
        
        newBillButton.frame = CGRectMake(0.0, 65.0, line.frame.size.width, 90.0);
        buttonView.frame = CGRectMake(20.0, 10.0, 70, 70);
        newBillButton.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
        newBillButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
        newBillButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        newBillButton.titleEdgeInsets = UIEdgeInsetsMake(0, 150, 0, 0);
        newBillButton.layer.borderWidth = 0.5f;
        newBillButton.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
        newBillButton.titleLabel.alpha = 0.7f;
        
        oldBillButton.frame = CGRectMake(0.0, 160.0, line.frame.size.width, 90.0);
        oldBillView.frame = CGRectMake(20.0, 10.0, 70, 70);
        oldBillButton.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
        oldBillButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
        oldBillButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        oldBillButton.titleEdgeInsets = UIEdgeInsetsMake(0, 150, 0, 0);
        oldBillButton.layer.borderWidth = 0.5f;
        oldBillButton.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
        oldBillButton.titleLabel.alpha = 0.7f;
        
        deliveryIcon.frame = CGRectMake(0.0, 350, line.frame.size.width, 90.0);
        deliveryView.frame = CGRectMake(20.0, 10.0, 70, 70);
        deliveryIcon.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
        deliveryIcon.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
        deliveryIcon.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        deliveryIcon.titleEdgeInsets = UIEdgeInsetsMake(0, 150, 0, 0);
        // deliveryIcon.layer.borderWidth = 0.5f;
        //  deliveryIcon.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
        deliveryIcon.titleLabel.alpha = 0.7f;
        
        pendingIcon.frame = CGRectMake(0.0, 255, line.frame.size.width, 90.0);
        
        pendingView.frame = CGRectMake(20.0, 10.0, 70, 70);
        pendingIcon.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
        pendingIcon.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
        pendingIcon.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        pendingIcon.titleEdgeInsets = UIEdgeInsetsMake(0, 150, 0, 0);
        pendingIcon.layer.borderWidth = 0.5f;
        pendingIcon.layer.borderColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
        pendingIcon.titleLabel.alpha = 0.7f;
        // pendingBottomBorder.frame = CGRectMake(0.0f, 100.0f, pendingIcon.frame.size.width, 1.0f);
        
        
        goodsTransfer.frame = CGRectMake(0.0, 255.0, line.frame.size.width, 50.0);
        stockReceipt.frame = CGRectMake(0.0, 305.0, line.frame.size.width, 90.0);
        
        stockReceiptView.frame = CGRectMake(20.0, 10.0, 70, 70);
        stockReceiptView.image = [UIImage imageNamed:@"Receipts.png"];
        stockReceipt.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
        stockReceipt.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
        stockReceipt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        stockReceipt.titleEdgeInsets = UIEdgeInsetsMake(0, 150, 0, 0);
        stockReceipt.titleLabel.alpha = 0.7f;
        
        stockIssue.frame = CGRectMake(0.0, 400.0, line.frame.size.width, 90.0);
        stocks.frame = CGRectMake(0.0, 10.0, line.frame.size.width, 50.0);
        criticalStock.frame = CGRectMake(0.0, 60.0, line.frame.size.width, 90.0);
        stockVerify.frame = CGRectMake(0.0, 155.0, line.frame.size.width, 90.0);
        goodsProcurement.frame = CGRectMake(0.0, 500.0, line.frame.size.width, 50.0);
        purchases.frame = CGRectMake(0.0, 550.0, line.frame.size.width, 90.0);
        shipments.frame = CGRectMake(0.0, 645.0, line.frame.size.width, 90.0);
        receipts.frame = CGRectMake(0.0, 740.0, line.frame.size.width, 90.0);
        delivers.frame = CGRectMake(0.0, 840.0, line.frame.size.width, 50.0);
        orders.frame = CGRectMake(0.0, 890.0, line.frame.size.width, 90.0);
        shipments_.frame = CGRectMake(0.0, 985.0, line.frame.size.width, 90.0);
        
        dealsButton.frame = CGRectMake(0.0, 65.0, line.frame.size.width, 90.0);
        offersButton.frame = CGRectMake(0.0, 160.0, line.frame.size.width, 90.0);
        offersBottomBorder.frame = CGRectMake(0.0f, 100.0f, offersButton.frame.size.width, 1.0f);
        
        newOrders.frame = CGRectMake(0.0, 65.0, line.frame.size.width, 90.0);
        oldOrders.frame = CGRectMake(0.0, 160.0, line.frame.size.width, 90.0);
        dOrder.frame = CGRectMake(0.0, 255.0, line.frame.size.width, 90.0);
        complaints.frame = CGRectMake(0.0,350.0, line.frame.size.width, 90.0);
        complaintsBottomBorder.frame = CGRectMake(0.0f, 100.0f, complaints.frame.size.width, 1.0f);
        
        newReports.frame = CGRectMake(0.0, 65.0, line.frame.size.width, 90.0);
        oldReports.frame = CGRectMake(0.0, 160.0, line.frame.size.width, 90.0);
        orderBottomBorder.frame = CGRectMake(0.0f, 100.0f, oldReports.frame.size.width, 1.0f);
        
        issueCard.frame = CGRectMake(0.0, 65.0, line.frame.size.width, 90.0);
        viewCard.frame = CGRectMake(0.0, 160.0, line.frame.size.width, 90.0);
        loyaltyEdit.frame = CGRectMake(0.0, 255, line.frame.size.width, 90);
        editBottomBorder.frame = CGRectMake(0.0f, 100.0f, loyaltyEdit.frame.size.width, 1.0f);
    }
    
}

// Commented by roja on 17/10/2019.. // reason :- getXZReports: method contains SOAP Service call .. so taken new method with same name(getXZReports:) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//-(void)getXZReports:(NSString*)reportType {
//
//    CheckWifi *WIFI = [[CheckWifi alloc]init];
//    BOOL status = [WIFI checkWifi];
//    if (status) {
//
//        @try {
//
//            SalesServiceSvcSoapBinding *custBindng =  [SalesServiceSvc SalesServiceSvcSoapBinding] ;
//            SalesServiceSvc_getXZreports *aParameters = [[SalesServiceSvc_getXZreports alloc] init];
//
//            NSDate *today = [NSDate date];
//            NSDateFormatter *f = [[NSDateFormatter alloc] init];
//            f.dateFormat = @"dd/MM/yyyy HH:mm:ss";
//            NSString* currentdate = [f stringFromDate:today];
//
//            defaults = [NSUserDefaults standardUserDefaults];
//            NSString *businessDate = [NSString stringWithFormat:@"%@%@%@",[defaults valueForKey:BUSSINESS_DATE],@" ",[currentdate componentsSeparatedByString:@" "][1]];
//            NSArray *keys = @[@"counterId",@"cashierId",@"shiftId",@"reportDate",@"requestHeader",@"store_location",@"startIndex",@"reportType"];
//
//
//            NSArray *objects  = @[counterName,firstName,[NSString stringWithFormat:@"%@",shiftId],[NSString stringWithFormat:@"%@",businessDate],[RequestHeader getRequestHeader],presentLocation,@"0",reportType];
//
//            NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
//
//            NSError * err;
//            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
//            NSString * createBillingJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//            aParameters.searchCriteria = createBillingJsonString;
//            SalesServiceSvcSoapBindingResponse *response = [custBindng getXZreportsUsingParameters:aParameters];
//            if (![response isKindOfClass:[NSError class]]) {
//
//                NSArray *responseBodyParts = response.bodyParts;
//                for (id bodyPart in responseBodyParts) {
//                    if ([bodyPart isKindOfClass:[SalesServiceSvc_getXZreportsResponse class]]) {
//                        SalesServiceSvc_getXZreportsResponse *body = (SalesServiceSvc_getXZreportsResponse *)bodyPart;
//                        printf("\nresponse=%s",(body.return_).UTF8String);
//
//                        NSError *e;
//                        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                             options: NSJSONReadingMutableContainers
//                                                                               error: &e];
//                        if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue] == 0) {
//
//                            [self printReports:JSON reportType:reportType];
//
//                        }
//                        else {
//
//                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%@",[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                            [alert show];
//                        }
//
//                        //[HUD setHidden:YES];
//                    }
//                }
//            }
//            else {
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Failed to print the report" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                [alert show];
//            }
//
//        }
//        @catch (NSException *exception) {
//
//        }
//    }
//    else {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Please enable wifi/mobile data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    }
//}




//getXZReports: method changed by roja on 17/10/2019.. // reason :- removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST
-(void)getXZReports:(NSString*)reportType {
    
    reportTypeStr = @""; // added by roja on 17/10/2019..
    
    CheckWifi *WIFI = [[CheckWifi alloc]init];
    BOOL status = [WIFI checkWifi];
    if (status) {
        
        @try {
            
            [HUD setHidden:NO];
           
            reportTypeStr = reportType; // added by roja on 17/10/2019..
            
            NSDate *today = [NSDate date];
            NSDateFormatter *f = [[NSDateFormatter alloc] init];
            f.dateFormat = @"dd/MM/yyyy HH:mm:ss";
            NSString* currentdate = [f stringFromDate:today];
            
            defaults = [NSUserDefaults standardUserDefaults];
            NSString *businessDate = [NSString stringWithFormat:@"%@%@%@",[defaults valueForKey:BUSSINESS_DATE],@" ",[currentdate componentsSeparatedByString:@" "][1]];
            NSArray *keys = @[@"counterId",@"cashierId",@"shiftId",@"reportDate",@"requestHeader",@"store_location",@"startIndex",@"reportType"];
            
            NSArray *objects  = @[counterName,firstName,[NSString stringWithFormat:@"%@",shiftId],[NSString stringWithFormat:@"%@",businessDate],[RequestHeader getRequestHeader],presentLocation,@"0",reportType];
            
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            
            NSError * err;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
            NSString * createBillingJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            WebServiceController * services = [[WebServiceController alloc] init];
            services.salesServiceDelegate = self;
            [services getXZReports:createBillingJsonString];

        }
        @catch (NSException *exception) {
            
        }
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Please enable wifi/mobile data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

// added by Roja on 17/10/2019…. // Old Code only written here..
- (void)getXZReportSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        
        [self printReports:successDictionary reportType:reportTypeStr];
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}

// added by Roja on 17/10/2019…. // Old Code only written here..
- (void)getXZReportErrorResponse:(NSString *)errorResponse{
    
    @try {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:errorResponse message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
    
}



-(void)printReports:(NSDictionary *)response reportType:(NSString *)reportTye {
    
    
    if (printer) {
        
        [printer addObserver:self];
        
        PowaPrinterSettings *settings = [PowaPrinterSettings defaultSettings];
        settings.leftMargin = 5;
        settings.quality = 1;
        settings.speed = PowaPrinterSpeedAuto;
        [printer setPrinterSettings:settings];
        
        [printer startReceipt];
        NSString *str;
        if ([reportTye isEqualToString:@"x"]) {
            NSLog(@"report Type %@",reportTye);
            str = [self printXString:response];
            
        }
        else if ([reportTye isEqualToString:@"z"]) {
            NSLog(@"report Type %@",reportTye);
            
            str = [self printZString:response];
            [defaults setValue:@"0000" forKey:LAST_BILL_COUNT];
            [defaults setValue:@"0.00" forKey:LAST_BILL_TOTAL];
            
            NSDateFormatter *f = [[NSDateFormatter alloc] init];
            f.dateFormat = @"dd/MM/yyyy";
            
            if ([WebServiceUtility numberOfDaysDifference:[f dateFromString:[NSString stringWithFormat:@"%@",[defaults valueForKey:BUSSINESS_DATE]]]] < 1) {
                NSString *bussinessDate = [WebServiceUtility addDays:1 toDate:[f dateFromString:[NSString stringWithFormat:@"%@",[defaults valueForKey:BUSSINESS_DATE]]]];
                [defaults setValue:bussinessDate forKey:BUSSINESS_DATE];
                
            }
            
        }
        else if ([reportTye isEqualToString:@"xz"]) {
            NSLog(@"report Type %@",reportTye);
            
            str = [self printXZString:response];
            
            
        }
        // [printer printImage:[UIImage imageNamed:@"sampoorna.jpg"] threshold:0.5];
        //                [self.tseries printImage:[UIImage imageNamed:@"sampoorna.jpg"]];
        
        //        [printer printImage:[UIImage imageNamed:@"sahyadri_logo.png"] threshold:0.5];
        
        //added by Srinivasulu on 07/06/2017....
        
        NSUserDefaults *   defaults = [[NSUserDefaults alloc]init];
        
        if(([[defaults valueForKey:LOGO_URL] length] > 0) && (! [[defaults valueForKey:LOGO_URL]  isKindOfClass:[NSNull class]])){
            
            
            NSURL * url = [NSURL URLWithString:[defaults valueForKey:LOGO_URL]];
            
            
            //getting images usings Synchronous Calling....
            NSData *imgData = [NSData dataWithContentsOfURL:url];
            
            
            if (imgData != nil && [UIImage imageWithData:imgData] != nil) {
                
                
                [printer printImage:[UIImage imageWithData:imgData] threshold:0.5];
            }
            
        }
        
        //upto here on 02/06/2017....
        
        [printer printText:str];
        [printer printReceipt];
        
        
        
        
    }
    else {
        // NSString *str = [self printString:response];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Printer is not connected" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

-(NSString *)printXString:(NSDictionary *)Json {
    
    NSString *finalPrintMessage = @"";
    NSString *storeAddress = [WebServiceUtility getStoreAddress];
    
    NSDate *today = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"dd/MM/yyyy HH:mm:ss";
    NSString* currentdate = [f stringFromDate:today];
    
    
    NSString *header = [NSString stringWithFormat:@"#####%@",@"X-Reading Report"];
    header = [NSString stringWithFormat:@"%@%@\n",header,@"(Shift-End)"];
    header = [NSString stringWithFormat:@"%@%@\n",header,@"---------------------------------"];
    header = [NSString stringWithFormat:@"\n%@%@\n%@%@",header,currentdate,@"U :",firstName];
    header = [NSString stringWithFormat:@"\n%@%@%@\n",header,@"Shift   #",shiftId];
    header = [NSString stringWithFormat:@"\n%@%@%@\n",header,@"MODE : ",@"END-SHIFT"];
    header = [NSString stringWithFormat:@"%@%@",header,@"---------------------------------\n"];
    
    NSString *body;
    if (![Json[@"sales"] isKindOfClass:[NSNull class]]) {
        body = [NSString stringWithFormat:@"%@%@%@",@"Sales   (Inclusive TAX) ",@"Rs.###",[Json valueForKey:@"sales"]];
    }
    else {
        body = [NSString stringWithFormat:@"%@\n%@",@"Sales   (Inclusive TAX) ",@"Rs.###0.00"];
    }
    if (![Json[@"itemDiscount"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Item Discount        (-) Rs.###",[Json valueForKey:@"itemDiscount"]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Item Discount        (-) Rs.###0.00"];
    }
    if (![Json[@"overalDiscount"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@\n%@",body,@"Overall Discount    (-) Rs.###",[Json valueForKey:@"overalDiscount"]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Overall Discount    (-) Rs.###0.00"];
    }
    if (![Json[@"netSalesInclusiveTax"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Net Sales(Inclusive TAX) Rs.###",[[Json valueForKey:@"netSalesInclusiveTax"] stringValue]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Net Sales(Inclusive TAX) Rs.###0.00"];
    }
    if (![Json[@"netSalesExclusiveTax"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Net Sales(Exclusive TAX) Rs.###",[[Json valueForKey:@"netSalesExclusiveTax"] stringValue]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Net Sales(Exclusive TAX) Rs.###0.00"];
        
    }
    if (![Json[@"cess"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@\n%@",body,@"Cess   Rs.###",[Json valueForKey:@"cess"]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Cess   Rs.###0.00"];
    }
    if (![Json[@"serviceCharge"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@\n%@",body,@"Service Charge     Rs.###",[Json valueForKey:@"serviceCharge"]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Service Charge     Rs.###0.00"];
    }
    if (![Json[@"otherCharge"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@\n%@",body,@"Other Charge     Rs.###",[Json valueForKey:@"otherCharge"]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Other Charge     Rs.###0.00"];
    }
    if (![Json[@"tax"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@%@",body,@"TAX      Rs.###",[[Json valueForKey:@"tax"] stringValue]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"TAX      Rs.###0.00"];
    }
    if (![Json[@"taxExempted"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@\n%@",body,@"TAX Exempted     Rs.###",[Json valueForKey:@"taxExempted"]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"TAX Exempted     Rs.###0.00"];
    }
    if (![Json[@"totalSalesCollection"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Total Sales Collection     Rs.###",[[Json valueForKey:@"totalSalesCollection"] stringValue]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Total Sales Collection     Rs.###0.00"];
    }
    if (![Json[@"depositCollected"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@\n%@",body,@"Deposit Collected     Rs.###",[Json valueForKey:@"depositCollected"]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Deposit Collected     Rs.###0.00"];
    }
    if (![Json[@"depositRefunded"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@\n%@",body,@"Deposit Refunded     Rs.###",[Json valueForKey:@"depositRefunded"]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Deposit Refunded     Rs.###0.00"];
    }
    body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Deposit Forefeited     ",@"0"];
    if (![Json[@"depositesUtilized"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@\n%@",body,@"Deposit Utilised     Rs.###",[Json valueForKey:@"depositesUtilized"]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Deposit Utilised     Rs.###0.00"];
    }
    if (![Json[@"totalAmmountCollected"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@%@\n",body,@"Total Amount Collected     Rs.###",[[Json valueForKey:@"totalAmmountCollected"] stringValue]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Total Amount Collected     Rs.###0.00"];
    }
    
    NSString *footer = [NSString stringWithFormat:@"%@%@\n",@"Sales Receipts ",@"0"];
    if (![Json[@"trainingReceipts"] isKindOfClass:[NSNull class]]) {
        footer = [NSString stringWithFormat:@"%@%@%@\n",footer,@"Training Receipts  ",[[Json valueForKey:@"trainingReceipts"] stringValue]];
    }
    else {
        footer = [NSString stringWithFormat:@"%@%@\n",footer,@"Training Receipts  0"];
    }
    if (![Json[@"manualReceipts"] isKindOfClass:[NSNull class]]) {
        footer = [NSString stringWithFormat:@"%@%@%@\n",footer,@"Manual Receipts  ",[[Json valueForKey:@"manualReceipts"] stringValue]];
    }
    else {
        footer = [NSString stringWithFormat:@"%@%@\n",footer,@"Manual Receipts  0"];
    }
    if (![Json[@"depositeReceipts"] isKindOfClass:[NSNull class]]) {
        footer = [NSString stringWithFormat:@"%@%@%@\n\n\n",footer,@"Deposit Receipts  ",[[Json valueForKey:@"depositeReceipts"] stringValue]];
    }
    else {
        footer = [NSString stringWithFormat:@"%@%@\n\n\n",footer,@"Deposit Receipts  0"];
    }
    
    footer = [NSString stringWithFormat:@"%@%@%@\n",footer,@"Refund/Exchange#########",@"0"];
    
    
    NSString *totalNumbers = [NSString stringWithFormat:@"\n%@%@%@",@"No. of Items Sold############",[Json valueForKey:@"noOfItemsSold"],@"\n"];
    totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Void Items############",[Json valueForKey:@"noOfVoidItems"],@"\n"];
    totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of No sale Done##########",[Json valueForKey:@"noOfNoSaleDone"],@"\n"];
    totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Price Overrides#######",[Json valueForKey:@"noOfPriceOverrides"],@"\n"];
    totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Line Discount#########",[Json valueForKey:@"noOfLineDiscounts"],@"\n"];
    totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Customers#############",[Json valueForKey:@"noOfCustomers"],@"\n"];
    totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Deposit Collected#####",[Json valueForKey:@"noOfDepositCollected"],@"\n"];
    totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Deposit Refunded######",[Json valueForKey:@"noOfDepositRefunded"],@"\n"];
    if (![Json[@"depositForefeited"] isKindOfClass:[NSNull class]]) {
        totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Deposit Forefeited####",[Json valueForKey:@"depositForefeited"],@"\n"];
    }
    else {
        totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Deposit Forefeited####",@"0",@"\n"];
    }
    if (![Json[@"depositesUtilized"] isKindOfClass:[NSNull class]]) {
        totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Deposit Utilized######",[Json valueForKey:@"depositesUtilized"],@"\n"];
    }
    else {
        totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Deposit Utilized######",@"0",@"\n"];
    }
    
    totalNumbers = [NSString stringWithFormat:@"%@%@",totalNumbers,@"---------------------------------\n"];
    
    NSString *transString;
    if (![[Json valueForKey:@"cardTotal"] isKindOfClass:[NSNull class]]) {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@",@"CARD######",[Json valueForKey:@"cardTransactions"],@"  Rs.  ",[Json valueForKey:@"cardTotal"],@"\n\n"];
    }
    else {
        transString = [NSString stringWithFormat:@"%@%@%@%@",@"CARD######",[Json valueForKey:@"cardTransactions"],@"  Rs.  0.00",@"\n\n"];
    }
    if (![[Json valueForKey:@"cardTotal"] isKindOfClass:[NSNull class]]) {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"***Total Card######",[Json valueForKey:@"cardTransactions"],@"  Rs.  ",[Json valueForKey:@"cardTotal"],@"\n\n"];
    }
    else {
        transString = [NSString stringWithFormat:@"%@%@%@%@",transString,@"***Total Card######",[Json valueForKey:@"cardTransactions"],@"  Rs.  0.00\n\n"];
    }
    if (![[Json valueForKey:@"cashTotal"] isKindOfClass:[NSNull class]]) {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"CASH######",[Json valueForKey:@"cashtransactions"],@"  Rs.  ",[Json valueForKey:@"cashTotal"],@"\n\n"];
    }
    else {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"CASH######",[Json valueForKey:@"cashtransactions"],@"  Rs.  0.00",@"\n\n"];
    }
    if (![[Json valueForKey:@"cashTotal"] isKindOfClass:[NSNull class]]) {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"**Total Cash######",[Json valueForKey:@"cashtransactions"],@"  Rs.  ",[Json valueForKey:@"cashTotal"],@"\n\n"];
    }
    else {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"**Total Cash######",[Json valueForKey:@"cashtransactions"],@"  Rs.  0.00",@"\n\n"];
    }
    if (![[Json valueForKey:@"foodCouponsTotal"] isKindOfClass:[NSNull class]]) {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"SODEXO######",[Json valueForKey:@"foodCouponsTransactions"],@"  Rs.  ",[Json valueForKey:@"foodCouponsTotal"],@"\n\n"];
    }
    else {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"SODEXO######",[Json valueForKey:@"foodCouponsTransactions"],@"  Rs.  0.00",@"\n\n"];
    }
    if (![[Json valueForKey:@"foodCouponsTotal"] isKindOfClass:[NSNull class]]) {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"**Total Sodexo######",[Json valueForKey:@"foodCouponsTransactions"],@"  Rs.  ",[Json valueForKey:@"foodCouponsTotal"],@"\n\n"];
    }
    else {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"**Total Sodexo######",[Json valueForKey:@"foodCouponsTransactions"],@"  Rs.  0.00",@"\n\n"];
    }
    
    transString = [NSString stringWithFormat:@"%@%@",transString,@"---------------------------------\n"];
    
    NSString *taxInfo = @"";
    if (![Json[@"taxesInfo"] isKindOfClass:[NSNull class]]) {
        taxInfo = [NSString stringWithFormat:@"%@%@%@",@"Tax Code####",@"Percentage########",@"Amount\n"];
        for (NSDictionary *dic in Json[@"taxesInfo"]) {
            taxInfo = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",taxInfo,dic[@"taxCode"] ,@"##########",[dic[@"percentage"] stringValue],@"########",@"RS   ",[NSString stringWithFormat:@"%.2f",[dic[@"amount"] floatValue]],@"\n\n"];
        }
        taxInfo = [NSString stringWithFormat:@"%@%@",taxInfo,@"---------------------------------\n"];
    }
    if (![Json[@"taxTotal"] isKindOfClass:[NSNull class]]) {
        taxInfo = [NSString stringWithFormat:@"%@%@%@%@",taxInfo,@"#######Tax Total :  RS  ",[NSString stringWithFormat:@"%.2f",[Json[@"taxTotal"] floatValue]],@"\n"];
    }
    else {
        taxInfo = [NSString stringWithFormat:@"%@%@",taxInfo,@"#######Tax Total :  RS  0.00\n"];
    }
    taxInfo = [NSString stringWithFormat:@"%@%@",taxInfo,@"---------------------------------\n"];
    
    NSString *cashierInfo = [NSString stringWithFormat:@"%@%@%@",@"Cashier##",@"Incl Tax Sales ##",@"Excl Tax Sales\n\n"];
    if (![Json[@"netSalesInclusiveTax"] isKindOfClass:[NSNull class]]) {
        cashierInfo = [NSString stringWithFormat:@"%@%@%@%@%@",cashierInfo,firstName,@"#######",[Json valueForKey:@"netSalesInclusiveTax"],@"###"];
    }
    else {
        cashierInfo = [NSString stringWithFormat:@"%@%@%@%@",cashierInfo,firstName,@"#######0.00",@"###"];
    }
    if (![Json[@"netSalesExclusiveTax"] isKindOfClass:[NSNull class]]) {
        cashierInfo = [NSString stringWithFormat:@"%@%@%@%@",cashierInfo,@"###",Json[@"netSalesExclusiveTax"],@"\n"];
    }
    else {
        cashierInfo = [NSString stringWithFormat:@"%@%@",cashierInfo,@"###0.00\n"];
    }
    
    cashierInfo = [NSString stringWithFormat:@"%@%@",cashierInfo,@"---------------------------------\n"];
    
    if (![Json[@"netSalesInclusiveTax"] isKindOfClass:[NSNull class]]) {
        cashierInfo = [NSString stringWithFormat:@"%@%@%@%@%@",cashierInfo,@"Cashier Total :",@"#######",[Json valueForKey:@"netSalesInclusiveTax"],@"###"];
    }
    else {
        cashierInfo = [NSString stringWithFormat:@"%@%@%@%@",cashierInfo,@"Cashier Total :",@"#######0.00",@"###"];
    }
    if (![Json[@"netSalesExclusiveTax"] isKindOfClass:[NSNull class]]) {
        cashierInfo = [NSString stringWithFormat:@"%@%@%@%@",cashierInfo,@"###",Json[@"netSalesExclusiveTax"],@"\n"];
    }
    else {
        cashierInfo = [NSString stringWithFormat:@"%@%@",cashierInfo,@"###0.00\n"];
    }
    
    cashierInfo = [NSString stringWithFormat:@"%@\n%@",cashierInfo,@"---------------------------------\n"];
    
    NSString *currencyInfo = @"####*** Currency Declaration *** \n---------------------------------\n";
    currencyInfo = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",currencyInfo,@"No. ",@"Code ",@"Name ",@"DENOM ",@"Colle ",@"AMT "];
    if (![Json[@"denominations"] isKindOfClass:[NSNull class]]) {
        for (NSDictionary *dic in Json[@"denominations"]) {
            currencyInfo = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@",[dic[@"slNo"] stringValue],@"#",dic[@"currCode"] ,@"#",dic[@"currencyName"] ,@"#",[dic[@"denomination"] stringValue],@"#",[dic[@"collection"] stringValue],@"#",[dic[@"amount"] stringValue]];
        }
        currencyInfo = [NSString stringWithFormat:@"%@%@",currencyInfo,@"---------------------------------\n"];
    }
    currencyInfo = [NSString stringWithFormat:@"%@%@",currencyInfo,@"#######Open Balance :     0.00\n"];
    currencyInfo = [NSString stringWithFormat:@"%@%@%@%@",currencyInfo,@"#######Open Balance :     ",[Json valueForKey:@"systemSales"],@"\n"];
    currencyInfo = [NSString stringWithFormat:@"%@%@",currencyInfo,@"#######--------------------\n"];
    
    if (![[Json valueForKey:@"totalInwards"] isKindOfClass:[NSNull class]]) {
        
        currencyInfo = [NSString stringWithFormat:@"%@%@%@%@",currencyInfo,@"#######Total Inward :     ",[Json valueForKey:@"totalInwards"],@"\n"];
    }
    
    currencyInfo = [NSString stringWithFormat:@"%@%@",currencyInfo,@"#######--------------------\n"];
    currencyInfo = [NSString stringWithFormat:@"%@%@",currencyInfo,@"#######--------------------\n"];
    if (![[Json valueForKey:@"totalOutwards"] isKindOfClass:[NSNull class]]) {
        currencyInfo = [NSString stringWithFormat:@"%@%@%@%@",currencyInfo,@"#######Total Outward :     ",[Json valueForKey:@"totalOutwards"],@"\n"];
    }
    
    currencyInfo = [NSString stringWithFormat:@"%@%@",currencyInfo,@"#######--------------------\n"];
    if (![[Json valueForKey:@"systemSales"] isKindOfClass:[NSNull class]]) {
        currencyInfo = [NSString stringWithFormat:@"%@%@%@%@",currencyInfo,@"#######System Toatl :     ",[Json valueForKey:@"systemSales"],@"\n"];
    }
    
    
    currencyInfo = [NSString stringWithFormat:@"%@%@%@%@",currencyInfo,@"#####Collection short by :     ",@"0.00",@"\n"];
    
    currencyInfo = [NSString stringWithFormat:@"%@%@",currencyInfo,@"#######--------------------\n"];
    
    
    NSString *excessDetails= @"####*** Short Excess Details *** \n---------------------------------\n";
    
    excessDetails = [NSString stringWithFormat:@"%@%@%@%@%@",excessDetails,@"Pay Group ",@"System Amount ",@"Declare Amount ",@"Diff Amount "];
    excessDetails = [NSString stringWithFormat:@"%@%@",excessDetails,@"---------------------------------\n"];
    
    excessDetails = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@",excessDetails,@"CARD",@"#",[Json valueForKey:@"cardTotal"],@"#",@"0.00",@"#",@"0.00",@"#",@"\n"];
    excessDetails = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@",excessDetails,@"CASH",@"#",[Json valueForKey:@"cashTotal"],@"#",@"0.00",@"#",@"0.00",@"#",@"\n"];
    excessDetails = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@",excessDetails,@"SODEX",@"#",[Json valueForKey:@"foodCouponsTotal"],@"#",@"0.00",@"#",@"0.00",@"#",@"\n"];
    excessDetails = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@",excessDetails,@"TICKT",@"#",@"0.00",@"#",@"0.00",@"#",@"0.00",@"#",@"\n"];
    
    excessDetails = [NSString stringWithFormat:@"%@%@",excessDetails,@"---------------------------------\n"];
    excessDetails = [NSString stringWithFormat:@"%@%@%@%.2f%@%@%@%@%@%@",excessDetails,@"Total :",@"#",([[Json valueForKey:@"cashTotal"] floatValue]+[[Json valueForKey:@"cardTotal"] floatValue]+[[Json valueForKey:@"foodCouponsTotal"] floatValue]+0.0),@"#",@"0.00",@"#",@"0.00",@"#",@"\n"];
    
    excessDetails = [NSString stringWithFormat:@"%@%@",excessDetails,@"#######Declared Total :     0.00\n"];
    excessDetails = [NSString stringWithFormat:@"%@%@%@%@",excessDetails,@"#######System Total :     ",[Json valueForKey:@"systemSales"],@"\n"];
    excessDetails = [NSString stringWithFormat:@"%@%@",excessDetails,@"#######--------------------\n"];
    excessDetails = [NSString stringWithFormat:@"%@%@%@%@",excessDetails,@"#######Short By :     ",@"0.00",@"\n"];
    excessDetails = [NSString stringWithFormat:@"%@%@",excessDetails,@"---------------------------------\n"];
    
    NSString *endStr = @"<End of report>";
    
    finalPrintMessage = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@\n\n\n\n\n",storeAddress,header,body,footer,totalNumbers,transString,taxInfo,cashierInfo,currencyInfo,excessDetails,endStr];
    finalPrintMessage = [finalPrintMessage stringByReplacingOccurrencesOfString:@"#" withString:@" "];
    return finalPrintMessage;
    
}

-(NSString *)printZString:(NSDictionary *)Json {
    
    NSString *finalPrintMessage = @"";
    NSString *storeAddress = [WebServiceUtility getStoreAddress];
    
    NSDate *today = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"dd/MM/yyyy HH:mm:ss";
    NSString* currentdate = [f stringFromDate:today];
    
    
    
    NSString *header = [NSString stringWithFormat:@"%@\n",@"---------------------------------"];
    header = [NSString stringWithFormat:@"\n%@%@\n%@%@",header,currentdate,@"U :",firstName];
    header = [NSString stringWithFormat:@"\n%@%@\n",header,@"Z-Readings Report"];
    header = [NSString stringWithFormat:@"\n%@%@%@\n",header,@"MODE : ",@"END-DAY"];
    header = [NSString stringWithFormat:@"%@%@",header,@"---------------------------------\n"];
    
    NSString *body;
    if (![Json[@"sales"] isKindOfClass:[NSNull class]]) {
        body = [NSString stringWithFormat:@"%@%@%@",@"Sales   (Inclusive TAX) ",@"Rs.###",[Json valueForKey:@"sales"]];
    }
    else {
        body = [NSString stringWithFormat:@"%@\n%@",@"Sales   (Inclusive TAX) ",@"Rs.###0.00"];
    }
    if (![Json[@"itemDiscount"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Item Discount        (-) Rs.###",[Json valueForKey:@"itemDiscount"]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Item Discount        (-) Rs.###0.00"];
    }
    if (![Json[@"overalDiscount"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Overall Discount    (-) Rs.###",[Json valueForKey:@"overalDiscount"]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@",body,@"Overall Discount    (-) Rs.###0.00"];
    }
    if (![Json[@"netSalesInclusiveTax"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Net Sales(Inclusive TAX) Rs.###",[[Json valueForKey:@"netSalesInclusiveTax"] stringValue]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Net Sales(Inclusive TAX) Rs.###0.00"];
    }
    if (![Json[@"netSalesExclusiveTax"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Net Sales(Exclusive TAX) Rs.###",[[Json valueForKey:@"netSalesExclusiveTax"] stringValue]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Net Sales(Exclusive TAX) Rs.###0.00"];
        
    }
    if (![Json[@"cess"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Cess   Rs.###",[Json valueForKey:@"cess"]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Cess   Rs.###0.00"];
    }
    if (![Json[@"serviceCharge"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Service Charge     Rs.###",[Json valueForKey:@"serviceCharge"]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Service Charge     Rs.###0.00"];
    }
    if (![Json[@"otherCharge"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Other Charge     Rs.###",[Json valueForKey:@"otherCharge"]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Other Charge     Rs.###0.00"];
    }
    if (![Json[@"tax"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@%@",body,@"TAX      Rs.###",[[Json valueForKey:@"tax"] stringValue]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"TAX      Rs.###0.00"];
    }
    if (![Json[@"taxExempted"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@%@",body,@"TAX Exempted     Rs.###",[Json valueForKey:@"taxExempted"]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"TAX Exempted     Rs.###0.00"];
    }
    if (![Json[@"totalSalesCollection"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Total Sales Collection     Rs.###",[[Json valueForKey:@"totalSalesCollection"] stringValue]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Total Sales Collection     Rs.###0.00"];
    }
    if (![Json[@"depositCollected"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Deposit Collected     Rs.###",[Json valueForKey:@"depositCollected"]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Deposit Collected     Rs.###0.00"];
    }
    if (![Json[@"depositRefunded"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Deposit Refunded     Rs.###",[Json valueForKey:@"depositRefunded"]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Deposit Refunded     Rs.###0.00"];
    }
    body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Deposit Forefeited     ",@"0"];
    if (![Json[@"depositesUtilized"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@\n%@",body,@"Deposit Utilised     Rs.###",[Json valueForKey:@"depositesUtilized"]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Deposit Utilised     Rs.###0.00"];
    }
    if (![Json[@"totalAmmountCollected"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@%@%@",body,@"Total Amount Collected     Rs.###",[[Json valueForKey:@"totalAmmountCollected"] stringValue],@"\n"];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Total Amount Collected     Rs.###0.00"];
    }
    
    NSString *footer;
    if (![Json[@"salesReports"] isKindOfClass:[NSNull class]]) {
        footer = [NSString stringWithFormat:@"\n%@%@\n",@"Sales Receipts ",Json[@"salesReports"]];
    }
    else {
        footer = [NSString stringWithFormat:@"\n%@%@\n",@"Sales Receipts ",@"0"];
        
    }
    if (![Json[@"trainingReceipts"] isKindOfClass:[NSNull class]]) {
        footer = [NSString stringWithFormat:@"%@%@%@\n",footer,@"Training Receipts  ",[[Json valueForKey:@"trainingReceipts"] stringValue]];
    }
    else {
        footer = [NSString stringWithFormat:@"%@%@\n",footer,@"Training Receipts  0"];
    }
    if (![Json[@"manualReceipts"] isKindOfClass:[NSNull class]]) {
        footer = [NSString stringWithFormat:@"%@%@%@\n",footer,@"Manual Receipts  ",[[Json valueForKey:@"manualReceipts"] stringValue]];
    }
    else {
        footer = [NSString stringWithFormat:@"%@%@\n",footer,@"Manual Receipts  0"];
    }
    if (![Json[@"depositeReceipts"] isKindOfClass:[NSNull class]]) {
        footer = [NSString stringWithFormat:@"%@%@%@\n\n\n",footer,@"Deposit Receipts  ",[[Json valueForKey:@"depositeReceipts"] stringValue]];
    }
    else {
        footer = [NSString stringWithFormat:@"%@%@\n\n\n",footer,@"Deposit Receipts  0"];
    }
    
    footer = [NSString stringWithFormat:@"%@%@%@\n",footer,@"Refund/Exchange#########",@"0"];
    
    
    NSString *totalNumbers = [NSString stringWithFormat:@"\n%@%@%@",@"No. of Items Sold############",[Json valueForKey:@"noOfItemsSold"],@"\n"];
    totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Void Items############",[Json valueForKey:@"noOfVoidItems"],@"\n"];
    totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of No sale Done##########",[Json valueForKey:@"noOfNoSaleDone"],@"\n"];
    totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Price Overrides#######",[Json valueForKey:@"noOfPriceOverrides"],@"\n"];
    totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Line Discount#########",[Json valueForKey:@"noOfLineDiscounts"],@"\n"];
    totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Customers#############",[Json valueForKey:@"noOfCustomers"],@"\n"];
    totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Deposit Collected#####",[Json valueForKey:@"noOfDepositCollected"],@"\n"];
    totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Deposit Refunded######",[Json valueForKey:@"noOfDepositRefunded"],@"\n"];
    if (![Json[@"depositForefeited"] isKindOfClass:[NSNull class]]) {
        totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Deposit Forefeited####",[Json valueForKey:@"depositForefeited"],@"\n"];
    }
    else {
        totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Deposit Forefeited####",@"0",@"\n"];
    }
    if (![Json[@"depositesUtilized"] isKindOfClass:[NSNull class]]) {
        totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Deposit Utilized######",[Json valueForKey:@"depositesUtilized"],@"\n"];
    }
    else {
        totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Deposit Utilized######",@"0",@"\n"];
    }
    
    totalNumbers = [NSString stringWithFormat:@"%@%@",totalNumbers,@"---------------------------------\n"];
    
    NSString *transString;
    if (![[Json valueForKey:@"cardTotal"] isKindOfClass:[NSNull class]]) {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@",@"CARD######",[Json valueForKey:@"cardTransactions"],@"  Rs.  ",[Json valueForKey:@"cardTotal"],@"\n\n"];
    }
    else {
        transString = [NSString stringWithFormat:@"%@%@%@%@",@"CARD######",[Json valueForKey:@"cardTransactions"],@"  Rs.  0.00",@"\n\n"];
    }
    if (![[Json valueForKey:@"cardTotal"] isKindOfClass:[NSNull class]]) {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"***Total Card######",[Json valueForKey:@"cardTransactions"],@"  Rs.  ",[Json valueForKey:@"cardTotal"],@"\n\n"];
    }
    else {
        transString = [NSString stringWithFormat:@"%@%@%@%@",transString,@"***Total Card######",[Json valueForKey:@"cardTransactions"],@"  Rs.  0.00\n\n"];
    }
    if (![[Json valueForKey:@"cashTotal"] isKindOfClass:[NSNull class]]) {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"CASH######",[Json valueForKey:@"cashtransactions"],@"  Rs.  ",[Json valueForKey:@"cashTotal"],@"\n\n"];
    }
    else {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"CASH######",[Json valueForKey:@"cashtransactions"],@"  Rs.  0.00",@"\n\n"];
    }
    if (![[Json valueForKey:@"cashTotal"] isKindOfClass:[NSNull class]]) {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"**Total Cash######",[Json valueForKey:@"cashtransactions"],@"  Rs.  ",[Json valueForKey:@"cashTotal"],@"\n\n"];
    }
    else {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"**Total Cash######",[Json valueForKey:@"cashtransactions"],@"  Rs.  0.00",@"\n\n"];
    }
    if (![[Json valueForKey:@"sodexoTotal"] isKindOfClass:[NSNull class]]) {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"SODEXO######",[Json valueForKey:@"sodexoTransactions"],@"  Rs.  ",[Json valueForKey:@"sodexoTotal"],@"\n\n"];
    }
    else {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"SODEXO######",[Json valueForKey:@"sodexoTransactions"],@"  Rs.  0.00",@"\n\n"];
    }
    if (![[Json valueForKey:@"sodexoTotal"] isKindOfClass:[NSNull class]]) {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"**Total Sodexo######",[Json valueForKey:@"sodexoTransactions"],@"  Rs.  ",[Json valueForKey:@"sodexoTotal"],@"\n\n"];
    }
    else {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"**Total Sodexo######",[Json valueForKey:@"sodexoTransactions"],@"  Rs.  0.00",@"\n\n"];
    }
    
    if (![[Json valueForKey:@"ticketTotal"] isKindOfClass:[NSNull class]]) {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"TICKET######",[Json valueForKey:@"ticketTransactions"],@"  Rs.  ",[Json valueForKey:@"ticketTotal"],@"\n\n"];
    }
    else {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"TICKET######",[Json valueForKey:@"ticketTransactions"],@"  Rs.  0.00",@"\n\n"];
    }
    if (![[Json valueForKey:@"ticketTotal"] isKindOfClass:[NSNull class]]) {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"**Total Ticket######",[Json valueForKey:@"ticketTransactions"],@"  Rs.  ",[Json valueForKey:@"ticketTotal"],@"\n\n"];
    }
    else {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"**Total Ticket######",[Json valueForKey:@"ticketTransactions"],@"  Rs.  0.00",@"\n\n"];
    }
    if (![[Json valueForKey:@"exchangeTotal"] isKindOfClass:[NSNull class]]) {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"**Exchange Deduc######",@"        Rs.  ",[Json valueForKey:@"exchangeTotal"],@"\n\n"];
    }
    else {
        transString = [NSString stringWithFormat:@"%@%@%@%@",transString,@"**Exchange Deduc######",@"  Rs.  0.00",@"\n\n"];
    }
    if (![[Json valueForKey:@"returnTotal"] isKindOfClass:[NSNull class]]) {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"**Return Deduc######",@"       Rs.  ",[Json valueForKey:@"returnTotal"],@"\n\n"];
    }
    else {
        transString = [NSString stringWithFormat:@"%@%@%@%@",transString,@"**Return Deduc######",@"        Rs.  0.00",@"\n\n"];
    }
    
    
    transString = [NSString stringWithFormat:@"%@%@",transString,@"---------------------------------\n"];
    
    
    
    NSString *voidList = @"";
    if (![Json[@"voidItems"] isKindOfClass:[NSNull class]]) {
        voidList = [NSString stringWithFormat:@"%@%@%@%@%@",@"Receipt####",@"Time##",@"Refund##",@"Void(Rs.)##",@"Discount\n"];
        for (NSDictionary *dic in Json[@"voidItems"]) {
            voidList = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@",voidList,dic[@"billId"] ,@"#",dic[@"time"] ,@"#",[[dic valueForKey:@"refund"] stringValue],@"#",[[dic valueForKey:@"voidAmount"] stringValue],@"#",[dic[@"discount"] stringValue],@"\n"];
        }
        voidList = [NSString stringWithFormat:@"%@%@",voidList,@"\n"];
    }
    
    
    if (![Json[@"discountTotal"] isKindOfClass:[NSNull class]]) {
        voidList = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",voidList,@"***Total#####",[Json valueForKey:@"refundTotal"],@"##",[Json valueForKey:@"voidItemsTotal"],@"##",[Json valueForKey:@"discountTotal"],@"\n"];
        
    }
    else {
        voidList = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",voidList,@"***#Total#####",[Json valueForKey:@"refundTotal"],@"##",[Json valueForKey:@"voidItemsTotal"],@"##",@"0.00",@"\n"];
    }
    voidList = [NSString stringWithFormat:@"%@%@",voidList,@"---------------------------------\n"];
    
    NSString *hourReport = @"";
    if (![Json[@"hourReports"] isKindOfClass:[NSNull class]]) {
        hourReport = [NSString stringWithFormat:@"%@%@%@%@",@"Hour####",@"Count####",@"Sales####",@"Sales%\n\n"];
        for (NSDictionary *dic in Json[@"hourReports"]) {
            hourReport = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",hourReport,dic[@"hour"] ,@"#####",[dic[@"count"] stringValue] ,@"####",[[dic valueForKey:@"sales"] stringValue],@"####",[[dic valueForKey:@"salesPercentage"] stringValue],@"\n"];
        }
        hourReport = [NSString stringWithFormat:@"%@%@",hourReport,@"\n\n"];
    }
    
    
    hourReport = [NSString stringWithFormat:@"%@%@",hourReport,@"---------------------------------\n"];
    
    
    
    NSString *endStr = @"<End of report>";
    
    finalPrintMessage = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@\n\n\n\n\n",storeAddress,header,body,footer,totalNumbers,transString,voidList,hourReport,endStr];
    finalPrintMessage = [finalPrintMessage stringByReplacingOccurrencesOfString:@"#" withString:@" "];
    return finalPrintMessage;
    
}
-(NSString*)printXZString:(NSDictionary *)Json {
    
    NSString *finalPrintMessage = @"";
    NSString *storeAddress = [WebServiceUtility getStoreAddress];
    
    NSDate *today = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"dd/MM/yyyy HH:mm:ss";
    NSString* currentdate = [f stringFromDate:today];
    
    
    
    NSString *header = [NSString stringWithFormat:@"%@\n",@"---------------------------------"];
    header = [NSString stringWithFormat:@"\n%@%@\n%@%@",header,currentdate,@"U :",firstName];
    header = [NSString stringWithFormat:@"\n%@%@\n",header,@"Z-Readings Report (Consolidated)"];
    header = [NSString stringWithFormat:@"\n%@%@%@\n",header,@"MODE : ",@"END-DAY"];
    header = [NSString stringWithFormat:@"%@%@",header,@"---------------------------------\n"];
    
    NSString *body;
    if (![Json[@"sales"] isKindOfClass:[NSNull class]]) {
        body = [NSString stringWithFormat:@"%@%@%@",@"Sales   (Inclusive TAX) ",@"Rs.###",[Json valueForKey:@"sales"]];
    }
    else {
        body = [NSString stringWithFormat:@"%@\n%@",@"Sales   (Inclusive TAX) ",@"Rs.###0.00"];
    }
    if (![Json[@"itemDiscount"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Item Discount        (-) Rs.###",[Json valueForKey:@"itemDiscount"]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Item Discount        (-) Rs.###0.00"];
    }
    if (![Json[@"overalDiscount"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Overall Discount    (-) Rs.###",[Json valueForKey:@"overalDiscount"]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@",body,@"Overall Discount    (-) Rs.###0.00"];
    }
    if (![Json[@"netSalesInclusiveTax"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Net Sales(Inclusive TAX) Rs.###",[[Json valueForKey:@"netSalesInclusiveTax"] stringValue]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Net Sales(Inclusive TAX) Rs.###0.00"];
    }
    if (![Json[@"netSalesExclusiveTax"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Net Sales(Exclusive TAX) Rs.###",[[Json valueForKey:@"netSalesExclusiveTax"] stringValue]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Net Sales(Exclusive TAX) Rs.###0.00"];
        
    }
    if (![Json[@"cess"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Cess   Rs.###",[Json valueForKey:@"cess"]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Cess   Rs.###0.00"];
    }
    if (![Json[@"serviceCharge"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Service Charge     Rs.###",[Json valueForKey:@"serviceCharge"]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Service Charge     Rs.###0.00"];
    }
    if (![Json[@"otherCharge"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Other Charge     Rs.###",[Json valueForKey:@"otherCharge"]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Other Charge     Rs.###0.00"];
    }
    if (![Json[@"tax"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@%@",body,@"TAX      Rs.###",[[Json valueForKey:@"tax"] stringValue]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"TAX      Rs.###0.00"];
    }
    if (![Json[@"taxExempted"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@%@",body,@"TAX Exempted     Rs.###",[Json valueForKey:@"taxExempted"]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"TAX Exempted     Rs.###0.00"];
    }
    if (![Json[@"totalSalesCollection"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Total Sales Collection     Rs.###",[[Json valueForKey:@"totalSalesCollection"] stringValue]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Total Sales Collection     Rs.###0.00"];
    }
    if (![Json[@"depositCollected"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Deposit Collected     Rs.###",[Json valueForKey:@"depositCollected"]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Deposit Collected     Rs.###0.00"];
    }
    if (![Json[@"depositRefunded"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Deposit Refunded     Rs.###",[Json valueForKey:@"depositRefunded"]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Deposit Refunded     Rs.###0.00"];
    }
    body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Deposit Forefeited     ",@"0"];
    if (![Json[@"depositesUtilized"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@\n%@",body,@"Deposit Utilised     Rs.###",[Json valueForKey:@"depositesUtilized"]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Deposit Utilised     Rs.###0.00"];
    }
    if (![Json[@"totalAmmountCollected"] isKindOfClass:[NSNull class]]) {
        body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Total Amount Collected     Rs.###",[[Json valueForKey:@"totalAmmountCollected"] stringValue]];
    }
    else {
        body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Total Amount Collected     Rs.###0.00"];
    }
    
    
    NSString *footer = [NSString stringWithFormat:@"%@%@\n",@"Sales Receipts ",@"0"];
    if (![Json[@"trainingReceipts"] isKindOfClass:[NSNull class]]) {
        footer = [NSString stringWithFormat:@"%@%@%@\n",footer,@"Training Receipts  ",[[Json valueForKey:@"trainingReceipts"] stringValue]];
    }
    else {
        footer = [NSString stringWithFormat:@"%@%@\n",footer,@"Training Receipts  0"];
    }
    if (![Json[@"manualReceipts"] isKindOfClass:[NSNull class]]) {
        footer = [NSString stringWithFormat:@"%@%@%@\n",footer,@"Manual Receipts  ",[[Json valueForKey:@"manualReceipts"] stringValue]];
    }
    else {
        footer = [NSString stringWithFormat:@"%@%@\n",footer,@"Manual Receipts  0"];
    }
    if (![Json[@"depositeReceipts"] isKindOfClass:[NSNull class]]) {
        footer = [NSString stringWithFormat:@"%@%@%@\n\n\n",footer,@"Deposit Receipts  ",[[Json valueForKey:@"depositeReceipts"] stringValue]];
    }
    else {
        footer = [NSString stringWithFormat:@"%@%@\n\n\n",footer,@"Deposit Receipts  0"];
    }
    
    footer = [NSString stringWithFormat:@"%@%@%@\n",footer,@"Refund/Exchange#########",@"0"];
    
    
    NSString *totalNumbers = [NSString stringWithFormat:@"\n%@%@%@",@"No. of Items Sold############",[Json valueForKey:@"noOfItemsSold"],@"\n"];
    totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Void Items############",[Json valueForKey:@"noOfVoidItems"],@"\n"];
    totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of No sale Done##########",[Json valueForKey:@"noOfNoSaleDone"],@"\n"];
    totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Price Overrides#######",[Json valueForKey:@"noOfPriceOverrides"],@"\n"];
    totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Line Discount#########",[Json valueForKey:@"noOfLineDiscounts"],@"\n"];
    totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Customers#############",[Json valueForKey:@"noOfCustomers"],@"\n"];
    totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Deposit Collected#####",[Json valueForKey:@"noOfDepositCollected"],@"\n"];
    totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Deposit Refunded######",[Json valueForKey:@"noOfDepositRefunded"],@"\n"];
    if (![Json[@"depositForefeited"] isKindOfClass:[NSNull class]]) {
        totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Deposit Forefeited####",[Json valueForKey:@"depositForefeited"],@"\n"];
    }
    else {
        totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Deposit Forefeited####",@"0",@"\n"];
    }
    if (![Json[@"depositesUtilized"] isKindOfClass:[NSNull class]]) {
        totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Deposit Utilized######",[Json valueForKey:@"depositesUtilized"],@"\n"];
    }
    else {
        totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Deposit Utilized######",@"0",@"\n"];
    }
    
    totalNumbers = [NSString stringWithFormat:@"%@%@",totalNumbers,@"---------------------------------\n"];
    
    NSString *transString;
    if (![[Json valueForKey:@"cardTotal"] isKindOfClass:[NSNull class]]) {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@",@"CARD######",[Json valueForKey:@"cardTransactions"],@"  Rs.  ",[Json valueForKey:@"cardTotal"],@"\n\n"];
    }
    else {
        transString = [NSString stringWithFormat:@"%@%@%@%@",@"CARD######",[Json valueForKey:@"cardTransactions"],@"  Rs.  0.00",@"\n\n"];
    }
    if (![[Json valueForKey:@"cardTotal"] isKindOfClass:[NSNull class]]) {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"***Total Card######",[Json valueForKey:@"cardTransactions"],@"  Rs.  ",[Json valueForKey:@"cardTotal"],@"\n\n"];
    }
    else {
        transString = [NSString stringWithFormat:@"%@%@%@%@",transString,@"***Total Card######",[Json valueForKey:@"cardTransactions"],@"  Rs.  0.00\n\n"];
    }
    if (![[Json valueForKey:@"cashTotal"] isKindOfClass:[NSNull class]]) {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"CASH######",[Json valueForKey:@"cashtransactions"],@"  Rs.  ",[Json valueForKey:@"cashTotal"],@"\n\n"];
    }
    else {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"CASH######",[Json valueForKey:@"cashtransactions"],@"  Rs.  0.00",@"\n\n"];
    }
    if (![[Json valueForKey:@"cashTotal"] isKindOfClass:[NSNull class]]) {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"**Total Cash######",[Json valueForKey:@"cashtransactions"],@"  Rs.  ",[Json valueForKey:@"cashTotal"],@"\n\n"];
    }
    else {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"**Total Cash######",[Json valueForKey:@"cashtransactions"],@"  Rs.  0.00",@"\n\n"];
    }
    if (![[Json valueForKey:@"foodCouponsTotal"] isKindOfClass:[NSNull class]]) {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"SODEXO######",[Json valueForKey:@"foodCouponsTransactions"],@"  Rs.  ",[Json valueForKey:@"foodCouponsTotal"],@"\n\n"];
    }
    else {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"SODEXO######",[Json valueForKey:@"foodCouponsTransactions"],@"  Rs.  0.00",@"\n\n"];
    }
    if (![[Json valueForKey:@"foodCouponsTotal"] isKindOfClass:[NSNull class]]) {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"**Total Sodexo######",[Json valueForKey:@"foodCouponsTransactions"],@"  Rs.  ",[Json valueForKey:@"foodCouponsTotal"],@"\n\n"];
    }
    else {
        transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"**Total Sodexo######",[Json valueForKey:@"foodCouponsTransactions"],@"  Rs.  0.00",@"\n\n"];
    }
    
    transString = [NSString stringWithFormat:@"%@%@",transString,@"---------------------------------\n"];
    transString = [NSString stringWithFormat:@"%@%@",transString,@"---------------------------------\n"];
    
    NSString *receipt = @"***RECEIPTS-DEBTORS\n\n\n";
    receipt = [NSString stringWithFormat:@"%@%@",receipt,@"***RECEIPTS NO.  FROM        TO      0\n\n"];
    
    
    NSString *taxInfo = @"";
    if (![Json[@"taxesInfo"] isKindOfClass:[NSNull class]]) {
        taxInfo = [NSString stringWithFormat:@"%@%@%@",@"Tax Code####",@"Percentage########",@"Amount\n"];
        for (NSDictionary *dic in Json[@"taxesInfo"]) {
            taxInfo = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",taxInfo,dic[@"taxCode"] ,@"############",[dic[@"percentage"] stringValue],@"###########",@"RS   ",[dic[@"amount"] stringValue],@"\n\n"];
        }
        taxInfo = [NSString stringWithFormat:@"%@%@",taxInfo,@"---------------------------------\n"];
    }
    if (![Json[@"taxTotal"] isKindOfClass:[NSNull class]]) {
        taxInfo = [NSString stringWithFormat:@"%@%@%@%@",taxInfo,@"#######Tax Total :  RS  ",Json[@"taxTotal"],@"\n"];
    }
    else {
        taxInfo = [NSString stringWithFormat:@"%@%@",taxInfo,@"#######Tax Total :  RS  0.00\n"];
    }
    taxInfo = [NSString stringWithFormat:@"%@%@",taxInfo,@"---------------------------------\n"];
    
    
    NSString *endStr = @"<End of report>";
    
    finalPrintMessage = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@\n\n\n\n\n",storeAddress,header,body,footer,totalNumbers,transString,receipt,taxInfo,endStr];
    finalPrintMessage = [finalPrintMessage stringByReplacingOccurrencesOfString:@"#" withString:@" "];
    return finalPrintMessage;
    
}


- (void)tseriesDidFinishInitializing:(PowaTSeries *)tseries
{
    if(!printer)
    {
        // Get the connected TSeries devices
        NSArray *connectedTSeries = [PowaTSeries connectedDevices];
        
        // Select the first TSeries device available
        if(connectedTSeries.count)
        {
            printer = connectedTSeries[0];
            //            [printer addObserver:self];
            [powaPOS addPeripheral:printer];
        }
    }
    
    NSString *string = [NSString stringWithFormat:@"Initialized"];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Init"
                                                        message:string
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}
- (void)tseriesPrinterResult:(PowaTSeriesPrinterResult)result
{
    if(result == PowaTSeriesPrinterResultSuccessfull)
    {
        
    }
    if(result == PowaTSeriesPrinterResultErrorThermalMotor)
    {
        //        [self.overheatTimer invalidate];
        //        self.overheatTimer = nil;
        
        NSString *string = [NSString stringWithFormat:@"Printer Overheated"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                            message:string
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
    if(result == PowaTSeriesPrinterResultReady)
    {
        NSString *string = [NSString stringWithFormat:@"Ready"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Printer Result"
                                                            message:string
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma -mark denominationView

-(void)populateDenominationView {
    
    //    paymentView.hidden = YES;
    
    tensCount = 0;
    twentyCount = 0;
    fiftyCount = 0;
    hundredCount = 0;
    fiveHundredCount = 0;
    thousandCount = 0;
    oneCount = 0;
    twoCount = 0;
    fiveCount = 0;
    tenCoinCount = 0;
    
    denominationDic = [[NSMutableDictionary alloc]init];
    
    
    denomination = [[NSBundle mainBundle]loadNibNamed:@"DenominationView" owner:self options:nil][0];
    denomination.hidden = NO;
    
    thousandValue = [[UILabel alloc]init];
    thousandValue.textColor = [UIColor whiteColor];
    thousandValue.text = @"0.00";
    
    fiveHundValue = [[UILabel alloc]init];
    fiveHundValue.textColor = [UIColor whiteColor];
    fiveHundValue.text = @"0.00";
    
    hundValue = [[UILabel alloc]init];
    hundValue.textColor = [UIColor whiteColor];
    hundValue.text = @"0.00";
    
    fiftyValue = [[UILabel alloc]init];
    fiftyValue.textColor = [UIColor whiteColor];
    fiftyValue.text = @"0.00";
    
    twentyValue = [[UILabel alloc]init];
    twentyValue.textColor = [UIColor whiteColor];
    twentyValue.text = @"0.00";
    
    tenValue = [[UILabel alloc]init];
    tenValue.textColor = [UIColor whiteColor];
    tenValue.text = @"0.00";
    
    fiveValue = [[UILabel alloc]init];
    fiveValue.textColor = [UIColor whiteColor];
    fiveValue.text = @"0.00";
    
    twoValue = [[UILabel alloc]init];
    twoValue.textColor = [UIColor whiteColor];
    twoValue.text = @"0.00";
    
    oneValue = [[UILabel alloc]init];
    oneValue.textColor = [UIColor whiteColor];
    oneValue.text = @"0.00";
    
    UILabel  *label = [[UILabel alloc] init] ;
    label.text = @"    Cash Denomination";
    label.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
    label.alpha = 1.0f;
    label.textAlignment = NSTextAlignmentLeft;
    label.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label.textColor = [UIColor whiteColor];
    
    // close button to close the view ..
    UIButton  *backbutton = [[UIButton alloc] init] ;
    [backbutton addTarget:self action:@selector(closeView:) forControlEvents:UIControlEventTouchUpInside];
    backbutton.tag = 0;
    
    UIImage *image = [UIImage imageNamed:@"delete.png"];
    [backbutton setBackgroundImage:image    forState:UIControlStateNormal];
    
    
    
    tensQty = [[CustomTextField alloc]init];
    tensQty.borderStyle = UITextBorderStyleRoundedRect;
    tensQty.textColor = [UIColor blackColor];
    tensQty.font = [UIFont systemFontOfSize:18.0];
    tensQty.backgroundColor = [UIColor whiteColor];
    tensQty.clearButtonMode = UITextFieldViewModeWhileEditing;
    tensQty.backgroundColor = [UIColor whiteColor];
    tensQty.keyboardType = UIKeyboardTypeNumberPad;
    tensQty.autocorrectionType = UITextAutocorrectionTypeNo;
    tensQty.layer.borderColor = [UIColor whiteColor].CGColor;
    tensQty.backgroundColor = [UIColor whiteColor];
    tensQty.delegate = self;
    // [tensQty awakeFromNib];
    
    twentyQty = [[CustomTextField alloc]init];
    twentyQty.borderStyle = UITextBorderStyleRoundedRect;
    twentyQty.textColor = [UIColor blackColor];
    twentyQty.font = [UIFont systemFontOfSize:18.0];
    twentyQty.backgroundColor = [UIColor whiteColor];
    twentyQty.clearButtonMode = UITextFieldViewModeWhileEditing;
    twentyQty.backgroundColor = [UIColor whiteColor];
    twentyQty.keyboardType = UIKeyboardTypeNumberPad;
    twentyQty.autocorrectionType = UITextAutocorrectionTypeNo;
    twentyQty.layer.borderColor = [UIColor whiteColor].CGColor;
    twentyQty.backgroundColor = [UIColor whiteColor];
    twentyQty.delegate = self;
    // [twentyQty awakeFromNib];
    
    fiftyQty = [[CustomTextField alloc]init];
    fiftyQty.borderStyle = UITextBorderStyleRoundedRect;
    fiftyQty.textColor = [UIColor blackColor];
    fiftyQty.font = [UIFont systemFontOfSize:18.0];
    fiftyQty.backgroundColor = [UIColor whiteColor];
    fiftyQty.keyboardType = UIKeyboardTypeNumberPad;
    fiftyQty.clearButtonMode = UITextFieldViewModeWhileEditing;
    fiftyQty.autocorrectionType = UITextAutocorrectionTypeNo;
    fiftyQty.layer.borderColor = [UIColor whiteColor].CGColor;
    fiftyQty.delegate = self;
    // [fiftyQty awakeFromNib];
    
    hundredQty = [[CustomTextField alloc]init];
    hundredQty.borderStyle = UITextBorderStyleRoundedRect;
    hundredQty.textColor = [UIColor blackColor];
    hundredQty.font = [UIFont systemFontOfSize:18.0];
    hundredQty.backgroundColor = [UIColor whiteColor];
    hundredQty.clearButtonMode = UITextFieldViewModeWhileEditing;
    hundredQty.backgroundColor = [UIColor whiteColor];
    hundredQty.keyboardType = UIKeyboardTypeNumberPad;
    hundredQty.autocorrectionType = UITextAutocorrectionTypeNo;
    hundredQty.layer.borderColor = [UIColor whiteColor].CGColor;
    hundredQty.backgroundColor = [UIColor whiteColor];
    hundredQty.delegate = self;
    //    [hundredQty awakeFromNib];
    
    fiveHundredQty = [[CustomTextField alloc]init];
    fiveHundredQty.borderStyle = UITextBorderStyleRoundedRect;
    fiveHundredQty.textColor = [UIColor blackColor];
    fiveHundredQty.font = [UIFont systemFontOfSize:18.0];
    fiveHundredQty.backgroundColor = [UIColor whiteColor];
    fiveHundredQty.clearButtonMode = UITextFieldViewModeWhileEditing;
    fiveHundredQty.backgroundColor = [UIColor whiteColor];
    fiveHundredQty.keyboardType = UIKeyboardTypeNumberPad;
    fiveHundredQty.autocorrectionType = UITextAutocorrectionTypeNo;
    fiveHundredQty.layer.borderColor = [UIColor whiteColor].CGColor;
    fiveHundredQty.backgroundColor = [UIColor whiteColor];
    fiveHundredQty.delegate = self;
    //    [fiveHundredQty awakeFromNib];
    
    thousandQty = [[CustomTextField alloc]init];
    thousandQty.borderStyle = UITextBorderStyleRoundedRect;
    thousandQty.textColor = [UIColor blackColor];
    thousandQty.font = [UIFont systemFontOfSize:18.0];
    thousandQty.backgroundColor = [UIColor whiteColor];
    thousandQty.clearButtonMode = UITextFieldViewModeWhileEditing;
    thousandQty.backgroundColor = [UIColor whiteColor];
    thousandQty.keyboardType = UIKeyboardTypeNumberPad;
    thousandQty.autocorrectionType = UITextAutocorrectionTypeNo;
    thousandQty.layer.borderColor = [UIColor whiteColor].CGColor;
    thousandQty.backgroundColor = [UIColor whiteColor];
    thousandQty.delegate = self;
    
    oneQty = [[CustomTextField alloc]init];
    oneQty.borderStyle = UITextBorderStyleRoundedRect;
    oneQty.textColor = [UIColor blackColor];
    oneQty.font = [UIFont systemFontOfSize:18.0];
    oneQty.backgroundColor = [UIColor whiteColor];
    oneQty.clearButtonMode = UITextFieldViewModeWhileEditing;
    oneQty.keyboardType = UIKeyboardTypeNumberPad;
    oneQty.autocorrectionType = UITextAutocorrectionTypeNo;
    oneQty.layer.borderColor = [UIColor whiteColor].CGColor;
    oneQty.delegate = self;
    // [fiftyQty awakeFromNib];
    
    twoQty = [[CustomTextField alloc]init];
    twoQty.borderStyle = UITextBorderStyleRoundedRect;
    twoQty.textColor = [UIColor blackColor];
    twoQty.font = [UIFont systemFontOfSize:18.0];
    twoQty.backgroundColor = [UIColor whiteColor];
    twoQty.clearButtonMode = UITextFieldViewModeWhileEditing;
    twoQty.keyboardType = UIKeyboardTypeNumberPad;
    twoQty.backgroundColor = [UIColor whiteColor];
    twoQty.autocorrectionType = UITextAutocorrectionTypeNo;
    twoQty.layer.borderColor = [UIColor whiteColor].CGColor;
    twoQty.backgroundColor = [UIColor whiteColor];
    twoQty.delegate = self;
    //    [hundredQty awakeFromNib];
    
    fiveQty = [[CustomTextField alloc]init];
    fiveQty.borderStyle = UITextBorderStyleRoundedRect;
    fiveQty.textColor = [UIColor blackColor];
    fiveQty.font = [UIFont systemFontOfSize:18.0];
    fiveQty.backgroundColor = [UIColor whiteColor];
    fiveQty.clearButtonMode = UITextFieldViewModeWhileEditing;
    fiveQty.keyboardType = UIKeyboardTypeNumberPad;
    fiveQty.backgroundColor = [UIColor whiteColor];
    fiveQty.autocorrectionType = UITextAutocorrectionTypeNo;
    fiveQty.layer.borderColor = [UIColor whiteColor].CGColor;
    fiveQty.backgroundColor = [UIColor whiteColor];
    fiveQty.delegate = self;
    //    [fiveHundredQty awakeFromNib];
    
    tenCoinQty = [[CustomTextField alloc]init];
    tenCoinQty.borderStyle = UITextBorderStyleRoundedRect;
    tenCoinQty.textColor = [UIColor blackColor];
    tenCoinQty.font = [UIFont systemFontOfSize:18.0];
    tenCoinQty.backgroundColor = [UIColor whiteColor];
    tenCoinQty.clearButtonMode = UITextFieldViewModeWhileEditing;
    tenCoinQty.backgroundColor = [UIColor whiteColor];
    tenCoinQty.autocorrectionType = UITextAutocorrectionTypeNo;
    tenCoinQty.layer.borderColor = [UIColor whiteColor].CGColor;
    tenCoinQty.backgroundColor = [UIColor whiteColor];
    tenCoinQty.delegate = self;
    
    UIButton   *continueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [continueBtn addTarget:self action:@selector(populateReportView) forControlEvents:UIControlEventTouchUpInside];
    [continueBtn setTitle:@"Continue"    forState:UIControlStateNormal];
    continueBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    continueBtn.titleLabel.textColor = [UIColor whiteColor];
    continueBtn.backgroundColor = [UIColor grayColor];
    
    UIButton   *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn addTarget:self action:@selector(closeView:) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setTitle:@"Back"    forState:UIControlStateNormal];
    closeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    closeBtn.titleLabel.textColor = [UIColor whiteColor];
    closeBtn.backgroundColor = [UIColor grayColor];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
            
            denomination.frame = CGRectMake(100, 80, 800, 650);
            label.frame = CGRectMake(0, 0, 800, 70);
            label.font = [UIFont systemFontOfSize:25];
            backbutton.frame = CGRectMake(740, 10.0, 45.0, 45.0);
            tensQty.frame = CGRectMake(540,280.0, 80, 25);
            tensQty.font = [UIFont boldSystemFontOfSize:20];
            
            twentyQty.frame = CGRectMake(540,240.0, 80, 25);
            twentyQty.font = [UIFont boldSystemFontOfSize:20];
            
            fiftyQty.frame = CGRectMake(540,205.0, 80, 25);
            fiftyQty.font = [UIFont boldSystemFontOfSize:20];
            
            hundredQty.frame = CGRectMake(540,170.0, 80, 25);
            hundredQty.font = [UIFont boldSystemFontOfSize:20];
            fiveHundredQty.frame = CGRectMake(540,130, 80, 25);
            fiveHundredQty.font = [UIFont boldSystemFontOfSize:20];
            thousandQty.frame = CGRectMake(540,90, 80, 25);
            thousandQty.font =[UIFont boldSystemFontOfSize:20];
            
            oneQty.frame = CGRectMake(540,390.0, 80, 25);
            oneQty.font = [UIFont boldSystemFontOfSize:20];
            twoQty.frame = CGRectMake(540,355.0, 80, 25);
            twoQty.font = [UIFont boldSystemFontOfSize:20];
            fiveQty.frame = CGRectMake(540,315.0, 80, 25);
            fiveQty.font =[UIFont boldSystemFontOfSize:20];
            tenCoinQty.frame = CGRectMake(450,460, 80, 20);
            tenCoinQty.font =[UIFont boldSystemFontOfSize:20];
            
            thousandValue.frame = CGRectMake(670.0, 96.0, 200.0, 20);
            thousandValue.font = [UIFont systemFontOfSize:17.0];
            fiveHundValue.frame = CGRectMake(670.0, 133.0, 200.0, 20);
            fiveHundValue.font = [UIFont systemFontOfSize:17.0];
            hundValue.frame = CGRectMake(670.0, 170.0, 200.0, 20);
            hundValue.font = [UIFont systemFontOfSize:17.0];
            fiftyValue.frame = CGRectMake(670.0, 207.0, 200.0, 20);
            fiftyValue.font = [UIFont systemFontOfSize:17.0];
            twentyValue.frame = CGRectMake(670.0, 244.0, 200.0, 20);
            twentyValue.font = [UIFont systemFontOfSize:17.0];
            tenValue.frame = CGRectMake(670.0, 281.0, 200.0, 20);
            tenValue.font = [UIFont systemFontOfSize:17.0];
            fiveValue.frame = CGRectMake(670.0, 318.0, 200.0, 20);
            fiveValue.font = [UIFont systemFontOfSize:17.0];
            twoValue.frame = CGRectMake(670.0, 355.0, 200.0, 20);
            twoValue.font = [UIFont systemFontOfSize:17.0];
            oneValue.frame = CGRectMake(670.0, 392.0, 200.0, 20);
            oneValue.font = [UIFont systemFontOfSize:17.0];
            
            
            paidVal.frame = CGRectMake(550, 530, 150, 30);
            paidVal.font = [UIFont boldSystemFontOfSize:20.0];
            
            
            
            changeReturnVal.frame = CGRectMake(550, 560, 150, 30);
            changeReturnVal.font = [UIFont boldSystemFontOfSize:20.0];
            
            
            
            continueBtn.frame = CGRectMake(100.0, 600, 250.0, 40);
            continueBtn.layer.cornerRadius = 10.0f;
            continueBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            
            closeBtn.frame = CGRectMake(450.0, 600, 250.0, 40);
            closeBtn.layer.cornerRadius = 10.0;
            closeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        }
    }
    denomination.layer.borderColor = [UIColor whiteColor].CGColor;
    denomination.layer.borderWidth = 1.0f;
    [denomination addSubview:label];
    [denomination addSubview:backbutton];
    [denomination addSubview:tensQty];
    [denomination addSubview:twentyQty];
    [denomination addSubview:fiftyQty];
    [denomination addSubview:hundredQty];
    [denomination addSubview:fiveHundredQty];
    [denomination addSubview:thousandQty];
    [denomination addSubview:thousandValue];
    [denomination addSubview:fiveHundValue];
    [denomination addSubview:hundValue];
    [denomination addSubview:fiftyValue];
    [denomination addSubview:twentyValue];
    [denomination addSubview:tenValue];
    [denomination addSubview:fiveValue];
    [denomination addSubview:twoValue];
    [denomination addSubview:oneValue];
    [denomination addSubview:paidVal];
    [denomination addSubview:oneQty];
    [denomination addSubview:twoQty];
    [denomination addSubview:fiveQty];
    
    
    [denomination addSubview:continueBtn];
    [denomination addSubview:closeBtn];
    
    
    [self.view addSubview:denomination];
    
}

- (IBAction)removeRupee:(UIButton *)sender {
    AudioServicesPlaySystemSound (soundFileObject);
    
    if (oneCount != 0) {
        oneCount--;
    }
    if (oneCount>=0) {
        if ([denominationDic valueForKey:@"1"]) {
            oneQty.text = [NSString stringWithFormat:@"%d",oneCount];
            oneValue.text = [NSString stringWithFormat:@"%.2f",(oneCount * 1.00)];
            
            
            
            [denominationDic setValue:[NSString stringWithFormat:@"%d",oneCount] forKey:@"1"];
            
        }
    }
}

- (IBAction)addRupee:(UIButton *)sender {
    AudioServicesPlaySystemSound (soundFileObject);
    
    oneCount++;
    oneQty.text = [NSString stringWithFormat:@"%d",oneCount];
    if (oneCount > 0) {
        [denominationDic setValue:[NSString stringWithFormat:@"%d",oneCount] forKey:@"1"];
        oneValue.text = [NSString stringWithFormat:@"%.2f",(oneCount * 1.00)];
    }
}

- (IBAction)removeTwo:(UIButton *)sender {
    AudioServicesPlaySystemSound (soundFileObject);
    
    if (twoCount != 0) {
        twoCount--;
    }
    if (twoCount>=0) {
        if ([denominationDic valueForKey:@"2"]) {
            twoQty.text = [NSString stringWithFormat:@"%d",twoCount];
            twoValue.text = [NSString stringWithFormat:@"%.2f",(twoCount * 2.00)];
            [denominationDic setValue:[NSString stringWithFormat:@"%d",twoCount] forKey:@"2"];
            
        }
    }
}

- (IBAction)addTwoCoin:(UIButton *)sender {
    AudioServicesPlaySystemSound (soundFileObject);
    
    twoCount++;
    twoQty.text = [NSString stringWithFormat:@"%d",twoCount];
    if (twoCount > 0) {
        [denominationDic setValue:[NSString stringWithFormat:@"%d",twoCount] forKey:@"2"];
        twoValue.text = [NSString stringWithFormat:@"%.2f",(twoCount * 2.00)];
    }
    
}

- (IBAction)removeFiveCoin:(UIButton *)sender {
    AudioServicesPlaySystemSound (soundFileObject);
    
    if (fiveCount != 0) {
        fiveCount--;
    }
    if (fiveCount>=0) {
        if ([denominationDic valueForKey:@"5"]) {
            fiveQty.text = [NSString stringWithFormat:@"%d",fiveCount];
            fiveValue.text = [NSString stringWithFormat:@"%.2f",(fiveCount * 5.00)];
            
            [denominationDic setValue:[NSString stringWithFormat:@"%d",fiveCount] forKey:@"5"];
            
        }
    }
}

- (IBAction)addFiveCoin:(UIButton *)sender {
    AudioServicesPlaySystemSound (soundFileObject);
    
    fiveCount++;
    fiveQty.text = [NSString stringWithFormat:@"%d",fiveCount];
    if (fiveCount > 0) {
        [denominationDic setValue:[NSString stringWithFormat:@"%d",fiveCount] forKey:@"5"];
        fiveValue.text = [NSString stringWithFormat:@"%.2f",(fiveCount * 5.00)];
    }
    
}

- (IBAction)removeTenCoin:(UIButton *)sender {
    AudioServicesPlaySystemSound (soundFileObject);
    
    if (tenCoinCount != 0) {
        tenCoinCount--;
    }
    if (tenCoinCount>=0) {
        if ([denominationDic valueForKey:@"10"]) {
            tenCoinQty.text = [NSString stringWithFormat:@"%d",tenCoinCount];
            tenValue.text = [NSString stringWithFormat:@"%.2f",(tenCoinCount * 10.00)];
        }
        if (tenCoinCount == 0) {
            [denominationDic removeObjectForKey:@"10"];
        }
        else {
            [denominationDic setValue:[NSString stringWithFormat:@"%d",tenCoinCount] forKey:@"10"];
        }
    }
}

- (IBAction)addTenCoin:(UIButton *)sender {
    AudioServicesPlaySystemSound (soundFileObject);
    
    if (!((changeReturnVal.text).floatValue > 0)) {
        tenCoinCount++;
        tenCoinQty.text = [NSString stringWithFormat:@"%d",tenCoinCount];
        if (tenCoinCount > 0) {
            [denominationDic setValue:[NSString stringWithFormat:@"%d",tenCoinCount] forKey:@"10"];
            tenValue.text = [NSString stringWithFormat:@"%.2f",(tenCoinCount * 10.00)];
        }
    }
    else {
        
        //  [self addLabel];
    }
}

- (IBAction)addHundred:(UIButton *)sender {
    AudioServicesPlaySystemSound (soundFileObject);
    
    hundredCount++;
    hundredQty.text = [NSString stringWithFormat:@"%d",hundredCount];
    if (hundredCount > 0) {
        [denominationDic setValue:[NSString stringWithFormat:@"%d",hundredCount] forKey:@"100"];
        hundValue.text = [NSString stringWithFormat:@"%.2f",(hundredCount * 100.00)];
    }
    
    
}

- (IBAction)removeHundred:(UIButton *)sender {
    AudioServicesPlaySystemSound (soundFileObject);
    
    if (hundredCount != 0) {
        hundredCount--;
    }
    //    hundredCount--;
    if (hundredCount>=0) {
        if ([denominationDic valueForKey:@"100"]) {
            hundredQty.text = [NSString stringWithFormat:@"%d",hundredCount];
            hundValue.text = [NSString stringWithFormat:@"%.2f",(hundredCount * 100.00)];
            
            if (hundredCount == 0) {
                [denominationDic removeObjectForKey:@"100"];
            }
            else {
                [denominationDic setValue:[NSString stringWithFormat:@"%d",hundredCount] forKey:@"100"];
            }
        }
        
    }
}

- (IBAction)addFiveHundred:(UIButton *)sender {
    AudioServicesPlaySystemSound (soundFileObject);
    
    fiveHundredCount++;
    fiveHundredQty.text = [NSString stringWithFormat:@"%d",fiveHundredCount];
    if (fiveHundredCount > 0) {
        [denominationDic setValue:[NSString stringWithFormat:@"%d",fiveHundredCount] forKey:@"500"];
        fiveHundValue.text = [NSString stringWithFormat:@"%.2f",(fiveHundredCount * 500.00)];
    }
    
}

- (IBAction)removeFiveHundred:(UIButton *)sender {
    AudioServicesPlaySystemSound (soundFileObject);
    if (fiveHundredCount != 0) {
        fiveHundredCount--;
    }
    if (fiveHundredCount>=0) {
        if ([denominationDic valueForKey:@"500"]) {
            fiveHundredQty.text = [NSString stringWithFormat:@"%d",fiveHundredCount];
            fiveHundValue.text = [NSString stringWithFormat:@"%.2f",(fiveHundredCount * 500.00)];
            
            if (fiveHundredCount == 0) {
                [denominationDic removeObjectForKey:@"500"];
            }
            else {
                [denominationDic setValue:[NSString stringWithFormat:@"%d",fiveHundredCount] forKey:@"500"];
            }
        }
    }
}

- (IBAction)addThousand:(UIButton *)sender {
    AudioServicesPlaySystemSound (soundFileObject);
    thousandCount++;
    thousandQty.text = [NSString stringWithFormat:@"%d",thousandCount];
    if (thousandCount > 0) {
        [denominationDic setValue:[NSString stringWithFormat:@"%d",thousandCount] forKey:@"2000"];
        thousandValue.text = [NSString stringWithFormat:@"%.2f",(thousandCount * 2000.00)];
    }
}


- (IBAction)removeThousand:(UIButton *)sender {
    AudioServicesPlaySystemSound (soundFileObject);
    if (thousandCount != 0) {
        thousandCount--;
    }
    if (thousandCount>=0) {
        if ([denominationDic valueForKey:@"2000"]) {
            thousandQty.text = [NSString stringWithFormat:@"%d",thousandCount];
            thousandValue.text = [NSString stringWithFormat:@"%.2f",(thousandCount * 2000.00)];
            if (thousandCount == 0) {
                [denominationDic removeObjectForKey:@"2000"];
            }
            else {
                [denominationDic setValue:[NSString stringWithFormat:@"%d",thousandCount] forKey:@"2000"];
            }
        }
    }
}

- (IBAction)addTens:(id)sender {
    AudioServicesPlaySystemSound (soundFileObject);
    
    tensCount++;
    tensQty.text = [NSString stringWithFormat:@"%d",tensCount];
    if (tensCount > 0) {
        [denominationDic setValue:[NSString stringWithFormat:@"%d",tensCount] forKey:@"10"];
        tenValue.text = [NSString stringWithFormat:@"%.2f",(tensCount * 10.00)];
    }
    
    
}

- (IBAction)removeTens:(id)sender {
    AudioServicesPlaySystemSound (soundFileObject);
    if (tensCount != 0) {
        tensCount--;
    }
    if (tensCount>=0) {
        if ([denominationDic valueForKey:@"10"]) {
            tensQty.text = [NSString stringWithFormat:@"%d",tensCount];
            tenValue.text = [NSString stringWithFormat:@"%.2f",(tensCount * 10.00)];
            
            if (tensCount == 0) {
                [denominationDic removeObjectForKey:@"10"];
            }
            else {
                [denominationDic setValue:[NSString stringWithFormat:@"%d",tensCount] forKey:@"10"];
            }
        }
    }
}

- (IBAction)addTwenty:(id)sender {
    AudioServicesPlaySystemSound (soundFileObject);
    twentyCount++;
    twentyQty.text = [NSString stringWithFormat:@"%d",twentyCount];
    if (twentyCount > 0) {
        [denominationDic setValue:[NSString stringWithFormat:@"%d",twentyCount] forKey:@"20"];
        twentyValue.text = [NSString stringWithFormat:@"%.2f",(twentyCount * 20.00)];
    }
}


- (IBAction)removeTwenty:(id)sender {
    AudioServicesPlaySystemSound (soundFileObject);
    if (twentyCount != 0) {
        twentyCount--;
    }
    if (twentyCount>=0) {
        if ([denominationDic valueForKey:@"20"]) {
            twentyQty.text = [NSString stringWithFormat:@"%d",twentyCount];
            twentyValue.text = [NSString stringWithFormat:@"%.2f",(twentyCount * 20.00)];
            if (twentyCount == 0) {
                [denominationDic removeObjectForKey:@"0"];
            }
            else {
                [denominationDic setValue:[NSString stringWithFormat:@"%d",twentyCount] forKey:@"20"];
            }
        }
    }
}

- (IBAction)addFifty:(UIButton *)sender {
    AudioServicesPlaySystemSound (soundFileObject);
    fiftyCount++;
    if (fiftyCount>=0) {
        
        fiftyQty.text = [NSString stringWithFormat:@"%d",fiftyCount];
        if (fiftyCount > 0) {
            [denominationDic setValue:[NSString stringWithFormat:@"%d",fiftyCount] forKey:@"50"];
            fiftyValue.text = [NSString stringWithFormat:@"%.2f",(fiftyCount * 50.00)];
        }
    }
    else {
        fiftyCount = 0;
        hundredQty.text = [NSString stringWithFormat:@"%d",fiftyCount];
        
    }
    
}

- (IBAction)removeFifty:(UIButton *)sender {
    AudioServicesPlaySystemSound (soundFileObject);
    if (fiftyCount != 0) {
        fiftyCount--;
    }
    if (fiftyCount>=0) {
        if ([denominationDic valueForKey:@"50"]) {
            fiftyQty.text = [NSString stringWithFormat:@"%d",fiftyCount];
            fiftyValue.text = [NSString stringWithFormat:@"%.2f",(fiftyCount * 50.00)];
            
            if (fiftyCount == 0) {
                [denominationDic removeObjectForKey:@"50"];
            }
            else {
                [denominationDic setValue:[NSString stringWithFormat:@"%d",fiftyCount] forKey:@"50"];
            }
        }
    }
}


-(NSArray *)prepareDenominationString:(NSString *)total{
    
    NSDate *today = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"dd/MM/yyyy HH:mm:ss";
    NSString* currentdate = [f stringFromDate:today];
    
    NSMutableArray *tempArr = [[NSMutableArray alloc]init];
    NSArray *keys = @[@"denomination",@"paidDenominationNo",@"transactionId",@"billId",@"billDate",@"paidAmount",@"returnAmount",@"returnDenominationNo"];
    @try {
        
        for (int i=0; i<denominationDic.allKeys.count; i++) {
            
            
            NSArray *objects = @[denominationDic.allKeys[i],[denominationDic valueForKey:denominationDic.allKeys[i]],@"",@"",currentdate,[NSString stringWithFormat:@"%.2f",[denominationDic.allKeys[i] floatValue]*[[denominationDic valueForKey:denominationDic.allKeys[i]] intValue]],@"0.00",@"0"];
            NSDictionary *dic = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            [tempArr addObject:dic];
            
        }
        
        //denominationCoinDic
        
        
        for (int i=0; i<denominationCoinDic.allKeys.count; i++) {
            
            
            NSArray *objects = @[denominationCoinDic.allKeys[i],[denominationCoinDic valueForKey:denominationCoinDic.allKeys[i]],@"",@"",currentdate,[NSString stringWithFormat:@"%.2f",[denominationCoinDic.allKeys[i] floatValue] * [[denominationCoinDic valueForKey:denominationCoinDic.allKeys[i]] intValue]],@"0.00",@"0"];
            NSDictionary *dic = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            
            [tempArr addObject:dic];
            
        }
        
        
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
    }
    
    
    
    return tempArr;
    
}
#pragma mark  End of Paying amount calculations -

-(void)validateDenomination:(UIButton*)sender {
    if (denominationDic.count==0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please provide the cash denomination" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        [self populateReportView];
    }
}

#pragma -mark reportView

-(void)populateReportView {
    
    
    reportView = [[NSBundle mainBundle]loadNibNamed:@"XReportView" owner:self options:nil][0];
    
    UILabel  *label = [[UILabel alloc] init] ;
    label.text = @"    Generate X-Report";
    label.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
    label.alpha = 0.8f;
    label.textAlignment = NSTextAlignmentLeft;
    label.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label.textColor = [UIColor whiteColor];
    
    
    cardTotalTxt = [[UITextField alloc]init];
    cardTotalTxt.borderStyle = UITextBorderStyleRoundedRect;
    cardTotalTxt.textColor = [UIColor blackColor];
    cardTotalTxt.font = [UIFont systemFontOfSize:18.0];
    cardTotalTxt.backgroundColor = [UIColor whiteColor];
    cardTotalTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    cardTotalTxt.backgroundColor = [UIColor whiteColor];
    cardTotalTxt.keyboardType = UIKeyboardTypeNumberPad;
    cardTotalTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    cardTotalTxt.layer.borderColor = [UIColor whiteColor].CGColor;
    cardTotalTxt.backgroundColor = [UIColor whiteColor];
    cardTotalTxt.delegate = self;
    cardTotalTxt.text = @"0.00";
    
    cashTotalTxt = [[UITextField alloc]init];
    cashTotalTxt.borderStyle = UITextBorderStyleRoundedRect;
    cashTotalTxt.textColor = [UIColor blackColor];
    cashTotalTxt.font = [UIFont systemFontOfSize:18.0];
    cashTotalTxt.backgroundColor = [UIColor whiteColor];
    cashTotalTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    cashTotalTxt.backgroundColor = [UIColor whiteColor];
    cashTotalTxt.keyboardType = UIKeyboardTypeNumberPad;
    cashTotalTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    cashTotalTxt.layer.borderColor = [UIColor whiteColor].CGColor;
    cashTotalTxt.backgroundColor = [UIColor whiteColor];
    cashTotalTxt.delegate = self;
    
    couponTotalTxt = [[UITextField alloc]init];
    couponTotalTxt.borderStyle = UITextBorderStyleRoundedRect;
    couponTotalTxt.textColor = [UIColor blackColor];
    couponTotalTxt.font = [UIFont systemFontOfSize:18.0];
    couponTotalTxt.backgroundColor = [UIColor whiteColor];
    couponTotalTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    couponTotalTxt.backgroundColor = [UIColor whiteColor];
    couponTotalTxt.keyboardType = UIKeyboardTypeNumberPad;
    couponTotalTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    couponTotalTxt.layer.borderColor = [UIColor whiteColor].CGColor;
    couponTotalTxt.backgroundColor = [UIColor whiteColor];
    couponTotalTxt.delegate = self;
    couponTotalTxt.text = @"0.00";
    
    ticketTotalTxt = [[UITextField alloc]init];
    ticketTotalTxt.borderStyle = UITextBorderStyleRoundedRect;
    ticketTotalTxt.textColor = [UIColor blackColor];
    ticketTotalTxt.font = [UIFont systemFontOfSize:18.0];
    ticketTotalTxt.backgroundColor = [UIColor whiteColor];
    ticketTotalTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    ticketTotalTxt.backgroundColor = [UIColor whiteColor];
    ticketTotalTxt.keyboardType = UIKeyboardTypeNumberPad;
    ticketTotalTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    ticketTotalTxt.layer.borderColor = [UIColor whiteColor].CGColor;
    ticketTotalTxt.backgroundColor = [UIColor whiteColor];
    ticketTotalTxt.delegate = self;
    ticketTotalTxt.text = @"0.00";
    
    
    generateReportBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    generateReportBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    generateReportBtn.layer.cornerRadius = 10.0f;
    generateReportBtn.layer.borderWidth = 1.0f;
    [generateReportBtn setTitle:@"Generate Report" forState:UIControlStateNormal];
    [generateReportBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    (generateReportBtn.titleLabel).font = [UIFont boldSystemFontOfSize:22.0];
    [generateReportBtn addTarget:self action:@selector(generateReport:) forControlEvents:UIControlEventTouchUpInside];
    
    cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    cancelBtn.layer.cornerRadius = 10.0f;
    cancelBtn.layer.borderWidth = 1.0f;
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    (cancelBtn.titleLabel).font = [UIFont boldSystemFontOfSize:22.0];
    [cancelBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    
    
    @try {
        
    } @catch (NSException *exception) {
        
    }
    
    transparentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    transparentView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6f];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
            
            cardTotalTxt.frame = CGRectMake(300, 66, 250, 35);
            couponTotalTxt.frame = CGRectMake(300, 135, 250, 35);
            ticketTotalTxt.frame = CGRectMake(300, 205, 250, 35);
            //            ticketTotalTxt.frame = CGRectMake(300, 275, 250, 35);
            generateReportBtn.frame = CGRectMake(100, 350, 250, 40);
            cancelBtn.frame = CGRectMake(380, 350, 150, 40);
            
            transparentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            label.frame = CGRectMake(0, 0, 600, 45);
            reportView.frame = CGRectMake(300, 150, 600, 450);
            
        }
    }
    reportView.layer.borderWidth = 1.0;
    reportView.layer.borderColor = [UIColor whiteColor].CGColor;
    [reportView addSubview:label];
    [reportView addSubview:cardTotalTxt];
    //    [reportView addSubview:cashTotalTxt];
    [reportView addSubview:couponTotalTxt];
    [reportView addSubview:ticketTotalTxt];
    [reportView addSubview:generateReportBtn];
    [reportView addSubview:cancelBtn];
    [transparentView addSubview:reportView];
    [self.view addSubview:transparentView];
    
    [UIView transitionFromView:denominationView
                        toView:reportView
                      duration:0.6
                       options:UIViewAnimationOptionTransitionFlipFromRight | UIViewAnimationOptionShowHideTransitionViews
                    completion:nil];
    
}

- (IBAction)generateReport:(UIButton *)sender {
    
    @try {
        
        [transparentView removeFromSuperview];
        
        NSMutableArray * enteredTenderArr = [NSMutableArray new];
        
        for(int i = 0; i < paymentModesArr.count; i++){
            
            if([paymentModesAmountArr[i] integerValue]){
                
                NSMutableDictionary * mutDic = [NSMutableDictionary new];
                
                [mutDic setValue:paymentModesArr[i] forKey:TENDER_NAME];
                [mutDic setValue:paymentModesAmountArr[i] forKey:DECLARED_AMOUNT];
                [mutDic setValue:@"0" forKey:DECLARED_NO_OF_COUPONS];
                
                [enteredTenderArr addObject:mutDic];
                //        [paymentModesArr addObject:[dic valueForKey:TENDER_NAME]];
                //        [paymentModesAmountArr addObject:@"0"];
            }
            
        }
        
        
        XReportController *report = [[XReportController alloc] initWithValues:cardTotalTxt.text cashTotal:cashTotalTxt.text coupon:couponTotalTxt.text ticket:ticketTotalTxt.text denomArr:[[self prepareDenominationString:@"0.00"] mutableCopy]];
        
        report.declaredTenderDeatailsArr = enteredTenderArr;
        
        [self.navigationController pushViewController:report animated:YES];
        
    } @catch (NSException *exception) {
        
    }
}
- (IBAction)cancel:(UIButton *)sender {
    
    if(tenderModesView != nil)
        tenderModesView.hidden = YES;
    
    [transparentView removeFromSuperview];
}

- (void)closeView:(UIButton *)sender {
    [denomination setHidden:YES];
    [denominationView removeFromSuperview];
}

-(void)deleteUploadedBillsFromLocal {
    
    NSMutableArray *billIdsArr=[NSMutableArray new];
    //    NSMutableArray *billDatesArr=[NSMutableArray new];
    BOOL isDeleted = NO;
    
    @try {
        
        NSString* dbPath = [DataBaseConnection connection:@"RetailerBillingDataBase.sqlite"];
        
        
        if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
            
            
            //        NSString *query = [NSString stringWithFormat:@"select * from sku_master where sku_id LIKE '%% %@ %%'",selected_SKID];
            
            NSString *query = [NSString stringWithFormat:@"select bill_id,date_and_time from billing_table where save_status=='%@'",SUCCESS];
            
            const char *sqlStatement = query.UTF8String;
            
            
            if(sqlite3_prepare_v2(database, sqlStatement, -1, &selectStmt, NULL) == SQLITE_OK) {
                //                        int count = sqlite3_column_count(selectStmt);
                while (sqlite3_step(selectStmt) == SQLITE_ROW) {
                    
                    // NSString  *skuId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStmt, 0)];
                    NSString  *bill_id = @((char *)sqlite3_column_text(selectStmt, 0));
                    NSString  *bill_date = @((char *)sqlite3_column_text(selectStmt,1));
                    [billIdsArr addObject:@{@"billId": bill_id,@"billDate": bill_date}];
                    //  [billDatesArr addObject:bill_date];
                }
            }
            else {
                NSLog(@"%s",sqlite3_errmsg(database)) ;
            }
            sqlite3_reset(selectStmt);
            sqlite3_finalize(selectStmt);
            
            sqlite3_close(database);
        }
        
        if (billIdsArr.count>0) {
            
            //compare the sync clear date in config...
            
            NSString *noOfDays;
            NSString *noOfHours;
            
            NSString* filePath = [[NSBundle mainBundle] pathForResource:@"Config"
                                                                 ofType:@"xml"];
            
            //    [document.XMLData writeToFile:@"/Users/chandrasekhar/Desktop/1.xml" atomically:YES];
            NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
            NSError *error;
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData
                                                                   options:0 error:&error];
            NSArray *ele=[doc.rootElement elementsForName:@"bills-clean"];
            
            for (GDataXMLElement *partyMember in ele) {
                NSArray *days = [partyMember elementsForName:@"days"];
                GDataXMLElement *nameValue = (GDataXMLElement *) days[0];
                NSArray *hours = [partyMember elementsForName:@"hours"];
                GDataXMLElement *hoursVal = (GDataXMLElement *) hours[0];
                noOfDays = [nameValue.stringValue copy];
                noOfHours = [hoursVal.stringValue copy];
            }
            
            for (NSDictionary *dic in billIdsArr) {
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                // this is imporant - we set our input date format to match our input string
                // if format doesn't match you'll get nil from your string, so be careful
                dateFormatter.dateFormat = @"dd/MM/yyyy HH:mm:ss";
                NSDate *dateFromString = [[NSDate alloc] init];
                // voila!
                dateFromString = [dateFormatter dateFromString:[dic valueForKey:@"billDate"]];
                int daysToAdd = noOfDays.intValue;
                NSDate *newDate1 = [dateFromString dateByAddingTimeInterval:60*60*24*daysToAdd];
                
                
                NSDate *now = [NSDate date];
                
                if ([now compare:newDate1]==NSOrderedDescending) {
                    if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
                        
                        if (deleteStmt == nil) {
                            NSString *query = [NSString stringWithFormat:@"delete from billing_table where bill_id='%@'",[dic valueForKey:@"billId"]];
                            const char *sqlStatement = query.UTF8String;
                            
                            if(sqlite3_prepare_v2(database, sqlStatement, -1, &deleteStmt, NULL) == SQLITE_OK) {
                                
                                if(SQLITE_DONE != sqlite3_step(deleteStmt)){
                                    isDeleted = NO;
                                    NSLog(@"%s",sqlite3_errmsg(database));
                                    NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(database));
                                }
                                else {
                                    isDeleted = YES;
                                    
                                }
                                sqlite3_reset(deleteStmt);
                                sqlite3_finalize(deleteStmt);
                            }
                            deleteStmt = nil;
                            
                        }
                        if (deleteStmt == nil) {
                            NSString *query = [NSString stringWithFormat:@"delete from billing_items where bill_id='%@'",[dic valueForKey:@"billId"]];
                            
                            const char *sqlStatement = query.UTF8String;
                            
                            if(sqlite3_prepare_v2(database, sqlStatement, -1, &deleteStmt, NULL) == SQLITE_OK) {
                                
                                if(SQLITE_DONE != sqlite3_step(deleteStmt)){
                                    NSLog(@"%s",sqlite3_errmsg(database));
                                    isDeleted = NO;
                                    NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(database));
                                }
                                else {
                                    isDeleted = YES;
                                }
                                sqlite3_reset(deleteStmt);
                                sqlite3_finalize(deleteStmt);
                            }
                            deleteStmt = nil;
                            
                        }
                        if (deleteStmt == nil) {
                            NSString *query = [NSString stringWithFormat:@"delete from billing_transactions where bill_id='%@'",[dic valueForKey:@"billId"]];
                            
                            const char *sqlStatement = query.UTF8String;
                            
                            if(sqlite3_prepare_v2(database, sqlStatement, -1, &deleteStmt, NULL) == SQLITE_OK) {
                                
                                if(SQLITE_DONE != sqlite3_step(deleteStmt)){
                                    isDeleted = NO;
                                    NSLog(@"%s",sqlite3_errmsg(database));
                                    NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(database));
                                }
                                else {
                                    isDeleted = YES;
                                }
                                sqlite3_reset(deleteStmt);
                                sqlite3_finalize(deleteStmt);
                            }
                            deleteStmt = nil;
                            
                        }
                        if (deleteStmt == nil) {
                            NSString *query = [NSString stringWithFormat:@"delete from billing_denomination where bill_id='%@'",[dic valueForKey:@"billId"]];
                            
                            const char *sqlStatement = query.UTF8String;
                            
                            if(sqlite3_prepare_v2(database, sqlStatement, -1, &deleteStmt, NULL) == SQLITE_OK) {
                                
                                if(SQLITE_DONE != sqlite3_step(deleteStmt)){
                                    isDeleted = NO;
                                    NSLog(@"%s",sqlite3_errmsg(database));
                                    NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(database));
                                }
                                else {
                                    isDeleted = YES;
                                }
                                sqlite3_reset(deleteStmt);
                                sqlite3_finalize(deleteStmt);
                            }
                            deleteStmt = nil;
                            
                        }
                        if (deleteStmt == nil) {
                            NSString *query = [NSString stringWithFormat:@"delete from billing_discounts where bill_id='%@'",[dic valueForKey:@"billId"]];
                            
                            const char *sqlStatement = query.UTF8String;
                            
                            if(sqlite3_prepare_v2(database, sqlStatement, -1, &deleteStmt, NULL) == SQLITE_OK) {
                                
                                if(SQLITE_DONE != sqlite3_step(deleteStmt)){
                                    isDeleted = NO;
                                    NSLog(@"%s",sqlite3_errmsg(database));
                                    NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(database));
                                }
                                else {
                                    isDeleted = YES;
                                }
                                sqlite3_reset(deleteStmt);
                                sqlite3_finalize(deleteStmt);
                            }
                            deleteStmt = nil;
                            
                        }
                        if (deleteStmt == nil) {
                            NSString *query = [NSString stringWithFormat:@"delete from billing_item_taxes where bill_id='%@'",[dic valueForKey:@"billId"]];
                            
                            const char *sqlStatement = query.UTF8String;
                            
                            if(sqlite3_prepare_v2(database, sqlStatement, -1, &deleteStmt, NULL) == SQLITE_OK) {
                                
                                if(SQLITE_DONE != sqlite3_step(deleteStmt)){
                                    isDeleted = NO;
                                    NSLog(@"%s",sqlite3_errmsg(database));
                                    NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(database));
                                }
                                else {
                                    isDeleted = YES;
                                }
                                sqlite3_reset(deleteStmt);
                                sqlite3_finalize(deleteStmt);
                            }
                            deleteStmt = nil;
                            
                        }
                        if (deleteStmt == nil) {
                            NSString *query = [NSString stringWithFormat:@"delete from billing_taxes where bill_id='%@'",[dic valueForKey:@"billId"]];
                            
                            const char *sqlStatement = query.UTF8String;
                            
                            if(sqlite3_prepare_v2(database, sqlStatement, -1, &deleteStmt, NULL) == SQLITE_OK) {
                                
                                if(SQLITE_DONE != sqlite3_step(deleteStmt)){
                                    isDeleted = NO;
                                    NSLog(@"%s",sqlite3_errmsg(database));
                                    NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(database));
                                }
                                else {
                                    isDeleted = YES;
                                }
                                sqlite3_reset(deleteStmt);
                                sqlite3_finalize(deleteStmt);
                            }
                            deleteStmt = nil;
                            
                        }
                    }
                    
                }
            }
            
        }
        
    }
    
    @catch (NSException *exception) {
        [HUD hide:YES afterDelay:2.0];
        NSLog(@"%@",exception);
        
    }
    @finally {
        sqlite3_close(database);
        deleteStmt = nil;
        //        selectStmt = nil;
        
    }
    
    
}

-(void)test {
    
    @try {
        
        NSString* dbPath = [DataBaseConnection connection:@"RetailerBillingDataBase.sqlite"];
        
        
        if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
            
            if (deleteStmt == nil) {
                NSString *query = [NSString stringWithFormat:@"alter table billing_table add column business_cycle_date text"];
                const char *sqlStatement = query.UTF8String;
                
                if(sqlite3_prepare_v2(database, sqlStatement, -1, &deleteStmt, NULL) == SQLITE_OK) {
                    
                    if(SQLITE_DONE != sqlite3_step(deleteStmt)){
                        NSLog(@"%s",sqlite3_errmsg(database));
                        NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(database));
                    }
                    
                    sqlite3_reset(deleteStmt);
                }
                deleteStmt = nil;
                
            }
            
        }
        
    }
    @catch (NSException *exception) {
        [HUD hide:YES afterDelay:2.0];
        NSLog(@"%@",exception);
        
        
    }
    @finally {
        sqlite3_close(database);
        deleteStmt = nil;
        selectStmt = nil;
        
    }
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [printer removeObserver:self];
}

-(void)dropTable:(NSString *)tableName {
    
    @try {
        NSString* dbPath = [DataBaseConnection connection:@"RetailerBillingDataBase.sqlite"];
        if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
            
            if (deleteStmt == nil) {
                
                NSString *query = [NSString stringWithFormat:@"drop table %@",tableName];
                
                const char *sqlStatement = query.UTF8String;
                
                if(sqlite3_prepare_v2(database, sqlStatement, -1, &deleteStmt, NULL) == SQLITE_OK) {
                    
                    if(SQLITE_DONE != sqlite3_step(deleteStmt))
                        NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(database));
                    
                    sqlite3_reset(deleteStmt);
                }
                
            }
            
        }
        deleteStmt = nil;
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        sqlite3_close(database);
        deleteStmt = nil;
    }
    
}

#pragma alter query

-(void)alterTable:(NSString*)tableName column:(NSString*)coloumn type:(NSString*)type{
    
    //    BOOL billStatus = FALSE;
    NSString* dbPath = [DataBaseConnection connection:@"RetailerBillingDataBase.sqlite"];
    @try {
        
        if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
            
            char *errMsg;
            NSString *query = [NSString stringWithFormat:@"alter table '%@' add column '%@' '%@'",tableName,coloumn,type];
            
            const char *sqlStatement = query.UTF8String;
            
            if (sqlite3_exec(database, sqlStatement, NULL, NULL, &errMsg)
                == SQLITE_OK) {
                
                NSLog(@"Success");
            }
            else {
                sqlite3_errmsg(database);
                NSLog(@"%s", sqlite3_errmsg(database));
            }
            
        }
    }
    @catch (NSException *exception) {
        
        
    }
    @finally {
        
        sqlite3_close(database);
        deleteStmt = nil;
    }
    
}

-(void)alterTable:(NSString*)tableName column:(NSString*)column{
    
    //    BOOL billStatus = FALSE;
    NSString* dbPath = [DataBaseConnection connection:@"RetailerBillingDataBase.sqlite"];
    @try {
        
        if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
            
            char *errMsg;
            //            NSString *query = [NSString stringWithFormat:@"alter table '%@' add KEY '(%@)'",tableName,column];
            NSString *query = [NSString stringWithFormat:@"alter table '%@' add column '%@' INT  DEFAULT '0'",tableName,column];
            
            const char *sqlStatement = query.UTF8String;
            
            if (sqlite3_exec(database, sqlStatement, NULL, NULL, &errMsg)
                == SQLITE_OK) {
                
                NSLog(@"Success");
            }
            else {
                sqlite3_errmsg(database);
                NSLog(@"%s", sqlite3_errmsg(database));
            }
        }
    }
    @catch (NSException *exception) {
        
        
    }
    @finally {
        
        sqlite3_close(database);
        deleteStmt = nil;
    }
    
}

-(void)updateTable:(NSString*)tableName columnName:(NSString*)columnName value:(id)value {
    NSString* dbPath = [DataBaseConnection connection:@"RetailerBillingDataBase.sqlite"];
    @try {
        
        if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
            NSString *query ;
            
            query = [NSString stringWithFormat:@"update %@ SET %@='%@' where offer_id='1001900031920'",tableName,columnName,value];
            
            const char *sqlStatement = query.UTF8String;
            
            
            if(sqlite3_prepare_v2(database, sqlStatement, -1, &selectStmt, NULL) == SQLITE_OK) {
                //                        int count = sqlite3_column_count(selectStmt);
                if (sqlite3_step(selectStmt) == SQLITE_DONE) {
                    
                    
                }
                else {
                    NSLog(@"%s",sqlite3_errmsg(database)) ;
                    
                }
                
                sqlite3_finalize(selectStmt);
                selectStmt = nil;
            }
            else {
                NSLog(@"%s",sqlite3_errmsg(database)) ;
            }
            
        }
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
        UIAlertView *alert=  [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Problem occured while processing" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    @finally {
        sqlite3_close(database);
        deleteStmt = nil;
        selectStmt = nil;
    }
    
}

-(BOOL)deleteFromTable:(NSString*)tableName {
    
    BOOL isDeleted = NO;
    
    @try {
        
        NSString* dbPath = [DataBaseConnection connection:@"RetailerBillingDataBase.sqlite"];
        
        //  BOOL isExists = [self createTable:@"billing"];
        
        //  if (isExists) {
        
        
        if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
            
            if (deleteStmt == nil) {
                NSString *query = [NSString stringWithFormat:@"delete from %@ ",tableName];
                const char *sqlStatement = query.UTF8String;
                
                if(sqlite3_prepare_v2(database, sqlStatement, -1, &deleteStmt, NULL) == SQLITE_OK) {
                    
                    if(SQLITE_DONE != sqlite3_step(deleteStmt)){
                        isDeleted = NO;
                        NSLog(@"%s",sqlite3_errmsg(database));
                        NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(database));
                    }
                    else {
                        isDeleted = YES;
                        
                    }
                    sqlite3_reset(deleteStmt);
                }
                deleteStmt = nil;
                
            }
            
        }
        
    }
    @catch (NSException *exception) {
        [HUD hide:YES afterDelay:2.0];
        NSLog(@"%@",exception);
        
    }
    @finally {
        sqlite3_close(database);
        deleteStmt = nil;
        selectStmt = nil;
        
    }
    
    
    
}

/**
 * @description  here we are hidding and showing respective view.......
 * @date         13/11/2016
 * @method       showRespectiveView:
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)showRespectiveView:(UIButton *)sender{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    //creation of UIButtons
    
    @try {
        
        if(sender.tag == 2){
            
            
            UIImage *deselecedListImage = [UIImage imageNamed:@"list_brown.png"];
            UIImage *selectedGirdImage = [UIImage imageNamed:@"grid_select.png"];
            
            [showListViewBtn setImage:deselecedListImage forState:UIControlStateNormal];
            [showgridViewBtn setImage:selectedGirdImage forState:UIControlStateNormal];
            
            listTableView.hidden = YES;
            gridView.hidden = NO;
            
            isListView = false;
            
            headerView.hidden = YES;
            
        }
        else{
            UIImage *selctedListImage = [UIImage imageNamed:@"list_select.png"];
            UIImage *deselectedGirdImage = [UIImage imageNamed:@"grid_brown.png"];
            
            [showListViewBtn setImage:selctedListImage forState:UIControlStateNormal];
            [showgridViewBtn setImage:deselectedGirdImage forState:UIControlStateNormal];
            
            
            listTableView.hidden = NO;
            gridView.hidden = YES;
            
            isListView = true;
            headerView.hidden = NO;
            
        }
        
        [self reloadCollectionView:selectedTableRowNumber];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

/**
 * @description  here we are hidding and showing respective view.......
 * @date         13/11/2016
 * @method       showRespectiveView:
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)reloadCollectionView:(int)selectedNumber{
    
    @try {
        
        selectedTableRowNumber = selectedNumber;
        backBtn.hidden=YES;
        
        //loading the gridView images as well as flowNames.......
        
        
        //added by Srinivasulu on 20/01/2016....
        
        if(gridImagesArr == nil){
            
            gridImagesArr = [[NSMutableArray alloc] init];
            gridImageNamesArr  = [[NSMutableArray alloc] init];
            noOfDocsArr = [NSMutableArray new];
            noOfPendingDocsArr = [NSMutableArray new];
            lastUpdatedDate = [NSMutableArray new];
        }
        else{
            
            if(gridImagesArr.count)
                [gridImagesArr removeAllObjects];
            
            
            if(gridImageNamesArr.count)
                [gridImageNamesArr removeAllObjects];
            
            if(noOfDocsArr.count)
                [noOfDocsArr removeAllObjects];
            
            if(noOfPendingDocsArr.count)
                [noOfPendingDocsArr removeAllObjects];
            
            
            if(lastUpdatedDate.count)
                [lastUpdatedDate removeAllObjects];
            
            
        }
        
        //upto here on 20/01/2016....
        
        //        int pos = 0;
        
        
        NSDate * todayDate = [NSDate date];
        NSDateFormatter * requiredDateFormate = [[NSDateFormatter alloc] init];
        requiredDateFormate.dateFormat = @"dd/MM/yyyy";
        NSString * currentDateStr = [requiredDateFormate stringFromDate:todayDate];
        
        
        switch (selectedNumber) {
            case 0: {
                
                //adding images.......
                [gridImagesArr addObject:@"new_bill.png"];
                [gridImagesArr addObject:@"return_bill.png"];
                [gridImagesArr addObject:@"completed_bills.png"];
                [gridImagesArr addObject:@"credit_bills.png"];
                [gridImagesArr addObject:@"pending_bills.png"];
                [gridImagesArr addObject:@"pending_bills.png"];
                [gridImagesArr addObject:@"door_delivery_bills.png"];
                [gridImagesArr addObject:@"cancel_bills.png"];
                [gridImagesArr addObject:@"return_bills.png"];
                [gridImagesArr addObject:@"exchange_bills.png"];
                [gridImagesArr addObject:@"customer_walkout.png"];
                
                [gridImagesArr addObject:@"new_bill.png"];
                [gridImagesArr addObject:@"day_start.png"];
                
                
                //adding flowNames.......
                [gridImageNamesArr addObject:NSLocalizedString(@"new_bill", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"returning_bill", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"past_bill", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"credit_bills", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"pending_bills", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"draft_bills", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"door_delivery_bills", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"cancelled_bills", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"returned_bills", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"exchange_bills", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"customer_walkout", nil)];
                
                [gridImageNamesArr addObject:NSLocalizedString(@"new_exchange_bill", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"day_start", nil)];
                
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                
            }
                
                break;
            case 1:{
                
                //Adding Images..For Stock Management
                
                [gridImagesArr addObject:@"view_stocks.png"];
                [gridImagesArr addObject:@"stock_verification.png"];
                [gridImagesArr addObject:@"stock request_in.png"]; //stock_request_new.png
                [gridImagesArr addObject:@"stock request_out.png"]; //Critical@2x.png
                [gridImagesArr addObject:@"stock_issue_new.png"];
                [gridImagesArr addObject:@"stock_receipts_new.png"]; //
                [gridImagesArr addObject:@"goods_issue.png"];//Stock Return..
                //[gridImagesArr addObject:@"purchases_new"];
                [gridImagesArr addObject:@"receipts_new"];
                [gridImagesArr addObject:@"shipments_new"];
                
                
                //adding flowNames.......
                [gridImageNamesArr addObject:NSLocalizedString(@"view_stocks", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"verify_stocks", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"stock_indent", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"outBound_indent",nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"stock_issue", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"stock_receipt", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"stock_return", nil)];
                //[gridImageNamesArr addObject:NSLocalizedString(@"purchases", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"receipts", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"shipment_return", nil)];
                
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
            }
                break;
                
            case 2: {
                
                //adding images.......
                [gridImagesArr addObject:@"deals_new.png"];
                [gridImagesArr addObject:@"offer_new.png"];
                
                //adding flowNames.......
                [gridImageNamesArr addObject:NSLocalizedString(@"deals", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"offers", nil)];
                
                
                
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [lastUpdatedDate addObject:@"15/11/2016"];
                [lastUpdatedDate addObject:@"15/11/2016"];
                
                /*NSLocalizedString(@"new_order", nil)
                 NSLocalizedString(@"new_order", nil)
                 NSLocalizedString(@"delivered_orders", nil)*/
                
                
            }
                break;
            case 3: {
                
                //adding images.......
                [gridImagesArr addObject:@"new_orders.png"];
                [gridImagesArr addObject:@"pending_orders.png"];
                [gridImagesArr addObject:@"delivered_orders.png"];
                [gridImagesArr addObject:@"complaint_orders.png"];
                //added by roja for F&b flow...
//                [gridImagesArr addObject:@"New_Booking_Img.png"];
                [gridImagesArr addObject:@"Table_Booking.png"]; //View_Booking_Img.png
                
                //adding flowNames.......
                [gridImageNamesArr addObject:NSLocalizedString(@"orders", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"pending_orders", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"delivered_orders", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"complaints", nil)];
                //added by roja for F&b flow...
                [gridImageNamesArr addObject:NSLocalizedString(@"table_booking", nil)];
                
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                
                // commented by roja // uncomment below if table_booking flow is required.
//                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
//                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
//                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
            }
                break;
            case 4: {
                
                //adding images.......
                [gridImagesArr addObject:@"new_loyalty_card.png"];
                [gridImagesArr addObject:@"view_loyalty_card.png"];
                [gridImagesArr addObject:@"edit_loyalty_card.png"];
                [gridImagesArr addObject:@"new_gift_vouchure.png"];
                [gridImagesArr addObject:@"view_gift_vouchure.png"];
                [gridImagesArr addObject:@"edit_gift_vouchure.png"];
                [gridImagesArr addObject:@"issue_gift_coupon.png"];
                [gridImagesArr addObject:@"view_gift_coupon"];
                [gridImagesArr addObject:@"view_gift_coupon"]; // added By roja on 28/11/2019...

                //adding flowNames.......
                [gridImageNamesArr addObject:NSLocalizedString(@"new_loyalty_card", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"view_loyalty_card", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"edit_loyalty_card", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"new_gift_voucher", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"view_gift_voucher", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"edit_gift_voucher", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"new_gift_coupon", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"view_gift_coupon", nil)];
                [gridImageNamesArr addObject:@"Issue Loyalty Card"];// added By roja on 28/11/2019...

                
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];// added By roja on 28/11/2019...

                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];  // added By roja on 28/11/2019...
                
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];// added By roja on 28/11/2019...
                
            }
                break;
                
            case 5:{
                
                selectedFlowStr = @"Reports";
                
                //adding images.......
                [gridImagesArr addObject:@"sales_report.png"];
                [gridImagesArr addObject:@"order_reports_new.png"];
                //                [gridImagesArr addObject:@"Order_Reports@2x.png"];
                //                [gridImagesArr addObject:@"Order_Reports@2x.png"];
                //                [gridImagesArr addObject:@"Order_Reports@2x.png"];
                
                //adding flowNames.......
                [gridImageNamesArr addObject:NSLocalizedString(@"sales_reports", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"order_reports", nil)];
                //                [gridImageNamesArr addObject:NSLocalizedString(@"x_eading", nil)];
                //                [gridImageNamesArr addObject:NSLocalizedString(@"z_reading", nil)];
                //                [gridImageNamesArr addObject:NSLocalizedString(@"z_reading_consolidate", nil)];
                
                
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                
                //                [noOfDocsArr addObject:@"10"];
                //                [noOfDocsArr addObject:@"10"];
                //                [noOfDocsArr addObject:@"10"];
                //                [noOfPendingDocsArr addObject:@"3"];
                //                [noOfPendingDocsArr addObject:@"3"];
                //                [noOfPendingDocsArr addObject:@"3"];
                //                [lastUpdatedDate addObject:@"15/11/2016"];
                //                [lastUpdatedDate addObject:@"15/11/2016"];
                //                [lastUpdatedDate addObject:@"15/11/2016"];
                
                
            }
                break;
                
            case 6:{
                
                backBtn.hidden = NO;
                
                selectedFlowStr = @"Reports1";
                
                
                //changed by Srinivasulu on 24/10/2017....
                //update newly updated images....
                
                //adding images.......
                [gridImagesArr addObject:@"xyz_reading.png"];
                [gridImagesArr addObject:@"z_sales_report.png"];
                [gridImagesArr addObject:@"date_wise_report.png"];
                [gridImagesArr addObject:@"categories.png"];
                [gridImagesArr addObject:@"sku_wise_report.png"];
                [gridImagesArr addObject:@"material_consumption.png"];
                [gridImagesArr addObject:@"suplies_report.png"];
                [gridImagesArr addObject:@"tax_reports.png"];
                
                [gridImagesArr addObject:@"zx_sales_report.png"];
                [gridImagesArr addObject:@"void_item_report.png"];
                [gridImagesArr addObject:@"price_override_report.png"];
                [gridImagesArr addObject:@"zx_sales_report.png"];
                [gridImagesArr addObject:@"zx_sales_report.png"];
                
                
                //adding flowNames.......
                [gridImageNamesArr addObject:NSLocalizedString(@"xreading", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"zreading", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"datewise", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"categorywise", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"skuwise", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"material_consumption", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"supplies-report", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"tax_report", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"hourWise_report",nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"void_item_report",nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"override_sales_report",nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"salesmen_commission_report",nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"department_wise_report",nil)];
                
                
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                
                
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                
                
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
                [lastUpdatedDate addObject:currentDateStr];
            }
                break;
            case 7: {
                
                //adding images.......
                [gridImagesArr addObject:@"Dine_In.png"]; //NewCheckIn.png //Dining.png
                [gridImagesArr addObject:@"KOT1.png"]; //NewCheckIn.png  //KOT.png //KOT_New.png
                
                //adding flowNames.......
                [gridImageNamesArr addObject:NSLocalizedString(@"dine_in", nil)];
                [gridImageNamesArr addObject:NSLocalizedString(@"kitchen_order_token", nil)];
                
                [noOfDocsArr addObject:@"10"];
                [noOfDocsArr addObject:@"10"];
                [noOfPendingDocsArr addObject:@"3"];
                [noOfPendingDocsArr addObject:@"3"];
                [lastUpdatedDate addObject:@"15/11/2016"];
                [lastUpdatedDate addObject:@"15/11/2016"];
            }
                break;
                
                
            default:
                break;
        }
        
        
        if (isListView) {
            
            [listTableView reloadData];
        }
        else {
            [gridCollectionView reloadData];
        }
        
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        
    }
    
}
#pragma -mark collection view delegate methods


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return gridImagesArr.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView1 cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    @try {
        
        
        static NSString *identifier = @"GridCollectionCellView";
        
        UICollectionViewCell *cell = [collectionView1 dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        
        if ((cell.contentView).subviews){
            for (UIView *subview in (cell.contentView).subviews) {
                [subview removeFromSuperview];
            }
        }
        
        if (!cell) {
            
            cell = [[UICollectionViewCell alloc] init];
        }
        
        @try {
            UIView *flowView = [[UIView alloc] init];
            flowView.layer.borderWidth = 1.0;
            flowView.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.7].CGColor;
            
            
            UIImageView *flowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:gridImagesArr[indexPath.row]]];
            
            UILabel *flowNameLbl = [[UILabel alloc] init];
            flowNameLbl.textAlignment = NSTextAlignmentCenter;
            flowNameLbl.numberOfLines = 2;
            flowNameLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            
            flowView.backgroundColor = [UIColor colorWithRed:21.0/255.0 green:21.0/255.0 blue:21.0/255.0 alpha:1.0];
            flowNameLbl.backgroundColor = [UIColor colorWithRed:37.0/255.0 green:37.0/255.0 blue:37.0/255.0 alpha:1.0];
            flowNameLbl.textColor = [UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:120.0/255.0 alpha:1.0];
            flowNameLbl.text = gridImageNamesArr[indexPath.row];
            
            
            
            [flowView addSubview:flowImage];
            [flowView addSubview:flowNameLbl];
            
            flowView.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
            
            //        flowImage.frame = CGRectMake( (cell.frame.size.width - 100)/2 , (cell.frame.size.width - 100)/2, 100, 100);
            //        flowNameLbl.frame = CGRectMake( 0, flowImage.frame.origin.y + flowImage.frame.size.height, cell.frame.size.width, cell.frame.size.height - (flowImage.frame.origin.y + flowImage.frame.size.height));
            
            
            flowNameLbl.frame = CGRectMake( 0, cell.frame.size.height - 50, cell.frame.size.width, 50);
            
            flowImage.frame = CGRectMake( (cell.frame.size.width - 100)/2 + 8, (cell.frame.size.width - 100)/2 - 15, 80, 80);
            
            
            flowNameLbl.font = [UIFont fontWithName:kLabelFont size:18.0];
            
            
            
            if(indexPath.row == (gridImagesArr.count - 1)){
                
                //            [UIView beginAnimations:nil context:NULL];
                //            [UIView setAnimationDuration:1.0];
                //            [UIView setAnimationTransition:UIViewAnimationOptionTransitionFlipFromTop forView:cell cache:YES];
                //            [UIView commitAnimations];
                //            cell.layer.speed = 0.1;
                
                [UIView animateWithDuration:5.5
                                      delay:0.0
                                    options:UIViewAnimationOptionTransitionFlipFromTop
                                 animations:^{
                                     // ... do stuff here
                                     flowView.frame = flowView.frame;
                                 } completion:NULL];
            }
            
            [cell.contentView addSubview:flowView];
            
            
        } @catch (NSException *exception) {
            
        } @finally {
            return cell;
            
        }
        
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize s;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
            
            
            s = CGSizeMake( 150,  150);
            
            
        }
        else {
            s = CGSizeMake([UIScreen mainScreen].bounds.size.width/4 - 130, [UIScreen mainScreen].bounds.size.height/4-150);
        }
    }
    else {
        if (version >=8.0) {
            s = CGSizeMake([UIScreen mainScreen].bounds.size.width/5 - 50, [UIScreen mainScreen].bounds.size.height/4-100);
            
            
        }
        else {
            s = CGSizeMake([UIScreen mainScreen].bounds.size.width/4 - 50, [UIScreen mainScreen].bounds.size.height/4-50);
        }
    }
    
    
    return s;
    
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake( 40, 0, 10, 5);
    
}
-(void)collectionView:(UICollectionView *)collectionView_ didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    @try {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = indexPath.row;
        
        [self prduct1_method:btn];
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

#pragma -mark end of collection view methods

-(void)closeMessagePopUp {
    
    [popOver dismissPopoverAnimated:YES];
}

-(void)populateDenominations {
    @try {
        
        denomValTxtArr = [NSMutableArray new];
        denomCountArr = [NSMutableArray new];
        denomCountCoinsArr = [NSMutableArray new];
        denomValCoinsTxtArr = [NSMutableArray new];
        
        OfflineBillingServices  *offline = [[OfflineBillingServices alloc] init];
        
        //added by Srinivasulu on 07/04/2018....
        
        showDefaultCurrencyCode = INR;
        NSString * savedDefaultCurrencyCode = INR;
        
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        
        if ( ! ([[defaults valueForKey:DEFAULT_CURRENCY_CODE] isKindOfClass:[NSNull class]] || [defaults valueForKey:DEFAULT_CURRENCY_CODE] == nil))
            savedDefaultCurrencyCode = [defaults valueForKey:DEFAULT_CURRENCY_CODE];
        
        if ( ! ([[defaults valueForKey:DENOMNINATION_OPTIONS] isKindOfClass:[NSNull class]] || [defaults valueForKey:DENOMNINATION_OPTIONS] == nil)) {
            
            for(NSDictionary * payDic in [defaults valueForKey:DENOMNINATION_OPTIONS]){
                
                if([[payDic valueForKey:TENDER_NAME] caseInsensitiveCompare:savedDefaultCurrencyCode] == NSOrderedSame){
                    showDefaultCurrencyCode = savedDefaultCurrencyCode;
                    break;
                }
            }
        }
        
        NSArray *denominations = [offline getDenominationDetails:showDefaultCurrencyCode];
        
        //upot here on 07/04/2018....
        
        //added by Srinivasulu on 05/05/2017....
        
        @try {
            
            if(!denominations.count){
                [HUD setHidden:NO];
                HUD.labelText = @"Getting denominations...";
                
                
                if([offline getDenominationsDetails:-1 totalRecords:DOWNLOAD_RATE]){
                    showDefaultCurrencyCode = INR;
                    denominations = [offline getDenominationDetails:INR];
                    
                }
                [HUD setHidden:YES];
                
            }
            
        } @catch (NSException *exception) {
            [HUD setHidden:YES];
            
        }
        
        //upto here on 05/05/2017....
        
        if (denominations.count) {
            
            tensCount = 0;
            twentyCount = 0;
            fiftyCount = 0;
            hundredCount = 0;
            fiveHundredCount = 0;
            thousandCount = 0;
            oneCount = 0;
            twoCount = 0;
            fiveCount = 0;
            tenCoinCount = 0;
            
            denominationDic = [[NSMutableDictionary alloc]init];
            denominationCoinDic = [NSMutableDictionary new];
            
            
            // close button to close the view ..
            UIButton   *backbutton = [[UIButton alloc] init] ;
            [backbutton addTarget:self action:@selector(closeView:) forControlEvents:UIControlEventTouchUpInside];
            backbutton.tag = 75;
            
            UILabel  *label = [[UILabel alloc] init] ;
            label.text = @"    Cash Denomination";
            label.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
            label.alpha = 1.0f;
            label.textAlignment = NSTextAlignmentLeft;
            label.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
            label.textColor = [UIColor whiteColor];
            
            
            UIImage *image = [UIImage imageNamed:@"delete.png"];
            [backbutton setBackgroundImage:image forState:UIControlStateNormal];
            
            
            UIButton   *continueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            //                        [continueBtn addTarget:self action:@selector(populateReportView) forControlEvents:UIControlEventTouchUpInside];
            [continueBtn addTarget:self action:@selector(populateReportView:) forControlEvents:UIControlEventTouchUpInside];
            [continueBtn setTitle:@"Continue"    forState:UIControlStateNormal];
            continueBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            continueBtn.titleLabel.textColor = [UIColor whiteColor];
            continueBtn.backgroundColor = [UIColor grayColor];
            
            UIButton   *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [closeBtn addTarget:self action:@selector(closeView:) forControlEvents:UIControlEventTouchUpInside];
            [closeBtn setTitle:@"Back"    forState:UIControlStateNormal];
            closeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            closeBtn.titleLabel.textColor = [UIColor whiteColor];
            closeBtn.backgroundColor = [UIColor grayColor];
            closeBtn.tag = 75;
            
            
            denominationView    = [[UIView alloc] init];
            (denominationView.layer).borderWidth = 1.0f;
            (denominationView.layer).cornerRadius = 8.0f;
            denominationView.backgroundColor = [UIColor blackColor];
            denominationView.hidden = false;
            denominationView.tag = 33;
            
            UIView *notesView    = [[UIView alloc] init];
            (notesView.layer).borderWidth = 1.0f;
            (notesView.layer).cornerRadius = 8.0f;
            notesView.backgroundColor = [UIColor blackColor];
            
            UIScrollView  *denomSrollView = [[UIScrollView alloc] init];
            denomSrollView.hidden = NO;
            denomSrollView.backgroundColor = [UIColor clearColor];
            denomSrollView.bounces = FALSE;
            denomSrollView.scrollEnabled = YES;
            
            
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths[0] stringByAppendingString:@"/DenominationImagesFolder"];
            
            int index=1;
            
            float yPosition = 0;
            float xPosition = 10;
            
            float textYposition = 10;
            
            NSMutableArray *notesArr = [NSMutableArray new];
            NSMutableArray *coinsArr = [NSMutableArray new];
            
            for (NSDictionary *infoDic in denominations) {
                
                if (![[infoDic valueForKey:kDenomType] boolValue]) {
                    
                    [coinsArr addObject:infoDic];
                }
                else {
                    [notesArr addObject:infoDic];
                }
            }
            
            NSSortDescriptor *sortDescriptor;
            
            //changed by Srinivaslulu on 16/08/2017....
            
            //            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:kDenomValue
            //                                                         ascending:YES];
            
            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:kDenomValue
                                                         ascending:NO];
            
            
            //upto here on 16/08/2017....
            
            
            NSArray *sortDescriptors = @[sortDescriptor];
            notesArr = [[notesArr sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
            coinsArr = [[coinsArr sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
            
            denominationView.frame = CGRectMake(100, 80, 800, 670);
            label.frame = CGRectMake(0, 0, denominationView.frame.size.width, 70);
            label.font = [UIFont systemFontOfSize:25];
            backbutton.frame = CGRectMake(740, 10.0, 45.0, 45.0);
            
            notesView.frame = CGRectMake(0, 0, denominationView.frame.size.width, denominationView.frame.size.height-180);
            
            denomSrollView.frame = CGRectMake(0, 80,  denominationView.frame.size.width, denominationView.frame.size.height-180);
            denomSrollView.contentSize = CGSizeMake(778, 550);
            
            for (NSDictionary *dic in notesArr) {
                
                
                NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:[dic valueForKey:kDenomImage]];
                
                UIImageView *denomImg = [[UIImageView alloc] init];
                denomImg.backgroundColor = [UIColor clearColor];
                denomImg.image = [UIImage imageWithContentsOfFile:savedImagePath];
                
                UIButton *addDenom = [[UIButton alloc] init];
                addDenom.backgroundColor = [UIColor clearColor];
                addDenom.tag = [[dic valueForKey:kDenomValue] integerValue];
                [addDenom addTarget:self action:@selector(addDenominations:) forControlEvents:UIControlEventTouchUpInside];
                
                UIButton *removeDenom = [[UIButton alloc] init];
                removeDenom.backgroundColor = [UIColor clearColor];
                removeDenom.tag = [[dic valueForKey:kDenomValue] integerValue];
                [removeDenom addTarget:self action:@selector(removeDenominations:) forControlEvents:UIControlEventTouchUpInside];
                
                UILabel *addDenomLbl = [[UILabel alloc] init];
                addDenomLbl.text = @"+";
                addDenomLbl.textColor = [UIColor whiteColor];
                
                UILabel *removeDenomLbl = [[UILabel alloc] init];
                removeDenomLbl.text = @"-";
                removeDenomLbl.textColor = [UIColor whiteColor];
                
                UILabel  *denomValueMultiply = [[UILabel alloc]init];
                denomValueMultiply.textColor = [UIColor whiteColor];
                denomValueMultiply.text = [NSString stringWithFormat:@"%@%@",[[dic valueForKey:kDenomValue] stringValue],@"  X"];
                denomValueMultiply.textAlignment = NSTextAlignmentRight;
                
                UILabel  *denomValue = [[UILabel alloc]init];
                denomValue.textColor = [UIColor whiteColor];
                denomValue.text = @"0.00";
                denomValue.tag = [[dic valueForKey:kDenomValue] integerValue];
                
                denomValueTxt = [[CustomTextField alloc]init];
                denomValueTxt.borderStyle = UITextBorderStyleRoundedRect;
                denomValueTxt.textColor = [UIColor blackColor];
                denomValueTxt.font = [UIFont systemFontOfSize:18.0];
                denomValueTxt.backgroundColor = [UIColor whiteColor];
                denomValueTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
                denomValueTxt.backgroundColor = [UIColor whiteColor];
                denomValueTxt.keyboardType = UIKeyboardTypeNumberPad;
                denomValueTxt.autocorrectionType = UITextAutocorrectionTypeNo;
                denomValueTxt.layer.borderColor = [UIColor whiteColor].CGColor;
                denomValueTxt.backgroundColor = [UIColor whiteColor];
                denomValueTxt.delegate = self;
                denomValueTxt.tag = [[dic valueForKey:kDenomValue] integerValue];
                
                
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    
                    //                    denominationView.frame = CGRectMake(100, 0, 800, 670);
                    //                    label.frame = CGRectMake(0, 0, denominationView.frame.size.width, 70);
                    //                    label.font = [UIFont systemFontOfSize:25];
                    //                    backbutton.frame = CGRectMake(740, 10.0, 45.0, 45.0);
                    //
                    //                    denomSrollView.frame = CGRectMake(0, 80, 778, 150);
                    //                    denomSrollView.contentSize = CGSizeMake(778, 800);
                    
                    removeDenomLbl.frame = CGRectMake(xPosition , yPosition, 60, 40);
                    removeDenomLbl.font = [UIFont boldSystemFontOfSize:22];
                    
                    
                    denomImg.frame = CGRectMake(xPosition, yPosition + removeDenomLbl.frame.size.height, 156, 60);
                    
                    addDenomLbl.frame = CGRectMake(xPosition + denomImg.frame.size.width - 30, yPosition, 60, 40);
                    addDenomLbl.font = [UIFont boldSystemFontOfSize:22];
                    
                    removeDenom.frame = CGRectMake(denomImg.frame.origin.x, denomImg.frame.origin.y, denomImg.frame.size.width/2, denomImg.frame.size.height);
                    addDenom.frame = CGRectMake(denomImg.frame.origin.x + (denomImg.frame.size.width/2), denomImg.frame.origin.y, denomImg.frame.size.width/2, denomImg.frame.size.height);
                    
                    denomValueMultiply.frame = CGRectMake(450, textYposition, 120, 25);
                    denomValueMultiply.font = [UIFont boldSystemFontOfSize:20];
                    
                    denomValueTxt.frame = CGRectMake(denomValueMultiply.frame.origin.x + denomValueMultiply.frame.size.width + 20,textYposition, 80, 25);
                    denomValueTxt.font = [UIFont boldSystemFontOfSize:20];
                    
                    //changed by Srinivasulu on 29/08/2017....
                    
                    //                    denomValue.frame = CGRectMake(denomValueTxt.frame.origin.x + denomValueTxt.frame.size.width + 20,textYposition, 200, 25);
                    denomValue.frame = CGRectMake( denomValueTxt.frame.origin.x + denomValueTxt.frame.size.width + 10,textYposition, denomSrollView.frame.size.width - (denomValueTxt.frame.origin.x + denomValueTxt.frame.size.width + 20), 25);
                    
                    
                    //upto here on 29/08/2017....
                    
                    denomValue.font = [UIFont systemFontOfSize:20.0];
                    
                }
                
                xPosition = xPosition + denomImg.frame.size.width + 20;
                
                textYposition = textYposition + 40;
                
                if (index != 0 && (index%2) == 0) {
                    
                    yPosition = yPosition + denomImg.frame.size.height+addDenomLbl.frame.size.height;
                    
                    xPosition = 10;
                }
                [denomSrollView addSubview:addDenomLbl];
                [denomSrollView addSubview:removeDenomLbl];
                [denomSrollView addSubview:denomImg];
                [denomSrollView addSubview:addDenom];
                [denomSrollView addSubview:removeDenom];
                [denomSrollView addSubview:denomValueMultiply];
                [denomSrollView addSubview:denomValue];
                [denomSrollView addSubview:denomValueTxt];
                
                index++;
                
                [denomValTxtArr addObject:denomValueTxt];
                [denomCountArr addObject:denomValue];
                
            }
            
            index = 1;
            
            
            //added by srinivasulu on 29/03/2018....
            //because need to be displaced side
            
            yPosition = 0;
            xPosition = 380;
            
            //upto here on 29/03/2018....
            
            for (NSDictionary *dic in coinsArr) {
                
                NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:[dic valueForKey:kDenomImage]];
                
                UIImageView *denomImg = [[UIImageView alloc] init];
                denomImg.backgroundColor = [UIColor clearColor];
                denomImg.image = [UIImage imageWithContentsOfFile:savedImagePath];
                
                UIButton *addDenom = [[UIButton alloc] init];
                addDenom.backgroundColor = [UIColor clearColor];
                addDenom.tag = [[dic valueForKey:kDenomValue] integerValue];
                [addDenom addTarget:self action:@selector(addCoinsDenominations:) forControlEvents:UIControlEventTouchUpInside];
                
                UIButton *removeDenom = [[UIButton alloc] init];
                removeDenom.backgroundColor = [UIColor clearColor];
                removeDenom.tag = [[dic valueForKey:kDenomValue] integerValue];
                [removeDenom addTarget:self action:@selector(removeCoinDenominations:) forControlEvents:UIControlEventTouchUpInside];
                
                
                UILabel *addDenomLbl = [[UILabel alloc] init];
                addDenomLbl.text = @"+";
                addDenomLbl.textColor = [UIColor whiteColor];
                
                UILabel *removeDenomLbl = [[UILabel alloc] init];
                removeDenomLbl.text = @"-";
                removeDenomLbl.textColor = [UIColor whiteColor];
                
                UILabel  *denomValueMultiply = [[UILabel alloc]init];
                denomValueMultiply.textColor = [UIColor whiteColor];
                denomValueMultiply.text = [NSString stringWithFormat:@"%@%@",[[dic valueForKey:kDenomValue] stringValue],@"  X"];
                denomValueMultiply.textAlignment = NSTextAlignmentRight;
                
                UILabel  *denomValue = [[UILabel alloc]init];
                denomValue.textColor = [UIColor whiteColor];
                denomValue.text = @"0.00";
                denomValue.tag = [[dic valueForKey:kDenomValue] integerValue];
                
                denomValueTxt = [[CustomTextField alloc]init];
                denomValueTxt.borderStyle = UITextBorderStyleRoundedRect;
                denomValueTxt.textColor = [UIColor blackColor];
                denomValueTxt.font = [UIFont systemFontOfSize:18.0];
                denomValueTxt.backgroundColor = [UIColor whiteColor];
                denomValueTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
                denomValueTxt.backgroundColor = [UIColor whiteColor];
                denomValueTxt.keyboardType = UIKeyboardTypeNumberPad;
                denomValueTxt.autocorrectionType = UITextAutocorrectionTypeNo;
                denomValueTxt.layer.borderColor = [UIColor whiteColor].CGColor;
                denomValueTxt.backgroundColor = [UIColor whiteColor];
                denomValueTxt.delegate = self;
                denomValueTxt.tag = [[dic valueForKey:kDenomValue] integerValue];
                
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    
                    
                    
                    removeDenomLbl.frame = CGRectMake(xPosition , yPosition, 60, 40);
                    removeDenomLbl.font = [UIFont boldSystemFontOfSize:22];
                    
                    
                    denomImg.frame = CGRectMake(xPosition, yPosition + removeDenomLbl.frame.size.height, 95, 85);
                    
                    addDenomLbl.frame = CGRectMake(xPosition + denomImg.frame.size.width - 30, yPosition, 60, 40);
                    addDenomLbl.font = [UIFont boldSystemFontOfSize:22];
                    
                    removeDenom.frame = CGRectMake(denomImg.frame.origin.x, denomImg.frame.origin.y, denomImg.frame.size.width/2, denomImg.frame.size.height);
                    addDenom.frame = CGRectMake(denomImg.frame.origin.x + (denomImg.frame.size.width/2), denomImg.frame.origin.y, denomImg.frame.size.width/2, denomImg.frame.size.height);
                    
                    denomValueMultiply.frame = CGRectMake(450, textYposition, 120, 25);
                    denomValueMultiply.font = [UIFont boldSystemFontOfSize:20];
                    
                    denomValueTxt.frame = CGRectMake(denomValueMultiply.frame.origin.x + denomValueMultiply.frame.size.width + 20,textYposition, 80, 25);
                    denomValueTxt.font = [UIFont boldSystemFontOfSize:20];
                    
                    
                    //changed by Srinivasulu on 29/08/2017....
                    
                    //                    denomValue.frame = CGRectMake(denomValueTxt.frame.origin.x + denomValueTxt.frame.size.width + 20,textYposition, 200, 25);
                    denomValue.frame = CGRectMake( denomValueTxt.frame.origin.x + denomValueTxt.frame.size.width + 10,textYposition, denomSrollView.frame.size.width - (denomValueTxt.frame.origin.x + denomValueTxt.frame.size.width + 20), 25);
                    
                    
                    //upto here on 29/08/2017....
                    
                    denomValue.font = [UIFont systemFontOfSize:20.0];
                    
                }
                
                
                //commented and changes done by srinivasulu on 27/03/2018....
                //because need to be displaced side
                
                //                xPosition = xPosition + denomImg.frame.size.width + 20;
                textYposition = textYposition + 40;
                
                //                if (index != 0 && (index%3) == 0) {
                
                yPosition = yPosition + denomImg.frame.size.height+addDenomLbl.frame.size.height ;
                
                //                    xPosition = 10;
                //                }
                
                
                //upto here by srinivasulu on 27/03/2018....
                
                [denomSrollView addSubview:addDenomLbl];
                [denomSrollView addSubview:removeDenomLbl];
                [denomSrollView addSubview:denomImg];
                [denomSrollView addSubview:addDenom];
                [denomSrollView addSubview:removeDenom];
                [denomSrollView addSubview:denomValueMultiply];
                [denomSrollView addSubview:denomValue];
                [denomSrollView addSubview:denomValueTxt];
                
                index++;
                
                [denomValCoinsTxtArr addObject:denomValueTxt];
                [denomCountCoinsArr addObject:denomValue];
                
            }
            
            CGRect contentRect = CGRectZero;
            for (UIView *view in denomSrollView.subviews) {
                contentRect = CGRectUnion(contentRect, view.frame);
            }
            denomSrollView.contentSize = contentRect.size;
            
            textYposition = denomSrollView.frame.size.height + denomSrollView.frame.origin.y + 30;
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                
                continueBtn.frame = CGRectMake(100.0, textYposition, 250.0, 40);
                continueBtn.layer.cornerRadius = 10.0f;
                continueBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
                
                closeBtn.frame = CGRectMake(450.0, textYposition, 250.0, 40);
                closeBtn.layer.cornerRadius = 10.0;
                closeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
                
            }
            
            denominationView.layer.borderColor = [UIColor whiteColor].CGColor;
            denominationView.layer.borderWidth = 1.0f;
            
            [denominationView addSubview:label];
            [denominationView addSubview:backbutton];
            //            [denomSrollView addSubview:notesView];
            [denominationView addSubview:denomSrollView];
            [denominationView addSubview:continueBtn];
            [denominationView addSubview:closeBtn];
            [self.view addSubview:denominationView];
        }
        else {
            // [self setSiblings:paymentView enabled:true];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Denominations are not available" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

-(void)addDenominations:(UIButton*)sender {
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        
        if ([denominationDic.allKeys containsObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]]) {
            
            NSString *str = [denominationDic valueForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            
            oneCount = str.intValue;
        }
        else {
            oneCount = 0;
        }
        oneCount++;
        oneQty.text = [NSString stringWithFormat:@"%d",oneCount];
        if (oneCount > 0) {
            [denominationDic setValue:[NSString stringWithFormat:@"%d",oneCount] forKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            
            for (UITextField *text in denomValTxtArr) {
                
                if (text.tag == sender.tag) {
                    text.text = [NSString stringWithFormat:@"%d",oneCount];
                    
                    
                }
            }
            
            for (UILabel *text in denomCountArr) {
                
                if (text.tag == sender.tag) {
                    text.text = [NSString stringWithFormat:@"%.2f",(float)(oneCount * sender.tag)];
                    
                }
            }
        }
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

-(void)addCoinsDenominations:(UIButton*)sender {
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        
        if ([denominationCoinDic.allKeys containsObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]]) {
            
            NSString *str = [denominationCoinDic valueForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            
            oneCount = str.intValue;
        }
        else {
            oneCount = 0;
        }
        oneCount++;
        oneQty.text = [NSString stringWithFormat:@"%d",oneCount];
        if (oneCount > 0) {
            [denominationCoinDic setValue:[NSString stringWithFormat:@"%d",oneCount] forKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            
            for (UITextField *text in denomValCoinsTxtArr) {
                
                if (text.tag == sender.tag) {
                    text.text = [NSString stringWithFormat:@"%d",oneCount];
                }
            }
            
            for (UILabel *text in denomCountCoinsArr) {
                
                if (text.tag == sender.tag) {
                    text.text = [NSString stringWithFormat:@"%.2f",(float)(oneCount * sender.tag)];
                    
                }
            }
        }
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

-(void)removeDenominations:(UIButton*)sender {
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        if ([denominationDic.allKeys containsObject:@(sender.tag)]) {
            
            NSString *str = [denominationDic valueForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            
            oneCount = str.intValue;
        }
        else {
            oneCount = 0;
        }
        if (oneCount != 0) {
            oneCount--;
        }
        if (oneCount>=0) {
            if ([denominationDic valueForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]) {
                for (UITextField *text in denomValTxtArr) {
                    
                    if (text.tag == sender.tag) {
                        text.text = [NSString stringWithFormat:@"%d",oneCount];
                    }
                }
                
                for (UILabel *text in denomCountArr) {
                    
                    if (text.tag == sender.tag) {
                        text.text = [NSString stringWithFormat:@"%.2f",(float)(oneCount * sender.tag)];
                        
                    }
                }
            }
            if (tenCoinCount == 0) {
                [denominationDic removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            }
            else {
                [denominationDic setValue:[NSString stringWithFormat:@"%d",oneCount] forKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            }
        }
        // [self updatePaidAmount];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

-(void)removeCoinDenominations:(UIButton*)sender {
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        if ([denominationCoinDic.allKeys containsObject:@(sender.tag)]) {
            
            NSString *str = [denominationCoinDic valueForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            
            oneCount = str.intValue;
        }
        else {
            oneCount = 0;
        }
        if (oneCount != 0) {
            oneCount--;
        }
        if (oneCount>=0) {
            if ([denominationCoinDic valueForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]]) {
                for (UITextField *text in denomValCoinsTxtArr) {
                    
                    if (text.tag == sender.tag) {
                        text.text = [NSString stringWithFormat:@"%d",oneCount];
                    }
                }
                
                for (UILabel *text in denomCountCoinsArr) {
                    
                    if (text.tag == sender.tag) {
                        text.text = [NSString stringWithFormat:@"%.2f",(float)(oneCount * sender.tag)];
                        
                    }
                }
            }
            if (tenCoinCount == 0) {
                [denominationCoinDic removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            }
            else {
                [denominationCoinDic setValue:[NSString stringWithFormat:@"%d",oneCount] forKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            }
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}


//Modified for adding the backButton at the end by Pabhu
- (void)backButton:(UIButton *)sender {
    [self reloadCollectionView:saleNo];
}





-(int)getLocalBillCount{
    
    int count = 0;
    
    @try {
        
        NSString* dbPath = [DataBaseConnection connection:@"RetailerBillingDataBase.sqlite"];
        
        if(sqlite3_open(dbPath.UTF8String, &database) == SQLITE_OK) {
            NSString *query;
            
            
            //changed by Srinivaslulu on 29/08/2017....
            //reason error status are also has to be uploaded....
            
            //            query = [NSString stringWithFormat:@"select count (*) from billing_table where save_status != 'Success' and save_status!='Error'"];
            
            query = [NSString stringWithFormat:@"select count (*) from billing_table where save_status != 'Success'"];
            
            //upto here on 29/08/2017....
            
            
            const char *sqlStatement = query.UTF8String;
            
            
            if(sqlite3_prepare_v2(database, sqlStatement, -1, &selectStmt, NULL) == SQLITE_OK) {
                //                        int count = sqlite3_column_count(selectStmt);
                while (sqlite3_step(selectStmt) == SQLITE_ROW) {
                    
                    count = sqlite3_column_int(selectStmt, 0);
                    
                    
                }
                sqlite3_reset(selectStmt);
                sqlite3_finalize(selectStmt);
                selectStmt = nil;
            }
            else {
                NSLog(@"%s",sqlite3_errmsg(database)) ;
            }
            
        }
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
        
    }
    @finally {
        sqlite3_close(database);
        
    }
    
    return count;
}

-(void)uploadLocalBills{
    
    if(isOfflineService){
        
        UIAlertView * wifiAlert = [[UIAlertView alloc] initWithTitle:@"Please, Enable your wifi" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [wifiAlert show];
        
    }
    
    else if ([self getLocalBillCount] > 0) {
        uploadConfirmationAlert = [[UIAlertView alloc] initWithTitle:@"Are you sure to synch the local bills" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
        
        [uploadConfirmationAlert show];
        
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"There are no bills to sync" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
}

#pragma -mark Start of TextFieldDelegates.......

/**
 * @description  it is an textFieldDelegate method it will be executed when text  Begin edititng........
 * @date
 * @method       textFieldShouldBeginEditing:
 * @author
 * @param        UITextField
 * @param
 * @param
 * @return
 *
 * @modified By  Srinivasulu on 30/08/2017....
 * @reason       added the comment's....
 *
 * @verified By
 * @verified On
 *
 */

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    
    return YES;
    
}

/**
 * @description  it is an textFieldDelegate method it will be executed when text Begin edititng........
 * @date
 * @method       textFieldDidBeginEditing:
 * @author
 * @param        UITextField
 * @param
 * @param
 * @return
 *
 * @modified By  Srinivasulu on 30/08/2017 && on 22/03/2018....
 * @reason       added the comment's added deminations handling....
 *
 * @verified By
 * @verified On
 *
 */

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField==cardTotalTxt || textField == couponTotalTxt || textField == ticketTotalTxt) {
        
        //        offSetViewTo =  0;
        [textField selectAll:self];
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    
    //paymentModesAmountTxt --
    else if(textField.frame.origin.x == denomValueTxt.frame.origin.x){
        
        @try {
            offSetViewTo = textField.frame.origin.y;
            
            [self keyboardWillShow];
            
        } @catch (NSException *exception) {
            
        }
    }
    //aded by Srinivasulu on 10/10/2017....
    
    else if(textField == totalNoOfWalkinsTxt){
        
        @try {
            
            offSetViewTo = textField.frame.origin.y - 70;
            [self keyboardWillShow];
        } @catch (NSException *exception) {
            
        }
    }
    else if(textField == remarksTxt){
        
        @try {
            
            offSetViewTo = textField.frame.origin.y - 150;
            [self keyboardWillShow];
        } @catch (NSException *exception) {
            
        }
        
    }
    else if(textField.frame.origin.x == totalNoOfWalkinsTxt.frame.origin.x){
        
        @try {
            
            [textField selectAll:self];
            offSetViewTo = textField.frame.origin.y - 20;
            [self keyboardWillShow];
            
            //            if(([totalNoOfWalkinsTxt.text intValue] - [textField.text intValue]) >= 0)
            //            totalNoOfWalkinsTxt.text = [NSString stringWithFormat:@"%i", ([totalNoOfWalkinsTxt.text intValue] - [textField.text intValue])];
        } @catch (NSException *exception) {
            
        }
        
    }
    else if(!tenderModesView.hidden && tenderModesView != nil){
        
        @try {
            
            [textField selectAll:self];
            
            if(textField.tag > 8)
                offSetViewTo = 200;
            [self keyboardWillShow];
            
            //            if(([totalNoOfWalkinsTxt.text intValue] - [textField.text intValue]) >= 0)
            //            totalNoOfWalkinsTxt.text = [NSString stringWithFormat:@"%i", ([totalNoOfWalkinsTxt.text intValue] - [textField.text intValue])];
        } @catch (NSException *exception) {
            
        }
        
    }
    //upto here on 10/10/2017....
    
}

/**
 * @description  it is an textFieldDelegate method it will be executed for ever character change........
 * @date         30/08/2017....
 * @method       textField:  shouldChangeCharactersInRange:  replacementString:
 * @author       Srinivasulu
 * @param        UITextField
 * @param        NSRange
 * @param        NSString
 * @return       BOOL
 * @verified By
 * @verified On
 *
 */

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    @try {
        
        if(textField.frame.origin.x == denomValueTxt.frame.origin.x){
            @try {
                
                NSUInteger lengthOfString = string.length;
                for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {
                    unichar character = [string characterAtIndex:loopIndex];
                    if (character < 48) return NO; // 48 unichar for 0
                    if (character > 57) return NO; // 57 unichar for 9
                }
                
            } @catch (NSException *exception) {
                return  YES;
                
                NSLog(@"----exception in homepage ----");
                NSLog(@"---- exception in texField: shouldChangeCharactersInRange:replalcement----%@",exception);
            }
            
        }
        
        
        //added by Srinivasulu on 10/10/2017 && 29/03/2018....
        
        
        else if(textField == remarksTxt){
            
            return  YES;
        }
        else if(textField.frame.origin.x == totalNoOfWalkinsTxt.frame.origin.x){
            
            
            
            @try {
                
                NSUInteger lengthOfString = string.length;
                for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {
                    unichar character = [string characterAtIndex:loopIndex];
                    if (character < 48) return NO; // 48 unichar for 0
                    if (character > 57) return NO; // 57 unichar for 9
                }
            } @catch (NSException *exception) {
                return  YES;
                
                NSLog(@"----exception in homepage ----");
                NSLog(@"---- exception in texField: shouldChangeCharactersInRange:replalcement----%@",exception);
            }
            
        }
        else if(!tenderModesView.hidden && tenderModesView != nil){
            
            @try {
                
                NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
                NSString *expression = @"^[0-9]*((\\.)[0-9]{0,2})?$";
                NSError *error = nil;
                NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
                NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString options:0 range:NSMakeRange(0, newString.length)];
                return numberOfMatches != 0;
                
            } @catch (NSException *exception) {
                
                return  YES;
            }
            
        }
        
        //upto here on 10/10/2017....
        return  YES;
        
    } @catch (NSException *exception) {
        
        NSLog(@"----exception in the homepage in shouldChangeCharactersInRange:----");
        NSLog(@"------exception while creating the popUp in stockView------%@",exception);
        return  YES;
    }
    @finally{
        
        @try {
            
            if(textField != totalNoOfWalkinsTxt && textField != remarksTxt  && totalNoOfWalkinsTxt != nil)
                if(((totalNoOfWalkinsTxt.text).intValue - (textField.text).intValue) >= 0)
                    totalNoOfWalkinsTxt.text = [NSString stringWithFormat:@"%i", ((totalNoOfWalkinsTxt.text).intValue - (textField.text).intValue)];
            
        } @catch (NSException *exception) {
            
        }
        
    }
}

/**
 * @description  it is an textFieldDelegate method it will be executed for ever character change........
 * @date         30/08/2017....
 * @method       textFieldDidChange:
 * @author       Srinivasulu
 * @param        UITextField
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)textFieldDidChange:(UITextField *)textField {
    
    //    if(textField.frame.origin.x == denomValueTxt.frame.origin.x){
    //
    //        @try {
    //            float textFieldCount = textField.frame.origin.y / 70;
    //
    //            if(textFieldCount > [denomCountCoinsArr count]){
    //
    //                oneCount = 0;
    //                oneCount = [textField.text intValue];
    //
    //                //here we are check whether user has enter the any text or not....
    //
    //                if (oneCount > 0) {
    //
    //                    [denominationCoinDic setValue:[NSString stringWithFormat:@"%d",oneCount] forKey:[NSString stringWithFormat:@"%d",(int)textField.tag]];
    //
    //                }
    //                else{
    //
    //                    if ([[denominationCoinDic allKeys] containsObject:[NSString stringWithFormat:@"%d",(int)textField.tag]]) {
    //                        [denominationCoinDic removeObjectForKey:[NSString stringWithFormat:@"%d",(int)textField.tag]];
    //                    }
    //                }
    //
    //                for (UITextField *text in denomValCoinsTxtArr) {
    //
    //                    if (text.tag == textField.tag) {
    //                        text.text = [NSString stringWithFormat:@"%d",oneCount];
    //
    //                        break;
    //                    }
    //                }
    //
    //                for (UILabel *text in denomCountCoinsArr) {
    //
    //                    if (text.tag == textField.tag) {
    //                        text.text = [NSString stringWithFormat:@"%.2f",(float)(oneCount * textField.tag)];
    //                        break;
    //
    //                    }
    //                }
    //
    //
    //            }
    //            else{
    //
    //
    //                oneCount = 0;
    //                oneCount = [textField.text intValue];
    //                tensQty.text = [NSString stringWithFormat:@"%d",tensCount];
    //                if (oneCount > 0) {
    //                    [denominationDic setValue:[NSString stringWithFormat:@"%d",oneCount] forKey:[NSString stringWithFormat:@"%d",(int)textField.tag]];
    //
    //                }
    //                else{
    //                    tenValue.text = [NSString stringWithFormat:@"%.2f",(tensCount * 10.00)];
    //                    if ([[denominationDic allKeys] containsObject:[NSString stringWithFormat:@"%d",(int)textField.tag]]) {
    //                        [denominationDic removeObjectForKey:[NSString stringWithFormat:@"%d",(int)textField.tag]];
    //                    }
    //                }
    //
    //                for (UITextField *text in denomValTxtArr) {
    //
    //                    if (text.tag == textField.tag) {
    //                        text.text = [NSString stringWithFormat:@"%d",oneCount];
    //
    //
    //                    }
    //                }
    //
    //                for (UILabel *text in denomCountArr) {
    //
    //                    if (text.tag == textField.tag) {
    //                        text.text = [NSString stringWithFormat:@"%.2f",(float)(oneCount * textField.tag)];
    //
    //                    }
    //                }
    //
    //            }
    //        } @catch (NSException *exception) {
    //
    //        }
    //
    //    }
    
    //aded by Srinivasulu on 10/10/2017 && 29/03/2018....
    
    if(textField == remarksTxt){
        //just to handled/overcome the below comparing for origin x....
        
    }
    else if(textField == totalNoOfWalkinsTxt){
        
        @try {
            
            
            
        } @catch (NSException *exception) {
            
        }
    }
    else if(textField.frame.origin.x == totalNoOfWalkinsTxt.frame.origin.x){
        
        @try {
            
            totalNoOfWalkinsTxt.text = [NSString stringWithFormat:@"%i", ((totalNoOfWalkinsTxt.text).intValue + (textField.text).intValue)];
        } @catch (NSException *exception) {
            
        }
        
    }
    else if(!tenderModesView.hidden && tenderModesView != nil){
        
        @try {
            
            paymentModesAmountArr[textField.tag] = textField.text;
            
            float totalAmount = 0.0;
            
            for(NSString * str in paymentModesAmountArr){
                
                totalAmount = totalAmount + str.floatValue;
            }
            
            userEnteredTotalsValueLbl.text = [NSString stringWithFormat:@"%.2f",totalAmount];
        } @catch (NSException *exception) {
            
        }
    }
    
    //upto here on 10/10/2017....
    
}

/**
 * @description  It is tableFieldDelegates Method. It will executed when textFieldEndEditing.........
 * @date         30/08/2017....
 * @method       textFieldDidEndEditing:
 * @author       Srinivasulu
 * @param        UITextField
 * @param
 * @param
 * @return       void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */


-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    @try {
        
        @try {
            
            
            [self keyboardWillHide];
            offSetViewTo =  0;
        } @catch (NSException *exception) {
            
        }
        
        if(textField.frame.origin.x == denomValueTxt.frame.origin.x){
            
            float textFieldCount = textField.frame.origin.y / 70;
            
            if(textFieldCount > denomCountCoinsArr.count){
                
                oneCount = 0;
                oneCount = (textField.text).intValue;
                
                //here we are check whether user has enter the any text or not....
                
                if (oneCount > 0) {
                    
                    [denominationCoinDic setValue:[NSString stringWithFormat:@"%d",oneCount] forKey:[NSString stringWithFormat:@"%d",(int)textField.tag]];
                    
                }
                else{
                    
                    if ([denominationCoinDic.allKeys containsObject:[NSString stringWithFormat:@"%d",(int)textField.tag]]) {
                        [denominationCoinDic removeObjectForKey:[NSString stringWithFormat:@"%d",(int)textField.tag]];
                    }
                }
                
                for (UITextField *text in denomValCoinsTxtArr) {
                    
                    if (text.tag == textField.tag) {
                        text.text = [NSString stringWithFormat:@"%d",oneCount];
                        
                        break;
                    }
                }
                
                for (UILabel *text in denomCountCoinsArr) {
                    
                    if (text.tag == textField.tag) {
                        text.text = [NSString stringWithFormat:@"%.2f",(float)(oneCount * textField.tag)];
                        break;
                        
                    }
                }
                
                
            }
            else{
                
                
                oneCount = 0;
                oneCount = (textField.text).intValue;
                tensQty.text = [NSString stringWithFormat:@"%d",tensCount];
                if (oneCount > 0) {
                    [denominationDic setValue:[NSString stringWithFormat:@"%d",oneCount] forKey:[NSString stringWithFormat:@"%d",(int)textField.tag]];
                    
                }
                else{
                    tenValue.text = [NSString stringWithFormat:@"%.2f",(tensCount * 10.00)];
                    if ([denominationDic.allKeys containsObject:[NSString stringWithFormat:@"%d",(int)textField.tag]]) {
                        [denominationDic removeObjectForKey:[NSString stringWithFormat:@"%d",(int)textField.tag]];
                    }
                }
                
                for (UITextField *text in denomValTxtArr) {
                    
                    if (text.tag == textField.tag) {
                        text.text = [NSString stringWithFormat:@"%d",oneCount];
                        
                    }
                }
                
                for (UILabel *text in denomCountArr) {
                    
                    if (text.tag == textField.tag) {
                        text.text = [NSString stringWithFormat:@"%.2f",(float)(oneCount * textField.tag)];
                        
                    }
                }
                
            }
        }
        
        //added by Srinivasulu on 10/10/2017....
        
        if(textField == remarksTxt){
            //just to handled/overcome the below comparing for origin x....
            
        }
        else if(textField == totalNoOfWalkinsTxt){
            
            @try {
                
                
                
            } @catch (NSException *exception) {
                
            }
        }
        else if(textField.frame.origin.x == totalNoOfWalkinsTxt.frame.origin.x){
            
            @try {
                
                //reason in textField did change it is already existing....
                //                totalNoOfWalkinsTxt.text = [NSString stringWithFormat:@"%i", ([totalNoOfWalkinsTxt.text intValue] + [textField.text intValue])];
            } @catch (NSException *exception) {
                
            }
            
        }
        //upto here on 10/10/2017....
        
    } @catch (NSException *exception) {
        
    }
    
}

/**
 * @description  It is tableFieldDelegates Method. It will executed when user started entering input.........
 * @date
 * @method       textFieldShouldReturn:
 * @author
 * @param        UITextField
 * @param
 * @param
 * @return
 *
 * @modified By  Srinivasulu on 30/08/2017....
 * @reason       added the comment's....
 *
 * @verified By
 * @verified On
 *
 */

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    if (textField == tensQty){
        tensCount = 0;
        tensCount = (tensQty.text).intValue;
        tensQty.text = [NSString stringWithFormat:@"%d",tensCount];
        if (tensCount > 0) {
            [denominationDic setValue:[NSString stringWithFormat:@"%d",tensCount] forKey:@"10"];
            tenValue.text = [NSString stringWithFormat:@"%.2f",(tensCount * 10.00)];
        }
        else{
            tenValue.text = [NSString stringWithFormat:@"%.2f",(tensCount * 10.00)];
            if ([denominationDic valueForKey:@"10"]) {
                [denominationDic removeObjectForKey:@"10"];
            }
        }
        
        
    }
    else if (textField == twentyQty){
        twentyCount = 0;
        twentyCount = (twentyQty.text).intValue;
        twentyQty.text = [NSString stringWithFormat:@"%d",twentyCount];
        if (twentyCount > 0) {
            [denominationDic setValue:[NSString stringWithFormat:@"%d",twentyCount] forKey:@"20"];
            twentyValue.text = [NSString stringWithFormat:@"%.2f",(twentyCount * 20.00)];
        }
        else{
            twentyValue.text = [NSString stringWithFormat:@"%.2f",(twentyCount * 20.00)];
            if ([denominationDic valueForKey:@"20"]) {
                [denominationDic removeObjectForKey:@"20"];
            }
        }
        
    }
    else if (textField == fiftyQty){
        fiftyCount = 0;
        fiftyCount = (fiftyQty.text).intValue;
        fiftyQty.text = [NSString stringWithFormat:@"%d",fiftyCount];
        if (fiftyCount > 0) {
            [denominationDic setValue:[NSString stringWithFormat:@"%d",fiftyCount] forKey:@"50"];
            fiftyValue.text = [NSString stringWithFormat:@"%.2f",(fiftyCount * 50.00)];
        }
        else{
            fiftyValue.text = [NSString stringWithFormat:@"%.2f",(fiftyCount * 50.00)];
            if ([denominationDic valueForKey:@"50"]) {
                [denominationDic removeObjectForKey:@"50"];
            }
        }
        
    }
    else if (textField == hundredQty){
        hundredCount = 0;
        hundredCount = (hundredQty.text).intValue;
        hundredQty.text = [NSString stringWithFormat:@"%d",hundredCount];
        if (hundredCount > 0) {
            [denominationDic setValue:[NSString stringWithFormat:@"%d",hundredCount] forKey:@"100"];
            hundValue.text = [NSString stringWithFormat:@"%.2f",(hundredCount * 100.00)];
        }
        else{
            hundValue.text = [NSString stringWithFormat:@"%.2f",(hundredCount * 100.00)];
            if ([denominationDic valueForKey:@"100"]) {
                [denominationDic removeObjectForKey:@"100"];
            }
        }
        
    }
    else if (textField == fiveHundredQty){
        fiveHundredCount = 0;
        fiveHundredCount = (fiveHundredQty.text).intValue;
        fiveHundredQty.text = [NSString stringWithFormat:@"%d",fiveHundredCount];
        if (fiveHundredCount > 0) {
            [denominationDic setValue:[NSString stringWithFormat:@"%d",fiveHundredCount] forKey:@"500"];
            fiveHundValue.text = [NSString stringWithFormat:@"%.2f",(fiveHundredCount * 500.00)];
        }
        else{
            fiveHundValue.text = [NSString stringWithFormat:@"%.2f",(fiveHundredCount * 500.00)];
            if ([denominationDic valueForKey:@"500"]) {
                [denominationDic removeObjectForKey:@"500"];
            }
        }
        
    }
    else if (textField == thousandQty){
        thousandCount = 0;
        thousandCount = (thousandQty.text).intValue;
        thousandQty.text = [NSString stringWithFormat:@"%d",thousandCount];
        if (thousandCount > 0) {
            [denominationDic setValue:[NSString stringWithFormat:@"%d",thousandCount] forKey:@"2000"];
            thousandValue.text = [NSString stringWithFormat:@"%.2f",(thousandCount * 2000.00)];
        }
        else{
            thousandValue.text = [NSString stringWithFormat:@"%.2f",(thousandCount * 2000.00)];
            if ([denominationDic valueForKey:@"2000"]) {
                [denominationDic removeObjectForKey:@"2000"];
            }
        }
        
    }
    else if (textField == oneQty){
        oneCount = 0;
        oneCount = (oneQty.text).intValue;
        oneQty.text = [NSString stringWithFormat:@"%d",oneCount];
        if (oneCount > 0) {
            [denominationDic setValue:[NSString stringWithFormat:@"%d",oneCount] forKey:@"1"];
            oneValue.text = [NSString stringWithFormat:@"%.2f",(oneCount * 1.00)];
        }
        else{
            oneValue.text = [NSString stringWithFormat:@"%.2f",(oneCount * 1.00)];
            if ([denominationDic valueForKey:@"1"]) {
                [denominationDic removeObjectForKey:@"1"];
            }
        }
        
    }
    else if (textField == twoQty){
        twoCount = 0;
        twoCount = (twoQty.text).intValue;
        twoQty.text = [NSString stringWithFormat:@"%d",twoCount];
        if (twoCount > 0) {
            [denominationDic setValue:[NSString stringWithFormat:@"%d",twoCount] forKey:@"2"];
            twoValue.text = [NSString stringWithFormat:@"%.2f",(twoCount * 2.00)];
        }
        else{
            twoValue.text = [NSString stringWithFormat:@"%.2f",(twoCount *2.00)];
            if ([denominationDic valueForKey:@"2"]) {
                [denominationDic removeObjectForKey:@"2"];
            }
        }
        
    }
    else if (textField == fiveQty){
        fiveCount = 0;
        fiveCount = (fiveQty.text).intValue;
        fiveQty.text = [NSString stringWithFormat:@"%d",fiveCount];
        if (fiveCount > 0) {
            [denominationDic setValue:[NSString stringWithFormat:@"%d",fiveCount] forKey:@"5"];
            fiveValue.text = [NSString stringWithFormat:@"%.2f",(fiveCount * 5.00)];
        }
        else{
            fiveValue.text = [NSString stringWithFormat:@"%.2f",(fiveCount *5.00)];
            if ([denominationDic valueForKey:@"5"]) {
                [denominationDic removeObjectForKey:@"5"];
            }
        }
        
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        
    }
    else {
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
            if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
                
                if (textField == fiveQty || textField == twoQty || textField == oneQty) {
                    denomination.frame = CGRectMake(denomination.frame.origin.x, 60.0, denomination.frame.size.width, denomination.frame.size.height);
                }
                
                
            }
            
        }
        
    }
    
    
    
    [textField resignFirstResponder];
    
    //  giftView.frame = CGRectMake(giftView.frame.origin.x, 10, giftView.frame.size.width, giftView.frame.size.height);
    
    return YES;
}




#pragma -mark keyboard notification methods

/**
 * @description  called when keyboard is displayed
 * @date         04/06/2016
 * @method       keyboardWillShow
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)keyboardWillShow {
    // Animate the current view out of the way
    @try {
        [self setViewMovedUp:YES];
        
    } @catch (NSException *exception) {
        NSLog(@"----exception in the stockReceiptView in textFieldDidChange:----");
        NSLog(@"-------exception while changing frame self.view---------%@",exception);
        
    }
}

/**
 * @description  called when keyboard is dismissed
 * @date         04/06/2016
 * @method       keyboardWillHide
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)keyboardWillHide {
    @try {
        [self setViewMovedUp:NO];
        
    } @catch (NSException *exception) {
        NSLog(@"----exception in the stockReceiptView in textFieldDidChange:----");
        NSLog(@"-------exception while changing frame self.view---------%@",exception);
        
    }
}

/**
 * @description  method to move the view up/down whenever the keyboard is shown/dismissed
 * @date         04/06/2016
 * @method       setViewMovedUp
 * @author       Srinivasulu
 * @param        BOOL
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)setViewMovedUp:(BOOL)movedUp
{
    @try {
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3]; // if you want to slide up the view
        
        CGRect rect = self.view.frame;
        
        //    CGRect rect = scrollView.frame;
        
        if (movedUp)
        {
            // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
            rect.origin.y = (rect.origin.y -(rect.origin.y + offSetViewTo));
        }
        else
        {
            // revert back to the normal state.
            rect.origin.y +=  offSetViewTo;
        }
        self.view.frame = rect;
        //   scrollView.frame = rect;
        
        [UIView commitAnimations];
        
        /* offSetViewTo = 80;
         [self keyboardWillShow];*/
        
    } @catch (NSException *exception) {
        NSLog(@"----exception in the stockReceiptView in textFieldDidChange:----");
        NSLog(@"-------exception while changing frame self.view---------%@",exception);
    } @finally {
        
    }
    
}

/**
 * @description  in this method we are creating and displaying the GUI related to the customer walk outs....
 * @date         09/10/2017....
 * @method       showCustomerWalkOutScreen
 * @author       Srinivasulu
 * @param
 * @param
 *
 * @return       void
 *
 * @modified By  Akhila on 14/11/2017....
 * @reason       teens related GUI.. and buttons....
 *
 * @verified By
 * @verified On
 *
 
 *
 */

-(void)showCustomerWalkOutScreen{
    
    @try {
        
        int accessVal = [WebServiceUtility checkAccessPermissionsFor:@"ZReport"subFlow:@"ZReport" mainFlow:@"Reports"];
        if (accessVal == kAcessDenied) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"ACESS_DENIED", nil)] message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
            [alert show];
            
            return;
        }
        
        
        UIView * customerWalkOutsView;
        
        transperentView = [[UIView alloc] init];
        transperentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        //        PopOverViewController  * customerInfoPopUp = [[PopOverViewController alloc] init];
        
        //UILabel used for displaying header information...
        UILabel * headerlabel;
        
        UIButton * closeBtn;
        
        customerWalkOutsView = [[UIView alloc] init];
        customerWalkOutsView.opaque = NO;
        customerWalkOutsView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        customerWalkOutsView.backgroundColor = [UIColor blackColor];
        customerWalkOutsView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customerWalkOutsView.layer.borderWidth = 2.0f;
        
        headerlabel = [[UILabel alloc] init];
        headerlabel.textColor = [UIColor whiteColor];
        headerlabel.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        headerlabel.textAlignment = NSTextAlignmentCenter;
        
        
        // close button to close the view ..
        UIImage * image = [UIImage imageNamed:@"delete.png"];
        
        closeBtn = [[UIButton alloc] init] ;
        [closeBtn addTarget:self action:@selector(closeCustomerWalkOutsView:) forControlEvents:UIControlEventTouchUpInside];
        [closeBtn setBackgroundImage:image    forState:UIControlStateNormal];
        
        //start of decleration section....
        UILabel * kidsLbl;
        UILabel * womenLbl;
        UILabel * menLbl;
        UILabel * totalNoOfWalkinsLbl;
        UILabel * remarksLbl;
        
        UILabel * kidsOneLbl;
        UILabel * kidsTwoLbl;
        
        UILabel * womenOneLbl;
        UILabel * womenTwoLbl;
        UILabel * womenThreeLbl;
        
        UILabel * menOneLbl;
        UILabel * menTwoLbl;
        UILabel * menThreeLbl;
        
        UITextField * kidsOneTxt;
        UITextField * kidsTwoTxt;
        
        UITextField * womenOneTxt;
        UITextField * womenTwoTxt;
        UITextField * womenThreeTxt;
        
        UITextField * menOneTxt;
        UITextField * menTwoTxt;
        UITextField * menThreeTxt;
        
        
        //added by Akhila on 14/11/2017....
        
        UILabel * teensLbl;
        
        UILabel * teensOneLbl;
        
        UITextField * teensOneTxt;
        
        UIImage * buttonImage_;
        
        UIButton * kidsOneBtn;
        UIButton * kidsTwoBtn;
        
        UIButton * teensOneBtn;
        
        UIButton * womensOneBtn;
        UIButton * womensTwoBtn;
        UIButton * womensThreeBtn;
        
        UIButton * mensOneBtn;
        UIButton * mensTwoBtn;
        UIButton * mensThreeBtn;
        
        
        //upto here  by Akhila on 14/11/2017....
        
        UIButton * okEditItemDeatilsBtn;
        UIButton * cancelItemEditDetailsViewBtn;
        
        
        //end of deceleration section....
        
        //creation of UILabel used in page....
        kidsLbl = [[UILabel alloc] init];
        kidsLbl.textColor = [UIColor whiteColor];
        kidsLbl.font = [UIFont boldSystemFontOfSize:18.0];
        kidsLbl.textAlignment = NSTextAlignmentLeft;
        
        womenLbl = [[UILabel alloc] init];
        womenLbl.textColor = [UIColor whiteColor];
        womenLbl.font = [UIFont boldSystemFontOfSize:18.0];
        womenLbl.textAlignment = NSTextAlignmentLeft;
        
        menLbl = [[UILabel alloc] init];
        menLbl.textColor = [UIColor whiteColor];
        menLbl.font = [UIFont boldSystemFontOfSize:18.0];
        menLbl.textAlignment = NSTextAlignmentLeft;
        
        totalNoOfWalkinsLbl = [[UILabel alloc] init];
        totalNoOfWalkinsLbl.textColor = [UIColor whiteColor];
        totalNoOfWalkinsLbl.font = [UIFont boldSystemFontOfSize:18.0];
        totalNoOfWalkinsLbl.textAlignment = NSTextAlignmentLeft;
        
        remarksLbl = [[UILabel alloc] init];
        remarksLbl.textColor = [UIColor whiteColor];
        remarksLbl.font = [UIFont boldSystemFontOfSize:18.0];
        remarksLbl.textAlignment = NSTextAlignmentLeft;
        
        //creation of UILabel used in page....
        kidsOneLbl = [[UILabel alloc] init];
        kidsOneLbl.textColor = [UIColor blackColor];
        kidsOneLbl.backgroundColor = [UIColor whiteColor];
        kidsOneLbl.font = [UIFont boldSystemFontOfSize:18.0];
        kidsOneLbl.textAlignment = NSTextAlignmentLeft;
        
        kidsTwoLbl = [[UILabel alloc] init];
        kidsTwoLbl.textColor = [UIColor blackColor];
        kidsTwoLbl.backgroundColor = [UIColor whiteColor];
        kidsTwoLbl.font = [UIFont boldSystemFontOfSize:18.0];
        kidsTwoLbl.textAlignment = NSTextAlignmentLeft;
        
        womenOneLbl = [[UILabel alloc] init];
        womenOneLbl.textColor = [UIColor blackColor];
        womenOneLbl.backgroundColor = [UIColor whiteColor];
        womenOneLbl.font = [UIFont boldSystemFontOfSize:18.0];
        womenOneLbl.textAlignment = NSTextAlignmentLeft;
        
        womenTwoLbl = [[UILabel alloc] init];
        womenTwoLbl.textColor = [UIColor blackColor];
        womenTwoLbl.backgroundColor = [UIColor whiteColor];
        womenTwoLbl.font = [UIFont boldSystemFontOfSize:18.0];
        womenTwoLbl.textAlignment = NSTextAlignmentLeft;
        
        womenThreeLbl = [[UILabel alloc] init];
        womenThreeLbl.textColor = [UIColor blackColor];
        womenThreeLbl.backgroundColor = [UIColor whiteColor];
        womenThreeLbl.font = [UIFont boldSystemFontOfSize:18.0];
        womenThreeLbl.textAlignment = NSTextAlignmentLeft;
        
        menOneLbl = [[UILabel alloc] init];
        menOneLbl.textColor = [UIColor blackColor];
        menOneLbl.backgroundColor = [UIColor whiteColor];
        menOneLbl.font = [UIFont boldSystemFontOfSize:18.0];
        menOneLbl.textAlignment = NSTextAlignmentLeft;
        
        menTwoLbl = [[UILabel alloc] init];
        menTwoLbl.textColor = [UIColor blackColor];
        menTwoLbl.backgroundColor = [UIColor whiteColor];
        menTwoLbl.font = [UIFont boldSystemFontOfSize:18.0];
        menTwoLbl.textAlignment = NSTextAlignmentLeft;
        
        menThreeLbl = [[UILabel alloc] init];
        menThreeLbl.textColor = [UIColor blackColor];
        menThreeLbl.backgroundColor = [UIColor whiteColor];
        menThreeLbl.font = [UIFont boldSystemFontOfSize:18.0];
        menThreeLbl.textAlignment = NSTextAlignmentLeft;
        
        totalNoOfWalkinsLbl = [[UILabel alloc] init];
        totalNoOfWalkinsLbl.textColor = [UIColor whiteColor];
        totalNoOfWalkinsLbl.font = [UIFont boldSystemFontOfSize:18.0];
        totalNoOfWalkinsLbl.textAlignment = NSTextAlignmentLeft;
        
        remarksLbl = [[UILabel alloc] init];
        remarksLbl.textColor = [UIColor whiteColor];
        remarksLbl.font = [UIFont boldSystemFontOfSize:18.0];
        remarksLbl.textAlignment = NSTextAlignmentLeft;
        
        
        kidsOneTxt = [[UITextField alloc] init];
        kidsOneTxt.borderStyle = UITextBorderStyleRoundedRect;
        kidsOneTxt.textColor = [UIColor blackColor];
        kidsOneTxt.delegate = self;
        [kidsOneTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        kidsTwoTxt = [[UITextField alloc] init];
        kidsTwoTxt.borderStyle = UITextBorderStyleRoundedRect;
        kidsTwoTxt.textColor = [UIColor blackColor];
        kidsTwoTxt.delegate = self;
        [kidsTwoTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        womenOneTxt = [[UITextField alloc] init];
        womenOneTxt.borderStyle = UITextBorderStyleRoundedRect;
        womenOneTxt.textColor = [UIColor blackColor];
        womenOneTxt.delegate = self;
        [womenOneTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        womenTwoTxt = [[UITextField alloc] init];
        womenTwoTxt.borderStyle = UITextBorderStyleRoundedRect;
        womenTwoTxt.textColor = [UIColor blackColor];
        womenTwoTxt.delegate = self;
        [womenTwoTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        womenThreeTxt = [[UITextField alloc] init];
        womenThreeTxt.borderStyle = UITextBorderStyleRoundedRect;
        womenThreeTxt.textColor = [UIColor blackColor];
        womenThreeTxt.delegate = self;
        [womenThreeTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        menOneTxt = [[UITextField alloc] init];
        menOneTxt.borderStyle = UITextBorderStyleRoundedRect;
        menOneTxt.textColor = [UIColor blackColor];
        menOneTxt.delegate = self;
        [menOneTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        menTwoTxt = [[UITextField alloc] init];
        menTwoTxt.borderStyle = UITextBorderStyleRoundedRect;
        menTwoTxt.textColor = [UIColor blackColor];
        menTwoTxt.delegate = self;
        [menTwoTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        menThreeTxt = [[UITextField alloc] init];
        menThreeTxt.borderStyle = UITextBorderStyleRoundedRect;
        menThreeTxt.textColor = [UIColor blackColor];
        menThreeTxt.delegate = self;
        [menThreeTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        totalNoOfWalkinsTxt = [[UITextField alloc] init];
        totalNoOfWalkinsTxt.borderStyle = UITextBorderStyleRoundedRect;
        totalNoOfWalkinsTxt.textColor = [UIColor blackColor];
        totalNoOfWalkinsTxt.delegate = self;
        
        remarksTxt = [[UITextField alloc] init];
        remarksTxt.borderStyle = UITextBorderStyleRoundedRect;
        remarksTxt.textColor = [UIColor blackColor];
        remarksTxt.delegate = self;
        
        
        /** ok Button for edit price view....*/
        okEditItemDeatilsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        okEditItemDeatilsBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
        okEditItemDeatilsBtn.backgroundColor = [UIColor grayColor];
        
        //added by Srinivasulu on 10/08/2017...
        
        cancelItemEditDetailsViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelItemEditDetailsViewBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
        cancelItemEditDetailsViewBtn.backgroundColor = [UIColor grayColor];
        
        
        BOOL isDayClosed  = [[[NSUserDefaults standardUserDefaults] valueForKey:IS_DAY_CLOSURE_TAKEN] boolValue];
        
        if(!isDayClosed) {
            
            [okEditItemDeatilsBtn addTarget:self action:@selector(navigateToDayClosure:) forControlEvents:UIControlEventTouchDown];
            [cancelItemEditDetailsViewBtn addTarget:self action:@selector(navigateToDayClosure:) forControlEvents:UIControlEventTouchDown];
        }
        else {
            
            [okEditItemDeatilsBtn addTarget:self action:@selector(openZReportView:) forControlEvents:UIControlEventTouchDown];
            [cancelItemEditDetailsViewBtn addTarget:self action:@selector(openZReportView:) forControlEvents:UIControlEventTouchDown];
        }
        
        //added by Akhila on 14/11/2017....
        
        
        teensLbl = [[UILabel alloc] init];
        teensLbl.textColor = [UIColor whiteColor];
        teensLbl.font = [UIFont boldSystemFontOfSize:18.0];
        teensLbl.textAlignment = NSTextAlignmentLeft;
        
        teensOneLbl = [[UILabel alloc] init];
        teensOneLbl.textColor = [UIColor blackColor];
        teensOneLbl.backgroundColor = [UIColor whiteColor];
        teensOneLbl.font = [UIFont boldSystemFontOfSize:18.0];
        teensOneLbl.textAlignment = NSTextAlignmentLeft;
        
        
        teensOneTxt = [[UITextField alloc]init];
        teensOneTxt.borderStyle = UITextBorderStyleRoundedRect;
        teensOneTxt.textColor =[UIColor blackColor];
        teensOneTxt.delegate =self;
        [teensOneTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        buttonImage_ = [UIImage imageNamed:@"arrow_1.png"];
        
        kidsOneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [kidsOneBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
        
        kidsTwoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [kidsTwoBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
        
        teensOneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [teensOneBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
        
        
        womensOneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [womensOneBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
        
        womensTwoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [womensTwoBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
        
        
        
        womensThreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [womensThreeBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
        
        
        mensOneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [mensOneBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
        
        
        mensTwoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [mensTwoBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
        
        
        mensThreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [mensThreeBtn setBackgroundImage:buttonImage_ forState:UIControlStateNormal];
        
        
        //upto here  by Akhila on 14/11/2017....
        
        
        //here we are populating text into UILabels and UITextFields....
        @try {
            
            headerlabel.text = NSLocalizedString(@"z_report_customer_walk_ins", nil);
            
            kidsLbl.text = NSLocalizedString(@"kids", nil);
            womenLbl.text = NSLocalizedString(@"women", nil);
            menLbl.text = NSLocalizedString(@"men", nil);
            totalNoOfWalkinsLbl.text = NSLocalizedString(@"total_no_of_walk_ins", nil);
            remarksLbl.text = NSLocalizedString(@"remarks", nil);
            
            kidsOneLbl.text = NSLocalizedString(@"2_to_7", nil);
            kidsTwoLbl.text = NSLocalizedString(@"8_to_12", nil);
            
            //added by Akhila on 14/11/2017....
            
            teensLbl.text = NSLocalizedString(@"teens", nil);
            teensOneLbl.text = NSLocalizedString(@"13_to_19",nil);
            
            //upto here  by Akhila on 14/11/2017....
            
            
            
            womenOneLbl.text = NSLocalizedString(@"20_to_40", nil);
            womenTwoLbl.text = NSLocalizedString(@"41_to_60", nil);
            womenThreeLbl.text = NSLocalizedString(@"61_to_above", nil);
            
            menOneLbl.text = NSLocalizedString(@"20_to_40", nil);
            menTwoLbl.text = NSLocalizedString(@"41_to_60", nil);
            menThreeLbl.text = NSLocalizedString(@"61_to_above", nil);
            
            //            kidsOneLbl.layer.cornerRadius = 10;
            //            kidsTwoLbl.layer.cornerRadius = 10;
            //
            //            womenOneLbl.layer.cornerRadius = 10;
            //            womenTwoLbl.layer.cornerRadius = 10;
            //            womenThreeLbl.layer.cornerRadius = 10;
            //
            //            menOneLbl.layer.cornerRadius = 10;
            //            menTwoLbl.layer.cornerRadius = 10;
            //            menThreeLbl.layer.cornerRadius = 10;
            
            [okEditItemDeatilsBtn setTitle:NSLocalizedString(@"submit_", nil) forState:UIControlStateNormal];
            [cancelItemEditDetailsViewBtn setTitle:NSLocalizedString(@"skip", nil) forState:UIControlStateNormal];
            okEditItemDeatilsBtn.tag = 1;
            cancelItemEditDetailsViewBtn.tag = 0;
            
        } @catch (NSException *exception) {
            
        }
        
        
        [customerWalkOutsView addSubview:headerlabel];
        [customerWalkOutsView addSubview:closeBtn];
        
        [customerWalkOutsView addSubview:kidsLbl];
        [customerWalkOutsView addSubview:womenLbl];
        [customerWalkOutsView addSubview:menLbl];
        [customerWalkOutsView addSubview:totalNoOfWalkinsLbl];
        [customerWalkOutsView addSubview:remarksLbl];
        
        [customerWalkOutsView addSubview:kidsOneLbl];
        [customerWalkOutsView addSubview:kidsTwoLbl];
        
        [customerWalkOutsView addSubview:womenOneLbl];
        [customerWalkOutsView addSubview:womenTwoLbl];
        [customerWalkOutsView addSubview:womenThreeLbl];
        
        [customerWalkOutsView addSubview:menOneLbl];
        [customerWalkOutsView addSubview:menTwoLbl];
        [customerWalkOutsView addSubview:menThreeLbl];
        
        [customerWalkOutsView addSubview:kidsOneTxt];
        [customerWalkOutsView addSubview:kidsTwoTxt];
        
        [customerWalkOutsView addSubview:womenOneTxt];
        [customerWalkOutsView addSubview:womenTwoTxt];
        [customerWalkOutsView addSubview:womenThreeTxt];
        
        [customerWalkOutsView addSubview:menOneTxt];
        [customerWalkOutsView addSubview:menTwoTxt];
        [customerWalkOutsView addSubview:menThreeTxt];
        
        [customerWalkOutsView addSubview:totalNoOfWalkinsTxt];
        [customerWalkOutsView addSubview:remarksTxt];
        
        [customerWalkOutsView addSubview:okEditItemDeatilsBtn];
        [customerWalkOutsView addSubview:cancelItemEditDetailsViewBtn];
        
        
        //added by Akhila on 14/11/2017....
        
        [customerWalkOutsView addSubview:teensLbl];
        
        [customerWalkOutsView addSubview:teensOneLbl];
        
        [customerWalkOutsView addSubview:teensOneTxt];
        
        [customerWalkOutsView addSubview:kidsOneBtn];
        [customerWalkOutsView addSubview:kidsTwoBtn];
        
        [customerWalkOutsView addSubview:teensOneBtn];
        
        [customerWalkOutsView addSubview:womensOneBtn];
        [customerWalkOutsView addSubview:womensTwoBtn];
        [customerWalkOutsView addSubview:womensThreeBtn];
        
        [customerWalkOutsView addSubview:mensOneBtn];
        [customerWalkOutsView addSubview:mensTwoBtn];
        [customerWalkOutsView addSubview:mensThreeBtn];
        
        //upto here  by Akhila on 14/11/2017....
        
        [transperentView addSubview:customerWalkOutsView];
        
        [self.view addSubview:transperentView];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
            }
            else{
            }
            
            transperentView.frame = self.view.frame;
            
            headerlabel.frame = CGRectMake(0, 0, 450, 50);
            
            closeBtn.frame =  CGRectMake( headerlabel.frame.size.width - 50, 5, 40, 40);
            
            kidsLbl.frame = CGRectMake( headerlabel.frame.origin.x + 10, headerlabel.frame.origin.y +  headerlabel.frame.size.height + 12, 100, 40);
            
            kidsOneLbl.frame = CGRectMake( kidsLbl.frame.origin.x + kidsLbl.frame.size.width, kidsLbl.frame.origin.y, 150, 40);
            kidsTwoLbl.frame = CGRectMake( kidsOneLbl.frame.origin.x, kidsOneLbl.frame.origin.y + kidsOneLbl.frame.size.height + 10, kidsOneLbl.frame.size.width, kidsOneLbl.frame.size.height);
            
            
            //added by Akhila on 14/11/2017....
            
            teensLbl.frame = CGRectMake( kidsLbl.frame.origin.x, kidsTwoLbl.frame.origin.y +  kidsTwoLbl.frame.size.height + 10, kidsLbl.frame.size.width, kidsLbl.frame.size.height);
            
            teensOneLbl.frame = CGRectMake( kidsOneLbl.frame.origin.x, teensLbl.frame.origin.y , kidsOneLbl.frame.size.width, kidsOneLbl.frame.size.height);
            
            womenLbl.frame = CGRectMake( kidsLbl.frame.origin.x, teensOneLbl.frame.origin.y +  teensOneLbl.frame.size.height + 10, kidsLbl.frame.size.width, kidsLbl.frame.size.height);
            
            //upto here  by Akhila on 14/11/2017....
            
            
            
            womenOneLbl.frame = CGRectMake( kidsOneLbl.frame.origin.x, womenLbl.frame.origin.y , kidsOneLbl.frame.size.width, kidsOneLbl.frame.size.height);
            womenTwoLbl.frame = CGRectMake( kidsOneLbl.frame.origin.x, womenOneLbl.frame.origin.y + womenOneLbl.frame.size.height + 10, kidsOneLbl.frame.size.width, kidsOneLbl.frame.size.height);
            womenThreeLbl.frame = CGRectMake( kidsOneLbl.frame.origin.x, womenTwoLbl.frame.origin.y + womenTwoLbl.frame.size.height + 10, kidsOneLbl.frame.size.width, kidsOneLbl.frame.size.height);
            
            menLbl.frame = CGRectMake( kidsLbl.frame.origin.x, womenThreeLbl.frame.origin.y +  womenThreeLbl.frame.size.height + 10, kidsLbl.frame.size.width, kidsLbl.frame.size.height);
            
            menOneLbl.frame = CGRectMake( kidsOneLbl.frame.origin.x, menLbl.frame.origin.y , kidsOneLbl.frame.size.width, kidsOneLbl.frame.size.height);
            menTwoLbl.frame = CGRectMake( kidsOneLbl.frame.origin.x, menOneLbl.frame.origin.y + menOneLbl.frame.size.height + 10, kidsOneLbl.frame.size.width, kidsOneLbl.frame.size.height);
            menThreeLbl.frame = CGRectMake( kidsOneLbl.frame.origin.x, menTwoLbl.frame.origin.y + menTwoLbl.frame.size.height + 10, kidsOneLbl.frame.size.width, kidsOneLbl.frame.size.height);
            
            kidsOneTxt.frame = CGRectMake( kidsOneLbl.frame.origin.x + kidsOneLbl.frame.size.width + 10, kidsOneLbl.frame.origin.y, 150, 40);
            kidsTwoTxt.frame = CGRectMake( kidsOneTxt.frame.origin.x, kidsTwoLbl.frame.origin.y, kidsOneTxt.frame.size.width, kidsOneTxt.frame.size.height);
            
            
            //added by Akhila on 14/11/2017....
            
            teensOneTxt.frame = CGRectMake( kidsOneTxt.frame.origin.x, teensLbl.frame.origin.y, kidsOneTxt.frame.size.width, kidsOneTxt.frame.size.height);
            
            //upto here  by Akhila on 14/11/2017....
            
            
            womenOneTxt.frame = CGRectMake( kidsOneTxt.frame.origin.x, womenOneLbl.frame.origin.y, kidsOneTxt.frame.size.width, kidsOneTxt.frame.size.height);
            womenTwoTxt.frame = CGRectMake( kidsOneTxt.frame.origin.x, womenTwoLbl.frame.origin.y, kidsOneTxt.frame.size.width, kidsOneTxt.frame.size.height);
            womenThreeTxt.frame = CGRectMake( kidsOneTxt.frame.origin.x, womenThreeLbl.frame.origin.y, kidsOneTxt.frame.size.width, kidsOneTxt.frame.size.height);
            
            menOneTxt.frame = CGRectMake( kidsOneTxt.frame.origin.x, menOneLbl.frame.origin.y, kidsOneTxt.frame.size.width, kidsOneTxt.frame.size.height);
            menTwoTxt.frame = CGRectMake( kidsOneTxt.frame.origin.x, menTwoLbl.frame.origin.y, kidsOneTxt.frame.size.width, kidsOneTxt.frame.size.height);
            menThreeTxt.frame = CGRectMake( kidsOneTxt.frame.origin.x, menThreeLbl.frame.origin.y, kidsOneTxt.frame.size.width, kidsOneTxt.frame.size.height);
            
            totalNoOfWalkinsLbl.frame = CGRectMake( kidsLbl.frame.origin.x + 10, menThreeTxt.frame.origin.y +  menThreeTxt.frame.size.height + 10, 240, kidsLbl.frame.size.height);
            
            remarksLbl.frame = CGRectMake( totalNoOfWalkinsLbl.frame.origin.x, totalNoOfWalkinsLbl.frame.origin.y +  totalNoOfWalkinsLbl.frame.size.height + 10, totalNoOfWalkinsLbl.frame.size.width, kidsLbl.frame.size.height);
            
            totalNoOfWalkinsTxt.frame  = CGRectMake( menTwoTxt.frame.origin.x, totalNoOfWalkinsLbl.frame.origin.y, menOneTxt.frame.size.width, kidsLbl.frame.size.height);
            
            remarksTxt.frame  = CGRectMake( totalNoOfWalkinsTxt.frame.origin.x, remarksLbl.frame.origin.y, menOneTxt.frame.size.width, kidsLbl.frame.size.height);
            
            okEditItemDeatilsBtn.frame = CGRectMake( (headerlabel.frame.size.width - 300) / 3, remarksTxt.frame.origin.y + remarksTxt.frame.size.height + 20, 150, 45);
            
            cancelItemEditDetailsViewBtn.frame = CGRectMake( 2 * okEditItemDeatilsBtn.frame.origin.x + okEditItemDeatilsBtn.frame.size.width, okEditItemDeatilsBtn.frame.origin.y, okEditItemDeatilsBtn.frame.size.width, okEditItemDeatilsBtn.frame.size.height);
            
            
            //added by Akhila on 14/11/2017....
            
            kidsOneBtn.frame = CGRectMake( (kidsOneLbl.frame.origin.x + kidsOneLbl.frame.size.width - 35),kidsOneLbl.frame.origin.y - 1,kidsOneTxt.frame.size.height,kidsOneTxt.frame.size.height);
            
            kidsTwoBtn.frame = CGRectMake( kidsOneBtn.frame.origin.x, kidsTwoLbl.frame.origin.y - 1, kidsOneBtn.frame.size.width, kidsOneBtn.frame.size.height);
            
            teensOneBtn.frame = CGRectMake( kidsOneBtn.frame.origin.x, teensOneLbl.frame.origin.y - 1, kidsOneBtn.frame.size.width, kidsOneBtn.frame.size.height);
            womensOneBtn.frame = CGRectMake( kidsOneBtn.frame.origin.x, womenOneLbl.frame.origin.y - 1, kidsOneBtn.frame.size.width, kidsOneBtn.frame.size.height);
            womensTwoBtn.frame =CGRectMake( kidsOneBtn.frame.origin.x, womenTwoLbl.frame.origin.y - 1, kidsOneBtn.frame.size.width, kidsOneBtn.frame.size.height);
            womensThreeBtn.frame =CGRectMake( kidsOneBtn.frame.origin.x, womenThreeLbl.frame.origin.y - 1, kidsOneBtn.frame.size.width ,kidsOneBtn.frame.size.width);
            mensOneBtn.frame = CGRectMake( kidsOneBtn.frame.origin.x, menOneLbl.frame.origin.y - 1, kidsOneBtn.frame.size.width, kidsOneBtn.frame.size.height);
            mensTwoBtn.frame =CGRectMake( kidsOneBtn.frame.origin.x, menTwoLbl.frame.origin.y - 1, kidsOneBtn.frame.size.width, kidsOneBtn.frame.size.height);
            mensThreeBtn.frame =CGRectMake( kidsOneBtn.frame.origin.x, menThreeLbl.frame.origin.y - 1, kidsOneBtn.frame.size.width, kidsOneBtn.frame.size.height);
            
            float originYPosition = 80;
            
            if(80 < ((transperentView.frame.size.height - (okEditItemDeatilsBtn.frame.origin.y +  okEditItemDeatilsBtn.frame.size.height + 12)) / 2))
                originYPosition = (transperentView.frame.size.height - (okEditItemDeatilsBtn.frame.origin.y +  okEditItemDeatilsBtn.frame.size.height + 12)) / 2;
            
            
            customerWalkOutsView.frame = CGRectMake( (transperentView.frame.size.width - headerlabel.frame.size.width) / 2, originYPosition, headerlabel.frame.size.width, okEditItemDeatilsBtn.frame.origin.y +  okEditItemDeatilsBtn.frame.size.height + 12);
            
            
            //upto here  by Akhila on 14/11/2017....
            
            
            [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:customerWalkOutsView andSubViews:YES fontSize:22 cornerRadius:10];
            
            headerlabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:24];
            
            kidsOneLbl.layer.cornerRadius = 5;
            kidsTwoLbl.layer.cornerRadius = 5;
            
            //added by Akhila on 14/11/2017....
            
            teensOneLbl.layer.cornerRadius = 5;
            
            //upto here  by Akhila on 14/11/2017....
            
            womenOneLbl.layer.cornerRadius = 5;
            womenTwoLbl.layer.cornerRadius = 5;
            womenThreeLbl.layer.cornerRadius = 5;
            
            menOneLbl.layer.cornerRadius = 5;
            menTwoLbl.layer.cornerRadius = 5;
            menThreeLbl.layer.cornerRadius = 5;
            
            [kidsOneLbl setClipsToBounds:YES];
            [kidsTwoLbl setClipsToBounds:YES];
            
            [womenOneLbl setClipsToBounds:YES];
            [womenTwoLbl setClipsToBounds:YES];
            [womenThreeLbl setClipsToBounds:YES];
            
            [menOneLbl setClipsToBounds:YES];
            [menTwoLbl setClipsToBounds:YES];
            [menThreeLbl setClipsToBounds:YES];
            
            
        }
        else{
            
        }
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

/**
 * @description  here we are dismissing the customerWalkOutsView....
 * @date         09/10/2017....
 * @method       closeCustomerWalkOutsView:
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @param
 * @param
 * @param
 *
 * @return
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)closeCustomerWalkOutsView:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    @try {
        
        if ([transperentView isDescendantOfView:self.view])
            [transperentView removeFromSuperview];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

/**
 * @description  here we are navigating current class to z-report....
 * @date         09/10/2017....
 * @method       openZReportView:
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @param
 * @param
 * @param
 *
 * @return      void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)openZReportView:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    @try {
        NSString * value = [totalNoOfWalkinsTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        if(sender.tag && (!value.length)){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"please_enter_no_of_walkins_for_the_day", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        
        if ([transperentView isDescendantOfView:self.view])
            [transperentView removeFromSuperview];
        
        ZReportController * report = [[ZReportController alloc] init];
        
        report.totalCustomerWalkOuts = value;
        report.walkOutReason = remarksTxt.text;
        report.callWalkinService = sender.tag;
        
        [self.navigationController pushViewController:report animated:YES];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}


-(NSMutableArray *)isThereAnyBillsToDelete{
    
    NSMutableArray * billIdsArr = [[NSMutableArray alloc] init];
    
    @try {
        
        NSUserDefaults * userDefaults = [[NSUserDefaults alloc] init];
        
        NSString * previousDate;
        
        if ( [[userDefaults dictionaryRepresentation].allKeys containsObject:OFFLINE_DATA_TIME_OUT_DAYS] && ![[userDefaults valueForKey:OFFLINE_DATA_TIME_OUT_DAYS] isKindOfClass:[NSNull class]]){
            
            if([[userDefaults valueForKey:OFFLINE_DATA_TIME_OUT_DAYS] floatValue] <= 0){
                
                return billIdsArr;
            }
            else{
                
                previousDate = [WebServiceUtility getPreviousDate:(([[userDefaults valueForKey:OFFLINE_DATA_TIME_OUT_DAYS] floatValue] * 24 * 60 * 60) + ([[userDefaults valueForKey:OFFLINE_DATA_TIME_OUT_HOURS] floatValue] * 60 * 60))];
            }
        }
        //        else
        //        previousDate = [WebServiceUtility getPreviousDate:86400];
        
        
        previousDate = [previousDate stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
        
        
        
        static sqlite3 * localDatabase = nil;
        static sqlite3_stmt * localSelectStmt =nil;
        
        
        NSString* dbPath = [DataBaseConnection connection:@"RetailerBillingDataBase.sqlite"];
        
        if(sqlite3_open(dbPath.UTF8String, & localDatabase) == SQLITE_OK) {
            NSString *query;
            
            
            //            query = [NSString stringWithFormat:@"select count (*) from billing_table where save_status == 'Success' and   DATE(substr(date_and_time,7,4) ||'-' ||substr(date_and_time,4,2) ||'-'||substr(date_and_time,1,2)) >= ('%@')",previousDate];
            query = [NSString stringWithFormat:@"select bill_id from billing_table where save_status == 'Success' and   DATE(substr(date_and_time,7,4) ||'-' ||substr(date_and_time,4,2) ||'-'||substr(date_and_time,1,2)) >= ('%@')",previousDate];
            
            const char * sqlStatement = query.UTF8String;
            
            if(sqlite3_prepare_v2(localDatabase, sqlStatement, -1, &localSelectStmt, NULL) == SQLITE_OK) {
                
                if(sqlite3_column_count(localSelectStmt))
                    while (sqlite3_step(localSelectStmt) == SQLITE_ROW) {
                        
                        NSString  * bill_id = @((char *)sqlite3_column_text(localSelectStmt, 0));
                        
                        [billIdsArr addObject:bill_id];
                    }
                
                sqlite3_reset(localSelectStmt);
                sqlite3_finalize(localSelectStmt);
            }
            else {
                
                NSLog(@"%s",sqlite3_errmsg(localDatabase)) ;
            }
            
        }
        
        return  billIdsArr;
        
    } @catch (NSException *exception) {
        return  billIdsArr;
        
    } @finally {
        
    }
    
}

-(void)deleteCompleteBillInformationFromLocalDB:(NSString *)bill_id{
    
    static sqlite3 * localDatabase = nil;
    static sqlite3_stmt * localDeleteStmt =nil;
    
    @try {
        
        NSString* dbPath = [DataBaseConnection connection:@"RetailerBillingDataBase.sqlite"];
        
        if(sqlite3_open(dbPath.UTF8String, &localDatabase) == SQLITE_OK) {
            
            if (localDeleteStmt == nil) {
                
                NSString * query = [NSString stringWithFormat:@"delete from billing_denomination where bill_id = '%@'",bill_id];
                const char * sqlStatement = query.UTF8String;
                
                if(sqlite3_prepare_v2(localDatabase, sqlStatement, -1, &localDeleteStmt, NULL) == SQLITE_OK) {
                    
                    if(SQLITE_DONE != sqlite3_step(localDeleteStmt)){
                        NSLog(@"%s",sqlite3_errmsg(localDatabase));
                        NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(localDatabase));
                    }
                    else {
                        
                    }
                    sqlite3_reset(localDeleteStmt);
                }
                localDeleteStmt = nil;
            }
            
            if (localDeleteStmt == nil) {
                
                NSString * query = [NSString stringWithFormat:@"delete from billing_item_taxes where bill_id = '%@'",bill_id];
                const char * sqlStatement = query.UTF8String;
                
                if(sqlite3_prepare_v2(localDatabase, sqlStatement, -1, &localDeleteStmt, NULL) == SQLITE_OK) {
                    
                    if(SQLITE_DONE != sqlite3_step(localDeleteStmt)){
                        NSLog(@"%s",sqlite3_errmsg(localDatabase));
                        NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(localDatabase));
                    }
                    else {
                        
                    }
                    sqlite3_reset(localDeleteStmt);
                }
                localDeleteStmt = nil;
            }
            
            if (localDeleteStmt == nil) {
                
                NSString * query = [NSString stringWithFormat:@"delete from billing_discounts where bill_id = '%@'",bill_id];
                const char * sqlStatement = query.UTF8String;
                
                if(sqlite3_prepare_v2(localDatabase, sqlStatement, -1, &localDeleteStmt, NULL) == SQLITE_OK) {
                    
                    if(SQLITE_DONE != sqlite3_step(localDeleteStmt)){
                        NSLog(@"%s",sqlite3_errmsg(localDatabase));
                        NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(localDatabase));
                    }
                    else {
                        
                    }
                    sqlite3_reset(localDeleteStmt);
                }
                localDeleteStmt = nil;
            }
            
            if (localDeleteStmt == nil) {
                
                NSString * query = [NSString stringWithFormat:@"delete from billing_taxes where bill_id = '%@'",bill_id];
                const char * sqlStatement = query.UTF8String;
                
                if(sqlite3_prepare_v2(localDatabase, sqlStatement, -1, &localDeleteStmt, NULL) == SQLITE_OK) {
                    
                    if(SQLITE_DONE != sqlite3_step(localDeleteStmt)){
                        NSLog(@"%s",sqlite3_errmsg(localDatabase));
                        NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(localDatabase));
                    }
                    else {
                        
                    }
                    sqlite3_reset(localDeleteStmt);
                }
                localDeleteStmt = nil;
            }
            
            if (localDeleteStmt == nil) {
                
                NSString * query = [NSString stringWithFormat:@"delete from billing_transactions where bill_id = '%@'",bill_id];
                const char * sqlStatement = query.UTF8String;
                
                if(sqlite3_prepare_v2(localDatabase, sqlStatement, -1, &localDeleteStmt, NULL) == SQLITE_OK) {
                    
                    if(SQLITE_DONE != sqlite3_step(localDeleteStmt)){
                        NSLog(@"%s",sqlite3_errmsg(localDatabase));
                        NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(localDatabase));
                    }
                    else {
                        
                    }
                    sqlite3_reset(localDeleteStmt);
                }
                localDeleteStmt = nil;
            }
            
            
            if (localDeleteStmt == nil) {
                
                NSString * query = [NSString stringWithFormat:@"delete from return_items where bill_id = '%@'",bill_id];
                const char * sqlStatement = query.UTF8String;
                
                if(sqlite3_prepare_v2(localDatabase, sqlStatement, -1, &localDeleteStmt, NULL) == SQLITE_OK) {
                    
                    if(SQLITE_DONE != sqlite3_step(localDeleteStmt)){
                        NSLog(@"%s",sqlite3_errmsg(localDatabase));
                        NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(localDatabase));
                    }
                    else {
                        
                    }
                    sqlite3_reset(localDeleteStmt);
                }
                localDeleteStmt = nil;
            }
            
            if (localDeleteStmt == nil) {
                
                NSString * query = [NSString stringWithFormat:@"delete from exchange_items where bill_id = '%@'",bill_id];
                const char * sqlStatement = query.UTF8String;
                
                if(sqlite3_prepare_v2(localDatabase, sqlStatement, -1, &localDeleteStmt, NULL) == SQLITE_OK) {
                    
                    if(SQLITE_DONE != sqlite3_step(localDeleteStmt)){
                        NSLog(@"%s",sqlite3_errmsg(localDatabase));
                        NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(localDatabase));
                    }
                    else {
                        
                    }
                    sqlite3_reset(localDeleteStmt);
                }
                localDeleteStmt = nil;
            }
            
            if (localDeleteStmt == nil) {
                
                NSString * query = [NSString stringWithFormat:@"delete from billing_items where bill_id = '%@'",bill_id];
                const char * sqlStatement = query.UTF8String;
                
                if(sqlite3_prepare_v2(localDatabase, sqlStatement, -1, &localDeleteStmt, NULL) == SQLITE_OK) {
                    
                    if(SQLITE_DONE != sqlite3_step(localDeleteStmt)){
                        NSLog(@"%s",sqlite3_errmsg(localDatabase));
                        NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(localDatabase));
                    }
                    else {
                        
                    }
                    sqlite3_reset(localDeleteStmt);
                }
                localDeleteStmt = nil;
            }
            
            if (localDeleteStmt == nil) {
                
                NSString * query = [NSString stringWithFormat:@"delete from billing_table where bill_id = '%@'",bill_id];
                const char * sqlStatement = query.UTF8String;
                
                if(sqlite3_prepare_v2(localDatabase, sqlStatement, -1, &localDeleteStmt, NULL) == SQLITE_OK) {
                    
                    if(SQLITE_DONE != sqlite3_step(localDeleteStmt)){
                        NSLog(@"%s",sqlite3_errmsg(localDatabase));
                        NSAssert1(0, @"Error While Deleting. '%s'",sqlite3_errmsg(localDatabase));
                    }
                    else {
                        
                    }
                    sqlite3_reset(localDeleteStmt);
                }
                localDeleteStmt = nil;
            }
            
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}


/**
 * @description  here we are taking inputs form user of other payment details....
 * @date
 * @method       populateReportView
 * @author
 * @param
 * @param
 * @param
 * @param
 * @param
 * @return       void
 *
 * @modified By  Srinivasulu on 29/03/2018....
 * @reason       added the comments....
 *
 * @verified By
 * @verified On
 *
 */

-(void)populateReportView:(UIButton *)sender{
    
    transparentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    transparentView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6f];
    
    UILabel  * headerDisplayLbl;
    
    UILabel  * underLineOneLbl;
    UILabel  * underLineTwoLbl;
    
    UILabel  * userEnteredTotalsLbl;
    
    UIScrollView * displayAllPaymentsInfoScrollView;
    
    tenderModesView = [[UIView alloc] init];
    tenderModesView.backgroundColor = [UIColor blackColor];
    
    headerDisplayLbl = [[UILabel alloc] init] ;
    headerDisplayLbl.alpha = 0.8f;
    headerDisplayLbl.textAlignment = NSTextAlignmentLeft;
    headerDisplayLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    headerDisplayLbl.textColor = [UIColor whiteColor];
    
    underLineOneLbl = [[UILabel alloc] init] ;
    underLineOneLbl.alpha = 0.8f;
    underLineOneLbl.textAlignment = NSTextAlignmentLeft;
    underLineOneLbl.backgroundColor = [UIColor lightGrayColor];
    underLineOneLbl.textColor = [UIColor whiteColor];
    
    underLineTwoLbl = [[UILabel alloc] init] ;
    underLineTwoLbl.alpha = 0.8f;
    underLineTwoLbl.textAlignment = NSTextAlignmentLeft;
    underLineTwoLbl.backgroundColor = [UIColor lightGrayColor];
    underLineTwoLbl.textColor = [UIColor whiteColor];
    
    userEnteredTotalsLbl = [[UILabel alloc] init] ;
    userEnteredTotalsLbl.alpha = 0.8f;
    userEnteredTotalsLbl.textAlignment = NSTextAlignmentLeft;
    userEnteredTotalsLbl.backgroundColor = [UIColor clearColor];
    userEnteredTotalsLbl.textColor = [UIColor whiteColor];
    
    userEnteredTotalsValueLbl = [[UILabel alloc] init] ;
    userEnteredTotalsValueLbl.alpha = 0.8f;
    userEnteredTotalsValueLbl.textAlignment = NSTextAlignmentCenter;
    userEnteredTotalsValueLbl.backgroundColor = [UIColor clearColor];
    userEnteredTotalsValueLbl.textColor = [UIColor whiteColor];
    
    generateReportBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    generateReportBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    generateReportBtn.layer.cornerRadius = 10.0f;
    generateReportBtn.layer.borderWidth = 1.0f;
    [generateReportBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    (generateReportBtn.titleLabel).font = [UIFont boldSystemFontOfSize:22.0];
    [generateReportBtn addTarget:self action:@selector(generateReport:) forControlEvents:UIControlEventTouchUpInside];
    
    cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    cancelBtn.layer.cornerRadius = 10.0f;
    cancelBtn.layer.borderWidth = 1.0f;
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    (cancelBtn.titleLabel).font = [UIFont boldSystemFontOfSize:22.0];
    [cancelBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    
    displayAllPaymentsInfoScrollView = [[UIScrollView alloc] init];
    //    displayAllPaymentsInfoScrollView.backgroundColor = [UIColor redColor];
    
    
    [tenderModesView addSubview:headerDisplayLbl];
    
    
    [tenderModesView addSubview:generateReportBtn];
    [tenderModesView addSubview:cancelBtn];
    
    [tenderModesView addSubview:underLineOneLbl];
    [tenderModesView addSubview:underLineTwoLbl];
    [tenderModesView addSubview:userEnteredTotalsLbl];
    [tenderModesView addSubview:userEnteredTotalsValueLbl];
    
    [tenderModesView addSubview:displayAllPaymentsInfoScrollView];
    
    [transparentView addSubview:tenderModesView];
    [self.view addSubview:transparentView];
    
    float userEnterDeminationValue = 0;
    @try {
        headerDisplayLbl.text = NSLocalizedString(@"_generate_x_report", nil);
        headerDisplayLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:18];
        
        userEnteredTotalsLbl.text = NSLocalizedString(@"sub_total", nil);
        userEnteredTotalsValueLbl.text = NSLocalizedString(@"0.00", nil);
        
        userEnteredTotalsLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20];
        userEnteredTotalsValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20];
        
        [generateReportBtn setTitle:NSLocalizedString(@"generate_report", nil) forState:UIControlStateNormal];
        [cancelBtn setTitle:NSLocalizedString(@"cancel", nil) forState:UIControlStateNormal];
        
        if(paymentModesArr == nil){
            
            paymentModesArr = [NSMutableArray new];
            paymentModesAmountArr = [NSMutableArray new];
        }
        
        if(paymentModesArr.count){
            [paymentModesArr removeAllObjects];
        }
        
        if(paymentModesAmountArr.count){
            [paymentModesAmountArr removeAllObjects];
        }
        
        [paymentModesArr addObject:@"Card"];
        [paymentModesAmountArr addObject:@"0"];
        
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        
        if ( ! ([[defaults valueForKey:COUPON_OPTIONS] isKindOfClass:[NSNull class]] || [defaults valueForKey:COUPON_OPTIONS] == nil)) {
            
            for(NSDictionary * dic in  [defaults valueForKey:COUPON_OPTIONS]){
                
                [paymentModesArr addObject:[dic valueForKey:TENDER_NAME]];
                [paymentModesAmountArr addObject:@"0"];
            }
        }
        
        if ( ! ([[defaults valueForKey:DENOMNINATION_OPTIONS] isKindOfClass:[NSNull class]] || [defaults valueForKey:DENOMNINATION_OPTIONS] == nil)) {
            
            for(NSDictionary * dic in  [defaults valueForKey:DENOMNINATION_OPTIONS]){
                
                [paymentModesArr addObject:[dic valueForKey:TENDER_NAME]];
                [paymentModesAmountArr addObject:@"0"];
            }
        }
        
        
        //        paymentModesArr = [NSMutableArray arrayWithObjects:@"one1",@"one2",@"one3",@"one4",@"one5",@"one6",@"one7",@"one8",@"one9",@"one10",@"one11",@"one12",@"one13",@"one14",@"one11",@"one12",@"one13",@"one14",@"one11",@"one12",@"one13",@"one14", nil];
        //        paymentModesAmountArr = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
        
        
        for (int i=0; i<denominationDic.allKeys.count; i++) {
            
            userEnterDeminationValue = userEnterDeminationValue + ([denominationDic.allKeys[i] floatValue] * [[denominationDic valueForKey:denominationDic.allKeys[i]] intValue]);
        }
        
        for (int i=0; i<denominationCoinDic.allKeys.count; i++) {
            
            userEnterDeminationValue = userEnterDeminationValue + ([denominationCoinDic.allKeys[i] floatValue] * [[denominationCoinDic valueForKey:denominationCoinDic.allKeys[i]] intValue]);
        }
        
    } @catch (NSException *exception) {
        
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
            
        }
        else{
            
        }
        
        tenderModesView.frame = CGRectMake(100, 80, 800, 600);
        
        headerDisplayLbl.frame = CGRectMake( 0, 0, tenderModesView.frame.size.width, 45);
        
        generateReportBtn.frame = CGRectMake( (tenderModesView.frame.size.width - 400)/3, tenderModesView.frame.size.height - 50, 200, 40);
        cancelBtn.frame = CGRectMake( generateReportBtn.frame.origin.x * 2 + generateReportBtn.frame.size.width, generateReportBtn.frame.origin.y, generateReportBtn.frame.size.width, 40);
        
        
        underLineOneLbl.frame = CGRectMake( generateReportBtn.frame.origin.x, generateReportBtn.frame.origin.y - 60, (cancelBtn.frame.origin.x + cancelBtn.frame.size.width) - generateReportBtn.frame.origin.x, 2);
        
        userEnteredTotalsLbl.frame =  CGRectMake( generateReportBtn.frame.origin.x, underLineOneLbl.frame.origin.y + underLineOneLbl.frame.size.height + 2, underLineOneLbl.frame.size.width/2, 35);
        
        userEnteredTotalsValueLbl.frame =  CGRectMake( userEnteredTotalsLbl.frame.origin.x + userEnteredTotalsLbl.frame.size.width, userEnteredTotalsLbl.frame.origin.y, userEnteredTotalsLbl.frame.size.width, userEnteredTotalsLbl.frame.size.height);
        
        underLineTwoLbl.frame = CGRectMake( underLineOneLbl.frame.origin.x, userEnteredTotalsLbl.frame.origin.y +userEnteredTotalsLbl.frame.size.height + 2, underLineOneLbl.frame.size.width, underLineOneLbl.frame.size.height);
        
        
        displayAllPaymentsInfoScrollView.frame =CGRectMake( headerDisplayLbl.frame.origin.x, headerDisplayLbl.frame.origin.y + headerDisplayLbl.frame.size.height + 10, headerDisplayLbl.frame.size.width, (underLineOneLbl.frame.origin.y + underLineOneLbl.frame.size.height) - (headerDisplayLbl.frame.origin.y + headerDisplayLbl.frame.size.height + 20));
        
        float x_position = 20;
        float y_position = 10;
        float text_width = (userEnteredTotalsLbl.frame.size.width - 20)/ 2;
        float label_width = (tenderModesView.frame.size.width - (text_width * 3))/ 2;
        float label_height = 40;
        tenderModesView.tag = 0;
        
        for(int i = 0; i < paymentModesArr.count; i++){
            
            UILabel * paymentTypeLbl;
            
            paymentTypeLbl = [[UILabel alloc] init] ;
            paymentTypeLbl.alpha = 0.8f;
            paymentTypeLbl.textAlignment = NSTextAlignmentLeft;
            paymentTypeLbl.backgroundColor = [UIColor clearColor];
            paymentTypeLbl.textColor = [UIColor whiteColor];
            
            paymentModesAmountTxt = [[UITextField alloc]init];
            paymentModesAmountTxt.borderStyle = UITextBorderStyleRoundedRect;
            paymentModesAmountTxt.textColor = [UIColor blackColor];
            paymentModesAmountTxt.font = [UIFont systemFontOfSize:18.0];
            paymentModesAmountTxt.backgroundColor = [UIColor whiteColor];
            paymentModesAmountTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
            paymentModesAmountTxt.backgroundColor = [UIColor whiteColor];
            paymentModesAmountTxt.keyboardType = UIKeyboardTypeNumberPad;
            paymentModesAmountTxt.autocorrectionType = UITextAutocorrectionTypeNo;
            paymentModesAmountTxt.layer.borderColor = [UIColor whiteColor].CGColor;
            paymentModesAmountTxt.backgroundColor = [UIColor whiteColor];
            paymentModesAmountTxt.delegate = self;
            [paymentModesAmountTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            
            [displayAllPaymentsInfoScrollView addSubview:paymentTypeLbl];
            [displayAllPaymentsInfoScrollView addSubview:paymentModesAmountTxt];
            
            @try {
                
                paymentTypeLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:18];
                paymentModesAmountTxt.font = [UIFont fontWithName:TEXT_FONT_NAME size:18];
                paymentModesAmountTxt.tag = i;
                
                paymentTypeLbl.text = paymentModesArr[i];
                
                if([paymentTypeLbl.text isEqualToString:showDefaultCurrencyCode]){
                    
                    paymentModesAmountArr[i] = [NSString stringWithFormat:@"%.2f",userEnterDeminationValue];
                }
                paymentModesAmountTxt.text = [NSString stringWithFormat:@"%.2f",[paymentModesAmountArr[i] floatValue]];
                
            } @catch (NSException *exception) {
                
            }
            
            paymentTypeLbl.frame = CGRectMake( x_position, y_position, label_width, label_height);
            paymentModesAmountTxt.frame = CGRectMake( paymentTypeLbl.frame.origin.x + paymentTypeLbl.frame.size.width, y_position, text_width, label_height);
            
            
            if(i%2 != 0){
                
                x_position = 20;
                y_position = 10 + y_position + label_height;
                displayAllPaymentsInfoScrollView.contentSize = CGSizeMake( displayAllPaymentsInfoScrollView.frame.size.width, y_position);
            }
            else{
                
                x_position = x_position + tenderModesView.frame.size.width/ 2;
            }
            
        }
        
        [paymentModesArr addObject:CASH];
        [paymentModesAmountArr addObject:[NSString stringWithFormat:@"%.2f",userEnterDeminationValue]];
        
    }
    else{
        //it has to be used for iphone framing....
        
    }
    
    
    [denomination setHidden:YES];
    [denominationView removeFromSuperview];
    //    [UIView transitionFromView:denominationView
    //                        toView:transparentView
    //                      duration:0.6
    //                       options:UIViewAnimationOptionTransitionFlipFromRight | UIViewAnimationOptionShowHideTransitionViews
    //                    completion:nil];
}

-(id) imageFromImage:(UIImage*)image  imageBackGroundColor:(UIColor*)backGroundColor  string:(NSString*)string  color:(UIColor*)color  font:(int)fontSize   width:(float)labelWidth height:(float)labelHeight fontType:(NSString *)fontType imageWidth:(float)imageWidth imageHeight:(float)imageHeight{
    
    @try {
        UIImageView  *returnView =  [[UIImageView alloc] init];
        
        UIImageView  *imageView =  [[UIImageView alloc] init];
        
        /*[self  imageFromImage:[UIImage imageNamed:@"Users@2x.png"]
         imageBackGroundColor:[UIColor blackColor]
         string:@"cloud"
         color:[UIColor blueColor]
         font:12
         width:width
         height:15
         fontType:TEXT_FONT_NAME
         imageWidth:100
         imageHeight:height - 15]];*/
        //added by Srinivasulu on 29/08/2016....
        UIGraphicsBeginImageContext(CGSizeMake(imageWidth, imageHeight));
        [image drawInRect:CGRectMake(0, 0, imageWidth, imageHeight)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        imageView.image = newImage;
        imageView.contentMode = UIViewContentModeCenter;
        
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor =[UIColor clearColor];
        label.textAlignment =  NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        label.font = [UIFont fontWithName:fontType size:fontSize];
        label.text = string;
        label.textColor = color;
        
        
        //frame setting.....
        returnView.frame = CGRectMake(0, 0, labelWidth, imageHeight + labelHeight);
        imageView.frame = CGRectMake( (labelWidth - imageWidth)/2, 0,  imageWidth, imageHeight);
        label.frame = CGRectMake(0, imageHeight,labelWidth, labelHeight);
        
        
        //        if (! (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && [[[UIDevice currentDevice] systemVersion] floatValue] < 8.0))
        imageView.backgroundColor = backGroundColor;//[UIColor clearColor];
        
        
        [returnView addSubview:imageView];
        [returnView addSubview:label];
        
        UIGraphicsBeginImageContextWithOptions(returnView.bounds.size, false, 0);
        
        [returnView.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *imageWithText = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return imageWithText;
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
        
    }
}



/**
 * @description  <#description#>
 * @date         <#date#>
 * @method       <#name#>
 * @author       Bhargav.v
 * @param        <#param#>
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)navigateToDayClosure:(UIButton*)sender {
    
    @try {
        
        if (!isOfflineService) {
            
            DayClosure * dc = [[DayClosure alloc] init];
            [self.navigationController pushViewController:dc animated:YES];
        }
        else {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"message", nil) message:NSLocalizedString(@"this_feature_can_only_be_used_with_internet_connectivity", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    @catch(NSException * exception) {
        
    }
    @finally {
        
    }
}

@end
