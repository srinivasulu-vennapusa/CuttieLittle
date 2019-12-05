//
//  ServiceStaff.m
//  OmniRetailer
//
//  Created by Sonali on 12/25/15.
//
//

#import "ServiceStaff.h"

@interface ServiceStaff ()

@end

@implementation ServiceStaff

@synthesize scrollView,tableNoTxt,headCountTxt,mobileNoTxt,startTimeTxt,sectionTF,firstNameTF,lastNameTF,eatingHabitsTF,bookingTimeTF,captainNameTF;
@synthesize sNoLbl,menuItemLbl,descriptionLbl,qtyLbl,priceLbl,tasteRecommendationsLbl,statusLbl,addOnLbl;
@synthesize itemsTbl,saveBtn,submitBtn,printBillBtn;
@synthesize soundFileObject,soundFileURLRef;
@synthesize billAmtValLbl,taxValLbl,discountValLbl,netPayValLbl;
@synthesize billAmtLbl,discountLbl,netPayLbl,productMenuBtn,customerInfoBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = NSLocalizedString(@"Table Service", nil); //Staff-Service
    
    [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:20.0 cornerRadius:8.0];
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    itemsTbl.tableFooterView  = [[UIView alloc] initWithFrame:CGRectZero];
    sNoLbl.layer.cornerRadius = 10.0f;
    sNoLbl.clipsToBounds=YES;
    menuItemLbl.layer.cornerRadius = 10.0f;
    menuItemLbl.clipsToBounds=YES;
    descriptionLbl.layer.cornerRadius = 10.0f;
    descriptionLbl.clipsToBounds=YES;
    qtyLbl.layer.cornerRadius = 10.0f;
    qtyLbl.clipsToBounds=YES;
    priceLbl.layer.cornerRadius = 10.0f;
    priceLbl.clipsToBounds=YES;
    tasteRecommendationsLbl.layer.cornerRadius = 10.0f;
    tasteRecommendationsLbl.clipsToBounds=YES;
    statusLbl.layer.cornerRadius = 10.0f;
    statusLbl.clipsToBounds=YES;
    addOnLbl.layer.cornerRadius = 10.0f;
    addOnLbl.clipsToBounds=YES;
    
    startTimeTxt.text = [WebServiceUtility getCurrentDate];
    
    captainNameTF.text = firstName;
    
    currentOrientation = [UIDevice currentDevice].orientation;
    
    yposition_f = billAmtValLbl.frame.origin.y+billAmtValLbl.frame.size.height;
    
    textFieldData = [[NSMutableArray alloc] init];
    textFieldTitle = [[NSMutableArray alloc] init];
    
    //commented by Srinivasulu on 28/01/2018....
    
    //    for (int i = 0; i < [finalTaxDetails count]; i++) {
    //
    //        NSDictionary *JSON1 = [finalTaxDetails objectAtIndex:i];
    //
    //        taxTitle = [[UILabel alloc] init];
    //        taxTitle.text = [NSString stringWithFormat:@"%@",[JSON1 objectForKey:@"taxName"]];
    //        taxTitle.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
    //        taxTitle.backgroundColor = [UIColor clearColor];
    //        taxTitle.textColor = [UIColor whiteColor];
    //
    //        taxTxt = [[UITextField alloc] init];
    //        taxTxt.text = @"0.00";
    //        taxTxt.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
    //        taxTxt.backgroundColor = [UIColor clearColor];
    //        taxTxt.textAlignment = NSTextAlignmentLeft;
    //        taxTxt.textColor = [UIColor whiteColor];
    //        [taxTxt setEnabled:FALSE];
    //
    //        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    //            if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
    //
    //                taxTitle.font = [UIFont boldSystemFontOfSize:18];
    //                taxTitle.frame = CGRectMake(billAmtLbl.frame.origin.x, yposition_f, 240, 30);
    //                taxTxt.font = [UIFont boldSystemFontOfSize:18];
    //                taxTxt.frame = CGRectMake(billAmtValLbl.frame.origin.x, yposition_f, 550, 30);
    //                yposition_f = yposition_f + 30.0f;
    //            }
    //            else {
    //                taxTitle.font = [UIFont boldSystemFontOfSize:20];
    //                taxTitle.frame = CGRectMake(30, yposition_f, 240, 40);
    //                taxTxt.font = [UIFont boldSystemFontOfSize:20];
    //                taxTxt.frame = CGRectMake(640, yposition_f, 550, 40);
    //                yposition_f = yposition_f + 40.0f;
    //            }
    //
    //        }
    //        else {
    //            taxTitle.frame = CGRectMake(20, yposition_f, 130, 25);
    //            taxTxt.frame = CGRectMake(150, yposition_f, 550, 25);
    //            yposition_f = yposition_f + 25.0f;
    //        }
    //
    //        [textFieldData addObject:taxTxt];
    //        [textFieldTitle addObject:taxTitle];
    //        [self.view addSubview:taxTitle];
    //        [self.view addSubview:taxTxt];
    //    }
    
    
    taxTitle = [[UILabel alloc] init];
    taxTitle.text = @"Tax ";
    taxTitle.font = billAmtLbl.font;
    taxTitle.backgroundColor = [UIColor clearColor];
    taxTitle.textColor = [UIColor whiteColor];
    
    taxTxt = [[UITextField alloc] init];
    taxTxt.text = @"0.00";
    taxTxt.font = billAmtValLbl.font;
    taxTxt.backgroundColor = [UIColor clearColor];
    taxTxt.textAlignment = NSTextAlignmentRight;
    taxTxt.textColor = [UIColor whiteColor];
    [taxTxt setEnabled:FALSE];
    
    taxTitle.font = billAmtValLbl.font;
    taxTitle.frame = CGRectMake(billAmtLbl.frame.origin.x, yposition_f, billAmtLbl.frame.size.width, billAmtLbl.frame.size.height);
    taxTxt.font = billAmtValLbl.font;
    taxTxt.frame = CGRectMake(billAmtValLbl.frame.origin.x, yposition_f, billAmtValLbl.frame.size.width, billAmtValLbl.frame.size.height);
    yposition_f = yposition_f + billAmtValLbl.frame.size.height;
    
    
    
    [textFieldData addObject:taxTxt];
    [textFieldTitle addObject:taxTitle];
    [self.view addSubview:taxTitle];
    [self.view addSubview:taxTxt];
    
    
    //upto here by Srinivasulu on 28/01/2018....
    
    
    
    discountLbl.frame = CGRectMake(discountLbl.frame.origin.x, yposition_f, discountLbl.frame.size.width, discountLbl.frame.size.height);
    discountValLbl.frame = CGRectMake(discountValLbl.frame.origin.x, yposition_f, discountValLbl.frame.size.width, discountValLbl.frame.size.height);
    netPayLbl.frame = CGRectMake(netPayLbl.frame.origin.x, yposition_f+30, netPayLbl.frame.size.width, netPayLbl.frame.size.height);
    netPayValLbl.frame = CGRectMake(netPayValLbl.frame.origin.x, yposition_f+30, netPayValLbl.frame.size.width, netPayValLbl.frame.size.height);
    
    //initialize HUD....
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    // Show the HUD
    [HUD show:YES];
    [HUD setHidden:YES];
    
    dealTempVal = 0.0f;
    
    //initialize arrays...
    
    menuItemsCategories = [[NSMutableArray alloc] init];
    menuItemDescArr = [NSMutableArray new];
    cartTotalItems = [NSMutableArray new];
    isVoidedArray = [NSMutableArray new];
    customerInfoDic = [NSDictionary new];
    
    //Tap Gesture
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapped:)];
    //Adding userinteraction for label
    [menuItemLbl setUserInteractionEnabled:YES];
    
    // commented by roja on 06/02/19
    // no need to pop up menu table...
    //Adding label to tap gesture
//    [menuItemLbl addGestureRecognizer:gesture];
    
    // added by roja on 02/04/2019
    tasteRequirementsTbl = [[UITableView alloc] init];
    tasteRequirementsTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [tasteRequirementsTbl setDataSource:self];
    [tasteRequirementsTbl setDelegate:self];
    [tasteRequirementsTbl.layer setBorderWidth:1.0f];
    tasteRequirementsTbl.layer.cornerRadius = 3;
    tasteRequirementsTbl.layer.borderColor = [UIColor grayColor].CGColor;
    
    eatingHabitsTbl = [[UITableView alloc] init];
    eatingHabitsTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [eatingHabitsTbl setDataSource:self];
    [eatingHabitsTbl setDelegate:self];
    [eatingHabitsTbl.layer setBorderWidth:1.0f];
    eatingHabitsTbl.layer.cornerRadius = 3;
    eatingHabitsTbl.layer.borderColor = [UIColor grayColor].CGColor;
    
    tableNoTxt.backgroundColor = [UIColor whiteColor];
    headCountTxt.backgroundColor = [UIColor whiteColor];
    mobileNoTxt.backgroundColor = [UIColor whiteColor];
    startTimeTxt.backgroundColor = [UIColor whiteColor];
    sectionTF.backgroundColor = [UIColor whiteColor];
    firstNameTF.backgroundColor = [UIColor whiteColor];
    lastNameTF.backgroundColor = [UIColor whiteColor];
    bookingTimeTF.backgroundColor = [UIColor whiteColor];
    eatingHabitsTF.backgroundColor = [UIColor whiteColor];

    tableNoTxt.borderStyle = UITextBorderStyleRoundedRect;
    headCountTxt.borderStyle = UITextBorderStyleRoundedRect;
    mobileNoTxt.borderStyle = UITextBorderStyleRoundedRect;
    sectionTF.borderStyle = UITextBorderStyleRoundedRect;
    firstNameTF.borderStyle = UITextBorderStyleRoundedRect;
    lastNameTF.borderStyle = UITextBorderStyleRoundedRect;
    bookingTimeTF.borderStyle = UITextBorderStyleRoundedRect;
    startTimeTxt.borderStyle = UITextBorderStyleRoundedRect;
    eatingHabitsTF.borderStyle = UITextBorderStyleRoundedRect;
    
    [self provideCustomerRatingfor:nil];
    //Upto here added by roja on 02/04/2019

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
 */

-(void)userTapped:(UITapGestureRecognizer*)gesture
{
    UIButton *btn= [UIButton new];
    [self populateMenu:btn];
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    
//    cartItemDetails = [NSMutableArray new];
    reloadTableData = true;
    isEatingHabitsDropDown = false;

    ratingDetailsBtn.tag = 2;

    [self populateTableView:@"1"];
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


- (IBAction)saveOrder:(UIButton *)sender {
    
    AudioServicesPlaySystemSound (soundFileObject);

    float y_axis = self.view.frame.size.height - 120;
    
    if([tableNoTxt.text length]==0 && [headCountTxt.text length]==0 && [mobileNoTxt.text length]){
        
        y_axis = self.view.frame.size.height - 200;
        [self displayAlertMessage:@"Please select the table" horizontialAxis:(self.view.frame.size.width - 360)/2 verticalAxis:y_axis msgType:@"Alert" conentWidth:300 contentHeight:60 isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    else{
        
        NSMutableArray * temparr = [[NSMutableArray alloc]init];
        
        for(NSDictionary * locDic in cartItemDetails){
            
            if(![[self checkGivenValueIsNullOrNil:[locDic valueForKey:IS_VOID] defaultReturn:@"0"] boolValue]){
                [temparr addObject:locDic];
            }
        }
        
        if([temparr count]){

            if (!isOfflineService) {
                
                //                [HUD setHidden:NO];
                //                [HUD setLabelText:@"Placing order"];
                //                [HUD show:YES];
                
                if(isToCallUpdate){
                    
                    [self callUpdateOutletOrder:1];
                }
                else{
                    
                    [self callCreateOutletOrder:1];
                }
                
                
                //                //add the all the taxes available....
                //                NSString *tax = @"0.00";
                //
                //                for (int c = 0; c < [textFieldData count]; c++) {
                //                    UITextField *text = [textFieldData objectAtIndex:c];
                //                    tax = [NSString stringWithFormat:@"%.2f",[tax floatValue]+[text.text floatValue]];
                //                }
                //
                //                // NSString *order_id;
                //                @try {
                //                    NSDate *today = [NSDate date];
                //                    NSDateFormatter *f = [[NSDateFormatter alloc] init];
                //                    [f setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
                //                    NSString* currentdate = [f stringFromDate:today];
                //
                //                    NSMutableDictionary *orderDetails = [[NSMutableDictionary alloc] init];
                //                    //                    NSMutableArray *temparr = [[NSMutableArray alloc]init];
                //                    //
                //                    //                    for(NSDictionary * locDic in cartItemDetails){
                //                    //
                //                    //                        if(![[self checkGivenValueIsNullOrNil:[locDic valueForKey:IS_VOID] defaultReturn:@"0"] boolValue]){
                //                    //
                //                    //                            [temparr addObject:locDic];
                //                    //                        }
                //                    //                    }
                //                    [orderDetails setObject:[bookingDetails valueForKey:@"orderReference"] forKey:@"orderReference"];
                //                    [orderDetails setObject:@"immediate" forKey:@"orderType"];
                //                    [orderDetails setObject:currentdate forKey:@"orderDate"];
                //                    [orderDetails setObject:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
                //
                //                    [orderDetails setObject:[bookingDetails valueForKey:@"customerName"] forKey:@"customerName"];
                //                    [orderDetails setObject:[bookingDetails valueForKey:@"email"] forKey:@"email"];
                //                    [orderDetails setObject:[bookingDetails valueForKey:@"slotId"] forKey:@"slotId"];
                //                    [orderDetails setObject:[bookingDetails valueForKey:@"reservationTypeId"] forKey:@"reservationTypeId"];
                //                    [orderDetails setObject:[NSNumber numberWithInt:[[bookingDetails valueForKey:@"noOfVegAdults"] intValue]] forKey:@"noOfVegAdults"];
                //                    [orderDetails setObject:[NSNumber numberWithInt:[[bookingDetails valueForKey:@"noOfNonVegAdult"] intValue]] forKey:@"noOfNonVegAdult"];
                //                    [orderDetails setObject:[NSNumber numberWithInt:[[bookingDetails valueForKey:@"noOfVegChildren"] intValue]] forKey:@"noOfVegChildren"];
                //                    [orderDetails setObject:[NSNumber numberWithInt:[[bookingDetails valueForKey:@"noOfNonVegChildren"] intValue]] forKey:@"noOfNonVegChildren"];
                //                    [orderDetails setObject:[NSNumber numberWithInt:[[bookingDetails valueForKey:@"noOfAlcoholic"] intValue]] forKey:@"noOfAlcoholic"];
                //                    [orderDetails setObject:[NSNumber numberWithInt:[[bookingDetails valueForKey:@"noOfNonAlcoholic"] intValue]] forKey:@"noOfNonAlcoholic"];
                //
                //                    [orderDetails setObject:[NSNumber numberWithInt:[[bookingDetails valueForKey:@"noOfAlcoholic"] intValue]] forKey:@"noOfAlcoholic"];
                //                    [orderDetails setObject:[NSNumber numberWithInt:[[bookingDetails valueForKey:@"childPax"] intValue]] forKey:@"childPax"];
                //                    [orderDetails setObject:[bookingDetails valueForKey:@"occasionId"] forKey:@"occasionId"];
                //                    [orderDetails setObject:[bookingDetails valueForKey:@"occasionDesc"] forKey:@"occasionDesc"];
                //                    [orderDetails setObject:[bookingDetails valueForKey:@"reservationDateTimeStr"] forKey:@"reservationDateTimeStr"];
                //                    [orderDetails setObject:[bookingDetails valueForKey:@"specialInstructions"] forKey:@"specialInstructions"];
                //                    [orderDetails setObject:[bookingDetails valueForKey:@"mobileNumber"] forKey:@"mobileNumber"];
                //                    [orderDetails setObject:[NSNumber numberWithFloat:[netPayValLbl.text floatValue]] forKey:@"grandTotal"];
                //                    [orderDetails setObject:[NSNumber numberWithFloat:[tax floatValue]] forKey:@"tax"];
                //                    //            [orderDetails setObject:[NSNumber numberWithFloat:[billAmtValLbl.text floatValue]] forKey:kSubTotal];
                //                    [orderDetails setObject:[NSNumber numberWithFloat:[billAmtValLbl.text floatValue]] forKey:SUB_TOTAL];
                //
                //
                //
                //                    [orderDetails setObject:presentLocation forKey:STORE_LOCATION];
                //                    [orderDetails setObject:[NSNumber numberWithBool:NO] forKey:kIsTableChange];
                //                    [orderDetails setObject:[bookingDetails valueForKey:STATUS] forKey:STATUS];
                //
                //                    [orderDetails setObject:[bookingDetails valueForKey:@"gender"] forKey:@"gender"];
                //                    [orderDetails setObject:[bookingDetails valueForKey:@"carNumber"] forKey:@"carNumber"];
                //                    [orderDetails setObject:[bookingDetails valueForKey:@"salesLocation"] forKey:@"salesLocation"];
                //
                //                    //            if ([temparr count]) {
                //                    [orderDetails setObject:[NSNumber numberWithBool:YES] forKey:@"isItemsChange"];
                //                    [orderDetails setObject:temparr forKey:kItemDetails];
                //                    //        }
                //                    NSError * err;
                //                    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:orderDetails options:0 error:&err];
                //                    NSString * updateBookingJsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                //                    [HUD setHidden:NO];
                //
                //                    WebServiceController *controller = [[WebServiceController alloc] init];
                //                    [controller setRestaurantBookingServiceDelegate:self];
                //                    [controller updateRestBooking:updateBookingJsonStr];
                //
                //                }
                //                @catch (NSException *exception) {
                //
                //                    NSLog(@"%@",exception);
                //                }
                //                @finally
                //                {
                //                    [HUD setHidden:YES];
                //                }
                
            }
            else {
                
                float y_axis = self.view.frame.size.height - 120;
                [self displayAlertMessage:@"Please enable wifi or mobile data" horizontialAxis:(self.view.frame.size.width - 300)/2  verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
            }
        }
        else{
            
            y_axis = self.view.frame.size.height - 200;
            
            [self displayAlertMessage:@"Please add items" horizontialAxis:(self.view.frame.size.width - 360)/2 verticalAxis:y_axis msgType:@"Alert" conentWidth:300 contentHeight:60 isSoundRequired:YES timming:2.0 noOfLines:2];
        }
    }
}



- (IBAction)orderItems:(UIButton *)sender {
}

- (IBAction)printBill:(UIButton *)sender {
    
    BOOL itemsServed = false;
    
    // added by roja on 13/02/2019...
    // reason here we need to check the items-status weather items are served or not..
    if([cartItemDetails count]) {
        
        for (NSDictionary * itemDetailsDic in cartItemDetails) {
            
           NSString * itemStatusStr = [self checkGivenValueIsNullOrNil:[itemDetailsDic valueForKey:STATUS]  defaultReturn:@""];
            
            if ([itemStatusStr caseInsensitiveCompare:@"Served"] == NSOrderedSame  ||  [[self checkGivenValueIsNullOrNil:[itemDetailsDic valueForKey:kIsManuFacturedItem]  defaultReturn:ZERO_CONSTANT] boolValue]) {
                itemsServed = true;
            }
            else{
                break;
            }
        }
        
        if (itemsServed) {
            
            if(bookingTypeStr == nil)
                bookingTypeStr  = @"Telephone";
            
            BillingHome *billing = [[BillingHome alloc] init];
            billing.salesOrderIdStr = orderRef;
            billing.salesOrderBookingTypeStr = bookingTypeStr;
            billing.isOrderedBill = true;
            
            //        billing.cartItem = [[NSMutableArray alloc] init];
            //        billing.cartItem = [cartTotalItems mutableCopy];
            //        billing.order_id = orderRef;
            //        billing.order_type = @"immediate";
            //        billing.waiter_name = @"Ramesh";
            //        billing.table = [bookingDetails valueForKey:kTableNo];
            //        billing.emailTxt = [[UITextField alloc] init];
            //        billing.emailTxt.text = [bookingDetails valueForKey:kEmail];
            //        billing.phoneTxt = [[UITextField alloc] init];
            //        billing.phoneTxt.text = [bookingDetails valueForKey:kmobileNo];
            
            //        self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
            //        self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
            
            [self.navigationController pushViewController:billing animated:YES];
        }
        else{
            
            float y_axis = self.view.frame.size.height - 150;
            NSString * msg = @"All the items need to be served before bill.";
            [self displayAlertMessage:msg horizontialAxis:(self.view.frame.size.width - 350)/2  verticalAxis:y_axis  msgType:@""  conentWidth:350 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
        }
    }
    else {

        float y_axis = self.view.frame.size.height - 150;
        NSString * msg = @"Please add items";
        [self displayAlertMessage:msg horizontialAxis:(self.view.frame.size.width - 300)/2  verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:1];
    }
    
}

/**
 * @description  Here we are displaying pop up view controller for eating habits...
 * @date         14/03/2019
 * @method       eatingHabitsDropDownBtn
 * @author       Roja
 * @param
 * @param        NSDictionary
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (IBAction)eatingHabitsDropDownBtn:(UIButton *)sender {
    
    @try {
        AudioServicesPlaySystemSound (soundFileObject);
        
        isEatingHabitsDropDown = true;
        
        if ([tableNoTxt.text length] == 0) {

            float y_axis = self.view.frame.size.height / 2;
            NSString * mesg = @"Please select any table";
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2 verticalAxis:y_axis  msgType:@"" conentWidth:300 contentHeight:40  isSoundRequired:NO timming:2.0 noOfLines:2];
        }
        else if ([mobileNoTxt.text length] == 0){
            
            float y_axis = self.view.frame.size.height / 2;
            NSString * mesg = @"Please enter customer mobile number";
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2 verticalAxis:y_axis  msgType:@"" conentWidth:300 contentHeight:40  isSoundRequired:NO timming:2.0 noOfLines:2];
        }
        else if ([mobileNoTxt.text length] < 10){
            
            float y_axis = self.view.frame.size.height / 2;
            NSString * mesg = @"Please enter valid mobile number";
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2 verticalAxis:y_axis  msgType:@"" conentWidth:300 contentHeight:40  isSoundRequired:NO timming:2.0 noOfLines:2];
        }
        else{
            
            [self getCustomerEatingHabits:@""];
        }
        
        if ([tasteRequirmntArray count] && tasteRequirmntArray != nil) {
            
            PopOverViewController * customerInfoPopUp = [[PopOverViewController alloc] init];
            
            float tableHt = 0;
            if([tasteRequirmntArray count] && [tasteRequirmntArray count] <= 4) {
                tableHt = [tasteRequirmntArray count] * 40;
            }
            else if([tasteRequirmntArray count] && [tasteRequirmntArray count] > 4){
                tableHt = 4 * 40;
            }
            
            UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, eatingHabitsTF.frame.size.width, tableHt)];
            customView.opaque = NO;
            customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
            customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            customView.layer.borderWidth = 2.0f;
            [customView setHidden:NO];
            
            eatingHabitsTbl.frame = CGRectMake(0, 0, customView.frame.size.width, customView.frame.size.height);
            
            [customView addSubview:eatingHabitsTbl];
            
            customerInfoPopUp.view = customView;
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            [popover presentPopoverFromRect:eatingHabitsTF.frame inView:scrollView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            customerInfoPopOver= popover;
            
            UIGraphicsBeginImageContext(customView.frame.size);
            [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            customView.backgroundColor = [UIColor colorWithPatternImage:image];
        }
        
        //    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"currently_this_feature_is_unavailable", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Close", nil) otherButtonTitles:nil, nil];
        //
        //    [alert show];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [eatingHabitsTbl reloadData];
    }
}


- (IBAction)getCustomerInfo:(UIButton *)sender {
    
    @try {

        if ([mobileNoTxt.text length]==10) {
            
            [HUD setHidden:NO];
            
            AudioServicesPlaySystemSound(soundFileObject);
            
            if (!isOfflineService) {
                
                // showing the HUD ..
                
                @try{
                    [HUD setHidden:NO];
                    
                    if (sender == customerInfoBtn) {
                        ratingDetailsBtn.tag = 2;
                    }
                    
                    WebServiceController * controller = [WebServiceController new];
                    [controller setCustomerServiceDelegate:self];
                    
                    NSArray * customerDetailsKeys = [NSArray arrayWithObjects:@"email",@"mobileNumber",REQUEST_HEADER, nil];
                    
                    NSArray *customerDetailsObjects = [NSArray arrayWithObjects:@"",mobileNoTxt.text,[RequestHeader getRequestHeader], nil];
                    NSDictionary *requestDic = [NSDictionary dictionaryWithObjects:customerDetailsObjects forKeys:customerDetailsKeys];
                    
                    NSError * err_;
                    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:requestDic options:0 error:&err_];
                    NSString * RequestString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
                    [controller getCustomerDetails:RequestString];
                    
                    } @catch (NSException *exception) {
                    
                    [HUD setHidden:YES];
                }
            }
            
        }
        else {
          
            float y_axis = self.view.frame.size.height/2;
            NSString * msg = @"Please enter valid mobile number";
            [self displayAlertMessage:msg horizontialAxis:(self.view.frame.size.width - 300)/2  verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    @finally {
        [HUD setHidden:YES];
        
    }
}

-(void)getCustomerDetailsSuccessResponse:(NSDictionary *)successDictionary{
    
    @try{
        
        customerInfoDic = [successDictionary copy];
        
        if(ratingDetailsBtn.tag == 2){
            [self populateCustomerInfoPopUp:customerInfoDic];
        }
        
        if (![[customerInfoDic valueForKey:@"category"] isKindOfClass:[NSNull class]] && [customerInfoDic valueForKey:@"category"]!=nil) {
            
            [self provideCustomerRatingfor:[NSString stringWithFormat:@"%@",[customerInfoDic objectForKey:@"category"]]];
        }
        else {
            [self provideCustomerRatingfor:EXISTING_CUSTOMER];
        }
    }
    @catch(NSException * exception){
        
    }
    @finally{
        [HUD setHidden:YES];
    }
}

-(void)getCustomerDetailsErrorResponse:(NSString *)errorRespose{
    
    @try{
        
        if(ratingDetailsBtn.tag == 2){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:errorRespose delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
    @catch(NSException * exception){
        
    }
    @finally{
        [HUD setHidden:YES];
    }
}
#pragma -mark tableview delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
    if (tableView == menuTable) {
        
        return [menuItemsCategories count];
        
    }
    else {
        return 1;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (tableView == itemsTbl) {
            
            return 40.0;
        }
        else if (tableView == menuItems) {
            
            return 60.0;
        }
        else if(tableView == tasteRequirementsTbl){
            
            return 30;
        }
        else if (tableView == eatingHabitsTbl){
            
            return 40.0;
        }
        else  {
            
            if (indexPath.row == 0) {
                if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft)
                {
                    
                    return 80.0;
                }
                else {
                    return 100.0;
                }
            }
            else{
                if ((45.0*(itemsCount))<250.0) {
                    
                    return 45.0*(itemsCount);
                }
                else {
                    return 250.0;
                }
            }
        }
    }
    return 40.0;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.itemsTbl) {
        
        if ([cartItemDetails count]>0) {
            
            return [cartItemDetails count];
        }
        else {
            return 2;
        }
    }
    else if (tableView == menuTable) {
        
        if (self.isOpen) {
            if (self.selectIndex.section == section) {
                return 1 + 1;
            }
        }
        return 1;
    }
    else if(tableView == menuItems) {
        
        return itemsCount;
    }
    else if(tableView == tasteRequirementsTbl){
        
        return [tasteRequirmntArray count];
    }
    else if (tableView == eatingHabitsTbl){
        
        return [tasteRequirmntArray count];
    }

    return 2;
}


/**
 * @description  it is one of UITextField delagate method.
 * @method       tableView:-- cellForRowAtIndexPath:--
 * @author
 * @param        NSIndexPath
 * @param        UITableView
 * @return       UITableViewCell
 *
 * @modified BY  Roja on 14/03/2019....
 * @reason       In itemsTbl-- As per latest GUI added some more fields and setting there frames and assing values....
 *
 * @return
 * @verified By
 * @verified On
 *
 */
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    tableView.separatorColor = [UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0];
    
    static NSString *hlCellID = @"hlCellID";
    
    UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
    
    static NSString *MyIdentifier = @"MyIdentifier";
    MyIdentifier = @"TableView";
    
    if ([hlcell.contentView subviews]){
        for (UIView *subview in [hlcell.contentView subviews]) {
            [subview removeFromSuperview];
        }
    }
    
    if(hlcell == nil){
        hlcell =  [[UITableViewCell alloc]
                   initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID];
        hlcell.accessoryType = UITableViewCellAccessoryNone;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            hlcell.textLabel.font = [UIFont boldSystemFontOfSize:18];
        }
        else {
            hlcell.textLabel.font = [UIFont boldSystemFontOfSize:12];
        }
    }
    if (tableView == self.itemsTbl) {
        
        @try {
            
//            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            tableView.separatorColor = [UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0];

            UILabel *sNoValueLbl = [[UILabel alloc] init];
            sNoValueLbl.backgroundColor = [UIColor blackColor];
            sNoValueLbl.textAlignment = NSTextAlignmentCenter;
            sNoValueLbl.numberOfLines = 2;
            sNoValueLbl.lineBreakMode = NSLineBreakByWordWrapping;
            sNoValueLbl.textColor = [UIColor whiteColor];
            sNoValueLbl.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
            //            sNoValueLbl.layer.borderWidth = 1.5;
            //            sNoValueLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            //            sNoValueLbl.font = [UIFont systemFontOfSize:13.0];

            
            menuItem = [[UIButton alloc] init] ;
            menuItem.backgroundColor = [UIColor blackColor];
            menuItem.titleLabel.textColor = [UIColor whiteColor];
            menuItem.userInteractionEnabled = YES;
            menuItem.lineBreakMode = NSLineBreakByTruncatingTail;
            //            [menuItem addTarget:self action:@selector(populateMenu:) forControlEvents:UIControlEventTouchUpInside];
//            menuItem.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
//            menuItem.layer.borderWidth = 1.5;
            //            menuItem.titleLabel.font = [UIFont systemFontOfSize:13.0];

            menuItem.tag = indexPath.row;
            
            UILabel *description = [[UILabel alloc] init] ;
            description.backgroundColor = [UIColor blackColor];
            description.textColor = [UIColor whiteColor];
            description.userInteractionEnabled = YES;
            description.tag = indexPath.row;
            description.lineBreakMode = NSLineBreakByTruncatingTail;

//            description.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
//            description.layer.borderWidth = 1.5;
            //            description.font = [UIFont systemFontOfSize:13.0];

            UILabel *priceValueLbl = [[UILabel alloc] init];
            priceValueLbl.backgroundColor = [UIColor blackColor];
            priceValueLbl.textAlignment = NSTextAlignmentCenter;
            priceValueLbl.textColor = [UIColor whiteColor];
            //            priceValueLbl.font = [UIFont systemFontOfSize:13.0];
//            priceValueLbl.layer.borderWidth = 1.5;
//            priceValueLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;

            
            qty = [[UIButton alloc] init] ;
            qty.backgroundColor = [UIColor blackColor];
            qty.titleLabel.textColor = [UIColor whiteColor];
            qty.userInteractionEnabled = YES;
            qty.tag = indexPath.row;
//            qty.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
//            qty.layer.borderWidth = 1.5;
//            qty.titleLabel.font = [UIFont systemFontOfSize:13.0];

            
            UILabel * addOnValueLbl = [[UILabel alloc] init];
            addOnValueLbl.backgroundColor = [UIColor blackColor];
            addOnValueLbl.textAlignment = NSTextAlignmentCenter;
            addOnValueLbl.textColor = [UIColor whiteColor];

            
//            UILabel * tasteRecommendationValue = [[UILabel alloc] init];
//            tasteRecommendationValue.backgroundColor = [UIColor blackColor];
//            tasteRecommendationValue.textColor = [UIColor whiteColor];
//            tasteRecommendationValue.textAlignment = NSTextAlignmentLeft;
//            tasteRecommendationValue.numberOfLines = 2;
//            tasteRecommendationValue.textAlignment = NSTextAlignmentCenter;
           
            tasteRequirementBtn = [[UIButton alloc] init] ;
            tasteRequirementBtn.backgroundColor = [UIColor blackColor];
            tasteRequirementBtn.titleLabel.textColor = [UIColor whiteColor];
            tasteRequirementBtn.userInteractionEnabled = YES;
            tasteRequirementBtn.tag = indexPath.row;
            [tasteRequirementBtn addTarget:self action:@selector(populateTasteRequirementView:) forControlEvents:UIControlEventTouchUpInside];

            UILabel *statusBackGroundLbl = [[UILabel alloc] init];
            statusBackGroundLbl.backgroundColor = [UIColor blackColor];
            statusBackGroundLbl.textColor = [UIColor whiteColor];
            statusBackGroundLbl.textAlignment = NSTextAlignmentLeft;
            statusBackGroundLbl.numberOfLines = 2;
            statusBackGroundLbl.textAlignment = NSTextAlignmentCenter;
//            statusBackGroundLbl.font = [UIFont systemFontOfSize:13.0];
//            statusBackGroundLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
//            statusBackGroundLbl.layer.borderWidth = 1.5;

            
            UIButton  *status = [[UIButton alloc] init] ;
            status.backgroundColor = [UIColor blackColor];
            status.titleLabel.textColor = [UIColor whiteColor];
            status.userInteractionEnabled = NO;
            //            [status addTarget:self action:@selector(populateQtyView:) forControlEvents:UIControlEventTouchUpInside];
            status.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            status.layer.borderWidth = 1.5;
            //            status.titleLabel.font = [UIFont systemFontOfSize:13.0];

            status.tag = indexPath.row;
            
            UIButton *delrowbtn = [[UIButton alloc] init] ;
            [delrowbtn setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
            [delrowbtn addTarget:self action:@selector(delRow:) forControlEvents:UIControlEventTouchUpInside];
            delrowbtn.tag = indexPath.row;
            delrowbtn.backgroundColor = [UIColor clearColor];
            delrowbtn.hidden = YES;
            
            [hlcell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            hlcell.frame = CGRectMake(0, 0, scrollView.frame.size.width, 40.0);
            
            sNoValueLbl.font = [UIFont systemFontOfSize:18];
            menuItem.titleLabel.font = [UIFont systemFontOfSize:18];
            description.font = [UIFont systemFontOfSize:18];
            priceValueLbl.font = [UIFont systemFontOfSize:18];
            qty.titleLabel.font = [UIFont systemFontOfSize:18];
            tasteRequirementBtn.titleLabel.font = [UIFont systemFontOfSize:18];
//            tasteRecommendationValue.font = [UIFont systemFontOfSize:18];
            statusBackGroundLbl.font = [UIFont systemFontOfSize:18];
            status.titleLabel.font = [UIFont systemFontOfSize:18];
            delrowbtn.titleLabel.font = [UIFont systemFontOfSize:18];
            addOnValueLbl.font = [UIFont systemFontOfSize:18];
            
            sNoValueLbl.frame = CGRectMake(sNoLbl.frame.origin.x, 0, sNoLbl.frame.size.width, hlcell.frame.size.height);
            
            menuItem.frame = CGRectMake(menuItemLbl.frame.origin.x, 0, menuItemLbl.frame.size.width, hlcell.frame.size.height);
            
            description.frame = CGRectMake(descriptionLbl.frame.origin.x + 5, 0, descriptionLbl.frame.size.width - 5,  hlcell.frame.size.height);
            
            priceValueLbl.frame = CGRectMake(priceLbl.frame.origin.x, 0, priceLbl.frame.size.width, hlcell.frame.size.height);
            
            qty.frame = CGRectMake(qtyLbl.frame.origin.x, 0, qtyLbl.frame.size.width, hlcell.frame.size.height);
            
            addOnValueLbl.frame = CGRectMake(addOnLbl.frame.origin.x, 0, addOnLbl.frame.size.width, hlcell.frame.size.height);
            
            tasteRequirementBtn.frame = CGRectMake(tasteRecommendationsLbl.frame.origin.x, 0, tasteRecommendationsLbl.frame.size.width, hlcell.frame.size.height);
            
            statusBackGroundLbl.frame = CGRectMake(statusLbl.frame.origin.x, 0, statusLbl.frame.size.width, hlcell.frame.size.height);
            
            status.frame = CGRectMake((statusLbl.frame.origin.x + statusLbl.frame.size.width/2)-17, 3, 35, 35);
            
            delrowbtn.frame = CGRectMake((statusLbl.frame.origin.x + statusLbl.frame.size.width), 0, 40,40);
            
            
            [hlcell.contentView addSubview:sNoValueLbl];
            [hlcell.contentView addSubview:menuItem];
            [hlcell.contentView addSubview:description];
            [hlcell.contentView addSubview:priceValueLbl];
            [hlcell.contentView addSubview:qty];
            [hlcell.contentView addSubview:tasteRequirementBtn];
            [hlcell.contentView addSubview:statusBackGroundLbl];
            [hlcell.contentView addSubview:status];
            [hlcell.contentView addSubview:addOnValueLbl];
            [hlcell.contentView addSubview:delrowbtn];

            [hlcell setBackgroundColor:[UIColor clearColor]];
            
            status.layer.cornerRadius = status.frame.size.height/2;
            
            @try {
                
                if ([cartItemDetails count]) {
                    
                    NSDictionary * tempDic = [cartItemDetails objectAtIndex:indexPath.row];
                    
                    NSString * itemSkuIdStr = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:ITEM_SKU]  defaultReturn:@""];
                    NSString * itemDescStr = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:ITEM_DESCRIPTION_]  defaultReturn:@""];
                    NSString * itemPriceStr =  [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[tempDic valueForKey:SALE_PRICE]  defaultReturn:@"0.00"] floatValue]];
                    NSString * itemQtyStr = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[tempDic valueForKey:ORDERED_QUANTITY]  defaultReturn:@"0.00"] floatValue]];
                    
                    if(!itemDescStr.length)
                        itemDescStr = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:ITEM_NAME]  defaultReturn:@""];
                    
                    NSString * itemRemarksStr = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:@"tastePattern"] defaultReturn:@"--"];// REMARKS
                    
