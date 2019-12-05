//
//  EditStockReceipt.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 2/14/15.
//
//

#import "EditStockReceipt.h"
#import "MaterialTransferReciepts.h"
#import "Global.h"
#import "StockReceiptServiceSvc.h"
#import "RawMaterialServiceSvc.h"
#import "OpenStockReceipt.h"
#import "EditStockIssue.h"
#import "StockIssueServiceSvc.h"
#import "OpenStockIssue.h"
#import "SkuServiceSvc.h"
#import "UtilityMasterServiceSvc.h"
#import "CheckWifi.h"
#import "OmniHomePage.h"
#import "RequestHeader.h"

@interface EditStockIssue ()

@end

@implementation EditStockIssue

@synthesize soundFileObject,soundFileURLRef;

int editQuantity_issue = 0;
int editMaterialTagid_issue = 0;
float editMaterialCost_issue = 0.0f;
int editRejectMaterialTagid_issue = 0;
int receipt_id_val_int;
NSString *editReceipt_issue = @"";
NSString *editFinalReceiptID_issue = @"";
NSString *issueIdStr = @"";
int editlocationIndex = 0;



-(id) initWithReceiptID:(NSString *)receiptID{
    
    editFinalReceiptID_issue = [receiptID copy];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    version = [UIDevice currentDevice].systemVersion.floatValue;

    isCancelBtnSelected = false;// added by roja on 17/10/2019...
 
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = backBtn;
    
    
    
    self.navigationController.navigationBarHidden = NO;
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 400.0, 45.0)];
    titleView.backgroundColor = [UIColor clearColor];
    
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo_200.png"]];
    logoView.backgroundColor = [UIColor clearColor];
    logoView.frame = CGRectMake(60.0, 0.0, 45.0, 45.0);
    
    [logoView setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *sinleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(homeButonClicked)];
    [logoView addGestureRecognizer:sinleTap];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(110.0, -13.0, 200.0, 70.0)];
    titleLbl.text = @"Edit Stock Issue";
    titleLbl.textColor = [UIColor blackColor];
    titleLbl.font = [UIFont boldSystemFontOfSize:25.0f];
    titleLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25.0f];
    [titleView addSubview:logoView];
    [titleView addSubview:titleLbl];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
    }
    else{
        logoView.frame = CGRectMake(20.0, 7.0, 30.0, 30.0);
        titleLbl.frame = CGRectMake(55.0, -12.0, 200.0, 70.0);
        titleLbl.backgroundColor = [UIColor clearColor];
//        titleLbl.textColor = [UIColor whiteColor];
        titleLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:13.0f];
    }
    
    self.navigationItem.titleView = titleView;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    HUD_ = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD_];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD_.delegate = self;
    HUD_.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD_.mode = MBProgressHUDModeCustomView;
    
    locationArr = [[NSMutableArray alloc]init];
    
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
    skListTable.dataSource = self;
    skListTable.delegate = self;
    (skListTable.layer).borderWidth = 1.0f;
    skListTable.layer.cornerRadius = 3;
    skListTable.layer.borderColor = [UIColor grayColor].CGColor;
    
    recieptNumberTxt = [[UITextField alloc] init] ;
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
    
    fromLocationTxt = [[UITextField alloc] init] ;
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
    location.placeholder = @"   From Location";
    [location awakeFromNib];
    // [location addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    toLocation = [[CustomTextField alloc] init];
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
    toLocation.placeholder = @"   From Location";
    toLocation.userInteractionEnabled = FALSE;
    [toLocation awakeFromNib];
    
    locationTable = [[UITableView alloc] init];
    locationTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    locationTable.dataSource = self;
    locationTable.delegate = self;
    (locationTable.layer).borderWidth = 1.0f;
    locationTable.layer.cornerRadius = 3;
    locationTable.layer.borderColor = [UIColor grayColor].CGColor;
    locationTable.hidden = YES;
    
    selectLocation = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *buttonImageDD = [UIImage imageNamed:@"combo.png"];
    [selectLocation setBackgroundImage:buttonImageDD forState:UIControlStateNormal];
    [selectLocation addTarget:self
                       action:@selector(getListOfLocations:) forControlEvents:UIControlEventTouchDown];
    selectLocation.tag = 1;
    
    
    
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
    [deliveredBy awakeFromNib];
    // [deliveredBy addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
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
    [inspectedBy awakeFromNib];
    // [inspectedBy addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    NSDate *today = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"dd/MM/yyyy HH:mm:ss";
    NSString* currentdate = [f stringFromDate:today];
    
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
    
    
    dropDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImageSM = [UIImage imageNamed:@"combo.png"];
    [dropDownButton setBackgroundImage:buttonImageSM forState:UIControlStateNormal];
    [dropDownButton addTarget:self action:@selector(shipoModeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    dropDownButton.userInteractionEnabled = YES;
    
    UILabel *skuidLbl = [[UILabel alloc] init] ;
    skuidLbl.text = @"Sku Id";
    skuidLbl.layer.cornerRadius = 14;
    skuidLbl.layer.masksToBounds = YES;
    skuidLbl.numberOfLines = 2;
    skuidLbl.textAlignment = NSTextAlignmentCenter;
    skuidLbl.font = [UIFont boldSystemFontOfSize:14.0];
    skuidLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    skuidLbl.textColor = [UIColor whiteColor];
    
    UILabel *desclbl = [[UILabel alloc] init] ;
    desclbl.text = @"Desc";
    desclbl.layer.cornerRadius = 14;
    desclbl.layer.masksToBounds = YES;
    desclbl.numberOfLines = 2;
    desclbl.textAlignment = NSTextAlignmentCenter;
    desclbl.font = [UIFont boldSystemFontOfSize:14.0];
    desclbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    desclbl.textColor = [UIColor whiteColor];
    
    UILabel *priceLbl_ = [[UILabel alloc] init];
    priceLbl_.text = @"Price";
    priceLbl_.layer.cornerRadius = 14;
    priceLbl_.layer.masksToBounds = YES;
    priceLbl_.textAlignment = NSTextAlignmentCenter;
    priceLbl_.font = [UIFont boldSystemFontOfSize:14.0];
    priceLbl_.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    priceLbl_.textColor = [UIColor whiteColor];
    
    UILabel *packLbl = [[UILabel alloc] init] ;
    packLbl.text = @"Pack";
    packLbl.layer.cornerRadius = 14;
    packLbl.layer.masksToBounds = YES;
    packLbl.textAlignment = NSTextAlignmentCenter;
    packLbl.font = [UIFont boldSystemFontOfSize:14.0];
    packLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    packLbl.textColor = [UIColor whiteColor];
    
    UILabel *qtyLbl = [[UILabel alloc] init] ;
    qtyLbl.text = @"Qty";
    qtyLbl.layer.cornerRadius = 14;
    qtyLbl.layer.masksToBounds = YES;
    qtyLbl.textAlignment = NSTextAlignmentCenter;
    qtyLbl.font = [UIFont boldSystemFontOfSize:14.0];
    qtyLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    qtyLbl.textColor = [UIColor whiteColor];
    
    UILabel *shippedQtyLbl = [[UILabel alloc] init] ;
    shippedQtyLbl.text = @"Shipped Qty";
    shippedQtyLbl.layer.cornerRadius = 14;
    shippedQtyLbl.layer.masksToBounds = YES;
    shippedQtyLbl.textAlignment = NSTextAlignmentCenter;
    shippedQtyLbl.font = [UIFont boldSystemFontOfSize:14.0];
    shippedQtyLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    shippedQtyLbl.textColor = [UIColor whiteColor];
    
    UILabel *makeLbl = [[UILabel alloc] init] ;
    makeLbl.text = @"Make";
    makeLbl.layer.cornerRadius = 14;
    makeLbl.layer.masksToBounds = YES;
    makeLbl.textAlignment = NSTextAlignmentCenter;
    makeLbl.font = [UIFont boldSystemFontOfSize:14.0];
    makeLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    makeLbl.textColor = [UIColor whiteColor];
    
    UILabel *receivedLbl = [[UILabel alloc] init] ;
    receivedLbl.text = @"Supplied";
    receivedLbl.layer.cornerRadius = 14;
    receivedLbl.layer.masksToBounds = YES;
    receivedLbl.textAlignment = NSTextAlignmentCenter;
    receivedLbl.font = [UIFont boldSystemFontOfSize:14.0];
    receivedLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    receivedLbl.textColor = [UIColor whiteColor];
    
    UILabel *rejectedLbl = [[UILabel alloc] init] ;
    rejectedLbl.text = @"Rejected";
    rejectedLbl.layer.cornerRadius = 14;
    rejectedLbl.layer.masksToBounds = YES;
    rejectedLbl.textAlignment = NSTextAlignmentCenter;
    rejectedLbl.font = [UIFont boldSystemFontOfSize:14.0];
    rejectedLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    rejectedLbl.textColor = [UIColor whiteColor];
    
    UILabel *costLbl = [[UILabel alloc] init] ;
    costLbl.text = @"Cost";
    costLbl.layer.cornerRadius = 14;
    costLbl.layer.masksToBounds = YES;
    costLbl.textAlignment = NSTextAlignmentCenter;
    costLbl.font = [UIFont boldSystemFontOfSize:14.0];
    costLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    costLbl.textColor = [UIColor whiteColor];
    
    /** UIScrollView Design */
    scrollView = [[UIScrollView alloc] init];
    scrollView.hidden = NO;
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.bounces = FALSE;
    
    // Table for storing the items ..
    cartTable = [[UITableView alloc] init];
    cartTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    cartTable.backgroundColor = [UIColor clearColor];
    cartTable.dataSource = self;
    cartTable.delegate = self;
    
    fromLocation = [[UITableView alloc] init];
    fromLocation.backgroundColor = [UIColor clearColor];
    fromLocation.dataSource = self;
    fromLocation.delegate = self;
    fromLocation.hidden = YES;
    
    fromLocationDetails = [[NSMutableArray alloc] init];
    [fromLocationDetails addObject:@"site1"];
    [fromLocationDetails addObject:@"site2"];
    [fromLocationDetails addObject:@"site3"];
    [fromLocationDetails addObject:@"site4"];
    
    UILabel *totalQtyLbl = [[UILabel alloc] init] ;
    totalQtyLbl.text = @"Total Quantity";
    totalQtyLbl.layer.cornerRadius = 14;
    totalQtyLbl.layer.masksToBounds = YES;
    totalQtyLbl.textAlignment = NSTextAlignmentLeft;
    totalQtyLbl.font = [UIFont boldSystemFontOfSize:14.0];
    totalQtyLbl.textColor = [UIColor whiteColor];
    
    UILabel *totalCostLbl = [[UILabel alloc] init] ;
    totalCostLbl.text = @"Total Cost";
    totalCostLbl.layer.cornerRadius = 14;
    totalCostLbl.layer.masksToBounds = YES;
    totalCostLbl.textAlignment = NSTextAlignmentLeft;
    totalCostLbl.font = [UIFont boldSystemFontOfSize:14.0];
    totalCostLbl.textColor = [UIColor whiteColor];
    
    totalQunatity = [[UILabel alloc] init] ;
    totalQunatity.text = @"0";
    totalQunatity.layer.cornerRadius = 14;
    totalQunatity.layer.masksToBounds = YES;
    totalQunatity.textAlignment = NSTextAlignmentLeft;
    totalQunatity.font = [UIFont boldSystemFontOfSize:14.0];
    totalQunatity.textColor = [UIColor whiteColor];
    
    totalCost = [[UILabel alloc] init] ;
    totalCost.text = @"0.0";
    totalCost.layer.cornerRadius = 14;
    totalCost.layer.masksToBounds = YES;
    totalCost.textAlignment = NSTextAlignmentLeft;
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
        location.frame = CGRectMake(10.0, 10.0, 300, 40);
        
        toLocation.font = [UIFont boldSystemFontOfSize:20];
        toLocation.frame = CGRectMake(320.0, 10.0, 300, 40);
        
        selectLocation.frame = CGRectMake(270, 5, 50, 55);
        
        locationTable.frame = CGRectMake(10.0, 50.0, 300, 0);
        
        
        deliveredBy.font = [UIFont boldSystemFontOfSize:20];
        deliveredBy.frame = CGRectMake(630.0, 10.0, 300, 40);
        
        inspectedBy.font = [UIFont boldSystemFontOfSize:20];
        inspectedBy.frame = CGRectMake(10.0, 60, 300, 40);
        
        date.font = [UIFont boldSystemFontOfSize:20];
        date.frame = CGRectMake(320.0, 60.0, 300, 40);
        
    
        toLocation.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"location" attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.6]}];
        deliveredBy.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"delivered by" attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.6]}];
        inspectedBy.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"inspected by" attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.6]}];
        
        BillField.font = [UIFont boldSystemFontOfSize:20    ];
        BillField.frame = CGRectMake(5.0, 135, 853.0, 40.0);
        
        skListTable.frame = CGRectMake(175, 80, 360,0);
        recieptNumberTxt.frame = CGRectMake(10.0, 140.0, 300.0, 50.0);
        fromLocationTxt.frame = CGRectMake(10.0, 150.0, 300.0, 50.0);
        dropDownButton.frame = CGRectMake(300.0, 143.0, 60.0, 70.0);
        
        skuidLbl.font = [UIFont boldSystemFontOfSize:15];
        skuidLbl.frame = CGRectMake(5, 180.0, 80, 40);
        desclbl.font = [UIFont boldSystemFontOfSize:15];
        desclbl.frame = CGRectMake(88, 180.0, 80, 40);
        priceLbl_.font = [UIFont boldSystemFontOfSize:15];
        priceLbl_.frame = CGRectMake(171, 180.0, 90, 40);
        packLbl.font = [UIFont boldSystemFontOfSize:15];
        packLbl.frame = CGRectMake(264, 180.0, 90, 40);
        qtyLbl.font = [UIFont boldSystemFontOfSize:15];
        qtyLbl.frame = CGRectMake(357, 180.0, 90, 40);
        // label8.font = [UIFont boldSystemFontOfSize:20];
        // label8.frame = CGRectMake(494, 270, 110, 55);
        shippedQtyLbl.font = [UIFont boldSystemFontOfSize:15];
        shippedQtyLbl.frame = CGRectMake(451, 180.0, 120, 40);
        receivedLbl.font = [UIFont boldSystemFontOfSize:15];
        receivedLbl.frame = CGRectMake(451, 180.0, 110, 40);
        makeLbl.font = [UIFont boldSystemFontOfSize:15];
        makeLbl.frame = CGRectMake(565, 180.0, 70, 40);
        rejectedLbl.font = [UIFont boldSystemFontOfSize:15];
        rejectedLbl.frame = CGRectMake(639, 180.0, 110, 40);
        costLbl.font = [UIFont boldSystemFontOfSize:15];
        costLbl.frame = CGRectMake(753, 180.0, 110, 40);
        
        scrollView.frame = CGRectMake(10, 230.0, 1030.0, 260.0);
        scrollView.contentSize = CGSizeMake(778, 1000);
        cartTable.frame = CGRectMake(10, 230, 1030.0,300);
        cartTable.hidden = YES;
        totalQtyLbl.font = [UIFont boldSystemFontOfSize:20];
        totalQtyLbl.frame = CGRectMake(750.0, 500.0, 200, 55.0);
        
        totalCostLbl.font = [UIFont boldSystemFontOfSize:20];
        totalCostLbl.frame = CGRectMake(750.0, 550.0, 200, 55);
        
        totalQunatity.font = [UIFont boldSystemFontOfSize:20];
        totalQunatity.frame = CGRectMake(930.0, 500.0, 200, 55);
        
        totalCost.font = [UIFont boldSystemFontOfSize:20];
        totalCost.frame = CGRectMake(930.0, 550.0, 200, 55);
        
        submitBtn.frame = CGRectMake(45.0f, 550.0,300.0f, 55.0f);
        submitBtn.layer.cornerRadius = 25.0f;
        submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        cancelButton.frame = CGRectMake(400.0f, 550.0,300.0f, 55.0f);
        cancelButton.layer.cornerRadius = 25.0f;
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        [self.view addSubview:skuidLbl];
        [self.view addSubview:priceLbl_];
        [self.view addSubview:packLbl];
        [self.view addSubview:qtyLbl];
        [self.view addSubview:totalCostLbl];
        [self.view addSubview:receivedLbl];
        [self.view addSubview:rejectedLbl];
        [self.view addSubview:desclbl];
