//
//  BillSummary.m
//  OmniRetailer
//
//  Created by admin on 06/02/17.
//
//

#import <QuartzCore/QuartzCore.h>
#import "BillSummary.h"
#import "Global.h"
//#import "SalesReportsSvc.h"
#import "OmniHomePage.h"
#import "RequestHeader.h"

@implementation BillSummary

@synthesize fromOrder,bill,salesTableView,dateStr;
@synthesize soundFileURLRef,soundFileObject;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) goHomePage {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    //[self.navigationController popViewControllerAnimated:YES];
    [UIView  transitionWithView:self.navigationController.view duration:0.8  options:UIViewAnimationOptionTransitionFlipFromRight
                     animations:^(void) {
                         BOOL oldState = [UIView areAnimationsEnabled];
                         [UIView setAnimationsEnabled:NO];
                         [self.navigationController popViewControllerAnimated:YES];
                         [UIView setAnimationsEnabled:oldState];
                     }
                     completion:nil];
}

//- (void)viewDidLoad {
//
//    [super viewDidLoad];
//    
//    version = [[[UIDevice currentDevice] systemVersion] floatValue];
//    
//    
//    // Audio Sound load url......
//    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
//    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
//    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
//    
//    self.navigationController.navigationBarHidden = NO;
//    
//    self.titleLabel.text = @"Date-Wise Reports";
//    
//    //main view bakgroung setting...
//    self.view.backgroundColor = [UIColor blackColor];
//    changeID = 0;
//
//    /** TextFields Design*/
//    
//    counterIds = [[NSArray alloc]initWithObjects:@"Counter 1",@"Counter 2",@"Counter 3",@"Counter 4",@"Counter 5",@"Counter 6",@"Counter 7",@"Counter 8",@"Counter 9",@"Counter 10",@"Counter 11",@"Counter 12",@"Counter 13",@"Counter 14",@"Counter 15",@"Counter 16",@"Counter 17",@"Counter 22", nil];
//
////    
//    dateArr = [[NSMutableArray alloc] init];
//    totalBillArr = [[NSMutableArray alloc]init];
//    counterIdArr = [[NSMutableArray alloc]init];
//    cardTotal = [[NSMutableArray alloc] init];
//    discount = [[NSMutableArray alloc] init];
//    
//    fromOrder = [[CustomTextField alloc] init];
//    fromOrder.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
//
//    fromOrder.borderStyle = UITextBorderStyleRoundedRect;
//    fromOrder.textColor = [UIColor blackColor];
//    fromOrder.backgroundColor = [UIColor whiteColor];
//    fromOrder.autocorrectionType = UITextAutocorrectionTypeNo;
//    fromOrder.keyboardType = UIKeyboardTypeDefault;
//    fromOrder.returnKeyType = UIReturnKeyDone;
//    fromOrder.clearButtonMode = UITextFieldViewModeWhileEditing;
//    fromOrder.userInteractionEnabled = NO;
//    fromOrder.delegate = self;
//    fromOrder.userInteractionEnabled = false;
//    fromOrder.text = dateStr;
//    [fromOrder awakeFromNib];
//    fromOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    
//    counterId = [[UITextField alloc] init];
//    counterId.borderStyle = UITextBorderStyleRoundedRect;
//    counterId.textColor = [UIColor blackColor];
//    counterId.placeholder = @"Counter Id";  //place holder
//    counterId.backgroundColor = [UIColor whiteColor];
//    counterId.autocorrectionType = UITextAutocorrectionTypeNo;
//    counterId.keyboardType = UIKeyboardTypeDefault;
//    counterId.returnKeyType = UIReturnKeyDone;
//    counterId.clearButtonMode = UITextFieldViewModeWhileEditing;
//   
//    
//    UIToolbar* numberToolbar1 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
//    numberToolbar1.barStyle = UIBarStyleBlackTranslucent;
//    numberToolbar1.items = [NSArray arrayWithObjects:
//                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
//                            [[UIBarButtonItem alloc]initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
//                            nil];
//    [numberToolbar1 sizeToFit];
//    counterId.inputAccessoryView = numberToolbar1;
//    counterId.keyboardType = UIKeyboardTypeNumberPad;
//    counterId.delegate = self;
//    counterId.text = counterName;
//    
//
//    /** UIScrollView Design */
//    scrollView = [[UIScrollView alloc] init];
//    scrollView.bounces =FALSE;
//    
//    /** Table Headers Design*/
//    
//    
//    sNo = [[UILabel alloc] init];
//    sNo.backgroundColor = [UIColor clearColor];
//    sNo.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
//    sNo.text = @"S No";
//    [sNo setTextAlignment:NSTextAlignmentCenter];
//    sNo.textColor = [UIColor whiteColor];
//    sNo.layer.cornerRadius = 14;
//    sNo.layer.masksToBounds = YES;
//    
//    
//   billedOn = [[UILabel alloc] init];
//    billedOn.backgroundColor = [UIColor clearColor];
//    billedOn.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
//    billedOn.text = @"Bill Id";
//    [billedOn setTextAlignment:NSTextAlignmentCenter];
//    billedOn.textColor = [UIColor whiteColor];
//    billedOn.layer.cornerRadius = 14;
//    billedOn.layer.masksToBounds = YES;
//    
//    
//   transactions = [[UILabel alloc] init];
//    transactions.backgroundColor = [UIColor clearColor];
//    transactions.text = @"Total Amt";
//    transactions.numberOfLines = 2;
//    transactions.lineBreakMode = NSLineBreakByWordWrapping;
//    transactions.textAlignment = NSTextAlignmentLeft;
//    transactions.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
//    [transactions setTextAlignment:NSTextAlignmentCenter];
//    transactions.textColor = [UIColor whiteColor];
//    transactions.layer.cornerRadius = 14;
//    transactions.layer.masksToBounds = YES;
//    
//   totalCashAmt = [[UILabel alloc] init];
//    totalCashAmt.backgroundColor = [UIColor clearColor];
//    totalCashAmt.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
//    totalCashAmt.text = @"Cash Amt";
//    [totalCashAmt setTextAlignment:NSTextAlignmentCenter];
//    totalCashAmt.textColor = [UIColor whiteColor];
//    totalCashAmt.layer.cornerRadius = 14;
//    totalCashAmt.layer.masksToBounds = YES;
//    
//
//    
//  paidAmount = [[UILabel alloc] init];
//    paidAmount.backgroundColor = [UIColor clearColor];
//    paidAmount.text = @"Card Amt";
//    paidAmount.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
//    [paidAmount setTextAlignment:NSTextAlignmentCenter];
//    paidAmount.textColor = [UIColor whiteColor];
//    paidAmount.layer.cornerRadius = 14;
//    paidAmount.layer.masksToBounds = YES;
//
//    
//    
//  amountDue = [[UILabel alloc] init];
//    amountDue.backgroundColor = [UIColor clearColor];
//    amountDue.text = @"Change";
//    amountDue.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
//    [amountDue setTextAlignment:NSTextAlignmentCenter];
//    amountDue.textColor = [UIColor whiteColor];
//    amountDue.layer.cornerRadius = 14;
//    amountDue.layer.masksToBounds = YES;
//
//   
//
//    
//    
//    totalBillAmount = [[UILabel alloc] init];
//    totalBillAmount.backgroundColor = [UIColor clearColor];
//    totalBillAmount.text = @"Sodexo Amt";
//    totalBillAmount.numberOfLines = 2;
//    totalBillAmount.lineBreakMode = NSLineBreakByWordWrapping;
//    totalBillAmount.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
//    [totalBillAmount setTextAlignment:NSTextAlignmentCenter];
//    totalBillAmount.textColor = [UIColor whiteColor];
//    totalBillAmount.layer.cornerRadius = 14;
//    totalBillAmount.layer.masksToBounds = YES;
//    
//    
//    
//   ticketAmtLbl = [[UILabel alloc] init];
//    ticketAmtLbl.backgroundColor = [UIColor clearColor];
//    ticketAmtLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
//    ticketAmtLbl.text = @"Ticket Amt";
//    [ticketAmtLbl setTextAlignment:NSTextAlignmentCenter];
//    ticketAmtLbl.textColor = [UIColor whiteColor];
//    ticketAmtLbl.layer.cornerRadius = 14;
//    ticketAmtLbl.layer.masksToBounds = YES;
//    
//    
//   voucherTotal=[[UILabel alloc]init];
//    voucherTotal.backgroundColor=[UIColor clearColor];
//    voucherTotal.backgroundColor=[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
//    voucherTotal.text = @"Voucher Total";
//    [voucherTotal setTextAlignment:NSTextAlignmentCenter];
//    voucherTotal.textColor=[UIColor whiteColor];
//    voucherTotal.layer.cornerRadius=14;
//    voucherTotal.layer.masksToBounds=YES;
//    
//    couponTotal=[[UILabel alloc]init];
//    couponTotal.backgroundColor=[UIColor clearColor];
//    couponTotal.backgroundColor=[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
//    couponTotal.text = @"Coupons Total";
//    [couponTotal setTextAlignment:NSTextAlignmentCenter];
//    couponTotal.textColor=[UIColor whiteColor];
//    couponTotal.layer.cornerRadius=14;
//    couponTotal.layer.masksToBounds=YES;
//    
//    
//    loyaltyPoints=[[UILabel alloc]init];
//    loyaltyPoints.backgroundColor=[UIColor clearColor];
//    loyaltyPoints.backgroundColor=[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
//    loyaltyPoints.text = @"Loyalty Points";
//    [loyaltyPoints setTextAlignment:NSTextAlignmentCenter];
//    loyaltyPoints.textColor=[UIColor whiteColor];
//    loyaltyPoints.layer.cornerRadius=14;
//    loyaltyPoints.layer.masksToBounds=YES;
//    
//    
//  creditNote=[[UILabel alloc]init];
//    creditNote.backgroundColor=[UIColor clearColor];
//    creditNote.backgroundColor=[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
//    creditNote.text = @"Credit Note";
//    [creditNote setTextAlignment:NSTextAlignmentCenter];
//    creditNote.textColor=[UIColor whiteColor];
//    creditNote.layer.cornerRadius=14;
//    creditNote.layer.masksToBounds=YES;
//    
//    creditTotal=[[UILabel alloc]init];
//    creditTotal.backgroundColor=[UIColor clearColor];
//    creditTotal.backgroundColor=[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
//    creditTotal.text = @"Credits Total";
//    [creditTotal setTextAlignment:NSTextAlignmentCenter];
//    creditTotal.textColor=[UIColor whiteColor];
//    creditTotal.layer.cornerRadius=14;
//    creditTotal.layer.masksToBounds=YES;
//    
//    
//    /** Create TableView */
//    salesTableView = [[UITableView alloc]init];
//    salesTableView.backgroundColor = [UIColor clearColor];
//    salesTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//    [salesTableView setDataSource:self];
//    [salesTableView setDelegate:self];
//    salesTableView.bounces = FALSE;
//    [salesTableView setSeparatorColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.2f]];
//    
//    
//    counterTable = [[UITableView alloc] init];
//    counterTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
//    [counterTable setDataSource:self];
//    [counterTable setDelegate:self];
//    [counterTable.layer setBorderWidth:1.0f];
//    counterTable.layer.cornerRadius = 3;
//    counterTable.layer.borderColor = [UIColor grayColor].CGColor;
//    counterTable.hidden = YES;
//    
//    
//    
//    
//    //creating the dateWiseReportView which will displayed completed Screen.......
//    billWiseReportView = [[UIView alloc] init];
//    billWiseReportView.backgroundColor = [UIColor blackColor];
//    billWiseReportView.layer.borderWidth = 1.0f;
//    billWiseReportView.layer.cornerRadius = 10.0f;
//    billWiseReportView.layer.borderColor = [UIColor blackColor].CGColor;
//    
//    
//    
//    //ProgressBar creation...
//    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
//    [self.navigationController.view addSubview:HUD];
//    // Regiser for HUD callbacks so we can remove it from the window at the right time
//    HUD.delegate = self;
//    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
//    HUD.mode = MBProgressHUDModeCustomView;
//    // Show the HUD
//    [HUD show:YES];
//    
//    [HUD setHidden:NO];
//    
//    
//    // Calling the webservices to get the present orders ..
//    
//  blockedCharacters = [[NSCharacterSet alphanumericCharacterSet] invertedSet] ;
//    
//  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//
//      @try {
//          
//          billWiseReportView.frame = CGRectMake( 2, 70, self.view.frame.size.width - 4, self.view.frame.size.height - 80);
//          
//          fromOrder.frame = CGRectMake(billWiseReportView.frame.origin.x+10,billWiseReportView.frame.origin.y-50, 220,40);
//          
//          scrollView.frame = CGRectMake(0, fromOrder.frame.origin.y+fromOrder.frame.size.height-10, 2300, billWiseReportView.frame.size.height);
//          
//          scrollView.contentSize = CGSizeMake(2940, 450);
//          
//          
//          sNo.frame=CGRectMake(billWiseReportView.frame.origin.x+10, billWiseReportView.frame.origin.y-20, 60, 40);
//          salesTableView.frame = CGRectMake(sNo.frame.origin.x,sNo.frame.origin.y+sNo.frame.size.height,scrollView.frame.size.width-40,scrollView.frame.size.height-200);
//
//          billedOn.frame=CGRectMake(sNo.frame.origin.x+sNo.frame.size.width+2, sNo.frame.origin.y, 230,40);
//          
//          
//          transactions.frame=CGRectMake(billedOn.frame.origin.x+billedOn.frame.size.width+2, billedOn.frame.origin.y, 120,40);
//          
//          totalCashAmt.frame=CGRectMake(transactions.frame.origin.x+transactions.frame.size.width+2, transactions.frame.origin.y, 120,40);
//          paidAmount.frame=CGRectMake(totalCashAmt.frame.origin.x+totalCashAmt.frame.size.width+2,totalCashAmt.frame.origin.y, 120, 40);
//          amountDue.frame=CGRectMake(paidAmount.frame.origin.x+paidAmount.frame.size.width+2,paidAmount.frame.origin.y , 120, 40);
//  
//          totalBillAmount.frame = CGRectMake(amountDue.frame.origin.x+amountDue.frame.size.width+2, amountDue.frame.origin.y, 120, 40);
//          ticketAmtLbl.frame=CGRectMake(totalBillAmount.frame.origin.x+totalBillAmount.frame.size.width+2, totalBillAmount.frame.origin.y, 120, 40);
//          voucherTotal.frame=CGRectMake(ticketAmtLbl.frame.origin.x+ticketAmtLbl.frame.size.width+2, ticketAmtLbl.frame.origin.y, 120, 40);
//          couponTotal.frame=CGRectMake(voucherTotal.frame.origin.x+voucherTotal.frame.size.width+2, voucherTotal.frame.origin.y, 120, 40);
//          
//          
//          loyaltyPoints.frame=CGRectMake(couponTotal.frame.origin.x+couponTotal.frame.size.width+2, couponTotal.frame.origin.y, 120, 40);
//          creditNote.frame=CGRectMake(loyaltyPoints.frame.origin.x+loyaltyPoints.frame.size.width+2, loyaltyPoints.frame.origin.y, 120, 40);
//          creditTotal.frame=CGRectMake(creditNote.frame.origin.x+creditNote.frame.size.width+2, creditNote.frame.origin.y, 120, 40);
//
//      
//      } @catch (NSException *exception) {
//          
//      } @finally {
//          
//      }
//      
//  }
//    
//    
//     [billWiseReportView addSubview:fromOrder];
//
//    [scrollView addSubview : sNo];
//    [scrollView addSubview : billedOn];
//    [scrollView addSubview : transactions];
//    [scrollView addSubview : totalCashAmt];
//    [scrollView addSubview : paidAmount];
//    [scrollView addSubview : amountDue];
//    [scrollView addSubview : totalBillAmount];
//    [scrollView addSubview : ticketAmtLbl];
//    [scrollView addSubview : voucherTotal];
//    [scrollView addSubview : couponTotal];
//    [scrollView addSubview : creditNote];
//    [scrollView addSubview : creditTotal];
//    [scrollView addSubview : loyaltyPoints];
//    
//    [scrollView addSubview:salesTableView];
//    [billWiseReportView addSubview:scrollView];
//    [self.view addSubview:billWiseReportView];
//}

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
    
    //Show the HUD
    [HUD show:YES];
    [HUD setHidden:NO];
    
    //allocation of billWiseReportView ReportView....
    billWiseReportView = [[UIView alloc]init];
    
    /*Creation of UILabel for headerDisplay.......*/
    //creating line  UILabel which will display at topOfThe  billingView.......
    
    UILabel  * headerNameLbl;
    CALayer  * bottomBorder;

    
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
    
    //Allocation of startDateTxt
    startDateTxt = [[CustomTextField alloc] init];
    startDateTxt.delegate = self;
    startDateTxt.userInteractionEnabled  = NO;
    startDateTxt.text = dateStr;
    [startDateTxt awakeFromNib];
    
    /** UIScrollView Design */
    scrollView = [[UIScrollView alloc] init];
    
    
    //Allocation Of CustomLabels..
    
    snoLbl = [[CustomLabel alloc] init];
    [snoLbl awakeFromNib];
    
    billIDLbl = [[CustomLabel alloc] init];
    [billIDLbl awakeFromNib];
    
    totalAmtLbl = [[CustomLabel alloc] init];
    [totalAmtLbl awakeFromNib];
    
    cashAmtLbl = [[CustomLabel alloc] init];
    [cashAmtLbl awakeFromNib];

    cardAmtLbl = [[CustomLabel alloc] init];
    [cardAmtLbl awakeFromNib];
    
    returnedAmtLbl = [[CustomLabel alloc] init];
    [returnedAmtLbl awakeFromNib];
    
    exchangedAmtLbl = [[CustomLabel alloc] init];
    [exchangedAmtLbl awakeFromNib];

    sodexoAmtLbl = [[CustomLabel alloc] init];
    [sodexoAmtLbl awakeFromNib];
    
    tickectAmtLbl = [[CustomLabel alloc] init];
    [tickectAmtLbl awakeFromNib];
    
    creditNoteLbl = [[CustomLabel alloc] init];
    [creditNoteLbl awakeFromNib];
    
    giftVouchersLbl = [[CustomLabel alloc] init];
    [giftVouchersLbl awakeFromNib];

    creditsAmtLbl = [[CustomLabel alloc] init];
    [creditsAmtLbl awakeFromNib];

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
    
    //Allocation of UIView....
    
    totalBillsView = [[UIView alloc]init];
    totalBillsView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
    totalBillsView.layer.borderWidth =3.0f;
    
    //Allocation Of UILabels to show the totalValue
    UILabel * totalLabel;
    
    totalLabel = [[UILabel alloc] init];
    totalLabel.layer.masksToBounds = YES;
    totalLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
    totalLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    totalBillValueLbl = [[UILabel alloc] init];
    totalBillValueLbl.numberOfLines = 2;
    totalBillValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
    totalBillValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    totalBillValueLbl.textAlignment = NSTextAlignmentCenter;
    totalBillValueLbl.text = @"0.0";
    
    
    @try {
        //setting the titleName for the Page....
        self.titleLabel.text = NSLocalizedString(@"omni_retailer",nil);
        HUD.labelText = NSLocalizedString(@"please_wait..",nil);
        headerNameLbl.text = NSLocalizedString(@"date_wise_report",nil);
        
        //Strings for the CustomLabels..
        snoLbl.text    = NSLocalizedString(@"S_NO",nil);
        billIDLbl.text = NSLocalizedString(@"bill_id",nil);
        totalAmtLbl.text = NSLocalizedString(@"total_amount",nil);
        cashAmtLbl.text = NSLocalizedString(@"cash_amt",nil);
        cardAmtLbl.text = NSLocalizedString(@"card_amt",nil);
        returnedAmtLbl.text = NSLocalizedString(@"returned_amount",nil);
        exchangedAmtLbl.text = NSLocalizedString(@"exchange_amount",nil);
        sodexoAmtLbl.text = NSLocalizedString(@"sodexo_amt",nil);
        tickectAmtLbl.text = NSLocalizedString(@"ticket_amt",nil);
        creditNoteLbl.text = NSLocalizedString(@"credit_note",nil);
        giftVouchersLbl.text = NSLocalizedString(@"gift_vouchers",nil);
        creditsAmtLbl.text = NSLocalizedString(@"credits_amt",nil);
        actionLbl.text = NSLocalizedString(@"action",nil);
        
        totalLabel.text = NSLocalizedString(@"total_bills:",nil);

    } @catch (NSException *exception) {
        
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
        }
        else{
        }
        //setting for the stockReceiptView....
        billWiseReportView.frame = CGRectMake(2,70,self.view.frame.size.width-4,self.view.frame.size.height-80);
        //seting frame for headerNameLbl....
        headerNameLbl.frame = CGRectMake(0,0,billWiseReportView.frame.size.width,45);
        
        
        float textFieldWidth = 180;
        float textFieldHeight = 40;
        
        //Row 1...
        //frame for the start date label...
        startDateTxt.frame = CGRectMake(billWiseReportView.frame.origin.x+10,headerNameLbl.frame.origin.y+headerNameLbl.frame.size.height+20,textFieldWidth,textFieldHeight);
        
        scrollView.frame = CGRectMake(10,startDateTxt.frame.origin.y+startDateTxt.frame.size.height+20,billWiseReportView.frame.size.width+100,520);

        //frames for the custom Labels...
        snoLbl.frame = CGRectMake(0,0,60,40);
        
        billIDLbl.frame = CGRectMake(snoLbl.frame.origin.x+snoLbl.frame.size.width+2,snoLbl.frame.origin.y,170,snoLbl.frame.size.height);

        totalAmtLbl.frame = CGRectMake(billIDLbl.frame.origin.x+billIDLbl.frame.size.width+2,snoLbl.frame.origin.y,100,snoLbl.frame.size.height);
        
        cashAmtLbl.frame = CGRectMake(totalAmtLbl.frame.origin.x+totalAmtLbl.frame.size.width+2,snoLbl.frame.origin.y,100,snoLbl.frame.size.height);
        
        cardAmtLbl.frame = CGRectMake(cashAmtLbl.frame.origin.x+cashAmtLbl.frame.size.width+2,snoLbl.frame.origin.y,100,snoLbl.frame.size.height);

        returnedAmtLbl.frame = CGRectMake(cardAmtLbl.frame.origin.x+cardAmtLbl.frame.size.width+2,snoLbl.frame.origin.y,120,snoLbl.frame.size.height);
        
        exchangedAmtLbl.frame = CGRectMake(returnedAmtLbl.frame.origin.x+returnedAmtLbl.frame.size.width+2,snoLbl.frame.origin.y,120,snoLbl.frame.size.height);

        sodexoAmtLbl.frame = CGRectMake(exchangedAmtLbl.frame.origin.x+exchangedAmtLbl.frame.size.width+2,snoLbl.frame.origin.y,100,snoLbl.frame.size.height);
        
        tickectAmtLbl.frame = CGRectMake(sodexoAmtLbl.frame.origin.x+sodexoAmtLbl.frame.size.width+2,snoLbl.frame.origin.y,100,snoLbl.frame.size.height);
        
        creditNoteLbl.frame = CGRectMake(tickectAmtLbl.frame.origin.x+tickectAmtLbl.frame.size.width+2,snoLbl.frame.origin.y,100,snoLbl.frame.size.height);

        giftVouchersLbl.frame = CGRectMake(creditNoteLbl.frame.origin.x+creditNoteLbl.frame.size.width+2,snoLbl.frame.origin.y,120,snoLbl.frame.size.height);
        
        creditsAmtLbl.frame = CGRectMake(giftVouchersLbl.frame.origin.x+giftVouchersLbl.frame.size.width+2,snoLbl.frame.origin.y,100,snoLbl.frame.size.height);
        actionLbl.frame = CGRectMake(creditsAmtLbl.frame.origin.x+creditsAmtLbl.frame.size.width+2,snoLbl.frame.origin.y,100,snoLbl.frame.size.height);

        salesTableView.frame = CGRectMake(snoLbl.frame.origin.x,snoLbl.frame.origin.y+snoLbl.frame.size.height + 10,actionLbl.frame.origin.x+actionLbl.frame.size.width-snoLbl.frame.origin.x,scrollView.frame.size.height);