//                    NSString * itemRemarksStr = @"--";//Add Taste Requirements

                    NSString * itemStausStr = [self checkGivenValueIsNullOrNil:[tempDic valueForKey:STATUS]  defaultReturn:@""];
                    
                    //ITEM_SKU @"skuId" --  ITEM_CODE @"itemCode" -- ITEM_DESCRIPTION @"itemDescription" -- QUANTITY @"quantity" -- ITEM_UNIT_PRICE @"price" -- TOTAL @"total" -- REMARKS @"remarks" -- STATUS @"status" --  PLU_CODE @"pluCode"
                    [menuItem setTitle:itemSkuIdStr forState:UIControlStateNormal];
                    description.text = itemDescStr;
                    priceValueLbl.text = itemPriceStr;
                    [qty setTitle:itemQtyStr forState:UIControlStateNormal];
                    [tasteRequirementBtn setTitle:itemRemarksStr forState:UIControlStateNormal];
//                    tasteRecommendationValue.text = itemRemarksStr;
                    
                    addOnValueLbl.text = @"--";
                    
                    // Changing Colors to status's
                    if ([itemStausStr caseInsensitiveCompare:@"Getting Prepared"] == NSOrderedSame) { //getting prepepared
                        
                        [status setBackgroundColor:[UIColor orangeColor]];
                    }
                    else  if ([itemStausStr caseInsensitiveCompare:@"Ready From Kitchen"] == NSOrderedSame) {//ready from kitchen
                        
                        [status addTarget:self action:@selector(updateItemStatus:) forControlEvents:UIControlEventTouchUpInside];
                        status.userInteractionEnabled = YES;
                        [status setBackgroundColor:[UIColor greenColor]];
                    }
                    else if([itemStausStr caseInsensitiveCompare:@"Served"] == NSOrderedSame){
                        
                        [status setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:252.0/255.0 blue:72.0/255.0 alpha:1.0]];
                    }
                    else if([itemStausStr caseInsensitiveCompare:ORDERED] == NSOrderedSame)  { //@"Confirmed"
                        
                        [status setBackgroundColor:[UIColor blueColor]];
                    }
                    else{ // Ordered or Draft (save btn) and item just added
 
                        [status setBackgroundColor:[UIColor clearColor]];
                    }
                    
                    if([[self checkGivenValueIsNullOrNil:[tempDic valueForKey:IS_VOID] defaultReturn:0] boolValue]){
                        
                        [delrowbtn setImage:[UIImage imageNamed:@"enable.png"] forState:UIControlStateNormal];
                        [sNoValueLbl setTextColor:[[UIColor whiteColor] colorWithAlphaComponent:0.4f]];
                        [priceValueLbl setTextColor:[[UIColor whiteColor] colorWithAlphaComponent:0.4f]];
                        [menuItem setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.4f] forState:UIControlStateNormal];
                        [description setTextColor:[[UIColor whiteColor] colorWithAlphaComponent:0.4f]];
                        [qty setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.4f] forState:UIControlStateNormal];
                        [tasteRequirementBtn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.4f] forState:UIControlStateNormal];
//                        [tasteRecommendationValue setTextColor:[[UIColor whiteColor] colorWithAlphaComponent:0.4f]];
                        [statusBackGroundLbl setTextColor:[[UIColor whiteColor] colorWithAlphaComponent:0.4f]];
                        
                        [status.titleLabel setTextColor:[[UIColor whiteColor] colorWithAlphaComponent:0.4f]];
                        [qty setUserInteractionEnabled:NO];
                        [tasteRequirementBtn setUserInteractionEnabled:NO];
                        
                    }
                    delrowbtn.hidden = NO;
                    [qty addTarget:self action:@selector(populateQtyView:) forControlEvents:UIControlEventTouchUpInside];

                }
            } @catch (NSException *exception) {
                
            }
            return hlcell;
        }
        @catch (NSException *exception) {
            
            NSLog(@"%@",exception.name);
        }
    }
    else if (tableView == menuTable) {
        
        @try {
            
            if (self.isOpen&&self.selectIndex.section == indexPath.section&&indexPath.row!=0) {
                
                static NSString *hlCellID = @"hlCellID";
                
                UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
                
                if ([hlcell.contentView subviews]){
                    
                    for (UIView *subview in [hlcell.contentView subviews]) {
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
                    
                    //  NSDictionary *dic = [priceDic objectAtIndex:indexPath.row];
                    menuItems = [[UITableView alloc] init];
                    [menuItems setDataSource:self];
                    [menuItems setDelegate:self];
                    menuItems.backgroundColor = [UIColor clearColor];
                    [menuItems setSeparatorColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.2f]];
                    menuItems.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
                    
                    [hlcell setSelectionStyle:UITableViewCellSelectionStyleNone];
                    
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        
                        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
                            if ((70*(itemsCount))<350.0) {
                                
                                hlcell.frame = CGRectMake(0, 0,menuTable.frame.size.width,  45*(itemsCount));
                                menuItems.frame = CGRectMake(0, 5,hlcell.frame.size.width, 45.0*(itemsCount));
                            }
                            else {
                                hlcell.frame = CGRectMake(0, 0,menuTable.frame.size.width,250.0);
                                menuItems.frame = CGRectMake(0, 5,hlcell.frame.size.width,250.0);
                            }
                        }
                        else {
                            //skid.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:22];
                            menuItems.frame = CGRectMake(5, 0, 125, 56);
                        }
                    }
                    else {
                        menuItems.frame = CGRectMake(5, 0, 58, 34);
                    }
                    
                    [hlcell setBackgroundColor:[UIColor clearColor]];
                    [hlcell.contentView addSubview:menuItems];
                }
                @catch (NSException *exception) {
                    NSLog(@"%@",exception);
                }
                return hlcell;
            }
            else
            {
                static NSString *CellIdentifier = @"Cell3";
                
                Cell3_ = (Cell3*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (!Cell3_) {
                    Cell3_ = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
                }
                @try {
                    NSString *name = [menuItemsCategories objectAtIndex:indexPath.section];
                    Cell3_.titleLabel.text = name;
                    //                    Cell3_.itemImageView.image = [UIImage imageWithData:[itemCategoryImages objectAtIndex:indexPath.section]];
                    
                    Cell3_.orderedQuantity.hidden = YES;
                    
                }
                @catch (NSException *exception) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Failed to get the Menu" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    
                }
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                    
                    Cell3_.frame = CGRectMake(0, 0,550,70);
                    
                    Cell3_.itemImageView.frame = CGRectMake(0, 8, 45, 45);
                    Cell3_.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
                    Cell3_.titleLabel.frame = CGRectMake(55,5,200 ,60);
                    Cell3_.arrowImageView.frame = CGRectMake(280, 20, 30, 30);
                }
                else {
                    if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
                        
                        //                        Cell3_.itemImageView.frame = CGRectMake(0, 8, 45, 45);
                        Cell3_.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0f];
                        Cell3_.titleLabel.frame = CGRectMake(80,17,400 ,60);
                        Cell3_.arrowImageView.frame = CGRectMake(menuTable.frame.size.width-100, 15, 50, 50);
                    }
                }
                Cell3_.itemImageView.hidden = YES;
                [Cell3_ changeArrowWithUp:([self.selectIndex isEqual:indexPath]?YES:NO)];
                [Cell3_ setBackgroundColor:[UIColor blackColor]];
                return Cell3_;
            }
        }
        @catch (NSException *exception) {
            
        }
    }
    else if (tableView == menuItems) {
        
        static NSString *CellIdentifier = @"Cell4";
        Cell4_ = (Cell4*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!Cell4_) {
            Cell4_ = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
        }
        
        @try {
            [Cell4_ setBackgroundColor:[UIColor blackColor]];
            
            NSMutableArray *titleList = [menuItemDescArr objectAtIndex:self.selectIndex.section];
            NSMutableArray * priceList_ = [priceList objectAtIndex:self.selectIndex.section];
            NSMutableArray *itemImageList_ = [itemImageArray objectAtIndex:self.selectIndex.section];
            
            Cell4_.titleLabel.text = [titleList objectAtIndex:indexPath.row];
            Cell4_.priceLabel.text = [NSString stringWithFormat:@"%.2f",[[priceList_ objectAtIndex:indexPath.row] floatValue]];
            Cell4_.titleImage.image = [UIImage imageWithData:[itemImageList_ objectAtIndex:indexPath.row ]] ;
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            
            Cell4_.frame = CGRectMake(0, 0, 550, 70);
            Cell4_.titleImage.frame = CGRectMake(10, 8, 30.0, 30.0);
            Cell4_.titleLabel.frame = CGRectMake(50, 15, 220, 16);
            Cell4_.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
            Cell4_.priceLabel.frame = CGRectMake(250,15 ,55,16);
            Cell4_.priceLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
        }
        else {
            if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
                
                Cell4_.frame = CGRectMake(0, 0, 550, 60);
                Cell4_.titleLabel.frame = CGRectMake(120, 15, 250, 16);
                Cell4_.titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0f];
                Cell4_.priceLabel.frame = CGRectMake(550,15 ,200,16);
                Cell4_.priceLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0f];
            }
        }
        Cell4_.titleImage.hidden = YES;
        return Cell4_;
    }
    
    else if(tableView == tasteRequirementsTbl){//Added by Roja on 02/04/2019....
        
        static NSString *hlCellID = @"hlCellID";
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
        
        static NSString *MyIdentifier = @"MyIdentifier";
        MyIdentifier = @"TableView";
        
        if ([hlcell.contentView subviews]){
            for (UIView *subview in [hlcell.contentView subviews]) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                       initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                hlcell.textLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
            }
            else {
                hlcell.textLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:12];
            }
        }
        
        hlcell.textLabel.text = [NSString stringWithFormat:@"%@",[tasteRequirmntArray objectAtIndex:indexPath.row]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        return hlcell;
    }
    else if (tableView == eatingHabitsTbl){//Added by Roja on 02/04/2019....
        
        static NSString *hlCellID = @"hlCellID";
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
        
        static NSString *MyIdentifier = @"MyIdentifier";
        MyIdentifier = @"TableView";
        
        if ([hlcell.contentView subviews]){
            for (UIView *subview in [hlcell.contentView subviews]) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                       initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                hlcell.textLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18.0];
            }
            else {
                hlcell.textLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:12];
            }
        }
        
        hlcell.textLabel.text = [NSString stringWithFormat:@"%@",[tasteRequirmntArray objectAtIndex:indexPath.row]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        return hlcell;
    }
    
    return hlcell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AudioServicesPlaySystemSound (soundFileObject);

    if (tableView == menuTable) {
        
        @try {
            
            if (indexPath.row == 0) {
                
                // Cell3_ = (Cell3_ *)[tableView cellForRowAtIndexPath:indexPath.row];
                
                if ([indexPath isEqual:self.selectIndex]) {
                    self.isOpen = NO;
                    //changed by Srinviaslulu on 05/01/2018
                    //                itemsCount = [[totalItemsArray objectAtIndex: self.selectIndex.section] count];
                    
                    itemsCount = (int)[[priceList objectAtIndex: self.selectIndex.section] count];
                    [self didSelectCellRowFirstDo:NO nextDo:NO];
                    self.selectIndex = nil;
                    
                }else
                {
                    if (!self.selectIndex) {
                        self.selectIndex = indexPath;
                        //                    itemsCount = [[totalItemsArray objectAtIndex: self.selectIndex.section] count];
                        itemsCount = (int)[[priceList objectAtIndex: self.selectIndex.section] count];
                        
                        [self didSelectCellRowFirstDo:YES nextDo:NO];
                        
                    }else
                    {
                        
                        NSLog(@" itemscount %d",itemsCount);
                        
                        [self didSelectCellRowFirstDo:NO nextDo:YES];
                    }
                }
                indexNo =(int)indexPath.section;
                //Cell3_ = (Cell3_ *)[tableView cellForRowAtIndexPath:indexPath.section];
                selectedItem = [menuItemsCategories objectAtIndex:indexPath.section];
                
                
                
                
            }else
            {
                //            menuTable.userInteractionEnabled  = NO;
                //            //            ordersTable1.userInteractionEnabled = NO;
                //            //
                //            //            order.enabled = false;
                //            //            cancel.enabled = false;
                //            //
                //            //            rejectQtyChangeDisplayView = [[UIView alloc]init];
                //
                //            Cell4_ = (Cell4_ *)[tableView cellForRowAtIndexPath:indexPath];
                //
                //            selectedIndex = self.selectIndex.section;
                //
                //            UIButton *btn = [[UIButton alloc] init];
                //            btn.tag = indexPath.row-1;
                //            [self addItemsToCart:btn];
                
                
            }
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
    else if (tableView == menuItems) {
        @try {
            
            Cell4_ = (Cell4 *)[tableView cellForRowAtIndexPath:indexPath];
            
            selectedIndex = (int)self.selectIndex.section;
            
            UIButton *btn = [[UIButton alloc] init];
            btn.tag=indexPath.row;
            [self addItemsToCart:btn];
            
        }
        @catch (NSException *exception) {
            
            NSLog(@"%@",exception);
        }
        
    }
    else if (tableView == tasteRequirementsTbl){ // added by roja on 01/04/2019.
        
        @try {
            
            NSString * selectedTasteRequirementStr = [tasteRequirmntArray objectAtIndex:indexPath.row];
            
            NSMutableDictionary * selectedItemsDic = [cartItemDetails objectAtIndex:tasteRequirmentTF.tag];
            
            NSString * tasteRequirmentMainString = tasteRequirmentTF.text;
            
            if ([tasteRequirmentMainString length] == 0 || [tasteRequirmentMainString isEqualToString:@"--"] || [tasteRequirmentMainString isEqualToString:@""]) {
                
                tasteRequirmentMainString = selectedTasteRequirementStr;
            }
            else{
                
                tasteRequirmentMainString =  [[tasteRequirmentMainString stringByAppendingString:@","] stringByAppendingString:selectedTasteRequirementStr];
            }
            
            tasteRequirmentTF.text = tasteRequirmentMainString;
            
            [selectedItemsDic setValue:tasteRequirmentTF.text forKey:@"tastePattern"];
            [cartItemDetails replaceObjectAtIndex:tasteRequirmentTF.tag withObject:selectedItemsDic];
            
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
    else if (tableView == eatingHabitsTbl){ // added by roja on 02/04/2019.
    
        @try {
            eatingHabitsTF.text = [tasteRequirmntArray objectAtIndex:indexPath.row];

        } @catch (NSException *exception) {
            
        } @finally {
            
            [customerInfoPopOver dismissPopoverAnimated:YES];
        }
    }
}


- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert
{
    self.isOpen = firstDoInsert;
    
    @try {
        Cell3_ = (Cell3 *)[menuTable cellForRowAtIndexPath:self.selectIndex];
        [Cell3_ changeArrowWithUp:firstDoInsert];
        
        [menuTable beginUpdates];
        
        int section = (int)self.selectIndex.section;
        int contentCount = 1;
        
        
        NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
        for (NSUInteger i = 1; i < contentCount+1 ; i++) {
            NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:section];
            [rowToInsert addObject:indexPathToInsert];
        }
        
        if (firstDoInsert)
        {
            [menuTable insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
        }
        else
        {
            [menuTable deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
        }
        
        
        [menuTable endUpdates];
        
        if (nextDoInsert) {
            self.isOpen = YES;
            self.selectIndex = [menuTable indexPathForSelectedRow];
            //            NSLog(@"%d",_selectIndex.section);
            //            itemsCount = [[totalItemsArray objectAtIndex:_selectIndex.section] count];
            [self didSelectCellRowFirstDo:YES nextDo:NO];
        }
        if (self.isOpen) [menuTable scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@ exception",exception);
    }
    
    
}

#pragma -mark end of tableview delegates

-(void)populateMenu:(id)sender {
    
    @try {
        
        itemDetailsArr = [NSMutableArray new];
        NSIndexPath *selectedRow = [NSIndexPath indexPathForRow:[sender tag] inSection:0];
        selectedCell = [self.itemsTbl cellForRowAtIndexPath:selectedRow];
        
        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        
        customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 700, 600)];
        customView.opaque = NO;
        customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customView.layer.borderWidth = 2.0f;
        [customView setHidden:NO];
        customView.backgroundColor = [UIColor blackColor];
        
        NSArray *segmentLabels = [NSArray arrayWithObjects:NSLocalizedString(@"FoodService", nil),NSLocalizedString(@"DrinkService", nil), nil];
        
        mainSegmentControl = [[UISegmentedControl alloc] initWithItems:segmentLabels];
        
        mainSegmentControl.tintColor=[UIColor colorWithRed:145.0/255.0 green:145.0/255.0 blue:145.0/255.0 alpha:1.0];
        mainSegmentControl.segmentedControlStyle = UISegmentedControlStyleBar;
        mainSegmentControl.backgroundColor = [UIColor blackColor];
        
        
        mainSegmentControl.selectedSegmentIndex = 0;
        [mainSegmentControl addTarget:self action:@selector(mainSegmentAction:) forControlEvents:UIControlEventValueChanged];
        
        // assigning a value to check the bill finished ..
        mainSegmentControl.tag = 0;
        
        menuTable = [[UITableView alloc] init];
        menuTable.backgroundColor = [UIColor clearColor];
        [menuTable setDataSource:self];
        [menuTable setDelegate:self];
        [menuTable.layer setBorderWidth:1.0f];
        menuTable.layer.cornerRadius = 3;
        menuTable.layer.borderColor = [UIColor grayColor].CGColor;
        menuTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        menuTable.layer.borderWidth = 3.0f;
        menuTable.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.5f].CGColor;
        menuTable.layer.cornerRadius = 10.0f;
        menuTable.sectionFooterHeight = 0;
        menuTable.sectionHeaderHeight = 0;
        menuTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            mainSegmentControl.frame = CGRectMake(0,0, customView.frame.size.width,50);
            menuTable.frame = CGRectMake(0, (mainSegmentControl.frame.origin.y+mainSegmentControl.frame.size.height+5), customView.frame.size.width, customView.frame.size.height - (mainSegmentControl.frame.origin.y+mainSegmentControl.frame.size.height+5));
            
            mainSegmentControl.tintColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
            mainSegmentControl.backgroundColor = [UIColor blackColor];
            NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont boldSystemFontOfSize:25], UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor,
                                        nil];
            [mainSegmentControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
        }
        
        [customView addSubview:menuTable];
        [customView addSubview:mainSegmentControl];
        customerInfoPopUp.view = customView;
        
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            [popover presentPopoverFromRect:menuItem.frame inView:selectedCell permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
            
            catPopOver = popover;
            
        }
        
        else {
            
            customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            // popover.contentViewController.view.alpha = 0.0;
            [[[popover contentViewController]  view] setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:1.0f]];
            [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            catPopOver = popover;
            
        }
        
        defaults = [NSUserDefaults standardUserDefaults];
        
        if ([[defaults objectForKey:@"menuCategories"] count]!=0 && false) {
            
            menuItemsCategories = [[defaults objectForKey:@"menuCategories"] mutableCopy];
            menuItemDescArr = [[defaults objectForKey:@"menuItemDesc"] mutableCopy];
            itemCategoryImages = [[defaults objectForKey:@"categoryImages"] mutableCopy];
            itemImageArray = [[defaults objectForKey:@"itemImages"] mutableCopy];
            totalItemsArray = [[defaults objectForKey:@"items"] mutableCopy];
            priceList = [[defaults objectForKey:@"priceList"] mutableCopy];
            
            menuItemsStatus = FALSE;
            
            [menuTable reloadData];
        }
        menuItemsStatus = true;
        
        if (menuItemsStatus) {
            
            menuItemsCategories = [[NSMutableArray alloc] init];
            menuItemDescArr = [NSMutableArray new];
            itemCategoryImages = [[NSMutableArray alloc] init];
            totalItemsArray = [[NSMutableArray alloc] init];
            priceList = [[NSMutableArray alloc] init];
            itemImageArray = [[NSMutableArray alloc] init];
            
            menuItemsSkuIdArr = [[NSMutableArray alloc] init];
            menuItemsPluCodeArr = [[NSMutableArray alloc] init];
            
            NSArray *keys = [NSArray arrayWithObjects:@"menu_name",@"outlet_name",START_INDEX,REQUEST_HEADER, nil];
            
            NSArray *objects = [NSArray arrayWithObjects:@"Recafe Menu",presentLocation,@"0",[RequestHeader getRequestHeader], nil];
            NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            
            NSError * err_;
            NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
            NSString * reqStr = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
            @try {
                
                WebServiceController *controller = [WebServiceController new];
                [controller setGetMenuServiceDelegate:self];
                //                [controller getMenuCategories:reqStr];
                [controller getMenuCategoriesWithRestFullServiceSynchrousRequest:reqStr];//                [controller getMenuItems:reqStr];
                //                [controller getMenuItemsWithRestFullService:reqStr];
                [controller getMenuItemsWithRestFullServiceSynchrousRequest:reqStr];
                
            }
            @catch (NSException *exception) {
                
                NSLog(@"Exception occured %@",exception.name);
                
            }
            menuItemsStatus = FALSE;
            [menuTable reloadData];
        }
        if ([menuItemsCategories count] == 0) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Failed to get the Menu", @"failure")  message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        [HUD setHidden:YES];
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
        [HUD setHidden:YES];
    }
    
    
}
#pragma -mark menu service delegates