//        [self.view addSubview:shippedQtyLbl];
        [self.view addSubview:totalQtyLbl];
        [self.view addSubview:costLbl];
        [self.view addSubview:makeLbl];
        [self.view addSubview:totalCostLbl];
        [self.view addSubview:totalQunatity];
        [self.view addSubview:totalCost];
    }
    else {
        
        if (version>8.0) {
            
            
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
            
//            label2.font = [UIFont boldSystemFontOfSize:15];
//            label2.frame = CGRectMake(0, 0, 50, 35);
//            label3.font = [UIFont boldSystemFontOfSize:15];
//            label3.frame = CGRectMake(50, 0, 60, 35);
//            label4.font = [UIFont boldSystemFontOfSize:15];
//            label4.frame = CGRectMake(110, 0, 60, 35);
//            label5.font = [UIFont boldSystemFontOfSize:15];
//            label5.frame = CGRectMake(170, 0, 60, 35);
//            label9.font = [UIFont boldSystemFontOfSize:15];
//            label9.frame = CGRectMake(230, 0, 80, 35);
//            // label8.font = [UIFont boldSystemFontOfSize:20];
//            // label8.frame = CGRectMake(494, 270, 110, 55);
//            label10.font = [UIFont boldSystemFontOfSize:15];
//            label10.frame = CGRectMake(310, 0, 80, 35);
//            //        label10.font = [UIFont boldSystemFontOfSize:15];
            //        label10.frame = CGRectMake(350.0, 0, 80, 35);
            
            scrollView.frame = CGRectMake(10, 175, 400.0, 150.0);
            scrollView.contentSize = CGSizeMake(600, 1000);
            cartTable.frame = CGRectMake(0, 40, 750,60);
            
//            label6.font = [UIFont boldSystemFontOfSize:15];
//            label6.frame = CGRectMake(10.0, 315.0, 120, 25.0);
//            [label6 setBackgroundColor:[UIColor clearColor]];
//            
//            label7.font = [UIFont boldSystemFontOfSize:15];
//            label7.frame = CGRectMake(10.0, 345.0, 150, 25);
//            [label7 setBackgroundColor:[UIColor clearColor]];
//            
            totalQunatity.font = [UIFont boldSystemFontOfSize:15];
            totalQunatity.frame = CGRectMake(190.0, 315.0, 120, 25);
            totalQunatity.backgroundColor = [UIColor clearColor];
            
            
            totalCost.font = [UIFont boldSystemFontOfSize:15];
            totalCost.frame = CGRectMake(190.0, 345.0, 120, 25);
            totalCost.backgroundColor = [UIColor clearColor];
            
            
            submitBtn.frame = CGRectMake(5.0f, 440.0,150.0f, 35.0f);
            submitBtn.layer.cornerRadius = 17.0f;
            submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
            cancelButton.frame = CGRectMake(160.0f, 440,150.0f, 35.0f);
            cancelButton.layer.cornerRadius = 17.0f;
            cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
            
//            [scrollView addSubview:label2];
//            [scrollView addSubview:label3];
//            [scrollView addSubview:label4];
//            [scrollView addSubview:label5];
//            [scrollView addSubview:label8];
//            [scrollView addSubview:label9];
//            [scrollView addSubview:label10];
            //        [scrollView addSubview:label6];
            //        [scrollView addSubview:label7];
            //        [scrollView addSubview:totalCost];
            //        [scrollView addSubview:totalQunatity];
            
            location.attributedPlaceholder = [[NSAttributedString alloc]initWithString:location.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            toLocation.attributedPlaceholder = [[NSAttributedString alloc]initWithString:toLocation.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            deliveredBy.attributedPlaceholder = [[NSAttributedString alloc]initWithString:deliveredBy.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            inspectedBy.attributedPlaceholder = [[NSAttributedString alloc]initWithString:inspectedBy.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            
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
            
//            label2.font = [UIFont boldSystemFontOfSize:15];
//            label2.frame = CGRectMake(0, 0, 50, 35);
//            label3.font = [UIFont boldSystemFontOfSize:15];
//            label3.frame = CGRectMake(50, 0, 60, 35);
//            label4.font = [UIFont boldSystemFontOfSize:15];
//            label4.frame = CGRectMake(110, 0, 60, 35);
//            label5.font = [UIFont boldSystemFontOfSize:15];
//            label5.frame = CGRectMake(170, 0, 60, 35);
//            label9.font = [UIFont boldSystemFontOfSize:15];
//            label9.frame = CGRectMake(230, 0, 80, 35);
//            // label8.font = [UIFont boldSystemFontOfSize:20];
//            // label8.frame = CGRectMake(494, 270, 110, 55);
//            label10.font = [UIFont boldSystemFontOfSize:15];
//            label10.frame = CGRectMake(310, 0, 80, 35);
//            //        label10.font = [UIFont boldSystemFontOfSize:15];
//            //        label10.frame = CGRectMake(350.0, 0, 80, 35);
            
            scrollView.frame = CGRectMake(10, 175, 400.0, 150.0);
            scrollView.contentSize = CGSizeMake(600, 1000);
            cartTable.frame = CGRectMake(0, 40, 750,60);
            
//            label6.font = [UIFont boldSystemFontOfSize:15];
//            label6.frame = CGRectMake(10.0, 315.0, 120, 25.0);
//            [label6 setBackgroundColor:[UIColor clearColor]];
//            
//            label7.font = [UIFont boldSystemFontOfSize:15];
//            label7.frame = CGRectMake(10.0, 345.0, 150, 25);
//            [label7 setBackgroundColor:[UIColor clearColor]];
            
            totalQunatity.font = [UIFont boldSystemFontOfSize:15];
            totalQunatity.frame = CGRectMake(190.0, 315.0, 120, 25);
            totalQunatity.backgroundColor = [UIColor clearColor];
            
            
            totalCost.font = [UIFont boldSystemFontOfSize:15];
            totalCost.frame = CGRectMake(190.0, 345.0, 120, 25);
            totalCost.backgroundColor = [UIColor clearColor];
            
            
            submitBtn.frame = CGRectMake(5.0f, 370.0,150.0f, 35.0f);
            submitBtn.layer.cornerRadius = 17.0f;
            submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
            cancelButton.frame = CGRectMake(160.0f, 370.0,150.0f, 35.0f);
            cancelButton.layer.cornerRadius = 17.0f;
            cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
            
//            [scrollView addSubview:label2];
//            [scrollView addSubview:label3];
//            [scrollView addSubview:label4];
//            [scrollView addSubview:label5];
//            [scrollView addSubview:label8];
//            [scrollView addSubview:label9];
//            [scrollView addSubview:label10];
            //        [scrollView addSubview:label6];
            //        [scrollView addSubview:label7];
            //        [scrollView addSubview:totalCost];
            //        [scrollView addSubview:totalQunatity];
        }
    }
    [self.view addSubview:location];
    [self.view addSubview:toLocation];
    [self.view addSubview:selectLocation];
    [self.view addSubview:locationTable];
    [self.view addSubview:deliveredBy];
    [self.view addSubview:inspectedBy];
    [self.view addSubview:date];
    [self.view addSubview:BillField];
    [self.view addSubview:skListTable];
    [self.view addSubview:cartTable];
    //[self.view addSubview:recieptNumberTxt];
    //    [self.view addSubview:fromLocationTxt];
    //    [self.view addSubview:dropDownButton];
//    [self.view addSubview:label2];
//    [self.view addSubview:label3];
//    [self.view addSubview:label4];
//    [self.view addSubview:label5];
//    [self.view addSubview:label6];
//    [self.view addSubview:label7];
    //    [self.view addSubview:label8];
//    [self.view addSubview:label9];
//    [self.view addSubview:label10];
    [self.view addSubview:totalQunatity];
    [self.view addSubview:totalCost];
    [self.view addSubview:submitBtn];
    [self.view addSubview:cancelButton];
    
    [self callReceiptIDDetails:editFinalReceiptID_issue];
    
    rawMaterials = [[NSMutableArray alloc] init];
    skuArrayList = [[NSMutableArray alloc]init];
    tempSkuArrayList = [[NSMutableArray alloc] init];
    
    priceTable = [[UITableView alloc] init];
    priceTable.backgroundColor = [UIColor blackColor];
    priceTable.dataSource = self;
    priceTable.delegate = self;
    (priceTable.layer).borderWidth = 1.0f;
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
    [closeBtn setBackgroundImage:image    forState:UIControlStateNormal];
    
    
    priceView = [[UIView alloc] initWithFrame:CGRectMake(250, 200, self.view.frame.size.width, self.view.frame.size.height)];
    priceView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6f];
    // priceView.hidden = YES;
    
    transparentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    transparentView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6f];
    transparentView.hidden = YES;
    
    descLabl = [[UILabel alloc]init];
    descLabl.text = @"Description";
    descLabl.layer.cornerRadius = 14;
    descLabl.textAlignment = NSTextAlignmentCenter;
    descLabl.layer.masksToBounds = YES;
    descLabl.font = [UIFont boldSystemFontOfSize:14.0];
    descLabl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:14.0f];
    descLabl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    descLabl.textColor = [UIColor whiteColor];
    
    priceLbl = [[UILabel alloc]init];
    priceLbl.text = @"Price";
    priceLbl.layer.cornerRadius = 14;
    priceLbl.layer.masksToBounds = YES;
    priceLbl.textAlignment = NSTextAlignmentCenter;
    priceLbl.font = [UIFont boldSystemFontOfSize:14.0];
    priceLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:14.0f];
    priceLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    priceLbl.textColor = [UIColor whiteColor];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        priceView.frame = CGRectMake(250, 200, self.view.frame.size.width, self.view.frame.size.height);
        priceLbl.frame = CGRectMake(300, 5, 180, 30);
        descLabl.frame = CGRectMake(30, 5, 250, 30);
        closeBtn.frame = CGRectMake(750, 200.0, 40, 40);
        transparentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        priceTable.frame = CGRectMake(0, 40, 480, 400);
    }
    else {
        descLabl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:12.0f];
        priceLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:12.0f];
        priceView.frame = CGRectMake(10, 50.0, self.view.frame.size.width, self.view.frame.size.height);
        priceLbl.frame = CGRectMake(140.0, 5, 100, 30);
        descLabl.frame = CGRectMake(30, 5, 100, 30);
        closeBtn.frame = CGRectMake(250.0, 50.0, 40, 40);
        transparentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        priceTable.frame = CGRectMake(20, 40, 220, 200);
    }
    [priceView addSubview:priceLbl];
    [priceView addSubview:descLabl];
    [priceView addSubview:priceTable];
    [transparentView addSubview:priceView];
    [transparentView addSubview:closeBtn];
    [self.view addSubview:transparentView];
    
}


// Commented by roja on 17/10/2019.. // reason : callReceiptIDDetails method contains SOAP Service call .. so taken new method with same(callReceiptIDDetails) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//-(void) callReceiptIDDetails:(NSString *)receiptID{
//
//    CheckWifi *wifi = [[CheckWifi alloc]init];
//    BOOL status = [wifi checkWifi];
//
//    if (status) {
//
//
//    editMaterialCost_issue = 0.0f;
//    editQuantity_issue = 0;
//    [rawMaterialDetails removeAllObjects];
//    totalCost.text = @"0.0";
//    totalQunatity.text = @"0";
//    BOOL status = FALSE;
//
//        @try {
//
//            NSMutableDictionary *receiptDetails1 = [[NSMutableDictionary alloc] init];
//            receiptDetails1[@"requestHeader"] = [RequestHeader getRequestHeader];
//            receiptDetails1[@"goods_issue_ref_num"] = editFinalReceiptID_issue;
//            // [receiptDetails1 setObject:[NSString stringWithFormat:@"%d",startIndex] forKey:@""];
//
//            NSError * err;
//            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:receiptDetails1 options:0 error:&err];
//            NSString * createReceiptJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//
//
//
//            StockIssueServiceSoapBinding *materialBinding = [StockIssueServiceSvc StockIssueServiceSoapBinding] ;
//            materialBinding.logXMLInOut = YES;
//            StockIssueServiceSvc_getStockIssue *create_receipt = [[StockIssueServiceSvc_getStockIssue alloc] init];
//            create_receipt.issueID = createReceiptJsonString;
//
//            StockIssueServiceSoapBindingResponse *response = [materialBinding getStockIssueUsingParameters:create_receipt];
//
//            NSArray *responseBodyParts = response.bodyParts;
//
//            NSDictionary *JSONData;
//
//            for (id bodyPart in responseBodyParts) {
//
//                if ([bodyPart isKindOfClass:[StockIssueServiceSvc_getStockIssueResponse class]]) {
//
//                    StockIssueServiceSvc_getStockIssueResponse *body = (StockIssueServiceSvc_getStockIssueResponse *)bodyPart;
//                    printf("\nresponse=%s",(body.return_).UTF8String);
//                    NSError *e;
//                    status = TRUE;
//                    JSONData = [[NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                options: NSJSONReadingMutableContainers
//                                                                  error: &e] copy];
//                    //viewJSON_issue = [JSONData copy];
//                }
//            }
//            if (status) {
//                NSDictionary *temp1 = [JSONData valueForKey:@"issueDetails"];
//                // NSLog(@"%@",temp1);
//
//                NSArray *items = [JSONData valueForKey:@"itemDetails"];
//                date.text = temp1[@"deliveryDate"];
//
//                if (![temp1[@"issue_to"] isKindOfClass:[NSNull class]]) {
//                    toLocation.text = temp1[@"shipped_from"];
//                    receipt_id_val_int = [temp1[@"id_goods_issue"] intValue];
//                    deliveredBy.text = temp1[@"delivered_by"];
//                    inspectedBy.text = temp1[@"inspectedBy"];
//                    location.text = temp1[@"issue_to"];
//                }
//                else{
//                    toLocation.text = temp1[@"shipped_from"];
//                    receipt_id_val_int = [temp1[@"id_goods_issue"] intValue];
//                    deliveredBy.text = temp1[@"delivered_by"];
//                    inspectedBy.text = temp1[@"inspectedBy"];
//                    location.text = @"";
//                }
//
//
//                for (int i = 0; i < items.count; i++) {
//
//                    NSDictionary *itemDic = items[i];
//                    NSMutableArray *itemArr = [[NSMutableArray alloc] init];
//                    //                [itemArr addObject:[itemDic valueForKey:@"description"]];
//                    //                [itemArr addObject:[itemDic valueForKey:@"item"]];
//                    //                [itemArr addObject:[itemDic valueForKey:@"price"]];
//                    //                [itemArr addObject:[itemDic valueForKey:@"quantity"]];
//                    //                [itemArr addObject:[itemDic valueForKey:@"maxquantity"]];
//                    //                [itemArr addObject:[itemDic valueForKey:@"recieved"]];
//                    //                [itemArr addObject:[itemDic valueForKey:@"rejected"]];
//                    //                [itemArr addObject:[itemDic valueForKey:@"cost"]];
//                    //                [itemArr addObject:[itemDic valueForKey:@"skuId"]];
//
//                    [itemArr addObject:[itemDic valueForKey:@"skuId"]];
//                    [itemArr addObject:[itemDic valueForKey:@"description"]];
//                    [itemArr addObject:[itemDic valueForKey:@"price"]];
//                    [itemArr addObject:@"NOS"];
//                    [itemArr addObject:[itemDic valueForKey:@"quantity"]];
//                    [itemArr addObject:[itemDic valueForKey:@"quantity"]];
//                    [itemArr addObject:[itemDic valueForKey:@"recieved"]];
//                    [itemArr addObject:@"NA"];
//                    [itemArr addObject:[itemDic valueForKey:@"rejected"]];
//                    [itemArr addObject:[itemDic valueForKey:@"cost"]];
//                    [itemArr addObject:[itemDic valueForKey:@"pluCode"]];
//
//                    [rawMaterialDetails addObject:itemArr];
//
//
//                }
//                for (int j = 0; j < rawMaterialDetails.count; j++) {
//
//                    NSArray *temp = rawMaterialDetails[j];
//
//                    editQuantity_issue = editQuantity_issue + [temp[6] intValue];
//                    editMaterialCost_issue = editMaterialCost_issue + ([temp[6] intValue] * [temp[2]  floatValue]);
//                }
//
//                totalQunatity.text = [NSString stringWithFormat:@"%d",editQuantity_issue];
//                totalCost.text = [NSString stringWithFormat:@"%.2f",editMaterialCost_issue];
//                cartTable.hidden = NO;
//                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//                    cartTable.frame = CGRectMake(cartTable.frame.origin.x, cartTable.frame.origin.y, cartTable.frame.size.width, cartTable.frame.size.height);
//                }
//                else {
//                    cartTable.frame = CGRectMake(cartTable.frame.origin.x, cartTable.frame.origin.y, cartTable.frame.size.width, cartTable.frame.size.height);
//                }
//                [cartTable reloadData];
//
//            }
//        }
//    @catch (NSException *exception) {
//
//
//    }
//    }
//    else {
//
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Please enable wifi or mobile data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    }
//
//}



