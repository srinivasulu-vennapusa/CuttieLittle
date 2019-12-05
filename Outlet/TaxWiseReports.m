//  TaxWiseReports.m
//  OmniRetailer
//  Created by Bhargav Ram on 3/13/17.....

#import "TaxWiseReports.h"
#import "SalesServiceSvc.h"
//#import "SalesReportsSvc.h"

//added by Srinivasulu on 13/07/2017....
#import "OmniHomePage.h"

@interface TaxWiseReports ()

@end

@implementation TaxWiseReports

@synthesize soundFileObject,soundFileURLRef;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //reading the DeviceVersion....
    version = [UIDevice currentDevice].systemVersion.floatValue;
    
    //here we reading the DeviceOrientaion....
    currentOrientation = [UIDevice currentDevice].orientation;
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (CFURLRef) CFBridgingRetain(tapSound);
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    //setting the backGroundColor to view....
    self.view.backgroundColor = [UIColor blackColor];
    

    
    //  ProgressBar creation...
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    // Show the HUD
    [HUD show:YES];
    [HUD setHidden:NO];
    
    //  creation of UIView
    TaxReportsView  = [[UIView alloc ]init];
    TaxReportsView.backgroundColor = [UIColor blackColor];
    TaxReportsView.layer.borderWidth = 2.0f;
    TaxReportsView.layer.cornerRadius = 8.0f;
    TaxReportsView.layer.borderColor = [UIColor clearColor].CGColor;
    
    /*Creation of UILabel for headerDisplay.......*/
    //creating line  UILabel which will display at topOfThe  billingView.......
    UILabel * headerNameLbl = [[UILabel alloc] init];
    headerNameLbl.layer.cornerRadius = 10.0f;
    headerNameLbl.layer.masksToBounds = YES;
    headerNameLbl.textAlignment = NSTextAlignmentCenter;
    headerNameLbl.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
    headerNameLbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gradient.png"]];
    
    //it is regard's to the view borderwidth and color setting....
    CALayer * bottomBorder = [CALayer layer];
    bottomBorder.opacity = 5.0f;
    bottomBorder.backgroundColor = [UIColor grayColor].CGColor;
    bottomBorder.frame = CGRectMake(0.0f, 60.0f, headerNameLbl.frame.size.width, 1.0f);
    [headerNameLbl.layer addSublayer:bottomBorder];

   
    //allocation of startDteTxt....
    startDteTxt = [[UITextField alloc]init];
    startDteTxt.borderStyle = UITextBorderStyleRoundedRect;
    startDteTxt.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    startDteTxt.layer.borderWidth = 1.0f;
    startDteTxt.backgroundColor = [UIColor clearColor];
    startDteTxt.returnKeyType = UIReturnKeyDone;
    startDteTxt.delegate = self;
    startDteTxt.textAlignment = NSTextAlignmentLeft;
    startDteTxt.userInteractionEnabled = NO;
    [startDteTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    startDteTxt.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
    
    startDteTxt.placeholder = @"start Date";
    startDteTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:startDteTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    UIImage * calendarImg = [UIImage imageNamed:@"Calandar_Icon.png"];
    UIButton *startDteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startDteBtn setBackgroundImage:calendarImg forState:UIControlStateNormal];
    [startDteBtn addTarget:self
                    action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    startDteBtn.tag = 2;
    
    
    //allocation of endDateTxt....
    endDateTxt = [[UITextField alloc]init];
    endDateTxt.borderStyle = UITextBorderStyleRoundedRect;
    endDateTxt.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    endDateTxt.layer.borderWidth = 1.0f;
    endDateTxt.backgroundColor = [UIColor clearColor];
    endDateTxt.returnKeyType = UIReturnKeyDone;
    endDateTxt.delegate = self;
    endDateTxt.textAlignment = NSTextAlignmentLeft;
    endDateTxt.userInteractionEnabled = NO;
    [endDateTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    endDateTxt.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.6]. CGColor;
    
    endDateTxt.placeholder = @"End Date";
    endDateTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:endDateTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    UIButton *endDteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [endDteBtn setBackgroundImage:calendarImg forState:UIControlStateNormal];
    [endDteBtn addTarget:self
                  action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    
    //allocation of GO Buttton:
    goButton = [[UIButton alloc] init] ;
    [goButton setTitle:@"Go" forState:UIControlStateNormal];
    goButton.backgroundColor = [UIColor grayColor];
    goButton.layer.masksToBounds = YES;
    [goButton addTarget:self action:@selector(goButtonPressed:) forControlEvents:UIControlEventTouchDown];
    goButton.userInteractionEnabled = YES;
    goButton.layer.cornerRadius = 6.0f;
    goButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
    goButton.tag = 2;
    
    
    //allocation of UIScrollView
    TaxReportsScrollView  = [[UIScrollView alloc ]init];
//    TaxReportsScrollView.backgroundColor = [UIColor whiteColor];
    
    
    //allocation of UILabels..
    snoLbl = [[UILabel alloc] init];
    snoLbl.layer.cornerRadius = 14;
    snoLbl.layer.masksToBounds = YES;
    snoLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    snoLbl.textColor = [UIColor whiteColor];
    snoLbl.font = [UIFont boldSystemFontOfSize:18.0];
    snoLbl.textAlignment = NSTextAlignmentCenter;
    snoLbl.text = @"SNo";
    
    //consumption details table creation...
    taxReportsTbl = [[UITableView alloc] init];
    taxReportsTbl.backgroundColor  = [UIColor blackColor];
    taxReportsTbl.layer.cornerRadius = 4.0;
    taxReportsTbl.bounces = TRUE;
    taxReportsTbl.userInteractionEnabled  = YES;
    taxReportsTbl.dataSource = self;
    taxReportsTbl.delegate = self;
    taxReportsTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    @try {
        //setting the titleName for the Page....
        self.titleLabel.text = NSLocalizedString(@"omni_retailer",nil);
        headerNameLbl.text = NSLocalizedString(@"tax_report",nil);
        HUD.labelText = NSLocalizedString(@"please_wait..",nil);
    } @catch (NSException *exception) {
        
    }
    
   
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        TaxReportsView.frame = CGRectMake( 2, 70, self.view.frame.size.width - 4, self.view.frame.size.height - 80);

        float verticalGap = 20;
        
        headerNameLbl.frame = CGRectMake(0,0,TaxReportsView.frame.size.width,45);
        
        startDteTxt.frame = CGRectMake(10,headerNameLbl.frame.origin.y+headerNameLbl.frame.size.height+verticalGap, 180, 40);
        
        endDateTxt.frame = CGRectMake(startDteTxt.frame.origin.x+startDteTxt.frame.size.width+30, startDteTxt.frame.origin.y, startDteTxt.frame.size.width, 40);
       
        startDteBtn.frame = CGRectMake((startDteTxt.frame.origin.x+startDteTxt.frame.size.width-45), startDteTxt.frame.origin.y+2, 40, 35);
        
        endDteBtn.frame = CGRectMake((endDateTxt.frame.origin.x+endDateTxt.frame.size.width-45), endDateTxt.frame.origin.y+2, 40, 35);
        
        goButton.frame  = CGRectMake(endDateTxt.frame.origin.x+endDateTxt.frame.size.width+20,endDateTxt.frame
                                     .origin.y,80, 40);
        
        TaxReportsScrollView.frame  = CGRectMake(startDteTxt.frame.origin.x, startDteTxt.frame.origin.y+startDteTxt.frame.size.height+20,TaxReportsView.frame.size.width,TaxReportsView.frame.size.height-(startDteTxt.frame.origin.y+startDteTxt.frame.size.height+40));
        
         TaxReportsScrollView.contentSize  = CGSizeMake(TaxReportsScrollView.frame.size.width+400, TaxReportsScrollView.bounds.size.height);
        
        snoLbl.frame = CGRectMake(0,10,80,40);
        
        taxReportsTbl.frame = CGRectMake(snoLbl.frame.origin.x, snoLbl.frame.origin.y+snoLbl.frame.size.height+10,((taxWiseLabel.frame.origin.x+taxWiseLabel.frame.size.width)-snoLbl.frame.origin.x),TaxReportsScrollView.frame.size.height-(snoLbl.frame.origin.y+snoLbl.frame.size.height));
    }
    
    [TaxReportsView addSubview:headerNameLbl];
    [TaxReportsView addSubview:startDteTxt];
    [TaxReportsView addSubview:endDateTxt];
    [TaxReportsView addSubview:startDteBtn];
    [TaxReportsView addSubview:endDteBtn];
    [TaxReportsView addSubview:goButton];
    [TaxReportsScrollView addSubview:snoLbl];
    [TaxReportsScrollView addSubview:taxReportsTbl];
    [TaxReportsView addSubview:TaxReportsScrollView];
    
    [self.view addSubview: TaxReportsView];
    
    @try {
        headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];

    } @catch (NSException *exception) {
        
    }
    
}


