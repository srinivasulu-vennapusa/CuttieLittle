//
//  NewBooking.m
//  OmniRetailer
//
//  Created by Sonali on 12/5/15.
//
//

#import "NewRestBooking.h"
#import "ServiceOrders.h"

BOOL isDrinkReq = FALSE;

@interface NewRestBooking ()

@end

@implementation NewRestBooking

@synthesize mobileNo,slotId,reservationModeTxt,reservationDate,reservationStatusTxt,reservModeSelectionBtn,registrationView;
@synthesize submitDetails,cancel,custName,lastNameTxt;
@synthesize soundFileObject,soundFileURLRef;
@synthesize customerEmailTxt,noOfChildsTxt,noOfAdultsTxt,isVegBtn,specialInstructionsTxtView;
@synthesize radioBtn1,radioBtn2;
@synthesize genderTxt,alcoholCountTxt,nonAlcoholCountTxt,nonvegCountTxt,vegCountTxt,childrenNonVegCount,childrenVegCount,occasionTxt,vehicleNo;
@synthesize selectGenderBtn,selectOccasion;
@synthesize directTableBookingLbl,custNotSharingDetailsLbl;
@synthesize checkBoxButton1,checkBoxButton2;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    currentOrientation = [[UIDevice currentDevice] orientation];
    
    self.titleLabel.text  = NSLocalizedString(@"Rest Booking", nil);
    [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:18.0 cornerRadius:8.0];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    // Show the HUD
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    [HUD show:YES];
    [HUD setHidden:YES];
    
    specialInstructionsTxtView.layer.cornerRadius = 10.0f;
    
    customerDetails = [[UILabel alloc] init] ;
    customerDetails.text = @"Customer Details>>>";
    customerDetails.font = [UIFont italicSystemFontOfSize:20.0];
    customerDetails.textColor = [UIColor whiteColor];
    customerDetails.backgroundColor = [UIColor clearColor];
    customerDetails.hidden = NO;
    customerDetails.userInteractionEnabled = TRUE;
    UITapGestureRecognizer *sinleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getCustomerDetailsDoorDel)];
    [customerDetails addGestureRecognizer:sinleTap];
    
    customerInfoEnable = [[UIButton alloc] init];
    [customerInfoEnable addTarget:self action:@selector(getCustomerDetailsDoorDel) forControlEvents:UIControlEventTouchUpInside];
    [customerInfoEnable setBackgroundImage:[UIImage imageNamed:@"MB__info.png"] forState:UIControlStateNormal];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
            
            customerDetails.frame = CGRectMake(20,600, 200, 30);
            customerInfoEnable.frame = CGRectMake((mobileNo.frame.origin.x + mobileNo.frame.size.width - 50),92, 30, 30);//
        }
    }
    
    [self.view addSubview:customerInfoEnable];
    
    //set the current date...
    NSDate *today = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString* currentdate = [f stringFromDate:today];
    reservationDate.text = currentdate;
    
    //properties initialization...
    
    slotIdsArr = [WebServiceUtility getPropertyFromProperties:@"slotId"];
    modeOfResrvArr = [WebServiceUtility getPropertyFromProperties:@"reservationMode"];
    
    occasionsDic = [WebServiceUtility getPropertyFromProperties:@"Occasions"];
    listOfOccasions = [[[WebServiceUtility getPropertyFromProperties:@"Occasions"] allKeys] mutableCopy];
    genderArr = [WebServiceUtility getPropertyFromProperties:@"gender"];
    customerInfoDic = [[NSMutableDictionary alloc] init];
    isVeg = FALSE;
    custCategory = @"";
    gender = @"M";
    
    // added by roja on 09/01/2019...
    mobileNo.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    slotId.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    reservationModeTxt.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    custName.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    lastNameTxt.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    occasionTxt.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    noOfAdultsTxt.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    noOfChildsTxt.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    customerEmailTxt.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    specialInstructionsTxtView.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    vehicleNo.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    genderTxt.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    vegCountTxt.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    nonvegCountTxt.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    alcoholCountTxt.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    nonAlcoholCountTxt.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    childrenVegCount.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    childrenNonVegCount.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    reservationDate.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    
    directTableBookingLbl.textColor = [UIColor lightGrayColor];
    custNotSharingDetailsLbl.textColor = [UIColor lightGrayColor];

    directTableBookingLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:16];
    custNotSharingDetailsLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:16];

    checkBoxButton1.tag = 2;
    checkBoxButton2.tag = 2;
    
    //Upto here  added by roja on 09/01/2019 && 23/03/2019...

    //[[UIColor lightGrayColor] colorWithAlphaComponent:0.8]
//    [submitDetails setBackgroundColor:[UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8]];
//    [cancel setBackgroundColor:[UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8]];

    // Do any additional setup after loading the view from its nib.
}


/**
 * @description
 * @date            02/04/2019
 * @method          viewDidAppear
 * @author          Roja
 * @param           BOOL
 * @param
 * @return          (void)
 * @verified By
 * @verified On
 */
-(void)viewDidAppear:(BOOL)animated{

    isDirectTableBooking = false;
    isDetailsNotSharing = false;
}

-(void)getCustomerDetailsDoorDel {
    
    [self populateCustomerInfoPopUp:customerInfoDic];
}

