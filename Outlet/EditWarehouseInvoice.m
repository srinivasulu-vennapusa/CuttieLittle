//
//  EditWarehouseInvoice.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/24/15.
//
//

#import "EditWarehouseInvoice.h"
#import "WHInvoiceServicesSvc.h"
#import "WHShippingServicesSvc.h"
#import "ViewWarehouseInvoice.h"
#import "Global.h"
#import "WarehouseInvoicing.h"

@interface EditWarehouseInvoice ()

@end

@implementation EditWarehouseInvoice
@synthesize soundFileObject,soundFileURLRef;
NSString *wareEditInvoiceID_ = @"";
int invoiceEditInvoiceIndex;
bool invoiceIdStatus = TRUE;

-(id) initWithInvoiceID:(NSString *)invoiceID{
    
    wareEditInvoiceID_ = [invoiceID copy];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (CFURLRef) [tapSound retain];
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    //ProgressBar creation...
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    self.navigationController.navigationBarHidden = NO;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 600.0, 45.0)];
    titleView.backgroundColor = [UIColor clearColor];
    
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo_200.png"]];
    logoView.backgroundColor = [UIColor clearColor];
    logoView.frame = CGRectMake(150.0, 0.0, 45.0, 45.0);
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(200.0, -13.0, 300.0, 70.0)];
    titleLbl.text = @"Edit Warehouse Invoice";
    titleLbl.textColor = [UIColor blackColor];
    titleLbl.font = [UIFont boldSystemFontOfSize:25.0f];
    titleLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
    [titleView addSubview:logoView];
    [titleView addSubview:titleLbl];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
    }
    else{
        logoView.frame = CGRectMake(10.0, 7.0, 30.0, 30.0);
        titleLbl.frame = CGRectMake(45.0, -12.0, 150.0, 70.0);
        titleLbl.backgroundColor = [UIColor clearColor];
        titleLbl.textColor = [UIColor whiteColor];
        titleLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:12.0f];
    }
    
    self.navigationItem.titleView = titleView;
    self.view.backgroundColor = [UIColor blackColor];
    shipmentView = [[UIScrollView alloc] init];
    shipmentView.backgroundColor = [UIColor clearColor];
    shipmentView.bounces = FALSE;
    shipmentView.hidden = NO;
    
    shipmentId = [[[UILabel alloc] init] autorelease];
    shipmentId.text = @"Shipment ID :";
    shipmentId.layer.masksToBounds = YES;
    shipmentId.numberOfLines = 2;
    [shipmentId setTextAlignment:NSTextAlignmentLeft];
    shipmentId.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentId.textColor = [UIColor whiteColor];
    
    orderId = [[[UILabel alloc] init] autorelease];
    orderId.text = @"Order ID :";
    orderId.layer.masksToBounds = YES;
    orderId.numberOfLines = 2;
    [orderId setTextAlignment:NSTextAlignmentLeft];
    orderId.font = [UIFont boldSystemFontOfSize:14.0];
    orderId.textColor = [UIColor whiteColor];
    
    shipmentNoteId = [[[UILabel alloc] init] autorelease];
    shipmentNoteId.text = @"Shipment Note ID :";
    shipmentNoteId.layer.masksToBounds = YES;
    shipmentNoteId.numberOfLines = 2;
    [shipmentNoteId setTextAlignment:NSTextAlignmentLeft];
    shipmentNoteId.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentNoteId.textColor = [UIColor whiteColor];
    
    customerName = [[[UILabel alloc] init] autorelease];
    customerName.text = @"Customer Name :";
    customerName.layer.masksToBounds = YES;
    customerName.numberOfLines = 2;
    [customerName setTextAlignment:NSTextAlignmentLeft];
    customerName.font = [UIFont boldSystemFontOfSize:14.0];
    customerName.textColor = [UIColor whiteColor];
    
    buildingNo = [[[UILabel alloc] init] autorelease];
    buildingNo.text = @"Building No. :";
    buildingNo.layer.masksToBounds = YES;
    buildingNo.numberOfLines = 2;
    [buildingNo setTextAlignment:NSTextAlignmentLeft];
    buildingNo.font = [UIFont boldSystemFontOfSize:14.0];
    buildingNo.textColor = [UIColor whiteColor];
    
    streetName = [[[UILabel alloc] init] autorelease];
    streetName.text = @"Street Name :";
    streetName.layer.masksToBounds = YES;
    streetName.numberOfLines = 2;
    [streetName setTextAlignment:NSTextAlignmentLeft];
    streetName.font = [UIFont boldSystemFontOfSize:14.0];
    streetName.textColor = [UIColor whiteColor];
    
    city = [[[UILabel alloc] init] autorelease];
    city.text = @"City :";
    city.layer.masksToBounds = YES;
    city.numberOfLines = 2;
    [city setTextAlignment:NSTextAlignmentLeft];
    city.font = [UIFont boldSystemFontOfSize:14.0];
    city.textColor = [UIColor whiteColor];
    
    country = [[[UILabel alloc] init] autorelease];
    country.text = @"Country :";
    country.layer.masksToBounds = YES;
    country.numberOfLines = 2;
    [country setTextAlignment:NSTextAlignmentLeft];
    country.font = [UIFont boldSystemFontOfSize:14.0];
    country.textColor = [UIColor whiteColor];
    
    zip_code = [[[UILabel alloc] init] autorelease];
    zip_code.text = @"Zip Code :";
    zip_code.layer.masksToBounds = YES;
    zip_code.numberOfLines = 2;
    [zip_code setTextAlignment:NSTextAlignmentLeft];
    zip_code.font = [UIFont boldSystemFontOfSize:14.0];
    zip_code.textColor = [UIColor whiteColor];
    
    shipmentAgency = [[[UILabel alloc] init] autorelease];
    shipmentAgency.text = @"Shipment Agency :";
    shipmentAgency.layer.masksToBounds = YES;
    shipmentAgency.numberOfLines = 2;
    [shipmentAgency setTextAlignment:NSTextAlignmentLeft];
    shipmentAgency.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentAgency.textColor = [UIColor whiteColor];
    
    shipmentCost = [[[UILabel alloc] init] autorelease];
    shipmentCost.text = @"Shipment Cost :";
    shipmentCost.layer.masksToBounds = YES;
    shipmentCost.numberOfLines = 2;
    [shipmentCost setTextAlignment:NSTextAlignmentLeft];
    shipmentCost.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentCost.textColor = [UIColor whiteColor];
    
    insuranceCost = [[[UILabel alloc] init] autorelease];
    insuranceCost.text = @"Insurance Cost :";
    insuranceCost.layer.masksToBounds = YES;
    insuranceCost.numberOfLines = 2;
    [insuranceCost setTextAlignment:NSTextAlignmentLeft];
    insuranceCost.font = [UIFont boldSystemFontOfSize:14.0];
    insuranceCost.textColor = [UIColor whiteColor];
    
    paymentTerms = [[[UILabel alloc] init] autorelease];
    paymentTerms.text = @"Payment Terms :";
    paymentTerms.layer.masksToBounds = YES;
    paymentTerms.numberOfLines = 2;
    [paymentTerms setTextAlignment:NSTextAlignmentLeft];
    paymentTerms.font = [UIFont boldSystemFontOfSize:14.0];
    paymentTerms.textColor = [UIColor whiteColor];
    
    invoiceDate = [[[UILabel alloc] init] autorelease];
    invoiceDate.text = @"Invoice Date :";
    invoiceDate.layer.masksToBounds = YES;
    invoiceDate.numberOfLines = 2;
    [invoiceDate setTextAlignment:NSTextAlignmentLeft];
    invoiceDate.font = [UIFont boldSystemFontOfSize:14.0];
    invoiceDate.textColor = [UIColor whiteColor];
    
    remarks = [[[UILabel alloc] init] autorelease];
    remarks.text = @"Remarks :";
    remarks.layer.masksToBounds = YES;
    remarks.numberOfLines = 2;
    [remarks setTextAlignment:NSTextAlignmentLeft];
    remarks.font = [UIFont boldSystemFontOfSize:14.0];
    remarks.textColor = [UIColor whiteColor];
    
    shipmentIdValue = [[UITextField alloc] init];
    shipmentIdValue.borderStyle = UITextBorderStyleRoundedRect;
    shipmentIdValue.textColor = [UIColor blackColor];
    shipmentIdValue.font = [UIFont systemFontOfSize:18.0];
    shipmentIdValue.backgroundColor = [UIColor whiteColor];
    shipmentIdValue.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentIdValue.backgroundColor = [UIColor whiteColor];
    shipmentIdValue.autocorrectionType = UITextAutocorrectionTypeNo;
    shipmentIdValue.layer.borderColor = [UIColor whiteColor].CGColor;
    shipmentIdValue.backgroundColor = [UIColor whiteColor];
    shipmentIdValue.delegate = self;
    shipmentIdValue.placeholder = @"   Shipment ID";
    [shipmentIdValue addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    // ShipModeTableview cration....
    shipIdTable = [[UITableView alloc]init];
    shipIdTable.layer.borderWidth = 1.0;
    shipIdTable.layer.cornerRadius = 10.0;
    shipIdTable.bounces = FALSE;
    shipIdTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    shipIdTable.layer.borderColor = [UIColor blackColor].CGColor;
    [shipIdTable setDataSource:self];
    [shipIdTable setDelegate:self];
    
    orderIdValue = [[UITextField alloc] init];
    orderIdValue.borderStyle = UITextBorderStyleRoundedRect;
    orderIdValue.textColor = [UIColor blackColor];
    orderIdValue.font = [UIFont systemFontOfSize:18.0];
    orderIdValue.backgroundColor = [UIColor whiteColor];
    orderIdValue.clearButtonMode = UITextFieldViewModeWhileEditing;
    orderIdValue.backgroundColor = [UIColor whiteColor];
    orderIdValue.autocorrectionType = UITextAutocorrectionTypeNo;
    orderIdValue.layer.borderColor = [UIColor whiteColor].CGColor;
    orderIdValue.backgroundColor = [UIColor whiteColor];
    orderIdValue.delegate = self;
    orderIdValue.placeholder = @"   Order ID";
    
    shipmentNoteIdValue = [[UITextField alloc] init];
    shipmentNoteIdValue.borderStyle = UITextBorderStyleRoundedRect;
    shipmentNoteIdValue.textColor = [UIColor blackColor];
    shipmentNoteIdValue.font = [UIFont systemFontOfSize:18.0];
    shipmentNoteIdValue.backgroundColor = [UIColor whiteColor];
    shipmentNoteIdValue.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentNoteIdValue.backgroundColor = [UIColor whiteColor];
    shipmentNoteIdValue.autocorrectionType = UITextAutocorrectionTypeNo;
    shipmentNoteIdValue.layer.borderColor = [UIColor whiteColor].CGColor;
    shipmentNoteIdValue.backgroundColor = [UIColor whiteColor];
    shipmentNoteIdValue.delegate = self;
    shipmentNoteIdValue.placeholder = @"   Shipment Note ID";
    
    customerNameValue = [[UITextField alloc] init];
    customerNameValue.borderStyle = UITextBorderStyleRoundedRect;
    customerNameValue.textColor = [UIColor blackColor];
    customerNameValue.font = [UIFont systemFontOfSize:18.0];
    customerNameValue.backgroundColor = [UIColor whiteColor];
    customerNameValue.clearButtonMode = UITextFieldViewModeWhileEditing;
    customerNameValue.backgroundColor = [UIColor whiteColor];
    customerNameValue.autocorrectionType = UITextAutocorrectionTypeNo;
    customerNameValue.layer.borderColor = [UIColor whiteColor].CGColor;
    customerNameValue.backgroundColor = [UIColor whiteColor];
    customerNameValue.delegate = self;
    customerNameValue.placeholder = @"   Customer Name";
    
    buildingNoValue = [[UITextField alloc] init];
    buildingNoValue.borderStyle = UITextBorderStyleRoundedRect;
    buildingNoValue.textColor = [UIColor blackColor];
    buildingNoValue.font = [UIFont systemFontOfSize:18.0];
    buildingNoValue.backgroundColor = [UIColor whiteColor];
    buildingNoValue.clearButtonMode = UITextFieldViewModeWhileEditing;
    buildingNoValue.backgroundColor = [UIColor whiteColor];
    buildingNoValue.autocorrectionType = UITextAutocorrectionTypeNo;
    buildingNoValue.layer.borderColor = [UIColor whiteColor].CGColor;
    buildingNoValue.backgroundColor = [UIColor whiteColor];
    buildingNoValue.delegate = self;
    buildingNoValue.placeholder = @"   Building NO.";
    
    streetNameValue = [[UITextField alloc] init];
    streetNameValue.borderStyle = UITextBorderStyleRoundedRect;
    streetNameValue.textColor = [UIColor blackColor];
    streetNameValue.font = [UIFont systemFontOfSize:18.0];
    streetNameValue.backgroundColor = [UIColor whiteColor];
    streetNameValue.clearButtonMode = UITextFieldViewModeWhileEditing;
    streetNameValue.backgroundColor = [UIColor whiteColor];
    streetNameValue.autocorrectionType = UITextAutocorrectionTypeNo;
    streetNameValue.layer.borderColor = [UIColor whiteColor].CGColor;
    streetNameValue.backgroundColor = [UIColor whiteColor];
    streetNameValue.delegate = self;
    streetNameValue.placeholder = @"   Street Name";
    
    cityValue = [[UITextField alloc] init];
    cityValue.borderStyle = UITextBorderStyleRoundedRect;
    cityValue.textColor = [UIColor blackColor];
    cityValue.font = [UIFont systemFontOfSize:18.0];
    cityValue.backgroundColor = [UIColor whiteColor];
    cityValue.clearButtonMode = UITextFieldViewModeWhileEditing;
    cityValue.backgroundColor = [UIColor whiteColor];
    cityValue.autocorrectionType = UITextAutocorrectionTypeNo;
    cityValue.layer.borderColor = [UIColor whiteColor].CGColor;
    cityValue.backgroundColor = [UIColor whiteColor];
    cityValue.delegate = self;
    cityValue.placeholder = @"   City";
    
    countryValue = [[UITextField alloc] init];
    countryValue.borderStyle = UITextBorderStyleRoundedRect;
    countryValue.textColor = [UIColor blackColor];
    countryValue.font = [UIFont systemFontOfSize:18.0];
    countryValue.backgroundColor = [UIColor whiteColor];
    countryValue.clearButtonMode = UITextFieldViewModeWhileEditing;
    countryValue.backgroundColor = [UIColor whiteColor];
    countryValue.autocorrectionType = UITextAutocorrectionTypeNo;
    countryValue.layer.borderColor = [UIColor whiteColor].CGColor;
    countryValue.backgroundColor = [UIColor whiteColor];
    countryValue.delegate = self;
    countryValue.placeholder = @"   Country";
    
    zip_codeValue = [[UITextField alloc] init];
    zip_codeValue.borderStyle = UITextBorderStyleRoundedRect;
    zip_codeValue.textColor = [UIColor blackColor];
    zip_codeValue.font = [UIFont systemFontOfSize:18.0];
    zip_codeValue.backgroundColor = [UIColor whiteColor];
    zip_codeValue.clearButtonMode = UITextFieldViewModeWhileEditing;
    zip_codeValue.backgroundColor = [UIColor whiteColor];
    zip_codeValue.autocorrectionType = UITextAutocorrectionTypeNo;
    zip_codeValue.layer.borderColor = [UIColor whiteColor].CGColor;
    zip_codeValue.backgroundColor = [UIColor whiteColor];
    zip_codeValue.delegate = self;
    zip_codeValue.placeholder = @"   Zip Code";
    
    shipmentAgencyValue = [[UITextField alloc] init];
    shipmentAgencyValue.borderStyle = UITextBorderStyleRoundedRect;
    shipmentAgencyValue.textColor = [UIColor blackColor];
    shipmentAgencyValue.font = [UIFont systemFontOfSize:18.0];
    shipmentAgencyValue.backgroundColor = [UIColor whiteColor];
    shipmentAgencyValue.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentAgencyValue.backgroundColor = [UIColor whiteColor];
    shipmentAgencyValue.autocorrectionType = UITextAutocorrectionTypeNo;
    shipmentAgencyValue.layer.borderColor = [UIColor whiteColor].CGColor;
    shipmentAgencyValue.backgroundColor = [UIColor whiteColor];
    shipmentAgencyValue.delegate = self;
    shipmentAgencyValue.placeholder = @"   Shipment Agency";
    
    shipmentCostValue = [[UITextField alloc] init];
    shipmentCostValue.borderStyle = UITextBorderStyleRoundedRect;
    shipmentCostValue.textColor = [UIColor blackColor];
    shipmentCostValue.font = [UIFont systemFontOfSize:18.0];
    shipmentCostValue.backgroundColor = [UIColor whiteColor];
    shipmentCostValue.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentCostValue.backgroundColor = [UIColor whiteColor];
    shipmentCostValue.autocorrectionType = UITextAutocorrectionTypeNo;
    shipmentCostValue.layer.borderColor = [UIColor whiteColor].CGColor;
    shipmentCostValue.backgroundColor = [UIColor whiteColor];
    shipmentCostValue.delegate = self;
    shipmentCostValue.placeholder = @"   Shipment Cost";
    
    insuranceCostValue = [[UITextField alloc] init];
    insuranceCostValue.borderStyle = UITextBorderStyleRoundedRect;
    insuranceCostValue.textColor = [UIColor blackColor];
    insuranceCostValue.font = [UIFont systemFontOfSize:18.0];
    insuranceCostValue.backgroundColor = [UIColor whiteColor];
    insuranceCostValue.clearButtonMode = UITextFieldViewModeWhileEditing;
    insuranceCostValue.backgroundColor = [UIColor whiteColor];
    insuranceCostValue.autocorrectionType = UITextAutocorrectionTypeNo;
    insuranceCostValue.layer.borderColor = [UIColor whiteColor].CGColor;
    insuranceCostValue.backgroundColor = [UIColor whiteColor];
    insuranceCostValue.delegate = self;
    insuranceCostValue.placeholder = @"   Insurance Cost";
    
    paymentTermsValue = [[UITextField alloc] init];
    paymentTermsValue.borderStyle = UITextBorderStyleRoundedRect;
    paymentTermsValue.textColor = [UIColor blackColor];
    paymentTermsValue.font = [UIFont systemFontOfSize:18.0];
    paymentTermsValue.backgroundColor = [UIColor whiteColor];
    paymentTermsValue.clearButtonMode = UITextFieldViewModeWhileEditing;
    paymentTermsValue.backgroundColor = [UIColor whiteColor];
    paymentTermsValue.autocorrectionType = UITextAutocorrectionTypeNo;
    paymentTermsValue.layer.borderColor = [UIColor whiteColor].CGColor;
    paymentTermsValue.backgroundColor = [UIColor whiteColor];
    paymentTermsValue.delegate = self;
    paymentTermsValue.placeholder = @"   Payment Terms";
    
    // getting present date & time ..
    NSDate *today = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString* currentdate = [f stringFromDate:today];
    [f release];
    
    invoiceDateValue = [[UITextField alloc] init];
    invoiceDateValue.borderStyle = UITextBorderStyleRoundedRect;
    invoiceDateValue.textColor = [UIColor blackColor];
    invoiceDateValue.font = [UIFont systemFontOfSize:18.0];
    invoiceDateValue.backgroundColor = [UIColor whiteColor];
    invoiceDateValue.clearButtonMode = UITextFieldViewModeWhileEditing;
    invoiceDateValue.backgroundColor = [UIColor whiteColor];
    invoiceDateValue.autocorrectionType = UITextAutocorrectionTypeNo;
    invoiceDateValue.layer.borderColor = [UIColor whiteColor].CGColor;
    invoiceDateValue.backgroundColor = [UIColor whiteColor];
    invoiceDateValue.delegate = self;
    invoiceDateValue.text = currentdate;
    invoiceDateValue.placeholder = @"   Invoice Date";
    
    remarksValue = [[UITextField alloc] init];
    remarksValue.borderStyle = UITextBorderStyleRoundedRect;
    remarksValue.textColor = [UIColor blackColor];
    remarksValue.font = [UIFont systemFontOfSize:18.0];
    remarksValue.backgroundColor = [UIColor whiteColor];
    remarksValue.clearButtonMode = UITextFieldViewModeWhileEditing;
    remarksValue.backgroundColor = [UIColor whiteColor];
    remarksValue.autocorrectionType = UITextAutocorrectionTypeNo;
    remarksValue.layer.borderColor = [UIColor whiteColor].CGColor;
    remarksValue.backgroundColor = [UIColor whiteColor];
    remarksValue.delegate = self;
    remarksValue.placeholder = @"   Remarks";

    /**table header labels */
    
    UILabel *label1 = [[[UILabel alloc] init] autorelease];
    label1.text = @"Item";
    label1.layer.cornerRadius = 12;
    [label1 setTextAlignment:NSTextAlignmentCenter];
    label1.layer.masksToBounds = YES;
    
    label1.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label1.textColor = [UIColor whiteColor];
    //[self.view addSubview:scrollView];
    
    UILabel *label5 = [[[UILabel alloc] init] autorelease];
    label5.text = @"Desc";
    label5.layer.cornerRadius = 12;
    [label5 setTextAlignment:NSTextAlignmentCenter];
    label5.layer.masksToBounds = YES;
    
    label5.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label5.textColor = [UIColor whiteColor];
    
    UILabel *label2 = [[[UILabel alloc] init] autorelease];
    label2.text = @"Price";
    label2.layer.cornerRadius = 12;
    label2.layer.masksToBounds = YES;
    [label2 setTextAlignment:NSTextAlignmentCenter];
    label2.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label2.textColor = [UIColor whiteColor];
    //[self.view addSubview:scrollView];
    
    UILabel *label3 = [[[UILabel alloc] init] autorelease];
    label3.text = @"Qty";
    label3.layer.cornerRadius = 12;
    label3.layer.masksToBounds = YES;
    [label3 setTextAlignment:NSTextAlignmentCenter];
    label3.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label3.textColor = [UIColor whiteColor];
    //[self.view addSubview:scrollView];
    
    UILabel *label4 = [[[UILabel alloc] init] autorelease];
    label4.text = @"Total";
    label4.layer.cornerRadius = 12;
    label4.layer.masksToBounds = YES;
    [label4 setTextAlignment:NSTextAlignmentCenter];
    label4.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label4.textColor = [UIColor whiteColor];
    
    //serchOrderItemTable creation...
    serchOrderItemTable = [[UITableView alloc] init];
    serchOrderItemTable.layer.borderWidth = 1.0;
    serchOrderItemTable.layer.cornerRadius = 4.0;
    serchOrderItemTable.layer.borderColor = [UIColor blackColor].CGColor;
    serchOrderItemTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [serchOrderItemTable setDataSource:self];
    [serchOrderItemTable setDelegate:self];
    serchOrderItemTable.bounces = FALSE;
    
    //OrderItemTable creation...
    orderItemsTable = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, 300, 150)];
    ;
    orderItemsTable.backgroundColor  = [UIColor clearColor];
    //orderItemsTable.layer.borderColor = [UIColor grayColor].CGColor;
    //orderItemsTable.layer.borderWidth = 1.0;
    orderItemsTable.layer.cornerRadius = 4.0;
    orderItemsTable.bounces = FALSE;
    [orderItemsTable setDataSource:self];
    [orderItemsTable setDelegate:self];
    
    //Followings are SubTotal,Tax,TotalAmount labels creation...
    UILabel *subTotal = [[[UILabel alloc] init] autorelease];
    subTotal.text = @"Sub Total";
    subTotal.textColor = [UIColor whiteColor];
    subTotal.backgroundColor = [UIColor clearColor];
    //[self.view addSubview:scrollView];
    UILabel *tax_ = [[[UILabel alloc] init] autorelease];
    
    
    tax_.text = @"Tax 8.25%";
    tax_.textColor = [UIColor whiteColor];
    tax_.backgroundColor = [UIColor clearColor];
    //[self.view addSubview:scrollView];
    
    
    UILabel *totAmount = [[[UILabel alloc] init] autorelease];
    totAmount.text = @"Total Bill";
    totAmount.textColor = [UIColor whiteColor];
    totAmount.backgroundColor = [UIColor clearColor];
    //[self.view addSubview:scrollView];
    
    
    // Disply ActualData of SubTotal,Tax,TotalAmount labels creation...
    subTotalData = [[[UILabel alloc] init] autorelease];
    subTotalData.text = @"0.00";
    subTotalData.textColor = [UIColor whiteColor];
    subTotalData.backgroundColor = [UIColor clearColor];
    //[self.view addSubview:scrollView];
    
    
    taxData = [[[UILabel alloc] init] autorelease];
    taxData.text = @"0.00";
    taxData.textColor = [UIColor whiteColor];
    taxData.backgroundColor = [UIColor clearColor];
    //[self.view addSubview:scrollView];
    
    
    totAmountData = [[[UILabel alloc] init] autorelease];
    totAmountData.text = @"0.00";
    totAmountData.textColor = [UIColor whiteColor];
    totAmountData.backgroundColor = [UIColor clearColor];
    
    /** Order Button */
    orderButton = [[UIButton alloc] init];
    [orderButton addTarget:self
                    action:@selector(orderButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [orderButton setTitle:@"Update" forState:UIControlStateNormal];
    orderButton.layer.cornerRadius = 3.0f;
    orderButton.backgroundColor = [UIColor grayColor];
    [orderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //[self.view addSubview:orderButton];
    
    
    /** Create CancelButton */
    cancelButton = [[UIButton alloc] init];
    [cancelButton addTarget:self
                     action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [cancelButton setTitle:@"Save" forState:UIControlStateNormal];
    cancelButton.layer.cornerRadius = 3.0f;
    cancelButton.backgroundColor = [UIColor grayColor];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // MutabileArray's initialization....
    shipmentIdList = [[NSMutableArray alloc] init];
    skuIdArray = [[NSMutableArray alloc] init];
    ItemArray = [[NSMutableArray alloc] init];
    ItemDiscArray = [[NSMutableArray alloc] init];
    priceArray = [[NSMutableArray alloc] init];
    QtyArray = [[NSMutableArray alloc] init];
    totalArray = [[NSMutableArray alloc] init];
    totalQtyArray = [[NSMutableArray alloc] init];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        shipmentView.frame = CGRectMake(0, 0.0, self.view.frame.size.width, 830.0);
        shipmentView.contentSize = CGSizeMake(self.view.frame.size.width + 200.0, 1500.0);
        
        shipmentId.font = [UIFont boldSystemFontOfSize:20];
        shipmentId.frame = CGRectMake(10, 0.0, 200.0, 55);
        shipmentIdValue.font = [UIFont boldSystemFontOfSize:20];
        shipmentIdValue.frame = CGRectMake(250.0, 0.0, 200.0, 40);
        shipmentIdValue.userInteractionEnabled = NO;
        
        orderId.font = [UIFont boldSystemFontOfSize:20];
        orderId.frame = CGRectMake(460.0, 0.0, 200.0, 55);
        orderIdValue.font = [UIFont boldSystemFontOfSize:20];
        orderIdValue.frame = CGRectMake(700.0, 0.0, 200.0, 40);
        
        shipmentNoteId.font = [UIFont boldSystemFontOfSize:20];
        shipmentNoteId.frame = CGRectMake(10, 60.0, 200.0, 55);
        shipmentNoteIdValue.font = [UIFont boldSystemFontOfSize:20];
        shipmentNoteIdValue.frame = CGRectMake(250.0, 60.0, 200.0, 40);
        
        customerName.font = [UIFont boldSystemFontOfSize:20];
        customerName.frame = CGRectMake(460.0, 60.0, 200.0, 55);
        customerNameValue.font = [UIFont boldSystemFontOfSize:20];
        customerNameValue.frame = CGRectMake(700.0, 60.0, 200.0, 40);
        
        buildingNo.font = [UIFont boldSystemFontOfSize:20];
        buildingNo.frame = CGRectMake(10, 120.0, 200.0, 55);
        buildingNoValue.font = [UIFont boldSystemFontOfSize:20];
        buildingNoValue.frame = CGRectMake(250.0, 120.0, 200.0, 40);
        
        streetName.font = [UIFont boldSystemFontOfSize:20];
        streetName.frame = CGRectMake(460.0, 120.0, 200.0, 55);
        streetNameValue.font = [UIFont boldSystemFontOfSize:20];
        streetNameValue.frame = CGRectMake(700.0, 120.0, 200.0, 40);
        
        city.font = [UIFont boldSystemFontOfSize:20];
        city.frame = CGRectMake(10, 180.0, 200.0, 55);
        cityValue.font = [UIFont boldSystemFontOfSize:20];
        cityValue.frame = CGRectMake(250.0, 180.0, 200.0, 40);
        
        country.font = [UIFont boldSystemFontOfSize:20];
        country.frame = CGRectMake(460.0, 180.0, 200.0, 55);
        countryValue.font = [UIFont boldSystemFontOfSize:20];
        countryValue.frame = CGRectMake(700.0, 180.0, 200.0, 40);
        
        zip_code.font = [UIFont boldSystemFontOfSize:20];
        zip_code.frame = CGRectMake(10, 240.0, 200.0, 55);
        zip_codeValue.font = [UIFont boldSystemFontOfSize:20];
        zip_codeValue.frame = CGRectMake(250.0, 240.0, 200.0, 40);
        
        shipmentAgency.font = [UIFont boldSystemFontOfSize:20];
        shipmentAgency.frame = CGRectMake(460.0, 240.0, 200.0, 55);
        shipmentAgencyValue.font = [UIFont boldSystemFontOfSize:20];
        shipmentAgencyValue.frame = CGRectMake(700.0, 240.0, 200.0, 40);
        
        shipmentCost.font = [UIFont boldSystemFontOfSize:20];
        shipmentCost.frame = CGRectMake(10, 300.0, 200.0, 55);
        shipmentCostValue.font = [UIFont boldSystemFontOfSize:20];
        shipmentCostValue.frame = CGRectMake(250.0, 300.0, 200.0, 40);
        
        insuranceCost.font = [UIFont boldSystemFontOfSize:20];
        insuranceCost.frame = CGRectMake(460.0, 300.0, 200.0, 55);
        insuranceCostValue.font = [UIFont boldSystemFontOfSize:20];
        insuranceCostValue.frame = CGRectMake(700.0, 300.0, 200.0, 40);
        
        paymentTerms.font = [UIFont boldSystemFontOfSize:20];
        paymentTerms.frame = CGRectMake(10, 360.0, 200.0, 55);
        paymentTermsValue.font = [UIFont boldSystemFontOfSize:20];
        paymentTermsValue.frame = CGRectMake(250.0, 360.0, 200.0, 40);
        
        invoiceDate.font = [UIFont boldSystemFontOfSize:20];
        invoiceDate.frame = CGRectMake(460.0, 360.0, 200.0, 55);
        invoiceDateValue.font = [UIFont boldSystemFontOfSize:20];
        invoiceDateValue.frame = CGRectMake(700.0, 360.0, 200.0, 40);
        
        remarks.font = [UIFont boldSystemFontOfSize:20];
        remarks.frame = CGRectMake(10.0, 420.0, 200.0, 55);
        remarksValue.font = [UIFont boldSystemFontOfSize:20];
        remarksValue.frame = CGRectMake(250.0, 420.0, 200.0, 40);
        
        label1.frame = CGRectMake(10, 485.0, 150, 40);
        label1.font = [UIFont boldSystemFontOfSize:20.0];
        
        label5.frame = CGRectMake(161, 485.0, 150, 40);
        label5.font = [UIFont boldSystemFontOfSize:20.0];
        
        label2.frame = CGRectMake(312, 485.0, 150, 40);
        label2.font = [UIFont boldSystemFontOfSize:20.0];
        
        label3.frame = CGRectMake(463, 485.0, 150, 40);
        label3.font = [UIFont boldSystemFontOfSize:20.0];
        
        label4.frame = CGRectMake(614, 485.0, 150, 40);
        label4.font = [UIFont boldSystemFontOfSize:20.0];
        
        orderItemsTable.frame = CGRectMake(10, 535.0, 750, 376);
        
        subTotal.frame = CGRectMake(10,950,300,50);
        subTotal.font = [UIFont boldSystemFontOfSize:25];
        
        tax_.frame = CGRectMake(10,1010,300,50);
        tax_.font = [UIFont boldSystemFontOfSize:25];
        
        totAmount.frame = CGRectMake(10,1070,300,50);
        totAmount.font = [UIFont boldSystemFontOfSize:25];
        
        
        subTotalData.frame = CGRectMake(500,950,200,50);
        subTotalData.font = [UIFont boldSystemFontOfSize:25];
        
        taxData.frame = CGRectMake(500,1010,300,50);
        taxData.font = [UIFont boldSystemFontOfSize:25];
        
        totAmountData.frame = CGRectMake(500,1070,300,50);
        totAmountData.font = [UIFont boldSystemFontOfSize:25];
        
        orderButton.frame = CGRectMake(30, 900.0, 350, 50);
        orderButton.layer.cornerRadius = 22.0f;
        orderButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        cancelButton.frame = CGRectMake(390, 900.0, 350, 50);
        cancelButton.layer.cornerRadius = 22.0f;
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];

    }
    else{
        shipmentView.frame = CGRectMake(0, 0, self.view.frame.size.width, 360);
        shipmentView.contentSize = CGSizeMake(self.view.frame.size.width + 300.0, 900.0);
        
        shipmentId.font = [UIFont boldSystemFontOfSize:15];
        shipmentId.frame = CGRectMake(5, 0.0, 150.0, 35);
        shipmentId.backgroundColor = [UIColor clearColor];
        shipmentIdValue.font = [UIFont boldSystemFontOfSize:15];
        shipmentIdValue.frame = CGRectMake(165.0, 0.0, 150.0, 35.0);
        
        orderId.font = [UIFont boldSystemFontOfSize:15];
        orderId.frame = CGRectMake(325, 0.0, 150.0, 35);
        orderId.backgroundColor = [UIColor clearColor];
        orderIdValue.font = [UIFont boldSystemFontOfSize:15];
        orderIdValue.frame = CGRectMake(450.0, 0.0, 150.0, 35.0);
        
        shipmentNoteId.font = [UIFont boldSystemFontOfSize:15];
        shipmentNoteId.frame = CGRectMake(5, 40.0, 150.0, 35);
        shipmentNoteId.backgroundColor = [UIColor clearColor];
        shipmentNoteIdValue.font = [UIFont boldSystemFontOfSize:15];
        shipmentNoteIdValue.frame = CGRectMake(165.0, 40.0, 150.0, 35);
        
        customerName.font = [UIFont boldSystemFontOfSize:15];
        customerName.frame = CGRectMake(325, 40.0, 150.0, 35);
        customerName.backgroundColor = [UIColor clearColor];
        customerNameValue.font = [UIFont boldSystemFontOfSize:15];
        customerNameValue.frame = CGRectMake(450.0, 40.0, 150.0, 35);
        
        buildingNo.font = [UIFont boldSystemFontOfSize:15];
        buildingNo.frame = CGRectMake(5, 80.0, 150.0, 35.0);
        buildingNo.backgroundColor = [UIColor clearColor];
        buildingNoValue.font = [UIFont boldSystemFontOfSize:15];
        buildingNoValue.frame = CGRectMake(165.0, 80.0, 150.0, 35);
        
        streetName.font = [UIFont boldSystemFontOfSize:15];
        streetName.frame = CGRectMake(325, 80.0, 150.0, 35.0);
        streetName.backgroundColor = [UIColor clearColor];
        streetNameValue.font = [UIFont boldSystemFontOfSize:15];
        streetNameValue.frame = CGRectMake(450.0, 80.0, 150.0, 35.0);
        
        city.font = [UIFont boldSystemFontOfSize:15];
        city.frame = CGRectMake(5, 120.0, 150.0, 35);
        city.backgroundColor = [UIColor clearColor];
        cityValue.font = [UIFont boldSystemFontOfSize:15];
        cityValue.frame = CGRectMake(165.0, 120.0, 150.0, 35.0);
        
        country.font = [UIFont boldSystemFontOfSize:15];
        country.frame = CGRectMake(325, 120.0, 150.0, 35);
        country.backgroundColor = [UIColor clearColor];
        countryValue.font = [UIFont boldSystemFontOfSize:15];
        countryValue.frame = CGRectMake(450.0, 120.0, 150.0, 35);
        
        zip_code.font = [UIFont boldSystemFontOfSize:15];
        zip_code.frame = CGRectMake(5, 160.0, 150.0, 35);
        zip_code.backgroundColor = [UIColor clearColor];
        zip_codeValue.font = [UIFont boldSystemFontOfSize:15];
        zip_codeValue.frame = CGRectMake(165.0, 160.0, 150.0, 35);
        
        shipmentAgency.font = [UIFont boldSystemFontOfSize:15];
        shipmentAgency.frame = CGRectMake(325, 160.0, 150.0, 35);
        shipmentAgency.backgroundColor = [UIColor clearColor];
        shipmentAgencyValue.font = [UIFont boldSystemFontOfSize:15];
        shipmentAgencyValue.frame = CGRectMake(450, 160, 150, 35);
        
        shipmentCost.font = [UIFont boldSystemFontOfSize:15];
        shipmentCost.frame = CGRectMake(5, 200.0, 150.0, 35);
        shipmentCost.backgroundColor = [UIColor clearColor];
        shipmentCostValue.font = [UIFont boldSystemFontOfSize:15];
        shipmentCostValue.frame = CGRectMake(165.0, 200.0, 150.0, 35);
        
        insuranceCost.font = [UIFont boldSystemFontOfSize:15];
        insuranceCost.frame = CGRectMake(325.0, 200.0, 150.0, 35);
        insuranceCost.backgroundColor = [UIColor clearColor];
        insuranceCostValue.font = [UIFont boldSystemFontOfSize:15];
        insuranceCostValue.frame = CGRectMake(450.0, 200.0, 150.0, 35);
        
        paymentTerms.font = [UIFont boldSystemFontOfSize:15];
        paymentTerms.frame = CGRectMake(5, 240.0, 150.0, 35.0);
        paymentTerms.backgroundColor = [UIColor clearColor];
        paymentTermsValue.font = [UIFont boldSystemFontOfSize:15];
        paymentTermsValue.frame = CGRectMake(165.0, 240.0, 150.0, 35.0);
        
        invoiceDate.font = [UIFont boldSystemFontOfSize:15];
        invoiceDate.frame = CGRectMake(325.0, 240.0, 150.0, 35);
        invoiceDate.backgroundColor = [UIColor clearColor];
        invoiceDateValue.font = [UIFont boldSystemFontOfSize:15];
        invoiceDateValue.frame = CGRectMake(450.0, 240.0, 150.0, 35);
        
        remarks.font = [UIFont boldSystemFontOfSize:15];
        remarks.frame = CGRectMake(5, 280.0, 150.0, 35);
        remarks.backgroundColor = [UIColor clearColor];
        remarksValue.font = [UIFont boldSystemFontOfSize:20];
        remarksValue.frame = CGRectMake(165.0, 280.0, 150.0, 35);
        
        label1.frame = CGRectMake(0, 320.0, 60, 25);
        label1.font = [UIFont boldSystemFontOfSize:17];
        
        label5.frame = CGRectMake(61, 320.0, 60, 25);
        label5.font = [UIFont boldSystemFontOfSize:17];
        
        label2.frame = CGRectMake(122, 320.0, 60, 25);
        label2.font = [UIFont boldSystemFontOfSize:17];
        
        label3.frame = CGRectMake(183, 320.0, 60, 25);
        label3.font = [UIFont boldSystemFontOfSize:17];
        
        label4.frame = CGRectMake(244, 320.0, 60, 25);
        label4.font = [UIFont boldSystemFontOfSize:17];
        
        orderItemsTable.frame = CGRectMake(10, 355, 550, 250.0);
        orderItemsTable.hidden = YES;
        
        subTotal.frame = CGRectMake(5,670,150,30);
        subTotal.font = [UIFont boldSystemFontOfSize:17];
        
        tax_.frame = CGRectMake(10,710,150,30);
        tax_.font = [UIFont boldSystemFontOfSize:17];
        
        totAmount.frame = CGRectMake(10,750,180,30);
        totAmount.font = [UIFont boldSystemFontOfSize:17];
        
        subTotalData.frame = CGRectMake(250,670,150,30);
        subTotalData.font = [UIFont boldSystemFontOfSize:17];
        
        taxData.frame = CGRectMake(250,710,150,30);
        taxData.font = [UIFont boldSystemFontOfSize:17];
        
        totAmountData.frame = CGRectMake(250,750,180,30);
        totAmountData.font = [UIFont boldSystemFontOfSize:17];
        
        orderButton.frame = CGRectMake(15, 370, 130, 30);
        orderButton.layer.cornerRadius = 18.0f;
        orderButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        
        cancelButton.frame = CGRectMake(165, 370, 130, 30);
        cancelButton.layer.cornerRadius = 18.0f;
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];

    }
    
    [shipmentView addSubview:shipmentId];
    [shipmentView addSubview:shipmentIdValue];
    [shipmentView addSubview:orderId];
    [shipmentView addSubview:orderIdValue];
    [shipmentView addSubview:shipmentNoteIdValue];
    [shipmentView addSubview:shipmentNoteId];
    [shipmentView addSubview:customerName];
    [shipmentView addSubview:customerNameValue];
    [shipmentView addSubview:buildingNo];
    [shipmentView addSubview:buildingNoValue];
    [shipmentView addSubview:streetName];
    [shipmentView addSubview:streetNameValue];
    [shipmentView addSubview:city];
    [shipmentView addSubview:cityValue];
    [shipmentView addSubview:country];
    [shipmentView addSubview:countryValue];
    [shipmentView addSubview:zip_code];
    [shipmentView addSubview:zip_codeValue];
    [shipmentView addSubview:shipmentAgency];
    [shipmentView addSubview:shipmentAgencyValue];
    [shipmentView addSubview:shipmentCost];
    [shipmentView addSubview:shipmentCostValue];
    [shipmentView addSubview:insuranceCost];
    [shipmentView addSubview:insuranceCostValue];
    [shipmentView addSubview:paymentTerms];
    [shipmentView addSubview:paymentTermsValue];
    [shipmentView addSubview:invoiceDate];
    [shipmentView addSubview:invoiceDateValue];
    [shipmentView addSubview:remarks];
    [shipmentView addSubview:remarksValue];
    [shipmentView addSubview:label1];
    [shipmentView addSubview:label2];
    [shipmentView addSubview:label3];
    [shipmentView addSubview:label4];
    [shipmentView addSubview:label5];
    [shipmentView addSubview:orderItemsTable];
    [shipmentView addSubview:subTotal];
    [shipmentView addSubview:tax_];
    [shipmentView addSubview:totAmount];
    [shipmentView addSubview:subTotalData];
    [shipmentView addSubview:taxData];
    [shipmentView addSubview:totAmountData];
    [self.view addSubview:shipmentView];
    [self.view addSubview:orderButton];
    [self.view addSubview:cancelButton];
    
    [self getShipmentIDDetails];
}