/**
 * @description
 * @date
 * @method       <#name#>
 * @author       Bhargav.v
 * @param        <#param#>
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    @try {
        [self getTaxReports];
        
        [self displayLables:taxWiseLblsArr];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 * @description  tax Reports  .......
 * @date         26/09/2016
 * @method       getTaxReports
 * @author       Bhargav Ram
 * @param
 * @param
 * @return
 * @return
 *
 * @modified By Srinivasulu on 13/07/3017....
 * @reason      hidding HUD in catch block....
 *
 * @verified By
 * @verified On
 *
 */

// Commented by roja on 17/10/2019.. // reason :- getTaxReports method contains SOAP Service call .. so taken new method with same name(getTaxReports) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//-(void)getTaxReports {
//
//    @try {
//
//        [HUD setHidden:NO];
//
//        NSString * startDteStr = @"";
//        NSString * endDateStr = @"";
//
//        if((startDteTxt!= nil) && ((startDteTxt.text).length>1)){
//            startDteStr = [NSString stringWithFormat:@"%@%@", startDteTxt.text,@" 00:00:00"];
//
//        }
//        if((endDateTxt!= nil) && ((endDateTxt.text).length >1 )){
//
//            endDateStr = [NSString stringWithFormat:@"%@%@", endDateTxt.text,@" 00:00:00"];
//        }
//
//        NSMutableDictionary * taxReports  = [[NSMutableDictionary alloc]init];
//
//        taxReports[START_INDEX] = [NSString stringWithFormat:@"%d",startIndex];
//        taxReports[REQUEST_HEADER] = [RequestHeader getRequestHeader];
//        taxReports[kRequiredRecords] = @10;
//        taxReports[STORE_LOCATION] = presentLocation;
//        taxReports[kSearchCriteria] = @"tax";
//        taxReports[START_DATE] = startDteStr;
//        taxReports[END_DATE] = endDateStr;
//
//        NSError * err;
//        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:taxReports options:0 error:&err];
//        NSString * reportsJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//        SalesServiceSvcSoapBinding * salesBindng =  [SalesServiceSvc SalesServiceSvcSoapBinding];
//        SalesServiceSvc_getSalesReports * aParameters =  [[SalesServiceSvc_getSalesReports alloc] init];
//
//        aParameters.searchCriteria = reportsJsonString;
//        SalesServiceSvcSoapBindingResponse * response = [salesBindng getSalesReportsUsingParameters:aParameters];
//
//        NSArray * responseBodyParts = response.bodyParts;
//
//        for (id bodyPart in responseBodyParts) {
//            if ([bodyPart isKindOfClass:[SalesServiceSvc_getSalesReportsResponse class]]) {
//                SalesServiceSvc_getSalesReportsResponse *body = (SalesServiceSvc_getSalesReportsResponse *)bodyPart;
//                printf("\nresponse=%s",(body.return_).UTF8String);
//
//                NSError *e;
//                NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                     options: NSJSONReadingMutableContainers
//                                                                       error: &e];
//
//                if (![body.return_ isKindOfClass:[NSNull class]]) {
//
//                    @try {
//
//                        if (taxWiseArray == nil &&  taxWiseLblsArr == nil &&  startIndex == 0 ) {
//
//                            taxWiseLblsArr = [NSMutableArray new];
//                            taxWiseArray = [NSMutableArray new];
//
//                        }
//                        else if (startIndex == 0 &&  taxWiseArray.count  && taxWiseLblsArr.count ) {
//
//                            [taxWiseLblsArr removeAllObjects];
//                            [taxWiseArray removeAllObjects];
//                        }
//
//                        NSDictionary * json1 = JSON[RESPONSE_HEADER];
//
//                        NSLog(@"%@",json1);
//
//                        if (JSON.count>0) {
//
//                            for(NSDictionary * lablesDic in JSON[@"taxLablesList"]) {
//
//                                [taxWiseLblsArr addObject:lablesDic];
//                            }
//
//                            //commneted by Srinivasulu on 29/09/2017....
//
//                            //NSLog(@"----%i",[[[JSON objectForKey:@"taxWiseReport"] valueForKey: [taxWiseLblsArr objectAtIndex:0]] count]);
//
//                            //upto heree on 29/09/2017....
//
//                            [taxWiseArray addObject:JSON[@"taxWiseReport"]];
//                        }
//
//                        else{
//
//                            [self displayAlertMessage:NSLocalizedString(@"Sales reports not available", nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height-150  msgType:NSLocalizedString(@"warning", nil) conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
//                        }
//                    }
//                    @catch (NSException *exception) {
//
//                        NSLog(@"%@-exceptoin in service call---",exception);
//
//                    }
//                    @finally {
//
//                        [taxReportsTbl reloadData];
//                        [HUD setHidden:YES];
//                    }
//
//                }
//            }
//        }
//
//    }
//    @catch (NSException *exception) {
//
//        [HUD setHidden:YES];
//    }
//    @finally {
//
//    }
//}


