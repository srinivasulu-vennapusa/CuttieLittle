
//  OpenStockIssue.m
//  OmniRetailer
//  Modified By Bhargav.v



#import "StockReceiptServiceSvc.h"
#import "PopOverViewController.h"
#import "OmniHomePage.h"
#import "OpenStockReceipt.h"
#import "OpenStockIssue.h"
#import "MaterialTransferIssue.h"
#import "StockIssueServiceSvc.h"
#import "OmniRetailerViewController.h"
#import "OmniHomePage.h"
#import "RequestHeader.h"

@implementation OpenStockIssue

@synthesize soundFileURLRef,soundFileObject;
@synthesize IssueId,selectIndex;

#pragma  -mark start of ViewLifeCycle mehods....

/**
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date         04/11/2016
 * @method       ViewDidLoad
 * @author       Bhargav
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //reading the DeviceVersion....
    version = [UIDevice currentDevice].systemVersion.floatValue;
    
    //here we reading the DeviceOrientaion....
    currentOrientation = [UIDevice currentDevice].orientation;
    
    //added by Srinivasulu on 26/03/2018....
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && !(currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight))
        currentOrientation = UIDeviceOrientationLandscapeRight;
    
    //upto here on 26/03/2018....
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (__bridge CFURLRef)tapSound;
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
    
    
    // Show the HUD
    [HUD show:YES];
    [HUD setHidden:NO];
    
    HUD.labelText = NSLocalizedString(@"please_wait..", nil);
    
    //creating the createReceiptView which will displayed completed Screen.......
    createReceiptView = [[UIView alloc] init];
    createReceiptView.backgroundColor = [UIColor blackColor];
    createReceiptView.layer.borderWidth = 1.0f;
    createReceiptView.layer.cornerRadius = 10.0f;
    createReceiptView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    /*Creation of UILabel for headerDisplay.......*/
    //creating line  UILabel which will display at topOfThe  stockRequest View...
    
    UILabel * headerNameLbl;
    CALayer * bottomBorder;
    
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
    
    //column 1
    UILabel * fromLocLbl;
    UILabel * storeIdLbl;
    
    fromLocLbl = [[UILabel alloc] init];
    fromLocLbl.text = NSLocalizedString(@"fromLocation", nil);
    fromLocLbl.layer.cornerRadius = 14;
    fromLocLbl.layer.masksToBounds = YES;
    fromLocLbl.numberOfLines = 2;
    fromLocLbl.textAlignment = NSTextAlignmentLeft;
    fromLocLbl.backgroundColor = [UIColor clearColor];
    fromLocLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];

    storeIdLbl = [[UILabel alloc] init];
    storeIdLbl.text = NSLocalizedString(@"to_store_code", nil);
    storeIdLbl.layer.cornerRadius = 14;
    storeIdLbl.layer.masksToBounds = YES;
    storeIdLbl.numberOfLines = 2;
    storeIdLbl.textAlignment = NSTextAlignmentLeft;
    storeIdLbl.backgroundColor = [UIColor clearColor];
    storeIdLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];


    //column 2
    UILabel *  issueDateLbl;
    UILabel *  deliverDteLbl;
    
    issueDateLbl = [[UILabel alloc] init];
    issueDateLbl.text = NSLocalizedString(@"issue_date", nil);
    issueDateLbl.layer.cornerRadius = 14;
    issueDateLbl.layer.masksToBounds = YES;
    issueDateLbl.numberOfLines = 2;
    issueDateLbl.textAlignment = NSTextAlignmentLeft;
    issueDateLbl.backgroundColor = [UIColor clearColor];
    issueDateLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    deliverDteLbl = [[UILabel alloc] init];
    deliverDteLbl.text = NSLocalizedString(@"delivered_on", nil);
    deliverDteLbl.layer.cornerRadius = 14;
    deliverDteLbl.layer.masksToBounds = YES;
    deliverDteLbl.numberOfLines = 2;
    deliverDteLbl.textAlignment = NSTextAlignmentLeft;
    deliverDteLbl.backgroundColor = [UIColor clearColor];
    deliverDteLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];

    
    //column 3
    UILabel * requestRefLbl;
    UILabel * RequestDateLbl;
    
    requestRefLbl = [[UILabel alloc] init];
    requestRefLbl.text = NSLocalizedString(@"request_ref_no", nil);
    requestRefLbl.layer.cornerRadius = 14;
    requestRefLbl.layer.masksToBounds = YES;
    requestRefLbl.numberOfLines = 2;
    requestRefLbl.textAlignment = NSTextAlignmentLeft;
    requestRefLbl.backgroundColor = [UIColor clearColor];
    requestRefLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5  ];
    
    RequestDateLbl = [[UILabel alloc] init];
    RequestDateLbl.text = NSLocalizedString(@"request_date", nil);
    RequestDateLbl.layer.cornerRadius = 14;
    RequestDateLbl.layer.masksToBounds = YES;
    RequestDateLbl.numberOfLines = 2;
    RequestDateLbl.textAlignment = NSTextAlignmentLeft;
    RequestDateLbl.backgroundColor = [UIColor clearColor];
    RequestDateLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5  ];
    
    //column 4
    
    UILabel * shipmentModeLbl;
    UILabel * shipmentRefLbl;
    
    shipmentModeLbl = [[UILabel alloc] init];
    shipmentModeLbl.text = NSLocalizedString(@"shipment_mode", nil);
    shipmentModeLbl.layer.cornerRadius = 14;
    shipmentModeLbl.layer.masksToBounds = YES;
    shipmentModeLbl.numberOfLines = 2;
    shipmentModeLbl.textAlignment = NSTextAlignmentLeft;
    shipmentModeLbl.backgroundColor = [UIColor clearColor];
    shipmentModeLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];

    shipmentRefLbl = [[UILabel alloc] init];
    shipmentRefLbl.text = NSLocalizedString(@"shipment_ref.", nil);
    shipmentRefLbl.layer.cornerRadius = 14;
    shipmentRefLbl.layer.masksToBounds = YES;
    shipmentRefLbl.numberOfLines = 2;
    shipmentRefLbl.textAlignment = NSTextAlignmentLeft;
    shipmentRefLbl.backgroundColor = [UIColor clearColor];
    shipmentRefLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    //column 5

    UILabel * issuedByLbl;
    UILabel * carriedByLbl;
    
    issuedByLbl = [[UILabel alloc] init];
    issuedByLbl.text = NSLocalizedString(@"issued_by", nil);
    issuedByLbl.layer.cornerRadius = 14;
    issuedByLbl.layer.masksToBounds = YES;
    issuedByLbl.numberOfLines = 2;
    issuedByLbl.textAlignment = NSTextAlignmentLeft;
    issuedByLbl.backgroundColor = [UIColor clearColor];
    issuedByLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    carriedByLbl = [[UILabel alloc] init];
    carriedByLbl.text = NSLocalizedString(@"carried_by", nil);
    carriedByLbl.layer.cornerRadius = 14;
    carriedByLbl.layer.masksToBounds = YES;
    carriedByLbl.numberOfLines = 2;
    carriedByLbl.textAlignment = NSTextAlignmentLeft;
    carriedByLbl.backgroundColor = [UIColor clearColor];
    carriedByLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    //column 6
    
    UILabel * actionReqLbl = [[UILabel alloc] init];
    actionReqLbl.text = NSLocalizedString(@"action_required",nil);
    actionReqLbl.layer.cornerRadius = 14;
    actionReqLbl.layer.masksToBounds = YES;
    actionReqLbl.numberOfLines = 2;
    actionReqLbl.textAlignment = NSTextAlignmentLeft;
    actionReqLbl.backgroundColor = [UIColor clearColor];
    actionReqLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
    
    //End Of UILabels...
    
    //TextField Creation under the corresponding Labels....
    
    //Column 1
    
    fromLocTxt = [[CustomTextField alloc] init];
    fromLocTxt.placeholder = NSLocalizedString(@"from_location", nil);
    fromLocTxt.delegate = self;
    fromLocTxt.text = presentLocation;
    [fromLocTxt awakeFromNib];
    
    toStoreCodeTxt = [[CustomTextField alloc] init];
    toStoreCodeTxt.placeholder = NSLocalizedString(@"toLocation", nil);
    toStoreCodeTxt.delegate = self;
    toStoreCodeTxt.userInteractionEnabled =NO;
    [toStoreCodeTxt awakeFromNib];

    //Column 2
    issueDateTxt = [[CustomTextField alloc] init];
    issueDateTxt.placeholder = NSLocalizedString(@"issue_date", nil);
    issueDateTxt.delegate = self;
    issueDateTxt.userInteractionEnabled =NO;
    [issueDateTxt awakeFromNib];
    
    
    deliveryDteTxt = [[CustomTextField alloc] init];
    deliveryDteTxt.placeholder = NSLocalizedString(@"delivery_Date",nil);
    deliveryDteTxt.delegate = self;
    deliveryDteTxt.userInteractionEnabled =NO;
    [deliveryDteTxt awakeFromNib];
    
    
    //Column 3...
    
    
    requestRefNoTxt = [[CustomTextField alloc] init];
    requestRefNoTxt.placeholder = NSLocalizedString(@"request_ref_no",nil);
    requestRefNoTxt.delegate = self;
    requestRefNoTxt.userInteractionEnabled =NO;
    [requestRefNoTxt awakeFromNib];

    requestDateTxt = [[CustomTextField alloc] init];
    requestDateTxt.placeholder = NSLocalizedString(@"request_date",nil);
    requestDateTxt.delegate = self;
    requestDateTxt.userInteractionEnabled =NO;
    [requestDateTxt awakeFromNib];

    //column 4
    
    shipmentModeTxt = [[CustomTextField alloc] init];
    shipmentModeTxt.placeholder = NSLocalizedString(@"shipment_mode", nil);
    shipmentModeTxt.delegate = self;
    [shipmentModeTxt awakeFromNib];
    shipmentModeTxt.userInteractionEnabled = NO;
    
    shipmentRefTxt = [[CustomTextField alloc] init];
    shipmentRefTxt.placeholder = NSLocalizedString(@"shipment_ref_no", nil);
    shipmentRefTxt.delegate = self;
    [shipmentRefTxt awakeFromNib];
    
    
    // Cloumn 4
    
    issuedByTxt = [[CustomTextField alloc] init];
    issuedByTxt.placeholder = NSLocalizedString(@"issued_by", nil);
    issuedByTxt.delegate = self;
    issuedByTxt.text = firstName;

    [issuedByTxt awakeFromNib];
    
    
    carriedByTxt = [[CustomTextField alloc] init];
    carriedByTxt.placeholder = NSLocalizedString(@"carried_by", nil);
    carriedByTxt.delegate = self;
    [carriedByTxt awakeFromNib];
    
    //Column 5
    
    
    ActionReqTxt = [[CustomTextField alloc] init];
    ActionReqTxt.placeholder = NSLocalizedString(@"action_required", nil);
    ActionReqTxt.delegate = self;
    ActionReqTxt.userInteractionEnabled = NO;
    [ActionReqTxt awakeFromNib];

    UIImage *calendarImg;
    UIImage *dropDownImg;

    UIButton * selectDlvryDte;
    UIButton * selectIssueDate;
    UIButton * selectRequestDte;
    UIButton * toStoreLoction;
    UIButton * selctShipment;
    UIButton * selctAction;
    
    calendarImg  = [UIImage imageNamed:@"Calandar_Icon.png"];
    dropDownImg  = [UIImage imageNamed:@"arrow_1.png"];
    
     toStoreLoction = [UIButton buttonWithType:UIButtonTypeCustom];
    [toStoreLoction setBackgroundImage:dropDownImg forState:UIControlStateNormal];
    [toStoreLoction addTarget:self
                       action:@selector(populateLocationsTable:) forControlEvents:UIControlEventTouchDown];
    
    selectIssueDate = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectIssueDate setBackgroundImage:calendarImg forState:UIControlStateNormal];
    [selectIssueDate addTarget:self
                        action:@selector(selectrequiredDate:) forControlEvents:UIControlEventTouchDown];
    //    selectIssueDate.hidden =YES;
    
    selectDlvryDte = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectDlvryDte setBackgroundImage:calendarImg forState:UIControlStateNormal];
    [selectDlvryDte addTarget:self
                       action:@selector(selectrequiredDate:) forControlEvents:UIControlEventTouchDown];
