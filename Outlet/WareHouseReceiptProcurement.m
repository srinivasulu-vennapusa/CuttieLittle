//
//  WareHouseReceiptProcurement.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/17/15.
//
//

#import "WareHouseReceiptProcurement.h"
#import "RawMaterialServiceSvc.h"
#import "WHStockReceiptService.h"
#import "Global.h"
#import "SkuServiceSvc.h"
#import "ViewWareHouseProcurementReceipt.h"
#import "SupplierServiceSvc.h"

@interface WareHouseReceiptProcurement ()

@end

@implementation WareHouseReceiptProcurement
@synthesize soundFileURLRef,soundFileObject;

int wareReceiptProcurementQuantity = 0;
int wareReceieptProcurementMaterialTagid = 0;
int wareReceiptProcurementRejectMaterialTagId = 0;
float wareReceiptProcurementMaterialCost = 0.0f;
int wareStartPoint;
NSString *wareReceipt;
NSDictionary *wareJSON = NULL;
bool wareScrollValueStatus = NO;

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
            wareJSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                   options: NSJSONReadingMutableContainers
                                                     error: &e];
            //  NSString *itemString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",[JSON objectForKey:@"productName"],@"#",[JSON objectForKey:@"description"],@"#",[JSON objectForKey:@"quantity"],@"#",[JSON objectForKey:@"price"]];
        }
    }
    
    NSArray *temp = [NSArray arrayWithObjects:[wareJSON objectForKey:@"productName"],[wareJSON objectForKey:@"description"],[wareJSON objectForKey:@"price"],@"1",[wareJSON objectForKey:@"price"],@"NA",@"1",@"1",@"0", nil];
    
    for (int c = 0; c < [rawMaterialDetails count]; c++) {
        NSArray *material = [rawMaterialDetails objectAtIndex:c];
        if ([[material objectAtIndex:0] isEqualToString:[NSString stringWithFormat:@"%@",[wareJSON objectForKey:@"productName"]]]) {
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
    
    wareReceiptProcurementQuantity = 0;
    wareReceiptProcurementMaterialCost = 0.0f;
    
    for (int i = 0; i < [rawMaterialDetails count]; i++) {
        NSArray *material = [rawMaterialDetails objectAtIndex:i];
        wareReceiptProcurementQuantity = wareReceiptProcurementQuantity + [[material objectAtIndex:7] intValue];
        wareReceiptProcurementMaterialCost = wareReceiptProcurementMaterialCost + ([[material objectAtIndex:2] floatValue] * [[material objectAtIndex:7] intValue]);
    }
    
    totalQuantity.text = [NSString stringWithFormat:@"%d",wareReceiptProcurementQuantity];
    totalCost.text = [NSString stringWithFormat:@"%.2f",wareReceiptProcurementMaterialCost];
    
    [HUD hide:YES afterDelay:1.0];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    wareScrollValueStatus = NO;
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (CFURLRef) [tapSound retain];
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    self.navigationController.navigationBarHidden = NO;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 700.0, 45.0)];
    titleView.backgroundColor = [UIColor clearColor];
    
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo_200.png"]];
    logoView.backgroundColor = [UIColor clearColor];
    logoView.frame = CGRectMake(100.0, 0.0, 45.0, 45.0);
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(150.0, -13.0, 400.0, 70.0)];
    titleLbl.text = @"Warehouse Procurement Receipt";
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
    supplierID.placeholder = @"   Supplier ID";
    [supplierID addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [supplierID awakeFromNib];
    
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
    supplierName.placeholder = @"   Supplier Name";
    [supplierName addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [supplierName awakeFromNib];
    
    supplierTable = [[UITableView alloc] init];
    supplierTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [supplierTable setDataSource:self];
    [supplierTable setDelegate:self];
    [supplierTable.layer setBorderWidth:1.0f];
    supplierTable.layer.cornerRadius = 3;
    supplierTable.layer.borderColor = [UIColor grayColor].CGColor;
    
    
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
    deliveredBy.placeholder = @"   Delivered By";
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
    inspectedBy.placeholder = @"   Inspected By";
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
    poReference.placeholder = @"   PO Reference";
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
    shipmentNote.placeholder = @"   Shipment Note";
    [shipmentNote addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [shipmentNote awakeFromNib];
    
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
        
        createReceiptView.frame = CGRectMake(0, 125, self.view.frame.size.width, self.view.frame.size.height);
        createReceiptView.contentSize = CGSizeMake(self.view.frame.size.width + 500, 1000);
        
        supplierName.font = [UIFont boldSystemFontOfSize:20];
        supplierName.frame = CGRectMake(10.0, 10.0, 360, 50);
        
        supplierID.font = [UIFont boldSystemFontOfSize:20];
        supplierID.frame = CGRectMake(400.0, 10.0, 360, 50);
        
        location.font = [UIFont boldSystemFontOfSize:20];
        location.frame = CGRectMake(10.0, 70.0, 360, 50);
        
        deliveredBy.font = [UIFont boldSystemFontOfSize:20];
        deliveredBy.frame = CGRectMake(400.0, 70.0, 360, 50);
        
        inspectedBy.font = [UIFont boldSystemFontOfSize:20];
        inspectedBy.frame = CGRectMake(10.0, 130.0, 360, 50);
        
        date.font = [UIFont boldSystemFontOfSize:20];
        date.frame = CGRectMake(400.0, 130.0, 360, 50);
        
        poReference.font = [UIFont boldSystemFontOfSize:20];
        poReference.frame = CGRectMake(10.0, 190.0, 360, 50);
        
        shipmentNote.font = [UIFont boldSystemFontOfSize:20];
        shipmentNote.frame = CGRectMake(400.0, 190.0, 360, 50);
        
        searchItem.font = [UIFont boldSystemFontOfSize:20];
        searchItem.frame = CGRectMake(200.0, 250.0, 360.0, 50.0);
        
        ReceiptID.font = [UIFont boldSystemFontOfSize:20];
        ReceiptID.frame = CGRectMake(200.0, 10.0, 360.0, 50.0);
        
        label2.font = [UIFont boldSystemFontOfSize:20];
        label2.frame = CGRectMake(10, 320.0, 90, 55);
        label11.font = [UIFont boldSystemFontOfSize:20];
        label11.frame = CGRectMake(103, 320.0, 90, 55);
        label3.font = [UIFont boldSystemFontOfSize:20];
        label3.frame = CGRectMake(195, 320.0, 90, 55);
        label4.font = [UIFont boldSystemFontOfSize:20];
        label4.frame = CGRectMake(288, 320.0, 90, 55);
        label5.font = [UIFont boldSystemFontOfSize:20];
        label5.frame = CGRectMake(381, 320.0, 110, 55);
        label12.font = [UIFont boldSystemFontOfSize:20];
        label12.frame = CGRectMake(494, 320.0, 110, 55);
        label8.font = [UIFont boldSystemFontOfSize:20];
        label8.frame = CGRectMake(494, 320.0, 110, 55);
        label9.font = [UIFont boldSystemFontOfSize:20];
        label9.frame = CGRectMake(607, 320.0, 110, 55);
        label10.font = [UIFont boldSystemFontOfSize:20];
        label10.frame = CGRectMake(720.0, 320.0, 110, 55);
        
        scrollView.frame = CGRectMake(10, 380.0, 980.0, 280.0);
        scrollView.contentSize = CGSizeMake(778, 1000);
        cartTable.frame = CGRectMake(0, 0, 980.0,60);
        
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
        
        skListTable.frame = CGRectMake(200, 300.0, 360,0);
        supplierTable.frame = CGRectMake(10, 300.0, 360,0);
        receiptIDTable.frame = CGRectMake(200.0, 60, 360, 0);
        
        location.attributedPlaceholder = [[NSAttributedString alloc]initWithString:location.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        //        date.attributedPlaceholder = [[NSAttributedString alloc]initWithString:date.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor whiteColor]colorWithAlphaComponent:0.8]}];
        deliveredBy.attributedPlaceholder = [[NSAttributedString alloc]initWithString:deliveredBy.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        inspectedBy.attributedPlaceholder = [[NSAttributedString alloc]initWithString:inspectedBy.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        poReference.attributedPlaceholder = [[NSAttributedString alloc]initWithString:poReference.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        supplierName.attributedPlaceholder = [[NSAttributedString alloc]initWithString:supplierName.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        supplierID.attributedPlaceholder = [[NSAttributedString alloc]initWithString:supplierID.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        shipmentNote.attributedPlaceholder = [[NSAttributedString alloc]initWithString:shipmentNote.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.8]}];
        
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
        // mainSegmentedControl.frame = CGRectMake(-2, 65, 772, 60);
        //        mainSegmentedControl.tintColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        //        mainSegmentedControl.backgroundColor = [UIColor clearColor];
        //        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
        //                                    [UIFont boldSystemFontOfSize:18], UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor,
        //                                    nil];
        //        [mainSegmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
        
        createReceiptView.frame = CGRectMake(0, 42, self.view.frame.size.width, self.view.frame.size.height);
        //createReceiptView.contentSize = CGSizeMake(self.view.frame.size.width + 500, 1000);
        viewReceiptView.frame = CGRectMake(0, 42, self.view.frame.size.width, self.view.frame.size.height);
        
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
    
    //[self.view addSubview:mainSegmentedControl];
    [createReceiptView addSubview:supplierID];
    [createReceiptView addSubview:supplierName];
    [createReceiptView addSubview:location];
    [createReceiptView addSubview:deliveredBy];
    [createReceiptView addSubview:inspectedBy];
    [createReceiptView addSubview:date];
    [createReceiptView addSubview:poReference];
    [createReceiptView addSubview:shipmentNote];
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
    [createReceiptView addSubview:submitBtn];
    [createReceiptView addSubview:cancelButton];
    [createReceiptView addSubview:skListTable];
    [createReceiptView addSubview:supplierTable];
    createReceiptView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:createReceiptView];
    viewReceiptView.backgroundColor = [UIColor blackColor];
    [viewReceiptView addSubview:ReceiptID];
    [viewReceiptView addSubview:normalstockTable];
    [viewReceiptView addSubview:receiptIDTable];
    [self.view addSubview:viewReceiptView];
    
    
    
    [HUD hide:YES afterDelay:1.0];
    
    rawMaterials = [[NSMutableArray alloc] init];
    skuArrayList = [[NSMutableArray alloc]init];
    tempSkuArrayList = [[NSMutableArray alloc] init];
//    supplierList = [[NSMutableArray alloc] init];
//    supplierCode = [[NSMutableArray alloc] init];
    
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
    
    rawMaterials = [[NSMutableArray alloc] init];
    skuArrayList = [[NSMutableArray alloc]init];
    tempSkuArrayList = [[NSMutableArray alloc] init];
    supplierList = [[NSMutableArray alloc] init];
    supplierCode = [[NSMutableArray alloc] init];
}

-(void) getAllReceiptIDS:(int)startPoint {
    BOOL status = FALSE;
    WHStockReceiptServiceSoapBinding *materialBinding = [[WHStockReceiptService WHStockReceiptServiceSoapBinding] retain];
    
    WHStockReceiptService_getStockProcurementReceipts *aparams = [[WHStockReceiptService_getStockProcurementReceipts alloc] init];
    NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str = [time componentsSeparatedByString:@" "];
    NSString *date_ = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    
    NSArray *headerKeys_ = [NSArray arrayWithObjects:@"start",@"requestHeader", nil];
    
    NSArray *headerObjects_ = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",startPoint],dictionary_, nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects_ forKeys:headerKeys_];
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
    NSString * createBillingJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    aparams.start =createBillingJsonString;
    //    tns1_getStockProcurementReceipts *aparams = [[tns1_getStockProcurementReceipts alloc] init];
    //    aparams.start = [NSString stringWithFormat:@"%d",startPoint];
    
    //    StockReceiptServiceSvc_getStockProcurementReceipts *aParams = [[StockReceiptServiceSvc_getStockProcurementReceipts alloc] init];
    //    aParams.start = [NSString stringWithFormat:@"%d",startPoint];
    
    @try {
        
        WHStockReceiptServiceSoapBindingResponse *response = [materialBinding getStockProcurementReceiptsUsingParameters:(WHStockReceiptService_getStockProcurementReceipts *)aparams];
        NSArray *responseBodyParts = response.bodyParts;
        NSDictionary *JSONData;
        
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[WHStockReceiptService_getStockProcurementReceiptsResponse class]]) {
                WHStockReceiptService_getStockProcurementReceiptsResponse *body = (WHStockReceiptService_getStockProcurementReceiptsResponse *)bodyPart;
                
                NSError *err;
                NSLog(@"%@",body.return_);
                JSONData = [[NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                            options: NSJSONReadingMutableContainers
                                                              error: &err] copy];
                status = TRUE;
                wareJSON = [JSONData copy];
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
    
    
    if (status) {
        
        [HUD setHidden:YES];
        NSDictionary *responseDic = [wareJSON valueForKey:@"responseHeader"];
        if ([[responseDic objectForKey:@"responseCode"] isEqualToString:@"0"] && [[responseDic objectForKey:@"responseMessage"] isEqualToString:@"Success"]) {
            NSArray *temp = [wareJSON objectForKey:@"receiptDetails"];
            if ([temp count] == 0) {
                wareScrollValueStatus = YES;
            }
            for (int i = 0; i < [temp count]; i++) {
                NSDictionary *receipt = [temp objectAtIndex:i];
                if (![procurementReceipts containsObject:[receipt objectForKey:@"receipt_ref_num"]] && ![procuremnetReceiptDetails containsObject:receipt]) {
                    [procurementReceipts addObject:[receipt objectForKey:@"receipt_ref_num"]];
                    [procuremnetReceiptDetails addObject:receipt];
                }
            }
            [normalstockTable reloadData];
        }
        else{
            
        }
    }
    
    //[HUD hide:YES afterDelay:1.0];
    
}


-(void) callRawMaterials:(NSString *)searchString {
    // BOOL status = FALSE;
    
    [HUD setHidden:NO];
    
    SkuServiceSoapBinding *skuService = [[SkuServiceSvc SkuServiceSoapBinding] retain];
    
    SkuServiceSvc_searchProducts *getSkuid = [[SkuServiceSvc_searchProducts alloc] init];
    NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str = [time componentsSeparatedByString:@" "];
    NSString *date1 = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date1, nil];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    NSArray *keys = [NSArray arrayWithObjects:@"requestHeader",@"startIndex",@"searchCriteria",nil];
    NSArray *objects = [NSArray arrayWithObjects:dictionary_,@"0",searchString, nil];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
    NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    getSkuid.searchCriteria = salesReportJsonString;
    //
    if ([tempSkuArrayList count]!=0) {
        [tempSkuArrayList removeAllObjects];
    }
    //
    @try {
        
        SkuServiceSoapBindingResponse *response = [skuService searchProductsUsingParameters:getSkuid];
        NSArray *responseBodyParts = response.bodyParts;
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[SkuServiceSvc_searchProductsResponse class]]) {
                SkuServiceSvc_searchProductsResponse *body = (SkuServiceSvc_searchProductsResponse *)bodyPart;
                printf("\nresponse=%s",[body.return_ UTF8String]);
                NSError *e;
                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                                     options: NSJSONReadingMutableContainers
                                                                       error: &e];
                [HUD setHidden:YES];
                
                NSArray *list = [JSON objectForKey:@"productsList"];
                
                [tempSkuArrayList addObjectsFromArray:list];
            }
        }
        
    }
    @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No data found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
    
    
    //[skListTable reloadData];
    
}

