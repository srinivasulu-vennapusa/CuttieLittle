//
//  VerifiedStockReceipts.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 9/14/15.
//
//

#import "VerifiedStockReceipts.h"
#import "RequestHeader.h"

@implementation VerifiedStockReceipts
@synthesize soundFileObject,soundFileURLRef;
@synthesize verficationCodeStr;



- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    requiredVerifiedRecords = 20;
    stockVerifiedStartIndex = 0;
    
    self.titleLabel.text = NSLocalizedString(@"VERIFIED_STOCK_DETAILS", nil);
    
    self.view.backgroundColor = [UIColor blackColor];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.dimBackground = YES;
    HUD.labelText = @"Please Wait \n Loading..";
    
    [HUD show:YES];
    [HUD setHidden:NO];
    
    salesDetailsView = [[UIScrollView alloc] init];
    salesDetailsView.backgroundColor = [UIColor clearColor];
    salesDetailsView.bounces = FALSE;
    
    salesDetailsTable = [[UITableView alloc] init];
    salesDetailsTable.backgroundColor = [UIColor clearColor];
    salesDetailsTable.layer.borderColor = [UIColor grayColor].CGColor;
    
    //selectedSaleIdTable.layer.borderWidth = 1.0f;
    salesDetailsTable.bounces = TRUE;
    salesDetailsTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    salesDetailsTable.hidden = NO;
    salesDetailsTable.dataSource = self;
    salesDetailsTable.delegate = self;
    [salesDetailsTable setContentOffset:CGPointMake(0,100) animated:YES];
    salesDetailsArray = [[NSMutableArray alloc] init];
    label_1 = [[UILabel alloc] init] ;
    
    label_1.layer.cornerRadius = 14;
    label_1.textAlignment = NSTextAlignmentCenter;
    label_1.layer.masksToBounds = YES;
    label_1.font = [UIFont boldSystemFontOfSize:14.0];
    label_1.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label_1.textColor = [UIColor whiteColor];
    label_1.text = @"S No";
    
    label_2 = [[UILabel alloc] init] ;
    
    label_2.layer.cornerRadius = 14;
    label_2.layer.masksToBounds = YES;
    label_2.textAlignment = NSTextAlignmentCenter;
    label_2.font = [UIFont boldSystemFontOfSize:14.0];
    label_2.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label_2.textColor = [UIColor whiteColor];
    label_2.text = @"Sku Id";
    
    label_3 = [[UILabel alloc] init] ;
    
    label_3.layer.cornerRadius = 14;
    label_3.layer.masksToBounds = YES;
    label_3.textAlignment = NSTextAlignmentCenter;
    label_3.font = [UIFont boldSystemFontOfSize:14.0];
    label_3.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label_3.textColor = [UIColor whiteColor];
    label_3.text = @"PLU Code";
    
    label_4 = [[UILabel alloc] init] ;
    
    label_4.layer.cornerRadius = 14;
    label_4.layer.masksToBounds = YES;
    label_4.textAlignment = NSTextAlignmentCenter;
    label_4.font = [UIFont boldSystemFontOfSize:14.0];
    label_4.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label_4.textColor = [UIColor whiteColor];
    label_4.text = @"SKU Desc";
    
    label_5 = [[UILabel alloc] init] ;
    
    label_5.layer.cornerRadius = 14;
    label_5.layer.masksToBounds = YES;
    label_5.textAlignment = NSTextAlignmentCenter;
    label_5.font = [UIFont boldSystemFontOfSize:14.0];
    label_5.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label_5.textColor = [UIColor whiteColor];
    label_5.text = @"Loss Type";
    
    label_6 = [[UILabel alloc] init] ;
    
    label_6.layer.cornerRadius = 14;
    label_6.layer.masksToBounds = YES;
    label_6.textAlignment = NSTextAlignmentCenter;
    label_6.font = [UIFont boldSystemFontOfSize:14.0];
    label_6.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label_6.textColor = [UIColor whiteColor];
    label_6.text = @"Cost Price";
    
    label_7 = [[UILabel alloc] init] ;
    
    label_7.layer.cornerRadius = 14;
    label_7.layer.masksToBounds = YES;
    label_7.textAlignment = NSTextAlignmentCenter;
    label_7.font = [UIFont boldSystemFontOfSize:14.0];
    label_7.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label_7.textColor = [UIColor whiteColor];
    label_7.text = @"MRP";
    
    label_8 = [[UILabel alloc] init] ;
    
    label_8.layer.cornerRadius = 14;
    label_8.layer.masksToBounds = YES;
    label_8.textAlignment = NSTextAlignmentCenter;
    label_8.font = [UIFont boldSystemFontOfSize:14.0];
    label_8.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label_8.textColor = [UIColor whiteColor];
    label_8.text = @"Sale Price";
    
    label_9 = [[UILabel alloc] init] ;
    
    label_9.layer.cornerRadius = 14;
    label_9.layer.masksToBounds = YES;
    label_9.textAlignment = NSTextAlignmentCenter;
    label_9.font = [UIFont boldSystemFontOfSize:14.0];
    label_9.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label_9.textColor = [UIColor whiteColor];
    label_9.text = @"Book Qty";
    
    label_10 = [[UILabel alloc] init] ;
    
    label_10.layer.cornerRadius = 14;
    label_10.layer.masksToBounds = YES;
    label_10.textAlignment = NSTextAlignmentCenter;
    label_10.font = [UIFont boldSystemFontOfSize:14.0];
    label_10.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label_10.textColor = [UIColor whiteColor];
    label_10.text = @"Physical Qty";
    
    label_11 = [[UILabel alloc] init] ;
    
    label_11.layer.cornerRadius = 14;
    label_11.layer.masksToBounds = YES;
    label_11.textAlignment = NSTextAlignmentCenter;
    label_11.font = [UIFont boldSystemFontOfSize:14.0];
    label_11.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label_11.textColor = [UIColor whiteColor];
    label_11.text = @"Cost Price Val";
    
    label_12 = [[UILabel alloc] init] ;
    
    label_12.layer.cornerRadius = 14;
    label_12.layer.masksToBounds = YES;
    label_12.textAlignment = NSTextAlignmentCenter;
    label_12.font = [UIFont boldSystemFontOfSize:14.0];
    label_12.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label_12.textColor = [UIColor whiteColor];
    label_12.text = @"MRP Val";
    
    label_13 = [[UILabel alloc] init] ;
    
    label_13.layer.cornerRadius = 14;
    label_13.layer.masksToBounds = YES;
    label_13.textAlignment = NSTextAlignmentCenter;
    label_13.font = [UIFont boldSystemFontOfSize:14.0];
    label_13.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label_13.textColor = [UIColor whiteColor];
    label_13.text = @"Sale Price Val";
    
    label_14 = [[UILabel alloc] init] ;
    
    label_14.layer.cornerRadius = 14;
    label_14.layer.masksToBounds = YES;
    label_14.textAlignment = NSTextAlignmentCenter;
    label_14.font = [UIFont boldSystemFontOfSize:14.0];
    label_14.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label_14.textColor = [UIColor whiteColor];
    label_14.text = @"Stock Loss";
    
    label_15 = [[UILabel alloc] init] ;
    
    label_15.layer.cornerRadius = 14;
    label_15.layer.masksToBounds = YES;
    label_15.textAlignment = NSTextAlignmentCenter;
    label_15.font = [UIFont boldSystemFontOfSize:14.0];
    label_15.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label_15.textColor = [UIColor whiteColor];
    label_15.text = @"CP Variance";
    
    label_16 = [[UILabel alloc] init] ;
    
    label_16.layer.cornerRadius = 14;
    label_16.layer.masksToBounds = YES;
    label_16.textAlignment = NSTextAlignmentCenter;
    label_16.font = [UIFont boldSystemFontOfSize:14.0];
    label_16.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label_16.textColor = [UIColor whiteColor];
    label_16.text = @"MRP Variance";
    
    label_17 = [[UILabel alloc] init] ;
    
    label_17.layer.cornerRadius = 14;
    label_17.layer.masksToBounds = YES;
    label_17.textAlignment = NSTextAlignmentCenter;
    label_17.font = [UIFont boldSystemFontOfSize:14.0];
    label_17.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label_17.textColor = [UIColor whiteColor];
    label_17.text = @"SP Variance";
    
    UILabel  *label_18 = [[UILabel alloc] init] ;
    
    label_18.layer.cornerRadius = 14;
    label_18.layer.masksToBounds = YES;
    label_18.textAlignment = NSTextAlignmentCenter;
    label_18.font = [UIFont boldSystemFontOfSize:14.0];
    label_18.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label_18.textColor = [UIColor whiteColor];
    label_18.text = @"Verification Code";
    
    
    writeOffBtn = [[UIButton alloc] init];
    [writeOffBtn setBackgroundImage:[UIImage imageNamed:@"Button.png"] forState:UIControlStateNormal];//        [status setBackgroundColor:[UIColor grayColor]];
    [writeOffBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [writeOffBtn setTitle:@"Write Off & Close" forState:UIControlStateNormal];
    //        status.titleLabel.textColor = [UIColor blackColor];
    writeOffBtn.titleLabel.font = [UIFont boldSystemFontOfSize:22.0];
    writeOffBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    writeOffBtn.layer.cornerRadius = 10.0f;
    [writeOffBtn addTarget:self action:@selector(doStockWriteOff) forControlEvents:UIControlEventTouchUpInside];
    
    closeBtn = [[UIButton alloc] init];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"Button.png"] forState:UIControlStateNormal];//        [status setBackgroundColor:[UIColor grayColor]];
    [closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [closeBtn setTitle:@"Close Verification" forState:UIControlStateNormal];
    //        status.titleLabel.textColor = [UIColor blackColor];
    closeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:22.0];
    closeBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    closeBtn.layer.cornerRadius = 10.0f;
    [closeBtn addTarget:self action:@selector(closeVerification) forControlEvents:UIControlEventTouchUpInside];
    
    searchOptionsArr = [@[@"Category",@"Product Name",@"None"] copy];
    
    searchCriteria = [[UITextField alloc]init];
    searchCriteria.borderStyle = UITextBorderStyleRoundedRect;
    searchCriteria.textColor = [UIColor blackColor];
    searchCriteria.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
    searchCriteria.backgroundColor = [UIColor whiteColor];
    searchCriteria.placeholder = @"Search Criteria";
    
    UIButton  *selectCriteria = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [selectCriteria setBackgroundImage:[UIImage imageNamed:@"combo.png"] forState:UIControlStateNormal];
    [selectCriteria addTarget:self
                       action:@selector(getListOfOptions:) forControlEvents:UIControlEventTouchDown];
    
    
    searchTxt = [[UITextField alloc]init];
    searchTxt.borderStyle = UITextBorderStyleRoundedRect;
    searchTxt.textColor = [UIColor blackColor];
    searchTxt.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
    searchTxt.backgroundColor = [UIColor whiteColor];
    searchTxt.placeholder = @"Enter your search";
    
    UIButton  *search = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *buttonImageDD2 = [UIImage imageNamed:@"search_stock.png"];
    [search setBackgroundImage:buttonImageDD2 forState:UIControlStateNormal];
    [search addTarget:self
               action:@selector(searchTableView:) forControlEvents:UIControlEventTouchDown];
    search.tag = 1;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        
        searchCriteria.frame = CGRectMake(10,90, 230, 40);
        selectCriteria.frame = CGRectMake(210,85, 45, 53);
        searchTxt.frame = CGRectMake(280,90, 360, 40);
        
        search.frame = CGRectMake(590.0, 90, 45,45);
        
        
        salesDetailsView.frame = CGRectMake(0.0, 80, self.view.frame.size.width, self.view.frame.size.height-200);
        salesDetailsView.contentSize = CGSizeMake(self.view.frame.size.width + 1400.0,0);
        
        salesDetailsTable.frame = CGRectMake(0, 50.0, 2500.0, 530.0);
        salesDetailsTable.allowsSelection = YES;
        
        label_1.font = [UIFont boldSystemFontOfSize:18];
        label_1.frame = CGRectMake(10, 5.0, 80.0, 40.0);
        
        label_18.font = [UIFont boldSystemFontOfSize:18];
        label_18.frame = CGRectMake(100.0, 5.0, 150.0, 40.0);
        
        label_2.font = [UIFont boldSystemFontOfSize:18];
        label_2.frame = CGRectMake((label_18.frame.origin.x + label_18.frame.size.width + 10), 5.0, 100.0, 40.0);
        label_3.font = [UIFont boldSystemFontOfSize:18];
        label_3.frame = CGRectMake((label_2.frame.origin.x + label_2.frame.size.width + 10), 5.0, 120.0, 40);
        label_4.font = [UIFont boldSystemFontOfSize:18];
        label_4.frame = CGRectMake((label_3.frame.origin.x + label_3.frame.size.width + 10), 5.0, 120.0, 40.0);
        label_6.font = [UIFont boldSystemFontOfSize:18];
        label_6.frame = CGRectMake((label_4.frame.origin.x + label_4.frame.size.width + 10), 5.0, 120.0, 40);
        label_7.font = [UIFont boldSystemFontOfSize:18];
        label_7.frame = CGRectMake((label_6.frame.origin.x + label_6.frame.size.width + 10), 5.0, 140.0, 40);
        label_8.font = [UIFont boldSystemFontOfSize:18];
        label_8.frame = CGRectMake((label_7.frame.origin.x + label_7.frame.size.width + 10), 5.0, 120.0, 40);
        label_9.font = [UIFont boldSystemFontOfSize:18];
        label_9.frame = CGRectMake((label_8.frame.origin.x + label_8.frame.size.width + 10), 5.0, 120.0, 40);
        label_10.font = [UIFont boldSystemFontOfSize:18];
        label_10.frame = CGRectMake((label_9.frame.origin.x + label_9.frame.size.width + 10), 5.0, 120.0, 40);
        label_11.font = [UIFont boldSystemFontOfSize:18];
        label_11.frame = CGRectMake((label_10.frame.origin.x + label_10.frame.size.width + 10), 5.0, 120.0, 40);
        label_12.font = [UIFont boldSystemFontOfSize:18];
        label_12.frame = CGRectMake((label_11.frame.origin.x + label_11.frame.size.width + 10), 5.0, 120.0, 40);
        label_13.font = [UIFont boldSystemFontOfSize:18];
        label_13.frame = CGRectMake((label_12.frame.origin.x + label_12.frame.size.width + 10), 5.0, 120.0, 40);
        label_14.font = [UIFont boldSystemFontOfSize:18];
        label_14.frame = CGRectMake((label_13.frame.origin.x + label_13.frame.size.width + 10), 5.0, 120.0, 40);
        label_5.font = [UIFont boldSystemFontOfSize:18];
        label_5.frame = CGRectMake((label_14.frame.origin.x + label_14.frame.size.width + 10), 5.0, 120.0, 40);
        label_15.font = [UIFont boldSystemFontOfSize:18];
        label_15.frame = CGRectMake((label_5.frame.origin.x + label_5.frame.size.width + 10), 5.0, 120.0, 40);
        label_16.font = [UIFont boldSystemFontOfSize:18];
        label_16.frame = CGRectMake((label_15.frame.origin.x + label_15.frame.size.width + 10), 5.0, 120.0, 40);
        label_17.font = [UIFont boldSystemFontOfSize:18];
        label_17.frame = CGRectMake((label_16.frame.origin.x + label_16.frame.size.width + 10), 5.0, 120.0, 40);
        
        
        writeOffBtn.titleLabel.font = [UIFont boldSystemFontOfSize:22];
        
        
        [salesDetailsView addSubview:label_1];
        [salesDetailsView addSubview:label_2];
        [salesDetailsView addSubview:label_3];
        [salesDetailsView addSubview:label_4];
        [salesDetailsView addSubview:label_5];
        [salesDetailsView addSubview:label_6];
        [salesDetailsView addSubview:label_7];
        [salesDetailsView addSubview:label_8];
        [salesDetailsView addSubview:label_9];
        [salesDetailsView addSubview:label_10];
        [salesDetailsView addSubview:label_11];
        [salesDetailsView addSubview:label_12];
        [salesDetailsView addSubview:label_13];
        [salesDetailsView addSubview:label_14];
        [salesDetailsView addSubview:label_15];
        [salesDetailsView addSubview:label_16];
        [salesDetailsView addSubview:label_17];
        [salesDetailsView addSubview:label_18];
        [salesDetailsView addSubview:salesDetailsTable];
        [self.view addSubview:salesDetailsView];
        [self.view addSubview:searchCriteria];
        [self.view addSubview:selectCriteria];
        [self.view addSubview:searchTxt];
        [self.view addSubview:search];
        
    }
    else{
        salesDetailsTable.frame = CGRectMake(0, 45, self.view.frame.size.width + 700.0, 300);
        salesDetailsView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height);
        salesDetailsView.contentSize = CGSizeMake(self.view.frame.size.width + 700.0, self.view.frame.size.height);
        label_1.font = [UIFont fontWithName:@"Arial-Bold" size:12];
        label_1.frame = CGRectMake(0, 10.0, 80, 30);
        label_2.font = [UIFont fontWithName:@"Arial-Bold" size:12];
        label_2.frame = CGRectMake(85, 10.0, 80, 30);
        label_3.font = [UIFont fontWithName:@"Arial-Bold" size:12];
        label_3.frame = CGRectMake(170.0, 10.0, 100.0, 30);
        label_4.font = [UIFont fontWithName:@"Arial-Bold" size:12];
        label_4.frame = CGRectMake(275.0, 10.0, 130.0, 30);
        label_5.font = [UIFont fontWithName:@"Arial-Bold" size:12];
        label_5.frame = CGRectMake(410.0, 10.0, 120.0, 30);
        label_6.font = [UIFont fontWithName:@"Arial-Bold" size:12];
        label_6.frame = CGRectMake(535.0, 10.0, 120.0, 30);
        label_7.font = [UIFont fontWithName:@"Arial-Bold" size:12];
        label_7.frame = CGRectMake(660.0, 10, 120.0, 30);
        label_8.font = [UIFont fontWithName:@"Arial-Bold" size:12];
        label_8.frame = CGRectMake(785.0, 10, 120.0, 30);
        
        [salesDetailsView addSubview:salesDetailsTable];
        [salesDetailsView addSubview:label_1];
        [salesDetailsView addSubview:label_2];
        [salesDetailsView addSubview:label_3];
        [salesDetailsView addSubview:label_4];
        [salesDetailsView addSubview:label_5];
        [salesDetailsView addSubview:label_6];
        [salesDetailsView addSubview:label_7];
        [salesDetailsView addSubview:label_8];
        [self.view addSubview:salesDetailsView];
    }
    salesDetailsArray = [[NSMutableArray alloc] init];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    [self getVerifiedStockDetails];
    
}

