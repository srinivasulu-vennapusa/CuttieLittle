//
//  ViewWarehouseInvoice.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/23/15.
//
//

#import "ViewWarehouseInvoice.h"
#import "OmniHomePage.h"
#import "WHInvoiceServicesSvc.h"
#import "Global.h"
#import "EditWarehouseInvoice.h"
#import "RequestHeader.h"

@interface ViewWarehouseInvoice ()

@end

@implementation ViewWarehouseInvoice

@synthesize soundFileObject,soundFileURLRef;
NSString *wareInvoiceID_ = @"";

-(id) initWithInvoiceID:(NSString *)invoiceID{
    
    wareInvoiceID_ = [invoiceID copy];
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
    titleLbl.text = @"Warehouse Invoice Details";
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
    
    popButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [popButton setImage:[UIImage imageNamed:@"emails-letters.png"] forState:UIControlStateNormal];
    popButton.frame = CGRectMake(0, 0, 40.0, 40.0);
    [popButton addTarget:self action:@selector(popUpView) forControlEvents:UIControlEventTouchUpInside];
    
    sendButton =[[UIBarButtonItem alloc]init];
    sendButton.customView = popButton;
    sendButton.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem=sendButton;
    
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
    
    shipmentIdValue = [[[UILabel alloc] init] autorelease];
    shipmentIdValue.layer.masksToBounds = YES;
    shipmentIdValue.text = @"*******";
    shipmentIdValue.numberOfLines = 2;
    [shipmentIdValue setTextAlignment:NSTextAlignmentLeft];
    shipmentIdValue.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentIdValue.textColor = [UIColor whiteColor];
    
    orderId = [[[UILabel alloc] init] autorelease];
    orderId.text = @"Order ID :";
    orderId.layer.masksToBounds = YES;
    orderId.numberOfLines = 2;
    [orderId setTextAlignment:NSTextAlignmentLeft];
    orderId.font = [UIFont boldSystemFontOfSize:14.0];
    orderId.textColor = [UIColor whiteColor];
    
    orderIdValue = [[[UILabel alloc] init] autorelease];
    orderIdValue.layer.masksToBounds = YES;
    orderIdValue.text = @"*******";
    orderIdValue.numberOfLines = 2;
    [orderIdValue setTextAlignment:NSTextAlignmentLeft];
    orderIdValue.font = [UIFont boldSystemFontOfSize:14.0];
    orderIdValue.textColor = [UIColor whiteColor];
    
    shipmentNoteId = [[[UILabel alloc] init] autorelease];
    shipmentNoteId.text = @"Shipment Note ID :";
    shipmentNoteId.layer.masksToBounds = YES;
    shipmentNoteId.numberOfLines = 2;
    [shipmentNoteId setTextAlignment:NSTextAlignmentLeft];
    shipmentNoteId.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentNoteId.textColor = [UIColor whiteColor];
    
    shipmentNoteIdValue = [[[UILabel alloc] init] autorelease];
    shipmentNoteIdValue.layer.masksToBounds = YES;
    shipmentNoteIdValue.text = @"*******";
    shipmentNoteIdValue.numberOfLines = 2;
    [shipmentNoteIdValue setTextAlignment:NSTextAlignmentLeft];
    shipmentNoteIdValue.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentNoteIdValue.textColor = [UIColor whiteColor];
    
    customerName = [[[UILabel alloc] init] autorelease];
    customerName.text = @"Customer Name :";
    customerName.layer.masksToBounds = YES;
    customerName.numberOfLines = 2;
    [customerName setTextAlignment:NSTextAlignmentLeft];
    customerName.font = [UIFont boldSystemFontOfSize:14.0];
    customerName.textColor = [UIColor whiteColor];
    
    customerNameValue = [[[UILabel alloc] init] autorelease];
    customerNameValue.layer.masksToBounds = YES;
    customerNameValue.text = @"*******";
    customerNameValue.numberOfLines = 2;
    [customerNameValue setTextAlignment:NSTextAlignmentLeft];
    customerNameValue.font = [UIFont boldSystemFontOfSize:14.0];
    customerNameValue.textColor = [UIColor whiteColor];

    buildingNo = [[[UILabel alloc] init] autorelease];
    buildingNo.text = @"Building No. :";
    buildingNo.layer.masksToBounds = YES;
    buildingNo.numberOfLines = 2;
    [buildingNo setTextAlignment:NSTextAlignmentLeft];
    buildingNo.font = [UIFont boldSystemFontOfSize:14.0];
    buildingNo.textColor = [UIColor whiteColor];
    
    buildingNoValue = [[[UILabel alloc] init] autorelease];
    buildingNoValue.layer.masksToBounds = YES;
    buildingNoValue.text = @"*******";
    buildingNoValue.numberOfLines = 2;
    [buildingNoValue setTextAlignment:NSTextAlignmentLeft];
    buildingNoValue.font = [UIFont boldSystemFontOfSize:14.0];
    buildingNoValue.textColor = [UIColor whiteColor];
    
    streetName = [[[UILabel alloc] init] autorelease];
    streetName.text = @"Street Name :";
    streetName.layer.masksToBounds = YES;
    streetName.numberOfLines = 2;
    [streetName setTextAlignment:NSTextAlignmentLeft];
    streetName.font = [UIFont boldSystemFontOfSize:14.0];
    streetName.textColor = [UIColor whiteColor];
    
    streetNameValue = [[[UILabel alloc] init] autorelease];
    streetNameValue.layer.masksToBounds = YES;
    streetNameValue.text = @"*******";
    streetNameValue.numberOfLines = 2;
    [streetNameValue setTextAlignment:NSTextAlignmentLeft];
    streetNameValue.font = [UIFont boldSystemFontOfSize:14.0];
    streetNameValue.textColor = [UIColor whiteColor];
    
    city = [[[UILabel alloc] init] autorelease];
    city.text = @"City :";
    city.layer.masksToBounds = YES;
    city.numberOfLines = 2;
    [city setTextAlignment:NSTextAlignmentLeft];
    city.font = [UIFont boldSystemFontOfSize:14.0];
    city.textColor = [UIColor whiteColor];
    
    cityValue = [[[UILabel alloc] init] autorelease];
    cityValue.layer.masksToBounds = YES;
    cityValue.text = @"*******";
    cityValue.numberOfLines = 2;
    [cityValue setTextAlignment:NSTextAlignmentLeft];
    cityValue.font = [UIFont boldSystemFontOfSize:14.0];
    cityValue.textColor = [UIColor whiteColor];
    
    country = [[[UILabel alloc] init] autorelease];
    country.text = @"Country :";
    country.layer.masksToBounds = YES;
    country.numberOfLines = 2;
    [country setTextAlignment:NSTextAlignmentLeft];
    country.font = [UIFont boldSystemFontOfSize:14.0];
    country.textColor = [UIColor whiteColor];
    
    countryValue = [[[UILabel alloc] init] autorelease];
    countryValue.layer.masksToBounds = YES;
    countryValue.text = @"*******";
    countryValue.numberOfLines = 2;
    [countryValue setTextAlignment:NSTextAlignmentLeft];
    countryValue.font = [UIFont boldSystemFontOfSize:14.0];
    countryValue.textColor = [UIColor whiteColor];
    
    zip_code = [[[UILabel alloc] init] autorelease];
    zip_code.text = @"Zip Code :";
    zip_code.layer.masksToBounds = YES;
    zip_code.numberOfLines = 2;
    [zip_code setTextAlignment:NSTextAlignmentLeft];
    zip_code.font = [UIFont boldSystemFontOfSize:14.0];
    zip_code.textColor = [UIColor whiteColor];
    
    zip_codeValue = [[[UILabel alloc] init] autorelease];
    zip_codeValue.layer.masksToBounds = YES;
    zip_codeValue.text = @"*******";
    zip_codeValue.numberOfLines = 2;
    [zip_codeValue setTextAlignment:NSTextAlignmentLeft];
    zip_codeValue.font = [UIFont boldSystemFontOfSize:14.0];
    zip_codeValue.textColor = [UIColor whiteColor];
    
    shipmentAgency = [[[UILabel alloc] init] autorelease];
    shipmentAgency.text = @"Shipment Agency :";
    shipmentAgency.layer.masksToBounds = YES;
    shipmentAgency.numberOfLines = 2;
    [shipmentAgency setTextAlignment:NSTextAlignmentLeft];
    shipmentAgency.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentAgency.textColor = [UIColor whiteColor];
    
    shipmentAgencyValue = [[[UILabel alloc] init] autorelease];
    shipmentAgencyValue.layer.masksToBounds = YES;
    shipmentAgencyValue.text = @"*******";
    shipmentAgencyValue.numberOfLines = 2;
    [shipmentAgencyValue setTextAlignment:NSTextAlignmentLeft];
    shipmentAgencyValue.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentAgencyValue.textColor = [UIColor whiteColor];

    shipmentCost = [[[UILabel alloc] init] autorelease];
    shipmentCost.text = @"Shipment Cost :";
    shipmentCost.layer.masksToBounds = YES;
    shipmentCost.numberOfLines = 2;
    [shipmentCost setTextAlignment:NSTextAlignmentLeft];
    shipmentCost.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentCost.textColor = [UIColor whiteColor];
    
    shipmentCostValue = [[[UILabel alloc] init] autorelease];
    shipmentCostValue.layer.masksToBounds = YES;
    shipmentCostValue.text = @"*******";
    shipmentCostValue.numberOfLines = 2;
    [shipmentCostValue setTextAlignment:NSTextAlignmentLeft];
    shipmentCostValue.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentCostValue.textColor = [UIColor whiteColor];
    
    insuranceCost = [[[UILabel alloc] init] autorelease];
    insuranceCost.text = @"Insurance Cost :";
    insuranceCost.layer.masksToBounds = YES;
    insuranceCost.numberOfLines = 2;
    [insuranceCost setTextAlignment:NSTextAlignmentLeft];
    insuranceCost.font = [UIFont boldSystemFontOfSize:14.0];
    insuranceCost.textColor = [UIColor whiteColor];
    
    insuranceCostValue = [[[UILabel alloc] init] autorelease];
    insuranceCostValue.layer.masksToBounds = YES;
    insuranceCostValue.text = @"*******";
    insuranceCostValue.numberOfLines = 2;
    [insuranceCostValue setTextAlignment:NSTextAlignmentLeft];
    insuranceCostValue.font = [UIFont boldSystemFontOfSize:14.0];
    insuranceCostValue.textColor = [UIColor whiteColor];

    paymentTerms = [[[UILabel alloc] init] autorelease];
    paymentTerms.text = @"Payment Terms :";
    paymentTerms.layer.masksToBounds = YES;
    paymentTerms.numberOfLines = 2;
    [paymentTerms setTextAlignment:NSTextAlignmentLeft];
    paymentTerms.font = [UIFont boldSystemFontOfSize:14.0];
    paymentTerms.textColor = [UIColor whiteColor];
    
    paymentTermsValue = [[[UILabel alloc] init] autorelease];
    paymentTermsValue.layer.masksToBounds = YES;
    paymentTermsValue.text = @"*******";
    paymentTermsValue.numberOfLines = 2;
    [paymentTermsValue setTextAlignment:NSTextAlignmentLeft];
    paymentTermsValue.font = [UIFont boldSystemFontOfSize:14.0];
    paymentTermsValue.textColor = [UIColor whiteColor];
    
    invoiceDate = [[[UILabel alloc] init] autorelease];
    invoiceDate.text = @"Invoice Date :";
    invoiceDate.layer.masksToBounds = YES;
    invoiceDate.numberOfLines = 2;
    [invoiceDate setTextAlignment:NSTextAlignmentLeft];
    invoiceDate.font = [UIFont boldSystemFontOfSize:14.0];
    invoiceDate.textColor = [UIColor whiteColor];
    
    invoiceDateValue = [[[UILabel alloc] init] autorelease];
    invoiceDateValue.layer.masksToBounds = YES;
    invoiceDateValue.text = @"*******";
    invoiceDateValue.numberOfLines = 2;
    [invoiceDateValue setTextAlignment:NSTextAlignmentLeft];
    invoiceDateValue.font = [UIFont boldSystemFontOfSize:14.0];
    invoiceDateValue.textColor = [UIColor whiteColor];
    
    remarks = [[[UILabel alloc] init] autorelease];
    remarks.text = @"Remarks :";
    remarks.layer.masksToBounds = YES;
    remarks.numberOfLines = 2;
    [remarks setTextAlignment:NSTextAlignmentLeft];
    remarks.font = [UIFont boldSystemFontOfSize:14.0];
    remarks.textColor = [UIColor whiteColor];
    
    remarksValue = [[[UILabel alloc] init] autorelease];
    remarksValue.layer.masksToBounds = YES;
    remarksValue.text = @"*******";
    remarksValue.numberOfLines = 2;
    [remarksValue setTextAlignment:NSTextAlignmentLeft];
    remarksValue.font = [UIFont boldSystemFontOfSize:14.0];
    remarksValue.textColor = [UIColor whiteColor];
    
    UILabel *label2 = [[[UILabel alloc] init] autorelease];
    label2.text = @"Item Id";
    label2.layer.cornerRadius = 14;
    label2.layer.masksToBounds = YES;
    label2.numberOfLines = 2;
    [label2 setTextAlignment:NSTextAlignmentCenter];
    label2.font = [UIFont boldSystemFontOfSize:14.0];
    label2.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label2.textColor = [UIColor whiteColor];
    
    UILabel *label11 = [[[UILabel alloc] init] autorelease];
    label11.text = @"Item Name";
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
    label4.text = @"Quantity";
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
    label8.text = @"Model";
    label8.layer.cornerRadius = 14;
    label8.layer.masksToBounds = YES;
    [label8 setTextAlignment:NSTextAlignmentCenter];
    label8.font = [UIFont boldSystemFontOfSize:14.0];
    label8.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label8.textColor = [UIColor whiteColor];
    
    UILabel *label9 = [[[UILabel alloc] init] autorelease];
    label9.text = @"Color";
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
    
    // Table for storing the items ..
    cartTable = [[UITableView alloc] init];
    cartTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    cartTable.backgroundColor = [UIColor clearColor];
    [cartTable setDataSource:self];
    [cartTable setDelegate:self];

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
    
    itemIdArray = [[NSMutableArray alloc] init];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        shipmentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        shipmentView.contentSize = CGSizeMake(self.view.frame.size.width + 200, self.view.frame.size.height);
        
        shipmentId.font = [UIFont boldSystemFontOfSize:20];
        shipmentId.frame = CGRectMake(10, 0.0, 200.0, 55);
        shipmentIdValue.font = [UIFont boldSystemFontOfSize:20];
        shipmentIdValue.frame = CGRectMake(250.0, 0.0, 200.0, 55);
        
        orderId.font = [UIFont boldSystemFontOfSize:20];
        orderId.frame = CGRectMake(460.0, 0.0, 200.0, 55);
        orderIdValue.font = [UIFont boldSystemFontOfSize:20];
        orderIdValue.frame = CGRectMake(700.0, 0.0, 200.0, 55);
        
        shipmentNoteId.font = [UIFont boldSystemFontOfSize:20];
        shipmentNoteId.frame = CGRectMake(10, 60.0, 200.0, 55);
        shipmentNoteIdValue.font = [UIFont boldSystemFontOfSize:20];
        shipmentNoteIdValue.frame = CGRectMake(250.0, 60.0, 200.0, 55);
        
        customerName.font = [UIFont boldSystemFontOfSize:20];
        customerName.frame = CGRectMake(460.0, 60.0, 200.0, 55);
        customerNameValue.font = [UIFont boldSystemFontOfSize:20];
        customerNameValue.frame = CGRectMake(700.0, 60.0, 200.0, 55);
        
        buildingNo.font = [UIFont boldSystemFontOfSize:20];
        buildingNo.frame = CGRectMake(10, 120.0, 200.0, 55);
        buildingNoValue.font = [UIFont boldSystemFontOfSize:20];
        buildingNoValue.frame = CGRectMake(250.0, 120.0, 200.0, 55);
        
        streetName.font = [UIFont boldSystemFontOfSize:20];
        streetName.frame = CGRectMake(460.0, 120.0, 200.0, 55);
        streetNameValue.font = [UIFont boldSystemFontOfSize:20];
        streetNameValue.frame = CGRectMake(700.0, 120.0, 200.0, 55);
        
        city.font = [UIFont boldSystemFontOfSize:20];
        city.frame = CGRectMake(10, 180.0, 200.0, 55);
        cityValue.font = [UIFont boldSystemFontOfSize:20];
        cityValue.frame = CGRectMake(250.0, 180.0, 200.0, 55);
        
        country.font = [UIFont boldSystemFontOfSize:20];
        country.frame = CGRectMake(460.0, 180.0, 200.0, 55);
        countryValue.font = [UIFont boldSystemFontOfSize:20];
        countryValue.frame = CGRectMake(700.0, 180.0, 200.0, 55);
        
        zip_code.font = [UIFont boldSystemFontOfSize:20];
        zip_code.frame = CGRectMake(10, 240.0, 200.0, 55);
        zip_codeValue.font = [UIFont boldSystemFontOfSize:20];
        zip_codeValue.frame = CGRectMake(250.0, 240.0, 200.0, 55);
        
        shipmentAgency.font = [UIFont boldSystemFontOfSize:20];
        shipmentAgency.frame = CGRectMake(460.0, 240.0, 200.0, 55);
        shipmentAgencyValue.font = [UIFont boldSystemFontOfSize:20];
        shipmentAgencyValue.frame = CGRectMake(700.0, 240.0, 200.0, 55);
        
        shipmentCost.font = [UIFont boldSystemFontOfSize:20];
        shipmentCost.frame = CGRectMake(10, 300.0, 200.0, 55);
        shipmentCostValue.font = [UIFont boldSystemFontOfSize:20];
        shipmentCostValue.frame = CGRectMake(250.0, 300.0, 200.0, 55);
        
        insuranceCost.font = [UIFont boldSystemFontOfSize:20];
        insuranceCost.frame = CGRectMake(460.0, 300.0, 200.0, 55);
        insuranceCostValue.font = [UIFont boldSystemFontOfSize:20];
        insuranceCostValue.frame = CGRectMake(700.0, 300.0, 200.0, 55);
        
        paymentTerms.font = [UIFont boldSystemFontOfSize:20];
        paymentTerms.frame = CGRectMake(10, 360.0, 200.0, 55);
        paymentTermsValue.font = [UIFont boldSystemFontOfSize:20];
        paymentTermsValue.frame = CGRectMake(250.0, 360.0, 200.0, 55);
        
        invoiceDate.font = [UIFont boldSystemFontOfSize:20];
        invoiceDate.frame = CGRectMake(460.0, 360.0, 200.0, 55);
        invoiceDateValue.font = [UIFont boldSystemFontOfSize:20];
        invoiceDateValue.frame = CGRectMake(700.0, 360.0, 200.0, 55);
        
        remarks.font = [UIFont boldSystemFontOfSize:20];
        remarks.frame = CGRectMake(460.0, 420.0, 200.0, 55);
        remarksValue.font = [UIFont boldSystemFontOfSize:20];
        remarksValue.frame = CGRectMake(700.0, 420.0, 200.0, 55);

        label2.font = [UIFont boldSystemFontOfSize:20];
        label2.frame = CGRectMake(10, 485.0, 90, 55);
        label11.font = [UIFont boldSystemFontOfSize:20];
        label11.frame = CGRectMake(103, 485.0, 90, 55);
        label3.font = [UIFont boldSystemFontOfSize:20];
        label3.frame = CGRectMake(195, 485.0, 90, 55);
        label4.font = [UIFont boldSystemFontOfSize:20];
        label4.frame = CGRectMake(288, 485.0, 90, 55);
        label5.font = [UIFont boldSystemFontOfSize:20];
        label5.frame = CGRectMake(381, 485.0, 110, 55);
        label12.font = [UIFont boldSystemFontOfSize:20];
        label12.frame = CGRectMake(494, 485.0, 110, 55);
        label8.font = [UIFont boldSystemFontOfSize:20];
        label8.frame = CGRectMake(607, 485.0, 110, 55);
        label9.font = [UIFont boldSystemFontOfSize:20];
        label9.frame = CGRectMake(720.0, 485.0, 110, 55);
        label10.font = [UIFont boldSystemFontOfSize:20];
        label10.frame = CGRectMake(833.0, 485.0, 110, 55);
        
        cartTable.frame = CGRectMake(10, 550, 980.0,235.0);
        
        subTotal.frame = CGRectMake(10,795,300,50);
        subTotal.font = [UIFont boldSystemFontOfSize:25];
        
        tax_.frame = CGRectMake(10,855,300,50);
        tax_.font = [UIFont boldSystemFontOfSize:25];
        
        totAmount.frame = CGRectMake(10,915,300,50);
        totAmount.font = [UIFont boldSystemFontOfSize:25];
        
        
        subTotalData.frame = CGRectMake(500,795,200,50);
        subTotalData.font = [UIFont boldSystemFontOfSize:25];
        
        taxData.frame = CGRectMake(500,855,300,50);
        taxData.font = [UIFont boldSystemFontOfSize:25];
        
        totAmountData.frame = CGRectMake(500,915,300,50);
        totAmountData.font = [UIFont boldSystemFontOfSize:25];

    }
    else{
        
        shipmentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        shipmentView.contentSize = CGSizeMake(self.view.frame.size.width + 250.0, 800.0);
        
        shipmentId.font = [UIFont boldSystemFontOfSize:15];
        shipmentId.frame = CGRectMake(5, 0.0, 150.0, 35);
        shipmentId.backgroundColor = [UIColor clearColor];
        shipmentIdValue.font = [UIFont boldSystemFontOfSize:15];
        shipmentIdValue.frame = CGRectMake(165.0, 0.0, 150.0, 35.0);
        shipmentIdValue.backgroundColor = [UIColor clearColor];
        
        orderId.font = [UIFont boldSystemFontOfSize:15];
        orderId.frame = CGRectMake(325, 0.0, 150.0, 35);
        orderId.backgroundColor = [UIColor clearColor];
        orderIdValue.font = [UIFont boldSystemFontOfSize:15];
        orderIdValue.frame = CGRectMake(450.0, 0.0, 150.0, 35.0);
        orderIdValue.backgroundColor = [UIColor clearColor];
        
        shipmentNoteId.font = [UIFont boldSystemFontOfSize:15];
        shipmentNoteId.frame = CGRectMake(5, 40.0, 150.0, 35);
        shipmentNoteId.backgroundColor = [UIColor clearColor];
        shipmentNoteIdValue.font = [UIFont boldSystemFontOfSize:15];
        shipmentNoteIdValue.frame = CGRectMake(165.0, 40.0, 150.0, 35);
        shipmentNoteIdValue.backgroundColor = [UIColor clearColor];
        
        customerName.font = [UIFont boldSystemFontOfSize:15];
        customerName.frame = CGRectMake(325, 40.0, 150.0, 35);
        customerName.backgroundColor = [UIColor clearColor];
        customerNameValue.font = [UIFont boldSystemFontOfSize:15];
        customerNameValue.frame = CGRectMake(450.0, 40.0, 150.0, 35);
        customerNameValue.backgroundColor = [UIColor clearColor];
        
        buildingNo.font = [UIFont boldSystemFontOfSize:15];
        buildingNo.frame = CGRectMake(5, 80.0, 150.0, 35.0);
        buildingNo.backgroundColor = [UIColor clearColor];
        buildingNoValue.font = [UIFont boldSystemFontOfSize:15];
        buildingNoValue.frame = CGRectMake(165.0, 80.0, 150.0, 35);
        buildingNoValue.backgroundColor = [UIColor clearColor];
        
        streetName.font = [UIFont boldSystemFontOfSize:15];
        streetName.frame = CGRectMake(325, 80.0, 150.0, 35.0);
        streetName.backgroundColor = [UIColor clearColor];
        streetNameValue.font = [UIFont boldSystemFontOfSize:15];
        streetNameValue.frame = CGRectMake(450.0, 80.0, 150.0, 35.0);
        streetNameValue.backgroundColor = [UIColor clearColor];
        
        city.font = [UIFont boldSystemFontOfSize:15];
        city.frame = CGRectMake(5, 120.0, 150.0, 35);
        city.backgroundColor = [UIColor clearColor];
        cityValue.font = [UIFont boldSystemFontOfSize:15];
        cityValue.frame = CGRectMake(1650.0, 120.0, 150.0, 35.0);
        cityValue.backgroundColor = [UIColor clearColor];
        
        country.font = [UIFont boldSystemFontOfSize:15];
        country.frame = CGRectMake(325, 120.0, 150.0, 35);
        country.backgroundColor = [UIColor clearColor];
        countryValue.font = [UIFont boldSystemFontOfSize:15];
        countryValue.frame = CGRectMake(450.0, 120.0, 150.0, 35);
        countryValue.backgroundColor = [UIColor clearColor];
        
        zip_code.font = [UIFont boldSystemFontOfSize:15];
        zip_code.frame = CGRectMake(5, 160.0, 150.0, 35);
        zip_code.backgroundColor = [UIColor clearColor];
        zip_codeValue.font = [UIFont boldSystemFontOfSize:15];
        zip_codeValue.frame = CGRectMake(165.0, 160.0, 150.0, 35);
        zip_codeValue.backgroundColor = [UIColor clearColor];
        
        shipmentAgency.font = [UIFont boldSystemFontOfSize:15];
        shipmentAgency.frame = CGRectMake(325, 160.0, 150.0, 35);
        shipmentAgency.backgroundColor = [UIColor clearColor];
        shipmentAgencyValue.font = [UIFont boldSystemFontOfSize:15];
        shipmentAgencyValue.frame = CGRectMake(450, 160, 150, 35);
        shipmentAgencyValue.backgroundColor = [UIColor clearColor];
        
        shipmentCost.font = [UIFont boldSystemFontOfSize:15];
        shipmentCost.frame = CGRectMake(5, 200.0, 150.0, 35);
        shipmentCost.backgroundColor = [UIColor clearColor];
        shipmentCostValue.font = [UIFont boldSystemFontOfSize:15];
        shipmentCostValue.frame = CGRectMake(165.0, 200.0, 150.0, 35);
        shipmentCostValue.backgroundColor = [UIColor clearColor];
        
        insuranceCost.font = [UIFont boldSystemFontOfSize:15];
        insuranceCost.frame = CGRectMake(325.0, 200.0, 150.0, 35);
        insuranceCost.backgroundColor = [UIColor clearColor];
        insuranceCostValue.font = [UIFont boldSystemFontOfSize:15];
        insuranceCostValue.frame = CGRectMake(450.0, 200.0, 150.0, 35);
        insuranceCostValue.backgroundColor = [UIColor clearColor];
        
        paymentTerms.font = [UIFont boldSystemFontOfSize:15];
        paymentTerms.frame = CGRectMake(5, 240.0, 150.0, 35.0);
        paymentTerms.backgroundColor = [UIColor clearColor];
        paymentTermsValue.font = [UIFont boldSystemFontOfSize:15];
        paymentTermsValue.frame = CGRectMake(165.0, 240.0, 150.0, 35.0);
        paymentTermsValue.backgroundColor = [UIColor clearColor];
        
        invoiceDate.font = [UIFont boldSystemFontOfSize:15];
        invoiceDate.frame = CGRectMake(325.0, 240.0, 150.0, 35);
        invoiceDate.backgroundColor = [UIColor clearColor];
        invoiceDateValue.font = [UIFont boldSystemFontOfSize:15];
        invoiceDateValue.frame = CGRectMake(450.0, 240.0, 150.0, 35);
        invoiceDateValue.backgroundColor = [UIColor clearColor];
        
        remarks.font = [UIFont boldSystemFontOfSize:15];
        remarks.frame = CGRectMake(5, 280.0, 150.0, 35);
        remarks.backgroundColor = [UIColor clearColor];
        remarksValue.font = [UIFont boldSystemFontOfSize:20];
        remarksValue.frame = CGRectMake(165.0, 280.0, 150.0, 35);
        remarksValue.backgroundColor = [UIColor clearColor];

        label2.font = [UIFont boldSystemFontOfSize:15];
        label2.frame = CGRectMake(10, 320.0, 90, 35);
        label11.font = [UIFont boldSystemFontOfSize:15];
        label11.frame = CGRectMake(103, 320.0, 90, 35);
        label3.font = [UIFont boldSystemFontOfSize:15];
        label3.frame = CGRectMake(195, 320.0, 90, 35);
        label4.font = [UIFont boldSystemFontOfSize:15];
        label4.frame = CGRectMake(288, 320.0, 90, 35);
        label5.font = [UIFont boldSystemFontOfSize:15];
        label5.frame = CGRectMake(381, 320.0, 110, 35);
        
        cartTable.frame = CGRectMake(10, 360.0, 980.0,230.0);
        
        subTotal.frame = CGRectMake(5,600.0,150.0,35.0);
        subTotal.font = [UIFont boldSystemFontOfSize:15];
        
        tax_.frame = CGRectMake(5,645,150,35);
        tax_.font = [UIFont boldSystemFontOfSize:15];
        
        totAmount.frame = CGRectMake(5,690,150,35);
        totAmount.font = [UIFont boldSystemFontOfSize:15];
        
        
        subTotalData.frame = CGRectMake(200,600.0,150.0,35);
        subTotalData.font = [UIFont boldSystemFontOfSize:15];
        
        taxData.frame = CGRectMake(200,645.0,150,35);
        taxData.font = [UIFont boldSystemFontOfSize:15];
        
        totAmountData.frame = CGRectMake(200,690,150,35);
        totAmountData.font = [UIFont boldSystemFontOfSize:15];
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
    [shipmentView addSubview:label10];
    [shipmentView addSubview:label11];
    [shipmentView addSubview:label12];
    [shipmentView addSubview:label2];
    [shipmentView addSubview:label3];
    [shipmentView addSubview:label4];
    [shipmentView addSubview:label5];
    [shipmentView addSubview:label8];
    [shipmentView addSubview:label9];
    [shipmentView addSubview:cartTable];
    [shipmentView addSubview:subTotal];
    [shipmentView addSubview:subTotalData];
    [shipmentView addSubview:tax_];
    [shipmentView addSubview:taxData];
    [shipmentView addSubview:totAmount];
    [shipmentView addSubview:totAmountData];
    
    [self.view addSubview:shipmentView];
    
    [self getShipmentIDDetails];
}

