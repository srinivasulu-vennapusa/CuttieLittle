//
//  CompletedBills.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 10/30/15.
//
//

#import "CompletedBills.h"
#import "CellView_TakeAwayOrder.h"
#import "SalesServiceSvc.h"
#import "PastBilling.h"
#import "Global.h"
#import "OfflineBillingServices.h"
#import "OmniHomePage.h"

@interface CompletedBills ()

@end

@implementation CompletedBills

@synthesize soundFileURLRef,soundFileObject;


int completed_bill_no = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
//    [[NSNotificationCenter defaultCenter] addObserver: self selector:@selector(deviceOrientationDidChange:) name: UIDeviceOrientationDidChangeNotification object: nil];
    
    currentOrientation = [UIDevice currentDevice].orientation;
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    
    //main view bakgroung setting...
    self.view.backgroundColor = [UIColor blackColor];
    
    version =  [UIDevice currentDevice].systemVersion.floatValue;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    /** SearchBarItem*/
    const NSInteger searchBarHeight = 40;
    searchBar = [[UISearchBar alloc] init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        searchBar.frame = CGRectMake(0, 80, 768, 50);
        
    }
    else {
        
        searchBar.frame = CGRectMake(0, 0, 320, searchBarHeight);
    }
    searchBar.delegate = self;
    
    self.searchDisplayController.searchBar.translucent = NO;
    self.searchDisplayController.searchBar.backgroundColor = [UIColor clearColor];
    
    self.titleLabel.text = @"COMPLETED BILLS";
    
    billSummaryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    // pay the cash button to continue the transaction ..
    [billSummaryButton addTarget:self action:@selector(showBillSummary) forControlEvents:UIControlEventTouchUpInside];
    [billSummaryButton setTitle:@"Bill Summary"    forState:UIControlStateNormal];
    billSummaryButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    billSummaryButton.titleLabel.textColor = [UIColor whiteColor];
    billSummaryButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0f];
    billSummaryButton.backgroundColor = [UIColor grayColor];
    billSummaryButton.layer.cornerRadius = 20.0f;

    
    pendingHeaderView = [[UIView alloc] init];
    
    order_Id = [[UILabel alloc] init] ;
    order_Id.layer.cornerRadius = 14;
    order_Id.textAlignment = NSTextAlignmentCenter;
    order_Id.layer.masksToBounds = YES;
    order_Id.font = [UIFont boldSystemFontOfSize:14.0];
    order_Id.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    order_Id.textColor = [UIColor whiteColor];
    order_Id.text = @"Bill Id";
    
    
    totalAmtLbl = [[UILabel alloc] init] ;
    totalAmtLbl.layer.cornerRadius = 12;
    totalAmtLbl.textAlignment = NSTextAlignmentCenter;
    totalAmtLbl.layer.masksToBounds = YES;
    totalAmtLbl.font = [UIFont boldSystemFontOfSize:14.0];
    totalAmtLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    totalAmtLbl.textColor = [UIColor whiteColor];
    totalAmtLbl.text = @"Total Amt";
    
    sodexoAmtLbl = [[UILabel alloc] init] ;
    sodexoAmtLbl.layer.cornerRadius = 14;
    sodexoAmtLbl.textAlignment = NSTextAlignmentCenter;
    sodexoAmtLbl.layer.masksToBounds = YES;
    sodexoAmtLbl.font = [UIFont boldSystemFontOfSize:14.0];
    sodexoAmtLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    sodexoAmtLbl.textColor = [UIColor whiteColor];
    sodexoAmtLbl.text = @"Sodexo Amt";
    
    cashAmtLbl = [[UILabel alloc] init] ;
    cashAmtLbl.layer.cornerRadius = 14;
    cashAmtLbl.textAlignment = NSTextAlignmentCenter;
    cashAmtLbl.layer.masksToBounds = YES;
    cashAmtLbl.font = [UIFont boldSystemFontOfSize:14.0];
    cashAmtLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    cashAmtLbl.textColor = [UIColor whiteColor];
    cashAmtLbl.text = @"Cash Amt";
    
    cardAmtLbl = [[UILabel alloc] init] ;
    cardAmtLbl.layer.cornerRadius = 14;
    cardAmtLbl.textAlignment = NSTextAlignmentCenter;
    cardAmtLbl.layer.masksToBounds = YES;
    cardAmtLbl.font = [UIFont boldSystemFontOfSize:14.0];
    cardAmtLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    cardAmtLbl.textColor = [UIColor whiteColor];
    cardAmtLbl.text = @"Card Total";
    
    ticketAmtLbl = [[UILabel alloc] init] ;
    ticketAmtLbl.layer.cornerRadius = 14;
    ticketAmtLbl.textAlignment = NSTextAlignmentCenter;
    ticketAmtLbl.layer.masksToBounds = YES;
    ticketAmtLbl.font = [UIFont boldSystemFontOfSize:14.0];
    ticketAmtLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    ticketAmtLbl.textColor = [UIColor whiteColor];
    ticketAmtLbl.text = @"Ticket Total";

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
            
            order_Id.font = [UIFont boldSystemFontOfSize:20];
            order_Id.frame = CGRectMake(30, 130, 150, 40);
            totalAmtLbl .font = [UIFont boldSystemFontOfSize:20];
            totalAmtLbl.frame = CGRectMake(210, 130, 150, 40);
            cashAmtLbl.font = [UIFont boldSystemFontOfSize:20];
            cashAmtLbl.frame = CGRectMake(390, 130, 120, 40);
            cardAmtLbl.font = [UIFont boldSystemFontOfSize:20];
            cardAmtLbl.frame = CGRectMake(530, 130, 120, 40);
            sodexoAmtLbl.font = [UIFont boldSystemFontOfSize:20];
            sodexoAmtLbl.frame = CGRectMake(670, 130, 150, 40);
            ticketAmtLbl.font = [UIFont boldSystemFontOfSize:20];
            ticketAmtLbl.frame = CGRectMake(840, 130, 150, 40);
        }
        else {
            order_Id.font = [UIFont boldSystemFontOfSize:20];
            order_Id.frame = CGRectMake(30, 160, 150, 45);
            totalAmtLbl .font = [UIFont boldSystemFontOfSize:20];
            totalAmtLbl.frame = CGRectMake(285, 160, 150, 45);
            sodexoAmtLbl.font = [UIFont boldSystemFontOfSize:20];
            sodexoAmtLbl.frame = CGRectMake(550, 160, 150, 45);
            ticketAmtLbl.font = [UIFont boldSystemFontOfSize:20];
            ticketAmtLbl.frame = CGRectMake(550, 160, 150, 45);
        }
        
        
        
    }
    else {
        
        order_Id.font = [UIFont boldSystemFontOfSize:15];
        order_Id.frame = CGRectMake(0, 35, 70, 30);
        totalAmtLbl .font = [UIFont boldSystemFontOfSize:15];
        totalAmtLbl.frame = CGRectMake(135, 35, 70, 30);
        sodexoAmtLbl.font = [UIFont boldSystemFontOfSize:15];
        sodexoAmtLbl.frame = CGRectMake(245, 35, 70, 30);
        
    }
    
    [pendingHeaderView addSubview:order_Id];
    [pendingHeaderView addSubview:totalAmtLbl];
    [pendingHeaderView addSubview:sodexoAmtLbl];
    [pendingHeaderView addSubview:cashAmtLbl];
    [pendingHeaderView addSubview:cardAmtLbl];
    [pendingHeaderView addSubview:ticketAmtLbl];
    [self.view addSubview:pendingHeaderView];
    
    completedBillsTable.tableHeaderView = pendingHeaderView;
    
    /** Table Creation*/
    completedBillsTable = [[UITableView alloc] init];
    completedBillsTable.separatorColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
    completedBillsTable.dataSource = self;
    completedBillsTable.delegate = self;
    completedBillsTable.backgroundColor = [UIColor clearColor];
    completedBillsTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    pastBillField = [[UITextField alloc] init];
    pastBillField.borderStyle = UITextBorderStyleRoundedRect;
    pastBillField.textColor = [UIColor blackColor];
    pastBillField.font = [UIFont systemFontOfSize:18.0];
    pastBillField.backgroundColor = [UIColor clearColor];
    pastBillField.clearButtonMode = UITextFieldViewModeWhileEditing;
    pastBillField.backgroundColor = [UIColor whiteColor];
    pastBillField.autocorrectionType = UITextAutocorrectionTypeNo;
    // pastBillField.backgroundColor = [UIColor whiteColor];
    pastBillField.returnKeyType = UIReturnKeyDone;
    [pastBillField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    pastBillField.placeholder = @"Search Bill ID";
    pastBillField.delegate = self;
    
    
    salesIdTable = [[UITableView alloc] init];
    salesIdTable.layer.borderWidth = 1.0;
    salesIdTable.layer.cornerRadius = 4.0;
    salesIdTable.layer.borderColor = [UIColor grayColor].CGColor;
    salesIdTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    salesIdTable.dataSource = self;
    salesIdTable.delegate = self;
    salesIdTable.hidden = YES;
    
    ordersDate = [[UITextField alloc] init];
    ordersDate.borderStyle = UITextBorderStyleRoundedRect;
    ordersDate.textColor = [UIColor blackColor];
    ordersDate.placeholder = @"from";  //place holder
    ordersDate.backgroundColor = [UIColor whiteColor];
    ordersDate.autocorrectionType = UITextAutocorrectionTypeNo;
    ordersDate.keyboardType = UIKeyboardTypeDefault;
    ordersDate.returnKeyType = UIReturnKeyDone;
    ordersDate.clearButtonMode = UITextFieldViewModeWhileEditing;
    ordersDate.userInteractionEnabled = NO;
    ordersDate.delegate = self;
    ordersDate.text = [NSString stringWithFormat:@"%@",[defaults valueForKey:BUSSINESS_DATE]];
    
    orderDateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    UIImage *buttonImageDD = [UIImage imageNamed:@"combo.png"];
    [orderDateButton setBackgroundImage:buttonImageDD forState:UIControlStateNormal];
    [orderDateButton addTarget:self
                        action:@selector(DateButtonPressed:) forControlEvents:UIControlEventTouchDown];
    orderDateButton.tag = 1;
    
    /** Design of Go Button*/
    getBillsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [getBillsBtn addTarget:self action:@selector(getCompletedBills) forControlEvents:UIControlEventTouchDown];
    [getBillsBtn setTitle:@"GO" forState:UIControlStateNormal];
    getBillsBtn.backgroundColor = [UIColor grayColor];

    
    firstOrders = [UIButton buttonWithType:UIButtonTypeCustom];
    [firstOrders addTarget:self action:@selector(loadFirstPage:) forControlEvents:UIControlEventTouchDown];
    [firstOrders setImage:[UIImage imageNamed:@"mail_first.png"] forState:UIControlStateNormal];
    firstOrders.layer.cornerRadius = 3.0f;
    firstOrders.enabled = NO;
    
    lastOrders = [UIButton buttonWithType:UIButtonTypeCustom];
    [lastOrders addTarget:self action:@selector(loadLastPage:) forControlEvents:UIControlEventTouchDown];
    [lastOrders setImage:[UIImage imageNamed:@"mail_last.png"] forState:UIControlStateNormal];
    lastOrders.layer.cornerRadius = 3.0f;
    
    /** Create PreviousButton */
    previousOrders = [UIButton buttonWithType:UIButtonTypeCustom];
    [previousOrders addTarget:self
                       action:@selector(loadPreviousPage:) forControlEvents:UIControlEventTouchDown];
    [previousOrders setImage:[UIImage imageNamed:@"mail_prev.png"] forState:UIControlStateNormal];
    
    previousOrders.enabled =  NO;
    
    
    /** Create NextButton */
    nextOrders = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextOrders addTarget:self
                   action:@selector(loadNextPage:) forControlEvents:UIControlEventTouchDown];
    [nextOrders setImage:[UIImage imageNamed:@"mail_next.png"] forState:UIControlStateNormal];
    
    //bottom label1...
    orderStart = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    orderStart.text = @"";
    orderStart.textAlignment = NSTextAlignmentLeft;
    orderStart.backgroundColor = [UIColor clearColor];
    orderStart.textColor = [UIColor whiteColor];
    
    //bottom label_2...
    label1 = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    label1.text = @"-";
    label1.textAlignment = NSTextAlignmentLeft;
    label1.backgroundColor = [UIColor clearColor];
    label1.textColor = [UIColor whiteColor];
    
    //bottom label2...
    orderEnd = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    orderEnd.text = @"";
    orderEnd.textAlignment = NSTextAlignmentLeft;
    orderEnd.backgroundColor = [UIColor clearColor];
    orderEnd.textColor = [UIColor whiteColor];
    
    //bottom label_3...
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    label2.text = @"of";
    label2.textAlignment = NSTextAlignmentLeft;
    label2.backgroundColor = [UIColor clearColor];
    label2.textColor = [UIColor whiteColor];
    
    //bottom label3...
    totalOrder = [[UILabel alloc] initWithFrame:CGRectMake(3, 1, 120, 30)];
    totalOrder.textAlignment = NSTextAlignmentLeft;
    totalOrder.backgroundColor = [UIColor clearColor];
    totalOrder.textColor = [UIColor whiteColor];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
            
            mainSegmentedControl.frame = CGRectMake(-2, 65, 770, 60);
            mainSegmentedControl.tintColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
            mainSegmentedControl.backgroundColor = [UIColor clearColor];
            NSDictionary *attributes = @{UITextAttributeFont: [UIFont boldSystemFontOfSize:18],UITextAttributeTextColor: [UIColor whiteColor]};
            [mainSegmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
            
            pastBillField.font = [UIFont boldSystemFontOfSize:25];
            pastBillField.frame = CGRectMake(10, 75, 320, 40);
            salesIdTable.frame = CGRectMake(10, 108, 320, 280);
            
            ordersDate.frame = CGRectMake(340, 75, 250, 40);
            ordersDate.font = [UIFont systemFontOfSize:25.0];
            orderDateButton.frame = CGRectMake(553, 70, 50, 55);
            
            getBillsBtn.frame = CGRectMake(620, 75, 100, 40);
            getBillsBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            getBillsBtn.layer.cornerRadius = 15.0f;

            
            billSummaryButton.frame = CGRectMake(750.0, 75, 250.0, 40.0);

            
            completedBillsTable.frame = CGRectMake(0, 180, self.view.frame.size.width, self.view.frame.size.height-290);
            
            
            firstOrders.frame = CGRectMake(162, 700, 50, 50);
            firstOrders.layer.cornerRadius = 25.0f;
            firstOrders.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            
            lastOrders.frame = CGRectMake(705, 700, 50, 50);
            lastOrders.layer.cornerRadius = 25.0f;
            lastOrders.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            
            previousOrders.frame = CGRectMake(290, 700, 50, 50);
            previousOrders.layer.cornerRadius = 22.0f;
            previousOrders.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            
            nextOrders.frame = CGRectMake(580, 700, 50, 50);
            nextOrders.layer.cornerRadius = 22.0f;
            nextOrders.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            
            
            orderStart.frame = CGRectMake(375, 700, 100, 50);
            label1.frame = CGRectMake(415, 700, 30, 50);
            orderEnd.frame = CGRectMake(440, 700, 100, 50);
            label2.frame = CGRectMake(480, 700, 30, 50);
            totalOrder.frame = CGRectMake(515, 700, 100, 50);
            
            orderStart.font = [UIFont systemFontOfSize:25.0];
            label1.font = [UIFont systemFontOfSize:25.0];
            orderEnd.font = [UIFont systemFontOfSize:25.0];
            label2.font = [UIFont systemFontOfSize:25.0];
            totalOrder.font = [UIFont systemFontOfSize:25.0];
            
            
        }
        else {
            mainSegmentedControl.frame = CGRectMake(-2, 65, 770, 60);
            mainSegmentedControl.tintColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
            mainSegmentedControl.backgroundColor = [UIColor clearColor];
            NSDictionary *attributes = @{UITextAttributeFont: [UIFont boldSystemFontOfSize:18],UITextAttributeTextColor: [UIColor whiteColor]};
            [mainSegmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
            
            pastBillField.font = [UIFont boldSystemFontOfSize:30];
            pastBillField.frame = CGRectMake(180, 75, 360, 52);
            salesIdTable.frame = CGRectMake(180, 117, 360, 400);
            
            completedBillsTable.frame = CGRectMake(0, 210, 778, 700);
            
            
            firstOrders.frame = CGRectMake(82, 940, 50, 50);
            firstOrders.layer.cornerRadius = 25.0f;
            firstOrders.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            
            lastOrders.frame = CGRectMake(625, 940, 50, 50);
            lastOrders.layer.cornerRadius = 25.0f;
            lastOrders.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            
            previousOrders.frame = CGRectMake(210, 940, 50, 50);
            previousOrders.layer.cornerRadius = 22.0f;
            previousOrders.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            
            nextOrders.frame = CGRectMake(500, 940, 50, 50);
            nextOrders.layer.cornerRadius = 22.0f;
            nextOrders.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            
            
            orderStart.frame = CGRectMake(295, 940, 100, 50);
            label1.frame = CGRectMake(335, 940, 30, 50);
            orderEnd.frame = CGRectMake(360, 940, 100, 50);
            label2.frame = CGRectMake(400, 940, 30, 50);
            totalOrder.frame = CGRectMake(435, 940, 100, 50);
            
            orderStart.font = [UIFont systemFontOfSize:25.0];
            label1.font = [UIFont systemFontOfSize:25.0];
            orderEnd.font = [UIFont systemFontOfSize:25.0];
            label2.font = [UIFont systemFontOfSize:25.0];
            totalOrder.font = [UIFont systemFontOfSize:25.0];
            
            
        }
        
    }
    else {
        if (version >= 8.0) {
            
            mainSegmentedControl.backgroundColor = [UIColor clearColor];
            mainSegmentedControl.frame = CGRectMake(-2, 0.0, 324, 47);
            
            order_Id.font = [UIFont boldSystemFontOfSize:15];
            order_Id.frame = CGRectMake(10, 70, 70, 30);
            totalAmtLbl .font = [UIFont boldSystemFontOfSize:15];
            totalAmtLbl.frame = CGRectMake(135, 70, 70, 30);
            sodexoAmtLbl.font = [UIFont boldSystemFontOfSize:15];
            sodexoAmtLbl.frame = CGRectMake(245, 70, 70, 30);
            
            completedBillsTable.frame = CGRectMake(0, 105, 320, self.view.frame.size.height-180);
            
            firstOrders.frame = CGRectMake(10, self.view.frame.size.height-45, 40, 40);
            firstOrders.layer.cornerRadius = 15.0f;
            firstOrders.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            
            
            lastOrders.frame = CGRectMake(273, self.view.frame.size.height-45, 40, 40);
            lastOrders.layer.cornerRadius = 15.0f;
            lastOrders.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            
            previousOrders.frame = CGRectMake(70, self.view.frame.size.height-45, 40, 40);
            previousOrders.layer.cornerRadius = 15.0f;
            previousOrders.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            
            nextOrders.frame = CGRectMake(210, self.view.frame.size.height-45, 40, 40);
            nextOrders.layer.cornerRadius = 15.0f;
            nextOrders.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            
            orderStart.frame = CGRectMake(122, self.view.frame.size.height-45, 20, 30);
            label1.frame = CGRectMake(140, self.view.frame.size.height-45, 20, 30);
            orderEnd.frame = CGRectMake(148, self.view.frame.size.height-45, 20, 30);
            label2.frame = CGRectMake(167, self.view.frame.size.height-45, 20, 30);
            totalOrder.frame = CGRectMake(183, self.view.frame.size.height-45, 20, 30);
            
            orderStart.font = [UIFont systemFontOfSize:14.0];
            label1.font = [UIFont systemFontOfSize:14.0];
            orderEnd.font = [UIFont systemFontOfSize:14.0];
            label2.font = [UIFont systemFontOfSize:14.0];
            totalOrder.font = [UIFont systemFontOfSize:14.0];
        }
        else{
            pastBillField.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15];
            pastBillField.frame = CGRectMake(80, 0, 160, 30);
            salesIdTable.frame = CGRectMake(80, 30, 160, 200);
            
            completedBillsTable.frame = CGRectMake(0, 65, self.view.frame.size.width, 300);
            
            firstOrders.frame = CGRectMake(10, 375, 40, 40);
            firstOrders.layer.cornerRadius = 15.0f;
            firstOrders.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            
            
            lastOrders.frame = CGRectMake(273, 375, 40, 40);
            lastOrders.layer.cornerRadius = 15.0f;
            lastOrders.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            
            previousOrders.frame = CGRectMake(80, 375, 40, 40);
            previousOrders.layer.cornerRadius = 15.0f;
            previousOrders.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            
            nextOrders.frame = CGRectMake(210, 375, 40, 40);
            nextOrders.layer.cornerRadius = 15.0f;
            nextOrders.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            
            orderStart.frame = CGRectMake(122, 375, 20, 30);
            label1.frame = CGRectMake(140, 375, 20, 30);
            orderEnd.frame = CGRectMake(148, 375, 20, 30);
            label2.frame = CGRectMake(167, 375, 20, 30);
            totalOrder.frame = CGRectMake(183, 375, 20, 30);
            
            orderStart.font = [UIFont systemFontOfSize:14.0];
            label1.font = [UIFont systemFontOfSize:14.0];
            orderEnd.font = [UIFont systemFontOfSize:14.0];
            label2.font = [UIFont systemFontOfSize:14.0];
            totalOrder.font = [UIFont systemFontOfSize:14.0];
        }
        
        
    }
    [self.view addSubview:salesIdTable];
    [self.view addSubview:pastBillField];
    [self.view addSubview:ordersDate];
    [self.view addSubview:orderDateButton];
    [self.view  addSubview:getBillsBtn];
    [self.view addSubview:billSummaryButton];
    [self.view addSubview:completedBillsTable];
    [self.view  addSubview:firstOrders];
    [self.view  addSubview:lastOrders];
    [self.view  addSubview:previousOrders];
    [self.view  addSubview:nextOrders];
    [self.view  addSubview:orderStart];
    [self.view  addSubview:label1];
    [self.view  addSubview:orderEnd];
    [self.view  addSubview:label2];
    [self.view  addSubview:totalOrder];
    
    // initalize the arrays ..
    bill_ids = [[NSMutableArray alloc] init];
    cashTotalArr = [[NSMutableArray alloc] init];
    sodexoTotalsArr = [[NSMutableArray alloc] init];
    cardTotalArr = [[NSMutableArray alloc]init];
    totalPriceArr = [[NSMutableArray alloc]init];
    ticketTotalArr = [[NSMutableArray alloc]init];

}

