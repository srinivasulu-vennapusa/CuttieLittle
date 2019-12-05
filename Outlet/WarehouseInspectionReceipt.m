//
//  WarehouseInspectionReceipt.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/29/15.
//
//

#import "WarehouseInspectionReceipt.h"
#import "StoreStockVerificationImplServiceSvc.h"
#import "WarehouseStockVerificationSvc.h"
#import "shipmentInspectionServicesSvc.h"
#import "Global.h"
#import "ViewWarehouseInspection.h"

@interface WarehouseInspectionReceipt ()

@end

@implementation WarehouseInspectionReceipt
@synthesize soundFileObject,soundFileURLRef;

NSDictionary *inspJSON;
UILabel *recStart;
UILabel *recEnd;
UILabel *totalRec;
UILabel *label1_;
UILabel *label2_;
NSString *wareInspection = @"";
int wareInspectionCount1_ = 0;
int wareInspectionCount2_ = 1;
int wareInspectionCount3_ = 0;
BOOL wareInspectionCountValue_ = YES;
int wareInspectionChangeNum_ = 0;


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
    titleLbl.text = @"Shipment Inspection";
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
    
    shipmentView = [[UIScrollView alloc] init];
    shipmentView.backgroundColor = [UIColor blackColor];
    shipmentView.bounces = FALSE;
    shipmentView.hidden = NO;
    
    po_ref = [[UITextField alloc] init];
    po_ref.borderStyle = UITextBorderStyleRoundedRect;
    po_ref.textColor = [UIColor blackColor];
    po_ref.font = [UIFont systemFontOfSize:18.0];
    po_ref.backgroundColor = [UIColor whiteColor];
    po_ref.clearButtonMode = UITextFieldViewModeWhileEditing;
    po_ref.backgroundColor = [UIColor whiteColor];
    po_ref.autocorrectionType = UITextAutocorrectionTypeNo;
    po_ref.layer.borderColor = [UIColor whiteColor].CGColor;
    po_ref.backgroundColor = [UIColor whiteColor];
    po_ref.delegate = self;
    po_ref.placeholder = @"   Po Ref.";
    
    shipment_note_ref = [[UITextField alloc] init];
    shipment_note_ref.borderStyle = UITextBorderStyleRoundedRect;
    shipment_note_ref.textColor = [UIColor blackColor];
    shipment_note_ref.font = [UIFont systemFontOfSize:18.0];
    shipment_note_ref.backgroundColor = [UIColor whiteColor];
    shipment_note_ref.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipment_note_ref.backgroundColor = [UIColor whiteColor];
    shipment_note_ref.autocorrectionType = UITextAutocorrectionTypeNo;
    shipment_note_ref.layer.borderColor = [UIColor whiteColor].CGColor;
    shipment_note_ref.backgroundColor = [UIColor whiteColor];
    shipment_note_ref.delegate = self;
    shipment_note_ref.placeholder = @"   Shipment Note Ref.";

    inspected_by = [[UITextField alloc] init];
    inspected_by.borderStyle = UITextBorderStyleRoundedRect;
    inspected_by.textColor = [UIColor blackColor];
    inspected_by.font = [UIFont systemFontOfSize:18.0];
    inspected_by.backgroundColor = [UIColor whiteColor];
    inspected_by.clearButtonMode = UITextFieldViewModeWhileEditing;
    inspected_by.backgroundColor = [UIColor whiteColor];
    inspected_by.autocorrectionType = UITextAutocorrectionTypeNo;
    inspected_by.layer.borderColor = [UIColor whiteColor].CGColor;
    inspected_by.backgroundColor = [UIColor whiteColor];
    inspected_by.delegate = self;
    inspected_by.placeholder = @"   Inspected By.";

    inspection_summary = [[UITextField alloc] init];
    inspection_summary.borderStyle = UITextBorderStyleRoundedRect;
    inspection_summary.textColor = [UIColor blackColor];
    inspection_summary.font = [UIFont systemFontOfSize:18.0];
    inspection_summary.backgroundColor = [UIColor whiteColor];
    inspection_summary.clearButtonMode = UITextFieldViewModeWhileEditing;
    inspection_summary.backgroundColor = [UIColor whiteColor];
    inspection_summary.autocorrectionType = UITextAutocorrectionTypeNo;
    inspection_summary.layer.borderColor = [UIColor whiteColor].CGColor;
    inspection_summary.backgroundColor = [UIColor whiteColor];
    inspection_summary.delegate = self;
    inspection_summary.placeholder = @"   Inspection Summary.";
    // getting present date & time ..
    NSDate *today = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString* currentdate = [f stringFromDate:today];
    [f release];
    received_on = [[UITextField alloc] init];
    received_on.borderStyle = UITextBorderStyleRoundedRect;
    received_on.textColor = [UIColor blackColor];
    received_on.font = [UIFont systemFontOfSize:18.0];
    received_on.backgroundColor = [UIColor whiteColor];
    received_on.clearButtonMode = UITextFieldViewModeWhileEditing;
    received_on.backgroundColor = [UIColor whiteColor];
    received_on.autocorrectionType = UITextAutocorrectionTypeNo;
    received_on.layer.borderColor = [UIColor whiteColor].CGColor;
    received_on.backgroundColor = [UIColor whiteColor];
    received_on.delegate = self;
    received_on.text = currentdate;
    received_on.userInteractionEnabled = FALSE;
    received_on.placeholder = @"   Received On";

    inspection_status = [[UITextField alloc] init];
    inspection_status.borderStyle = UITextBorderStyleRoundedRect;
    inspection_status.textColor = [UIColor blackColor];
    inspection_status.font = [UIFont systemFontOfSize:18.0];
    inspection_status.backgroundColor = [UIColor whiteColor];
    inspection_status.clearButtonMode = UITextFieldViewModeWhileEditing;
    inspection_status.backgroundColor = [UIColor whiteColor];
    inspection_status.autocorrectionType = UITextAutocorrectionTypeNo;
    inspection_status.layer.borderColor = [UIColor whiteColor].CGColor;
    inspection_status.backgroundColor = [UIColor whiteColor];
    inspection_status.delegate = self;
    inspection_status.placeholder = @"   Inspection Status";

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

    
    skListTable = [[UITableView alloc] init];
    skListTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [skListTable setDataSource:self];
    [skListTable setDelegate:self];
    [skListTable.layer setBorderWidth:1.0f];
    skListTable.layer.cornerRadius = 3;
    skListTable.layer.borderColor = [UIColor grayColor].CGColor;
    
    itemTable = [[UITableView alloc] init];
    [itemTable setDataSource:self];
    [itemTable setDelegate:self];
    itemTable.backgroundColor = [UIColor clearColor];
    [itemTable setSeparatorColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.2f]];
    itemTable.hidden = YES;
    
    itemArray = [[NSMutableArray alloc] init];
    //
    itemSubArray = [[NSMutableArray alloc] init];
    
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
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        shipmentView.frame = CGRectMake(0, 125, self.view.frame.size.width, 830.0);
        shipmentView.contentSize = CGSizeMake(self.view.frame.size.width+100.0, 1500.0);
        
        po_ref.font = [UIFont boldSystemFontOfSize:20];
        po_ref.frame = CGRectMake(10.0, 0.0, 360, 40);
        
        shipment_note_ref.font = [UIFont boldSystemFontOfSize:20];
        shipment_note_ref.frame = CGRectMake(400.0, 0.0, 360, 40);
        
        inspected_by.font = [UIFont boldSystemFontOfSize:20];
        inspected_by.frame = CGRectMake(10.0, 50.0, 360, 40);
        
        inspection_summary.font = [UIFont boldSystemFontOfSize:20];
        inspection_summary.frame = CGRectMake(400.0, 50.0, 360, 40);
        
        received_on.font = [UIFont boldSystemFontOfSize:20];
        received_on.frame = CGRectMake(10.0, 100.0, 360, 40);
        
        inspection_status.font = [UIFont boldSystemFontOfSize:20];
        inspection_status.frame = CGRectMake(400.0, 100.0, 360, 40);
        
        remarks.font = [UIFont boldSystemFontOfSize:20];
        remarks.frame = CGRectMake(10.0, 150.0, 360, 40);
        
        searchItem.font = [UIFont boldSystemFontOfSize:20];
        searchItem.frame = CGRectMake(200.0, 200, 360.0, 50.0);
        
        label1.frame = CGRectMake(10, 260.0, 150, 40);
        label1.font = [UIFont boldSystemFontOfSize:20.0];
        
        label5.frame = CGRectMake(161, 260.0, 150, 40);
        label5.font = [UIFont boldSystemFontOfSize:20.0];
        
        label2.frame = CGRectMake(312, 260.0, 150, 40);
        label2.font = [UIFont boldSystemFontOfSize:20.0];
        
        label3.frame = CGRectMake(463, 260.0, 150, 40);
        label3.font = [UIFont boldSystemFontOfSize:20.0];
        
        label4.frame = CGRectMake(614, 260.0, 150, 40);
        label4.font = [UIFont boldSystemFontOfSize:20.0];
        
        skListTable.frame = CGRectMake(200, 250.0, 360,0);
        
        itemTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        itemTable.frame = CGRectMake(0, 310.0, 850.0, 500);
        
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
        
        po_ref.font = [UIFont systemFontOfSize:15.0f];
        po_ref.frame = CGRectMake(5, 0, 150.0, 30.0);
        
        shipment_note_ref.font = [UIFont systemFontOfSize:15.0f];
        shipment_note_ref.frame = CGRectMake(165.0, 0, 150, 30.0);
        
        inspected_by.font = [UIFont systemFontOfSize:15.0f];
        inspected_by.frame = CGRectMake(5, 35.0, 150.0, 30.0);
        
        inspection_summary.font = [UIFont systemFontOfSize:15.0f];
        inspection_summary.frame = CGRectMake(165.0, 35.0, 150, 30.0);

        received_on.font = [UIFont systemFontOfSize:15.0f];
        received_on.frame = CGRectMake(5, 70.0, 150.0, 30.0);
        
        inspection_status.font = [UIFont systemFontOfSize:15.0f];
        inspection_status.frame = CGRectMake(165.0, 70.0, 150, 30.0);

        remarks.font = [UIFont systemFontOfSize:15.0f];
        remarks.frame = CGRectMake(5, 105, 150.0, 30.0);
        
        searchItem.font = [UIFont boldSystemFontOfSize:20];
        searchItem.frame = CGRectMake(5.0, 140.0, 150.0, 30.0);
        
        label1.frame = CGRectMake(0, 180.0, 60, 25);
        label1.font = [UIFont boldSystemFontOfSize:17];
        
        label5.frame = CGRectMake(61, 180.0, 60, 25);
        label5.font = [UIFont boldSystemFontOfSize:17];
        
        label2.frame = CGRectMake(122, 180.0, 60, 25);
        label2.font = [UIFont boldSystemFontOfSize:17];
        
        label3.frame = CGRectMake(183, 180.0, 60, 25);
        label3.font = [UIFont boldSystemFontOfSize:17];
        
        label4.frame = CGRectMake(244, 180.0, 60, 25);
        label4.font = [UIFont boldSystemFontOfSize:17];

        
        skListTable.frame = CGRectMake(5.0, 170.0, 150.0,0);
        
        itemTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        itemTable.frame = CGRectMake(0, 215, 320.0, 300.0);
        
        orderButton.frame = CGRectMake(15, 370, 130, 30);
        orderButton.layer.cornerRadius = 18.0f;
        orderButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        
        cancelButton.frame = CGRectMake(165, 370, 130, 30);
        cancelButton.layer.cornerRadius = 18.0f;
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
    }

    [shipmentView addSubview:po_ref];
    [shipmentView addSubview:shipment_note_ref];
    [shipmentView addSubview:inspected_by];
    [shipmentView addSubview:inspection_summary];
    [shipmentView addSubview:received_on];
    [shipmentView addSubview:inspection_status];
    [shipmentView addSubview:remarks];
    [shipmentView addSubview:searchItem];
    [shipmentView addSubview:itemTable];
    [shipmentView addSubview:skListTable];
    [shipmentView addSubview:label1];
    [shipmentView addSubview:label2];
    [shipmentView addSubview:label3];
    [shipmentView addSubview:label4];
    [shipmentView addSubview: label5];
    [self.view addSubview:shipmentView];
    [self.view addSubview:orderButton];
    [self.view addSubview:cancelButton];
    
    NSArray *segmentLabels = [NSArray arrayWithObjects:@"New Shipment",@"View Shipment", nil];
    
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

    /** SearchBarItem*/
    const NSInteger searchBarHeight = 40;
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
    
    shipmentInspectionServicesSoapBinding *service = [[shipmentInspectionServicesSvc shipmentInspectionServicesSoapBinding] retain];
    shipmentInspectionServicesSvc_getInspection *aparams = [[shipmentInspectionServicesSvc_getInspection alloc] init];
    NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str_ = [time_ componentsSeparatedByString:@" "];
    NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"requestHeader", nil];
    
    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",wareInspectionChangeNum_],dictionary, nil];
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
    aparams.getInspectionRequest = normalStockString;
    shipmentInspectionServicesSoapBindingResponse *response = [service getInspectionUsingParameters:(shipmentInspectionServicesSvc_getInspection *)aparams];
    
    NSArray *responseBodyParts =  response.bodyParts;
    
    for (id bodyPart in responseBodyParts) {
        if ([bodyPart isKindOfClass:[shipmentInspectionServicesSvc_getInspectionResponse class]]) {
            shipmentInspectionServicesSvc_getInspectionResponse *body = (shipmentInspectionServicesSvc_getInspectionResponse *)bodyPart;
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
    
    if ([[json objectForKey:@"responseMessage"] isEqualToString:@"Success"] && [[json objectForKey:@"responseCode"] isEqualToString:@"0"]) {
        
        // initialize the arrays ..
        itemIdArray = [[NSMutableArray alloc] init];
        orderStatusArray = [[NSMutableArray alloc] init];
        orderAmountArray = [[NSMutableArray alloc] init];
        OrderedOnArray = [[NSMutableArray alloc] init];
        NSArray *listDetails = [JSON1 objectForKey:@"inspectionList"];
        //        NSArray *temp = [result componentsSeparatedByString:@"!"];
        
        recStart.text = [NSString stringWithFormat:@"%d",(wareInspectionChangeNum_ * 10) + 1];
        recEnd.text = [NSString stringWithFormat:@"%d",[recStart.text intValue] + 9];
        totalRec.text = [NSString stringWithFormat:@"%d",[[JSON1 objectForKey:@"totalShipmentInspections"] intValue]];
        
        if ([[JSON1 objectForKey:@"totalShipmentInspections"] intValue] <= 10) {
            recEnd.text = [NSString stringWithFormat:@"%d",[totalRec.text intValue]];
            nextButton.enabled =  NO;
            previousButton.enabled = NO;
            firstButton.enabled = NO;
            lastButton.enabled = NO;
            //nextButton.backgroundColor = [UIColor lightGrayColor];
        }
        else{
            
            if (wareInspectionChangeNum_ == 0) {
                previousButton.enabled = NO;
                firstButton.enabled = NO;
                nextButton.enabled = YES;
                lastButton.enabled = YES;
            }
            else if (([[JSON1 objectForKey:@"totalShipmentInspections"] intValue] - (10 * (wareInspectionChangeNum_+1))) <= 0) {
                
                nextButton.enabled = NO;
                lastButton.enabled = NO;
                recEnd.text = totalRec.text;
            }
        }
        
        
        //[temp removeObjectAtIndex:0];
        
        for (int i = 0; i < [listDetails count]; i++) {
            
            NSDictionary *temp2 = [listDetails objectAtIndex:i];
            
            [itemIdArray addObject:[NSString stringWithFormat:@"%@",[temp2 objectForKey:@"inspection_ref"]]];
            [orderStatusArray addObject:[NSString stringWithFormat:@"%@",[temp2 objectForKey:@"inspection_status"]]];
            [orderAmountArray addObject:[NSString stringWithFormat:@"%@",[temp2 objectForKey:@"inspected_on"]]];
            [OrderedOnArray addObject:[NSString stringWithFormat:@"%@",[temp2 objectForKey:@"received_on"]]];
        }
        
        if ([itemIdArray count] < 5) {
            //nextButton.backgroundColor = [UIColor lightGrayColor];
            nextButton.enabled =  NO;
        }
        
        wareInspectionCount3_ = [itemIdArray count];
        
        if ([listDetails count] == 0) {
            nextButton.enabled = NO;
            lastButton.enabled = NO;
            previousButton.enabled = NO;
            firstButton.enabled = NO;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Inspections To Display" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        
        [orderstockTable reloadData];
    }
    else{
        
        wareInspectionCount2_ = NO;
        wareInspectionChangeNum_--;
        
        //nextButton.backgroundColor = [UIColor lightGrayColor];
        nextButton.enabled =  NO;
        
        //previousButton.backgroundColor = [UIColor grayColor];
        previousButton.enabled =  NO;
        
        firstButton.enabled = NO;
        lastButton.enabled = NO;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Inspections To Display" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
}



- (void)textFieldDidChange:(UITextField *)textField {
    if (textField == searchItem) {
        if ([textField.text length] >= 3) {
            [itemArray removeAllObjects];
            [itemTable reloadData];
            [self searchProduct:textField.text];
            
            if ([rawMaterials count] > 0) {
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    skListTable.frame = CGRectMake(200, 250.0, 360,240);
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
                        skListTable.frame = CGRectMake(200, 250.0, 360,450);
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
                [shipmentView bringSubviewToFront:skListTable];
                [skListTable reloadData];
                skListTable.hidden = NO;
            }
            else {
                skListTable.hidden = YES;
            }
            
        }
        
    }
}
-(void)searchProduct:(NSString *)searchString{
    
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
    HUD_.labelText = @"Loading..";
    
    @try {
        BOOL status = FALSE;
        WarehouseStockVerificationSoapBinding *materialBinding = [[WarehouseStockVerificationSvc WarehouseStockVerificationSoapBinding] retain];
        
        WarehouseStockVerificationSvc_getSkuDetails *aParams = [[WarehouseStockVerificationSvc_getSkuDetails alloc] init];
        
        NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        NSArray *str = [time componentsSeparatedByString:@" "];
        NSString *date_ = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
        
        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
        
        
        
        NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"productId",@"startIndex",@"requestHeader", nil];
        
        NSArray *loyaltyObjects = [NSArray arrayWithObjects:searchString,@"0",dictionary, nil];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        aParams.productId = loyaltyString;
        
        WarehouseStockVerificationSoapBindingResponse *response = [materialBinding getSkuDetailsUsingParameters:(WarehouseStockVerificationSvc_getSkuDetails *)aParams];
        NSArray *responseBodyParts = response.bodyParts;
        NSDictionary *JSONData ;
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[WarehouseStockVerificationSvc_getSkuDetailsResponse class]]) {
                WarehouseStockVerificationSvc_getSkuDetailsResponse *body = (WarehouseStockVerificationSvc_getSkuDetailsResponse *)bodyPart;
                printf("\nresponse=%s",[body.return_ UTF8String]);
                NSError *err;
                status = TRUE;
                JSONData = [[NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                            options: NSJSONReadingMutableContainers
                                                              error: &err] copy];
                inspJSON = [JSONData copy];
            }
        }
        if (status) {
            NSArray *temp = [inspJSON objectForKey:@"sku"];
            rawMaterials = [[NSMutableArray alloc] init];
            for (int i = 0; i < [temp count]; i++) {
                NSDictionary *data = [temp objectAtIndex:i];
                if (![rawMaterials containsObject:[data objectForKey:@"productId"]]) {
                    [rawMaterials addObject:[data objectForKey:@"productId"]];
                }
                
            }
            [HUD_ setHidden:YES];
            [HUD_ release];
        }
    }
    @catch (NSException *exception) {
        
        searchItem.text = nil;
        
        [HUD_ setHidden:YES];
        [HUD_ release];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Unable to load data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    @finally {
        
    }
    
    
}
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == skListTable) {
        return [rawMaterials count];
    }
    else if(tableView == itemTable){
        
        return [itemArray count];
    }
    else if(tableView == orderstockTable){
        return [itemIdArray count];
    }
    else{
        return 0;
    }
}
//heigth for tableviewcell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == skListTable) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            return 45.0;
            
        }
        else {
            return 150.0;
        }
    }
    else if(tableView == itemTable){
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            if (indexPath.row == 0) {
                return 70.0;
            }
            else{
                return 50.0;
            }
            
        }
        else {
            return 150.0;
        }
        
    }
    else if (tableView == orderstockTable) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            return 140.0;
        }
        else {
            return 98.0;
        }
        
    }

    else{
        return 0.0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    tableView.separatorColor = [UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0];
    
    static NSString *hlCellID = @"hlCellID";
    
    UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
    
    static NSString *MyIdentifier = @"MyIdentifier";
    MyIdentifier = @"TableView";
    
    
    if (tableView == skListTable) {
        
        
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
        
        hlcell.textLabel.text = [NSString stringWithFormat:@"%@",[rawMaterials objectAtIndex:indexPath.row]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        
        
        
    }
    else if (tableView == itemTable){
        if ([itemArray count] >= 1) {
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
            NSArray *temp = [[itemArray objectAtIndex:indexPath.row] componentsSeparatedByString:@"#"];
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
                label1.text = [temp objectAtIndex:0];
                label1.textColor = [UIColor whiteColor];
                
                UILabel *label5 = [[[UILabel alloc] initWithFrame:CGRectMake(154, 0, 151, 50)] autorelease];
                label5.font = [UIFont systemFontOfSize:22.0];
                label5.layer.borderWidth = 1.5;
                label5.backgroundColor = [UIColor clearColor];
                label5.textAlignment = NSTextAlignmentCenter;
                label5.numberOfLines = 2;
                label5.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label5.lineBreakMode = NSLineBreakByWordWrapping;
                label5.text = [temp objectAtIndex:1];
                label5.textColor = [UIColor whiteColor];
                
                UILabel *label2 = [[[UILabel alloc] initWithFrame:CGRectMake(305, 0, 150, 50)] autorelease];
                label2.font = [UIFont systemFontOfSize:22.0];
                label2.backgroundColor =  [UIColor clearColor];
                label2.layer.borderWidth = 1.5;
                label2.textAlignment = NSTextAlignmentCenter;
                label2.numberOfLines = 2;
                label2.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label2.text = [temp objectAtIndex:2];
                label2.textColor = [UIColor whiteColor];
                
                
                qtyChange = [UIButton buttonWithType:UIButtonTypeCustom];
                [qtyChange addTarget:self action:@selector(qtyChangePressed:) forControlEvents:UIControlEventTouchDown];
                qtyChange.tag = indexPath.row;
                qtyChange.backgroundColor =  [UIColor clearColor];
                qtyChange.frame = CGRectMake(456, 0, 151, 50);
                
                qtyChange.layer.cornerRadius = 0;
                [qtyChange setTitle:[temp objectAtIndex:3] forState:UIControlStateNormal];
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
                NSString *str = [temp objectAtIndex:4];
                label4.text = str;
                
                // close button to close the view ..
                delButton = [[[UIButton alloc] init] autorelease];
                [delButton addTarget:self action:@selector(delButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                UIImage *image = [UIImage imageNamed:@"delete.png"];
                delButton.tag = [indexPath row];
                delButton.frame = CGRectMake(767, 2, 45, 45);
                [delButton setBackgroundImage:image	forState:UIControlStateNormal];
                
                [hlcell.contentView addSubview:label1];
                [hlcell.contentView addSubview:label2];
                [hlcell.contentView addSubview:label5];
                [hlcell.contentView addSubview:qtyChange];
                [hlcell.contentView addSubview:label4];
                [hlcell.contentView addSubview:delButton];
                
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
                label1.text = [temp objectAtIndex:1];
                
                UILabel *label2 = [[[UILabel alloc] initWithFrame:CGRectMake(66, 0, 68, 34)] autorelease];
                label2.font = [UIFont systemFontOfSize:13.0];
                label2.backgroundColor =  [UIColor whiteColor];
                label2.layer.borderWidth = 1.5;
                label2.textAlignment = NSTextAlignmentCenter;
                label2.numberOfLines = 2;
                label2.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label2.text = [temp objectAtIndex:2];
                
                
                qtyChange = [UIButton buttonWithType:UIButtonTypeCustom];
                [qtyChange addTarget:self action:@selector(qtyChangePressed:) forControlEvents:UIControlEventTouchDown];
                qtyChange.tag = indexPath.row;
                qtyChange.backgroundColor =  [UIColor whiteColor];
                qtyChange.frame = CGRectMake(132, 0, 72, 34);
                qtyChange.layer.cornerRadius = 0;
                [qtyChange setTitle:[temp objectAtIndex:3] forState:UIControlStateNormal];
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
                NSString *str = [temp objectAtIndex:4];
                label4.text = [NSString stringWithFormat:@"%@%@",str,@".0"];
                
                // close button to close the view ..
                delButton = [[[UIButton alloc] init] autorelease];
                [delButton addTarget:self action:@selector(delButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                UIImage *image = [UIImage imageNamed:@"delete.png"];
                delButton.tag = [indexPath row];
                delButton.frame = CGRectMake(274, 7, 22, 22);
                [delButton setBackgroundImage:image	forState:UIControlStateNormal];
                
                
                
                [hlcell.contentView addSubview:label1];
                [hlcell.contentView addSubview:label2];
                [hlcell.contentView addSubview:qtyChange];
                [hlcell.contentView addSubview:label4];
                [hlcell.contentView addSubview:delButton];
            }
            
        }
        hlcell.backgroundColor = [UIColor clearColor];
        
        [hlcell setTag:indexPath.row];

    }
    else if (tableView == orderstockTable){
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

        if (wareInspectionCountValue_ == YES) {
            
            wareInspectionCount2_ = wareInspectionCount2_ + wareInspectionCount1_;
            wareInspectionCount1_ = 0;
        }
        else{
            
            wareInspectionCount2_ = wareInspectionCount2_ - wareInspectionCount3_;
            wareInspectionCount3_ = 0;
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
            
            [hlcell.contentView addSubview:label1];
            [hlcell.contentView addSubview:label2];
            [hlcell.contentView addSubview:label3];
            [hlcell.contentView addSubview:label4];
            
            [hlcell setBackgroundColor:[UIColor blackColor]];
        }
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            hlcell.textLabel.font = [UIFont boldSystemFontOfSize:25];
        }
        else{
            
            hlcell.textLabel.font = [UIFont boldSystemFontOfSize:17];
        }
    }

    return hlcell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    [searchItem resignFirstResponder];
    UITableViewCell* theCell = [tableView cellForRowAtIndexPath:indexPath];
    theCell.contentView.backgroundColor=[UIColor clearColor];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == skListTable) {
        searchItem.text = [NSString stringWithFormat:@"%@",[rawMaterials objectAtIndex:indexPath.row]];
        skListTable.hidden = YES;
        [self searchParticularProduct:[NSString stringWithFormat:@"%@",[rawMaterials objectAtIndex:indexPath.row]]];
    }
    else if (tableView == orderstockTable){
        self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
        self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
        
        ViewWarehouseInspection *vpo = [[ViewWarehouseInspection alloc] initWithInspectionID:[itemIdArray objectAtIndex:indexPath.row]];
        [self.navigationController pushViewController:vpo animated:YES];
    }
}

-(void)searchParticularProduct :(NSString *)searchString{
    
    searchItem.text = nil;
    @try {
        BOOL status = FALSE;
        WarehouseStockVerificationSoapBinding *materialBinding = [[WarehouseStockVerificationSvc WarehouseStockVerificationSoapBinding] retain];
        
        WarehouseStockVerificationSvc_getSkuDetails *aParams = [[WarehouseStockVerificationSvc_getSkuDetails alloc] init];
        
        NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        NSArray *str = [time componentsSeparatedByString:@" "];
        NSString *date_ = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
        
        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
        
        
        
        NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"productId",@"startIndex",@"requestHeader", nil];
        
        NSArray *loyaltyObjects = [NSArray arrayWithObjects:searchString,@"0",dictionary, nil];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        aParams.productId = loyaltyString;
        
        WarehouseStockVerificationSoapBindingResponse *response = [materialBinding getSkuDetailsUsingParameters:(WarehouseStockVerificationSvc_getSkuDetails *)aParams];
        NSArray *responseBodyParts = response.bodyParts;
        NSDictionary *JSONData ;
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[WarehouseStockVerificationSvc_getSkuDetailsResponse class]]) {
                WarehouseStockVerificationSvc_getSkuDetailsResponse *body = (WarehouseStockVerificationSvc_getSkuDetailsResponse *)bodyPart;
                printf("\nresponse=%s",[body.return_ UTF8String]);
                NSError *err;
                status = TRUE;
                JSONData = [[NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                            options: NSJSONReadingMutableContainers
                                                              error: &err] copy];
                inspJSON = [JSONData copy];
            }
        }
        if (status) {
            NSArray *temp = [inspJSON objectForKey:@"sku"];
            NSDictionary *data = NULL;
            for (int i = 0; i < [temp count]; i++) {
                data = [temp objectAtIndex:i];
                NSString *finalStr = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@",[data objectForKey:@"skuID"],@"#",[NSString stringWithFormat:@"%@",[data objectForKey:@"description"]],@"#",[NSString stringWithFormat:@"%@",[data objectForKey:@"description"]],@"#",[NSString stringWithFormat:@"%@",[data objectForKey:@"buy_price"]],@"#",@"1",@"#",[NSString stringWithFormat:@"%@",[data objectForKey:@"buy_price"]]];
                [itemArray addObject:finalStr];
            }
            [shipmentView addSubview:itemTable];
            itemTable.hidden = NO;
            [itemTable reloadData];
        }
        
    }
    @catch (NSException *exception) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Unable to load data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    @finally {
        
    }
    
}
-(void) delButtonPressed:(id) sender {
    
    AudioServicesPlaySystemSound (soundFileObject);
    
    [itemArray removeObjectAtIndex:[sender tag]];
    [itemTable reloadData];
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
    wareInspectionChangeNum_ = 0;
    //    cellcount = 10;
    
    //[HUD setHidden:NO];
    [HUD show:YES];
    
    shipmentInspectionServicesSoapBinding *service = [[shipmentInspectionServicesSvc shipmentInspectionServicesSoapBinding] retain];
    shipmentInspectionServicesSvc_getInspection *aparams = [[shipmentInspectionServicesSvc_getInspection alloc] init];
    NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str_ = [time_ componentsSeparatedByString:@" "];
    NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"requestHeader", nil];
    
    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",wareInspectionChangeNum_],dictionary, nil];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
    
    NSError * err_;
    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
    
    aparams.getInspectionRequest = normalStockString;
    shipmentInspectionServicesSoapBindingResponse *response = [service getInspectionUsingParameters:(shipmentInspectionServicesSvc_getInspection *)aparams];
    
    NSArray *responseBodyParts =  response.bodyParts;
    
    for (id bodyPart in responseBodyParts) {
        if ([bodyPart isKindOfClass:[shipmentInspectionServicesSvc_getInspectionResponse class]]) {
            shipmentInspectionServicesSvc_getInspectionResponse *body = (shipmentInspectionServicesSvc_getInspectionResponse *)bodyPart;
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
        
        wareInspectionChangeNum_ = [totalRec.text intValue]/10 - 1;
    }
    else{
        wareInspectionChangeNum_ =[totalRec.text intValue]/10;
    }
    //changeID = ([rec_total.text intValue]/5) - 1;
    
    //previousButton.backgroundColor = [UIColor grayColor];
    wareInspectionCount1_ = (wareInspectionChangeNum_ * 10);
    
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
    
    shipmentInspectionServicesSoapBinding *service = [[shipmentInspectionServicesSvc shipmentInspectionServicesSoapBinding] retain];
    shipmentInspectionServicesSvc_getInspection *aparams = [[shipmentInspectionServicesSvc_getInspection alloc] init];
    NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str_ = [time_ componentsSeparatedByString:@" "];
    NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"requestHeader", nil];
    
    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",wareInspectionCount1_],dictionary, nil];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
    
    NSError * err_;
    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
    
    aparams.getInspectionRequest = normalStockString;
    shipmentInspectionServicesSoapBindingResponse *response = [service getInspectionUsingParameters:(shipmentInspectionServicesSvc_getInspection *)aparams];
    
    NSArray *responseBodyParts =  response.bodyParts;
    
    for (id bodyPart in responseBodyParts) {
        if ([bodyPart isKindOfClass:[shipmentInspectionServicesSvc_getInspectionResponse class]]) {
            shipmentInspectionServicesSvc_getInspectionResponse *body = (shipmentInspectionServicesSvc_getInspectionResponse *)bodyPart;
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
    
    if (wareInspectionChangeNum_ > 0){
        
        //nextButton.backgroundColor = [UIColor grayColor];
        nextButton.enabled =  YES;
        
        wareInspectionChangeNum_--;
        wareInspectionCount1_ = (wareInspectionChangeNum_ * 10);
        
        [itemIdArray removeAllObjects];
        [orderStatusArray removeAllObjects];
        [orderAmountArray removeAllObjects];
        [OrderedOnArray removeAllObjects];
        
        wareInspectionCountValue_ = NO;
        
        [HUD setHidden:NO];
        
        shipmentInspectionServicesSoapBinding *service = [[shipmentInspectionServicesSvc shipmentInspectionServicesSoapBinding] retain];
        shipmentInspectionServicesSvc_getInspection *aparams = [[shipmentInspectionServicesSvc_getInspection alloc] init];
        NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        NSArray *str_ = [time_ componentsSeparatedByString:@" "];
        NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
        
        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
        NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"requestHeader", nil];
        
        NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",wareInspectionCount1_],dictionary, nil];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        aparams.getInspectionRequest = normalStockString;
        shipmentInspectionServicesSoapBindingResponse *response = [service getInspectionUsingParameters:(shipmentInspectionServicesSvc_getInspection *)aparams];
        
        NSArray *responseBodyParts =  response.bodyParts;
        
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[shipmentInspectionServicesSvc_getInspectionResponse class]]) {
                shipmentInspectionServicesSvc_getInspectionResponse *body = (shipmentInspectionServicesSvc_getInspectionResponse *)bodyPart;
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
    
    wareInspectionChangeNum_++;
    
    wareInspectionCount1_ = (wareInspectionChangeNum_ * 10);
    
    [itemIdArray removeAllObjects];
    [orderStatusArray removeAllObjects];
    [orderAmountArray removeAllObjects];
    [OrderedOnArray removeAllObjects];
    
    //previousButton.backgroundColor = [UIColor grayColor];
    previousButton.enabled =  YES;
    firstButton.enabled = YES;
    
    wareInspectionCountValue_ = YES;
    
    [HUD setHidden:NO];
    
    shipmentInspectionServicesSoapBinding *service = [[shipmentInspectionServicesSvc shipmentInspectionServicesSoapBinding] retain];
    shipmentInspectionServicesSvc_getInspection *aparams = [[shipmentInspectionServicesSvc_getInspection alloc] init];
    NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str_ = [time_ componentsSeparatedByString:@" "];
    NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"requestHeader", nil];
    
    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",wareInspectionCount1_],dictionary, nil];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
    
    NSError * err_;
    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
    
    aparams.getInspectionRequest = normalStockString;
    shipmentInspectionServicesSoapBindingResponse *response = [service getInspectionUsingParameters:(shipmentInspectionServicesSvc_getInspection *)aparams];
    
    NSArray *responseBodyParts =  response.bodyParts;
    
    for (id bodyPart in responseBodyParts) {
        if ([bodyPart isKindOfClass:[shipmentInspectionServicesSvc_getInspectionResponse class]]) {
            shipmentInspectionServicesSvc_getInspectionResponse *body = (shipmentInspectionServicesSvc_getInspectionResponse *)bodyPart;
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

- (void) orderButtonPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    NSString *shipmentIdValue = [po_ref.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *lshipmentNoteValue = [shipment_note_ref.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipmentDateValue = [inspected_by.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipmentModeValue = [inspection_summary.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipmentAgencyValue = [received_on.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipmentAgencyContactValue = [inspection_status.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *inspectedByValue = [remarks.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([itemArray count] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Add Items to Cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else if ([shipmentIdValue length] == 0 || [lshipmentNoteValue length] == 0 || [shipmentDateValue length] == 0 || [shipmentModeValue length] == 0 || [shipmentAgencyValue length] == 0 || [shipmentAgencyContactValue length] == 0 || [inspectedByValue length] == 0 ){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Fields couldn't be empty" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else{
        HUD.labelText = @"Creating Inspection..";
        [HUD setHidden:NO];
        
        NSMutableArray *items = [[NSMutableArray alloc] init];
        for (int i = 0; i < [itemArray count]; i++) {
            NSArray *temp = [[itemArray objectAtIndex:i] componentsSeparatedByString:@"#"];
            NSArray *keys = [NSArray arrayWithObjects:@"item_id", @"item_desc",@"UOM",@"quantity",@"status",@"inspection_details", nil];
            NSArray *objects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",[temp objectAtIndex:0]],[NSString stringWithFormat:@"%@",[temp objectAtIndex:1]],@"piece",[NSString stringWithFormat:@"%@",[temp objectAtIndex:3]],@"Submitted",@"hhgjk", nil];
            NSDictionary *itemsDic = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
//            totalQuantity = totalQuantity + [[QtyArray objectAtIndex:i] intValue];
            [items addObject:itemsDic];
        }
        
        shipmentInspectionServicesSoapBinding *service = [[shipmentInspectionServicesSvc shipmentInspectionServicesSoapBinding] retain];
        shipmentInspectionServicesSvc_newInspection *aparams = [[shipmentInspectionServicesSvc_newInspection alloc] init];
        NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        NSArray *str_ = [time_ componentsSeparatedByString:@" "];
        NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
        
        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
        NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"po_ref", @"shipment_note_ref",@"received_on_string",@"inspected_by",@"inspection_summary",@"inspection_status",@"remarks",@"itemsList",@"requestHeader", nil];
        
        NSArray *loyaltyObjects = [NSArray arrayWithObjects:po_ref.text,shipment_note_ref.text,received_on.text,inspected_by.text,inspection_summary.text,inspection_status.text,remarks.text,items,dictionary, nil];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        aparams.newInspectionRequest = normalStockString;
        shipmentInspectionServicesSoapBindingResponse *response = [service newInspectionUsingParameters:(shipmentInspectionServicesSvc_newInspection *)aparams];
        
        NSArray *responseBodyParts =  response.bodyParts;
        NSError *e;
        
        NSDictionary *JSON1;
        
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[shipmentInspectionServicesSvc_newInspectionResponse class]]) {
                shipmentInspectionServicesSvc_newInspectionResponse *body = (shipmentInspectionServicesSvc_newInspectionResponse *)bodyPart;
                NSLog(@"%@",body.return_);
                JSON1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                        options: NSJSONReadingMutableContainers
                                                          error: &e];
                NSDictionary *responseDic = [JSON1 objectForKey:@"responseHeader"];
                if ([[responseDic objectForKey:@"responseMessage"] isEqualToString:@"Success"] && [[responseDic objectForKey:@"responseCode"] isEqualToString:@"0"]) {
                    NSString *status = [NSString stringWithFormat:@"%@%@%@%@",@"Successfully Inspection Created",@"\n",@"Inspection ID :",[JSON1 objectForKey:@"inspection_id"]];
                    wareInspection = [[JSON1 objectForKey:@"inspection_id"] copy];
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
                    
                    po_ref.text = nil;
                    shipment_note_ref.text = nil;
                    inspected_by.text = currentdate;
                    inspection_summary.text = nil;
                    received_on.text= nil;
                    inspection_status.text = nil;
                    remarks.text = nil;
                    
                    [itemArray removeAllObjects];
                    
                    
                    [itemTable reloadData];
                    
                }
                else{
                    [HUD setHidden:YES];
                    SystemSoundID	soundFileObject1;
                    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
                    self.soundFileURLRef = (CFURLRef) [tapSound retain];
                    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                    AudioServicesPlaySystemSound (soundFileObject1);
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed Creating Inspection Receipt" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
//    NSString *shipmentCostValue = [shipmentCost.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([itemArray count] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Add Items to Cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else{
        HUD.labelText = @"Saving Invoice..";
        [HUD setHidden:NO];
        
        NSMutableArray *items = [[NSMutableArray alloc] init];
        for (int i = 0; i < [itemArray count]; i++) {
            NSArray *temp = [[itemArray objectAtIndex:i] componentsSeparatedByString:@"#"];
            NSArray *keys = [NSArray arrayWithObjects:@"item_id", @"item_desc",@"UOM",@"quantity",@"status",@"inspection_details", nil];
            NSArray *objects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",[temp objectAtIndex:0]],[NSString stringWithFormat:@"%@",[temp objectAtIndex:1]],@"piece",[NSString stringWithFormat:@"%@",[temp objectAtIndex:3]],@"Submitted",@"hhgjk", nil];
            NSDictionary *itemsDic = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            //            totalQuantity = totalQuantity + [[QtyArray objectAtIndex:i] intValue];
            [items addObject:itemsDic];
        }
        
        shipmentInspectionServicesSoapBinding *service = [[shipmentInspectionServicesSvc shipmentInspectionServicesSoapBinding] retain];
        shipmentInspectionServicesSvc_newInspection *aparams = [[shipmentInspectionServicesSvc_newInspection alloc] init];
        NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        NSArray *str_ = [time_ componentsSeparatedByString:@" "];
        NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
        
        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
        NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"po_ref", @"shipment_note_ref",@"received_on",@"inspected_by",@"inspection_summary",@"inspection_status",@"remarks",@"itemsList",@"requestHeader", nil];
        
        NSArray *loyaltyObjects = [NSArray arrayWithObjects:po_ref.text,shipment_note_ref.text,received_on.text,inspected_by.text,inspection_summary.text,inspection_status.text,remarks.text,items,dictionary, nil];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        aparams.newInspectionRequest = normalStockString;
        shipmentInspectionServicesSoapBindingResponse *response = [service newInspectionUsingParameters:(shipmentInspectionServicesSvc_newInspection *)aparams];
        
        NSArray *responseBodyParts =  response.bodyParts;
        NSError *e;
        
        NSDictionary *JSON1;
        
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[shipmentInspectionServicesSvc_newInspectionResponse class]]) {
                shipmentInspectionServicesSvc_newInspectionResponse *body = (shipmentInspectionServicesSvc_newInspectionResponse *)bodyPart;
                NSLog(@"%@",body.return_);
                JSON1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                        options: NSJSONReadingMutableContainers
                                                          error: &e];
                NSDictionary *responseDic = [JSON1 objectForKey:@"responseHeader"];
                if ([[responseDic objectForKey:@"responseMessage"] isEqualToString:@"Success"] && [[responseDic objectForKey:@"responseCode"] isEqualToString:@"0"]) {
                    NSString *status = [NSString stringWithFormat:@"%@%@%@%@",@"Successfully Inspection Created",@"\n",@"Inspection ID :",[JSON1 objectForKey:@"inspection_id"]];
                    wareInspection = [[JSON1 objectForKey:@"inspection_id"] copy];
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
                    
                    po_ref.text = nil;
                    shipment_note_ref.text = nil;
                    inspected_by.text = currentdate;
                    inspection_summary.text = nil;
                    received_on.text= nil;
                    inspection_status.text = nil;
                    remarks.text = nil;
                    
                    [itemArray removeAllObjects];
                    
                    
                    [itemTable reloadData];
                    
                }
                else{
                    [HUD setHidden:YES];
                    SystemSoundID	soundFileObject1;
                    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
                    self.soundFileURLRef = (CFURLRef) [tapSound retain];
                    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                    AudioServicesPlaySystemSound (soundFileObject1);
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed Saving Inspection Receipt" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
            
            ViewWarehouseInspection *vpo = [[ViewWarehouseInspection alloc] initWithInspectionID:wareInspection];
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
