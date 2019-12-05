//
//  ReceiptGoodsProcurement.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 2/19/15.
//
//

#import "EditStockRequest.h"
#import "RawMaterialServiceSvc.h"
#import "StockReceiptServiceSvc.h"

#import "ViewStockRequest.h"
#import "Global.h"
#import "SkuServiceSvc.h"
#import "SupplierServiceSvc.h"
#import "purchaseOrdersSvc.h"
#import "OmniHomePage.h"
#import "StockRequests.h"
#import "RequestHeader.h"

@interface EditStockRequest ()

@end

@implementation EditStockRequest

@synthesize soundFileURLRef,soundFileObject;


-(id) initWithReceiptID:(NSString *)receiptID{
    
    requestReceiptID = [receiptID copy];
    
    return self;
}

-(void)callReceiptDetails {
    
    BOOL status_ = FALSE;
    StockRequestsSoapBinding *materialBinding = [[StockRequests StockRequestsSoapBinding] retain];
    
    StockRequests_getStockRequests *aparams = [[StockRequests_getStockRequests alloc] init];
    //    tns1_getStockProcurementReceipt *aparams = [[tns1_getStockProcurementReceipt alloc] init];
    
    
    NSArray *headerKeys_ = [NSArray arrayWithObjects:@"stockRequestId",@"requestHeader",@"location", nil];
    
    NSArray *headerObjects_ = [NSArray arrayWithObjects:requestReceiptID,[RequestHeader getRequestHeader],presentLocation, nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects_ forKeys:headerKeys_];
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
    NSString * createBillingJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    aparams.stockRequestDetails = createBillingJsonString;
    @try {
        
        StockRequestsSoapBindingResponse *response = [materialBinding getStockRequestsUsingParameters:aparams];
        NSArray *responseBodyParts = response.bodyParts;
        NSDictionary *JSONData;
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[StockRequests_getStockRequestsResponse class]]) {
                StockRequests_getStockRequestsResponse *body = (StockRequests_getStockRequestsResponse *)bodyPart;
                printf("\nresponse=%s",[body.return_ UTF8String]);
                NSError *e;
                status_ = TRUE;
                JSONData = [[NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                            options: NSJSONReadingMutableContainers
                                                              error: &e] copy];
                requestJSON = [JSONData copy];
            }
        }
    }
    @catch (NSException *exception) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed to get Data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    NSArray *receiptArr = [requestJSON valueForKey:@"stockRequests"];
    
    for (NSDictionary *receiptDic in receiptArr) {
        if ([[receiptDic valueForKey:@"stockRequestId"] isEqualToString:requestReceiptID]) {
            requestJSON = [receiptDic copy];
        }
    }
    if (status_) {
        
        poReference.text = [requestJSON objectForKey:@"deliveryDateStr"];
        location.text = [requestJSON objectForKey:@"fromStoreCode"];
        deliveredBy.text = [requestJSON objectForKey:@"requestApprovedBy"];
        inspectedBy.text = [requestJSON valueForKey:@"requestedUserName"];
        supplierID.text = [requestJSON objectForKey:@"toStoreCode"];
        supplierName.text = [requestJSON valueForKey:@"toWareHouseId"];
        shipmentNote.text = [requestJSON objectForKey:@"shippingMode"];
        date.text = [requestJSON objectForKey:@"requestDateStr"];
        reasonTxt.text = [requestJSON objectForKey:@"reason"];
        totalCost.text = [NSString stringWithFormat:@"%.2f",[[requestJSON objectForKey:@"totalStockRequestValue"] floatValue]];
        
        
        NSArray *items = [requestJSON objectForKey:@"stockRequestItems"];
        int quantity = 0;
        for (int i = 0; i < [items count]; i++) {
            NSDictionary *itemDic = [items objectAtIndex:i];
            quantity += [[itemDic valueForKey:@"quantity"] intValue];
            NSArray *temp = [NSArray arrayWithObjects:[itemDic objectForKey:@"skuId"],[itemDic objectForKey:@"pluCode"],[itemDic objectForKey:@"itemDesc"],[itemDic valueForKey:@"itemPrice"],[itemDic valueForKey:@"quantity"],[itemDic valueForKey:@"totalCost"],[itemDic valueForKey:@"color"],[itemDic valueForKey:@"model"],@"NA",[itemDic valueForKey:@"quantity"], nil];
            [rawMaterialDetails addObject:temp];
        }
        totalQuantity.text = [NSString stringWithFormat:@"%d",quantity];
        scrollView.hidden = NO;

        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            cartTable.frame = CGRectMake(cartTable.frame.origin.x, cartTable.frame.origin.y, cartTable.frame.size.width, cartTable.frame.size.height + 60);
        }
        else {
            cartTable.frame = CGRectMake(cartTable.frame.origin.x, cartTable.frame.origin.y, cartTable.frame.size.width, cartTable.frame.size.height + 30);
        }
        [cartTable reloadData];
        
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed to load Data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    [HUD setHidden:YES];
}

-(void) callRawMaterialDetails:(NSString *)rawMaterial {
    BOOL status = TRUE;
    rawMateialsSkuid = [rawMaterial copy];
    //    SkuServiceSoapBinding *skuService = [[SkuServiceSvc SkuServiceSoapBinding] retain];
    //
    //    SkuServiceSvc_getSkuDetails *getSkuid = [[SkuServiceSvc_getSkuDetails alloc] init];
    //
    
    NSArray *keys = [NSArray arrayWithObjects:@"skuId",@"requestHeader",@"storeLocation", nil];
    NSArray *objects = [NSArray arrayWithObjects:rawMaterial,[RequestHeader getRequestHeader],presentLocation, nil];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
    NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    @try {
        
        WebServiceController *webServiceController = [WebServiceController new];
        [webServiceController setGetSkuDetailsDelegate:self];
        [webServiceController getSkuDetailsWithData:salesReportJsonString];
        
        //        getSkuid.skuID = salesReportJsonString;
        //        SkuServiceSoapBindingResponse *response = [skuService getSkuDetailsUsingParameters:(SkuServiceSvc_getSkuDetails *)getSkuid];
        //        NSArray *responseBodyParts = response.bodyParts;
        //        for (id bodyPart in responseBodyParts) {
        //            if ([bodyPart isKindOfClass:[SkuServiceSvc_getSkuDetailsResponse class]]) {
        //                SkuServiceSvc_getSkuDetailsResponse *body = (SkuServiceSvc_getSkuDetailsResponse *)bodyPart;
        //                printf("\nresponse=%s",[body.return_ UTF8String]);
        //                NSError *e;
        //                JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
        //                                                       options: NSJSONReadingMutableContainers
        //                                                         error: &e];
        //                //  NSString *itemString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",[JSON objectForKey:@"productName"],@"#",[JSON objectForKey:@"description"],@"#",[JSON objectForKey:@"quantity"],@"#",[JSON objectForKey:@"price"]];
        //            }
        //        }
        //
        //        NSArray *temp = [NSArray arrayWithObjects:[JSON objectForKey:@"productName"],[JSON objectForKey:@"description"],[JSON objectForKey:@"price"],@"1",[JSON objectForKey:@"price"],@"NA",@"1",@"1",@"0",rawMaterial, nil];
        //
        //        for (int c = 0; c < [rawMaterialDetails count]; c++) {
        //            NSArray *material = [rawMaterialDetails objectAtIndex:c];
        //            if ([[material objectAtIndex:9] isEqualToString:[NSString stringWithFormat:@"%@",[JSON objectForKey:@"skuId"]]]) {
        //                NSArray *temp = [NSArray arrayWithObjects:[material objectAtIndex:0],[material objectAtIndex:1],[material objectAtIndex:2],[NSString stringWithFormat:@"%d",[[material objectAtIndex:3] intValue] + 1],[NSString stringWithFormat:@"%.2f",(([[material objectAtIndex:7] intValue] + 1) * [[material objectAtIndex:2] floatValue])],[material objectAtIndex:5],[NSString stringWithFormat:@"%d",[[material objectAtIndex:6] intValue] + 1],[NSString stringWithFormat:@"%d",[[material objectAtIndex:7] intValue]+1],[material objectAtIndex:8],[material objectAtIndex:9],nil];
        //                [rawMaterialDetails replaceObjectAtIndex:c withObject:temp];
        //                status = FALSE;
        //            }
        //        }
        //        if (status) {
        //            [rawMaterialDetails addObject:temp];
        //        }
        //
        //        scrollView.hidden = NO;
        //        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        //            cartTable.frame = CGRectMake(cartTable.frame.origin.x, cartTable.frame.origin.y, cartTable.frame.size.width, cartTable.frame.size.height + 60);
        //        }
        //        else {
        //            cartTable.frame = CGRectMake(cartTable.frame.origin.x, cartTable.frame.origin.y, cartTable.frame.size.width, cartTable.frame.size.height + 30);
        //        }
        //        [cartTable reloadData];
        //
        //        requestQuantity = 0;
        //        requestMaterialCost = 0.0f;
        //
        //        for (int i = 0; i < [rawMaterialDetails count]; i++) {
        //            NSArray *material = [rawMaterialDetails objectAtIndex:i];
        //            requestQuantity = requestQuantity + [[material objectAtIndex:7] intValue];
        //            requestMaterialCost = requestMaterialCost + ([[material objectAtIndex:2] floatValue] * [[material objectAtIndex:7] intValue]);
        //        }
        //
        //        totalQuantity.text = [NSString stringWithFormat:@"%d",requestQuantity];
        //        totalCost.text = [NSString stringWithFormat:@"%.2f",requestMaterialCost];
        
    }
    @catch (NSException *exception) {
        
        
    }
    
    [HUD hide:YES afterDelay:1.0];
}

#pragma mark - Get SKU Details Service Reposnse Delegates

- (void)getSkuDetailsSuccessResponse:(NSDictionary *)successDictionary
{
    @try {
        BOOL status = TRUE;
        if (successDictionary != nil) {
            if (![[successDictionary valueForKey:@"skuLists"] isKindOfClass:[NSNull class]]) {
                
                priceDic = [[NSMutableArray alloc]init];
                
                NSArray *price_arr = [successDictionary valueForKey:@"skuLists"];
                for (int i=0; i<[price_arr count]; i++) {
                    
                    NSDictionary *json = [price_arr objectAtIndex:i];
                    [priceDic addObject:json];
                }
                
                if ([[successDictionary valueForKey:@"skuLists"] count]>1) {
                    
                    
                    if ([priceDic count]>0) {
                        [HUD setHidden:YES];
                        transparentView.hidden = NO;
                        [priceTable reloadData];
                    }
                }
                else {
                    
//                    if ([[[priceDic objectAtIndex:0] objectForKey:@"quantity"] floatValue] > 0) {
                        NSDictionary *itemDic = [priceDic objectAtIndex:0];
                        NSArray *temp = [NSArray arrayWithObjects:[itemDic objectForKey:@"skuId"],[itemDic objectForKey:@"pluCode"],[itemDic objectForKey:@"description"],[itemDic valueForKey:@"salePrice"],@"1",[itemDic valueForKey:@"salePrice"],[itemDic valueForKey:@"color"],[itemDic valueForKey:@"model"],@"NA",[itemDic valueForKey:@"quantity"], nil];
                        
                        for (int c = 0; c < [rawMaterialDetails count]; c++) {
                            NSArray *material = [rawMaterialDetails objectAtIndex:c];
                            if ([[material objectAtIndex:0] isEqualToString:[NSString stringWithFormat:@"%@",[itemDic objectForKey:@"skuId"]]] && [[material objectAtIndex:1] isEqualToString:[NSString stringWithFormat:@"%@",[itemDic objectForKey:@"pluCode"]]]) {
                                NSArray *temp = [NSArray arrayWithObjects:[material objectAtIndex:0],[material objectAtIndex:1],[material objectAtIndex:2],[NSString stringWithFormat:@"%.2f",[[material objectAtIndex:3] floatValue]],[NSString stringWithFormat:@"%d",[[material objectAtIndex:4] intValue] + 1],[NSString stringWithFormat:@"%.2f",(([[material objectAtIndex:4] intValue] + 1) * [[material objectAtIndex:3] floatValue])],[material objectAtIndex:6],[material objectAtIndex:7],[material objectAtIndex:8],[material objectAtIndex:9],nil];
                                [rawMaterialDetails replaceObjectAtIndex:c withObject:temp];
                                status = FALSE;
                            }
                        }
                        if (status) {
                            [rawMaterialDetails addObject:temp];
                        }
                        
                        scrollView.hidden = NO;
                        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                            cartTable.frame = CGRectMake(cartTable.frame.origin.x, cartTable.frame.origin.y, cartTable.frame.size.width, cartTable.frame.size.height + 60);
                        }
                        else {
                            cartTable.frame = CGRectMake(cartTable.frame.origin.x, cartTable.frame.origin.y, cartTable.frame.size.width, cartTable.frame.size.height + 30);
                        }
                        [cartTable reloadData];
                        
                        requestQuantity = 0;
                        requestMaterialCost = 0.0f;
                        
                        for (int i = 0; i < [rawMaterialDetails count]; i++) {
                            NSArray *material = [rawMaterialDetails objectAtIndex:i];
                            requestQuantity = requestQuantity + [[material objectAtIndex:4] intValue];
                            requestMaterialCost = requestMaterialCost + ([[material objectAtIndex:3] floatValue] * [[material objectAtIndex:4] intValue]);
                        }
                        
                        totalQuantity.text = [NSString stringWithFormat:@"%d",requestQuantity];
                        totalCost.text = [NSString stringWithFormat:@"%.2f",requestMaterialCost];
                        
//                    }
                }
            }
        }
    }
    @catch (NSException * exception) {
        
    }
}

