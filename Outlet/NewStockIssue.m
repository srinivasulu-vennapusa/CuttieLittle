
//  NewStockIssue.m
//  OmniRetailer

//  Created by Chandrasekhar on 11/1/16.


#import "NewStockIssue.h"
#import "OmniHomePage.h"
#import "MaterialTransferIssue.h"

@interface NewStockIssue ()

@end

@implementation NewStockIssue

@synthesize soundFileURLRef,soundFileObject;

@synthesize IssueId,isOpen,selectIndex,selectSectionIndex;

#pragma  -mark start of ViewLifeCycle mehods....

/**
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date         28/06/2017
 * @method       ViewDidLoad
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @modified By 
 * @reason
 *
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //reading the DeviceVersion....
    version = [UIDevice currentDevice].systemVersion.floatValue;
    
    //here we reading the DeviceOrientaion....
    currentOrientation = [UIDevice currentDevice].orientation;
    
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
   
    HUD.labelText = NSLocalizedString(@"please_wait..", nil);
    // Show the HUD
    //[HUD show:NO];
    
    //creating the stockRequestView which will displayed completed Screen.......
    stockIssueView = [[UIView alloc] init];
    stockIssueView.backgroundColor = [UIColor blackColor];
    stockIssueView.layer.borderWidth = 1.0f;
    stockIssueView.layer.cornerRadius = 10.0f;
    stockIssueView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    /*Creation of UILabel for headerDisplay.......*/
    //creating line  UILabel which will display at topOfThe  billingView.......
    UILabel * headerNameLbl;
    CALayer * bottomBorder;
    
    //headerNameLbl used to identify the flow....
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
    
    /*Creation of UIButton for providing user to select the dates.......*/
    UIButton * summaryInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage * summaryImage = [UIImage imageNamed:@"summaryInfo.png"];
    [summaryInfoBtn setBackgroundImage:summaryImage forState:UIControlStateNormal];
    [summaryInfoBtn addTarget:self action:@selector(populateSumaryInfo) forControlEvents:UIControlEventTouchDown];
