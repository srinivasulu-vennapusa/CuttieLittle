//
//  EditWareHouseProcurementReceipt.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/17/15.
//
//

#import "EditWareHouseProcurementReceipt.h"
#import "WHStockReceiptService.h"
#import "RawMaterialServiceSvc.h"
#import "PopOverViewController.h"
#import "OmniHomePage.h"
#import "WareHouseReceiptProcurement.h"
#import "ViewWareHouseProcurementReceipt.h"
#import "Global.h"
#import "SkuServiceSvc.h"

@interface EditWareHouseProcurementReceipt ()

@end

@implementation EditWareHouseProcurementReceipt

@synthesize soundFileObject,soundFileURLRef;

NSString *wareEditProcurementReceiptID = @"";
int wareEditReceiptProcurementQuantity = 0;
float wareEditReceiptProcurementMaterialCost = 0.0f;
int wareEditReceiptProcurementRejectMaterialTagId = 0;
NSString *wareEditProcurementReceipt = @"";
NSDictionary *wareJSON_ = NULL;

-(id) initWithReceiptID:(NSString *)receiptID{
    
    wareEditProcurementReceiptID = [receiptID copy];
    
    return self;
}
-(void) callRawMaterialDetails:(NSString *)rawMaterial {
    BOOL status = TRUE;
    
    SkuServiceSoapBinding *skuService = [[SkuServiceSvc SkuServiceSoapBinding] retain];
    
    SkuServiceSvc_getSkuDetails *getSkuid = [[SkuServiceSvc_getSkuDetails alloc] init];
    
    NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str = [time componentsSeparatedByString:@" "];
    NSString *date1 = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date1, nil];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    
    NSArray *keys = [NSArray arrayWithObjects:@"skuId",@"requestHeader", nil];
    NSArray *objects = [NSArray arrayWithObjects:rawMaterial,dictionary_, nil];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
    NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    getSkuid.skuID = salesReportJsonString;
    SkuServiceSoapBindingResponse *response = [skuService getSkuDetailsUsingParameters:(SkuServiceSvc_getSkuDetails *)getSkuid];
    NSArray *responseBodyParts = response.bodyParts;
    for (id bodyPart in responseBodyParts) {
        if ([bodyPart isKindOfClass:[SkuServiceSvc_getSkuDetailsResponse class]]) {
            SkuServiceSvc_getSkuDetailsResponse *body = (SkuServiceSvc_getSkuDetailsResponse *)bodyPart;
            printf("\nresponse=%s",[body.return_ UTF8String]);
            NSError *e;
            wareJSON_ = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                    options: NSJSONReadingMutableContainers
                                                      error: &e];
            //  NSString *itemString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",[JSON objectForKey:@"productName"],@"#",[JSON objectForKey:@"description"],@"#",[JSON objectForKey:@"quantity"],@"#",[JSON objectForKey:@"price"]];
        }
    }
    
    NSArray *temp = [NSArray arrayWithObjects:[wareJSON_ objectForKey:@"description"],[wareJSON_ objectForKey:@"productName"],[wareJSON_ objectForKey:@"price"],@"1",@"NA",@"1",@"0",[wareJSON_ objectForKey:@"price"],@"1", nil];
    
    for (int c = 0; c < [itemDetails count]; c++) {
        NSArray *material = [itemDetails objectAtIndex:c];
        if ([[material objectAtIndex:0] isEqualToString:[NSString stringWithFormat:@"%@",[wareJSON_ objectForKey:@"productName"]]]) {
            
            //            NSArray *temp = [NSArray arrayWithObjects:[material objectAtIndex:0],[material objectAtIndex:1],[material objectAtIndex:2],[NSString stringWithFormat:@"%d",[[material objectAtIndex:3] intValue] + 1],[temp objectAtIndex:4],[NSString stringWithFormat:@"%d",[[material objectAtIndex:5] intValue]],[temp objectAtIndex:6],[NSString stringWithFormat:@"%.2f",(([[material objectAtIndex:5] intValue] + 1) * [[material objectAtIndex:2] floatValue])],[NSString stringWithFormat:@"%d",[[material objectAtIndex:8] intValue] + 1], nil];
            
            NSArray *temp = [NSArray arrayWithObjects:[material objectAtIndex:0],[material objectAtIndex:1],[NSString stringWithFormat:@"%0.2f",[[material objectAtIndex:2] floatValue]],[NSString stringWithFormat:@"%d",[[material objectAtIndex:3] intValue] + 1],[material objectAtIndex:4],[NSString stringWithFormat:@"%d",[[material objectAtIndex:5] intValue]+1],[NSString stringWithFormat:@"%d",[[material objectAtIndex:6] intValue]],[NSString stringWithFormat:@"%.2f",(([[material objectAtIndex:3] intValue] + 1) * [[material objectAtIndex:2] floatValue])],[NSString stringWithFormat:@"%d",[[material objectAtIndex:8] intValue]+1], nil];
            
            [itemDetails replaceObjectAtIndex:c withObject:temp];
            status = FALSE;
        }
    }
    if (status) {
        [itemDetails addObject:temp];
    }
    
    scrollView.hidden = NO;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        cartTable.frame = CGRectMake(cartTable.frame.origin.x, cartTable.frame.origin.y, cartTable.frame.size.width, cartTable.frame.size.height + 60);
    }
    else {
        cartTable.frame = CGRectMake(cartTable.frame.origin.x, cartTable.frame.origin.y, cartTable.frame.size.width, cartTable.frame.size.height + 30);
    }
    [cartTable reloadData];
    
    wareEditReceiptProcurementQuantity = 0;
    wareEditReceiptProcurementMaterialCost = 0.0f;
    
    for (int i = 0; i < [itemDetails count]; i++) {
        
        NSArray *material = [itemDetails objectAtIndex:i];
        
        wareEditReceiptProcurementQuantity = wareEditReceiptProcurementQuantity + [[material objectAtIndex:5] intValue];
        
        wareEditReceiptProcurementMaterialCost = wareEditReceiptProcurementMaterialCost + ([[material objectAtIndex:2] floatValue]* [[material objectAtIndex:5] intValue]);
    }
    
    totalQuantity.text = [NSString stringWithFormat:@"%d",wareEditReceiptProcurementQuantity];
    totalCost.text = [NSString stringWithFormat:@"%.2f",wareEditReceiptProcurementMaterialCost];
}


