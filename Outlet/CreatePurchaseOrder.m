//
//  CreatePurchaseOrder.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/9/15.
//
//

#import "CreatePurchaseOrder.h"
#import <QuartzCore/QuartzCore.h>
#import "BarcodeType.h"
#import "Global.h"
#import "SkuServiceSvc.h"
#import "purchaseOrdersSvc.h"
#import "ViewPurchaseOrder.h"
#import "SupplierServiceSvc.h"
#import "OmniHomePage.h"
#import "UtilityMasterServiceSvc.h"
#import "RequestHeader.h"

@interface CreatePurchaseOrder ()

@end

@implementation CreatePurchaseOrder

@synthesize customerCode,customerName;
@synthesize phNo;
@synthesize soundFileURLRef,soundFileObject;

UIButton  *dueDateButton;
UIButton  *locationButton;
UIButton *orderDateButton;
UIButton *orderChannnelButton;
UIButton *orderDeliveryTypeButton;
UIButton  *paymentModeButton;
UIButton *paymentTypeButton;
UIButton  *shipoModeButton;
UIDatePicker *myPicker;
CustomTextField *orderShipCharges;

BOOL newItem__ = YES;
NSString *purchaseOrderID_ = @"";

int purchaseCount1_ = 0;
int purchaseCount2_ = 1;
int purchaseCount3_ = 0;
UILabel *recStart;
UILabel *recEnd;
UILabel *totalRec;
UILabel *label1_;
UILabel *label2_;

BOOL purchaseCountValue_ = YES;