//callReceiptIDDetails method changed by roja on 17/10/2019.. // reason : removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST
-(void) callReceiptIDDetails:(NSString *)receiptID {
    
    CheckWifi *wifi = [[CheckWifi alloc]init];
    BOOL status = [wifi checkWifi];
    
    if (status) {
        
        @try {
            
            editMaterialCost_issue = 0.0f;
            editQuantity_issue = 0;
            [rawMaterialDetails removeAllObjects];
            totalCost.text = @"0.0";
            totalQunatity.text = @"0";

            
            [HUD_ setHidden:NO];
            
            NSMutableDictionary *receiptDetails1 = [[NSMutableDictionary alloc] init];
            receiptDetails1[@"requestHeader"] = [RequestHeader getRequestHeader];
            receiptDetails1[@"goods_issue_ref_num"] = editFinalReceiptID_issue;
            // [receiptDetails1 setObject:[NSString stringWithFormat:@"%d",startIndex] forKey:@""];
            
            NSError * err;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:receiptDetails1 options:0 error:&err];
            NSString * createReceiptJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            WebServiceController * services = [[WebServiceController alloc] init];
            services.stockIssueDelegate= self;
            [services getStockIssueId:createReceiptJsonString];
            
        }
        @catch (NSException *exception) {
            
        }
    }
    else {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Please enable wifi or mobile data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}


// added by Roja on 17/10/2019…. // Old code only written here...
- (void)getStockIssueIdSuccessResponse:(NSDictionary *)sucessDictionary{
    
    @try {
        NSDictionary *temp1 = [sucessDictionary valueForKey:@"issueDetails"];
        // NSLog(@"%@",temp1);
        
        NSArray *items = [sucessDictionary valueForKey:@"itemDetails"];
        date.text = temp1[@"deliveryDate"];
        
        if (![temp1[@"issue_to"] isKindOfClass:[NSNull class]]) {
            toLocation.text = temp1[@"shipped_from"];
            receipt_id_val_int = [temp1[@"id_goods_issue"] intValue];
            deliveredBy.text = temp1[@"delivered_by"];
            inspectedBy.text = temp1[@"inspectedBy"];
            location.text = temp1[@"issue_to"];
        }
        else{
            toLocation.text = temp1[@"shipped_from"];
            receipt_id_val_int = [temp1[@"id_goods_issue"] intValue];
            deliveredBy.text = temp1[@"delivered_by"];
            inspectedBy.text = temp1[@"inspectedBy"];
            location.text = @"";
        }
        
        
        for (int i = 0; i < items.count; i++) {
            
            NSDictionary *itemDic = items[i];
            NSMutableArray *itemArr = [[NSMutableArray alloc] init];
        
            [itemArr addObject:[itemDic valueForKey:@"skuId"]];
            [itemArr addObject:[itemDic valueForKey:@"description"]];
            [itemArr addObject:[itemDic valueForKey:@"price"]];
            [itemArr addObject:@"NOS"];
            [itemArr addObject:[itemDic valueForKey:@"quantity"]];
            [itemArr addObject:[itemDic valueForKey:@"quantity"]];
            [itemArr addObject:[itemDic valueForKey:@"recieved"]];
            [itemArr addObject:@"NA"];
            [itemArr addObject:[itemDic valueForKey:@"rejected"]];
            [itemArr addObject:[itemDic valueForKey:@"cost"]];
            [itemArr addObject:[itemDic valueForKey:@"pluCode"]];
            
            [rawMaterialDetails addObject:itemArr];
            
        }
        for (int j = 0; j < rawMaterialDetails.count; j++) {
            
            NSArray *temp = rawMaterialDetails[j];
            
            editQuantity_issue = editQuantity_issue + [temp[6] intValue];
            editMaterialCost_issue = editMaterialCost_issue + ([temp[6] intValue] * [temp[2]  floatValue]);
        }
        
        totalQunatity.text = [NSString stringWithFormat:@"%d",editQuantity_issue];
        totalCost.text = [NSString stringWithFormat:@"%.2f",editMaterialCost_issue];
        cartTable.hidden = NO;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            cartTable.frame = CGRectMake(cartTable.frame.origin.x, cartTable.frame.origin.y, cartTable.frame.size.width, cartTable.frame.size.height);
        }
        else {
            cartTable.frame = CGRectMake(cartTable.frame.origin.x, cartTable.frame.origin.y, cartTable.frame.size.width, cartTable.frame.size.height);
        }
        [cartTable reloadData];
        
    } @catch (NSException *exception) {
    
    } @finally {
        [HUD_ setHidden:YES];
    }
}


