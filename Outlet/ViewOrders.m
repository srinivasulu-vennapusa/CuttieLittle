//
//  NewOrder.m
//  OmniRetailer
//
//  Created by Bangaru.Raju on 11/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.

//  Modified By Bhargav.v on 22/03/2018...


#import "OmniRetailerViewController.h"
#import "ViewOrders.h"
#import <QuartzCore/QuartzCore.h>
#import "BarcodeType.h"
#import "Global.h"
#import "CheckWifi.h"
#import "OmniHomePage.h"
#import "RequestHeader.h"
#import "NewOrder.h"
#import "EditOrder.h"
#import "OrderTrackingPage.h"
#import "OrderTrackingPage2.h"
#import "OrderTrackingPageNew.h"

@implementation ViewOrders
@synthesize soundFileURLRef,soundFileObject;



#pragma  -mark start of ViewLifeCycle mehods....

/**
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date         21/09/2016
 * @method       ViewDidLoad
 * @author       Bhargav Ram
 * @param
 * @param
 * @return
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 */

//- (void)viewDidLoad {
//    //calling super call method....
//    [super viewDidLoad];
//
//    // Do any additional setup after loading the view.
//
//    //reading the DeviceVersion....
//    version = [UIDevice currentDevice].systemVersion.floatValue;
//
//    //here we reading the DeviceOrientaion....
//    currentOrientation = [UIDevice currentDevice].orientation;
//
//    // Audio Sound load url......
//    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
//    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
//    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
//
//    //setting the backGroundColor to view...
//    self.view.backgroundColor = [UIColor blackColor];
//
//    //ProgressBar creation...
//    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
//    [self.navigationController.view addSubview:HUD];
//    // Regiser for HUD callbacks so we can remove it from the window at the right time
//    HUD.delegate = self;
//    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
//    HUD.mode = MBProgressHUDModeCustomView;
//
//    // Show the HUD
//
//    [HUD show:YES];
//    [HUD setHidden:NO];
//
//    //creating the stockRequestView which will displayed completed Screen...
//    orderSummaryView = [[UIView alloc] init];
//
//    /*Creation of UILabel for headerDisplay.......*/
//    //creating line  UILabel which will display at topOfThe  billingView...
//    UILabel * headerNameLbl = [[UILabel alloc] init];
//    headerNameLbl.layer.cornerRadius = 10.0f;
//    headerNameLbl.layer.masksToBounds = YES;
//    headerNameLbl.textAlignment = NSTextAlignmentCenter;
//    headerNameLbl.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
//    headerNameLbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gradient.png"]];
//
//    //it is regard's to the view borderwidth and color setting....
//    CALayer * bottomBorder = [CALayer layer];
//    bottomBorder.opacity = 5.0f;
//    bottomBorder.backgroundColor = [UIColor grayColor].CGColor;
//    bottomBorder.frame = CGRectMake(0.0f, 60.0f, headerNameLbl.frame.size.width, 1.0f);
//    [headerNameLbl.layer addSublayer:bottomBorder];
//
//    /*Creation of UIButton for providing user to select the dates.......*/
//    UIImage  * summaryImage;
//    UIButton * summaryInfoBtn;
//
//    summaryInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    summaryImage = [UIImage imageNamed:@"emails-letters.png"];
//    [summaryInfoBtn setBackgroundImage:summaryImage forState:UIControlStateNormal];
//    //[summaryInfoBtn addTarget:self  action:@selector(callingStockRequestSumary:) forControlEvents:UIControlEventTouchDown];
//
//    /*Creation of textField used in this page*/
//
//    //changed by Srinivasulu on 10/05/2017....
//
//    outletIdText = [[CustomTextField alloc] init];
//    outletIdText.delegate = self;
//    outletIdText.placeholder = NSLocalizedString(@"all_outlets", nil);
//    outletIdText.userInteractionEnabled  = NO;
//    [outletIdText awakeFromNib];
//
//    zoneIdText = [[CustomTextField alloc] init];
//    zoneIdText.placeholder = NSLocalizedString(@"zone_id", nil);
//    zoneIdText.delegate = self;
//    zoneIdText.userInteractionEnabled  = NO;
//    [zoneIdText awakeFromNib];
//
//    orderStartValueText = [[CustomTextField alloc] init];
//    orderStartValueText.placeholder = NSLocalizedString(@"order_value_start", nil);
//    orderStartValueText.delegate = self;
//    orderStartValueText.keyboardType = UIKeyboardTypeNumberPad;
//
//    orderStartValueText.userInteractionEnabled  = YES;
//    [orderStartValueText awakeFromNib];
//
//    orderEndValueText = [[CustomTextField alloc] init];
//    orderEndValueText.placeholder = NSLocalizedString(@"order_value_end", nil);
//    orderEndValueText.delegate = self;
//    orderEndValueText.keyboardType = UIKeyboardTypeNumberPad;
//    orderEndValueText.userInteractionEnabled  = YES;
//    [orderEndValueText awakeFromNib];
//
//    orderStatusText = [[CustomTextField alloc] init];
//    orderStatusText.placeholder = NSLocalizedString(@"order_status", nil);
//    orderStatusText.delegate = self;
//    orderStatusText.userInteractionEnabled  = NO;
//    [orderStatusText awakeFromNib];
//
//    orderChannelText = [[CustomTextField alloc] init];
//    orderChannelText.placeholder = NSLocalizedString(@"Oder_channel", nil);
//    orderChannelText.delegate = self;
//    orderChannelText.userInteractionEnabled  = NO;
//    [orderChannelText awakeFromNib];
//
//    startDateText = [[CustomTextField alloc] init];
//    startDateText.placeholder = NSLocalizedString(@"start_date", nil);
//    startDateText.delegate = self;
//    startDateText.userInteractionEnabled  = NO;
//    [startDateText awakeFromNib];
//
//    endDateText = [[CustomTextField alloc] init];
//    endDateText.placeholder = NSLocalizedString(@"end_date", nil);
//    endDateText.delegate = self;
//    endDateText.userInteractionEnabled  = NO;
//    [endDateText awakeFromNib];
//
//    /*Creation of UIImage used for buttons*/
//    UIImage * downArrowImage = [UIImage imageNamed:@"arrow_1.png"];
//    UIImage * calendarIconImage = [UIImage imageNamed:@"Calandar_Icon.png"];
//
//    UIButton * outletIdButton;
//    UIButton * orderChannelButton;
//    UIButton * orderStartDateButton;
//    UIButton * orderEndDateButton;
//    UIButton * orderStatusButton;
//
//    outletIdButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [outletIdButton setBackgroundImage:downArrowImage forState:UIControlStateNormal];
//    outletIdButton.hidden = YES;
//
//    orderStatusButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [orderStatusButton setBackgroundImage:downArrowImage forState:UIControlStateNormal];
//
//    orderChannelButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [orderChannelButton setBackgroundImage:downArrowImage forState:UIControlStateNormal];
//
//    orderStartDateButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [orderStartDateButton setBackgroundImage:calendarIconImage forState:UIControlStateNormal];
//
//    orderEndDateButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [orderEndDateButton setBackgroundImage:calendarIconImage forState:UIControlStateNormal];
//
//    [outletIdButton addTarget:self action:@selector(showAllOutletId:) forControlEvents:UIControlEventTouchDown];
//    [orderChannelButton addTarget:self action:@selector(showOrderChannel:) forControlEvents:UIControlEventTouchDown];
//    [orderStatusButton addTarget:self action:@selector(showOrderStatus:) forControlEvents:UIControlEventTouchDown];
//    [orderStartDateButton addTarget:self action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
//    [orderEndDateButton addTarget:self action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
//
//
//
//    UIButton * clearButton;
//
//    searchButton = [[UIButton alloc] init];
//    [searchButton addTarget:self action:@selector(searchTheProducts:) forControlEvents:UIControlEventTouchDown];
//    searchButton.layer.cornerRadius = 3.0f;
//    searchButton.backgroundColor = [UIColor grayColor];
//    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    //searchButton.tag = 2;
//
//    clearButton = [[UIButton alloc] init];
//    [clearButton addTarget:self action:@selector(clearAllFilterInSearch:) forControlEvents:UIControlEventTouchDown];
//    clearButton.layer.cornerRadius = 3.0f;
//    clearButton.backgroundColor = [UIColor grayColor];
//    [clearButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//
//    searchOrdersText = [[UITextField alloc] init];
//    searchOrdersText.delegate = self;
//    searchOrdersText.borderStyle = UITextBorderStyleRoundedRect;
//    searchOrdersText.clearButtonMode = UITextFieldViewModeWhileEditing;
//    searchOrdersText.textAlignment = NSTextAlignmentCenter;
//    searchOrdersText.autocorrectionType = UITextAutocorrectionTypeNo;
//    searchOrdersText.textColor = [UIColor blackColor];
//    searchOrdersText.layer.borderColor = [UIColor clearColor].CGColor;
//    searchOrdersText.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
//    [searchOrdersText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//
//    //Allocation UIButton to navigate to the new Order Creation screen....
//
//    UIButton * newOrderButton;
//
//    newOrderButton = [[UIButton alloc] init];
//    [newOrderButton addTarget:self action:@selector(newOrder:) forControlEvents:UIControlEventTouchDown];
//    newOrderButton.layer.cornerRadius = 3.0f;
//    newOrderButton.backgroundColor = [UIColor grayColor];
//    [newOrderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//
//    //Creation of scroll view
//    oredersHeaderScrollView = [[UIScrollView alloc] init];
//    //oredersHeaderScrollView.backgroundColor = [UIColor lightGrayColor];
//
//    /*Creation of UILabels used in this page*/
//    snoLabel = [[CustomLabel alloc] init];
//    [snoLabel awakeFromNib];
//
//    orderIDLabel = [[CustomLabel alloc] init];
//    [orderIDLabel awakeFromNib];
//
//    orderDateLabel = [[CustomLabel alloc] init];
//    [orderDateLabel awakeFromNib];
//
//    deliveryDateLabel = [[CustomLabel alloc] init];
//    [deliveryDateLabel awakeFromNib];
//
//    paymentTypeLabel =  [[CustomLabel alloc] init];
//    [paymentTypeLabel awakeFromNib];
//
//    orderChannelLabel = [[CustomLabel alloc] init];
//    [orderChannelLabel awakeFromNib];
//
//    orderStatusLabel = [[CustomLabel alloc] init];
//    [orderStatusLabel awakeFromNib];
//
//    orderAmountLabel = [[CustomLabel alloc] init];
//    [orderAmountLabel awakeFromNib];
//
//    actionLabel = [[CustomLabel alloc] init];
//    [actionLabel awakeFromNib];
//
//
//    //Allocation of CustomTextField.... for Displaying the Pagenation Data....
//    pagenationText = [[CustomTextField alloc] init];
//    pagenationText.userInteractionEnabled = NO;
//    pagenationText.textAlignment = NSTextAlignmentCenter;
//    pagenationText.delegate = self;
//    [pagenationText awakeFromNib];
//
//    UIButton * dropDownBtn;
//    dropDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [dropDownBtn setBackgroundImage:downArrowImage forState:UIControlStateNormal];
//    [dropDownBtn addTarget:self action:@selector(showPaginationData:) forControlEvents:UIControlEventTouchDown];
//
//    //creating the UIButton which are used to show pagenationData popUp...
//    UIButton * goButton;
//
//    goButton = [[UIButton alloc] init] ;
//    goButton.backgroundColor = [UIColor grayColor];
//    goButton.layer.masksToBounds = YES;
//    [goButton addTarget:self action:@selector(goButtonPressesd:) forControlEvents:UIControlEventTouchDown];
//    goButton.userInteractionEnabled = YES;
//    goButton.layer.cornerRadius = 6.0f;
//    goButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
//
//    //orderListTable allocation...
//    orderListTable = [[UITableView alloc] init];
//    orderListTable.backgroundColor  = [UIColor blackColor];
//    orderListTable.layer.cornerRadius = 4.0;
//    orderListTable.bounces = TRUE;
//    orderListTable.dataSource = self;
//    orderListTable.delegate = self;
//    orderListTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//
//    //UITableView Allocation  for the popups in the View..
//
//    locationTable = [[UITableView alloc] init];
//    orderStatusTable = [[UITableView alloc]init];
//    orderChannelTable = [[UITableView alloc] init];
//    pagenationTable = [[UITableView alloc]init];
//
//    //populating text into the textFields && labels && placeholders && buttons titles....
//    @try {
//
//        self.titleLabel.text = NSLocalizedString(@"omni_retailer", nil);
//
//        HUD.labelText = NSLocalizedString(@"please_wait..", nil);
//
//        headerNameLbl.text = NSLocalizedString(@"order_summary",nil);
//
//        [searchButton setTitle:NSLocalizedString(@"search", nil) forState:UIControlStateNormal];
//        [clearButton setTitle:NSLocalizedString(@"clear", nil) forState:UIControlStateNormal];
//
//        searchOrdersText.placeholder = NSLocalizedString(@"search_orders",nil);
//
//        [newOrderButton setTitle:NSLocalizedString(@"new_order", nil) forState:UIControlStateNormal];
//
//        snoLabel.text          = NSLocalizedString(@"s_no", nil);
//        orderIDLabel.text      = NSLocalizedString(@"order_id", nil);
//        orderDateLabel.text    = NSLocalizedString(@"order_date", nil);
//        deliveryDateLabel.text = NSLocalizedString(@"delivery_Date", nil);
//        paymentTypeLabel.text  = NSLocalizedString(@"payment_type",nil);
//        orderChannelLabel.text = NSLocalizedString(@"Oder_channel", nil);
//        orderStatusLabel.text  = NSLocalizedString(@"order_status", nil);
//        orderAmountLabel.text  = NSLocalizedString(@"order_amount", nil);
//        actionLabel.text       = NSLocalizedString(@"action", nil);
//
//        [goButton setTitle:NSLocalizedString(@"go", nil) forState:UIControlStateNormal];
//
//    } @catch (NSException *exception) {
//
//    }
//
//    //setting the titleName for the Page....
//
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//
//        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
//
//        }
//        else{
//
//        }
//
//        //setting for the stockReceiptView....
//        orderSummaryView.frame = CGRectMake( 2, 70, self.view.frame.size.width - 4, self.view.frame.size.height - 80);
//
//        //seting frame for headerNameLbl....
//        headerNameLbl.frame    = CGRectMake( 0, 0, orderSummaryView.frame.size.width, 45);
//
//        //seting frame for summaryInfoBtn....
//        summaryInfoBtn.frame   = CGRectMake(orderSummaryView.frame.size.width - 45, headerNameLbl.frame.origin.y, 50, 50);
//
//        float textFieldWidth  = 180;
//        float textFiedHeight  = 40;
//        float horizontalWidth = 30;
//
//        //setting first column....
//        zoneIdText.frame   = CGRectMake(orderSummaryView.frame.origin.x + 10, headerNameLbl.frame.origin.y + headerNameLbl.frame.size.height + 10, textFieldWidth, textFiedHeight);
//
//        outletIdText.frame = CGRectMake( zoneIdText.frame.origin.x, zoneIdText.frame.origin.y + zoneIdText.frame.size.height +10,textFieldWidth, textFiedHeight);
//
//        //setting second column....
//        orderStartValueText.frame = CGRectMake(zoneIdText.frame.origin.x +zoneIdText.frame.size.width + horizontalWidth, zoneIdText.frame.origin.y, textFieldWidth,textFiedHeight);
//
//        orderEndValueText.frame = CGRectMake(orderStartValueText.frame.origin.x, outletIdText.frame.origin.y, textFieldWidth,textFiedHeight);
//
//        //setting third column....
//        orderStatusText.frame  = CGRectMake(orderStartValueText.frame.origin.x + orderStartValueText.frame.size.width + horizontalWidth, orderStartValueText.frame.origin.y ,textFieldWidth,textFiedHeight);
//
//        orderChannelText.frame = CGRectMake(orderStatusText.frame.origin.x, orderEndValueText.frame.origin.y, textFieldWidth,textFiedHeight);
//
//        //setting fourth column....
//        startDateText.frame    = CGRectMake(orderStatusText.frame.origin.x + orderStatusText.frame.size.width + horizontalWidth, orderStatusText.frame.origin.y ,textFieldWidth ,textFiedHeight);
//
//        endDateText.frame      = CGRectMake(startDateText.frame.origin.x,orderChannelText.frame.origin.y , textFieldWidth, textFiedHeight);
//
//        //setting frames for UIButtons....
//        outletIdButton.frame = CGRectMake( (outletIdText.frame.origin.x + outletIdText.frame.size.width - 45), outletIdText.frame.origin.y - 8,  55, 60);
//
//        orderChannelButton.frame = CGRectMake( (orderChannelText.frame.origin.x + orderChannelText.frame.size.width - 45), orderChannelText.frame.origin.y - 8,  55, 60);
//
//        orderStatusButton.frame = CGRectMake( (orderStatusText.frame.origin.x + orderStatusText.frame.size.width - 45), orderStatusText.frame.origin.y - 8,  55, 60);
//
//        orderStartDateButton.frame = CGRectMake((startDateText.frame.origin.x + startDateText.frame.size.width - 45), startDateText.frame.origin.y + 2, 40, 35);
//
//        orderEndDateButton.frame = CGRectMake((endDateText.frame.origin.x + endDateText.frame.size.width - 45), endDateText.frame.origin.y + 2, 40, 35);
//
//        // frame for the searchOrders Text
//        searchOrdersText.frame  = CGRectMake(10,outletIdText.frame.origin.y + outletIdText.frame.size.height + 20, endDateText.frame.origin.x + endDateText.frame.size.width - (zoneIdText.frame.origin.x), 40);
//
//        //
//        newOrderButton.frame   = CGRectMake(searchOrdersText.frame.origin.x + searchOrdersText.frame.size.width + 30,searchOrdersText.frame.origin.y, 160, 40);
//
//        //
//        searchButton.frame = CGRectMake((( newOrderButton.frame.origin.x + newOrderButton.frame.size.width) - 160), zoneIdText.frame.origin.y, 160, 40);
//
//        //
//        clearButton.frame  = CGRectMake(searchButton.frame.origin.x, endDateText.frame.origin.y, searchButton.frame.size.width, searchButton.frame.size.height);
//
//        //Setting frame for the pagenationText...
//        pagenationText.frame = CGRectMake(outletIdText.frame.origin.x, orderSummaryView.frame.size.height - 45,90,40);
//
//        dropDownBtn.frame   = CGRectMake((pagenationText.frame.origin.x + pagenationText.frame.size.width - 45), pagenationText.frame.origin.y - 5, 45, 50);
//
//        goButton.frame      = CGRectMake(pagenationText.frame.origin.x+pagenationText.frame.size.width + 15,pagenationText.frame.origin.y, 80, 40);
//
//        //setting frames for the oredersHeaderScrollView....
//
//        float x_position;
//
//        x_position = newOrderButton.frame.origin.x + newOrderButton.frame.size.width - searchOrdersText.frame.origin.x;
//
//        oredersHeaderScrollView.frame =  CGRectMake( searchOrdersText.frame.origin.x, searchOrdersText.frame.origin.y + searchOrdersText.frame.size.height + 5, x_position + 20, pagenationText.frame.origin.y - (searchOrdersText.frame.origin.y + searchOrdersText.frame.size.height + 10));
//
//        //frame for the Header Labels....
//
//        snoLabel.frame = CGRectMake(0,0,45,40);
//
//        orderIDLabel.frame = CGRectMake(snoLabel.frame.origin.x + snoLabel.frame.size.width + 2,snoLabel.frame.origin.y, 170, snoLabel.frame.size.height);
//
//        orderDateLabel.frame = CGRectMake(orderIDLabel.frame.origin.x + orderIDLabel.frame.size.width + 2,snoLabel.frame.origin.y, 100, snoLabel.frame.size.height);
//
//        deliveryDateLabel.frame = CGRectMake(orderDateLabel.frame.origin.x + orderDateLabel.frame.size.width + 2,snoLabel.frame.origin.y, 110, snoLabel.frame.size.height);
//
//        paymentTypeLabel.frame = CGRectMake(deliveryDateLabel.frame.origin.x + deliveryDateLabel.frame.size.width + 2,snoLabel.frame.origin.y, 120, snoLabel.frame.size.height);
//
//        orderChannelLabel.frame = CGRectMake(paymentTypeLabel.frame.origin.x + paymentTypeLabel.frame.size.width + 2,snoLabel.frame.origin.y, 140, snoLabel.frame.size.height);
//
//        orderStatusLabel.frame = CGRectMake(orderChannelLabel.frame.origin.x + orderChannelLabel.frame.size.width + 2,snoLabel.frame.origin.y, 110, snoLabel.frame.size.height);
//
//        orderAmountLabel.frame = CGRectMake(orderStatusLabel.frame.origin.x + orderStatusLabel.frame.size.width + 2,snoLabel.frame.origin.y, 100, snoLabel.frame.size.height);
//
//        actionLabel.frame = CGRectMake(orderAmountLabel.frame.origin.x + orderAmountLabel.frame.size.width + 2,snoLabel.frame.origin.y, 90, snoLabel.frame.size.height);
//
//        orderListTable.frame = CGRectMake(0, snoLabel.frame.origin.y + snoLabel.frame.size.height, oredersHeaderScrollView.frame.size.width, oredersHeaderScrollView.frame.size.height - (snoLabel.frame.origin.y + snoLabel.frame.size.height));
//    }
//
//    else {
//
//        // DO CODING FOR IPHONE DEVICES.......
//    }
//
//    [orderSummaryView addSubview:headerNameLbl];
//    [orderSummaryView addSubview:summaryInfoBtn];
//
//    [orderSummaryView addSubview:zoneIdText];
//    [orderSummaryView addSubview:outletIdText];
//    [orderSummaryView addSubview:orderStartValueText];
//    [orderSummaryView addSubview:orderEndValueText];
//    [orderSummaryView addSubview:orderStatusText];
//    [orderSummaryView addSubview:orderChannelText];
//    [orderSummaryView addSubview:startDateText];
//    [orderSummaryView addSubview:endDateText];
//
//    [orderSummaryView addSubview:outletIdButton];
//    [orderSummaryView addSubview:orderChannelButton];
//    [orderSummaryView addSubview:orderStatusButton];
//    [orderSummaryView addSubview:orderStartDateButton];
//    [orderSummaryView addSubview:orderEndDateButton];
//
//    //
//    [orderSummaryView addSubview:searchOrdersText];
//    //
//    [orderSummaryView addSubview:newOrderButton];
//
//    //adding UIButton's as subView's....
//    [orderSummaryView addSubview:searchButton];
//    [orderSummaryView addSubview:clearButton];
//    //
//    [orderSummaryView addSubview: pagenationText];
//    [orderSummaryView addSubview: dropDownBtn];
//    [orderSummaryView addSubview: goButton];
//
//    //
//    [orderSummaryView addSubview:oredersHeaderScrollView];
//
//    //
//    [oredersHeaderScrollView addSubview:snoLabel];
//    [oredersHeaderScrollView addSubview:orderIDLabel];
//    [oredersHeaderScrollView addSubview:orderDateLabel];
//    [oredersHeaderScrollView addSubview:paymentTypeLabel];
//    [oredersHeaderScrollView addSubview:deliveryDateLabel];
//    [oredersHeaderScrollView addSubview:orderChannelLabel];
//    [oredersHeaderScrollView addSubview:orderStatusLabel];
//    [oredersHeaderScrollView addSubview:orderAmountLabel];
//    [oredersHeaderScrollView addSubview:actionLabel];
//
//    //
//    [oredersHeaderScrollView addSubview: orderListTable];
//
//    //
//    [self.view addSubview:orderSummaryView];
//
//
//    [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:16.0f cornerRadius:0];
//
//    headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
//
//    searchButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
//    clearButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
//    newOrderButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
//
//    //Freezing the current zone and Current location to the respective fields..
//    //freezing Zone...
//
//    if (zoneID.length == 0 || [zoneID isKindOfClass:[NSNull class]] || [zoneID isEqualToString:@""] ) {
//
//        zoneIdText.text = zone;
//    }
//
//    else {
//
//        zoneIdText.text = zoneID;
//    }
//
//    // freezing the Location...
//    outletIdText.text = presentLocation;
//
//    //used for identification propous....
//    orderStartDateButton.tag = 2;
//
//
//}