//    summaryInfoBtn.hidden = YES;
    
    /** creation of UITextField*/
    currentLocationTxt = [[CustomTextField alloc] init];
    currentLocationTxt.placeholder = NSLocalizedString(@"po_ref", nil);
    currentLocationTxt.delegate = self;
    currentLocationTxt.userInteractionEnabled = NO;
    [currentLocationTxt awakeFromNib];
    
    shipmentRefNoTxt = [[CustomTextField alloc] init];
    shipmentRefNoTxt.placeholder = NSLocalizedString(@"shipment_ref_no", nil);
    shipmentRefNoTxt.delegate = self;
    [shipmentRefNoTxt awakeFromNib];
    
    // getting present date & time ..
    NSDate *today = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"dd/MM/yyyy";
    NSString * currentdate = [f stringFromDate:today];
    
    issueDateTxt = [[CustomTextField alloc] init];
    issueDateTxt.placeholder = NSLocalizedString(@"issue_date", nil);
    issueDateTxt.delegate = self;
    issueDateTxt.userInteractionEnabled = YES;
    issueDateTxt.text = currentdate;
    [issueDateTxt awakeFromNib];
    
    UIImage * issueDteImg  = [UIImage imageNamed:@"Calandar_Icon.png"];
    
    UIButton * issueDte = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [issueDte setBackgroundImage:issueDteImg forState:UIControlStateNormal];
    [issueDte addTarget:self
                  action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    issueDte.userInteractionEnabled = YES;
    
    toStoreCodeTxt = [[CustomTextField alloc] init];
    toStoreCodeTxt.placeholder = NSLocalizedString(@"toLocation",nil);
    toStoreCodeTxt.delegate = self;
    toStoreCodeTxt.userInteractionEnabled =NO;
    [toStoreCodeTxt awakeFromNib];
    
    UIImage * locationImg  = [UIImage imageNamed:@"arrow_1.png"];
    
    UIButton * toStoreLoction = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [toStoreLoction setBackgroundImage:locationImg forState:UIControlStateNormal];
    [toStoreLoction addTarget:self
                       action:@selector(populateLocationsTable:) forControlEvents:UIControlEventTouchDown];
    
    issuedByTxt = [[CustomTextField alloc] init];
    issuedByTxt.placeholder = NSLocalizedString(@"issued_by", nil);
    issuedByTxt.delegate = self;
    [issuedByTxt awakeFromNib];
    issuedByTxt.text = firstName;
    
    carriedByTxt = [[CustomTextField alloc] init];
    carriedByTxt.placeholder = NSLocalizedString(@"carried_by", nil);
    carriedByTxt.delegate = self;
    [carriedByTxt awakeFromNib];
    
    requestRefNoTxt = [[CustomTextField alloc] init];
    requestRefNoTxt.placeholder = NSLocalizedString(@"request_ref_no", nil);
    requestRefNoTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    requestRefNoTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    requestRefNoTxt.delegate = self;
    [requestRefNoTxt awakeFromNib];
    [requestRefNoTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    reqeustDateTxt = [[CustomTextField alloc] init];
    reqeustDateTxt.placeholder = NSLocalizedString(@"request_date", nil);
    reqeustDateTxt.delegate = self;
    reqeustDateTxt.userInteractionEnabled = NO;
    [reqeustDateTxt awakeFromNib];
    
    UIImage * reqstDteImg  = [UIImage imageNamed:@"Calandar_Icon.png"];
    
    UIButton * requstDte = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [requstDte setBackgroundImage:reqstDteImg forState:UIControlStateNormal];
    [requstDte addTarget:self
                  action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    
    requestedByTxt = [[CustomTextField alloc] init];
    requestedByTxt.placeholder = NSLocalizedString(@"requested_by", nil);
    requestedByTxt.delegate = self;
    [requestedByTxt awakeFromNib];
    
    shipmentModeTxt = [[CustomTextField alloc] init];
    shipmentModeTxt.placeholder = NSLocalizedString(@"shipment_mode", nil);
    shipmentModeTxt.delegate = self;
    shipmentModeTxt.userInteractionEnabled = NO;
    [shipmentModeTxt awakeFromNib];
    
    UIImage * shipmentImg  = [UIImage imageNamed:@"arrow_1.png"];
    
    UIButton * shipmentMode = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [shipmentMode setBackgroundImage:shipmentImg forState:UIControlStateNormal];
    [shipmentMode addTarget:self
                       action:@selector(getShipmentModes:) forControlEvents:UIControlEventTouchDown];
    
    pickUpByTxt = [[CustomTextField alloc] init];
    pickUpByTxt.placeholder = NSLocalizedString(@"pick_up_by",nil);
    pickUpByTxt.delegate = self;
    [pickUpByTxt awakeFromNib];
    
    deliveredDateTxt = [[CustomTextField alloc] init];
    deliveredDateTxt.placeholder = NSLocalizedString(@"delivery_Date",nil);
    deliveredDateTxt.delegate = self;
    deliveredDateTxt.userInteractionEnabled = NO;
    [deliveredDateTxt awakeFromNib];
    
    UIImage * dlvrImg  = [UIImage imageNamed:@"Calandar_Icon.png"];
    
    UIButton * dlvryDte = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [dlvryDte setBackgroundImage:dlvrImg forState:UIControlStateNormal];
    [dlvryDte addTarget:self
                 action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    dlvryDte.userInteractionEnabled =YES;

    //Creation of SearchItemsTxt UITextField.......
    searchItemsTxt = [[CustomTextField alloc] init];
    searchItemsTxt.placeholder = NSLocalizedString(@"Search_Sku_Here",nil);
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
    
    // creartion of UIScroll View...
    
    stockIssueScrollView = [[UIScrollView alloc] init];
    //stockIssueScrollView.backgroundColor = [UIColor lightGrayColor];
    
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

    requestedQtyLabel = [[CustomLabel alloc]init];
    [requestedQtyLabel awakeFromNib];
    
    scanCodeLabel = [[CustomLabel alloc] init];
    [scanCodeLabel awakeFromNib];
    
    stockQtyLbl = [[CustomLabel alloc] init];
    [stockQtyLbl awakeFromNib];
    
    issueQtyLbl = [[CustomLabel alloc] init];
    [issueQtyLbl awakeFromNib];
    
    balanceQtyLbl = [[CustomLabel alloc] init];
    [balanceQtyLbl awakeFromNib];
    
    make_Lbl = [[CustomLabel alloc] init];
    [make_Lbl awakeFromNib];
    
    actionLbl = [[CustomLabel alloc] init];
    [actionLbl awakeFromNib];
    
    //Allocation of productListTbl...
    productListTbl = [[UITableView alloc] init];
    
    //Allocation of requestedItemsTbl..
    requestedItemsTbl = [[UITableView alloc] init];
    requestedItemsTbl.backgroundColor  = [UIColor blackColor];
    requestedItemsTbl.layer.cornerRadius = 4.0;
    requestedItemsTbl.dataSource = self;
    requestedItemsTbl.delegate = self;
    requestedItemsTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    //allocation of shipmentModeTable....
    shipModeTable = [[UITableView alloc] init];

    //creation of Labels for the item calculation
    UILabel * line_;
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
    totalIssuesValueLbl.textColor = [UIColor whiteColor];
    
    totalSaleCostValueCost = [[UILabel alloc] init];
    totalSaleCostValueCost.layer.masksToBounds = YES;
    totalSaleCostValueCost.numberOfLines = 2;
    totalSaleCostValueCost.textColor = [UIColor whiteColor];
    
    //Recently Added Labels For making the totals of stock quantity
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
    
    priceValueLbl.text      = @"0.0";
    stockQtyValueLbl.text   = @"0.0";
    issueQtyValueLbl.text   = @"0.0";
    balanceQtyValueLbl.text = @"0.0";
    
    priceValueLbl.textAlignment      = NSTextAlignmentCenter;
    stockQtyValueLbl.textAlignment   = NSTextAlignmentCenter;
    issueQtyValueLbl.textAlignment   = NSTextAlignmentCenter;
    balanceQtyValueLbl.textAlignment = NSTextAlignmentCenter;
    
   //end of calculations....
    
    submitBtn = [[UIButton alloc] init];
    [submitBtn addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchDown];
    submitBtn.layer.cornerRadius = 3.0f;
    submitBtn.backgroundColor = [UIColor grayColor];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.userInteractionEnabled = YES;
    submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    //submitBtn.tag = 2;
    
    submitBtn.tag = 4;

    saveBtn = [[UIButton alloc] init] ;
    saveBtn.backgroundColor = [UIColor grayColor];
    saveBtn.layer.masksToBounds = YES;
    saveBtn.userInteractionEnabled = YES;
    saveBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    saveBtn.layer.cornerRadius = 3.0f;
    [saveBtn addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchDown];
    saveBtn.tag = 2;
    
    cancelBtn = [[UIButton alloc] init];
    [cancelBtn addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchDown];
    cancelBtn.layer.cornerRadius = 3.0f;
    cancelBtn.backgroundColor = [UIColor grayColor];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
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
    priceLbl.text = NSLocalizedString(@"price", nil);
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
    [selectCategoriesBtn addTarget:self action:@selector(validatingCategoriesList:) forControlEvents:UIControlEventTouchDown];
    
    // Allocation of  UIView For multipleStoresTransparentView.....
    multipleStoresTransparentView = [[UIView alloc]init];
    multipleStoresTransparentView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6f];
    multipleStoresTransparentView.hidden = YES;
    
    multipleIssuesView = [[UIView alloc] init];
    multipleIssuesView.backgroundColor = [UIColor blackColor];
    multipleIssuesView.layer.borderColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7].CGColor;
    multipleIssuesView.layer.borderWidth = 1.0;
    multipleIssuesView.layer.cornerRadius = 3.0f;
    //multipleIssuesView.hidden = YES;
    
    /*Creation of UILabel for headerDisplay.......*/
    //creating line  UILabel which will display at topOfThe billingView.......
    UILabel  * locationHeaderNameLbl;
    CALayer  * locationbottomBorder;
    UIButton * cancelButton;
    UIButton * selectMultipleStoresBtn;
    
    //headerNameLbl used to identify the flow....
    locationHeaderNameLbl = [[UILabel alloc] init];
    locationHeaderNameLbl.layer.cornerRadius = 10.0f;
    locationHeaderNameLbl.layer.masksToBounds = YES;
    
    locationHeaderNameLbl.textAlignment = NSTextAlignmentCenter;
    locationHeaderNameLbl.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
    locationHeaderNameLbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gradient.png"]];
    
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
    
    cancelButton = [[UIButton alloc] init] ;
    //cancelButton.backgroundColor = [UIColor grayColor];
    cancelButton.layer.masksToBounds = YES;
    cancelButton.userInteractionEnabled = YES;
    cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    //cancelButton.layer.cornerRadius = 5.0f;
    [cancelButton addTarget:self action:@selector(AddMultipleLocations:) forControlEvents:UIControlEventTouchDown];

    selectMultipleStoresBtn = [[UIButton alloc] init] ;
    //selectMultipleStoresBtn.backgroundColor = [UIColor grayColor];
    selectMultipleStoresBtn.layer.masksToBounds = YES;
    selectMultipleStoresBtn.userInteractionEnabled = YES;
    selectMultipleStoresBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    //selectMultipleStoresBtn.layer.cornerRadius = 5.0f;
    [selectMultipleStoresBtn addTarget:self action:@selector(AddMultipleLocations:) forControlEvents:UIControlEventTouchDown];
    
    [cancelButton setTitle:NSLocalizedString(@"cancel",nil) forState:UIControlStateNormal];
    [selectMultipleStoresBtn setTitle:NSLocalizedString(@"ok",nil) forState:UIControlStateNormal];

    [cancelButton setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [selectMultipleStoresBtn setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0] forState:UIControlStateNormal];

    //allocation of RequestReference Table..
    reqRefTable = [[UITableView alloc]init];

    @try {        //setting title label text....
        self.titleLabel.text = NSLocalizedString(@"omni_retailer", nil);
        
        //setting the titleName for the Page....
        
       headerNameLbl.text = NSLocalizedString(@"new_stock_issue",nil);
        @try {
            currentLocationTxt.text = [NSString stringWithFormat:@"%@%@",@"  ",presentLocation];
        }
        @catch (NSException *exception) {
            
        }
        locationHeaderNameLbl.text = NSLocalizedString(@"select_stores",nil);

        sNoLbl.text = NSLocalizedString(@"S_NO", nil);
        skuIdLbl.text = NSLocalizedString(@"sku_id", nil);
        descriptionLbl.text = NSLocalizedString(@"item_desc", nil);
        uomLbl.text = NSLocalizedString(@"uom", nil);
        rangeLbl.text = NSLocalizedString(@"range", nil);
        gradeLbl.text = NSLocalizedString(@"grade", nil);
        priceLabel.text = NSLocalizedString(@"price", nil);
        requestedQtyLabel.text = NSLocalizedString(@"req_qty",nil);
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

        [submitBtn setTitle:NSLocalizedString(@"submit",nil) forState:UIControlStateNormal];
        [saveBtn setTitle:NSLocalizedString(@"save", nil) forState:UIControlStateNormal];
        [cancelBtn setTitle:NSLocalizedString(@"cancel", nil) forState:UIControlStateNormal];
    }
    @catch (NSException *excpetion) {
        
    }
    
    [stockIssueView addSubview:headerNameLbl];
    [stockIssueView addSubview:summaryInfoBtn];
    
    [stockIssueView addSubview:currentLocationTxt];
    [stockIssueView addSubview:shipmentRefNoTxt];
    [stockIssueView addSubview:issueDateTxt];
    [stockIssueView addSubview:issueDte];
    
    [stockIssueView addSubview:toStoreCodeTxt];
    [stockIssueView addSubview:toStoreLoction];
    
    [stockIssueView addSubview:issuedByTxt];
    [stockIssueView addSubview:carriedByTxt];
    [stockIssueView addSubview:requestRefNoTxt];
    [stockIssueView addSubview:reqeustDateTxt];
    [stockIssueView addSubview:requstDte];
    [stockIssueView addSubview:requestedByTxt];
    [stockIssueView addSubview:shipmentModeTxt];
    [stockIssueView addSubview:shipmentMode];
    [stockIssueView addSubview:pickUpByTxt];
    [stockIssueView addSubview:deliveredDateTxt];
    [stockIssueView addSubview:dlvryDte];

    [stockIssueView addSubview:searchItemsTxt];
    [stockIssueView addSubview:selectCategoriesBtn];

    [stockIssueScrollView addSubview:sNoLbl];
    [stockIssueScrollView addSubview:skuIdLbl];
    [stockIssueScrollView addSubview:descriptionLbl];
    [stockIssueScrollView addSubview:uomLbl];
    [stockIssueScrollView addSubview:rangeLbl];
    [stockIssueScrollView addSubview:gradeLbl];
    [stockIssueScrollView addSubview:priceLabel];
    
    //Added on 03/06/2018..
    //New fields at Item Level..
    [stockIssueScrollView addSubview:requestedQtyLabel];
    [stockIssueScrollView addSubview:scanCodeLabel];
    
    [stockIssueScrollView addSubview:stockQtyLbl];
    [stockIssueScrollView addSubview:issueQtyLbl];
    [stockIssueScrollView addSubview:balanceQtyLbl];
    [stockIssueScrollView addSubview:make_Lbl];
    [stockIssueScrollView addSubview:actionLbl];
    [stockIssueScrollView addSubview:requestedItemsTbl];
    
    [stockIssueView addSubview:priceValueLbl];
    [stockIssueView addSubview:stockQtyValueLbl];
    [stockIssueView addSubview:issueQtyValueLbl];
    [stockIssueView addSubview:balanceQtyValueLbl];

    
//    [stockIssueView addSubview:line_];
//    [stockIssueView addSubview:totalIsuesLbl];
    [stockIssueView addSubview:totalIssuesValueLbl];
    
//    [stockIssueView addSubview:totalSaleCostLbl];
    [stockIssueView addSubview:totalSaleCostValueCost];
//    [stockIssueView addSubview:line_2];

    [stockIssueView addSubview:submitBtn];
    [stockIssueView addSubview:saveBtn];
    [stockIssueView addSubview:cancelBtn];
    
    //    adding price list view for the stock Issue View
    
    [priceView addSubview:priceLbl];
    [priceView addSubview:mrpLbl];
    [priceView addSubview:descLabl];
    [priceView addSubview:priceTable];
    [transparentView addSubview:priceView];
    [transparentView addSubview:closeBtn];
    
    
    [stockIssueView addSubview:stockIssueScrollView];
    [stockIssueView addSubview:productListTbl];
    
    
    //Adding UIview for the multipleIssue...
    [multipleStoresTransparentView addSubview:multipleIssuesView];
    [multipleIssuesView addSubview:locationTable];
    [multipleIssuesView addSubview:locationHeaderNameLbl];
    [multipleIssuesView addSubview:locationCloseBtn];
    [multipleIssuesView addSubview:selectMultipleStoresBtn];
    [multipleIssuesView addSubview:cancelButton];

    [self.view addSubview:stockIssueView];
    [self.view addSubview:transparentView];
    [self.view addSubview:multipleStoresTransparentView];
  
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
        }
        else{
            
        }
        self.view.frame = CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
        
        // setting frame for the stockIssueView...
        stockIssueView.frame = CGRectMake(2,70,self.view.frame.size.width-4,self.view.frame.size.height-80);
        
        // setting frame for the Header Name Label...
        headerNameLbl.frame = CGRectMake(0,0,stockIssueView.frame.size.width,45);
        
        //setting below labe's frame.......
        float labelWidth =  180;
        float textFieldHeight = 40;
        
        //float vertical_Gap_for_labels = 10;
        float vertical_Gap_for_TextFiels = 20;
        float horzantial_Gap = 25;
        
        summaryInfoBtn.frame = CGRectMake(stockIssueView.frame.size.width-40,headerNameLbl.frame.origin.y + headerNameLbl.frame.size.height+5,35,30);
        summaryInfoBtn.hidden = YES;
        
        //first Column.......
        currentLocationTxt.frame =  CGRectMake(10,headerNameLbl.frame.origin.y + headerNameLbl.frame.size.height + 10,labelWidth,textFieldHeight);
        
        toStoreCodeTxt.frame = CGRectMake(currentLocationTxt.frame.origin.x,currentLocationTxt.frame.origin.y+ currentLocationTxt.frame.size.height+vertical_Gap_for_TextFiels,currentLocationTxt.frame.size.width, currentLocationTxt.frame.size.height);
        
        //Second Column....
        deliveredDateTxt.frame = CGRectMake(currentLocationTxt.frame.origin.x+currentLocationTxt.frame.size.width + horzantial_Gap,currentLocationTxt.frame.origin.y,currentLocationTxt.frame.size.width, currentLocationTxt.frame.size.height);
        
        reqeustDateTxt.frame = CGRectMake(deliveredDateTxt.frame.origin.x,toStoreCodeTxt.frame.origin.y,currentLocationTxt.frame.size.width, currentLocationTxt.frame.size.height);
        
        //Third Column....
        requestRefNoTxt.frame =  CGRectMake(deliveredDateTxt.frame.origin.x+deliveredDateTxt.frame.size.width + horzantial_Gap, currentLocationTxt.frame.origin.y,currentLocationTxt.frame.size.width, currentLocationTxt.frame.size.height);
        
        issueDateTxt.frame =  CGRectMake(requestRefNoTxt.frame.origin.x,toStoreCodeTxt.frame.origin.y, currentLocationTxt.frame.size.width,currentLocationTxt.frame.size.height);
        
        //fourth Column.......
        shipmentModeTxt.frame =  CGRectMake(requestRefNoTxt.frame.origin.x + requestRefNoTxt.frame.size.width + horzantial_Gap,currentLocationTxt.frame.origin.y,currentLocationTxt.frame.size.width, currentLocationTxt.frame.size.height);
        
        shipmentRefNoTxt.frame = CGRectMake(shipmentModeTxt.frame.origin.x,shipmentModeTxt.frame.origin.y+ shipmentModeTxt.frame.size.height+vertical_Gap_for_TextFiels,currentLocationTxt.frame.size.width, currentLocationTxt.frame.size.height);
        
        issuedByTxt.frame =  CGRectMake(shipmentModeTxt.frame.origin.x + shipmentModeTxt.frame.size.width + horzantial_Gap,shipmentModeTxt.frame.origin.y,currentLocationTxt.frame.size.width,currentLocationTxt.frame.size.height);

        carriedByTxt.frame =  CGRectMake(issuedByTxt.frame.origin.x,shipmentRefNoTxt.frame.origin.y, currentLocationTxt.frame.size.width,currentLocationTxt.frame.size.height);
        
        //Frames for the UIButtons....
        
        toStoreLoction.frame = CGRectMake((toStoreCodeTxt.frame.origin.x+toStoreCodeTxt.frame.size.width-45), toStoreCodeTxt.frame.origin.y-8,55,60);
        
        issueDte.frame = CGRectMake((issueDateTxt.frame.origin.x+issueDateTxt.frame.size.width-45),issueDateTxt.frame.origin.y+2,40,35);

        dlvryDte.frame = CGRectMake((deliveredDateTxt.frame.origin.x+deliveredDateTxt.frame.size.width-45), deliveredDateTxt.frame.origin.y+2,40,35);

        requstDte.frame = CGRectMake((reqeustDateTxt.frame.origin.x+reqeustDateTxt.frame.size.width-45), reqeustDateTxt.frame.origin.y+2,40,35);
        
        shipmentMode.frame = CGRectMake((shipmentModeTxt.frame.origin.x+shipmentModeTxt.frame.size.width-45), shipmentModeTxt.frame.origin.y-8, 55, 60);
        
        //setting the searchItemsTxt frame.......
        searchItemsTxt.frame = CGRectMake(currentLocationTxt.frame.origin.x,issueDateTxt.frame.origin.y + issueDateTxt.frame.size.height+20,(issuedByTxt.frame.origin.x+issuedByTxt.frame.size.width - currentLocationTxt.frame.origin.x-80),40);
        
        //setting the selectCategoriesBtn frame.......
        selectCategoriesBtn.frame = CGRectMake((searchItemsTxt.frame.origin.x+searchItemsTxt.frame.size.width+5), searchItemsTxt.frame.origin.y,75,40);
        
        //productListTbl.frame = CGRectMake(searchItemsTxt.frame.origin.x,searchItemsTxt.frame.origin.y+ searchItemsTxt.frame.size.height,searchItemsTxt.frame.size.width,260);
        
        //float table_headers_origin = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height + vertical_Gap_for_labels;
        
        //setting the tableheader label's...

        sNoLbl.frame = CGRectMake(0,0,50,35);

        skuIdLbl.frame = CGRectMake(sNoLbl.frame.origin.x+sNoLbl.frame.size.width+2,sNoLbl.frame.origin.y,100, sNoLbl.frame.size.height);

        descriptionLbl.frame = CGRectMake(skuIdLbl.frame.origin.x+skuIdLbl.frame.size.width+2,sNoLbl.frame.origin.y,160,sNoLbl.frame.size.height);

        uomLbl.frame = CGRectMake(descriptionLbl.frame.origin.x+descriptionLbl.frame.size.width+2,sNoLbl.frame.origin.y,60,sNoLbl.frame.size.height);
        
        rangeLbl.frame = CGRectMake(uomLbl.frame.origin.x+uomLbl.frame.size.width+2,sNoLbl.frame.origin.y,60,sNoLbl.frame.size.height);
        
        gradeLbl.frame = CGRectMake(rangeLbl.frame.origin.x + rangeLbl.frame.size.width + 2 , sNoLbl.frame.origin.y, 60,sNoLbl.frame.size.height);
        
        priceLabel.frame = CGRectMake(gradeLbl.frame.origin.x+gradeLbl.frame.size.width+2 ,sNoLbl.frame.origin.y,80,sNoLbl.frame.size.height);

        //requestedQtyLabel.frame = CGRectMake(priceLabel.frame.origin.x + priceLabel.frame.size.width + 2 ,sNoLbl.frame.origin.y,100,sNoLbl.frame.size.height);

        stockQtyLbl.frame = CGRectMake(priceLabel.frame.origin.x + priceLabel.frame.size.width + 2,sNoLbl.frame.origin.y,100,sNoLbl.frame.size.height);
        
        issueQtyLbl.frame = CGRectMake(stockQtyLbl.frame.origin.x+stockQtyLbl.frame.size.width+2 , sNoLbl.frame.origin.y,100,sNoLbl.frame.size.height);
        
        balanceQtyLbl.frame = CGRectMake(issueQtyLbl.frame.origin.x + issueQtyLbl.frame.size.width+2 , sNoLbl.frame.origin.y,100 ,sNoLbl.frame.size.height);
        
        scanCodeLabel.frame = CGRectMake(balanceQtyLbl.frame.origin.x + balanceQtyLbl.frame.size.width + 2 ,sNoLbl.frame.origin.y,100,sNoLbl.frame.size.height);

        make_Lbl.frame = CGRectMake(scanCodeLabel.frame.origin.x + scanCodeLabel.frame.size.width + 2 , sNoLbl.frame.origin.y,70,sNoLbl.frame.size.height);
        
        actionLbl.frame = CGRectMake(make_Lbl.frame.origin.x + make_Lbl.frame.size.width + 2,sNoLbl.frame.origin.y,60,sNoLbl.frame.size.height);
        
        //Frame for the MultipleIssues VIew...
        
        
        multipleStoresTransparentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        multipleIssuesView.frame = CGRectMake(deliveredDateTxt.frame.origin.x,120,shipmentRefNoTxt.frame.origin.x+shipmentRefNoTxt.frame.size.width-(deliveredDateTxt.frame.origin.x+100),500);
        
        locationHeaderNameLbl.frame = CGRectMake(0,0,multipleIssuesView.frame.size.width,45);
        
        locationCloseBtn.frame = CGRectMake(multipleIssuesView.frame.size.width-40,5,35,35);
        
        locationTable.frame = CGRectMake(0,locationHeaderNameLbl.frame.origin.y+locationHeaderNameLbl.frame.size.height,multipleIssuesView.frame.size.width,400);
        
        cancelButton.frame = CGRectMake(300,locationTable.frame.origin.y+locationTable.frame.size.height+5,90,40);
        selectMultipleStoresBtn.frame = CGRectMake(cancelButton.frame.origin.x+cancelButton.frame.size.width+10,cancelButton.frame.origin.y,80,40);

        
        // frame for the stockVerificationScrollView...
        stockIssueScrollView.frame = CGRectMake(searchItemsTxt.frame.origin.x,searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height+5,searchItemsTxt.frame.size.width+90,410);
        
        requestedItemsTbl.frame = CGRectMake(stockIssueView.frame.origin.x,sNoLbl.frame.origin.y+sNoLbl.frame.size.height,actionLbl.frame.origin.x+actionLbl.frame.size.width+50,stockIssueScrollView.frame.size.height - (sNoLbl.frame.origin.y+sNoLbl.frame.size.height));

        stockIssueScrollView.contentSize = CGSizeMake(requestedItemsTbl.frame.size.width - 40,  stockIssueScrollView.frame.size.height);
        
        // frame for the UIButtons...
        submitBtn.frame = CGRectMake(searchItemsTxt.frame.origin.x,stockIssueView.frame.size.height-45,140,40);
        
        saveBtn.frame = CGRectMake(submitBtn.frame.origin.x+submitBtn.frame.size.width+20, submitBtn.frame.origin.y,140,40);
        
        cancelBtn.frame = CGRectMake(saveBtn.frame.origin.x+saveBtn.frame.size.width+20,submitBtn.frame.origin.y,140,40);
        
        priceValueLbl.frame = CGRectMake(priceLabel.frame.origin.x+10,cancelBtn.frame.origin.y,priceLabel.frame.size.width,cancelBtn.frame.size.height);

        stockQtyValueLbl.frame = CGRectMake(stockQtyLbl.frame.origin.x+10,cancelBtn.frame.origin.y,stockQtyLbl.frame.size.width,cancelBtn.frame.size.height);
        
        issueQtyValueLbl.frame = CGRectMake(issueQtyLbl.frame.origin.x+10,cancelBtn.frame.origin.y,issueQtyLbl.frame.size.width,cancelBtn.frame.size.height);
        
        balanceQtyValueLbl.frame = CGRectMake(balanceQtyLbl.frame.origin.x+10,cancelBtn.frame.origin.y,balanceQtyLbl.frame.size.width,cancelBtn.frame.size.height);
    
        //  frame for the Transparent view:
        
        transparentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        priceView.frame = CGRectMake(200,300,550,400);
        
        descLabl.frame = CGRectMake(10,10, 225, 35);
        mrpLbl.frame = CGRectMake(descLabl.frame.origin.x+descLabl.frame.size.width+2,descLabl.frame.origin.y, 150, 35);
        priceLbl.frame = CGRectMake(mrpLbl.frame.origin.x+mrpLbl.frame.size.width+2, descLabl.frame.origin.y, 150, 35);
        
        priceTable.frame = CGRectMake(descLabl.frame.origin.x,descLabl.frame.origin.y+descLabl.frame.size.height+10, priceLbl.frame.origin.x+priceLbl.frame.size.width - (descLabl.frame.origin.x), priceView.frame.size.height - (descLabl.frame.origin.y + descLabl.frame.size.height +48));
        closeBtn.frame = CGRectMake(priceView.frame.size.width+165, priceView.frame.origin.y-38, 40, 40);
        
        //here we are setting font to all subview to mainView.....
        @try {
            [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:16.0f cornerRadius:3.0f];
            headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
            locationHeaderNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
            
            submitBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            saveBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            cancelBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];

        } @catch (NSException *exception) {
            NSLog(@"---- exception while setting the fontSize to subViews ----%@",exception);
        }
    }
    else{
    }

    issueDte.tag = 1;
    dlvryDte.tag = 2;
    requstDte.tag = 3;
}