//    selectDlvryDte.hidden =YES;

    
    selectRequestDte = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectRequestDte setBackgroundImage:calendarImg forState:UIControlStateNormal];
    [selectRequestDte addTarget:self
                       action:@selector(selectrequiredDate:) forControlEvents:UIControlEventTouchDown];
    //    selectDlvryDte.hidden =YES;

    selctShipment = [UIButton buttonWithType:UIButtonTypeCustom];
    [selctShipment setBackgroundImage:dropDownImg forState:UIControlStateNormal];
    [selctShipment addTarget:self
                      action:@selector(getShipmentModes) forControlEvents:UIControlEventTouchDown];
    
    
    selctAction  = [UIButton buttonWithType:UIButtonTypeCustom];
    [selctAction setBackgroundImage:dropDownImg forState:UIControlStateNormal];
    [selctAction addTarget:self
                    action:@selector(showNextAcivities:) forControlEvents:UIControlEventTouchDown];

    //Allocation of SearchItemsTxt UITextField.......
    searchItemsTxt = [[CustomTextField alloc] init];
    searchItemsTxt.placeholder = NSLocalizedString(@"Search_Sku_Here", nil);
    searchItemsTxt.delegate = self;
    [searchItemsTxt awakeFromNib];
    searchItemsTxt.borderStyle = UITextBorderStyleRoundedRect;
    searchItemsTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchItemsTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    searchItemsTxt.borderStyle = UITextBorderStyleRoundedRect;
    searchItemsTxt.textColor = [UIColor blackColor];
    searchItemsTxt.layer.borderColor = [UIColor clearColor].CGColor;
    searchItemsTxt.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    [searchItemsTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    //    Creation of UIScrollView....
    
    stockIssueScrollView = [[UIScrollView alloc] init];
    
    //Creation of items TableHeader's.......
    sNoLbl = [[CustomLabel alloc] init];
    [sNoLbl awakeFromNib];
    
    skuIdLbl = [[CustomLabel alloc] init];
    [skuIdLbl awakeFromNib];
    
    descriptionLbl = [[CustomLabel alloc] init];
    [descriptionLbl awakeFromNib];
    
    uomLbl = [[CustomLabel alloc] init];
    [uomLbl awakeFromNib];
    
    rangeLbl = [[CustomLabel alloc] init];
    [rangeLbl awakeFromNib];
    
    gradeLbl = [[CustomLabel alloc] init];
    [gradeLbl awakeFromNib];
    
    priceLabel = [[CustomLabel alloc] init];
    [priceLabel awakeFromNib];
    
    availQtyLbl = [[CustomLabel alloc] init];
    [availQtyLbl awakeFromNib];
    
    stockQtyLbl = [[CustomLabel alloc] init];
    [stockQtyLbl awakeFromNib];
    
    issueQtyLbl = [[CustomLabel alloc] init];
    [issueQtyLbl awakeFromNib];
    
    scanCodeLabel = [[CustomLabel alloc] init];
    [scanCodeLabel awakeFromNib];
    
    balanceQtyLbl = [[CustomLabel alloc] init];
    [balanceQtyLbl awakeFromNib];
    
    make_Lbl = [[CustomLabel alloc] init];
    [make_Lbl awakeFromNib];
    
    actionLbl = [[CustomLabel alloc] init];
    [actionLbl awakeFromNib];
    
    productListTbl = [[UITableView alloc] init];
    productListTbl.dataSource = self;
    productListTbl.delegate = self;
    productListTbl.backgroundColor = [UIColor blackColor];
    productListTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    productListTbl.hidden = YES;

    //creating the workFlowView.......
    workFlowView = [[UIView alloc] init];
    
    //requestedItemsTbl creation...
    requestedItemsTbl = [[UITableView alloc] init];
    requestedItemsTbl.backgroundColor  = [UIColor clearColor];
    requestedItemsTbl.layer.cornerRadius = 4.0;
    requestedItemsTbl.bounces = TRUE;
    requestedItemsTbl.dataSource = self;
    requestedItemsTbl.delegate = self;
    requestedItemsTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    //nextActivitiesTbl creation......
    nextActivityTbl = [[UITableView alloc] init];
    nextActivityTbl.layer.borderWidth = 1.0;
    nextActivityTbl.layer.cornerRadius = 4.0;
    nextActivityTbl.layer.borderColor = [UIColor blackColor].CGColor;
    nextActivityTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    nextActivityTbl.dataSource = self;
    nextActivityTbl.delegate = self;
    
    
    //    creation of Labels for the item calculation
    UILabel *line_;
    UILabel *line_2;
    
    line_  = [[UILabel alloc] init];
    line_.layer.masksToBounds = YES;
    line_.backgroundColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0];
    
    
    line_2 = [[UILabel alloc] init];
    line_2.layer.masksToBounds = YES;
    line_2.backgroundColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0];
    
    UILabel *totalIsuesLbl;
    UILabel *totalSaleCostLbl;
    
    totalIsuesLbl = [[UILabel alloc] init];
    totalIsuesLbl.layer.masksToBounds = YES;
    totalIsuesLbl.numberOfLines = 2;
    totalIsuesLbl.textColor = [UIColor whiteColor];
    
    totalSaleCostLbl = [[UILabel alloc] init];
    totalSaleCostLbl.layer.masksToBounds = YES;
    totalSaleCostLbl.numberOfLines = 2;
    totalSaleCostLbl.textColor = [UIColor whiteColor];
    
    totalIssuesValueLbl = [[UILabel alloc] init];
    totalIssuesValueLbl.layer.masksToBounds = YES;
    totalIssuesValueLbl.numberOfLines = 2;
    
    totalSaleCostValueCost = [[UILabel alloc] init];
    totalSaleCostValueCost.layer.masksToBounds = YES;
    totalSaleCostValueCost.numberOfLines = 2;

    //end of calculations..
    
    
    
    
    //Recently Added Labels For making the total of stock quantity
    
    
    priceValueLbl = [[UILabel alloc] init];
    priceValueLbl.layer.cornerRadius = 5;
    priceValueLbl.layer.masksToBounds = YES;
    priceValueLbl.backgroundColor = [UIColor blackColor];
    priceValueLbl.layer.borderWidth = 2.0f;
    priceValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    priceValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    priceValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    stockQtyValueLbl = [[UILabel alloc] init];
    stockQtyValueLbl.layer.cornerRadius = 5;
    stockQtyValueLbl.layer.masksToBounds = YES;
    stockQtyValueLbl.backgroundColor = [UIColor blackColor];
    stockQtyValueLbl.layer.borderWidth = 2.0f;
    stockQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    stockQtyValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    stockQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    issueQtyValueLbl = [[UILabel alloc] init];
    issueQtyValueLbl.layer.cornerRadius = 5;
    issueQtyValueLbl.layer.masksToBounds = YES;
    issueQtyValueLbl.backgroundColor = [UIColor blackColor];
    issueQtyValueLbl.layer.borderWidth = 2.0f;
    issueQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    issueQtyValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    issueQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    balanceQtyValueLbl = [[UILabel alloc] init];
    balanceQtyValueLbl.layer.cornerRadius = 5;
    balanceQtyValueLbl.layer.masksToBounds = YES;
    balanceQtyValueLbl.backgroundColor = [UIColor blackColor];
    balanceQtyValueLbl.layer.borderWidth = 2.0f;
    balanceQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    balanceQtyValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    balanceQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    priceValueLbl.text = @"0.0";
    stockQtyValueLbl.text = @"0.0";
    issueQtyValueLbl.text = @"0.0";
    balanceQtyValueLbl.text = @"0.0";
    
    priceValueLbl.textAlignment = NSTextAlignmentCenter;
    stockQtyValueLbl.textAlignment = NSTextAlignmentCenter;
    issueQtyValueLbl.textAlignment = NSTextAlignmentCenter;
    balanceQtyValueLbl.textAlignment = NSTextAlignmentCenter;
    
    //added by Srinivasulu on 04/04/2017....
    @try {
        
        self.titleLabel.text = NSLocalizedString(@"omni_retailer",nil);
        headerNameLbl.text = NSLocalizedString(@"edit_Stock_issue",nil);
        

        
        sNoLbl.text = NSLocalizedString(@"S_NO", nil);
        skuIdLbl.text = NSLocalizedString(@"sku_id", nil);
        descriptionLbl.text = NSLocalizedString(@"item_desc", nil);
        uomLbl.text = NSLocalizedString(@"uom", nil);
        rangeLbl.text = NSLocalizedString(@"range", nil);
        gradeLbl.text = NSLocalizedString(@"grade", nil);
        priceLabel.text = NSLocalizedString(@"price", nil);
        availQtyLbl.text = NSLocalizedString(@"avl_qty", nil);
        stockQtyLbl.text = NSLocalizedString(@"stock_qty", nil);
        issueQtyLbl.text = NSLocalizedString(@"issue_qty", nil);
        balanceQtyLbl.text = NSLocalizedString(@"balance_qty", nil);
        scanCodeLabel.text = NSLocalizedString(@"item_code",nil);
        make_Lbl.text = NSLocalizedString(@"make", nil);
        actionLbl.text = NSLocalizedString(@"action", nil);
        
        totalIsuesLbl.textAlignment = NSTextAlignmentLeft;
        totalSaleCostLbl.textAlignment = NSTextAlignmentLeft;
        
        totalIssuesValueLbl.textAlignment = NSTextAlignmentRight;
        totalSaleCostValueCost.textAlignment = NSTextAlignmentRight;
        
        totalIsuesLbl.text = NSLocalizedString(@"total_issues_:", nil);
        totalSaleCostLbl.text = NSLocalizedString(@"total_sale_cost_:", nil);
        
        totalIsuesLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        totalSaleCostLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        
        totalIssuesValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        totalSaleCostValueCost.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        
        //upto on 14/04/2017....
    } @catch (NSException *exception) {
        
    }
    
    /**creating UIButton*/
    
    editBtn = [[UIButton alloc] init];
    [editBtn addTarget:self
                  action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchDown];
    editBtn.layer.cornerRadius = 3.0f;
    editBtn.backgroundColor = [UIColor grayColor];
    [editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    editBtn.userInteractionEnabled = YES;
//    [editBtn setTitle:NSLocalizedString(@"edit", nil) forState:UIControlStateNormal];
    editBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    cancelBtn = [[UIButton alloc] init];
    [cancelBtn addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchDown];
    cancelBtn.layer.cornerRadius = 3.0f;
    cancelBtn.backgroundColor = [UIColor grayColor];
    cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [editBtn setTitle:NSLocalizedString(@"edit", nil) forState:UIControlStateNormal];
    [cancelBtn setTitle:NSLocalizedString(@"cancel", nil) forState:UIControlStateNormal];

    //  creation of price View
    
    priceTable = [[UITableView alloc] init];
    priceTable.backgroundColor = [UIColor blackColor];
    priceTable.dataSource = self;
    priceTable.delegate = self;
    priceTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    priceTable.layer.cornerRadius = 3;
    
    closeBtn = [[UIButton alloc] init] ;
    [closeBtn addTarget:self action:@selector(closePriceView:) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.tag = 11;
    
    UIImage * image = [UIImage imageNamed:@"delete.png"];
    [closeBtn setBackgroundImage:image    forState:UIControlStateNormal];
    
    priceView = [[UIView alloc] init];
    priceView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6f];
    priceView.layer.borderColor = [UIColor whiteColor].CGColor;
    priceView.layer.borderWidth = 1.0;
    
    transparentView = [[UIView alloc]init];
    transparentView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6f];
    transparentView.hidden = YES;
    
    descLabl = [[UILabel alloc]init];
    descLabl.text =NSLocalizedString(@"description", nil) ;
    descLabl.layer.cornerRadius = 14;
    descLabl.textAlignment = NSTextAlignmentCenter;
    descLabl.layer.masksToBounds = YES;
    descLabl.font = [UIFont boldSystemFontOfSize:14.0];
    descLabl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14.0f];
    descLabl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    descLabl.textColor = [UIColor whiteColor];
    
    mrpLbl = [[UILabel alloc]init];
    mrpLbl.text =NSLocalizedString(@"mrp_rps", nil) ;
    mrpLbl.layer.cornerRadius = 14;
    mrpLbl.layer.masksToBounds = YES;
    mrpLbl.textAlignment = NSTextAlignmentCenter;
    mrpLbl.font = [UIFont boldSystemFontOfSize:14.0];
    mrpLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14.0f];
    mrpLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    mrpLbl.textColor = [UIColor whiteColor];
    
    priceLbl = [[UILabel alloc]init];
    priceLbl.text =NSLocalizedString(@"price", nil) ;
    priceLbl.layer.cornerRadius = 14;
    priceLbl.layer.masksToBounds = YES;
    priceLbl.textAlignment = NSTextAlignmentCenter;
    priceLbl.font = [UIFont boldSystemFontOfSize:14.0];
    priceLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14.0f];
    priceLbl.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    priceLbl.textColor = [UIColor whiteColor];
    
    
    //creation of Select List Button...
    
    UIImage * productListImg;
    
    
    productListImg  = [UIImage imageNamed:@"btn_list.png"];
    
    selectCategoriesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectCategoriesBtn setBackgroundImage:productListImg forState:UIControlStateNormal];
    [selectCategoriesBtn addTarget:self
                            action:@selector(validatingCategoriesList:) forControlEvents:UIControlEventTouchDown];
    
    
    //Allocation of  UIView For Multiple Issuese.....
    
    multipleIssuesView = [[UIView alloc] init];
    multipleIssuesView.backgroundColor = [UIColor blackColor];
    multipleIssuesView.layer.borderColor = [UIColor whiteColor].CGColor;
    multipleIssuesView.layer.borderWidth = 1.0;
    multipleIssuesView.layer.cornerRadius = 3.0f;
    multipleIssuesView.hidden = YES;
    
    /*Creation of UILabel for headerDisplay.......*/
    //creating line  UILabel which will display at topOfThe  billingView.......
    UILabel * locationHeaderNameLbl;
    CALayer * locationbottomBorder;
    UIButton * selectMultipleStoresBtn;
    
    //headerNameLbl used to identify the flow....
    locationHeaderNameLbl = [[UILabel alloc] init];
    locationHeaderNameLbl.layer.cornerRadius = 10.0f;
    locationHeaderNameLbl.layer.masksToBounds = YES;
    
    locationHeaderNameLbl.textAlignment = NSTextAlignmentCenter;
    locationHeaderNameLbl.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
    locationHeaderNameLbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gradient.png"]];
    locationHeaderNameLbl.text = NSLocalizedString(@"select_stores",nil);

    //it is regard's to the view borderwidth and color setting....
    locationbottomBorder = [CALayer layer];
    locationbottomBorder.opacity = 5.0f;
    locationbottomBorder.backgroundColor = [UIColor grayColor].CGColor;
    locationbottomBorder.frame = CGRectMake(0.0f, 60.0f,locationHeaderNameLbl.frame.size.width, 1.0f);
    [headerNameLbl.layer addSublayer:locationbottomBorder];
    
    locationCloseBtn = [[UIButton alloc] init] ;
    [locationCloseBtn addTarget:self action:@selector(closeMultipleIssuesview:) forControlEvents:UIControlEventTouchUpInside];
    
    [locationCloseBtn setBackgroundImage:image    forState:UIControlStateNormal];
    
    locationTable = [[UITableView alloc] init];
    locationTable.backgroundColor  = [UIColor blackColor];
    locationTable.layer.cornerRadius = 4.0;
    locationTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    locationTable.dataSource = self;
    locationTable.delegate = self;
    
    
    selectMultipleStoresBtn = [[UIButton alloc] init] ;
    [selectMultipleStoresBtn setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
    selectMultipleStoresBtn.backgroundColor = [UIColor grayColor];
    selectMultipleStoresBtn.layer.masksToBounds = YES;
    selectMultipleStoresBtn.userInteractionEnabled = YES;
    selectMultipleStoresBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    selectMultipleStoresBtn.layer.cornerRadius = 5.0f;
    [selectMultipleStoresBtn addTarget:self action:@selector(AddMultipleLocations:) forControlEvents:UIControlEventTouchDown];
    
   
    
    
    
    [createReceiptView addSubview:headerNameLbl];
    
    [createReceiptView addSubview:fromLocLbl];
    [createReceiptView addSubview:fromLocTxt];
    
    [createReceiptView addSubview:storeIdLbl];
    [createReceiptView addSubview:toStoreCodeTxt];
    
    [createReceiptView addSubview:issueDateLbl];
    [createReceiptView addSubview:issueDateTxt];
    
    [createReceiptView addSubview:deliverDteLbl];
    [createReceiptView addSubview:deliveryDteTxt];
    
    [createReceiptView addSubview:requestRefLbl];
    [createReceiptView addSubview:requestRefNoTxt];
    
    [createReceiptView addSubview:RequestDateLbl];
    [createReceiptView addSubview:requestDateTxt];
    
    [createReceiptView addSubview:shipmentModeLbl];
    [createReceiptView addSubview:shipmentModeTxt];

    [createReceiptView addSubview:shipmentRefLbl];
    [createReceiptView addSubview:shipmentRefTxt];

    [createReceiptView addSubview:issuedByLbl];
    [createReceiptView addSubview:issuedByTxt];

    [createReceiptView addSubview:carriedByLbl];
    [createReceiptView addSubview:carriedByTxt];
    
    [createReceiptView addSubview:selectDlvryDte];
    [createReceiptView addSubview:selectIssueDate];
    [createReceiptView addSubview:selectRequestDte];
    [createReceiptView addSubview:toStoreLoction];
    [createReceiptView addSubview:selctShipment];
    [createReceiptView addSubview:selctAction];
    
    [createReceiptView addSubview:actionReqLbl];
    [createReceiptView addSubview:ActionReqTxt];
    
    [createReceiptView addSubview:selctAction];
    
    [createReceiptView addSubview:workFlowView];
    
    
    [createReceiptView addSubview:searchItemsTxt];
    
    [createReceiptView addSubview:selectCategoriesBtn];

    [stockIssueScrollView addSubview:sNoLbl];
    [stockIssueScrollView addSubview:skuIdLbl];
    [stockIssueScrollView addSubview:descriptionLbl];
    [stockIssueScrollView addSubview:uomLbl];
    [stockIssueScrollView addSubview:rangeLbl];
    [stockIssueScrollView addSubview:gradeLbl];
    [stockIssueScrollView addSubview:priceLabel];
    [stockIssueScrollView addSubview:availQtyLbl];
    [stockIssueScrollView addSubview:stockQtyLbl];
    [stockIssueScrollView addSubview:issueQtyLbl];
    [stockIssueScrollView addSubview:balanceQtyLbl];
    [stockIssueScrollView addSubview:scanCodeLabel];

    
    [stockIssueScrollView addSubview:make_Lbl];
    [stockIssueScrollView addSubview:actionLbl];
    [stockIssueScrollView addSubview:requestedItemsTbl];
  
    [createReceiptView addSubview:editBtn];
    [createReceiptView addSubview:cancelBtn];
    
    [createReceiptView addSubview:priceValueLbl];
    [createReceiptView addSubview:stockQtyValueLbl];
    [createReceiptView addSubview:issueQtyValueLbl];
    [createReceiptView addSubview:balanceQtyValueLbl];
    

//    [createReceiptView addSubview:line_];
//    [createReceiptView addSubview:totalIsuesLbl];
//    [createReceiptView addSubview:totalIssuesValueLbl];
//    
//    [createReceiptView addSubview:totalSaleCostLbl];
//    [createReceiptView addSubview:totalSaleCostValueCost];
//    [createReceiptView addSubview:line_2];
    
    //    adding price list view for the stock Issue View
    
    [priceView addSubview:priceLbl];
    [priceView addSubview:mrpLbl];
    [priceView addSubview:descLabl];
    [priceView addSubview:priceTable];
    [transparentView addSubview:priceView];
    [transparentView addSubview:closeBtn];
    
    [createReceiptView addSubview:stockIssueScrollView];
    [createReceiptView addSubview:productListTbl];
    
    //Adding UIview for the multipleIssue...
    [createReceiptView addSubview:multipleIssuesView];
    [multipleIssuesView addSubview:locationTable];
    [multipleIssuesView addSubview:locationHeaderNameLbl];
    [multipleIssuesView addSubview:locationCloseBtn];
    [multipleIssuesView addSubview:selectMultipleStoresBtn];

    
    [self.view addSubview:createReceiptView];
    [self.view addSubview:transparentView];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
            
            
//            float vertical_Gap_for_labels = 10;
            //setting below labe's frame.......
            float labelWidth =  220;
            float labelHeight = 40;
            float horizontalGap = -15;
            
            float textFieldWidth =  180;
            float textFieldHeight = 40;
            
            
            createReceiptView.frame = CGRectMake(2, 70, self.view.frame.size.width - 4, self.view.frame.size.height - 80);
            
            headerNameLbl.frame = CGRectMake(0,0,createReceiptView.frame.size.width,45);
            
            //first Column.......
            fromLocLbl.frame =  CGRectMake(10,headerNameLbl.frame.origin.y+headerNameLbl.frame.size.height,labelWidth, labelHeight);
            
            fromLocTxt.frame =  CGRectMake(fromLocLbl.frame.origin.x, fromLocLbl.frame.origin.y + fromLocLbl.frame.size.height-10, textFieldWidth, textFieldHeight);
            
            storeIdLbl.frame =  CGRectMake(fromLocLbl.frame.origin.x,fromLocTxt.frame.origin.y+fromLocTxt.frame.size.height,labelWidth, labelHeight);
            
            toStoreCodeTxt.frame =  CGRectMake(storeIdLbl.frame.origin.x, storeIdLbl.frame.origin.y + storeIdLbl.frame.size.height-10,textFieldWidth, textFieldHeight);
            
            toStoreLoction.frame = CGRectMake((toStoreCodeTxt.frame.origin.x+toStoreCodeTxt.frame.size.width-45), shipmentModeTxt.frame.origin.y-8, 55, 60);

         // second column
            
            issueDateLbl.frame = CGRectMake(fromLocLbl.frame.origin.x+fromLocLbl.frame.size.width+horizontalGap,fromLocLbl.frame.origin.y,labelWidth,labelHeight);
            
            issueDateTxt.frame = CGRectMake(issueDateLbl.frame.origin.x,fromLocTxt.frame.origin.y,textFieldWidth,textFieldHeight);
            
            
            deliverDteLbl.frame = CGRectMake(issueDateLbl.frame.origin.x,storeIdLbl.frame.origin.y,labelWidth,labelHeight);
            
            deliveryDteTxt.frame = CGRectMake(deliverDteLbl.frame.origin.x,toStoreCodeTxt.frame.origin.y,textFieldWidth,textFieldHeight);
            
           //Third Column...
            
            requestRefLbl.frame = CGRectMake(issueDateLbl.frame.origin.x+issueDateLbl.frame.size.width+horizontalGap,issueDateLbl.frame.origin.y,labelWidth,labelHeight);
            
            requestRefNoTxt.frame = CGRectMake(requestRefLbl.frame.origin.x,issueDateTxt.frame.origin.y,textFieldWidth,textFieldHeight);
            
            RequestDateLbl.frame = CGRectMake(requestRefLbl.frame.origin.x,deliverDteLbl.frame.origin.y,labelWidth,labelHeight);
            
            requestDateTxt.frame = CGRectMake(RequestDateLbl.frame.origin.x,deliveryDteTxt.frame.origin.y,textFieldWidth,textFieldHeight);
            
            //fourth Column
            shipmentModeLbl.frame = CGRectMake(requestRefLbl.frame.origin.x+requestRefLbl.frame.size.width+horizontalGap,requestRefLbl.frame.origin.y,labelWidth,labelHeight);
            shipmentModeTxt.frame = CGRectMake(shipmentModeLbl.frame.origin.x,requestRefNoTxt.frame.origin.y,textFieldWidth,textFieldHeight);
            
            shipmentRefLbl.frame = CGRectMake(shipmentModeLbl.frame.origin.x,RequestDateLbl.frame.origin.y,labelWidth,labelHeight);
            
            shipmentRefTxt.frame = CGRectMake(shipmentRefLbl.frame.origin.x,requestDateTxt.frame.origin.y,textFieldWidth,textFieldHeight);
            
            //Cloumn 5
            
            issuedByLbl.frame = CGRectMake(shipmentModeLbl.frame.origin.x+shipmentModeLbl.frame.size.width+horizontalGap,shipmentModeLbl.frame.origin.y,labelWidth,labelHeight);
            
            issuedByTxt.frame = CGRectMake(issuedByLbl.frame.origin.x,shipmentModeTxt.frame.origin.y,textFieldWidth,textFieldHeight);
            
            carriedByLbl.frame =CGRectMake(issuedByLbl.frame.origin.x,shipmentRefLbl.frame.origin.y,labelWidth,labelHeight);
            
            carriedByTxt.frame = CGRectMake(carriedByLbl.frame.origin.x,shipmentRefTxt.frame.origin.y,textFieldWidth,textFieldHeight);

           //actionReqLbl.frame = CGRectMake(issuedByLbl.frame.origin.x,carriedByTxt.frame.origin.y+carriedByTxt.frame.size.height,labelWidth,labelHeight);
            
            ActionReqTxt.frame = CGRectMake(carriedByTxt.frame.origin.x,carriedByTxt.frame.origin.y+carriedByTxt.frame.size.height+10,textFieldWidth,textFieldHeight);
            //Frames for the UIButtons...
            
            toStoreLoction.frame = CGRectMake((toStoreCodeTxt.frame.origin.x+toStoreCodeTxt.frame.size.width-45), toStoreCodeTxt.frame.origin.y-8,55,60);
            
            selectIssueDate.frame = CGRectMake((issueDateTxt.frame.origin.x+issueDateTxt.frame.size.width-45),issueDateTxt.frame.origin.y+2,40,35);

            selectDlvryDte.frame = CGRectMake((deliveryDteTxt.frame.origin.x+deliveryDteTxt.frame.size.width-45),deliveryDteTxt.frame.origin.y+2,40,35);
            
            selectRequestDte.frame = CGRectMake((requestDateTxt.frame.origin.x+requestDateTxt.frame.size.width-45),requestDateTxt.frame.origin.y+2,40,35);

            selctShipment.frame = CGRectMake((shipmentModeTxt.frame.origin.x+shipmentModeTxt.frame.size.width-45), shipmentModeTxt.frame.origin.y-8,55,60);

            selctAction.frame = CGRectMake((ActionReqTxt.frame.origin.x+ActionReqTxt.frame.size.width-45), ActionReqTxt.frame.origin.y-8, 55, 60);
            
            //setting frame for workFlowView.......
            workFlowView.frame = CGRectMake(0,ActionReqTxt.frame.origin.y,shipmentModeTxt.frame.origin.x + shipmentModeTxt.frame.size.width -fromLocTxt.frame.origin.x,textFieldHeight);
            
            //workFlowView.backgroundColor = [UIColor  lightGrayColor];
            
            searchItemsTxt.frame = CGRectMake(fromLocTxt.frame.origin.x,workFlowView.frame.origin.y+workFlowView.frame.size.height+10,(ActionReqTxt.frame.origin.x + ActionReqTxt.frame.size.width-fromLocTxt.frame.origin.x-80), 40);
            
            productListTbl.frame = CGRectMake(searchItemsTxt.frame.origin.x, searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height,searchItemsTxt.frame.size.width, 260);
            
            //setting the selectCategoriesBtn frame.......
            selectCategoriesBtn.frame = CGRectMake((searchItemsTxt.frame.origin.x + searchItemsTxt.frame.size.width + 5), searchItemsTxt.frame.origin.y,75, 40);

            //setting the tableheader label's...
            
            //setting the tableheader label's...
            
            sNoLbl.frame = CGRectMake(0,0,50,35);
            
            skuIdLbl.frame = CGRectMake(sNoLbl.frame.origin.x+sNoLbl.frame.size.width+2,sNoLbl.frame.origin.y,80, sNoLbl.frame.size.height);
            
            descriptionLbl.frame = CGRectMake(skuIdLbl.frame.origin.x+skuIdLbl.frame.size.width+2,sNoLbl.frame.origin.y,160,sNoLbl.frame.size.height);
            
            uomLbl.frame = CGRectMake(descriptionLbl.frame.origin.x+descriptionLbl.frame.size.width+2,sNoLbl.frame.origin.y,60,sNoLbl.frame.size.height);
            
            rangeLbl.frame = CGRectMake(uomLbl.frame.origin.x+uomLbl.frame.size.width+2,sNoLbl.frame.origin.y,60,sNoLbl.frame.size.height);
            
            gradeLbl.frame = CGRectMake(rangeLbl.frame.origin.x + rangeLbl.frame.size.width + 2,sNoLbl.frame.origin.y,60,sNoLbl.frame.size.height);
            
            priceLabel.frame = CGRectMake(gradeLbl.frame.origin.x + gradeLbl.frame.size.width+2,sNoLbl.frame.origin.y,80,sNoLbl.frame.size.height);
            
            //availQtyLbl.frame = CGRectMake(priceLabel.frame.origin.x + priceLabel.frame.size.width + 2 , sNoLbl.frame.origin.y, 80,sNoLbl.frame.size.height);
            
            stockQtyLbl.frame = CGRectMake(priceLabel.frame.origin.x+priceLabel.frame.size.width+2,sNoLbl.frame.origin.y,100,sNoLbl.frame.size.height);
            
            issueQtyLbl.frame = CGRectMake(stockQtyLbl.frame.origin.x+stockQtyLbl.frame.size.width+2,sNoLbl.frame.origin.y,100,sNoLbl.frame.size.height);
            
            balanceQtyLbl.frame = CGRectMake(issueQtyLbl.frame.origin.x+issueQtyLbl.frame.size.width+2 , sNoLbl.frame.origin.y,100,sNoLbl.frame.size.height);
            
            scanCodeLabel.frame = CGRectMake(balanceQtyLbl.frame.origin.x + balanceQtyLbl.frame.size.width + 2 ,sNoLbl.frame.origin.y,100,sNoLbl.frame.size.height);

            make_Lbl.frame = CGRectMake(scanCodeLabel.frame.origin.x + scanCodeLabel.frame.size.width + 2 , sNoLbl.frame.origin.y,70, sNoLbl.frame.size.height);
            
            actionLbl.frame = CGRectMake(make_Lbl.frame.origin.x + make_Lbl.frame.size.width + 2,sNoLbl.frame.origin.y,60,sNoLbl.frame.size.height);
            
            //upto on 14/04/2017....
            
            //Frame for the MultipleIssues VIew...
            
            multipleIssuesView.frame = CGRectMake(issueDateTxt.frame.origin.x+60,requestRefNoTxt.frame.origin.y+requestRefNoTxt.frame.size.height,shipmentRefTxt.frame.origin.x+shipmentRefTxt.frame.size.width-(issueDateTxt.frame.origin.x+100),320);
            
            locationHeaderNameLbl.frame = CGRectMake(0,0,multipleIssuesView.frame.size.width,45);
            
            locationCloseBtn.frame = CGRectMake(multipleIssuesView.frame.size.width-40,5,35,35);
            
            locationTable.frame = CGRectMake(0,locationHeaderNameLbl.frame.origin.y+locationHeaderNameLbl.frame.size.height,multipleIssuesView.frame.size.width,220);
            
            selectMultipleStoresBtn.frame = CGRectMake(180,locationTable.frame.origin.y+locationTable.frame.size.height+5,80,40);

            stockIssueScrollView.frame = CGRectMake(searchItemsTxt.frame.origin.x,searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height+5,searchItemsTxt.frame.size.width + 90,350);
            
            requestedItemsTbl.frame = CGRectMake( createReceiptView.frame.origin.x, sNoLbl.frame.origin.y + sNoLbl.frame.size.height, actionLbl.frame.origin.x + actionLbl.frame.size.width + 50,stockIssueScrollView.frame.size.height - (sNoLbl.frame.origin.y +  sNoLbl.frame.size.height));
            
            // frame for the stockVerificationScrollView content size...
            stockIssueScrollView.contentSize = CGSizeMake(requestedItemsTbl.frame.size.width - 40,stockIssueScrollView.frame.size.height);
            
            //Submit Button frame
            editBtn.frame = CGRectMake(searchItemsTxt.frame.origin.x,createReceiptView.frame.size.height-45, 140, 40);
            
            //  Cancel Button frame
            cancelBtn.frame = CGRectMake(editBtn.frame.origin.x +editBtn.frame.size.width + 20,editBtn.frame.origin.y, 140, editBtn.frame.size.height);

            //Frame For the Quantity Value Labels...
            priceValueLbl.frame = CGRectMake(priceLabel.frame.origin.x + 10,cancelBtn.frame.origin.y,priceLabel.frame.size.width,cancelBtn.frame.size.height);
            
            stockQtyValueLbl.frame = CGRectMake(stockQtyLbl.frame.origin.x+10,cancelBtn.frame.origin.y,stockQtyLbl.frame.size.width,cancelBtn.frame.size.height);
            
            issueQtyValueLbl.frame = CGRectMake(issueQtyLbl.frame.origin.x+10,cancelBtn.frame.origin.y,issueQtyLbl.frame.size.width,cancelBtn.frame.size.height);
            
            balanceQtyValueLbl.frame = CGRectMake(balanceQtyLbl.frame.origin.x+10,cancelBtn.frame.origin.y,balanceQtyLbl.frame.size.width,cancelBtn.frame.size.height);
            
            //frame for the Transparent view:
            
            transparentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            
            priceView.frame = CGRectMake(200,300,550,400);
            
            descLabl.frame = CGRectMake(10,10, 225, 35);
            mrpLbl.frame = CGRectMake(descLabl.frame.origin.x+descLabl.frame.size.width+2,descLabl.frame.origin.y, 150, 35);
            priceLbl.frame = CGRectMake(mrpLbl.frame.origin.x+mrpLbl.frame.size.width+2, descLabl.frame.origin.y, 150, 35);
            
            priceTable.frame = CGRectMake(descLabl.frame.origin.x,descLabl.frame.origin.y+descLabl.frame.size.height+10, priceLbl.frame.origin.x+priceLbl.frame.size.width - (descLabl.frame.origin.x), priceView.frame.size.height - (descLabl.frame.origin.y + descLabl.frame.size.height +48));
            closeBtn.frame = CGRectMake(priceView.frame.size.width+165, priceView.frame.origin.y-38,40,40);
            
            //here we are setting font to all subview to mainView.....
            @try {
                [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:16.0f cornerRadius:3.0f];
                
                headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
                locationHeaderNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];

                editBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
                cancelBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
                
            } @catch (NSException *exception) {
                NSLog(@"---- exception while setting the fontSize to subViews ----%@",exception);
            }
        }
    }
    else {
        
    }
    @try {
        for (id view in  createReceiptView.subviews) {
            [view setUserInteractionEnabled:NO];
        }
        editBtn.userInteractionEnabled =YES;
        cancelBtn.userInteractionEnabled = YES;
        stockIssueScrollView.userInteractionEnabled = YES;

    }
    @catch (NSException *exception) {
    }
    @finally {
        
    }
    selectIssueDate.tag = 1;
    selectDlvryDte.tag = 2;
    selectRequestDte.tag = 3;
}