/**
 * @discussion Add popup showing the customer info
 * @date   16/10/15
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
    
    
    UILabel *customerName = [[UILabel alloc] init];
    customerName.textColor = [UIColor blackColor];
    customerName.font = [UIFont boldSystemFontOfSize:18.0];
    customerName.text  = @"Customer Name";
    
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
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
            
            
            custType.frame =  CGRectMake(10, 5, 150, 30);
            custTypeVal.frame =  CGRectMake(230, 5, 200, 30);
            
            customerName.frame =  CGRectMake(10, 40, 150, 30);
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
        }
    }
    
    [customerView addSubview:custType];
    [customerView addSubview:custTypeVal];
    [customerView addSubview:customerName];
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
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        customerInfoPopUp.preferredContentSize =  CGSizeMake(customerView.frame.size.width, customerView.frame.size.height);
        
        // uncomment....
//        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
//
//          [popover presentPopoverFromRect:customerInfoEnable.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
//          popover= popover;
//
        
        // added by roja on 22/01/2019...
        customerInfoPopUp.modalPresentationStyle = UIModalPresentationPopover;

        presentationPopOverController = [customerInfoPopUp popoverPresentationController];
        presentationPopOverController.permittedArrowDirections = UIPopoverArrowDirectionUp;
        
//        CGRect temp = customerInfoEnable.frame;
//        temp.origin.y = temp.origin.y + temp.size.height/2;

        presentationPopOverController.sourceView = registrationView; // customerInfoPopUp.view
        presentationPopOverController.sourceRect = customerInfoEnable.frame; //customerInfoEnable.frame
        [self presentViewController:customerInfoPopUp animated:YES completion:nil];
        // upto here added by roja on 22/01/2019...
    }
    else {
        
        
    }
    
    UIGraphicsBeginImageContext(customerView.frame.size);
    [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customerView.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    customerView.backgroundColor = [UIColor colorWithPatternImage:image];
    
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

//- (void)dealloc {
//
//
//    [super dealloc];
//}


- (void)viewDidUnload {
    [self setRegistrationView:nil];
    [self setMobileNo:nil];
    [self setSlotId:nil];
    [self setSlotIdSelectionBtn:nil];
    [self setReservationModeTxt:nil];
    [self setReservModeSelectionBtn:nil];
    [self setSubmitDetails:nil];
    [self setCancel:nil];
    [self setNoOfCustTxt:nil];
    [self setReservationDate:nil];
    [self setReservationStatusTxt:nil];
    [self setCustName:nil];
    [self setSelectOccasion:nil];
    [self setOccasionTxt:nil];
    [self setNoOfChildsTxt:nil];
    [self setSpecialInstrTxt:nil];
    [self setCustomerEmailTxt:nil];
    [self setIsVegBtn:nil];
    [self setSpecialInstructionsTxtView:nil];
    [self setDrinkReqBtn:nil];
    [self setVehicleNo:nil];
    [self setGenderTxt:nil];
    [self setSelectGenderBtn:nil];
    [self setVegCountTxt:nil];
    [self setNonvegCountTxt:nil];
    [self setAlcoholCountTxt:nil];
    [self setNonAlcoholCountTxt:nil];
    [self setChildrenVegCount:nil];
    [self setChildrenNonVegCount:nil];
    [super viewDidUnload];
}
- (IBAction)textFieldDidChange:(UITextField *)sender {
    
    if (sender == mobileNo && [mobileNo.text length]==10) {
        
        [self getCustomerDetails:mobileNo.text];
        
    }
    else if ([mobileNo.text length]>10) {
        
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ValidPhoneNo", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
        [alert show];
    }
}

/**
 * @description     get the existed customer details based on phone no
 * @date            5/12/15
 * @method          getCustomerDetails
 * @author           Sonali
 * @param           phoneNo
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)getCustomerDetails:(NSString*)phoneNo {
    
    [mobileNo resignFirstResponder];
    
//    BOOL status = FALSE;
//    CheckWifi *WIFI = [[CheckWifi alloc]init];
//    status = [WIFI checkWifi];
    
    if (!isOfflineService) {
        
        // showing the HUD ..
        [HUD setHidden:NO];
        
        @try{
            WebServiceController * controller = [WebServiceController new];
            [controller setCustomerServiceDelegate:self];
            
            NSArray * customerDetailsKeys = [NSArray arrayWithObjects:@"email",@"mobileNumber",REQUEST_HEADER, nil];
            
            NSArray *customerDetailsObjects = [NSArray arrayWithObjects:@"",phoneNo,[RequestHeader getRequestHeader], nil];
            NSDictionary *requestDic = [NSDictionary dictionaryWithObjects:customerDetailsObjects forKeys:customerDetailsKeys];
            
            NSError * err_;
            NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:requestDic options:0 error:&err_];
            NSString * RequestString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
            [controller getCustomerDetails:RequestString];
            
            //                NSArray * addressDetailsKeys = [NSArray arrayWithObjects: KEY_EMAIL,KEY_MOBILE_NUMBER,KEY_NAME,KEY_PHONE,KEY_REQUEST_HEADER, nil];
            //
            //                NSArray *addressDetailsObjects = [NSArray arrayWithObjects:KEY_EMPTY_STRING,mobileNumTF.text,KEY_EMPTY_STRING,mobileNumTF.text,[RequestHeader getRequestHeader], nil];
            
        } @catch (NSException *exception) {
                
                [HUD setHidden:YES];
            }
    }
    
    // commented by roja on 09/01/2019
    // reason offline work need to be done.
//    else {
//
//        OfflineBillingServices *offline = [[OfflineBillingServices alloc] init];
//        NSDictionary *JSON1 = [offline getCustomerDetails:mobileNo.text];
//        if ([[NSString stringWithFormat:@"%@",[JSON1 objectForKey:@"phone"]] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",[JSON1 objectForKey:@"email"]] isEqualToString:@"<null>"] || [JSON1 count]==0) {
//
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"New Customer" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//        }
//        else{
//
//            //NSArray *temp = [body.return_ componentsSeparatedByString:@"#"];
//            customerInfoDic = [JSON1 copy];
//            custCategory = [[JSON1 objectForKey:@"category"] copy];
//
//            //NSArray *temp = [body.return_ componentsSeparatedByString:@"#"];
//            mobileNo.text = [NSString stringWithFormat:@"%@",[JSON1 objectForKey:@"phone"]];
//            customerEmailTxt.text = [NSString stringWithFormat:@"%@",[JSON1 objectForKey:@"email"]];
//            custName.text = [NSString stringWithFormat:@"%@",[JSON1 objectForKey:@"name"]];
//        }
//
//    }
}


- (IBAction)selectDate:(UIButton *)sender {
    
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
        
        pickView.frame = CGRectMake(15, reservationDate.frame.origin.y+reservationDate.frame.size.height, 320, 320);
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
    [myPicker setBackgroundColor:[UIColor whiteColor]];
    
    UIButton  *pickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [pickButton setBackgroundImage:[UIImage imageNamed:@"ok2.jpg"] forState:UIControlStateNormal];
    
    pickButton.frame = CGRectMake(85, 269, 100, 45);
    pickButton.backgroundColor = [UIColor clearColor];
    pickButton.layer.masksToBounds = YES;
    [pickButton addTarget:self action:@selector(getStartDate:) forControlEvents:UIControlEventTouchUpInside];
    pickButton.layer.borderColor = [UIColor blackColor].CGColor;
    pickButton.layer.borderWidth = 0.5f;
    pickButton.layer.cornerRadius = 12;
    //pickButton.layer.masksToBounds = YES;
    [customView addSubview:myPicker];
    [customView addSubview:pickButton];
    
    
    customerInfoPopUp.view = customView;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
        
        // commented by roja on 22/01/2019...
        //Reason UIPopoverController is deprecated in iOS 9.0, So using UIPopoverPresentationController && UIModalPresentationPopover(style)
        
//        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
//        [popover presentPopoverFromRect:reservationDate.frame inView:registrationView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
//        popOver= popover;
        
        
        // added by roja on 22/01/2019...
        customerInfoPopUp.modalPresentationStyle = UIModalPresentationPopover;
        
        presentationPopOverController = [customerInfoPopUp popoverPresentationController];
        presentationPopOverController.permittedArrowDirections = UIPopoverArrowDirectionUp;
        
//        CGRect temp = reservationDate.frame;
//        temp.origin.y = temp.origin.y + temp.size.height/2;
        
        presentationPopOverController.sourceView = registrationView; //  customerInfoPopUp.view
        presentationPopOverController.sourceRect = reservationDate.frame; //reservationDate.frame
        [self presentViewController:customerInfoPopUp animated:YES completion:nil];
        // upto here added by roja on 22/01/2019...
    }
    
    else {
     
    }
    
    UIGraphicsBeginImageContext(customView.frame.size);
    [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    customView.backgroundColor = [UIColor colorWithPatternImage:image];
    
    
    
}
-(IBAction)getStartDate:(id)sender{
    
    AudioServicesPlaySystemSound (soundFileObject);
    
    //Date Formate Setting...
    
    NSDateFormatter *sdayFormat = [[NSDateFormatter alloc] init];
    [sdayFormat setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *dateString = [sdayFormat stringFromDate:myPicker.date];
    
//    [self.popOver dismissPopoverAnimated:YES];
    // added by roja on 22/01/2019...
    [self dismissViewControllerAnimated:YES completion:nil];

    
    NSDateFormatter *compFormat = [[NSDateFormatter alloc] init];
    [compFormat setDateFormat:@"dd/MM/yyyy HH:mm"];
    NSString *dateString1 = [sdayFormat stringFromDate:myPicker.date];
    
    reservationDate.text = dateString;
    
    
    NSDate *selectedDate = [compFormat dateFromString:dateString1];
    NSDate *currentDate = [compFormat dateFromString:[compFormat stringFromDate:[NSDate date]]];
    
    if ([currentDate compare:selectedDate] == NSOrderedDescending) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Select proper date" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        reservationDate.text = @"";
        
    }
    
    
}

- (IBAction)selectReservationMode:(UIButton *)sender {
    
    
    PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
    
    
    float tableHt = 0;
    
    if([modeOfResrvArr count] && [modeOfResrvArr count] <= 5) {
        tableHt =[modeOfResrvArr count] * 40;
    }
    else if([modeOfResrvArr count] && [modeOfResrvArr count] > 5){
        
        tableHt = 5 * 40;
    }
    
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 250, tableHt)]; // ht = 150
    customView.opaque = NO;
    customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    customView.layer.borderWidth = 2.0f;
    [customView setHidden:NO];
    
    reservationModeTbl = [[UITableView alloc] init];
    reservationModeTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [reservationModeTbl setDataSource:self];
    [reservationModeTbl setDelegate:self];
    [reservationModeTbl.layer setBorderWidth:1.0f];
    reservationModeTbl.layer.cornerRadius = 3;
    reservationModeTbl.layer.borderColor = [UIColor grayColor].CGColor;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        reservationModeTbl.frame = CGRectMake(0, 0, customView.frame.size.width, customView.frame.size.height);
        
    }
    
    
    [customView addSubview:reservationModeTbl];
    
    customerInfoPopUp.view = customView;
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
        
        // commented by roja on 22/01/2019...
        //Reason UIPopoverController is deprecated in iOS 9.0, So using UIPopoverPresentationController && UIModalPresentationPopover(style).....
        
//        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
//        [popover presentPopoverFromRect:reservationModeTxt.frame inView:registrationView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
//        popOver= popover;
        
        
        // added by roja on 22/01/2019...
        customerInfoPopUp.modalPresentationStyle = UIModalPresentationPopover;
        
        presentationPopOverController = [customerInfoPopUp popoverPresentationController];
        presentationPopOverController.permittedArrowDirections = UIPopoverArrowDirectionUp;
        
//        CGRect temp = reservationModeTxt.frame;
//        temp.origin.y = temp.origin.y + temp.size.height/2;
        
        presentationPopOverController.sourceView = registrationView; // customerInfoPopUp.view
        presentationPopOverController.sourceRect = reservationModeTxt.frame; //reservationModeTxt.frame
        [self presentViewController:customerInfoPopUp animated:YES completion:nil];
        // upto here added by roja on 22/01/2019...
    }
    else {
       
    }
    
    UIGraphicsBeginImageContext(customView.frame.size);
    [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    customView.backgroundColor = [UIColor colorWithPatternImage:image];
    
    [reservationModeTbl reloadData];
    
}
/**
 * @description     select the slot
 * @date            7/12/15
 * @method          selectSlot
 * @author           Sonali
 * @param           sender of type UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 */