- (void)getSkuDetailsErrorResponse {
    [HUD setHidden:YES];
    UIAlertView *alert=  [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Product Not Available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    requestScrollValueStatus = NO;
    
    requestQuantity = 0;
    requestMaterialTagid = 0;
    requestRejectMaterialTagId = 0;
    requestMaterialCost = 0;
    requestStartPoint = 0;
    requestReceipt = @"";
    requestJSON = NULL;
    requestScrollValueStatus = FALSE;

    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (CFURLRef) [tapSound retain];
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    self.titleLabel.text = @"EDIT STOCK REQUEST";
    
    self.view.backgroundColor = [UIColor blackColor];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    // Show the HUD
    [HUD show:YES];
    [HUD setHidden:NO];
    
    HUD.labelText = @"Loading Please Wait..";
    
    rawMaterialDetails = [[NSMutableArray alloc] init];
    
    
    createReceiptView = [[UIScrollView alloc] init];
    createReceiptView.backgroundColor = [UIColor clearColor];
    createReceiptView.bounces = FALSE;
    createReceiptView.hidden = NO;
    
    viewReceiptView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 125.0, self.view.frame.size.width, self.view.frame.size.height)];
    viewReceiptView.backgroundColor = [UIColor clearColor];
    viewReceiptView.hidden = YES;
    
    supplierID = [[CustomTextField alloc] init];
    supplierID.borderStyle = UITextBorderStyleRoundedRect;
    supplierID.textColor = [UIColor blackColor];
    supplierID.font = [UIFont systemFontOfSize:18.0];
    supplierID.backgroundColor = [UIColor whiteColor];
    supplierID.clearButtonMode = UITextFieldViewModeWhileEditing;
    supplierID.backgroundColor = [UIColor whiteColor];
    supplierID.autocorrectionType = UITextAutocorrectionTypeNo;
    supplierID.layer.borderColor = [UIColor whiteColor].CGColor;
    supplierID.backgroundColor = [UIColor whiteColor];
    supplierID.delegate = self;
    supplierID.placeholder = @"   To Store Code";
    [supplierID addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [supplierID awakeFromNib];
    [supplierID setUserInteractionEnabled:YES];
    
    supplierName = [[CustomTextField alloc] init];
    supplierName.borderStyle = UITextBorderStyleRoundedRect;
    supplierName.textColor = [UIColor blackColor];
    supplierName.font = [UIFont systemFontOfSize:18.0];
    supplierName.backgroundColor = [UIColor whiteColor];
    supplierName.clearButtonMode = UITextFieldViewModeWhileEditing;
    supplierName.backgroundColor = [UIColor whiteColor];
    supplierName.autocorrectionType = UITextAutocorrectionTypeNo;
    supplierName.layer.borderColor = [UIColor whiteColor].CGColor;
    supplierName.backgroundColor = [UIColor whiteColor];
    supplierName.delegate = self;
    supplierName.placeholder = @"   To Warehouse ID";
    [supplierName addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [supplierName awakeFromNib];
    
    
    location = [[CustomTextField alloc] init];
    location.borderStyle = UITextBorderStyleRoundedRect;
    location.textColor = [UIColor blackColor];
    location.font = [UIFont systemFontOfSize:18.0];
    location.backgroundColor = [UIColor whiteColor];
    location.clearButtonMode = UITextFieldViewModeWhileEditing;
    location.backgroundColor = [UIColor whiteColor];
    location.autocorrectionType = UITextAutocorrectionTypeNo;
    location.layer.borderColor = [UIColor whiteColor].CGColor;
    location.backgroundColor = [UIColor whiteColor];
    location.delegate = self;
    location.placeholder = @"   Location";
    location.text = presentLocation;
    [location addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [location awakeFromNib];
    
    
    deliveredBy = [[CustomTextField alloc] init];
    deliveredBy.borderStyle = UITextBorderStyleRoundedRect;
    deliveredBy.textColor = [UIColor blackColor];
    deliveredBy.font = [UIFont systemFontOfSize:18.0];
    deliveredBy.backgroundColor = [UIColor whiteColor];
    deliveredBy.clearButtonMode = UITextFieldViewModeWhileEditing;
    deliveredBy.backgroundColor = [UIColor whiteColor];
    deliveredBy.autocorrectionType = UITextAutocorrectionTypeNo;
    deliveredBy.layer.borderColor = [UIColor whiteColor].CGColor;
    deliveredBy.backgroundColor = [UIColor whiteColor];
    deliveredBy.delegate = self;
    deliveredBy.placeholder = @"   Approved By";
    [deliveredBy addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [deliveredBy awakeFromNib];
    
    
    inspectedBy = [[CustomTextField alloc] init];
    inspectedBy.borderStyle = UITextBorderStyleRoundedRect;
    inspectedBy.textColor = [UIColor blackColor];
    inspectedBy.font = [UIFont systemFontOfSize:18.0];
    inspectedBy.backgroundColor = [UIColor whiteColor];
    inspectedBy.clearButtonMode = UITextFieldViewModeWhileEditing;
    inspectedBy.backgroundColor = [UIColor whiteColor];
    inspectedBy.autocorrectionType = UITextAutocorrectionTypeNo;
    inspectedBy.layer.borderColor = [UIColor whiteColor].CGColor;
    inspectedBy.backgroundColor = [UIColor whiteColor];
    inspectedBy.delegate = self;
    inspectedBy.placeholder = @"   Requested By";
    [inspectedBy addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [inspectedBy awakeFromNib];
    
    
    // getting present date & time ..
    NSDate *today = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString* currentdate = [f stringFromDate:today];
    [f release];
    
    date = [[CustomTextField alloc] init];
    date.borderStyle = UITextBorderStyleRoundedRect;
    date.textColor = [UIColor blackColor];
    date.font = [UIFont systemFontOfSize:18.0];
    date.backgroundColor = [UIColor whiteColor];
    date.clearButtonMode = UITextFieldViewModeWhileEditing;
    date.backgroundColor = [UIColor whiteColor];
    date.autocorrectionType = UITextAutocorrectionTypeNo;
    date.layer.borderColor = [UIColor whiteColor].CGColor;
    date.backgroundColor = [UIColor whiteColor];
    date.text = currentdate;
    [date setEnabled:FALSE];
    date.delegate = self;
    [date awakeFromNib];
    
    UIImage *buttonImageDD = [UIImage imageNamed:@"combo.png"];
    
    selectDate = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [selectDate setBackgroundImage:buttonImageDD forState:UIControlStateNormal];
    [selectDate addTarget:self
                   action:@selector(selectStartDate:) forControlEvents:UIControlEventTouchDown];
    selectDate.tag = 1;
    
    poReference = [[CustomTextField alloc] init];
    poReference.borderStyle = UITextBorderStyleRoundedRect;
    poReference.textColor = [UIColor blackColor];
    poReference.font = [UIFont systemFontOfSize:18.0];
    poReference.backgroundColor = [UIColor whiteColor];
    poReference.clearButtonMode = UITextFieldViewModeWhileEditing;
    poReference.backgroundColor = [UIColor whiteColor];
    poReference.autocorrectionType = UITextAutocorrectionTypeNo;
    poReference.layer.borderColor = [UIColor whiteColor].CGColor;
    poReference.backgroundColor = [UIColor whiteColor];
    poReference.delegate = self;
    poReference.placeholder = @"   Delivery Date";
    poReference.text = currentdate;
    [poReference addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [poReference awakeFromNib];
    
    
    shipmentNote = [[CustomTextField alloc] init];
    shipmentNote.borderStyle = UITextBorderStyleRoundedRect;
    shipmentNote.textColor = [UIColor blackColor];
    shipmentNote.font = [UIFont systemFontOfSize:18.0];
    shipmentNote.backgroundColor = [UIColor whiteColor];
    shipmentNote.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentNote.backgroundColor = [UIColor whiteColor];
    shipmentNote.autocorrectionType = UITextAutocorrectionTypeNo;
    shipmentNote.layer.borderColor = [UIColor whiteColor].CGColor;
    shipmentNote.backgroundColor = [UIColor whiteColor];
    shipmentNote.delegate = self;
    shipmentNote.placeholder = @"   Shipping Mode";
    [shipmentNote addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [shipmentNote awakeFromNib];
    
    shipoModeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImageSM = [UIImage imageNamed:@"combo.png"];
    [shipoModeButton setBackgroundImage:buttonImageSM forState:UIControlStateNormal];
    [shipoModeButton addTarget:self action:@selector(shipoModeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

    reasonTxt = [[CustomTextField alloc] init];
    reasonTxt.borderStyle = UITextBorderStyleRoundedRect;
    reasonTxt.textColor = [UIColor blackColor];
    reasonTxt.font = [UIFont systemFontOfSize:18.0];
    reasonTxt.backgroundColor = [UIColor whiteColor];
    reasonTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    reasonTxt.backgroundColor = [UIColor whiteColor];
    reasonTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    reasonTxt.layer.borderColor = [UIColor whiteColor].CGColor;
    reasonTxt.backgroundColor = [UIColor whiteColor];
    reasonTxt.delegate = self;
    reasonTxt.placeholder = @"   Reason";
    [reasonTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [reasonTxt awakeFromNib];
    
    
    searchItem = [[UITextField alloc] init];
    searchItem.borderStyle = UITextBorderStyleRoundedRect;
    searchItem.textColor = [UIColor blackColor];
    searchItem.font = [UIFont systemFontOfSize:18.0];
    searchItem.backgroundColor = [UIColor whiteColor];
    searchItem.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchItem.backgroundColor = [UIColor whiteColor];
    searchItem.autocorrectionType = UITextAutocorrectionTypeNo;
    searchItem.layer.borderColor = [UIColor whiteColor].CGColor;
    searchItem.backgroundColor = [UIColor whiteColor];
    searchItem.delegate = self;
    searchItem.placeholder = @"   Search Item Here";
    [searchItem addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    skListTable = [[UITableView alloc] init];
    skListTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [skListTable setDataSource:self];
    [skListTable setDelegate:self];
    [skListTable.layer setBorderWidth:1.0f];
    skListTable.layer.cornerRadius = 3;
    skListTable.layer.borderColor = [UIColor grayColor].CGColor;
    
    supplierTable = [[UITableView alloc] init];
    supplierTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [supplierTable setDataSource:self];
    [supplierTable setDelegate:self];
    [supplierTable.layer setBorderWidth:1.0f];
    supplierTable.layer.cornerRadius = 3;
    supplierTable.layer.borderColor = [UIColor grayColor].CGColor;
    
    receiptIDTable = [[UITableView alloc] init];
    receiptIDTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [receiptIDTable setDataSource:self];
    [receiptIDTable setDelegate:self];
    [receiptIDTable.layer setBorderWidth:1.0f];
    receiptIDTable.layer.cornerRadius = 3;
    receiptIDTable.layer.borderColor = [UIColor grayColor].CGColor;
    
    ReceiptID = [[UITextField alloc] init];
    ReceiptID.borderStyle = UITextBorderStyleRoundedRect;
    ReceiptID.textColor = [UIColor blackColor];
    ReceiptID.font = [UIFont systemFontOfSize:18.0];
    ReceiptID.backgroundColor = [UIColor whiteColor];
    ReceiptID.clearButtonMode = UITextFieldViewModeWhileEditing;
    ReceiptID.backgroundColor = [UIColor whiteColor];
    ReceiptID.autocorrectionType = UITextAutocorrectionTypeNo;
    ReceiptID.layer.borderColor = [UIColor whiteColor].CGColor;
    ReceiptID.backgroundColor = [UIColor whiteColor];
    ReceiptID.delegate = self;
    ReceiptID.placeholder = @"   ReceiptID";
    [ReceiptID addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UILabel *label2 = [[[UILabel alloc] init] autorelease];
    label2.text = @"Item Code";
    label2.layer.cornerRadius = 14;
    label2.layer.masksToBounds = YES;
    label2.numberOfLines = 2;
    [label2 setTextAlignment:NSTextAlignmentCenter];
    label2.font = [UIFont boldSystemFontOfSize:14.0];
    label2.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label2.textColor = [UIColor whiteColor];
    
    UILabel *label11 = [[[UILabel alloc] init] autorelease];
    label11.text = @"Item PLUCode";
    label11.layer.cornerRadius = 14;
    label11.layer.masksToBounds = YES;
    label11.numberOfLines = 2;
    [label11 setTextAlignment:NSTextAlignmentCenter];
    label11.font = [UIFont boldSystemFontOfSize:14.0];
    label11.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label11.textColor = [UIColor whiteColor];
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"Item Desc";
    label3.layer.cornerRadius = 14;
    label3.layer.masksToBounds = YES;
    [label3 setTextAlignment:NSTextAlignmentCenter];
    label3.font = [UIFont boldSystemFontOfSize:14.0];
    label3.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label3.textColor = [UIColor whiteColor];
    
    UILabel *label4 = [[[UILabel alloc] init] autorelease];
    label4.text = @"Price";
    label4.layer.cornerRadius = 14;
    label4.layer.masksToBounds = YES;
    [label4 setTextAlignment:NSTextAlignmentCenter];
    label4.font = [UIFont boldSystemFontOfSize:14.0];
    label4.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label4.textColor = [UIColor whiteColor];
    
    UILabel *label5 = [[[UILabel alloc] init] autorelease];
    label5.text = @"Qty";
    label5.layer.cornerRadius = 14;
    label5.layer.masksToBounds = YES;
    [label5 setTextAlignment:NSTextAlignmentCenter];
    label5.font = [UIFont boldSystemFontOfSize:14.0];
    label5.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label5.textColor = [UIColor whiteColor];
    
    UILabel *label13 = [[[UILabel alloc] init] autorelease];
    label13.text = @"Cost";
    label13.layer.cornerRadius = 14;
    label13.layer.masksToBounds = YES;
    [label13 setTextAlignment:NSTextAlignmentCenter];
    label13.font = [UIFont boldSystemFontOfSize:14.0];
    label13.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label13.textColor = [UIColor whiteColor];
    
    UILabel *label12 = [[[UILabel alloc] init] autorelease];
    label12.text = @"Make";
    label12.layer.cornerRadius = 14;
    label12.layer.masksToBounds = YES;
    [label12 setTextAlignment:NSTextAlignmentCenter];
    label12.font = [UIFont boldSystemFontOfSize:14.0];
    label12.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label12.textColor = [UIColor whiteColor];
    
    UILabel *label8 = [[[UILabel alloc] init] autorelease];
    label8.text = @"Color";
    label8.layer.cornerRadius = 14;
    label8.layer.masksToBounds = YES;
    [label8 setTextAlignment:NSTextAlignmentCenter];
    label8.font = [UIFont boldSystemFontOfSize:14.0];
    label8.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label8.textColor = [UIColor whiteColor];
    
    UILabel *label9 = [[[UILabel alloc] init] autorelease];
    label9.text = @"Model";
    label9.layer.cornerRadius = 14;
    label9.layer.masksToBounds = YES;
    [label9 setTextAlignment:NSTextAlignmentCenter];
    label9.font = [UIFont boldSystemFontOfSize:14.0];
    label9.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label9.textColor = [UIColor whiteColor];
    
    UILabel *label10 = [[[UILabel alloc] init] autorelease];
    label10.text = @"Size";
    label10.layer.cornerRadius = 14;
    label10.layer.masksToBounds = YES;
    [label10 setTextAlignment:NSTextAlignmentCenter];
    label10.font = [UIFont boldSystemFontOfSize:14.0];
    label10.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label10.textColor = [UIColor whiteColor];
    
    /** UIScrollView Design */
    scrollView = [[UIScrollView alloc] init];
    scrollView.hidden = YES;
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.bounces = FALSE;
    
    // Table for storing the items ..
    cartTable = [[UITableView alloc] init];
    cartTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    cartTable.backgroundColor = [UIColor clearColor];
    [cartTable setDataSource:self];
    [cartTable setDelegate:self];
    
    UILabel *label6 = [[[UILabel alloc] init] autorelease];
    label6.text = @"Total Quantity";
    label6.layer.cornerRadius = 14;
    label6.layer.masksToBounds = YES;
    [label6 setTextAlignment:NSTextAlignmentLeft];
    label6.font = [UIFont boldSystemFontOfSize:14.0];
    label6.textColor = [UIColor whiteColor];
    
    UILabel *label7 = [[[UILabel alloc] init] autorelease];
    label7.text = @"Total Cost";
    label7.layer.cornerRadius = 14;
    label7.layer.masksToBounds = YES;
    [label7 setTextAlignment:NSTextAlignmentLeft];
    label7.font = [UIFont boldSystemFontOfSize:14.0];
    label7.textColor = [UIColor whiteColor];
    
    totalQuantity = [[[UILabel alloc] init] autorelease];
    totalQuantity.text = @"0";
    totalQuantity.layer.cornerRadius = 14;
    totalQuantity.layer.masksToBounds = YES;
    [totalQuantity setTextAlignment:NSTextAlignmentLeft];
    totalQuantity.font = [UIFont boldSystemFontOfSize:14.0];
    totalQuantity.textColor = [UIColor whiteColor];
    
    totalCost = [[[UILabel alloc] init] autorelease];
    totalCost.text = @"0.0";
    totalCost.layer.cornerRadius = 14;
    totalCost.layer.masksToBounds = YES;
    [totalCost setTextAlignment:NSTextAlignmentLeft];
    totalCost.font = [UIFont boldSystemFontOfSize:12.0];
    totalCost.textColor = [UIColor whiteColor];
    
    submitBtn = [[UIButton alloc] init] ;
    [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    submitBtn.backgroundColor = [UIColor grayColor];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 5.0f;
    [submitBtn addTarget:self action:@selector(submitButtonPressed) forControlEvents:UIControlEventTouchDown];
    
    cancelButton = [[UIButton alloc] init];
    [cancelButton addTarget:self
                     action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchDown];
    [cancelButton setTitle:@"Save" forState:UIControlStateNormal];
    cancelButton.layer.cornerRadius = 3.0f;
    cancelButton.backgroundColor = [UIColor grayColor];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    submitBtn.userInteractionEnabled = YES;
    cancelButton.userInteractionEnabled = YES;
    
    normalstockTable = [[UITableView alloc] init];
    [normalstockTable setDataSource:self];
    [normalstockTable setDelegate:self];
    normalstockTable.backgroundColor = [UIColor clearColor];
    
    normalstockTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    procurementReceipts = [[NSMutableArray alloc] init];
    procuremnetReceiptDetails = [[NSMutableArray alloc] init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        //        mainSegmentedControl.frame = CGRectMake(-2, 65, 772, 60);
        //        mainSegmentedControl.tintColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        //        mainSegmentedControl.backgroundColor = [UIColor clearColor];
        //        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
        //                                    [UIFont boldSystemFontOfSize:18], UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor,
        //                                    nil];
        //        [mainSegmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
        
        createReceiptView.frame = CGRectMake(0, 0.0, self.view.frame.size.width, self.view.frame.size.height - 200.0);
        createReceiptView.contentSize = CGSizeMake(self.view.frame.size.width, 1000);
        
        supplierName.font = [UIFont boldSystemFontOfSize:20];
        supplierName.frame = CGRectMake(10.0, 10.0, 320.0, 50);
        
        supplierID.font = [UIFont boldSystemFontOfSize:20];
        supplierID.frame = CGRectMake(350.0, 10.0, 320.0, 50);
        supplierTable.frame = CGRectMake(10, 60, 320.0, 200);
        
        location.font = [UIFont boldSystemFontOfSize:20];
        location.frame = CGRectMake(690.0, 10.0, 320.0, 50);
        
        deliveredBy.font = [UIFont boldSystemFontOfSize:20];
        deliveredBy.frame = CGRectMake(350.0, 70.0, 320.0, 50);
        
        inspectedBy.font = [UIFont boldSystemFontOfSize:20];
        inspectedBy.frame = CGRectMake(10.0, 70.0, 320.0, 50);
        
        date.font = [UIFont boldSystemFontOfSize:20];
        date.frame = CGRectMake(690.0, 70.0, 320.0, 50);
        
        selectDate.frame = CGRectMake(285.0, 125.0, 50.0, 65.0);
        poReference.font = [UIFont boldSystemFontOfSize:20];
        poReference.frame = CGRectMake(10.0, 130.0, 320.0, 50);
        
        shipmentNote.font = [UIFont boldSystemFontOfSize:20];
        shipmentNote.frame = CGRectMake(350.0, 130.0, 320.0, 50);
        shipoModeButton.frame = CGRectMake(625.0, 125.0, 50, 65);
        
        reasonTxt.font = [UIFont boldSystemFontOfSize:20];
        reasonTxt.frame = CGRectMake(690.0, 130.0, 320.0, 50);
        
        searchItem.font = [UIFont boldSystemFontOfSize:20];
        searchItem.frame = CGRectMake(10.0, 220.0, 1000.0, 50.0);
        
        location.attributedPlaceholder = [[NSAttributedString alloc]initWithString:location.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        //        date.attributedPlaceholder = [[NSAttributedString alloc]initWithString:date.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor whiteColor]colorWithAlphaComponent:0.8]}];
        deliveredBy.attributedPlaceholder = [[NSAttributedString alloc]initWithString:deliveredBy.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        inspectedBy.attributedPlaceholder = [[NSAttributedString alloc]initWithString:inspectedBy.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        poReference.attributedPlaceholder = [[NSAttributedString alloc]initWithString:poReference.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        supplierName.attributedPlaceholder = [[NSAttributedString alloc]initWithString:supplierName.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        supplierID.attributedPlaceholder = [[NSAttributedString alloc]initWithString:supplierID.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        shipmentNote.attributedPlaceholder = [[NSAttributedString alloc]initWithString:shipmentNote.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        reasonTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:reasonTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        
        label2.font = [UIFont boldSystemFontOfSize:20];
        label2.frame = CGRectMake(10, 280.0, 90, 55);
        label11.font = [UIFont boldSystemFontOfSize:20];
        label11.frame = CGRectMake(103, 280.0, 90, 55);
        label3.font = [UIFont boldSystemFontOfSize:20];
        label3.frame = CGRectMake(195, 280.0, 155, 55);
        label4.font = [UIFont boldSystemFontOfSize:20];
        label4.frame = CGRectMake(355, 280.0, 90, 55);
        label5.font = [UIFont boldSystemFontOfSize:20];
        label5.frame = CGRectMake(448, 280.0, 110, 55);
        label12.font = [UIFont boldSystemFontOfSize:20];
        label12.frame = CGRectMake(494, 280.0, 110, 55);
        label13.font = [UIFont boldSystemFontOfSize:20];
        label13.frame = CGRectMake(561, 280.0, 110, 55);
        label8.font = [UIFont boldSystemFontOfSize:20];
        label8.frame = CGRectMake(674, 280.0, 110, 55);
        label9.font = [UIFont boldSystemFontOfSize:20];
        label9.frame = CGRectMake(787.0, 280.0, 110, 55);
        label10.font = [UIFont boldSystemFontOfSize:20];
        label10.frame = CGRectMake(900, 280.0, 110, 55);
        
        scrollView.frame = CGRectMake(10, 340.0, self.view.frame.size.width, 260.0);
        scrollView.contentSize = CGSizeMake(778, 1000);
        cartTable.frame = CGRectMake(0, 0, self.view.frame.size.width,60);
        
        label6.font = [UIFont boldSystemFontOfSize:20];
        label6.frame = CGRectMake(10.0, 620.0, 200, 55.0);
        
        label7.font = [UIFont boldSystemFontOfSize:20];
        label7.frame = CGRectMake(10.0, 660.0, 200, 55);
        
        totalQuantity.font = [UIFont boldSystemFontOfSize:20];
        totalQuantity.frame = CGRectMake(580.0, 620.0, 200, 55);
        
        totalCost.font = [UIFont boldSystemFontOfSize:20];
        totalCost.frame = CGRectMake(580.0, 660.0, 200, 55);
        
        submitBtn.frame = CGRectMake(155.0f, 600.0,300.0f, 55.0f);
        submitBtn.layer.cornerRadius = 25.0f;
        submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        cancelButton.frame = CGRectMake(525.0f, 600.0,300.0f, 55.0f);
        cancelButton.layer.cornerRadius = 25.0f;
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        normalstockTable.frame = CGRectMake(0.0, 5.0, self.view.frame.size.width, 600.0);
        
        skListTable.frame = CGRectMake(200, 300.0, 360,0);
        supplierTable.frame = CGRectMake(200, 300.0, 360,0);
        
        receiptIDTable.frame = CGRectMake(200.0, 60, 360, 0);
        
        [createReceiptView addSubview:label2];
        [createReceiptView addSubview:label3];
        [createReceiptView addSubview:label4];
        [createReceiptView addSubview:label5];
        [createReceiptView addSubview:label8];
        [createReceiptView addSubview:label9];
        [createReceiptView addSubview:label10];
        [createReceiptView addSubview:label11];
        [createReceiptView addSubview:label13];
        [createReceiptView addSubview:label6];
        [createReceiptView addSubview:label7];
        [createReceiptView addSubview:totalQuantity];
        [createReceiptView addSubview:totalCost];
        
    }
    else {
        // mainSegmentedControl.frame = CGRectMake(-2, 65, 772, 60);
        //        mainSegmentedControl.tintColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        //        mainSegmentedControl.backgroundColor = [UIColor clearColor];
        //        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
        //                                    [UIFont boldSystemFontOfSize:18], UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor,
        //                                    nil];
        //        [mainSegmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
        if (version>=8.0) {
            
            createReceiptView.frame = CGRectMake(0, 110, self.view.frame.size.width, self.view.frame.size.height);
            //createReceiptView.contentSize = CGSizeMake(self.view.frame.size.width + 500, 1000);
            viewReceiptView.frame = CGRectMake(0, 110, self.view.frame.size.width, self.view.frame.size.height);
            
            supplierID.font = [UIFont boldSystemFontOfSize:15];
            supplierID.frame = CGRectMake(0.0, 0.0, 150, 35);
            
            supplierName.font = [UIFont boldSystemFontOfSize:15];
            supplierName.frame = CGRectMake(160.0, 0.0, 160, 35);
            
            location.font = [UIFont boldSystemFontOfSize:15];
            location.frame = CGRectMake(0.0, 40.0, 150, 35);
            
            //        selectLocation.frame = CGRectMake(130, 2, 30, 45);
            //
            //        locationTable.frame = CGRectMake(10.0, 30.0, 120, 0);
            //
            //        fromLocation.font = [UIFont boldSystemFontOfSize:15];
            //        fromLocation.frame = CGRectMake(160.0, 5.0, 160, 35);
            
            deliveredBy.font = [UIFont boldSystemFontOfSize:15];
            deliveredBy.frame = CGRectMake(160.0, 40.0, 150, 35);
            
            inspectedBy.font = [UIFont boldSystemFontOfSize:15];
            inspectedBy.frame = CGRectMake(0.0, 80.0, 150, 35);
            
            date.font = [UIFont boldSystemFontOfSize:15];
            date.frame = CGRectMake( 160, 80.0, 150, 35);
            
            //        inspectedBy.font = [UIFont boldSystemFontOfSize:30];
            //        inspectedBy.frame = CGRectMake(10.0, 130.0, 360, 50);
            
            //        date.font = [UIFont boldSystemFontOfSize:30];
            //        date.frame = CGRectMake(400.0, 130.0, 360, 50);
            
            poReference.font = [UIFont boldSystemFontOfSize:15];
            poReference.frame = CGRectMake(0.0, 120.0, 150, 35);
            
            shipmentNote.font = [UIFont boldSystemFontOfSize:15];
            shipmentNote.frame = CGRectMake(1600, 120.0, 150, 35);
            
            location.attributedPlaceholder = [[NSAttributedString alloc]initWithString:location.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            //        date.attributedPlaceholder = [[NSAttributedString alloc]initWithString:date.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor whiteColor]colorWithAlphaComponent:0.8]}];
            deliveredBy.attributedPlaceholder = [[NSAttributedString alloc]initWithString:deliveredBy.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            inspectedBy.attributedPlaceholder = [[NSAttributedString alloc]initWithString:inspectedBy.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            poReference.attributedPlaceholder = [[NSAttributedString alloc]initWithString:poReference.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            supplierName.attributedPlaceholder = [[NSAttributedString alloc]initWithString:supplierName.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            supplierID.attributedPlaceholder = [[NSAttributedString alloc]initWithString:supplierID.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            shipmentNote.attributedPlaceholder = [[NSAttributedString alloc]initWithString:shipmentNote.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            
            searchItem.font = [UIFont boldSystemFontOfSize:17];
            searchItem.frame = CGRectMake(60.0, 160, 180, 35.0);
            
            //        ReceiptID.font = [UIFont boldSystemFontOfSize:17];
            //        ReceiptID.frame = CGRectMake(60.0, 0, 180, 35.0);
            
            label2.font = [UIFont boldSystemFontOfSize:12];
            label2.frame = CGRectMake(0, 0, 60, 30);
            label2.text = @"Item";
            label11.font = [UIFont boldSystemFontOfSize:12];
            label11.frame = CGRectMake(60, 0, 60, 30);
            label11.text = @"Desc";
            label3.font = [UIFont boldSystemFontOfSize:12];
            label3.frame = CGRectMake(120, 0, 60, 30);
            label4.font = [UIFont boldSystemFontOfSize:12];
            label4.frame = CGRectMake(180, 0, 60, 30);
            label5.font = [UIFont boldSystemFontOfSize:12];
            label5.frame = CGRectMake(240, 0, 50, 30);
            label12.font = [UIFont boldSystemFontOfSize:12];
            // label12.frame = CGRectMake(290, 0.0, 80, 30);
            label8.font = [UIFont boldSystemFontOfSize:12];
            label8.frame = CGRectMake(290,0, 80, 30);
            label9.font = [UIFont boldSystemFontOfSize:12];
            label9.frame = CGRectMake(370, 0, 80, 30);
            label10.font = [UIFont boldSystemFontOfSize:12];
            label10.frame = CGRectMake(450, 0, 80, 30);
            
            scrollView.frame = CGRectMake(10, 200, 450.0, 200);
            scrollView.contentSize = CGSizeMake(700, 1000);
            cartTable.frame = CGRectMake(0, 40, 750,60);
            
            label6.font = [UIFont boldSystemFontOfSize:15];
            label6.frame = CGRectMake(10.0, 140.0, 150, 25.0);
            [label6 setBackgroundColor:[UIColor clearColor]];
            
            label7.font = [UIFont boldSystemFontOfSize:15];
            label7.frame = CGRectMake(10.0, 165.0, 150, 25);
            [label7 setBackgroundColor:[UIColor clearColor]];
            
            totalQuantity.font = [UIFont boldSystemFontOfSize:15];
            totalQuantity.frame = CGRectMake(190.0, 140.0, 120, 25);
            [totalQuantity setBackgroundColor:[UIColor clearColor]];
            
            
            totalCost.font = [UIFont boldSystemFontOfSize:15];
            totalCost.frame = CGRectMake(190.0, 165.0, 120, 25);
            [totalCost setBackgroundColor:[UIColor clearColor]];
            
            
            submitBtn.frame = CGRectMake(5.0f, 400,150.0f, 35.0f);
            submitBtn.layer.cornerRadius = 17.0f;
            submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
            cancelButton.frame = CGRectMake(160.0f, 400,150.0f, 35.0f);
            cancelButton.layer.cornerRadius = 17.0f;
            cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
            
            normalstockTable.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, 360.0);
            
            skListTable.frame = CGRectMake(200, 200, 360,0);
            // receiptIDTable.frame = CGRectMake(60.0, 35, 360, 0);
            
            [scrollView addSubview:label2];
            [scrollView addSubview:label3];
            [scrollView addSubview:label4];
            [scrollView addSubview:label5];
            [scrollView addSubview:label8];
            [scrollView addSubview:label9];
            [scrollView addSubview:label10];
            [scrollView addSubview:label11];
            [scrollView addSubview:label12];
            [scrollView addSubview:label6];
            [scrollView addSubview:label7];
            [scrollView addSubview:totalCost];
            [scrollView addSubview:totalQuantity];
            
        }
        else {
            createReceiptView.frame = CGRectMake(0, 45, self.view.frame.size.width, self.view.frame.size.height);
            //createReceiptView.contentSize = CGSizeMake(self.view.frame.size.width + 500, 1000);
            viewReceiptView.frame = CGRectMake(0, 45, self.view.frame.size.width, self.view.frame.size.height);
            
            supplierID.font = [UIFont boldSystemFontOfSize:15];
            supplierID.frame = CGRectMake(0.0, 0.0, 150, 35);
            
            supplierName.font = [UIFont boldSystemFontOfSize:15];
            supplierName.frame = CGRectMake(160.0, 0.0, 160, 35);
            
            location.font = [UIFont boldSystemFontOfSize:15];
            location.frame = CGRectMake(0.0, 40.0, 150, 35);
            
            //        selectLocation.frame = CGRectMake(130, 2, 30, 45);
            //
            //        locationTable.frame = CGRectMake(10.0, 30.0, 120, 0);
            //
            //        fromLocation.font = [UIFont boldSystemFontOfSize:15];
            //        fromLocation.frame = CGRectMake(160.0, 5.0, 160, 35);
            
            deliveredBy.font = [UIFont boldSystemFontOfSize:15];
            deliveredBy.frame = CGRectMake(160.0, 40.0, 150, 35);
            
            inspectedBy.font = [UIFont boldSystemFontOfSize:15];
            inspectedBy.frame = CGRectMake(0.0, 80.0, 150, 35);
            
            date.font = [UIFont boldSystemFontOfSize:20];
            date.frame = CGRectMake( 150.0, 80.0, 220, 35);
            
            //        inspectedBy.font = [UIFont boldSystemFontOfSize:30];
            //        inspectedBy.frame = CGRectMake(10.0, 130.0, 360, 50);
            
            //        date.font = [UIFont boldSystemFontOfSize:30];
            //        date.frame = CGRectMake(400.0, 130.0, 360, 50);
            
            poReference.font = [UIFont boldSystemFontOfSize:15];
            poReference.frame = CGRectMake(0.0, 120.0, 120, 35);
            
            shipmentNote.font = [UIFont boldSystemFontOfSize:15];
            shipmentNote.frame = CGRectMake(125.0, 120.0, 220, 35);
            
            searchItem.font = [UIFont boldSystemFontOfSize:17];
            searchItem.frame = CGRectMake(60.0, 160, 180, 35.0);
            
            //        ReceiptID.font = [UIFont boldSystemFontOfSize:17];
            //        ReceiptID.frame = CGRectMake(60.0, 0, 180, 35.0);
            
            label2.font = [UIFont boldSystemFontOfSize:15];
            label2.frame = CGRectMake(0, 0, 60, 35);
            label11.font = [UIFont boldSystemFontOfSize:15];
            label11.frame = CGRectMake(60, 0, 60, 35);
            label3.font = [UIFont boldSystemFontOfSize:15];
            label3.frame = CGRectMake(120, 0, 60, 35);
            label4.font = [UIFont boldSystemFontOfSize:15];
            label4.frame = CGRectMake(180, 0, 60, 35);
            label5.font = [UIFont boldSystemFontOfSize:15];
            label5.frame = CGRectMake(240, 0, 50, 35);
            label12.font = [UIFont boldSystemFontOfSize:15];
            label12.frame = CGRectMake(290, 0.0, 80, 35);
            label8.font = [UIFont boldSystemFontOfSize:15];
            label8.frame = CGRectMake(370,0, 50, 35);
            label9.font = [UIFont boldSystemFontOfSize:15];
            label9.frame = CGRectMake(420, 0, 80, 35);
            label10.font = [UIFont boldSystemFontOfSize:15];
            label10.frame = CGRectMake(500.0, 0, 80, 35);
            
            scrollView.frame = CGRectMake(10, 200, 450.0, 150.0);
            scrollView.contentSize = CGSizeMake(630, 1000);
            cartTable.frame = CGRectMake(0, 40, 750,60);
            
            label6.font = [UIFont boldSystemFontOfSize:15];
            label6.frame = CGRectMake(10.0, 140.0, 150, 25.0);
            [label6 setBackgroundColor:[UIColor clearColor]];
            
            label7.font = [UIFont boldSystemFontOfSize:15];
            label7.frame = CGRectMake(10.0, 165.0, 150, 25);
            [label7 setBackgroundColor:[UIColor clearColor]];
            
            totalQuantity.font = [UIFont boldSystemFontOfSize:15];
            totalQuantity.frame = CGRectMake(190.0, 140.0, 120, 25);
            [totalQuantity setBackgroundColor:[UIColor clearColor]];
            
            
            totalCost.font = [UIFont boldSystemFontOfSize:15];
            totalCost.frame = CGRectMake(190.0, 165.0, 120, 25);
            [totalCost setBackgroundColor:[UIColor clearColor]];
            
            
            submitBtn.frame = CGRectMake(5.0f, 320.0,150.0f, 35.0f);
            submitBtn.layer.cornerRadius = 17.0f;
            submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
            cancelButton.frame = CGRectMake(160.0f, 320.0,150.0f, 35.0f);
            cancelButton.layer.cornerRadius = 17.0f;
            cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
            
            normalstockTable.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, 360.0);
            
            skListTable.frame = CGRectMake(200, 200, 360,0);
            // receiptIDTable.frame = CGRectMake(60.0, 35, 360, 0);
            
            [scrollView addSubview:label2];
            [scrollView addSubview:label3];
            [scrollView addSubview:label4];
            [scrollView addSubview:label5];
            [scrollView addSubview:label8];
            [scrollView addSubview:label9];
            [scrollView addSubview:label10];
            [scrollView addSubview:label11];
            [scrollView addSubview:label12];
            [scrollView addSubview:label6];
            [scrollView addSubview:label7];
            [scrollView addSubview:totalCost];
            [scrollView addSubview:totalQuantity];
            
        }
        
        
        
    }
    
    //[self.view addSubview:mainSegmentedControl];
    [createReceiptView addSubview:supplierID];
    [createReceiptView addSubview:supplierName];
    [createReceiptView addSubview:location];
    [createReceiptView addSubview:deliveredBy];
    [createReceiptView addSubview:inspectedBy];
    [createReceiptView addSubview:date];
    [createReceiptView addSubview:poReference];
    [createReceiptView addSubview:selectDate];
    [createReceiptView addSubview:shipmentNote];
    [createReceiptView addSubview:shipoModeButton];
    [createReceiptView addSubview:reasonTxt];
    [createReceiptView addSubview:searchItem];
    //    [createReceiptView addSubview:label2];
    //    [createReceiptView addSubview:label3];
    //    [createReceiptView addSubview:label4];
    //    [createReceiptView addSubview:label5];
    //    [createReceiptView addSubview:label8];
    //    [createReceiptView addSubview:label9];
    //    [createReceiptView addSubview:label10];
    //    [createReceiptView addSubview:label11];
    //    [createReceiptView addSubview:label12];
    //    [createReceiptView addSubview:label6];
    //    [createReceiptView addSubview:label7];
    //    [createReceiptView addSubview:totalQuantity];
    //    [createReceiptView addSubview:totalCost];
    [scrollView addSubview:cartTable];
    [createReceiptView addSubview:scrollView];
    [self.view addSubview:submitBtn];
    [self.view addSubview:cancelButton];
    [createReceiptView addSubview:skListTable];
    [createReceiptView addSubview:supplierTable];
    createReceiptView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:createReceiptView];
    viewReceiptView.backgroundColor = [UIColor blackColor];
    [viewReceiptView addSubview:ReceiptID];
    [viewReceiptView addSubview:normalstockTable];
    [viewReceiptView addSubview:receiptIDTable];
    [self.view addSubview:viewReceiptView];
    [createReceiptView addSubview:supplierTable];
    
    
    
    [HUD hide:YES afterDelay:1.0];
    
    priceTable = [[UITableView alloc] init];
    priceTable.backgroundColor = [UIColor blackColor];
    [priceTable setDataSource:self];
    [priceTable setDelegate:self];
    [priceTable.layer setBorderWidth:1.0f];
    priceTable.layer.cornerRadius = 3;
    priceTable.layer.borderColor = [UIColor grayColor].CGColor;
    
    priceArr = [[NSMutableArray alloc]init];
    descArr = [[NSMutableArray alloc]init];
    
    closeBtn = [[UIButton alloc] init] ;
    [closeBtn addTarget:self action:@selector(closePriceView:) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.tag = 11;
    
    
    transparentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    transparentView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6f];
    transparentView.hidden = YES;
    
    UIImage *image = [UIImage imageNamed:@"delete.png"];
    [closeBtn setBackgroundImage:image	forState:UIControlStateNormal];
    
    
    priceView = [[UIView alloc] initWithFrame:CGRectMake(250, 200, self.view.frame.size.width, self.view.frame.size.height)];
    priceView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6f];
    // priceView.hidden = YES;
    
    transparentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    transparentView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6f];
    transparentView.hidden = YES;
    
    descLabl = [[UILabel alloc]init];
    descLabl.text = @"Description";
    descLabl.layer.cornerRadius = 14;
    [descLabl setTextAlignment:NSTextAlignmentCenter];
    descLabl.layer.masksToBounds = YES;
    descLabl.font = [UIFont boldSystemFontOfSize:14.0];
    descLabl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:14.0f];
    descLabl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    descLabl.textColor = [UIColor whiteColor];
    
    priceLbl = [[UILabel alloc]init];
    priceLbl.text = @"Price";
    priceLbl.layer.cornerRadius = 14;
    priceLbl.layer.masksToBounds = YES;
    [priceLbl setTextAlignment:NSTextAlignmentCenter];
    priceLbl.font = [UIFont boldSystemFontOfSize:14.0];
    priceLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:14.0f];
    priceLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    priceLbl.textColor = [UIColor whiteColor];
    
    priceLbl.frame = CGRectMake(300, 5, 180, 30);
    descLabl.frame = CGRectMake(30, 5, 250, 30);
    closeBtn.frame = CGRectMake(720, 175.0, 40, 40);
    transparentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    priceTable.frame = CGRectMake(0, 40, 480, 400);
    [priceView addSubview:priceLbl];
    [priceView addSubview:descLabl];
    [priceView addSubview:priceTable];
    [transparentView addSubview:priceView];
    [transparentView addSubview:closeBtn];
    [self.view addSubview:transparentView];
    
    [self callReceiptDetails];

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    version = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    
    NSArray *segmentLabels = [NSArray arrayWithObjects:@"New Receipt",@"View Receipt", nil];
    
    mainSegmentedControl = [[UISegmentedControl alloc] initWithItems:segmentLabels];
    
    mainSegmentedControl.tintColor=[UIColor colorWithRed:145.0/255.0 green:145.0/255.0 blue:145.0/255.0 alpha:1.0];
    //segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    mainSegmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    mainSegmentedControl.backgroundColor = [UIColor lightGrayColor];
    
    //UIColor *tintcolor=[UIColor colorWithRed:63.0/255.0 green:127.0/255.0 blue:187.0/255.0 alpha:1.0];
    //[[segmentedControl.subviews objectAtIndex:0] setTintColor:tintcolor];
    mainSegmentedControl.selectedSegmentIndex = 0;
    [mainSegmentedControl addTarget:self action:@selector(segmentAction1:) forControlEvents:UIControlEventValueChanged];
    
    // assigning a value to check the bill finished ..
    mainSegmentedControl.tag = 0;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        mainSegmentedControl.frame = CGRectMake(-2, 65, self.view.frame.size.width, 60);
        mainSegmentedControl.tintColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        mainSegmentedControl.backgroundColor = [UIColor clearColor];
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIFont boldSystemFontOfSize:18], UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor,
                                    nil];
        [mainSegmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    }
    else {
        if (version>=8.0) {
            
            mainSegmentedControl.frame = CGRectMake( -2, 60, 324, 47);
            mainSegmentedControl.tintColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
            mainSegmentedControl.backgroundColor = [UIColor clearColor];
            NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont boldSystemFontOfSize:18], UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor,
                                        nil];
            [mainSegmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
            
        }
        else {
            mainSegmentedControl.frame = CGRectMake(-2, 0.0, 324, 42);
            mainSegmentedControl.tintColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
            mainSegmentedControl.backgroundColor = [UIColor clearColor];
            NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont boldSystemFontOfSize:18], UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor,
                                        nil];
            [mainSegmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
        }
        
    }
    
    [self.view addSubview:mainSegmentedControl];
    
    rawMaterials = [[NSMutableArray alloc] init];
    skuArrayList = [[NSMutableArray alloc]init];
    tempSkuArrayList = [[NSMutableArray alloc] init];
    supplierList = [[NSMutableArray alloc] init];
    supplierCode = [[NSMutableArray alloc] init];
    poRefArr = [[NSMutableArray alloc]init];
    

}

-(IBAction) shipoModeButtonPressed:(id) sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    shipmodeList = [[NSMutableArray alloc] init];
    [shipmodeList addObject:@"Rail"];
    [shipmodeList addObject:@"Flight"];
    [shipmodeList addObject:@"Express"];
    [shipmodeList addObject:@"Ordinary"];
    
    PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320, 320)];
    customView.opaque = NO;
    customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    customView.layer.borderWidth = 2.0f;
    [customView setHidden:NO];
    
    
    pickView = [[UIView alloc] init];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        pickView.frame = CGRectMake(15, shipmentNote.frame.origin.y+shipmentNote.frame.size.height, 320, 320);
    }
    else{
        pickView.frame = CGRectMake(0, 0, 320, 460);
    }
    
    
    pickView.backgroundColor = [UIColor colorWithRed:(119/255.0) green:(136/255.0) blue:(153/255.0) alpha:0.8f];
    pickView.layer.masksToBounds = YES;
    pickView.layer.cornerRadius = 12.0f;
    
    shipModeTable = [[UITableView alloc]init];
    shipModeTable.layer.borderWidth = 1.0;
    shipModeTable.layer.cornerRadius = 10.0;
    shipModeTable.bounces = FALSE;
    shipModeTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    shipModeTable.layer.borderColor = [UIColor blackColor].CGColor;
    [shipModeTable setDataSource:self];
    [shipModeTable setDelegate:self];
    
    shipModeTable.hidden = NO;
    shipModeTable.frame = CGRectMake(0.0, 0.0, customView.frame.size.width, customView.frame.size.height);
    [customView addSubview:shipModeTable];
    [shipModeTable reloadData];
    
    customerInfoPopUp.view = customView;
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        
        [popover presentPopoverFromRect:shipmentNote.frame inView:createReceiptView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        
        
        catPopOver= popover;
        
    }
    
    else {
        
        customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        // popover.contentViewController.view.alpha = 0.0;
        [[[popover contentViewController]  view] setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:1.0f]];
        [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        catPopOver = popover;
        
    }
    
    UIGraphicsBeginImageContext(customView.frame.size);
    [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    customView.backgroundColor = [UIColor colorWithPatternImage:image];
    
    
}

-(void) getAllReceiptIDS:(int)requestStartPoint {
    
    [HUD setHidden:NO];
    
    BOOL status = FALSE;
    StockRequestsSoapBinding *materialBinding = [[StockRequests StockRequestsSoapBinding] retain];
    
    StockRequests_getStockRequests *aparams = [[StockRequests_getStockRequests alloc] init];
    
    NSArray *headerKeys_ = [NSArray arrayWithObjects:@"start",@"location",@"requestHeader", nil];
    
    NSArray *headerObjects_ = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",requestStartPoint],presentLocation,[RequestHeader getRequestHeader], nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects_ forKeys:headerKeys_];
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
    NSString * createBillingJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    aparams.stockRequestDetails =createBillingJsonString;
    //    tns1_getStockProcurementReceipts *aparams = [[tns1_getStockProcurementReceipts alloc] init];
    //    aparams.start = [NSString stringWithFormat:@"%d",requestStartPoint];
    
    //    StockReceiptServiceSvc_getStockProcurementReceipts *aParams = [[StockReceiptServiceSvc_getStockProcurementReceipts alloc] init];
    //    aParams.start = [NSString stringWithFormat:@"%d",requestStartPoint];
    
    @try {
        
        StockRequestsSoapBindingResponse *response = [materialBinding getStockRequestsUsingParameters:aparams];
        NSArray *responseBodyParts = response.bodyParts;
        NSDictionary *JSONData;
        
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[StockRequests_getStockRequestsResponse class]]) {
                StockRequests_getStockRequestsResponse *body = (StockRequests_getStockRequestsResponse *)bodyPart;
                
                NSError *err;
                NSLog(@"%@",body.return_);
                JSONData = [[NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                            options: NSJSONReadingMutableContainers
                                                              error: &err] copy];
                status = TRUE;
                requestJSON = [JSONData copy];
            }
        }
        if (status) {
            
            [HUD setHidden:YES];
            NSDictionary *responseDic = [requestJSON valueForKey:@"responseHeader"];
            if ([[responseDic objectForKey:@"responseCode"] isEqualToString:@"0"] && [[responseDic objectForKey:@"responseMessage"] isEqualToString:@"Success"]) {
                NSArray *temp = [requestJSON objectForKey:@"stockRequests"];
                if ([temp count] == 0) {
                    requestScrollValueStatus = YES;
                    //                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Receipts are not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    //                [alert show];
                }
                else {
                    for (int i = 0; i < [temp count]; i++) {
                        NSDictionary *receipt = [temp objectAtIndex:i];
                        [procurementReceipts addObject:[receipt objectForKey:@"stockRequestId"]];
                        [procuremnetReceiptDetails addObject:receipt];
                    }
                    [normalstockTable reloadData];
                }
            }
            else{
                
            }
        }
    }
    @catch (NSException *exception) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Failed to get the receipts" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    @finally {
        
        [HUD setHidden:YES];
    }
    
    
    
    
    //[HUD hide:YES afterDelay:1.0];
    
}


-(void) callRawMaterials:(NSString *)searchString {
    // BOOL status = FALSE;
    
    [HUD setHidden:NO];
    
    //    SkuServiceSoapBinding *skuService = [[SkuServiceSvc SkuServiceSoapBinding] retain];
    //
    //    SkuServiceSvc_searchProducts *getSkuid = [[SkuServiceSvc_searchProducts alloc] init];
    NSArray *keys = [NSArray arrayWithObjects:@"requestHeader",@"startIndex",@"searchCriteria",nil];
    NSArray *objects = [NSArray arrayWithObjects:[RequestHeader getRequestHeader],@"0",searchString, nil];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
    NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    @try {
        
        WebServiceController *webServiceController = [WebServiceController new];
        [webServiceController setSearchProductDelegate:self];
        [webServiceController searchProductsWithData:salesReportJsonString];
        
        //        SkuServiceSoapBindingResponse *response = [skuService searchProductsUsingParameters:getSkuid];
        //        NSArray *responseBodyParts = response.bodyParts;
        //        for (id bodyPart in responseBodyParts) {
        //            if ([bodyPart isKindOfClass:[SkuServiceSvc_searchProductsResponse class]]) {
        //                SkuServiceSvc_searchProductsResponse *body = (SkuServiceSvc_searchProductsResponse *)bodyPart;
        //                printf("\nresponse=%s",[body.return_ UTF8String]);
        //                NSError *e;
        //                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
        //                                                                     options: NSJSONReadingMutableContainers
        //                                                                       error: &e];
        //                [HUD setHidden:YES];
        //
        //                NSArray *list = [JSON objectForKey:@"productsList"];
        //
        //                [tempSkuArrayList addObjectsFromArray:list];
        //            }
        //        }
        
    }
    @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No data found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
    
    
    //[skListTable reloadData];
    
}

- (IBAction)selectStartDate:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    
    PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320, 320)];
    customView.opaque = NO;
    customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    customView.layer.borderWidth = 2.0f;
    [customView setHidden:NO];
    
    
    pickView = [[UIView alloc] init];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        pickView.frame = CGRectMake(15, poReference.frame.origin.y+poReference.frame.size.height, 320, 320);
    }
    else{
        pickView.frame = CGRectMake(0, 0, 320, 460);
    }
    
    
    pickView.backgroundColor = [UIColor colorWithRed:(119/255.0) green:(136/255.0) blue:(153/255.0) alpha:0.8f];
    pickView.layer.masksToBounds = YES;
    pickView.layer.cornerRadius = 12.0f;
    
    //pickerframe creation...
    CGRect pickerFrame = CGRectMake(0,50,0,0);
    myPicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    
    //Current Date...
    NSDate *now = [NSDate date];
    [myPicker setDate:now animated:YES];
    [myPicker setBackgroundColor:[UIColor whiteColor]];
    
    UIButton  *pickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    
    [pickButton setBackgroundImage:[UIImage imageNamed:@"ok2.jpg"] forState:UIControlStateNormal];
    
    pickButton.frame = CGRectMake(85, 269, 100, 45);
    pickButton.backgroundColor = [UIColor clearColor];
    pickButton.layer.masksToBounds = YES;
    [pickButton addTarget:self action:@selector(getStartDate:) forControlEvents:UIControlEventTouchUpInside];
    pickButton.layer.borderColor = [UIColor blackColor].CGColor;
    pickButton.layer.borderWidth = 0.5f;
    pickButton.layer.cornerRadius = 12;
    //pickButton.layer.masksToBounds = YES;
    [customView addSubview:myPicker];
    [customView addSubview:pickButton];
    
    
    customerInfoPopUp.view = customView;
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        
        [popover presentPopoverFromRect:poReference.frame inView:createReceiptView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        
        
        catPopOver= popover;
        
    }
    
    else {
        
        customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        // popover.contentViewController.view.alpha = 0.0;
        [[[popover contentViewController]  view] setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:1.0f]];
        [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        catPopOver = popover;
        
    }
    
    UIGraphicsBeginImageContext(customView.frame.size);
    [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    customView.backgroundColor = [UIColor colorWithPatternImage:image];
    
    
    
}
-(IBAction)getStartDate:(id)sender{
    
    AudioServicesPlaySystemSound (soundFileObject);
    
    //Date Formate Setting...
    
    NSDateFormatter *sdayFormat = [[NSDateFormatter alloc] init];
    [sdayFormat setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *dateString = [sdayFormat stringFromDate:myPicker.date];
    
    poReference.text = dateString;
    [pickView removeFromSuperview];
    [catPopOver dismissPopoverAnimated:YES];
    
    //    if ([WebServiceUtility checkDateValidity:dateString secondDate:nil]) {
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Select proper date" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //        [alert show];
    //        dateOfReturn.text = @"";
    //    }
}

#pragma mark - Search Products Service Reposnse Delegates

- (void)searchProductsSuccessResponse:(NSDictionary *)successDictionary {
    
    [tempSkuArrayList removeAllObjects];
    @try {
        if (successDictionary != nil) {
            if (![[successDictionary objectForKey:@"productsList"] isKindOfClass:[NSNull class]]) {
                NSArray *list = [successDictionary objectForKey:@"productsList"];
                [tempSkuArrayList addObjectsFromArray:list];
            }
            [skuArrayList removeAllObjects];
            [rawMaterials removeAllObjects];
            for (NSDictionary *product in tempSkuArrayList)
            {
                NSComparisonResult result;
                
                if (!([[product objectForKey:@"productId"] rangeOfString:searchStringStock options:NSCaseInsensitiveSearch].location == NSNotFound))
                {
                    result = [[product objectForKey:@"productId"] compare:searchStringStock options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchStringStock length])];
                    if (result == NSOrderedSame)
                    {
                        [skuArrayList addObject:[product objectForKey:@"productId"]];
                        [rawMaterials addObject:product];
                        
                    }
                }
                if (!([[product objectForKey:@"description"] rangeOfString:searchStringStock options:NSCaseInsensitiveSearch].location == NSNotFound)) {
                    
                    [skuArrayList addObject:[product objectForKey:@"description"]];
                    [rawMaterials addObject:product];
                    
                    
                    
                    
                }
                else {
                    
                    // [filteredSkuArrayList addObject:[product objectForKey:@"skuID"]];
                    
                    
                    result = [[product objectForKey:@"skuID"] compare:searchStringStock options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchStringStock length])];
                    
                    if (result == NSOrderedSame)
                    {
                        [skuArrayList addObject:[product objectForKey:@"skuID"]];
                        [rawMaterials addObject:product];
                        
                    }
                }
                
                
            }
            
            if ([skuArrayList count] > 0) {
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    skListTable.frame = CGRectMake(10, 270.0, searchItem.frame.size.width,240);
                }
                else {
                    if (version >= 8.0) {
                        skListTable.frame = CGRectMake(60, 170, 180,200);
                    }
                    else{
                        skListTable.frame = CGRectMake(60.0, 170.0, 180, 130);
                    }
                }
                
                if ([skuArrayList count] > 5) {
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        skListTable.frame = CGRectMake(10, 270.0, searchItem.frame.size.width,450);
                    }
                    else {
                        if (version >= 8.0) {
                            skListTable.frame = CGRectMake(60, 170, 180,200);
                        }
                        else{
                            skListTable.frame = CGRectMake(60.0, 170.0, 180, 130);
                        }
                    }
                }
                [self.view bringSubviewToFront:skListTable];
                [skListTable reloadData];
                skListTable.hidden = NO;
            }
            else {
                skListTable.hidden = YES;
            }
        }
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
    }
    [HUD setHidden:YES];
    
}
- (void)searchProductsErrorResponse {
    [HUD setHidden:YES];
    
}
#pragma mark End of Search Products Service Reposnse Delegates -