// added by Roja on 17/10/2019…. // Old code only written here...
- (void)getStockIssueIdErrorResponse:(NSString *)error{
    
    @try {
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

    } @catch (NSException *exception) {
        
    } @finally {
        [HUD_ setHidden:YES];
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
    // BOOL status = FALSE;
    
    CheckWifi *wifi = [[CheckWifi alloc]init];
    BOOL status = [wifi checkWifi];
    
    if (status) {

    
    [HUD_ setHidden:NO];
    
//    SkuServiceSoapBinding *skuService = [[SkuServiceSvc SkuServiceSoapBinding] retain];
//    
//    SkuServiceSvc_searchProducts *getSkuid = [[SkuServiceSvc_searchProducts alloc] init];
    NSArray *keys = @[@"requestHeader",@"startIndex",@"searchCriteria",@"storeLocation"];
    NSArray *objects = @[[RequestHeader getRequestHeader],@"0",searchString,presentLocation];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
    NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    getSkuid.searchCriteria = salesReportJsonString;
    //
//    if ([tempSkuArrayList count]!=0) {
//        [tempSkuArrayList removeAllObjects];
//    }
    //
    @try {
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.searchProductDelegate = self;
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
//                [HUD_ setHidden:YES];
//                
//                NSArray *list = [JSON objectForKey:@"productsList"];
//                
//                [tempSkuArrayList addObjectsFromArray:list];
//            }
//        }
        
    }
    @catch (NSException *exception) {
        
        [HUD_ setHidden:YES];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No data found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    }
    else {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Please enable wifi or mobile data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
    //[skListTable reloadData];
    
}

#pragma mark - Search Products Service Reposnse Delegates

- (void)searchProductsSuccessResponse:(NSDictionary *)successDictionary {
    
    [tempSkuArrayList removeAllObjects];
    @try {
        if (successDictionary != nil) {
            if (![successDictionary[@"productsList"] isKindOfClass:[NSNull class]]) {
                NSArray *list = successDictionary[@"productsList"];
                [tempSkuArrayList addObjectsFromArray:list];
            }
            [skuArrayList removeAllObjects];
            [rawMaterials removeAllObjects];
            for (NSDictionary *product in tempSkuArrayList)
            {
                NSComparisonResult result;
                
                if (!([product[@"productId"] rangeOfString:searchStringStock options:NSCaseInsensitiveSearch].location == NSNotFound))
                {
                    result = [product[@"productId"] compare:searchStringStock options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, searchStringStock.length)];
                    if (result == NSOrderedSame)
                    {
                        [skuArrayList addObject:product[@"productId"]];
                        [rawMaterials addObject:product];
                        
                    }
                }
                if (!([product[@"description"] rangeOfString:searchStringStock options:NSCaseInsensitiveSearch].location == NSNotFound)) {
                    
                    [skuArrayList addObject:product[@"description"]];
                    [rawMaterials addObject:product];
                    
                    
                    
                    
                }
                else {
                    
                    // [filteredSkuArrayList addObject:[product objectForKey:@"skuID"]];
                    
                    
                    result = [product[@"skuID"] compare:searchStringStock options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, searchStringStock.length)];
                    
                    if (result == NSOrderedSame)
                    {
                        [skuArrayList addObject:product[@"skuID"]];
                        [rawMaterials addObject:product];
                        
                    }
                }
                
                
            }
            
            if (skuArrayList.count > 0) {
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    skListTable.frame = CGRectMake(5.0, 175.0, 853,240);
                }
                else {
                    if (version >= 8.0) {
                        skListTable.frame = CGRectMake(60, 170, 180,200);
                    }
                    else{
                        skListTable.frame = CGRectMake(60.0, 170.0, 180, 130);
                    }
                }
                
                if (skuArrayList.count > 5) {
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        skListTable.frame = CGRectMake(5.0, 175.0, 853,450);
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
        [HUD_ setHidden:YES];
    }
    [HUD_ setHidden:YES];
    
}
- (void)searchProductsErrorResponse {
    [HUD_ setHidden:YES];
    
}
#pragma mark End of Search Products Service Reposnse Delegates -


-(void) callRawMaterialDetails:(NSString *)rawMaterial{
    
    CheckWifi *wifi = [[CheckWifi alloc]init];
    BOOL status_wifi = [wifi checkWifi];
    
    if (status_wifi) {

        rawMateialsSkuid = [rawMaterial copy];
    
    
    NSArray *keys = @[@"skuId",@"requestHeader",@"storeLocation"];
    NSArray *objects = @[rawMaterial,[RequestHeader getRequestHeader],presentLocation];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
    NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
//    getSkuid.skuID = salesReportJsonString;
        
    @try {
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.getSkuDetailsDelegate = self;
        [webServiceController getSkuDetailsWithData:salesReportJsonString];

        
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
//            }
//        }
//        
//        NSArray *temp = [NSArray arrayWithObjects:[JSON objectForKey:@"description"],[JSON objectForKey:@"productName"],[JSON objectForKey:@"price"],@"1",[JSON objectForKey:@"quantity"],@"1",@"0", [JSON objectForKey:@"price"],rawMaterial,[JSON objectForKey:@"skuId"],nil];
//        
//        //       NSArray *temp = [NSArray arrayWithObjects:[JSON objectForKey:@"product_name"],[JSON objectForKey:@"price"],@"1",@"1",@"1",@"0",[JSON objectForKey:@"description"],[JSON objectForKey:@"quantity"], nil];
//        
//        for (int c = 0; c < [rawMaterialDetails count]; c++) {
//            NSArray *material = [rawMaterialDetails objectAtIndex:c];
//            if ([[material objectAtIndex:8] isEqualToString:[NSString stringWithFormat:@"%@",[JSON objectForKey:@"skuId"]]]) {
//                //            NSArray *temp = [NSArray arrayWithObjects:[material objectAtIndex:0],[material objectAtIndex:1],[material objectAtIndex:2],[NSString stringWithFormat:@"%.2f",(([[material objectAtIndex:3] intValue] + 1) * [[material objectAtIndex:2] floatValue])],[NSString stringWithFormat:@"%d",[[material objectAtIndex:3] intValue] + 1],@"0",[temp objectAtIndex:5],[temp objectAtIndex:6],[temp objectAtIndex:7],[NSString stringWithFormat:@"%d",[[material objectAtIndex:6] intValue] + 1],[NSString stringWithFormat:@"%d",[[material objectAtIndex:7] intValue]+1],[material objectAtIndex:8], nil];
//                
//                NSArray *temp = [NSArray arrayWithObjects:[material objectAtIndex:0],[material objectAtIndex:1],[material objectAtIndex:2],[NSString stringWithFormat:@"%d",[[material objectAtIndex:3] intValue] + 1],[material objectAtIndex:4],[NSString stringWithFormat:@"%d",[[material objectAtIndex:5] intValue]+1],[material objectAtIndex:6],[NSString stringWithFormat:@"%.2f",(([[material objectAtIndex:3] intValue] + 1) * [[material objectAtIndex:2] floatValue])],[material objectAtIndex:8],[material objectAtIndex:4], nil];
//                
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
//        editQuantity_issue = 0;
//        editMaterialCost_issue = 0.0f;
//        
//        for (int i = 0; i < [rawMaterialDetails count]; i++) {
//            NSArray *material = [rawMaterialDetails objectAtIndex:i];
//            editQuantity_issue = editQuantity_issue + [[material objectAtIndex:5] intValue];
//            editMaterialCost_issue = editMaterialCost_issue + ([[material objectAtIndex:5] intValue] * [[material objectAtIndex:2] floatValue]);
//        }
//        
//        totalQunatity.text = [NSString stringWithFormat:@"%d",editQuantity_issue];
//        totalCost.text = [NSString stringWithFormat:@"%.2f",editMaterialCost_issue];
    }
    @catch (NSException *exception) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Failed to get the details" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
        
    }
    else {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Please enable wifi or mobile data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)getSkuDetailsSuccessResponse:(NSDictionary *)successDictionary
{
    @try {
        BOOL status = TRUE;
        if (successDictionary != nil) {
            if (![[successDictionary valueForKey:@"skuLists"] isKindOfClass:[NSNull class]]) {
                
                priceDic = [[NSMutableArray alloc]init];
                
                NSArray *price_arr = [successDictionary valueForKey:@"skuLists"];
                for (int i=0; i<price_arr.count; i++) {
                    
                    NSDictionary *json = price_arr[i];
                    [priceDic addObject:json];
                }
                
                if ([[successDictionary valueForKey:@"skuLists"] count]>1) {
                    
                    
                    if (priceDic.count>0) {
                        [HUD_ setHidden:YES];
                        transparentView.hidden = NO;
                        [priceTable reloadData];
                    }
                }
                else {
                    
                    if ([priceDic[0][@"quantity"] floatValue] > 0) {
                        NSDictionary *itemDic = priceDic[0];
                        
                        NSArray *temp = @[itemDic[@"skuId"],itemDic[@"description"],itemDic[@"price"],[itemDic valueForKey:@"uom"],@"1",@"1",@"1",@"N/A",@"0",itemDic[@"price"],[itemDic valueForKey:@"pluCode"]];
                        for (int c = 0; c < rawMaterialDetails.count; c++) {
                            NSArray *material = rawMaterialDetails[c];
                            if ([material[0] isEqualToString:[NSString stringWithFormat:@"%@",itemDic[@"skuId"]]] && [material[10] isEqualToString:[NSString stringWithFormat:@"%@",itemDic[@"pluCode"]]]) {
                                NSArray *temp = @[material[0],material[1],material[2],material[3],[NSString stringWithFormat:@"%d",[material[4] intValue] + 1],material[5],[NSString stringWithFormat:@"%d",([material[6] intValue] + 1)],material[7],[NSString stringWithFormat:@"%d",[material[8] intValue]],[NSString stringWithFormat:@"%.2f",(([material[6] intValue]+1) * [material[2] floatValue])],material[10]];
                                rawMaterialDetails[c] = temp;
                                status = FALSE;
                            }
                        }
                        if (status) {
                            [rawMaterialDetails addObject:temp];
                        }
                        
                        scrollView.hidden = NO;
                        cartTable.hidden = NO;
                        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                            cartTable.frame = CGRectMake(cartTable.frame.origin.x, cartTable.frame.origin.y, cartTable.frame.size.width, cartTable.frame.size.height);
                        }
                        else {
                            cartTable.frame = CGRectMake(cartTable.frame.origin.x, cartTable.frame.origin.y, cartTable.frame.size.width, cartTable.frame.size.height);
                        }
                        [cartTable reloadData];
                        
                        editQuantity_issue = 0;
                        editMaterialCost_issue = 0.0f;
                        
                        for (int i = 0; i < rawMaterialDetails.count; i++) {
                            NSArray *material = rawMaterialDetails[i];
                            editQuantity_issue = editQuantity_issue + [material[6] intValue];
                            editMaterialCost_issue = editMaterialCost_issue + ([material[6] intValue] * [material[2] floatValue]);
                        }
                        
                        totalQunatity.text = [NSString stringWithFormat:@"%d",editQuantity_issue];
                        totalCost.text = [NSString stringWithFormat:@"%.2f",editMaterialCost_issue];

                    }
                }
            }
        }
    }
    @catch(NSException * exception){
        
    }
}

- (void)getSkuDetailsErrorResponse:(NSString *)failureString {
    [HUD_ setHidden:YES];
    UIAlertView *alert=  [[UIAlertView alloc] initWithTitle:failureString message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}


- (void)textFieldDidChange:(UITextField *)textField {
    if (textField == BillField) {
        
        if ((textField.text).length >= 3) {
            searchStringStock = [textField.text copy];
            [self callRawMaterials:textField.text];
        }
    }
    else if (textField == rejectedQty){
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        [textField resignFirstResponder];
        cartTable.userInteractionEnabled = FALSE;
        
        NSArray *temp = rawMaterialDetails[textField.tag];
        
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
        topbar.textAlignment = NSTextAlignmentCenter;
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
        availQtyData.text = [NSString stringWithFormat:@"%@",temp[3]];
        availQtyData.font = [UIFont boldSystemFontOfSize:14];
        availQtyData.backgroundColor = [UIColor clearColor];
        availQtyData.textColor = [UIColor blackColor];
        [rejectQtyChangeDisplayView addSubview:availQtyData];
        
        UILabel *unitPriceData = [[UILabel alloc] init];
        unitPriceData.text = [NSString stringWithFormat:@"%@",temp[2]];
        unitPriceData.font = [UIFont boldSystemFontOfSize:14];
        unitPriceData.backgroundColor = [UIColor clearColor];
        unitPriceData.textColor = [UIColor blackColor];
        
        
        rejecQtyField = [[UITextField alloc] init];
        rejecQtyField.borderStyle = UITextBorderStyleRoundedRect;
        rejecQtyField.textColor = [UIColor blackColor];
        rejecQtyField.placeholder = @"Enter Qty";
        //NumberKeyBoard hidden....
//        UIToolbar* numberToolbar1 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
//        numberToolbar1.barStyle = UIBarStyleBlackTranslucent;
//        numberToolbar1.items = [NSArray arrayWithObjects:
//                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
//                                [[UIBarButtonItem alloc]initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
//                                nil];
//        [numberToolbar1 sizeToFit];
        rejecQtyField.keyboardType = UIKeyboardTypeNumberPad;
//        rejecQtyField.inputAccessoryView = numberToolbar1;
        rejecQtyField.text = textField.text;
        rejecQtyField.font = [UIFont systemFontOfSize:17.0];
        rejecQtyField.backgroundColor = [UIColor whiteColor];
        rejecQtyField.autocorrectionType = UITextAutocorrectionTypeNo;
        //qtyFeild.keyboardType = UIKeyboardTypeDefault;
        rejecQtyField.clearButtonMode = UITextFieldViewModeWhileEditing;
        rejecQtyField.returnKeyType = UIReturnKeyDone;
        rejecQtyField.delegate = self;
        [rejecQtyField becomeFirstResponder];
        
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
        
        editRejectMaterialTagid_issue = textField.tag;
        
      
        
    }
    else {
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        [textField resignFirstResponder];
        cartTable.userInteractionEnabled = FALSE;
        
        NSArray *temp = rawMaterialDetails[textField.tag];
        
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
        topbar.textAlignment = NSTextAlignmentCenter;
        topbar.font = [UIFont boldSystemFontOfSize:17];
        topbar.textColor = [UIColor whiteColor];
        topbar.textAlignment = NSTextAlignmentLeft;
        
        
        UILabel *availQty = [[UILabel alloc] init];
        availQty.text = @"Available Qty :";
        availQty.font = [UIFont boldSystemFontOfSize:14];
        availQty.backgroundColor = [UIColor clearColor];
        availQty.textColor = [UIColor blackColor];
        
        UILabel *unitPrice = [[UILabel alloc] init];
        unitPrice.text = @"Unit Price       :";
        unitPrice.font = [UIFont boldSystemFontOfSize:14];
        unitPrice.backgroundColor = [UIColor clearColor];
        unitPrice.textColor = [UIColor blackColor];
        
        
        UILabel *availQtyData = [[UILabel alloc] init];
        availQtyData.text = [NSString stringWithFormat:@"%@",temp[4]];
        availQtyData.font = [UIFont boldSystemFontOfSize:14];
        availQtyData.backgroundColor = [UIColor clearColor];
        availQtyData.textColor = [UIColor blackColor];
        
        UILabel *unitPriceData = [[UILabel alloc] init];
        unitPriceData.text = [NSString stringWithFormat:@"%.2f",[temp[2] floatValue]];
        unitPriceData.font = [UIFont boldSystemFontOfSize:14];
        unitPriceData.backgroundColor = [UIColor clearColor];
        unitPriceData.textColor = [UIColor blackColor];
        
        
        qtyFeild = [[UITextField alloc] init];
        qtyFeild.borderStyle = UITextBorderStyleRoundedRect;
        qtyFeild.textColor = [UIColor blackColor];
        qtyFeild.placeholder = @"Enter Qty";
        //NumberKeyBoard hidden....
//        UIToolbar* numberToolbar1 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
//        numberToolbar1.barStyle = UIBarStyleBlackTranslucent;
//        numberToolbar1.items = [NSArray arrayWithObjects:
//                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
//                                [[UIBarButtonItem alloc]initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
//                                nil];
//        [numberToolbar1 sizeToFit];
        qtyFeild.keyboardType = UIKeyboardTypeNumberPad;
//        qtyFeild.inputAccessoryView = numberToolbar1;
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
            
            
            availQty.frame = CGRectMake(10,60,200,40);
            availQty.font = [UIFont boldSystemFontOfSize:25];
            
            
            unitPrice.frame = CGRectMake(10,110,200,40);
            unitPrice.font = [UIFont boldSystemFontOfSize:25];
            
            
            availQtyData.frame = CGRectMake(200,60,250,40);
            availQtyData.font = [UIFont boldSystemFontOfSize:25];
            
            
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
        
        [qtyChangeDisplyView addSubview:img];
        [qtyChangeDisplyView addSubview:topbar];
        [qtyChangeDisplyView addSubview:availQty];
        [qtyChangeDisplyView addSubview:unitPrice];
        [qtyChangeDisplyView addSubview:availQtyData];
        [qtyChangeDisplyView addSubview:unitPriceData];
        [qtyChangeDisplyView addSubview:qtyFeild];
        [qtyChangeDisplyView addSubview:okButton];
        [qtyChangeDisplyView addSubview:qtyCancelButton];
        
        editMaterialTagid_issue = textField.tag;
        
        
    }
    
}
-(void)getListOfLocations:(id)sender {
    
    if (sender == selectLocation) {
        
        if (selectLocation.tag == 1) {
            
        
      //  [selectLocation setEnabled:NO];
        
        [cartTable setUserInteractionEnabled:NO];
        [location resignFirstResponder];
            selectLocation.tag = 2;
        editlocationIndex = 0;
        [self getLocations:editlocationIndex];
        
        // [waiterName resignFirstResponder];
        locationTable.hidden = NO;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            locationTable.frame = CGRectMake(10.0, 60.0, 360, 220);
        }
        else {
            locationTable.frame = CGRectMake(0.0, 37.0, 140, 120);
        }

        [self.view bringSubviewToFront:locationTable];
        
    }
        else {
            
            selectLocation.tag = 1;
            [locationTable setHidden:YES];
        }
    }
    
}


// Commented by roja on 17/10/2019.. // reason :- getLocations: method contains SOAP Service call .. so taken new method with same name(getLocations:) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//-(void)getLocations:(int)startIndex {
//
//    CheckWifi *wifi = [[CheckWifi alloc]init];
//    BOOL status = [wifi checkWifi];
//
//    if (status) {
//
//    UtilityMasterServiceSoapBinding *utility =  [UtilityMasterServiceSvc UtilityMasterServiceSoapBinding] ;
//    utility.logXMLInOut = YES;
//
//    //    NSError * err;
//    //    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
//    //    NSString * requestHeaderString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//    NSArray *loyaltyKeys = @[@"startIndex",@"requestHeader"];
//
//    NSArray *loyaltyObjects = @[[NSString stringWithFormat:@"%d",startIndex],[RequestHeader getRequestHeader]];
//    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
//
//    NSError * err_;
//    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
//    NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//
//    UtilityMasterServiceSvc_getLocation *location1 = [[UtilityMasterServiceSvc_getLocation alloc] init];
//    location1.locationDetails = loyaltyString;
//
//    @try {
//
//        UtilityMasterServiceSoapBindingResponse *response_ = [utility getLocationUsingParameters:location1];
//
//        NSArray *responseBodyParts1_ = response_.bodyParts;
//        NSDictionary *JSON1;
//        for (id bodyPart in responseBodyParts1_) {
//
//            if ([bodyPart isKindOfClass:[UtilityMasterServiceSvc_getLocationResponse class]]) {
//                // status = TRUE;
//                UtilityMasterServiceSvc_getLocationResponse *body = (UtilityMasterServiceSvc_getLocationResponse *)bodyPart;
//                printf("\nresponse=%s",(body.return_).UTF8String);
//
//                //status = body.return_;
//                NSError *e;
//                JSON1 = [[NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                         options: NSJSONReadingMutableContainers
//                                                           error: &e] copy];
//            }
//        }
//
//        NSDictionary *responseHeader = [JSON1 valueForKey:@"responseHeader"];
//
//        if ([[responseHeader valueForKey:@"responseCode"] isEqualToString:@"0"] && [[responseHeader valueForKey:@"responseMessage"] isEqualToString:@"Location Details"]) {
//
//            NSArray *locations = [JSON1 valueForKey:@"locationDetails"];
//
//            for (int i=0; i < locations.count; i++) {
//
//                NSDictionary *location1 = locations[i];
//
//                [locationArr addObject:[location1 valueForKey:@"locationId"]];
//
//            }
//
//            if ([locationArr containsObject:presentLocation]) {
//
//                [locationArr removeObject:presentLocation];
//            }
//
//            [locationTable reloadData];
//
//        }
//        else {
//
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Failed to get the locations" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//
//        }
//
//    }
//    @catch (NSException *exception) {
//
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Failed to get the locations" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//
//    }
//    }
//    else {
//
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Please enable wifi or mobile data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    }
//}


//getLocations: method changed by roja on 17/10/2019.. // reason : removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST

-(void)getLocations:(int)startIndex {
    
    CheckWifi *wifi = [[CheckWifi alloc]init];
    BOOL status = [wifi checkWifi];
    
    if (status) {
        
        [HUD_ setHidden:NO];

        NSArray *loyaltyKeys = @[@"startIndex",@"requestHeader"];
        NSArray *loyaltyObjects = @[[NSString stringWithFormat:@"%d",startIndex],[RequestHeader getRequestHeader]];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        
        WebServiceController * services  = [[WebServiceController alloc] init];
        services.utilityMasterDelegate = self;
        [services getAllLocationDetailsData:loyaltyString];
        
    }
    else {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Please enable wifi or mobile data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}


// added by Roja on 17/10/2019…. // OLd code only written below
- (void)getLocationSuccessResponse:(NSDictionary *)sucessDictionary{
    
    @try {
        
            NSArray *locations = [sucessDictionary valueForKey:@"locationDetails"];
            
            for (int i=0; i < locations.count; i++) {
                
                NSDictionary *location1 = locations[i];
                [locationArr addObject:[location1 valueForKey:@"locationId"]];
            }
            
            if ([locationArr containsObject:presentLocation]) {
                
                [locationArr removeObject:presentLocation];
            }
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD_ setHidden:YES];
        [locationTable reloadData];

    }
}


// added by Roja on 17/10/2019…. // OLd code only written below
- (void)getLocationErrorResponse:(NSString *)error{
    
    @try {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

    } @catch (NSException *exception) {
        
    } @finally {
        [HUD_ setHidden:YES];
    }
}




- (IBAction)okButtonPressed:(id)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    cartTable.userInteractionEnabled = TRUE;
    NSString *value = [rejecQtyField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // PhoNumber validation...
    NSString *decimalRegex = @"[0-9]+([.]([0-9]+)?)?"; // @"[0-9]+[.][0-9]+";
    NSPredicate *decimalTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalRegex];
    BOOL isNumber = [decimalTest evaluateWithObject:rejecQtyField.text];
    int qty = value.intValue;
    @try {
        NSArray *temp = rawMaterialDetails[editRejectMaterialTagid_issue];
        
        if(value.length == 0 || !isNumber){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Quantity in Number." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            rejecQtyField.text = NO;
        }
        else if((rejecQtyField.text).intValue==0){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Valid Quantity." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            rejecQtyField.text = nil;
        }
//        else if ([rejecQtyField.text intValue]>[[temp objectAtIndex:4] intValue]){
//            
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Quantity should be less than the available quantity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//            [alert release];
//            
//            rejecQtyField.text = nil;
//        }
        else{
            //int received = qty - [[temp objectAtIndex:5] intValue];
            
            
            
            NSArray *finalArray = @[temp[0],temp[1],temp[2],temp[3],[NSString stringWithFormat:@"%d", qty],temp[5],[NSString stringWithFormat:@"%d", qty],temp[7],[NSString stringWithFormat:@"%d",0],[NSString stringWithFormat:@"%.2f",([temp[2] floatValue] * qty)],temp[10]];
            
            rawMaterialDetails[editRejectMaterialTagid_issue] = finalArray;
            
            [cartTable reloadData];
            
            rejectQtyChangeDisplayView.hidden = YES;
            cartTable.userInteractionEnabled = TRUE;
            
            editQuantity_issue = 0;
            editMaterialCost_issue = 0.0f;
            
            for (int i = 0; i < rawMaterialDetails.count; i++) {
                NSArray *material = rawMaterialDetails[i];
                editQuantity_issue = editQuantity_issue + [material[6] intValue];
                editMaterialCost_issue = editMaterialCost_issue + ([material[6] intValue] * [material[2] floatValue]);
            }
            
            totalQunatity.text = [NSString stringWithFormat:@"%d",editQuantity_issue];
            totalCost.text = [NSString stringWithFormat:@"%.2f",editMaterialCost_issue];
            
        }
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
        
    }
    
    
}

- (IBAction)QtyCancelButtonPressed:(id)sender {
    
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    rejectQtyChangeDisplayView.hidden = YES;
    cartTable.userInteractionEnabled = TRUE;
}

- (IBAction)rejectQtyOkButtonPressed:(id)sender{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    cartTable.userInteractionEnabled = TRUE;
    location.userInteractionEnabled = TRUE;
    deliveredBy.userInteractionEnabled = TRUE;
    inspectedBy.userInteractionEnabled = TRUE;
    submitBtn.userInteractionEnabled = TRUE;
    cancelButton.userInteractionEnabled = TRUE;
    segmentedControl.userInteractionEnabled = TRUE;

    NSString *value = [rejecQtyField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // PhoNumber validation...
    NSString *decimalRegex = @"[0-9]+([.]([0-9]+)?)?"; // @"[0-9]+[.][0-9]+";
    NSPredicate *decimalTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalRegex];
    BOOL isNumber = [decimalTest evaluateWithObject:rejecQtyField.text];
    int qty = value.intValue;
    
    NSArray *temp = rawMaterialDetails[editRejectMaterialTagid_issue];
    
    if (qty > [temp[4] intValue]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Quantity Should be Less than or Equal to  Available Quantity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        rejecQtyField.text = nil;
    }
    else if(value.length == 0 || !isNumber){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Quantity in Number." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
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
        
        @try {
            
            int received = [temp[4] intValue] - qty;
            
            NSArray *finalArray = @[temp[0],temp[1],temp[2],temp[3],temp[4],temp[5],[NSString stringWithFormat:@"%d",received],temp[7],[NSString stringWithFormat:@"%d",qty],[NSString stringWithFormat:@"%.2f",(received * [temp[2] floatValue])],temp[10]];
            
            rawMaterialDetails[editRejectMaterialTagid_issue] = finalArray;
            
            [cartTable reloadData];
            
            qtyChangeDisplyView.hidden = YES;
            cartTable.userInteractionEnabled = TRUE;
            
            editQuantity_issue = 0;
            editMaterialCost_issue = 0.0f;
            
            for (int i = 0; i < rawMaterialDetails.count; i++) {
                NSArray *material = rawMaterialDetails[i];
                editQuantity_issue = editQuantity_issue + [material[6] intValue];
                editMaterialCost_issue = editMaterialCost_issue + ([material[6] intValue] * [material[2] floatValue]);
            }
            
            totalQunatity.text = [NSString stringWithFormat:@"%d",editQuantity_issue];
            totalCost.text = [NSString stringWithFormat:@"%.2f",editMaterialCost_issue];

        }
        @catch (NSException *exception) {
            qtyChangeDisplyView.hidden = YES;
            cartTable.userInteractionEnabled = TRUE;
            NSLog(@"%@",exception);
        }
       
    }
    
}

-(IBAction) rejectQtyCancelButtonPressed:(id)sender{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    qtyChangeDisplyView.hidden = YES;
    cartTable.userInteractionEnabled = TRUE;
    location.userInteractionEnabled = TRUE;
    deliveredBy.userInteractionEnabled = TRUE;
    inspectedBy.userInteractionEnabled = TRUE;
    submitBtn.userInteractionEnabled = TRUE;
    cancelButton.userInteractionEnabled = TRUE;
    segmentedControl.userInteractionEnabled = TRUE;

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
            return 40.0;
        }
        else if (tableView == priceTable) {
            return 40.0;
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
        return rawMaterialDetails.count;
    }
    else if (tableView == priceTable){
        return priceDic.count;
    }
    else if (tableView == fromLocation){
        return fromLocationDetails.count;
    }
    else if (tableView == locationTable) {
        
        return locationArr.count;
    }
    else {
        return skuArrayList.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == cartTable) {
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        static NSString *hlCellID = @"hlCellID";
        
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
        
        if ((hlcell.contentView).subviews){
            for (UIView *subview in (hlcell.contentView).subviews) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID] ;
            hlcell.accessoryType = UITableViewCellAccessoryNone;
        }
        //
        
        @try {
            
            
            NSArray *temp = rawMaterialDetails[indexPath.row];
            
            UILabel *item_code = [[UILabel alloc] init] ;
            item_code.layer.borderWidth = 1.5;
            item_code.font = [UIFont systemFontOfSize:13.0];
            item_code.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            item_code.backgroundColor = [UIColor blackColor];
            item_code.textColor = [UIColor whiteColor];
            
            item_code.text = temp[0];
            item_code.textAlignment=NSTextAlignmentCenter;
            //        item_code.adjustsFontSizeToFitWidth = YES;
            //name.adjustsFontSizeToFitWidth = YES;
            
            UILabel *item_description = [[UILabel alloc] init] ;
            item_description.layer.borderWidth = 1.5;
            item_description.font = [UIFont systemFontOfSize:13.0];
            item_description.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            item_description.backgroundColor = [UIColor blackColor];
            item_description.textColor = [UIColor whiteColor];
            
            item_description.text = temp[1];
            item_description.textAlignment=NSTextAlignmentCenter;
            //        item_description.adjustsFontSizeToFitWidth = YES;
            
            UILabel *price = [[UILabel alloc] init] ;
            price.layer.borderWidth = 1.5;
            price.font = [UIFont systemFontOfSize:13.0];
            price.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            price.backgroundColor = [UIColor blackColor];
            price.text = [NSString stringWithFormat:@"%.2f",[temp[2] floatValue]];
            price.textColor = [UIColor whiteColor];
            price.textAlignment=NSTextAlignmentCenter;
            price.adjustsFontSizeToFitWidth = YES;
            
            
            UIButton *packButton = [[UIButton alloc] init] ;
            [packButton setTitle:temp[3] forState:UIControlStateNormal];
            packButton.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            packButton.layer.borderWidth = 1.5;
            [packButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [packButton addTarget:self action:@selector(changeQuantity:) forControlEvents:UIControlEventTouchUpInside];
            packButton.layer.masksToBounds = YES;
            packButton.tag = indexPath.row;
            [packButton setUserInteractionEnabled:NO];
            
            UIButton *qtyButton = [[UIButton alloc] init] ;
            [qtyButton setTitle:[NSString stringWithFormat:@"%d",[temp[4] intValue]] forState:UIControlStateNormal];
            qtyButton.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            qtyButton.layer.borderWidth = 1.5;
            [qtyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [qtyButton addTarget:self action:@selector(changeQuantity:) forControlEvents:UIControlEventTouchUpInside];
            qtyButton.layer.masksToBounds = YES;
            qtyButton.tag = indexPath.row;
            [qtyButton setUserInteractionEnabled:YES];
            
            UILabel *shippedQty = [[UILabel alloc] init] ;
            shippedQty.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            shippedQty.layer.borderWidth = 1.5;
            shippedQty.font = [UIFont systemFontOfSize:13.0];
            shippedQty.backgroundColor = [UIColor blackColor];
            shippedQty.text = [NSString stringWithFormat:@"%d", [temp[5] intValue]];
            shippedQty.textColor = [UIColor whiteColor];
            shippedQty.textAlignment=NSTextAlignmentCenter;
            shippedQty.adjustsFontSizeToFitWidth = YES;
            
            
            UILabel *cost = [[UILabel alloc] init] ;
            cost.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            cost.layer.borderWidth = 1.5;
            cost.font = [UIFont systemFontOfSize:13.0];
            cost.backgroundColor = [UIColor blackColor];
            cost.text = [NSString stringWithFormat:@"%.02f", [temp[9] floatValue]];
            cost.textColor = [UIColor whiteColor];
            cost.textAlignment=NSTextAlignmentCenter;
            cost.adjustsFontSizeToFitWidth = YES;
            
            UILabel *make = [[UILabel alloc] init] ;
            make.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            make.layer.borderWidth = 1.5;
            make.font = [UIFont systemFontOfSize:13.0];
            make.backgroundColor = [UIColor blackColor];
            make.text = [NSString stringWithFormat:@"%@", temp[7]];
            make.textColor = [UIColor whiteColor];
            make.textAlignment=NSTextAlignmentCenter;
            make.adjustsFontSizeToFitWidth = YES;
            
            UILabel *supplied = [[UILabel alloc] init] ;
            supplied.layer.borderWidth = 1.5;
            supplied.font = [UIFont systemFontOfSize:13.0];
            supplied.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            supplied.backgroundColor = [UIColor blackColor];
            supplied.textColor = [UIColor whiteColor];
            
            supplied.text = [NSString stringWithFormat:@"%d",[temp[6] intValue]];
            supplied.textAlignment=NSTextAlignmentCenter;
            supplied.adjustsFontSizeToFitWidth = YES;
            
            UILabel *received = [[UILabel alloc] init] ;
            received.layer.borderWidth = 1.5;
            received.font = [UIFont systemFontOfSize:13.0];
            received.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            received.backgroundColor = [UIColor blackColor];
            received.textColor = [UIColor whiteColor];
            
            received.text = [NSString stringWithFormat:@"%d",[temp[6] intValue]];
            received.textAlignment=NSTextAlignmentCenter;
            received.adjustsFontSizeToFitWidth = YES;
            
            UIButton *rejectQtyButton = [[UIButton alloc] init] ;
            [rejectQtyButton setTitle:[NSString stringWithFormat:@"%d",[temp[8] intValue]] forState:UIControlStateNormal];
            rejectQtyButton.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            rejectQtyButton.layer.borderWidth = 1.5;
            [rejectQtyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [rejectQtyButton addTarget:self action:@selector(changeRejectQuantity:) forControlEvents:UIControlEventTouchUpInside];
            rejectQtyButton.layer.masksToBounds = YES;
            rejectQtyButton.tag = indexPath.row;
            
            //        rejectedQty = [[UITextField alloc] init] ;
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
            
            UIButton *delrowbtn = [[UIButton alloc] init] ;
            [delrowbtn setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
            [delrowbtn addTarget:self action:@selector(delRow:) forControlEvents:UIControlEventTouchUpInside];
            delrowbtn.tag = indexPath.row;
            delrowbtn.backgroundColor = [UIColor clearColor];
            
            
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                //skid.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:22];
                item_code.font = [UIFont fontWithName:@"ArialRoundedMT" size:20];
                item_code.frame = CGRectMake(0, 0, 70, 40);
                item_description.font = [UIFont fontWithName:@"ArialRoundedMT" size:20];
                item_description.frame = CGRectMake(73, 0, 80, 40);
                price.font = [UIFont fontWithName:@"ArialRoundedMT" size:20];
                price.frame = CGRectMake(156, 0, 90, 40);
                packButton.frame = CGRectMake(249, 0, 90, 40);
                packButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMT" size:20];
                qtyButton.frame = CGRectMake(342, 0, 90, 40);
                qtyButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMT" size:20];
                shippedQty.frame = CGRectMake(435, 0, 120, 40);
                shippedQty.font = [UIFont fontWithName:@"ArialRoundedMT" size:20];
                cost.font = [UIFont fontWithName:@"ArialRoundedMT" size:20];
                cost.frame = CGRectMake(744, 0, 100, 40);
                //            supplied.font = [UIFont fontWithName:@"Helvetica" size:25];
                //            supplied.frame = CGRectMake(484, 0, 110, 56);
                received.font = [UIFont fontWithName:@"ArialRoundedMT" size:20];
                received.frame = CGRectMake(435, 0, 110, 40);
                make.font = [UIFont fontWithName:@"ArialRoundedMT" size:20];
                make.frame = CGRectMake(548, 0, 80, 40);
                //            received.font = [UIFont fontWithName:@"Helvetica" size:25];
                //            received.frame = CGRectMake(710.0, 0, 110, 56);
                rejectQtyButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMT" size:20];
                rejectQtyButton.frame = CGRectMake(631, 0, 110, 40);
                delrowbtn.frame = CGRectMake(845.0, 5 , 40, 40);
                
            }
            else {
                
                item_code.font = [UIFont fontWithName:@"ArialRoundedMT" size:10];
                item_code.frame = CGRectMake(0, 0, 50, 30);
                item_description.font = [UIFont fontWithName:@"ArialRoundedMT" size:10];
                item_description.frame = CGRectMake(50, 0, 50, 30);
                price.font = [UIFont fontWithName:@"ArialRoundedMT" size:15];
                price.frame = CGRectMake(100, 0, 60, 30);
                packButton.frame = CGRectMake(160, 0, 60, 30);
                qtyButton.frame = CGRectMake(220, 0, 50, 30);
                qtyButton.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMT" size:15];
                shippedQty.frame = CGRectMake(270, 0, 80, 30);
                shippedQty.font = [UIFont fontWithName:@"ArialRoundedMT" size:15];
                received.font = [UIFont fontWithName:@"ArialRoundedMT" size:15];
                received.frame = CGRectMake(350, 0, 80, 30);
                make.font = [UIFont fontWithName:@"ArialRoundedMT" size:15];
                make.frame = CGRectMake(430, 0, 80, 30);
                cost.font = [UIFont fontWithName:@"ArialRoundedMT" size:15];
                cost.frame = CGRectMake(590, 0, 80, 30);
                rejectQtyButton.frame = CGRectMake(510, 0, 80, 30);
                delrowbtn.frame = CGRectMake(680.0, 2 , 30, 30);
                
                
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
            
            
            
            hlcell.backgroundColor = [UIColor clearColor];
            [hlcell.contentView addSubview:item_code];
            [hlcell.contentView addSubview:item_description];
            [hlcell.contentView addSubview:price];
            [hlcell.contentView addSubview:packButton];
            [hlcell.contentView addSubview:qtyButton];
            [hlcell.contentView addSubview:received];
            [hlcell.contentView addSubview:shippedQty];
            [hlcell.contentView addSubview:cost];
            [hlcell.contentView addSubview:make];
            //[hlcell .contentView addSubview:supplied];
            [hlcell.contentView addSubview:received];
            [hlcell.contentView addSubview:rejectQtyButton];
            [hlcell addSubview:delrowbtn];
            
        }
        @catch (NSException *exception) {
            
            
        }
        
        //
        return hlcell;
        
    }
    else if (tableView == priceTable) {
        
        static NSString *hlCellID = @"hlCellID";
        
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
        
        if ((hlcell.contentView).subviews){
            
            for (UIView *subview in (hlcell.contentView).subviews) {
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
            
            NSDictionary *dic = priceDic[indexPath.row];
            
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
            
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
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
                
                skid.frame = CGRectMake(10, 0, 100, 34);
                name.frame = CGRectMake(120, 0, 90, 34);
                
                
            }
            
            hlcell.backgroundColor = [UIColor clearColor];
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
    else if (tableView == fromLocation) {
        
        tableView.separatorColor = [UIColor blackColor];
        
        static NSString *hlCellID = @"hlCellID";
        
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID] ;
            hlcell.accessoryType = UITableViewCellAccessoryNone;
        }
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            hlcell.textLabel.font = [UIFont fontWithName:@"ArialRoundedMT" size:25];
        }
        else{
            hlcell.textLabel.font = [UIFont fontWithName:@"ArialRoundedMT" size:15];
        }
        hlcell.backgroundColor = [UIColor whiteColor];
        hlcell.textLabel.text = fromLocationDetails[indexPath.row];
        
        return hlcell;
        
    }
    else if (tableView == locationTable) {
        
        tableView.separatorColor = [UIColor blackColor];
        
        static NSString *hlCellID = @"hlCellID";
        
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID] ;
            hlcell.accessoryType = UITableViewCellAccessoryNone;
        }
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            hlcell.textLabel.font = [UIFont fontWithName:@"ArialRoundedMT" size:25];
        }
        else{
            hlcell.textLabel.font = [UIFont fontWithName:@"ArialRoundedMT" size:15];
        }
        hlcell.textLabel.text = locationArr[indexPath.row];
        //[hlcell setBackgroundColor:[UIColor blackColor]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.selectionStyle = UITableViewCellEditingStyleNone;
        
        return hlcell;
        
    }
    else {
        static NSString *hlCellID = @"hlCellID";
        
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID] ;
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:20];
            }
        }
        
       // NSDictionary *JSON = [rawMaterials objectAtIndex:indexPath.row];
        hlcell.textLabel.text = skuArrayList[indexPath.row];
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
        
        NSDictionary *skuId = rawMaterials[indexPath.row];
        
        [self callRawMaterialDetails:[NSString stringWithFormat:@"%@",skuId[@"skuID"]]];
    }
    else if (tableView == priceTable) {
        
        NSDictionary *JSON = priceDic[indexPath.row];
        
        if ([JSON[@"quantity"] floatValue] > 0) {
            @try {
                BOOL status = TRUE;
                NSArray *temp = @[JSON[@"skuId"],JSON[@"description"],JSON[@"price"],[JSON valueForKey:@"uom"],@"1",@"1",@"1",@"N/A",@"0",JSON[@"price"],[JSON valueForKey:@"pluCode"]];
                for (int c = 0; c < rawMaterialDetails.count; c++) {
                    NSArray *material = rawMaterialDetails[c];
                    if ([material[0] isEqualToString:[NSString stringWithFormat:@"%@",JSON[@"skuId"]]] && [material[10] isEqualToString:[NSString stringWithFormat:@"%@",JSON[@"pluCode"]]]) {
                        NSArray *temp = @[material[0],material[1],material[2],material[3],[NSString stringWithFormat:@"%d",[material[4] intValue] + 1],material[5],[NSString stringWithFormat:@"%d",([material[6] intValue] + 1)],material[7],[NSString stringWithFormat:@"%d",[material[8] intValue]],[NSString stringWithFormat:@"%.2f",(([material[6] intValue]+1) * [material[2] floatValue])],material[10]];
                        rawMaterialDetails[c] = temp;
                        status = FALSE;
                    }
                }
                if (status) {
                    [rawMaterialDetails addObject:temp];
                }
                
                scrollView.hidden = NO;
                cartTable.hidden = NO;
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    cartTable.frame = CGRectMake(cartTable.frame.origin.x, cartTable.frame.origin.y, cartTable.frame.size.width, cartTable.frame.size.height);
                }
                else {
                    cartTable.frame = CGRectMake(cartTable.frame.origin.x, cartTable.frame.origin.y, cartTable.frame.size.width, cartTable.frame.size.height);
                }
                [cartTable reloadData];
                
                editQuantity_issue = 0;
                editMaterialCost_issue = 0.0f;
                
                for (int i = 0; i < rawMaterialDetails.count; i++) {
                    NSArray *material = rawMaterialDetails[i];
                    editQuantity_issue = editQuantity_issue + [material[6] intValue];
                    editMaterialCost_issue = editMaterialCost_issue + ([material[6] intValue] * [material[2] floatValue]);
                }
                
                totalQunatity.text = [NSString stringWithFormat:@"%d",editQuantity_issue];
                totalCost.text = [NSString stringWithFormat:@"%.2f",editMaterialCost_issue];
                transparentView.hidden = YES;
                [HUD_ setHidden:YES];

            }
            @catch (NSException * exception){
                
            }
        }
    }
    else if (tableView == locationTable) {
        
        location.text = @"";
        [fromLocation resignFirstResponder];
        locationTable.hidden = YES;
        location.text = locationArr[indexPath.row];
        [cartTable setUserInteractionEnabled:YES];
        [selectLocation setEnabled:YES];
        selectLocation.tag = 1;
        
    }
}