-(void)getVerifiedStockDetails {
    @try {
        
        [HUD setHidden:NO];
        
        NSDictionary *reqDic = @{REQUEST_HEADER: [RequestHeader getRequestHeader],@"location": presentLocation,@"startIndex": @"-1",@"verificationsUnderMasterCode": [NSNumber numberWithBool:TRUE],@"verification_code": verficationCodeStr};
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
        NSString * getCodeJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:GET_VERIFICATION_CODE];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,getCodeJsonString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                            timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 if (![[response valueForKey:RESPONSE_HEADER]isKindOfClass:[NSNull class]] &&[[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [HUD setHidden:YES];
                     
                     salesDetailsArray = [NSMutableArray new];
                     
                     approvedBy = [[[response valueForKey:@"verificationMasterObj"] valueForKey:@"approvedBy"] copy];
                     
                     for (NSDictionary *list in [[response valueForKey:@"verificationMasterObj"] valueForKey:@"stockVerificationList"]) {
                         
                         for (NSDictionary *items in [list valueForKey:@"itemsList"]) {
                             [salesDetailsArray addObject:items];
                             
                         }
                         
                     }
                     
                     if (salesDetailsArray.count) {
                         
                         if ([[[response valueForKey:@"verificationMasterObj"] valueForKey:@"status"] caseInsensitiveCompare:@"closed"] == NSOrderedSame) {
                             
                             writeOffBtn.frame = CGRectMake(350,self.view.frame.size.height - 100,320, 45);
                             
                             writeOffBtn.frame = CGRectMake(self.view.frame.size.width/2 - writeOffBtn.frame.size.width/2,self.view.frame.size.height - 80,writeOffBtn.frame.size.width,writeOffBtn.frame.size.height);
                             [self.view addSubview:writeOffBtn];
                         }
                         
                         else if ([[[response valueForKey:kVerificationMasterObj] valueForKey:@"status"] caseInsensitiveCompare:@"Write Off"] != NSOrderedSame) {
                             
                             writeOffBtn.frame = CGRectMake(200,self.view.frame.size.height - 70,250, 45);
                             
                             
                             closeBtn.frame = CGRectMake(writeOffBtn.frame.origin.x + writeOffBtn.frame.size.width + 50,self.view.frame.size.height - 70,250, 45);
                             
                             
                             [self.view addSubview:writeOffBtn];
                             
                             [self.view addSubview:closeBtn];
                             
                             //                             [self.view addConstraint:[NSLayoutConstraint constraintWithItem:writeOffBtn attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
                             //
                             //                             NSDictionary *views = NSDictionaryOfVariableBindings(writeOffBtn, closeBtn);
                             //
                             //                             [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[writeOffBtn][closeBtn(==writeOffBtn)]|" options:NSLayoutFormatAlignAllBottom metrics:nil views:views]];
                             
                             
                         }
                         
                         [salesDetailsTable reloadData];
                     }
                     
                 }
                 else {
                     [HUD setHidden:YES];
                     
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alert show];
                     
                 }
             }
             else {
                 [HUD setHidden:YES];
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:connectionError.localizedDescription message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alert show];
             }
         }];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
    }
}