/**
 * @description  it is one of ViewLifeCylce Method which will be executed after execution of viewDidLoad.......
 * @date         28/06/2017
 * @method       viewDidAppear
 * @param        BOOL
 * @param
 * @return
 * @modified By
 * @reason */

-(void)viewDidAppear:(BOOL)animated {
    
    @try {
        
        HUD.tag = 0;
        
        if(requestedItemsInfoArr == nil){
            
            requestedItemsInfoArr = [NSMutableArray new];
        }
        
    } @catch (NSException *exception) {
        NSLog(@"-exception in serviceCall%@",exception);
    } @finally {
        
        if (IssueId != nil) {
            
            [self callingIssueIdDetails];
            
        }
    }
}


/**
 * @description  it is one of ViewLifeCylce Method which will be executed after execution of viewDidAppear.......
 * @date         28/06/2017
 * @method       viewWillAppear
 * @author       Bhargav.v
 * @param        BOOL
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)viewWillAppear:(BOOL)animated {
    
    //calling the superClass method.......
    [super viewWillAppear:YES];
    
}

#pragma -mark end of ViewLifeCylce Methods....

/**
 * @description  it will be executed when memory warning is receiveds.......
 * @date         28/06/2017
 * @method       didReceiveMemoryWarning
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma  mark Request Methods...

/**
 * @description  Forming the Request to fetch The Skuid's..
 * @date         28/06/2017
 * @method       callRawMaterials
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callRawMaterials:(NSString *)searchString {
    
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
 * @description  Forming the Request To Fetch the SkuiD Details
 * @date         28/06/2017
 * @method       callRawMaterialDetails
 * @author       Bhargav.v
 * @param        NSString
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
        productDetailsDic[START_INDEX] = NEGATIVE_ONE;
        productDetailsDic[ITEM_SKU] = pluCodeStr;

        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:productDetailsDic options:0 error:&err];
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
 * @description  Forming the Request to Get the Stock Request ID's..
 * @date         26/10/2017
 * @method       getStockRequestIDs
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getStockRequestIDs {
    
    @try {
        
        [HUD show:YES];
        [HUD setHidden:NO];
        
        if(requestRefId == nil ){
            
            requestRefId = [NSMutableArray new];
        }
        else if(requestRefId.count ){
            
            [requestRefId removeAllObjects];
        }
        
        NSMutableDictionary * requestIdDic = [[NSMutableDictionary alloc]init];
        
        NSString * requestRefStr;
        
        if((requestRefNoTxt!= nil) && ((requestRefNoTxt.text).length >1 )) {
            requestRefStr =  requestRefNoTxt.text;
            
        }
        
        [requestIdDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [requestIdDic setValue:presentLocation  forKey:TO_STORE_CODE];
        [requestIdDic setValue:NEGATIVE_ONE forKey:START_INDEX];
        [requestIdDic setValue:requestRefStr forKey:kSearchCriteria];
        [requestIdDic setValue:@0 forKey:SL_NO];
        [requestIdDic setValue:@0 forKey:ID_GOODS_ISSUE];

        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:requestIdDic options:0 error:&err_];
        NSString * requestIdsJsonString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@----Requset ID's",requestIdsJsonString);
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.stockRequestDelegate = self;
        [webServiceController getStockRequestIDs:requestIdsJsonString];
        
    }
    @catch (NSException *exception) {
        
        [HUD setHidden: YES];
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];

    }
}

 /**
 * @description  Forming the Request to fetch The ID Details..
 * @date         28/10/2017
 * @method       callingRequestRefIdDetails
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callingRequestRefIdDetails:(NSString*)RequestRefString {
    
    @try {
        
        [HUD show:YES];
        [HUD setHidden:NO];
        
        NSMutableDictionary * requestRefDic = [[NSMutableDictionary alloc]init];
        
        requestRefDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        requestRefDic[STOCK_REQUEST_ID] = RequestRefString;
        //[requestRefDic setValue:[NSNumber numberWithInt:0] forKey:@"slNo"];
        //[requestRefDic setValue:[NSNumber numberWithInt:0] forKey:@"id_goods_issue"];
        //[requestRefDic setObject:presentLocation forKey:TO_STORE_CODE];
        requestRefDic[IS_DRAFT_REQUIRED] = [NSNumber numberWithBool:TRUE];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:requestRefDic options:0 error:&err_];
        NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.stockRequestDelegate = self;
        [webServiceController getAllStockRequest:loyaltyString];
        
        
    } @catch (NSException * exception) {
        
        [HUD setHidden: YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @finally {
        
    }
}


/**
 * @description  Forming the Request To Fetch Number of Outlets Baseed on BusinessActivity
 * @date         28/12/2017
 * @method       getLocations
 * @author       Bhargav.v
 * @param        int
 * @param        NSString
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getLocations:(int)selectIndex businessActivity:(NSString *)businessActivity {
    
    @try {
        
        [HUD show:YES];
        [HUD setHidden:NO];
        
        if(locationArr == nil) {
            locationArr  = [NSMutableArray new];
        }
        else if(locationArr.count) {
            
            [locationArr removeAllObjects];
            
            if (locationCheckBoxArr.count) {
                
                [locationCheckBoxArr removeAllObjects];
            }
        }
        
        //
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
        
        //Hiding the HUD..
        [HUD setHidden: YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
}

/**
 * @description  here we are calling getStockIssue for outlet........
 * @date         28/10/2017
 * @method       callingIssueIdDetails
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

        receiptDetails1[kGoodsIssueRef] = IssueId;
        receiptDetails1[OUTLET_ALL] = [NSNumber numberWithBool:false];
        receiptDetails1[WAREHOUSE_ALL] = [NSNumber numberWithBool:false];
        receiptDetails1[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        receiptDetails1[ISSUE_AND_CLOSE] = [NSNumber numberWithBool:false];
        receiptDetails1[kNotForDownload] = [NSNumber numberWithBool:false];
        receiptDetails1[ALL_LOCATIONS] = [NSNumber numberWithBool:false];
        receiptDetails1[VALID_MASTER_CODE] = [NSNumber numberWithBool:false];
        receiptDetails1[EXISTS_IN_CAPILLARY] = [NSNumber numberWithBool:false];
        receiptDetails1[kVerificationUnderMasterCode] = [NSNumber numberWithBool:false];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:receiptDetails1 options:0 error:&err];
        NSString * getStockIssueJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.stockIssueDelegate = self;
        [webServiceController getStockIssueId:getStockIssueJsonString];
        
    }
    @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"message", nil),@"\n",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
}


/**
 * @description  this method is used to get Categories List...
 * @date         21/09/2016
 * @method       callingCategoriesList
 * @author       Bhargav Ram
 * @param        NSString
 * @return
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
        if(categoriesArr == nil) {
            
            categoriesArr  = [NSMutableArray new];
            checkBoxArr    = [NSMutableArray new];
        }
        
        NSMutableDictionary * locationWiseCategoryDictionary = [[NSMutableDictionary alloc]init];
        
        [locationWiseCategoryDictionary setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        
        [locationWiseCategoryDictionary setValue:presentLocation forKey:kStoreLocation];
        
        [locationWiseCategoryDictionary setValue:NEGATIVE_ONE forKey:START_INDEX_STR];
        
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
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"message", nil),@"\n",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 200)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:200 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        
    } @finally {
        
    }
}

/**
 * @description  Forming the Request String To create A new Stock Issue
 * @date
 * @method       submitButtonPressed
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 * @modified BY Srinivasulu
 * @reason      item level handling was remove and added comments....
 */