- (void)deviceOrientationDidChange:(NSNotification *)notification {
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    
    if ((UIDeviceOrientationIsPortrait(orientation) ||UIDeviceOrientationIsPortrait(orientation)) ||
        (UIDeviceOrientationIsLandscape(orientation) || UIDeviceOrientationIsLandscape(orientation))) {
        //still saving the current orientation
        currentOrientation = orientation;
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
            
            order_Id.font = [UIFont boldSystemFontOfSize:20];
            order_Id.frame = CGRectMake(60, 160, 180, 45);
            totalAmtLbl .font = [UIFont boldSystemFontOfSize:20];
            totalAmtLbl.frame = CGRectMake(365, 160, 180, 45);
            sodexoAmtLbl.font = [UIFont boldSystemFontOfSize:20];
            sodexoAmtLbl.frame = CGRectMake(620, 160, 180, 45);
            
            pastBillField.font = [UIFont boldSystemFontOfSize:25];
            pastBillField.frame = CGRectMake(300, 75, 360, 52);
            salesIdTable.frame = CGRectMake(300, 117, 360, 280);
            
            completedBillsTable.frame = CGRectMake(0, 210, self.view.frame.size.width, self.view.frame.size.height-290);
            
            
            firstOrders.frame = CGRectMake(162, 700, 50, 50);
            firstOrders.layer.cornerRadius = 25.0f;
            firstOrders.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            
            lastOrders.frame = CGRectMake(705, 700, 50, 50);
            lastOrders.layer.cornerRadius = 25.0f;
            lastOrders.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            
            previousOrders.frame = CGRectMake(290, 700, 50, 50);
            previousOrders.layer.cornerRadius = 22.0f;
            previousOrders.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            
            nextOrders.frame = CGRectMake(580, 700, 50, 50);
            nextOrders.layer.cornerRadius = 22.0f;
            nextOrders.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            
            
            orderStart.frame = CGRectMake(375, 700, 100, 50);
            label1.frame = CGRectMake(415, 700, 30, 50);
            orderEnd.frame = CGRectMake(440, 700, 100, 50);
            label2.frame = CGRectMake(480, 700, 30, 50);
            totalOrder.frame = CGRectMake(515, 700, 100, 50);
            
            orderStart.font = [UIFont systemFontOfSize:25.0];
            label1.font = [UIFont systemFontOfSize:25.0];
            orderEnd.font = [UIFont systemFontOfSize:25.0];
            label2.font = [UIFont systemFontOfSize:25.0];
            totalOrder.font = [UIFont systemFontOfSize:25.0];
            
        }
        else {
            order_Id.font = [UIFont boldSystemFontOfSize:20];
            order_Id.frame = CGRectMake(30, 160, 150, 45);
            totalAmtLbl .font = [UIFont boldSystemFontOfSize:20];
            totalAmtLbl.frame = CGRectMake(285, 160, 150, 45);
            sodexoAmtLbl.font = [UIFont boldSystemFontOfSize:20];
            sodexoAmtLbl.frame = CGRectMake(550, 160, 150, 45);
            
            pastBillField.font = [UIFont boldSystemFontOfSize:30];
            pastBillField.frame = CGRectMake(180, 75, 360, 52);
            salesIdTable.frame = CGRectMake(180, 117, 360, 400);
            
            completedBillsTable.frame = CGRectMake(0, 210, 778, 700);
            
            
            firstOrders.frame = CGRectMake(82, 940, 50, 50);
            firstOrders.layer.cornerRadius = 25.0f;
            firstOrders.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            
            lastOrders.frame = CGRectMake(625, 940, 50, 50);
            lastOrders.layer.cornerRadius = 25.0f;
            lastOrders.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            
            previousOrders.frame = CGRectMake(210, 940, 50, 50);
            previousOrders.layer.cornerRadius = 22.0f;
            previousOrders.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            
            nextOrders.frame = CGRectMake(500, 940, 50, 50);
            nextOrders.layer.cornerRadius = 22.0f;
            nextOrders.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
            
            
            orderStart.frame = CGRectMake(295, 940, 100, 50);
            label1.frame = CGRectMake(335, 940, 30, 50);
            orderEnd.frame = CGRectMake(360, 940, 100, 50);
            label2.frame = CGRectMake(400, 940, 30, 50);
            totalOrder.frame = CGRectMake(435, 940, 100, 50);
            
            orderStart.font = [UIFont systemFontOfSize:25.0];
            label1.font = [UIFont systemFontOfSize:25.0];
            orderEnd.font = [UIFont systemFontOfSize:25.0];
            label2.font = [UIFont systemFontOfSize:25.0];
            totalOrder.font = [UIFont systemFontOfSize:25.0];
            
        }
        
        
        
    }
    
    [completedBillsTable reloadData];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    //ProgressBar creation...
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = @"Please wait...";
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    
    // Show the HUD
    [HUD show:YES];
    [HUD setHidden:NO];
    
    completed_bill_no = 0;
    
    [self getCompletedBills];
}

