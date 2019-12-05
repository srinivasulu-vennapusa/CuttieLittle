//
//  SuppliesReports.m
//  OmniRetailer
//
//  Created by Sonali Maharana on 24/02/17.
//
//

#import "SuppliesReports.h"

@interface SuppliesReports ()

@end

@implementation SuppliesReports

@synthesize fromOrder,toOrder,bill,salesTableView;
@synthesize soundFileURLRef,soundFileObject;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) goHomePage {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    //[self.navigationController popViewControllerAnimated:YES];
    [UIView  transitionWithView:self.navigationController.view duration:0.8  options:UIViewAnimationOptionTransitionFlipFromRight
                     animations:^(void) {
                         BOOL oldState = [UIView areAnimationsEnabled];
                         [UIView setAnimationsEnabled:NO];
                         [self.navigationController popViewControllerAnimated:YES];
                         [UIView setAnimationsEnabled:oldState];
                     }
                     completion:nil];
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    version = [UIDevice currentDevice].systemVersion.floatValue;
    
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
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
    
    HUD.labelText = @"Please Wait..";
    
    self.navigationController.navigationBarHidden = NO;
    
    self.titleLabel.text = NSLocalizedString(@"supplies-report", nil);
    
    //main view bakgroung setting...
    self.view.backgroundColor = [UIColor blackColor];
    
    
    /** TextFields Design*/
    
    
    dateArr = [[NSMutableArray alloc] init];
    totalBillArr = [[NSMutableArray alloc]init];
    counterIdArr = [[NSMutableArray alloc]init];
    cardTotal = [[NSMutableArray alloc] init];
    discount = [[NSMutableArray alloc] init];
    
    fromOrder = [[UITextField alloc] init];
    fromOrder.borderStyle = UITextBorderStyleRoundedRect;
    fromOrder.textColor = [UIColor blackColor];
    fromOrder.placeholder = @"from";  //place holder
    fromOrder.backgroundColor = [UIColor whiteColor];
    fromOrder.autocorrectionType = UITextAutocorrectionTypeNo;
    fromOrder.keyboardType = UIKeyboardTypeDefault;
    fromOrder.returnKeyType = UIReturnKeyDone;
    fromOrder.clearButtonMode = UITextFieldViewModeWhileEditing;
    fromOrder.userInteractionEnabled = NO;
    fromOrder.delegate = self;
    fromOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    UIImage *buttonImageDD = [UIImage imageNamed:@"Calandar_Icon.png"];
    [fromOrderButton setBackgroundImage:buttonImageDD forState:UIControlStateNormal];
    [fromOrderButton addTarget:self
                        action:@selector(DateButtonPressed:) forControlEvents:UIControlEventTouchDown];
    fromOrderButton.tag = 2;
    
    /** Design of Go Button*/
    getReportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [getReportBtn addTarget:self action:@selector(goButtonClicked) forControlEvents:UIControlEventTouchDown];
    [getReportBtn setTitle:@"GO" forState:UIControlStateNormal];
    getReportBtn.backgroundColor = [UIColor grayColor];
    getReportBtn.layer.cornerRadius=14;
    getReportBtn.layer.masksToBounds=YES;
    
    
    selectCounter = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImageDD2 = [UIImage imageNamed:@"combo.png"];
    [selectCounter setBackgroundImage:buttonImageDD2 forState:UIControlStateNormal];
    [selectCounter addTarget:self
                      action:@selector(selectCounter:) forControlEvents:UIControlEventTouchDown];
    selectCounter.tag = 1;
    counterId.delegate = self;
    
    
    toOrder = [[UITextField alloc] init];
    toOrder.borderStyle = UITextBorderStyleRoundedRect;
    toOrder.textColor = [UIColor blackColor];
    toOrder.placeholder = @"to";  //place holder
    toOrder.text = @"";
    toOrder.backgroundColor = [UIColor whiteColor];
    toOrder.autocorrectionType = UITextAutocorrectionTypeNo;
    toOrder.keyboardType = UIKeyboardTypeDefault;
    toOrder.returnKeyType = UIReturnKeyDone;
    toOrder.clearButtonMode = UITextFieldViewModeWhileEditing;
    toOrder.userInteractionEnabled = NO;
    toOrder.delegate = self;
    
    
    toOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImageDD1 = [UIImage imageNamed:@"Calandar_Icon.png"];
    [toOrderButton setBackgroundImage:buttonImageDD1 forState:UIControlStateNormal];
    [toOrderButton addTarget:self
                      action:@selector(DateButtonPressed:) forControlEvents:UIControlEventTouchDown];
    fromOrderButton.tag = 2;
    fromOrder.delegate = self;
    
    // taglabel initialization..
    tag = [[UILabel alloc] init];
    
    
    counterId = [[UITextField alloc] init];
    counterId.borderStyle = UITextBorderStyleRoundedRect;
    counterId.textColor = [UIColor blackColor];
    counterId.placeholder = @"Counter Id";  //place holder
    counterId.backgroundColor = [UIColor whiteColor];
    counterId.autocorrectionType = UITextAutocorrectionTypeNo;
    counterId.keyboardType = UIKeyboardTypeDefault;
    counterId.returnKeyType = UIReturnKeyDone;
    counterId.clearButtonMode = UITextFieldViewModeWhileEditing;
    UIToolbar* numberToolbar1 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar1.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar1.items = @[[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar1 sizeToFit];
    counterId.inputAccessoryView = numberToolbar1;
    counterId.keyboardType = UIKeyboardTypeNumberPad;
    counterId.delegate = self;
    counterId.text = counterName;
    
    
    searchCriterialable = [[UILabel alloc] init];
    searchCriterialable.text = @" # # ";
    
    
    /** Design of Go Button*/
    goButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [goButton addTarget:self action:@selector(gobuttonPressed:) forControlEvents:UIControlEventTouchDown];
    [goButton setTitle:@"PRINT" forState:UIControlStateNormal];
    goButton.backgroundColor = [UIColor grayColor];
    
    
    /** UIScrollView Design */
    scrollView = [[UIScrollView alloc] init];
    scrollView.bounces =FALSE;
    //scrollView.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *borderLine = [[UILabel alloc] init];
    borderLine.text = @"";
    borderLine.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    
    cashTotalVal = [[UILabel alloc] init];
    cashTotalVal.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    cashTotalVal.backgroundColor = [UIColor clearColor];
    cashTotalVal.textAlignment = NSTextAlignmentCenter;
    
    cardTotalVal = [[UILabel alloc] init];
    cardTotalVal.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    cardTotalVal.backgroundColor = [UIColor clearColor];
    cardTotalVal.textAlignment = NSTextAlignmentCenter;
    
    sodexoTotalVal = [[UILabel alloc] init];
    sodexoTotalVal.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    sodexoTotalVal.backgroundColor = [UIColor clearColor];
    sodexoTotalVal.textAlignment = NSTextAlignmentCenter;
    
    ticketTotalVal = [[UILabel alloc] init];
    ticketTotalVal.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    ticketTotalVal.backgroundColor = [UIColor clearColor];
    ticketTotalVal.textAlignment = NSTextAlignmentCenter;
    
    loyaltyTotalVal = [[UILabel alloc] init];
    loyaltyTotalVal.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    loyaltyTotalVal.backgroundColor = [UIColor clearColor];
    loyaltyTotalVal.textAlignment = NSTextAlignmentCenter;
    
    discountTotalVal = [[UILabel alloc] init];
    discountTotalVal.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    discountTotalVal.backgroundColor = [UIColor clearColor];
    discountTotalVal.textAlignment = NSTextAlignmentCenter;
    
    totalBillAmtVal = [[UILabel alloc] init];
    totalBillAmtVal.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    totalBillAmtVal.backgroundColor = [UIColor clearColor];
    totalBillAmtVal.textAlignment = NSTextAlignmentCenter;
    
    
    /** Table Headers Design*/
    sNo = [[UILabel alloc] init];
    sNo.backgroundColor = [UIColor clearColor];
    sNo.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    sNo.text = @"S No";
    sNo.textAlignment = NSTextAlignmentCenter;
    sNo.textColor = [UIColor whiteColor];
    sNo.layer.cornerRadius = 14;
    sNo.layer.masksToBounds = YES;
    
    
    billedOn = [[UILabel alloc] init];
    billedOn.backgroundColor = [UIColor clearColor];
    billedOn.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    billedOn.text = @"Date";
    billedOn.textAlignment = NSTextAlignmentCenter;
    billedOn.textColor = [UIColor whiteColor];
    billedOn.layer.cornerRadius = 14;
    billedOn.layer.masksToBounds = YES;
    
    
    
    
    transactions = [[UILabel alloc] init];
    transactions.backgroundColor = [UIColor clearColor];
    transactions.text = @"Item Code";
    transactions.numberOfLines = 2;
    transactions.lineBreakMode = NSLineBreakByWordWrapping;
    transactions.textAlignment = NSTextAlignmentLeft;
    transactions.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    transactions.textAlignment = NSTextAlignmentCenter;
    transactions.textColor = [UIColor whiteColor];
    transactions.layer.cornerRadius = 14;
    transactions.layer.masksToBounds = YES;
    
    
    
    totalBillAmount = [[UILabel alloc] init];
    totalBillAmount.backgroundColor = [UIColor clearColor];
    totalBillAmount.text = @"Item Desc";
    totalBillAmount.numberOfLines = 2;
    totalBillAmount.lineBreakMode = NSLineBreakByWordWrapping;
    totalBillAmount.textAlignment = NSTextAlignmentLeft;
    totalBillAmount.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    totalBillAmount.textAlignment = NSTextAlignmentCenter;
    totalBillAmount.textColor = [UIColor whiteColor];
    totalBillAmount.layer.cornerRadius = 14;
    totalBillAmount.layer.masksToBounds = YES;
    
    
    
    paidAmount = [[UILabel alloc] init];
    paidAmount.backgroundColor = [UIColor clearColor];
    paidAmount.text = @"Supplied Qty";
    paidAmount.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    paidAmount.textAlignment = NSTextAlignmentCenter;
    paidAmount.textColor = [UIColor whiteColor];
    paidAmount.layer.cornerRadius = 14;
    paidAmount.layer.masksToBounds = YES;
    
    
    
    amountDue = [[UILabel alloc] init];
    amountDue.backgroundColor = [UIColor clearColor];
    amountDue.text = @"Received Qty";
    amountDue.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    amountDue.textAlignment = NSTextAlignmentCenter;
    amountDue.textColor = [UIColor whiteColor];
    amountDue.layer.cornerRadius = 14;
    amountDue.layer.masksToBounds = YES;
    
    
    totalCashAmt = [[UILabel alloc] init];
    totalCashAmt.backgroundColor = [UIColor clearColor];
    totalCashAmt.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    totalCashAmt.text = @"Unit Price";
    totalCashAmt.textAlignment = NSTextAlignmentCenter;
    totalCashAmt.textColor = [UIColor whiteColor];
    totalCashAmt.layer.cornerRadius = 14;
    totalCashAmt.layer.masksToBounds = YES;
    
    
    ticketAmtLbl = [[UILabel alloc] init];
    ticketAmtLbl.backgroundColor = [UIColor clearColor];
    ticketAmtLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    ticketAmtLbl.text = @"Total Sale";
    ticketAmtLbl.textAlignment = NSTextAlignmentCenter;
    ticketAmtLbl.textColor = [UIColor whiteColor];
    ticketAmtLbl.layer.cornerRadius = 14;
    ticketAmtLbl.layer.masksToBounds = YES;
    
    
    
    /** Create TableView */
    salesTableView = [[UITableView alloc]init];
    salesTableView.backgroundColor = [UIColor clearColor];
    salesTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    salesTableView.dataSource = self;
    salesTableView.delegate = self;
    salesTableView.bounces = FALSE;
    salesTableView.separatorColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2f];
    
    
    //creating the skuWiseReportView which will displayed completed Screen.......
    dateWiseReportView = [[UIView alloc] init];
    dateWiseReportView.backgroundColor = [UIColor blackColor];
    dateWiseReportView.layer.borderWidth = 1.0f;
    dateWiseReportView.layer.cornerRadius = 10.0f;
    dateWiseReportView.layer.borderColor = [UIColor blackColor].CGColor;
    
    
    
    // Calling the webservices to get the present orders ..
    
    
    blockedCharacters = [NSCharacterSet alphanumericCharacterSet].invertedSet;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        dateWiseReportView.frame = CGRectMake( 2, 70, self.view.frame.size.width - 4, self.view.frame.size.height - 80);
        
        fromOrder.frame = CGRectMake(dateWiseReportView.frame.origin.x+10,dateWiseReportView.frame.origin.y-50, 220,40);
        
        fromOrderButton.frame = CGRectMake((fromOrder.frame.origin.x+fromOrder.frame.size.width-45), fromOrder.frame.origin.y+2, 40, 35);
        
        toOrder.frame = CGRectMake(dateWiseReportView.frame.origin.x+300,dateWiseReportView.frame.origin.y-50, 220,40);
        
        toOrderButton.frame = CGRectMake((toOrder.frame.origin.x+toOrder.frame.size.width-45), toOrder.frame.origin.y+2, 40, 35);
        
        getReportBtn.frame=CGRectMake(dateWiseReportView.frame.origin.x+550, dateWiseReportView.frame.origin.y-50, 100,40);
        
        
        scrollView.frame = CGRectMake(0, fromOrder.frame.origin.y+fromOrder.frame.size.height-10, 2300, dateWiseReportView.frame.size.height);
        
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 400);
        
        
        
        
        //        salesTableView.frame = CGRectMake(0, 65, 3500, 520);
        
        //        borderLine.frame = CGRectMake(0, salesTableView.frame.origin.y+salesTableView.frame.size.height + 10, salesTableView.frame.size.width,2);
        
        
        sNo.frame=CGRectMake(dateWiseReportView.frame.origin.x+10, dateWiseReportView.frame.origin.y, 75,40);
        sNo.font = [UIFont fontWithName:kLabelFont size:20];
        salesTableView.frame = CGRectMake(sNo.frame.origin.x,sNo.frame.origin.y+sNo.frame.size.height,scrollView.frame.size.width-40,scrollView.frame.size.height-200);

        billedOn.frame=CGRectMake(sNo.frame.origin.x+sNo.frame.size.width+2, sNo.frame.origin.y, 150,40);
        billedOn.font = [UIFont fontWithName:kLabelFont size:18];
        transactions.frame=CGRectMake(billedOn.frame.origin.x+billedOn.frame.size.width+2, billedOn.frame.origin.y, 120,40);
        transactions.font = [UIFont fontWithName:kLabelFont size:18];
        totalBillAmount.frame=CGRectMake(transactions.frame.origin.x+transactions.frame.size.width+2, transactions.frame.origin.y, 200,40);
        totalBillAmount.font = [UIFont fontWithName:kLabelFont size:18];
        paidAmount.frame=CGRectMake(totalBillAmount.frame.origin.x+totalBillAmount.frame.size.width+2, totalBillAmount.frame.origin.y, 120,40);
        paidAmount.font = [UIFont fontWithName:kLabelFont size:18];
        amountDue.frame=CGRectMake(paidAmount.frame.origin.x+paidAmount.frame.size.width+2, paidAmount.frame.origin.y, 120,40);
        amountDue.font = [UIFont fontWithName:kLabelFont size:18];
        totalCashAmt.frame=CGRectMake(amountDue.frame.origin.x+amountDue.frame.size.width+2, amountDue.frame.origin.y, 100,40);
        totalCashAmt.font = [UIFont fontWithName:kLabelFont size:18];
        ticketAmtLbl.frame=CGRectMake(totalCashAmt.frame.origin.x+totalCashAmt.frame.size.width+2, totalCashAmt.frame.origin.y, 105,40);
        ticketAmtLbl.font = [UIFont fontWithName:kLabelFont size:18];
        
    }
    
    [self.view addSubview:dateWiseReportView];
    [dateWiseReportView addSubview:fromOrder];
    [dateWiseReportView addSubview:fromOrderButton];
    [dateWiseReportView addSubview:toOrder];
    [dateWiseReportView addSubview:toOrderButton];
    [dateWiseReportView addSubview:getReportBtn];
    [dateWiseReportView addSubview:sNo];
    [dateWiseReportView addSubview:billedOn];
    [dateWiseReportView addSubview:totalBillAmount];
    [dateWiseReportView addSubview:cashTotalVal];
    [dateWiseReportView addSubview:paidAmount];
    [dateWiseReportView addSubview:amountDue];
    [dateWiseReportView addSubview:transactions];
    [dateWiseReportView addSubview: totalCashAmt];
    [dateWiseReportView addSubview:ticketAmtLbl];
    
    [dateWiseReportView addSubview:scrollView];
    
    [scrollView addSubview:sNo];
    [scrollView addSubview:billedOn];
    [scrollView addSubview:totalCashAmt];
    [scrollView addSubview:transactions];
    [scrollView addSubview:paidAmount];
    [scrollView addSubview:amountDue];
    [scrollView addSubview:totalBillAmount];
    [scrollView addSubview:ticketAmtLbl];
    [scrollView addSubview:totalCostLbl];
    [scrollView addSubview:discountLbl];
    [scrollView addSubview:voucherTotal];
    [scrollView addSubview:couponTotal];
    [scrollView addSubview:creditNote];
    [scrollView addSubview:creditTotal];
    
    [scrollView addSubview:salesTableView];
    
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    counterIdArr = [[NSMutableArray alloc] init];
    reportStartIndex=0;
    @try {
        [self callingSalesServiceforRecords];

    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)characters
{
    if ([textField.text isEqualToString:bill.text]) {
        
        return ([characters rangeOfCharacterFromSet:blockedCharacters].location == NSNotFound);
    }
    else{
        return YES;
    }
}