/**
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date         17/04/2019..
 * @method       ViewDidLoad
 * @author       Roja
 * @param
 * @param
 * @return
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 */

- (void)viewDidLoad {
    //calling super call method....
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    //reading the DeviceVersion....
    version = [UIDevice currentDevice].systemVersion.floatValue;
    
    //here we reading the DeviceOrientaion....
    currentOrientation = [UIDevice currentDevice].orientation;
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    //setting the backGroundColor to view...
    self.view.backgroundColor = [UIColor blackColor];
    
    //ProgressBar creation...
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    
    // Show the HUD
    
    [HUD show:YES];
    [HUD setHidden:NO];
    
    //creating the stockRequestView which will displayed completed Screen...
    orderSummaryView = [[UIView alloc] init];
    
    /*Creation of UILabel for headerDisplay.......*/
    //creating line  UILabel which will display at topOfThe  billingView...
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
    
    /*Creation of UIButton for providing user to select the dates.......*/
    UIImage  * summaryImage;
    UIButton * summaryInfoBtn;
    
    summaryInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    summaryImage = [UIImage imageNamed:@"emails-letters.png"];
    [summaryInfoBtn setBackgroundImage:summaryImage forState:UIControlStateNormal];
    //[summaryInfoBtn addTarget:self  action:@selector(callingStockRequestSumary:) forControlEvents:UIControlEventTouchDown];
    
    /*Creation of textField used in this page*/
    
    //changed by Srinivasulu on 10/05/2017....
    
    outletIdText = [[CustomTextField alloc] init];
    outletIdText.delegate = self;
    outletIdText.placeholder = NSLocalizedString(@"all_outlets", nil);
    outletIdText.userInteractionEnabled  = NO;
    outletIdText.borderStyle = UITextBorderStyleRoundedRect;
    outletIdText.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0];
    outletIdText.font = [UIFont systemFontOfSize:14];
    outletIdText.adjustsFontSizeToFitWidth = YES;

    zoneIdText = [[CustomTextField alloc] init];
    zoneIdText.placeholder = NSLocalizedString(@"zone_id", nil);
    zoneIdText.delegate = self;
    zoneIdText.userInteractionEnabled  = NO;
    zoneIdText.borderStyle = UITextBorderStyleRoundedRect;
    zoneIdText.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0];
    zoneIdText.font = [UIFont systemFontOfSize:14];
    zoneIdText.adjustsFontSizeToFitWidth = YES;

    orderStartValueText = [[CustomTextField alloc] init];
    orderStartValueText.placeholder = NSLocalizedString(@"order_value_start", nil);
    orderStartValueText.delegate = self;
    orderStartValueText.keyboardType = UIKeyboardTypeNumberPad;
    orderStartValueText.userInteractionEnabled  = YES;
    orderStartValueText.borderStyle = UITextBorderStyleRoundedRect;
    orderStartValueText.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0];
    orderStartValueText.font = [UIFont systemFontOfSize:14];
    orderStartValueText.adjustsFontSizeToFitWidth = YES;

    orderEndValueText = [[CustomTextField alloc] init];
    orderEndValueText.placeholder = NSLocalizedString(@"order_value_end", nil);
    orderEndValueText.delegate = self;
    orderEndValueText.keyboardType = UIKeyboardTypeNumberPad;
    orderEndValueText.userInteractionEnabled  = YES;
    orderEndValueText.borderStyle = UITextBorderStyleRoundedRect;
    orderEndValueText.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0];
    orderEndValueText.font = [UIFont systemFontOfSize:14];
    orderEndValueText.adjustsFontSizeToFitWidth = YES;

    orderStatusText = [[CustomTextField alloc] init];
    orderStatusText.placeholder = NSLocalizedString(@"order_status", nil);
    orderStatusText.delegate = self;
    orderStatusText.userInteractionEnabled  = NO;
    orderStatusText.borderStyle = UITextBorderStyleRoundedRect;
    orderStatusText.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0];
    orderStatusText.font = [UIFont systemFontOfSize:14];

    // added by roja on 16/04/2019...
    deliveryTypeText = [[CustomTextField alloc] init];
    deliveryTypeText.placeholder = NSLocalizedString(@"Delivery Type", nil);
    deliveryTypeText.delegate = self;
    deliveryTypeText.userInteractionEnabled  = NO;
    deliveryTypeText.borderStyle = UITextBorderStyleRoundedRect;
    deliveryTypeText.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0];
    deliveryTypeText.font = [UIFont systemFontOfSize:14];
    deliveryTypeText.text = @"";

    deliveryModelText = [[CustomTextField alloc] init];
    deliveryModelText.placeholder = NSLocalizedString(@"Delivery Model", nil);
    deliveryModelText.delegate = self;
    deliveryModelText.userInteractionEnabled  = NO;
    deliveryModelText.borderStyle = UITextBorderStyleRoundedRect;
    deliveryModelText.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0];
    deliveryModelText.font = [UIFont systemFontOfSize:14];
    deliveryModelText.text = @"";
    
    startTimeText = [[CustomTextField alloc] init];
    startTimeText.placeholder = NSLocalizedString(@"Start Time", nil);
    startTimeText.delegate = self;
    startTimeText.userInteractionEnabled  = NO;
    startTimeText.borderStyle = UITextBorderStyleRoundedRect;
    startTimeText.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0];
    startTimeText.font = [UIFont systemFontOfSize:14];
    startTimeText.text = @"";

    endTimeText = [[CustomTextField alloc] init];
    endTimeText.placeholder = NSLocalizedString(@"End Time", nil);
    endTimeText.delegate = self;
    endTimeText.userInteractionEnabled  = NO;
    endTimeText.borderStyle = UITextBorderStyleRoundedRect;
    endTimeText.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0];
    endTimeText.font = [UIFont systemFontOfSize:14];
    endTimeText.text = @"";
    // Upto here added by roja on 16/04/2019.
    
    orderChannelText = [[CustomTextField alloc] init];
    orderChannelText.placeholder = NSLocalizedString(@"Oder_channel", nil);
    orderChannelText.delegate = self;
    orderChannelText.userInteractionEnabled  = NO;
    orderChannelText.borderStyle = UITextBorderStyleRoundedRect;
    orderChannelText.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0];
    orderChannelText.font = [UIFont systemFontOfSize:14];

    startDateText = [[CustomTextField alloc] init];
    startDateText.placeholder = NSLocalizedString(@"start_date", nil);
    startDateText.delegate = self;
    startDateText.userInteractionEnabled  = NO;
    startDateText.borderStyle = UITextBorderStyleRoundedRect;
    startDateText.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0];
    startDateText.font = [UIFont systemFontOfSize:14];

    endDateText = [[CustomTextField alloc] init];
    endDateText.placeholder = NSLocalizedString(@"end_date", nil);
    endDateText.delegate = self;
    endDateText.userInteractionEnabled  = NO;
    endDateText.borderStyle = UITextBorderStyleRoundedRect;
    endDateText.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0];
    endDateText.font = [UIFont systemFontOfSize:14];

    /*Creation of UIImage used for buttons*/
    UIImage * downArrowImage = [UIImage imageNamed:@"arrow_1.png"];
    UIImage * calendarIconImage = [UIImage imageNamed:@"Calandar_Icon.png"];
    
    UIButton * outletIdButton;
    UIButton * orderChannelButton;
    UIButton * orderStartDateButton;
    UIButton * orderEndDateButton;
    UIButton * orderStatusButton;
    // added by roja on 16/04/2019..
    UIButton * deliveryTypeBtn;
    UIButton * deliveryModelBtn;
    UIButton * orderStartTimeBtn;
    UIButton * orderEndTimeBtn;
    // upto here added by roja on 16/04/2019..
  

    
    outletIdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [outletIdButton setBackgroundImage:downArrowImage forState:UIControlStateNormal];
    outletIdButton.hidden = YES;
    
    orderStatusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [orderStatusButton setBackgroundImage:downArrowImage forState:UIControlStateNormal];
    
    orderChannelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [orderChannelButton setBackgroundImage:downArrowImage forState:UIControlStateNormal];
    
    orderStartDateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [orderStartDateButton setBackgroundImage:calendarIconImage forState:UIControlStateNormal];
    
    orderEndDateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [orderEndDateButton setBackgroundImage:calendarIconImage forState:UIControlStateNormal];
    
    deliveryTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deliveryTypeBtn setBackgroundImage:downArrowImage forState:UIControlStateNormal];
    
    deliveryModelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deliveryModelBtn setBackgroundImage:downArrowImage forState:UIControlStateNormal];
    
    orderStartTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [orderStartTimeBtn setBackgroundImage:calendarIconImage forState:UIControlStateNormal];
    
    orderEndTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [orderEndTimeBtn setBackgroundImage:calendarIconImage forState:UIControlStateNormal];
    
    [outletIdButton addTarget:self action:@selector(showAllOutletId:) forControlEvents:UIControlEventTouchDown];
    [orderChannelButton addTarget:self action:@selector(showOrderChannel:) forControlEvents:UIControlEventTouchDown];
    [orderStatusButton addTarget:self action:@selector(showOrderStatus:) forControlEvents:UIControlEventTouchDown];
    [orderStartDateButton addTarget:self action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    [orderEndDateButton addTarget:self action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    
    [deliveryTypeBtn addTarget:self action:@selector(showDeliveryType:) forControlEvents:UIControlEventTouchDown];
    [deliveryModelBtn addTarget:self action:@selector(showDeliveryModel:) forControlEvents:UIControlEventTouchDown];

    [orderStartTimeBtn addTarget:self action:@selector(showTimeInPopUp:) forControlEvents:UIControlEventTouchDown];
    [orderEndTimeBtn addTarget:self action:@selector(showTimeInPopUp:) forControlEvents:UIControlEventTouchDown];
    
    orderStartTimeBtn.tag = 2;
    orderEndTimeBtn.tag = 4;
    
    UIButton * clearButton;
    
    searchButton = [[UIButton alloc] init];
    [searchButton addTarget:self action:@selector(searchTheProducts:) forControlEvents:UIControlEventTouchDown];
    searchButton.layer.cornerRadius = 3.0f;
//    searchButton.backgroundColor = [UIColor grayColor];
    searchButton.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //searchButton.tag = 2;
    
    clearButton = [[UIButton alloc] init];
    [clearButton addTarget:self action:@selector(clearAllFilterInSearch:) forControlEvents:UIControlEventTouchDown];
    clearButton.layer.cornerRadius = 3.0f;
//    clearButton.backgroundColor = [UIColor grayColor];
    clearButton.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    [clearButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    searchOrdersText = [[UITextField alloc] init];
    searchOrdersText.delegate = self;
    searchOrdersText.borderStyle = UITextBorderStyleRoundedRect;
    searchOrdersText.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchOrdersText.textAlignment = NSTextAlignmentCenter;
    searchOrdersText.autocorrectionType = UITextAutocorrectionTypeNo;
    searchOrdersText.textColor = [UIColor blackColor];
    searchOrdersText.layer.borderColor = [UIColor clearColor].CGColor;
    searchOrdersText.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    [searchOrdersText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    //Allocation UIButton to navigate to the new Order Creation screen....
    
    UIButton * newOrderButton;
    
    newOrderButton = [[UIButton alloc] init];
    [newOrderButton addTarget:self action:@selector(newOrder:) forControlEvents:UIControlEventTouchDown];
    newOrderButton.layer.cornerRadius = 3.0f;
//    newOrderButton.backgroundColor = [UIColor grayColor];
    newOrderButton.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    [newOrderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //Creation of scroll view
    oredersHeaderScrollView = [[UIScrollView alloc] init];
    //oredersHeaderScrollView.backgroundColor = [UIColor lightGrayColor];
//    oredersHeaderScrollView.scroll
    
    /*Creation of UILabels used in this page*/
    snoLabel = [[CustomLabel alloc] init];
    [snoLabel awakeFromNib];
    
    orderIDLabel = [[CustomLabel alloc] init];
    [orderIDLabel awakeFromNib];
    
    orderDateLabel = [[CustomLabel alloc] init];
    [orderDateLabel awakeFromNib];
    
    deliveryDateLabel = [[CustomLabel alloc] init];
    [deliveryDateLabel awakeFromNib];
    
    paymentTypeLabel =  [[CustomLabel alloc] init];
    [paymentTypeLabel awakeFromNib];
    
    orderChannelLabel = [[CustomLabel alloc] init];
    [orderChannelLabel awakeFromNib];
    
    orderStatusLabel = [[CustomLabel alloc] init];
    [orderStatusLabel awakeFromNib];
    
    orderAmountLabel = [[CustomLabel alloc] init];
    [orderAmountLabel awakeFromNib];
    
    actionLabel = [[CustomLabel alloc] init];
    [actionLabel awakeFromNib];
    
    // added by roja on 16/04/2019
    timeSlotLbl = [[CustomLabel alloc] init];
    [timeSlotLbl awakeFromNib];
    
    payModeLbl = [[CustomLabel alloc] init];
    [payModeLbl awakeFromNib];
    
    deliveryTypeLbl = [[CustomLabel alloc] init];
    [deliveryTypeLbl awakeFromNib];
    
    deliveryModelLbl = [[CustomLabel alloc] init];
    [deliveryModelLbl awakeFromNib];
    
    //Upto here added by roja on 16/04/2019

    //Allocation of CustomTextField.... for Displaying the Pagenation Data....
    pagenationText = [[CustomTextField alloc] init];
    pagenationText.userInteractionEnabled = NO;
    pagenationText.textAlignment = NSTextAlignmentCenter;
    pagenationText.delegate = self;
    [pagenationText awakeFromNib];
    
    UIButton * dropDownBtn;
    dropDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dropDownBtn setBackgroundImage:downArrowImage forState:UIControlStateNormal];
    [dropDownBtn addTarget:self action:@selector(showPaginationData:) forControlEvents:UIControlEventTouchDown];
    
    //creating the UIButton which are used to show pagenationData popUp...
    UIButton * goButton;
    
    goButton = [[UIButton alloc] init] ;
    goButton.backgroundColor = [UIColor grayColor];
    goButton.layer.masksToBounds = YES;
    [goButton addTarget:self action:@selector(goButtonPressesd:) forControlEvents:UIControlEventTouchDown];
    goButton.userInteractionEnabled = YES;
    goButton.layer.cornerRadius = 6.0f;
    goButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
    
    //orderListTable allocation...
    orderListTable = [[UITableView alloc] init];
    orderListTable.backgroundColor  = [UIColor blackColor];
    orderListTable.layer.cornerRadius = 4.0;
    orderListTable.bounces = TRUE;
    orderListTable.dataSource = self;
    orderListTable.delegate = self;
    orderListTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    //UITableView Allocation  for the popups in the View..
    
    locationTable = [[UITableView alloc] init];
    orderStatusTable = [[UITableView alloc]init];
    orderChannelTable = [[UITableView alloc] init];
    pagenationTable = [[UITableView alloc]init];
    deliveryTypeTable = [[UITableView alloc] init];
    deliveryModelTable = [[UITableView alloc]init];

    //populating text into the textFields && labels && placeholders && buttons titles....
    @try {
        
        self.titleLabel.text = NSLocalizedString(@"omni_retailer", nil);
        
        HUD.labelText = NSLocalizedString(@"please_wait..", nil);
        
        headerNameLbl.text = NSLocalizedString(@"order_summary",nil);
        
        [searchButton setTitle:NSLocalizedString(@"search", nil) forState:UIControlStateNormal];
        [clearButton setTitle:NSLocalizedString(@"clear", nil) forState:UIControlStateNormal];
        
        searchOrdersText.placeholder = NSLocalizedString(@"search_orders",nil);
        
        [newOrderButton setTitle:NSLocalizedString(@"new_order", nil) forState:UIControlStateNormal];
        
        snoLabel.text          = NSLocalizedString(@"s_no", nil);
        orderIDLabel.text      = NSLocalizedString(@"order_id", nil);
        orderDateLabel.text    = NSLocalizedString(@"order_date", nil);
        deliveryDateLabel.text = NSLocalizedString(@"delivery_Date", nil);
        paymentTypeLabel.text  = NSLocalizedString(@"payment_type",nil);
        orderChannelLabel.text = NSLocalizedString(@"Oder_channel", nil);
        orderStatusLabel.text  = NSLocalizedString(@"order_status", nil);
        orderAmountLabel.text  = NSLocalizedString(@"order_amount", nil);
        actionLabel.text       = NSLocalizedString(@"action", nil);
        
        
        // added by roja on 16/04/2019
        timeSlotLbl.text = NSLocalizedString(@"Time Slot", nil);
        payModeLbl.text = NSLocalizedString(@"Pay Mode", nil);
        deliveryTypeLbl.text = NSLocalizedString(@"Delivery Type", nil);
        deliveryModelLbl.text = NSLocalizedString(@"Delivery Mode", nil);
        // Upto here added by roja on 16/04/2019
    
        [goButton setTitle:NSLocalizedString(@"go", nil) forState:UIControlStateNormal];
        
    } @catch (NSException *exception) {
        
    }
    
    //setting the titleName for the Page....
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
            
        }
        else{
            
        }
        
        //setting for the stockReceiptView....
        orderSummaryView.frame = CGRectMake( 2, 70, self.view.frame.size.width - 4, self.view.frame.size.height - 80);
        
        //seting frame for headerNameLbl....
        headerNameLbl.frame    = CGRectMake( 0, 0, orderSummaryView.frame.size.width, 45);
        
        //seting frame for summaryInfoBtn....
        summaryInfoBtn.frame   = CGRectMake(orderSummaryView.frame.size.width - 45, headerNameLbl.frame.origin.y, 50, 50);
        
//        float textFieldWidth  = 180;
        float textFiedHeight  = 40;
        float horizontalWidth = 20;
        
        //setting first column....
        zoneIdText.frame   = CGRectMake(orderSummaryView.frame.origin.x + 10, headerNameLbl.frame.origin.y + headerNameLbl.frame.size.height + 10, 100, textFiedHeight);
        
        outletIdText.frame = CGRectMake( zoneIdText.frame.origin.x, zoneIdText.frame.origin.y + zoneIdText.frame.size.height + 10, zoneIdText.frame.size.width, textFiedHeight);
        
        //setting second column....
        orderStartValueText.frame = CGRectMake(zoneIdText.frame.origin.x +zoneIdText.frame.size.width + horizontalWidth, zoneIdText.frame.origin.y, 100, textFiedHeight);
        
        orderEndValueText.frame = CGRectMake(orderStartValueText.frame.origin.x, outletIdText.frame.origin.y, orderStartValueText.frame.size.width, textFiedHeight);
        
        //setting third column....
        orderStatusText.frame = CGRectMake(orderStartValueText.frame.origin.x + orderStartValueText.frame.size.width + horizontalWidth, zoneIdText.frame.origin.y, 130, textFiedHeight);
        
        orderChannelText.frame = CGRectMake(orderStatusText.frame.origin.x, outletIdText.frame.origin.y, orderStatusText.frame.size.width, textFiedHeight);
        
        //setting fourth column....
        deliveryTypeText.frame = CGRectMake(orderStatusText.frame.origin.x + orderStatusText.frame.size.width + horizontalWidth, zoneIdText.frame.origin.y, 130, textFiedHeight);
        
        deliveryModelText.frame = CGRectMake(deliveryTypeText.frame.origin.x, outletIdText.frame.origin.y, deliveryTypeText.frame.size.width, textFiedHeight);
        
        //setting Fifth column....
        startDateText.frame = CGRectMake(deliveryTypeText.frame.origin.x + deliveryTypeText.frame.size.width + horizontalWidth, zoneIdText.frame.origin.y ,130, textFiedHeight);
        
        endDateText.frame = CGRectMake(startDateText.frame.origin.x, outletIdText.frame.origin.y, startDateText.frame.size.width, textFiedHeight);
        
        //setting Sixth column....
        startTimeText.frame = CGRectMake(startDateText.frame.origin.x + startDateText.frame.size.width + horizontalWidth, zoneIdText.frame.origin.y, 130, textFiedHeight);
        
        endTimeText.frame = CGRectMake(startTimeText.frame.origin.x, outletIdText.frame.origin.y, startTimeText.frame.size.width, textFiedHeight);
       
        //setting frames for UIButtons....
        outletIdButton.frame = CGRectMake( (outletIdText.frame.origin.x + outletIdText.frame.size.width - 45), outletIdText.frame.origin.y - 8, 55, 60);
        
        orderChannelButton.frame = CGRectMake( (orderChannelText.frame.origin.x + orderChannelText.frame.size.width - 45), orderChannelText.frame.origin.y - 8, 55, 60);
        
        orderStatusButton.frame = CGRectMake( (orderStatusText.frame.origin.x + orderStatusText.frame.size.width - 45), orderStatusText.frame.origin.y - 8, 55, 60);
        
        orderStartDateButton.frame = CGRectMake((startDateText.frame.origin.x + startDateText.frame.size.width - 45), startDateText.frame.origin.y + 2, 40, 35);
        
        orderEndDateButton.frame = CGRectMake((endDateText.frame.origin.x + endDateText.frame.size.width - 45), endDateText.frame.origin.y + 2, 40, 35);
        
        // added by roja on 16/04/2019...
        deliveryTypeBtn.frame = CGRectMake( (deliveryTypeText.frame.origin.x + deliveryTypeText.frame.size.width - 45), deliveryTypeText.frame.origin.y - 8, 55, 60);
        
        deliveryModelBtn.frame = CGRectMake( (deliveryModelText.frame.origin.x + deliveryModelText.frame.size.width - 45), deliveryModelText.frame.origin.y - 8, 55, 60);
        
        orderStartTimeBtn.frame = CGRectMake((startTimeText.frame.origin.x + startTimeText.frame.size.width - 45), startTimeText.frame.origin.y + 2, 40, 35);
        
        orderEndTimeBtn.frame = CGRectMake((endTimeText.frame.origin.x + endTimeText.frame.size.width - 45), endTimeText.frame.origin.y + 2, 40, 35);
        
       
        // frame for the searchOrders Text
        searchOrdersText.frame  = CGRectMake(10, outletIdText.frame.origin.y + outletIdText.frame.size.height + 20, endTimeText.frame.origin.x + endTimeText.frame.size.width - (zoneIdText.frame.origin.x), 40);
        
        //
        newOrderButton.frame   = CGRectMake(searchOrdersText.frame.origin.x + searchOrdersText.frame.size.width + 20,searchOrdersText.frame.origin.y, 160, 40);
        
        //
        searchButton.frame = CGRectMake((( newOrderButton.frame.origin.x + newOrderButton.frame.size.width) - 160), zoneIdText.frame.origin.y, 160, 40);
        
        //
        clearButton.frame  = CGRectMake(searchButton.frame.origin.x, endTimeText.frame.origin.y, searchButton.frame.size.width, searchButton.frame.size.height);
        
        //Setting frame for the pagenationText...
        pagenationText.frame = CGRectMake(outletIdText.frame.origin.x, orderSummaryView.frame.size.height - 45,90,40);
        
        dropDownBtn.frame   = CGRectMake((pagenationText.frame.origin.x + pagenationText.frame.size.width - 45), pagenationText.frame.origin.y - 5, 45, 50);
        
        goButton.frame      = CGRectMake(pagenationText.frame.origin.x+pagenationText.frame.size.width + 15,pagenationText.frame.origin.y, 80, 40);
        
        //setting frames for the oredersHeaderScrollView....
        
        float x_position;
        
        x_position = newOrderButton.frame.origin.x + newOrderButton.frame.size.width - searchOrdersText.frame.origin.x;
        
        oredersHeaderScrollView.frame =  CGRectMake( searchOrdersText.frame.origin.x, searchOrdersText.frame.origin.y + searchOrdersText.frame.size.height + 5, x_position + 20, pagenationText.frame.origin.y - (searchOrdersText.frame.origin.y + searchOrdersText.frame.size.height + 10));
        
        //frame for the Header Labels....

        snoLabel.frame = CGRectMake(0,0,45,40);
        
        orderIDLabel.frame = CGRectMake(snoLabel.frame.origin.x + snoLabel.frame.size.width + 2,snoLabel.frame.origin.y, 170, snoLabel.frame.size.height);
        
        orderDateLabel.frame = CGRectMake(orderIDLabel.frame.origin.x + orderIDLabel.frame.size.width + 2,snoLabel.frame.origin.y, 100, snoLabel.frame.size.height);
        
        deliveryDateLabel.frame = CGRectMake(orderDateLabel.frame.origin.x + orderDateLabel.frame.size.width + 2,snoLabel.frame.origin.y, 110, snoLabel.frame.size.height);
        
        timeSlotLbl.frame = CGRectMake(deliveryDateLabel.frame.origin.x + deliveryDateLabel.frame.size.width + 2, snoLabel.frame.origin.y, 130, snoLabel.frame.size.height);
        
        payModeLbl.frame = CGRectMake(timeSlotLbl.frame.origin.x + timeSlotLbl.frame.size.width + 2, snoLabel.frame.origin.y, 100, snoLabel.frame.size.height);
        
        paymentTypeLabel.frame = CGRectMake(payModeLbl.frame.origin.x + payModeLbl.frame.size.width + 2, snoLabel.frame.origin.y, 120, snoLabel.frame.size.height);
        
        deliveryTypeLbl.frame = CGRectMake(paymentTypeLabel.frame.origin.x + paymentTypeLabel.frame.size.width + 2, snoLabel.frame.origin.y, 120, snoLabel.frame.size.height);
        
        deliveryModelLbl.frame = CGRectMake(deliveryTypeLbl.frame.origin.x + deliveryTypeLbl.frame.size.width + 2, snoLabel.frame.origin.y, 120, snoLabel.frame.size.height);
        
        orderChannelLabel.frame = CGRectMake(deliveryModelLbl.frame.origin.x + deliveryModelLbl.frame.size.width + 2,snoLabel.frame.origin.y, 120, snoLabel.frame.size.height);
        
        orderStatusLabel.frame = CGRectMake(orderChannelLabel.frame.origin.x + orderChannelLabel.frame.size.width + 2,snoLabel.frame.origin.y, 110, snoLabel.frame.size.height);
        
        orderAmountLabel.frame = CGRectMake(orderStatusLabel.frame.origin.x + orderStatusLabel.frame.size.width + 2,snoLabel.frame.origin.y, 100, snoLabel.frame.size.height);
        
        actionLabel.frame = CGRectMake(orderAmountLabel.frame.origin.x + orderAmountLabel.frame.size.width + 2,snoLabel.frame.origin.y, 150, snoLabel.frame.size.height);
        
        oredersHeaderScrollView.contentSize = CGSizeMake((actionLabel.frame.origin.x + actionLabel.frame.size.width) + (2 * searchOrdersText.frame.origin.x), pagenationText.frame.origin.y - (searchOrdersText.frame.origin.y + searchOrdersText.frame.size.height + 10));
        
        orderListTable.frame = CGRectMake(0, snoLabel.frame.origin.y + snoLabel.frame.size.height, oredersHeaderScrollView.contentSize.width, oredersHeaderScrollView.frame.size.height - (snoLabel.frame.origin.y + snoLabel.frame.size.height));

//        orderListTable.frame = CGRectMake(0, snoLabel.frame.origin.y + snoLabel.frame.size.height, oredersHeaderScrollView.frame.size.width, oredersHeaderScrollView.frame.size.height - (snoLabel.frame.origin.y + snoLabel.frame.size.height));
    }

    else {
        
        // DO CODING FOR IPHONE DEVICES.......
    }
    
    [orderSummaryView addSubview:headerNameLbl];
    [orderSummaryView addSubview:summaryInfoBtn];
    
    [orderSummaryView addSubview:zoneIdText];
    [orderSummaryView addSubview:outletIdText];
    [orderSummaryView addSubview:orderStartValueText];
    [orderSummaryView addSubview:orderEndValueText];
    [orderSummaryView addSubview:orderStatusText];
    [orderSummaryView addSubview:orderChannelText];
    [orderSummaryView addSubview:startDateText];
    [orderSummaryView addSubview:endDateText];
    
    // added by roja on 16/04/2019
    [orderSummaryView addSubview:deliveryTypeText];
    [orderSummaryView addSubview:deliveryModelText];
    [orderSummaryView addSubview:startTimeText];
    [orderSummaryView addSubview:endTimeText];
    
    [orderSummaryView addSubview:deliveryTypeBtn];
    [orderSummaryView addSubview:deliveryModelBtn];
    [orderSummaryView addSubview:orderStartTimeBtn];
    [orderSummaryView addSubview:orderEndTimeBtn];
    //Upto here added by roja on 16/04/2019

    [orderSummaryView addSubview:outletIdButton];
    [orderSummaryView addSubview:orderChannelButton];
    [orderSummaryView addSubview:orderStatusButton];
    [orderSummaryView addSubview:orderStartDateButton];
    [orderSummaryView addSubview:orderEndDateButton];

    //
    [orderSummaryView addSubview:searchOrdersText];
    //
    [orderSummaryView addSubview:newOrderButton];
    
    //adding UIButton's as subView's....
    [orderSummaryView addSubview:searchButton];
    [orderSummaryView addSubview:clearButton];
    //
    [orderSummaryView addSubview: pagenationText];
    [orderSummaryView addSubview: dropDownBtn];
    [orderSummaryView addSubview: goButton];
    
    //
    [orderSummaryView addSubview:oredersHeaderScrollView];
    
    //
    [oredersHeaderScrollView addSubview:snoLabel];
    [oredersHeaderScrollView addSubview:orderIDLabel];
    [oredersHeaderScrollView addSubview:orderDateLabel];
    [oredersHeaderScrollView addSubview:paymentTypeLabel];
    [oredersHeaderScrollView addSubview:deliveryDateLabel];
    [oredersHeaderScrollView addSubview:orderChannelLabel];
    [oredersHeaderScrollView addSubview:orderStatusLabel];
    [oredersHeaderScrollView addSubview:orderAmountLabel];
    [oredersHeaderScrollView addSubview:actionLabel];
    // added by roja on 16/04/2019..
    [oredersHeaderScrollView addSubview:timeSlotLbl];
    [oredersHeaderScrollView addSubview:payModeLbl];
    [oredersHeaderScrollView addSubview:deliveryTypeLbl];
    [oredersHeaderScrollView addSubview:deliveryModelLbl];
    //Upto here added by roja on 16/04/2019..

    //
    [oredersHeaderScrollView addSubview: orderListTable];
    
    //
    [self.view addSubview:orderSummaryView];
    
    
    [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:16.0f cornerRadius:0];
    
    headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
    
    searchButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
    clearButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
    newOrderButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
    
    //Freezing the current zone and Current location to the respective fields..
    //freezing Zone...
    
    if (zoneID.length == 0 || [zoneID isKindOfClass:[NSNull class]] || [zoneID isEqualToString:@""] ) {
        
        zoneIdText.text = zone;
    }
    
    else {
        
        zoneIdText.text = zoneID;
    }
    
    // freezing the Location...
    outletIdText.text = presentLocation;
    
    //used for identification propous....
    orderStartDateButton.tag = 2;
    
    
}


/**
 * @description   ViewLifeCylce  which will be executed after the execution of  viewDidLoad.......
 * @date         20/03/2018
 * @method       viewDidAppear
 * @author       Bhargav Ram
 * @param        BOOL
 * @param
 * @return       void
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 *
 */


-(void)viewDidAppear:(BOOL)animated {
    //calling super method....
    [super viewDidAppear:YES];
    
    @try {
        
        [self callingOutletOrders];
        
    } @catch (NSException *exception) {
        NSLog(@"----exception in serviceCall of callingGetStockReqeusts------------%@",exception);
    } @finally {
        
    }
}





/**
 * @description  Forming a request String to get Orders Summary....
 * @date         20/03/2018
 * @method
 * @author       Bhargav.v
 * @param        <#param#>
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callingOutletOrders {
    
    @try {
        
        [HUD setHidden:NO];
        [HUD setLabelText:NSLocalizedString(@"please_wait..",nil)];
        
        if(orderListArray == nil && orderStartIndex == 0){
            
            totalOrders = 0;
            
            orderListArray = [NSMutableArray new];
        }
        else if(orderListArray.count ){
            
            [orderListArray removeAllObjects];
        }
        
        NSString * locationStr        = outletIdText.text;
        NSString * orderStartValueStr = orderStartValueText.text;
        NSString * orderEndValueStr   = orderEndValueText.text;
        NSString * orderChannelStr    = orderChannelText.text;
        NSString * orderStatusStr     = orderStatusText.text;
        NSString * startDateStr = startDateText.text;
        NSString * endDateStr  = endDateText.text;
        // Added by roja on 16/04/2019...
        NSString * deliveryModelStr  = deliveryModelText.text;
        NSString * deliveryTypeStr  = deliveryTypeText.text;
        NSString * startTimestr  = startTimeText.text;
        NSString * endTimeStr  = endTimeText.text;
        // Upto here added by roja on 16/04/2019...

        if((startDateText.text).length > 0)
            startDateStr =  [NSString stringWithFormat:@"%@%@",startDateText.text,@" 00:00:00"];
        
        if ((endDateText.text).length > 0) {
            endDateStr = [NSString stringWithFormat:@"%@%@",endDateText.text,@" 00:00:00"];
        }
        
        if ((orderStartValueText.text).length > 0) {
            orderStartValueStr = [NSString stringWithFormat:@"%@.2f",orderStartValueText.text];
        }
        
        if ((orderEndValueText.text).length > 0) {
            orderEndValueStr = [NSString stringWithFormat:@"%@.2f",orderEndValueText.text];
        }
        
        NSString * searchOrderStr = @"";
        
        if((searchOrdersText.text).length > 3)
            searchOrderStr = searchOrdersText.text;
        
        
        NSMutableDictionary * orderListDic = [[NSMutableDictionary alloc]init];
        
        [orderListDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        
        [orderListDic setValue:[NSString stringWithFormat:@"%d",orderStartIndex] forKey:START_INDEX];
        
        [orderListDic setValue:@"10" forKey:MAX_RECORDS];
        
        [orderListDic setValue:searchOrderStr forKey:kSearchCriteria];
        
        if (locationTable.tag == 0  && [outletIdText.text isEqualToString:NSLocalizedString(@"all_outlets", nil)])
            
            locationStr = @"";
        
        if (orderChannelTable.tag == 0 && (orderChannelText.text).length == 0)
            
            orderChannelStr = @"";
        
        if (orderStatusTable.tag == 0 && (orderStatusText.text).length == 0)
            
            orderStatusStr = @"";
        
        // Added by roja on 16/04/2019...
        if (deliveryModelTable.tag == 0 && (deliveryModelText.text).length == 0)
            
            deliveryModelStr = @"";
        
        if (deliveryTypeTable.tag == 0 && (deliveryTypeText.text).length == 0)
            
            deliveryTypeStr = @"";
        //Upto here added by roja on 16/04/2019...

        

        if(searchButton.tag == 2) {
            locationStr        = presentLocation;
            orderStartValueStr = @"";
            orderEndValueStr   = @"";
            startDateStr       = @"";
            endDateStr         = @"";
            orderChannelStr    = @"";
            orderStatusStr     = @"";
            deliveryModelStr = @"";
            deliveryTypeStr = @"";
            endTimeStr = @"";
            startTimestr = @"";
        }
        
        [orderListDic setValue:locationStr forKey:SALE_LOCATION];
        [orderListDic setValue:orderStartValueStr forKey:ORDER_START_VALUE];
        [orderListDic setValue:orderEndValueStr forKey:ORDER_END_VALUE];
        [orderListDic setValue:orderChannelStr forKey:ORDER_CHANNEL];
        [orderListDic setValue:startDateStr forKey:ORDER_START_DATE];
        [orderListDic setValue:endDateStr forKey:ORDER_END_DATE];
        [orderListDic setValue:orderStatusStr forKey:ORDER_STATUS];
        // Added by roja on 16/04/2019...
        [orderListDic setValue:deliveryModelStr forKey:DELIVERY_MODEL];
        [orderListDic setValue:deliveryTypeStr forKey:ORDER_DELIVERY_TYPE];
        [orderListDic setValue:endTimeStr forKey:ORDER_END_TIME];
        [orderListDic setValue:startTimestr forKey:ORDER_START_TIME];
        //Upto here added by roja on 16/04/2019...

        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:orderListDic options:0 error:&err];
        NSString * orderDetailsJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * serviceController = [WebServiceController new];
        serviceController.outletOrderServiceDelegate = self;
        [serviceController getOutletOrders:orderDetailsJsonString];
    }
    @catch (NSException * exception) {
        
        [HUD setHidden:YES];
    }
}


/**
 * @description  Forming a request string to call the service to get zones...
 * @date         20/09/2016
 * @method       getZones
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getZones {
    
    @try {
        
        [HUD setHidden:NO];
        
        if(locationArray == nil)
            locationArray = [NSMutableArray new];
        
        //Changes Made By Bhargav.v on 20/10/2017
        //REASON: Instead of Using NSArray to form the request Param changed to NSMutableDictionary
        
        NSString * zoneStr = zoneIdText.text;
        
        NSMutableDictionary * zoneDic  = [[NSMutableDictionary alloc]init];
        
        [zoneDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [zoneDic setValue:ZERO_CONSTANT forKey:START_INDEX];
        [zoneDic setValue:zoneStr forKey:ZONE_ID];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:zoneDic options:0 error:&err_];
        NSString * zoneJsonStr = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.zoneMasterDelegate = self;
        [webServiceController getZoneIdsRequest:zoneJsonStr];
        
    } @catch (NSException * exception) {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"---- exception while calling getZones ServicesCall ----%@",exception);
        
    } @finally {
        
    }
}

/**
 * @description  storing the Data....
 * @date         20/03/2018
 * @method       getOutletOrdersSuccessResponse
 * @author       Bhargav.v
 * @param        NSDictionary
 * @param
 * @return       void
 * @verified By
 * @verified On
 *
 */

-(void)getOutletOrdersSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        //Using to Display the Item wise Data (Description)....
        orderedSet = [NSMutableOrderedSet new];
        
        totalOrders = [[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:TOTAL_ORDERS]  defaultReturn:@"0"]intValue];
        
        for (NSDictionary * orderListDic in [successDictionary valueForKey:ORDERS_LIST]) {
            
         for(NSString * str  in [orderListDic valueForKey:WORKFLOW_LIST])
            [orderedSet addObject:str];
            
            [orderListArray addObject:orderListDic];
        }
        
        // Calling The pagenation Handler Method...
        // to Display The Pagenation Data....
        
        [self pagenationHandler];
        
    }
    @catch(NSException * exception) {
        
        NSLog(@"----exception in handling serviceCall resposne----%@",exception);
    }
    @finally {
        
        [HUD setHidden: YES];
        [orderListTable reloadData];
    }
}