- (IBAction)selectSlot:(UIButton *)sender {
    
    
    PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
    
    float tableHt = 0;
    
    if([slotIdsArr count] && [slotIdsArr count] <= 5) {
        tableHt = [slotIdsArr count] * 40;
    }
    else if([slotIdsArr count] && [slotIdsArr count] > 5){
        tableHt = 5 * 40;
    }
 
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 250, tableHt)];
    customView.opaque = NO;
    customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    customView.layer.borderWidth = 2.0f;
    [customView setHidden:NO];
    
    slotIdsTbl = [[UITableView alloc] init];
    slotIdsTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [slotIdsTbl setDataSource:self];
    [slotIdsTbl setDelegate:self];
    [slotIdsTbl.layer setBorderWidth:1.0f];
    slotIdsTbl.layer.cornerRadius = 3;
    slotIdsTbl.layer.borderColor = [UIColor grayColor].CGColor;
    slotIdsTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        slotIdsTbl.frame = CGRectMake(0, 0, customView.frame.size.width, customView.frame.size.height);
    }
    
    [customView addSubview:slotIdsTbl];
    
    slotIdsTbl.rowHeight = 40.0f;
    slotIdsTbl.frame = [WebServiceUtility setTableViewheightOfTable:slotIdsTbl ByArrayName:slotIdsArr];
    customView.frame = slotIdsTbl.frame;
    customerInfoPopUp.view = customView;
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        customerInfoPopUp.preferredContentSize = CGSizeMake(customView.frame.size.width, customView.frame.size.height);
        
        // commented by roja on 22/01/2019...
        //Reason UIPopoverController is deprecated in iOS 9.0, So using UIPopoverPresentationController && UIModalPresentationPopover(style).....
        
//        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
//        [popover presentPopoverFromRect:slotId.frame inView:registrationView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
//        popOver= popover;
        
        
        
        // added by roja on 22/01/2019...
        customerInfoPopUp.modalPresentationStyle = UIModalPresentationPopover;
        
        presentationPopOverController = [customerInfoPopUp popoverPresentationController];
        presentationPopOverController.permittedArrowDirections = UIPopoverArrowDirectionUp;
        
