//
//  EditWarehouseShipment.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/22/15.
//
//

#import "EditWarehouseShipment.h"
#import "WHShippingServicesSvc.h"
#import "Global.h"
#import "SkuServiceSvc.h"
#import "ViewWarehouseShipment.h"
#import "WareHouseShipments.h"

@interface EditWarehouseShipment ()

@end

@implementation EditWarehouseShipment
@synthesize soundFileURLRef,soundFileObject;
NSString *wareEditShipmentID;
BOOL wareEditShipNewItem__ = YES;

-(id) initWithShipmentID:(NSString *)shipmentID{
    
    wareEditShipmentID = [shipmentID copy];
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
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 450.0, 45.0)];
    titleView.backgroundColor = [UIColor clearColor];
    
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo_200.png"]];
    logoView.backgroundColor = [UIColor clearColor];
    logoView.frame = CGRectMake(60.0, 0.0, 45.0, 45.0);
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(110.0, -13.0, 300.0, 70.0)];
    titleLbl.text = @"Edit Warehouse Shipment";
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
        titleLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:13.0f];
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
    shipmentNote = [[[UILabel alloc] init] autorelease];
    shipmentNote.text = @"Shipment Note :";
    shipmentNote.layer.masksToBounds = YES;
    shipmentNote.numberOfLines = 2;
    [shipmentNote setTextAlignment:NSTextAlignmentLeft];
    shipmentNote.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentNote.textColor = [UIColor whiteColor];
    shipmentDate = [[[UILabel alloc] init] autorelease];
    shipmentDate.text = @"Shipment Date :";
    shipmentDate.layer.masksToBounds = YES;
    shipmentDate.numberOfLines = 2;
    [shipmentDate setTextAlignment:NSTextAlignmentLeft];
    shipmentDate.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentDate.textColor = [UIColor whiteColor];
    shipmentMode = [[[UILabel alloc] init] autorelease];
    shipmentMode.text = @"Shipment Mode :";
    shipmentMode.layer.masksToBounds = YES;
    shipmentMode.numberOfLines = 2;
    [shipmentMode setTextAlignment:NSTextAlignmentLeft];
    shipmentMode.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentMode.textColor = [UIColor whiteColor];
    shipmentAgency = [[[UILabel alloc] init] autorelease];
    shipmentAgency.text = @"Shipment Agency :";
    shipmentAgency.layer.masksToBounds = YES;
    shipmentAgency.numberOfLines = 2;
    [shipmentAgency setTextAlignment:NSTextAlignmentLeft];
    shipmentAgency.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentAgency.textColor = [UIColor whiteColor];
    shipmentAgencyContact = [[[UILabel alloc] init] autorelease];
    shipmentAgencyContact.text = @"Shipment Agency Contact :";
    shipmentAgencyContact.layer.masksToBounds = YES;
    shipmentAgencyContact.numberOfLines = 2;
    [shipmentAgencyContact setTextAlignment:NSTextAlignmentLeft];
    shipmentAgencyContact.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentAgencyContact.textColor = [UIColor whiteColor];
    inspectedBy = [[[UILabel alloc] init] autorelease];
    inspectedBy.text = @"Inspected By :";
    inspectedBy.layer.masksToBounds = YES;
    inspectedBy.numberOfLines = 2;
    [inspectedBy setTextAlignment:NSTextAlignmentLeft];
    inspectedBy.font = [UIFont boldSystemFontOfSize:14.0];
    inspectedBy.textColor = [UIColor whiteColor];
    shippedBy = [[[UILabel alloc] init] autorelease];
    shippedBy.text = @"Shipped By :";
    shippedBy.layer.masksToBounds = YES;
    shippedBy.numberOfLines = 2;
    [shippedBy setTextAlignment:NSTextAlignmentLeft];
    shippedBy.font = [UIFont boldSystemFontOfSize:14.0];
    shippedBy.textColor = [UIColor whiteColor];
    rfidTagNo = [[[UILabel alloc] init] autorelease];
    rfidTagNo.text = @"RFID Tag No. :";
    rfidTagNo.layer.masksToBounds = YES;
    rfidTagNo.numberOfLines = 2;
    [rfidTagNo setTextAlignment:NSTextAlignmentLeft];
    rfidTagNo.font = [UIFont boldSystemFontOfSize:14.0];
    rfidTagNo.textColor = [UIColor whiteColor];
    shipmentCost = [[[UILabel alloc] init] autorelease];
    shipmentCost.text = @"Shipment Cost :";
    shipmentCost.layer.masksToBounds = YES;
    shipmentCost.numberOfLines = 2;
    [shipmentCost setTextAlignment:NSTextAlignmentLeft];
    shipmentCost.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentCost.textColor = [UIColor whiteColor];
    shipmentLocation = [[[UILabel alloc] init] autorelease];
    shipmentLocation.text = @"Shipment Location :";
    shipmentLocation.layer.masksToBounds = YES;
    shipmentLocation.numberOfLines = 2;
    [shipmentLocation setTextAlignment:NSTextAlignmentLeft];
    shipmentLocation.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentLocation.textColor = [UIColor whiteColor];
    shipmentCity = [[[UILabel alloc] init] autorelease];
    shipmentCity.text = @"Shipment City :";
    shipmentCity.layer.masksToBounds = YES;
    shipmentCity.numberOfLines = 2;
    [shipmentCity setTextAlignment:NSTextAlignmentLeft];
    shipmentCity.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentCity.textColor = [UIColor whiteColor];
    shipmentStreet = [[[UILabel alloc] init] autorelease];
    shipmentStreet.text = @"Shipment Street :";
    shipmentStreet.layer.masksToBounds = YES;
    shipmentStreet.numberOfLines = 2;
    [shipmentStreet setTextAlignment:NSTextAlignmentLeft];
    shipmentStreet.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentStreet.textColor = [UIColor whiteColor];
    packagesDescription = [[[UILabel alloc] init] autorelease];
    packagesDescription.text = @"Package Description :";
    packagesDescription.layer.masksToBounds = YES;
    packagesDescription.numberOfLines = 2;
    [packagesDescription setTextAlignment:NSTextAlignmentLeft];
    packagesDescription.font = [UIFont boldSystemFontOfSize:14.0];
    packagesDescription.textColor = [UIColor whiteColor];
    gatePassRef = [[[UILabel alloc] init] autorelease];
    gatePassRef.text = @"Gate Pass Reference :";
    gatePassRef.layer.masksToBounds = YES;
    gatePassRef.numberOfLines = 2;
    [gatePassRef setTextAlignment:NSTextAlignmentLeft];
    gatePassRef.font = [UIFont boldSystemFontOfSize:14.0];
    gatePassRef.textColor = [UIColor whiteColor];
    
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
    shipmentIdValue.placeholder = @"   Order ID";
    
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
    
    shipmentNoteValue = [[UITextField alloc] init];
    shipmentNoteValue.borderStyle = UITextBorderStyleRoundedRect;
    shipmentNoteValue.textColor = [UIColor blackColor];
    shipmentNoteValue.font = [UIFont systemFontOfSize:18.0];
    shipmentNoteValue.backgroundColor = [UIColor whiteColor];
    shipmentNoteValue.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentNoteValue.backgroundColor = [UIColor whiteColor];
    shipmentNoteValue.autocorrectionType = UITextAutocorrectionTypeNo;
    shipmentNoteValue.layer.borderColor = [UIColor whiteColor].CGColor;
    shipmentNoteValue.backgroundColor = [UIColor whiteColor];
    shipmentNoteValue.delegate = self;
    shipmentNoteValue.placeholder = @"   Shipment Note";
    
    // getting present date & time ..
    NSDate *today = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString* currentdate = [f stringFromDate:today];
    [f release];
    
    shipmentDateValue = [[UITextField alloc] init];
    shipmentDateValue.borderStyle = UITextBorderStyleRoundedRect;
    shipmentDateValue.textColor = [UIColor blackColor];
    shipmentDateValue.font = [UIFont systemFontOfSize:18.0];
    shipmentDateValue.backgroundColor = [UIColor whiteColor];
    shipmentDateValue.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentDateValue.backgroundColor = [UIColor whiteColor];
    shipmentDateValue.autocorrectionType = UITextAutocorrectionTypeNo;
    shipmentDateValue.layer.borderColor = [UIColor whiteColor].CGColor;
    shipmentDateValue.backgroundColor = [UIColor whiteColor];
    shipmentDateValue.delegate = self;
    shipmentDateValue.placeholder = @"   Shipment Date";
    shipmentDateValue.userInteractionEnabled = NO;
    shipmentDateValue.text = currentdate;
    
    shipmentModeValue = [[UITextField alloc] init];
    shipmentModeValue.borderStyle = UITextBorderStyleRoundedRect;
    shipmentModeValue.textColor = [UIColor blackColor];
    shipmentModeValue.font = [UIFont systemFontOfSize:18.0];
    shipmentModeValue.backgroundColor = [UIColor whiteColor];
    shipmentModeValue.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentModeValue.backgroundColor = [UIColor whiteColor];
    shipmentModeValue.autocorrectionType = UITextAutocorrectionTypeNo;
    shipmentModeValue.layer.borderColor = [UIColor whiteColor].CGColor;
    shipmentModeValue.backgroundColor = [UIColor whiteColor];
    shipmentModeValue.delegate = self;
    shipmentModeValue.placeholder = @"   Shipment Mode";
    
    shipoModeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImageSM = [UIImage imageNamed:@"combo.png"];
    [shipoModeButton setBackgroundImage:buttonImageSM forState:UIControlStateNormal];
    [shipoModeButton addTarget:self action:@selector(shipoModeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // ShipModeTableview cration....
    shipModeTable = [[UITableView alloc]init];
    shipModeTable.layer.borderWidth = 1.0;
    shipModeTable.layer.cornerRadius = 10.0;
    shipModeTable.bounces = FALSE;
    shipModeTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    shipModeTable.layer.borderColor = [UIColor blackColor].CGColor;
    [shipModeTable setDataSource:self];
    [shipModeTable setDelegate:self];

    
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
    
    shipmentAgencyContactValue = [[UITextField alloc] init];
    shipmentAgencyContactValue.borderStyle = UITextBorderStyleRoundedRect;
    shipmentAgencyContactValue.textColor = [UIColor blackColor];
    shipmentAgencyContactValue.font = [UIFont systemFontOfSize:18.0];
    shipmentAgencyContactValue.backgroundColor = [UIColor whiteColor];
    shipmentAgencyContactValue.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentAgencyContactValue.backgroundColor = [UIColor whiteColor];
    shipmentAgencyContactValue.autocorrectionType = UITextAutocorrectionTypeNo;
    shipmentAgencyContactValue.layer.borderColor = [UIColor whiteColor].CGColor;
    shipmentAgencyContactValue.backgroundColor = [UIColor whiteColor];
    shipmentAgencyContactValue.delegate = self;
    shipmentAgencyContactValue.placeholder = @"   Shipment Agency Contact";
    
    inspectedByValue = [[UITextField alloc] init];
    inspectedByValue.borderStyle = UITextBorderStyleRoundedRect;
    inspectedByValue.textColor = [UIColor blackColor];
    inspectedByValue.font = [UIFont systemFontOfSize:18.0];
    inspectedByValue.backgroundColor = [UIColor whiteColor];
    inspectedByValue.clearButtonMode = UITextFieldViewModeWhileEditing;
    inspectedByValue.backgroundColor = [UIColor whiteColor];
    inspectedByValue.autocorrectionType = UITextAutocorrectionTypeNo;
    inspectedByValue.layer.borderColor = [UIColor whiteColor].CGColor;
    inspectedByValue.backgroundColor = [UIColor whiteColor];
    inspectedByValue.delegate = self;
    inspectedByValue.placeholder = @"   Inspected By";
    
    shippedByValue = [[UITextField alloc] init];
    shippedByValue.borderStyle = UITextBorderStyleRoundedRect;
    shippedByValue.textColor = [UIColor blackColor];
    shippedByValue.font = [UIFont systemFontOfSize:18.0];
    shippedByValue.backgroundColor = [UIColor whiteColor];
    shippedByValue.clearButtonMode = UITextFieldViewModeWhileEditing;
    shippedByValue.backgroundColor = [UIColor whiteColor];
    shippedByValue.autocorrectionType = UITextAutocorrectionTypeNo;
    shippedByValue.layer.borderColor = [UIColor whiteColor].CGColor;
    shippedByValue.backgroundColor = [UIColor whiteColor];
    shippedByValue.delegate = self;
    shippedByValue.placeholder = @"   Shipped By";
    
    rfidTagNoValue = [[UITextField alloc] init];
    rfidTagNoValue.borderStyle = UITextBorderStyleRoundedRect;
    rfidTagNoValue.textColor = [UIColor blackColor];
    rfidTagNoValue.font = [UIFont systemFontOfSize:18.0];
    rfidTagNoValue.backgroundColor = [UIColor whiteColor];
    rfidTagNoValue.clearButtonMode = UITextFieldViewModeWhileEditing;
    rfidTagNoValue.backgroundColor = [UIColor whiteColor];
    rfidTagNoValue.autocorrectionType = UITextAutocorrectionTypeNo;
    rfidTagNoValue.layer.borderColor = [UIColor whiteColor].CGColor;
    rfidTagNoValue.backgroundColor = [UIColor whiteColor];
    rfidTagNoValue.delegate = self;
    rfidTagNoValue.placeholder = @"   RFID Tag No";
    
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
    
    shipmentCityValue = [[UITextField alloc] init];
    shipmentCityValue.borderStyle = UITextBorderStyleRoundedRect;
    shipmentCityValue.textColor = [UIColor blackColor];
    shipmentCityValue.font = [UIFont systemFontOfSize:18.0];
    shipmentCityValue.backgroundColor = [UIColor whiteColor];
    shipmentCityValue.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentCityValue.backgroundColor = [UIColor whiteColor];
    shipmentCityValue.autocorrectionType = UITextAutocorrectionTypeNo;
    shipmentCityValue.layer.borderColor = [UIColor whiteColor].CGColor;
    shipmentCityValue.backgroundColor = [UIColor whiteColor];
    shipmentCityValue.delegate = self;
    shipmentCityValue.placeholder = @"   Shipment City";
    
    shipmentLocationValue = [[UITextField alloc] init];
    shipmentLocationValue.borderStyle = UITextBorderStyleRoundedRect;
    shipmentLocationValue.textColor = [UIColor blackColor];
    shipmentLocationValue.font = [UIFont systemFontOfSize:18.0];
    shipmentLocationValue.backgroundColor = [UIColor whiteColor];
    shipmentLocationValue.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentLocationValue.backgroundColor = [UIColor whiteColor];
    shipmentLocationValue.autocorrectionType = UITextAutocorrectionTypeNo;
    shipmentLocationValue.layer.borderColor = [UIColor whiteColor].CGColor;
    shipmentLocationValue.backgroundColor = [UIColor whiteColor];
    shipmentLocationValue.delegate = self;
    shipmentLocationValue.placeholder = @"   Shipment Location";
    
    shipmentStreetValue = [[UITextField alloc] init];
    shipmentStreetValue.borderStyle = UITextBorderStyleRoundedRect;
    shipmentStreetValue.textColor = [UIColor blackColor];
    shipmentStreetValue.font = [UIFont systemFontOfSize:18.0];
    shipmentStreetValue.backgroundColor = [UIColor whiteColor];
    shipmentStreetValue.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentStreetValue.backgroundColor = [UIColor whiteColor];
    shipmentStreetValue.autocorrectionType = UITextAutocorrectionTypeNo;
    shipmentStreetValue.layer.borderColor = [UIColor whiteColor].CGColor;
    shipmentStreetValue.backgroundColor = [UIColor whiteColor];
    shipmentStreetValue.delegate = self;
    shipmentStreetValue.placeholder = @"   Shipment Street";
    
    packagesDescriptionValue = [[UITextField alloc] init];
    packagesDescriptionValue.borderStyle = UITextBorderStyleRoundedRect;
    packagesDescriptionValue.textColor = [UIColor blackColor];
    packagesDescriptionValue.font = [UIFont systemFontOfSize:18.0];
    packagesDescriptionValue.backgroundColor = [UIColor whiteColor];
    packagesDescriptionValue.clearButtonMode = UITextFieldViewModeWhileEditing;
    packagesDescriptionValue.backgroundColor = [UIColor whiteColor];
    packagesDescriptionValue.autocorrectionType = UITextAutocorrectionTypeNo;
    packagesDescriptionValue.layer.borderColor = [UIColor whiteColor].CGColor;
    packagesDescriptionValue.backgroundColor = [UIColor whiteColor];
    packagesDescriptionValue.delegate = self;
    packagesDescriptionValue.placeholder = @"   Package Description";
    
    gatePassRefValue = [[UITextField alloc] init];
    gatePassRefValue.borderStyle = UITextBorderStyleRoundedRect;
    gatePassRefValue.textColor = [UIColor blackColor];
    gatePassRefValue.font = [UIFont systemFontOfSize:18.0];
    gatePassRefValue.backgroundColor = [UIColor whiteColor];
    gatePassRefValue.clearButtonMode = UITextFieldViewModeWhileEditing;
    gatePassRefValue.backgroundColor = [UIColor whiteColor];
    gatePassRefValue.autocorrectionType = UITextAutocorrectionTypeNo;
    gatePassRefValue.layer.borderColor = [UIColor whiteColor].CGColor;
    gatePassRefValue.backgroundColor = [UIColor whiteColor];
    gatePassRefValue.delegate = self;
    gatePassRefValue.placeholder = @"   Gate Pass Ref.";

    
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
    searchItem.delegate = self;
    
    
    /** Search Button*/
    searchBtton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtton addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventTouchDown];
    [searchBtton setTitle:@"Search" forState:UIControlStateNormal];
    searchBtton.backgroundColor = [UIColor grayColor];
    
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
    UILabel *tax = [[[UILabel alloc] init] autorelease];
    
    
    tax.text = @"Tax 8.25%";
    tax.textColor = [UIColor whiteColor];
    tax.backgroundColor = [UIColor clearColor];
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
    skuIdArray = [[NSMutableArray alloc] init];
    ItemArray = [[NSMutableArray alloc] init];
    ItemDiscArray = [[NSMutableArray alloc] init];
    priceArray = [[NSMutableArray alloc] init];
    QtyArray = [[NSMutableArray alloc] init];
    totalArray = [[NSMutableArray alloc] init];
    totalQtyArray = [[NSMutableArray alloc] init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        shipmentView.frame = CGRectMake(0, 0.0, self.view.frame.size.width, 830.0);
        shipmentView.contentSize = CGSizeMake(self.view.frame.size.width + 200, 1500.0);
        
        shipmentId.font = [UIFont boldSystemFontOfSize:20];
        shipmentId.frame = CGRectMake(10, 0.0, 200.0, 55);
        shipmentIdValue.font = [UIFont boldSystemFontOfSize:20];
        shipmentIdValue.frame = CGRectMake(250.0, 0.0, 200.0, 40);
        
        orderId.font = [UIFont boldSystemFontOfSize:20];
        orderId.frame = CGRectMake(460.0, 0.0, 200.0, 55);
        orderIdValue.font = [UIFont boldSystemFontOfSize:20];
        orderIdValue.frame = CGRectMake(700.0, 0.0, 200.0, 40);
        
        shipmentNote.font = [UIFont boldSystemFontOfSize:20];
        shipmentNote.frame = CGRectMake(10, 60.0, 200.0, 55);
        shipmentNoteValue.font = [UIFont boldSystemFontOfSize:20];
        shipmentNoteValue.frame = CGRectMake(250.0, 60.0, 200.0, 40);
        
        shipmentDate.font = [UIFont boldSystemFontOfSize:20];
        shipmentDate.frame = CGRectMake(460.0, 60.0, 200.0, 55);
        shipmentDateValue.font = [UIFont boldSystemFontOfSize:20];
        shipmentDateValue.frame = CGRectMake(700.0, 60.0, 200.0, 40);
        
        shipmentMode.font = [UIFont boldSystemFontOfSize:20];
        shipmentMode.frame = CGRectMake(10, 120.0, 200.0, 55);
        shipmentModeValue.font = [UIFont boldSystemFontOfSize:20];
        shipmentModeValue.frame = CGRectMake(250.0, 120.0, 200.0, 40);
        shipoModeButton.frame = CGRectMake(410.0, 115.0, 50, 55);
        shipModeTable.frame = CGRectMake(200, 260, 340, 270);
        [self.view addSubview:shipModeTable];
        shipModeTable.hidden = YES;
        
        shipmentAgency.font = [UIFont boldSystemFontOfSize:20];
        shipmentAgency.frame = CGRectMake(460.0, 120.0, 200.0, 55);
        shipmentAgencyValue.font = [UIFont boldSystemFontOfSize:20];
        shipmentAgencyValue.frame = CGRectMake(700.0, 120.0, 200.0, 40);
        
        shipmentAgencyContact.font = [UIFont boldSystemFontOfSize:20];
        shipmentAgencyContact.frame = CGRectMake(10, 180.0, 200.0, 55);
        shipmentAgencyContactValue.font = [UIFont boldSystemFontOfSize:20];
        shipmentAgencyContactValue.frame = CGRectMake(250.0, 180.0, 200.0, 40);
        
        inspectedBy.font = [UIFont boldSystemFontOfSize:20];
        inspectedBy.frame = CGRectMake(460.0, 180.0, 200.0, 55);
        inspectedByValue.font = [UIFont boldSystemFontOfSize:20];
        inspectedByValue.frame = CGRectMake(700.0, 180.0, 200.0, 40);
        
        shippedBy.font = [UIFont boldSystemFontOfSize:20];
        shippedBy.frame = CGRectMake(10, 240.0, 200.0, 55);
        shippedByValue.font = [UIFont boldSystemFontOfSize:20];
        shippedByValue.frame = CGRectMake(250.0, 240.0, 200.0, 40);
        
        rfidTagNo.font = [UIFont boldSystemFontOfSize:20];
        rfidTagNo.frame = CGRectMake(460.0, 240.0, 200.0, 55);
        rfidTagNoValue.font = [UIFont boldSystemFontOfSize:20];
        rfidTagNoValue.frame = CGRectMake(700.0, 240.0, 200.0, 40);
        
        shipmentCost.font = [UIFont boldSystemFontOfSize:20];
        shipmentCost.frame = CGRectMake(10, 300.0, 200.0, 55);
        shipmentCostValue.font = [UIFont boldSystemFontOfSize:20];
        shipmentCostValue.frame = CGRectMake(250.0, 300.0, 200.0, 40);
        
        shipmentLocation.font = [UIFont boldSystemFontOfSize:20];
        shipmentLocation.frame = CGRectMake(460.0, 300.0, 200.0, 55);
        shipmentLocationValue.font = [UIFont boldSystemFontOfSize:20];
        shipmentLocationValue.frame = CGRectMake(700.0, 300.0, 200.0, 40);
        
        shipmentCity.font = [UIFont boldSystemFontOfSize:20];
        shipmentCity.frame = CGRectMake(10, 360.0, 200.0, 55);
        shipmentCityValue.font = [UIFont boldSystemFontOfSize:20];
        shipmentCityValue.frame = CGRectMake(250.0, 360.0, 200.0, 40);
        
        shipmentStreet.font = [UIFont boldSystemFontOfSize:20];
        shipmentStreet.frame = CGRectMake(460.0, 360.0, 200.0, 55);
        shipmentStreetValue.font = [UIFont boldSystemFontOfSize:20];
        shipmentStreetValue.frame = CGRectMake(700.0, 360.0, 200.0, 40);
        
        packagesDescription.font = [UIFont boldSystemFontOfSize:20];
        packagesDescription.frame = CGRectMake(10, 420.0, 200.0, 55);
        packagesDescriptionValue.font = [UIFont boldSystemFontOfSize:20];
        packagesDescriptionValue.frame = CGRectMake(250.0, 420.0, 200.0, 40);
        
        gatePassRef.font = [UIFont boldSystemFontOfSize:20];
        gatePassRef.frame = CGRectMake(460.0, 420.0, 200.0, 55);
        gatePassRefValue.font = [UIFont boldSystemFontOfSize:20];
        gatePassRefValue.frame = CGRectMake(700.0, 420.0, 200.0, 40);

        
        searchItem.frame = CGRectMake(10, 480, 400, 40);
        searchItem.font = [UIFont systemFontOfSize:20.0];
        
        searchBtton.frame = CGRectMake(420, 480, 110, 40);
        searchBtton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0f];
        searchBtton.layer.cornerRadius = 22.0f;
        
        label1.frame = CGRectMake(10, 530.0, 150, 40);
        label1.font = [UIFont boldSystemFontOfSize:20.0];
        
        label5.frame = CGRectMake(161, 530.0, 150, 40);
        label5.font = [UIFont boldSystemFontOfSize:20.0];
        
        label2.frame = CGRectMake(312, 530.0, 150, 40);
        label2.font = [UIFont boldSystemFontOfSize:20.0];
        
        label3.frame = CGRectMake(463, 530.0, 150, 40);
        label3.font = [UIFont boldSystemFontOfSize:20.0];
        
        label4.frame = CGRectMake(614, 530.0, 150, 40);
        label4.font = [UIFont boldSystemFontOfSize:20.0];
        
        serchOrderItemTable.frame = CGRectMake(10, 520, 400, 300);
        serchOrderItemTable.hidden = YES;
        orderItemsTable.frame = CGRectMake(10, 570, 820.0, 400);
        
        subTotal.frame = CGRectMake(10,950,300,50);
        subTotal.font = [UIFont boldSystemFontOfSize:25];
        
        tax.frame = CGRectMake(10,1010,300,50);
        tax.font = [UIFont boldSystemFontOfSize:25];
        
        totAmount.frame = CGRectMake(10,1070,300,50);
        totAmount.font = [UIFont boldSystemFontOfSize:25];
        
        
        subTotalData.frame = CGRectMake(500,950,200,50);
        subTotalData.font = [UIFont boldSystemFontOfSize:25];
        
        taxData.frame = CGRectMake(500,1010,300,50);
        taxData.font = [UIFont boldSystemFontOfSize:25];
        
        totAmountData.frame = CGRectMake(500,1070,300,50);
        totAmountData.font = [UIFont boldSystemFontOfSize:25];
        
        orderButton.frame = CGRectMake(30, 840, 350, 50);
        orderButton.layer.cornerRadius = 22.0f;
        orderButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        cancelButton.frame = CGRectMake(390, 840, 350, 50);
        cancelButton.layer.cornerRadius = 22.0f;
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
    }
    else {
        shipmentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        shipmentView.contentSize = CGSizeMake(self.view.frame.size.width + 250.0, 800.0);
        
        shipmentId.font = [UIFont boldSystemFontOfSize:15];
        shipmentId.frame = CGRectMake(5, 0.0, 150, 35);
        shipmentId.backgroundColor = [UIColor clearColor];
        shipmentIdValue.font = [UIFont boldSystemFontOfSize:15];
        shipmentIdValue.frame = CGRectMake(165, 0.0, 150, 35);
        
        orderId.font = [UIFont boldSystemFontOfSize:15];
        orderId.frame = CGRectMake(325, 0.0, 150, 35);
        orderId.backgroundColor = [UIColor clearColor];
        orderIdValue.font = [UIFont boldSystemFontOfSize:15];
        orderIdValue.frame = CGRectMake(450.0, 0.0, 150, 35);
        
        shipmentNote.font = [UIFont boldSystemFontOfSize:15];
        shipmentNote.frame = CGRectMake(5, 40, 150, 35);
        shipmentNote.backgroundColor = [UIColor clearColor];
        shipmentNoteValue.font = [UIFont boldSystemFontOfSize:15];
        shipmentNoteValue.frame = CGRectMake(165, 40, 150, 35);
        
        shipmentDate.font = [UIFont boldSystemFontOfSize:15];
        shipmentDate.frame = CGRectMake(325, 40, 150, 35);
        shipmentDate.backgroundColor = [UIColor clearColor];
        shipmentDateValue.font = [UIFont boldSystemFontOfSize:15];
        shipmentDateValue.frame = CGRectMake(450, 40, 150, 35);
        
        shipmentMode.font = [UIFont boldSystemFontOfSize:15];
        shipmentMode.frame = CGRectMake(5, 80, 150, 35);
        shipmentMode.backgroundColor = [UIColor clearColor];
        shipmentModeValue.font = [UIFont boldSystemFontOfSize:15];
        shipmentModeValue.frame = CGRectMake(165, 80, 150, 35);
        
        shipmentAgency.font = [UIFont boldSystemFontOfSize:15];
        shipmentAgency.frame = CGRectMake(325, 80, 150, 35);
        shipmentAgency.backgroundColor = [UIColor clearColor];
        shipmentAgencyValue.font = [UIFont boldSystemFontOfSize:15];
        shipmentAgencyValue.frame = CGRectMake(450, 80, 150, 35);
        
        shipmentAgencyContact.font = [UIFont boldSystemFontOfSize:15];
        shipmentAgencyContact.frame = CGRectMake(5, 120, 150, 35);
        shipmentAgencyContact.backgroundColor = [UIColor clearColor];
        shipmentAgencyContactValue.font = [UIFont boldSystemFontOfSize:15];
        shipmentAgencyContactValue.frame = CGRectMake(165, 120, 150, 35);
        
        inspectedBy.font = [UIFont boldSystemFontOfSize:15];
        inspectedBy.frame = CGRectMake(325, 120, 150, 35);
        inspectedBy.backgroundColor = [UIColor clearColor];
        inspectedByValue.font = [UIFont boldSystemFontOfSize:15];
        inspectedByValue.frame = CGRectMake(450, 120, 150, 35);
        
        shippedBy.font = [UIFont boldSystemFontOfSize:15];
        shippedBy.frame = CGRectMake(5, 160, 150, 35);
        shippedBy.backgroundColor = [UIColor clearColor];
        shippedByValue.font = [UIFont boldSystemFontOfSize:15];
        shippedByValue.frame = CGRectMake(165, 160, 150, 35);
        
        rfidTagNo.font = [UIFont boldSystemFontOfSize:15];
        rfidTagNo.frame = CGRectMake(325, 160, 150, 35);
        rfidTagNo.backgroundColor = [UIColor clearColor];
        rfidTagNoValue.font = [UIFont boldSystemFontOfSize:15];
        rfidTagNoValue.frame = CGRectMake(450, 160, 150, 35);
        
        shipmentCost.font = [UIFont boldSystemFontOfSize:15];
        shipmentCost.frame = CGRectMake(5, 200, 150, 35);
        shipmentCost.backgroundColor = [UIColor clearColor];
        shipmentCostValue.font = [UIFont boldSystemFontOfSize:15];
        shipmentCostValue.frame = CGRectMake(165, 200, 150, 35);
        
        shipmentLocation.font = [UIFont boldSystemFontOfSize:15];
        shipmentLocation.frame = CGRectMake(325, 200, 150, 35);
        shipmentLocation.backgroundColor = [UIColor clearColor];
        shipmentLocationValue.font = [UIFont boldSystemFontOfSize:15];
        shipmentLocationValue.frame = CGRectMake(450, 200, 150, 35);
        
        shipmentCity.font = [UIFont boldSystemFontOfSize:15];
        shipmentCity.frame = CGRectMake(5, 240, 150, 35);
        shipmentCity.backgroundColor = [UIColor clearColor];
        shipmentCityValue.font = [UIFont boldSystemFontOfSize:15];
        shipmentCityValue.frame = CGRectMake(165, 240, 150, 35);
        
        shipmentStreet.font = [UIFont boldSystemFontOfSize:15];
        shipmentStreet.frame = CGRectMake(325, 240, 150, 35);
        shipmentStreet.backgroundColor = [UIColor clearColor];
        shipmentStreetValue.font = [UIFont boldSystemFontOfSize:15];
        shipmentStreetValue.frame = CGRectMake(450, 240, 150, 35);
        
        packagesDescription.font = [UIFont boldSystemFontOfSize:15];
        packagesDescription.frame = CGRectMake(5, 280, 150, 35);
        packagesDescription.backgroundColor = [UIColor clearColor];
        packagesDescriptionValue.font = [UIFont boldSystemFontOfSize:15];
        packagesDescriptionValue.frame = CGRectMake(165, 280, 150, 35);
        
        gatePassRef.font = [UIFont boldSystemFontOfSize:15];
        gatePassRef.frame = CGRectMake(325, 280, 150, 35);
        gatePassRef.backgroundColor = [UIColor clearColor];
        gatePassRefValue.font = [UIFont boldSystemFontOfSize:15];
        gatePassRefValue.frame = CGRectMake(450, 280, 150, 35);

        
        searchItem.frame = CGRectMake(5, 320, 220, 30);
        searchItem.font = [UIFont systemFontOfSize:15];
        
        searchBtton.frame = CGRectMake(235, 320, 80, 35);
        searchBtton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        searchBtton.layer.cornerRadius = 18.0f;
        
        
        label1.frame = CGRectMake(0, 360.0, 60, 25);
        label1.font = [UIFont boldSystemFontOfSize:17];
        
        label5.frame = CGRectMake(61, 360.0, 60, 25);
        label5.font = [UIFont boldSystemFontOfSize:17];
        
        label2.frame = CGRectMake(122, 360.0, 60, 25);
        label2.font = [UIFont boldSystemFontOfSize:17];
        
        label3.frame = CGRectMake(183, 360.0, 60, 25);
        label3.font = [UIFont boldSystemFontOfSize:17];
        
        label4.frame = CGRectMake(244, 360.0, 60, 25);
        label4.font = [UIFont boldSystemFontOfSize:17];
        
        serchOrderItemTable.frame = CGRectMake(10, 360.0, 220, 200);
        serchOrderItemTable.hidden = YES;
        
        
        orderItemsTable.frame = CGRectMake(10, 390, 550, 250);
        
        subTotal.frame = CGRectMake(5,650,150,30);
        subTotal.font = [UIFont boldSystemFontOfSize:17];
        
        tax.frame = CGRectMake(10,690,150,30);
        tax.font = [UIFont boldSystemFontOfSize:17];
        
        totAmount.frame = CGRectMake(10,730,180,30);
        totAmount.font = [UIFont boldSystemFontOfSize:17];
        
        subTotalData.frame = CGRectMake(250,650,150,30);
        subTotalData.font = [UIFont boldSystemFontOfSize:17];
        
        taxData.frame = CGRectMake(250,690,150,30);
        taxData.font = [UIFont boldSystemFontOfSize:17];
        
        totAmountData.frame = CGRectMake(250,730,180,30);
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
    [shipmentView addSubview:shipmentNote];
    [shipmentView addSubview:shipmentNoteValue];
    [shipmentView addSubview:shipmentDate];
    [shipmentView addSubview:shipmentDateValue];
    [shipmentView addSubview:shipmentMode];
    [shipmentView addSubview:shipmentModeValue];
    [shipmentView addSubview:shipoModeButton];
    [shipmentView addSubview:shipmentAgency];
    [shipmentView addSubview:shipmentAgencyValue];
    [shipmentView addSubview:shipmentAgencyContact];
    [shipmentView addSubview:shipmentAgencyContactValue];
    [shipmentView addSubview:inspectedBy];
    [shipmentView addSubview:inspectedByValue];
    [shipmentView addSubview:shippedBy];
    [shipmentView addSubview:shippedByValue];
    [shipmentView addSubview:rfidTagNo];
    [shipmentView addSubview:rfidTagNoValue];
    [shipmentView addSubview:shipmentCost];
    [shipmentView addSubview:shipmentCostValue];
    [shipmentView addSubview:shipmentLocation];
    [shipmentView addSubview:shipmentLocationValue];
    [shipmentView addSubview:shipmentCity];
    [shipmentView addSubview:shipmentCityValue];
    [shipmentView addSubview:shipmentStreet];
    [shipmentView addSubview:shipmentStreetValue];
    [shipmentView addSubview:packagesDescription];
    [shipmentView addSubview:packagesDescriptionValue];
    [shipmentView addSubview:gatePassRef];
    [shipmentView addSubview:gatePassRefValue];
    [shipmentView addSubview:searchItem];
    [shipmentView addSubview:searchBtton];
    [shipmentView addSubview:label1];
    [shipmentView addSubview:label2];
    [shipmentView addSubview:label3];
    [shipmentView addSubview:label4];
    [shipmentView addSubview:label5];
    [shipmentView addSubview:serchOrderItemTable];
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

    [self getShipmentIDDetails];
}

