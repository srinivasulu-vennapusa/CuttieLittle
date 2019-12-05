//
//  SalemenCommissionReport.m
//  OmniRetailer

//  Created by Bhargav.v on 9/18/17.


#import "SalemenCommissionReport.h"
#import "RequestHeader.h"
#import "OmniHomePage.h"
//#import "SalesReportsSvc.h"
#import "SalesServiceSvc.h"


@interface SalemenCommissionReport ()

@end

@implementation SalemenCommissionReport

@synthesize soundFileURLRef,soundFileObject;


/**
 * @description  One of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date         09/18/2017
 * @method       viewDidLoad
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //reading the DeviceVersion....
    version = [UIDevice currentDevice].systemVersion.floatValue;
    
    //here we are  reading the Device Orientaion....
    currentOrientation = [UIDevice currentDevice].orientation;
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource:@"tap" withExtension:@"aif"];
    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    //setting the backGroundColor to view....
    self.view.backgroundColor = [UIColor blackColor];
    
    //ProgressBar creation...
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    
    //Show the HUD
   
    [HUD show:YES];
    [HUD setHidden:NO];
    
    //Allocation of overrideReportview...
    
    salesmenReportView = [[UIView alloc]init];
    
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
    
    
    // Allocation of startDateTxt
    startDateTxt = [[CustomTextField alloc] init];
    startDateTxt.delegate = self;
    startDateTxt.userInteractionEnabled  = NO;
    startDateTxt.placeholder = NSLocalizedString(@"start_date",nil);
    [startDateTxt awakeFromNib];
    
    // Allocation of endDateTxt
    endDateTxt = [[CustomTextField alloc] init];
    endDateTxt.delegate = self;
    endDateTxt.userInteractionEnabled  = NO;
    endDateTxt.placeholder = NSLocalizedString(@"end_date",nil);
    [endDateTxt awakeFromNib];
    
    // Allocation of endDateTxt
    locationTxt = [[CustomTextField alloc] init];
    locationTxt.delegate = self;
    locationTxt.userInteractionEnabled  = NO;
    locationTxt.text = presentLocation;
    locationTxt.placeholder = NSLocalizedString(@"location",nil);
    [locationTxt awakeFromNib];
    
    counterTxt = [[CustomTextField alloc] init];
    counterTxt.delegate = self;
    counterTxt.userInteractionEnabled  = NO;
    counterTxt.placeholder = NSLocalizedString(@"counter",nil);
    [counterTxt awakeFromNib];
    
    // Allocation of endDateTxt
    salesperonTxt = [[CustomTextField alloc] init];
    salesperonTxt.delegate = self;
    salesperonTxt.userInteractionEnabled  = NO;
    salesperonTxt.placeholder = NSLocalizedString(@"Sales Person",nil);
    [salesperonTxt awakeFromNib];
    
    UIImage  * startDteImg;
    UIImage  * dropDown_img;
    UIButton * startDteBtn;
    UIButton * endDteBtn;
    UIButton * salesPersonBtn;
    UIButton * counterBtn;
    
    //Allocation of startDteImg
    startDteImg  = [UIImage imageNamed:@"Calandar_Icon.png"];
    
    //Allocation of dropDown_img
    dropDown_img  = [UIImage imageNamed:@"arrow_1.png"];

    
    //Allocation of startDteBtn
    startDteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startDteBtn setBackgroundImage:startDteImg forState:UIControlStateNormal];
    [startDteBtn addTarget:self
                    action:@selector(DateButtonPressed:) forControlEvents:UIControlEventTouchDown];
    
    //Allocation of endDteBtn
    endDteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [endDteBtn setBackgroundImage:startDteImg forState:UIControlStateNormal];
    [endDteBtn addTarget:self
                  action:@selector(DateButtonPressed:) forControlEvents:UIControlEventTouchDown];
    
    //allocation of SalesPersonBtn
    salesPersonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [salesPersonBtn setBackgroundImage:dropDown_img forState:UIControlStateNormal];
    [salesPersonBtn addTarget:self
                  action:@selector(showSalesPersonID:) forControlEvents:UIControlEventTouchDown];
    
    //allocation of SalesPersonBtn
    counterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [counterBtn setBackgroundImage:dropDown_img forState:UIControlStateNormal];
    [counterBtn addTarget:self
                   action:@selector(showCounterList:) forControlEvents:UIControlEventTouchDown];
    
    
    //used for identification propouse....
    startDteBtn.tag = 2;
    endDteBtn.tag = 4;
   
    //Allocation Of UIScrollView...
    salemenReportScrollView = [[UIScrollView alloc]init];
//salemenReportScrollView.backgroundColor = [UIColor greenColor];
    
    
    // allocation Of CustomLabels...
    
    snoLbl = [[CustomLabel alloc] init];
    [snoLbl awakeFromNib];
    
    salesmanNameLbl = [[CustomLabel alloc] init];
    [salesmanNameLbl awakeFromNib];
    
    salesmenIdLbl = [[CustomLabel alloc] init];
    [salesmenIdLbl awakeFromNib];
    
    bussinessDateLbl = [[CustomLabel alloc] init];
    [bussinessDateLbl awakeFromNib];
    
    shiftIdLbl = [[CustomLabel alloc] init];
    [shiftIdLbl awakeFromNib];
    
    counterIdLbl = [[CustomLabel alloc] init];
    [counterIdLbl awakeFromNib];
    
    transactionCountLbl = [[CustomLabel alloc] init];
    [transactionCountLbl awakeFromNib];
    
    quantityLbl = [[CustomLabel alloc] init];
    [quantityLbl awakeFromNib];
    
    amountLbl = [[CustomLabel alloc] init];
    [amountLbl awakeFromNib];
    
    averagQtyTxnLbl = [[CustomLabel alloc] init];
    [averagQtyTxnLbl awakeFromNib];
    
    averageAmountTxnLbl = [[CustomLabel alloc] init];
    [averageAmountTxnLbl awakeFromNib];
    
    //Allocation of UITableView...
    
    /** Create TableView */
    salesmenReportTbl = [[UITableView alloc]init];
    salesmenReportTbl.backgroundColor = [UIColor blackColor];
    salesmenReportTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    salesmenReportTbl.dataSource = self;
    salesmenReportTbl.delegate = self;
    salesmenReportTbl.bounces = TRUE;
    salesmenReportTbl.separatorColor = [UIColor clearColor];
    
    //sectionTbl creation...
    salesPersonIdTbl = [[UITableView alloc] init];
    salesPersonIdTbl.layer.borderWidth = 1.0;
    salesPersonIdTbl.layer.cornerRadius = 4.0;
    salesPersonIdTbl.layer.borderColor = [UIColor blackColor].CGColor;
    salesPersonIdTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    salesPersonIdTbl.dataSource = self;
    salesPersonIdTbl.delegate = self;

    //sectionTbl creation...
    counterIDTbl = [[UITableView alloc] init];
    counterIDTbl.layer.borderWidth = 1.0;
    counterIDTbl.layer.cornerRadius = 4.0;
    counterIDTbl.layer.borderColor = [UIColor blackColor].CGColor;
    counterIDTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    counterIDTbl.dataSource = self;
    counterIDTbl.delegate = self;
    
    //creation of GO Buttton:
    
    goButton = [[UIButton alloc] init] ;
    goButton.backgroundColor = [UIColor grayColor];
    goButton.layer.masksToBounds = YES;
    [goButton addTarget:self action:@selector(goButtonPressed:) forControlEvents:UIControlEventTouchDown];
    goButton.userInteractionEnabled = YES;
    goButton.layer.cornerRadius = 6.0f;
    goButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
    goButton.tag = 2;

    UIButton * clearBtn;
    
    //Allocation of searchBtn
    searchBtn = [[UIButton alloc] init];
    [searchBtn addTarget:self
                  action:@selector(searchTheProducts:) forControlEvents:UIControlEventTouchDown];
    searchBtn.layer.cornerRadius = 3.0f;
    searchBtn.backgroundColor = [UIColor grayColor];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchBtn.tag = 2;
    
    //Allocation of clearBtn
    clearBtn = [[UIButton alloc] init];
    [clearBtn addTarget:self action:@selector(clearAllFilterInSearch:) forControlEvents:UIControlEventTouchDown];
    clearBtn.layer.cornerRadius = 3.0f;
    clearBtn.backgroundColor = [UIColor grayColor];
    [clearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //Allocation of UIView....
    
    totalsalesmenReportView = [[UIView alloc]init];
    totalsalesmenReportView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
    totalsalesmenReportView.layer.borderWidth =3.0f;
    
    UILabel * totalQtyLbl;
    UILabel * totalAmountLbl;
    UILabel * totalTxnLbl;
    
    totalQtyLbl = [[UILabel alloc] init];
    totalQtyLbl.font = [UIFont systemFontOfSize:18.0f];
    totalQtyLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
    totalQtyLbl.layer.cornerRadius = 20.0f;
    totalQtyLbl.layer.masksToBounds = YES;
    totalQtyLbl.textAlignment = NSTextAlignmentLeft;
    
    totalAmountLbl = [[UILabel alloc] init];
    totalAmountLbl.font = [UIFont systemFontOfSize:18.0f];
    totalAmountLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
    totalAmountLbl.layer.cornerRadius = 20.0f;
    totalAmountLbl.layer.masksToBounds = YES;
    totalAmountLbl.textAlignment = NSTextAlignmentLeft;
    
    totalTxnLbl = [[UILabel alloc] init];
    totalTxnLbl.font = [UIFont systemFontOfSize:18.0f];
    totalTxnLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
    totalTxnLbl.layer.cornerRadius = 20.0f;
    totalTxnLbl.layer.masksToBounds = YES;
    totalTxnLbl.textAlignment = NSTextAlignmentLeft;
    
    
    totalQtyValueLbl = [[UILabel alloc] init];
    totalQtyValueLbl.font = [UIFont systemFontOfSize:20.0f];
    totalQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
    totalQtyValueLbl.layer.cornerRadius = 20.0f;
    totalQtyValueLbl.layer.masksToBounds = YES;
    

    totalAmtValueLbl = [[UILabel alloc] init];
    totalAmtValueLbl.font = [UIFont systemFontOfSize:20.0f];
    totalAmtValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
    totalAmtValueLbl.layer.cornerRadius = 20.0f;
    totalAmtValueLbl.layer.masksToBounds = YES;
    
    totalTxnValueLbl = [[UILabel alloc] init];
    totalTxnValueLbl.font = [UIFont systemFontOfSize:20.0f];
    totalTxnValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
    totalTxnValueLbl.layer.cornerRadius = 20.0f;
    totalTxnValueLbl.layer.masksToBounds = YES;

    //Setting Intial Value as Zero...
    totalQtyValueLbl.text = @"0.0";
    totalAmtValueLbl.text = @"0.0";
    totalTxnValueLbl.text = @"0.0";

    //setting alignment for the  calculate value labels...
    
    totalQtyValueLbl.textAlignment = NSTextAlignmentRight;
    totalAmtValueLbl.textAlignment = NSTextAlignmentRight;
    totalTxnValueLbl.textAlignment = NSTextAlignmentRight;
    
    
    @try {
        
        //setting the titleName for the Page....
        
        self.titleLabel.text = NSLocalizedString(@"omni_retailer",nil);
        
        //setting the HUD name..
        HUD.labelText = NSLocalizedString(@"please_wait..",nil);
        
        //calss Name for the headerNameLbl...
        headerNameLbl.text = NSLocalizedString(@"salesmen_commission",nil);
        
        snoLbl.text = NSLocalizedString(@"S_NO",nil);
        salesmanNameLbl.text = NSLocalizedString(@"salesman_name",nil);
        salesmenIdLbl.text = NSLocalizedString(@"salesman_id",nil);
        bussinessDateLbl.text = NSLocalizedString(@"business_date",nil);
        shiftIdLbl.text = NSLocalizedString(@"shift_Id",nil);
        counterIdLbl.text = NSLocalizedString(@"counter_id",nil);

        transactionCountLbl.text = NSLocalizedString(@"transaction_count",nil);
        quantityLbl.text = NSLocalizedString(@"quantity",nil);
        amountLbl.text = NSLocalizedString(@"amount",nil);
        averagQtyTxnLbl.text = NSLocalizedString(@"averageQty/txn",nil);
        averageAmountTxnLbl.text = NSLocalizedString(@"average_amount/txn",nil);
        
        [goButton setTitle:NSLocalizedString(@"go",nil) forState:UIControlStateNormal];
       
        // setting title label text of the UIButton's....
        [searchBtn setTitle:NSLocalizedString(@"search", nil) forState:UIControlStateNormal];
        [clearBtn setTitle:NSLocalizedString(@"clear", nil) forState:UIControlStateNormal];

        
        totalQtyLbl.text = NSLocalizedString(@"total_Qty",nil);
        totalAmountLbl.text = NSLocalizedString(@"total_amt:",nil);
        totalTxnLbl.text = NSLocalizedString(@"total_txn:",nil);


    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
        }
        else{
        }
        //setting for the overrideReportview....
        salesmenReportView.frame = CGRectMake(2,70,self.view.frame.size.width-4,self.view.frame.size.height-80);
        //seting frame for headerNameLbl....
        headerNameLbl.frame = CGRectMake(0,0,salesmenReportView.frame.size.width,45);
        
        float textFieldWidth = 160;
        float textFieldHeight = 40;
        float horizontalGap = 20;
        float labelHeight = 40;

        
        counterTxt.frame = CGRectMake(salesmenReportView.frame.origin.x+10,headerNameLbl.frame.origin.y+headerNameLbl.frame.size.height+20,textFieldWidth,textFieldHeight);
        
        salesperonTxt.frame = CGRectMake(counterTxt.frame.origin.x,counterTxt.frame.origin.y+counterTxt.frame.size.height+20,textFieldWidth,textFieldHeight);
        
        startDateTxt.frame = CGRectMake(counterTxt.frame.origin.x+counterTxt.frame.size.width+horizontalGap,counterTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        
        endDateTxt.frame = CGRectMake(startDateTxt.frame.origin.x,salesperonTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        
        locationTxt.frame = CGRectMake(startDateTxt.frame.origin.x+startDateTxt.frame.size.width+horizontalGap,startDateTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        locationTxt.hidden = YES;
        
        //Frame for the startDteBtn...
        startDteBtn.frame = CGRectMake((startDateTxt.frame.origin.x+startDateTxt.frame.size.width-40), startDateTxt.frame.origin.y+2, 35, 30);
        
        //Frame for the endDateBtn...
        endDteBtn.frame = CGRectMake((endDateTxt.frame.origin.x+endDateTxt.frame.size.width-40), endDateTxt.frame.origin.y+2, 35, 30);
        
        //Frame for the subDepartmentBtn
        salesPersonBtn.frame = CGRectMake((salesperonTxt.frame.origin.x+salesperonTxt.frame.size.width-45), salesperonTxt.frame.origin.y-8,55,60);
        
        counterBtn.frame = CGRectMake((counterTxt.frame.origin.x+counterTxt.frame.size.width-45),counterTxt.frame.origin.y-8,55,60);

        
        searchBtn.frame = CGRectMake((startDateTxt.frame.origin.x+startDateTxt.frame.size.width+horizontalGap), locationTxt.frame.origin.y,140,45);
        
        clearBtn.frame = CGRectMake(searchBtn.frame.origin.x,endDateTxt.frame.origin.y,searchBtn.frame.size.width,searchBtn.frame.size.height);
        
        
//        //Frame for the GO Button...
//        goButton.frame  = CGRectMake(startDateTxt.frame.origin.x+startDateTxt.frame.size.width+horizontalGap,startDateTxt.frame.origin.y,80,40);

        //Frame for the overrideScrollView...
        salemenReportScrollView.frame = CGRectMake(10,endDateTxt.frame.origin.y+endDateTxt.frame.size.height+20,salesmenReportView.frame.size.width+100,410);
        
        snoLbl.frame = CGRectMake(0, 0, 50,labelHeight);
        
        salesmanNameLbl.frame = CGRectMake(snoLbl.frame.origin.x+snoLbl.frame.size.width+2,snoLbl.frame.origin.y,120,labelHeight);
       
        salesmenIdLbl.frame = CGRectMake(salesmanNameLbl.frame.origin.x+salesmanNameLbl.frame.size.width+2,snoLbl.frame.origin.y,100,labelHeight);

        bussinessDateLbl.frame = CGRectMake(salesmenIdLbl.frame.origin.x+salesmenIdLbl.frame.size.width+2,snoLbl.frame.origin.y,120,labelHeight);
        
        shiftIdLbl.frame = CGRectMake(bussinessDateLbl.frame.origin.x+bussinessDateLbl.frame.size.width+2,snoLbl.frame.origin.y,70,labelHeight);
        
        counterIdLbl.frame = CGRectMake(shiftIdLbl.frame.origin.x+shiftIdLbl.frame.size.width+2,snoLbl.frame.origin.y,80,labelHeight);

        transactionCountLbl.frame = CGRectMake(counterIdLbl.frame.origin.x+counterIdLbl.frame.size.width+2,snoLbl.frame.origin.y,80,labelHeight);
        
        quantityLbl.frame = CGRectMake(transactionCountLbl.frame.origin.x+transactionCountLbl.frame.size.width+2,snoLbl.frame.origin.y,80,labelHeight);

        amountLbl.frame = CGRectMake(quantityLbl.frame.origin.x+quantityLbl.frame.size.width+2,snoLbl.frame.origin.y,70,labelHeight);

        averagQtyTxnLbl.frame = CGRectMake(amountLbl.frame.origin.x+amountLbl.frame.size.width+2,snoLbl.frame.origin.y,100,labelHeight);
        
        averageAmountTxnLbl.frame = CGRectMake(averagQtyTxnLbl.frame.origin.x+averagQtyTxnLbl.frame.size.width+2,snoLbl.frame.origin.y,120,labelHeight);

        
        //frame for the UITableView
        salesmenReportTbl.frame = CGRectMake(snoLbl.frame.origin.x,snoLbl.frame.origin.y+snoLbl.frame.size.height+5,averageAmountTxnLbl.frame.origin.x+averageAmountTxnLbl.frame.size.width-(snoLbl.frame.origin.x),salemenReportScrollView.frame.origin.y+salemenReportScrollView.frame.size.height);

        //Frame for the UIView...
        totalsalesmenReportView.frame = CGRectMake(salesmenReportView.frame.size.width-300, salemenReportScrollView.frame.origin.y+salemenReportScrollView.frame.size.height+10,300,90);
        
        // Frames for the UILabels under the totalInventoryView....
        
        totalQtyLbl.frame = CGRectMake(5,0,180,40);
        
        totalAmountLbl.frame = CGRectMake(totalQtyLbl.frame.origin.x,totalQtyLbl.frame.origin.y+totalQtyLbl.frame.size.height-15,totalQtyLbl.frame.size.width,totalQtyLbl.frame.size.height);

        totalTxnLbl.frame = CGRectMake(totalQtyLbl.frame.origin.x,totalAmountLbl.frame.origin.y+totalAmountLbl.frame.size.height-15,totalQtyLbl.frame.size.width,totalQtyLbl.frame.size.height);
        
        totalQtyValueLbl.frame = CGRectMake(totalQtyLbl.frame.origin.x+totalQtyLbl.frame.size.width-10,totalQtyLbl.frame.origin.y,120,totalQtyLbl.frame.size.height);
        
        totalAmtValueLbl.frame = CGRectMake(totalQtyValueLbl.frame.origin.x,totalAmountLbl.frame.origin.y,120,totalQtyLbl.frame.size.height);
        
        totalTxnValueLbl.frame = CGRectMake(totalQtyValueLbl.frame.origin.x,totalTxnLbl.frame.origin.y,120,totalQtyLbl.frame.size.height);
    }
    
    [salesmenReportView addSubview:headerNameLbl];
    [salesmenReportView addSubview:locationTxt];
    [salesmenReportView addSubview:salesperonTxt];
    [salesmenReportView addSubview:startDateTxt];
    [salesmenReportView addSubview:endDateTxt];
    [salesmenReportView addSubview:locationTxt];
    [salesmenReportView addSubview:counterTxt];

    
    [salesmenReportView addSubview:startDteBtn];
    [salesmenReportView addSubview:endDteBtn];
    [salesmenReportView addSubview:salesPersonBtn];
    [salesmenReportView addSubview:counterBtn];

    [salesmenReportView addSubview:searchBtn];
    [salesmenReportView addSubview:clearBtn];
    
//    [salesmenReportView addSubview:goButton];
    
    [salesmenReportView addSubview:salemenReportScrollView];
    [salemenReportScrollView addSubview:snoLbl];
    [salemenReportScrollView addSubview:salesmanNameLbl];
    [salemenReportScrollView addSubview:salesmenIdLbl];
    [salemenReportScrollView addSubview:bussinessDateLbl];
    [salemenReportScrollView addSubview:shiftIdLbl];
    [salemenReportScrollView addSubview:counterIdLbl];

    [salemenReportScrollView addSubview:transactionCountLbl];
    [salemenReportScrollView addSubview:quantityLbl];
    [salemenReportScrollView addSubview:amountLbl];
    [salemenReportScrollView addSubview:averagQtyTxnLbl];
    [salemenReportScrollView addSubview:averageAmountTxnLbl];
    
    [salemenReportScrollView addSubview:salesmenReportTbl];
    
    [salesmenReportView addSubview:totalsalesmenReportView];
    
    [totalsalesmenReportView addSubview:totalQtyLbl];
    [totalsalesmenReportView addSubview:totalAmountLbl];
    [totalsalesmenReportView addSubview:totalTxnLbl];

    [totalsalesmenReportView addSubview:totalQtyValueLbl];
    [totalsalesmenReportView addSubview:totalAmtValueLbl];
    [totalsalesmenReportView addSubview:totalTxnValueLbl];

    //Adding categoryWiseReportView For the self.view
    [self.view addSubview:salesmenReportView];
    
    
    @try {
        [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:15.0f cornerRadius:0];
        headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
        searchBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        clearBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        
        //goButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];

    } @catch (NSException * exception) {
        
    }
}

/**
 * @description  EXecuted after the VeiwDidLoad Execution
 * @date         18/09/2017..
 * @method       viewDidAppear
 * @author       Bhargav.v
 * @param        BOOL
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    @try {
        startIndexInt = 0;
        
        // totalNumberOfReports = 0;
        
        salesManCommissionArr = [NSMutableArray new];
       
        [self getSalesMenReport];
        
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
}



/**
 * @description
 * @date         18/09/2017
 * @method       didReceiveMemoryWarning
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 * @description  intialization of this method is to send the Request String...
 * @date         18/09/2017
 * @method
 * @author       Bhargav.v
 * @param        <#param#>
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)getSalesMenReport {
    
    @try {
        
        [HUD setHidden:NO];
        
        if( salesManCommissionArr == nil && startIndexInt == 0){
            
            salesManCommissionArr = [NSMutableArray new];
        }
        else if(startIndexInt == 0 &&  salesManCommissionArr.count) {
            
            [salesManCommissionArr removeAllObjects];
        }
        
        NSString * startDteStr = startDateTxt.text;
        
        if((startDateTxt.text).length > 0)
            startDteStr =  [NSString stringWithFormat:@"%@%@",startDateTxt.text,@" 00:00:00"];
        
        NSString *  endDteStr  = endDateTxt.text;
        
        if ((endDateTxt.text).length> 0) {
            endDteStr = [NSString stringWithFormat:@"%@%@",endDateTxt.text,@" 00:00:00"];
        }
        
        NSString * counterIdStr = counterTxt.text;
        
        if(counterIDTbl.tag == 0)
            counterIdStr = @"";
       if (salesPersonIdTbl.tag == 0 || (salesperonTxt.text).length == 0)
           salesPersonIdStr = @"";
        
        NSMutableDictionary * salesmenReportDic = [[NSMutableDictionary alloc] init];
        
        [salesmenReportDic setValue:[NSString stringWithFormat:@"%d",startIndexInt] forKey:START_INDEX];
        [salesmenReportDic setValue:[NSString stringWithFormat:@"%d",10] forKey:kRequiredRecords];
        [salesmenReportDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [salesmenReportDic setValue:[NSNumber numberWithBool:false] forKey:SAVE_REORT_FLAG];
        [salesmenReportDic setValue:[NSNumber numberWithBool:false] forKey:IS_SAVE_REPORT];
        [salesmenReportDic setValue:presentLocation forKey:STORE_LOCATION];
        [salesmenReportDic setValue:@"" forKey:SEARCH_CRITERIA_STR];
        [salesmenReportDic setValue:startDteStr forKey:kStartDate];
        
        [salesmenReportDic setValue:counterIdStr forKey:COUNTER];
        [salesmenReportDic setValue:endDteStr forKey:END_DATE];
        [salesmenReportDic setValue:salesPersonIdStr forKey:CASHIER_ID];

        [salesmenReportDic setValue:@"" forKey:kCategoryName];
        [salesmenReportDic setValue:@"" forKey:kSubCategory];
        [salesmenReportDic setValue:@"" forKey:kItemDept];
        [salesmenReportDic setValue:@"" forKey:ZONE_Id];
        [salesmenReportDic setValue:@"" forKey:kBrand];
        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:salesmenReportDic options:0 error:&err];
        NSString * salemenReportDicJsonStr   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        //NSLog(@"%@--json product Categories String--",overrideSalesJsonStr);
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.salesServiceDelegate = self;
        [webServiceController getSalesMenCommission:salemenReportDicJsonStr];
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"message", nil),@"\n",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @finally {
        
    }
    
}


/**
 * @description  we are Storing the Data which is retrieved from DataBase...
 * @date         18/09/2017
 * @method       getSalesMenCommissionReportSuccessResponse
 * @author       Bhargav.v
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)getSalesMenCommissionReportSuccessResponse:(NSDictionary *)successDictionary{
    @try {
        
        totalNumberOfReports= [[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:TOTAL_BILLS]  defaultReturn:@"0"] intValue];
        
        float qty = 0.0;
        float amount = 0.0;
        float transactions = 0.0;
        
        if(successDictionary.count){
            
            for(NSDictionary * salesmenDic in [successDictionary valueForKey:REPORT_LIST]){
                
                [salesManCommissionArr addObject:salesmenDic];
                
                qty  +=  [[self checkGivenValueIsNullOrNil:[salesmenDic valueForKey:QUANTITY] defaultReturn:@"0.00"]  floatValue];
                amount  +=  [[self checkGivenValueIsNullOrNil:[salesmenDic valueForKey:TOTAL_COST] defaultReturn:@"0.00"]  floatValue];
                transactions  +=  [[self checkGivenValueIsNullOrNil:[salesmenDic valueForKey:NO_OF_BILLS] defaultReturn:@"0.00"]  floatValue];
            }
        }

        totalQtyValueLbl.text  = [NSString stringWithFormat:@"%@%.2f",@"", qty];
        totalAmtValueLbl.text  = [NSString stringWithFormat:@"%@%.2f",@"", amount];
        totalTxnValueLbl.text  = [NSString stringWithFormat:@"%@%.2f",@"", transactions];
        
    } @catch (NSException * exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
        [salesmenReportTbl reloadData];
    }
}


/**
 * @description  Displaying the ErrorResponse if there is no Data available in the DataBase...
 * @date         18/09/2017
 * @method       getSalesMenCommissionReportErrorResponse
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getSalesMenCommissionReportErrorResponse:(NSString *)errorResponse{
    
    @try {
        
        if (startIndexInt == 0) {
            
            //Setting Intial Value as Zero...
            totalQtyValueLbl.text = @"0.0";
            totalAmtValueLbl.text = @"0.0";
            totalTxnValueLbl.text = @"0.0";
           
            [self displayAlertMessage:errorResponse horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height-150  msgType:NSLocalizedString(@"warning", nil) conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
        [salesmenReportTbl reloadData];
    }
}




/**
 * @description  here we are showing sales persons in drop down....
 * @date
 * @method       selectSalesPersonIds:
 * @author
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 22/06/2017....
 * @reason      added the comments and exception handling.... changed popUp display logic....  used common method to display popUp....  not completed....
 *
 */
// Commented by roja on 17/10/2019.. // reason :- selectSalesPersonIds method contains SOAP Service call .. so taken new method with same name(selectSalesPersonIds) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//-(void)selectSalesPersonIds {
//
//    //changed by Srinivasulu on 22/06/2017....
//
//
//    @try {
//
//        if(isOfflineService){
//
//            return;
//        }
//
//
//        //checking the array status and doing service call....
//        if( (employeeIdsArr == nil) && (!employeeIdsArr.count)){
//
//            // showing the HUD ..
//            [HUD setHidden:NO];
//
//            employeeIdsArr = [NSMutableArray new];
//            //checking for deals & offers...
//            EmployeesSoapBinding *custBindng =  [EmployeesSvc EmployeesSoapBinding] ;
//            EmployeesSvc_getEmployees *aParameters = [[EmployeesSvc_getEmployees alloc] init];
//
//            NSArray * loyaltyKeys = @[START_INDEX,LOCATION,REQUEST_HEADER];
//
//            NSArray * loyaltyObjects = @[@"-1",presentLocation,[RequestHeader getRequestHeader]];
//            NSDictionary *dictionary_req = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
//
//            NSError  * err_;
//            NSData   * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_req options:0 error:&err_];
//            NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//            aParameters.employeeDetails = loyaltyString;
//
//
//            EmployeesSoapBindingResponse * response = [custBindng getEmployeesUsingParameters:(EmployeesSvc_getEmployees *)aParameters];
//            NSArray *responseBodyParts = response.bodyParts;
//            for (id bodyPart in responseBodyParts) {
//                if ([bodyPart isKindOfClass:[EmployeesSvc_getEmployeesResponse class]]) {
//                    EmployeesSvc_getEmployeesResponse *body = (EmployeesSvc_getEmployeesResponse *)bodyPart;
//                    //                    printf("\nresponse=%s",[body.return_ UTF8String]);
//                    NSError *e;
//
//                    NSMutableDictionary * JSON1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                                  options: NSJSONReadingMutableContainers
//                                                                                    error: &e];
//
//                    NSDictionary * dictionary = [JSON1 valueForKey:RESPONSE_HEADER];
//
//
//                    @try {
//
//
//
//                        if ([[dictionary valueForKey:RESPONSE_CODE] intValue] == 0) {
//
//                            [employeeIdsArr addObject:@"All"];
//
//                            for (NSDictionary * employeeDic in [JSON1 valueForKey:kEmplyeesList]) {
//
//                                [employeeIdsArr addObject:employeeDic];
//                            }
//                        }
//
//
//                    } @catch (NSException *exception) {
//
//                    }
//                }
//            }
//        }
//
//    } @catch (NSException *exception) {
//
//        [HUD setHidden:YES];
//            }
//    @finally{
//
//    }
//}


//selectSalesPersonIds method changed by roja on 17/10/2019.. // reason : removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST
-(void)selectSalesPersonIds {
    
    //changed by Srinivasulu on 22/06/2017....
    @try {
        
        if(isOfflineService){
            return;
        }
        
        //checking the array status and doing service call....
        if( (employeeIdsArr == nil) && (!employeeIdsArr.count)){
            
            // showing the HUD ..
            [HUD setHidden:NO];
            employeeIdsArr = [NSMutableArray new];
            
            //checking for deals & offers...
            
            NSArray * loyaltyKeys = @[START_INDEX,LOCATION,REQUEST_HEADER];
            
            NSArray * loyaltyObjects = @[@"-1",presentLocation,[RequestHeader getRequestHeader]];
            NSDictionary *dictionary_req = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
            
            NSError  * err_;
            NSData   * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_req options:0 error:&err_];
            NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
            
            WebServiceController * services =  [[WebServiceController alloc] init];
            services.employeeServiceDelegate = self;
            [services getEmployeeDetails:loyaltyString];
            
        }
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
    }
    @finally{
        
    }
}

- (void)getEmployeeDetailsSucess:(NSDictionary *)successResponse{
    
    @try {
        NSLog(@"getEmployeeDetailsSucess in SalemenCommissionReport :%@",successResponse);

        [employeeIdsArr addObject:@"All"];
        for (NSDictionary * employeeDic in [successResponse valueForKey:kEmplyeesList]) {
            [employeeIdsArr addObject:employeeDic];
        }

    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}


- (void)getEmployeeDetailsFailure:(NSString *)successFailure{
    
    @try {
        NSLog(@"getEmployeeDetailsFailure in SalemenCommissionReport :%@",successFailure);
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}

/**
 * @description  getting the data from the Customer Service..
 * @date         24/08/2017
 * @method       getCounters
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

// Commented by roja on 17/10/2019.. // reason :- getCounters method contains SOAP Service call .. so taken new method with same name(getCounters) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//-(void)getCounters {
//
//    @try {
//
//        [HUD show: YES];
//        [HUD setHidden:NO];
//
//        couterIdArr = [NSMutableArray new];
//
//        NSArray *keys = @[REQUEST_HEADER,kStartIndex,kStoreLocation];
//        NSArray *objects = @[[RequestHeader getRequestHeader],@"-1",presentLocation];
//
//        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
//
//        NSError * err;
//        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
//        NSString * getCountersJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//        CountersServiceSoapBinding *salesBindng =  [CountersServiceSvc CountersServiceSoapBinding];
//        CountersServiceSvc_getCounters *aParameters =  [[CountersServiceSvc_getCounters alloc] init];
//
//
//        aParameters.counterDetails = getCountersJsonString;
//        CountersServiceSoapBindingResponse *response = [salesBindng getCountersUsingParameters:aParameters];
//
//        NSArray *responseBodyParts = response.bodyParts;
//
//        for (id bodyPart in responseBodyParts) {
//            if ([bodyPart isKindOfClass:[CountersServiceSvc_getCountersResponse class]]) {
//                CountersServiceSvc_getCountersResponse *body = (CountersServiceSvc_getCountersResponse *)bodyPart;
//
//                NSError *e;
//                NSDictionary * JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                      options: NSJSONReadingMutableContainers
//                                                                        error: &e];
//
//                if (![body.return_ isKindOfClass:[NSNull class]]) {
//
//                    [HUD setHidden:YES];
//
//                    [couterIdArr addObject:@"All"];
//
//                    for (NSDictionary * counters in [JSON valueForKey:@"counters"]) {
//
//                        if (![[counters valueForKey:@"counterName"] isKindOfClass:[NSNull class]]) {
//
//                            [couterIdArr addObject:[counters valueForKey:@"counterName"]];
//                        }
//                    }
//
//
//                }
//                else {
//                    [HUD setHidden:YES];
//                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Failed to get the reports" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                    [alert show];
//                }
//            }
//        }
//    }
//    @catch (NSException * exception) {
//
//    }
//}

//getCounters method changed by roja on 17/10/2019.. // reason : removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST
-(void)getCounters {
    
    @try {
        
        [HUD show: YES];
        [HUD setHidden:NO];
        
        couterIdArr = [NSMutableArray new];
        
        NSArray *keys = @[REQUEST_HEADER,kStartIndex,kStoreLocation];
        NSArray *objects = @[[RequestHeader getRequestHeader],@"-1",presentLocation];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * getCountersJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * services = [[WebServiceController alloc] init];
        services.counterServiceDelegate = self;
        [services getCounters:getCountersJsonString];

    }
    @catch (NSException * exception) {
        
    }
}

// added by Roja on 17/10/2019….
- (void)getCountersSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        
        [couterIdArr addObject:@"All"];
        
        for (NSDictionary * counters in [successDictionary valueForKey:@"counters"]) {
            
            if (![[counters valueForKey:@"counterName"] isKindOfClass:[NSNull class]]) {
                
                [couterIdArr addObject:[counters valueForKey:@"counterName"]];
            }
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
    
}

// added by Roja on 17/10/2019….
- (void)getCountersErrorResponse:(NSString *)errorString{
    
    @try {
        NSLog(@"getCountersErrorResponse in SalemenCommissionReport : %@",errorString);
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}

/**
 * @description  here we are showing sales persons in drop down....
 * @date
 * @method       populateEmployeesData
 * @author
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 
 */


-(void)showSalesPersonID:(UIButton*)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if (employeeIdsArr == nil) {
            
            [self selectSalesPersonIds];
        }
        [HUD setHidden:YES];
        
        if (! employeeIdsArr.count){
            
            NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        
        float tableHeight = employeeIdsArr.count * 45;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = employeeIdsArr.count * 33;
        
        if(employeeIdsArr.count > 5)
            tableHeight = (tableHeight/employeeIdsArr.count) * 5;
        
        [self showPopUpForTables:salesPersonIdTbl  popUpWidth:salesperonTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:salesperonTxt  showViewIn:salesmenReportView permittedArrowDirections:UIPopoverArrowDirectionUp];
        
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
}





/**
 * @description  showing the availiable  Shipment modes.......
 * @date         19/08/2017....
 * @method       showSectionList:
 * @author       Bhargav
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)showCounterList:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if (couterIdArr == nil) {
            
            [self getCounters];
            //            return;
        }
        [HUD setHidden:YES];
        
        if (! couterIdArr.count){
            
            NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"no_data_found", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        
        float tableHeight = couterIdArr.count * 45;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = couterIdArr.count * 33;
        
        if(couterIdArr.count > 5)
            tableHeight = (tableHeight/couterIdArr.count) * 5;
        
        [self showPopUpForTables:counterIDTbl  popUpWidth:counterTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:counterTxt  showViewIn:salesmenReportView permittedArrowDirections:UIPopoverArrowDirectionUp];
        
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
}

/**
 * @description  goButton is the method used to make service call through sending date strings for filteers...
 * @date         12/08/2017
 * @method       goButtonClicked
 * @author       Bhargav.v
 * @param        sender
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)searchTheProducts:(UIButton*)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        searchBtn.tag  = 4;
        
        if ((salesperonTxt.text).length == 0  && (startDateTxt.text).length == 0 && (endDateTxt.text).length == 0 && (counterTxt.text).length == 0 ) {
            
            float y_axis = self.view.frame.size.height-200;
            
            NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert",nil),@"\n",NSLocalizedString(@"Please select above fields before proceeding", nil)];
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:450 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        
        else
            [HUD setHidden:NO];
        startIndexInt = 0;
        salesManCommissionArr = [NSMutableArray new];
        [self getSalesMenReport];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}





/**
 * @description  here we are creating request string for creation of new SupplierQuotation.......
 * @date         31/03/2017
 * @method       clearAllFilterInSearch
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)clearAllFilterInSearch:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        searchBtn.tag  = 2;
        
        salesperonTxt.text = @"";
        startDateTxt.text   = @"";
        endDateTxt.text     = @"";
        counterTxt.text = @"";
        startIndexInt = 0;
        [self getSalesMenReport];
        
    } @catch (NSException * exception) {
        [HUD setHidden:YES];
        NSLog(@"--------exception in the dateWiseReportView.... in viewWillDisappear---------%@",exception);
        NSLog(@"----exception is------------%@",exception);
        
    } @finally {
        
    }
}

#pragma mark populate Calendar

/**
 * @description  To create picker frame and set the date inside the dueData textfield.
 * @date         07/08/2017
 * @method       DateButtonPressed
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(IBAction)DateButtonPressed:(UIButton*) sender {
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
            
            pickView.frame = CGRectMake(15,startDateTxt.frame.origin.y+startDateTxt.frame.size.height, 320, 320);
            
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
        [pickButton addTarget:self action:@selector(getDate:) forControlEvents:UIControlEventTouchUpInside];
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
                [popover presentPopoverFromRect:startDateTxt.frame inView:salesmenReportView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else
                [popover presentPopoverFromRect:endDateTxt.frame inView:salesmenReportView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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
        
        NSLog(@"----exception in the stockReceiptView in showCalenderInPopUp:----%@",exception);
        NSLog(@"------exception while creating the popUp in stockView------%@",exception);
        
    }
    
}



/**
 * @description  clear the date from textField and calling services.......
 * @date         07/08/2017
 * @method       clearDate:
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)clearDate:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    //    BOOL callServices = false;
    
    @try {
        
        [catPopOver dismissPopoverAnimated:YES];
        
        
        if(sender.tag == 2){
            if((startDateTxt.text).length)
                //                callServices = true;
                
                startDateTxt.text = @"";
        }
        else{
            if((endDateTxt.text).length)
                //                callServices = true;
                
                endDateTxt.text = @"";
        }
        
        //                if(callServices){
        //                    [HUD setHidden:NO];
        //
        //                    requestStartNumber = 0;
        //                    totalNoOfStockRequests = 0;
        //                    [self callingGetPurchaseStockReturns];
        //                }
        
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        NSLog(@"---- exception in StockReceiptView -- in  -- clearDate() ----");
        NSLog(@"---- exception is ----%@",exception);
        
    } @finally {
        
    }
}

/**
 * @description   Handle getDate method for pick date from calendar.
 * @date         07/08/2017
 * @method       getDate
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(IBAction)getDate:(UIButton*)sender
{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        [catPopOver dismissPopoverAnimated:YES];
        
        //Date Formate Setting...
        NSDateFormatter * requiredDateFormat = [[NSDateFormatter alloc] init];
        //        [requiredDateFormat setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        requiredDateFormat.dateFormat = @"dd/MM/yyyy";
        dateString = [requiredDateFormat stringFromDate:myPicker.date];
        
        
        NSDate * selectedDateString = [requiredDateFormat dateFromString:[requiredDateFormat stringFromDate:myPicker.date]];
        
        NSDate * existingDateString;
        /*z;
         UITextField *endDateTxt;*/
        
        if(sender.tag == 2){
            if ((startDateTxt.text).length != 0 && ( ![startDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:startDateTxt.text ];
                
                if ([existingDateString compare:selectedDateString]== NSOrderedAscending) {
                    
                    startDateTxt.text = @"";
                    
                    [self displayAlertMessage:NSLocalizedString(@"start_date_should_be_earlier_than_endDate", nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
                    
                    return;
                }
            }
            startDateTxt.text = dateString;
        }
        else{
            
            if ((endDateTxt.text).length != 0 && ( ![endDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:endDateTxt.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    endDateTxt.text = @"";
                    
                    [self displayAlertMessage:NSLocalizedString(@"closed_date_should_not_be_earlier_than_created_date", nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
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


/**
 * @description  goButton is the method used to make service call through sending date strings for filteers...
 * @date         12/08/2017
 * @method       goButtonClicked
 * @author       Bhargav.v
 * @param        sender
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)goButtonPressed:(UIButton*)sender {
    
    startIndexInt = 0;
    salesManCommissionArr = [NSMutableArray new];
    [self getSalesMenReport];
}







/** Table Implementation */

#pragma mark Table view methods

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == salesmenReportTbl) {
        if (salesManCommissionArr.count)
            
            return salesManCommissionArr.count;
        else
            return 1;
    }
    else if(tableView == salesPersonIdTbl){
        return employeeIdsArr.count;
    }
    else if(tableView == counterIDTbl){
        return couterIdArr.count;
    }
    return 0;
}


//Customize HeightForRowAtIndexPath ...
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView == salesmenReportTbl || salesPersonIdTbl ||counterIDTbl ){
        
        return 45;
        
    }
    
    
    return 0.0;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView == salesmenReportTbl){
        
        
        static NSString * hlCellID = @"hlCellID";
        
        UITableViewCell * hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
        
        if ((hlcell.contentView).subviews){
            
            for (UIView *subview in (hlcell.contentView).subviews) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
        }
        tableView.separatorColor = [UIColor clearColor];
        
        
        @try {
            
            UILabel * sno_Lbl;
            UILabel * salesmanName_Lbl;
            UILabel * salesManId_Lbl;
            UILabel * bussinessDate_Lbl;
            UILabel * shiftID_Lbl;
            UILabel * counterId_Lbl;
            UILabel * transactionCount_Lbl;
            UILabel * quantity_Lbl;
            UILabel * amount_Lbl;
            UILabel * avgQtyTxn_Lbl;
            UILabel * avgAmountTxn_Lbl;
            
            /*Creation of UILabels used in this cell*/
            sno_Lbl = [[UILabel alloc] init];
            sno_Lbl.backgroundColor = [UIColor clearColor];
            sno_Lbl.textAlignment = NSTextAlignmentCenter;
            sno_Lbl.numberOfLines = 1;
            sno_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            salesmanName_Lbl = [[UILabel alloc] init];
            salesmanName_Lbl.backgroundColor = [UIColor clearColor];
            salesmanName_Lbl.textAlignment = NSTextAlignmentCenter;
            salesmanName_Lbl.numberOfLines = 1;
            salesmanName_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            salesManId_Lbl = [[UILabel alloc] init];
            salesManId_Lbl.backgroundColor = [UIColor clearColor];
            salesManId_Lbl.textAlignment = NSTextAlignmentCenter;
            salesManId_Lbl.numberOfLines = 1;
            salesManId_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            bussinessDate_Lbl = [[UILabel alloc] init];
            bussinessDate_Lbl.backgroundColor = [UIColor clearColor];
            bussinessDate_Lbl.textAlignment = NSTextAlignmentCenter;
            bussinessDate_Lbl.numberOfLines = 1;
            bussinessDate_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            shiftID_Lbl = [[UILabel alloc] init];
            shiftID_Lbl.backgroundColor = [UIColor clearColor];
            shiftID_Lbl.textAlignment = NSTextAlignmentCenter;
            shiftID_Lbl.numberOfLines = 1;
            shiftID_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            counterId_Lbl = [[UILabel alloc] init];
            counterId_Lbl.backgroundColor = [UIColor clearColor];
            counterId_Lbl.textAlignment = NSTextAlignmentCenter;
            counterId_Lbl.numberOfLines = 1;
            counterId_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            transactionCount_Lbl = [[UILabel alloc] init];
            transactionCount_Lbl.backgroundColor = [UIColor clearColor];
            transactionCount_Lbl.textAlignment = NSTextAlignmentCenter;
            transactionCount_Lbl.numberOfLines = 1;
            transactionCount_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            quantity_Lbl = [[UILabel alloc] init];
            quantity_Lbl.backgroundColor = [UIColor clearColor];
            quantity_Lbl.textAlignment = NSTextAlignmentCenter;
            quantity_Lbl.numberOfLines = 1;
            quantity_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            
            amount_Lbl = [[UILabel alloc] init];
            amount_Lbl.backgroundColor = [UIColor clearColor];
            amount_Lbl.textAlignment = NSTextAlignmentCenter;
            amount_Lbl.numberOfLines = 1;
            amount_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            avgQtyTxn_Lbl = [[UILabel alloc] init];
            avgQtyTxn_Lbl.backgroundColor = [UIColor clearColor];
            avgQtyTxn_Lbl.textAlignment = NSTextAlignmentCenter;
            avgQtyTxn_Lbl.numberOfLines = 1;
            avgQtyTxn_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            avgAmountTxn_Lbl = [[UILabel alloc] init];
            avgAmountTxn_Lbl.backgroundColor = [UIColor clearColor];
            avgAmountTxn_Lbl.textAlignment = NSTextAlignmentCenter;
            avgAmountTxn_Lbl.numberOfLines = 1;
            avgAmountTxn_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            sno_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            salesmanName_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            salesManId_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            bussinessDate_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            shiftID_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            counterId_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            transactionCount_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            quantity_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            amount_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            avgQtyTxn_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            avgAmountTxn_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            
            [hlcell.contentView addSubview:sno_Lbl];
            [hlcell.contentView addSubview:salesmanName_Lbl];
            [hlcell.contentView addSubview:salesManId_Lbl];
            [hlcell.contentView addSubview:bussinessDate_Lbl];
            [hlcell.contentView addSubview:shiftID_Lbl];
            [hlcell.contentView addSubview:counterId_Lbl];
            [hlcell.contentView addSubview:transactionCount_Lbl];
            [hlcell.contentView addSubview:quantity_Lbl];
            [hlcell.contentView addSubview:amount_Lbl];
            [hlcell.contentView addSubview:avgQtyTxn_Lbl];
            [hlcell.contentView addSubview:avgAmountTxn_Lbl];
            
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                sno_Lbl.frame = CGRectMake(0,0,snoLbl.frame.size.width,hlcell.frame.size.height);
                
                salesmanName_Lbl.frame = CGRectMake(salesmanNameLbl.frame.origin.x,0,salesmanNameLbl.frame.size.width,hlcell.frame.size.height);
                
                salesManId_Lbl.frame = CGRectMake(salesmenIdLbl.frame.origin.x,0,salesmenIdLbl.frame.size.width,hlcell.frame.size.height);
                
                bussinessDate_Lbl.frame = CGRectMake(bussinessDateLbl.frame.origin.x,0,bussinessDateLbl.frame.size.width,hlcell.frame.size.height);
                
                shiftID_Lbl.frame = CGRectMake(shiftIdLbl.frame.origin.x,0,shiftIdLbl.frame.size.width,hlcell.frame.size.height);
                
                counterId_Lbl.frame = CGRectMake(counterIdLbl.frame.origin.x,0,counterIdLbl.frame.size.width,hlcell.frame.size.height);
                
                transactionCount_Lbl.frame = CGRectMake(transactionCountLbl.frame.origin.x,0,transactionCountLbl.frame.size.width,hlcell.frame.size.height);
                
                quantity_Lbl.frame = CGRectMake(quantityLbl.frame.origin.x,0,quantityLbl.frame.size.width,hlcell.frame.size.height);
                
                amount_Lbl.frame = CGRectMake(amountLbl.frame.origin.x,0,amountLbl.frame.size.width,hlcell.frame.size.height);
                
                avgQtyTxn_Lbl.frame = CGRectMake(averagQtyTxnLbl.frame.origin.x,0,averagQtyTxnLbl.frame.size.width,hlcell.frame.size.height);
                
                avgAmountTxn_Lbl.frame = CGRectMake(averageAmountTxnLbl.frame.origin.x,0,averageAmountTxnLbl.frame.size.width,hlcell.frame.size.height);
            }
            
            else{
                
                //Code for iPhone...
                
            }
            //setting font size....
            [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:15.0f cornerRadius:0.0];
            
            //appending values based on the service data...
            
            if (salesManCommissionArr.count >= indexPath.row && salesManCommissionArr.count) {
                
                NSDictionary * dic  = salesManCommissionArr[indexPath.row];
                
                sno_Lbl.text = [NSString stringWithFormat:@"%ld",(indexPath.row+1)];
                
                salesmanName_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:CASHIER_NAME] defaultReturn:@"--"];
                
                salesManId_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:CASHIER_ID] defaultReturn:@"--"];//CASHIER_ID
                
                
                bussinessDate_Lbl.text = [self checkGivenValueIsNullOrNil:[[dic valueForKey:@"date"] componentsSeparatedByString:@" "][0] defaultReturn:@"--"];//ITEM_DESC
                
                shiftID_Lbl.text = [NSString stringWithFormat:@"%ld",[[self checkGivenValueIsNullOrNil:[dic valueForKey:HOUR] defaultReturn:@"0.00"] integerValue]];
                
                counterId_Lbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:COUNTER] defaultReturn:@"--"];
                
                transactionCount_Lbl.text = [NSString stringWithFormat:@"%ld", [[self checkGivenValueIsNullOrNil:[dic valueForKey:NO_OF_BILLS] defaultReturn:@"0.00"] integerValue]];
                
                quantity_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]];
                
                amount_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:TOTAL_COST] defaultReturn:@"0.00"] floatValue]];
                
                avgQtyTxn_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:AVG_QUANTITY] defaultReturn:@"0.00"] floatValue]];
                
                
                avgAmountTxn_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:AVG_VALUE] defaultReturn:@"0.00"] floatValue]];
            }
            else {
                
                sno_Lbl.text = @"--";
                salesmanName_Lbl.text = @"--";
                salesManId_Lbl.text = @"--";
                bussinessDate_Lbl.text = @"--";
                shiftID_Lbl.text = @"--";
                counterId_Lbl.text = @"--";
                transactionCount_Lbl.text = @"--";
                quantity_Lbl.text = @"--";
                avgQtyTxn_Lbl.text = @"--";
                avgAmountTxn_Lbl.text = @"--";
                
            }
            
            
        } @catch (NSException *exception) {
            
        } @finally {
            hlcell.backgroundColor = [UIColor clearColor];
            hlcell.tag = indexPath.row;
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            return hlcell;
            
        }
        
    }
    else if (tableView == salesPersonIdTbl){
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
        hlcell.textLabel.font = [UIFont systemFontOfSize:16.0];

        NSDictionary * dic = employeeIdsArr[indexPath.row];
        
        if (indexPath.row == 0) {
            hlcell.textLabel.text =  employeeIdsArr[indexPath.row];
            
        }
        else
            hlcell.textLabel.text =  [NSString stringWithFormat:@"%@(%@)",[dic valueForKey:@"firstName"],[dic valueForKey:@"employeeCode"]];
        
        
        //hlcell.textLabel.text =  [NSString stringWithFormat:@"%@",[dic valueForKey:@"employeeCode"]];
        //[dic valueForKey:@"firstName"] @(%@)
        
        return hlcell;
    }
    
    
    else if (tableView == counterIDTbl){
        
        static NSString * CellIdentifier = @"Cell";
        
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
        
        @try {
            hlcell.textLabel.text = couterIdArr[indexPath.row];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.textLabel.font = [UIFont systemFontOfSize:18.0];
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
        return hlcell;
    }
}


