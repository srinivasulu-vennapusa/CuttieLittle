//
//  EditWareHouseReceipt.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/17/15.
//
//

#import "EditWareHouseReceipt.h"
#import "MaterialTransferReciepts.h"
#import "Global.h"
#import "WHStockReceiptService.h"
#import "RawMaterialServiceSvc.h"
#import "SkuServiceSvc.h"
#import "UtilityMasterServiceSvc.h"
#import "OpenWareHouseReceipt.h"

@interface EditWareHouseReceipt ()

@end

@implementation EditWareHouseReceipt

@synthesize soundFileObject,soundFileURLRef;

int ware_receipt_id_val = 0;
int wareEditQuantity = 0;
int wareEditMaterialTagid = 0;
float wareEditMaterialCost = 0.0f;
int wareEditRejectMaterialTagid = 0;
NSString *wareEditReceipt = @"";
NSString *wareEditFinalReceiptID = @"";

bool wareEditstockScrollValueStatus_ = NO;
int  wareEditstockStartIndex = 0;

-(id) initWithReceiptID:(NSString *)receiptID{
    
    wareEditFinalReceiptID = [receiptID copy];
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    titleLbl.text = @"Edit Stock Receipt";
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
        titleLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:12.0f];
    }
    
    self.navigationItem.titleView = titleView;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    locationArr = [[NSMutableArray alloc] init];
    
    receiptRefNo = [[UITextField alloc] init];
    receiptRefNo.borderStyle = UITextBorderStyleRoundedRect;
    receiptRefNo.textColor = [UIColor blackColor];
    receiptRefNo.font = [UIFont systemFontOfSize:18.0];
    receiptRefNo.backgroundColor = [UIColor whiteColor];
    receiptRefNo.clearButtonMode = UITextFieldViewModeWhileEditing;
    receiptRefNo.backgroundColor = [UIColor whiteColor];
    receiptRefNo.autocorrectionType = UITextAutocorrectionTypeNo;
    receiptRefNo.layer.borderColor = [UIColor whiteColor].CGColor;
    receiptRefNo.backgroundColor = [UIColor whiteColor];
    receiptRefNo.delegate = self;
    receiptRefNo.placeholder = @"   Receipt ID";
    [receiptRefNo addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
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
    toLocation.userInteractionEnabled = FALSE;
    
    locationTable = [[UITableView alloc] init];
    locationTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [locationTable setDataSource:self];
    [locationTable setDelegate:self];
    [locationTable.layer setBorderWidth:1.0f];
    locationTable.layer.cornerRadius = 3;
    locationTable.layer.borderColor = [UIColor grayColor].CGColor;
    locationTable.hidden = YES;
    
    selectLocation = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *buttonImageDD = [UIImage imageNamed:@"combo.png"];
    [selectLocation setBackgroundImage:buttonImageDD forState:UIControlStateNormal];
    [selectLocation addTarget:self
                       action:@selector(getListOfLocations:) forControlEvents:UIControlEventTouchDown];
    selectLocation.tag = 1;
    
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
    // [deliveredBy addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
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
    // [inspectedBy addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
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
    
    BillField = [[UITextField alloc] init];
    BillField.borderStyle = UITextBorderStyleRoundedRect;
    BillField.textColor = [UIColor blackColor];
    BillField.font = [UIFont systemFontOfSize:18.0];
    BillField.backgroundColor = [UIColor whiteColor];
    BillField.clearButtonMode = UITextFieldViewModeWhileEditing;
    BillField.backgroundColor = [UIColor whiteColor];
    BillField.autocorrectionType = UITextAutocorrectionTypeNo;
    BillField.layer.borderColor = [UIColor whiteColor].CGColor;
    BillField.backgroundColor = [UIColor whiteColor];
    BillField.placeholder = @"      Search Item Here";
    BillField.delegate = self;
    [BillField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [BillField setEnabled:TRUE];
    
    // table for drop down list to show the skuid's ..
    skListTable = [[UITableView alloc] init];
    skListTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [skListTable setDataSource:self];
    [skListTable setDelegate:self];
    [skListTable.layer setBorderWidth:1.0f];
    skListTable.layer.cornerRadius = 3;
    skListTable.layer.borderColor = [UIColor grayColor].CGColor;
    
    recieptNumberTxt = [[[UITextField alloc] init] autorelease];
    recieptNumberTxt.borderStyle = UITextBorderStyleRoundedRect;
    recieptNumberTxt.text = @"";
    recieptNumberTxt.font = [UIFont systemFontOfSize:25.0];
    recieptNumberTxt.backgroundColor = [UIColor whiteColor];
    recieptNumberTxt.textAlignment = NSTextAlignmentLeft;
    recieptNumberTxt.textColor = [UIColor blackColor];
    recieptNumberTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    recieptNumberTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    recieptNumberTxt.keyboardType = UIKeyboardTypeDefault;
    recieptNumberTxt.returnKeyType = UIReturnKeyDone;
    recieptNumberTxt.placeholder = @"Reciept ID";
    [recieptNumberTxt setEnabled:FALSE];
    
    fromLocationTxt = [[[UITextField alloc] init] autorelease];
    fromLocationTxt.borderStyle = UITextBorderStyleRoundedRect;
    fromLocationTxt.text = @"";
    fromLocationTxt.font = [UIFont systemFontOfSize:25.0];
    fromLocationTxt.backgroundColor = [UIColor whiteColor];
    fromLocationTxt.textAlignment = NSTextAlignmentLeft;
    fromLocationTxt.textColor = [UIColor blackColor];
    fromLocationTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    fromLocationTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    fromLocationTxt.keyboardType = UIKeyboardTypeDefault;
    fromLocationTxt.returnKeyType = UIReturnKeyDone;
    fromLocationTxt.placeholder = @"From Location";
    [fromLocationTxt setEnabled:FALSE];
    
    dropDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImageSM = [UIImage imageNamed:@"combo.png"];
    [dropDownButton setBackgroundImage:buttonImageSM forState:UIControlStateNormal];
    [dropDownButton addTarget:self action:@selector(shipoModeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    dropDownButton.userInteractionEnabled = YES;
    
    UILabel *label2 = [[[UILabel alloc] init] autorelease];
    label2.text = @"Item";
    label2.layer.cornerRadius = 14;
    label2.layer.masksToBounds = YES;
    [label2 setTextAlignment:NSTextAlignmentCenter];
    label2.font = [UIFont boldSystemFontOfSize:14.0];
    label2.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label2.textColor = [UIColor whiteColor];
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"Price";
    label3.layer.cornerRadius = 14;
    label3.layer.masksToBounds = YES;
    [label3 setTextAlignment:NSTextAlignmentCenter];
    label3.font = [UIFont boldSystemFontOfSize:14.0];
    label3.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label3.textColor = [UIColor whiteColor];
    
    UILabel *label4 = [[[UILabel alloc] init] autorelease];
    label4.text = @"Qty";
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
    
    fromLocation = [[UITableView alloc] init];
    fromLocation.backgroundColor = [UIColor clearColor];
    [fromLocation setDataSource:self];
    [fromLocation setDelegate:self];
    fromLocation.hidden = YES;
    
    fromLocationDetails = [[NSMutableArray alloc] init];
    [fromLocationDetails addObject:@"site1"];
    [fromLocationDetails addObject:@"site2"];
    [fromLocationDetails addObject:@"site3"];
    [fromLocationDetails addObject:@"site4"];
    
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
    
    totalQunatity = [[[UILabel alloc] init] autorelease];
    totalQunatity.text = @"0";
    totalQunatity.layer.cornerRadius = 14;
    totalQunatity.layer.masksToBounds = YES;
    [totalQunatity setTextAlignment:NSTextAlignmentLeft];
    totalQunatity.font = [UIFont boldSystemFontOfSize:14.0];
    totalQunatity.textColor = [UIColor whiteColor];
    
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
    
    rawMaterialDetails = [[NSMutableArray alloc] init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        location.font = [UIFont boldSystemFontOfSize:20];
        location.frame = CGRectMake(10.0, 10.0, 360, 50);
        
        toLocation.font = [UIFont boldSystemFontOfSize:20];
        toLocation.frame = CGRectMake(400.0, 10.0, 360, 50);
        
        selectLocation.frame = CGRectMake(330, 5, 50, 65);
        
        locationTable.frame = CGRectMake(10.0, 70.0, 360, 0);
        
        deliveredBy.font = [UIFont boldSystemFontOfSize:20];
        deliveredBy.frame = CGRectMake(10.0, 70.0, 360, 50);
        
        inspectedBy.font = [UIFont boldSystemFontOfSize:20];
        inspectedBy.frame = CGRectMake(400.0, 70.0, 360, 50);
        
        date.font = [UIFont boldSystemFontOfSize:20];
        date.frame = CGRectMake(10.0, 130.0, 360, 50);
        
        
        
        BillField.font = [UIFont boldSystemFontOfSize:20];
        BillField.frame = CGRectMake(200.0, 190.0, 360.0, 50.0);
        
        skListTable.frame = CGRectMake(175, 80, 360,0);
        recieptNumberTxt.frame = CGRectMake(10.0, 140.0, 300.0, 50.0);
        fromLocationTxt.frame = CGRectMake(10.0, 150.0, 300.0, 50.0);
        dropDownButton.frame = CGRectMake(300.0, 143.0, 60.0, 70.0);
        
        label2.font = [UIFont boldSystemFontOfSize:20];
        label2.frame = CGRectMake(10, 260.0, 90, 55);
        label3.font = [UIFont boldSystemFontOfSize:20];
        label3.frame = CGRectMake(110, 260.0, 90, 55);
        label4.font = [UIFont boldSystemFontOfSize:20];
        label4.frame = CGRectMake(210, 260.0, 90, 55);
        label5.font = [UIFont boldSystemFontOfSize:20];
        label5.frame = CGRectMake(310, 260.0, 90, 55);
        //        label8.font = [UIFont boldSystemFontOfSize:20];
        //        label8.frame = CGRectMake(371, 260.0, 110, 55);
        label9.font = [UIFont boldSystemFontOfSize:20];
        label9.frame = CGRectMake(410, 260.0, 110, 55);
        label10.font = [UIFont boldSystemFontOfSize:20];
        label10.frame = CGRectMake(530, 260.0, 110, 55);
        
        scrollView.frame = CGRectMake(0, 325, 778, 600);
        scrollView.contentSize = CGSizeMake(778, 1000);
        cartTable.frame = CGRectMake(0, 0, 780,200);
        
        label6.font = [UIFont boldSystemFontOfSize:20];
        label6.frame = CGRectMake(12, 635.0, 200, 55);
        
        totalQunatity.font = [UIFont boldSystemFontOfSize:20];
        totalQunatity.frame = CGRectMake(600.0, 635.0, 200, 55);
        
        label7.font = [UIFont boldSystemFontOfSize:20];
        label7.frame = CGRectMake(12, 700.0, 200, 55);
        
        totalCost.font = [UIFont boldSystemFontOfSize:20];
        totalCost.frame = CGRectMake(600.0, 700.0, 200, 55);
        
        submitBtn.frame = CGRectMake(55.0f, 820.0,300.0f, 55.0f);
        submitBtn.layer.cornerRadius = 25.0f;
        submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        cancelButton.frame = CGRectMake(425.0f, 820.0,300.0f, 55.0f);
        cancelButton.layer.cornerRadius = 25.0f;
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        
        
        [self.view addSubview:label2];
        [self.view addSubview:label3];
        [self.view addSubview:label4];
        [self.view addSubview:label5];
        
        //    [self.view addSubview:label8];
        [self.view addSubview:label9];
        [self.view addSubview:label10];
        
        
    }
    else {
        
        location.font = [UIFont boldSystemFontOfSize:15];
        location.frame = CGRectMake(0.0, 5.0, 150, 35);
        
        toLocation.font = [UIFont boldSystemFontOfSize:15];
        toLocation.frame = CGRectMake(160.0, 5.0, 160, 35);
        
        selectLocation.frame = CGRectMake(130, 2, 30, 45);
        
        locationTable.frame = CGRectMake(10.0, 30.0, 120, 0);
        
        deliveredBy.font = [UIFont boldSystemFontOfSize:15];
        deliveredBy.frame = CGRectMake(0.0, 45.0, 150, 35);
        
        inspectedBy.font = [UIFont boldSystemFontOfSize:15];
        inspectedBy.frame = CGRectMake(160.0, 45.0, 160, 35);
        
        date.font = [UIFont boldSystemFontOfSize:20];
        date.frame = CGRectMake( 0.0, 90.0, 220, 35);
        
        
        BillField.font = [UIFont boldSystemFontOfSize:17];
        BillField.frame = CGRectMake(60.0, 135, 180, 35.0);
        
        skListTable.frame = CGRectMake(175, 80, 360,0);
        recieptNumberTxt.frame = CGRectMake(10.0, 140.0, 300.0, 50.0);
        fromLocationTxt.frame = CGRectMake(10.0, 150.0, 300.0, 50.0);
        dropDownButton.frame = CGRectMake(300.0, 143.0, 60.0, 70.0);
        
        label2.font = [UIFont boldSystemFontOfSize:15];
        label2.frame = CGRectMake(0, 0, 50, 35);
        label3.font = [UIFont boldSystemFontOfSize:15];
        label3.frame = CGRectMake(50, 0, 60, 35);
        label4.font = [UIFont boldSystemFontOfSize:15];
        label4.frame = CGRectMake(110, 0, 60, 35);
        label5.font = [UIFont boldSystemFontOfSize:15];
        label5.frame = CGRectMake(170, 0, 60, 35);
        label9.font = [UIFont boldSystemFontOfSize:15];
        label9.frame = CGRectMake(230, 0, 80, 35);
        // label8.font = [UIFont boldSystemFontOfSize:20];
        // label8.frame = CGRectMake(494, 270, 110, 55);
        label10.font = [UIFont boldSystemFontOfSize:15];
        label10.frame = CGRectMake(310, 0, 80, 35);
        //        label10.font = [UIFont boldSystemFontOfSize:15];
        //        label10.frame = CGRectMake(350.0, 0, 80, 35);
        
        scrollView.frame = CGRectMake(10, 175, 400.0, 150.0);
        scrollView.contentSize = CGSizeMake(600, 1000);
        cartTable.frame = CGRectMake(0, 40, 750,60);
        
        label6.font = [UIFont boldSystemFontOfSize:15];
        label6.frame = CGRectMake(10.0, 315.0, 120, 25.0);
        [label6 setBackgroundColor:[UIColor clearColor]];
        
        label7.font = [UIFont boldSystemFontOfSize:15];
        label7.frame = CGRectMake(10.0, 345.0, 150, 25);
        [label7 setBackgroundColor:[UIColor clearColor]];
        
        totalQunatity.font = [UIFont boldSystemFontOfSize:15];
        totalQunatity.frame = CGRectMake(190.0, 315.0, 120, 25);
        [totalQunatity setBackgroundColor:[UIColor clearColor]];
        
        
        totalCost.font = [UIFont boldSystemFontOfSize:15];
        totalCost.frame = CGRectMake(190.0, 345.0, 120, 25);
        [totalCost setBackgroundColor:[UIColor clearColor]];
        
        
        submitBtn.frame = CGRectMake(5.0f, 370.0,150.0f, 35.0f);
        submitBtn.layer.cornerRadius = 17.0f;
        submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        cancelButton.frame = CGRectMake(160.0f, 370.0,150.0f, 35.0f);
        cancelButton.layer.cornerRadius = 17.0f;
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        
        [scrollView addSubview:label2];
        [scrollView addSubview:label3];
        [scrollView addSubview:label4];
        [scrollView addSubview:label5];
        [scrollView addSubview:label8];
        [scrollView addSubview:label9];
        [scrollView addSubview:label10];
        //        [scrollView addSubview:label6];
        //        [scrollView addSubview:label7];
        //        [scrollView addSubview:totalCost];
        //        [scrollView addSubview:totalQunatity];
        
    }
    
    [self.view addSubview:location];
    [self.view addSubview:selectLocation];
    [self.view addSubview:locationTable];
    [self.view addSubview:deliveredBy];
    [self.view addSubview:inspectedBy];
    [self.view addSubview:toLocation];
    [self.view addSubview:date];
    [self.view addSubview:BillField];
    [self.view addSubview:skListTable];
    [self.view addSubview:label6];
    [self.view addSubview:label7];
    [self.view addSubview:totalQunatity];
    [self.view addSubview:totalCost];
    [scrollView addSubview:cartTable];
    [self.view addSubview:scrollView];
    [self.view addSubview:submitBtn];
    [self.view addSubview:cancelButton];
    
    [self callReceiptIDDetails:wareEditFinalReceiptID];

}

-(void) callReceiptIDDetails:(NSString *)receiptID{
    
    wareEditMaterialCost = 0.0f;
    wareEditQuantity = 0;
    [rawMaterialDetails removeAllObjects];
    totalCost.text = @"0.0";
    totalQunatity.text = @"0";
    
    BOOL status = FALSE;
    
    WHStockReceiptServiceSoapBinding *materialBinding = [[WHStockReceiptService WHStockReceiptServiceSoapBinding] retain];
    //    tns1_getStockReceipt *aparams = [[tns1_getStockReceipt alloc] init];
    //    aparams.receiptID = receiptID;
    //
    //    StockReceiptServiceSoapBindingResponse *response = [materialBinding getStockReceiptUsingParameters:(tns1_getStockReceipt *)aparams];
    //    NSDictionary *JSON = NULL;
    //    NSArray *responseBodyParts = response.bodyParts;
    //    for (id bodyPart in responseBodyParts) {
    //        if ([bodyPart isKindOfClass:[tns1_getStockReceiptResponse class]]) {
    //            tns1_getStockReceiptResponse *body = (tns1_getStockReceiptResponse *)bodyPart;
    //            printf("\nresponse=%s",[body.return_ UTF8String]);
    //
    //            NSError *e;
    //            JSON = [[NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
    //                                                    options: NSJSONReadingMutableContainers
    //                                                      error: &e] copy];
    //        }
    //    }
    
    
    NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str = [time componentsSeparatedByString:@" "];
    NSString *date_ = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    
    NSMutableDictionary *receiptDetails1 = [[NSMutableDictionary alloc] init];
    [receiptDetails1 setObject:dictionary_ forKey:@"requestHeader"];
    [receiptDetails1 setObject:wareEditFinalReceiptID forKey:@"goods_receipt_ref_num"];
    // [receiptDetails1 setObject:[NSString stringWithFormat:@"%d",startIndex] forKey:@""];
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:receiptDetails1 options:0 error:&err];
    NSString * createReceiptJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    materialBinding.logXMLInOut = YES;
    
    WHStockReceiptService_getStockReceipt *create_receipt = [[WHStockReceiptService_getStockReceipt alloc] init];
    create_receipt.receiptID = createReceiptJsonString;
    
    WHStockReceiptServiceSoapBindingResponse *response = [materialBinding getStockReceiptUsingParameters:create_receipt];
    
    NSArray *responseBodyParts = response.bodyParts;
    
    NSDictionary *JSONData;
    NSError *e;
    
    for (id bodyPart in responseBodyParts) {
        
        if ([bodyPart isKindOfClass:[WHStockReceiptService_getStockReceiptResponse class]]) {
            
            WHStockReceiptService_getStockReceiptResponse *body = (WHStockReceiptService_getStockReceiptResponse *)bodyPart;
            printf("\nresponse=%s",[body.return_ UTF8String]);
            
            status = TRUE;
            JSONData = [[NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                        options: NSJSONReadingMutableContainers
                                                          error: &e] copy];
        }
    }
    
    //    NSArray *item = [JSONData objectForKey:@"item"];
    //    NSArray *price = [JSONData objectForKey:@"price"];
    //    NSArray *qty = [JSON objectForKey:@"quantity"];
    //    NSArray *max_qty = [JSON objectForKey:@"max_quantity"];
    //    NSArray *cost = [JSON objectForKey:@"cost"];
    //    NSArray *description = [JSON objectForKey:@"description"];
    //    NSArray *supplied = [JSON objectForKey:@"supplied"];
    //    NSArray *rejected = [JSON objectForKey:@"rejected"];
    
    //    for (int i = 0; i < [item count]; i++) {
    //
    //        NSArray *finalArray = [NSArray arrayWithObjects:[item objectAtIndex:i],
    //                               [price objectAtIndex:i],
    //                               [qty objectAtIndex:i],
    //                               [supplied objectAtIndex:i],
    //                               [received objectAtIndex:i],
    //                               [rejected objectAtIndex:i],
    //                               [description objectAtIndex:i],
    //                               [max_qty objectAtIndex:i],
    //                               nil];
    //
    //        [rawMaterialDetails addObject:finalArray];
    //
    //    }
    
    if (status) {
        NSDictionary *temp1 = [JSONData objectForKey:@"warehouse_receipt"];
        
        NSArray *items = [JSONData objectForKey:@"itemDetails"];
        
        // dateValue.text = [temp1 objectForKey:@"Delivery_date"];
        // receiptRefNoValue.text = [temp1 objectForKey:@"goods_receipt_ref_num"];
        // supplierIDValue.text = [temp1 objectForKey:@"supplier_id"];
        //supplierNameValue.text = [temp1 objectForKey:@"Received_by"];
        location.text = [temp1 objectForKey:@"shipped_from"];
        ware_receipt_id_val = [[temp1 objectForKey:@"id_goods_receipt"] intValue];
        deliveredBy.text = [temp1 objectForKey:@"delivered_by"];
        inspectedBy.text = [temp1 objectForKey:@"InspectedBy"];
        toLocation.text = [temp1 objectForKey:@"receipt_location"];
        
        for (int i = 0; i < [items count]; i++) {
            NSDictionary *itemDic = [items objectAtIndex:i];
            NSMutableArray *itemArr = [[NSMutableArray alloc] init];
            [itemArr addObject:[itemDic valueForKey:@"description"]];
            //[itemArr addObject:[itemDic valueForKey:@"S_No"]];
            // [itemArr addObject:[itemDic valueForKey:@"reciept_id"]];
            [itemArr addObject:[itemDic valueForKey:@"item"]];
            [itemArr addObject:[itemDic valueForKey:@"price"]];
            [itemArr addObject:[itemDic valueForKey:@"quantity"]];
            [itemArr addObject:[itemDic valueForKey:@"max_quantity"]];
            [itemArr addObject:[itemDic valueForKey:@"supplied"]];
            [itemArr addObject:[itemDic valueForKey:@"recieved"]];
            [itemArr addObject:[itemDic valueForKey:@"rejected"]];
            [itemArr addObject:[itemDic valueForKey:@"cost"]];
            
            [rawMaterialDetails addObject:itemArr];
            
            
        }
        for (int j = 0; j < [rawMaterialDetails count]; j++) {
            
            NSArray *temp = [rawMaterialDetails objectAtIndex:j];
            
            wareEditQuantity = wareEditQuantity + [[temp objectAtIndex:6] intValue];
            wareEditMaterialCost = wareEditMaterialCost + ([[temp objectAtIndex:6] intValue] * [[temp objectAtIndex:2]  floatValue]);
        }
        
        totalQunatity.text = [NSString stringWithFormat:@"%d",wareEditQuantity];
        totalCost.text = [NSString stringWithFormat:@"%.2f",wareEditMaterialCost];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            cartTable.frame = CGRectMake(cartTable.frame.origin.x, cartTable.frame.origin.y, cartTable.frame.size.width, cartTable.frame.size.height + 60);
        }
        else {
            cartTable.frame = CGRectMake(cartTable.frame.origin.x, cartTable.frame.origin.y, cartTable.frame.size.width, cartTable.frame.size.height + 30);
        }
        [cartTable reloadData];
        
    }
    
}


-(void)shipoModeButtonPressed{
    fromLocation.hidden = NO;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        fromLocation.frame = CGRectMake(10.0, 200.0, 300.0, 200.0);
    }
    else {
        
    }
    [self.view addSubview:fromLocation];
    [fromLocation reloadData];
}