int purchaseChangeNum_ = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    version = [UIDevice currentDevice].systemVersion.floatValue;
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    self.titleLabel.text = @"PURCHASE ORDER";
    
    self.view.backgroundColor = [UIColor blackColor];
    
    supplierList = [[NSMutableArray alloc] init];
    supplierCode = [[NSMutableArray alloc] init];
    poShipmentLocationArr = [[NSMutableArray alloc] init];
    locationWiseItemArr = [[NSMutableArray alloc] init];
    
    supplierTable = [[UITableView alloc] init];
    supplierTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    supplierTable.dataSource = self;
    supplierTable.delegate = self;
    (supplierTable.layer).borderWidth = 1.0f;
    supplierTable.layer.cornerRadius = 3;
    supplierTable.layer.borderColor = [UIColor grayColor].CGColor;
    
    NSArray *segmentLabels;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
       segmentLabels = @[@"New Purchase Order",@"View Purchase Orders"];
    }
    else {
        
        segmentLabels = @[@"New Order",@"View Orders"];

    }
    
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
    
    /** UIScrollView Design */
    scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.bounces = FALSE;
    
    /** UIScrollView Design */
    orderTableScrollView = [[UIScrollView alloc] init];
    orderTableScrollView.backgroundColor = [UIColor clearColor];
    orderTableScrollView.bounces = FALSE;
    
    
    locationTable = [[UITableView alloc] init];
    locationTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    locationTable.dataSource = self;
    locationTable.delegate = self;
    (locationTable.layer).borderWidth = 1.0f;
    locationTable.layer.cornerRadius = 3;
    locationTable.layer.borderColor = [UIColor grayColor].CGColor;
    locationTable.hidden = YES;

    /** Custmor Fields Design*/
    
    customerCode = [[CustomTextField alloc] init];
    customerCode.borderStyle = UITextBorderStyleRoundedRect;
    customerCode.textColor = [UIColor blackColor];
    customerCode.placeholder = @"Supplier ID";
    customerCode.backgroundColor = [UIColor whiteColor];
    customerCode.clearButtonMode = UITextFieldViewModeWhileEditing;
    customerCode.backgroundColor = [UIColor whiteColor];
    customerCode.autocorrectionType = UITextAutocorrectionTypeNo;
    customerCode.keyboardType = UIKeyboardTypeDefault;
    customerCode.returnKeyType = UIReturnKeyDone;
    customerCode.delegate = self;
    [customerCode awakeFromNib];

    
    customerName = [[CustomTextField alloc] init];
    customerName.borderStyle = UITextBorderStyleRoundedRect;
    customerName.textColor = [UIColor blackColor];
    customerName.placeholder = @"Supplier Name";
    customerName.backgroundColor = [UIColor whiteColor];
    customerName.clearButtonMode = UITextFieldViewModeWhileEditing;
    customerName.backgroundColor = [UIColor whiteColor];
    customerName.autocorrectionType = UITextAutocorrectionTypeNo;
    customerName.keyboardType = UIKeyboardTypeDefault;
    customerName.returnKeyType = UIReturnKeyDone;
    customerName.delegate = self;
    [customerName addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [customerName awakeFromNib];
    
    executiveName = [[CustomTextField alloc] init];
    executiveName.borderStyle = UITextBorderStyleRoundedRect;
    executiveName.textColor = [UIColor blackColor];
    executiveName.placeholder = @"Supplier Contact Name";
    executiveName.backgroundColor = [UIColor whiteColor];
    executiveName.clearButtonMode = UITextFieldViewModeWhileEditing;
    executiveName.backgroundColor = [UIColor whiteColor];
    executiveName.autocorrectionType = UITextAutocorrectionTypeNo;
    executiveName.keyboardType = UIKeyboardTypeDefault;
    executiveName.returnKeyType = UIReturnKeyDone;
    executiveName.delegate = self;
    [executiveName awakeFromNib];
    
    /** SearchBarItem*/
    searchItem = [[UITextField alloc] init];
    searchItem.borderStyle = UITextBorderStyleRoundedRect;
    searchItem.textColor = [UIColor blackColor];
    searchItem.placeholder = @"Enter Item";
    searchItem.backgroundColor = [UIColor whiteColor];
    searchItem.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchItem.backgroundColor = [UIColor whiteColor];
    searchItem.autocorrectionType = UITextAutocorrectionTypeNo;
    searchItem.keyboardType = UIKeyboardTypeDefault;
    searchItem.returnKeyType = UIReturnKeyDone;
    [searchItem addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [scrollView addSubview:searchItem];
    searchItem.delegate = self;
    
    
    /** Search Button*/
    searchBtton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtton addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventTouchDown];
    [searchBtton setTitle:@"Search" forState:UIControlStateNormal];
    searchBtton.backgroundColor = [UIColor grayColor];
    
    
    /**table header labels */
    
    UILabel *label1 = [[UILabel alloc] init] ;
    label1.text = @"Item";
    label1.layer.cornerRadius = 12;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.layer.masksToBounds = YES;
    
    label1.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label1.textColor = [UIColor whiteColor];
    //[self.view addSubview:scrollView];
    
    UILabel *label5 = [[UILabel alloc] init] ;
    label5.text = @"Desc";
    label5.layer.cornerRadius = 12;
    label5.textAlignment = NSTextAlignmentCenter;
    label5.layer.masksToBounds = YES;
    
    label5.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label5.textColor = [UIColor whiteColor];
    
    UILabel *label2 = [[UILabel alloc] init] ;
    label2.text = @"Price";
    label2.layer.cornerRadius = 12;
    label2.layer.masksToBounds = YES;
    label2.textAlignment = NSTextAlignmentCenter;
    label2.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label2.textColor = [UIColor whiteColor];
    //[self.view addSubview:scrollView];
    
    UILabel *label3 = [[UILabel alloc] init] ;
    label3.text = @"Qty";
    label3.layer.cornerRadius = 12;
    label3.layer.masksToBounds = YES;
    label3.textAlignment = NSTextAlignmentCenter;
    label3.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label3.textColor = [UIColor whiteColor];
    //[self.view addSubview:scrollView];
    
    UILabel *label4 = [[UILabel alloc] init] ;
    label4.text = @"Total";
    label4.layer.cornerRadius = 12;
    label4.layer.masksToBounds = YES;
    label4.textAlignment = NSTextAlignmentCenter;
    label4.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label4.textColor = [UIColor whiteColor];
    //[self.view addSubview:scrollView];
    
    
    
    dueDate = [[CustomTextField alloc] init];
    dueDate.borderStyle = UITextBorderStyleRoundedRect;
    dueDate.textColor = [UIColor blackColor];
    dueDate.placeholder = @"Delivery Date";
    dueDate.backgroundColor = [UIColor whiteColor];
    dueDate.keyboardType = UIKeyboardTypeDefault;
    dueDate.clearButtonMode = UITextFieldViewModeWhileEditing;
    dueDate.autocorrectionType = UITextAutocorrectionTypeNo;
    dueDate.returnKeyType = UIReturnKeyDone;
    //[self.view addSubview:scrollView];
    dueDate.userInteractionEnabled = NO;
    dueDate.delegate = self;
    [dueDate awakeFromNib];
    
    
    dueDateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImageDD = [UIImage imageNamed:@"combo.png"];
    [dueDateButton setBackgroundImage:buttonImageDD forState:UIControlStateNormal];
    [dueDateButton addTarget:self
                      action:@selector(dueDateButtonPressed:) forControlEvents:UIControlEventTouchDown];
    dueDateButton.tag = 0;

    locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImageDD_ = [UIImage imageNamed:@"combo.png"];
    [locationButton setBackgroundImage:buttonImageDD_ forState:UIControlStateNormal];
    [locationButton addTarget:self
                      action:@selector(getListOfLocations:) forControlEvents:UIControlEventTouchDown];
    locationButton.tag = 1;
//[self.view addSubview:scrollView];
    
    shipment_location = [[CustomTextField alloc] init];
//    shipment_location.borderStyle = UITextBorderStyleRoundedRect;
//    shipment_location.textColor = [UIColor blackColor];
    shipment_location.placeholder = @"Shipment Location";
//    shipment_location.backgroundColor = [UIColor whiteColor];
//    shipment_location.keyboardType = UIKeyboardTypeDefault;
//    shipment_location.clearButtonMode = UITextFieldViewModeWhileEditing;
//    shipment_location.autocorrectionType = UITextAutocorrectionTypeNo;
//    shipment_location.returnKeyType = UIReturnKeyDone;
//    //[self.view addSubview:scrollView];
//    shipment_location.userInteractionEnabled = YES;
//    shipment_location.delegate = self;
    [shipment_location awakeFromNib];

    
    shipment_city = [[CustomTextField alloc] init];
    shipment_city.borderStyle = UITextBorderStyleRoundedRect;
    shipment_city.textColor = [UIColor blackColor];
    shipment_city.placeholder = @"Shipment City";
//    shipment_city.backgroundColor = [UIColor whiteColor];
    shipment_city.keyboardType = UIKeyboardTypeDefault;
    shipment_city.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipment_city.autocorrectionType = UITextAutocorrectionTypeNo;
    shipment_city.returnKeyType = UIReturnKeyDone;
    //[self.view addSubview:scrollView];
    shipment_city.userInteractionEnabled = YES;
    shipment_city.delegate = self;
    [shipment_city awakeFromNib];

    
    shipment_street = [[CustomTextField alloc] init];
    shipment_street.borderStyle = UITextBorderStyleRoundedRect;
    shipment_street.textColor = [UIColor blackColor];
    shipment_street.placeholder = @"Shipment Street";
//    shipment_street.backgroundColor = [UIColor whiteColor];
    shipment_street.keyboardType = UIKeyboardTypeDefault;
    shipment_street.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipment_street.autocorrectionType = UITextAutocorrectionTypeNo;
    shipment_street.returnKeyType = UIReturnKeyDone;
    //[self.view addSubview:scrollView];
    shipment_street.userInteractionEnabled = YES;
    shipment_street.delegate = self;
    [shipment_street awakeFromNib];

    
    shipmentID = [[CustomTextField alloc] init];
    shipmentID.borderStyle = UITextBorderStyleRoundedRect;
    shipmentID.textColor = [UIColor blackColor];
    shipmentID.placeholder = @"Order Submitted By";
//    shipmentID.backgroundColor = [UIColor whiteColor];
    shipmentID.keyboardType = UIKeyboardTypeDefault;
    shipmentID.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentID.autocorrectionType = UITextAutocorrectionTypeNo;
    shipmentID.returnKeyType = UIReturnKeyDone;
    //[self.view addSubview:scrollView];
    shipmentID.userInteractionEnabled = YES;
    shipmentID.delegate = self;
    [shipmentID awakeFromNib];
    
    saleLocation = [[CustomTextField alloc] init];
    saleLocation.borderStyle = UITextBorderStyleRoundedRect;
    saleLocation.textColor = [UIColor blackColor];
    saleLocation.placeholder = @"Order Approved By";
//    saleLocation.backgroundColor = [UIColor whiteColor];
    saleLocation.keyboardType = UIKeyboardTypeDefault;
    saleLocation.clearButtonMode = UITextFieldViewModeWhileEditing;
    saleLocation.autocorrectionType = UITextAutocorrectionTypeNo;
    saleLocation.returnKeyType = UIReturnKeyDone;
    //[self.view addSubview:scrollView];
    saleLocation.userInteractionEnabled = YES;
    saleLocation.delegate = self;
    [saleLocation awakeFromNib];
    
    orderShipCharges = [[CustomTextField alloc] init];
    orderShipCharges.borderStyle = UITextBorderStyleRoundedRect;
    orderShipCharges.textColor = [UIColor blackColor];
    orderShipCharges.placeholder = @"Shipment Charges";
    //    saleLocation.backgroundColor = [UIColor whiteColor];
    orderShipCharges.keyboardType = UIKeyboardTypeNumberPad;
    orderShipCharges.clearButtonMode = UITextFieldViewModeWhileEditing;
    orderShipCharges.autocorrectionType = UITextAutocorrectionTypeNo;
    orderShipCharges.returnKeyType = UIReturnKeyDone;
    //[orderShipCharges addSubview:scrollView];
    orderShipCharges.userInteractionEnabled = YES;
    orderShipCharges.delegate = self;
    [orderShipCharges awakeFromNib];

    time = [[CustomTextField alloc] init];
    time.borderStyle = UITextBorderStyleRoundedRect;
    time.textColor = [UIColor blackColor];
    time.placeholder = @"Time";
//    time.backgroundColor = [UIColor whiteColor];
    time.keyboardType = UIKeyboardTypeDefault;
    time.clearButtonMode = UITextFieldViewModeWhileEditing;
    time.autocorrectionType = UITextAutocorrectionTypeNo;
    time.returnKeyType = UIReturnKeyDone;
    //[self.view addSubview:scrollView];
    time.userInteractionEnabled = NO;
    time.delegate = self;
    [time awakeFromNib];

    
    
    //    timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    UIImage *buttonImageT = [UIImage imageNamed:@"combo.png"];
    //    [timeButton setBackgroundImage:buttonImageT forState:UIControlStateNormal];
    //    [timeButton addTarget:self action:@selector(timeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    //    //[self.view addSubview:scrollView];
    
    
    UILabel *shipNote = [[UILabel alloc]init];
    shipNote.text  = @"Shipping Terms";
    shipNote.textColor = [UIColor whiteColor];
    shipNote.backgroundColor = [UIColor clearColor];
    
    UILabel *creditTerms = [[UILabel alloc]init];
    creditTerms.text  = @"Credit Terms";
    creditTerms.textColor = [UIColor whiteColor];
    creditTerms.backgroundColor = [UIColor clearColor];
    
    UILabel *paymentTerms = [[UILabel alloc]init];
    paymentTerms.text  = @"Payment Terms";
    paymentTerms.textColor = [UIColor whiteColor];
    paymentTerms.backgroundColor = [UIColor clearColor];
    
    UILabel *remarksView = [[UILabel alloc]init];
    remarksView.text  = @"Remarks";
    remarksView.textColor = [UIColor whiteColor];
    remarksView.backgroundColor = [UIColor clearColor];

    shipCharges = [[UITextView alloc] init];
    //shipCharges.borderStyle = UITextBorderStyleRoundedRect;
    shipCharges.textColor = [UIColor whiteColor];
    //shipCharges.placeholder = @"Shipping Terms";
    shipCharges.keyboardType = UIKeyboardTypeAlphabet;
    shipCharges.backgroundColor = [UIColor clearColor];
    //shipCharges.keyboardType = UIKeyboardTypeDefault;
    //shipCharges.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipCharges.autocorrectionType = UITextAutocorrectionTypeNo;
    shipCharges.returnKeyType = UIReturnKeyDone;
    //[self.view addSubview:scrollView];
    shipCharges.userInteractionEnabled = YES;
    shipCharges.delegate = self;
    shipCharges.layer.borderWidth = 1.0f;
    shipCharges.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    [shipCharges awakeFromNib];

    
    
    paymentMode = [[UITextView alloc] init];
  //  paymentMode.borderStyle = UITextBorderStyleRoundedRect;
    paymentMode.textColor = [UIColor whiteColor];
  //  paymentMode.placeholder = @"Credit Terms";
    paymentMode.backgroundColor = [UIColor clearColor];
    paymentMode.keyboardType = UIKeyboardTypeDefault;
  //  paymentMode.clearButtonMode = UITextFieldViewModeWhileEditing;
    paymentMode.autocorrectionType = UITextAutocorrectionTypeNo;
    paymentMode.returnKeyType = UIReturnKeyDone;
    //[self.view addSubview:scrollView];
    paymentMode.delegate = self;
    paymentMode.layer.borderWidth = 1.0f;
    paymentMode.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    [paymentMode awakeFromNib];

    
    //[self.view addSubview:scrollView];
    
    paymentType = [[UITextView alloc] init];
    //paymentType.borderStyle = UITextBorderStyleRoundedRect;
    paymentType.textColor = [UIColor whiteColor];
    //paymentType.placeholder = @"Payment Terms";
    paymentType.backgroundColor = [UIColor clearColor];
    paymentType.keyboardType = UIKeyboardTypeDefault;
  //  paymentType.clearButtonMode = UITextFieldViewModeWhileEditing;
    paymentType.autocorrectionType = UITextAutocorrectionTypeNo;
    paymentType.returnKeyType = UIReturnKeyDone;
    //[self.view addSubview:scrollView];
    paymentType.delegate = self;
    paymentType.layer.borderWidth = 1.0f;
    paymentType.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    [paymentType awakeFromNib];

    remarksTextView = [[UITextView alloc] init];
    //paymentType.borderStyle = UITextBorderStyleRoundedRect;
    remarksTextView.textColor = [UIColor whiteColor];
    //paymentType.placeholder = @"Payment Terms";
    remarksTextView.backgroundColor = [UIColor clearColor];
    remarksTextView.keyboardType = UIKeyboardTypeDefault;
    //  paymentType.clearButtonMode = UITextFieldViewModeWhileEditing;
    remarksTextView.autocorrectionType = UITextAutocorrectionTypeNo;
    remarksTextView.returnKeyType = UIReturnKeyDone;
    //[self.view addSubview:scrollView];
    remarksTextView.delegate = self;
    remarksTextView.layer.borderWidth = 1.0f;
    remarksTextView.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    [remarksTextView awakeFromNib];

    
    shipoMode = [[CustomTextField alloc] init];
    shipoMode.borderStyle = UITextBorderStyleRoundedRect;
    shipoMode.textColor = [UIColor blackColor];
    shipoMode.placeholder = @"SHIP Mode";
    shipoMode.backgroundColor = [UIColor whiteColor];
    shipoMode.keyboardType = UIKeyboardTypeDefault;
    shipoMode.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipoMode.autocorrectionType = UITextAutocorrectionTypeNo;
    shipoMode.returnKeyType = UIReturnKeyDone;
    //[self.view addSubview:scrollView];
    shipoMode.userInteractionEnabled = NO;
    shipoMode.delegate = self;
    [shipoMode awakeFromNib];
    
    shipoModeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImageSM = [UIImage imageNamed:@"combo.png"];
    [shipoModeButton setBackgroundImage:buttonImageSM forState:UIControlStateNormal];
    [shipoModeButton addTarget:self action:@selector(shipoModeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    // [self.view addSubview:scrollView];
    
    
    /** Order Button */
    orderButton = [[UIButton alloc] init];
    [orderButton addTarget:self
                    action:@selector(orderButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [orderButton setTitle:@"Order" forState:UIControlStateNormal];
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
    
    
    
    
    //serchOrderItemTable creation...
    serchOrderItemTable = [[UITableView alloc] init];
    serchOrderItemTable.layer.borderWidth = 1.0;
    serchOrderItemTable.layer.cornerRadius = 4.0;
    serchOrderItemTable.layer.borderColor = [UIColor blackColor].CGColor;
    serchOrderItemTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    serchOrderItemTable.dataSource = self;
    serchOrderItemTable.delegate = self;
    serchOrderItemTable.bounces = FALSE;
    
    
    
    
    //OrderItemTable creation...
    orderItemsTable = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, 300, 150)];
    ;
    orderItemsTable.backgroundColor  = [UIColor clearColor];
    //orderItemsTable.layer.borderColor = [UIColor grayColor].CGColor;
    //orderItemsTable.layer.borderWidth = 1.0;
    orderItemsTable.layer.cornerRadius = 4.0;
    orderItemsTable.bounces = FALSE;
    orderItemsTable.dataSource = self;
    orderItemsTable.delegate = self;
    //[self.view addSubview:scrollView];
    
    
    
    // PaymentTableview cration....
    paymentTable = [[UITableView alloc]init];
    paymentTable.layer.borderWidth = 1.0;
    paymentTable.bounces = FALSE;
    paymentTable.layer.cornerRadius = 10.0;
    paymentTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    paymentTable.layer.borderColor = [UIColor blackColor].CGColor;
    paymentTable.dataSource = self;
    paymentTable.delegate = self;
    
    
    
    
    // ShipModeTableview cration....
    shipModeTable = [[UITableView alloc]init];
    shipModeTable.layer.borderWidth = 1.0;
    shipModeTable.layer.cornerRadius = 10.0;
    shipModeTable.bounces = FALSE;
    shipModeTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    shipModeTable.layer.borderColor = [UIColor blackColor].CGColor;
    shipModeTable.dataSource = self;
    shipModeTable.delegate = self;
    
    orderChannelTable = [[UITableView alloc]init];
    orderChannelTable.layer.borderWidth = 1.0;
    orderChannelTable.layer.cornerRadius = 10.0;
    orderChannelTable.bounces = FALSE;
    orderChannelTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    orderChannelTable.layer.borderColor = [UIColor blackColor].CGColor;
    orderChannelTable.dataSource = self;
    orderChannelTable.delegate = self;
    
    orderDeliveryTable = [[UITableView alloc]init];
    orderDeliveryTable.layer.borderWidth = 1.0;
    orderDeliveryTable.layer.cornerRadius = 10.0;
    orderDeliveryTable.bounces = FALSE;
    orderDeliveryTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    orderDeliveryTable.layer.borderColor = [UIColor blackColor].CGColor;
    orderDeliveryTable.dataSource = self;
    orderDeliveryTable.delegate = self;
    
    paymentTypeTable = [[UITableView alloc]init];
    paymentTypeTable.layer.borderWidth = 1.0;
    paymentTypeTable.layer.cornerRadius = 10.0;
    paymentTypeTable.bounces = FALSE;
    paymentTypeTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    paymentTypeTable.layer.borderColor = [UIColor blackColor].CGColor;
    paymentTypeTable.dataSource = self;
    paymentTypeTable.delegate = self;
    
    
    shipmentLocationTable = [[UITableView alloc]init];
    shipmentLocationTable.layer.borderWidth = 1.0;
    shipmentLocationTable.layer.cornerRadius = 10.0;
    shipmentLocationTable.bounces = FALSE;
    shipmentLocationTable.backgroundColor = [UIColor clearColor];
    shipmentLocationTable.layer.borderColor = [UIColor blackColor].CGColor;
    shipmentLocationTable.dataSource = self;
    shipmentLocationTable.delegate = self;
    shipmentLocationTable.hidden = YES;

    addLocationButton = [[UIButton alloc] init] ;
    [addLocationButton setTitle:@"ADD" forState:UIControlStateNormal];
    addLocationButton.backgroundColor = [UIColor grayColor];
    addLocationButton.layer.masksToBounds = YES;
    addLocationButton.layer.cornerRadius = 5.0f;
    [addLocationButton addTarget:self action:@selector(addLocation:) forControlEvents:UIControlEventTouchDown];

    
    //Followings are SubTotal,Tax,TotalAmount labels creation...
    UILabel *subTotal = [[UILabel alloc] init] ;
    subTotal.text = @"Total Items";
    subTotal.textColor = [UIColor whiteColor];
    subTotal.backgroundColor = [UIColor clearColor];
    //[self.view addSubview:scrollView];
    UILabel *tax = [[UILabel alloc] init] ;
    
    
    tax.text = @"Tax 8.25%";
    tax.textColor = [UIColor whiteColor];
    tax.backgroundColor = [UIColor clearColor];
    //[self.view addSubview:scrollView];
    
    
    UILabel *totAmount = [[UILabel alloc] init] ;
    totAmount.text = @"Total Bill";
    totAmount.textColor = [UIColor whiteColor];
    totAmount.backgroundColor = [UIColor clearColor];
    //[self.view addSubview:scrollView];
    
    
    // Disply ActualData of SubTotal,Tax,TotalAmount labels creation...
    subTotalData = [[UILabel alloc] init] ;
    subTotalData.text = @"0.00";
    subTotalData.textColor = [UIColor whiteColor];
    subTotalData.backgroundColor = [UIColor clearColor];
    //[self.view addSubview:scrollView];
    
    
    taxData = [[UILabel alloc] init] ;
    taxData.text = @"0.00";
    taxData.textColor = [UIColor whiteColor];
    taxData.backgroundColor = [UIColor clearColor];
    //[self.view addSubview:scrollView];
    
    
    totAmountData = [[UILabel alloc] init] ;
    totAmountData.text = @"0.00";
    totAmountData.textColor = [UIColor whiteColor];
    totAmountData.backgroundColor = [UIColor clearColor];
    //[self.view addSubview:scrollView];
    
    UILabel *deliveryLocationLbl = [[UILabel alloc] init] ;
    deliveryLocationLbl.text = @"Delivery Locations";
    deliveryLocationLbl.textColor = [UIColor whiteColor];
    deliveryLocationLbl.backgroundColor = [UIColor clearColor];

    UILabel *locationLbl = [[UILabel alloc] init] ;
    locationLbl.text = @"Location";
    locationLbl.layer.cornerRadius = 12;
    locationLbl.textAlignment = NSTextAlignmentCenter;
    locationLbl.layer.masksToBounds = YES;
    
    locationLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    locationLbl.textColor = [UIColor whiteColor];
    //[self.view addSubview:scrollView];
    
    UILabel *streetLbl = [[UILabel alloc] init] ;
    streetLbl.text = @"Street";
    streetLbl.layer.cornerRadius = 12;
    streetLbl.textAlignment = NSTextAlignmentCenter;
    streetLbl.layer.masksToBounds = YES;
    
    streetLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    streetLbl.textColor = [UIColor whiteColor];
    
    UILabel *areaLbl = [[UILabel alloc] init] ;
    areaLbl.text = @"Area";
    areaLbl.layer.cornerRadius = 12;
    areaLbl.layer.masksToBounds = YES;
    areaLbl.textAlignment = NSTextAlignmentCenter;
    areaLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    areaLbl.textColor = [UIColor whiteColor];
    //[self.view addSubview:scrollView];
    
    UILabel *cityLbl = [[UILabel alloc] init] ;
    cityLbl.text = @"City";
    cityLbl.layer.cornerRadius = 12;
    cityLbl.layer.masksToBounds = YES;
    cityLbl.textAlignment = NSTextAlignmentCenter;
    cityLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    cityLbl.textColor = [UIColor whiteColor];

    // MutabileArray's initialization....
    skuIdArray = [[NSMutableArray alloc] init];
    ItemArray = [[NSMutableArray alloc] init];
    ItemDiscArray = [[NSMutableArray alloc] init];
    priceArray = [[NSMutableArray alloc] init];
    QtyArray = [[NSMutableArray alloc] init];
    totalArray = [[NSMutableArray alloc] init];
    totalQtyArray = [[NSMutableArray alloc] init];
    locationArr = [[NSMutableArray alloc] init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        
        //        img.frame = CGRectMake(0, 0, 768, 50);
        //        [self.view addSubview:img];
        //
        //        label.font = [UIFont boldSystemFontOfSize:25];
        //        label.frame = CGRectMake(3, 10, 250, 30);
        //        label.font = [UIFont systemFontOfSize:25.0];
        //        [self.view addSubview:label];
        //
        //        backbutton.frame = CGRectMake(710.0, 6.0, 40.0, 40.0);
        //        [self.view addSubview:backbutton];
        
        mainSegmentedControl.frame = CGRectMake(-2, 65, 1050.0, 60);
        mainSegmentedControl.tintColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
        mainSegmentedControl.backgroundColor = [UIColor clearColor];
        NSDictionary *attributes = @{UITextAttributeFont: [UIFont boldSystemFontOfSize:18],UITextAttributeTextColor: [UIColor whiteColor]};
        [mainSegmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
        [self.view addSubview:mainSegmentedControl];
        
        
        scrollView.frame = CGRectMake(0, 125, 1050.0, 500.0);
        scrollView.contentSize = CGSizeMake(768, 1500.0);
        [self.view addSubview:scrollView];
        
        customerName.frame = CGRectMake(10,10, 300.0, 40);
        customerName.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        [scrollView addSubview:customerName];
        
        customerCode.frame = CGRectMake(330.0, 10, 300.0, 40);
        customerCode.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        [scrollView addSubview:customerCode];
        
        supplierTable.frame = CGRectMake(650.0, 50, 300.0, 0);
        [scrollView addSubview:supplierTable];
        
        executiveName.frame = CGRectMake(650.0, 10, 300.0, 40);
        executiveName.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        [scrollView addSubview:executiveName];
        
        dueDate.frame = CGRectMake(10.0, 70, 300.0, 40);
        dueDate.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        [scrollView addSubview:dueDate];
        
        dueDateButton.frame = CGRectMake(270.0, 65, 50, 55);//set frame for button
        [scrollView addSubview:dueDateButton];
        
        shipment_location.frame = CGRectMake(600.0, 1080, 280.0, 50);
        shipment_location.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        [scrollView addSubview:shipment_location];
        
        locationButton.frame = CGRectMake(840, 1075, 50, 65);//set frame for button
        [scrollView addSubview:locationButton];

        addLocationButton.frame = CGRectMake(905.0, 1075.0,100.0f, 55.0f);
        addLocationButton.layer.cornerRadius = 25.0f;
        addLocationButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        [scrollView addSubview:addLocationButton];
        
        shipment_city.frame = CGRectMake(330.0, 70.0, 300.0, 40);
        shipment_city.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        [scrollView addSubview:shipment_city];
        
        shipment_street.frame = CGRectMake(650.0, 70.0, 300.0, 40);
        shipment_street.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        [scrollView addSubview:shipment_street];
        
        shipoMode.frame = CGRectMake(10.0, 130.0, 300.0, 40);
        shipoMode.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        [scrollView addSubview:shipoMode];
        
        shipoModeButton.frame = CGRectMake(275.0, 125.0, 50, 55);//set frame for button
        [scrollView addSubview:shipoModeButton];
        
        shipmentID.frame = CGRectMake(330.0, 130.0, 300.0, 40);
        shipmentID.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        [scrollView addSubview:shipmentID];
        
        shipNote.frame = CGRectMake(20, 230.0, 200.0, 40);
        shipNote.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        [scrollView addSubview:shipNote];
        
        shipCharges.frame = CGRectMake(10, 280.0, 450.0, 80);
        shipCharges.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        [scrollView addSubview:shipCharges];
        
        saleLocation.frame = CGRectMake(650, 130.0, 300.0, 40);
        saleLocation.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        [scrollView addSubview:saleLocation];
        
        orderShipCharges.frame = CGRectMake(10.0, 190.0, 300.0, 40);
        orderShipCharges.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        [scrollView addSubview:orderShipCharges];

        creditTerms.frame = CGRectMake(500, 230, 150, 40);
        creditTerms.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        [scrollView addSubview:creditTerms];
        
        paymentMode.frame = CGRectMake(510.0, 280.0, 450.0, 80);
        paymentMode.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        [scrollView addSubview:paymentMode];
        
        paymentTerms.frame = CGRectMake(20, 360, 150, 40);
        paymentTerms.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        [scrollView addSubview:paymentTerms];
        
        paymentType.frame = CGRectMake(10, 410.0, 450.0, 80);
        paymentType.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        [scrollView addSubview:paymentType];
        
        remarksView.frame = CGRectMake(500, 360, 150, 40);
        remarksView.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        [scrollView addSubview:remarksView];
        
        remarksTextView.frame = CGRectMake(510, 410, 450.0, 80);
        remarksTextView.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
        [scrollView addSubview:remarksTextView];

        customerCode.attributedPlaceholder = [[NSAttributedString alloc]initWithString:customerCode.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        customerName.attributedPlaceholder = [[NSAttributedString alloc]initWithString:customerName.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        executiveName.attributedPlaceholder = [[NSAttributedString alloc]initWithString:executiveName.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        saleLocation.attributedPlaceholder = [[NSAttributedString alloc]initWithString:saleLocation.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
       // phNo.attributedPlaceholder = [[NSAttributedString alloc]initWithString:phNo.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
      //  email.attributedPlaceholder = [[NSAttributedString alloc]initWithString:email.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        dueDate.attributedPlaceholder = [[NSAttributedString alloc]initWithString:dueDate.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
       // orderDate.attributedPlaceholder = [[NSAttributedString alloc]initWithString:orderDate.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        
        time.attributedPlaceholder = [[NSAttributedString alloc]initWithString:time.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        shipment_location.attributedPlaceholder = [[NSAttributedString alloc]initWithString:shipment_location.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        shipment_street.attributedPlaceholder = [[NSAttributedString alloc]initWithString:shipment_street.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        shipment_city.attributedPlaceholder = [[NSAttributedString alloc]initWithString:shipment_city.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
//        shipCharges.attributedPlaceholder = [[NSAttributedString alloc]initWithString:shipCharges.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
////        paymentMode.attributedPlaceholder = [[NSAttributedString alloc]initWithString:paymentMode.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
//        paymentType.attributedPlaceholder = [[NSAttributedString alloc]initWithString:paymentType.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        shipmentID.attributedPlaceholder = [[NSAttributedString alloc]initWithString:shipmentID.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        
        
        
        shipoMode.attributedPlaceholder = [[NSAttributedString alloc]initWithString:shipoMode.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        orderShipCharges.attributedPlaceholder = [[NSAttributedString alloc]initWithString:orderShipCharges.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
      //  billing_city.attributedPlaceholder = [[NSAttributedString alloc]initWithString:billing_city.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
      //  billing_location.attributedPlaceholder = [[NSAttributedString alloc]initWithString:billing_location.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
//        address.attributedPlaceholder = [[NSAttributedString alloc]initWithString:address.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
//        phNo.attributedPlaceholder = [[NSAttributedString alloc]initWithString:phNo.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
//        email.attributedPlaceholder = [[NSAttributedString alloc]initWithString:email.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
//        dueDate.attributedPlaceholder = [[NSAttributedString alloc]initWithString:dueDate.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
//        orderDate.attributedPlaceholder = [[NSAttributedString alloc]initWithString:orderDate.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        
        
        searchItem.frame = CGRectMake(10, 520.0, 704.0, 50);
        searchItem.font = [UIFont systemFontOfSize:20.0];
        [scrollView addSubview:searchItem];
        
        searchBtton.frame = CGRectMake(420, 310, 110, 40);
        searchBtton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0f];
        searchBtton.layer.cornerRadius = 22.0f;
        //[scrollView addSubview:searchBtton];
        
        
        label1.frame = CGRectMake(10, 580.0, 150, 40);
        label1.font = [UIFont boldSystemFontOfSize:20.0];
        label1.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
        [scrollView addSubview:label1];
        
        label5.frame = CGRectMake(161, 580.0, 150, 40);
        label5.font = [UIFont boldSystemFontOfSize:20.0];
        label5.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
        [scrollView addSubview:label5];
        
        label2.frame = CGRectMake(312, 580.0, 130, 40);
        label2.font = [UIFont boldSystemFontOfSize:20.0];
        label2.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
        [scrollView addSubview:label2];
        
        label3.frame = CGRectMake(443, 580.0, 130, 40);
        label3.font = [UIFont boldSystemFontOfSize:20.0];
        label3.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
        [scrollView addSubview:label3];
        
        label4.frame = CGRectMake(574, 580.0, 130, 40);
        label4.font = [UIFont boldSystemFontOfSize:20.0];
        label4.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
        [scrollView addSubview:label4];
        
        serchOrderItemTable.frame = CGRectMake(10, 630.0, 400, 300);
        [scrollView addSubview:serchOrderItemTable];
        serchOrderItemTable.hidden = YES;
        
        
        // orderTableScrollView.frame = CGRectMake(0, 262, 770, 380);
        // orderTableScrollView.contentSize = CGSizeMake(320,150);
        // [scrollView addSubview:orderTableScrollView];
        
        
        orderItemsTable.frame = CGRectMake(10, 630.0, 750, 250);
        [scrollView addSubview:orderItemsTable];
        orderItemsTable.hidden = YES;
        
        subTotal.frame = CGRectMake(600,950,300,50);
        subTotal.font = [UIFont boldSystemFontOfSize:25];
        subTotal.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25];
        [scrollView addSubview:subTotal];
        
        totAmount.frame = CGRectMake(600,1010,300,50);
        totAmount.font = [UIFont boldSystemFontOfSize:25];
        totAmount.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25];
        [scrollView addSubview:totAmount];
        
        
        subTotalData.frame = CGRectMake(880,950,200,50);
        subTotalData.font = [UIFont boldSystemFontOfSize:25];
        [scrollView addSubview:subTotalData];
        
        totAmountData.frame = CGRectMake(880,1010,300,50);
        totAmountData.font = [UIFont boldSystemFontOfSize:25];
        [scrollView addSubview:totAmountData];
        
        deliveryLocationLbl.frame = CGRectMake(10.0, 1080, 300.0, 55);
        deliveryLocationLbl.font = [UIFont boldSystemFontOfSize:30.0];
        [scrollView addSubview:deliveryLocationLbl];
        //        address.frame = CGRectMake(5, 750, 760, 50);
        //        address.font = [UIFont systemFontOfSize:25.0];
        //        [scrollView addSubview:address];
        //
        //
        //
        //
        //
        //        time.frame = CGRectMake(385, 870, 370, 50);
        //        time.font = [UIFont systemFontOfSize:25.0];
        //        [scrollView addSubview:time];
        //
        //        // timeButton.frame = CGRectMake(720, 916, 50, 65);//set frame for button
        //        // [scrollView addSubview:timeButton];
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //        //        orderButton.frame = CGRectMake(250, 940, 120, 50);
        //        //        orderButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        //        //        [self.view addSubview:orderButton];
        //        //
        //        //        cancelButton.frame = CGRectMake(400, 940, 120, 50);
        //        //        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        //        //        [self.view addSubview:cancelButton];
        
        
        orderButton.frame = CGRectMake(30, 650.0, 350, 50);
        orderButton.layer.cornerRadius = 22.0f;
        orderButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        [self.view addSubview:orderButton];
        
        cancelButton.frame = CGRectMake(500, 650.0, 350, 50);
        cancelButton.layer.cornerRadius = 22.0f;
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        [self.view addSubview:cancelButton];
        
        // label.font = [UIFont boldSystemFontOfSize:25];
        
        locationLbl.frame = CGRectMake(10, 1150, 200.0, 40);
        locationLbl.font = [UIFont boldSystemFontOfSize:20.0];
        locationLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
        [scrollView addSubview:locationLbl];

        streetLbl.frame = CGRectMake(215, 1150, 200, 40);
        streetLbl.font = [UIFont boldSystemFontOfSize:20.0];
        streetLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
        [scrollView addSubview:streetLbl];

        areaLbl.frame = CGRectMake(420, 1150, 200, 40);
        areaLbl.font = [UIFont boldSystemFontOfSize:20.0];
        areaLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
        [scrollView addSubview:areaLbl];

        cityLbl.frame = CGRectMake(625, 1150, 200, 40);
        cityLbl.font = [UIFont boldSystemFontOfSize:20.0];
        cityLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
        [scrollView addSubview:cityLbl];
        
        shipmentLocationTable.frame = CGRectMake(10.0, 1190.0, self.view.frame.size.width, 300.0);
        [scrollView addSubview:shipmentLocationTable];
        
        paymentTable.frame = CGRectMake(200, 260, 340, 300);
        [self.view addSubview:paymentTable];
        paymentTable.hidden = YES;
        
        shipModeTable.frame = CGRectMake(200, 260, 340, 270);
        [self.view addSubview:shipModeTable];
        shipModeTable.hidden = YES;
        
        orderChannelTable.frame = CGRectMake(200, 260, 340, 270);
        [self.view addSubview:orderChannelTable];
        orderChannelTable.hidden = YES;
        
        orderDeliveryTable.frame = CGRectMake(200, 260, 340, 270);
        [self.view addSubview:orderDeliveryTable];
        orderDeliveryTable.hidden = YES;
        
        paymentTypeTable.frame = CGRectMake(200, 260, 340, 270);
        [self.view addSubview:paymentTypeTable];
        paymentTypeTable.hidden = YES;
        
        
        
        //        subTotal.frame = CGRectMake(10,580,300,50);
        //        subTotal.font = [UIFont boldSystemFontOfSize:25];
        //        [scrollView addSubview:subTotal];
        //
        //        tax.frame = CGRectMake(10,630,300,50);
        //        tax.font = [UIFont boldSystemFontOfSize:25];
        //        [scrollView addSubview:tax];
        //
        //        totAmount.frame = CGRectMake(10,680,300,50);
        //        totAmount.font = [UIFont boldSystemFontOfSize:25];
        //        [scrollView addSubview:totAmount];
        //
        //
        //
        //        subTotalData.frame = CGRectMake(500,580,200,50);
        //        subTotalData.font = [UIFont boldSystemFontOfSize:25];
        //        [scrollView addSubview:subTotalData];
        //
        //        taxData.frame = CGRectMake(500,630,300,50);
        //        taxData.font = [UIFont boldSystemFontOfSize:25];
        //        [scrollView addSubview:taxData];
        //
        //        totAmountData.frame = CGRectMake(500,680,300,50);
        //        totAmountData.font = [UIFont boldSystemFontOfSize:25];
        //        [scrollView addSubview:totAmountData];
        
    }
    else{
        
        if (version>=8.0) {
           
            mainSegmentedControl.frame = CGRectMake(-2, 65, 324, 42);
            mainSegmentedControl.tintColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
            mainSegmentedControl.backgroundColor = [UIColor clearColor];
            NSDictionary *attributes = @{UITextAttributeFont: [UIFont boldSystemFontOfSize:18],UITextAttributeTextColor: [UIColor whiteColor]};
            [mainSegmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
            
            [self.view addSubview:mainSegmentedControl];
            
            
            scrollView.frame = CGRectMake(0, 110, 768, 400);
            scrollView.contentSize = CGSizeMake(768, 1100);
            [self.view addSubview:scrollView];
            
            customerName.frame = CGRectMake(5,0, 150.0, 30);
            customerName.font = [UIFont systemFontOfSize:15.0];
            [scrollView addSubview:customerName];
            
            customerCode.frame = CGRectMake(165.0, 0, 150.0, 30);
            customerCode.font = [UIFont systemFontOfSize:15.0];
            [scrollView addSubview:customerCode];
            
            supplierTable.frame = CGRectMake(5, 30, 150, 0);
            [scrollView addSubview:supplierTable];
            
            phNo.frame = CGRectMake(5, 35, 150.0, 30);
            phNo.font = [UIFont systemFontOfSize:15.0];
            [scrollView addSubview:phNo];
            
            email.frame = CGRectMake(165, 35, 150.0, 30);
            email.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:email];
            
            executiveName.frame = CGRectMake(5, 35, 150, 30);
            executiveName.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:executiveName];
            
            orderDate.frame = CGRectMake(165, 70, 150, 30);
            orderDate.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:orderDate];
            
            orderDateButton.frame = CGRectMake(295, 69, 30, 35);//set frame for button
            [scrollView addSubview:orderDateButton];
            
            dueDate.frame = CGRectMake(165, 35, 150, 30);
            dueDate.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:dueDate];
            
            dueDateButton.frame = CGRectMake(300, 33, 30, 35);//set frame for button
            [scrollView addSubview:dueDateButton];
            
            shipment_location.frame = CGRectMake(5, 70, 150, 30);
            shipment_location.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:shipment_location];
            
            shipment_city.frame = CGRectMake(165, 70, 150, 30);
            shipment_city.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:shipment_city];
            
            shipment_street.frame = CGRectMake(5, 105, 150, 30);
            shipment_street.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:shipment_street];
            
            billing_location.frame = CGRectMake(5, 175, 150, 30);
            billing_location.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:billing_location];
            
            billing_city.frame = CGRectMake(165, 175, 150, 30);
            billing_city.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:billing_city];
            
            billing_street.frame = CGRectMake(5, 210, 150, 30);
            billing_street.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:billing_street];
            
            customer_location.frame = CGRectMake(165, 210, 150, 30);
            customer_location.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:customer_location];
            
            customer_city.frame = CGRectMake(5, 245, 150, 30);
            customer_city.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:customer_city];
            
            customer_street.frame = CGRectMake(165, 245, 150, 30);
            customer_street.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:customer_street];
            
            orderChannel.frame = CGRectMake(5, 280, 150, 30);
            orderChannel.font = [UIFont systemFontOfSize:15.0];
            [scrollView addSubview:orderChannel];
            
            orderChannnelButton.frame = CGRectMake(135, 277, 30, 35);//set frame for button
            [scrollView addSubview:orderChannnelButton];
            
            orderDeliveryType.frame = CGRectMake(165, 280, 150, 30);
            orderDeliveryType.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:orderDeliveryType];
            
            orderDeliveryTypeButton.frame = CGRectMake(295, 277, 30, 35);//set frame for button
            [scrollView addSubview:orderDeliveryTypeButton];
            
            shipoMode.frame = CGRectMake(165, 105, 150, 30);
            shipoMode.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:shipoMode];
            
            shipoModeButton.frame = CGRectMake(295, 104, 30, 35);//set frame for button
            [scrollView addSubview:shipoModeButton];
            
            shipmentID.frame = CGRectMake(5, 140, 150, 30);
            shipmentID.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:shipmentID];
            
            shipNote.frame = CGRectMake(10, 175, 200.0, 30);
            shipNote.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];
            [scrollView addSubview:shipNote];
            
            shipCharges.frame = CGRectMake(5, 210, 180, 40);
            shipCharges.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:shipCharges];
            
            saleLocation.frame = CGRectMake(165, 140, 150, 30);
            saleLocation.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:saleLocation];
            
            creditTerms.frame = CGRectMake(10, 260, 150, 30);
            creditTerms.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];
            [scrollView addSubview:creditTerms];
            
            paymentMode.frame = CGRectMake(5, 300, 180, 40);
            paymentMode.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:paymentMode];
            
            paymentModeButton.frame = CGRectMake(135, 210, 30, 35); //set frame for button
            [scrollView addSubview:paymentModeButton];
            
            paymentTerms.frame = CGRectMake(10, 350, 150, 30);
            paymentTerms.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];
            [scrollView addSubview:paymentTerms];
            
            paymentType.frame = CGRectMake(5, 390, 180, 40);
            paymentType.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:paymentType];
            
            paymentTypeButton.frame = CGRectMake(295, 382, 30, 35); //set frame for button
            [scrollView addSubview:paymentTypeButton];
            
            customerCode.attributedPlaceholder = [[NSAttributedString alloc]initWithString:customerCode.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            customerName.attributedPlaceholder = [[NSAttributedString alloc]initWithString:customerName.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            executiveName.attributedPlaceholder = [[NSAttributedString alloc]initWithString:executiveName.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            saleLocation.attributedPlaceholder = [[NSAttributedString alloc]initWithString:saleLocation.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            // phNo.attributedPlaceholder = [[NSAttributedString alloc]initWithString:phNo.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            //  email.attributedPlaceholder = [[NSAttributedString alloc]initWithString:email.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            dueDate.attributedPlaceholder = [[NSAttributedString alloc]initWithString:dueDate.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            // orderDate.attributedPlaceholder = [[NSAttributedString alloc]initWithString:orderDate.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            
            time.attributedPlaceholder = [[NSAttributedString alloc]initWithString:time.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            shipment_location.attributedPlaceholder = [[NSAttributedString alloc]initWithString:shipment_location.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            shipment_street.attributedPlaceholder = [[NSAttributedString alloc]initWithString:shipment_street.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            shipment_city.attributedPlaceholder = [[NSAttributedString alloc]initWithString:shipment_city.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            //        shipCharges.attributedPlaceholder = [[NSAttributedString alloc]initWithString:shipCharges.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            ////        paymentMode.attributedPlaceholder = [[NSAttributedString alloc]initWithString:paymentMode.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            //        paymentType.attributedPlaceholder = [[NSAttributedString alloc]initWithString:paymentType.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            shipmentID.attributedPlaceholder = [[NSAttributedString alloc]initWithString:shipmentID.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            
            
            
            shipoMode.attributedPlaceholder = [[NSAttributedString alloc]initWithString:shipoMode.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
            
            searchItem.frame = CGRectMake(5, 440, 220, 30);
            searchItem.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:searchItem];
            
            searchBtton.frame = CGRectMake(235, 250, 80, 35);
            searchBtton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
            searchBtton.layer.cornerRadius = 18.0f;
          //  [scrollView addSubview:searchBtton];
            
            
            label1.frame = CGRectMake(0, 480, 60, 25);
            label1.font = [UIFont boldSystemFontOfSize:17];
            [scrollView addSubview:label1];
            
            label5.frame = CGRectMake(61, 480, 60, 25);
            label5.font = [UIFont boldSystemFontOfSize:17];
            [scrollView addSubview:label5];
            
            label2.frame = CGRectMake(122, 480, 60, 25);
            label2.font = [UIFont boldSystemFontOfSize:17];
            [scrollView addSubview:label2];
            
            label3.frame = CGRectMake(183, 480, 60, 25);
            label3.font = [UIFont boldSystemFontOfSize:17];
            [scrollView addSubview:label3];
            
            label4.frame = CGRectMake(244, 480, 60, 25);
            label4.font = [UIFont boldSystemFontOfSize:17];
            [scrollView addSubview:label4];
            
            serchOrderItemTable.frame = CGRectMake(10, 380, 220, 200);
            [scrollView addSubview:serchOrderItemTable];
            serchOrderItemTable.hidden = YES;
            
            
            orderItemsTable.frame = CGRectMake(10, 510, 550, 250);
            [scrollView addSubview:orderItemsTable];
            orderItemsTable.hidden = YES;
            
            subTotal.frame = CGRectMake(5,620,150,30);
            subTotal.font = [UIFont boldSystemFontOfSize:17];
            [scrollView addSubview:subTotal];
            
            tax.frame = CGRectMake(10,650,150,30);
            tax.font = [UIFont boldSystemFontOfSize:17];
            [scrollView addSubview:tax];
            
            totAmount.frame = CGRectMake(10,680,180,30);
            totAmount.font = [UIFont boldSystemFontOfSize:17];
            [scrollView addSubview:totAmount];
            
            
            
            subTotalData.frame = CGRectMake(250,620,150,30);
            subTotalData.font = [UIFont boldSystemFontOfSize:17];
            [scrollView addSubview:subTotalData];
            
            taxData.frame = CGRectMake(250,650,150,30);
            taxData.font = [UIFont boldSystemFontOfSize:17];
            [scrollView addSubview:taxData];
            
            totAmountData.frame = CGRectMake(250,680,180,30);
            totAmountData.font = [UIFont boldSystemFontOfSize:17];
            [scrollView addSubview:totAmountData];
            
            
            
            orderButton.frame = CGRectMake(15, 520, 130, 30);
            orderButton.layer.cornerRadius = 18.0f;
            orderButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
            [self.view addSubview:orderButton];
            
            cancelButton.frame = CGRectMake(165, 520, 130, 30);
            cancelButton.layer.cornerRadius = 18.0f;
            cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
            [self.view addSubview:cancelButton];
            
            // label.font = [UIFont boldSystemFontOfSize:25];
            
            
            
            
            paymentTable.frame = CGRectMake(130, 150, 120, 100);
            [self.view addSubview:paymentTable];
            paymentTable.hidden = YES;
            
            shipModeTable.frame = CGRectMake(165, 135, 150, 200);
            [self.view addSubview:shipModeTable];
            shipModeTable.hidden = YES;
            
            orderChannelTable.frame = CGRectMake(130, 150, 120, 100);
            [self.view addSubview:orderChannelTable];
            orderChannelTable.hidden = YES;
            
            orderDeliveryTable.frame = CGRectMake(130, 150, 120, 100);
            [self.view addSubview:orderDeliveryTable];
            orderDeliveryTable.hidden = YES;
            
            paymentTypeTable.frame = CGRectMake(130, 150, 120, 100);
            [self.view addSubview:paymentTypeTable];
            paymentTypeTable.hidden = YES;

        }
        else {
            mainSegmentedControl.frame = CGRectMake(-2, 0.0, 324, 42);
            mainSegmentedControl.tintColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
            mainSegmentedControl.backgroundColor = [UIColor clearColor];
            NSDictionary *attributes = @{UITextAttributeFont: [UIFont boldSystemFontOfSize:18],UITextAttributeTextColor: [UIColor whiteColor]};
            [mainSegmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
            
            [self.view addSubview:mainSegmentedControl];
            
            
            scrollView.frame = CGRectMake(0, 42, 768, 810);
            scrollView.contentSize = CGSizeMake(768, 1350);
            [self.view addSubview:scrollView];
            
            customerCode.frame = CGRectMake(5,0, 150.0, 30);
            customerCode.font = [UIFont systemFontOfSize:15.0];
            [scrollView addSubview:customerCode];
            
            customerName.frame = CGRectMake(165.0, 0, 150.0, 30);
            customerName.font = [UIFont systemFontOfSize:15.0];
            [scrollView addSubview:customerName];
            
            phNo.frame = CGRectMake(5, 35, 150.0, 30);
            phNo.font = [UIFont systemFontOfSize:15.0];
            [scrollView addSubview:phNo];
            
            email.frame = CGRectMake(165, 35, 150.0, 30);
            email.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:email];
            
            executiveName.frame = CGRectMake(5, 35, 150, 30);
            executiveName.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:executiveName];
            
            orderDate.frame = CGRectMake(165, 70, 150, 30);
            orderDate.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:orderDate];
            
            orderDateButton.frame = CGRectMake(295, 69, 30, 35);//set frame for button
            [scrollView addSubview:orderDateButton];
            
            dueDate.frame = CGRectMake(165, 35, 150, 30);
            dueDate.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:dueDate];
            
            dueDateButton.frame = CGRectMake(135, 33, 30, 35);//set frame for button
            [scrollView addSubview:dueDateButton];
            
            shipment_location.frame = CGRectMake(5, 70, 150, 30);
            shipment_location.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:shipment_location];
            
            shipment_city.frame = CGRectMake(165, 70, 150, 30);
            shipment_city.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:shipment_city];
            
            shipment_street.frame = CGRectMake(5, 105, 150, 30);
            shipment_street.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:shipment_street];
            
            billing_location.frame = CGRectMake(5, 175, 150, 30);
            billing_location.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:billing_location];
            
            billing_city.frame = CGRectMake(165, 175, 150, 30);
            billing_city.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:billing_city];
            
            billing_street.frame = CGRectMake(5, 210, 150, 30);
            billing_street.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:billing_street];
            
            customer_location.frame = CGRectMake(165, 210, 150, 30);
            customer_location.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:customer_location];
            
            customer_city.frame = CGRectMake(5, 245, 150, 30);
            customer_city.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:customer_city];
            
            customer_street.frame = CGRectMake(165, 245, 150, 30);
            customer_street.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:customer_street];
            
            orderChannel.frame = CGRectMake(5, 280, 150, 30);
            orderChannel.font = [UIFont systemFontOfSize:15.0];
            [scrollView addSubview:orderChannel];
            
            orderChannnelButton.frame = CGRectMake(135, 277, 30, 35);//set frame for button
            [scrollView addSubview:orderChannnelButton];
            
            orderDeliveryType.frame = CGRectMake(165, 280, 150, 30);
            orderDeliveryType.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:orderDeliveryType];
            
            orderDeliveryTypeButton.frame = CGRectMake(295, 277, 30, 35);//set frame for button
            [scrollView addSubview:orderDeliveryTypeButton];
            
            shipoMode.frame = CGRectMake(165, 105, 150, 30);
            shipoMode.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:shipoMode];
            
            shipoModeButton.frame = CGRectMake(295, 104, 30, 35);//set frame for button
            [scrollView addSubview:shipoModeButton];
            
            shipmentID.frame = CGRectMake(5, 140, 150, 30);
            shipmentID.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:shipmentID];
            
            shipCharges.frame = CGRectMake(165, 140, 150, 30);
            shipCharges.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:shipCharges];
            
            saleLocation.frame = CGRectMake(5, 175, 150, 30);
            saleLocation.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:saleLocation];
            
            paymentMode.frame = CGRectMake(5, 175, 150, 30);
            paymentMode.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:paymentMode];
            
            paymentModeButton.frame = CGRectMake(135, 210, 30, 35); //set frame for button
            [scrollView addSubview:paymentModeButton];
            
            paymentType.frame = CGRectMake(5, 210, 150, 30);
            paymentType.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:paymentType];
            
            paymentTypeButton.frame = CGRectMake(295, 382, 30, 35); //set frame for button
            [scrollView addSubview:paymentTypeButton];
            
            searchItem.frame = CGRectMake(5, 250, 220, 30);
            searchItem.font = [UIFont systemFontOfSize:15];
            [scrollView addSubview:searchItem];
            
            searchBtton.frame = CGRectMake(235, 250, 80, 35);
            searchBtton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
            searchBtton.layer.cornerRadius = 18.0f;
            [scrollView addSubview:searchBtton];
            
            
            label1.frame = CGRectMake(0, 290, 60, 25);
            label1.font = [UIFont boldSystemFontOfSize:17];
            [scrollView addSubview:label1];
            
            label5.frame = CGRectMake(61, 290, 60, 25);
            label5.font = [UIFont boldSystemFontOfSize:17];
            [scrollView addSubview:label5];
            
            label2.frame = CGRectMake(122, 290, 60, 25);
            label2.font = [UIFont boldSystemFontOfSize:17];
            [scrollView addSubview:label2];
            
            label3.frame = CGRectMake(183, 290, 60, 25);
            label3.font = [UIFont boldSystemFontOfSize:17];
            [scrollView addSubview:label3];
            
            label4.frame = CGRectMake(244, 290, 60, 25);
            label4.font = [UIFont boldSystemFontOfSize:17];
            [scrollView addSubview:label4];
            
            serchOrderItemTable.frame = CGRectMake(10, 380, 220, 200);
            [scrollView addSubview:serchOrderItemTable];
            serchOrderItemTable.hidden = YES;
            
            
            orderItemsTable.frame = CGRectMake(10, 490, 550, 250);
            [scrollView addSubview:orderItemsTable];
            orderItemsTable.hidden = YES;
            
            subTotal.frame = CGRectMake(5,670,150,30);
            subTotal.font = [UIFont boldSystemFontOfSize:17];
            [scrollView addSubview:subTotal];
            
            tax.frame = CGRectMake(10,710,150,30);
            tax.font = [UIFont boldSystemFontOfSize:17];
            [scrollView addSubview:tax];
            
            totAmount.frame = CGRectMake(10,750,180,30);
            totAmount.font = [UIFont boldSystemFontOfSize:17];
            [scrollView addSubview:totAmount];
            
            
            
            subTotalData.frame = CGRectMake(250,670,150,30);
            subTotalData.font = [UIFont boldSystemFontOfSize:17];
            [scrollView addSubview:subTotalData];
            
            taxData.frame = CGRectMake(250,710,150,30);
            taxData.font = [UIFont boldSystemFontOfSize:17];
            [scrollView addSubview:taxData];
            
            totAmountData.frame = CGRectMake(250,750,180,30);
            totAmountData.font = [UIFont boldSystemFontOfSize:17];
            [scrollView addSubview:totAmountData];
            
            
            
            orderButton.frame = CGRectMake(15, 370, 130, 30);
            orderButton.layer.cornerRadius = 18.0f;
            orderButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
            [self.view addSubview:orderButton];
            
            cancelButton.frame = CGRectMake(165, 370, 130, 30);
            cancelButton.layer.cornerRadius = 18.0f;
            cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
            [self.view addSubview:cancelButton];
            
            // label.font = [UIFont boldSystemFontOfSize:25];
            
            
            
            
            paymentTable.frame = CGRectMake(130, 150, 120, 100);
            [self.view addSubview:paymentTable];
            paymentTable.hidden = YES;
            
            shipModeTable.frame = CGRectMake(130, 150, 120, 100);
            [self.view addSubview:shipModeTable];
            shipModeTable.hidden = YES;
            
            orderChannelTable.frame = CGRectMake(130, 150, 120, 100);
            [self.view addSubview:orderChannelTable];
            orderChannelTable.hidden = YES;
            
            orderDeliveryTable.frame = CGRectMake(130, 150, 120, 100);
            [self.view addSubview:orderDeliveryTable];
            orderDeliveryTable.hidden = YES;
            
            paymentTypeTable.frame = CGRectMake(130, 150, 120, 100);
            [self.view addSubview:paymentTypeTable];
            paymentTypeTable.hidden = YES;

        }
        
        
    }
    