//Number pad close...
-(void)doneWithNumberPad{
    
    [counterId resignFirstResponder];
}


-(void) callingSalesServiceforRecords{
    NSDate *today = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"dd/MM/yyyy";
    NSString* currentdate = [f stringFromDate:today];
    
    if ((fromOrder.text).length>0) {
        
        currentdate = [fromOrder.text copy];
    }
    
    if (!isOfflineService) {
        @try {
            
            [HUD setHidden:NO];
            
            NSMutableDictionary *reports = [[NSMutableDictionary alloc]init];
            reports[@"startDate"] = fromOrder.text;
            reports[@"endDate"] = toOrder.text;
            reports[@"location"] = presentLocation;
            reports[@"searchCriteria"] = @"";
            reports[@"maxRecords"] = [NSString stringWithFormat:@"%d",10];
            reports[@"startIndex"] = [NSString stringWithFormat:@"%d",reportStartIndex];
            reports[REQUEST_HEADER] = [RequestHeader getRequestHeader];
            
            NSError * err;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reports options:0 error:&err];
            NSString * reportsJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            WebServiceController *controller = [[WebServiceController alloc] init];
            controller.stockReceiptDelegate = self;
            [controller getSuppliesReport:reportsJsonString];
    
        }
        @catch (NSException *exception) {
            
            [HUD setHidden:YES];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Failed to get the reports" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
    }
    else {
        currentdate = [currentdate componentsSeparatedByString:@" "][0];
        OfflineBillingServices *offline = [[OfflineBillingServices alloc]init];
        NSMutableArray *result = [offline getCompletedBills:@"" fromDate:currentdate];
        counterIdArr = [[NSMutableArray alloc] initWithArray:result];
        if (counterIdArr.count == 0){
            
            //changeID--;
            [HUD setHidden:YES];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Records Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            fromOrder.text = @"";
            toOrder.text = @"";
            counterId.text = @"";
            
        }
        [HUD setHidden:YES];
        [salesTableView reloadData];
    }
}