-(void)getCategorySuccessResponse:(NSDictionary *)sucess {
    
    if (sucess!= (NSDictionary *)[NSNull null] && [sucess count]!=0) {
        
        NSArray *temp = [sucess objectForKey:@"menu_category_details"];
        for (int i = 0; i < [temp count]; i++) {
            NSDictionary *itemDic = [temp objectAtIndex:i];
            [menuItemsCategories addObject:[NSString stringWithFormat:@"%@",[itemDic objectForKey:@"category_desc"]]];
        }
    }
}

-(void)getCategoryFailureResponse:(NSString *)failure {
   
    float y_axis = self.view.frame.size.height - 120;
    NSString * msg = failure;
    [self displayAlertMessage:msg horizontialAxis:(self.view.frame.size.width - 350)/2  verticalAxis:y_axis  msgType:@""  conentWidth:350 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
    
}

-(void)getMenuItemsSuccessResponse:(NSDictionary *)sucess {
    
    @try {
        if ([sucess count]) {
            NSArray *temp = [sucess objectForKey:@"menu_item_details"];
            
            for (int c = 0; c < [menuItemsCategories count]; c++) {
                NSMutableArray *categoryItem = [[NSMutableArray alloc] init];
                NSMutableArray *itemPrice = [[NSMutableArray alloc] init];
                NSMutableArray *itemImage = [[NSMutableArray alloc] init];
                NSMutableArray *itemNames = [[NSMutableArray alloc]init];
                
                NSMutableArray * itemSkuIds = [[NSMutableArray alloc] init];
                NSMutableArray * itemPlucodes = [[NSMutableArray alloc]init];
                for (int h = 0; h < [temp count]; h++) {
                    NSDictionary *dic = [temp objectAtIndex:h];
                    if ([[dic objectForKey:@"category_name"] isEqualToString:[menuItemsCategories objectAtIndex:c]]) {
                        [categoryItem addObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"item_name"]]];
                        [itemNames addObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"item_desc"]]];
                        [itemPrice addObject:[NSString stringWithFormat:@"%.02f",[[dic objectForKey:@"unit_price"] floatValue]]];
                        
                        [itemSkuIds addObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"sku_id"]]];
                        [itemPlucodes addObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"pluCode"]]];
                        
                        
                        
                        
                        //commented by Srinivasulu on 05/01/2019..
                        //                        NSArray *strings = [dic objectForKey:kItemIcon];
                        //
                        //                        if ([strings count] > 0) {
                        //                            unsigned c = strings.count;
                        //                            uint8_t *bytes = (uint8_t*)malloc(sizeof(*bytes) * c);
                        //
                        //                            unsigned i;
                        //                            for (i = 0; i < c; i++)
                        //                            {
                        //                                NSString *str = [strings objectAtIndex:i];
                        //                                int byte = [str intValue];
                        //                                bytes[i] = byte;
                        //                            }
                        //                            @try {
                        //                                NSData *imageData = [NSData dataWithBytesNoCopy:bytes length:c freeWhenDone:YES];
                        //                                //  UIImage *image = [UIImage imageWithData:imageData];
                        //                                [itemImage addObject:imageData];
                        //                            }
                        //                            @catch (NSException *exception) {
                        //                                NSData *imgData = UIImageJPEGRepresentation([UIImage imageNamed:@"Popular_Menu.png"],1.0);
                        //                                [itemImage addObject:imgData];
                        //                            }
                        //
                        //                        }
                        //                        else{
                        //                            NSData *imgData = UIImageJPEGRepresentation([UIImage imageNamed:@"Popular_Menu.png"],1.0);
                        //                            [itemImage addObject:imgData];
                        //                        }
                    }
                }
                [priceList addObject:itemPrice];
                [totalItemsArray addObject:categoryItem];
                [itemImageArray addObject:itemImage];
                [menuItemDescArr addObject:itemNames];
                [menuItemsSkuIdArr addObject:itemSkuIds];
                [menuItemsPluCodeArr addObject:itemPlucodes];
                
            }
            // saving values in user defaults....
            [defaults setObject:menuItemsCategories forKey:@"menuCategories"];
            [defaults setObject:itemCategoryImages forKey:@"categoryImages"];
            [defaults setObject:itemImageArray forKey:@"itemImages"];
            [defaults setObject:totalItemsArray forKey:@"items"];
            [defaults setObject:priceList forKey:@"priceList"];
            [defaults setObject:menuItemDescArr forKey:@"menuItemDesc"];
            
            BOOL status = FALSE;
            status = [defaults synchronize];
            if (status) {
                
                NSLog(@"Menu saved");
            }
            
        }
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
    }
    @finally {
        
        
    }
    
    
}
-(void)getMenuItemsFailureResponse:(NSString *)failure {
    
    float y_axis = self.view.frame.size.height - 120;
    NSString * msg = failure;
    [self displayAlertMessage:msg horizontialAxis:(self.view.frame.size.width - 350)/2  verticalAxis:y_axis  msgType:@""  conentWidth:350 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
}


#pragma mark End of Get SKU Details Service Reposnse Delegates -



#pragma mark End of Get Deals And Offers Service Reposnse Delegates -



/**
 * @discussion method to rearrange the cart table rows
 * @date
 * @method goToBottom
 * @author
 */

-(void)goToBottom
{
    itemsTbl.hidden = NO;
    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:([itemsTbl numberOfRowsInSection:0] - 1) inSection:0];
    [itemsTbl scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}

#pragma -mark change quantity methods
/**
 * @discussion populate the change quantity view when we click on the quantity
 * @method qtyChangeView
 
 */

- (void)populateQtyView:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    // [textField resignFirstResponder];
    
    PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
    
    rejectQtyChangeDisplayView = [[UIView alloc]init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
            
            rejectQtyChangeDisplayView.frame = CGRectMake(250, 100, 400, 350);
            
        }
        else {
            rejectQtyChangeDisplayView.frame = CGRectMake(200, 300, 400, 350);
            
        }
        
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
    //    [self.view addSubview:rejectQtyChangeDisplayView];
    
    UIImageView *img  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.PNG"]];
    
    // a label on top of the view ..
    UILabel *topbar = [[UILabel alloc] init];
    topbar.backgroundColor = [UIColor grayColor];
    topbar.text = @"    Enter Quantity";
    topbar.backgroundColor = [UIColor clearColor];
    [topbar setTextAlignment:NSTextAlignmentCenter];
    topbar.font = [UIFont boldSystemFontOfSize:17];
    topbar.textColor = [UIColor whiteColor];
    topbar.textAlignment = NSTextAlignmentLeft;
    
    
    UILabel *unitPrice = [[UILabel alloc] init];
    unitPrice.text = @"Unit Price       :";
    unitPrice.font = [UIFont boldSystemFontOfSize:14];
    unitPrice.backgroundColor = [UIColor clearColor];
    unitPrice.textColor = [UIColor whiteColor];
    
    
    UILabel *unitPriceData = [[UILabel alloc] init];
    
    unitPriceData.font = [UIFont boldSystemFontOfSize:14];
    unitPriceData.backgroundColor = [UIColor clearColor];
    unitPriceData.textColor = [UIColor whiteColor];
    
    
    rejecQtyField = [[CustomTextField alloc] init];
    rejecQtyField.borderStyle = UITextBorderStyleRoundedRect;
    rejecQtyField.textColor = [UIColor whiteColor];
    rejecQtyField.placeholder = @"Enter Qty";
    rejecQtyField.keyboardType = UIKeyboardTypeNumberPad;
    //rejecQtyField.inputAccessoryView = numberToolbar1;
    rejecQtyField.text = sender.titleLabel.text;
    rejecQtyField.font = [UIFont systemFontOfSize:17.0];
    rejecQtyField.backgroundColor = [UIColor clearColor];
    rejecQtyField.autocorrectionType = UITextAutocorrectionTypeNo;
    //qtyFeild.keyboardType = UIKeyboardTypeDefault;
    rejecQtyField.clearButtonMode = UITextFieldViewModeWhileEditing;
    rejecQtyField.returnKeyType = UIReturnKeyDone;
    rejecQtyField.delegate = self;
    [rejecQtyField awakeFromNib]; 
    
    remarksTxt = [[CustomTextField alloc] init];
    remarksTxt.borderStyle = UITextBorderStyleRoundedRect;
    remarksTxt.textColor = [UIColor blackColor];
    remarksTxt.placeholder = @"Remarks";
    remarksTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    remarksTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    remarksTxt.returnKeyType = UIReturnKeyDone;
    remarksTxt.delegate = self;
    [remarksTxt awakeFromNib];
    
    /** ok Button for qtyChangeDisplyView....*/
    okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //[okButton setImage:[UIImage imageNamed:@"OK.png"] forState:UIControlStateNormal];
    [okButton addTarget:self
                 action:@selector(okButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [okButton setTitle:@"OK" forState:UIControlStateNormal];
    okButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
    okButton.backgroundColor = [UIColor grayColor];
    okButton.tag = 20;
    
    /** CancelButton for qtyChangeDisplyView....*/
    qtyCancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //[qtyCancelButton setImage:[UIImage imageNamed:@"Cancel.png"] forState:UIControlStateNormal];
    [qtyCancelButton addTarget:self
                        action:@selector(QtyCancelButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [qtyCancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
    qtyCancelButton.backgroundColor = [UIColor grayColor];
    qtyCancelButton.tag = 21;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        
        img.frame = CGRectMake(0, 0, 400, 50);
        topbar.frame = CGRectMake(0, 5, 400, 40);
        topbar.font = [UIFont boldSystemFontOfSize:22];
        
        
        unitPrice.frame = CGRectMake(10,60,200,40);
        unitPrice.font = [UIFont boldSystemFontOfSize:20];
        
        
        unitPriceData.frame = CGRectMake(200,60,2500,40);
        unitPriceData.font = [UIFont boldSystemFontOfSize:20];
        
        
        rejecQtyField.frame = CGRectMake(40, 140, 290, 50);
        rejecQtyField.font = [UIFont systemFontOfSize:25.0];
        rejecQtyField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Enter Quantity" attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        
        remarksTxt.frame = CGRectMake(40, 200, 290, 50);
        remarksTxt.font = [UIFont systemFontOfSize:25.0];
        remarksTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Special Instructions" attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        
        
        okButton.frame = CGRectMake(20, 300, 165, 45);
        okButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        okButton.layer.cornerRadius = 20.0f;
        
        qtyCancelButton.frame = CGRectMake(190, 300, 165, 45);
        qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        qtyCancelButton.layer.cornerRadius = 20.0f;
        
        
    }
    else {
        
        img.frame = CGRectMake(0, 0, 200, 32);
        topbar.frame = CGRectMake(10, 0, 175, 30);
        topbar.font = [UIFont boldSystemFontOfSize:17];
        
        unitPrice.frame = CGRectMake(10,50,100,30);
        unitPrice.font = [UIFont boldSystemFontOfSize:14];
        
        unitPriceData.frame = CGRectMake(115,50,60,30);
        unitPriceData.font = [UIFont boldSystemFontOfSize:14];
        
        rejecQtyField.frame = CGRectMake(36, 107, 100, 30);
        rejecQtyField.font = [UIFont systemFontOfSize:17.0];
        
        okButton.frame = CGRectMake(10, 150, 75, 30);
        okButton.layer.cornerRadius = 14.0f;
        okButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
        qtyCancelButton.frame = CGRectMake(110, 150, 75, 30);
        qtyCancelButton.layer.cornerRadius = 14.0f;
        qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
    }
    
    [rejectQtyChangeDisplayView addSubview:img];
    [rejectQtyChangeDisplayView addSubview:topbar];
    [rejectQtyChangeDisplayView addSubview:unitPrice];
    [rejectQtyChangeDisplayView addSubview:unitPriceData];
    [rejectQtyChangeDisplayView addSubview:rejecQtyField];
    [rejectQtyChangeDisplayView addSubview:remarksTxt];
    [rejectQtyChangeDisplayView addSubview:okButton];
    [rejectQtyChangeDisplayView addSubview:qtyCancelButton];
    
    //    [self.view addSubview:rejectQtyChangeDisplayView];
    //    [self.view addSubview:scrollView];
    
    customerInfoPopUp.view = rejectQtyChangeDisplayView;
    
    NSIndexPath *selectedRow = [NSIndexPath indexPathForRow:[sender tag] inSection:0];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        customerInfoPopUp.preferredContentSize =  CGSizeMake(rejectQtyChangeDisplayView.frame.size.width, rejectQtyChangeDisplayView.frame.size.height);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        
        //                [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        [popover presentPopoverFromRect:qty.frame inView:[itemsTbl cellForRowAtIndexPath:selectedRow] permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
        
        
        customerInfoPopOver= popover;
        
    }
    
    else {
        
        customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        // popover.contentViewController.view.alpha = 0.0;
        [[[popover contentViewController]  view] setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:1.0f]];
        [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        customerInfoPopOver = popover;
        
    }
    
    //    UIGraphicsBeginImageContext(rejectQtyChangeDisplayView.frame.size);
    //    [[UIImage imageNamed:@"CustomerView.png"] drawInRect:rejectQtyChangeDisplayView.bounds];
    //    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    //    rejectQtyChangeDisplayView.backgroundColor = [UIColor colorWithPatternImage:image];
    
    
    tagId = (int)sender.tag;
    
    //    @try {
    //
    //        NSArray *instArr = [[dictionary3 valueForKey:[arr objectAtIndex:button.tag]] componentsSeparatedByString:@","] ;
    //        if (![[instArr objectAtIndex:2] isEqualToString:@""]) {
    //
    //            remarks.text = [NSString stringWithFormat:@"%@",[instArr objectAtIndex:2]];
    //        }
    //        else {
    //            remarks.text = @"-";
    //        }
    //        unitPriceData.text =  [[[dictionary3 valueForKey:[arr objectAtIndex:button.tag]] componentsSeparatedByString:@","] objectAtIndex:0] ;
    //    }
    //    @catch (NSException *exception) {
    //
    //        NSLog(@"%@",exception);
    //        unitPriceData.text = @"";
    //        remarks.text = @"-";
    //    }
}


/**
 * @description
 * @date         29/03/2019
 * @method       populateTasteRequirementView
 * @author       roja
 * @param        UIButton
 * @param
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (void)populateTasteRequirementView:(UIButton *)sender {

    AudioServicesPlaySystemSound (soundFileObject);

    PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];

    tasteRequirementView = [[UIView alloc]init];
    tasteRequirementView.frame = CGRectMake(250, 100, 370, 270);

    tasteRequirementView.layer.borderWidth = 1.0;
    tasteRequirementView.layer.cornerRadius = 10.0;
    tasteRequirementView.layer.masksToBounds = YES;
    tasteRequirementView.hidden = NO;
    tasteRequirementView.layer.borderColor = [UIColor whiteColor].CGColor;
    tasteRequirementView.backgroundColor = [UIColor blackColor];
    
    UIImageView *img  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.PNG"]];
    
    // a label on top of the view ..
    UILabel *topbar = [[UILabel alloc] init];
    topbar.backgroundColor = [UIColor grayColor];
    topbar.text = @"  Enter Taste Requirements";
    topbar.backgroundColor = [UIColor clearColor];
    [topbar setTextAlignment:NSTextAlignmentCenter];
    topbar.font = [UIFont boldSystemFontOfSize:17];
    topbar.textColor = [UIColor whiteColor];
    topbar.textAlignment = NSTextAlignmentLeft;
    
    
    UILabel * tasteRequirmentLbl = [[UILabel alloc] init];
    tasteRequirmentLbl.text = @"Taste Requirement:";
    tasteRequirmentLbl.font = [UIFont boldSystemFontOfSize:20];
    tasteRequirmentLbl.backgroundColor = [UIColor clearColor];
    tasteRequirmentLbl.textColor = [UIColor whiteColor];
    
    tasteRequirmentTF = [[CustomTextField alloc] init];
    tasteRequirmentTF.borderStyle = UITextBorderStyleRoundedRect;
    tasteRequirmentTF.textColor = [UIColor whiteColor];
    tasteRequirmentTF.placeholder = @"Enter taste requirements";
    tasteRequirmentTF.text = sender.titleLabel.text;
    tasteRequirmentTF.font = [UIFont systemFontOfSize:16];
    tasteRequirmentTF.backgroundColor = [UIColor clearColor];
    tasteRequirmentTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    tasteRequirmentTF.returnKeyType = UIReturnKeyDone;
    tasteRequirmentTF.delegate = self;
    tasteRequirmentTF.autocorrectionType = UITextAutocorrectionTypeNo;
    tasteRequirmentTF.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"Enter taste requirements" attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    [tasteRequirmentTF awakeFromNib];

    UIButton * tasteRequirmentDropDownBtn = [[UIButton alloc] init];
    tasteRequirmentDropDownBtn.backgroundColor = [UIColor blackColor];
    tasteRequirmentDropDownBtn.titleLabel.textColor = [UIColor whiteColor];
    tasteRequirmentDropDownBtn.userInteractionEnabled = YES;
    [tasteRequirmentDropDownBtn setImage:[UIImage imageNamed:@"brown_down_arrow.png"] forState:UIControlStateNormal];
    
    [tasteRequirmentDropDownBtn addTarget:self action:@selector(populateTasteRequirementPopUpView:) forControlEvents:UIControlEventTouchDown];
    
    tasteRequirmentDropDownBtn.tag = sender.tag;
    
    
    /** ok Button for taste Requirements ChangeDisplyView....*/
    UIButton * okButton;
    okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [okButton addTarget:self action:@selector(okButtonOfTasteRequirementsAction:) forControlEvents:UIControlEventTouchDown];
    [okButton setTitle:@"OK" forState:UIControlStateNormal];
    okButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
    okButton.backgroundColor = [UIColor grayColor];
    //    okButton.tag = 20;
    
    /** CancelButton for taste Requirements Change DisplyView....*/
    tasteRequirementsCancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //[tasteRequirementsCancelButton setImage:[UIImage imageNamed:@"Cancel.png"] forState:UIControlStateNormal];
    [tasteRequirementsCancelButton addTarget:self
                                      action:@selector(tasteRequirementCancelBtnAction:) forControlEvents:UIControlEventTouchDown];
    [tasteRequirementsCancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    tasteRequirementsCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    tasteRequirementsCancelButton.backgroundColor = [UIColor grayColor];
    //    tasteRequirementsCancelButton.tag = 21;
    
    topbar.font = [UIFont boldSystemFontOfSize:22];
    okButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
    okButton.layer.cornerRadius = 20.0f;
    tasteRequirementsCancelButton.layer.cornerRadius = 20.0f;
    
    img.frame = CGRectMake(0, 0, tasteRequirementView.frame.size.width, 50);
    topbar.frame = CGRectMake(0, 5, tasteRequirementView.frame.size.width, 40);
    tasteRequirmentLbl.frame = CGRectMake(10,60,200,40);
    tasteRequirmentTF.frame = CGRectMake(40, 110, 290, 50);
    tasteRequirmentDropDownBtn.frame = CGRectMake(295, 125, 25, 25);
    okButton.frame = CGRectMake(20, 200, 165, 45);
    tasteRequirementsCancelButton.frame = CGRectMake(190, 200, 165, 45);
    
    
    [tasteRequirementView addSubview:img];
    [tasteRequirementView addSubview:topbar];
    [tasteRequirementView addSubview:tasteRequirmentLbl];
    [tasteRequirementView addSubview:tasteRequirmentTF];
    [tasteRequirementView addSubview:tasteRequirmentDropDownBtn];
    [tasteRequirementView addSubview:okButton];
    [tasteRequirementView addSubview:tasteRequirementsCancelButton];
    
    customerInfoPopUp.view = tasteRequirementView;
    
    NSIndexPath *selectedRow = [NSIndexPath indexPathForRow:[sender tag] inSection:0];
    
    customerInfoPopUp.preferredContentSize =  CGSizeMake(tasteRequirementView.frame.size.width, tasteRequirementView.frame.size.height);
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
    //                [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    [popover presentPopoverFromRect: tasteRequirementBtn.frame inView:[itemsTbl cellForRowAtIndexPath:selectedRow] permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
    customerInfoPopOver= popover;
    tagId = (int)sender.tag;
    
    tasteRequirmentTF.tag = (int)sender.tag;
}

/**
 * @description  Here we are displaying the pop up view for taste requirements
 * @date         29/03/2019
 * @method       populateTasteRequirementPopUpView
 * @author       roja
 * @param        UIButton
 * @param
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
-(void)populateTasteRequirementPopUpView:(UIButton *)sender{
    
    @try {
        
        AudioServicesPlaySystemSound (soundFileObject);
        
        NSDictionary * cartDetailsDic = [cartItemDetails objectAtIndex:sender.tag];
//        NSString * skuIDString = [self checkGivenValueIsNullOrNil:[cartDetailsDic valueForKey:@"skuId"] defaultReturn:@""];
        NSString * pluCodeString = [self checkGivenValueIsNullOrNil:[cartDetailsDic valueForKey:@"pluCode"] defaultReturn:@""];

        [self getCustomerEatingHabits:pluCodeString];
        
        if ([tasteRequirmntArray count] && tasteRequirmntArray != nil) {
            
            PopOverViewController * customerInfoPopUp = [[PopOverViewController alloc] init];
            
            float tableHt = 0;
            if([tasteRequirmntArray count] && [tasteRequirmntArray count] <= 4) {
                tableHt = [tasteRequirmntArray count] * 30;
            }
            else if([tasteRequirmntArray count] && [tasteRequirmntArray count] > 4){
                tableHt = 4 * 30;
            }
            
            UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, tasteRequirmentTF.frame.size.width, tableHt)];
            customView.opaque = NO;
            customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
            customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            customView.layer.borderWidth = 2.0f;
            [customView setHidden:NO];
            
            tasteRequirementsTbl.frame = CGRectMake(0, 0, customView.frame.size.width, customView.frame.size.height);
            
            [customView addSubview:tasteRequirementsTbl];
            
            customerInfoPopUp.view = customView;
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            [popover presentPopoverFromRect:tasteRequirmentTF.frame inView:tasteRequirementView  permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            customerInfoPopOver= popover;
            
            UIGraphicsBeginImageContext(customView.frame.size);
            [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            customView.backgroundColor = [UIColor colorWithPatternImage:image];
        }
        
        else{
            float y_axis = self.view.frame.size.height / 2;
            NSString * mesg = @"No Record Found";
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2 verticalAxis:y_axis  msgType:@"" conentWidth:300 contentHeight:40  isSoundRequired:NO timming:2.0 noOfLines:1];
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [tasteRequirementsTbl reloadData];
    }
}



/**
 * @description  Here we are making service call to get customer eating habits
 * @date         29/03/2019
 * @method       getCustomerEatingHabits
 * @author       roja
 * @param        NSString
 * @param
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
-(void)getCustomerEatingHabits:(NSString *)pluCodeStr{
    
    @try {
        
        [HUD setHidden:NO];
        
        NSArray * eatingHabitsKeys = [NSArray arrayWithObjects:pluCodeStr,@"mobileNumber",REQUEST_HEADER, nil];
        NSArray *eatingHabitsObjects = [NSArray arrayWithObjects:@"pluCode",mobileNoTxt.text,[RequestHeader getRequestHeader], nil]; // skuId
        NSDictionary *requestDic = [NSDictionary dictionaryWithObjects:eatingHabitsObjects forKeys:eatingHabitsKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:requestDic options:0 error:&err_];
        NSString * RequestString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        WebServiceController * controller = [WebServiceController new];
        [controller setOutletOrderServiceDelegate:self];
        [controller getCustomerEatingHabits:RequestString];
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
    }
}



/**
 * @description  Here we are handling success response of eating habits...
 * @date         29/03/2019
 * @method       getCustomerEatinghabitsSuccessRespose
 * @author       roja
 * @param        NSDictionary
 * @param
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
-(void)getCustomerEatingHabitsSuccessRespose:(NSDictionary *)successDictionary{
    
    @try {
        
        tasteRequirmntArray = [[NSMutableArray alloc] init];

        for (NSString * eatingHabitsStr in [successDictionary valueForKey:@"eatingHabits"]) {
            
            [tasteRequirmntArray addObject: eatingHabitsStr];
        }
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
        
    }
    
}



/**
 * @description  Here we are handling error response of eating habits...
 * @date         29/03/2019
 * @method       getCustomerEatinghabitsErrorResponse
 * @author       roja
 * @param        NSString
 * @param
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (void)getCustomerEatingHabitsErrorResponse:(NSString *)errorResponse{
    
    @try {
        
        if (isEatingHabitsDropDown) {
            
            float y_axis = self.view.frame.size.height / 2;
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"Eating Habits are not available for this customer",nil)];
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2 verticalAxis:y_axis  msgType:@"" conentWidth:300 contentHeight:40  isSoundRequired:NO timming:2.0 noOfLines:2];
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}

/**
 * @discussion```
 * @method okButtonPressed
 *  @author Sonali
 * @param sourceId Source timeline entity ID
 * @param destId Destination timeline entity ID
 * @return A newly created message instance
 */

// okButtonPressed handler for quantity changed..
- (IBAction)okButtonPressed:(id)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    [rejecQtyField resignFirstResponder];
    
    BOOL shouldCallOffers = YES;
    
    NSString *value = [rejecQtyField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // PhoNumber validation...
    NSString *decimalRegex = @"[0-9]+([.]([0-9]+)?)?"; // @"[0-9]+[.][0-9]+";
    NSPredicate *decimalTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalRegex];
    BOOL isNumber = [decimalTest evaluateWithObject:[rejecQtyField text]];
    int qty1 = [value intValue];
    
    NSMutableDictionary * itemTempDic = [cartItemDetails objectAtIndex:tagId];
    
    float availiableQty = [[self checkGivenValueIsNullOrNil:[itemTempDic valueForKey:MAX_QUANTITY] defaultReturn:@"0"] floatValue];
    
    if (qty1 > availiableQty){
       
        float y_axis = self.view.frame.size.height - 120;
        NSString * msg = @"Quantity Should be Less than or Equal to Available Quantity";
        [self displayAlertMessage:msg horizontialAxis:(self.view.frame.size.width - 350)/2  verticalAxis:y_axis  msgType:@""  conentWidth:350 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        rejecQtyField.text = nil;
    }
    else if([value length] == 0 || !isNumber){
        
        float y_axis = self.view.frame.size.height - 120;
        NSString * msg = @"Enter Quantity in Number.";
        [self displayAlertMessage:msg horizontialAxis:(self.view.frame.size.width - 300)/2  verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        rejecQtyField.text = NO;
    }
    else if([rejecQtyField.text intValue]==0){
        
        float y_axis = self.view.frame.size.height - 120;
        NSString * msg = @"Enter Valid Quantity.";
        [self displayAlertMessage:msg horizontialAxis:(self.view.frame.size.width - 300)/2  verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        
        rejecQtyField.text = nil;
    }
    else{
        
        @try {
            
            [itemTempDic setValue:rejecQtyField.text  forKey:QUANTITY];
            [itemTempDic setValue:rejecQtyField.text  forKey:ORDERED_QUANTITY];
            [itemTempDic setValue:remarksTxt.text  forKey:REMARKS];
            
            [cartItemDetails replaceObjectAtIndex:tagId withObject:itemTempDic];
        }
        @catch (NSException *exception) {
            
            NSLog(@"exception %@",exception);
        }
        @finally{
            [self callDealsAndOffersForItem];
        }
    }
}


// cancelButtonPressed handler quantity changed view cancel..
- (IBAction)QtyCancelButtonPressed:(id)sender {
    
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    [rejecQtyField resignFirstResponder];
    rejectQtyChangeDisplayView.hidden = YES;
    [customerInfoPopOver dismissPopoverAnimated:YES];
    [self callDealsAndOffersForItem];
}

-(void)okButtonOfTasteRequirementsAction:(UIButton *)sender {

    AudioServicesPlaySystemSound (soundFileObject);
    [tasteRequirmentTF resignFirstResponder];
    NSMutableDictionary * itemTempDic = [cartItemDetails objectAtIndex:tagId];
    
    [itemTempDic setValue:tasteRequirmentTF.text forKey:@"tastePattern"];
    
    [cartItemDetails replaceObjectAtIndex:tagId withObject:itemTempDic];
    [customerInfoPopOver dismissPopoverAnimated:YES];

    [itemsTbl reloadData];
}


-(void)tasteRequirementCancelBtnAction:(UIButton *)sender {
    
    AudioServicesPlaySystemSound (soundFileObject);
    [tasteRequirmentTF resignFirstResponder];
    //tasteRequirementView.hidden = YES;
    [customerInfoPopOver dismissPopoverAnimated:YES];
}

/**
 * @description     tableview layout
 * @date            3/12/15
 * @method          populateTableView
 * @author           Sonali
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */
-(void)populateTableView:(NSString*)level {
    
    [HUD setHidden:NO];
    [HUD setLabelText:@"please wait.."];

    @try {
        NSDictionary *reqDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:presentLocation,@"-1",[RequestHeader getRequestHeader],level, nil] forKeys:[NSArray arrayWithObjects:@"location",START_INDEX,REQUEST_HEADER,@"level", nil]];
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
        NSString * getBookingJsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *controller = [[WebServiceController alloc] init];
        [controller setStoreServiceDelegate:self];
        [controller getLayoutDetails:getBookingJsonStr];
        
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"Exception %@",exception);
    }
    
}

#pragma -mark layout delegates
-(void)getAllLayoutTablesSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        tableDetails = [NSMutableArray new];
        tableStatusArr = [NSMutableArray new];
        NSArray *array = [successDictionary valueForKey:@"tablesList"];
        
        
        for (NSDictionary *dic in array) {
            
            NSDictionary * tempDic  = [[NSMutableDictionary alloc] init];

            [tempDic setValue:[dic valueForKey:@"level"] forKey:@"level"];
            [tempDic setValue:[dic valueForKey:@"tableNumber"] forKey:@"tableNumber"];
            [tempDic setValue:[dic valueForKey:@"noOfChairs"] forKey:@"noOfChairs"];
            [tempDic setValue:[dic valueForKey:@"order"] forKey:@"order"];
            [tempDic setValue:[dic valueForKey:@"orderItems"] forKey:@"orderItems"];
            [tempDic setValue:[dic valueForKey:@"sectionName"] forKey:@"sectionName"];

            [tableDetails addObject:tempDic];
            [tableStatusArr addObject:[dic valueForKey:STATUS]];
        }

        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 9, 10);
        layout.itemSize = CGSizeMake(60, 60);
        layout.minimumInteritemSpacing = 10.0;
        layout.minimumLineSpacing = 20.0;
        
        collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,65,650,60) collectionViewLayout:layout];
        [collectionView setDataSource:self];
        [collectionView setDelegate:self];
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Collection_cell"];
        collectionView.backgroundColor = [UIColor blackColor];
        
        [self.view addSubview:collectionView];
        [collectionView setHidden:NO];
        collectionView.userInteractionEnabled = YES;
        
        [collectionView reloadData];
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
    }
    @finally {
        
        [HUD setHidden:YES];
        
        BOOL isTableAllocated = false;
        int i;

        if ([tableStatusArr count] && tableStatusArr != nil) {

            for (i=0; i<tableStatusArr.count; i++) {

                NSString * tableStatusStr = [tableStatusArr objectAtIndex:i];

                if ([tableStatusStr caseInsensitiveCompare:@"vacant"] != NSOrderedSame) {
                    isTableAllocated = true;
                    break;
                }
            }

            if (isTableAllocated) {

                NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [self collectionView:collectionView didSelectItemAtIndexPath:indexPath];
            }
        }
    }
}



