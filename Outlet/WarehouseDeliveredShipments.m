//
//  WarehouseDeliveredShipments.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/22/15.
//
//

#import "WarehouseDeliveredShipments.h"
#import "WHShippingServicesSvc.h"
#import "Global.h"
#import "ViewWarehouseShipment.h"
#import "RequestHeader.h"

@interface WarehouseDeliveredShipments ()

@end

@implementation WarehouseDeliveredShipments
@synthesize soundFileObject,soundFileURLRef;

int wareDeliveredShipmentCount1_ = 0;
int wareDeliveredShipmentCount2_ = 1;
int wareDeliveredShipmentCount3_ = 0;
UILabel *recStart;
UILabel *recEnd;
UILabel *totalRec;
UILabel *label1_;
UILabel *label2_;

BOOL wareDeliveredShipmentCountValue_ = YES;
int wareDeliveredShipmentChangeNum_ = 0;

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
    titleLbl.text = @"Delivered Shipments";
    titleLbl.textColor = [UIColor blackColor];
    titleLbl.font = [UIFont boldSystemFontOfSize:25.0f];
    titleLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:25.0f];
    [titleView addSubview:logoView];
    [titleView addSubview:titleLbl];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
    }
    else{
        logoView.frame = CGRectMake(80.0, 7.0, 30.0, 30.0);
        titleLbl.frame = CGRectMake(115.0, -12.0, 150.0, 70.0);
        titleLbl.backgroundColor = [UIColor clearColor];
        titleLbl.textColor = [UIColor whiteColor];
        titleLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
    }
    
    self.navigationItem.titleView = titleView;

    
    self.view.backgroundColor = [UIColor blackColor];
    
    /** SearchBarItem*/
    const NSInteger searchBarHeight = 40;
    searchBar = [[UISearchBar alloc] init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        searchBar.frame = CGRectMake(0, 65, 768, 60);
    }
    else {
        searchBar.frame = CGRectMake(0, 0, 320, searchBarHeight);
    }
    searchBar.delegate = self;
    searchBar.tintColor=[UIColor grayColor];
    orderstockTable.tableHeaderView = searchBar;
    [self.view addSubview:searchBar];
    [searchBar release];
    searchBar.hidden = NO;
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
    orderstockTable.hidden = NO;
    [self.view addSubview:orderstockTable];
    
    
    
    firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [firstButton addTarget:self action:@selector(firstButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [firstButton setImage:[UIImage imageNamed:@"mail_first.png"] forState:UIControlStateNormal];
    firstButton.layer.cornerRadius = 3.0f;
    firstButton.hidden = NO;
    
    lastButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [lastButton addTarget:self action:@selector(lastButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [lastButton setImage:[UIImage imageNamed:@"mail_last.png"] forState:UIControlStateNormal];
    lastButton.layer.cornerRadius = 3.0f;
    lastButton.hidden = NO;
    
    /** Create PreviousButton */
    previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [previousButton addTarget:self
                       action:@selector(previousButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [previousButton setImage:[UIImage imageNamed:@"mail_prev.png"] forState:UIControlStateNormal];
    //    [previousButton setTitle:@"Previous" forState:UIControlStateNormal];
    //    previousButton.backgroundColor = [UIColor lightGrayColor];
    previousButton.enabled =  NO;
    previousButton.hidden = NO;
    
    
    /** Create NextButton */
    nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton addTarget:self
                   action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [nextButton setImage:[UIImage imageNamed:@"mail_next.png"] forState:UIControlStateNormal];
    nextButton.hidden = NO;
    //    [nextButton setTitle:@"Next" forState:UIControlStateNormal];
    //    nextButton.backgroundColor = [UIColor grayColor];
    
    //bottom label1...
    recStart = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    recStart.text = @"";
    recStart.textAlignment = NSTextAlignmentLeft;
    recStart.backgroundColor = [UIColor clearColor];
    recStart.textColor = [UIColor whiteColor];
    recStart.hidden = NO;
    
    //bottom label_2...
    label1_ = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    label1_.text = @"-";
    label1_.textAlignment = NSTextAlignmentLeft;
    label1_.backgroundColor = [UIColor clearColor];
    label1_.textColor = [UIColor whiteColor];
    label1_.hidden = NO;
    
    //bottom label2...
    recEnd = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    recEnd.text = @"";
    recEnd.textAlignment = NSTextAlignmentLeft;
    recEnd.backgroundColor = [UIColor clearColor];
    recEnd.textColor = [UIColor whiteColor];
    recEnd.hidden = NO;
    
    //bottom label_3...
    label2_ = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    label2_.text = @"of";
    label2_.textAlignment = NSTextAlignmentLeft;
    label2_.backgroundColor = [UIColor clearColor];
    label2_.textColor = [UIColor whiteColor];
    label2_.hidden = NO;
    
    //bottom label3...
    totalRec = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    totalRec.textAlignment = NSTextAlignmentLeft;
    totalRec.backgroundColor = [UIColor clearColor];
    totalRec.textColor = [UIColor whiteColor];
    totalRec.hidden = NO;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        //        img.frame = CGRectMake(0, 0, 778, 50);
        //        label.frame = CGRectMake(10, 0, 200, 45);
        //        backbutton.frame = CGRectMake(710.0, 3.0, 45.0, 45.0);
        orderstockTable.frame = CGRectMake(0, 130.0, 778, 780);
        
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
    
    WHShippingServicesSoapBinding *service = [[WHShippingServicesSvc WHShippingServicesSoapBinding] retain];
    WHShippingServicesSvc_getShipments *aparams = [[WHShippingServicesSvc_getShipments alloc] init];
    NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str_ = [time_ componentsSeparatedByString:@" "];
    NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"shipmentStatus",@"requestHeader", nil];
    
    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",wareDeliveredShipmentChangeNum_],@"delivered",[RequestHeader getRequestHeader], nil];
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

- (void) getPreviousOrdersHandler: (NSString *) value {
    
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
        
        recStart.text = [NSString stringWithFormat:@"%d",(wareDeliveredShipmentChangeNum_ * 10) + 1];
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
            
            if (wareDeliveredShipmentChangeNum_ == 0) {
                previousButton.enabled = NO;
                firstButton.enabled = NO;
                nextButton.enabled = YES;
                lastButton.enabled = YES;
            }
            else if (([[JSON1 objectForKey:@"totalShipments"] intValue] - (10 * (wareDeliveredShipmentChangeNum_+1))) <= 0) {
                
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
        
        wareDeliveredShipmentCount3_ = [itemIdArray count];
        
        if ([listDetails count] == 0) {
            recStart.text = @"0";
            nextButton.enabled = NO;
            lastButton.enabled = NO;
            previousButton.enabled = NO;
            firstButton.enabled = NO;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Delivered Shipments" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        
        [orderstockTable reloadData];
    }
    else{
        
        wareDeliveredShipmentCount2_ = NO;
        wareDeliveredShipmentChangeNum_--;
        
        //nextButton.backgroundColor = [UIColor lightGrayColor];
        nextButton.enabled =  NO;
        
        //previousButton.backgroundColor = [UIColor grayColor];
        previousButton.enabled =  NO;
        
        firstButton.enabled = NO;
        lastButton.enabled = NO;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Delivered Shipments" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
}

-(void) firstButtonPressed:(id) sender {
    
    AudioServicesPlaySystemSound (soundFileObject);
    
    [itemIdArray removeAllObjects];
    [orderStatusArray removeAllObjects];
    [orderAmountArray removeAllObjects];
    [OrderedOnArray removeAllObjects];
    wareDeliveredShipmentChangeNum_ = 0;
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
    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"shipmentStatus",@"requestHeader", nil];
    
    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",wareDeliveredShipmentChangeNum_],@"delivered",[RequestHeader getRequestHeader], nil];
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
        
        wareDeliveredShipmentChangeNum_ = [totalRec.text intValue]/10 - 1;
    }
    else{
        wareDeliveredShipmentChangeNum_ =[totalRec.text intValue]/10;
    }
    //changeID = ([rec_total.text intValue]/5) - 1;
    
    //previousButton.backgroundColor = [UIColor grayColor];
    wareDeliveredShipmentCount1_ = (wareDeliveredShipmentChangeNum_ * 10);
    
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
    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"shipmentStatus",@"requestHeader", nil];
    
    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",wareDeliveredShipmentChangeNum_],@"delivered",[RequestHeader getRequestHeader], nil];
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
    
    if (wareDeliveredShipmentChangeNum_ > 0){
        
        //nextButton.backgroundColor = [UIColor grayColor];
        nextButton.enabled =  YES;
        
        wareDeliveredShipmentChangeNum_--;
        wareDeliveredShipmentCount1_ = (wareDeliveredShipmentChangeNum_ * 10);
        
        [itemIdArray removeAllObjects];
        [orderStatusArray removeAllObjects];
        [orderAmountArray removeAllObjects];
        [OrderedOnArray removeAllObjects];
        
        wareDeliveredShipmentCountValue_ = NO;
        
        [HUD setHidden:NO];
        
        WHShippingServicesSoapBinding *service = [[WHShippingServicesSvc WHShippingServicesSoapBinding] retain];
        WHShippingServicesSvc_getShipments *aparams = [[WHShippingServicesSvc_getShipments alloc] init];
        NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        NSArray *str_ = [time_ componentsSeparatedByString:@" "];
        NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
        
        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
        NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"shipmentStatus",@"requestHeader", nil];
        
        NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",wareDeliveredShipmentChangeNum_],@"delivered",[RequestHeader getRequestHeader], nil];
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
    
    wareDeliveredShipmentChangeNum_++;
    
    wareDeliveredShipmentCount1_ = (wareDeliveredShipmentChangeNum_ * 10);
    
    [itemIdArray removeAllObjects];
    [orderStatusArray removeAllObjects];
    [orderAmountArray removeAllObjects];
    [OrderedOnArray removeAllObjects];
    
    //previousButton.backgroundColor = [UIColor grayColor];
    previousButton.enabled =  YES;
    firstButton.enabled = YES;
    
    wareDeliveredShipmentCountValue_ = YES;
    
    [HUD setHidden:NO];
    
    WHShippingServicesSoapBinding *service = [[WHShippingServicesSvc WHShippingServicesSoapBinding] retain];
    WHShippingServicesSvc_getShipments *aparams = [[WHShippingServicesSvc_getShipments alloc] init];
    NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str_ = [time_ componentsSeparatedByString:@" "];
    NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"startIndex",@"shipmentStatus",@"requestHeader", nil];
    
    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",wareDeliveredShipmentChangeNum_],@"delivered",[RequestHeader getRequestHeader], nil];
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

/** Table started.... */

#pragma mark Table view methods

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (searching){
        return [copyListOfItems count];
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
    if (tableView == orderstockTable){
        
        if (wareDeliveredShipmentCountValue_ == YES) {
            
            wareDeliveredShipmentCount2_ = wareDeliveredShipmentCount2_ + wareDeliveredShipmentCount1_;
            wareDeliveredShipmentCount1_ = 0;
        }
        else{
            
            wareDeliveredShipmentCount2_ = wareDeliveredShipmentCount2_ - wareDeliveredShipmentCount3_;
            wareDeliveredShipmentCount3_ = 0;
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
                label4.frame = CGRectMake(10, 60, 150, 30);
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
    if (tableView == orderstockTable){
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