//getTaxReports method changed by roja on 17/10/2019.. // reason :- removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST

-(void)getTaxReports {
    
    @try {
        
        [HUD setHidden:NO];
        
        NSString * startDteStr = @"";
        NSString * endDateStr = @"";
        
        if((startDteTxt!= nil) && ((startDteTxt.text).length>1)){
            startDteStr = [NSString stringWithFormat:@"%@%@", startDteTxt.text,@" 00:00:00"];
            
        }
        if((endDateTxt!= nil) && ((endDateTxt.text).length >1 )){
            
            endDateStr = [NSString stringWithFormat:@"%@%@", endDateTxt.text,@" 00:00:00"];
        }
        
        NSMutableDictionary * taxReports  = [[NSMutableDictionary alloc]init];
        
        taxReports[START_INDEX] = [NSString stringWithFormat:@"%d",startIndex];
        taxReports[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        taxReports[kRequiredRecords] = @10;
        taxReports[STORE_LOCATION] = presentLocation;
        taxReports[kSearchCriteria] = @"tax";
        taxReports[START_DATE] = startDteStr;
        taxReports[END_DATE] = endDateStr;
        
        if (taxWiseArray == nil &&  taxWiseLblsArr == nil &&  startIndex == 0 ) {
            
            taxWiseLblsArr = [NSMutableArray new];
            taxWiseArray = [NSMutableArray new];
            
        }
        else if (startIndex == 0 &&  taxWiseArray.count  && taxWiseLblsArr.count ) {
            
            [taxWiseLblsArr removeAllObjects];
            [taxWiseArray removeAllObjects];
        }
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:taxReports options:0 error:&err];
        NSString * reportsJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        
        WebServiceController * services = [[WebServiceController alloc] init];
        services.salesServiceDelegate = self;
        [services getSalesReport:reportsJsonString];

    }
    @catch (NSException *exception) {
        
        [HUD setHidden:YES];
    }
   
}