-(void)changeQuantity:(UIButton *)sender{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    cartTable.userInteractionEnabled = FALSE;
    
    NSArray *temp = rawMaterialDetails[sender.tag];
    
    rejectQtyChangeDisplayView = [[UIView alloc]init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        rejectQtyChangeDisplayView.frame = CGRectMake(300, 150, 375, 300);
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
    topbar.textAlignment = NSTextAlignmentCenter;
    topbar.font = [UIFont boldSystemFontOfSize:17];
    topbar.textColor = [UIColor whiteColor];
    topbar.textAlignment = NSTextAlignmentLeft;
    
    
    UILabel *availQty = [[UILabel alloc] init];
    availQty.text = @"Available Qty :";
    availQty.font = [UIFont boldSystemFontOfSize:14];
    availQty.backgroundColor = [UIColor clearColor];
    availQty.textColor = [UIColor blackColor];
//    [rejectQtyChangeDisplayView addSubview:availQty];
    
    UILabel *unitPrice = [[UILabel alloc] init];
    unitPrice.text = @"Unit Price       :";
    unitPrice.font = [UIFont boldSystemFontOfSize:14];
    unitPrice.backgroundColor = [UIColor clearColor];
    unitPrice.textColor = [UIColor blackColor];
    
    
    UILabel *availQtyData = [[UILabel alloc] init];
    availQtyData.text = [NSString stringWithFormat:@"%@",temp[4]];
    availQtyData.font = [UIFont boldSystemFontOfSize:14];
    availQtyData.backgroundColor = [UIColor clearColor];
    availQtyData.textColor = [UIColor blackColor];
//    [rejectQtyChangeDisplayView addSubview:availQtyData];
    
    UILabel *unitPriceData = [[UILabel alloc] init];
    unitPriceData.text = [NSString stringWithFormat:@"%@",temp[2]];
    unitPriceData.font = [UIFont boldSystemFontOfSize:14];
    unitPriceData.backgroundColor = [UIColor clearColor];
    unitPriceData.textColor = [UIColor blackColor];
    
    
    rejecQtyField = [[UITextField alloc] init];
    rejecQtyField.borderStyle = UITextBorderStyleRoundedRect;
    rejecQtyField.textColor = [UIColor blackColor];
    rejecQtyField.placeholder = @"Enter Qty";
    //NumberKeyBoard hidden....
//    UIToolbar* numberToolbar1 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
//    numberToolbar1.barStyle = UIBarStyleBlackTranslucent;
//    numberToolbar1.items = [NSArray arrayWithObjects:
//                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
//                            [[UIBarButtonItem alloc]initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
//                            nil];
//    [numberToolbar1 sizeToFit];
    rejecQtyField.keyboardType = UIKeyboardTypeNumberPad;
//    rejecQtyField.inputAccessoryView = numberToolbar1;
    rejecQtyField.font = [UIFont systemFontOfSize:17.0];
    rejecQtyField.backgroundColor = [UIColor whiteColor];
    rejecQtyField.autocorrectionType = UITextAutocorrectionTypeNo;
    //qtyFeild.keyboardType = UIKeyboardTypeDefault;
    rejecQtyField.clearButtonMode = UITextFieldViewModeWhileEditing;
    rejecQtyField.returnKeyType = UIReturnKeyDone;
    rejecQtyField.delegate = self;
    [rejecQtyField becomeFirstResponder];
    
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
        
        rejecQtyField.frame = CGRectMake(36, 107, 100, 30);
        rejecQtyField.font = [UIFont systemFontOfSize:17.0];
        
        okButton.frame = CGRectMake(10, 150, 75, 30);
        okButton.layer.cornerRadius = 14.0f;
        okButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
        qtyCancelButton.frame = CGRectMake(90, 150, 75, 30);
        qtyCancelButton.layer.cornerRadius = 14.0f;
        qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
    }
    
    [rejectQtyChangeDisplayView addSubview:img];
    [rejectQtyChangeDisplayView addSubview:topbar];
//    [rejectQtyChangeDisplayView addSubview:availQty];
    [rejectQtyChangeDisplayView addSubview:unitPrice];
//    [rejectQtyChangeDisplayView addSubview:availQtyData];
    [rejectQtyChangeDisplayView addSubview:unitPriceData];
    [rejectQtyChangeDisplayView addSubview:rejecQtyField];
    [rejectQtyChangeDisplayView addSubview:okButton];
    [rejectQtyChangeDisplayView addSubview:qtyCancelButton];
    
    editRejectMaterialTagid_issue = sender.tag;
    
  }