-(void) callRawMaterials:(NSString *)searchString {
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
    
    NSDictionary *JSON;
    
    @try {
        
        SkuServiceSoapBindingResponse *response = [skuService getSkuDetailsUsingParameters:(SkuServiceSvc_getSkuDetails *)getSkuid];
        NSArray *responseBodyParts = response.bodyParts;
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[SkuServiceSvc_getSkuDetailsResponse class]]) {
                SkuServiceSvc_getSkuDetailsResponse *body = (SkuServiceSvc_getSkuDetailsResponse *)bodyPart;
                printf("\nresponse=%s",[body.return_ UTF8String]);
                NSError *e;
                JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                       options: NSJSONReadingMutableContainers
                                                         error: &e];
            }
        }
    }
    @catch (NSException *exception) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Failed to get the details" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    NSArray *temp = [NSArray arrayWithObjects:[JSON objectForKey:@"description"],[JSON objectForKey:@"productName"],[JSON objectForKey:@"price"],@"1",[JSON objectForKey:@"price"],@"1",@"1",@"0",@"N/A", nil];
    
    //       NSArray *temp = [NSArray arrayWithObjects:[JSON objectForKey:@"product_name"],[JSON objectForKey:@"price"],@"1",@"1",@"1",@"0",[JSON objectForKey:@"description"],[JSON objectForKey:@"quantity"], nil];
    
    for (int c = 0; c < [rawMaterialDetails count]; c++) {
        NSArray *material = [rawMaterialDetails objectAtIndex:c];
        if ([[material objectAtIndex:0] isEqualToString:[NSString stringWithFormat:@"%@",[JSON objectForKey:@"productName"]]]) {
            NSArray *temp = [NSArray arrayWithObjects:[material objectAtIndex:0],[material objectAtIndex:1],[material objectAtIndex:2],[NSString stringWithFormat:@"%d",[[material objectAtIndex:3] intValue] + 1],[NSString stringWithFormat:@"%.2f",(([[material objectAtIndex:7] intValue] + 1) * [[material objectAtIndex:2] floatValue])],[material objectAtIndex:5],[NSString stringWithFormat:@"%d",[[material objectAtIndex:6] intValue] + 1],[material objectAtIndex:7] ,[material objectAtIndex:8], nil];
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
    
    wareEditQuantity = 0;
    wareEditMaterialCost = 0.0f;
    
    for (int i = 0; i < [rawMaterialDetails count]; i++) {
        NSArray *material = [rawMaterialDetails objectAtIndex:i];
        wareEditQuantity = wareEditQuantity + [[material objectAtIndex:3] intValue];
        wareEditMaterialCost = wareEditMaterialCost + ([[material objectAtIndex:6] intValue] * [[material objectAtIndex:2] floatValue]);
    }
    
    totalQunatity.text = [NSString stringWithFormat:@"%d",wareEditQuantity];
    totalCost.text = [NSString stringWithFormat:@"%.2f",wareEditMaterialCost];
}

- (void)textFieldDidChange:(UITextField *)textField {
    
    if (textField == BillField) {
        
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
                    skListTable.frame = CGRectMake(200, 240, 360,240);
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
                        skListTable.frame = CGRectMake(200, 240, 360,450);
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
    else if (textField == rejectedQty){
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        [textField resignFirstResponder];
        cartTable.userInteractionEnabled = FALSE;
        location.userInteractionEnabled = FALSE;
        deliveredBy.userInteractionEnabled = FALSE;
        inspectedBy.userInteractionEnabled = FALSE;
        submitBtn.userInteractionEnabled = FALSE;
        cancelButton.userInteractionEnabled = FALSE;
        
        NSArray *temp = [rawMaterialDetails objectAtIndex:textField.tag];
        
        rejectQtyChangeDisplayView = [[UIView alloc]init];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            rejectQtyChangeDisplayView.frame = CGRectMake(200, 300, 375, 300);
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
        
        
        UILabel *availQty = [[UILabel alloc] init];
        availQty.text = @"Available Qty :";
        availQty.font = [UIFont boldSystemFontOfSize:14];
        availQty.backgroundColor = [UIColor clearColor];
        availQty.textColor = [UIColor blackColor];
        [rejectQtyChangeDisplayView addSubview:availQty];
        
        UILabel *unitPrice = [[UILabel alloc] init];
        unitPrice.text = @"Unit Price       :";
        unitPrice.font = [UIFont boldSystemFontOfSize:14];
        unitPrice.backgroundColor = [UIColor clearColor];
        unitPrice.textColor = [UIColor blackColor];
        
        
        UILabel *availQtyData = [[UILabel alloc] init];
        availQtyData.text = [NSString stringWithFormat:@"%@",[temp objectAtIndex:4]];
        availQtyData.font = [UIFont boldSystemFontOfSize:14];
        availQtyData.backgroundColor = [UIColor clearColor];
        availQtyData.textColor = [UIColor blackColor];
        [rejectQtyChangeDisplayView addSubview:availQtyData];
        
        UILabel *unitPriceData = [[UILabel alloc] init];
        unitPriceData.text = [NSString stringWithFormat:@"%@",[temp objectAtIndex:1]];
        unitPriceData.font = [UIFont boldSystemFontOfSize:14];
        unitPriceData.backgroundColor = [UIColor clearColor];
        unitPriceData.textColor = [UIColor blackColor];
        
        
        rejecQtyField = [[UITextField alloc] init];
        rejecQtyField.borderStyle = UITextBorderStyleRoundedRect;
        rejecQtyField.textColor = [UIColor blackColor];
        rejecQtyField.placeholder = @"Enter Qty";
        //NumberKeyBoard hidden....
        UIToolbar* numberToolbar1 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar1.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar1.items = [NSArray arrayWithObjects:
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                                nil];
        [numberToolbar1 sizeToFit];
        rejecQtyField.keyboardType = UIKeyboardTypeNumberPad;
        rejecQtyField.inputAccessoryView = numberToolbar1;
        rejecQtyField.text = textField.text;
        rejecQtyField.font = [UIFont systemFontOfSize:17.0];
        rejecQtyField.backgroundColor = [UIColor whiteColor];
        rejecQtyField.autocorrectionType = UITextAutocorrectionTypeNo;
        //qtyFeild.keyboardType = UIKeyboardTypeDefault;
        rejecQtyField.clearButtonMode = UITextFieldViewModeWhileEditing;
        rejecQtyField.returnKeyType = UIReturnKeyDone;
        rejecQtyField.delegate = self;
        
        /** ok Button for qtyChangeDisplyView....*/
        okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //[okButton setImage:[UIImage imageNamed:@"OK.png"] forState:UIControlStateNormal];
        [okButton addTarget:self
                     action:@selector(rejecQtyOkButtonPressed:) forControlEvents:UIControlEventTouchDown];
        [okButton setTitle:@"OK" forState:UIControlStateNormal];
        okButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
        okButton.backgroundColor = [UIColor grayColor];
        
        /** CancelButton for qtyChangeDisplyView....*/
        qtyCancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //[qtyCancelButton setImage:[UIImage imageNamed:@"Cancel.png"] forState:UIControlStateNormal];
        [qtyCancelButton addTarget:self
                            action:@selector(rejecQtytyCancelButtonPressed:) forControlEvents:UIControlEventTouchDown];
        [qtyCancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
        qtyCancelButton.backgroundColor = [UIColor grayColor];
        
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
            
            
            rejecQtyField.frame = CGRectMake(110, 165, 150, 50);
            rejecQtyField.font = [UIFont systemFontOfSize:25.0];
            
            
            okButton.frame = CGRectMake(60, 220, 80, 50);
            okButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            
            
            //            qtyCancelButton.frame = CGRectMake(250, 220, 80, 50);
            //            qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            
            okButton.frame = CGRectMake(20, 235, 165, 45);
            okButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            okButton.layer.cornerRadius = 20.0f;
            
            qtyCancelButton.frame = CGRectMake(190, 235, 165, 45);
            qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            qtyCancelButton.layer.cornerRadius = 20.0f;
            
            
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
            
            qtyFeild.frame = CGRectMake(36, 107, 100, 30);
            qtyFeild.font = [UIFont systemFontOfSize:17.0];
            
            okButton.frame = CGRectMake(10, 150, 75, 30);
            okButton.layer.cornerRadius = 14.0f;
            okButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            
            qtyCancelButton.frame = CGRectMake(90, 150, 75, 30);
            qtyCancelButton.layer.cornerRadius = 14.0f;
            qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            
        }
        
        [rejectQtyChangeDisplayView addSubview:img];
        [rejectQtyChangeDisplayView addSubview:topbar];
        [rejectQtyChangeDisplayView addSubview:availQty];
        [rejectQtyChangeDisplayView addSubview:unitPrice];
        [rejectQtyChangeDisplayView addSubview:availQtyData];
        [rejectQtyChangeDisplayView addSubview:unitPriceData];
        [rejectQtyChangeDisplayView addSubview:rejecQtyField];
        [rejectQtyChangeDisplayView addSubview:okButton];
        [rejectQtyChangeDisplayView addSubview:qtyCancelButton];
        
        wareEditRejectMaterialTagid = textField.tag;
        
        [rejectQtyChangeDisplayView release];
        [topbar release];
        [availQty release];
        [unitPrice release];
        [availQtyData release];
        [unitPriceData release];
        [rejecQtyField release];
        
    }
    else {
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        [textField resignFirstResponder];
        cartTable.userInteractionEnabled = FALSE;
        location.userInteractionEnabled = FALSE;
        deliveredBy.userInteractionEnabled = FALSE;
        inspectedBy.userInteractionEnabled = FALSE;
        submitBtn.userInteractionEnabled = FALSE;
        cancelButton.userInteractionEnabled = FALSE;
        
        NSArray *temp = [rawMaterialDetails objectAtIndex:textField.tag];
        
        qtyChangeDisplyView = [[UIView alloc]init];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            qtyChangeDisplyView.frame = CGRectMake(200, 300, 375, 300);
        }
        else{
            qtyChangeDisplyView.frame = CGRectMake(75, 68, 175, 200);
        }
        qtyChangeDisplyView.layer.borderWidth = 1.0;
        qtyChangeDisplyView.layer.cornerRadius = 10.0;
        qtyChangeDisplyView.layer.masksToBounds = YES;
        qtyChangeDisplyView.layer.borderColor = [UIColor blackColor].CGColor;
        qtyChangeDisplyView.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
        [self.view addSubview:qtyChangeDisplyView];
        
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
        
        
        //        UILabel *availQty = [[UILabel alloc] init];
        //        availQty.text = @"Available Qty :";
        //        availQty.font = [UIFont boldSystemFontOfSize:14];
        //        availQty.backgroundColor = [UIColor clearColor];
        //        availQty.textColor = [UIColor blackColor];
        //        [qtyChangeDisplyView addSubview:availQty];
        
        UILabel *unitPrice = [[UILabel alloc] init];
        unitPrice.text = @"Unit Price       :";
        unitPrice.font = [UIFont boldSystemFontOfSize:14];
        unitPrice.backgroundColor = [UIColor clearColor];
        unitPrice.textColor = [UIColor blackColor];
        
        
        //        UILabel *availQtyData = [[UILabel alloc] init];
        //        availQtyData.text = [NSString stringWithFormat:@"%@",[temp objectAtIndex:3]];
        //        availQtyData.font = [UIFont boldSystemFontOfSize:14];
        //        availQtyData.backgroundColor = [UIColor clearColor];
        //        availQtyData.textColor = [UIColor blackColor];
        //        [qtyChangeDisplyView addSubview:availQtyData];
        
        UILabel *unitPriceData = [[UILabel alloc] init];
        unitPriceData.text = [NSString stringWithFormat:@"%.2f",[[temp objectAtIndex:2] floatValue]];
        unitPriceData.font = [UIFont boldSystemFontOfSize:14];
        unitPriceData.backgroundColor = [UIColor clearColor];
        unitPriceData.textColor = [UIColor blackColor];
        
        
        qtyFeild = [[UITextField alloc] init];
        qtyFeild.borderStyle = UITextBorderStyleRoundedRect;
        qtyFeild.textColor = [UIColor blackColor];
        qtyFeild.placeholder = @"Enter Qty";
        //NumberKeyBoard hidden....
        UIToolbar* numberToolbar1 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar1.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar1.items = [NSArray arrayWithObjects:
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                                nil];
        [numberToolbar1 sizeToFit];
        qtyFeild.keyboardType = UIKeyboardTypeNumberPad;
        qtyFeild.inputAccessoryView = numberToolbar1;
        qtyFeild.text = textField.text;
        qtyFeild.font = [UIFont systemFontOfSize:17.0];
        qtyFeild.backgroundColor = [UIColor whiteColor];
        qtyFeild.autocorrectionType = UITextAutocorrectionTypeNo;
        //qtyFeild.keyboardType = UIKeyboardTypeDefault;
        qtyFeild.clearButtonMode = UITextFieldViewModeWhileEditing;
        qtyFeild.returnKeyType = UIReturnKeyDone;
        qtyFeild.delegate = self;
        
        /** ok Button for qtyChangeDisplyView....*/
        okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //[okButton setImage:[UIImage imageNamed:@"OK.png"] forState:UIControlStateNormal];
        [okButton addTarget:self
                     action:@selector(okButtonPressed:) forControlEvents:UIControlEventTouchDown];
        [okButton setTitle:@"OK" forState:UIControlStateNormal];
        okButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
        okButton.backgroundColor = [UIColor grayColor];
        
        /** CancelButton for qtyChangeDisplyView....*/
        qtyCancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //[qtyCancelButton setImage:[UIImage imageNamed:@"Cancel.png"] forState:UIControlStateNormal];
        [qtyCancelButton addTarget:self
                            action:@selector(QtyCancelButtonPressed:) forControlEvents:UIControlEventTouchDown];
        [qtyCancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
        qtyCancelButton.backgroundColor = [UIColor grayColor];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            
            img.frame = CGRectMake(0, 0, 375, 50);
            topbar.frame = CGRectMake(80, 5, 375, 40);
            topbar.font = [UIFont boldSystemFontOfSize:25];
            
            
            //            availQty.frame = CGRectMake(10,60,200,40);
            //            availQty.font = [UIFont boldSystemFontOfSize:25];
            
            
            unitPrice.frame = CGRectMake(10,110,200,40);
            unitPrice.font = [UIFont boldSystemFontOfSize:25];
            
            
            //            availQtyData.frame = CGRectMake(200,60,250,40);
            //            availQtyData.font = [UIFont boldSystemFontOfSize:25];
            
            
            unitPriceData.frame = CGRectMake(200,110,2500,40);
            unitPriceData.font = [UIFont boldSystemFontOfSize:25];
            
            
            qtyFeild.frame = CGRectMake(110, 165, 150, 50);
            qtyFeild.font = [UIFont systemFontOfSize:25.0];
            
            
            okButton.frame = CGRectMake(60, 220, 80, 50);
            okButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            
            
            //            qtyCancelButton.frame = CGRectMake(250, 220, 80, 50);
            //            qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            
            okButton.frame = CGRectMake(20, 235, 165, 45);
            okButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            okButton.layer.cornerRadius = 20.0f;
            
            qtyCancelButton.frame = CGRectMake(190, 235, 165, 45);
            qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            qtyCancelButton.layer.cornerRadius = 20.0f;
            
            
        }
        else{
            
            img.frame = CGRectMake(0, 0, 175, 32);
            topbar.frame = CGRectMake(0, 0, 175, 30);
            topbar.font = [UIFont boldSystemFontOfSize:17];
            
            //            availQty.frame = CGRectMake(10,40,100,30);
            //            availQty.font = [UIFont boldSystemFontOfSize:14];
            
            unitPrice.frame = CGRectMake(10,70,100,30);
            unitPrice.font = [UIFont boldSystemFontOfSize:14];
            
            //            availQtyData.frame = CGRectMake(115,40,60,30);
            //            availQtyData.font = [UIFont boldSystemFontOfSize:14];
            
            unitPriceData.frame = CGRectMake(115,70,60,30);
            unitPriceData.font = [UIFont boldSystemFontOfSize:14];
            
            qtyFeild.frame = CGRectMake(36, 107, 100, 30);
            qtyFeild.font = [UIFont systemFontOfSize:17.0];
            
            okButton.frame = CGRectMake(10, 150, 75, 30);
            okButton.layer.cornerRadius = 14.0f;
            okButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            
            qtyCancelButton.frame = CGRectMake(90, 150, 75, 30);
            qtyCancelButton.layer.cornerRadius = 14.0f;
            qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            
        }
        
        [qtyChangeDisplyView addSubview:img];
        [qtyChangeDisplyView addSubview:topbar];
        //        [qtyChangeDisplyView addSubview:availQty];
        [qtyChangeDisplyView addSubview:unitPrice];
        //        [qtyChangeDisplyView addSubview:availQtyData];
        [qtyChangeDisplyView addSubview:unitPriceData];
        [qtyChangeDisplyView addSubview:qtyFeild];
        [qtyChangeDisplyView addSubview:okButton];
        [qtyChangeDisplyView addSubview:qtyCancelButton];
        
        wareEditMaterialTagid = textField.tag;
        
        [qtyChangeDisplyView release];
        [topbar release];
        //        [availQty release];
        [unitPrice release];
        //        [availQtyData release];
        [unitPriceData release];
        [qtyFeild release];
        
    }
    
}

-(void)getListOfLocations:(id)sender {
    
    if (sender == selectLocation) {
        
        [selectLocation setEnabled:NO];
        
        [cartTable setUserInteractionEnabled:NO];
        [fromLocation resignFirstResponder];
        
        [self getLocations:wareEditstockStartIndex];
        
        // [waiterName resignFirstResponder];
        locationTable.hidden = NO;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            locationTable.frame = CGRectMake(10.0, 60.0, 360, 220);
        }
        [self.view bringSubviewToFront:locationTable];
        
    }
    
}

