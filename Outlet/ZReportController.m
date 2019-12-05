//
//  XReportController.m
//  OmniRetailer
//
//  Created by MACPC on 9/28/15.
//
//

#import "ZReportController.h"
#import "RequestHeader.h"

//added by Srinivasulu on 19/06/2017....
//reason is used for starIO_print....

#import "OmniRetailerAppDelegate.h"

//#import "ModelCapability.h"

#import <StarIO/SMPort.h>

#import "Communication.h"
#import "ModelCapability.h"

//upto here on 19/06/2017....


@interface  ZReportController()

@end


@implementation ZReportController
@synthesize zReportTxtView,currenDateLbl,businessDateLbl,currenDateValueLbl,businessDateValueLbl,locationLbl,counterLbl,locationValueLbl,counterValueLbl,shiftsView,shiftsLbl,shiftDisplayScrollView,dateTxt,goButton,printButton,emailBtn,showCalenderBtn,instructionsTxtView;
@synthesize soundFileURLRef,soundFileObject;


@synthesize totalCustomerWalkOuts, walkOutReason,callWalkinService;

#pragma  -mark start of ViewLifeCycle mehods....

/**
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date
 * @method       ViewDidLoad
 * @author
 * @param
 * @param
 * @return
 *
 * @modified By Srinivasulu on 11/10/2017....
 * @reason      added the comments and changed the code alignment     .... not completed....
 *
 * @verified By
 * @verified On
 *
 */

- (void)viewDidLoad {
    
    //calling super call method....
    [super viewDidLoad];
    
    
    //ProgressBar creation...
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;

    
    // Audio Sound load url......
    NSURL * tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    
    //creation of standardUserDefaults....
    defaults = [[NSUserDefaults alloc]init];
    
    //creation on NSDictionary to store the service response....
    //it's need to be change to NSMutableDictionary not conform written by Srinivasulu on 21/10/2017....
    JSON = [NSDictionary new];
    
    
    //Creation of UITableView....
    shiftsTbl = [[UITableView alloc] init];
    shiftsTbl.backgroundColor = [UIColor clearColor];
    shiftsTbl.dataSource = self;
    shiftsTbl.delegate = self;
    
    
    //creation NSMutableArray used to dispaly the shifts....
    //it needs to be modifed for dynamic display.. using service call.. Written by Srinivasulu on 21/10/2017....
    shiftsArr = [[NSMutableArray alloc] init];
    
    [shiftsArr addObject:@"1"];
    [shiftsArr addObject:@"2"];
    [shiftsArr addObject:@"3"];
    
    
    //populating the static test into the UILabel, UITextView placeholders....
    @try {
        self.dateTxt.textColor = [UIColor whiteColor];
        
        self.titleLabel.text = @"Z-REPORT";
        NSDate * today = [NSDate date];
        NSDateFormatter *f = [[NSDateFormatter alloc] init];
        f.dateFormat = @"dd/MM/yyyy";
        NSString * currentdate = [f stringFromDate:today];
        
        businessDateValueLbl.text = [NSString stringWithFormat:@"%@",[defaults valueForKey:BUSSINESS_DATE]];
        currenDateValueLbl.text = currentdate;
        
        locationValueLbl.text = presentLocation;
        counterValueLbl.text = counterName;
        
        dateTxt.text = [NSString stringWithFormat:@"%@",[defaults valueForKey:BUSSINESS_DATE]];
        printButton.layer.cornerRadius = 10.0f;
        goButton.layer.cornerRadius = 10.0f;
        emailBtn.layer.cornerRadius = 10.0f;
        
        zReportTxtView.layer.borderColor = [UIColor whiteColor].CGColor;
        zReportTxtView.layer.borderWidth = 4.0f;
        zReportTxtView.layer.cornerRadius = 10.0f;
        zReportTxtView.textColor = [UIColor whiteColor];
        
        
        shiftsView.layer.borderColor = [UIColor whiteColor].CGColor;
        shiftsView.layer.borderWidth = 2.0f;
        shiftsView.layer.cornerRadius = 5.0f;
        
        shiftDisplayScrollView.layer.borderColor = [UIColor whiteColor].CGColor;
        shiftDisplayScrollView.layer.borderWidth = 2.0f;
        shiftDisplayScrollView.layer.cornerRadius = 5.0f;
        NSLocalizedString(@"point_1", nil);
        
        NSString * str = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"instructions_:", nil),@"\n"];
        
        str = [NSString stringWithFormat:@"%@%@%@",str,NSLocalizedString(@"point_1", nil),@"\n\n"];
        str = [NSString stringWithFormat:@"%@%@%@",str,NSLocalizedString(@"point_2", nil),@"\n\n"];
        str = [NSString stringWithFormat:@"%@%@%@",str,NSLocalizedString(@"point_3", nil),@"\n\n"];
        str = [NSString stringWithFormat:@"%@%@%@",str,NSLocalizedString(@"point_4", nil),@"\n\n"];
        str = [NSString stringWithFormat:@"%@%@",str,NSLocalizedString(@"point_5", nil)];
        
        locationValueLbl.textAlignment = NSTextAlignmentLeft;
        counterValueLbl.textAlignment = NSTextAlignmentLeft;
        
        instructionsTxtView.text = str;
        [instructionsTxtView setContentOffset:CGPointZero animated:NO];
        
    } @catch (NSException *exception) {
        
    }
    
    [shiftDisplayScrollView addSubview:shiftsTbl];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
//        if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
//            
//        }
//        else{
//            
//        }
        
        self.view.frame = CGRectMake(0, 0, [ UIScreen mainScreen ].bounds.size.width, [ UIScreen mainScreen ].bounds.size.height);
        
        currenDateLbl.frame =  CGRectMake( 10, 90, 130, 25);
        businessDateLbl.frame = CGRectMake( currenDateLbl.frame.origin.x, currenDateLbl.frame.origin.y + currenDateLbl.frame.size.height + 5, currenDateLbl.frame.size.width, currenDateLbl.frame.size.height);
        
        currenDateValueLbl.frame =  CGRectMake( currenDateLbl.frame.origin.x + currenDateLbl.frame.size.width, currenDateLbl.frame.origin.y, 90, currenDateLbl.frame.size.height);
        businessDateValueLbl.frame = CGRectMake( currenDateValueLbl.frame.origin.x, businessDateLbl.frame.origin.y, currenDateValueLbl.frame.size.width, currenDateLbl.frame.size.height);
        
        locationLbl.frame =  CGRectMake( currenDateValueLbl.frame.origin.x + currenDateValueLbl.frame.size.width + 10, currenDateLbl.frame.origin.y, 90, currenDateLbl.frame.size.height);
        counterLbl.frame = CGRectMake( locationLbl.frame.origin.x, businessDateLbl.frame.origin.y, locationLbl.frame.size.width, currenDateLbl.frame.size.height);
        
        locationValueLbl.frame =  CGRectMake( locationLbl.frame.origin.x + locationLbl.frame.size.width + 10, currenDateLbl.frame.origin.y, 120, currenDateLbl.frame.size.height);
        counterValueLbl.frame = CGRectMake( locationValueLbl.frame.origin.x, businessDateLbl.frame.origin.y, locationValueLbl.frame.size.width, currenDateLbl.frame.size.height);
        
        zReportTxtView.frame = CGRectMake( locationValueLbl.frame.origin.x + locationValueLbl.frame.size.width + 50, currenDateLbl.frame.origin.y, self.view.frame.size.width - (locationValueLbl.frame.origin.x + locationValueLbl.frame.size.width + 130), self.view.frame.size.height - (currenDateLbl.frame.origin.y + 10));
        
        
        shiftsView.frame = CGRectMake( currenDateLbl.frame.origin.x, counterValueLbl.frame.origin.y + counterValueLbl.frame.size.height + 10, counterValueLbl.frame.origin.x + counterValueLbl.frame.size.width - (currenDateLbl.frame.origin.x + 20), 150);
        
        shiftsLbl.frame = CGRectMake( shiftsView.frame.origin.x + 10, 0, currenDateValueLbl.frame.origin.x + currenDateValueLbl.frame.size.width - (currenDateLbl.frame.origin.x + 20), 30);
        
        shiftDisplayScrollView.frame = CGRectMake( 0, shiftsLbl.frame.size.height, shiftsView.frame.size.width, shiftsView.frame.size.height - shiftsLbl.frame.size.height);
        
        shiftsTbl.frame =  CGRectMake( 0, 0, shiftDisplayScrollView.frame.size.width, shiftDisplayScrollView.frame.size.height);
        
        dateTxt.frame = CGRectMake( currenDateLbl.frame.origin.x, shiftsView.frame.origin.y + shiftsView.frame.size.height + 10, 200, 40);
        
        showCalenderBtn.frame = CGRectMake((dateTxt.frame.origin.x + dateTxt.frame.size.width - 45), dateTxt.frame.origin.y + 2, 40, 35);
        
        goButton.frame = CGRectMake( shiftsView.frame.origin.x + shiftsView.frame.size.width - 160, dateTxt.frame.origin.y, 160, 40);
        
        printButton.frame = CGRectMake( goButton.frame.origin.x, goButton.frame.origin.y + goButton.frame.size.height + 10, goButton.frame.size.width, goButton.frame.size.height);
        
        emailBtn.frame = CGRectMake( goButton.frame.origin.x, printButton.frame.origin.y + printButton.frame.size.height + 10, goButton.frame.size.width, goButton.frame.size.height);
        
        instructionsTxtView.frame = CGRectMake( shiftsView.frame.origin.x, emailBtn.frame.origin.y + emailBtn.frame.size.height + 10, goButton.frame.origin.x + goButton.frame.size.width, self.view.frame.size.height - (emailBtn.frame.origin.y + emailBtn.frame.size.height + 20));
        
        [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:16.0f cornerRadius:0];
        instructionsTxtView.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0];
    }
    else{
        
    }
    
}