-(void) changeRejectQuantity:(UIButton *)sender{
    
    AudioServicesPlaySystemSound (soundFileObject);
    
    cartTable.userInteractionEnabled = FALSE;
    location.userInteractionEnabled = FALSE;
    deliveredBy.userInteractionEnabled = FALSE;
    inspectedBy.userInteractionEnabled = FALSE;
    submitBtn.userInteractionEnabled = FALSE;
    cancelButton.userInteractionEnabled = FALSE;
    segmentedControl.userInteractionEnabled = FALSE;
    NSArray *temp = rawMaterialDetails[sender.tag];
    
    qtyChangeDisplyView = [[UIView alloc]init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        qtyChangeDisplyView.frame = CGRectMake(300, 150, 375, 300);
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
    topbar.textAlignment = NSTextAlignmentCenter;
    topbar.font = [UIFont boldSystemFontOfSize:17];
    topbar.textColor = [UIColor whiteColor];
    topbar.textAlignment = NSTextAlignmentLeft;
    
    
    UILabel *availQty = [[UILabel alloc] init];
    availQty.text = @"Available Qty :";
    availQty.font = [UIFont boldSystemFontOfSize:14];
    availQty.backgroundColor = [UIColor clearColor];
    availQty.textColor = [UIColor blackColor];
    [qtyChangeDisplyView addSubview:availQty];
    
    UILabel *unitPrice = [[UILabel alloc] init];
    unitPrice.text = @"Unit Price       :";
    unitPrice.font = [UIFont boldSystemFontOfSize:14];
    unitPrice.backgroundColor = [UIColor clearColor];
    unitPrice.textColor = [UIColor blackColor];
    
    
    UILabel *availQtyData = [[UILabel alloc] init];
    availQtyData.text = [NSString stringWithFormat:@"%@",temp[4]];
    availQtyData.font = [UIFont boldSystemFontOfSize:14];
    availQtyData.backgroundColor = [UIColor clearColor];
    availQtyData.textColor = [UIColor blackColor];
    [qtyChangeDisplyView addSubview:availQtyData];
    
    UILabel *unitPriceData = [[UILabel alloc] init];
    unitPriceData.text = [NSString stringWithFormat:@"%@",temp[2]];
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
    numberToolbar1.items = @[[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar1 sizeToFit];
    rejecQtyField.keyboardType = UIKeyboardTypeNumberPad;
    //    rejectQtyField.inputAccessoryView = numberToolbar1;
    rejecQtyField.font = [UIFont systemFontOfSize:17.0];
    rejecQtyField.backgroundColor = [UIColor whiteColor];
    rejecQtyField.autocorrectionType = UITextAutocorrectionTypeNo;
    //qtyFeild.keyboardType = UIKeyboardTypeDefault;
    rejecQtyField.clearButtonMode = UITextFieldViewModeWhileEditing;
    rejecQtyField.returnKeyType = UIReturnKeyDone;
    rejecQtyField.delegate = self;
    [rejecQtyField becomeFirstResponder];
    
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
        
        
        rejecQtyField.frame = CGRectMake(110, 165, 150, 50);
        rejecQtyField.font = [UIFont systemFontOfSize:25.0];
        
        
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
        
        rejecQtyField.frame = CGRectMake(36, 107, 100, 30);
        rejecQtyField.font = [UIFont systemFontOfSize:17.0];
        
        rejectOkButton.frame = CGRectMake(10, 150, 75, 30);
        rejectOkButton.layer.cornerRadius = 14.0f;
        rejectOkButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
        rejectCancelButton.frame = CGRectMake(90, 150, 75, 30);
        rejectCancelButton.layer.cornerRadius = 14.0f;
        rejectCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
    }
    
    [qtyChangeDisplyView addSubview:img];
    [qtyChangeDisplyView addSubview:topbar];
    [qtyChangeDisplyView addSubview:availQty];
    [qtyChangeDisplyView addSubview:unitPrice];
    [qtyChangeDisplyView addSubview:availQtyData];
    [qtyChangeDisplyView addSubview:unitPriceData];
    [qtyChangeDisplyView addSubview:rejecQtyField];
    [qtyChangeDisplyView addSubview:rejectOkButton];
    [qtyChangeDisplyView addSubview:rejectCancelButton];
    
    editRejectMaterialTagid_issue = sender.tag;
    

    
}

- (void) delRow:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
       
        [rawMaterialDetails removeObjectAtIndex:[sender tag]];
        
        editQuantity_issue = 0;
        editMaterialCost_issue = 0.0f;
        
        for (int i = 0; i < rawMaterialDetails.count; i++) {
            NSArray *material = rawMaterialDetails[i];
            editQuantity_issue = editQuantity_issue + [material[5] intValue];
            editMaterialCost_issue = editMaterialCost_issue + ([material[5] intValue] * [material[2] floatValue]);
        }
        
        totalQunatity.text = [NSString stringWithFormat:@"%d",editQuantity_issue];
        totalCost.text = [NSString stringWithFormat:@"%.2f",editMaterialCost_issue];
        
        [cartTable reloadData];

    }
    @catch (NSException *exception) {
       
        NSLog(@"%@",exception);
        
    }
}