//    customerCode.backgroundColor = [UIColor whiteColor];
    //    customerCode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Customer Code" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
//    customerName.backgroundColor = [UIColor whiteColor];
//    executiveName.backgroundColor = [UIColor whiteColor];
//    searchItem.backgroundColor = [UIColor whiteColor];
//    address.backgroundColor = [UIColor whiteColor];
//    phNo.backgroundColor = [UIColor whiteColor];
//    email.backgroundColor = [UIColor whiteColor];
//    orderDate.backgroundColor = [UIColor whiteColor];
//    dueDate.backgroundColor = [UIColor whiteColor];
//    shipment_location.backgroundColor = [UIColor whiteColor];
//    shipment_city.backgroundColor = [UIColor whiteColor];
//    shipment_street.backgroundColor = [UIColor whiteColor];
//    billing_location.backgroundColor = [UIColor whiteColor];
//    billing_city.backgroundColor = [UIColor whiteColor];
//    billing_street.backgroundColor = [UIColor whiteColor];
//    customer_location.backgroundColor = [UIColor whiteColor];
//    customer_city.backgroundColor = [UIColor whiteColor];
//    customer_street.backgroundColor = [UIColor whiteColor];
//    orderChannel.backgroundColor = [UIColor whiteColor];
//    orderDeliveryType.backgroundColor = [UIColor whiteColor];
//    shipmentID.backgroundColor = [UIColor whiteColor];
//    saleLocation.backgroundColor = [UIColor whiteColor];
//    time.backgroundColor = [UIColor whiteColor];
//    shipCharges.backgroundColor = [UIColor whiteColor];
//    paymentMode.backgroundColor = [UIColor whiteColor];
//    paymentType.backgroundColor = [UIColor whiteColor];
//    shipoMode.backgroundColor = [UIColor whiteColor];

    
    /** SearchBarItem*/
//    const NSInteger searchBarHeight = 30;
    searchBar = [[UISearchBar alloc] init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        searchBar.frame = CGRectMake(0, 125, 768, 60);
    }
    else {
        searchBar.frame = CGRectMake(0, 35, 320, 30);
    }
    searchBar.delegate = self;
    searchBar.tintColor=[UIColor grayColor];
    orderstockTable.tableHeaderView = searchBar;
    [self.view addSubview:searchBar];
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
    orderstockTable.dataSource = self;
    orderstockTable.delegate = self;
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
        orderstockTable.frame = CGRectMake(0, 125, self.view.frame.size.width, 600.0);
        
        firstButton.frame = CGRectMake(165, 720.0, 50, 50);
        firstButton.layer.cornerRadius = 25.0f;
        firstButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        lastButton.frame = CGRectMake(695, 720.0, 50, 50);
        lastButton.layer.cornerRadius = 25.0f;
        lastButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        previousButton.frame = CGRectMake(320, 720.0, 50, 50);
        previousButton.layer.cornerRadius = 22.0f;
        previousButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        nextButton.frame = CGRectMake(550, 720.0, 50, 50);
        nextButton.layer.cornerRadius = 22.0f;
        nextButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        recStart.frame = CGRectMake(375, 720.0, 30, 50);
        label1_.frame = CGRectMake(418, 720.0, 30, 50);
        recEnd.frame = CGRectMake(445, 720.0, 30, 50);
        label2_.frame = CGRectMake(480, 720.0, 30, 50);
        totalRec.frame = CGRectMake(515, 720.0, 30, 50);
        
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
        
        if (version>=8.0) {
            
            orderstockTable.frame = CGRectMake(0, 110, 320, 420);
            
            firstButton.frame = CGRectMake(10, 500, 35, 35);
            firstButton.layer.cornerRadius = 15.0f;
            firstButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            
            
            lastButton.frame = CGRectMake(273, 500, 35, 35);
            lastButton.layer.cornerRadius = 15.0f;
            lastButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            
            previousButton.frame = CGRectMake(80, 500, 35, 35);
            previousButton.layer.cornerRadius = 15.0f;
            previousButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            
            nextButton.frame = CGRectMake(210, 500, 35, 35);
            nextButton.layer.cornerRadius = 15.0f;
            nextButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            
            recStart.frame = CGRectMake(122, 500, 20, 30);
            label1_.frame = CGRectMake(140, 500, 20, 30);
            recEnd.frame = CGRectMake(148, 500, 20, 30);
            label2_.frame = CGRectMake(167, 500, 20, 30);
            totalRec.frame = CGRectMake(183, 500, 20, 30);
            
            recStart.font = [UIFont systemFontOfSize:14.0];
            label1_.font = [UIFont systemFontOfSize:14.0];
            recEnd.font = [UIFont systemFontOfSize:14.0];
            label2_.font = [UIFont systemFontOfSize:14.0];
            totalRec.font = [UIFont systemFontOfSize:14.0];
        }
        else {
            orderstockTable.frame = CGRectMake(0, 70, 320, 300);
            firstButton.frame = CGRectMake(10, 420, 40, 40);
            firstButton.layer.cornerRadius = 15.0f;
            firstButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            
            
            lastButton.frame = CGRectMake(273, 420, 40, 40);
            lastButton.layer.cornerRadius = 15.0f;
            lastButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            
            previousButton.frame = CGRectMake(80, 420, 40, 40);
            previousButton.layer.cornerRadius = 15.0f;
            previousButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            
            nextButton.frame = CGRectMake(210, 420, 40, 40);
            nextButton.layer.cornerRadius = 15.0f;
            nextButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            
            recStart.frame = CGRectMake(122, 420, 20, 30);
            label1_.frame = CGRectMake(140, 420, 20, 30);
            recEnd.frame = CGRectMake(148, 420, 20, 30);
            label2_.frame = CGRectMake(167, 420, 20, 30);
            totalRec.frame = CGRectMake(183, 420, 20, 30);
            
            recStart.font = [UIFont systemFontOfSize:14.0];
            label1_.font = [UIFont systemFontOfSize:14.0];
            recEnd.font = [UIFont systemFontOfSize:14.0];
            label2_.font = [UIFont systemFontOfSize:14.0];
            totalRec.font = [UIFont systemFontOfSize:14.0];
        }
        
      
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
    [HUD show:NO];
    [HUD setHidden:YES];
    
    skuArrayList = [[NSMutableArray alloc]init];
    tempSkuArrayList = [[NSMutableArray alloc] init];
    serchOrderItemArray = [[NSMutableArray alloc] init];
    selectedLocationIdArr = [[NSMutableArray alloc] init];

}
// Commented By roja on 17/10/2019... // Reaso:- Due convertion of getPurchaseOrders SOAP to REST below Handling also effecting, so with same method name written below with latest changes...
//- (void) getPreviousOrdersHandler: (NSString *) value {
//
//    //    // Handle errors
//    //    if([value isKindOfClass:[NSError class]]) {
//    //        //NSLog(@"%@", value);
//    //        return;
//    //    }
//    //
//    //    // Handle faults
//    //    if([value isKindOfClass:[SoapFault class]]) {
//    //        //NSLog(@"%@", value);
//    //        return;
//    //    }
//    //
//
//    [HUD setHidden:YES];
//
//    // Do something with the NSString* result
//    NSString* result = [value copy];
//
//    NSError *e;
//
//    NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [result dataUsingEncoding:NSUTF8StringEncoding]
//                                                          options: NSJSONReadingMutableContainers
//                                                            error: &e];
//
//    NSDictionary *json = JSON1[@"responseHeader"];
//
//    if ([json[@"responseMessage"] isEqualToString:@"Success"] && [json[@"responseCode"] isEqualToString:@"0"]) {
//
//        // initialize the arrays ..
//        itemIdArray = [[NSMutableArray alloc] init];
//        orderStatusArray = [[NSMutableArray alloc] init];
//        orderAmountArray = [[NSMutableArray alloc] init];
//        OrderedOnArray = [[NSMutableArray alloc] init];
//        NSArray *listDetails = JSON1[@"ordersList"];
//        //        NSArray *temp = [result componentsSeparatedByString:@"!"];
//
//        recStart.text = [NSString stringWithFormat:@"%d",(purchaseChangeNum_ * 10) + 1];
//        recEnd.text = [NSString stringWithFormat:@"%d",(recStart.text).intValue + 9];
//        totalRec.text = [NSString stringWithFormat:@"%@",JSON1[@"totalOrders"]];
//
//        if ([JSON1[@"totalOrders"] intValue] <= 10) {
//            recEnd.text = [NSString stringWithFormat:@"%d",(totalRec.text).intValue];
//            nextButton.enabled =  NO;
//            previousButton.enabled = NO;
//            firstButton.enabled = NO;
//            lastButton.enabled = NO;
//            //nextButton.backgroundColor = [UIColor lightGrayColor];
//        }
//        else{
//
//            if (purchaseChangeNum_ == 0) {
//                previousButton.enabled = NO;
//                firstButton.enabled = NO;
//                nextButton.enabled = YES;
//                lastButton.enabled = YES;
//            }
//            else if (([JSON1[@"totalOrders"] intValue] - (10 * (purchaseChangeNum_+1))) <= 0) {
//
//                nextButton.enabled = NO;
//                lastButton.enabled = NO;
//                recEnd.text = totalRec.text;
//            }
//        }
//
//
//        //[temp removeObjectAtIndex:0];
//
//        for (int i = 0; i < listDetails.count; i++) {
//
//            NSDictionary *temp2 = listDetails[i];
//
//            [itemIdArray addObject:[NSString stringWithFormat:@"%@",temp2[@"PO_Ref"]]];
//            [orderStatusArray addObject:[NSString stringWithFormat:@"%@",temp2[@"storeLocation"]]];
//            [orderAmountArray addObject:[NSString stringWithFormat:@"%@",temp2[@"total_po_value"]]];
//            [OrderedOnArray addObject:[NSString stringWithFormat:@"%@",temp2[@"order_date"]]];
//        }
//
//        if (itemIdArray.count < 5) {
//            //nextButton.backgroundColor = [UIColor lightGrayColor];
//            nextButton.enabled =  NO;
//        }
//
//        purchaseCount3_ = (int)itemIdArray.count;
//
//        if (listDetails.count == 0) {
//            nextButton.enabled = NO;
//            lastButton.enabled = NO;
//            previousButton.enabled = NO;
//            firstButton.enabled = NO;
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Previous Orders" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//        }
//
//        [orderstockTable reloadData];
//    }
//    else{
//
//        purchaseCount2_ = NO;
//        purchaseChangeNum_--;
//
//        //nextButton.backgroundColor = [UIColor lightGrayColor];
//        nextButton.enabled =  NO;
//
//        //previousButton.backgroundColor = [UIColor grayColor];
//        previousButton.enabled =  NO;
//
//        firstButton.enabled = NO;
//        lastButton.enabled = NO;
//
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Previous Orders" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//    }
//
//}


-(IBAction) dueDateButtonPressed:(id) sender{
    
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
        
        pickView.frame = CGRectMake(15, dueDate.frame.origin.y+dueDate.frame.size.height, 320, 320);
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
    myPicker.backgroundColor = [UIColor whiteColor];
    
    UIButton  *pickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    
    [pickButton setBackgroundImage:[UIImage imageNamed:@"ok2.jpg"] forState:UIControlStateNormal];
    
    pickButton.frame = CGRectMake(85, 269, 100, 45);
    pickButton.backgroundColor = [UIColor clearColor];
    pickButton.layer.masksToBounds = YES;
    [pickButton addTarget:self action:@selector(getDate:) forControlEvents:UIControlEventTouchUpInside];
    pickButton.layer.borderColor = [UIColor blackColor].CGColor;
    pickButton.layer.borderWidth = 0.5f;
    pickButton.layer.cornerRadius = 12;
    //pickButton.layer.masksToBounds = YES;
    [customView addSubview:myPicker];
    [customView addSubview:pickButton];
    
    
    customerInfoPopUp.view = customView;
    
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        
        [popover presentPopoverFromRect:dueDate.frame inView:scrollView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        
        
        catPopOver= popover;
        
    }
    
    else {
        
        customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        // popover.contentViewController.view.alpha = 0.0;
        popover.contentViewController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        catPopOver = popover;
        
    }
    
    UIGraphicsBeginImageContext(customView.frame.size);
    [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    customView.backgroundColor = [UIColor colorWithPatternImage:image];
}

-(IBAction)getDate:(id)sender
{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    [pickView setHidden:YES];
    [catPopOver dismissPopoverAnimated:YES];
    //Date Formate Setting...
    NSDateFormatter *sdayFormat = [[NSDateFormatter alloc] init];
    sdayFormat.dateFormat = @"dd/MM/yyyy HH:mm:ss";
    NSString *dateString = [sdayFormat stringFromDate:myPicker.date];
    
    NSComparisonResult result = [myPicker.date compare:[NSDate date]];
    
    if(result==NSOrderedAscending) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Invalid Date Selection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        
        NSArray *temp =[dateString componentsSeparatedByString:@" "];
        NSLog(@" %@",temp);
        
        dueDate.text = temp[0];
        time.text = temp[1];
       // [pickView removeFromSuperview];
        
    }
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
        
        pickView.frame = CGRectMake(15, shipoMode.frame.origin.y+shipoMode.frame.size.height, 320, 320);
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
    shipModeTable.dataSource = self;
    shipModeTable.delegate = self;
    
    shipModeTable.hidden = NO;
    shipModeTable.frame = CGRectMake(0.0, 0.0, customView.frame.size.width, customView.frame.size.height);
    [customView addSubview:shipModeTable];
    [shipModeTable reloadData];
    
    customerInfoPopUp.view = customView;
    
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        
        [popover presentPopoverFromRect:shipoMode.frame inView:scrollView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        
        
        catPopOver= popover;
        
    }
    
    else {
        
        customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        // popover.contentViewController.view.alpha = 0.0;
        popover.contentViewController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        catPopOver = popover;
        
    }
    
    UIGraphicsBeginImageContext(customView.frame.size);
    [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    customView.backgroundColor = [UIColor colorWithPatternImage:image];
    
}

-(void)getListOfLocations:(id)sender {
    
    if (sender == locationButton) {
        
        // [selectLocation setEnabled:NO];
        if (locationButton.tag == 1) {
            
            [orderButton setEnabled:NO];
            [cancelButton setEnabled:NO];
            
            locationButton.tag = 2;
            
            //[normalstockTable setUserInteractionEnabled:NO];
            [shipment_location resignFirstResponder];
            
            fromlocationStartIndex = 0;
            
            [self getLocations:fromlocationStartIndex];
            
            // [waiterName resignFirstResponder];
            locationTable.hidden = NO;
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                locationTable.frame = CGRectMake(shipment_location.frame.origin.x, shipment_location.frame.origin.y + 50, shipment_location.frame.size.width, 220);
            }
            else {
                locationTable.frame = CGRectMake(10.0, 30.0, 120, 150);
            }
            [scrollView addSubview:locationTable];
            
        }
        else {
            
            [locationTable setHidden:YES];
            locationButton.tag = 1;
            
        }
    }
    
    
}
-(void)addLocation:(id)locationButton{
    if (ItemArray.count > 0) {
        if (locationArr.count > 0) {
            [selectedLocationIdArr addObject:locationArr[selectedLocationId]];
            [shipmentLocationTable setHidden:NO];
            [shipmentLocationTable reloadData];
        }
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Add Items to Cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];

    }
}

// Commented by roja on 17/10/2019.. // reason:- getLocations: method contains SOAP Service call .. so taken new method with same name(getLocations:) method name which contains REST service call....
// At the time of converting SOAP call's to REST
//-(void)getLocations:(int)startIndex {
//
//    if (locationArr.count>0) {
//
//        [locationArr removeAllObjects];
//    }
//
//    UtilityMasterServiceSoapBinding *utility =  [UtilityMasterServiceSvc UtilityMasterServiceSoapBinding];
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
//        NSDictionary *JSON1 = [[NSDictionary alloc] init];
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
//        if (![JSON1 isKindOfClass:[NSNull class]]) {
//
//
//            NSDictionary *responseHeader = [JSON1 valueForKey:@"responseHeader"];
//
//            if ([[responseHeader valueForKey:@"responseCode"] isEqualToString:@"0"] && [[responseHeader valueForKey:@"responseMessage"] isEqualToString:@"Location Details"]) {
//
//                NSArray *locations = [JSON1 valueForKey:@"locationDetails"];
//
//                if (locations.count!=0) {
//
////                    for (int i=0; i < [locations count]; i++) {
////
////                        NSDictionary *locationdic = [locations objectAtIndex:i];
////
////                        [locationArr addObject:[locationdic valueForKey:@"locationId"]];
////
////                    }
//                    [locationArr addObjectsFromArray:locations];
//                    for (NSDictionary *locationDic in locationArr) {
//                        if ([[locationDic valueForKey:@"locationId"] isEqualToString:presentLocation]) {
//                            [locationArr removeObject:locationDic];
//                        }
//                    }
//                    locationTable.hidden = NO;
//
//                    [locationTable reloadData];
//                }
//
//                else {
//                    locationTable.hidden = YES;
//                }
//
//            }
//            else {
//
//                fromlocationScrollValueStatus_ = YES;
//
//            }
//        }
//    }
//    @catch (NSException *exception) {
//
//        locationTable.hidden = YES;
//    }
//
//}


//getLocations: method changed by roja on 17/10/2019.. // reason : removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST
-(void)getLocations:(int)startIndex {
    
    if (locationArr.count>0) {
        [locationArr removeAllObjects];
    }
    
    [HUD setHidden:NO];

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



// added by Roja on 17/10/2019…. // OLd code only written below
- (void)getLocationSuccessResponse:(NSDictionary *)sucessDictionary{

    @try {
        
        NSArray *locations = [sucessDictionary valueForKey:@"locationDetails"];
        
        if (locations.count!=0) {
            
            [locationArr addObjectsFromArray:locations];
            for (NSDictionary *locationDic in locationArr) {
                if ([[locationDic valueForKey:@"locationId"] isEqualToString:presentLocation]) {
                    [locationArr removeObject:locationDic];
                }
            }
            locationTable.hidden = NO;
            [locationTable reloadData];
        }
        
        else {
            locationTable.hidden = YES;
        }
        
    } @catch (NSException *exception) {
        
    } @finally {

        [HUD setHidden:YES];
    }
}


// added by Roja on 17/10/2019…. // OLd code only written below
- (void)getLocationErrorResponse:(NSString *)error{
    
    @try {
        fromlocationScrollValueStatus_ = YES;
        locationTable.hidden = YES;

    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
    }

}




//getSkuIDForGivenProductNameHandler: method Commented by roja on 17/10/2019.. // reason :- This method is no where using in this class..
// At the time of converting SOAP call's to REST
//- (void) getSkuIDForGivenProductNameHandler: (id) value {
//
//    // Handle errors
//    if([value isKindOfClass:[NSError class]]) {
//        NSLog(@"%@", value);
//        return;
//    }
//
//    NSString* result = (NSString*)value;
//
//    NSLog(@" %@",result);
//
//    if(result.length >= 1) {
//
//        NSError *e;
//
//        NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [result dataUsingEncoding:NSUTF8StringEncoding]
//                                                              options: NSJSONReadingMutableContainers
//                                                                error: &e];
//
//        NSArray *temp = JSON1[@"skuIds"];
//        if (temp.count > 0) {
//            NSDictionary *json =  temp[0];
//            result = [NSString stringWithFormat:@"%@",json[@"skuId"]];
//
//            if (skuIdArray.count == 0) {
//                [skuIdArray addObject:result];
//            }
//            else{
//
//                for (int i=0; i<=skuIdArray.count-1; i++) {
//                    NSString *str1  = skuIdArray[i];
//                    if ([str1 isEqualToString:result]) {
//                        newItem__ = NO;
//                    }
//                }
//                if (newItem__ == YES) {
//
//                    [skuIdArray addObject:result];
//                }
//                else{
//
//                    newItem__ = YES;
//                }
//            }
//
//
//            NSArray *keys = @[@"skuId",@"requestHeader"];
//            NSArray *objects = @[result,[RequestHeader getRequestHeader]];
//
//            NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
//
//            NSError * err;
//            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
//            NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//
//            SkuServiceSoapBinding *service = [SkuServiceSvc SkuServiceSoapBinding];
//            SkuServiceSvc_getSkuDetails *aparams = [[SkuServiceSvc_getSkuDetails alloc] init];
//            aparams.skuID = salesReportJsonString;
//
//            SkuServiceSoapBindingResponse *response = [service getSkuDetailsUsingParameters:(SkuServiceSvc_getSkuDetails *)aparams];
//
//            NSArray *responseBodyParts =  response.bodyParts;
//
//            for (id bodyPart in responseBodyParts) {
//                if ([bodyPart isKindOfClass:[SkuServiceSvc_getSkuDetailsResponse class]]) {
//                    SkuServiceSvc_getSkuDetailsResponse *body = (SkuServiceSvc_getSkuDetailsResponse *)bodyPart;
//                    NSError *e;
//                    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                         options: NSJSONReadingMutableContainers
//                                                                           error: &e];
//                    //printf("\nresponse=%s",body.return_);
//                    [self getSkuDetailsHandler:JSON];
//                }
//            }
//
//        }
//        else{
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Failed to get Details" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//        }
//    }
//    else{
//
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Product Not found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//
//        searchItem.text = nil;
//    }
//}
/*
 
 
 WebServiceController *webServiceController = [WebServiceController new];
 webServiceController.getSkuDetailsDelegate = self;
 [webServiceController getSkuDetailsWithData:salesReportJsonString];

 */





// Handle the response from getSkuDetails.
- (void) getSkuDetailsHandler: (NSDictionary *) value {
    
    // Handle errors
    if([value isKindOfClass:[NSError class]]) {
        NSLog(@"%@", value);
        return;
    }
    
    // Handle faults
    //    if([value isKindOfClass:[SoapFault class]]) {
    //        NSLog(@"%@", value);
    //        return;
    //    }
    
    
    // Do something with the NSString* result
    //    NSDictionary* result = (NSDictionary*)value;
    //    NSError *e;
    //
    //  NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [result dataUsingEncoding:NSUTF8StringEncoding]
    //                                                          options: NSJSONReadingMutableContainers
    //                                                            error: &e];
    //  NSDictionary *JSON2 = [JSON1 objectForKey:@"responseHeader"];
    //
    //  if ([[JSON2 objectForKey:@"responseMessage"] isEqualToString:@"SUCCESS"] && [[JSON2 objectForKey:@"responseCode"] isEqualToString:@"0"]) {
    
    //       NSArray *temp = [NSArray arrayWithObjects:[JSON_1 objectForKey:@"productName"],[JSON_1 objectForKey:@"description"],[JSON_1 objectForKey:@"price"],@"1",[JSON_1 objectForKey:@"price"],@"N/A",@"1",@"1",@"0", nil];
    
    // NSString *itemStr = [value objectForKey:@"productName"];
    
    //        NSArray *tempItems = [result componentsSeparatedByString:@"#"];
    
    // if ([ItemArray count] == 0) {
    
    //            for (int i=0; i<[tempItems count]/4; i++) {
    
    BOOL status = FALSE;
    
    
    for (int i=0; i<ItemArray.count; i++) {
        NSArray *itemArray = [value valueForKey:@"skuLists"];
        if (itemArray.count > 0) {
            NSDictionary *itemdic = itemArray[0];
            NSMutableDictionary *dic = ItemArray[i];
            if ([[dic valueForKey:SKU_ID] isEqualToString:[itemdic valueForKey:@"skuId"]] && [[dic valueForKey:PLU_CODE] isEqualToString:[itemdic valueForKey:PLU_CODE]]) {
                [dic setValue:[NSString stringWithFormat:@"%d",[[dic valueForKey:QUANTITY] intValue] + 1] forKey:QUANTITY];
                status = TRUE;
            }

        }
    }
    
    
    if (!status) {
        
        NSArray *itemArray = [value valueForKey:@"skuLists"];
        if (itemArray.count > 0) {
            NSDictionary *itemdic = itemArray[0];
            NSMutableDictionary *itemDetailsDic = [[NSMutableDictionary alloc] init];
            [itemDetailsDic setValue:[itemdic valueForKey:@"skuId"] forKey:SKU_ID];
            [itemDetailsDic setValue:[itemdic valueForKey:ITEM_DESCRIPTION] forKey:ITEM_DESCRIPTION];
            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[itemdic valueForKey:@"salePrice"] floatValue]] forKey:ITEM_UNIT_PRICE];
            [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:QUANTITY];
            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[itemdic valueForKey:@"salePrice"] floatValue]] forKey:ITEM_TOTAL_PRICE];
            [itemDetailsDic setValue:[itemdic valueForKey:PLU_CODE] forKey:PLU_CODE];
            [itemDetailsDic setValue:[itemdic valueForKey:QUANTITY] forKey:QUANTITY_IN_HAND];

            [ItemArray addObject:itemDetailsDic];
        }
    }
    
    //            }
    // }
    //  else
    //        {
    //            for (int i=0; i<=[ItemArray count]-1; i++) {
    //
    //                //NSString *str1  = [tempItems objectAtIndex:0];
    //                NSString *str2  = [ItemArray objectAtIndex:i];
    //
    //                if ([str2 isEqualToString:itemStr]) {
    //                    newItem__ = NO;
    //
    //                }
    //            }
    //
    //            if (newItem__ == YES) {
    //
    //                //                for (int i=0; i<[tempItems count]/4; i++) {
    //
    //                [ItemArray addObject:[JSON1 objectForKey:@"productName"]];
    //                [ItemDiscArray addObject:[JSON1 objectForKey:@"description"]];
    //                [totalQtyArray addObject:[JSON1 objectForKey:@"quantity"]];
    //                [priceArray addObject:[JSON1 objectForKey:@"price"]];
    //                [QtyArray addObject:@"1"];
    //                [totalArray addObject:[NSString stringWithFormat:@"%.02f", [[JSON1 objectForKey:@"price"] floatValue]*[[QtyArray objectAtIndex:0] intValue]]];
    //                //                }
    //            }
    //            else{
    //
    //                for (int i=0; i<=[ItemArray count]-1; i++) {
    //
    //                    //                       NSString *str1  = [tempItems objectAtIndex:0];
    //                    NSString *str2  = [ItemArray objectAtIndex:i];
    //
    //                    if ([str2 isEqualToString:itemStr]) {
    //
    //                        NSLog(@"%@",[QtyArray objectAtIndex:i]);
    //
    //                        NSLog(@" %d",[[QtyArray objectAtIndex:i] intValue] + 1);
    //
    //                        if ([[QtyArray objectAtIndex:i] intValue] + 1 > [[totalQtyArray objectAtIndex:i] intValue]) {
    //
    //                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Quantity Should be Less than or Equal to  Availble Quantity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //                            [alert show];
    //                            [alert release];
    //
    //                            qtyFeild.text = nil;
    //                        }
    //                        else{
    //
    //                            [QtyArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",[[QtyArray objectAtIndex:i] intValue] + 1]];
    //
    //                            newItem__ = YES;
    //                            [self displayOrdersData];
    //                        }
    //                    }
    //                }
    //            }
    //        }
    
    
    
    totalAmount = 0.0;
    int totalItems = 0;
    for (int i=0; i<ItemArray.count; i++) {
        NSDictionary *itemDetails = ItemArray[i];
        totalAmount += [[itemDetails valueForKey:ITEM_TOTAL_PRICE] floatValue];
        totalItems += [[itemDetails valueForKey:QUANTITY] intValue];
    }
    
    subTotalData.text = [NSString stringWithFormat:@"%d", totalItems];
    totAmountData.text = [NSString stringWithFormat:@"%.2f", totalAmount];
    
    orderItemsTable.hidden = NO;
    //[self.view bringSubviewToFront:orderItemsTable];
    [orderItemsTable reloadData];
    
    //    }
    //    else{
    //
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Failed to get Details" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //        [alert show];
    //        [alert release];
    //    }
    
}