//        CGRect temp = slotId.frame;
//        temp.origin.y = temp.origin.y + temp.size.height/2;
        
        presentationPopOverController.sourceView = registrationView; // customerInfoPopUp.view
        presentationPopOverController.sourceRect = slotId.frame; //slotId.frame
        [self presentViewController:customerInfoPopUp animated:YES completion:nil];
        // upto here added by roja on 22/01/2019...
    }
    else {
    
    }
    
    UIGraphicsBeginImageContext(customView.frame.size);
    [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    customView.backgroundColor = [UIColor colorWithPatternImage:image];
    
    [slotIdsTbl reloadData];
    
}
#pragma -mark tableview delegates
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == slotIdsTbl) {
        
        return [slotIdsArr count];
    }
    else if (tableView == reservationModeTbl) {
        
        return [modeOfResrvArr count];
    }
    else if (tableView == genderTbl) {
        return [genderArr count];
    }
    else if (tableView == occasionsTbl) {
        
        return [listOfOccasions count];
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (tableView == slotIdsTbl || tableView == reservationModeTbl || tableView == occasionsTbl || tableView == genderTbl) {
            
            return 40.0f;
        }
    }
    return 40.0f;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorColor = [UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0];
    
    static NSString *hlCellID = @"hlCellID";
    
    UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
    
    static NSString *MyIdentifier = @"MyIdentifier";
    
    MyIdentifier = @"TableView";
    
    if (tableView == reservationModeTbl) {
        
        
        if ([hlcell.contentView subviews]){
            for (UIView *subview in [hlcell.contentView subviews]) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID] ;
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:18];
            }
            else {
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:12];
            }
        }
        
        hlcell.textLabel.text = [NSString stringWithFormat:@"%@",[modeOfResrvArr objectAtIndex:indexPath.row]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        
    }
    else if (tableView == genderTbl) {
        
        
        if ([hlcell.contentView subviews]){
            for (UIView *subview in [hlcell.contentView subviews]) {
                [subview removeFromSuperview];
            }
        }
      
        if(hlcell == nil) {
            
            hlcell =  [[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID] ;
            
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:18];
            }
            else {
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:12];
            }
        }
        
        hlcell.textLabel.text = [NSString stringWithFormat:@"%@",[genderArr objectAtIndex:indexPath.row]];
        hlcell.textLabel.textColor = [UIColor blackColor];
    }
    else if (tableView == slotIdsTbl) {
        
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
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:18];
            }
            else {
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:12];
            }
        }
        
        hlcell.textLabel.text = [NSString stringWithFormat:@"%@",[slotIdsArr objectAtIndex:indexPath.row]];
        hlcell.textLabel.textColor = [UIColor blackColor];
    }
    else  if (tableView == occasionsTbl){
        
        
        if ([hlcell.contentView subviews]){
            for (UIView *subview in [hlcell.contentView subviews]) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil) {
            hlcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:18];
            }
            else {
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:12];
            }
        }
        
        hlcell.textLabel.text = [NSString stringWithFormat:@"%@",[listOfOccasions objectAtIndex:indexPath.row]];
        hlcell.textLabel.textColor = [UIColor blackColor];
    }
    return hlcell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (tableView == occasionsTbl) {
        
        occasionTxt.text = [listOfOccasions objectAtIndex:indexPath.row];
        
        //    [self.popOver dismissPopoverAnimated:YES];
        // added by roja on 22/01/2019...
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    else if (tableView == slotIdsTbl) {
        
        slotId.text = [NSString stringWithFormat:@"%@",[slotIdsArr objectAtIndex:indexPath.row]];
        
        //    [self.popOver dismissPopoverAnimated:YES];
        // added by roja on 22/01/2019...
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if (tableView == genderTbl) {
        
        genderTxt.text = [NSString stringWithFormat:@"%@",[genderArr objectAtIndex:indexPath.row]];
        
        //    [self.popOver dismissPopoverAnimated:YES];
        // added by roja on 22/01/2019...
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if (tableView == reservationModeTbl) {
        
        reservationModeTxt.text = [NSString stringWithFormat:@"%@",[modeOfResrvArr objectAtIndex:indexPath.row]];

        //    [self.popOver dismissPopoverAnimated:YES];
        // added by roja on 22/01/2019...
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma -mark end of tableview methods

- (IBAction)selectOccasionType:(UIButton *)sender {
    
    
    PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
    
    float tableHt = 0;
    
    if([listOfOccasions count] && [listOfOccasions count] <= 5) {
        tableHt =[listOfOccasions count] * 40;
    }
    else if([listOfOccasions count] && [listOfOccasions count] > 5){
        
        tableHt = 5 * 40;
    }
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 250, tableHt)];
    customView.opaque = NO;
    customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    customView.layer.borderWidth = 2.0f;
    [customView setHidden:NO];
    
    occasionsTbl = [[UITableView alloc] init];
    occasionsTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [occasionsTbl setDataSource:self];
    [occasionsTbl setDelegate:self];
    [occasionsTbl.layer setBorderWidth:1.0f];
    occasionsTbl.layer.cornerRadius = 3;
    occasionsTbl.layer.borderColor = [UIColor grayColor].CGColor;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        occasionsTbl.frame = CGRectMake(0, 0, customView.frame.size.width, customView.frame.size.height);
        
    }
    
    
    [customView addSubview:occasionsTbl];
    
    occasionsTbl.rowHeight = 40.0f;
    occasionsTbl.frame = [WebServiceUtility setTableViewheightOfTable:occasionsTbl ByArrayName:listOfOccasions];
    customView.frame = occasionsTbl.frame;
    customerInfoPopUp.view = customView;
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
        
        
        // commented by roja on 22/01/2019...
        //Reason UIPopoverController is deprecated in iOS 9.0, So using UIPopoverPresentationController && UIModalPresentationPopover(style).....
        
//        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
//        [popover presentPopoverFromRect:occasionTxt.frame inView:registrationView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
//        popOver= popover;
        
        
        
        // added by roja on 22/01/2019...
        customerInfoPopUp.modalPresentationStyle = UIModalPresentationPopover;
        
        presentationPopOverController = [customerInfoPopUp popoverPresentationController];
        presentationPopOverController.permittedArrowDirections = UIPopoverArrowDirectionUp;
        
//        CGRect temp = occasionTxt.frame;
//        temp.origin.y = temp.origin.y + temp.size.height/2;
        
        presentationPopOverController.sourceView = registrationView; // customerInfoPopUp.view  //
        presentationPopOverController.sourceRect = occasionTxt.frame; //occasionTxt.frame
        [self presentViewController:customerInfoPopUp animated:YES completion:nil];
        // upto here added by roja on 22/01/2019...
        
    }
    
    else {
   
    }
    
    UIGraphicsBeginImageContext(customView.frame.size);
    [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    customView.backgroundColor = [UIColor colorWithPatternImage:image];
    
    
    [occasionsTbl reloadData];
    
}

- (IBAction)placeOrder:(UIButton *)sender {
    
    if(checkBoxButton1.tag == 4 && checkBoxButton2.tag == 4){
        
        float y_axis = self.view.frame.size.height/2;
        NSString * mesg = @"Please select any one check box";
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:1];
    }
    
    else if (checkBoxButton1.tag == 4){
        
        isDetailsNotSharing = true;
        [self callingPlaceOrder];
        
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Do you want to book the table with out sharing details" preferredStyle:UIAlertControllerStyleAlert];
//
//        UIAlertAction * yes = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//            isDetailsNotSharing = true;
//            [self callingPlaceOrder];
//        }];
//        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
//        [alert addAction:cancel];
//        [alert addAction:yes];
//        [self presentViewController:alert animated:YES completion:nil];
    }
    else if (checkBoxButton2.tag == 4){
        
        if ([mobileNo.text length] == 0) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Please enter customer mobile number", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
            [alert show];
        }
       else if ([mobileNo.text length] < 10) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Enter valid mobile number", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
            [alert show];
        }
        else  if ([custName.text length]==0) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Enter customer name", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            
            isDirectTableBooking = true;
            [self callingPlaceOrder];
        }
    }
    else{
        @try {
            
            int selectedReservationTime = [[[reservationDate.text componentsSeparatedByString:@" "] [1] componentsSeparatedByString:@":"][0] intValue];
            
            
            if ([reservationModeTxt.text isEqualToString:@"Telephone"] && [mobileNo.text length]==0) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"phoneNoMissing", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([mobileNo.text length]>0 && [mobileNo.text length]<10) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ValidPhoneNo", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                [alert show];
                
            }
            else  if ([custName.text length]==0) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"customerNameMissing", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                [alert show];
            }
            
            else  if ([slotId.text length]==0) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"slotIdMissing", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                [alert show];
            }
            else  if ([occasionTxt.text length]==0) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"occasionMissing", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([noOfAdultsTxt.text intValue]==0 && [noOfChildsTxt.text intValue]==0) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"noOfCustomers", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([vegCountTxt.text intValue]>0 && ([noOfAdultsTxt.text intValue]!=([vegCountTxt.text intValue]+[nonvegCountTxt.text intValue]))) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"count_does_not_match", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([nonvegCountTxt.text intValue]>0 && ([noOfAdultsTxt.text intValue]!=([vegCountTxt.text intValue]+[nonvegCountTxt.text intValue]))) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"count_does_not_match", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([nonAlcoholCountTxt.text intValue]>0 && ([noOfAdultsTxt.text intValue] != ([alcoholCountTxt.text intValue]+[nonAlcoholCountTxt.text intValue]))) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"count_does_not_match", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([alcoholCountTxt.text intValue]>0 && ([noOfAdultsTxt.text intValue] != ([alcoholCountTxt.text intValue]+[nonAlcoholCountTxt.text intValue]))) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"count_does_not_match", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([childrenVegCount.text intValue]>0 && ([noOfChildsTxt.text intValue]>0 && ([noOfChildsTxt.text intValue]!=([childrenVegCount.text intValue]+[childrenNonVegCount.text intValue])))) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"children_count_not_matching", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                [alert show];
            }
            else if ([childrenNonVegCount.text intValue]>0 && ([noOfChildsTxt.text intValue]>0 && ([noOfChildsTxt.text intValue]!=([childrenVegCount.text intValue]+[childrenNonVegCount.text intValue])))) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"children_count_not_matching", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                [alert show];
            }
            else  if ([reservationModeTxt.text length]==0) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please select mode of reservation" message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                [alert show];
            }
            
            else if([genderTxt.text length] == 0){
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please select gender" message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                [alert show];
            }
            else if(([slotId.text caseInsensitiveCompare:@"Lunch"] == NSOrderedSame) && selectedReservationTime > 18){
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"select the slot id to dinner", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                [alert show];
            }
            else if(([slotId.text caseInsensitiveCompare:@"dinner"] == NSOrderedSame) && selectedReservationTime < 18){
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"select the slot id to lunch", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                [alert show];
                
            }
            else if ([customerEmailTxt.text length] && ![WebServiceUtility validateEmail:customerEmailTxt.text]) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please Enter valid Email Id" message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                [alert show];
            }
            else{
                [self addCustomerDetails];
            }
        }
        @catch (NSException *exception) {
        } @finally {
        }
    }
}