/**
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date         04/11/2016
 * @method       ViewDidLoad
 * @author       Bhargav
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)viewDidAppear:(BOOL)animated{
    
    //calling super call.....
    [super viewDidAppear:YES];
    
    [self callingIssueIdDetails];
    
    
    if(requestedItemsInfoArr == nil){
        requestedItemsInfoArr = [NSMutableArray new];
    }
}

#pragma -mark start ServiceCall.......

/**
 * @description  here we are calling getStokckIssue for outlet........
 * @date         04/11/2016
 * @method       ViewDidLoad
 * @author       Bhargav
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callingIssueIdDetails {
    
    @try {
        
        NSMutableDictionary * receiptDetails1 = [[NSMutableDictionary alloc] init];
        receiptDetails1[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        receiptDetails1[kGoodsIssueRef] = IssueId;
        receiptDetails1[ISSUE_AND_CLOSE] = [NSNumber numberWithBool:false];
        receiptDetails1[EXISTS_IN_CAPILLARY] = [NSNumber numberWithBool:false];
        receiptDetails1[kNotForDownload] = [NSNumber numberWithBool:false];
        receiptDetails1[VALID_MASTER_CODE] = [NSNumber numberWithBool:false];
        receiptDetails1[OUTLET_ALL] = [NSNumber numberWithBool:false];
        receiptDetails1[WAREHOUSE_ALL] = [NSNumber numberWithBool:false];
        receiptDetails1[kVerificationUnderMasterCode] = [NSNumber numberWithBool:false];
        receiptDetails1[ALL_LOCATIONS] = [NSNumber numberWithBool:false];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:receiptDetails1 options:0 error:&err];
        NSString * getStockIssueJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.stockIssueDelegate = self;
        [webServiceController getStockIssueId:getStockIssueJsonString];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
}
/**
 * @description  Used To get the Locations...
 * @date         1/08/2017
 * @method       getLocations
 * @author       Bhargav
 * @param        int
 * @param        NSString
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getLocations:(int)selectIndex businessActivity:(NSString *)businessActivity{
    
    @try {
        [HUD show:YES];
        [HUD setHidden: NO];
        
        if(locationArr == nil){
            locationArr  = [NSMutableArray new];
        }
        else if( locationArr.count ){
            
            [locationArr removeAllObjects];
        }
        locationCheckBoxArr = [NSMutableArray new];
        
        NSArray * loyaltyKeys = @[START_INDEX,REQUEST_HEADER,BUSSINESS_ACTIVITY];
        
        NSArray * loyaltyObjects = @[NEGATIVE_ONE,[RequestHeader getRequestHeader],@""];
        
        NSDictionary * dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.utilityMasterDelegate = self;
        [webServiceController getAllLocationDetailsData:loyaltyString];
        
    } @catch (NSException *exception) {
        [HUD setHidden:YES];
        
    } @finally {
        
    }
}

/**
 * @description   we are storing the data from the database in a locationArr
 * @date         1/08/2017
 * @method       getLocationSuccessResponse
 * @author       Bhargav.v
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getLocationSuccessResponse:(NSDictionary *)successDictionary {
    @try {
        
        for(NSDictionary *dic in [successDictionary valueForKey:LOCATIONS_DETAILS]){
            if (![[dic valueForKey:LOCATION_ID] isKindOfClass:[NSNull class]] && [[dic valueForKey:LOCATION_ID] caseInsensitiveCompare:presentLocation] != NSOrderedSame) {
                [locationArr addObject:[dic valueForKey:LOCATION_ID]];
                //[locationCheckBoxArr addObject:@"0"];
            }
            if ([locationArr containsObject:presentLocation]) {
                [locationArr removeObject:presentLocation];
            }
        }
        
        //if ([locationArr count]) {
        //[multipleIssuesView setHidden:NO];
        //}
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        [HUD setHidden:YES];
        [locationTable reloadData];
    }
}

/**
 * @description  we are Displaying the error response from DataBase...
 * @date         1/08/2017
 * @method       getLocationErrorResponse
 * @author       Bhargav
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getLocationErrorResponse:(NSString *)errorResponse{
    
    @try {
        
    } @catch (NSException *exception) {
        
    } @finally {
        [catPopOver dismissPopoverAnimated:YES];
        [HUD setHidden:YES];
    }
}

/**
 * @description  description
 * @date         date
 * @method       name
 * @author       Bhargav.v
 * @param        param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */
- (void)getStockIssueIdSuccessResponse:(NSDictionary *)sucessDictionary {
    
    @try {
        
        updateStockIssueDic    = [NSMutableDictionary new];
        nextActivitiesArr      = [NSMutableArray new];
        updateStockIssueDic    = [[sucessDictionary valueForKey:kIssueDetails ] mutableCopy];
        NSDictionary * details = [sucessDictionary valueForKey:kIssueDetails];
        
        // here we are showing  the next Activities:
        
        if([[updateStockIssueDic valueForKey:NEXT_ACTIVITIES] count] || [[updateStockIssueDic valueForKey:kNextWorkFlowStates] count]){
            
            for(NSString * str in [updateStockIssueDic valueForKey:NEXT_ACTIVITIES])
                [nextActivitiesArr addObject:str];
            
            for(NSString * str in [updateStockIssueDic valueForKey:kNextWorkFlowStates])
                [nextActivitiesArr addObject:str];
        }
        //upto here.....
        
        if(nextActivitiesArr.count == 0){
            [nextActivitiesArr addObject:NSLocalizedString(@"no_more_activities", nil)];
            
            editBtn.hidden = YES;
            
            //cancelBtn Button frame
            cancelBtn.frame = CGRectMake(searchItemsTxt.frame.origin.x,createReceiptView.frame.size.height-45, 140, 40);
        }
        
        if ([[updateStockIssueDic valueForKey:STATUS ] isEqualToString:@"Closed"] ) {
            
            editBtn.hidden = YES;
            
            cancelBtn.frame = CGRectMake(descriptionLbl.frame.origin.x, cancelBtn.frame.origin.y, cancelBtn.frame.size.width, cancelBtn.frame.size.height);
        }
        
        if ([details.allKeys containsObject:kIssuedTo] && ![[details valueForKey:kIssuedTo] isKindOfClass:[NSNull class]]) {
            toStoreCodeTxt.text = [details valueForKey:kIssuedTo];
        }
        if ([details.allKeys containsObject:kIssuedBy] && ![[details valueForKey:kIssuedBy] isKindOfClass:[NSNull class]]) {
            
            issuedByTxt.text = [details valueForKey:kIssuedBy];
        }
        
        if ([details.allKeys containsObject:DELIVERED_BY] && ![[details valueForKey:DELIVERED_BY] isKindOfClass:[NSNull class]]) {
            
            carriedByTxt.text = [details valueForKey:DELIVERED_BY];
        }
        
        if ([details.allKeys containsObject:DELIVERY_DATE] && ![[details valueForKey:DELIVERY_DATE] isKindOfClass:[NSNull class]]) {
            
            deliveryDteTxt.text = [details valueForKey:DELIVERY_DATE];
        }
        
        if ([details.allKeys containsObject:CREATED_DATE_STR] && ![[details valueForKey:CREATED_DATE_STR] isKindOfClass:[NSNull class]]) {
            
            issueDateTxt.text = [details valueForKey:CREATED_DATE_STR];
        }
        
        
        if ([details.allKeys containsObject:CREATED_DATE_STR] && ![[details valueForKey:CREATED_DATE_STR] isKindOfClass:[NSNull class]]) {
            
            requestDateTxt.text = [details valueForKey:CREATED_DATE_STR];
        }
        
        if ([details.allKeys containsObject:kShipmentMode] && ![[details valueForKey:kShipmentMode] isKindOfClass:[NSNull class]]) {
            
            shipmentModeTxt.text = [details valueForKey:kShipmentMode];
        }
        
        if ([details.allKeys containsObject:kShipmentRef] && ![[details valueForKey:kShipmentRef] isKindOfClass:[NSNull class]]) {
            
            shipmentRefTxt.text = [details valueForKey:kShipmentRef];
        }
        
        // added by roja on 13-07-2018....
        if ([details.allKeys containsObject:kgoodsReqRef] && ![[details valueForKey:kgoodsReqRef] isKindOfClass:[NSNull class]]) {
            
            requestRefNoTxt.text = [details valueForKey:kgoodsReqRef];
        }
        
        //Handling the response under Item Details.....
        for (NSDictionary * itemDetails in [sucessDictionary valueForKey:kItemDetails]) {
            
            NSMutableDictionary * dic = [itemDetails mutableCopy];
            
            [dic removeObjectForKey:Issue_id];
            
            [dic setValue:[self checkGivenValueIsNullOrNil:[itemDetails  valueForKey:QUANTITY] defaultReturn:@"0.0"] forKey:QUANTITY];
            
            [dic setValue:[self checkGivenValueIsNullOrNil:[itemDetails  valueForKey:kMaxQuantity] defaultReturn:@"0.0"] forKey:kMaxQuantity];
            
            //setting availiable qty....
            [dic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemDetails  valueForKey:AVAILABLE_QTY] defaultReturn:@"0.00"] floatValue]] forKey:AVAILABLE_QTY];
            
            [dic setValue:[self checkGivenValueIsNullOrNil:[itemDetails  valueForKey:ITEM_SKU] defaultReturn:@" "] forKey:ITEM_SKU];
            
            //aded by Srinivasulu on 13/04/2017...
            [dic setValue:[self checkGivenValueIsNullOrNil:[itemDetails  valueForKey:kItem] defaultReturn:@" "] forKey:kItem];
            
            //newly added keys....
            [dic setValue:[self checkGivenValueIsNullOrNil:[itemDetails valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
            
            [dic setValue:[self checkGivenValueIsNullOrNil:[itemDetails valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
            
            [dic setValue:[self checkGivenValueIsNullOrNil:[itemDetails valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
            
            [dic setValue:[self checkGivenValueIsNullOrNil:[itemDetails valueForKey:MEASUREMENT_RANGE] defaultReturn:@""] forKey:MEASUREMENT_RANGE];
            
            [dic setValue:[self checkGivenValueIsNullOrNil:[itemDetails valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];
            
            [dic setValue:[self checkGivenValueIsNullOrNil:[itemDetails valueForKey:kBrand] defaultReturn:@""] forKey:kBrand];
            
            [dic setValue:[self checkGivenValueIsNullOrNil:[itemDetails valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
            
            [dic setValue:[self checkGivenValueIsNullOrNil:[itemDetails valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
            
            [dic setValue:[self checkGivenValueIsNullOrNil:[itemDetails valueForKey:MAKE] defaultReturn:@""] forKey:MAKE];
            
            [dic setValue:[self checkGivenValueIsNullOrNil:[itemDetails valueForKey:TRACKING_REQUIRED] defaultReturn:ZERO_CONSTANT] forKey:TRACKING_REQUIRED];
            
            [dic setValue:EMPTY_STRING forKey:ITEM_SCAN_CODE];

            
          
            
            [requestedItemsInfoArr addObject:itemDetails];
            
            [requestedItemsTbl reloadData];
        }
      
        UIImage *workArrowImg = [UIImage imageNamed:@"workflow_arrow.png"];
        
        UIImageView *workFlowImageView = [[UIImageView alloc] init];
        
        workFlowImageView.image = workArrowImg;
        
        [workFlowView addSubview:workFlowImageView];
        
        NSArray * workFlowArr;
        
        workFlowArr = [updateStockIssueDic valueForKey:PREVIOUS_STATES];
        
        workFlowImageView.frame = CGRectMake(workFlowView.frame.origin.x,5,workFlowView.frame.size.height + 30 , workFlowView.frame.size.height - 10);
        
        float label_x_origin = workFlowImageView.frame.origin.x + workFlowImageView.frame.size.width;
        float label_y_origin = workFlowImageView.frame.origin.y;
        
        float labelWidth =  (workFlowView.frame.size.width - workFlowImageView.frame.size.width)/ ((workFlowArr.count * 2 )-1)   ;
        float labelHeight = workFlowImageView.frame.size.height;
        
        if( workFlowArr.count <= 3 )
            //taking max as 5 labels.....
            labelWidth =  (workFlowView.frame.size.width - workFlowImageView.frame.size.width - 380)/4;
        
        for(NSString * str  in workFlowArr){
            
            UILabel * workFlowNameLbl;
            UILabel * workFlowLineLbl;
            
            workFlowNameLbl = [[UILabel alloc] init];
            workFlowNameLbl.layer.masksToBounds = YES;
            workFlowNameLbl.numberOfLines = 2;
            workFlowNameLbl.textAlignment = NSTextAlignmentCenter;
            workFlowNameLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
          
            //workFlowNameLbl.text = @"Closed-----Cancelled";
            workFlowNameLbl.text = str;
            
            [workFlowView addSubview:workFlowNameLbl];
            
            workFlowNameLbl.frame = CGRectMake(label_x_origin,label_y_origin,labelWidth,labelHeight);
            
            label_x_origin = workFlowNameLbl.frame.origin.x + workFlowNameLbl.frame.size.width;
            
            if(![str isEqualToString:workFlowArr.lastObject]){
                workFlowLineLbl = [[UILabel alloc] init];
                workFlowLineLbl.backgroundColor = [UIColor lightGrayColor];
                
                [workFlowView addSubview:workFlowLineLbl];
                
                workFlowLineLbl.frame = CGRectMake(label_x_origin,(labelHeight + 8)/2,labelWidth, 2);
                label_x_origin = workFlowLineLbl.frame.origin.x + workFlowLineLbl.frame.size.width;
            }
            
            NSLog(@"---------%@",str);
            
        }
        
        [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:workFlowView andSubViews:YES fontSize:16.0f cornerRadius:0.0];
    
    }
    @catch (NSException *exception) {
        
        
        NSLog(@"--%@",exception);
    }
    
    @finally {
     
        [HUD setHidden:YES];
        
    }
}


/**
 * @description  handling the success response........
 * @date         04/11/2016
 * @method       getStockIssueIdSuccessResponse:
 * @author       Bhargav
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void) getStockIssueIdErrorResponse:(NSString *)error{
    
    @try {
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 350;
        
        if(searchItemsTxt.isEditing)
            y_axis = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height;
        
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",error];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        [HUD setHidden:YES];
    }
    
}



/**
 * @description  here we are calling getStokckIssue for outlet........
 * @date         04/11/2016
 * @method       ViewDidLoad
 * @author       Bhargav
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callRawMaterialDetails:(NSString *)pluCodeStr {
    
    @try {
        [HUD show:YES];
        [HUD setHidden: NO];
        
        NSMutableDictionary * productDetailsDic = [[NSMutableDictionary alloc] init];
        
        productDetailsDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        productDetailsDic[kStoreLocation] = presentLocation;
        productDetailsDic[ITEM_SKU] = pluCodeStr;
        productDetailsDic[START_INDEX] = NEGATIVE_ONE;
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:productDetailsDic options:0 error:&err];
        NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.getSkuDetailsDelegate = self;
        [webServiceController getSkuDetailsWithData:salesReportJsonString];
        
    }
    @catch (NSException *exception) {
        
        [HUD setHidden: YES];
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
}


/**
 * @description  handling the success response........
 * @date         04/11/2016
 * @method       getSkuDetailsMethod:
 * @author       Bhargav
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)getSkuDetailsSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        if (successDictionary != nil) {
            
            priceDic = [[NSMutableArray alloc]init];
            
            NSArray * price_arr = [successDictionary valueForKey:kSkuLists];
            
            for (int i= 0; i< price_arr.count; i++) {
                
                NSDictionary * json = price_arr[i];
                [priceDic addObject:json];
            }
            
            if (((NSArray *)[successDictionary valueForKey:kSkuLists]).count>1) {
                
                if (priceDic.count>0) {
                    [HUD setHidden:YES];
                    transparentView.hidden = NO;
                    [priceTable reloadData];
                    SystemSoundID    soundFileObject1;
                    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"popup_tune" withExtension: @"mp3"];
                    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
                    
                    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                    
                    AudioServicesPlaySystemSound (soundFileObject1);
                }
            }
            
            else {
                
                BOOL status = FALSE;
                
                int i=0;
                NSMutableDictionary * dic;
                
                for ( i=0; i<requestedItemsInfoArr.count; i++) {
                    NSArray *itemArray = [successDictionary valueForKey:kSkuLists];
                    if (itemArray.count > 0) {
                        NSDictionary * itemdic = itemArray[0];
                        dic = requestedItemsInfoArr[i];
                        if ([[dic valueForKey:ITEM_SKU] isEqualToString:[itemdic valueForKey:ITEM_SKU]] && [[dic valueForKey:PLU_CODE] isEqualToString:[itemdic valueForKey:PLU_CODE]]) {
                            
                            [dic setValue:[NSString stringWithFormat:@"%.2f",[[dic valueForKey:QUANTITY] floatValue] + 1] forKey:QUANTITY];
                            
                            requestedItemsInfoArr[i] = dic;
                            status = TRUE;
                            break;
                        }
                    }
                }
                
                if (!status) {
                    
                    NSArray * itemArray = [successDictionary valueForKey:kSkuLists];
                    if (itemArray.count > 0) {
                        NSDictionary * itemdic = itemArray[0];
                        
                        NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc] init];
                        
                        //setting skuId....
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_SKU];
                        
                        [itemDetailsDic setValue:[itemDetailsDic valueForKey:ITEM_SKU] forKey:kItem];
                        
                        //setting plucode....
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:PLU_CODE] defaultReturn:[itemDetailsDic valueForKey:ITEM_SKU]] forKey:PLU_CODE];
                        
                        //setting itemDescription....
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESCRIPTION];
                        
                        
                        //setting itemPrice as salePrice...
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic valueForKey:cost_Price] defaultReturn:@"0.00"] floatValue]] forKey:ITEM_UNIT_PRICE];
                        
                        //setting availiable qty....
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:QUANTITY];
                        
                        //setting kMaxQuantity for the stock quantity....
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:kMaxQuantity] defaultReturn:@"0.00"] floatValue]] forKey:kMaxQuantity];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:AVAILABLE_QTY] defaultReturn:@"0.00"] floatValue]] forKey:BALANCE_QTY];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:AVAILABLE_QTY];
                        
                        //setting quantity as  BALANCE_QTY to 0..
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:BALANCE_QTY];
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:COST];
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:ISSUED];
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:QUANTITY];
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:INDENT_QTY];
                        
                        
                        //extra keys....
                        
                        //setting kReceived for the rejectedQty key....
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:kReceived] defaultReturn:@"0.00"] floatValue]] forKey:kReceived];
                        
                        //setting kRejected for the rejectedQty key...
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:kRejected] defaultReturn:@"0.00"] floatValue]] forKey:kRejected];
                        
                        //setting kRejected for the rejectedQty key...
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:kSupplied] defaultReturn:@"0.00"] floatValue]] forKey:kSupplied];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:MAKE] defaultReturn:@""] forKey:MAKE];

                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kMeasureRange] defaultReturn:@""] forKey:MEASUREMENT_RANGE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kProductBrand] defaultReturn:@""] forKey:kBrand];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:EAN] defaultReturn:@""] forKey:EAN];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:UTILITY] defaultReturn:@""] forKey:UTILITY];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:TRACKING_REQUIRED] defaultReturn:ZERO_CONSTANT] forKey:TRACKING_REQUIRED];
                        
                        [itemDetailsDic setValue:EMPTY_STRING forKey:ITEM_SCAN_CODE];

                        //Checking isPacked item based on the Boolean value
                        
                        float qty = 0;
                        
                        if (qty == 0) {
                            
                            BOOL isPackedItem = false;
                            
                            int minimumQty = 0;
                            
                            if ([itemdic.allKeys containsObject:kPackagedType] && ![itemdic[kPackagedType] isKindOfClass:[NSNull class]]) {
                                
                                if([itemdic[kPackagedType] boolValue]){
                                    minimumQty = 1;
                                    isPackedItem = true;
                                }
                            }
                        }
                        
                        if ([itemdic.allKeys containsObject:kPackagedType] && ![itemdic[kPackagedType] isKindOfClass:[NSNull class]]) {
                            
                            [isPacked addObject:@([itemdic[kPackagedType] boolValue])];
                        }
                        else {
                            
                            [isPacked addObject:[NSNumber numberWithBool:FALSE]];
                        }
                        
                        [requestedItemsInfoArr addObject:itemDetailsDic];
                    }
                }
                else
                    requestedItemsInfoArr[i] = dic;
            }
            
            [self calculateTotal];
        }
    }
    @catch (NSException * exception) {
        NSLog(@"-------Exception While Reading.-------%@",exception);
    }
    @finally{
        [HUD setHidden:YES];
        
        [requestedItemsTbl reloadData];
    }
}

/**
 * @description  in this method we will call the services....
 * @method       getSkuDetailsSuccessResponse
 * @author
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 13/04/2017...
 * @reason      added comments && added new field in items level....
 *
 */

- (void)getSkuDetailsErrorResponse:(NSString*)failureString{
    @try {
        
        
        //added by Srinivasulu on 13/04/2017....
        //
        
        [HUD setHidden:YES];
        
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"No Records Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //        [alert show];
        
        float y_axis = self.view.frame.size.height - 350;
        
        if(searchItemsTxt.isEditing)
            y_axis = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height;
        
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",failureString];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        
    }
    
}

/**
 * @description  handling the success response........
 * @date         04/11/2016
 * @method       getSkuDetailsErrorResponse:
 * @author       Bhargav
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


- (void)getSkuDetailsErrorResponse {
    [HUD setHidden:YES];
    UIAlertView * alert=  [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"sorry", nil) message:NSLocalizedString(@"product_not_available", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
    [alert show];
}








/**
 * @description  here we are calling getStokckIssue for outlet........
 * @date         04/11/2016
 * @method       ViewDidLoad
 * @author       Bhargav
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void) callRawMaterials:(NSString *)searchString {
    
    @try {
        [HUD show:YES];
        [HUD setHidden:NO];
        
        NSMutableDictionary * searchProductDic = [[NSMutableDictionary alloc] init];
        
        searchProductDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        searchProductDic[START_INDEX] = ZERO_CONSTANT;
        searchProductDic[kSearchCriteria] = searchItemsTxt.text;
        searchProductDic[kStoreLocation] = presentLocation;
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:searchProductDic options:0 error:&err];
        NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.searchProductDelegate = self;
        [webServiceController searchProductsWithData:salesReportJsonString];
        
    }
    @catch (NSException *exception) {
        
        [HUD setHidden: YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
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

- (void)searchProductsSuccessResponse:(NSDictionary *)successDictionary {
    
    
    @try {
        
        //checking searchItemsFieldTag.......
        if (successDictionary != nil && (searchItemsTxt.tag == (searchItemsTxt.text).length) ) {
            
            
            //checking searchItemsFieldTag.......
            if (![successDictionary[PRODUCTS_LIST] isKindOfClass:[NSNull class]]  && [successDictionary.allKeys containsObject:PRODUCTS_LIST]) {
                
                for(NSDictionary *dic in [successDictionary valueForKey:PRODUCTS_LIST]){
                    
                    [productList addObject:dic];
                }
            }
            
            if(productList.count){
                float tableHeight = productList.count * 40;
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                    tableHeight = productList.count * 33;
                
                if(productList.count > 5)
                    tableHeight = (tableHeight/productList.count) * 5;
                
                [self showPopUpForTables:productListTbl  popUpWidth:searchItemsTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:searchItemsTxt  showViewIn:createReceiptView permittedArrowDirections:UIPopoverArrowDirectionUp];
            }
            else if(catPopOver.popoverVisible)
                [catPopOver dismissPopoverAnimated:YES];
            searchItemsTxt.tag = 0;
            [HUD setHidden:YES];
        }
        
        else if ( (((searchItemsTxt.text).length >= 3) && (searchItemsTxt.tag != 0)) && (searchItemsTxt.tag != (searchItemsTxt.text).length)) {
            
            searchItemsTxt.tag = 0;
            
            [self textFieldDidChange:searchItemsTxt];
            
        }
        else  if(catPopOver.popoverVisible || (searchItemsTxt.tag == (searchItemsTxt.text).length)){
            [catPopOver dismissPopoverAnimated:YES];
            searchItemsTxt.tag = 0;
            [HUD setHidden:YES];
            
        }
        else {
            
            [catPopOver dismissPopoverAnimated:YES];
            searchItemsTxt.tag = 0;
            [HUD setHidden:YES];
        }
    }
    
    @catch (NSException *exception) {
        
        if(catPopOver.popoverVisible)
            [catPopOver dismissPopoverAnimated:YES];
        searchItemsTxt.tag = 0;
        [HUD setHidden:YES];
        
    }
    @finally {
        
        
    }
}
/**
 * @description  handling the success response........
 * @date         04/11/2016
 * @method       getStockIssueIdSuccessResponse:
 * @author       Bhargav
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)searchProductsErrorResponse {
    
    @try {
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"message", nil)  message:NSLocalizedString(@"no_products_found", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles:nil, nil];
        [alert show];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [HUD setHidden:YES];
        
    }
    
}


#pragma -mark showing next Activities..

- (void)showNextAcivities:(UIButton *)sender{
    
    
    AudioServicesPlaySystemSound(soundFileObject);
    @try {
        int count = 5;
        
        if (nextActivitiesArr.count < count) {
            count = (int)nextActivitiesArr.count;
        }
        
        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, ActionReqTxt.frame.size.width, count * 40)];
        customView.opaque = NO;
        customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customView.layer.borderWidth = 2.0f;
        [customView setHidden:NO];
        
        nextActivityTbl = [[UITableView alloc] init];
        nextActivityTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
        nextActivityTbl.dataSource = self;
        nextActivityTbl.delegate = self;
        (nextActivityTbl.layer).borderWidth = 1.0f;
        nextActivityTbl.layer.cornerRadius = 3;
        nextActivityTbl.layer.borderColor = [UIColor grayColor].CGColor;
        nextActivityTbl.separatorColor = [UIColor grayColor];
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            nextActivityTbl.frame = CGRectMake(0, 0, customView.frame.size.width, customView.frame.size.height);
            
        }
        
        [customView addSubview:nextActivityTbl];
        
        customerInfoPopUp.view = customView;
        
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            [popover presentPopoverFromRect:ActionReqTxt.frame inView:createReceiptView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
            catPopOver= popover;
        }
        
        else {
            
            customerInfoPopUp.preferredContentSize = CGSizeMake(160.0, 250.0);
            
            UIPopoverController * popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
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
        
        [nextActivityTbl reloadData];
    }
    @catch (NSException *exception) {
    }
    @finally {
        
    }
}

/**
 * @description  we are closing the multipleIssuesView view
 * @date         15/07/2017
 * @method       closeMultipleIssuesview
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */
-(void)closeMultipleIssuesview:(UIButton*)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        multipleIssuesView.hidden = YES;
        
    } @catch (NSException * exception) {
    }
}

/**
 * @description  we are removing the item from cart view....
 * @date         15/07/2017
 * @method       delRow
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */
- (void)delRow:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    @try {
        
        if(requestedItemsInfoArr.count >= sender.tag){
            [requestedItemsInfoArr removeObjectAtIndex:sender.tag];
            [requestedItemsTbl reloadData];
        }
        
    } @catch (NSException *exception) {
        NSLog(@"%li",(long)sender.tag);
    } @finally {
    }
}


#pragma -mark submitButton   action.......

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
-(void)submitButtonPressed:(UIButton *)sender {
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        if([sender.titleLabel.text isEqualToString:NSLocalizedString(@"edit", nil)] ){

            @try {
                
                for (id view in createReceiptView.subviews) {
                    [view setUserInteractionEnabled:YES];
                }
            }
            @catch (NSException * exception) {
                
            }
            
            [editBtn setTitle:NSLocalizedString(@"submit",nil) forState:UIControlStateNormal];
        }
        else {
            
            //changed By srinivauslu on 02/05/2018....
            //reason.. Need to stop user internation after servcie calls...
            
            editBtn.userInteractionEnabled = NO;
            
            //upto here on 02/05/2018....
            [HUD setHidden:NO];
            
            NSString * updateStatuStr = [updateStockIssueDic  valueForKey:STATUS];
            NSString * shipModeStr  = [updateStockIssueDic valueForKey:kShipmentMode];
            
            if(!([ActionReqTxt.text isEqualToString:NSLocalizedString(@"action_required", nil)]  ||[ActionReqTxt.text isEqualToString:@""])) {
                
                updateStatuStr = ActionReqTxt.text;
            }
            NSMutableArray * locArr = [NSMutableArray new];
            
            float issueTotal = 0;
            
            for (NSDictionary * dic in requestedItemsInfoArr) {
                
                NSMutableDictionary * itemDetailsDic = [dic mutableCopy];
                
                issueTotal +=([[dic valueForKey:QUANTITY] integerValue]*[[dic valueForKey:ITEM_UNIT_PRICE] floatValue]);
                
                // changed by roja on 13-07-2018....
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f" ,([[itemDetailsDic valueForKey:AVAILABLE_QTY] floatValue]-[[dic valueForKey:QUANTITY] floatValue])] forKey:BALANCE_QTY];
                
                // added by roja on 26-07-2018...
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",([[dic valueForKey:QUANTITY] floatValue]*[[dic valueForKey:ITEM_UNIT_PRICE] floatValue]) ] forKey:COST];

                [locArr addObject:itemDetailsDic];
            }
            
            updateStockIssueDic[RECEIPT_DETAILS] = locArr;
            updateStockIssueDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
            [updateStockIssueDic setValue:@(issueTotal) forKey:ISSUE_TOTAL];
            [updateStockIssueDic setValue:@(issueTotal) forKey:GRAND_TOTAL];
            [updateStockIssueDic setValue:@(issueTotal) forKey:kSubTotal];
            [updateStockIssueDic setValue:@((issueQtyValueLbl.text).floatValue) forKey:ISSUE_TOTAL_QTY];

            updateStockIssueDic[STATUS] = updateStatuStr;
            
            if(!([shipmentModeTxt.text isEqualToString:@""])) {
                
                shipModeStr  = shipmentModeTxt.text;
            }
            
            updateStockIssueDic[kShipmentMode] = shipModeStr;
            
            // added by roja on 13-07-2018....
            int  totalItems = (int)requestedItemsInfoArr.count;
            [updateStockIssueDic setValue:@(totalItems) forKey:NO_OF_ITEMS];
            
           
            NSError * err;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:updateStockIssueDic options:0 error:&err];
            NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            NSLog(@"------------%@",salesReportJsonString);
            
            WebServiceController * webServiceController = [WebServiceController new];
            webServiceController.stockIssueDelegate = self;
            [webServiceController upDateStockIssue:jsonData];
            
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@" ecxeption in service call %@",exception);
        //changed By srinivauslu on 02/05/2018....
        //reason.. Need to stop user internation after servcie calls...
        
        editBtn.userInteractionEnabled = YES;
        
        //upto here on 02/05/2018....
    }
    @finally {
        
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
-(void)updateStockIssueSuccessResponse:(NSDictionary *)sucessDictionary {
    @try {
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItemsTxt.isEditing)
            y_axis = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height;
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"stock_issue_updated_successfully",nil),@"\n", [sucessDictionary valueForKey:ISSUE_ID]];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"SUCCESS", nil)  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        [HUD setHidden:YES];
    }

}


-(void) updateStockIssueErrorResponse:(NSString *) error {
    
    @try {
        [HUD setHidden:YES];
        
        //changed By srinivauslu on 02/05/2018....
        //reason.. Need to stop user internation after servcie calls...
        
        editBtn.userInteractionEnabled = YES;
        
        //upto here on 02/05/2018....
        float y_axis = self.view.frame.size.height - 350;
        
        if(searchItemsTxt.isEditing)
            y_axis = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height;
        
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",error];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

-(void)cancelButtonPressed:(UIButton*)sender {
    @try {
            AudioServicesPlaySystemSound(soundFileObject);
        
        [self backAction];
 
    }
    @catch (NSException *exception) {
        
        
    }
    @finally {
        
        
    }
    
}

-(void)getShipmentModes {
    
    @try {
        {
            
            AudioServicesPlaySystemSound(soundFileObject);
            
            shipModesArr = [NSMutableArray new];
            [shipModesArr addObject:NSLocalizedString(@"rail", nil)];
            [shipModesArr addObject:NSLocalizedString(@"flight", nil)];
            [shipModesArr addObject:NSLocalizedString(@"express", nil)];
            [shipModesArr addObject:NSLocalizedString(@"ordinary", nil)];
            [shipModesArr addObject:NSLocalizedString(@"direct_person", nil)];
            
            
            int count  = 5 ;
            
            if (shipModesArr.count < count) {
                count = (int)shipModesArr.count;
            }
            
            PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
            
            UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, shipmentModeTxt.frame.size.width,count * 40)];
            customView.opaque = NO;
            customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
            customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            customView.layer.borderWidth = 2.0f;
            [customView setHidden:NO];
            
            shipModeTable = [[UITableView alloc] init];
            shipModeTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
            shipModeTable.dataSource = self;
            shipModeTable.delegate = self;
            (shipModeTable.layer).borderWidth = 1.0f;
            shipModeTable.layer.cornerRadius = 3;
            shipModeTable.layer.borderColor = [UIColor grayColor].CGColor;
            shipModeTable.separatorColor = [UIColor grayColor];
            
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                shipModeTable.frame = CGRectMake(0, 0, customView.frame.size.width, customView.frame.size.height);
                
            }
            
            
            [customView addSubview:shipModeTable];
            
            customerInfoPopUp.view = customView;
            
            
            if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
                
                UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
                
                [popover presentPopoverFromRect:shipmentModeTxt.frame inView:createReceiptView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
                
                catPopOver= popover;
                
            }
            
            else {
                
                customerInfoPopUp.preferredContentSize = CGSizeMake(160.0, 250.0);
                
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
            
            [shipModeTable reloadData];
            
        }

    }
    @catch (NSException *exception) {
    }
    
    
    @finally {
        
    }
}

#pragma mark textField delegates:


/**
 * @description  it is an textFieldDelegate method it will be executed when text Begin edititng........
 * @date         10/09/2016
 * @method       textFieldDidBeginEditing:
 * @author       Bhargav
 * @param        UITextField
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    
    if ( textField.frame.origin.x  == issueQtyText.frame.origin.x)
        
        reloadTableData = false;
    
    return YES;
}

/**
 * @description  it is an textFieldDelegate method it will be executed when text Begin edititng........
 * @date         10/09/2016
 * @method       textFieldDidBeginEditing:
 * @author       Bhargav
 * @param        UITextField
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    @try {
        
        @try {
            
            if(textField == searchItemsTxt){
                
                offSetViewTo = 120;
                
            }
            
            else if (textField.frame.origin.x  == issueQtyText.frame.origin.x) {
                
                reloadTableData = true;
                
                offSetViewTo = 120;
                
            }
            
            [self keyboardWillShow];
            
        } @catch (NSException *exception) {
            
        }
        
    } @catch (NSException *exception) {
        
    }
}

/**
 * @description  it is an textFieldDelegate method it will be executed when text Begin edititng........
 * @date         10/09/2016
 * @method       textFieldDidChange:
 * @author       Bhargav
 * @param        UITextField
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */

- (void)textFieldDidChange:(UITextField *)textField {
    if (textField == searchItemsTxt){
        
        if ((textField.text).length >= 3) {
            
            @try {
                
                if (searchItemsTxt.tag == 0) {
                    
                    searchItemsTxt.tag = (textField.text).length;
                    
                    productList = [[NSMutableArray alloc]init];
                    
                    [self callRawMaterials:textField.text];
                }
                
                else {
                    
                    [HUD setHidden:YES];
                    [catPopOver dismissPopoverAnimated:YES];
                }
                
            } @catch (NSException *exception) {
                
            }
        }
        
        else {
            [HUD setHidden:YES];
            searchItemsTxt.tag = 0;
            [catPopOver dismissPopoverAnimated:YES];
            
        }
    }
    
    else if (textField.frame.origin.x == issueQtyText.frame.origin.x){
        
        @try {
            NSString * qtyKey = QUANTITY;
            
            NSMutableDictionary * temp = [requestedItemsInfoArr[textField.tag]  mutableCopy];
            [temp setValue:textField.text  forKey:qtyKey];
            
            requestedItemsInfoArr[textField.tag] = temp;
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }
}

/**
 * @description  It is tableFieldDelegates Method. It will executed when user started entering input....
 * @date         29/05/2016
 * @method       textField shouldChangeCharactersInRange:
 * @author       Bhargav
 * @param        UITextField
 * @param
 * @return       BOOL
 * @verified By
 * @verified On
 *
 */

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    if(textField.frame.origin.x == issueQtyText.frame.origin.x) {
        
        @try {
            
            if ([isPacked[textField.tag] boolValue]) {
                
                NSUInteger lengthOfString = string.length;
                
                for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {
                    unichar character = [string characterAtIndex:loopIndex];
                    if (character < 48) return NO; // 48 unichar for 0
                    if (character > 57) return NO; // 57 unichar for 9
                }
            }
            
            else {
                
                NSString * newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
                NSString * expression = @"^[0-9]*((\\.)[0-9]{0,2})?$";
                NSError  * error = nil;
                NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
                NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString options:0 range:NSMakeRange(0, newString.length)];
                return numberOfMatches != 0;
            }
            
        } @catch (NSException *exception) {
            
            NSLog(@"---- exception in texField: shouldChangeCharactersInRange:replalcement----%@",exception);
            
            return  YES;
            
        }
    }
    
    return  YES;
    
}


/**
 * @description  It is tableFieldDelegates Method. It will executed when user started entering input....
 * @date         29/05/2016
 * @method       textFieldDidEndEditing:
 * @author       Bhargav
 * @param        UITextField
 * @param
 * @return       BOOL
 * @verified By
 * @verified On
 *
 */
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [self keyboardWillHide];
    offSetViewTo = 0;
    
     if (textField.frame.origin.x == issueQtyText.frame.origin.x) {
        
        @try {
            NSString * qtyKey = QUANTITY;
            
            NSMutableDictionary *temp = [requestedItemsInfoArr[textField.tag]  mutableCopy];
            [temp setValue:textField.text  forKey:qtyKey];
            
            requestedItemsInfoArr[textField.tag] = temp;
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            if(reloadTableData)
                [requestedItemsTbl reloadData];
        }
    }
}

/**
 * @description  It is tableFieldDelegates Method. It will executed when user started entering input....
 * @date         29/05/2016
 * @method       textFieldShouldReturn:
 * @author       Bhargav
 * @param        UITextField
 * @param
 * @return       BOOL
 * @verified By
 * @verified On
 *
 */

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
   
    [textField resignFirstResponder];
    return YES;
}

#pragma - mark  start  tableView delegate mehods.......

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(tableView == requestedItemsTbl){
        
        @try {
            
            // [self changeAdjustableViewFrame];
            [self calculateTotal];
            
        } @catch (NSException *exception) {
            NSLog( @"-----exception in changing the frame sizes..----%@",exception);
        }
        
        return  requestedItemsInfoArr.count;
    }
    
    else if (tableView == productListTbl){
        return productList.count;
    }
    
    else if(tableView == nextActivityTbl) {
        return  nextActivitiesArr.count;
    }
    
    else if(tableView == shipModeTable) {
        return  shipModesArr.count;
    }
    else if(tableView == priceTable) {
        return  priceDic.count;
    }
    else if (tableView == categoriesTbl ) {
        return categoriesArr.count;
    }
    else if (tableView == locationTable){
        return locationArr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView == requestedItemsTbl) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            return 38;
        }
        else {
            return 40;
        }
    }
    else  if (tableView == productListTbl|| tableView == nextActivityTbl ||tableView == shipModeTable ||tableView == priceTable || tableView == categoriesTbl ||tableView == locationTable ) {
        
        return 40;
    }
    
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView == requestedItemsTbl) {
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        static NSString *hlCellID = @"hlCellID";
        
        UITableViewCell * hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
        
        if ((hlcell.contentView).subviews){
            for (UIView *subview in (hlcell.contentView).subviews) {
                [subview removeFromSuperview];
            }
        }
        
        CAGradientLayer * layer_1;
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                       initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            
            
            @try {
                layer_1 = [CAGradientLayer layer];
                layer_1.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
                
                layer_1.frame = CGRectMake(sNoLbl.frame.origin.x, hlcell.frame.size.height - 2,actionLbl.frame.origin.x+actionLbl.frame.size.width-(sNoLbl.frame.origin.x),1);
                
                [hlcell.contentView.layer addSublayer:layer_1];
                
            } @catch (NSException *exception) {
                
            }
        }
        
        UILabel *itemNoLbl;
        UILabel *itemIdLbl;
        UILabel *itemDescLbl;
        UILabel *itemUomLbl;
        UILabel *itemRangeLbl;
        UILabel *itemGradeLbl;
        UILabel *itempriceLabel;
        UILabel *itemStockQtyLbl;
        UILabel * balance_QtyLbl;
        
        UILabel *makeLbl;
        UIButton *delRowBtn;
        
        itemNoLbl = [[UILabel alloc] init];
        itemNoLbl.backgroundColor = [UIColor clearColor];
        itemNoLbl.layer.borderWidth = 0;
        itemNoLbl.textAlignment = NSTextAlignmentCenter;
        itemNoLbl.numberOfLines = 1;
        itemNoLbl.lineBreakMode = NSLineBreakByWordWrapping;
        
        
        itemIdLbl = [[UILabel alloc] init];
        itemIdLbl.backgroundColor = [UIColor clearColor];
        itemIdLbl.layer.borderWidth = 0;
        itemIdLbl.textAlignment = NSTextAlignmentCenter;
        itemIdLbl.numberOfLines = 1;
        itemIdLbl.lineBreakMode = NSLineBreakByWordWrapping;
        
        itemDescLbl = [[UILabel alloc] init];
        itemDescLbl.backgroundColor = [UIColor clearColor];
        itemDescLbl.layer.borderWidth = 0;
        itemDescLbl.textAlignment = NSTextAlignmentCenter;
        itemDescLbl.numberOfLines = 1;
        itemDescLbl.lineBreakMode = NSLineBreakByWordWrapping;
        
        itemUomLbl = [[UILabel alloc] init];
        itemUomLbl.backgroundColor = [UIColor clearColor];
        itemUomLbl.layer.borderWidth = 0;
        itemUomLbl.textAlignment = NSTextAlignmentCenter;
        itemUomLbl.numberOfLines = 1;
        itemUomLbl.lineBreakMode = NSLineBreakByWordWrapping;
        
        itemRangeLbl = [[UILabel alloc] init];
        itemRangeLbl.backgroundColor = [UIColor clearColor];
        itemRangeLbl.layer.borderWidth = 0;
        itemRangeLbl.textAlignment = NSTextAlignmentCenter;
        itemRangeLbl.numberOfLines = 1;
        itemRangeLbl.lineBreakMode = NSLineBreakByWordWrapping;
        
        itemGradeLbl = [[UILabel alloc] init];
        itemGradeLbl.backgroundColor = [UIColor clearColor];
        itemGradeLbl.layer.borderWidth = 0;
        itemGradeLbl.textAlignment = NSTextAlignmentCenter;
        itemGradeLbl.numberOfLines = 1;
        itemGradeLbl.lineBreakMode = NSLineBreakByWordWrapping;
        
        itempriceLabel = [[UILabel alloc] init];
        itempriceLabel.backgroundColor = [UIColor clearColor];
        itempriceLabel.layer.borderWidth = 0;
        itempriceLabel.textAlignment = NSTextAlignmentCenter;
        itempriceLabel.numberOfLines = 1;
        itempriceLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        
        itemStockQtyLbl = [[UILabel alloc] init];
        itemStockQtyLbl.backgroundColor = [UIColor clearColor];
        itemStockQtyLbl.layer.borderWidth = 0;
        itemStockQtyLbl.textAlignment = NSTextAlignmentCenter;
        itemStockQtyLbl.numberOfLines = 1;
        itemStockQtyLbl.lineBreakMode = NSLineBreakByWordWrapping;
        
        issueQtyText = [[UITextField alloc] init];
        issueQtyText.borderStyle = UITextBorderStyleRoundedRect;
        issueQtyText.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        issueQtyText.keyboardType = UIKeyboardTypeNumberPad;
        issueQtyText.layer.borderWidth = 1.0;
        issueQtyText.backgroundColor = [UIColor clearColor];
        issueQtyText.autocorrectionType = UITextAutocorrectionTypeNo;
        issueQtyText.clearButtonMode = UITextFieldViewModeWhileEditing;
        issueQtyText.returnKeyType = UIReturnKeyDone;
        issueQtyText.delegate = self;
        issueQtyText.textAlignment = NSTextAlignmentCenter;
        issueQtyText.tag = indexPath.row;
        issueQtyText.userInteractionEnabled = YES;
        [issueQtyText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        balance_QtyLbl = [[UILabel alloc] init];
        balance_QtyLbl.backgroundColor = [UIColor clearColor];
        balance_QtyLbl.layer.borderWidth = 0;
        balance_QtyLbl.textAlignment = NSTextAlignmentCenter;
        balance_QtyLbl.numberOfLines = 1;
        balance_QtyLbl.lineBreakMode = NSLineBreakByWordWrapping;
        
        scanCodeText = [[UITextField alloc] init];
        scanCodeText.borderStyle = UITextBorderStyleRoundedRect;
        scanCodeText.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        scanCodeText.keyboardType = UIKeyboardTypeNumberPad;
        scanCodeText.layer.borderWidth = 1.0;
        scanCodeText.backgroundColor = [UIColor clearColor];
        scanCodeText.autocorrectionType = UITextAutocorrectionTypeNo;
        scanCodeText.clearButtonMode = UITextFieldViewModeWhileEditing;
        scanCodeText.returnKeyType = UIReturnKeyDone;
        scanCodeText.delegate = self;
        scanCodeText.textAlignment = NSTextAlignmentCenter;
        scanCodeText.tag = indexPath.row;
        scanCodeText.userInteractionEnabled = YES;
        scanCodeText.placeholder = NSLocalizedString(@"item_code",nil);
        scanCodeText.attributedPlaceholder = [[NSAttributedString alloc]initWithString:scanCodeText.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor whiteColor]colorWithAlphaComponent:0.4]}];
        
        [scanCodeText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        makeLbl = [[UILabel alloc] init];
        makeLbl.backgroundColor = [UIColor clearColor];
        makeLbl.layer.borderWidth = 0;
        makeLbl.textAlignment = NSTextAlignmentCenter;
        makeLbl.numberOfLines = 1;
        makeLbl.lineBreakMode = NSLineBreakByWordWrapping;
        
        //upto here on 11/05//2017....
        delRowBtn = [[UIButton alloc] init];
        [delRowBtn addTarget:self action:@selector(delRow:) forControlEvents:UIControlEventTouchUpInside];
        UIImage * image = [UIImage imageNamed:@"delete.png"];
        delRowBtn.tag = indexPath.row;
        [delRowBtn setBackgroundImage:image    forState:UIControlStateNormal];
        
        itemNoLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
        itemIdLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
        itemDescLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
        itemUomLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
        itemRangeLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
        itemGradeLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
        itempriceLabel.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
        itemStockQtyLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
        issueQtyText.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
        balance_QtyLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
        scanCodeText.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
        makeLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
        
        itemNoLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        itemIdLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        itemDescLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        itemUomLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        itemRangeLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        itemGradeLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        itempriceLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        itemStockQtyLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        issueQtyText.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        balance_QtyLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        scanCodeText.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        makeLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        
        [hlcell.contentView addSubview:itemNoLbl];
        [hlcell.contentView addSubview:itemIdLbl];
        [hlcell.contentView addSubview:itemDescLbl];
        [hlcell.contentView addSubview:itemUomLbl];
        [hlcell.contentView addSubview:itemRangeLbl];
        [hlcell.contentView addSubview:itemGradeLbl];
        [hlcell.contentView addSubview:itempriceLabel];
        [hlcell.contentView addSubview:itemStockQtyLbl];
        [hlcell.contentView addSubview:issueQtyText];
        [hlcell.contentView addSubview:balance_QtyLbl];
        [hlcell.contentView addSubview:scanCodeText];
        [hlcell.contentView addSubview:makeLbl];
        [hlcell.contentView addSubview:delRowBtn];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            itemNoLbl.frame = CGRectMake(sNoLbl.frame.origin.x,0,sNoLbl.frame.size.width, hlcell.frame.size.height);
            
            itemIdLbl.frame = CGRectMake(skuIdLbl.frame.origin.x, 0, skuIdLbl.frame.size.width,  hlcell.frame.size.height);
            
            itemDescLbl.frame = CGRectMake(descriptionLbl.frame.origin.x, 0, descriptionLbl.frame.size.width,  hlcell.frame.size.height);
            
            itemUomLbl .frame= CGRectMake( uomLbl.frame.origin.x, 0, uomLbl.frame.size.width,  hlcell.frame.size.height);
            
            itemRangeLbl.frame = CGRectMake(rangeLbl.frame.origin.x, 0, rangeLbl.frame.size.width,  hlcell.frame.size.height);
            
            itemGradeLbl.frame = CGRectMake(gradeLbl.frame.origin.x, 0, gradeLbl.frame.size.width,  hlcell.frame.size.height);
            
            itempriceLabel.frame = CGRectMake(priceLabel.frame.origin.x,0,priceLabel.frame.size.width,  hlcell.frame.size.height);
            
            itemStockQtyLbl.frame = CGRectMake(stockQtyLbl.frame.origin.x,0,stockQtyLbl.frame.size.width,  hlcell.frame.size.height);
            
            issueQtyText .frame = CGRectMake(issueQtyLbl.frame.origin.x,2,issueQtyLbl.frame.size.width,36);
            
            balance_QtyLbl .frame = CGRectMake(balanceQtyLbl.frame.origin.x,2,balanceQtyLbl.frame.size.width,36);
            
            scanCodeText .frame = CGRectMake(scanCodeLabel.frame.origin.x,2,scanCodeLabel.frame.size.width,36);
            
            makeLbl.frame = CGRectMake(make_Lbl.frame.origin.x,0,make_Lbl.frame.size.width-2,hlcell.frame.size.height);
            
            delRowBtn.frame= CGRectMake(makeLbl.frame.origin.x+makeLbl.frame.size.width+20,5,35,35);
            
            [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:15.0f cornerRadius:0.0];
            
        }
        else {
            
        }
        
        //populating the data into table.......
        @try {
            if(requestedItemsInfoArr.count > indexPath.row) {
                
                NSDictionary * dic = requestedItemsInfoArr[indexPath.row];
                
                itemNoLbl.text = [NSString stringWithFormat:@"%li", (indexPath.row+1)];
                
                itemIdLbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_SKU] defaultReturn:@"--"];//ITEM_SKU
                
                itemDescLbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_DESCRIPTION] defaultReturn:@"--"];
                
                itemUomLbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:SELL_UOM] defaultReturn:@"--"];
                
                itemRangeLbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:MEASUREMENT_RANGE] defaultReturn:@"--"];
                
                itemGradeLbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:PRODUCT_RANGE] defaultReturn:@"--"];
                
                itempriceLabel.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_UNIT_PRICE] defaultReturn:@"0.00"] floatValue]];
                
                itemStockQtyLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:AVAILABLE_QTY] defaultReturn:@"0.00"] floatValue]];
                
                issueQtyText.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]];
                
                balance_QtyLbl.text = [NSString stringWithFormat:@"%.2f",(itemStockQtyLbl.text).floatValue - (issueQtyText.text).floatValue];
                
                scanCodeText.text  = [self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_SCAN_CODE] defaultReturn:@"--"];
               
                makeLbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:MAKE] defaultReturn:@"--"];
                
            }
            
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            hlcell.backgroundColor = [UIColor clearColor];
        }
        @catch (NSException * exception) {
            
        }
        return hlcell;

    }
    
    else if (tableView == productListTbl) {
        
        //changed by Bhargav.v  on 12/2/2018....
        UITableViewCell * hlcell;
        
        @try {
            
            static NSString * hlCellID = @"hlCellID";
            
            hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
            
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
            
            //  NSDictionary *dic = [priceDic objectAtIndex:indexPath.row];
            
            UILabel * itemDescLbl;
            UILabel * itemPriceLbl;
            UILabel * itemQtyInHandLbl;
            UILabel * itemColorLbl;
            UILabel * itemSizeLbl;
            UILabel * itemMeasurementLbl;
            
            itemDescLbl = [[UILabel alloc] init] ;
            itemDescLbl.layer.borderWidth = 1.5;
            itemDescLbl.font = [UIFont systemFontOfSize:13.0];
            itemDescLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            itemDescLbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
            itemDescLbl.textColor = [UIColor blackColor];
            itemDescLbl.textAlignment=NSTextAlignmentLeft;
            
            itemPriceLbl = [[UILabel alloc] init] ;
            itemPriceLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            itemPriceLbl.layer.borderWidth = 1.5;
            itemPriceLbl.backgroundColor =[UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
            itemPriceLbl.textAlignment = NSTextAlignmentCenter;
            itemPriceLbl.numberOfLines = 2;
            itemPriceLbl.textColor = [UIColor blackColor];
            
            itemQtyInHandLbl = [[UILabel alloc] init] ;
            itemQtyInHandLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            itemQtyInHandLbl.layer.borderWidth = 1.5;
            itemQtyInHandLbl.backgroundColor =[UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
            itemQtyInHandLbl.textAlignment = NSTextAlignmentCenter;
            itemQtyInHandLbl.numberOfLines = 2;
            itemQtyInHandLbl.textColor = [UIColor blackColor];
            
            itemColorLbl = [[UILabel alloc] init] ;
            itemColorLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            itemColorLbl.layer.borderWidth = 1.5;
            itemColorLbl.backgroundColor =[UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
            itemColorLbl.textAlignment = NSTextAlignmentCenter;
            itemColorLbl.numberOfLines = 2;
            itemColorLbl.textColor = [UIColor blackColor];
            
            itemSizeLbl = [[UILabel alloc] init] ;
            itemSizeLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            itemSizeLbl.layer.borderWidth = 1.5;
            itemSizeLbl.backgroundColor =[UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
            itemSizeLbl.textAlignment = NSTextAlignmentCenter;
            itemSizeLbl.numberOfLines = 2;
            itemSizeLbl.textColor = [UIColor blackColor];
            
            itemMeasurementLbl = [[UILabel alloc] init] ;
            itemMeasurementLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            itemMeasurementLbl.layer.borderWidth = 1.5;
            itemMeasurementLbl.backgroundColor =[UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
            itemMeasurementLbl.textAlignment = NSTextAlignmentCenter;
            itemMeasurementLbl.numberOfLines = 2;
            itemMeasurementLbl.textColor = [UIColor blackColor];
            
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (productList.count > indexPath.row){
                NSDictionary * dic = productList[indexPath.row];
                
                
                if([dic isKindOfClass:[NSDictionary class]]){
                    
                    itemDescLbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_DESCRIPTION] defaultReturn:@"--"];
                    itemPriceLbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:kPrice] defaultReturn:@"0.00"] floatValue]];
                    
                    itemQtyInHandLbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:QUANTITY_IN_HAND] defaultReturn:@"0.00"] floatValue]];
                    itemColorLbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:COLOR] defaultReturn:@"--"];
                    itemSizeLbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:SIZE] defaultReturn:@""];
                    itemMeasurementLbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:MEASUREMENT_RANGE] defaultReturn:@""];
                }
            }
            
            else {
                
                itemDescLbl.text = @"";
                itemPriceLbl.text = @"";
                itemQtyInHandLbl.text = @"";
                itemColorLbl.text = @"";
                itemSizeLbl.text = @"";
                itemMeasurementLbl.text = @"";
            }
            
            if(!(itemQtyInHandLbl.text).length)
                itemQtyInHandLbl.text = @"--";
            if(!(itemColorLbl.text).length)
                itemColorLbl.text = @"--";
            if(!(itemSizeLbl.text).length)
                itemSizeLbl.text = @"--";
            if(!(itemMeasurementLbl.text).length)
                itemMeasurementLbl.text = @"--";
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                itemDescLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
                itemPriceLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
                itemQtyInHandLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
                itemColorLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
                itemSizeLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
                itemMeasurementLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
                
                if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
                    
                }
                else {
                    
                }
                
                itemDescLbl.frame = CGRectMake(0, 0, 300, 50);
                itemPriceLbl.frame = CGRectMake( itemDescLbl.frame.origin.x + itemDescLbl.frame.size.width, 0, 100, itemDescLbl.frame.size.height);
                itemQtyInHandLbl.frame = CGRectMake( itemPriceLbl.frame.origin.x + itemPriceLbl.frame.size.width, 0, 100, itemDescLbl.frame.size.height);
                itemColorLbl.frame = CGRectMake( itemQtyInHandLbl.frame.origin.x + itemQtyInHandLbl.frame.size.width, 0, 100, itemDescLbl.frame.size.height);
                itemSizeLbl.frame = CGRectMake( itemColorLbl.frame.origin.x + itemColorLbl.frame.size.width, 0, 100, itemDescLbl.frame.size.height);
                itemMeasurementLbl.frame = CGRectMake( itemSizeLbl.frame.origin.x + itemSizeLbl.frame.size.width, 0, searchItemsTxt.frame.size.width - (itemSizeLbl.frame.origin.x + itemSizeLbl.frame.size.width), itemDescLbl.frame.size.height);
            }
            else {
                
                itemDescLbl.frame = CGRectMake(5, 0, 130, 34);
                itemPriceLbl.frame = CGRectMake(135, 0, 70, 34);
            }
            
            
            //[hlcell setBackgroundColor:[UIColor clearColor]];
            [hlcell.contentView addSubview:itemDescLbl];
            [hlcell.contentView addSubview:itemPriceLbl];
            [hlcell.contentView addSubview:itemQtyInHandLbl];
            [hlcell.contentView addSubview:itemColorLbl];
            [hlcell.contentView addSubview:itemSizeLbl];
            [hlcell.contentView addSubview:itemMeasurementLbl];
        }
        @catch (NSException *exception) {
            
            NSLog(@"%@",exception);
        }
        @finally{
            
            return hlcell;
        }
    }
    
    else if(tableView == nextActivityTbl){
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
        
        @try {
            hlcell.textLabel.numberOfLines = 1;
            hlcell.textLabel.text = nextActivitiesArr[indexPath.row];
            
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:20];
        } @catch (NSException *exception) {
            
        }
        
        //[hlcell setBackgroundColor:[UIColor blackColor]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.textLabel.font = [UIFont systemFontOfSize:18.0];
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return hlcell;
        
    }
    
 else if (tableView == shipModeTable) {
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
        
        @try {
            hlcell.textLabel.numberOfLines = 2;
            hlcell.textLabel.text = shipModesArr[indexPath.row];
            
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:20];
        } @catch (NSException *exception) {
            
        }
        
        //[hlcell setBackgroundColor:[UIColor blackColor]];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.textLabel.font = [UIFont systemFontOfSize:18.0];
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return hlcell;
     
    }
 else if (tableView == priceTable) {
     
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
     @try {
         [HUD setHidden:YES];
         NSDictionary *dic = priceDic[indexPath.row];
         
         UILabel *desc_Lbl = [[UILabel alloc] init] ;
         desc_Lbl.layer.borderWidth = 1.5;
         desc_Lbl.font = [UIFont systemFontOfSize:13.0];
         desc_Lbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:13];
         desc_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
         desc_Lbl.backgroundColor = [UIColor blackColor];
         desc_Lbl.textColor = [UIColor whiteColor];
         desc_Lbl.text = [dic valueForKey:kDescription];
         desc_Lbl.textAlignment=NSTextAlignmentCenter;
         //            skid.adjustsFontSizeToFitWidth = YES;
         
         UILabel *mrpPrice = [[UILabel alloc] init] ;
         mrpPrice.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
         mrpPrice.layer.borderWidth = 1.5;
         mrpPrice.backgroundColor = [UIColor blackColor];
         mrpPrice.text = [NSString stringWithFormat:@"%.2f",[[dic valueForKey:SALE_PRICE] floatValue]];
         mrpPrice.textAlignment = NSTextAlignmentCenter;
         mrpPrice.numberOfLines = 2;
         mrpPrice.textColor = [UIColor whiteColor];
         
         UILabel *price = [[UILabel alloc] init] ;
         price.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
         price.layer.borderWidth = 1.5;
         price.backgroundColor = [UIColor blackColor];
         price.text = [NSString stringWithFormat:@"%.2f",[[dic valueForKey:kPrice] floatValue]];
         price.textAlignment = NSTextAlignmentCenter;
         price.numberOfLines = 2;
         price.textColor = [UIColor whiteColor];
         // name.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:12];
         
         hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
         
         if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
             
             desc_Lbl.frame = CGRectMake( 0, 0, descLabl.frame.size.width + 1, hlcell.frame.size.height);
             
             desc_Lbl.font = [UIFont systemFontOfSize:22];
             
             mrpPrice.frame = CGRectMake(desc_Lbl.frame.origin.x + desc_Lbl.frame.size.width, 0, mrpLbl.frame.size.width + 2,  hlcell.frame.size.height);
             
             mrpPrice.font = [UIFont systemFontOfSize:22];
             
             price.font = [UIFont systemFontOfSize:22];
             price.frame = CGRectMake(mrpPrice.frame.origin.x + mrpPrice.frame.size.width, 0, priceLbl.frame.size.width+2, hlcell.frame.size.height);
             
             
         }
         else {
             
             
         }
         
         hlcell.backgroundColor = [UIColor clearColor];
         [hlcell.contentView addSubview:desc_Lbl];
         [hlcell.contentView addSubview:price];
         [hlcell.contentView addSubview:mrpPrice];
         
     }
     @catch (NSException *exception) {
         
         NSLog(@"%@",exception);
     }
     @finally {
         
     }
     return hlcell;
 }
 
 else if (tableView == categoriesTbl) {
    
     @try {
         
         static NSString * hlCellID = @"hlCellID";
         
         UITableViewCell * hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
         
         if ((hlcell.contentView).subviews){
             
             for (UIView * subview in (hlcell.contentView).subviews) {
                 [subview removeFromSuperview];
             }
         }
         
         if(hlcell == nil) {
             hlcell =  [[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID] ;
             hlcell.accessoryType = UITableViewCellAccessoryNone;
         }
         tableView.separatorColor = [UIColor clearColor];
         
         //added by Bhargav.v on 07/03/2017....
         
         checkBoxsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
         
         UIImage * checkBoxImg =  [UIImage imageNamed:@"checkbox_off_background.png"];
         [checkBoxsBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
         
         if( checkBoxArr.count && categoriesArr.count){
             if([checkBoxArr[indexPath.row] integerValue])
                 checkBoxImg = [UIImage imageNamed:@"checkbox_on_background.png"];
             checkBoxsBtn.userInteractionEnabled = YES;
         }
         [checkBoxsBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
         checkBoxsBtn.tag = indexPath.row;
         
         [checkBoxsBtn addTarget:self action:@selector(changeCheckBoxImages:) forControlEvents:UIControlEventTouchUpInside];
         
         [hlcell.contentView addSubview:checkBoxsBtn];
         checkBoxsBtn.frame = CGRectMake(selectAllCheckBoxBtn.frame.origin.x, 7, 30 , 30);
         
         //upto here on 07/03/2017....
         
         UILabel * categoryLbl = [[UILabel alloc] init];
         categoryLbl.backgroundColor = [UIColor clearColor];
         categoryLbl.numberOfLines = 1;
         categoryLbl.lineBreakMode = NSLineBreakByWordWrapping;
         
         categoryLbl.textColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0];
         if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
             
             categoryLbl.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
             categoryLbl.frame = CGRectMake(checkBoxsBtn.frame.origin.x+checkBoxsBtn.frame.size.width+15, checkBoxsBtn.frame.origin.y-5,280,40);
         }
         categoryLbl.textAlignment = NSTextAlignmentLeft;
         categoryLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
         
         [hlcell.contentView addSubview:checkBoxsBtn];
         [hlcell.contentView addSubview:categoryLbl];
         
         @try {
             
             if( categoriesArr.count > indexPath.row){
                 categoryLbl.text  = categoriesArr[indexPath.row];
             }
             
         } @catch (NSException *exception) {
             
         } @finally {
             
         }
         
         hlcell.backgroundColor = [UIColor clearColor];
         hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
         return hlcell;
         
     }
     @catch (NSException *exception) {
         
     }
     @finally {
         
     }
 }
    
//Locations Table For Single Store Selection...
 else if (tableView == locationTable)  {
     
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
     
     @try {
         
         hlcell.textLabel.text = [self checkGivenValueIsNullOrNil:locationArr[indexPath.row]  defaultReturn:@""];
         
     } @catch (NSException *exception) {
         
     }
     hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
     hlcell.textLabel.numberOfLines = 1;
     hlcell.textLabel.textColor = [UIColor blackColor];
     hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
     
     return hlcell;
 }
    
    
// else if (tableView == locationTable){
//
//     static NSString * hlCellID = @"hlCellID";
//
//     UITableViewCell * hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
//
//     if ([hlcell.contentView subviews]){
//
//         for (UIView * subview in [hlcell.contentView subviews]) {
//             [subview removeFromSuperview];
//         }
//     }
//
//     if(hlcell == nil) {
//         hlcell =  [[UITableViewCell alloc]
//                    initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID] ;
//         hlcell.accessoryType = UITableViewCellAccessoryNone;
//     }
//     tableView.separatorColor = [UIColor clearColor];
//
//     checkBoxsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//
//     UIImage * checkBoxImg =  [UIImage imageNamed:@"checkbox_off_background.png"];
//     [checkBoxsBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
//
//
//     if( [locationCheckBoxArr count] && [locationArr count]){
//         if([[locationCheckBoxArr objectAtIndex:indexPath.row] integerValue])
//             checkBoxImg = [UIImage imageNamed:@"checkbox_on_background.png"];
//         checkBoxsBtn.userInteractionEnabled = YES;
//     }
//
//     [checkBoxsBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
//     checkBoxsBtn.tag = indexPath.row;
//
//     [checkBoxsBtn addTarget:self action:@selector(changeLocationCheckBoxImages:) forControlEvents:UIControlEventTouchUpInside];
//
//     [hlcell.contentView addSubview:checkBoxsBtn];
//
//
//     //upto here on 07/03/2017....
//
//     UILabel * locationLbl = [[UILabel alloc] init];
//     locationLbl.backgroundColor = [UIColor clearColor];
//     locationLbl.numberOfLines = 1;
//     locationLbl.lineBreakMode = NSLineBreakByWordWrapping;
//
//     locationLbl.textColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0];
//     if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//
//         locationLbl.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
//         locationLbl.frame = CGRectMake(5,0,335,40);
//         checkBoxsBtn.frame = CGRectMake(locationCloseBtn.frame.origin.x,locationLbl.frame.origin.y,30,30);
//     }
//     locationLbl.textAlignment = NSTextAlignmentLeft;
//     locationLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
//     [hlcell.contentView addSubview:locationLbl];
//     [hlcell.contentView addSubview:checkBoxsBtn];
//
//     @try {
//
//         if( [locationArr count] > indexPath.row){
//             locationLbl.text  = [locationArr objectAtIndex:indexPath.row];
//
//         }
//
//     } @catch (NSException *exception) {
//
//     } @finally {
//
//     }
//
//     hlcell.backgroundColor = [UIColor clearColor];
//     hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
//     return hlcell;
//
// }
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [catPopOver dismissPopoverAnimated:YES];
    
    if(tableView == nextActivityTbl) {
        
        @try {
            
            ActionReqTxt.text = nextActivitiesArr[indexPath.row];
            
        } @catch (NSException *exception) {
            
            NSLog(@"----exception changing the textField text in didSelectRowAtIndexPath:----%@",exception);
        }
    }
    
    else if (tableView == shipModeTable) {
        shipmentModeTxt.text = shipModesArr[indexPath.row];
    }
    
    else if (tableView == locationTable) {
        
        toStoreCodeTxt.text = locationArr[indexPath.row];
        [catPopOver dismissPopoverAnimated: YES];
    }
    
    else if (tableView == productListTbl) {
        
        //Changes Made Bhargav.v on 11/05/2018...
        //Changed The Parameter to Plucode While sending the RequestString to SkuDetails...
        //Reason:Making the plucode Search instead of searching skuid to avoid Price List...
        
        NSDictionary * detailsDic = productList[indexPath.row];
        
        NSString * inputServiceStr = [NSString stringWithFormat:@"%@",detailsDic[SKUID]];
        
        if (([detailsDic.allKeys containsObject:PLU_CODE]) && (![[detailsDic valueForKey:PLU_CODE] isKindOfClass:[NSNull class]])) {
            
            inputServiceStr = [NSString stringWithFormat:@"%@",detailsDic[PLU_CODE]];
        }
        
        [self callRawMaterialDetails:inputServiceStr];
        
        searchItemsTxt.text = @"";
        
        
    }
    
    // Code for priceTable
    else if (tableView == priceTable){
        
        @try {
            transparentView.hidden = YES;
            
            NSDictionary * detailsDic = priceDic[indexPath.row];
            BOOL status = FALSE;
            int i = 0;
            NSMutableDictionary * dic;
            for ( i=0; i<requestedItemsInfoArr.count;i++) {
                
                dic = requestedItemsInfoArr[i];
                if ([[dic valueForKey:ITEM_SKU] isEqualToString:[detailsDic valueForKey:ITEM_SKU]] && [[dic valueForKey:PLU_CODE] isEqualToString:[detailsDic valueForKey:PLU_CODE]]) {
                    [dic setValue:[NSString stringWithFormat:@"%d",[[dic valueForKey:kMaxQuantity] intValue] + 1] forKey:kMaxQuantity];
                    
                    requestedItemsInfoArr[i] = dic;
                    
                    status = TRUE;
                    break;
                }
            }
            if (!status) {
                
                NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc] init];
                
                //setting skuId....
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_SKU];
                
                [itemDetailsDic setValue:[itemDetailsDic valueForKey:ITEM_SKU] forKey:kItem];
                
                //setting plucode....
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:PLU_CODE] defaultReturn:[itemDetailsDic valueForKey:ITEM_SKU]] forKey:PLU_CODE];
                
                //setting itemDescription....
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESCRIPTION];
                
                //setting itemPrice as salePrice...
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:cost_Price] defaultReturn:@"0.00"] floatValue]] forKey:ITEM_UNIT_PRICE];
                
                //setting availiable qty....
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:AVAILABLE_QTY] defaultReturn:@"0.00"] floatValue]] forKey:AVL_QTY];
                
                //setting availiable qty....
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:AVL_QTY];
                
                //setting quantity as  indentQuantity to 0....
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:QUANTITY];
                
                //setting quantity as max_quantity to 1....
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:kMaxQuantity];
                
                //newly added keys....
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:kMeasureRange] defaultReturn:@""] forKey:MEASUREMENT_RANGE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:kProductBrand] defaultReturn:@""] forKey:kBrand];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
                
                [requestedItemsInfoArr addObject:itemDetailsDic];
            }
            requestedItemsTbl.hidden =  NO;
        }
        @catch (NSException * exception) {
            
        }
        @finally {
            [self calculateTotal];
            [requestedItemsTbl reloadData];
        }
    }
    
    else if (tableView == locationTable){
        
        toStoreCodeTxt.text = [self checkGivenValueIsNullOrNil:locationArr[indexPath.row]  defaultReturn:@""];
        
    }
}


