//
//  HourWiseReports.m
//  OmniRetailer
//
//  Created by Saikrishna Kumbhoji on 08/09/2017.
//
//

#import <QuartzCore/QuartzCore.h>
#import "HourWiseReports.h"
#import "Global.h"
#import "OmniHomePage.h"


@interface HourWiseReports ()

@end

@implementation HourWiseReports
@synthesize soundFileURLRef,soundFileObject;

#pragma  -mark start of ViewLifeCycle mehods....

/*
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date         09/08/2017
 * @method       ViewDidLoad
 * @author       Sai Krishna Kumbhoji
 * @param
 * @param
 * @return
 *
 * @modified BY
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    version = [UIDevice currentDevice].systemVersion.floatValue;
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (CFURLRef)CFBridgingRetain(tapSound);
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    self.navigationController.navigationBarHidden = NO;
    
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
    
    self.view.backgroundColor = [UIColor blackColor];
    
    // UIView
    //creating the skuWiseReportView which will displayed completed Screen.......
    hourWiseReportView = [[UIView alloc] init];
    hourWiseReportView.layer.borderWidth = 1.0f;
    hourWiseReportView.layer.cornerRadius = 10.0f;
    hourWiseReportView.layer.borderColor = [UIColor blackColor].CGColor;
    
    /*Creation of UILabel for headerDisplay.......*/
    //creating line  UILabel which will display at topOfThe  billingView.......
    
    UILabel  * headerNameLbl;
    UIButton * startDteBtn;
    UIButton * endDateBtn;
    UIImage  * calendarImg;
    CALayer  *bottomBorder;
    
    
    calendarImg = [UIImage imageNamed:@"Calandar_Icon.png"];
    
    //Allocation of headerLabel..
    headerNameLbl = [[UILabel alloc] init];
    headerNameLbl.backgroundColor = [UIColor clearColor];
    headerNameLbl.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
    headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
    headerNameLbl.textAlignment = NSTextAlignmentCenter;
    headerNameLbl.layer.cornerRadius = 10.0f;
    headerNameLbl.layer.masksToBounds = YES;
    headerNameLbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gradient.png"]];
    headerNameLbl.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
    
    //changing the headerNameLbl backGrouondColor & textColor.......
    bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, 60.0f, headerNameLbl.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor grayColor].CGColor;
    bottomBorder.opacity = 5.0f;
    [headerNameLbl.layer addSublayer:bottomBorder];
    
    NSDate * today = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"dd/MM/yyyy";
    NSString* currentdate = [f stringFromDate:today];
    
    //Allocation of startDateTxt..
    startDateTxt = [[CustomTextField alloc] init];
    startDateTxt.placeholder = NSLocalizedString(@"start_date",nil);
    startDateTxt.borderStyle=UITextBorderStyleRoundedRect;
    startDateTxt.delegate = self;
    startDateTxt.userInteractionEnabled = NO;
    startDateTxt.text = currentdate;
    [startDateTxt awakeFromNib];
    
    //Allocation of endDateTxt..
    endDateTxt = [[CustomTextField alloc] init];
    endDateTxt.placeholder = NSLocalizedString(@"end_date",nil);
    endDateTxt.borderStyle=UITextBorderStyleRoundedRect;
    endDateTxt.delegate = self;
    endDateTxt.userInteractionEnabled = NO;
    [endDateTxt awakeFromNib];
    
    //Allocation of startDteBtn..
     startDteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startDteBtn setBackgroundImage:calendarImg forState:UIControlStateNormal];
    [startDteBtn addTarget:self action:@selector(DateButtonPressed:) forControlEvents:UIControlEventTouchDown];
    
    //Allocation of endDateBtn..
     endDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [endDateBtn setBackgroundImage:calendarImg forState:UIControlStateNormal];
    [endDateBtn addTarget:self action:@selector(DateButtonPressed:) forControlEvents:UIControlEventTouchDown];
    
    //used for identification propouse....
    startDteBtn.tag = 2;
    endDateBtn.tag = 4;
    
    //Allocation of headerScrollView..
    headerScrollView  = [[UIScrollView alloc] init];
    //headerScrollView.backgroundColor = [UIColor lightGrayColor];
    
    //Allocation of CustomLabels..
    slnoLbl = [[CustomLabel alloc] init];
    [slnoLbl awakeFromNib];
    
    dateLbl = [[CustomLabel alloc]init];
    [dateLbl awakeFromNib];
    
    timeLbl = [[CustomLabel alloc]init];
    [timeLbl awakeFromNib];
    
    totalBillsLbl = [[CustomLabel alloc]init];
    [totalBillsLbl awakeFromNib];
    
    cashTotalLbl = [[CustomLabel alloc]init];
    [cashTotalLbl awakeFromNib];
    
    cardTotalLbl = [[CustomLabel alloc]init];
    [cardTotalLbl awakeFromNib];
    
    returnedAmtLbl = [[CustomLabel alloc]init];
    [returnedAmtLbl awakeFromNib];
    
    exchangeAmtLbl = [[CustomLabel alloc]init];
    [exchangeAmtLbl awakeFromNib];
    
    sodexoTotalLbl = [[CustomLabel alloc]init];
    [sodexoTotalLbl awakeFromNib];
    
    ticketTotalLbl = [[CustomLabel alloc]init];
    [ticketTotalLbl awakeFromNib];
    
    loyaltyTotalLbl = [[CustomLabel alloc]init];
    [loyaltyTotalLbl awakeFromNib];
    
    creditNoteLbl = [[CustomLabel alloc]init];
    [creditNoteLbl awakeFromNib];
    
    giftVouchersLbl = [[CustomLabel alloc]init];
    [giftVouchersLbl awakeFromNib];
    
    couponsLbl = [[CustomLabel alloc]init];
    [couponsLbl awakeFromNib];
    
    totalCostLbl = [[CustomLabel alloc]init];
    [totalCostLbl awakeFromNib];
 
    
    //Allocation of skuReportTable..
    hourReportTable = [[UITableView alloc]init];
    hourReportTable.backgroundColor = [UIColor blackColor];
    hourReportTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    hourReportTable.dataSource = self;
    hourReportTable.delegate = self;
    hourReportTable.bounces = TRUE;
    hourReportTable.layer.cornerRadius = 14;
    
    //Allocation Of UILabels to show the totalValue:
    
    //Allocation of UIView....
    totalReportsView = [[UIView alloc]init];
    totalReportsView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
    totalReportsView.layer.borderWidth =3.0f;
    
    //Allocation of GO Buttton:
    goButton = [[UIButton alloc] init] ;
