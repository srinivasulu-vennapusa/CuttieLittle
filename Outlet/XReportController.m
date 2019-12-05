//
//  XReportController.m
//  OmniRetailer
//
//  Created by MACPC on 9/28/15.
//
//

#import "XReportController.h"
#import "RequestHeader.h"

//added by Srinivasulu on 19/06/2017....
//reason is used for starIO_print....

#import "OmniRetailerAppDelegate.h"

//#import "ModelCapability.h"

#import <StarIO/SMPort.h>

#import "Communication.h"
#import "ModelCapability.h"

//upto here on 19/06/2017....


@interface XReportController ()

@end


@implementation XReportController
@synthesize xReportTxtView;
@synthesize soundFileURLRef,soundFileObject;
@synthesize declaredTenderDeatailsArr;

-(id)initWithValues:(NSString *)cardTotal cashTotal:(NSString *)cashTotal coupon:(NSString *)coupon ticket:(NSString *)ticket denomArr:(NSMutableArray*)denomArr {
    
    //changed by Srinivasulu on 04/04/2018....
    
    if(cardTotal != nil)
        cardAmt = [cardTotal copy];
    else
        cardAmt = @"0.00";
    
    if(cashTotal != nil)
        cashAmt = [cashTotal copy];
    else
        cashAmt = @"0.00";
    
    if(coupon != nil)
        couponAmt = [coupon copy];
    else
        couponAmt = @"0.00";
    
    if(ticket != nil)
        ticketAmt = [ticket copy];
    else
        ticketAmt = @"0.00";
    
    if(denomArr != nil)
        denomArray = [denomArr copy];
    else
        denomArray = [NSMutableArray new];
    
    //upto here on04/04/2018....
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    JSON = [NSDictionary new];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    
    printButton = [UIButton buttonWithType:UIButtonTypeCustom];
    // pay the cash button to continue the transaction ..
    [printButton addTarget:self action:@selector(print) forControlEvents:UIControlEventTouchUpInside];
    [printButton setTitle:@"Print"    forState:UIControlStateNormal];
    printButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    printButton.titleLabel.textColor = [UIColor whiteColor];
    printButton.backgroundColor = [UIColor grayColor];
    
    //added for date filter....
    
    goButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [goButton addTarget:self action:@selector(gobuttonPressed:) forControlEvents:UIControlEventTouchDown];
    [goButton setTitle:@"GO" forState:UIControlStateNormal];
    goButton.backgroundColor = [UIColor grayColor];

    
    reportDateTxt = [[UITextField alloc] init];
    reportDateTxt.borderStyle = UITextBorderStyleRoundedRect;
    reportDateTxt.textColor = [UIColor blackColor];
    reportDateTxt.placeholder = @"Select date";  //place holder
    reportDateTxt.backgroundColor = [UIColor whiteColor];
    reportDateTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    reportDateTxt.keyboardType = UIKeyboardTypeDefault;
    reportDateTxt.returnKeyType = UIReturnKeyDone;
    reportDateTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    reportDateTxt.userInteractionEnabled = NO;
    reportDateTxt.delegate = self;
    
    selectDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    UIImage *buttonImageDD = [UIImage imageNamed:@"combo.png"];
    [selectDateBtn setBackgroundImage:buttonImageDD forState:UIControlStateNormal];
    [selectDateBtn addTarget:self
                        action:@selector(DateButtonPressed:) forControlEvents:UIControlEventTouchDown];
    selectDateBtn.tag = 1;


    
//    self.xReportTxtView.contentInset = UIEdgeInsetsMake(20, 0, 20, 0);
//    [self.xReportTxtView.layoutManager ensureLayoutForTextContainer:self.xReportTxtView.textContainer];
    self.view.backgroundColor = [UIColor blackColor];
    
    self.titleLabel.text = @"X-REPORT";
    
    currentOrientation = [UIDevice currentDevice].orientation;
    
    
    //added by Srinivasulu on 26/03/2018....
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && !(currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight))
        currentOrientation = UIDeviceOrientationLandscapeRight;
    
    //upto here on 26/03/2018....
    self.xReportTxtView.delegate = self;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
            
            reportDateTxt.frame = CGRectMake(250, 0, 250, 50);
            selectDateBtn.frame = CGRectMake(450, 0, 50, 50);
            self.xReportTxtView.frame = CGRectMake(330, 20, 400, 700);
            printButton.frame = CGRectMake(780, 200, 150, 40);
            goButton.frame = CGRectMake(630, 15, 200, 50);
            goButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            goButton.layer.cornerRadius = 15.0f;
        }
    }
    printButton.layer.cornerRadius = 10.0f;
    self.xReportTxtView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.xReportTxtView.layer.borderWidth = 5.0f;
    self.xReportTxtView.layer.cornerRadius = 10.0f;
    self.xReportTxtView.textColor = [UIColor whiteColor];
    

//    [self.view addSubview:reportDateTxt];
//    [self.view addSubview:selectDateBtn];
//    [self.view addSubview:goButton];
    [self.view addSubview:self.xReportTxtView];
    [self.view addSubview:printButton];

    // Do any additional setup after loading the view from its nib.
}
- (void)tseriesPrinterResult:(PowaTSeriesPrinterResult)result{
    
    
}

-(void)viewWillDisappear:(BOOL)animated {
    
    @try {
        
        [printer removeObserver:self];
        [scanner removeObserver:self];
    }
    @catch (NSException *exception) {
        
        NSLog(@"Exception %@",exception);
    }
   
}
/** DateButtonPressed handle....
 To create picker frame and set the date inside the dueData textfield.
 */
-(IBAction) DateButtonPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    
//    if ((UIButton *)sender == fromOrderButton) {
//        toOrderButton.enabled = NO;
//        fromOrderButton.enabled = NO;
//        goButton.enabled = NO;
//    }
//    else if ((UIButton *)sender == toOrderButton){
//        fromOrderButton.enabled = NO;
//        toOrderButton.enabled = NO;
//        goButton.enabled = NO;
//    }
//    
    //pickerview creation....
    pickView = [[UIView alloc] init];
    
    
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            pickView.frame = CGRectMake(350, 70, 320, 320);
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
    
    pickButton.frame = CGRectMake(105, 269, 100, 45);
    pickButton.backgroundColor = [UIColor clearColor];
    pickButton.layer.masksToBounds = YES;
    [pickButton addTarget:self action:@selector(getDate:) forControlEvents:UIControlEventTouchUpInside];
    pickButton.layer.borderColor = [UIColor blackColor].CGColor;
    pickButton.layer.borderWidth = 0.5f;
    pickButton.layer.cornerRadius = 12;
    //pickButton.layer.masksToBounds = YES;
    [pickView addSubview:myPicker];
    [pickView addSubview:pickButton];
    [self.view addSubview:pickView];
    
    
}
// handle getDate method for pick date from calendar.
-(IBAction)getDate:(id)sender
{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    //    fromOrderButton.enabled = YES;
    //    toOrderButton.enabled = YES;
    //    goButton.enabled = YES;
    
    //Date Formate Setting...
    
    NSDateFormatter *sdayFormat = [[NSDateFormatter alloc] init];
    sdayFormat.dateFormat = @"yyyy/MM/dd";
    dateString = [sdayFormat stringFromDate:myPicker.date];
    
    
    reportDateTxt.text = dateString;
    
    [pickView removeFromSuperview];
    
}
- (void) gobuttonPressed:(id) sender {
    
    [self getXZReports:@"x"];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];

    [self getXZReports:@"x"];
}


// Commented by roja on 17/10/2019.. // reason :- getXZReports: method contains SOAP Service call .. so taken new method with same name(getXZReports:) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//-(void)getXZReports:(NSString*)reportType {
//
//    CheckWifi *WIFI = [[CheckWifi alloc]init];
//    BOOL status = [WIFI checkWifi];
//    if (status) {
//
//        @try {
//            [HUD show:YES];
//            SalesServiceSvcSoapBinding *custBindng =  [SalesServiceSvc SalesServiceSvcSoapBinding] ;
//            SalesServiceSvc_getXZreports *aParameters = [[SalesServiceSvc_getXZreports alloc] init];
//
//
//            NSDate *today = [NSDate date];
//            NSDateFormatter *f = [[NSDateFormatter alloc] init];
//            f.dateFormat = @"dd/MM/yyyy HH:mm:ss";
//            NSString* currentdate = [f stringFromDate:today];
//
//            //            NSArray *keys = [NSArray arrayWithObjects:@"DateAndTime", @"CashierId",@"CounterId",@"card_type",@"card_sub_type",@"card_number",@"Paid_amount",@"date_and_time",@"mode_of_payment",@"TotalPrice",@"DueAmount",@"transactionID",@"sku_id",@"TotalDiscount",@"DiscountType",@"DiscountTypeId",@"cash",@"Tax",@"emailId",@"phoneNumber",@"customerName",@"requestHeader", nil];
////            if ([reportDateTxt.text length]>0) {
////
////                currentdate = [reportDateTxt.text copy];
////            }
//            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//            // NSString *businessDate = [NSString stringWithFormat:@"%@%@%@",@"04/03/2017",@" ",[[currentdate componentsSeparatedByString:@" "] objectAtIndex:1]];
//
//            NSString * businessDate = [NSString stringWithFormat:@"%@%@%@",[defaults valueForKey:BUSSINESS_DATE],@" ",[currentdate componentsSeparatedByString:@" "][1]];
//            if(declaredTenderDeatailsArr == nil)
//            declaredTenderDeatailsArr = [NSMutableArray new];
//
//            NSArray *keys = @[@"counterId",@"cashierId",@"shiftId",@"reportDate",@"requestHeader",@"store_location",@"startIndex",@"reportType",CARD_TOTAL,COUPON_TOTAL,TICKET_TOTAL,@"denominations",kCustomerBillId,TENDER_HAND_OVERS];
//
//
//            NSArray *objects  = @[counterName,firstName,[NSString stringWithFormat:@"%@",shiftId],[NSString stringWithFormat:@"%@",businessDate],[RequestHeader getRequestHeader],presentLocation,@"0",reportType,cardAmt,couponAmt,ticketAmt,denomArray,@(isCustomerBillId),declaredTenderDeatailsArr];
//
//            NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
//
//            NSError * err;
//            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
//            NSString * createBillingJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//            aParameters.searchCriteria = createBillingJsonString;
//            SalesServiceSvcSoapBindingResponse *response = [custBindng getXZreportsUsingParameters:aParameters];
//            if (![response isKindOfClass:[NSError class]]) {
//
//                NSArray *responseBodyParts = response.bodyParts;
//                for (id bodyPart in responseBodyParts) {
//                    if ([bodyPart isKindOfClass:[SalesServiceSvc_getXZreportsResponse class]]) {
//                        SalesServiceSvc_getXZreportsResponse *body = (SalesServiceSvc_getXZreportsResponse *)bodyPart;
//                        printf("\nresponse=%s",(body.return_).UTF8String);
//
//                        NSError *e;
//                      NSDictionary  *json = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                             options: NSJSONReadingMutableContainers
//                                                                               error: &e];
//
//                        if ([[[json valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue] == 0) {
//
////                            [self printReports:JSON reportType:reportType];
//                            NSString * str = [self printXString:json];
//
//                            str = [str stringByReplacingOccurrencesOfString:@" " withString:@"\u00a0"];
//
//                            self.xReportTxtView.text = str;
//                            self.xReportTxtView.textColor = [UIColor whiteColor];
//                            xReportTxtView.autocorrectionType = UITextAutocorrectionTypeNo;
//                            JSON = [json copy];
////                            self.xReportTxtView.text = @"Hello How are You ??...";
//                            self.xReportTxtView.textAlignment = NSTextAlignmentCenter;
////                            [self.xReportTxtView.layoutManager ensureLayoutForTextContainer:self.xReportTxtView.textContainer];
//                        }
//                        else {
//
//                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%@",[[json valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                            [alert show];
//                        }
//
//
//
//                        //[HUD setHidden:YES];
//                    }
//                }
//            }
//            else {
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Failed to print the report" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                [alert show];
//            }
//
//
//        }
//        @catch (NSException *exception) {
//
//
//
//        }
//        @finally {
//            [HUD setHidden:YES];
//
//        }
//
//    }
//    else {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Please enable wifi/mobile data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    }
//}