//DisplayOrdersData handler
-(void)displayOrdersData{
    
    totalAmount = 0.0;
    int totalItems = 0;
    for (int i=0; i<ItemArray.count; i++) {
        NSDictionary *itemDetails = ItemArray[i];
        totalAmount += [[itemDetails valueForKey:ITEM_TOTAL_PRICE] floatValue];
        totalItems += [[itemDetails valueForKey:QUANTITY] intValue];
    }
    
    subTotalData.text = [NSString stringWithFormat:@"%d", totalItems];
    totAmountData.text = [NSString stringWithFormat:@"%.2f", totalAmount];
    
    orderItemsTable.hidden = NO;
    //[self.view bringSubviewToFront:orderItemsTable];
    [orderItemsTable reloadData];
}

// qtyChangeClick handler...
- (IBAction)qtyChangePressed:(id)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    scrollView.scrollEnabled = NO;
    orderButton.enabled = NO;
    cancelButton.enabled = NO;
    //timeButton.enabled = NO;
    paymentModeButton.enabled= NO;
    customerCode.enabled = NO;
    customerName.enabled = NO;
    searchItem.enabled = NO;
//    searchBtton.enabled = NO;
    address.enabled =NO;
    phNo.enabled = NO;
    email.enabled = NO;
    dueDate.enabled = NO;
    dueDateButton.enabled = NO;
    time.enabled = NO;
    //timeButton.enabled = NO;
    shipoMode.enabled = NO;
    shipoModeButton.userInteractionEnabled = FALSE;
    paymentModeButton.enabled = NO;
    orderItemsTable.userInteractionEnabled = FALSE;
    
    qtyOrderPosition = [sender tag];
    
    qtyChangeDisplyView = [[UIView alloc]init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        qtyChangeDisplyView.frame = CGRectMake(300.0, 200.0, 375, 320.0);
    }
    else{
        qtyChangeDisplyView.frame = CGRectMake(75, 68, 175, 200);
    }
    qtyChangeDisplyView.layer.borderWidth = 2.0;
    qtyChangeDisplyView.layer.cornerRadius = 10.0;
    qtyChangeDisplyView.layer.masksToBounds = YES;
    qtyChangeDisplyView.layer.borderColor = [UIColor blackColor].CGColor;
    
    //    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index29" ofType:@"jpg"];
    //    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:filePath]];
    //    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    //
    //        img.frame = CGRectMake(0, 0, 375, 300);
    //    }
    //    else{
    //        img.frame = CGRectMake(0, 0, 175, 200);
    //    }
    //    [qtyChangeDisplyView addSubview:img];
    qtyChangeDisplyView.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [self.view addSubview:qtyChangeDisplyView];
    
    NSDictionary *itemDic = ItemArray[[sender tag]];
    
    // a label on top of the view ..
    UILabel *topbar = [[UILabel alloc] init] ;
    topbar.backgroundColor = [UIColor grayColor];
    topbar.text = @"    Enter Quantity";
    topbar.backgroundColor = [UIColor blackColor];
    topbar.textAlignment = NSTextAlignmentCenter;
    topbar.textColor = [UIColor whiteColor];
    topbar.textAlignment = NSTextAlignmentLeft;
    
    
    
    UILabel *availQty = [[UILabel alloc] init] ;
    availQty.text = @"Available Qty :";
    availQty.backgroundColor = [UIColor clearColor];
    availQty.textColor = [UIColor blackColor];
    
    
    UILabel *unitPrice = [[UILabel alloc] init] ;
    unitPrice.text = @"Unit Price       :";
    unitPrice.backgroundColor = [UIColor clearColor];
    unitPrice.textColor = [UIColor blackColor];
    
    
    
    UILabel *availQtyData = [[UILabel alloc] init] ;
    availQtyData.text = [NSString stringWithFormat:@"%d",[[itemDic valueForKey:QUANTITY_IN_HAND] intValue]];
    availQtyData.backgroundColor = [UIColor clearColor];
    availQtyData.textColor = [UIColor blackColor];
    
    
    UILabel *unitPriceData = [[UILabel alloc] init] ;
    unitPriceData.text = [itemDic valueForKey:ITEM_UNIT_PRICE];
    unitPriceData.backgroundColor = [UIColor clearColor];
    unitPriceData.textColor = [UIColor blackColor];
    
    
    
    qtyFeild = [[UITextField alloc] init];
    qtyFeild.borderStyle = UITextBorderStyleRoundedRect;
    qtyFeild.textColor = [UIColor blackColor];
    qtyFeild.placeholder = @"Enter Qty";
    qtyFeild.backgroundColor = [UIColor whiteColor];
    qtyFeild.autocorrectionType = UITextAutocorrectionTypeNo;
    qtyFeild.keyboardType = UIKeyboardTypeDefault;
    qtyFeild.clearButtonMode = UITextFieldViewModeWhileEditing;
    qtyFeild.returnKeyType = UIReturnKeyDone;
    qtyFeild.delegate = self;
    [qtyFeild becomeFirstResponder];
    
    /** ok Button for qtyChangeDisplyView....*/
    okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //[okButton setImage:[UIImage imageNamed:@"OK.png"] forState:UIControlStateNormal];
    [okButton addTarget:self
                 action:@selector(okButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [okButton setTitle:@"OK" forState:UIControlStateNormal];
    okButton.backgroundColor = [UIColor grayColor];
    
    
    /** CancelButton for qtyChangeDisplyView....*/
    qtyCancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //[qtyCancelButton setImage:[UIImage imageNamed:@"Cancel.png"] forState:UIControlStateNormal];
    [qtyCancelButton addTarget:self
                        action:@selector(QtyCancelButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [qtyCancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    qtyCancelButton.backgroundColor = [UIColor grayColor];
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        topbar.frame = CGRectMake(0, 0, 375, 40);
        topbar.font = [UIFont boldSystemFontOfSize:25];
        
        
        availQty.frame = CGRectMake(10,50,200,40);
        availQty.font = [UIFont boldSystemFontOfSize:25];
        
        
        unitPrice.frame = CGRectMake(10,100,200,40);
        unitPrice.font = [UIFont boldSystemFontOfSize:25];
        
        
        availQtyData.frame = CGRectMake(200,50,250,40);
        availQtyData.font = [UIFont boldSystemFontOfSize:25];
        
        
        unitPriceData.frame = CGRectMake(200,100,2500,40);
        unitPriceData.font = [UIFont boldSystemFontOfSize:25];
        
        
        qtyFeild.frame = CGRectMake(110, 160, 150, 40);
        qtyFeild.font = [UIFont systemFontOfSize:25.0];
        
        
        okButton.frame = CGRectMake(20, 230, 165, 45);
        okButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        okButton.layer.cornerRadius = 20.0f;
        
        qtyCancelButton.frame = CGRectMake(190, 230, 165, 45);
        qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        qtyCancelButton.layer.cornerRadius = 20.0f;
        
    }
    else{
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
    
    
    [qtyChangeDisplyView addSubview:topbar];
    [qtyChangeDisplyView addSubview:availQty];
    [qtyChangeDisplyView addSubview:unitPrice];
    [qtyChangeDisplyView addSubview:availQtyData];
    [qtyChangeDisplyView addSubview:unitPriceData];
    [qtyChangeDisplyView addSubview:qtyFeild];
    [qtyChangeDisplyView addSubview:okButton];
    [qtyChangeDisplyView addSubview:qtyCancelButton];
}


// qtyChangeClick handler...
- (IBAction)locationQtyPressed:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    scrollView.scrollEnabled = NO;
    orderButton.enabled = NO;
    cancelButton.enabled = NO;
    //timeButton.enabled = NO;
    paymentModeButton.enabled= NO;
    customerCode.enabled = NO;
    customerName.enabled = NO;
    searchItem.enabled = NO;
    //    searchBtton.enabled = NO;
    address.enabled =NO;
    phNo.enabled = NO;
    email.enabled = NO;
    dueDate.enabled = NO;
    dueDateButton.enabled = NO;
    time.enabled = NO;
    //timeButton.enabled = NO;
    shipoMode.enabled = NO;
    shipoModeButton.userInteractionEnabled = FALSE;
    paymentModeButton.enabled = NO;
    orderItemsTable.userInteractionEnabled = FALSE;
    
    qtyOrderPosition = sender.tag;
    PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
    

    qtyChangeDisplyView = [[UIView alloc]init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        qtyChangeDisplyView.frame = CGRectMake(300.0, 200.0, 375, 320.0);
    }
    else{
        qtyChangeDisplyView.frame = CGRectMake(75, 68, 175, 200);
    }
    qtyChangeDisplyView.layer.borderWidth = 2.0;
    qtyChangeDisplyView.layer.cornerRadius = 10.0;
    qtyChangeDisplyView.layer.masksToBounds = YES;
    qtyChangeDisplyView.layer.borderColor = [UIColor blackColor].CGColor;
    
    //    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index29" ofType:@"jpg"];
    //    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:filePath]];
    //    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    //
    //        img.frame = CGRectMake(0, 0, 375, 300);
    //    }
    //    else{
    //        img.frame = CGRectMake(0, 0, 175, 200);
    //    }
    //    [qtyChangeDisplyView addSubview:img];
    qtyChangeDisplyView.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    
    NSDictionary *itemDic = locationWiseItemArr[sender.tag];
    
    // a label on top of the view ..
    UILabel *topbar = [[UILabel alloc] init] ;
    topbar.backgroundColor = [UIColor grayColor];
    topbar.text = @"    Enter Quantity";
    topbar.backgroundColor = [UIColor blackColor];
    topbar.textAlignment = NSTextAlignmentCenter;
    topbar.textColor = [UIColor whiteColor];
    topbar.textAlignment = NSTextAlignmentLeft;
    
    
    
    UILabel *availQty = [[UILabel alloc] init] ;
    availQty.text = @"Available Qty :";
    availQty.backgroundColor = [UIColor clearColor];
    availQty.textColor = [UIColor blackColor];
    
    
    UILabel *unitPrice = [[UILabel alloc] init] ;
    unitPrice.text = @"Unit Price       :";
    unitPrice.backgroundColor = [UIColor clearColor];
    unitPrice.textColor = [UIColor blackColor];
    
    
    
    UILabel *availQtyData = [[UILabel alloc] init] ;
    availQtyData.text = [NSString stringWithFormat:@"%d",[[itemDic valueForKey:QUANTITY_IN_HAND] intValue]];
    availQtyData.backgroundColor = [UIColor clearColor];
    availQtyData.textColor = [UIColor blackColor];
    
    
    UILabel *unitPriceData = [[UILabel alloc] init] ;
    unitPriceData.text = [itemDic valueForKey:ITEM_UNIT_PRICE];
    unitPriceData.backgroundColor = [UIColor clearColor];
    unitPriceData.textColor = [UIColor blackColor];
    
    
    
    qtyFeild = [[UITextField alloc] init];
    qtyFeild.borderStyle = UITextBorderStyleRoundedRect;
    qtyFeild.textColor = [UIColor blackColor];
    qtyFeild.placeholder = @"Enter Qty";
    qtyFeild.backgroundColor = [UIColor whiteColor];
    qtyFeild.autocorrectionType = UITextAutocorrectionTypeNo;
    qtyFeild.keyboardType = UIKeyboardTypeDefault;
    qtyFeild.clearButtonMode = UITextFieldViewModeWhileEditing;
    qtyFeild.returnKeyType = UIReturnKeyDone;
    qtyFeild.delegate = self;
    [qtyFeild becomeFirstResponder];
    
    /** ok Button for qtyChangeDisplyView....*/
    okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //[okButton setImage:[UIImage imageNamed:@"OK.png"] forState:UIControlStateNormal];
    [okButton addTarget:self
                 action:@selector(locationOkButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [okButton setTitle:@"OK" forState:UIControlStateNormal];
    okButton.backgroundColor = [UIColor grayColor];
    okButton.tag = sender.tag;
    
    /** CancelButton for qtyChangeDisplyView....*/
    qtyCancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //[qtyCancelButton setImage:[UIImage imageNamed:@"Cancel.png"] forState:UIControlStateNormal];
    [qtyCancelButton addTarget:self
                        action:@selector(locationQtyCancelButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [qtyCancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    qtyCancelButton.backgroundColor = [UIColor grayColor];
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        topbar.frame = CGRectMake(0, 0, 375, 40);
        topbar.font = [UIFont boldSystemFontOfSize:25];
        
        
        availQty.frame = CGRectMake(10,50,200,40);
        availQty.font = [UIFont boldSystemFontOfSize:25];
        
        
        unitPrice.frame = CGRectMake(10,100,200,40);
        unitPrice.font = [UIFont boldSystemFontOfSize:25];
        
        
        availQtyData.frame = CGRectMake(200,50,250,40);
        availQtyData.font = [UIFont boldSystemFontOfSize:25];
        
        
        unitPriceData.frame = CGRectMake(200,100,2500,40);
        unitPriceData.font = [UIFont boldSystemFontOfSize:25];
        
        
        qtyFeild.frame = CGRectMake(110, 160, 150, 40);
        qtyFeild.font = [UIFont systemFontOfSize:25.0];
        
        
        okButton.frame = CGRectMake(20, 230, 165, 45);
        okButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        okButton.layer.cornerRadius = 20.0f;
        
        qtyCancelButton.frame = CGRectMake(190, 230, 165, 45);
        qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        qtyCancelButton.layer.cornerRadius = 20.0f;
        
    }
    else{
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
    
    
    [qtyChangeDisplyView addSubview:topbar];
    [qtyChangeDisplyView addSubview:availQty];
    [qtyChangeDisplyView addSubview:unitPrice];
    [qtyChangeDisplyView addSubview:availQtyData];
    [qtyChangeDisplyView addSubview:unitPriceData];
    [qtyChangeDisplyView addSubview:qtyFeild];
    [qtyChangeDisplyView addSubview:okButton];
    [qtyChangeDisplyView addSubview:qtyCancelButton];
    
    customerInfoPopUp.view = qtyChangeDisplyView;
    customerInfoPopUp.view.backgroundColor = [UIColor clearColor];
    NSIndexPath *selectedRow = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        customerInfoPopUp.preferredContentSize =  CGSizeMake(qtyChangeDisplyView.frame.size.width, qtyChangeDisplyView.frame.size.height);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        
        [popover presentPopoverFromRect:sender.frame inView:[locationWiseItemTable cellForRowAtIndexPath:selectedRow] permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        
        
        locationPopOver= popover;
    }
    
    else {
        
        customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        // popover.contentViewController.view.alpha = 0.0;
        popover.contentViewController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        locationPopOver = popover;
        
    }

}

// okButtonPressed handler for quantity changed..
- (IBAction)okButtonPressed:(id)sender {
    
    AudioServicesPlaySystemSound (soundFileObject);
    NSString *str = qtyFeild.text;
    //NSString *candidate = qtyFeild.text;
    NSString *value = [qtyFeild.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    // PhoNumber validation...
    NSString *decimalRegex = @"[0-9]+([.]([0-9]+)?)?"; // @"[0-9]+[.][0-9]+";
    NSPredicate *decimalTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalRegex];
    //BOOL isNumber = [decimalTest evaluateWithObject:[qtyFeild text]];
    BOOL isNumber = [decimalTest evaluateWithObject:qtyFeild.text];
    
    int qty = str.intValue;
    NSMutableDictionary *itemDic = ItemArray[qtyOrderPosition];
    
    if (qty >= [[itemDic valueForKey:QUANTITY_IN_HAND] intValue] ){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Quantity Should be Less than or Equal to  Availble Quantity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        qtyFeild.text = nil;
        qtyChangeDisplyView.hidden = NO;
        
    }
    else if([value isEqualToString:@"0"] || !isNumber){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Quantity." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        qtyFeild.text = NO;
    }
    //    else if(!isNumber){
    //
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Quantity." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //        [alert show];
    //        [alert release];
    //    }
    else{
        [itemDic setValue:qtyFeild.text forKey:QUANTITY];
        [itemDic setValue:[NSString stringWithFormat:@"%.2f",([[itemDic valueForKey:ITEM_UNIT_PRICE] floatValue] * qty)] forKey:ITEM_TOTAL_PRICE];
        //[qtyChangeDisplyView removeFromSuperview];
        qtyChangeDisplyView.hidden = YES;
        
        
        
        [self displayOrdersData];
    }
    
    
    scrollView.scrollEnabled = YES;
    orderButton.enabled = YES;
    cancelButton.enabled = YES;
    //timeButton.enabled = YES;
    paymentModeButton.enabled= YES;
    customerCode.enabled = YES;
    customerName.enabled = YES;
    searchItem.enabled = YES;
//    searchBtton.enabled = YES;
    address.enabled = YES;
    phNo.enabled = YES;
    email.enabled = YES;
    dueDate.enabled = YES;
    dueDateButton.enabled = YES;
    time.enabled = YES;
    //timeButton.enabled = YES;
    shipoMode.enabled = YES;
    shipoModeButton.userInteractionEnabled = TRUE;
    paymentModeButton.enabled = YES;
    orderItemsTable.userInteractionEnabled = TRUE;
}





// cancelButtonPressed handler quantity changed view cancel..
- (IBAction)QtyCancelButtonPressed:(id)sender {
    
    AudioServicesPlaySystemSound (soundFileObject);
    qtyChangeDisplyView.hidden = YES;
    
    scrollView.scrollEnabled = YES;
    orderButton.enabled = YES;
    cancelButton.enabled = YES;
    // timeButton.enabled = YES;
    paymentModeButton.enabled= YES;
    customerCode.enabled = YES;
    customerName.enabled = YES;
    searchItem.enabled = YES;
//    searchBtton.enabled = YES;
    address.enabled =YES;
    phNo.enabled = YES;
    email.enabled = YES;
    dueDate.enabled = YES;
    dueDateButton.enabled = YES;
    time.enabled = YES;
    // timeButton.enabled = YES;
    shipoMode.enabled = YES;
    shipoModeButton.userInteractionEnabled = TRUE;
    paymentModeButton.enabled = YES;
    orderItemsTable.userInteractionEnabled = TRUE;
}

// okButtonPressed handler for quantity changed..
- (IBAction)locationOkButtonPressed:(id)sender {
    
    AudioServicesPlaySystemSound (soundFileObject);
    NSString *str = qtyFeild.text;
    //NSString *candidate = qtyFeild.text;
    NSString *value = [qtyFeild.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    // PhoNumber validation...
    NSString *decimalRegex = @"[0-9]+([.]([0-9]+)?)?"; // @"[0-9]+[.][0-9]+";
    NSPredicate *decimalTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalRegex];
    //BOOL isNumber = [decimalTest evaluateWithObject:[qtyFeild text]];
    BOOL isNumber = [decimalTest evaluateWithObject:qtyFeild.text];
    
    int qty = str.intValue;
    NSMutableDictionary *itemDic = locationWiseItemArr[[sender tag]];
    
    if (qty >= [[itemDic valueForKey:QUANTITY_IN_HAND] intValue] ){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Quantity Should be Less than or Equal to  Availble Quantity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        qtyFeild.text = nil;
        qtyChangeDisplyView.hidden = NO;
        
    }
    else if([value isEqualToString:@"0"] || !isNumber){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Quantity." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        qtyFeild.text = NO;
    }
    //    else if(!isNumber){
    //
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Quantity." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //        [alert show];
    //        [alert release];
    //    }
    else{
        [itemDic setValue:qtyFeild.text forKey:QUANTITY];
        [itemDic setValue:[NSString stringWithFormat:@"%.2f",([[itemDic valueForKey:ITEM_UNIT_PRICE] floatValue] * qty)] forKey:ITEM_TOTAL_PRICE];
        //[qtyChangeDisplyView removeFromSuperview];
        qtyChangeDisplyView.hidden = YES;
        [locationPopOver dismissPopoverAnimated:YES];
        
    }
    [locationWiseItemTable reloadData];
    
    scrollView.scrollEnabled = YES;
    orderButton.enabled = YES;
    cancelButton.enabled = YES;
    //timeButton.enabled = YES;
    paymentModeButton.enabled= YES;
    customerCode.enabled = YES;
    customerName.enabled = YES;
    searchItem.enabled = YES;
    //    searchBtton.enabled = YES;
    address.enabled = YES;
    phNo.enabled = YES;
    email.enabled = YES;
    dueDate.enabled = YES;
    dueDateButton.enabled = YES;
    time.enabled = YES;
    //timeButton.enabled = YES;
    shipoMode.enabled = YES;
    shipoModeButton.userInteractionEnabled = TRUE;
    paymentModeButton.enabled = YES;
    orderItemsTable.userInteractionEnabled = TRUE;
}





// cancelButtonPressed handler quantity changed view cancel..
- (IBAction)locationQtyCancelButtonPressed:(id)sender {
    
    AudioServicesPlaySystemSound (soundFileObject);
    qtyChangeDisplyView.hidden = YES;
    [locationPopOver dismissPopoverAnimated:YES];

    scrollView.scrollEnabled = YES;
    orderButton.enabled = YES;
    cancelButton.enabled = YES;
    // timeButton.enabled = YES;
    paymentModeButton.enabled= YES;
    customerCode.enabled = YES;
    customerName.enabled = YES;
    searchItem.enabled = YES;
    //    searchBtton.enabled = YES;
    address.enabled =YES;
    phNo.enabled = YES;
    email.enabled = YES;
    dueDate.enabled = YES;
    dueDateButton.enabled = YES;
    time.enabled = YES;
    // timeButton.enabled = YES;
    shipoMode.enabled = YES;
    shipoModeButton.userInteractionEnabled = TRUE;
    paymentModeButton.enabled = YES;
    orderItemsTable.userInteractionEnabled = TRUE;
}

- (IBAction)doneWithLocationItems:(UIButton *)sender {
    [editPricePopOver dismissPopoverAnimated:YES];
    NSDictionary *shipmentLocationDic = selectedLocationIdArr[sender.tag];
    if (poShipmentLocationArr.count == 0) {
        for (NSDictionary *itemDic_ in locationWiseItemArr) {
            NSMutableDictionary *itemDic = [[NSMutableDictionary alloc] init];
            [itemDic setValue:[itemDic_ valueForKey:SKU_ID] forKey:@"skuId"];
            [itemDic setValue:[itemDic_ valueForKey:ITEM_DESCRIPTION] forKey:@"skuName"];
            [itemDic setValue:[itemDic_ valueForKey:PLU_CODE] forKey:PLU_CODE];
            [itemDic setValue:[shipmentLocationDic valueForKey:@"locationId"] forKey:@"storeLocation"];
            [itemDic setValue:[itemDic_ valueForKey:QUANTITY] forKey:QUANTITY];
            [itemDic setValue:@"" forKey:@"remarks"];
            [itemDic setValue:[itemDic_ valueForKey:ITEM_TOTAL_PRICE] forKey:@"skuPrice"];
            [poShipmentLocationArr addObject:itemDic];
        }
    }
    else {
        for (NSDictionary *itemDic_ in [poShipmentLocationArr reverseObjectEnumerator]) {
            if ([[itemDic_ valueForKey:@"storeLocation"] isEqualToString:[shipmentLocationDic valueForKey:@"locationId"]]) {
                [poShipmentLocationArr removeObject:itemDic_];
            }
        }
        for (NSDictionary *itemDic_ in locationWiseItemArr) {
            NSMutableDictionary *itemDic = [[NSMutableDictionary alloc] init];
            [itemDic setValue:[itemDic_ valueForKey:SKU_ID] forKey:@"skuId"];
            [itemDic setValue:[itemDic_ valueForKey:ITEM_DESCRIPTION] forKey:@"skuName"];
            [itemDic setValue:[itemDic_ valueForKey:PLU_CODE] forKey:PLU_CODE];
            [itemDic setValue:[shipmentLocationDic valueForKey:@"locationId"] forKey:@"storeLocation"];
            [itemDic setValue:[itemDic_ valueForKey:QUANTITY] forKey:QUANTITY];
            [itemDic setValue:@"" forKey:@"remarks"];
            [itemDic setValue:[itemDic_ valueForKey:ITEM_TOTAL_PRICE] forKey:@"skuPrice"];
            [poShipmentLocationArr addObject:itemDic];
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
            scrollView.hidden = NO;
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
            scrollView.hidden = YES;
            orderButton.hidden = YES;
            cancelButton.hidden = YES;
            purchaseChangeNum_ = 0;
            [self getPurchaseOrders];
            [orderstockTable reloadData];
            break;
        default:
            break;
    }

}

// Commented by roja on 17/10/2019.. // reason :-- orderButtonPressed: method contains SOAP Service call .. so taken new method with same name(orderButtonPressed:) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//- (void) orderButtonPressed:(id) sender {
//
//    //Play Audio for button touch....
//    AudioServicesPlaySystemSound (soundFileObject);
//
//    // PhoNumber validation...
////    NSString *decimalRegex = @"[0-9]+([.]([0-9]+)?)?"; // @"[0-9]+[.][0-9]+";
////    NSPredicate *decimalTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalRegex];
////    BOOL isNumber = [decimalTest evaluateWithObject:[phNo text]];
////
////
////    // email validation...
////    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
////    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
////    BOOL isMail = [emailTest evaluateWithObject:[email text]];
//
//    NSString *locationValue = [customerCode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    NSString *customerNameValue = [customerName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    NSString *executiveNameValue = [executiveName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    NSString *dueDateValue = [dueDate.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    NSString *shipment_cityValue = [shipment_city.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    NSString *shipment_streetValue = [shipment_street.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    NSString *shipoModeValue = [shipoMode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    NSString *shipmentIDValue = [shipmentID.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    NSString *shipChargesValue = [shipCharges.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    NSString *saleLocationValue = [saleLocation.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    NSString *paymentModeValue = [paymentMode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    NSString *paymentTypeValue = [paymentType.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//
//    int shipmentQty = 0;
//
//    for (NSMutableDictionary *locItemDic in poShipmentLocationArr) {
//        shipmentQty += [[locItemDic valueForKey:QUANTITY] intValue];
//        [locItemDic setValue:[locItemDic valueForKey:QUANTITY] forKey:@"quantityStr"];
//        [locItemDic setValue:[locItemDic valueForKey:@"skuPrice"] forKey:@"skuPriceStr"];
//    }
//
//    if (ItemArray.count == 0) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Add Items to Cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//    }
//    else if (shipmentQty != (subTotalData.text).intValue){
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Total ordered items and shipment location items are not same" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//
//    }
//    else if(locationValue.length == 0 || customerNameValue.length == 0 || executiveNameValue.length == 0 || dueDateValue.length == 0 ||     shipment_cityValue.length == 0 || shipment_streetValue.length == 0  || shipoModeValue.length == 0 ||            shipmentIDValue.length == 0 || shipChargesValue.length == 0 || saleLocationValue.length == 0 ||            paymentModeValue.length == 0 || paymentTypeValue.length == 0){
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Fields couldn't be empty" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//    }
////    else if (!isNumber){
////        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Valid Mobile Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
////        [alert show];
////        [alert release];
////    }
////    else if (!isMail){
////        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter valid mail ID" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
////        [alert show];
////        [alert release];
////    }
//    else{
//        HUD.labelText = @" Placing the order..";
//        [HUD setHidden:NO];
//
//
//        //        SDZOrderService* service = [SDZOrderService service];
//        //        service.logging = YES;
//        //
//        //        // Returns BOOL.
//        //         [service createOrder:self action:@selector(createOrderHandler:) userID:user_name orderDateTime: dateString deliveryDate: dueDate.text deliveryTime: time.text ordererEmail: email.text ordererMobile:phNo.text ordererAddress: address.text orderTotalPrice: totAmountData.text shipmentCharge: shipCharges.text shipmentMode:shipoMode.text paymentMode: paymentMode.text orderItems: str];
//        @try {
//            NSMutableArray *items = [[NSMutableArray alloc] init];
//            for (int i = 0; i < ItemArray.count; i++) {
//                NSDictionary *itemDetailsDic = ItemArray[i];
//                NSArray *keys = @[@"itemId", @"itemPrice",@"quantity",@"item_name",@"size",@"color",@"model",@"make",@"totalCost",@"itemDesc",@"poRef",@"poItemId",@"skuId",PLU_CODE];
//                NSArray *objects = @[[NSString stringWithFormat:@"%@",[itemDetailsDic valueForKey:SKU_ID]],[NSString stringWithFormat:@"%@",[itemDetailsDic valueForKey:ITEM_UNIT_PRICE]],[NSString stringWithFormat:@"%@",[itemDetailsDic valueForKey:QUANTITY]],[NSString stringWithFormat:@"%@",[itemDetailsDic valueForKey:ITEM_DESCRIPTION]],@"35",@"blue",@"NA",@"NA",[NSString stringWithFormat:@"%@",[itemDetailsDic valueForKey:ITEM_TOTAL_PRICE]],[NSString stringWithFormat:@"%@",[itemDetailsDic valueForKey:ITEM_DESCRIPTION]],@"",@"1234",[itemDetailsDic valueForKey:SKU_ID], [itemDetailsDic valueForKey:PLU_CODE]];
//                NSDictionary *itemsDic = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
//
//                [items addObject:itemsDic];
//            }
//
//            purchaseOrdersSoapBinding *service = [purchaseOrdersSvc purchaseOrdersSoapBinding];
//            purchaseOrdersSvc_createPurchaseOrder *aparams = [[purchaseOrdersSvc_createPurchaseOrder alloc] init];
//            //        {"supplier_Id":"123456","supplier_name":"sanju","supplier_contact_name":"sanjana","Order_submitted_by":"sanju","Order_approved_by":"king","shipping_address":"hyd","shipping_mode":"flight","shipping_cost":100,"shipping_terms":"lklkasjdflkjas;dlkfj","delivery_due_date":"2015/04/01","credit_terms":"kjsafjasdhf","payment_terms":"payment terms","products_cost":1000,"total_tax":10,"total_po_value":65545,"remarks":"good or bad","shipping_address_street":"hyd","shipping_address_location":"hyd","shipping_address_city":"hyd","purchaseItems":[{"itemId":"5445","itemPrice":"45454","quantity":"5","item_name":"jsdkljas","size":"35","color":"jkf","model":"iasdf","make":"kjdshkjsdf","totalCost":"6544","itemDesc":"ksdfsakjdfh","poRef":"1000","poItemId":"13213"},{"itemId":"5445","itemPrice":"45454","quantity":"5","item_name":"jsdkljas","size":"35","color":"jkf","model":"iasdf","make":"kjdshkjsdf","totalCost":"6544","itemDesc":"ksdfsakjdfh","poRef":"1000","poItemId":"13213"}],"requestHeader":{"correlationId":"-","dateTime":"3/30/15","accessKey":"CID8995420","customerId":"CID8995420","applicationName":"omniRetailer","userName":"chandrasekhar.reddy@technolabssoftware.com"}}
//            NSArray *loyaltyKeys = @[@"supplier_Id", @"supplier_name",@"supplier_contact_name",@"order_submitted_by",@"order_approved_by",@"shipping_address",@"shipping_address_street",@"shipping_address_location",@"shipping_address_city",@"shipping_mode",@"shipping_cost",@"shipping_terms",@"delivery_due_date",@"credit_terms",@"payment_terms",@"products_cost",@"total_po_value",@"remarks",@"purchaseItems",@"requestHeader",@"order_date",@"storeLocation",@"status",@"pOShipmentLocations"];
//
//            NSArray *loyaltyObjects = @[customerCode.text,customerName.text,executiveName.text,shipmentID.text,saleLocation.text,shipment_location.text,shipment_street.text,shipment_location.text,shipment_city.text,shipoMode.text,orderShipCharges.text,shipCharges.text,dueDate.text,paymentMode.text,paymentType.text,subTotalData.text,totAmountData.text,remarksTextView.text,items,[RequestHeader getRequestHeader],dueDate.text,presentLocation,@"Submitted",poShipmentLocationArr];
//            NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
//
//            NSError * err_;
//            NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
//            NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//            //        aparams.userID = user_name;
//            //        aparams.orderDateTime = dateString;
//            //        aparams.deliveryDate = dueDate.text;
//            //        aparams.deliveryTime = time.text;
//            //        aparams.ordererEmail = email.text;
//            //        aparams.ordererMobile = phNo.text;
//            //        aparams.ordererAddress = address.text;
//            //        aparams.orderTotalPrice = totAmountData.text;
//            //        aparams.shipmentCharge = shipCharges.text;
//            //        aparams.shipmentMode = shipoMode.text;
//            //        aparams.paymentMode = paymentMode.text;
//            //        aparams.orderItems = str;
//            aparams.orderDetails = normalStockString;
//
//            purchaseOrdersSoapBindingResponse *response = [service createPurchaseOrderUsingParameters:(purchaseOrdersSvc_createPurchaseOrder *)aparams];
//
//            NSArray *responseBodyParts =  response.bodyParts;
//
//            for (id bodyPart in responseBodyParts) {
//                if ([bodyPart isKindOfClass:[purchaseOrdersSvc_createPurchaseOrderResponse class]]) {
//                    purchaseOrdersSvc_createPurchaseOrderResponse *body = (purchaseOrdersSvc_createPurchaseOrderResponse *)bodyPart;
//                    //printf("\nresponse=%s",body.return_);
//                    [self createOrderHandler:body.return_];
//                }
//            }
//        }
//        @catch (NSException *exception) {
//
//            [HUD setHidden:YES];
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Failed to create order" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//
//        }
//
//
//
//    }
//    // Show the HUD
//
//    //    }
//}


// Commented by roja on 17/10/2019.....

// Handle the response from createOrder.
//- (void) createOrderHandler: (NSString *) value {
//
//    // Do something with the BOOL result
//    NSString *result = [value copy];
//
//    // hiding the HUD ..
//    [HUD setHidden:YES];
//
//    NSError *e;
//
//    NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [result dataUsingEncoding:NSUTF8StringEncoding]
//                                                          options: NSJSONReadingMutableContainers
//                                                            error: &e];
//
//    NSDictionary *json = JSON1[@"responseHeader"];
//
//    if ([json[@"responseMessage"] isEqualToString:@"Order Created Succesfully"] && [json[@"responseCode"] isEqualToString:@"0"]) {
//
//        NSString *status = [NSString stringWithFormat:@"%@%@%@%@",@"Successfully Placed Ordered",@"\n",@"Order ID :",JSON1[@"orderId"]];
//        purchaseOrderID_ = [JSON1[@"orderId"] copy];
//        SystemSoundID    soundFileObject1;
//        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
//        self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
//        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
//        AudioServicesPlaySystemSound (soundFileObject1);
//
//        //        NSString *receiptID = [JSON objectForKey:@"receipt_id"];
//        //        receipt = [receiptID copy];
//        UIAlertView *successAlertView  = [[UIAlertView alloc] init];
//        successAlertView.delegate = self;
//        successAlertView.title = @"Success";
//        successAlertView.message = status;
//        [successAlertView addButtonWithTitle:@"OPEN ORDER"];
//        [successAlertView addButtonWithTitle:@"NEW ORDER"];
//
//        [successAlertView show];
//
//
//        customerCode.text = nil;
//        customerName.text = nil;
//        address.text = nil;
//        customerName.text = nil;
//        address.text= nil;
//        phNo.text = nil;
//        email.text = nil;
//        dueDate.text= nil;
//        time.text = nil;
//        shipCharges.text = nil;
//        paymentMode.text = nil;
//        shipoMode.text = nil;
//        executiveName.text = nil;
//        orderDate.text = nil;
//        shipment_city.text = nil;
//        shipment_location.text = nil;
//        shipment_street.text = nil;
//        billing_city.text = nil;
//        billing_location.text = nil;
//        billing_street.text = nil;
//        customer_city.text = nil;
//        customer_location.text = nil;
//        customer_street.text = nil;
//        orderChannel.text = nil;
//        orderDeliveryType.text = nil;
//        shipmentID.text = nil;
//        shipCharges.text = nil;
//        saleLocation.text = nil;
//        paymentType.text  = nil;
//
//        [skuIdArray removeAllObjects];
//        [ItemDiscArray removeAllObjects];
//        [totalArray removeAllObjects];
//        [QtyArray removeAllObjects];
//        [ItemArray removeAllObjects];
//        [totalQtyArray removeAllObjects];
//
//        subTotalData.text = @"0.00";
//        totAmountData.text = @"0.00";
//
//        [orderItemsTable reloadData];
//
//    }
//    else{
//        SystemSoundID    soundFileObject1;
//        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
//        self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
//        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
//        AudioServicesPlaySystemSound (soundFileObject1);
//
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed Placing Order" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//    }
//
//}




//orderButtonPressed method changed by roja on 17/10/2019.. // reason : removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST
- (void) orderButtonPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
   
    NSString *locationValue = [customerCode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *customerNameValue = [customerName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *executiveNameValue = [executiveName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *dueDateValue = [dueDate.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipment_cityValue = [shipment_city.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipment_streetValue = [shipment_street.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipoModeValue = [shipoMode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipmentIDValue = [shipmentID.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipChargesValue = [shipCharges.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *saleLocationValue = [saleLocation.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *paymentModeValue = [paymentMode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *paymentTypeValue = [paymentType.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    int shipmentQty = 0;
    
    for (NSMutableDictionary *locItemDic in poShipmentLocationArr) {
        shipmentQty += [[locItemDic valueForKey:QUANTITY] intValue];
        [locItemDic setValue:[locItemDic valueForKey:QUANTITY] forKey:@"quantityStr"];
        [locItemDic setValue:[locItemDic valueForKey:@"skuPrice"] forKey:@"skuPriceStr"];
    }
    
    if (ItemArray.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Add Items to Cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if (shipmentQty != (subTotalData.text).intValue){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Total ordered items and shipment location items are not same" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    else if(locationValue.length == 0 || customerNameValue.length == 0 || executiveNameValue.length == 0 || dueDateValue.length == 0 ||     shipment_cityValue.length == 0 || shipment_streetValue.length == 0  || shipoModeValue.length == 0 ||            shipmentIDValue.length == 0 || shipChargesValue.length == 0 || saleLocationValue.length == 0 ||            paymentModeValue.length == 0 || paymentTypeValue.length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Fields couldn't be empty" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    //    else if (!isNumber){
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Valid Mobile Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //        [alert show];
    //        [alert release];
    //    }
    //    else if (!isMail){
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter valid mail ID" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //        [alert show];
    //        [alert release];
    //    }
    else{
        HUD.labelText = @" Placing the order..";
        [HUD setHidden:NO];
        
        
        //        SDZOrderService* service = [SDZOrderService service];
        //        service.logging = YES;
        //
        //        // Returns BOOL.
        //         [service createOrder:self action:@selector(createOrderHandler:) userID:user_name orderDateTime: dateString deliveryDate: dueDate.text deliveryTime: time.text ordererEmail: email.text ordererMobile:phNo.text ordererAddress: address.text orderTotalPrice: totAmountData.text shipmentCharge: shipCharges.text shipmentMode:shipoMode.text paymentMode: paymentMode.text orderItems: str];
        @try {
            NSMutableArray *items = [[NSMutableArray alloc] init];
            for (int i = 0; i < ItemArray.count; i++) {
                NSDictionary *itemDetailsDic = ItemArray[i];
                NSArray *keys = @[@"itemId", @"itemPrice",@"quantity",@"item_name",@"size",@"color",@"model",@"make",@"totalCost",@"itemDesc",@"poRef",@"poItemId",@"skuId",PLU_CODE];
                NSArray *objects = @[[NSString stringWithFormat:@"%@",[itemDetailsDic valueForKey:SKU_ID]],[NSString stringWithFormat:@"%@",[itemDetailsDic valueForKey:ITEM_UNIT_PRICE]],[NSString stringWithFormat:@"%@",[itemDetailsDic valueForKey:QUANTITY]],[NSString stringWithFormat:@"%@",[itemDetailsDic valueForKey:ITEM_DESCRIPTION]],@"35",@"blue",@"NA",@"NA",[NSString stringWithFormat:@"%@",[itemDetailsDic valueForKey:ITEM_TOTAL_PRICE]],[NSString stringWithFormat:@"%@",[itemDetailsDic valueForKey:ITEM_DESCRIPTION]],@"",@"1234",[itemDetailsDic valueForKey:SKU_ID], [itemDetailsDic valueForKey:PLU_CODE]];
                NSDictionary *itemsDic = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
                
                [items addObject:itemsDic];
            }
            
            //        {"supplier_Id":"123456","supplier_name":"sanju","supplier_contact_name":"sanjana","Order_submitted_by":"sanju","Order_approved_by":"king","shipping_address":"hyd","shipping_mode":"flight","shipping_cost":100,"shipping_terms":"lklkasjdflkjas;dlkfj","delivery_due_date":"2015/04/01","credit_terms":"kjsafjasdhf","payment_terms":"payment terms","products_cost":1000,"total_tax":10,"total_po_value":65545,"remarks":"good or bad","shipping_address_street":"hyd","shipping_address_location":"hyd","shipping_address_city":"hyd","purchaseItems":[{"itemId":"5445","itemPrice":"45454","quantity":"5","item_name":"jsdkljas","size":"35","color":"jkf","model":"iasdf","make":"kjdshkjsdf","totalCost":"6544","itemDesc":"ksdfsakjdfh","poRef":"1000","poItemId":"13213"},{"itemId":"5445","itemPrice":"45454","quantity":"5","item_name":"jsdkljas","size":"35","color":"jkf","model":"iasdf","make":"kjdshkjsdf","totalCost":"6544","itemDesc":"ksdfsakjdfh","poRef":"1000","poItemId":"13213"}],"requestHeader":{"correlationId":"-","dateTime":"3/30/15","accessKey":"CID8995420","customerId":"CID8995420","applicationName":"omniRetailer","userName":"chandrasekhar.reddy@technolabssoftware.com"}}
            
            
            NSArray *loyaltyKeys = @[@"supplier_Id", @"supplier_name",@"supplier_contact_name",@"order_submitted_by",@"order_approved_by",@"shipping_address",@"shipping_address_street",@"shipping_address_location",@"shipping_address_city",@"shipping_mode",@"shipping_cost",@"shipping_terms",@"delivery_due_date",@"credit_terms",@"payment_terms",@"products_cost",@"total_po_value",@"remarks",@"purchaseItems",@"requestHeader",@"order_date",@"storeLocation",@"status",@"pOShipmentLocations"];
            
            NSArray *loyaltyObjects = @[customerCode.text,customerName.text,executiveName.text,shipmentID.text,saleLocation.text,shipment_location.text,shipment_street.text,shipment_location.text,shipment_city.text,shipoMode.text,orderShipCharges.text,shipCharges.text,dueDate.text,paymentMode.text,paymentType.text,subTotalData.text,totAmountData.text,remarksTextView.text,items,[RequestHeader getRequestHeader],dueDate.text,presentLocation,@"Submitted",poShipmentLocationArr];
            NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
            
            NSError * err_;
            NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
            NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
            
            WebServiceController * services  =  [[WebServiceController alloc] init];
            services.purchaseOrderSvcDelegate = self;
            [services createPurchaseOrder:normalStockString];

        }
        @catch (NSException *exception) {
            
            [HUD setHidden:YES];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Failed to create order" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    // Show the HUD
    //    }
}

// added by Roja on 17/10/2019….// OLD code only pasted here...
- (void)createPurchaseOrderSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        [self createOrderHandler:successDictionary];

    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}

// added by Roja on 17/10/2019….// OLD code only pasted here...
- (void)createPurchaseOrderErrorResponse:(NSString *)errorResponse{
    
    @try {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:errorResponse delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}


//createOrderHandler: method changed by roja on 17/10/2019.. // reason: changed according to latest REST service call...
// At the time of converting SOAP call's to REST
- (void) createOrderHandler: (NSDictionary *) successResponse {
    
//    if ([json[@"responseMessage"] isEqualToString:@"Order Created Succesfully"] && [json[@"responseCode"] isEqualToString:@"0"]) {
    
    if(successResponse != nil){
        
        NSString *status = [NSString stringWithFormat:@"%@%@%@%@",@"Successfully Placed Ordered",@"\n",@"Order ID :",successResponse[@"orderId"]];
        purchaseOrderID_ = [successResponse[@"orderId"] copy];
        SystemSoundID    soundFileObject1;
        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
        self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
        AudioServicesPlaySystemSound (soundFileObject1);
        
        //        NSString *receiptID = [JSON objectForKey:@"receipt_id"];
        //        receipt = [receiptID copy];
        UIAlertView *successAlertView  = [[UIAlertView alloc] init];
        successAlertView.delegate = self;
        successAlertView.title = @"Success";
        successAlertView.message = status;
        [successAlertView addButtonWithTitle:@"OPEN ORDER"];
        [successAlertView addButtonWithTitle:@"NEW ORDER"];
        
        [successAlertView show];
        
        
        customerCode.text = nil;
        customerName.text = nil;
        address.text = nil;
        customerName.text = nil;
        address.text= nil;
        phNo.text = nil;
        email.text = nil;
        dueDate.text= nil;
        time.text = nil;
        shipCharges.text = nil;
        paymentMode.text = nil;
        shipoMode.text = nil;
        executiveName.text = nil;
        orderDate.text = nil;
        shipment_city.text = nil;
        shipment_location.text = nil;
        shipment_street.text = nil;
        billing_city.text = nil;
        billing_location.text = nil;
        billing_street.text = nil;
        customer_city.text = nil;
        customer_location.text = nil;
        customer_street.text = nil;
        orderChannel.text = nil;
        orderDeliveryType.text = nil;
        shipmentID.text = nil;
        shipCharges.text = nil;
        saleLocation.text = nil;
        paymentType.text  = nil;
        
        [skuIdArray removeAllObjects];
        [ItemDiscArray removeAllObjects];
        [totalArray removeAllObjects];
        [QtyArray removeAllObjects];
        [ItemArray removeAllObjects];
        [totalQtyArray removeAllObjects];
        
        subTotalData.text = @"0.00";
        totAmountData.text = @"0.00";
        
        [orderItemsTable reloadData];
        
    }
    else{
        SystemSoundID    soundFileObject1;
        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
        self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
        AudioServicesPlaySystemSound (soundFileObject1);
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed Placing Order" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    if ([alertView.title isEqualToString:@"Success"]) {
        if (buttonIndex == 0) {
            self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
            
            ViewPurchaseOrder *vpo = [[ViewPurchaseOrder alloc] initWithorderID:purchaseOrderID_];
            [self.navigationController pushViewController:vpo animated:YES];
        }
        else{
            alertView.hidden = YES;
        }
    }
    
    if (alertView == warning) {
            
            if (buttonIndex == 0) {
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            else {
                [alertView dismissWithClickedButtonIndex:0 animated:YES];
            }
            
        }
}



// Commented by roja on 17/10/2019.. // reason :- cancelButtonPressed: method contains SOAP Service call .. so taken new method with same name(cancelButtonPressed:) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//- (void) cancelButtonPressed:(id) sender {
//
//    //Play Audio for button touch....
//    AudioServicesPlaySystemSound (soundFileObject);
//
////    [self.navigationController popViewControllerAnimated:YES];
//    if (ItemArray.count == 0) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Add Items to Cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//    }
//    else{
//        @try {
//            NSMutableArray *items = [[NSMutableArray alloc] init];
//            for (int i = 0; i < ItemArray.count; i++) {
//                NSDictionary *itemDetailsDic = ItemArray[i];
//                NSArray *keys = @[@"itemId", @"itemPrice",@"quantity",@"item_name",@"size",@"color",@"model",@"make",@"totalCost",@"itemDesc",@"poRef",@"poItemId",@"skuId",PLU_CODE];
//                NSArray *objects = @[[NSString stringWithFormat:@"%@",[itemDetailsDic valueForKey:SKU_ID]],[NSString stringWithFormat:@"%@",[itemDetailsDic valueForKey:ITEM_UNIT_PRICE]],[NSString stringWithFormat:@"%@",[itemDetailsDic valueForKey:QUANTITY]],[NSString stringWithFormat:@"%@",[itemDetailsDic valueForKey:ITEM_DESCRIPTION]],@"35",@"blue",@"NA",@"NA",[NSString stringWithFormat:@"%@",[itemDetailsDic valueForKey:ITEM_TOTAL_PRICE]],[NSString stringWithFormat:@"%@",[itemDetailsDic valueForKey:ITEM_DESCRIPTION]],@"",@"1234",[itemDetailsDic valueForKey:SKU_ID], [itemDetailsDic valueForKey:PLU_CODE]];
//                NSDictionary *itemsDic = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
//
//                [items addObject:itemsDic];
//            }
//
//            purchaseOrdersSoapBinding *service = [purchaseOrdersSvc purchaseOrdersSoapBinding];
//            purchaseOrdersSvc_createPurchaseOrder *aparams = [[purchaseOrdersSvc_createPurchaseOrder alloc] init];
//            //        {"supplier_Id":"123456","supplier_name":"sanju","supplier_contact_name":"sanjana","Order_submitted_by":"sanju","Order_approved_by":"king","shipping_address":"hyd","shipping_mode":"flight","shipping_cost":100,"shipping_terms":"lklkasjdflkjas;dlkfj","delivery_due_date":"2015/04/01","credit_terms":"kjsafjasdhf","payment_terms":"payment terms","products_cost":1000,"total_tax":10,"total_po_value":65545,"remarks":"good or bad","shipping_address_street":"hyd","shipping_address_location":"hyd","shipping_address_city":"hyd","purchaseItems":[{"itemId":"5445","itemPrice":"45454","quantity":"5","item_name":"jsdkljas","size":"35","color":"jkf","model":"iasdf","make":"kjdshkjsdf","totalCost":"6544","itemDesc":"ksdfsakjdfh","poRef":"1000","poItemId":"13213"},{"itemId":"5445","itemPrice":"45454","quantity":"5","item_name":"jsdkljas","size":"35","color":"jkf","model":"iasdf","make":"kjdshkjsdf","totalCost":"6544","itemDesc":"ksdfsakjdfh","poRef":"1000","poItemId":"13213"}],"requestHeader":{"correlationId":"-","dateTime":"3/30/15","accessKey":"CID8995420","customerId":"CID8995420","applicationName":"omniRetailer","userName":"chandrasekhar.reddy@technolabssoftware.com"}}
//            NSArray *loyaltyKeys = @[@"supplier_Id", @"supplier_name",@"supplier_contact_name",@"order_submitted_by",@"order_approved_by",@"shipping_address",@"shipping_address_street",@"shipping_address_location",@"shipping_address_city",@"shipping_mode",@"shipping_cost",@"shipping_terms",@"delivery_due_date",@"credit_terms",@"payment_terms",@"products_cost",@"total_po_value",@"remarks",@"purchaseItems",@"requestHeader",@"order_date",@"storeLocation",@"Status",@"pOShipmentLocations"];
//
//            NSArray *loyaltyObjects = @[customerCode.text,customerName.text,executiveName.text,shipmentID.text,saleLocation.text,shipment_location.text,shipment_street.text,shipment_location.text,shipment_city.text,shipoMode.text,orderShipCharges.text,shipCharges.text,dueDate.text,paymentMode.text,paymentType.text,subTotalData.text,totAmountData.text,remarksTextView.text,items,[RequestHeader getRequestHeader],dueDate.text,presentLocation,@"Pending",poShipmentLocationArr];
//            NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
//
//            NSError * err_;
//            NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
//            NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//            //        aparams.userID = user_name;
//            //        aparams.orderDateTime = dateString;
//            //        aparams.deliveryDate = dueDate.text;
//            //        aparams.deliveryTime = time.text;
//            //        aparams.ordererEmail = email.text;
//            //        aparams.ordererMobile = phNo.text;
//            //        aparams.ordererAddress = address.text;
//            //        aparams.orderTotalPrice = totAmountData.text;
//            //        aparams.shipmentCharge = shipCharges.text;
//            //        aparams.shipmentMode = shipoMode.text;
//            //        aparams.paymentMode = paymentMode.text;
//            //        aparams.orderItems = str;
//            aparams.orderDetails = normalStockString;
//
//            purchaseOrdersSoapBindingResponse *response = [service createPurchaseOrderUsingParameters:(purchaseOrdersSvc_createPurchaseOrder *)aparams];
//
//            NSArray *responseBodyParts =  response.bodyParts;
//
//            for (id bodyPart in responseBodyParts) {
//                if ([bodyPart isKindOfClass:[purchaseOrdersSvc_createPurchaseOrderResponse class]]) {
//                    purchaseOrdersSvc_createPurchaseOrderResponse *body = (purchaseOrdersSvc_createPurchaseOrderResponse *)bodyPart;
//                    //printf("\nresponse=%s",body.return_);
//                    [self createOrderHandler:body.return_];
//                }
//            }
//        }
//        @catch (NSException *exception) {
//
//            [HUD setHidden:YES];
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Failed to create order" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//
//        }
//
//    }
//}


//cancelButtonPressed: method changed by roja on 17/10/2019.. // reason : removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST

- (void) cancelButtonPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    //    [self.navigationController popViewControllerAnimated:YES];
    if (ItemArray.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Add Items to Cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else{
        @try {
            NSMutableArray *items = [[NSMutableArray alloc] init];
            for (int i = 0; i < ItemArray.count; i++) {
                NSDictionary *itemDetailsDic = ItemArray[i];
                NSArray *keys = @[@"itemId", @"itemPrice",@"quantity",@"item_name",@"size",@"color",@"model",@"make",@"totalCost",@"itemDesc",@"poRef",@"poItemId",@"skuId",PLU_CODE];
                NSArray *objects = @[[NSString stringWithFormat:@"%@",[itemDetailsDic valueForKey:SKU_ID]],[NSString stringWithFormat:@"%@",[itemDetailsDic valueForKey:ITEM_UNIT_PRICE]],[NSString stringWithFormat:@"%@",[itemDetailsDic valueForKey:QUANTITY]],[NSString stringWithFormat:@"%@",[itemDetailsDic valueForKey:ITEM_DESCRIPTION]],@"35",@"blue",@"NA",@"NA",[NSString stringWithFormat:@"%@",[itemDetailsDic valueForKey:ITEM_TOTAL_PRICE]],[NSString stringWithFormat:@"%@",[itemDetailsDic valueForKey:ITEM_DESCRIPTION]],@"",@"1234",[itemDetailsDic valueForKey:SKU_ID], [itemDetailsDic valueForKey:PLU_CODE]];
                NSDictionary *itemsDic = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
                
                [items addObject:itemsDic];
            }
            
            //        {"supplier_Id":"123456","supplier_name":"sanju","supplier_contact_name":"sanjana","Order_submitted_by":"sanju","Order_approved_by":"king","shipping_address":"hyd","shipping_mode":"flight","shipping_cost":100,"shipping_terms":"lklkasjdflkjas;dlkfj","delivery_due_date":"2015/04/01","credit_terms":"kjsafjasdhf","payment_terms":"payment terms","products_cost":1000,"total_tax":10,"total_po_value":65545,"remarks":"good or bad","shipping_address_street":"hyd","shipping_address_location":"hyd","shipping_address_city":"hyd","purchaseItems":[{"itemId":"5445","itemPrice":"45454","quantity":"5","item_name":"jsdkljas","size":"35","color":"jkf","model":"iasdf","make":"kjdshkjsdf","totalCost":"6544","itemDesc":"ksdfsakjdfh","poRef":"1000","poItemId":"13213"},{"itemId":"5445","itemPrice":"45454","quantity":"5","item_name":"jsdkljas","size":"35","color":"jkf","model":"iasdf","make":"kjdshkjsdf","totalCost":"6544","itemDesc":"ksdfsakjdfh","poRef":"1000","poItemId":"13213"}],"requestHeader":{"correlationId":"-","dateTime":"3/30/15","accessKey":"CID8995420","customerId":"CID8995420","applicationName":"omniRetailer","userName":"chandrasekhar.reddy@technolabssoftware.com"}}
            NSArray *loyaltyKeys = @[@"supplier_Id", @"supplier_name",@"supplier_contact_name",@"order_submitted_by",@"order_approved_by",@"shipping_address",@"shipping_address_street",@"shipping_address_location",@"shipping_address_city",@"shipping_mode",@"shipping_cost",@"shipping_terms",@"delivery_due_date",@"credit_terms",@"payment_terms",@"products_cost",@"total_po_value",@"remarks",@"purchaseItems",@"requestHeader",@"order_date",@"storeLocation",@"Status",@"pOShipmentLocations"];
            
            NSArray *loyaltyObjects = @[customerCode.text,customerName.text,executiveName.text,shipmentID.text,saleLocation.text,shipment_location.text,shipment_street.text,shipment_location.text,shipment_city.text,shipoMode.text,orderShipCharges.text,shipCharges.text,dueDate.text,paymentMode.text,paymentType.text,subTotalData.text,totAmountData.text,remarksTextView.text,items,[RequestHeader getRequestHeader],dueDate.text,presentLocation,@"Pending",poShipmentLocationArr];
            NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
            
            NSError * err_;
            NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
            NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
           
            WebServiceController * services  = [[WebServiceController alloc] init];
            services.purchaseOrderSvcDelegate = self;
            [services createPurchaseOrder:normalStockString];
            
        }
        @catch (NSException *exception) {
            
            [HUD setHidden:YES];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Failed to create order" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        
    }
}


// Commented by roja on 17/10/2019.. // reason :- firstButtonPressed: method contains SOAP Service call .. so taken new method with same name(firstButtonPressed:) method name which contains REST service call....
// At the time of converting SOAP call's to REST
//-(void) firstButtonPressed:(id) sender {
//
//    AudioServicesPlaySystemSound (soundFileObject);
//
//    [itemIdArray removeAllObjects];
//    [orderStatusArray removeAllObjects];
//    [orderAmountArray removeAllObjects];
//    [OrderedOnArray removeAllObjects];
//    purchaseChangeNum_ = 0;
//    //    cellcount = 10;
//
//    //[HUD setHidden:NO];
//    [HUD show:YES];
//
////    OrderServiceSoapBinding *custBindng =  [[OrderServiceSvc OrderServiceSoapBinding] retain];
////    OrderServiceSvc_getOrders *aParameters = [[OrderServiceSvc_getOrders alloc] init];
////
////    //    aParameters.userID = user_name;
////    //    aParameters.pageNumber = [NSString stringWithFormat:@"%d",changeNum];
////
////    NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
////    NSArray *str_ = [time_ componentsSeparatedByString:@" "];
////    NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
////    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
////
////    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
////    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
////    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"requestHeader", nil];
////
////    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",changeNum_],dictionary, nil];
////    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
////
////    NSError * err_;
////    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
////    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
////    aParameters.orderDetails = normalStockString;
////
////    OrderServiceSoapBindingResponse *response = [custBindng getOrdersUsingParameters:(OrderServiceSvc_getOrders *)aParameters];
////    NSArray *responseBodyParts = response.bodyParts;
////    for (id bodyPart in responseBodyParts) {
////        if ([bodyPart isKindOfClass:[OrderServiceSvc_getOrdersResponse class]]) {
////            OrderServiceSvc_getOrdersResponse *body = (OrderServiceSvc_getOrdersResponse *)bodyPart;
////            //printf("\nresponse",body.getPreviousOrdersReturn);
////            NSLog(@"%@",body.return_);
////
////            if (body.return_ == NULL) {
////
////                [HUD setHidden:YES];
////                //nextButton.backgroundColor = [UIColor lightGrayColor];
////                firstButton.enabled = NO;
////                lastButton.enabled = NO;
////                nextButton.enabled = NO;
////                recStart.text  = @"0";
////                recEnd.text  = @"0";
////                totalRec.text  = @"0";
////                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Ordered Items Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
////                [alert show];
////            }
////            else{
////
////                [self getPreviousOrdersHandler:body.return_];
////            }
////        }
////    }
//    purchaseOrdersSoapBinding *service = [purchaseOrdersSvc purchaseOrdersSoapBinding];
//    purchaseOrdersSvc_getPurchaseOrders *aparams = [[purchaseOrdersSvc_getPurchaseOrders alloc] init];
//    NSArray *loyaltyKeys = @[@"startIndex",@"requestHeader"];
//
//    NSArray *loyaltyObjects = @[[NSString stringWithFormat:@"%d",purchaseChangeNum_],[RequestHeader getRequestHeader]];
//    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
//
//    NSError * err_;
//    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
//    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//    //        aparams.userID = user_name;
//    //        aparams.orderDateTime = dateString;
//    //        aparams.deliveryDate = dueDate.text;
//    //        aparams.deliveryTime = time.text;
//    //        aparams.ordererEmail = email.text;
//    //        aparams.ordererMobile = phNo.text;
//    //        aparams.ordererAddress = address.text;
//    //        aparams.orderTotalPrice = totAmountData.text;
//    //        aparams.shipmentCharge = shipCharges.text;
//    //        aparams.shipmentMode = shipoMode.text;
//    //        aparams.paymentMode = paymentMode.text;
//    //        aparams.orderItems = str;
//    aparams.orderDetails = normalStockString;
//    purchaseOrdersSoapBindingResponse *response = [service getPurchaseOrdersUsingParameters:(purchaseOrdersSvc_getPurchaseOrders *)aparams];
//
//    NSArray *responseBodyParts =  response.bodyParts;
//
//    for (id bodyPart in responseBodyParts) {
//        if ([bodyPart isKindOfClass:[purchaseOrdersSvc_getPurchaseOrdersResponse class]]) {
//            purchaseOrdersSvc_getPurchaseOrdersResponse *body = (purchaseOrdersSvc_getPurchaseOrdersResponse *)bodyPart;
//            //printf("\nresponse=%s",body.return_);
//            if (body.return_ == NULL) {
//
//                [HUD setHidden:YES];
//                //nextButton.backgroundColor = [UIColor lightGrayColor];
//                firstButton.enabled = NO;
//                lastButton.enabled = NO;
//                nextButton.enabled = NO;
//                recStart.text  = @"0";
//                recEnd.text  = @"0";
//                totalRec.text  = @"0";
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Ordered Items Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                [alert show];
//            }
//            else{
//
//                [self getPreviousOrdersHandler:body.return_];
//            }
//
//        }
//    }
//}


// Commented by roja on 17/10/2019.. // reason :- lastButtonPressed: method contains SOAP Service call .. so taken new method with same name(lastButtonPressed:) method name which contains REST service call....
// At the time of converting SOAP call's to REST

// last button pressed....
//-(void) lastButtonPressed:(id) sender {
//
//    //Play Audio for button touch....
//    AudioServicesPlaySystemSound (soundFileObject);
//
//    //float a = [rec_total.text intValue]/5;
//    //float t = ([rec_total.text floatValue]/5);
//
//    if ((totalRec.text).intValue/10 == ((totalRec.text).floatValue/10)) {
//
//        purchaseChangeNum_ = (totalRec.text).intValue/10 - 1;
//    }
//    else{
//        purchaseChangeNum_ =(totalRec.text).intValue/10;
//    }
//    //changeID = ([rec_total.text intValue]/5) - 1;
//
//    //previousButton.backgroundColor = [UIColor grayColor];
//    purchaseCount1_ = (purchaseChangeNum_ * 10);
//
//    [itemIdArray removeAllObjects];
//    [orderStatusArray removeAllObjects];
//    [orderAmountArray removeAllObjects];
//    [OrderedOnArray removeAllObjects];
//
//    previousButton.enabled = YES;
//
//
//    //frstButton.backgroundColor = [UIColor grayColor];
//    firstButton.enabled = YES;
//    nextButton.enabled = NO;
//
//    //[HUD setHidden:NO];
//    [HUD show:YES];
//
////    OrderServiceSoapBinding *custBindng =  [[OrderServiceSvc OrderServiceSoapBinding] retain];
////    OrderServiceSvc_getOrders *aParameters = [[OrderServiceSvc_getOrders alloc] init];
////
////    //    aParameters.userID = user_name;
////    //    aParameters.pageNumber = [NSString stringWithFormat:@"%d",changeNum];
////
////    NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
////    NSArray *str_ = [time_ componentsSeparatedByString:@" "];
////    NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
////    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
////
////    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
////    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
////    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"requestHeader", nil];
////
////    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",count1_],dictionary, nil];
////    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
////
////    NSError * err_;
////    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
////    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
////    aParameters.orderDetails = normalStockString;
////
////    OrderServiceSoapBindingResponse *response = [custBindng getOrdersUsingParameters:(OrderServiceSvc_getOrders *)aParameters];
////    NSArray *responseBodyParts = response.bodyParts;
////    for (id bodyPart in responseBodyParts) {
////        if ([bodyPart isKindOfClass:[OrderServiceSvc_getOrdersResponse class]]) {
////            OrderServiceSvc_getOrdersResponse *body = (OrderServiceSvc_getOrdersResponse *)bodyPart;
////            //printf("\nresponse",body.getPreviousOrdersReturn);
////            NSLog(@"%@",body.return_);
////
////            if (body.return_ == NULL) {
////
////                [HUD setHidden:YES];
////                //nextButton.backgroundColor = [UIColor lightGrayColor];
////                firstButton.enabled = NO;
////                lastButton.enabled = NO;
////                nextButton.enabled = NO;
////                recStart.text  = @"0";
////                recEnd.text  = @"0";
////                totalRec.text  = @"0";
////                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Ordered Items Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
////                [alert show];
////            }
////            else{
////
////                [self getPreviousOrdersHandler:body.return_];
////            }
////        }
////    }
//    purchaseOrdersSoapBinding *service = [purchaseOrdersSvc purchaseOrdersSoapBinding];
//    purchaseOrdersSvc_getPurchaseOrders *aparams = [[purchaseOrdersSvc_getPurchaseOrders alloc] init];
//    NSArray *loyaltyKeys = @[@"startIndex",@"requestHeader"];
//
//    NSArray *loyaltyObjects = @[[NSString stringWithFormat:@"%d",purchaseCount1_],[RequestHeader getRequestHeader]];
//    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
//
//    NSError * err_;
//    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
//    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//    //        aparams.userID = user_name;
//    //        aparams.orderDateTime = dateString;
//    //        aparams.deliveryDate = dueDate.text;
//    //        aparams.deliveryTime = time.text;
//    //        aparams.ordererEmail = email.text;
//    //        aparams.ordererMobile = phNo.text;
//    //        aparams.ordererAddress = address.text;
//    //        aparams.orderTotalPrice = totAmountData.text;
//    //        aparams.shipmentCharge = shipCharges.text;
//    //        aparams.shipmentMode = shipoMode.text;
//    //        aparams.paymentMode = paymentMode.text;
//    //        aparams.orderItems = str;
//    aparams.orderDetails = normalStockString;
//    purchaseOrdersSoapBindingResponse *response = [service getPurchaseOrdersUsingParameters:(purchaseOrdersSvc_getPurchaseOrders *)aparams];
//
//    NSArray *responseBodyParts =  response.bodyParts;
//
//    for (id bodyPart in responseBodyParts) {
//        if ([bodyPart isKindOfClass:[purchaseOrdersSvc_getPurchaseOrdersResponse class]]) {
//            purchaseOrdersSvc_getPurchaseOrdersResponse *body = (purchaseOrdersSvc_getPurchaseOrdersResponse *)bodyPart;
//            //printf("\nresponse=%s",body.return_);
//            if (body.return_ == NULL) {
//
//                [HUD setHidden:YES];
//                //nextButton.backgroundColor = [UIColor lightGrayColor];
//                firstButton.enabled = NO;
//                lastButton.enabled = NO;
//                nextButton.enabled = NO;
//                recStart.text  = @"0";
//                recEnd.text  = @"0";
//                totalRec.text  = @"0";
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Ordered Items Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                [alert show];
//            }
//            else{
//
//                [self getPreviousOrdersHandler:body.return_];
//            }
//
//        }
//    }
//
//}


// Commented by roja on 17/10/2019.. // reason :- previousButtonPressed: method contains SOAP Service call .. so taken new method with same name(previousButtonPressed:) method name which contains REST service call....
// At the time of converting SOAP call's to REST

// previousButtonPressed handing...
//- (void) previousButtonPressed:(id) sender {
//
//    //Play Audio for button touch....
//    AudioServicesPlaySystemSound (soundFileObject);
//
//    if (purchaseChangeNum_ > 0){
//
//        //nextButton.backgroundColor = [UIColor grayColor];
//        nextButton.enabled =  YES;
//
//        purchaseChangeNum_--;
//        purchaseCount1_ = (purchaseChangeNum_ * 10);
//
//        [itemIdArray removeAllObjects];
//        [orderStatusArray removeAllObjects];
//        [orderAmountArray removeAllObjects];
//        [OrderedOnArray removeAllObjects];
//
//        purchaseCountValue_ = NO;
//
//        [HUD setHidden:NO];
//
////        OrderServiceSoapBinding *custBindng =  [[OrderServiceSvc OrderServiceSoapBinding] retain];
////        OrderServiceSvc_getOrders *aParameters = [[OrderServiceSvc_getOrders alloc] init];
////
////        //    aParameters.userID = user_name;
////        //    aParameters.pageNumber = [NSString stringWithFormat:@"%d",changeNum];
////
////        NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
////        NSArray *str_ = [time_ componentsSeparatedByString:@" "];
////        NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
////        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
////
////        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
////        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
////        NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"requestHeader", nil];
////
////        NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",count1_],dictionary, nil];
////        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
////
////        NSError * err_;
////        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
////        NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
////        aParameters.orderDetails = normalStockString;
////
////        OrderServiceSoapBindingResponse *response = [custBindng getOrdersUsingParameters:(OrderServiceSvc_getOrders *)aParameters];
////        NSArray *responseBodyParts = response.bodyParts;
////        for (id bodyPart in responseBodyParts) {
////            if ([bodyPart isKindOfClass:[OrderServiceSvc_getOrdersResponse class]]) {
////                OrderServiceSvc_getOrdersResponse *body = (OrderServiceSvc_getOrdersResponse *)bodyPart;
////                //printf("\nresponse",body.getPreviousOrdersReturn);
////                NSLog(@"%@",body.return_);
////
////                if (body.return_ == NULL) {
////
////                    [HUD setHidden:YES];
////                    //nextButton.backgroundColor = [UIColor lightGrayColor];
////                    firstButton.enabled = NO;
////                    lastButton.enabled = NO;
////                    nextButton.enabled = NO;
////                    recStart.text  = @"0";
////                    recEnd.text  = @"0";
////                    totalRec.text  = @"0";
////                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Ordered Items Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
////                    [alert show];
////                }
////                else{
////
////                    [self getPreviousOrdersHandler:body.return_];
////                }
////            }
////        }
//        purchaseOrdersSoapBinding *service = [purchaseOrdersSvc purchaseOrdersSoapBinding];
//        purchaseOrdersSvc_getPurchaseOrders *aparams = [[purchaseOrdersSvc_getPurchaseOrders alloc] init];
//        NSArray *loyaltyKeys = @[@"startIndex",@"requestHeader"];
//
//        NSArray *loyaltyObjects = @[[NSString stringWithFormat:@"%d",purchaseCount1_],[RequestHeader getRequestHeader]];
//        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
//
//        NSError * err_;
//        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
//        NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//        //        aparams.userID = user_name;
//        //        aparams.orderDateTime = dateString;
//        //        aparams.deliveryDate = dueDate.text;
//        //        aparams.deliveryTime = time.text;
//        //        aparams.ordererEmail = email.text;
//        //        aparams.ordererMobile = phNo.text;
//        //        aparams.ordererAddress = address.text;
//        //        aparams.orderTotalPrice = totAmountData.text;
//        //        aparams.shipmentCharge = shipCharges.text;
//        //        aparams.shipmentMode = shipoMode.text;
//        //        aparams.paymentMode = paymentMode.text;
//        //        aparams.orderItems = str;
//        aparams.orderDetails = normalStockString;
//        purchaseOrdersSoapBindingResponse *response = [service getPurchaseOrdersUsingParameters:(purchaseOrdersSvc_getPurchaseOrders *)aparams];
//
//        NSArray *responseBodyParts =  response.bodyParts;
//
//        for (id bodyPart in responseBodyParts) {
//            if ([bodyPart isKindOfClass:[purchaseOrdersSvc_getPurchaseOrdersResponse class]]) {
//                purchaseOrdersSvc_getPurchaseOrdersResponse *body = (purchaseOrdersSvc_getPurchaseOrdersResponse *)bodyPart;
//                //printf("\nresponse=%s",body.return_);
//                if (body.return_ == NULL) {
//
//                    [HUD setHidden:YES];
//                    //nextButton.backgroundColor = [UIColor lightGrayColor];
//                    firstButton.enabled = NO;
//                    lastButton.enabled = NO;
//                    nextButton.enabled = NO;
//                    recStart.text  = @"0";
//                    recEnd.text  = @"0";
//                    totalRec.text  = @"0";
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Ordered Items Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                    [alert show];
//                }
//                else{
//
//                    [self getPreviousOrdersHandler:body.return_];
//                }
//
//            }
//        }
//
//
//        if ([recEnd.text isEqualToString:totalRec.text]) {
//
//            lastButton.enabled = NO;
//        }
//        else {
//            lastButton.enabled = YES;
//        }
//
//        // count1 = [itemIdArray count];
//    }
//    else{
//        //previousButton.backgroundColor = [UIColor lightGrayColor];
//        previousButton.enabled =  NO;
//
//        //nextButton.backgroundColor = [UIColor grayColor];
//        nextButton.enabled =  YES;
//    }
//
//}


// Commented by roja on 17/10/2019.. // reason :- nextButtonPressed: method contains SOAP Service call .. so taken new method with same name(nextButtonPressed:) method name which contains REST service call....
// At the time of converting SOAP call's to REST

// NextButtonPressed handing...
//- (void) nextButtonPressed:(id) sender {
//
//    //Play Audio for button touch....
//    AudioServicesPlaySystemSound (soundFileObject);
//
//    purchaseChangeNum_++;
//
//    purchaseCount1_ = (purchaseChangeNum_ * 10);
//
//    [itemIdArray removeAllObjects];
//    [orderStatusArray removeAllObjects];
//    [orderAmountArray removeAllObjects];
//    [OrderedOnArray removeAllObjects];
//
//    //previousButton.backgroundColor = [UIColor grayColor];
//    previousButton.enabled =  YES;
//    firstButton.enabled = YES;
//
//    purchaseCountValue_ = YES;
//
//    [HUD setHidden:NO];
//
////    OrderServiceSoapBinding *custBindng =  [[OrderServiceSvc OrderServiceSoapBinding] retain];
////    OrderServiceSvc_getOrders *aParameters = [[OrderServiceSvc_getOrders alloc] init];
////
////    //    aParameters.userID = user_name;
////    //    aParameters.pageNumber = [NSString stringWithFormat:@"%d",changeNum];
////
////    NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
////    NSArray *str_ = [time_ componentsSeparatedByString:@" "];
////    NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
////    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
////
////    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
////    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
////    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"requestHeader", nil];
////
////    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",count1_],dictionary, nil];
////    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
////
////    NSError * err_;
////    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
////    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
////    aParameters.orderDetails = normalStockString;
////
////    OrderServiceSoapBindingResponse *response = [custBindng getOrdersUsingParameters:(OrderServiceSvc_getOrders *)aParameters];
////    NSArray *responseBodyParts = response.bodyParts;
////    for (id bodyPart in responseBodyParts) {
////        if ([bodyPart isKindOfClass:[OrderServiceSvc_getOrdersResponse class]]) {
////            OrderServiceSvc_getOrdersResponse *body = (OrderServiceSvc_getOrdersResponse *)bodyPart;
////            //printf("\nresponse",body.getPreviousOrdersReturn);
////            NSLog(@"%@",body.return_);
////
////            if (body.return_ == NULL) {
////
////                [HUD setHidden:YES];
////                //nextButton.backgroundColor = [UIColor lightGrayColor];
////                firstButton.enabled = NO;
////                lastButton.enabled = NO;
////                nextButton.enabled = NO;
////                recStart.text  = @"0";
////                recEnd.text  = @"0";
////                totalRec.text  = @"0";
////                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Ordered Items Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
////                [alert show];
////            }
////            else{
////
////                [self getPreviousOrdersHandler:body.return_];
////            }
////        }
////    }
//    purchaseOrdersSoapBinding *service = [purchaseOrdersSvc purchaseOrdersSoapBinding];
//    purchaseOrdersSvc_getPurchaseOrders *aparams = [[purchaseOrdersSvc_getPurchaseOrders alloc] init];
//    NSArray *loyaltyKeys = @[@"startIndex",@"requestHeader"];
//
//    NSArray *loyaltyObjects = @[[NSString stringWithFormat:@"%d",purchaseCount1_],[RequestHeader getRequestHeader]];
//    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
//
//    NSError * err_;
//    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
//    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//    //        aparams.userID = user_name;
//    //        aparams.orderDateTime = dateString;
//    //        aparams.deliveryDate = dueDate.text;
//    //        aparams.deliveryTime = time.text;
//    //        aparams.ordererEmail = email.text;
//    //        aparams.ordererMobile = phNo.text;
//    //        aparams.ordererAddress = address.text;
//    //        aparams.orderTotalPrice = totAmountData.text;
//    //        aparams.shipmentCharge = shipCharges.text;
//    //        aparams.shipmentMode = shipoMode.text;
//    //        aparams.paymentMode = paymentMode.text;
//    //        aparams.orderItems = str;
//    aparams.orderDetails = normalStockString;
//    purchaseOrdersSoapBindingResponse *response = [service getPurchaseOrdersUsingParameters:(purchaseOrdersSvc_getPurchaseOrders *)aparams];
//
//    NSArray *responseBodyParts =  response.bodyParts;
//
//    for (id bodyPart in responseBodyParts) {
//        if ([bodyPart isKindOfClass:[purchaseOrdersSvc_getPurchaseOrdersResponse class]]) {
//            purchaseOrdersSvc_getPurchaseOrdersResponse *body = (purchaseOrdersSvc_getPurchaseOrdersResponse *)bodyPart;
//            //printf("\nresponse=%s",body.return_);
//            if (body.return_ == NULL) {
//
//                [HUD setHidden:YES];
//                //nextButton.backgroundColor = [UIColor lightGrayColor];
//                firstButton.enabled = NO;
//                lastButton.enabled = NO;
//                nextButton.enabled = NO;
//                recStart.text  = @"0";
//                recEnd.text  = @"0";
//                totalRec.text  = @"0";
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Ordered Items Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                [alert show];
//            }
//            else{
//
//                [self getPreviousOrdersHandler:body.return_];
//            }
//
//        }
//    }
//
//}


//firstButtonPressed: method changed by roja on 17/10/2019.. // reason :- removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST
-(void) firstButtonPressed:(id) sender {
    
    AudioServicesPlaySystemSound (soundFileObject);
    
    [itemIdArray removeAllObjects];
    [orderStatusArray removeAllObjects];
    [orderAmountArray removeAllObjects];
    [OrderedOnArray removeAllObjects];
    purchaseChangeNum_ = 0;
    //    cellcount = 10;
    
    [HUD setHidden:NO];
    [HUD show:YES];
    
    NSArray *loyaltyKeys = @[@"startIndex",@"requestHeader"];
    
    NSArray *loyaltyObjects = @[[NSString stringWithFormat:@"%d",purchaseChangeNum_],[RequestHeader getRequestHeader]];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
    
    NSError * err_;
    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
    
    WebServiceController * services = [[WebServiceController alloc] init];
    services.purchaseOrderSvcDelegate =  self;
    [services getPurchaseOrders:normalStockString];
    
}

//lastButtonPressed: method changed by roja on 17/10/2019.. // reason : removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST
// last button pressed....
-(void) lastButtonPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    //float a = [rec_total.text intValue]/5;
    //float t = ([rec_total.text floatValue]/5);
    
    if ((totalRec.text).intValue/10 == ((totalRec.text).floatValue/10)) {
        
        purchaseChangeNum_ = (totalRec.text).intValue/10 - 1;
    }
    else{
        purchaseChangeNum_ =(totalRec.text).intValue/10;
    }
    //changeID = ([rec_total.text intValue]/5) - 1;
    
    //previousButton.backgroundColor = [UIColor grayColor];
    purchaseCount1_ = (purchaseChangeNum_ * 10);
    
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
   
    
    NSArray *loyaltyKeys = @[@"startIndex",@"requestHeader"];
    
    NSArray *loyaltyObjects = @[[NSString stringWithFormat:@"%d",purchaseCount1_],[RequestHeader getRequestHeader]];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
    
    NSError * err_;
    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
    
    WebServiceController * services = [[WebServiceController alloc] init];
    services.purchaseOrderSvcDelegate =  self;
    [services getPurchaseOrders:normalStockString];

}

//previousButtonPressed: method changed by roja on 17/10/2019.. // reason : removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST
- (void) previousButtonPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    if (purchaseChangeNum_ > 0){
        
        //nextButton.backgroundColor = [UIColor grayColor];
        nextButton.enabled =  YES;
        
        purchaseChangeNum_--;
        purchaseCount1_ = (purchaseChangeNum_ * 10);
        
        [itemIdArray removeAllObjects];
        [orderStatusArray removeAllObjects];
        [orderAmountArray removeAllObjects];
        [OrderedOnArray removeAllObjects];
        
        purchaseCountValue_ = NO;
        [HUD setHidden:NO];
        
        NSArray *loyaltyKeys = @[@"startIndex",@"requestHeader"];
        NSArray *loyaltyObjects = @[[NSString stringWithFormat:@"%d",purchaseCount1_],[RequestHeader getRequestHeader]];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
     
        
        WebServiceController * services = [[WebServiceController alloc] init];
        services.purchaseOrderSvcDelegate =  self;
        [services getPurchaseOrders:normalStockString];
        
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

//nextButtonPressed: method changed by roja on 17/10/2019.. // reason : removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST
- (void) nextButtonPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    purchaseChangeNum_++;
    
    purchaseCount1_ = (purchaseChangeNum_ * 10);
    
    [itemIdArray removeAllObjects];
    [orderStatusArray removeAllObjects];
    [orderAmountArray removeAllObjects];
    [OrderedOnArray removeAllObjects];
    
    //previousButton.backgroundColor = [UIColor grayColor];
    previousButton.enabled =  YES;
    firstButton.enabled = YES;
    
    purchaseCountValue_ = YES;
    [HUD setHidden:NO];
    
    NSArray *loyaltyKeys = @[@"startIndex",@"requestHeader"];
    
    NSArray *loyaltyObjects = @[[NSString stringWithFormat:@"%d",purchaseCount1_],[RequestHeader getRequestHeader]];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
    
    NSError * err_;
    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];

    WebServiceController * services = [[WebServiceController alloc] init];
    services.purchaseOrderSvcDelegate =  self;
    [services getPurchaseOrders:normalStockString];

}


// added by Roja on 17/10/2019…. // Old code only pasted here...
- (void)getPurchaseOrdersSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        [self getPreviousOrdersHandler:successDictionary];
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}


// added by Roja on 17/10/2019…. // Old code only pasted here...
- (void)getPurchaseOrdersErrorResponse:(NSString *)errorResponse{
    
    @try {
        
        //nextButton.backgroundColor = [UIColor lightGrayColor];
        firstButton.enabled = NO;
        lastButton.enabled = NO;
        nextButton.enabled = NO;
        recStart.text  = @"0";
        recEnd.text  = @"0";
        totalRec.text  = @"0";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:errorResponse delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]; //@"No Ordered Items Found"
        [alert show];
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}


//getPreviousOrdersHandler: changed by roja on 17/10/2019...
- (void) getPreviousOrdersHandler: (NSDictionary *) successResponse {
    
    [HUD setHidden:YES];

    if(successResponse != nil){
        
        // initialize the arrays ..
        itemIdArray = [[NSMutableArray alloc] init];
        orderStatusArray = [[NSMutableArray alloc] init];
        orderAmountArray = [[NSMutableArray alloc] init];
        OrderedOnArray = [[NSMutableArray alloc] init];
        NSArray *listDetails = successResponse[@"ordersList"];
        //        NSArray *temp = [result componentsSeparatedByString:@"!"];
        
        recStart.text = [NSString stringWithFormat:@"%d",(purchaseChangeNum_ * 10) + 1];
        recEnd.text = [NSString stringWithFormat:@"%d",(recStart.text).intValue + 9];
        totalRec.text = [NSString stringWithFormat:@"%@",successResponse[@"totalOrders"]];
        
        if ([successResponse[@"totalOrders"] intValue] <= 10) {
            recEnd.text = [NSString stringWithFormat:@"%d",(totalRec.text).intValue];
            nextButton.enabled =  NO;
            previousButton.enabled = NO;
            firstButton.enabled = NO;
            lastButton.enabled = NO;
            //nextButton.backgroundColor = [UIColor lightGrayColor];
        }
        else{
            
            if (purchaseChangeNum_ == 0) {
                previousButton.enabled = NO;
                firstButton.enabled = NO;
                nextButton.enabled = YES;
                lastButton.enabled = YES;
            }
            else if (([successResponse[@"totalOrders"] intValue] - (10 * (purchaseChangeNum_+1))) <= 0) {
                
                nextButton.enabled = NO;
                lastButton.enabled = NO;
                recEnd.text = totalRec.text;
            }
        }
        
        
        //[temp removeObjectAtIndex:0];
        
        for (int i = 0; i < listDetails.count; i++) {
            
            NSDictionary *temp2 = listDetails[i];
            
            [itemIdArray addObject:[NSString stringWithFormat:@"%@",temp2[@"PO_Ref"]]];
            [orderStatusArray addObject:[NSString stringWithFormat:@"%@",temp2[@"storeLocation"]]];
            [orderAmountArray addObject:[NSString stringWithFormat:@"%@",temp2[@"total_po_value"]]];
            [OrderedOnArray addObject:[NSString stringWithFormat:@"%@",temp2[@"order_date"]]];
        }
        
        if (itemIdArray.count < 5) {
            //nextButton.backgroundColor = [UIColor lightGrayColor];
            nextButton.enabled =  NO;
        }
        
        purchaseCount3_ = (int)itemIdArray.count;
        
        if (listDetails.count == 0) {
            nextButton.enabled = NO;
            lastButton.enabled = NO;
            previousButton.enabled = NO;
            firstButton.enabled = NO;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Previous Orders" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        
        [orderstockTable reloadData];
    }
    else{
        
        purchaseCount2_ = NO;
        purchaseChangeNum_--;
        
        //nextButton.backgroundColor = [UIColor lightGrayColor];
        nextButton.enabled =  NO;
        
        //previousButton.backgroundColor = [UIColor grayColor];
        previousButton.enabled =  NO;
        
        firstButton.enabled = NO;
        lastButton.enabled = NO;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Previous Orders" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
}
/** Table started.... */

#pragma mark Table view methods

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    if (tableView == paymentTable) {
//        
//        return [listOfItems count];
//    }
//    else if(tableView == serchOrderItemTable){
//        
//        return [serchOrderItemArray count];
//    }
//    else if(tableView == orderItemsTable){
//        
//        return [ItemArray count];
//    }
//    else if(tableView == orderChannelTable){
//        
//        return [shipmodeList count];
//    }
//    else if(tableView == orderDeliveryTable){
//        
//        return [shipmodeList count];
//    }
//    else if(tableView == paymentTypeTable){
//        
//        return [listOfItems count];
//    }
//    else if (searching)
//        return [copyListOfItems count];                           //copyItems
//    else if(tableView == orderstockTable){
//        return [itemIdArray count];
//    }
//    else{
//        return [shipmodeList count];
//    }
    if (tableView == shipModeTable) {
        return shipmodeList.count;
    }
    else if (tableView == locationWiseItemTable){
        return locationWiseItemArr.count;
    }
    else if (tableView == shipmentLocationTable) {
        return selectedLocationIdArr.count;
    }
    else if(tableView == serchOrderItemTable){
        
        return serchOrderItemArray.count;
    }
    else if(tableView == orderItemsTable){
        
        return ItemArray.count;
    }
    else if (tableView == locationTable) {
        
        return locationArr.count;
    }
    else if (searching){
        return copyListOfItems.count;
    }
    else if(tableView == orderstockTable){
        return itemIdArray.count;
    }
    else if (tableView == supplierTable) {
        return supplierList.count;
    }
    else{
        return 0;
    }
}


//Customize HeightForHeaderInSection ...
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(tableView == shipModeTable){
        
        return 35.0;
    }
    else if (tableView == serchOrderItemTable) {
        return 35.0;
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
    
    tableView.separatorColor = [UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0];
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.frame = CGRectZero;
    }
    if ((cell.contentView).subviews){
        for (UIView *subview in (cell.contentView).subviews) {
            [subview removeFromSuperview];
        }
    }
    if (tableView == shipModeTable){
        
        cell.textLabel.text = shipmodeList[indexPath.row];
    }
    else if (tableView == locationTable) {
        
        if ((cell.contentView).subviews){
            for (UIView *subview in (cell.contentView).subviews) {
                [subview removeFromSuperview];
            }
        }
        
        if(cell == nil) {
            cell =  [[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryNone;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                cell.textLabel.font = [UIFont boldSystemFontOfSize:25];
            }
        }
        
        cell.textLabel.text = [locationArr[indexPath.row] valueForKey:@"locationId"];
        //[hlcell setBackgroundColor:[UIColor blackColor]];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont systemFontOfSize:18.0];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        return cell;
        
    }
    else if(tableView == serchOrderItemTable){
        
       // NSDictionary *json = [serchOrderItemArray objectAtIndex:indexPath.row];
        cell.textLabel.text = serchOrderItemArray[indexPath.row];
    }
    else if (tableView == locationWiseItemTable) {
        tableView.separatorColor = [UIColor clearColor];
        NSDictionary *itemDic = locationWiseItemArr[indexPath.row];
        
        UILabel *billID = [[UILabel alloc] init] ;
        billID.layer.borderWidth = 1.5;
        billID.font = [UIFont systemFontOfSize:13.0];
        billID.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:13];
        billID.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
        billID.backgroundColor = [UIColor clearColor];
        billID.textColor = [UIColor whiteColor];
        
        
        UILabel *skuID = [[UILabel alloc] init] ;
        skuID.layer.borderWidth = 1.5;
        skuID.font = [UIFont systemFontOfSize:13.0];
        skuID.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:13];
        skuID.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
        skuID.backgroundColor = [UIColor clearColor];
        skuID.textColor = [UIColor whiteColor];
        
        UILabel *itemName = [[UILabel alloc] init] ;
        itemName.layer.borderWidth = 1.5;
        itemName.font = [UIFont systemFontOfSize:13.0];
        itemName.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:13];
        itemName.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
        itemName.backgroundColor = [UIColor clearColor];
        itemName.textColor = [UIColor whiteColor];
        
//        UILabel *qty = [[UILabel alloc] init] ;
//        qty.layer.borderWidth = 1.5;
//        qty.font = [UIFont systemFontOfSize:13.0];
//        qty.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:13];
//        qty.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
//        qty.backgroundColor = [UIColor clearColor];
//        qty.textColor = [UIColor whiteColor];
        
        UIButton *qty = [UIButton buttonWithType:UIButtonTypeCustom];
        [qty addTarget:self action:@selector(locationQtyPressed:) forControlEvents:UIControlEventTouchDown];
        qty.tag = indexPath.row;
        qty.backgroundColor =  [UIColor clearColor];
        qty.frame = CGRectMake(436, 0, 120, 40);
        
        qty.layer.cornerRadius = 0;
        [qty setTitle:[itemDic valueForKey:QUANTITY] forState:UIControlStateNormal];
        [qty setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        qty.titleLabel.font = [UIFont systemFontOfSize:20];
        CALayer * layer = qty.layer;
        [layer setMasksToBounds:YES];
        layer.cornerRadius = 0.0;
        layer.borderWidth = 1.5;
        layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;

        
        UILabel *totalPrice = [[UILabel alloc] init] ;
        totalPrice.layer.borderWidth = 1.5;
        totalPrice.font = [UIFont systemFontOfSize:13.0];
        totalPrice.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:13];
        totalPrice.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
        totalPrice.backgroundColor = [UIColor clearColor];
        totalPrice.textColor = [UIColor whiteColor];
        
        billID.frame = CGRectMake(5.0, 5.0, 120.0, 50.0);
        skuID.frame = CGRectMake(130.0, 5.0, 120.0, 50.0);
        itemName.frame = CGRectMake(255.0, 5.0, 250.0, 50.0);
        qty.frame = CGRectMake(510.0, 5.0, 100.0, 50.0);
        totalPrice.frame = CGRectMake(615, 5.0, 170.0, 50.0);
        
        @try {
            billID.text = [itemDic valueForKey:SKU_ID];
            skuID.text = [itemDic valueForKey:PLU_CODE];
            itemName.text = [itemDic valueForKey:ITEM_DESCRIPTION];
            qty.titleLabel.text = [NSString stringWithFormat:@"%d",[[itemDic valueForKey:QUANTITY] intValue]];
            totalPrice.text = [NSString stringWithFormat:@"%.2f",[[itemDic valueForKey:ITEM_TOTAL_PRICE] floatValue]];
            
            billID.textAlignment = NSTextAlignmentCenter;
            skuID.textAlignment = NSTextAlignmentCenter;
            itemName.textAlignment = NSTextAlignmentCenter;
            qty.titleLabel.textAlignment = NSTextAlignmentCenter;
            totalPrice.textAlignment = NSTextAlignmentCenter;
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception.name);
        }
        @finally {
            
        }
        cell.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:billID];
        [cell.contentView addSubview:skuID];
        [cell.contentView addSubview:itemName];
        [cell.contentView addSubview:qty];
        [cell.contentView addSubview:totalPrice];

    }
    else if (tableView == shipmentLocationTable){
        if (selectedLocationIdArr.count > 0) {
            tableView.separatorColor = [UIColor clearColor];
            
            NSDictionary *locationDic = selectedLocationIdArr[indexPath.row];
            
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 40)];
            label1.font = [UIFont systemFontOfSize:20.0];
            label1.layer.borderWidth = 1.5;
            label1.backgroundColor = [UIColor clearColor];
            label1.textAlignment = NSTextAlignmentCenter;
            label1.numberOfLines = 2;
            label1.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
            label1.lineBreakMode = NSLineBreakByWordWrapping;
            label1.text = [locationDic valueForKey:@"locationId"];
            label1.textColor = [UIColor whiteColor];

            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(215, 0, 200, 40)];
            label2.font = [UIFont systemFontOfSize:20.0];
            label2.layer.borderWidth = 1.5;
            label2.backgroundColor = [UIColor clearColor];
            label2.textAlignment = NSTextAlignmentCenter;
            label2.numberOfLines = 2;
            label2.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
            label2.lineBreakMode = NSLineBreakByWordWrapping;
            label2.text = [locationDic valueForKey:@"address"];
            label2.textColor = [UIColor whiteColor];

            UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(420, 0, 200, 40)];
            label3.font = [UIFont systemFontOfSize:20.0];
            label3.layer.borderWidth = 1.5;
            label3.backgroundColor = [UIColor clearColor];
            label3.textAlignment = NSTextAlignmentCenter;
            label3.numberOfLines = 2;
            label3.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
            label3.lineBreakMode = NSLineBreakByWordWrapping;
            label3.text = [locationDic valueForKey:@"area"];
            label3.textColor = [UIColor whiteColor];

            UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(625, 0, 150, 40)];
            label4.font = [UIFont systemFontOfSize:20.0];
            label4.layer.borderWidth = 1.5;
            label4.backgroundColor = [UIColor clearColor];
            label4.textAlignment = NSTextAlignmentCenter;
            label4.numberOfLines = 2;
            label4.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
            label4.lineBreakMode = NSLineBreakByWordWrapping;
            label4.text = [locationDic valueForKey:@"city"];
            label4.textColor = [UIColor whiteColor];

            UIButton *shipmentViewBtn = [[UIButton alloc] init] ;
            [shipmentViewBtn setTitle:@"Shipments" forState:UIControlStateNormal];
            shipmentViewBtn.backgroundColor = [UIColor grayColor];
            shipmentViewBtn.layer.masksToBounds = YES;
            shipmentViewBtn.layer.cornerRadius = 5.0f;
            [shipmentViewBtn addTarget:self action:@selector(showShipmentView:) forControlEvents:UIControlEventTouchDown];
            shipmentViewBtn.tag = indexPath.row;
            
            [cell.contentView addSubview:label1];
            [cell.contentView addSubview:label2];
            [cell.contentView addSubview:label3];
            [cell.contentView addSubview:label4];
            shipmentViewBtn.frame = CGRectMake(780, 0,150.0, 40.0f);
            shipmentViewBtn.layer.cornerRadius = 25.0f;
            shipmentViewBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
            
            UIButton *shipmentDelButton = [[UIButton alloc] init] ;
            [shipmentDelButton addTarget:self action:@selector(delShipmentLocation:) forControlEvents:UIControlEventTouchUpInside];
            UIImage *image = [UIImage imageNamed:@"delete.png"];
            shipmentDelButton.tag = indexPath.row;
            shipmentDelButton.frame = CGRectMake(940, 2, 45, 45);
            [shipmentDelButton setBackgroundImage:image    forState:UIControlStateNormal];

            [cell.contentView addSubview:shipmentViewBtn];
            [cell.contentView addSubview:shipmentDelButton];
            cell.backgroundColor = [UIColor blackColor];

        }
    }
    else if(tableView == orderItemsTable){
        
        if (ItemArray.count >= 1) {
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                
                // tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                tableView.separatorColor = [UIColor clearColor];
                
                NSDictionary *itemDic = ItemArray[indexPath.row];
                
                UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(3, 0, 151, 40)];
                label1.font = [UIFont systemFontOfSize:20.0];
                label1.layer.borderWidth = 1.5;
                label1.backgroundColor = [UIColor clearColor];
                label1.textAlignment = NSTextAlignmentCenter;
                label1.numberOfLines = 2;
                label1.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label1.lineBreakMode = NSLineBreakByWordWrapping;
                label1.text = [itemDic valueForKey:SKU_ID];
                label1.textColor = [UIColor whiteColor];
                
                UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(154, 0, 151, 40)];
                label5.font = [UIFont systemFontOfSize:20];
                label5.layer.borderWidth = 1.5;
                label5.backgroundColor = [UIColor clearColor];
                label5.textAlignment = NSTextAlignmentCenter;
                label5.numberOfLines = 2;
                label5.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label5.lineBreakMode = NSLineBreakByWordWrapping;
                label5.text = [itemDic valueForKey:ITEM_DESCRIPTION];
                label5.textColor = [UIColor whiteColor];
                
                UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(305, 0, 130, 40)];
                label2.font = [UIFont systemFontOfSize:20.0];
                label2.backgroundColor =  [UIColor clearColor];
                label2.layer.borderWidth = 1.5;
                label2.textAlignment = NSTextAlignmentCenter;
                label2.numberOfLines = 2;
                label2.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label2.text = [itemDic valueForKey:ITEM_UNIT_PRICE];
                label2.textColor = [UIColor whiteColor];
                
                
                qtyChange = [UIButton buttonWithType:UIButtonTypeCustom];
                [qtyChange addTarget:self action:@selector(qtyChangePressed:) forControlEvents:UIControlEventTouchDown];
                qtyChange.tag = indexPath.row;
                qtyChange.backgroundColor =  [UIColor clearColor];
                qtyChange.frame = CGRectMake(436, 0, 120, 40);
                
                qtyChange.layer.cornerRadius = 0;
                [qtyChange setTitle:[itemDic valueForKey:QUANTITY] forState:UIControlStateNormal];
                [qtyChange setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                qtyChange.titleLabel.font = [UIFont systemFontOfSize:20];
                CALayer * layer = qtyChange.layer;
                [layer setMasksToBounds:YES];
                layer.cornerRadius = 0.0;
                layer.borderWidth = 1.5;
                layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                
                
                UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(557, 0, 150, 40)];
                label4.font = [UIFont systemFontOfSize:20];
                label4.layer.borderWidth = 1.5;
                label4.backgroundColor = [UIColor clearColor];
                label4.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label4.textAlignment = NSTextAlignmentCenter;
                label4.textColor = [UIColor whiteColor];
                NSString *str = [itemDic valueForKey:ITEM_TOTAL_PRICE];
                label4.text = str;
                
                // close button to close the view ..
                delButton = [[UIButton alloc] init] ;
                [delButton addTarget:self action:@selector(delButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                UIImage *image = [UIImage imageNamed:@"delete.png"];
                delButton.tag = indexPath.row;
                delButton.frame = CGRectMake(710, 2, 45, 45);
                [delButton setBackgroundImage:image    forState:UIControlStateNormal];
                
                
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
                
                UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 68, 34)];
                label1.font = [UIFont systemFontOfSize:13.0];
                label1.backgroundColor = [UIColor whiteColor];
                label1.textAlignment = NSTextAlignmentCenter;
                label1.numberOfLines = 2;
                label1.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label1.lineBreakMode = NSLineBreakByWordWrapping;
                label1.text = ItemArray[(indexPath.row)];
                
                UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(66, 0, 68, 34)];
                label2.font = [UIFont systemFontOfSize:13.0];
                label2.backgroundColor =  [UIColor whiteColor];
                label2.layer.borderWidth = 1.5;
                label2.textAlignment = NSTextAlignmentCenter;
                label2.numberOfLines = 2;
                label2.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label2.text = priceArray[(indexPath.row)];
                
                
                qtyChange = [UIButton buttonWithType:UIButtonTypeCustom];
                [qtyChange addTarget:self action:@selector(qtyChangePressed:) forControlEvents:UIControlEventTouchDown];
                qtyChange.tag = indexPath.row;
                qtyChange.backgroundColor =  [UIColor whiteColor];
                qtyChange.frame = CGRectMake(132, 0, 72, 34);
                qtyChange.layer.cornerRadius = 0;
                [qtyChange setTitle:QtyArray[(indexPath.row)] forState:UIControlStateNormal];
                [qtyChange setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                qtyChange.titleLabel.font = [UIFont systemFontOfSize:14.0];
                CALayer * layer = qtyChange.layer;
                [layer setMasksToBounds:YES];
                layer.cornerRadius = 0.0;
                layer.borderWidth = 1.5;
                layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                
                
                UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(202, 0, 70, 34)];
                label4.font = [UIFont systemFontOfSize:13.0];
                label4.layer.borderWidth = 1.5;
                label4.backgroundColor = [UIColor whiteColor];
                label4.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label4.textAlignment = NSTextAlignmentCenter;
                NSString *str = totalArray[(indexPath.row)];
                label4.text = [NSString stringWithFormat:@"%@%@",str,@".0"];
                
                // close button to close the view ..
                delButton = [[UIButton alloc] init] ;
                [delButton addTarget:self action:@selector(delButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                UIImage *image = [UIImage imageNamed:@"delete.png"];
                delButton.tag = indexPath.row;
                delButton.frame = CGRectMake(274, 7, 22, 22);
                [delButton setBackgroundImage:image    forState:UIControlStateNormal];
                
                
                
                [cell.contentView addSubview:label1];
                [cell.contentView addSubview:label2];
                [cell.contentView addSubview:qtyChange];
                [cell.contentView addSubview:label4];
                [cell.contentView addSubview:delButton];
            }
            
        }
        cell.backgroundColor = [UIColor clearColor];
        
        cell.tag = indexPath.row;
    }
    else if (tableView == supplierTable) {
        
        static NSString *hlCellID = @"hlCellID";
        
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
        
        static NSString *MyIdentifier = @"MyIdentifier";
        MyIdentifier = @"TableView";
        
            if ((hlcell.contentView).subviews){
                for (UIView *subview in (hlcell.contentView).subviews) {
                    [subview removeFromSuperview];
                }
            }

        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:20];
            }
        }
        // NSDictionary *JSON = [rawMaterials objectAtIndex:indexPath.row];
        hlcell.textLabel.text = supplierList[indexPath.row];
        hlcell.textLabel.textColor = [UIColor blackColor];
        
        return hlcell;
    }
    else if (tableView == orderstockTable){
        
        tableView.separatorColor = [UIColor clearColor];
        if (purchaseCountValue_ == YES) {
            
            purchaseCount2_ = purchaseCount2_ + purchaseCount1_;
            purchaseCount1_ = 0;
        }
        else{
            
            purchaseCount2_ = purchaseCount2_ - purchaseCount3_;
            purchaseCount3_ = 0;
        }
        
        if(searching)
        {
            int x = [copyListOfItems[indexPath.row] intValue];
            
            //NSString *rownum = [NSString stringWithFormat:@"%d. ", indexPath.row + count2_];
            NSString *itemNameString = [NSString stringWithFormat:@"%@", itemIdArray[x]];
            
        }
        else{
            
            // NSString *rownum = [NSString stringWithFormat:@"%d. ", indexPath.row + count2_];
            NSString *itemNameString = [NSString stringWithFormat:@"%@", itemIdArray[indexPath.row]];
            
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 350.0, 55)];
            label1.font = [UIFont boldSystemFontOfSize:25.0];
            label1.backgroundColor = [UIColor clearColor];
            label1.textAlignment = NSTextAlignmentLeft;
            label1.numberOfLines = 2;
            label1.lineBreakMode = NSLineBreakByWordWrapping;
            label1.text = itemNameString;
            label1.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
            
            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, 350.0, 55)];
            label2.font = [UIFont boldSystemFontOfSize:20.0];
            label2.backgroundColor = [UIColor clearColor];
            label2.textAlignment = NSTextAlignmentLeft;
            label2.numberOfLines = 2;
            label2.lineBreakMode = NSLineBreakByWordWrapping;
            label2.text = orderStatusArray[(indexPath.row)];
            label2.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];;
            
            UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(700.0, 10, 400, 55)];
            label3.font = [UIFont boldSystemFontOfSize:20.0];
            label3.backgroundColor = [UIColor clearColor];
            label3.textAlignment = NSTextAlignmentLeft;
            label3.numberOfLines = 2;
            label3.lineBreakMode = NSLineBreakByWordWrapping;
            label3.text = OrderedOnArray[(indexPath.row)];
            label3.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
            
            UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(700.0, 90, 350.0, 55)];
            label4.font = [UIFont boldSystemFontOfSize:20.0];
            label4.backgroundColor = [UIColor clearColor];
            label4.textAlignment = NSTextAlignmentLeft;
            label4.numberOfLines = 2;
            label4.lineBreakMode = NSLineBreakByWordWrapping;
            label4.text = orderAmountArray[(indexPath.row)];
            label4.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
            
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
            
            cell.backgroundColor = [UIColor blackColor];
            
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
    
    if (tableView == shipModeTable) {
        shipoMode.text = shipmodeList[indexPath.row];
        shipModeTable.hidden = YES;
        [catPopOver dismissPopoverAnimated:YES];
    }
    else if (tableView == locationTable) {
        
        shipment_location.text = @"";
        [shipment_location resignFirstResponder];
        locationTable.hidden = YES;
        shipment_location.text = [locationArr[indexPath.row] valueForKey:@"locationId"];
        [addLocationButton setEnabled:YES];
        [orderButton setEnabled:YES];
        [cancelButton setEnabled:YES];
        addLocationButton.tag = 1;
        selectedLocationId = indexPath.row;
    }
    else if(tableView == serchOrderItemTable){
        
        searchItem.text = @"";
        serchOrderItemTable.hidden = YES;
        NSDictionary *json = skuArrayList[indexPath.row];
        // Create the service
        //        SDZSkuService* service = [SDZSkuService service];
        //        service.logging = YES;
        //
        //        // Returns NSString*.
        //        [service getSkuIDForGivenProductName:self action:@selector(getSkuIDForGivenProductNameHandler:) productName: [serchOrderItemArray objectAtIndex:indexPath.row]];
        BOOL status = TRUE;
        rawMateialsSkuid = [[json valueForKey:@"skuID"] copy];
        //    SkuServiceSoapBinding *skuService = [[SkuServiceSvc SkuServiceSoapBinding] retain];
        //
        //    SkuServiceSvc_getSkuDetails *getSkuid = [[SkuServiceSvc_getSkuDetails alloc] init];
        //
        
        NSArray *keys = @[@"skuId",@"requestHeader",@"storeLocation"];
        NSArray *objects = @[rawMateialsSkuid,[RequestHeader getRequestHeader],presentLocation];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        @try {
            
            WebServiceController *webServiceController = [WebServiceController new];
            webServiceController.getSkuDetailsDelegate = self;
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
            //        receiptProcurementQuantity = 0;
            //        receiptProcurementMaterialCost = 0.0f;
            //
            //        for (int i = 0; i < [rawMaterialDetails count]; i++) {
            //            NSArray *material = [rawMaterialDetails objectAtIndex:i];
            //            receiptProcurementQuantity = receiptProcurementQuantity + [[material objectAtIndex:7] intValue];
            //            receiptProcurementMaterialCost = receiptProcurementMaterialCost + ([[material objectAtIndex:2] floatValue] * [[material objectAtIndex:7] intValue]);
            //        }
            //
            //        totalQuantity.text = [NSString stringWithFormat:@"%d",receiptProcurementQuantity];
            //        totalCost.text = [NSString stringWithFormat:@"%.2f",receiptProcurementMaterialCost];
            
        }
        @catch (NSException *exception) {
            
            
        }
        
        [HUD hide:YES afterDelay:1.0];
    }
    else if (tableView == supplierTable) {
        [supplierTable setHidden:YES];
        customerName.text = supplierList[indexPath.row];
        customerCode.text = supplierCode[indexPath.row];
        
        
    }

    else if (tableView == orderstockTable){
        self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
        ViewPurchaseOrder *vpo = [[ViewPurchaseOrder alloc] initWithorderID:[NSString stringWithFormat:@"%@",itemIdArray[indexPath.row]]];
        [self.navigationController pushViewController:vpo animated:YES];
    }
    scrollView.scrollEnabled = YES;
    orderButton.enabled = YES;
    cancelButton.enabled = YES;
    customerCode.enabled = YES;
    customerName.enabled = YES;
    searchItem.enabled = YES;
//    searchBtton.enabled = YES;
    address.enabled = YES;
    phNo.enabled = YES;
    email.enabled = YES;
    dueDate.enabled = YES;
    dueDateButton.enabled = YES;
    time.enabled = YES;
    // timeButton.enabled = YES;
    shipoMode.enabled = YES;
    shipoModeButton.enabled = YES;
    orderItemsTable.userInteractionEnabled = TRUE;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //1. Setup the CATransform3D structure
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
    
    //2. Define the initial state (Before the animation)
    cell.layer.shadowColor = [UIColor blackColor].CGColor;
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

-(void)showShipmentView:(UIButton *)shipmentButton {
    
    if (poShipmentLocationArr.count == 0) {
        locationWiseItemArr = [[NSMutableArray alloc] init];
        for (NSDictionary *itemDic in ItemArray) {
            NSMutableDictionary *locWiseItemDic = [[NSMutableDictionary alloc] init];
            [locWiseItemDic setValue:[itemDic valueForKey:SKU_ID] forKey:SKU_ID];
            [locWiseItemDic setValue:[itemDic valueForKey:ITEM_DESCRIPTION] forKey:ITEM_DESCRIPTION];
            [locWiseItemDic setValue:[itemDic valueForKey:ITEM_UNIT_PRICE] forKey:ITEM_UNIT_PRICE];
            [locWiseItemDic setValue:[itemDic valueForKey:QUANTITY] forKey:QUANTITY];
            [locWiseItemDic setValue:[itemDic valueForKey:ITEM_TOTAL_PRICE] forKey:ITEM_TOTAL_PRICE];
            [locWiseItemDic setValue:[itemDic valueForKey:PLU_CODE] forKey:PLU_CODE];
            [locWiseItemDic setValue:[itemDic valueForKey:QUANTITY] forKey:QUANTITY_IN_HAND];
            
            [locationWiseItemArr addObject:locWiseItemDic];
        }
    }
    else {
        NSDictionary *shipmentLocation = selectedLocationIdArr[shipmentButton.tag];
        locationWiseItemArr = [[NSMutableArray alloc] init];
        BOOL sameLocationStatus = FALSE;
        int totalQuantity = 0;
        for (NSDictionary *itemDic in poShipmentLocationArr) {
            NSMutableDictionary *locItemDic = [[NSMutableDictionary alloc] init];
            if ([[itemDic valueForKey:@"storeLocation"] isEqualToString:[shipmentLocation valueForKey:@"locationId"]]) {
                sameLocationStatus = TRUE;
                [locItemDic setValue:[itemDic valueForKey:@"skuId"] forKey:SKU_ID];
                [locItemDic setValue:[itemDic valueForKey:@"skuName"] forKey:ITEM_DESCRIPTION];
                [locItemDic setValue:[NSString stringWithFormat:@"%.2f",[[itemDic valueForKey:@"skuPrice"] floatValue]/[[itemDic valueForKey:QUANTITY] intValue]] forKey:ITEM_UNIT_PRICE];
                [locItemDic setValue:[itemDic valueForKey:QUANTITY] forKey:QUANTITY];
                [locItemDic setValue:[itemDic valueForKey:@"skuPrice"] forKey:ITEM_TOTAL_PRICE];
                [locItemDic setValue:[itemDic valueForKey:PLU_CODE] forKey:PLU_CODE];
                if (selectedLocationIdArr.count == 1) {
                    for (NSDictionary *mainItemDic in ItemArray) {
                        if ([[mainItemDic valueForKey:SKU_ID] isEqualToString:[itemDic valueForKey:@"skuId"]] && [[mainItemDic valueForKey:PLU_CODE] isEqualToString:[itemDic valueForKey:PLU_CODE]]) {
                            [locItemDic setValue:[mainItemDic valueForKey:QUANTITY] forKey:QUANTITY_IN_HAND];
                        }
                    }

                }
                else {
                    for (NSDictionary *mainItemDic in ItemArray) {
                        if ([[mainItemDic valueForKey:SKU_ID] isEqualToString:[itemDic valueForKey:@"skuId"]] && [[mainItemDic valueForKey:PLU_CODE] isEqualToString:[itemDic valueForKey:PLU_CODE]]) {
                            totalQuantity = [[mainItemDic valueForKey:QUANTITY] intValue] - [[itemDic valueForKey:QUANTITY] intValue];
                        }
                    }
                    [locItemDic setValue:[NSString stringWithFormat:@"%d",totalQuantity] forKey:QUANTITY_IN_HAND];

                }
                [locationWiseItemArr addObject:locItemDic];
            }
        }
        if (!sameLocationStatus) {
            int totalQuantity = 0;
            for (NSDictionary *itemDic in poShipmentLocationArr) {
                NSMutableDictionary *locItemDic = [[NSMutableDictionary alloc] init];
                [locItemDic setValue:[itemDic valueForKey:@"skuId"] forKey:SKU_ID];
                [locItemDic setValue:[itemDic valueForKey:@"skuName"] forKey:ITEM_DESCRIPTION];
                [locItemDic setValue:[NSString stringWithFormat:@"%.2f",[[itemDic valueForKey:@"skuPrice"] floatValue]/[[itemDic valueForKey:QUANTITY] intValue]] forKey:ITEM_UNIT_PRICE];
                [locItemDic setValue:[itemDic valueForKey:@"skuPrice"] forKey:ITEM_TOTAL_PRICE];
                [locItemDic setValue:[itemDic valueForKey:PLU_CODE] forKey:PLU_CODE];
                for (NSDictionary *mainItemDic in ItemArray) {
                    if ([[mainItemDic valueForKey:SKU_ID] isEqualToString:[itemDic valueForKey:@"skuId"]] && [[mainItemDic valueForKey:PLU_CODE] isEqualToString:[itemDic valueForKey:PLU_CODE]]) {
                        totalQuantity = [[mainItemDic valueForKey:QUANTITY] intValue] - [[itemDic valueForKey:QUANTITY] intValue];
                    }
                }
                [locItemDic setValue:[NSString stringWithFormat:@"%d",totalQuantity] forKey:QUANTITY];
                [locItemDic setValue:[NSString stringWithFormat:@"%d",totalQuantity] forKey:QUANTITY_IN_HAND];
                [locationWiseItemArr addObject:locItemDic];
            }
        }

    }
    PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
    
    editPriceView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 1000.0, 1000.0)];
    editPriceView.opaque = NO;
    editPriceView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    editPriceView.layer.borderColor = [UIColor whiteColor].CGColor;
    editPriceView.layer.borderWidth = 3.0f;
    [editPriceView setHidden:NO];
    
    UILabel *billIDLbl = [[UILabel alloc] init] ;
    billIDLbl.layer.cornerRadius = 14;
    billIDLbl.textAlignment = NSTextAlignmentCenter;
    billIDLbl.layer.masksToBounds = YES;
    billIDLbl.font = [UIFont boldSystemFontOfSize:20.0];
    billIDLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    billIDLbl.textColor = [UIColor whiteColor];
    billIDLbl.text = @"SKU ID";
    billIDLbl.frame = CGRectMake(5.0, 5.0, 120.0, 50.0);
    
    UILabel *skuIDLbl = [[UILabel alloc] init] ;
    skuIDLbl.layer.cornerRadius = 14;
    skuIDLbl.textAlignment = NSTextAlignmentCenter;
    skuIDLbl.layer.masksToBounds = YES;
    skuIDLbl.font = [UIFont boldSystemFontOfSize:20.0];
    skuIDLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    skuIDLbl.textColor = [UIColor whiteColor];
    skuIDLbl.text = @"PLUCode";
    skuIDLbl.frame = CGRectMake(130.0, 5.0, 120.0, 50.0);
    
    UILabel *itemLbl = [[UILabel alloc] init] ;
    itemLbl.layer.cornerRadius = 14;
    itemLbl.textAlignment = NSTextAlignmentCenter;
    itemLbl.layer.masksToBounds = YES;
    itemLbl.font = [UIFont boldSystemFontOfSize:20.0];
    itemLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    itemLbl.textColor = [UIColor whiteColor];
    itemLbl.text = @"Item Name";
    itemLbl.frame = CGRectMake(255.0, 5.0, 250.0, 50.0);
    
    UILabel *qtyLbl = [[UILabel alloc] init] ;
    qtyLbl.layer.cornerRadius = 14;
    qtyLbl.textAlignment = NSTextAlignmentCenter;
    qtyLbl.layer.masksToBounds = YES;
    qtyLbl.font = [UIFont boldSystemFontOfSize:20.0];
    qtyLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    qtyLbl.textColor = [UIColor whiteColor];
    qtyLbl.text = @"Qty";
    qtyLbl.frame = CGRectMake(510.0, 5.0, 100.0, 50.0);
    
    
    UILabel *priceLbl = [[UILabel alloc] init] ;
    priceLbl.layer.cornerRadius = 14;
    priceLbl.textAlignment = NSTextAlignmentCenter;
    priceLbl.layer.masksToBounds = YES;
    priceLbl.font = [UIFont boldSystemFontOfSize:20.0];
    priceLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    priceLbl.textColor = [UIColor whiteColor];
    priceLbl.text = @"Total Cost";
    priceLbl.frame = CGRectMake(615, 5.0, 170.0, 50.0);
    
    locationWiseItemTable = [[UITableView alloc] init];
    locationWiseItemTable.backgroundColor = [UIColor clearColor];
    locationWiseItemTable.layer.borderColor = [UIColor blackColor].CGColor;
    locationWiseItemTable.layer.cornerRadius = 4.0f;
    locationWiseItemTable.layer.borderWidth = 1.0f;
    locationWiseItemTable.dataSource = self;
    locationWiseItemTable.delegate = self;
    locationWiseItemTable.frame = CGRectMake(0.0, 55.0, editPriceView.frame.size.width, 500.0);
    
    UIButton *locationItemDone = [[UIButton alloc] init] ;
    [locationItemDone setTitle:@"DONE" forState:UIControlStateNormal];
    locationItemDone.backgroundColor = [UIColor grayColor];
    locationItemDone.layer.masksToBounds = YES;
    locationItemDone.layer.cornerRadius = 10.0f;
    [locationItemDone addTarget:self action:@selector(doneWithLocationItems:) forControlEvents:UIControlEventTouchDown];
    locationItemDone.frame = CGRectMake(250.0, 600.0, 300.0, 50.0);
    locationItemDone.tag = shipmentButton.tag;
    
    [editPriceView addSubview:billIDLbl];
    [editPriceView addSubview:skuIDLbl];
    [editPriceView addSubview:itemLbl];
    [editPriceView addSubview:qtyLbl];
    [editPriceView addSubview:priceLbl];
    [editPriceView addSubview:locationWiseItemTable];
    [editPriceView addSubview:locationItemDone];
    
    customerInfoPopUp.view = editPriceView;
    customerInfoPopUp.view.backgroundColor = [UIColor blackColor];
    NSIndexPath *selectedRow = [NSIndexPath indexPathForRow:shipmentButton.tag inSection:0];

    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        customerInfoPopUp.preferredContentSize =  CGSizeMake(editPriceView.frame.size.width, editPriceView.frame.size.height);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        
        [popover presentPopoverFromRect:shipmentButton.frame inView:[shipmentLocationTable cellForRowAtIndexPath:selectedRow] permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        
        
        editPricePopOver= popover;
    }
    
    else {
        
        customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        // popover.contentViewController.view.alpha = 0.0;
        popover.contentViewController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        editPricePopOver = popover;
        
    }

}

-(void)delShipmentLocation:(id)delShipmentLocation {
    
}

#pragma mark - Get SKU Details Service Reposnse Delegates

- (void)getSkuDetailsSuccessResponse:(NSDictionary *)successDictionary
{
    @try {
        BOOL status_ = TRUE;
        if (successDictionary != nil) {
            [self getSkuDetailsHandler:successDictionary];
        }
    }
    @catch (NSException * exception) {
        
    }
}

- (void)getSkuDetailsErrorResponse:(NSString *)failureString {
    [HUD setHidden:YES];
    UIAlertView *alert=  [[UIAlertView alloc] initWithTitle:failureString message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

//SearchItem TextFieldDidChange handler....
//- (void)textFieldDidChange:(UITextField *)textField {
//    
//    if (textField == searchItem) {
//        if ([textField text].length >=3) {
//    
//    [HUD setHidden:NO];
//    
//    SkuServiceSoapBinding *skuService = [[SkuServiceSvc SkuServiceSoapBinding] retain];
//    
//    SkuServiceSvc_searchProducts *getSkuid = [[SkuServiceSvc_searchProducts alloc] init];
//    NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
//    NSArray *str = [time componentsSeparatedByString:@" "];
//    NSString *date = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
//    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
//    
//    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date, nil];
//    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
//    NSArray *keys = [NSArray arrayWithObjects:@"requestHeader",@"startIndex",@"searchCriteria",nil];
//    NSArray *objects = [NSArray arrayWithObjects:dictionary_,@"0",searchString, nil];
//    
//    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
//    
//    NSError * err;
//    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
//    NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    getSkuid.searchCriteria = salesReportJsonString;
//    //
//    if ([tempSkuArrayList count]!=0) {
//        [tempSkuArrayList removeAllObjects];
//    }
//    //
//    @try {
//        
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
//                [self searchProductHandler:JSON];
//            }
//        }
//    }
//    @catch (NSException *exception) {
//        
//        [HUD setHidden:YES];
//        
//        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No data found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        //        [alert show];
//        
//    }
//        }
//    
//    //    SkuServiceSoapBinding *skuService = [[SkuServiceSvc SkuServiceSoapBinding] retain];
//    //
//    //    SkuServiceSvc_getSkuID *getSkuid = [[SkuServiceSvc_getSkuID alloc] init];
//    //    NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
//    //    NSArray *str = [time componentsSeparatedByString:@" "];
//    //    NSString *date = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
//    //    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
//    //
//    //    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date, nil];
//    //    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
//    //    NSArray *keys = [NSArray arrayWithObjects:@"requestHeader",nil];
//    //    NSArray *objects = [NSArray arrayWithObjects:dictionary_, nil];
//    //
//    //    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
//    //
//    //    NSError * err;
//    //    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
//    //    NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    //    getSkuid.requestHeader = salesReportJsonString;
//    //
//    //    if ([skuArrayList count]!=0) {
//    //        [skuArrayList removeAllObjects];
//    //    }
//    //
//    //    @try {
//    //
//    //
//    //        SkuServiceSoapBindingResponse *response = [skuService getSkuIDUsingParameters:(SkuServiceSvc_getSkuID *)getSkuid];
//    //        NSArray *responseBodyParts = response.bodyParts;
//    //        for (id bodyPart in responseBodyParts) {
//    //            if ([bodyPart isKindOfClass:[SkuServiceSvc_getSkuIDResponse class]]) {
//    //                SkuServiceSvc_getSkuIDResponse *body = (SkuServiceSvc_getSkuIDResponse *)bodyPart;
//    //                printf("\nresponse=%s",[body.return_ UTF8String]);
//    //                NSError *e;
//    //                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//    //                                                                     options: NSJSONReadingMutableContainers
//    //                                                                       error: &e];
//    //                NSArray *list = [JSON objectForKey:@"skuIds"];
//    //
//    //                [skuArrayList addObjectsFromArray:list];
//    //            }
//    //        }
//    //    }
//    //    @catch (NSException *exception) {
//    //
//    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No data found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    //        [alert show];
//    //
//    //    }
//    
//    }
//    
//    
//}

- (void)textFieldDidChange:(UITextField *)textField {
    
    if (textField == searchItem) {
        
        if ((textField.text).length >= 3) {
            
            [serchOrderItemArray removeAllObjects];   // First clear the filtered array.
            [skuArrayList removeAllObjects];
            searchStringStock = [textField.text copy];

            [self callSkuIdService:textField.text];
            
            // NSLog(@"%@",textField.text);
            
            
        }
        else if ((textField.text).length == 0) {
            serchOrderItemTable.hidden = YES;
        }
        
    }
    else if (textField == customerName) {
        if ((textField.text).length >= 3) {
            
            [self getSuppliers:textField.text];
            
            if (supplierList.count > 0) {
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    supplierTable.frame = CGRectMake(10, 50, 350, 200);
                }
                else {
                    if (version >= 8.0) {
                        supplierTable.frame = CGRectMake(5, 30, 150, 200);
                    }
                    else{
                        supplierTable.frame = CGRectMake(60, 35, 180,150);
                    }
                }
                
                if (supplierList.count > 5) {
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        supplierTable.frame = CGRectMake(10, 50, 350, 200);
                    }
                    else {
                        if (version >= 8.0) {
                            supplierTable.frame = CGRectMake(5, 30, 150, 200);
                        }
                        else{
                            supplierTable.frame = CGRectMake(60, 35, 180,150);
                        }
                    }
                }
                [scrollView bringSubviewToFront:supplierTable];
                [supplierTable reloadData];
                supplierTable.hidden = NO;
            }
            else {
                supplierTable.hidden = YES;
            }
        }
    }
}
-(void)callSkuIdService:(NSString *)searchString1 {
    
    [HUD setHidden:NO];
    
    //    SkuServiceSoapBinding *skuService = [[SkuServiceSvc SkuServiceSoapBinding] retain];
    //
    //    SkuServiceSvc_searchProducts *getSkuid = [[SkuServiceSvc_searchProducts alloc] init];
    NSArray *keys = @[@"requestHeader",@"startIndex",@"searchCriteria"];
    NSArray *objects = @[[RequestHeader getRequestHeader],@"0",searchString1];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
    NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
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
            for (NSDictionary *product in tempSkuArrayList)
            {
                NSComparisonResult result;
                
                if (!([product[@"productId"] rangeOfString:searchStringStock options:NSCaseInsensitiveSearch].location == NSNotFound))
                {
                    result = [product[@"productId"] compare:searchStringStock options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, searchStringStock.length)];
                    if (result == NSOrderedSame)
                    {
                        [serchOrderItemArray addObject:product[@"productId"]];
                        [skuArrayList addObject:product];
                        
                    }
                }
                if (!([product[@"description"] rangeOfString:searchStringStock options:NSCaseInsensitiveSearch].location == NSNotFound)) {
                    
                    [serchOrderItemArray addObject:product[@"description"]];
                    [skuArrayList addObject:product];
                    
                    
                    
                    
                }
                else {
                    
                    // [filteredSkuArrayList addObject:[product objectForKey:@"skuID"]];
                    
                    
                    result = [product[@"skuID"] compare:searchStringStock options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, searchStringStock.length)];
                    
                    if (result == NSOrderedSame)
                    {
                        [serchOrderItemArray addObject:product[@"skuID"]];
                        [skuArrayList addObject:product];
                        
                    }
                }
                
                
            }
            
            //[newBillField setEnabled:FALSE];
            
            if (serchOrderItemArray.count > 0) {
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    serchOrderItemTable.frame = CGRectMake(10, 570.0, searchItem.frame.size.width,240);
                }
                else {
                    if (version >= 8.0) {
                        serchOrderItemTable.frame = CGRectMake(5, 470, 220,200);
                    }
                    else{
                        serchOrderItemTable.frame = CGRectMake(10, 75, 213,200);
                    }
                }
                
                if (serchOrderItemArray.count > 5) {
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        serchOrderItemTable.frame = CGRectMake(10, 570.0, searchItem.frame.size.width,240);
                    }
                    else {
                        if (version >= 8.0) {
                            serchOrderItemTable.frame = CGRectMake(5, 470, 220,200);
                        }
                        else{
                            serchOrderItemTable.frame = CGRectMake(10, 75, 213,100);
                        }
                    }
                }
                [scrollView bringSubviewToFront:serchOrderItemTable];
                [serchOrderItemTable reloadData];
                serchOrderItemTable.hidden = NO;
            }
            else {
                
                serchOrderItemTable.hidden = YES;
                
                //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No data found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                //                [alert show];
                
            }
            

