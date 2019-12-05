//
//  WareHouseVerification.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/15/15.
//
//

#import "WareHouseVerification.h"
#import "WarehouseStockVerificationSvc.h"
#import "Global.h"
#import "Cell1.h"
#import "Cell2.h"
#import "UtilityMasterServiceSvc.h"

@interface WareHouseVerification ()

@end

@implementation WareHouseVerification

@synthesize soundFileURLRef,soundFileObject,selectIndex,isOpen;

Cell2 *cell2;
Cell1 *cell1;
int cellPosition_ = 0;

int  fromlocationStartIndex1_ = 0;
NSDictionary *verifyJSON_ = NULL;

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
    titleLbl.text = @"Warehouse Verification";
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

    
    //main view bakgroung setting...
    self.view.backgroundColor = [UIColor blackColor];
    
    locationArr = [[NSMutableArray alloc] init];
    
    
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
    location.placeholder = @"   Location";
    // [location addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    selectLocation = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *buttonImageDD = [UIImage imageNamed:@"combo.png"];
    [selectLocation setBackgroundImage:buttonImageDD forState:UIControlStateNormal];
    [selectLocation addTarget:self
                       action:@selector(getListOfLocations:) forControlEvents:UIControlEventTouchDown];
    selectLocation.tag = 1;
    
    locationTable = [[UITableView alloc] init];
    locationTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [locationTable setDataSource:self];
    [locationTable setDelegate:self];
    [locationTable.layer setBorderWidth:1.0f];
    locationTable.layer.cornerRadius = 3;
    locationTable.layer.borderColor = [UIColor grayColor].CGColor;
    locationTable.hidden = YES;
    
    
    NSDate *today = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString* currentdate = [f stringFromDate:today];
    [f release];
    
    verifiedDate = [[UITextField alloc] init];
    verifiedDate.borderStyle = UITextBorderStyleRoundedRect;
    verifiedDate.textColor = [UIColor blackColor];
    verifiedDate.font = [UIFont systemFontOfSize:18.0];
    verifiedDate.backgroundColor = [UIColor whiteColor];
    verifiedDate.clearButtonMode = UITextFieldViewModeWhileEditing;
    verifiedDate.backgroundColor = [UIColor whiteColor];
    verifiedDate.autocorrectionType = UITextAutocorrectionTypeNo;
    verifiedDate.layer.borderColor = [UIColor whiteColor].CGColor;
    verifiedDate.backgroundColor = [UIColor whiteColor];
    verifiedDate.delegate = self;
    verifiedDate.placeholder = @"   Verified Date";
    verifiedDate.text = currentdate;
    [verifiedDate addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    verifiedBy = [[UITextField alloc] init];
    verifiedBy.borderStyle = UITextBorderStyleRoundedRect;
    verifiedBy.textColor = [UIColor blackColor];
    verifiedBy.font = [UIFont systemFontOfSize:18.0];
    verifiedBy.backgroundColor = [UIColor whiteColor];
    verifiedBy.clearButtonMode = UITextFieldViewModeWhileEditing;
    verifiedBy.backgroundColor = [UIColor whiteColor];
    verifiedBy.autocorrectionType = UITextAutocorrectionTypeNo;
    verifiedBy.layer.borderColor = [UIColor whiteColor].CGColor;
    verifiedBy.backgroundColor = [UIColor whiteColor];
    verifiedBy.delegate = self;
    verifiedBy.placeholder = @"   Verified By";
    [verifiedBy addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    storageUnit = [[UITextField alloc] init];
    storageUnit.borderStyle = UITextBorderStyleRoundedRect;
    storageUnit.textColor = [UIColor blackColor];
    storageUnit.font = [UIFont systemFontOfSize:18.0];
    storageUnit.backgroundColor = [UIColor whiteColor];
    storageUnit.clearButtonMode = UITextFieldViewModeWhileEditing;
    storageUnit.backgroundColor = [UIColor whiteColor];
    storageUnit.autocorrectionType = UITextAutocorrectionTypeNo;
    storageUnit.layer.borderColor = [UIColor whiteColor].CGColor;
    storageUnit.backgroundColor = [UIColor whiteColor];
    storageUnit.delegate = self;
    storageUnit.placeholder = @"   Storage Unit";
    [storageUnit addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
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
    
    skListTable = [[UITableView alloc] init];
    skListTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [skListTable setDataSource:self];
    [skListTable setDelegate:self];
    [skListTable.layer setBorderWidth:1.0f];
    skListTable.layer.cornerRadius = 3;
    skListTable.layer.borderColor = [UIColor grayColor].CGColor;
    
    UILabel *label2 = [[[UILabel alloc] init] autorelease];
    label2.text = @"SKU ID";
    label2.layer.cornerRadius = 14;
    label2.layer.masksToBounds = YES;
    label2.numberOfLines = 2;
    [label2 setTextAlignment:NSTextAlignmentCenter];
    label2.font = [UIFont boldSystemFontOfSize:14.0];
    label2.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label2.textColor = [UIColor whiteColor];
    
    UILabel *label11 = [[[UILabel alloc] init] autorelease];
    label11.text = @"Book Qty";
    label11.layer.cornerRadius = 14;
    label11.layer.masksToBounds = YES;
    label11.numberOfLines = 2;
    [label11 setTextAlignment:NSTextAlignmentCenter];
    label11.font = [UIFont boldSystemFontOfSize:14.0];
    label11.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label11.textColor = [UIColor whiteColor];
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"Physical Qty";
    label3.layer.cornerRadius = 14;
    label3.layer.masksToBounds = YES;
    [label3 setTextAlignment:NSTextAlignmentCenter];
    label3.font = [UIFont boldSystemFontOfSize:14.0];
    label3.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label3.textColor = [UIColor whiteColor];
    
    UILabel *label4 = [[[UILabel alloc] init] autorelease];
    label4.text = @"Loss";
    label4.layer.cornerRadius = 14;
    label4.layer.masksToBounds = YES;
    [label4 setTextAlignment:NSTextAlignmentCenter];
    label4.font = [UIFont boldSystemFontOfSize:14.0];
    label4.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label4.textColor = [UIColor whiteColor];
    
    UILabel *label5 = [[[UILabel alloc] init] autorelease];
    label5.text = @"Loss Type";
    label5.layer.cornerRadius = 14;
    label5.layer.masksToBounds = YES;
    [label5 setTextAlignment:NSTextAlignmentCenter];
    label5.font = [UIFont boldSystemFontOfSize:14.0];
    label5.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label5.textColor = [UIColor whiteColor];
    
    UILabel *label6 = [[[UILabel alloc] init] autorelease];
    label6.text = @"Desc";
    label6.layer.cornerRadius = 14;
    label6.layer.masksToBounds = YES;
    [label6 setTextAlignment:NSTextAlignmentCenter];
    label6.font = [UIFont boldSystemFontOfSize:14.0];
    label6.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label6.textColor = [UIColor whiteColor];
    
    
    itemTable = [[UITableView alloc] init];
    [itemTable setDataSource:self];
    [itemTable setDelegate:self];
    itemTable.backgroundColor = [UIColor clearColor];
    [itemTable setSeparatorColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.2f]];
    itemTable.hidden = YES;
    
    submitBtn = [[UIButton alloc] init] ;
    [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    submitBtn.backgroundColor = [UIColor grayColor];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 5.0f;
    [submitBtn addTarget:self action:@selector(submitButtonPressed) forControlEvents:UIControlEventTouchDown];
    
    cancelButton = [[UIButton alloc] init];
    [cancelButton addTarget:self
                     action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchDown];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    cancelButton.layer.cornerRadius = 3.0f;
    cancelButton.backgroundColor = [UIColor grayColor];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    submitBtn.userInteractionEnabled = YES;
    cancelButton.userInteractionEnabled = YES;
    
    itemArray = [[NSMutableArray alloc] init];
    //
    itemSubArray = [[NSMutableArray alloc] init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        location.font = [UIFont boldSystemFontOfSize:20];
        location.frame = CGRectMake(10.0, 80, 360, 50);
        
        selectLocation.frame = CGRectMake(330, 75, 50, 65);
        
        locationTable.frame = CGRectMake(10.0, 130.0, 360, 0);
        
        verifiedDate.font = [UIFont boldSystemFontOfSize:20];
        verifiedDate.frame = CGRectMake(400.0, 80, 360, 50);
        
        verifiedBy.font = [UIFont boldSystemFontOfSize:20];
        verifiedBy.frame = CGRectMake(10, 140.0, 360, 50);
        
        storageUnit.font = [UIFont boldSystemFontOfSize:20];
        storageUnit.frame = CGRectMake(400.0, 140.0, 360, 50);
        
        searchItem.font = [UIFont boldSystemFontOfSize:20];
        searchItem.frame = CGRectMake(200.0, 250, 360.0, 50.0);
        itemTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        itemTable.frame = CGRectMake(0, 380.0, 778, 500);
        skListTable.frame = CGRectMake(200, 300.0, 360,0);
        
        label2.font = [UIFont boldSystemFontOfSize:20];
        label2.frame = CGRectMake(10, 320.0, 120, 55);
        label6.font = [UIFont boldSystemFontOfSize:20];
        label6.frame = CGRectMake(135, 320.0, 120, 55);
        label11.font = [UIFont boldSystemFontOfSize:20];
        label11.frame = CGRectMake(260, 320.0, 120, 55);
        label3.font = [UIFont boldSystemFontOfSize:20];
        label3.frame = CGRectMake(385, 320.0, 120, 55);
        label4.font = [UIFont boldSystemFontOfSize:20];
        label4.frame = CGRectMake(510, 320.0, 120, 55);
        label5.font = [UIFont boldSystemFontOfSize:20];
        label5.frame = CGRectMake(635, 320.0, 120, 55);
        
        submitBtn.frame = CGRectMake(55.0f, 900.0,300.0f, 55.0f);
        submitBtn.layer.cornerRadius = 25.0f;
        submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        cancelButton.frame = CGRectMake(425.0f, 900.0,300.0f, 55.0f);
        cancelButton.layer.cornerRadius = 25.0f;
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
    }
    else{
        
    }
    
    itemTable.sectionFooterHeight = 0;
    itemTable.sectionHeaderHeight = 0;
    self.isOpen = NO;
    
    [self.view addSubview:location];
    [self.view addSubview:selectLocation];
    [self.view addSubview:locationTable];
    [self.view addSubview:verifiedDate];
    [self.view addSubview:verifiedBy];
    [self.view addSubview:storageUnit];
    [self.view addSubview:searchItem];
    [self.view addSubview:itemTable];
    [self.view addSubview:skListTable];
    [self.view addSubview:label2];
    [self.view addSubview:label11];
    [self.view addSubview:label3];
    [self.view addSubview:label4];
    [self.view addSubview:label5];
    [self.view addSubview:label6];
    [self.view addSubview:submitBtn];
    [self.view addSubview:cancelButton];

}

-(void)getListOfLocations:(id)sender {
    
    if (sender == selectLocation) {
        
        [selectLocation setEnabled:NO];
        [submitBtn setEnabled:NO];
        [cancelButton setEnabled:NO];
        
        [skListTable setUserInteractionEnabled:NO];
        [location resignFirstResponder];
        
        fromlocationStartIndex1_ = 0;
        
        [self getLocations:fromlocationStartIndex1_];
        
        // [waiterName resignFirstResponder];
        locationTable.hidden = NO;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            locationTable.frame = CGRectMake(10.0, 130.0, 360, 220);
        }
        [self.view bringSubviewToFront:locationTable];
        
    }
    
}
-(void)getLocations:(int)startIndex {
    
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
    
    UtilityMasterServiceSvc_getLocation *location_ = [[UtilityMasterServiceSvc_getLocation alloc] init];
    location_.locationDetails = loyaltyString;
    
    @try {
        
        UtilityMasterServiceSoapBindingResponse *response_ = [utility getLocationUsingParameters:location_];
        
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
        //        else {
        //
        //            fromlocationScrollValueStatus_ = YES;
        //
        //        }
        
    }
    @catch (NSException *exception) {
        
        
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
                verifyJSON_ = [JSONData copy];
            }
        }
        if (status) {
            NSArray *temp = [verifyJSON_ objectForKey:@"sku"];
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

-(void)searchParticularProduct :(NSString *)searchString{
    
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
                verifyJSON_ = [JSONData copy];
            }
        }
        if (status) {
            NSArray *temp = [verifyJSON_ objectForKey:@"sku"];
            [itemSubArray addObject:temp];
            NSDictionary *data = NULL;
            for (int i = 0; i < [temp count]; i++) {
                data = [temp objectAtIndex:i];
                NSString *finalStr = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@",[data objectForKey:@"skuID"],@"#",[NSString stringWithFormat:@"%@",[data objectForKey:@"quantity"]],@"#",[NSString stringWithFormat:@"%@",[data objectForKey:@"quantity"]],@"#",@"0",@"#",[data objectForKey:@"productId"],@"#",@"--",@"#",[data objectForKey:@"description"],@"#",@"--"];
                [itemArray addObject:finalStr];
            }
            
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

- (void)textFieldDidChange:(UITextField *)textField {
    if (textField == searchItem) {
        if ([textField.text length] >= 3) {
            [itemArray removeAllObjects];
            [itemTable reloadData];
            [self searchProduct:textField.text];
            
            if ([rawMaterials count] > 0) {
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    skListTable.frame = CGRectMake(200, 300.0, 360,240);
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
                        skListTable.frame = CGRectMake(200, 300.0, 360,450);
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
}

-(void) openQTYView{
    
    itemTable.userInteractionEnabled  = NO;
    
    NSArray *temp = [[itemArray objectAtIndex:cellPosition_] componentsSeparatedByString:@"#"];
    
    transparentView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)];
    transparentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    transparentView.hidden = NO;
    rejectQtyChangeDisplayView = [[UIView alloc]init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        rejectQtyChangeDisplayView.frame = CGRectMake(10.0, 200, 740.0, 650);
    }
    else{
        rejectQtyChangeDisplayView.frame = CGRectMake(75, 68, 175, 200);
    }
    rejectQtyChangeDisplayView.layer.borderWidth = 1.0;
    rejectQtyChangeDisplayView.layer.cornerRadius = 10.0;
    rejectQtyChangeDisplayView.layer.masksToBounds = YES;
    rejectQtyChangeDisplayView.hidden = NO;
    rejectQtyChangeDisplayView.layer.borderColor = [UIColor whiteColor].CGColor;
    rejectQtyChangeDisplayView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:rejectQtyChangeDisplayView];
    
    UIImageView *img  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.PNG"]];
    
    // a label on top of the view ..
    UILabel *topbar = [[UILabel alloc] init];
    topbar.backgroundColor = [UIColor grayColor];
    topbar.text = @"Enter Physical Quantity";
    topbar.backgroundColor = [UIColor clearColor];
    [topbar setTextAlignment:NSTextAlignmentCenter];
    topbar.font = [UIFont boldSystemFontOfSize:17];
    topbar.textColor = [UIColor whiteColor];
    UILabel *unitPrice = [[UILabel alloc] init];
    
    unitPrice.text = @"Book Quantity       :";
    unitPrice.font = [UIFont boldSystemFontOfSize:14];
    unitPrice.backgroundColor = [UIColor clearColor];
    unitPrice.textColor = [UIColor whiteColor];
    
    UILabel *unitPriceData = [[UILabel alloc] init];
    unitPriceData.text = [NSString stringWithFormat:@"%@",[temp objectAtIndex:1]];
    unitPriceData.font = [UIFont boldSystemFontOfSize:14];
    unitPriceData.backgroundColor = [UIColor clearColor];
    unitPriceData.textColor = [UIColor whiteColor];
    
    UILabel *physicalQty = [[UILabel alloc] init];
    
    physicalQty.text = @"Physical Qty         :";
    physicalQty.font = [UIFont boldSystemFontOfSize:14];
    physicalQty.backgroundColor = [UIColor clearColor];
    physicalQty.textColor = [UIColor whiteColor];
    
    rejecQtyField = [[UITextField alloc] init];
    rejecQtyField.borderStyle = UITextBorderStyleRoundedRect;
    rejecQtyField.textColor = [UIColor blackColor];
    rejecQtyField.placeholder = @"  Enter Qty";
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
    //        rejecQtyField.text = textField.text;
    rejecQtyField.font = [UIFont systemFontOfSize:17.0];
    rejecQtyField.backgroundColor = [UIColor whiteColor];
    rejecQtyField.autocorrectionType = UITextAutocorrectionTypeNo;
    //qtyFeild.keyboardType = UIKeyboardTypeDefault;
    rejecQtyField.clearButtonMode = UITextFieldViewModeWhileEditing;
    rejecQtyField.returnKeyType = UIReturnKeyDone;
    rejecQtyField.delegate = self;
    [rejecQtyField becomeFirstResponder];
    
    UILabel *lossType = [[UILabel alloc] init];
    
    lossType.text = @"Loss Type             :";
    lossType.font = [UIFont boldSystemFontOfSize:14];
    lossType.backgroundColor = [UIColor clearColor];
    lossType.textColor = [UIColor whiteColor];
    
    lossTypeField = [[UITextField alloc] init];
    lossTypeField.borderStyle = UITextBorderStyleRoundedRect;
    lossTypeField.textColor = [UIColor blackColor];
    lossTypeField.font = [UIFont systemFontOfSize:18.0];
    lossTypeField.backgroundColor = [UIColor whiteColor];
    lossTypeField.clearButtonMode = UITextFieldViewModeWhileEditing;
    lossTypeField.backgroundColor = [UIColor whiteColor];
    lossTypeField.autocorrectionType = UITextAutocorrectionTypeNo;
    lossTypeField.layer.borderColor = [UIColor whiteColor].CGColor;
    lossTypeField.backgroundColor = [UIColor whiteColor];
    lossTypeField.delegate = self;
    lossTypeField.placeholder = @"   Loss Type";
    [lossTypeField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    lossTypeField.userInteractionEnabled = NO;
    
    lossTypeTable = [[UITableView alloc] init];
    lossTypeTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [lossTypeTable setDataSource:self];
    [lossTypeTable setDelegate:self];
    [lossTypeTable.layer setBorderWidth:1.0f];
    lossTypeTable.layer.cornerRadius = 3;
    lossTypeTable.layer.borderColor = [UIColor grayColor].CGColor;
    lossTypeTable.hidden = YES;
    
    lossTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImageSM = [UIImage imageNamed:@"combo.png"];
    [lossTypeButton setBackgroundImage:buttonImageSM forState:UIControlStateNormal];
    [lossTypeButton addTarget:self action:@selector(shipoModeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *remarks = [[UILabel alloc] init];
    
    remarks.text = @"Remarks";
    remarks.font = [UIFont boldSystemFontOfSize:14];
    remarks.backgroundColor = [UIColor clearColor];
    remarks.textColor = [UIColor whiteColor];
    
    remarkTextView = [[UITextView alloc] init];
    remarkTextView.delegate = self;
    remarkTextView.textColor = [UIColor blackColor];
    remarkTextView.layer.cornerRadius = 5.0f;
    
    okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //[okButton setImage:[UIImage imageNamed:@"OK.png"] forState:UIControlStateNormal];
    [okButton addTarget:self
                 action:@selector(orderButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [okButton setTitle:@"OK" forState:UIControlStateNormal];
    okButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
    okButton.backgroundColor = [UIColor grayColor];
    
    /** CancelButton for qtyChangeDisplyView....*/
    qtyCancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //[qtyCancelButton setImage:[UIImage imageNamed:@"Cancel.png"] forState:UIControlStateNormal];
    [qtyCancelButton addTarget:self
                        action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [qtyCancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
    qtyCancelButton.backgroundColor = [UIColor grayColor];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        
        img.frame = CGRectMake(0, 0, 740.0, 50);
        topbar.frame = CGRectMake(0, 5, 740.0, 40);
        topbar.font = [UIFont boldSystemFontOfSize:22];
        
        
        unitPrice.frame = CGRectMake(50,60,200,40);
        unitPrice.font = [UIFont boldSystemFontOfSize:20];
        
        
        unitPriceData.frame = CGRectMake(240.0,60,2500,40);
        unitPriceData.font = [UIFont boldSystemFontOfSize:20];
        
        physicalQty.frame = CGRectMake(50,120.0,200,40);
        physicalQty.font = [UIFont boldSystemFontOfSize:20];
        
        rejecQtyField.frame = CGRectMake(240.0, 120, 200.0, 40);
        rejecQtyField.font = [UIFont boldSystemFontOfSize:20];
        
        lossType.frame = CGRectMake(50,180.0,200,40);
        lossType.font = [UIFont boldSystemFontOfSize:20];
        
        lossTypeField.font = [UIFont boldSystemFontOfSize:20];
        lossTypeField.frame = CGRectMake(240.0, 180.0, 200.0, 40);
        
        lossTypeButton.frame = CGRectMake(410.0, 175.0, 40.0, 55.0);
        
        lossTypeTable.frame = CGRectMake(240.0, 220.0, 250.0, 270);
        
        remarks.frame = CGRectMake(50,240,200,40);
        remarks.font = [UIFont boldSystemFontOfSize:20];
        
        remarkTextView.font = [UIFont boldSystemFontOfSize:20];
        remarkTextView.frame = CGRectMake(50.0, 300.0, 600.0, 200.0);
        
        okButton.frame = CGRectMake(60, 180, 80, 50);
        okButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        
        okButton.frame = CGRectMake(100.0, 540.0, 165, 45);
        okButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        okButton.layer.cornerRadius = 20.0f;
        
        qtyCancelButton.frame = CGRectMake(500.0, 540.0, 165, 45);
        qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        qtyCancelButton.layer.cornerRadius = 20.0f;
        
        
    }
    else{
        
        img.frame = CGRectMake(0, 0, 175, 32);
        topbar.frame = CGRectMake(0, 0, 175, 30);
        topbar.font = [UIFont boldSystemFontOfSize:17];
        
        unitPrice.frame = CGRectMake(10,70,100,30);
        unitPrice.font = [UIFont boldSystemFontOfSize:14];
        
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
    [rejectQtyChangeDisplayView addSubview:unitPrice];
    [rejectQtyChangeDisplayView addSubview:unitPriceData];
    [rejectQtyChangeDisplayView addSubview:physicalQty];
    [rejectQtyChangeDisplayView addSubview:rejecQtyField];
    [rejectQtyChangeDisplayView addSubview:lossType];
    
    [rejectQtyChangeDisplayView addSubview:lossTypeField];
    [rejectQtyChangeDisplayView addSubview:lossTypeButton];
    [rejectQtyChangeDisplayView addSubview:remarks];
    [rejectQtyChangeDisplayView addSubview:remarkTextView];
    [rejectQtyChangeDisplayView addSubview:okButton];
    [rejectQtyChangeDisplayView addSubview:qtyCancelButton];
    [rejectQtyChangeDisplayView addSubview:lossTypeTable];
    [transparentView addSubview:rejectQtyChangeDisplayView];
    [self.view addSubview:transparentView];
    
    
}

-(void)orderButtonPressed:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    NSString *value = [rejecQtyField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *lossTypeValue = [lossTypeField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *remarksValue = [remarkTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // PhoNumber validation...
    NSString *decimalRegex = @"[0-9]+([.]([0-9]+)?)?"; // @"[0-9]+[.][0-9]+";
    NSPredicate *decimalTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalRegex];
    BOOL isNumber = [decimalTest evaluateWithObject:[rejecQtyField text]];
    NSArray *temp = [[itemArray objectAtIndex:cellPosition_] componentsSeparatedByString:@"#"];
    int qty = [value intValue];
    if([value length] == 0 || !isNumber){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Quantity in Number." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        rejecQtyField.text = NO;
    }
    else if([rejecQtyField.text isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Valid Quantity." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        rejecQtyField.text = nil;
    }
    else if (qty > [[temp objectAtIndex:1] intValue]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Quantity cannot be Greater than Book Quantity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else if ([lossTypeValue length] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please select Loss Type" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else{
        NSString *str = @"";
        if ([remarksValue length] == 0) {
            str  = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@",[temp objectAtIndex:0],@"#",[temp objectAtIndex:1],@"#",[NSString stringWithFormat:@"%d",qty],@"#",[NSString stringWithFormat:@"%d",[[temp objectAtIndex:1] intValue] - qty],@"#",[temp objectAtIndex:4],@"#",lossTypeField.text,@"#",[temp objectAtIndex:6],@"#",@"--"];
        }
        else{
            str  = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@",[temp objectAtIndex:0],@"#",[temp objectAtIndex:1],@"#",[NSString stringWithFormat:@"%d",qty],@"#",[NSString stringWithFormat:@"%d",[[temp objectAtIndex:1] intValue] - qty],@"#",[temp objectAtIndex:4],@"#",lossTypeField.text,@"#",[temp objectAtIndex:6],@"#",remarkTextView.text];
        }
        
        
        [itemArray replaceObjectAtIndex:cellPosition_ withObject:str];
        
        transparentView.hidden = YES;
        
        [rejecQtyField resignFirstResponder];
        
        itemTable.userInteractionEnabled = YES;
        
        [itemTable reloadData];
    }
}

-(void)cancelButtonPressed:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    transparentView.hidden = YES;
    itemTable.userInteractionEnabled = YES;
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == itemTable) {
        return [itemArray count];
    }
    else{
        return 1;
    }
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == skListTable){
        
        return  [rawMaterials count];
    }
    else if(tableView == itemTable){
        if (self.isOpen) {
            if (self.selectIndex.section == section) {
                return [[itemSubArray objectAtIndex:0] count] + 1;
            }
        }
        return 1;
    }
    else if (tableView == locationTable) {
        
        return [locationArr count];
    }
    else if (tableView == lossTypeTable){
        return  [lossTypeList count];
    }
    else{
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tableView == lossTypeTable){
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            UIView* headerView = [[[UIView alloc] initWithFrame: CGRectMake(0.0, 0.0, 320.0, 69.0)] autorelease];
            headerView.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
            
            UILabel *label1 = [[[UILabel alloc] initWithFrame:CGRectMake(8, 3, 255, 30)] autorelease];
            label1.font = [UIFont boldSystemFontOfSize:22.0];
            label1.backgroundColor = [UIColor clearColor];
            label1.text = @"Select Loss Type";
            label1.textColor = [UIColor whiteColor];
            [headerView addSubview:label1];
            
            UIButton *closeBtn = [[[UIButton alloc] init] autorelease];
            [closeBtn addTarget:self action:@selector(serchOrderItemTableCancel:) forControlEvents:UIControlEventTouchUpInside];
            closeBtn.frame = CGRectMake(200.0, 4, 30, 30);
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
    else{
        return NO;
    }
}

//Customize HeightForHeaderInSection ...
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == lossTypeTable) {
        return 35.0;
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
    else if (tableView == lossTypeTable){
        return 35.0;
    }
    else{
        return 45.0;
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
    else if (tableView == lossTypeTable){
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
        
        hlcell.textLabel.text = [NSString stringWithFormat:@"%@",[lossTypeList objectAtIndex:indexPath.row]];
        hlcell.textLabel.font = [UIFont boldSystemFontOfSize:20.0f];
        hlcell.textLabel.textColor = [UIColor blackColor];
    }
    else if (tableView == itemTable){
        
        
        if (self.isOpen&&self.selectIndex.section == indexPath.section&&indexPath.row!=0) {
            
            static NSString *CellIdentifier = @"Cell2";
            cell2 = (Cell2*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (!cell2) {
                cell2 = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
            }
            //NSArray *list = [itemSubArray objectAtIndex:indexPath.row];
            
            //            NSArray *titleList = [list objectAtIndex:0];
            ////            priceList = [list objectAtIndex:1];
            //            //        NSArray *list1 = [[list objectAtIndex:indexPath.row-1] componentsSeparatedByString:@" "];
            //            //        NSLog(@"%@",list1);
            //            cell2.titleLabel.text = [titleList objectAtIndex:indexPath.row-1];
            //            cell2.priceLabel.text = [NSString stringWithFormat:@"%.2f",[[priceList objectAtIndex:indexPath.row-1] floatValue]];
            //            [cell2 setBackgroundColor:[UIColor blackColor]];
            //
            //            // cell2.piecesLabel.text = @"2pcs";
            //
            //            if ([dictionary1 count] == 0) {
            //
            //                cell2.orderedQtyLabel.text = @"";
            //            }
            //            else {
            //
            //                if ([dictionary1 objectForKey:cell2.titleLabel.text]) {
            //
            //                    cell2.orderedQtyLabel.text = [dictionary1 valueForKey:cell2.titleLabel.text];
            //                }
            //                else {
            //                    cell2.orderedQtyLabel.text = @"";
            //
            //                }
            //
            //            }
            [cell2 setBackgroundColor:[UIColor blackColor]];
            return cell2;
        }else
        {
            static NSString *CellIdentifier = @"Cell1";
            
            cell1 = (Cell1*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell1) {
                cell1 = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
            }
            //            NSString *name = [menuItemsCategories objectAtIndex:indexPath.section];
            NSArray *temp = [[itemArray objectAtIndex:indexPath.section] componentsSeparatedByString:@"#"];
            cell1.titleLabel.text = [NSString stringWithFormat:@"%@",[temp objectAtIndex:0]];
            cell1.bookQuantity.text = [NSString stringWithFormat:@"%@",[temp objectAtIndex:1]];
            cell1.physicalQty.text = [NSString stringWithFormat:@"%@",[temp objectAtIndex:2]];
            cell1.quantityLoss.text = [NSString stringWithFormat:@"%@",[temp objectAtIndex:3]];
            cell1.lossType.text = [NSString stringWithFormat:@"%@",[temp objectAtIndex:5]];
            cell1.itemDesc.numberOfLines = 3;
            cell1.itemDesc.adjustsFontSizeToFitWidth = YES;
            cell1.itemDesc.text = [NSString stringWithFormat:@"%@",[temp objectAtIndex:6]];
            //            cell1.itemImageView.image = [UIImage imageNamed:[itemImages objectAtIndex:indexPath.section]];
            //
            //            if ([dictionary2 count] == 0) {
            //
            //                cell1.orderedQuantity.text = @"";
            //            }
            //            else {
            //
            //
            //                if ([dictionary2 valueForKey:cell1.titleLabel.text]) {
            //
            //                    cell1.orderedQuantity.text = [NSString stringWithFormat:@"%@%@%@",@"(",[dictionary2 valueForKey:cell1.titleLabel.text],@")"];
            //                }
            //                else {
            //                    cell1.orderedQuantity.text = @"";
            //
            //
            //                }
            //
            //            }
            [cell1 changeArrowWithUp:([self.selectIndex isEqual:indexPath]?YES:NO)];
            [cell1 setBackgroundColor:[UIColor blackColor]];
            return cell1;
        }
    }
    else if (tableView == locationTable) {
        
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
        
        hlcell.textLabel.text = [locationArr objectAtIndex:indexPath.row];
        //[hlcell setBackgroundColor:[UIColor blackColor]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.textLabel.font = [UIFont systemFontOfSize:18.0];
        [hlcell setSelectionStyle:UITableViewCellEditingStyleNone];
        return hlcell;
        
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
    else if (tableView == lossTypeTable){
        lossTypeField.text = [NSString stringWithFormat:@"%@",[lossTypeList objectAtIndex:indexPath.row]];
        lossTypeTable.hidden = YES;
        okButton.enabled = YES;
        cancelButton.enabled = YES;
    }
    else if (tableView == itemTable){
        cellPosition_ = indexPath.section;
        [self openQTYView];
        //        if (indexPath.row == 0) {
        //
        //            if ([indexPath isEqual:self.selectIndex]) {
        //                self.isOpen = NO;
        //                [self didSelectCellRowFirstDo:NO nextDo:NO];
        //                self.selectIndex = nil;
        //
        //            }else
        //            {
        //                if (!self.selectIndex) {
        //                    self.selectIndex = indexPath;
        //                    [self didSelectCellRowFirstDo:YES nextDo:NO];
        //
        //                }else
        //                {
        //
        //                    [self didSelectCellRowFirstDo:NO nextDo:YES];
        //                }
        //            }
        //
        //        }
    }
    //        if (indexPath.row == 0) {
    //
    //            //cell1 = (Cell1 *)[tableView cellForRowAtIndexPath:self.selectIndex];
    //
    //            if ([indexPath isEqual:self.selectIndex]) {
    //                self.isOpen = NO;
    //                [self didSelectCellRowFirstDo:NO nextDo:NO];
    //                self.selectIndex = nil;
    //
    //            }else
    //            {
    //                if (!self.selectIndex) {
    //                    self.selectIndex = indexPath;
    //                    [self didSelectCellRowFirstDo:YES nextDo:NO];
    //
    //                }else
    //                {
    //
    //                    [self didSelectCellRowFirstDo:NO nextDo:YES];
    //                }
    //            }
    //
    //        }else
    //        {
    //        }
    
    else if (tableView == locationTable) {
        
        location.text = @"";
        [location resignFirstResponder];
        locationTable.hidden = YES;
        location.text = [locationArr objectAtIndex:indexPath.row];
        [skListTable setUserInteractionEnabled:YES];
        [selectLocation setEnabled:YES];
        [submitBtn setEnabled:YES];
        [cancelButton setEnabled:YES];
        [locationArr removeAllObjects];
    }
}

- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert
{
    self.isOpen = firstDoInsert;
    
    cell1 = (Cell1 *)[itemTable cellForRowAtIndexPath:self.selectIndex];
    [cell1 changeArrowWithUp:firstDoInsert];
    
    [itemTable beginUpdates];
    
    int section = self.selectIndex.section;
    int contentCount = [[itemSubArray objectAtIndex:0] count];
    NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
    for (NSUInteger i = 1; i < contentCount + 1; i++) {
        NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:section];
        [rowToInsert addObject:indexPathToInsert];
    }
    
    if (firstDoInsert)
    {
        [itemTable insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
    else
    {
        [itemTable deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
    
    [rowToInsert release];
    
    [itemTable endUpdates];
    if (nextDoInsert) {
        self.isOpen = YES;
        self.selectIndex = [itemTable indexPathForSelectedRow];
        [self didSelectCellRowFirstDo:YES nextDo:NO];
    }
    if (self.isOpen) [itemTable scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
}

-(void)submitButtonPressed{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    BOOL countStatus = FALSE;
    
    NSString *locationValue = [location.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *verifiedDateValue = [verifiedDate.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *verifiedByValue = [verifiedBy.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *storageValue = [storageUnit.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([itemArray count] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Please add items to cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else if ([locationValue length] == 0 || [verifiedDateValue length] == 0 || [verifiedByValue length] == 0 || [storageValue length] == 0 ){
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
        HUD_.labelText = @"Updating Stock..";
        
        int productBookStock = 0;
        int productPhysicalStock = 0;
        NSMutableArray *stockList = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < [itemArray count]; i++) {
            NSArray *temp = [[itemArray objectAtIndex:i] componentsSeparatedByString:@"#"];
            productBookStock = productBookStock + [[temp objectAtIndex:1] intValue];
            productPhysicalStock = productPhysicalStock + [[temp objectAtIndex:2] intValue];
        }
        
        
        for (int c = 0; c < [itemArray count]; c++) {
            
            NSArray *temp_ = [[[itemArray objectAtIndex:c] componentsSeparatedByString:@"#"] copy];
            if ([[temp_ objectAtIndex:3] intValue] > 0) {
                NSArray *headerKeys = [NSArray arrayWithObjects:@"productId", @"skuId",@"productBookStock",@"productPhysicalStock",@"skuBookStock",@"skuPhysicalStock",@"stockLoss",@"lossType",@"remarks", nil];
                
                NSArray *headerObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",[temp_ objectAtIndex:4]],[NSString stringWithFormat:@"%@",[temp_ objectAtIndex:0]],[NSString stringWithFormat:@"%d",productBookStock],[NSString stringWithFormat:@"%d",productPhysicalStock],[NSString stringWithFormat:@"%d",[[temp_ objectAtIndex:1] integerValue]],[NSString stringWithFormat:@"%d",[[temp_ objectAtIndex:2] integerValue]],[NSString stringWithFormat:@"%d",[[temp_ objectAtIndex:3] integerValue]],[temp_ objectAtIndex:5],[temp_ objectAtIndex:7], nil];
                NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
                
                [stockList addObject:dictionary_];
                
                countStatus = TRUE;
            }
        }
        
        if (!countStatus) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Quantity Lost is Zero for All the products" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            [HUD_ setHidden:YES];
            [HUD_ release];
            return;
        }
        
        @try {
            BOOL status = FALSE;
            WarehouseStockVerificationSoapBinding *materialBinding = [[WarehouseStockVerificationSvc WarehouseStockVerificationSoapBinding] retain];
            WarehouseStockVerificationSvc_updateStock *aParams = [[WarehouseStockVerificationSvc_updateStock alloc] init];
            
            
            NSString *time = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
            NSArray *str = [time componentsSeparatedByString:@" "];
            NSString *date_ = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
            NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
            
            NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
            NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
            
            NSArray *keys = [NSArray arrayWithObjects:@"verifiedDate", @"verifiedBy",@"location",@"storageUnit",@"stockItemsList",@"requestHeader", nil];
            
            NSArray *objects = [NSArray arrayWithObjects:verifiedDate.text,verifiedBy.text,location.text,storageUnit.text,stockList,dictionary_, nil];
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            
            NSError * err;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
            NSString * createReceiptJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            aParams.stockVerificationDetails = createReceiptJsonString;
            
            WarehouseStockVerificationSoapBindingResponse *response = [materialBinding updateStockUsingParameters:(WarehouseStockVerificationSvc_updateStock *)aParams];
            NSArray *responseBodyParts = response.bodyParts;
            NSDictionary *JSONData ;
            for (id bodyPart in responseBodyParts) {
                if ([bodyPart isKindOfClass:[WarehouseStockVerificationSvc_updateStockResponse class]]) {
                    WarehouseStockVerificationSvc_updateStockResponse *body = (WarehouseStockVerificationSvc_updateStockResponse *)bodyPart;
                    printf("\nresponse=%s",[body.return_ UTF8String]);
                    NSError *err;
                    status = TRUE;
                    JSONData = [[NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                                options: NSJSONReadingMutableContainers
                                                                  error: &err] copy];
                    verifyJSON_ = [JSONData copy];
                }
            }
            if (status) {
                
                NSDictionary *json = [verifyJSON_ objectForKey:@"responseHeader"];
                
                if ([[json objectForKey:@"responseMessage"] isEqualToString:@"Success"] && [[json objectForKey:@"responseCode"] isEqualToString:@"0"]) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Stock Updated Successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                    
                    location.text = nil;
                    verifiedDate.text = nil;
                    verifiedBy.text = nil;
                    storageUnit.text = nil;
                    [itemArray removeAllObjects];
                    [itemSubArray removeAllObjects];
                    
                    [itemTable reloadData];
                    
                    [HUD_ setHidden:YES];
                    [HUD_ release];
                    
                    [self viewDidLoad];
                }
                else{
                    [HUD_ setHidden:YES];
                    [HUD_ release];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed Update Stock" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                }
            }
            
        }
        @catch (NSException *exception) {
            [HUD_ setHidden:YES];
            [HUD_ release];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed Update Stock" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        @finally {
            
        }
        
        
    }
    
}

-(void)cancelButtonPressed{
    
}

-(IBAction) shipoModeButtonPressed:(id) sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    okButton.enabled = NO;
    cancelButton.enabled = NO;
    cancelButton.enabled = NO;
    //timeButton.enabled = NO;
    
    lossTypeList = [[NSMutableArray alloc] init];
    [lossTypeList addObject:@"Shop Theft"];
    [lossTypeList addObject:@"Damage"];
    [lossTypeList addObject:@"Expired"];
    [lossTypeList addObject:@"Manufacturing Defect"];
    
    lossTypeTable.hidden = NO;
    [rejectQtyChangeDisplayView bringSubviewToFront:lossTypeTable];
    [lossTypeTable reloadData];
    
}

// Handle serchOrderItemTableCancel Pressed....
-(IBAction) serchOrderItemTableCancel:(id) sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    okButton.enabled = YES;
    cancelButton.enabled = YES;
    lossTypeTable.hidden = YES;
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