-(void)callReceiptIDS:(NSString *)searchString {
    
    BOOL status = FALSE;
    
    StockReceiptServiceSoapBinding *materialBinding = [[StockReceiptServiceSvc StockReceiptServiceSoapBinding] retain];
    
    StockReceiptServiceSvc_getStockProcurementReceiptIds *aparams = [[StockReceiptServiceSvc_getStockProcurementReceiptIds alloc] init];
    //    tns1_getStockProcurementReceiptIds *aparams = [[tns1_getStockProcurementReceiptIds alloc] init];
    
    NSArray *headerKeys_ = [NSArray arrayWithObjects:@"searchCriteria",@"location",@"store_location",@"requestHeader", nil];
    
    NSArray *headerObjects_ = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",searchString],presentLocation,presentLocation,[RequestHeader getRequestHeader], nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects_ forKeys:headerKeys_];
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
    NSString * createBillingJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    aparams.searchCriteria = createBillingJsonString;
    
    NSDictionary *JSON ;
    
    @try {
        
        StockReceiptServiceSoapBindingResponse *response = [materialBinding getStockProcurementReceiptIdsUsingParameters:(StockReceiptServiceSvc_getStockProcurementReceiptIds *)aparams];
        NSArray *responseBodyParts = response.bodyParts;
        
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[StockReceiptServiceSvc_getStockProcurementReceiptIdsResponse class]]) {
                StockReceiptServiceSvc_getStockProcurementReceiptIdsResponse *body = (StockReceiptServiceSvc_getStockProcurementReceiptIdsResponse *)bodyPart;
                
                NSError *err;
                status = TRUE;
                JSON = [[NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                        options: NSJSONReadingMutableContainers
                                                          error: &err] copy];
            }
        }
        
    }
    @catch (NSException *exception) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Failed to get the receipt ids" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    
    if (status) {
        
        NSArray *temp = [JSON objectForKey:@"receipt_id"];
        
        receiptIDS = [[NSMutableArray alloc] initWithArray:temp];
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
    
}