-(void)callReceiptIDS:(NSString *)searchString {
    
    BOOL status = FALSE;
    
    WHStockReceiptServiceSoapBinding *materialBinding = [[WHStockReceiptService WHStockReceiptServiceSoapBinding] retain];
    
    WHStockReceiptService_getStockProcurementReceiptIds *aparams = [[WHStockReceiptService_getStockProcurementReceiptIds alloc] init];
    //    tns1_getStockProcurementReceiptIds *aparams = [[tns1_getStockProcurementReceiptIds alloc] init];
    //    aparams.searchCriteria = searchString;
    NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str = [time componentsSeparatedByString:@" "];
    NSString *date_ = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    
    NSArray *headerKeys_ = [NSArray arrayWithObjects:@"searchCriteria",@"requestHeader", nil];
    
    NSArray *headerObjects_ = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",searchString],dictionary_, nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects_ forKeys:headerKeys_];
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
    NSString * createBillingJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    aparams.searchCriteria = createBillingJsonString;
    
    NSDictionary *JSON ;
    
    @try {
        
        WHStockReceiptServiceSoapBindingResponse *response = [materialBinding getStockProcurementReceiptIdsUsingParameters:(WHStockReceiptService_getStockProcurementReceiptIds *)aparams];
        NSArray *responseBodyParts = response.bodyParts;
        
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[WHStockReceiptService_getStockProcurementReceiptIdsResponse class]]) {
                WHStockReceiptService_getStockProcurementReceiptIdsResponse *body = (WHStockReceiptService_getStockProcurementReceiptIdsResponse *)bodyPart;
                
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

- (void)textFieldDidChange:(UITextField *)textField {
    if (textField == searchItem) {
        
        if ([textField.text length] >= 3) {
            
            [self callRawMaterials:textField.text];
            [skuArrayList removeAllObjects];
            [rawMaterials removeAllObjects];
            for (NSDictionary *product in tempSkuArrayList)
            {
                NSComparisonResult result;
                
                if (!([[product objectForKey:@"productId"] rangeOfString:textField.text options:NSCaseInsensitiveSearch].location == NSNotFound))
                {
                    result = [[product objectForKey:@"productId"] compare:textField.text options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [textField.text length])];
                    if (result == NSOrderedSame)
                    {
                        [skuArrayList addObject:[product objectForKey:@"productId"]];
                        [rawMaterials addObject:product];
                        
                    }
                }
                if (!([[product objectForKey:@"description"] rangeOfString:textField.text options:NSCaseInsensitiveSearch].location == NSNotFound)) {
                    
                    [skuArrayList addObject:[product objectForKey:@"description"]];
                    [rawMaterials addObject:product];
                    
                    
                    
                    
                }
                else {
                    
                    // [filteredSkuArrayList addObject:[product objectForKey:@"skuID"]];
                    
                    
                    result = [[product objectForKey:@"skuID"] compare:textField.text options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [textField.text length])];
                    
                    if (result == NSOrderedSame)
                    {
                        [skuArrayList addObject:[product objectForKey:@"skuID"]];
                        [rawMaterials addObject:product];
                        
                    }
                }
                
                
            }
            
            if ([skuArrayList count] > 0) {
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    skListTable.frame = CGRectMake(200, 300, 360,240);
                }
//                else {
//                    if (version >= 8.0) {
//                        skListTable.frame = CGRectMake(40, 100, 213,100);
//                    }
//                    else{
//                        skListTable.frame = CGRectMake(60.0, 170.0, 180, 130);
//                    }
//                }
                
                if ([skuArrayList count] > 5) {
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        skListTable.frame = CGRectMake(200, 300, 360,450);
                    }
//                    else {
//                        if (version >= 8.0) {
//                            skListTable.frame = CGRectMake(40, 100, 213,100);
//                        }
//                        else{
//                            skListTable.frame = CGRectMake(60.0, 170.0, 180, 130);
//                        }
//                    }
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
    else if (textField == supplierName) {
        if ([textField.text length] >= 3) {
            
            [self getSuppliers:textField.text];
            
            if ([supplierList count] > 0) {
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    supplierTable.frame = CGRectMake(10, 60, 360,240);
                }
//                else {
//                    if (version >= 8.0) {
//                        supplierTable.frame = CGRectMake(60, 35, 180,130);
//                    }
//                    else{
//                        supplierTable.frame = CGRectMake(60, 35, 180,150);
//                    }
//                }
                
                if ([supplierList count] > 5) {
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        supplierTable.frame = CGRectMake(10, 60, 360,450);
                    }
//                    else {
//                        if (version >= 8.0) {
//                            supplierTable.frame = CGRectMake(60, 35, 180,130);
//                        }
//                        else{
//                            supplierTable.frame = CGRectMake(60, 35, 180,150);
//                        }
//                    }
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
            
            wareStartPoint = 0;
            
            [self getAllReceiptIDS:wareStartPoint];
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
        receiptID.frame = CGRectMake(10.0, 10.0, 200.0, 55.0);
        receiptID.font = [UIFont boldSystemFontOfSize:30.0];
        receiptID.textColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        receiptID.text = procurementReceipt;
        
        UILabel *supplier_ID = [[UILabel alloc] init];
        supplier_ID.frame = CGRectMake(10.0, 65.0, 200.0, 55.0);
        supplier_ID.font = [UIFont boldSystemFontOfSize:20.0];
        supplier_ID.textColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
        supplier_ID.text = [NSString stringWithFormat:@"%@",[procurmentDetails objectForKey:@"supplier_id"]];
        
        UILabel *supplier_Name = [[UILabel alloc] init];
        supplier_Name.frame = CGRectMake(10.0, 120.0, 200.0, 55.0);
        supplier_Name.font = [UIFont boldSystemFontOfSize:20.0];
        supplier_Name.textColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
        supplier_Name.text = [NSString stringWithFormat:@"%@",[procurmentDetails objectForKey:@"supplier_name"]];
        
        UIImageView *statusView = [[UIImageView alloc] init];
        if ([[procurmentDetails objectForKey:@"status"] isEqualToString:@"false"]) {
            
            statusView.backgroundColor = [UIColor clearColor];
            statusView.image = [UIImage imageNamed:@"pending.png"];
            statusView.frame = CGRectMake(700.0, 65.0, 50.0, 50.0);
        }
        
        UILabel *date_ = [[UILabel alloc] init];
        date_.frame = CGRectMake(500.0, 10.0, 200.0, 55.0);
        date_.font = [UIFont boldSystemFontOfSize:20.0];
        date_.textColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
        date_.text = [NSString stringWithFormat:@"%@",[procurmentDetails objectForKey:@"date"]];
        
        UILabel *total = [[UILabel alloc] init];
        total.frame = CGRectMake(500.0, 100.0, 200.0, 55.0);
        total.font = [UIFont boldSystemFontOfSize:20.0];
        total.textColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
        total.text = [NSString stringWithFormat:@"%.2f",[[procurmentDetails objectForKey:@"grand_total"] floatValue]];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            
            receiptID.frame = CGRectMake(10.0, 10.0, 120.0, 35.0);
            receiptID.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:17.0];
            [receiptID setBackgroundColor:[UIColor clearColor]];
            
            supplier_ID.frame = CGRectMake(10.0, 45.0, 120.0, 35.0);
            supplier_ID.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:17.0];
            [supplier_ID setBackgroundColor:[UIColor clearColor]];
            
            supplier_Name.frame = CGRectMake(10.0, 90.0, 120.0, 35.0);
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
//        item_code.adjustsFontSizeToFitWidth = YES;
        //name.adjustsFontSizeToFitWidth = YES;
        
        UILabel *item_description = [[[UILabel alloc] init] autorelease];
        item_description.layer.borderWidth = 1.5;
        item_description.font = [UIFont systemFontOfSize:13.0];
        item_description.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        item_description.backgroundColor = [UIColor blackColor];
        item_description.textColor = [UIColor whiteColor];
        
        item_description.text = [temp objectAtIndex:1];
        item_description.textAlignment=NSTextAlignmentCenter;
//        item_description.adjustsFontSizeToFitWidth = YES;
        
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
            item_code.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
            item_code.frame = CGRectMake(0, 0, 90, 56);
            item_description.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
            item_description.frame = CGRectMake(93, 0, 90, 56);
            price.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
            price.frame = CGRectMake(185, 0, 90, 56);
            qtyButton.frame = CGRectMake(278, 0, 90, 56);
            qtyButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];

            cost.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
            cost.frame = CGRectMake(371, 0, 110, 56);
            supplied.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
            supplied.frame = CGRectMake(484, 0, 110, 56);
            received.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
            received.frame = CGRectMake(597, 0, 110, 56);
            rejectQtyButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
            rejectQtyButton.frame = CGRectMake(710.0, 0, 110, 56);
//            rejectQtyButton.frame = CGRectMake(823.0, 0, 110, 56);
            delrowbtn.frame = CGRectMake(850.0, 10 , 40, 40);
            
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
//        [hlcell.contentView addSubview:make];
        [hlcell .contentView addSubview:supplied];
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
    
    [rawMaterialDetails removeObjectAtIndex:[sender tag]];
    
    wareReceiptProcurementQuantity = 0;
    wareReceiptProcurementMaterialCost = 0.0f;
    
    for (int i = 0; i < [rawMaterialDetails count]; i++) {
        NSArray *material = [rawMaterialDetails objectAtIndex:i];
        wareReceiptProcurementQuantity = wareReceiptProcurementQuantity + [[material objectAtIndex:7] intValue];
        wareReceiptProcurementMaterialCost = wareReceiptProcurementMaterialCost + ([[material objectAtIndex:2] floatValue] * [[material objectAtIndex:7] intValue]);
    }
    
    totalQuantity.text = [NSString stringWithFormat:@"%d",wareReceiptProcurementQuantity];
    totalCost.text = [NSString stringWithFormat:@"%.2f",wareReceiptProcurementMaterialCost];
    [cartTable reloadData];
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
    
    wareReceiptProcurementRejectMaterialTagId = sender.tag;
    
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
    
    NSString *value = [qtyField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // PhoNumber validation...
    NSString *decimalRegex = @"[0-9]+([.]([0-9]+)?)?"; // @"[0-9]+[.][0-9]+";
    NSPredicate *decimalTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalRegex];
    BOOL isNumber = [decimalTest evaluateWithObject:[qtyField text]];
    int qty = [value intValue];
    
    NSArray *temp = [rawMaterialDetails objectAtIndex:wareReceiptProcurementRejectMaterialTagId];
    
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
        
        NSArray *finalArray = [NSArray arrayWithObjects:[temp objectAtIndex:0],[temp objectAtIndex:1],[temp objectAtIndex:2],[NSString stringWithFormat:@"%d", qty],[NSString stringWithFormat:@"%.2f",([[temp objectAtIndex:2] floatValue] * qty)],[temp objectAtIndex:5],[NSString stringWithFormat:@"%d",qty],[NSString stringWithFormat:@"%d",qty],@"0", nil];
        
        [rawMaterialDetails replaceObjectAtIndex:wareReceiptProcurementRejectMaterialTagId withObject:finalArray];
        
        [cartTable reloadData];
        
        rejectQtyChangeDisplayView.hidden = YES;
        cartTable.userInteractionEnabled = TRUE;
        
        wareReceiptProcurementQuantity = 0;
        wareReceiptProcurementMaterialCost = 0.0f;
        
        for (int i = 0; i < [rawMaterialDetails count]; i++) {
            NSArray *material = [rawMaterialDetails objectAtIndex:i];
            wareReceiptProcurementQuantity = wareReceiptProcurementQuantity + [[material objectAtIndex:7] intValue];
            wareReceiptProcurementMaterialCost = wareReceiptProcurementMaterialCost + ([[material objectAtIndex:2] floatValue] * [[material objectAtIndex:7] intValue]);
        }
        
        totalQuantity.text = [NSString stringWithFormat:@"%d",wareReceiptProcurementQuantity];
        totalCost.text = [NSString stringWithFormat:@"%.2f",wareReceiptProcurementMaterialCost];
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
    
    wareReceiptProcurementRejectMaterialTagId = sender.tag;
    
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
    
    NSString *value = [rejectQtyField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // PhoNumber validation...
    NSString *decimalRegex = @"[0-9]+([.]([0-9]+)?)?"; // @"[0-9]+[.][0-9]+";
    NSPredicate *decimalTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalRegex];
    BOOL isNumber = [decimalTest evaluateWithObject:[rejectQtyField text]];
    int qty = [value intValue];
    
    NSArray *temp = [rawMaterialDetails objectAtIndex:wareReceiptProcurementRejectMaterialTagId];
    
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
        
        NSArray *finalArray = [NSArray arrayWithObjects:[temp objectAtIndex:0],[temp objectAtIndex:1],[temp objectAtIndex:2],[temp objectAtIndex:3],[temp objectAtIndex:4],[temp objectAtIndex:5],[temp objectAtIndex:6],[NSString stringWithFormat:@"%d",received],[NSString stringWithFormat:@"%d",qty], nil];
        
        [rawMaterialDetails replaceObjectAtIndex:wareReceiptProcurementRejectMaterialTagId withObject:finalArray];
        
        [cartTable reloadData];
        
        qtyChangeDisplayView.hidden = YES;
        cartTable.userInteractionEnabled = TRUE;
        
        wareReceiptProcurementQuantity = 0;
        wareReceiptProcurementMaterialCost = 0.0f;
        
        for (int i = 0; i < [rawMaterialDetails count]; i++) {
            NSArray *material = [rawMaterialDetails objectAtIndex:i];
            wareReceiptProcurementQuantity = wareReceiptProcurementQuantity + [[material objectAtIndex:7] intValue];
            wareReceiptProcurementMaterialCost = wareReceiptProcurementMaterialCost + ([[material objectAtIndex:2] floatValue] * [[material objectAtIndex:7] intValue]);
        }
        
        totalQuantity.text = [NSString stringWithFormat:@"%d",wareReceiptProcurementQuantity];
        totalCost.text = [NSString stringWithFormat:@"%.2f",wareReceiptProcurementMaterialCost];
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
    else if (tableView == normalstockTable) {
        NSString *receiptID = [procurementReceipts objectAtIndex:indexPath.row];
        self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
        self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
        
        mainSegmentedControl.selectedSegmentIndex = 0;
        //        viewReceiptView.hidden = YES;
        
        ViewWareHouseProcurementReceipt *viewReceipt = [[ViewWareHouseProcurementReceipt alloc] initWithReceiptID:receiptID];
        [self.navigationController pushViewController:viewReceipt animated:YES];
    }
    else if (tableView == receiptIDTable){
        NSString *receiptID = [receiptIDS objectAtIndex:indexPath.row];
        self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
        self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
        receiptIDTable.hidden = YES;
        mainSegmentedControl.selectedSegmentIndex = 0;
        ViewWareHouseProcurementReceipt *viewReceipt = [[ViewWareHouseProcurementReceipt alloc] initWithReceiptID:receiptID];
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
            if (!wareScrollValueStatus) {
                wareStartPoint = wareStartPoint + [procurementReceipts count];
                [self getAllReceiptIDS:wareStartPoint];
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
        
        NSArray *objects1 = [NSArray arrayWithObjects:@"", totalQuantity.text,totalCost.text,@"0",totalCost.text,supplierID.text,supplierName.text,location.text,deliveredBy.text,date.text, poReference.text,shipmentNote.text,inspectedBy.text,temparr,@"true",dictionary_, nil];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects1 forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * createReceiptJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WHStockReceiptServiceSoapBinding *materialBinding = [[WHStockReceiptService WHStockReceiptServiceSoapBinding] retain];
        
        WHStockReceiptService_createNewStockProcurementReceipt *aparams = [[WHStockReceiptService_createNewStockProcurementReceipt alloc] init];
        //        tns1_createNewStockProcurementReceipt *aparams = [[tns1_createNewStockProcurementReceipt alloc] init];
        //        aparams.procurement_details = createReceiptJsonString;
        
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
                    wareReceipt = [receiptID copy];
                    UIAlertView *successAlertView  = [[UIAlertView alloc] init];
                    [successAlertView setDelegate:self];
                    [successAlertView setTitle:@"Procurement Receipt Created Successfully"];
                    [successAlertView setMessage:[NSString stringWithFormat:@"%@%@",@"Receipt ID : ",receiptID]];
                    [successAlertView addButtonWithTitle:@"OPEN RECEIPT"];
                    [successAlertView addButtonWithTitle:@"NEW RECEIPT"];
                    
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
        supplierID.text = @"";
        supplierName.text = @"";
        location.text = @"";
        deliveredBy.text = @"";
        inspectedBy.text = @"";
        poReference.text = @"";
        shipmentNote.text = @"";
        
        [rawMaterials removeAllObjects];
        [rawMaterialDetails removeAllObjects];
        [cartTable reloadData];
        totalCost.text = @"0.0";
        totalQuantity.text = @"0";
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
        
        NSArray *keys = [NSArray arrayWithObjects:@"receipt_ref_num", @"receipt_total_qty",@"sub_total",@"gst",@"grand_total",@"supplier_id",@"supplier_name",@"location",@"delivered_by",@"date",@"po_reference",@"shipment_note",@"inspected_by",@"itemDetails","status",@"requestHeader", nil];
        
        NSArray *objects = [NSArray arrayWithObjects:@"", totalQuantity.text,totalCost.text,@"0",totalCost.text,supplierID.text,supplierName.text,location.text,deliveredBy.text,date.text, poReference.text,shipmentNote.text,inspectedBy.text,temparr,@"false",dictionary_, nil];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * createReceiptJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WHStockReceiptServiceSoapBinding *materialBinding = [[WHStockReceiptService WHStockReceiptServiceSoapBinding] retain];
        
        WHStockReceiptService_createNewStockProcurementReceipt *aparams = [[WHStockReceiptService_createNewStockProcurementReceipt alloc] init];
        //        tns1_createNewStockProcurementReceipt *aparams = [[tns1_createNewStockProcurementReceipt alloc] init];
        //
        //        aparams.procurement_details = createReceiptJsonString;
        
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
                    wareReceipt = [receiptID copy];
                    UIAlertView *successAlertView  = [[UIAlertView alloc] init];
                    [successAlertView setDelegate:self];
                    [successAlertView setTitle:@"Procurement Receipt Saved Successfully"];
                    [successAlertView setMessage:[NSString stringWithFormat:@"%@%@",@"Receipt ID : ",receiptID]];
                    [successAlertView addButtonWithTitle:@"OPEN RECEIPT"];
                    [successAlertView addButtonWithTitle:@"NEW RECEIPT"];
                    
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
        supplierID.text = @"";
        supplierName.text = @"";
        location.text = @"";
        deliveredBy.text = @"";
        inspectedBy.text = @"";
        poReference.text = @"";
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
    //            startPoint = startPoint + [procurementReceipts count];
    //
    //            dispatch_queue_t myQueue = dispatch_queue_create("My Queue",NULL);
    //            dispatch_async(myQueue, ^{
    //                // Perform long running process
    //                [self getAllReceiptIDS:startPoint];
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
-(void)getSuppliers:(NSString *)supplierNameStr {
    // BOOL status = FALSE;
    
    [HUD setHidden:NO];
    
    SupplierServiceSoapBinding *skuService = [[SupplierServiceSvc SupplierServiceSoapBinding] retain];
    
    SupplierServiceSvc_getSuppliers *getSkuid = [[SupplierServiceSvc_getSuppliers alloc] init];
    NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str = [time componentsSeparatedByString:@" "];
    NSString *date1 = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date1, nil];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    NSArray *keys = [NSArray arrayWithObjects:@"requestHeader",@"pageNo",@"searchCriteria",nil];
    NSArray *objects = [NSArray arrayWithObjects:dictionary_,@"-1",supplierNameStr, nil];
    
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
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    if ([alertView.title isEqualToString:@"Procurement Receipt Created Successfully"]) {
        if (buttonIndex == 0) {
            self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
            self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
            
            ViewWareHouseProcurementReceipt *viewReceipt = [[ViewWareHouseProcurementReceipt alloc] initWithReceiptID:wareReceipt];
            [self.navigationController pushViewController:viewReceipt animated:YES];
        }
        else{
            alertView.hidden = YES;
        }
    }
    else if ([alertView.title isEqualToString:@"Procurement Receipt Saved Successfully"]){
        if (buttonIndex == 0) {
            self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
            self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
            
            ViewWareHouseProcurementReceipt *viewReceipt = [[ViewWareHouseProcurementReceipt alloc] initWithReceiptID:wareReceipt];
            [self.navigationController pushViewController:viewReceipt animated:YES];
        }
        else{
            alertView.hidden = YES;
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
