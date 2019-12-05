//
//  WareHouseStockReceipt.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/17/15.
//
//

#import "WareHouseStockReceipt.h"
#import "RawMaterialServiceSvc.h"
#import "WHStockReceiptService.h"
#import "Global.h"
#import "SkuServiceSvc.h"
#import "UtilityMasterServiceSvc.h"
#import "OpenWareHouseReceipt.h"

@interface WareHouseStockReceipt ()

@end

@implementation WareHouseStockReceipt
@synthesize soundFileURLRef,soundFileObject;

int wareReceiptProcurementQuantity_ = 0;
int wareReceieptProcurementMaterialTagid_ = 0;
int wareReceiptProcurementRejectMaterialTagId_ = 0;
float wareReceiptProcurementMaterialCost_ = 0.0f;
int wareStartPoint_;
NSString *wareReceipt_;
NSDictionary *wareJSON_1 = NULL;
bool wareScrollValueStatus_ = NO;
int  wareStartIndex = 0;

bool wareFromlocationScrollValueStatus_ = NO;
int  wareFromlocationStartIndex = 0;

-(void) callRawMaterialDetails:(NSString *)skuId{
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
    NSArray *objects = [NSArray arrayWithObjects:skuId,dictionary_, nil];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
    NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    getSkuid.skuID = salesReportJsonString;
    
    // NSDictionary *JSON;
    
    @try {
        
        SkuServiceSoapBindingResponse *response = [skuService getSkuDetailsUsingParameters:(SkuServiceSvc_getSkuDetails *)getSkuid];
        NSArray *responseBodyParts = response.bodyParts;
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[SkuServiceSvc_getSkuDetailsResponse class]]) {
                SkuServiceSvc_getSkuDetailsResponse *body = (SkuServiceSvc_getSkuDetailsResponse *)bodyPart;
                printf("\nresponse=%s",[body.return_ UTF8String]);
                NSError *e;
                wareJSON_1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                         options: NSJSONReadingMutableContainers
                                                           error: &e];
            }
        }
    }
    @catch (NSException *exception) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Failed to get the details" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
    NSArray *temp = [NSArray arrayWithObjects:[wareJSON_1 objectForKey:@"description"],[wareJSON_1 objectForKey:@"productName"],[wareJSON_1 objectForKey:@"price"],@"1",[wareJSON_1 objectForKey:@"price"],@"N/A",@"1",@"1",@"0", nil];
    
    for (int c = 0; c < [rawMaterialDetails count]; c++) {
        NSArray *material = [rawMaterialDetails objectAtIndex:c];
        if ([[material objectAtIndex:0] isEqualToString:[NSString stringWithFormat:@"%@",[wareJSON_1 objectForKey:@"productName"]]]) {
            NSArray *temp = [NSArray arrayWithObjects:[material objectAtIndex:0],[material objectAtIndex:1],[material objectAtIndex:2],[NSString stringWithFormat:@"%d",[[material objectAtIndex:3] intValue] + 1],[NSString stringWithFormat:@"%.2f",(([[material objectAtIndex:7] intValue] + 1) * [[material objectAtIndex:2] floatValue])],[material objectAtIndex:5],[NSString stringWithFormat:@"%d",[[material objectAtIndex:6] intValue] + 1],[NSString stringWithFormat:@"%d",[[material objectAtIndex:7] intValue]+1],[material objectAtIndex:8], nil];
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
    
    wareReceiptProcurementQuantity_ = 0;
    wareReceiptProcurementMaterialCost_ = 0.0f;
    
    for (int i = 0; i < [rawMaterialDetails count]; i++) {
        NSArray *material = [rawMaterialDetails objectAtIndex:i];
        wareReceiptProcurementQuantity_ = wareReceiptProcurementQuantity_ + [[material objectAtIndex:7] intValue];
        wareReceiptProcurementMaterialCost_ = wareReceiptProcurementMaterialCost_ + ([[material objectAtIndex:2] floatValue] * [[material objectAtIndex:7] intValue]);
    }
    
    totalQuantity.text = [NSString stringWithFormat:@"%d",wareReceiptProcurementQuantity_];
    totalCost.text = [NSString stringWithFormat:@"%.2f",wareReceiptProcurementMaterialCost_];
    
    [HUD hide:YES afterDelay:1.0];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    wareScrollValueStatus_ = NO;
    wareFromlocationScrollValueStatus_ = NO;
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (CFURLRef) [tapSound retain];
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    self.navigationController.navigationBarHidden = NO;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 400.0, 45.0)];
    titleView.backgroundColor = [UIColor clearColor];
    
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo_200.png"]];
    logoView.backgroundColor = [UIColor clearColor];
    logoView.frame = CGRectMake(60.0, 0.0, 45.0, 45.0);
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(110.0, -13.0, 200.0, 70.0)];
    titleLbl.text = @"Stock Receipt";
    titleLbl.textColor = [UIColor blackColor];
    titleLbl.font = [UIFont boldSystemFontOfSize:25.0f];
    titleLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25.0f];
    [titleView addSubview:logoView];
    [titleView addSubview:titleLbl];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
    }
    else{
        logoView.frame = CGRectMake(20.0, 7.0, 30.0, 30.0);
        titleLbl.frame = CGRectMake(55.0, -12.0, 150.0, 70.0);
        titleLbl.backgroundColor = [UIColor clearColor];
        titleLbl.textColor = [UIColor whiteColor];
        titleLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
    }
    
    self.navigationItem.titleView = titleView;

    self.view.backgroundColor = [UIColor blackColor];
    
    locationArr = [[NSMutableArray alloc] init];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    // Show the HUD
    [HUD show:NO];
    [HUD setHidden:YES];
    
    HUD.labelText = @"Loading Please Wait..";
    
    rawMaterialDetails = [[NSMutableArray alloc] init];
    
    
    createReceiptView = [[UIView alloc] init];
    createReceiptView.backgroundColor = [UIColor clearColor];
    //    createReceiptView.bounces = FALSE;
    //    createReceiptView.hidden = NO;
    
    viewReceiptView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 125.0, self.view.frame.size.width, self.view.frame.size.height)];
    viewReceiptView.backgroundColor = [UIColor clearColor];
    viewReceiptView.hidden = YES;
    
    supplierID = [[UITextField alloc] init];
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
    supplierID.placeholder = @"   Supplier ID";
    [supplierID addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    supplierName = [[UITextField alloc] init];
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
    supplierName.placeholder = @"   Supplier Name";
    [supplierName addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    location = [[UITextField alloc] init];
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
    location.placeholder = @"   From Location";
    // [location addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    selectLocation = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *buttonImageDD = [UIImage imageNamed:@"combo.png"];
    [selectLocation setBackgroundImage:buttonImageDD forState:UIControlStateNormal];
    [selectLocation addTarget:self
                       action:@selector(getListOfLocations:) forControlEvents:UIControlEventTouchDown];
    selectLocation.tag = 1;
    
    locationTable = [[UITableView alloc] init];
    locationTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [locationTable setDataSource:self];
    [locationTable setDelegate:self];
    [locationTable.layer setBorderWidth:1.0f];
    locationTable.layer.cornerRadius = 3;
    locationTable.layer.borderColor = [UIColor grayColor].CGColor;
    locationTable.hidden = YES;
    
    deliveredBy = [[UITextField alloc] init];
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
    deliveredBy.placeholder = @"   Delivered By";
    [deliveredBy addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    inspectedBy = [[UITextField alloc] init];
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
    inspectedBy.placeholder = @"   Inspected By";
    [inspectedBy addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    // getting present date & time ..
    NSDate *today = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString* currentdate = [f stringFromDate:today];
    [f release];
    
    date = [[UITextField alloc] init];
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
    
    toLocation = [[UITextField alloc] init];
    toLocation.borderStyle = UITextBorderStyleRoundedRect;
    toLocation.textColor = [UIColor blackColor];
    toLocation.font = [UIFont systemFontOfSize:18.0];
    toLocation.backgroundColor = [UIColor whiteColor];
    toLocation.clearButtonMode = UITextFieldViewModeWhileEditing;
    toLocation.backgroundColor = [UIColor whiteColor];
    toLocation.autocorrectionType = UITextAutocorrectionTypeNo;
    toLocation.layer.borderColor = [UIColor whiteColor].CGColor;
    toLocation.backgroundColor = [UIColor whiteColor];
    toLocation.delegate = self;
    toLocation.placeholder = @"   To Location";
    [toLocation addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    toLocation.text = presentLocation;
    toLocation.userInteractionEnabled = FALSE;
    
    shipmentNote = [[UITextField alloc] init];
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
    shipmentNote.placeholder = @"   Shipment Note";
    [shipmentNote addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
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
    label2.text = @"Item";
    label2.layer.cornerRadius = 14;
    label2.layer.masksToBounds = YES;
    label2.numberOfLines = 2;
    [label2 setTextAlignment:NSTextAlignmentCenter];
    label2.font = [UIFont boldSystemFontOfSize:14.0];
    label2.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label2.textColor = [UIColor whiteColor];
    
    UILabel *label11 = [[[UILabel alloc] init] autorelease];
    label11.text = @"Desc";
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
    
    //    UILabel *label12 = [[[UILabel alloc] init] autorelease];
    //    label12.text = @"Make";
    //    label12.layer.cornerRadius = 14;
    //    label12.layer.masksToBounds = YES;
    //    [label12 setTextAlignment:NSTextAlignmentCenter];
    //    label12.font = [UIFont boldSystemFontOfSize:14.0];
    //    label12.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    //    label12.textColor = [UIColor whiteColor];
    
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
    
    receiptsIdsArr = [[NSMutableArray alloc] init];
    receiptStatusArr = [[NSMutableArray alloc] init];
    receiptDateArr = [[NSMutableArray alloc] init];
    receiptDeliveredByArr = [[NSMutableArray alloc] init];
    receiptTotalArr = [[NSMutableArray alloc] init];
    
    receiptDetails = [[NSMutableArray alloc] init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        //        mainSegmentedControl.frame = CGRectMake(-2, 65, 772, 60);
        //        mainSegmentedControl.tintColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        //        mainSegmentedControl.backgroundColor = [UIColor clearColor];
        //        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
        //                                    [UIFont boldSystemFontOfSize:18], UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor,
        //                                    nil];
        //        [mainSegmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
        
        createReceiptView.frame = CGRectMake(0, 125, self.view.frame.size.width, self.view.frame.size.height);
        //createReceiptView.contentSize = CGSizeMake(self.view.frame.size.width + 500, 1000);
        
        location.font = [UIFont boldSystemFontOfSize:20];
        location.frame = CGRectMake(10.0, 10.0, 360, 50);
        
        selectLocation.frame = CGRectMake(330, 5, 50, 65);
        
        locationTable.frame = CGRectMake(10.0, 70.0, 360, 0);
        
        toLocation.font = [UIFont boldSystemFontOfSize:20];
        toLocation.frame = CGRectMake(400.0, 10.0, 360, 50);
        
        deliveredBy.font = [UIFont boldSystemFontOfSize:20];
        deliveredBy.frame = CGRectMake(10.0, 70.0, 360, 50);
        
        inspectedBy.font = [UIFont boldSystemFontOfSize:20];
        inspectedBy.frame = CGRectMake(400.0, 70.0, 360, 50);
        
        date.font = [UIFont boldSystemFontOfSize:20];
        date.frame = CGRectMake( 10.0, 130.0, 360, 50);
        
        //        inspectedBy.font = [UIFont boldSystemFontOfSize:30];
        //        inspectedBy.frame = CGRectMake(10.0, 130.0, 360, 50);
        //
        //        date.font = [UIFont boldSystemFontOfSize:30];
        //        date.frame = CGRectMake(400.0, 130.0, 360, 50);
        //
        
        //
        //        shipmentNote.font = [UIFont boldSystemFontOfSize:30];
        //        shipmentNote.frame = CGRectMake(400.0, 190.0, 360, 50);
        
        searchItem.font = [UIFont boldSystemFontOfSize:20];
        searchItem.frame = CGRectMake(200.0, 200, 360.0, 50.0);
        
        ReceiptID.font = [UIFont boldSystemFontOfSize:20];
        ReceiptID.frame = CGRectMake(200.0, 10.0, 360.0, 50.0);
        
        label2.font = [UIFont boldSystemFontOfSize:20];
        label2.frame = CGRectMake(10, 270, 90, 55);
        label11.font = [UIFont boldSystemFontOfSize:20];
        label11.frame = CGRectMake(103, 270, 90, 55);
        label3.font = [UIFont boldSystemFontOfSize:20];
        label3.frame = CGRectMake(195, 270, 90, 55);
        label4.font = [UIFont boldSystemFontOfSize:20];
        label4.frame = CGRectMake(288, 270, 90, 55);
        label5.font = [UIFont boldSystemFontOfSize:20];
        label5.frame = CGRectMake(386, 270, 110, 55);
        // label8.font = [UIFont boldSystemFontOfSize:20];
        // label8.frame = CGRectMake(494, 270, 110, 55);
        label9.font = [UIFont boldSystemFontOfSize:20];
        label9.frame = CGRectMake(504, 270, 110, 55);
        label10.font = [UIFont boldSystemFontOfSize:20];
        label10.frame = CGRectMake(624.0, 270, 110, 55);
        
        scrollView.frame = CGRectMake(10, 330, 980.0, 280.0);
        scrollView.contentSize = CGSizeMake(778, 1000);
        cartTable.frame = CGRectMake(0, 0, 750,60);
        
        label6.font = [UIFont boldSystemFontOfSize:20];
        label6.frame = CGRectMake(10.0, 670.0, 200, 55.0);
        
        label7.font = [UIFont boldSystemFontOfSize:20];
        label7.frame = CGRectMake(10.0, 700.0, 200, 55);
        
        totalQuantity.font = [UIFont boldSystemFontOfSize:20];
        totalQuantity.frame = CGRectMake(580.0, 670.0, 200, 55);
        
        totalCost.font = [UIFont boldSystemFontOfSize:20];
        totalCost.frame = CGRectMake(580.0, 700.0, 200, 55);
        
        submitBtn.frame = CGRectMake(55.0f, 800.0,300.0f, 55.0f);
        submitBtn.layer.cornerRadius = 25.0f;
        submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        cancelButton.frame = CGRectMake(425.0f, 800.0,300.0f, 55.0f);
        cancelButton.layer.cornerRadius = 25.0f;
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        normalstockTable.frame = CGRectMake(0.0, 65.0, self.view.frame.size.width, 800.0);
        
        skListTable.frame = CGRectMake(200, 200, 360,0);
        receiptIDTable.frame = CGRectMake(200.0, 60, 360, 0);
        [createReceiptView addSubview:label2];
        [createReceiptView addSubview:label3];
        [createReceiptView addSubview:label4];
        [createReceiptView addSubview:label5];
        [createReceiptView addSubview:label8];
        [createReceiptView addSubview:label9];
        [createReceiptView addSubview:label10];
        [createReceiptView addSubview:label11];
        [createReceiptView addSubview:label6];
        [createReceiptView addSubview:label7];
        [createReceiptView addSubview:totalQuantity];
        [createReceiptView addSubview:totalCost];
    }
    else {
        createReceiptView.frame = CGRectMake(0, 42, self.view.frame.size.width, self.view.frame.size.height);
        //createReceiptView.contentSize = CGSizeMake(self.view.frame.size.width + 500, 1000);
        viewReceiptView.frame = CGRectMake(0, 42, self.view.frame.size.width, self.view.frame.size.height);
        
        
        location.font = [UIFont boldSystemFontOfSize:15];
        location.frame = CGRectMake(0.0, 5.0, 150, 35);
        
        selectLocation.frame = CGRectMake(130, 2, 30, 45);
        
        locationTable.frame = CGRectMake(10.0, 30.0, 120, 0);
        
        toLocation.font = [UIFont boldSystemFontOfSize:15];
        toLocation.frame = CGRectMake(160.0, 5.0, 160, 35);
        
        deliveredBy.font = [UIFont boldSystemFontOfSize:15];
        deliveredBy.frame = CGRectMake(0.0, 45.0, 150, 35);
        
        inspectedBy.font = [UIFont boldSystemFontOfSize:15];
        inspectedBy.frame = CGRectMake(160.0, 45.0, 160, 35);
        
        date.font = [UIFont boldSystemFontOfSize:20];
        date.frame = CGRectMake( 0.0, 90.0, 220, 35);
        
        //        inspectedBy.font = [UIFont boldSystemFontOfSize:30];
        //        inspectedBy.frame = CGRectMake(10.0, 130.0, 360, 50);
        //
        //        date.font = [UIFont boldSystemFontOfSize:30];
        //        date.frame = CGRectMake(400.0, 130.0, 360, 50);
        //
        
        //
        //        shipmentNote.font = [UIFont boldSystemFontOfSize:30];
        //        shipmentNote.frame = CGRectMake(400.0, 190.0, 360, 50);
        
        searchItem.font = [UIFont boldSystemFontOfSize:17];
        searchItem.frame = CGRectMake(60.0, 135, 180, 35.0);
        
        ReceiptID.font = [UIFont boldSystemFontOfSize:17];
        ReceiptID.frame = CGRectMake(60.0, 0, 180, 35.0);
        
        label2.font = [UIFont boldSystemFontOfSize:15];
        label2.frame = CGRectMake(0, 0, 50, 35);
        label11.font = [UIFont boldSystemFontOfSize:15];
        label11.frame = CGRectMake(50, 0, 50, 35);
        label3.font = [UIFont boldSystemFontOfSize:15];
        label3.frame = CGRectMake(100, 0, 60, 35);
        label4.font = [UIFont boldSystemFontOfSize:15];
        label4.frame = CGRectMake(160, 0, 60, 35);
        label5.font = [UIFont boldSystemFontOfSize:15];
        label5.frame = CGRectMake(220, 0, 50, 35);
        // label8.font = [UIFont boldSystemFontOfSize:20];
        // label8.frame = CGRectMake(494, 270, 110, 55);
        label9.font = [UIFont boldSystemFontOfSize:15];
        label9.frame = CGRectMake(270, 0, 80, 35);
        label10.font = [UIFont boldSystemFontOfSize:15];
        label10.frame = CGRectMake(350.0, 0, 80, 35);
        
        scrollView.frame = CGRectMake(10, 175, 400.0, 150.0);
        scrollView.contentSize = CGSizeMake(600, 1000);
        cartTable.frame = CGRectMake(0, 40, 750,60);
        
        label6.font = [UIFont boldSystemFontOfSize:15];
        label6.frame = CGRectMake(10.0, 120.0, 150, 25.0);
        [label6 setBackgroundColor:[UIColor clearColor]];
        
        label7.font = [UIFont boldSystemFontOfSize:15];
        label7.frame = CGRectMake(10.0, 155.0, 150, 25);
        [label7 setBackgroundColor:[UIColor clearColor]];
        
        totalQuantity.font = [UIFont boldSystemFontOfSize:15];
        totalQuantity.frame = CGRectMake(190.0, 120.0, 120, 25);
        [totalQuantity setBackgroundColor:[UIColor clearColor]];
        
        
        totalCost.font = [UIFont boldSystemFontOfSize:15];
        totalCost.frame = CGRectMake(190.0, 155.0, 120, 25);
        [totalCost setBackgroundColor:[UIColor clearColor]];
        
        
        submitBtn.frame = CGRectMake(5.0f, 330.0,150.0f, 35.0f);
        submitBtn.layer.cornerRadius = 17.0f;
        submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        cancelButton.frame = CGRectMake(160.0f, 330.0,150.0f, 35.0f);
        cancelButton.layer.cornerRadius = 17.0f;
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        
        normalstockTable.frame = CGRectMake(0.0, 40.0, self.view.frame.size.width, 400.0);
        
        skListTable.frame = CGRectMake(200, 200, 360,0);
        receiptIDTable.frame = CGRectMake(60.0, 35, 360, 0);
        
        [scrollView addSubview:label2];
        [scrollView addSubview:label3];
        [scrollView addSubview:label4];
        [scrollView addSubview:label5];
        [scrollView addSubview:label8];
        [scrollView addSubview:label9];
        [scrollView addSubview:label10];
        [scrollView addSubview:label11];
        [scrollView addSubview:label6];
        [scrollView addSubview:label7];
        [scrollView addSubview:totalCost];
        [scrollView addSubview:totalQuantity];

    }
    
    //[self.view addSubview:mainSegmentedControl];
    //[createReceiptView addSubview:supplierID];
    // [createReceiptView addSubview:supplierName];
    [createReceiptView addSubview:location];
    [createReceiptView addSubview:selectLocation];
    [createReceiptView addSubview:locationTable];
    [createReceiptView addSubview:deliveredBy];
    [createReceiptView addSubview:inspectedBy];
    [createReceiptView addSubview:date];
    [createReceiptView addSubview:toLocation];
    // [createReceiptView addSubview:shipmentNote];
    [createReceiptView addSubview:searchItem];
    //  [createReceiptView addSubview:label12];
    [scrollView addSubview:cartTable];
    [createReceiptView addSubview:scrollView];
    [createReceiptView addSubview:submitBtn];
    [createReceiptView addSubview:cancelButton];
    [createReceiptView addSubview:skListTable];
    createReceiptView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:createReceiptView];
    viewReceiptView.backgroundColor = [UIColor blackColor];
    [viewReceiptView addSubview:ReceiptID];
    [viewReceiptView addSubview:normalstockTable];
    [viewReceiptView addSubview:receiptIDTable];
    [self.view addSubview:viewReceiptView];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
        mainSegmentedControl.frame = CGRectMake(-2, 65, 772, 60);
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
    
    [self.view addSubview:mainSegmentedControl];
    
    wareStartPoint_ = 1000;
    
    [HUD hide:YES afterDelay:1.0];

}

-(void) callRawMaterials:(NSString *)searchString{
    BOOL status = FALSE;
    rawMaterials = [[NSMutableArray alloc] init];
    skuArrayList = [[NSMutableArray alloc]init];
    
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
    
    NSDictionary *JSON;
    
    @try {
        
        SkuServiceSoapBindingResponse *response = [skuService getSkuIDUsingParameters:(SkuServiceSvc_getSkuID *)getSkuid];
        NSArray *responseBodyParts = response.bodyParts;
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[SkuServiceSvc_getSkuIDResponse class]]) {
                
                SkuServiceSvc_getSkuIDResponse *body = (SkuServiceSvc_getSkuIDResponse *)bodyPart;
                status =TRUE;
                
                printf("\nresponse=%s",[body.return_ UTF8String]);
                NSError *e;
                JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                       options: NSJSONReadingMutableContainers
                                                         error: &e];
            }
        }
        
        if (status) {
            
            NSArray *temp = [JSON objectForKey:@"skuIds"];
            
            skuArrayList = [[NSMutableArray alloc] initWithArray:temp];
            
        }
        
        
    }
    @catch (NSException *exception) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No data found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
    
    
    //[skListTable reloadData];
    
}

