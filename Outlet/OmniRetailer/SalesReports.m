//
//  OrderReports.m
//  OmniRetailer
//
//  Created by Bangaru.Raju on 11/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SalesReports.h"
#import "Global.h"
//#import "SalesReportsSvc.h"
#import "OmniHomePage.h"
#import "RequestHeader.h"

//#import "SDZSalesService.h"

#import "SalesServiceSvc.h"

//static NSArray* item2 =nil;
int changeID = 0;

@implementation SalesReports

@synthesize fromOrder,toOrder,bill,salesTableView;
@synthesize soundFileURLRef,soundFileObject;

int reportStartIndex = 0;
int totalRecordsInt = 0;

/**
 * @description
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

    // Releases the view if it doesn't have a superview.
      [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle
/**
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date         11/08/2017
 * @method       ViewDidLoad
 * @author       Bhargav Ram
 * @param
 * @param
 * @return
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 *
 */
- (void)viewDidLoad{
    //calling super method....
    [super viewDidLoad];

    //reading the DeviceVersion....
    version = [UIDevice currentDevice].systemVersion.floatValue;

    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
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

//     Show the HUD
    [HUD show:YES];
    [HUD setHidden:NO];
    
    //allocation of DateWise ReportView....
    dateWiseReportView = [[UIView alloc]init];
    
    /*Creation of UILabel for headerDisplay.......*/
    //creating line  UILabel which will display at topOfThe  billingView.......
    
    UILabel  * headerNameLbl;
    CALayer  * bottomBorder;
    
    UIButton * counterBtn;
    UIButton * salesPersonBtn;
    
    UIButton * startDteBtn;
    UIButton * endDteBtn;
    UIImage  * calendarImg;
    UIImage  * dropDownImg;
     //Allocation of startDteImg
    calendarImg  = [UIImage imageNamed:@"Calandar_Icon.png"];
    dropDownImg  = [UIImage imageNamed:@"arrow_1.png"];
    
    
    headerNameLbl = [[UILabel alloc] init];
    headerNameLbl.layer.cornerRadius = 10.0f;
    headerNameLbl.layer.masksToBounds = YES;
    headerNameLbl.textAlignment = NSTextAlignmentCenter;
    headerNameLbl.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
    headerNameLbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gradient.png"]];
    
    //it is regard's to the view borderwidth and color setting....
    bottomBorder = [CALayer layer];
    bottomBorder.opacity = 5.0f;
    bottomBorder.backgroundColor = [UIColor grayColor].CGColor;
    bottomBorder.frame = CGRectMake(0.0f, 60.0f, headerNameLbl.frame.size.width, 1.0f);
    [headerNameLbl.layer addSublayer:bottomBorder];
    
    
    //Allocation of counterIDTxt
    counterIDTxt = [[CustomTextField alloc] init];
    counterIDTxt.delegate = self;
    counterIDTxt.userInteractionEnabled  = NO;
    counterIDTxt.placeholder = NSLocalizedString(@"Counter ID",nil);
    [counterIDTxt awakeFromNib];

    //Allocation of counterIDTxt
    salesPersonTxt = [[CustomTextField alloc] init];
    salesPersonTxt.delegate = self;
    salesPersonTxt.userInteractionEnabled  = NO;
    salesPersonTxt.placeholder = NSLocalizedString(@"Sales Person",nil);
    [salesPersonTxt awakeFromNib];
    
    //Allocation of startDateTxt
    startDateTxt = [[CustomTextField alloc] init];
    startDateTxt.delegate = self;
    startDateTxt.userInteractionEnabled  = NO;
    startDateTxt.placeholder = NSLocalizedString(@"start_date",nil);
    [startDateTxt awakeFromNib];
    
    //Allocation of endDateTxt
    endDateTxt = [[CustomTextField alloc] init];
    endDateTxt.delegate = self;
    endDateTxt.userInteractionEnabled  = NO;
    endDateTxt.placeholder = NSLocalizedString(@"end_date",nil);
    [endDateTxt awakeFromNib];
    
    
    //Allocation of counterBtn
    counterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [counterBtn setBackgroundImage:dropDownImg forState:UIControlStateNormal];
    [counterBtn addTarget:self
                    action:@selector(showCounterList:) forControlEvents:UIControlEventTouchDown];

    //Allocation of salesPersonBtn
    salesPersonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [salesPersonBtn setBackgroundImage:dropDownImg forState:UIControlStateNormal];
    [salesPersonBtn addTarget:self
                   action:@selector(showSalesPersonID:) forControlEvents:UIControlEventTouchDown];
    
    //Allocation of startDteBtn
   
    startDteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startDteBtn setBackgroundImage:calendarImg forState:UIControlStateNormal];
    [startDteBtn addTarget:self
                    action:@selector(DateButtonPressed:) forControlEvents:UIControlEventTouchDown];
    
    //Allocation of endDteBtn
    endDteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [endDteBtn setBackgroundImage:calendarImg forState:UIControlStateNormal];
    [endDteBtn addTarget:self
                  action:@selector(DateButtonPressed:) forControlEvents:UIControlEventTouchDown];
    
    //used for identification propouse....
    startDteBtn.tag = 2;
    endDteBtn.tag = 4;
    
    //Allocation of GO Buttton:
    goButton = [[UIButton alloc] init] ;
    goButton.backgroundColor = [UIColor grayColor];
    goButton.layer.masksToBounds = YES;
    [goButton addTarget:self action:@selector(goButtonClicked:) forControlEvents:UIControlEventTouchDown];
    goButton.userInteractionEnabled = YES;
    goButton.layer.cornerRadius = 6.0f;
    goButton.titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    goButton.tag = 2;
    goButton.hidden = YES;
    
    
    //Allocation of searchBtn
    searchBtn = [[UIButton alloc] init];
    [searchBtn addTarget:self
                  action:@selector(searchTheProducts:) forControlEvents:UIControlEventTouchDown];
    searchBtn.layer.cornerRadius = 3.0f;
    searchBtn.backgroundColor = [UIColor grayColor];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchBtn.tag = 2;
    
    //Allocation of clearBtn
    
    UIButton * clearBtn;
    
    clearBtn = [[UIButton alloc] init];
    [clearBtn addTarget:self action:@selector(clearAllFilterInSearch:) forControlEvents:UIControlEventTouchDown];
    clearBtn.layer.cornerRadius = 3.0f;
    clearBtn.backgroundColor = [UIColor grayColor];
    [clearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    /** UIScrollView Design */
    scrollView = [[UIScrollView alloc] init];
    
    //scrollView.backgroundColor = [UIColor lightGrayColor];
    
    //Allocation Of CustomLabels..
    
    snoLbl = [[CustomLabel alloc] init];
    [snoLbl awakeFromNib];
    
    dateLbl = [[CustomLabel alloc] init];
    [dateLbl awakeFromNib];

    totalBillsLbl = [[CustomLabel alloc] init];
    [totalBillsLbl awakeFromNib];
    
    soldQtyLbl = [[CustomLabel alloc] init];
    [soldQtyLbl awakeFromNib];
    
    cashTotalLbl = [[CustomLabel alloc] init];
    [cashTotalLbl awakeFromNib];

    cardTotalLbl = [[CustomLabel alloc] init];
    [cardTotalLbl awakeFromNib];
    
    returnAmntLbl = [[CustomLabel alloc] init];
    [returnAmntLbl awakeFromNib];
    
    exchangeAmntLbl = [[CustomLabel alloc] init];
    [exchangeAmntLbl awakeFromNib];

    sodexoTotlLbl = [[CustomLabel alloc] init];
    [sodexoTotlLbl awakeFromNib];

    ticketTotlLbl = [[CustomLabel alloc] init];
    [ticketTotlLbl awakeFromNib];
    
    loyaltyClaimLbl = [[CustomLabel alloc] init];
    [loyaltyClaimLbl awakeFromNib];

    creditNoteLbl = [[CustomLabel alloc] init];
    [creditNoteLbl awakeFromNib];

    discountLbl = [[CustomLabel alloc] init];
    [discountLbl awakeFromNib];

    giftVouchersLbl = [[CustomLabel alloc] init];
    [giftVouchersLbl awakeFromNib];
    
    couponsLbl = [[CustomLabel alloc] init];
    [couponsLbl awakeFromNib];

    creditsAmntLbl = [[CustomLabel alloc] init];
    [creditsAmntLbl awakeFromNib];
    
    creditSalesLbl = [[CustomLabel alloc] init];
    [creditSalesLbl awakeFromNib];

    dayTurnOverLbl = [[CustomLabel alloc] init];
    [dayTurnOverLbl awakeFromNib];

    actionLbl = [[CustomLabel alloc] init];
    [actionLbl awakeFromNib];

    /** Create TableView */
    salesTableView = [[UITableView alloc]init];
    salesTableView.backgroundColor = [UIColor blackColor];
    salesTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    salesTableView.dataSource = self;
    salesTableView.delegate = self;
    salesTableView.bounces = TRUE;
    salesTableView.separatorColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2f];
    
    
    //sectionTbl creation...
    counterIDTbl = [[UITableView alloc] init];
    counterIDTbl.layer.borderWidth = 1.0;
    counterIDTbl.layer.cornerRadius = 4.0;
    counterIDTbl.layer.borderColor = [UIColor blackColor].CGColor;
    counterIDTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    counterIDTbl.dataSource = self;
    counterIDTbl.delegate = self;
    
    
    //sectionTbl creation...
    salesPersonIdTbl = [[UITableView alloc] init];
    salesPersonIdTbl.layer.borderWidth = 1.0;
    salesPersonIdTbl.layer.cornerRadius = 4.0;
    salesPersonIdTbl.layer.borderColor = [UIColor blackColor].CGColor;
    salesPersonIdTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    salesPersonIdTbl.dataSource = self;
    salesPersonIdTbl.delegate = self;

    //Recently Added Labels For displaying the total of stock quantity
    
    soldQtyValueLbl = [[UILabel alloc] init];
    soldQtyValueLbl.layer.cornerRadius = 5;
    soldQtyValueLbl.layer.masksToBounds = YES;
    soldQtyValueLbl.backgroundColor = [UIColor blackColor];
    soldQtyValueLbl.layer.borderWidth = 2.0f;
    soldQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    soldQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
   
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

   
    exchangeAmtValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    exchangeAmtValueLbl = [[UILabel alloc] init];
    exchangeAmtValueLbl.layer.cornerRadius = 5;
    exchangeAmtValueLbl.layer.masksToBounds = YES;
    exchangeAmtValueLbl.backgroundColor = [UIColor blackColor];
    exchangeAmtValueLbl.layer.borderWidth = 2.0f;
    exchangeAmtValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    exchangeAmtValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

    sodexoAmtvalueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    sodexoAmtvalueLbl = [[UILabel alloc] init];
    sodexoAmtvalueLbl.layer.cornerRadius = 5;
    sodexoAmtvalueLbl.layer.masksToBounds = YES;
    sodexoAmtvalueLbl.backgroundColor = [UIColor blackColor];
    sodexoAmtvalueLbl.layer.borderWidth = 2.0f;
    sodexoAmtvalueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    sodexoAmtvalueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    
    ticketTotalValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    ticketTotalValueLbl = [[UILabel alloc] init];
    ticketTotalValueLbl.layer.cornerRadius = 5;
    ticketTotalValueLbl.layer.masksToBounds = YES;
    ticketTotalValueLbl.backgroundColor = [UIColor blackColor];
    ticketTotalValueLbl.layer.borderWidth = 2.0f;
    ticketTotalValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    ticketTotalValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    loyaltyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    loyaltyValueLbl = [[UILabel alloc] init];
    loyaltyValueLbl.layer.cornerRadius = 5;
    loyaltyValueLbl.layer.masksToBounds = YES;
    loyaltyValueLbl.backgroundColor = [UIColor blackColor];
    loyaltyValueLbl.layer.borderWidth = 2.0f;
    loyaltyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    loyaltyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

    creditNoteValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    creditNoteValueLbl = [[UILabel alloc] init];
    creditNoteValueLbl.layer.cornerRadius = 5;
    creditNoteValueLbl.layer.masksToBounds = YES;
    creditNoteValueLbl.backgroundColor = [UIColor blackColor];
    creditNoteValueLbl.layer.borderWidth = 2.0f;
    creditNoteValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    creditNoteValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

    
    discountValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    discountValueLbl = [[UILabel alloc] init];
    discountValueLbl.layer.cornerRadius = 5;
    discountValueLbl.layer.masksToBounds = YES;
    discountValueLbl.backgroundColor = [UIColor blackColor];
    discountValueLbl.layer.borderWidth = 2.0f;
    discountValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    discountValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

    giftVouchersValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    giftVouchersValueLbl = [[UILabel alloc] init];
    giftVouchersValueLbl.layer.cornerRadius = 5;
    giftVouchersValueLbl.layer.masksToBounds = YES;
    giftVouchersValueLbl.backgroundColor = [UIColor blackColor];
    giftVouchersValueLbl.layer.borderWidth = 2.0f;
    giftVouchersValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    giftVouchersValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

    couponsValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    couponsValueLbl = [[UILabel alloc] init];
    couponsValueLbl.layer.cornerRadius = 5;
    couponsValueLbl.layer.masksToBounds = YES;
    couponsValueLbl.backgroundColor = [UIColor blackColor];
    couponsValueLbl.layer.borderWidth = 2.0f;
    couponsValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    couponsValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

    
    creditAmtValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    creditAmtValueLbl = [[UILabel alloc] init];
    creditAmtValueLbl.layer.cornerRadius = 5;
    creditAmtValueLbl.layer.masksToBounds = YES;
    creditAmtValueLbl.backgroundColor = [UIColor blackColor];
    creditAmtValueLbl.layer.borderWidth = 2.0f;
    creditAmtValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    creditAmtValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

    creditSalesValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    creditSalesValueLbl = [[UILabel alloc] init];
    creditSalesValueLbl.layer.cornerRadius = 5;
    creditSalesValueLbl.layer.masksToBounds = YES;
    creditSalesValueLbl.backgroundColor = [UIColor blackColor];
    creditSalesValueLbl.layer.borderWidth = 2.0f;
    creditSalesValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    creditSalesValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    
    dayTurnOverValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    dayTurnOverValueLbl = [[UILabel alloc] init];
    dayTurnOverValueLbl.layer.cornerRadius = 5;
    dayTurnOverValueLbl.layer.masksToBounds = YES;
    dayTurnOverValueLbl.backgroundColor = [UIColor blackColor];
    dayTurnOverValueLbl.layer.borderWidth = 2.0f;
    dayTurnOverValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    dayTurnOverValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

    
    soldQtyValueLbl.textAlignment     = NSTextAlignmentCenter;
    cashTotalValueLbl.textAlignment   = NSTextAlignmentCenter;
    cardTotalValueLbl.textAlignment   = NSTextAlignmentCenter;
    returnedAmtValueLbl.textAlignment = NSTextAlignmentCenter;
    exchangeAmtValueLbl.textAlignment = NSTextAlignmentCenter;
    sodexoAmtvalueLbl.textAlignment   = NSTextAlignmentCenter;
    ticketTotalValueLbl.textAlignment = NSTextAlignmentCenter;
    loyaltyValueLbl.textAlignment     = NSTextAlignmentCenter;
    creditNoteValueLbl.textAlignment  = NSTextAlignmentCenter;
    discountValueLbl.textAlignment    = NSTextAlignmentCenter;
    discountValueLbl.textAlignment    = NSTextAlignmentCenter;
    giftVouchersValueLbl.textAlignment= NSTextAlignmentCenter;
    couponsValueLbl.textAlignment     = NSTextAlignmentCenter;
    creditAmtValueLbl.textAlignment   = NSTextAlignmentCenter;
    creditSalesValueLbl.textAlignment = NSTextAlignmentCenter;
    dayTurnOverValueLbl.textAlignment = NSTextAlignmentCenter;

    
    soldQtyValueLbl.text     = @"0.0";
    cashTotalValueLbl.text   = @"0.0";
    cardTotalValueLbl.text   = @"0.0";
    returnedAmtValueLbl.text = @"0.0";
    exchangeAmtValueLbl.text = @"0.0";
    sodexoAmtvalueLbl.text   = @"0.0";
    ticketTotalValueLbl.text = @"0.0";
    loyaltyValueLbl.text     = @"0.0";
    creditNoteValueLbl.text  = @"0.0";
    discountValueLbl.text    = @"0.0";
    giftVouchersValueLbl.text= @"0.0";
    couponsValueLbl.text     = @"0.0";
    creditAmtValueLbl.text   = @"0.0";
    creditSalesValueLbl.text = @"0.0";
    dayTurnOverValueLbl.text = @"0.0";
    
    //Allocation of UIView....
    
    totalReportsView = [[UIView alloc]init];
    totalReportsView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
    totalReportsView.layer.borderWidth =3.0f;
    
    //Allocation Of UILabels to show the totalValue
    
    UILabel * totalLabel;
    
    totalLabel = [[UILabel alloc] init];
    totalLabel.layer.masksToBounds = YES;
    totalLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
    totalLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    totalReportsValueLbl = [[UILabel alloc] init];
    totalReportsValueLbl.numberOfLines = 2;
    totalReportsValueLbl.lineBreakMode = NSLineBreakByWordWrapping;
    totalReportsValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
    totalReportsValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    totalReportsValueLbl.textAlignment = NSTextAlignmentCenter;
    totalReportsValueLbl.text = @"0.0";
    
    //populating text into the textFields && labels && placeholders && buttons titles....
    @try {
        //setting the titleName for the Page....
        self.titleLabel.text = NSLocalizedString(@"omni_retailer",nil);
        HUD.labelText = NSLocalizedString(@"please_wait..",nil);
        headerNameLbl.text = NSLocalizedString(@"date_wise_report",nil);
//        [goButton setTitle:NSLocalizedString(@"go",nil) forState:UIControlStateNormal];

        //setting title label text of the UIButton's....
        [searchBtn setTitle:NSLocalizedString(@"search", nil) forState:UIControlStateNormal];
        [clearBtn setTitle:NSLocalizedString(@"clear", nil) forState:UIControlStateNormal];

        
        //Strings for the CustomLabels..
        
        snoLbl.text = NSLocalizedString(@"S_NO",nil);
        dateLbl.text = NSLocalizedString(@"date",nil);
        totalBillsLbl.text = NSLocalizedString(@"total_bills",nil);
        soldQtyLbl.text = NSLocalizedString(@"sold_qty",nil);
        cashTotalLbl.text = NSLocalizedString(@"cash_total",nil);
        cardTotalLbl.text = NSLocalizedString(@"card_total",nil);
        returnAmntLbl.text = NSLocalizedString(@"returned_amount",nil);
        exchangeAmntLbl.text = NSLocalizedString(@"exchange_amount",nil);
        sodexoTotlLbl.text = NSLocalizedString(@"sodexo_total",nil);
        ticketTotlLbl.text = NSLocalizedString(@"ticket_total",nil);
        loyaltyClaimLbl.text = NSLocalizedString(@"loyalty_claim",nil);
        creditNoteLbl.text = NSLocalizedString(@"credit_note",nil);
        discountLbl.text = NSLocalizedString(@"discount",nil);
        giftVouchersLbl.text = NSLocalizedString(@"gift_vouchers",nil);
        couponsLbl.text = NSLocalizedString(@"coupons",nil);
        creditsAmntLbl.text = NSLocalizedString(@"credit_amount",nil);
        creditSalesLbl.text = NSLocalizedString(@"credit_sales",nil);
        dayTurnOverLbl.text = NSLocalizedString(@"dayTurn_Over",nil);
        actionLbl.text = NSLocalizedString(@"action",nil);
        totalLabel.text = NSLocalizedString(@"total_reports",nil);

    }
    
    @catch(NSException * exception){
        
    }
    //Frame Design for the Category wise Report View....
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
        }
        else{
        }
        //setting for the stockReceiptView....
        dateWiseReportView.frame = CGRectMake(2,70,self.view.frame.size.width-4,self.view.frame.size.height-80);
        //seting frame for headerNameLbl....
        headerNameLbl.frame = CGRectMake(0,0,dateWiseReportView.frame.size.width,45);
        
        
        float textFieldWidth  = 180;
        float textFieldHeight = 40;
        float horizontalGap   = 20;
        float verticalGap     = 20;
        
        //Row 1...
        //frame for the start date label...
        counterIDTxt.frame = CGRectMake(dateWiseReportView.frame.origin.x+10,headerNameLbl.frame.origin.y+headerNameLbl.frame.size.height+20,textFieldWidth,textFieldHeight);
        
        salesPersonTxt.frame = CGRectMake(counterIDTxt.frame.origin.x,counterIDTxt.frame.origin.y+counterIDTxt.frame.size.height+verticalGap,textFieldWidth,textFieldHeight);
        
       //row 2....
        
        //frame for the startDateTxt....
        
        startDateTxt.frame = CGRectMake(counterIDTxt.frame.origin.x+counterIDTxt.frame.size.width+horizontalGap,counterIDTxt.frame.origin.y,textFieldWidth,textFieldHeight);
        
        endDateTxt.frame = CGRectMake(startDateTxt.frame.origin.x, startDateTxt.frame.origin.y+startDateTxt.frame.size.height+verticalGap, textFieldWidth, textFieldHeight);
        
        //Frame for the brandBtn...
        counterBtn.frame = CGRectMake((counterIDTxt.frame.origin.x+counterIDTxt.frame.size.width-45),counterIDTxt.frame.origin.y-8,55,60);

        //Frame  for the salesPersonBtn...
        salesPersonBtn.frame = CGRectMake((salesPersonTxt.frame.origin.x+salesPersonTxt.frame.size.width-45),salesPersonTxt.frame.origin.y-8,55,60);

        //Frame for the startDteBtn
        startDteBtn.frame = CGRectMake((startDateTxt.frame.origin.x+startDateTxt.frame.size.width-45), startDateTxt.frame.origin.y+2, 40, 35);
        
        //Frame for the endDteBtn
        endDteBtn.frame = CGRectMake((endDateTxt.frame.origin.x+endDateTxt.frame.size.width-45),endDateTxt.frame.origin.y+2,40,35);
        
        //Frame for the Go Button..
        searchBtn.frame =CGRectMake(startDateTxt.frame.origin.x+startDateTxt.frame.size.width+horizontalGap,startDateTxt.frame.origin.y,140,45);
        
        clearBtn.frame = CGRectMake(searchBtn.frame.origin.x, endDateTxt.frame.origin.y,searchBtn.frame.size.width, searchBtn.frame.size.height);
        
        scrollView.frame = CGRectMake(10,salesPersonTxt.frame.origin.y+salesPersonTxt.frame.size.height+20,dateWiseReportView.frame.size.width+150,500);
        
        //frames for the custom Labels...
        snoLbl.frame = CGRectMake(0,0,60,40);
        dateLbl.frame = CGRectMake(snoLbl.frame.origin.x+snoLbl.frame.size.width+2,snoLbl.frame.origin.y,100,snoLbl.frame.size.height);
        totalBillsLbl.frame = CGRectMake(dateLbl.frame.origin.x+dateLbl.frame.size.width+2,snoLbl.frame.origin.y,100,snoLbl.frame.size.height);
        
        soldQtyLbl.frame = CGRectMake(totalBillsLbl.frame.origin.x+totalBillsLbl.frame.size.width+2,snoLbl.frame.origin.y,100,snoLbl.frame.size.height);
        
        cashTotalLbl.frame = CGRectMake(soldQtyLbl.frame.origin.x+soldQtyLbl.frame.size.width+2,snoLbl.frame.origin.y,100,snoLbl.frame.size.height);

        cardTotalLbl.frame = CGRectMake(cashTotalLbl.frame.origin.x+cashTotalLbl.frame.size.width+2,snoLbl.frame.origin.y,100,snoLbl.frame.size.height);
        
        returnAmntLbl.frame = CGRectMake(cardTotalLbl.frame.origin.x+cardTotalLbl.frame.size.width+2,snoLbl.frame.origin.y,120,snoLbl.frame.size.height);
        
        exchangeAmntLbl.frame = CGRectMake(returnAmntLbl.frame.origin.x+returnAmntLbl.frame.size.width+2,snoLbl.frame.origin.y,120,snoLbl.frame.size.height);

        sodexoTotlLbl.frame = CGRectMake(exchangeAmntLbl.frame.origin.x+exchangeAmntLbl.frame.size.width+2,snoLbl.frame.origin.y,100,snoLbl.frame.size.height);
        
        ticketTotlLbl.frame = CGRectMake(sodexoTotlLbl.frame.origin.x+sodexoTotlLbl.frame.size.width+2,snoLbl.frame.origin.y,100,snoLbl.frame.size.height);

        loyaltyClaimLbl.frame = CGRectMake(ticketTotlLbl.frame.origin.x+ticketTotlLbl.frame.size.width+2,snoLbl.frame.origin.y,120,snoLbl.frame.size.height);
        
        creditNoteLbl.frame = CGRectMake(loyaltyClaimLbl.frame.origin.x+loyaltyClaimLbl.frame.size.width+2,snoLbl.frame.origin.y,100,snoLbl.frame.size.height);

        discountLbl.frame = CGRectMake(creditNoteLbl.frame.origin.x+creditNoteLbl.frame.size.width+2,snoLbl.frame.origin.y,100,snoLbl.frame.size.height);

        giftVouchersLbl.frame = CGRectMake(discountLbl.frame.origin.x+discountLbl.frame.size.width+2,snoLbl.frame.origin.y,120,snoLbl.frame.size.height);

        couponsLbl.frame = CGRectMake(giftVouchersLbl.frame.origin.x+giftVouchersLbl.frame.size.width+2,snoLbl.frame.origin.y,100,snoLbl.frame.size.height);

        creditsAmntLbl.frame = CGRectMake(couponsLbl.frame.origin.x+couponsLbl.frame.size.width+2,snoLbl.frame.origin.y,100,snoLbl.frame.size.height);
        
        creditSalesLbl.frame = CGRectMake(creditsAmntLbl.frame.origin.x+creditsAmntLbl.frame.size.width+2,snoLbl.frame.origin.y,100,snoLbl.frame.size.height);
        
        dayTurnOverLbl.frame = CGRectMake(creditSalesLbl.frame.origin.x+creditSalesLbl.frame.size.width+2,snoLbl.frame.origin.y,120,snoLbl.frame.size.height);
        
        actionLbl.frame = CGRectMake(dayTurnOverLbl.frame.origin.x+dayTurnOverLbl.frame.size.width+2,snoLbl.frame.origin.y,100,snoLbl.frame.size.height);

        
        salesTableView.frame = CGRectMake(snoLbl.frame.origin.x,snoLbl.frame.origin.y+snoLbl.frame.size.height + 10,actionLbl.frame.origin.x+actionLbl.frame.size.width-snoLbl.frame.origin.x,scrollView.frame.size.height-100);
        
        scrollView.contentSize = CGSizeMake(salesTableView.frame.size.width+170,scrollView.frame.size.height);

        //frames for the total  value
        
        soldQtyValueLbl.frame = CGRectMake(soldQtyLbl.frame.origin.x,salesTableView.frame.origin.y+salesTableView.frame.size.height+10,soldQtyLbl.frame.size.width,40);
       
        cashTotalValueLbl.frame = CGRectMake(cashTotalLbl.frame.origin.x,soldQtyValueLbl.frame.origin.y,cashTotalLbl.frame.size.width,40);
        
        cardTotalValueLbl.frame = CGRectMake(cardTotalLbl.frame.origin.x,soldQtyValueLbl.frame.origin.y,cardTotalLbl.frame.size.width,40);

        returnedAmtValueLbl.frame = CGRectMake(returnAmntLbl.frame.origin.x,soldQtyValueLbl.frame.origin.y,returnAmntLbl.frame.size.width,40);

        exchangeAmtValueLbl.frame = CGRectMake(exchangeAmntLbl.frame.origin.x,soldQtyValueLbl.frame.origin.y,exchangeAmntLbl.frame.size.width,40);

        sodexoAmtvalueLbl.frame = CGRectMake(sodexoTotlLbl.frame.origin.x,soldQtyValueLbl.frame.origin.y,sodexoTotlLbl.frame.size.width,40);

        ticketTotalValueLbl.frame = CGRectMake(ticketTotlLbl.frame.origin.x,soldQtyValueLbl.frame.origin.y,ticketTotlLbl.frame.size.width,40);
        
        loyaltyValueLbl.frame = CGRectMake(loyaltyClaimLbl.frame.origin.x,soldQtyValueLbl.frame.origin.y,loyaltyClaimLbl.frame.size.width,40);

        creditNoteValueLbl.frame = CGRectMake(creditNoteLbl.frame.origin.x,soldQtyValueLbl.frame.origin.y,creditNoteLbl.frame.size.width,40);

        discountValueLbl.frame = CGRectMake(discountLbl.frame.origin.x,soldQtyValueLbl.frame.origin.y,discountLbl.frame.size.width,40);

        giftVouchersValueLbl.frame = CGRectMake(giftVouchersLbl.frame.origin.x,soldQtyValueLbl.frame.origin.y,giftVouchersLbl.frame.size.width,40);

        couponsValueLbl.frame = CGRectMake(couponsLbl.frame.origin.x,soldQtyValueLbl.frame.origin.y,couponsLbl.frame.size.width,40);
        
        creditAmtValueLbl.frame = CGRectMake(creditsAmntLbl.frame.origin.x,soldQtyValueLbl.frame.origin.y,creditsAmntLbl.frame.size.width,40);

        creditSalesValueLbl.frame = CGRectMake(creditSalesLbl.frame.origin.x,soldQtyValueLbl.frame.origin.y,creditSalesLbl.frame.size.width,40);

        dayTurnOverValueLbl.frame = CGRectMake(dayTurnOverLbl.frame.origin.x,soldQtyValueLbl.frame.origin.y,dayTurnOverLbl.frame.size.width,40);

        totalReportsView.frame = CGRectMake(scrollView.frame.origin.x,scrollView.frame.origin.y+scrollView.frame.size.height,totalBillsLbl.frame.origin.x+totalBillsLbl.frame.size.width -(snoLbl.frame.origin.x),dayTurnOverLbl.frame.size.height);
        
        totalLabel.frame = CGRectMake(10,0,160,40);
        
        totalReportsValueLbl.frame = CGRectMake(totalLabel.frame.origin.x+totalLabel.frame.size.width,totalLabel.frame.origin.y,totalBillsLbl.frame.size.width,totalLabel.frame.size.height);
        
    }
    
    [dateWiseReportView addSubview:headerNameLbl];
    [dateWiseReportView addSubview:startDateTxt];
    [dateWiseReportView addSubview:endDateTxt];
    
    [dateWiseReportView addSubview:counterIDTxt];
    [dateWiseReportView addSubview:salesPersonTxt];

    
    [dateWiseReportView addSubview:startDteBtn];
    [dateWiseReportView addSubview:endDteBtn];
    
    [dateWiseReportView addSubview:counterBtn];

    [dateWiseReportView addSubview:salesPersonBtn];
    