// Commented by roja on 17/10/2019.. // reason : submitButtonPressed method contains SOAP Service call .. so taken new method with same(submitButtonPressed) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//-(void)submitButtonPressed{
//    AudioServicesPlaySystemSound (soundFileObject);
//    // NSString *supplierValue = [supplierID.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    //  NSString *supplierNameValue = [supplierName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    NSString *locationValue = [location.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    NSString *deliveredByValue = [deliveredBy.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    //  NSString *poreferenceValue = [poReference.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    //  NSString *shipmentValue = [shipmentNote.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    NSString *inspectedValue = [inspectedBy.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//
//    if (rawMaterialDetails.count == 0){
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please add items to cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//    }
//    else if (locationValue.length == 0 || deliveredByValue.length == 0 || inspectedValue.length == 0){
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please provide all the details" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//    }
//    else{
//
////        HUD_ = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
////        [self.navigationController.view addSubview:HUD_];
////        // Regiser for HUD callbacks so we can remove it from the window at the right time
////        HUD_.delegate = self;
////        HUD_.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
////        HUD_.mode = MBProgressHUDModeCustomView;
//
//        CheckWifi *wifi = [[CheckWifi alloc]init];
//        BOOL status = [wifi checkWifi];
//
//        if (status) {
//
//
//        // Show the HUD
//        [HUD_ show:YES];
//        [HUD_ setHidden:NO];
//        [HUD_ setHidden:NO];
//        HUD_.labelText = @"Creating Receipt..";
//
//        NSMutableArray *itemcode = [[NSMutableArray alloc] init];
//        NSMutableArray *desc = [[NSMutableArray alloc] init];
//        NSMutableArray *price = [[NSMutableArray alloc] init];
//        NSMutableArray *max_qty = [[NSMutableArray alloc] init];
//        NSMutableArray *cost = [[NSMutableArray alloc] init];
//        //        NSMutableArray *make = [[NSMutableArray alloc] init];
//        NSMutableArray *supplied = [[NSMutableArray alloc] init];
//        NSMutableArray *received = [[NSMutableArray alloc] init];
//        NSMutableArray *rejected = [[NSMutableArray alloc] init];
//        NSMutableArray *skuid = [[NSMutableArray alloc] init];
//            NSMutableArray *pluCode = [[NSMutableArray alloc] init];
//
//         @try {
//
//        for (int i = 0; i < rawMaterialDetails.count; i++) {
//            NSArray *temp = rawMaterialDetails[i];
//            [itemcode addObject:temp[0]];
//            [desc addObject:temp[1]];
//            [price addObject:temp[2]];
//            [max_qty addObject:temp[4]];
//            [cost addObject:temp[9]];
//            [supplied addObject:temp[5]];
//            [received addObject:temp[6]];
//            [rejected addObject:temp[8]];
//            [skuid addObject:temp[0]];
//            [pluCode addObject:temp[10]];
//        }
//
//
//        NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
//        NSMutableDictionary *temp1 = [[NSMutableDictionary alloc]init];
//        NSMutableArray *temparr = [[NSMutableArray alloc]init];
//        NSDictionary *dic = [[NSDictionary alloc] init];
//
//
//        NSMutableDictionary *receiptDetails1 = [[NSMutableDictionary alloc] init];
//        receiptDetails1[@"requestHeader"] = [RequestHeader getRequestHeader];
//
//        receiptDetails1[@"shipped_from"] = presentLocation;
//        receiptDetails1[@"issue_to"] = location.text;
//        receiptDetails1[@"delivered_by"] = deliveredBy.text;
//        NSLog(@"%@",date.text);
//        receiptDetails1[@"deliveryDate"] = date.text;
//        receiptDetails1[@"customerId"] = custID;
//        receiptDetails1[@"Goods_Request_Ref"] = @"";
//        receiptDetails1[@"issue_total"] = totalCost.text;
//        receiptDetails1[@"id_goods_issue"] = [NSString stringWithFormat:@"%d",receipt_id_val_int];
//        receiptDetails1[@"issue_total_qty"] = totalQunatity.text;
//        receiptDetails1[@"Received_by"] = firstName;
//        receiptDetails1[@"InspectedBy"] = inspectedBy.text;
//        receiptDetails1[@"grand_total"] = totalCost.text;
//        receiptDetails1[@"sub_total"] = totalCost.text;
//        receiptDetails1[@"goods_issue_ref_num"] = editFinalReceiptID_issue;
//        receiptDetails1[@"status"] = @"Submitted";
//
//
//        for (int i=0; i < itemcode.count; i++) {
//
//            temp[@"item"] = itemcode[i];
//            temp[@"description"] = desc[i];
//            temp[@"price"] = price[i];
//            temp[@"quantity"] = max_qty[i];
//            temp[@"cost"] = cost[i];
//            temp[@"issued"] = supplied[i];
//            temp[@"recieved"] = received[i];
//            temp[@"rejected"] = rejected[i];
//            temp[@"max_quantity"] = rejected[i];
//            temp[@"skuId"] = skuid[i];
//            temp[@"pluCode"] = pluCode[i];
//
//            dic = [temp copy];
//
//            temp1[[NSString stringWithFormat:@"%d",i]] = dic;
//
//            [temparr addObject:[temp1 valueForKey:[NSString stringWithFormat:@"%d",i]]];
//
//        }
//
//        receiptDetails1[@"reciptDetails"] = temparr;
//
//        //        NSError * err;
//        //        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:orderDetails options:0 error:&err];
//        //        NSString * orderJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//
//        //        NSArray *keys = [NSArray arrayWithObjects:@"receipt_ref_num", @"receipt_total_qty",@"sub_total",@"gst",@"grand_total",@"supplier_id",@"supplier_name",@"location",@"delivered_by",@"date",@"po_reference",@"shipment_note",@"inspected_by",@"itemCode",@"itemDescription",@"pack",@"price",@"cost",@"supplied",@"received",@"rejected",@"make",@"status", nil];
//        //
//        //        NSArray *objects = [NSArray arrayWithObjects:@"", totalQuantity.text,totalCost.text,@"0",totalCost.text,supplierID.text,supplierName.text,location.text,deliveredBy.text,date.text, poReference.text,shipmentNote.text,inspectedBy.text,itemcode,desc,max_qty,price,cost,supplied,received,rejected,make,@"true", nil];
//        //        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
//
//        NSError * err;
//        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:receiptDetails1 options:0 error:&err];
//        NSString * createReceiptJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//        StockIssueServiceSoapBinding *materialBinding = [StockIssueServiceSvc StockIssueServiceSoapBinding] ;
//
//        materialBinding.logXMLInOut = YES;
//
//        StockIssueServiceSvc_updateStockIssue *create_receipt = [[StockIssueServiceSvc_updateStockIssue alloc] init];
//        create_receipt.stockIssueDetails = createReceiptJsonString;
//
//
//
//            StockIssueServiceSoapBindingResponse *response = [materialBinding updateStockIssueUsingParameters:create_receipt];
//            NSArray *responseBodyParts1 = response.bodyParts;
//
//            for (id bodyPart in responseBodyParts1) {
//
//                if ([bodyPart isKindOfClass:[StockIssueServiceSvc_updateStockIssueResponse class]]) {
//
//
//                    [HUD_ setHidden:YES];
//                    StockIssueServiceSvc_updateStockIssueResponse *body = (StockIssueServiceSvc_updateStockIssueResponse *)bodyPart;
//                    printf("\nresponse=%s",(body.return_).UTF8String);
//
//                    // status = body.return_;
//                    NSError *e;
//                    NSDictionary *json1;
//                    NSDictionary *json_issue;
//
//
//                    json1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                            options: NSJSONReadingMutableContainers
//                                                              error: &e];
//
//                    if (json1!=NULL) {
//
//                        json_issue = json1[@"responseHeader"] ;
//                        if ([json_issue[@"responseMessage"] isEqualToString:@"Success"] && [json_issue[@"responseCode"] isEqualToString:@"0"]) {
//                            SystemSoundID    soundFileObject1;
//                            NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
//                            self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
//                            AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
//                            AudioServicesPlaySystemSound (soundFileObject1);
//
//                            location.text = @"";
//                            deliveredBy.text = @"";
//                            inspectedBy.text = @"";
//                            //        poReference.text = @"";
//                            //        shipmentNote.text = @"";
//
//                            [rawMaterials removeAllObjects];
//                            [rawMaterialDetails removeAllObjects];
//                            [cartTable reloadData];
//                            totalCost.text = @"0.0";
//                            totalQunatity.text = @"0";
//
//                            NSString *receiptID = json1[@"issueid"];
//                            issueIdStr = [receiptID copy];
//                            UIAlertView *successAlertView  = [[UIAlertView alloc] init];
//                            successAlertView.delegate = self;
//                            successAlertView.title = @"Material  Issue Submitted Successfully";
//                            successAlertView.message = [NSString stringWithFormat:@"%@%@",@"Receipt ID : ",receiptID];
//                            [successAlertView addButtonWithTitle:@"OK"];
//
//                            [successAlertView show];
//
//                            [HUD_ setHidden:YES];
//
//
//                        }
//                        else {
//                            SystemSoundID    soundFileObject1;
//                            NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
//                            self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
//                            AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
//                            AudioServicesPlaySystemSound (soundFileObject1);
//
//                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed to Submit" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                            [alert show];
//                        }
//
//                    }
//                    else{
//                        SystemSoundID    soundFileObject1;
//                        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
//                        self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
//                        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
//                        AudioServicesPlaySystemSound (soundFileObject1);
//
//                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed to Update" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                        [alert show];
//                    }
//                }
//            }
//        }
//        @catch (NSException *exception) {
//            [HUD_ setHidden:YES];
//            SystemSoundID    soundFileObject1;
//            NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
//            self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
//            AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
//            AudioServicesPlaySystemSound (soundFileObject1);
//
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed to Update" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//
//
//        }
//
//
//
//        [HUD_ setHidden:YES];
//        //        supplierID.text = @"";
//        //        supplierName.text = @"";
//
//    }
//        else {
//
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Please enable wifi or mobile data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//        }
//    }
//}



// Commented by roja on 17/10/2019.. // reason : cancelButtonPressed method contains SOAP Service call .. so taken new method with same(cancelButtonPressed) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//-(void)cancelButtonPressed{
//
//    AudioServicesPlaySystemSound (soundFileObject);
//
//    if ([self.view.subviews containsObject:skListTable]) {
//
//        [skListTable setHidden:YES];
//    }
//
//    // NSString *supplierValue = [supplierID.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    //  NSString *supplierNameValue = [supplierName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    //    NSString *locationValue = [location.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    //    NSString *deliveredByValue = [deliveredBy.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    //    //  NSString *poreferenceValue = [poReference.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    //    //  NSString *shipmentValue = [shipmentNote.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    //    NSString *inspectedValue = [inspectedBy.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//
//    if (rawMaterialDetails.count == 0){
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please add items to cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//    }
//    //    else if ([locationValue length] == 0 || [deliveredByValue length] == 0 || [inspectedValue length] == 0){
//    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please provide all the details" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    //        [alert show];
//    //        [alert release];
//    //    }
//    else{
//
////        HUD_ = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
////        [self.navigationController.view addSubview:HUD_];
////        // Regiser for HUD callbacks so we can remove it from the window at the right time
////        HUD_.delegate = self;
////        HUD_.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
////        HUD_.mode = MBProgressHUDModeCustomView;
//
//        CheckWifi *wifi = [[CheckWifi alloc]init];
//        BOOL status = [wifi checkWifi];
//
//        if (status) {
//
//        // Show the HUD
//        [HUD_ show:YES];
//        [HUD_ setHidden:NO];
//        [HUD_ setHidden:NO];
//        HUD_.labelText = @"Saving Receipt..";
//
//        NSMutableArray *itemcode = [[NSMutableArray alloc] init];
//        NSMutableArray *desc = [[NSMutableArray alloc] init];
//        NSMutableArray *price = [[NSMutableArray alloc] init];
//        NSMutableArray *max_qty = [[NSMutableArray alloc] init];
//        NSMutableArray *cost = [[NSMutableArray alloc] init];
//        //        NSMutableArray *make = [[NSMutableArray alloc] init];
//        NSMutableArray *supplied = [[NSMutableArray alloc] init];
//        NSMutableArray *received = [[NSMutableArray alloc] init];
//        NSMutableArray *rejected = [[NSMutableArray alloc] init];
//        NSMutableArray *skuid = [[NSMutableArray alloc] init];
//            NSMutableArray *pluCode = [[NSMutableArray alloc] init];
//
//
//        for (int i = 0; i < rawMaterialDetails.count; i++) {
//            NSArray *temp = rawMaterialDetails[i];
//            [itemcode addObject:temp[0]];
//            [desc addObject:temp[1]];
//            [price addObject:temp[2]];
//            [max_qty addObject:temp[4]];
//            [cost addObject:temp[9]];
//            [supplied addObject:temp[5]];
//            [received addObject:temp[6]];
//            [rejected addObject:temp[8]];
//            [skuid addObject:temp[0]];
//            [pluCode addObject:temp[10]];
//        }
//
//
//        NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
//        NSMutableDictionary *temp1 = [[NSMutableDictionary alloc]init];
//        NSMutableArray *temparr = [[NSMutableArray alloc]init];
//        NSDictionary *dic = [[NSDictionary alloc] init];
//
//
//        NSMutableDictionary *receiptDetails1 = [[NSMutableDictionary alloc] init];
//        receiptDetails1[@"requestHeader"] = [RequestHeader getRequestHeader];
//
//        receiptDetails1[@"shipped_from"] = presentLocation;
//        receiptDetails1[@"issue_to"] = location.text;
//        receiptDetails1[@"delivered_by"] = deliveredBy.text;
//        receiptDetails1[@"deliveryDate"] = date.text;
//        receiptDetails1[@"customerId"] = custID;
//        receiptDetails1[@"Goods_Request_Ref"] = @"";
//        receiptDetails1[@"issue_total"] = totalCost.text;
//        receiptDetails1[@"issue_total_qty"] = totalQunatity.text;
//        receiptDetails1[@"Received_by"] = firstName;
//        receiptDetails1[@"InspectedBy"] = inspectedBy.text;
//        receiptDetails1[@"grand_total"] = totalCost.text;
//        receiptDetails1[@"sub_total"] = totalCost.text;
//        receiptDetails1[@"id_goods_issue"] = [NSString stringWithFormat:@"%d",receipt_id_val_int];
//        receiptDetails1[@"goods_issue_ref_num"] = editFinalReceiptID_issue;
//        receiptDetails1[@"status"] = @"Pending";
//
//
//        for (int i=0; i < itemcode.count; i++) {
//
//            temp[@"item"] = itemcode[i];
//            temp[@"description"] = desc[i];
//            temp[@"price"] = price[i];
//            temp[@"quantity"] = max_qty[i];
//            temp[@"cost"] = cost[i];
//            //            [temp setObject:[supplied objectAtIndex:i] forKey:@"issued"];
//            temp[@"recieved"] = received[i];
//            temp[@"rejected"] = rejected[i];
//            temp[@"max_quantity"] = rejected[i];
//            temp[@"skuId"] = skuid[i];
//            temp[@"pluCode"] = pluCode[i];
//
//
//            dic = [temp copy];
//
//            temp1[[NSString stringWithFormat:@"%d",i]] = dic;
//
//            [temparr addObject:[temp1 valueForKey:[NSString stringWithFormat:@"%d",i]]];
//
//        }
//
//        receiptDetails1[@"reciptDetails"] = temparr;
//
//        //        NSError * err;
//        //        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:orderDetails options:0 error:&err];
//        //        NSString * orderJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//
//        //        NSArray *keys = [NSArray arrayWithObjects:@"receipt_ref_num", @"receipt_total_qty",@"sub_total",@"gst",@"grand_total",@"supplier_id",@"supplier_name",@"location",@"delivered_by",@"date",@"po_reference",@"shipment_note",@"inspected_by",@"itemCode",@"itemDescription",@"pack",@"price",@"cost",@"supplied",@"received",@"rejected",@"make",@"status", nil];
//        //
//        //        NSArray *objects = [NSArray arrayWithObjects:@"", totalQuantity.text,totalCost.text,@"0",totalCost.text,supplierID.text,supplierName.text,location.text,deliveredBy.text,date.text, poReference.text,shipmentNote.text,inspectedBy.text,itemcode,desc,max_qty,price,cost,supplied,received,rejected,make,@"true", nil];
//        //        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
//
//        NSError * err;
//        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:receiptDetails1 options:0 error:&err];
//        NSString * createReceiptJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//        StockIssueServiceSoapBinding *materialBinding = [StockIssueServiceSvc StockIssueServiceSoapBinding] ;
//
//        StockIssueServiceSvc_updateStockIssue *create_receipt = [[StockIssueServiceSvc_updateStockIssue alloc] init];
//        create_receipt.stockIssueDetails = createReceiptJsonString;
//
//        @try {
//
//            StockIssueServiceSoapBindingResponse *response = [materialBinding updateStockIssueUsingParameters:create_receipt];
//            NSArray *responseBodyParts1 = response.bodyParts;
//
//            for (id bodyPart in responseBodyParts1) {
//
//                if ([bodyPart isKindOfClass:[StockIssueServiceSvc_updateStockIssueResponse class]]) {
//
//
//                    [HUD_ setHidden:YES];
//                    StockIssueServiceSvc_updateStockIssueResponse *body = (StockIssueServiceSvc_updateStockIssueResponse *)bodyPart;
//                    printf("\nresponse=%s",(body.return_).UTF8String);
//
//                    // status = body.return_;
//                    NSError *e;
//                    NSDictionary *json1;
//                    NSDictionary *json_issue;
//
//
//                    json1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                            options: NSJSONReadingMutableContainers
//                                                              error: &e];
//
//                    if (json1!=NULL) {
//
//                        json_issue = json1[@"responseHeader"];
//                        if ([json_issue[@"responseMessage"] isEqualToString:@"Success"]) {
//
//                            location.text = @"";
//                            deliveredBy.text = @"";
//                            inspectedBy.text = @"";
//                            //        poReference.text = @"";
//                            //        shipmentNote.text = @"";
//
//                            [rawMaterials removeAllObjects];
//                            [rawMaterialDetails removeAllObjects];
//                            [cartTable reloadData];
//                            totalCost.text = @"0.0";
//                            totalQunatity.text = @"0";
//
//                            NSString *receiptID = json1[@"issueid"];
//                            issueIdStr = [receiptID copy];
//                            UIAlertView *successAlertView  = [[UIAlertView alloc] init];
//                            successAlertView.delegate = self;
//                            successAlertView.title = @"Material  Issue Saved Successfully";
//                            successAlertView.message = [NSString stringWithFormat:@"%@%@",@"Receipt ID : ",receiptID];
//                            [successAlertView addButtonWithTitle:@"OK"];
//
//                            [successAlertView show];
//
//                            [HUD_ setHidden:YES];
//
//
//                        }
//                        else {
//                            SystemSoundID    soundFileObject1;
//                            NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
//                            self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
//                            AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
//                            AudioServicesPlaySystemSound (soundFileObject1);
//
//                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed to Save" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                            [alert show];
//                        }
//
//                    }
//                    else{
//                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed to Save" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                        [alert show];
//                    }
//                }
//            }
//        }
//        @catch (NSException *exception) {
//
//            [HUD_ setHidden:YES];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed to Save" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//
//        }
//
//
//        [HUD_ setHidden:YES];
//        //        supplierID.text = @"";
//        //        supplierName.text = @"";
//
//    }
//        else {
//
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Please enable wifi or mobile data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//        }
//    }
//}