-(void)getAllLayoutTablesErrorResponse:(NSString *)failureString {
    
    [HUD setHidden:YES];
  
    float y_axis = self.view.frame.size.height/2;// 120
    NSString * msg = failureString;
    [self displayAlertMessage:msg horizontialAxis:(self.view.frame.size.width - 350)/2  verticalAxis:y_axis  msgType:@""  conentWidth:350 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
    
    [collectionView setHidden:YES];
}


#pragma -mark collection view delegate methods


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if(collectionView == menuCategoriesView){
        
        return [[menuCategoriesDic valueForKey:CATEGORY_NAMES] count];
    }
    else if(collectionView == menuCategoriesItemsCollectionView){
        
        if(menuCategoriesView.tag == 0){
            
            int  totalCount = 0;
            
            @try {
                for (NSString * categoryStr in [menuCategoriesDic valueForKey:CATEGORY_NAMES]){
                    if(![categoryStr.uppercaseString isEqualToString:ALL]){
                        totalCount = totalCount + (int)[[menuCategoriesDic valueForKey:categoryStr] count];
                    }
                }
            } @catch (NSException *exception) {
                
            }
            return totalCount;
        }
        else{
            return [[menuCategoriesDic valueForKey:[menuCategoriesDic valueForKey:CATEGORY_NAMES][menuCategoriesView.tag]] count];
        }
    }
    else
        return [tableDetails count];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView1 cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(collectionView1 == menuCategoriesView){
        UICollectionViewCell * menuCategoriesCell;
        
        @try {
            static NSString *identifier = @"menu_categories_cell";
            
            menuCategoriesCell = [menuCategoriesView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
            
            if ((menuCategoriesCell.contentView).subviews){
                for (UIView *subview in (menuCategoriesCell.contentView).subviews) {
                    [subview removeFromSuperview];
                }
            }
            
            if (!menuCategoriesCell) {
                
                menuCategoriesCell = [[UICollectionViewCell alloc] init];
            }
            
            UILabel * categoryNameLbl = [[UILabel alloc] init];
            categoryNameLbl.frame = CGRectMake(0, 0, menuCategoriesCell.frame.size.width, menuCategoriesCell.frame.size.height);
            categoryNameLbl.textColor = [UIColor blackColor];
            categoryNameLbl.numberOfLines = 1;
            categoryNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0];
            categoryNameLbl.textAlignment = NSTextAlignmentCenter;
            categoryNameLbl.lineBreakMode = NSLineBreakByTruncatingTail;
            
            @try{
                NSString * str = [self checkGivenValueIsNullOrNil:[menuCategoriesDic valueForKey:CATEGORY_NAMES][indexPath.row] defaultReturn:@""];
                categoryNameLbl.text = str.uppercaseString;
            }
            @catch(NSException * e){
                
            }
            
            if(menuCategoriesView.tag == indexPath.row){
                
                categoryNameLbl.backgroundColor = [UIColor whiteColor];
            }
            else{
                
                categoryNameLbl.backgroundColor = [UIColor clearColor];
                menuCategoriesCell.contentView.layer.borderWidth = 1;
                menuCategoriesCell.contentView.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:0.4].CGColor;
            }
            
            [menuCategoriesCell.contentView addSubview:categoryNameLbl];
        } @catch (NSException *exception) {
            
        } @finally {
            
            return menuCategoriesCell;
        }
    }
    else if (collectionView1 == menuCategoriesItemsCollectionView){
        UICollectionViewCell * cell;
        
        @try {
            static NSString *identifier = @"menu_categories_item_cell";
            
            cell = [menuCategoriesItemsCollectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
            
            UIButton * recipeImageView = [[UIButton alloc] init];
            
            if ((cell.contentView).subviews){
                for (UIView *subview in (cell.contentView).subviews) {
                    [subview removeFromSuperview];
                }
            }
            
            if (!cell) {
                
                cell = [[UICollectionViewCell alloc] init];
            }
            
            [recipeImageView setBackgroundImage:[UIImage imageNamed:@"Button1.png"] forState:UIControlStateNormal];
            recipeImageView.backgroundColor = [UIColor clearColor];
            recipeImageView.titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
            [recipeImageView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            recipeImageView.layer.cornerRadius = recipeImageView.frame.size.height/2.0;
            recipeImageView.tag = indexPath.row;
            recipeImageView.userInteractionEnabled = NO;

            //        [recipeImageView addTarget:self action:@selector(addItemToCart:) forControlEvents:UIControlEventTouchUpInside];
            //
            UILabel *name = [[UILabel alloc] init];
            name.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6 ];
            name.numberOfLines = 2;
            name.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0];
            name.textAlignment = NSTextAlignmentCenter;
            name.backgroundColor = [UIColor colorWithRed:37.0/255.0 green:37.0/255.0 blue:37.0/255.0 alpha:1.0];
            name.textColor = [UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:120.0/255.0 alpha:1.0];
            
            cell.layer.borderColor = [UIColor whiteColor].CGColor;
            cell.layer.borderWidth = 2;
            cell.layer.cornerRadius= 0.5;
            
            [cell.contentView addSubview:recipeImageView];
            [cell.contentView addSubview:name];
            
         
            name.frame = CGRectMake( 0, cell.frame.size.height - 50, cell.frame.size.width, 50);
            recipeImageView.frame = CGRectMake( (cell.frame.size.width - 50)/2, (cell.frame.size.height - 90)/2, 50, 50);
            
            
            @try {
                [recipeImageView setTitle:[NSString stringWithFormat:@"%ld", indexPath.row+1] forState:UIControlStateNormal];
                cell.tag = indexPath.row;
                
                NSString * itemNameStr = @"";
                
                if(menuCategoriesView.tag == 0){
                    
                    int findIndexPath = 0;
                    
                    for(int i = 1; i < menuCategoriesDic.allKeys.count; i++){
                        
                        findIndexPath = findIndexPath + (int)[[menuCategoriesDic valueForKey:[menuCategoriesDic valueForKey:CATEGORY_NAMES][i]] count];
                        if(findIndexPath > indexPath.row){
                            menuCategoriesItemsCollectionView.tag = i;
                            break;
                        }
                    }
                    
                    int objectIndex = (int)indexPath.row;
                    
                    for (int j = (int)menuCategoriesItemsCollectionView.tag - 1;j > 0; j--){
                        objectIndex = objectIndex - ((int) [[menuCategoriesDic valueForKey:[menuCategoriesDic valueForKey:CATEGORY_NAMES][j]] count]);
                    }
                    
                    itemNameStr = [[menuCategoriesDic valueForKey:[menuCategoriesDic valueForKey:CATEGORY_NAMES][menuCategoriesItemsCollectionView.tag]][objectIndex] valueForKey:ITEM__DESC];
                    
                    
                    
                    //                    for(int i = 1; i < [[menuCategoriesDic allKeys] count]; i++){
                    //
                    //                        if(i == 1 && [[menuCategoriesDic valueForKey:[[menuCategoriesDic valueForKey:CATEGORY_NAMES] objectAtIndex:i]] count] > indexPath.row){
                    //                            itemNameStr = [[[menuCategoriesDic valueForKey:[[menuCategoriesDic valueForKey:CATEGORY_NAMES] objectAtIndex:i]] objectAtIndex:indexPath.row] valueForKey:ITEM__DESC];
                    //                            break;
                    //                        }
                    //                        else if(i > 1){
                    ////                        if([[menuCategoriesDic valueForKey:[[menuCategoriesDic valueForKey:CATEGORY_NAMES] objectAtIndex:i]] count] > indexPath.row){
                    //                            int objectIndex = (int)indexPath.row;
                    //
                    //                            int j = 0;
                    //                            for (j = i-1;j > 0; j--)
                    //                                objectIndex = objectIndex - ((int) [[menuCategoriesDic valueForKey:[[menuCategoriesDic valueForKey:CATEGORY_NAMES] objectAtIndex:j]] count]);
                    //
                    //                            itemNameStr = [[[menuCategoriesDic valueForKey:[[menuCategoriesDic valueForKey:CATEGORY_NAMES] objectAtIndex:i]] objectAtIndex:objectIndex] valueForKey:ITEM__DESC];
                    //                            break;
                    ////                        }
                    //                        }
                    //                    }
                }
                else{
                    
                    itemNameStr = [[menuCategoriesDic valueForKey:[menuCategoriesDic valueForKey:CATEGORY_NAMES][menuCategoriesView.tag]][indexPath.row] valueForKey:ITEM__DESC];
                }
                name.text = itemNameStr;
                
                //                if([subCategoriesArr count] > indexPath.row){
                //                    NSDictionary *dic = [subCategoriesArr objectAtIndex:indexPath.row];
                //                    name.text =[dic valueForKey:kskuDescription];
                //                }
                //                else{
                //                    name.text = @"--";
                //                }
            }
            @catch (NSException *exception) {
                
            }
            
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                
                if (version>=8.0) {
                    recipeImageView.frame = CGRectMake(5, 0, 30, 30);
                    name.frame = CGRectMake(5, 30, 40, 20);
                    recipeImageView.layer.cornerRadius = recipeImageView.frame.size.height/2.0;
                    name.font = [UIFont fontWithName:TEXT_FONT_NAME size:8];
                    recipeImageView.titleLabel.font = [UIFont boldSystemFontOfSize:12];
                }
                else {
                    
                    recipeImageView.frame = CGRectMake(5, 0, 5, 5);
                    name.frame = CGRectMake(10, 10, 40, 30);
                }
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
            return cell;
        }
    }
    else {
        
        @try {
            static NSString *identifier = @"Collection_cell";
            
            UICollectionViewCell *cell = [collectionView1 dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
            
            //    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
            
            if ([cell.contentView subviews]){
                for (UIView *subview in [cell.contentView subviews]) {
                    [subview removeFromSuperview];
                }
            }
            
            if (!cell) {
                cell = [[UICollectionViewCell alloc] init];
            }
            
            tableLayout = [[UIView alloc] init];
            
            UIColor *color = [WebServiceUtility UIColorFromNSString:[[WebServiceUtility getPropertyFromProperties:@"TableStatusColorCodes"] valueForKey:[tableStatusArr objectAtIndex:indexPath.row]]];
            
            tableLayout.backgroundColor = color;
            
            
            // Create the colors
            UIColor *darkOp =
            [UIColor colorWithRed:82.0/255.0 green:237.0/255.0 blue:199.0/255.0 alpha:1.0];
            UIColor *lightOp =
            [UIColor colorWithRed:90.0/255.0 green:200.0/255.0 blue:251.0/255.0 alpha:1.0];
            
            // Create the gradient
            CAGradientLayer *gradient = [CAGradientLayer layer];
            
            // Set colors
            gradient.colors = [NSArray arrayWithObjects:
                               (id)lightOp.CGColor,
                               (id)darkOp.CGColor,
                               nil];
            
            // Set bounds
            
            // Add the gradient to the view
            //    [tableLayout.layer insertSublayer:gradient atIndex:0];
            
            UILabel *tableNoLbl = [[UILabel alloc] init];
            tableNoLbl.textColor = [UIColor blackColor];
            tableNoLbl.textAlignment = NSTextAlignmentCenter;
            tableNoLbl.font = [UIFont boldSystemFontOfSize:17.0];
            
            UILabel *noOfAvailChairs = [[UILabel alloc] init];
            noOfAvailChairs.textColor = [UIColor blackColor];
            noOfAvailChairs.textAlignment = NSTextAlignmentCenter;
            
            
            @try {
                NSDictionary * temp = [tableDetails objectAtIndex:indexPath.row];
                
                if([[temp allKeys] containsObject:@"tableNumber"] && ![[temp valueForKey:@"tableNumber"] isKindOfClass:[NSNull class]]){
                    
                    tableNoLbl.text = [NSString stringWithFormat:@"%@%@",@"T",[temp valueForKey:@"tableNumber"]] ;
                    //                tableNoLbl.text = [NSString stringWithFormat:@"%@%@",@"T",[[temp valueForKey:kTableNumber] substringFromIndex:5]];
                }
                
                if([[temp allKeys] containsObject:kNoOfChairs] && ![[temp valueForKey:kNoOfChairs] isKindOfClass:[NSNull class]])
                    noOfAvailChairs.text = [temp valueForKey:kNoOfChairs];
                
            } @catch (NSException *exception) {
                
            }
            
            
            // commented by roja on 11/03/2019...
////            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
////
////                if (version>=8.0) {
////                    tableLayout.frame = CGRectMake(5, 0, 30, 30);
////
////                }
////                else {
////                    tableLayout.frame = CGRectMake(5, 0, 30, 30);
////                }
////            }
//            else {
                
                tableLayout.frame = CGRectMake(5, 0, 45,45);
                tableNoLbl.frame = CGRectMake(tableLayout.frame.size.width/2-20, tableLayout.frame.size.height/2-10, 40,25);
                //noOfAvailChairs.frame = CGRectMake(tableLayout.frame.size.width-60,20,60, 30);
//            }
            gradient.frame = tableLayout.bounds;
            tableLayout.layer.cornerRadius = 8.0f;
            
            [tableLayout addSubview:tableNoLbl];
            //        [tableLayout addSubview:noOfAvailChairs];
            [cell.contentView addSubview:tableLayout];
            
            return cell;
            
        }
        @catch (NSException *exception) {
            
            NSLog(@"%@",exception);
        }
        
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize s;
    
    @try {
        
        if(collectionView == menuCategoriesView){
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
                    
                    CGRect sizeDynamic;
                    
                    @try{
                        
                        NSString * description = [menuCategoriesDic valueForKey:CATEGORY_NAMES][indexPath.row];
                        sizeDynamic = [description boundingRectWithSize:CGSizeMake(menuCategoriesView.frame.size.width, 0)
                                                                options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                             attributes:@{NSFontAttributeName : [UIFont fontWithName:TEXT_FONT_NAME size:20]}
                                                                context:nil];
                        //                        sizeDynamic = [[[menuCategoriesDic valueForKey:CATEGORY_NAMES] objectAtIndex:indexPath.row] sizeWithFont:[UIFont fontWithName:TEXT_FONT_NAME size:20] constrainedToSize:CGSizeMake(CGFLOAT_MAX,CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
                    }
                    @catch(NSException * exception){
                        
                    }
                    float calculatedWidth = menuCategoriesView.frame.size.width/5;
                    if(calculatedWidth <  sizeDynamic.size.width)
                        calculatedWidth = sizeDynamic.size.width + 10;
                    
                    s = CGSizeMake( calculatedWidth, menuCategoriesView.frame.size.height);
                }
                else {
                    s = CGSizeMake(menuCategoriesView.frame.size.width/5, menuCategoriesView.frame.size.height - 10);
                }
                
            }
            // commented by roja on 11/03/2019..
//            else {
//                if (version >=8.0) {
//                    s = CGSizeMake(menuCategoriesView.frame.size.width/5, menuCategoriesView.frame.size.height - 10);
//                }
//                else {
//                    s = CGSizeMake(menuCategoriesView.frame.size.width/5, menuCategoriesView.frame.size.height - 10);
//                }
//            }
        }
        else if (collectionView == menuCategoriesItemsCollectionView){
            
            s = CGSizeMake( (menuCategoriesItemsCollectionView.frame.size.width - 10)/5, menuCategoriesItemsCollectionView.frame.size.height/4);

            // commented by roja on 11/03/2019..

//            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//                if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
//
//                    s = CGSizeMake( (menuCategoriesItemsCollectionView.frame.size.width - 10)/5, menuCategoriesItemsCollectionView.frame.size.height/4);
//                }
//                else {
//                    s = CGSizeMake( menuCategoriesItemsCollectionView.frame.size.width/5, menuCategoriesItemsCollectionView.frame.size.height/5);
//                }
//
//            }
//            else {
//                if (version >=8.0) {
//                    s = CGSizeMake( menuCategoriesItemsCollectionView.frame.size.width/5, menuCategoriesItemsCollectionView.frame.size.height/5);
//
//
//                }
//                else {
//                    s = CGSizeMake( menuCategoriesItemsCollectionView.frame.size.width/5, menuCategoriesItemsCollectionView.frame.size.height/5);
//                }
//            }
            //upto here commented by roja on 11/03/2019..
        }
        else{
            
            s = CGSizeMake([[UIScreen mainScreen] bounds].size.width/4 - 210, [[UIScreen mainScreen] bounds].size.height/4-160); // width -- 210

            // commented by roja on 11/03/2019..

//            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//                if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
//
//                    NSLog(@"%f",[[UIScreen mainScreen] bounds].size.width/3 );
//
//                    s = CGSizeMake([[UIScreen mainScreen] bounds].size.width/4 - 210, [[UIScreen mainScreen] bounds].size.height/4-160); // width -- 210
//                }
//                else {
//                    s = CGSizeMake([[UIScreen mainScreen] bounds].size.width/4 - 130, [[UIScreen mainScreen] bounds].size.height/4-150); // width -- 130
//                }
//            }
            
//            else {
//                if (version >=8.0) {
//                    s = CGSizeMake([[UIScreen mainScreen] bounds].size.width/5 - 50, [[UIScreen mainScreen] bounds].size.height/4-100);
//
//
//                }
//                else {
//                    s = CGSizeMake([[UIScreen mainScreen] bounds].size.width/4 - 50, [[UIScreen mainScreen] bounds].size.height/4-50);
//                }
//            }
            //upto here commented by roja on 11/03/2019..

        }
    } @catch (NSException *exception) {
        
    } @finally {
        
        return s;
    }
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 0, 5, 5);
}
-(void)collectionView:(UICollectionView *)collectionView_ didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AudioServicesPlaySystemSound (soundFileObject);

    
    if(collectionView_ == menuCategoriesView){
        
        @try {
            menuCategoriesView.tag  = indexPath.row;
            
            [menuCategoriesView reloadData];
            [menuCategoriesView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:menuCategoriesView.tag  inSection:0] atScrollPosition:UICollectionViewScrollPositionNone   animated:YES];
            
        } @catch (NSException *exception) {
            
        } @finally {
            [menuCategoriesItemsCollectionView reloadData];
        }
    }
    else if (collectionView_ == menuCategoriesItemsCollectionView){
        
            @try {
                
                NSString * itemIdStr = @"";
                if(menuCategoriesView.tag == 0){
                    
                    int findIndexPath = 0;
                    
                    for(int i = 1; i < menuCategoriesDic.allKeys.count; i++){
                        
                        findIndexPath = findIndexPath + (int)[[menuCategoriesDic valueForKey:[menuCategoriesDic valueForKey:CATEGORY_NAMES][i]] count];
                        if(findIndexPath > indexPath.row){
                            menuCategoriesItemsCollectionView.tag = i;
                            break;
                        }
                    }
                    
                    int objectIndex = (int)indexPath.row;
                    
                    for (int j = (int)menuCategoriesItemsCollectionView.tag - 1;j > 0; j--){
                        objectIndex = objectIndex - ((int) [[menuCategoriesDic valueForKey:[menuCategoriesDic valueForKey:CATEGORY_NAMES][j]] count]);
                    }
                    
                    //checking details process changed by roja on 23/02/2019...
                    NSDictionary * categoryItemsDic = [menuCategoriesDic valueForKey:[menuCategoriesDic valueForKey:CATEGORY_NAMES][menuCategoriesItemsCollectionView.tag]] [objectIndex];
                    
                    itemIdStr = [self checkGivenValueIsNullOrNil:[categoryItemsDic valueForKey:PLU_CODE] defaultReturn:@""];
                    
                    if ([itemIdStr length] == 0) {
                        itemIdStr = [self checkGivenValueIsNullOrNil:[categoryItemsDic valueForKey:SKU_ID] defaultReturn:@""];
                    }
                    
                    
//                    itemIdStr = [[menuCategoriesDic valueForKey:[menuCategoriesDic valueForKey:CATEGORY_NAMES][menuCategoriesItemsCollectionView.tag]][objectIndex] valueForKey:PLU_CODE];
//
//                    if ([itemIdStr length] == 0  ) {
//                        itemIdStr = [[menuCategoriesDic valueForKey:[menuCategoriesDic valueForKey:CATEGORY_NAMES][menuCategoriesItemsCollectionView.tag]][objectIndex] valueForKey:SKU_ID];
//                    }
                    
//                selected_SKID = [[menuCategoriesDic valueForKey:[menuCategoriesDic valueForKey:CATEGORY_NAMES][menuCategoriesItemsCollectionView.tag]][objectIndex] valueForKey:ITEM_NAME];
                }
                else{
                    //checking details process changed by roja on 23/02/2019...
                    itemIdStr = [[menuCategoriesDic valueForKey:[menuCategoriesDic valueForKey:CATEGORY_NAMES][menuCategoriesView.tag]][indexPath.row] valueForKey:PLU_CODE];
                    
                    if ([itemIdStr length] == 0) {
                        
                        itemIdStr = [[menuCategoriesDic valueForKey:[menuCategoriesDic valueForKey:CATEGORY_NAMES][menuCategoriesView.tag]][indexPath.row] valueForKey:SKU_ID];
                    }
                    
//                    itemIdStr = [[menuCategoriesDic valueForKey:[menuCategoriesDic valueForKey:CATEGORY_NAMES][menuCategoriesView.tag]][indexPath.row] valueForKey:SKU_ID];
                    
//                selected_SKID = [[menuCategoriesDic valueForKey:[menuCategoriesDic valueForKey:CATEGORY_NAMES][menuCategoriesItemsCollectionView.tag]][indexPath.row] valueForKey:ITEM_NAME];
                }
                [self callRawMaterialDetails:itemIdStr];
            } @catch (NSException *exception) {
                
            }

    }
    else{
        if ([[tableStatusArr objectAtIndex:indexPath.row] caseInsensitiveCompare:@"vacant"]!=NSOrderedSame) {
            
            @try {
                NSDictionary *details = [NSDictionary new];
                bookingDetails = [NSDictionary new];
                //            if (isOfflineService) {
                //                RestBookingServices *service = [[RestBookingServices alloc] init];
                //                details = [service getTableInfoOf:[[tableDetails objectAtIndex:indexPath.row]valueForKey:kTableNumber]];
                //            }
                //            else if(![[[tableDetails objectAtIndex:indexPath.row] valueForKey:"order"] isKindOfClass:[NSNull class]] && [[tableDetails objectAtIndex:indexPath.row] valueForKey:"order"]!=nil){
                //
                //                details = [[[tableDetails objectAtIndex:indexPath.row] valueForKey:"order"] copy];
                //            }
                
                sectionTF.text = [self checkGivenValueIsNullOrNil:[[tableDetails objectAtIndex:indexPath.row] valueForKey:@"sectionName"] defaultReturn:@""];
           
                details = [[[tableDetails objectAtIndex:indexPath.row] valueForKey:@"order"] copy];
                
                if ([details count] && details !=nil) {
                    
                    bookingDetails = [details copy];
                    
                    tableNoTxt.text = [self checkGivenValueIsNullOrNil:[details valueForKey:@"salesLocation"] defaultReturn:@""];
                    
                    firstNameTF.text = [self checkGivenValueIsNullOrNil:[details valueForKey:@"customerName"] defaultReturn:@""];
                    
                    lastNameTF.text = [self checkGivenValueIsNullOrNil:[details valueForKey:@"lastName"] defaultReturn:@""];
                    
                    bookingTimeTF.text = [self checkGivenValueIsNullOrNil:[details valueForKey:@"date"] defaultReturn:@""];
                    
                    startTimeTxt.text = [self checkGivenValueIsNullOrNil:[details valueForKey:@"createdOn"] defaultReturn:@""];//lastModifiedDate
                    
                    if(startTimeTxt.text.length == 0){
                        startTimeTxt.text = [WebServiceUtility getCurrentDate];
                    }
                    
                    if (![[details valueForKey:@"orderReference"] isKindOfClass:[NSNull class]] && [[details allKeys] containsObject:@"orderReference"]) {
                        
                        orderRef = [details valueForKey:@"orderReference"];
                    }
                    else
                        orderRef = @"";
                    
                    
                    bookingTypeStr = [self checkGivenValueIsNullOrNil:[details valueForKey:RESERVATION_TYPE_ID] defaultReturn:@""];
                    
                    mobileNoTxt.text = [self checkGivenValueIsNullOrNil:[details valueForKey:@"mobileNumber"] defaultReturn:@""];

                    int headCount = [[details valueForKey:@"adultPax"] intValue]+[[details valueForKey:@"childPax"] intValue];
                    headCountTxt.text = [NSString stringWithFormat:@"%d",headCount];
                    
                    
                    cartTotalItems = [[NSMutableArray alloc]init];
                    cartItem=[[NSMutableArray alloc]init];
                    cartItemDetails = [[NSMutableArray alloc]init];
                    
                    //added by Srinivasulu on 30/01/2019....
                    //any one of the below code can be commented..
                    
                    [self callingOutletOrderIdDetails];
                    
                    //                    if ([[[tableDetails objectAtIndex:indexPath.row] valueForKey:@"orderItems"] count] !=0) {
                    //
                    //                        NSArray *items = [[tableDetails objectAtIndex:indexPath.row] valueForKey:@"orderItems"];
                    //
                    //                        for (int i = 0; i < [items count]; i++) {
                    //
                    //                            NSMutableDictionary * itemDetailsDic = [[items objectAtIndex:i] mutableCopy];
                    //
                    //                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDetailsDic valueForKey:ITEM_UNIT_PRICE]  defaultReturn:@"0.0"] forKey:SALE_PRICE];
                    //                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDetailsDic valueForKey:QUANTITY]  defaultReturn:@"0.0"] forKey:ORDERED_QUANTITY];
                    //
                    //
                    //                            [itemDetailsDic setValue:[NSNumber numberWithBool:false] forKey:IS_VOID];
                    //                            [cartItemDetails addObject:itemDetailsDic];
                    //                        }
                    //                    }
                    
                    //upto here by srinivasulu on 30/01/2019....
                }
            }
            @catch (NSException *exception) {
                
            }
            @finally{
                
                scrollView.hidden = NO;
                
                if ([mobileNoTxt.text length] >= 10) {
                    
                    ratingDetailsBtn = [[UIButton alloc] init];
                    ratingDetailsBtn.tag = 4;
                    [self getCustomerInfo:ratingDetailsBtn];
                }
                
                [self callDealsAndOffersForItem];
//                [self calculateTotal];
            }
        }
        
        else{
            
            float y_axis = self.view.frame.size.height / 2;
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"The table you have selected is vacant",nil)];
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2 verticalAxis:y_axis  msgType:@"" conentWidth:300 contentHeight:40  isSoundRequired:NO timming:2.0 noOfLines:2];
        }
    }
    
}