-(void)callReceiptIDS:(NSString *)searchString{
    BOOL status = FALSE;
    WHStockReceiptServiceSoapBinding *materialBinding = [[WHStockReceiptService WHStockReceiptServiceSoapBinding] retain];
    
    //    tns1_getStockProcurementReceiptIds *aparams = [[tns1_getStockProcurementReceiptIds alloc] init];
    //    aparams.searchCriteria = searchString;
    NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str = [time componentsSeparatedByString:@" "];
    NSString *date_ = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    
    NSMutableDictionary *receiptDetails1 = [[NSMutableDictionary alloc] init];
    [receiptDetails1 setObject:dictionary_ forKey:@"requestHeader"];
    [receiptDetails1 setObject:ReceiptID.text forKey:@"goods_receipt_ref_num"];
    [receiptDetails1 setObject:presentLocation forKey:@"receipt_location"];
    // [receiptDetails1 setObject:[NSString stringWithFormat:@"%d",startIndex] forKey:@""];
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:receiptDetails1 options:0 error:&err];
    NSString * createReceiptJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    materialBinding.logXMLInOut = YES;
    
    WHStockReceiptService_getStockReceiptIds *create_receipt = [[WHStockReceiptService_getStockReceiptIds alloc] init];
    create_receipt.searchCriteria = createReceiptJsonString;
    @try {
        WHStockReceiptServiceSoapBindingResponse *response = [materialBinding getStockReceiptIdsUsingParameters:create_receipt];
        
        NSArray *responseBodyParts = response.bodyParts;
        NSDictionary *JSON ;
        
        for (id bodyPart in responseBodyParts) {
            
            if ([bodyPart isKindOfClass:[WHStockReceiptService_getStockReceiptIdsResponse class]]) {
                
                WHStockReceiptService_getStockReceiptIdsResponse *body = (WHStockReceiptService_getStockReceiptIdsResponse *)bodyPart;
                status = TRUE;
                NSError *err;
                JSON = [[NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                        options: NSJSONReadingMutableContainers
                                                          error: &err] copy];
            }
        }
        if (status) {
            NSArray *temp =  [JSON objectForKey:@"receiptIds"];
            
            receiptIDS = [[NSMutableArray alloc] initWithArray:temp];
        }
        
    }
    @catch (NSException *exception) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No match found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    }
    
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
                    skListTable.frame = CGRectMake(200, 250, 360,240);
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
                        skListTable.frame = CGRectMake(200, 250, 360,450);
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
                [self.view bringSubviewToFront:skListTable];
                [skListTable reloadData];
                skListTable.hidden = NO;
            }
            else {
                skListTable.hidden = YES;
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
                    //            if (version >= 8.0) {
                    //                skListTable.frame = CGRectMake(40, 100, 213,100);
                    //            }
                    //            else{
                    //                skListTable.frame = CGRectMake(40, 45, 213,100);
                    //            }
                }
                
                if ([receiptIDS count] > 5) {
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        receiptIDTable.frame = CGRectMake(200, 60, 360,450);
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
                [self.view bringSubviewToFront:receiptIDTable];
                [receiptIDTable reloadData];
                receiptIDTable.hidden = NO;
            }
            else {
                receiptIDTable.hidden = YES;
            }
        }
    }
}