//- (IBAction)placeOrder:(UIButton *)sender {
//
//    Boolean isValidCall = true;
//    @try {
//
//        if ([reservationModeTxt.text isEqualToString:@"Telephone"] && [mobileNo.text length]==0) {
//
//            isValidCall = false;
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"phoneNoMissing", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//            [alert show];
//        }
//        else if ([mobileNo.text length]>0 && [mobileNo.text length]<10) {
//
//            isValidCall = false;
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ValidPhoneNo", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//            [alert show];
//
//        }
//        else  if ([custName.text length]==0) {
//
//            isValidCall = false;
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"customerNameMissing", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//            [alert show];
//        }
//
//        else  if ([slotId.text length]==0) {
//
//            isValidCall = false;
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"slotIdMissing", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//            [alert show];
//        }
//        else  if ([occasionTxt.text length]==0) {
//
//            isValidCall = false;
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"occasionMissing", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//            [alert show];
//        }
//        else if ([noOfAdultsTxt.text intValue]==0 && [noOfChildsTxt.text intValue]==0) {
//
//            isValidCall = false;
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"noOfCustomers", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//            [alert show];
//        }
//        else if ([vegCountTxt.text intValue]>0 && ([noOfAdultsTxt.text intValue]!=([vegCountTxt.text intValue]+[nonvegCountTxt.text intValue]))) {
//
//            isValidCall = false;
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"count_does_not_match", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//            [alert show];
//        }
//        else if ([nonvegCountTxt.text intValue]>0 && ([noOfAdultsTxt.text intValue]!=([vegCountTxt.text intValue]+[nonvegCountTxt.text intValue]))) {
//
//            isValidCall = false;
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"count_does_not_match", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//            [alert show];
//        }
//        else if ([nonAlcoholCountTxt.text intValue]>0 && ([noOfAdultsTxt.text intValue] != ([alcoholCountTxt.text intValue]+[nonAlcoholCountTxt.text intValue]))) {
//
//            isValidCall = false;
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"count_does_not_match", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//            [alert show];
//        }
//        else if ([alcoholCountTxt.text intValue]>0 && ([noOfAdultsTxt.text intValue] != ([alcoholCountTxt.text intValue]+[nonAlcoholCountTxt.text intValue]))) {
//
//            isValidCall = false;
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"count_does_not_match", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//            [alert show];
//        }
//        else if ([childrenVegCount.text intValue]>0 && ([noOfChildsTxt.text intValue]>0 && ([noOfChildsTxt.text intValue]!=([childrenVegCount.text intValue]+[childrenNonVegCount.text intValue])))) {
//
//            isValidCall = false;
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"children_count_not_matching", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//            [alert show];
//        }
//        else if ([childrenNonVegCount.text intValue]>0 && ([noOfChildsTxt.text intValue]>0 && ([noOfChildsTxt.text intValue]!=([childrenVegCount.text intValue]+[childrenNonVegCount.text intValue])))) {
//
//            isValidCall = false;
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"children_count_not_matching", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//            [alert show];
//        }
//        else  if ([reservationModeTxt.text length]==0) {
//
//            isValidCall = false;
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please Select mode of reservation" message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//            [alert show];
//        }
//        else if ([customerEmailTxt.text length]>0) {
//
//            if ([WebServiceUtility validateEmail:customerEmailTxt.text]) {
//
//            }
//            else {
//                isValidCall = false;
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please Enter valid Email Id" message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//                [alert show];
//            }
//        }
//        else if([slotId.text length] > 0 && [reservationDate.text length] > 0){
//
//            int selectedReservationTime = [[[reservationDate.text componentsSeparatedByString:@" "] [1] componentsSeparatedByString:@":"][0] intValue];
//
//            if(([slotId.text caseInsensitiveCompare:@"Lunch"] == NSOrderedSame) && selectedReservationTime > 18){
//
//                isValidCall = false;
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"select the slot id to dinner", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//                [alert show];
//            }
//            else if(([slotId.text caseInsensitiveCompare:@"dinner"] == NSOrderedSame) && selectedReservationTime < 18){
//
//                isValidCall = false;
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"select the slot id to lunch", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//                [alert show];
//
//            }
//        }
//    } @catch (NSException *exception) {
//
//    } @finally {
//
//        if(isValidCall)
//            [self addCustomerDetails];
//    }
//}

- (IBAction)clearDetails:(UIButton *)sender {
    
    @try {
        
        // added by roja on 08/02/2019...
//        if([mobileNo.text length] > 0 || [custName.text length] > 0 || [genderTxt.text length] > 0 || [slotId.text length] > 0 || [noOfChildsTxt.text length] > 0 ){
        
//            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"You will lose the data you entered.\n Do you want to clear?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
//            [alert show];
//        }
//        else{
//            specialInstructionsTxtView.text = @"";
//            // upto here added by roja on 08/02/2019...
//
//            for (UITextField *text in self.view.subviews) {
//                if ([text isKindOfClass:[UITextField class]]) {
//                    text.text = @"";
//                }
//                else if ([text isKindOfClass:[UIView class]]) {
//                    for (UITextField *textF in registrationView.subviews) {
//
//                        if ([textF isKindOfClass:[UITextField class]]) {
//                            textF.text = @"";
//                        }
//                    }
//                }
//            }
//        }
        
        
        if([mobileNo.text length] > 0 || [custName.text length] > 0 || [genderTxt.text length] > 0 || [slotId.text length] > 0 || [noOfChildsTxt.text length] > 0 ){

        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                       message:@"You will lose the data you entered.\n Do you want to clear?"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  
                                                                  specialInstructionsTxtView.text = @"";
                                                                  
                                                                  for (UITextField *text in self.view.subviews) {
                                                                      if ([text isKindOfClass:[UITextField class]]) {
                                                                          text.text = @"";
                                                                      }
                                                                      else if ([text isKindOfClass:[UIView class]]) {
                                                                          for (UITextField *textF in registrationView.subviews) {
                                                                              
                                                                              if ([textF isKindOfClass:[UITextField class]]) {
                                                                                  textF.text = @"";
                                                                              }
                                                                          }
                                                                      }
                                                                  }
                                                                  
                                                              }];
        
        UIAlertAction* noButton = [UIAlertAction
                                   actionWithTitle:@"NO"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       //Handle no, thanks button
                                   }];
        
        [alert addAction:defaultAction];
        [alert addAction:noButton];

        [self presentViewController:alert animated:YES completion:nil];
            
        }
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
    }
    
    
}

-(void) addCustomerDetails {
    
//    BOOL status = FALSE;
//    CheckWifi *WIFI = [[CheckWifi alloc]init];
//    status = [WIFI checkWifi];O
    
    if (!isOfflineService) {

        [HUD setHidden:YES];
        
        @try {
            
//            NSArray *loyaltyKeys = [NSArray arrayWithObjects:CUSTOMER_PHONE,CUSTOMER_MAIL,kFirstName,REQUEST_HEADER,kcategory, nil];
//
//            NSArray *loyaltyObjects = [NSArray arrayWithObjects:mobileNo.text,customerEmailTxt.text,custName.text,[RequestHeader getRequestHeader],custCategory, nil];
            
            NSArray *loyaltyKeys = [NSArray arrayWithObjects:CUSTOMER_PHONE,CUSTOMER_MAIL,kFirstName,REQUEST_HEADER,STATUS,@"lastName", nil];// //kcategory
            
            NSArray *loyaltyObjects = [NSArray arrayWithObjects:mobileNo.text,customerEmailTxt.text,custName.text,[RequestHeader getRequestHeader], ZERO_CONSTANT,lastNameTxt.text, nil];// custCategory
            
            NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
            
            NSError * err_;
            NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
            NSString * custDetails = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
            
            
            WebServiceController *controller = [[WebServiceController alloc] init];
            [controller setCustomerServiceDelegate:self];
            
//            [controller updateCustomerDetails:custDetails];
            
            [controller updateCustomerDetailsAsynchronousRequest:custDetails];
        }
        @catch (NSException *exception) {
            
            [self callingPlaceOrder];
        }
        @finally {
            [HUD setHidden:YES];
        }
        
    }
    // commented by roja on 09/01/2019 ... Here Offline work need to be done.
//    else {
//
//        NSArray *loyaltyKeys = [NSArray arrayWithObjects:kCUSTOMER_PHONE, kCUSTOMER_PIN,kCUSTOMER_STATUS,kCUSTOMER_EMAIL,kCUSTOMER_NAME,kCUSTOMER_STREET,kCUSTOMER_LOCALITY,kCUSTOMER_LOYALTY,kCUSTOMER_PHONEIDS,kCUSTOMER_CITY,REQUEST_HEADER,kCUSTOMER_CATEGORY, nil];
//
//        NSArray *loyaltyObjects = [NSArray arrayWithObjects:mobileNo.text,@"",@"false",customerEmailTxt.text,custName.text,@"",@"",@"",@"",@"",[RequestHeader getRequestHeader],@"", nil];
//        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
//        OfflineBillingServices    *offline = [[OfflineBillingServices alloc] init];
//        [offline saveCustomerDetails:dictionary_];
//        [self callingPlaceOrder];
//    }
    
}




//-(void)updateCustomerSuccessResponse:(NSDictionary *)successDictionary {

-(void)updateCustomerDetailsSuccessResponse:(NSDictionary *)sucessDictionary{

    BOOL result = [[sucessDictionary objectForKey:@"status"] boolValue];
    
    if (result) {
        //Sending mail......
        [self callingPlaceOrder];
    }
    else {
        [self callingPlaceOrder];
    }
}