-(void)callReceiptDetails {
    
    BOOL status = FALSE;
    WHStockReceiptServiceSoapBinding *materialBinding = [[WHStockReceiptService WHStockReceiptServiceSoapBinding] retain];
    WHStockReceiptService_getStockProcurementReceipt *aparams= [[WHStockReceiptService_getStockProcurementReceipt alloc] init];
    //    tns1_getStockProcurementReceipt *aparams = [[tns1_getStockProcurementReceipt alloc] init];
    NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str = [time componentsSeparatedByString:@" "];
    NSString *date_ = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    
    NSArray *headerKeys_ = [NSArray arrayWithObjects:@"receiptId",@"requestHeader", nil];
    
    NSArray *headerObjects_ = [NSArray arrayWithObjects:wareEditProcurementReceiptID,dictionary_, nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects_ forKeys:headerKeys_];
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
    NSString * createBillingJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    aparams.receiptId = createBillingJsonString;
    
    WHStockReceiptServiceSoapBindingResponse *response = [materialBinding getStockProcurementReceiptUsingParameters:(WHStockReceiptService_getStockProcurementReceipt *)aparams];
    NSArray *responseBodyParts = response.bodyParts;
    NSDictionary *JSON;
    for (id bodyPart in responseBodyParts) {
        if ([bodyPart isKindOfClass:[WHStockReceiptService_getStockProcurementReceiptResponse class]]) {
            WHStockReceiptService_getStockProcurementReceiptResponse *body = (WHStockReceiptService_getStockProcurementReceiptResponse *)bodyPart;
            printf("\nresponse=%s",[body.return_ UTF8String]);
            NSError *e;
            status = TRUE;
            JSON = [[NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                    options: NSJSONReadingMutableContainers
                                                      error: &e] copy];
        }
    }
    if (status) {
        
        dateValue.text = [JSON objectForKey:@"date"];
        receiptRefNoValue.text = [JSON objectForKey:@"goods_receipt_ref_num"];
        supplierIDValue.text = [JSON objectForKey:@"supplier_id"];
        supplierNameValue.text = [JSON objectForKey:@"supplier_name"];
        locationValue.text = [JSON objectForKey:@"location"];
        shipmentValue.text = [JSON objectForKey:@"shipment_note"];
        deliveredBYValue.text = [JSON objectForKey:@"delivered_by"];
        inspectedBYValue.text = [JSON objectForKey:@"inspected_by"];
        poRefValue.text = [JSON objectForKey:@"po_reference"];
        totalQuantity.text = [NSString stringWithFormat:@"%@",[JSON objectForKey:@"receipt_total_qty"]];
        totalCost.text = [NSString stringWithFormat:@"%.2f",[[JSON objectForKey:@"grand_total"] floatValue]];
        
        NSArray *items = [JSON objectForKey:@"items"];
        for (int i = 0; i < [items count]; i++) {
            
            NSDictionary *itemDic = [items objectAtIndex:i];
            NSMutableArray *itemArr = [[NSMutableArray alloc] init];
            [itemArr addObject:[itemDic valueForKey:@"item_description"]];
            [itemArr addObject:[itemDic valueForKey:@"item_code"]];
            [itemArr addObject:[itemDic valueForKey:@"price"]];
            [itemArr addObject:[itemDic valueForKey:@"pack"]];
            [itemArr addObject:[itemDic valueForKey:@"make"]];
            [itemArr addObject:[itemDic valueForKey:@"received"]];
            [itemArr addObject:[itemDic valueForKey:@"reject"]];
            [itemArr addObject:[itemDic valueForKey:@"cost"]];
            [itemArr addObject:[itemDic valueForKey:@"supplied"]];
            
            [itemDetails addObject:itemArr];
            
            
        }
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            cartTable.frame = CGRectMake(cartTable.frame.origin.x, cartTable.frame.origin.y, cartTable.frame.size.width, cartTable.frame.size.height + 60);
        }
        else {
            cartTable.frame = CGRectMake(cartTable.frame.origin.x, cartTable.frame.origin.y, cartTable.frame.size.width, cartTable.frame.size.height + 30);
        }
        [cartTable reloadData];
        
    }
    
    [HUD setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (CFURLRef) [tapSound retain];
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    self.navigationController.navigationBarHidden = NO;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 600.0, 45.0)];
    titleView.backgroundColor = [UIColor clearColor];
    
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo_200.png"]];
    logoView.backgroundColor = [UIColor clearColor];
    logoView.frame = CGRectMake(150.0, 0.0, 45.0, 45.0);
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(200.0, -13.0, 300.0, 70.0)];
    titleLbl.text = @"Edit Procurement Receipt";
    titleLbl.textColor = [UIColor blackColor];
    titleLbl.font = [UIFont boldSystemFontOfSize:25.0f];
    titleLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
    [titleView addSubview:logoView];
    [titleView addSubview:titleLbl];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
    }
    else{
        logoView.frame = CGRectMake(10.0, 7.0, 30.0, 30.0);
        titleLbl.frame = CGRectMake(45.0, -12.0, 200.0, 70.0);
        titleLbl.backgroundColor = [UIColor clearColor];
        titleLbl.textColor = [UIColor whiteColor];
        titleLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:12.0f];
    }
    
    self.navigationItem.titleView = titleView;

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
    
    popButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [popButton setImage:[UIImage imageNamed:@"emails-letters.png"] forState:UIControlStateNormal];
    popButton.frame = CGRectMake(0, 0, 40.0, 40.0);
    [popButton addTarget:self action:@selector(popUpView) forControlEvents:UIControlEventTouchUpInside];
    
    sendButton =[[UIBarButtonItem alloc]init];
    sendButton.customView = popButton;
    sendButton.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem=sendButton;
    
    createReceiptView = [[UIScrollView alloc] init];
    createReceiptView.backgroundColor = [UIColor clearColor];
    createReceiptView.bounces = FALSE;
    createReceiptView.hidden = NO;
    
    UILabel *receiptRefNo = [[[UILabel alloc] init] autorelease];
    receiptRefNo.text = @"Receipt Ref NO. :";
    receiptRefNo.layer.masksToBounds = YES;
    receiptRefNo.numberOfLines = 2;
    [receiptRefNo setTextAlignment:NSTextAlignmentLeft];
    receiptRefNo.font = [UIFont boldSystemFontOfSize:14.0];
    receiptRefNo.textColor = [UIColor whiteColor];
    
    receiptRefNoValue = [[[UITextField alloc] init] autorelease];
    receiptRefNoValue.layer.masksToBounds = YES;
    receiptRefNoValue.text = @"*******";
    [receiptRefNoValue setTextAlignment:NSTextAlignmentLeft];
    receiptRefNoValue.font = [UIFont boldSystemFontOfSize:14.0];
    receiptRefNoValue.textColor = [UIColor blackColor];
    receiptRefNoValue.borderStyle = UITextBorderStyleRoundedRect;
    receiptRefNoValue.layer.borderColor = [UIColor whiteColor].CGColor;
    
    UILabel *supplierID = [[[UILabel alloc] init] autorelease];
    supplierID.text = @"Supplier ID :";
    supplierID.layer.masksToBounds = YES;
    supplierID.numberOfLines = 2;
    [supplierID setTextAlignment:NSTextAlignmentLeft];
    supplierID.font = [UIFont boldSystemFontOfSize:14.0];
    supplierID.textColor = [UIColor whiteColor];
    
    supplierIDValue = [[[UITextField alloc] init] autorelease];
    supplierIDValue.layer.masksToBounds = YES;
    supplierIDValue.text = @"*******";
    [supplierIDValue setTextAlignment:NSTextAlignmentLeft];
    supplierIDValue.font = [UIFont boldSystemFontOfSize:14.0];
    supplierIDValue.textColor = [UIColor blackColor];
    supplierIDValue.borderStyle = UITextBorderStyleRoundedRect;
    supplierIDValue.layer.borderColor = [UIColor whiteColor].CGColor;
    
    UILabel *supplierName = [[[UILabel alloc] init] autorelease];
    supplierName.text = @"Supplier Name :";
    supplierName.layer.masksToBounds = YES;
    supplierName.numberOfLines = 2;
    [supplierName setTextAlignment:NSTextAlignmentLeft];
    supplierName.font = [UIFont boldSystemFontOfSize:14.0];
    supplierName.textColor = [UIColor whiteColor];
    
    supplierNameValue = [[[UITextField alloc] init] autorelease];
    supplierNameValue.layer.masksToBounds = YES;
    supplierNameValue.text = @"**********";
    [supplierNameValue setTextAlignment:NSTextAlignmentLeft];
    supplierNameValue.font = [UIFont boldSystemFontOfSize:14.0];
    supplierNameValue.textColor = [UIColor blackColor];
    supplierNameValue.borderStyle = UITextBorderStyleRoundedRect;
    supplierNameValue.layer.borderColor = [UIColor whiteColor].CGColor;
    
    UILabel *location = [[[UILabel alloc] init] autorelease];
    location.text = @"Location :";
    location.layer.masksToBounds = YES;
    location.numberOfLines = 2;
    [location setTextAlignment:NSTextAlignmentLeft];
    location.font = [UIFont boldSystemFontOfSize:14.0];
    location.textColor = [UIColor whiteColor];
    
    locationValue = [[[UITextField alloc] init] autorelease];
    locationValue.layer.masksToBounds = YES;
    locationValue.text = @"**********";
    [locationValue setTextAlignment:NSTextAlignmentLeft];
    locationValue.font = [UIFont boldSystemFontOfSize:14.0];
    locationValue.textColor = [UIColor blackColor];
    locationValue.borderStyle = UITextBorderStyleRoundedRect;
    locationValue.layer.borderColor = [UIColor whiteColor].CGColor;
    
    UILabel *deliveredBY = [[[UILabel alloc] init] autorelease];
    deliveredBY.text = @"Delivered By :";
    deliveredBY.layer.masksToBounds = YES;
    deliveredBY.numberOfLines = 2;
    [deliveredBY setTextAlignment:NSTextAlignmentLeft];
    deliveredBY.font = [UIFont boldSystemFontOfSize:14.0];
    deliveredBY.textColor = [UIColor whiteColor];
    
    deliveredBYValue = [[[UITextField alloc] init] autorelease];
    deliveredBYValue.layer.masksToBounds = YES;
    deliveredBYValue.text = @"**********";
    [deliveredBYValue setTextAlignment:NSTextAlignmentLeft];
    deliveredBYValue.font = [UIFont boldSystemFontOfSize:14.0];
    deliveredBYValue.textColor = [UIColor blackColor];
    deliveredBYValue.borderStyle = UITextBorderStyleRoundedRect;
    deliveredBYValue.layer.borderColor = [UIColor whiteColor].CGColor;
    
    UILabel *inspectedBY = [[[UILabel alloc] init] autorelease];
    inspectedBY.text = @"Inspected By :";
    inspectedBY.layer.masksToBounds = YES;
    inspectedBY.numberOfLines = 2;
    [inspectedBY setTextAlignment:NSTextAlignmentLeft];
    inspectedBY.font = [UIFont boldSystemFontOfSize:14.0];
    inspectedBY.textColor = [UIColor whiteColor];
    
    inspectedBYValue = [[[UITextField alloc] init] autorelease];
    inspectedBYValue.layer.masksToBounds = YES;
    inspectedBYValue.text = @"*********";
    [inspectedBYValue setTextAlignment:NSTextAlignmentLeft];
    inspectedBYValue.font = [UIFont boldSystemFontOfSize:14.0];
    inspectedBYValue.textColor = [UIColor blackColor];
    inspectedBYValue.borderStyle = UITextBorderStyleRoundedRect;
    inspectedBYValue.layer.borderColor = [UIColor whiteColor].CGColor;
    
    UILabel *date = [[[UILabel alloc] init] autorelease];
    date.text = @"Date :";
    date.layer.masksToBounds = YES;
    date.numberOfLines = 2;
    [date setTextAlignment:NSTextAlignmentLeft];
    date.font = [UIFont boldSystemFontOfSize:14.0];
    date.textColor = [UIColor whiteColor];
    
    dateValue = [[[UITextField alloc] init] autorelease];
    dateValue.layer.masksToBounds = YES;
    dateValue.text = @"*********";
    [dateValue setTextAlignment:NSTextAlignmentLeft];
    dateValue.font = [UIFont boldSystemFontOfSize:14.0];
    dateValue.textColor = [UIColor blackColor];
    dateValue.borderStyle = UITextBorderStyleRoundedRect;
    dateValue.layer.borderColor = [UIColor whiteColor].CGColor;
    
    UILabel *poRef = [[[UILabel alloc] init] autorelease];
    poRef.text = @"PO Reference :";
    poRef.layer.masksToBounds = YES;
    poRef.numberOfLines = 2;
    [poRef setTextAlignment:NSTextAlignmentLeft];
    poRef.font = [UIFont boldSystemFontOfSize:14.0];
    poRef.textColor = [UIColor whiteColor];
    
    poRefValue = [[[UITextField alloc] init] autorelease];
    poRefValue.layer.masksToBounds = YES;
    poRefValue.text = @"**********";
    [poRefValue setTextAlignment:NSTextAlignmentLeft];
    poRefValue.font = [UIFont boldSystemFontOfSize:14.0];
    poRefValue.textColor = [UIColor blackColor];
    poRefValue.borderStyle = UITextBorderStyleRoundedRect;
    poRefValue.layer.borderColor = [UIColor whiteColor].CGColor;
    
    UILabel *shipment = [[[UILabel alloc] init] autorelease];
    shipment.text = @"Shipment Note :";
    shipment.layer.masksToBounds = YES;
    shipment.numberOfLines = 2;
    [shipment setTextAlignment:NSTextAlignmentLeft];
    shipment.font = [UIFont boldSystemFontOfSize:14.0];
    shipment.textColor = [UIColor whiteColor];
    
    shipmentValue = [[[UITextField alloc] init] autorelease];
    shipmentValue.layer.masksToBounds = YES;
    shipmentValue.text = @"*********";
    [shipmentValue setTextAlignment:NSTextAlignmentLeft];
    shipmentValue.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentValue.textColor = [UIColor blackColor];
    shipmentValue.borderStyle = UITextBorderStyleRoundedRect;
    shipmentValue.layer.borderColor = [UIColor whiteColor].CGColor;
    
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
    label11.text = @"Item Desc";
    label11.layer.cornerRadius = 14;
    label11.layer.masksToBounds = YES;
    label11.numberOfLines = 2;
    [label11 setTextAlignment:NSTextAlignmentCenter];
    label11.font = [UIFont boldSystemFontOfSize:14.0];
    label11.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label11.textColor = [UIColor whiteColor];
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"Price";
    label3.layer.cornerRadius = 14;
    label3.layer.masksToBounds = YES;
    [label3 setTextAlignment:NSTextAlignmentCenter];
    label3.font = [UIFont boldSystemFontOfSize:14.0];
    label3.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label3.textColor = [UIColor whiteColor];
    
    UILabel *label4 = [[[UILabel alloc] init] autorelease];
    label4.text = @"Pack";
    label4.layer.cornerRadius = 14;
    label4.layer.masksToBounds = YES;
    [label4 setTextAlignment:NSTextAlignmentCenter];
    label4.font = [UIFont boldSystemFontOfSize:14.0];
    label4.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label4.textColor = [UIColor whiteColor];
    
    UILabel *label5 = [[[UILabel alloc] init] autorelease];
    label5.text = @"Cost";
    label5.layer.cornerRadius = 14;
    label5.layer.masksToBounds = YES;
    [label5 setTextAlignment:NSTextAlignmentCenter];
    label5.font = [UIFont boldSystemFontOfSize:14.0];
    label5.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label5.textColor = [UIColor whiteColor];
    
    UILabel *label12 = [[[UILabel alloc] init] autorelease];
    label12.text = @"Make";
    label12.layer.cornerRadius = 14;
    label12.layer.masksToBounds = YES;
    [label12 setTextAlignment:NSTextAlignmentCenter];
    label12.font = [UIFont boldSystemFontOfSize:14.0];
    label12.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label12.textColor = [UIColor whiteColor];
    
    UILabel *label8 = [[[UILabel alloc] init] autorelease];
    label8.text = @"Supplied";
    label8.layer.cornerRadius = 14;
    label8.layer.masksToBounds = YES;
    [label8 setTextAlignment:NSTextAlignmentCenter];
    label8.font = [UIFont boldSystemFontOfSize:14.0];
    label8.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label8.textColor = [UIColor whiteColor];
    
    UILabel *label9 = [[[UILabel alloc] init] autorelease];
    label9.text = @"Received";
    label9.layer.cornerRadius = 14;
    label9.layer.masksToBounds = YES;
    [label9 setTextAlignment:NSTextAlignmentCenter];
    label9.font = [UIFont boldSystemFontOfSize:14.0];
    label9.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label9.textColor = [UIColor whiteColor];
    
    UILabel *label10 = [[[UILabel alloc] init] autorelease];
    label10.text = @"Rejected";
    label10.layer.cornerRadius = 14;
    label10.layer.masksToBounds = YES;
    [label10 setTextAlignment:NSTextAlignmentCenter];
    label10.font = [UIFont boldSystemFontOfSize:14.0];
    label10.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label10.textColor = [UIColor whiteColor];
    
    /** UIScrollView Design */
    scrollView = [[UIScrollView alloc] init];
    scrollView.hidden = NO;
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
    [submitBtn setTitle:@"Update" forState:UIControlStateNormal];
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
    
    itemDetails = [[NSMutableArray alloc] init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        createReceiptView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        createReceiptView.contentSize = CGSizeMake(self.view.frame.size.width + 500, 900);
        
        receiptRefNo.font = [UIFont boldSystemFontOfSize:20];
        receiptRefNo.frame = CGRectMake(10, 0.0, 200.0, 55);
        receiptRefNoValue.font = [UIFont boldSystemFontOfSize:20];
        receiptRefNoValue.frame = CGRectMake(200.0, 10.0, 200.0, 40);
        supplierID.font = [UIFont boldSystemFontOfSize:20];
        supplierID.frame = CGRectMake(10, 60.0, 200.0, 55);
        supplierIDValue.font = [UIFont boldSystemFontOfSize:20];
        supplierIDValue.frame = CGRectMake(200.0, 70.0, 200.0, 40);
        supplierName.font = [UIFont boldSystemFontOfSize:20];
        supplierName.frame = CGRectMake(10, 120.0, 200.0, 55);
        supplierNameValue.font = [UIFont boldSystemFontOfSize:20];
        supplierNameValue.frame = CGRectMake(200.0, 130.0, 200.0, 40);
        location.font = [UIFont boldSystemFontOfSize:20];
        location.frame = CGRectMake(10, 180.0, 200, 55);
        locationValue.font = [UIFont boldSystemFontOfSize:20];
        locationValue.frame = CGRectMake(200.0, 190.0, 200, 40);
        deliveredBY.font = [UIFont boldSystemFontOfSize:20];
        deliveredBY.frame = CGRectMake(460.0, 0.0, 200, 55);
        deliveredBYValue.font = [UIFont boldSystemFontOfSize:20];
        deliveredBYValue.frame = CGRectMake(650.0, 10.0, 200, 40);
        inspectedBY.font = [UIFont boldSystemFontOfSize:20];
        inspectedBY.frame = CGRectMake(460.0, 60, 200, 55);
        inspectedBYValue.font = [UIFont boldSystemFontOfSize:20];
        inspectedBYValue.frame = CGRectMake(650.0, 70.0, 200.0, 40);
        date.font = [UIFont boldSystemFontOfSize:20];
        date.frame = CGRectMake(460.0, 120.0, 200.0, 55);
        dateValue.font = [UIFont boldSystemFontOfSize:20];
        dateValue.frame = CGRectMake(650.0, 130.0, 200.0, 40);
        poRef.font = [UIFont boldSystemFontOfSize:20];
        poRef.frame = CGRectMake(460.0, 180.0, 200.0, 55);
        poRefValue.font = [UIFont boldSystemFontOfSize:20];
        poRefValue.frame = CGRectMake(650.0, 190.0, 200.0, 40);
        shipment.font = [UIFont boldSystemFontOfSize:20];
        shipment.frame = CGRectMake(10, 240.0, 200.0, 55);
        shipmentValue.font = [UIFont boldSystemFontOfSize:20];
        shipmentValue.frame = CGRectMake(200.0, 250.0, 200.0, 40);
        
        searchItem.font = [UIFont boldSystemFontOfSize:30];
        searchItem.frame = CGRectMake(200.0, 300.0, 360.0, 50.0);
        
        skListTable.frame = CGRectMake(200, 350.0, 360,0);
        
        label2.font = [UIFont boldSystemFontOfSize:20];
        label2.frame = CGRectMake(10, 355.0, 90, 55);
        label11.font = [UIFont boldSystemFontOfSize:20];
        label11.frame = CGRectMake(103, 355.0, 90, 55);
        label3.font = [UIFont boldSystemFontOfSize:20];
        label3.frame = CGRectMake(195, 355.0, 90, 55);
        label4.font = [UIFont boldSystemFontOfSize:20];
        label4.frame = CGRectMake(288, 355.0, 90, 55);
        label5.font = [UIFont boldSystemFontOfSize:20];
        label5.frame = CGRectMake(381, 355.0, 110, 55);
        label12.font = [UIFont boldSystemFontOfSize:20];
        label12.frame = CGRectMake(494, 355.0, 110, 55);
        label8.font = [UIFont boldSystemFontOfSize:20];
        label8.frame = CGRectMake(607, 355.0, 110, 55);
        label9.font = [UIFont boldSystemFontOfSize:20];
        label9.frame = CGRectMake(720.0, 355.0, 110, 55);
        label10.font = [UIFont boldSystemFontOfSize:20];
        label10.frame = CGRectMake(833.0, 355.0, 110, 55);
        
        scrollView.frame = CGRectMake(10, 415.0, 980.0, 250.0);
        scrollView.contentSize = CGSizeMake(778, 1000);
        cartTable.frame = CGRectMake(0, 0, 980.0,250.0);
        
        label6.font = [UIFont boldSystemFontOfSize:20];
        label6.frame = CGRectMake(10.0, 670.0, 200, 55.0);
        
        label7.font = [UIFont boldSystemFontOfSize:20];
        label7.frame = CGRectMake(10.0, 730.0, 200, 55);
        
        totalQuantity.font = [UIFont boldSystemFontOfSize:20];
        totalQuantity.frame = CGRectMake(580.0, 670.0, 200, 55);
        
        totalCost.font = [UIFont boldSystemFontOfSize:20];
        totalCost.frame = CGRectMake(580.0, 730.0, 200, 55);
        
        submitBtn.frame = CGRectMake(55.0f, 800.0,300.0f, 55.0f);
        submitBtn.layer.cornerRadius = 25.0f;
        submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        cancelButton.frame = CGRectMake(425.0f, 800.0,300.0f, 55.0f);
        cancelButton.layer.cornerRadius = 25.0f;
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        [createReceiptView addSubview:label2];
        [createReceiptView addSubview:label3];
        [createReceiptView addSubview:label4];
        [createReceiptView addSubview:label5];
        [createReceiptView addSubview:label8];
        [createReceiptView addSubview:label9];
        [createReceiptView addSubview:label10];
        [createReceiptView addSubview:label11];
        [createReceiptView addSubview:label12];
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
        
        createReceiptView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        //createReceiptView.contentSize = CGSizeMake(self.view.frame.size.width + 500, 1000);
        createReceiptView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        supplierIDValue.font = [UIFont boldSystemFontOfSize:15];
        supplierIDValue.frame = CGRectMake(0.0, 0.0, 150, 35);
        
        supplierNameValue.font = [UIFont boldSystemFontOfSize:15];
        supplierNameValue.frame = CGRectMake(160.0, 0.0, 160, 35);
        
        locationValue.font = [UIFont boldSystemFontOfSize:15];
        locationValue.frame = CGRectMake(0.0, 40.0, 150, 35);
        
        //        selectLocation.frame = CGRectMake(130, 2, 30, 45);
        //
        //        locationTable.frame = CGRectMake(10.0, 30.0, 120, 0);
        //
        //        fromLocation.font = [UIFont boldSystemFontOfSize:15];
        //        fromLocation.frame = CGRectMake(160.0, 5.0, 160, 35);
        
        deliveredBYValue.font = [UIFont boldSystemFontOfSize:15];
        deliveredBYValue.frame = CGRectMake(160.0, 40.0, 150, 35);
        
        inspectedBYValue.font = [UIFont boldSystemFontOfSize:15];
        inspectedBYValue.frame = CGRectMake(0.0, 80.0, 150, 35);
        
        dateValue.font = [UIFont boldSystemFontOfSize:20];
        dateValue.frame = CGRectMake( 150.0, 80.0, 220, 35);
        
        //        inspectedBy.font = [UIFont boldSystemFontOfSize:30];
        //        inspectedBy.frame = CGRectMake(10.0, 130.0, 360, 50);
        
        //        date.font = [UIFont boldSystemFontOfSize:30];
        //        date.frame = CGRectMake(400.0, 130.0, 360, 50);
        
        poRefValue.font = [UIFont boldSystemFontOfSize:15];
        poRefValue.frame = CGRectMake(0.0, 120.0, 120, 35);
        
        shipmentValue.font = [UIFont boldSystemFontOfSize:15];
        shipmentValue.frame = CGRectMake(125.0, 120.0, 220, 35);
        
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
        
        
        submitBtn.frame = CGRectMake(5.0f, 340.0,150.0f, 35.0f);
        submitBtn.layer.cornerRadius = 17.0f;
        submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        cancelButton.frame = CGRectMake(160.0f, 340.0,150.0f, 35.0f);
        cancelButton.layer.cornerRadius = 17.0f;
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        
        // normalstockTable.frame = CGRectMake(0.0, 40.0, self.view.frame.size.width, 320.0);
        
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
    [createReceiptView addSubview:receiptRefNo];
    [createReceiptView addSubview:receiptRefNoValue];
    [createReceiptView addSubview:supplierID];
    [createReceiptView addSubview:supplierIDValue];
    [createReceiptView addSubview:supplierName];
    [createReceiptView addSubview:supplierNameValue];
    [createReceiptView addSubview:location];
    [createReceiptView addSubview:locationValue];
    [createReceiptView addSubview:deliveredBY];
    [createReceiptView addSubview:deliveredBYValue];
    [createReceiptView addSubview:inspectedBY];
    [createReceiptView addSubview:inspectedBYValue];
    [createReceiptView addSubview:date];
    [createReceiptView addSubview:dateValue];
    [createReceiptView addSubview:poRef];
    [createReceiptView addSubview:poRefValue];
    [createReceiptView addSubview:shipment];
    [createReceiptView addSubview:shipmentValue];
    [createReceiptView addSubview:searchItem];
    [createReceiptView addSubview:skListTable];
    
    [scrollView addSubview:cartTable];
    [createReceiptView addSubview:scrollView];
    [createReceiptView addSubview:submitBtn];
    [createReceiptView addSubview:cancelButton];
    [self.view addSubview:createReceiptView];
    
    [self callReceiptDetails];

}