-(void)getShipmentIDDetails{
    
    WHShippingServicesSoapBinding *service = [[WHShippingServicesSvc WHShippingServicesSoapBinding] retain];
    WHShippingServicesSvc_getShipmentDetails *aparams = [[WHShippingServicesSvc_getShipmentDetails alloc] init];
    NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str_ = [time_ componentsSeparatedByString:@" "];
    NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"shipmentId",@"requestHeader", nil];
    
    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",wareEditShipmentID],dictionary, nil];
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
                inspectedByValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"inspectedBy"]];
                subTotalData.text = [NSString stringWithFormat:@"%.02f",[[json objectForKey:@"totalCost"] floatValue]];
                orderIdValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"orderId"]];
                totAmountData.text = [NSString stringWithFormat:@"%.02f",[[json objectForKey:@"totalCost"] floatValue]];
                taxData.text = [NSString stringWithFormat:@"%.02f",[[json objectForKey:@"tax"] floatValue]];
                shipmentLocationValue.text =[NSString stringWithFormat:@"%@",[json objectForKey:@"shipmentLocation"]];
                shipmentStreetValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"shipmentStreet"]];
                shipmentAgencyContactValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"shipmentAgencyContact"]];
                shipmentNoteValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"shipmentNote"]];
                rfidTagNoValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"rfidTagNo"]];
                shipmentCityValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"shipmentCity"]];
                shipmentDateValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"shipmentDate"]];
                shipmentIdValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"shipmentId"]];
                shipmentCostValue.text = [NSString stringWithFormat:@"%.02f",[[json objectForKey:@"shipmentCost"] floatValue]];
                packagesDescriptionValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"packagesDescription"]];
                gatePassRefValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"gatePassRef"]];
                shipmentModeValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"shipmentMode"]];
                orderIdValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"orderId"]];
                shippedByValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"shippedBy"]];
                shipmentAgencyValue.text  = [NSString stringWithFormat:@"%@",[json objectForKey:@"shipmentAgency"]];
                
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
    
    NSString *value = [searchItem.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([value length] == 0){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Order Item" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        searchItem.text = nil;
        
    }
    else{
        
        seardhOrderItem = searchItem.text;
        // Create the service
        //        SDZSkuService* service = [SDZSkuService service];
        //        service.logging = YES;
        //
        //        // Returns NSString*.
        //        [service searchProduct:self action:@selector(searchProductHandler:) searchCriteria: seardhOrderItem];
        
        SkuServiceSoapBinding *service = [[SkuServiceSvc SkuServiceSoapBinding] retain];
        SkuServiceSvc_searchProduct *aparams = [[SkuServiceSvc_searchProduct alloc] init];
        NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        NSArray *str = [time_ componentsSeparatedByString:@" "];
        NSString *date = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
        
        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date, nil];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
        
        NSArray *keys = [NSArray arrayWithObjects:@"searchCriteria",@"requestHeader", nil];
        NSArray *objects = [NSArray arrayWithObjects:seardhOrderItem,dictionary_, nil];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        aparams.searchCriteria = salesReportJsonString;
        
        SkuServiceSoapBindingResponse *response = [service searchProductUsingParameters:(SkuServiceSvc_searchProduct *)aparams];
        
        NSArray *responseBodyParts =  response.bodyParts;
        
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[SkuServiceSvc_searchProductResponse class]]) {
                SkuServiceSvc_searchProductResponse *body = (SkuServiceSvc_searchProductResponse *)bodyPart;
                //printf("\nresponse=%s",body.return_);
                [self searchProductHandler:body.return_];
            }
        }
    }
}
// Handle the response from searchProduct.
- (void) searchProductHandler: (NSString *) value {
    
    // Handle errors
    if([value isKindOfClass:[NSError class]]) {
        NSLog(@"%@", value);
        return;
    }
    
    // Handle faults
    //	if([value isKindOfClass:[SoapFault class]]) {
    //		NSLog(@"%@", value);
    //		return;
    //	}
    
    
    // Do something with the NSString* result
    NSString* result = (NSString*)value;
    
    NSLog(@"%@",result);
    
    if ([result length] >= 1) {
        
        NSError *e;
        
        NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [result dataUsingEncoding:NSUTF8StringEncoding]
                                                              options: NSJSONReadingMutableContainers
                                                                error: &e];
        
        NSArray *tempItems = [JSON1 objectForKey:@"skuIds"];
        
        // serchOrderItemArray initialization...
        serchOrderItemArray = [[NSMutableArray alloc] init];
        
        for (int i=0; i<[tempItems count]; i++) {
            
            [serchOrderItemArray addObject:[tempItems objectAtIndex:i]];
        }
        
        shipmentView.scrollEnabled = NO;
        
        searchItem.enabled = NO;
        searchBtton.enabled = NO;
        //timeButton.enabled = NO;
        orderItemsTable.userInteractionEnabled = FALSE;
        
        serchOrderItemTable.hidden = NO;
        [self.view bringSubviewToFront:serchOrderItemTable];
        
        [serchOrderItemTable reloadData];
        
    }
    else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"No Order Items found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        searchItem.text = nil;
    }
}