- (void)textFieldDidChange:(UITextField *)textField {
    if (textField == searchItem) {
        
        if ([textField.text length] >= 3) {
            searchStringStock = [textField.text copy];
            [self callRawMaterials:textField.text];
        }
    }
    else if (textField == supplierName) {
        if ([textField.text length] >= 3) {
            
            [self getSuppliers:textField.text];
            
            if ([supplierList count] > 0) {
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    supplierTable.frame = CGRectMake(10, 60, 360,240);
                }
                else {
                    if (version >= 8.0) {
                        supplierTable.frame = CGRectMake(60, 35, 180,130);
                    }
                    else{
                        supplierTable.frame = CGRectMake(60, 35, 180,150);
                    }
                }
                
                if ([supplierList count] > 5) {
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        supplierTable.frame = CGRectMake(10, 60, 360,450);
                    }
                    else {
                        if (version >= 8.0) {
                            supplierTable.frame = CGRectMake(60, 35, 180,130);
                        }
                        else{
                            supplierTable.frame = CGRectMake(60, 35, 180,150);
                        }
                    }
                }
                [createReceiptView bringSubviewToFront:supplierTable];
                [supplierTable reloadData];
                supplierTable.hidden = NO;
            }
            else {
                supplierTable.hidden = YES;
            }
        }
    }
    else if (textField == ReceiptID){
        if ([textField.text length] >= 3) {
            
            [self callReceiptIDS:textField.text];
            if ([receiptIDS count] > 0) {
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    receiptIDTable.frame = CGRectMake(200, 60, 360,240);
                }
                else {
                    if (version >= 8.0) {
                        receiptIDTable.frame = CGRectMake(60, 35, 180,130);
                    }
                    else{
                        receiptIDTable.frame = CGRectMake(60, 35, 180,150);
                    }
                }
                
                if ([receiptIDS count] > 5) {
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        receiptIDTable.frame = CGRectMake(200, 60, 360,450);
                    }
                    else {
                        if (version >= 8.0) {
                            receiptIDTable.frame = CGRectMake(60, 35, 180,130);
                        }
                        else{
                            receiptIDTable.frame = CGRectMake(60, 35, 180,150);
                        }
                    }
                }
                [self.view bringSubviewToFront:receiptIDTable];
                [receiptIDTable reloadData];
                receiptIDTable.hidden = NO;
            }
            else {
                receiptIDTable.hidden = YES;
            }
        }
    }
    //    else if (textField == poReference) {
    //
    //        if ([textField.text length]>=3) {
    //            [self getPurchaseOrders];
    //
    //        }
    //
    //    }
}