/**
 @method : getLocations
 @discription : calls the service method to get the list of from locations
 
 */


-(void)getLocations:(int)startIndex {
    
    locationArr = [[NSMutableArray alloc] init];
    
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
        NSDictionary *JSON1;
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
        
        NSDictionary *responseHeader = [JSON1 valueForKey:@"responseHeader"];
        
        if ([[responseHeader valueForKey:@"responseCode"] isEqualToString:@"0"] && [[responseHeader valueForKey:@"responseMessage"] isEqualToString:@"Location Details"]) {
            
            NSArray *locations = [JSON1 valueForKey:@"locationDetails"];
            
            for (int i=0; i < [locations count]; i++) {
                
                NSDictionary *location_ = [locations objectAtIndex:i];
                
                [locationArr addObject:[location_ valueForKey:@"locationId"]];
                
            }
            if ([locationArr containsObject:presentLocation]) {
                
                [locationArr removeObject:presentLocation];
            }
            [locationTable reloadData];
            
        }
        else {
            
            //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Failed to get the locations" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            //            [alert show];
            
            wareEditstockScrollValueStatus_ = YES;
            
        }
        
    }
    @catch (NSException *exception) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Failed to get the locations" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
}


- (IBAction)okButtonPressed:(id)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    cartTable.userInteractionEnabled = TRUE;
    location.userInteractionEnabled = TRUE;
    deliveredBy.userInteractionEnabled = TRUE;
    inspectedBy.userInteractionEnabled = TRUE;
    submitBtn.userInteractionEnabled = TRUE;
    cancelButton.userInteractionEnabled = TRUE;
    
    NSString *value = [qtyFeild.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // PhoNumber validation...
    NSString *decimalRegex = @"[0-9]+([.]([0-9]+)?)?"; // @"[0-9]+[.][0-9]+";
    NSPredicate *decimalTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalRegex];
    BOOL isNumber = [decimalTest evaluateWithObject:[qtyFeild text]];
    int qty = [value intValue];
    
    NSArray *temp = [rawMaterialDetails objectAtIndex:wareEditMaterialTagid];
    
    //    if (qty > [[temp objectAtIndex:7] intValue]){
    //
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Quantity Should be Less than or Equal to  Available Quantity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //        [alert show];
    //        [alert release];
    //
    //        qtyFeild.text = nil;
    //    }
    if([value length] == 0 || !isNumber){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Quantity in Number." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        qtyFeild.text = NO;
    }
    else if([qtyFeild.text isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Valid Quantity." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        qtyFeild.text = nil;
    }
    else{
        // int received = qty - [[temp objectAtIndex:5] intValue];
        
        NSArray *finalArray = [NSArray arrayWithObjects:[temp objectAtIndex:0],[temp objectAtIndex:1],[temp objectAtIndex:2],[NSString stringWithFormat:@"%d",qty],[NSString stringWithFormat:@"%d", qty],[NSString stringWithFormat:@"%d",qty],[NSString stringWithFormat:@"%d",qty],[temp objectAtIndex:7],[temp objectAtIndex:8], nil];
        
        [rawMaterialDetails replaceObjectAtIndex:wareEditMaterialTagid withObject:finalArray];
        
        [cartTable reloadData];
        
        qtyChangeDisplyView.hidden = YES;
        cartTable.userInteractionEnabled = TRUE;
        
        wareEditQuantity = 0;
        wareEditMaterialCost = 0.0f;
        
        for (int i = 0; i < [rawMaterialDetails count]; i++) {
            NSArray *material = [rawMaterialDetails objectAtIndex:i];
            wareEditQuantity = wareEditQuantity + [[material objectAtIndex:6] intValue];
            wareEditMaterialCost = wareEditMaterialCost + ([[material objectAtIndex:6] intValue] * [[material objectAtIndex:2] floatValue]);
        }
        
        totalQunatity.text = [NSString stringWithFormat:@"%d",wareEditQuantity];
        totalCost.text = [NSString stringWithFormat:@"%.2f",wareEditMaterialCost];
    }
}