//            for (NSDictionary *product in tempSkuArrayList)
//            {
//                NSComparisonResult result;
//                
//                if (!([[product objectForKey:@"productId"] rangeOfString:searchStringStock options:NSCaseInsensitiveSearch].location == NSNotFound))
//                {
//                    result = [[product objectForKey:@"productId"] compare:searchStringStock options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchStringStock length])];
//                    if (result == NSOrderedSame)
//                    {
//                        [skuArrayList addObject:[product objectForKey:@"productId"]];
//                        [rawMaterials addObject:product];
//                        
//                    }
//                }
//                if (!([[product objectForKey:@"description"] rangeOfString:searchStringStock options:NSCaseInsensitiveSearch].location == NSNotFound)) {
//                    
//                    [skuArrayList addObject:[product objectForKey:@"description"]];
//                    [rawMaterials addObject:product];
//                    
//                    
//                    
//                    
//                }
//                else {
//                    
//                    // [filteredSkuArrayList addObject:[product objectForKey:@"skuID"]];
//                    
//                    
//                    result = [[product objectForKey:@"skuID"] compare:searchStringStock options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchStringStock length])];
//                    
//                    if (result == NSOrderedSame)
//                    {
//                        [skuArrayList addObject:[product objectForKey:@"skuID"]];
//                        [rawMaterials addObject:product];
//                        
//                    }
//                }
//                
//                
//            }
//            
//            if ([skuArrayList count] > 0) {
//                
//                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//                    skListTable.frame = CGRectMake(searchItem.frame.origin.x, searchItem.frame.origin.y+searchItem.frame.size.height, searchItem.frame.size.width,240);
//                }
//                else {
//                    if (goodsReturnVersion >= 8.0) {
//                        skListTable.frame = CGRectMake(60, 170, 180,200);
//                    }
//                    else{
//                        skListTable.frame = CGRectMake(60.0, 170.0, 180, 130);
//                    }
//                }
//                
//                if ([skuArrayList count] > 5) {
//                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//                        skListTable.frame = CGRectMake(searchItem.frame.origin.x, searchItem.frame.origin.y+searchItem.frame.size.height, searchItem.frame.size.width,450);
//                    }
//                    else {
//                        if (goodsReturnVersion >= 8.0) {
//                            skListTable.frame = CGRectMake(60, 170, 180,200);
//                        }
//                        else{
//                            skListTable.frame = CGRectMake(60.0, 170.0, 180, 130);
//                        }
//                    }
//                }
//                [self.view bringSubviewToFront:skListTable];
//                [skListTable reloadData];
//                skListTable.hidden = NO;
//            }
//            else {
//                skListTable.hidden = YES;
//            }
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