//        salesTableView.backgroundColor =  [UIColor lightGrayColor];
        
        scrollView.contentSize = CGSizeMake(salesTableView.frame.size.width+120,scrollView.frame.size.height);

        
        totalBillsView.frame = CGRectMake(scrollView.frame.origin.x,scrollView.frame.origin.y+scrollView.frame.size.height,billIDLbl.frame.origin.x+billIDLbl.frame.size.width -(snoLbl.frame.origin.x),actionLbl.frame.size.height);
        
        totalLabel.frame = CGRectMake(10,0,160,40);
        
        totalBillValueLbl.frame = CGRectMake(totalLabel.frame.origin.x+totalLabel.frame.size.width-40,totalLabel.frame.origin.y,totalAmtLbl.frame.size.width,totalLabel.frame.size.height);
    
    }
    
    [billWiseReportView addSubview:headerNameLbl];
    [billWiseReportView addSubview:startDateTxt];
    
    [billWiseReportView addSubview:scrollView];
    [scrollView addSubview:snoLbl];
    [scrollView addSubview:billIDLbl];
    [scrollView addSubview:totalAmtLbl];
    [scrollView addSubview:cashAmtLbl];
    [scrollView addSubview:cardAmtLbl];
    [scrollView addSubview:returnedAmtLbl];
    [scrollView addSubview:exchangedAmtLbl];
    [scrollView addSubview:sodexoAmtLbl];
    [scrollView addSubview:tickectAmtLbl];
    [scrollView addSubview:creditNoteLbl];
    [scrollView addSubview:giftVouchersLbl];
    [scrollView addSubview:creditsAmtLbl];
    [scrollView addSubview:actionLbl];
    [scrollView addSubview:salesTableView];
    