#pragma mark closwe transparentView


-(void)closePriceView:(UIButton *)sender {
    transparentView.hidden = YES;
}

#pragma - mark calculating total...

/**
 * @description  we are calculating the totalvalues...
 * @date         29/07/2017
 * @method       calculateTotal
 * @author       Bhargav.v
 * @param        nil
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)calculateTotal{
    
    @try {
        float totalPrice       = 0.0;
        float totalStockQty    = 0.0;
        float totalIssueQty    = 0.0;
        float totalBalanceQty  = 0.0;
        
        
        for(NSDictionary * dic in requestedItemsInfoArr){
            
            if([[self checkGivenValueIsNullOrNil:[dic valueForKey:QUANTITY] defaultReturn:@"0.00"]floatValue] >= 0){
                
                totalPrice  += [[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_UNIT_PRICE] defaultReturn:@"0.00"]floatValue];
                
                totalStockQty   += [[self checkGivenValueIsNullOrNil:[dic valueForKey:AVAILABLE_QTY] defaultReturn:@"0.00"]floatValue];
                
                totalIssueQty  += [[self checkGivenValueIsNullOrNil:[dic valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue];
                
                totalBalanceQty +=  ([[dic valueForKey:AVAILABLE_QTY] floatValue] - [[dic valueForKey:QUANTITY] floatValue]);
            }
        }
        
        priceValueLbl.text      = [NSString stringWithFormat:@"%@%.2f",@"",totalPrice];
        stockQtyValueLbl.text   = [NSString stringWithFormat:@"%@%.2f",@" ",totalStockQty];
        issueQtyValueLbl.text   = [NSString stringWithFormat:@"%@%.2f",@" ",totalIssueQty];
        balanceQtyValueLbl.text = [NSString stringWithFormat:@"%@%.2f",@" ",totalBalanceQty];
        
    } @catch (NSException *exception) {
        NSLog(@"-----exception in while calculating the totalValue-----%@",exception);
        
    } @finally {
    }
    
}


/**
 * @description   here we are change frame Size's as well as the scrollView content Size.......
 * @date          27/09/2016
 * @method        changeAdjustableViewFrame
 
 
 
 */