/**
 * @description  it is one of ViewLifeCylce Method which will be executed after execution of viewDidLoad.......
 * @date
 * @method       viewDidAppear:--
 * @author
 * @param        BOOL
 * @param
 *
 * @return       void
 *
 * @modified By Srinivasulu on 13/06/2017....
 * @reason      added the comments and changed the directly calling of the z reprot service, exception handling....
 *
 * @verified By
 * @verified On
 *
 */

-(void)viewDidAppear:(BOOL)animated {
    
    @try {
        [super viewDidAppear:YES];
        
        HUD.labelText = NSLocalizedString(@"genarating_reports..", nil);
        [HUD setHidden:NO];
        
        //changed by Srinivasulu on 16/10/2017....
        if(callWalkinService){
            
            [self callingCustomerWalkinsSummary];
        }
        else{
            
            [self getXZReports:@"z"];
            [HUD setHidden:YES];
        }
        //upto her on 16/10/2017....
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
    }
}

/**
 * @description  it is one of ViewLifeCylce Method which will be executed after execution of viewDidLoad.......
 * @date
 * @method       viewWillDisappear:--
 * @author
 * @param        BOOL
 * @param
 *
 * @return       void
 *
 * @modified By Srinivasulu on 10/10/2017....
 * @reason      added the comments and changed the directly calling of the z reprot service, exception handling....
 *
 * @verified By
 * @verified On
 *
 */

-(void)viewWillDisappear:(BOOL)animated {
    
    @try {
        
        [printer removeObserver:self];
        [scanner removeObserver:self];
    }
    @catch (NSException *exception) {
        
        NSLog(@"Exception %@",exception);
    }
    
}

/**
 * @description  it is one of ViewLifeCylce Method which will be executed after execution of viewDidLoad.......
 * @date
 * @method       viewDidUnload
 * @author
 * @param
 * @param
 *
 * @return       void
 *
 * @modified By Srinivasulu on 10/10/2017....
 * @reason      added the comments and changed the directly calling of the z reprot service, exception handling  && commented by Srinivasulu on 21/10/2017 because this method  is deprecated in iOS 6....
 *
 * @verified By
 * @verified On
 *
 */

//- (void)viewDidUnload {
//    //    [self setZReportsScrollView:nil];
//    //    [self setZReportTxtView:nil];
//    //    //    [self setXReportLbl:nil];
//    //    [self setValidateReportBtn:nil];
//    //    [self setDateTxt:nil];
//    //    [self setGoButton:nil];
//    //    [super viewDidUnload];
//}

#pragma -mark end of ViewLifeCylce Methods....

/**
 * @description  it will be executed when memory warning is receiveds.......
 * @date
 * @method       didReceiveMemoryWarning
 * @author
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 13/06/2017....
 * @reason      added the comments and     .... not completed....
 *
 */

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


#pragma -mark Start of Service call used in this page....