-(void)getListOfLocations:(id)sender {
    
    if (sender == selectLocation) {
        
        [selectLocation setEnabled:NO];
        [submitBtn setEnabled:NO];
        [cancelButton setEnabled:NO];
        
        [normalstockTable setUserInteractionEnabled:NO];
        [toLocation resignFirstResponder];
        
        wareFromlocationStartIndex = 0;
        
        [self getLocations:wareFromlocationStartIndex];
        
        // [waiterName resignFirstResponder];
        locationTable.hidden = NO;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            locationTable.frame = CGRectMake(10.0, 60.0, 360, 220);
        }
        [createReceiptView bringSubviewToFront:locationTable];
        
    }
    
}
-(void)getLocations:(int)startIndex {
    
    UtilityMasterServiceSoapBinding *utility =  [[UtilityMasterServiceSvc UtilityMasterServiceSoapBinding] retain];
    utility.logXMLInOut = YES;
    
    NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str = [time componentsSeparatedByString:@" "];
    NSString *date1 = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"Store Mobile APP",mail_,@"-",date1, nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    
    //    NSError * err;
    //    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
    //    NSString * requestHeaderString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"requestHeader", nil];
    
    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",startIndex],dictionary, nil];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
    
    NSError * err_;
    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
    NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
    
    UtilityMasterServiceSvc_getLocation *location1 = [[UtilityMasterServiceSvc_getLocation alloc] init];
    location1.locationDetails = loyaltyString;
    
    @try {
        
        UtilityMasterServiceSoapBindingResponse *response_ = [utility getLocationUsingParameters:location1];
        
        NSArray *responseBodyParts1_ = response_.bodyParts;
        NSDictionary *JSON1 = [[NSDictionary alloc] init];
        for (id bodyPart in responseBodyParts1_) {
            
            if ([bodyPart isKindOfClass:[UtilityMasterServiceSvc_getLocationResponse class]]) {
                // status = TRUE;
                UtilityMasterServiceSvc_getLocationResponse *body = (UtilityMasterServiceSvc_getLocationResponse *)bodyPart;
                printf("\nresponse=%s",[body.return_ UTF8String]);
                
                //status = body.return_;
                NSError *e;
                JSON1 = [[NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                         options: NSJSONReadingMutableContainers
                                                           error: &e] copy];
            }
        }
        
        if (![JSON1 isKindOfClass:[NSNull class]]) {
            
            
            NSDictionary *responseHeader = [JSON1 valueForKey:@"responseHeader"];
            
            if ([[responseHeader valueForKey:@"responseCode"] isEqualToString:@"0"] && [[responseHeader valueForKey:@"responseMessage"] isEqualToString:@"Location Details"]) {
                
                NSArray *locations = [JSON1 valueForKey:@"locationDetails"];
                
                for (int i=0; i < [locations count]; i++) {
                    
                    NSDictionary *locationdic = [locations objectAtIndex:i];
                    
                    [locationArr addObject:[locationdic valueForKey:@"locationId"]];
                    
                }
                
                if ([locationArr containsObject:presentLocation]) {
                    
                    [locationArr removeObject:presentLocation];
                }
                
                [locationTable reloadData];
                
            }
            else {
                
                wareFromlocationScrollValueStatus_ = YES;
                
            }
        }
    }
    @catch (NSException *exception) {
        
        
    }
    
}
- (void) segmentAction1: (id) sender  {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    mainSegmentedControl = (UISegmentedControl *)sender;
    NSInteger index = mainSegmentedControl.selectedSegmentIndex;
    
    switch (index) {
        case 0:
            createReceiptView.hidden = NO;
            viewReceiptView.hidden = YES;
            break;
        case 1:
            createReceiptView.hidden = YES;
            viewReceiptView.hidden = NO;
            wareStartIndex = 0;
            [self getAllReceiptIDS:wareStartIndex];
            [normalstockTable reloadData];
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
            return 66.0;
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
            return 100.0;
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
    else if (tableView == normalstockTable){
        return [receiptsIdsArr count];
    }
    else if (tableView == receiptIDTable){
        return [receiptIDS count];
    }
    else if (tableView == locationTable) {
        
        return [locationArr count];
    }
    else{
        return [rawMaterials count];
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
        NSString *procurementReceipt = [receiptsIdsArr objectAtIndex:indexPath.row];
        //        NSError *err;
        //        NSDictionary *procurmentDetails = [NSJSONSerialization JSONObjectWithData: [[NSString stringWithFormat:@"%@",[receiptDetails objectAtIndex:indexPath.row]] dataUsingEncoding:NSUTF8StringEncoding]
        //                                                                          options: NSJSONReadingMutableContainers
        //                                                                            error: &err];
        
        UILabel *receiptID = [[UILabel alloc] init];
        receiptID.frame = CGRectMake(10.0, 10.0, 200.0, 55.0);
        receiptID.backgroundColor = [UIColor clearColor];
        receiptID.font = [UIFont boldSystemFontOfSize:30.0];
        receiptID.textColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        receiptID.text = procurementReceipt;
        
        //        UILabel *supplier_ID = [[UILabel alloc] init];
        //        supplier_ID.frame = CGRectMake(10.0, 65.0, 200.0, 55.0);
        //        supplier_ID.font = [UIFont boldSystemFontOfSize:20.0];
        //        supplier_ID.textColor = [UIColor grayColor];
        //        supplier_ID.text = [NSString stringWithFormat:@"%@",[procurmentDetails objectForKey:@"supplier_id"]];
        //
        //        UILabel *supplier_Name = [[UILabel alloc] init];
        //        supplier_Name.frame = CGRectMake(10.0, 120.0, 200.0, 55.0);
        //        supplier_Name.font = [UIFont boldSystemFontOfSize:20.0];
        //        supplier_Name.textColor = [UIColor grayColor];
        //        supplier_Name.text = [NSString stringWithFormat:@"%@",[procurmentDetails objectForKey:@"supplier_name"]];
        
        UIImageView *statusView = [[UIImageView alloc] init];
        if ([[receiptStatusArr objectAtIndex:indexPath.row] isEqualToString:@"false"]) {
            
            statusView.backgroundColor = [UIColor clearColor];
            statusView.image = [UIImage imageNamed:@"pending.png"];
            statusView.frame = CGRectMake(700.0, 65.0, 50.0, 50.0);
        }
        
        UILabel *date_ = [[UILabel alloc] init];
        date_.frame = CGRectMake(500.0, 10.0, 200.0, 55.0);
        date_.font = [UIFont boldSystemFontOfSize:20.0];
        date_.textColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
        if ([receiptDateArr count]!=0 && [receiptDateArr objectAtIndex:indexPath.row]!=NULL ) {
            date_.text = [NSString stringWithFormat:@"%@",[receiptDateArr objectAtIndex:indexPath.row]];
        }
        
        UILabel *total = [[UILabel alloc] init];
        total.frame = CGRectMake(500.0, 100.0, 200.0, 55.0);
        total.font = [UIFont boldSystemFontOfSize:20.0];
        total.textColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
        total.text = [NSString stringWithFormat:@"%.2f",[[receiptTotalArr objectAtIndex:indexPath.row] floatValue]];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            
            receiptID.frame = CGRectMake(10.0, 10.0, 120.0, 35.0);
            receiptID.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:17.0];
            statusView.frame = CGRectMake(245.0, 40.0, 35.0, 35.0);
            date_.frame = CGRectMake(10.0, 50.0, 200.0, 35.0);
            date_.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:17.0];
            [date_ setBackgroundColor:[UIColor clearColor]];
            total.frame = CGRectMake(190.0, 10.0, 150.0, 35.0);
            total.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:17.0];
            [total setBackgroundColor:[UIColor clearColor]];
            
            
        }
        

        [hlcell setBackgroundColor:[UIColor blackColor]];
        [hlcell.contentView addSubview:receiptID];
        // [hlcell.contentView addSubview:supplier_ID];
        // [hlcell.contentView addSubview:supplier_Name];
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
        
        NSArray *temp = [rawMaterialDetails objectAtIndex:indexPath.row];
        
        UILabel *item_code = [[[UILabel alloc] init] autorelease];
        item_code.layer.borderWidth = 1.5;
        item_code.font = [UIFont systemFontOfSize:13.0];
        item_code.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        item_code.backgroundColor = [UIColor blackColor];
        item_code.textColor = [UIColor whiteColor];
        
        item_code.text = [temp objectAtIndex:0];
        item_code.textAlignment=NSTextAlignmentCenter;
        item_code.adjustsFontSizeToFitWidth = YES;
        //name.adjustsFontSizeToFitWidth = YES;
        
        UILabel *item_description = [[[UILabel alloc] init] autorelease];
        item_description.layer.borderWidth = 1.5;
        item_description.font = [UIFont systemFontOfSize:13.0];
        item_description.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        item_description.backgroundColor = [UIColor blackColor];
        item_description.textColor = [UIColor whiteColor];
        
        item_description.text = [temp objectAtIndex:1];
        item_description.textAlignment=NSTextAlignmentCenter;
        item_description.adjustsFontSizeToFitWidth = YES;
        
        UILabel *price = [[[UILabel alloc] init] autorelease];
        price.layer.borderWidth = 1.5;
        price.font = [UIFont systemFontOfSize:13.0];
        price.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        price.backgroundColor = [UIColor blackColor];
        price.text = [NSString stringWithFormat:@"%.2f",[[temp objectAtIndex:2] floatValue]];
        price.textColor = [UIColor whiteColor];
        price.textAlignment=NSTextAlignmentCenter;
        price.adjustsFontSizeToFitWidth = YES;
        
        
        UIButton *qtyButton = [[[UIButton alloc] init] autorelease];
        [qtyButton setTitle:[temp objectAtIndex:3] forState:UIControlStateNormal];
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
        cost.text = [NSString stringWithFormat:@"%.02f", [[temp objectAtIndex:4] floatValue]];
        cost.textColor = [UIColor whiteColor];
        cost.textAlignment=NSTextAlignmentCenter;
        cost.adjustsFontSizeToFitWidth = YES;
        
        UILabel *make = [[[UILabel alloc] init] autorelease];
        make.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        make.layer.borderWidth = 1.5;
        make.font = [UIFont systemFontOfSize:13.0];
        make.backgroundColor = [UIColor blackColor];
        make.text = [NSString stringWithFormat:@"%@", [temp objectAtIndex:5]];
        make.textColor = [UIColor whiteColor];
        make.textAlignment=NSTextAlignmentCenter;
        make.adjustsFontSizeToFitWidth = YES;
        
        UILabel *supplied = [[[UILabel alloc] init] autorelease];
        supplied.layer.borderWidth = 1.5;
        supplied.font = [UIFont systemFontOfSize:13.0];
        supplied.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        supplied.backgroundColor = [UIColor blackColor];
        supplied.textColor = [UIColor whiteColor];
        
        supplied.text = [NSString stringWithFormat:@"%d",[[temp objectAtIndex:6] intValue]];
        supplied.textAlignment=NSTextAlignmentCenter;
        supplied.adjustsFontSizeToFitWidth = YES;
        
        UILabel *received = [[[UILabel alloc] init] autorelease];
        received.layer.borderWidth = 1.5;
        received.font = [UIFont systemFontOfSize:13.0];
        received.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        received.backgroundColor = [UIColor blackColor];
        received.textColor = [UIColor whiteColor];
        
        received.text = [NSString stringWithFormat:@"%d",[[temp objectAtIndex:7] intValue]];
        received.textAlignment=NSTextAlignmentCenter;
        received.adjustsFontSizeToFitWidth = YES;
        
        UIButton *rejectQtyButton = [[[UIButton alloc] init] autorelease];
        [rejectQtyButton setTitle:[temp objectAtIndex:8] forState:UIControlStateNormal];
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
            //            supplied.font = [UIFont fontWithName:@"Helvetica" size:25];
            //            supplied.frame = CGRectMake(484, 0, 110, 56);
            received.font = [UIFont fontWithName:@"Helvetica" size:25];
            received.frame = CGRectMake(484, 0, 110, 56);
            //            received.font = [UIFont fontWithName:@"Helvetica" size:25];
            //            received.frame = CGRectMake(710.0, 0, 110, 56);
            rejectQtyButton.frame = CGRectMake(597.0, 0, 110, 56);
            delrowbtn.frame = CGRectMake(710.0, 10 , 40, 40);
            
        }
        else {
            
            item_code.frame = CGRectMake(5, 0, 58, 34);
            price.frame = CGRectMake(119, 0, 58, 34);
            cost.frame = CGRectMake(233, 0, 58, 34);
            delrowbtn.frame = CGRectMake(293, 3 , 25, 25);
            
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
        //[hlcell.contentView addSubview:make];
        //[hlcell .contentView addSubview:supplied];
        [hlcell.contentView addSubview:received];
        [hlcell.contentView addSubview:rejectQtyButton];
        [hlcell addSubview:delrowbtn];
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
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:25];
            }
        }
        
        hlcell.textLabel.text = [receiptIDS objectAtIndex:indexPath.row];
        hlcell.textLabel.textColor = [UIColor blackColor];
        
        return hlcell;
    }
    else if (tableView == locationTable) {
        
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
        
        hlcell.textLabel.text = [locationArr objectAtIndex:indexPath.row];
        //[hlcell setBackgroundColor:[UIColor blackColor]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.textLabel.font = [UIFont systemFontOfSize:18.0];
        [hlcell setSelectionStyle:UITableViewCellEditingStyleNone];
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
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:25];
            }
        }
        
        NSDictionary *JSON = [rawMaterials objectAtIndex:indexPath.row];
        hlcell.textLabel.text = [NSString stringWithFormat:@"%@",[JSON objectForKey:@"skuId"]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        
        return hlcell;
    }
    
}