- (void)submitButtonPressed:(UIButton *)sender {
    @try {
        //Play Audio for Button touch...
        AudioServicesPlaySystemSound(soundFileObject);
        
        if  ( requestedItemsInfoArr.count  == 0)  {
            
            float y_axis = self.view.frame.size.height - 200;
            
            NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"please_add_items_to_the_cart", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 320)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:400 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        }
        else if ((toStoreCodeTxt.text).length == 0) {
            
            float y_axis = self.view.frame.size.height - 200;
            
            NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"please_select_Location", nil)];
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:400 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
            
            [self populateLocationsTable:sender];
        }
        
        else if ((shipmentModeTxt.text).length == 0)  {
            [self getShipmentModes:sender];
        }
        
        else if ((deliveredDateTxt.text).length == 0){
            
            UIButton * DeliveryBtn  = [[UIButton alloc]init];
            DeliveryBtn.tag = 2;
            
            [self showCalenderInPopUp:DeliveryBtn];
        }
       
        else if((issuedByTxt.text).length == 0) {
            [issuedByTxt becomeFirstResponder];
        }
        
        else if((carriedByTxt.text).length == 0) {
            
            [carriedByTxt becomeFirstResponder];
        }
        
        else {
            
            //changed By srinivauslu on 02/05/2018....
            //reason.. Need to stop user internation after servcie calls...
            
            submitBtn.userInteractionEnabled = NO;
            saveBtn.userInteractionEnabled = NO;
            
            //upto here on 02/05/2018....
            
            [HUD setHidden:NO];
            [HUD show:YES];
            NSMutableArray * locArr = [NSMutableArray new];
            
            float issueTotal = 0;
            
            for (NSDictionary * dic in requestedItemsInfoArr) {
                
                NSMutableDictionary * itemDetailsDic = [dic mutableCopy];
                
                issueTotal += ([[dic valueForKey:QUANTITY] floatValue]*[[dic valueForKey:ITEM_UNIT_PRICE] floatValue]);
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f" ,([[itemDetailsDic valueForKey:AVAILABLE_QTY] floatValue]-[[dic valueForKey:QUANTITY] floatValue])] forKey:BALANCE_QTY];
                
                // added by roja on 26-07-2018...
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",([[dic valueForKey:QUANTITY] floatValue]*[[dic valueForKey:ITEM_UNIT_PRICE] floatValue]) ] forKey:COST];

                [locArr addObject:itemDetailsDic];
            }
            NSString * deliveryDateStr = deliveredDateTxt.text;
            
            if(deliveryDateStr.length > 1)
                deliveryDateStr = [NSString stringWithFormat:@"%@%@", deliveredDateTxt.text,@" 00:00:00"];
            
            NSString * requestDateStr = reqeustDateTxt.text;
            
            if(requestDateStr.length >1)
                requestDateStr = [NSString stringWithFormat:@"%@%@",reqeustDateTxt.text,@" 00:00:00"];
            
            NSString * issueDateStr = issueDateTxt.text;
            
            if(issueDateStr.length >1)
                issueDateStr = [NSString stringWithFormat:@"%@%@",issueDateTxt.text,@" 00:00:00"];
            
            NSMutableDictionary * dic = [NSMutableDictionary new];
            
            [dic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
            [dic setValue:toStoreCodeTxt.text forKey:TO_STORE_CODE];
            [dic setValue:toStoreCodeTxt.text forKey:kIssuedTo];
            [dic setValue:issuedByTxt.text forKey:kIssuedBy];
            [dic setValue:presentLocation forKey:FROM_STORE_CODE];
            [dic setValue:shipmentModeTxt.text forKey:kShipmentMode];
            [dic setValue:presentLocation forKey:kShippedFrom];
            [dic setValue:carriedByTxt.text forKey:DELIVERED_BY];
            [dic setValue:deliveryDateStr forKey:DELIVERY_DATE];
            [dic setValue:issueDateStr forKey:CREATED_DATE_STR];
            [dic setValue:locArr forKey:RECEIPT_DETAILS];
            
            [dic setValue:@(issueTotal) forKey:ISSUE_TOTAL];
            [dic setValue:@(issueTotal) forKey:GRAND_TOTAL];
            [dic setValue:@(issueTotal) forKey:kSubTotal];
            [dic setValue:@((issueQtyValueLbl.text).floatValue) forKey:ISSUE_TOTAL_QTY];
            [dic setValue:[NSNumber numberWithBool:false] forKey:kVerificationUnderMasterCode];
           
            int  totalItems = (int)requestedItemsInfoArr.count;
            [dic setValue:@(totalItems) forKey:NO_OF_ITEMS];
            
            if(sender.tag == 2)
                dic[STATUS] = DRAFT;
            
            else
                dic[STATUS] = STATUS_ISSUED;
            
            [dic setValue:EMPTY_STRING forKey:REMARKS];
            [dic setValue:requestedByTxt.text forKey:REQUESTED_BY];
            [dic setValue:EMPTY_STRING forKey:RECEIVED_by];
            [dic setValue:EMPTY_STRING forKey:inspected_By];

            
            if((requestRefNoTxt.text).length >0)
                [dic setValue:requestRefNoTxt.text forKey:kgoodsReqRef];
            
            if ((shipmentRefNoTxt.text).length>0) {
                [dic setValue:shipmentRefNoTxt.text forKey:kShipmentRef];
            }
            
            if (isDraft) {
                
                [dic setValue:IssueId forKey:kGoodsIssueRef];
            }
            
            NSError  * err;
            NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&err];
            NSString * jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
           
            WebServiceController * webServiceController = [WebServiceController new];

            if (isDraft) {
               
                webServiceController.stockIssueDelegate = self;
                [webServiceController upDateStockIssue:jsonData];
            }
            else {
                
                webServiceController.stockIssueDelegate = self;
                [webServiceController createStockIssue:jsonStr];
            }
            
        }
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        //changed By srinivauslu on 02/05/2018....
        //reason.. Need to stop user internation after servcie calls...
        
        submitBtn.userInteractionEnabled = YES;
        saveBtn.userInteractionEnabled = YES;
        
        //upto here on 02/05/2018....
    }
}