/**
 * @description  Handling the error Resopnse from server....
 * @date         20/03/2018
 * @method       getOutletOrdersErrorResponse
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return       void
 * @verified By
 * @verified On
 *
 */

-(void)getOutletOrdersErrorResponse:(NSString *)errorResponse {
    
    @try {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [orderListTable reloadData];
        
    }
}


/**
 * @description  Handling the Response for GetZones to get the locations based on the ZONE ID...
 * @date         21/09/2016
 * @method       getZonesSuccessResponse
 * @author       Bhargav.v
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getZonesSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        //here we are reading the Locations based on zone ID and bussiness type......
        [locationArray addObject:NSLocalizedString(@"all_outlets",nil)];
        
        for(NSDictionary * locDic in [[successDictionary valueForKey:ZONE_MASTER_LIST] valueForKey:ZONE_DETAILS][0]) {
            
            if ([[locDic valueForKey:LOCATION_TYPE] caseInsensitiveCompare:RETAIL_OUTLET] == NSOrderedSame) {
                
                [locationArray addObject:[locDic valueForKey:LOCATION]];
            }
            
            //if ([locationArr containsObject:presentLocation]) {
            //[locationArr removeObject:presentLocation];
            //}
        }
        
    } @catch (NSException *exception) {
        NSLog(@"----exception while handling the zoneResponse----%@",exception);
    } @finally {
        [HUD setHidden:YES];
        
    }
}

/**
 * @description  handling the error respone of getZones....
 * @date         21/09/2016
 * @method       getZonesErrorResponse:
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)getZonesErrorResponse:(NSString *)errorResponse {
    
    @try {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}


/**
 * @description  here we are sending the Request through searchTheProducts to filter the Records .......
 * @date         31/03/2017
 * @method       searchTheProducts
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)searchTheProducts:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        searchButton.tag  = 4;
        
        if ((outletIdText.text).length == 0 && (orderStartValueText.text).length == 0 && (orderEndValueText.text).length == 0 && (orderChannelText.text).length== 0 && (startDateText.text).length == 0 && (endDateText.text).length== 0  && (orderStatusText.text).length == 0 && (startTimeText.text).length == 0 && (endTimeText.text).length == 0 && (deliveryModelText.text).length == 0 && (deliveryTypeText.text).length == 0) {
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_select_above_fields_before_proceeding",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2  verticalAxis:y_axis  msgType:@"" conentWidth:360 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            return;
        }
        else
            
            [HUD setHidden:NO];
        orderStartIndex = 0;
        [self callingOutletOrders];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  Clearing the All Data in  searchTheProducts to get All The Records...
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
        
        searchButton.tag  = 2;
        
        orderStartValueText.text = @"";
        orderEndValueText.text   = @"";
        orderChannelText.text    = @"";
        startDateText.text = @"";
        endDateText.text   = @"";
        orderStatusText.text = @"";
       
        outletIdText.text = presentLocation;
        
        // added by roja on 16/04/2019...
        deliveryModelText.text = @"";
        deliveryTypeText.text = @"";
        startTimeText.text = @"";
        endTimeText.text = @"";
        //Upto here added by roja on 16/04/2019...

        
        orderStartIndex = 0;
        [self callingOutletOrders];
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"--------exception in the CreateNewWareHouseStockReceiptView in viewWillDisappear---------%@",exception);
        NSLog(@"----exception is------------%@",exception);
        
    } @finally {
        
    }
}


/**
 * @description  here we are showing the all availiable outlerId.......
 * @date         10/05/2016
 * @method       showAllOutletId
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 */

