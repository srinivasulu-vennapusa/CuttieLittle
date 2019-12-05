//
//  IssueGiftCouponFlow.m
//  OmniRetailer
//
//  Created by Roja on 6/13/19.
//

#import "IssueGiftCouponFlow.h"
#import "RequestHeader.h"
#import "Global.h"
#import "OmniHomePage.h"


@interface IssueGiftCouponFlow ()

@end

@implementation IssueGiftCouponFlow

@synthesize soundFileURLRef,soundFileObject;
@synthesize mobileNumberTF,customerIdTF, firstNameTF, lastNameTF, localityTF, customerCategoryTF, addressTF, cityTF, emailTF, couponProgramTF, couponValueTF, couponCodeTF, submitButton, cancelButton, addButton;

@synthesize snoLbl, couponValueTableLbl, couponNumTableLbl, issueDateLbl, expryDateLbl, statusLbl, actionLbl;

@synthesize mainView,giftCouponScrollView,giftCouponTableView;


/**
 * @description
 * @date         14/06/2019
 * @method       viewDidLoad
 * @author       Roja
 * @param
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    // Show the HUD
    [HUD show:YES];
    [HUD setHidden:YES];
    
    self.titleLabel.text = @"Issue Gift Coupon";

    mobileNumberTF.backgroundColor = [UIColor whiteColor];
    mobileNumberTF.borderStyle = UITextBorderStyleRoundedRect;
    
    customerIdTF.backgroundColor = [UIColor whiteColor];
    customerIdTF.borderStyle = UITextBorderStyleRoundedRect;
    
    firstNameTF.backgroundColor = [UIColor whiteColor];
    firstNameTF.borderStyle = UITextBorderStyleRoundedRect;
    
    lastNameTF.backgroundColor = [UIColor whiteColor];
    lastNameTF.borderStyle = UITextBorderStyleRoundedRect;
    
    localityTF.backgroundColor = [UIColor whiteColor];
    localityTF.borderStyle = UITextBorderStyleRoundedRect;
    
    customerCategoryTF.backgroundColor = [UIColor whiteColor];
    customerCategoryTF.borderStyle = UITextBorderStyleRoundedRect;
    
    addressTF.backgroundColor = [UIColor whiteColor];
    addressTF.borderStyle = UITextBorderStyleRoundedRect;
    
    cityTF.backgroundColor = [UIColor whiteColor];
    cityTF.borderStyle = UITextBorderStyleRoundedRect;
    
    emailTF.backgroundColor = [UIColor whiteColor];
    emailTF.borderStyle = UITextBorderStyleRoundedRect;
    
    couponProgramTF.backgroundColor = [UIColor whiteColor];
    couponProgramTF.borderStyle = UITextBorderStyleRoundedRect;
    
    couponValueTF.backgroundColor = [UIColor whiteColor];
    couponValueTF.borderStyle = UITextBorderStyleRoundedRect;
    
    couponCodeTF.backgroundColor = [UIColor whiteColor];
    couponCodeTF.borderStyle = UITextBorderStyleRoundedRect;
    [couponCodeTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    submitButton.backgroundColor = [UIColor grayColor];
    submitButton.layer.masksToBounds = YES;
    submitButton.layer.cornerRadius = 5.0f;
    
    cancelButton.backgroundColor = [UIColor grayColor];
    cancelButton.layer.masksToBounds = YES;
    cancelButton.layer.cornerRadius = 5.0f;
    
    addButton.backgroundColor = [UIColor grayColor];
    addButton.layer.masksToBounds = YES;
    addButton.layer.cornerRadius = 5.0f;
    
    snoLbl.layer.masksToBounds = YES;
    snoLbl.layer.cornerRadius = 5.0f;
    snoLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    
    couponValueTableLbl.layer.masksToBounds = YES;
    couponValueTableLbl.layer.cornerRadius = 5.0f;
    couponValueTableLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    
    couponNumTableLbl.layer.masksToBounds = YES;
    couponNumTableLbl.layer.cornerRadius = 5.0f;
    couponNumTableLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];

    issueDateLbl.layer.masksToBounds = YES;
    issueDateLbl.layer.cornerRadius = 5.0f;
    issueDateLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];

    expryDateLbl.layer.masksToBounds = YES;
    expryDateLbl.layer.cornerRadius = 5.0f;
    expryDateLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];

    statusLbl.layer.masksToBounds = YES;
    statusLbl.layer.cornerRadius = 5.0f;
    statusLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];

    actionLbl.layer.masksToBounds = YES;
    actionLbl.layer.cornerRadius = 5.0f;
    actionLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    
    mainView.backgroundColor = [UIColor colorWithRed:45/255.0 green:45/255.0 blue:45/255.0 alpha:1.0];
    
    mobileNumberTF.delegate = self;
    [mobileNumberTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    
    
    giftCouponCodeDetailsTable = [[UITableView alloc] init];
    giftCouponCodeDetailsTable.backgroundColor = [UIColor colorWithRed:0.939f green:0.939f blue:0.939f alpha:1.0];
    giftCouponCodeDetailsTable.layer.borderColor = [UIColor blackColor].CGColor;
    giftCouponCodeDetailsTable.layer.cornerRadius = 4.0f;
    giftCouponCodeDetailsTable.layer.borderWidth = 1.0f;
    giftCouponCodeDetailsTable.dataSource = self;
    giftCouponCodeDetailsTable.delegate = self;
    
    [mainView addSubview:giftCouponCodeDetailsTable];
    
    // allocation of selected gift coupon arrary
    selectGiftCouponArr = [[NSMutableArray alloc]init];
    
    giftCouponTableView.dataSource = self;
    giftCouponTableView.delegate = self;
    
}


-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];

    [self getGiftCouponDetails];
}


/**
 * @description  Here we are calling 'GiftCouponServices' to get available getGiftCouponDetails....
 * @date         14/06/2019
 * @method       getGiftCouponDetails
 * @author       Roja
 * @param
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

-(void)getGiftCouponDetails{
    
    @try {
        [HUD show: YES];
        [HUD setHidden:NO];
        [HUD setLabelText:NSLocalizedString(@"please_wait..",nil)];
        
        NSArray * giftCouponKeys = @[@"requestHeader", @"startIndex", MAX_RECORDS, @"locations",STATUS];//STATUS locations
        
        NSArray * giftCouponObjects = @[[RequestHeader getRequestHeader], NEGATIVE_ONE, @"1000", presentLocation, @"Active"];//@"active"
        
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:giftCouponObjects forKeys:giftCouponKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * giftCouponRequestStr = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        
        WebServiceController *webServiceContr = [WebServiceController new];
        webServiceContr.giftCouponServicesDelegate = self;
        [webServiceContr getAvailableGiftCouponDetails:giftCouponRequestStr];
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        
    } @finally {
        
    }
}


/**
 * @description
 * @date         14/06/2019
 * @method       getGiftCouponDetailsSuccessReponse
 * @author       Roja
 * @param
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

- (void)getGiftCouponDetailsSuccessReponse:(NSDictionary *)sucessDictionary{

    @try {
        
        NSArray * giftCouponsArray = [self checkGivenValueIsNullOrNil:[sucessDictionary valueForKey:@"giftCouponsList"] defaultReturn:@""];

        giftCouponDetailsArr = [[NSMutableArray alloc]init];

        for (NSDictionary * dic in giftCouponsArray) {
            
            NSMutableDictionary * tempDic = [[NSMutableDictionary alloc]init];
            
            [tempDic setValue:[dic valueForKey:@"promoName"] forKey:@"promoName"];
            [tempDic setValue:[dic valueForKey:@"unitCashValue"] forKey:@"unitCashValue"];
            [tempDic setValue:[dic valueForKey:@"status"] forKey:@"status"];
            [tempDic setValue:[dic valueForKey:@"createdOn"] forKey:@"createdOn"];
            [tempDic setValue:[dic valueForKey:@"expiryDate"] forKey:@"expiryDate"];
            [tempDic setValue:[dic valueForKey:@"couponProgramCode"] forKey:@"couponProgramCode"];
            [tempDic setValue:[dic valueForKey:@"assignedStatus"] forKey:@"assignedStatus"];
            [tempDic setValue:[dic valueForKey:@"multiples"] forKey:@"multiples"];
            [tempDic setValue:[dic valueForKey:@"noOfCliams"] forKey:@"noOfCliams"];
            [tempDic setValue:[dic valueForKey:@"otpRequirement"] forKey:@"otpRequirement"];
            
            [giftCouponDetailsArr addObject:tempDic];
        }
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
    }

}



/**
 * @description
 * @date         14/06/2019
 * @method       getGiftCouponDetailsErrorResponse
 * @author       Roja
 * @param
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

- (void)getGiftCouponDetailsErrorResponse:(NSString *)error{
    
    @try {
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
    }
}




- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return true;
}

/**
 * @description
 * @date         14/06/2019
 * @method       textFieldDidChange
 * @author       Roja
 * @param
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
- (void)textFieldDidChange:(UITextField *)textField {
    
    if (textField == mobileNumberTF) {
        
        if ([mobileNumberTF.text length]==10) {

            [self getCustomerDetails];
        }
    }
    
    else if(textField == couponCodeTF){
        
        if([couponCodeTF.text length] >= 3){
            [self getGiftCouponCodeDetailsList];
        }
    }
    
}



/**
 * @description  It is one of the UITextField delegate method used to hide the keyboard..
 * @date         16/06/2019
 * @method       textFieldShouldReturn
 * @author       roja
 * @param
 * @param        UITextField
 * @return       BOOL
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

/**
 * @description  Here we are calling 'GiftCouponServices' to get Gift Coupons By Search Criteria....
 * @date         18/06/2019
 * @method       getGiftCouponCodeDetailsList
 * @author       Roja
 * @param
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

-(void)getGiftCouponCodeDetailsList{
    
    @try {
        [HUD show: YES];
        [HUD setHidden:NO];
        [HUD setLabelText:NSLocalizedString(@"please_wait..",nil)];
        
        NSArray * giftCouponCodeKeys = @[@"requestHeader",@"searchCriteria",@"startIndex",@"couponProgramCode"];
        
        NSArray * giftCouponCodeObj = @[[RequestHeader getRequestHeader],couponCodeTF.text,ZERO_CONSTANT,couponPromoCodeStr];
        
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:giftCouponCodeObj forKeys:giftCouponCodeKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * giftCouponCodeRequestStr = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceContr = [WebServiceController new];
        webServiceContr.giftCouponServicesDelegate = self;
        [webServiceContr getGiftCouponsBySearchCriteria:giftCouponCodeRequestStr];
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        
    } @finally {
        
    }
}


/**
 * @description
 * @date         16/06/2019
 * @method       getGiftCouponsSearchErrorResponse
 * @author
 * @param        NSString
 * @param
 * @return       void
 *
 * @modified BY  Roja
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (void)getGiftCouponsSearchErrorResponse:(NSString *)errorResponse{
    
    @try {
        NSString * errMsg = errorResponse;
        
        [self displayAlertMessage:errMsg horizontialAxis:(self.view.frame.size.width - 350)/2  verticalAxis:(self.view.frame.size.height)/2  msgType:@"" conentWidth:350 contentHeight:100 isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
    }
}



/**
 * @description
 * @date         16/06/2019
 * @method       getGiftCouponsBySearchSuccessResponse
 * @author          roja
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
- (void)getGiftCouponsBySearchSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        giftCouponCodeDetailsArray = [[NSMutableArray alloc]init];

        NSArray * giftCouponCodeArr  = [successDictionary valueForKey:@"giftCoupons"];
        
        for (NSDictionary * giftCouponDic in giftCouponCodeArr) {
            
            if(![[giftCouponDic valueForKey:@"assignedStatus"] boolValue]){
             
                NSMutableDictionary * tempDic =  [[NSMutableDictionary alloc] init];
                
                [tempDic setValue:[self checkGivenValueIsNullOrNil:[giftCouponDic valueForKey:@"couponCode"] defaultReturn:@""] forKey:@"couponCode"];
                
                [giftCouponCodeDetailsArray addObject:tempDic];

            }
            
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
        
        [self giftCouponCodeDetailsPopUp];
        [giftCouponCodeDetailsTable reloadData];
    }
}



/**
 * @description  Here we are displaying the Pop up view on selection of gift coupon details button..
 * @date
 * @method       giftCouponCodeDetailsPopUp
 * @author
 * @param        NSString
 * @param
 * @return       void
 *
 * @modified BY  Roja
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (void)giftCouponCodeDetailsPopUp{

    float couponCodeTblHeight = 0;
    
    if ([giftCouponCodeDetailsArray count] && giftCouponCodeDetailsArray != nil) {
        
        couponCodeTblHeight =  [giftCouponCodeDetailsArray count] * 40;
        
        if ([giftCouponCodeDetailsArray count] >= 3) {
            
            couponCodeTblHeight = 3 * 40;
        }
        
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        
        UIView * couponCodeView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, couponCodeTF.frame.size.width, couponCodeTblHeight)];
        couponCodeView.opaque = NO;
        couponCodeView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        couponCodeView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        couponCodeView.layer.borderWidth = 2.0f;
        [couponCodeView setHidden:NO];
        
        giftCouponCodeDetailsTable = [[UITableView alloc] init];
        giftCouponCodeDetailsTable.backgroundColor = [UIColor colorWithRed:0.939f green:0.939f blue:0.939f alpha:1.0];
        giftCouponCodeDetailsTable.layer.borderColor = [UIColor blackColor].CGColor;
        giftCouponCodeDetailsTable.layer.cornerRadius = 4.0f;
        giftCouponCodeDetailsTable.layer.borderWidth = 1.0f;
        giftCouponCodeDetailsTable.dataSource = self;
        giftCouponCodeDetailsTable.delegate = self;
        giftCouponCodeDetailsTable.bounces = FALSE;
        giftCouponCodeDetailsTable.frame = CGRectMake(0.0, 0.0, couponCodeView.frame.size.width, couponCodeView.frame.size.height);
        
        [couponCodeView addSubview:giftCouponCodeDetailsTable];
        customerInfoPopUp.view = couponCodeView;
        
        
        customerInfoPopUp.preferredContentSize =  CGSizeMake(couponCodeView.frame.size.width, couponCodeView.frame.size.height);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        
        [popover presentPopoverFromRect:couponCodeTF.frame inView:mainView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        
        couponCodePopOver= popover;
    }
}


/**
 * @description  Here we are calling 'customerService' to get Customer Details..
 * @date         14/06/2019
 * @method       getCustomerDetails
 * @author       Roja
 * @param
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
-(void)getCustomerDetails{
    
    @try{
        [HUD setHidden:NO];
        
        NSArray * customerDetailsKeys = [NSArray arrayWithObjects:@"email",@"mobileNumber",REQUEST_HEADER, nil];
        NSArray *customerDetailsObjects = [NSArray arrayWithObjects:@"",mobileNumberTF.text,[RequestHeader getRequestHeader], nil];
        
        NSDictionary *requestDic = [NSDictionary dictionaryWithObjects:customerDetailsObjects forKeys:customerDetailsKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:requestDic options:0 error:&err_];
        NSString * RequestString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        WebServiceController * controller = [WebServiceController new];
        [controller setCustomerServiceDelegate:self];
        [controller getCustomerDetails:RequestString];
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
    }
}



/**
 * @description  Here we are handling success response of get customer details
 * @date         14/06/2019
 * @method       getCustomerDetailsSuccessResponse
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
- (void)getCustomerDetailsSuccessResponse:(NSDictionary *)sucessDictionary{
    
    @try {
        
        emailTF.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[sucessDictionary valueForKey:@"email"] defaultReturn:@""]];
        firstNameTF.text =  [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[sucessDictionary valueForKey:@"name"] defaultReturn:@""]];//
        customerIdTF.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[sucessDictionary valueForKey:@"customerId"] defaultReturn:@""]];
        lastNameTF.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[sucessDictionary valueForKey:@"lastName"] defaultReturn:@""]];
        localityTF.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[sucessDictionary valueForKey:@"locality"] defaultReturn:@""]];
        addressTF.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[sucessDictionary valueForKey:@"street"] defaultReturn:@""]];
        cityTF.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[sucessDictionary valueForKey:@"city"] defaultReturn:@""]];
        
//        if ([[sucessDictionary valueForKey:@"phone"] isKindOfClass:[NSNull class]] || [[sucessDictionary valueForKey:@"phone"] isEqualToString:@""]) { // email may also need to check
//            if ((mobileNumberTF.text).length >= 10) {
//                [self provideCustomerRatingfor:NEW_CUSTOMER];
//                return;
//            }
//        }
//        else{
//            if ((phNotxt.text).length >= 10) {
//
//                if (!([[sucessDictionary valueForKey:@"category"] isKindOfClass:[NSNull class]]) && ![[sucessDictionary valueForKey:@"category"] isEqualToString:@""]) {
//
//                    [self provideCustomerRatingfor:[NSString stringWithFormat:@"%@",[sucessDictionary valueForKey:@"category"]]];
//                    return;
//                }
//                else {
//                    [self provideCustomerRatingfor:EXISTING_CUSTOMER];
//                    return;
//                }
//            }
//        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
    }
}



/**
 * @description  Here we are handling error response of get customer details
 * @date         14/06/2019
 * @method       getCustomerDetailsErrorResponse
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
- (void)getCustomerDetailsErrorResponse:(NSString *)errorResponse{
    
    @try {
        
        [self displayAlertMessage:@"New Customer" horizontialAxis:(self.view.frame.size.width - 350)/2  verticalAxis:(self.view.frame.size.height)/2  msgType:@"Error" conentWidth:350 contentHeight:50 isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
    }
}




/**
 * @description  Here we are adding the selected gift coupon to the row
 * @date         16/06/2019
 * @method       addGiftCouponBtnAction
 * @author       Roja
 * @param
 * @param        UIButton
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

- (IBAction)addGiftCouponBtnAction:(id)sender {
    
    @try {
        
        if ([couponProgramTF.text length] == 0) {
            
            [self displayAlertMessage:@"Please select any gift coupon" horizontialAxis:(self.view.frame.size.width - 350)/2  verticalAxis:(self.view.frame.size.height)/2  msgType:@"Error" conentWidth:350 contentHeight:50 isSoundRequired:YES timming:2.0 noOfLines:2];
        }
        else if ([couponCodeTF.text length] == 0 || [couponCodeTF.text length] != 16) {
            
            [self displayAlertMessage:@"Please enter coupon code" horizontialAxis:(self.view.frame.size.width - 350)/2  verticalAxis:(self.view.frame.size.height)/2  msgType:@"Error" conentWidth:350 contentHeight:50 isSoundRequired:YES timming:2.0 noOfLines:2];
        }
        else {
            
            if ([giftCouponDetailsArr count]) {
                
                NSMutableDictionary * tempDic = [[NSMutableDictionary alloc]init];
                NSDictionary * selectedGiftCouponDic = [giftCouponDetailsArr objectAtIndex:selectedCouponNoPosition];
                
                BOOL couponCodeExists = false;
                
                for (NSDictionary * existingGiftCouponDic in selectGiftCouponArr) {
                    
                    if ([[existingGiftCouponDic valueForKey:@"couponCode"] isEqualToString:couponCodeTF.text]) {
                        
                        couponCodeExists = true;
                    }
                }
                if (couponCodeExists) {
                    
                    NSString * errMsg = @"Coupon already added";
                    [self displayAlertMessage:errMsg horizontialAxis:(self.view.frame.size.width - 350)/2  verticalAxis:(self.view.frame.size.height)/2  msgType:@"Error" conentWidth:350 contentHeight:50 isSoundRequired:YES timming:2.0 noOfLines:2];
                }
                else{
                    [tempDic setValue:[selectedGiftCouponDic valueForKey:@"createdOn"] forKey:@"createdOnStr"];
                    [tempDic setValue:[selectedGiftCouponDic valueForKey:@"expiryDate"] forKey:@"expiryDateStr"];
                    [tempDic setValue:[selectedGiftCouponDic valueForKey:@"status"] forKey:@"status"];
                    [tempDic setValue:[selectedGiftCouponDic valueForKey:@"promoName"] forKey:@"promoName"];
                    [tempDic setValue:[selectedGiftCouponDic valueForKey:@"unitCashValue"] forKey:@"unitCashValue"];
                    [tempDic setValue:[selectedGiftCouponDic valueForKey:@"couponProgramCode"] forKey:@"couponProgramCode"];
//                    [tempDic setValue:[selectedGiftCouponDic valueForKey:@"couponProgramCode"] forKey:@"voucherPrgCode"];
                    [tempDic setValue:couponCodeTF.text forKey:@"couponCode"];
                    
                    [tempDic setValue:[selectedGiftCouponDic valueForKey:@"assignedStatus"] forKey:@"assignedStatus"];
                    [tempDic setValue:[selectedGiftCouponDic valueForKey:@"multiples"] forKey:@"multiples"];
                    [tempDic setValue:[selectedGiftCouponDic valueForKey:@"noOfCliams"] forKey:@"noOfCliams"];
                    [tempDic setValue:[selectedGiftCouponDic valueForKey:@"otpRequirement"] forKey:@"otpRequirement"];
                    [tempDic setValue:0 forKey:@"totalCoupons"];
                    [tempDic setValue:0 forKey:@"totolGiftCoupons"];
                    [tempDic setValue:0 forKey:@"noOfCoupons"];

                    [selectGiftCouponArr addObject:tempDic];
                }
                
                [giftCouponTableView reloadData];
                [giftCouponTableView setHidden:NO];
            }
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        couponCodeTF.text = @"";
        couponValueTF.text = @"";
        couponValueTF.text = @"";
    }
    
}


/**
 * @description  Issuing the coupon to customer
 * @date         18/06/2019
 * @method       submitBtn
 * @author
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
- (IBAction)submitBtn:(id)sender {
    
    @try {
        
        if([mobileNumberTF.text length] != 10){
            
            [mobileNumberTF becomeFirstResponder];
            
            [self displayAlertMessage:@"Please enter valid mobile number" horizontialAxis:(self.view.frame.size.width - 350)/2  verticalAxis:(self.view.frame.size.height)/2  msgType:@"Alert" conentWidth:350 contentHeight:50 isSoundRequired:YES timming:2.0 noOfLines:2];
        }
        else if([firstNameTF.text length] == 0){
            
            [firstNameTF becomeFirstResponder];
            
            [self displayAlertMessage:@"Please enter your name" horizontialAxis:(self.view.frame.size.width - 350)/2  verticalAxis:(self.view.frame.size.height)/2  msgType:@"Alert" conentWidth:350 contentHeight:50 isSoundRequired:YES timming:2.0 noOfLines:2];
        }
        else if([emailTF.text length] && ![WebServiceUtility validateEmail:emailTF.text]){
            
            [emailTF becomeFirstResponder];
            [self displayAlertMessage:@"Please enter valid email id" horizontialAxis:(self.view.frame.size.width - 350)/2  verticalAxis:(self.view.frame.size.height)/2  msgType:@"Alert" conentWidth:350 contentHeight:50 isSoundRequired:YES timming:2.0 noOfLines:2];
        }
        else if([selectGiftCouponArr count] == 0 || selectGiftCouponArr == nil){
            
            [self displayAlertMessage:@"Please add atleast one gift voucher" horizontialAxis:(self.view.frame.size.width - 350)/2  verticalAxis:(self.view.frame.size.height)/2  msgType:@"Alert" conentWidth:350 contentHeight:100 isSoundRequired:YES timming:2.0 noOfLines:2];
        }
        else{
            
            AudioServicesPlaySystemSound (soundFileObject);
            
            [HUD show: YES];
            [HUD setHidden:NO];
            [HUD setLabelText:NSLocalizedString(@"please_wait..",nil)];
            
            NSMutableDictionary * customerDetailsDic = [[NSMutableDictionary alloc]init];

            [customerDetailsDic setValue:firstNameTF.text forKey:@"name"];
            [customerDetailsDic setValue:mobileNumberTF.text forKey:@"phone"];
            [customerDetailsDic setValue:mobileNumberTF.text forKey:@"mobileNumber"];
            [customerDetailsDic setValue:emailTF.text forKey:@"email"];
            [customerDetailsDic setValue:localityTF.text forKey:@"locality"];
            [customerDetailsDic setValue:cityTF.text forKey:@"city"];
            [customerDetailsDic setValue:lastNameTF.text forKey:@"lastName"];
            [customerDetailsDic setValue:addressTF.text forKey:@"street"];
            // customerID && customer category has to send..
            
//            NSArray * issueVoucherKeys = @[@"requestHeader",@"customerObj",@"locations",@"couponsList",@"mobileNumber",@"multiples",@"noOfCliams",@"otpRequirement",@"startIndex","totalCoupons",@"totolGiftCoupons",@"assignedStatus"];//@
//
//            NSArray * issueVoucherObjects = @[[RequestHeader getRequestHeader],customerDetailsDic,presentLocation,selectGiftCouponArr,mobileNumberTF.text,[NSNumber numberWithBool:0], [NSNumber numberWithInt:0], [NSNumber numberWithBool:0], NEGATIVE_ONE,@"0",@"0",[NSNumber numberWithBool:0]];//
            
            int noOfCoupons = (int)[selectGiftCouponArr count];
            
            for (NSDictionary * tempDic in selectGiftCouponArr) {
                [tempDic setValue:[NSNumber numberWithInt:noOfCoupons] forKey:@"noOfCoupons"];
            }
            
            NSArray * issueVoucherKeys = @[@"requestHeader",@"customerObj",@"locations",@"couponsList",@"assignedStatus"];
            
            NSArray * issueVoucherObjects = @[[RequestHeader getRequestHeader],customerDetailsDic,presentLocation,selectGiftCouponArr,[NSNumber numberWithBool:1]];//noOfCoupons

            
            NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:issueVoucherObjects forKeys:issueVoucherKeys];
            
            NSError * err_;
            NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
            NSString * issueGiftVoucherStr = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
            
            WebServiceController * webServContlr = [[WebServiceController alloc] init];
            webServContlr.giftCouponServicesDelegate = self;
            [webServContlr issueGiftCouponToCustomer:issueGiftVoucherStr];
        }
        
    } @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
        
    } @finally {
        
    }
}



/**
 * @description
 * @date         18/06/2019
 * @method       issueGiftCouponsToCustomerSuccessResponse
 * @author
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
- (void)issueGiftCouponsToCustomerSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        
        [self displayAlertMessage:@"Coupon issued successfully" horizontialAxis:(self.view.frame.size.width - 350)/2  verticalAxis:(self.view.frame.size.height)/2  msgType:@"Alert" conentWidth:350 contentHeight:50 isSoundRequired:YES timming:2.0 noOfLines:2];
        
            [self backAction];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
    }
}


/**
 * @description
 * @date         18/06/2019
 * @method       issueGiftCouponsToCustomerErrorResponse
 * @author
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
- (void)issueGiftCouponsToCustomerErrorResponse:(NSString *)errorResponse{
    
    @try {
        
          [self displayAlertMessage:errorResponse horizontialAxis:(self.view.frame.size.width - 350)/2  verticalAxis:(self.view.frame.size.height)/2  msgType:@"Alert" conentWidth:350 contentHeight:100 isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
    }
    
}




/**
 * @description  Goes to back page
 * @date         18/06/2019
 * @method       cancelBtn
 * @author
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
- (IBAction)cancelBtn:(id)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    [self.navigationController popViewControllerAnimated:YES];
}


/**
 * @description  Here we are displaying the pop up view on selection of gift coupons
 * @date         14/06/2019
 * @method       couponProgramBtnAction
 * @author
 * @param
 * @param        NSString
 * @return       void
 *
 * @modified BY  Roja
 * @reason       Pop up need to display only when giftCouponDetailsArr has count.
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (IBAction)couponProgramBtnAction:(id)sender {
    
    @try {

        // added by roja on 06/03/2019...
        float couponTblHeight = 0;

        if ([giftCouponDetailsArr count] && giftCouponDetailsArr != nil) {

            couponTblHeight =  [giftCouponDetailsArr count] * 40;

            if ([giftCouponDetailsArr count] >= 3) {

                couponTblHeight = 3 * 40;
            }
        }
        //upto here added by roja on 06/03/2019...

        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);

        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];

        UIView *editPriceView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, couponProgramTF.frame.size.width, couponTblHeight)];//
        editPriceView.opaque = NO;
        editPriceView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        editPriceView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        editPriceView.layer.borderWidth = 2.0f;
        [editPriceView setHidden:NO];

        giftCouponDetailsTable = [[UITableView alloc] init];
        giftCouponDetailsTable.backgroundColor = [UIColor colorWithRed:0.939f green:0.939f blue:0.939f alpha:1.0];
        giftCouponDetailsTable.layer.borderColor = [UIColor blackColor].CGColor;
        giftCouponDetailsTable.layer.cornerRadius = 4.0f;
        giftCouponDetailsTable.layer.borderWidth = 1.0f;
        giftCouponDetailsTable.dataSource = self;
        giftCouponDetailsTable.delegate = self;
        giftCouponDetailsTable.bounces = FALSE;
        giftCouponDetailsTable.frame = CGRectMake(0.0, 0.0, editPriceView.frame.size.width, editPriceView.frame.size.height);

        [editPriceView addSubview:giftCouponDetailsTable];
        customerInfoPopUp.view = editPriceView;


        customerInfoPopUp.preferredContentSize =  CGSizeMake(editPriceView.frame.size.width, editPriceView.frame.size.height);
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        [popover presentPopoverFromRect:couponProgramTF.frame inView:mainView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        couponProgramPopOver= popover;


    } @catch (NSException *exception) {

    } @finally {

    }
    
}


/**
 * @description  Here we are checkings null values.. if input is Null or nill we will return default.
 * @date         14/06/2019...
 * @method       checkGivenValueIsNullOrNil:--   defaultReturn:--
 * @author       roja
 * @param        NSString
 * @param        id
 * @return       id
 *
 * @modified BY
 * @reason
 *
 * @return
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




#pragma mark Table view methods

// Customize the number of rows in the table view.
/**
 * @description  It is one of the UITableView delegate method used to Customize the number of rows in the table view...
 * @date         17/06/2019
 * @method       tableView:-- numberOfRowsInSection:--
 * @author       roja
 * @param        UITableView
 * @param        NSInteger
 * @return       NSInteger
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if(tableView == giftCouponDetailsTable){
        return giftCouponDetailsArr.count;
    }
    else if(tableView == giftCouponCodeDetailsTable){
        return giftCouponCodeDetailsArray.count;
    }
    else if (tableView == giftCouponTableView) {
        return selectGiftCouponArr.count;
    }
    else{
        return 0;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}


// Customize the appearance of table view cells.
/**
 * @description  It is one of the UITableView delegate method used to Customize the appearance of table view cells.
 * @date         17/06/2019...
 * @method       tableView:--  cellForRowAtIndexPath:--
 * @author       roja
 * @param        UITableView
 * @param        NSIndexPath
 * @return       UITableViewCell
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
        cell.frame = CGRectZero;
    }
    
    
    
    if (tableView == giftCouponTableView) {
        
        static NSString *hlCellID = @"hlCellID";
        
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
        
        if ((hlcell.contentView).subviews){
            
            for (UIView *subview in (hlcell.contentView).subviews) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                       initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID] ;
            hlcell.accessoryType = UITableViewCellAccessoryNone;
        }
        tableView.separatorColor = [UIColor clearColor];
        
        hlcell.backgroundColor = [UIColor clearColor];
        //        [UIColor colorWithRed:45/255.0 green:45/255.0 blue:45/255.0 alpha:1.0];
        
        @try {
            UILabel *sno = [[UILabel alloc] init] ;
            sno.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];
            sno.backgroundColor = [UIColor clearColor];
            sno.textColor = [UIColor whiteColor];
            sno.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
            sno.textAlignment=NSTextAlignmentCenter;
            
            //            sno.layer.borderWidth = 1.5;
            //            sno.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            
            
            UILabel *voucherValLbl = [[UILabel alloc] init] ;
            voucherValLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];
            voucherValLbl.backgroundColor = [UIColor clearColor];
            voucherValLbl.textColor = [UIColor whiteColor];
            voucherValLbl.textAlignment=NSTextAlignmentCenter;
            
            UILabel *noOfVoucherLbl = [[UILabel alloc] init] ;
            noOfVoucherLbl.backgroundColor = [UIColor clearColor];
            noOfVoucherLbl.textAlignment = NSTextAlignmentCenter;
            //            noOfVoucherLbl.numberOfLines = 2;
            noOfVoucherLbl.textColor = [UIColor whiteColor];
            noOfVoucherLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:14];
            
            UILabel * issuedDateLabel = [[UILabel alloc] init] ;
            issuedDateLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];
            issuedDateLabel.backgroundColor = [UIColor clearColor];
            issuedDateLabel.textColor = [UIColor whiteColor];
            issuedDateLabel.textAlignment=NSTextAlignmentCenter;
            issuedDateLabel.text = @"-";
            issuedDateLabel.numberOfLines = 2;
            
            UILabel *expiryDateLabel = [[UILabel alloc] init] ;
            expiryDateLabel.backgroundColor = [UIColor clearColor];
            expiryDateLabel.textAlignment = NSTextAlignmentCenter;
            expiryDateLabel.numberOfLines = 2;
            expiryDateLabel.textColor = [UIColor whiteColor];
            expiryDateLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];
            
            
            UILabel * statusLabel = [[UILabel alloc] init] ;
            statusLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];
            statusLabel.backgroundColor = [UIColor clearColor];
            statusLabel.textColor = [UIColor whiteColor];
            statusLabel.textAlignment=NSTextAlignmentCenter;
            statusLabel.text = @"-";
            
            
            UIButton *delrowbtn = [[UIButton alloc] init] ;
            [delrowbtn setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
            [delrowbtn addTarget:self action:@selector(delRow:) forControlEvents:UIControlEventTouchUpInside];
            delrowbtn.tag = indexPath.row;
            delrowbtn.backgroundColor = [UIColor clearColor];
            
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            // Setting values from dic
            if ([selectGiftCouponArr count] && selectGiftCouponArr != nil) {
                
                NSDictionary * tempDic = selectGiftCouponArr[indexPath.row];
                
                voucherValLbl.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[tempDic valueForKey:@"unitCashValue"] defaultReturn:@"0"]];

                noOfVoucherLbl.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[tempDic valueForKey:@"couponCode"] defaultReturn:@"0"]];
                
                expiryDateLabel.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[tempDic valueForKey:@"expiryDateStr"] defaultReturn:@"-"]];
                issuedDateLabel.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[tempDic valueForKey:@"createdOnStr"] defaultReturn:@"-"]];
                statusLabel.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[tempDic valueForKey:@"status"] defaultReturn:@"-"]];
            }
            
            sno.frame = CGRectMake(snoLbl.frame.origin.x, 0, snoLbl.frame.size.width, snoLbl.frame.size.height);
            
            voucherValLbl.frame = CGRectMake(couponValueTableLbl.frame.origin.x, 0, couponValueTableLbl.frame.size.width, couponValueTableLbl.frame.size.height);
            
            noOfVoucherLbl.frame = CGRectMake(couponNumTableLbl.frame.origin.x, 0, couponNumTableLbl.frame.size.width, couponNumTableLbl.frame.size.height);
            
            issuedDateLabel.frame = CGRectMake(issueDateLbl.frame.origin.x, 0, issueDateLbl.frame.size.width, issueDateLbl.frame.size.height);
            
            expiryDateLabel.frame = CGRectMake(expryDateLbl.frame.origin.x, 0, expryDateLbl.frame.size.width, expryDateLbl.frame.size.height);
            
            statusLabel.frame = CGRectMake(statusLbl.frame.origin.x, 0, statusLbl.frame.size.width, statusLbl.frame.size.height);
            
            delrowbtn.frame = CGRectMake((actionLbl.frame.origin.x + (actionLbl.frame.size.width/2))-15 , 0, 35, 35);
            
            
            [hlcell.contentView addSubview:sno];
            [hlcell.contentView addSubview:voucherValLbl];
            [hlcell.contentView addSubview:delrowbtn];
            [hlcell.contentView addSubview:noOfVoucherLbl];
            [hlcell.contentView addSubview:expiryDateLabel];
            [hlcell.contentView addSubview:statusLabel];
            [hlcell.contentView addSubview:issuedDateLabel];
        }
        @catch (NSException *exception) {
            
            NSLog(@"%@",exception);
        }
        @finally {
        }
        return hlcell;
        
    }
    
    else if(tableView == giftCouponDetailsTable){
        
        @try {
            
            cell.textLabel.textColor= [UIColor blackColor];
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            
            if([giftCouponDetailsArr count] && giftCouponDetailsArr != nil){
                
                NSDictionary * giftCouponDetailsDic = giftCouponDetailsArr[indexPath.row];
                cell.textLabel.text = [self checkGivenValueIsNullOrNil:[giftCouponDetailsDic valueForKey:@"promoName"] defaultReturn:@"-"];
            }
        } @catch (NSException *exception) {
            NSLog(@"%@",exception);
            
        } @finally {
            
        }
    }
    
    else if(tableView == giftCouponCodeDetailsTable){
        
        @try {
            cell.textLabel.textColor= [UIColor blackColor];
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            
            if([giftCouponCodeDetailsArray count] && giftCouponCodeDetailsArray != nil){
                
                NSDictionary * giftCouponCodeDetailsDic = giftCouponCodeDetailsArray[indexPath.row];
                cell.textLabel.text = [self checkGivenValueIsNullOrNil:[giftCouponCodeDetailsDic valueForKey:@"couponCode"] defaultReturn:@"-"];
            }
            
        } @catch (NSException *exception) {
            
            NSLog(@"%@",exception);
            
        } @finally {
            
        }
    }
    
    return cell;
}



/**
 * @description  It is one of the UITableView delegate method
 * @date         16/06/2019...
 * @method       tableView:--  didSelectRowAtIndexPath:--
 * @author       roja
 * @param        UITableView
 * @param        NSIndexPath
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    

    if (tableView == giftCouponDetailsTable){
        
        @try {
            
            NSDictionary * giftCouponDetailsDic = giftCouponDetailsArr[indexPath.row];
            
            selectedCouponNoPosition = (int)indexPath.row;
            
            couponProgramTF.text =  [self checkGivenValueIsNullOrNil:[giftCouponDetailsDic valueForKey:@"promoName"] defaultReturn:@""];
            
            couponValueTF.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[giftCouponDetailsDic valueForKey:@"unitCashValue"] defaultReturn:@"0.00"] floatValue]];
            
            couponPromoCodeStr = [self checkGivenValueIsNullOrNil:[giftCouponDetailsDic valueForKey:@"couponProgramCode"] defaultReturn:@""];
            
            if ([couponCodeTF.text length] != 0) {
                couponCodeTF.text = @"";
            }
            
            [couponProgramPopOver dismissPopoverAnimated:YES];
            
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
    else if (tableView == giftCouponCodeDetailsTable) {
        
        @try {
            
            NSDictionary * giftCouponCodeDetailsDic = giftCouponCodeDetailsArray[indexPath.row];
            
            couponCodeTF.text =  [self checkGivenValueIsNullOrNil:[giftCouponCodeDetailsDic valueForKey:@"couponCode"] defaultReturn:@""];
            
            [couponCodePopOver dismissPopoverAnimated:YES];
            
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
}



#pragma -mark method used to display alert/warning messages....

/**
 * @description  adding the  alertMessage's based on input
 * @date         18/06/2019
 * @method       displayAlertMessage
 * @author
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
 * @date         18/06/2019
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
 * @description  here we are navigating back to home page.......
 * @date         18/06/2019
 * @method       backAction
 * @author       Roja
 * @param
 * @param
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)backAction {
    
    //Play audio for button touch...
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } @catch (NSException *exception) {
        
    }
}


/**
 * @description  In this method we are delete the row on selection of delete(action) button
 * @date         16/06/2019...
 * @method       delRow
 * @author       roja
 * @param
 * @param        UIButton
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
-(void)delRow:(UIButton *)sender {
    [selectGiftCouponArr removeObjectAtIndex:sender.tag];
    [giftCouponTableView reloadData];
}



-(void)homeButonClicked {
    
    OmniHomePage *home = [[OmniHomePage alloc]init];
    [self.navigationController pushViewController:home animated:YES];
    
}
- (void)goToHome {
    [self.navigationController popViewControllerAnimated:YES];
}




@end