-(void)getCompletedBills {
    
    if (!isOfflineService) {
        @try {
            WebServiceController *service = [[WebServiceController alloc] init];
            service.getBillsDelegate = self;
            [service getBills:completedBillsTable deliveryType:@"" status:@"completed"];
        }
        @catch (NSException *exception) {
            
            NSLog(@"%@",exception.name);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry failed to get data" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        @finally {
            [HUD setHidden:YES];
        }
        
        
    }
    else {
        if (bill_ids.count > 0) {
            [bill_ids removeAllObjects];
            [totalPriceArr removeAllObjects];
            [cashTotalArr removeAllObjects];
            [cardTotalArr removeAllObjects];
            [sodexoTotalsArr removeAllObjects];
            [ticketTotalArr removeAllObjects];
        }
        OfflineBillingServices *offline = [[OfflineBillingServices alloc]init];
        NSMutableArray *result = [offline getCompletedBills:@"" fromDate:ordersDate.text];
        [HUD setHidden:YES];
        if (result.count>0) {
            
            totalOrder.text = result.lastObject;
            orderStart.text = [NSString stringWithFormat:@"%d",completed_bill_no+1];
            orderEnd.text = [NSString stringWithFormat:@"%d",(orderStart.text).intValue + 9];
            
            if ((totalOrder.text).intValue <= 10) {
                
                orderEnd.text = [NSString stringWithFormat:@"%d",(totalOrder.text).intValue];
                nextOrders.enabled =  NO;
                previousOrders.enabled = NO;
                firstOrders.enabled = NO;
                lastOrders.enabled = NO;
            }
            else{
                
                if (completed_bill_no == 0) {
                    
                    previousOrders.enabled = NO;
                    firstOrders.enabled = NO;
                    nextOrders.enabled = YES;
                    lastOrders.enabled = YES;
                }
                orderEnd.text = totalOrder.text;
                
                //                else if (([[result lastObject] intValue] -  (pending_bill_no+1)) < 10) {
                //
                //                    nextOrders.enabled = NO;
                //                    lastOrders.enabled = NO;
                //                    orderEnd.text = totalOrder.text;
                //                }
            }
            
            
            
            
            NSDictionary *temp;
            
            if (bill_ids.count!=0) {
                
                [bill_ids removeAllObjects];
                [cashTotalArr removeAllObjects];
                [sodexoTotalsArr removeAllObjects];
                [cardTotalArr removeAllObjects];
                [totalPriceArr removeAllObjects];
                [ticketTotalArr removeAllObjects];
            }
            
            for (int i=0; i< result.count-1 ; i++) {
                
                temp = result[i];
                
                [bill_ids addObject:temp[@"bill_id"]];
                [sodexoTotalsArr addObject:temp[@"sodexo_total"]];
                [totalPriceArr addObject:temp[@"total_price"]];
                [cashTotalArr addObject:temp[@"cash_total"]];
                
                [cardTotalArr addObject:temp[@"card_total"]];
                [ticketTotalArr addObject:temp[@"ticket_total"]];
                
            }
            
            [completedBillsTable reloadData];
            
            firstOrders.enabled = false;
            nextOrders.enabled = false;
            previousOrders.enabled = false;
            lastOrders.enabled = false;
            
        }
        else {
            [completedBillsTable reloadData];
            totalOrder.text = @"0";
            orderStart.text = @"0";
            orderEnd.text = @"0";

            firstOrders.enabled = false;
            nextOrders.enabled = false;
            previousOrders.enabled = false;
            lastOrders.enabled = false;
            [HUD setHidden:YES];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"No bills for given Date" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
}
#pragma -mark getBillingDelegateMethods
-(void)getBillsSuccesResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        
        totalOrder.text = [successDictionary[TOTAL_BILLS] stringValue];
        orderStart.text = [NSString stringWithFormat:@"%d",completed_bill_no+1];
        orderEnd.text = [NSString stringWithFormat:@"%d",(orderStart.text).intValue + 9];
        
        if ((totalOrder.text).intValue <= 10) {
            
            orderEnd.text = [NSString stringWithFormat:@"%d",(totalOrder.text).intValue];
            nextOrders.enabled =  NO;
            previousOrders.enabled = NO;
            firstOrders.enabled = NO;
            lastOrders.enabled = NO;
        }
        else{
            
            if (completed_bill_no == 0) {
                
                previousOrders.enabled = NO;
                firstOrders.enabled = NO;
                nextOrders.enabled = YES;
                lastOrders.enabled = YES;
            }
            else if (([successDictionary[TOTAL_BILLS] intValue] -  (completed_bill_no+1)) < 10) {
                
                nextOrders.enabled = NO;
                lastOrders.enabled = NO;
                orderEnd.text = totalOrder.text;
            }
        }
        
        NSArray *response_Arr = [successDictionary valueForKey:BILL_LIST];
        
        NSDictionary *temp;
        
        if (bill_ids.count!=0) {
            
            [bill_ids removeAllObjects];
            [cashTotalArr removeAllObjects];
            [sodexoTotalsArr removeAllObjects];
            [cardTotalArr removeAllObjects];
            [totalPriceArr removeAllObjects];
            [ticketTotalArr removeAllObjects];
        }
        
        for (int i=0; i< response_Arr.count ; i++) {
            
            temp = response_Arr[i];
            
            [bill_ids addObject:temp[BILL_ID]];
            [sodexoTotalsArr addObject:temp[BILL_DUE]];
            [totalPriceArr addObject:temp[BILL_DATE]];
            [cashTotalArr addObject:temp[COUNTER]];
            if (![temp[CUSTOMER_NAME] isKindOfClass:[NSNull class]]) {
                
                [cardTotalArr addObject:temp[CUSTOMER_NAME]];
                
            }
            else {
                [cardTotalArr addObject:@"-"];
                
            }
        }
        // totalOrder.text = [json1 objectForKey:@"totalOrders"];
        
        [HUD setHidden:YES];
        
        if (bill_ids.count == 0) {
            totalOrder.text = @"0";
            orderStart.text = @"0";
            orderEnd.text = @"0";
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Door Delivery Bills not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        [completedBillsTable reloadData];
    }
    @catch (NSException *exception) {
        
        NSLog(@"Exception %@",exception);
    }
    @finally {
        [HUD setHidden:YES];
    }
    
}
-(void)getBillsFailureResponse:(NSString *)failureString {
    [HUD setHidden:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:failureString message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    
}

#pragma -mark end of delegates

-(void)showBillSummary {
    
    
    PopOverViewController  *billSummaryInfoPopup = [[PopOverViewController alloc] init];
    
    UIView *billSummaryView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 380, 250)];
    billSummaryView.opaque = NO;
    billSummaryView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    billSummaryView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    billSummaryView.layer.borderWidth = 2.0f;
    [billSummaryView setHidden:NO];
    
    UILabel *totalBillAmt = [[UILabel alloc] init];
    totalBillAmt.textColor = [UIColor blackColor];
    totalBillAmt.font = [UIFont boldSystemFontOfSize:18.0];
    totalBillAmt.text  = @"Total Amount";
    
    totalBillAmtValue = [[UILabel alloc] init];
    totalBillAmtValue.textColor = [UIColor blackColor];
    totalBillAmtValue.font = [UIFont boldSystemFontOfSize:18.0];
    
    
    UILabel *totalCashAmt = [[UILabel alloc] init];
    totalCashAmt.textColor = [UIColor blackColor];
    totalCashAmt.font = [UIFont boldSystemFontOfSize:18.0];
    totalCashAmt.text  = @"Total Cash Amt";
    
    totalCashAmtVal = [[UILabel alloc] init];
    totalCashAmtVal.textColor = [UIColor blackColor];
    totalCashAmtVal.font = [UIFont boldSystemFontOfSize:18.0];
    
    
    UILabel *totalCardAmt = [[UILabel alloc] init];
    totalCardAmt.textColor = [UIColor blackColor];
    totalCardAmt.font = [UIFont boldSystemFontOfSize:18.0];
    totalCardAmt.text  = @"Total Card Amt";
    
    totalCardAmtVal = [[UILabel alloc] init];
    totalCardAmtVal.textColor = [UIColor blackColor];
    totalCardAmtVal.font = [UIFont boldSystemFontOfSize:18.0];
    
    UILabel *totalSodexAmt = [[UILabel alloc] init];
    totalSodexAmt.textColor = [UIColor blackColor];
    totalSodexAmt.font = [UIFont boldSystemFontOfSize:18.0];
    totalSodexAmt.text  = @"Total Sodexo Amt";
    
    totalSodexoAmtVal = [[UILabel alloc] init];
    totalSodexoAmtVal.textColor = [UIColor blackColor];
    totalSodexoAmtVal.font = [UIFont boldSystemFontOfSize:18.0];
    
    
    UILabel *totalTickAmt = [[UILabel alloc] init];
    totalTickAmt.textColor = [UIColor blackColor];
    totalTickAmt.font = [UIFont boldSystemFontOfSize:18.0];
    totalTickAmt.text  = @"Total Ticket Amt";
    
    totalTickAmtVal = [[UILabel alloc] init];
    totalTickAmtVal.textColor = [UIColor blackColor];
    totalTickAmtVal.font = [UIFont boldSystemFontOfSize:18.0];
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
            
            totalBillAmt.frame =  CGRectMake(10, 5, 150, 30);
            totalBillAmtValue.frame =  CGRectMake(250, 5, 200, 30);
            
            totalCashAmt.frame =  CGRectMake(10, 40, 150, 30);
            totalCashAmtVal.frame =  CGRectMake(250, 40, 200, 30);
            totalCardAmt.frame =  CGRectMake(10, 75, 150, 30);
            totalCardAmtVal.frame =  CGRectMake(250, 75, 200, 30);
            totalSodexAmt.frame =  CGRectMake(10, 110, 150, 30);
            totalSodexoAmtVal.frame =  CGRectMake(250, 110, 400, 30);
            
            totalTickAmt.frame =  CGRectMake(10, 145, 150, 30);
            totalTickAmtVal.frame =  CGRectMake(250, 145, 200, 30);
        }
    }
    
    [billSummaryView addSubview:totalBillAmt];
    [billSummaryView addSubview:totalBillAmtValue];
    [billSummaryView addSubview:totalCashAmt];
    [billSummaryView addSubview:totalCashAmtVal];
    [billSummaryView addSubview:totalCardAmt];
    [billSummaryView addSubview:totalCardAmtVal];
    [billSummaryView addSubview:totalSodexAmt];
    [billSummaryView addSubview:totalSodexoAmtVal];
    [billSummaryView addSubview:totalTickAmt];
    [billSummaryView addSubview:totalTickAmtVal];
    
    billSummaryInfoPopup.view = billSummaryView;
    
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        billSummaryInfoPopup.preferredContentSize =  CGSizeMake(billSummaryView.frame.size.width, billSummaryView.frame.size.height);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:billSummaryInfoPopup];
        
        //                [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        [popover presentPopoverFromRect:billSummaryButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        
        
        billSummaryPopOver= popover;
        
    }
    
    else {
        
        billSummaryInfoPopup.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:billSummaryInfoPopup];
        // popover.contentViewController.view.alpha = 0.0;
        popover.contentViewController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        billSummaryPopOver = popover;
        
    }
    
    UIGraphicsBeginImageContext(billSummaryView.frame.size);
    [[UIImage imageNamed:@"CustomerView.png"] drawInRect:billSummaryView.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    billSummaryView.backgroundColor = [UIColor colorWithPatternImage:image];
    [self setBillSummaryValues];
    
}