-(void)getSuppliesReportSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        
        totalRecordsInt = [[successDictionary valueForKey:@"totalRecords"] intValue];
        
        if (![[successDictionary valueForKey:@"suppliesReportBeanList"] isKindOfClass:[NSNull class]]) {
            
            [counterIdArr addObjectsFromArray:[successDictionary valueForKey:@"suppliesReportBeanList"]];
        }
        [salesTableView reloadData];
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}

-(void)getSuppliesReportErrorResponse:(NSString *)errorResponse {
    [HUD setHidden:YES];

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:errorResponse message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    
    [salesTableView reloadData];

}

//previousButtonPressed handler...
//- (void) previousButtonPressed:(id) sender {
//
//    //Play Audio for button touch....
//    AudioServicesPlaySystemSound (soundFileObject);
//
//    [dateArr removeAllObjects];
//    [totalBillArr removeAllObjects];
//    [counterIdArr removeAllObjects];
//    [discount removeAllObjects];
//    [cardTotal removeAllObjects];
//
//    [HUD setHidden:NO];
//
//    [HUD show:YES];
//    [HUD setLabelText:@"Loading"];
//
//    if (changeID > 0){
//
//        changeID = changeID-10;
//
//        [self callingSalesServiceforRecords];
//
//        if ([rec_End.text isEqualToString:rec_total.text]) {
//
//            lastButton.enabled = NO;
//        }
//        else {
//            lastButton.enabled = YES;
//        }
//        nextButton.enabled =  YES;
//
//        [HUD setHidden:YES];
//
//    }
//    else{
//        //previousButton.backgroundColor = [UIColor lightGrayColor];
//        previousButton.enabled =  NO;
//
//        //nextButton.backgroundColor = [UIColor grayColor];
//        previousButton.enabled =  YES;
//    }
//}