//-(void)updateCustomerErrorResponse:(NSString *)failureString {

-(void)updateCustomerDetailsErrorResponse:(NSString *)errorResponse{
    [self callingPlaceOrder];
}


#pragma -mark place order service call

/**
 * @description     service call to place an order (service type restful)
 * @date
 * @method          callingPlaceOrder
 * @author          Sonali
 * @param
 * @param
 * @return
 *
 * @modified By     LastName key, isDirectTableBooking and isDetailsNotSharing booleans added
 * @modified On     02/04/2019
 *
 * @verified By
 * @verified On
 */

-(void)callingPlaceOrder {
    
//    BOOL status = false;
//    CheckWifi *WIFI = [[CheckWifi alloc]init];
//    status = [WIFI checkWifi];
    
    [HUD setHidden:NO];
    [HUD setLabelText:@"Please wait..."];
    [HUD show:YES];
    
    NSMutableArray *temparr = [[NSMutableArray alloc]init];

    NSDate *today = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString* currentdate = [f stringFromDate:today];
    
    //NSDictionary *dic1 = [NSDictionary dictionaryWithObject:reqDic forKey:@"requestHeader"];
    
    //            BOOL status = FALSE;
    //            NSDictionary *json1;
    
    @try {
        NSMutableDictionary *orderDetails = [[NSMutableDictionary alloc] init];
        
        [orderDetails setObject:currentdate forKey:Order_Date];
        [orderDetails setObject:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        
        [orderDetails setObject:@"immediate" forKey:ORDER_TYPE];
        [orderDetails setObject:custName.text forKey:CUSTOMER_NAME];
        [orderDetails setObject:self.customerEmailTxt.text forKey:CUSTOMER_MAIL];
        [orderDetails setObject:slotId.text forKey:SLOT_ID];
        [orderDetails setObject:reservationModeTxt.text forKey:RESERVATION_TYPE_ID];
        [orderDetails setObject:[NSNumber numberWithInt:[vegCountTxt.text intValue]] forKey:NO_OF_VEG_ADULTS];
        [orderDetails setObject:[NSNumber numberWithInt:[nonvegCountTxt.text intValue]] forKey:NO_OF_NON_VEG_ADULTS];
        [orderDetails setObject:[NSNumber numberWithInt:[childrenVegCount.text intValue]] forKey:NO_OF_VEG_CHILDREN];
        [orderDetails setObject:[NSNumber numberWithInt:[childrenNonVegCount.text intValue]] forKey:NO_OF_NON_VEG_CHILDREN];
        [orderDetails setObject:[NSNumber numberWithInt:[alcoholCountTxt.text intValue]] forKey:NO_OF_ALCOHOLIC];
        [orderDetails setObject:[NSNumber numberWithInt:[nonAlcoholCountTxt.text intValue]] forKey:NO_OF_NON_ALCOHOLIC];
        
        [orderDetails setObject:[NSNumber numberWithInt:[self.noOfAdultsTxt.text intValue]] forKey:ADULT_PAX];
        [orderDetails setObject:[NSNumber numberWithInt:[self.noOfChildsTxt.text intValue]] forKey:CHILD_PAX];
        [orderDetails setObject:[occasionsDic valueForKey:occasionTxt.text] forKey:OCCASION_ID];
        [orderDetails setObject:occasionTxt.text forKey:OCCASION_DESC];
        [orderDetails setObject:reservationDate.text forKey:RESERVATION_DATE_TIME_STR];
        [orderDetails setObject:specialInstructionsTxtView.text forKey:SPECIAL_INSTRUCTIONS];
        [orderDetails setObject:mobileNo.text forKey:MOBILE_NUMBER];
        [orderDetails setObject:[NSNumber numberWithFloat:0.0] forKey:Grand_Total_D_1];
        [orderDetails setObject:[NSNumber numberWithFloat:0.0] forKey:TAX];
        [orderDetails setObject:[NSNumber numberWithFloat:0.0] forKey:SUB_TOTAL];
        
        [orderDetails setObject:presentLocation forKey:STORE_LOCATION];
        
        [orderDetails setObject:temparr forKey:kItemDetails];
        [orderDetails setObject:genderTxt.text forKey:CUSTOMER_GENDER];
        [orderDetails setObject:vehicleNo.text forKey:CAR_NUMBER];
        // added by roja on 02/04/2019
        [orderDetails setObject:lastNameTxt.text forKey:CUSTOMER_LAST_NAME];
        [orderDetails setObject:[NSNumber numberWithBool:isDirectTableBooking] forKey:@"isDirectTableBooking"];
        [orderDetails setObject:[NSNumber numberWithBool:isDetailsNotSharing] forKey:@"isCustomerNotSharingDetails"];

        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:orderDetails options:0 error:&err];
        NSString * orderJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        if (!isOfflineService) {

            WebServiceController *controller =[[WebServiceController alloc] init];
            [controller setRestaurantBookingServiceDelegate:self];
            [controller createRestBooking:orderJsonString];
        }
        
        // Commented by roja on 09/01/2019.. offline work to be done here.
        
//        else {
//
//            isOfflineService = YES;
//
//            RestBookingServices *createOrder = [[RestBookingServices alloc] init];
//            BOOL isSaved =   [createOrder createOrder:orderDetails order_id:@""];
//
//            if (isSaved) {
//
//                [HUD setHidden:YES];
//
//
//                success = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Booking created successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                [success show];
//
//                SystemSoundID    soundFileObject1;
//                NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
//                self.soundFileURLRef = (CFURLRef) [tapSound retain];
//                AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
//                AudioServicesPlaySystemSound (soundFileObject1);
//            }
//            else {
//
//                [HUD setHidden:YES];
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Failure" message:@"Failed to place booking" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                [alert show];
//                [alert release];
//
//                SystemSoundID    soundFileObject1;
//                NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
//                self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
//                AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
//                AudioServicesPlaySystemSound (soundFileObject1);
//            }
//
//        }
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
        
        [HUD setHidden:YES];
        float y_axis = self.view.frame.size.height/2;//150
        NSString * mesg = @"Failed to place booking";
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
    }
    //        return [created_id copy];
}