- (void)setBillSummaryValues {
    
    float totalBill = 0.0f;
    float cashTotal = 0.0f;
    float cardTotal = 0.0f;
    float sodexoTotal = 0.0f;
    float ticketTotal = 0.0f;
    
    for (NSString *sodexoTotalVal in sodexoTotalsArr) {
        sodexoTotal += sodexoTotalVal.floatValue;
    }
    for (NSString *totalBillVal in totalPriceArr) {
        totalBill += totalBillVal.floatValue;
    }
    for (NSString *cashTotalVal in cashTotalArr) {
        cashTotal += cashTotalVal.floatValue;
    }
    for (NSString *cardTotalVal in cardTotalArr) {
        cardTotal += cardTotalVal.floatValue;
    }
    for (NSString *ticketotalVal in ticketTotalArr) {
        ticketTotal += ticketotalVal.floatValue;
    }
    
    totalBillAmtValue.text = [NSString stringWithFormat:@"%.2f",totalBill];
    totalCashAmtVal.text = [NSString stringWithFormat:@"%.2f",cashTotal];
    totalCardAmtVal.text = [NSString stringWithFormat:@"%.2f",cardTotal];
    totalSodexoAmtVal.text = [NSString stringWithFormat:@"%.2f",sodexoTotal];
    totalTickAmtVal.text = [NSString stringWithFormat:@"%.2f",ticketTotal];
}