/**
 * @description  <#description#>
 * @date         <#date#>
 * @method       <#name#>
 * @author       Bhargav.v
 * @param        <#param#>
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    //Dimissing the popOver.....
    [catPopOver dismissPopoverAnimated:YES];
    
    if(tableView == salesPersonIdTbl) {
        
        @try {
            
            salesPersonIdTbl.tag = indexPath.row;
            
            NSDictionary * dic = employeeIdsArr[indexPath.row];
            
            if (indexPath.row == 0) {
                salesperonTxt.text =  employeeIdsArr[indexPath.row];
                salesPersonIdStr  = @"";

            }
            
            else{
                
                salesperonTxt.text =  [NSString stringWithFormat:@"%@(%@)",[dic valueForKey:@"firstName"],[dic valueForKey:@"employeeCode"]];
                
                salesPersonIdStr  = [[dic valueForKey:@"employeeCode"] copy];
            }
            
            
            //NSDictionary * dic = [employeeIdsArr objectAtIndex:indexPath.row];
            //salesperonTxt.text = [NSString stringWithFormat:@"%@(%@)",[dic valueForKey:@"firstName"],[dic valueForKey:@"employeeCode"]];
            //salesperonTxt.text = [employeeIdsArr objectAtIndex:indexPath.row];
            //[NSString stringWithFormat:@"%@(%@)",[dic valueForKey:@"firstName"],[dic valueForKey:@"employeeCode"]]
            
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
        
    }
    
    else if (tableView == counterIDTbl){
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        counterIDTbl.tag = indexPath.row;
        
        counterTxt.text = couterIdArr[indexPath.row];
    }
}


/**
 * @description
 * @date         <#date#>
 * @method       tableView willDisplayCell forRowAtIndexpath
 * @author       Bhargav.v
 * @param        UITableView
 * @param        UITableViewCell
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    @try {
        
        if(tableView == salesmenReportTbl){
            
            @try {
                
                if ((indexPath.row == (salesManCommissionArr.count-1)) && (salesManCommissionArr.count < totalNumberOfReports) && (salesManCommissionArr.count> startIndexInt)) {
                    
                    [HUD show:YES];
                    [HUD setHidden:NO];
                    startIndexInt = startIndexInt +10;
                    [self getSalesMenReport];
                }
                
            } @catch (NSException * exception) {
                NSLog(@"-----------exception in servicecall-------------%@",exception);
                [HUD setHidden:YES];
            }
        }
    } @catch (NSException * exception) {
        
    }
}


#pragma -mark reusableMethods.......

/**
 * @description  Displaying th PopUp's and reloading table if popUp is vissiable.....
 * @date         10/05/2017
 * @method       showPopUpForTables:-- popUpWidth:-- popUpHeight:-- presentPopUpAt:-- showViewIn:-- permittedArrowDirections:--
 * @author       Srinivasulu
 * @param        UITableView
 * @param        float
 * @param        float
 * @param        id
 * @param        id
 * @param        permittedArrowDirections
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)showPopUpForTables:(UITableView *)tableName   popUpWidth:(float)width popUpHeight:(float)height  presentPopUpAt:(id)displayFrame  showViewIn:(id)view   permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections{
    
    @try {
        
        if ( catPopOver.popoverVisible && (tableName.frame.size.height > height) ){
            catPopOver.popoverContentSize =  CGSizeMake(width, height);
            
            //            catPopOver.contentViewController.preferredContentSize = CGSizeMake(width, height);
            //CGRectMake( tableName.frame.origin.x, tableName.frame.origin.x, tableName.frame.size.width, tableName.frame.size.height);
            
            //            if (tableName.frame.size.height < height)
            //                tableName.frame = CGRectMake( tableName.frame.origin.x, tableName.frame.origin.x, tableName.frame.size.width, tableName.frame.size.height);
            
            [tableName reloadData];
            return;
            
        }
        
        if(catPopOver.popoverVisible)
            [catPopOver dismissPopoverAnimated:YES];
        
        
        UITextView *textView = displayFrame;
        
        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake( 0.0, 0.0, width, height)];
        customView.opaque = NO;
        customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customView.layer.borderWidth = 2.0f;
        [customView setHidden:NO];
        
        
        //        tableName = [[UITableView alloc]init];
        tableName.layer.borderWidth = 1.0;
        tableName.layer.cornerRadius = 10.0;
        tableName.bounces = FALSE;
        tableName.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
        tableName.layer.borderColor = [UIColor blackColor].CGColor;
        tableName.dataSource = self;
        tableName.delegate = self;
        tableName.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        tableName.hidden = NO;
        tableName.frame = CGRectMake(0.0, 0.0, customView.frame.size.width, customView.frame.size.height);
        [customView addSubview:tableName];
        [tableName reloadData];
        
        customerInfoPopUp.view = customView;
        
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            [popover presentPopoverFromRect:textView.frame inView:view permittedArrowDirections:arrowDirections animated:YES];
            
            catPopOver= popover;
            
        }
        
        else {
            
            //            customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
            
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
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        [tableName reloadData];
        
    }
}




#pragma -mark mehod used to check whether received object in NULL or not

/**
 * @description  here we are checking whether the object is null or not
 * @date         07/05/2017....
 * @method       checkGivenValueIsNullOrNil
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */
- (id)checkGivenValueIsNullOrNil:(id)inputValue defaultReturn:(NSString *)returnStirng{
    
    
    @try {
        if (([inputValue isKindOfClass:[NSNull class]] || inputValue == nil )) {
            
            
            return returnStirng;
        }
        else {
            
            
            if([inputValue isKindOfClass:[NSString class]])
                if([inputValue isEqualToString:@"<null>"])
                    return returnStirng;
            
            return inputValue;
        }
    } @catch (NSException * exception) {
        return returnStirng;
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
                NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
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


#pragma -mark super class methods

/**
 * @description  Navigating back to home page...
 * @date         26/09/2016
 * @method       homeButonClicked
 * @author       Bhargav Ram
 * @param
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)homeButonClicked{
    
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        OmniHomePage *home = [[OmniHomePage alloc]init];
        [self.navigationController pushViewController:home animated:YES];
        
    } @catch (NSException *exception) {
        
    }
}

/**
 * @description  here we are navigating back to home page.......
 * @date         26/09/2016
 * @method       goToHome
 * @author       Bhargav.v
 * @param
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the comment's section && added try catch block....
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)goToHome {
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        [self.navigationController popViewControllerAnimated:YES];
        
    } @catch (NSException *exception) {
        
    }
}

/**
 * @description  here we are navigating back to home page.......
 * @date         26/09/2016
 * @method       backAction
 * @author       Bhargav Ram
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
    AudioServicesPlaySystemSound(soundFileObject);
    
    
    @try {
        [self.navigationController popViewControllerAnimated:YES];
        
    } @catch (NSException *exception) {
        
    }
}



@end
