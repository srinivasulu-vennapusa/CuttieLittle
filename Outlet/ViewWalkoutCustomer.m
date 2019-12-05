//
//  ViewWalkoutCustomer.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 10/10/16.
//
//

#import "CheckWifi.h"
#import "ViewWalkoutCustomer.h"
#import "CustomerWalkOut.h"
#import "WalkoutDetails.h"
#import "OmniHomePage.h"


@interface ViewWalkoutCustomer ()

@end

@implementation ViewWalkoutCustomer



int totalNoOfRecords = 0;


-(void)viewDidAppear:(BOOL)animated {
    
    @try {
        
        if( (walkoutLIstArr == nil) || ( walkoutLIstArr.count == 0)){
            [HUD setHidden:NO];
            
            walkoutLIstArr = [NSMutableArray new];
            startIndexint_ = 0;
            
            [self getCustomerWalkout:totalNoOfRecords];
        }
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    //         Show the HUD
    //    [HUD show:YES];
    //    [HUD setHidden:NO];
   // HUD.labelText = NSLocalizedString(@"HUD_LABEL", nil);
    
    HUD.labelText = @"Please wait..";

    
    //main view bakground setting...
    self.view.backgroundColor = [UIColor blackColor];
    self.titleLabel.text = NSLocalizedString(@"CUSTOMER WALKOUTS LIST", nil);
    version = [UIDevice currentDevice].systemVersion.floatValue;
    
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (_soundFileURLRef,&_soundFileObject);
    
    
    
    viewWalkout = [[UIView alloc] init];
    viewWalkout.backgroundColor = [UIColor blackColor];
    viewWalkout.layer.borderWidth = 1.0f;
    viewWalkout.layer.cornerRadius = 10.0f;
    viewWalkout.layer.borderColor = [UIColor clearColor].CGColor;
    
    
    departmentFld = [[UITextField alloc] init];
    departmentFld.borderStyle = UITextBorderStyleRoundedRect;
    departmentFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    departmentFld.font = [UIFont systemFontOfSize:18.0];
    departmentFld.backgroundColor = [UIColor clearColor];
    departmentFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    departmentFld.autocorrectionType = UITextAutocorrectionTypeNo;
    departmentFld.layer.borderWidth = 1.0f;
    departmentFld.delegate = self;
    departmentFld.userInteractionEnabled = NO;
    
    departmentFld.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0]. CGColor;
    departmentFld.placeholder = NSLocalizedString(@" Department", nil);
    
    [departmentFld addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventValueChanged];
    
    
    UIImage *dprtmntImg = [UIImage imageNamed:@"arrow_1.png"];
    
    selctDprtmnt = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [selctDprtmnt setBackgroundImage:dprtmntImg forState:UIControlStateNormal];
    [selctDprtmnt addTarget:self
                     action:@selector(populateCstmrDprtmnt) forControlEvents:UIControlEventTouchDown];
    
    
    brandFld = [[UITextField alloc] init];
    brandFld.borderStyle = UITextBorderStyleRoundedRect;
    brandFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    brandFld.font = [UIFont systemFontOfSize:18.0];
    brandFld.backgroundColor = [UIColor clearColor];
    brandFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    brandFld.autocorrectionType = UITextAutocorrectionTypeNo;
    brandFld.layer.borderWidth = 1.0f;
    
    brandFld.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    brandFld.placeholder = NSLocalizedString(@" Brand", nil);
    [brandFld addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    brandFld.delegate = self;
    brandFld.userInteractionEnabled = NO;
    
    
    UIImage *brandImg = [UIImage imageNamed:@"arrow_1.png"];
    
    selctBrand = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [selctBrand setBackgroundImage:brandImg forState:UIControlStateNormal];
    [selctBrand addTarget:self
                   action:@selector(populateBrand) forControlEvents:UIControlEventTouchDown];
    
    
    strtDteFld = [[UITextField alloc] init];
    strtDteFld.borderStyle = UITextBorderStyleRoundedRect;
    strtDteFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    strtDteFld.font = [UIFont systemFontOfSize:18.0];
    strtDteFld.backgroundColor = [UIColor clearColor];
    strtDteFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    strtDteFld.autocorrectionType = UITextAutocorrectionTypeNo;
    strtDteFld.layer.borderWidth = 1.0f;
    
    strtDteFld.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    strtDteFld.placeholder = NSLocalizedString(@" Start Date", nil);
    [strtDteFld addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    strtDteFld.delegate = self;
    strtDteFld.userInteractionEnabled = NO;
    
    
    UIImage *strtImg = [UIImage imageNamed:@"Calandar_Icon.png"];
    
    selctStrtDte = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [selctStrtDte setBackgroundImage:strtImg forState:UIControlStateNormal];
    [selctStrtDte addTarget:self
                     action:@selector(selectDate:) forControlEvents:UIControlEventTouchDown];
    selctStrtDte.tag = 2;
    
    
    endDteFld = [[UITextField alloc] init];
    endDteFld.borderStyle = UITextBorderStyleRoundedRect;
    endDteFld.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    endDteFld.font = [UIFont systemFontOfSize:18.0];
    endDteFld.backgroundColor = [UIColor clearColor];
    endDteFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    endDteFld.autocorrectionType = UITextAutocorrectionTypeNo;
    endDteFld.layer.borderWidth = 1.0f;
    
    endDteFld.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    endDteFld.placeholder = NSLocalizedString(@" End Date", nil);
    [endDteFld addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    endDteFld.delegate = self;
    endDteFld.userInteractionEnabled = NO;
    
    
    UIImage *endImg = [UIImage imageNamed:@"Calandar_Icon.png"];
    
    selectEndDte = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [selectEndDte setBackgroundImage:endImg forState:UIControlStateNormal];
    [selectEndDte addTarget:self
                     action:@selector(selectDate:) forControlEvents:UIControlEventTouchDown];
    
    
    UIImage *summaryImg = [UIImage imageNamed:@"summaryInfo.png"];
    
    UIButton * summaryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [summaryBtn setBackgroundImage:summaryImg forState:UIControlStateNormal];
    [summaryBtn addTarget:self
                   action:@selector(getSummary:) forControlEvents:UIControlEventTouchDown];
    
    
    
    
    
    
    
    /** UIScrollView Design */
//    scrollView = [[UIScrollView alloc] init];
//    scrollView.hidden = NO;
//    scrollView.backgroundColor = [UIColor clearColor];
//    scrollView.bounces = FALSE;
//    
    
    
    sNoLbl = [[UILabel alloc] init] ;
    sNoLbl.text = NSLocalizedString(@"S No", nil);
    sNoLbl.layer.cornerRadius = 14;
    sNoLbl.layer.masksToBounds = YES;
    sNoLbl.numberOfLines = 2;
    sNoLbl.textAlignment = NSTextAlignmentCenter;
    sNoLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    sNoLbl.textColor = [UIColor whiteColor];
    
    cstmrName = [[UILabel alloc] init] ;
    cstmrName.text = NSLocalizedString(@"Name", nil);
    cstmrName.layer.cornerRadius = 14;
    cstmrName.layer.masksToBounds = YES;
    cstmrName.numberOfLines = 2;
    cstmrName.textAlignment = NSTextAlignmentCenter;
    cstmrName.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    cstmrName.textColor = [UIColor whiteColor];
    
    cstmrMoble = [[UILabel alloc] init] ;
    cstmrMoble.text = NSLocalizedString(@"Mobile", nil);
    cstmrMoble.layer.cornerRadius = 14;
    cstmrMoble.layer.masksToBounds = YES;
    cstmrMoble.numberOfLines = 2;
    cstmrMoble.textAlignment = NSTextAlignmentCenter;
    cstmrMoble.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    cstmrMoble.textColor = [UIColor whiteColor];
    
    date = [[UILabel alloc] init];
    date.text = @"Date";
    date.layer.cornerRadius = 14;
    date.layer.masksToBounds = YES;
    date.textAlignment = NSTextAlignmentCenter;
    date.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    date.textColor = [UIColor whiteColor];
    
    inTime = [[UILabel alloc] init];
    inTime.text = @"In Time";
    inTime.layer.cornerRadius = 14;
    inTime.layer.masksToBounds = YES;
    inTime.textAlignment = NSTextAlignmentCenter;
    inTime.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    inTime.textColor = [UIColor whiteColor];
    
    outTime = [[UILabel alloc] init] ;
    outTime.text = @"Out Time";
    outTime.layer.cornerRadius = 14;
    outTime.layer.masksToBounds = YES;
    outTime.textAlignment = NSTextAlignmentCenter;
    outTime.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    outTime.textColor = [UIColor whiteColor];
    
    departmnt = [[UILabel alloc] init] ;
    departmnt.text = @"Department";
    departmnt.layer.cornerRadius = 14;
    departmnt.layer.masksToBounds = YES;
    departmnt.textAlignment = NSTextAlignmentCenter;
    departmnt.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    departmnt.textColor = [UIColor whiteColor];
    
    
    walkoutRsn = [[UILabel alloc] init] ;
    walkoutRsn.text = @"Reason";
    walkoutRsn.layer.cornerRadius = 14;
    walkoutRsn.layer.masksToBounds = YES;
    walkoutRsn.textAlignment = NSTextAlignmentCenter;
    walkoutRsn.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    walkoutRsn.textColor = [UIColor whiteColor];
    
    action = [[UILabel alloc] init] ;
    action.text = @"Action";
    action.layer.cornerRadius = 14;
    action.layer.masksToBounds = YES;
    action.textAlignment = NSTextAlignmentCenter;
    action.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    action.textColor = [UIColor whiteColor];
    
    
    
    
    
    viewWalkOutTbl = [[UITableView alloc] init];
    viewWalkOutTbl.dataSource = self;
    viewWalkOutTbl.delegate = self;
    viewWalkOutTbl.backgroundColor = [UIColor clearColor];
    viewWalkOutTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    
    
    
    [viewWalkout addSubview:departmentFld];
    [viewWalkout addSubview:selctDprtmnt];
    [viewWalkout addSubview:brandFld];
    [viewWalkout addSubview:selctBrand];
    [viewWalkout addSubview:strtDteFld];
    [viewWalkout addSubview:selctStrtDte];
    [viewWalkout addSubview:endDteFld];
    [viewWalkout addSubview:selectEndDte];
    [viewWalkout addSubview:summaryBtn];
    
    [viewWalkout addSubview:sNoLbl];
    [viewWalkout addSubview:cstmrName];
    [viewWalkout addSubview:cstmrMoble];
    [viewWalkout addSubview:date];
    [viewWalkout addSubview:inTime];
    [viewWalkout addSubview:outTime];
    [viewWalkout addSubview:departmnt];
    [viewWalkout addSubview:walkoutRsn];
    [viewWalkout addSubview:action];
    
    [viewWalkout addSubview:viewWalkOutTbl];
    
    [self.view addSubview:viewWalkout];
    
    
    
    
    
    
    viewWalkout.frame = CGRectMake(10, 80, self.view.frame.size.width - 20, self.view.frame.size.height+40);
    
    
    summaryBtn.frame = CGRectMake(viewWalkout.frame.size.width - 50
                                  , 5, 40, 40);

    
    departmentFld.frame  = CGRectMake( 10, summaryBtn.frame.origin.y + summaryBtn.frame.size.height + 10, 220, 40);
    
    selctDprtmnt.frame = CGRectMake(departmentFld.frame.origin.x + departmentFld.frame.size.width - 40, departmentFld.frame.origin.y - 10, 50, 65);
    
    
    brandFld.frame  = CGRectMake(departmentFld.frame.origin.x+ departmentFld.frame.size.width+20, departmentFld.frame.origin.y, 220, 40);
    
    selctBrand.frame = CGRectMake(brandFld.frame.origin.x + brandFld.frame.size.width - 40, brandFld.frame.origin.y - 10, 50, 65);
    
    strtDteFld.frame  = CGRectMake(brandFld.frame.origin.x+ brandFld.frame .size.width+60, departmentFld.frame.origin.y, 220, 40);
    
    selctStrtDte.frame = CGRectMake(strtDteFld.frame.origin.x + strtDteFld.frame.size.width - 45, strtDteFld.frame.origin.y+2, 40, 35);
    
    
    endDteFld.frame  = CGRectMake(strtDteFld.frame.origin.x+ strtDteFld.frame.size.width+20, departmentFld.frame.origin.y, 220, 40);
    
    selectEndDte.frame = CGRectMake(endDteFld.frame.origin.x + endDteFld.frame.size.width - 45, endDteFld.frame.origin.y+2 , 40, 35);

    
    
    
    
    sNoLbl.frame = CGRectMake( viewWalkout.frame.origin.x,  departmentFld.frame.origin.y + departmentFld.frame.size.height + 10, 60, 40);
    sNoLbl.font = [UIFont boldSystemFontOfSize:16];
    
    
    
    cstmrName.frame = CGRectMake( sNoLbl.frame.origin.x + sNoLbl.frame.size.width + 2 , sNoLbl.frame.origin.y ,  90  , sNoLbl.frame.size.height);
    cstmrName.font = [UIFont  boldSystemFontOfSize:16];
    
    
    cstmrMoble.frame = CGRectMake( cstmrName.frame.origin.x + cstmrName.frame.size.width + 2 , sNoLbl.frame.origin.y ,  110  , sNoLbl.frame.size.height);
    cstmrMoble.font = [UIFont  boldSystemFontOfSize:16];
    
    
    date.frame = CGRectMake( cstmrMoble.frame.origin.x + cstmrMoble.frame.size.width + 2 , sNoLbl.frame.origin.y ,  120  , sNoLbl.frame.size.height);
    date.font = [UIFont boldSystemFontOfSize:16];
    
    
    inTime.frame = CGRectMake( date.frame.origin.x + date.frame.size.width + 2 , sNoLbl.frame.origin.y ,  100  , sNoLbl.frame.size.height);
    inTime.font = [UIFont  boldSystemFontOfSize:16];
    
    outTime.frame = CGRectMake( inTime.frame.origin.x + inTime.frame.size.width + 2 , sNoLbl.frame.origin.y ,  100  , sNoLbl.frame.size.height);
    outTime.font = [UIFont  boldSystemFontOfSize:16];
    
    departmnt.frame = CGRectMake( outTime.frame.origin.x + outTime.frame.size.width + 2 , sNoLbl.frame.origin.y ,  120  , sNoLbl.frame.size.height);
    departmnt.font = [UIFont  boldSystemFontOfSize:16];
    
    
    walkoutRsn.frame = CGRectMake( departmnt.frame.origin.x + departmnt.frame.size.width + 2 , sNoLbl.frame.origin.y ,  140  , sNoLbl.frame.size.height);
    walkoutRsn.font = [UIFont  boldSystemFontOfSize:16];
    
    action.frame = CGRectMake( walkoutRsn.frame.origin.x + walkoutRsn.frame.size.width + 2 , sNoLbl.frame.origin.y ,  120  , sNoLbl.frame.size.height);
    action.font = [UIFont  boldSystemFontOfSize:16];
    
    
    departmentFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:departmentFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    brandFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:brandFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    strtDteFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:strtDteFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
    
    
    endDteFld.attributedPlaceholder = [[NSAttributedString alloc]initWithString:endDteFld.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]}];
        viewWalkOutTbl.frame = CGRectMake(departmentFld.frame.origin.x, sNoLbl.frame.origin.y + sNoLbl.frame.size.height + 5,endDteFld.frame.origin.x + endDteFld.frame.size.width -  departmentFld.frame.origin.x, 490 );
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark getCustomerWalkout :

-(void)getCustomerWalkout:(int)totalNoOfRecords{
    
    @try {
        
        [HUD show: YES];
        [HUD setHidden:NO];
        NSArray *keys = @[REQUEST_HEADER,START_INDEX,CUSTOMER_DEPARTMENT,@"requiredBrand",
                         @"startDateStr",@"endDateStr",kMaxRecords];
        NSArray *objects = @[[RequestHeader getRequestHeader],[NSString stringWithFormat:@"%d",startIndexint_],departmentFld.text ,brandFld.text,strtDteFld.text ,endDteFld.text,@"10"];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * walkoutJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.customerWalkoutDelegate = self;
        [webServiceController getCustomerWalkout:walkoutJsonString];
        
    }
    @catch (NSException *exception) {
        
    }
    
}

-(void)getCustomerWalkOutSuccessResponse:(NSDictionary*)sucessDictionary {
    
    
    
    @try {
        
        totalNoOfRecords  = [[sucessDictionary valueForKey:TOTAL_BILLS] integerValue];

        
        for(NSDictionary *dic in [sucessDictionary valueForKey:@"walkoutsList"]){
            
            [walkoutLIstArr addObject:dic];
        }
        
    }
    @catch (NSException *exception) {
        
        
    }
    @finally {
        [viewWalkOutTbl reloadData];
        
        [HUD setHidden: YES];
    }
    
}
-(void)getCustomerWalkOutErrorResponse:(NSString*)error {
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Records Found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [alert show];
//    [alert release];
//    
    [HUD setHidden:YES];
    
    [viewWalkOutTbl reloadData];
}




#pragma mark getDepartmentList :

-(void)callingDepartmentList {
    @try {
        [HUD show: YES];
        
        [HUD setHidden:NO];
        
        departmentArr  = [NSMutableArray new];

        NSArray *keys = @[REQUEST_HEADER,START_INDEX,@"noOfSubDepartments",@"slNo"];
        NSArray *objects = @[[RequestHeader getRequestHeader],@"-1",[NSNumber numberWithBool:true],[NSNumber numberWithBool:true]];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * departmentJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.outletMasterDelegate = self;
        [webServiceController getDepartmentList:departmentJsonString];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
}

-(void)getDepartmentSuccessResponse:(NSDictionary*)sucessDictionary{
    @try {
        
        for (NSDictionary * department in  [sucessDictionary valueForKey: @"departments" ]) {
            
            
            [departmentArr addObject:department];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        [HUD setHidden: YES];
    }
    
    
}
-(void)getDepartmentErrorResponse:(NSString*)error {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Records Found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    
    [HUD setHidden:YES];
    
    
}


-(void)populateCstmrDprtmnt {
    @try {
        
        
        
        AudioServicesPlaySystemSound(_soundFileObject);
        
        
        [self callingDepartmentList];

        
        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 200,140)];
        customView.opaque = NO;
        customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customView.layer.borderWidth = 2.0f;
        [customView setHidden:NO];
        
        deprtmntTbl = [[UITableView alloc] init];
        deprtmntTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
        deprtmntTbl.dataSource = self;
        deprtmntTbl.delegate = self;
        (deprtmntTbl.layer).borderWidth = 1.0f;
        deprtmntTbl.layer.cornerRadius = 3;
        deprtmntTbl.layer.borderColor = [UIColor grayColor].CGColor;
        deprtmntTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            deprtmntTbl.frame = CGRectMake(0, 0, departmentFld.frame.size.width+40, departmentFld.frame.size.height+100);
            
            
        }
        
        
        [customView addSubview:deprtmntTbl];
        
        customerInfoPopUp.view = customView;
        
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            [popover presentPopoverFromRect:departmentFld.frame inView:viewWalkout permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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
        
        
        
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        
    }
    
    
}




#pragma mark getBrandList :


-(void)callingBrandList {
    @try {
        [HUD show: YES];
        
        [HUD setHidden:NO];
        
        brandListArr = [NSMutableArray new];

        
        NSArray *keys = @[REQUEST_HEADER,START_INDEX,@"bName",@"slNo"];
        NSArray *objects = @[[RequestHeader getRequestHeader],@"-1",@"", [NSNumber numberWithBool:true]];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * brandListJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.outletMasterDelegate = self;
        [webServiceController getBrandList:brandListJsonString];
        
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
}

-(void)getBrandMasterSuccessResponse:(NSDictionary*)sucessDictionary {
    
    @try {
        
        for (NSDictionary * brand in  [sucessDictionary valueForKey: @"brandDetails" ]) {
            
//           [brandListArr addObject:@"All"];
            
            
            [brandListArr addObject:brand];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        [HUD setHidden:YES];
    }
    
    
}
-(void)getBrandMasterErrorResponse:(NSString*)error {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No products found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    
    [HUD setHidden:YES];
    
}



-(void)populateBrand  {
    
    @try {
        
        AudioServicesPlaySystemSound(_soundFileObject);
        
        [self callingBrandList];
        
        
        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 200,140)];
        customView.opaque = NO;
        customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customView.layer.borderWidth = 2.0f;
        [customView setHidden:NO];
        
        brandTbl = [[UITableView alloc] init];
        brandTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
        brandTbl.dataSource = self;
        brandTbl.delegate = self;
        (brandTbl.layer).borderWidth = 1.0f;
        brandTbl.layer.cornerRadius = 3;
        brandTbl.layer.borderColor = [UIColor grayColor].CGColor;
        brandTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            brandTbl.frame = CGRectMake(0, 0, brandFld.frame.size.width+40, brandFld.frame.size.height+100);
            
            
        }
        
        
        [customView addSubview:brandTbl];
        
        customerInfoPopUp.view = customView;
        
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            [popover presentPopoverFromRect:brandFld.frame inView:viewWalkout permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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
        
        
        }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [brandTbl reloadData];
        
    }
    
}


-(void) selectDate:(UIButton *) sender {
    
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (_soundFileObject);
    
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
        
        pickView.frame = CGRectMake(15, strtDteFld.frame.origin.y+strtDteFld.frame.size.height, 320, 320);
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
    [pickButton addTarget:self action:@selector(populateDateToTextField:) forControlEvents:UIControlEventTouchUpInside];
    pickButton.layer.borderColor = [UIColor blackColor].CGColor;
    pickButton.layer.borderWidth = 0.5f;
    pickButton.layer.cornerRadius = 12;
    pickButton.tag = sender.tag;
    [customView addSubview:myPicker];
    [customView addSubview:pickButton];
    
    
    customerInfoPopUp.view = customView;
    
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        
        if (sender.tag == 2) {
            [popover presentPopoverFromRect:strtDteFld.frame inView:viewWalkout permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
//            strtDteFld.tag = 2;
            
        } else {
            
            [popover presentPopoverFromRect:endDteFld.frame inView:viewWalkout permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
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
-(void)populateDateToTextField:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (_soundFileObject);
    
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
            if ((strtDteFld.text).length != 0 && ( ![strtDteFld.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:strtDteFld.text ];
                
                if ([existingDateString compare:selectedDateString]== NSOrderedAscending) {
                    
                    strtDteFld.text = @"";
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"start should be earlier than end date", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
                    [alert show];
                    return;
                }
            }
            strtDteFld.text = dateString;
            
        }
        else{
            
            if ((endDteFld.text).length != 0 && ( ![endDteFld.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:endDteFld.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    endDteFld.text = @"";
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"closed_date_should_not_be_earlier_than_created_date", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
                    [alert show];
                    return;
                }
            }
            endDteFld.text = dateString;
            
        }
        
        
        
        
        
    } @catch (NSException *exception) {
        
    }
    @finally{
        
    }
    
    
    @try {
        
        if ((endDteFld.text).length != 0 &&  (strtDteFld.text).length != 0){
            totalNoOfRecords = 0;
            startIndexint_ = 0;
            walkoutLIstArr = [NSMutableArray new];
            
            [self getCustomerWalkout:startIndexint_];
            
        }
        
    }
    @catch (NSException * exception) {
        
        [HUD setHidden:YES];
        NSLog(@"----exception in the populateDateToTextField:----%@",exception);
        NSLog(@"------exception while creating------%@",exception);
        
    }
}


//

- (void)getSummary:(UIButton *)sender {
    AudioServicesPlaySystemSound (_soundFileObject);

    
}

#pragma mark navigation methods




- (void)openCustomerWalkuts:(UIButton *)sender {
    
    AudioServicesPlaySystemSound (_soundFileObject);

    
    CustomerWalkOut *viewController = [[CustomerWalkOut alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)openCustomerWalkoutDetails:(UIButton *)sender {
    AudioServicesPlaySystemSound (_soundFileObject);

    NSDictionary *detailsDic = walkoutLIstArr[sender.tag];
    
    NSString *walkout = [detailsDic valueForKey:@"slno"];
    WalkoutDetails *viewController = [[WalkoutDetails alloc]init];
    viewController.walkoutID = walkout;
    [self.navigationController pushViewController:viewController animated:YES];
    
}

#pragma mark table View Delegates delegates


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == viewWalkOutTbl ) {
        if (walkoutLIstArr.count)
            
            return walkoutLIstArr.count;
        else
            return 2;
        
    }
    
    else if (tableView == deprtmntTbl ) {
        
        
        return  departmentArr.count;
    }
    
    else if (tableView == brandTbl ) {
        
        
        return  brandListArr.count;
    }
    
    else
        return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == viewWalkOutTbl ) {
        return 60;
    }
    else  if (tableView == deprtmntTbl ) {
        return 45;
    }
    
    else  if (tableView == brandTbl ) {
        return 45;
    }
    
    else
        return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    tableView.separatorColor = [UIColor clearColor];
//    colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0
    
    if (tableView == viewWalkOutTbl){
        @try {
            
            static NSString *CellIdentifier =  @"Cell";
            
            UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if ((hlcell.contentView).subviews){
                
                for (UIView *subview in (hlcell.contentView).subviews) {
                    [subview removeFromSuperview];
                }
            }
            
            if(hlcell == nil) {
                hlcell =  [[UITableViewCell alloc]
                           initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
                hlcell.accessoryType = UITableViewCellAccessoryNone;
            }
            
            
            
            UILabel *sNo = [[UILabel alloc] init] ;
            sNo.layer.borderWidth = 0;
            sNo.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            sNo.backgroundColor = [UIColor clearColor];
            sNo.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            sNo.textAlignment=NSTextAlignmentCenter;
            
            
            UILabel *coustmrName = [[UILabel alloc] init] ;
            coustmrName.layer.borderWidth = 0;
            coustmrName.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            coustmrName.backgroundColor = [UIColor clearColor];
            coustmrName.textAlignment = NSTextAlignmentCenter;
            coustmrName.numberOfLines = 2;
            coustmrName.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            UILabel *coustmrMobl = [[UILabel alloc] init] ;
            coustmrMobl.layer.borderWidth = 0;
            coustmrMobl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            coustmrMobl.backgroundColor = [UIColor clearColor];
            coustmrMobl.textAlignment = NSTextAlignmentCenter;
            coustmrMobl.numberOfLines = 2;
            coustmrMobl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            
            UILabel *dateLbl = [[UILabel alloc] init] ;
            dateLbl.layer.borderWidth = 0;
            dateLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            dateLbl.backgroundColor = [UIColor clearColor];
            dateLbl.textAlignment = NSTextAlignmentCenter;
            dateLbl.numberOfLines = 2;
            dateLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            UILabel *inTimeLbl = [[UILabel alloc] init] ;
            inTimeLbl.layer.borderWidth =0;
            inTimeLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            inTimeLbl.backgroundColor = [UIColor clearColor];
            inTimeLbl.textAlignment = NSTextAlignmentCenter;
            inTimeLbl.numberOfLines = 2;
            inTimeLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            
            UILabel *outTimeLbl = [[UILabel alloc] init] ;
            outTimeLbl.layer.borderWidth = 0;
            outTimeLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            outTimeLbl.backgroundColor = [UIColor clearColor];
            outTimeLbl.textAlignment = NSTextAlignmentCenter;
            outTimeLbl.numberOfLines = 2;
            outTimeLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            
            UILabel * departmntLbl = [[UILabel alloc] init] ;
            departmntLbl.layer.borderWidth = 0;
            departmntLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            departmntLbl.backgroundColor = [UIColor clearColor];
            departmntLbl.textAlignment = NSTextAlignmentCenter;
            departmntLbl.numberOfLines = 2;
            departmntLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            
            UILabel * reasnLbl = [[UILabel alloc] init] ;
            reasnLbl.layer.borderWidth = 0;
            reasnLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            reasnLbl.backgroundColor = [UIColor clearColor];
            reasnLbl.textAlignment = NSTextAlignmentCenter;
            reasnLbl.numberOfLines = 1;
            reasnLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            newBtn = [[UIButton alloc] init];
            newBtn.backgroundColor = [UIColor blackColor];
            newBtn.titleLabel.textColor = [UIColor whiteColor];
            newBtn.userInteractionEnabled = YES;
            newBtn.tag = indexPath.row;
            [newBtn addTarget:self action:@selector(openCustomerWalkuts:) forControlEvents:UIControlEventTouchUpInside];
            [newBtn setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0]forState:UIControlStateNormal];;
            
            
            viewBtn = [[UIButton alloc] init];
            viewBtn.backgroundColor = [UIColor blackColor];
            viewBtn.titleLabel.textColor = [UIColor whiteColor];
            viewBtn.userInteractionEnabled = YES;
            viewBtn.tag = indexPath.row;
            [viewBtn addTarget:self action:@selector(openCustomerWalkoutDetails:) forControlEvents:UIControlEventTouchUpInside];
            
            [viewBtn setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0]forState:UIControlStateNormal];
            
            UILabel *line = [[UILabel alloc] init];
            //            line_2.textColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0];
            line.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
            
            
            line.frame = CGRectMake( 0, hlcell.frame.size.height - 2, viewWalkOutTbl.frame.size.width, 2);
            
            line.text = @"-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------";
            
            
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                
                sNo.frame = CGRectMake( 0, 0, sNoLbl.frame.size.width , hlcell.frame.size.height);
                
                coustmrName.frame = CGRectMake( sNo.frame.origin.x + sNo.frame.size.width , 0, cstmrName.frame.size.width ,  hlcell.frame.size.height);
                
                coustmrMobl.frame = CGRectMake( coustmrName.frame.origin.x + coustmrName.frame.size.width , 0, cstmrMoble.frame.size.width ,  hlcell.frame.size.height);
                
                dateLbl.frame = CGRectMake( coustmrMobl.frame.origin.x + coustmrMobl.frame.size.width+2 , 0, date.frame.size.width ,  hlcell.frame.size.height);
                
                inTimeLbl.frame = CGRectMake( dateLbl.frame.origin.x + dateLbl.frame.size.width , 0, inTime.frame.size.width ,  hlcell.frame.size.height);
                
                outTimeLbl.frame = CGRectMake( inTimeLbl.frame.origin.x + inTimeLbl.frame.size.width , 0, outTime.frame.size.width ,  hlcell.frame.size.height);
                
                departmntLbl.frame = CGRectMake( departmnt.frame.origin.x-5  , 0, departmnt.frame.size.width  ,  hlcell.frame.size.height);
                
                reasnLbl.frame = CGRectMake( departmntLbl.frame.origin.x + departmntLbl.frame.size.width , 0, walkoutRsn.frame.size.width ,  hlcell.frame.size.height);
                
                
                newBtn.frame = CGRectMake(action.frame.origin.x-5, 0,(action.frame.size.width-3)/2 ,  hlcell.frame.size.height);
                
                viewBtn.frame = CGRectMake(newBtn.frame.origin.x+newBtn.frame.size.width, 0,(action.frame.size.width - newBtn.frame.size.width) ,  hlcell.frame.size.height);
                
                
                
            }
            else {
                
                
            }
            
            
            sNo.font =  [UIFont fontWithName:kLabelFont size:18];
            coustmrName.font =  [UIFont fontWithName:kLabelFont size:18];
            coustmrMobl.font =  [UIFont fontWithName:kLabelFont size:18];
            dateLbl.font =  [UIFont fontWithName:kLabelFont size:18];
            inTimeLbl.font =  [UIFont fontWithName:kLabelFont size:18];
            outTimeLbl.font =  [UIFont fontWithName:kLabelFont size:18];
            departmntLbl.font =  [UIFont fontWithName:kLabelFont size:18];
            reasnLbl.font =  [UIFont fontWithName:kLabelFont size:18];
            
            newBtn.titleLabel.font = [UIFont fontWithName:kLabelFont size:20];
            viewBtn.titleLabel.font = [UIFont fontWithName:kLabelFont size:20];
            
            
            
            hlcell.backgroundColor = [UIColor clearColor];
            [hlcell.contentView addSubview:sNo];
            [hlcell.contentView addSubview:coustmrName];
            [hlcell.contentView addSubview:coustmrMobl];
            [hlcell.contentView addSubview:dateLbl];
            [hlcell.contentView addSubview:inTimeLbl];
            [hlcell.contentView addSubview:outTimeLbl];
            [hlcell.contentView addSubview:departmntLbl];
            [hlcell.contentView addSubview:reasnLbl];
            [hlcell.contentView addSubview:newBtn];
            [hlcell.contentView addSubview:viewBtn];
            [hlcell.contentView addSubview:line];
            
            if (walkoutLIstArr.count >= indexPath.row && walkoutLIstArr.count ) {
                
                NSDictionary *dic = walkoutLIstArr[indexPath.row];
                
                sNo.text = [NSString stringWithFormat:@"%d",indexPath.row + 1];
                coustmrName.text = [[dic valueForKey:@"customerObj"]valueForKey:@"name"];
                coustmrMobl.text = [dic valueForKey:@"mobileNum"];
                dateLbl.text = [[dic valueForKey:@"createdDateStr"] componentsSeparatedByString:@" "][0];
                inTimeLbl.text = [[dic valueForKey:@"walkInTime"] componentsSeparatedByString:@" "][0];
                
                outTimeLbl.text = [[dic valueForKey:@"walkOutTime"] componentsSeparatedByString:@" "][0];
                departmntLbl.text = [dic valueForKey:@"department" ];
                reasnLbl.text = [dic valueForKey:@"walkoutReason"];
                
            }
            else {
                
                sNo.text = @"--";
                coustmrName.text = @"--";
                coustmrMobl.text =@"--";
                dateLbl.text = @"--";
                inTimeLbl.text = @"--";
                outTimeLbl.text = @"--";
                departmntLbl.text = @"--";
                reasnLbl.text =@"--";
                
                newBtn.frame = CGRectMake(reasnLbl.frame.origin.x + reasnLbl.frame.size.width + 2, 0, action.frame.size.width  ,  hlcell.frame.size.height);
                viewBtn.hidden = YES;
                
                
            }
            
            return hlcell;
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
            [newBtn setTitle:NSLocalizedString(@"New", nil) forState:UIControlStateNormal];
            [viewBtn setTitle:NSLocalizedString(@"Open", nil) forState:UIControlStateNormal];
            
        }
        
    }
    
    
    
    
    else if (tableView == deprtmntTbl)  {
        
        @try {
            tableView.separatorColor = [UIColor blackColor];

            static NSString *CellIdentifier = @"Cell";
            
            UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (hlcell == nil) {
                hlcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                hlcell.frame = CGRectZero;
            }
            if ((hlcell.contentView).subviews){
                for (UIView *subview in (hlcell.contentView).subviews) {
                    [subview removeFromSuperview];
                }
            }
            
            
            hlcell.textLabel.numberOfLines = 2;
            
            hlcell.textLabel.text = [departmentArr[indexPath.row] valueForKey:@"primaryDepartment"];
            hlcell.textLabel.font =  [UIFont fontWithName:@"Ariel Rounded MT BOld" size:18];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
            
        }
        @catch (NSException *exception) {
            
        }
        
        
    }
    
    
    else if (tableView == brandTbl) {
        @try {
            static NSString *CellIdentifier = @"Cell";
            tableView.separatorColor = [UIColor blackColor];

            UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (hlcell == nil) {
                hlcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                hlcell.frame = CGRectZero;
            }
            if ((hlcell.contentView).subviews){
                for (UIView *subview in (hlcell.contentView).subviews) {
                    [subview removeFromSuperview];
                }
            }
            
            
            hlcell.textLabel.numberOfLines = 2;
            

            hlcell.textLabel.text = [brandListArr[indexPath.row] valueForKey:@"bDescription"];
            
            hlcell.textLabel.font =  [UIFont fontWithName:@"Ariel Rounded MT BOld" size:18];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
            
        }
        
        @catch (NSException *exception) {
            
        }
    }
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (_soundFileObject);
    
    if (tableView == viewWalkOutTbl) {
        
        @try {
            
            NSDictionary *detailsDic = walkoutLIstArr[indexPath.row];
            
            NSString *walkout = [detailsDic valueForKey:@"slno"];
            self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
            
            WalkoutDetails *viewController = [[WalkoutDetails alloc]init];
            viewController.walkoutID = walkout;
            [self.navigationController pushViewController:viewController animated:YES];
            //
        }
        @catch (NSException *exception) {
            
            NSLog(@"%@",exception);
        }
        
    }
    else if (tableView == deprtmntTbl) {
        
        departmentFld.text = [departmentArr[indexPath.row] valueForKey:@"primaryDepartment"];
        [catPopOver dismissPopoverAnimated:YES];
        
        startIndexint_ = 0;
        walkoutLIstArr = [NSMutableArray new];
        [self getCustomerWalkout:totalNoOfRecords];
        
        
        
    }
    
    else if (tableView == brandTbl) {
        
        [catPopOver dismissPopoverAnimated:YES];
        
        brandFld.text = [brandListArr[indexPath.row] valueForKey:@"bDescription"];
        
        startIndexint_ = 0;
        
        walkoutLIstArr = [NSMutableArray new];
        [self getCustomerWalkout:totalNoOfRecords];
    }
    
    
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if(tableView == viewWalkOutTbl){
        
        @try {
            
            
            if((indexPath.row == (walkoutLIstArr.count - 1))  && (walkoutLIstArr.count < totalNoOfRecords)){
                [HUD setHidden:NO];
                startIndexint_ = startIndexint_ + 10;
                [self getCustomerWalkout:totalNoOfRecords];
                [viewWalkOutTbl reloadData];
                
            }
            
        } @catch (NSException *exception) {
            NSLog(@"-----------exception in servicecall-------------%@",exception);
            [HUD setHidden:YES];
        }
    }
    
    
}
-(void)backAction  {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)goToHome {
    
    [self backAction];
}
-(void)homeButonClicked {
    
    OmniHomePage *home = [[OmniHomePage alloc]init];
    [self.navigationController pushViewController:home animated:YES];
    
    
}



@end
//    viewWalkOutTbl.frame = CGRectMake( sNoLbl.frame.origin.x, sNoLbl.frame.origin.y+50,sNoLbl.frame.origin.x+walkoutRsn.frame.origin.x+walkoutRsn.frame.size.width-10, newButton.frame.origin.y - (sNoLbl.frame.origin.y + sNoLbl.frame.size.height +20));