- (void)textFieldDidChange:(UITextField *)textField {
    
    if(textField == pastBillField) {
        
        NSString *value = [pastBillField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        saleId = pastBillField.text;
        
        if (saleId.length == 3 && !value.length == 0) {
            
            // web services calling....
            // Create the service
            //            SDZSalesService* service = [SDZSalesService service];
            //            service.logging = YES;
            //
            //            // Returns NSString*.
            //            [service getExistedSaleID:self action:@selector(getExistedSaleIDHandler:) saleID: saleId];
            
            if (!isOfflineService) {
                
                WebServiceController *controller = [[WebServiceController alloc] init];
                controller.getBillsDelegate = self;
                [controller getBillIds:-1 deliveryType:@"" status:@"completed" searchCriteria:saleId];
                
            }
            else {
                
                OfflineBillingServices *offline = [[OfflineBillingServices alloc]init];
                NSMutableArray *result = [offline getCompletedBills:pastBillField.text fromDate:ordersDate.text];
                [HUD setHidden:YES];
                filteredSkuArrayList = nil;
                filteredSkuArrayList = result;
                
                salesIdTable.hidden = NO;
                [self.view bringSubviewToFront:salesIdTable];
                
                [salesIdTable reloadData];
                
            }
            
            
            
        }
        else if(saleId.length > 3){
            
            filteredSkuArrayList = [[NSMutableArray alloc] init];
            if (!isOfflineService) {
                
                @try {
                    
                    for (NSString *product in salesIdArray)
                    {
                        NSComparisonResult result = [product compare:pastBillField.text options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, (pastBillField.text).length)];
                        
                        if (result == NSOrderedSame)
                        {
                            [filteredSkuArrayList addObject:product];
                        }
                    }
                }
                @catch (NSException *exception) {
                    
                    
                }
            }
            
            else
                
            {
                
                OfflineBillingServices *offline = [[OfflineBillingServices alloc]init];
                NSMutableArray *result = [offline getCompletedBills:pastBillField.text fromDate:ordersDate.text];
                [HUD setHidden:YES];
                filteredSkuArrayList = nil;
                filteredSkuArrayList = result;
                
                salesIdTable.hidden = NO;
                [self.view bringSubviewToFront:salesIdTable];
                
                [salesIdTable reloadData];
                
            }
            
            [salesIdTable reloadData];
        }
        else if(saleId.length == 2){
            
            //salesIdTable.hidden =YES;
        }
        else{
            //salesIdTable.hidden =YES;
            //return NO;
        }
    }
}
#pragma -mark getBillIds delegate
-(void)getBillIdsSuccessResponse:(NSDictionary *)successDic{
    
    [self getExistedSaleIDHandler:successDic];
    
}