#pragma -mark end of collection view methods

-(void)goToHome {
    
    [self backAction];
}

-(void)backAction {
    if ([totalItemsArray count]) {
        
        warning = [[UIAlertView alloc]initWithTitle:@"Do you want to save the order" message:nil delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
        [warning show];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

/**
 * @discussion Add popup showing the customer info
 * @date   21/1/16
 * @method populateCustomerInfoPopUp
 * @author Sonali
 * @param customer information of type NSDictionary
 */
-(void)populateCustomerInfoPopUp:(NSDictionary*)custInfo {
    
    PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
    
    UIView *customerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 450, 300)];
    customerView.opaque = NO;
    customerView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    customerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    customerView.layer.borderWidth = 2.0f;
    [customerView setHidden:NO];
    
    UILabel *custType = [[UILabel alloc] init];
    custType.textColor = [UIColor blackColor];
    custType.font = [UIFont boldSystemFontOfSize:18.0];
    custType.text  = @"Customer Type";
    
    UILabel *custTypeVal = [[UILabel alloc] init];
    custTypeVal.textColor = [UIColor blackColor];
    custTypeVal.font = [UIFont boldSystemFontOfSize:18.0];
    if (![custInfo objectForKey:@"category"]&&[[custInfo objectForKey:@"category"] length] > 0) {
        custTypeVal.text  = [custInfo objectForKey:@"category"];
    }
    else {
        custTypeVal.text  = @"--";
        
    }
    
    
    UILabel *custName = [[UILabel alloc] init];
    custName.textColor = [UIColor blackColor];
    custName.font = [UIFont boldSystemFontOfSize:18.0];
    custName.text  = @"Customer Name";
    
    UILabel *custNameVal = [[UILabel alloc] init];
    custNameVal.textColor = [UIColor blackColor];
    custNameVal.font = [UIFont boldSystemFontOfSize:18.0];
    if ([[custInfo objectForKey:@"name"] length] > 0) {
        custNameVal.text  = [custInfo objectForKey:@"name"];
    }
    else {
        custNameVal.text  = @"--";
        
    }
    
    
    UILabel *custPhone = [[UILabel alloc] init];
    custPhone.textColor = [UIColor blackColor];
    custPhone.font = [UIFont boldSystemFontOfSize:18.0];
    custPhone.text  = @"Customer Phone";
    
    UILabel *custPhoneVal = [[UILabel alloc] init];
    custPhoneVal.textColor = [UIColor blackColor];
    custPhoneVal.font = [UIFont boldSystemFontOfSize:18.0];
    if ([[custInfo objectForKey:@"phone"] length] > 0) {
        custPhoneVal.text  = [custInfo objectForKey:@"phone"];
    }
    else {
        custPhoneVal.text  = @"--";
        
    }
    
    UILabel *custEmail = [[UILabel alloc] init];
    custEmail.textColor = [UIColor blackColor];
    custEmail.font = [UIFont boldSystemFontOfSize:18.0];
    custEmail.text  = @"Customer Email";
    
    UILabel *custEmailVal = [[UILabel alloc] init];
    custEmailVal.textColor = [UIColor blackColor];
    custEmailVal.font = [UIFont boldSystemFontOfSize:18.0];
    custEmailVal.lineBreakMode = NSLineBreakByWordWrapping;
    custEmailVal.numberOfLines = 0;
    if ([[custInfo objectForKey:@"email"] length] > 0) {
        custEmailVal.text  = [custInfo objectForKey:@"email"];
    }
    else {
        custEmailVal.text   = @"--";
        
    }
    
    
    UILabel *street = [[UILabel alloc] init];
    street.textColor = [UIColor blackColor];
    street.font = [UIFont boldSystemFontOfSize:18.0];
    street.text  = @"Street";
    
    UILabel *streetVal = [[UILabel alloc] init];
    streetVal.textColor = [UIColor blackColor];
    streetVal.font = [UIFont boldSystemFontOfSize:18.0];
    if ([[custInfo objectForKey:@"street"] length] > 0) {
        streetVal.text  = [custInfo objectForKey:@"street"];
    }
    else {
        streetVal.text    = @"--";
        
    }
    
    UILabel *locality = [[UILabel alloc] init];
    locality.textColor = [UIColor blackColor];
    locality.font = [UIFont boldSystemFontOfSize:18.0];
    locality.text  = @"Locality";
    
    UILabel *localityVal = [[UILabel alloc] init];
    localityVal.textColor = [UIColor blackColor];
    localityVal.font = [UIFont boldSystemFontOfSize:18.0];
    if ([[custInfo objectForKey:@"locality"] length] > 0) {
        localityVal.text  = [custInfo objectForKey:@"locality"];
    }
    else {
        localityVal.text    = @"--";
        
    }
    
    UILabel *city = [[UILabel alloc] init];
    city.textColor = [UIColor blackColor];
    city.font = [UIFont boldSystemFontOfSize:18.0];
    city.text  = @"City";
    
    UILabel *cityVal = [[UILabel alloc] init];
    cityVal.textColor = [UIColor blackColor];
    cityVal.font = [UIFont boldSystemFontOfSize:18.0];
    if ([[custInfo objectForKey:@"city"] length] > 0) {
        cityVal.text  = [custInfo objectForKey:@"city"];
    }
    else {
        cityVal.text    = @"--";
        
    }
    
    UILabel *pin = [[UILabel alloc] init];
    pin.textColor = [UIColor blackColor];
    pin.font = [UIFont boldSystemFontOfSize:18.0];
    pin.text  = @"Pin No";
    
    UILabel *pinVal = [[UILabel alloc] init];
    pinVal.textColor = [UIColor blackColor];
    pinVal.font = [UIFont boldSystemFontOfSize:18.0];
    if ([[custInfo objectForKey:@"pin_no"] length] > 0) {
        pinVal.text  = [custInfo objectForKey:@"pin_no"];
    }
    else {
        pinVal.text   =  @"--";
        
    }
    
    //    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    //        if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
    
    custType.frame =  CGRectMake(10, 5, 150, 30);
    custTypeVal.frame =  CGRectMake(230, 5, 200, 30);
    
    custName.frame =  CGRectMake(10, 40, 150, 30);
    custNameVal.frame =  CGRectMake(230, 40, 200, 30);
    custPhone.frame =  CGRectMake(10, 75, 150, 30);
    custPhoneVal.frame =  CGRectMake(230, 75, 200, 30);
    custEmail.frame =  CGRectMake(10, 110, 150, 30);
    custEmailVal.frame =  CGRectMake(230, 110, 400, 30);
    
    street.frame =  CGRectMake(10, 145, 150, 30);
    streetVal.frame =  CGRectMake(230, 145, 200, 30);
    locality.frame =  CGRectMake(10, 180, 150, 30);
    localityVal.frame =  CGRectMake(230, 180, 200, 30);
    city.frame =  CGRectMake(10, 215, 150, 30);
    cityVal.frame =  CGRectMake(230, 215, 400, 30);
    
    pin.frame =  CGRectMake(10, 250, 170, 30);
    pinVal.frame =  CGRectMake(230, 250, 400, 30);
    //        }
    //    }
    
    [customerView addSubview:custType];
    [customerView addSubview:custTypeVal];
    [customerView addSubview:custName];
    [customerView addSubview:custNameVal];
    [customerView addSubview:custPhone];
    [customerView addSubview:custPhoneVal];
    [customerView addSubview:custEmail];
    [customerView addSubview:custEmailVal];
    [customerView addSubview:street];
    [customerView addSubview:streetVal];
    [customerView addSubview:locality];
    [customerView addSubview:localityVal];
    [customerView addSubview:city];
    [customerView addSubview:cityVal];
    [customerView addSubview:pin];
    [customerView addSubview:pinVal];
    
    customerInfoPopUp.view = customerView;
    
    customerInfoPopUp.preferredContentSize =  CGSizeMake(customerView.frame.size.width, customerView.frame.size.height);
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
    //                [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    [popover presentPopoverFromRect:mobileNoTxt.frame inView:scrollView permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    customerInfoPopOver= popover;
    
    
    UIGraphicsBeginImageContext(customerView.frame.size);
    [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customerView.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    customerView.backgroundColor = [UIColor colorWithPatternImage:image];
    
}


/**
 * @description    handles the segment action
 * @date           26/11/15
 * @method         mainSegmentAction
 * @author         Sonali
 * @param          sender of type id
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)mainSegmentAction:(id)sender {
    
    NSUInteger  mainSegmentSelectedIndex = mainSegmentControl.selectedSegmentIndex;
    
    switch (mainSegmentSelectedIndex) {
        case 0:
        {
            menuTable.hidden = NO;
        }
            break;
        case 1:
        {
            menuTable.hidden = YES;
        }
            break;
    }
}

#pragma -mark update service delegates
-(void)updateBookingSuccess:(NSDictionary *)successDictionary {
    
//    sucess = [[UIAlertView alloc] initWithTitle:@"Order Placed Successfully" message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//    [sucess show];
    
    float y_axis = self.view.frame.size.height - 120;
    NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"Order Updated Successfully",nil)];
    [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:@"" conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    
}

-(void)updateBookingFailure:(NSString *)failureString {

    float y_axis = self.view.frame.size.height - 120;
    NSString * msg = failureString;
    [self displayAlertMessage:msg horizontialAxis:(self.view.frame.size.width - 350)/2  verticalAxis:y_axis  msgType:@""  conentWidth:350 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
}

#pragma -mark alertview delegates
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView == sucess) {
        
        if (buttonIndex == 0) {
            
            OmniHomePage *home = [[OmniHomePage alloc] init];
            [self.navigationController pushViewController:home animated:YES];
        }
    }
    else if(alertView == warning) {
        
        if (buttonIndex==0) {
            
            OmniHomePage *home = [[OmniHomePage alloc] init];
            [self.navigationController pushViewController:home animated:YES];
        }
        else {
            OmniHomePage *home = [[OmniHomePage alloc] init];
            [self.navigationController pushViewController:home animated:YES];
        }
    }
}
/**
 * @discussion check the customer category
 * @date  15/10/15
 * @method provideCustomerRatingfor
 * @author Sonali
 * @param category
 
 */


-(void)provideCustomerRatingfor:(NSString *)category
{
    [starRat removeFromSuperview];
    starRat = [[UIImageView alloc] init];
    starRat.backgroundColor = [UIColor clearColor];

    starRat.frame = CGRectMake((startTimeTxt.frame.origin.x + startTimeTxt.frame.size.width + 33), startTimeTxt.frame.origin.y, eatingHabitsTF.frame.size.width, 40);
            
//    [self.view addSubview:starRat];

    [scrollView addSubview:starRat];

    if ([category isEqualToString:@"premium"])
    {
        [self ratingView:5.0 outOf:5.0 imageView:starRat];
    }
    else if ([category isEqualToString:@"generic"])
    {
        [self ratingView:4.0 outOf:5.0 imageView:starRat];
    }
    else if ([category isEqualToString:@"plus"])
    {
        [self ratingView:3.0 outOf:5.0 imageView:starRat];
    }
    else if ([category isEqualToString:@"basic"])
    {
        [self ratingView:2.5 outOf:5.0 imageView:starRat];
    }
    else if ([category isEqualToString:@"normal"])
    {
        [self ratingView:2.0 outOf:5.0 imageView:starRat];
    }
    else
    {
        [self ratingView:0.0 outOf:5.0 imageView:starRat];
    }
}

/**
 * @discussion present the star rating based on the customer category
 * @date  15/1/16
 * @method ratingView
 * @author Sonali
 * @param ratingValue of type double
 * @param totalValue
 * @param star image view
 */

-(void )ratingView:(double)ratingValue outOf:(NSUInteger)totalValue imageView:(UIImageView *)view

{
    NSUInteger xPos = view.frame.origin.x;
    if (ratingValue >= 5) {
        
        ratingValue = 5;
    }
    double tempRatingValue = ratingValue;
    UIImageView *starImageView;
    
    for (NSUInteger currentStar=0; currentStar<totalValue; currentStar++) { // Looping for each star(imageView) in the KDRatingView
        
//        starImageView = [[UIImageView alloc] initWithFrame:CGRectMake(xPos, view.frame.origin.y, view.frame.size.width/totalValue, view.frame.size.height)];
        
        starImageView = [[UIImageView alloc] initWithFrame:CGRectMake(xPos, view.frame.origin.y, view.frame.size.width/totalValue-20, 30)];

        
        if (tempRatingValue-1>=0) {
            tempRatingValue--;
            // place one complete star
            [starImageView setImage:[UIImage imageNamed:@"1_star"]];
            
        } else {
            if ((tempRatingValue>=0)&&(tempRatingValue<0.25)) {
                // place 0 star
                [starImageView setImage:[UIImage imageNamed:@"grey_star@2x.png"]];
                
            } else if ((tempRatingValue>=0.25)&&(tempRatingValue<0.50)) {
                // place 1/4 star
                [starImageView setImage:[UIImage imageNamed:@"14_star"]];
                
            } else if ((tempRatingValue>=0.50)&&(tempRatingValue<0.75)) {
                // place 1/2 star
                [starImageView setImage:[UIImage imageNamed:@"12_star"]];
                
            } else if ((tempRatingValue>=0.75)&&(tempRatingValue<1.0)) {
                // place 3/4 star
                [starImageView setImage:[UIImage imageNamed:@"34_star"]];
            }
            
            tempRatingValue=0;
        }
        
        // set tag starImageView which will allow to identify and differentiate it individually in calling class.
        // Add starImageView to view as a subView
        starImageView.tag = currentStar;
//        [self.view addSubview:starImageView];
        [scrollView addSubview:starImageView];

        // calculate new xPos and yPos
        xPos = xPos + starImageView.frame.size.width + 10;
    }
    
    
}



#pragma -mark Changed methods by Srinviasulu & Roja from 23/01/2019...

- (void) delRow:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    @try{
        
        NSMutableDictionary * tempMutDic = [[cartItemDetails objectAtIndex:[sender tag]] mutableCopy];
        
        if([[self checkGivenValueIsNullOrNil:[tempMutDic valueForKey:IS_VOID] defaultReturn:@"0"] boolValue]){
            
            [tempMutDic setValue:[NSNumber numberWithBool:false] forKey:IS_VOID];
        }
        else {
            
            [tempMutDic setValue:[NSNumber numberWithBool:true] forKey:IS_VOID];
        }
        
        [cartItemDetails replaceObjectAtIndex:[sender tag] withObject:tempMutDic];
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"%@",exception);
    }
    @finally{
        
        [self callDealsAndOffersForItem];
    }
}

#pragma -mark Changed methods by Srinviasulu & Roja from 23/01/2019...




/**
 * @description       add service to the cart
 * @date              27/11/15
 * @method            addServiceToCart
 * @author            Sonali
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */


-(void)addItemsToCart:(UIButton*)sender {
    
    AudioServicesPlaySystemSound (soundFileObject);
    
    itemTagInt = (int)sender.tag;
    
    NSMutableArray *titleList = [totalItemsArray objectAtIndex:self.selectIndex.section];
    
    
    selected_SKID = [[NSString stringWithFormat:@"%@",[titleList objectAtIndex:itemTagInt]] copy];
    
    
    NSMutableArray * pluCodeArr  = [menuItemsSkuIdArr objectAtIndex:self.selectIndex.section];
    selected_SKID = [[NSString stringWithFormat:@"%@",[pluCodeArr objectAtIndex:itemTagInt]] copy];
    
    
    if (!isOfflineService) {
        
        HUD.dimBackground = YES;
        [HUD setHidden:NO];
        
        
        NSArray *keys = [NSArray arrayWithObjects:@"skuId",REQUEST_HEADER,@"storeLocation", nil];
        NSArray *objects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",selected_SKID],[RequestHeader getRequestHeader],presentLocation, nil];
        
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err];
        NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        @try {
            WebServiceController *webServiceController = [WebServiceController new];
            [webServiceController setGetSkuDetailsDelegate:self];
            [webServiceController getSkuDetailsWithData:salesReportJsonString];
            
        }
        @catch (NSException *exception) {
            [HUD setHidden:YES];
            
        }
        
        
    }
    //    else {
    //
    //        @try {
    //
    //            offline = [[OfflineBillingServices alloc]init];
    //            //                priceDic = [[NSMutableArray alloc]init];
    //            NSDictionary *itemDic = [offline getProductDetails:[NSString stringWithFormat:@"%@",selected_SKID]];
    //            if ([itemDic count]>0) {
    //
    //                NSString *taxRate = [offline getTaxForSku:[NSString stringWithFormat:@"%@",[itemDic valueForKey:@"taxCode"]]];
    //
    //                NSString *itemString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",[itemDic  objectForKey:@"description"],@"#",[itemDic objectForKey:@"description"],@"#",[itemDic objectForKey:@"quantity"],@"#",[itemDic objectForKey:@"price"], @"#", [NSString stringWithFormat:@"%@",[itemDic objectForKey:@"taxCode"]]];
    //
    //                if ([taxRate length]>0) {
    //
    //                    [taxArr addObject:taxRate];
    //                    itemString = [NSString stringWithFormat:@"%@%@%@",itemString,@"#",taxRate];
    //                }
    //                else {
    //
    //                    taxRate = @"0.00";
    //                    [taxArr addObject:taxRate];
    //                    itemString = [NSString stringWithFormat:@"%@%@%@",itemString,@"#",taxRate];
    //                }
    //                if ([[[itemString componentsSeparatedByString:@"#"] objectAtIndex:2] intValue]!=0) {
    //
    //                    selected_desc = [[itemString componentsSeparatedByString:@"#"] objectAtIndex:1];
    //                    selected_price = [[[itemString componentsSeparatedByString:@"#"] objectAtIndex:3] copy];
    //                    [self getSkuDetailsHandler:itemString];
    //
    //                }
    //                else {
    //
    //                    [HUD setHidden:YES];
    //                    UIAlertView *alert=  [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Stock Not Available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //                    [alert show];
    //                }
    //            }
    //            //                }
    //            else {
    //
    //                [HUD setHidden:YES];
    //                UIAlertView *alert=  [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Product Not Available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //                [alert show];
    //            }
    //
    //        }
    //        @catch (NSException *exception) {
    //            NSLog(@"%@",exception);
    //            [HUD setHidden:YES];
    //            UIAlertView *alert=  [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Product Not Available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //            [alert show];
    //
    //        }
    //
    //
    //
    //
    //    }
    
    
}




-(void)callRawMaterialDetails:(NSString *)pluCodeStr {
    
    
    @try {
        [HUD show:YES];
        [HUD setHidden: NO];
        [HUD setLabelText:NSLocalizedString(@"please_wait..",nil)];
        
        NSDictionary * campaigndictionary_;
        
        if(isToCallApplyCampaigns){
            
            NSMutableArray *skuIdList = [[NSMutableArray alloc]init];
            NSMutableArray *pluCodeList = [[NSMutableArray alloc]init];
            NSMutableArray *unitPriceList = [[NSMutableArray alloc]init];
            NSMutableArray *qtyList = [[NSMutableArray alloc]init];
            NSMutableArray *totalPriceList = [[NSMutableArray alloc]init];
            NSMutableArray *itemStatusList = [NSMutableArray new];
            NSMutableArray *itemDiscountList = [NSMutableArray new];
            
            for (int i = 0; i < cartItemDetails.count; i++) {
                
                NSDictionary *itemDetailsDic = [cartItemDetails objectAtIndex:i];
                [skuIdList addObject:[itemDetailsDic valueForKey:ITEM_SKU]];
                [pluCodeList addObject:[itemDetailsDic valueForKey:PLU_CODE]];
                [unitPriceList addObject:[NSString stringWithFormat:@"%.2f",[[itemDetailsDic valueForKey:Item_Price]floatValue]] ];
                [qtyList addObject: [NSString stringWithFormat:@"%.2f",[[itemDetailsDic valueForKey:ORDERED_QUANTITY]floatValue] ] ];
                [totalPriceList addObject: [NSString stringWithFormat:@"%.2f", [[itemDetailsDic valueForKey:Item_Price] floatValue] * [[itemDetailsDic valueForKey:ORDERED_QUANTITY]floatValue]] ];
                
                [itemStatusList addObject:@""];
                //[itemDiscountList addObject:@([itemDiscountArr[i] floatValue])];
                [itemDiscountList addObject:[itemDetailsDic valueForKey:DISCOUNT]];
            }
            
            NSArray *loyaltyKeys = @[STORELOCATION, REQUEST_HEADER, SKU_ID_ARR_LIST, PLU_CODE_ARR_LIST, UNIT_PRICE_ARR_LIST, QTY_ARR_LIST, TOTAL_PRICE_ARR_LIST, ITME_STATUS_ARR_LIST, PRODUCT_OPTIONAL_DISCOUNT_ARR, TOTAL_BILL_AMOUNT, QUANTITY, PHONE_NUMBER, PURCHASE_CHANNEL, EMPLOYEE_CODE, LATEST_CAMPAIGNS];
            
            NSString *empCodeStr = @"";
            
            NSArray *loyaltyObjects = @[presentLocation,[RequestHeader getRequestHeader],skuIdList,pluCodeList,unitPriceList,qtyList,totalPriceList,itemStatusList, itemDiscountList, netPayValLbl.text,@"1",mobileNoTxt.text,POS,empCodeStr,@(applyLatestCampaigns)];
            
            campaigndictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        }
        else{
            campaigndictionary_ = [[NSDictionary alloc]init];
            
        }
        
        Boolean isCampaignsRequired = false;
        
        if (isToCallApplyCampaigns) {
            isCampaignsRequired = true;
        }
        
        // NSDictionary * productDetailsDic = [[NSDictionary alloc] init];
        
        NSDictionary * productDetailsDic  = [NSDictionary dictionaryWithObjectsAndKeys:presentLocation,kStoreLocation,[RequestHeader getRequestHeader],REQUEST_HEADER,pluCodeStr,ITEM_SKU,NEGATIVE_ONE,START_INDEX,[NSNumber numberWithBool:TRUE],kIsApplyCampaigns,campaigndictionary_,CART_DETAILS,[NSNumber numberWithBool:TRUE],kZeroStockBillCheck,[NSNumber numberWithBool: isCampaignsRequired],IS_CAMPAIGNS_REQUIRED, nil];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:productDetailsDic options:0 error:&err];
        NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.getSkuDetailsDelegate = self;
        [webServiceController getSkuDetailsWithData:salesReportJsonString];
        
    }
    @catch (NSException *exception) {
        
        [HUD setHidden: YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    
}

/**
 * @description  This method is used to call apply campaigns...
 * @date         17/09/2018
 * @method       callDealsAndOffersForItem
 * @author       Roja
 * @param
 * @param
 * @return       void
 * @verified By
 * @verified On
 */

-(void)callDealsAndOffersForItem {
    
    @try {
        
        if(isToCallApplyCampaigns){
            
            [HUD setHidden:NO];
            
            NSMutableArray *skuIdList = [[NSMutableArray alloc]init];
            NSMutableArray *pluCodeList = [[NSMutableArray alloc]init];
            NSMutableArray *unitPriceList = [[NSMutableArray alloc]init];
            NSMutableArray *qtyList = [[NSMutableArray alloc]init];
            NSMutableArray *totalPriceList = [[NSMutableArray alloc]init];
            NSMutableArray *itemStatusList = [NSMutableArray new];
            NSMutableArray *itemDiscountList = [NSMutableArray new];
            
            for (int i = 0; i < cartItemDetails.count; i++) {
                
                NSDictionary * detailsDic = [cartItemDetails objectAtIndex:i];
                [skuIdList addObject:[detailsDic valueForKey:ITEM_SKU]];
                [pluCodeList addObject:[detailsDic valueForKey:PLU_CODE]];
                [unitPriceList addObject:[NSString stringWithFormat:@"%.2f",[[detailsDic valueForKey:ITEM_UNIT_PRICE]floatValue]] ];
                [qtyList addObject: [NSString stringWithFormat:@"%.2f",[[detailsDic valueForKey:QUANTITY]floatValue] ] ];
                [totalPriceList addObject: [NSString stringWithFormat:@"%.2f", [[detailsDic valueForKey:ITEM_UNIT_PRICE] floatValue] * [[detailsDic valueForKey:QUANTITY]floatValue]] ];
                
                [itemStatusList addObject:@""];
                [itemDiscountList addObject:@"0.00"];
            }
            
            NSString *quantity = @"1";
            
            NSArray *loyaltyKeys = @[STORELOCATION, REQUEST_HEADER, SKU_ID_ARR_LIST, PLU_CODE_ARR_LIST, UNIT_PRICE_ARR_LIST, QTY_ARR_LIST, TOTAL_PRICE_ARR_LIST, ITME_STATUS_ARR_LIST, PRODUCT_OPTIONAL_DISCOUNT_ARR, TOTAL_BILL_AMOUNT, QUANTITY, PHONE_NUMBER, PURCHASE_CHANNEL, EMPLOYEE_CODE, LATEST_CAMPAIGNS];
            
            NSString *empCodeStr = @"";
            
            NSArray *loyaltyObjects = @[presentLocation,[RequestHeader getRequestHeader],skuIdList,pluCodeList,unitPriceList,qtyList,totalPriceList,itemStatusList, itemDiscountList, netPayValLbl.text,quantity,mobileNoTxt.text,POS,empCodeStr,@(applyLatestCampaigns)];
            
            NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
            
            NSError * err_;
            NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
            NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
            
            WebServiceController *serviceController = [WebServiceController new];
            serviceController.getDealsAndOffersDelegate = self;
            [serviceController getDealsAndOffersWithData:loyaltyString];
        }
        else{
            [self calculateTotal];
        }
    }
    @catch (NSException *exception) {
        [self calculateTotal];
        [HUD setHidden:YES];
    }
}

#pragma mark - Get SKU Details Service Reposnse Delegates

/**
 * @description  here we are handling the resposne received from services.......
 * @date         27/03/2018
 * @method       getSkuDetailsSuccessResponse:
 * @author       Bhargav.v
 * @param        NSDictionary
 * @param
 * @return
 * @modified BY  Srinivasulu on 17/01/2016 and Roja on 18-09-2018..
 * @Reason       calculating minimum quantity based on item "packed" flag. Also sending Apply Campaign as input to
 getDealsAndOffersSuccessResponse.
 * @return
 * @verified By
 * @verified On
 */

- (void)getSkuDetailsSuccessResponse:(NSDictionary *)successDictionary
{
    
    @try {
        
        if([[successDictionary allKeys] containsObject:kSkuLists] && ![[successDictionary valueForKey:kSkuLists] isKindOfClass:[NSNull class]]){
            
            if([[successDictionary valueForKey:kSkuLists] count] > 0){
                
                NSDictionary * itemdic = [[successDictionary valueForKey:kSkuLists] objectAtIndex:0];
                
                BOOL isNewItem = TRUE;
                int i = 0;
                NSMutableDictionary * existingDic;
                
                for(NSDictionary * tempDic in cartItemDetails){
                    
                    if ([[tempDic valueForKey:ITEM_SKU] isEqualToString:[itemdic valueForKey:ITEM_SKU]] && [[tempDic valueForKey:PLU_CODE] isEqualToString:[itemdic valueForKey:PLU_CODE]]) {
                        
                        existingDic = [tempDic mutableCopy];
                        isNewItem = FALSE;
                        break;
                    }
                    i++;
                }
                
                Boolean  showAlert = false;
                Boolean  isToAllowZeroStock = true;
                
                float minimumQty = 0;
                
                if(!isNewItem)
                    minimumQty = [[existingDic valueForKey:QUANTITY] floatValue];
                //                    minimumQty = [[existingDic valueForKey:ORDERED_QUANTITY] floatValue];
                
                bool isPacked = false;
                
                if(!zeroStockCheckAtOutletLevel ||  (zeroStockCheckAtOutletLevel && ![[itemdic valueForKey:kZeroStock] boolValue])){
                    isToAllowZeroStock = false;
                    float availQty = [[self checkGivenValueIsNullOrNil:[itemdic valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue];
                    
                    
                    if ([[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kPackagedType] defaultReturn:@"0"]  boolValue]) {
                        
                        minimumQty = minimumQty + 1;
                        isPacked = true;
                    }
                    
                    if ( (minimumQty > availQty) || (minimumQty == availQty  && !isPacked) ){
                        
                        showAlert = true;
                    }
                    else if(!isPacked){
                        
                        availQty = availQty - minimumQty;
                        
                        if(availQty < 1 && availQty > 0)
                            minimumQty = minimumQty + availQty;
                        else
                            minimumQty = minimumQty + 1;
                    }
                }
                else{
                    
                    minimumQty = minimumQty + 1;
                }
                
                
                if(showAlert){
                    
                    SystemSoundID    soundFileObject1;
                    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
                    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
                    
                    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                    AudioServicesPlaySystemSound (soundFileObject1);
                    
                    UIAlertView *alert=  [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"out_of_stock", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil];
                    [alert show];
                    return;
                }
                else if(!isNewItem){
                    
                    [existingDic setValue: [NSString stringWithFormat:@"%.2f",minimumQty] forKey:QUANTITY];
                    [existingDic setValue: [NSString stringWithFormat:@"%.2f",minimumQty] forKey:ORDERED_QUANTITY];
                    //                    [existingDic setValue: [NSString stringWithFormat:@"%.2f",minimumQty] forKey:ORDERED_QUANTITY];
                }
                
                
                
                //
                SystemSoundID    soundFileObject1;
                NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
                self.soundFileURLRef = (__bridge CFURLRef) tapSound;
                
                AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                AudioServicesPlaySystemSound (soundFileObject1);
                
                
                
                
                
                
                if (isNewItem) {
                    
                    NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc] init];
                    //ITEM_SKU @"skuId" --  ITEM_CODE @"itemCode" -- ITEM_DESCRIPTION @"itemDescription" -- QUANTITY @"quantity" -- ITEM_UNIT_PRICE @"price" -- TOTAL @"total" -- REMARKS @"remarks" -- STATUS @"status" --  PLU_CODE @"pluCode"
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_SKU];
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_CODE];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_SKU] defaultReturn:@""] forKey:iTEM_ID];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_NAME];
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESCRIPTION_];
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESCRIPTION];
                    
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:COLOR] defaultReturn:@""] forKey:COLOUR];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:MAKE] defaultReturn:@""] forKey:MAKE];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:UOM] defaultReturn:@"--"] forKey:UOM];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:kBrand] defaultReturn:@""] forKey:kBrand];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:PRODUCT_CLASS] defaultReturn:@""] forKey:PRODUCT_CLASS];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:SUB_CLASS] defaultReturn:@""] forKey:SUB_CLASS];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kItemDept] defaultReturn:@""] forKey:kItemDept];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kItemSubDept] defaultReturn:@""] forKey:kItemSubDept];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kMeasureRange] defaultReturn:@""] forKey:kMeasureRange];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:STYLE] defaultReturn:@""] forKey:STYLE];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:EAN] defaultReturn:@""] forKey:EAN];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:UTILITY] defaultReturn:@""] forKey:UTILITY];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:SECTION] defaultReturn:@""] forKey:SECTION];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_SCAN_CODE] defaultReturn:@""] forKey:ITEM_SCAN_CODE];
                    
                    //Setting price as mrp(Max Retail Price).
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_UNIT_PRICE] defaultReturn:@"0.00"] floatValue]] forKey:MAX_RETAIL_PRICE];
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_UNIT_PRICE] defaultReturn:@"0.00"] floatValue]] forKey:ITEM_UNIT_PRICE];
                    //                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_UNIT_PRICE] defaultReturn:@"0.00"] floatValue]] forKey:SALE_PRICE];
                    
                    //setting Sale Price...
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:SALE_PRICE] defaultReturn:@"0.00"] floatValue]] forKey:SALE_PRICE];
                    
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:SALE_PRICE] defaultReturn:@"0.00"] floatValue]] forKey:Item_Price];
                    
                    
                    // For Getting The TaxRate Value...
                    
                    // added by roja on 11-09-2018...
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:TAX_CODE] defaultReturn:@""] forKey:TAX_CODE];
                    [itemDetailsDic setValue:@0.0f forKey:TAXX_VALUE];
                    [itemDetailsDic setValue:@0.0f forKey:TAX_RATE];
                    [itemDetailsDic setValue:@0.0f forKey:TAX_VALUE];
                    
                    [itemDetailsDic setValue:[itemdic valueForKey:TAX] forKey:TAX];
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kItemTaxExclusive] defaultReturn:ZERO_CONSTANT] forKey:kItemTaxExclusive];

                    [itemDetailsDic setValue: [self checkGivenValueIsNullOrNil:[itemdic valueForKey:TAXATION_ON_DISCOUNT_PRICE] defaultReturn:ZERO_CONSTANT]  forKey:TAXATION_ON_DISCOUNT_PRICE];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kIsManuFacturedItem] defaultReturn:ZERO_CONSTANT] forKey:kIsManuFacturedItem];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kPackagedType] defaultReturn:ZERO_CONSTANT] forKey:kPackagedType];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:TRACKING_REQUIRED] defaultReturn:ZERO_CONSTANT] forKey:TRACKING_REQUIRED];
                    
                    [itemDetailsDic setValue:[NSNumber numberWithBool:isToAllowZeroStock] forKey:ZERO_STOCK_FLAG];
                    
                    [itemDetailsDic setValue:[NSNumber numberWithBool:[[self checkGivenValueIsNullOrNil:[itemdic valueForKey:EDITABLE] defaultReturn:ZERO_CONSTANT] boolValue]] forKey:EDITABLE];
                    
                    
                    [itemDetailsDic setValue:[NSNumber numberWithBool:false] forKey:EDIT_PRICE_FLAG];
                    [itemDetailsDic setValue:[NSNumber numberWithBool:true] forKey:EDIT_TABLE_FLAG];
                    [itemDetailsDic setValue:[NSNumber numberWithBool:false] forKey:VOID_STATUS_FLAG];
                    [itemDetailsDic setValue:[NSNumber numberWithBool:false] forKey:IS_VOID];
                    
                    [itemDetailsDic setValue:@0.0f forKey:ISGST_RATE];
                    [itemDetailsDic setValue:@0.0f forKey:IS_GST_VALUE];
                    [itemDetailsDic setValue:@0.0f forKey:OTHER_TAX_RATE];
                    [itemDetailsDic setValue:@0.0f forKey:OTHER_TAX_VALUE];
                    [itemDetailsDic setValue:@0.0f forKey:DISCOUNT];
                    [itemDetailsDic setValue:@"--" forKey:DISCOUNT_ID];
                    
                    // extra keys
                    [itemDetailsDic setValue:@0.0f forKey:SALE_PRICE_AFTER_DISCOUNT];
                    [itemDetailsDic setValue:@0.0f forKey:ITEM_COST_BEFORE_OTHER_DISCOUNT];
                    
                    [itemDetailsDic setValue:@0.0f forKey:ITEM_SPECIAL_DISCOUNT];
                    [itemDetailsDic setValue:@0.0f forKey:MANAUAL_DISCOUNT];
                    
                    [itemDetailsDic setValue:@0.0f forKey:CGST_RATE];
                    [itemDetailsDic setValue:@0.0f forKey:CGST_VALUE];
                    [itemDetailsDic setValue:@0.0f forKey:SGST_RATE];
                    [itemDetailsDic setValue:@0.0f forKey:SGST_VALUE];
                    
                    [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:HSN_CODE] defaultReturn:@""] forKey:HSN_CODE];
                    
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic valueForKey:QUANTITY] defaultReturn:@"0"] floatValue]] forKey:MAX_QUANTITY];
                    
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f", minimumQty] forKey:ORDERED_QUANTITY];
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f", minimumQty] forKey:QUANTITY];
                    
                    
                    //                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:ORDERED_QUANTITY];
                    
                    float totalCost = [[self checkGivenValueIsNullOrNil:[itemDetailsDic valueForKey:SALE_PRICE] defaultReturn:@"0.00"] floatValue] * [[self checkGivenValueIsNullOrNil:[itemDetailsDic valueForKey:ORDERED_QUANTITY] defaultReturn:@"0.00"] floatValue];
                    
                    //For Getting the Total Cost..
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",totalCost] forKey:ITEM_TOTAL_COST];
                    