-(void)popUpView {
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
    [folderStructure addObject:@"Edit Invoice"];
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
        
        popOverViewController.contentSizeForViewInPopover = CGSizeMake(160.0, 150.0);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:popOverViewController];
        // popover.contentViewController.view.alpha = 0.0;
        [[[popover contentViewController]  view] setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:1.0f]];
        [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        self.popOver = popover;
    }
}

-(void) buttonClicked1:(UIButton*)sender
{
    [self.popOver dismissPopoverAnimated:YES];
    AudioServicesPlaySystemSound (soundFileObject);
    if (sender.tag == 0) {
        
        [self.popOver dismissPopoverAnimated:YES];
        OmniHomePage *home = [[[OmniHomePage alloc] init] autorelease];
        [self.navigationController pushViewController:home animated:YES];
    }
    else if (sender.tag == 1) {
        
        //        if ([statusValue.text isEqualToString:@"Pending"]) {
        
        self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
        self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
        
        EditWarehouseInvoice *editReceipt = [[EditWarehouseInvoice alloc] initWithInvoiceID:wareInvoiceID_];
        [self.navigationController pushViewController:editReceipt animated:YES];
        //        }
        //        else {
        //
        //            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Issue cannot be edited" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //            [alert show];
        //
        //        }
    }
    else{
        [self.popOver dismissPopoverAnimated:YES];
        OmniHomePage *omniRetailerViewController = [[OmniHomePage alloc] init];
        [omniRetailerViewController logOut];
    }
}