- (void) getVerifiedStockReport:(NSDictionary *)successDictionary {
    if (successDictionary != nil) {
        if (![[successDictionary valueForKey:@"verificationDetails"] isKindOfClass:[NSNull class]]) {
            if ([[successDictionary valueForKey:@"verificationDetails"] count] > 0) {
                [HUD setHidden:YES];
                [salesDetailsArray addObjectsFromArray:[successDictionary valueForKey:@"verificationDetails"]];
                [salesDetailsTable reloadData];
                //                stockStartIndex = stockStartIndex + 20;
            }
            else {
                [HUD setHidden:YES];
                stockReportScrollStatus = YES;
            }
        }
        else {
            [HUD setHidden:YES];
            stockReportScrollStatus = YES;
        }
    }
    else {
        [HUD setHidden:YES];
        stockReportScrollStatus = YES;
    }
}

- (void) getStockLedgerReportErrorResponse {
    [HUD setHidden:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed to get Data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
}


#pragma mark Table view methods

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == salesDetailsTable) {
        return salesDetailsArray.count;
    }
    else  if (tableView == searchCriteriaTbl) {
        return searchOptionsArr.count;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return 40;
    }
    else {
        return 33; //I put some padding on it.
    }
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if (tableView == salesDetailsTable) {
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.separatorColor = [UIColor clearColor];
    }
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.backgroundColor = [UIColor clearColor];
    if ((cell.contentView).subviews){
        for (UIView *subview in (cell.contentView).subviews) {
            [subview removeFromSuperview];
        }
    }
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.frame = CGRectZero;
    }
    cell.backgroundColor = [UIColor blackColor];
    // Set up the cell...
    //    if (tableView == salesIdTable) {
    
    //        cell.textLabel.text = [filteredSkuArrayList objectAtIndex:indexPath.row];
    //        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    //            cell.textLabel.font = [UIFont boldSystemFontOfSize:25];
    //        }
    //        else{
    //            cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
    //        }
    //
    //    }
    if(tableView == salesDetailsTable){
        
        @try {
            NSDictionary *detailsDic = salesDetailsArray[indexPath.row];
            
            UILabel *snoLbl = [[UILabel alloc] init] ;
            snoLbl.font = [UIFont systemFontOfSize:13.0];
            snoLbl.layer.borderWidth = 1.5;
            snoLbl.backgroundColor = [UIColor blackColor];
            snoLbl.textAlignment = NSTextAlignmentCenter;
            snoLbl.numberOfLines = 2;
            snoLbl.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            snoLbl.lineBreakMode = NSLineBreakByWordWrapping;
            snoLbl.textColor = [UIColor whiteColor];
            snoLbl.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
            
            UILabel *codeLbl = [[UILabel alloc] init] ;
            codeLbl.font = [UIFont systemFontOfSize:13.0];
            codeLbl.layer.borderWidth = 1.5;
            codeLbl.backgroundColor = [UIColor blackColor];
            codeLbl.textAlignment = NSTextAlignmentCenter;
            codeLbl.numberOfLines = 2;
            codeLbl.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            codeLbl.lineBreakMode = NSLineBreakByWordWrapping;
            codeLbl.textColor = [UIColor whiteColor];
            codeLbl.text = [detailsDic valueForKey:@"verification_code"];
            
            UILabel *skuidLbl = [[UILabel alloc] init] ;
            skuidLbl.font = [UIFont systemFontOfSize:13.0];
            skuidLbl.layer.borderWidth = 1.5;
            skuidLbl.backgroundColor = [UIColor blackColor];
            skuidLbl.textColor = [UIColor whiteColor];
            skuidLbl.textAlignment = NSTextAlignmentCenter;
            skuidLbl.numberOfLines = 2;
            skuidLbl.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            skuidLbl.lineBreakMode = NSLineBreakByWordWrapping;
            skuidLbl.text = [NSString stringWithFormat:@"%@",[detailsDic valueForKey:@"sku_id"]];
            
            UILabel *itemName = [[UILabel alloc] init] ;
            itemName.font = [UIFont systemFontOfSize:13.0];
            itemName.layer.borderWidth = 1.5;
            itemName.backgroundColor = [UIColor blackColor];
            itemName.textColor = [UIColor whiteColor];
            itemName.textAlignment = NSTextAlignmentCenter;
            itemName.numberOfLines = 2;
            itemName.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            itemName.textAlignment = NSTextAlignmentCenter;
            if ([[detailsDic valueForKey:@"pluCode"] isKindOfClass:[NSNull class]] || [detailsDic valueForKey:@"pluCode"] == nil) {
                itemName.text = @"--";
            }
            else{
                
                itemName.text = [NSString stringWithFormat:@"%@",[detailsDic valueForKey:@"pluCode"]];
            }
            
            UILabel *dateLbl = [[UILabel alloc] init] ;
            dateLbl.font = [UIFont systemFontOfSize:13.0];
            dateLbl.layer.borderWidth = 1.5;
            dateLbl.backgroundColor = [UIColor blackColor];
            dateLbl.textColor = [UIColor whiteColor];
            dateLbl.textAlignment = NSTextAlignmentCenter;
            dateLbl.numberOfLines = 2;
            dateLbl.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            dateLbl.textAlignment = NSTextAlignmentCenter;
            if ([[detailsDic valueForKey:@"skuDescription"] isKindOfClass:[NSNull class]] || [detailsDic valueForKey:@"skuDescription"] == nil) {
                dateLbl.text = @"--";
            }
            else{
                
                dateLbl.text = [NSString stringWithFormat:@"%@",[detailsDic valueForKey:@"skuDescription"]];
            }
            
            UILabel *bookQtyLbl = [[UILabel alloc] init] ;
            bookQtyLbl.font = [UIFont systemFontOfSize:13.0];
            bookQtyLbl.layer.borderWidth = 1.5;
            bookQtyLbl.backgroundColor = [UIColor blackColor];
            bookQtyLbl.textColor = [UIColor whiteColor];
            bookQtyLbl.textAlignment = NSTextAlignmentCenter;
            bookQtyLbl.numberOfLines = 2;
            bookQtyLbl.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            bookQtyLbl.textAlignment = NSTextAlignmentCenter;
            bookQtyLbl.text = [NSString stringWithFormat:@"%@",[detailsDic valueForKey:@"loss_type"]];
            
            UILabel *verifyQtyLbl = [[UILabel alloc] init] ;
            verifyQtyLbl.font = [UIFont systemFontOfSize:13.0];
            verifyQtyLbl.layer.borderWidth = 1.5;
            verifyQtyLbl.backgroundColor = [UIColor blackColor];
            verifyQtyLbl.textColor = [UIColor whiteColor];
            verifyQtyLbl.textAlignment = NSTextAlignmentCenter;
            verifyQtyLbl.numberOfLines = 2;
            verifyQtyLbl.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            verifyQtyLbl.textAlignment = NSTextAlignmentCenter;
            if ([[detailsDic valueForKey:@"skuCostPrice"] isKindOfClass:[NSNull class]] || [detailsDic valueForKey:@"skuCostPrice"] == nil) {
                verifyQtyLbl.text = @"--";
            }
            else {
                verifyQtyLbl.text = [NSString stringWithFormat:@"%.2f",[[detailsDic valueForKey:@"skuCostPrice"] floatValue]];
            }
            UILabel *stockLoss = [[UILabel alloc] init] ;
            stockLoss.font = [UIFont systemFontOfSize:13.0];
            stockLoss.layer.borderWidth = 1.5;
            stockLoss.backgroundColor = [UIColor blackColor];
            stockLoss.textColor = [UIColor whiteColor];
            stockLoss.textAlignment = NSTextAlignmentCenter;
            stockLoss.numberOfLines = 2;
            stockLoss.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            stockLoss.textAlignment = NSTextAlignmentCenter;
            if ([[detailsDic valueForKey:@"skuMrp"] isKindOfClass:[NSNull class]] || [detailsDic valueForKey:@"skuMrp"] == nil) {
                stockLoss.text = @"--";
            }
            else {
                stockLoss.text = [NSString stringWithFormat:@"%.2f",[[detailsDic valueForKey:@"skuMrp"] floatValue]];
            }
            
            UILabel *lossType = [[UILabel alloc] init] ;
            lossType.font = [UIFont systemFontOfSize:13.0];
            lossType.layer.borderWidth = 1.5;
            lossType.backgroundColor = [UIColor blackColor];
            lossType.textColor = [UIColor whiteColor];
            lossType.textAlignment = NSTextAlignmentCenter;
            lossType.numberOfLines = 2;
            lossType.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            lossType.textAlignment = NSTextAlignmentCenter;
            if ([[detailsDic valueForKey:@"skuSalePrice"] isKindOfClass:[NSNull class]] || [detailsDic valueForKey:@"skuSalePrice"] == nil) {
                lossType.text = @"--";
            }
            else {
                lossType.text = [NSString stringWithFormat:@"%.2f",[[detailsDic valueForKey:@"skuSalePrice"] floatValue]];
            }
            
            UILabel *lossType1 = [[UILabel alloc] init] ;
            lossType1.font = [UIFont systemFontOfSize:13.0];
            lossType1.layer.borderWidth = 1.5;
            lossType1.backgroundColor = [UIColor blackColor];
            lossType1.textColor = [UIColor whiteColor];
            lossType1.textAlignment = NSTextAlignmentCenter;
            lossType1.numberOfLines = 2;
            lossType1.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            lossType1.textAlignment = NSTextAlignmentCenter;
            
            if ([[detailsDic valueForKey:@"sku_book_stock"] isKindOfClass:[NSNull class]] || [detailsDic valueForKey:@"sku_book_stock"] == nil) {
                lossType.text = @"--";
            }
            else {
                lossType1.text = [NSString stringWithFormat:@"%.2f",[[detailsDic valueForKey:@"sku_book_stock"] floatValue]];
            }
            
            
            UILabel *lossType2 = [[UILabel alloc] init] ;
            lossType2.font = [UIFont systemFontOfSize:13.0];
            lossType2.layer.borderWidth = 1.5;
            lossType2.backgroundColor = [UIColor blackColor];
            lossType2.textColor = [UIColor whiteColor];
            lossType2.textAlignment = NSTextAlignmentCenter;
            lossType2.numberOfLines = 2;
            lossType2.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            lossType2.textAlignment = NSTextAlignmentCenter;
            lossType2.text = [NSString stringWithFormat:@"%.2f",[[detailsDic valueForKey:@"product_physical_stock"] floatValue]];
            
            UILabel *lossType3 = [[UILabel alloc] init] ;
            lossType3.font = [UIFont systemFontOfSize:13.0];
            lossType3.layer.borderWidth = 1.5;
            lossType3.backgroundColor = [UIColor blackColor];
            lossType3.textColor = [UIColor whiteColor];
            lossType3.textAlignment = NSTextAlignmentCenter;
            lossType3.numberOfLines = 2;
            lossType3.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            lossType3.textAlignment = NSTextAlignmentCenter;
            if ([[detailsDic valueForKey:@"costPriceValue"] isKindOfClass:[NSNull class]] || [detailsDic valueForKey:@"costPriceValue"] == nil) {
                lossType3.text = @"--";
            }
            else {
                lossType3.text = [NSString stringWithFormat:@"%.2f",[[detailsDic valueForKey:@"costPriceValue"] floatValue]];
            }
            
            UILabel *lossType4 = [[UILabel alloc] init] ;
            lossType4.font = [UIFont systemFontOfSize:13.0];
            lossType4.layer.borderWidth = 1.5;
            lossType4.backgroundColor = [UIColor blackColor];
            lossType4.textColor = [UIColor whiteColor];
            lossType4.textAlignment = NSTextAlignmentCenter;
            lossType4.numberOfLines = 2;
            lossType4.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            lossType4.textAlignment = NSTextAlignmentCenter;
            if ([[detailsDic valueForKey:@"mrpValue"] isKindOfClass:[NSNull class]] || [detailsDic valueForKey:@"mrpValue"] == nil) {
                lossType4.text = @"--";
            }
            else {
                
                lossType4.text = [NSString stringWithFormat:@"%.2f",[[detailsDic valueForKey:@"mrpValue"] floatValue]];
            }
            
            UILabel *lossType5 = [[UILabel alloc] init] ;
            lossType5.font = [UIFont systemFontOfSize:13.0];
            lossType5.layer.borderWidth = 1.5;
            lossType5.backgroundColor = [UIColor blackColor];
            lossType5.textColor = [UIColor whiteColor];
            lossType5.textAlignment = NSTextAlignmentCenter;
            lossType5.numberOfLines = 2;
            lossType5.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            lossType5.textAlignment = NSTextAlignmentCenter;
            if ([[detailsDic valueForKey:@"salePriceValue"] isKindOfClass:[NSNull class]] || [detailsDic valueForKey:@"salePriceValue"] == nil) {
                lossType5.text = @"--";
            }
            else{
                lossType5.text = [NSString stringWithFormat:@"%.2f",[[detailsDic valueForKey:@"salePriceValue"] floatValue]];
            }
            
            UILabel *lossType6 = [[UILabel alloc] init] ;
            lossType6.font = [UIFont systemFontOfSize:13.0];
            lossType6.layer.borderWidth = 1.5;
            lossType6.backgroundColor = [UIColor blackColor];
            lossType6.textColor = [UIColor whiteColor];
            lossType6.textAlignment = NSTextAlignmentCenter;
            lossType6.numberOfLines = 2;
            lossType6.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            lossType6.textAlignment = NSTextAlignmentCenter;
            lossType6.text = [NSString stringWithFormat:@"%.2f",[[detailsDic valueForKey:@"stock_loss"] floatValue]];
            
            UILabel *lossType7 = [[UILabel alloc] init] ;
            lossType7.font = [UIFont systemFontOfSize:13.0];
            lossType7.layer.borderWidth = 1.5;
            lossType7.backgroundColor = [UIColor blackColor];
            lossType7.textColor = [UIColor whiteColor];
            lossType7.textAlignment = NSTextAlignmentCenter;
            lossType7.numberOfLines = 2;
            lossType7.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            lossType7.textAlignment = NSTextAlignmentCenter;
            if ([[detailsDic valueForKey:@"costPriceVariance"] isKindOfClass:[NSNull class]] || [detailsDic valueForKey:@"costPriceVariance"] == nil) {
                lossType7.text = @"--";
                
            }
            else{
                lossType7.text = [NSString stringWithFormat:@"%.2f",[[detailsDic valueForKey:@"costPriceVariance"] floatValue]];
                
            }
            
            UILabel *lossType8 = [[UILabel alloc] init] ;
            lossType8.font = [UIFont systemFontOfSize:13.0];
            lossType8.layer.borderWidth = 1.5;
            lossType8.backgroundColor = [UIColor blackColor];
            lossType8.textColor = [UIColor whiteColor];
            lossType8.textAlignment = NSTextAlignmentCenter;
            lossType8.numberOfLines = 2;
            lossType8.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            lossType8.textAlignment = NSTextAlignmentCenter;
            if ([[detailsDic valueForKey:@"mrpVariance"] isKindOfClass:[NSNull class]] || [detailsDic valueForKey:@"mrpVariance"] == nil) {
                lossType8.text = @"--";
            }
            else{
                
                lossType8.text = [NSString stringWithFormat:@"%.2f",[[detailsDic valueForKey:@"mrpVariance"] floatValue]];
            }
            
            UILabel *lossType9 = [[UILabel alloc] init] ;
            lossType9.font = [UIFont systemFontOfSize:13.0];
            lossType9.layer.borderWidth = 1.5;
            lossType9.backgroundColor = [UIColor blackColor];
            lossType9.textColor = [UIColor whiteColor];
            lossType9.textAlignment = NSTextAlignmentCenter;
            lossType9.numberOfLines = 2;
            lossType9.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.2].CGColor;
            lossType9.textAlignment = NSTextAlignmentCenter;
            if ([[detailsDic valueForKey:@"salePriceVariance"] isKindOfClass:[NSNull class]] || [detailsDic valueForKey:@"salePriceVariance"] == nil) {
                lossType9.text = @"--";
            }
            else {
                
                lossType9.text = [NSString stringWithFormat:@"%.2f",[[detailsDic valueForKey:@"salePriceVariance"] floatValue]];
            }
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                snoLbl.font = [UIFont systemFontOfSize:18];
                snoLbl.frame = CGRectMake(10, 0, 80.0, 40.0);
                
                codeLbl.font = [UIFont systemFontOfSize:18];
                codeLbl.frame = CGRectMake(100, 0, 160, 40.0);
                
                skuidLbl.font = [UIFont systemFontOfSize:18];
                skuidLbl.frame = CGRectMake((codeLbl.frame.origin.x + codeLbl.frame.size.width ), 0, 100.0, 40);
                itemName.font = [UIFont systemFontOfSize:18];
                itemName.frame = CGRectMake((skuidLbl.frame.origin.x + skuidLbl.frame.size.width ), 0, 120.0, 40);
                dateLbl.font = [UIFont systemFontOfSize:18];
                dateLbl.frame = CGRectMake((itemName.frame.origin.x + itemName.frame.size.width ), 0, 150.0, 40);
                verifyQtyLbl.font = [UIFont systemFontOfSize:18];
                verifyQtyLbl.frame = CGRectMake((dateLbl.frame.origin.x + dateLbl.frame.size.width ), 0, 130.0, 40);
                stockLoss.font = [UIFont systemFontOfSize:18];
                stockLoss.frame = CGRectMake((verifyQtyLbl.frame.origin.x + verifyQtyLbl.frame.size.width ), 0, 140, 40);
                lossType.font = [UIFont systemFontOfSize:18];
                lossType.frame = CGRectMake((stockLoss.frame.origin.x + stockLoss.frame.size.width ), 0, 130.0, 40);
                lossType1.font = [UIFont systemFontOfSize:18];
                lossType1.frame = CGRectMake((lossType.frame.origin.x + lossType.frame.size.width ), 0, 130, 40);
                lossType2.font = [UIFont systemFontOfSize:18];
                lossType2.frame = CGRectMake((lossType1.frame.origin.x + lossType1.frame.size.width ), 0, 130, 40);
                lossType3.font = [UIFont systemFontOfSize:18];
                lossType3.frame = CGRectMake((lossType2.frame.origin.x + lossType2.frame.size.width ), 0, 130, 40);
                lossType4.font = [UIFont systemFontOfSize:18];
                lossType4.frame = CGRectMake((lossType3.frame.origin.x + lossType3.frame.size.width ), 0, 130, 40);
                lossType5.font = [UIFont systemFontOfSize:18];
                lossType5.frame = CGRectMake((lossType4.frame.origin.x + lossType4.frame.size.width ), 0, 130, 40);
                lossType6.font = [UIFont systemFontOfSize:18];
                lossType6.frame = CGRectMake((lossType5.frame.origin.x + lossType5.frame.size.width ), 0, 130, 40);
                bookQtyLbl.font = [UIFont systemFontOfSize:18];
                bookQtyLbl.frame = CGRectMake((lossType6.frame.origin.x + lossType6.frame.size.width ), 0, 130, 40);
                lossType7.font = [UIFont systemFontOfSize:18];
                lossType7.frame = CGRectMake((bookQtyLbl.frame.origin.x + bookQtyLbl.frame.size.width ), 0, 130, 40);
                lossType8.font = [UIFont systemFontOfSize:18];
                lossType8.frame = CGRectMake((lossType7.frame.origin.x + lossType7.frame.size.width ), 0, 130,40);
                lossType9.font = [UIFont systemFontOfSize:18];
                lossType9.frame = CGRectMake((lossType8.frame.origin.x + lossType8.frame.size.width ), 0, 130,40);
            }
            else {
                snoLbl.frame = CGRectMake(0, 0, 80, 30);
                snoLbl.font = [UIFont systemFontOfSize:12];
                skuidLbl.frame = CGRectMake(85, 0, 80, 30);
                skuidLbl.font = [UIFont systemFontOfSize:12];
                itemName.frame = CGRectMake(170, 0, 100, 30);
                itemName.font = [UIFont systemFontOfSize:12];
                dateLbl.font = [UIFont systemFontOfSize:12];
                dateLbl.frame = CGRectMake(275.0, 0, 130.0, 30);
                bookQtyLbl.font = [UIFont systemFontOfSize:12];
                bookQtyLbl.frame = CGRectMake(410.0, 0, 120.0, 30);
                verifyQtyLbl.font = [UIFont systemFontOfSize:12];
                verifyQtyLbl.frame = CGRectMake(535.0, 0, 120.0, 30);
                stockLoss.font = [UIFont systemFontOfSize:12];
                stockLoss.frame = CGRectMake(660.0, 0, 120.0, 30);
                lossType.font = [UIFont systemFontOfSize:12];
                lossType.frame = CGRectMake(785.0, 0, 120.0, 30);
                
            }
            //            NSString *str = [NSString stringWithFormat:@"%@#%@#%@#%@#%@#%@",label1.text,label2.text,label3.text,label4.text,label5.text,[tempArrayItems objectAtIndex:(indexPath.row*5)+1]];
            //            [cartItem addObject:str];
            
            [cell.contentView addSubview:snoLbl];
            [cell.contentView addSubview:codeLbl];
            [cell.contentView addSubview:skuidLbl];
            [cell.contentView addSubview:itemName];
            [cell.contentView addSubview:dateLbl];
            [cell.contentView addSubview:bookQtyLbl];
            [cell.contentView addSubview:verifyQtyLbl];
            [cell.contentView addSubview:stockLoss];
            [cell.contentView addSubview:lossType];
            [cell.contentView addSubview:lossType1];
            [cell.contentView addSubview:lossType2];
            [cell.contentView addSubview:lossType3];
            [cell.contentView addSubview:lossType4];
            [cell.contentView addSubview:lossType5];
            [cell.contentView addSubview:lossType6];
            [cell.contentView addSubview:lossType7];
            [cell.contentView addSubview:lossType8];
            [cell.contentView addSubview:lossType9];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
        }
        @finally {
            
        }
        
    }
    else if (tableView == searchCriteriaTbl) {
        
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
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:25];
            }
        }
        @try {
            
            hlcell.textLabel.text = searchOptionsArr[indexPath.row];
            //[hlcell setBackgroundColor:[UIColor blackColor]];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellEditingStyleNone;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                hlcell.textLabel.font = [UIFont systemFontOfSize:18.0];
            }
            else {
                hlcell.textLabel.font = [UIFont systemFontOfSize:12.0];
            }
            
        }
        @catch (NSException *exception) {
            
            NSLog(@"%@",exception);
        }
        
        return hlcell;
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    
    
    // cell background color...
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == searchCriteriaTbl) {
        
        [catPopOver dismissPopoverAnimated:YES];
        
        searchCriteria.text = [NSString stringWithFormat:@"%@",searchOptionsArr[indexPath.row]];
        
        
    }
    
    
}