- (void) delRow:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    [rawMaterialDetails removeObjectAtIndex:[sender tag]];
    
    wareReceiptProcurementQuantity_ = 0;
    wareReceiptProcurementMaterialCost_ = 0.0f;
    
    for (int i = 0; i < [rawMaterialDetails count]; i++) {
        NSArray *material = [rawMaterialDetails objectAtIndex:i];
        wareReceiptProcurementQuantity_ = wareReceiptProcurementQuantity_ + [[material objectAtIndex:7] intValue];
        wareReceiptProcurementMaterialCost_ = wareReceiptProcurementMaterialCost_ + ([[material objectAtIndex:2] floatValue] * [[material objectAtIndex:7] intValue]);
    }
    
    totalQuantity.text = [NSString stringWithFormat:@"%d",wareReceiptProcurementQuantity_];
    totalCost.text = [NSString stringWithFormat:@"%.2f",wareReceiptProcurementMaterialCost_];
    [cartTable reloadData];
}


-(void)changeQuantity:(UIButton *)sender{
    
    AudioServicesPlaySystemSound (soundFileObject);
    
    cartTable.userInteractionEnabled = FALSE;
    location.userInteractionEnabled = FALSE;
    deliveredBy.userInteractionEnabled = FALSE;
    inspectedBy.userInteractionEnabled = FALSE;
    submitBtn.userInteractionEnabled = FALSE;
    cancelButton.userInteractionEnabled = FALSE;
    
    NSArray *temp = [rawMaterialDetails objectAtIndex:sender.tag];
    
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
    
    wareReceiptProcurementRejectMaterialTagId_ = sender.tag;
    
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
    location.userInteractionEnabled = TRUE;
    deliveredBy.userInteractionEnabled = TRUE;
    inspectedBy.userInteractionEnabled = TRUE;
    submitBtn.userInteractionEnabled = TRUE;
    cancelButton.userInteractionEnabled = TRUE;
    
    NSString *value = [qtyField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // PhoNumber validation...
    NSString *decimalRegex = @"[0-9]+([.]([0-9]+)?)?"; // @"[0-9]+[.][0-9]+";
    NSPredicate *decimalTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalRegex];
    BOOL isNumber = [decimalTest evaluateWithObject:[qtyField text]];
    int qty = [value intValue];
    
    NSArray *temp = [rawMaterialDetails objectAtIndex:wareReceiptProcurementRejectMaterialTagId_];
    
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
        
        NSArray *finalArray = [NSArray arrayWithObjects:[temp objectAtIndex:0],[temp objectAtIndex:1],[temp objectAtIndex:2],[NSString stringWithFormat:@"%d", qty],[NSString stringWithFormat:@"%.2f",([[temp objectAtIndex:2] floatValue] * qty)],[temp objectAtIndex:5],[NSString stringWithFormat:@"%d",qty],[NSString stringWithFormat:@"%d",qty],[temp objectAtIndex:8], nil];
        
        [rawMaterialDetails replaceObjectAtIndex:wareReceiptProcurementRejectMaterialTagId_ withObject:finalArray];
        
        [cartTable reloadData];
        
        rejectQtyChangeDisplayView.hidden = YES;
        cartTable.userInteractionEnabled = TRUE;
        
        wareReceiptProcurementQuantity_ = 0;
        wareReceiptProcurementMaterialCost_ = 0.0f;
        
        for (int i = 0; i < [rawMaterialDetails count]; i++) {
            NSArray *material = [rawMaterialDetails objectAtIndex:i];
            wareReceiptProcurementQuantity_ = wareReceiptProcurementQuantity_ + [[material objectAtIndex:7] intValue];
            wareReceiptProcurementMaterialCost_ = wareReceiptProcurementMaterialCost_ + ([[material objectAtIndex:2] floatValue] * [[material objectAtIndex:7] intValue]);
        }
        
        totalQuantity.text = [NSString stringWithFormat:@"%d",wareReceiptProcurementQuantity_];
        totalCost.text = [NSString stringWithFormat:@"%.2f",wareReceiptProcurementMaterialCost_];
    }
}