-(void) callRawMaterials:(NSString *)searchString {
    
    BOOL status = FALSE;
    
    rawMaterials = [[NSMutableArray alloc] init];
    
    SkuServiceSoapBinding *skuService = [[SkuServiceSvc SkuServiceSoapBinding] retain];
    
    SkuServiceSvc_getSkuID *getSkuid = [[SkuServiceSvc_getSkuID alloc] init];
    NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str = [time componentsSeparatedByString:@" "];
    NSString *date1 = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date1, nil];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    NSArray *keys = [NSArray arrayWithObjects:@"requestHeader", nil];
    NSArray *objects = [NSArray arrayWithObjects:dictionary_, nil];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
    NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    getSkuid.requestHeader = salesReportJsonString;
    
    @try {
        
        
        SkuServiceSoapBindingResponse *response = [skuService getSkuIDUsingParameters:(SkuServiceSvc_getSkuID *)getSkuid];
        NSArray *responseBodyParts = response.bodyParts;
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[SkuServiceSvc_getSkuIDResponse class]]) {
                
                SkuServiceSvc_getSkuIDResponse *body = (SkuServiceSvc_getSkuIDResponse *)bodyPart;
                status =TRUE;
                
                printf("\nresponse=%s",[body.return_ UTF8String]);
                NSError *e;
                wareJSON_ = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                        options: NSJSONReadingMutableContainers
                                                          error: &e];
            }
        }
    }
    @catch (NSException *exception) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No data found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
    
    if (status) {
        NSArray *temp = [wareJSON_ objectForKey:@"skuIds"];
        
        skuArrayList = [[NSMutableArray alloc] initWithArray:temp];
    }
    //[skListTable reloadData];
    
}