//submitButtonPressed method changed by roja on 17/10/2019.. // reason : removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST

-(void)submitButtonPressed{
    
    AudioServicesPlaySystemSound (soundFileObject);
    // NSString *supplierValue = [supplierID.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //  NSString *supplierNameValue = [supplierName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *locationValue = [location.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *deliveredByValue = [deliveredBy.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //  NSString *poreferenceValue = [poReference.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //  NSString *shipmentValue = [shipmentNote.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *inspectedValue = [inspectedBy.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (rawMaterialDetails.count == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please add items to cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if (locationValue.length == 0 || deliveredByValue.length == 0 || inspectedValue.length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please provide all the details" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else{
        
        CheckWifi *wifi = [[CheckWifi alloc]init];
        BOOL status = [wifi checkWifi];
        
        if (status) {
            
            // Show the HUD
            [HUD_ show:YES];
            [HUD_ setHidden:NO];
            HUD_.labelText = @"Creating Receipt..";
            
            isCancelBtnSelected = false;

            NSMutableArray *itemcode = [[NSMutableArray alloc] init];
            NSMutableArray *desc = [[NSMutableArray alloc] init];
            NSMutableArray *price = [[NSMutableArray alloc] init];
            NSMutableArray *max_qty = [[NSMutableArray alloc] init];
            NSMutableArray *cost = [[NSMutableArray alloc] init];
            //        NSMutableArray *make = [[NSMutableArray alloc] init];
            NSMutableArray *supplied = [[NSMutableArray alloc] init];
            NSMutableArray *received = [[NSMutableArray alloc] init];
            NSMutableArray *rejected = [[NSMutableArray alloc] init];
            NSMutableArray *skuid = [[NSMutableArray alloc] init];
            NSMutableArray *pluCode = [[NSMutableArray alloc] init];
            
            @try {
                
                for (int i = 0; i < rawMaterialDetails.count; i++) {
                    NSArray *temp = rawMaterialDetails[i];
                    [itemcode addObject:temp[0]];
                    [desc addObject:temp[1]];
                    [price addObject:temp[2]];
                    [max_qty addObject:temp[4]];
                    [cost addObject:temp[9]];
                    [supplied addObject:temp[5]];
                    [received addObject:temp[6]];
                    [rejected addObject:temp[8]];
                    [skuid addObject:temp[0]];
                    [pluCode addObject:temp[10]];
                }
                
                
                NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
                NSMutableDictionary *temp1 = [[NSMutableDictionary alloc]init];
                NSMutableArray *temparr = [[NSMutableArray alloc]init];
                NSDictionary *dic = [[NSDictionary alloc] init];
                
                
                NSMutableDictionary *receiptDetails1 = [[NSMutableDictionary alloc] init];
                receiptDetails1[@"requestHeader"] = [RequestHeader getRequestHeader];
                
                receiptDetails1[@"shipped_from"] = presentLocation;
                receiptDetails1[@"issue_to"] = location.text;
                receiptDetails1[@"delivered_by"] = deliveredBy.text;
                NSLog(@"%@",date.text);
                receiptDetails1[@"deliveryDate"] = date.text;
                receiptDetails1[@"customerId"] = custID;
                receiptDetails1[@"Goods_Request_Ref"] = @"";
                receiptDetails1[@"issue_total"] = totalCost.text;
                receiptDetails1[@"id_goods_issue"] = [NSString stringWithFormat:@"%d",receipt_id_val_int];
                receiptDetails1[@"issue_total_qty"] = totalQunatity.text;
                receiptDetails1[@"Received_by"] = firstName;
                receiptDetails1[@"InspectedBy"] = inspectedBy.text;
                receiptDetails1[@"grand_total"] = totalCost.text;
                receiptDetails1[@"sub_total"] = totalCost.text;
                receiptDetails1[@"goods_issue_ref_num"] = editFinalReceiptID_issue;
                receiptDetails1[@"status"] = @"Submitted";
                
                
                for (int i=0; i < itemcode.count; i++) {
                    
                    temp[@"item"] = itemcode[i];
                    temp[@"description"] = desc[i];
                    temp[@"price"] = price[i];
                    temp[@"quantity"] = max_qty[i];
                    temp[@"cost"] = cost[i];
                    temp[@"issued"] = supplied[i];
                    temp[@"recieved"] = received[i];
                    temp[@"rejected"] = rejected[i];
                    temp[@"max_quantity"] = rejected[i];
                    temp[@"skuId"] = skuid[i];
                    temp[@"pluCode"] = pluCode[i];
                    
                    dic = [temp copy];
                    
                    temp1[[NSString stringWithFormat:@"%d",i]] = dic;
                    
                    [temparr addObject:[temp1 valueForKey:[NSString stringWithFormat:@"%d",i]]];
                    
                }
                receiptDetails1[@"reciptDetails"] = temparr;
                
                NSError * err;
                NSData * jsonData = [NSJSONSerialization dataWithJSONObject:receiptDetails1 options:0 error:&err];
                NSString * createReceiptJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                
                WebServiceController * services = [[WebServiceController alloc] init];
                services.stockIssueDelegate = self;
                [services upDateStockIssue:jsonData];
                
            }
            @catch (NSException *exception) {
                [HUD_ setHidden:YES];
                SystemSoundID    soundFileObject1;
                NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
                self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
                AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                AudioServicesPlaySystemSound (soundFileObject1);
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed to Update" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            
        }
        else {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Please enable wifi or mobile data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}


//cancelButtonPressed method changed by roja on 17/10/2019.. // reason : removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST
-(void)cancelButtonPressed{
    
    AudioServicesPlaySystemSound (soundFileObject);
    
    if ([self.view.subviews containsObject:skListTable]) {
        
        [skListTable setHidden:YES];
    }
    
    if (rawMaterialDetails.count == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please add items to cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
   
    else{
        
        CheckWifi *wifi = [[CheckWifi alloc]init];
        BOOL status = [wifi checkWifi];
        
        if (status) {
            
            // Show the HUD
            [HUD_ show:YES];
            [HUD_ setHidden:NO];
            HUD_.labelText = @"Saving Receipt..";
            
            isCancelBtnSelected = true;
            
            NSMutableArray *itemcode = [[NSMutableArray alloc] init];
            NSMutableArray *desc = [[NSMutableArray alloc] init];
            NSMutableArray *price = [[NSMutableArray alloc] init];
            NSMutableArray *max_qty = [[NSMutableArray alloc] init];
            NSMutableArray *cost = [[NSMutableArray alloc] init];
            //        NSMutableArray *make = [[NSMutableArray alloc] init];
            NSMutableArray *supplied = [[NSMutableArray alloc] init];
            NSMutableArray *received = [[NSMutableArray alloc] init];
            NSMutableArray *rejected = [[NSMutableArray alloc] init];
            NSMutableArray *skuid = [[NSMutableArray alloc] init];
            NSMutableArray *pluCode = [[NSMutableArray alloc] init];
            
            
            for (int i = 0; i < rawMaterialDetails.count; i++) {
                NSArray *temp = rawMaterialDetails[i];
                [itemcode addObject:temp[0]];
                [desc addObject:temp[1]];
                [price addObject:temp[2]];
                [max_qty addObject:temp[4]];
                [cost addObject:temp[9]];
                [supplied addObject:temp[5]];
                [received addObject:temp[6]];
                [rejected addObject:temp[8]];
                [skuid addObject:temp[0]];
                [pluCode addObject:temp[10]];
            }
            
            
            NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
            NSMutableDictionary *temp1 = [[NSMutableDictionary alloc]init];
            NSMutableArray *temparr = [[NSMutableArray alloc]init];
            NSDictionary *dic = [[NSDictionary alloc] init];
            
            
            NSMutableDictionary *receiptDetails1 = [[NSMutableDictionary alloc] init];
            receiptDetails1[@"requestHeader"] = [RequestHeader getRequestHeader];
            
            receiptDetails1[@"shipped_from"] = presentLocation;
            receiptDetails1[@"issue_to"] = location.text;
            receiptDetails1[@"delivered_by"] = deliveredBy.text;
            receiptDetails1[@"deliveryDate"] = date.text;
            receiptDetails1[@"customerId"] = custID;
            receiptDetails1[@"Goods_Request_Ref"] = @"";
            receiptDetails1[@"issue_total"] = totalCost.text;
            receiptDetails1[@"issue_total_qty"] = totalQunatity.text;
            receiptDetails1[@"Received_by"] = firstName;
            receiptDetails1[@"InspectedBy"] = inspectedBy.text;
            receiptDetails1[@"grand_total"] = totalCost.text;
            receiptDetails1[@"sub_total"] = totalCost.text;
            receiptDetails1[@"id_goods_issue"] = [NSString stringWithFormat:@"%d",receipt_id_val_int];
            receiptDetails1[@"goods_issue_ref_num"] = editFinalReceiptID_issue;
            receiptDetails1[@"status"] = @"Pending";
            
            
            for (int i=0; i < itemcode.count; i++) {
                
                temp[@"item"] = itemcode[i];
                temp[@"description"] = desc[i];
                temp[@"price"] = price[i];
                temp[@"quantity"] = max_qty[i];
                temp[@"cost"] = cost[i];
                //            [temp setObject:[supplied objectAtIndex:i] forKey:@"issued"];
                temp[@"recieved"] = received[i];
                temp[@"rejected"] = rejected[i];
                temp[@"max_quantity"] = rejected[i];
                temp[@"skuId"] = skuid[i];
                temp[@"pluCode"] = pluCode[i];
                
                
                dic = [temp copy];
                
                temp1[[NSString stringWithFormat:@"%d",i]] = dic;
                
                [temparr addObject:[temp1 valueForKey:[NSString stringWithFormat:@"%d",i]]];
                
            }
            
            receiptDetails1[@"reciptDetails"] = temparr;
        
            NSError * err;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:receiptDetails1 options:0 error:&err];
            NSString * createReceiptJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            WebServiceController* services = [[WebServiceController alloc] init];
            services.storeServiceDelegate = self;
            [services upDateStockIssue:jsonData];
        }
        else {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Please enable wifi or mobile data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}


// added by Roja on 17/10/2019…. // OLd code only added below
- (void)updateStockIssueSuccessResponse:(NSDictionary *)sucessDictionary{
    
    @try {
        if(isCancelBtnSelected){ // This condition is for Cancel Btn,..
            
            location.text = @"";
            deliveredBy.text = @"";
            inspectedBy.text = @"";
            //        poReference.text = @"";
            //        shipmentNote.text = @"";
            
            [rawMaterials removeAllObjects];
            [rawMaterialDetails removeAllObjects];
            [cartTable reloadData];
            totalCost.text = @"0.0";
            totalQunatity.text = @"0";
            
            NSString *receiptID = sucessDictionary[@"issueid"];
            issueIdStr = [receiptID copy];
            UIAlertView *successAlertView  = [[UIAlertView alloc] init];
            successAlertView.delegate = self;
            successAlertView.title = @"Material  Issue Saved Successfully";
            successAlertView.message = [NSString stringWithFormat:@"%@%@",@"Receipt ID : ",receiptID];
            [successAlertView addButtonWithTitle:@"OK"];
            
            [successAlertView show];
            
        }
        
        else {// This condition is for Submit Btn,..
            
            SystemSoundID    soundFileObject1;
            NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
            self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
            AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
            AudioServicesPlaySystemSound (soundFileObject1);
            
            location.text = @"";
            deliveredBy.text = @"";
            inspectedBy.text = @"";
            //        poReference.text = @"";
            //        shipmentNote.text = @"";
            
            [rawMaterials removeAllObjects];
            [rawMaterialDetails removeAllObjects];
            [cartTable reloadData];
            totalCost.text = @"0.0";
            totalQunatity.text = @"0";
            
            NSString *receiptID = sucessDictionary[@"issueid"];
            issueIdStr = [receiptID copy];
            UIAlertView *successAlertView  = [[UIAlertView alloc] init];
            successAlertView.delegate = self;
            successAlertView.title = @"Material  Issue Submitted Successfully";
            successAlertView.message = [NSString stringWithFormat:@"%@%@",@"Receipt ID : ",receiptID];
            [successAlertView addButtonWithTitle:@"OK"];
            
            [successAlertView show];
            
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD_ setHidden:YES];
    }
}

// added by Roja on 17/10/2019…. // OLd code only added below
- (void)updateStockIssueErrorResponse:(NSString *)error{
    
    @try {
        NSString * alertMSgStr = @"";
        if(isCancelBtnSelected){ // This condition is for Cancel Btn,..
            
            alertMSgStr = @"Failed to Save";
        }
        else {// This condition is for Submit Btn,..
            
            alertMSgStr = @"Failed to Submit";
        }
        
        SystemSoundID    soundFileObject1;
        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
        self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
        AudioServicesPlaySystemSound (soundFileObject1);
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:alertMSgStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD_ setHidden:YES];
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
    
    if (textField == qtyFeild) {
        
        NSUInteger lengthOfString = string.length;
        for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {
            unichar character = [string characterAtIndex:loopIndex];
            if (character < 48) return NO; // 48 unichar for 0
            if (character > 57) return NO; // 57 unichar for 9
        }
        
    }
    
    if (textField == rejecQtyField) {
        
        NSUInteger lengthOfString = string.length;
        for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {
            unichar character = [string characterAtIndex:loopIndex];
            if (character < 48) return NO; // 48 unichar for 0
            if (character > 57) return NO; // 57 unichar for 9
        }
        
    }
    return YES;
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    AudioServicesPlaySystemSound (soundFileObject);
    if ([alertView.title isEqualToString:@"Material  Issue Submitted Successfully"]) {
        if (buttonIndex == 0) {
            OmniHomePage *home = [[OmniHomePage alloc]init];
            [self.navigationController pushViewController:home animated:YES];
        }
        else{
            alertView.hidden = YES;
        }
    }
    else if ([alertView.title isEqualToString:@"Material  Issue Saved Successfully"]){
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
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        else {
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        }
        
    }
}

-(void)backAction {
    if (rawMaterialDetails.count>0) {
        
        warning = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"You will lose data you entered.\n Do you want to exit?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
        [warning show];
    }
    else {
        OmniHomePage *home = [[OmniHomePage alloc]init];
        [self.navigationController pushViewController:home animated:YES];
    }
    
}
-(void)viewWillDisappear:(BOOL)animated {
    
    if (rawMaterialDetails.count>0) {
        
        [rawMaterials removeAllObjects];
        [rawMaterialDetails removeAllObjects];
    }
    
    [skListTable reloadData];
    [cartTable reloadData];
    
}
-(void)homeButonClicked {
    
    OmniHomePage *home = [[OmniHomePage alloc]init];
    [self.navigationController pushViewController:home animated:YES];
    
}

-(void)closePriceView:(UIButton *)sender {
    transparentView.hidden = YES;
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