//    [goButton setTitle:@"Go" forState:UIControlStateNormal];
    goButton.backgroundColor = [UIColor grayColor];
    goButton.layer.masksToBounds = YES;
    [goButton addTarget:self action:@selector(goButtonPressed:) forControlEvents:UIControlEventTouchDown];
    goButton.userInteractionEnabled = YES;
    goButton.layer.cornerRadius = 6.0f;
    goButton.titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    goButton.tag = 2;
    
    //Recently Added Labels For making the total of stock quantity
    
    cashTotalValueLbl = [[UILabel alloc] init];
    cashTotalValueLbl.layer.cornerRadius = 5;
    cashTotalValueLbl.layer.masksToBounds = YES;
    cashTotalValueLbl.backgroundColor = [UIColor blackColor];
    cashTotalValueLbl.layer.borderWidth = 2.0f;
    cashTotalValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    cashTotalValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    cardTotalValueLbl = [[UILabel alloc] init];
    cardTotalValueLbl.layer.cornerRadius = 5;
    cardTotalValueLbl.layer.masksToBounds = YES;
    cardTotalValueLbl.backgroundColor = [UIColor blackColor];
    cardTotalValueLbl.layer.borderWidth = 2.0f;
    cardTotalValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    cardTotalValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

    returnedAmtValueLbl = [[UILabel alloc] init];
    returnedAmtValueLbl.layer.cornerRadius = 5;
    returnedAmtValueLbl.layer.masksToBounds = YES;
    returnedAmtValueLbl.backgroundColor = [UIColor blackColor];
    returnedAmtValueLbl.layer.borderWidth = 2.0f;
    returnedAmtValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    returnedAmtValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

    exchangeAmtValueLbl = [[UILabel alloc] init];
    exchangeAmtValueLbl.layer.cornerRadius = 5;
    exchangeAmtValueLbl.layer.masksToBounds = YES;
    exchangeAmtValueLbl.backgroundColor = [UIColor blackColor];
    exchangeAmtValueLbl.layer.borderWidth = 2.0f;
    exchangeAmtValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    exchangeAmtValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

    sodexoTotalValueLbl = [[UILabel alloc] init];
    sodexoTotalValueLbl.layer.cornerRadius = 5;
    sodexoTotalValueLbl.layer.masksToBounds = YES;
    sodexoTotalValueLbl.backgroundColor = [UIColor blackColor];
    sodexoTotalValueLbl.layer.borderWidth = 2.0f;
    sodexoTotalValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    sodexoTotalValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

    ticketTotalValueLbl = [[UILabel alloc] init];
    ticketTotalValueLbl.layer.cornerRadius = 5;
    ticketTotalValueLbl.layer.masksToBounds = YES;
    ticketTotalValueLbl.backgroundColor = [UIColor blackColor];
    ticketTotalValueLbl.layer.borderWidth = 2.0f;
    ticketTotalValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    ticketTotalValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

    
    loyalityValueLbl = [[UILabel alloc] init];
    loyalityValueLbl.layer.cornerRadius = 5;
    loyalityValueLbl.layer.masksToBounds = YES;
    loyalityValueLbl.backgroundColor = [UIColor blackColor];
    loyalityValueLbl.layer.borderWidth = 2.0f;
    loyalityValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    loyalityValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

    creditNoteValueLbl = [[UILabel alloc] init];
    creditNoteValueLbl.layer.cornerRadius = 5;
    creditNoteValueLbl.layer.masksToBounds = YES;
    creditNoteValueLbl.backgroundColor = [UIColor blackColor];
    creditNoteValueLbl.layer.borderWidth = 2.0f;
    creditNoteValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    creditNoteValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

    giftVoucherValueLbl = [[UILabel alloc] init];
    giftVoucherValueLbl.layer.cornerRadius = 5;
    giftVoucherValueLbl.layer.masksToBounds = YES;
    giftVoucherValueLbl.backgroundColor = [UIColor blackColor];
    giftVoucherValueLbl.layer.borderWidth = 2.0f;
    giftVoucherValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    giftVoucherValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    couponsValueLbl = [[UILabel alloc] init];
    couponsValueLbl.layer.cornerRadius = 5;
    couponsValueLbl.layer.masksToBounds = YES;
    couponsValueLbl.backgroundColor = [UIColor blackColor];
    couponsValueLbl.layer.borderWidth = 2.0f;
    couponsValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    couponsValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

    totalCostValueLbl = [[UILabel alloc] init];
    totalCostValueLbl.layer.cornerRadius = 5;
    totalCostValueLbl.layer.masksToBounds = YES;
    totalCostValueLbl.backgroundColor = [UIColor blackColor];
    totalCostValueLbl.layer.borderWidth = 2.0f;
    totalCostValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    totalCostValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    

    cashTotalValueLbl.textAlignment      = NSTextAlignmentCenter;
    cardTotalValueLbl.textAlignment      = NSTextAlignmentCenter;
    returnedAmtValueLbl.textAlignment    = NSTextAlignmentCenter;
    exchangeAmtValueLbl.textAlignment    = NSTextAlignmentCenter;
    sodexoTotalValueLbl.textAlignment    = NSTextAlignmentCenter;
    ticketTotalValueLbl.textAlignment    = NSTextAlignmentCenter;
    loyalityValueLbl.textAlignment       = NSTextAlignmentCenter;
    creditNoteValueLbl.textAlignment     = NSTextAlignmentCenter;
    giftVoucherValueLbl.textAlignment    = NSTextAlignmentCenter;
    couponsValueLbl.textAlignment        = NSTextAlignmentCenter;
    totalCostValueLbl.textAlignment      = NSTextAlignmentCenter;

    cashTotalValueLbl.text   = @"0.0";
    cardTotalValueLbl.text   = @"0.0";
    returnedAmtValueLbl.text = @"0.0";
    exchangeAmtValueLbl.text = @"0.0";
    sodexoTotalValueLbl.text = @"0.0";
    ticketTotalValueLbl.text = @"0.0";
    loyalityValueLbl.text    = @"0.0";
    creditNoteValueLbl.text  = @"0.0";
    giftVoucherValueLbl.text = @"0.0";
    couponsValueLbl.text     = @"0.0";
    totalCostValueLbl.text   = @"0.0";

    
    
    
    @try {
        self.titleLabel.text = NSLocalizedString(@"omni_retailer",nil);
        HUD.labelText = NSLocalizedString(@"please_wait..",nil);
        headerNameLbl.text = NSLocalizedString(@"hour_wise_report",nil);
        
        slnoLbl.text = NSLocalizedString(@"s_no",nil);
        dateLbl.text = NSLocalizedString(@"date",nil);
        timeLbl.text = NSLocalizedString(@"time",nil);
        totalBillsLbl.text = NSLocalizedString(@"total_bills",nil);
        cashTotalLbl.text = NSLocalizedString(@"cash_total",nil);
        cardTotalLbl.text = NSLocalizedString(@"card_total",nil);
        returnedAmtLbl.text = NSLocalizedString(@"returned_amount",nil);
        exchangeAmtLbl.text = NSLocalizedString(@"exchange_amount",nil);
        sodexoTotalLbl.text = NSLocalizedString(@"sodexo_total",nil);
        ticketTotalLbl.text = NSLocalizedString(@"ticket_total",nil);
        loyaltyTotalLbl.text = NSLocalizedString(@"loyalty_total",nil);
        creditNoteLbl.text = NSLocalizedString(@"credit_note",nil);
        giftVouchersLbl.text = NSLocalizedString(@"gift_vouchers",nil);
        couponsLbl.text = NSLocalizedString(@"coupons",nil);
        totalCostLbl.text = NSLocalizedString(@"total_cost",nil);
        
        //setting title label text of the UIButton's....
        [goButton setTitle:NSLocalizedString(@"go", nil) forState:UIControlStateNormal];
        
    } @catch (NSException * exception) {
        
    }
    
    //added by Srinivasulu on 09/11/2017....
    
    averageQuantityLbl = [[CustomLabel alloc]init];
    [averageQuantityLbl awakeFromNib];
    
    averageValueLbl = [[CustomLabel alloc]init];
    [averageValueLbl awakeFromNib];
    
    averageQuantityValueLbl = [[UILabel alloc] init];
    averageQuantityValueLbl.layer.cornerRadius = 5;
    averageQuantityValueLbl.layer.masksToBounds = YES;
    averageQuantityValueLbl.backgroundColor = [UIColor blackColor];
    averageQuantityValueLbl.layer.borderWidth = 2.0f;
    averageQuantityValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    averageQuantityValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    averageSoledValueLbl = [[UILabel alloc] init];
    averageSoledValueLbl.layer.cornerRadius = 5;
    averageSoledValueLbl.layer.masksToBounds = YES;
    averageSoledValueLbl.backgroundColor = [UIColor blackColor];
    averageSoledValueLbl.layer.borderWidth = 2.0f;
    averageSoledValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    averageSoledValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    averageQuantityLbl.textAlignment      = NSTextAlignmentCenter;
    averageValueLbl.textAlignment      = NSTextAlignmentCenter;
    averageQuantityValueLbl.textAlignment    = NSTextAlignmentCenter;
    averageSoledValueLbl.textAlignment    = NSTextAlignmentCenter;

    averageQuantityLbl.text = NSLocalizedString(@"avg_qty",nil);
    averageValueLbl.text = NSLocalizedString(@"avg_value",nil);
  
    averageQuantityValueLbl.text   = @"0.0";
    averageSoledValueLbl.text   = @"0.0";
    
    [headerScrollView addSubview:averageQuantityLbl];
    [headerScrollView addSubview:averageValueLbl];

    [headerScrollView addSubview:averageQuantityValueLbl];
    [headerScrollView addSubview:averageSoledValueLbl];

    
    //upto here on 09/11/2017....
    
    //Adding subViews to the main view....
    
    //adding header label as subView....
    [hourWiseReportView addSubview:headerNameLbl];
    
    [hourWiseReportView addSubview:startDateTxt];
    [hourWiseReportView addSubview:endDateTxt];
    
    [hourWiseReportView addSubview:startDteBtn];
    [hourWiseReportView addSubview:endDateBtn];
    
    [hourWiseReportView addSubview: goButton];
    
    [headerScrollView addSubview:slnoLbl];
    [headerScrollView addSubview:dateLbl];
    [headerScrollView addSubview:timeLbl];
    [headerScrollView addSubview:totalBillsLbl];
    [headerScrollView addSubview:cashTotalLbl];
    [headerScrollView addSubview:cardTotalLbl];
    [headerScrollView addSubview:returnedAmtLbl];
    [headerScrollView addSubview:exchangeAmtLbl];
    [headerScrollView addSubview:sodexoTotalLbl];
    [headerScrollView addSubview:ticketTotalLbl];
    [headerScrollView addSubview:loyaltyTotalLbl];
    [headerScrollView addSubview:creditNoteLbl];
    [headerScrollView addSubview:giftVouchersLbl];
    [headerScrollView addSubview:couponsLbl];
    [headerScrollView addSubview:totalCostLbl];
    
    [headerScrollView addSubview:hourReportTable];
    
    [headerScrollView addSubview:cashTotalValueLbl];
    [headerScrollView addSubview:cardTotalValueLbl];
    [headerScrollView addSubview:returnedAmtValueLbl];
    [headerScrollView addSubview:exchangeAmtValueLbl];
    [headerScrollView addSubview:sodexoTotalValueLbl];
    [headerScrollView addSubview:ticketTotalValueLbl];
    [headerScrollView addSubview:loyalityValueLbl];
    [headerScrollView addSubview:creditNoteValueLbl];
    [headerScrollView addSubview:giftVoucherValueLbl];
    [headerScrollView addSubview:couponsValueLbl];
    [headerScrollView addSubview:totalCostValueLbl];
    
    
    //adding headerScrollView as subView for the hourWiseReportView ....
    [hourWiseReportView addSubview:headerScrollView];
    
    //Adding hourWiseReportView as a subView for the self.view...
    [self.view addSubview:hourWiseReportView];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
        }
        //frame for the hourWiseReport view..
        hourWiseReportView.frame = CGRectMake( 2, 70, self.view.frame.size.width - 4, self.view.frame.size.height - 80);
        
        //frame for the headerNameLbl..
        headerNameLbl.frame = CGRectMake( 0, 0, hourWiseReportView.frame.size.width, 45);

        float textFieldWidth = 180;
        float textFieldHeight = 40;
        float horizontalGap = 20;
        
        //Row 1...
        //frame for the start date label...
        startDateTxt.frame =  CGRectMake(hourWiseReportView.frame.origin.x+10,headerNameLbl.frame.origin.y+headerNameLbl.frame.size.height+20,textFieldWidth,textFieldHeight);
        
        endDateTxt.frame = CGRectMake(startDateTxt.frame.origin.x+startDateTxt.frame.size.width+horizontalGap,startDateTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        
        //Frame for the startDteBtn
        startDteBtn.frame = CGRectMake((startDateTxt.frame.origin.x + startDateTxt.frame.size.width - 45), startDateTxt.frame.origin.y + 2, 40, 35);
        
        //Frame for the endDteBtn
        endDateBtn.frame = CGRectMake((endDateTxt.frame.origin.x + endDateTxt.frame.size.width - 45), endDateTxt.frame.origin.y + 2, 40, 35);
        
        //Frame for the Go Button..
        
        goButton.frame =CGRectMake(endDateTxt.frame.origin.x + endDateTxt.frame.size.width + horizontalGap, endDateTxt.frame.origin.y, 80, 40);
        
        headerScrollView.frame = CGRectMake( 10, startDateTxt.frame.origin.y + startDateTxt.frame.size.height + 20, hourWiseReportView.frame.size.width  -20, 560);

       //frames for the custom Labels...
        slnoLbl.frame = CGRectMake(0,0,60,40);
        dateLbl.frame = CGRectMake(slnoLbl.frame.origin.x+slnoLbl.frame.size.width+2,slnoLbl.frame.origin.y,100,slnoLbl.frame.size.height);
        timeLbl.frame = CGRectMake(dateLbl.frame.origin.x+dateLbl.frame.size.width+2,slnoLbl.frame.origin.y,100,slnoLbl.frame.size.height);
        
        totalBillsLbl.frame = CGRectMake(timeLbl.frame.origin.x+timeLbl.frame.size.width+2,slnoLbl.frame.origin.y,100,slnoLbl.frame.size.height);
        cashTotalLbl.frame = CGRectMake(totalBillsLbl.frame.origin.x+totalBillsLbl.frame.size.width+2,slnoLbl.frame.origin.y,100,slnoLbl.frame.size.height);
        
        cardTotalLbl.frame = CGRectMake(cashTotalLbl.frame.origin.x+cashTotalLbl.frame.size.width+2,slnoLbl.frame.origin.y,100,slnoLbl.frame.size.height);

        returnedAmtLbl.frame = CGRectMake(cardTotalLbl.frame.origin.x+cardTotalLbl.frame.size.width+2,slnoLbl.frame.origin.y,120,slnoLbl.frame.size.height);
        
        exchangeAmtLbl.frame = CGRectMake(returnedAmtLbl.frame.origin.x+returnedAmtLbl.frame.size.width+2,slnoLbl.frame.origin.y,120,slnoLbl.frame.size.height);
        
        sodexoTotalLbl.frame = CGRectMake(exchangeAmtLbl.frame.origin.x+exchangeAmtLbl.frame.size.width+2,slnoLbl.frame.origin.y,100,slnoLbl.frame.size.height);

        ticketTotalLbl.frame = CGRectMake(sodexoTotalLbl.frame.origin.x+sodexoTotalLbl.frame.size.width+2,slnoLbl.frame.origin.y,100,slnoLbl.frame.size.height);
        
        loyaltyTotalLbl.frame = CGRectMake(ticketTotalLbl.frame.origin.x+ticketTotalLbl.frame.size.width+2,slnoLbl.frame.origin.y,100,slnoLbl.frame.size.height);
        
        creditNoteLbl.frame = CGRectMake(loyaltyTotalLbl.frame.origin.x+loyaltyTotalLbl.frame.size.width+2,slnoLbl.frame.origin.y,100,slnoLbl.frame.size.height);
        
        giftVouchersLbl.frame = CGRectMake(creditNoteLbl.frame.origin.x+creditNoteLbl.frame.size.width+2,slnoLbl.frame.origin.y,120,slnoLbl.frame.size.height);
        
        couponsLbl.frame = CGRectMake(giftVouchersLbl.frame.origin.x+giftVouchersLbl.frame.size.width+2,slnoLbl.frame.origin.y,100,slnoLbl.frame.size.height);
        
        totalCostLbl.frame = CGRectMake( couponsLbl.frame.origin.x + couponsLbl.frame.size.width + 2, slnoLbl.frame.origin.y, 100, slnoLbl.frame.size.height);
  

        cashTotalValueLbl.frame = CGRectMake( cashTotalLbl.frame.origin.x,  headerScrollView.frame.size.height - 50, cashTotalLbl.frame.size.width, 40);
        
        cardTotalValueLbl.frame = CGRectMake( cardTotalLbl.frame.origin.x, cashTotalValueLbl.frame.origin.y,cardTotalLbl.frame.size.width,40);

        returnedAmtValueLbl.frame = CGRectMake(returnedAmtLbl.frame.origin.x,cashTotalValueLbl.frame.origin.y,returnedAmtLbl.frame.size.width,40);

        exchangeAmtValueLbl.frame = CGRectMake(exchangeAmtLbl.frame.origin.x,cashTotalValueLbl.frame.origin.y,exchangeAmtLbl.frame.size.width,40);

        sodexoTotalValueLbl.frame = CGRectMake(sodexoTotalLbl.frame.origin.x,cashTotalValueLbl.frame.origin.y,sodexoTotalLbl.frame.size.width,40);

        ticketTotalValueLbl.frame = CGRectMake(ticketTotalLbl.frame.origin.x,cashTotalValueLbl.frame.origin.y,ticketTotalLbl.frame.size.width,40);

        loyalityValueLbl.frame = CGRectMake(loyaltyTotalLbl.frame.origin.x,cashTotalValueLbl.frame.origin.y,loyaltyTotalLbl.frame.size.width,40);

        creditNoteValueLbl.frame = CGRectMake(creditNoteLbl.frame.origin.x,cashTotalValueLbl.frame.origin.y,creditNoteLbl.frame.size.width,40);
        
        giftVoucherValueLbl.frame = CGRectMake(giftVouchersLbl.frame.origin.x,cashTotalValueLbl.frame.origin.y,giftVouchersLbl.frame.size.width,40);

        couponsValueLbl.frame = CGRectMake(couponsLbl.frame.origin.x,cashTotalValueLbl.frame.origin.y,couponsLbl.frame.size.width,40);
        
        totalCostValueLbl.frame = CGRectMake(totalCostLbl.frame.origin.x,cashTotalValueLbl.frame.origin.y,totalCostLbl.frame.size.width,40);
        
        
        
        //added by Srinivasulu on 09/11/2017....
     
        
        averageQuantityLbl.frame = CGRectMake( totalCostLbl.frame.origin.x + totalCostLbl.frame.size.width + 2, slnoLbl.frame.origin.y, 100, slnoLbl.frame.size.height);
        averageValueLbl.frame = CGRectMake( averageQuantityLbl.frame.origin.x + averageQuantityLbl.frame.size.width + 2, slnoLbl.frame.origin.y, 100, slnoLbl.frame.size.height);
        
        averageQuantityValueLbl.frame = CGRectMake( totalCostValueLbl.frame.origin.x + totalCostValueLbl.frame.size.width + 2, cashTotalValueLbl.frame.origin.y, averageQuantityLbl.frame.size.width, totalCostValueLbl.frame.size.height);
        averageSoledValueLbl.frame = CGRectMake( averageQuantityValueLbl.frame.origin.x + averageQuantityValueLbl.frame.size.width + 2, cashTotalValueLbl.frame.origin.y, averageValueLbl.frame.size.width, totalCostValueLbl.frame.size.height);
        
        //upto here on 09/11/2017....
        
//        hourReportTable.frame = CGRectMake( slnoLbl.frame.origin.x, slnoLbl.frame.origin.y + slnoLbl.frame.size.height + 10, totalCostLbl.frame.origin.x + totalCostLbl.frame.size.width - slnoLbl.frame.origin.x, cashTotalValueLbl.frame.origin.y - (slnoLbl.frame.origin.y + slnoLbl.frame.size.height + 10) );

        hourReportTable.frame = CGRectMake( slnoLbl.frame.origin.x, slnoLbl.frame.origin.y + slnoLbl.frame.size.height + 10, averageSoledValueLbl.frame.origin.x + averageSoledValueLbl.frame.size.width - slnoLbl.frame.origin.x, cashTotalValueLbl.frame.origin.y - (slnoLbl.frame.origin.y + slnoLbl.frame.size.height + 10) );

        headerScrollView.contentSize = CGSizeMake( hourReportTable.frame.size.width + 5,headerScrollView.frame.size.height);
        
        
        
        
    }
    
    else{
        
        // code for the iPhone versions....
    }
    

 

    
    
    @try {
        [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:16.0f cornerRadius:0];
        headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
   
    } @catch (NSException *exception) {
        
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}