-(IBAction) shipoModeButtonPressed:(id) sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    shipmentView.scrollEnabled = NO;
    orderButton.enabled = NO;
    cancelButton.enabled = NO;
    
    shipmodeList = [[NSMutableArray alloc] init];
    [shipmodeList addObject:@"Rail"];
    [shipmodeList addObject:@"Flight"];
    [shipmodeList addObject:@"Express"];
    [shipmodeList addObject:@"Ordinary"];
    
    shipModeTable.hidden = NO;
    [self.view bringSubviewToFront:shipModeTable];
    [shipModeTable reloadData];
    
}


/** Table started.... */

#pragma mark Table view methods

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == serchOrderItemTable){
        
        return [serchOrderItemArray count];
    }
    else if(tableView == orderItemsTable){
        
        return [ItemArray count];
    }
    else if (tableView == shipModeTable) {
        return [shipmodeList count];
    }
    else{
        return 0;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tableView == shipModeTable){
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            UIView* headerView = [[[UIView alloc] initWithFrame: CGRectMake(0.0, 0.0, 320.0, 69.0)] autorelease];
            headerView.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
            
            UILabel *label1 = [[[UILabel alloc] initWithFrame:CGRectMake(8, 3, 255, 30)] autorelease];
            label1.font = [UIFont boldSystemFontOfSize:22.0];
            label1.backgroundColor = [UIColor clearColor];
            label1.text = @"Select The ShipMode";
            label1.textColor = [UIColor whiteColor];
            [headerView addSubview:label1];
            
            UIButton *closeBtn = [[[UIButton alloc] init] autorelease];
            [closeBtn addTarget:self action:@selector(serchOrderItemTableCancel:) forControlEvents:UIControlEventTouchUpInside];
            closeBtn.frame = CGRectMake(300, 4, 30, 30);
            UIImage *image = [UIImage imageNamed:@"go-back-icon.png"];
            [closeBtn setBackgroundImage:image	forState:UIControlStateNormal];
            [headerView addSubview:closeBtn];
            
            return headerView;
        }
        else{
            
            UIView* headerView = [[[UIView alloc] initWithFrame: CGRectMake(0.0, 0.0, 320.0, 69.0)] autorelease];
            headerView.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
            
            UILabel *label1 = [[[UILabel alloc] initWithFrame:CGRectMake(8, 3, 175, 30)] autorelease];
            label1.font = [UIFont boldSystemFontOfSize:17.0];
            label1.backgroundColor = [UIColor clearColor];
            label1.text = @"Select The ShipMode";
            label1.textColor = [UIColor whiteColor];
            [headerView addSubview:label1];
            
            UIButton *closeBtn = [[[UIButton alloc] init] autorelease];
            [closeBtn addTarget:self action:@selector(serchOrderItemTableCancel:) forControlEvents:UIControlEventTouchUpInside];
            closeBtn.frame = CGRectMake(185, 4, 28, 28);
            UIImage *image = [UIImage imageNamed:@"go-back-icon.png"];
            [closeBtn setBackgroundImage:image	forState:UIControlStateNormal];
            [headerView addSubview:closeBtn];
            
            return headerView;
            
        }
        
    }

   else if (tableView == serchOrderItemTable) {
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            UIView* headerView = [[[UIView alloc] initWithFrame: CGRectMake(0.0, 0.0, 320.0, 69.0)] autorelease];
            headerView.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
            
            UILabel *label1 = [[[UILabel alloc] initWithFrame:CGRectMake(25, 3, 400, 30)] autorelease];
            label1.font = [UIFont boldSystemFontOfSize:25.0];
            
            label1.backgroundColor = [UIColor clearColor];
            label1.text = @"Select OrderItem";
            label1.textColor = [UIColor whiteColor];
            [headerView addSubview:label1];
            
            UIButton *closeBtn = [[[UIButton alloc] init] autorelease];
            [closeBtn addTarget:self action:@selector(serchOrderItemTableCancel:) forControlEvents:UIControlEventTouchUpInside];
            closeBtn.frame = CGRectMake(350, 4, 30, 30);
            UIImage *image = [UIImage imageNamed:@"go-back-icon.png"];
            [closeBtn setBackgroundImage:image	forState:UIControlStateNormal];
            [headerView addSubview:closeBtn];
            
            return headerView;
        }
        else{
            
            
            UIView* headerView = [[[UIView alloc] initWithFrame: CGRectMake(0.0, 0.0, 320.0, 69.0)] autorelease];
            headerView.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
            
            UILabel *label1 = [[[UILabel alloc] initWithFrame:CGRectMake(25, 3, 150, 30)] autorelease];
            label1.font = [UIFont boldSystemFontOfSize:17.0];
            
            label1.backgroundColor = [UIColor clearColor];
            label1.text = @"Select OrderItem";
            label1.textColor = [UIColor whiteColor];
            [headerView addSubview:label1];
            
            UIButton *closeBtn = [[[UIButton alloc] init] autorelease];
            [closeBtn addTarget:self action:@selector(serchOrderItemTableCancel:) forControlEvents:UIControlEventTouchUpInside];
            closeBtn.frame = CGRectMake(185, 4, 28, 28);
            UIImage *image = [UIImage imageNamed:@"go-back-icon.png"];
            [closeBtn setBackgroundImage:image	forState:UIControlStateNormal];
            [headerView addSubview:closeBtn];
            
            return headerView;
        }
        
    }
    else{
        return NO;
    }
}
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
    if (tableView == shipModeTable){
        
        cell.textLabel.text = [shipmodeList objectAtIndex:indexPath.row];
    }
    else if(tableView == serchOrderItemTable){
        
        NSDictionary *json = [serchOrderItemArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"skuId"]];
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
    if (tableView == shipModeTable) {
        shipmentView.scrollEnabled = YES;
        orderButton.enabled = YES;
        cancelButton.enabled = YES;
        shipmentModeValue.text = [shipmodeList objectAtIndex:indexPath.row];
        shipModeTable.hidden = YES;
    }
    else if(tableView == serchOrderItemTable){
        
        searchItem.text = @"";
        serchOrderItemTable.hidden = YES;
        NSDictionary *json = [serchOrderItemArray objectAtIndex:indexPath.row];
        // Create the service
        //        SDZSkuService* service = [SDZSkuService service];
        //        service.logging = YES;
        //
        //        // Returns NSString*.
        //        [service getSkuIDForGivenProductName:self action:@selector(getSkuIDForGivenProductNameHandler:) productName: [serchOrderItemArray objectAtIndex:indexPath.row]];
        SkuServiceSoapBinding *service = [[SkuServiceSvc SkuServiceSoapBinding] retain];
        SkuServiceSvc_getSkuIDForGivenProductName *aparams = [[SkuServiceSvc_getSkuIDForGivenProductName alloc] init];
        NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        NSArray *str = [time_ componentsSeparatedByString:@" "];
        NSString *date = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
        
        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date, nil];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
        
        NSArray *keys = [NSArray arrayWithObjects:@"product",@"requestHeader", nil];
        NSArray *objects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",[json objectForKey:@"skuId"]],dictionary_, nil];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        aparams.productName = salesReportJsonString;
        
        SkuServiceSoapBindingResponse *response = [service getSkuIDForGivenProductNameUsingParameters:(SkuServiceSvc_getSkuIDForGivenProductName *)aparams];
        
        NSArray *responseBodyParts =  response.bodyParts;
        
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[SkuServiceSvc_getSkuIDForGivenProductNameResponse class]]) {
                SkuServiceSvc_getSkuIDForGivenProductNameResponse *body = (SkuServiceSvc_getSkuIDForGivenProductNameResponse *)bodyPart;
                //printf("\nresponse=%s",body.return_);
                [self getSkuIDForGivenProductNameHandler:body.return_];
            }
        }
    }
}