- (void)showAllOutletId:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        if(locationArray == nil ||  locationArray.count == 0){
            [HUD setHidden:NO];
            //changed on 17/02/2017....
            [self getZones];
        }
        
        if(locationArray.count){
            float tableHeight = locationArray.count * 35;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = locationArray.count * 33;
            
            if(locationArray.count > 5)
                tableHeight = (tableHeight/locationArray.count) * 5;
            
            [self showPopUpForTables:locationTable  popUpWidth:(outletIdText.frame.size.width * 1.5) popUpHeight:tableHeight presentPopUpAt:outletIdText  showViewIn:orderSummaryView permittedArrowDirections:UIPopoverArrowDirectionUp];
        }
        else
            [catPopOver dismissPopoverAnimated:YES];
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"-- exception while calling showAllOutletId:--%@",exception);
        
    }
}


/**
 * @description  displaying popOver for the Order Channel....
 * @date         21/03/2018
 * @method       showOrderChannel::
 * @author       Bhargav Ram
 * @param        UIButton
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)showOrderChannel:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        orderChannelArray = [NSMutableArray new];
        
        [orderChannelArray addObject:NSLocalizedString(@"all_channels",nil)];
        [orderChannelArray addObject:@"Online"];
        [orderChannelArray addObject:@"Mobile"];
        [orderChannelArray addObject:@"Telephone"];
        
        float tableHeight = orderChannelArray.count * 35;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = orderChannelArray.count * 33;
        
        if(orderChannelArray.count>5)
            tableHeight = (tableHeight/orderChannelArray.count) * 5;
        
        [self showPopUpForTables:orderChannelTable  popUpWidth:(orderChannelText.frame.size.width)  popUpHeight:tableHeight presentPopUpAt:orderChannelText  showViewIn:orderSummaryView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
    }
}


/**
 * @description  here we are showing the all availiable items.......
 * @date         12/10/2016
 * @method       showAllItems
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)showOrderStatus:(UIButton*)sender {
    
    @try {
        
        if (orderedSet.count) {
            
            float tableHeight = orderedSet.count * 35;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = orderedSet.count * 33;
            
            if(orderedSet.count > 5)
                tableHeight = (tableHeight/orderedSet.count) * 5;
            
            [self showPopUpForTables:orderStatusTable  popUpWidth:(orderStatusText.frame.size.width) popUpHeight:tableHeight presentPopUpAt:orderStatusText  showViewIn:orderSummaryView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        }
        
        else {
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}




/**
 * @description  Handling the Response for pagenation.....
 * @date
 * @method
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */
-(void)pagenationHandler {
    
    @try {
        
        int strTotalRecords = totalOrders/10;
        
        int remainder = totalOrders % 10;
        
        if(remainder == 0) {
            
            strTotalRecords = strTotalRecords;
        }
        
        else {
            
            strTotalRecords = strTotalRecords + 1;
        }
        
        pagenationArray = [NSMutableArray new];
        
        if(strTotalRecords < 1){
            
            [pagenationArray addObject:@"1"];
        }
        else {
            
            for(int i = 1;i<= strTotalRecords; i++) {
                
                [pagenationArray addObject:[NSString stringWithFormat:@"%i",i]];
            }
        }
        
        //Up to here on 16/10/2017...
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        if(orderStartIndex == 0) {
            pagenationText.text = @"1";
        }
    }
}