#pragma  Hadling  Success Response methods...

/**
 * @description  Handling the Response to get The Searche sku In
 * @date         date
 * @method       searchProductsSuccessResponse
 * @author       Bhargav.v
 * @param        NSDictionary
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
                
                [self showPopUpForTables:productListTbl  popUpWidth:searchItemsTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:searchItemsTxt  showViewIn:stockIssueView permittedArrowDirections:UIPopoverArrowDirectionUp];
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
 * @description  Hadling the error Response..
 * @date          ----
 * @method       searchProductsErrorResponse
 * @author       Bhargav.v
 * @param        ----
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)searchProductsErrorResponse {
    
    @try {
        
        [HUD setHidden: YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found", nil)];
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:350 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];

    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}


/**
 * @description  we are Handling the success Respopnse to fetch the locations..
 * @date         25/12/2017
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
                
                //Commented we don't need this functionality currently.
                //[locationCheckBoxArr addObject:@"0"];
            }
            if ([locationArr containsObject:presentLocation]) {
                [locationArr removeObject:presentLocation];
            }
        }
        
//        if ([locationArr count]) {
//
//            [multipleStoresTransparentView setHidden:NO];
//        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        [HUD setHidden:YES];
        [locationTable reloadData];
    }
}

/**
 * @description  handling the error respone of getLocation....
 * @date         21/09/2016
 * @method       getLocationErrorResponse:
 * @param        NSString
 
 */

-(void)getLocationErrorResponse:(NSString *)errorResponse{
    
    @try {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItemsTxt.isEditing)
            y_axis = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];

        
        
    } @catch (NSException *exception) {
        
    } @finally {
        [catPopOver dismissPopoverAnimated:YES];
        [HUD setHidden:YES];
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
 * @modified By Srinivasulu on 13/04/2017...
 * @reason      added comments && added new field in items level....
 */

- (void)getSkuDetailsSuccessResponse:(NSDictionary*)successDictionary {
    
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
                NSMutableDictionary * existingItemsDic;
                
                for ( i=0; i<requestedItemsInfoArr.count; i++) {
                    NSArray *itemArray = [successDictionary valueForKey:kSkuLists];
                    if (itemArray.count > 0) {
                        NSDictionary * itemdic = itemArray[0];
                        existingItemsDic = requestedItemsInfoArr[i];
                        if ([[existingItemsDic valueForKey:ITEM_SKU] isEqualToString:[itemdic valueForKey:ITEM_SKU]] && [[existingItemsDic valueForKey:PLU_CODE] isEqualToString:[itemdic valueForKey:PLU_CODE]]) {
                            
                            [existingItemsDic setValue:[NSString stringWithFormat:@"%.2f",[[existingItemsDic valueForKey:QUANTITY] floatValue] + 1] forKey:QUANTITY];
                            
                            requestedItemsInfoArr[i] = existingItemsDic;
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
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_SKU] defaultReturn:@""] forKey:kItem];

                        //setting plucode....
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:PLU_CODE] defaultReturn:[itemDetailsDic valueForKey:ITEM_SKU]] forKey:PLU_CODE];

                        //setting itemDescription....
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESCRIPTION];
                        
                        //setting itemPrice as salePrice...
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic valueForKey:cost_Price] defaultReturn:@"0.00"] floatValue]] forKey:ITEM_UNIT_PRICE];
                        
                        //setting kMaxQuantity for the stock quantity....
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:kMaxQuantity] defaultReturn:@"0.00"] floatValue]] forKey:kMaxQuantity];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:AVAILABLE_QTY];

                        //setting quantity as  BALANCE_QTY to 0..
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:BALANCE_QTY];
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:COST];
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:ISSUED];
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:QUANTITY];
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:INDENT_QTY];
                        
                        
                        //extra keys....
                        //setting kReceived for the rejectedQty key....
                        [itemDetailsDic setValue:@"0.00" forKey:kReceived];
                        
                        //setting kRejected for the rejectedQty key...
                        [itemDetailsDic setValue:@"0.00" forKey:kRejected];
                        
                        //setting kRejected for the rejectedQty key...
                        [itemDetailsDic setValue:@"0.00" forKey:kSupplied];
                        
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
                        
                        // added by roja on 24-07-2018...
                        [itemDetailsDic setValue:EMPTY_STRING forKey:ITEM_SCAN_CODE];
                        

                        [requestedItemsInfoArr addObject:itemDetailsDic];

                        
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
                    }
                }
                else
                    requestedItemsInfoArr[i] = existingItemsDic;
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
 * @modified By Srinivasulu on 13/04/2017...
 * @reason      added comments && added new field in items level....
 */

- (void)getSkuDetailsErrorResponse:(NSString*)failureString {
    
    @try {
        
        //added by Srinivasulu on 13/04/2017....
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",failureString];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}



/**
 * @description
 * @date
 * @method
 * @author
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified BY Srinivasulu 
 * @reason      item level handling was remove and added comments....
 *
 */

-(void)getStockRequestsSuccessResponse:(NSDictionary *)successDictionary  {
    
    @try {
        
        [HUD setHidden:YES];
        
        NSDictionary * details =[successDictionary valueForKey:STOCK_REQUESTS][0];
        
        if ([details.allKeys containsObject:REQUESTED_USER_NAME] && ![[details valueForKey:REQUESTED_USER_NAME] isKindOfClass:[NSNull class]]) {
            requestedByTxt.text = [details valueForKey:REQUESTED_USER_NAME];
        }
        if ([details.allKeys containsObject:SHIPPING_MODE] && ![[details valueForKey:SHIPPING_MODE] isKindOfClass:[NSNull class]]) {
            shipmentModeTxt.text = [details valueForKey:SHIPPING_MODE];
        }
        if ([details.allKeys containsObject:FROM_STORE_CODE] && ![[details valueForKey:FROM_STORE_CODE] isKindOfClass:[NSNull class]]) {
            toStoreCodeTxt.text = [details valueForKey:FROM_STORE_CODE];
        }
        if ([details.allKeys containsObject:REQUEST_DATE_STR] && ![[details valueForKey:REQUEST_DATE_STR] isKindOfClass:[NSNull class]]) {
            reqeustDateTxt.text = [[details valueForKey:REQUEST_DATE_STR] componentsSeparatedByString:@" "][0];
        }
        
        for (NSMutableDictionary * dic in [[successDictionary valueForKey:STOCK_REQUESTS][0] valueForKey:STOCK_REQUEST_ITEMS] ) {
            
            NSMutableDictionary * locDic = [dic mutableCopy];
            
            [locDic setValue:[self checkGivenValueIsNullOrNil:[locDic valueForKey:ITEM_SKU] defaultReturn:@""] forKey:kItem];
            
            [locDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:iTEM_PRICE] defaultReturn:@"0.00"] floatValue]] forKey:ITEM_UNIT_PRICE];
            
            // changed by roja on 13-07-2018....
            [locDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:kApprovedQty] defaultReturn:@"0.00"] floatValue]] forKey:QUANTITY];

            // added by roja
            [locDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[details valueForKey:REQUESTED_QTY] defaultReturn:@"0.00"] floatValue]] forKey:INDENT_QTY];
        // [locDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:kApprovedQty] defaultReturn:@"0.00"] floatValue]] forKey:INDENT_QTY];

            [locDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:kApprovedQty] defaultReturn:@"0.00"] floatValue]] forKey:kMaxQuantity];
            
            //setting availiable qty....
            [locDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic  valueForKey:AVL_QTY] defaultReturn:@"0.00"] floatValue]] forKey:AVAILABLE_QTY];
            
            [locDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic  valueForKey:TOTAL_COST] defaultReturn:@"0.00"] floatValue]] forKey:COST];
            
            //setting itemDescription....
            if(  [dic.allKeys containsObject:ITEM_DESC] &&  (![[dic valueForKey:ITEM_DESC] isKindOfClass: [NSNull class]]))
                [locDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_DESC] defaultReturn:@""] forKey:ITEM_DESCRIPTION];
            
            else
                [locDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESCRIPTION];
            
            //newly added keys....
            [locDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
            
            [locDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
            
            [locDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
            
            [locDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:MEASUREMENT_RANGE] defaultReturn:@""] forKey:MEASUREMENT_RANGE];
            
            [locDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];
            
            [locDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kProductBrand] defaultReturn:@""] forKey:kBrand];
            
            [locDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
            
            [locDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
            
            // added by roja on 24-07-2018..
            [locDic setValue:EMPTY_STRING forKey:ITEM_SCAN_CODE];

//            [locDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kSubCategory] defaultReturn:@" "] forKey:kSubCategory];

            [requestedItemsInfoArr addObject:locDic];
        }
        
        [self calculateTotal];
    }
    @catch (NSException *exception) {
        
        NSLog(@"-----55--------%@",exception);
        
    }
    @finally {
        
        [requestedItemsTbl reloadData];

        [HUD setHidden:YES];
    }
}