- (void) getExistedSaleIDHandler: (NSDictionary *) value {
    
    NSArray *temp = value[@"billIds"];
    
    if (temp.count > 0 ){
        salesIdArray = nil;
        salesIdArray = [[NSMutableArray alloc] init];
        
        salesIdArray = [temp copy];
        
        filteredSkuArrayList = nil;
        filteredSkuArrayList = salesIdArray;
        
        salesIdTable.hidden = NO;
        [self.view bringSubviewToFront:salesIdTable];
        
        [salesIdTable reloadData];
    }
    else{
        
        //[HUD setHidden:YES];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"No Data found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == salesIdTable) {
        
        return filteredSkuArrayList.count;
    }
    else {
        return bill_ids.count;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        return 50.0;
        
    }
    else {
        return 50.0;
    }
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == salesIdTable) {
        
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if ((cell.contentView).subviews){
            for (UIView *subview in (cell.contentView).subviews) {
                [subview removeFromSuperview];
            }
        }
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.frame = CGRectZero;
        }
        
        @try {
            
            cell.textLabel.text = filteredSkuArrayList[indexPath.row];
            
        }
        @catch (NSException *exception) {
            
            NSLog(@"%@",exception.name);
        }
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
        }
        else{
            cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
        }
        
        return cell;
        
    }
    else {
        
        static NSString *MyIdentifier = @"OrderCell";
        
        CellView_TakeAwayOrder *cell;
        
        cell = (CellView_TakeAwayOrder *)[tableView dequeueReusableCellWithIdentifier: MyIdentifier];
        
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"CellView_TakeAwayOrder" owner:self options:nil][0];
        }
        
        @try {
            
            cell.orderId.text = bill_ids[indexPath.row];
            // cell.tableNo.text = [tableId objectAtIndex:indexPath.row];
            //  cell.waiterName.text = [billDue objectAtIndex:indexPath.row];
            cell.totalBill.text = [NSString stringWithFormat:@"%.2f",[sodexoTotalsArr[indexPath.row] floatValue]];
            
            // NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            //        dateFormat.dateFormat = @"yy/MM/dd HH:mm:ss";
            //
            //        NSString *time = [NSDateFormatter localizedStringFromDate:[dateFormat dateFromString:@"Mar 3,2015 6:24:47PM"] dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterNoStyle];
            
            if (totalPriceArr.count!=0) {
                cell.orderDate.text = [totalPriceArr[indexPath.row] componentsSeparatedByString:@" "][0];
            }
            else {
                cell.orderDate.text = @"";
                
            }
            cell.counter.text = cashTotalArr[indexPath.row];
            cell.billDone.text =cardTotalArr[indexPath.row];
            cell.ticketTotal.text = ticketTotalArr[indexPath.row];
        }
        @catch (NSException *exception) {
            
            NSLog(@"%@",exception.name);
        }
        
        cell.backgroundColor = [UIColor blackColor];
        //  cell.waiterName.textColor = [UIColor whiteColor];
        //  cell.tableNo.textColor = [UIColor whiteColor];
        cell.totalBill.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
        cell.orderDate.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
        cell.orderId.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5f];
        cell.orderId.layer.cornerRadius = 10.0f;
        cell.orderId.layer.masksToBounds = YES;
        cell.orderId.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            
            cell.frame = CGRectMake(0, 0,200, 45);
            cell.orderId.frame = CGRectMake(5,16,120.0,20);
            cell.orderId.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:12.0];
            //cell.orderId.backgroundColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
            cell.orderId.layer.cornerRadius = 10.0f;
            cell.orderId.layer.masksToBounds = YES;
            cell.orderId.textColor = [UIColor whiteColor];
            cell.orderDate.frame = CGRectMake(130,16,150 ,20);
            cell.orderDate.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0];
            cell.totalBill.frame = CGRectMake(255,16,130 ,20);
            cell.totalBill.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:15.0];
            cell.counter.hidden = YES;
            if (version >= 8.0) {
                cell.totalBill.frame = CGRectMake(255,16,130 ,20);
            }
            
        }
        else {
            if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
                
                cell.frame = CGRectMake(0, 0,self.view.frame.size.width, 80);
                cell.orderId.frame = CGRectMake(10,8,200,40);
                cell.orderId.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
                //cell.orderId.backgroundColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
                cell.orderId.layer.cornerRadius = 10.0f;
                cell.orderId.layer.masksToBounds = YES;
                cell.orderId.textColor = [UIColor whiteColor];
                cell.orderDate.frame = CGRectMake(255,12,150 ,28);
                cell.orderDate.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
                cell.counter.frame = CGRectMake(380,12,150 ,28);
                cell.counter.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
                cell.counter.textAlignment = NSTextAlignmentCenter;
                cell.billDone.frame = CGRectMake(580,12,150 ,34);
                cell.billDone.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
                cell.totalBill.frame = CGRectMake(730,12,150 ,34);
                cell.totalBill.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
                cell.ticketTotal.frame = CGRectMake(880,12,150 ,34);
                cell.ticketTotal.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
                cell.ticketTotal.textColor = [UIColor whiteColor];

            }
            else {
                cell.orderId.frame = CGRectMake(33,12,150,40);
                cell.orderId.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
                //cell.orderId.backgroundColor = [UIColor colorWithRed:0.93 green:0.01 blue:0.55 alpha:1.0];
                cell.orderId.layer.cornerRadius = 10.0f;
                cell.orderId.layer.masksToBounds = YES;
                cell.orderId.textColor = [UIColor whiteColor];
                cell.orderDate.frame = CGRectMake(315,12,220 ,28);
                cell.orderDate.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
                cell.totalBill.frame = CGRectMake(570,18,202 ,34);
                cell.totalBill.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
            }
        }
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    [salesIdTable setHidden:YES];
    
    PastBilling *past_bill;
    
    if (tableView == salesIdTable) {
        
        past_bill = [[PastBilling alloc]initWithBillType:filteredSkuArrayList[indexPath.row]];
        
    }
    else {
        
        past_bill = [[PastBilling alloc]initWithBillType:bill_ids[indexPath.row]];
        
    }
    
    billTypeStatus = TRUE;
    typeBilling = @"completed";
    past_bill.billingType = @"completed";
    past_bill.isBillSummery = false;

    pastBillField.text = @"";
    
    self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    
    [self.navigationController pushViewController:past_bill animated:YES];
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //1. Setup the CATransform3D structure
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
    
    //2. Define the initial state (Before the animation)
    cell.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    //!!!FIX for issue #1 Cell position wrong------------
    if(cell.layer.position.x != 0){
        cell.layer.position = CGPointMake(0, cell.layer.position.y);
    }
    
    //4. Define the final state (After the animation) and commit the animation
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
    
}