-(void)createBookingsSuccess:(NSDictionary *)successDictionary {
    
    [HUD setHidden:YES];
    
        // added by roja on 26/03/2019  // For better results
        specialInstructionsTxtView.text = @"";
        for (UITextField *text in self.view.subviews) {
    
            if ([text isKindOfClass:[UITextField class]]) {
                text.text = @"";
            }
            else if ([text isKindOfClass:[UIView class]]) {
                for (UITextField *textF in registrationView.subviews) {
    
                    if ([textF isKindOfClass:[UITextField class]]) {
                        textF.text = @"";
                    }
                }
            }
        }
    
    float y_axis = self.view.frame.size.height - 120;
    NSString * mesg = @"Booking created successfully";
    
    [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:@"SUCCESS"  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
    
    if (isDirectTableBooking) {

        BookingWorkFlow * tableBookingsPage = [[BookingWorkFlow alloc]init];
        
        tableBookingsPage.orderRef = [successDictionary valueForKey:@"orderId"];
        tableBookingsPage.isDirectTableBooking = true;
        [self.navigationController pushViewController:tableBookingsPage animated:YES];
    }
    else
    [self goToBookingsPage];
    
}




-(void)createBookingsFailure:(NSString *)failureString {
    
    @try {
        float y_axis = self.view.frame.size.height/2;//150
        NSString * mesg = @"Failed to place booking";
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}

#pragma -mark text fiels delegates
-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField == vegCountTxt && [vegCountTxt.text intValue]>0) {
        
        nonvegCountTxt.text = [NSString stringWithFormat:@"%d",[noOfAdultsTxt.text intValue]-[vegCountTxt.text intValue]];
        if([nonvegCountTxt.text intValue]<0) {
            nonvegCountTxt.text = @"0";
        }
        
        if (!([alcoholCountTxt.text intValue]>0 || [nonAlcoholCountTxt.text intValue]>0)) {
            
            nonAlcoholCountTxt.text = noOfAdultsTxt.text;
        }
    }
    if (textField == nonvegCountTxt && [nonvegCountTxt.text intValue]>0) {
        
        vegCountTxt.text = [NSString stringWithFormat:@"%d",[noOfAdultsTxt.text intValue]-[nonvegCountTxt.text intValue]];
        if([vegCountTxt.text intValue]<0) {
            vegCountTxt.text = @"0";
        }
        
        if (!([alcoholCountTxt.text intValue]>0 || [nonAlcoholCountTxt.text intValue]>0)) {
            
            nonAlcoholCountTxt.text = noOfAdultsTxt.text;
        }
        
    }
    else if (textField == alcoholCountTxt && [alcoholCountTxt.text intValue]>0) {
        
        nonAlcoholCountTxt.text = [NSString stringWithFormat:@"%d",[noOfAdultsTxt.text intValue]-[alcoholCountTxt.text intValue]];
        if([nonAlcoholCountTxt.text intValue]<0) {
            nonAlcoholCountTxt.text = @"0";
        }
        
    }
    else if (textField == nonAlcoholCountTxt && [nonAlcoholCountTxt.text intValue]>0) {
        
        alcoholCountTxt.text = [NSString stringWithFormat:@"%d",[noOfAdultsTxt.text intValue]-[nonAlcoholCountTxt.text intValue]];
        if([alcoholCountTxt.text intValue]<0) {
            alcoholCountTxt.text = @"0";
        }
        
    }
    else if (textField == childrenVegCount && [childrenVegCount.text intValue]>0) {
        
        childrenNonVegCount.text = [NSString stringWithFormat:@"%d",[noOfChildsTxt.text intValue]-[childrenVegCount.text intValue]];
        if([childrenNonVegCount.text intValue]<0) {
            childrenNonVegCount.text = @"0";
        }
        
    }
    else if (textField == childrenNonVegCount && [childrenNonVegCount.text intValue]>0) {
        
        childrenVegCount.text = [NSString stringWithFormat:@"%d",[noOfChildsTxt.text intValue]-[childrenNonVegCount.text intValue]];
        if([childrenVegCount.text intValue]<0) {
            childrenVegCount.text = @"0";
        }
        
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    if (textField == mobileNo) {
        
        NSUInteger lengthOfString = string.length;
        for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {
            unichar character = [string characterAtIndex:loopIndex];
            if (character < 48) return NO; // 48 unichar for 0
            if (character > 57) return NO; // 57 unichar for 9
        }
        if ([textField.text length]>10) {
            
            return FALSE;
        }
        
    }
    else  if (textField == noOfAdultsTxt) {
        
        NSUInteger lengthOfString = string.length;
        for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {
            unichar character = [string characterAtIndex:loopIndex];
            if (character < 48) return NO; // 48 unichar for 0
            if (character > 57) return NO; // 57 unichar for 9
        }
        
        
    }
    else  if (textField == noOfChildsTxt) {
        
        NSUInteger lengthOfString = string.length;
        for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {
            unichar character = [string characterAtIndex:loopIndex];
            if (character < 48) return NO; // 48 unichar for 0
            if (character > 57) return NO; // 57 unichar for 9
        }
        
        
    }
    else  if (textField == vegCountTxt || textField == nonvegCountTxt || textField == childrenNonVegCount || textField == childrenVegCount || textField == alcoholCountTxt || textField == nonAlcoholCountTxt) {
        
        NSUInteger lengthOfString = string.length;
        for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {
            unichar character = [string characterAtIndex:loopIndex];
            if (character < 48) return NO; // 48 unichar for 0
            if (character > 57) return NO; // 57 unichar for 9
        }
        
        
    }
    
    
    return YES;
}
-(void)goToHome {
    
    
    [self backAction];
}

/**
 * @description  action to be performed when the back button is pressed
 * @date         04/04/19
 * @method       backAction
 * @author       Roja
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */
-(void)backAction {
    if ([mobileNo.text length]>0 || [slotId.text length]>0 || [custName.text length]>0) {
        
        // Commented by roja on 04/04/2019...
        // Dont delete it may be usefull....
        //        warning = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"You will lose the data you entered.\n Do you want to exit?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
        //        [warning show];
        
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                       message:@"You will lose the data you entered.\n Do you want to clear?"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  
                                                                  [self.navigationController popViewControllerAnimated:YES];

//                                                                  specialInstructionsTxtView.text = @"";
//
//                                                                  for (UITextField *text in self.view.subviews) {
//                                                                      if ([text isKindOfClass:[UITextField class]]) {
//                                                                          text.text = @"";
//                                                                      }
//                                                                      else if ([text isKindOfClass:[UIView class]]) {
//                                                                          for (UITextField *textF in registrationView.subviews) {
//
//                                                                              if ([textF isKindOfClass:[UITextField class]]) {
//                                                                                  textF.text = @"";
//                                                                              }
//                                                                          }
//                                                                      }
//                                                                  }
//                                                               ServiceOrders * serviceOrderPage =  [[ServiceOrders alloc]init];
//                                                                  [self.navigationController pushViewController:serviceOrderPage animated:YES];
                                                                  
                                                              }];
        
        UIAlertAction* noButton = [UIAlertAction
                                   actionWithTitle:@"NO"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       //Handle no, thanks button
                                   }];
        
        [alert addAction:defaultAction];
        [alert addAction:noButton];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }

}

/**
 * @description  action to be performed when the Booking created successfully
 * @date         25/03/2019
 * @method       goToBookingsPage
 * @author       Roja
 * @param
 * @param
 * @return       void
 * @verified By
 * @verified On
 */
-(void)goToBookingsPage{
    
    ServiceOrders * bookingsPage = [[ServiceOrders alloc] init];
    [self.navigationController pushViewController:bookingsPage animated:YES];
}

#pragma -mark alertview delegates
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView==warning) {
        
        if (buttonIndex==0) {
            
            OmniHomePage *home = [[OmniHomePage alloc] init];
            [self.navigationController pushViewController:home animated:YES];
        }
        else {
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        }
    }
    
    else if (alertView == success && buttonIndex == 0) {
        
        OmniHomePage *home = [[OmniHomePage alloc] init];
        [self.navigationController pushViewController:home animated:YES];
    }
}
/**
 * @description  check if vegetarian
 * @date         2/11/15
 * @method       isVegetarian
 * @author       Sonali
 * @param        sender of type UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 */
- (IBAction)isVegetarian:(UIButton *)sender {
    if (sender.tag == 0) {
        isVegBtn.tag = 1;
        isVeg = TRUE;
        [isVegBtn setImage:[UIImage imageNamed:@"checkbox_on_background.png"] forState:UIControlStateNormal];
        
    }
    else {
        isVegBtn.tag = 0;
        isVeg = FALSE;
        [isVegBtn setImage:[UIImage imageNamed:@"checkbox_off_background.png"] forState:UIControlStateNormal];
        
    }
}


- (IBAction)drinkRequired:(UIButton *)sender {
    if (sender.tag == 0) {
        _drinkReqBtn.tag = 1;
        isDrinkReq = TRUE;
        [_drinkReqBtn setImage:[UIImage imageNamed:@"checkbox_on_background.png"] forState:UIControlStateNormal];
        
    }
    else {
        _drinkReqBtn.tag = 0;
        isDrinkReq = FALSE;
        [_drinkReqBtn setImage:[UIImage imageNamed:@"checkbox_off_background.png"] forState:UIControlStateNormal];
        
    }
}
#pragma -mark textview delegates
-(void)textViewDidBeginEditing:(UITextView *)textView {
    if (textView == specialInstructionsTxtView) {
        
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-200, self.view.frame.size.width, self.view.frame.size.height);
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView {
    if (textView == specialInstructionsTxtView) {
        
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+200, self.view.frame.size.width, self.view.frame.size.height);
        
    }
}
/**
 * @description  Here we are returning the Text View when the user clicks on 'ENTER' button or clicks on 'RETURN' button..
 * @date         01/03/19
 * @method       textView:---  shouldChangeTextInRange:---  replacementText:---
 * @author       Roja
 * @param        UITextView
 * @param        NSRange NSString
 * @param        NSString
 * @return       BOOL
 * @verified By
 * @verified On
 */

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma -mark end of textview delegates