-(void)getShipmentIDDetails{
    
    WHInvoiceServicesSoapBinding *service = [[WHInvoiceServicesSvc WHInvoiceServicesSoapBinding] retain];
    WHInvoiceServicesSvc_getInvoiceDetails *aparams = [[WHInvoiceServicesSvc_getInvoiceDetails alloc] init];
    NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str_ = [time_ componentsSeparatedByString:@" "];
    NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"invoiceId",@"requestHeader", nil];
    
    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",wareEditInvoiceID_],dictionary, nil];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
    
    NSError * err_;
    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
    
    aparams.invoiceDetails = normalStockString;
    WHInvoiceServicesSoapBindingResponse *response = [service getInvoiceDetailsUsingParameters:(WHInvoiceServicesSvc_getInvoiceDetails *)aparams];
    
    NSArray *responseBodyParts =  response.bodyParts;
    NSError *e;
    
    NSDictionary *JSON1 ;
    for (id bodyPart in responseBodyParts) {
        if ([bodyPart isKindOfClass:[WHInvoiceServicesSvc_getInvoiceDetailsResponse class]]) {
            WHInvoiceServicesSvc_getInvoiceDetailsResponse *body = (WHInvoiceServicesSvc_getInvoiceDetailsResponse *)bodyPart;
            NSLog(@"%@",body.return_);
            JSON1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                    options: NSJSONReadingMutableContainers
                                                      error: &e];
            NSDictionary *json = [JSON1 objectForKey:@"responseHeader"];
            
            if ([[json objectForKey:@"responseMessage"] isEqualToString:@"Invoice Details"] && [[json objectForKey:@"responseCode"] isEqualToString:@"0"]) {
                NSArray *temp = [JSON1 objectForKey:@"invoiceItems"];
                for (int i = 0; i < [temp count]; i++) {
                    NSDictionary *itemJson = [temp objectAtIndex:i];
                    [ItemArray addObject:[NSString stringWithFormat:@"%@",[itemJson objectForKey:@"itemDescription"]]];
                    [ItemDiscArray addObject:[NSString stringWithFormat:@"%@",[itemJson objectForKey:@"itemDescription"]]];
                    [priceArray addObject:[NSString stringWithFormat:@"%0.2f",[[itemJson objectForKey:@"price"] floatValue]]];
                    [QtyArray addObject:[NSString stringWithFormat:@"%d",[[itemJson objectForKey:@"quantity"] intValue]]];
                    [totalArray addObject:[NSString stringWithFormat:@"%.02f",[[itemJson objectForKey:@"total"] floatValue]]];
                    [skuIdArray addObject:[NSString stringWithFormat:@"%@",[itemJson objectForKey:@"itemId"]]];
                }
                json = [JSON1 objectForKey:@"invoice"];
                orderIdValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"orderId"]];
                shipmentIdValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"shipmentId"]];
                shipmentNoteIdValue.text =[NSString stringWithFormat:@"%@",[json objectForKey:@"shipmentNoteId"]];
                customerNameValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"customerName"]];
                buildingNoValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"buildingNo"]];
                streetNameValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"streetName"]];
                cityValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"city"]];
                countryValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"country"]];
                zip_codeValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"zip_code"]];
                shipmentAgencyValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"shipmentAgency"]];
                shipmentCostValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"shipmentCost"]];
                insuranceCostValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"insuranceCost"]];
                paymentTermsValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"paymentTerms"]];
                invoiceDateValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"invoiceDate"]];
                remarksValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"remarks"]];
                subTotalData.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"totalItemCost"]];
                taxData.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"tax"]];
                totAmountData.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"totalItemCost"]];
                
                [orderItemsTable reloadData];
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed To Load Data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
            }
        }
    }
}