// Handle the response from searchProduct.
- (void) searchProductHandler: (NSString *) value {
    
    [HUD setHidden:YES];

    // Handle errors
    if([value isKindOfClass:[NSError class]]) {
        NSLog(@"%@", value);
        return;
    }
    
    // Handle faults
    //    if([value isKindOfClass:[SoapFault class]]) {
    //        NSLog(@"%@", value);
    //        return;
    //    }
    
    
    // Do something with the NSString* result
    NSString* result = (NSString*)value;
    
    NSLog(@"%@",result);
    
    if (result.length >= 1) {
        
        NSError *e;
        
        NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [result dataUsingEncoding:NSUTF8StringEncoding]
                                                              options: NSJSONReadingMutableContainers
                                                                error: &e];
        
        NSArray *tempItems = JSON1[@"skuIds"];
        
        // serchOrderItemArray initialization...
        serchOrderItemArray = [[NSMutableArray alloc] init];
        
        for (int i=0; i<tempItems.count; i++) {
            
            [serchOrderItemArray addObject:tempItems[i]];
        }
        
        scrollView.scrollEnabled = NO;
        orderButton.enabled = NO;
        cancelButton.enabled = NO;
        //timeButton.enabled = NO;
        paymentModeButton.enabled= NO;
        customerCode.enabled = NO;
        customerName.enabled = NO;
        searchItem.enabled = NO;
//        searchBtton.enabled = NO;
        address.enabled =NO;
        phNo.enabled = NO;
        email.enabled = NO;
        dueDate.enabled = NO;
        dueDateButton.enabled = NO;
        time.enabled = NO;
        //timeButton.enabled = NO;
        shipoMode.enabled = NO;
        shipoModeButton =NO;
        paymentModeButton.enabled = NO;
        orderItemsTable.userInteractionEnabled = FALSE;
        
        [serchOrderItemTable reloadData];

        serchOrderItemTable.hidden = NO;
        [scrollView bringSubviewToFront:serchOrderItemTable];
        
        
    }
    else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"No Order Items found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        searchItem.text = nil;
    }
}
// Handle serchOrderItemTableCancel Pressed....
-(IBAction) serchOrderItemTableCancel:(id) sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    searchItem.text = nil;
    serchOrderItemTable.hidden = YES;
    shipModeTable.hidden = YES;
    paymentTable.hidden= YES;
    
    scrollView.scrollEnabled = YES;
    orderButton.enabled = YES;
    cancelButton.enabled = YES;
    //timeButton.enabled = YES;
    paymentModeButton.enabled= YES;
    customerCode.enabled = YES;
    customerName.enabled = YES;
    searchItem.enabled = YES;