/**
 * @description     writes off the stock verification
 * @date            21/7/16
 * @method          doStockWriteOff
 * @author          Sonali
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 * @modified On
 * @modified By
 * @modified reason
 */

-(void)doStockWriteOff {
    
    [HUD setHidden:NO];
    
    @try {
        
        [HUD setHidden:NO];
        
        NSDictionary *reqDic = @{REQUEST_HEADER: [RequestHeader getRequestHeader],@"location": presentLocation,@"startIndex": @"-1",@"verification_code": verficationCodeStr};
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
        NSString * getCodeJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:STOCK_WRITE_OFF];
        serviceUrl = [NSString stringWithFormat:@"%@",serviceUrl];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                            timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        //        [request setValue:[NSString stringWithFormat:@"%d",[[serviceUrl dataUsingEncoding:NSUTF8StringEncoding] length]] forKey:@"Content-Length"];
        request.HTTPBody = jsonData;
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *billingResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                 options:0
                                                                                   error:NULL];
                 if (![[billingResponse valueForKey:RESPONSE_HEADER]isKindOfClass:[NSNull class]] &&[[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [HUD setHidden:YES];
                     
                     sucess = [[UIAlertView alloc] initWithTitle:@"Stock Updated Successfully" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [sucess show];
                 }
                 else {
                     [HUD setHidden:YES];
                     
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alert show];
                     
                 }
             }
             else {
                 [HUD setHidden:YES];
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:connectionError.localizedDescription message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alert show];
             }
         }];
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
        [HUD setHidden:YES];
    }
    @finally {
    }
}