/**
 * @description
 * @date         17/10/2017
 * @method       showPaginationData
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)showPaginationData:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        [HUD setHidden:YES];
        
        if(pagenationArray.count == 0){
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            return;
        }
        float tableHeight = pagenationArray.count * 35;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = pagenationArray.count * 33;
        
        if(pagenationArray.count> 5)
            tableHeight = (tableHeight/pagenationArray.count) * 5;
        
        [self showPopUpForTables:pagenationTable  popUpWidth:pagenationText.frame.size.width  popUpHeight:tableHeight presentPopUpAt:pagenationText  showViewIn:orderSummaryView permittedArrowDirections:UIPopoverArrowDirectionLeft];
        
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
}

/**
 * @description  here we are navigation from current page to ViewStockRequest.......
 * @date         26/09/2016
 * @method       goButtonPressesd:
 * @author       Bhargav Ram
 * @param        UIButton
 * @param
 * @return
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the comment's section....
 
 * @return
 * @return
 * @verified By
 * @verified On
 
 */

-(void)goButtonPressesd:(UIButton *)sender {
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        [self callingOutletOrders];
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        NSLog(@"----exception while navigating to NewSockRequest page----%@",exception);
    }
}



#pragma mark navigation methods:

/**
 * @description  Navigating to the New Order Page to create the Orders...
 * @date         22/03/2018
 * @method       newOrder;
 * @author       bhargav
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 * @modified By
 * @reason
 */