-(void)getShipmentIDDetails{
    
    WHInvoiceServicesSoapBinding *service = [[WHInvoiceServicesSvc WHInvoiceServicesSoapBinding] retain];
    WHInvoiceServicesSvc_getInvoiceDetails *aparams = [[WHInvoiceServicesSvc_getInvoiceDetails alloc] init];
    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"invoiceId",@"requestHeader", nil];
    
    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",wareInvoiceID_],[RequestHeader getRequestHeader], nil];
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
                itemIdArray = [[NSMutableArray alloc] initWithArray:[JSON1 objectForKey:@"invoiceItems"]];
                
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
                
                [cartTable reloadData];
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed To Load Data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
            }
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [itemIdArray count];
}


//heigth for tableviewcell
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


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    tableView.separatorColor = [UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0];
    
    
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
        
        NSDictionary *temp = [itemIdArray objectAtIndex:indexPath.row];
        
        UILabel *item_code = [[[UILabel alloc] init] autorelease];
        item_code.layer.borderWidth = 1.5;
        item_code.font = [UIFont systemFontOfSize:13.0];
        item_code.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        item_code.backgroundColor = [UIColor blackColor];
        item_code.textColor = [UIColor whiteColor];
        
        item_code.text = [NSString stringWithFormat:@"%@",[temp objectForKey:@"itemId"]];
        item_code.textAlignment=NSTextAlignmentCenter;
        item_code.adjustsFontSizeToFitWidth = YES;
        //name.adjustsFontSizeToFitWidth = YES;
        
        UILabel *item_description = [[[UILabel alloc] init] autorelease];
        item_description.layer.borderWidth = 1.5;
        item_description.font = [UIFont systemFontOfSize:13.0];
        item_description.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        item_description.backgroundColor = [UIColor blackColor];
        item_description.textColor = [UIColor whiteColor];
        
        item_description.text = [NSString stringWithFormat:@"%@",[temp objectForKey:@"itemDesc"]];
        item_description.textAlignment=NSTextAlignmentCenter;
        item_description.adjustsFontSizeToFitWidth = YES;
        
        UILabel *price = [[[UILabel alloc] init] autorelease];
        price.layer.borderWidth = 1.5;
        price.font = [UIFont systemFontOfSize:13.0];
        price.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        price.backgroundColor = [UIColor blackColor];
        price.text = [NSString stringWithFormat:@"%.2f",[[temp objectForKey:@"itemPrice"] floatValue]];
        price.textColor = [UIColor whiteColor];
        price.textAlignment=NSTextAlignmentCenter;
        //price.adjustsFontSizeToFitWidth = YES;
        
        
        UIButton *qtyButton = [[[UIButton alloc] init] autorelease];
        [qtyButton setTitle:[NSString stringWithFormat:@"%d",[[temp objectForKey:@"quantity"] integerValue]] forState:UIControlStateNormal];
        qtyButton.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        qtyButton.layer.borderWidth = 1.5;
        [qtyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [qtyButton addTarget:self action:@selector(changeQuantity:) forControlEvents:UIControlEventTouchUpInside];
        qtyButton.layer.masksToBounds = YES;
        qtyButton.tag = indexPath.row;
        qtyButton.userInteractionEnabled = NO;
        
        
        UILabel *cost = [[[UILabel alloc] init] autorelease];
        cost.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        cost.layer.borderWidth = 1.5;
        cost.font = [UIFont systemFontOfSize:13.0];
        cost.backgroundColor = [UIColor blackColor];
        cost.text = [NSString stringWithFormat:@"%.02f", [[temp objectForKey:@"totalCost"] floatValue]];
        cost.textColor = [UIColor whiteColor];
        cost.textAlignment=NSTextAlignmentCenter;
        //cost.adjustsFontSizeToFitWidth = YES;
        
        UILabel *make = [[[UILabel alloc] init] autorelease];
        make.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        make.layer.borderWidth = 1.5;
        make.font = [UIFont systemFontOfSize:13.0];
        make.backgroundColor = [UIColor blackColor];
        make.text = [temp objectForKey:@"make"];
        make.textColor = [UIColor whiteColor];
        make.textAlignment=NSTextAlignmentCenter;
        //make.adjustsFontSizeToFitWidth = YES;
        
        UILabel *supplied = [[[UILabel alloc] init] autorelease];
        supplied.layer.borderWidth = 1.5;
        supplied.font = [UIFont systemFontOfSize:13.0];
        supplied.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        supplied.backgroundColor = [UIColor blackColor];
        supplied.textColor = [UIColor whiteColor];
        
        supplied.text = [NSString stringWithFormat:@"%@",[temp objectForKey:@"model"]];
        supplied.textAlignment=NSTextAlignmentCenter;
        //supplied.adjustsFontSizeToFitWidth = YES;
        
        UILabel *received = [[[UILabel alloc] init] autorelease];
        received.layer.borderWidth = 1.5;
        received.font = [UIFont systemFontOfSize:13.0];
        received.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        received.backgroundColor = [UIColor blackColor];
        received.textColor = [UIColor whiteColor];
        
        received.text = [NSString stringWithFormat:@"%@",[temp objectForKey:@"color"]];
        received.textAlignment=NSTextAlignmentCenter;
        //received.adjustsFontSizeToFitWidth = YES;
        
        UIButton *rejectQtyButton = [[[UIButton alloc] init] autorelease];
        [rejectQtyButton setTitle:[NSString stringWithFormat:@"%@",[temp objectForKey:@"size"]] forState:UIControlStateNormal];
        rejectQtyButton.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        rejectQtyButton.layer.borderWidth = 1.5;
        [rejectQtyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rejectQtyButton addTarget:self action:@selector(changeRejectQuantity:) forControlEvents:UIControlEventTouchUpInside];
        rejectQtyButton.layer.masksToBounds = YES;
        rejectQtyButton.tag = indexPath.row;
        rejectQtyButton.userInteractionEnabled = NO;
        
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
            
        }
        else {
            
            item_code.font = [UIFont fontWithName:@"ArialRoundedMT" size:13];
            item_code.frame = CGRectMake(0, 0, 90, 35);
            item_description.font = [UIFont fontWithName:@"ArialRoundedMT" size:13];
            item_description.frame = CGRectMake(93, 0, 90, 35);
            price.font = [UIFont fontWithName:@"ArialRoundedMT" size:13];
            price.frame = CGRectMake(185, 0, 90, 35);
            qtyButton.frame = CGRectMake(278, 0, 90, 35);
            cost.font = [UIFont fontWithName:@"ArialRoundedMT" size:13];
            cost.frame = CGRectMake(371, 0, 110, 35);
            
//            make.font = [UIFont fontWithName:@"ArialRoundedMT" size:13];
//            make.frame = CGRectMake(484, 0, 110, 35);
//            supplied.font = [UIFont fontWithName:@"ArialRoundedMT" size:13];
//            supplied.frame = CGRectMake(597, 0, 110, 35);
//            
//            received.font = [UIFont fontWithName:@"ArialRoundedMT" size:13];
//            received.frame = CGRectMake(710, 0, 110, 35);
//            rejectQtyButton.frame = CGRectMake(823, 0, 110, 35);
            
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
        //
        
        
    }
    
    
    return hlcell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    // cell background color...
    UITableViewCell* theCell = [tableView cellForRowAtIndexPath:indexPath];
    theCell.contentView.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:232.0/255.0 blue:124.0/255.0 alpha:1.0];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