/**
 * @description  here we are calling customer walk in service call if any exceptions occurs in catch block we are calling the z - report service call....
 * @date         10/10/2017....
 * @method       callingCustomerWalkinsSummary
 * @author
 * @param
 * @param
 * @param
 *
 * @return       void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)callingCustomerWalkinsSummary{
    @try {
        AudioServicesPlaySystemSound(soundFileObject);
        
        [HUD setHidden: NO];
        
        NSDate * today = [NSDate date];
        NSDateFormatter * f = [[NSDateFormatter alloc] init];
        f.dateFormat = @"dd/MM/yyyy HH:mm:ss";
        NSString * currentdate = [f stringFromDate:today];
        
        NSString * businessDate = @"";
        if ((self.dateTxt.text).length > 0) {
            
            businessDate = [NSString stringWithFormat:@"%@%@%@",self.dateTxt.text,@" ",[currentdate componentsSeparatedByString:@" "][1]];
        }
        else {
            
            businessDate = [NSString stringWithFormat:@"%@%@%@",[defaults valueForKey:BUSSINESS_DATE],@" ",[currentdate componentsSeparatedByString:@" "][1]];
        }
        
        int walkOuts =  totalCustomerWalkOuts.intValue;
        
        NSArray * keys = @[REQUEST_HEADER,STORELOCATION,COUNTER,BUSSINESS_DATE,NO_OF_WALKINS,WALKIN_DESCRIPTIONS];
        NSArray * objects = @[[RequestHeader getRequestHeader],presentLocation,counterName,businessDate,@(walkOuts),walkOutReason];
        
        NSDictionary * dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        
        NSString * walkInsJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.customerWalkoutDelegate = self;
        [webServiceController createNewCustomerWalkinsInfo:walkInsJsonString];
    }
    @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        [self getXZReports:@"z"];
    }
    
}

#pragma -mark start of serviceCall response handling....

/**
 * @description  here we are handling the service call success response && we are calling the z - report service calling method....
 * @date         10/10/2017....
 * @method       createCustomerWalkinsSuccessResponse:
 * @author       Srinivasulu
 * @param        NSDictionary
 * @param
 *
 * @return       void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)createCustomerWalkinsSuccessResponse:(NSDictionary *)sucessDictionary{
    
    @try {
        
        [self getXZReports:@"z"];
        [HUD setHidden:YES];
    } @catch (NSException *exception) {
       
        [HUD setHidden:YES];
    }
}

/**
 * @description  here we are handling the service call error response && we are calling the z - report service calling method....
 * @date         10/10/2017....
 * @method       createCustomerWalkinsErrorResponse:
 * @author       Srinivasulu
 * @param        NSString
 * @param
 *
 * @return       void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)createCustomerWalkinsErrorResponse:(NSString *)error{
    
    @try {
        
        [self getXZReports:@"z"];
        [HUD setHidden:YES];
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
    }
}

#pragma -mark calling Z-report Service call....

/**
 * @description  here we are calling Z - report Service call....
 * @date
 * @method       getXZReports:--
 * @author
 * @param        NSString
 * @param
 * @param
 *
 * @return       void
 *
 * @modified By  modified by Srinivasulu on 10/10/2017....
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

// Commented by roja on 17/10/2019.. // reason :- getXZReports: method contains SOAP Service call .. so taken new method with same name(getXZReports:) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//-(void)getXZReports:(NSString *)reportType {
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
//            NSDate * today = [NSDate date];
//            NSDateFormatter *f = [[NSDateFormatter alloc] init];
//            f.dateFormat = @"dd/MM/yyyy HH:mm:ss";
//            NSString * currentdate = [f stringFromDate:today];
//
//
//            NSString * businessDate = @"";
//            if ((self.dateTxt.text).length > 0) {
//
//                businessDate = [NSString stringWithFormat:@"%@%@%@",self.dateTxt.text,@" ",[currentdate componentsSeparatedByString:@" "][1]];
////                businessDate = [NSString stringWithFormat:@"%@%@%@",self.dateTxt.text,@" ",@"00:00:00"];
//
//            }
//            else {
//
//                businessDate = [NSString stringWithFormat:@"%@%@%@",[defaults valueForKey:BUSSINESS_DATE],@" ",[currentdate componentsSeparatedByString:@" "][1]];
////                businessDate = [NSString stringWithFormat:@"%@%@%@",[defaults valueForKey:BUSSINESS_DATE],@" ",@"00:00:00"];
//
//            }
//
//            //added by Srinivasulu on 18/10/2017....
//            NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
//            dateFormatter.dateFormat = @"dd/MM/yyyy";
//            NSString * bussinessDateStr = [defaults valueForKey:BUSSINESS_DATE];
//
//            NSDate * dateFromString = [[NSDate alloc] init];
//            dateFromString = [dateFormatter dateFromString:bussinessDateStr];
//
//            if((self.dateTxt.text).length > 0){
//
//                if(defaults == nil)
//                    defaults = [[NSUserDefaults alloc]init];
//
//                NSString * selectedDateStr = [self.dateTxt.text copy];
//
//                NSDate * selectedDate = [[NSDate alloc] init];
//                selectedDate = [dateFormatter dateFromString:selectedDateStr];
//
//                NSDate * todayDate = [[NSDate alloc] init];
//                todayDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:today]];
//
//                if (([WebServiceUtility numberOfDaysDifference:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@",[defaults valueForKey:BUSSINESS_DATE]]]] >= 1) && ([selectedDate compare:todayDate] == NSOrderedDescending)){
//
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"further_day_z_report_alert", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
//                    [alert show];
//                    [HUD setHidden:YES];
//                    return;
//                }
//
//            }
//
//            //upto here on 18/10/2017....
//
//
//            NSArray *keys = @[COUNTER,CASHIER_ID,SHIFT_ID,kReportDate,REQUEST_HEADER,STORE_LOCATION,START_INDEX,REPORT_TYPE,kCustomerBillId];
//
//            NSArray *objects  = @[counterName,firstName,[NSString stringWithFormat:@"%@",shiftId],[NSString stringWithFormat:@"%@",businessDate],[RequestHeader getRequestHeader],presentLocation,@"0",reportType,@(isCustomerBillId)];
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
//                        NSDictionary  *json = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                              options: NSJSONReadingMutableContainers
//                                                                                error: &e];
//
//                        JSON = [json copy];
//
//                        if ([[[json valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue] == 0) {
//
//                            //                            [self printReports:JSON reportType:reportType];
//                            self.zReportTxtView.text = [self printZString:json];
//                            self.zReportTxtView.textColor = [UIColor whiteColor];
//                            JSON = [json copy];
//                            //                            self.xReportTxtView.text = @"Hello How are You ??...";
//
//                            //added by Srinivasulu on 31/08/2017....
//                            //reason is to change the changing of business date issue....
//
//                            NSString * bussinessDateStr = [NSString stringWithFormat:@"%@",[defaults valueForKey:BUSSINESS_DATE]];
//                            NSString * selectedDateStr = [self.dateTxt.text copy];
//
//                            if([bussinessDateStr caseInsensitiveCompare:selectedDateStr] == NSOrderedSame){
//
//                                printButton.tag = 0;
//                                self.goButton.tag = 0;
//                            }
//                            else{
//
//                                printButton.tag = 1;
//                                self.goButton.tag = 1;
//                            }
//
//                            //upto here on 31/08/2017....
//
//
//                        }
//                        else {
//
//                            //added by Srinivasulu on 18/10/2017 && 10/04/2018 reson handled the something went Wrong response also....
//                            //changed the logic on 24/10/2017....
//
//                            if((([WebServiceUtility numberOfDaysDifference:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@",bussinessDateStr]]] >= 1) && ([[dateFormatter dateFromString:[dateFormatter stringFromDate:today]]  compare:dateFromString] == NSOrderedDescending)) && (([[[json valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]  caseInsensitiveCompare:@"No Records Found"] == NSOrderedSame) || ([[[json valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]  caseInsensitiveCompare:@"Something went Wrong"] == NSOrderedSame)) ){
//
//                                [defaults setValue:[[WebServiceUtility getCurrentDate] componentsSeparatedByString:@" "][0] forKey:BUSSINESS_DATE];
//                                [defaults setValue:@"0000" forKey:LAST_BILL_COUNT];
//                                [defaults setValue:@"0.00" forKey:LAST_BILL_TOTAL];
//                                [defaults setObject:@(false)  forKey:IS_DAY_CLOSURE_TAKEN];
//                                [defaults setObject:@(false)  forKey:IS_DAY_OPEN];
//                            }
//
//                            //upto here on 18/10/2017....
//
//
//                            self.zReportTxtView.text = @"";
//
//                            //added by Srinivasulu on 31/08/2017....
//                            //reason is to change the changing of business date issue....
//
//                            printButton.tag = 1;
//                            self.goButton.tag = 1;
//
//                            //upto here on 31/08/2017....
//
//
//                            //added by Srinivasulu on 23/10/2017....
//
//                            if([[[json valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]  caseInsensitiveCompare:@"No Records Found"] == NSOrderedSame){
//
//                                NSString * str = [NSString stringWithFormat:@"%@%@%@", NSLocalizedString(@"z_report_info_alert_1", nil),dateTxt.text,NSLocalizedString(@"z_report_info_alert_2", nil)];
//
//                                str = [NSString stringWithFormat:@"%@", NSLocalizedString(@"z_report_info_alert_3", nil)];
//
//                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:nil  delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
//                                [alert show];
//                            }
//                            else{
//
//                                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%@",[[json valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_MESSAGE]] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                                [alert show];
//                            }
//                            //upto here on 23/10/2017....
//
//                        }
//
//                        //[HUD setHidden:YES];
//                    }
//                }
//            }
//            else {
//
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Failed to print the report" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                [alert show];
//            }
//
//
//        }
//        @catch (NSException *exception) {
//
//        }
//        @finally {
//
//            [HUD setHidden:YES];
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
-(void)getXZReports:(NSString *)reportType {
    
    CheckWifi *WIFI = [[CheckWifi alloc]init];
    BOOL status = [WIFI checkWifi];
    
    if (status) {
        
        @try {
            [HUD show:YES];
            [HUD setHidden:NO];

            NSDate * today = [NSDate date];
            NSDateFormatter *f = [[NSDateFormatter alloc] init];
            f.dateFormat = @"dd/MM/yyyy HH:mm:ss";
            NSString * currentdate = [f stringFromDate:today];
            
            NSString * businessDate = @"";
            if ((self.dateTxt.text).length > 0) {
                
                businessDate = [NSString stringWithFormat:@"%@%@%@",self.dateTxt.text,@" ",[currentdate componentsSeparatedByString:@" "][1]];
                //                businessDate = [NSString stringWithFormat:@"%@%@%@",self.dateTxt.text,@" ",@"00:00:00"];
            }
            else {
                
                businessDate = [NSString stringWithFormat:@"%@%@%@",[defaults valueForKey:BUSSINESS_DATE],@" ",[currentdate componentsSeparatedByString:@" "][1]];
                //                businessDate = [NSString stringWithFormat:@"%@%@%@",[defaults valueForKey:BUSSINESS_DATE],@" ",@"00:00:00"];
            }
            
            //added by Srinivasulu on 18/10/2017....
            NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"dd/MM/yyyy";
            NSString * bussinessDateStr = [defaults valueForKey:BUSSINESS_DATE];
            
            NSDate * dateFromString = [[NSDate alloc] init];
            dateFromString = [dateFormatter dateFromString:bussinessDateStr];
            
            
            if((self.dateTxt.text).length > 0){
                
                if(defaults == nil)
                    defaults = [[NSUserDefaults alloc]init];
                
                NSString * selectedDateStr = [self.dateTxt.text copy];
                
                NSDate * selectedDate = [[NSDate alloc] init];
                selectedDate = [dateFormatter dateFromString:selectedDateStr];
                
                NSDate * todayDate = [[NSDate alloc] init];
                todayDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:today]];
                
                if (([WebServiceUtility numberOfDaysDifference:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@",[defaults valueForKey:BUSSINESS_DATE]]]] >= 1) && ([selectedDate compare:todayDate] == NSOrderedDescending)){
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"further_day_z_report_alert", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
                    [alert show];
                    [HUD setHidden:YES];
                    return;
                }
                
            }
            
            //upto here on 18/10/2017....
            
            NSArray *keys = @[COUNTER,CASHIER_ID,SHIFT_ID,kReportDate,REQUEST_HEADER,STORE_LOCATION,START_INDEX,REPORT_TYPE,kCustomerBillId];
            
            NSArray *objects  = @[counterName,firstName,[NSString stringWithFormat:@"%@",shiftId],[NSString stringWithFormat:@"%@",businessDate],[RequestHeader getRequestHeader],presentLocation,@"0",reportType,@(isCustomerBillId)];
            
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            
            NSError * err;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
            NSString * createBillingJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            WebServiceController * services = [[WebServiceController alloc] init];
            services.salesServiceDelegate = self;
            [services getXZReports:createBillingJsonString];
        }
        @catch (NSException *exception) {
            
            [HUD setHidden:YES];
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
        self.zReportTxtView.text = [self printZString:successDictionary];
        self.zReportTxtView.textColor = [UIColor whiteColor];
        JSON = [successDictionary copy];
        //                            self.xReportTxtView.text = @"Hello How are You ??...";
        
        //added by Srinivasulu on 31/08/2017....
        //reason is to change the changing of business date issue....
        
        NSString * bussinessDateStr = [NSString stringWithFormat:@"%@",[defaults valueForKey:BUSSINESS_DATE]];
        NSString * selectedDateStr = [self.dateTxt.text copy];
        
        if([bussinessDateStr caseInsensitiveCompare:selectedDateStr] == NSOrderedSame){
            
            printButton.tag = 0;
            self.goButton.tag = 0;
        }
        else{
            
            printButton.tag = 1;
            self.goButton.tag = 1;
        }
        
        //upto here on 31/08/2017....
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}

// added by Roja on 17/10/2019….
- (void)getXZReportErrorResponse:(NSString *)errorResponse{
    
    @try {
        
        NSDate * today = [NSDate date];

        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"dd/MM/yyyy";
        NSString * bussinessDateStr = [defaults valueForKey:BUSSINESS_DATE];
        
        NSDate * dateFromString = [[NSDate alloc] init];
        dateFromString = [dateFormatter dateFromString:bussinessDateStr];
        
        
        //added by Srinivasulu on 18/10/2017 && 10/04/2018 reson handled the something went Wrong response also....
        //changed the logic on 24/10/2017....
        
        if((([WebServiceUtility numberOfDaysDifference:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@",bussinessDateStr]]] >= 1) && ([[dateFormatter dateFromString:[dateFormatter stringFromDate:today]]  compare:dateFromString] == NSOrderedDescending)) && (([errorResponse  caseInsensitiveCompare:@"No Records Found"] == NSOrderedSame) || ([errorResponse  caseInsensitiveCompare:@"Something went Wrong"] == NSOrderedSame)) ){
            
            [defaults setValue:[[WebServiceUtility getCurrentDate] componentsSeparatedByString:@" "][0] forKey:BUSSINESS_DATE];
            [defaults setValue:@"0000" forKey:LAST_BILL_COUNT];
            [defaults setValue:@"0.00" forKey:LAST_BILL_TOTAL];
            [defaults setObject:@(false)  forKey:IS_DAY_CLOSURE_TAKEN];
            [defaults setObject:@(false)  forKey:IS_DAY_OPEN];
        }
        
        //upto here on 18/10/2017....
        
        
        self.zReportTxtView.text = @"";
        
        //added by Srinivasulu on 31/08/2017....
        //reason is to change the changing of business date issue....
        
        printButton.tag = 1;
        self.goButton.tag = 1;
        
        //upto here on 31/08/2017....
        
        
        //added by Srinivasulu on 23/10/2017....
        
        if([errorResponse caseInsensitiveCompare:@"No Records Found"] == NSOrderedSame){
            
            NSString * str = [NSString stringWithFormat:@"%@%@%@", NSLocalizedString(@"z_report_info_alert_1", nil),dateTxt.text,NSLocalizedString(@"z_report_info_alert_2", nil)];
            
            str = [NSString stringWithFormat:@"%@", NSLocalizedString(@"z_report_info_alert_3", nil)];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:nil  delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:errorResponse message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        //upto here on 23/10/2017....
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}




#pragma -mark methods used for displaying and populating the calenderview....

/**
 * @description  here we are showing the calender popUP....
 * @date
 * @method       DateButtonPressed:--
 * @author
 * @param        UIButton
 * @param
 * @param
 *
 * @return       IBAction
 *
 * @modified By  modified by Srinivasulu on 11/10/2017....
 * @reason       added the comment's and still need's to modify the code....
 *
 * @verified By
 * @verified On
 *
 */