-(void)closeVerification {
    
    [HUD setHidden:NO];
    
    @try {
        
        [HUD setHidden:NO];
        
        NSDictionary *reqDic = @{REQUEST_HEADER: [RequestHeader getRequestHeader],@"location": presentLocation,@"verification_code": verficationCodeStr,@"status": @"Closed"};
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
        NSString * getCodeJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:CLOSE_STOCK_VERIFICATION];
        serviceUrl = [NSString stringWithFormat:@"%@",serviceUrl];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                            timeoutInterval:60.0];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        //        [request setValue:[NSString stringWithFormat:@"%d",[[serviceUrl dataUsingEncoding:NSUTF8StringEncoding] length]] forKey:@"Content-Length"];
        request.HTTPBody = jsonData;
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *billingResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                 options:0
                                                                                   error:NULL];
                 if (![[billingResponse valueForKey:RESPONSE_HEADER]isKindOfClass:[NSNull class]] &&[[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [HUD setHidden:YES];
                     
                     sucess = [[UIAlertView alloc] initWithTitle:@"Verification closed successfully" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [sucess show];
                 }
                 else {
                     [HUD setHidden:YES];
                     
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[[billingResponse valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alert show];
                     
                 }
             }
             else {
                 [HUD setHidden:YES];
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:connectionError.localizedDescription message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alert show];
             }
         }];
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
        [HUD setHidden:YES];
    }
    @finally {
    }
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (alertView == sucess) {
        
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:NO];
        }
    }
    
    //added  by Srinivasulu on 20/04/2017....
    else if(alertView == offlineModeAlert){
        
        [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
        
        [self changeOperationMode:buttonIndex];
        //[super alertView:alertView didDismissWithButtonIndex:buttonIndex_];
    }
    
    else if (alertView == uploadConfirmationAlert)
    {
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
        
        
        
        [self syncOfflinebillsToOnline:buttonIndex];
        
        
    }
    //upto here on 28/04/2017...

}