- (void) getSkuIDForGivenProductNameHandler: (id) value {
    
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
    
    NSLog(@" %@",result);
    
    if([result length] >= 1) {
        
        NSError *e;
        
        NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [result dataUsingEncoding:NSUTF8StringEncoding]
                                                              options: NSJSONReadingMutableContainers
                                                                error: &e];
        
        NSArray *temp = [JSON1 objectForKey:@"skuIds"];
        if ([temp count] > 0) {
            NSDictionary *json =  [temp objectAtIndex:0];
            result = [NSString stringWithFormat:@"%@",[json objectForKey:@"skuId"]];
            
            if ([skuIdArray count] == 0) {
                [skuIdArray addObject:result];
            }
            else{
                
                for (int i=0; i<=[skuIdArray count]-1; i++) {
                    NSString *str1  = [skuIdArray objectAtIndex:i];
                    if ([str1 isEqualToString:result]) {
                        wareEditShipNewItem__ = NO;
                    }
                }
                if (wareEditShipNewItem__ == YES) {
                    
                    [skuIdArray addObject:result];
                }
                else{
                    
                    wareEditShipNewItem__ = YES;
                }
            }
            
            // Create the service
            //            SDZSkuService* service = [SDZSkuService service];
            //            service.logging = YES;
            //
            //            // Returns NSString*.
            //            [service getSkuDetails:self action:@selector(getSkuDetailsHandler:) skuID: result];
            
            SkuServiceSoapBinding *service = [[SkuServiceSvc SkuServiceSoapBinding] retain];
            SkuServiceSvc_getSkuDetails *aparams = [[SkuServiceSvc_getSkuDetails alloc] init];
            NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
            NSArray *str = [time_ componentsSeparatedByString:@" "];
            NSString *date = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
            NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
            
            NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date, nil];
            NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
            
            NSArray *keys = [NSArray arrayWithObjects:@"skuId",@"requestHeader", nil];
            NSArray *objects = [NSArray arrayWithObjects:result,dictionary_, nil];
            
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            
            NSError * err;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
            NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            aparams.skuID = salesReportJsonString;
            
            SkuServiceSoapBindingResponse *response = [service getSkuDetailsUsingParameters:(SkuServiceSvc_getSkuDetails *)aparams];
            
            NSArray *responseBodyParts =  response.bodyParts;
            
            for (id bodyPart in responseBodyParts) {
                if ([bodyPart isKindOfClass:[SkuServiceSvc_getSkuDetailsResponse class]]) {
                    SkuServiceSvc_getSkuDetailsResponse *body = (SkuServiceSvc_getSkuDetailsResponse *)bodyPart;
                    //printf("\nresponse=%s",body.return_);
                    [self getSkuDetailsHandler:body.return_];
                }
            }
            
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Failed to get Details" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
    }
    else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Product Not found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        searchItem.text = nil;
    }
}