- (void)textFieldDidChange:(UITextField *)textField {
    if (textField == searchItem) {
        if ([textField.text length] >= 3) {
            
            [self callRawMaterials:textField.text];
            
            for (NSDictionary *product in skuArrayList)
            {
                NSComparisonResult result = [[product objectForKey:@"skuId"] compare:textField.text options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [textField.text length])];
                
                if (result == NSOrderedSame)
                {
                    [rawMaterials addObject:product];
                }
            }
            if ([rawMaterials count] > 0) {
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    skListTable.frame = CGRectMake(200, 350.0, 360,240);
                }
                else {
                    //            if (version >= 8.0) {
                    //                skListTable.frame = CGRectMake(40, 100, 213,100);
                    //            }
                    //            else{
                    //                skListTable.frame = CGRectMake(40, 45, 213,100);
                    //            }
                }
                
                if ([rawMaterials count] > 5) {
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        skListTable.frame = CGRectMake(200, 350.0, 360,450);
                    }
                    else {
                        //                if (version >= 8.0) {
                        //                    skListTable.frame = CGRectMake(40, 100, 213,100);
                        //                }
                        //                else{
                        //                    skListTable.frame = CGRectMake(40, 45, 213,100);
                        //                }
                    }
                }
                [createReceiptView bringSubviewToFront:skListTable];
                [skListTable reloadData];
                skListTable.hidden = NO;
            }
            else {
                skListTable.hidden = YES;
            }
        }
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
            return 66.0;
        }
        else {
            return 45.0;
        }
    }
    else {
        if (tableView == cartTable) {
            return 33.0;
        }
        
        else {
            return 28.0;
        }
    }
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == cartTable) {
        return [itemDetails count];
    }
    else{
        return [rawMaterials count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    tableView.separatorColor = [UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0];
    
    //static NSString *hlCellID = @"hlCellID";
    static NSString *hlCellID = @"hlCellID";
    
    UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
    static NSString *MyIdentifier = @"MyIdentifier";
    MyIdentifier = @"TableView";
    if (tableView == cartTable){
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
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
        
        NSArray *temp = [itemDetails objectAtIndex:indexPath.row];
        
        UILabel *item_code = [[[UILabel alloc] init] autorelease];
        item_code.layer.borderWidth = 1.5;
        item_code.font = [UIFont systemFontOfSize:13.0];
        item_code.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        item_code.backgroundColor = [UIColor blackColor];
        item_code.textColor = [UIColor whiteColor];
        
        item_code.text = [NSString stringWithFormat:@"%@",[temp objectAtIndex:1]];
        item_code.textAlignment=NSTextAlignmentCenter;
        item_code.adjustsFontSizeToFitWidth = YES;
        //name.adjustsFontSizeToFitWidth = YES;
        
        UILabel *item_description = [[[UILabel alloc] init] autorelease];
        item_description.layer.borderWidth = 1.5;
        item_description.font = [UIFont systemFontOfSize:13.0];
        item_description.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        item_description.backgroundColor = [UIColor blackColor];
        item_description.textColor = [UIColor whiteColor];
        
        item_description.text = [NSString stringWithFormat:@"%@",[temp objectAtIndex:0]];
        item_description.textAlignment=NSTextAlignmentCenter;
        item_description.adjustsFontSizeToFitWidth = YES;
        
        UILabel *price = [[[UILabel alloc] init] autorelease];
        price.layer.borderWidth = 1.5;
        price.font = [UIFont systemFontOfSize:10.0];
        price.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        price.backgroundColor = [UIColor blackColor];
        price.text = [NSString stringWithFormat:@"%0.2f",[[temp objectAtIndex:2] floatValue]];
        // price.text = [temp objectAtIndex:2];
        price.textColor = [UIColor whiteColor];
        price.textAlignment=NSTextAlignmentCenter;
        //price.adjustsFontSizeToFitWidth = YES;
        
        
        UIButton *qtyButton = [[[UIButton alloc] init] autorelease];
        [qtyButton setTitle:[NSString stringWithFormat:@"%d",[[temp objectAtIndex:3] integerValue]] forState:UIControlStateNormal];
        qtyButton.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        qtyButton.layer.borderWidth = 1.5;
        [qtyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [qtyButton addTarget:self action:@selector(changeQuantity:) forControlEvents:UIControlEventTouchUpInside];
        qtyButton.layer.masksToBounds = YES;
        qtyButton.tag = indexPath.row;
        
        
        UILabel *cost = [[[UILabel alloc] init] autorelease];
        cost.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        cost.layer.borderWidth = 1.5;
        cost.font = [UIFont systemFontOfSize:13.0];
        cost.backgroundColor = [UIColor blackColor];
        cost.text = [NSString stringWithFormat:@"%.02f", [[temp objectAtIndex:7] floatValue]];
        cost.textColor = [UIColor whiteColor];
        cost.textAlignment=NSTextAlignmentCenter;
        //cost.adjustsFontSizeToFitWidth = YES;
        
        UILabel *make = [[[UILabel alloc] init] autorelease];
        make.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        make.layer.borderWidth = 1.5;
        make.font = [UIFont systemFontOfSize:13.0];
        make.backgroundColor = [UIColor blackColor];
        make.text = @"NA";
        make.textColor = [UIColor whiteColor];
        make.textAlignment=NSTextAlignmentCenter;
        //make.adjustsFontSizeToFitWidth = YES;
        
        UILabel *supplied = [[[UILabel alloc] init] autorelease];
        supplied.layer.borderWidth = 1.5;
        supplied.font = [UIFont systemFontOfSize:13.0];
        supplied.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        supplied.backgroundColor = [UIColor blackColor];
        supplied.textColor = [UIColor whiteColor];
        
        supplied.text = [NSString stringWithFormat:@"%d",[[temp objectAtIndex:8] intValue]];
        supplied.textAlignment=NSTextAlignmentCenter;
        //supplied.adjustsFontSizeToFitWidth = YES;
        
        UILabel *received = [[[UILabel alloc] init] autorelease];
        received.layer.borderWidth = 1.5;
        received.font = [UIFont systemFontOfSize:13.0];
        received.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        received.backgroundColor = [UIColor blackColor];
        received.textColor = [UIColor whiteColor];
        
        received.text = [NSString stringWithFormat:@"%d",[[temp objectAtIndex:5] intValue]];
        received.textAlignment=NSTextAlignmentCenter;
        //received.adjustsFontSizeToFitWidth = YES;
        
        UIButton *rejectQtyButton = [[[UIButton alloc] init] autorelease];
        [rejectQtyButton setTitle:[NSString stringWithFormat:@"%d",[[temp objectAtIndex:6] intValue]] forState:UIControlStateNormal];
        rejectQtyButton.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        rejectQtyButton.layer.borderWidth = 1.5;
        [rejectQtyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rejectQtyButton addTarget:self action:@selector(changeRejectQuantity:) forControlEvents:UIControlEventTouchUpInside];
        rejectQtyButton.layer.masksToBounds = YES;
        rejectQtyButton.tag = indexPath.row;
        
        //        rejectedQty = [[[UITextField alloc] init] autorelease];
        //        rejectedQty.textAlignment = NSTextAlignmentCenter;
        //        rejectedQty.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        //        rejectedQty.layer.borderWidth = 1.5;
        //        rejectedQty.font = [UIFont systemFontOfSize:13.0];
        //        rejectedQty.frame = CGRectMake(176, 0, 58, 34);
        //        rejectedQty.backgroundColor = [UIColor blackColor];
        //        rejectedQty.text = [temp objectAtIndex:5];
        //        rejectedQty.textColor = [UIColor whiteColor];
        //        [rejectedQty addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingDidBegin];
        //        rejectedQty.tag = indexPath.row;
        //        rejectedQty.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        //        rejectedQty.adjustsFontSizeToFitWidth = YES;
        //        rejectedQty.delegate = self;
        //        [rejectedQty resignFirstResponder];
        UIButton *delrowbtn = [[[UIButton alloc] init] autorelease];
        [delrowbtn setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
        [delrowbtn addTarget:self action:@selector(delRow:) forControlEvents:UIControlEventTouchUpInside];
        delrowbtn.tag = indexPath.row;
        delrowbtn.backgroundColor = [UIColor clearColor];
        
        [hlcell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            //skid.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:22];
            item_code.font = [UIFont fontWithName:@"Helvetica" size:22];
            item_code.frame = CGRectMake(0, 0, 90, 56);
            item_description.font = [UIFont fontWithName:@"Helvetica" size:22];
            item_description.frame = CGRectMake(93, 0, 90, 56);
            price.font = [UIFont fontWithName:@"Helvetica" size:25];
            price.frame = CGRectMake(185, 0, 90, 56);
            qtyButton.frame = CGRectMake(278, 0, 90, 56);
            cost.font = [UIFont fontWithName:@"Helvetica" size:25];
            cost.frame = CGRectMake(371, 0, 110, 56);
            make.font = [UIFont fontWithName:@"Helvetica" size:25];
            make.frame = CGRectMake(484, 0, 110, 56);
            supplied.font = [UIFont fontWithName:@"Helvetica" size:25];
            supplied.frame = CGRectMake(597, 0, 110, 56);
            received.font = [UIFont fontWithName:@"Helvetica" size:25];
            received.frame = CGRectMake(710.0, 0, 110, 56);
            rejectQtyButton.frame = CGRectMake(823.0, 0, 110, 56);
            delrowbtn.frame = CGRectMake(935.0, 10 , 40, 40);
        }
        else {
            
            item_code.font = [UIFont fontWithName:@"ArialRoundedMT" size:15];
            item_code.frame = CGRectMake(0, 0, 60, 30);
            item_description.font = [UIFont fontWithName:@"ArialRoundedMT" size:15];
            item_description.frame = CGRectMake(60, 0, 60, 30);
            price.font = [UIFont fontWithName:@"ArialRoundedMT" size:15];
            price.frame = CGRectMake(120, 0, 60, 30);
            qtyButton.frame = CGRectMake(180, 0, 50, 30);
            cost.font = [UIFont fontWithName:@"ArialRoundedMT" size:15];
            cost.frame = CGRectMake(230, 0, 60, 30);
            
            make.font = [UIFont fontWithName:@"Helvetica" size:25];
            make.frame = CGRectMake(290, 0, 60, 30);
            
            supplied.font = [UIFont fontWithName:@"ArialRoundedMT" size:15];
            supplied.frame = CGRectMake(350, 0, 60, 30);
            
            received.font = [UIFont fontWithName:@"Helvetica" size:25];
            received.frame = CGRectMake(410.0, 0, 60, 30);
            
            rejectQtyButton.frame = CGRectMake(470.0, 0, 60, 30);
            delrowbtn.frame = CGRectMake(535.0, 2 , 30, 30);
            
        }
        
        //        if (flag == false) {
        //
        //            NSLog(@"%@",dealoroffersTxt);
        //            NSLog(@"%.2f",[dealoroffersTxt.text floatValue]);
        //
        //            if ([subtotalTxt.text length] > 0) {
        //
        //                subtotalTxt.text = [NSString stringWithFormat:@"%.02f", [subtotalTxt.text floatValue] + [total.text floatValue]];
        //                if ([cartItem count] == indexPath.row +1) {
        //                    subtotalTxt.text = [NSString stringWithFormat:@"%.02f",[subtotalTxt.text floatValue] - [dealoroffersTxt.text floatValue]];
        //                }
        //            }
        //            else {
        //
        //                subtotalTxt.text = [NSString stringWithFormat:@"%.02f", [subtotalTxt.text floatValue] + [total.text floatValue] - [giftVoucherTxt.text floatValue]];
        //                if ([cartItem count] == indexPath.row +1) {
        //                    subtotalTxt.text = [NSString stringWithFormat:@"%.02f",[subtotalTxt.text floatValue] - [dealoroffersTxt.text floatValue]];
        //                }
        //
        //            }
        //
        //            taxTxt.text = [NSString stringWithFormat:@"%.02f", ([subtotalTxt.text floatValue] / 100) * 0.0f];
        //
        //            totalTxt.text = [NSString stringWithFormat:@"%.02f", [subtotalTxt.text floatValue] + [taxTxt.text floatValue]];
        //        }
        //        else{
        //
        //            taxTxt.text = [NSString stringWithFormat:@"%.02f", ([subtotalTxt.text floatValue] / 100) * 0.0f];
        //
        //            totalTxt.text = [NSString stringWithFormat:@"%.02f", [subtotalTxt.text floatValue] + [taxTxt.text floatValue]];
        //
        //
        //            NSLog(@" %d",[cartItem count]);
        //            NSLog(@" %d",indexPath.row);
        //
        //            if([cartItem count]-1 == indexPath.row){
        //
        //                flag = false;
        //            }
        //        }
        
        
        
        [hlcell setBackgroundColor:[UIColor clearColor]];
        [hlcell.contentView addSubview:item_code];
        [hlcell.contentView addSubview:item_description];
        [hlcell.contentView addSubview:price];
        [hlcell.contentView addSubview:qtyButton];
        [hlcell.contentView addSubview:cost];
        [hlcell.contentView addSubview:make];
        [hlcell .contentView addSubview:supplied];
        [hlcell.contentView addSubview:received];
        [hlcell.contentView addSubview:rejectQtyButton];
        [hlcell addSubview:delrowbtn];
        //
        
        
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
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:25];
            }
        }
        
        NSDictionary *JSON = [rawMaterials objectAtIndex:indexPath.row];
        hlcell.textLabel.text = [NSString stringWithFormat:@"%@",[JSON objectForKey:@"skuId"]];
        hlcell.textLabel.textColor = [UIColor blackColor];
    }
    
    return hlcell;
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
        
        NSDictionary *JSON = [rawMaterials objectAtIndex:indexPath.row];
        NSString *rawMaterial = [NSString stringWithFormat:@"%@",[JSON objectForKey:@"skuId"]];
        
        [self callRawMaterialDetails:rawMaterial];
    }
}