//getXZReports: method changed by roja on 17/10/2019.. // reason : removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST
-(void)getXZReports:(NSString*)reportType {
    
    CheckWifi *WIFI = [[CheckWifi alloc]init];
    BOOL status = [WIFI checkWifi];
    
    if (status) {
        
        @try {
            
            [HUD show:YES];
            [HUD setHidden:NO];

            NSDate *today = [NSDate date];
            NSDateFormatter *f = [[NSDateFormatter alloc] init];
            f.dateFormat = @"dd/MM/yyyy HH:mm:ss";
            NSString* currentdate = [f stringFromDate:today];
          
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            // NSString *businessDate = [NSString stringWithFormat:@"%@%@%@",@"04/03/2017",@" ",[[currentdate componentsSeparatedByString:@" "] objectAtIndex:1]];
            
            NSString * businessDate = [NSString stringWithFormat:@"%@%@%@",[defaults valueForKey:BUSSINESS_DATE],@" ",[currentdate componentsSeparatedByString:@" "][1]];
            if(declaredTenderDeatailsArr == nil)
                declaredTenderDeatailsArr = [NSMutableArray new];
            
            NSArray *keys = @[@"counterId",@"cashierId",@"shiftId",@"reportDate",@"requestHeader",@"store_location",@"startIndex",@"reportType",CARD_TOTAL,COUPON_TOTAL,TICKET_TOTAL,@"denominations",kCustomerBillId,TENDER_HAND_OVERS];
            
            NSArray *objects  = @[counterName,firstName,[NSString stringWithFormat:@"%@",shiftId],[NSString stringWithFormat:@"%@",businessDate],[RequestHeader getRequestHeader],presentLocation,@"0",reportType,cardAmt,couponAmt,ticketAmt,denomArray,@(isCustomerBillId),declaredTenderDeatailsArr];
            
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            
            NSError * err;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
            NSString * createBillingJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            WebServiceController * services = [[WebServiceController alloc] init];
            services.salesServiceDelegate = self;
            [services getXZReports:createBillingJsonString];
            
        }
        @catch (NSException *exception) {
            [HUD setHidden:NO];
        }

    }
    else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Please enable wifi/mobile data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

// added by Roja on 17/10/2019….
- (void)getXZReportSuccessResponse:(NSDictionary *)successDictionary{
  
    @try {
        
        //                            [self printReports:JSON reportType:reportType];
        NSString * str = [self printXString:successDictionary];
        str = [str stringByReplacingOccurrencesOfString:@" " withString:@"\u00a0"];
        
        self.xReportTxtView.text = str;
        self.xReportTxtView.textColor = [UIColor whiteColor];
        xReportTxtView.autocorrectionType = UITextAutocorrectionTypeNo;
        JSON = [successDictionary copy];
        //                            self.xReportTxtView.text = @"Hello How are You ??...";
        self.xReportTxtView.textAlignment = NSTextAlignmentCenter;
        //                            [self.xReportTxtView.layoutManager ensureLayoutForTextContainer:self.xReportTxtView.textContainer];
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}

// added by Roja on 17/10/2019….
- (void)getXZReportErrorResponse:(NSString *)errorResponse{
    
    @try {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""  message:errorResponse delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]; //@"Failed to print the report"
        [alert show];

    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}



-(void)print {
    
    AudioServicesPlaySystemSound (soundFileObject);

    [self printReports:JSON reportType:@"x"];
}

/**
 * @description  here we are froming the print String....
 * @date
 * @method       printXString:--
 * @author
 * @param        UIButton
 * @param
 * @return       void
 *
 * @modified By  Srinivasulu on 10/04/2018....
 * @reason       here change the printStirng formation....
 *
 * @verified By
 * @verified On
 *
 */

-(NSString *)printXString:(NSDictionary *)Json {
    
    NSString *finalPrintMessage = @"";

    @try {
        NSString *storeAddress = [WebServiceUtility getStoreAddress];
        
        NSDate *today = [NSDate date];
        NSDateFormatter *f = [[NSDateFormatter alloc] init];
        f.dateFormat = @"dd/MM/yyyy HH:mm:ss";
        NSString* currentdate = [f stringFromDate:today];
        
        
        NSString *header = [NSString stringWithFormat:@"#####%@",@"X-Reading Report"];
        header = [NSString stringWithFormat:@"%@%@\n",header,@"(Shift-End)"];
        header = [NSString stringWithFormat:@"%@%@\n",header,@"---------------------------------"];
        header = [NSString stringWithFormat:@"\n%@%@\n%@%@%@",header,currentdate,@"U :",firstName,@"##\n"];
        header = [NSString stringWithFormat:@"%@%@%@%@",header,@"Shift   #",shiftId,@"\n"];
        header = [NSString stringWithFormat:@"\n%@%@%@\n",header,@"Counter   #",counterName];
        header = [NSString stringWithFormat:@"\n%@%@%@\n",header,@"MODE : ",@"END-SHIFT"];
        header = [NSString stringWithFormat:@"%@%@",header,@"---------------------------------\n"];
        
        //String of RS -- stirng dispal --  written by Srinivasulu on 10/04/2018.... y....

//        NSArray * staticStringArr = [NSArray arrayWithObjects:NSLocalizedString(@"sales_inclusive_tax_", nil),NSLocalizedString(@"item_discount_", nil),NSLocalizedString(@"over_all_discount_", nil), nil];
//        NSArray * dynamicStringArr = [NSArray arrayWithObjects:SALES,ITEM_WISE_DISCOUNT,OVER_ALL_DISCOUNT, nil];
        NSString *body  = @"";;

        NSArray * staticStringArr = @[NSLocalizedString(@"sales_inclusive_tax_", nil),NSLocalizedString(@"item_discount_", nil),NSLocalizedString(@"over_all_discount_", nil),NSLocalizedString(@"net_sales_inclusive_tax_", nil),NSLocalizedString(@"net_sales_exclusive_tax_", nil),NSLocalizedString(@"cess", nil),NSLocalizedString(@"service_charge_", nil),NSLocalizedString(@"other_charge_", nil),NSLocalizedString(@"tax_", nil),NSLocalizedString(@"tax_exempted_", nil),NSLocalizedString(@"total_sales_collection", nil),NSLocalizedString(@"deposit_collected", nil), NSLocalizedString(@"deposit_refunded", nil),NSLocalizedString(@"deposit_forefeited", nil),NSLocalizedString(@"deposit_utilised", nil),NSLocalizedString(@"total_amount_collected", nil)];
        NSArray * dynamicStringArr = @[SALES,ITEM_WISE_DISCOUNT,OVER_ALL_DISCOUNT,NET_SALES_INCLUSIVE_TAX,NET_SALES_EXCLUSIVE_TAX,CESS,SERVICE_CHARGE,OTHER_CHARGE,TAX,TAX_EXEMPTED,TOTAL_SALES_COLLECTION,DEPOSIT_COLLECTED,DEPOSIT_REFUNDED,DEPOSIT_FORE_FEITED,DEPOSITES_UTILIZED,TOTAL_AMMOUNT_COLLECTED];
        
        for(int i = 0; i < staticStringArr.count; i++){
            
            NSString * staticDisplayStr = staticStringArr[i];
            NSString * dynamicDisplayStr = @"0.00";
            
            if(![[Json valueForKey:dynamicStringArr[i]] isKindOfClass:[NSNull class]] && [Json.allKeys containsObject:dynamicStringArr[i]]){
            
                if([dynamicStringArr[i] isEqualToString:OVER_ALL_DISCOUNT]){
                    
                    
                    float overAllDisc = 0;
                    
                    if (![Json[ITEM_WISE_DISCOUNT] isKindOfClass:[NSNull class]]) {
                        
                        //some comfit which line has to comment.. written by Srinivasulu on 10/04/2018..
                        overAllDisc = [[Json valueForKey:OVER_ALL_DISCOUNT] floatValue] - [Json[ITEM_WISE_DISCOUNT] floatValue];
//                        overAllDisc = [[Json valueForKey:@"itemDiscount"] floatValue] - [[Json objectForKey:ITEM_WISE_DISCOUNT] floatValue];
                    }
                    
//                    dynamicDisplayStr =[NSString stringWithFormat:@"%@%@%.2f",NSLocalizedString(@"rs_", nil),@"##",overAllDisc];
                    dynamicDisplayStr =[NSString stringWithFormat:@"%.2f",overAllDisc];

                }
                else{
//                    dynamicDisplayStr =[NSString stringWithFormat:@"%@%@%.2f",NSLocalizedString(@"rs_", nil),@"##",[[Json valueForKey:[dynamicStringArr objectAtIndex:i]] floatValue]];
                    dynamicDisplayStr =[NSString stringWithFormat:@"%.2f",[[Json valueForKey:dynamicStringArr[i]] floatValue]];
                }
            }
           
            
            
            int strLength = (int)staticDisplayStr.length + (int)dynamicDisplayStr.length;
            for(int i = strLength; i < 43; i++){
                
                if(i == 38)
                    staticDisplayStr = [NSString stringWithFormat:@"%@%@",staticDisplayStr,@"R"];
                else if(i == 39)
                        staticDisplayStr = [NSString stringWithFormat:@"%@%@",staticDisplayStr,@"s."];
            else
                staticDisplayStr = [NSString stringWithFormat:@"%@%@",staticDisplayStr,@"#"];
            }
            
            body = [NSString stringWithFormat:@"%@%@%@%@", body,staticDisplayStr,dynamicDisplayStr,@"\n"];
        }
        
        
//        NSString *body;
//        if (![[Json objectForKey:@"sales"] isKindOfClass:[NSNull class]]) {
//            body = [NSString stringWithFormat:@"%@%@%@",@"Sales   (Inclusive TAX) ",@"Rs.###",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"sales"] floatValue]]];
//        }
//        else {
//            body = [NSString stringWithFormat:@"%@\n%@",@"Sales   (Inclusive TAX) ",@"Rs.###0.00"];
//        }
//
//
//
//
//        if (![[Json objectForKey:@"itemWiseDiscount"] isKindOfClass:[NSNull class]]) {
//            body=[NSString stringWithFormat:@"%@\n%@%.2f",body,@"Item Discount        (-) Rs.###",[[Json valueForKey:@"itemWiseDiscount"] floatValue]];
//        }
//        else {
//            body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Item Discount        (-) Rs.###0.00"];
//        }
//        if (![[Json objectForKey:@"overalDiscount"] isKindOfClass:[NSNull class]]) {
//            float overAllDisc = 0;
//            if (![[Json objectForKey:@"itemWiseDiscount"] isKindOfClass:[NSNull class]]) {
//
//                overAllDisc = [[Json valueForKey:@"itemDiscount"] floatValue] - [[Json objectForKey:@"itemWiseDiscount"] floatValue];
//            }
//            body=[NSString stringWithFormat:@"%@\n%@%.2f",body,@"Overall Discount    (-) Rs.###",overAllDisc];
//        }
//        else {
//            body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Overall Discount    (-) Rs.###0.00"];
//        }
//        if (![[Json objectForKey:@"netSalesInclusiveTax"] isKindOfClass:[NSNull class]]) {
//            body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Net Sales(Inclusive TAX) Rs.###",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"netSalesInclusiveTax"] floatValue]]];
//        }
//        else {
//            body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Net Sales(Inclusive TAX) Rs.###0.00"];
//        }
//        if (![[Json objectForKey:@"netSalesExclusiveTax"] isKindOfClass:[NSNull class]]) {
//            body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Net Sales(Exclusive TAX) Rs.###",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"netSalesExclusiveTax"] floatValue]]];
//        }
//        else {
//            body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Net Sales(Exclusive TAX) Rs.###0.00"];
//
//        }
//        if (![[Json objectForKey:@"cess"] isKindOfClass:[NSNull class]]) {
//            body=[NSString stringWithFormat:@"%@\n%@\n%@",body,@"Cess   Rs.###",[Json valueForKey:@"cess"]];
//        }
//        else {
//            body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Cess   Rs.###0.00"];
//        }
//        if (![[Json objectForKey:@"serviceCharge"] isKindOfClass:[NSNull class]]) {
//            body=[NSString stringWithFormat:@"%@\n%@\n%@",body,@"Service Charge     Rs.###",[Json valueForKey:@"serviceCharge"]];
//        }
//        else {
//            body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Service Charge     Rs.###0.00"];
//        }
//        if (![[Json objectForKey:@"otherCharge"] isKindOfClass:[NSNull class]]) {
//            body=[NSString stringWithFormat:@"%@\n%@\n%@",body,@"Other Charge     Rs.###",[Json valueForKey:@"otherCharge"]];
//        }
//        else {
//            body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Other Charge     Rs.###0.00"];
//        }
//        if (![[Json objectForKey:@"tax"] isKindOfClass:[NSNull class]]) {
//            body=[NSString stringWithFormat:@"%@\n%@%@",body,@"TAX      Rs.###",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"tax"] floatValue]]];
//        }
//        else {
//            body=[NSString stringWithFormat:@"%@\n%@\n",body,@"TAX      Rs.###0.00"];
//        }
//        if (![[Json objectForKey:@"taxExempted"] isKindOfClass:[NSNull class]]) {
//            body=[NSString stringWithFormat:@"%@\n%@\n%@",body,@"TAX Exempted     Rs.###",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"taxExempted"] floatValue]]];
//        }
//        else {
//            body=[NSString stringWithFormat:@"%@\n%@\n",body,@"TAX Exempted     Rs.###0.00"];
//        }
//        if (![[Json objectForKey:@"totalSalesCollection"] isKindOfClass:[NSNull class]]) {
//            body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Total Sales Collection     Rs.###",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"totalSalesCollection"] floatValue]]];
//        }
//        else {
//            body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Total Sales Collection     Rs.###0.00"];
//        }
//        if (![[Json objectForKey:@"depositCollected"] isKindOfClass:[NSNull class]]) {
//            body=[NSString stringWithFormat:@"%@\n%@\n%@",body,@"Deposit Collected     Rs.###",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"depositCollected"] floatValue]]];
//        }
//        else {
//            body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Deposit Collected     Rs.###0.00"];
//        }
//        if (![[Json objectForKey:@"depositRefunded"] isKindOfClass:[NSNull class]]) {
//            body=[NSString stringWithFormat:@"%@\n%@\n%@",body,@"Deposit Refunded     Rs.###",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"depositRefunded"] floatValue]]];
//        }
//        else {
//            body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Deposit Refunded     Rs.###0.00"];
//        }
//        body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Deposit Forefeited     ",@"0"];
//        if (![[Json objectForKey:@"depositesUtilized"] isKindOfClass:[NSNull class]]) {
//            body=[NSString stringWithFormat:@"%@\n%@\n%@",body,@"Deposit Utilised     Rs.###",[Json valueForKey:@"depositesUtilized"]];
//        }
//        else {
//            body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Deposit Utilised     Rs.###0.00"];
//        }
//        if (![[Json objectForKey:@"totalAmmountCollected"] isKindOfClass:[NSNull class]]) {
//            body=[NSString stringWithFormat:@"%@\n%@%@\n",body,@"Total Amount Collected     Rs.###",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"totalAmmountCollected"] floatValue]]];
//        }
//        else {
//            body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Total Amount Collected     Rs.###0.00"];
//        }
//
        //end of RS -- stirng dispal --  written by Srinivasulu on 10/04/2018.... y....
        
        NSString *footer;
        if (![Json[@"salesReports"] isKindOfClass:[NSNull class]]) {
            footer = [NSString stringWithFormat:@"%@%@\n",@"Sales Receipts ",Json[@"salesReports"]];
        }
        else {
            footer = [NSString stringWithFormat:@"%@%@\n",@"Sales Receipts ",@""];
            
        }
        if (![Json[@"trainingReceipts"] isKindOfClass:[NSNull class]]) {
            footer = [NSString stringWithFormat:@"%@%@%@\n",footer,@"Training Receipts  ",[[Json valueForKey:@"trainingReceipts"] stringValue]];
        }
        else {
            footer = [NSString stringWithFormat:@"%@%@\n",footer,@"Training Receipts  0"];
        }
        if (![Json[@"manualReceipts"] isKindOfClass:[NSNull class]]) {
            footer = [NSString stringWithFormat:@"%@%@%@\n",footer,@"Manual Receipts  ",[[Json valueForKey:@"manualReceipts"] stringValue]];
        }
        else {
            footer = [NSString stringWithFormat:@"%@%@\n",footer,@"Manual Receipts  0"];
        }
        if (![Json[@"depositeReceipts"] isKindOfClass:[NSNull class]]) {
            footer = [NSString stringWithFormat:@"%@%@%@\n\n\n",footer,@"Deposit Receipts  ",[[Json valueForKey:@"depositeReceipts"] stringValue]];
        }
        else {
            footer = [NSString stringWithFormat:@"%@%@\n\n\n",footer,@"Deposit Receipts  0"];
        }
        if (![Json[@"refundExchange"] isKindOfClass:[NSNull class]]) {
            footer = [NSString stringWithFormat:@"%@%@%@\n",footer,@"Refund/Exchange#########",[NSString stringWithFormat:@"%.2f",[Json[@"refundExchange"] floatValue]]];
        }
        else {
            footer = [NSString stringWithFormat:@"%@%@%@\n",footer,@"Refund/Exchange#########",@"0"];
        }
        
        
        NSString *totalNumbers = [NSString stringWithFormat:@"\n%@%@%@",@"No. of Items Sold############",[Json valueForKey:@"noOfItemsSold"],@"\n"];
        totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Void Items############",[Json valueForKey:@"noOfVoidItems"],@"\n"];
        totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Disc Items############",[Json valueForKey:@"noOfDiscountedItems"],@"\n"];
        totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of No sale Done##########",[Json valueForKey:@"noOfNoSaleDone"],@"\n"];
        totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Price Overrides#######",[Json valueForKey:@"noOfPriceOverrides"],@"\n"];
        totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Line Discount#########",[Json valueForKey:@"noOfLineDiscounts"],@"\n"];
        totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Customers#############",[Json valueForKey:@"noOfCustomers"],@"\n"];
        totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Deposit Collected#####",[Json valueForKey:@"noOfDepositCollected"],@"\n"];
        totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Deposit Refunded######",[Json valueForKey:@"noOfDepositRefunded"],@"\n"];
        if (![Json[@"depositForefeited"] isKindOfClass:[NSNull class]]) {
            totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Deposit Forefeited####",[Json valueForKey:@"depositForefeited"],@"\n"];
        }
        else {
            totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Deposit Forefeited####",@"0",@"\n"];
        }
        if (![Json[@"depositesUtilized"] isKindOfClass:[NSNull class]]) {
            totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Deposit Utilized######",[Json valueForKey:@"depositesUtilized"],@"\n"];
        }
        else {
            totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Deposit Utilized######",@"0",@"\n"];
        }
        
        totalNumbers = [NSString stringWithFormat:@"%@%@",totalNumbers,@"---------------------------------\n"];
        
        NSString *transString;
        if (![[Json valueForKey:@"cardTotal"] isKindOfClass:[NSNull class]]) {
            transString = [NSString stringWithFormat:@"%@%@%@%@%@",@"CARD######",[Json valueForKey:@"cardTransactions"],@"  Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"cardTotal"] floatValue]],@"\n\n"];
        }
        else {
            transString = [NSString stringWithFormat:@"%@%@%@%@",@"CARD######",[Json valueForKey:@"cardTransactions"],@"  Rs.  0.00",@"\n\n"];
        }
        if (![[Json valueForKey:@"cardTotal"] isKindOfClass:[NSNull class]]) {
            transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"***Total Card######",[Json valueForKey:@"cardTransactions"],@"  Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"cardTotal"] floatValue]],@"\n\n"];
        }
        else {
            transString = [NSString stringWithFormat:@"%@%@%@%@",transString,@"***Total Card######",[Json valueForKey:@"cardTransactions"],@"  Rs.  0.00\n\n"];
        }
        if (![[Json valueForKey:@"cashTotal"] isKindOfClass:[NSNull class]]) {
            transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"CASH######",[Json valueForKey:@"cashtransactions"],@"  Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"cashTotal"] floatValue]],@"\n\n"];
        }
        else {
            transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"CASH######",[Json valueForKey:@"cashtransactions"],@"  Rs.  0.00",@"\n\n"];
        }
        if (![[Json valueForKey:@"cashTotal"] isKindOfClass:[NSNull class]]) {
            transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"**Total Cash######",[Json valueForKey:@"cashtransactions"],@"  Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"cashTotal"] floatValue]],@"\n\n"];
        }
        else {
            transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"**Total Cash######",[Json valueForKey:@"cashtransactions"],@"  Rs.  0.00",@"\n\n"];
        }
        if (![[Json valueForKey:@"sodexoTotal"] isKindOfClass:[NSNull class]]) {
            transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"SODEXO######",[Json valueForKey:@"sodexoTransactions"],@"  Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"sodexoTotal"] floatValue]],@"\n\n"];
        }
        else {
            transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"SODEXO######",[Json valueForKey:@"sodexoTransactions"],@"  Rs.  0.00",@"\n\n"];
        }
        if (![[Json valueForKey:@"sodexoTotal"] isKindOfClass:[NSNull class]]) {
            transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"**Total Sodexo######",[Json valueForKey:@"sodexoTransactions"],@"  Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"sodexoTotal"] floatValue]],@"\n\n"];
        }
        else {
            transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"**Total Sodexo######",[Json valueForKey:@"sodexoTransactions"],@"  Rs.  0.00",@"\n\n"];
        }
        
        
        
        if (![[Json valueForKey:@"ticketTotal"] isKindOfClass:[NSNull class]]) {
            transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"TICKET######",[Json valueForKey:@"ticketTransactions"],@"  Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"ticketTotal"] floatValue]],@"\n\n"];
        }
        else {
            transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"TICKET######",[Json valueForKey:@"ticketTransactions"],@"  Rs.  0.00",@"\n\n"];
        }
        if (![[Json valueForKey:@"ticketTotal"] isKindOfClass:[NSNull class]]) {
            transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"**Total TICKET######",[Json valueForKey:@"ticketTransactions"],@"  Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"ticketTotal"] floatValue]],@"\n\n"];
        }
        else {
            transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"**Total TICKET######",[Json valueForKey:@"ticketTransactions"],@"  Rs.  0.00",@"\n\n"];
        }
        
        if (![[Json valueForKey:@"giftVouchers"] isKindOfClass:[NSNull class]]) {
            transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"VOUCHERS######",[Json valueForKey:@"totalGiftVouchers"],@"  Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"giftVouchers"] floatValue]],@"\n\n"];
        }
        else {
            transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"VOUCHERS######",[Json valueForKey:@"totalGiftVouchers"],@"  Rs.  0.00",@"\n\n"];
        }
        
        if (![[Json valueForKey:@"giftVouchers"] isKindOfClass:[NSNull class]]) {
            transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"**Total Vouchers######",[Json valueForKey:@"totalGiftVouchers"],@"  Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"giftVouchers"] floatValue]],@"\n\n"];
        }
        else {
            transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"**Total Vouchers######",[Json valueForKey:@"totalGiftVouchers"],@"  Rs.  0.00",@"\n\n"];
        }
        
        if (![[Json valueForKey:@"coupons"] isKindOfClass:[NSNull class]]) {
            transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"COUPONS######",[Json valueForKey:@"totalCoupons"],@"  Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"coupons"] floatValue]],@"\n\n"];
        }
        else {
            transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"COUPONS######",[Json valueForKey:@"totalCoupons"],@"  Rs.  0.00",@"\n\n"];
        }
        
        if (![[Json valueForKey:@"coupons"] isKindOfClass:[NSNull class]]) {
            transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"**Total Coupons######",[Json valueForKey:@"totalCoupons"],@"  Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"coupons"] floatValue]],@"\n\n"];
        }
        else {
            transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"**Total Coupons######",[Json valueForKey:@"totalCoupons"],@"  Rs.  0.00",@"\n\n"];
        }
        
        if (![[Json valueForKey:@"loyaltyPointsTotal"] isKindOfClass:[NSNull class]]) {
            transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"LOYALTY POINTS######",[Json valueForKey:@"loyaltyPointsTransactions"],@"  Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"loyaltyPointsTotal"] floatValue]],@"\n\n"];
        }
        else {
            transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"LOYALTY POINTS######",[Json valueForKey:@"loyaltyPointsTransactions"],@"  Rs.  0.00",@"\n\n"];
        }
        
        if (![[Json valueForKey:@"loyaltyPointsTotal"] isKindOfClass:[NSNull class]]) {
            transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"**Total Loyalty Points####",[Json valueForKey:@"loyaltyPointsTransactions"],@"  Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"loyaltyPointsTotal"] floatValue]],@"\n\n"];
        }
        else {
            transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"**Total Loyalty Points######",[Json valueForKey:@"loyaltyPointsTransactions"],@"  Rs.  0.00",@"\n\n"];
        }
        
        if (![[Json valueForKey:@"totalCreditNoteAmt"] isKindOfClass:[NSNull class]]) {
            transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"CREDIT NOTES######",[Json valueForKey:@"noOfCreditNotes"],@"  Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"totalCreditNoteAmt"] floatValue]],@"\n\n"];
        }
        else {
            transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"CREDIT NOTES######",[Json valueForKey:@"noOfCreditNotes"],@"  Rs.  0.00",@"\n\n"];
        }
        
        if (![[Json valueForKey:@"totalCreditNoteAmt"] isKindOfClass:[NSNull class]]) {
            transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"**Total Credit Notes####",[Json valueForKey:@"noOfCreditNotes"],@"  Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"totalCreditNoteAmt"] floatValue]],@"\n\n"];
        }
        else {
            transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"**Total Credit Notes######",[Json valueForKey:@"noOfCreditNotes"],@"  Rs.  0.00",@"\n\n"];
        }
        
        if (![[Json valueForKey:@"exchangeTotal"] isKindOfClass:[NSNull class]]) {
            transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"**Exchange Deduc######",@"        Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"exchangeTotal"] floatValue]],@"\n\n"];
        }
        else {
            transString = [NSString stringWithFormat:@"%@%@%@%@",transString,@"**Exchange Deduc######",@"  Rs.  0.00",@"\n\n"];
        }
        if (![[Json valueForKey:@"returnTotal"] isKindOfClass:[NSNull class]]) {
            transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"**Return Deduc######",@"       Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"returnTotal"] floatValue]],@"\n\n"];
        }
        else {
            transString = [NSString stringWithFormat:@"%@%@%@%@",transString,@"**Return Deduc######",@"        Rs.  0.00",@"\n\n"];
        }
        
        
        transString = [NSString stringWithFormat:@"%@%@",transString,@"---------------------------------\n"];
        
        NSString *taxInfo = @"";
        if (![Json[@"taxesInfo"] isKindOfClass:[NSNull class]]) {
            taxInfo = [NSString stringWithFormat:@"%@%@%@",@"Tax Code####",@"Percentage########",@"Amount\n"];
            for (NSDictionary *dic in Json[@"taxesInfo"]) {
                taxInfo = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",taxInfo,dic[@"taxCode"] ,@"##########",[dic[@"percentage"] stringValue],@"########",@"RS   ",[NSString stringWithFormat:@"%.2f",[dic[@"amount"] floatValue]],@"\n\n"];
            }
            taxInfo = [NSString stringWithFormat:@"%@%@",taxInfo,@"---------------------------------\n"];
        }
        if (![Json[@"taxTotal"] isKindOfClass:[NSNull class]]) {
            taxInfo = [NSString stringWithFormat:@"%@%@%@%@",taxInfo,@"#######Tax Total :  RS  ",[NSString stringWithFormat:@"%.2f",[Json[@"taxTotal"] floatValue]],@"\n"];
        }
        else {
            taxInfo = [NSString stringWithFormat:@"%@%@",taxInfo,@"#######Tax Total :  RS  0.00\n"];
        }
        taxInfo = [NSString stringWithFormat:@"%@%@",taxInfo,@"---------------------------------\n"];
        
        NSString *cashierInfo = [NSString stringWithFormat:@"%@%@%@",@"Cashier##",@"Incl Tax Sales ##",@"Excl Tax Sales\n\n"];
        if (![Json[@"netSalesInclusiveTax"] isKindOfClass:[NSNull class]]) {
            cashierInfo = [NSString stringWithFormat:@"%@%@%@%@%@",cashierInfo,firstName,@"#######",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"netSalesInclusiveTax"] floatValue]],@"###"];
        }
        else {
            cashierInfo = [NSString stringWithFormat:@"%@%@%@%@",cashierInfo,firstName,@"#######0.00",@"###"];
        }
        if (![Json[@"netSalesExclusiveTax"] isKindOfClass:[NSNull class]]) {
            cashierInfo = [NSString stringWithFormat:@"%@%@%@%@",cashierInfo,@"###",[NSString stringWithFormat:@"%.2f",[Json[@"netSalesExclusiveTax"] floatValue]],@"\n"];
        }
        else {
            cashierInfo = [NSString stringWithFormat:@"%@%@",cashierInfo,@"###0.00\n"];
        }
        
        cashierInfo = [NSString stringWithFormat:@"%@%@",cashierInfo,@"---------------------------------\n"];
        
        if (![Json[@"netSalesInclusiveTax"] isKindOfClass:[NSNull class]]) {
            cashierInfo = [NSString stringWithFormat:@"%@%@%@%@%@",cashierInfo,@"Cashier Total :",@"#######",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"netSalesInclusiveTax"] floatValue]],@"###"];
        }
        else {
            cashierInfo = [NSString stringWithFormat:@"%@%@%@%@",cashierInfo,@"Cashier Total :",@"#######0.00",@"###"];
        }
        if (![Json[@"netSalesExclusiveTax"] isKindOfClass:[NSNull class]]) {
            cashierInfo = [NSString stringWithFormat:@"%@%@%@%@",cashierInfo,@"###",[NSString stringWithFormat:@"%.2f",[Json[@"netSalesExclusiveTax"] floatValue]],@"\n"];
        }
        else {
            cashierInfo = [NSString stringWithFormat:@"%@%@",cashierInfo,@"###0.00\n"];
        }
        
        cashierInfo = [NSString stringWithFormat:@"%@\n%@",cashierInfo,@"---------------------------------\n"];
        
        NSString *currencyInfo = @"####*** Currency Declaration *** \n---------------------------------\n";
        currencyInfo = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",currencyInfo,@"Code ###",@"Name ###",@"DENOM ###",@"Colle ###",@"AMT ###",@"\n"];
        if (![Json[@"denominations"] isKindOfClass:[NSNull class]]) {
            for (NSDictionary *dic in Json[@"denominations"]) {
                if ([dic[@"currencyName"] length] > 4 && [dic[@"currencyName"] length] == 7) {
                    currencyInfo = [NSString stringWithFormat:@"%@%@%@%@%@%@",currencyInfo,dic[@"currCode"] ,@"####",dic[@"currencyName"] ,@"####",[dic[@"denomination"] stringValue]];
                    
                    if ([dic[@"denomination"] stringValue].length >= 4) {
                        currencyInfo = [NSString stringWithFormat:@"%@%@%@%@%@%@",currencyInfo,@"##",[dic[@"collection"] stringValue],@"####",[dic[@"amount"] stringValue],@"\n"];
                    }
                    else if ([dic[@"denomination"] stringValue].length == 3) {
                        currencyInfo = [NSString stringWithFormat:@"%@%@%@%@%@%@",currencyInfo,@"####",[dic[@"collection"] stringValue],@"######",[dic[@"amount"] stringValue],@"\n"];
                    }
                    else if ([dic[@"denomination"] stringValue].length == 2) {
                        currencyInfo = [NSString stringWithFormat:@"%@%@%@%@%@%@",currencyInfo,@"####",[dic[@"collection"] stringValue],@"######",[dic[@"amount"] stringValue],@"\n"];
                    }
                    else {
                        currencyInfo = [NSString stringWithFormat:@"%@%@%@%@%@%@",currencyInfo,@"#########",[dic[@"collection"] stringValue],@"#####",[dic[@"amount"] stringValue],@"\n"];
                    }
                }
                else if ([dic[@"currencyName"] length] > 4 && [dic[@"currencyName"] length] == 6) {
                    currencyInfo = [NSString stringWithFormat:@"%@%@%@%@%@%@",currencyInfo,dic[@"currCode"] ,@"###",dic[@"currencyName"] ,@"##",[dic[@"denomination"] stringValue]];
                    if ([dic[@"denomination"] stringValue].length >= 4) {
                        currencyInfo = [NSString stringWithFormat:@"%@%@%@%@%@%@",currencyInfo,@"##",[dic[@"collection"] stringValue],@"####",[dic[@"amount"] stringValue],@"\n"];
                    }
                    else if ([dic[@"denomination"] stringValue].length == 3) {
                        currencyInfo = [NSString stringWithFormat:@"%@%@%@%@%@%@",currencyInfo,@"####",[dic[@"collection"] stringValue],@"######",[dic[@"amount"] stringValue],@"\n"];
                    }
                    else if ([dic[@"denomination"] stringValue].length == 2) {
                        currencyInfo = [NSString stringWithFormat:@"%@%@%@%@%@%@",currencyInfo,@"######",[dic[@"collection"] stringValue],@"#######",[dic[@"amount"] stringValue],@"\n"];
                    }
                    else {
                        currencyInfo = [NSString stringWithFormat:@"%@%@%@%@%@%@",currencyInfo,@"#########",[dic[@"collection"] stringValue],@"#####",[dic[@"amount"] stringValue],@"\n"];
                    }
                    
                }
                else {
                    currencyInfo = [NSString stringWithFormat:@"%@%@%@%@%@%@",currencyInfo,dic[@"currCode"] ,@"######",dic[@"currencyName"] ,@"#####",[dic[@"denomination"] stringValue]];
                    if ([dic[@"denomination"] stringValue].length >= 4) {
                        currencyInfo = [NSString stringWithFormat:@"%@%@%@",currencyInfo,@"######",[dic[@"collection"] stringValue]];
                    }
                    else if ([dic[@"denomination"] stringValue].length == 3) {
                        currencyInfo = [NSString stringWithFormat:@"%@%@%@",currencyInfo,@"#######",[dic[@"collection"] stringValue]];
                    }
                    else if ([dic[@"denomination"] stringValue].length == 2) {
                        currencyInfo = [NSString stringWithFormat:@"%@%@%@",currencyInfo,@"########",[dic[@"collection"] stringValue]];
                    }
                    else {
                        currencyInfo = [NSString stringWithFormat:@"%@%@%@",currencyInfo,@"#########",[dic[@"collection"] stringValue]];
                    }
                    
                    if ([dic[@"collection"] stringValue].length >= 4) {
                        currencyInfo = [NSString stringWithFormat:@"%@%@%@%@",currencyInfo,@"##",[dic[@"amount"] stringValue],@"\n"];
                    }
                    else if ([dic[@"collection"] stringValue].length == 3) {
                        currencyInfo = [NSString stringWithFormat:@"%@%@%@%@",currencyInfo,@"###",[dic[@"amount"] stringValue],@"\n"];
                    }
                    else if ([dic[@"collection"] stringValue].length == 2) {
                        currencyInfo = [NSString stringWithFormat:@"%@%@%@%@",currencyInfo,@"####",[dic[@"amount"] stringValue],@"\n"];
                    }
                    else {
                        currencyInfo = [NSString stringWithFormat:@"%@%@%@%@",currencyInfo,@"#####",[dic[@"amount"] stringValue],@"\n"];
                        
                    }
                }
            }
            currencyInfo = [NSString stringWithFormat:@"%@%@",currencyInfo,@"---------------------------------\n"];
        }
        if ([[Json valueForKey:@"openBalance"] floatValue]>0) {
            
            currencyInfo = [NSString stringWithFormat:@"%@%@%@%@",currencyInfo,@"#######Open Balance :     ",[Json valueForKey:@"openBalance"],@"\n"];
        }
        currencyInfo = [NSString stringWithFormat:@"%@%@%@%@",currencyInfo,@"#######System Sales :     ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"systemSales"] floatValue]],@"\n"];
        currencyInfo = [NSString stringWithFormat:@"%@%@",currencyInfo,@"#######--------------------\n"];
        
        if (![[Json valueForKey:@"totalInwards"] isKindOfClass:[NSNull class]]) {
            
            currencyInfo = [NSString stringWithFormat:@"%@%@%@%@",currencyInfo,@"#######Total Inward :     ",[Json valueForKey:@"totalInwards"],@"\n"];
        }
        
        currencyInfo = [NSString stringWithFormat:@"%@%@",currencyInfo,@"#######--------------------\n"];
        currencyInfo = [NSString stringWithFormat:@"%@%@",currencyInfo,@"#######--------------------\n"];
        if (![[Json valueForKey:@"totalOutwards"] isKindOfClass:[NSNull class]]) {
            currencyInfo = [NSString stringWithFormat:@"%@%@%@%@",currencyInfo,@"#######Total Outward :     ",[Json valueForKey:@"totalOutwards"],@"\n"];
        }
        
        currencyInfo = [NSString stringWithFormat:@"%@%@",currencyInfo,@"#######--------------------\n"];
        if (![[Json valueForKey:@"systemSales"] isKindOfClass:[NSNull class]]) {
            currencyInfo = [NSString stringWithFormat:@"%@%@%@%@",currencyInfo,@"#######System Total :     ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"systemSales"] floatValue]],@"\n"];
        }
        
        
        currencyInfo = [NSString stringWithFormat:@"%@%@%@%@",currencyInfo,@"#####Collection short by :     ",[Json valueForKey:@"itemDiscount"],@"\n"];
        
        currencyInfo = [NSString stringWithFormat:@"%@%@",currencyInfo,@"#######--------------------\n"];
        
        //changed by Srinivasulu on 11/04/2018...


        NSString * excessDetails= @"####*** Short Excess Details *** \n---------------------------------\n";
        
//        excessDetails = [NSString stringWithFormat:@"%@%@%@%@%@",excessDetails,@"Pay Grp   ",@"Sys Amt   ",@"Declare Amt   ",@"Diff Amt   "];
        excessDetails = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",excessDetails,NSLocalizedString(@"pay_grp", nil),@"       ",NSLocalizedString(@"amt_grp", nil),@"   ",NSLocalizedString(@"declare_amt", nil),NSLocalizedString(@"diff_Amt", nil)];

        excessDetails = [NSString stringWithFormat:@"%@%@",excessDetails,@"\n---------------------------------\n"];
        
        float systemTotalAmt = 0.00;
        
        if (![[Json valueForKey:TENDER_HAND_OVERS] isKindOfClass:[NSNull class]]) {

            NSString * tenderDetailsStr = @"";

            for(NSDictionary * dic in [Json valueForKey:TENDER_HAND_OVERS]){
                
                float estimationAmt = 0.00;
                float decelatedAmt = 0.00;

                if (![[dic valueForKey:TENDER_NAME] isKindOfClass:[NSNull class]]){
                    
                    tenderDetailsStr = [dic valueForKey:TENDER_NAME];
                    int itemLength = (int)tenderDetailsStr.length;
                    if (itemLength >= 15) {
                        tenderDetailsStr = [NSString stringWithFormat:@"%@%@",[tenderDetailsStr substringWithRange:NSMakeRange(0, 12)],@"##"];
                    } else {
                        for (int j = 0; j < 15 - itemLength; j++) {
                            tenderDetailsStr = [NSString stringWithFormat:@"%@%@",tenderDetailsStr,@"#"];
                        }
                    }
                }
                
                if (![[dic valueForKey:ESTIMATION_AMOUNT] isKindOfClass:[NSNull class]]){
                    
                    estimationAmt = [[dic valueForKey:ESTIMATION_AMOUNT] floatValue];
                    systemTotalAmt = systemTotalAmt + estimationAmt;
                    NSString * str = [NSString stringWithFormat:@"%.2f", estimationAmt];
                    
                    for (int i = 0; i < 25 - (tenderDetailsStr.length - str.length); i++) {
                        tenderDetailsStr = [NSString stringWithFormat:@"%@%@",tenderDetailsStr,@"#"];
                    }
                    
                    tenderDetailsStr = [NSString stringWithFormat:@"%@%@", tenderDetailsStr, str];
                }
                
                if (![[dic valueForKey:DECLARED_AMOUNT] isKindOfClass:[NSNull class]]){
                    
                    decelatedAmt = [[dic valueForKey:DECLARED_AMOUNT] floatValue];
                    NSString * str = [NSString stringWithFormat:@"%.2f", decelatedAmt];
                    
                    for (int i = 0; i < 35 - (tenderDetailsStr.length - str.length); i++) {
                        tenderDetailsStr = [NSString stringWithFormat:@"%@%@",tenderDetailsStr,@"#"];
                    }
                    
                    tenderDetailsStr = [NSString stringWithFormat:@"%@%@", tenderDetailsStr, str];
                }
                NSString * str = [NSString stringWithFormat:@"%.2f", decelatedAmt - estimationAmt];

                for (int i = 0; i < 45 - (tenderDetailsStr.length - str.length); i++) {
                    tenderDetailsStr = [NSString stringWithFormat:@"%@%@",tenderDetailsStr,@"#"];
                }
                
                tenderDetailsStr = [NSString stringWithFormat:@"%@%@%@", tenderDetailsStr, str,@"\n"];
            }
            
            excessDetails = [NSString stringWithFormat:@"%@%@",excessDetails,tenderDetailsStr];
            
            excessDetails = [NSString stringWithFormat:@"%@%@",excessDetails,@"---------------------------------\n"];
            excessDetails = [NSString stringWithFormat:@"%@%@%@%.2f%@%@%@%@%@%@",excessDetails,@"Total :",@"#####",systemTotalAmt,@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"declareTotal"] floatValue]],@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"diffAmtTotal"] floatValue]],@"#####",@"\n"];
        }
        
        else {
                    excessDetails = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@",excessDetails,@"CARD",@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"cardTotal"] floatValue]],@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"declareAmtCard"] floatValue]],@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"finalCard"] floatValue]],@"#####",@"\n"];
                    excessDetails = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@",excessDetails,@"CASH",@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"cashTotal"] floatValue]],@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"declareAmtCash"] floatValue]],@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"finalCash"] floatValue]],@"#####",@"\n"];
                    excessDetails = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@",excessDetails,@"SODEX",@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"sodexoTotal"] floatValue]],@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"declareAmtSodex"] floatValue]],@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"finalSodex"] floatValue]],@"#####",@"\n"];
                    excessDetails = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@",excessDetails,@"TICKT",@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"ticketTotal"] floatValue]],@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"declareAmtTicket"] floatValue]],@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"finalTicket"] floatValue]],@"#####",@"\n"];
            
                    excessDetails = [NSString stringWithFormat:@"%@%@",excessDetails,@"---------------------------------\n"];
                    excessDetails = [NSString stringWithFormat:@"%@%@%@%.2f%@%@%@%@%@%@",excessDetails,@"Total :",@"#####",([[Json valueForKey:@"cashTotal"] floatValue]+[[Json valueForKey:@"cardTotal"] floatValue]+[[Json valueForKey:@"foodCouponsTotal"] floatValue]+0.0),@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"declareTotal"] floatValue]],@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"diffAmtTotal"] floatValue]],@"#####",@"\n"];
        }
        


        
        