// Handle the response from getSkuDetails.
- (void) getSkuDetailsHandler: (NSString *) value {
    
    // Handle errors
    if([value isKindOfClass:[NSError class]]) {
        NSLog(@"%@", value);
        return;
    }
    
    // Handle faults
    //	if([value isKindOfClass:[SoapFault class]]) {
    //		NSLog(@"%@", value);
    //		return;
    //	}
    
    
    // Do something with the NSString* result
    NSString* result = (NSString*)value;
    NSError *e;
    
    NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [result dataUsingEncoding:NSUTF8StringEncoding]
                                                          options: NSJSONReadingMutableContainers
                                                            error: &e];
    NSDictionary *JSON2 = [JSON1 objectForKey:@"responseHeader"];
    
    if ([[JSON2 objectForKey:@"responseMessage"] isEqualToString:@"SUCCESS"] && [[JSON2 objectForKey:@"responseCode"] isEqualToString:@"0"]) {
        
        NSString *itemStr = [JSON1 objectForKey:@"productName"];
        //        NSArray *tempItems = [result componentsSeparatedByString:@"#"];
        
        if ([ItemArray count] == 0) {
            
            //            for (int i=0; i<[tempItems count]/4; i++) {
            
            [ItemArray addObject:[JSON1 objectForKey:@"productName"]];
            [ItemDiscArray addObject:[JSON1 objectForKey:@"description"]];
            [totalQtyArray addObject:[JSON1 objectForKey:@"quantity"]];
            [priceArray addObject:[JSON1 objectForKey:@"price"]];
            [QtyArray addObject:@"1"];
            [totalArray addObject:[NSString stringWithFormat:@"%.02f", [[JSON1 objectForKey:@"price"] floatValue]*[[QtyArray objectAtIndex:0] intValue]]];
            //            }
        }
        else
        {
            for (int i=0; i<=[ItemArray count]-1; i++) {
                
                //NSString *str1  = [tempItems objectAtIndex:0];
                NSString *str2  = [ItemArray objectAtIndex:i];
                
                if ([str2 isEqualToString:itemStr]) {
                    wareEditShipNewItem__ = NO;
                    
                }
            }
            
            if (wareEditShipNewItem__ == YES) {
                
                //                for (int i=0; i<[tempItems count]/4; i++) {
                
                [ItemArray addObject:[JSON1 objectForKey:@"productName"]];
                [ItemDiscArray addObject:[JSON1 objectForKey:@"description"]];
                [totalQtyArray addObject:[JSON1 objectForKey:@"quantity"]];
                [priceArray addObject:[JSON1 objectForKey:@"price"]];
                [QtyArray addObject:@"1"];
                [totalArray addObject:[NSString stringWithFormat:@"%.02f", [[JSON1 objectForKey:@"price"] floatValue]*[[QtyArray objectAtIndex:0] intValue]]];
                //                }
            }
            else{
                
                for (int i=0; i<=[ItemArray count]-1; i++) {
                    
                    //                       NSString *str1  = [tempItems objectAtIndex:0];
                    NSString *str2  = [ItemArray objectAtIndex:i];
                    
                    if ([str2 isEqualToString:itemStr]) {
                        
                        NSLog(@"%@",[QtyArray objectAtIndex:i]);
                        
                        NSLog(@" %d",[[QtyArray objectAtIndex:i] intValue] + 1);
                        
                        if ([[QtyArray objectAtIndex:i] intValue] + 1 > [[totalQtyArray objectAtIndex:i] intValue]) {
                            
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Quantity Should be Less than or Equal to  Availble Quantity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                            [alert show];
                            [alert release];
                            
                            qtyFeild.text = nil;
                        }
                        else{
                            
                            [QtyArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",[[QtyArray objectAtIndex:i] intValue] + 1]];
                            
                            wareEditShipNewItem__ = YES;
                            [self displayOrdersData];
                        }
                    }
                }
            }
        }
        
        
        
        totalAmount = 0.0;
        
        for (int i=0; i<[totalArray count]; i++) {
            totalAmount = totalAmount + [[totalArray objectAtIndex:i] intValue];
        }
        
        subTotalData.text = [NSString stringWithFormat:@"%d%@", totalAmount,@".0"];
        taxData.text = [NSString stringWithFormat:@"%.2lf", totalAmount/8.25f];
        totAmountData.text = [NSString stringWithFormat:@"%.2lf", totalAmount+(totalAmount/8.25f)];
        
        orderItemsTable.hidden = NO;
        //[self.view bringSubviewToFront:orderItemsTable];
        [orderItemsTable reloadData];
        shipmentView.scrollEnabled = YES;
        orderItemsTable.userInteractionEnabled = TRUE;
        searchItem.userInteractionEnabled = TRUE;
        searchItem.enabled = YES;
//        searchBtton.enabled = YES;
        searchBtton.userInteractionEnabled = TRUE;
    }
    else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Failed to get Details" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
}