//nextButtonPressed handler...
//- (void) nextButtonPressed:(id) sender {
//
//    //Play Audio for button touch....
//    AudioServicesPlaySystemSound (soundFileObject);
//
//    [dateArr removeAllObjects];
//    [totalBillArr removeAllObjects];
//    [counterIdArr removeAllObjects];
//    [discount removeAllObjects];
//    [cardTotal removeAllObjects];
//
//    previousButton.enabled =  YES;
//
//    changeID = changeID+10;
//
//
//    //previousButton.backgroundColor = [UIColor grayColor];
//    previousButton.enabled = YES;
//
//
//    //frstButton.backgroundColor = [UIColor grayColor];
//    frstButton.enabled = YES;
//
//    //[HUD setHidden:NO];
//    [HUD setHidden:NO];
//    [HUD show:YES];
//    [HUD setLabelText:@"Loading"];
//
//    [self callingSalesServiceforRecords];
//}


//FirstButtonPressed handler...
//- (void) firstButtonPressed:(id) sender {
//
//    //Play Audio for button touch....
//    AudioServicesPlaySystemSound (soundFileObject);
//
//    [dateArr removeAllObjects];
//    [totalBillArr removeAllObjects];
//    [counterIdArr removeAllObjects];
//    [discount removeAllObjects];
//    [cardTotal removeAllObjects];
//
//
//    changeID = 0;
//
//    [HUD setHidden:NO];
//    [HUD show:YES];
//    [HUD setLabelText:@"Loading"];
//
//    [self callingSalesServiceforRecords];
//}


//LastButtonPressed handler...
//- (void) lastButtonPressed:(id) sender {
//
//    //Play Audio for button touch....
//    AudioServicesPlaySystemSound (soundFileObject);
//
//
//    [dateArr removeAllObjects];
//    [totalBillArr removeAllObjects];
//    [counterIdArr removeAllObjects];
//    [discount removeAllObjects];
//    [cardTotal removeAllObjects];
//
//    //float a = [rec_total.text intValue]/5;
//    //float t = ([rec_total.text floatValue]/5);
//
//    // NSLog(@"%@",totalOrder.text);
//
//    // NSLog(@"%f",([totalOrder.text floatValue]/10));
//    //
//    if ([rec_total.text intValue]/10 == ([rec_total.text floatValue]/10)) {
//
//        changeID = (([rec_total.text intValue]/10)*10)-10;
//    }
//    else{
//        changeID = ([rec_total.text intValue]/10) * 10;
//    }
//
//
//    //changeID = ([rec_total.text intValue]/5) - 1;
//
//    //previousButton.backgroundColor = [UIColor grayColor];
//    previousButton.enabled = YES;
//
//
//    //frstButton.backgroundColor = [UIColor grayColor];
//    frstButton.enabled = YES;
//
//    [HUD setHidden:NO];
//    [HUD show:YES];
//    [HUD setLabelText:@"Loading"];
//
//    [self callingSalesServiceforRecords];
//
//}



/** DateButtonPressed handle....
 To create picker frame and set the date inside the dueData textfield.
 */
-(IBAction)DateButtonPressed:(UIButton*) sender {
    
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    [catPopOver dismissPopoverAnimated:YES];
    
    PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320, 320)];
    customView.opaque = NO;
    customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    customView.layer.borderWidth = 2.0f;
    [customView setHidden:NO];
    
    
    pickView = [[UIView alloc] init];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        pickView.frame = CGRectMake(15, fromOrder.frame.origin.y+fromOrder.frame.size.height, 320, 320);
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
    
    pickButton.frame = CGRectMake(110, 269, 100, 45);
    pickButton.backgroundColor = [UIColor clearColor];
    pickButton.layer.masksToBounds = YES;
    [pickButton addTarget:self action:@selector(getDate:) forControlEvents:UIControlEventTouchUpInside];
    pickButton.layer.borderColor = [UIColor blackColor].CGColor;
    pickButton.layer.borderWidth = 0.5f;
    pickButton.layer.cornerRadius = 12;
    [customView addSubview:myPicker];
    [customView addSubview:pickButton];
    customerInfoPopUp.view = customView;
    
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        
        if (sender.tag == 2) {
            [popover presentPopoverFromRect:fromOrder.frame inView:dateWiseReportView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            pickButton.tag = 2;
            
        } else {
            
            [popover presentPopoverFromRect:toOrder.frame inView:dateWiseReportView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            //            strtDteFld.tag =0;
        }
        catPopOver = popover;
        
    }
    
    else {
        
        customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        popover.contentViewController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
        catPopOver = popover;
        
    }
    
    UIGraphicsBeginImageContext(customView.frame.size);
    [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    customView.backgroundColor = [UIColor colorWithPatternImage:image];
}


// handle getDate method for pick date from calendar.
-(IBAction)getDate:(UIButton*)sender
{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        [catPopOver dismissPopoverAnimated:YES];
        
        //Date Formate Setting...
        NSDateFormatter *requiredDateFormat = [[NSDateFormatter alloc] init];
        //        [requiredDateFormat setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        requiredDateFormat.dateFormat = @"dd/MM/yyyy";
        dateString = [requiredDateFormat stringFromDate:myPicker.date];
        
        
        NSDate *selectedDateString = [requiredDateFormat dateFromString:[requiredDateFormat stringFromDate:myPicker.date]];
        
        NSDate *existingDateString;
        /*z;
         UITextField *endDateTxt;*/
        
        if(sender.tag == 2){
            if ((fromOrder.text).length != 0 && ( ![fromOrder.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:fromOrder.text ];
                
                if ([existingDateString compare:selectedDateString]== NSOrderedAscending) {
                    
                    fromOrder.text = @"";
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"start should be earlier than end date", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
                    [alert show];
                    return;
                }
            }
            fromOrder.text = dateString;
            
        }
        else{
            
            if ((toOrder.text).length != 0 && ( ![toOrder.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:toOrder.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    toOrder.text = @"";
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"closed_date_should_not_be_earlier_than_created_date", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
                    [alert show];
                    return;
                }
            }
            toOrder.text = dateString;
            
        }
        
    } @catch (NSException *exception) {
        
    }
    @finally{
        
    }
    
    
}



// Hidden TextFields...
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [fromOrder resignFirstResponder];
    [toOrder resignFirstResponder];
    [bill resignFirstResponder];
    return YES;
}

/** Table Implementation */

#pragma mark Table view methods

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == salesTableView) {
        return counterIdArr.count;
    }
   
    
}