//    searchBtton.enabled = YES;
    address.enabled = YES;
    phNo.enabled = YES;
    email.enabled = YES;
    dueDate.enabled = YES;
    dueDateButton.enabled = YES;
    time.enabled = YES;
    // timeButton.enabled = YES;
    shipoMode.enabled = YES;
    shipoModeButton.enabled = YES;
    orderItemsTable.userInteractionEnabled = TRUE;
    
}
-(void)getPurchaseOrders{
    
    [HUD setHidden:NO];
    
    purchaseOrdersSoapBinding *service = [purchaseOrdersSvc purchaseOrdersSoapBinding];
    purchaseOrdersSvc_getPurchaseOrders *aparams = [[purchaseOrdersSvc_getPurchaseOrders alloc] init];

    NSArray *loyaltyKeys = @[@"startIndex",@"requestHeader",@"storeLocation"];
    
    NSArray *loyaltyObjects = @[[NSString stringWithFormat:@"%d",purchaseChangeNum_],[RequestHeader getRequestHeader],presentLocation];
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
                    firstButton.enabled = NO;
                    lastButton.enabled = NO;
                    nextButton.enabled = NO;
                    recStart.text  = @"0";
                    recEnd.text  = @"0";
                    totalRec.text  = @"0";
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Orderes  Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
                else{
                    
                    [self getPreviousOrdersHandler:body.return_];
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
// DelButton handler...
- (IBAction)delButtonPressed:(id)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    @try {
        
        [ItemArray removeObjectAtIndex:[sender tag]];
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception.name);
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Problem occured while processing" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    //delButton.tag
    
    [orderItemsTable reloadData];
    
    [self displayOrdersData];
}


// Commented by roja on 17/10/2019.. // reason :- getSuppliers: method contains SOAP Service call .. so taken new method with same name(getSuppliers:) method name which contains REST service call....
// At the time of converting SOAP call's to REST
//-(void)getSuppliers:(NSString *)supplierNameStr {
//    // BOOL status = FALSE;
//
//    [HUD setHidden:NO];
//
//    SupplierServiceSoapBinding *skuService = [SupplierServiceSvc SupplierServiceSoapBinding];
//
//    SupplierServiceSvc_getSuppliers *getSkuid = [[SupplierServiceSvc_getSuppliers alloc] init];
//
//    NSArray *keys = @[@"requestHeader",@"pageNo",@"searchCriteria"];
//    NSArray *objects = @[[RequestHeader getRequestHeader],@"-1",supplierNameStr];
//
//    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
//
//    NSError * err;
//    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
//    NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    getSkuid.supplierDetails = salesReportJsonString;
//    //
//    if (supplierList.count!=0) {
//        [supplierList removeAllObjects];
//        [supplierCode removeAllObjects];
//
//    }
//    //
//    @try {
//
//        SupplierServiceSoapBindingResponse *response = [skuService getSuppliersUsingParameters:getSkuid];
//        NSArray *responseBodyParts = response.bodyParts;
//        for (id bodyPart in responseBodyParts) {
//            if ([bodyPart isKindOfClass:[SupplierServiceSvc_getSuppliersResponse class]]) {
//                SupplierServiceSvc_getSuppliersResponse *body = (SupplierServiceSvc_getSuppliersResponse *)bodyPart;
//                printf("\nresponse=%s",(body.return_).UTF8String);
//                NSError *e;
//                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                     options: NSJSONReadingMutableContainers
//                                                                       error: &e];
//                [HUD setHidden:YES];
//
//                NSArray *list = JSON[@"suppliers"];
//                for (int i=0; i<list.count; i++) {
//
//                    NSDictionary *dic = list[i];
//                    [supplierCode addObject:dic[@"supplierCode"]];
//                    [supplierList addObject:dic[@"firmName"]];
//
//
//                }
//            }
//        }
//
//    }
//    @catch (NSException *exception) {
//
//        [HUD setHidden:YES];
//
//        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No data found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        //        [alert show];
//
//    }
//    //[skListTable reloadData];
//}



//getSuppliers: method changed by roja on 17/10/2019.. // reason : removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST
-(void)getSuppliers:(NSString *)supplierNameStr {
    
    [HUD setHidden:NO];

    NSArray *keys = @[@"requestHeader",@"pageNo",@"searchCriteria"];
    NSArray *objects = @[[RequestHeader getRequestHeader],@"-1",supplierNameStr];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
    NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    if (supplierList.count!=0) {
        [supplierList removeAllObjects];
        [supplierCode removeAllObjects];
    }
    
    WebServiceController * services =  [[WebServiceController alloc] init];
    services.supplierServiceSvcDelegate = self;
    [services getSupplierDetailsData:salesReportJsonString];
}

// added by Roja on 17/10/2019…. // OLD code only written below...
- (void)getSuppliersSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        
        NSArray *list = successDictionary[@"suppliers"];
        for (int i=0; i<list.count; i++) {
            
            NSDictionary *dic = list[i];
            [supplierCode addObject:dic[@"supplierCode"]];
            [supplierList addObject:dic[@"firmName"]];
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}

// added by Roja on 17/10/2019…. // OLD code only written below...
- (void)getSuppliersErrorResponse:(NSString *)errorResponse {
    
    @try {
        
        NSLog(@"getSuppliersErrorResponse in CreatePurchaseOrder :%@", errorResponse);
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}


-(void)backAction {
    if (ItemArray.count>0) {
        
        warning = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"You will lose data you entered.\n Do you want to exit?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
        [warning show];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
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