- (void)textFieldDidChange:(UITextField *)textField {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    if (textField == shipmentIdValue) {
        if ([textField.text length] > 4) {
            shipmentView.scrollEnabled = NO;
            [self getShipmentIds:invoiceEditInvoiceIndex searchString:textField.text];
        }
    }
}

-(void)getShipmentIds:(int)index searchString:(NSString *)searchString{
    
    WHShippingServicesSoapBinding *service = [[WHShippingServicesSvc WHShippingServicesSoapBinding] retain];
    WHShippingServicesSvc_getShipmentIds *aparams = [[WHShippingServicesSvc_getShipmentIds alloc] init];
    NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str_ = [time_ componentsSeparatedByString:@" "];
    NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"shipmentId",@"requestHeader",@"startIndex", nil];
    
    NSArray *loyaltyObjects = [NSArray arrayWithObjects:searchString,dictionary,[NSString stringWithFormat:@"%d",index], nil];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
    
    NSError * err_;
    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
    aparams.shipmentDetails = normalStockString;
    WHShippingServicesSoapBindingResponse *response = [service getShipmentIdsUsingParameters:(WHShippingServicesSvc_getShipmentIds *)aparams];
    
    NSArray *responseBodyParts =  response.bodyParts;
    NSError *e;
    
    NSDictionary *JSON1;
    
    for (id bodyPart in responseBodyParts) {
        if ([bodyPart isKindOfClass:[WHShippingServicesSvc_getShipmentIdsResponse class]]) {
            WHShippingServicesSvc_getShipmentIdsResponse *body = (WHShippingServicesSvc_getShipmentIdsResponse *)bodyPart;
            NSLog(@"%@",body.return_);
            JSON1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                    options: NSJSONReadingMutableContainers
                                                      error: &e];
            NSDictionary *json = [JSON1 objectForKey:@"responseHeader"];
            if ([[json objectForKey:@"responseMessage"] isEqualToString:@"ShipmentDetails"] && [[json objectForKey:@"responseCode"] isEqualToString:@"0"]) {
                NSArray *temp = [JSON1 objectForKey:@"shipmentIds"];
                if ([temp count] == 0) {
                    invoiceIdStatus = FALSE;
                }
                for (int i = 0; i < [temp count]; i++) {
                    [shipmentIdList addObject:[temp objectAtIndex:i]];
                }
                
                shipIdTable.hidden = NO;
                [shipmentView bringSubviewToFront:shipIdTable];
                [shipIdTable reloadData];
            }
            else{
                
            }
        }
    }
}