//Customize eightForRowAtIndexPath ...
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == salesTableView) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            
            return 50;
        }
        else{
            return 45;
        }
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            return 50.0;
        }
        else{
            return 30.0;
        }
    }
    return 0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (tableView == salesTableView) {
        
        
        @try {
            
            
            if ((cell.contentView).subviews){
                for (UIView *subview in (cell.contentView).subviews) {
                    [subview removeFromSuperview];
                }
            }
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                // cell.frame = CGRectZero;
            }
            
            
            
            if (counterIdArr.count > 0) {
                
                NSDictionary *summaryDic = counterIdArr[indexPath.row];
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    if (!isOfflineService) {
                        
                        UILabel *snoLbl = [[UILabel alloc] init];//WithFrame:CGRectMake(10, 8, 60, 50)];
                        snoLbl.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
                        snoLbl.font = [UIFont systemFontOfSize:20.0f];
                        snoLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                        // snoLbl.backgroundColor = [UIColor clearColor];
                        snoLbl.layer.cornerRadius = 20.0f;
                        snoLbl.layer.masksToBounds = YES;
                        snoLbl.textAlignment = NSTextAlignmentCenter;
                        snoLbl.frame = CGRectMake(5, 0, sNo.frame.size.width, cell.frame.size.height);
                        
                        
                        UILabel *label1 = [[UILabel alloc] init];//WithFrame:CGRectMake(snoLbl.frame.origin.x+snoLbl.frame.size.width, 8, 200.0, 50)];
                        if (![[summaryDic valueForKey:@"receiptCreatedStr"] isKindOfClass:[NSNull class]]) {
                            label1.text = [NSString stringWithFormat:@"%@",[summaryDic valueForKey:@"receiptCreatedStr"]];
                        }
                        else {
                            label1.text = @"--";
                        }
                        label1.font = [UIFont systemFontOfSize:20.0f];
                        label1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                        //                    label1.backgroundColor = [UIColor clearColor] ;
                        label1.layer.cornerRadius = 20.0f;
                        label1.layer.masksToBounds = YES;
                        label1.textAlignment = NSTextAlignmentCenter;
                        label1.frame = CGRectMake(snoLbl.frame.origin.x+10 + snoLbl.frame.size.width, 0, billedOn.frame.size.width + 2,  cell.frame.size.height);
                        
                        UILabel *label2 = [[UILabel alloc] init];//WithFrame:CGRectMake(label1.frame.origin.x+label1.frame.size.width, 8, 200, 50)];
                        if (![[summaryDic valueForKey:@"skuId"] isKindOfClass:[NSNull class]]) {
                            label2.text = [NSString stringWithFormat:@"%@",[summaryDic valueForKey:@"skuId"]];
                        }
                        else {
                            label2.text = @"--";
                        }
                        label2.font = [UIFont systemFontOfSize:20.0f];
                        //                    label2.backgroundColor = [UIColor clearColor];
                        label2.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                        label2.textAlignment = NSTextAlignmentCenter;
                        label2.frame = CGRectMake(label1.frame.origin.x + label1.frame.size.width, 0, transactions.frame.size.width + 2,  cell.frame.size.height);
                        
                        
                        
                        UILabel *label3 = [[UILabel alloc] init ];//
                        label3.font = [UIFont systemFontOfSize:20.0f];
                        // label3.backgroundColor = [UIColor clearColor];
                        //[label3 setTextAlignment:NSTextAlignmentRight];
                        label3.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                        label3.textAlignment = NSTextAlignmentCenter;
                        label3.frame = CGRectMake(label2.frame.origin.x + label2.frame.size.width, 0, totalBillAmount.frame.size.width + 2,  cell.frame.size.height);
                        if (![[summaryDic valueForKey:@"description"] isKindOfClass:[NSNull class]]) {
                            label3.text = [NSString stringWithFormat:@"%@",[summaryDic valueForKey:@"description"]];
                        }
                        else {
                            label3.text = @"--";
                        }
                        
                        UILabel *label4 = [[UILabel alloc] init];
                        label4.font = [UIFont systemFontOfSize:18.0f];
                        // [label4 setTextAlignment:NSTextAlignmentRight];
                        //label4.backgroundColor = [UIColor clearColor];
                        label4.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                        label4.textAlignment = NSTextAlignmentCenter;
                        label4.frame = CGRectMake(label3.frame.origin.x + label3.frame.size.width, 0, paidAmount.frame.size.width + 2,  cell.frame.size.height);
                        if ([summaryDic.allKeys containsObject:@"suppliedQty"] && ![[summaryDic valueForKey:@"suppliedQty"] isKindOfClass:[NSNull class]]) {
                            label4.text = [NSString stringWithFormat:@"%.2f",[[summaryDic valueForKey:@"suppliedQty"] floatValue]];
                        }
                        else {
                            label4.text = @"--";
                        }
                        
                        UILabel *label5 = [[UILabel alloc] init];
                        label5.font = [UIFont systemFontOfSize:20.0f];
                        label5.backgroundColor = [UIColor clearColor];
                        //                    [label5 setTextAlignment:NSTextAlignmentRight];
                        label5.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                        label5.textAlignment = NSTextAlignmentCenter;
                        label5.frame = CGRectMake(label4.frame.origin.x + label4.frame.size.width, 0, amountDue.frame.size.width + 2,  cell.frame.size.height);
                        if ([summaryDic.allKeys containsObject:@"receivedQty"] && ![[summaryDic valueForKey:@"receivedQty"] isKindOfClass:[NSNull class]]) {
                            label5.text = [NSString stringWithFormat:@"%.2f",[[summaryDic valueForKey:@"receivedQty"] floatValue]];
                        }
                        else {
                            label5.text = @"--";
                        }
                        
                        UILabel *label6 = [[UILabel alloc] init];
                        label6.font = [UIFont systemFontOfSize:20.0f];
                        label6.backgroundColor = [UIColor clearColor];
                        //                    [label6 setTextAlignment:NSTextAlignmentRight];
                        label6.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                        label6.textAlignment = NSTextAlignmentCenter;
                        label6.frame = CGRectMake(label5.frame.origin.x + label5.frame.size.width, 0, totalCashAmt.frame.size.width + 2,  cell.frame.size.height);
                        if ([summaryDic.allKeys containsObject:@"price"] && ![[summaryDic valueForKey:@"price"] isKindOfClass:[NSNull class]]) {
                            label6.text = [NSString stringWithFormat:@"%.2f",[[summaryDic valueForKey:@"price"] floatValue]];
                        }
                        else {
                            label6.text = @"--";
                        }
                        
                        UILabel *label7 = [[UILabel alloc] init];
                        label7.font = [UIFont systemFontOfSize:20.0f];
                        //                    label7.backgroundColor = [UIColor clearColor];
                        //                    [label7 setTextAlignment:NSTextAlignmentRight;
                        label7.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                        label7.textAlignment = NSTextAlignmentCenter;
                        label7.frame = CGRectMake(label6.frame.origin.x + label6.frame.size.width, 0, ticketAmtLbl.frame.size.width + 2,  cell.frame.size.height);
                        
                        if ([summaryDic.allKeys containsObject:@"cost"] && ![[summaryDic valueForKey:@"cost"] isKindOfClass:[NSNull class]]) {
                            label7.text = [NSString stringWithFormat:@"%.2f",[[summaryDic valueForKey:@"cost"] floatValue]];
                        }
                        else {
                            label7.text = @"--";
                        }
                        
                    
                        
                        [cell.contentView addSubview:snoLbl];
                        [cell.contentView addSubview:label1];
                        [cell.contentView addSubview:label2];
                        [cell.contentView addSubview:label3];
                        [cell.contentView addSubview:label4];
                        [cell.contentView addSubview:label5];
                        [cell.contentView addSubview:label6];
                        [cell.contentView addSubview:label7];
                    }
                    else {
                        if ([summaryDic isKindOfClass:[NSDictionary class]]) {
                            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 230.0, 50)];
                            if (![[summaryDic valueForKey:@"bill_id"] isKindOfClass:[NSNull class]]) {
                                label1.text = [NSString stringWithFormat:@"%@",[summaryDic valueForKey:@"bill_id"]];
                            }
                            else {
                                label1.text = @"--";
                            }
                            label1.font = [UIFont systemFontOfSize:20.0f];
                            label1.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
                            label1.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5f];;
                            label1.layer.cornerRadius = 20.0f;
                            label1.layer.masksToBounds = YES;
                            label1.textAlignment = NSTextAlignmentCenter;
                            
                            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(310, 8, 250, 50)];
                            if (![[summaryDic valueForKey:@"total_price"] isKindOfClass:[NSNull class]]) {
                                label2.text = [NSString stringWithFormat:@"%.2f",[[summaryDic valueForKey:@"total_price"] floatValue]];
                            }
                            else {
                                label2.text = @"--";
                            }
                            label2.font = [UIFont systemFontOfSize:22.0f];
                            label2.backgroundColor = [UIColor clearColor];
                            label2.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                            
                            UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(350, 8, 250, 50)];
                            // label3.text =[NSString stringWithFormat:@"%@",s_3];
                            label3.text = [NSString stringWithFormat:@"%.2f",[[summaryDic valueForKey:@"cash_total"] floatValue]];
                            label3.font = [UIFont systemFontOfSize:22.0f];
                            label3.backgroundColor = [UIColor clearColor];
                            label3.textAlignment = NSTextAlignmentRight;
                            label3.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                            
                            
                            UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(560, 8, 250, 50)];
                            //  label4.text = [NSString stringWithFormat:@"%d",s4];
                            label4.text = [NSString stringWithFormat:@"%.2f",[[summaryDic valueForKey:@"card_total"] floatValue]];
                            label4.font = [UIFont systemFontOfSize:22.0f];
                            label4.textAlignment = NSTextAlignmentRight
                             ;
                            label4.backgroundColor = [UIColor clearColor];
                            label4.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                            
                            UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(780, 8, 265, 50)];
                            //    label5.text = [NSString stringWithFormat:@"%@",s55];
                            label5.text = [NSString stringWithFormat:@"%.2f",[[summaryDic valueForKey:@"change_return"] floatValue]];
                            label5.font = [UIFont systemFontOfSize:22.0f];
                            label5.backgroundColor = [UIColor clearColor];
                            label5.textAlignment = NSTextAlignmentRight
                             ;
                            label5.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                            
                            UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(990, 8, 265, 50)];
                            //    label5.text = [NSString stringWithFormat:@"%@",s55];
                            label6.text = [NSString stringWithFormat:@"%.2f",[[summaryDic valueForKey:@"sodexo_total"] floatValue]];
                            label6.font = [UIFont systemFontOfSize:22.0f];
                            label6.backgroundColor = [UIColor clearColor];
                            label6.textAlignment = NSTextAlignmentRight
                             ;
                            label6.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                            
                            UILabel *label7 = [[UILabel alloc] initWithFrame:CGRectMake(1200, 8, 265, 50)];
                            //    label5.text = [NSString stringWithFormat:@"%@",s55];
                            label7.text = [NSString stringWithFormat:@"%.2f",[[summaryDic valueForKey:@"ticket_total"] floatValue]];
                            label7.font = [UIFont systemFontOfSize:22.0f];
                            label7.backgroundColor = [UIColor clearColor];
                            label7.textAlignment = NSTextAlignmentRight
                             ;
                            label7.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                            
                            [cell.contentView addSubview:label1];
                            [cell.contentView addSubview:label2];
                            [cell.contentView addSubview:label3];
                            [cell.contentView addSubview:label4];
                            [cell.contentView addSubview:label5];
                            [cell.contentView addSubview:label6];
                            [cell.contentView addSubview:label7];
                        }
                    }
                }
                else{
                    
                    //item2 = [[item objectAtIndex:indexPath.row] componentsSeparatedByString:@"#"];
                    
                    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 106, 40)];
                    label1.text = [NSString stringWithFormat:@"%@",dateArr[indexPath.row]];
                    label1.font = [UIFont fontWithName:@"ArialRoundedMT" size:13.0f];
                    label1.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
                    //                label1.backgroundColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
                    //                label1.layer.cornerRadius = 20.0f;
                    //                label1.layer.masksToBounds = YES;
                    label1.textAlignment = NSTextAlignmentCenter;
                    
                    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(115, 5, 106, 40)];
                    label2.text = counterIdArr[indexPath.row];
                    label2.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:13.0f];
                    label2.backgroundColor = [UIColor clearColor];
                    label2.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                    
                    
                    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(225, 5, 106, 40)];
                    label3.text = [NSString stringWithFormat:@"%.2f",[totalBillArr[indexPath.row] doubleValue]];
                    //    label3.text = [NSString stringWithFormat:@"%@",s_3];
                    label3.font = [UIFont fontWithName:@"ArialRoundedMT" size:13.0f];
                    label3.backgroundColor = [UIColor clearColor];
                    label3.textAlignment = NSTextAlignmentLeft;
                    label3.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                    
                    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(335, 5, 106, 40)];
                    label4.text = [NSString stringWithFormat:@"%.2f",[cardTotal[indexPath.row] floatValue]];
                    label4.font = [UIFont fontWithName:@"ArialRoundedMT" size:13.0f];
                    label4.textAlignment = NSTextAlignmentLeft;
                    label4.backgroundColor = [UIColor clearColor];
                    label4.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                    
                    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(441, 5, 106, 40)];
                    label5.text = [NSString stringWithFormat:@"%.2f",[discount[indexPath.row] doubleValue]];
                    label5.font = [UIFont fontWithName:@"ArialRoundedMT" size:13.0f];
                    label5.backgroundColor = [UIColor clearColor];
                    label5.textAlignment = NSTextAlignmentLeft;
                    label5.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                    
                    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(551, 5, 120, 40)];
                    //    label5.text = [NSString stringWithFormat:@"%@",s55];
                    label6.text = [NSString stringWithFormat:@"%.2f",[cardTotal[indexPath.row] doubleValue]+[totalBillArr[indexPath.row]doubleValue]];
                    label6.font = [UIFont fontWithName:@"ArialRoundedMT" size:13.0f];
                    label6.backgroundColor = [UIColor clearColor];
                    label6.textAlignment = NSTextAlignmentLeft;
                    label6.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
                    
                    
                    [cell.contentView addSubview:label1];
                    [cell.contentView addSubview:label2];
                    [cell.contentView addSubview:label3];
                    [cell.contentView addSubview:label4];
                    [cell.contentView addSubview:label5];
                    [cell.contentView addSubview:label6];
                }
                
            }
            cell.backgroundColor = [UIColor clearColor];
            cell.tag = indexPath.row;
            
            return cell;
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
        
        
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    UITableViewCell* theCell = [tableView cellForRowAtIndexPath:indexPath];
    theCell.contentView.backgroundColor=[UIColor clearColor];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    @try {
        
        if(tableView == salesTableView){
            
            @try {
                
                if ((indexPath.row == (counterIdArr.count -1)) && (counterIdArr.count < totalRecordsInt ) && (counterIdArr.count> reportStartIndex )) {
                    
                    [HUD show:YES];
                    [HUD setHidden:NO];
                    reportStartIndex = reportStartIndex + 10;
                    [self callingSalesServiceforRecords];
                    [salesTableView reloadData];
                    
                }
                
            } @catch (NSException *exception) {
                NSLog(@"-----------exception in servicecall-------------%@",exception);
                [HUD setHidden:YES];
            }
        }
    } @catch (NSException *exception) {
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)goToHome {
    
    OmniHomePage *home = [[OmniHomePage alloc]init];
    [self.navigationController pushViewController:home animated:YES];
    
}