//                    [itemDetailsDic setValue:@"ordered" forKey:STATUS];

                    [itemDetailsDic setValue:@"Draft" forKey:STATUS];

                    [cartItemDetails addObject:itemDetailsDic];
                }
                else{
                    
                    [cartItemDetails replaceObjectAtIndex:i withObject:existingDic];
                }
            }
            else{
                //pricelist handling has to be done....
                
            }
        }
        
    }
    @catch (NSException * exception) {
        NSLog(@"-------exception will reading.-------%@",exception);
    }
    @finally{
        
        if([[successDictionary allKeys] containsObject:Apply_Campaigns] && ![[successDictionary valueForKey:Apply_Campaigns] isKindOfClass:[NSNull class]]){
            [self getDealsAndOffersSuccessResponse:[successDictionary valueForKey:Apply_Campaigns]];
        }else{
            
            [self calculateTotal];
        }
        [HUD setHidden:YES];
    }
}

/**
 * @description  in this method we will call the services....
 * @method       getSkuDetailsErrorResponse
 * @author
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 * @modified By Srinivasulu on 23/01/2019...
 * @reason      added comments && added new field in items level....
 *
 */

- (void)getSkuDetailsErrorResponse:(NSString*)failureString{
    @try {
        
        //added by Srinivasulu on 13/04/2017....
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        [self displayAlertMessage:failureString horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:y_axis  msgType:@""  conentWidth:350 contentHeight:70  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

#pragma mark - Get Deals And Offers Service Reposnse Delegates

/**
 * @description  Here we are handling the success response received from service....
 * @date         17/09/2018
 * @method       getDealsAndOffersSuccessResponse
 * @author       Roja
 * @param        NSDictionary
 * @param
 * @return       void
 * @verified By
 * @verified On
 */

- (void)getDealsAndOffersSuccessResponse:(NSDictionary *)successDictionary {
    
    @try{
        
        dealOffersDic = [[NSMutableDictionary alloc]init];
        
        [dealOffersDic setValue:[successDictionary valueForKey:APPLIED_DEAL_ID_LIST] forKey:APPLIED_DEAL_ID_LIST];
        [dealOffersDic setValue:[successDictionary valueForKey:DEAL_DISCOUNT] forKey:DEAL_DISCOUNT];
        [dealOffersDic setValue:[successDictionary valueForKey:mPRODUCT_OFFER_PRICE] forKey:mPRODUCT_OFFER_PRICE];
        [dealOffersDic setValue:[successDictionary valueForKey:TURN_OVER_OFFER_DISCOUNT] forKey:TURN_OVER_OFFER_DISCOUNT];
        [dealOffersDic setValue:[successDictionary valueForKey:DISCOUNT_ID_ARRAY_LIST] forKey:DISCOUNT_ID_ARRAY_LIST];
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception.name);
    }
    @finally {
        
        [self calculateTotal];
        [HUD setHidden:YES];
    }
}


/**
 * @description  Here we are handling the error response received from service....
 * @date         17/09/2018
 * @method       getDealsAndOffersErrorResponse
 * @author       Roja
 * @param
 * @param
 * @return       void
 * @verified By
 * @verified On
 */

- (void)getDealsAndOffersErrorResponse {
    
    [self calculateTotal];
    [HUD setHidden:YES];
    
}
#pragma -mark methods used for multiple times....
/**
 * @description  here we are calculating the Totalprice for items in the cart..........
 * @date         12-09-2018...
 *
 * @method       calculateTotal
 * @author       Roja
 * @param
 * @param
 * @return       void
 * @verified By
 * @verified On           [self goToBottom];
 *
 */

-(void)calculateTotal {
    
    float totalCost      = 0;
    float subTotalAmount = 0;
    float amountDue      = 0;
    float amountPaid     = 0;
    float totItemDiscountVal = 0;
    float subTotBeforeDiscount = 0;
    totalCostBeforeDisc = 0;
    
    //    otherDiscAmountTxt.userInteractionEnabled  = YES;
    //    otherDiscPercentageTxt.userInteractionEnabled  = YES;
    @try {
        
        float calculatedTaxValue = 0;
        
        for(int i=0; i< [cartItemDetails count]; i++) {
            
            NSMutableDictionary * orderItemListDic = [[cartItemDetails objectAtIndex:i] mutableCopy];
            
            float dealOfferAmount = 0;
            float rangeCheckPrice = 0;
            float itemDiscValue  = 0;
            
            
            NSString * discountTypeStr = @"";
            NSString * discountIdStr = @"";
            
            if (dealOffersDic != nil) {
                
                if ([[[dealOffersDic valueForKey:DEAL_DISCOUNT] objectAtIndex:i] floatValue] > 0) {
                    
                    dealOfferAmount = [[[dealOffersDic valueForKey:DEAL_DISCOUNT] objectAtIndex:i]floatValue];
                    discountTypeStr = NSLocalizedString(@"deal", nil);
                    discountIdStr =[[dealOffersDic valueForKey:APPLIED_DEAL_ID_LIST] objectAtIndex:i];
                }
                
                if([[[dealOffersDic valueForKey:mPRODUCT_OFFER_PRICE] objectAtIndex:i] floatValue] > 0){
                    
                    dealOfferAmount += [[[dealOffersDic valueForKey:mPRODUCT_OFFER_PRICE] objectAtIndex:i]floatValue];
                    discountTypeStr = NSLocalizedString(@"offer", nil);
                    discountIdStr =[[dealOffersDic valueForKey:DISCOUNT_ID_ARRAY_LIST] objectAtIndex:i];
                }
            }
            
            if (otherDiscPercentageValue > 0){
                
                itemDiscValue = (([[orderItemListDic valueForKey:SALE_PRICE]floatValue] * otherDiscPercentageValue)/100);
            }
            // ITEM_SPECIAL_DISCOUNT is the value of other discounts ...
            [orderItemListDic setValue:[NSString stringWithFormat:@"%.2f",itemDiscValue * [[orderItemListDic valueForKey:ORDERED_QUANTITY] floatValue] ] forKey:ITEM_SPECIAL_DISCOUNT];
            
            totItemDiscountVal += [[orderItemListDic valueForKey:ITEM_SPECIAL_DISCOUNT]floatValue];
            
            rangeCheckPrice = [[orderItemListDic valueForKey:SALE_PRICE] floatValue];
            
            float itemTotalPrice =  [[orderItemListDic valueForKey:SALE_PRICE] floatValue] * [[orderItemListDic valueForKey:ORDERED_QUANTITY] floatValue] - (dealOfferAmount + [[orderItemListDic valueForKey:ITEM_SPECIAL_DISCOUNT] floatValue]);
            
            [orderItemListDic setValue:[NSString stringWithFormat:@"%.2f",(itemTotalPrice / [[orderItemListDic valueForKey:ORDERED_QUANTITY] floatValue])] forKey:SALE_PRICE_AFTER_DISCOUNT];
            
            if ([[orderItemListDic valueForKey:TAXATION_ON_DISCOUNT_PRICE]boolValue]) {
                
                rangeCheckPrice = [[orderItemListDic valueForKey:SALE_PRICE_AFTER_DISCOUNT] floatValue];
            }
            
            [orderItemListDic setValue:[NSString stringWithFormat:@"%.2f",itemTotalPrice] forKey:ITEM_TOTAL_COST];
            [orderItemListDic setValue:[NSString stringWithFormat:@"%.2f",itemTotalPrice] forKey:TOTAL];
            
            bool isInclusiveType = ![[orderItemListDic valueForKey:kItemTaxExclusive] boolValue];
            
            if((discCalcOn.length > 0 && [discCalcOn caseInsensitiveCompare:ORIGINAL_PRICE] == NSOrderedSame)){
                
                itemTotalPrice =  ( [[orderItemListDic valueForKey:SALE_PRICE] floatValue] * [[orderItemListDic valueForKey:ORDERED_QUANTITY] floatValue] );
            }
            else if(dealOfferAmount > 0){
                
                if (discTaxation.length > 0 && [discTaxation caseInsensitiveCompare:INCLUSIVE] == NSOrderedSame)
                    isInclusiveType = true;
                else if (discTaxation.length > 0 && [discTaxation caseInsensitiveCompare:EXCLUSIVE] == NSOrderedSame)
                    isInclusiveType = false;
            }
            
            if(otherDiscPercentageValue < 100){
                
                [self calculateItemTax:orderItemListDic totalPrice:itemTotalPrice rangeCheckAmount:rangeCheckPrice taxType:isInclusiveType];
            }
            
            [orderItemListDic setValue:[NSString stringWithFormat:@"%.2f",(( [[orderItemListDic valueForKey:SALE_PRICE] floatValue] * [[orderItemListDic valueForKey:ORDERED_QUANTITY] floatValue] ) - dealOfferAmount)] forKey:ITEM_COST_BEFORE_OTHER_DISCOUNT];
            
            subTotBeforeDiscount += ([[orderItemListDic valueForKey:ITEM_COST_BEFORE_OTHER_DISCOUNT] floatValue] - [[orderItemListDic valueForKey:TAX_VALUE] floatValue]);
            
            subTotalAmount += ([[orderItemListDic valueForKey:ITEM_TOTAL_COST] floatValue] - [[orderItemListDic valueForKey:TAX_VALUE] floatValue]);
            
            calculatedTaxValue += [[orderItemListDic valueForKey:TAX_VALUE]floatValue];
            
            [orderItemListDic setValue:discountTypeStr forKey:DISCOUNT_TYPE];
            [orderItemListDic setValue:discountIdStr forKey:DISCOUNT_ID];
            [orderItemListDic setValue:[NSString stringWithFormat:@"%.2f", dealOfferAmount] forKey:DISCOUNT_PRICE];
            [orderItemListDic setValue:[NSString stringWithFormat:@"%.2f", dealOfferAmount] forKey:DISCOUNT];
            [cartItemDetails replaceObjectAtIndex:i withObject:orderItemListDic];
        }
        
        totalCostBeforeDisc = subTotBeforeDiscount + calculatedTaxValue ;
        
        totalCost =  subTotalAmount + calculatedTaxValue;
        amountDue = (totalCost - amountPaid);
        
        billAmtValLbl.text = [NSString stringWithFormat:@"%.2f", subTotalAmount];
        taxValLbl.text = [NSString stringWithFormat:@"%.2f", calculatedTaxValue];
        taxTxt.text = [NSString stringWithFormat:@"%.2f", calculatedTaxValue];
        discountValLbl.text = [NSString stringWithFormat:@"%.2f", totItemDiscountVal];
        netPayValLbl.text = [NSString stringWithFormat:@"%.2f", totalCost];
    }
    @catch(NSException * exception) {
        
    }
    @finally {
        
        if(reloadTableData)
            [itemsTbl reloadData];
        [HUD setHidden:YES];
    }
}

/**
 * @description  here we are calculating the tax
 * @date         11/09/2018
 * @method       calculateItemTax:-- totalPrice:-- rangeCheckAmount:-- taxType:--
 * @author       Roja
 * @param        NSMutableDictionary
 * @param        float
 * @param        float
 * @param        Boolean
 *
 * @return       void
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)calculateItemTax:(NSMutableDictionary *)itemDetailsDic totalPrice:(float)itemTotalCost rangeCheckAmount:(float)rangeCheckPrice taxType:(Boolean)isTaxInclusive{
    
    float totalTaxRateValue = 0;
    float taxValue = 0;
    NSString *taxCodeStr = @"";
    NSMutableArray * taxDispalyArr;
    taxDispalyArr = [[NSMutableArray alloc]init];
    
    @try{
        
        for (NSDictionary * taxdic in [itemDetailsDic valueForKey:TAX]) {
            
            float specifiedTaxValue = 0;
            float taxRateValue = [[taxdic valueForKey:TAX_RATE]floatValue];
            
            taxCodeStr = [taxdic valueForKey: TAX_CODE];
            
            for (NSDictionary * saleRangeListDic in [taxdic valueForKey:SALE_RANGES_LIST]) {
                
                if ( ([[saleRangeListDic valueForKey:SALE_VALUE_FROM]floatValue] <= rangeCheckPrice) && (rangeCheckPrice <= [[saleRangeListDic valueForKey:SALE_VALUE_TO]floatValue]) ) {
                    
                    taxRateValue = [[saleRangeListDic valueForKey:TAX_RATE] floatValue];
                    break;
                }
            }
            
            if ([[taxdic valueForKey:TAX_TYPE] caseInsensitiveCompare:Percentage] == NSOrderedSame) {
                
                if (isTaxInclusive) {
                    
                    specifiedTaxValue = ( itemTotalCost - (itemTotalCost / (100 + taxRateValue * 2) * 100 ) ) / 2;
                }
                else{
                    
                    specifiedTaxValue = (itemTotalCost * taxRateValue)/100;
                    
                    float itemTotalPrice = [[itemDetailsDic valueForKey:ITEM_TOTAL_COST] floatValue];
                    itemTotalPrice+= ((itemTotalCost * taxRateValue)/100);
                    [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",itemTotalPrice] forKey:ITEM_TOTAL_COST];
                }
            }
            else{
                
                specifiedTaxValue = (taxRateValue * [[itemDetailsDic valueForKey:ORDERED_QUANTITY]floatValue]);
            }
            
            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",specifiedTaxValue] forKey:taxCodeStr];
            taxValue += specifiedTaxValue;
            totalTaxRateValue += taxRateValue;
        }
        
        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",totalTaxRateValue] forKey:TAX_RATE];
        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",taxValue] forKey:TAX_VALUE];
        
    }
    @catch(NSException * exception){
        NSLog(@"%@",exception.name);
    }
    @finally{
        
    }
}

/**
 * @description  adding the  alertMessage's based on input
 * @date         23/01/2019
 * @method       displayAlertMessage
 * @author       Srinivasulu
 * @param        NSString
 * @param        float
 * @param        float
 * @param        NSString
 * @param        float
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)displayAlertMessage:(NSString *)message    horizontialAxis:(float)xPostion  verticalAxis:(float)yPosition msgType:(NSString *)messageType   conentWidth:(float )labelWidth contentHeight:(float)labelHeight   isSoundRequired:(BOOL)soundStatus  timming:(float)noOfSecondsToDisplay    noOfLines:(int)noOfLines {
    
    
    @try {
        AudioServicesPlayAlertSound(soundFileObject);
        
        if ([userAlertMessageLbl isDescendantOfView:self.view] ) {
            [userAlertMessageLbl removeFromSuperview];
            
        }
        
        userAlertMessageLbl = [[UILabel alloc] init];
        userAlertMessageLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        userAlertMessageLbl.backgroundColor = [UIColor groupTableViewBackgroundColor];
        userAlertMessageLbl.layer.cornerRadius = 5.0f;
        userAlertMessageLbl.text =  message;
        userAlertMessageLbl.textAlignment = NSTextAlignmentCenter;
        userAlertMessageLbl.numberOfLines = noOfLines;
        
        userAlertMessageLbl.tag = 2;
        
        if ([messageType caseInsensitiveCompare:@"SUCCESS"] == NSOrderedSame || [messageType isEqualToString:@"CART_RECORDS"]) {
            
            if([messageType isEqualToString:@"CART_RECORDS"]) {
                
                userAlertMessageLbl.tag = 2;
            }
            else
                
                userAlertMessageLbl.tag = 4;
            
            userAlertMessageLbl.textColor = [UIColor blackColor];
            
            if(soundStatus){
                
                SystemSoundID    soundFileObject1;
                NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
                self.soundFileURLRef = (__bridge CFURLRef) tapSound;
                AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                AudioServicesPlaySystemSound (soundFileObject1);
            }
        }
        else{
            
            userAlertMessageLbl.textColor = [UIColor blackColor];
            
            if(soundStatus){
                SystemSoundID    soundFileObject1;
                NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
                self.soundFileURLRef = (__bridge CFURLRef) tapSound;
                AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                AudioServicesPlaySystemSound (soundFileObject1);
            }
        }
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            
            userAlertMessageLbl.frame = CGRectMake(xPostion, yPosition, labelWidth, labelHeight);
            
        }
        else{
        }
        
        [self.view addSubview:userAlertMessageLbl];
        fadeOutTime = [NSTimer scheduledTimerWithTimeInterval:noOfSecondsToDisplay target:self selector:@selector(removeAlertMessages) userInfo:nil repeats:NO];
        
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        
        NSLog(@"--------exception in the stockReceiptView in displayAlertMessage---------%@",exception);
        NSLog(@"----exception while creating the useralertMesssageLbl------------%@",exception);
    }
}

/**
 * @description  removing alertMessage add in the  disPlayAlertMessage method
 * @date         23/01/2019
 * @method       removeAletMessages
 * @author
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)removeAlertMessages{
    @try {
        
        if(userAlertMessageLbl.tag == 4){
            
            [self backAction];
            
        }
        
        else if ([userAlertMessageLbl isDescendantOfView:self.view])
            [userAlertMessageLbl removeFromSuperview];
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        
        NSLog(@"--------exception in the customerWalOut in removeAlertMessages---------%@",exception);
        NSLog(@"----exception in removing userAlertMessageLbl label------------%@",exception);
    }
}

/**
 * @description  here we are checking whether the object is null or not
 * @date         21/03/2018..
 * @method       checkGivenValueIsNullOrNil
 * @author       Bhargav.v
 * @param        NSString
 * @param        id
 * @return       id
 * @verified By
 * @verified On
 *
 */

- (id)checkGivenValueIsNullOrNil:(id)inputValue defaultReturn:(NSString *)returnStirng{
    
    
    @try {
        if ([inputValue isKindOfClass:[NSNull class]] || inputValue == nil) {
            return returnStirng;
        }
        else {
            return inputValue;
        }
    } @catch (NSException *exception) {
        return @"--";
    }
}

#pragma -mark methods used for menu handling..

- (IBAction)displayNewProductMenu:(id)sender {
    
    AudioServicesPlaySystemSound(soundFileObject);

    // Alert added by roja
    if(![tableNoTxt.text length] && ![mobileNoTxt.text length]){
        
        float y_axis = self.view.frame.size.height/2;
        NSString * msg = @"Select any table for adding items";
        [self displayAlertMessage:msg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:70  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        //@"To add items you need to select any occupied table"
    }
    else{
        
        @try {
            if(menuCategoriesDic == nil){
                
                if(!isOfflineService){
                    
                    [self callMenuDetails];
                    return;
                }
                else{
                    OfflineBillingServices * offline;
                    if(offline == nil)
                        offline = [[OfflineBillingServices alloc]init];
                    menuCategoriesDic =[offline getProductMenuDetailsFromfflineDB];
                }
            }
            
            BOOL isMenuDetailsExist = false;
            
            if(menuCategoriesDic.allKeys.count)
                if([[menuCategoriesDic valueForKey:CATEGORY_NAMES] count] <= 1){
                    
                    isMenuDetailsExist = true;
                }
            
            if(!menuCategoriesDic.allKeys.count)
                isMenuDetailsExist = true;
            
            
            if(isMenuDetailsExist){
                float y_axis = self.view.frame.size.height - 120;
                
                y_axis = productMenuBtn.frame.origin.y + productMenuBtn.frame.size.height;
                
                NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"product_menu_details_does_not_exists", nil)];
                
                [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:550 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
                return;
            }
            
            PopOverViewController  * productMenu = [[PopOverViewController alloc] init];
            
            UIView * showProductMenuView = [[UIView alloc] initWithFrame:CGRectMake( productMenuBtn.frame.origin.x, productMenuBtn.frame.origin.y, self.view.frame.size.width/1.4, self.view.frame.size.height - (productMenuBtn.frame.origin.y + 100))];
            showProductMenuView.opaque = NO;
            showProductMenuView.backgroundColor = [UIColor blackColor];
            showProductMenuView.layer.borderColor = [UIColor whiteColor].CGColor;
            showProductMenuView.layer.borderWidth = 1.0f;
            
            UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
            layout.sectionInset = UIEdgeInsetsMake( 5, 5, 5, 5);
            layout.itemSize = CGSizeMake(50, 50);
            layout.minimumInteritemSpacing = 1.0;
            layout.minimumLineSpacing = 1.0;
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            
            menuCategoriesView = [[UICollectionView alloc] initWithFrame:CGRectMake( 0, 0, showProductMenuView.frame.size.width, 120) collectionViewLayout:layout];
            menuCategoriesView.dataSource = self;
            menuCategoriesView.delegate = self;
            [menuCategoriesView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"menu_categories_cell"];
            menuCategoriesView.backgroundColor = [UIColor clearColor];
            menuCategoriesView.pagingEnabled = YES;
            menuCategoriesView.tag = 0;
            menuCategoriesView.userInteractionEnabled = YES;
            //        menuCategoriesView.auto
            
            UICollectionViewFlowLayout * menuCategoriesItemslayout = [[UICollectionViewFlowLayout alloc] init];
            menuCategoriesItemslayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
            //        menuCategoriesItemslayout.itemSize = CGSizeMake(50, 50);
            menuCategoriesItemslayout.minimumInteritemSpacing = 0.0;
            menuCategoriesItemslayout.minimumLineSpacing = 0.0;
            
            
            menuCategoriesItemsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, showProductMenuView.frame.size.width, showProductMenuView.frame.size.height) collectionViewLayout:menuCategoriesItemslayout];
            menuCategoriesItemsCollectionView.dataSource = self;
            menuCategoriesItemsCollectionView.delegate = self;
            [menuCategoriesItemsCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"menu_categories_item_cell"];
            menuCategoriesItemsCollectionView.backgroundColor = [UIColor blackColor];
            menuCategoriesItemsCollectionView.userInteractionEnabled = YES;
            
            
            productMenu.automaticallyAdjustsScrollViewInsets = false;
            
            // sub view frames:
            UILabel * blueBackGroundLbl = [[UILabel alloc] init];
            //        blueBackGroundLbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gradient.png"]];
            blueBackGroundLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
            //        blueBackGroundLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:24.0f];
            //        blueBackGroundLbl.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
            blueBackGroundLbl.textAlignment = NSTextAlignmentCenter;
            
            CALayer * bottomBorder = [CALayer layer];
            
            bottomBorder.frame = CGRectMake(0.0f, 60.0f, showProductMenuView.frame.size.width, 1.0f);
            bottomBorder.backgroundColor = [UIColor whiteColor].CGColor;
            bottomBorder.opacity = 5.0f;
            [blueBackGroundLbl.layer addSublayer:bottomBorder];
            
            [showProductMenuView addSubview:blueBackGroundLbl];
            [showProductMenuView addSubview:menuCategoriesView];
            [showProductMenuView addSubview:menuCategoriesItemsCollectionView];
            
            blueBackGroundLbl.frame = CGRectMake(0, 0, showProductMenuView.frame.size.width, 50);
            bottomBorder.frame = CGRectMake( 0, blueBackGroundLbl.frame.size.height - 2, blueBackGroundLbl.frame.size.width, 2);
            
            menuCategoriesView.frame = CGRectMake( blueBackGroundLbl.frame.origin.x, blueBackGroundLbl.frame.origin.y, blueBackGroundLbl.frame.size.width - 75, blueBackGroundLbl.frame.size.height);
            
            menuCategoriesItemsCollectionView.frame = CGRectMake(0, blueBackGroundLbl.frame.size.height, showProductMenuView.frame.size.width, showProductMenuView.frame.size.height - blueBackGroundLbl.frame.size.height);
            
            showProductMenuView.clipsToBounds = NO;
            showProductMenuView.layer.cornerRadius = 0.0;
            
            productMenu.view = showProductMenuView;
            
            productMenu.view.clipsToBounds = NO;
            productMenu.view.layer.cornerRadius = 0.0;
            
//            if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            
                productMenu.preferredContentSize =  CGSizeMake(showProductMenuView.frame.size.width, showProductMenuView.frame.size.height);
                
                UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:productMenu];
                
                [popover presentPopoverFromRect:productMenuBtn.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
                
                productmenuInfoPopUp = popover;
                
//            }
//
//            else {
//
//            }
            
        } @catch (NSException *exception) {
            
        }
    }
}