/** Table started.... */

#pragma mark Table view methods

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == shipIdTable) {
        return [shipmentIdList count];
    }
    else if(tableView == orderItemsTable){
        
        return [ItemArray count];
    }
    else{
        return 0;
    }
}
//Customize eightForRowAtIndexPath ...
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        return 52;
    }
    else{
        
        return 33;
        
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    tableView.separatorColor = [UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.frame = CGRectZero;
    }
    if ([cell.contentView subviews]){
        for (UIView *subview in [cell.contentView subviews]) {
            [subview removeFromSuperview];
        }
    }
    if (tableView == shipIdTable){
        
        cell.textLabel.text = [shipmentIdList objectAtIndex:indexPath.row];
    }
    else if(tableView == orderItemsTable){
        
        if ([ItemArray count] >= 1) {
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                
                // tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                tableView.separatorColor = [UIColor clearColor];
                
                UILabel *label1 = [[[UILabel alloc] initWithFrame:CGRectMake(3, 0, 151, 50)] autorelease];
                label1.font = [UIFont systemFontOfSize:22.0];
                label1.layer.borderWidth = 1.5;
                label1.backgroundColor = [UIColor clearColor];
                label1.textAlignment = NSTextAlignmentCenter;
                label1.numberOfLines = 2;
                label1.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label1.lineBreakMode = NSLineBreakByWordWrapping;
                label1.text = [ItemArray objectAtIndex:(indexPath.row)];
                label1.textColor = [UIColor whiteColor];
                
                UILabel *label5 = [[[UILabel alloc] initWithFrame:CGRectMake(154, 0, 151, 50)] autorelease];
                label5.font = [UIFont systemFontOfSize:22.0];
                label5.layer.borderWidth = 1.5;
                label5.backgroundColor = [UIColor clearColor];
                label5.textAlignment = NSTextAlignmentCenter;
                label5.numberOfLines = 2;
                label5.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label5.lineBreakMode = NSLineBreakByWordWrapping;
                label5.text = [ItemArray objectAtIndex:(indexPath.row)];
                label5.textColor = [UIColor whiteColor];
                
                UILabel *label2 = [[[UILabel alloc] initWithFrame:CGRectMake(305, 0, 150, 50)] autorelease];
                label2.font = [UIFont systemFontOfSize:22.0];
                label2.backgroundColor =  [UIColor clearColor];
                label2.layer.borderWidth = 1.5;
                label2.textAlignment = NSTextAlignmentCenter;
                label2.numberOfLines = 2;
                label2.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label2.text = [priceArray objectAtIndex:(indexPath.row)];
                label2.textColor = [UIColor whiteColor];
                
                
                qtyChange = [UIButton buttonWithType:UIButtonTypeCustom];
                [qtyChange addTarget:self action:@selector(qtyChangePressed:) forControlEvents:UIControlEventTouchDown];
                qtyChange.tag = indexPath.row;
                qtyChange.backgroundColor =  [UIColor clearColor];
                qtyChange.frame = CGRectMake(456, 0, 151, 50);
                
                qtyChange.layer.cornerRadius = 0;
                [qtyChange setTitle:[QtyArray objectAtIndex:(indexPath.row)] forState:UIControlStateNormal];
                [qtyChange setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                qtyChange.titleLabel.font = [UIFont systemFontOfSize:22.0];
                CALayer * layer = [qtyChange layer];
                [layer setMasksToBounds:YES];
                [layer setCornerRadius:0.0];
                [layer setBorderWidth:1.5];
                [layer setBorderColor:[[UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0] CGColor]];
                qtyChange.enabled = NO;
                
                
                UILabel *label4 = [[[UILabel alloc] initWithFrame:CGRectMake(607, 0, 150, 50)] autorelease];
                label4.font = [UIFont systemFontOfSize:22.0];
                label4.layer.borderWidth = 1.5;
                label4.backgroundColor = [UIColor clearColor];
                label4.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label4.textAlignment = NSTextAlignmentCenter;
                label4.textColor = [UIColor whiteColor];
                NSString *str = [totalArray objectAtIndex:(indexPath.row)];
                label4.text = str;
                
                // close button to close the view ..
                delButton = [[[UIButton alloc] init] autorelease];
                [delButton addTarget:self action:@selector(delButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                UIImage *image = [UIImage imageNamed:@"delete.png"];
                delButton.tag = [indexPath row];
                delButton.frame = CGRectMake(767, 2, 45, 45);
                [delButton setBackgroundImage:image	forState:UIControlStateNormal];
                delButton.enabled = NO;
                
                [cell.contentView addSubview:label1];
                [cell.contentView addSubview:label2];
                [cell.contentView addSubview:label5];
                [cell.contentView addSubview:qtyChange];
                [cell.contentView addSubview:label4];
                [cell.contentView addSubview:delButton];
                
            }
            else{
                
                // tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                tableView.separatorColor = [UIColor clearColor];
                
                UILabel *label1 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 68, 34)] autorelease];
                label1.font = [UIFont systemFontOfSize:13.0];
                label1.backgroundColor = [UIColor whiteColor];
                label1.textAlignment = NSTextAlignmentCenter;
                label1.numberOfLines = 2;
                label1.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label1.lineBreakMode = NSLineBreakByWordWrapping;
                label1.text = [ItemArray objectAtIndex:(indexPath.row)];
                
                UILabel *label2 = [[[UILabel alloc] initWithFrame:CGRectMake(66, 0, 68, 34)] autorelease];
                label2.font = [UIFont systemFontOfSize:13.0];
                label2.backgroundColor =  [UIColor whiteColor];
                label2.layer.borderWidth = 1.5;
                label2.textAlignment = NSTextAlignmentCenter;
                label2.numberOfLines = 2;
                label2.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label2.text = [priceArray objectAtIndex:(indexPath.row)];
                
                
                qtyChange = [UIButton buttonWithType:UIButtonTypeCustom];
                [qtyChange addTarget:self action:@selector(qtyChangePressed:) forControlEvents:UIControlEventTouchDown];
                qtyChange.tag = indexPath.row;
                qtyChange.backgroundColor =  [UIColor whiteColor];
                qtyChange.frame = CGRectMake(132, 0, 72, 34);
                qtyChange.layer.cornerRadius = 0;
                [qtyChange setTitle:[QtyArray objectAtIndex:(indexPath.row)] forState:UIControlStateNormal];
                [qtyChange setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                qtyChange.titleLabel.font = [UIFont systemFontOfSize:14.0];
                CALayer * layer = [qtyChange layer];
                [layer setMasksToBounds:YES];
                [layer setCornerRadius:0.0];
                [layer setBorderWidth:1.5];
                [layer setBorderColor:[[UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0] CGColor]];
                
                
                UILabel *label4 = [[[UILabel alloc] initWithFrame:CGRectMake(202, 0, 70, 34)] autorelease];
                label4.font = [UIFont systemFontOfSize:13.0];
                label4.layer.borderWidth = 1.5;
                label4.backgroundColor = [UIColor whiteColor];
                label4.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label4.textAlignment = NSTextAlignmentCenter;
                NSString *str = [totalArray objectAtIndex:(indexPath.row)];
                label4.text = [NSString stringWithFormat:@"%@%@",str,@".0"];
                
                // close button to close the view ..
                delButton = [[[UIButton alloc] init] autorelease];
                [delButton addTarget:self action:@selector(delButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                UIImage *image = [UIImage imageNamed:@"delete.png"];
                delButton.tag = [indexPath row];
                delButton.frame = CGRectMake(274, 7, 22, 22);
                [delButton setBackgroundImage:image	forState:UIControlStateNormal];
                
                
                
                [cell.contentView addSubview:label1];
                [cell.contentView addSubview:label2];
                [cell.contentView addSubview:qtyChange];
                [cell.contentView addSubview:label4];
                [cell.contentView addSubview:delButton];
            }
            
        }
        cell.backgroundColor = [UIColor clearColor];
        
        [cell setTag:indexPath.row];
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    // cell background color...
    UITableViewCell* theCell = [tableView cellForRowAtIndexPath:indexPath];
    theCell.contentView.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:232.0/255.0 blue:124.0/255.0 alpha:1.0];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == shipIdTable) {
        [shipmentId resignFirstResponder];
        shipmentView.scrollEnabled = YES;
        orderButton.enabled = YES;
        cancelButton.enabled = YES;
        shipmentId.text = [shipmentIdList objectAtIndex:indexPath.row];
        shipIdTable.hidden = YES;
        [ItemArray removeAllObjects];
        [ItemDiscArray removeAllObjects];
        [priceArray removeAllObjects];
        [QtyArray removeAllObjects];
        [totalArray removeAllObjects];
        [skuIdArray removeAllObjects];
        WHShippingServicesSoapBinding *service = [[WHShippingServicesSvc WHShippingServicesSoapBinding] retain];
        WHShippingServicesSvc_getShipmentDetails *aparams = [[WHShippingServicesSvc_getShipmentDetails alloc] init];
        NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        NSArray *str_ = [time_ componentsSeparatedByString:@" "];
        NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
        
        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
        NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"shipmentId",@"requestHeader", nil];
        
        NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",[shipmentIdList objectAtIndex:indexPath.row]],dictionary, nil];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        aparams.shipmentDetails = normalStockString;
        WHShippingServicesSoapBindingResponse *response = [service getShipmentDetailsUsingParameters:(WHShippingServicesSvc_getShipmentDetails *)aparams];
        
        NSArray *responseBodyParts =  response.bodyParts;
        NSError *e;
        
        NSDictionary *JSON1 ;
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[WHShippingServicesSvc_getShipmentDetailsResponse class]]) {
                WHShippingServicesSvc_getShipmentDetailsResponse *body = (WHShippingServicesSvc_getShipmentDetailsResponse *)bodyPart;
                NSLog(@"%@",body.return_);
                JSON1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                        options: NSJSONReadingMutableContainers
                                                          error: &e];
                NSDictionary *json = [JSON1 objectForKey:@"responseHeader"];
                
                if ([[json objectForKey:@"responseMessage"] isEqualToString:@"ShipmentDetails"] && [[json objectForKey:@"responseCode"] isEqualToString:@"0"]) {
                    NSArray *temp = [JSON1 objectForKey:@"shipmentItems"];
                    for (int i = 0; i < [temp count]; i++) {
                        NSDictionary *itemJson = [temp objectAtIndex:i];
                        [ItemArray addObject:[NSString stringWithFormat:@"%@",[itemJson objectForKey:@"itemDescription"]]];
                        [ItemDiscArray addObject:[NSString stringWithFormat:@"%@",[itemJson objectForKey:@"itemDescription"]]];
                        [priceArray addObject:[NSString stringWithFormat:@"%0.2f",[[itemJson objectForKey:@"price"] floatValue]]];
                        [QtyArray addObject:[NSString stringWithFormat:@"%d",[[itemJson objectForKey:@"quantity"] intValue]]];
                        [totalArray addObject:[NSString stringWithFormat:@"%.02f",[[itemJson objectForKey:@"total"] floatValue]]];
                        [skuIdArray addObject:[NSString stringWithFormat:@"%@",[itemJson objectForKey:@"itemId"]]];
                    }
                    json = [JSON1 objectForKey:@"shipment"];
                    subTotalData.text = [NSString stringWithFormat:@"%.02f",[[json objectForKey:@"totalCost"] floatValue]];
                    taxData.text = [NSString stringWithFormat:@"%.02f",[[json objectForKey:@"tax"] floatValue]];
                    totAmountData.text = [NSString stringWithFormat:@"%.02f",[[json objectForKey:@"totalCost"] floatValue]];
                    orderItemsTable.hidden = NO;
                    [orderItemsTable reloadData];
                }
                else{
                    
                }
            }
        }
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == shipIdTable) {
        if (invoiceIdStatus) {
            [self getShipmentIds:[shipmentIdList count] searchString:shipmentId.text];
        }
    }
}