//    [billWiseReportView addSubview:totalBillsView];
//    [totalBillsView addSubview:totalLabel];
//    [totalBillsView addSubview:totalBillValueLbl];

    [self.view addSubview:billWiseReportView];

    //Setting font for the UI Elements added under self.view...
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

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    @try {
        counterIdArr = [NSMutableArray new];
        reportStartIndex = 0;
        totalRecordsInt = 0;
        
        [self callingSalesServiceforRecords];
        
    } @catch (NSException * exception) {
        
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

// Commented by roja on 17/10/2019.. // reason :- callingSalesServiceforRecords method contains SOAP Service call .. so taken new method with same name(callingSalesServiceforRecords) method name which contains REST service call....
// At the time of converting SOAP call's to REST

//-(void) callingSalesServiceforRecords{
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
//    if (!isOfflineService) {
//
//        @try {
//
//            [HUD setHidden:NO];
//
//            NSMutableDictionary *reports = [[NSMutableDictionary alloc]init];
//            reports[@"date"] = [NSString stringWithFormat:@"%@%@",dateStr,@" 00:00:00"];
//            reports[@"startTime"] = @"";
//            reports[@"endtime"] = @"";
//            reports[@"shiftId"] = shiftId;
//            reports[@"paymentMode"] = @"";
//            reports[@"store_location"] = presentLocation;
//            reports[@"searchCriteria"] = @"billSummery";
//            reports[@"counterId"] = @"";
//            reports[@"startIndex"] = [NSString stringWithFormat:@"%d",reportStartIndex];
//            reports[@"requiredRecords"] = [NSString stringWithFormat:@"%d",10];
//
//            reports[REQUEST_HEADER] = [RequestHeader getRequestHeader];
//            reports[kCustomerBillId] = @(isCustomerBillId);
//
//            NSError * err;
//            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reports options:0 error:&err];
//            NSString * reportsJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//
//            SalesServiceSvcSoapBinding *salesBindng =  [SalesServiceSvc SalesServiceSvcSoapBinding] ;
//            SalesServiceSvc_getSalesReports *aParameters =  [[SalesServiceSvc_getSalesReports alloc] init];
//
//
//            aParameters.searchCriteria = reportsJsonString;
//            SalesServiceSvcSoapBindingResponse *response = [salesBindng getSalesReportsUsingParameters:aParameters];
//
//            NSArray *responseBodyParts = response.bodyParts;
//
//            for (id bodyPart in responseBodyParts) {
//                if ([bodyPart isKindOfClass:[SalesServiceSvc_getSalesReportsResponse class]]) {
//                    SalesServiceSvc_getSalesReportsResponse *body = (SalesServiceSvc_getSalesReportsResponse *)bodyPart;
//                    printf("\nresponse=%s",(body.return_).UTF8String);
//
//
//                    NSError *e;
//                    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
//                                                                         options: NSJSONReadingMutableContainers
//                                                                           error: &e];
//
//                    if (![body.return_ isKindOfClass:[NSNull class]]) {
//
//                        NSDictionary  *json1 = JSON[RESPONSE_HEADER];
//
//                        if ([json1[RESPONSE_CODE]intValue] == 0) {
//
//                            if ([[JSON valueForKey:BILLLSSUMMARY_LIST] count] > 0) {
//                                @try {
//                                    [counterIdArr addObjectsFromArray:[JSON valueForKey:BILLLSSUMMARY_LIST]];
//                                }
//                                @catch (NSException *exception) {
//
//                                }
//                            }
//                            [HUD setHidden:YES];
//                        }
//
//                        else {
//
//                        }
//                    }
//                    else {
//                        [HUD setHidden:YES];
//                    }
//                }
//            }
//
//            [salesTableView reloadData];
//        }
//        @catch (NSException *exception) {
//
//            [HUD setHidden:YES];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Failed to get the reports" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//
//        }
//    }
//    else {
//        currentdate = [currentdate componentsSeparatedByString:@" "][0];
//        OfflineBillingServices *offline = [[OfflineBillingServices alloc]init];
//        NSMutableArray *result = [offline getCompletedBills:@"" fromDate:currentdate];
//        counterIdArr = [[NSMutableArray alloc] initWithArray:result];
//        if (counterIdArr.count == 0){
//
//            //changeID--;
//            [HUD setHidden:YES];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Records Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//
//            startDateTxt.text = @"";
//
//        }
//        [HUD setHidden:YES];
//        [salesTableView reloadData];
//    }
//}


//callingSalesServiceforRecords method changed by roja on 17/10/2019.. // reason : removed SOAP service call related code and  added REST service call code...
// At the time of converting SOAP call's to REST
-(void) callingSalesServiceforRecords{
    
    NSDate *today = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"dd/MM/yyyy";
    NSString* currentdate = [f stringFromDate:today];
    
    if ((startDateTxt.text).length>0) {
        
        currentdate = [startDateTxt.text copy];
    }
    
    if (!isOfflineService) {
        
        @try {
            
            [HUD setHidden:NO];
            
            NSMutableDictionary *reports = [[NSMutableDictionary alloc]init];
            reports[@"date"] = [NSString stringWithFormat:@"%@%@",dateStr,@" 00:00:00"];
            reports[@"startTime"] = @"";
            reports[@"endtime"] = @"";
            reports[@"shiftId"] = shiftId;
            reports[@"paymentMode"] = @"";
            reports[@"store_location"] = presentLocation;
            reports[@"searchCriteria"] = @"billSummery";
            reports[@"counterId"] = @"";
            reports[@"startIndex"] = [NSString stringWithFormat:@"%d",reportStartIndex];
            reports[@"requiredRecords"] = [NSString stringWithFormat:@"%d",10];
            
            reports[REQUEST_HEADER] = [RequestHeader getRequestHeader];
            reports[kCustomerBillId] = @(isCustomerBillId);
            
            NSError * err;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reports options:0 error:&err];
            NSString * reportsJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            WebServiceController * services = [[WebServiceController alloc] init];
            services.salesServiceDelegate = self;
            [services getSalesReport:reportsJsonString];
            
        }
        @catch (NSException *exception) {
            
            [HUD setHidden:YES];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Failed to get the reports" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else {
        currentdate = [currentdate componentsSeparatedByString:@" "][0];
        OfflineBillingServices *offline = [[OfflineBillingServices alloc]init];
        NSMutableArray *result = [offline getCompletedBills:@"" fromDate:currentdate];
        counterIdArr = [[NSMutableArray alloc] initWithArray:result];
        if (counterIdArr.count == 0){
            
            //changeID--;
            [HUD setHidden:YES];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Records Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            startDateTxt.text = @"";
        }
        [HUD setHidden:YES];
        [salesTableView reloadData];
    }
}

// added by Roja on 17/10/2019…. // OLD code only written here
- (void)getSalesReportsSuccessResponse:(NSDictionary *)successDictionary{

    @try {
        
        if ([[successDictionary valueForKey:BILLLSSUMMARY_LIST] count] > 0) {

            [counterIdArr addObjectsFromArray:[successDictionary valueForKey:BILLLSSUMMARY_LIST]];
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
        [salesTableView reloadData];

    }
}

// added by Roja on 17/10/2019…. // OLD code only written here
- (void)getSalesReportsErrorResponse:(NSString *)errorResponse{

    @try {

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:errorResponse delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
        [salesTableView reloadData];

    }
}




// handle getDate method for pick date from calendar.
-(IBAction)getDate:(id)sender
{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    fromOrderButton.enabled = YES;
    getReportBtn.enabled = YES;
    
    //Date Formate Setting...
    
    NSDateFormatter *sdayFormat = [[NSDateFormatter alloc] init];
    sdayFormat.dateFormat = @"dd/MM/yyyy HH:mm:ss";
    dateString = [sdayFormat stringFromDate:myPicker.date];
    
    if ([tag.text isEqualToString:@"1"]) {
        
        fromOrder.text = dateString;
    }

    [pickView removeFromSuperview];
}

//// Hidden TextFields...
//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    
//    [fromOrder resignFirstResponder];
//    [bill resignFirstResponder];
//    return YES;
//}

/** Table Implementation */

#pragma mark Table view methods

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == salesTableView) {
        return counterIdArr.count;
    }
    else {
        return counterIds.count;
    }
    
}