-(void)getStockRequestsErrorResponse:(NSString *) error {
    @try {
        
        
        [HUD setHidden:YES];

        float y_axis = self.view.frame.size.height - 120;
        
        if(requestRefNoTxt.isEditing)
            y_axis = requestRefNoTxt.frame.origin.y + requestRefNoTxt.frame.size.height;
        
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",error];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:500 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    }
    @catch (NSException *exception) {
        
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
-(void)getStockRequestIdsSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        for (NSDictionary *dic in [successDictionary valueForKey:INDENT_IDS_LIST]) {
            
            [requestRefId addObject:dic];
        }
        
        if(requestRefId.count) {
            
            float tableHeight = requestRefId.count * 40;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = requestRefId.count * 33;
            
            if(requestRefId.count > 5)
                tableHeight = (tableHeight/requestRefId.count) * 5;
            
            [self showPopUpForTables:reqRefTable  popUpWidth:(requestRefNoTxt.frame.size.width * 1.5) popUpHeight:tableHeight presentPopUpAt:requestRefNoTxt  showViewIn:stockIssueView permittedArrowDirections:UIPopoverArrowDirectionUp ];
            
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [HUD setHidden:YES];

    }
}


/**
 * @description  Handling the Error Response for StockRequest Ids...
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
-(void)getStockRequestIdsErrorResponse:(NSString *)errorResponse {
    @try {
        
        [HUD setHidden: YES];

        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItemsTxt.isEditing)
            
            y_axis = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        HUD.tag = 0;
        [HUD setHidden: YES];
        
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

- (void)getStockIssueIdSuccessResponse:(NSDictionary*)sucessDictionary {
    
    @try {
        
        isDraft = true;
        
        NSDictionary * details = [sucessDictionary valueForKey:kIssueDetails];
        
        if ([details.allKeys containsObject:kIssuedTo] && ![[details valueForKey:kIssuedTo] isKindOfClass:[NSNull class]]) {
            toStoreCodeTxt.text = [details valueForKey:kIssuedTo];
        }
        
        if ([details.allKeys containsObject:kReceivedBy] && ![[details valueForKey:kReceivedBy] isKindOfClass:[NSNull class]]) {
            
            requestedByTxt.text = [details valueForKey:kReceivedBy];
        }
        
        if ([details.allKeys containsObject:DELIVERY_DATE] && ![[details valueForKey:DELIVERY_DATE] isKindOfClass:[NSNull class]]) {
            
            deliveredDateTxt.text = [details valueForKey:DELIVERY_DATE];
        }
        
        if ([details.allKeys containsObject:CREATED_DATE_STR] && ![[details valueForKey:CREATED_DATE_STR] isKindOfClass:[NSNull class]]) {
            
            reqeustDateTxt.text = [details valueForKey:CREATED_DATE_STR];
        }
        
        if ([details.allKeys containsObject:kIssuedBy] && ![[details valueForKey:kIssuedBy] isKindOfClass:[NSNull class]]) {
            
            issuedByTxt.text = [details valueForKey:kIssuedBy];
        }
        
        if ([details.allKeys containsObject:DELIVERED_BY] && ![[details valueForKey:DELIVERED_BY] isKindOfClass:[NSNull class]]) {
            
            carriedByTxt.text = [details valueForKey:DELIVERED_BY];
        }
        
        if ([details.allKeys containsObject:kShipmentMode] && ![[details valueForKey:kShipmentMode] isKindOfClass:[NSNull class]]) {
            
            shipmentModeTxt.text = [details valueForKey:kShipmentMode];
        }
        
        if ([details.allKeys containsObject:kShipmentRef] && ![[details valueForKey:kShipmentRef] isKindOfClass:[NSNull class]]) {
            
            shipmentRefNoTxt.text = [details valueForKey:kShipmentRef];
        }
        // added by roja on 12-07-2018....
        if ([details.allKeys containsObject:kgoodsReqRef] && ![[details valueForKey:kgoodsReqRef] isKindOfClass:[NSNull class]]) {
            
            requestRefNoTxt.text = [details valueForKey:kgoodsReqRef];
        }
        if ([details.allKeys containsObject:REQUESTED_BY] && ![[details valueForKey:REQUESTED_BY] isKindOfClass:[NSNull class]]) {
            
            requestedByTxt.text = [details valueForKey:REQUESTED_BY];
        }
        
      
        
        //Handling the response under Item Details.....
        
        for (NSDictionary * itemDetails in [sucessDictionary valueForKey:kItemDetails]) {
            
            NSMutableDictionary * dic = [itemDetails mutableCopy];
            [dic removeObjectForKey:Issue_id];
            
            [dic setValue:[self checkGivenValueIsNullOrNil:[itemDetails  valueForKey:QUANTITY] defaultReturn:@"0.00"] forKey:QUANTITY];
            
            [dic setValue:[self checkGivenValueIsNullOrNil:[itemDetails  valueForKey:kMaxQuantity] defaultReturn:@"0.00"] forKey:kMaxQuantity];
            
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
            
            // added by roja on 24-07-2018..
            [dic setValue:EMPTY_STRING forKey:ITEM_SCAN_CODE];

            [dic setValue:[self checkGivenValueIsNullOrNil:[itemDetails valueForKey:UTILITY] defaultReturn:@" "] forKey:UTILITY];

            [dic setValue:[self checkGivenValueIsNullOrNil:[itemDetails valueForKey:kSubCategory] defaultReturn:@" "] forKey:kSubCategory];

            
            [requestedItemsInfoArr addObject:itemDetails];
            
            [requestedItemsTbl reloadData];
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [self calculateTotal];
        
    }
}


/**
 * @description  handling the success response........
 * @date         04/11/2016
 * @method       getStockIssueIdErrorResponse:
 * @author       Bhargav
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void) getStockIssueIdErrorResponse:(NSString *)error{
    
    @try {
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItemsTxt.isEditing)
            
            y_axis = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",error];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        [HUD setHidden:YES];
    }
    
}


/**
 * @description
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

- (void)createStockIssueSuccessResponse:(NSDictionary *)sucessDictionary {
    
    @try {
        [HUD setHidden:YES];
        
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItemsTxt.isEditing)
            y_axis = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height;
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"stock_issue_generated_successfully",nil),@"\n", [sucessDictionary valueForKey:ISSUE_ID]];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"SUCCESS", nil)  conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

/**
 * @description  handling the Error Response To Display the Error Response
 * @date         28/10/2017
 * @method       createStockIssueErrorResponse
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)createStockIssueErrorResponse:(NSString *)error {
    
    @try {
        [HUD setHidden:YES];
        
        //changed By srinivauslu on 02/05/2018....
        //reason.. Need to stop user internation after servcie calls...
        
        submitBtn.userInteractionEnabled = YES;
        saveBtn.userInteractionEnabled = YES;
        
        //upto here on 02/05/2018....
        float y_axis = self.view.frame.size.height - 200;
        
        if(searchItemsTxt.isEditing)
            y_axis = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",error];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:500 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @catch (NSException *exception) {
        
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
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"SUCCESS", nil)  conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        [HUD setHidden:YES];
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
-(void)updateStockIssueErrorResponse:(NSString *)error {
    
    @try {
        [HUD setHidden:YES];
        
        //changed By srinivauslu on 02/05/2018....
        //reason.. Need to stop user internation after servcie calls...
        
        submitBtn.userInteractionEnabled = YES;
        saveBtn.userInteractionEnabled = YES;

        //upto here on 02/05/2018....
        float y_axis = self.view.frame.size.height - 350;
        
        if(searchItemsTxt.isEditing)
            y_axis = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height;
        
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",error];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:500 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}


#pragma mark populating the methods:





/**
 * @description  Displaying the TO - Locations where we can issue the issued items
 * @date         25/12/2017
 * @method       populateLocationsTable
 * @author       Bhargav.v
 * @param        UIButton
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
            
            [self showPopUpForTables:locationTable  popUpWidth:(toStoreCodeTxt.frame.size.width *1.5) popUpHeight:tableHeight presentPopUpAt:toStoreCodeTxt  showViewIn:stockIssueView permittedArrowDirections:UIPopoverArrowDirectionUp];
        }
        else
            [catPopOver dismissPopoverAnimated:YES];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

/**
 * @description  Displaying the Shipment modes to transfer from one outlet to another...
 * @date         25/12/207
 * @method       getShipmentModes
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */
 -(void)getShipmentModes:(UIButton*)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        shipModesArr = [NSMutableArray new];
        [shipModesArr addObject:NSLocalizedString(@"rail", nil) ];
        [shipModesArr addObject:NSLocalizedString(@"flight", nil) ];
        [shipModesArr addObject:NSLocalizedString(@"express", nil) ];
        [shipModesArr addObject:NSLocalizedString(@"ordinary", nil) ];
        
        float tableHeight = shipModesArr.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = shipModesArr.count * 33;
        
        if(shipModesArr.count>5)
            tableHeight = (tableHeight/shipModesArr.count) * 5;
        
        [self showPopUpForTables:shipModeTable  popUpWidth:(shipmentModeTxt.frame.size.width* 1.5)  popUpHeight:tableHeight presentPopUpAt:shipmentModeTxt  showViewIn:stockIssueView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
    }
}


#pragma -mark used to display calender....

/**
 * @description  in this method we will show the calender in popUp....
 * @method       showCalenderInPopUp:
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 * @modified By Srinivasulu on 13/04/2017...
 * @reason      added comments....
 */

-(void)showCalenderInPopUp:(UIButton *)sender {
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
        
        // Current Date...
        NSDate * now = [NSDate date];
        [myPicker setDate:now animated:YES];
        myPicker.backgroundColor = [UIColor whiteColor];
        
        UIButton  * pickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [pickButton setBackgroundImage:[UIImage imageNamed:@"ok2.png"] forState:UIControlStateNormal];
        
        //pickButton.backgroundColor = [UIColor grayColor];
        //pickButton.backgroundColor = [UIColor clearColor];
        pickButton.layer.masksToBounds = YES;
        [pickButton addTarget:self action:@selector(populateDateToTextField:) forControlEvents:UIControlEventTouchUpInside];
        //pickButton.layer.borderColor = [UIColor blackColor].CGColor;
        //pickButton.layer.borderWidth = 0.5f;
        //pickButton.layer.cornerRadius = 12;
        pickButton.tag = sender.tag;
        [customView addSubview:myPicker];
        [customView addSubview:pickButton];
        
        
        
        //added by srinivasulu on 02/02/2017....
        
        UIButton  * clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [clearButton setBackgroundImage:[UIImage imageNamed:@"Clear.png"] forState:UIControlStateNormal];
        
        //pickButton.backgroundColor = [UIColor grayColor];
        //clearButton.backgroundColor = [UIColor clearColor];
        
        clearButton.layer.masksToBounds = YES;
        [clearButton addTarget:self action:@selector(clearDate:) forControlEvents:UIControlEventTouchUpInside];
        
        //clearButton.layer.borderColor = [UIColor blackColor].CGColor;
        //clearButton.layer.borderWidth = 0.5f;
        //clearButton.layer.cornerRadius = 12;
        
        clearButton.tag = sender.tag;
        [customView addSubview:clearButton];
        
        pickButton.frame = CGRectMake( ((customView.frame.size.width - 230)/ 3), 270, 110, 45);
        clearButton.frame = CGRectMake( pickButton.frame.origin.x + pickButton.frame.size.width + ((customView.frame.size.width - 200)/ 3), pickButton.frame.origin.y, pickButton.frame.size.width, pickButton.frame.size.height);
        
        customerInfoPopUp.view = customView;
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
            
            UIPopoverController * popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            issueDateTxt.tag = 0;
            deliveredDateTxt.tag = 0;
            reqeustDateTxt.tag = 0;
            
            if(sender.tag == 1) {
                
                [popover presentPopoverFromRect:issueDateTxt.frame inView:stockIssueView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
                
                issueDateTxt.tag = sender.tag;
                deliveredDateTxt.tag = 0;
                reqeustDateTxt.tag = 0;
                
            }
            else  if(sender.tag == 2) {
                
                [popover presentPopoverFromRect:deliveredDateTxt.frame inView:stockIssueView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
                
                issueDateTxt.tag = 0;
                deliveredDateTxt.tag = sender.tag;
                reqeustDateTxt.tag = 0;
                
            }
            else  {
                
                issueDateTxt.tag = 0;
                deliveredDateTxt.tag = 0;
                reqeustDateTxt.tag = sender.tag;
                
                [popover presentPopoverFromRect:reqeustDateTxt.frame inView:stockIssueView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
                
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
 * @description  clear the date from textField and calling services.......
 * @date         01/03/2017
 * @method       clearDate:
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)clearDate:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        [catPopOver dismissPopoverAnimated:YES];
        
        if(sender.tag == 1){
            if((issueDateTxt.text).length)
                //callServices = true;
                
                issueDateTxt.text = @"";
        }
        else if(sender.tag == 2) {
            
            if((deliveredDateTxt.text).length)
                //callServices = true;
                
                deliveredDateTxt.text = @"";
        }
        
        else
            if ((reqeustDateTxt.text).length) {
                //callServices = true;
                
                reqeustDateTxt.text = @"";
            }
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        NSLog(@"---- exception in StockReceiptView -- in  -- clearDate() ----");
        NSLog(@"---- exception is ----%@",exception);
        
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
        
        if( sender.tag == 1) {
            
            
            if ((deliveredDateTxt.text).length != 0 && ( ![deliveredDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:deliveredDateTxt.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedDescending) {
                    
                    [self displayAlertMessage:NSLocalizedString(@"issue_date_should_be_earlier_than_delivered_date", nil) horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:400 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
                    
                    return;
                }
            }
            
            if ((reqeustDateTxt.text).length != 0 && ( ![reqeustDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:reqeustDateTxt.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    [self displayAlertMessage:NSLocalizedString(@"issue_date_should_not_be_earlier_than_requested_date", nil) horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:400 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
                    
                    return;
                }
            }
            
            issueDateTxt.text = dateString;
            
        }
        else if (sender.tag == 2) {
            
            if ((reqeustDateTxt.text).length != 0 && ( ![reqeustDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:reqeustDateTxt.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    [self displayAlertMessage:NSLocalizedString(@"delivery_date_should_not_be_earlier_than_request_date", nil) horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:400 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
                    
                    return;
                }
            }
            
            if ((issueDateTxt.text).length != 0 && ( ![issueDateTxt.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:issueDateTxt.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    [self displayAlertMessage:NSLocalizedString(@"delivery_date_should_not_be_earlier_than_request_date", nil) horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:400 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
                    
                    return;
                    
                }
            }
            deliveredDateTxt.text = dateString;
            
        }
        
      else if (sender.tag == 3) {
          
          if ((issueDateTxt.text).length != 0 && ( ![issueDateTxt.text isEqualToString:@""])){
              existingDateString = [requiredDateFormat dateFromString:issueDateTxt.text ];
              
              if ([selectedDateString compare:existingDateString]== NSOrderedDescending) {
                  
                  
                  [self displayAlertMessage:NSLocalizedString(@"request_date_should_be_earlier_than_delivery_date", nil) horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:400 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
                  
                  return;
                  
              }
          }
          
          if ((deliveredDateTxt.text).length != 0 && ( ![deliveredDateTxt.text isEqualToString:@""])){
              existingDateString = [requiredDateFormat dateFromString:deliveredDateTxt.text ];
              
              if ([selectedDateString compare:existingDateString]== NSOrderedDescending) {
                  
                  [self displayAlertMessage:NSLocalizedString(@"request_date_should_be_earlier_than_delivery_date", nil) horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:400 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
                  
                  return;
              }
          }
          
          reqeustDateTxt.text = dateString;
      }
        
    } @catch (NSException *exception) {
        
    }
    @finally{
        
    }
    
}


/**
 * @description  We are Navigating to the Summary class by calling this action...
 * @date         18/10/2017
 * @method       cancelButtonPressed
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)cancelButtonPressed:(UIButton*) sender {
    @try {
        
        [self backAction];
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
 * @method       textFieldShouldBeginEditing:
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
    
    if (textField.frame.origin.x  == issueQtyText.frame.origin.x ||textField.frame.origin.x == scanCodeText.frame.origin.x )
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

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    @try {
        
        @try {
            
            if(textField == searchItemsTxt){
                
                offSetViewTo = 120;
            }
            
            else if (textField.frame.origin.x  == issueQtyText.frame.origin.x || textField.frame.origin.x == scanCodeText.frame.origin.x) {
                
                [textField selectAll:nil];
                
                [UIMenuController sharedMenuController].menuVisible = NO;
                
                reloadTableData = true;

                int count = (int)textField.tag;
                
                if(textField.tag > 9)
                    
                    count = 9;
                
                offSetViewTo = (textField.frame.origin.y + textField.frame.size.height) * count + requestedItemsTbl.frame.origin.y;
            }
            
            [self keyboardWillShow];
            
        } @catch (NSException * exception) {
            
        }
    } @catch (NSException *exception) {
        
    }
}


/**
 * @description  Delegate method which will be called when we start tyiping the text filed...
 * @date
 * @method       textFieldDidChange
 * @author       Bhargav.v
 * @param        UITextField
 * @param
 * @return
 * @verified By
 * @verified On
 *
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
    
    else if (textField == requestRefNoTxt){
        
        //HUD.tag = 0;
        
        if ((textField.text).length>=3 ){
            
            @try {
                
                requestRefId = [NSMutableArray new];

                [self getStockRequestIDs];

            } @catch ( NSException * exception) {
                
            } @finally {
                
            }
        }
        
        // added by roja on 27-07-2018...
//        else{
//
//            [requestedItemsInfoArr removeAllObjects];
//
//            [requestedItemsTbl reloadData];
//        }
        
    }
    
    else if(textField.frame.origin.x == issueQtyText.frame.origin.x){
        
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
    
    else if(textField.frame.origin.x == scanCodeText.frame.origin.x) {
        
        @try {
            NSMutableDictionary * dic =  [requestedItemsInfoArr[textField.tag] mutableCopy];
            
            [dic setValue:textField.text  forKey:ITEM_SCAN_CODE];
            requestedItemsInfoArr[textField.tag] = dic;
        }
        @catch(NSException * exception) {
            
        }
    }
}


/**
 * @description  Changing the keyboard format when keyboardshows in to numerical form..
 * @date
 * @method       shouldChangeCharactersInRange
 * @author       Bhargav.v
 * @param        UITextField
 * @param        NSRange
 * @param        NSString
 * @return
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
 * @description  Delegate called while we select the return
 * @date
 * @method       textFieldDidEndEditing
 * @author       Bhargav.v
 * @param        UITextField
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [self keyboardWillHide];
    offSetViewTo = 0;
    
    if (textField.frame.origin.x == issueQtyText.frame.origin.x){
        
        @try {
            NSString * qtyKey = QUANTITY;
            
            NSMutableDictionary * temp = [requestedItemsInfoArr[textField.tag]  mutableCopy];
            [temp setValue:textField.text  forKey:qtyKey];
            
            requestedItemsInfoArr[textField.tag] = temp;
        }
        @catch (NSException * exception) {
            
        }
        @finally {
            
            [self calculateTotal];
        
            if(reloadTableData)
                [requestedItemsTbl reloadData];
        }
    }

    else if(textField.frame.origin.x == scanCodeText.frame.origin.x) {
        
        @try {
            
            NSMutableDictionary * dic =  [requestedItemsInfoArr[textField.tag] mutableCopy];
            [dic setValue:textField.text  forKey:ITEM_SCAN_CODE];
            requestedItemsInfoArr[textField.tag] = dic;
        }
        @catch(NSException * exception) {
            
        }
        if(reloadTableData)
            [requestedItemsTbl reloadData];
    }
}

/**
 * @description  It is tableFieldDelegates Method. It will executed when user started entering input....
 * @date         29/05/2016
 * @method       textFieldShouldBeginEditing:
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

#pragma -mark   UITableView Delegate Methods

/**
 * @description  it is tableViewDelegate method it will execute and return numberOfRows in Table.....
 * @date         10/09/2016
 * @method       tableView: numberOfRowsInSectionL
 *
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == requestedItemsTbl) {
        @try {
            
            return requestedItemsInfoArr.count;
        }
        @catch (NSException *exception) {
            
        }
    }
    
    
    else if (tableView == productListTbl) {
        
        return productList.count;
    }
    else if (tableView == locationTable) {
        return locationArr.count;
    }
    else if (tableView == shipModeTable) {
        return shipModesArr.count;
    }
    else if (tableView == reqRefTable) {
        return requestRefId.count;
    }
    else if (tableView == priceTable) {
        return priceDic.count;
    }
    else if (tableView == categoriesTbl ) {
        
        return categoriesArr.count;
    }
    
    else
        return 0;
}

/**
 * @description  it is tableViewDelegate method it will execute and return height in Table.....
 * @date         21/09/2016
 * @method       tableView: hegintForRowAtIndexPath:

 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView == requestedItemsTbl){
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            return 38;
        }
    }
    else  if (tableView == productListTbl ||tableView == locationTable ||tableView == shipModeTable || reqRefTable ||tableView == priceTable || tableView == categoriesTbl)  {
        
        return 40;
    }
    
    return 45;
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
                
                itemDescLbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_DESCRIPTION] defaultReturn:@""];
                
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
    else if (tableView == shipModeTable) {
        
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
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                       initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
        }
        hlcell.textLabel.text = [self checkGivenValueIsNullOrNil:shipModesArr[indexPath.row]  defaultReturn:@"--"];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        return hlcell;
    }
    else if(tableView == reqRefTable) {
        
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
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                       initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
        }
        hlcell.textLabel.text = [self checkGivenValueIsNullOrNil:requestRefId[indexPath.row]  defaultReturn:@"--"];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        return hlcell;
    }
    else if (tableView == priceTable)  {
        
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
                price.frame = CGRectMake(mrpPrice.frame.origin.x + mrpPrice.frame.size.width, 0, priceLabel.frame.size.width+2, hlcell.frame.size.height);
                
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
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    //dismissing the catPopOver.......
    [catPopOver dismissPopoverAnimated:YES];
    
    if (tableView == productListTbl) {
        
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
    
    else if (tableView == shipModeTable) {
        
        shipmentModeTxt.text = shipModesArr[indexPath.row];
        [catPopOver dismissPopoverAnimated:YES];
    }
    else if (tableView == reqRefTable) {
        // HUD.tag = 1;
        @try {
            [catPopOver dismissPopoverAnimated:NO];
            requestRefNoTxt.text = requestRefId[indexPath.row];
            [HUD setHidden:NO];
            
            [self callingRequestRefIdDetails:requestRefId[indexPath.row]];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }
    //  Code for priceTable
    else if (tableView == priceTable) {
        
        @try {
            transparentView.hidden = YES;
            NSDictionary *detailsDic = priceDic[indexPath.row];
            
            BOOL status = FALSE;
            
            int i=0;
            NSMutableDictionary *dic;
            
            for ( i=0; i<requestedItemsInfoArr.count;i++) {
                
                dic = requestedItemsInfoArr[i];
                if ([[dic valueForKey:ITEM_SKU] isEqualToString:[detailsDic valueForKey:ITEM_SKU]] && [[dic valueForKey:PLU_CODE] isEqualToString:[detailsDic valueForKey:PLU_CODE]]) {
                    [dic setValue:[NSString stringWithFormat:@"%.2f",[[dic valueForKey:kMaxQuantity] floatValue] + 1] forKey:kMaxQuantity];
                    
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
        }
        @catch (NSException *exception) {
            
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


#pragma mark action need to implemented in this page:

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

-(void)populateSumaryInfo{
    @try {
        AudioServicesPlaySystemSound(soundFileObject);
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
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
            
//            if([[self checkGivenValueIsNullOrNil:[dic valueForKey:QUANTITY] defaultReturn:@"0.00"]floatValue] >= 0){
            
                totalPrice     += [[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_UNIT_PRICE] defaultReturn:@"0.00"]floatValue];
            
                totalStockQty  += [[self checkGivenValueIsNullOrNil:[dic valueForKey:AVAILABLE_QTY] defaultReturn:@"0.00"]floatValue];
            
                totalIssueQty  += [[self checkGivenValueIsNullOrNil:[dic valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue];
            
                totalBalanceQty +=  ([[dic valueForKey:AVAILABLE_QTY] floatValue] - [[dic valueForKey:QUANTITY] floatValue]);
//            }
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




#pragma mark closwe transparentView

/**
 * @description  we are closing the price view
 * @date         15/07/2017
 * @method       closePriceView
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)closePriceView:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        transparentView.hidden = YES;
        
    } @catch (NSException *exception) {
        
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
-(void)closeMultipleIssuesview:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);

    @try {
        multipleStoresTransparentView.hidden = YES;

        
    } @catch (NSException *exception) {
        
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
-(void)delRow:(UIButton *)sender{
    
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

-(void)displayAlertMessage:(NSString *)message    horizontialAxis:(float)xPostion  verticalAxis:(float)yPosition msgType:(NSString *)messageType   conentWidth:(float )labelWidth contentHeight:(float)labelHeight   isSoundRequired:(BOOL)soundStatus  timming:(float)noOfSecondsToDisplay    noOfLines:(int)noOfLines{
    
    
    //    [self displayAlertMessage: @"No Products Avaliable" horizontialAxis:segmentedControl.frame.origin.x   verticalAxis:segmentedControl.frame.origin.y  msgType:@"warning" timming:2.0];
    
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

/**
 * @description  removing alertMessage add in the  disPlayAlertMessage method
 * @date         18/11/2016
 * @method       removeAlertMessages
 * @author       Bhargav.v
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
        tableName.layer.cornerRadius = 2.0;
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

#pragma -mark mehod used to check whether received object in NULL or not

/**
 * @description  here we are checking whether the object is null or not
 * @date         17/01/2016
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

-(void)displayCategoriesList:(UIButton*)sender {
    
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
        headerNameLbl.text = NSLocalizedString(@"categories_list", nil) ;
        
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
        selectAllLbl.text = NSLocalizedString(@"select_all", nil);
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
        [okButton setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
        okButton.backgroundColor = [UIColor grayColor];
        okButton.layer.masksToBounds = YES;
        okButton.userInteractionEnabled = YES;
        okButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        okButton.layer.cornerRadius = 5.0f;
        [okButton addTarget:self action:@selector(multipleCategriesSelection:) forControlEvents:UIControlEventTouchDown];
        
        
        cancelButton = [[UIButton alloc] init] ;
        [cancelButton setTitle:NSLocalizedString(@"cancel", nil) forState:UIControlStateNormal];
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
            
            [popOver presentPopoverFromRect:selectCategoriesBtn.frame inView:stockIssueView permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
            
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
            
            
            //Recently Added By Bhargav.v on 26/10/2017....
            if (requestedItemsInfoArr.count) {
                
                [requestedItemsInfoArr removeAllObjects];
            }
            //up to here By Bhargav.v on 26/10/2017....
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

/**
 * @description  Yet this feature is yet to implement...
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
-(void)moreButtonPressed:(UIButton*)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        float y_axis = self.view.frame.size.height - 200;
        
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"currently_this_feature_is_unavailable", nil)];
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 320)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:400 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];

    } @catch (NSException * exception) {
        
    } @finally {
        
    }
}

/**
 * @description  feature yet  to enable currently we are dismissing the UIView...
 * @date         27/07/2017
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
        
        
        multipleStoresTransparentView.hidden = YES;
        
    } @catch (NSException *exception) {
        
    } @finally {
        
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
 * @modified BY
 * @reason
 *
 * @verified By
 * @verified On
 *
 */

-(void)getPriceListSkuDetailsSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        if (successDictionary != nil) {
            
            int  totalRecords = [[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:TOTAL_SKUS]  defaultReturn:@"0"]intValue];

            for(NSDictionary * newSkuItemDic in [successDictionary valueForKey:SKU_LIST]){
                
                //checking priceList is existing or not....
                if([[newSkuItemDic valueForKey:SKU_PRICE_LIST] count]){
                    
                    for(NSDictionary * newSkuPriceListDic in [newSkuItemDic valueForKey:SKU_PRICE_LIST]){
                        
                        
                        BOOL isExistingItem = false;
                        NSDictionary * existItemdic;
                        int i = 0;
                        
                        for (i = 0; i < requestedItemsInfoArr.count; i++) {
                            
                            //reading the existing cartItem....
                            existItemdic = requestedItemsInfoArr[i];
                            
                            if ([[existItemdic valueForKey:ITEM_SKU] isEqualToString:[newSkuPriceListDic valueForKey:ITEM_SKU]] && [[existItemdic valueForKey:PLU_CODE] isEqualToString:[newSkuPriceListDic valueForKey:PLU_CODE]]) {
                                
                                 [existItemdic setValue:[NSString stringWithFormat:@"%d",[[existItemdic valueForKey:QUANTITY] intValue] + 1] forKey:QUANTITY];
                                
                                requestedItemsInfoArr[i] = existItemdic;
                                
                                isExistingItem = true;
                                
                                break;
                            }
                        }
                        
//                        if(isExistingItem) {
//
//                            [requestedItemsInfoArr replaceObjectAtIndex:i withObject:existItemdic];
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
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:cost_Price] defaultReturn:@"0.00"] floatValue]] forKey:ITEM_UNIT_PRICE];
                            
                            //setting kSupplied for the rejectedQty key...
                            [itemDetailsDic setValue:@"0.00" forKey:kSupplied];
                            
                            //setting kRejected for the rejectedQty key...
                            [itemDetailsDic setValue:@"0.00" forKey:kRejected];
                            
                            //setting kReceived for the rejectedQty key...
                            [itemDetailsDic setValue:@"0.00" forKey:kReceived];
                            
                            //setting kMaxQuantity for the kMaxQuantity key...
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:kMaxQuantity] defaultReturn:@""] floatValue]] forKey:kMaxQuantity];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:kProductBrand] defaultReturn:@""] forKey:kBrand];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:kcategory] defaultReturn:@""] forKey:kcategory];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
                            
                            // CAlling from the main Dictionary....
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:MAKE] defaultReturn:@""] forKey:MAKE];
                            
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:QUANTITY_IN_HAND] defaultReturn:@"0.00"] floatValue]] forKey:AVAILABLE_QTY];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:TRACKING_REQUIRED] defaultReturn:ZERO_CONSTANT] forKey:TRACKING_REQUIRED];
                            
                            [itemDetailsDic setValue:EMPTY_STRING forKey:ITEM_SCAN_CODE];

                            // keys added by roja on  27-08-2018.....
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:UTILITY] defaultReturn:@" "] forKey:UTILITY];
                            
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:ISSUED];
                            
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:INDENT_QTY];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:kMeasureRange] defaultReturn:@""] forKey:MEASUREMENT_RANGE];

                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];

                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:EAN] defaultReturn:@""] forKey:EAN];

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
                        
                        [itemDetailsDic setValue:@"1.00" forKey:QUANTITY];
                        [itemDetailsDic setValue:@"0.00" forKey:BALANCE_QTY];
                        [itemDetailsDic setValue:@"0.00" forKey:COST];

                        //setting kSupplied for the rejectedQty key...
                        [itemDetailsDic setValue:@"0.00" forKey:kSupplied];
                        
                        //setting kRejected for the rejectedQty key...
                        [itemDetailsDic setValue:@"0.00" forKey:kRejected];
                        
                        //setting kReceived for the rejectedQty key...
                        [itemDetailsDic setValue:@"0.00" forKey:kReceived];
                       
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

                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:cost_Price] defaultReturn:@"0.00"] floatValue]] forKey:ITEM_UNIT_PRICE];
                    
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
            
            NSString * mesg = [NSString stringWithFormat:@"%d%@",totalRecords,NSLocalizedString(@"records_are_added_to_the_cart_successfully", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"cart_records", nil) conentWidth:400 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];

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
 * @param        NSString
 * @param
 * @return
 * @modified BY  Srinivasulu on 17/01/2016
 * @return
 * @verified By
 * @verified On
 */