//    [dateWiseReportView addSubview:goButton];
    
    [dateWiseReportView addSubview:searchBtn];
    [dateWiseReportView addSubview:clearBtn];
    
    [dateWiseReportView addSubview:scrollView];
   
    [scrollView addSubview:snoLbl];
    [scrollView addSubview:dateLbl];
    [scrollView addSubview:totalBillsLbl];
    [scrollView addSubview:soldQtyLbl];
    [scrollView addSubview:cashTotalLbl];
    [scrollView addSubview:cardTotalLbl];
    [scrollView addSubview:returnAmntLbl];
    [scrollView addSubview:exchangeAmntLbl];
    [scrollView addSubview:sodexoTotlLbl];
    [scrollView addSubview:ticketTotlLbl];
    [scrollView addSubview:loyaltyClaimLbl];
    [scrollView addSubview:creditNoteLbl];
    [scrollView addSubview:discountLbl];
    [scrollView addSubview:giftVouchersLbl];
    [scrollView addSubview:couponsLbl];
    [scrollView addSubview:creditsAmntLbl];
    [scrollView addSubview:creditSalesLbl];
    [scrollView addSubview:dayTurnOverLbl];
    [scrollView addSubview:actionLbl];
    
    [scrollView addSubview:salesTableView];
    
    [scrollView addSubview:soldQtyValueLbl];
    [scrollView addSubview:cashTotalValueLbl];
    [scrollView addSubview:cardTotalValueLbl];
    [scrollView addSubview:returnedAmtValueLbl];
    [scrollView addSubview:exchangeAmtValueLbl];
    [scrollView addSubview:sodexoAmtvalueLbl];
    [scrollView addSubview:ticketTotalValueLbl];
    [scrollView addSubview:loyaltyValueLbl];
    [scrollView addSubview:creditNoteValueLbl];
    [scrollView addSubview:discountValueLbl];
    [scrollView addSubview:giftVouchersValueLbl];
    [scrollView addSubview:couponsValueLbl];
    [scrollView addSubview:creditAmtValueLbl];
    [scrollView addSubview:creditSalesValueLbl];
    [scrollView addSubview:dayTurnOverValueLbl];
    