- (IBAction)QtyCancelButtonPressed:(id)sender {
    
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    qtyChangeDisplyView.hidden = YES;
    cartTable.userInteractionEnabled = TRUE;
    location.userInteractionEnabled = TRUE;
    deliveredBy.userInteractionEnabled = TRUE;
    inspectedBy.userInteractionEnabled = TRUE;
    submitBtn.userInteractionEnabled = TRUE;
    cancelButton.userInteractionEnabled = TRUE;
}

- (void)rejecQtyOkButtonPressed:(id)sender{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    cartTable.userInteractionEnabled = TRUE;
    location.userInteractionEnabled = TRUE;
    deliveredBy.userInteractionEnabled = TRUE;
    inspectedBy.userInteractionEnabled = TRUE;
    submitBtn.userInteractionEnabled = TRUE;
    cancelButton.userInteractionEnabled = TRUE;
    
    NSString *value = [rejecQtyField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // PhoNumber validation...
    NSString *decimalRegex = @"[0-9]+([.]([0-9]+)?)?"; // @"[0-9]+[.][0-9]+";
    NSPredicate *decimalTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalRegex];
    BOOL isNumber = [decimalTest evaluateWithObject:[rejecQtyField text]];
    int qty = [value intValue];
    
    NSArray *temp = [rawMaterialDetails objectAtIndex:wareEditRejectMaterialTagid];
    
    if (qty > [[temp objectAtIndex:3] intValue]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Quantity Should be Less than or Equal to  Available Quantity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        rejecQtyField.text = nil;
    }
    else if([value length] == 0 || !isNumber){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Quantity in Number." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        rejecQtyField.text = NO;
    }
    //    else if([rejecQtyField.text isEqualToString:@"0"]){
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Valid Quantity." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //        [alert show];
    //        [alert release];
    //
    //        rejecQtyField.text = nil;
    //    }
    else{
        
        int received = [[temp objectAtIndex:6] intValue] - qty;
        
        NSArray *finalArray = [NSArray arrayWithObjects:[temp objectAtIndex:0],[temp objectAtIndex:1],[temp objectAtIndex:2],[temp objectAtIndex:3],[temp objectAtIndex:4],[temp objectAtIndex:5],[NSString stringWithFormat:@"%d",received],[NSString stringWithFormat:@"%d",qty],[NSString stringWithFormat:@"%.2f",(received * [[temp objectAtIndex:2]floatValue])], nil];
        
        [rawMaterialDetails replaceObjectAtIndex:wareEditRejectMaterialTagid withObject:finalArray];
        
        [cartTable reloadData];
        
        rejectQtyChangeDisplayView.hidden = YES;
        cartTable.userInteractionEnabled = TRUE;
        
        wareEditQuantity = 0;
        wareEditMaterialCost = 0.0f;
        
        for (int i = 0; i < [rawMaterialDetails count]; i++) {
            NSArray *material = [rawMaterialDetails objectAtIndex:i];
            wareEditQuantity = wareEditQuantity + [[material objectAtIndex:6] intValue];
            wareEditMaterialCost = wareEditMaterialCost + ([[material objectAtIndex:6] intValue] * [[material objectAtIndex:2] floatValue]);
        }
        
        totalQunatity.text = [NSString stringWithFormat:@"%d",wareEditQuantity];
        totalCost.text = [NSString stringWithFormat:@"%.2f",wareEditMaterialCost];
    }
    
}

