//
//  WareHouseShipments.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/21/15.
//
//

#import "WareHouseShipments.h"
#import "SkuServiceSvc.h"
#import "Global.h"
#import "WHShippingServicesSvc.h"
#import "ViewWarehouseShipment.h"
@interface WareHouseShipments ()

@end

@implementation WareHouseShipments
@synthesize soundFileURLRef,soundFileObject;
BOOL wareshipNewItem__ = YES;
NSString *wareShipemntId;

int wareShipmentCount1_ = 0;
int wareShipmentCount2_ = 1;
int wareShipmentCount3_ = 0;
UILabel *recStart;
UILabel *recEnd;
UILabel *totalRec;
UILabel *label1_;
UILabel *label2_;

BOOL wareShipmentCountValue_ = YES;
int wareshipmentChangeNum_ = 0;
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}
- (void) getPreviousOrdersHandler: (NSString *) value {
    
    //	// Handle errors
    //	if([value isKindOfClass:[NSError class]]) {
    //		//NSLog(@"%@", value);
    //		return;
    //	}
    //
    //	// Handle faults
    //	if([value isKindOfClass:[SoapFault class]]) {
    //		//NSLog(@"%@", value);
    //		return;
    //	}
    //
    
    [HUD setHidden:YES];
    
    // Do something with the NSString* result
    NSString* result = [value copy];
    
    NSError *e;
    
    NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [result dataUsingEncoding:NSUTF8StringEncoding]
                                                          options: NSJSONReadingMutableContainers
                                                            error: &e];
    
    NSDictionary *json = [JSON1 objectForKey:@"responseHeader"];
    
    if ([[json objectForKey:@"responseMessage"] isEqualToString:@"ShipmentDetails"] && [[json objectForKey:@"responseCode"] isEqualToString:@"0"]) {
        
        // initialize the arrays ..
        itemIdArray = [[NSMutableArray alloc] init];
        orderStatusArray = [[NSMutableArray alloc] init];
        orderAmountArray = [[NSMutableArray alloc] init];
        OrderedOnArray = [[NSMutableArray alloc] init];
        NSArray *listDetails = [JSON1 objectForKey:@"shipments"];
        //        NSArray *temp = [result componentsSeparatedByString:@"!"];
        
        recStart.text = [NSString stringWithFormat:@"%d",(wareshipmentChangeNum_ * 10) + 1];
        recEnd.text = [NSString stringWithFormat:@"%d",[recStart.text intValue] + 9];
        totalRec.text = [NSString stringWithFormat:@"%d",[[JSON1 objectForKey:@"totalShipments"] intValue]];
        
        if ([[JSON1 objectForKey:@"totalShipments"] intValue] <= 10) {
            recEnd.text = [NSString stringWithFormat:@"%d",[totalRec.text intValue]];
            nextButton.enabled =  NO;
            previousButton.enabled = NO;
            firstButton.enabled = NO;
            lastButton.enabled = NO;
            //nextButton.backgroundColor = [UIColor lightGrayColor];
        }
        else{
            
            if (wareshipmentChangeNum_ == 0) {
                previousButton.enabled = NO;
                firstButton.enabled = NO;
                nextButton.enabled = YES;
                lastButton.enabled = YES;
            }
            else if (([[JSON1 objectForKey:@"totalShipments"] intValue] - (10 * (wareshipmentChangeNum_+1))) <= 0) {
                
                nextButton.enabled = NO;
                lastButton.enabled = NO;
                recEnd.text = totalRec.text;
            }
        }
        
        
        //[temp removeObjectAtIndex:0];
        
        for (int i = 0; i < [listDetails count]; i++) {
            
            NSDictionary *temp2 = [listDetails objectAtIndex:i];
            
            [itemIdArray addObject:[NSString stringWithFormat:@"%@",[temp2 objectForKey:@"shipmentId"]]];
            [orderStatusArray addObject:[NSString stringWithFormat:@"%@",[temp2 objectForKey:@"shipmentStatus"]]];
            [orderAmountArray addObject:[NSString stringWithFormat:@"%@",[temp2 objectForKey:@"totalCost"]]];
            [OrderedOnArray addObject:[NSString stringWithFormat:@"%@",[temp2 objectForKey:@"shipmentDate"]]];
        }
        
        if ([itemIdArray count] < 5) {
            //nextButton.backgroundColor = [UIColor lightGrayColor];
            nextButton.enabled =  NO;
        }
        
        wareShipmentCount3_ = [itemIdArray count];
        
        if ([listDetails count] == 0) {
            nextButton.enabled = NO;
            lastButton.enabled = NO;
            previousButton.enabled = NO;
            firstButton.enabled = NO;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Shipments To Display" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        
        [orderstockTable reloadData];
    }
    else{
        
        wareShipmentCount2_ = NO;
        wareshipmentChangeNum_--;
        
        //nextButton.backgroundColor = [UIColor lightGrayColor];
        nextButton.enabled =  NO;
        
        //previousButton.backgroundColor = [UIColor grayColor];
        previousButton.enabled =  NO;
        
        firstButton.enabled = NO;
        lastButton.enabled = NO;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Shipments To Display" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    titleLbl.text = @"Warehouse Shipment";
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
    shipmentId.placeholder = @"   Order ID";
    
    shipmentNote = [[UITextField alloc] init];
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
    
    // getting present date & time ..
    NSDate *today = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString* currentdate = [f stringFromDate:today];
    [f release];
    
    shipmentDate = [[UITextField alloc] init];
    shipmentDate.borderStyle = UITextBorderStyleRoundedRect;
    shipmentDate.textColor = [UIColor blackColor];
    shipmentDate.font = [UIFont systemFontOfSize:18.0];
    shipmentDate.backgroundColor = [UIColor whiteColor];
    shipmentDate.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentDate.backgroundColor = [UIColor whiteColor];
    shipmentDate.autocorrectionType = UITextAutocorrectionTypeNo;
    shipmentDate.layer.borderColor = [UIColor whiteColor].CGColor;
    shipmentDate.backgroundColor = [UIColor whiteColor];
    shipmentDate.delegate = self;
    shipmentDate.placeholder = @"   Shipment Date";
    shipmentDate.userInteractionEnabled = NO;
    shipmentDate.text = currentdate;
    
    shipmentMode = [[UITextField alloc] init];
    shipmentMode.borderStyle = UITextBorderStyleRoundedRect;
    shipmentMode.textColor = [UIColor blackColor];
    shipmentMode.font = [UIFont systemFontOfSize:18.0];
    shipmentMode.backgroundColor = [UIColor whiteColor];
    shipmentMode.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentMode.backgroundColor = [UIColor whiteColor];
    shipmentMode.autocorrectionType = UITextAutocorrectionTypeNo;
    shipmentMode.layer.borderColor = [UIColor whiteColor].CGColor;
    shipmentMode.backgroundColor = [UIColor whiteColor];
    shipmentMode.delegate = self;
    shipmentMode.placeholder = @"   Shipment Mode";
    
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
    
    shipmentAgencyContact = [[UITextField alloc] init];
    shipmentAgencyContact.borderStyle = UITextBorderStyleRoundedRect;
    shipmentAgencyContact.textColor = [UIColor blackColor];
    shipmentAgencyContact.font = [UIFont systemFontOfSize:18.0];
    shipmentAgencyContact.backgroundColor = [UIColor whiteColor];
    shipmentAgencyContact.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentAgencyContact.backgroundColor = [UIColor whiteColor];
    shipmentAgencyContact.autocorrectionType = UITextAutocorrectionTypeNo;
    shipmentAgencyContact.layer.borderColor = [UIColor whiteColor].CGColor;
    shipmentAgencyContact.backgroundColor = [UIColor whiteColor];
    shipmentAgencyContact.delegate = self;
    shipmentAgencyContact.placeholder = @"   Shipment Agency Contact";
    
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
    
    shippedBy = [[UITextField alloc] init];
    shippedBy.borderStyle = UITextBorderStyleRoundedRect;
    shippedBy.textColor = [UIColor blackColor];
    shippedBy.font = [UIFont systemFontOfSize:18.0];
    shippedBy.backgroundColor = [UIColor whiteColor];
    shippedBy.clearButtonMode = UITextFieldViewModeWhileEditing;
    shippedBy.backgroundColor = [UIColor whiteColor];
    shippedBy.autocorrectionType = UITextAutocorrectionTypeNo;
    shippedBy.layer.borderColor = [UIColor whiteColor].CGColor;
    shippedBy.backgroundColor = [UIColor whiteColor];
    shippedBy.delegate = self;
    shippedBy.placeholder = @"   Shipped By";
    
    rfidTagNo = [[UITextField alloc] init];
    rfidTagNo.borderStyle = UITextBorderStyleRoundedRect;
    rfidTagNo.textColor = [UIColor blackColor];
    rfidTagNo.font = [UIFont systemFontOfSize:18.0];
    rfidTagNo.backgroundColor = [UIColor whiteColor];
    rfidTagNo.clearButtonMode = UITextFieldViewModeWhileEditing;
    rfidTagNo.backgroundColor = [UIColor whiteColor];
    rfidTagNo.autocorrectionType = UITextAutocorrectionTypeNo;
    rfidTagNo.layer.borderColor = [UIColor whiteColor].CGColor;
    rfidTagNo.backgroundColor = [UIColor whiteColor];
    rfidTagNo.delegate = self;
    rfidTagNo.placeholder = @"   RFID Tag No";
    
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
    
    shipmentCity = [[UITextField alloc] init];
    shipmentCity.borderStyle = UITextBorderStyleRoundedRect;
    shipmentCity.textColor = [UIColor blackColor];
    shipmentCity.font = [UIFont systemFontOfSize:18.0];
    shipmentCity.backgroundColor = [UIColor whiteColor];
    shipmentCity.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentCity.backgroundColor = [UIColor whiteColor];
    shipmentCity.autocorrectionType = UITextAutocorrectionTypeNo;
    shipmentCity.layer.borderColor = [UIColor whiteColor].CGColor;
    shipmentCity.backgroundColor = [UIColor whiteColor];
    shipmentCity.delegate = self;
    shipmentCity.placeholder = @"   Shipment City";
    
    shipmentLocation = [[UITextField alloc] init];
    shipmentLocation.borderStyle = UITextBorderStyleRoundedRect;
    shipmentLocation.textColor = [UIColor blackColor];
    shipmentLocation.font = [UIFont systemFontOfSize:18.0];
    shipmentLocation.backgroundColor = [UIColor whiteColor];
    shipmentLocation.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentLocation.backgroundColor = [UIColor whiteColor];
    shipmentLocation.autocorrectionType = UITextAutocorrectionTypeNo;
    shipmentLocation.layer.borderColor = [UIColor whiteColor].CGColor;
    shipmentLocation.backgroundColor = [UIColor whiteColor];
    shipmentLocation.delegate = self;
    shipmentLocation.placeholder = @"   Shipment Location";
    
    shipmentStreet = [[UITextField alloc] init];
    shipmentStreet.borderStyle = UITextBorderStyleRoundedRect;
    shipmentStreet.textColor = [UIColor blackColor];
    shipmentStreet.font = [UIFont systemFontOfSize:18.0];
    shipmentStreet.backgroundColor = [UIColor whiteColor];
    shipmentStreet.clearButtonMode = UITextFieldViewModeWhileEditing;
    shipmentStreet.backgroundColor = [UIColor whiteColor];
    shipmentStreet.autocorrectionType = UITextAutocorrectionTypeNo;
    shipmentStreet.layer.borderColor = [UIColor whiteColor].CGColor;
    shipmentStreet.backgroundColor = [UIColor whiteColor];
    shipmentStreet.delegate = self;
    shipmentStreet.placeholder = @"   Shipment Street";
    
    packagesDescription = [[UITextField alloc] init];
    packagesDescription.borderStyle = UITextBorderStyleRoundedRect;
    packagesDescription.textColor = [UIColor blackColor];
    packagesDescription.font = [UIFont systemFontOfSize:18.0];
    packagesDescription.backgroundColor = [UIColor whiteColor];
    packagesDescription.clearButtonMode = UITextFieldViewModeWhileEditing;
    packagesDescription.backgroundColor = [UIColor whiteColor];
    packagesDescription.autocorrectionType = UITextAutocorrectionTypeNo;
    packagesDescription.layer.borderColor = [UIColor whiteColor].CGColor;
    packagesDescription.backgroundColor = [UIColor whiteColor];
    packagesDescription.delegate = self;
    packagesDescription.placeholder = @"   Package Description";
    
    gatePassRef = [[UITextField alloc] init];
    gatePassRef.borderStyle = UITextBorderStyleRoundedRect;
    gatePassRef.textColor = [UIColor blackColor];
    gatePassRef.font = [UIFont systemFontOfSize:18.0];
    gatePassRef.backgroundColor = [UIColor whiteColor];
    gatePassRef.clearButtonMode = UITextFieldViewModeWhileEditing;
    gatePassRef.backgroundColor = [UIColor whiteColor];
    gatePassRef.autocorrectionType = UITextAutocorrectionTypeNo;
    gatePassRef.layer.borderColor = [UIColor whiteColor].CGColor;
    gatePassRef.backgroundColor = [UIColor whiteColor];
    gatePassRef.delegate = self;
    gatePassRef.placeholder = @"   Gate Pass Ref.";
    
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
        
        shipmentNote.font = [UIFont boldSystemFontOfSize:20];
        shipmentNote.frame = CGRectMake(400.0, 10.0, 360, 40);
        
        shipmentDate.font = [UIFont boldSystemFontOfSize:20];
        shipmentDate.frame = CGRectMake(10.0, 60.0, 360, 40);
        
        shipmentMode.font = [UIFont boldSystemFontOfSize:20];
        shipmentMode.frame = CGRectMake(400.0, 60.0, 360, 40);
        shipoModeButton.frame = CGRectMake(725, 55.0, 55, 55);
        shipModeTable.frame = CGRectMake(200, 260, 340, 270);
        [self.view addSubview:shipModeTable];
        shipModeTable.hidden = YES;
        
        shipmentAgency.font = [UIFont boldSystemFontOfSize:20];
        shipmentAgency.frame = CGRectMake(10.0, 110.0, 360, 40);
        
        shipmentAgencyContact.font = [UIFont boldSystemFontOfSize:20];
        shipmentAgencyContact.frame = CGRectMake(400.0, 110.0, 360, 40);
        
        inspectedBy.font = [UIFont boldSystemFontOfSize:20];
        inspectedBy.frame = CGRectMake(10.0, 160.0, 360, 40);
        
        shippedBy.font = [UIFont boldSystemFontOfSize:20];
        shippedBy.frame = CGRectMake(400.0, 160.0, 360, 40);
        
        rfidTagNo.font = [UIFont boldSystemFontOfSize:20];
        rfidTagNo.frame = CGRectMake(10.0, 210.0, 360, 40);
        
        shipmentCost.font = [UIFont boldSystemFontOfSize:20];
        shipmentCost.frame = CGRectMake(400.0, 210.0, 360, 40);
        
        shipmentLocation.font = [UIFont boldSystemFontOfSize:20];
        shipmentLocation.frame = CGRectMake(10.0, 260.0, 360, 40);
        
        shipmentCity.font = [UIFont boldSystemFontOfSize:20];
        shipmentCity.frame = CGRectMake(400.0, 260.0, 360, 40);
        
        shipmentStreet.font = [UIFont boldSystemFontOfSize:20];
        shipmentStreet.frame = CGRectMake(10.0, 310.0, 360, 40);
        
        packagesDescription.font = [UIFont boldSystemFontOfSize:20];
        packagesDescription.frame = CGRectMake(400.0, 310.0, 360, 40);
        
        gatePassRef.font = [UIFont boldSystemFontOfSize:20];
        gatePassRef.frame = CGRectMake(10.0, 360.0, 360, 40);
        
        searchItem.frame = CGRectMake(10, 430, 400, 40);
        searchItem.font = [UIFont systemFontOfSize:20.0];
        
        searchBtton.frame = CGRectMake(420, 430, 110, 40);
        searchBtton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0f];
        searchBtton.layer.cornerRadius = 22.0f;
        
        label1.frame = CGRectMake(10, 480.0, 150, 40);
        label1.font = [UIFont boldSystemFontOfSize:20.0];
        
        label5.frame = CGRectMake(161, 480.0, 150, 40);
        label5.font = [UIFont boldSystemFontOfSize:20.0];
        
        label2.frame = CGRectMake(312, 480.0, 150, 40);
        label2.font = [UIFont boldSystemFontOfSize:20.0];
        
        label3.frame = CGRectMake(463, 480.0, 150, 40);
        label3.font = [UIFont boldSystemFontOfSize:20.0];
        
        label4.frame = CGRectMake(614, 480.0, 150, 40);
        label4.font = [UIFont boldSystemFontOfSize:20.0];
        
        serchOrderItemTable.frame = CGRectMake(10, 470, 400, 300);
        serchOrderItemTable.hidden = YES;
        orderItemsTable.frame = CGRectMake(10, 530, 750, 376);
        orderItemsTable.hidden = YES;
        
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
        
        orderButton.frame = CGRectMake(30, 960, 350, 50);
        orderButton.layer.cornerRadius = 22.0f;
        orderButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        cancelButton.frame = CGRectMake(390, 960, 350, 50);
        cancelButton.layer.cornerRadius = 22.0f;
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
    }
    else {
        shipmentView.frame = CGRectMake(0, 42, 768, 810);
        shipmentView.contentSize = CGSizeMake(768, 1350);
        
        shipmentId.font = [UIFont boldSystemFontOfSize:15];
        shipmentId.frame = CGRectMake(5, 0, 150.0, 35.0);
        
        shipmentNote.font = [UIFont boldSystemFontOfSize:15];
        shipmentNote.frame = CGRectMake(165.0, 0, 150.0, 35.0);
        
        shipmentDate.font = [UIFont boldSystemFontOfSize:15];
        shipmentDate.frame = CGRectMake(5, 40.0, 150.0, 35);
        
        shipmentMode.font = [UIFont boldSystemFontOfSize:15];
        shipmentMode.frame = CGRectMake(165.0, 40.0, 150.0, 35);
        shipoModeButton.frame = CGRectMake(280.0, 35.0, 40.0, 40.0);
        
        shipmentAgency.font = [UIFont boldSystemFontOfSize:15];
        shipmentAgency.frame = CGRectMake(5, 80.0, 150.0, 35);
        
        shipmentAgencyContact.font = [UIFont boldSystemFontOfSize:15];
        shipmentAgencyContact.frame = CGRectMake(165, 80, 150, 35);
        
        inspectedBy.font = [UIFont boldSystemFontOfSize:15];
        inspectedBy.frame = CGRectMake(5, 120.0, 150, 35);
        
        shippedBy.font = [UIFont boldSystemFontOfSize:15];
        shippedBy.frame = CGRectMake(165, 120.0, 150, 35);
        
        rfidTagNo.font = [UIFont boldSystemFontOfSize:15];
        rfidTagNo.frame = CGRectMake(5, 160, 150, 35);
        
        shipmentCost.font = [UIFont boldSystemFontOfSize:15];
        shipmentCost.frame = CGRectMake(165, 160, 150, 35);
        
        shipmentLocation.font = [UIFont boldSystemFontOfSize:15];
        shipmentLocation.frame = CGRectMake(5, 200, 150, 35);
        
        shipmentCity.font = [UIFont boldSystemFontOfSize:15];
        shipmentCity.frame = CGRectMake(165, 200, 150, 35);
        
        shipmentStreet.font = [UIFont boldSystemFontOfSize:15];
        shipmentStreet.frame = CGRectMake(5, 240.0, 150, 35);
        
        packagesDescription.font = [UIFont boldSystemFontOfSize:15];
        packagesDescription.frame = CGRectMake(165, 240.0, 150, 35);
        
        gatePassRef.font = [UIFont boldSystemFontOfSize:15];
        gatePassRef.frame = CGRectMake(5, 280, 150, 35);
        
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
        orderItemsTable.hidden = YES;
        
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
    [shipmentView addSubview:shipmentNote];
    [shipmentView addSubview:shipmentDate];
    [shipmentView addSubview:shipmentMode];
    [shipmentView addSubview:shipoModeButton];
    [shipmentView addSubview:shipmentAgency];
    [shipmentView addSubview:shipmentAgencyContact];
    [shipmentView addSubview:inspectedBy];
    [shipmentView addSubview:shippedBy];
    [shipmentView addSubview:rfidTagNo];
    [shipmentView addSubview:shipmentCost];
    [shipmentView addSubview:shipmentLocation];
    [shipmentView addSubview:shipmentCity];
    [shipmentView addSubview:shipmentStreet];
    [shipmentView addSubview:packagesDescription];
    [shipmentView addSubview:gatePassRef];
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
    
    /** SearchBarItem*/
    const NSInteger searchBarHeight = 40;
    searchBar = [[UISearchBar alloc] init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        searchBar.frame = CGRectMake(0, 125, 768, 60);
    }
    else {
        searchBar.frame = CGRectMake(0, 35, 320, searchBarHeight);
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
        orderstockTable.frame = CGRectMake(0, 75, 320, 300);
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
    
    WHShippingServicesSoapBinding *service = [[WHShippingServicesSvc WHShippingServicesSoapBinding] retain];
    WHShippingServicesSvc_getShipments *aparams = [[WHShippingServicesSvc_getShipments alloc] init];
    NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str_ = [time_ componentsSeparatedByString:@" "];
    NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"requestHeader", nil];
    
    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",wareshipmentChangeNum_],dictionary, nil];
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
    aparams.shipmentDetails = normalStockString;
    WHShippingServicesSoapBindingResponse *response = [service getShipmentsUsingParameters:(WHShippingServicesSvc_getShipments *)aparams];
    
    NSArray *responseBodyParts =  response.bodyParts;
    
    for (id bodyPart in responseBodyParts) {
        if ([bodyPart isKindOfClass:[WHShippingServicesSvc_getShipmentsResponse class]]) {
            WHShippingServicesSvc_getShipmentsResponse *body = (WHShippingServicesSvc_getShipmentsResponse *)bodyPart;
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
    
    // Do any additional setup after loading the view.
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
}

-(void) firstButtonPressed:(id) sender {
    
    AudioServicesPlaySystemSound (soundFileObject);
    
    [itemIdArray removeAllObjects];
    [orderStatusArray removeAllObjects];
    [orderAmountArray removeAllObjects];
    [OrderedOnArray removeAllObjects];
    wareshipmentChangeNum_ = 0;
    //    cellcount = 10;
    
    //[HUD setHidden:NO];
    [HUD show:YES];
    
    WHShippingServicesSoapBinding *service = [[WHShippingServicesSvc WHShippingServicesSoapBinding] retain];
    WHShippingServicesSvc_getShipments *aparams = [[WHShippingServicesSvc_getShipments alloc] init];
    NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str_ = [time_ componentsSeparatedByString:@" "];
    NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"requestHeader", nil];
    
    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",wareshipmentChangeNum_],dictionary, nil];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
    
    NSError * err_;
    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];

    aparams.shipmentDetails = normalStockString;
    WHShippingServicesSoapBindingResponse *response = [service getShipmentsUsingParameters:(WHShippingServicesSvc_getShipments *)aparams];
    
    NSArray *responseBodyParts =  response.bodyParts;
    
    for (id bodyPart in responseBodyParts) {
        if ([bodyPart isKindOfClass:[WHShippingServicesSvc_getShipmentsResponse class]]) {
            WHShippingServicesSvc_getShipmentsResponse *body = (WHShippingServicesSvc_getShipmentsResponse *)bodyPart;
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
        
        wareshipmentChangeNum_ = [totalRec.text intValue]/10 - 1;
    }
    else{
        wareshipmentChangeNum_ =[totalRec.text intValue]/10;
    }
    //changeID = ([rec_total.text intValue]/5) - 1;
    
    //previousButton.backgroundColor = [UIColor grayColor];
    wareShipmentCount1_ = (wareshipmentChangeNum_ * 10);
    
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
    
    WHShippingServicesSoapBinding *service = [[WHShippingServicesSvc WHShippingServicesSoapBinding] retain];
    WHShippingServicesSvc_getShipments *aparams = [[WHShippingServicesSvc_getShipments alloc] init];
    NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str_ = [time_ componentsSeparatedByString:@" "];
    NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"requestHeader", nil];
    
    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",wareShipmentCount1_],dictionary, nil];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
    
    NSError * err_;
    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
    
    aparams.shipmentDetails = normalStockString;
    WHShippingServicesSoapBindingResponse *response = [service getShipmentsUsingParameters:(WHShippingServicesSvc_getShipments *)aparams];
    
    NSArray *responseBodyParts =  response.bodyParts;
    
    for (id bodyPart in responseBodyParts) {
        if ([bodyPart isKindOfClass:[WHShippingServicesSvc_getShipmentsResponse class]]) {
            WHShippingServicesSvc_getShipmentsResponse *body = (WHShippingServicesSvc_getShipmentsResponse *)bodyPart;
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
    
    if (wareshipmentChangeNum_ > 0){
        
        //nextButton.backgroundColor = [UIColor grayColor];
        nextButton.enabled =  YES;
        
        wareshipmentChangeNum_--;
        wareShipmentCount1_ = (wareshipmentChangeNum_ * 10);
        
        [itemIdArray removeAllObjects];
        [orderStatusArray removeAllObjects];
        [orderAmountArray removeAllObjects];
        [OrderedOnArray removeAllObjects];
        
        wareShipmentCountValue_ = NO;
        
        [HUD setHidden:NO];
        
        WHShippingServicesSoapBinding *service = [[WHShippingServicesSvc WHShippingServicesSoapBinding] retain];
        WHShippingServicesSvc_getShipments *aparams = [[WHShippingServicesSvc_getShipments alloc] init];
        NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        NSArray *str_ = [time_ componentsSeparatedByString:@" "];
        NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
        
        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
        NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"requestHeader", nil];
        
        NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",wareShipmentCount1_],dictionary, nil];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        aparams.shipmentDetails = normalStockString;
        WHShippingServicesSoapBindingResponse *response = [service getShipmentsUsingParameters:(WHShippingServicesSvc_getShipments *)aparams];
        
        NSArray *responseBodyParts =  response.bodyParts;
        
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[WHShippingServicesSvc_getShipmentsResponse class]]) {
                WHShippingServicesSvc_getShipmentsResponse *body = (WHShippingServicesSvc_getShipmentsResponse *)bodyPart;
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
    
    wareshipmentChangeNum_++;
    
    wareShipmentCount1_ = (wareshipmentChangeNum_ * 10);
    
    [itemIdArray removeAllObjects];
    [orderStatusArray removeAllObjects];
    [orderAmountArray removeAllObjects];
    [OrderedOnArray removeAllObjects];
    
    //previousButton.backgroundColor = [UIColor grayColor];
    previousButton.enabled =  YES;
    firstButton.enabled = YES;
    
    wareShipmentCountValue_ = YES;
    
    [HUD setHidden:NO];
    
    WHShippingServicesSoapBinding *service = [[WHShippingServicesSvc WHShippingServicesSoapBinding] retain];
    WHShippingServicesSvc_getShipments *aparams = [[WHShippingServicesSvc_getShipments alloc] init];
    NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str_ = [time_ componentsSeparatedByString:@" "];
    NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"requestHeader", nil];
    
    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",wareShipmentCount1_],dictionary, nil];
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
    aparams.shipmentDetails = normalStockString;
    WHShippingServicesSoapBindingResponse *response = [service getShipmentsUsingParameters:(WHShippingServicesSvc_getShipments *)aparams];
    
    NSArray *responseBodyParts =  response.bodyParts;
    
    for (id bodyPart in responseBodyParts) {
        if ([bodyPart isKindOfClass:[WHShippingServicesSvc_getShipmentsResponse class]]) {
            WHShippingServicesSvc_getShipmentsResponse *body = (WHShippingServicesSvc_getShipmentsResponse *)bodyPart;
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
    else if (searching){
        return [copyListOfItems count];
    }
    else if(tableView == orderstockTable){
        return [itemIdArray count];
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
        else if (tableView == orderstockTable){
            
            if (wareShipmentCountValue_ == YES) {
                
                wareShipmentCount2_ = wareShipmentCount2_ + wareShipmentCount1_;
                wareShipmentCount1_ = 0;
            }
            else{
                
                wareShipmentCount2_ = wareShipmentCount2_ - wareShipmentCount3_;
                wareShipmentCount3_ = 0;
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
        if (tableView == shipModeTable) {
            shipmentView.scrollEnabled = YES;
            orderButton.enabled = YES;
            cancelButton.enabled = YES;
            shipmentMode.text = [shipmodeList objectAtIndex:indexPath.row];
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
        else if (tableView == orderstockTable){
            self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
            self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
            ViewWarehouseShipment *vpo = [[ViewWarehouseShipment alloc] initWithShipmentID:[NSString stringWithFormat:@"%@",[itemIdArray objectAtIndex:indexPath.row]]];
            [self.navigationController pushViewController:vpo animated:YES];
        }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == orderstockTable) {
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
                        wareshipNewItem__ = NO;
                    }
                }
                if (wareshipNewItem__ == YES) {
                    
                    [skuIdArray addObject:result];
                }
                else{
                    
                    wareshipNewItem__ = YES;
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
                    wareshipNewItem__ = NO;
                    
                }
            }
            
            if (wareshipNewItem__ == YES) {
                
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
                            
                            wareshipNewItem__ = YES;
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
//        searchBtton.userInteractionEnabled = TRUE;
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
     NSString *shipmentIdValue = [shipmentId.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
     NSString *lshipmentNoteValue = [shipmentNote.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
     NSString *shipmentDateValue = [shipmentDate.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
     NSString *shipmentModeValue = [shipmentMode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
     NSString *shipmentAgencyValue = [shipmentAgency.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
     NSString *shipmentAgencyContactValue = [shipmentAgencyContact.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
     NSString *inspectedByValue = [inspectedBy.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
     NSString *shippedByValue = [shippedBy.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
     NSString *shipmentCostValue = [shipmentCost.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
     NSString *shipmentLocationValue = [shipmentLocation.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
     NSString *shipmentCityValue = [shipmentCity.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
     NSString *shipmentStreetValue = [shipmentStreet.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
     NSString *packagesDescriptionValue = [packagesDescription.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *rfidTagNoValue = [rfidTagNo.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
     NSString *gatePassRefValue = [gatePassRef.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
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
        HUD.labelText = @"Creating Shipment..";
        [HUD setHidden:NO];
        
        
        //        SDZOrderService* service = [SDZOrderService service];
        //        service.logging = YES;
        //
        //        // Returns BOOL.
        //         [service createOrder:self action:@selector(createOrderHandler:) userID:user_name orderDateTime: dateString deliveryDate: dueDate.text deliveryTime: time.text ordererEmail: email.text ordererMobile:phNo.text ordererAddress: address.text orderTotalPrice: totAmountData.text shipmentCharge: shipCharges.text shipmentMode:shipoMode.text paymentMode: paymentMode.text orderItems: str];
        int totalQuantity = 0;
        NSMutableArray *items = [[NSMutableArray alloc] init];
        for (int i = 0; i < [ItemArray count]; i++) {
            NSArray *keys = [NSArray arrayWithObjects:@"itemId", @"itemDescription",@"color",@"size",@"unitOfMeasurement",@"price",@"quantity",@"total", nil];
            NSArray *objects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",[skuIdArray objectAtIndex:i]],[NSString stringWithFormat:@"%@",[ItemArray objectAtIndex:i]],@"blue",@"35",@"NA",[NSString stringWithFormat:@"%@",[priceArray objectAtIndex:i]],[NSString stringWithFormat:@"%@",[QtyArray objectAtIndex:i]],[NSString stringWithFormat:@"%@",[totalArray objectAtIndex:i]], nil];
            NSDictionary *itemsDic = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            totalQuantity = totalQuantity + [[QtyArray objectAtIndex:i] intValue];
            [items addObject:itemsDic];
        }
        WHShippingServicesSoapBinding *service = [[WHShippingServicesSvc WHShippingServicesSoapBinding] retain];
        WHShippingServicesSvc_createShipment *aparams = [[WHShippingServicesSvc_createShipment alloc] init];
        NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        NSArray *str_ = [time_ componentsSeparatedByString:@" "];
        NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
        
        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
        NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"orderId", @"shipmentNote",@"gatePassRef",@"shipmentDate",@"shipmentMode",@"shipmentAgency",@"shipmentAgencyContact",@"noPackages",@"inspectedBy",@"shippedBy",@"rfidTagNo",@"packagesDescription",@"shipmentCost",@"tax",@"totalCost",@"shipmentStatus",@"remarks",@"shipmentStreet",@"shipmentLocation",@"shipmentCity",@"shipmentItemsList",@"requestHeader", nil];
        
        NSArray *loyaltyObjects = [NSArray arrayWithObjects:shipmentId.text,shipmentNote.text,gatePassRef.text,shipmentDate.text,shipmentMode.text,shipmentAgency.text,shipmentAgencyContact.text,[NSString stringWithFormat:@"%d",totalQuantity],inspectedBy.text,shippedBy.text,rfidTagNo.text,packagesDescription.text,shipmentCost.text,taxData.text,totAmountData.text,@"submitted",@"djfhgjd",shipmentStreet.text,shipmentLocation.text,shipmentCity.text,items,dictionary, nil];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        aparams.shipmentDetails = normalStockString;
        WHShippingServicesSoapBindingResponse *response = [service createShipmentUsingParameters:(WHShippingServicesSvc_createShipment *)aparams];
        
        NSArray *responseBodyParts =  response.bodyParts;
        NSError *e;
        
        NSDictionary *JSON1;
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[WHShippingServicesSvc_createShipmentResponse class]]) {
                WHShippingServicesSvc_createShipmentResponse *body = (WHShippingServicesSvc_createShipmentResponse *)bodyPart;
                NSLog(@"%@",body.return_);
                JSON1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                        options: NSJSONReadingMutableContainers
                                                          error: &e];
                NSDictionary *responseDic = [JSON1 objectForKey:@"responseHeader"];
                if ([[responseDic objectForKey:@"responseMessage"] isEqualToString:@"Shipment Created Successfully"] && [[responseDic objectForKey:@"responseCode"] isEqualToString:@"0"]) {
                    NSString *status = [NSString stringWithFormat:@"%@%@%@%@",@"Successfully Shipment Created",@"\n",@"Shipment ID :",[JSON1 objectForKey:@"shipmentId"]];
                    wareShipemntId = [[JSON1 objectForKey:@"shipmentId"] copy];
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
                    
                    // getting present date & time ..
                    NSDate *today = [NSDate date];
                    NSDateFormatter *f = [[NSDateFormatter alloc] init];
                    [f setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
                    NSString* currentdate = [f stringFromDate:today];
                    [f release];
                    [HUD setHidden:YES];
                    shipmentId.text = nil;
                    shipmentNote.text = nil;
                    shipmentDate.text = currentdate;
                    shipmentMode.text = nil;
                    shipmentAgency.text= nil;
                    shipmentAgencyContact.text = nil;
                    inspectedBy.text = nil;
                    shippedBy.text= nil;
                    shipmentCost.text = nil;
                    shipmentLocation.text = nil;
                    shipmentCity.text = nil;
                    shipmentStreet.text = nil;
                    rfidTagNo.text = nil;
                    packagesDescription.text = nil;
                    gatePassRef.text = nil;
                    
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
            
            ViewWarehouseShipment *vpo = [[ViewWarehouseShipment alloc] initWithShipmentID:wareShipemntId];
            [self.navigationController pushViewController:vpo animated:YES];
        }
        else{
            alertView.hidden = YES;
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
        HUD.labelText = @"Saving Shipment..";
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
        WHShippingServicesSvc_createShipment *aparams = [[WHShippingServicesSvc_createShipment alloc] init];
        NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        NSArray *str_ = [time_ componentsSeparatedByString:@" "];
        NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
        
        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
        NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"orderId", @"shipmentNote",@"gatePassRef",@"shipmentDate",@"shipmentMode",@"shipmentAgency",@"shipmentAgencyContact",@"noPackages",@"inspectedBy",@"shippedBy",@"rfidTagNo",@"packagesDescription",@"shipmentCost",@"tax",@"totalCost",@"shipmentStatus",@"remarks",@"shipmentStreet",@"shipmentLocation",@"shipmentCity",@"shipmentItemsList",@"requestHeader", nil];
        NSArray *loyaltyObjects;
        if ([shipmentCostValue length] == 0) {
            loyaltyObjects = [NSArray arrayWithObjects:shipmentId.text,shipmentNote.text,gatePassRef.text,shipmentDate.text,shipmentMode.text,shipmentAgency.text,shipmentAgencyContact.text,[NSString stringWithFormat:@"%d",totalQuantity],inspectedBy.text,shippedBy.text,rfidTagNo.text,packagesDescription.text,@"0",taxData.text,totAmountData.text,@"pending",@"djfhgjd",shipmentStreet.text,shipmentLocation.text,shipmentCity.text,items,dictionary, nil];
        }
        else{
            loyaltyObjects = [NSArray arrayWithObjects:shipmentId.text,shipmentNote.text,gatePassRef.text,shipmentDate.text,shipmentMode.text,shipmentAgency.text,shipmentAgencyContact.text,@"3",inspectedBy.text,shippedBy.text,rfidTagNo.text,packagesDescription.text,shipmentCost.text,taxData.text,totAmountData.text,@"pending",@"djfhgjd",shipmentStreet.text,shipmentLocation.text,shipmentCity.text,items,dictionary, nil];
        }
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        aparams.shipmentDetails = normalStockString;
        WHShippingServicesSoapBindingResponse *response = [service createShipmentUsingParameters:(WHShippingServicesSvc_createShipment *)aparams];
        
        NSArray *responseBodyParts =  response.bodyParts;
        NSError *e;
        
        NSDictionary *JSON1;
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[WHShippingServicesSvc_createShipmentResponse class]]) {
                WHShippingServicesSvc_createShipmentResponse *body = (WHShippingServicesSvc_createShipmentResponse *)bodyPart;
                NSLog(@"%@",body.return_);
                JSON1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                        options: NSJSONReadingMutableContainers
                                                          error: &e];
                NSDictionary *responseDic = [JSON1 objectForKey:@"responseHeader"];
                if ([[responseDic objectForKey:@"responseMessage"] isEqualToString:@"Shipment Created Successfully"] && [[responseDic objectForKey:@"responseCode"] isEqualToString:@"0"]) {
                    NSString *status = [NSString stringWithFormat:@"%@%@%@%@",@"Successfully Shipment Created",@"\n",@"Shipment ID :",[JSON1 objectForKey:@"shipmentId"]];
                    wareShipemntId = [[JSON1 objectForKey:@"shipmentId"] copy];
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
                    shipmentNote.text = nil;
                    shipmentDate.text = currentdate;
                    shipmentMode.text = nil;
                    shipmentAgency.text= nil;
                    shipmentAgencyContact.text = nil;
                    inspectedBy.text = nil;
                    shippedBy.text= nil;
                    shipmentCost.text = nil;
                    shipmentLocation.text = nil;
                    shipmentCity.text = nil;
                    shipmentStreet.text = nil;
                    rfidTagNo.text = nil;
                    packagesDescription.text = nil;
                    gatePassRef.text = nil;
                    
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
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed Saving Shipment" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
    
    //delButton.tag
    [skuIdArray removeObjectAtIndex:[sender tag]];
    [ItemDiscArray removeObjectAtIndex:[sender tag]];
    [ItemArray removeObjectAtIndex:[sender tag]];
    [priceArray removeObjectAtIndex:[sender tag]];
    [QtyArray removeObjectAtIndex:[sender tag]];
    [totalArray removeObjectAtIndex:[sender tag]];
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
-(void)backAction {
    if ([ItemArray count]>0) {
        
        warning = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"You will lose data you entered.\n Do you want to exit?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
        [warning show];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
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