-(void)changeAdjustableViewFrame {
    
    @try {
        int count = 2;
        if(requestedItemsInfoArr.count)
            count = (int)requestedItemsInfoArr.count;
        
        requestedItemsTbl.frame =  CGRectMake(requestedItemsTbl.frame.origin.x, requestedItemsTbl.frame.origin.y, requestedItemsTbl.frame.size.width, (count * 40 + 15));
        
        adjustableView.frame = CGRectMake( adjustableView.frame.origin.x, requestedItemsTbl.frame.origin.y + requestedItemsTbl.frame.size.height + 10, adjustableView.frame.size.width,  adjustableView.frame.size.height);
        
        stockIssueScrollView.contentSize = CGSizeMake(stockIssueScrollView.frame.size.width, adjustableView.frame.origin.y + adjustableView.frame.size.height + 100);
        
    } @catch (NSException *exception) {
        NSLog(@"------exception in changing the frame Sizes-----%@",exception);
        
    } @finally {
        
    }
    
}

#pragma -mark used to display the error message...


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

-(void)displayAlertMessage:(NSString *)message  horizontialAxis:(float)xPostion  verticalAxis:(float)yPosition msgType:(NSString *)messageType   conentWidth:(float )labelWidth contentHeight:(float)labelHeight isSoundRequired:(BOOL)soundStatus  timming:(float)noOfSecondsToDisplay noOfLines:(int)noOfLines{
    
    @try {
        
        //Play audio for button touch...
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
            
            if(searchItemsTxt.isEditing)
                yPosition = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height;
            
            
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

//**
// * @description  removing alertMessage add in the  disPlayAlertMessage method
// * @date         18/11/2016
// * @method       removeAlertMessages
// * @author       Bhargav Ram
// * @param
// * @param
// * @return
// * @verified By
// * @verified On
// *
// */

-(void)removeAlertMessages{
    @try {
        
        if(userAlertMessageLbl.tag == 4){
            
            [self backAction];
            
//            MaterialTransferIssue *home = [[MaterialTransferIssue alloc]init];
//            [self.navigationController pushViewController:home animated:YES];
        }
        
        else if ([userAlertMessageLbl isDescendantOfView:self.view])
            [userAlertMessageLbl removeFromSuperview];
        
        
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        
        NSLog(@"--------exception in the CreateReceiptView in removeAlertMessages---------%@",exception);
        NSLog(@"----exception in removing userAlertMessageLbl label------------%@",exception);
        
    }
    
}


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
        
        if (catPopOver.popoverVisible && (tableName.frame.size.height > height)){
            catPopOver.popoverContentSize =  CGSizeMake(width, height);
            
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
        
    } @finally {
        [tableName reloadData];
        
    }
}



#pragma mark key board methods:

-(void)setViewMovedUp:(BOOL)movedUp {
    
    @try {
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3]; // if you want to slide up the view
        
        CGRect rect = self.view.frame;
        
        //    CGRect rect = scrollView.frame;
        
        if (movedUp)
        {
            // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
            rect.origin.y = (rect.origin.y -(rect.origin.y + offSetViewTo));
        }
        else
        {
            // revert back to the normal state.
            rect.origin.y +=  offSetViewTo;
        }
        self.view.frame = rect;
        //   scrollView.frame = rect;
        
        [UIView commitAnimations];
        
        /* offSetViewTo = 80;
         [self keyboardWillShow];*/
        
    } @catch (NSException *exception) {
        NSLog(@"-------exception while changing frame self.view---------%@",exception);
    } @finally {
        
    }
    
}