/**
 * @description  it is one of ViewLifeCylce Method which will be executed after execution of
 viewDidLoad.......
 * @date         21/09/2016
 * @method       viewDidAppear
 * @author       Bhargav Ram
 * @param        BOOL
 * @param
 * @return
 * @modified BY
 * @reason
 * * @return
 * @verified By
 * @verified On
 *
 */


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    [HUD setHidden:NO];
    
    @try {
        
        startIndexInt = 0;
        [self getHourWiseReports];
        
    } @catch (NSException *exception) {
        NSLog(@"----exception while calling service call------------%@",exception);
    } @finally {
        
    }
}






/**
 * @description  Calling the webService to get the hour wise reports...
 * @date         21/08/2017..
 * @method       getHourWiseReports
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getHourWiseReports{

    @try {
        
        [HUD setHidden:NO];
 
        if( hourWiseReportArr == nil && startIndexInt == 0){
        
            hourWiseReportArr = [NSMutableArray new];
        }
        else if(startIndexInt == 0 &&  hourWiseReportArr.count ){
            
            [hourWiseReportArr removeAllObjects];
        }

        
        NSString * startDteStr = startDateTxt.text;
        
        if((startDateTxt.text).length > 0)
            startDteStr =  [NSString stringWithFormat:@"%@%@",startDateTxt.text,@" 00:00:00"];
        
        NSString *  endDteStr  = endDateTxt.text;
        
        if ((endDateTxt.text).length>0) {
            endDteStr = [NSString stringWithFormat:@"%@%@",endDateTxt.text,@" 00:00:00"];
        }

        NSMutableDictionary * hourWiseDic = [[NSMutableDictionary alloc] init];

        [hourWiseDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [hourWiseDic setValue:presentLocation forKey:STORE_LOCATION];
//        [hourWiseDic setValue:presentLocation forKey:LOCATION];
        [hourWiseDic setValue:@"hour"forKey:SEARCH_CRITERIA];
        [hourWiseDic setValue:[NSNumber numberWithBool:false] forKey:IS_SAVE_REPORT];
        [hourWiseDic setValue:[NSNumber numberWithBool:false] forKey:SAVE_REORT_FLAG];
//        [hourWiseDic setValue:[NSString stringWithFormat:@"%d",10]  forKey:MAX_RECORDS];
        [hourWiseDic setValue:[NSString stringWithFormat:@"%d",10]  forKey:kRequiredRecords];
        hourWiseDic[START_INDEX] = [NSString stringWithFormat:@"%d",startIndexInt];
        
        [hourWiseDic setValue:@"" forKey:SEARCH_CRITERIA_STR];
        [hourWiseDic setValue:@"" forKey:kCategoryName];
        [hourWiseDic setValue:@"" forKey:ZONE_Id];
        [hourWiseDic setValue:@"" forKey:kSubCategory];
        [hourWiseDic setValue:@"" forKey:kBrand];
        [hourWiseDic setValue:@"" forKey:kItemDept];
        [hourWiseDic setValue:@"" forKey:SECTION];
        [hourWiseDic setValue:@"" forKey:SUPPLIER_NAME];
        [hourWiseDic setValue:@"" forKey:SEARCH_NAME];
        hourWiseDic[START_DATE] = startDteStr;
        hourWiseDic[END_DATE] = endDteStr;
        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:hourWiseDic options:0 error:&err];
        NSString * hourWiseJsonStr   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@--json product Categories String--",hourWiseJsonStr);
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.salesServiceDelegate = self;
        [webServiceController getHourWiseReports:hourWiseJsonStr];
 
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"message", nil),@"\n",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"---- exception while calling getPurchaseOrders ServicesCall ----%@",exception);

    } @finally {
        
        
        
    }
    
}




/**
 * @description  storing the data from the webservice success Response
 * @date         21/08/2017
 * @method       getHourWiseReportsSuccessResponse
 * @author       Bhargav.v
 * @param        NSDIctionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getHourWiseReportsSuccessResponse:(NSDictionary *)successDictionary {
  
    @try {
        
        if (successDictionary.count) {
            
            totalNumberOfReports= [[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:TOTAL_BILLS]  defaultReturn:@"0"]intValue];

            
            for (NSDictionary *reportListDic in [successDictionary valueForKey:HOUR_WISEREPORT_LIST] ) {
                
                [hourWiseReportArr addObject:reportListDic];
            }
            
            cashTotalValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:@"totCashAmt"] defaultReturn:@"0.00"] floatValue]];

            cardTotalValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:@"totCardAmt"] defaultReturn:@"0.00"] floatValue]];
            
            returnedAmtValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:@"totReturnAmt"] defaultReturn:@"0.00"] floatValue]];

            exchangeAmtValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:@"totExchAmt"] defaultReturn:@"0.00"] floatValue]];
            
            sodexoTotalValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:@"totSedexoAmt"] defaultReturn:@"0.00"] floatValue]];
            
            ticketTotalValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:@"totTickAmt"] defaultReturn:@"0.00"] floatValue]];

            loyalityValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:@"totLoyalAmt"] defaultReturn:@"0.00"] floatValue]];
            
            creditNoteValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:@"totCreditNoteAmt"] defaultReturn:@"0.00"] floatValue]];

            giftVoucherValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:@"totGiftVocAmt"] defaultReturn:@"0.00"] floatValue]];

            couponsValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:@"totGiftCoupAmt"] defaultReturn:@"0.00"] floatValue]];
            
            totalCostValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:@"totOverallAmt"] defaultReturn:@"0.00"] floatValue]];
            
            averageQuantityValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:@""] defaultReturn:@"0.00"] floatValue]];
            
            averageSoledValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:@""] defaultReturn:@"0.00"] floatValue]];
       

        }
    } @catch (NSException * exception) {
        
        
    } @finally {
        
        [HUD setHidden:YES];
        [hourReportTable reloadData];
    }
}

/**
 * @description  displaying the error response....
 * @date         21/08/2017
 * @method       getHourWiseReportErrorResponse
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getHourWiseReportErrorResponse:(NSString *)errorResponse {
    
    @try {
        
        if (startIndexInt == 0) {
            
            
            cashTotalValueLbl.text   = @"0.0";
            cardTotalValueLbl.text   = @"0.0";
            returnedAmtValueLbl.text = @"0.0";
            exchangeAmtValueLbl.text = @"0.0";
            sodexoTotalValueLbl.text = @"0.0";
            ticketTotalValueLbl.text = @"0.0";
            loyalityValueLbl.text    = @"0.0";
            creditNoteValueLbl.text  = @"0.0";
            giftVoucherValueLbl.text = @"0.0";
            couponsValueLbl.text     = @"0.0";
            totalCostValueLbl.text   = @"0.0";
            averageQuantityValueLbl.text = @"0.0";
            averageSoledValueLbl.text = @"0.0";
//            startDateTxt.text = @"";
//            endDateTxt.text   = @"";
            [self displayAlertMessage:@"No Records found" horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height-150  msgType:NSLocalizedString(@"warning", nil) conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        }
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
        [hourReportTable reloadData];
    }
}

/**
 * @description  Button action for the filter service call....
 * @date         10/08/2017
 * @method       goButtonPressed
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

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
    hourWiseReportArr = [NSMutableArray new];
    [self getHourWiseReports];
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
                [popover presentPopoverFromRect:startDateTxt.frame inView:hourWiseReportView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else
                [popover presentPopoverFromRect:endDateTxt.frame inView:hourWiseReportView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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


#pragma mark UITableVIew Delegates....

/**
 * @description  it is tableViewDelegate method it will execute and return numberOfRows in Table.....
 * @date         09/05/2017
 * @method       tableView: numberOfRowsInSectionL
 * @author       Bhargav.v
 * @param        UITableView
 * @param        NSInteger
 * @return       NSInteger
 * @verified By
 * @verified On
 *
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (tableView == hourReportTable) {
        if (hourWiseReportArr.count)
            
            return hourWiseReportArr.count;
        else
            return 2;
    }
    return 1;

    
}


/**
 * @description  it is tableview delegate method it will be called after numberOfRowsInSection.......
 * @date         26/09/2016
 * @method       tableView: heightForRowAtIndexPath:
 * @author       Bhargav Ram
 * @param        UITableView
 * @param        NSIndexPath
 * @return       CGFloat
 * @verified By
 * @verified On
 *
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView == hourReportTable){
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            return 45;
        }
        else{
            
            return 45;
        }
    }
    return 45;
  
}

//
/**
 * @description  Customize the appearance of table view cells.
 * @date         21/08/2017
 * @method       cellForRowAtIndexPath
 * @author       Bhargav.v
 * @param        UITableView
 * @param        NSIndexPath
 * @return       UITableViewCell
 * @verified By
 * @verified On
 *
 */


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    if (tableView == hourReportTable){

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
            
            UILabel * slno_Lbl;
            UILabel * date_Lbl;
            UILabel * time_Lbl;
            UILabel * totalBills_Lbl;
            UILabel * cashTotal_Lbl;
            UILabel * cardTotal_Lbl;
            UILabel * returnedAmt_Lbl;
            UILabel * exchangeAmt_lbl;
            UILabel * sodexoTotal_Lbl;
            UILabel * ticketTotal_Lbl;
            UILabel * loyaltyTotal_Lbl;
            UILabel * creditNote_Lbl;
            UILabel * giftVouchers_Lbl;
            UILabel * coupons_Lbl;
            UILabel * Total_Lbl;
            
            //added by Srinivasulu on 09/11/2017....
            
            UILabel * averageQuantityLbl_Lbl;
            UILabel * averageValue_Lbl;
            
            averageQuantityLbl_Lbl = [[UILabel alloc] init];
            averageQuantityLbl_Lbl.backgroundColor = [UIColor clearColor];
            averageQuantityLbl_Lbl.textAlignment = NSTextAlignmentCenter;
            averageQuantityLbl_Lbl.numberOfLines = 1;
            averageQuantityLbl_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            
            averageValue_Lbl = [[UILabel alloc] init];
            averageValue_Lbl.backgroundColor = [UIColor clearColor];
            averageValue_Lbl.textAlignment = NSTextAlignmentCenter;
            averageValue_Lbl.numberOfLines = 1;
            averageValue_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

            
            //upto here on 09/11/2017....
            
            /*Creation of UILabels used in this cell*/
            slno_Lbl = [[UILabel alloc] init];
            slno_Lbl.backgroundColor = [UIColor clearColor];
            slno_Lbl.textAlignment = NSTextAlignmentCenter;
            slno_Lbl.numberOfLines = 1;
            slno_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            date_Lbl = [[UILabel alloc] init];
            date_Lbl.backgroundColor = [UIColor clearColor];
            date_Lbl.textAlignment = NSTextAlignmentCenter;
            date_Lbl.numberOfLines = 1;
            date_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

            time_Lbl = [[UILabel alloc] init];
            time_Lbl.backgroundColor = [UIColor clearColor];
            time_Lbl.textAlignment = NSTextAlignmentCenter;
            time_Lbl.numberOfLines = 1;
            time_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            totalBills_Lbl = [[UILabel alloc] init];
            totalBills_Lbl.backgroundColor = [UIColor clearColor];
            totalBills_Lbl.textAlignment = NSTextAlignmentCenter;
            totalBills_Lbl.numberOfLines = 1;
            totalBills_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

            cashTotal_Lbl = [[UILabel alloc] init];
            cashTotal_Lbl.backgroundColor = [UIColor clearColor];
            cashTotal_Lbl.textAlignment = NSTextAlignmentCenter;
            cashTotal_Lbl.numberOfLines = 1;
            cashTotal_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

            cardTotal_Lbl = [[UILabel alloc] init];
            cardTotal_Lbl.backgroundColor = [UIColor clearColor];
            cardTotal_Lbl.textAlignment = NSTextAlignmentCenter;
            cardTotal_Lbl.numberOfLines = 1;
            cardTotal_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            cashTotal_Lbl = [[UILabel alloc] init];
            cashTotal_Lbl.backgroundColor = [UIColor clearColor];
            cashTotal_Lbl.textAlignment = NSTextAlignmentCenter;
            cashTotal_Lbl.numberOfLines = 1;
            cashTotal_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

            cardTotal_Lbl = [[UILabel alloc] init];
            cardTotal_Lbl.backgroundColor = [UIColor clearColor];
            cardTotal_Lbl.textAlignment = NSTextAlignmentCenter;
            cardTotal_Lbl.numberOfLines = 1;
            cardTotal_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

            returnedAmt_Lbl = [[UILabel alloc] init];
            returnedAmt_Lbl.backgroundColor = [UIColor clearColor];
            returnedAmt_Lbl.textAlignment = NSTextAlignmentCenter;
            returnedAmt_Lbl.numberOfLines = 1;
            returnedAmt_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
           
            exchangeAmt_lbl = [[UILabel alloc] init];
            exchangeAmt_lbl.backgroundColor = [UIColor clearColor];
            exchangeAmt_lbl.textAlignment = NSTextAlignmentCenter;
            exchangeAmt_lbl.numberOfLines = 1;
            exchangeAmt_lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            sodexoTotal_Lbl = [[UILabel alloc] init];
            sodexoTotal_Lbl.backgroundColor = [UIColor clearColor];
            sodexoTotal_Lbl.textAlignment = NSTextAlignmentCenter;
            sodexoTotal_Lbl.numberOfLines = 1;
            sodexoTotal_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            ticketTotal_Lbl = [[UILabel alloc] init];
            ticketTotal_Lbl.backgroundColor = [UIColor clearColor];
            ticketTotal_Lbl.textAlignment = NSTextAlignmentCenter;
            ticketTotal_Lbl.numberOfLines = 1;
            ticketTotal_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

            loyaltyTotal_Lbl = [[UILabel alloc] init];
            loyaltyTotal_Lbl.backgroundColor = [UIColor clearColor];
            loyaltyTotal_Lbl.textAlignment = NSTextAlignmentCenter;
            loyaltyTotal_Lbl.numberOfLines = 1;
            loyaltyTotal_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

            creditNote_Lbl = [[UILabel alloc] init];
            creditNote_Lbl.backgroundColor = [UIColor clearColor];
            creditNote_Lbl.textAlignment = NSTextAlignmentCenter;
            creditNote_Lbl.numberOfLines = 1;
            creditNote_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

            giftVouchers_Lbl = [[UILabel alloc] init];
            giftVouchers_Lbl.backgroundColor = [UIColor clearColor];
            giftVouchers_Lbl.textAlignment = NSTextAlignmentCenter;
            giftVouchers_Lbl.numberOfLines = 1;
            giftVouchers_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            coupons_Lbl = [[UILabel alloc] init];
            coupons_Lbl.backgroundColor = [UIColor clearColor];
            coupons_Lbl.textAlignment = NSTextAlignmentCenter;
            coupons_Lbl.numberOfLines = 1;
            coupons_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

            Total_Lbl = [[UILabel alloc] init];
            Total_Lbl.backgroundColor = [UIColor clearColor];
            Total_Lbl.textAlignment = NSTextAlignmentCenter;
            Total_Lbl.numberOfLines = 1;
            Total_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            
            slno_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            date_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            time_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            totalBills_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            cashTotal_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            cardTotal_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            returnedAmt_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            exchangeAmt_lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            sodexoTotal_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            ticketTotal_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            loyaltyTotal_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            creditNote_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            giftVouchers_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            coupons_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            Total_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            //added by Srinivasulu on 09/11/2017....

            averageQuantityLbl_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            averageValue_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

            
            [hlcell.contentView addSubview:averageQuantityLbl_Lbl];
            [hlcell.contentView addSubview:averageValue_Lbl];
            
            //upto here on 09/11/2017....

            [hlcell.contentView addSubview:slno_Lbl];
            [hlcell.contentView addSubview:date_Lbl];
            [hlcell.contentView addSubview:time_Lbl];
            [hlcell.contentView addSubview:totalBills_Lbl];
            [hlcell.contentView addSubview:cashTotal_Lbl];
            [hlcell.contentView addSubview:cardTotal_Lbl];
            [hlcell.contentView addSubview:returnedAmt_Lbl];
            [hlcell.contentView addSubview:exchangeAmt_lbl];
            [hlcell.contentView addSubview:sodexoTotal_Lbl];
            [hlcell.contentView addSubview:ticketTotal_Lbl];
            [hlcell.contentView addSubview:loyaltyTotal_Lbl];
            [hlcell.contentView addSubview:creditNote_Lbl];
            [hlcell.contentView addSubview:giftVouchers_Lbl];
            [hlcell.contentView addSubview:coupons_Lbl];
            [hlcell.contentView addSubview:Total_Lbl];


            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                slno_Lbl.frame = CGRectMake(0,0,slnoLbl.frame.size.width,hlcell.frame.size.height);
                date_Lbl.frame = CGRectMake(dateLbl.frame.origin.x,0,dateLbl.frame.size.width,hlcell.frame.size.height);
                time_Lbl.frame = CGRectMake(timeLbl.frame.origin.x,0,timeLbl.frame.size.width,hlcell.frame.size.height);
                
                totalBills_Lbl.frame = CGRectMake(totalBillsLbl.frame.origin.x,0,totalBillsLbl.frame.size.width,hlcell.frame.size.height);
                
                cashTotal_Lbl.frame = CGRectMake(cashTotalLbl.frame.origin.x,0,cashTotalLbl.frame.size.width,hlcell.frame.size.height);
                cardTotal_Lbl.frame = CGRectMake(cardTotalLbl.frame.origin.x,0,cardTotalLbl.frame.size.width,hlcell.frame.size.height);

                returnedAmt_Lbl.frame = CGRectMake(returnedAmtLbl.frame.origin.x,0,returnedAmtLbl.frame.size.width,hlcell.frame.size.height);
                
                exchangeAmt_lbl.frame = CGRectMake(exchangeAmtLbl.frame.origin.x,0,exchangeAmtLbl.frame.size.width,hlcell.frame.size.height);

                sodexoTotal_Lbl.frame = CGRectMake(sodexoTotalLbl.frame.origin.x,0,sodexoTotalLbl.frame.size.width,hlcell.frame.size.height);
                
                ticketTotal_Lbl.frame = CGRectMake(ticketTotalLbl.frame.origin.x,0,ticketTotalLbl.frame.size.width,hlcell.frame.size.height);
                
                
                loyaltyTotal_Lbl.frame = CGRectMake(loyaltyTotalLbl.frame.origin.x,0,loyaltyTotalLbl.frame.size.width,hlcell.frame.size.height);

                creditNote_Lbl.frame = CGRectMake(creditNoteLbl.frame.origin.x,0,creditNoteLbl.frame.size.width,hlcell.frame.size.height);

                giftVouchers_Lbl.frame = CGRectMake(giftVouchersLbl.frame.origin.x,0,giftVouchersLbl.frame.size.width,hlcell.frame.size.height);
                
                coupons_Lbl.frame = CGRectMake(couponsLbl.frame.origin.x,0,couponsLbl.frame.size.width,hlcell.frame.size.height);

                Total_Lbl.frame = CGRectMake(totalCostLbl.frame.origin.x,0,totalCostLbl.frame.size.width,hlcell.frame.size.height);
                
                //added by Srinivasulu on 09/11/2017....
                
                averageQuantityLbl_Lbl.frame = CGRectMake( averageQuantityLbl.frame.origin.x, 0, averageQuantityLbl.frame.size.width, hlcell.frame.size.height);
                averageValue_Lbl.frame = CGRectMake( averageValueLbl.frame.origin.x, 0, averageValueLbl.frame.size.width, hlcell.frame.size.height);

                //upto here on 09/11/2017....
                
                
                
                
                  }
            else{
                
                //Code For the iPhone
            }

            //setting font size....
            [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:15.0f cornerRadius:0.0];

                 //appending values based on the service data...
            
            if (hourWiseReportArr.count >= indexPath.row && hourWiseReportArr.count) {
                    
                    NSDictionary * dic  = hourWiseReportArr[indexPath.row];
                    
                    slno_Lbl.text = [NSString stringWithFormat:@"%d",(int)(indexPath.row+1)];
                   
                    date_Lbl.text = [self checkGivenValueIsNullOrNil:[[dic valueForKey:DATE_STR] componentsSeparatedByString:@" "][0]  defaultReturn:@"--"];

                float timeValue = 0.0;
                
                timeValue = [[self checkGivenValueIsNullOrNil:[dic valueForKey:HOUR] defaultReturn:@""]floatValue];
                
                time_Lbl.text = [NSString stringWithFormat:@"%.f%@%.f",timeValue,@"-", timeValue == 24? 00:(timeValue + 1)];

//                timeValue == 24? 00:(timeValue + 1);
                
                
                    totalBills_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:BILL_COUNT] defaultReturn:@"0.00"] floatValue]];

                    cashTotal_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:CASHTOTAL] defaultReturn:@"0.00"] floatValue]];

                    cardTotal_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:CARDTOTAL] defaultReturn:@"0.00"] floatValue]];
                    
                    returnedAmt_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:RETURN_AMT] defaultReturn:@"0.00"] floatValue]];

                    exchangeAmt_lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:EXCHANGE_AMT] defaultReturn:@"0.00"] floatValue]];
                   
                    sodexoTotal_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:@"sodexoTotal"] defaultReturn:@"0.00"] floatValue]];
                   
                    ticketTotal_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:TICKETTOTAL] defaultReturn:@"0.00"] floatValue]];

                    loyaltyTotal_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:LOYALTY_TOTAL] defaultReturn:@"0.00"] floatValue]];

                    creditNote_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:CREDIT_NOTE_TOTAL] defaultReturn:@"0.00"] floatValue]];
                  
                    giftVouchers_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:GIFTVOUCHERS_TOTAL] defaultReturn:@"0.00"] floatValue]];

                    coupons_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:COUPONS_TOTAL] defaultReturn:@"0.00"] floatValue]];

                    coupons_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:COUPONS_TOTAL] defaultReturn:@"0.00"] floatValue]];
                    
                    Total_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:OVER_ALL_CASH_TOTAL] defaultReturn:@"0.00"] floatValue]];
                
                
                //added by Srinivasulu on 09/11/2017....
                
                averageQuantityLbl_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:AVG_BIL_QTY] defaultReturn:@"0.00"] doubleValue]];

                averageValue_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:AVG_BIL_VALUE] defaultReturn:@"0.00"] doubleValue]];
                
                //upto here on 09/11/2017....
                
                }
                
                else{
                    slno_Lbl.text = @"--";
                    date_Lbl.text = @"--";
                    time_Lbl.text = @"--";
                    totalBills_Lbl.text = @"--";
                    cashTotal_Lbl.text = @"--";
                    cardTotal_Lbl.text = @"--";
                    returnedAmt_Lbl.text = @"--";
                    exchangeAmt_lbl.text = @"--";
                    sodexoTotal_Lbl.text = @"--";
                    ticketTotal_Lbl.text = @"--";
                    loyaltyTotal_Lbl.text = @"--";
                    creditNote_Lbl.text = @"--";
                    giftVouchers_Lbl.text = @"--";
                    coupons_Lbl.text = @"--";
                    Total_Lbl.text = @"--";

                    averageQuantityLbl_Lbl.text = @"--";
                    averageValue_Lbl.text = @"--";
                }
            
        } @catch (NSException *exception) {
            
        } @finally {
            
            hlcell.backgroundColor = [UIColor clearColor];
            hlcell.tag = indexPath.row;
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            return hlcell;
        }
    }
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    @try {
        
        if(tableView == hourReportTable){
            
            @try {
                
                if ((indexPath.row == (hourWiseReportArr.count-1)) && (hourWiseReportArr.count < totalNumberOfReports) && (hourWiseReportArr.count> startIndexInt)) {
                    
                    [HUD show:YES];
                    [HUD setHidden:NO];
                    startIndexInt = startIndexInt +10;
                    [self getHourWiseReports];
//                    [hourReportTable reloadData];
                }
                
            } @catch (NSException * exception) {
                NSLog(@"-----------exception in servicecall-------------%@",exception);
                [HUD setHidden:YES];
            }
        }
    } @catch (NSException *exception) {
        
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
