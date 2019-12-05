//
//  ViewWarehouseShipment.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/22/15.
//
//

#import "ViewWarehouseShipment.h"
#import "WHShippingServicesSvc.h"
#import "Global.h"
#import "PopOverViewController.h"
#import "EditWarehouseShipment.h"
#import "OmniHomePage.h"
#import "RequestHeader.h"

@interface ViewWarehouseShipment ()

@end

@implementation ViewWarehouseShipment
@synthesize soundFileURLRef,soundFileObject;
NSString *wareShipmentID;
-(id) initWithShipmentID:(NSString *)shipmentID{
    
    wareShipmentID = [shipmentID copy];
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
    titleLbl.text = @"Shipment Details";
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
    
    shipmentNote = [[[UILabel alloc] init] autorelease];
    shipmentNote.text = @"Shipment Note :";
    shipmentNote.layer.masksToBounds = YES;
    shipmentNote.numberOfLines = 2;
    [shipmentNote setTextAlignment:NSTextAlignmentLeft];
    shipmentNote.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentNote.textColor = [UIColor whiteColor];
    
    shipmentNoteValue = [[[UILabel alloc] init] autorelease];
    shipmentNoteValue.layer.masksToBounds = YES;
    shipmentNoteValue.text = @"*******";
    shipmentNoteValue.numberOfLines = 2;
    [shipmentNoteValue setTextAlignment:NSTextAlignmentLeft];
    shipmentNoteValue.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentNoteValue.textColor = [UIColor whiteColor];
    
    shipmentDate = [[[UILabel alloc] init] autorelease];
    shipmentDate.text = @"Shipment Date :";
    shipmentDate.layer.masksToBounds = YES;
    shipmentDate.numberOfLines = 2;
    [shipmentDate setTextAlignment:NSTextAlignmentLeft];
    shipmentDate.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentDate.textColor = [UIColor whiteColor];
    
    shipmentDateValue = [[[UILabel alloc] init] autorelease];
    shipmentDateValue.layer.masksToBounds = YES;
    shipmentDateValue.text = @"*******";
    shipmentDateValue.numberOfLines = 2;
    [shipmentDateValue setTextAlignment:NSTextAlignmentLeft];
    shipmentDateValue.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentDateValue.textColor = [UIColor whiteColor];
    
    shipmentMode = [[[UILabel alloc] init] autorelease];
    shipmentMode.text = @"Shipment Mode :";
    shipmentMode.layer.masksToBounds = YES;
    shipmentMode.numberOfLines = 2;
    [shipmentMode setTextAlignment:NSTextAlignmentLeft];
    shipmentMode.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentMode.textColor = [UIColor whiteColor];
    
    shipmentModeValue = [[[UILabel alloc] init] autorelease];
    shipmentModeValue.layer.masksToBounds = YES;
    shipmentModeValue.text = @"*******";
    shipmentModeValue.numberOfLines = 2;
    [shipmentModeValue setTextAlignment:NSTextAlignmentLeft];
    shipmentModeValue.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentModeValue.textColor = [UIColor whiteColor];
    
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
    
    shipmentAgencyContact = [[[UILabel alloc] init] autorelease];
    shipmentAgencyContact.text = @"Shipment Agency Contact :";
    shipmentAgencyContact.layer.masksToBounds = YES;
    shipmentAgencyContact.numberOfLines = 2;
    [shipmentAgencyContact setTextAlignment:NSTextAlignmentLeft];
    shipmentAgencyContact.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentAgencyContact.textColor = [UIColor whiteColor];
    
    shipmentAgencyContactValue = [[[UILabel alloc] init] autorelease];
    shipmentAgencyContactValue.layer.masksToBounds = YES;
    shipmentAgencyContactValue.text = @"*******";
    shipmentAgencyContactValue.numberOfLines = 2;
    [shipmentAgencyContactValue setTextAlignment:NSTextAlignmentLeft];
    shipmentAgencyContactValue.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentAgencyContactValue.textColor = [UIColor whiteColor];
    
    inspectedBy = [[[UILabel alloc] init] autorelease];
    inspectedBy.text = @"Inspected By :";
    inspectedBy.layer.masksToBounds = YES;
    inspectedBy.numberOfLines = 2;
    [inspectedBy setTextAlignment:NSTextAlignmentLeft];
    inspectedBy.font = [UIFont boldSystemFontOfSize:14.0];
    inspectedBy.textColor = [UIColor whiteColor];
    
    inspectedByValue = [[[UILabel alloc] init] autorelease];
    inspectedByValue.layer.masksToBounds = YES;
    inspectedByValue.text = @"*******";
    inspectedByValue.numberOfLines = 2;
    [inspectedByValue setTextAlignment:NSTextAlignmentLeft];
    inspectedByValue.font = [UIFont boldSystemFontOfSize:14.0];
    inspectedByValue.textColor = [UIColor whiteColor];
    
    shippedBy = [[[UILabel alloc] init] autorelease];
    shippedBy.text = @"Shipped By :";
    shippedBy.layer.masksToBounds = YES;
    shippedBy.numberOfLines = 2;
    [shippedBy setTextAlignment:NSTextAlignmentLeft];
    shippedBy.font = [UIFont boldSystemFontOfSize:14.0];
    shippedBy.textColor = [UIColor whiteColor];
    
    shippedByValue = [[[UILabel alloc] init] autorelease];
    shippedByValue.layer.masksToBounds = YES;
    shippedByValue.text = @"*******";
    shippedByValue.numberOfLines = 2;
    [shippedByValue setTextAlignment:NSTextAlignmentLeft];
    shippedByValue.font = [UIFont boldSystemFontOfSize:14.0];
    shippedByValue.textColor = [UIColor whiteColor];
    
    rfidTagNo = [[[UILabel alloc] init] autorelease];
    rfidTagNo.text = @"RFID Tag No. :";
    rfidTagNo.layer.masksToBounds = YES;
    rfidTagNo.numberOfLines = 2;
    [rfidTagNo setTextAlignment:NSTextAlignmentLeft];
    rfidTagNo.font = [UIFont boldSystemFontOfSize:14.0];
    rfidTagNo.textColor = [UIColor whiteColor];
    
    rfidTagNoValue = [[[UILabel alloc] init] autorelease];
    rfidTagNoValue.layer.masksToBounds = YES;
    rfidTagNoValue.text = @"*******";
    rfidTagNoValue.numberOfLines = 2;
    [rfidTagNoValue setTextAlignment:NSTextAlignmentLeft];
    rfidTagNoValue.font = [UIFont boldSystemFontOfSize:14.0];
    rfidTagNoValue.textColor = [UIColor whiteColor];
    
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
    
    shipmentLocation = [[[UILabel alloc] init] autorelease];
    shipmentLocation.text = @"Shipment Location :";
    shipmentLocation.layer.masksToBounds = YES;
    shipmentLocation.numberOfLines = 2;
    [shipmentLocation setTextAlignment:NSTextAlignmentLeft];
    shipmentLocation.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentLocation.textColor = [UIColor whiteColor];
    
    shipmentLocationValue = [[[UILabel alloc] init] autorelease];
    shipmentLocationValue.layer.masksToBounds = YES;
    shipmentLocationValue.text = @"*******";
    shipmentLocationValue.numberOfLines = 2;
    [shipmentLocationValue setTextAlignment:NSTextAlignmentLeft];
    shipmentLocationValue.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentLocationValue.textColor = [UIColor whiteColor];
    
    shipmentCity = [[[UILabel alloc] init] autorelease];
    shipmentCity.text = @"Shipment City :";
    shipmentCity.layer.masksToBounds = YES;
    shipmentCity.numberOfLines = 2;
    [shipmentCity setTextAlignment:NSTextAlignmentLeft];
    shipmentCity.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentCity.textColor = [UIColor whiteColor];
    
    shipmentCityValue = [[[UILabel alloc] init] autorelease];
    shipmentCityValue.layer.masksToBounds = YES;
    shipmentCityValue.text = @"*******";
    shipmentCityValue.numberOfLines = 2;
    [shipmentCityValue setTextAlignment:NSTextAlignmentLeft];
    shipmentCityValue.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentCityValue.textColor = [UIColor whiteColor];
    
    shipmentStreet = [[[UILabel alloc] init] autorelease];
    shipmentStreet.text = @"Shipment Street :";
    shipmentStreet.layer.masksToBounds = YES;
    shipmentStreet.numberOfLines = 2;
    [shipmentStreet setTextAlignment:NSTextAlignmentLeft];
    shipmentStreet.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentStreet.textColor = [UIColor whiteColor];
    
    shipmentStreetValue = [[[UILabel alloc] init] autorelease];
    shipmentStreetValue.layer.masksToBounds = YES;
    shipmentStreetValue.text = @"*******";
    shipmentStreetValue.numberOfLines = 2;
    [shipmentStreetValue setTextAlignment:NSTextAlignmentLeft];
    shipmentStreetValue.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentStreetValue.textColor = [UIColor whiteColor];
    
    packagesDescription = [[[UILabel alloc] init] autorelease];
    packagesDescription.text = @"Package Description :";
    packagesDescription.layer.masksToBounds = YES;
    packagesDescription.numberOfLines = 2;
    [packagesDescription setTextAlignment:NSTextAlignmentLeft];
    packagesDescription.font = [UIFont boldSystemFontOfSize:14.0];
    packagesDescription.textColor = [UIColor whiteColor];
    
    packagesDescriptionValue = [[[UILabel alloc] init] autorelease];
    packagesDescriptionValue.layer.masksToBounds = YES;
    packagesDescriptionValue.text = @"*******";
    packagesDescriptionValue.numberOfLines = 2;
    [packagesDescriptionValue setTextAlignment:NSTextAlignmentLeft];
    packagesDescriptionValue.font = [UIFont boldSystemFontOfSize:14.0];
    packagesDescriptionValue.textColor = [UIColor whiteColor];
    
    gatePassRef = [[[UILabel alloc] init] autorelease];
    gatePassRef.text = @"Gate Pass Reference :";
    gatePassRef.layer.masksToBounds = YES;
    gatePassRef.numberOfLines = 2;
    [gatePassRef setTextAlignment:NSTextAlignmentLeft];
    gatePassRef.font = [UIFont boldSystemFontOfSize:14.0];
    gatePassRef.textColor = [UIColor whiteColor];
    
    gatePassRefValue = [[[UILabel alloc] init] autorelease];
    gatePassRefValue.layer.masksToBounds = YES;
    gatePassRefValue.text = @"*******";
    gatePassRefValue.numberOfLines = 2;
    [gatePassRefValue setTextAlignment:NSTextAlignmentLeft];
    gatePassRefValue.font = [UIFont boldSystemFontOfSize:14.0];
    gatePassRefValue.textColor = [UIColor whiteColor];
    
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
        
        shipmentNote.font = [UIFont boldSystemFontOfSize:20];
        shipmentNote.frame = CGRectMake(10, 60.0, 200.0, 55);
        shipmentNoteValue.font = [UIFont boldSystemFontOfSize:20];
        shipmentNoteValue.frame = CGRectMake(250.0, 60.0, 200.0, 55);
        
        shipmentDate.font = [UIFont boldSystemFontOfSize:20];
        shipmentDate.frame = CGRectMake(460.0, 60.0, 200.0, 55);
        shipmentDateValue.font = [UIFont boldSystemFontOfSize:20];
        shipmentDateValue.frame = CGRectMake(700.0, 60.0, 200.0, 55);
        
        shipmentMode.font = [UIFont boldSystemFontOfSize:20];
        shipmentMode.frame = CGRectMake(10, 120.0, 200.0, 55);
        shipmentModeValue.font = [UIFont boldSystemFontOfSize:20];
        shipmentModeValue.frame = CGRectMake(250.0, 120.0, 200.0, 55);
        
        shipmentAgency.font = [UIFont boldSystemFontOfSize:20];
        shipmentAgency.frame = CGRectMake(460.0, 120.0, 200.0, 55);
        shipmentAgencyValue.font = [UIFont boldSystemFontOfSize:20];
        shipmentAgencyValue.frame = CGRectMake(700.0, 120.0, 200.0, 55);
        
        shipmentAgencyContact.font = [UIFont boldSystemFontOfSize:20];
        shipmentAgencyContact.frame = CGRectMake(10, 180.0, 200.0, 55);
        shipmentAgencyContactValue.font = [UIFont boldSystemFontOfSize:20];
        shipmentAgencyContactValue.frame = CGRectMake(250.0, 180.0, 200.0, 55);
        
        inspectedBy.font = [UIFont boldSystemFontOfSize:20];
        inspectedBy.frame = CGRectMake(460.0, 180.0, 200.0, 55);
        inspectedByValue.font = [UIFont boldSystemFontOfSize:20];
        inspectedByValue.frame = CGRectMake(700.0, 180.0, 200.0, 55);
        
        shippedBy.font = [UIFont boldSystemFontOfSize:20];
        shippedBy.frame = CGRectMake(10, 240.0, 200.0, 55);
        shippedByValue.font = [UIFont boldSystemFontOfSize:20];
        shippedByValue.frame = CGRectMake(250.0, 240.0, 200.0, 55);
        
        rfidTagNo.font = [UIFont boldSystemFontOfSize:20];
        rfidTagNo.frame = CGRectMake(460.0, 240.0, 200.0, 55);
        rfidTagNoValue.font = [UIFont boldSystemFontOfSize:20];
        rfidTagNoValue.frame = CGRectMake(700.0, 240.0, 200.0, 55);
        
        shipmentCost.font = [UIFont boldSystemFontOfSize:20];
        shipmentCost.frame = CGRectMake(10, 300.0, 200.0, 55);
        shipmentCostValue.font = [UIFont boldSystemFontOfSize:20];
        shipmentCostValue.frame = CGRectMake(250.0, 300.0, 200.0, 55);
        
        shipmentLocation.font = [UIFont boldSystemFontOfSize:20];
        shipmentLocation.frame = CGRectMake(460.0, 300.0, 200.0, 55);
        shipmentLocationValue.font = [UIFont boldSystemFontOfSize:20];
        shipmentLocationValue.frame = CGRectMake(700.0, 300.0, 200.0, 55);
        
        shipmentCity.font = [UIFont boldSystemFontOfSize:20];
        shipmentCity.frame = CGRectMake(10, 360.0, 200.0, 55);
        shipmentCityValue.font = [UIFont boldSystemFontOfSize:20];
        shipmentCityValue.frame = CGRectMake(250.0, 360.0, 200.0, 55);
        
        shipmentStreet.font = [UIFont boldSystemFontOfSize:20];
        shipmentStreet.frame = CGRectMake(460.0, 360.0, 200.0, 55);
        shipmentStreetValue.font = [UIFont boldSystemFontOfSize:20];
        shipmentStreetValue.frame = CGRectMake(700.0, 360.0, 200.0, 55);
        
        packagesDescription.font = [UIFont boldSystemFontOfSize:20];
        packagesDescription.frame = CGRectMake(10, 420.0, 200.0, 55);
        packagesDescriptionValue.font = [UIFont boldSystemFontOfSize:20];
        packagesDescriptionValue.frame = CGRectMake(250.0, 420.0, 200.0, 55);
        
        gatePassRef.font = [UIFont boldSystemFontOfSize:20];
        gatePassRef.frame = CGRectMake(460.0, 420.0, 200.0, 55);
        gatePassRefValue.font = [UIFont boldSystemFontOfSize:20];
        gatePassRefValue.frame = CGRectMake(700.0, 420.0, 200.0, 55);
        
        label2.font = [UIFont boldSystemFontOfSize:20];
        label2.frame = CGRectMake(10, 480.0, 90, 55);
        label11.font = [UIFont boldSystemFontOfSize:20];
        label11.frame = CGRectMake(103, 480.0, 90, 55);
        label3.font = [UIFont boldSystemFontOfSize:20];
        label3.frame = CGRectMake(195, 480.0, 90, 55);
        label4.font = [UIFont boldSystemFontOfSize:20];
        label4.frame = CGRectMake(288, 480.0, 90, 55);
        label5.font = [UIFont boldSystemFontOfSize:20];
        label5.frame = CGRectMake(381, 480.0, 110, 55);
        label12.font = [UIFont boldSystemFontOfSize:20];
        label12.frame = CGRectMake(494, 480.0, 110, 55);
        label8.font = [UIFont boldSystemFontOfSize:20];
        label8.frame = CGRectMake(607, 480.0, 110, 55);
        label9.font = [UIFont boldSystemFontOfSize:20];
        label9.frame = CGRectMake(720.0, 480.0, 110, 55);
        label10.font = [UIFont boldSystemFontOfSize:20];
        label10.frame = CGRectMake(833.0, 480.0, 110, 55);
        
        cartTable.frame = CGRectMake(10, 535.0, 980.0,250.0);
        
        label6.font = [UIFont boldSystemFontOfSize:20];
        label6.frame = CGRectMake(10.0, 790, 200, 55.0);
        
        label7.font = [UIFont boldSystemFontOfSize:20];
        label7.frame = CGRectMake(10.0, 855, 200, 55);
        
        totalQuantity.font = [UIFont boldSystemFontOfSize:20];
        totalQuantity.frame = CGRectMake(580.0, 790, 200, 55);
        
        totalCost.font = [UIFont boldSystemFontOfSize:20];
        totalCost.frame = CGRectMake(580.0, 855, 200, 55);
    }
    else {
        shipmentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        shipmentView.contentSize = CGSizeMake(self.view.frame.size.width + 250.0, 800.0);
        
        shipmentId.font = [UIFont boldSystemFontOfSize:15];
        shipmentId.frame = CGRectMake(5, 0.0, 150, 35);
        shipmentId.backgroundColor = [UIColor clearColor];
        shipmentIdValue.font = [UIFont boldSystemFontOfSize:15];
        shipmentIdValue.frame = CGRectMake(165, 0.0, 150, 35);
        shipmentIdValue.backgroundColor = [UIColor clearColor];
        
        orderId.font = [UIFont boldSystemFontOfSize:15];
        orderId.frame = CGRectMake(325, 0.0, 150, 35);
        orderId.backgroundColor = [UIColor clearColor];
        orderIdValue.font = [UIFont boldSystemFontOfSize:15];
        orderIdValue.frame = CGRectMake(450.0, 0.0, 150, 35);
        orderIdValue.backgroundColor = [UIColor clearColor];
        
        shipmentNote.font = [UIFont boldSystemFontOfSize:15];
        shipmentNote.frame = CGRectMake(5, 40, 150, 35);
        shipmentNote.backgroundColor = [UIColor clearColor];
        shipmentNoteValue.font = [UIFont boldSystemFontOfSize:15];
        shipmentNoteValue.frame = CGRectMake(165, 40, 150, 35);
        shipmentNoteValue.backgroundColor = [UIColor clearColor];
        
        shipmentDate.font = [UIFont boldSystemFontOfSize:15];
        shipmentDate.frame = CGRectMake(325, 40, 150, 35);
        shipmentDate.backgroundColor = [UIColor clearColor];
        shipmentDateValue.font = [UIFont boldSystemFontOfSize:15];
        shipmentDateValue.frame = CGRectMake(450, 40, 150, 35);
        shipmentDateValue.backgroundColor = [UIColor clearColor];
        
        shipmentMode.font = [UIFont boldSystemFontOfSize:15];
        shipmentMode.frame = CGRectMake(5, 80, 150, 35);
        shipmentMode.backgroundColor = [UIColor clearColor];
        shipmentModeValue.font = [UIFont boldSystemFontOfSize:15];
        shipmentModeValue.frame = CGRectMake(165, 80, 150, 35);
        shipmentModeValue.backgroundColor = [UIColor clearColor];
        
        shipmentAgency.font = [UIFont boldSystemFontOfSize:15];
        shipmentAgency.frame = CGRectMake(325, 80, 150, 35);
        shipmentAgency.backgroundColor = [UIColor clearColor];
        shipmentAgencyValue.font = [UIFont boldSystemFontOfSize:15];
        shipmentAgencyValue.frame = CGRectMake(450, 80, 150, 35);
        shipmentAgencyValue.backgroundColor = [UIColor clearColor];
        
        shipmentAgencyContact.font = [UIFont boldSystemFontOfSize:15];
        shipmentAgencyContact.frame = CGRectMake(5, 120, 150, 35);
        shipmentAgencyContact.backgroundColor = [UIColor clearColor];
        shipmentAgencyContactValue.font = [UIFont boldSystemFontOfSize:15];
        shipmentAgencyContactValue.frame = CGRectMake(165, 120, 150, 35);
        shipmentAgencyContactValue.backgroundColor = [UIColor clearColor];
        
        inspectedBy.font = [UIFont boldSystemFontOfSize:15];
        inspectedBy.frame = CGRectMake(325, 120, 150, 35);
        inspectedBy.backgroundColor = [UIColor clearColor];
        inspectedByValue.font = [UIFont boldSystemFontOfSize:15];
        inspectedByValue.frame = CGRectMake(450, 120, 150, 35);
        inspectedByValue.backgroundColor = [UIColor clearColor];
        
        shippedBy.font = [UIFont boldSystemFontOfSize:15];
        shippedBy.frame = CGRectMake(5, 160, 150, 35);
        shippedBy.backgroundColor = [UIColor clearColor];
        shippedByValue.font = [UIFont boldSystemFontOfSize:15];
        shippedByValue.frame = CGRectMake(165, 160, 150, 35);
        shippedByValue.backgroundColor = [UIColor clearColor];
        
        rfidTagNo.font = [UIFont boldSystemFontOfSize:15];
        rfidTagNo.frame = CGRectMake(325, 160, 150, 35);
        rfidTagNo.backgroundColor = [UIColor clearColor];
        rfidTagNoValue.font = [UIFont boldSystemFontOfSize:15];
        rfidTagNoValue.frame = CGRectMake(450, 160, 150, 35);
        rfidTagNoValue.backgroundColor = [UIColor clearColor];
        
        shipmentCost.font = [UIFont boldSystemFontOfSize:15];
        shipmentCost.frame = CGRectMake(5, 200, 150, 35);
        shipmentCost.backgroundColor = [UIColor clearColor];
        shipmentCostValue.font = [UIFont boldSystemFontOfSize:15];
        shipmentCostValue.frame = CGRectMake(165, 200, 150, 35);
        shipmentCostValue.backgroundColor = [UIColor clearColor];
        
        shipmentLocation.font = [UIFont boldSystemFontOfSize:15];
        shipmentLocation.frame = CGRectMake(325, 200, 150, 35);
        shipmentLocation.backgroundColor = [UIColor clearColor];
        shipmentLocationValue.font = [UIFont boldSystemFontOfSize:15];
        shipmentLocationValue.frame = CGRectMake(450, 200, 150, 35);
        shipmentLocationValue.backgroundColor = [UIColor clearColor];
        
        shipmentCity.font = [UIFont boldSystemFontOfSize:15];
        shipmentCity.frame = CGRectMake(5, 240, 150, 35);
        shipmentCity.backgroundColor = [UIColor clearColor];
        shipmentCityValue.font = [UIFont boldSystemFontOfSize:15];
        shipmentCityValue.frame = CGRectMake(165, 240, 150, 35);
        shipmentCityValue.backgroundColor = [UIColor clearColor];
        
        shipmentStreet.font = [UIFont boldSystemFontOfSize:15];
        shipmentStreet.frame = CGRectMake(325, 240, 150, 35);
        shipmentStreet.backgroundColor = [UIColor clearColor];
        shipmentStreetValue.font = [UIFont boldSystemFontOfSize:15];
        shipmentStreetValue.frame = CGRectMake(450, 240, 150, 35);
        shipmentStreetValue.backgroundColor = [UIColor clearColor];
        
        packagesDescription.font = [UIFont boldSystemFontOfSize:15];
        packagesDescription.frame = CGRectMake(5, 280, 150, 35);
        packagesDescription.backgroundColor = [UIColor clearColor];
        packagesDescriptionValue.font = [UIFont boldSystemFontOfSize:15];
        packagesDescriptionValue.frame = CGRectMake(165, 280, 150, 35);
        packagesDescriptionValue.backgroundColor = [UIColor clearColor];
        
        gatePassRef.font = [UIFont boldSystemFontOfSize:15];
        gatePassRef.frame = CGRectMake(325, 280, 150, 35);
        gatePassRef.backgroundColor = [UIColor clearColor];
        gatePassRefValue.font = [UIFont boldSystemFontOfSize:15];
        gatePassRefValue.frame = CGRectMake(450, 280, 150, 35);
        gatePassRefValue.backgroundColor = [UIColor clearColor];
        
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
        
        cartTable.frame = CGRectMake(0, 365, 980.0,230);
        
        label6.font = [UIFont boldSystemFontOfSize:15];
        label6.frame = CGRectMake(10.0, 605, 200, 35);
        label6.backgroundColor = [UIColor clearColor];
        
        label7.font = [UIFont boldSystemFontOfSize:15];
        label7.frame = CGRectMake(10.0, 650, 200, 35);
        label7.backgroundColor = [UIColor clearColor];
        
        totalQuantity.font = [UIFont boldSystemFontOfSize:15];
        totalQuantity.frame = CGRectMake(200.0, 605, 200, 55);
        totalQuantity.backgroundColor = [UIColor clearColor];
        
        totalCost.font = [UIFont boldSystemFontOfSize:15];
        totalCost.frame = CGRectMake(200.0, 650, 200, 55);
        totalCost.backgroundColor = [UIColor clearColor];
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
    [shipmentView addSubview:label10];
    [shipmentView addSubview:label11];
    [shipmentView addSubview:label12];
    [shipmentView addSubview:label2];
    [shipmentView addSubview:label3];
    [shipmentView addSubview:label4];
    [shipmentView addSubview:label5];
    [shipmentView addSubview:label8];
    [shipmentView addSubview:label9];
    [shipmentView addSubview:label6];
    [shipmentView addSubview:label7];
    [shipmentView addSubview:cartTable];
    [shipmentView addSubview:totalQuantity];
    [shipmentView addSubview:totalCost];
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
    [folderStructure addObject:@"Edit Shipment"];
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
            
            EditWarehouseShipment *editReceipt = [[EditWarehouseShipment alloc] initWithShipmentID:wareShipmentID];
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
    
    WHShippingServicesSoapBinding *service = [[WHShippingServicesSvc WHShippingServicesSoapBinding] retain];
    WHShippingServicesSvc_getShipmentDetails *aparams = [[WHShippingServicesSvc_getShipmentDetails alloc] init];
    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"shipmentId",@"requestHeader", nil];
    
    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",wareShipmentID],[RequestHeader getRequestHeader], nil];
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
                itemIdArray = [[NSMutableArray alloc] initWithArray:[JSON1 objectForKey:@"shipmentItems"]];
                
                json = [JSON1 objectForKey:@"shipment"];
                inspectedByValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"inspectedBy"]];
                totalCost.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"totalCost"]];
                shipmentLocationValue.text =[NSString stringWithFormat:@"%@",[json objectForKey:@"shipmentLocation"]];
                shipmentStreetValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"shipmentStreet"]];
                shipmentAgencyContactValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"shipmentAgencyContact"]];
                shipmentNoteValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"shipmentNote"]];
                rfidTagNoValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"rfidTagNo"]];
                shipmentCityValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"shipmentCity"]];
                totalQuantity.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"noPackages"]];
                shipmentDateValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"shipmentDate"]];
                shipmentIdValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"shipmentId"]];
                shipmentCostValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"shipmentCost"]];
                packagesDescriptionValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"packagesDescription"]];
                gatePassRefValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"gatePassRef"]];
                shipmentModeValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"shipmentMode"]];
                orderIdValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"orderId"]];
                shippedByValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"shippedBy"]];
                shipmentAgencyValue.text  = [NSString stringWithFormat:@"%@",[json objectForKey:@"shipmentAgency"]];
                
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