- (IBAction)DateButtonPressed:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320, 320)];
        customView.opaque = NO;
        customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customView.layer.borderWidth = 2.0f;
        [customView setHidden:NO];
        
        pickView = [[UIView alloc] init];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            pickView.frame = CGRectMake( 15, self.dateTxt.frame.origin.y+self.dateTxt.frame.size.height, 320, 320);
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
        
        //        myPicker.datePickerMode = UIDatePickerModeTime;
        
        UIButton  *pickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [pickButton setBackgroundImage:[UIImage imageNamed:@"ok2.png"] forState:UIControlStateNormal];
        
        
        //        pickButton.backgroundColor = [UIColor grayColor];
        
        
        
        //        pickButton.backgroundColor = [UIColor clearColor];
        pickButton.layer.masksToBounds = YES;
        [pickButton addTarget:self action:@selector(populateDateToTextField:) forControlEvents:UIControlEventTouchUpInside];
        //        pickButton.layer.borderColor = [UIColor blackColor].CGColor;
        //        pickButton.layer.borderWidth = 0.5f;
        //        pickButton.layer.cornerRadius = 12;
        pickButton.tag = sender.tag;
        [customView addSubview:myPicker];
        [customView addSubview:pickButton];
        
        
        //added by srinivasulu on 02/02/2017....
        
        UIButton  *clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [clearButton setBackgroundImage:[UIImage imageNamed:@"Clear.png"] forState:UIControlStateNormal];
        
        
        //        pickButton.backgroundColor = [UIColor grayColor];
        
        
        
        //        clearButton.backgroundColor = [UIColor clearColor];
        clearButton.layer.masksToBounds = YES;
        [clearButton addTarget:self action:@selector(clearDate:) forControlEvents:UIControlEventTouchUpInside];
        //        clearButton.layer.borderColor = [UIColor blackColor].CGColor;
        //        clearButton.layer.borderWidth = 0.5f;
        //        clearButton.layer.cornerRadius = 12;
        clearButton.tag = sender.tag;
        [customView addSubview:clearButton];
        
        
        
        //        pickButton.frame = CGRectMake( (customView.frame.size.width / 2) - (100/2), 269, 100, 45);
        //        clearButton.frame = CGRectMake( (customView.frame.size.width / 2) - (100/2), 269, 100, 45);
        
        pickButton.frame = CGRectMake( ((customView.frame.size.width - 230)/ 3), 270, 110, 45);
        clearButton.frame = CGRectMake( pickButton.frame.origin.x + pickButton.frame.size.width + ((customView.frame.size.width - 200)/ 3), pickButton.frame.origin.y, pickButton.frame.size.width, pickButton.frame.size.height);
        
        
        //upto here on 02/02/2017....
        
        
        customerInfoPopUp.view = customView;
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            
            [popover presentPopoverFromRect:self.dateTxt.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
            
            catPopOver= popover;
            
        }
        
        else {
            
            //            customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            popover.contentViewController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
            [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            catPopOver = popover;
            
        }
        
        UIGraphicsBeginImageContext(customView.frame.size);
        [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        customView.backgroundColor = [UIColor colorWithPatternImage:image];
    } @catch (NSException *exception) {
        
        NSLog(@"----exception in the stockReceiptView in showCalenderInPopUp:----%@",exception);
        NSLog(@"------exception while creating the popUp in stockView------%@",exception);
        
    }
    
}

/**
 * @description  here we are populating text into the textFields....
 * @date
 * @method       populateDateToTextField:--
 * @author
 * @param        UIButton
 * @param
 * @param
 *
 * @return       IBAction
 *
 * @modified By  modified by Srinivasulu on 11/10/2017....
 * @reason       added the comment's and still need's to modify the code....
 *
 * @verified By
 * @verified On
 *
 */

-(void)populateDateToTextField:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        //Date Formate Setting...
        NSDateFormatter *requiredDateFormat = [[NSDateFormatter alloc] init];
        //        [requiredDateFormat setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        requiredDateFormat.dateFormat = @"dd/MM/yyyy";
        dateString = [requiredDateFormat stringFromDate:myPicker.date];
        
        
        NSDate *selectedDateString = [requiredDateFormat dateFromString:[requiredDateFormat stringFromDate:myPicker.date]];
        
        
        // getting present date & time ..
        NSDate *today = [NSDate date];
        NSDateFormatter *f = [[NSDateFormatter alloc] init];
        f.dateFormat = @"dd/MM/yyyy";
        NSString* currentdate = [f stringFromDate:today];
        today = [f dateFromString:currentdate];
        
        if( [today compare:selectedDateString] == NSOrderedAscending ){
            
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"message", nil) message:NSLocalizedString(@"selected_date_can_not_be_more_than_current_data", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
            [alert show];

            return;
        }
        

        [catPopOver dismissPopoverAnimated:YES];
        dateTxt.text = dateString;
        
    } @catch (NSException *exception) {
        
    }
    @finally{
    }
    
}