-(void)newOrder:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        NewOrder * controller = [[NewOrder alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
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

-(void)editOrder:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if(orderListArray.count > sender.tag) {
           
            EditOrder * order  = [[EditOrder alloc] init];
            order.orderId  = [orderListArray[sender.tag] valueForKey:ORDER_ID];
            [self.navigationController pushViewController:order animated:YES];
            
            
        }
        
    } @catch (NSException *exception) {
        
        NSLog(@"----exception in StockRequest page in newStockRequest----");
        NSLog(@"----exception while navigating to NewSockRequest page----%@",exception);
        
    }
    
}



#pragma mark methods used to disaply calendar and populate data into textfields....

/**
 * @description  here we are showing the calender in popUp view....
 * @date
 * @method       showCalenderInPopUp:
 * @author
 * @param        UIButton
 * @param
 *
 * @return
 *
 * @modified BY  Srinivasulu on 08/06/2017....
 * @reason       changed the comment's section && add clear button and its functionality....
 *
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
            
            pickView.frame = CGRectMake( 15, startDateText.frame.origin.y + startDateText.frame.size.height, 320, 320);
            
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
                [popover presentPopoverFromRect:startDateText.frame inView:orderSummaryView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else
                [popover presentPopoverFromRect:endDateText.frame inView:orderSummaryView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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
 * @description  Populating dates into textFields Based On the user Selection....
 * @date         21/03/2018...
 * @method       populateDateToTextField:
 * @author       Bhargav.v
 * @param        UIButton
 * @verified By
 * @verified On
 *
 */