-(void)loadFirstPage:(id)sender {
    
    AudioServicesPlaySystemSound (soundFileObject);
    
    [bill_ids removeAllObjects];
    [sodexoTotalsArr removeAllObjects];
    [totalPriceArr removeAllObjects];
    [ticketTotalArr removeAllObjects];
    
    completed_bill_no = 0;
    //    cellcount = 10;
    
    //[HUD setHidden:NO];
    [HUD show:YES];
    [self getCompletedBills];
    
}

-(void)loadLastPage:(id)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    [bill_ids removeAllObjects];
    [sodexoTotalsArr removeAllObjects];
    [totalPriceArr removeAllObjects];
    [ticketTotalArr removeAllObjects];
    //float a = [rec_total.text intValue]/5;
    //float t = ([rec_total.text floatValue]/5);
    
    // NSLog(@"%@",totalOrder.text);
    
    // NSLog(@"%f",([totalOrder.text floatValue]/10));
    //
    if ((totalOrder.text).intValue/10 == ((totalOrder.text).floatValue/10)) {
        
        completed_bill_no = (((totalOrder.text).intValue/10)*10)-10;
    }
    else{
        completed_bill_no = ((totalOrder.text).intValue/10) * 10;
    }
    
    
    //changeID = ([rec_total.text intValue]/5) - 1;
    
    //previousButton.backgroundColor = [UIColor grayColor];
    previousOrders.enabled = YES;
    
    
    //frstButton.backgroundColor = [UIColor grayColor];
    firstOrders.enabled = YES;
    
    [HUD setHidden:NO];
    [HUD show:YES];
    [self getCompletedBills];
    
}
-(void)loadPreviousPage:(id)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    
    [bill_ids removeAllObjects];
    [sodexoTotalsArr removeAllObjects];
    [totalPriceArr removeAllObjects];
    [ticketTotalArr removeAllObjects];
    
    if (completed_bill_no > 0){
        completed_bill_no = completed_bill_no-10;
        
        [self getCompletedBills];
        
        if ([orderEnd.text isEqualToString:totalOrder.text]) {
            
            lastOrders.enabled = NO;
        }
        else {
            lastOrders.enabled = YES;
        }
        nextOrders.enabled =  YES;
        
        [HUD setHidden:NO];
        [HUD setHidden:YES];
        
    }
    else{
        //previousButton.backgroundColor = [UIColor lightGrayColor];
        previousOrders.enabled =  NO;
        
        //nextButton.backgroundColor = [UIColor grayColor];
        nextOrders.enabled =  YES;
    }
    
}