/**
 * @description  Here we are showing popUp for gelected gender button
 * @date         01/03/19
 * @method       selectGender
 * @author       Roja
 * @param        UIButton
 * @param
 * @param
 * @return      IBAction
 * @verified By
 * @verified On
 */
- (IBAction)selectGender:(UIButton *)sender {
    
    
    PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
    
    float tableHt = 0;
    
    if([genderArr count] && [genderArr count] <= 5) {
        tableHt =[genderArr count] * 40;
    }
    else if([genderArr count] && [genderArr count] > 5){
        
        tableHt = 5 * 40;
    }
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 250, tableHt)];
    customView.opaque = NO;
    customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    customView.layer.borderWidth = 2.0f;
    [customView setHidden:NO];
    
    genderTbl = [[UITableView alloc] init];
    genderTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [genderTbl setDataSource:self];
    [genderTbl setDelegate:self];
    [genderTbl.layer setBorderWidth:1.0f];
    genderTbl.layer.cornerRadius = 3;
    genderTbl.layer.borderColor = [UIColor grayColor].CGColor;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        genderTbl.frame = CGRectMake(0, 0, customView.frame.size.width, customView.frame.size.height);
        
    }
    
    
    [customView addSubview:genderTbl];
    
    //    genderTbl.rowHeight = 40.0f;
    //    genderTbl.frame = [WebServiceUtility setTableViewheightOfTable:genderTbl ByArrayName:genderArr];
    //    customView.frame = CGRectMake(0, 0, genderTbl.frame.size.width, genderTbl.frame.size.height);
    //
    customerInfoPopUp.view = customView;
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
        
        // commented by roja on 22/01/2019...
        //Reason UIPopoverController is deprecated in iOS 9.0, So using UIPopoverPresentationController && UIModalPresentationPopover(style).....
        
//        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
//        [popover presentPopoverFromRect:genderTxt.frame inView:registrationView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
//        popOver= popover;
        
     
        // added by roja on 22/01/2019...
        customerInfoPopUp.modalPresentationStyle = UIModalPresentationPopover;
        
        presentationPopOverController = [customerInfoPopUp popoverPresentationController];
        presentationPopOverController.permittedArrowDirections = UIPopoverArrowDirectionUp;
        
//        CGRect temp = genderTxt.frame;
//        temp.origin.y = temp.origin.y + temp.size.height/2;
        
        presentationPopOverController.sourceView = registrationView;  //customerInfoPopUp.view
        presentationPopOverController.sourceRect = genderTxt.frame; //genderTxt.frame
        [self presentViewController:customerInfoPopUp animated:YES completion:nil];
        // upto here added by roja on 22/01/2019...
        
    }
    
    else {
        
    }
    
    UIGraphicsBeginImageContext(customView.frame.size);
    [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    customView.backgroundColor = [UIColor colorWithPatternImage:image];
    
    [genderTbl reloadData];
    
}

/**
 * @description  Here we are handling success response of get customer details...
 * @date         01/03/19
 * @method       getCustomerDetailsSuccessResponse
 * @author       Roja
 * @param        NSDictionary
 * @param
 * @param
 * @return      void
 * @verified By
 * @verified On
 */
-(void)getCustomerDetailsSuccessResponse:(NSDictionary *)successDictionary{
    
    @try{
        customerInfoDic = [successDictionary mutableCopy];
        custCategory = [[successDictionary objectForKey:@"category"] mutableCopy];
        
        //NSArray *temp = [body.return_ componentsSeparatedByString:@"#"];
        mobileNo.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[successDictionary objectForKey:@"phone"] defaultReturn:@""]];
        customerEmailTxt.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[successDictionary objectForKey:@"email"] defaultReturn:@""]];
        custName.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[successDictionary objectForKey:@"name"] defaultReturn:@""]];
        lastNameTxt.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[successDictionary objectForKey:@"lastName"] defaultReturn:@""]];
        genderTxt.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[successDictionary objectForKey:@"gender"] defaultReturn:@""]];
        
    }
    @catch(NSException * exception){
        
    }
    @finally{
        [HUD setHidden:YES];
    }
}

/**
 * @description  Here we are handling error response of get customer details...
 * @date         01/03/19
 * @method       getCustomerDetailsErrorResponse
 * @author       Roja
 * @param        NSString
 * @param
 * @param
 * @return      void
 * @verified By
 * @verified On
 */
-(void)getCustomerDetailsErrorResponse:(NSString *)errorRespose{
    
    @try{
        
        float y_axis = self.view.frame.size.height - 120;
        NSString * mesg = @"New Customer";
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:1];
    }
    @catch(NSException * exception){
        
    }
    @finally{
        [HUD setHidden:YES];
    }
}

//-(void)dismissPopover:(id)sender
//{
//    [self dismissViewControllerAnimated:YES completion:NULL];
//    //or better yet
//    [self dismissModalViewControllerAnimated:YES];
//    //the latter works fine for Modal segues
//}
//

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



///**
// * @description  Here we are handling check box 1
// * @date         23/03/19
// * @method       checkBoxBtn1Action
// * @author       Roja
// * @param        UIButton
// * @param
// * @param
// * @return      IBAction
// * @verified By
// * @verified On
// */
- (IBAction)checkBoxBtn1Action:(UIButton *)sender {
    
    @try {
        AudioServicesPlaySystemSound (soundFileObject);
        
        if(checkBoxButton1.tag == 4 ){
            checkBoxButton1.tag = 2;
            [checkBoxButton1 setImage:[UIImage imageNamed:@"Credit_Deselect.png"] forState:UIControlStateNormal];
            
            //            [checkBoxButton2 setImage:[UIImage imageNamed:@"Credit_Select.png"] forState:UIControlStateNormal];
        }
        else{
            checkBoxButton1.tag = 4;
            [checkBoxButton1 setImage:[UIImage imageNamed:@"Credit_Select.png"] forState:UIControlStateNormal];
            
            //            [checkBoxButton2 setImage:[UIImage imageNamed:@"Credit_Deselect.png"] forState:UIControlStateNormal];
        }
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}
//
///**
// * @description  Here we are handling check box 2
// * @date         23/03/19
// * @method       checkBoxBtn2Action
// * @author       Roja
// * @param        UIButton
// * @param
// * @param
// * @return      IBAction
// * @verified By
// * @verified On
// */
- (IBAction)checkBoxBtn2Action:(id)sender {
    
    @try {
        AudioServicesPlaySystemSound (soundFileObject);
        
        if(checkBoxButton2.tag == 4 ){
            checkBoxButton2.tag = 2;
            [checkBoxButton2 setImage:[UIImage imageNamed:@"Credit_Deselect.png"] forState:UIControlStateNormal];
            
            //            [checkBoxButton1 setImage:[UIImage imageNamed:@"Credit_Select.png"] forState:UIControlStateNormal];
        }
        else{
            checkBoxButton2.tag = 4;
            [checkBoxButton2 setImage:[UIImage imageNamed:@"Credit_Select.png"] forState:UIControlStateNormal];
            
            //            [checkBoxButton1 setImage:[UIImage imageNamed:@"Credit_Deselect.png"] forState:UIControlStateNormal];
            
        }
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

#pragma -mark method used to display alert/warning messages....

/**
 * @description  adding the  alertMessage's based on input
 * @date         20/03/2019
 * @method       displayAlertMessage
 * @author       Roja
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

-(void)displayAlertMessage:(NSString *)message horizontialAxis:(float)xPostion  verticalAxis:(float)yPosition msgType:(NSString *)messageType conentWidth:(float)labelWidth contentHeight:(float)labelHeight isSoundRequired:(BOOL)soundStatus  timming:(float)noOfSecondsToDisplay noOfLines:(int)noOfLines {
    
    
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
 * @date         20/03/2019
 * @method       removeAlertMessages
 * @author       Roja
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)removeAlertMessages{
    @try {
        
        if(userAlertMessageLbl.tag == 4){
            
//            [self goToBookingsPage];
        }
        else if ([userAlertMessageLbl isDescendantOfView:self.view])
            [userAlertMessageLbl removeFromSuperview];
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"----exception in removing userAlertMessageLbl label------------%@",exception);
    }
}


@end