- (void) segmentAction1: (id) sender  {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    mainSegmentedControl = (UISegmentedControl *)sender;
    index = mainSegmentedControl.selectedSegmentIndex;
    
    switch (index) {
        case 0:
            createReceiptView.hidden = NO;
            viewReceiptView.hidden = YES;
            break;
        case 1:
            createReceiptView.hidden = YES;
            viewReceiptView.hidden = NO;
            
            requestStartPoint = 0;
            @try {
                
                [procurementReceipts removeAllObjects];
                [procuremnetReceiptDetails removeAllObjects];
                [self getAllReceiptIDS:requestStartPoint];
                
            }
            @catch (NSException *exception) {
                
                
            }
            
            
            
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (tableView == cartTable) {
            return 56.0;
        }
        else if (tableView == priceTable) {
            return 40.0;
        }
        else if (tableView == normalstockTable){
            return 170.0;
        }
        else if (tableView == receiptIDTable){
            return 45.0;
        }
        else {
            return 45.0;
        }
    }
    else {
        if (tableView == cartTable) {
            return 33.0;
        }
        
        else if (tableView == normalstockTable){
            return 120.0;
        }
        
        else {
            return 28.0;
        }
    }
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == cartTable) {
        return [rawMaterialDetails count];
    }
    else if (tableView == priceTable){
        return [priceDic count];
    }
    else if (tableView == shipModeTable) {
        return [shipmodeList count];
    }
    else if (tableView == normalstockTable){
        return [procurementReceipts count];
    }
    else if (tableView == receiptIDTable){
        return [receiptIDS count];
    }
    else if (tableView == supplierTable) {
        return [supplierList count];
    }
    else{
        return [skuArrayList count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    tableView.separatorColor = [UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0];
    
    static NSString *hlCellID = @"hlCellID";
    
    UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
    
    static NSString *MyIdentifier = @"MyIdentifier";
    MyIdentifier = @"TableView";
    if (tableView == normalstockTable) {
        
        if ([hlcell.contentView subviews]){
            for (UIView *subview in [hlcell.contentView subviews]) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil) {
            hlcell =  [[[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID] autorelease];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
        }
        NSString *procurementReceipt = [procurementReceipts objectAtIndex:indexPath.row];
        NSDictionary *procurmentDetails = [procuremnetReceiptDetails objectAtIndex:indexPath.row];
        
        UILabel *receiptID = [[UILabel alloc] init];
        receiptID.frame = CGRectMake(10.0, 10.0, 350.0, 50.0);
        receiptID.font = [UIFont boldSystemFontOfSize:25.0];
        receiptID.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
        receiptID.text = procurementReceipt;
        [receiptID setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:0.5f]];
        receiptID.layer.cornerRadius = 10.0f;
        receiptID.layer.masksToBounds = YES;
        receiptID.textAlignment = NSTextAlignmentCenter;
        
        UILabel *supplier_ID = [[UILabel alloc] init];
        supplier_ID.frame = CGRectMake(10.0, 65.0, 200.0, 55.0);
        supplier_ID.font = [UIFont boldSystemFontOfSize:20.0];
        supplier_ID.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
        supplier_ID.text = [NSString stringWithFormat:@"%@",[procurmentDetails objectForKey:@"fromStoreCode"]];
        
        UILabel *supplier_Name = [[UILabel alloc] init];
        supplier_Name.frame = CGRectMake(10.0, 120.0, 250.0, 55.0);
        supplier_Name.font = [UIFont boldSystemFontOfSize:20.0];
        supplier_Name.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
        supplier_Name.text = [NSString stringWithFormat:@"%@",[procurmentDetails objectForKey:@"toStoreCode"]];
        
        UIImageView *statusView = [[UIImageView alloc] init];
        if ([[procurmentDetails objectForKey:@"status"] isEqualToString:@"Pending"]) {
            
            statusView.backgroundColor = [UIColor clearColor];
            statusView.image = [UIImage imageNamed:@"pending.png"];
            statusView.frame = CGRectMake(700.0, 65.0, 50.0, 50.0);
        }
        
        UILabel *date_ = [[UILabel alloc] init];
        date_.frame = CGRectMake(650.0, 10.0, 200.0, 55.0);
        date_.font = [UIFont boldSystemFontOfSize:20.0];
        date_.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
        date_.text = [NSString stringWithFormat:@"%@",[procurmentDetails objectForKey:@"requestDateStr"]];
        
        UILabel *total = [[UILabel alloc] init];
        total.frame = CGRectMake(650.0, 100.0, 200.0, 55.0);
        total.font = [UIFont boldSystemFontOfSize:20.0];
        total.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
        total.text = [NSString stringWithFormat:@"%.2f",[[procurmentDetails objectForKey:@"totalStockRequestValue"] floatValue]];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            if (version >= 8.0) {
                
                receiptID.frame = CGRectMake(10.0, 10.0, 120.0, 35.0);
                receiptID.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];
                [receiptID setBackgroundColor:[UIColor clearColor]];
                
                supplier_ID.frame = CGRectMake(10.0, 45.0, 120.0, 35.0);
                supplier_ID.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];
                [supplier_ID setBackgroundColor:[UIColor clearColor]];
                
                supplier_Name.frame = CGRectMake(10.0, 90.0, 200.0, 35.0);
                supplier_Name.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];
                [supplier_Name setBackgroundColor:[UIColor clearColor]];
                
                statusView.frame = CGRectMake(250.0, 70.0, 35.0, 35.0);
                
                date_.frame = CGRectMake(225.0, 10.0, 200.0, 35.0);
                date_.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];
                [date_ setBackgroundColor:[UIColor clearColor]];
                
                total.frame = CGRectMake(220.0, 45.0, 150.0, 35.0);
                total.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];
                [total setBackgroundColor:[UIColor clearColor]];
            }
            else {
                receiptID.frame = CGRectMake(10.0, 10.0, 120.0, 35.0);
                receiptID.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:17.0];
                [receiptID setBackgroundColor:[UIColor clearColor]];
                
                supplier_ID.frame = CGRectMake(10.0, 45.0, 120.0, 35.0);
                supplier_ID.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:17.0];
                [supplier_ID setBackgroundColor:[UIColor clearColor]];
                
                supplier_Name.frame = CGRectMake(10.0, 90.0, 200.0, 35.0);
                supplier_Name.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:17.0];
                [supplier_Name setBackgroundColor:[UIColor clearColor]];
                
                statusView.frame = CGRectMake(250.0, 55.0, 35.0, 35.0);
                
                date_.frame = CGRectMake(225.0, 10.0, 200.0, 35.0);
                date_.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:17.0];
                [date_ setBackgroundColor:[UIColor clearColor]];
                
                total.frame = CGRectMake(220.0, 55.0, 150.0, 35.0);
                total.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:17.0];
                [total setBackgroundColor:[UIColor clearColor]];
            }
            
            
        }
        
        [hlcell setBackgroundColor:[UIColor blackColor]];
        [hlcell.contentView addSubview:receiptID];
        [hlcell.contentView addSubview:supplier_ID];
        [hlcell.contentView addSubview:supplier_Name];
        [hlcell.contentView addSubview:date_];
        [hlcell.contentView addSubview:statusView];
        [hlcell.contentView addSubview:total];
        
        if (indexPath.row % 2 == 0) {
            hlcell.contentView.backgroundColor = [UIColor blackColor];
        }
        else{
            hlcell.contentView.backgroundColor = [UIColor blackColor];
        }
        return hlcell;
    }
    else if (tableView == shipModeTable){
        if ([hlcell.contentView subviews]){
            for (UIView *subview in [hlcell.contentView subviews]) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil) {
            hlcell =  [[[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID] autorelease];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                hlcell.textLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25];
            }
            else {
                hlcell.textLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:13];
                
            }
        }
        
        hlcell.textLabel.text = [shipmodeList objectAtIndex:indexPath.row];
        return hlcell;
    }
    else if (tableView == priceTable) {
        
        static NSString *hlCellID = @"hlCellID";
        
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
        
        if ([hlcell.contentView subviews]){
            
            for (UIView *subview in [hlcell.contentView subviews]) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                       initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID] ;
            hlcell.accessoryType = UITableViewCellAccessoryNone;
        }
        tableView.separatorColor = [UIColor clearColor];
        @try {
            
            NSDictionary *dic = [priceDic objectAtIndex:indexPath.row];
            
            UILabel *skid = [[UILabel alloc] init] ;
            skid.layer.borderWidth = 1.5;
            skid.font = [UIFont systemFontOfSize:13.0];
            skid.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:13];
            skid.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            skid.backgroundColor = [UIColor blackColor];
            skid.textColor = [UIColor whiteColor];
            skid.text = [dic valueForKey:@"description"];
            skid.textAlignment=NSTextAlignmentCenter;
            //            skid.adjustsFontSizeToFitWidth = YES;
            
            
            UILabel *name = [[UILabel alloc] init] ;
            name.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            name.layer.borderWidth = 1.5;
            name.backgroundColor = [UIColor blackColor];
            name.text = [NSString stringWithFormat:@"%.2f",[[dic valueForKey:@"price"] floatValue]];
            name.textAlignment = NSTextAlignmentCenter;
            name.numberOfLines = 2;
            name.textColor = [UIColor whiteColor];
            // name.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:12];
            
            [hlcell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                skid.font = [UIFont systemFontOfSize:18];
                skid.frame = CGRectMake(0, 0, 300, 50);
                name.font = [UIFont systemFontOfSize:18];
                name.frame = CGRectMake(300, 0, 180, 50);
                //                }
                //                else {
                //                    //skid.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:22];
                //                    skid.font = [UIFont fontWithName:@"Helvetica" size:22];
                //                    skid.frame = CGRectMake(5, 0, 125, 56);
                //                    name.font = [UIFont fontWithName:@"Helvetica" size:18];
                //                    name.frame = CGRectMake(130, 0, 125, 56);
                //
                //                }
                //
                
            }
            else {
                
                skid.frame = CGRectMake(5, 0, 58, 34);
                name.frame = CGRectMake(62, 0, 58, 34);
                
                
            }
            
            [hlcell setBackgroundColor:[UIColor clearColor]];
            [hlcell.contentView addSubview:skid];
            [hlcell.contentView addSubview:name];
            
        }
        @catch (NSException *exception) {
            
            NSLog(@"%@",exception);
            
        }
        @finally {
            
            
        }
        return hlcell;
    }
    else if (tableView == cartTable){
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        static NSString *hlCellID = @"hlCellID";
        
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
        
        if ([hlcell.contentView subviews]){
            for (UIView *subview in [hlcell.contentView subviews]) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil) {
            hlcell =  [[[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID] autorelease];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
        }
        //
        
        @try {
            
            NSArray *temp = [rawMaterialDetails objectAtIndex:indexPath.row];
            
            UILabel *item_code = [[[UILabel alloc] init] autorelease];
            item_code.layer.borderWidth = 1.5;
            item_code.font = [UIFont systemFontOfSize:13.0];
            item_code.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
            item_code.backgroundColor = [UIColor blackColor];
            item_code.textColor = [UIColor whiteColor];
            
            item_code.text = [NSString stringWithFormat:@"%@",[temp objectAtIndex:0]];
            item_code.textAlignment=NSTextAlignmentCenter;
            //        item_code.adjustsFontSizeToFitWidth = YES;
            //name.adjustsFontSizeToFitWidth = YES;
            
            UILabel *item_plucode = [[[UILabel alloc] init] autorelease];
            item_plucode.layer.borderWidth = 1.5;
            item_plucode.font = [UIFont systemFontOfSize:13.0];
            item_plucode.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
            item_plucode.backgroundColor = [UIColor blackColor];
            item_plucode.textColor = [UIColor whiteColor];
            
            item_plucode.text = [NSString stringWithFormat:@"%@",[temp objectAtIndex:1]];
            item_plucode.textAlignment=NSTextAlignmentCenter;
            //        item_description.adjustsFontSizeToFitWidth = YES;
            
            UILabel *item_desc = [[[UILabel alloc] init] autorelease];
            item_desc.layer.borderWidth = 1.5;
            item_desc.font = [UIFont systemFontOfSize:13.0];
            item_desc.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
            item_desc.backgroundColor = [UIColor blackColor];
            item_desc.text = [NSString stringWithFormat:@"%@",[temp objectAtIndex:2]];
            item_desc.textColor = [UIColor whiteColor];
            item_desc.textAlignment=NSTextAlignmentCenter;
            item_desc.adjustsFontSizeToFitWidth = YES;
            
            
            UIButton *price = [[[UIButton alloc] init] autorelease];
            [price setTitle:[NSString stringWithFormat:@"%.2f",[[temp objectAtIndex:3] floatValue]] forState:UIControlStateNormal];
            price.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
            price.layer.borderWidth = 1.5;
            [price setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [price addTarget:self action:@selector(changeQuantity:) forControlEvents:UIControlEventTouchUpInside];
            price.layer.masksToBounds = YES;
            price.tag = indexPath.row;
            [price setUserInteractionEnabled:NO];
            
            //            UILabel *quantity = [[[UILabel alloc] init] autorelease];
            //            quantity.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
            //            quantity.layer.borderWidth = 1.5;
            //            quantity.font = [UIFont systemFontOfSize:13.0];
            //            quantity.backgroundColor = [UIColor blackColor];
            //            quantity.text = [NSString stringWithFormat:@"%d", [[temp objectAtIndex:4] intValue]];
            //            quantity.textColor = [UIColor whiteColor];
            //            quantity.textAlignment=NSTextAlignmentCenter;
            //            quantity.adjustsFontSizeToFitWidth = YES;
            
            UIButton *quantity = [[[UIButton alloc] init] autorelease];
            [quantity setTitle:[NSString stringWithFormat:@"%d",[[temp objectAtIndex:4] intValue]] forState:UIControlStateNormal];
            quantity.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
            quantity.layer.borderWidth = 1.5;
            [quantity setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [quantity addTarget:self action:@selector(changeQuantity:) forControlEvents:UIControlEventTouchUpInside];
            quantity.layer.masksToBounds = YES;
            quantity.tag = indexPath.row;
            
            UILabel *cost = [[[UILabel alloc] init] autorelease];
            cost.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
            cost.layer.borderWidth = 1.5;
            cost.font = [UIFont systemFontOfSize:13.0];
            cost.backgroundColor = [UIColor blackColor];
            cost.text = [NSString stringWithFormat:@"%.2f", [[temp objectAtIndex:5] floatValue]];
            cost.textColor = [UIColor whiteColor];
            cost.textAlignment=NSTextAlignmentCenter;
            cost.adjustsFontSizeToFitWidth = YES;
            
            UILabel *color = [[[UILabel alloc] init] autorelease];
            color.layer.borderWidth = 1.5;
            color.font = [UIFont systemFontOfSize:13.0];
            color.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
            color.backgroundColor = [UIColor blackColor];
            color.textColor = [UIColor whiteColor];
            if ([[NSString stringWithFormat:@"%@",[temp objectAtIndex:6]] length] > 0) {
                color.text = [NSString stringWithFormat:@"%@",[temp objectAtIndex:6]];
            }
            else {
                color.text = @"NA";
            }
            color.textAlignment=NSTextAlignmentCenter;
            color.adjustsFontSizeToFitWidth = YES;
            
            UILabel *model = [[[UILabel alloc] init] autorelease];
            model.layer.borderWidth = 1.5;
            model.font = [UIFont systemFontOfSize:13.0];
            model.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
            model.backgroundColor = [UIColor blackColor];
            model.textColor = [UIColor whiteColor];
            
            model.text = [NSString stringWithFormat:@"%@",[temp objectAtIndex:7]];
            model.textAlignment=NSTextAlignmentCenter;
            model.adjustsFontSizeToFitWidth = YES;
            
            UIButton *rejectQtyButton = [[[UIButton alloc] init] autorelease];
            [rejectQtyButton setTitle:[NSString stringWithFormat:@"%@",[temp objectAtIndex:8]] forState:UIControlStateNormal];
            rejectQtyButton.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
            rejectQtyButton.layer.borderWidth = 1.5;
            [rejectQtyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [rejectQtyButton addTarget:self action:@selector(changeRejectQuantity:) forControlEvents:UIControlEventTouchUpInside];
            rejectQtyButton.layer.masksToBounds = YES;
            rejectQtyButton.tag = indexPath.row;
            
            UIButton *delrowbtn = [[[UIButton alloc] init] autorelease];
            [delrowbtn setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
            [delrowbtn addTarget:self action:@selector(delRow:) forControlEvents:UIControlEventTouchUpInside];
            delrowbtn.tag = indexPath.row;
            delrowbtn.backgroundColor = [UIColor clearColor];
            [delrowbtn setHidden:NO];
            [rejectQtyButton setUserInteractionEnabled:NO];
            [quantity setUserInteractionEnabled:YES];
            
            [hlcell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                //skid.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:22];
                item_code.font = [UIFont fontWithName:@"ArialRoundedMT" size:20];
                item_code.frame = CGRectMake(0, 0, 90, 56);
                item_plucode.font = [UIFont fontWithName:@"ArialRoundedMT" size:20];
                item_plucode.frame = CGRectMake(93, 0, 90, 56);
                item_desc.font = [UIFont fontWithName:@"ArialRoundedMT" size:20];
                item_desc.frame = CGRectMake(185, 0, 150, 56);
                price.frame = CGRectMake(338, 0, 90, 56);
                price.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMT" size:20.0];
                quantity.frame = CGRectMake(431, 0, 110, 56);
                cost.font = [UIFont fontWithName:@"ArialRoundedMT" size:20];
                cost.frame = CGRectMake(544, 0, 110, 56);
                color.font = [UIFont fontWithName:@"ArialRoundedMT" size:20];
                color.frame = CGRectMake(657, 0, 110, 56);
                model.font = [UIFont fontWithName:@"ArialRoundedMT" size:20];
                model.frame = CGRectMake(770, 0, 110, 56);
                rejectQtyButton.frame = CGRectMake(883, 0, 90, 56);
                rejectQtyButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMT" size:20.0];
                delrowbtn.frame = CGRectMake(975.0, 10 , 40, 40);
                
            }
            else {
                if (version>=8.0) {
                    
                    item_code.font = [UIFont fontWithName:@"ArialRoundedMT" size:12];
                    item_code.frame = CGRectMake(0, 0, 60, 30);
                    item_plucode.font = [UIFont fontWithName:@"ArialRoundedMT" size:12];
                    item_plucode.frame = CGRectMake(60, 0, 60, 30);
                    item_desc.font = [UIFont fontWithName:@"ArialRoundedMT" size:12];
                    item_desc.frame = CGRectMake(120, 0, 60, 30);
                    price.frame = CGRectMake(180, 0, 50, 30);
                    quantity.frame = CGRectMake(230, 0, 60, 30);
                    
                    //                    make.font = [UIFont fontWithName:@"ArialRoundedMT" size:12];
                    //                    make.frame = CGRectMake(290, 0, 60, 30);
                    
                    color.font = [UIFont fontWithName:@"ArialRoundedMT" size:12];
                    color.frame = CGRectMake(290, 0, 60, 30);
                    
                    model.font = [UIFont fontWithName:@"ArialRoundedMT" size:12];
                    model.frame = CGRectMake(350, 0, 60, 30);
                    
                    rejectQtyButton.frame = CGRectMake(410, 0, 60, 30);
                    rejectQtyButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMT" size:12];
                    delrowbtn.frame = CGRectMake(490, 2 , 30, 30);
                }
                else {
                    
                    item_code.font = [UIFont fontWithName:@"ArialRoundedMT" size:15];
                    item_code.frame = CGRectMake(0, 0, 60, 30);
                    item_plucode.font = [UIFont fontWithName:@"ArialRoundedMT" size:15];
                    item_plucode.frame = CGRectMake(60, 0, 60, 30);
                    item_desc.font = [UIFont fontWithName:@"ArialRoundedMT" size:15];
                    item_desc.frame = CGRectMake(120, 0, 60, 30);
                    price.frame = CGRectMake(180, 0, 50, 30);
                    quantity.frame = CGRectMake(230, 0, 60, 30);
                    
                    cost.font = [UIFont fontWithName:@"Helvetica" size:25];
                    cost.frame = CGRectMake(290, 0, 60, 30);
                    
                    color.font = [UIFont fontWithName:@"ArialRoundedMT" size:15];
                    color.frame = CGRectMake(350, 0, 60, 30);
                    
                    model.font = [UIFont fontWithName:@"ArialRoundedMT" size:25];
                    model.frame = CGRectMake(410.0, 0, 60, 30);
                    
                    rejectQtyButton.frame = CGRectMake(470.0, 0, 60, 30);
                    delrowbtn.frame = CGRectMake(535.0, 2 , 30, 30);
                    
                    
                }
                
                
            }
            
            
            
            
            [hlcell setBackgroundColor:[UIColor clearColor]];
            [hlcell.contentView addSubview:item_code];
            [hlcell.contentView addSubview:item_plucode];
            [hlcell.contentView addSubview:item_desc];
            [hlcell.contentView addSubview:price];
            [hlcell.contentView addSubview:quantity];
            [hlcell.contentView addSubview:cost];
            [hlcell .contentView addSubview:color];
            [hlcell.contentView addSubview:model];
            [hlcell.contentView addSubview:rejectQtyButton];
            [hlcell addSubview:delrowbtn];
        }
        @catch (NSException *exception) {
            
            
        }
        
        
        //
        return hlcell;
        
    }
    else if (tableView == receiptIDTable){
        if ([hlcell.contentView subviews]){
            for (UIView *subview in [hlcell.contentView subviews]) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil) {
            hlcell =  [[[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID] autorelease];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:20];
            }
        }
        
        hlcell.textLabel.text = [receiptIDS objectAtIndex:indexPath.row];
        hlcell.textLabel.textColor = [UIColor blackColor];
        
        return hlcell;
    }
    else if (tableView == supplierTable) {
        
        
        if ([hlcell.contentView subviews]){
            for (UIView *subview in [hlcell.contentView subviews]) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil) {
            hlcell =  [[[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID] autorelease];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:20];
            }
        }
        // NSDictionary *JSON = [rawMaterials objectAtIndex:indexPath.row];
        hlcell.textLabel.text = [supplierList objectAtIndex:indexPath.row];
        hlcell.textLabel.textColor = [UIColor blackColor];
        
        return hlcell;
    }
    else{
        
        
        if ([hlcell.contentView subviews]){
            for (UIView *subview in [hlcell.contentView subviews]) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil) {
            hlcell =  [[[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID] autorelease];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:20];
            }
        }
        // NSDictionary *JSON = [rawMaterials objectAtIndex:indexPath.row];
        hlcell.textLabel.text = [skuArrayList objectAtIndex:indexPath.row];
        hlcell.textLabel.textColor = [UIColor blackColor];
        
        return hlcell;
    }
    
}

- (void) delRow:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        [rawMaterialDetails removeObjectAtIndex:[sender tag]];
        
        requestQuantity = 0;
        requestMaterialCost = 0.0f;
        
        for (int i = 0; i < [rawMaterialDetails count]; i++) {
            NSArray *material = [rawMaterialDetails objectAtIndex:i];
            requestQuantity = requestQuantity + [[material objectAtIndex:7] intValue];
            requestMaterialCost = requestMaterialCost + ([[material objectAtIndex:2] floatValue] * [[material objectAtIndex:7] intValue]);
        }
        
        totalQuantity.text = [NSString stringWithFormat:@"%d",requestQuantity];
        totalCost.text = [NSString stringWithFormat:@"%.2f",requestMaterialCost];
        [cartTable reloadData];
    }
    @catch (NSException *exception) {
        
        
    }
    
    
}