// added by Roja on 17/10/2019…. // Old Code only written here...
- (void)getSalesReportsSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
            for(NSDictionary * lablesDic in successDictionary[@"taxLablesList"]) {
                
                [taxWiseLblsArr addObject:lablesDic];
            }
            
            //commneted by Srinivasulu on 29/09/2017....
            
            //NSLog(@"----%i",[[[JSON objectForKey:@"taxWiseReport"] valueForKey: [taxWiseLblsArr objectAtIndex:0]] count]);
            
            //upto heree on 29/09/2017....
            
            [taxWiseArray addObject:successDictionary[@"taxWiseReport"]];
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [taxReportsTbl reloadData];
        [HUD setHidden:YES];
    }
}

// added by Roja on 17/10/2019…. // Old Code only written here...
- (void)getSalesReportsErrorResponse:(NSString *)errorResponse{
    
    @try {
        [self displayAlertMessage:errorResponse horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height-150  msgType:NSLocalizedString(@"warning", nil) conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];

    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
        [taxReportsTbl reloadData];

    }
}



/**
 * @description  populating lables dynamically based on the service call .......
 * @date         26/09/2016
 * @method       displayLables:lablesArr
 * @author       Bhargav Ram
 * @param
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)displayLables:(NSArray*)LablesArr {
    
    float x_position = snoLbl.frame.origin.x+snoLbl.frame.size.width + 2;
    float labelWidth = 120;
    
    @try {
        
        for (NSString * LabelStr in LablesArr) {
            taxWiseLabel = [[UILabel alloc]init];
            taxWiseLabel.layer.cornerRadius = 14;
            taxWiseLabel.layer.masksToBounds = YES;
            taxWiseLabel.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
            taxWiseLabel.textColor = [UIColor whiteColor];
            taxWiseLabel.font = [UIFont boldSystemFontOfSize:18.0];
            taxWiseLabel.textAlignment = NSTextAlignmentCenter;
            taxWiseLabel.text  = LabelStr;
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                taxWiseLabel.frame  =  CGRectMake(x_position,snoLbl.frame.origin.y,labelWidth,snoLbl.frame.size.height);
                
                [TaxReportsScrollView addSubview:taxWiseLabel];
                
                x_position = x_position + labelWidth+2;
            }
            
            taxReportsTbl.frame = CGRectMake(snoLbl.frame.origin.x, snoLbl.frame.origin.y+snoLbl.frame.size.height+5,((taxWiseLabel.frame.origin.x+taxWiseLabel.frame.size.width)-snoLbl.frame.origin.x),TaxReportsScrollView.frame.size.height-20);
            
            NSLog(@"%f",taxReportsTbl.frame.size.height);
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
        
    }
    @finally {
        
    }
}

/**
 * @description  it is tableview delegate method it will be called after numberOfSection.......
 * @date         26/09/2016
 * @method       showCompleteStockRequestInfo: numberOfRowsInSection:
 * @author       Bhargav
 * @param        UITableView
 * @param        NSInteger
 * @return       NSInteger
 * @return
 * @verified By
 * @verified On
 *
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == taxReportsTbl) {
        
        if( taxWiseArray.count &&  taxWiseLblsArr.count ){
            
            return  [[taxWiseArray[0] valueForKey:taxWiseLblsArr[0]] count];
        }
        else
            return 0;
    }
    else
        return 0;
}

/**
 * @description  it is tableview delegate method it will be called after numberOfRowsInSection.......
 * @date         26/09/2016
 * @method       tableView: heightForRowAtIndexPath:
 * @author       Bhargav
 * @param        UITableView
 * @param        NSIndexPath
 * @return       CGFloat
 * @verified By
 * @verified On
 *
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if(tableView == taxReportsTbl){
            
            return  45;
            
        }
        else
            return 45;
        
    }
    
    return 0;
    
}

/**
 * @description  it is tableview delegate method it will be called after willDisplayCell.......
 * @date         26/09/2016
 * @method       tableView: cellForRowAtIndexPath:
 * @author       Bhargav Ram
 * @param        UITableView
 * @param        UITableViewCell
 * @param
 * @return       UITableViewCell
 * @modified BY  Bhargav on 17/01/2016
 * @reason       changed the comment's section and populating the data into labels....
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView == taxReportsTbl) {
        
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
            
            UILabel * sno_Lbl = [[UILabel alloc] init];
            sno_Lbl.backgroundColor = [UIColor clearColor];
//            sno_Lbl.layer.borderWidth = 1.5;
//            sno_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            sno_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            sno_Lbl.font =  [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0f];
            sno_Lbl.textAlignment = NSTextAlignmentCenter;
            sno_Lbl.numberOfLines = 2;
            sno_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            sno_Lbl.text = [NSString stringWithFormat:@"%d",(indexPath.row)+1];
            
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            hlcell.backgroundColor = [UIColor clearColor];
            [hlcell.contentView addSubview:sno_Lbl];
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                sno_Lbl.frame = CGRectMake(0,snoLbl.frame.origin.y,snoLbl.frame.size.width,hlcell.frame.size.height);
            }
            
            float x_position = sno_Lbl.frame.origin.x+sno_Lbl.frame.size.width ;
            float labelWidth = 120;
            
            for (NSString * cellLabelStr in taxWiseLblsArr) {
                
                UILabel * cellLabel = [[UILabel alloc] init];
                
                cellLabel.textAlignment = NSTextAlignmentCenter;
                cellLabel.layer.masksToBounds = YES;
                cellLabel.font = [UIFont systemFontOfSize:15.0f];
                cellLabel.backgroundColor = [UIColor clearColor];
                cellLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
                cellLabel.textAlignment = NSTextAlignmentCenter;
                
                if ([[taxWiseArray[0] valueForKey:cellLabelStr] count] > indexPath.row)
                    cellLabel.text = [taxWiseArray[0] valueForKey:cellLabelStr][indexPath.row];
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    
                    cellLabel.frame  =  CGRectMake(x_position,sno_Lbl.frame.origin.y,labelWidth,hlcell.frame.size.height);
                    
                    [hlcell.contentView addSubview:cellLabel];
                    
                    x_position = x_position + labelWidth;
                }
            }
            
            return hlcell;
            
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
    
    return false;
}

#pragma mark displaying calendar:
/**
 * @description  here we are showing the calenderView.......
 * @date         01/03/2017
 * @method       showCalenderInPopUp
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)showCalenderInPopUp:(UIButton *)sender {
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
            
            pickView.frame = CGRectMake( 15, startDteTxt.frame.origin.y+startDteTxt.frame.size.height, 320, 320);
            
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
            
            
            if(sender.tag == 2)
                [popover presentPopoverFromRect:startDteTxt.frame inView:TaxReportsView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else
                [popover presentPopoverFromRect:endDateTxt.frame inView:TaxReportsView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
            catPopOver= popover;
            
        }
        
        else {
            
            //            customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            popover.contentViewController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
            [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            catPopOver = popover;
            
        }
        
        UIGraphicsBeginImageContext(customView.frame.size);
        [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        customView.backgroundColor = [UIColor colorWithPatternImage:image];
        
        
        
    } @catch (NSException *exception) {
        
        NSLog(@"----exception in the taxReportsView in showCalenderInPopUp:----%@",exception);
        
    }
    
}

///**
// * @description  clear the date from textField and calling services.......
// * @date         01/03/2017
// * @method       clearDate:
// * @author       Srinivasulu
// * @param        UIButton
// * @param
// * @return
// * @verified By
// * @verified On
// *
// */
//
-(void)clearDate:(UIButton *)sender{
    //    BOOL callServices = false;
    
    @try {
        
        [catPopOver dismissPopoverAnimated:YES];
        
        
        if(  sender.tag == 2){
            if((startDteTxt.text).length)
                //                callServices = true;
                
                
                startDteTxt.text = @"";
        }
        else{
            if((endDateTxt.text).length)
                //                callServices = true;
                
                endDateTxt.text = @"";
        }
        
        
        //       if(callServices){
        //            [HUD setHidden:NO];
        //
        //            searchItemsTxt.tag = [searchItemsTxt.text length];
        //            //                stockRequestsInfoArr = [NSMutableArray new];
        //            requestStartNumber = 0;
        //            totalNoOfStockRequests = 0;
        //            [self callingGetPurchaseStockReturns];
        //        }
        
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        NSLog(@"---- exception in StockReceiptView -- in  -- clearDate() ----");
        NSLog(@"---- exception is ----%@",exception);
        
    } @finally {
        
    }
    
}