- (void) orderButtonPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    NSString *shipmentIdValue_ = [shipmentIdValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *lshipmentNoteValue = [orderIdValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipmentDateValue = [shipmentNoteIdValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipmentModeValue = [customerNameValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipmentAgencyValue_ = [buildingNoValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipmentAgencyContactValue = [streetNameValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *inspectedByValue = [cityValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shippedByValue = [countryValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipmentCostValue_ = [shipmentCostValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipmentLocationValue = [zip_codeValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipmentCityValue = [shipmentAgencyValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipmentStreetValue = [insuranceCostValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *packagesDescriptionValue = [paymentTermsValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *rfidTagNoValue = [invoiceDateValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *gatePassRefValue = [remarksValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([skuIdArray count] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Add Items to Cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else if ([shipmentIdValue_ length] == 0 || [lshipmentNoteValue length] == 0 || [shipmentDateValue length] == 0 || [shipmentModeValue length] == 0 || [shipmentAgencyValue_ length] == 0 || [shipmentAgencyContactValue length] == 0 || [inspectedByValue length] == 0 || [shippedByValue length] == 0 || [rfidTagNoValue length] == 0 || [shipmentCostValue_ length] == 0 || [shipmentLocationValue length] == 0 || [shipmentCityValue length] == 0 || [shipmentStreetValue length] == 0 || [packagesDescriptionValue length] == 0 || [gatePassRefValue length] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Fields couldn't be empty" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else{
        HUD.labelText = @"Creating Invoice..";
        [HUD setHidden:NO];
        
        int totalQuantity = 0;
        NSMutableArray *items = [[NSMutableArray alloc] init];
        for (int i = 0; i < [ItemArray count]; i++) {
            NSArray *keys = [NSArray arrayWithObjects:@"itemId", @"itemDescription",@"color",@"size",@"unitOfMeasurement",@"price",@"quantity",@"total", nil];
            NSArray *objects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",[skuIdArray objectAtIndex:i]],[NSString stringWithFormat:@"%@",[ItemArray objectAtIndex:i]],@"blue",@"35",@"NA",[NSString stringWithFormat:@"%@",[priceArray objectAtIndex:i]],[NSString stringWithFormat:@"%@",[QtyArray objectAtIndex:i]],[NSString stringWithFormat:@"%@",[totalArray objectAtIndex:i]], nil];
            NSDictionary *itemsDic = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            totalQuantity = totalQuantity + [[QtyArray objectAtIndex:i] intValue];
            [items addObject:itemsDic];
        }
        
        WHInvoiceServicesSoapBinding *service = [[WHInvoiceServicesSvc WHInvoiceServicesSoapBinding] retain];
        WHInvoiceServicesSvc_updateInvoice *aparams = [[WHInvoiceServicesSvc_updateInvoice alloc] init];
        NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        NSArray *str_ = [time_ componentsSeparatedByString:@" "];
        NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
        
        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
        NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"invoiceId",@"orderId", @"shipmentId",@"shipmentNoteId",@"customerName",@"buildingNo",@"streetName",@"city",@"country",@"zip_code",@"noOfPackages",@"shipmentAgency",@"totalItemCost",@"shipmentCost",@"tax",@"insuranceCost",@"paymentTerms",@"remarks",@"invoiceDate",@"invoiceStatus",@"invoiceItems",@"requestHeader", nil];
        
        NSArray *loyaltyObjects = [NSArray arrayWithObjects:wareEditInvoiceID_,orderIdValue.text,shipmentIdValue.text,shipmentNoteIdValue.text,customerNameValue.text,buildingNoValue.text,streetNameValue.text,cityValue.text,countryValue.text,zip_codeValue.text,[NSString stringWithFormat:@"%d",totalQuantity],shipmentAgencyValue.text,totAmountData.text,shipmentCostValue.text,taxData.text,insuranceCostValue.text,paymentTermsValue.text,remarksValue.text,invoiceDateValue.text,@"submitted",items,dictionary, nil];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        aparams.invoiceDetails = normalStockString;
        WHInvoiceServicesSoapBindingResponse *response = [service updateInvoiceUsingParameters:(WHInvoiceServicesSvc_updateInvoice *)aparams];
        
        NSArray *responseBodyParts =  response.bodyParts;
        NSError *e;
        
        NSDictionary *JSON1;
        
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[WHInvoiceServicesSvc_updateInvoiceResponse class]]) {
                WHInvoiceServicesSvc_updateInvoiceResponse *body = (WHInvoiceServicesSvc_updateInvoiceResponse *)bodyPart;
                NSLog(@"%@",body.return_);
                JSON1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                        options: NSJSONReadingMutableContainers
                                                          error: &e];
                NSDictionary *responseDic = [JSON1 objectForKey:@"responseHeader"];
                if ([[responseDic objectForKey:@"responseMessage"] isEqualToString:@"Invoice Updated Successfully"] && [[responseDic objectForKey:@"responseCode"] isEqualToString:@"0"]) {
                    NSString *status = [NSString stringWithFormat:@"%@%@%@%@",@"Successfully Invoice Created",@"\n",@"Shipment ID :",[JSON1 objectForKey:@"invoiceId"]];
                    wareEditInvoiceID_ = [[JSON1 objectForKey:@"invoiceId"] copy];
                    SystemSoundID	soundFileObject1;
                    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
                    self.soundFileURLRef = (CFURLRef) [tapSound retain];
                    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                    AudioServicesPlaySystemSound (soundFileObject1);
                    
                    //        NSString *receiptID = [JSON objectForKey:@"receipt_id"];
                    //        receipt = [receiptID copy];
                    UIAlertView *successAlertView  = [[UIAlertView alloc] init];
                    [successAlertView setDelegate:self];
                    [successAlertView setTitle:@"Success"];
                    [successAlertView setMessage:status];
                    [successAlertView addButtonWithTitle:@"OPEN"];
                    [successAlertView addButtonWithTitle:@"NEW"];
                    
                    [successAlertView show];
                    [HUD setHidden:YES];
                    // getting present date & time ..
                    NSDate *today = [NSDate date];
                    NSDateFormatter *f = [[NSDateFormatter alloc] init];
                    [f setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
                    NSString* currentdate = [f stringFromDate:today];
                    [f release];
                    
                    shipmentIdValue.text = nil;
                    orderIdValue.text = nil;
                    invoiceDateValue.text = currentdate;
                    customerNameValue.text = nil;
                    buildingNoValue.text= nil;
                    streetNameValue.text = nil;
                    cityValue.text = nil;
                    countryValue.text= nil;
                    shipmentCostValue.text = nil;
                    zip_codeValue.text = nil;
                    shipmentAgencyValue.text = nil;
                    insuranceCostValue.text = nil;
                    paymentTermsValue.text = nil;
                    shipmentNoteIdValue.text = nil;
                    remarksValue.text = nil;
                    
                    [skuIdArray removeAllObjects];
                    [ItemDiscArray removeAllObjects];
                    [totalArray removeAllObjects];
                    [QtyArray removeAllObjects];
                    [ItemArray removeAllObjects];
                    [totalQtyArray removeAllObjects];
                    
                    subTotalData.text = @"0.00";
                    taxData.text = @"0.00";
                    totAmountData.text = @"0.00";
                    
                    [orderItemsTable reloadData];
                    
                }
                else{
                    [HUD setHidden:YES];
                    SystemSoundID	soundFileObject1;
                    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
                    self.soundFileURLRef = (CFURLRef) [tapSound retain];
                    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                    AudioServicesPlaySystemSound (soundFileObject1);
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed Creating Invoice" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                }
                
            }
        }
    }
}

- (void) cancelButtonPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    NSString *shipmentCostValue_ = [shipmentCost.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([skuIdArray count] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Add Items to Cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else{
        HUD.labelText = @"Saving Invoice..";
        [HUD setHidden:NO];
        
        int totalQuantity = 0;
        NSMutableArray *items = [[NSMutableArray alloc] init];
        for (int i = 0; i < [ItemArray count]; i++) {
            NSArray *keys = [NSArray arrayWithObjects:@"itemId", @"itemDescription",@"color",@"size",@"unitOfMeasurement",@"price",@"quantity",@"total", nil];
            NSArray *objects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",[skuIdArray objectAtIndex:i]],[NSString stringWithFormat:@"%@",[ItemArray objectAtIndex:i]],@"blue",@"35",@"NA",[NSString stringWithFormat:@"%@",[priceArray objectAtIndex:i]],[NSString stringWithFormat:@"%@",[QtyArray objectAtIndex:i]],[NSString stringWithFormat:@"%@",[totalArray objectAtIndex:i]], nil];
            NSDictionary *itemsDic = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            totalQuantity = totalQuantity + [[QtyArray objectAtIndex:i] intValue];
            [items addObject:itemsDic];
        }
        
        WHInvoiceServicesSoapBinding *service = [[WHInvoiceServicesSvc WHInvoiceServicesSoapBinding] retain];
        WHInvoiceServicesSvc_updateInvoice *aparams = [[WHInvoiceServicesSvc_updateInvoice alloc] init];
        NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        NSArray *str_ = [time_ componentsSeparatedByString:@" "];
        NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
        
        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
        NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"invoiceId",@"orderId", @"shipmentId",@"shipmentNoteId",@"customerName",@"buildingNo",@"streetName",@"city",@"country",@"zip_code",@"noOfPackages",@"shipmentAgency",@"totalItemCost",@"shipmentCost",@"tax",@"insuranceCost",@"paymentTerms",@"remarks",@"invoiceDate",@"invoiceStatus",@"invoiceItems",@"requestHeader", nil];
        NSArray *loyaltyObjects;
        if ([shipmentCostValue_ length] == 0) {
            loyaltyObjects = [NSArray arrayWithObjects:wareEditInvoiceID_,orderIdValue.text,shipmentIdValue.text,shipmentNoteIdValue.text,customerNameValue.text,buildingNoValue.text,streetNameValue.text,cityValue.text,countryValue.text,zip_codeValue.text,[NSString stringWithFormat:@"%d",totalQuantity],shipmentAgencyValue.text,totAmountData.text,shipmentCostValue.text,taxData.text,insuranceCostValue.text,paymentTermsValue.text,remarksValue.text,invoiceDate.text,@"submitted",items,dictionary, nil];
        }else{
            loyaltyObjects = [NSArray arrayWithObjects:orderId.text,shipmentId.text,shipmentNoteId.text,customerName.text,buildingNo.text,streetName.text,city.text,country.text,zip_code.text,[NSString stringWithFormat:@"%d",totalQuantity],shipmentAgency.text,totAmountData.text,shipmentCost.text,taxData.text,insuranceCost.text,paymentTerms.text,@"djfhgjd",invoiceDate.text,@"pending",items,dictionary, nil];
        }
        
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        aparams.invoiceDetails = normalStockString;
        WHInvoiceServicesSoapBindingResponse *response = [service updateInvoiceUsingParameters:(WHInvoiceServicesSvc_updateInvoice *)aparams];
        
        NSArray *responseBodyParts =  response.bodyParts;
        NSError *e;
        
        NSDictionary *JSON1;
        
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[WHInvoiceServicesSvc_updateInvoiceResponse class]]) {
                WHInvoiceServicesSvc_updateInvoiceResponse *body = (WHInvoiceServicesSvc_updateInvoiceResponse *)bodyPart;
                NSLog(@"%@",body.return_);
                JSON1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                        options: NSJSONReadingMutableContainers
                                                          error: &e];
                NSDictionary *responseDic = [JSON1 objectForKey:@"responseHeader"];
                if ([[responseDic objectForKey:@"responseMessage"] isEqualToString:@"Invoice Updated Successfully"] && [[responseDic objectForKey:@"responseCode"] isEqualToString:@"0"]) {
                    NSString *status = [NSString stringWithFormat:@"%@%@%@%@",@"Successfully Invoice Created",@"\n",@"Shipment ID :",[JSON1 objectForKey:@"invoiceId"]];
                    wareEditInvoiceID_ = [[JSON1 objectForKey:@"invoiceId"] copy];
                    SystemSoundID	soundFileObject1;
                    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
                    self.soundFileURLRef = (CFURLRef) [tapSound retain];
                    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                    AudioServicesPlaySystemSound (soundFileObject1);
                    
                    //        NSString *receiptID = [JSON objectForKey:@"receipt_id"];
                    //        receipt = [receiptID copy];
                    UIAlertView *successAlertView  = [[UIAlertView alloc] init];
                    [successAlertView setDelegate:self];
                    [successAlertView setTitle:@"Success"];
                    [successAlertView setMessage:status];
                    [successAlertView addButtonWithTitle:@"OPEN"];
                    [successAlertView addButtonWithTitle:@"NEW"];
                    
                    [successAlertView show];
                    [HUD setHidden:YES];
                    // getting present date & time ..
                    NSDate *today = [NSDate date];
                    NSDateFormatter *f = [[NSDateFormatter alloc] init];
                    [f setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
                    NSString* currentdate = [f stringFromDate:today];
                    [f release];
                    
                    shipmentIdValue.text = nil;
                    orderIdValue.text = nil;
                    invoiceDateValue.text = currentdate;
                    customerNameValue.text = nil;
                    buildingNoValue.text= nil;
                    streetNameValue.text = nil;
                    cityValue.text = nil;
                    countryValue.text= nil;
                    shipmentCostValue.text = nil;
                    zip_codeValue.text = nil;
                    shipmentAgencyValue.text = nil;
                    insuranceCostValue.text = nil;
                    paymentTermsValue.text = nil;
                    shipmentNoteIdValue.text = nil;
                    remarksValue.text = nil;
                    
                    [skuIdArray removeAllObjects];
                    [ItemDiscArray removeAllObjects];
                    [totalArray removeAllObjects];
                    [QtyArray removeAllObjects];
                    [ItemArray removeAllObjects];
                    [totalQtyArray removeAllObjects];
                    
                    subTotalData.text = @"0.00";
                    taxData.text = @"0.00";
                    totAmountData.text = @"0.00";
                    
                    [orderItemsTable reloadData];
                    
                }
                else{
                    [HUD setHidden:YES];
                    SystemSoundID	soundFileObject1;
                    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
                    self.soundFileURLRef = (CFURLRef) [tapSound retain];
                    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                    AudioServicesPlaySystemSound (soundFileObject1);
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed Saving Invoice" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                }
                
            }
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    if ([alertView.title isEqualToString:@"Success"]) {
        if (buttonIndex == 0) {
            self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
            self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
            
            ViewWarehouseInvoice *vpo = [[ViewWarehouseInvoice alloc] initWithInvoiceID:wareEditInvoiceID_];
            [self.navigationController pushViewController:vpo animated:YES];
        }
        else{
            self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
            self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
            WarehouseInvoicing *whi = [[WarehouseInvoicing alloc] init];
            [self.navigationController pushViewController:whi animated:YES];
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