-(void)populateDateToTextField:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    
    @try {
        
        [catPopOver dismissPopoverAnimated:YES];
        
        //Date Formate Setting...
        NSDateFormatter *requiredDateFormat = [[NSDateFormatter alloc] init];
        //[requiredDateFormat setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        requiredDateFormat.dateFormat = @"dd/MM/yyyy";
        dateString = [requiredDateFormat stringFromDate:myPicker.date];
        
        NSDate *selectedDateString = [requiredDateFormat dateFromString:[requiredDateFormat stringFromDate:myPicker.date]];
        
        
        // getting present date & time ..
        NSDate * today = [NSDate date];
        NSDateFormatter *f = [[NSDateFormatter alloc] init];
        f.dateFormat = @"dd/MM/yyyy";
        NSString* currentdate = [f stringFromDate:today];
        //[f release];
        today = [f dateFromString:currentdate];
        
        if( [today compare:selectedDateString] == NSOrderedAscending ){
            
            [self displayAlertMessage:NSLocalizedString(@"ordered_date_can_not_be_more_than_current_data", nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:400 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
            
            return;
            
        }
        
        NSDate *existingDateString;
        
        
        if(  sender.tag == 2){
            if ((endDateText.text).length != 0 && ( ![endDateText.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:endDateText.text ];
                
                if ([existingDateString compare:selectedDateString]== NSOrderedAscending) {
                    
                    [self displayAlertMessage:NSLocalizedString(@"start_date_should_be_earlier_than_end_date", nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:390 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
                    
                    return;
                    
                }
            }
            
            startDateText.text = dateString;
            
        }
        else{
            
            if ((startDateText.text).length != 0 && ( ![startDateText.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:startDateText.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    
                    [self displayAlertMessage:NSLocalizedString(@"end_date_should_not_be_earlier_than_start_date", nil) horizontialAxis:(self.view.frame.size.width - 250)/2   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:390 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
                    
                    return;
                    
                }
            }
            
            endDateText.text = dateString;
            
        }
        
    } @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

/**
 * @description  clearing the date from textField and calling services.......
 * @date         13/06/2017
 * @method       clearDate:
 * @author       Bhargav.v
 * @param        UIButton
 * @verified By
 * @verified On
 *
 */

-(void)clearDate:(UIButton *)sender{
    
    @try {
        //Dismissing the pop over....
        [catPopOver dismissPopoverAnimated:YES];
        
        if(sender.tag == 2){
            if((startDateText.text).length)
                
                startDateText.text = @"";
        }
        else{
            if((endDateText.text).length)
                
                endDateText.text = @"";
        }
        
    } @catch (NSException * exception) {
        
        [HUD setHidden:YES];
        
        NSLog(@"---- exception in StockReceiptView -- in  -- clearDate() ----");
        NSLog(@"---- exception is ----%@",exception);
        
    } @finally {
        
    }
}


/**
 * @description  it is an textFieldDelegate method it will be executed for ever character change........
 * @date         10/09/2016
 * @method       textFieldDidChange:
 * @author       Srinivasulu
 * @param        UITextField
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)textFieldDidChange:(UITextField *)textField {
    
    @try {
        if(textField == searchOrdersText){
            
            if ((textField.text).length >= 3) {
                
                @try {
                    [self callingOutletOrders];
                    
                } @catch (NSException *exception) {
                    NSLog(@"---- exception while calling ServicesCall ----%@",exception);
                }
            }
            
            else if ((searchOrdersText.text).length == 0 ) {
                
                [self callingOutletOrders];
                
            }
            else{
                
                [HUD setHidden:YES];
            }
        }
        
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
}



/**
 * @description  ----------
 * @date         20/03/2018
 * @method       numberOfRowsInSection
 * @author       Bhargav.v
 * @param        UITableView
 * @param        NSInteger
 * @return       NSInteger
 * @verified By
 * @verified On
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == orderListTable) {
        
        return orderListArray.count;
    }
    else if(tableView == locationTable){
        
        return locationArray.count;
    }
    else if(tableView == orderChannelTable){
        
        return orderChannelArray.count;
    }
    else if (tableView == pagenationTable){
        
        return pagenationArray.count;
    }
    else if (tableView == orderStatusTable){
        
        return orderedSet.count;
    }
    else if(tableView == deliveryTypeTable) {
        
        return deliveryTypeArray.count;
    }
    else if(tableView == deliveryModelTable){
        
        return deliveryModelArray.count;
    }
    
    else
        return 0;
}


/**
 * @description  ----------
 * @date         21/03/2018
 * @method       heightForRowAtIndexPath
 * @author       Bhargav.v
 * @param        UITableView
 * @param        NSIndexPath
 * @return       CGFloat
 * @verified By
 * @verified On
 *
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *) indexPath {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if(tableView == orderListTable){
            
            return  38;
        }
        else if (tableView == locationTable || tableView == orderChannelTable || tableView == pagenationTable || tableView == orderStatusTable || tableView == deliveryTypeTable || deliveryModelTable ) {
            
            return 35;
            
        }
    }
    
    else {
        // Set cell Height for the iPhone And other compatable Devices....
    }
    
    return 30;
    
}

/**
 * @description  ----------
 * @date         20/03/2018
 * @method       cellForRowAtIndexPath
 * @author       Bhargav.v
 * @param        UITableView
 * @param        NSIndexPath
 * @return       UITableViewCell
 * @verified By
 * @verified On
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView == orderListTable) {
        
        static NSString * cellIdentifier = @"orderSummaryCell";
        
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ((hlcell.contentView).subviews){
            
            for (UIView *subview in (hlcell.contentView).subviews) {
                [subview removeFromSuperview];
            }
        }
        
        CAGradientLayer *layer_1;
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                       initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            
            tableView.separatorColor = [UIColor clearColor];

            @try {
                layer_1 = [CAGradientLayer layer];
                layer_1.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
                
                layer_1.frame = CGRectMake(snoLabel.frame.origin.x, hlcell.frame.size.height - 2, actionLabel.frame.origin.x + actionLabel.frame.size.width -(snoLabel.frame.origin.x),1);
                
                [hlcell.contentView.layer addSublayer:layer_1];
                
            } @catch (NSException *exception) {
                
            }
        }
        
        // Creation of UILabels to Display in the OrderListTable....
        UILabel * itemSnoLabel;
        UILabel * itemOrderIDLabel;
        UILabel * itemOrderDateLabel;
        UILabel * itemDeliveryDateLabel;
        UILabel * itemPaymentTypeLabel;
        
        UILabel * itemOrderChannelLabel;
        UILabel * itemOrderStatusLabel;
        UILabel * itemOrderAmountLabel;
        
        //added by roja on 16/04/2019..
        UILabel * deliveryTimeSlotLabel;
        UILabel * payModeLabel;
        UILabel * deliveryTypeLabel;
        UILabel * deliveryModelLabel;
        //Upto here added by roja on 16/04/2019..

        //UILabels Allocatuion....
    
        itemSnoLabel = [[UILabel alloc] init];
        itemSnoLabel.backgroundColor = [UIColor clearColor];
        itemSnoLabel.textAlignment = NSTextAlignmentCenter;
        itemSnoLabel.numberOfLines = 1;
        itemSnoLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        itemOrderIDLabel = [[UILabel alloc] init];
        itemOrderIDLabel.backgroundColor = [UIColor clearColor];
        itemOrderIDLabel.textAlignment = NSTextAlignmentCenter;
        itemOrderIDLabel.numberOfLines = 1;
        itemOrderIDLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        itemOrderDateLabel = [[UILabel alloc] init];
        itemOrderDateLabel.backgroundColor = [UIColor clearColor];
        itemOrderDateLabel.textAlignment = NSTextAlignmentCenter;
        itemOrderDateLabel.numberOfLines = 1;
        itemOrderDateLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        itemDeliveryDateLabel = [[UILabel alloc] init];
        itemDeliveryDateLabel.backgroundColor = [UIColor clearColor];
        itemDeliveryDateLabel.textAlignment = NSTextAlignmentCenter;
        itemDeliveryDateLabel.numberOfLines = 1;
        itemDeliveryDateLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        itemPaymentTypeLabel = [[UILabel alloc] init];
        itemPaymentTypeLabel.backgroundColor = [UIColor clearColor];
        itemPaymentTypeLabel.textAlignment = NSTextAlignmentCenter;
        itemPaymentTypeLabel.numberOfLines = 1;
        itemPaymentTypeLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        itemOrderChannelLabel = [[UILabel alloc] init];
        itemOrderChannelLabel.backgroundColor = [UIColor clearColor];
        itemOrderChannelLabel.textAlignment = NSTextAlignmentCenter;
        itemOrderChannelLabel.numberOfLines = 1;
        itemOrderChannelLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        itemOrderStatusLabel = [[UILabel alloc] init];
        itemOrderStatusLabel.backgroundColor = [UIColor clearColor];
        itemOrderStatusLabel.textAlignment = NSTextAlignmentCenter;
        itemOrderStatusLabel.numberOfLines = 1;
        itemOrderStatusLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        itemOrderAmountLabel = [[UILabel alloc] init];
        itemOrderAmountLabel.backgroundColor = [UIColor clearColor];
        itemOrderAmountLabel.textAlignment = NSTextAlignmentCenter;
        itemOrderAmountLabel.numberOfLines = 1;
        itemOrderAmountLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        //added by roja on 16/04/2019..
        deliveryTimeSlotLabel = [[UILabel alloc] init];
        deliveryTimeSlotLabel.backgroundColor = [UIColor clearColor];
        deliveryTimeSlotLabel.textAlignment = NSTextAlignmentCenter;
        deliveryTimeSlotLabel.numberOfLines = 1;
        deliveryTimeSlotLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        payModeLabel = [[UILabel alloc] init];
        payModeLabel.backgroundColor = [UIColor clearColor];
        payModeLabel.textAlignment = NSTextAlignmentCenter;
        payModeLabel.numberOfLines = 1;
        payModeLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        deliveryTypeLabel = [[UILabel alloc] init];
        deliveryTypeLabel.backgroundColor = [UIColor clearColor];
        deliveryTypeLabel.textAlignment = NSTextAlignmentCenter;
        deliveryTypeLabel.numberOfLines = 1;
        deliveryTypeLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        deliveryModelLabel = [[UILabel alloc] init];
        deliveryModelLabel.backgroundColor = [UIColor clearColor];
        deliveryModelLabel.textAlignment = NSTextAlignmentCenter;
        deliveryModelLabel.numberOfLines = 1;
        deliveryModelLabel.lineBreakMode = NSLineBreakByWordWrapping;
        //Upto here added by roja on 16/04/2019..

        
        /*Creation of UIButton's used in this cell*/
        openButton = [[UIButton alloc] init];
        openButton.titleLabel.textColor = [UIColor whiteColor];
        openButton.userInteractionEnabled = YES;
        openButton.tag = indexPath.row;
        [openButton setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0]forState:UIControlStateNormal];
        [openButton addTarget:self action:@selector(editOrder:) forControlEvents:UIControlEventTouchUpInside];
        
        // added by roja on 04/12/2019.
        trackOrderBtn = [[UIButton alloc] init];
        trackOrderBtn.titleLabel.text = @"Track";
        trackOrderBtn.titleLabel.textColor = [UIColor whiteColor];
        trackOrderBtn.userInteractionEnabled = YES;
        trackOrderBtn.tag = indexPath.row;
        [trackOrderBtn setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [trackOrderBtn addTarget:self action:@selector(goToTrackingPage:) forControlEvents:UIControlEventTouchUpInside];
        //Upto here added by roja on 04/12/2019.

        
        //setting the color to text....
        itemSnoLabel.textColor          = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        itemOrderIDLabel.textColor      = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        itemOrderDateLabel.textColor    = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        itemDeliveryDateLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        itemPaymentTypeLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        itemOrderChannelLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        itemOrderStatusLabel.textColor  = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        itemOrderAmountLabel.textColor  = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        // added by roja on 16/04/2019...
        deliveryTimeSlotLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        payModeLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        deliveryTypeLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        deliveryModelLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        //Upto here added by roja on 16/04/2019...
        
        //added subview to cell View....
        [hlcell.contentView addSubview:itemSnoLabel];
        [hlcell.contentView addSubview:itemOrderIDLabel];
        [hlcell.contentView addSubview:itemOrderDateLabel];
        [hlcell.contentView addSubview:itemDeliveryDateLabel];
        // added by roja on 16/04/2019...
        [hlcell.contentView addSubview:deliveryTimeSlotLabel];
        [hlcell.contentView addSubview:payModeLabel];
        [hlcell.contentView addSubview:itemPaymentTypeLabel];
        [hlcell.contentView addSubview:deliveryTypeLabel];
        [hlcell.contentView addSubview:deliveryModelLabel];
        //Upto here added by roja on 16/04/2019...
        [hlcell.contentView addSubview:itemOrderChannelLabel];
        [hlcell.contentView addSubview:itemOrderStatusLabel];
        [hlcell.contentView addSubview:itemOrderAmountLabel];
        [hlcell.contentView addSubview:openButton];
        [hlcell.contentView addSubview:trackOrderBtn]; // added by roja on 04/12/2019...

        
        

        //setting frame and font........
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            //setting frame....
            itemSnoLabel.frame           = CGRectMake(snoLabel.frame.origin.x, 0, snoLabel.frame.size.width, hlcell.frame.size.height);
            itemOrderIDLabel.frame       = CGRectMake(orderIDLabel.frame.origin.x, 0, orderIDLabel.frame.size.width, hlcell.frame.size.height);
            itemOrderDateLabel.frame     = CGRectMake(orderDateLabel.frame.origin.x, 0, orderDateLabel.frame.size.width, hlcell.frame.size.height);
            itemDeliveryDateLabel.frame  = CGRectMake(deliveryDateLabel.frame.origin.x, 0, deliveryDateLabel.frame.size.width, hlcell.frame.size.height);
            deliveryTimeSlotLabel.frame     = CGRectMake(timeSlotLbl.frame.origin.x, 0, timeSlotLbl.frame.size.width, hlcell.frame.size.height);
            payModeLabel.frame     = CGRectMake(payModeLbl.frame.origin.x, 0, payModeLbl.frame.size.width, hlcell.frame.size.height);
            itemPaymentTypeLabel.frame   = CGRectMake(paymentTypeLabel.frame.origin.x, 0, paymentTypeLabel.frame.size.width, hlcell.frame.size.height);
            deliveryTypeLabel.frame     = CGRectMake(deliveryTypeLbl.frame.origin.x, 0, deliveryTypeLbl.frame.size.width, hlcell.frame.size.height);
            deliveryModelLabel.frame     = CGRectMake(deliveryModelLbl.frame.origin.x, 0, deliveryModelLbl.frame.size.width, hlcell.frame.size.height);
            itemOrderChannelLabel.frame  = CGRectMake(orderChannelLabel.frame.origin.x, 0, orderChannelLabel.frame.size.width, hlcell.frame.size.height);
            itemOrderStatusLabel.frame   = CGRectMake(orderStatusLabel.frame.origin.x, 0, orderStatusLabel.frame.size.width, hlcell.frame.size.height);
            itemOrderAmountLabel.frame   = CGRectMake(orderAmountLabel.frame.origin.x, 0, orderAmountLabel.frame.size.width, hlcell.frame.size.height);
            openButton.frame = CGRectMake(actionLabel.frame.origin.x + 5, 0,(actionLabel.frame.size.width)/2, hlcell.frame.size.height);
            trackOrderBtn.frame = CGRectMake(openButton.frame.origin.x + openButton.frame.size.height + 10, 0,(actionLabel.frame.size.width-10)/2, hlcell.frame.size.height); // added roja on 04/12/2019...
            
        }
        
        if (orderListArray.count >= indexPath.row && orderListArray.count ) {
            
            [openButton setTitle:NSLocalizedString(@"Open",nil) forState:UIControlStateNormal];
            
            [trackOrderBtn setTitle:@"Track" forState:UIControlStateNormal]; // added by roja on 04/12/2019..
            
            NSDictionary * dic = orderListArray[indexPath.row];
            
            itemSnoLabel.text       = [NSString stringWithFormat:@"%ld", (indexPath.row + 1) + orderStartIndex];
            itemOrderIDLabel.text   = [self checkGivenValueIsNullOrNil:[dic valueForKey:ORDER_ID] defaultReturn:@""];
            
            // changed by roja on 06-10-2018..
            itemOrderDateLabel.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[[dic valueForKey:Order_Date] componentsSeparatedByString: @" "][0] defaultReturn:@""]];
 
            itemDeliveryDateLabel.text = [NSString stringWithFormat:@"%@",[self checkGivenValueIsNullOrNil:[[dic valueForKey:DELIVERY_DATE] componentsSeparatedByString: @" "][0] defaultReturn:@""]];
            // upto here changed by roja on 06-10-2018..

            itemPaymentTypeLabel.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:PAYMENT_TYPE] defaultReturn:@""];
            
            itemOrderChannelLabel.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:ORDER_CHANNEL] defaultReturn:@""];
            itemOrderStatusLabel.text  = [self checkGivenValueIsNullOrNil:[dic valueForKey:ORDER_STATUS] defaultReturn:@""];
            itemOrderAmountLabel.text  = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:TOTAL_ORDER_AMOUNT] defaultReturn:@"0.00"] floatValue]];
            
            // added by toja no 16/04/2019..
            NSString * timeSlot = @"-";

            NSString * deliverySlotStartTimeStr = [self checkGivenValueIsNullOrNil:[dic valueForKey:DELIVERY_SLOT_START_TIME] defaultReturn:@""];
            NSString * deliverySlotEndTimeStr = [self checkGivenValueIsNullOrNil:[dic valueForKey:DELIVERY_SLOT_END_TIME] defaultReturn:@""];

            timeSlot = [[deliverySlotStartTimeStr stringByAppendingString:@"/"] stringByAppendingString:deliverySlotEndTimeStr];

            if ([deliverySlotStartTimeStr isEqualToString:@""] || [deliverySlotEndTimeStr isEqualToString:@""]) {
                timeSlot = @"-";
            }
            deliveryTimeSlotLabel.text = [NSString stringWithFormat:@"%@", timeSlot];
            payModeLabel.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:PAYMENT_MODE] defaultReturn:@""];
            deliveryTypeLabel.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:ORDER_DELIVERY_TYPE] defaultReturn:@""];
            deliveryModelLabel.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:DELIVERY_MODEL] defaultReturn:@""];
            //upto here added by toja no 16/04/2019..
        }
        
        //setting font size....
        [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:15.0f cornerRadius:0.0];
        openButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        trackOrderBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f]; // added by roja on 04/12/2019..
        
        hlcell.backgroundColor = [UIColor clearColor];
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return hlcell;
    }
    
    else if (tableView == locationTable) {
        
        static NSString * CellIdentifier = @"locationCell";
        
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
            hlcell.textLabel.numberOfLines = 1;
            
            hlcell.textLabel.text = locationArray[indexPath.row];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
        } @catch (NSException *exception) {
            
        }
        return hlcell;
    }

    else if (tableView == orderStatusTable) {
        
        static NSString * CellIdentifier = @"orderChannelCell";
        
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
            hlcell.textLabel.numberOfLines = 1;
            
            hlcell.textLabel.text = orderedSet[indexPath.row];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
        } @catch (NSException *exception) {
            
        }
        return hlcell;
    }
    
    else if (tableView == orderChannelTable) {
        
        static NSString * CellIdentifier = @"orderChannelCell";
        
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
            hlcell.textLabel.numberOfLines = 1;
            
            hlcell.textLabel.text = orderChannelArray[indexPath.row];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
        } @catch (NSException *exception) {
            
        }
        return hlcell;
    }
    
    else if (tableView == pagenationTable) {
        @try {
            static NSString * CellIdentifier = @"pagenationCell";
            
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
            
            hlcell.textLabel.text = pagenationArray[indexPath.row];
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return hlcell;
        }
        @catch (NSException *exception) {
        }
    }
    else if(tableView == deliveryTypeTable) {// added by roja on 16/04/2019...
        
        static NSString * CellIdentifier = @"deliveryTypeCell";
        
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
            hlcell.textLabel.numberOfLines = 1;
            
            hlcell.textLabel.text = deliveryTypeArray[indexPath.row];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
        } @catch (NSException *exception) {
            
        }
        return hlcell;
    }
    
    else if(tableView == deliveryModelTable) { // added by roja on 16/04/2019...
        
        static NSString * CellIdentifier = @"deliveryTypeCell";
        
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
            hlcell.textLabel.numberOfLines = 1;
            
            hlcell.textLabel.text = deliveryModelArray[indexPath.row];
            hlcell.textLabel.textColor = [UIColor blackColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16];
        } @catch (NSException *exception) {
            
        }
        return hlcell;
    }
}