-(void)populateDateToTextField:(UIButton *)sender {
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
        
        if(  sender.tag == 2){
            if ((startDteTxt.text).length != 0 && ( ![startDteTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:startDteTxt.text ];
                
                if ([existingDateString compare:selectedDateString]== NSOrderedAscending) {
                    
                    startDteTxt.text = @"";
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"start should be earlier than end date", nil) message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    return;
                }
            }
            startDteTxt.text = dateString;
        }
        else{
            
            if ((endDateTxt.text).length != 0 && ( ![endDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:endDateTxt.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    endDateTxt.text = @"";
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Closed date should not be earlier than start date", nil) message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    return;
                }
            }
            endDateTxt.text = dateString;
            
        }
        
    } @catch (NSException *exception) {
        
    }
    @finally{
    }
    
}



-(void)goButtonPressed:(UIButton *)sender  {
    
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        startIndex = 0;
        
        [self getTaxReports];
        
        //        [taxReportsTbl reloadData];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}





#pragma -mark method used to display alert/warning messages....

/**
 * @description  adding the  alertMessage's based on input
 * @date         09/05/2017
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

-(void)displayAlertMessage:(NSString *)message    horizontialAxis:(float)xPostion  verticalAxis:(float)yPosition msgType:(NSString *)messageType   conentWidth:(float )labelWidth contentHeight:(float)labelHeight   isSoundRequired:(BOOL)soundStatus  timming:(float)noOfSecondsToDisplay    noOfLines:(int)noOfLines{
    
    
    //    [self displayAlertMessage: @"No Products Avaliable" horizontialAxis:segmentedControl.frame.origin.x   verticalAxis:segmentedControl.frame.origin.y  msgType:@"warning" timming:2.0];
    
    @try {
        AudioServicesPlayAlertSound(soundFileObject);
        
        if ([userAlertMessageLbl isDescendantOfView:self.view] ) {
            [userAlertMessageLbl removeFromSuperview];
            
        }
        
        userAlertMessageLbl = [[UILabel alloc] init];
        userAlertMessageLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20];
        userAlertMessageLbl.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        userAlertMessageLbl.layer.cornerRadius = 5.0f;
        userAlertMessageLbl.text =  message;
        userAlertMessageLbl.textAlignment = NSTextAlignmentCenter;
        userAlertMessageLbl.numberOfLines = noOfLines;
        userAlertMessageLbl.tag = 2;
        
        if ([messageType caseInsensitiveCompare:@"SUCCESS"] == NSOrderedSame) {
            userAlertMessageLbl.tag = 4;
            
            userAlertMessageLbl.textColor = [UIColor colorWithRed:114.0/255.0 green:203.0/255.0 blue:158.0/255.0 alpha:1.0];
            
            if(soundStatus){
                
                SystemSoundID    soundFileObject1;
                NSURL * tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
                self.soundFileURLRef = (__bridge CFURLRef) tapSound;
                AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                AudioServicesPlaySystemSound (soundFileObject1);
            }
        }
        else{
            userAlertMessageLbl.textColor = [UIColor redColor];
            
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
            if (version > 8.0) {
                userAlertMessageLbl.frame = CGRectMake(xPostion + 75, yPosition-35,200,30);
                userAlertMessageLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
            }
            else{
                userAlertMessageLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
                userAlertMessageLbl.frame = CGRectMake(xPostion+75, yPosition-35,200,30);
            }
        }
        [self.view addSubview:userAlertMessageLbl];
        fadOutTime = [NSTimer scheduledTimerWithTimeInterval:noOfSecondsToDisplay target:self selector:@selector(removeAlertMessages) userInfo:nil repeats:NO];
    }
    @catch (NSException * exception) {
        [HUD setHidden:YES];
        
        NSLog(@"--------exception in the stockReceiptView in displayAlertMessage---------%@",exception);
        NSLog(@"----exception while creating the useralertMesssageLbl------------%@",exception);
        
    }
}


/**
 * @description  removing alertMessage add in the  disPlayAlertMessage method
 * @date         09/05/2017
 * @method       removeAlertMessages
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)removeAlertMessages{
    @try {
        
        if ([userAlertMessageLbl isDescendantOfView:self.view])
            [userAlertMessageLbl removeFromSuperview];
    }
    @catch (NSException * exception) {
        [HUD setHidden:YES];
        
        NSLog(@"--------exception in the stockReceiptView in removeAlertMessages---------%@",exception);
        NSLog(@"----exception in removing userAlertMessageLbl label------------%@",exception);
    }
}



#pragma  -mark super class method....

/**
 * @description  in this mehtod we are navigating back to homePage....
 * @date         13/07/2017..
 * @method       goToHome
 * @author       Srinivasulu
 * @param
 * @param
 * @return
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












@end