/**
 * @description     <#description#>
 * @date            <#date#>
 * @method          <#name#>
 * @author           Sonali
 * @param           <#param#>
 * @param           <#param#>
 * @return          <#return#>
 * @verified By     <#veridied by#>
 * @verified On     <#verified On#>
 * @modified On     <#modified On#>
 * @modified By     <#modified By#>
 * @modified reason  <#reason#>
 */

-(void)getListOfOptions:(UIButton *)sender {
    
    AudioServicesPlaySystemSound(soundFileObject);
    
    //    [self removeSideMenu];
    
    PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, searchCriteria.frame.size.width,200)];
    customView.opaque = NO;
    customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    customView.layer.borderWidth = 2.0f;
    [customView setHidden:NO];
    
    searchCriteriaTbl = [[UITableView alloc] init];
    searchCriteriaTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    searchCriteriaTbl.dataSource = self;
    searchCriteriaTbl.delegate = self;
    (searchCriteriaTbl.layer).borderWidth = 1.0f;
    searchCriteriaTbl.layer.cornerRadius = 3;
    searchCriteriaTbl.layer.borderColor = [UIColor grayColor].CGColor;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        searchCriteriaTbl.frame = CGRectMake(0, 0, customView.frame.size.width, customView.frame.size.height);
        
        
    }
    
    [customView addSubview:searchCriteriaTbl];
    
    customerInfoPopUp.view = customView;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        
        [popover presentPopoverFromRect:searchCriteria.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:NO];
        
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
    
    [searchCriteriaTbl reloadData];
    
    
}