//    [dateWiseReportView addSubview:totalReportsView];
//    [totalReportsView addSubview:totalLabel];
//    [totalReportsView addSubview:totalReportsValueLbl];

    [self.view addSubview:dateWiseReportView];
    
    //Setting font for the UI Elements added under self.view...
    @try {
        [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:16.0f cornerRadius:0];
        headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
        
        searchBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        clearBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        
    } @catch (NSException *exception) {
        
    }
}


/**
 * @description  it is one of ViewLifeCylce Method which will be executed after execution of
 viewDidLoad.......
 * @date         07/08/2017...
 * @method       viewDidAppear
 * @author       Bhargav Ram
 * @param        BOOL
 * @param
 * @return
 *
 * @modified BY
 * @reason
 * * @return
 * @verified By
 * @verified On
 *
 */

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
//    dateWiseArr = [[NSMutableArray alloc] init];
    reportStartIndex=0;
    [self callingSalesServiceforRecords];
}



/**
 * @description  we are calling the service to get the reports from  database...
 * @date         10/08/2017
 * @method       callingSalesServiceforRecords
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

// Commented by roja on 17/10/2019.. // reason :- callingSalesServiceforRecords method contains SOAP Service call .. so taken new method with same name(callingSalesServiceforRecords) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//-(void)callingSalesServiceforRecords{
//    NSDate *today = [NSDate date];
//    NSDateFormatter *f = [[NSDateFormatter alloc] init];
//    f.dateFormat = @"dd/MM/yyyy";
//    NSString* currentdate = [f stringFromDate:today];
//
//    if ((startDateTxt.text).length>0) {
//
//        currentdate = [startDateTxt.text copy];
//    }
//
//    if(reportStartIndex == 0 && dateWiseArr == nil)
//    dateWiseArr  = [NSMutableArray new];
//    else if(reportStartIndex == 0 && dateWiseArr.count)
//           [ dateWiseArr removeAllObjects];
//
//
//    if (!isOfflineService) {
//        @try {
//
//            [HUD setHidden:NO];
//
//            NSMutableDictionary * reports = [[NSMutableDictionary alloc]init];
//            reports[@"date"] = currentdate;
//            reports[@"startDate"] = startDateTxt.text;
//            reports[@"endDate"] = endDateTxt.text;
//            reports[@"shiftId"] = shiftId;
//            reports[@"paymentMode"] = @"";
//            reports[@"store_location"] = presentLocation;
//            reports[@"searchCriteria"] = @"date";
//            reports[@"counterId"] = counterIDTxt.text;
//            reports[@"requiredRecords"] = [NSString stringWithFormat:@"%d",10];
//            reports[@"startIndex"] = [NSString stringWithFormat:@"%d",reportStartIndex];
//            reports[@"requestHeader"] = [RequestHeader getRequestHeader];
//
//            NSError * err;
//            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reports options:0 error:&err];
//            NSString * reportsJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//            SalesServiceSvcSoapBinding * salesBindng =  [SalesServiceSvc SalesServiceSvcSoapBinding];
//            SalesServiceSvc_getSalesReports * aParameters =  [[SalesServiceSvc_getSalesReports alloc] init];
//
//            aParameters.searchCriteria = reportsJsonString;
//            SalesServiceSvcSoapBindingResponse * response = [salesBindng getSalesReportsUsingParameters:aParameters];
//
//            NSArray * responseBodyParts = response.bodyParts;
//
//            for (id bodyPart in responseBodyParts) {
//                if ([bodyPart isKindOfClass:[SalesServiceSvc_getSalesReportsResponse class]]) {
//                    SalesServiceSvc_getSalesReportsResponse *body = (SalesServiceSvc_getSalesReportsResponse *)bodyPart;
//                    printf("\nresponse=%s",(body.return_).UTF8String);
//
//                    // removing hud ..
//                    // [HUD hide:YES afterDelay:0.5];
//
//                    NSError *e;
//                    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                         options: NSJSONReadingMutableContainers
//                         error: &e];
//
//                    if (![body.return_ isKindOfClass:[NSNull class]]) {
//
//                        [HUD setHidden:YES];
//
//
//                        NSDictionary  * json1 = JSON[RESPONSE_HEADER];
//
//                        if ([json1[RESPONSE_CODE]intValue] == 0) {
//
//                            totalRecordsInt = [[JSON valueForKey:TOTAL_BILLS] intValue];
//
//                            if ([[JSON valueForKey:REPORT_LIST] count] > 0) {
//
//                                if (![[JSON valueForKey:REPORT_SUMMARY] isKindOfClass:[NSNull class]]) {
//
//                                    NSDictionary * summaryDic = [JSON valueForKey:REPORT_SUMMARY];
//
//                                    soldQtyValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:FINALSOLD_QTY] defaultReturn:@"0.00"] floatValue]];
//
//                                    cashTotalValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:FINAL_CASH] defaultReturn:@"0.00"] floatValue]];
//
//
//                                    cardTotalValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:FINAL_CARD] defaultReturn:@"0.00"] floatValue]];
//
//
//                                    returnedAmtValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:FINALRETURNED_AMNT] defaultReturn:@"0.00"] floatValue]];
//
//                                    exchangeAmtValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:FINALEXCHANGE_AMNT] defaultReturn:@"0.00"] floatValue]];
//
//                                    sodexoAmtvalueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:FINAL_SODEXO] defaultReturn:@"0.00"] floatValue]];
//
//                                    ticketTotalValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:FINAL_TICKET] defaultReturn:@"0.00"] floatValue]];
//
//                                    loyaltyValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:FINAL_LOYALTY] defaultReturn:@"0.00"] floatValue]];
//
//                                    creditNoteValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:FINALCREDIT_AMT] defaultReturn:@"0.00"] floatValue]];
//
//                                    discountValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:FINAL_DISCOUNT] defaultReturn:@"0.00"] floatValue]];
//
//                                    giftVouchersValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:FINALVOUCHERS_AMT] defaultReturn:@"0.00"] floatValue]];
//
//
//                                    couponsValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:FINALCOUPONS_AMT] defaultReturn:@"0.00"] floatValue]];
//
//
//                                    creditAmtValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:FINALCREDITS_AMT] defaultReturn:@"0.00"] floatValue]];
//
//                                    creditSalesValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:FINALCREDITBILL_AMT] defaultReturn:@"0.00"] floatValue]];
//
//                                    dayTurnOverValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:FINALDAYTURNOVER_AMT] defaultReturn:@"0.00"] floatValue]];
//
//                                    totalReportsValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[JSON valueForKey:TOTAL_BILLS] defaultReturn:@"0.00"] floatValue]];
//                                }
//                                [dateWiseArr addObjectsFromArray:[JSON valueForKey:REPORT_LIST]];
//                            }
//                            else {
//                                [self displayAlertMessage:NSLocalizedString(@"Sales reports not available", nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height-150  msgType:NSLocalizedString(@"warning", nil) conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
//                            }
//
//                            [HUD setHidden:YES];
//                            [salesTableView reloadData];
//                        }
//                        else{
//
//                            [self displayAlertMessage:NSLocalizedString(@"no_records_found",nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height-150  msgType:NSLocalizedString(@"warning", nil) conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
//
//
//                            soldQtyValueLbl.text     = @"0.0";
//                            cashTotalValueLbl.text   = @"0.0";
//                            cardTotalValueLbl.text   = @"0.0";
//                            returnedAmtValueLbl.text = @"0.0";
//                            exchangeAmtValueLbl.text = @"0.0";
//                            sodexoAmtvalueLbl.text   = @"0.0";
//                            ticketTotalValueLbl.text = @"0.0";
//                            loyaltyValueLbl.text     = @"0.0";
//                            creditNoteValueLbl.text  = @"0.0";
//                            discountValueLbl.text    = @"0.0";
//                            giftVouchersValueLbl.text= @"0.0";
//                            couponsValueLbl.text     = @"0.0";
//                            creditAmtValueLbl.text   = @"0.0";
//                            creditSalesValueLbl.text = @"0.0";
//                            dayTurnOverValueLbl.text = @"0.0";
//
//                            startDateTxt.text = @"";
//                            endDateTxt.text   = @"";
//                        }
//                    }
//                    else {
//                        [HUD setHidden:YES];
//                        [self displayAlertMessage:NSLocalizedString(@"failed to get the reports",nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height-150  msgType:NSLocalizedString(@"warning", nil) conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
//                    }
//                }
//
//                else{
//                    [HUD setHidden:YES];
//                    [self displayAlertMessage:NSLocalizedString(@"failed to get the reports",nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height-150  msgType:NSLocalizedString(@"warning", nil) conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
//                }
//
//            }
//
//            [salesTableView reloadData];
//
//        }
//        @catch (NSException * exception) {
//
//            [HUD setHidden:YES];
//            [self displayAlertMessage:NSLocalizedString(@"failed to get the reports",nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height-150  msgType:NSLocalizedString(@"warning", nil) conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
//        }
//    }
//    else {
//        currentdate = [currentdate componentsSeparatedByString:@" "][0];
//        OfflineBillingServices *offline = [[OfflineBillingServices alloc]init];
//        NSMutableArray *result = [offline getCompletedBills:@"" fromDate:currentdate];
//        dateWiseArr = [[NSMutableArray alloc] initWithArray:result];
//        if (dateWiseArr.count == 0){
//
//            [self displayAlertMessage:NSLocalizedString(@"no_records_found",nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height-150  msgType:NSLocalizedString(@"warning", nil) conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
//
//            startDateTxt.text = @"";
//            endDateTxt.text   = @"";
//
//        }
//        [HUD setHidden:YES];
//        [salesTableView reloadData];
//    }
//}



//callingSalesServiceforRecords method changed by roja on 17/10/2019.. // reason : removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST
-(void)callingSalesServiceforRecords{
    
    NSDate *today = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"dd/MM/yyyy";
    NSString* currentdate = [f stringFromDate:today];
    
    if ((startDateTxt.text).length>0) {
        
        currentdate = [startDateTxt.text copy];
    }
    
    if(reportStartIndex == 0 && dateWiseArr == nil)
        dateWiseArr  = [NSMutableArray new];
    else if(reportStartIndex == 0 && dateWiseArr.count)
        [ dateWiseArr removeAllObjects];
    
    
    if (!isOfflineService) {
        
        @try {
            
            [HUD setHidden:NO];
            
            NSMutableDictionary * reports = [[NSMutableDictionary alloc]init];
            reports[@"date"] = currentdate;
            reports[@"startDate"] = startDateTxt.text;
            reports[@"endDate"] = endDateTxt.text;
            reports[@"shiftId"] = shiftId;
            reports[@"paymentMode"] = @"";
            reports[@"store_location"] = presentLocation;
            reports[@"searchCriteria"] = @"date";
            reports[@"counterId"] = counterIDTxt.text;
            reports[@"requiredRecords"] = [NSString stringWithFormat:@"%d",10];
            reports[@"startIndex"] = [NSString stringWithFormat:@"%d",reportStartIndex];
            reports[@"requestHeader"] = [RequestHeader getRequestHeader];
            
            NSError * err;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reports options:0 error:&err];
            NSString * reportsJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            WebServiceController * services =  [[WebServiceController alloc] init];
            services.salesServiceDelegate = self;
            [services getSalesReport:reportsJsonString];
            
        }
        @catch (NSException * exception) {
            
            [HUD setHidden:YES];
            [self displayAlertMessage:NSLocalizedString(@"failed to get the reports",nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height-150  msgType:NSLocalizedString(@"warning", nil) conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        }
    }
    else {
        currentdate = [currentdate componentsSeparatedByString:@" "][0];
        OfflineBillingServices *offline = [[OfflineBillingServices alloc]init];
        NSMutableArray *result = [offline getCompletedBills:@"" fromDate:currentdate];
        dateWiseArr = [[NSMutableArray alloc] initWithArray:result];
        if (dateWiseArr.count == 0){
            
            [self displayAlertMessage:NSLocalizedString(@"no_records_found",nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height-150  msgType:NSLocalizedString(@"warning", nil) conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            
            startDateTxt.text = @"";
            endDateTxt.text   = @"";
            
        }
        [HUD setHidden:YES];
        [salesTableView reloadData];
    }
}


// added by Roja on 17/10/2019….
- (void)getSalesReportsSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        
        totalRecordsInt = [[successDictionary valueForKey:TOTAL_BILLS] intValue];
        
        if ([[successDictionary valueForKey:REPORT_LIST] count] > 0) {
            
            if (![[successDictionary valueForKey:REPORT_SUMMARY] isKindOfClass:[NSNull class]]) {
                
                NSDictionary * summaryDic = [successDictionary valueForKey:REPORT_SUMMARY];
                
                soldQtyValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:FINALSOLD_QTY] defaultReturn:@"0.00"] floatValue]];
                
                cashTotalValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:FINAL_CASH] defaultReturn:@"0.00"] floatValue]];
                
                
                cardTotalValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:FINAL_CARD] defaultReturn:@"0.00"] floatValue]];
                
                
                returnedAmtValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:FINALRETURNED_AMNT] defaultReturn:@"0.00"] floatValue]];
                
                exchangeAmtValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:FINALEXCHANGE_AMNT] defaultReturn:@"0.00"] floatValue]];
                
                sodexoAmtvalueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:FINAL_SODEXO] defaultReturn:@"0.00"] floatValue]];
                
                ticketTotalValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:FINAL_TICKET] defaultReturn:@"0.00"] floatValue]];
                
                loyaltyValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:FINAL_LOYALTY] defaultReturn:@"0.00"] floatValue]];
                
                creditNoteValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:FINALCREDIT_AMT] defaultReturn:@"0.00"] floatValue]];
                
                discountValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:FINAL_DISCOUNT] defaultReturn:@"0.00"] floatValue]];
                
                giftVouchersValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:FINALVOUCHERS_AMT] defaultReturn:@"0.00"] floatValue]];
                
                
                couponsValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:FINALCOUPONS_AMT] defaultReturn:@"0.00"] floatValue]];
                
                
                creditAmtValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:FINALCREDITS_AMT] defaultReturn:@"0.00"] floatValue]];
                
                creditSalesValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:FINALCREDITBILL_AMT] defaultReturn:@"0.00"] floatValue]];
                
                dayTurnOverValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[summaryDic valueForKey:FINALDAYTURNOVER_AMT] defaultReturn:@"0.00"] floatValue]];
                
                totalReportsValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:TOTAL_BILLS] defaultReturn:@"0.00"] floatValue]];
            }
            [dateWiseArr addObjectsFromArray:[successDictionary valueForKey:REPORT_LIST]];
        }
        else {
            [self displayAlertMessage:NSLocalizedString(@"Sales reports not available", nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height-150  msgType:NSLocalizedString(@"warning", nil) conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
        [salesTableView reloadData];
    }
}

// added by Roja on 17/10/2019….
- (void)getSalesReportsErrorResponse:(NSString *)errorResponse{
    
    @try {
        
        [self displayAlertMessage:errorResponse horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height-150  msgType:NSLocalizedString(@"warning", nil) conentWidth:250 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        
        soldQtyValueLbl.text     = @"0.0";
        cashTotalValueLbl.text   = @"0.0";
        cardTotalValueLbl.text   = @"0.0";
        returnedAmtValueLbl.text = @"0.0";
        exchangeAmtValueLbl.text = @"0.0";
        sodexoAmtvalueLbl.text   = @"0.0";
        ticketTotalValueLbl.text = @"0.0";
        loyaltyValueLbl.text     = @"0.0";
        creditNoteValueLbl.text  = @"0.0";
        discountValueLbl.text    = @"0.0";
        giftVouchersValueLbl.text= @"0.0";
        couponsValueLbl.text     = @"0.0";
        creditAmtValueLbl.text   = @"0.0";
        creditSalesValueLbl.text = @"0.0";
        dayTurnOverValueLbl.text = @"0.0";
        
        startDateTxt.text = @"";
        endDateTxt.text   = @"";
    } @catch (NSException *exception) {
        
    } @finally {
        
        [HUD setHidden:YES];
        [salesTableView reloadData];
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

// Commented by roja on 17/10/2019.. // reason : getCounters method contains SOAP Service call .. so taken new method with same name(getCounters) method name which contains REST service call....
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
//                                                                     options: NSJSONReadingMutableContainers
//                                                                       error: &e];
//
//                if (![body.return_ isKindOfClass:[NSNull class]]) {
//
//                    [HUD setHidden:YES];
//
//                    for (NSDictionary * counters in [JSON valueForKey:@"counters"]) {
//
//                        if (![[counters valueForKey:@"counterName"] isKindOfClass:[NSNull class]]) {
//
//                            [couterIdArr addObject:[counters valueForKey:@"counterName"]];
//                        }
//                    }
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
        
        WebServiceController * services =  [[WebServiceController alloc] init];
        services.counterServiceDelegate = self;
        [services updateCounter:getCountersJsonString];
        
    }
    @catch (NSException * exception) {
        
    }
}


// added by Roja on 17/10/2019…. // Old code only added below...
- (void)updateCounterSuccessResponse:(NSDictionary *)successDictionary{
    
    @try {
        
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

// added by Roja on 17/10/2019…. // Old code only added below...
- (void)updateCounterErrorResponse:(NSString *)errorString{
    
    @try {
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Message" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
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
//    @try {
//
//        if(isOfflineService){
//            return;
//        }
//
//        //checking the array status and doing service call....
//        if( (employeeIdsArr == nil) && (!employeeIdsArr.count)) {
//
//            // showing the HUD ..
//            [HUD setHidden:NO];
//
//            employeeIdsArr = [NSMutableArray new];
//            //checking for deals & offers...
//            EmployeesSoapBinding *custBindng =  [EmployeesSvc EmployeesSoapBinding];
//            EmployeesSvc_getEmployees *aParameters = [[EmployeesSvc_getEmployees alloc] init];
//
//            NSArray *loyaltyKeys = @[START_INDEX,LOCATION,REQUEST_HEADER];
//
//            NSArray *loyaltyObjects = @[@"-1",presentLocation,[RequestHeader getRequestHeader]];
//            NSDictionary *dictionary_req = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
//
//            NSError * err_;
//            NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_req options:0 error:&err_];
//            NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
//            aParameters.employeeDetails = loyaltyString;
//
//
//            EmployeesSoapBindingResponse *response = [custBindng getEmployeesUsingParameters:(EmployeesSvc_getEmployees *)aParameters];
//            NSArray *responseBodyParts = response.bodyParts;
//            for (id bodyPart in responseBodyParts) {
//                if ([bodyPart isKindOfClass:[EmployeesSvc_getEmployeesResponse class]]) {
//                    EmployeesSvc_getEmployeesResponse *body = (EmployeesSvc_getEmployeesResponse *)bodyPart;
//                    //                    printf("\nresponse=%s",[body.return_ UTF8String]);
//                    NSError *e;
//
//                    NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                          options: NSJSONReadingMutableContainers
//                                                                            error: &e];
//
//                    NSDictionary *dictionary = [JSON1 valueForKey:RESPONSE_HEADER];
//                    if ([[dictionary valueForKey:RESPONSE_CODE] intValue] == 0) {
//
//                        employeeIdsArr = [[JSON1 valueForKey:kEmplyeesList] mutableCopy];
//
//                    }
//
//
//                    [HUD setHidden:YES];
//                }
//            }
//        }
//
//    } @catch (NSException *exception) {
//
//        [HUD setHidden:YES];
//
//
//    }
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
        if( (employeeIdsArr == nil) && (!employeeIdsArr.count)) {
            
            // showing the HUD ..
            [HUD setHidden:NO];
            employeeIdsArr = [NSMutableArray new];
            
            NSArray *loyaltyKeys = @[START_INDEX,LOCATION,REQUEST_HEADER];
            
            NSArray *loyaltyObjects = @[@"-1",presentLocation,[RequestHeader getRequestHeader]];
            NSDictionary *dictionary_req = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
            
            NSError * err_;
            NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_req options:0 error:&err_];
            NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
            
            WebServiceController * services = [[WebServiceController alloc] init];
            services.employeeServiceDelegate =  self;
            [services getEmployeeDetails:loyaltyString];
        }
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
    }
  
}

// added by Roja on 17/10/2019…. // Old Code only added below
- (void)getEmployeeDetailsSucess:(NSDictionary *)successResponse{
    
    @try {
        employeeIdsArr = [[successResponse valueForKey:kEmplyeesList] mutableCopy];
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
}

// added by Roja on 17/10/2019…. // Old Code only added below
- (void)getEmployeeDetailsFailure:(NSString *)successFailure{
    @try {
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
    }
    
}
//


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
        
        float tableHeight = employeeIdsArr.count * 50;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = employeeIdsArr.count * 33;
        
        if(employeeIdsArr.count > 5)
            tableHeight = (tableHeight/employeeIdsArr.count) * 5;
        
        [self showPopUpForTables:salesPersonIdTbl  popUpWidth:salesPersonTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:salesPersonTxt  showViewIn:dateWiseReportView permittedArrowDirections:UIPopoverArrowDirectionUp];
        
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
        
        float tableHeight = couterIdArr.count * 50;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = couterIdArr.count * 33;
        
        if(couterIdArr.count > 5)
            tableHeight = (tableHeight/couterIdArr.count) * 5;
        
        [self showPopUpForTables:counterIDTbl  popUpWidth:counterIDTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:counterIDTxt  showViewIn:dateWiseReportView permittedArrowDirections:UIPopoverArrowDirectionUp];
        
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
}

/** DateButtonPressed handle..
 
 To create picker frame and set the date inside the dueData textfield.
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
        
        else {
            pickView.frame = CGRectMake(0, 0, 320, 460);
        }
        
        pickView.backgroundColor = [UIColor colorWithRed:(119/255.0)green:(136/255.0) blue:(153/255.0) alpha:0.8f];
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
                [popover presentPopoverFromRect:startDateTxt.frame inView:dateWiseReportView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else
                [popover presentPopoverFromRect:endDateTxt.frame inView:dateWiseReportView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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
 * @author       Bhargav.v
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
    
//        BOOL callServices = false;
    
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


// handle getDate method for pick date from calendar.
-(IBAction)getDate:(UIButton*)sender{

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
            if ((startDateTxt.text).length != 0 && ( ![startDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:fromOrder.text ];
                
                if ([existingDateString compare:selectedDateString]== NSOrderedAscending) {
                    
                    startDateTxt.text = @"";
                    
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"start_date_should_be_earlier_than_endDate", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
                    [alert show];
                    return;
                }
            }
            startDateTxt.text = dateString;
        }
        else{
            
            if ((endDateTxt.text).length != 0 && ( ![endDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:toOrder.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    endDateTxt.text = @"";
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"closed_date_should_not_be_earlier_than_created_date", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
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


/** Table Implementation */