//DisplayOrdersData handler
-(void)displayOrdersData{
    
    totalAmount = 0.0;
    
    shipmentView.scrollEnabled = YES;
    orderItemsTable.userInteractionEnabled = TRUE;
    
    for (int i=0; i<[ItemArray count]; i++) {
        
        [totalArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d", [[priceArray objectAtIndex:i] intValue]*[[QtyArray objectAtIndex:i] intValue]]];
        // qtyChangeDisplyView.hidden = YES;
        
        totalAmount = totalAmount + [[totalArray objectAtIndex:i] intValue];
        [orderItemsTable reloadData];
    }
    
    subTotalData.text = [NSString stringWithFormat:@"%d%@", totalAmount,@".0"];
    taxData.text = [NSString stringWithFormat:@"%.2lf", totalAmount/8.25f];
    totAmountData.text = [NSString stringWithFormat:@"%.2lf", totalAmount+(totalAmount/8.25f)];
}

// qtyChangeClick handler...
- (IBAction)qtyChangePressed:(id)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    shipmentView.scrollEnabled = NO;
    //    orderButton.enabled = NO;
    //    cancelButton.enabled = NO;
    //    //timeButton.enabled = NO;
    //    paymentModeButton.enabled= NO;
    //    customerCode.enabled = NO;
    //    customerName.enabled = NO;
    //    searchItem.enabled = NO;
    //    searchBtton.enabled = NO;
    //    address.enabled =NO;
    //    phNo.enabled = NO;
    //    email.enabled = NO;
    //    dueDate.enabled = NO;
    //    dueDateButton.enabled = NO;
    //    time.enabled = NO;
    //    shipCharges.enabled = NO;
    //    //timeButton.enabled = NO;
    //    shipoMode.enabled = NO;
    //    shipoModeButton =NO;
    //    paymentMode.enabled = NO;
    //    paymentModeButton.enabled = NO;
    orderItemsTable.userInteractionEnabled = FALSE;
    
    qtyOrderPosition = [sender tag];
    
    qtyChangeDisplyView = [[[UIView alloc]init] autorelease];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        qtyChangeDisplyView.frame = CGRectMake(200, 300, 375, 300);
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
    
    
    // a label on top of the view ..
    UILabel *topbar = [[[UILabel alloc] init] autorelease];
    topbar.backgroundColor = [UIColor grayColor];
    topbar.text = @"    Enter Quantity";
    topbar.backgroundColor = [UIColor blackColor];
    [topbar setTextAlignment:NSTextAlignmentCenter];
    topbar.textColor = [UIColor whiteColor];
    topbar.textAlignment = NSTextAlignmentLeft;
    
    
    
    UILabel *availQty = [[[UILabel alloc] init] autorelease];
    availQty.text = @"Available Qty :";
    availQty.backgroundColor = [UIColor clearColor];
    availQty.textColor = [UIColor blackColor];
    
    
    UILabel *unitPrice = [[[UILabel alloc] init] autorelease];
    unitPrice.text = @"Unit Price       :";
    unitPrice.backgroundColor = [UIColor clearColor];
    unitPrice.textColor = [UIColor blackColor];
    
    
    
    UILabel *availQtyData = [[[UILabel alloc] init] autorelease];
    availQtyData.text = [totalQtyArray objectAtIndex:[sender tag]];
    availQtyData.backgroundColor = [UIColor clearColor];
    availQtyData.textColor = [UIColor blackColor];
    
    
    UILabel *unitPriceData = [[[UILabel alloc] init] autorelease];
    unitPriceData.text = [priceArray objectAtIndex:[sender tag]];
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
    
    int qty = [str intValue];
    
    if (qty >= [[totalQtyArray objectAtIndex:qtyOrderPosition] intValue]+1 ){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Quantity Should be Less than or Equal to  Availble Quantity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        qtyFeild.text = nil;
        qtyChangeDisplyView.hidden = NO;
        
    }
    else if([value isEqualToString:@"0"] || !isNumber){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Quantity." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        qtyFeild.text = NO;
    }
    //    else if(!isNumber){
    //
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Quantity." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //        [alert show];
    //        [alert release];
    //    }
    else{
        [QtyArray replaceObjectAtIndex:qtyOrderPosition withObject:qtyFeild.text];
        //[qtyChangeDisplyView removeFromSuperview];
        qtyChangeDisplyView.hidden = YES;
        
        
        
        [self displayOrdersData];
    }
    
    
    shipmentView.scrollEnabled = YES;
    //    orderButton.enabled = YES;
    //    cancelButton.enabled = YES;
    //    //timeButton.enabled = YES;
    //    paymentModeButton.enabled= YES;
    //    customerCode.enabled = YES;
    //    customerName.enabled = YES;
    //    searchItem.enabled = YES;
    //    searchBtton.enabled = YES;
    //    address.enabled = YES;
    //    phNo.enabled = YES;
    //    email.enabled = YES;
    //    dueDate.enabled = YES;
    //    dueDateButton.enabled = YES;
    //    time.enabled = YES;
    //    shipCharges.enabled = YES;
    //    //timeButton.enabled = YES;
    //    shipoMode.enabled = YES;
    //    shipoModeButton.enabled = YES;
    //    paymentMode.enabled = YES;
    //    paymentModeButton.enabled = YES;
    orderItemsTable.userInteractionEnabled = TRUE;
}