/**
 * @description  TableViewDelegate method executes. When a cell is selected in Table..
 * @date         21/03/2018
 * @method       tableView: didSelectRowAtIndexPath:
 * @author       Bhargav.v
 * @param        UITableView
 * @param        NSIndexPath
 * @return       void
 * @verified By
 * @verified On
 *
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //dismissing the catPopOver....
    [catPopOver dismissPopoverAnimated:YES];
    
    if (tableView == locationTable) {
        
        @try {
            locationTable.tag = indexPath.row;
            outletIdText.text = locationArray[indexPath.row];
        }
        @catch(NSException * exception) {
            
        }
    }
    
    if (tableView == orderChannelTable) {
        
        @try {
            
            orderChannelTable.tag = indexPath.row;
            orderChannelText.text = orderChannelArray[indexPath.row];
        }
        @catch(NSException * exception) {
            
        }
    }
    if (tableView == orderStatusTable) {
        
        @try {
            
            orderStatusTable.tag = indexPath.row;
            
            orderStatusText.text = orderedSet[indexPath.row];
        }
        @catch(NSException * exception) {
            
        }
    }
    else if (tableView == pagenationTable){
        
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
            
            orderStartIndex = 0;
            pagenationText.text = pagenationArray[indexPath.row];
            int pageValue = (pagenationText.text).intValue;
            orderStartIndex = orderStartIndex + (pageValue * 10) - 10;
        } @catch (NSException * exception) {
            
        }
    }
    
    else if (tableView == deliveryTypeTable) { // added by roja on 16/04/2019
        
        deliveryTypeTable.tag = indexPath.row;

        deliveryTypeText.text = deliveryTypeArray[indexPath.row];
    }
    
    else if (tableView == deliveryModelTable) { // added by roja on 16/04/2019
        
        deliveryModelTable.tag = indexPath.row;
        deliveryModelText.text = deliveryModelArray[indexPath.row];
    }
    
}



#pragma -mark reusableMethods.......

/**
 * @description  Displaying th PopUp's and reloading table if popUp is vissiable.....
 * @date         15/03/2017
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
            
            //catPopOver.contentViewController.preferredContentSize = CGSizeMake(width, height);
            //CGRectMake( tableName.frame.origin.x, tableName.frame.origin.x, tableName.frame.size.width, tableName.frame.size.height);
            
            //if (tableName.frame.size.height < height)
            //tableName.frame = CGRectMake( tableName.frame.origin.x, tableName.frame.origin.x, tableName.frame.size.width, tableName.frame.size.height);
            
            [tableName reloadData];
            return;
            
        }
        
        if(catPopOver.popoverVisible)
            [catPopOver dismissPopoverAnimated:YES];
        
        
        UITextView * textView = displayFrame;
        
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



#pragma -mark method used to display alert/warning messages....

/**
 * @description  adding the  alertMessage's based on input
 * @date         15/03/2017
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
            
            if(searchOrdersText.isEditing)
                yPosition = searchOrdersText.frame.origin.y + searchOrdersText.frame.size.height;
            
            
            userAlertMessageLbl.frame = CGRectMake(xPostion, yPosition, labelWidth, labelHeight);
            
        }
        else{
            if (version > 8.0) {
                userAlertMessageLbl.frame = CGRectMake(xPostion + 75, yPosition-35, 200, 30);
                userAlertMessageLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
                
            }
            else{
                userAlertMessageLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
                userAlertMessageLbl.frame = CGRectMake(xPostion + 75, yPosition-35, 200, 30);
                
            }
            
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
 * @date         18/11/2016
 * @method       removeAlertMessages
 * @author       Bhargav Ram
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



#pragma -mark mehod used to check whether received object in NULL or not

/**
 * @description  here we are checking whether the object is null or not
 * @date         21/03/2018..
 * @method       checkGivenValueIsNullOrNil
 * @author       Bhargav.v
 * @param        NSString
 * @param        id
 * @return       id
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

#pragma -mark super class methods

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
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        for (UIViewController * controller in self.navigationController.viewControllers) {
            
            if ([controller isKindOfClass:[OmniHomePage class]]) {
                
                [self.navigationController popToViewController:controller animated:NO];
            }
        }
        
    } @catch (NSException * exception) {
        
    }
}

/**
 * @description  here we are navigating back to home page.......
 * @date         26/09/2016
 * @method       backAction
 * @author       Bhargav.v
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
 * @description  displaying popOver for the showDeliveryType options....
 * @date         16/04/2019
 * @method       showDeliveryType:
 * @author       Roja
 * @param        UIButton
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)showDeliveryType:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        deliveryTypeArray = [NSMutableArray new];
        
        [deliveryTypeArray addObject:@"Pick Up"];
        [deliveryTypeArray addObject:@"Door Delivery"];
        
        float tableHeight = deliveryTypeArray.count * 35;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = deliveryTypeArray.count * 33;
        
        if(deliveryTypeArray.count>5)
            tableHeight = (tableHeight/deliveryTypeArray.count) * 5;
        
        [self showPopUpForTables:deliveryTypeTable  popUpWidth:(deliveryTypeText.frame.size.width)  popUpHeight:tableHeight presentPopUpAt:deliveryTypeText  showViewIn:orderSummaryView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
    }
}


/**
 * @description  displaying popOver for the show delivery Model options....
 * @date         16/04/2019
 * @method       showDeliveryModel:
 * @author       Roja
 * @param        UIButton
 * @param
 * @return
 * @return
 *
 * modified By
 * Reason On
 *
 * @verified By
 * @verified On
 *
 */

-(void)showDeliveryModel:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        deliveryModelArray = [NSMutableArray new];
        
        [deliveryModelArray addObject:@"Immediate"];
        [deliveryModelArray addObject:@"Any Time"];
        //        [deliveryModelArray addObject:@"Road"];
        //        [deliveryModelArray addObject:@"Rail"];
        //        [deliveryModelArray addObject:@"Courier"];
        //        [deliveryModelArray addObject:@"Direct Person"];
        
        float tableHeight = deliveryModelArray.count * 35;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = deliveryModelArray.count * 33;
        
        if(deliveryModelArray.count>5)
            tableHeight = (tableHeight/deliveryModelArray.count) * 5;
        
        [self showPopUpForTables:deliveryModelTable  popUpWidth:(deliveryModelText.frame.size.width)  popUpHeight:tableHeight presentPopUpAt:deliveryModelText  showViewIn:orderSummaryView permittedArrowDirections:UIPopoverArrowDirectionUp];
        
    } @catch (NSException *exception) {
        
    }
}

/**
 * @description  Here we are showing the time picker in PopOverViewController
 * @date         16/04/2019
 * @method       showTimeInPopUp
 * @author       Roja
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */
- (void)showTimeInPopUp:(UIButton *)sender {

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
        pickView.frame = CGRectMake( 15, startTimeText.frame.origin.y + startTimeText.frame.size.height, 320, 320);
        pickView.backgroundColor = [UIColor colorWithRed:(119/255.0) green:(136/255.0) blue:(153/255.0) alpha:0.8f];
        pickView.layer.masksToBounds = YES;
        pickView.layer.cornerRadius = 12.0f;

        //pickerframe creation...
        CGRect pickerFrame = CGRectMake(0,50,0,0);
        myPicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
        myPicker.backgroundColor = [UIColor whiteColor];
        myPicker.datePickerMode = UIDatePickerModeTime;

        UIButton  *pickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [pickButton setBackgroundImage:[UIImage imageNamed:@"ok2.png"] forState:UIControlStateNormal];
        pickButton.layer.masksToBounds = YES;
        [pickButton addTarget:self action:@selector(populateTimeToTextField:) forControlEvents:UIControlEventTouchUpInside];
        pickButton.tag = sender.tag;
        [customView addSubview:myPicker];
        [customView addSubview:pickButton];

        UIButton  *clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [clearButton setBackgroundImage:[UIImage imageNamed:@"Clear.png"] forState:UIControlStateNormal];
        clearButton.layer.masksToBounds = YES;
        [clearButton addTarget:self action:@selector(clearDate:) forControlEvents:UIControlEventTouchUpInside];
        clearButton.tag = sender.tag;
        [customView addSubview:clearButton];

        pickButton.frame = CGRectMake( ((customView.frame.size.width - 230)/ 3), 270, 110, 45);
        clearButton.frame = CGRectMake( pickButton.frame.origin.x + pickButton.frame.size.width + ((customView.frame.size.width - 200)/ 3), pickButton.frame.origin.y, pickButton.frame.size.width, pickButton.frame.size.height);

        customerInfoPopUp.view = customView;

        customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);

        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];

        if(sender.tag == 2)
            [popover presentPopoverFromRect: startTimeText.frame inView:orderSummaryView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        else
            [popover presentPopoverFromRect:endTimeText.frame inView:orderSummaryView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];

        catPopOver= popover;

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
 * @description  clear the Time from textField
 * @date         16/04/2019
 * @method       clearDate:
 * @author       Roja
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)clearTime:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        [catPopOver dismissPopoverAnimated:YES];
        
        if(sender.tag == 2){
            if((startTimeText.text).length)
                startTimeText.text = @"";
        }
        else{
            if((endTimeText.text).length)
                endTimeText.text = @"";
        }
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
    } @finally {
        
    }
}

/**
 * @description  Here we are setting the selected time to text field..
 * @date         16/04/2019
 * @method       populateTimeToTextField:
 * @author       Roja
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */
-(void)populateTimeToTextField:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        [catPopOver dismissPopoverAnimated:YES];
        
        //Date Formate Setting...
        NSDateFormatter *requiredDateFormat = [[NSDateFormatter alloc] init];
        [requiredDateFormat setDateFormat:@"hh:mm a"];
        dateString = [requiredDateFormat stringFromDate:myPicker.date];
        
        NSString * selectedTimeString = [requiredDateFormat stringFromDate:myPicker.date];
        
        if (sender.tag == 2) {
            startTimeText.text = selectedTimeString;
        }
        else{
            endTimeText.text = selectedTimeString;
        }
        
    } @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}




// added by roja on 04/12/2019...
-(void)goToTrackingPage:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    if(orderListArray.count > sender.tag) {
        
        OrderTrackingPageNew * trackingPage = [[OrderTrackingPageNew alloc] init];
        trackingPage.orderId  = [orderListArray[sender.tag] valueForKey:ORDER_ID];
        [self.navigationController pushViewController:trackingPage animated:YES];
    }
}
//Upto here added by roja on 04/12/2019...


@end