-(void)callMenuDetails{
    
    @try {
        
        [HUD setHidden:NO];
        [HUD setLabelText:NSLocalizedString(@"getting_menu_details",nil)];
        
        menuCategoriesDic = [NSMutableDictionary new];
        
        NSMutableDictionary * menuDeatilsRequestDic = [[NSMutableDictionary alloc]init];
        
        [menuDeatilsRequestDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [menuDeatilsRequestDic setValue:presentLocation forKey:OUTLET_NAME];
        [menuDeatilsRequestDic setValue:presentLocation forKey:OUTLET_LOCATION];
        [menuDeatilsRequestDic setValue:ZERO_CONSTANT forKey:START_INDEX];
        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:menuDeatilsRequestDic options:0 error:&err];
        NSString * customerPurchasesRequestString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * serviceController = [WebServiceController new];
        serviceController.menuServiceDelegate = self;
        [serviceController getMenuDetailsInfo:customerPurchasesRequestString];
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
    }
}

-(void)callMenuCategoriesDetailsInfo:(NSString *)menuNameStr{
    
    @try {
        
        [HUD setHidden:NO];
        [HUD setLabelText:NSLocalizedString(@"getting_menu_details",nil)];
        
        menuCategoriesDic = [NSMutableDictionary new];
        
        NSMutableDictionary * menuDeatilsRequestDic = [[NSMutableDictionary alloc]init];
        
        [menuDeatilsRequestDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [menuDeatilsRequestDic setValue:presentLocation forKey:OUTLET_NAME];
        [menuDeatilsRequestDic setValue:presentLocation forKey:OUTLET_LOCATION];
        [menuDeatilsRequestDic setValue:menuNameStr forKey:MENU_NAME];
        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:menuDeatilsRequestDic options:0 error:&err];
        NSString * customerPurchasesRequestString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * serviceController = [WebServiceController new];
        serviceController.menuServiceDelegate = self;
        [serviceController getMenuCategoryDetailsInfo:customerPurchasesRequestString];
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
    }
}

-(void)getMenuDetailsSuccessResponse:(NSDictionary *)successDictionary{
    @try {
        
        NSMutableArray * menuNamesArr = [NSMutableArray new];
        
        for(NSDictionary * dic in [successDictionary valueForKey:MENU_CATEGORIES]){
            
            [menuNamesArr addObject:[dic valueForKey:MENU_NAME]];
        }
        if(menuNamesArr.count){
            
            //            [menuCategoriesDic setValue:menuNamesArr forKey:MENU_NAME];
            //            for(NSString * str in menuNamesArr)
            //                [self callMenuCategoriesDetailsInfo:str];
            [self callMenuCategoriesDetailsInfo:menuNamesArr[0]];
        }
        else{
            [HUD setHidden:YES];
            [self displayNewProductMenu:nil];
        }
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
    } @finally {
        
    }
}
-(void)getMenuDeatilsErrorResponse:(NSString *)errorResponse{
    @try {
        
        float y_axis = self.view.frame.size.height - 120;
        
        y_axis = productMenuBtn.frame.origin.y + productMenuBtn.frame.size.height;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
    }
}

-(void)getMenuCategoryDetailsSuccessResponse:(NSDictionary *)successDictionary{
    @try {
        
        NSMutableArray * categoriesNamesArr = [NSMutableArray new];
        
        [categoriesNamesArr addObject:ALL];
        
        for(NSDictionary * dic in [successDictionary valueForKey:MENU_CATEGORY_DETAILS]){
            
            [categoriesNamesArr addObject:[dic valueForKey:CATEGORY_NAME]];
            
            NSMutableArray * itemNamesArr = [NSMutableArray new];
            for(NSDictionary * locDic in [dic valueForKey:MENU_ITEMS_LIST]){
                
                [itemNamesArr addObject:locDic];
            }
            [menuCategoriesDic setValue:itemNamesArr forKey:[dic valueForKey:CATEGORY_NAME]];
        }
        
        [menuCategoriesDic setValue:categoriesNamesArr forKey:CATEGORY_NAMES];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [self displayNewProductMenu:nil];
        [HUD setHidden:YES];
    }
}
-(void)getMenuCategoryDeatilsErrorResponse:(NSString *)errorResponse{
    @try {
        
        float y_axis = self.view.frame.size.height - 120;
        
        y_axis = productMenuBtn.frame.origin.y + productMenuBtn.frame.size.height;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
    }
}

//isOrderUpdateCall


-(void)callingOutletOrderIdDetails {
    
    @try {
        
        [HUD setHidden:NO];
        HUD.labelText = @"Please wait..";
        isToCallUpdate = false;
        cartItemDetails = [[NSMutableArray alloc]init];
        
        NSMutableDictionary * orderDetailsDic = [[NSMutableDictionary alloc]init];
        
        [orderDetailsDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        
        [orderDetailsDic setValue:presentLocation forKey:kLocation];
        
        [orderDetailsDic setValue:ZERO_CONSTANT forKey:START_INDEX];
        
        [orderDetailsDic setValue:orderRef forKey:ORDER_ID];
        
        //--istablebooking--
        // [orderDetailsDic setValue:orderChanneLString forKey:ORDER_CHANNEL];
        
        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:orderDetailsDic options:0 error:&err];
        NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * serviceController = [WebServiceController new];
        serviceController.outletOrderServiceDelegate = self;
        [serviceController getOutleOrderDetails:salesReportJsonString];
    }
    @catch (NSException *exception) {
        
        [HUD setHidden:YES];
    }
}

-(void)getOutletOrderDetailsSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        [HUD setHidden:YES];
        
        mutOrderDetailsDic = [successDictionary mutableCopy];
        
        NSArray * orderItems = successDictionary[kItemDetails];
        
        for (int i = 0; i < orderItems.count; i++) {
            
            NSDictionary * orderItemDic = orderItems[i];
            
            NSMutableDictionary * orderItemDetailsDic = [[NSMutableDictionary alloc] init];
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:kBrand] defaultReturn:@""] forKey:kBrand];
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:COLOUR] defaultReturn:@""] forKey:COLOUR];
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic valueForKey:kItemDept] defaultReturn:@""] forKey:kItemDept];
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic valueForKey:EAN] defaultReturn:@""] forKey:EAN];
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic valueForKey:ITEM_SCAN_CODE] defaultReturn:@""] forKey:ITEM_SCAN_CODE];
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:ITEM_SKU] defaultReturn:@""] forKey:iTEM_ID];
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:ITEM_NAME] defaultReturn:@""] forKey:ITEM_NAME];
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:MAKE] defaultReturn:@""] forKey:MAKE];
            
            [orderItemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:MANUAL_DISCOUNT] defaultReturn:@"0.00"] floatValue]] forKey:MANUAL_DISCOUNT];
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic valueForKey:kIsManuFacturedItem] defaultReturn:ZERO_CONSTANT] forKey:kIsManuFacturedItem];
            
            [orderItemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:MAX_QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:MAX_QUANTITY];
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic valueForKey:kMeasureRange] defaultReturn:@""] forKey:kMeasureRange];
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
            
            [orderItemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:MAX_RETAIL_PRICE] defaultReturn:@"0.00"] floatValue]] forKey:MAX_RETAIL_PRICE];
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:ORDER_ITEM_ID] defaultReturn:@""] forKey:ORDER_ITEM_ID];
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:ORDER_REF] defaultReturn:@""] forKey:ORDER_REF];
            
            [orderItemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:ORDERED_QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:ORDERED_QUANTITY];
            [orderItemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:ORDERED_QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:QUANTITY];

            
            [orderItemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:OTHER_TAX_RATE] defaultReturn:@"0.00"] floatValue]] forKey:OTHER_TAX_RATE];
            
            [orderItemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:OTHER_TAX_VALUE] defaultReturn:@"0.00"] floatValue]] forKey:OTHER_TAX_VALUE];
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic valueForKey:kPackagedType] defaultReturn:ZERO_CONSTANT] forKey:kPackagedType]; //packed
            
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:PRODUCT_CLASS] defaultReturn:@""] forKey:PRODUCT_CLASS];
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
            
            [orderItemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:SALE_PRICE] defaultReturn:@"0.00"] floatValue]] forKey:SALE_PRICE];
            
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:SECTION] defaultReturn:@""] forKey:SECTION];
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
            
//            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:STATUS] defaultReturn:@"ordered"] forKey:STATUS];
            
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:STATUS] defaultReturn:@"Draft"] forKey:STATUS];

            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_SKU];
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:STYLE] defaultReturn:@""] forKey:STYLE];
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:SUB_CLASS] defaultReturn:@""] forKey:SUB_CLASS];
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:kItemSubDept] defaultReturn:@""] forKey:kItemSubDept];
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic valueForKey:TAX_CODE] defaultReturn:@""] forKey:TAX_CODE]; // taxCode = No;
            
            [orderItemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:TAX_RATE] defaultReturn:@"0.00"] floatValue]] forKey:TAX_RATE];
            
            [orderItemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:TAX_VALUE] defaultReturn:@"0.00"] floatValue]] forKey:TAX_VALUE];
            
            
            [orderItemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:TAXX_VALUE] defaultReturn:@"0.00"] floatValue]] forKey:TAXX_VALUE];
            
            
            [orderItemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:ITEM_TOTAL_COST] defaultReturn:@"0.00"] floatValue]] forKey:ITEM_TOTAL_COST]; //item_price * qty
            
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic valueForKey:UOM] defaultReturn:@""] forKey:UOM];
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic valueForKey:UTILITY] defaultReturn:@""] forKey:UTILITY];
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic valueForKey:TRACKING_REQUIRED] defaultReturn:ZERO_CONSTANT] forKey:TRACKING_REQUIRED]; //trackingRequired
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic valueForKey:VOID_STATUS_FLAG] defaultReturn:ZERO_CONSTANT] forKey:VOID_STATUS_FLAG]; //voidStatusFlag
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic valueForKey:ZERO_STOCK_FLAG] defaultReturn:ZERO_CONSTANT] forKey:ZERO_STOCK_FLAG]; //zeroStockFlag
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic valueForKey:EDIT_PRICE_FLAG] defaultReturn:ZERO_CONSTANT] forKey:EDIT_PRICE_FLAG]; //editPriceFlag
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic valueForKey:EDIT_TABLE_FLAG] defaultReturn:ZERO_CONSTANT] forKey:EDIT_TABLE_FLAG]; //editableFlag
            
            [orderItemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:DISCOUNT] defaultReturn:@"0.00"] floatValue]] forKey:DISCOUNT];
            
            [orderItemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:DISCOUNT_ID] defaultReturn:@"0.00"] floatValue]] forKey:DISCOUNT_ID];
            
            [orderItemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:DISCOUNT_TYPE] defaultReturn:@"0.00"] floatValue]] forKey:DISCOUNT_TYPE];
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic valueForKey:ISGST_RATE] defaultReturn:@""] forKey:ISGST_RATE];
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic valueForKey:IS_GST_VALUE] defaultReturn:@""] forKey:IS_GST_VALUE];
            
            // added by roja on 21-09-2018...
            // forming Tax_Details_Array using successResponce....
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic valueForKey:kItemTaxExclusive] defaultReturn:ZERO_CONSTANT] forKey:kItemTaxExclusive];
            
            NSMutableArray * taxArr = [NSMutableArray new];
            for(NSDictionary *itemTaxDic in [mutOrderDetailsDic valueForKey:ORDER_ITEM_TAXES_LIST]){
                
                if( [[orderItemDetailsDic valueForKey:iTEM_ID] isEqualToString:[itemTaxDic valueForKey:SKU_ID]] && [[orderItemDetailsDic valueForKey:PLU_CODE] isEqualToString:[itemTaxDic valueForKey:Plu_Code_]] ){
                    
                    NSMutableDictionary *taxTempDic = [[NSMutableDictionary alloc]init];
                    [taxTempDic setValue:[itemTaxDic valueForKey:TAX_CATEGORY] forKey:TAX_CATEGORY];
                    [taxTempDic setValue:[itemTaxDic valueForKey:Tax_code] forKey:Tax_code];
                    [taxTempDic setValue:[itemTaxDic valueForKey:Tax_Type] forKey:Tax_Type];
                    [taxTempDic setValue:[itemTaxDic valueForKey:Tax_rate] forKey:Tax_rate];
                    
                    [taxArr addObject:taxTempDic];
                }
            }
            
            [orderItemDetailsDic setValue:taxArr forKey:TAX];
            
            
            //            float itemTotalPrice = [[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:Item_Price] defaultReturn:@"0.00"] floatValue] + [[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:MANUAL_DISCOUNT] defaultReturn:@"0.00"] floatValue];
            
            // Discount details ....
            for(NSDictionary *discountDic in [mutOrderDetailsDic valueForKey:ORDER_DISCOUNTS_LIST]){
                
                if( [[orderItemDetailsDic valueForKey:iTEM_ID] isEqualToString:[discountDic valueForKey:ITEM_SKU]] && [[orderItemDetailsDic valueForKey:PLU_CODE] isEqualToString:[discountDic valueForKey:PLU_CODE]] ){
                    
                    //                    itemTotalPrice = itemTotalPrice + [[discountDic valueForKey:DISCOUNT_PRICE]floatValue];
                    
                    //need to uncomment this....
                    //                    discountAmt += [[discountDic valueForKey:DISCOUNT_PRICE]floatValue];
                }
            }
            
            //need to uncomment this....
            //            actualCartTotalAmt += ([[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:SALE_PRICE] defaultReturn:@"0.00"]floatValue] * [[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:ORDERED_QUANTITY] defaultReturn:@"0.00"] floatValue]);
            
            
            //            itemTotalPrice = itemTotalPrice / [[orderItemDic  valueForKey:ORDERED_QUANTITY]floatValue];
            //            [orderItemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",itemTotalPrice] forKey:Item_Price];
            
            [orderItemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:SALE_PRICE] defaultReturn:@"0.00"] floatValue]] forKey:Item_Price];
            [orderItemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:SALE_PRICE] defaultReturn:@"0.00"] floatValue]] forKey:SALE_PRICE];
            
            [orderItemDetailsDic setValue:@0.0f forKey:SALE_PRICE_AFTER_DISCOUNT];
            [orderItemDetailsDic setValue:@0.0f forKey:ITEM_COST_BEFORE_OTHER_DISCOUNT];
            [orderItemDetailsDic setValue:@0.0f forKey:ITEM_SPECIAL_DISCOUNT];
            [orderItemDetailsDic setValue:[NSNumber numberWithBool:[self checkGivenValueIsNullOrNil:[orderItemDic valueForKey:EDITABLE] defaultReturn:ZERO_CONSTANT]] forKey:EDITABLE];
            
            [orderItemDetailsDic setValue:@0.0f forKey:CGST_RATE];
            [orderItemDetailsDic setValue:@0.0f forKey:CGST_VALUE];
            [orderItemDetailsDic setValue:@0.0f forKey:SGST_RATE];
            [orderItemDetailsDic setValue:@0.0f forKey:SGST_VALUE];
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic valueForKey:HSN_CODE] defaultReturn:@""] forKey:HSN_CODE];
            [orderItemDetailsDic setValue:@0.0f  forKey:TAXATION_ON_DISCOUNT_PRICE];
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:@"tastePattern"] defaultReturn:@""] forKey:@"tastePattern"]; //
            
            
            // upto here added by roja on 21-09-2018...
            
            [cartItemDetails addObject:orderItemDetailsDic];
        }
    }
    @catch(NSException * exception) {
        
    }
    @finally {
        
        isToCallUpdate = true;
        [self calculateTotal];//cartItemDetails
    }
}

-(void)getOutletOrderDetailsErrorResponse:(NSString *)errorResponse {
    
    @try {
        
        //        float y_axis = self.view.frame.size.height - 120;
        //
        //        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        //
        //        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
    } @catch (NSException *exception) {
        
    } @finally {
        isToCallUpdate = false;
        [self calculateTotal];
    }
}





-(void)callCreateOutletOrder:(int)updateStatusNumber{
    
    @try{
        [HUD show: YES];
        [HUD setHidden: NO];
        [HUD setLabelText:@"Placing Order.."];
        
        NSString * mobileNumberStr = [self checkGivenValueIsNullOrNil:[bookingDetails valueForKey:@"mobileNumber"] defaultReturn:@""];
        
        NSDate * today = [NSDate date];
        NSDateFormatter * f = [[NSDateFormatter alloc] init];
        [f setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        NSString* currentdate = [f stringFromDate:today];
        
        
        NSString * orderCreatedDateStr = currentdate;
        NSString * orderDeliveryDateStr = currentdate;
//        NSString * orderCreatedOnStr = currentdate;


        NSUserDefaults * custDefaults = [[NSUserDefaults alloc] init];
        
        NSString * defaultStreetStr = [self checkGivenValueIsNullOrNil:[custDefaults objectForKey:CUSTOMER_DEFAULT_AREA] defaultReturn:@""];
        NSString * defaultLandMarkStr = [self checkGivenValueIsNullOrNil:[custDefaults objectForKey:CUSTOMER_DEFAULT_LANDMARK] defaultReturn:@""];
        NSString * defaultCityStr = [self checkGivenValueIsNullOrNil:[custDefaults objectForKey:CUSTOMER_DEFAULT_CITY] defaultReturn:@""];
        NSString * defaultPinCodeStr = [self checkGivenValueIsNullOrNil:[custDefaults objectForKey:CUSTOMER_DEFAULT_PIN] defaultReturn:@""];
        
        NSMutableDictionary * createOrderDic = [[NSMutableDictionary alloc] init];
        
        //Order Details...
        createOrderDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        createOrderDic[Order_Date] = orderCreatedDateStr;
        createOrderDic[DELIVERY_DATE] = orderDeliveryDateStr;
//        createOrderDic[@"createdOn"] = orderCreatedOnStr;  // added by roja on 29/03/2019..
        createOrderDic[@"orderType"] = @"Table";
        createOrderDic[ORDER_ID] = orderRef;
        [createOrderDic setValue:[NSNumber numberWithBool:true] forKey:IS_TABLE_BOOKING];
        createOrderDic[@"tableNumber"] = tableNoTxt.text;

        createOrderDic[PAYMENT_TYPE] = @"";
        createOrderDic[PAYMENT_MODE] = @"";
        createOrderDic[SALE_LOCATION] = presentLocation;
        //        createOrderDic[EMAIL_ID] = customerEmailIdText.text;
        createOrderDic[MOBILE_NUM] = mobileNumberStr;
        createOrderDic[PAYMENT_REF] = @"";
        
        //Customer Address..
        createOrderDic[CUSTOMER_ADDRESS_STREET] = defaultStreetStr;
        createOrderDic[CUSTOMER_ADDRESS_LOCATION] = defaultLandMarkStr;
        createOrderDic[CUSTOMER_ADDRESS_CITY] = defaultCityStr;
        createOrderDic[CUSTOMER_ADDRESS_DOOR_NO] = @"";
        createOrderDic[CUSTOMER_CONTACT_NUM] = mobileNumberStr;
        createOrderDic[CUSTOMER_MAP_LINK] = @"";
        createOrderDic[customer_pinNo] = defaultPinCodeStr;
        
        //Billing Address...
        createOrderDic[BILLING_ADDRESS_STREET] = defaultStreetStr;
        createOrderDic[BILLING_ADDRESS_LOCATION] = defaultLandMarkStr;
        createOrderDic[BILLING_ADDRESS_CITY] = defaultCityStr;
        createOrderDic[BILLING_ADDRESS_DOOR_NO] = @"";
        createOrderDic[BILLING_CONTACT_NUM] = mobileNumberStr;
        createOrderDic[BILLING_MAP_LINK] = @"";
        createOrderDic[billing_pinNo] = defaultPinCodeStr;
        
        //Shipment Address...
        createOrderDic[SHIPMENT_CONTACT_NUM] = mobileNumberStr;
        createOrderDic[SHIPMENT_DOOR_NO] = @"";
        createOrderDic[SHIPMENT_STREET] = defaultStreetStr;
        createOrderDic[SHIPMENT_NAME] = [self checkGivenValueIsNullOrNil:[bookingDetails valueForKey:CUSTOMER_NAME] defaultReturn:@""];
        createOrderDic[SHIPMENT_LOCATION] = defaultLandMarkStr;
        createOrderDic[SHIPMENT_CITY] = defaultCityStr;
        createOrderDic[SHIPMENT_STATE] = defaultCityStr;
        
        //Other Details...
        
        if(bookingTypeStr == nil)
            bookingTypeStr = @"Telephone";
        
        createOrderDic[ORDER_CHANNEL] = bookingTypeStr;
        createOrderDic[SHIPPER_ID] = @"";
        createOrderDic[SALES_EXECUTIVE_ID] = @"";
        createOrderDic[SALES_EXECUTIVE_NAME] = @"";
        //createOrderDic[REFERRED_BY] = refferedByText.text;
        createOrderDic[ORDER_DELIVERY_TYPE] = @"";
        createOrderDic[kShipmentMode] = @"";
        
        //itemDetails
        
        NSString * orderStatusStr = ORDERED;
        
        if(updateStatusNumber == 2 && mutOrderDetailsDic != nil){
            
            if([[mutOrderDetailsDic allKeys] containsObject:ORDER])
                orderStatusStr =  [self checkGivenValueIsNullOrNil:[mutOrderDetailsDic[ORDER]  valueForKey:ORDER_STATUS] defaultReturn:@"Confirmed"];
            
            if([orderStatusStr caseInsensitiveCompare:ORDERED] == NSOrderedSame)
                orderStatusStr =  @"Confirmed";
        }
        else if(updateStatusNumber == 2){
            
            orderStatusStr =  @"Confirmed";
        }
        
        
        createOrderDic[ORDER_STATUS] = orderStatusStr;
        
        //Discount Level Calulations....
        //Appending it Statically temporarly....
        createOrderDic[SPECIAL_DISCOUNT] = @0.0f;
        createOrderDic[OTHER_TAX_AMT] = @0.0f;
        //        if(![otherDiscAmountTxt.text length])
        //            otherDiscAmountTxt.text = @"0.00";
        createOrderDic[OTHER_DISCOUNTS] = @"0.00";
        createOrderDic[IS_GST_AMOUNT] = @0.0f;
        
        createOrderDic[SUB_TOTAL] = billAmtValLbl.text;
        createOrderDic[ORDER_TOTAL_COST] = netPayValLbl.text;
        createOrderDic[TOTAL_ORDER_AMOUNT] = netPayValLbl.text;
        //        createOrderDic[BILL_DUE] = amountDueText.text;
//        createOrderDic[PAID_AMT] = @"0.00";
//        createOrderDic[kAllotedTableNo] = tableNoTxt.text;
        
        
        
//        NSMutableDictionary * ordersTablesDic =  [NSMutableDictionary new];
//
//        ordersTablesDic[ORDER_ID] = orderRef;
//        ordersTablesDic[ORDER_REF] = orderRef;
//        ordersTablesDic[LOCATION] = presentLocation;
//        ordersTablesDic[LEVEL] = @"1";
//        ordersTablesDic[kAllotedTableNo] = tableNoTxt.text;
//        ordersTablesDic[REMARKS] = @"";
//        ordersTablesDic[@"orderType"] = @"Table";
//
//        createOrderDic[kListOfTables] = [NSArray arrayWithObjects:ordersTablesDic, nil];
        
        //OrdersTables
        
        
        // item Dictionary....
        NSMutableArray * orderItemTaxesListArr = [[NSMutableArray alloc]init];
        NSMutableDictionary * orderItemTaxesListDic;
        
        NSMutableArray * orderDiscountsArr = [[NSMutableArray alloc]init];
        NSMutableDictionary * orderDiscountsDic;
        
        // added by roja on 14-09-2018...
        
        @try{
            for (int i=0; i< cartItemDetails.count; i++) {
                
                NSMutableDictionary *orderItemsDic = [[cartItemDetails objectAtIndex:i] mutableCopy];
                
                // setting Sale_price after discounts to Item_Price Key...
                [orderItemsDic setValue:[orderItemsDic valueForKey:SALE_PRICE_AFTER_DISCOUNT] forKey:Item_Price];
          
                if(updateStatusNumber == 2)
                    [orderItemsDic setValue:ORDERED forKey:STATUS];//@"Confirmed"

                [cartItemDetails replaceObjectAtIndex:i withObject:orderItemsDic];
                
                
                if ( !( [[orderItemsDic valueForKey:TAX] isKindOfClass:[NSNull class]] ) && [[orderItemsDic valueForKey:TAX] count] ) {
                    
                    for (NSDictionary *taxDic in [orderItemsDic valueForKey:TAX] ){
                        
                        orderItemTaxesListDic = [[NSMutableDictionary alloc] init];
                        [orderItemTaxesListDic setValue:[orderItemsDic valueForKey:ITEM_SKU] forKey:SKU_ID];
                        [orderItemTaxesListDic setValue:[orderItemsDic valueForKey:PLU_CODE] forKey:plu_code_];
                        [orderItemTaxesListDic setValue:[taxDic valueForKey:Tax_Category] forKey:TAX_CATEGORY];
                        [orderItemTaxesListDic setValue:[taxDic valueForKey:TAX_CODE] forKey:Tax_code];
                        [orderItemTaxesListDic setValue:[taxDic valueForKey:TAX_TYPE] forKey:Tax_Type];
                        [orderItemTaxesListDic setValue:[taxDic valueForKey:TAX_RATE] forKey:Tax_rate];
                        
                        [orderItemTaxesListDic setValue:[self checkGivenValueIsNullOrNil:[orderItemsDic valueForKey:[taxDic valueForKey:TAX_CODE]]  defaultReturn:@"0.00"] forKey:Tax_value];
                        
                        [orderItemTaxesListArr addObject:orderItemTaxesListDic];
                    }
                }else if([[orderItemsDic valueForKey:TAX] count] == 0){
                    
                    orderItemTaxesListDic = [[NSMutableDictionary alloc]init];
                    [orderItemTaxesListArr addObject:orderItemTaxesListDic];
                }
                
                if(dealOffersDic != nil && ([[orderItemsDic valueForKey:DISCOUNT_PRICE]floatValue] > 0) ){
                    
                    orderDiscountsDic = [[NSMutableDictionary alloc]init];
                    
                    [orderDiscountsDic setValue:[orderItemsDic valueForKey:DISCOUNT_TYPE] forKey:DISCOUNT_TYPE];
                    [orderDiscountsDic setValue:[orderItemsDic valueForKey:DISCOUNT_ID] forKey:DISCOUNT_ID];
                    [orderDiscountsDic setValue:[orderItemsDic valueForKey:DISCOUNT_PRICE] forKey:DISCOUNT_PRICE];
                    [orderDiscountsDic setValue:[orderItemsDic valueForKey:ITEM_SKU] forKey:ITEM_SKU];
                    [orderDiscountsDic setValue:[orderItemsDic valueForKey:SALE_PRICE] forKey:iTEM_PRICE];
                    [orderDiscountsDic setValue:[orderItemsDic valueForKey:PLU_CODE] forKey:PLU_CODE];
                    
                    [orderDiscountsArr addObject:orderDiscountsDic];
                }
                //                    else
                //                        [orderDiscountsArr addObject:orderDiscountsDic];
            }
        }
        @catch(NSException *exception){
            NSLog(@"exception while creating an order ----%@",exception);
        }
        
        NSMutableArray * orderTransactionArr = [[NSMutableArray alloc]init];
        NSMutableDictionary * orderTransactionDic = [[NSMutableDictionary alloc]init];
        
        [orderTransactionDic setValue:orderRef forKey:ORDER_ID];
        [orderTransactionDic setValue:@"0.00" forKey:PAID_AMT];
        [orderTransactionDic setValue:@"0.00" forKey:RECEIVED_AMOUNT];
        [orderTransactionDic setValue:@"" forKey:MODE_OF_PAY];
        [orderTransactionDic setValue:@"" forKey:PAYMENT_STATUS];
        [orderTransactionDic setValue:@"" forKey:CARD_TYPE];
        [orderTransactionDic setValue:@"" forKey:COUPON_NO];
        [orderTransactionDic setValue:@"" forKey:BANK_NAME];
        [orderTransactionDic setValue:@"" forKey:APPROVAL_CODE];
        [orderTransactionDic setValue:@"0" forKey:CHANGE_RETURN];
        [orderTransactionDic setValue:@"" forKey:CARD_INFO];
        [orderTransactionDic setValue:@"" forKey:DATE];
        
        [orderTransactionArr addObject:orderTransactionDic];
        
        createOrderDic[ORDER_DISCOUNTS_LIST] = orderDiscountsArr;
        createOrderDic[kItemDetails] = cartItemDetails;
        createOrderDic[ORDER_ITEM_TAXES_LIST] = orderItemTaxesListArr;
        createOrderDic[ORDER_TRANSACTIONS] = orderTransactionArr;
        
        [createOrderDic setValue:taxValLbl.text forKey:ORDER_TAX];
        [createOrderDic setValue:@"0.00" forKey:SHIPMENT_CHARGES];
        createOrderDic[ORDERED_ITEMSLIST] = cartItemDetails;
        
        createOrderDic[no_of_items] = [NSNumber numberWithInteger:cartItemDetails.count];
        // upto here changed by roja on 14-09-2018..
        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:createOrderDic options:0 error:&err];
        
        NSString * createOrderJsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"----%@",createOrderJsonStr);
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.outletOrderServiceDelegate = self;
        [webServiceController  createOutletOrder:createOrderJsonStr];
    }
    @catch(NSException * exception){
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        NSLog(@"-------exception will reading.-------%@",exception);
    }
}