-(void)changeQuantity:(UIButton *)sender{
    
    AudioServicesPlaySystemSound (soundFileObject);
    
    cartTable.userInteractionEnabled = FALSE;
    receiptRefNoValue.userInteractionEnabled = FALSE;
    deliveredBYValue.userInteractionEnabled = FALSE;
    supplierIDValue.userInteractionEnabled = FALSE;
    inspectedBYValue.userInteractionEnabled = FALSE;
    supplierNameValue.userInteractionEnabled = FALSE;
    dateValue.userInteractionEnabled = FALSE;
    locationValue.userInteractionEnabled = FALSE;
    poRefValue.userInteractionEnabled = FALSE;
    shipmentValue.userInteractionEnabled = FALSE;
    submitBtn.userInteractionEnabled = FALSE;
    cancelButton.userInteractionEnabled = FALSE;
    
    NSArray *temp = [itemDetails objectAtIndex:sender.tag];
    
    rejectQtyChangeDisplayView = [[UIView alloc]init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        rejectQtyChangeDisplayView.frame = CGRectMake(200, 350.0, 375, 250.0);
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
    unitPriceData.text = [NSString stringWithFormat:@"%@",[temp objectAtIndex:2]];
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
    qtyField.inputAccessoryView = numberToolbar1;
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
    
    wareEditReceiptProcurementRejectMaterialTagId = sender.tag;
    
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
    receiptRefNoValue.userInteractionEnabled = TRUE;
    deliveredBYValue.userInteractionEnabled = TRUE;
    supplierIDValue.userInteractionEnabled = TRUE;
    inspectedBYValue.userInteractionEnabled = TRUE;
    supplierNameValue.userInteractionEnabled = TRUE;
    dateValue.userInteractionEnabled = TRUE;
    locationValue.userInteractionEnabled = TRUE;
    poRefValue.userInteractionEnabled = TRUE;
    shipmentValue.userInteractionEnabled = TRUE;
    submitBtn.userInteractionEnabled = TRUE;
    cancelButton.userInteractionEnabled = TRUE;
    
    NSString *value = [qtyField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // PhoNumber validation...
    NSString *decimalRegex = @"[0-9]+([.]([0-9]+)?)?"; // @"[0-9]+[.][0-9]+";
    NSPredicate *decimalTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalRegex];
    BOOL isNumber = [decimalTest evaluateWithObject:[qtyField text]];
    int qty = [value intValue];
    
    NSArray *temp = [itemDetails objectAtIndex:wareEditReceiptProcurementRejectMaterialTagId];
    
    if([value length] == 0 || !isNumber){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Quantity in Number." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        qtyField.text = NO;
    }
    else if([qtyField.text isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Valid Quantity." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        qtyField.text = nil;
    }
    else{
        
        //int received = qty - [[temp objectAtIndex:5] intValue];
        
        //        NSArray *finalArray = [NSArray arrayWithObjects:[temp objectAtIndex:0],[temp objectAtIndex:1],[temp objectAtIndex:2],[NSString stringWithFormat:@"%d", qty],[NSString stringWithFormat:@"%.2f",([[temp objectAtIndex:2] floatValue] * qty)],[temp objectAtIndex:5],[NSString stringWithFormat:@"%d",qty],[NSString stringWithFormat:@"%d",qty],@"0", nil];
        
        NSArray *finalArray = [NSArray arrayWithObjects:[temp objectAtIndex:0],[temp objectAtIndex:1],[temp objectAtIndex:2],[NSString stringWithFormat:@"%d",qty],[temp objectAtIndex:4],[NSString stringWithFormat:@"%d",qty],[NSString stringWithFormat:@"%d",[[temp objectAtIndex:6] intValue]],[NSString stringWithFormat:@"%.2f",(qty * [[temp objectAtIndex:2] floatValue])],[NSString stringWithFormat:@"%d",qty], nil];
        
        [itemDetails replaceObjectAtIndex:wareEditReceiptProcurementRejectMaterialTagId withObject:finalArray];
        
        [cartTable reloadData];
        
        rejectQtyChangeDisplayView.hidden = YES;
        cartTable.userInteractionEnabled = TRUE;
        
        wareEditReceiptProcurementQuantity = 0;
        wareEditReceiptProcurementMaterialCost = 0.0f;
        
        for (int i = 0; i < [itemDetails count]; i++) {
            NSArray *material = [itemDetails objectAtIndex:i];
            wareEditReceiptProcurementQuantity = wareEditReceiptProcurementQuantity + [[material objectAtIndex:5] intValue];
            wareEditReceiptProcurementMaterialCost = wareEditReceiptProcurementMaterialCost + ([[material objectAtIndex:2] floatValue]* [[material objectAtIndex:5] intValue]);
        }
        
        totalQuantity.text = [NSString stringWithFormat:@"%d",wareEditReceiptProcurementQuantity];
        totalCost.text = [NSString stringWithFormat:@"%.2f",wareEditReceiptProcurementMaterialCost];
    }
}

-(void) changeRejectQuantity:(UIButton *)sender{
    
    AudioServicesPlaySystemSound (soundFileObject);
    
    cartTable.userInteractionEnabled = FALSE;
    receiptRefNoValue.userInteractionEnabled = FALSE;
    deliveredBYValue.userInteractionEnabled = FALSE;
    supplierIDValue.userInteractionEnabled = FALSE;
    inspectedBYValue.userInteractionEnabled = FALSE;
    supplierNameValue.userInteractionEnabled = FALSE;
    dateValue.userInteractionEnabled = FALSE;
    locationValue.userInteractionEnabled = FALSE;
    poRefValue.userInteractionEnabled = FALSE;
    shipmentValue.userInteractionEnabled = FALSE;
    submitBtn.userInteractionEnabled = FALSE;
    cancelButton.userInteractionEnabled = FALSE;
    
    NSArray *temp = [itemDetails objectAtIndex:sender.tag];
    
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
    availQtyData.text = [NSString stringWithFormat:@"%@",[temp objectAtIndex:5]];
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
    rejectQtyField.inputAccessoryView = numberToolbar1;
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
    
    wareEditReceiptProcurementRejectMaterialTagId = sender.tag;
    
    [qtyChangeDisplayView release];
    [topbar release];
    [availQty release];
    [unitPrice release];
    [availQtyData release];
    [unitPriceData release];
    [qtyField release];
    
}

- (IBAction)qtyCancelButtonPressed:(id)sender {
    
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    rejectQtyChangeDisplayView.hidden = YES;
    cartTable.userInteractionEnabled = TRUE;
    receiptRefNoValue.userInteractionEnabled = TRUE;
    deliveredBYValue.userInteractionEnabled = TRUE;
    supplierIDValue.userInteractionEnabled = TRUE;
    inspectedBYValue.userInteractionEnabled = TRUE;
    supplierNameValue.userInteractionEnabled = TRUE;
    dateValue.userInteractionEnabled = TRUE;
    locationValue.userInteractionEnabled = TRUE;
    poRefValue.userInteractionEnabled = TRUE;
    shipmentValue.userInteractionEnabled = TRUE;
    submitBtn.userInteractionEnabled = TRUE;
    cancelButton.userInteractionEnabled = TRUE;
    //[qtyCancelButton release];
}

-(IBAction)rejectQtyCancelButtonPressed:(id)sender{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    qtyChangeDisplayView.hidden = YES;
    cartTable.userInteractionEnabled = TRUE;
    receiptRefNoValue.userInteractionEnabled = TRUE;
    deliveredBYValue.userInteractionEnabled = TRUE;
    supplierIDValue.userInteractionEnabled = TRUE;
    inspectedBYValue.userInteractionEnabled = TRUE;
    supplierNameValue.userInteractionEnabled = TRUE;
    dateValue.userInteractionEnabled = TRUE;
    locationValue.userInteractionEnabled = TRUE;
    poRefValue.userInteractionEnabled = TRUE;
    shipmentValue.userInteractionEnabled = TRUE;
    submitBtn.userInteractionEnabled = TRUE;
    cancelButton.userInteractionEnabled = TRUE;
    //[rejectCancelButton release];
}

- (IBAction)rejectQtyOkButtonPressed:(id)sender {
    
    AudioServicesPlaySystemSound (soundFileObject);
    [rejectQtyField resignFirstResponder];
    cartTable.userInteractionEnabled = TRUE;
    receiptRefNoValue.userInteractionEnabled = TRUE;
    deliveredBYValue.userInteractionEnabled = TRUE;
    supplierIDValue.userInteractionEnabled = TRUE;
    inspectedBYValue.userInteractionEnabled = TRUE;
    supplierNameValue.userInteractionEnabled = TRUE;
    dateValue.userInteractionEnabled = TRUE;
    locationValue.userInteractionEnabled = TRUE;
    poRefValue.userInteractionEnabled = TRUE;
    shipmentValue.userInteractionEnabled = TRUE;
    submitBtn.userInteractionEnabled = TRUE;
    cancelButton.userInteractionEnabled = TRUE;
    NSString *value = [rejectQtyField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // PhoNumber validation...
    NSString *decimalRegex = @"[0-9]+([.]([0-9]+)?)?"; // @"[0-9]+[.][0-9]+";
    NSPredicate *decimalTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalRegex];
    BOOL isNumber = [decimalTest evaluateWithObject:[rejectQtyField text]];
    int qty = [value intValue];
    
    NSArray *temp = [itemDetails objectAtIndex:wareEditReceiptProcurementRejectMaterialTagId];
    
    if (qty > [[temp objectAtIndex:7] intValue]){
        
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
    else if([rejectQtyField.text isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Valid Quantity." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        rejectQtyField.text = nil;
    }
    else{
        
        int received = [[temp objectAtIndex:5] intValue] - qty;
        
        //        NSArray *finalArray = [NSArray arrayWithObjects:[temp objectAtIndex:0],[temp objectAtIndex:1],[temp objectAtIndex:2],[temp objectAtIndex:3],[temp objectAtIndex:4],[temp objectAtIndex:5],[temp objectAtIndex:6],[NSString stringWithFormat:@"%d",received],[NSString stringWithFormat:@"%d",qty], nil];
        
        NSArray *finalArray = [NSArray arrayWithObjects:[temp objectAtIndex:0],[temp objectAtIndex:1],[temp objectAtIndex:2],[temp objectAtIndex:3],[temp objectAtIndex:4],[NSString stringWithFormat:@"%d",received],[NSString stringWithFormat:@"%d",qty],[NSString stringWithFormat:@"%.2f",(received * [[temp objectAtIndex:2] floatValue])],[NSString stringWithFormat:@"%d",received], nil];
        
        [itemDetails replaceObjectAtIndex:wareEditReceiptProcurementRejectMaterialTagId withObject:finalArray];
        
        [cartTable reloadData];
        
        qtyChangeDisplayView.hidden = YES;
        cartTable.userInteractionEnabled = TRUE;
        
        wareEditReceiptProcurementQuantity = 0;
        wareEditReceiptProcurementMaterialCost = 0.0f;
        
        for (int i = 0; i < [itemDetails count]; i++) {
            NSArray *material = [itemDetails objectAtIndex:i];
            wareEditReceiptProcurementQuantity = wareEditReceiptProcurementQuantity + [[material objectAtIndex:5] intValue];
            wareEditReceiptProcurementMaterialCost = wareEditReceiptProcurementMaterialCost + ([[material objectAtIndex:2] floatValue]* [[material objectAtIndex:5] intValue]);
        }
        
        totalQuantity.text = [NSString stringWithFormat:@"%d",wareEditReceiptProcurementQuantity];
        totalCost.text = [NSString stringWithFormat:@"%.2f",wareEditReceiptProcurementMaterialCost];
    }
    
}

-(void)submitButtonPressed {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    NSString *value1 = [supplierIDValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *value2 = [supplierNameValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *value3 = [locationValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *value4 = [deliveredBYValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *value5 = [poRefValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *value6 = [shipmentValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *value7 = [inspectedBYValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    
    if ([itemDetails count] == 0){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please add items to cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else if ([value1 length] == 0 || [value2 length] == 0 || [value3 length] == 0 || [value4 length] == 0 || [value5 length] == 0 || [value6 length] == 0 || [value7 length] == 0){
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
        HUD_.labelText = @"Updating Receipt..";
        
        NSMutableArray *itemcode = [[NSMutableArray alloc] init];
        NSMutableArray *desc = [[NSMutableArray alloc] init];
        NSMutableArray *price = [[NSMutableArray alloc] init];
        NSMutableArray *max_qty = [[NSMutableArray alloc] init];
        NSMutableArray *cost = [[NSMutableArray alloc] init];
        NSMutableArray *make = [[NSMutableArray alloc] init];
        NSMutableArray *supplied = [[NSMutableArray alloc] init];
        NSMutableArray *received = [[NSMutableArray alloc] init];
        NSMutableArray *rejected = [[NSMutableArray alloc] init];
        
        NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *temp1 = [[NSMutableDictionary alloc]init];
        NSMutableArray *temparr = [[NSMutableArray alloc]init];
        NSDictionary *dic = [[NSDictionary alloc] init];
        
        for (int i = 0; i < [itemDetails count]; i++) {
            NSArray *temp = [itemDetails objectAtIndex:i];
            [itemcode addObject:[temp objectAtIndex:0]];
            [desc addObject:[temp objectAtIndex:1]];
            [price addObject:[temp objectAtIndex:2]];
            [max_qty addObject:[temp objectAtIndex:3]];
            [cost addObject:[NSString stringWithFormat:@"%.2f",[[temp objectAtIndex:5] intValue]*[[temp objectAtIndex:2] floatValue]]];
            [make addObject:[temp objectAtIndex:4]];
            [supplied addObject:[temp objectAtIndex:8]];
            [received addObject:[temp objectAtIndex:5]];
            [rejected addObject:[temp objectAtIndex:6]];
        }
        
        NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        NSArray *str = [time componentsSeparatedByString:@" "];
        NSString *date_ = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
        
        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
        
        
        for (int i=0; i < [itemcode count]; i++) {
            
            [temp setObject:[itemcode objectAtIndex:i] forKey:@"item_code"];
            [temp setObject:[desc objectAtIndex:i] forKey:@"item_description"];
            [temp setObject:[price objectAtIndex:i] forKey:@"price"];
            [temp setObject:[max_qty objectAtIndex:i] forKey:@"pack"];
            [temp setObject:[cost objectAtIndex:i] forKey:@"cost"];
            [temp setObject:[supplied objectAtIndex:i] forKey:@"supplied"];
            [temp setObject:[received objectAtIndex:i] forKey:@"received"];
            [temp setObject:[rejected objectAtIndex:i] forKey:@"reject"];
            [temp setObject:[make objectAtIndex:i] forKey:@"make"];
            
            dic = [temp copy];
            
            [temp1 setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
            
            [temparr addObject:[temp1 valueForKey:[NSString stringWithFormat:@"%d",i]]];
            
            
        }
        
        NSArray *keys = [NSArray arrayWithObjects:@"receipt_ref_num", @"receipt_total_qty",@"sub_total",@"gst",@"grand_total",@"supplier_id",@"supplier_name",@"location",@"delivered_by",@"date",@"po_reference",@"shipment_note",@"inspected_by",@"itemDetails",@"status",@"requestHeader", nil];
        
        NSArray *objects = [NSArray arrayWithObjects:wareEditProcurementReceiptID, totalQuantity.text,totalCost.text,@"0",totalCost.text,supplierIDValue.text,supplierNameValue.text,locationValue.text,deliveredBYValue.text,dateValue.text, poRefValue.text,shipmentValue.text,inspectedBYValue.text,temparr,@"true",dictionary_, nil];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * createReceiptJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WHStockReceiptServiceSoapBinding *materialBinding = [[WHStockReceiptService WHStockReceiptServiceSoapBinding] retain];
        WHStockReceiptService_createNewStockProcurementReceipt *aparams = [[WHStockReceiptService_createNewStockProcurementReceipt alloc] init];
        //        tns1_createNewStockProcurementReceipt *aparams = [[tns1_createNewStockProcurementReceipt alloc] init];
        aparams.procurement_details = createReceiptJsonString;
        
        WHStockReceiptServiceSoapBindingResponse *response = [materialBinding createNewStockProcurementReceiptUsingParameters:(WHStockReceiptService_createNewStockProcurementReceipt *)aparams];
        NSArray *responseBodyParts = response.bodyParts;
        
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[WHStockReceiptService_createNewStockProcurementReceiptResponse class]]) {
                WHStockReceiptService_createNewStockProcurementReceiptResponse *body = (WHStockReceiptService_createNewStockProcurementReceiptResponse *)bodyPart;
                printf("\nresponse=%s",[body.return_ UTF8String]);
                
                
                NSError *e;
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                                     options: NSJSONReadingMutableContainers
                                                                       error: &e];
                NSDictionary *json = [JSON objectForKey:@"responseHeader"];
                if ([[json objectForKey:@"responseCode"] isEqualToString:@"0"] && [[json objectForKey:@"responseMessage"] isEqualToString:@"Success"]) {
                    
                    SystemSoundID	soundFileObject1;
                    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
                    self.soundFileURLRef = (CFURLRef) [tapSound retain];
                    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                    AudioServicesPlaySystemSound (soundFileObject1);
                    
                    NSString *receiptID = [JSON objectForKey:@"receipt_id"];
                    wareEditProcurementReceipt = [receiptID copy];
                    UIAlertView *successAlertView  = [[UIAlertView alloc] init];
                    [successAlertView setDelegate:self];
                    [successAlertView setTitle:@"Procurement Receipt Updated Successfully"];
                    [successAlertView setMessage:[NSString stringWithFormat:@"%@%@",@"Receipt ID : ",receiptID]];
                    [successAlertView addButtonWithTitle:@"OPEN RECEIPT"];
                    [successAlertView addButtonWithTitle:@"NEW RECEIPT"];
                    
                    [successAlertView show];
                    
                    [HUD_ hide:YES afterDelay:1.0];
                    [HUD_ release];
                }
                else{
                    [HUD_ setHidden:YES];
                    SystemSoundID	soundFileObject1;
                    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
                    self.soundFileURLRef = (CFURLRef) [tapSound retain];
                    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                    AudioServicesPlaySystemSound (soundFileObject1);
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed To update Receipt" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed To update Receipt" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
            }
        }
        supplierIDValue.text = @"";
        supplierNameValue.text = @"";
        locationValue.text = @"";
        deliveredBYValue.text = @"";
        inspectedBYValue.text = @"";
        poRefValue.text = @"";
        shipmentValue.text = @"";
        
        [rawMaterials removeAllObjects];
        [itemDetails removeAllObjects];
        [cartTable reloadData];
        totalCost.text = @"0.0";
        totalQuantity.text = @"0";
    }
}

-(void)cancelButtonPressed {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    //    NSString *value1 = [supplierIDValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //    NSString *value2 = [supplierNameValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //    NSString *value3 = [locationValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //    NSString *value4 = [deliveredBYValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //    NSString *value5 = [poRefValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //    NSString *value6 = [shipmentValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //    NSString *value7 = [inspectedBYValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    
    if ([itemDetails count] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please add items to cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    //    else if ([value1 length] == 0 || [value2 length] == 0 || [value3 length] == 0 || [value4 length] == 0 || [value5 length] == 0 || [value6 length] == 0 || [value7 length] == 0){
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
        
        NSMutableArray *itemcode = [[NSMutableArray alloc] init];
        NSMutableArray *desc = [[NSMutableArray alloc] init];
        NSMutableArray *price = [[NSMutableArray alloc] init];
        NSMutableArray *max_qty = [[NSMutableArray alloc] init];
        NSMutableArray *cost = [[NSMutableArray alloc] init];
        NSMutableArray *make = [[NSMutableArray alloc] init];
        NSMutableArray *supplied = [[NSMutableArray alloc] init];
        NSMutableArray *received = [[NSMutableArray alloc] init];
        NSMutableArray *rejected = [[NSMutableArray alloc] init];
        
        NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *temp1 = [[NSMutableDictionary alloc]init];
        NSMutableArray *temparr = [[NSMutableArray alloc]init];
        NSDictionary *dic = [[NSDictionary alloc] init];
        
        for (int i = 0; i < [itemDetails count]; i++) {
            
            NSArray *temp = [itemDetails objectAtIndex:i];
            [itemcode addObject:[temp objectAtIndex:0]];
            [desc addObject:[temp objectAtIndex:1]];
            [price addObject:[temp objectAtIndex:2]];
            [max_qty addObject:[temp objectAtIndex:3]];
            [cost addObject:[NSString stringWithFormat:@"%.2f",[[temp objectAtIndex:5] intValue]*[[temp objectAtIndex:2] floatValue]]];
            [make addObject:[temp objectAtIndex:4]];
            [supplied addObject:[temp objectAtIndex:8]];
            [received addObject:[temp objectAtIndex:5]];
            [rejected addObject:[temp objectAtIndex:6]];
            
        }
        
        NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        NSArray *str = [time componentsSeparatedByString:@" "];
        NSString *date_ = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
        
        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
        
        for (int i=0; i < [itemcode count]; i++) {
            
            [temp setObject:[itemcode objectAtIndex:i] forKey:@"item_code"];
            [temp setObject:[desc objectAtIndex:i] forKey:@"item_description"];
            [temp setObject:[price objectAtIndex:i] forKey:@"price"];
            [temp setObject:[max_qty objectAtIndex:i] forKey:@"pack"];
            [temp setObject:[cost objectAtIndex:i] forKey:@"cost"];
            [temp setObject:[supplied objectAtIndex:i] forKey:@"supplied"];
            [temp setObject:[received objectAtIndex:i] forKey:@"received"];
            [temp setObject:[rejected objectAtIndex:i] forKey:@"reject"];
            [temp setObject:[make objectAtIndex:i] forKey:@"make"];
            
            dic = [temp copy];
            
            [temp1 setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
            
            [temparr addObject:[temp1 valueForKey:[NSString stringWithFormat:@"%d",i]]];
            
            
        }
        
        NSArray *keys = [NSArray arrayWithObjects:@"receipt_ref_num", @"receipt_total_qty",@"sub_total",@"gst",@"grand_total",@"supplier_id",@"supplier_name",@"location",@"delivered_by",@"date",@"po_reference",@"shipment_note",@"inspected_by",@"itemDetails",@"status",@"requestHeader", nil];
        
        NSArray *objects = [NSArray arrayWithObjects:wareEditProcurementReceiptID, totalQuantity.text,totalCost.text,@"0",totalCost.text,supplierIDValue.text,supplierNameValue.text,locationValue.text,deliveredBYValue.text,dateValue.text, poRefValue.text,shipmentValue.text,inspectedBYValue.text,temparr,@"true",dictionary_, nil];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * createReceiptJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WHStockReceiptServiceSoapBinding *materialBinding = [[WHStockReceiptService WHStockReceiptServiceSoapBinding] retain];
        WHStockReceiptService_createNewStockProcurementReceipt *aparams = [[WHStockReceiptService_createNewStockProcurementReceipt alloc] init];
        //        tns1_createNewStockProcurementReceipt *aparams = [[tns1_createNewStockProcurementReceipt alloc] init];
        aparams.procurement_details = createReceiptJsonString;
        
        WHStockReceiptServiceSoapBindingResponse *response = [materialBinding createNewStockProcurementReceiptUsingParameters:(WHStockReceiptService_createNewStockProcurementReceipt *)aparams];
        NSArray *responseBodyParts = response.bodyParts;
        
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[WHStockReceiptService_createNewStockProcurementReceiptResponse class]]) {
                WHStockReceiptService_createNewStockProcurementReceiptResponse *body = (WHStockReceiptService_createNewStockProcurementReceiptResponse *)bodyPart;
                printf("\nresponse=%s",[body.return_ UTF8String]);
                
                NSError *e;
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                                     options: NSJSONReadingMutableContainers
                                                                       error: &e];
                NSDictionary *json = [JSON objectForKey:@"responseHeader"];
                if ([[json objectForKey:@"responseCode"] isEqualToString:@"0"] && [[json objectForKey:@"responseMessage"] isEqualToString:@"Success"]) {
                    SystemSoundID	soundFileObject1;
                    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
                    self.soundFileURLRef = (CFURLRef) [tapSound retain];
                    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                    AudioServicesPlaySystemSound (soundFileObject1);
                    
                    NSString *receiptID = [JSON objectForKey:@"receipt_id"];
                    wareEditProcurementReceipt = [receiptID copy];
                    UIAlertView *successAlertView  = [[UIAlertView alloc] init];
                    [successAlertView setDelegate:self];
                    [successAlertView setTitle:@"Procurement Receipt Saved Successfully"];
                    [successAlertView setMessage:[NSString stringWithFormat:@"%@%@",@"Receipt ID : ",receiptID]];
                    [successAlertView addButtonWithTitle:@"OPEN RECEIPT"];
                    [successAlertView addButtonWithTitle:@"NEW RECEIPT"];
                    
                    [successAlertView show];
                    
                    [HUD_ hide:YES afterDelay:1.0];
                    [HUD_ release];
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
        supplierIDValue.text = @"";
        supplierNameValue.text = @"";
        locationValue.text = @"";
        deliveredBYValue.text = @"";
        inspectedBYValue.text = @"";
        poRefValue.text = @"";
        shipmentValue.text = @"";
        
        [rawMaterials removeAllObjects];
        [itemDetails removeAllObjects];
        [cartTable reloadData];
        totalCost.text = @"0.0";
        totalQuantity.text = @"0";
    }
}

- (void) delRow:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    [itemDetails removeObjectAtIndex:[sender tag]];
    
    wareEditReceiptProcurementQuantity = 0;
    wareEditReceiptProcurementMaterialCost = 0.0f;
    
    for (int i = 0; i < [itemDetails count]; i++) {
        NSArray *material = [itemDetails objectAtIndex:i];
        wareEditReceiptProcurementQuantity = wareEditReceiptProcurementQuantity + [[material objectAtIndex:7] intValue];
        wareEditReceiptProcurementMaterialCost = wareEditReceiptProcurementMaterialCost + ([[material objectAtIndex:2] floatValue]* [[material objectAtIndex:7] intValue]);
    }
    
    totalQuantity.text = [NSString stringWithFormat:@"%d",wareEditReceiptProcurementQuantity];
    totalCost.text = [NSString stringWithFormat:@"%.2f",wareEditReceiptProcurementMaterialCost];
    [cartTable reloadData];
}

-(void)popUpView {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    PopOverViewController *popOverViewController = [[PopOverViewController alloc] init];
    
    UIView *categoriesView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 160.0, 100.0)];
    categoriesView.opaque = NO;
    categoriesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    categoriesView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    categoriesView.layer.borderWidth = 2.0f;
    [categoriesView setHidden:NO];
    CGFloat top = 0.0;
    
    NSMutableArray *folderStructure = [[NSMutableArray alloc] init];
    [folderStructure addObject:@"Home"];
    [folderStructure addObject:@"New Receipt"];
    [folderStructure addObject:@"Logout"];
    
    for (int i = 0; i < [folderStructure count]; i++) {
        UIButton *upload = [[UIButton alloc] init];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            categoriesView.frame = CGRectMake(0, 0, 230, 150.0);
            upload.frame = CGRectMake(-25, top, 280.0, 50.0);
        }
        else{
            upload.titleLabel.font = [UIFont systemFontOfSize:15.0f];
            upload.frame = CGRectMake(0.0, top, 160.0, 50.0);
        }
        upload.backgroundColor = [UIColor clearColor];
        upload.tag = i;
        [upload setTitle:[folderStructure objectAtIndex:i] forState:UIControlStateNormal];
        [upload setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [upload addTarget:self action:@selector(buttonClicked1:) forControlEvents:UIControlEventTouchUpInside];
        [[upload layer] setBorderWidth:0.5f];
        [[upload layer] setBorderColor:[UIColor grayColor].CGColor];
        top = top+50.0;
        [categoriesView addSubview:upload];
    }
    
    popOverViewController.view = categoriesView;
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        popOverViewController.preferredContentSize =  CGSizeMake(categoriesView.frame.size.width, categoriesView.frame.size.height);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:popOverViewController];
        
        [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        
        self.popOver = popover;
    }
    else {
        
        //        if (version >= 8.0) {
        //
        //            //         popOverViewController.preferredContentSize = CGSizeMake(100.0, 150.0);
        //            //         UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:popOverViewController];
        //            //          [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        //            //         self.popOver = popover;
        //
        //            action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Home",@"New Billing",@"Return Item",@"Exchange Item",@"Logout",@"Cancel", nil];
        //            [action showFromBarButtonItem:sendButton animated:YES];
        //        }
        //        else {
        popOverViewController.contentSizeForViewInPopover = CGSizeMake(160.0, 150.0);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:popOverViewController];
        // popover.contentViewController.view.alpha = 0.0;
        [[[popover contentViewController]  view] setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:1.0f]];
        [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        self.popOver = popover;
        //        }
    }
    
    
}

-(void) buttonClicked1:(UIButton*)sender
{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    [self.popOver dismissPopoverAnimated:YES];
    if (sender.tag == 0) {
        
        [self.popOver dismissPopoverAnimated:YES];
        OmniHomePage *home = [[[OmniHomePage alloc] init] autorelease];
        [self.navigationController pushViewController:home animated:YES];
    }
    else if (sender.tag == 1) {
        self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
        self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
        
        WareHouseReceiptProcurement *editReceipt = [[WareHouseReceiptProcurement alloc] init];
        [self.navigationController pushViewController:editReceipt animated:YES];
    }
    else{
        [self.popOver dismissPopoverAnimated:YES];
        OmniHomePage *omniRetailerViewController = [[OmniHomePage alloc] init];
        [omniRetailerViewController logOut];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    if ([alertView.title isEqualToString:@"Procurement Receipt Updated Successfully"]) {
        if (buttonIndex == 0) {
            self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
            self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
            
            ViewWareHouseProcurementReceipt *viewReceipt = [[ViewWareHouseProcurementReceipt alloc] initWithReceiptID:wareEditProcurementReceipt];
            [self.navigationController pushViewController:viewReceipt animated:YES];
        }
        else{
            self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
            self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
            
            WareHouseReceiptProcurement *editReceipt = [[WareHouseReceiptProcurement alloc] init];
            [self.navigationController pushViewController:editReceipt animated:YES];
        }
    }
    else if ([alertView.title isEqualToString:@"Procurement Receipt Saved Successfully"]){
        if (buttonIndex == 0) {
            self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
            self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
            
            ViewWareHouseProcurementReceipt *viewReceipt = [[ViewWareHouseProcurementReceipt alloc] initWithReceiptID:wareEditProcurementReceipt];
            [self.navigationController pushViewController:viewReceipt animated:YES];
        }
        else{
            self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
            self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
            
            WareHouseReceiptProcurement *editReceipt = [[WareHouseReceiptProcurement alloc] init];
            [self.navigationController pushViewController:editReceipt animated:YES];
        }
    }
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