-(void)changeQuantity:(UIButton *)sender{
    
    AudioServicesPlaySystemSound (soundFileObject);
    
    cartTable.userInteractionEnabled = FALSE;
    supplierID.userInteractionEnabled = FALSE;
    supplierName.userInteractionEnabled = FALSE;
    location.userInteractionEnabled = FALSE;
    deliveredBy.userInteractionEnabled = FALSE;
    inspectedBy.userInteractionEnabled = FALSE;
    poReference.userInteractionEnabled = FALSE;
    shipmentNote.userInteractionEnabled = FALSE;
    submitBtn.userInteractionEnabled = FALSE;
    cancelButton.userInteractionEnabled = FALSE;
    mainSegmentedControl.userInteractionEnabled = FALSE;
    
    NSArray *temp = [rawMaterialDetails objectAtIndex:sender.tag];
    
    rejectQtyChangeDisplayView = [[UIView alloc]init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        rejectQtyChangeDisplayView.frame = CGRectMake(300.0, 200.0, 375, 250.0);
    }
    else{
        rejectQtyChangeDisplayView.frame = CGRectMake(75, 68, 175, 200);
    }
    rejectQtyChangeDisplayView.layer.borderWidth = 1.0;
    rejectQtyChangeDisplayView.layer.cornerRadius = 10.0;
    rejectQtyChangeDisplayView.layer.masksToBounds = YES;
    rejectQtyChangeDisplayView.layer.borderColor = [UIColor blackColor].CGColor;
    rejectQtyChangeDisplayView.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [self.view addSubview:rejectQtyChangeDisplayView];
    
    UIImageView *img  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.PNG"]];
    
    // a label on top of the view ..
    UILabel *topbar = [[UILabel alloc] init];
    topbar.backgroundColor = [UIColor grayColor];
    topbar.text = @"    Enter Quantity";
    topbar.backgroundColor = [UIColor clearColor];
    [topbar setTextAlignment:NSTextAlignmentCenter];
    topbar.font = [UIFont boldSystemFontOfSize:17];
    topbar.textColor = [UIColor whiteColor];
    topbar.textAlignment = NSTextAlignmentLeft;
    
    UILabel *unitPrice = [[UILabel alloc] init];
    unitPrice.text = @"Unit Price       :";
    unitPrice.font = [UIFont boldSystemFontOfSize:14];
    unitPrice.backgroundColor = [UIColor clearColor];
    unitPrice.textColor = [UIColor blackColor];
    
    UILabel *unitPriceData = [[UILabel alloc] init];
    unitPriceData.text = [NSString stringWithFormat:@"%@",[temp objectAtIndex:3]];
    unitPriceData.font = [UIFont boldSystemFontOfSize:14];
    unitPriceData.backgroundColor = [UIColor clearColor];
    unitPriceData.textColor = [UIColor blackColor];
    
    
    qtyField = [[UITextField alloc] init];
    qtyField.borderStyle = UITextBorderStyleRoundedRect;
    qtyField.textColor = [UIColor blackColor];
    qtyField.placeholder = @"Enter Qty";
    //NumberKeyBoard hidden....
    UIToolbar* numberToolbar1 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar1.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar1.items = [NSArray arrayWithObjects:
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                            nil];
    [numberToolbar1 sizeToFit];
    qtyField.keyboardType = UIKeyboardTypeNumberPad;
    //    qtyField.inputAccessoryView = numberToolbar1;
    qtyField.font = [UIFont systemFontOfSize:17.0];
    qtyField.backgroundColor = [UIColor whiteColor];
    qtyField.autocorrectionType = UITextAutocorrectionTypeNo;
    //qtyFeild.keyboardType = UIKeyboardTypeDefault;
    qtyField.clearButtonMode = UITextFieldViewModeWhileEditing;
    qtyField.returnKeyType = UIReturnKeyDone;
    qtyField.delegate = self;
    [qtyField becomeFirstResponder];
    
    /** ok Button for qtyChangeDisplyView....*/
    okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //[okButton setImage:[UIImage imageNamed:@"OK.png"] forState:UIControlStateNormal];
    [okButton addTarget:self
                 action:@selector(qtyOkButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [okButton setTitle:@"OK" forState:UIControlStateNormal];
    okButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
    okButton.backgroundColor = [UIColor grayColor];
    
    /** CancelButton for qtyChangeDisplyView....*/
    qtyCancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //[qtyCancelButton setImage:[UIImage imageNamed:@"Cancel.png"] forState:UIControlStateNormal];
    [qtyCancelButton addTarget:self
                        action:@selector(qtyCancelButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [qtyCancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
    qtyCancelButton.backgroundColor = [UIColor grayColor];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        
        img.frame = CGRectMake(0, 0, 375, 50);
        topbar.frame = CGRectMake(80, 5, 375, 40);
        topbar.font = [UIFont boldSystemFontOfSize:25];
        
        
        unitPrice.frame = CGRectMake(40,50,200,40);
        unitPrice.font = [UIFont boldSystemFontOfSize:25];
        
        
        unitPriceData.frame = CGRectMake(240,50,2500,40);
        unitPriceData.font = [UIFont boldSystemFontOfSize:25];
        
        
        qtyField.frame = CGRectMake(110, 100.0, 150, 50);
        qtyField.font = [UIFont systemFontOfSize:25.0];
        
        
        okButton.frame = CGRectMake(60, 180.0, 80, 50);
        okButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        
        //            qtyCancelButton.frame = CGRectMake(250, 220, 80, 50);
        //            qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        okButton.frame = CGRectMake(20, 180.0, 165, 45);
        okButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        okButton.layer.cornerRadius = 20.0f;
        
        qtyCancelButton.frame = CGRectMake(190, 180.0, 165, 45);
        qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        qtyCancelButton.layer.cornerRadius = 20.0f;
        
        
    }
    else{
        
        img.frame = CGRectMake(0, 0, 175, 32);
        topbar.frame = CGRectMake(0, 0, 175, 30);
        topbar.font = [UIFont boldSystemFontOfSize:17];
        
        unitPrice.frame = CGRectMake(10,70,100,30);
        unitPrice.font = [UIFont boldSystemFontOfSize:14];
        
        unitPriceData.frame = CGRectMake(115,70,60,30);
        unitPriceData.font = [UIFont boldSystemFontOfSize:14];
        
        qtyField.frame = CGRectMake(36, 107, 100, 30);
        qtyField.font = [UIFont systemFontOfSize:17.0];
        
        okButton.frame = CGRectMake(10, 150, 75, 30);
        okButton.layer.cornerRadius = 14.0f;
        okButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
        qtyCancelButton.frame = CGRectMake(90, 150, 75, 30);
        qtyCancelButton.layer.cornerRadius = 14.0f;
        qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
    }
    
    [rejectQtyChangeDisplayView addSubview:img];
    [rejectQtyChangeDisplayView addSubview:topbar];
    [rejectQtyChangeDisplayView addSubview:unitPrice];
    [rejectQtyChangeDisplayView addSubview:unitPriceData];
    [rejectQtyChangeDisplayView addSubview:qtyField];
    [rejectQtyChangeDisplayView addSubview:okButton];
    [rejectQtyChangeDisplayView addSubview:qtyCancelButton];
    
    requestRejectMaterialTagId = sender.tag;
    
    [rejectQtyChangeDisplayView release];
    [topbar release];
    [unitPrice release];
    [unitPriceData release];
    [qtyField release];
    
}

- (IBAction)qtyOkButtonPressed:(id)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    [qtyField resignFirstResponder];
    cartTable.userInteractionEnabled = TRUE;
    supplierID.userInteractionEnabled = TRUE;
    supplierName.userInteractionEnabled = TRUE;
    location.userInteractionEnabled = TRUE;
    deliveredBy.userInteractionEnabled = TRUE;
    inspectedBy.userInteractionEnabled = TRUE;
    poReference.userInteractionEnabled = TRUE;
    shipmentNote.userInteractionEnabled = TRUE;
    submitBtn.userInteractionEnabled = TRUE;
    cancelButton.userInteractionEnabled = TRUE;
    mainSegmentedControl.userInteractionEnabled = TRUE;
    
    NSString *value = [qtyField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // PhoNumber validation...
    NSString *decimalRegex = @"[0-9]+([.]([0-9]+)?)?"; // @"[0-9]+[.][0-9]+";
    NSPredicate *decimalTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalRegex];
    BOOL isNumber = [decimalTest evaluateWithObject:[qtyField text]];
    int qty = [value intValue];
    
    NSArray *temp = [rawMaterialDetails objectAtIndex:requestRejectMaterialTagId];
    
    if([value length] == 0 || !isNumber){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Quantity in Number." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        qtyField.text = NO;
    }
    else if([qtyField.text intValue]==0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Valid Quantity." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        qtyField.text = nil;
    }
    else{
        
        //int received = qty - [[temp objectAtIndex:5] intValue];
        @try {
            
            NSArray *finalArray = [NSArray arrayWithObjects:[temp objectAtIndex:0],[temp objectAtIndex:1],[temp objectAtIndex:2],[temp objectAtIndex:3],[NSString stringWithFormat:@"%d",qty],[NSString stringWithFormat:@"%.2f",(qty * [[temp objectAtIndex:3] floatValue])],[temp objectAtIndex:6],[temp objectAtIndex:7],[temp objectAtIndex:8],[temp objectAtIndex:9], nil];
            
            [rawMaterialDetails replaceObjectAtIndex:requestRejectMaterialTagId withObject:finalArray];
            
            [cartTable reloadData];
            
            rejectQtyChangeDisplayView.hidden = YES;
            cartTable.userInteractionEnabled = TRUE;
            
            requestQuantity = 0;
            requestMaterialCost = 0.0f;
            
            for (int i = 0; i < [rawMaterialDetails count]; i++) {
                NSArray *material = [rawMaterialDetails objectAtIndex:i];
                requestQuantity = requestQuantity + [[material objectAtIndex:4] intValue];
                requestMaterialCost = requestMaterialCost + ([[material objectAtIndex:3] floatValue] * [[material objectAtIndex:4] intValue]);
            }
            
            totalQuantity.text = [NSString stringWithFormat:@"%d",requestQuantity];
            totalCost.text = [NSString stringWithFormat:@"%.2f",requestMaterialCost];
        }
        @catch (NSException *exception) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Problem occured while processing" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        
    }
}

-(void) changeRejectQuantity:(UIButton *)sender{
    
    AudioServicesPlaySystemSound (soundFileObject);
    
    cartTable.userInteractionEnabled = FALSE;
    supplierID.userInteractionEnabled = FALSE;
    supplierName.userInteractionEnabled = FALSE;
    location.userInteractionEnabled = FALSE;
    deliveredBy.userInteractionEnabled = FALSE;
    inspectedBy.userInteractionEnabled = FALSE;
    poReference.userInteractionEnabled = FALSE;
    shipmentNote.userInteractionEnabled = FALSE;
    submitBtn.userInteractionEnabled = FALSE;
    cancelButton.userInteractionEnabled = FALSE;
    mainSegmentedControl.userInteractionEnabled = FALSE;
    
    NSArray *temp = [rawMaterialDetails objectAtIndex:sender.tag];
    
    qtyChangeDisplayView = [[UIView alloc]init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        qtyChangeDisplayView.frame = CGRectMake(200, 300, 375, 300);
    }
    else{
        qtyChangeDisplayView.frame = CGRectMake(75, 68, 175, 200);
    }
    qtyChangeDisplayView.layer.borderWidth = 1.0;
    qtyChangeDisplayView.layer.cornerRadius = 10.0;
    qtyChangeDisplayView.layer.masksToBounds = YES;
    qtyChangeDisplayView.layer.borderColor = [UIColor blackColor].CGColor;
    qtyChangeDisplayView.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [self.view addSubview:qtyChangeDisplayView];
    
    UIImageView *img  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.PNG"]];
    
    // a label on top of the view ..
    UILabel *topbar = [[UILabel alloc] init];
    topbar.backgroundColor = [UIColor grayColor];
    topbar.text = @"    Enter Quantity";
    topbar.backgroundColor = [UIColor clearColor];
    [topbar setTextAlignment:NSTextAlignmentCenter];
    topbar.font = [UIFont boldSystemFontOfSize:17];
    topbar.textColor = [UIColor whiteColor];
    topbar.textAlignment = NSTextAlignmentLeft;
    
    
    UILabel *availQty = [[UILabel alloc] init];
    availQty.text = @"Available Qty :";
    availQty.font = [UIFont boldSystemFontOfSize:14];
    availQty.backgroundColor = [UIColor clearColor];
    availQty.textColor = [UIColor blackColor];
    [qtyChangeDisplayView addSubview:availQty];
    
    UILabel *unitPrice = [[UILabel alloc] init];
    unitPrice.text = @"Unit Price       :";
    unitPrice.font = [UIFont boldSystemFontOfSize:14];
    unitPrice.backgroundColor = [UIColor clearColor];
    unitPrice.textColor = [UIColor blackColor];
    
    
    UILabel *availQtyData = [[UILabel alloc] init];
    availQtyData.text = [NSString stringWithFormat:@"%@",[temp objectAtIndex:7]];
    availQtyData.font = [UIFont boldSystemFontOfSize:14];
    availQtyData.backgroundColor = [UIColor clearColor];
    availQtyData.textColor = [UIColor blackColor];
    [qtyChangeDisplayView addSubview:availQtyData];
    
    UILabel *unitPriceData = [[UILabel alloc] init];
    unitPriceData.text = [NSString stringWithFormat:@"%@",[temp objectAtIndex:2]];
    unitPriceData.font = [UIFont boldSystemFontOfSize:14];
    unitPriceData.backgroundColor = [UIColor clearColor];
    unitPriceData.textColor = [UIColor blackColor];
    
    
    rejectQtyField = [[UITextField alloc] init];
    rejectQtyField.borderStyle = UITextBorderStyleRoundedRect;
    rejectQtyField.textColor = [UIColor blackColor];
    rejectQtyField.placeholder = @"Enter Qty";
    //NumberKeyBoard hidden....
    UIToolbar* numberToolbar1 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar1.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar1.items = [NSArray arrayWithObjects:
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                            nil];
    [numberToolbar1 sizeToFit];
    rejectQtyField.keyboardType = UIKeyboardTypeNumberPad;
    //    rejectQtyField.inputAccessoryView = numberToolbar1;
    rejectQtyField.font = [UIFont systemFontOfSize:17.0];
    rejectQtyField.backgroundColor = [UIColor whiteColor];
    rejectQtyField.autocorrectionType = UITextAutocorrectionTypeNo;
    //qtyFeild.keyboardType = UIKeyboardTypeDefault;
    rejectQtyField.clearButtonMode = UITextFieldViewModeWhileEditing;
    rejectQtyField.returnKeyType = UIReturnKeyDone;
    rejectQtyField.delegate = self;
    [rejectQtyField becomeFirstResponder];
    
    /** ok Button for qtyChangeDisplyView....*/
    rejectOkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //[okButton setImage:[UIImage imageNamed:@"OK.png"] forState:UIControlStateNormal];
    [rejectOkButton addTarget:self
                       action:@selector(rejectQtyOkButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [rejectOkButton setTitle:@"OK" forState:UIControlStateNormal];
    rejectOkButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
    rejectOkButton.backgroundColor = [UIColor grayColor];
    
    /** CancelButton for qtyChangeDisplyView....*/
    rejectCancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //[qtyCancelButton setImage:[UIImage imageNamed:@"Cancel.png"] forState:UIControlStateNormal];
    [rejectCancelButton addTarget:self
                           action:@selector(rejectQtyCancelButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [rejectCancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    rejectCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
    rejectCancelButton.backgroundColor = [UIColor grayColor];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        
        img.frame = CGRectMake(0, 0, 375, 50);
        topbar.frame = CGRectMake(80, 5, 375, 40);
        topbar.font = [UIFont boldSystemFontOfSize:25];
        
        
        availQty.frame = CGRectMake(10,60,200,40);
        availQty.font = [UIFont boldSystemFontOfSize:25];
        
        
        unitPrice.frame = CGRectMake(10,110,200,40);
        unitPrice.font = [UIFont boldSystemFontOfSize:25];
        
        
        availQtyData.frame = CGRectMake(200,60,250,40);
        availQtyData.font = [UIFont boldSystemFontOfSize:25];
        
        
        unitPriceData.frame = CGRectMake(200,110,2500,40);
        unitPriceData.font = [UIFont boldSystemFontOfSize:25];
        
        
        rejectQtyField.frame = CGRectMake(110, 165, 150, 50);
        rejectQtyField.font = [UIFont systemFontOfSize:25.0];
        
        
        rejectOkButton.frame = CGRectMake(60, 220, 80, 50);
        rejectOkButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        
        //            qtyCancelButton.frame = CGRectMake(250, 220, 80, 50);
        //            qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        rejectOkButton.frame = CGRectMake(20, 235, 165, 45);
        rejectOkButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        rejectOkButton.layer.cornerRadius = 20.0f;
        
        rejectCancelButton.frame = CGRectMake(190, 235, 165, 45);
        rejectCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        rejectCancelButton.layer.cornerRadius = 20.0f;
        
        
    }
    else{
        
        img.frame = CGRectMake(0, 0, 175, 32);
        topbar.frame = CGRectMake(0, 0, 175, 30);
        topbar.font = [UIFont boldSystemFontOfSize:17];
        
        availQty.frame = CGRectMake(10,40,100,30);
        availQty.font = [UIFont boldSystemFontOfSize:14];
        
        unitPrice.frame = CGRectMake(10,70,100,30);
        unitPrice.font = [UIFont boldSystemFontOfSize:14];
        
        availQtyData.frame = CGRectMake(115,40,60,30);
        availQtyData.font = [UIFont boldSystemFontOfSize:14];
        
        unitPriceData.frame = CGRectMake(115,70,60,30);
        unitPriceData.font = [UIFont boldSystemFontOfSize:14];
        
        rejectQtyField.frame = CGRectMake(36, 107, 100, 30);
        rejectQtyField.font = [UIFont systemFontOfSize:17.0];
        
        rejectOkButton.frame = CGRectMake(10, 150, 75, 30);
        rejectOkButton.layer.cornerRadius = 14.0f;
        rejectOkButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
        rejectCancelButton.frame = CGRectMake(90, 150, 75, 30);
        rejectCancelButton.layer.cornerRadius = 14.0f;
        rejectCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
    }
    
    [qtyChangeDisplayView addSubview:img];
    [qtyChangeDisplayView addSubview:topbar];
    [qtyChangeDisplayView addSubview:availQty];
    [qtyChangeDisplayView addSubview:unitPrice];
    [qtyChangeDisplayView addSubview:availQtyData];
    [qtyChangeDisplayView addSubview:unitPriceData];
    [qtyChangeDisplayView addSubview:rejectQtyField];
    [qtyChangeDisplayView addSubview:rejectOkButton];
    [qtyChangeDisplayView addSubview:rejectCancelButton];
    
    requestRejectMaterialTagId = sender.tag;
    
    [qtyChangeDisplayView release];
    [topbar release];
    [availQty release];
    [unitPrice release];
    [availQtyData release];
    [unitPriceData release];
    
}

- (IBAction)qtyCancelButtonPressed:(id)sender {
    
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    rejectQtyChangeDisplayView.hidden = YES;
    cartTable.userInteractionEnabled = TRUE;
    supplierID.userInteractionEnabled = TRUE;
    supplierName.userInteractionEnabled = TRUE;
    location.userInteractionEnabled = TRUE;
    deliveredBy.userInteractionEnabled = TRUE;
    inspectedBy.userInteractionEnabled = TRUE;
    poReference.userInteractionEnabled = TRUE;
    shipmentNote.userInteractionEnabled = TRUE;
    submitBtn.userInteractionEnabled = TRUE;
    cancelButton.userInteractionEnabled = TRUE;
    mainSegmentedControl.userInteractionEnabled = TRUE;
    //[qtyCancelButton release];
}

-(IBAction)rejectQtyCancelButtonPressed:(id)sender{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    qtyChangeDisplayView.hidden = YES;
    cartTable.userInteractionEnabled = TRUE;
    supplierID.userInteractionEnabled = TRUE;
    supplierName.userInteractionEnabled = TRUE;
    location.userInteractionEnabled = TRUE;
    deliveredBy.userInteractionEnabled = TRUE;
    inspectedBy.userInteractionEnabled = TRUE;
    poReference.userInteractionEnabled = TRUE;
    shipmentNote.userInteractionEnabled = TRUE;
    submitBtn.userInteractionEnabled = TRUE;
    cancelButton.userInteractionEnabled = TRUE;
    mainSegmentedControl.userInteractionEnabled = TRUE;
    //[rejectCancelButton release];
}

- (IBAction)rejectQtyOkButtonPressed:(id)sender {
    
    AudioServicesPlaySystemSound (soundFileObject);
    [rejectQtyField resignFirstResponder];
    cartTable.userInteractionEnabled = TRUE;
    supplierID.userInteractionEnabled = TRUE;
    supplierName.userInteractionEnabled = TRUE;
    location.userInteractionEnabled = TRUE;
    deliveredBy.userInteractionEnabled = TRUE;
    inspectedBy.userInteractionEnabled = TRUE;
    poReference.userInteractionEnabled = TRUE;
    shipmentNote.userInteractionEnabled = TRUE;
    submitBtn.userInteractionEnabled = TRUE;
    cancelButton.userInteractionEnabled = TRUE;
    mainSegmentedControl.userInteractionEnabled = TRUE;
    
    NSString *value = [rejectQtyField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // PhoNumber validation...
    NSString *decimalRegex = @"[0-9]+([.]([0-9]+)?)?"; // @"[0-9]+[.][0-9]+";
    NSPredicate *decimalTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalRegex];
    BOOL isNumber = [decimalTest evaluateWithObject:[rejectQtyField text]];
    int qty = [value intValue];
    
    NSArray *temp = [rawMaterialDetails objectAtIndex:requestRejectMaterialTagId];
    
    if (qty > [[temp objectAtIndex:3] intValue]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Quantity Should be Less than or Equal to  Available Quantity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        rejectQtyField.text = nil;
    }
    else if([value length] == 0 || !isNumber){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Quantity in Number." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        rejectQtyField.text = NO;
    }
    else if([rejectQtyField.text intValue]==0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Valid Quantity." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        rejectQtyField.text = nil;
    }
    else{
        @try {
            
            int received = [[temp objectAtIndex:3] intValue] - qty;
            
            NSArray *finalArray = [NSArray arrayWithObjects:[temp objectAtIndex:0],[temp objectAtIndex:1],[temp objectAtIndex:2],[temp objectAtIndex:3],[temp objectAtIndex:4],[temp objectAtIndex:5],[temp objectAtIndex:6],[NSString stringWithFormat:@"%d",received],[NSString stringWithFormat:@"%d",qty], nil];
            
            [rawMaterialDetails replaceObjectAtIndex:requestRejectMaterialTagId withObject:finalArray];
            
            [cartTable reloadData];
            
            qtyChangeDisplayView.hidden = YES;
            cartTable.userInteractionEnabled = TRUE;
            
            requestQuantity = 0;
            requestMaterialCost = 0.0f;
            
            for (int i = 0; i < [rawMaterialDetails count]; i++) {
                NSArray *material = [rawMaterialDetails objectAtIndex:i];
                requestQuantity = requestQuantity + [[material objectAtIndex:7] intValue];
                requestMaterialCost = requestMaterialCost + ([[material objectAtIndex:2] floatValue] * [[material objectAtIndex:7] intValue]);
            }
            
            totalQuantity.text = [NSString stringWithFormat:@"%d",requestQuantity];
            totalCost.text = [NSString stringWithFormat:@"%.2f",requestMaterialCost];
        }
        @catch (NSException *exception) {
            
            
        }
        
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    UITableViewCell* theCell = [tableView cellForRowAtIndexPath:indexPath];
    //theCell.contentView.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:232.0/255.0 blue:124.0/255.0 alpha:1.0];
    theCell.contentView.backgroundColor=[UIColor clearColor];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == skListTable) {
        searchItem.text = @"";
        [searchItem resignFirstResponder];
        skListTable.hidden = YES;
        [HUD setHidden:NO];
        
        HUD.labelText = @"Loading Please Wait..";
        NSDictionary *JSON = [rawMaterials objectAtIndex:indexPath.row];
        NSString *rawMaterial = [NSString stringWithFormat:@"%@",[JSON objectForKey:@"skuID"]];
        
        [self callRawMaterialDetails:rawMaterial];
    }
    else if (tableView == shipModeTable) {
        [catPopOver dismissPopoverAnimated:YES];
        shipmentNote.text = [shipmodeList objectAtIndex:indexPath.row];
        shipModeTable.hidden = YES;
    }
    else if (tableView == priceTable) {
        
        NSDictionary *JSON = [priceDic objectAtIndex:indexPath.row];
        transparentView.hidden = YES;
//        if ([[JSON objectForKey:@"quantity"] floatValue] > 0) {
            @try {
                BOOL status = TRUE;
                
                NSArray *temp = [NSArray arrayWithObjects:[JSON objectForKey:@"skuId"],[JSON objectForKey:@"pluCode"],[JSON objectForKey:@"description"],[JSON valueForKey:@"salePrice"],@"1",[JSON valueForKey:@"salePrice"],[JSON valueForKey:@"color"],[JSON valueForKey:@"model"],@"NA",[JSON valueForKey:@"quantity"], nil];
                
                for (int c = 0; c < [rawMaterialDetails count]; c++) {
                    NSArray *material = [rawMaterialDetails objectAtIndex:c];
                    if ([[material objectAtIndex:0] isEqualToString:[NSString stringWithFormat:@"%@",[JSON objectForKey:@"skuId"]]] && [[material objectAtIndex:1] isEqualToString:[NSString stringWithFormat:@"%@",[JSON objectForKey:@"pluCode"]]]) {
                        NSArray *temp = [NSArray arrayWithObjects:[material objectAtIndex:0],[material objectAtIndex:1],[material objectAtIndex:2],[NSString stringWithFormat:@"%.2f",[[material objectAtIndex:3] floatValue]],[NSString stringWithFormat:@"%d",[[material objectAtIndex:4] intValue] + 1],[NSString stringWithFormat:@"%.2f",(([[material objectAtIndex:4] intValue] + 1) * [[material objectAtIndex:3] floatValue])],[material objectAtIndex:6],[material objectAtIndex:7],[material objectAtIndex:8],[material objectAtIndex:9],nil];
                        [rawMaterialDetails replaceObjectAtIndex:c withObject:temp];
                        status = FALSE;
                    }
                }
                if (status) {
                    [rawMaterialDetails addObject:temp];
                }
                
                scrollView.hidden = NO;
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    cartTable.frame = CGRectMake(cartTable.frame.origin.x, cartTable.frame.origin.y, cartTable.frame.size.width, cartTable.frame.size.height + 60);
                }
                else {
                    cartTable.frame = CGRectMake(cartTable.frame.origin.x, cartTable.frame.origin.y, cartTable.frame.size.width, cartTable.frame.size.height + 30);
                }
                [cartTable reloadData];
                
                requestQuantity = 0;
                requestMaterialCost = 0.0f;
                
                for (int i = 0; i < [rawMaterialDetails count]; i++) {
                    NSArray *material = [rawMaterialDetails objectAtIndex:i];
                    requestQuantity = requestQuantity + [[material objectAtIndex:4] intValue];
                    requestMaterialCost = requestMaterialCost + ([[material objectAtIndex:3] floatValue] * [[material objectAtIndex:4] intValue]);
                }
                
                totalQuantity.text = [NSString stringWithFormat:@"%d",requestQuantity];
                totalCost.text = [NSString stringWithFormat:@"%.2f",requestMaterialCost];
            }
            @catch(NSException* exception){
                
            }
//        }
    }
    else if (tableView == normalstockTable) {
        NSString *receiptID = [procurementReceipts objectAtIndex:indexPath.row];
        self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
        self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
        
        mainSegmentedControl.selectedSegmentIndex = 0;
        //        viewReceiptView.hidden = YES;
        
        ViewStockRequest *viewReceipt = [[ViewStockRequest alloc] initWithReceiptID:receiptID];
        [self.navigationController pushViewController:viewReceipt animated:YES];
    }
    else if (tableView == receiptIDTable){
        NSString *receiptID = [receiptIDS objectAtIndex:indexPath.row];
        self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
        self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
        receiptIDTable.hidden = YES;
        mainSegmentedControl.selectedSegmentIndex = 0;
        ViewStockRequest *viewReceipt = [[ViewStockRequest alloc] initWithReceiptID:receiptID];
        [self.navigationController pushViewController:viewReceipt animated:YES];
    }
    else if (tableView == supplierTable) {
        [supplierTable setHidden:YES];
        supplierName.text = [supplierList objectAtIndex:indexPath.row];
        supplierID.text = [supplierCode objectAtIndex:indexPath.row];
        
        
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == normalstockTable) {
        NSInteger lastSectionIndex = [tableView numberOfSections] - 1;
        NSInteger lastRowIndex = [tableView numberOfRowsInSection:lastSectionIndex] - 1;
        if ((indexPath.section == lastSectionIndex) && (indexPath.row == lastRowIndex)) {
            // This is the last cell
            if (!requestScrollValueStatus) {
                requestStartPoint = requestStartPoint + [procurementReceipts count];
                [self getAllReceiptIDS:requestStartPoint];
                [normalstockTable reloadData];
            }
            else{
                dataStatus = [[[UILabel alloc] init] autorelease];
                dataStatus.text = @"No More Receipt ID To Load";
                dataStatus.layer.masksToBounds = YES;
                dataStatus.numberOfLines = 2;
                [dataStatus setTextAlignment:NSTextAlignmentLeft];
                dataStatus.font = [UIFont boldSystemFontOfSize:30.0];
                dataStatus.textColor = [UIColor redColor];
                
                dataStatus.frame = CGRectMake(200.0, 610.0, 400.0, 50.0);
                
                [self.view addSubview:dataStatus];
                
                [self fadein];
            }
        }
        
    }
}

-(void)closePriceView:(UIButton *)sender {
    transparentView.hidden = YES;
}


-(void) fadein
{
    dataStatus.alpha = 0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    //don't forget to add delegate.....
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationDuration:2];
    dataStatus.alpha = 1;
    
    //also call this before commit animations......
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView commitAnimations];
}



-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished    context:(void *)context {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2];
    dataStatus.alpha = 0;
    [UIView commitAnimations];
    
}


-(void)submitButtonPressed {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    NSString *supplierValue = [supplierID.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *supplierNameValue = [supplierName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *locationValue = [location.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *deliveredByValue = [deliveredBy.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *poreferenceValue = [poReference.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipmentValue = [shipmentNote.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *inspectedValue = [inspectedBy.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([rawMaterialDetails count] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please add items to cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else if ([supplierValue length] == 0 || [supplierNameValue length] == 0 || [locationValue length] == 0 || [deliveredByValue length] == 0 || [poreferenceValue length] == 0 || [shipmentValue length] == 0 || [inspectedValue length] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please provide all the details" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else{
        MBProgressHUD *HUD_ = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD_];
        // Regiser for HUD callbacks so we can remove it from the window at the right time
        HUD_.delegate = self;
        HUD_.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
        HUD_.mode = MBProgressHUDModeCustomView;
        // Show the HUD
        [HUD_ show:YES];
        [HUD_ setHidden:NO];
        [HUD_ setHidden:NO];
        HUD_.labelText = @"Creating Receipt..";
        
        
        
        NSMutableArray *temparr = [[NSMutableArray alloc]init];
        @try {
            for (int i = 0; i < [rawMaterialDetails count]; i++) {
                NSArray *itemArr = [rawMaterialDetails objectAtIndex:i];
                NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
                [temp setValue:[itemArr objectAtIndex:0] forKey:@"skuId"];
                [temp setValue:[itemArr objectAtIndex:1] forKey:@"pluCode"];
                [temp setValue:[itemArr objectAtIndex:2] forKey:@"itemDesc"];
                [temp setValue:[itemArr objectAtIndex:3] forKey:@"itemPrice"];
                [temp setValue:[itemArr objectAtIndex:4] forKey:@"quantity"];
                [temp setValue:[itemArr objectAtIndex:5] forKey:@"totalCost"];
                [temp setValue:[itemArr objectAtIndex:6] forKey:@"color"];
                [temp setValue:[itemArr objectAtIndex:7] forKey:@"model"];
                [temp setValue:[itemArr objectAtIndex:8] forKey:@"size"];
                [temparr addObject:temp];
            }
            
            
            NSArray *keys = [NSArray arrayWithObjects:@"stockRequestId", @"fromStoreCode",@"fromWareHouseId",@"toStoreCode",@"toWareHouseId",@"reason",@"requestDateStr",@"deliveryDateStr",@"requestApprovedBy",@"requestedUserName",@"shippingMode",@"shippingCost",@"totalStockRequestValue",@"remarks",@"stockRequestItems",@"status",@"requestHeader", nil];
            
            NSArray *objects1 = [NSArray arrayWithObjects:requestReceiptID, location.text,location.text,supplierID.text,supplierName.text,reasonTxt.text,date.text,poReference.text,deliveredBy.text,inspectedBy.text,shipmentNote.text, @"200.0",totalCost.text,@"",temparr,@"Submitted",[RequestHeader getRequestHeader], nil];
            
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects1 forKeys:keys];
            
            NSError * err;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
            NSString * createReceiptJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            StockRequestsSoapBinding *materialBinding = [[StockRequests StockRequestsSoapBinding] retain];
            
            StockRequests_updateStockRequest *aparams = [[StockRequests_updateStockRequest alloc] init];
            //        tns1_createNewStockProcurementReceipt *aparams = [[tns1_createNewStockProcurementReceipt alloc] init];
            //        aparams.procurement_details = createReceiptJsonString;
            
            aparams.stockRequestDetails = createReceiptJsonString;
            
            
            StockRequestsSoapBindingResponse *response = [materialBinding updateStockRequestUsingParameters:aparams];
            NSArray *responseBodyParts = response.bodyParts;
            
            for (id bodyPart in responseBodyParts) {
                if ([bodyPart isKindOfClass:[StockRequests_updateStockRequestResponse class]]) {
                    StockRequests_updateStockRequestResponse *body = (StockRequests_updateStockRequestResponse *)bodyPart;
                    printf("\nresponse=%s",[body.return_ UTF8String]);
                    
                    
                    NSError *e;
                    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                                         options: NSJSONReadingMutableContainers
                                                                           error: &e];
                    NSDictionary *json = [JSON objectForKey:@"responseHeader"];
                    if ([[json objectForKey:@"responseCode"] isEqualToString:@"0"] && [[json objectForKey:@"responseMessage"] isEqualToString:@"Success"]) {
                        
                        supplierID.text = @"";
                        supplierName.text = @"";
                        //        location.text = @"";
                        deliveredBy.text = @"";
                        inspectedBy.text = @"";
                        poReference.text = @"";
                        shipmentNote.text = @"";
                        
                        @try {
                            
                            [rawMaterials removeAllObjects];
                            [rawMaterialDetails removeAllObjects];
                            [cartTable reloadData];
                        }
                        @catch (NSException *exception) {
                            
                            
                        }
                        totalCost.text = @"0.0";
                        totalQuantity.text = @"0";
                        
                        SystemSoundID	soundFileObject1;
                        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
                        self.soundFileURLRef = (CFURLRef) [tapSound retain];
                        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                        AudioServicesPlaySystemSound (soundFileObject1);
                        
                        NSString *receiptID = [JSON objectForKey:@"requestId"];
                        requestReceipt = [receiptID copy];
                        UIAlertView *successAlertView  = [[UIAlertView alloc] init];
                        [successAlertView setDelegate:self];
                        [successAlertView setTitle:@"Stock Request Updated Successfully"];
                        [successAlertView setMessage:[NSString stringWithFormat:@"%@%@",@"Receipt ID : ",receiptID]];
                        [successAlertView addButtonWithTitle:@"OK"];
                        
                        [successAlertView show];
                        
                        [HUD_ setHidden:YES];
                        [HUD_ release];
                    }
                    else{
                        [HUD_ setHidden:YES];
                        
                        SystemSoundID	soundFileObject1;
                        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
                        self.soundFileURLRef = (CFURLRef) [tapSound retain];
                        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                        AudioServicesPlaySystemSound (soundFileObject1);
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed To create Receipt" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                        [alert release];
                    }
                    
                }
                else{
                    [HUD_ setHidden:YES];
                    
                    SystemSoundID	soundFileObject1;
                    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
                    self.soundFileURLRef = (CFURLRef) [tapSound retain];
                    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                    AudioServicesPlaySystemSound (soundFileObject1);
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed To create Receipt" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                }
            }
        }
        @catch (NSException *exception) {
            [HUD_ setHidden:YES];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed To create Receipt" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }
        
        
        
    }
}

-(void)cancelButtonPressed {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    //    NSString *supplierValue = [supplierID.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //    NSString *supplierNameValue = [supplierName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //    NSString *locationValue = [location.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //    NSString *deliveredByValue = [deliveredBy.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //    NSString *poreferenceValue = [poReference.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //    NSString *shipmentValue = [shipmentNote.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //    NSString *inspectedValue = [inspectedBy.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([rawMaterialDetails count] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please add items to cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    //    else if ([supplierValue length] == 0 || [supplierNameValue length] == 0 || [locationValue length] == 0 || [deliveredByValue length] == 0 || [poreferenceValue length] == 0 || [shipmentValue length] == 0 || [inspectedValue length] == 0){
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please provide all the details" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //        [alert show];
    //        [alert release];
    //    }
    else{
        
        MBProgressHUD *HUD_ = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD_];
        // Regiser for HUD callbacks so we can remove it from the window at the right time
        HUD_.delegate = self;
        HUD_.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
        HUD_.mode = MBProgressHUDModeCustomView;
        // Show the HUD
        [HUD_ show:YES];
        [HUD_ setHidden:NO];
        [HUD_ setHidden:NO];
        HUD_.labelText = @"Saving Receipt..";
        
        NSMutableArray *temparr = [[NSMutableArray alloc]init];
        @try {
            for (int i = 0; i < [rawMaterialDetails count]; i++) {
                NSArray *itemArr = [rawMaterialDetails objectAtIndex:i];
                NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
                [temp setValue:[itemArr objectAtIndex:0] forKey:@"skuId"];
                [temp setValue:[itemArr objectAtIndex:1] forKey:@"pluCode"];
                [temp setValue:[itemArr objectAtIndex:2] forKey:@"itemDesc"];
                [temp setValue:[itemArr objectAtIndex:3] forKey:@"itemPrice"];
                [temp setValue:[itemArr objectAtIndex:4] forKey:@"quantity"];
                [temp setValue:[itemArr objectAtIndex:5] forKey:@"totalCost"];
                [temp setValue:[itemArr objectAtIndex:6] forKey:@"color"];
                [temp setValue:[itemArr objectAtIndex:7] forKey:@"model"];
                [temp setValue:[itemArr objectAtIndex:8] forKey:@"size"];
                [temparr addObject:temp];
            }
            
            NSArray *keys = [NSArray arrayWithObjects:@"stockRequestId", @"fromStoreCode",@"fromWareHouseId",@"toStoreCode",@"toWareHouseId",@"reason",@"requestDateStr",@"deliveryDateStr",@"requestApprovedBy",@"requestedUserName",@"shippingMode",@"shippingCost",@"totalStockRequestValue",@"remarks",@"stockRequestItems",@"status",@"requestHeader", nil];
            
            NSArray *objects1 = [NSArray arrayWithObjects:requestReceiptID, location.text,location.text,supplierID.text,supplierName.text,reasonTxt.text,date.text,poReference.text,deliveredBy.text,inspectedBy.text,shipmentNote.text, @"200.0",totalCost.text,@"",temparr,@"Pending",[RequestHeader getRequestHeader], nil];
            
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects1 forKeys:keys];
            
            NSError * err;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
            NSString * createReceiptJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            StockRequestsSoapBinding *materialBinding = [[StockRequests StockRequestsSoapBinding] retain];
            
            StockRequests_updateStockRequest *aparams = [[StockRequests_updateStockRequest alloc] init];
            //        tns1_createNewStockProcurementReceipt *aparams = [[tns1_createNewStockProcurementReceipt alloc] init];
            //
            //        aparams.procurement_details = createReceiptJsonString;
            
            aparams.stockRequestDetails = createReceiptJsonString;
            
            
            
            StockRequestsSoapBindingResponse *response = [materialBinding updateStockRequestUsingParameters:aparams];
            NSArray *responseBodyParts = response.bodyParts;
            
            for (id bodyPart in responseBodyParts) {
                if ([bodyPart isKindOfClass:[StockRequests_updateStockRequestResponse class]]) {
                    StockRequests_updateStockRequestResponse *body = (StockRequests_updateStockRequestResponse *)bodyPart;
                    printf("\nresponse=%s",[body.return_ UTF8String]);
                    
                    NSError *e;
                    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                                         options: NSJSONReadingMutableContainers
                                                                           error: &e];
                    NSDictionary *json = [JSON objectForKey:@"responseHeader"];
                    if ([[json objectForKey:@"responseCode"] isEqualToString:@"0"] && [[json objectForKey:@"responseMessage"] isEqualToString:@"Success"]) {
                        
                        [HUD_ setHidden:YES];
                        [HUD_ release];
                        
                        supplierID.text = @"";
                        supplierName.text = @"";
                        //                        location.text = @"";
                        deliveredBy.text = @"";
                        inspectedBy.text = @"";
                        poReference.text = @"";
                        shipmentNote.text = @"";
                        
                        @try {
                            
                            [rawMaterials removeAllObjects];
                            [rawMaterialDetails removeAllObjects];
                            [cartTable reloadData];
                        }
                        @catch (NSException *exception) {
                            
                            
                        }
                        totalCost.text = @"0.0";
                        totalQuantity.text = @"0";
                        
                        SystemSoundID	soundFileObject1;
                        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
                        self.soundFileURLRef = (CFURLRef) [tapSound retain];
                        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                        AudioServicesPlaySystemSound (soundFileObject1);
                        
                        NSString *receiptID = [JSON objectForKey:@"requestId"];
                        requestReceipt = [receiptID copy];
                        UIAlertView *successAlertView  = [[UIAlertView alloc] init];
                        [successAlertView setDelegate:self];
                        [successAlertView setTitle:@"Stock Request Saved Successfully"];
                        [successAlertView setMessage:[NSString stringWithFormat:@"%@%@",@"Receipt ID : ",receiptID]];
                        [successAlertView addButtonWithTitle:@"OK"];
                        
                        [successAlertView show];
                        
                        
                    }
                    else{
                        [HUD_ setHidden:YES];
                        SystemSoundID	soundFileObject1;
                        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
                        self.soundFileURLRef = (CFURLRef) [tapSound retain];
                        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                        AudioServicesPlaySystemSound (soundFileObject1);
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed To save Receipt" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                        [alert release];
                    }
                }
                else{
                    [HUD_ setHidden:YES];
                    SystemSoundID	soundFileObject1;
                    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
                    self.soundFileURLRef = (CFURLRef) [tapSound retain];
                    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                    AudioServicesPlaySystemSound (soundFileObject1);
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed To save Receipt" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                }
            }
        }
        @catch (NSException *exception) {
            
            [HUD_ setHidden:YES];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed To save Receipt" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }
        
        
        
    }
    
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    HUD.labelText = @"Loading Please Wait..";
//    [HUD setHidden:NO];
//
//    requestStartPoint = requestStartPoint + ([procurementReceipts count] + 1);
//
//    [self getAllReceiptIDS:requestStartPoint];
//
//    [normalstockTable reloadData];
//}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView1
//{
//    float bottomEdge = scrollView1.contentOffset.y + scrollView1.frame.size.height;
//    if (bottomEdge >= scrollView1.contentSize.height)
//    {
//        // we are at the end
//
//        HUD.labelText = @"Loading Please Wait..";
//        [HUD show:YES];
//        [HUD setHidden:NO];
//        requestStartPoint = requestStartPoint + [procurementReceipts count];
//
//        [self getAllReceiptIDS:requestStartPoint];
//
//        [normalstockTable reloadData];
//
//    }
//}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView_{
    
    //    if (!scrollValueStatus) {
    //        float bottomEdge = scrollView_.contentOffset.y + scrollView_.frame.size.height;
    //        if (bottomEdge >= scrollView_.contentSize.height)
    //        {
    //            // we are at the end
    //
    //            MBProgressHUD *HUD_ = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    //            [self.navigationController.view addSubview:HUD_];
    //            // Regiser for HUD callbacks so we can remove it from the window at the right time
    //            HUD_.delegate = self;
    //            // Show the HUD
    //            [HUD_ show:YES];
    //            [HUD_ setHidden:NO];
    //            HUD_.labelText = @"Loading Please Wait";
    //
    //            requestStartPoint = requestStartPoint + [procurementReceipts count];
    //
    //            dispatch_queue_t myQueue = dispatch_queue_create("My Queue",NULL);
    //            dispatch_async(myQueue, ^{
    //                // Perform long running process
    //                [self getAllReceiptIDS:requestStartPoint];
    //                dispatch_async(dispatch_get_main_queue(), ^{
    //                    // Update the UI
    //                    [normalstockTable reloadData];
    //                    [HUD_ hide:YES afterDelay:1.0];
    //                    [HUD_ release];
    //                });
    //            });
    //
    //        }
    //
    //    }
    
}


-(void)backAction {
    if ([rawMaterialDetails count]>0) {
        
        warning = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"You will lose data you entered.\n Do you want to exit?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
        [warning show];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    if ([alertView.title isEqualToString:@"Stock Request Updated Successfully"]) {
        if (buttonIndex == 0) {
            OmniHomePage *home = [[OmniHomePage alloc]init];
            [self.navigationController pushViewController:home animated:YES];
        }
        else{
            alertView.hidden = YES;
        }
    }
    else if ([alertView.title isEqualToString:@"Stock Request Saved Successfully"]){
        if (buttonIndex == 0) {
            OmniHomePage *home = [[OmniHomePage alloc]init];
            [self.navigationController pushViewController:home animated:YES];
        }
        else{
            alertView.hidden = YES;
        }
    }
    else if (alertView == warning) {
        
        if (buttonIndex == 0) {
            
            OmniHomePage *home = [[OmniHomePage alloc]init];
            [self.navigationController pushViewController:home animated:YES];
            
        }
        else {
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        }
        
    }
}

-(void)getSuppliers:(NSString *)supplierNameStr {
    // BOOL status = FALSE;
    
    [HUD setHidden:NO];
    
    SupplierServiceSoapBinding *skuService = [[SupplierServiceSvc SupplierServiceSoapBinding] retain];
    
    SupplierServiceSvc_getSuppliers *getSkuid = [[SupplierServiceSvc_getSuppliers alloc] init];
    NSArray *keys = [NSArray arrayWithObjects:@"requestHeader",@"pageNo",@"searchCriteria",nil];
    NSArray *objects = [NSArray arrayWithObjects:[RequestHeader getRequestHeader],@"-1",supplierNameStr, nil];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
    NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    getSkuid.supplierDetails = salesReportJsonString;
    //
    if ([supplierList count]!=0) {
        [supplierList removeAllObjects];
        [supplierCode removeAllObjects];
        
    }
    //
    @try {
        
        SupplierServiceSoapBindingResponse *response = [skuService getSuppliersUsingParameters:getSkuid];
        NSArray *responseBodyParts = response.bodyParts;
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[SupplierServiceSvc_getSuppliersResponse class]]) {
                SupplierServiceSvc_getSuppliersResponse *body = (SupplierServiceSvc_getSuppliersResponse *)bodyPart;
                printf("\nresponse=%s",[body.return_ UTF8String]);
                NSError *e;
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                                     options: NSJSONReadingMutableContainers
                                                                       error: &e];
                [HUD setHidden:YES];
                
                NSArray *list = [JSON objectForKey:@"suppliers"];
                for (int i=0; i<[list count]; i++) {
                    
                    NSDictionary *dic = [list objectAtIndex:i];
                    [supplierCode addObject:[dic objectForKey:@"supplierCode"]];
                    [supplierList addObject:[dic objectForKey:@"firmName"]];
                    
                    
                }
            }
        }
        
    }
    @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No data found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //        [alert show];
        
    }
    
    
    
    //[skListTable reloadData];
    
}

-(void)getPurchaseOrders{
    
    [HUD setHidden:NO];
    
    purchaseOrdersSoapBinding *service = [[purchaseOrdersSvc purchaseOrdersSoapBinding] retain];
    purchaseOrdersSvc_getPurchaseOrders *aparams = [[purchaseOrdersSvc_getPurchaseOrders alloc] init];

    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"requestHeader", nil];
    
    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",requestStartPoint],[RequestHeader getRequestHeader], nil];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
    
    NSError * err_;
    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
    //        aparams.userID = user_name;
    //        aparams.orderDateTime = dateString;
    //        aparams.deliveryDate = dueDate.text;
    //        aparams.deliveryTime = time.text;
    //        aparams.ordererEmail = email.text;
    //        aparams.ordererMobile = phNo.text;
    //        aparams.ordererAddress = address.text;
    //        aparams.orderTotalPrice = totAmountData.text;
    //        aparams.shipmentCharge = shipCharges.text;
    //        aparams.shipmentMode = shipoMode.text;
    //        aparams.paymentMode = paymentMode.text;
    //        aparams.orderItems = str;
    aparams.orderDetails = normalStockString;
    @try {
        
        purchaseOrdersSoapBindingResponse *response = [service getPurchaseOrdersUsingParameters:(purchaseOrdersSvc_getPurchaseOrders *)aparams];
        
        NSArray *responseBodyParts =  response.bodyParts;
        
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[purchaseOrdersSvc_getPurchaseOrdersResponse class]]) {
                purchaseOrdersSvc_getPurchaseOrdersResponse *body = (purchaseOrdersSvc_getPurchaseOrdersResponse *)bodyPart;
                //printf("\nresponse=%s",body.return_);
                if (body.return_ == NULL) {
                    
                    [HUD setHidden:YES];
                    //nextButton.backgroundColor = [UIColor lightGrayColor];
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Orderes  Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
                else{
                    
                    // [self getPreviousOrdersHandler:body.return_];
                }
                
            }
        }
    }
    @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Orderes  Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
}
-(void)homeButonClicked {
    
    OmniHomePage *home = [[OmniHomePage alloc]init];
    [self.navigationController pushViewController:home animated:YES];
    
}
- (void)goToHome {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