//        excessDetails = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@",excessDetails,@"CARD",@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"cardTotal"] floatValue]],@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"declareAmtCard"] floatValue]],@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"finalCard"] floatValue]],@"#####",@"\n"];
//        excessDetails = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@",excessDetails,@"CASH",@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"cashTotal"] floatValue]],@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"declareAmtCash"] floatValue]],@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"finalCash"] floatValue]],@"#####",@"\n"];
//        excessDetails = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@",excessDetails,@"SODEX",@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"sodexoTotal"] floatValue]],@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"declareAmtSodex"] floatValue]],@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"finalSodex"] floatValue]],@"#####",@"\n"];
//        excessDetails = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@",excessDetails,@"TICKT",@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"ticketTotal"] floatValue]],@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"declareAmtTicket"] floatValue]],@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"finalTicket"] floatValue]],@"#####",@"\n"];
//
//        excessDetails = [NSString stringWithFormat:@"%@%@",excessDetails,@"---------------------------------\n"];
//        excessDetails = [NSString stringWithFormat:@"%@%@%@%.2f%@%@%@%@%@%@",excessDetails,@"Total :",@"#####",([[Json valueForKey:@"cashTotal"] floatValue]+[[Json valueForKey:@"cardTotal"] floatValue]+[[Json valueForKey:@"foodCouponsTotal"] floatValue]+0.0),@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"declareTotal"] floatValue]],@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"diffAmtTotal"] floatValue]],@"#####",@"\n"];
        
        
        
        
        
        
        
        
        excessDetails = [NSString stringWithFormat:@"%@%@%@%@%@",excessDetails,@"####Declared Total :     ",@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"declareTotal"] floatValue]],@"\n"];
        if (![[Json valueForKey:@"exchangeTotal"] isKindOfClass:[NSNull class]]) {
            excessDetails = [NSString stringWithFormat:@"%@%@%@%@",excessDetails,@"#######Exch Deduc :     ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"exchangeTotal"] floatValue]],@"\n"];
        }
        else {
            excessDetails = [NSString stringWithFormat:@"%@%@%@%@",excessDetails,@"#######Exch Deduc :     ",@"  Rs.  0.00",@"\n\n"];
        }
        if (![[Json valueForKey:@"returnTotal"] isKindOfClass:[NSNull class]]) {
            excessDetails = [NSString stringWithFormat:@"%@%@%@%@",excessDetails,@"#######Return Deduc :     ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"returnTotal"] floatValue]],@"\n"];
        }
        else {
            excessDetails = [NSString stringWithFormat:@"%@%@%@%@",excessDetails,@"#######Return Deduc :     ",@"  Rs.  0.00",@"\n\n"];
        }
        
        excessDetails = [NSString stringWithFormat:@"%@%@%@%@",excessDetails,@"#######System Total :     ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"systemSales"] floatValue]],@"\n"];
        excessDetails = [NSString stringWithFormat:@"%@%@",excessDetails,@"#######--------------------\n"];
        if ([[Json valueForKey:@"shortBy"] floatValue]>0) {
            
            excessDetails = [NSString stringWithFormat:@"%@%@%@%@",excessDetails,@"#######Excess By :     ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"shortBy"] floatValue]],@"\n"];
        }
        else {
            excessDetails = [NSString stringWithFormat:@"%@%@%@%@",excessDetails,@"#######Short By :     ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"shortBy"] floatValue]],@"\n"];
        }
        excessDetails = [NSString stringWithFormat:@"%@%@",excessDetails,@"---------------------------------\n"];
        
        NSString *endStr = @"<End of report>";
        
        finalPrintMessage = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@\n\n\n\n\n",storeAddress,header,body,footer,totalNumbers,transString,taxInfo,cashierInfo,currencyInfo,excessDetails,endStr];
        finalPrintMessage = [finalPrintMessage stringByReplacingOccurrencesOfString:@"#" withString:@" "];

    } @catch (NSException *exception) {
        
        @try {
            NSString *storeAddress = [WebServiceUtility getStoreAddress];
            
            NSDate *today = [NSDate date];
            NSDateFormatter *f = [[NSDateFormatter alloc] init];
            f.dateFormat = @"dd/MM/yyyy HH:mm:ss";
            NSString* currentdate = [f stringFromDate:today];
            
            
            NSString *header = [NSString stringWithFormat:@"#####%@",@"X-Reading Report"];
            header = [NSString stringWithFormat:@"%@%@\n",header,@"(Shift-End)"];
            header = [NSString stringWithFormat:@"%@%@\n",header,@"---------------------------------"];
            header = [NSString stringWithFormat:@"\n%@%@\n%@%@%@",header,currentdate,@"U :",firstName,@"##\n"];
            header = [NSString stringWithFormat:@"%@%@%@%@",header,@"Shift   #",shiftId,@"\n"];
            header = [NSString stringWithFormat:@"\n%@%@%@\n",header,@"Counter   #",counterName];
            header = [NSString stringWithFormat:@"\n%@%@%@\n",header,@"MODE : ",@"END-SHIFT"];
            header = [NSString stringWithFormat:@"%@%@",header,@"---------------------------------\n"];
            
            NSString *body;
            if (![Json[@"sales"] isKindOfClass:[NSNull class]]) {
                body = [NSString stringWithFormat:@"%@%@%@",@"Sales   (Inclusive TAX) ",@"Rs.###",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"sales"] floatValue]]];
            }
            else {
                body = [NSString stringWithFormat:@"%@\n%@",@"Sales   (Inclusive TAX) ",@"Rs.###0.00"];
            }
            if (![Json[@"itemWiseDiscount"] isKindOfClass:[NSNull class]]) {
                body=[NSString stringWithFormat:@"%@\n%@%.2f",body,@"Item Discount        (-) Rs.###",[[Json valueForKey:@"itemWiseDiscount"] floatValue]];
            }
            else {
                body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Item Discount        (-) Rs.###0.00"];
            }
            if (![Json[@"overalDiscount"] isKindOfClass:[NSNull class]]) {
                float overAllDisc = 0;
                if (![Json[@"itemWiseDiscount"] isKindOfClass:[NSNull class]]) {
                    
                    overAllDisc = [[Json valueForKey:@"itemDiscount"] floatValue] - [Json[@"itemWiseDiscount"] floatValue];
                }
                body=[NSString stringWithFormat:@"%@\n%@%.2f",body,@"Overall Discount    (-) Rs.###",overAllDisc];
            }
            else {
                body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Overall Discount    (-) Rs.###0.00"];
            }
            if (![Json[@"netSalesInclusiveTax"] isKindOfClass:[NSNull class]]) {
                body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Net Sales(Inclusive TAX) Rs.###",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"netSalesInclusiveTax"] floatValue]]];
            }
            else {
                body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Net Sales(Inclusive TAX) Rs.###0.00"];
            }
            if (![Json[@"netSalesExclusiveTax"] isKindOfClass:[NSNull class]]) {
                body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Net Sales(Exclusive TAX) Rs.###",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"netSalesExclusiveTax"] floatValue]]];
            }
            else {
                body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Net Sales(Exclusive TAX) Rs.###0.00"];
                
            }
            if (![Json[@"cess"] isKindOfClass:[NSNull class]]) {
                body=[NSString stringWithFormat:@"%@\n%@\n%@",body,@"Cess   Rs.###",[Json valueForKey:@"cess"]];
            }
            else {
                body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Cess   Rs.###0.00"];
            }
            if (![Json[@"serviceCharge"] isKindOfClass:[NSNull class]]) {
                body=[NSString stringWithFormat:@"%@\n%@\n%@",body,@"Service Charge     Rs.###",[Json valueForKey:@"serviceCharge"]];
            }
            else {
                body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Service Charge     Rs.###0.00"];
            }
            if (![Json[@"otherCharge"] isKindOfClass:[NSNull class]]) {
                body=[NSString stringWithFormat:@"%@\n%@\n%@",body,@"Other Charge     Rs.###",[Json valueForKey:@"otherCharge"]];
            }
            else {
                body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Other Charge     Rs.###0.00"];
            }
            if (![Json[@"tax"] isKindOfClass:[NSNull class]]) {
                body=[NSString stringWithFormat:@"%@\n%@%@",body,@"TAX      Rs.###",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"tax"] floatValue]]];
            }
            else {
                body=[NSString stringWithFormat:@"%@\n%@\n",body,@"TAX      Rs.###0.00"];
            }
            if (![Json[@"taxExempted"] isKindOfClass:[NSNull class]]) {
                body=[NSString stringWithFormat:@"%@\n%@\n%@",body,@"TAX Exempted     Rs.###",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"taxExempted"] floatValue]]];
            }
            else {
                body=[NSString stringWithFormat:@"%@\n%@\n",body,@"TAX Exempted     Rs.###0.00"];
            }
            if (![Json[@"totalSalesCollection"] isKindOfClass:[NSNull class]]) {
                body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Total Sales Collection     Rs.###",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"totalSalesCollection"] floatValue]]];
            }
            else {
                body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Total Sales Collection     Rs.###0.00"];
            }
            if (![Json[@"depositCollected"] isKindOfClass:[NSNull class]]) {
                body=[NSString stringWithFormat:@"%@\n%@\n%@",body,@"Deposit Collected     Rs.###",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"depositCollected"] floatValue]]];
            }
            else {
                body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Deposit Collected     Rs.###0.00"];
            }
            if (![Json[@"depositRefunded"] isKindOfClass:[NSNull class]]) {
                body=[NSString stringWithFormat:@"%@\n%@\n%@",body,@"Deposit Refunded     Rs.###",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"depositRefunded"] floatValue]]];
            }
            else {
                body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Deposit Refunded     Rs.###0.00"];
            }
            body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Deposit Forefeited     ",@"0"];
            if (![Json[@"depositesUtilized"] isKindOfClass:[NSNull class]]) {
                body=[NSString stringWithFormat:@"%@\n%@\n%@",body,@"Deposit Utilised     Rs.###",[Json valueForKey:@"depositesUtilized"]];
            }
            else {
                body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Deposit Utilised     Rs.###0.00"];
            }
            if (![Json[@"totalAmmountCollected"] isKindOfClass:[NSNull class]]) {
                body=[NSString stringWithFormat:@"%@\n%@%@\n",body,@"Total Amount Collected     Rs.###",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"totalAmmountCollected"] floatValue]]];
            }
            else {
                body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Total Amount Collected     Rs.###0.00"];
            }
            NSString *footer;
            if (![Json[@"salesReports"] isKindOfClass:[NSNull class]]) {
                footer = [NSString stringWithFormat:@"%@%@\n",@"Sales Receipts ",Json[@"salesReports"]];
            }
            else {
                footer = [NSString stringWithFormat:@"%@%@\n",@"Sales Receipts ",@""];
                
            }
            if (![Json[@"trainingReceipts"] isKindOfClass:[NSNull class]]) {
                footer = [NSString stringWithFormat:@"%@%@%@\n",footer,@"Training Receipts  ",[[Json valueForKey:@"trainingReceipts"] stringValue]];
            }
            else {
                footer = [NSString stringWithFormat:@"%@%@\n",footer,@"Training Receipts  0"];
            }
            if (![Json[@"manualReceipts"] isKindOfClass:[NSNull class]]) {
                footer = [NSString stringWithFormat:@"%@%@%@\n",footer,@"Manual Receipts  ",[[Json valueForKey:@"manualReceipts"] stringValue]];
            }
            else {
                footer = [NSString stringWithFormat:@"%@%@\n",footer,@"Manual Receipts  0"];
            }
            if (![Json[@"depositeReceipts"] isKindOfClass:[NSNull class]]) {
                footer = [NSString stringWithFormat:@"%@%@%@\n\n\n",footer,@"Deposit Receipts  ",[[Json valueForKey:@"depositeReceipts"] stringValue]];
            }
            else {
                footer = [NSString stringWithFormat:@"%@%@\n\n\n",footer,@"Deposit Receipts  0"];
            }
            if (![Json[@"refundExchange"] isKindOfClass:[NSNull class]]) {
                footer = [NSString stringWithFormat:@"%@%@%@\n",footer,@"Refund/Exchange#########",[NSString stringWithFormat:@"%.2f",[Json[@"refundExchange"] floatValue]]];
            }
            else {
                footer = [NSString stringWithFormat:@"%@%@%@\n",footer,@"Refund/Exchange#########",@"0"];
            }
            
            
            NSString *totalNumbers = [NSString stringWithFormat:@"\n%@%@%@",@"No. of Items Sold############",[Json valueForKey:@"noOfItemsSold"],@"\n"];
            totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Void Items############",[Json valueForKey:@"noOfVoidItems"],@"\n"];
            totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Disc Items############",[Json valueForKey:@"noOfDiscountedItems"],@"\n"];
            totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of No sale Done##########",[Json valueForKey:@"noOfNoSaleDone"],@"\n"];
            totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Price Overrides#######",[Json valueForKey:@"noOfPriceOverrides"],@"\n"];
            totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Line Discount#########",[Json valueForKey:@"noOfLineDiscounts"],@"\n"];
            totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Customers#############",[Json valueForKey:@"noOfCustomers"],@"\n"];
            totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Deposit Collected#####",[Json valueForKey:@"noOfDepositCollected"],@"\n"];
            totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Deposit Refunded######",[Json valueForKey:@"noOfDepositRefunded"],@"\n"];
            if (![Json[@"depositForefeited"] isKindOfClass:[NSNull class]]) {
                totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Deposit Forefeited####",[Json valueForKey:@"depositForefeited"],@"\n"];
            }
            else {
                totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Deposit Forefeited####",@"0",@"\n"];
            }
            if (![Json[@"depositesUtilized"] isKindOfClass:[NSNull class]]) {
                totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Deposit Utilized######",[Json valueForKey:@"depositesUtilized"],@"\n"];
            }
            else {
                totalNumbers = [NSString stringWithFormat:@"%@%@%@%@",totalNumbers,@"No. of Deposit Utilized######",@"0",@"\n"];
            }
            
            totalNumbers = [NSString stringWithFormat:@"%@%@",totalNumbers,@"---------------------------------\n"];
            
            NSString *transString;
            if (![[Json valueForKey:@"cardTotal"] isKindOfClass:[NSNull class]]) {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@",@"CARD######",[Json valueForKey:@"cardTransactions"],@"  Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"cardTotal"] floatValue]],@"\n\n"];
            }
            else {
                transString = [NSString stringWithFormat:@"%@%@%@%@",@"CARD######",[Json valueForKey:@"cardTransactions"],@"  Rs.  0.00",@"\n\n"];
            }
            if (![[Json valueForKey:@"cardTotal"] isKindOfClass:[NSNull class]]) {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"***Total Card######",[Json valueForKey:@"cardTransactions"],@"  Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"cardTotal"] floatValue]],@"\n\n"];
            }
            else {
                transString = [NSString stringWithFormat:@"%@%@%@%@",transString,@"***Total Card######",[Json valueForKey:@"cardTransactions"],@"  Rs.  0.00\n\n"];
            }
            if (![[Json valueForKey:@"cashTotal"] isKindOfClass:[NSNull class]]) {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"CASH######",[Json valueForKey:@"cashtransactions"],@"  Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"cashTotal"] floatValue]],@"\n\n"];
            }
            else {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"CASH######",[Json valueForKey:@"cashtransactions"],@"  Rs.  0.00",@"\n\n"];
            }
            if (![[Json valueForKey:@"cashTotal"] isKindOfClass:[NSNull class]]) {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"**Total Cash######",[Json valueForKey:@"cashtransactions"],@"  Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"cashTotal"] floatValue]],@"\n\n"];
            }
            else {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"**Total Cash######",[Json valueForKey:@"cashtransactions"],@"  Rs.  0.00",@"\n\n"];
            }
            if (![[Json valueForKey:@"sodexoTotal"] isKindOfClass:[NSNull class]]) {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"SODEXO######",[Json valueForKey:@"sodexoTransactions"],@"  Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"sodexoTotal"] floatValue]],@"\n\n"];
            }
            else {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"SODEXO######",[Json valueForKey:@"sodexoTransactions"],@"  Rs.  0.00",@"\n\n"];
            }
            if (![[Json valueForKey:@"sodexoTotal"] isKindOfClass:[NSNull class]]) {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"**Total Sodexo######",[Json valueForKey:@"sodexoTransactions"],@"  Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"sodexoTotal"] floatValue]],@"\n\n"];
            }
            else {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"**Total Sodexo######",[Json valueForKey:@"sodexoTransactions"],@"  Rs.  0.00",@"\n\n"];
            }
            
            
            
            if (![[Json valueForKey:@"ticketTotal"] isKindOfClass:[NSNull class]]) {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"TICKET######",[Json valueForKey:@"ticketTransactions"],@"  Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"ticketTotal"] floatValue]],@"\n\n"];
            }
            else {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"TICKET######",[Json valueForKey:@"ticketTransactions"],@"  Rs.  0.00",@"\n\n"];
            }
            if (![[Json valueForKey:@"ticketTotal"] isKindOfClass:[NSNull class]]) {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"**Total TICKET######",[Json valueForKey:@"ticketTransactions"],@"  Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"ticketTotal"] floatValue]],@"\n\n"];
            }
            else {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"**Total TICKET######",[Json valueForKey:@"ticketTransactions"],@"  Rs.  0.00",@"\n\n"];
            }
            
            if (![[Json valueForKey:@"giftVouchers"] isKindOfClass:[NSNull class]]) {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"VOUCHERS######",[Json valueForKey:@"totalGiftVouchers"],@"  Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"giftVouchers"] floatValue]],@"\n\n"];
            }
            else {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"VOUCHERS######",[Json valueForKey:@"totalGiftVouchers"],@"  Rs.  0.00",@"\n\n"];
            }
            
            if (![[Json valueForKey:@"giftVouchers"] isKindOfClass:[NSNull class]]) {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"**Total Vouchers######",[Json valueForKey:@"totalGiftVouchers"],@"  Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"giftVouchers"] floatValue]],@"\n\n"];
            }
            else {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"**Total Vouchers######",[Json valueForKey:@"totalGiftVouchers"],@"  Rs.  0.00",@"\n\n"];
            }
            
            if (![[Json valueForKey:@"coupons"] isKindOfClass:[NSNull class]]) {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"COUPONS######",[Json valueForKey:@"totalCoupons"],@"  Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"coupons"] floatValue]],@"\n\n"];
            }
            else {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"COUPONS######",[Json valueForKey:@"totalCoupons"],@"  Rs.  0.00",@"\n\n"];
            }
            
            if (![[Json valueForKey:@"coupons"] isKindOfClass:[NSNull class]]) {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"**Total Coupons######",[Json valueForKey:@"totalCoupons"],@"  Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"coupons"] floatValue]],@"\n\n"];
            }
            else {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"**Total Coupons######",[Json valueForKey:@"totalCoupons"],@"  Rs.  0.00",@"\n\n"];
            }
            
            if (![[Json valueForKey:@"loyaltyPointsTotal"] isKindOfClass:[NSNull class]]) {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"LOYALTY POINTS######",[Json valueForKey:@"loyaltyPointsTransactions"],@"  Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"loyaltyPointsTotal"] floatValue]],@"\n\n"];
            }
            else {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"LOYALTY POINTS######",[Json valueForKey:@"loyaltyPointsTransactions"],@"  Rs.  0.00",@"\n\n"];
            }
            
            if (![[Json valueForKey:@"loyaltyPointsTotal"] isKindOfClass:[NSNull class]]) {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"**Total Loyalty Points####",[Json valueForKey:@"loyaltyPointsTransactions"],@"  Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"loyaltyPointsTotal"] floatValue]],@"\n\n"];
            }
            else {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"**Total Loyalty Points######",[Json valueForKey:@"loyaltyPointsTransactions"],@"  Rs.  0.00",@"\n\n"];
            }
            
            if (![[Json valueForKey:@"totalCreditNoteAmt"] isKindOfClass:[NSNull class]]) {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"CREDIT NOTES######",[Json valueForKey:@"noOfCreditNotes"],@"  Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"totalCreditNoteAmt"] floatValue]],@"\n\n"];
            }
            else {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"CREDIT NOTES######",[Json valueForKey:@"noOfCreditNotes"],@"  Rs.  0.00",@"\n\n"];
            }
            
            if (![[Json valueForKey:@"totalCreditNoteAmt"] isKindOfClass:[NSNull class]]) {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"**Total Credit Notes####",[Json valueForKey:@"noOfCreditNotes"],@"  Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"totalCreditNoteAmt"] floatValue]],@"\n\n"];
            }
            else {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"**Total Credit Notes######",[Json valueForKey:@"noOfCreditNotes"],@"  Rs.  0.00",@"\n\n"];
            }
            
            if (![[Json valueForKey:@"exchangeTotal"] isKindOfClass:[NSNull class]]) {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"**Exchange Deduc######",@"        Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"exchangeTotal"] floatValue]],@"\n\n"];
            }
            else {
                transString = [NSString stringWithFormat:@"%@%@%@%@",transString,@"**Exchange Deduc######",@"  Rs.  0.00",@"\n\n"];
            }
            if (![[Json valueForKey:@"returnTotal"] isKindOfClass:[NSNull class]]) {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"**Return Deduc######",@"       Rs.  ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"returnTotal"] floatValue]],@"\n\n"];
            }
            else {
                transString = [NSString stringWithFormat:@"%@%@%@%@",transString,@"**Return Deduc######",@"        Rs.  0.00",@"\n\n"];
            }
            
            
            transString = [NSString stringWithFormat:@"%@%@",transString,@"---------------------------------\n"];
            
            NSString *taxInfo = @"";
            if (![Json[@"taxesInfo"] isKindOfClass:[NSNull class]]) {
                taxInfo = [NSString stringWithFormat:@"%@%@%@",@"Tax Code####",@"Percentage########",@"Amount\n"];
                for (NSDictionary *dic in Json[@"taxesInfo"]) {
                    taxInfo = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",taxInfo,dic[@"taxCode"] ,@"##########",[dic[@"percentage"] stringValue],@"########",@"RS   ",[NSString stringWithFormat:@"%.2f",[dic[@"amount"] floatValue]],@"\n\n"];
                }
                taxInfo = [NSString stringWithFormat:@"%@%@",taxInfo,@"---------------------------------\n"];
            }
            if (![Json[@"taxTotal"] isKindOfClass:[NSNull class]]) {
                taxInfo = [NSString stringWithFormat:@"%@%@%@%@",taxInfo,@"#######Tax Total :  RS  ",[NSString stringWithFormat:@"%.2f",[Json[@"taxTotal"] floatValue]],@"\n"];
            }
            else {
                taxInfo = [NSString stringWithFormat:@"%@%@",taxInfo,@"#######Tax Total :  RS  0.00\n"];
            }
            taxInfo = [NSString stringWithFormat:@"%@%@",taxInfo,@"---------------------------------\n"];
            
            NSString *cashierInfo = [NSString stringWithFormat:@"%@%@%@",@"Cashier##",@"Incl Tax Sales ##",@"Excl Tax Sales\n\n"];
            if (![Json[@"netSalesInclusiveTax"] isKindOfClass:[NSNull class]]) {
                cashierInfo = [NSString stringWithFormat:@"%@%@%@%@%@",cashierInfo,firstName,@"#######",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"netSalesInclusiveTax"] floatValue]],@"###"];
            }
            else {
                cashierInfo = [NSString stringWithFormat:@"%@%@%@%@",cashierInfo,firstName,@"#######0.00",@"###"];
            }
            if (![Json[@"netSalesExclusiveTax"] isKindOfClass:[NSNull class]]) {
                cashierInfo = [NSString stringWithFormat:@"%@%@%@%@",cashierInfo,@"###",[NSString stringWithFormat:@"%.2f",[Json[@"netSalesExclusiveTax"] floatValue]],@"\n"];
            }
            else {
                cashierInfo = [NSString stringWithFormat:@"%@%@",cashierInfo,@"###0.00\n"];
            }
            
            cashierInfo = [NSString stringWithFormat:@"%@%@",cashierInfo,@"---------------------------------\n"];
            
            if (![Json[@"netSalesInclusiveTax"] isKindOfClass:[NSNull class]]) {
                cashierInfo = [NSString stringWithFormat:@"%@%@%@%@%@",cashierInfo,@"Cashier Total :",@"#######",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"netSalesInclusiveTax"] floatValue]],@"###"];
            }
            else {
                cashierInfo = [NSString stringWithFormat:@"%@%@%@%@",cashierInfo,@"Cashier Total :",@"#######0.00",@"###"];
            }
            if (![Json[@"netSalesExclusiveTax"] isKindOfClass:[NSNull class]]) {
                cashierInfo = [NSString stringWithFormat:@"%@%@%@%@",cashierInfo,@"###",[NSString stringWithFormat:@"%.2f",[Json[@"netSalesExclusiveTax"] floatValue]],@"\n"];
            }
            else {
                cashierInfo = [NSString stringWithFormat:@"%@%@",cashierInfo,@"###0.00\n"];
            }
            
            cashierInfo = [NSString stringWithFormat:@"%@\n%@",cashierInfo,@"---------------------------------\n"];
            
            NSString *currencyInfo = @"####*** Currency Declaration *** \n---------------------------------\n";
            currencyInfo = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",currencyInfo,@"Code ###",@"Name ###",@"DENOM ###",@"Colle ###",@"AMT ###",@"\n"];
            if (![Json[@"denominations"] isKindOfClass:[NSNull class]]) {
                for (NSDictionary *dic in Json[@"denominations"]) {
                    if ([dic[@"currencyName"] length] > 4 && [dic[@"currencyName"] length] == 7) {
                        currencyInfo = [NSString stringWithFormat:@"%@%@%@%@%@%@",currencyInfo,dic[@"currCode"] ,@"####",dic[@"currencyName"] ,@"####",[dic[@"denomination"] stringValue]];
                        
                        if ([dic[@"denomination"] stringValue].length >= 4) {
                            currencyInfo = [NSString stringWithFormat:@"%@%@%@%@%@%@",currencyInfo,@"##",[dic[@"collection"] stringValue],@"####",[dic[@"amount"] stringValue],@"\n"];
                        }
                        else if ([dic[@"denomination"] stringValue].length == 3) {
                            currencyInfo = [NSString stringWithFormat:@"%@%@%@%@%@%@",currencyInfo,@"####",[dic[@"collection"] stringValue],@"######",[dic[@"amount"] stringValue],@"\n"];
                        }
                        else if ([dic[@"denomination"] stringValue].length == 2) {
                            currencyInfo = [NSString stringWithFormat:@"%@%@%@%@%@%@",currencyInfo,@"####",[dic[@"collection"] stringValue],@"######",[dic[@"amount"] stringValue],@"\n"];
                        }
                        else {
                            currencyInfo = [NSString stringWithFormat:@"%@%@%@%@%@%@",currencyInfo,@"#########",[dic[@"collection"] stringValue],@"#####",[dic[@"amount"] stringValue],@"\n"];
                        }
                    }
                    else if ([dic[@"currencyName"] length] > 4 && [dic[@"currencyName"] length] == 6) {
                        currencyInfo = [NSString stringWithFormat:@"%@%@%@%@%@%@",currencyInfo,dic[@"currCode"] ,@"###",dic[@"currencyName"] ,@"##",[dic[@"denomination"] stringValue]];
                        if ([dic[@"denomination"] stringValue].length >= 4) {
                            currencyInfo = [NSString stringWithFormat:@"%@%@%@%@%@%@",currencyInfo,@"##",[dic[@"collection"] stringValue],@"####",[dic[@"amount"] stringValue],@"\n"];
                        }
                        else if ([dic[@"denomination"] stringValue].length == 3) {
                            currencyInfo = [NSString stringWithFormat:@"%@%@%@%@%@%@",currencyInfo,@"####",[dic[@"collection"] stringValue],@"######",[dic[@"amount"] stringValue],@"\n"];
                        }
                        else if ([dic[@"denomination"] stringValue].length == 2) {
                            currencyInfo = [NSString stringWithFormat:@"%@%@%@%@%@%@",currencyInfo,@"######",[dic[@"collection"] stringValue],@"#######",[dic[@"amount"] stringValue],@"\n"];
                        }
                        else {
                            currencyInfo = [NSString stringWithFormat:@"%@%@%@%@%@%@",currencyInfo,@"#########",[dic[@"collection"] stringValue],@"#####",[dic[@"amount"] stringValue],@"\n"];
                        }
                        
                    }
                    else {
                        currencyInfo = [NSString stringWithFormat:@"%@%@%@%@%@%@",currencyInfo,dic[@"currCode"] ,@"######",dic[@"currencyName"] ,@"#####",[dic[@"denomination"] stringValue]];
                        if ([dic[@"denomination"] stringValue].length >= 4) {
                            currencyInfo = [NSString stringWithFormat:@"%@%@%@",currencyInfo,@"######",[dic[@"collection"] stringValue]];
                        }
                        else if ([dic[@"denomination"] stringValue].length == 3) {
                            currencyInfo = [NSString stringWithFormat:@"%@%@%@",currencyInfo,@"#######",[dic[@"collection"] stringValue]];
                        }
                        else if ([dic[@"denomination"] stringValue].length == 2) {
                            currencyInfo = [NSString stringWithFormat:@"%@%@%@",currencyInfo,@"########",[dic[@"collection"] stringValue]];
                        }
                        else {
                            currencyInfo = [NSString stringWithFormat:@"%@%@%@",currencyInfo,@"#########",[dic[@"collection"] stringValue]];
                        }
                        
                        if ([dic[@"collection"] stringValue].length >= 4) {
                            currencyInfo = [NSString stringWithFormat:@"%@%@%@%@",currencyInfo,@"##",[dic[@"amount"] stringValue],@"\n"];
                        }
                        else if ([dic[@"collection"] stringValue].length == 3) {
                            currencyInfo = [NSString stringWithFormat:@"%@%@%@%@",currencyInfo,@"###",[dic[@"amount"] stringValue],@"\n"];
                        }
                        else if ([dic[@"collection"] stringValue].length == 2) {
                            currencyInfo = [NSString stringWithFormat:@"%@%@%@%@",currencyInfo,@"####",[dic[@"amount"] stringValue],@"\n"];
                        }
                        else {
                            currencyInfo = [NSString stringWithFormat:@"%@%@%@%@",currencyInfo,@"#####",[dic[@"amount"] stringValue],@"\n"];
                            
                        }
                    }
                }
                currencyInfo = [NSString stringWithFormat:@"%@%@",currencyInfo,@"---------------------------------\n"];
            }
            if ([[Json valueForKey:@"openBalance"] floatValue]>0) {
                
                currencyInfo = [NSString stringWithFormat:@"%@%@%@%@",currencyInfo,@"#######Open Balance :     ",[Json valueForKey:@"openBalance"],@"\n"];
            }
            currencyInfo = [NSString stringWithFormat:@"%@%@%@%@",currencyInfo,@"#######System Sales :     ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"systemSales"] floatValue]],@"\n"];
            currencyInfo = [NSString stringWithFormat:@"%@%@",currencyInfo,@"#######--------------------\n"];
            
            if (![[Json valueForKey:@"totalInwards"] isKindOfClass:[NSNull class]]) {
                
                currencyInfo = [NSString stringWithFormat:@"%@%@%@%@",currencyInfo,@"#######Total Inward :     ",[Json valueForKey:@"totalInwards"],@"\n"];
            }
            
            currencyInfo = [NSString stringWithFormat:@"%@%@",currencyInfo,@"#######--------------------\n"];
            currencyInfo = [NSString stringWithFormat:@"%@%@",currencyInfo,@"#######--------------------\n"];
            if (![[Json valueForKey:@"totalOutwards"] isKindOfClass:[NSNull class]]) {
                currencyInfo = [NSString stringWithFormat:@"%@%@%@%@",currencyInfo,@"#######Total Outward :     ",[Json valueForKey:@"totalOutwards"],@"\n"];
            }
            
            currencyInfo = [NSString stringWithFormat:@"%@%@",currencyInfo,@"#######--------------------\n"];
            if (![[Json valueForKey:@"systemSales"] isKindOfClass:[NSNull class]]) {
                currencyInfo = [NSString stringWithFormat:@"%@%@%@%@",currencyInfo,@"#######System Total :     ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"systemSales"] floatValue]],@"\n"];
            }
            
            
            currencyInfo = [NSString stringWithFormat:@"%@%@%@%@",currencyInfo,@"#####Collection short by :     ",[Json valueForKey:@"itemDiscount"],@"\n"];
            
            currencyInfo = [NSString stringWithFormat:@"%@%@",currencyInfo,@"#######--------------------\n"];
            
            
            NSString *excessDetails= @"####*** Short Excess Details *** \n---------------------------------\n";
            
            excessDetails = [NSString stringWithFormat:@"%@%@%@%@%@",excessDetails,@"Pay Grp   ",@"Sys Amt   ",@"Declare Amt   ",@"Diff Amt   "];
            excessDetails = [NSString stringWithFormat:@"%@%@",excessDetails,@"\n---------------------------------\n"];
            
            
            excessDetails = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@",excessDetails,@"CARD",@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"cardTotal"] floatValue]],@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"declareAmtCard"] floatValue]],@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"finalCard"] floatValue]],@"#####",@"\n"];
            excessDetails = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@",excessDetails,@"CASH",@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"cashTotal"] floatValue]],@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"declareAmtCash"] floatValue]],@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"finalCash"] floatValue]],@"#####",@"\n"];
            excessDetails = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@",excessDetails,@"SODEX",@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"sodexoTotal"] floatValue]],@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"declareAmtSodex"] floatValue]],@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"finalSodex"] floatValue]],@"#####",@"\n"];
            excessDetails = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@",excessDetails,@"TICKT",@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"ticketTotal"] floatValue]],@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"declareAmtTicket"] floatValue]],@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"finalTicket"] floatValue]],@"#####",@"\n"];
            
            excessDetails = [NSString stringWithFormat:@"%@%@",excessDetails,@"---------------------------------\n"];
            excessDetails = [NSString stringWithFormat:@"%@%@%@%.2f%@%@%@%@%@%@",excessDetails,@"Total :",@"#####",([[Json valueForKey:@"cashTotal"] floatValue]+[[Json valueForKey:@"cardTotal"] floatValue]+[[Json valueForKey:@"foodCouponsTotal"] floatValue]+0.0),@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"declareTotal"] floatValue]],@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"diffAmtTotal"] floatValue]],@"#####",@"\n"];
            
            excessDetails = [NSString stringWithFormat:@"%@%@%@%@%@",excessDetails,@"####Declared Total :     ",@"#####",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"declareTotal"] floatValue]],@"\n"];
            if (![[Json valueForKey:@"exchangeTotal"] isKindOfClass:[NSNull class]]) {
                excessDetails = [NSString stringWithFormat:@"%@%@%@%@",excessDetails,@"#######Exch Deduc :     ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"exchangeTotal"] floatValue]],@"\n"];
            }
            else {
                excessDetails = [NSString stringWithFormat:@"%@%@%@%@",excessDetails,@"#######Exch Deduc :     ",@"  Rs.  0.00",@"\n\n"];
            }
            if (![[Json valueForKey:@"returnTotal"] isKindOfClass:[NSNull class]]) {
                excessDetails = [NSString stringWithFormat:@"%@%@%@%@",excessDetails,@"#######Return Deduc :     ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"returnTotal"] floatValue]],@"\n"];
            }
            else {
                excessDetails = [NSString stringWithFormat:@"%@%@%@%@",excessDetails,@"#######Return Deduc :     ",@"  Rs.  0.00",@"\n\n"];
            }
            
            excessDetails = [NSString stringWithFormat:@"%@%@%@%@",excessDetails,@"#######System Total :     ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"systemSales"] floatValue]],@"\n"];
            excessDetails = [NSString stringWithFormat:@"%@%@",excessDetails,@"#######--------------------\n"];
            if ([[Json valueForKey:@"shortBy"] floatValue]>0) {
                
                excessDetails = [NSString stringWithFormat:@"%@%@%@%@",excessDetails,@"#######Excess By :     ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"shortBy"] floatValue]],@"\n"];
            }
            else {
                excessDetails = [NSString stringWithFormat:@"%@%@%@%@",excessDetails,@"#######Short By :     ",[NSString stringWithFormat:@"%.2f",[[Json valueForKey:@"shortBy"] floatValue]],@"\n"];
            }
            excessDetails = [NSString stringWithFormat:@"%@%@",excessDetails,@"---------------------------------\n"];
            
            NSString *endStr = @"<End of report>";
            
            finalPrintMessage = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@\n\n\n\n\n",storeAddress,header,body,footer,totalNumbers,transString,taxInfo,cashierInfo,currencyInfo,excessDetails,endStr];
            finalPrintMessage = [finalPrintMessage stringByReplacingOccurrencesOfString:@"#" withString:@" "];
            
        } @catch (NSException *exception) {
            
        }
    } @finally {
        
        return finalPrintMessage;
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


-(void)goToHome {
    
    OmniHomePage *home = [[OmniHomePage alloc]init];
    [self.navigationController pushViewController:home animated:YES];
    
}

- (void)viewDidUnload {
    [self setXReportsScrollView:nil];
    [self setXReportTxtView:nil];
//    [self setXReportLbl:nil];
    [self setValidateReportBtn:nil];
    [super viewDidUnload];
}


#pragma -mark methods modified by Srinivasulu on 20/06/2017 for using star printer....

-(void)printReports:(NSDictionary *)response reportType:(NSString *)reportTye {
    
    @try {
        
        //changed the print logic on 11/07/2017....
        if (printer) {
            
            @try {
                
                [printer addObserver:self];
                
                PowaPrinterSettings *settings = [PowaPrinterSettings defaultSettings];
                settings.leftMargin = 5;
                settings.quality = 1;
                settings.speed = PowaPrinterSpeedAuto;
                [printer setPrinterSettings:settings];
                
                [printer startReceipt];
                NSString *str;
                if ([reportTye isEqualToString:@"x"]) {
                    NSLog(@"report Type %@",reportTye);
                    str = [self printXString:response];
                    
                }
                else if ([reportTye isEqualToString:@"z"]) {
                    NSLog(@"report Type %@",reportTye);
                    
                    //            str = [self printZString:response];
                    
                }
                else if ([reportTye isEqualToString:@"xz"]) {
                    NSLog(@"report Type %@",reportTye);
                    
                    //            str = [self printXZString:response];
                    
                }
                //            [printer printImage:[UIImage imageNamed:@"sampoorna.jpg"] threshold:0.5];
                //                            [self.tseries printImage:[UIImage imageNamed:@"sampoorna.jpg"]];
                
                //            [printer printImage:[UIImage imageNamed:@"sahyadri_logo.png"] threshold:0.5];
                
                
                
                //added by Srinivasulu on 07/06/2017....
                
                NSUserDefaults *   defaults = [[NSUserDefaults alloc]init];
                
                if(([[defaults valueForKey:LOGO_URL] length] > 0) && (! [[defaults valueForKey:LOGO_URL]  isKindOfClass:[NSNull class]])){
                    
                    
                    NSURL * url = [NSURL URLWithString:[defaults valueForKey:LOGO_URL]];
                    
                    
                    //getting images usings Synchronous Calling....
                    NSData *imgData = [NSData dataWithContentsOfURL:url];
                    
                    
                    if (imgData != nil && [UIImage imageWithData:imgData] != nil) {
                        
                        
                        [printer printImage:[UIImage imageWithData:imgData] threshold:0.5];
                    }
                    
                }
                
                //upto here on 02/06/2017....
                
                [printer printText:str];
                [printer printReceipt];
                
                
            }
            @catch (NSException *exception) {
                
                NSLog(@"%@",exception);
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Failed to get print" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }
            
        }
        else{
            
            NSArray *portInfoArray;
            
            //              case 1  :     // LAN
            portInfoArray = [SMPort searchPrinter:@"TCP:"];
            
            if(portInfoArray.count){
                
                NSString * portName   = [OmniRetailerAppDelegate getPortName];
                NSString * modelName  = [OmniRetailerAppDelegate getModelName];
                NSString * macAddress = [OmniRetailerAppDelegate getMacAddress];
                
                for (PortInfo *portInfo in portInfoArray) {
                    
                    portName = portInfo.portName;
                    modelName = portInfo.modelName;
                    macAddress = portInfo.macAddress;
                    
                    break;
                }
                
                if(!isPrinted){
                    
                    ModelIndex modelIndex = [ModelCapability modelIndexAtModelName:modelName];
                    
                    portSettings = [ModelCapability portSettingsAtModelIndex:modelIndex];
                    emulation    = [ModelCapability emulationAtModelIndex   :modelIndex];
                    
                    isPrinted = true;
                }
                
                if(([self printXString:response].length) && ( [reportTye isEqualToString:@"x"] )){
                    
                    
                    NSData * commands = [self createRasterReceiptData:emulation printMessage:[self printXString:response]];
                    
                    [Communication sendCommands:commands portName:portName portSettings:portSettings timeout:10000 completionHandler:^(BOOL result, NSString *title, NSString *message) {     // 10000mS!!!
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        
                        [alertView show];
                    }];
                }
                else{
                    
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"No data to print." message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    
                }
                
                
                
            }
            else{
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Unable to find the printer. Please check the printer cable." message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }

        
        }
        
        
        //upto here on 11/07/2017.....
        
//        if ([custID caseInsensitiveCompare:@"CID8995458"] == NSOrderedSame) {
//
//        NSArray *portInfoArray;
//        
//        
//        //              case 1  :     // LAN
//        portInfoArray = [SMPort searchPrinter:@"TCP:"];
//        
//        if([portInfoArray count]){
//            
//            NSString * portName   = [OmniRetailerAppDelegate getPortName];
//            NSString * modelName  = [OmniRetailerAppDelegate getModelName];
//            NSString * macAddress = [OmniRetailerAppDelegate getMacAddress];
//            
//            for (PortInfo *portInfo in portInfoArray) {
//                
//                portName = portInfo.portName;
//                modelName = portInfo.modelName;
//                macAddress = portInfo.macAddress;
//                
//                break;
//            }
//            
//            if(!isPrinted){
//                
//                ModelIndex modelIndex = [ModelCapability modelIndexAtModelName:modelName];
//                
//                portSettings = [ModelCapability portSettingsAtModelIndex:modelIndex];
//                emulation    = [ModelCapability emulationAtModelIndex   :modelIndex];
//                
//                isPrinted = true;
//            }
//            
//            if(([[self printXString:response] length]) && ( [reportTye isEqualToString:@"x"] )){
//                
//                
//                NSData * commands = [self createRasterReceiptData:emulation printMessage:[self printXString:response]];
//                
//                [Communication sendCommands:commands portName:portName portSettings:portSettings timeout:10000 completionHandler:^(BOOL result, NSString *title, NSString *message) {     // 10000mS!!!
//                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                    
//                    [alertView show];
//                }];
//            }
//            else{
//                
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"No data to print." message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                [alert show];
//                
//            }
//            
//            
//            
//        }
//        else{
//            
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Unable to find the printer. Please check the printer cable." message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//            
//        }
//            
//        }
//        else{
//            if (printer) {
//                
//                
//                @try {
//                    
//                    [printer addObserver:self];
//                    
//                    PowaPrinterSettings *settings = [PowaPrinterSettings defaultSettings];
//                    settings.leftMargin = 5;
//                    settings.quality = 1;
//                    settings.speed = PowaPrinterSpeedAuto;
//                    [printer setPrinterSettings:settings];
//                    
//                    [printer startReceipt];
//                    NSString *str;
//                    if ([reportTye isEqualToString:@"x"]) {
//                        NSLog(@"report Type %@",reportTye);
//                        str = [self printXString:response];
//                        
//                    }
//                    else if ([reportTye isEqualToString:@"z"]) {
//                        NSLog(@"report Type %@",reportTye);
//                        
//                        //            str = [self printZString:response];
//                        
//                    }
//                    else if ([reportTye isEqualToString:@"xz"]) {
//                        NSLog(@"report Type %@",reportTye);
//                        
//                        //            str = [self printXZString:response];
//                        
//                    }
//                    //            [printer printImage:[UIImage imageNamed:@"sampoorna.jpg"] threshold:0.5];
//                    //                            [self.tseries printImage:[UIImage imageNamed:@"sampoorna.jpg"]];
//                    
//                    //            [printer printImage:[UIImage imageNamed:@"sahyadri_logo.png"] threshold:0.5];
//                    
//                    
//                    
//                    
//                    
//                    
//                    //added by Srinivasulu on 07/06/2017....
//                    
//                    NSUserDefaults *   defaults = [[NSUserDefaults alloc]init];
//                    
//                    if(([[defaults valueForKey:LOGO_URL] length] > 0) && (! [[defaults valueForKey:LOGO_URL]  isKindOfClass:[NSNull class]])){
//                        
//                        
//                        NSURL * url = [NSURL URLWithString:[defaults valueForKey:LOGO_URL]];
//                        
//                        
//                        //getting images usings Synchronous Calling....
//                        NSData *imgData = [NSData dataWithContentsOfURL:url];
//                        
//                        
//                        if (imgData != nil && [UIImage imageWithData:imgData] != nil) {
//                            
//                            
//                            [printer printImage:[UIImage imageWithData:imgData] threshold:0.5];
//                        }
//                        
//                    }
//                    
//                    //upto here on 02/06/2017....
//                    
//                    [printer printText:str];
//                    [printer printReceipt];
//                    
//                    
//                }
//                @catch (NSException *exception) {
//                    
//                    NSLog(@"%@",exception);
//                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Failed to get print" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                    [alert show];
//                    
//                }
//                
//            }
//            else {
//                // NSString *str = [self printString:response];
//                
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Printer is not connected" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                [alert show];
//            }
//            
//        }
        
    } @catch (NSException *exception) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Unable to find the printer. Please check the printer cable." message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    } @finally {
        
    }
    
    
    //    if (printer) {
    //
    //
    //        @try {
    //
    //            [printer addObserver:self];
    //
    //            PowaPrinterSettings *settings = [PowaPrinterSettings defaultSettings];
    //            settings.leftMargin = 5;
    //            settings.quality = 1;
    //            settings.speed = PowaPrinterSpeedAuto;
    //            [printer setPrinterSettings:settings];
    //
    //            [printer startReceipt];
    //            NSString *str;
    //            if ([reportTye isEqualToString:@"x"]) {
    //                NSLog(@"report Type %@",reportTye);
    //                str = [self printXString:response];
    //
    //            }
    //            else if ([reportTye isEqualToString:@"z"]) {
    //                NSLog(@"report Type %@",reportTye);
    //
    //                //            str = [self printZString:response];
    //
    //            }
    //            else if ([reportTye isEqualToString:@"xz"]) {
    //                NSLog(@"report Type %@",reportTye);
    //
    //                //            str = [self printXZString:response];
    //
    //            }
    //            //            [printer printImage:[UIImage imageNamed:@"sampoorna.jpg"] threshold:0.5];
    //            //                            [self.tseries printImage:[UIImage imageNamed:@"sampoorna.jpg"]];
    //
    //            //            [printer printImage:[UIImage imageNamed:@"sahyadri_logo.png"] threshold:0.5];
    //
    //
    //
    //
    //
    //
    //            //added by Srinivasulu on 07/06/2017....
    //
    //            NSUserDefaults *   defaults = [[NSUserDefaults alloc]init];
    //
    //            if(([[defaults valueForKey:LOGO_URL] length] > 0) && (! [[defaults valueForKey:LOGO_URL]  isKindOfClass:[NSNull class]])){
    //
    //
    //                NSURL * url = [NSURL URLWithString:[defaults valueForKey:LOGO_URL]];
    //
    //
    //                //getting images usings Synchronous Calling....
    //                NSData *imgData = [NSData dataWithContentsOfURL:url];
    //
    //
    //                if (imgData != nil && [UIImage imageWithData:imgData] != nil) {
    //
    //
    //                    [printer printImage:[UIImage imageWithData:imgData] threshold:0.5];
    //                }
    //
    //            }
    //
    //            //upto here on 02/06/2017....
    //
    //            [printer printText:str];
    //            [printer printReceipt];
    //
    //
    //        }
    //        @catch (NSException *exception) {
    //
    //            NSLog(@"%@",exception);
    //            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Failed to get print" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //            [alert show];
    //
    //        }
    //
    //    }
    //    else {
    //        // NSString *str = [self printString:response];
    //
    //        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Printer is not connected" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //        [alert show];
    //    }
    
}


#pragma -mark methods added by Srinivasulu on 20/06/2017 which are used for star printer....

//#pragma -mark methods used for printing bill throught starPrinter....

/**
 * @description  here we are converting printStream string into image and then to NSData.....
 * @date         20/06/2017....
 * @method       createRasterReceiptData:
 * @author       Srinivasulu
 * @param
 * @param        StarIoExtEmulation
 * @param
 * @return       NSData
 * @verified By
 * @verified On
 *
 */

- (NSData *)createRasterReceiptData:(StarIoExtEmulation)emulation printMessage:(NSString *)msgStr{
    
    @try {
        
        
        UIImage * image =  [self imageWithString:msgStr font:[UIFont fontWithName:kLabelFont size:24] width:834];
        
        ISCBBuilder * builder = [StarIoExt createCommandBuilder:emulation];
        
        [builder beginDocument];
        
        [builder appendBitmap:image diffusion:NO];
        
        [builder appendCutPaper:SCBCutPaperActionPartialCutWithFeed];
        
        [builder endDocument];
        
        return [builder.commands copy];
        
    } @catch (NSException *exception) {
        
    }
    
}


/**
 * @description  here we are converting printStream string into image and then to NSData.....
 * @date         20/06/2017....
 * @method       imageWithString:--  font:--  width:--
 * @author       Srinivasulu
 * @param
 * @param        StarIoExtEmulation
 * @param
 * @return       NSData
 * @verified By
 * @verified On
 *
 */

- (UIImage *)imageWithString:(NSString *)string font:(UIFont *)font width:(CGFloat)width {
    
    @try {
        
        NSDictionary *attributeDic = @{NSFontAttributeName:font};
        
        CGSize size = [string boundingRectWithSize:CGSizeMake(width, 10000)
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                                        attributes:attributeDic
                                           context:nil].size;
        
        if ([UIScreen.mainScreen respondsToSelector:@selector(scale)]) {
            if (UIScreen.mainScreen.scale == 2.0) {
                UIGraphicsBeginImageContextWithOptions(size, NO, 1.0);
            } else {
                UIGraphicsBeginImageContext(size);
            }
        } else {
            UIGraphicsBeginImageContext(size);
        }
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        [[UIColor whiteColor] set];
        
        CGRect rect = CGRectMake(0, 0, size.width + 1, size.height + 1);
        
        CGContextFillRect(context, rect);
        
        NSDictionary *attributes = @ {
        NSForegroundColorAttributeName:[UIColor blackColor],
        NSFontAttributeName:font
        };
        
        [string drawInRect:rect withAttributes:attributes];
        
        UIImage *imageToPrint = UIGraphicsGetImageFromCurrentImageContext();
        
        
        
        //added by Srinivasulu on 21/06/2017....
        @try {
            
            NSUserDefaults *   defaults = [[NSUserDefaults alloc]init];
            
            if((([[defaults valueForKey:LOGO_URL] length] > 0) && (! [[defaults valueForKey:LOGO_URL]  isKindOfClass:[NSNull class]])) && (!isOfflineService)){
                
                
                NSURL * url = [NSURL URLWithString:[defaults valueForKey:LOGO_URL]];
                
                
                //getting images usings Synchronous Calling....
                NSData *imgData = [NSData dataWithContentsOfURL:url];
                
                
                if (imgData != nil && [UIImage imageWithData:imgData] != nil) {
                    
                    
                    
                    UIImage *image2 = [UIImage imageWithData:imgData];
                    
                    CGSize size1 = CGSizeMake(imageToPrint.size.width, imageToPrint.size.height + image2.size.height);
                    
                    UIGraphicsBeginImageContext(size);
                    
                    [image2 drawInRect:CGRectMake(0,0,size1.width, image2.size.height)];
                    [imageToPrint drawInRect:CGRectMake(0,image2.size.height,size1.width, imageToPrint.size.height)];
                    
                    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
                    
                    UIGraphicsEndImageContext();
                    
                    //set finalImage to IBOulet UIImageView
                    imageToPrint = finalImage;
                }
                
            }
            
        } @catch (NSException *exception) {
            
        }
        
        //upto here on 21/06/2017...
        
        
        UIGraphicsEndImageContext();
        
        return imageToPrint;
        
    } @catch (NSException *exception) {
        
    }
    
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    
//    textView.textAlignment = NSTextAlignmentRight;
}

@end