-(void) rejecQtytyCancelButtonPressed:(id)sender{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    rejectQtyChangeDisplayView.hidden = YES;
    cartTable.userInteractionEnabled = TRUE;
    location.userInteractionEnabled = TRUE;
    deliveredBy.userInteractionEnabled = TRUE;
    inspectedBy.userInteractionEnabled = TRUE;
    submitBtn.userInteractionEnabled = TRUE;
    cancelButton.userInteractionEnabled = TRUE;
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
        else if (tableView == fromLocation){
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
        
        else {
            return 28.0;
        }
    }
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == cartTable) {
        return [rawMaterialDetails count];
    }
    else if (tableView == fromLocation){
        return [fromLocationDetails count];
    }
    else if (tableView == locationTable) {
        
        return [locationArr count];
    }
    else {
        return [rawMaterials count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == cartTable) {
        
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
        
        UILabel *skid = [[[UILabel alloc] init] autorelease];
        skid.layer.borderWidth = 1.5;
        skid.font = [UIFont systemFontOfSize:13.0];
        skid.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        skid.backgroundColor = [UIColor blackColor];
        skid.textColor = [UIColor whiteColor];
        
        skid.text = [temp objectAtIndex:1];
        skid.textAlignment=NSTextAlignmentCenter;
        skid.adjustsFontSizeToFitWidth = YES;
        //name.adjustsFontSizeToFitWidth = YES;
        
        UILabel *price = [[[UILabel alloc] init] autorelease];
        price.layer.borderWidth = 1.5;
        price.font = [UIFont systemFontOfSize:13.0];
        price.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        price.backgroundColor = [UIColor blackColor];
        price.text = [NSString stringWithFormat:@"%@",[temp objectAtIndex:2]];
        price.textColor = [UIColor whiteColor];
        price.textAlignment=NSTextAlignmentCenter;
        price.adjustsFontSizeToFitWidth = YES;
        
        
        qty1 = [[[UITextField alloc] init] autorelease];
        qty1.textAlignment = NSTextAlignmentCenter;
        qty1.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        qty1.layer.borderWidth = 1.5;
        qty1.font = [UIFont systemFontOfSize:13.0];
        qty1.frame = CGRectMake(176, 0, 58, 34);
        qty1.backgroundColor = [UIColor blackColor];
        qty1.text = [NSString stringWithFormat:@"%d",[[temp objectAtIndex:3] intValue]];
        qty1.textColor = [UIColor whiteColor];
        [qty1 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingDidBegin];
        qty1.tag = indexPath.row;
        qty1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        qty1.adjustsFontSizeToFitWidth = YES;
        qty1.delegate = self;
        [qty1 resignFirstResponder];
        
        
        UILabel *total = [[[UILabel alloc] init] autorelease];
        total.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        total.layer.borderWidth = 1.5;
        total.font = [UIFont systemFontOfSize:13.0];
        total.backgroundColor = [UIColor blackColor];
        total.text = [NSString stringWithFormat:@"%.02f", [[temp objectAtIndex:2] floatValue] * [[temp objectAtIndex:6] intValue]];
        // total.text = [NSString stringWithFormat:@"%.2f",[[temp objectAtIndex:8] floatValue]];
        total.textColor = [UIColor whiteColor];
        total.textAlignment=NSTextAlignmentCenter;
        total.adjustsFontSizeToFitWidth = YES;
        
        UILabel *supplied = [[[UILabel alloc] init] autorelease];
        supplied.layer.borderWidth = 1.5;
        supplied.font = [UIFont systemFontOfSize:13.0];
        supplied.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        supplied.backgroundColor = [UIColor blackColor];
        supplied.textColor = [UIColor whiteColor];
        
        supplied.text = [NSString stringWithFormat:@"%d",[[temp objectAtIndex:5] intValue]];
        supplied.textAlignment=NSTextAlignmentCenter;
        supplied.adjustsFontSizeToFitWidth = YES;
        
        UILabel *received = [[[UILabel alloc] init] autorelease];
        received.layer.borderWidth = 1.5;
        received.font = [UIFont systemFontOfSize:13.0];
        received.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        received.backgroundColor = [UIColor blackColor];
        received.textColor = [UIColor whiteColor];
        
        received.text = [NSString stringWithFormat:@"%d",[[temp objectAtIndex:6] intValue]];
        received.textAlignment=NSTextAlignmentCenter;
        received.adjustsFontSizeToFitWidth = YES;
        
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
        
        UIButton *rejectQtyButton = [[[UIButton alloc] init] autorelease];
        [rejectQtyButton setTitle:[NSString stringWithFormat:@"%d",[[temp objectAtIndex:7] intValue]] forState:UIControlStateNormal];
        rejectQtyButton.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        rejectQtyButton.layer.borderWidth = 1.5;
        [rejectQtyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rejectQtyButton addTarget:self action:@selector(changeQuantity:) forControlEvents:UIControlEventTouchUpInside];
        rejectQtyButton.layer.masksToBounds = YES;
        rejectQtyButton.tag = indexPath.row;
        
        UIButton *delrowbtn = [[[UIButton alloc] init] autorelease];
        [delrowbtn setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
        [delrowbtn addTarget:self action:@selector(delRow:) forControlEvents:UIControlEventTouchUpInside];
        delrowbtn.tag = indexPath.row;
        delrowbtn.backgroundColor = [UIColor clearColor];
        
        
        
        
        [hlcell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            //skid.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:22];
            skid.font = [UIFont fontWithName:@"Helvetica" size:22];
            skid.frame = CGRectMake(10, 0, 100, 56);
            price.font = [UIFont fontWithName:@"Helvetica" size:25];
            price.frame = CGRectMake(110, 0, 100, 56);
            qty1.font = [UIFont fontWithName:@"Helvetica" size:25];
            qty1.frame = CGRectMake(210, 0, 90, 56);
            total.font = [UIFont fontWithName:@"Helvetica" size:25];
            total.frame = CGRectMake(300, 0, 120, 56);
            //supplied.font = [UIFont fontWithName:@"Helvetica" size:25];
            // supplied.frame = CGRectMake(371.0, 0, 110, 56);
            received.font = [UIFont fontWithName:@"Helvetica" size:25];
            received.frame = CGRectMake(420, 0, 110, 56);
            rejectQtyButton.frame = CGRectMake(530.0, 0, 110, 56);
            delrowbtn.frame = CGRectMake(650.0, 10 , 40, 40);
            
        }
        else {
            
            
            skid.font = [UIFont fontWithName:@"ArialRoundedMT" size:15];
            skid.frame = CGRectMake(0, 0, 60, 30);
            price.font = [UIFont fontWithName:@"ArialRoundedMT" size:15];
            price.frame = CGRectMake(60, 0, 60, 30);
            qty1.font = [UIFont fontWithName:@"ArialRoundedMT" size:15];
            qty1.frame = CGRectMake(120, 0, 50, 30);
            total.frame = CGRectMake(170, 0, 70, 30);
            total.font = [UIFont fontWithName:@"ArialRoundedMT" size:15];
            received.font = [UIFont fontWithName:@"ArialRoundedMT" size:15];
            received.frame = CGRectMake(240, 0, 60, 30);
            //            supplied.font = [UIFont fontWithName:@"Helvetica" size:25];
            //            supplied.frame = CGRectMake(484, 0, 110, 56);
            rejectQtyButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMT" size:15];
            rejectQtyButton.frame = CGRectMake(300, 0, 60, 30);
            //            received.font = [UIFont fontWithName:@"Helvetica" size:25];
            //            received.frame = CGRectMake(710.0, 0, 110, 56);
            // rejectQtyButton.frame = CGRectMake(350.0, 0, 60, 30);
            delrowbtn.frame = CGRectMake(365.0, 2 , 30, 30);
            
            
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
        [hlcell.contentView addSubview:skid];
        [hlcell.contentView addSubview:price];
        [hlcell.contentView addSubview:qty1];
        [hlcell.contentView addSubview:total];
        //        [hlcell .contentView addSubview:supplied];
        [hlcell.contentView addSubview:received];
        [hlcell.contentView addSubview:rejectQtyButton];
        [hlcell addSubview:delrowbtn];
        //
        return hlcell;
        
    }
    else if (tableView == fromLocation) {
        
        tableView.separatorColor = [UIColor blackColor];
        
        static NSString *hlCellID = @"hlCellID";
        
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
        if(hlcell == nil) {
            hlcell =  [[[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID] autorelease];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
        }
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            hlcell.textLabel.font = [UIFont fontWithName:@"ArialRoundedMT" size:25];
        }
        else{
            hlcell.textLabel.font = [UIFont fontWithName:@"ArialRoundedMT" size:15];
        }
        hlcell.backgroundColor = [UIColor whiteColor];
        hlcell.textLabel.text = [fromLocationDetails objectAtIndex:indexPath.row];
        
        return hlcell;
        
    }
    else if (tableView == locationTable) {
        
        tableView.separatorColor = [UIColor blackColor];
        
        static NSString *hlCellID = @"hlCellID";
        
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
        if(hlcell == nil) {
            hlcell =  [[[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID] autorelease];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
        }
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            hlcell.textLabel.font = [UIFont fontWithName:@"ArialRoundedMT" size:25];
        }
        else{
            hlcell.textLabel.font = [UIFont fontWithName:@"ArialRoundedMT" size:15];
        }
        hlcell.textLabel.text = [locationArr objectAtIndex:indexPath.row];
        //[hlcell setBackgroundColor:[UIColor blackColor]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        [hlcell setSelectionStyle:UITableViewCellEditingStyleNone];
        
        return hlcell;
        
    }
    else {
        static NSString *hlCellID = @"hlCellID";
        
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
        if(hlcell == nil) {
            hlcell =  [[[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID] autorelease];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:20];
            }
        }
        
        NSDictionary *JSON = [rawMaterials objectAtIndex:indexPath.row];
        hlcell.textLabel.text = [NSString stringWithFormat:@"%@",[JSON objectForKey:@"skuId"]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        return hlcell;
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
        BillField.text = @"";
        [BillField resignFirstResponder];
        skListTable.hidden = YES;
        
        
        NSDictionary *skuId = [rawMaterials objectAtIndex:indexPath.row];
        
        [self callRawMaterialDetails:[NSString stringWithFormat:@"%@",[skuId objectForKey:@"skuId"]]];
        
    }
    else if (tableView == fromLocation){
        fromLocation.hidden = YES;
        fromLocationTxt.text = [fromLocationDetails objectAtIndex:indexPath.row];
    }
    else if (tableView == locationTable) {
        
        location.text = @"";
        [fromLocation resignFirstResponder];
        locationTable.hidden = YES;
        location.text = [locationArr objectAtIndex:indexPath.row];
        [cartTable setUserInteractionEnabled:YES];
        [selectLocation setEnabled:YES];
        [submitBtn setEnabled:YES];
        [cancelButton setEnabled:YES];
        
    }
}

-(void)changeQuantity:(UIButton *)sender{
    //Play Audio for button touch....
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
        
        rejectQtyChangeDisplayView.frame = CGRectMake(200, 300, 375, 300);
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
    
    
    UILabel *availQty = [[UILabel alloc] init];
    availQty.text = @"Available Qty :";
    availQty.font = [UIFont boldSystemFontOfSize:14];
    availQty.backgroundColor = [UIColor clearColor];
    availQty.textColor = [UIColor blackColor];
    [rejectQtyChangeDisplayView addSubview:availQty];
    
    UILabel *unitPrice = [[UILabel alloc] init];
    unitPrice.text = @"Unit Price       :";
    unitPrice.font = [UIFont boldSystemFontOfSize:14];
    unitPrice.backgroundColor = [UIColor clearColor];
    unitPrice.textColor = [UIColor blackColor];
    
    
    UILabel *availQtyData = [[UILabel alloc] init];
    availQtyData.text = [NSString stringWithFormat:@"%@",[temp objectAtIndex:3]];
    availQtyData.font = [UIFont boldSystemFontOfSize:14];
    availQtyData.backgroundColor = [UIColor clearColor];
    availQtyData.textColor = [UIColor blackColor];
    [rejectQtyChangeDisplayView addSubview:availQtyData];
    
    UILabel *unitPriceData = [[UILabel alloc] init];
    unitPriceData.text = [NSString stringWithFormat:@"%@",[temp objectAtIndex:2]];
    unitPriceData.font = [UIFont boldSystemFontOfSize:14];
    unitPriceData.backgroundColor = [UIColor clearColor];
    unitPriceData.textColor = [UIColor blackColor];
    
    
    rejecQtyField = [[UITextField alloc] init];
    rejecQtyField.borderStyle = UITextBorderStyleRoundedRect;
    rejecQtyField.textColor = [UIColor blackColor];
    rejecQtyField.placeholder = @"Enter Qty";
    //NumberKeyBoard hidden....
    UIToolbar* numberToolbar1 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar1.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar1.items = [NSArray arrayWithObjects:
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                            nil];
    [numberToolbar1 sizeToFit];
    rejecQtyField.keyboardType = UIKeyboardTypeNumberPad;
    rejecQtyField.inputAccessoryView = numberToolbar1;
    rejecQtyField.font = [UIFont systemFontOfSize:17.0];
    rejecQtyField.backgroundColor = [UIColor whiteColor];
    rejecQtyField.autocorrectionType = UITextAutocorrectionTypeNo;
    //qtyFeild.keyboardType = UIKeyboardTypeDefault;
    rejecQtyField.clearButtonMode = UITextFieldViewModeWhileEditing;
    rejecQtyField.returnKeyType = UIReturnKeyDone;
    rejecQtyField.delegate = self;
    
    /** ok Button for qtyChangeDisplyView....*/
    okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //[okButton setImage:[UIImage imageNamed:@"OK.png"] forState:UIControlStateNormal];
    [okButton addTarget:self
                 action:@selector(rejecQtyOkButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [okButton setTitle:@"OK" forState:UIControlStateNormal];
    okButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
    okButton.backgroundColor = [UIColor grayColor];
    
    /** CancelButton for qtyChangeDisplyView....*/
    qtyCancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //[qtyCancelButton setImage:[UIImage imageNamed:@"Cancel.png"] forState:UIControlStateNormal];
    [qtyCancelButton addTarget:self
                        action:@selector(rejecQtytyCancelButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [qtyCancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
    qtyCancelButton.backgroundColor = [UIColor grayColor];
    
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
        
        
        rejecQtyField.frame = CGRectMake(110, 165, 150, 50);
        rejecQtyField.font = [UIFont systemFontOfSize:25.0];
        
        
        okButton.frame = CGRectMake(60, 220, 80, 50);
        okButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        
        //            qtyCancelButton.frame = CGRectMake(250, 220, 80, 50);
        //            qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        okButton.frame = CGRectMake(20, 235, 165, 45);
        okButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        okButton.layer.cornerRadius = 20.0f;
        
        qtyCancelButton.frame = CGRectMake(190, 235, 165, 45);
        qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        qtyCancelButton.layer.cornerRadius = 20.0f;
        
        
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
        
        qtyFeild.frame = CGRectMake(36, 107, 100, 30);
        qtyFeild.font = [UIFont systemFontOfSize:17.0];
        
        okButton.frame = CGRectMake(10, 150, 75, 30);
        okButton.layer.cornerRadius = 14.0f;
        okButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
        qtyCancelButton.frame = CGRectMake(90, 150, 75, 30);
        qtyCancelButton.layer.cornerRadius = 14.0f;
        qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
    }
    
    [rejectQtyChangeDisplayView addSubview:img];
    [rejectQtyChangeDisplayView addSubview:topbar];
    [rejectQtyChangeDisplayView addSubview:availQty];
    [rejectQtyChangeDisplayView addSubview:unitPrice];
    [rejectQtyChangeDisplayView addSubview:availQtyData];
    [rejectQtyChangeDisplayView addSubview:unitPriceData];
    [rejectQtyChangeDisplayView addSubview:rejecQtyField];
    [rejectQtyChangeDisplayView addSubview:okButton];
    [rejectQtyChangeDisplayView addSubview:qtyCancelButton];
    
    wareEditRejectMaterialTagid = sender.tag;
    
    [rejectQtyChangeDisplayView release];
    [topbar release];
    [availQty release];
    [unitPrice release];
    [availQtyData release];
    [unitPriceData release];
    [rejecQtyField release];
}

- (void) delRow:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    [rawMaterialDetails removeObjectAtIndex:[sender tag]];
    
    wareEditQuantity = 0;
    wareEditMaterialCost = 0.0f;
    
    for (int i = 0; i < [rawMaterialDetails count]; i++) {
        NSArray *material = [rawMaterialDetails objectAtIndex:i];
        wareEditQuantity = wareEditQuantity + [[material objectAtIndex:4] intValue];
        wareEditMaterialCost = wareEditMaterialCost + ([[material objectAtIndex:4] intValue] * [[material objectAtIndex:1] floatValue]);
    }
    
    totalQunatity.text = [NSString stringWithFormat:@"%d",wareEditQuantity];
    totalCost.text = [NSString stringWithFormat:@"%.2f",wareEditMaterialCost];
    
    [cartTable reloadData];
}

-(void)submitButtonPressed{
    AudioServicesPlaySystemSound (soundFileObject);
    NSString *locationValue = [location.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *deliveredByValue = [deliveredBy.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //  NSString *poreferenceValue = [poReference.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //  NSString *shipmentValue = [shipmentNote.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *inspectedValue = [inspectedBy.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([rawMaterialDetails count] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please select add items to cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
        HUD_.labelText = @"Updating Receipt..";
        // getting present date & time ..
    //    NSDate *today = [NSDate date];
        NSDateFormatter *f = [[NSDateFormatter alloc] init];
        [f setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
      //  NSString* currentdate = [f stringFromDate:today];
        [f release];
        NSMutableArray *item = [[NSMutableArray alloc] init];
        NSMutableArray *desc = [[NSMutableArray alloc] init];
        NSMutableArray *qty = [[NSMutableArray alloc] init];
        NSMutableArray *max_qty = [[NSMutableArray alloc] init];
        NSMutableArray *price = [[NSMutableArray alloc] init];
        NSMutableArray *cost = [[NSMutableArray alloc] init];
        NSMutableArray *issued = [[NSMutableArray alloc] init];
        NSMutableArray *rejected = [[NSMutableArray alloc] init];
        NSMutableArray *received = [[NSMutableArray alloc] init];
        for (int i = 0; i < [rawMaterialDetails count]; i++) {
            NSArray *temp = [rawMaterialDetails objectAtIndex:i];
            [item addObject:[temp objectAtIndex:0]];
            [desc addObject:[temp objectAtIndex:1]];
            [qty addObject:[temp objectAtIndex:3]];
            [max_qty addObject:[temp objectAtIndex:3]];
            [price addObject:[temp objectAtIndex:2]];
            [cost addObject:[NSString stringWithFormat:@"%.02f", [[temp objectAtIndex:2] floatValue] * [[temp objectAtIndex:3] intValue]]];
            [issued addObject:[temp objectAtIndex:5]];
            [rejected addObject:[temp objectAtIndex:7]];
            [received addObject:[temp objectAtIndex:6]];
        }
        
        NSLog(@"%@",location.text);
        
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
        [receiptDetails1 setObject:[NSString stringWithFormat:@"%d",ware_receipt_id_val] forKey:@"id_goods_receipt"];
        [receiptDetails1 setObject:totalCost.text forKey:@"receipt_total"];
        [receiptDetails1 setObject:totalQunatity.text forKey:@"receipt_total_qty"];
        [receiptDetails1 setObject:@"technolabs" forKey:@"Received_by"];
        [receiptDetails1 setObject:inspectedBy.text forKey:@"InspectedBy"];
        [receiptDetails1 setObject:totalCost.text forKey:@"grand_total"];
        [receiptDetails1 setObject:totalCost.text forKey:@"sub_total"];
        [receiptDetails1 setObject:wareEditFinalReceiptID forKey:@"goods_receipt_ref_num"];
        [receiptDetails1 setObject:@"true" forKey:@"status"];
        
        for (int i=0; i < [item count]; i++) {
            
            [temp setObject:[item objectAtIndex:i] forKey:@"item"];
            [temp setObject:[desc objectAtIndex:i] forKey:@"description"];
            [temp setObject:[price objectAtIndex:i] forKey:@"price"];
            [temp setObject:[max_qty objectAtIndex:i] forKey:@"max_quantity"];
            [temp setObject:[qty objectAtIndex:i] forKey:@"quantity"];
            [temp setObject:[cost objectAtIndex:i] forKey:@"cost"];
            [temp setObject:[issued objectAtIndex:i] forKey:@"issued"];
            [temp setObject:[received objectAtIndex:i] forKey:@"recieved"];
            [temp setObject:[rejected objectAtIndex:i] forKey:@"rejected"];
            
            
            dic = [temp copy];
            
            [temp1 setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
            
            [temparr addObject:[temp1 valueForKey:[NSString stringWithFormat:@"%d",i]]];
            
        }
        
        [receiptDetails1 setObject:temparr forKey:@"reciptDetails"];
        
        //        NSArray *keys = [NSArray arrayWithObjects:@"receipt_id",@"from_location", @"date",@"item",@"description",@"quantity",@"max_quantity",@"price",@"cost",@"issued",@"rejected",@"received",@"status", nil];
        //
        //        NSArray *objects = [NSArray arrayWithObjects:editFinalReceiptID,fromLocationTxt.text, currentdate,item,desc,qty,max_qty,price,cost,issued,rejected, received,@"true", nil];
        //        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:receiptDetails1 options:0 error:&err];
        NSString * createReceiptJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        ////        StockReceiptServiceSoapBinding *materialBinding = [[StockReceiptServiceSvc StockReceiptServiceSoapBinding] retain];
        //        tns1_updateStockReciept *aparams = [[tns1_updateStockReciept alloc] init];
        //        aparams.stockRecieptDetails = createReceiptJsonString;
        //
        //        StockReceiptServiceSoapBindingResponse *response = [materialBinding updateStockRecieptUsingParameters:(tns1_updateStockReciept *)aparams];
        //        NSArray *responseBodyParts = response.bodyParts;
        
        //        for (id bodyPart in responseBodyParts) {
        //            if ([bodyPart isKindOfClass:[tns1_updateStockRecieptResponse class]]) {
        //                tns1_updateStockRecieptResponse *body = (tns1_updateStockRecieptResponse *)bodyPart;
        //                printf("\nresponse=%s",[body.return_ UTF8String]);
        //
        //                if (body.return_ != NULL) {
        //                    NSError *e;
        //                    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
        //                                                                         options: NSJSONReadingMutableContainers
        //                                                                           error: &e];
        //                    NSString *receiptID = [JSON objectForKey:@"receipt_id"];
        //                    editReceipt = [receiptID copy];
        //                    UIAlertView *successAlertView  = [[UIAlertView alloc] init];
        //                    [successAlertView setDelegate:self];
        //                    [successAlertView setTitle:@"Stock Receipt Updated Successfully"];
        //                    [successAlertView setMessage:[NSString stringWithFormat:@"%@%@",@"Receipt ID : ",receiptID]];
        //                    [successAlertView addButtonWithTitle:@"OPEN RECEIPT"];
        //                    [successAlertView addButtonWithTitle:@"NEW RECEIPT"];
        //
        //                    [successAlertView show];
        //                }
        //            }
        //        }
        
        WHStockReceiptServiceSoapBinding *materialBinding = [[WHStockReceiptService WHStockReceiptServiceSoapBinding] retain];
        
        materialBinding.logXMLInOut = YES;
        
        WHStockReceiptService_updateStockReciept *update_receipt = [[WHStockReceiptService_updateStockReciept alloc] init];
        update_receipt.stockRecieptDetails = createReceiptJsonString;
        
        WHStockReceiptServiceSoapBindingResponse *response = [materialBinding updateStockRecieptUsingParameters:update_receipt];
        NSArray *responseBodyParts1 = response.bodyParts;
        
        NSDictionary *JSON_ ;
        
        for (id bodyPart in responseBodyParts1) {
            
            if ([bodyPart isKindOfClass:[WHStockReceiptService_updateStockRecieptResponse class]]) {
                
                
                // [HUD_ setHidden:YES];
                WHStockReceiptService_updateStockRecieptResponse *body = (WHStockReceiptService_updateStockRecieptResponse *)bodyPart;
                printf("\nresponse=%s",[body.return_ UTF8String]);
                
                // status = body.return_;
                NSError *e;
                NSDictionary *json1;
                
                json1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                        options: NSJSONReadingMutableContainers
                                                          error: &e];
                
                if (json1!=NULL) {
                    
                    JSON_ = [json1 objectForKey:@"responseHeader"];
                    if ([[JSON_ objectForKey:@"responseMessage"] isEqualToString:@"Success"]) {
                        
                        NSString *receiptID = [json1 objectForKey:@"receiptid"];
                        wareEditReceipt = [receiptID copy];
                        UIAlertView *successAlertView  = [[UIAlertView alloc] init];
                        [successAlertView setDelegate:self];
                        [successAlertView setTitle:@"Stock Receipt Updated Successfully"];
                        [successAlertView setMessage:[NSString stringWithFormat:@"%@%@",@"Receipt ID : ",receiptID]];
                        [successAlertView addButtonWithTitle:@"OPEN RECEIPT"];
                        [successAlertView addButtonWithTitle:@"NEW RECEIPT"];
                        
                        [successAlertView show];
                        
                        //  [HUD_ setHidden:YES];
                        // [HUD_ release];
                        
                        
                    }
                    
                }
                else{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed to Update Receipt" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                }
            }
        }
        
        
        [HUD_ setHidden:YES];
        location.text = @"";
        deliveredBy.text = @"";
        inspectedBy.text = @"";
        
        [rawMaterials removeAllObjects];
        [rawMaterialDetails removeAllObjects];
        [cartTable reloadData];
        totalCost.text = @"0.0";
        totalQunatity.text = @"0";
        
    }
}

-(void)cancelButtonPressed{
    AudioServicesPlaySystemSound (soundFileObject);
    if ([rawMaterialDetails count] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please select add items to cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
        // getting present date & time ..
        NSDate *today = [NSDate date];
        NSDateFormatter *f = [[NSDateFormatter alloc] init];
        [f setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        NSString* currentdate = [f stringFromDate:today];
        [f release];
        NSMutableArray *item = [[NSMutableArray alloc] init];
        NSMutableArray *desc = [[NSMutableArray alloc] init];
        NSMutableArray *qty = [[NSMutableArray alloc] init];
        NSMutableArray *max_qty = [[NSMutableArray alloc] init];
        NSMutableArray *price = [[NSMutableArray alloc] init];
        NSMutableArray *cost = [[NSMutableArray alloc] init];
        NSMutableArray *issued = [[NSMutableArray alloc] init];
        NSMutableArray *rejected = [[NSMutableArray alloc] init];
        NSMutableArray *received = [[NSMutableArray alloc] init];
        for (int i = 0; i < [rawMaterialDetails count]; i++) {
            NSArray *temp = [rawMaterialDetails objectAtIndex:i];
            [item addObject:[temp objectAtIndex:0]];
            [desc addObject:[temp objectAtIndex:1]];
            [qty addObject:[temp objectAtIndex:3]];
            [max_qty addObject:[temp objectAtIndex:3]];
            [price addObject:[temp objectAtIndex:2]];
            [cost addObject:[NSString stringWithFormat:@"%.02f", [[temp objectAtIndex:2] floatValue] * [[temp objectAtIndex:3] intValue]]];
            [issued addObject:[temp objectAtIndex:5]];
            [rejected addObject:[temp objectAtIndex:7]];
            [received addObject:[temp objectAtIndex:6]];
        }
        
        NSLog(@"%@",location.text);
        
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
        [receiptDetails1 setObject:[NSString stringWithFormat:@"%d",ware_receipt_id_val] forKey:@"id_goods_receipt"];
        [receiptDetails1 setObject:totalCost.text forKey:@"receipt_total"];
        [receiptDetails1 setObject:totalQunatity.text forKey:@"receipt_total_qty"];
        [receiptDetails1 setObject:@"technolabs" forKey:@"Received_by"];
        [receiptDetails1 setObject:inspectedBy.text forKey:@"InspectedBy"];
        [receiptDetails1 setObject:totalCost.text forKey:@"grand_total"];
        [receiptDetails1 setObject:totalCost.text forKey:@"sub_total"];
        [receiptDetails1 setObject:wareEditFinalReceiptID forKey:@"goods_receipt_ref_num"];
        [receiptDetails1 setObject:@"false" forKey:@"status"];
        
        for (int i=0; i < [item count]; i++) {
            
            [temp setObject:[item objectAtIndex:i] forKey:@"item"];
            [temp setObject:[desc objectAtIndex:i] forKey:@"description"];
            [temp setObject:[price objectAtIndex:i] forKey:@"price"];
            [temp setObject:[max_qty objectAtIndex:i] forKey:@"max_quantity"];
            [temp setObject:[qty objectAtIndex:i] forKey:@"quantity"];
            [temp setObject:[cost objectAtIndex:i] forKey:@"cost"];
            [temp setObject:[issued objectAtIndex:i] forKey:@"issued"];
            [temp setObject:[received objectAtIndex:i] forKey:@"recieved"];
            [temp setObject:[rejected objectAtIndex:i] forKey:@"rejected"];
            
            
            dic = [temp copy];
            
            [temp1 setObject:dic forKey:[NSString stringWithFormat:@"%d",i]];
            
            [temparr addObject:[temp1 valueForKey:[NSString stringWithFormat:@"%d",i]]];
            
        }
        
        [receiptDetails1 setObject:temparr forKey:@"reciptDetails"];
        
        //        NSArray *keys = [NSArray arrayWithObjects:@"receipt_id",@"from_location", @"date",@"item",@"description",@"quantity",@"max_quantity",@"price",@"cost",@"issued",@"rejected",@"received",@"status", nil];
        //
        //        NSArray *objects = [NSArray arrayWithObjects:editFinalReceiptID,fromLocationTxt.text, currentdate,item,desc,qty,max_qty,price,cost,issued,rejected, received,@"true", nil];
        //        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:receiptDetails1 options:0 error:&err];
        NSString * createReceiptJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        ////        StockReceiptServiceSoapBinding *materialBinding = [[StockReceiptServiceSvc StockReceiptServiceSoapBinding] retain];
        //        tns1_updateStockReciept *aparams = [[tns1_updateStockReciept alloc] init];
        //        aparams.stockRecieptDetails = createReceiptJsonString;
        //
        //        StockReceiptServiceSoapBindingResponse *response = [materialBinding updateStockRecieptUsingParameters:(tns1_updateStockReciept *)aparams];
        //        NSArray *responseBodyParts = response.bodyParts;
        
        //        for (id bodyPart in responseBodyParts) {
        //            if ([bodyPart isKindOfClass:[tns1_updateStockRecieptResponse class]]) {
        //                tns1_updateStockRecieptResponse *body = (tns1_updateStockRecieptResponse *)bodyPart;
        //                printf("\nresponse=%s",[body.return_ UTF8String]);
        //
        //                if (body.return_ != NULL) {
        //                    NSError *e;
        //                    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
        //                                                                         options: NSJSONReadingMutableContainers
        //                                                                           error: &e];
        //                    NSString *receiptID = [JSON objectForKey:@"receipt_id"];
        //                    editReceipt = [receiptID copy];
        //                    UIAlertView *successAlertView  = [[UIAlertView alloc] init];
        //                    [successAlertView setDelegate:self];
        //                    [successAlertView setTitle:@"Stock Receipt Updated Successfully"];
        //                    [successAlertView setMessage:[NSString stringWithFormat:@"%@%@",@"Receipt ID : ",receiptID]];
        //                    [successAlertView addButtonWithTitle:@"OPEN RECEIPT"];
        //                    [successAlertView addButtonWithTitle:@"NEW RECEIPT"];
        //
        //                    [successAlertView show];
        //                }
        //            }
        //        }
        
        WHStockReceiptServiceSoapBinding *materialBinding = [[WHStockReceiptService WHStockReceiptServiceSoapBinding] retain];
        
        materialBinding.logXMLInOut = YES;
        
        WHStockReceiptService_updateStockReciept *update_receipt = [[WHStockReceiptService_updateStockReciept alloc] init];
        update_receipt.stockRecieptDetails = createReceiptJsonString;
        
        WHStockReceiptServiceSoapBindingResponse *response = [materialBinding updateStockRecieptUsingParameters:update_receipt];
        NSArray *responseBodyParts1 = response.bodyParts;
        
        NSDictionary *JSON_ ;
        
        for (id bodyPart in responseBodyParts1) {
            
            if ([bodyPart isKindOfClass:[WHStockReceiptService_updateStockRecieptResponse class]]) {
                
                
                // [HUD_ setHidden:YES];
                WHStockReceiptService_updateStockRecieptResponse *body = (WHStockReceiptService_updateStockRecieptResponse *)bodyPart;
                printf("\nresponse=%s",[body.return_ UTF8String]);
                
                // status = body.return_;
                NSError *e;
                NSDictionary *json1;
                
                json1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                        options: NSJSONReadingMutableContainers
                                                          error: &e];
                
                if (json1!=NULL) {
                    
                    JSON_ = [json1 objectForKey:@"responseHeader"];
                    if ([[JSON_ objectForKey:@"responseMessage"] isEqualToString:@"Success"]) {
                        
                        NSString *receiptID = [json1 objectForKey:@"receiptid"];
                        wareEditReceipt = [receiptID copy];
                        UIAlertView *successAlertView  = [[UIAlertView alloc] init];
                        [successAlertView setDelegate:self];
                        [successAlertView setTitle:@"Stock Receipt Saved Successfully"];
                        [successAlertView setMessage:[NSString stringWithFormat:@"%@%@",@"Receipt ID : ",receiptID]];
                        [successAlertView addButtonWithTitle:@"OPEN RECEIPT"];
                        [successAlertView addButtonWithTitle:@"NEW RECEIPT"];
                        
                        [successAlertView show];
                        
                        //  [HUD_ setHidden:YES];
                        // [HUD_ release];
                        
                        
                    }
                    
                }
                else{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed to Save Receipt" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                }
            }
        }
        
        
        [HUD_ setHidden:YES];
        location.text = @"";
        deliveredBy.text = @"";
        inspectedBy.text = @"";
        
        [rawMaterials removeAllObjects];
        [rawMaterialDetails removeAllObjects];
        [cartTable reloadData];
        totalCost.text = @"0.0";
        totalQunatity.text = @"0";
        
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
        
    }
    return YES;
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    AudioServicesPlaySystemSound (soundFileObject);
    if ([alertView.title isEqualToString:@"Stock Receipt Updated Successfully"]) {
        if (buttonIndex == 0) {
            self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
            self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
            OpenWareHouseReceipt *stockReceipt = [[OpenWareHouseReceipt alloc] initWithReceiptID:wareEditReceipt];
            [self.navigationController pushViewController:stockReceipt animated:YES];
        }
        else{
            alertView.hidden = YES;
        }
    }
    else if ([alertView.title isEqualToString:@"Stock Receipt Saved Successfully"]){
        if (buttonIndex == 0) {
            self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
            self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
            OpenWareHouseReceipt *stockReceipt = [[OpenWareHouseReceipt alloc] initWithReceiptID:wareEditReceipt];
            [self.navigationController pushViewController:stockReceipt animated:YES];
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