/**
 * @description  here we are clearing text into....
 * @date
 * @method       clearDate:--
 * @author
 * @param        UIButton
 * @param
 * @param
 *
 * @return       IBAction
 *
 * @modified By  modified by Srinivasulu on 11/10/2017....
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)clearDate:(UIButton *)sender{
    //    BOOL callServices = false;
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        [catPopOver dismissPopoverAnimated:YES];
        if((self.dateTxt.text).length){
            
            self.dateTxt.text = @"";
        }
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        NSLog(@"---- exception in StockReceiptView -- in  -- clearDate() ----");
        NSLog(@"---- exception is ----%@",exception);
    }
}

/**
 * @description  here we are clearing text into....
 * @date
 * @method       getDate:--
 * @author
 * @param        id
 * @param
 * @param
 *
 * @return       IBAction
 *
 * @modified By  modified by Srinivasulu on 11/10/2017....
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

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
    
    
    [pickView removeFromSuperview];
}

#pragma -mark start of actions used in this viewController....

/**
 * @description  here we are calling the service to generate the z report....
 * @date
 * @method       generateReport:--
 * @author
 * @param        id
 * @param
 * @param
 *
 * @return       IBAction
 *
 * @modified By  modified by Srinivasulu on 11/10/2017....
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

- (IBAction)generateReport:(UIButton *)sender {
    
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        if((dateTxt.text).length){
        
            [HUD setHidden:NO];
        [self getXZReports:@"z"];
        }
        else{
            
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"message", nil) message:NSLocalizedString(@"please_select_the_date_before_generating_z_report", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
            [alert show];
        }
    } @catch (NSException *exception) {
        
    }
}

/**
 * @description  here we are calling the service to send the email to client....
 * @date         21/10/2017....
 * @method       gobuttonPressed:--
 * @author       Srinivasulu
 * @param        id
 * @param
 * @param
 *
 * @return       IBAction
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

- (IBAction)emailbtn:(UIButton *)sender{
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"This feature is not available with this edition" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}
#pragma -mark methods using for forming the z-report....

/**
 * @description  here we are printing the ....
 * @date
 * @method       print
 * @author
 * @param
 * @param
 * @param
 *
 * @return       void
 *
 * @modified By  modified by Srinivasulu on 11/10/2017....
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

- (IBAction)printCompleteZReport:(id)sender {
    
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
       
        if ( [JSON.allKeys containsObject:RESPONSE_HEADER] &&   ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue] == 0)) {
            
            [self printReports:JSON reportType:@"z"];
        }
        else {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"no_data_to_print", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
            [alert show];
        }
        
    } @catch (NSException *exception) {
        
    }
 
}

/**
 * @description  here we are printing the ....
 * @date
 * @method       printZString:--
 * @author
 * @param        NSDictionary
 * @param
 * @param
 *
 * @return       NSString
 *
 * @modified By  modified by Srinivasulu on 11/10/2017....
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(NSString *)printZString:(NSDictionary *)Json {
    NSString *finalPrintMessage = @"";
    
    @try {
        
        
        NSString * storeAddress = [WebServiceUtility getStoreAddress];
        
        
        NSDate * today = [NSDate date];
        NSDateFormatter * f = [[NSDateFormatter alloc] init];
        f.dateFormat = @"dd/MM/yyyy HH:mm:ss";
        NSString * currentdate = [f stringFromDate:today];
        
        //added by Srinivasulu on 23/10/2017....
        
        if((dateTxt.text).length){
            
            currentdate = [NSString stringWithFormat:@"%@%@%@", dateTxt.text,@" ",[currentdate componentsSeparatedByString:@" "][1]];
        }
        
        //upto here on 23/10/2017....
        
        NSString * header = [NSString stringWithFormat:@"%@\n",@"---------------------------------"];
        header = [NSString stringWithFormat:@"\n%@%@\n%@%@",header,currentdate,@"U :",firstName];
        header = [NSString stringWithFormat:@"\n%@ %@\n",header,@"Z-Readings Report"];
        header = [NSString stringWithFormat:@"\n%@%@%@\n",header,@"MODE : ",@"END-DAY"];
        header = [NSString stringWithFormat:@"%@%@",header,@"---------------------------------\n"];
        
        
        if (( [Json.allKeys containsObject:CONTENT] &&  ![Json[CONTENT] isKindOfClass:[NSNull class]])) {
            
            NSString * contentStr = Json[CONTENT];

            NSString *endStr = @"<End of report>";
            
            finalPrintMessage = [NSString stringWithFormat:@"%@%@%@%@",storeAddress,header,contentStr,endStr];
            finalPrintMessage = [finalPrintMessage stringByReplacingOccurrencesOfString:@"#" withString:@" "];
        }
        else {
          
            NSString *body;
            if (![Json[@"sales"] isKindOfClass:[NSNull class]]) {
                body = [NSString stringWithFormat:@"%@%@%@",@"Sales   (Inclusive TAX) ",@"Rs.###",[Json valueForKey:@"sales"]];
            }
            else {
                body = [NSString stringWithFormat:@"%@\n%@",@"Sales   (Inclusive TAX) ",@"Rs.###0.00"];
            }
            
            //added by Srinivasulu on 15/04/2017....
            
            if ((![Json[@"pendingBills"] isKindOfClass:[NSNull class]]) && ([Json.allKeys containsObject:@"pendingBills"])) {
                body=[NSString stringWithFormat:@"%@\n%@%.f",body,@"Pending Bills Count           ###",[[Json valueForKey:@"pendingBills"] floatValue]];
            }
            else {
                body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Pending Bills Count        ###0.00"];
            }
            
            if ((![Json[@"pendingBillsAmt"] isKindOfClass:[NSNull class]]) && ([Json.allKeys containsObject:@"pendingBillsAmt"])) {
                body=[NSString stringWithFormat:@"%@\n%@%.2f",body,@"Pending Bills Amt           Rs.###",[[Json valueForKey:@"pendingBillsAmt"] floatValue]];
            }
            else {
                body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Pending Bills Amt           Rs.###0.00"];
            }
            
            //upto here on 15/04/2017....
            
            
            //added by Srinivasulu on 02/05/2017....
            
            if ((![Json[@"noOfCreditBills"] isKindOfClass:[NSNull class]]) && ([Json.allKeys containsObject:@"noOfCreditBills"])) {
                body=[NSString stringWithFormat:@"%@\n%@%.f",body,@"Credit Bills Count           ###",[[Json valueForKey:@"noOfCreditBills"] floatValue]];
            }
            else {
                body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Credit Bills Count        ###0.00"];
            }
            
            if ((![Json[@"totalCreditBillsAmt"] isKindOfClass:[NSNull class]]) && ([Json.allKeys containsObject:@"totalCreditBillsAmt"])) {
                body=[NSString stringWithFormat:@"%@\n%@%.2f",body,@"Credit Bills Amt               Rs.###",[[Json valueForKey:@"totalCreditBillsAmt"] floatValue]];
            }
            else {
                body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Credit Bills Amt               Rs.###0.00"];
            }
            
            if ((![Json[@"totalDayTurnOverAmt"] isKindOfClass:[NSNull class]]) && ([Json.allKeys containsObject:@"totalDayTurnOverAmt"])) {
                body=[NSString stringWithFormat:@"%@\n%@%.2f",body,@"Total Day Turn Over Amt   Rs.###",[[Json valueForKey:@"totalDayTurnOverAmt"] floatValue]];
            }
            else {
                body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Total Day Turn Over Amt   Rs.###0.00"];
            }
            
            //upto here 02/05/2017....
            
            
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
                body=[NSString stringWithFormat:@"%@\n%@",body,@"Overall Discount    (-) Rs.###0.00"];
            }
            if (![Json[@"netSalesInclusiveTax"] isKindOfClass:[NSNull class]]) {
                body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Net Sales(Inclusive TAX) Rs.###",[[Json valueForKey:@"netSalesInclusiveTax"] stringValue]];
            }
            else {
                body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Net Sales(Inclusive TAX) Rs.###0.00"];
            }
            if (![Json[@"netSalesExclusiveTax"] isKindOfClass:[NSNull class]]) {
                body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Net Sales(Exclusive TAX) Rs.###",[[Json valueForKey:@"netSalesExclusiveTax"] stringValue]];
            }
            else {
                body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Net Sales(Exclusive TAX) Rs.###0.00"];
                
            }
            if (![Json[@"cess"] isKindOfClass:[NSNull class]]) {
                body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Cess   Rs.###",[Json valueForKey:@"cess"]];
            }
            else {
                body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Cess   Rs.###0.00"];
            }
            if (![Json[@"serviceCharge"] isKindOfClass:[NSNull class]]) {
                body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Service Charge     Rs.###",[Json valueForKey:@"serviceCharge"]];
            }
            else {
                body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Service Charge     Rs.###0.00"];
            }
            if (![Json[@"otherCharge"] isKindOfClass:[NSNull class]]) {
                body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Other Charge     Rs.###",[Json valueForKey:@"otherCharge"]];
            }
            else {
                body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Other Charge     Rs.###0.00"];
            }
            if (![Json[@"tax"] isKindOfClass:[NSNull class]]) {
                body=[NSString stringWithFormat:@"%@\n%@%@",body,@"TAX      Rs.###",[[Json valueForKey:@"tax"] stringValue]];
            }
            else {
                body=[NSString stringWithFormat:@"%@\n%@\n",body,@"TAX      Rs.###0.00"];
            }
            if (![Json[@"taxExempted"] isKindOfClass:[NSNull class]]) {
                body=[NSString stringWithFormat:@"%@\n%@%@",body,@"TAX Exempted     Rs.###",[Json valueForKey:@"taxExempted"]];
            }
            else {
                body=[NSString stringWithFormat:@"%@\n%@\n",body,@"TAX Exempted     Rs.###0.00"];
            }
            if (![Json[@"totalSalesCollection"] isKindOfClass:[NSNull class]]) {
                body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Total Sales Collection     Rs.###",[[Json valueForKey:@"totalSalesCollection"] stringValue]];
            }
            else {
                body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Total Sales Collection     Rs.###0.00"];
            }
            if (![Json[@"depositCollected"] isKindOfClass:[NSNull class]]) {
                body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Deposit Collected     Rs.###",[Json valueForKey:@"depositCollected"]];
            }
            else {
                body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Deposit Collected     Rs.###0.00"];
            }
            if (![Json[@"depositRefunded"] isKindOfClass:[NSNull class]]) {
                body=[NSString stringWithFormat:@"%@\n%@%@",body,@"Deposit Refunded     Rs.###",[Json valueForKey:@"depositRefunded"]];
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
                body=[NSString stringWithFormat:@"%@\n%@%@%@",body,@"Total Amount Collected     Rs.###",[[Json valueForKey:@"totalAmmountCollected"] stringValue],@"\n"];
            }
            else {
                body=[NSString stringWithFormat:@"%@\n%@\n",body,@"Total Amount Collected     Rs.###0.00"];
            }
            
            NSString *footer;
            if (![Json[@"salesReports"] isKindOfClass:[NSNull class]]) {
                footer = [NSString stringWithFormat:@"\n%@%@\n",@"Sales Receipts ",Json[@"salesReports"]];
            }
            else {
                footer = [NSString stringWithFormat:@"\n%@%@\n",@"Sales Receipts ",@"0"];
                
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
                transString = [NSString stringWithFormat:@"%@%@%@%@%@",@"CARD######",[Json valueForKey:@"cardTransactions"],@"  Rs.  ",[Json valueForKey:@"cardTotal"],@"\n\n"];
            }
            else {
                transString = [NSString stringWithFormat:@"%@%@%@%@",@"CARD######",[Json valueForKey:@"cardTransactions"],@"  Rs.  0.00",@"\n\n"];
            }
            if (![[Json valueForKey:@"cardTotal"] isKindOfClass:[NSNull class]]) {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"***Total Card######",[Json valueForKey:@"cardTransactions"],@"  Rs.  ",[Json valueForKey:@"cardTotal"],@"\n\n"];
            }
            else {
                transString = [NSString stringWithFormat:@"%@%@%@%@",transString,@"***Total Card######",[Json valueForKey:@"cardTransactions"],@"  Rs.  0.00\n\n"];
            }
            if (![[Json valueForKey:@"cashTotal"] isKindOfClass:[NSNull class]]) {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"CASH######",[Json valueForKey:@"cashtransactions"],@"  Rs.  ",[Json valueForKey:@"cashTotal"],@"\n\n"];
            }
            else {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"CASH######",[Json valueForKey:@"cashtransactions"],@"  Rs.  0.00",@"\n\n"];
            }
            if (![[Json valueForKey:@"cashTotal"] isKindOfClass:[NSNull class]]) {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"**Total Cash######",[Json valueForKey:@"cashtransactions"],@"  Rs.  ",[Json valueForKey:@"cashTotal"],@"\n\n"];
            }
            else {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"**Total Cash######",[Json valueForKey:@"cashtransactions"],@"  Rs.  0.00",@"\n\n"];
            }
            if (![[Json valueForKey:@"sodexoTotal"] isKindOfClass:[NSNull class]]) {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"SODEXO######",[Json valueForKey:@"sodexoTransactions"],@"  Rs.  ",[Json valueForKey:@"sodexoTotal"],@"\n\n"];
            }
            else {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"SODEXO######",[Json valueForKey:@"sodexoTransactions"],@"  Rs.  0.00",@"\n\n"];
            }
            if (![[Json valueForKey:@"sodexoTotal"] isKindOfClass:[NSNull class]]) {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"**Total Sodexo######",[Json valueForKey:@"sodexoTransactions"],@"  Rs.  ",[Json valueForKey:@"sodexoTotal"],@"\n\n"];
            }
            else {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"**Total Sodexo######",[Json valueForKey:@"sodexoTransactions"],@"  Rs.  0.00",@"\n\n"];
            }
            
            if (![[Json valueForKey:@"ticketTotal"] isKindOfClass:[NSNull class]]) {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"TICKET######",[Json valueForKey:@"ticketTransactions"],@"  Rs.  ",[Json valueForKey:@"ticketTotal"],@"\n\n"];
            }
            else {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"TICKET######",[Json valueForKey:@"ticketTransactions"],@"  Rs.  0.00",@"\n\n"];
            }
            if (![[Json valueForKey:@"ticketTotal"] isKindOfClass:[NSNull class]]) {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@%@",transString,@"**Total Ticket######",[Json valueForKey:@"ticketTransactions"],@"  Rs.  ",[Json valueForKey:@"ticketTotal"],@"\n\n"];
            }
            else {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"**Total Ticket######",[Json valueForKey:@"ticketTransactions"],@"  Rs.  0.00",@"\n\n"];
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
                transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"**Exchange Deduc######",@"        Rs.  ",[Json valueForKey:@"exchangeTotal"],@"\n\n"];
            }
            else {
                transString = [NSString stringWithFormat:@"%@%@%@%@",transString,@"**Exchange Deduc######",@"  Rs.  0.00",@"\n\n"];
            }
            if (![[Json valueForKey:@"returnTotal"] isKindOfClass:[NSNull class]]) {
                transString = [NSString stringWithFormat:@"%@%@%@%@%@",transString,@"**Return Deduc######",@"       Rs.  ",[Json valueForKey:@"returnTotal"],@"\n\n"];
            }
            else {
                transString = [NSString stringWithFormat:@"%@%@%@%@",transString,@"**Return Deduc######",@"        Rs.  0.00",@"\n\n"];
            }
            
            
            transString = [NSString stringWithFormat:@"%@%@",transString,@"---------------------------------\n"];
            
            
            
            NSString *voidList = @"";
            if (![Json[@"voidItems"] isKindOfClass:[NSNull class]]) {
                voidList = [NSString stringWithFormat:@"%@%@%@%@%@",@"Receipt####",@"Time##",@"Refund##",@"Void(Rs.)##",@"Discount\n"];
                for (NSDictionary *dic in Json[@"voidItems"]) {
                    voidList = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@",voidList,dic[@"billId"] ,@"#",dic[@"time"] ,@"#",[[dic valueForKey:@"refund"] stringValue],@"#",[[dic valueForKey:@"voidAmount"] stringValue],@"#",[dic[@"discount"] stringValue],@"\n"];
                }
                voidList = [NSString stringWithFormat:@"%@%@",voidList,@"\n"];
            }
            
            
            if (![Json[@"discountTotal"] isKindOfClass:[NSNull class]]) {
                voidList = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",voidList,@"***Total#####",[Json valueForKey:@"refundTotal"],@"##",[Json valueForKey:@"voidItemsTotal"],@"##",[Json valueForKey:@"discountTotal"],@"\n"];
                
            }
            else {
                voidList = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",voidList,@"***#Total#####",[Json valueForKey:@"refundTotal"],@"##",[Json valueForKey:@"voidItemsTotal"],@"##",@"0.00",@"\n"];
            }
            voidList = [NSString stringWithFormat:@"%@%@",voidList,@"---------------------------------\n"];
            
            NSString *hourReport = @"";
            if (![Json[@"hourReports"] isKindOfClass:[NSNull class]]) {
                hourReport = [NSString stringWithFormat:@"%@%@%@%@",@"Hour####",@"Count####",@"Sales####",@"Sales%\n\n"];
                for (NSDictionary *dic in Json[@"hourReports"]) {
                    
                    //added by Srinivasulu on 12/10/2017....
                    //reason receiving from services "<null>" in hourReports....
                    if (![dic isKindOfClass:[NSNull class]] && [dic isKindOfClass:[NSDictionary class]])//[dic isEqual:@"<null>"])
                        //upto here on 12/10/2017....
                        hourReport = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",hourReport,dic[@"hour"] ,@"#####",[dic[@"count"] stringValue] ,@"####",[[dic valueForKey:@"sales"] stringValue],@"####",[[dic valueForKey:@"salesPercentage"] stringValue],@"\n"];
                }
                hourReport = [NSString stringWithFormat:@"%@%@",hourReport,@"\n\n"];
            }
            
            
            hourReport = [NSString stringWithFormat:@"%@%@",hourReport,@"---------------------------------\n"];
            
            
            
            NSString *endStr = @"<End of report>";
            
            finalPrintMessage = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@\n\n\n\n\n",storeAddress,header,body,footer,totalNumbers,transString,voidList,hourReport,endStr];
            finalPrintMessage = [finalPrintMessage stringByReplacingOccurrencesOfString:@"#" withString:@" "];
            
        }
    } @catch (NSException *exception) {
     
            finalPrintMessage = @"";
    }
    @finally{
        
        return finalPrintMessage;
    }
}

#pragma -mark superclass methods....

/**
 * @description  here we are navigating back to homepage....
 * @date
 * @method       goToHome
 * @author
 * @param
 * @param
 * @param
 *
 * @return       void
 *
 * @modified By  modified by Srinivasulu on 11/10/2017....
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)goToHome {
    
    @try {
      
        OmniHomePage *home = [[OmniHomePage alloc]init];
        [self.navigationController pushViewController:home animated:YES];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }

}

#pragma -mark alertview delegates

/**
 * @description  ....
 * @date
 * @method       alertView:--  clickedButtonAtIndex:--
 * @author
 * @param
 * @param
 * @param
 * @return       void
 *
 * @modified By  Srinivasulu on 10/10/2017....
 * @reason       added comments and exception handling and change the defaults as local varible  && some more change are done before itself....
 *
 * @verified By
 * @verified On
 *
 */

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    if (alertView == businessDateAlert) {
        
        if (buttonIndex == 0) {
            if ([[[JSON valueForKey:RESPONSE_HEADER] valueForKey:RESPONSE_CODE] intValue] == 0) {
                
                
                NSString * bussinessDateStr = [NSString stringWithFormat:@"%@",[defaults valueForKey:BUSSINESS_DATE]];
                NSString * selectedDateStr = [self.dateTxt.text copy];
                
                if([bussinessDateStr caseInsensitiveCompare:selectedDateStr] == NSOrderedSame){
                    
                    printButton.tag = 0;
                    self.goButton.tag = 0;
                }
                else{
                    
                    printButton.tag = 1;
                    self.goButton.tag = 1;
                }
                
            }
            else {
               
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"No Data To Print" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        else {
            [alertView setHidden:YES];
        }
    }
}

/**
 * @description  ....
 * @date
 * @method       tseriesPrinterResult:--
 * @author
 * @param        PowaTSeriesPrinterResult
 * @param
 * @param
 * @return       void
 *
 * @modified By  Srinivasulu on 10/10/2017....
 * @reason       added comments and exception handling and change the defaults as local varible  && some more change are done before itself....
 *
 * @verified By
 * @verified On
 *
 */

- (void)tseriesPrinterResult:(PowaTSeriesPrinterResult)result
{
    NSLog(@"called print result");
    
    if(result == PowaTSeriesPrinterResultSuccessfull)
    {
        @try {
            OmniHomePage *home = [[OmniHomePage alloc]init];
            //changed by Srinivasulu on 27/09/2017....
            //reason backButton and logout button GUI is distributed....
            
            //            [self.navigationController pushViewController:home animated:NO];
            [self.navigationController pushViewController:home animated:YES];
            
            //upto here on 27/09/2017....
            
        }
        @catch (NSException *exception) {
            
            NSLog(@"exception in print result %@ ",exception);
        }
        
        
    }
    if(result == PowaTSeriesPrinterResultErrorThermalMotor)
    {
        
        NSString *string = [NSString stringWithFormat:@"Printer Overheated"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                            message:string
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
    if(result == PowaTSeriesPrinterResultReady)
    {
        NSString *string = [NSString stringWithFormat:@"Ready"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Printer Result"
                                                            message:string
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
    if(result == PowaTSeriesPrinterResultErrorOutOfPaper)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Please insert paper roll"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
    
}



#pragma -mark methods modified by Srinivasulu on 20/06/2017 for using star printer....

/**
 * @description  here we are converting printStream string into image and then to NSData.....
 * @date
 * @method       printReports:--  reportType:--
 * @author
 * @param        NSDictionary
 * @param        NSString
 * @param
 * @return       void
 *
 * @modified By  Srinivasulu on 31/08/2017.... and previous at time of star printer integeration....
 * @reason       handled the both POW and star printer && added the condition when business date is changing....
 *
 * @verified By
 * @verified On
 *
 */

-(void)printReports:(NSDictionary *)response reportType:(NSString *)reportTye {
    
    @try {
        
        //changed the logic for getting print on 11/07/2017....
        
        // it can be used when device are not available. so, product will not effect if we ....
        //                if (printer  || !printer)  {
        
        // it has to be used in product by commenting above code....
        if (printer)  {
            
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
                    
                }
                else if ([reportTye isEqualToString:@"z"]) {
                    NSLog(@"report Type %@",reportTye);
                    str = [self printZString:response];
                    
                    //added by Srinivauluse on 06/10/2017....above line also same code only....
                    //reason in matter of seconds it is not working.... this code also false in case of change dthe dateTxt....
                    NSString * bussinessDateStr = [NSString stringWithFormat:@"%@",[defaults valueForKey:BUSSINESS_DATE]];
                    
                    //added by Srinivasulu on 11/10/2017.....
                    
                    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
                    dateFormatter.dateFormat = @"dd/MM/yyyy";
                    
                    
                    NSDate *today = [NSDate date];
                    
                    //added by Srinivasulu on 20/10/2017....
                    
                    NSDate * todayDate = [[NSDate alloc] init];
                    todayDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:today]];
                    
                    NSDate * bussinessDate = [[NSDate alloc] init];
                    bussinessDate = [dateFormatter dateFromString:bussinessDateStr];
                    
                    
                    //upto here on 20/10/2017....
                    
                    //            NSArray *keys = [NSArray arrayWithObjects:@"DateAndTime",
                    
                    //changed by Srinivasulu on 18/10/2017....
                    //reason is
                    
                    
                    if([WebServiceUtility numberOfDaysDifference:bussinessDate] < 1) {
                        
                        if(printButton.tag == 0){
                            
                            printButton.tag = 1;
                            self.goButton.tag = 1;
                            
                            [defaults setValue:@"0000" forKey:LAST_BILL_COUNT];
                            [defaults setValue:@"0.00" forKey:LAST_BILL_TOTAL];
                            
                            NSDateFormatter *f = [[NSDateFormatter alloc] init];
                            f.dateFormat = @"dd/MM/yyyy";
                            
                            NSString * bussinessDate = [WebServiceUtility addDays:1 toDate:[f dateFromString:[NSString stringWithFormat:@"%@",[defaults valueForKey:BUSSINESS_DATE]]]];
                            [defaults setValue:bussinessDate forKey:BUSSINESS_DATE];
                            [defaults setObject:@(false)  forKey:IS_DAY_CLOSURE_TAKEN];
                            [defaults setObject:@(false)  forKey:IS_DAY_OPEN];
                        }
                    }
                    else if([WebServiceUtility numberOfDaysDifference:bussinessDate] > 1){
                        
                        [defaults setValue:[[WebServiceUtility getCurrentDate] componentsSeparatedByString:@" "][0] forKey:BUSSINESS_DATE];
                        [defaults setValue:@"0000" forKey:LAST_BILL_COUNT];
                        [defaults setValue:@"0.00" forKey:LAST_BILL_TOTAL];
                        [defaults setObject:@(false)  forKey:IS_DAY_CLOSURE_TAKEN];
                        [defaults setObject:@(false)  forKey:IS_DAY_OPEN];
                    }
                    //added by Srinivasulu on 20/10/2017....
                    else if (([WebServiceUtility numberOfDaysDifference:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@",[defaults valueForKey:BUSSINESS_DATE]]]] >= 1) && ([todayDate  compare:bussinessDate] == NSOrderedDescending)){
                        
                        [defaults setValue:[[WebServiceUtility getCurrentDate] componentsSeparatedByString:@" "][0] forKey:BUSSINESS_DATE];
                        [defaults setValue:@"0000" forKey:LAST_BILL_COUNT];
                        [defaults setValue:@"0.00" forKey:LAST_BILL_TOTAL];
                        [defaults setObject:@(false)  forKey:IS_DAY_CLOSURE_TAKEN];
                        [defaults setObject:@(false)  forKey:IS_DAY_OPEN];
                    }
                    
                    //upto here on 20/10/2017....
                    
                    printButton.tag = 1;
                    self.goButton.tag = 1;
                    
                    //upto here on 31/08/2017....
                    
                    //            str = [self printZString:response];
                    
                }
                else if ([reportTye isEqualToString:@"xz"]) {
                    NSLog(@"report Type %@",reportTye);
                    
                    //            str = [self printXZString:response];
                    
                }
                //            [printer printImage:[UIImage imageNamed:@"sampoorna.jpg"] threshold:0.5];
                //                [self.tseries printImage:[UIImage imageNamed:@"sampoorna.jpg"]];
                
                //            [printer printImage:[UIImage imageNamed:@"sahyadri_logo.png"] threshold:0.5];
                
                
                
                //added by Srinivasulu on 07/06/2017....
                
                if(defaults == nil)
                    defaults = [[NSUserDefaults alloc]init];
                
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
                
                if(([self printZString:response].length) && ( [reportTye isEqualToString:@"z"] )){
                    NSData * commands = [self createRasterReceiptData:emulation printMessage:[self printZString:response]];
                    
                    //added by Srinivasulu on 21/10/2017.....

                    NSString * bussinessDateStr = [NSString stringWithFormat:@"%@",[defaults valueForKey:BUSSINESS_DATE]];
                    
                    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
                    dateFormatter.dateFormat = @"dd/MM/yyyy";
                    
                    
                    NSDate *today = [NSDate date];
                    
                    
                    NSDate * todayDate = [[NSDate alloc] init];
                    todayDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:today]];
                    
                    NSDate * bussinessDate = [[NSDate alloc] init];
                    bussinessDate = [dateFormatter dateFromString:bussinessDateStr];
                    
                    
                    if([WebServiceUtility numberOfDaysDifference:bussinessDate] < 1) {
                     
                        if(printButton.tag == 0){
                            
                            printButton.tag = 1;
                            self.goButton.tag = 1;
                            
                            [defaults setValue:@"0000" forKey:LAST_BILL_COUNT];
                            [defaults setValue:@"0.00" forKey:LAST_BILL_TOTAL];
                            
                            NSDateFormatter *f = [[NSDateFormatter alloc] init];
                            f.dateFormat = @"dd/MM/yyyy";
                            
                            NSString * bussinessDate = [WebServiceUtility addDays:1 toDate:[f dateFromString:[NSString stringWithFormat:@"%@",[defaults valueForKey:BUSSINESS_DATE]]]];
                            [defaults setValue:bussinessDate forKey:BUSSINESS_DATE];
                            [defaults setObject:@(false)  forKey:IS_DAY_CLOSURE_TAKEN];
                            [defaults setObject:@(false)  forKey:IS_DAY_OPEN];
                        }
                    }
                    else if([WebServiceUtility numberOfDaysDifference:bussinessDate] > 1){
                        
                        [defaults setValue:[[WebServiceUtility getCurrentDate] componentsSeparatedByString:@" "][0] forKey:BUSSINESS_DATE];
                        [defaults setValue:@"0000" forKey:LAST_BILL_COUNT];
                        [defaults setValue:@"0.00" forKey:LAST_BILL_TOTAL];
                        [defaults setObject:@(false)  forKey:IS_DAY_CLOSURE_TAKEN];
                        [defaults setObject:@(false)  forKey:IS_DAY_OPEN];
                    }
                    else if (([WebServiceUtility numberOfDaysDifference:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@",[defaults valueForKey:BUSSINESS_DATE]]]] >= 1) && ([todayDate  compare:bussinessDate] == NSOrderedDescending)){
                        
                        [defaults setValue:[[WebServiceUtility getCurrentDate] componentsSeparatedByString:@" "][0] forKey:BUSSINESS_DATE];
                        [defaults setValue:@"0000" forKey:LAST_BILL_COUNT];
                        [defaults setValue:@"0.00" forKey:LAST_BILL_TOTAL];
                        [defaults setObject:@(false)  forKey:IS_DAY_CLOSURE_TAKEN];
                        [defaults setObject:@(false)  forKey:IS_DAY_OPEN];
                    }
                    
            
                    printButton.tag = 1;
                    self.goButton.tag = 1;
                    
                    //upto here on 21/10/2017....
                    
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
        
        //upto here on 11/07/2017....
        
    } @catch (NSException *exception) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Unable to find the printer. Please check the printer cable." message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    } @finally {
        
    }

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
            
            //chnaged by Srinivasulu on 19/09/2017....
            //reason is -- != for int -----
            
            //if((defaults != nil)
            if(defaults == nil)
                
                //upto here on 19/09/2017....
                
                defaults = [[NSUserDefaults alloc]init];
            
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

#pragma -mark start of UITableViewDelegateMethods

/**
 * @description  it is tableview delegate method it will be called after numberOfSection.......
 * @date
 * @method       tableView: numberOfRowsInSection:
 * @author
 * @param        UITableView
 * @param        NSInteger
 *
 * @return       NSInteger
 *
 * @modified BY  Srinivasulu on 08/06/201477....
 * @reason       changed the comment's section....
 *
 * @verified By
 * @verified On
 *
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    @try {
        
        if (tableView == shiftsTbl) {
            
            return shiftsArr.count;
        }
        else
            return false;
    }
    @catch (NSException *exception) {
        
    }
    
}

/**
 * @description  it is tableview delegate method it will be called after numberOfRowsInSection.......
 * @date          11/10/2017....
 * @method       tableView: heightForRowAtIndexPath:
 * @author       Srinivasulu
 * @param        UITableView
 * @param        NSIndexPath
 *
 * @return       CGFloat
 *
 * @modified BY
 * @reason
 *
 * @verified By
 * @verified On
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView == shiftsTbl){
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            return 40;
        }
        else{
            
            return 40;
        }
        
    }
    else
        return 45;
}

/**
 * @description  it is tableview delegate method it will be called after heightForRowAtIndexPath.......
 * @date         14/10/2017....
 * @method       tableView: willDisplayCell: forRowAtIndexPath:
 * @author       Srinivasulu
 * @param        UITableView
 * @param        UITableViewCell
 *
 * @return       NSIndexPath
 *
 * @modified BY
 * @reason
 *
 * @verified By
 * @verified On
 */

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

/**
 * @description  it is tableview delegate method it will be called after willDisplayCell.......
 * @date         11/10/2017....
 * @method       tableView: cellForRowAtIndexPath:
 * @author       Srinivasulu
 * @param        UITableView
 * @param        UITableViewCell
 * @param
 *
 * @return       UITableViewCell
 *
 * @modified BY
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == shiftsTbl) {
        
        @try {
            
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
            
            
            UILabel * shiftStartTimeLbl;
            UILabel * shiftStartTimeValueLbl;
            UILabel * shiftEndTimeLbl;
            UILabel * shiftEndTimeValueLbl;
            
            
            shiftStartTimeLbl = [[UILabel alloc] init];
            shiftStartTimeLbl.backgroundColor = [UIColor clearColor];
            shiftStartTimeLbl.textAlignment = NSTextAlignmentCenter;
            shiftStartTimeLbl.numberOfLines = 1;
            shiftStartTimeLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            shiftStartTimeValueLbl = [[UILabel alloc] init];
            shiftStartTimeValueLbl.backgroundColor = [UIColor clearColor];
            shiftStartTimeValueLbl.textAlignment = NSTextAlignmentCenter;
            shiftStartTimeValueLbl.numberOfLines = 1;
            shiftStartTimeValueLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            shiftEndTimeLbl = [[UILabel alloc] init];
            shiftEndTimeLbl.backgroundColor = [UIColor clearColor];
            shiftEndTimeLbl.textAlignment = NSTextAlignmentCenter;
            shiftEndTimeLbl.numberOfLines = 2;
            shiftEndTimeLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            shiftEndTimeValueLbl = [[UILabel alloc] init];
            shiftEndTimeValueLbl.backgroundColor = [UIColor clearColor];
            shiftEndTimeValueLbl.textAlignment = NSTextAlignmentCenter;
            shiftEndTimeValueLbl.numberOfLines = 1;
            shiftEndTimeValueLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            
            /* assiginig the font and color of the labels  */
            
            shiftStartTimeLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0];
            shiftStartTimeValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            shiftEndTimeLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            shiftEndTimeValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            
            shiftStartTimeLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
            shiftStartTimeValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
            shiftEndTimeLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
            shiftEndTimeValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
            
            //added subViews to cell contentView....
            [hlcell.contentView addSubview:shiftStartTimeLbl];
            [hlcell.contentView addSubview:shiftStartTimeValueLbl];
            [hlcell.contentView addSubview:shiftEndTimeLbl];
            [hlcell.contentView addSubview:shiftEndTimeValueLbl];
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
//                if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
//                }
//                else{
//                }
                
                //setting frame....
                shiftStartTimeLbl.frame = CGRectMake( 0, 0, shiftsTbl.frame.size.width/4, hlcell.frame.size.height);
                shiftStartTimeValueLbl.frame = CGRectMake( shiftStartTimeLbl.frame.origin.x + shiftStartTimeLbl.frame.size.width, 0, shiftStartTimeLbl.frame.size.width,  hlcell.frame.size.height);
                shiftEndTimeLbl.frame = CGRectMake( shiftStartTimeValueLbl.frame.origin.x + shiftStartTimeValueLbl.frame.size.width, 0, shiftStartTimeValueLbl.frame.size.width,   hlcell.frame.size.height);
                shiftEndTimeValueLbl.frame = CGRectMake( shiftEndTimeLbl.frame.origin.x + shiftEndTimeLbl.frame.size.width, 0, shiftStartTimeValueLbl.frame.size.width,   hlcell.frame.size.height);
            }
            else{
                //need to give frame's for iPhone....
                
            }
            //setting frame and font..........
            
            @try {
                
                shiftStartTimeLbl.text = [NSString stringWithFormat:@"%@%ld%@%@",@" ", indexPath.row + 1,@") ", NSLocalizedString(@"start_time", nil) ];
                shiftStartTimeValueLbl.text = @":";
                shiftEndTimeLbl.text = NSLocalizedString(@"end_time", nil);
                shiftEndTimeValueLbl.text = @":";
            }
            @catch (NSException *exception) {
                
            }
            hlcell.backgroundColor = [UIColor clearColor];
            hlcell.tag = indexPath.row;
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
        }
        @catch (NSException *exception) {
            
        }
        
    }
    
}

/**
 * @description  it is tableview delegate method it will be called after cellForRowIndexPath.......
 * @date         11/10/2017.....
 * @method       tableView: didSelectRowAtIndexPath:
 * @author       Srinivasulu
 * @param        UITableView
 * @param        NSIndexPath
 * @param
 *
 * @return       void
 *
 * @modified BY
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma -mark method not is use....

/**
 * @description  here we are calling the service depending on day selection....
 * @date         21/10/2017....
 * @method       gobuttonPressed:--
 * @author       Srinivasulu
 * @param        id
 * @param
 * @param
 *
 * @return       void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

- (void) gobuttonPressed:(id) sender {

    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        [self getXZReports:@"z"];
    } @catch (NSException *exception) {
        
    }
}


/**
 * @description  here we are calling the service depending on day selection....
 * @date         09/02/2018....
 * @method       ChangedBusinessDate
 * @author       Srinivasulu
 * @param        id
 * @param
 * @param
 *
 * @return       void
 *
 * @modified By
 * @reason
 *
 * @verified By
 * @verified On
 *
 */


-(void)ChangedBusinessDate{
    
    @try {
        
        //creation of standardUserDefaults....
        if(defaults == nil)
        defaults = [[NSUserDefaults alloc]init];


        NSString * bussinessDateStr = [NSString stringWithFormat:@"%@",[defaults valueForKey:BUSSINESS_DATE]];
                
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"dd/MM/yyyy";
        
        NSDate *today = [NSDate date];
        
        
        NSDate * todayDate = [[NSDate alloc] init];
        todayDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:today]];
        
        NSDate * bussinessDate = [[NSDate alloc] init];
        bussinessDate = [dateFormatter dateFromString:bussinessDateStr];
        
        if([WebServiceUtility numberOfDaysDifference:bussinessDate] < 1) {
            
            if(printButton.tag == 0){
                
                printButton.tag = 1;
                self.goButton.tag = 1;
                
                [defaults setValue:@"0000" forKey:LAST_BILL_COUNT];
                [defaults setValue:@"0.00" forKey:LAST_BILL_TOTAL];
                
                NSDateFormatter *f = [[NSDateFormatter alloc] init];
                f.dateFormat = @"dd/MM/yyyy";
                
                NSString * bussinessDate = [WebServiceUtility addDays:1 toDate:[f dateFromString:[NSString stringWithFormat:@"%@",[defaults valueForKey:BUSSINESS_DATE]]]];
                [defaults setValue:bussinessDate forKey:BUSSINESS_DATE];
                
                [defaults setObject:@(false)  forKey:IS_DAY_CLOSURE_TAKEN];
                [defaults setObject:@(false)  forKey:IS_DAY_OPEN];
            }
        }
        else if([WebServiceUtility numberOfDaysDifference:bussinessDate] > 1){
            
            [defaults setValue:[[WebServiceUtility getCurrentDate] componentsSeparatedByString:@" "][0] forKey:BUSSINESS_DATE];
            [defaults setValue:@"0000" forKey:LAST_BILL_COUNT];
            [defaults setValue:@"0.00" forKey:LAST_BILL_TOTAL];
            [defaults setObject:@(false)  forKey:IS_DAY_CLOSURE_TAKEN];
            [defaults setObject:@(false)  forKey:IS_DAY_OPEN];
        }
        else if (([WebServiceUtility numberOfDaysDifference:[dateFormatter dateFromString:[NSString stringWithFormat:@"%@",[defaults valueForKey:BUSSINESS_DATE]]]] >= 1) && ([todayDate  compare:bussinessDate] == NSOrderedDescending)){
            
            [defaults setValue:[[WebServiceUtility getCurrentDate] componentsSeparatedByString:@" "][0] forKey:BUSSINESS_DATE];
            [defaults setValue:@"0000" forKey:LAST_BILL_COUNT];
            [defaults setValue:@"0.00" forKey:LAST_BILL_TOTAL];
            [defaults setObject:@(false)  forKey:IS_DAY_CLOSURE_TAKEN];
            [defaults setObject:@(false)  forKey:IS_DAY_OPEN];
        }
        
        
        printButton.tag = 1;
        self.goButton.tag = 1;
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

-(void)ShowBusinessDateChangeAlert:(NSString *)displayMessage{
    
    @try {
        
        //creation of standardUserDefaults....
        if(defaults == nil)
            defaults = [[NSUserDefaults alloc]init];
        
        NSString * bussinessDateStr = [NSString stringWithFormat:@"%@",[defaults valueForKey:BUSSINESS_DATE]];
        NSString * selectedDateStr = [self.dateTxt.text copy];
        
        if([bussinessDateStr caseInsensitiveCompare:selectedDateStr] == NSOrderedSame){
            
            
        }
        else{
            
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}


- (void)backAction {

    @try{
     
        OmniHomePage * home = [[OmniHomePage alloc]init];
        [self.navigationController pushViewController:home animated:NO];
    }
    @catch(NSException * expn){
        
    }
   
}

@end
