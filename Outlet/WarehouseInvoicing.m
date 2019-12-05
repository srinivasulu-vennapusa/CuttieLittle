//
//  WarehouseInvoicing.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/23/15.
//
//

#import "WarehouseInvoicing.h"
#import "WHShippingServicesSvc.h"
#import "WHInvoiceServicesSvc.h"
#import "Global.h"
#import "ViewWarehouseInvoice.h"

@interface WarehouseInvoicing ()

@end

@implementation WarehouseInvoicing
@synthesize soundFileObject,soundFileURLRef;

int invoiceShipmentIndex;
bool shipmentIdStatus = TRUE;
NSString *wareInvoiceId = @"";

int wareInvoiceCount1_ = 0;
int wareInvoiceCount2_ = 1;
int wareInvoiceCount3_ = 0;
UILabel *recStart;
UILabel *recEnd;
UILabel *totalRec;
UILabel *label1_;
UILabel *label2_;

BOOL wareInvoiceCountValue_ = YES;
int wareInvoiceChangeNum_ = 0;


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}

- (void) getPreviousOrdersHandler: (NSString *) value {
    
    
    [HUD setHidden:YES];
    
    // Do something with the NSString* result
    NSString* result = [value copy];
    
    NSError *e;
    
    NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [result dataUsingEncoding:NSUTF8StringEncoding]
                                                          options: NSJSONReadingMutableContainers
                                                            error: &e];
    
    NSDictionary *json = [JSON1 objectForKey:@"responseHeader"];
    
    if ([[json objectForKey:@"responseMessage"] isEqualToString:@"Invoice Details"] && [[json objectForKey:@"responseCode"] isEqualToString:@"0"]) {
        
        // initialize the arrays ..
        itemIdArray = [[NSMutableArray alloc] init];
        orderStatusArray = [[NSMutableArray alloc] init];
        orderAmountArray = [[NSMutableArray alloc] init];
        OrderedOnArray = [[NSMutableArray alloc] init];
        NSArray *listDetails = [JSON1 objectForKey:@"invoices"];
        //        NSArray *temp = [result componentsSeparatedByString:@"!"];
        
        recStart.text = [NSString stringWithFormat:@"%d",(wareInvoiceChangeNum_ * 10) + 1];
        recEnd.text = [NSString stringWithFormat:@"%d",[recStart.text intValue] + 9];
        totalRec.text = [NSString stringWithFormat:@"%d",[[JSON1 objectForKey:@"totalInvoices"] intValue]];
        
        if ([[JSON1 objectForKey:@"totalInvoices"] intValue] <= 10) {
            recEnd.text = [NSString stringWithFormat:@"%d",[totalRec.text intValue]];
            nextButton.enabled =  NO;
            previousButton.enabled = NO;
            firstButton.enabled = NO;
            lastButton.enabled = NO;
            //nextButton.backgroundColor = [UIColor lightGrayColor];
        }
        else{
            
            if (wareInvoiceChangeNum_ == 0) {
                previousButton.enabled = NO;
                firstButton.enabled = NO;
                nextButton.enabled = YES;
                lastButton.enabled = YES;
            }
            else if (([[JSON1 objectForKey:@"totalInvoices"] intValue] - (10 * (wareInvoiceChangeNum_+1))) <= 0) {
                
                nextButton.enabled = NO;
                lastButton.enabled = NO;
                recEnd.text = totalRec.text;
            }
        }
        
        
        //[temp removeObjectAtIndex:0];
        
        for (int i = 0; i < [listDetails count]; i++) {
            
            NSDictionary *temp2 = [listDetails objectAtIndex:i];
            
            [itemIdArray addObject:[NSString stringWithFormat:@"%@",[temp2 objectForKey:@"invoiceId"]]];
            [orderStatusArray addObject:[NSString stringWithFormat:@"%@",[temp2 objectForKey:@"shipmentId"]]];
            [orderAmountArray addObject:[NSString stringWithFormat:@"%@",[temp2 objectForKey:@"totalItemCost"]]];
            [OrderedOnArray addObject:[NSString stringWithFormat:@"%@",[temp2 objectForKey:@"invoiceDate"]]];
        }
        
        if ([itemIdArray count] < 5) {
            //nextButton.backgroundColor = [UIColor lightGrayColor];
            nextButton.enabled =  NO;
        }
        
        wareInvoiceCount3_ = [itemIdArray count];
        
        if ([listDetails count] == 0) {
            nextButton.enabled = NO;
            lastButton.enabled = NO;
            previousButton.enabled = NO;
            firstButton.enabled = NO;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Invoices To Display" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        
        [orderstockTable reloadData];
    }
    else{
        
        wareInvoiceCount2_ = NO;
        wareInvoiceChangeNum_--;
        
        //nextButton.backgroundColor = [UIColor lightGrayColor];
        nextButton.enabled =  NO;
        
        //previousButton.backgroundColor = [UIColor grayColor];
        previousButton.enabled =  NO;
        
        firstButton.enabled = NO;
        lastButton.enabled = NO;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Invoices To Display" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
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
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 450.0, 45.0)];
    titleView.backgroundColor = [UIColor clearColor];
    
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo_200.png"]];
    logoView.backgroundColor = [UIColor clearColor];
    logoView.frame = CGRectMake(60.0, 0.0, 45.0, 45.0);
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(110.0, -13.0, 250.0, 70.0)];
    titleLbl.text = @"Warehouse Invoice";
    titleLbl.textColor = [UIColor blackColor];
    titleLbl.font = [UIFont boldSystemFontOfSize:25.0f];
    titleLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
    [titleView addSubview:logoView];
    [titleView addSubview:titleLbl];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
    }
    else{
        logoView.frame = CGRectMake(20.0, 7.0, 30.0, 30.0);
        titleLbl.frame = CGRectMake(55.0, -12.0, 200.0, 70.0);
        titleLbl.backgroundColor = [UIColor clearColor];
        titleLbl.textColor = [UIColor whiteColor];
        titleLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
    }
    
    self.navigationItem.titleView = titleView;
    
    
    self.view.backgroundColor = [UIColor blackColor];
    invoiceShipmentIndex = 0;
    shipmentView = [[UIScrollView alloc] init];
    shipmentView.backgroundColor = [UIColor blackColor];
    shipmentView.bounces = FALSE;
    shipmentView.hidden = NO;
    
    shipmentId = [[UITextField alloc] init];
    shipmentId.borderStyle = UITextBorderStyleRoundedRect;
    shipmentId.textColor = [UIColor blackColor];
    shipmentId.font = [UIFont systemFontOfSize:18.0];
    shipmentId.backgroundColor = [UIColor whiteColor];
    shipmentId.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentId.backgroundColor = [UIColor whiteColor];
    shipmentId.autocorrectionType = UITextAutocorrectionTypeNo;
    shipmentId.layer.borderColor = [UIColor whiteColor].CGColor;
    shipmentId.backgroundColor = [UIColor whiteColor];
    shipmentId.delegate = self;
    shipmentId.placeholder = @"   Shipment ID";
    [shipmentId addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    // ShipModeTableview cration....
    shipIdTable = [[UITableView alloc]init];
    shipIdTable.layer.borderWidth = 1.0;
    shipIdTable.layer.cornerRadius = 10.0;
    shipIdTable.bounces = FALSE;
    shipIdTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    shipIdTable.layer.borderColor = [UIColor blackColor].CGColor;
    [shipIdTable setDataSource:self];
    [shipIdTable setDelegate:self];
    
    orderId = [[UITextField alloc] init];
    orderId.borderStyle = UITextBorderStyleRoundedRect;
    orderId.textColor = [UIColor blackColor];
    orderId.font = [UIFont systemFontOfSize:18.0];
    orderId.backgroundColor = [UIColor whiteColor];
    orderId.clearButtonMode = UITextFieldViewModeWhileEditing;
    orderId.backgroundColor = [UIColor whiteColor];
    orderId.autocorrectionType = UITextAutocorrectionTypeNo;
    orderId.layer.borderColor = [UIColor whiteColor].CGColor;
    orderId.backgroundColor = [UIColor whiteColor];
    orderId.delegate = self;
    orderId.placeholder = @"   Order ID";
    
    shipmentNoteId = [[UITextField alloc] init];
    shipmentNoteId.borderStyle = UITextBorderStyleRoundedRect;
    shipmentNoteId.textColor = [UIColor blackColor];
    shipmentNoteId.font = [UIFont systemFontOfSize:18.0];
    shipmentNoteId.backgroundColor = [UIColor whiteColor];
    shipmentNoteId.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentNoteId.backgroundColor = [UIColor whiteColor];
    shipmentNoteId.autocorrectionType = UITextAutocorrectionTypeNo;
    shipmentNoteId.layer.borderColor = [UIColor whiteColor].CGColor;
    shipmentNoteId.backgroundColor = [UIColor whiteColor];
    shipmentNoteId.delegate = self;
    shipmentNoteId.placeholder = @"   Shipment Note ID";
    
    customerName = [[UITextField alloc] init];
    customerName.borderStyle = UITextBorderStyleRoundedRect;
    customerName.textColor = [UIColor blackColor];
    customerName.font = [UIFont systemFontOfSize:18.0];
    customerName.backgroundColor = [UIColor whiteColor];
    customerName.clearButtonMode = UITextFieldViewModeWhileEditing;
    customerName.backgroundColor = [UIColor whiteColor];
    customerName.autocorrectionType = UITextAutocorrectionTypeNo;
    customerName.layer.borderColor = [UIColor whiteColor].CGColor;
    customerName.backgroundColor = [UIColor whiteColor];
    customerName.delegate = self;
    customerName.placeholder = @"   Customer Name";
    
    buildingNo = [[UITextField alloc] init];
    buildingNo.borderStyle = UITextBorderStyleRoundedRect;
    buildingNo.textColor = [UIColor blackColor];
    buildingNo.font = [UIFont systemFontOfSize:18.0];
    buildingNo.backgroundColor = [UIColor whiteColor];
    buildingNo.clearButtonMode = UITextFieldViewModeWhileEditing;
    buildingNo.backgroundColor = [UIColor whiteColor];
    buildingNo.autocorrectionType = UITextAutocorrectionTypeNo;
    buildingNo.layer.borderColor = [UIColor whiteColor].CGColor;
    buildingNo.backgroundColor = [UIColor whiteColor];
    buildingNo.delegate = self;
    buildingNo.placeholder = @"   Building NO.";
    
    streetName = [[UITextField alloc] init];
    streetName.borderStyle = UITextBorderStyleRoundedRect;
    streetName.textColor = [UIColor blackColor];
    streetName.font = [UIFont systemFontOfSize:18.0];
    streetName.backgroundColor = [UIColor whiteColor];
    streetName.clearButtonMode = UITextFieldViewModeWhileEditing;
    streetName.backgroundColor = [UIColor whiteColor];
    streetName.autocorrectionType = UITextAutocorrectionTypeNo;
    streetName.layer.borderColor = [UIColor whiteColor].CGColor;
    streetName.backgroundColor = [UIColor whiteColor];
    streetName.delegate = self;
    streetName.placeholder = @"   Street Name";
    
    city = [[UITextField alloc] init];
    city.borderStyle = UITextBorderStyleRoundedRect;
    city.textColor = [UIColor blackColor];
    city.font = [UIFont systemFontOfSize:18.0];
    city.backgroundColor = [UIColor whiteColor];
    city.clearButtonMode = UITextFieldViewModeWhileEditing;
    city.backgroundColor = [UIColor whiteColor];
    city.autocorrectionType = UITextAutocorrectionTypeNo;
    city.layer.borderColor = [UIColor whiteColor].CGColor;
    city.backgroundColor = [UIColor whiteColor];
    city.delegate = self;
    city.placeholder = @"   City";
    
    country = [[UITextField alloc] init];
    country.borderStyle = UITextBorderStyleRoundedRect;
    country.textColor = [UIColor blackColor];
    country.font = [UIFont systemFontOfSize:18.0];
    country.backgroundColor = [UIColor whiteColor];
    country.clearButtonMode = UITextFieldViewModeWhileEditing;
    country.backgroundColor = [UIColor whiteColor];
    country.autocorrectionType = UITextAutocorrectionTypeNo;
    country.layer.borderColor = [UIColor whiteColor].CGColor;
    country.backgroundColor = [UIColor whiteColor];
    country.delegate = self;
    country.placeholder = @"   Country";
    
    zip_code = [[UITextField alloc] init];
    zip_code.borderStyle = UITextBorderStyleRoundedRect;
    zip_code.textColor = [UIColor blackColor];
    zip_code.font = [UIFont systemFontOfSize:18.0];
    zip_code.backgroundColor = [UIColor whiteColor];
    zip_code.clearButtonMode = UITextFieldViewModeWhileEditing;
    zip_code.backgroundColor = [UIColor whiteColor];
    zip_code.autocorrectionType = UITextAutocorrectionTypeNo;
    zip_code.layer.borderColor = [UIColor whiteColor].CGColor;
    zip_code.backgroundColor = [UIColor whiteColor];
    zip_code.delegate = self;
    zip_code.placeholder = @"   Zip Code";
    
    shipmentAgency = [[UITextField alloc] init];
    shipmentAgency.borderStyle = UITextBorderStyleRoundedRect;
    shipmentAgency.textColor = [UIColor blackColor];
    shipmentAgency.font = [UIFont systemFontOfSize:18.0];
    shipmentAgency.backgroundColor = [UIColor whiteColor];
    shipmentAgency.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentAgency.backgroundColor = [UIColor whiteColor];
    shipmentAgency.autocorrectionType = UITextAutocorrectionTypeNo;
    shipmentAgency.layer.borderColor = [UIColor whiteColor].CGColor;
    shipmentAgency.backgroundColor = [UIColor whiteColor];
    shipmentAgency.delegate = self;
    shipmentAgency.placeholder = @"   Shipment Agency";
    
    shipmentCost = [[UITextField alloc] init];
    shipmentCost.borderStyle = UITextBorderStyleRoundedRect;
    shipmentCost.textColor = [UIColor blackColor];
    shipmentCost.font = [UIFont systemFontOfSize:18.0];
    shipmentCost.backgroundColor = [UIColor whiteColor];
    shipmentCost.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentCost.backgroundColor = [UIColor whiteColor];
    shipmentCost.autocorrectionType = UITextAutocorrectionTypeNo;
    shipmentCost.layer.borderColor = [UIColor whiteColor].CGColor;
    shipmentCost.backgroundColor = [UIColor whiteColor];
    shipmentCost.delegate = self;
    shipmentCost.placeholder = @"   Shipment Cost";
    
    insuranceCost = [[UITextField alloc] init];
    insuranceCost.borderStyle = UITextBorderStyleRoundedRect;
    insuranceCost.textColor = [UIColor blackColor];
    insuranceCost.font = [UIFont systemFontOfSize:18.0];
    insuranceCost.backgroundColor = [UIColor whiteColor];
    insuranceCost.clearButtonMode = UITextFieldViewModeWhileEditing;
    insuranceCost.backgroundColor = [UIColor whiteColor];
    insuranceCost.autocorrectionType = UITextAutocorrectionTypeNo;
    insuranceCost.layer.borderColor = [UIColor whiteColor].CGColor;
    insuranceCost.backgroundColor = [UIColor whiteColor];
    insuranceCost.delegate = self;
    insuranceCost.placeholder = @"   Insurance Cost";
    
    paymentTerms = [[UITextField alloc] init];
    paymentTerms.borderStyle = UITextBorderStyleRoundedRect;
    paymentTerms.textColor = [UIColor blackColor];
    paymentTerms.font = [UIFont systemFontOfSize:18.0];
    paymentTerms.backgroundColor = [UIColor whiteColor];
    paymentTerms.clearButtonMode = UITextFieldViewModeWhileEditing;
    paymentTerms.backgroundColor = [UIColor whiteColor];
    paymentTerms.autocorrectionType = UITextAutocorrectionTypeNo;
    paymentTerms.layer.borderColor = [UIColor whiteColor].CGColor;
    paymentTerms.backgroundColor = [UIColor whiteColor];
    paymentTerms.delegate = self;
    paymentTerms.placeholder = @"   Payment Terms";
    
    // getting present date & time ..
    NSDate *today = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString* currentdate = [f stringFromDate:today];
    [f release];
    
    invoiceDate = [[UITextField alloc] init];
    invoiceDate.borderStyle = UITextBorderStyleRoundedRect;
    invoiceDate.textColor = [UIColor blackColor];
    invoiceDate.font = [UIFont systemFontOfSize:18.0];
    invoiceDate.backgroundColor = [UIColor whiteColor];
    invoiceDate.clearButtonMode = UITextFieldViewModeWhileEditing;
    invoiceDate.backgroundColor = [UIColor whiteColor];
    invoiceDate.autocorrectionType = UITextAutocorrectionTypeNo;
    invoiceDate.layer.borderColor = [UIColor whiteColor].CGColor;
    invoiceDate.backgroundColor = [UIColor whiteColor];
    invoiceDate.delegate = self;
    invoiceDate.text = currentdate;
    invoiceDate.placeholder = @"   Invoice Date";
    
    remarks = [[UITextField alloc] init];
    remarks.borderStyle = UITextBorderStyleRoundedRect;
    remarks.textColor = [UIColor blackColor];
    remarks.font = [UIFont systemFontOfSize:18.0];
    remarks.backgroundColor = [UIColor whiteColor];
    remarks.clearButtonMode = UITextFieldViewModeWhileEditing;
    remarks.backgroundColor = [UIColor whiteColor];
    remarks.autocorrectionType = UITextAutocorrectionTypeNo;
    remarks.layer.borderColor = [UIColor whiteColor].CGColor;
    remarks.backgroundColor = [UIColor whiteColor];
    remarks.delegate = self;
    remarks.placeholder = @"   Remarks";
    
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
    [orderButton setTitle:@"Submit" forState:UIControlStateNormal];
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
        shipmentView.frame = CGRectMake(0, 125, self.view.frame.size.width, 830.0);
        shipmentView.contentSize = CGSizeMake(self.view.frame.size.width, 1500.0);
        
        shipmentId.font = [UIFont boldSystemFontOfSize:20];
        shipmentId.frame = CGRectMake(10.0, 10.0, 360, 40);
        shipIdTable.frame = CGRectMake(10.0, 50, 360, 270);
        shipIdTable.hidden = YES;
        orderId.font = [UIFont boldSystemFontOfSize:20];
        orderId.frame = CGRectMake(400.0, 10.0, 360, 40);
        
        shipmentNoteId.font = [UIFont boldSystemFontOfSize:20];
        shipmentNoteId.frame = CGRectMake(10.0, 60.0, 360, 40);
        
        customerName.font = [UIFont boldSystemFontOfSize:20];
        customerName.frame = CGRectMake(400.0, 60.0, 360, 40);
        
        buildingNo.font = [UIFont boldSystemFontOfSize:20];
        buildingNo.frame = CGRectMake(10.0, 110.0, 360, 40);
        
        streetName.font = [UIFont boldSystemFontOfSize:20];
        streetName.frame = CGRectMake(400.0, 110.0, 360, 40);
        
        city.font = [UIFont boldSystemFontOfSize:20];
        city.frame = CGRectMake(10.0, 160.0, 360, 40);
        
        country.font = [UIFont boldSystemFontOfSize:20];
        country.frame = CGRectMake(400.0, 160.0, 360, 40);
        
        zip_code.font = [UIFont boldSystemFontOfSize:20];
        zip_code.frame = CGRectMake(10.0, 210.0, 360, 40);
        
        shipmentAgency.font = [UIFont boldSystemFontOfSize:20];
        shipmentAgency.frame = CGRectMake(400.0, 210.0, 360, 40);
        
        shipmentCost.font = [UIFont boldSystemFontOfSize:20];
        shipmentCost.frame = CGRectMake(10.0, 260.0, 360, 40);
        
        insuranceCost.font = [UIFont boldSystemFontOfSize:20];
        insuranceCost.frame = CGRectMake(400.0, 260.0, 360, 40);
        
        paymentTerms.font = [UIFont boldSystemFontOfSize:20];
        paymentTerms.frame = CGRectMake(10.0, 310.0, 360, 40);
        
        invoiceDate.font = [UIFont boldSystemFontOfSize:20];
        invoiceDate.frame = CGRectMake(400.0, 310.0, 360, 40);
        
        remarks.font = [UIFont boldSystemFontOfSize:20];
        remarks.frame = CGRectMake(10.0, 360.0, 360, 40);
        
        label1.frame = CGRectMake(10, 420.0, 150, 40);
        label1.font = [UIFont boldSystemFontOfSize:20.0];
        
        label5.frame = CGRectMake(161, 420.0, 150, 40);
        label5.font = [UIFont boldSystemFontOfSize:20.0];
        
        label2.frame = CGRectMake(312, 420.0, 150, 40);
        label2.font = [UIFont boldSystemFontOfSize:20.0];
        
        label3.frame = CGRectMake(463, 420.0, 150, 40);
        label3.font = [UIFont boldSystemFontOfSize:20.0];
        
        label4.frame = CGRectMake(614, 420.0, 150, 40);
        label4.font = [UIFont boldSystemFontOfSize:20.0];
        
        orderItemsTable.frame = CGRectMake(10, 470.0, 750, 376);
        orderItemsTable.hidden = YES;
        
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
        
        shipmentView.frame = CGRectMake(0, 42, 768, 810);
        shipmentView.contentSize = CGSizeMake(768, 1350);
        
        shipmentId.font = [UIFont systemFontOfSize:15.0f];
        shipmentId.frame = CGRectMake(5, 0, 150.0, 30.0);
        
        orderId.font = [UIFont systemFontOfSize:15.0f];
        orderId.frame = CGRectMake(165.0, 0, 150, 30.0);
        
        shipmentNoteId.font = [UIFont systemFontOfSize:15.0f];
        shipmentNoteId.frame = CGRectMake(5, 35.0, 150, 30);
        
        customerName.font = [UIFont systemFontOfSize:15.0f];
        customerName.frame = CGRectMake(165, 35.0, 150.0, 30);
        
        buildingNo.font = [UIFont systemFontOfSize:15.0f];
        buildingNo.frame = CGRectMake(5, 70.0, 150.0, 30);
        
        streetName.font = [UIFont systemFontOfSize:15.0f];
        streetName.frame = CGRectMake(165, 70, 150.0, 30);
        
        city.font = [UIFont systemFontOfSize:15.0f];
        city.frame = CGRectMake(5, 105.0, 150.0, 30);
        
        country.font = [UIFont systemFontOfSize:15.0f];
        country.frame = CGRectMake(165.0, 105.0, 150.0, 30.0);
        
        zip_code.font = [UIFont systemFontOfSize:15.0f];
        zip_code.frame = CGRectMake(5, 140.0, 150.0, 30);
        
        shipmentAgency.font = [UIFont systemFontOfSize:15.0f];
        shipmentAgency.frame = CGRectMake(165.0, 140.0, 150.0, 30);
        
        shipmentCost.font = [UIFont systemFontOfSize:15.0f];
        shipmentCost.frame = CGRectMake(5, 175.0, 150.0, 30);
        
        insuranceCost.font = [UIFont systemFontOfSize:15.0f];
        insuranceCost.frame = CGRectMake(165.0, 175.0, 150.0, 30.0);
        
        paymentTerms.font = [UIFont systemFontOfSize:15.0f];
        paymentTerms.frame = CGRectMake(5, 210.0, 150.0, 30.0);
        
        invoiceDate.font = [UIFont systemFontOfSize:15.0f];
        invoiceDate.frame = CGRectMake(165.0, 210.0, 150.0, 30);
        
        remarks.font = [UIFont systemFontOfSize:15.0f];
        remarks.frame = CGRectMake(5.0, 245.0, 150.0, 30.0);
        
        label1.frame = CGRectMake(0, 280.0, 60, 25);
        label1.font = [UIFont boldSystemFontOfSize:17];
        
        label5.frame = CGRectMake(61, 280.0, 60, 25);
        label5.font = [UIFont boldSystemFontOfSize:17];
        
        label2.frame = CGRectMake(122, 280.0, 60, 25);
        label2.font = [UIFont boldSystemFontOfSize:17];
        
        label3.frame = CGRectMake(183, 280.0, 60, 25);
        label3.font = [UIFont boldSystemFontOfSize:17];
        
        label4.frame = CGRectMake(244, 280.0, 60, 25);
        label4.font = [UIFont boldSystemFontOfSize:17];
        
        orderItemsTable.frame = CGRectMake(10, 315, 550, 250.0);
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
    [shipmentView addSubview:shipIdTable];
    [shipmentView addSubview:orderId];
    [shipmentView addSubview:shipmentNoteId];
    [shipmentView addSubview:customerName];
    [shipmentView addSubview:buildingNo];
    [shipmentView addSubview:streetName];
    [shipmentView addSubview:city];
    [shipmentView addSubview:country];
    [shipmentView addSubview:zip_code];
    [shipmentView addSubview:shipmentAgency];
    [shipmentView addSubview:shipmentCost];
    [shipmentView addSubview:insuranceCost];
    [shipmentView addSubview:paymentTerms];
    [shipmentView addSubview:invoiceDate];
    [shipmentView addSubview:remarks];
    [shipmentView addSubview:label1];
    [shipmentView addSubview:label2];
    [shipmentView addSubview:label3];
    [shipmentView addSubview:label4];
    [shipmentView addSubview:label5];
    [shipmentView addSubview:orderItemsTable];
    [shipmentView addSubview:subTotal];
    [shipmentView addSubview:tax];
    [shipmentView addSubview:totAmount];
    [shipmentView addSubview:subTotalData];
    [shipmentView addSubview:taxData];
    [shipmentView addSubview:totAmountData];
    [self.view addSubview:shipmentView];
    [self.view addSubview:orderButton];
    [self.view addSubview:cancelButton];
    
    /** SearchBarItem*/
    searchBar = [[UISearchBar alloc] init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        searchBar.frame = CGRectMake(0, 125, 768, 60);
    }
    else {
        searchBar.frame = CGRectMake(0, 35, 320, 30);
    }
    searchBar.delegate = self;
    searchBar.tintColor=[UIColor grayColor];
    orderstockTable.tableHeaderView = searchBar;
    [self.view addSubview:searchBar];
    [searchBar release];
    searchBar.hidden = YES;
    searchBar.delegate = self;
    
    //    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAddContact:)];
    //    self.navigationItem.rightBarButtonItem = addButton;
    
    // Storing  for searchData
    copyListOfItems = [[NSMutableArray alloc] init];
    
    searching = NO;
    letUserSelectRow = YES;
    
    /** Table Creation*/
    orderstockTable = [[UITableView alloc] init];
    orderstockTable.bounces = TRUE;
    orderstockTable.backgroundColor = [UIColor clearColor];
    orderstockTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [orderstockTable setDataSource:self];
    [orderstockTable setDelegate:self];
    orderstockTable.hidden = YES;
    [self.view addSubview:orderstockTable];
    
    
    
    firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [firstButton addTarget:self action:@selector(firstButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [firstButton setImage:[UIImage imageNamed:@"mail_first.png"] forState:UIControlStateNormal];
    firstButton.layer.cornerRadius = 3.0f;
    firstButton.hidden = YES;
    
    lastButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [lastButton addTarget:self action:@selector(lastButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [lastButton setImage:[UIImage imageNamed:@"mail_last.png"] forState:UIControlStateNormal];
    lastButton.layer.cornerRadius = 3.0f;
    lastButton.hidden = YES;
    
    /** Create PreviousButton */
    previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [previousButton addTarget:self
                       action:@selector(previousButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [previousButton setImage:[UIImage imageNamed:@"mail_prev.png"] forState:UIControlStateNormal];
    //    [previousButton setTitle:@"Previous" forState:UIControlStateNormal];
    //    previousButton.backgroundColor = [UIColor lightGrayColor];
    previousButton.enabled =  NO;
    previousButton.hidden = YES;
    
    
    /** Create NextButton */
    nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton addTarget:self
                   action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [nextButton setImage:[UIImage imageNamed:@"mail_next.png"] forState:UIControlStateNormal];
    nextButton.hidden = YES;
    //    [nextButton setTitle:@"Next" forState:UIControlStateNormal];
    //    nextButton.backgroundColor = [UIColor grayColor];
    
    //bottom label1...
    recStart = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    recStart.text = @"";
    recStart.textAlignment = NSTextAlignmentLeft;
    recStart.backgroundColor = [UIColor clearColor];
    recStart.textColor = [UIColor whiteColor];
    recStart.hidden = YES;
    
    //bottom label_2...
    label1_ = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    label1_.text = @"-";
    label1_.textAlignment = NSTextAlignmentLeft;
    label1_.backgroundColor = [UIColor clearColor];
    label1_.textColor = [UIColor whiteColor];
    label1_.hidden = YES;
    
    //bottom label2...
    recEnd = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    recEnd.text = @"";
    recEnd.textAlignment = NSTextAlignmentLeft;
    recEnd.backgroundColor = [UIColor clearColor];
    recEnd.textColor = [UIColor whiteColor];
    recEnd.hidden = YES;
    
    //bottom label_3...
    label2_ = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    label2_.text = @"of";
    label2_.textAlignment = NSTextAlignmentLeft;
    label2_.backgroundColor = [UIColor clearColor];
    label2_.textColor = [UIColor whiteColor];
    label2_.hidden = YES;
    
    //bottom label3...
    totalRec = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    totalRec.textAlignment = NSTextAlignmentLeft;
    totalRec.backgroundColor = [UIColor clearColor];
    totalRec.textColor = [UIColor whiteColor];
    totalRec.hidden = YES;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        //        img.frame = CGRectMake(0, 0, 778, 50);
        //        label.frame = CGRectMake(10, 0, 200, 45);
        //        backbutton.frame = CGRectMake(710.0, 3.0, 45.0, 45.0);
        orderstockTable.frame = CGRectMake(0, 190, 778, 780);
        
        firstButton.frame = CGRectMake(80, 970.0, 50, 50);
        firstButton.layer.cornerRadius = 25.0f;
        firstButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        lastButton.frame = CGRectMake(615, 970.0, 50, 50);
        lastButton.layer.cornerRadius = 25.0f;
        lastButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        previousButton.frame = CGRectMake(240, 970.0, 50, 50);
        previousButton.layer.cornerRadius = 22.0f;
        previousButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        nextButton.frame = CGRectMake(470, 970.0, 50, 50);
        nextButton.layer.cornerRadius = 22.0f;
        nextButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        recStart.frame = CGRectMake(295, 970.0, 30, 50);
        label1_.frame = CGRectMake(338, 970.0, 30, 50);
        recEnd.frame = CGRectMake(365, 970.0, 30, 50);
        label2_.frame = CGRectMake(400, 970.0, 30, 50);
        totalRec.frame = CGRectMake(435, 970.0, 30, 50);
        
        recStart.font = [UIFont systemFontOfSize:25.0];
        label1_.font = [UIFont systemFontOfSize:25.0];
        recEnd.font = [UIFont systemFontOfSize:25.0];
        label2_.font = [UIFont systemFontOfSize:25.0];
        totalRec.font = [UIFont systemFontOfSize:25.0];
        
        
        //         label.font = [UIFont boldSystemFontOfSize:25];
    }
    else {
        //        img.frame = CGRectMake(0, 0, 320, 31);
        //        label.frame = CGRectMake(3, 1, 150, 30);
        //        backbutton.frame = CGRectMake(285.0, 2.0, 27.0, 27.0);
        orderstockTable.frame = CGRectMake(0, 70, 320, 300);
        firstButton.frame = CGRectMake(10, 375, 40, 40);
        firstButton.layer.cornerRadius = 15.0f;
        firstButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
        
        lastButton.frame = CGRectMake(273, 375, 40, 40);
        lastButton.layer.cornerRadius = 15.0f;
        lastButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
        previousButton.frame = CGRectMake(80, 375, 40, 40);
        previousButton.layer.cornerRadius = 15.0f;
        previousButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
        nextButton.frame = CGRectMake(210, 375, 40, 40);
        nextButton.layer.cornerRadius = 15.0f;
        nextButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
        recStart.frame = CGRectMake(122, 375, 20, 30);
        label1_.frame = CGRectMake(140, 375, 20, 30);
        recEnd.frame = CGRectMake(148, 375, 20, 30);
        label2_.frame = CGRectMake(167, 375, 20, 30);
        totalRec.frame = CGRectMake(183, 375, 20, 30);
        
        recStart.font = [UIFont systemFontOfSize:14.0];
        label1_.font = [UIFont systemFontOfSize:14.0];
        recEnd.font = [UIFont systemFontOfSize:14.0];
        label2_.font = [UIFont systemFontOfSize:14.0];
        totalRec.font = [UIFont systemFontOfSize:14.0];
    }
    
    //[topbar addSubview:img];
    //    [self.view addSubview:img];
    //    [self.view addSubview:label];
    //    [self.view addSubview:backbutton];
    [self.view addSubview:orderstockTable];
    [self.view addSubview:previousButton];
    [self.view addSubview:nextButton];
    [self.view addSubview:firstButton];
    [self.view addSubview:lastButton];
    [self.view addSubview:recStart];
    [self.view addSubview:recEnd];
    [self.view addSubview:label1_];
    [self.view addSubview:label2_];
    [self.view addSubview:totalRec];
    
    
    
    //ProgressBar creation...
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    // Show the HUD
    [HUD show:YES];
    [HUD setHidden:NO];
    
    WHInvoiceServicesSoapBinding *service = [[WHInvoiceServicesSvc WHInvoiceServicesSoapBinding] retain];
    WHInvoiceServicesSvc_getInvoices *aparams = [[WHInvoiceServicesSvc_getInvoices alloc] init];
    NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str_ = [time_ componentsSeparatedByString:@" "];
    NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"requestHeader", nil];
    
    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",wareInvoiceChangeNum_],dictionary, nil];
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
    aparams.invoiceDetails = normalStockString;
    WHInvoiceServicesSoapBindingResponse *response = [service getInvoicesUsingParameters:(WHInvoiceServicesSvc_getInvoices *)aparams];
    
    NSArray *responseBodyParts =  response.bodyParts;
    
    for (id bodyPart in responseBodyParts) {
        if ([bodyPart isKindOfClass:[WHInvoiceServicesSvc_getInvoicesResponse class]]) {
            WHInvoiceServicesSvc_getInvoicesResponse *body = (WHInvoiceServicesSvc_getInvoicesResponse *)bodyPart;
            //printf("\nresponse=%s",body.return_);
            if (body.return_ == NULL) {
                
                [HUD setHidden:YES];
                //nextButton.backgroundColor = [UIColor lightGrayColor];
                firstButton.enabled = NO;
                lastButton.enabled = NO;
                nextButton.enabled = NO;
                recStart.text  = @"0";
                recEnd.text  = @"0";
                totalRec.text  = @"0";
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Shipments To Display" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            else{
                
                [self getPreviousOrdersHandler:body.return_];
            }
            
        }
    }
    
    NSArray *segmentLabels = [NSArray arrayWithObjects:@"New Invoice",@"View Invoice", nil];
    
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
}

- (void)textFieldDidChange:(UITextField *)textField {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    if (textField == shipmentId) {
        if ([textField.text length] > 4) {
            shipmentView.scrollEnabled = NO;
            [self getShipmentIds:invoiceShipmentIndex searchString:textField.text];
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
                    shipmentIdStatus = FALSE;
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

- (void) segmentAction1: (id) sender  {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    mainSegmentedControl = (UISegmentedControl *)sender;
    NSInteger index = mainSegmentedControl.selectedSegmentIndex;
    
    switch (index) {
        case 0:
            orderstockTable.hidden = YES;
            nextButton.hidden = YES;
            lastButton.hidden = YES;
            firstButton.hidden = YES;
            previousButton.hidden = YES;
            searchBar.hidden = YES;
            recStart.hidden = YES;
            recEnd.hidden = YES;
            totalRec.hidden = YES;
            label1_.hidden = YES;
            label2_.hidden = YES;
            shipmentView.hidden = NO;
            orderButton.hidden = NO;
            cancelButton.hidden = NO;
            break;
        case 1:
            orderstockTable.hidden = NO;
            nextButton.hidden = NO;
            lastButton.hidden = NO;
            firstButton.hidden = NO;
            previousButton.hidden = NO;
            searchBar.hidden = NO;
            recStart.hidden = NO;
            recEnd.hidden = NO;
            totalRec.hidden = NO;
            label1_.hidden = NO;
            label2_.hidden = NO;
            shipmentView.hidden = YES;
            orderButton.hidden = YES;
            cancelButton.hidden = YES;
            break;
        default:
            break;
    }
    
}

-(void) firstButtonPressed:(id) sender {
    
    AudioServicesPlaySystemSound (soundFileObject);
    
    [itemIdArray removeAllObjects];
    [orderStatusArray removeAllObjects];
    [orderAmountArray removeAllObjects];
    [OrderedOnArray removeAllObjects];
    wareInvoiceChangeNum_ = 0;
    //    cellcount = 10;
    
    //[HUD setHidden:NO];
    [HUD show:YES];
    
    WHInvoiceServicesSoapBinding *service = [[WHInvoiceServicesSvc WHInvoiceServicesSoapBinding] retain];
    WHInvoiceServicesSvc_getInvoices *aparams = [[WHInvoiceServicesSvc_getInvoices alloc] init];
    NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str_ = [time_ componentsSeparatedByString:@" "];
    NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"requestHeader", nil];
    
    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",wareInvoiceChangeNum_],dictionary, nil];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
    
    NSError * err_;
    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
    
    aparams.invoiceDetails = normalStockString;
    WHInvoiceServicesSoapBindingResponse *response = [service getInvoicesUsingParameters:(WHInvoiceServicesSvc_getInvoices *)aparams];
    
    NSArray *responseBodyParts =  response.bodyParts;
    
    for (id bodyPart in responseBodyParts) {
        if ([bodyPart isKindOfClass:[WHInvoiceServicesSvc_getInvoicesResponse class]]) {
            WHInvoiceServicesSvc_getInvoicesResponse *body = (WHInvoiceServicesSvc_getInvoicesResponse *)bodyPart;
            //printf("\nresponse=%s",body.return_);
            if (body.return_ == NULL) {
                
                [HUD setHidden:YES];
                //nextButton.backgroundColor = [UIColor lightGrayColor];
                firstButton.enabled = NO;
                lastButton.enabled = NO;
                nextButton.enabled = NO;
                recStart.text  = @"0";
                recEnd.text  = @"0";
                totalRec.text  = @"0";
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Ordered Items Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            else{
                
                [self getPreviousOrdersHandler:body.return_];
            }
            
        }
    }
    
    
}
// last button pressed....
-(void) lastButtonPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    //float a = [rec_total.text intValue]/5;
    //float t = ([rec_total.text floatValue]/5);
    
    if ([totalRec.text intValue]/10 == ([totalRec.text floatValue]/10)) {
        
        wareInvoiceChangeNum_ = [totalRec.text intValue]/10 - 1;
    }
    else{
        wareInvoiceChangeNum_ =[totalRec.text intValue]/10;
    }
    //changeID = ([rec_total.text intValue]/5) - 1;
    
    //previousButton.backgroundColor = [UIColor grayColor];
    wareInvoiceCount1_ = (wareInvoiceChangeNum_ * 10);
    
    [itemIdArray removeAllObjects];
    [orderStatusArray removeAllObjects];
    [orderAmountArray removeAllObjects];
    [OrderedOnArray removeAllObjects];
    
    previousButton.enabled = YES;
    
    
    //frstButton.backgroundColor = [UIColor grayColor];
    firstButton.enabled = YES;
    nextButton.enabled = NO;
    
    //[HUD setHidden:NO];
    [HUD show:YES];
    
    WHInvoiceServicesSoapBinding *service = [[WHInvoiceServicesSvc WHInvoiceServicesSoapBinding] retain];
    WHInvoiceServicesSvc_getInvoices *aparams = [[WHInvoiceServicesSvc_getInvoices alloc] init];
    NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str_ = [time_ componentsSeparatedByString:@" "];
    NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"requestHeader", nil];
    
    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",wareInvoiceCount1_],dictionary, nil];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
    
    NSError * err_;
    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
    
    aparams.invoiceDetails = normalStockString;
    WHInvoiceServicesSoapBindingResponse *response = [service getInvoicesUsingParameters:(WHInvoiceServicesSvc_getInvoices *)aparams];
    
    NSArray *responseBodyParts =  response.bodyParts;
    
    for (id bodyPart in responseBodyParts) {
        if ([bodyPart isKindOfClass:[WHInvoiceServicesSvc_getInvoicesResponse class]]) {
            WHInvoiceServicesSvc_getInvoicesResponse *body = (WHInvoiceServicesSvc_getInvoicesResponse *)bodyPart;
            //printf("\nresponse=%s",body.return_);
            if (body.return_ == NULL) {
                
                [HUD setHidden:YES];
                //nextButton.backgroundColor = [UIColor lightGrayColor];
                firstButton.enabled = NO;
                lastButton.enabled = NO;
                nextButton.enabled = NO;
                recStart.text  = @"0";
                recEnd.text  = @"0";
                totalRec.text  = @"0";
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Ordered Items Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            else{
                
                [self getPreviousOrdersHandler:body.return_];
            }
            
        }
    }
    
}


// previousButtonPressed handing...

- (void) previousButtonPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    if (wareInvoiceChangeNum_ > 0){
        
        //nextButton.backgroundColor = [UIColor grayColor];
        nextButton.enabled =  YES;
        
        wareInvoiceChangeNum_--;
        wareInvoiceCount1_ = (wareInvoiceChangeNum_ * 10);
        
        [itemIdArray removeAllObjects];
        [orderStatusArray removeAllObjects];
        [orderAmountArray removeAllObjects];
        [OrderedOnArray removeAllObjects];
        
        wareInvoiceCountValue_ = NO;
        
        [HUD setHidden:NO];
        
        WHInvoiceServicesSoapBinding *service = [[WHInvoiceServicesSvc WHInvoiceServicesSoapBinding] retain];
        WHInvoiceServicesSvc_getInvoices *aparams = [[WHInvoiceServicesSvc_getInvoices alloc] init];
        NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        NSArray *str_ = [time_ componentsSeparatedByString:@" "];
        NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
        
        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
        NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"requestHeader", nil];
        
        NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",wareInvoiceCount1_],dictionary, nil];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        aparams.invoiceDetails = normalStockString;
        WHInvoiceServicesSoapBindingResponse *response = [service getInvoicesUsingParameters:(WHInvoiceServicesSvc_getInvoices *)aparams];
        
        NSArray *responseBodyParts =  response.bodyParts;
        
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[WHInvoiceServicesSvc_getInvoicesResponse class]]) {
                WHInvoiceServicesSvc_getInvoicesResponse *body = (WHInvoiceServicesSvc_getInvoicesResponse *)bodyPart;
                //printf("\nresponse=%s",body.return_);
                if (body.return_ == NULL) {
                    
                    [HUD setHidden:YES];
                    //nextButton.backgroundColor = [UIColor lightGrayColor];
                    firstButton.enabled = NO;
                    lastButton.enabled = NO;
                    nextButton.enabled = NO;
                    recStart.text  = @"0";
                    recEnd.text  = @"0";
                    totalRec.text  = @"0";
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Ordered Items Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
                else{
                    
                    [self getPreviousOrdersHandler:body.return_];
                }
                
            }
        }
        
        
        if ([recEnd.text isEqualToString:totalRec.text]) {
            
            lastButton.enabled = NO;
        }
        else {
            lastButton.enabled = YES;
        }
        
        // count1 = [itemIdArray count];
    }
    else{
        //previousButton.backgroundColor = [UIColor lightGrayColor];
        previousButton.enabled =  NO;
        
        //nextButton.backgroundColor = [UIColor grayColor];
        nextButton.enabled =  YES;
    }
    
}


// NextButtonPressed handing...

- (void) nextButtonPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    wareInvoiceChangeNum_++;
    
    wareInvoiceCount1_ = (wareInvoiceChangeNum_ * 10);
    
    [itemIdArray removeAllObjects];
    [orderStatusArray removeAllObjects];
    [orderAmountArray removeAllObjects];
    [OrderedOnArray removeAllObjects];
    
    //previousButton.backgroundColor = [UIColor grayColor];
    previousButton.enabled =  YES;
    firstButton.enabled = YES;
    
    wareInvoiceCountValue_ = YES;
    
    [HUD setHidden:NO];
    
    WHInvoiceServicesSoapBinding *service = [[WHInvoiceServicesSvc WHInvoiceServicesSoapBinding] retain];
    WHInvoiceServicesSvc_getInvoices *aparams = [[WHInvoiceServicesSvc_getInvoices alloc] init];
    NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str_ = [time_ componentsSeparatedByString:@" "];
    NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"requestHeader", nil];
    
    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",wareInvoiceCount1_],dictionary, nil];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
    
    NSError * err_;
    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
    
    aparams.invoiceDetails = normalStockString;
    WHInvoiceServicesSoapBindingResponse *response = [service getInvoicesUsingParameters:(WHInvoiceServicesSvc_getInvoices *)aparams];
    
    NSArray *responseBodyParts =  response.bodyParts;
    
    for (id bodyPart in responseBodyParts) {
        if ([bodyPart isKindOfClass:[WHInvoiceServicesSvc_getInvoicesResponse class]]) {
            WHInvoiceServicesSvc_getInvoicesResponse *body = (WHInvoiceServicesSvc_getInvoicesResponse *)bodyPart;
            //printf("\nresponse=%s",body.return_);
            if (body.return_ == NULL) {
                
                [HUD setHidden:YES];
                //nextButton.backgroundColor = [UIColor lightGrayColor];
                firstButton.enabled = NO;
                lastButton.enabled = NO;
                nextButton.enabled = NO;
                recStart.text  = @"0";
                recEnd.text  = @"0";
                totalRec.text  = @"0";
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Ordered Items Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            else{
                
                [self getPreviousOrdersHandler:body.return_];
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
    else if(tableView == orderstockTable){
        return [itemIdArray count];
    }
    else{
        return 0;
    }
}

//Customize eightForRowAtIndexPath ...
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == orderstockTable) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            return 140.0;
        }
        else {
            return 98.0;
        }
        
    }
    else{
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            return 52;
        }
        else{
            
            return 33;
            
        }
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
    else if (tableView == orderstockTable){
        
        if (wareInvoiceCountValue_ == YES) {
            
            wareInvoiceCount2_ = wareInvoiceCount2_ + wareInvoiceCount1_;
            wareInvoiceCount1_ = 0;
        }
        else{
            
            wareInvoiceCount2_ = wareInvoiceCount2_ - wareInvoiceCount3_;
            wareInvoiceCount3_ = 0;
        }
        
        if(searching)
        {
            int x = [[copyListOfItems objectAtIndex:indexPath.row] intValue];
            
            //NSString *rownum = [NSString stringWithFormat:@"%d. ", indexPath.row + count2_];
            NSString *itemNameString = [NSString stringWithFormat:@"%@", [itemIdArray objectAtIndex:x]];
            
        }
        else{
            
            // NSString *rownum = [NSString stringWithFormat:@"%d. ", indexPath.row + count2_];
            NSString *itemNameString = [NSString stringWithFormat:@"%@", [itemIdArray objectAtIndex:indexPath.row]];
            
            UILabel *label1 = [[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 55)] autorelease];
            label1.font = [UIFont boldSystemFontOfSize:30.0];
            label1.backgroundColor = [UIColor clearColor];
            label1.textAlignment = NSTextAlignmentLeft;
            label1.numberOfLines = 2;
            label1.lineBreakMode = NSLineBreakByWordWrapping;
            label1.text = itemNameString;
            label1.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
            
            UILabel *label2 = [[[UILabel alloc] initWithFrame:CGRectMake(10, 90, 200, 55)] autorelease];
            label2.font = [UIFont boldSystemFontOfSize:20.0];
            label2.backgroundColor = [UIColor clearColor];
            label2.textAlignment = NSTextAlignmentLeft;
            label2.numberOfLines = 2;
            label2.lineBreakMode = NSLineBreakByWordWrapping;
            label2.text = [orderStatusArray objectAtIndex:(indexPath.row)];
            label2.textColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
            
            UILabel *label3 = [[[UILabel alloc] initWithFrame:CGRectMake(400, 10, 400, 55)] autorelease];
            label3.font = [UIFont boldSystemFontOfSize:20.0];
            label3.backgroundColor = [UIColor clearColor];
            label3.textAlignment = NSTextAlignmentLeft;
            label3.numberOfLines = 2;
            label3.lineBreakMode = NSLineBreakByWordWrapping;
            label3.text = [OrderedOnArray objectAtIndex:(indexPath.row)];
            label3.textColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
            
            UILabel *label4 = [[[UILabel alloc] initWithFrame:CGRectMake(400, 90, 200, 55)] autorelease];
            label4.font = [UIFont boldSystemFontOfSize:20.0];
            label4.backgroundColor = [UIColor clearColor];
            label4.textAlignment = NSTextAlignmentLeft;
            label4.numberOfLines = 2;
            label4.lineBreakMode = NSLineBreakByWordWrapping;
            label4.text = [orderAmountArray objectAtIndex:(indexPath.row)];
            label4.textColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                
                label1.frame = CGRectMake(5, 10, 150, 30);
                label1.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0];
                label2.frame = CGRectMake(5, 60, 150, 30);
                label2.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0];
                label3.frame = CGRectMake(160, 10, 150, 30);
                label3.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0];
                label4.frame = CGRectMake(160, 60, 150, 30);
                label4.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0];
                
            }

            [cell.contentView addSubview:label1];
            [cell.contentView addSubview:label2];
            [cell.contentView addSubview:label3];
            [cell.contentView addSubview:label4];
            
            [cell setBackgroundColor:[UIColor blackColor]];
            
            return cell;
        }
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            cell.textLabel.font = [UIFont boldSystemFontOfSize:25];
        }
        else{
            
            cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
            
        }
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
    else if (tableView == orderstockTable){
        self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
        self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
        ViewWarehouseInvoice *vpo = [[ViewWarehouseInvoice alloc] initWithInvoiceID:[NSString stringWithFormat:@"%@",[itemIdArray objectAtIndex:indexPath.row]]];
        [self.navigationController pushViewController:vpo animated:YES];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == shipIdTable) {
        if (shipmentIdStatus) {
            [self getShipmentIds:[shipmentIdList count] searchString:shipmentId.text];
        }
    }
    else if (tableView == orderstockTable) {
        //1. Setup the CATransform3D structure
        CATransform3D rotation;
        rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
        rotation.m34 = 1.0/ -600;
        
        
        //2. Define the initial state (Before the animation)
        cell.layer.shadowColor = [[UIColor blackColor]CGColor];
        cell.layer.shadowOffset = CGSizeMake(10, 10);
        cell.alpha = 0;
        
        cell.layer.transform = rotation;
        cell.layer.anchorPoint = CGPointMake(0, 0.5);
        
        //!!!FIX for issue #1 Cell position wrong------------
        if(cell.layer.position.x != 0){
            cell.layer.position = CGPointMake(0, cell.layer.position.y);
        }
        
        //4. Define the final state (After the animation) and commit the animation
        [UIView beginAnimations:@"rotation" context:NULL];
        [UIView setAnimationDuration:0.8];
        cell.layer.transform = CATransform3DIdentity;
        cell.alpha = 1;
        cell.layer.shadowOffset = CGSizeMake(0, 0);
        [UIView commitAnimations];
    }

}