/**
 * @description  called when keyboard is displayed
 * @date         04/06/2016
 * @method       keyboardWillShow
 * @author       Bhargav
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)keyboardWillShow {
    // Animate the current view out of the way
    @try {
        [self setViewMovedUp:YES];
        
    } @catch (NSException *exception) {
        NSLog(@"-------exception while changing frame self.view---------%@",exception);
        
    }
}

/**
 * @description  called when keyboard is dismissed
 * @date         04/06/2016
 * @method       keyboardWillHide
 * @author       Bhargav
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)keyboardWillHide {
    @try {
        [self setViewMovedUp:NO];
        
    } @catch (NSException *exception) {
        NSLog(@"-------exception while changing frame self.view---------%@",exception);
        
    }
}

#pragma -mark used to check whethere the object is

/**
 * @description  here we are checking whether the object is null or not
 * @date         16/12/2016
 * @method       checkGivenValueIsNullOrNil
 * @author       bhargav
 * @param
 * @param
 * @return
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


#pragma Mark service Call For the Categories

/**
 * @description  this method is used to get Categories List...
 * @date         11/09/2016
 * @method       validatingCategoriesList
 * @author       Bhargav Ram
 * @param        UIButton
 * @return
 *
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)validatingCategoriesList:(UIButton *)sender {
    @try {
        
        
        if(((categoriesArr == nil)  && (!categoriesArr.count))){
            
            [self callingCategoriesList];
        }
        else {
            
            [self displayCategoriesList:nil];
            [categoriesTbl reloadData];
        }
    }
    @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @finally {
        [HUD setHidden:YES];
        
    }
}


/**
 * @description  this method is used to get Categories List...
 * @date         21/09/2016
 * @method       callingCategoriesList
 * @author       Bhargav Ram
 * @param        NSString
 * @return
 *
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callingCategoriesList {
    
    @try {
        [HUD show:YES];
        [HUD setHidden:NO];
        
        [HUD setLabelText:NSLocalizedString(@"please_wait..", nil)];
        
        if(categoriesArr == nil){
            categoriesArr  = [NSMutableArray new];
            checkBoxArr    = [NSMutableArray new];
        }
        
        NSMutableDictionary * locationWiseCategoryDictionary = [[NSMutableDictionary alloc]init];
        
        [locationWiseCategoryDictionary setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        
        [locationWiseCategoryDictionary setValue:presentLocation forKey:kStoreLocation];
        
        
        [locationWiseCategoryDictionary setValue:@"-1" forKey:START_INDEX_STR];
        
        [locationWiseCategoryDictionary setValue:[NSNumber numberWithBool:false] forKey:OUTLET_ALL];
        [locationWiseCategoryDictionary setValue:[NSNumber numberWithBool:false] forKey:WAREHOUSE_ALL];
        [locationWiseCategoryDictionary setValue:[NSNumber numberWithBool:false] forKey:ISSUE_AND_CLOSE];
        [locationWiseCategoryDictionary setValue:[NSNumber numberWithBool:false] forKey:kNotForDownload];
        [locationWiseCategoryDictionary setValue:[NSNumber numberWithBool:false] forKey:SAVE_STOCK_REPORT];
        [locationWiseCategoryDictionary setValue:[NSNumber numberWithBool:false] forKey:ENFORCE_GENERATE_PO];
        [locationWiseCategoryDictionary setValue:[NSNumber numberWithBool:false] forKey:IS_TOTAL_COUNT_REQUIRED];
        [locationWiseCategoryDictionary setValue:[NSNumber numberWithBool:false] forKey:ZERO_STOCK_CHECK_AT_OUTLET_LEVEL];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:locationWiseCategoryDictionary options: 0 error: &err];
        NSString * getProductsJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@--json product Categories String--",getProductsJsonString);
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.skuServiceDelegate = self;
        [webServiceController getCategoriesByLocation:getProductsJsonString];
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"---- exception while calling callingCategories List ServicesCall ----%@",exception);
        
    } @finally {
        
    }
}


/**
 * @description  handling the success response received from server side....
 * @date         03/04/2017
 * @method       getCategorySuccessResponse:
 * @author       Bhargav.v
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getCategoriesByLocationSuccessResponse:(NSDictionary*)sucessDictionary {
    @try {
        
        for (NSDictionary * categoryDic in [sucessDictionary valueForKey:CATEGORY_LIST]) {
            
            [categoriesArr addObject:categoryDic];
            [checkBoxArr addObject:@"0"];
            
        }
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@---exception in handling the response",exception);
        
    }
    @finally {
        
        [HUD setHidden:YES];
        
        if(categoriesArr.count){
            [self displayCategoriesList:nil];
            [categoriesTbl reloadData];
            
        }
    }
}


/**
 * @description  handling the service call error resposne....
 * @date         03/04/2017
 * @method       getCategoryErrorResponse:
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)getCategoriesByLocationErrorResponse:(NSString*)errorResponse {
    
    @try {
        
        [HUD setHidden:YES];
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2  verticalAxis:y_axis  msgType:@"" conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}



/**
 * @description        here we are displaying the popOver for the CategoriesList ...
 * @requestDteFld      27/09/2016
 * @method             displayCategoriesList
 * @author             Bhargav.v
 * @param              UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */




-(void)displayCategoriesList:(UIButton*)sender{
    
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        PopOverViewController * categoriesPopover = [[PopOverViewController alloc] init];
        
        categoriesView = [[UIView alloc] initWithFrame:CGRectMake(selectCategoriesBtn.frame.origin.x,searchItemsTxt.frame.origin.y,300,350)];
        categoriesView.opaque = NO;
        categoriesView.backgroundColor = [UIColor blackColor];
        categoriesView.layer.borderColor = [[UIColor whiteColor]colorWithAlphaComponent:0.6].CGColor;
        categoriesView.layer.borderWidth =2.0f;
        [categoriesView setHidden:NO];
        
        
        /*Creation of UILabel for headerDisplay.......*/
        //creating line  UILabel which will display at topOfThe  billingView.......
        
        UILabel * headerNameLbl;
        CALayer * bottomBorder;
        UIImage * checkBoxImg;
        UILabel * selectAllLbl;
        UIButton * okButton;
        UIButton * cancelButton;
        
        headerNameLbl = [[UILabel alloc] init];
        headerNameLbl.layer.cornerRadius = 10.0f;
        headerNameLbl.layer.masksToBounds = YES;
        headerNameLbl.text = NSLocalizedString(@"categories_list",nil) ;
        
        headerNameLbl.textAlignment = NSTextAlignmentCenter;
        headerNameLbl.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
        headerNameLbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gradient.png"]];
        headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
        
        //it is regard's to the view borderwidth and color setting....
        bottomBorder = [CALayer layer];
        bottomBorder.opacity = 5.0f;
        bottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        bottomBorder.frame = CGRectMake(0.0f, 60.0f, headerNameLbl.frame.size.width, 1.0f);
        [headerNameLbl.layer addSublayer:bottomBorder];
        
        
        /*Creation of table header's*/
        selectAllCheckBoxBtn = [[UIButton alloc] init];
        checkBoxImg = [UIImage imageNamed:@"checkbox_off_background.png"];
        
        selectAllCheckBoxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [selectAllCheckBoxBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
        [selectAllCheckBoxBtn addTarget:self
                                 action:@selector(changeSelectAllCheckBoxButtonImage:) forControlEvents:UIControlEventTouchDown];
        selectAllCheckBoxBtn.tag = 2;
        
        selectAllLbl = [[UILabel alloc] init];
        selectAllLbl.layer.cornerRadius = 10.0f;
        selectAllLbl.layer.masksToBounds = YES;
        selectAllLbl.text =NSLocalizedString(@"select_all", nil) ;
        selectAllLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
        selectAllLbl.textAlignment = NSTextAlignmentCenter;
        selectAllLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        
        
        //creation of Product menu  table...
        categoriesTbl = [[UITableView alloc] init];
        categoriesTbl.backgroundColor  = [UIColor blackColor];
        categoriesTbl.layer.cornerRadius = 4.0;
        categoriesTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        categoriesTbl.dataSource = self;
        categoriesTbl.delegate = self;
        
        
        okButton = [[UIButton alloc] init] ;
        [okButton setTitle:NSLocalizedString(@"OK",nil) forState:UIControlStateNormal];
        okButton.backgroundColor = [UIColor grayColor];
        okButton.layer.masksToBounds = YES;
        okButton.userInteractionEnabled = YES;
        okButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        okButton.layer.cornerRadius = 5.0f;
        [okButton addTarget:self action:@selector(multipleCategriesSelection:) forControlEvents:UIControlEventTouchDown];
        
        
        cancelButton = [[UIButton alloc] init] ;
        [cancelButton setTitle:NSLocalizedString(@"cancel",nil) forState:UIControlStateNormal];
        cancelButton.backgroundColor = [UIColor grayColor];
        cancelButton.layer.masksToBounds = YES;
        cancelButton.userInteractionEnabled = YES;
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        cancelButton.layer.cornerRadius = 5.0f;
        [cancelButton addTarget:self action:@selector(dismissCategoryPopOver:) forControlEvents:UIControlEventTouchDown];
        
        
        [categoriesView addSubview:headerNameLbl];
        [categoriesView addSubview:selectAllLbl];
        [categoriesView addSubview:selectAllCheckBoxBtn];
        [categoriesView addSubview:categoriesTbl];
        [categoriesView addSubview:okButton];
        [categoriesView addSubview:cancelButton];
        
        
        headerNameLbl.frame = CGRectMake(0,0,categoriesView.frame.size.width,50);
        
        selectAllCheckBoxBtn.frame = CGRectMake(10,headerNameLbl.frame.origin.y+headerNameLbl.frame.size.height+10,30,30);
        
        selectAllLbl.frame = CGRectMake(selectAllCheckBoxBtn.frame.origin.x+selectAllCheckBoxBtn.frame.size.width+10,selectAllCheckBoxBtn.frame.origin.y-5,95,40);
        
        categoriesTbl.frame = CGRectMake(0,selectAllCheckBoxBtn.frame.origin.y+selectAllCheckBoxBtn.frame.size.height+10,categoriesView.frame.size.width,200);
        
        okButton.frame = CGRectMake(selectAllLbl.frame.origin.x,categoriesTbl.frame.origin.y+categoriesTbl.frame.size.height+5,100,40);
        cancelButton.frame = CGRectMake(okButton.frame.origin.x+okButton.frame.size.width+20,categoriesTbl.frame.origin.y+categoriesTbl.frame.size.height+5,100,40);
        
        categoriesPopover.view = categoriesView;
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            categoriesPopover.preferredContentSize =  CGSizeMake(categoriesView.frame.size.width, categoriesView.frame.size.height);
            
            UIPopoverController *popOver = [[UIPopoverController alloc] initWithContentViewController:categoriesPopover];
            
            [popOver presentPopoverFromRect:selectCategoriesBtn.frame inView:createReceiptView permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
            
            categoriesPopOver = popOver;
        }
        
        else {
            
            categoriesPopover.preferredContentSize = CGSizeMake(160.0, 250.0);
            
            UIPopoverController *popOver = [[UIPopoverController alloc] initWithContentViewController:categoriesPopover];
            
            popOver.contentViewController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
            
            categoriesPopOver = popOver;
            
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}


/**
 * @description  we are sending the request to get items for the selected multiple categories.......
 * @date         20/0/2016
 * @method       multipleCategriesSelected
 * @author       Bhargav Ram
 * @param        UIButton
 * @param
 * @return
 
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)multipleCategriesSelection:(UIButton *)sender {
    @try {
        NSMutableArray * catArr = [NSMutableArray new];
        Boolean * selectCategory = true;
        
        if (sender.tag != 2) {
            
            for(int i = 0; i < checkBoxArr.count; i++){
                
                if([checkBoxArr[i] integerValue]){
                    
                    selectCategory = false;
                    
                    NSDictionary * locDic = categoriesArr[i];
                    [catArr addObject:locDic];
                }
                
            }
            
            if (selectCategory) {
                [HUD setHidden:YES];
                [self displayAlertMessage:NSLocalizedString(@"please_select_atleast_one_category", nil) horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:self.view.frame.size.height - 250  msgType:NSLocalizedString(@"warning", nil)  conentWidth:350 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
                
                return;
            }
            
        }
        
        @try {
            [HUD setHidden:NO];
            NSMutableDictionary * priceListDic = [[NSMutableDictionary alloc]init];
            
            priceListDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
            priceListDic[START_INDEX] = NEGATIVE_ONE;
            priceListDic[CATEGORY_LIST] = catArr;
            
            NSError * err;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:priceListDic options:0 error:&err];
            
            NSString * getProductsJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            NSLog(@"%@--json product Categories String--",getProductsJsonString);
            
            WebServiceController * webServiceController = [WebServiceController new];
            webServiceController.skuServiceDelegate = self;
            [webServiceController getPriceListSkuDetails:getProductsJsonString];
            
        }
        @catch (NSException * exception) {
            [HUD setHidden:YES];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"message", nil)  message:NSLocalizedString(@"no_products_found", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
            [alert show];
        }
        
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
}


/**
 * @description  Here we are dismissing the popOver when cancelButton pressed...
 * @date         29/07/2017
 * @method       dismissCategoryPopOver
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)dismissCategoryPopOver:(UIButton*)sender{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    @try {
        [categoriesPopOver dismissPopoverAnimated:YES];
    } @catch (NSException *exception) {
        
    }
}



#pragma -mark actions with service calls response

/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       getPriceListSuccessResponse:
 * @author       Bhargav Ram
 * @param        NSDictionary
 * @param
 * @return
 *
 * @modified BY  Srinivasulu on 17/01/2016
 *
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getPriceListSkuDetailsSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        if (successDictionary != nil) {
            
            int  totalRecords = [[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:TOTAL_SKUS]  defaultReturn:@"0"]intValue];
            
            for(NSDictionary * newSkuItemDic in [successDictionary valueForKey:SKU_LIST]) {
                
                //checking priceList is existing or not....
                if([[newSkuItemDic valueForKey:SKU_PRICE_LIST] count]){
                    
                    for(NSDictionary * newSkuPriceListDic in [newSkuItemDic valueForKey:SKU_PRICE_LIST]){
                        
                        
                        BOOL isExistingItem = false;
                        NSDictionary * existItemdic;
                        int i = 0;
                        
                        for (i = 0; i < requestedItemsInfoArr.count; i++) {
                            
                            //reading the existing cartItem....
                            existItemdic = requestedItemsInfoArr[i];
                            
                            if ([[existItemdic valueForKey:ITEM_SKU] isEqualToString:[newSkuPriceListDic valueForKey:ITEM_SKU]] && [[existItemdic valueForKey:PLU_CODE] isEqualToString:[newSkuPriceListDic valueForKey:PLU_CODE]] ) {
                                
                                 [existItemdic setValue:[NSString stringWithFormat:@"%d",[[existItemdic valueForKey:QUANTITY] intValue] + 1] forKey:QUANTITY];
                                
                                requestedItemsInfoArr[i] = existItemdic;
                                
                                isExistingItem = true;
                                
                                break;
                            }
                        }
                        
//                        if(isExistingItem) {
//
//                            [requestedItemsInfoArr replaceObjectAtIndex:i withObject:existItemdic];
//
//                        }
//                        else{
                        
                        if(!isExistingItem) {

                            NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc ]init];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_SKU];
                            
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:ITEM_SKU] defaultReturn:@""] forKey:kItem];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESCRIPTION];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                            
                            //[itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:AVAILABLE_QTY];
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:QUANTITY];
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:BALANCE_QTY];
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:COST];
                            
                            //setting itemPrice as salePrice...
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:cost_Price] defaultReturn:@""] floatValue]] forKey:ITEM_UNIT_PRICE];
                            
                            //setting kSupplied for the rejectedQty key...
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:kSupplied] defaultReturn:@""] floatValue]] forKey:kSupplied];
                            
                            //setting kRejected for the rejectedQty key...
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:kSupplied] defaultReturn:@""] floatValue]] forKey:kRejected];
                            
                            
                            //setting kReceived for the rejectedQty key...
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:kReceived] defaultReturn:@""] floatValue]] forKey:kReceived];
                            
                            //setting kMaxQuantity for the kMaxQuantity key...
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:kMaxQuantity] defaultReturn:@""] floatValue]] forKey:kMaxQuantity];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:kProductBrand] defaultReturn:@""] forKey:kBrand];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:kcategory] defaultReturn:@""] forKey:kcategory];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
                            
                            // CAlling from the main Dictionary....
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:MAKE] defaultReturn:@""] forKey:MAKE];
                            
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:QUANTITY_IN_HAND] defaultReturn:@""] floatValue]] forKey:AVAILABLE_QTY];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:TRACKING_REQUIRED] defaultReturn:ZERO_CONSTANT] forKey:TRACKING_REQUIRED];
                            
                            [itemDetailsDic setValue:EMPTY_STRING forKey:ITEM_SCAN_CODE];
                            
                            // keys added by roja on  27-08-2018.....
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:UTILITY] defaultReturn:@" "] forKey:UTILITY];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];
                            
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:ISSUED];
                            
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:INDENT_QTY];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:kMeasureRange] defaultReturn:@""] forKey:MEASUREMENT_RANGE];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:EAN] defaultReturn:@""] forKey:EAN];
                            // upto here on  27-08-2018.....
                            
                            [requestedItemsInfoArr addObject:itemDetailsDic];
                        }
                    }
                }
                else{
                    
                    BOOL isExistingItem = false;
                    NSDictionary * existItemdic;
                    int i = 0;
                    
                    for ( i=0; i < requestedItemsInfoArr.count; i++) {
                        
                        //reading the existing cartItem....
                        existItemdic = requestedItemsInfoArr[i];
                        
                        if ([[existItemdic valueForKey:ITEM_SKU] isEqualToString:[newSkuItemDic valueForKey:ITEM_SKU]] && [[existItemdic valueForKey:PLU_CODE] isEqualToString:[newSkuItemDic valueForKey:PLU_CODE]]) {
                            
                            [existItemdic setValue:[NSString stringWithFormat:@"%d",[[existItemdic valueForKey:QUANTITY] intValue] + 1] forKey:QUANTITY];
                            
                            requestedItemsInfoArr[i] = existItemdic;
                            
                            isExistingItem = true;
                            
                            break;
                        }
                    }
                    
//                    if(isExistingItem) {
//
//                        [existItemdic setValue:[NSString stringWithFormat:@"%d",[[existItemdic valueForKey:QUANTITY] intValue] + 1] forKey:QUANTITY];
//
//                        [requestedItemsInfoArr replaceObjectAtIndex:i withObject:existItemdic];
//                    }
//                    else{
                    
                    if(!isExistingItem) {
                        
                        NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc ]init];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_SKU];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:ITEM_SKU] defaultReturn:@""] forKey:kItem];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
                        
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESCRIPTION];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                        
                        //[itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:AVAILABLE_QTY];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:QUANTITY];
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:BALANCE_QTY];
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:COST];
                        
                        //setting itemPrice as salePrice...
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:cost_Price] defaultReturn:@""] floatValue]] forKey:ITEM_UNIT_PRICE];
                        
                        //setting kSupplied for the rejectedQty key...
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:kSupplied] defaultReturn:@""] floatValue]] forKey:kSupplied];
                        
                        //setting kRejected for the rejectedQty key...
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:kSupplied] defaultReturn:@""] floatValue]] forKey:kRejected];
                        
                        //setting kReceived for the rejectedQty key...
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:kReceived] defaultReturn:@""] floatValue]] forKey:kReceived];
                        
                        //setting kMaxQuantity for the kMaxQuantity key...
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:kMaxQuantity] defaultReturn:@""] floatValue]] forKey:kMaxQuantity];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:kProductBrand] defaultReturn:@""] forKey:kBrand];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:kcategory] defaultReturn:@""] forKey:kcategory];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
                        
                        // Calling from the main Dictionary....
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:MAKE] defaultReturn:@""] forKey:MAKE];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:QUANTITY_IN_HAND] defaultReturn:@""] floatValue]] forKey:AVAILABLE_QTY];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:TRACKING_REQUIRED] defaultReturn:ZERO_CONSTANT] forKey:TRACKING_REQUIRED];
                        
                        [itemDetailsDic setValue:EMPTY_STRING forKey:ITEM_SCAN_CODE];
                        
                        // keys added by roja on  27-08-2018.....
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:UTILITY] defaultReturn:@" "] forKey:UTILITY];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:ISSUED];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:INDENT_QTY];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:kMeasureRange] defaultReturn:@""] forKey:MEASUREMENT_RANGE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:EAN] defaultReturn:@""] forKey:EAN];
                        // upto here on  27-08-2018.....
                        
                        [requestedItemsInfoArr addObject:itemDetailsDic];
                    }
                }
            }
            
            float y_axis = self.view.frame.size.height - 120;
            
            if(searchItemsTxt.isEditing)
                y_axis = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height;
            
            NSString * mesg = [NSString stringWithFormat:@"%d%@",totalRecords,NSLocalizedString(@"records_are_added_to_the_cart_successfully",nil) ];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"cart_records",nil) conentWidth:400 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            
            [self calculateTotal];
        }
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
        [requestedItemsTbl reloadData];
        [categoriesPopOver dismissPopoverAnimated:YES];
    }
}


/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       getSkuDetailsFailureResponse:
 * @author       Bhargav Ram
 * @param       NSString
 * @param
 * @return
 *
 * @modified BY  Srinivasulu on 17/01/2016
 *
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getPriceListSKuDetailsErrorResponse:(NSString *)errorResponse {
    @try {
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 350;
        
        if(searchItemsTxt.isEditing)
            y_axis = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height;
        
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [HUD setHidden:YES];
    }
}

#pragma  -mark action used to change checkBoxs images....

/**
 * @description  here we are showing the list of requestedItems.......
 * @date         20/09/2016
 * @method       changeCheckBoxImages:
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)changeCheckBoxImages:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if( [checkBoxArr[sender.tag] integerValue])
            checkBoxArr[sender.tag] = @"0";
        
        else
            checkBoxArr[sender.tag] = @"1";
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [categoriesTbl reloadData];
    }
}


/**
 * @description  here we are showing the list of requestedItems.......
 * @date         20/09/2016
 * @method       changeCheckBoxImage;
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)changeSelectAllCheckBoxButtonImage:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if(categoriesArr.count){
            
            UIImage * checkBoxImg = [UIImage imageNamed:@"checkbox_off_background.png"];
            
            if(selectAllCheckBoxBtn.tag == 2){
                
                for(int i = 0; i < checkBoxArr.count; i++){
                    
                    checkBoxArr[i] = @"1";
                }
                
                checkBoxImg = [UIImage imageNamed:@"checkbox_on_background.png"];
                
                [selectAllCheckBoxBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
                selectAllCheckBoxBtn.tag = 4;
                
            }
            else{
                
                for(int i = 0; i < checkBoxArr.count; i++){
                    
                    checkBoxArr[i] = @"0";
                }
                
                [selectAllCheckBoxBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
                
                selectAllCheckBoxBtn.tag = 2;
            }
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [categoriesTbl reloadData];
        
    }
}



#pragma mark populating the methods:

#pragma -mark used to display calender....

/**
 * @description  in this method we will show the calender in popUp....
 * @method       selectrequiredDate:
 * @author
 * @param        UIButton
 * @param
 * @return
 * @verified By

 * @reason      added comments....
 *
 */

-(void)selectrequiredDate:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        PopOverViewController  * customerInfoPopUp = [[PopOverViewController alloc] init];
        
        UIView * customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0,320,320)];
        customView.opaque = NO;
        customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customView.layer.borderWidth = 2.0f;
        [customView setHidden:NO];
        
        pickView = [[UIView alloc] init];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            pickView.frame = CGRectMake(15, issueDateTxt.frame.origin.y+issueDateTxt.frame.size.height, 320, 320);
            
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
            
            
            //            issueDte.tag = 1;
            //            dlvryDte.tag = 2;
            //            requstDte.tag = 3;
            //
            
            
            issueDateTxt.tag = 0;
            deliveryDteTxt.tag = 0;
            requestDateTxt.tag = 0;
            
            if(sender.tag == 1){
                [popover presentPopoverFromRect:issueDateTxt.frame inView:createReceiptView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
                
                issueDateTxt.tag = 0;
                deliveryDteTxt.tag = 0;
                requestDateTxt.tag = 0;
            }
            else  if(sender.tag == 2)
            {
                [popover presentPopoverFromRect:deliveryDteTxt.frame inView:createReceiptView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
                
                issueDateTxt.tag = 0;
                deliveryDteTxt.tag = 0;
                requestDateTxt.tag = 0;
            }
            else
            {
                issueDateTxt.tag = 0;
                deliveryDteTxt.tag = 0;
                requestDateTxt.tag = 0;
                
                [popover presentPopoverFromRect:requestDateTxt.frame inView:createReceiptView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
                
            }
            catPopOver = popover;
        }
        
        else {
            
            customerInfoPopUp.preferredContentSize = CGSizeMake(160.0, 250.0);
            
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
        
    } @finally {
        
    }
    
}



/**
 * @description  in this method we will populate the date into the textFields....
 * @method       populateDateToTextField:
 * @author
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 13/04/2017...
 * @reason      added comments and added validations....
 *
 */


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
        
        if(  sender.tag == 1){
            
            
            if ((deliveryDteTxt.text).length != 0 && ( ![deliveryDteTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:deliveryDteTxt.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedDescending) {
                    
                    
                    
                    [self displayAlertMessage:NSLocalizedString(@"issue_date_should_be_earlier_than_delivered_date", nil) horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
                    
                    return;
                    
                    
                    
                }
            }
            
            if ((requestDateTxt.text).length != 0 && ( ![requestDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:requestDateTxt.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    
                    [self displayAlertMessage:NSLocalizedString(@"issue_date_should_not_be_earlier_than_requested_date", nil) horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
                    
                    return;
                    
                    
                    
                }
            }
            
            issueDateTxt.text = dateString;
            
        }
        else if (sender.tag == 2)   {
            
            if ((requestDateTxt.text).length != 0 && ( ![requestDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:requestDateTxt.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    
                    [self displayAlertMessage:NSLocalizedString(@"delivered_date_should_not_be_earlier_than_requested_date", nil) horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
                    
                    return;
                    
                }
            }
            
            if ((issueDateTxt.text).length != 0 && ( ![issueDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:issueDateTxt.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    
                    [self displayAlertMessage:NSLocalizedString(@"delivered_date_should_not_be_earlier_than_issue_date", nil) horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
                    
                    return;
                    
                    
                    
                }
            }
            
            
            
            deliveryDteTxt.text = dateString;
            
        }
        else if (sender.tag == 3) {
            
            
            if ((issueDateTxt.text).length != 0 && ( ![issueDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:issueDateTxt.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedDescending) {
                    
                    
                    [self displayAlertMessage:NSLocalizedString(@"requested_date_should_be_earlier_than_issue_date", nil) horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
                    
                    return;
                    
                    
                    
                }
            }
            
            
            if ((deliveryDteTxt.text).length != 0 && ( ![deliveryDteTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:deliveryDteTxt.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedDescending) {
                    
                    
                    
                    [self displayAlertMessage:NSLocalizedString(@"requested_date_should_be_earlier_than_delivered_date", nil) horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
                    
                    return;
                    
                    
                    
                }
            }
            
            
            requestDateTxt.text = dateString;
            
        }
        
    } @catch (NSException *exception) {
        
    }
    @finally{
        
        @try {
            
            
        }
        @catch (NSException *exception) {
            
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
-(void)populateLocationsTable:(UIButton *)sender {
    
    //play audio for button touch...
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        if(((locationArr == nil)  && (!locationArr.count))){
            
            [self getLocations:selectIndex businessActivity:RETAIL_OUTLET];
        }
        
        if(locationArr.count){
            float tableHeight = locationArr.count * 40;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = locationArr.count * 33;
            
            if(locationArr.count > 5)
                tableHeight = (tableHeight/locationArr.count) * 5;
            
            [self showPopUpForTables:locationTable  popUpWidth:(toStoreCodeTxt.frame.size.width *1.5) popUpHeight:tableHeight presentPopUpAt:toStoreCodeTxt  showViewIn:createReceiptView permittedArrowDirections:UIPopoverArrowDirectionUp];
        }
        else
            [catPopOver dismissPopoverAnimated:YES];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  Yet To Implement this method(present we are dismissing the popover).
 * @date         1/08/2017
 * @method       AddMultipleLocations
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)AddMultipleLocations:(UIButton*)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        multipleIssuesView.hidden = YES;
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}


/**
 * @description  here we are showing the list of requestedItems.......
 * @date         20/09/2016
 * @method       changeLocationCheckBoxImages:
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)changeLocationCheckBoxImages:(UIButton *)sender {
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        @try {
            
            if( [locationCheckBoxArr[sender.tag] integerValue])
                locationCheckBoxArr[sender.tag] = @"0";
            
            else
                locationCheckBoxArr[sender.tag] = @"1";
            
            if ([locationCheckBoxArr containsObject:@"0"]) {
                
                toStoreCodeTxt.text = locationArr[sender.tag];
            }
            
        } @catch (NSException *exception) {
            
        } @finally {
            
            [locationTable reloadData];
            
        }
    }
  
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


@end