-(void)createOutletOrderSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        isToCallUpdate = true;

        //    sucess = [[UIAlertView alloc] initWithTitle:@"Order Placed Successfully" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        //    [sucess show];
        
        float y_axis = self.view.frame.size.height - 120;
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"Order Placed Successfully",nil)];
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:@"CART_RECORDS" conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
    }
}

-(void)createOutletOrderErrorResponse:(NSString * )errorResponse{
    
    @try {
        
        float y_axis = self.view.frame.size.height - 170;
        [self displayAlertMessage:errorResponse horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:y_axis  msgType:@""  conentWidth:350 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
    }
   
}



-(void)callUpdateOutletOrder:(int)updateStatusNumber{
    
    @try{
//        [HUD show: YES];
        
        [HUD setHidden: NO];
        [HUD setLabelText: @"Placing Order.."];
        
        NSString * mobileNumberStr = [self checkGivenValueIsNullOrNil:[bookingDetails valueForKey:@"mobileNumber"] defaultReturn:@""];
        
        NSDate * today = [NSDate date];
        NSDateFormatter * f = [[NSDateFormatter alloc] init];
        [f setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        NSString* currentdate = [f stringFromDate:today];
        
        NSString * orderCreatedDateStr = currentdate;
        NSString * orderDeliveryDateStr = currentdate;
        
        
        orderCreatedDateStr = [self checkGivenValueIsNullOrNil:[mutOrderDetailsDic[ORDER]  valueForKey:Order_Date] defaultReturn:currentdate];
        orderDeliveryDateStr = [self checkGivenValueIsNullOrNil:[mutOrderDetailsDic[ORDER]  valueForKey:DELIVERY_DATE] defaultReturn:currentdate];
        
        
        NSUserDefaults * custDefaults = [[NSUserDefaults alloc] init];
        
        NSString * defaultStreetStr = [self checkGivenValueIsNullOrNil:[custDefaults objectForKey:CUSTOMER_DEFAULT_AREA] defaultReturn:@""];
        NSString * defaultLandMarkStr = [self checkGivenValueIsNullOrNil:[custDefaults objectForKey:CUSTOMER_DEFAULT_LANDMARK] defaultReturn:@""];
        NSString * defaultCityStr = [self checkGivenValueIsNullOrNil:[custDefaults objectForKey:CUSTOMER_DEFAULT_CITY] defaultReturn:@""];
        NSString * defaultPinCodeStr = [self checkGivenValueIsNullOrNil:[custDefaults objectForKey:CUSTOMER_DEFAULT_PIN] defaultReturn:@""];
        
        
        NSMutableDictionary * createOrderDic = [[NSMutableDictionary alloc] init];

        //Order Details...
        createOrderDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        createOrderDic[Order_Date] = orderCreatedDateStr;
        createOrderDic[DELIVERY_DATE] = orderDeliveryDateStr;
        createOrderDic[@"orderType"] = @"Table";

        createOrderDic[ORDER_ID] = orderRef;
        [createOrderDic setValue:[NSNumber numberWithBool:true] forKey:IS_TABLE_BOOKING];
        createOrderDic[@"tableNumber"] = tableNoTxt.text;

        createOrderDic[PAYMENT_TYPE] = @"";
        createOrderDic[PAYMENT_MODE] = @"";
        createOrderDic[SALE_LOCATION] = presentLocation;
        //        createOrderDic[EMAIL_ID] = customerEmailIdText.text;
        createOrderDic[MOBILE_NUM] = mobileNumberStr;
        createOrderDic[PAYMENT_REF] = @"";
        
        //Customer Address..
        createOrderDic[CUSTOMER_ADDRESS_STREET ] = defaultStreetStr;
        createOrderDic[CUSTOMER_ADDRESS_LOCATION] = defaultLandMarkStr;
        createOrderDic[CUSTOMER_ADDRESS_CITY] = defaultCityStr;
        createOrderDic[CUSTOMER_ADDRESS_DOOR_NO] = @"";
        createOrderDic[CUSTOMER_CONTACT_NUM] = mobileNumberStr;
        createOrderDic[CUSTOMER_MAP_LINK] = @"";
        createOrderDic[customer_pinNo] = defaultPinCodeStr;
        
        //Billing Address...
        createOrderDic[BILLING_ADDRESS_STREET] = defaultStreetStr;
        createOrderDic[BILLING_ADDRESS_LOCATION] = defaultLandMarkStr;
        createOrderDic[BILLING_ADDRESS_CITY] = defaultCityStr;
        createOrderDic[BILLING_ADDRESS_DOOR_NO] = @"";
        createOrderDic[BILLING_CONTACT_NUM] = mobileNumberStr;
        createOrderDic[BILLING_MAP_LINK] = @"";
        createOrderDic[billing_pinNo] = defaultPinCodeStr;
        
        //Shipment Address...
        createOrderDic[SHIPMENT_CONTACT_NUM] = mobileNumberStr;
        createOrderDic[SHIPMENT_DOOR_NO] = @"";
        createOrderDic[SHIPMENT_STREET] = defaultStreetStr;
        createOrderDic[SHIPMENT_NAME] = [self checkGivenValueIsNullOrNil:[bookingDetails valueForKey:CUSTOMER_NAME] defaultReturn:@""];
        createOrderDic[SHIPMENT_LOCATION] = defaultLandMarkStr;
        createOrderDic[SHIPMENT_CITY] = defaultCityStr;
        createOrderDic[SHIPMENT_STATE] = defaultCityStr;
        
        //Other Details...
        
        if(bookingTypeStr == nil)
            bookingTypeStr = @"Telephone";
        
        createOrderDic[ORDER_CHANNEL] = bookingTypeStr;
                createOrderDic[SHIPPER_ID] = @"";
                createOrderDic[SALES_EXECUTIVE_ID] = @"";
                createOrderDic[SALES_EXECUTIVE_NAME] = @"";
                //createOrderDic[REFERRED_BY] = refferedByText.text;
                createOrderDic[ORDER_DELIVERY_TYPE] = @"";
                createOrderDic[kShipmentMode] = @"";
        
        //itemDetails
        
        NSString * orderStatusStr = ORDERED;
        
        if(updateStatusNumber == 2 && mutOrderDetailsDic != nil){
            
            if([[mutOrderDetailsDic allKeys] containsObject:ORDER])
                orderStatusStr =  [self checkGivenValueIsNullOrNil:[mutOrderDetailsDic[ORDER]  valueForKey:ORDER_STATUS] defaultReturn:@"Confirmed"];
            
            if([orderStatusStr caseInsensitiveCompare:ORDERED] == NSOrderedSame)
                orderStatusStr =  @"Confirmed";
        }
        
        
        createOrderDic[ORDER_STATUS] = orderStatusStr;
//            createOrderDic[ORDER_STATUS] = ORDERED;
       
        
        //Discount Level Calulations....
        //Appending it Statically temporarly....
        createOrderDic[SPECIAL_DISCOUNT] = @0.0f;
        createOrderDic[OTHER_TAX_AMT] = @0.0f;
        //        if(![otherDiscAmountTxt.text length])
        //            otherDiscAmountTxt.text = @"0.00";
        createOrderDic[OTHER_DISCOUNTS] = @"0.00";
        createOrderDic[IS_GST_AMOUNT] = @0.0f;
        
        createOrderDic[SUB_TOTAL] = billAmtValLbl.text;
        createOrderDic[ORDER_TOTAL_COST] = netPayValLbl.text;
        createOrderDic[TOTAL_ORDER_AMOUNT] = netPayValLbl.text;
        //        createOrderDic[BILL_DUE] = amountDueText.text;
//        createOrderDic[PAID_AMT] = @"0.00";
//        createOrderDic[kAllotedTableNo] = tableNoTxt.text;
        

        
//        NSMutableDictionary * ordersTablesDic =  [NSMutableDictionary new];
//
//        ordersTablesDic[ORDER_ID] = orderRef;
//        ordersTablesDic[ORDER_REF] = orderRef;
//        ordersTablesDic[LOCATION] = presentLocation;
//        ordersTablesDic[LEVEL] = @"1";
//        ordersTablesDic[kAllotedTableNo] = tableNoTxt.text;
//        ordersTablesDic[REMARKS] = @"";
//        ordersTablesDic[@"orderType"] = @"Table";
//
//        createOrderDic[kListOfTables] = [NSArray arrayWithObjects:ordersTablesDic, nil];
        
        //OrdersTables
        
        
        // item Dictionary....
        NSMutableArray * orderItemTaxesListArr = [[NSMutableArray alloc]init];
        NSMutableDictionary * orderItemTaxesListDic;
        
        NSMutableArray * orderDiscountsArr = [[NSMutableArray alloc]init];
        NSMutableDictionary * orderDiscountsDic;
        
        // added by roja on 14-09-2018...
        
        @try{
            for (int i=0; i< cartItemDetails.count; i++) {
                
                NSMutableDictionary *orderItemsDic = [[cartItemDetails objectAtIndex:i] mutableCopy];
                
                // setting Sale_price after discounts to Item_Price Key...
                [orderItemsDic setValue:[orderItemsDic valueForKey:SALE_PRICE_AFTER_DISCOUNT] forKey:Item_Price];
                
                // added by roja on 23/03/2019...
                if((updateStatusNumber == 2) && [[orderItemsDic valueForKey:@"status"] caseInsensitiveCompare:@"Draft"] == NSOrderedSame){ //ORDERED
                    
                    [orderItemsDic setValue:ORDERED forKey:STATUS];//@"Confirmed"
                }
                else{
                    
                    [orderItemsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemsDic valueForKey:@"status"] defaultReturn:@"Draft"] forKey:STATUS]; //ORDERED
                }
                //Upto here added by roja on 23/03/2019...

//                if(updateStatusNumber == 2)
//                    [orderItemsDic setValue:@"Confirmed" forKey:STATUS];
                
                [cartItemDetails replaceObjectAtIndex:i withObject:orderItemsDic];
                
                
                if ( !( [[orderItemsDic valueForKey:TAX] isKindOfClass:[NSNull class]] ) && [[orderItemsDic valueForKey:TAX] count] ) {
                    
                    for (NSDictionary *taxDic in [orderItemsDic valueForKey:TAX] ){
                        
                        orderItemTaxesListDic = [[NSMutableDictionary alloc] init];
                        [orderItemTaxesListDic setValue:[orderItemsDic valueForKey:ITEM_SKU] forKey:SKU_ID];
                        [orderItemTaxesListDic setValue:[orderItemsDic valueForKey:PLU_CODE] forKey:plu_code_];
                        [orderItemTaxesListDic setValue:[taxDic valueForKey:Tax_Category] forKey:TAX_CATEGORY];
                        [orderItemTaxesListDic setValue:[taxDic valueForKey:TAX_CODE] forKey:Tax_code];
                        [orderItemTaxesListDic setValue:[taxDic valueForKey:TAX_TYPE] forKey:Tax_Type];
                        [orderItemTaxesListDic setValue:[taxDic valueForKey:TAX_RATE] forKey:Tax_rate];
                        
                        [orderItemTaxesListDic setValue:[self checkGivenValueIsNullOrNil:[orderItemsDic valueForKey:[taxDic valueForKey:TAX_CODE]]  defaultReturn:@"0.00"] forKey:Tax_value];
                        
                        [orderItemTaxesListArr addObject:orderItemTaxesListDic];
                    }
                }else if([[orderItemsDic valueForKey:TAX] count] == 0){
                    
                    orderItemTaxesListDic = [[NSMutableDictionary alloc]init];
                    [orderItemTaxesListArr addObject:orderItemTaxesListDic];
                }
                
                if(dealOffersDic != nil && ([[orderItemsDic valueForKey:DISCOUNT_PRICE]floatValue] > 0) ){
                    
                    orderDiscountsDic = [[NSMutableDictionary alloc]init];
                    
                    [orderDiscountsDic setValue:[orderItemsDic valueForKey:DISCOUNT_TYPE] forKey:DISCOUNT_TYPE];
                    [orderDiscountsDic setValue:[orderItemsDic valueForKey:DISCOUNT_ID] forKey:DISCOUNT_ID];
                    [orderDiscountsDic setValue:[orderItemsDic valueForKey:DISCOUNT_PRICE] forKey:DISCOUNT_PRICE];
                    [orderDiscountsDic setValue:[orderItemsDic valueForKey:ITEM_SKU] forKey:ITEM_SKU];
                    [orderDiscountsDic setValue:[orderItemsDic valueForKey:SALE_PRICE] forKey:iTEM_PRICE];
                    [orderDiscountsDic setValue:[orderItemsDic valueForKey:PLU_CODE] forKey:PLU_CODE];
                    
                    [orderDiscountsArr addObject:orderDiscountsDic];
                }
                //                    else
                //                        [orderDiscountsArr addObject:orderDiscountsDic];
            }
        }
        @catch(NSException *exception){
            NSLog(@"exception while creating an order ----%@",exception);
        }
        
        NSMutableArray * orderTransactionArr = [[NSMutableArray alloc]init];
        NSMutableDictionary * orderTransactionDic = [[NSMutableDictionary alloc]init];
        
        [orderTransactionDic setValue:orderRef forKey:ORDER_ID];
        [orderTransactionDic setValue:@"0.00" forKey:PAID_AMT];
        [orderTransactionDic setValue:@"0.00" forKey:RECEIVED_AMOUNT];
        [orderTransactionDic setValue:@"" forKey:MODE_OF_PAY];
        [orderTransactionDic setValue:@"" forKey:PAYMENT_STATUS];
        [orderTransactionDic setValue:@"" forKey:CARD_TYPE];
        [orderTransactionDic setValue:@"" forKey:COUPON_NO];
        [orderTransactionDic setValue:@"" forKey:BANK_NAME];
        [orderTransactionDic setValue:@"" forKey:APPROVAL_CODE];
        [orderTransactionDic setValue:@"0" forKey:CHANGE_RETURN];
        [orderTransactionDic setValue:@"" forKey:CARD_INFO];
        [orderTransactionDic setValue:@"" forKey:DATE];
        
        [orderTransactionArr addObject:orderTransactionDic];
        
        createOrderDic[ORDER_DISCOUNTS_LIST] = orderDiscountsArr;
        createOrderDic[kItemDetails] = cartItemDetails;
        createOrderDic[ORDER_ITEM_TAXES_LIST] = orderItemTaxesListArr;
        createOrderDic[ORDER_TRANSACTIONS] = orderTransactionArr;
        
        [createOrderDic setValue:taxValLbl.text forKey:ORDER_TAX];
        [createOrderDic setValue:@"0.00" forKey:SHIPMENT_CHARGES];
        createOrderDic[ORDERED_ITEMSLIST] = cartItemDetails;
        
        createOrderDic[no_of_items] = [NSNumber numberWithInteger:cartItemDetails.count];
        
        // added by roja
//        createOrderDic[@"createdOn"] = startTimeTxt.text;

        
        // upto here changed by roja on 14-09-2018..
//        //Order Details...
//        mutOrderDetailsDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
//
//        // item Dictionary....
//        NSMutableArray * orderItemTaxesListArr = [[NSMutableArray alloc]init];
//        NSMutableDictionary * orderItemTaxesListDic;
//
//        NSMutableArray * orderDiscountsArr = [[NSMutableArray alloc]init];
//        NSMutableDictionary * orderDiscountsDic;
//
//        // added by roja on 14-09-2018...
//
//        @try{
//            for (int i=0; i< cartItemDetails.count; i++) {
//
//                NSMutableDictionary *orderItemsDic = [[cartItemDetails objectAtIndex:i] mutableCopy];
//
//                // setting Sale_price after discounts to Item_Price Key...
//                [orderItemsDic setValue:[orderItemsDic valueForKey:SALE_PRICE_AFTER_DISCOUNT] forKey:Item_Price];
//                [cartItemDetails replaceObjectAtIndex:i withObject:orderItemsDic];
//
//
//                if ( !( [[orderItemsDic valueForKey:TAX] isKindOfClass:[NSNull class]] ) && [[orderItemsDic valueForKey:TAX] count] ) {
//
//                    for (NSDictionary *taxDic in [orderItemsDic valueForKey:TAX] ){
//
//                        orderItemTaxesListDic = [[NSMutableDictionary alloc] init];
//                        [orderItemTaxesListDic setValue:[orderItemsDic valueForKey:ITEM_SKU] forKey:SKU_ID];
//                        [orderItemTaxesListDic setValue:[orderItemsDic valueForKey:PLU_CODE] forKey:plu_code_];
//                        [orderItemTaxesListDic setValue:[taxDic valueForKey:Tax_Category] forKey:TAX_CATEGORY];
//                        [orderItemTaxesListDic setValue:[taxDic valueForKey:TAX_CODE] forKey:Tax_code];
//                        [orderItemTaxesListDic setValue:[taxDic valueForKey:TAX_TYPE] forKey:Tax_Type];
//                        [orderItemTaxesListDic setValue:[taxDic valueForKey:TAX_RATE] forKey:Tax_rate];
//
//                        [orderItemTaxesListDic setValue:[self checkGivenValueIsNullOrNil:[orderItemsDic valueForKey:[taxDic valueForKey:TAX_CODE]]  defaultReturn:@"0.00"] forKey:Tax_value];
//
//                        [orderItemTaxesListArr addObject:orderItemTaxesListDic];
//                    }
//                }else if([[orderItemsDic valueForKey:TAX] count] == 0){
//
//                    orderItemTaxesListDic = [[NSMutableDictionary alloc]init];
//                    [orderItemTaxesListArr addObject:orderItemTaxesListDic];
//                }
//
//                if(dealOffersDic != nil && ([[orderItemsDic valueForKey:DISCOUNT_PRICE]floatValue] > 0) ){
//
//                    orderDiscountsDic = [[NSMutableDictionary alloc]init];
//
//                    [orderDiscountsDic setValue:[orderItemsDic valueForKey:DISCOUNT_TYPE] forKey:DISCOUNT_TYPE];
//                    [orderDiscountsDic setValue:[orderItemsDic valueForKey:DISCOUNT_ID] forKey:DISCOUNT_ID];
//                    [orderDiscountsDic setValue:[orderItemsDic valueForKey:DISCOUNT_PRICE] forKey:DISCOUNT_PRICE];
//                    [orderDiscountsDic setValue:[orderItemsDic valueForKey:ITEM_SKU] forKey:ITEM_SKU];
//                    [orderDiscountsDic setValue:[orderItemsDic valueForKey:SALE_PRICE] forKey:iTEM_PRICE];
//                    [orderDiscountsDic setValue:[orderItemsDic valueForKey:PLU_CODE] forKey:PLU_CODE];
//
//                    [orderDiscountsArr addObject:orderDiscountsDic];
//                }
//                //                    else
//                //                        [orderDiscountsArr addObject:orderDiscountsDic];
//            }
//        }
//        @catch(NSException *exception){
//            NSLog(@"exception while creating an order ----%@",exception);
//        }
//
//        [mutOrderDetailsDic setValue:[NSNumber numberWithBool:true] forKey:IS_TABLE_BOOKING];
//        mutOrderDetailsDic[ORDER_DISCOUNTS_LIST] = orderDiscountsArr;
//        mutOrderDetailsDic[kItemDetails] = cartItemDetails;
//        mutOrderDetailsDic[ORDER_ITEM_TAXES_LIST] = orderItemTaxesListArr;
//        mutOrderDetailsDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
//
//        [mutOrderDetailsDic setValue:netPayValLbl.text forKey:ORDER_TAX];
//        [mutOrderDetailsDic setValue:@"0.00" forKey:SHIPMENT_CHARGES];
//        mutOrderDetailsDic[ORDERED_ITEMSLIST] = cartItemDetails;
//
//        mutOrderDetailsDic[no_of_items] = [NSNumber numberWithInteger:cartItemDetails.count];
        
        // upto here changed by roja on 14-09-2018..
        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:createOrderDic options:0 error:&err];
        
        NSString * updateOrderJsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"----%@",updateOrderJsonStr);
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.outletOrderServiceDelegate = self;
        [webServiceController  updateOutletOrder:updateOrderJsonStr];
    }
    @catch(NSException * exception){
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        NSLog(@"-------exception will reading.-------%@",exception);
    }
}


-(void)updateOutletOrderSucessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        [HUD setHidden:YES];
        
//        sucess = [[UIAlertView alloc] initWithTitle:@"Order Updated Successfully" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
//        [sucess show];
        
                float y_axis = self.view.frame.size.height - 120;
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"Order Updated Successfully",nil)];
//                NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"Order Updated Successfully",nil),@"\n", [successDictionary valueForKey:@"orderId"]];
        
                [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:@"CART_RECORDS" conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

-(void)updateOutletOrderErrorResponse:(NSString *)errorResponse {
    
    @try {
        
        
        float y_axis = self.view.frame.size.height - 170;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:350 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
    }
    
}

- (IBAction)submitOrder:(UIButton *)sender{

    AudioServicesPlaySystemSound (soundFileObject);

    float y_axis = self.view.frame.size.height - 150;
    
    if([tableNoTxt.text length]==0 && [headCountTxt.text length]==0 && [mobileNoTxt.text length]){
        
        y_axis = self.view.frame.size.height - 200;
        [self displayAlertMessage:@"Please select the table" horizontialAxis:(self.view.frame.size.width - 360)/2 verticalAxis:y_axis msgType:@"Alert" conentWidth:300 contentHeight:60 isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    else{
        NSMutableArray * temparr = [[NSMutableArray alloc]init];
        
        for(NSDictionary * locDic in cartItemDetails){
            
            if(![[self checkGivenValueIsNullOrNil:[locDic valueForKey:IS_VOID] defaultReturn:@"0"] boolValue]){
                [temparr addObject:locDic];
            }
        }
        
        if([temparr count]){
            
            if (!isOfflineService) {
                
                if(isToCallUpdate){
                    
                    [self callUpdateOutletOrder:2];
                }
                else{
                    
                    [self callCreateOutletOrder:2];
                }
            }
            else {
                
                float y_axis = self.view.frame.size.height - 120;
                [self displayAlertMessage:@"Please enable wifi or mobile data" horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:1];
            }
        }
        else{
            
            y_axis = self.view.frame.size.height - 200;
            
            [self displayAlertMessage:@"Please add items" horizontialAxis:(self.view.frame.size.width - 360)/2 verticalAxis:y_axis msgType:@"Alert" conentWidth:300 contentHeight:60 isSoundRequired:YES timming:2.0 noOfLines:2];
        }
    }
}

/**
 * @description  Here we are calling 'KOTServiceDelegate' to update items status
 * @date         14/03/2019
 * @method       updateItemStatus
 * @author       Roja
 * @param        UIButton
 * @param
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
-(void)updateItemStatus:(UIButton *)sender {
    
    @try {
        AudioServicesPlaySystemSound (soundFileObject);
        
        [HUD setHidden:NO];

        NSDictionary *  selectedItemDic = [cartItemDetails objectAtIndex:sender.tag];
//        NSDictionary *  tableDetailsDic = [tableDetails objectAtIndex:sender.tag];
        
        NSString * tableNumStr = [self checkGivenValueIsNullOrNil:[selectedItemDic valueForKey:@"tableNumber"] defaultReturn:tableNoTxt.text];
        
        NSString * statusStr = @"ready from kitchen";
        
//        statusStr = [self checkGivenValueIsNullOrNil:[selectedItemDic valueForKey:@"status"] defaultReturn:@"ordered"];
        statusStr = [self checkGivenValueIsNullOrNil:[selectedItemDic valueForKey:@"status"] defaultReturn:@"Draft"];

        
//        NSString * orderTypeStr = [self checkGivenValueIsNullOrNil:[selectedItemDic valueForKey:orderTypeTF.text] defaultReturn:orderTypeTF.text]; // WalkIn
        
        NSString * orderTypeStr = @"Table"; // Take Away // Table

//        NSString * orderRefStr = [self checkGivenValueIsNullOrNil:[[tableDetailsDic valueForKey:@"order"] valueForKey:@"orderReference"] defaultReturn:@""];
        
        NSString * orderRefStr = orderRef;
        
        NSString * itemIdStr = [self checkGivenValueIsNullOrNil:[selectedItemDic valueForKey:@"skuId"] defaultReturn:@"0"];
        
        NSString * skuIdStr = [self checkGivenValueIsNullOrNil:[selectedItemDic valueForKey:@"skuId"] defaultReturn:@"0"];
        
        NSString * pluCodeStr = [self checkGivenValueIsNullOrNil:[selectedItemDic valueForKey:@"pluCode"] defaultReturn:@"0"];
        
        NSDictionary *reqDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[RequestHeader getRequestHeader],presentLocation,tableNumStr,statusStr,orderTypeStr,orderRefStr,itemIdStr,skuIdStr,pluCodeStr, nil] forKeys:[NSArray arrayWithObjects:REQUEST_HEADER,@"store_location",@"tableNum",@"status",@"order_type",@"order_ref",@"item_id",@"skuId",@"pluCode", nil]];

        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:0 error:&err];
        NSString * updateItemStatusStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *controller = [[WebServiceController alloc] init];
        [controller setKotServiceDelegate:self];
        [controller updateKotStatus:updateItemStatusStr];
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
    } @finally {
        
    }
}


/**
 * @description  Here we are handling sucess response of update Item status
 * @date         14/03/2019
 * @method       updateKotStatusFailureResponse
 * @author       Roja
 * @param
 * @param        NSDictionary
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
-(void)updateKotStatusSuccessResponse:(NSDictionary*)successDictionary{
    
    @try {
        
        [self callingOutletOrderIdDetails];

    } @catch (NSException *exception) {

    } @finally {
        
//        [HUD setHidden:YES];
    }
}


/**
 * @description  Here we are handling error response of update Item status
 * @date         14/03/2019
 * @method       updateKotStatusFailureResponse
 * @author       Roja
 * @param
 * @param        NSString
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
-(void)updateKotStatusFailureResponse:(NSString *)failureString{
    
    @try {
    
        float y_axis = self.view.frame.size.height - 120;
        [self displayAlertMessage:failureString horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:y_axis  msgType:@""  conentWidth:350 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        [self callingOutletOrderIdDetails];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
//        [HUD setHidden:YES];
    }
}



@end