#pragma mark Table view methods

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == salesTableView) {
        return dateWiseArr.count;
    }
    else if (tableView == counterIDTbl) {
        return couterIdArr.count;
    }
    
    else if(tableView == salesPersonIdTbl){
        return employeeIdsArr.count;
    }
    return 0;
}

/**
 * @description  Customize HeightForRowAtIndexPath ...
 * @date         <#date#>
 * @method       heightForRowAtIndexPath
 * @author       Bhargav.v
 * @param        UITableView
 * @param        NSIndexPath
 * @return       CGFloat
 * @verified By
 * @verified On
 *
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == salesTableView || tableView == counterIDTbl || salesPersonIdTbl) {
        
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        return 40;
    }
    else{
        return 40;
    }
       
    }
    return 45;
}

//

/**
 * @description  Customize the appearance of table view cells.
 * @date         <#date#>
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
    
    if (tableView == salesTableView){
        
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
            UILabel * s_no_Lbl;
            UILabel * date_Lbl;
            UILabel * totalBills_Lbl;
            UILabel * soldQty_Lbl;
            UILabel * cashTotal_Lbl;
            UILabel * cardTotal_Lbl;
            UILabel * returnAmt_Lbl;
            UILabel * exchangeAmt_Lbl;
            UILabel * sodexo_Lbl;
            UILabel * ticketTotal_Lbl;
            UILabel * loyalty_Lbl;
            UILabel * creditNote_Lbl;
            UILabel * discount_Lbl;
            UILabel * giftVouchers_Lbl;
            UILabel * coupons_Lbl;
            UILabel * creditAmt_Lbl;
            UILabel * creditSales_Lbl;
            UILabel * dayTurnOver_Lbl;
            
            
            /*Creation of UILabels used in this cell*/
            s_no_Lbl = [[UILabel alloc] init];
            s_no_Lbl.backgroundColor = [UIColor clearColor];
            s_no_Lbl.textAlignment = NSTextAlignmentCenter;
            s_no_Lbl.numberOfLines = 1;
            s_no_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            date_Lbl = [[UILabel alloc] init];
            date_Lbl.backgroundColor = [UIColor clearColor];
            date_Lbl.textAlignment = NSTextAlignmentCenter;
            date_Lbl.numberOfLines = 1;
            date_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            totalBills_Lbl = [[UILabel alloc] init];
            totalBills_Lbl.backgroundColor = [UIColor clearColor];
            totalBills_Lbl.textAlignment = NSTextAlignmentCenter;
            totalBills_Lbl.numberOfLines = 1;
            totalBills_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            soldQty_Lbl = [[UILabel alloc] init];
            soldQty_Lbl.backgroundColor = [UIColor clearColor];
            soldQty_Lbl.textAlignment = NSTextAlignmentCenter;
            soldQty_Lbl.numberOfLines = 1;
            soldQty_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
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
            
            returnAmt_Lbl = [[UILabel alloc] init];
            returnAmt_Lbl.backgroundColor = [UIColor clearColor];
            returnAmt_Lbl.textAlignment = NSTextAlignmentCenter;
            returnAmt_Lbl.numberOfLines = 1;
            returnAmt_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            
            exchangeAmt_Lbl = [[UILabel alloc] init];
            exchangeAmt_Lbl.backgroundColor = [UIColor clearColor];
            exchangeAmt_Lbl.textAlignment = NSTextAlignmentCenter;
            exchangeAmt_Lbl.numberOfLines = 1;
            exchangeAmt_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            sodexo_Lbl = [[UILabel alloc] init];
            sodexo_Lbl.backgroundColor = [UIColor clearColor];
            sodexo_Lbl.textAlignment = NSTextAlignmentCenter;
            sodexo_Lbl.numberOfLines = 1;
            sodexo_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            ticketTotal_Lbl = [[UILabel alloc] init];
            ticketTotal_Lbl.backgroundColor = [UIColor clearColor];
            ticketTotal_Lbl.textAlignment = NSTextAlignmentCenter;
            ticketTotal_Lbl.numberOfLines = 1;
            ticketTotal_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            loyalty_Lbl = [[UILabel alloc] init];
            loyalty_Lbl.backgroundColor = [UIColor clearColor];
            loyalty_Lbl.textAlignment = NSTextAlignmentCenter;
            loyalty_Lbl.numberOfLines = 1;
            loyalty_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            creditNote_Lbl = [[UILabel alloc] init];
            creditNote_Lbl.backgroundColor = [UIColor clearColor];
            creditNote_Lbl.textAlignment = NSTextAlignmentCenter;
            creditNote_Lbl.numberOfLines = 1;
            creditNote_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            discount_Lbl = [[UILabel alloc] init];
            discount_Lbl.backgroundColor = [UIColor clearColor];
            discount_Lbl.textAlignment = NSTextAlignmentCenter;
            discount_Lbl.numberOfLines = 1;
            discount_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            
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
            
            creditAmt_Lbl = [[UILabel alloc] init];
            creditAmt_Lbl.backgroundColor = [UIColor clearColor];
            creditAmt_Lbl.textAlignment = NSTextAlignmentCenter;
            creditAmt_Lbl.numberOfLines = 1;
            creditAmt_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            creditSales_Lbl = [[UILabel alloc] init];
            creditSales_Lbl.backgroundColor = [UIColor clearColor];
            creditSales_Lbl.textAlignment = NSTextAlignmentCenter;
            creditSales_Lbl.numberOfLines = 1;
            creditSales_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            dayTurnOver_Lbl = [[UILabel alloc] init];
            dayTurnOver_Lbl.backgroundColor = [UIColor clearColor];
            dayTurnOver_Lbl.textAlignment = NSTextAlignmentCenter;
            dayTurnOver_Lbl.numberOfLines = 1;
            dayTurnOver_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            viewButton = [[UIButton alloc] init];
            viewButton.backgroundColor = [UIColor blackColor];
            viewButton.titleLabel.textColor =  [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
            viewButton.userInteractionEnabled = YES;
            viewButton.tag = indexPath.row;
            [viewButton setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0] forState:UIControlStateNormal];
            [viewButton setTitle:NSLocalizedString(@"View",nil) forState:UIControlStateNormal];
            [viewButton addTarget:self action:@selector(showView:) forControlEvents:UIControlEventTouchUpInside];

            s_no_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            date_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            totalBills_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            soldQty_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            cashTotal_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            cardTotal_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            returnAmt_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            exchangeAmt_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            sodexo_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            ticketTotal_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            loyalty_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            creditNote_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            discount_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            giftVouchers_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            coupons_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            creditAmt_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            creditSales_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            dayTurnOver_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            // adding subViews to thwe Cell...
            
            [hlcell.contentView addSubview:s_no_Lbl];
            [hlcell.contentView addSubview:date_Lbl];
            [hlcell.contentView addSubview:totalBills_Lbl];
            [hlcell.contentView addSubview:soldQty_Lbl];
            [hlcell.contentView addSubview:cashTotal_Lbl];
            [hlcell.contentView addSubview:cardTotal_Lbl];
            [hlcell.contentView addSubview:returnAmt_Lbl];
            [hlcell.contentView addSubview:exchangeAmt_Lbl];
            [hlcell.contentView addSubview:sodexo_Lbl];
            [hlcell.contentView addSubview:ticketTotal_Lbl];
            [hlcell.contentView addSubview:loyalty_Lbl];
            [hlcell.contentView addSubview:creditNote_Lbl];
            [hlcell.contentView addSubview:discount_Lbl];
            [hlcell.contentView addSubview:giftVouchers_Lbl];
            [hlcell.contentView addSubview:coupons_Lbl];
            [hlcell.contentView addSubview:creditAmt_Lbl];
            [hlcell.contentView addSubview:creditSales_Lbl];
            [hlcell.contentView addSubview:dayTurnOver_Lbl];
            [hlcell.contentView addSubview:viewButton];
            
            // adding frames for the UILabels in Cell...

            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                s_no_Lbl.frame = CGRectMake(0,0,snoLbl.frame.size.width,hlcell.frame.size.height);
                date_Lbl.frame = CGRectMake(dateLbl.frame.origin.x,0,dateLbl.frame.size.width,hlcell.frame.size.height);
                totalBills_Lbl.frame = CGRectMake(totalBillsLbl.frame.origin.x,0,totalBillsLbl.frame.size.width,hlcell.frame.size.height);
                
                soldQty_Lbl.frame = CGRectMake(soldQtyLbl.frame.origin.x,0,soldQtyLbl.frame.size.width,hlcell.frame.size.height);
                
                cashTotal_Lbl.frame = CGRectMake(cashTotalLbl.frame.origin.x,0,cashTotalLbl.frame.size.width,hlcell.frame.size.height);
                
                cardTotal_Lbl.frame = CGRectMake(cardTotalLbl.frame.origin.x,0,cardTotalLbl.frame.size.width,hlcell.frame.size.height);
                
                returnAmt_Lbl.frame = CGRectMake(returnAmntLbl.frame.origin.x,0,returnAmntLbl.frame.size.width,hlcell.frame.size.height);
                
                exchangeAmt_Lbl.frame = CGRectMake(exchangeAmntLbl.frame.origin.x,0,exchangeAmntLbl.frame.size.width,hlcell.frame.size.height);
                
                sodexo_Lbl.frame = CGRectMake(sodexoTotlLbl.frame.origin.x,0,sodexoTotlLbl.frame.size.width,hlcell.frame.size.height);
                
                ticketTotal_Lbl.frame = CGRectMake(ticketTotlLbl.frame.origin.x,0,ticketTotlLbl.frame.size.width,hlcell.frame.size.height);
                
                loyalty_Lbl.frame = CGRectMake(loyaltyClaimLbl.frame.origin.x,0,loyaltyClaimLbl.frame.size.width,hlcell.frame.size.height);
                
                creditNote_Lbl.frame = CGRectMake(creditNoteLbl.frame.origin.x,0,creditNoteLbl.frame.size.width,hlcell.frame.size.height);
                
                discount_Lbl.frame = CGRectMake(discountLbl.frame.origin.x,0,discountLbl.frame.size.width,hlcell.frame.size.height);
                
                giftVouchers_Lbl.frame = CGRectMake(giftVouchersLbl.frame.origin.x,0,giftVouchersLbl.frame.size.width,hlcell.frame.size.height);
                
                coupons_Lbl.frame = CGRectMake(couponsLbl.frame.origin.x,0,couponsLbl.frame.size.width,hlcell.frame.size.height);
                
                creditAmt_Lbl.frame = CGRectMake(creditsAmntLbl.frame.origin.x,0,creditsAmntLbl.frame.size.width,hlcell.frame.size.height);
                
                creditSales_Lbl.frame = CGRectMake(creditSalesLbl.frame.origin.x,0,creditSalesLbl.frame.size.width,hlcell.frame.size.height);
                
                dayTurnOver_Lbl.frame = CGRectMake(dayTurnOverLbl.frame.origin.x,0,dayTurnOverLbl.frame.size.width,hlcell.frame.size.height);
                
                viewButton.frame = CGRectMake(actionLbl.frame.origin.x,0, actionLbl.frame.size.width, hlcell.frame.size.height);
            }
            else{
                
                //code for the iPhone Devices
            }
            
            //setting font size....
            [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:15.0f cornerRadius:0.0];
            viewButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:17.0f];

            
            //appending values in the cell from DataBase...
            
            if (dateWiseArr.count >= indexPath.row && dateWiseArr.count) {
                
                
                NSDictionary * dic  = dateWiseArr[indexPath.row];
                
                s_no_Lbl.text = [NSString stringWithFormat:@"%d",(int)(indexPath.row+1)];
                
                date_Lbl.text = [self checkGivenValueIsNullOrNil:[[dic valueForKey:REPORT_DATE] componentsSeparatedByString:@" "][0]  defaultReturn:@"--"];
                
                totalBills_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:TOTALBILLS] defaultReturn:@"0.00"] floatValue]];
                
                soldQty_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:SOLD_QTY] defaultReturn:@"0.00"] floatValue]];
                
                cashTotal_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:CASHTOTAL] defaultReturn:@"0.00"] floatValue]];
                
                cardTotal_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:CARDTOTAL] defaultReturn:@"0.00"] floatValue]];
                
                returnAmt_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:RETURNED_AMT] defaultReturn:@"0.00"] floatValue]];
                
                exchangeAmt_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:EXCHANGED_AMT] defaultReturn:@"0.00"] floatValue]];
                
                sodexo_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:SODEXO_TOTAL] defaultReturn:@"0.00"] floatValue]];
                
                ticketTotal_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:TICKETTOTAL] defaultReturn:@"0.00"] floatValue]];
                
                loyalty_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:LOYALTY_TOTAL] defaultReturn:@"0.00"] floatValue]];
                
                creditNote_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:CREDIT_TOTAL] defaultReturn:@"0.00"] floatValue]];
                
                discount_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:DISCOUNT] defaultReturn:@"0.00"] floatValue]];
                
                giftVouchers_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:VOUCHERS_TOTAL] defaultReturn:@"0.00"] floatValue]];
                
                coupons_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:COUPONS_TOTAL] defaultReturn:@"0.00"] floatValue]];
                
                creditAmt_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:CREDITS_AMT] defaultReturn:@"0.00"] floatValue]];
                
                creditSales_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:FINALCREDITBILL_AMT] defaultReturn:@"0.00"] floatValue]];
                
                dayTurnOver_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:DAYTURN_OVER_AMT] defaultReturn:@"0.00"] floatValue]];
            }
            else{
                s_no_Lbl.text = @"--";
                date_Lbl.text = @"--";
                totalBills_Lbl.text = @"--";
                soldQty_Lbl.text = @"--";
                cashTotal_Lbl.text = @"--";
                cardTotal_Lbl.text = @"--";
                returnAmt_Lbl.text = @"--";
                exchangeAmt_Lbl.text = @"--";
                sodexo_Lbl.text = @"--";
                ticketTotal_Lbl.text = @"--";
                loyalty_Lbl.text = @"--";
                creditNote_Lbl.text = @"--";
                discount_Lbl.text = @"--";
                giftVouchers_Lbl.text = @"--";
                coupons_Lbl.text = @"--";
                creditAmt_Lbl.text = @"--";
                creditSales_Lbl.text = @"--";
                creditSales_Lbl.text = @"--";
                dayTurnOver_Lbl.text = @"--";

            }
            
        } @catch (NSException *exception) {
            
        } @finally {
            hlcell.backgroundColor = [UIColor clearColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            return hlcell;
        }
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
        
        NSDictionary *dic = employeeIdsArr[indexPath.row];
        
        hlcell.textLabel.text =  [NSString stringWithFormat:@"%@(%@)",[dic valueForKey:@"firstName"],[dic valueForKey:@"employeeCode"]];
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
    
     if (tableView == salesTableView) {
        @try {
            
            NSDictionary * summaryDic = dateWiseArr[indexPath.row];
            BillSummary  * billSummaryObj = [[BillSummary alloc] init];
            billSummaryObj.dateStr = [[summaryDic valueForKey:@"date"] copy];
            [self.navigationController pushViewController:billSummaryObj animated:YES];

        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
    
     else if (tableView == counterIDTbl){
         //Play Audio for button touch....
         AudioServicesPlaySystemSound (soundFileObject);
         
         counterIDTxt.text = couterIdArr[indexPath.row];
     }
    
     else if(tableView == salesPersonIdTbl) {
         
         @try {
             
             NSDictionary * dic = employeeIdsArr[indexPath.row];
             
             salesPersonTxt.text = [NSString stringWithFormat:@"%@(%@)",[dic valueForKey:@"firstName"],[dic valueForKey:@"employeeCode"]];

             
         } @catch (NSException *exception) {
             
         } @finally {
             
         }
         
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

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
   
        if(tableView == salesTableView){
            
            
                if ((indexPath.row == (dateWiseArr.count -1)) && (dateWiseArr.count < totalRecordsInt ) && (dateWiseArr.count> reportStartIndex )) {
                    
                    [HUD show:YES];
                    [HUD setHidden:NO];
                    reportStartIndex = reportStartIndex + 10;
                    [self callingSalesServiceforRecords];
                    [salesTableView reloadData];
                }
                
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
        
        if ((counterIDTxt.text).length == 0  && (salesPersonTxt.text).length == 0) {
            
            float y_axis = self.view.frame.size.height-200;
            
            NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert",nil),@"\n",NSLocalizedString(@"Please select above fields before proceeding", nil)];
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:450 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
            return;
        }
        
        else
            [HUD setHidden:NO];
        reportStartIndex = 0;
        dateWiseArr = [NSMutableArray new];
        [self callingSalesServiceforRecords];
        
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
        
        counterIDTxt.text   = @"";
        salesPersonTxt.text = @"";
        startDateTxt.text   = @"";
        endDateTxt.text     = @"";
        
        reportStartIndex = 0;
        [self callingSalesServiceforRecords];
        
    } @catch (NSException * exception) {
        [HUD setHidden:YES];
        NSLog(@"--------exception in the dateWiseReportView.... in viewWillDisappear---------%@",exception);
        NSLog(@"----exception is------------%@",exception);
        
    } @finally {
        
    }
}


/**
 * @description  This method is used to navigate to the other class with a date reference
 * @date         11/08/2017..
 * @method       showView
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)showView:(UIButton *)sender{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        NSDictionary *summaryDic = dateWiseArr[sender.tag];
        BillSummary  *billSummaryObj = [[BillSummary alloc] init];
        billSummaryObj.dateStr = [[summaryDic valueForKey:@"date"] copy];
        [self.navigationController pushViewController:billSummaryObj animated:YES];

        
    } @catch (NSException *exception) {
        
    } @finally {
        
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
        
        PopOverViewController  * customerInfoPopUp = [[PopOverViewController alloc] init];
        
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

#pragma -mark super class methods

/**
 * @description  here we are navigating back to home page.......
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

-(void)homeButonClicked {
    
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}





@end