-(void) changeRejectQuantity:(UIButton *)sender{
    
    AudioServicesPlaySystemSound (soundFileObject);
    
    cartTable.userInteractionEnabled = FALSE;
    location.userInteractionEnabled = FALSE;
    deliveredBy.userInteractionEnabled = FALSE;
    inspectedBy.userInteractionEnabled = FALSE;
    submitBtn.userInteractionEnabled = FALSE;
    cancelButton.userInteractionEnabled = FALSE;
    
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
    
    wareReceiptProcurementRejectMaterialTagId_ = sender.tag;
    
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
    location.userInteractionEnabled = TRUE;
    deliveredBy.userInteractionEnabled = TRUE;
    inspectedBy.userInteractionEnabled = TRUE;
    submitBtn.userInteractionEnabled = TRUE;
    cancelButton.userInteractionEnabled = TRUE;
    //[qtyCancelButton release];
}

-(IBAction)rejectQtyCancelButtonPressed:(id)sender{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    qtyChangeDisplayView.hidden = YES;
    cartTable.userInteractionEnabled = TRUE;
    location.userInteractionEnabled = TRUE;
    deliveredBy.userInteractionEnabled = TRUE;
    inspectedBy.userInteractionEnabled = TRUE;
    submitBtn.userInteractionEnabled = TRUE;
    cancelButton.userInteractionEnabled = TRUE;
    //[rejectCancelButton release];
}