//Customize eightForRowAtIndexPath ...
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == salesTableView) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            return 40;
        }
        else{
            return 40;
        }
    }
    return 40;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == salesTableView) {
        
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
            UILabel * billID_Lbl;
            UILabel * totalAmt_Lbl;
            UILabel * cashAmt_Lbl;
            UILabel * cardAmt_Lbl;
            UILabel * returnedAmt_Lbl;
            UILabel * exchangeAmt_Lbl;
            UILabel * sodexoAmt_Lbl;
            UILabel * ticketTotalAmt_Lbl;
            UILabel * creditNote_Lbl;
            UILabel * giftVouchers_Lbl;
            UILabel * creditsAmt_Lbl;
            
            /*Creation of UILabels used in this cell*/
            s_no_Lbl = [[UILabel alloc] init];
            s_no_Lbl.backgroundColor = [UIColor clearColor];
            s_no_Lbl.textAlignment = NSTextAlignmentCenter;
            s_no_Lbl.numberOfLines = 1;
            s_no_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

            billID_Lbl = [[UILabel alloc] init];
            billID_Lbl.backgroundColor = [UIColor clearColor];
            billID_Lbl.textAlignment = NSTextAlignmentCenter;
            billID_Lbl.numberOfLines = 1;
            billID_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            totalAmt_Lbl = [[UILabel alloc] init];
            totalAmt_Lbl.backgroundColor = [UIColor clearColor];
            totalAmt_Lbl.textAlignment = NSTextAlignmentCenter;
            totalAmt_Lbl.numberOfLines = 1;
            totalAmt_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            cashAmt_Lbl = [[UILabel alloc] init];
            cashAmt_Lbl.backgroundColor = [UIColor clearColor];
            cashAmt_Lbl.textAlignment = NSTextAlignmentCenter;
            cashAmt_Lbl.numberOfLines = 1;
            cashAmt_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

            cardAmt_Lbl = [[UILabel alloc] init];
            cardAmt_Lbl.backgroundColor = [UIColor clearColor];
            cardAmt_Lbl.textAlignment = NSTextAlignmentCenter;
            cardAmt_Lbl.numberOfLines = 1;
            cardAmt_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

            returnedAmt_Lbl = [[UILabel alloc] init];
            returnedAmt_Lbl.backgroundColor = [UIColor clearColor];
            returnedAmt_Lbl.textAlignment = NSTextAlignmentCenter;
            returnedAmt_Lbl.numberOfLines = 1;
            returnedAmt_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            exchangeAmt_Lbl = [[UILabel alloc] init];
            exchangeAmt_Lbl.backgroundColor = [UIColor clearColor];
            exchangeAmt_Lbl.textAlignment = NSTextAlignmentCenter;
            exchangeAmt_Lbl.numberOfLines = 1;
            exchangeAmt_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

            sodexoAmt_Lbl = [[UILabel alloc] init];
            sodexoAmt_Lbl.backgroundColor = [UIColor clearColor];
            sodexoAmt_Lbl.textAlignment = NSTextAlignmentCenter;
            sodexoAmt_Lbl.numberOfLines = 1;
            sodexoAmt_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            ticketTotalAmt_Lbl = [[UILabel alloc] init];
            ticketTotalAmt_Lbl.backgroundColor = [UIColor clearColor];
            ticketTotalAmt_Lbl.textAlignment = NSTextAlignmentCenter;
            ticketTotalAmt_Lbl.numberOfLines = 1;
            ticketTotalAmt_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

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
            
            creditsAmt_Lbl = [[UILabel alloc] init];
            creditsAmt_Lbl.backgroundColor = [UIColor clearColor];
            creditsAmt_Lbl.textAlignment = NSTextAlignmentCenter;
            creditsAmt_Lbl.numberOfLines = 1;
            creditsAmt_Lbl.lineBreakMode = NSLineBreakByWordWrapping;

            viewButton = [[UIButton alloc] init];
            viewButton.backgroundColor = [UIColor blackColor];
            viewButton.titleLabel.textColor =  [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
            viewButton.userInteractionEnabled = YES;
            viewButton.tag = indexPath.row;
            [viewButton setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0] forState:UIControlStateNormal];
            [viewButton setTitle:NSLocalizedString(@"View",nil) forState:UIControlStateNormal];
            
            [viewButton addTarget:self action:@selector(showView:) forControlEvents:UIControlEventTouchUpInside];
            
            
            s_no_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            billID_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            totalAmt_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            cashAmt_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            cardAmt_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            returnedAmt_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            exchangeAmt_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            sodexoAmt_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            ticketTotalAmt_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            creditNote_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            giftVouchers_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            creditsAmt_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

            
            [hlcell.contentView addSubview:s_no_Lbl];
            [hlcell.contentView addSubview:billID_Lbl];
            [hlcell.contentView addSubview:totalAmt_Lbl];
            [hlcell.contentView addSubview:cashAmt_Lbl];
            [hlcell.contentView addSubview:cardAmt_Lbl];
            [hlcell.contentView addSubview:returnedAmt_Lbl];
            [hlcell.contentView addSubview:exchangeAmt_Lbl];
            [hlcell.contentView addSubview:sodexoAmt_Lbl];
            [hlcell.contentView addSubview:ticketTotalAmt_Lbl];
            [hlcell.contentView addSubview:creditNote_Lbl];
            [hlcell.contentView addSubview:giftVouchers_Lbl];
            [hlcell.contentView addSubview:creditsAmt_Lbl];
            [hlcell.contentView addSubview:viewButton];
            
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                s_no_Lbl.frame = CGRectMake(0,0,snoLbl.frame.size.width,hlcell.frame.size.height);
                billID_Lbl.frame = CGRectMake(billIDLbl.frame.origin.x,0,billIDLbl.frame.size.width,hlcell.frame.size.height);
                totalAmt_Lbl.frame = CGRectMake(totalAmtLbl.frame.origin.x,0,totalAmtLbl.frame.size.width,hlcell.frame.size.height);
                
                cashAmt_Lbl.frame = CGRectMake(cashAmtLbl.frame.origin.x,0,cashAmtLbl.frame.size.width,hlcell.frame.size.height);

                cardAmt_Lbl.frame = CGRectMake(cardAmtLbl.frame.origin.x,0,cardAmtLbl.frame.size.width,hlcell.frame.size.height);

                returnedAmt_Lbl.frame = CGRectMake(returnedAmtLbl.frame.origin.x,0,returnedAmtLbl.frame.size.width,hlcell.frame.size.height);
                
                exchangeAmt_Lbl.frame = CGRectMake(exchangedAmtLbl.frame.origin.x,0,exchangedAmtLbl.frame.size.width,hlcell.frame.size.height);
                
                sodexoAmt_Lbl.frame = CGRectMake(sodexoAmtLbl.frame.origin.x,0,sodexoAmtLbl.frame.size.width,hlcell.frame.size.height);
                
                ticketTotalAmt_Lbl.frame = CGRectMake(tickectAmtLbl.frame.origin.x,0,tickectAmtLbl.frame.size.width,hlcell.frame.size.height);
                
                creditNote_Lbl.frame = CGRectMake(creditNoteLbl.frame.origin.x,0,creditNoteLbl.frame.size.width,hlcell.frame.size.height);
                
                giftVouchers_Lbl.frame = CGRectMake(giftVouchersLbl.frame.origin.x,0,giftVouchersLbl.frame.size.width,hlcell.frame.size.height);
                
                creditsAmt_Lbl.frame = CGRectMake(creditsAmtLbl.frame.origin.x,0,creditsAmtLbl.frame.size.width,hlcell.frame.size.height);
                
                viewButton.frame = CGRectMake(actionLbl.frame.origin.x,0, actionLbl.frame.size.width, hlcell.frame.size.height);
            }
            
            else{
                
                //Code for the iPhone...
            }
            
            
            //setting font size....
            [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:15.0f cornerRadius:0.0];
            
            viewButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:17.0];

            //appending values in the cell from DataBase...
            
            if (counterIdArr.count >= indexPath.row && counterIdArr.count) {
                
                NSDictionary * dic  = counterIdArr[indexPath.row];
                
                s_no_Lbl.text = [NSString stringWithFormat:@"%d",(indexPath.row+1)];
                
                billID_Lbl.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"billId"]];
                
                totalAmt_Lbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:@"amount"] defaultReturn:@"0.00"] floatValue]];;
               
                
                float cashAmount = 0.0f;
                float cardAmount = 0.0f;
                float sodexoAmount = 0.0f;
                float returnAmount = 0.0f;
                float ticketAmount = 0.0f;
                float voucherTotal_1 = 0.0f;
                float couponTotal_1 = 0.0f;
                float creditTotal_1 =0.0f;
                float creditNote_1 = 0.0f;
                float loyaltyPoints_1 = 0.0f;

                for (NSDictionary * transDic in [dic valueForKey:@"transactions"]) {

                    if ([[transDic valueForKey:@"paymentMode"] isEqualToString:@"Cash"]) {
                        cashAmount += [[transDic valueForKey:@"amount"] floatValue];
                    }
                    else if ([[transDic valueForKey:@"paymentMode"] isEqualToString:@"Card"]) {
                        cardAmount += [[transDic valueForKey:@"amount"] floatValue];
                    }
                    else if ([[transDic valueForKey:@"paymentMode"] isEqualToString:@"Sodexo"]) {
                        sodexoAmount += [[transDic valueForKey:@"amount"] floatValue];
                    }
                    else if ([[transDic valueForKey:@"paymentMode"] isEqualToString:@"Ticket"]) {
                        ticketAmount += [[transDic valueForKey:@"amount"] floatValue];
                    }
                    else if([[transDic valueForKey:@"paymentMode"] isEqualToString:@"giftvoucher"]){
                        voucherTotal_1 +=[[transDic valueForKey:@"amount"] floatValue];
                    }
                    
                    else if([[transDic valueForKey:@"paymentMode"] isEqualToString:@"coupon"]){
                        couponTotal_1 +=[[transDic valueForKey:@"amount"]floatValue];
                    }
                    
                    else if([[transDic valueForKey:@"paymentMode"] isEqualToString:@"Credit Note"]){
                        creditNote_1 +=[[transDic valueForKey:@"amount"]floatValue];
                    }
                    
                    else if([[transDic valueForKey:@"paymentMode"] caseInsensitiveCompare:@"credits"] == NSOrderedSame){
                        creditTotal_1 +=[[transDic valueForKey:@"amount"]floatValue];
                    }
                    
                    else if([[transDic valueForKey:@"paymentMode"] isEqualToString:@"Loyalty Points"]){
                        loyaltyPoints_1 +=[[transDic valueForKey:@"amount"]floatValue];
                    }
                    
                    if (![[transDic valueForKey:@"returnAmount"] isKindOfClass:[NSNull class]]) {
                        returnAmount += [[transDic valueForKey:@"returnAmount"] floatValue];
                    }
                    else {
                        returnAmount += 0.0;
                    }
                }
                
                cashAmt_Lbl.text = [NSString stringWithFormat:@"%@%.2f",@"",cashAmount];
                cardAmt_Lbl.text = [NSString stringWithFormat:@"%@%.2f",@"",cardAmount];
                returnedAmt_Lbl.text = [NSString stringWithFormat:@"%@%.2f",@"",returnAmount];
                
                exchangeAmt_Lbl.text =[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:@"exchangedAmt"] defaultReturn:@"0.00"] floatValue]];
                
                sodexoAmt_Lbl.text = [NSString stringWithFormat:@"%@%.2f",@"",sodexoAmount];
                ticketTotalAmt_Lbl.text = [NSString stringWithFormat:@"%@%.2f",@"",ticketAmount];
                creditNote_Lbl.text = [NSString stringWithFormat:@"%@%.2f",@"",creditNote_1];
                giftVouchers_Lbl.text = [NSString stringWithFormat:@"%@%.2f",@"",voucherTotal_1];
                creditsAmt_Lbl.text = [NSString stringWithFormat:@"%@%.2f",@"",creditTotal_1];
            }
            
        } @catch (NSException *exception) {
            
        } @finally {
            hlcell.backgroundColor = [UIColor clearColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            return hlcell;

        }
        
    }
    
     }
    


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    UITableViewCell* theCell = [tableView cellForRowAtIndexPath:indexPath];
    theCell.contentView.backgroundColor=[UIColor clearColor];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == salesTableView){
        
        @try {
            
            
            NSDictionary *summaryDic = counterIdArr[indexPath.row];
            NSString *billID = @"";
            if (!isOfflineService) {
                billID = [summaryDic valueForKey:@"billId"];
            }
            else {
                billID = [summaryDic valueForKey:@"bill_id"];
            }
            PastBilling *openBill = [[PastBilling alloc] initWithBillType:billID];
            billTypeStatus = TRUE;
            typeBilling = @"completed";
            openBill.billingType = @"completed";
            openBill.isBillSummery = true;
            
            [self.navigationController pushViewController:openBill animated:YES];
        

            
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    @try {
        
        if(tableView == salesTableView){
            
            @try {
                
                if ((indexPath.row == (counterIdArr.count -1)) && (counterIdArr.count < totalRecordsInt ) && (counterIdArr.count> reportStartIndex )) {
                    
                    [HUD show:YES];
                    [HUD setHidden:NO];
                    reportStartIndex = reportStartIndex + 10;
                    [self callingSalesServiceforRecords];
                    //[salesTableView reloadData];
                    
                }
                
            } @catch (NSException *exception) {
                NSLog(@"-----------exception in servicecall-------------%@",exception);
                [HUD setHidden:YES];
            }
        }
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

-(void)showView:(UIButton*)sender {
    
    @try {
        
        NSDictionary *summaryDic = counterIdArr[sender.tag];
        NSString *billID = @"";
        if (!isOfflineService) {
            billID = [summaryDic valueForKey:@"billId"];
        }
        else {
            billID = [summaryDic valueForKey:@"bill_id"];
        }
        PastBilling *openBill = [[PastBilling alloc] initWithBillType:billID];
        billTypeStatus = TRUE;
        typeBilling = @"completed";
        openBill.billingType = @"completed";
        openBill.isBillSummery = true;
        
        [self.navigationController pushViewController:openBill animated:YES];

    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}
    



-(void)goToHome {
    
    OmniHomePage *home = [[OmniHomePage alloc]init];
    [self.navigationController pushViewController:home animated:YES];
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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


@end