- (NSString *)getBillSummaryPrintString {
    
    @try {
        NSString *summaryString = @"";
        
        NSDate *today = [NSDate date];
        NSDateFormatter *f = [[NSDateFormatter alloc] init];
        f.dateFormat = @"dd-MM-yyyy";
        NSString* currentdate = [f stringFromDate:today];
        
        NSString *storeAddress = [WebServiceUtility getStoreAddress];
        
        NSString *posNo = [NSString stringWithFormat:@"%@%@%@",@"POS NO. ",counterName,@"\n"];
        NSString *summaryDate = [NSString stringWithFormat:@"%@%@%@%@",@"Bill Summ For : ",currentdate,@"\n",@"--------------------------------------------\n"];
        NSString *headerTitles = [NSString stringWithFormat:@"%@",@"BillNo##Amount##PayMode##Amount##Type\n--------------------------------------------\n\n"];
        NSMutableString *bodyString = [NSMutableString new];
        int serialNum = 1;
        for (NSDictionary *summaryDic in counterIdArr) {
            NSString *transacString = @"";
            if (!isOfflineService) {
                transacString = [NSString stringWithFormat:@"%d%@%@",serialNum,@"########",[NSString stringWithFormat:@"%.2f",[[summaryDic valueForKey:@"amount"] floatValue]]];
                float cashAmount = 0.0f;
                float cardAmount = 0.0f;
                float sodexoAmount = 0.0f;
                float returnAmount = 0.0f;
                float ticketAmount = 0.0f;
                NSString *bankName = @"";
                for (NSDictionary *transDic in [summaryDic valueForKey:@"transactions"]) {
                    if ([[transDic valueForKey:@"paymentMode"] isEqualToString:@"Cash"]) {
                        cashAmount += [[transDic valueForKey:@"amount"] floatValue];
                    }
                    else if ([[transDic valueForKey:@"paymentMode"] isEqualToString:@"Card"]) {
                        cardAmount += [[transDic valueForKey:@"amount"] floatValue];
                        bankName = [transDic valueForKey:@"bankName"];
                    }
                    else if ([[transDic valueForKey:@"paymentMode"] isEqualToString:@"Sodexo"]) {
                        sodexoAmount += [[transDic valueForKey:@"amount"] floatValue];
                    }
                    else if ([[transDic valueForKey:@"paymentMode"] isEqualToString:@"Ticket"]) {
                        ticketAmount += [[transDic valueForKey:@"amount"] floatValue];
                    }
                    if (![[transDic valueForKey:@"returnAmount"] isKindOfClass:[NSNull class]]) {
                        returnAmount += [[transDic valueForKey:@"returnAmount"] floatValue];
                    }
                    else {
                        returnAmount += 0.0;
                    }
                }
                if (cashAmount > 0) {
                    if (![transacString containsString:@"CASH"]) {
                        transacString = [NSString stringWithFormat:@"%@%@%@%@%@",transacString,@"###CASH###",[NSString stringWithFormat:@"%.2f",cashAmount],@"##Tender",@"\n"];
                    }
                    else {
                        transacString = [NSString stringWithFormat:@"%@%@%@%@%@",transacString,@"###########CASH###",[NSString stringWithFormat:@"%.2f",cashAmount],@"##Tender",@"\n"];
                    }
                }
                if (cardAmount > 0) {
                    if (![transacString containsString:@"CARD"]) {
                        transacString = [NSString stringWithFormat:@"%@%@%@%@%@",transacString,@"###CARD###",[NSString stringWithFormat:@"%.2f",cardAmount],@"##Tender",@"\n"];
                        transacString = [NSString stringWithFormat:@"%@%@%@%@",transacString,@"###########CCNo.##############",[NSString stringWithFormat:@"%@",bankName],@"\n"];
                    }
                    else {
                        transacString = [NSString stringWithFormat:@"%@%@%@%@%@",transacString,@"###########CARD###",[NSString stringWithFormat:@"%.2f",cardAmount],@"##Tender",@"\n"];
                        transacString = [NSString stringWithFormat:@"%@%@%@%@",transacString,@"###########CCNo.##############",[NSString stringWithFormat:@"%@",bankName],@"\n"];
                    }
                }
                if (sodexoAmount > 0) {
                    if (![transacString containsString:@"SODEXO"]) {
                        transacString = [NSString stringWithFormat:@"%@%@%@%@%@",transacString,@"###SODEXO###",[NSString stringWithFormat:@"%.2f",sodexoAmount],@"##Tender",@"\n"];
                    }
                    else {
                        transacString = [NSString stringWithFormat:@"%@%@%@%@%@",transacString,@"###########SODEXO###",[NSString stringWithFormat:@"%.2f",sodexoAmount],@"##Tender",@"\n"];
                    }
                }
                if (ticketAmount > 0) {
                    if (![transacString containsString:@"TICKET"]) {
                        transacString = [NSString stringWithFormat:@"%@%@%@%@%@",transacString,@"###TICKET###",[NSString stringWithFormat:@"%.2f",ticketAmount],@"##Tender",@"\n"];
                    }
                    else {
                        transacString = [NSString stringWithFormat:@"%@%@%@%@%@",transacString,@"###########TICKET###",[NSString stringWithFormat:@"%.2f",ticketAmount],@"##Tender",@"\n"];
                    }
                }
                if (returnAmount > 0) {
                    if (![transacString containsString:@"CASH"]) {
                        transacString = [NSString stringWithFormat:@"%@%@%@%@",transacString,@"###CASH###",[NSString stringWithFormat:@"%.2f",returnAmount],@"##Change\n"];
                    }
                    else {
                        transacString = [NSString stringWithFormat:@"%@%@%@%@",transacString,@"###########CASH###",[NSString stringWithFormat:@"%.2f",returnAmount],@"##Change\n"];
                    }
                }
                transacString = [NSString stringWithFormat:@"%@%@",transacString,@"\n"];
                
                [bodyString appendString:transacString];
                serialNum++;
            }
            else {
                if ([summaryDic isKindOfClass:[NSDictionary class]]) {
                    transacString = [NSString stringWithFormat:@"%d%@%@",serialNum,@"########",[NSString stringWithFormat:@"%.2f",[[summaryDic valueForKey:@"total_price"] floatValue]]];
                    float cashAmount = [[summaryDic valueForKey:@"cash_total"] floatValue];
                    float cardAmount = [[summaryDic valueForKey:@"card_total"] floatValue];
                    float sodexoAmount = [[summaryDic valueForKey:@"sodexo_total"] floatValue];
                    float returnAmount = [[summaryDic valueForKey:@"change_return"] floatValue];
                    float ticketAmount = [[summaryDic valueForKey:@"ticket_total"] floatValue];
                    NSString *bankName = @"";
                    if (cashAmount > 0) {
                        if (![transacString containsString:@"CASH"]) {
                            transacString = [NSString stringWithFormat:@"%@%@%@%@%@",transacString,@"###CASH###",[NSString stringWithFormat:@"%.2f",cashAmount],@"##Tender",@"\n"];
                        }
                        else {
                            transacString = [NSString stringWithFormat:@"%@%@%@%@%@",transacString,@"###########CASH###",[NSString stringWithFormat:@"%.2f",cashAmount],@"##Tender",@"\n"];
                        }
                    }
                    if (cardAmount > 0) {
                        if (![transacString containsString:@"CARD"]) {
                            transacString = [NSString stringWithFormat:@"%@%@%@%@%@",transacString,@"###CARD###",[NSString stringWithFormat:@"%.2f",cardAmount],@"##Tender",@"\n"];
                            transacString = [NSString stringWithFormat:@"%@%@%@%@",transacString,@"###########CCNo.##############",[NSString stringWithFormat:@"%@",bankName],@"\n"];
                        }
                        else {
                            transacString = [NSString stringWithFormat:@"%@%@%@%@%@",transacString,@"###########CARD###",[NSString stringWithFormat:@"%.2f",cardAmount],@"##Tender",@"\n"];
                            transacString = [NSString stringWithFormat:@"%@%@%@%@",transacString,@"###########CCNo.##############",[NSString stringWithFormat:@"%@",bankName],@"\n"];
                        }
                    }
                    if (sodexoAmount > 0) {
                        if (![transacString containsString:@"SODEXO"]) {
                            transacString = [NSString stringWithFormat:@"%@%@%@%@%@",transacString,@"###SODEXO###",[NSString stringWithFormat:@"%.2f",sodexoAmount],@"##Tender",@"\n"];
                        }
                        else {
                            transacString = [NSString stringWithFormat:@"%@%@%@%@%@",transacString,@"###########SODEXO###",[NSString stringWithFormat:@"%.2f",sodexoAmount],@"##Tender",@"\n"];
                        }
                    }
                    if (ticketAmount > 0) {
                        if (![transacString containsString:@"TICKET"]) {
                            transacString = [NSString stringWithFormat:@"%@%@%@%@%@",transacString,@"###TICKET###",[NSString stringWithFormat:@"%.2f",ticketAmount],@"##Tender",@"\n"];
                        }
                        else {
                            transacString = [NSString stringWithFormat:@"%@%@%@%@%@",transacString,@"###########TICKET###",[NSString stringWithFormat:@"%.2f",ticketAmount],@"##Tender",@"\n"];
                        }
                    }
                    if (returnAmount > 0) {
                        if (![transacString containsString:@"CASH"]) {
                            transacString = [NSString stringWithFormat:@"%@%@%@%@",transacString,@"###CASH###",[NSString stringWithFormat:@"%.2f",returnAmount],@"##Change\n"];
                        }
                        else {
                            transacString = [NSString stringWithFormat:@"%@%@%@%@",transacString,@"###########CASH###",[NSString stringWithFormat:@"%.2f",returnAmount],@"##Change\n"];
                        }
                    }
                    transacString = [NSString stringWithFormat:@"%@%@",transacString,@"\n"];
                    
                    [bodyString appendString:transacString];
                    serialNum++;
                }
            }
            summaryString = [NSString stringWithFormat:@"%@%@%@%@%@%@",storeAddress,posNo,summaryDate,headerTitles,bodyString,@"\n\n\n"];
            summaryString = [summaryString stringByReplacingOccurrencesOfString:@"#" withString:@" "];
        }
        return summaryString;
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception.name);
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)goButtonClicked {
    
    reportStartIndex = 0;
    counterIdArr = [NSMutableArray new];
    [self callingSalesServiceforRecords];
}

@end