-(void)getPriceListSKuDetailsErrorResponse:(NSString *)errorResponse {
    @try {
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 350;
        
        if(searchItemsTxt.isEditing)
            y_axis = searchItemsTxt.frame.origin.y + searchItemsTxt.frame.size.height;
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [requestedItemsTbl reloadData];
        [categoriesPopOver dismissPopoverAnimated:YES];
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
        
        if ([checkBoxArr[sender.tag] integerValue])
            checkBoxArr[sender.tag] = @"0";
        
        else
            
            checkBoxArr[sender.tag] = @"1";
        
    } @catch (NSException * exception) {
        
    } @finally {
        
        [categoriesTbl reloadData];
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
        
        if([locationCheckBoxArr[sender.tag] integerValue])
            
            locationCheckBoxArr[sender.tag] = @"0";
        
        else
            
            locationCheckBoxArr[sender.tag] = @"1";
        
        //Populating the location in to the text based on the object in location Check Box Array...
        if ([locationCheckBoxArr containsObject:@"1"]) {
            
            toStoreCodeTxt.text = locationArr[sender.tag];
        }
        else if ([locationCheckBoxArr containsObject:@"0"]){
            
            toStoreCodeTxt.text = @"";
        }
        
    } @catch (NSException * exception) {
        
    } @finally {
        
        [locationTable reloadData];
        
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


#pragma mark Super Class Methods.....
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