-(void)loadNextPage:(id)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    //previousButton.backgroundColor = [UIColor grayColor];
    previousOrders.enabled =  YES;
    
    completed_bill_no = completed_bill_no+10;
    
    [bill_ids removeAllObjects];
    [sodexoTotalsArr removeAllObjects];
    [totalPriceArr removeAllObjects];
    [ticketTotalArr removeAllObjects];
    
    [HUD setHidden:NO];
    
    // nextOrders.enabled =  NO;
    //nextButton.backgroundColor = [UIColor lightGrayColor];
    
    // Getting the required from webServices ..
    // Create the service
    
    firstOrders.enabled = YES;
    
    [self getCompletedBills];
    
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    [pastBillField resignFirstResponder];
    return YES;
}
-(void)goToHome {
    
    OmniHomePage *home = [[OmniHomePage alloc]init];
    [self.navigationController pushViewController:home animated:YES];
    
}

/** DateButtonPressed handle....
 To create picker frame and set the date inside the dueData textfield.
 */
-(IBAction) DateButtonPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    if ((UIButton *)sender == orderDateButton) {
        orderDateButton.enabled = NO;
        getBillsBtn.enabled = NO;
    }
    
    //pickerview creation....
    pickView = [[UIView alloc] init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        pickView.frame = CGRectMake(300, 115, 320, 320);
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
    
    NSDate *today = [NSDate date];
    [myPicker setDate:today animated:YES];
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
    
    orderDateButton.enabled = YES;
    getBillsBtn.enabled = YES;
    
    //Date Formate Setting...
    
    NSDateFormatter *sdayFormat = [[NSDateFormatter alloc] init];
    sdayFormat.dateFormat = @"dd/MM/yyyy";
    NSString *dateString = [sdayFormat stringFromDate:myPicker.date];
    ordersDate.text = dateString;
    [pickView removeFromSuperview];
    
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

@end