- (IBAction)rejectQtyOkButtonPressed:(id)sender {
    
    AudioServicesPlaySystemSound (soundFileObject);
    [rejectQtyField resignFirstResponder];
    cartTable.userInteractionEnabled = TRUE;
    location.userInteractionEnabled = TRUE;
    deliveredBy.userInteractionEnabled = TRUE;
    inspectedBy.userInteractionEnabled = TRUE;
    submitBtn.userInteractionEnabled = TRUE;
    cancelButton.userInteractionEnabled = TRUE;
    
    NSString *value = [rejectQtyField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // PhoNumber validation...
    NSString *decimalRegex = @"[0-9]+([.]([0-9]+)?)?"; // @"[0-9]+[.][0-9]+";
    NSPredicate *decimalTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalRegex];
    BOOL isNumber = [decimalTest evaluateWithObject:[rejectQtyField text]];
    int qty = [value intValue];
    
    NSArray *temp = [rawMaterialDetails objectAtIndex:wareReceiptProcurementRejectMaterialTagId_];
    
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
    else if([rejectQtyField.text isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Valid Quantity." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        rejectQtyField.text = nil;
    }
    else{
        
        int received = [[temp objectAtIndex:3] intValue] - qty;
        
        NSArray *finalArray = [NSArray arrayWithObjects:[temp objectAtIndex:0],[temp objectAtIndex:1],[temp objectAtIndex:2],[temp objectAtIndex:3],[NSString stringWithFormat:@"%.2f",(received * [[temp objectAtIndex:2] floatValue])],[temp objectAtIndex:5],[temp objectAtIndex:6],[NSString stringWithFormat:@"%d",received],[NSString stringWithFormat:@"%d",qty], nil];
        
        [rawMaterialDetails replaceObjectAtIndex:wareReceiptProcurementRejectMaterialTagId_ withObject:finalArray];
        
        [cartTable reloadData];
        
        qtyChangeDisplayView.hidden = YES;
        cartTable.userInteractionEnabled = TRUE;
        
        wareReceiptProcurementQuantity_ = 0;
        wareReceiptProcurementMaterialCost_ = 0.0f;
        
        for (int i = 0; i < [rawMaterialDetails count]; i++) {
            NSArray *material = [rawMaterialDetails objectAtIndex:i];
            wareReceiptProcurementQuantity_ = wareReceiptProcurementQuantity_ + [[material objectAtIndex:7] intValue];
            wareReceiptProcurementMaterialCost_ = wareReceiptProcurementMaterialCost_ + ([[material objectAtIndex:2] floatValue] * [[material objectAtIndex:7] intValue]);
        }
        
        totalQuantity.text = [NSString stringWithFormat:@"%d",wareReceiptProcurementQuantity_];
        totalCost.text = [NSString stringWithFormat:@"%.2f",wareReceiptProcurementMaterialCost_];
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
        
        NSDictionary *skuId = [rawMaterials objectAtIndex:indexPath.row];
        
        [self callRawMaterialDetails:[NSString stringWithFormat:@"%@",[skuId objectForKey:@"skuId"]]];
    }
    else if (tableView == normalstockTable) {
        NSString *receiptID = [receiptsIdsArr objectAtIndex:indexPath.row];
        self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
        self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
        
        mainSegmentedControl.selectedSegmentIndex = 0;
        //        viewReceiptView.hidden = YES;
        
        OpenWareHouseReceipt *viewReceipt = [[OpenWareHouseReceipt alloc] initWithReceiptID:receiptID];
        [self.navigationController pushViewController:viewReceipt animated:YES];
    }
    else if (tableView == receiptIDTable){
        NSString *receiptID = [receiptIDS objectAtIndex:indexPath.row];
        self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
        self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
        receiptIDTable.hidden = YES;
        mainSegmentedControl.selectedSegmentIndex = 0;
        OpenWareHouseReceipt *viewReceipt = [[OpenWareHouseReceipt alloc] initWithReceiptID:receiptID];
        [self.navigationController pushViewController:viewReceipt animated:YES];
    }
    else if (tableView == locationTable) {
        
        location.text = @"";
        [location resignFirstResponder];
        locationTable.hidden = YES;
        location.text = [locationArr objectAtIndex:indexPath.row];
        [normalstockTable setUserInteractionEnabled:YES];
        [selectLocation setEnabled:YES];
        [submitBtn setEnabled:YES];
        [cancelButton setEnabled:YES];
        [locationArr removeAllObjects];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == normalstockTable) {
        
        NSInteger lastSectionIndex = [tableView numberOfSections] - 1;
        NSInteger lastRowIndex = [tableView numberOfRowsInSection:lastSectionIndex] - 1;
        if ((indexPath.section == lastSectionIndex) && (indexPath.row == lastRowIndex)) {
            // This is the last cell
            if (!wareScrollValueStatus_) {
                wareStartIndex = wareStartIndex + [receiptsIdsArr count];
                [self getAllReceiptIDS:wareStartIndex];
                [normalstockTable reloadData];
            }
            else {
                
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
    //    else if (tableView == locationTable) {
    //
    //        NSInteger lastSectionIndex = [tableView numberOfSections] - 1;
    //        NSInteger lastRowIndex = [tableView numberOfRowsInSection:lastSectionIndex] - 1;
    //        if ((indexPath.section == lastSectionIndex) && (indexPath.row == lastRowIndex)) {
    //            // This is the last cell
    //            if (!fromlocationScrollValueStatus_) {
    //
    //                fromlocationStartIndex = fromlocationStartIndex + [locationArr count];
    //                [self getLocations:fromlocationStartIndex];
    //                [locationTable reloadData];
    //            }
    //            else {
    //
    //                dataStatus = [[[UILabel alloc] init] autorelease];
    //                dataStatus.text = @"No More locations To Load";
    //                dataStatus.layer.masksToBounds = YES;
    //                dataStatus.numberOfLines = 2;
    //                [dataStatus setTextAlignment:NSTextAlignmentLeft];
    //                dataStatus.font = [UIFont boldSystemFontOfSize:25.0];
    //                dataStatus.textColor = [UIColor redColor];
    //
    //                dataStatus.frame = CGRectMake(200.0, 610.0, 400.0, 50.0);
    //
    //                [self.view addSubview:dataStatus];
    //
    //                [self fadein];
    //            }
    //        }
    //    }
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


-(void) getAllReceiptIDS:(int)startPoint {
    
    //    StockReceiptServiceSoapBinding *materialBinding = [[StockReceiptServiceSvc StockReceiptServiceSoapBinding] retain];
    //
    //    tns1_getStockProcurementReceipts *aparams = [[tns1_getStockProcurementReceipts alloc] init];
    //    aparams.start = [NSString stringWithFormat:@"%d",startPoint];
    //
    //    //    StockReceiptServiceSvc_getStockProcurementReceipts *aParams = [[StockReceiptServiceSvc_getStockProcurementReceipts alloc] init];
    //    //    aParams.start = [NSString stringWithFormat:@"%d",startPoint];
    //
    //
    //    StockReceiptServiceSoapBindingResponse *response = [materialBinding getStockProcurementReceiptsUsingParameters:(tns1_getStockProcurementReceipts *)aparams];
    //    NSArray *responseBodyParts = response.bodyParts;
    //    NSDictionary *JSONData;
    //
    //    for (id bodyPart in responseBodyParts) {
    //        if ([bodyPart isKindOfClass:[tns1_getStockProcurementReceiptsResponse class]]) {
    //            tns1_getStockProcurementReceiptsResponse *body = (tns1_getStockProcurementReceiptsResponse *)bodyPart;
    //
    //            NSError *err;
    //            JSONData = [[NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
    //                                                        options: NSJSONReadingMutableContainers
    //                                                          error: &err] copy];
    //            JSON_ = [JSONData copy];
    //        }
    //    }
    
    BOOL status = FALSE;
    NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str = [time componentsSeparatedByString:@" "];
    NSString *date_ = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    
    NSMutableDictionary *receiptDetails1 = [[NSMutableDictionary alloc] init];
    [receiptDetails1 setObject:dictionary_ forKey:@"requestHeader"];
    [receiptDetails1 setObject:[NSString stringWithFormat:@"%d",wareStartIndex] forKey:@"startIndex"];
    [receiptDetails1 setObject:presentLocation forKey:@"receipt_location"];
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:receiptDetails1 options:0 error:&err];
    NSString * createReceiptJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    WHStockReceiptServiceSoapBinding *materialBinding = [[WHStockReceiptService WHStockReceiptServiceSoapBinding] retain];
    
    materialBinding.logXMLInOut = YES;
    
    WHStockReceiptService_getStockReceipts *create_receipt = [[WHStockReceiptService_getStockReceipts alloc] init];
    create_receipt.searchCriteria = createReceiptJsonString;
    
    NSDictionary *json1;
    NSError *e;
    @try {
        WHStockReceiptServiceSoapBindingResponse *response = [materialBinding getStockReceiptsUsingParameters:create_receipt];
        NSArray *responseBodyParts1 = response.bodyParts;
        
        for (id bodyPart in responseBodyParts1) {
            
            if ([bodyPart isKindOfClass:[WHStockReceiptService_getStockReceiptsResponse class]]) {
                
                
                [HUD setHidden:YES];
                status = TRUE;
                WHStockReceiptService_getStockReceiptsResponse *body = (WHStockReceiptService_getStockReceiptsResponse *)bodyPart;
                printf("\nresponse=%s",[body.return_ UTF8String]);
                
                
                json1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                        options: NSJSONReadingMutableContainers
                                                          error: &e];
                
            }
        }
        if (status) {
            
            NSDictionary *responseDic = [json1 objectForKey:@"responseHeader"];
            if ([[responseDic valueForKey:@"responseCode"] isEqualToString:@"0"] && [[responseDic valueForKey:@"responseMessage"]isEqualToString:@"Success"]) {
                
                NSArray *arr = [json1 objectForKey:@"receipts"];
                
                if ([arr count] == 0) {
                    wareScrollValueStatus_ = YES;
                }
                
                NSMutableDictionary *receiptDtlsDic = [[NSMutableDictionary alloc] init];
                
                for (int i=0; i<[arr count]; i++) {
                    
                    receiptDtlsDic = [arr objectAtIndex:i];
                    NSLog(@"%@",[receiptDtlsDic valueForKey:@"Delivery_date"]);
                    if (![[NSString stringWithFormat:@"%@",[receiptDtlsDic valueForKey:@"Delivery_date"]] isEqualToString:@"(null)"]) {
                        if (![receiptsIdsArr containsObject:[receiptDtlsDic valueForKey:@"goods_receipt_ref_num"]]) {
                            [receiptsIdsArr addObject:[receiptDtlsDic valueForKey:@"goods_receipt_ref_num"]];
                            [receiptStatusArr addObject:[receiptDtlsDic valueForKey:@"status"]];
                            [receiptTotalArr addObject:[receiptDtlsDic valueForKey:@"grand_total"]];
                            [receiptDateArr addObject:[receiptDtlsDic valueForKey:@"Delivery_date"]];
                            [receiptDeliveredByArr addObject:[receiptDtlsDic valueForKey:@"delivered_by"]];
                        }
                        
                    }
                    else{
                        if (![receiptsIdsArr containsObject:[receiptDtlsDic valueForKey:@"goods_receipt_ref_num"]]) {
                            [receiptsIdsArr addObject:[receiptDtlsDic valueForKey:@"goods_receipt_ref_num"]];
                            [receiptStatusArr addObject:[receiptDtlsDic valueForKey:@"status"]];
                            [receiptTotalArr addObject:[receiptDtlsDic valueForKey:@"grand_total"]];
                            [receiptDateArr addObject:@"N/A"];
                            [receiptDeliveredByArr addObject:[receiptDtlsDic valueForKey:@"delivered_by"]];
                        }
                       
                    }
                }
            }
            
        }
        
    }
    @catch (NSException *exception) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Failed to get the receipts" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
    
    //    NSArray *allReceiptIDS = [[JSON_ allKeys] copy];
    //    if ([allReceiptIDS count] == 0) {
    //        scrollValueStatus_ = YES;
    //    }
    //    NSArray *allReceiptIDDetails = [[JSON_ allValues] copy];
    //    for (int i = 0; i < [allReceiptIDS count]; i++) {
    //        [procurementReceipts addObject:[allReceiptIDS objectAtIndex:i]];
    //        [procuremnetReceiptDetails addObject:[allReceiptIDDetails objectAtIndex:i]];
    //    }
    
    //[HUD hide:YES afterDelay:1.0];
    
}

-(void)submitButtonPressed {
    AudioServicesPlaySystemSound (soundFileObject);
    // NSString *supplierValue = [supplierID.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //  NSString *supplierNameValue = [supplierName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *locationValue = [location.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *deliveredByValue = [deliveredBy.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //  NSString *poreferenceValue = [poReference.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //  NSString *shipmentValue = [shipmentNote.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *inspectedValue = [inspectedBy.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([rawMaterialDetails count] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please add items to cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else if ([locationValue length] == 0 || [deliveredByValue length] == 0 || [inspectedValue length] == 0){
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
        
        NSMutableArray *itemcode = [[NSMutableArray alloc] init];
        NSMutableArray *desc = [[NSMutableArray alloc] init];
        NSMutableArray *price = [[NSMutableArray alloc] init];
        NSMutableArray *max_qty = [[NSMutableArray alloc] init];
        NSMutableArray *cost = [[NSMutableArray alloc] init];
        NSMutableArray *make = [[NSMutableArray alloc] init];
        NSMutableArray *supplied = [[NSMutableArray alloc] init];
        NSMutableArray *received = [[NSMutableArray alloc] init];
        NSMutableArray *rejected = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < [rawMaterialDetails count]; i++) {
            NSArray *temp = [rawMaterialDetails objectAtIndex:i];
            [itemcode addObject:[temp objectAtIndex:0]];
            [desc addObject:[temp objectAtIndex:1]];
            [price addObject:[temp objectAtIndex:2]];
            [max_qty addObject:[temp objectAtIndex:3]];
            [cost addObject:[temp objectAtIndex:4]];
            [make addObject:[temp objectAtIndex:5]];
            [supplied addObject:[temp objectAtIndex:6]];
            [received addObject:[temp objectAtIndex:7]];
            [rejected addObject:[temp objectAtIndex:8]];
        }
        
        
        NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *temp1 = [[NSMutableDictionary alloc]init];
        NSMutableArray *temparr = [[NSMutableArray alloc]init];
        NSDictionary *dic = [[NSDictionary alloc] init];
        
        NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        NSArray *str = [time componentsSeparatedByString:@" "];
        NSString *date_ = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
        
        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
        
        NSMutableDictionary *receiptDetails1 = [[NSMutableDictionary alloc] init];
        [receiptDetails1 setObject:dictionary_ forKey:@"requestHeader"];
        
        [receiptDetails1 setObject:location.text forKey:@"shipped_from"];
        [receiptDetails1 setObject:presentLocation forKey:@"receipt_location"];
        [receiptDetails1 setObject:deliveredBy.text forKey:@"delivered_by"];
        [receiptDetails1 setObject:date.text forKey:@"deliveryDate"];
        [receiptDetails1 setObject:@"CID8995420" forKey:@"customerId"];
        [receiptDetails1 setObject:@"" forKey:@"Goods_Request_Ref"];
        [receiptDetails1 setObject:totalCost.text forKey:@"receipt_total"];
        [receiptDetails1 setObject:totalQuantity.text forKey:@"receipt_total_qty"];
        [receiptDetails1 setObject:@"technolabs" forKey:@"Received_by"];
        [receiptDetails1 setObject:inspectedBy.text forKey:@"InspectedBy"];
        [receiptDetails1 setObject:totalCost.text forKey:@"grand_total"];
        [receiptDetails1 setObject:totalCost.text forKey:@"sub_total"];
        [receiptDetails1 setObject:@"true" forKey:@"status"];
        
        
        //    [orderDetails setObject:arr forKey:@"items"];
        //    [orderDetails setObject:qtyArr forKey:@"quantity"];
        //    [orderDetails setObject:priceArr forKey:@"price"];
        //    [orderDetails setObject:costArr forKey:@"cost"];
        
        
        for (int i=0; i < [itemcode count]; i++) {
            
            [temp setObject:[itemcode objectAtIndex:i] forKey:@"item"];
            [temp setObject:[desc objectAtIndex:i] forKey:@"description"];
            [temp setObject:[price objectAtIndex:i] forKey:@"price"];
            [temp setObject:[max_qty objectAtIndex:i] forKey:@"quantity"];
            [temp setObject:[cost objectAtIndex:i] forKey:@"cost"];
            [temp setObject:[supplied objectAtIndex:i] forKey:@"supplied"];
            [temp setObject:[received objectAtIndex:i] forKey:@"recieved"];
            [temp setObject:[rejected objectAtIndex:i] forKey:@"rejected"];
            
            
            dic = [temp copy];
            
            [temp1 setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
            
            [temparr addObject:[temp1 valueForKey:[NSString stringWithFormat:@"%d",i]]];
            
        }
        
        [receiptDetails1 setObject:temparr forKey:@"reciptDetails"];
        
        //        NSError * err;
        //        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:orderDetails options:0 error:&err];
        //        NSString * orderJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        //        NSArray *keys = [NSArray arrayWithObjects:@"receipt_ref_num", @"receipt_total_qty",@"sub_total",@"gst",@"grand_total",@"supplier_id",@"supplier_name",@"location",@"delivered_by",@"date",@"po_reference",@"shipment_note",@"inspected_by",@"itemCode",@"itemDescription",@"pack",@"price",@"cost",@"supplied",@"received",@"rejected",@"make",@"status", nil];
        //
        //        NSArray *objects = [NSArray arrayWithObjects:@"", totalQuantity.text,totalCost.text,@"0",totalCost.text,supplierID.text,supplierName.text,location.text,deliveredBy.text,date.text, poReference.text,shipmentNote.text,inspectedBy.text,itemcode,desc,max_qty,price,cost,supplied,received,rejected,make,@"true", nil];
        //        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:receiptDetails1 options:0 error:&err];
        NSString * createReceiptJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WHStockReceiptServiceSoapBinding *materialBinding = [[WHStockReceiptService WHStockReceiptServiceSoapBinding] retain];
        
        materialBinding.logXMLInOut = YES;
        
        WHStockReceiptService_createStockReciept *create_receipt = [[WHStockReceiptService_createStockReciept alloc] init];
        create_receipt.stockRecieptDetails = createReceiptJsonString;
        
        WHStockReceiptServiceSoapBindingResponse *response = [materialBinding createStockRecieptUsingParameters:create_receipt];
        NSArray *responseBodyParts1 = response.bodyParts;
        
        for (id bodyPart in responseBodyParts1) {
            
            if ([bodyPart isKindOfClass:[WHStockReceiptService_createStockRecieptResponse class]]) {
                
                
                [HUD_ setHidden:YES];
                WHStockReceiptService_createStockRecieptResponse *body = (WHStockReceiptService_createStockRecieptResponse *)bodyPart;
                printf("\nresponse=%s",[body.return_ UTF8String]);
                
                // status = body.return_;
                NSError *e;
                NSDictionary *json1;
                
                json1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                        options: NSJSONReadingMutableContainers
                                                          error: &e];
                
                if (json1!=NULL) {
                    
                    wareJSON_1 = [json1 objectForKey:@"responseHeader"];
                    if ([[wareJSON_1 objectForKey:@"responseMessage"] isEqualToString:@"successfully inserted"] && [[wareJSON_1 objectForKey:@"responseCode"] isEqualToString:@"0"]) {
                        
                        NSString *receiptID = [json1 objectForKey:@"receiptid"];
                        wareReceipt_ = [receiptID copy];
                        UIAlertView *successAlertView  = [[UIAlertView alloc] init];
                        [successAlertView setDelegate:self];
                        [successAlertView setTitle:@"Material Transfer Receipt Submitted Successfully"];
                        [successAlertView setMessage:[NSString stringWithFormat:@"%@%@",@"Receipt ID : ",receiptID]];
                        [successAlertView addButtonWithTitle:@"OPEN RECEIPT"];
                        [successAlertView addButtonWithTitle:@"NEW RECEIPT"];
                        
                        [successAlertView show];
                        
                        [HUD_ setHidden:YES];
                        [HUD_ release];
                        SystemSoundID	soundFileObject1;
                        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
                        self.soundFileURLRef = (CFURLRef) [tapSound retain];
                        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                        AudioServicesPlaySystemSound (soundFileObject1);
                        
                    }
                    else {
                        SystemSoundID	soundFileObject1;
                        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
                        self.soundFileURLRef = (CFURLRef) [tapSound retain];
                        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                        AudioServicesPlaySystemSound (soundFileObject1);
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Receipt Submission Failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                        [alert release];
                    }
                    
                }
                else{
                    SystemSoundID	soundFileObject1;
                    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
                    self.soundFileURLRef = (CFURLRef) [tapSound retain];
                    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                    AudioServicesPlaySystemSound (soundFileObject1);
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Receipt Submission Failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                }
            }
        }
        
        
        //        StockReceiptServiceSoapBinding *materialBinding = [[StockReceiptServiceSvc StockReceiptServiceSoapBinding] retain];
        //
        //        tns1_createNewStockProcurementReceipt *aparams = [[tns1_createNewStockProcurementReceipt alloc] init];
        //        aparams.procurement_details = createReceiptJsonString;
        //
        //        StockReceiptServiceSoapBindingResponse *response = [materialBinding createNewStockProcurementReceiptUsingParameters:(tns1_createNewStockProcurementReceipt *)aparams];
        //        NSArray *responseBodyParts = response.bodyParts;
        
        //        for (id bodyPart in responseBodyParts) {
        //            if ([bodyPart isKindOfClass:[tns1_createNewStockProcurementReceiptResponse class]]) {
        //                tns1_createNewStockProcurementReceiptResponse *body = (tns1_createNewStockProcurementReceiptResponse *)bodyPart;
        //                printf("\nresponse=%s",[body.return_ UTF8String]);
        //
        //                if (body.return_ != NULL) {
        //                    NSError *e;
        //                    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
        //                                                                         options: NSJSONReadingMutableContainers
        //                                                                           error: &e];
        //                    NSString *receiptID = [JSON objectForKey:@"receipt_id"];
        //                    receipt = [receiptID copy];
        //                    UIAlertView *successAlertView  = [[UIAlertView alloc] init];
        //                    [successAlertView setDelegate:self];
        //                    [successAlertView setTitle:@"Procurement Receipt Created Successfully"];
        //                    [successAlertView setMessage:[NSString stringWithFormat:@"%@%@",@"Receipt ID : ",receiptID]];
        //                    [successAlertView addButtonWithTitle:@"OPEN RECEIPT"];
        //                    [successAlertView addButtonWithTitle:@"NEW RECEIPT"];
        //
        //                    [successAlertView show];
        //
        //                    [HUD_ setHidden:YES];
        //                    [HUD_ release];
        //                }
        //                else{
        //                    [HUD_ setHidden:YES];
        //                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed To create Receipt" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //                    [alert show];
        //                    [alert release];
        //                }
        //
        //            }
        //            else{
        //                [HUD_ setHidden:YES];
        //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed To create Receipt" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //                [alert show];
        //                [alert release];
        //            }
        //        }
        
        [HUD_ setHidden:YES];
    }
}

-(void)cancelButtonPressed {
    AudioServicesPlaySystemSound (soundFileObject);
    
    if ([rawMaterialDetails count] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please add items to cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    //    else if ([locationValue length] == 0 || [deliveredByValue length] == 0 || [inspectedValue length] == 0){
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
        
        for (int i = 0; i < [rawMaterialDetails count]; i++) {
            NSArray *temp = [rawMaterialDetails objectAtIndex:i];
            [itemcode addObject:[temp objectAtIndex:0]];
            [desc addObject:[temp objectAtIndex:1]];
            [price addObject:[temp objectAtIndex:2]];
            [max_qty addObject:[temp objectAtIndex:3]];
            [cost addObject:[temp objectAtIndex:4]];
            [make addObject:[temp objectAtIndex:5]];
            [supplied addObject:[temp objectAtIndex:6]];
            [received addObject:[temp objectAtIndex:7]];
            [rejected addObject:[temp objectAtIndex:8]];
        }
        
        
        NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *temp1 = [[NSMutableDictionary alloc]init];
        NSMutableArray *temparr = [[NSMutableArray alloc]init];
        NSDictionary *dic = [[NSDictionary alloc] init];
        
        NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        NSArray *str = [time componentsSeparatedByString:@" "];
        NSString *date_ = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
        
        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
        
        NSMutableDictionary *receiptDetails1 = [[NSMutableDictionary alloc] init];
        [receiptDetails1 setObject:dictionary_ forKey:@"requestHeader"];
        
        [receiptDetails1 setObject:location.text forKey:@"shipped_from"];
        [receiptDetails1 setObject:presentLocation forKey:@"receipt_location"];
        [receiptDetails1 setObject:deliveredBy.text forKey:@"delivered_by"];
        [receiptDetails1 setObject:date.text forKey:@"deliveryDate"];
        [receiptDetails1 setObject:@"CID8995420" forKey:@"customerId"];
        [receiptDetails1 setObject:@"" forKey:@"Goods_Request_Ref"];
        [receiptDetails1 setObject:totalCost.text forKey:@"receipt_total"];
        [receiptDetails1 setObject:totalQuantity.text forKey:@"receipt_total_qty"];
        [receiptDetails1 setObject:@"technolabs" forKey:@"Received_by"];
        [receiptDetails1 setObject:inspectedBy.text forKey:@"InspectedBy"];
        [receiptDetails1 setObject:totalCost.text forKey:@"grand_total"];
        [receiptDetails1 setObject:totalCost.text forKey:@"sub_total"];
        [receiptDetails1 setObject:@"false" forKey:@"status"];
        
        
        //    [orderDetails setObject:arr forKey:@"items"];
        //    [orderDetails setObject:qtyArr forKey:@"quantity"];
        //    [orderDetails setObject:priceArr forKey:@"price"];
        //    [orderDetails setObject:costArr forKey:@"cost"];
        
        
        for (int i=0; i < [itemcode count]; i++) {
            
            [temp setObject:[itemcode objectAtIndex:i] forKey:@"item"];
            [temp setObject:[desc objectAtIndex:i] forKey:@"description"];
            [temp setObject:[price objectAtIndex:i] forKey:@"price"];
            [temp setObject:[max_qty objectAtIndex:i] forKey:@"quantity"];
            [temp setObject:[cost objectAtIndex:i] forKey:@"cost"];
            [temp setObject:[supplied objectAtIndex:i] forKey:@"supplied"];
            [temp setObject:[received objectAtIndex:i] forKey:@"recieved"];
            [temp setObject:[rejected objectAtIndex:i] forKey:@"rejected"];
            
            
            dic = [temp copy];
            
            [temp1 setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
            
            [temparr addObject:[temp1 valueForKey:[NSString stringWithFormat:@"%d",i]]];
            
        }
        
        [receiptDetails1 setObject:temparr forKey:@"reciptDetails"];
        
        //        NSError * err;
        //        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:orderDetails options:0 error:&err];
        //        NSString * orderJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        //        NSArray *keys = [NSArray arrayWithObjects:@"receipt_ref_num", @"receipt_total_qty",@"sub_total",@"gst",@"grand_total",@"supplier_id",@"supplier_name",@"location",@"delivered_by",@"date",@"po_reference",@"shipment_note",@"inspected_by",@"itemCode",@"itemDescription",@"pack",@"price",@"cost",@"supplied",@"received",@"rejected",@"make",@"status", nil];
        //
        //        NSArray *objects = [NSArray arrayWithObjects:@"", totalQuantity.text,totalCost.text,@"0",totalCost.text,supplierID.text,supplierName.text,location.text,deliveredBy.text,date.text, poReference.text,shipmentNote.text,inspectedBy.text,itemcode,desc,max_qty,price,cost,supplied,received,rejected,make,@"true", nil];
        //        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:receiptDetails1 options:0 error:&err];
        NSString * createReceiptJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WHStockReceiptServiceSoapBinding *materialBinding = [[WHStockReceiptService WHStockReceiptServiceSoapBinding] retain];
        
        materialBinding.logXMLInOut = YES;
        
        WHStockReceiptService_createStockReciept *create_receipt = [[WHStockReceiptService_createStockReciept alloc] init];
        create_receipt.stockRecieptDetails = createReceiptJsonString;
        
        WHStockReceiptServiceSoapBindingResponse *response = [materialBinding createStockRecieptUsingParameters:create_receipt];
        NSArray *responseBodyParts1 = response.bodyParts;
        
        for (id bodyPart in responseBodyParts1) {
            
            if ([bodyPart isKindOfClass:[WHStockReceiptService_createStockRecieptResponse class]]) {
                
                
                [HUD_ setHidden:YES];
                WHStockReceiptService_createStockRecieptResponse *body = (WHStockReceiptService_createStockRecieptResponse *)bodyPart;
                printf("\nresponse=%s",[body.return_ UTF8String]);
                
                // status = body.return_;
                NSError *e;
                NSDictionary *json1;
                
                json1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                        options: NSJSONReadingMutableContainers
                                                          error: &e];
                
                if (json1!=NULL) {
                    
                    wareJSON_1 = [json1 objectForKey:@"responseHeader"];
                    if ([[wareJSON_1 objectForKey:@"responseMessage"] isEqualToString:@"successfully inserted"] && [[wareJSON_1 objectForKey:@"responseCode"]isEqualToString:@"0"]) {
                        SystemSoundID	soundFileObject1;
                        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
                        self.soundFileURLRef = (CFURLRef) [tapSound retain];
                        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                        AudioServicesPlaySystemSound (soundFileObject1);
                        
                        NSString *receiptID = [json1 objectForKey:@"receiptid"];
                        wareReceipt_ = [receiptID copy];
                        UIAlertView *successAlertView  = [[UIAlertView alloc] init];
                        [successAlertView setDelegate:self];
                        [successAlertView setTitle:@"Material Transfer Receipt Saved Successfully"];
                        [successAlertView setMessage:[NSString stringWithFormat:@"%@%@",@"Receipt ID : ",receiptID]];
                        [successAlertView addButtonWithTitle:@"OPEN RECEIPT"];
                        [successAlertView addButtonWithTitle:@"NEW RECEIPT"];
                        
                        [successAlertView show];
                        
                        [HUD_ setHidden:YES];
                        [HUD_ release];
                        
                        
                    }
                    else {
                        SystemSoundID	soundFileObject1;
                        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
                        self.soundFileURLRef = (CFURLRef) [tapSound retain];
                        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                        AudioServicesPlaySystemSound (soundFileObject1);
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Receipt Saving Failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                        [alert release];
                    }
                    
                }
                else{
                    SystemSoundID	soundFileObject1;
                    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
                    self.soundFileURLRef = (CFURLRef) [tapSound retain];
                    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                    AudioServicesPlaySystemSound (soundFileObject1);
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Receipt Saving Failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                }
            }
        }
        
        
        //        StockReceiptServiceSoapBinding *materialBinding = [[StockReceiptServiceSvc StockReceiptServiceSoapBinding] retain];
        //
        //        tns1_createNewStockProcurementReceipt *aparams = [[tns1_createNewStockProcurementReceipt alloc] init];
        //        aparams.procurement_details = createReceiptJsonString;
        //
        //        StockReceiptServiceSoapBindingResponse *response = [materialBinding createNewStockProcurementReceiptUsingParameters:(tns1_createNewStockProcurementReceipt *)aparams];
        //        NSArray *responseBodyParts = response.bodyParts;
        
        //        for (id bodyPart in responseBodyParts) {
        //            if ([bodyPart isKindOfClass:[tns1_createNewStockProcurementReceiptResponse class]]) {
        //                tns1_createNewStockProcurementReceiptResponse *body = (tns1_createNewStockProcurementReceiptResponse *)bodyPart;
        //                printf("\nresponse=%s",[body.return_ UTF8String]);
        //
        //                if (body.return_ != NULL) {
        //                    NSError *e;
        //                    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
        //                                                                         options: NSJSONReadingMutableContainers
        //                                                                           error: &e];
        //                    NSString *receiptID = [JSON objectForKey:@"receipt_id"];
        //                    receipt = [receiptID copy];
        //                    UIAlertView *successAlertView  = [[UIAlertView alloc] init];
        //                    [successAlertView setDelegate:self];
        //                    [successAlertView setTitle:@"Procurement Receipt Created Successfully"];
        //                    [successAlertView setMessage:[NSString stringWithFormat:@"%@%@",@"Receipt ID : ",receiptID]];
        //                    [successAlertView addButtonWithTitle:@"OPEN RECEIPT"];
        //                    [successAlertView addButtonWithTitle:@"NEW RECEIPT"];
        //
        //                    [successAlertView show];
        //
        //                    [HUD_ setHidden:YES];
        //                    [HUD_ release];
        //                }
        //                else{
        //                    [HUD_ setHidden:YES];
        //                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed To create Receipt" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //                    [alert show];
        //                    [alert release];
        //                }
        //
        //            }
        //            else{
        //                [HUD_ setHidden:YES];
        //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed To create Receipt" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //                [alert show];
        //                [alert release];
        //            }
        //        }
        
        [HUD_ setHidden:YES];
        supplierID.text = @"";
        supplierName.text = @"";
        location.text = @"";
        deliveredBy.text = @"";
        inspectedBy.text = @"";
        //poReference.text = @"";
        shipmentNote.text = @"";
        
        [rawMaterials removeAllObjects];
        [rawMaterialDetails removeAllObjects];
        [cartTable reloadData];
        totalCost.text = @"0.0";
        totalQuantity.text = @"0";
    }
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    HUD.labelText = @"Loading Please Wait..";
//    [HUD setHidden:NO];
//
//    startPoint = startPoint + ([procurementReceipts count] + 1);
//
//    [self getAllReceiptIDS:startPoint];
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
//        startPoint = startPoint + [procurementReceipts count];
//
//        [self getAllReceiptIDS:startPoint];
//
//        [normalstockTable reloadData];
//
//    }
//}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView_{
//
//    if (!scrollValueStatus_) {
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
//            startIndex = startIndex + [receiptsIdsArr count];
//
//            dispatch_queue_t myQueue = dispatch_queue_create("My Queue",NULL);
//            dispatch_async(myQueue, ^{
//                // Perform long running process
//                [self getAllReceiptIDS:startIndex];
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
//
//}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    AudioServicesPlaySystemSound (soundFileObject);
    if ([alertView.title isEqualToString:@"Material Transfer Receipt Submitted Successfully"]) {
        if (buttonIndex == 0) {
            self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
            self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
            
            OpenWareHouseReceipt *viewReceipt = [[OpenWareHouseReceipt alloc] initWithReceiptID:wareReceipt_];
            [self.navigationController pushViewController:viewReceipt animated:YES];
        }
        else{
            alertView.hidden = YES;
        }
    }
    else if ([alertView.title isEqualToString:@"Material Transfer Receipt Saved Successfully"]){
        if (buttonIndex == 0) {
            self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
            self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
            
            OpenWareHouseReceipt *viewReceipt = [[OpenWareHouseReceipt alloc] initWithReceiptID:wareReceipt_];
            [self.navigationController pushViewController:viewReceipt animated:YES];
        }
        else{
            alertView.hidden = YES;
        }
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == location) {
        
        // Check for non-numeric characters
        NSUInteger lengthOfString = string.length;
        for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {
            unichar character = [string characterAtIndex:loopIndex];
            if (character < 48) return NO; // 48 unichar for 0
            if (character > 57) return NO; // 57 unichar for 9
            if (character > 48 || character < 57) {
                
                return NO;
            }
        }
        // Check for total length
        //NSUInteger proposedNewLength = textField.text.length - range.length + string.length;
        //        if (proposedNewLength > 3) {
        //
        //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Enter valid quatity" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //            [alert show];
        //            return NO;
        //
        //        }
    }
    return YES;
    
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