// cancelButtonPressed handler quantity changed view cancel..
- (IBAction)QtyCancelButtonPressed:(id)sender {
    
    AudioServicesPlaySystemSound (soundFileObject);
    qtyChangeDisplyView.hidden = YES;
    
    shipmentView.scrollEnabled = YES;
    //    orderButton.enabled = YES;
    //    cancelButton.enabled = YES;
    //    // timeButton.enabled = YES;
    //    paymentModeButton.enabled= YES;
    //    customerCode.enabled = YES;
    //    customerName.enabled = YES;
    //    searchItem.enabled = YES;
    //    searchBtton.enabled = YES;
    //    address.enabled =YES;
    //    phNo.enabled = YES;
    //    email.enabled = YES;
    //    dueDate.enabled = YES;
    //    dueDateButton.enabled = YES;
    //    time.enabled = YES;
    //    shipCharges.enabled = YES;
    //    // timeButton.enabled = YES;
    //    shipoMode.enabled = YES;
    //    shipoModeButton.enabled =YES;
    //    paymentMode.enabled = YES;
    //    paymentModeButton.enabled = YES;
    orderItemsTable.userInteractionEnabled = TRUE;
}

- (void) orderButtonPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    NSString *shipmentIdValue_ = [shipmentIdValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *lshipmentNoteValue_ = [shipmentNoteValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipmentDateValue_ = [shipmentDateValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipmentModeValue_ = [shipmentModeValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipmentAgencyValue_ = [shipmentAgencyValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipmentAgencyContactValue_ = [shipmentAgencyContactValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *inspectedByValue_ = [inspectedByValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shippedByValue_ = [shippedByValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipmentCostValue_ = [shipmentCostValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipmentLocationValue_ = [shipmentLocationValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipmentCityValue_ = [shipmentCityValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipmentStreetValue_ = [shipmentStreetValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *packagesDescriptionValue_ = [packagesDescriptionValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *rfidTagNoValue_ = [rfidTagNoValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *gatePassRefValue_ = [gatePassRefValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([skuIdArray count] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Add Items to Cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else if ([shipmentIdValue_ length] == 0 || [lshipmentNoteValue_ length] == 0 || [shipmentDateValue_ length] == 0 || [shipmentModeValue_ length] == 0 || [shipmentAgencyValue_ length] == 0 || [shipmentAgencyContactValue_ length] == 0 || [inspectedByValue_ length] == 0 || [shippedByValue_ length] == 0 || [rfidTagNoValue_ length] == 0 || [shipmentCostValue_ length] == 0 || [shipmentLocationValue_ length] == 0 || [shipmentCityValue_ length] == 0 || [shipmentStreetValue_ length] == 0 || [packagesDescriptionValue_ length] == 0 || [gatePassRefValue_ length] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Fields couldn't be empty" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else{
        HUD.labelText = @"Updating Shipment..";
        [HUD setHidden:NO];
        
        
        //        SDZOrderService* service = [SDZOrderService service];
        //        service.logging = YES;
        //
        //        // Returns BOOL.
        //         [service createOrder:self action:@selector(createOrderHandler:) userID:user_name orderDateTime: dateString deliveryDate: dueDate.text deliveryTime: time.text ordererEmail: email.text ordererMobile:phNo.text ordererAddress: address.text orderTotalPrice: totAmountData.text shipmentCharge: shipCharges.text shipmentMode:shipoMode.text paymentMode: paymentMode.text orderItems: str];
        
        NSMutableArray *items = [[NSMutableArray alloc] init];
        int totalQuantity = 0;
        for (int i = 0; i < [ItemArray count]; i++) {
            NSArray *keys = [NSArray arrayWithObjects:@"itemId", @"itemDescription",@"color",@"size",@"unitOfMeasurement",@"price",@"quantity",@"total", nil];
            NSArray *objects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",[skuIdArray objectAtIndex:i]],[NSString stringWithFormat:@"%@",[ItemArray objectAtIndex:i]],@"blue",@"35",@"NA",[NSString stringWithFormat:@"%@",[priceArray objectAtIndex:i]],[NSString stringWithFormat:@"%@",[QtyArray objectAtIndex:i]],[NSString stringWithFormat:@"%@",[totalArray objectAtIndex:i]], nil];
            NSDictionary *itemsDic = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            totalQuantity = totalQuantity + [[QtyArray objectAtIndex:i] intValue];
            [items addObject:itemsDic];
        }
        WHShippingServicesSoapBinding *service = [[WHShippingServicesSvc WHShippingServicesSoapBinding] retain];
        WHShippingServicesSvc_updateShipment *aparams = [[WHShippingServicesSvc_updateShipment alloc] init];
        NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        NSArray *str_ = [time_ componentsSeparatedByString:@" "];
        NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
        
        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
        NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"shipmentId",@"orderId", @"shipmentNote",@"gatePassRef",@"shipmentDate",@"shipmentMode",@"shipmentAgency",@"shipmentAgencyContact",@"noPackages",@"inspectedBy",@"shippedBy",@"rfidTagNo",@"packagesDescription",@"shipmentCost",@"tax",@"totalCost",@"shipmentStatus",@"remarks",@"shipmentStreet",@"shipmentLocation",@"shipmentCity",@"shipmentItemsList",@"requestHeader", nil];
        
        NSArray *loyaltyObjects = [NSArray arrayWithObjects:wareEditShipmentID,orderIdValue.text,shipmentNoteValue.text,gatePassRefValue.text,shipmentDateValue.text,shipmentModeValue.text,shipmentAgencyValue.text,shipmentAgencyContactValue.text,[NSString stringWithFormat:@"%d",totalQuantity],inspectedByValue.text,shippedByValue.text,rfidTagNoValue.text,packagesDescriptionValue.text,shipmentCostValue.text,taxData.text,totAmountData.text,@"submitted",@"djfhgjd",shipmentStreetValue.text,shipmentLocationValue.text,shipmentCityValue.text,items,dictionary, nil];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        aparams.shipmentDetails = normalStockString;
        WHShippingServicesSoapBindingResponse *response = [service updateShipmentUsingParameters:(WHShippingServicesSvc_updateShipment *)aparams];
        
        NSArray *responseBodyParts =  response.bodyParts;
        NSError *e;
        
        NSDictionary *JSON1;
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[WHShippingServicesSvc_updateShipmentResponse class]]) {
                WHShippingServicesSvc_updateShipmentResponse *body = (WHShippingServicesSvc_updateShipmentResponse *)bodyPart;
                NSLog(@"%@",body.return_);
                JSON1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                        options: NSJSONReadingMutableContainers
                                                          error: &e];
                NSDictionary *responseDic = [JSON1 objectForKey:@"responseHeader"];
                if ([[responseDic objectForKey:@"responseMessage"] isEqualToString:@"Shipment Updated Successfully"] && [[responseDic objectForKey:@"responseCode"] isEqualToString:@"0"]) {
                    NSString *status = [NSString stringWithFormat:@"%@%@%@%@",@"Successfully Shipment Created",@"\n",@"Shipment ID :",[JSON1 objectForKey:@"shipmentId"]];
                    wareEditShipmentID = [[JSON1 objectForKey:@"shipmentId"] copy];
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
                    shipmentNoteValue.text = nil;
                    shipmentDateValue.text = currentdate;
                    shipmentModeValue.text = nil;
                    shipmentAgencyValue.text= nil;
                    shipmentAgencyContactValue.text = nil;
                    inspectedByValue.text = nil;
                    shippedByValue.text= nil;
                    shipmentCostValue.text = nil;
                    shipmentLocationValue.text = nil;
                    shipmentCityValue.text = nil;
                    shipmentStreetValue.text = nil;
                    rfidTagNoValue.text = nil;
                    packagesDescriptionValue.text = nil;
                    gatePassRefValue.text = nil;
                    orderIdValue.text = nil;
                    
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
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed Creating Shipment" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
            
            ViewWarehouseShipment *vpo = [[ViewWarehouseShipment alloc] initWithShipmentID:wareEditShipmentID];
            [self.navigationController pushViewController:vpo animated:YES];
        }
        else{
            self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
            self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
            WareHouseShipments *whs = [[WareHouseShipments alloc] init];
            [self.navigationController pushViewController:whs animated:YES];
        }
    }
}

- (void) cancelButtonPressed:(id) sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    NSString *shipmentCostValue_ = [shipmentCostValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([skuIdArray count] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Add Items to Cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else{
        HUD.labelText = @"Saving Shipment..";
        [HUD setHidden:NO];
        
        NSMutableArray *items = [[NSMutableArray alloc] init];
        int totalQuantity = 0;
        for (int i = 0; i < [ItemArray count]; i++) {
            NSArray *keys = [NSArray arrayWithObjects:@"itemId", @"itemDescription",@"color",@"size",@"unitOfMeasurement",@"price",@"quantity",@"total", nil];
            NSArray *objects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",[skuIdArray objectAtIndex:i]],[NSString stringWithFormat:@"%@",[ItemArray objectAtIndex:i]],@"blue",@"35",@"NA",[NSString stringWithFormat:@"%@",[priceArray objectAtIndex:i]],[NSString stringWithFormat:@"%@",[QtyArray objectAtIndex:i]],[NSString stringWithFormat:@"%@",[totalArray objectAtIndex:i]], nil];
            NSDictionary *itemsDic = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            totalQuantity = totalQuantity + [[QtyArray objectAtIndex:i] intValue];
            [items addObject:itemsDic];
        }
        WHShippingServicesSoapBinding *service = [[WHShippingServicesSvc WHShippingServicesSoapBinding] retain];
        WHShippingServicesSvc_updateShipment *aparams = [[WHShippingServicesSvc_updateShipment alloc] init];
        NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        NSArray *str_ = [time_ componentsSeparatedByString:@" "];
        NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
        
        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
        NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"shipmentId",@"orderId", @"shipmentNote",@"gatePassRef",@"shipmentDate",@"shipmentMode",@"shipmentAgency",@"shipmentAgencyContact",@"noPackages",@"inspectedBy",@"shippedBy",@"rfidTagNo",@"packagesDescription",@"shipmentCost",@"tax",@"totalCost",@"shipmentStatus",@"remarks",@"shipmentStreet",@"shipmentLocation",@"shipmentCity",@"shipmentItemsList",@"requestHeader", nil];
        NSArray *loyaltyObjects;
        if ([shipmentCostValue_ length] == 0) {
            loyaltyObjects = [NSArray arrayWithObjects:wareEditShipmentID,orderIdValue.text,shipmentNoteValue.text,gatePassRefValue.text,shipmentDateValue.text,shipmentModeValue.text,shipmentAgencyValue.text,shipmentAgencyContactValue.text,[NSString stringWithFormat:@"%d",totalQuantity],inspectedByValue.text,shippedByValue.text,rfidTagNoValue.text,packagesDescriptionValue.text,@"0",taxData.text,totAmountData.text,@"submitted",@"djfhgjd",shipmentStreetValue.text,shipmentLocationValue.text,shipmentCityValue.text,items,dictionary, nil];
        }
        else{
            loyaltyObjects = [NSArray arrayWithObjects:wareEditShipmentID,orderIdValue.text,shipmentNoteValue.text,gatePassRefValue.text,shipmentDateValue.text,shipmentModeValue.text,shipmentAgencyValue.text,shipmentAgencyContactValue.text,@"3",inspectedByValue.text,shippedByValue.text,rfidTagNoValue.text,packagesDescriptionValue.text,shipmentCostValue.text,taxData.text,totAmountData.text,@"submitted",@"djfhgjd",shipmentStreetValue.text,shipmentLocationValue.text,shipmentCityValue.text,items,dictionary, nil];
        }
        
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        aparams.shipmentDetails = normalStockString;
        WHShippingServicesSoapBindingResponse *response = [service updateShipmentUsingParameters:(WHShippingServicesSvc_updateShipment *)aparams];
        
        NSArray *responseBodyParts =  response.bodyParts;
        NSError *e;
        
        NSDictionary *JSON1;
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[WHShippingServicesSvc_updateShipmentResponse class]]) {
                WHShippingServicesSvc_updateShipmentResponse *body = (WHShippingServicesSvc_updateShipmentResponse *)bodyPart;
                NSLog(@"%@",body.return_);
                JSON1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                        options: NSJSONReadingMutableContainers
                                                          error: &e];
                NSDictionary *responseDic = [JSON1 objectForKey:@"responseHeader"];
                if ([[responseDic objectForKey:@"responseMessage"] isEqualToString:@"Shipment Updated Successfully"] && [[responseDic objectForKey:@"responseCode"] isEqualToString:@"0"]) {
                    NSString *status = [NSString stringWithFormat:@"%@%@%@%@",@"Successfully Shipment Created",@"\n",@"Shipment ID :",[JSON1 objectForKey:@"shipmentId"]];
                    wareEditShipmentID = [[JSON1 objectForKey:@"shipmentId"] copy];
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
                    shipmentNoteValue.text = nil;
                    shipmentDateValue.text = currentdate;
                    shipmentModeValue.text = nil;
                    shipmentAgencyValue.text= nil;
                    shipmentAgencyContactValue.text = nil;
                    inspectedByValue.text = nil;
                    shippedByValue.text= nil;
                    shipmentCostValue.text = nil;
                    shipmentLocationValue.text = nil;
                    shipmentCityValue.text = nil;
                    shipmentStreetValue.text = nil;
                    rfidTagNoValue.text = nil;
                    packagesDescriptionValue.text = nil;
                    gatePassRefValue.text = nil;
                    orderIdValue.text = nil;
                    
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
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed Creating Shipment" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                }
            }
        }
    }
}

// DelButton handler...
- (IBAction)delButtonPressed:(id)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    @try {
        
        //  [skuIdArray removeObjectAtIndex:[sender tag]];
        [ItemDiscArray removeObjectAtIndex:[sender tag]];
        [ItemArray removeObjectAtIndex:[sender tag]];
        [priceArray removeObjectAtIndex:[sender tag]];
        [QtyArray removeObjectAtIndex:[sender tag]];
        [totalArray removeObjectAtIndex:[sender tag]];
        [totalQtyArray removeObjectAtIndex:[sender tag]];
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

// Handle serchOrderItemTableCancel Pressed....
-(IBAction) serchOrderItemTableCancel:(id) sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    searchItem.text = nil;
    serchOrderItemTable.hidden = YES;
    shipModeTable.hidden = YES;
    
    shipmentView.scrollEnabled = YES;
    orderButton.enabled = YES;
    cancelButton.enabled = YES;
    searchItem.enabled = YES;
//    searchBtton.enabled = YES;
    shipoModeButton.enabled = YES;
    orderItemsTable.userInteractionEnabled = TRUE;
    
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