- (void) orderButtonPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    NSString *shipmentIdValue = [shipmentId.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *lshipmentNoteValue = [orderId.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipmentDateValue = [shipmentNoteId.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipmentModeValue = [customerName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipmentAgencyValue = [buildingNo.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipmentAgencyContactValue = [streetName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *inspectedByValue = [city.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shippedByValue = [country.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipmentCostValue = [shipmentCost.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipmentLocationValue = [zip_code.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipmentCityValue = [shipmentAgency.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipmentStreetValue = [insuranceCost.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *packagesDescriptionValue = [paymentTerms.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *rfidTagNoValue = [invoiceDate.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *gatePassRefValue = [remarks.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([skuIdArray count] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Add Items to Cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else if ([shipmentIdValue length] == 0 || [lshipmentNoteValue length] == 0 || [shipmentDateValue length] == 0 || [shipmentModeValue length] == 0 || [shipmentAgencyValue length] == 0 || [shipmentAgencyContactValue length] == 0 || [inspectedByValue length] == 0 || [shippedByValue length] == 0 || [rfidTagNoValue length] == 0 || [shipmentCostValue length] == 0 || [shipmentLocationValue length] == 0 || [shipmentCityValue length] == 0 || [shipmentStreetValue length] == 0 || [packagesDescriptionValue length] == 0 || [gatePassRefValue length] == 0){
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
        WHInvoiceServicesSvc_createInvoice *aparams = [[WHInvoiceServicesSvc_createInvoice alloc] init];
        NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        NSArray *str_ = [time_ componentsSeparatedByString:@" "];
        NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
        
        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
        NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"orderId", @"shipmentId",@"shipmentNoteId",@"customerName",@"buildingNo",@"streetName",@"city",@"country",@"zip_code",@"noOfPackages",@"shipmentAgency",@"totalItemCost",@"shipmentCost",@"tax",@"insuranceCost",@"paymentTerms",@"remarks",@"invoiceDate",@"invoiceStatus",@"invoiceItems",@"requestHeader", nil];
        
        NSArray *loyaltyObjects = [NSArray arrayWithObjects:orderId.text,shipmentId.text,shipmentNoteId.text,customerName.text,buildingNo.text,streetName.text,city.text,country.text,zip_code.text,[NSString stringWithFormat:@"%d",totalQuantity],shipmentAgency.text,totAmountData.text,shipmentCost.text,taxData.text,insuranceCost.text,paymentTerms.text,remarks.text,invoiceDate.text,@"submitted",items,dictionary, nil];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        aparams.invoiceDetails = normalStockString;
        WHInvoiceServicesSoapBindingResponse *response = [service createInvoiceUsingParameters:(WHInvoiceServicesSvc_createInvoice *)aparams];
        
        NSArray *responseBodyParts =  response.bodyParts;
        NSError *e;
        
        NSDictionary *JSON1;
        
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[WHInvoiceServicesSvc_createInvoiceResponse class]]) {
                WHInvoiceServicesSvc_createInvoiceResponse *body = (WHInvoiceServicesSvc_createInvoiceResponse *)bodyPart;
                NSLog(@"%@",body.return_);
                JSON1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                        options: NSJSONReadingMutableContainers
                                                          error: &e];
                NSDictionary *responseDic = [JSON1 objectForKey:@"responseHeader"];
                if ([[responseDic objectForKey:@"responseMessage"] isEqualToString:@"Invoice Created Successfully"] && [[responseDic objectForKey:@"responseCode"] isEqualToString:@"0"]) {
                    NSString *status = [NSString stringWithFormat:@"%@%@%@%@",@"Successfully Invoice Created",@"\n",@"Shipment ID :",[JSON1 objectForKey:@"invoiceId"]];
                    wareInvoiceId = [[JSON1 objectForKey:@"invoiceId"] copy];
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
                    
                    shipmentId.text = nil;
                    orderId.text = nil;
                    invoiceDate.text = currentdate;
                    customerName.text = nil;
                    buildingNo.text= nil;
                    streetName.text = nil;
                    city.text = nil;
                    country.text= nil;
                    shipmentCost.text = nil;
                    zip_code.text = nil;
                    shipmentAgency.text = nil;
                    insuranceCost.text = nil;
                    paymentTerms.text = nil;
                    shipmentNoteId.text = nil;
                    remarks.text = nil;
                    
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
    NSString *shipmentCostValue = [shipmentCost.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
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
        WHInvoiceServicesSvc_createInvoice *aparams = [[WHInvoiceServicesSvc_createInvoice alloc] init];
        NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        NSArray *str_ = [time_ componentsSeparatedByString:@" "];
        NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
        
        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
        NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"orderId", @"shipmentId",@"shipmentNoteId",@"customerName",@"buildingNo",@"streetName",@"city",@"country",@"zip_code",@"noOfPackages",@"shipmentAgency",@"totalItemCost",@"shipmentCost",@"tax",@"insuranceCost",@"paymentTerms",@"remarks",@"invoiceDate",@"invoiceStatus",@"invoiceItems",@"requestHeader", nil];
        NSArray *loyaltyObjects;
        if ([shipmentCostValue length] == 0) {
            loyaltyObjects = [NSArray arrayWithObjects:orderId.text,shipmentId.text,shipmentNoteId.text,customerName.text,buildingNo.text,streetName.text,city.text,country.text,zip_code.text,[NSString stringWithFormat:@"%d",totalQuantity],shipmentAgency.text,totAmountData.text,shipmentCost.text,taxData.text,insuranceCost.text,paymentTerms.text,@"djfhgjd",invoiceDate.text,@"submitted",items,dictionary, nil];
        }else{
            loyaltyObjects = [NSArray arrayWithObjects:orderId.text,shipmentId.text,shipmentNoteId.text,customerName.text,buildingNo.text,streetName.text,city.text,country.text,zip_code.text,[NSString stringWithFormat:@"%d",totalQuantity],shipmentAgency.text,totAmountData.text,shipmentCost.text,taxData.text,insuranceCost.text,paymentTerms.text,remarks.text,invoiceDate.text,@"pending",items,dictionary, nil];
        }
        
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        aparams.invoiceDetails = normalStockString;
        WHInvoiceServicesSoapBindingResponse *response = [service createInvoiceUsingParameters:(WHInvoiceServicesSvc_createInvoice *)aparams];
        
        NSArray *responseBodyParts =  response.bodyParts;
        NSError *e;
        
        NSDictionary *JSON1;
        
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[WHInvoiceServicesSvc_createInvoiceResponse class]]) {
                WHInvoiceServicesSvc_createInvoiceResponse *body = (WHInvoiceServicesSvc_createInvoiceResponse *)bodyPart;
                NSLog(@"%@",body.return_);
                JSON1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                        options: NSJSONReadingMutableContainers
                                                          error: &e];
                NSDictionary *responseDic = [JSON1 objectForKey:@"responseHeader"];
                if ([[responseDic objectForKey:@"responseMessage"] isEqualToString:@"Invoice Created Successfully"] && [[responseDic objectForKey:@"responseCode"] isEqualToString:@"0"]) {
                    NSString *status = [NSString stringWithFormat:@"%@%@%@%@",@"Successfully Invoice Created",@"\n",@"Shipment ID :",[JSON1 objectForKey:@"invoiceId"]];
                    wareInvoiceId = [[JSON1 objectForKey:@"invoiceId"] copy];
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
                    
                    shipmentId.text = nil;
                    orderId.text = nil;
                    invoiceDate.text = currentdate;
                    customerName.text = nil;
                    buildingNo.text= nil;
                    streetName.text = nil;
                    city.text = nil;
                    country.text= nil;
                    shipmentCost.text = nil;
                    zip_code.text = nil;
                    shipmentAgency.text = nil;
                    insuranceCost.text = nil;
                    paymentTerms.text = nil;
                    shipmentNoteId.text = nil;
                    remarks.text = nil;
                    
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
            
            ViewWarehouseInvoice *vpo = [[ViewWarehouseInvoice alloc] initWithInvoiceID:wareInvoiceId];
            [self.navigationController pushViewController:vpo animated:YES];
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