-(void)searchTableView:(UIButton*)sender {
    @try {
        
        [HUD setHidden:NO];
        
        NSDictionary *reqDic = @{REQUEST_HEADER: [RequestHeader getRequestHeader],@"location": presentLocation,@"startIndex": @"-1",@"verification_code": verficationCodeStr,@"searchCriteria": searchTxt.text};
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
        NSString * getCodeJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        NSString *serviceUrl = [WebServiceUtility getURLFor:SEARCH_VERIFICATION_ITEMS];
        serviceUrl = [NSString stringWithFormat:@"%@%@",serviceUrl,getCodeJsonString];
        serviceUrl = [WebServiceUtility addPercentEscapesFor:serviceUrl];
        
        NSURL *url = [NSURL URLWithString:serviceUrl];
        NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                            timeoutInterval:60.0];
        request.HTTPMethod = @"GET";
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:0
                                                                            error:NULL];
                 if (![[response valueForKey:RESPONSE_HEADER]isKindOfClass:[NSNull class]] &&[[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue]==0) {
                     
                     [HUD setHidden:YES];
                     
                     salesDetailsArray = [NSMutableArray new];
                     
                     salesDetailsArray = [[response valueForKey:@"itemsList"] mutableCopy];
                     
                     
                     if (salesDetailsArray.count) {
                         
                         [salesDetailsTable reloadData];
                     }
                     
                 }
                 else {
                     [HUD setHidden:YES];
                     
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[[response valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alert show];
                     
                 }
             }
             else {
                 [HUD setHidden:YES];
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:connectionError.localizedDescription message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alert show];
             }
         }];
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    
}

-(void)goToHome {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)textFieldDidChange:(UITextField *)textField {
    if(textField == searchTxt) {
        
        if ((textField.text).length == 0) {
            
            [self getVerifiedStockDetails];
        }
    }
}

@end
