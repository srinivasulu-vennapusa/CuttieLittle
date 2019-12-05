//
//  EditAndViewStockRequest.m
//  OmniRetailer
//
//  Created by    Bhargav Ram on 10/5/16.
//^
//

#import "NewStockRequest.h"
#import "OmniHomePage.h"
#import "StockRequest.h"

@interface NewStockRequest ()

@end

@implementation NewStockRequest

@synthesize soundFileURLRef,soundFileObject;

@synthesize selectIndex,requestID;


#pragma  -mark start of ViewLifeCycle mehods....

/**
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date         21/09/2016
 * @method       ViewDidLoad
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @modified BY
 * @reason
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
    NSURL * tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (__bridge CFURLRef) tapSound;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    //setting the backGroundColor to view....
    self.view.backgroundColor = [UIColor blackColor];
    
    self.titleLabel.text = NSLocalizedString(@"omni_retailer", nil);
    
    //ProgressBar creation...
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    // Show the HUD
    // HUD added by roja on 28-06-2018....
    [HUD show:YES];
    [HUD setHidden:YES];
    
    [HUD setLabelText:NSLocalizedString(@"please_wait..", nil)];
    
    //creating the stockRequestView which will displayed completed Screen.......
    stockRequestView = [[UIView alloc] init];
    stockRequestView.backgroundColor = [UIColor blackColor];
    stockRequestView.layer.borderWidth = 1.0f;
    stockRequestView.layer.cornerRadius = 10.0f;
    stockRequestView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    
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
    
    
    /*Creation of UIButton for providing user to select the requestDteFlds.......*/
    UIButton *summaryInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *summaryImage = [UIImage imageNamed:@"summaryInfo.png"];
    [summaryInfoBtn setBackgroundImage:summaryImage forState:UIControlStateNormal];
    [summaryInfoBtn addTarget:self
                       action:@selector(populatesummaryInfo) forControlEvents:UIControlEventTouchDown];
    
    //creation of customTextField.......
    fromStoreTxt = [[CustomTextField alloc] init];
    fromStoreTxt.delegate = self;
    fromStoreTxt.userInteractionEnabled = NO;
    fromStoreTxt.placeholder = NSLocalizedString(@"select_outlet",nil);
    [fromStoreTxt awakeFromNib];
    
    UIImage * loctnImg  = [UIImage imageNamed:@"arrow_1.png"];
    
    UIButton * selectLoctn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [selectLoctn setBackgroundImage:loctnImg forState:UIControlStateNormal];
    [selectLoctn addTarget:self
                    action:@selector(populateLocationsTable:) forControlEvents:UIControlEventTouchDown];
    selectLoctn.tag = 2;
    
    
    //creation of customTextField.......
    toLocationText = [[CustomTextField alloc] init];
    toLocationText.placeholder = NSLocalizedString(@"To Location",nil);
    toLocationText.delegate = self;
    [toLocationText awakeFromNib];
    toLocationText.userInteractionEnabled = NO;
    
    
    UIImage * wareHouseImg  = [UIImage imageNamed:@"arrow_1.png"];
    
    selctWareHouse = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [selctWareHouse setBackgroundImage:wareHouseImg forState:UIControlStateNormal];
    [selctWareHouse addTarget:self
                       action:@selector(populateLocationsTable:) forControlEvents:UIControlEventTouchDown];
    
    selctWareHouse.tag = 4;
    
    //creation of customTextField.......
    requestedBy = [[CustomTextField alloc] init];
    requestedBy.placeholder = NSLocalizedString(@"Requested By",nil);
    requestedBy.delegate = self;
    requestedBy.text =  firstName;
    requestedBy.userInteractionEnabled = NO;
    [requestedBy awakeFromNib];
    
    //creation of customTextField.......
    requestDteFld = [[CustomTextField alloc] init];
    requestDteFld.placeholder = NSLocalizedString(@"Request Date",nil);
    requestDteFld.delegate = self;
    [requestDteFld awakeFromNib];
    requestDteFld.userInteractionEnabled = NO;
    
    UIImage *buttonImageDD;
    UIImage * productListImg;
    UIButton * selectdelvryBtn;
    UIButton * selectrequestDteBtn;
    
    buttonImageDD = [UIImage imageNamed:@"Calandar_Icon.png"];
    
    selectrequestDteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectrequestDteBtn setBackgroundImage:buttonImageDD forState:UIControlStateNormal];
    [selectrequestDteBtn addTarget:self
                            action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    
    //creation of customTextField.......
    DeliveyDate = [[CustomTextField alloc] init];
    DeliveyDate.placeholder = NSLocalizedString(@"Delivery Date",nil);
    DeliveyDate.delegate = self;
    [DeliveyDate awakeFromNib];
    DeliveyDate.userInteractionEnabled = NO;
    
    selectdelvryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [selectdelvryBtn setBackgroundImage:buttonImageDD forState:UIControlStateNormal];
    [selectdelvryBtn addTarget:self
                        action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    
    //creation of customTextField.......
    shipmentModeTxt = [[CustomTextField alloc] init];
    shipmentModeTxt.placeholder = NSLocalizedString(@"Shipment Mode",nil);
    shipmentModeTxt.delegate = self;
    [shipmentModeTxt awakeFromNib];
    shipmentModeTxt.userInteractionEnabled = NO;
    
    
    UIButton * shipModeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImageSM = [UIImage imageNamed:@"arrow_1.png"];
    [shipModeButton setBackgroundImage:buttonImageSM forState:UIControlStateNormal];
    [shipModeButton addTarget:self action:@selector(getShipmentModes:) forControlEvents:UIControlEventTouchUpInside];
    
    //creation of customTextField.......
    priorityTxt = [[CustomTextField alloc] init];
    priorityTxt.placeholder = NSLocalizedString(@" Priority",nil);
    priorityTxt.delegate = self;
    [priorityTxt awakeFromNib];
    priorityTxt.userInteractionEnabled = NO;
    
    UIButton * priortyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *priorityImg = [UIImage imageNamed:@"arrow_1.png"];
    [priortyBtn setBackgroundImage:priorityImg forState:UIControlStateNormal];
    [priortyBtn addTarget:self action:@selector(populatePriorityList:) forControlEvents:UIControlEventTouchUpInside];
    
    
    outletIdTxt = [[CustomTextField alloc] init];
    outletIdTxt.delegate = self;
    outletIdTxt.placeholder = NSLocalizedString(@"outlet_id", nil);
    outletIdTxt.userInteractionEnabled  = NO;
    outletIdTxt.hidden = YES;
    [outletIdTxt awakeFromNib];
    
    zoneIdTxt = [[CustomTextField alloc] init];
    zoneIdTxt.placeholder = NSLocalizedString(@"zone_id", nil);
    zoneIdTxt.delegate = self;
    zoneIdTxt.userInteractionEnabled  = NO;
    [zoneIdTxt awakeFromNib];
    
    searchItemTxt = [[CustomTextField alloc] init];
    searchItemTxt.placeholder = NSLocalizedString(@"Search_Sku_Here", nil);
    searchItemTxt.delegate = self;
    [searchItemTxt awakeFromNib];
    searchItemTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchItemTxt.autocorrectionType = UITextAutocorrectionTypeNo;
    
    searchItemTxt.borderStyle = UITextBorderStyleRoundedRect;
    searchItemTxt.textColor = [UIColor blackColor];
    searchItemTxt.layer.borderColor = [UIColor clearColor].CGColor;
    searchItemTxt.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    searchItemTxt.font = [UIFont fontWithName:TEXT_FONT_NAME size:22];
    [searchItemTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    productListImg  = [UIImage imageNamed:@"btn_list.png"];
    
    selectCategoriesBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [selectCategoriesBtn setBackgroundImage:productListImg forState:UIControlStateNormal];
    [selectCategoriesBtn addTarget:self
                            action:@selector(validatingCategoriesList:) forControlEvents:UIControlEventTouchDown];
    
    /*creation of UILable's*/
    S_No  = [[CustomLabel alloc] init];
    [S_No awakeFromNib];
    
    skuId = [[CustomLabel alloc] init];
    [skuId awakeFromNib];
    
    descriptionLbl = [[CustomLabel alloc] init];
    [descriptionLbl awakeFromNib];
    
    uomLbl = [[CustomLabel alloc] init];
    [uomLbl awakeFromNib];
    
    gradeLbl = [[CustomLabel alloc] init];
    [gradeLbl awakeFromNib];
    
    priceLbl = [[CustomLabel alloc] init];
    [priceLbl awakeFromNib];
    
    qohLbl = [[CustomLabel alloc] init];
    [qohLbl awakeFromNib];
    
    prvIndentQtyLbl = [[CustomLabel alloc] init];
    [prvIndentQtyLbl awakeFromNib];
    
    projQtyLbl = [[CustomLabel alloc] init];
    [projQtyLbl awakeFromNib];
    
    qtyLbl = [[CustomLabel alloc] init];
    [qtyLbl awakeFromNib];
    
    approvedQtyLbl = [[CustomLabel alloc] init];
    [approvedQtyLbl awakeFromNib];
    
    actionLbl = [[CustomLabel alloc] init];
    [actionLbl awakeFromNib];
    
    
    S_No.text = NSLocalizedString(@"S No", nil);
    skuId.text = NSLocalizedString(@"sku_id", nil);
    descriptionLbl.text = NSLocalizedString(@"Desc", nil);
    uomLbl.text = NSLocalizedString(@"uom", nil);
    gradeLbl.text = NSLocalizedString(@"grade", nil);
    priceLbl.text = NSLocalizedString(@"Price", nil);
    qohLbl.text = NSLocalizedString(@"qoh", nil);
    prvIndentQtyLbl.text = NSLocalizedString(@"prv_indent_qty", nil);
    projQtyLbl.text = NSLocalizedString(@"proj_qty_lbl", nil);
    qtyLbl.text = NSLocalizedString(@"Req Qty", nil);
    approvedQtyLbl.text = NSLocalizedString(@"app_qty", nil);
    actionLbl.text = NSLocalizedString(@"action", nil);
    
    
    //Added By Bhargav on 25/10/2017...To Display the  total values of quantities in cart...
    
    quantityOnHandValueLbl = [[UILabel alloc] init];
    quantityOnHandValueLbl.layer.cornerRadius = 5;
    quantityOnHandValueLbl.layer.masksToBounds = YES;
    quantityOnHandValueLbl.backgroundColor = [UIColor blackColor];
    quantityOnHandValueLbl.layer.borderWidth = 2.0f;
    quantityOnHandValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    quantityOnHandValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    quantityOnHandValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    previousQtyValueLbl = [[UILabel alloc] init];
    previousQtyValueLbl.layer.cornerRadius = 5;
    previousQtyValueLbl.layer.masksToBounds = YES;
    previousQtyValueLbl.backgroundColor = [UIColor blackColor];
    previousQtyValueLbl.layer.borderWidth = 2.0f;
    previousQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    previousQtyValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    previousQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    projectedQtyValueLbl = [[UILabel alloc] init];
    projectedQtyValueLbl.layer.cornerRadius = 5;
    projectedQtyValueLbl.layer.masksToBounds = YES;
    projectedQtyValueLbl.backgroundColor = [UIColor blackColor];
    projectedQtyValueLbl.layer.borderWidth = 2.0f;
    projectedQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    projectedQtyValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    projectedQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    requestedQtyvalueLbl = [[UILabel alloc] init];
    requestedQtyvalueLbl.layer.cornerRadius = 5;
    requestedQtyvalueLbl.layer.masksToBounds = YES;
    requestedQtyvalueLbl.backgroundColor = [UIColor blackColor];
    requestedQtyvalueLbl.layer.borderWidth = 2.0f;
    requestedQtyvalueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    requestedQtyvalueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    requestedQtyvalueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    approvedQtyValueLbl = [[UILabel alloc] init];
    approvedQtyValueLbl.layer.cornerRadius = 5;
    approvedQtyValueLbl.layer.masksToBounds = YES;
    approvedQtyValueLbl.backgroundColor = [UIColor blackColor];
    approvedQtyValueLbl.layer.borderWidth = 2.0f;
    approvedQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    approvedQtyValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    approvedQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    quantityOnHandValueLbl.textAlignment = NSTextAlignmentCenter;
    previousQtyValueLbl.textAlignment    = NSTextAlignmentCenter;
    projectedQtyValueLbl.textAlignment   = NSTextAlignmentCenter;
    requestedQtyvalueLbl.textAlignment   = NSTextAlignmentCenter;
    approvedQtyValueLbl.textAlignment    = NSTextAlignmentCenter;
    
    quantityOnHandValueLbl.text = @"0.00";
    previousQtyValueLbl.text    = @"0.00";
    projectedQtyValueLbl.text   = @"0.00";
    requestedQtyvalueLbl.text   = @"0.00";
    approvedQtyValueLbl.text    = @"0.00";
    
    //upto here on 25/10/2017
    
    productListTbl = [[UITableView alloc] init];
    
    //creation of scroll view
    stockRequestScrollView = [[UIScrollView alloc]init];
    //stockRequestScrollView.backgroundColor = [UIColor lightGrayColor];
    
    //Table for storing the items ..
    requestedItemsTbl = [[UITableView alloc] init];
    requestedItemsTbl.backgroundColor = [UIColor blackColor];
    requestedItemsTbl.dataSource = self;
    requestedItemsTbl.delegate = self;
    requestedItemsTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    requestedItemsTbl.userInteractionEnabled = TRUE;
    
    //Allocaion of priority table..
    priorityTbl = [[UITableView alloc] init];
    
    //allocation of shipmentModeTable....
    shipModeTable = [[UITableView alloc] init];
    
    // creation of adjustable view:
    adjustableView = [[UIView alloc] init];
    
    submitBtn = [[UIButton alloc] init] ;
    submitBtn.backgroundColor = [UIColor grayColor];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.userInteractionEnabled = YES;
    submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    submitBtn.layer.cornerRadius = 5.0f;
    [submitBtn addTarget:self action:@selector(submitButonPressed:) forControlEvents:UIControlEventTouchDown];
  
    
    saveBtn = [[UIButton alloc] init] ;
    saveBtn.backgroundColor = [UIColor grayColor];
    saveBtn.layer.masksToBounds = YES;
    saveBtn.userInteractionEnabled = YES;
    saveBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    saveBtn.layer.cornerRadius = 5.0f;
    [saveBtn addTarget:self action:@selector(submitButonPressed:) forControlEvents:UIControlEventTouchDown];
    
    
    cancelButton = [[UIButton alloc] init];
    [cancelButton addTarget:self
                     action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchDown];
    cancelButton.layer.cornerRadius = 3.0f;
    cancelButton.backgroundColor = [UIColor grayColor];
    cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelButton.userInteractionEnabled = YES;
    
    @try {
        
    } @catch (NSException *exception) {
        
    }
    
    headerNameLbl.text = NSLocalizedString(@"newStock_request", nil);
    [submitBtn setTitle:NSLocalizedString(@"submit",nil) forState:UIControlStateNormal];
    [saveBtn setTitle:NSLocalizedString(@"save",nil) forState:UIControlStateNormal];
    [cancelButton setTitle:NSLocalizedString(@"cancel",nil) forState:UIControlStateNormal];
    
    priceTable = [[UITableView alloc] init];
    priceTable.backgroundColor = [UIColor blackColor];
    priceTable.dataSource = self;
    priceTable.delegate = self;
    priceTable.layer.cornerRadius = 3;
    
    closeBtn = [[UIButton alloc] init] ;
    [closeBtn addTarget:self action:@selector(closePriceView:) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.tag = 11;
    
    UIImage * image = [UIImage imageNamed:@"delete.png"];
    [closeBtn setBackgroundImage:image    forState:UIControlStateNormal];
    
    priceView = [[UIView alloc] init];
    priceView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6f];
    priceView.layer.borderColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7].CGColor;
    priceView.layer.borderWidth = 1.0;
    
    transparentView = [[UIView alloc]init];
    transparentView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6f];
    transparentView.hidden = YES;
    
    descLabl = [[CustomLabel alloc]init];
    [descLabl awakeFromNib];
    
    mrpLbl = [[CustomLabel alloc]init];
    [mrpLbl awakeFromNib];
    
    priceLabl = [[CustomLabel alloc]init];
    [priceLabl awakeFromNib];
    
    // added by roja on 30/04/2019...
    productBatchNoLabel = [[CustomLabel alloc]init];
    [productBatchNoLabel awakeFromNib];
    
    //added Srinivasulu on 12/05/2017....
    stockRequestItemsScrollView = [[UIScrollView alloc] init];
    
    sucessTransparentView = [[UIView alloc] init];
    sucessTransparentView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6f];
    sucessTransparentView.hidden = YES;
    
    
    //Allocation of  UIView For successView.....
    
    successView = [[UIView alloc] init];
    successView.backgroundColor = [UIColor blackColor];
    successView.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    successView.layer.borderWidth = 1.0;
    successView.layer.cornerRadius = 3.0f;
    
    UILabel * successHeaderNameLbl;
    
    successHeaderNameLbl = [[UILabel alloc] init];
    successHeaderNameLbl.layer.cornerRadius = 10.0f;
    successHeaderNameLbl.layer.masksToBounds = YES;
    successHeaderNameLbl.text = NSLocalizedString(@"indent_details",nil);
    
    successHeaderNameLbl.textAlignment = NSTextAlignmentCenter;
    successHeaderNameLbl.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
    successHeaderNameLbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gradient.png"]];
    successHeaderNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
    
    [successHeaderNameLbl.layer addSublayer:bottomBorder];
    
    UILabel * requestIDLbl;
    UILabel * outletIDLbl;
    UILabel * dateLbl;
    UILabel * statusLbl;
    UILabel * NoOfItemsLbl;
    UILabel * requestedQtyLbl;
    
    requestIDLbl = [[UILabel alloc] init];
    requestIDLbl.layer.masksToBounds = YES;
    requestIDLbl.numberOfLines = 1;
    requestIDLbl.textColor = [UIColor whiteColor];
    
    outletIDLbl = [[UILabel alloc] init];
    outletIDLbl.layer.masksToBounds = YES;
    outletIDLbl.numberOfLines = 1;
    outletIDLbl.textColor = [UIColor whiteColor];
    
    dateLbl = [[UILabel alloc] init];
    dateLbl.layer.masksToBounds = YES;
    dateLbl.numberOfLines = 1;
    dateLbl.textColor = [UIColor whiteColor];
    
    statusLbl = [[UILabel alloc] init];
    statusLbl.layer.masksToBounds = YES;
    statusLbl.numberOfLines = 1;
    statusLbl.textColor = [UIColor whiteColor];
    
    NoOfItemsLbl = [[UILabel alloc] init];
    NoOfItemsLbl.layer.masksToBounds = YES;
    NoOfItemsLbl.numberOfLines = 1;
    NoOfItemsLbl.textColor = [UIColor whiteColor];
    
    requestedQtyLbl = [[UILabel alloc] init];
    requestedQtyLbl.layer.masksToBounds = YES;
    requestedQtyLbl.numberOfLines = 1;
    requestedQtyLbl.textColor = [UIColor whiteColor];
    
    UILabel *semi_colon_1;
    UILabel *semi_colon_2;
    UILabel *semi_colon_3;
    UILabel *semi_colon_4;
    UILabel *semi_colon_5;
    UILabel *semi_colon_6;
    
    
    semi_colon_1 = [[UILabel alloc] init];
    semi_colon_2 = [[UILabel alloc] init];
    semi_colon_3 = [[UILabel alloc] init];
    semi_colon_4 = [[UILabel alloc] init];
    semi_colon_5 = [[UILabel alloc] init];
    semi_colon_6 = [[UILabel alloc] init];
    
    
    UIButton * okButton;
    
    okButton = [[UIButton alloc] init] ;
    okButton.backgroundColor = [UIColor grayColor];
    okButton.layer.masksToBounds = YES;
    okButton.userInteractionEnabled = YES;
    okButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    okButton.layer.cornerRadius = 5.0f;
    [okButton addTarget:self action:@selector(okButtonPressed:) forControlEvents:UIControlEventTouchDown];
    
    requestIdValueLbl = [[UILabel alloc] init];
    requestIdValueLbl.layer.masksToBounds = YES;
    requestIdValueLbl.numberOfLines = 1;
    requestIdValueLbl.textColor = [UIColor whiteColor];
    
    outletIdValueLbl = [[UILabel alloc] init];
    outletIdValueLbl.layer.masksToBounds = YES;
    outletIdValueLbl.numberOfLines = 1;
    outletIdValueLbl.textColor = [UIColor whiteColor];
    
    dateValueLbl = [[UILabel alloc] init];
    dateValueLbl.layer.masksToBounds = YES;
    dateValueLbl.numberOfLines = 1;
    dateValueLbl.textColor = [UIColor whiteColor];
    
    statusValueLbl = [[UILabel alloc] init];
    statusValueLbl.layer.masksToBounds = YES;
    statusValueLbl.numberOfLines = 1;
    statusValueLbl.textColor = [UIColor whiteColor];
    
    NoOfItemsValueLbl = [[UILabel alloc] init];
    NoOfItemsValueLbl.layer.masksToBounds = YES;
    NoOfItemsValueLbl.numberOfLines = 1;
    NoOfItemsValueLbl.textColor = [UIColor whiteColor];
    
    totalRequestedQtyValueLbl = [[UILabel alloc] init];
    totalRequestedQtyValueLbl.layer.masksToBounds = YES;
    totalRequestedQtyValueLbl.numberOfLines = 1;
    totalRequestedQtyValueLbl.textColor = [UIColor whiteColor];
    
    
    
    requestIDLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    outletIDLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    dateLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    statusLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    NoOfItemsLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    requestedQtyLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    requestIdValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    outletIdValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    dateValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    statusValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    NoOfItemsValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    totalRequestedQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    
    
    
    semi_colon_1.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    semi_colon_2.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    semi_colon_3.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    semi_colon_4.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    semi_colon_5.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    semi_colon_6.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    
    requestIDLbl.textAlignment    = NSTextAlignmentLeft;
    outletIDLbl.textAlignment     = NSTextAlignmentLeft;
    dateLbl.textAlignment         = NSTextAlignmentLeft;
    statusLbl.textAlignment       = NSTextAlignmentLeft;
    NoOfItemsLbl.textAlignment    = NSTextAlignmentLeft;
    requestedQtyLbl.textAlignment = NSTextAlignmentLeft;
    
    
    requestIdValueLbl.textAlignment    = NSTextAlignmentLeft;
    outletIdValueLbl.textAlignment     = NSTextAlignmentLeft;
    dateValueLbl.textAlignment         = NSTextAlignmentLeft;
    statusValueLbl.textAlignment       = NSTextAlignmentLeft;
    NoOfItemsValueLbl.textAlignment    = NSTextAlignmentLeft;
    totalRequestedQtyValueLbl.textAlignment = NSTextAlignmentLeft;
    
    
    
    requestIDLbl.text =  NSLocalizedString(@"request_id", nil);
    outletIDLbl.text =  NSLocalizedString(@"outlet_id", nil);
    dateLbl.text =  NSLocalizedString(@"date", nil);
    statusLbl.text =  NSLocalizedString(@"status", nil);
    NoOfItemsLbl.text =  NSLocalizedString(@"no_of_items", nil);
    requestedQtyLbl.text =  NSLocalizedString(@"requested_qty", nil);
    
    //priceList Labels...
    
    descLabl.text = NSLocalizedString(@"description", nil);
    mrpLbl.text = NSLocalizedString(@"mrp_rps", nil);
    priceLabl.text = NSLocalizedString(@"price", nil);
    productBatchNoLabel.text = NSLocalizedString(@"Batch No.", nil); // added by roja
    
    semi_colon_1.text = NSLocalizedString(@":", nil);
    semi_colon_2.text = NSLocalizedString(@":", nil);
    semi_colon_3.text = NSLocalizedString(@":", nil);
    semi_colon_4.text = NSLocalizedString(@":", nil);
    semi_colon_5.text = NSLocalizedString(@":", nil);
    semi_colon_6.text = NSLocalizedString(@":", nil);
    
    [okButton setTitle:NSLocalizedString(@"OK",nil) forState:UIControlStateNormal];
    
    
    //upto here on 12/05/2017....
    
    [stockRequestView addSubview:headerNameLbl];
    [stockRequestView addSubview:summaryInfoBtn];
    [stockRequestView addSubview:fromStoreTxt];
    [stockRequestView addSubview:toLocationText];
    [stockRequestView addSubview:requestedBy];
    [stockRequestView addSubview:requestDteFld];
    [stockRequestView addSubview:DeliveyDate];
    [stockRequestView addSubview:shipmentModeTxt];
    [stockRequestView addSubview:priorityTxt];
    [stockRequestView addSubview:outletIdTxt];
    [stockRequestView addSubview:zoneIdTxt];
    
    //Recently made modification made by Bhargav.v
    //    checking the HUB Level..to get the outlet locations...on 27/06/2017
    
    [stockRequestView addSubview:selctWareHouse];
    [stockRequestView addSubview:selectrequestDteBtn];
    [stockRequestView addSubview:shipModeButton];
    [stockRequestView addSubview:selectdelvryBtn];
    [stockRequestView addSubview:priortyBtn];
    [stockRequestView addSubview:selectLoctn];
    
    [stockRequestView addSubview:searchItemTxt];
    [stockRequestView addSubview:selectCategoriesBtn];
    
    [stockRequestView addSubview:adjustableView];
    
    [stockRequestScrollView addSubview:S_No];
    [stockRequestScrollView addSubview:skuId];
    
    [stockRequestScrollView addSubview:descriptionLbl];
    [stockRequestScrollView addSubview:uomLbl];
    [stockRequestScrollView addSubview:gradeLbl];
    [stockRequestScrollView addSubview:priceLbl];
    [stockRequestScrollView addSubview:qohLbl];
    [stockRequestScrollView addSubview:prvIndentQtyLbl];
    [stockRequestScrollView addSubview:projQtyLbl];
    
    [stockRequestScrollView addSubview:qtyLbl];
    [stockRequestScrollView addSubview:approvedQtyLbl];
    [stockRequestScrollView addSubview:actionLbl];
    [stockRequestScrollView addSubview:requestedItemsTbl];
    [stockRequestView addSubview:stockRequestScrollView];
    
    //upto here on 12/05/2017....
    
    [stockRequestView addSubview:productListTbl];
    
    [stockRequestView addSubview:saveBtn];
    [stockRequestView addSubview:submitBtn];
    [stockRequestView addSubview:cancelButton];
    
    [stockRequestView addSubview:quantityOnHandValueLbl];
    [stockRequestView addSubview:previousQtyValueLbl];
    [stockRequestView addSubview:projectedQtyValueLbl];
    [stockRequestView addSubview:requestedQtyvalueLbl];
    [stockRequestView addSubview:approvedQtyValueLbl];
    
    //Adding  successView for the stockRequestView..
    
    [sucessTransparentView addSubview:successView];
    
    [successView addSubview:successHeaderNameLbl];
    [successView addSubview:requestIDLbl];
    [successView addSubview:outletIDLbl];
    [successView addSubview:dateLbl];
    [successView addSubview:statusLbl];
    [successView addSubview:NoOfItemsLbl];
    [successView addSubview:requestedQtyLbl];
    
    [successView addSubview:semi_colon_1];
    [successView addSubview:semi_colon_2];
    [successView addSubview:semi_colon_3];
    [successView addSubview:semi_colon_4];
    [successView addSubview:semi_colon_5];
    [successView addSubview:semi_colon_6];
    
    [successView addSubview:requestIdValueLbl];
    [successView addSubview:outletIdValueLbl];
    [successView addSubview:dateValueLbl];
    [successView addSubview:statusValueLbl];
    [successView addSubview:NoOfItemsValueLbl];
    [successView addSubview:totalRequestedQtyValueLbl];
    
    [successView addSubview:okButton];
    
    //modified By Bhargav.v
    [priceView addSubview:priceLabl];
    [priceView addSubview:mrpLbl];
    [priceView addSubview:descLabl];
    [priceView addSubview:productBatchNoLabel];  // added by roja
    [priceView addSubview:priceTable];
    [transparentView addSubview:priceView];
    [transparentView addSubview:closeBtn];
    
    
    
    [self.view addSubview:stockRequestView];
    
    [self.view addSubview:transparentView];
    
    [self.view addSubview:sucessTransparentView];
    
    if (currentOrientation==UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            //setting frame for the main view....
            stockRequestView.frame = CGRectMake(2,70, self.view.frame.size.width - 4, self.view.frame.size.height - 80);
            
            //setting frame for the headerNameLbl....
            headerNameLbl.frame = CGRectMake( 0, 0, stockRequestView.frame.size.width, 45);
            
            //setting frame for the summaryInfoButton && hiding it here itself because not in use....
            
            summaryInfoBtn.frame = CGRectMake(stockRequestView.frame.size.width - 45,headerNameLbl.frame.origin.y +  headerNameLbl.frame.size.height+5 , 35, 30);
            //            summaryInfoBtn.hidden = YES;
            
            //setting frame for the customtextFields...
            
            float textFieldWidth = 200;
            float textFieldHeight = 40;
            float horizontalGap = 40;
            float verticalGap = 10;
            
            zoneIdTxt.frame = CGRectMake(10,summaryInfoBtn.frame.origin.y+5,textFieldWidth,textFieldHeight);
            
            requestDteFld.frame = CGRectMake(zoneIdTxt.frame.origin.x+zoneIdTxt.frame.size.width+horizontalGap,zoneIdTxt.frame.origin.y,textFieldWidth,textFieldHeight);
            
            priorityTxt.frame = CGRectMake(requestDteFld.frame.origin.x+requestDteFld.frame.size.width+horizontalGap,zoneIdTxt.frame.origin.y,textFieldWidth,textFieldHeight);
            
            toLocationText.frame = CGRectMake(priorityTxt.frame.origin.x+priorityTxt.frame.size.width+horizontalGap,zoneIdTxt.frame.origin.y,textFieldWidth,textFieldHeight);
            
            //column 2
            
            requestedBy.frame = CGRectMake(zoneIdTxt.frame.origin.x,zoneIdTxt.frame.origin.y+zoneIdTxt.frame.size.height+verticalGap,textFieldWidth,textFieldHeight);
            
            DeliveyDate.frame = CGRectMake(requestDteFld.frame.origin.x,requestedBy.frame.origin.y,textFieldWidth,textFieldHeight);
            
            shipmentModeTxt.frame = CGRectMake(priorityTxt.frame.origin.x,DeliveyDate.frame.origin.y,textFieldWidth,textFieldHeight);
            
            fromStoreTxt.frame = CGRectMake(toLocationText.frame.origin.x, shipmentModeTxt.frame.origin.y, textFieldWidth, textFieldHeight);
            
            // frame for the buton actions...
            
            selctWareHouse.frame = CGRectMake((toLocationText.frame.origin.x+toLocationText.frame.size.width-45), toLocationText.frame.origin.y-8,55,60);
            
            //Changes made as per the freshword documentation...
            selectLoctn.frame = CGRectMake((fromStoreTxt.frame.origin.x+fromStoreTxt.frame.size.width-45), fromStoreTxt.frame.origin.y-8,  55, 60);
            
            shipModeButton.frame = CGRectMake((shipmentModeTxt.frame.origin.x+shipmentModeTxt.frame.size.width-45), shipmentModeTxt.frame.origin.y-8, 55,60);
            
            selectrequestDteBtn.frame = CGRectMake((requestDteFld.frame.origin.x+requestDteFld.frame.size.width-45), requestDteFld.frame.origin.y+2, 40,35);
            
            selectdelvryBtn.frame = CGRectMake((DeliveyDate.frame.origin.x+DeliveyDate.frame.size.width-45), DeliveyDate.frame.origin.y+2, 40, 35);
            
            priortyBtn.frame = CGRectMake((priorityTxt.frame.origin.x+priorityTxt.frame.size.width-45), priorityTxt.frame.origin.y-8, 55, 60);
            
            // Upto Here on 26/06/2017.. By Bhargav.v
            
            searchItemTxt.frame = CGRectMake(zoneIdTxt.frame.origin.x,requestedBy.frame.origin.y+requestedBy.frame.size.height+15,summaryInfoBtn.frame.origin.x+summaryInfoBtn.frame.size.width -(zoneIdTxt.frame.origin.x+80), 40);
            
            selectCategoriesBtn.frame = CGRectMake((searchItemTxt.frame.origin.x+searchItemTxt.frame.size.width + 5),searchItemTxt.frame.origin.y,75,searchItemTxt.frame.size.height);
            
            //frame for successView
            
            // frame for the UIButtons...
            submitBtn.frame = CGRectMake(searchItemTxt.frame.origin.x,stockRequestView.frame.size.height-45,140,40);
            saveBtn.frame = CGRectMake(submitBtn.frame.origin.x+submitBtn.frame.size.width+20,submitBtn.frame.origin.y,140,40);
            cancelButton.frame = CGRectMake(saveBtn.frame.origin.x+saveBtn.frame.size.width+20,submitBtn.frame.origin.y,140,40);
            
            // frame for the adjustableView...
            adjustableView.frame = CGRectMake(stockRequestView.frame.origin.x, submitBtn.frame.origin.y -  (taxesValueLbl.frame.origin.y +  taxesValueLbl.frame.size.height + 10), stockRequestView.frame.size.width, (taxesValueLbl.frame.origin.y +  taxesValueLbl.frame.size.height + 10 ));
            
            // frame for the stockRequestScrollView...
            
            stockRequestScrollView.frame = CGRectMake(searchItemTxt.frame.origin.x,searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height +5, searchItemTxt.frame.size.width+120,adjustableView.frame.origin.y - (searchItemTxt.frame.origin.y+searchItemTxt.frame.size.height + 10));
            
            // frame for the header Section Labels...
            
            S_No.frame = CGRectMake(0,0,60,35);
            
            skuId.frame = CGRectMake(S_No.frame.origin.x+S_No.frame.size.width+2,S_No.frame.origin.y,110,S_No.frame.size.height);
            
            descriptionLbl.frame = CGRectMake(skuId.frame.origin.x+skuId.frame.size.width+2,skuId.frame.origin.y,150,skuId.frame.size.height);
            
            uomLbl.frame = CGRectMake( descriptionLbl.frame.origin.x + descriptionLbl.frame.size.width + 2 , descriptionLbl.frame.origin.y ,70, descriptionLbl.frame.size.height);
            
            gradeLbl.frame = CGRectMake( uomLbl.frame.origin.x + uomLbl.frame.size.width + 2 , descriptionLbl.frame.origin.y ,80, descriptionLbl.frame.size.height);
            
            //priceLbl.frame = CGRectMake( gradeLbl.frame.origin.x + gradeLbl.frame.size.width + 2 , descriptionLbl.frame.origin.y ,70, descriptionLbl.frame.size.height);
            
            qohLbl.frame = CGRectMake( gradeLbl.frame.origin.x + gradeLbl.frame.size.width + 2 , descriptionLbl.frame.origin.y ,70, descriptionLbl.frame.size.height);
            
            prvIndentQtyLbl.frame = CGRectMake( qohLbl.frame.origin.x + qohLbl.frame.size.width + 2 , descriptionLbl.frame.origin.y ,80, descriptionLbl.frame.size.height);
            
            projQtyLbl.frame = CGRectMake( prvIndentQtyLbl.frame.origin.x + prvIndentQtyLbl.frame.size.width + 2 , descriptionLbl.frame.origin.y ,70, descriptionLbl.frame.size.height);
            
            qtyLbl.frame = CGRectMake(projQtyLbl.frame.origin.x+projQtyLbl.frame.size.width + 2 , descriptionLbl.frame.origin.y ,90, descriptionLbl.frame.size.height);
            
            approvedQtyLbl.frame = CGRectMake(qtyLbl.frame.origin.x+qtyLbl.frame.size.width+2,qtyLbl.frame.origin.y ,100,qtyLbl.frame.size.height);
            
            actionLbl.frame = CGRectMake(approvedQtyLbl.frame.origin.x +approvedQtyLbl.frame.size.width+2 , approvedQtyLbl.frame.origin.y,100,approvedQtyLbl.frame.size.height);
            
            
            // Added By Bhargav.v on 12/11/2017...
            // Reason: To Display the Success alert view with the following details...
            
            sucessTransparentView.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
            
            successView.frame = CGRectMake(DeliveyDate.frame.origin.x+20,320,shipmentModeTxt.frame.origin.x+shipmentModeTxt.frame.size.width-(DeliveyDate.frame.origin.x),310);
            
            successHeaderNameLbl.frame = CGRectMake(0,0, successView.frame.size.width,40);
            
            requestIDLbl.frame = CGRectMake(10,successHeaderNameLbl.frame.origin.y+successHeaderNameLbl.frame.size.height+5,140,40);
            
            
            outletIDLbl.frame = CGRectMake(requestIDLbl.frame.origin.x,requestIDLbl.frame.origin.y+requestIDLbl.frame.size.height-5,140,40);
            
            dateLbl.frame = CGRectMake(requestIDLbl.frame.origin.x,outletIDLbl.frame.origin.y+outletIDLbl.frame.size.height-5,140,40);
            
            statusLbl.frame = CGRectMake(requestIDLbl.frame.origin.x,dateLbl.frame.origin.y+dateLbl.frame.size.height-5,140,40);
            
            NoOfItemsLbl.frame = CGRectMake(requestIDLbl.frame.origin.x, statusLbl.frame.origin.y+statusLbl.frame.size.height-5, 140,40);
            
            requestedQtyLbl.frame = CGRectMake(requestIDLbl.frame.origin.x, NoOfItemsLbl.frame.origin.y+NoOfItemsLbl.frame.size.height-5, 140,40);
            
            
            semi_colon_1.frame = CGRectMake(requestIDLbl.frame.origin.x+requestIDLbl.frame.size.width+10, requestIDLbl.frame.origin.y,5 , requestIDLbl.frame.size.height);
            
            semi_colon_2.frame = CGRectMake(semi_colon_1.frame.origin.x, outletIDLbl.frame.origin.y,5 , requestIDLbl.frame.size.height);
            
            semi_colon_3.frame = CGRectMake(semi_colon_1.frame.origin.x, dateLbl.frame.origin.y,5 , requestIDLbl.frame.size.height);
            
            semi_colon_4.frame = CGRectMake(semi_colon_1.frame.origin.x, statusLbl.frame.origin.y,5 , requestIDLbl.frame.size.height);
            
            semi_colon_5.frame = CGRectMake(semi_colon_1.frame.origin.x, NoOfItemsLbl.frame.origin.y,5 , requestIDLbl.frame.size.height);
            
            semi_colon_6.frame = CGRectMake(semi_colon_1.frame.origin.x, requestedQtyLbl.frame.origin.y,5 , requestIDLbl.frame.size.height);
            
            
            
            requestIdValueLbl.frame = CGRectMake(semi_colon_1.frame.origin.x+semi_colon_1.frame.size.width+10,requestIDLbl.frame.origin.y,180,40);
            
            outletIdValueLbl.frame = CGRectMake(requestIdValueLbl.frame.origin.x,outletIDLbl.frame.origin.y,140,40);
            
            dateValueLbl.frame = CGRectMake(requestIdValueLbl.frame.origin.x,dateLbl.frame.origin.y,140,40);
            
            statusValueLbl.frame = CGRectMake(requestIdValueLbl.frame.origin.x,statusLbl.frame.origin.y,140,40);
            
            NoOfItemsValueLbl.frame = CGRectMake(requestIdValueLbl.frame.origin.x,NoOfItemsLbl.frame.origin.y,140,40);
            
            totalRequestedQtyValueLbl.frame = CGRectMake(requestIdValueLbl.frame.origin.x,requestedQtyLbl.frame.origin.y,120,40);
            
            
            okButton.frame = CGRectMake(requestIdValueLbl.frame.origin.x,requestedQtyLbl.frame.origin.y+requestedQtyLbl.frame.size.height,100,40);
            
            //upto here on 12/11/2017...
            
            
            requestedItemsTbl.frame = CGRectMake(0,S_No.frame.origin.y+S_No.frame.size.height,actionLbl.frame.origin.x + actionLbl.frame.size.width + 50,stockRequestScrollView.frame.size.height -(S_No.frame.origin.y + S_No.frame.size.height));
            
            // for calculating the totalItems & total Quantity...
            
            quantityOnHandValueLbl.frame = CGRectMake(qohLbl.frame.origin.x+8,submitBtn.frame.origin.y, qohLbl.frame.size.width,qohLbl.frame.size.height);
            
            previousQtyValueLbl.frame = CGRectMake(prvIndentQtyLbl.frame.origin.x+8,quantityOnHandValueLbl.frame.origin.y, prvIndentQtyLbl.frame.size.width,prvIndentQtyLbl.frame.size.height);
            
            projectedQtyValueLbl.frame = CGRectMake(projQtyLbl.frame.origin.x+8,quantityOnHandValueLbl.frame.origin.y, projQtyLbl.frame.size.width,projQtyLbl.frame.size.height);
            
            requestedQtyvalueLbl.frame = CGRectMake(qtyLbl.frame.origin.x+8,quantityOnHandValueLbl.frame.origin.y, qtyLbl.frame.size.width,qtyLbl.frame.size.height);
            
            approvedQtyValueLbl.frame = CGRectMake(approvedQtyLbl.frame.origin.x+8,quantityOnHandValueLbl.frame.origin.y, approvedQtyLbl.frame.size.width,approvedQtyLbl.frame.size.height);
            
            
            //stockRequestScrollView.contentSize = CGSizeMake(requestedItemsTbl.frame.size.width,  stockRequestScrollView.frame.size.height);
            
            //frame for the Transparent view:
            
            transparentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            
//            priceView.frame = CGRectMake(200, 300, 490,300);
            
            descLabl.frame = CGRectMake(0,5,180, 35);
            mrpLbl.frame = CGRectMake(descLabl.frame.origin.x+descLabl.frame.size.width+2,descLabl.frame.origin.y, 150, 35);
            priceLabl.frame = CGRectMake(mrpLbl.frame.origin.x+mrpLbl.frame.size.width+2, descLabl.frame.origin.y, 150, 35);
            
            // added by roja on 30/04/2019...
            productBatchNoLabel.frame = CGRectMake(priceLabl.frame.origin.x + priceLabl.frame.size.width + 2, descLabl.frame.origin.y, 200, 35);

            priceView.frame = CGRectMake(200, 300, productBatchNoLabel.frame.origin.x + productBatchNoLabel.frame.size.width, 300);
            //Upto here added by roja on 30/04/2019...

            priceTable.frame = CGRectMake(descLabl.frame.origin.x,descLabl.frame.origin.y+descLabl.frame.size.height+5, productBatchNoLabel.frame.origin.x+productBatchNoLabel.frame.size.width - (descLabl.frame.origin.x), priceView.frame.size.height - (descLabl.frame.origin.y + descLabl.frame.size.height+20));
            
            closeBtn.frame = CGRectMake(priceView.frame.size.width+165, priceView.frame.origin.y-38, 40, 40);
            
        }
    }
    
    else{
        
    }
    //////----End------///
    
    
    //here we are setting font to all subview to mainView.....
    
    @try {
        [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:16.0f cornerRadius:3.0f];
        headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
        
        //submitBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        
    } @catch (NSException *exception) {
        NSLog(@"---- exception while setting the fontSize to subViews ----%@",exception);
    }
    
    //Checking the HUB Level to
    
    if (isHubLevel) {
        zoneIdTxt.text = zoneID;
        selctWareHouse.hidden = NO;
        selectLoctn.hidden = NO;
        
        
    }
    else {
        @try {
            zoneIdTxt.text = zoneID;
            fromStoreTxt.text = presentLocation;
            //toLocationText.text = wareHouseIdStr;
            
            //selctWareHouse.hidden = YES;
            selectLoctn.hidden = YES;
            
        } @catch (NSException * exception) {
        }
    }
    
    // Setting the Request Date as a current date..
    NSDate *today = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"dd/MM/yyyy";
    NSString* currentdate = [f stringFromDate:today];
    requestDteFld.text = currentdate;

    //Used for identification purpose....
    selectrequestDteBtn.tag = 2;
    selectdelvryBtn.tag = 4;
    submitBtn.tag = 4;
    saveBtn.tag = 2;
    isPacked = [NSMutableArray new];
}


/**
 * @description  it is one of ViewLifeCylce Method which will be executed after execution of
 viewDidAppear.......
 * @date         21/09/2016
 * @method       viewWillAppear
 * @author       Bhargav Ram
 * @param        BOOL
 * @param
 * @return
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */

- (void) viewWillAppear:(BOOL)animated {
    
    //calling the superClass method.......
    [super viewWillAppear:YES];
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

-(void)viewDidAppear:(BOOL)animated{
    
    //calling super call.....
    [super viewDidAppear:YES];
    
    @try {
        if (requestID != nil) {
            
            // HUD added by roja on 28-06-2018....
            [HUD setHidden:NO];
            [self callingStockRequestDetails];
        }
    } @catch (NSException * exception) {
        // HUD added by roja on 28-06-2018....
        [HUD setHidden:YES];
        
    } @finally {
        if (rawMaterialDetails == nil)
            rawMaterialDetails = [NSMutableArray new];
    }
}
#pragma -mark end of ViewLifeCylce Methods....



/**
 * @description  it will be executed when memory warning is receiveds.......
 * @date         21/09/2016
 * @method       didReceiveMemoryWarning
 * @author       Bhargav Ram
 * @param
 * @param
 * @return
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  -mark  start of service calls


/**
 * @description  here we are calling searchSku.......
 * @date         21/09/2016
 * @method       callRawMaterials
 * @author       Bhargav Ram
 * @param        NSString
 * @param
 * @return
 *
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       hiding the HUD in catch block....
 *
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callRawMaterials:(NSString *)searchString {
    
    @try {
//        [HUD show:YES];
        [HUD setHidden: NO];
        
        //productList  =[NSMutableArray new];
        
        NSMutableDictionary * searchProductDic = [[NSMutableDictionary alloc] init];
        
        searchProductDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        searchProductDic[START_INDEX] = @"0";
        searchProductDic[kSearchCriteria] = searchItemTxt.text;
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
 * @description  this method is used to call skuList.......
 * @date         21/09/2016
 * @method       callRawMaterialDetails
 * @author       Bhargav Ram
 * @param
 * @param
 * @return
 *
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       hiding the HUD in catch block....
 *
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)callRawMaterialDetails:(NSString *)pluCodeStr {
    
    @try {
//        [HUD show:YES];
        [HUD setHidden: NO];
        
        NSMutableDictionary * productDetailsDic = [[NSMutableDictionary alloc] init];
        
        productDetailsDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        productDetailsDic[kStoreLocation] = presentLocation;
        productDetailsDic[ITEM_SKU] = pluCodeStr;
        productDetailsDic[START_INDEX] = NEGATIVE_ONE;
        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:productDetailsDic options:0 error:&err];
        NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.getSkuDetailsDelegate = self;
        [webServiceController getSKUStockInformation:salesReportJsonString];
    }
    @catch (NSException *exception) {
        
        [HUD setHidden: YES];
        float y_axis = self.view.frame.size.height - 120;
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    //[HUD hide:YES afterDelay:1.0];
}



/**
 * @description  this method is used to get the locations based on bussinessActivty...
 * @date         21/09/2016
 * @method       getLocations
 * @author       Bhargav Ram
 * @param        int
 * @param        NSString
 * @return
 *
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       hiding the HUD in catch block....
 *
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getLocations:(int)selectIndex businessActivity:(NSString *) businessActivity {
    
    @try {
        
        [HUD setHidden: NO];
        
        
        NSArray *loyaltyKeys = @[START_INDEX,REQUEST_HEADER,BUSSINESS_ACTIVITY];
        
        NSArray *loyaltyObjects = @[@"0",[RequestHeader getRequestHeader],businessActivity];
        
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        
        NSError  * err_;
        NSData   * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.utilityMasterDelegate = self;
        [webServiceController getAllLocationDetailsData:loyaltyString];
        
    } @catch (NSException *exception) {
        
        [HUD setHidden: YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @finally {
        
    }
}

#pragma mark Get Categories

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
    //Play Audio for button touch....
    AudioServicesPlaySystemSound(soundFileObject);

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
        
        [HUD setHidden: YES];
        float y_axis = self.view.frame.size.height - 120;
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
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
        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:locationWiseCategoryDictionary options: 0 error: &err];
        NSString * getProductsJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@--json product Categories String--",getProductsJsonString);
        
        WebServiceController  * webServiceController = [WebServiceController new];
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
 * @description  we are calling the stock Request details which are only in Draft status...
 * @date         21/09/2016
 * @method       callStockRequestDetails
 * @author       Bhargav Ram
 * @param        NSString
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callingStockRequestDetails {
    @try {
       
        [HUD show:YES];
        [HUD setHidden:NO];
        HUD.labelText =  NSLocalizedString(@"please_wait..",nil);

        NSArray * headerKeys_ = @[STOCK_REQUEST_ID,REQUEST_HEADER,kLocation,IS_DRAFT_REQUIRED];
        
        NSArray *headerObjects_ = @[requestID,[RequestHeader getRequestHeader],presentLocation,[NSNumber numberWithBool:true]];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects_ forKeys:headerKeys_];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * quoteRequestJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.stockRequestDelegate = self;
        [webServiceController getAllStockRequest:quoteRequestJsonString];
    }
    @catch (NSException * exception) {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        NSLog(@"----exception in service Call------%@",exception);
    }
    
}


#pragma -mark start of handling service call reponses


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

-(void)getCategoriesByLocationSuccessResponse:(NSDictionary *)sucessDictionary {
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
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       searchProductsSuccessResponse:
 * @author       Bhargav Ram
 * @param        NSDictionary
 * @param
 * @return
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the populating date directly to method....
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)searchProductsSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        //checking searchItemsFieldTag.......
        if (successDictionary != nil && (searchItemTxt.tag == (searchItemTxt.text).length) ) {
            
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
                
                [self showPopUpForTables:productListTbl  popUpWidth:searchItemTxt.frame.size.width  popUpHeight:tableHeight presentPopUpAt:searchItemTxt  showViewIn:stockRequestView permittedArrowDirections:UIPopoverArrowDirectionUp];
            }
            else if(catPopOver.popoverVisible)
                [catPopOver dismissPopoverAnimated:YES];
            searchItemTxt.tag = 0;
            [HUD setHidden:YES];
        }
        
        else if ( (((searchItemTxt.text).length >= 3) && (searchItemTxt.tag != 0)) && (searchItemTxt.tag != (searchItemTxt.text).length)) {
            
            searchItemTxt.tag = 0;
            
            [self textFieldDidChange:searchItemTxt];
        }
        else  if(catPopOver.popoverVisible || (searchItemTxt.tag == (searchItemTxt.text).length)){
            [catPopOver dismissPopoverAnimated:YES];
            searchItemTxt.tag = 0;
            [HUD setHidden:YES];
        }
        else {
            
            [catPopOver dismissPopoverAnimated:YES];
            searchItemTxt.tag = 0;
            [HUD setHidden:YES];
        }
    }
    
    @catch (NSException * exception) {
        
        if(catPopOver.popoverVisible)
            [catPopOver dismissPopoverAnimated:YES];
        searchItemTxt.tag = 0;
        [HUD setHidden:YES];
        
    }
}

/**
 * @description  here we are handling the error resposne received from services.......
 * @date         20/0/2016
 * @method       searchProductsErrorResponse:
 * @author       Bhargav Ram
 * @param
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)searchProductsErrorResponse {
    
    @try {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [productListTbl reloadData];
     
        [catPopOver dismissPopoverAnimated:YES];

    }
}


/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       getSkuDetailsSuccessResponse:
 * @author       Bhargav.v
 * @param        NSDictionary
 * @param
 * @return
 * @modified BY  Srinivasulu on 17/01/2016
 * @return
 * @verified By
 * @verified On
 */

- (void)getSkuDetailsSuccessResponse:(NSDictionary*)successDictionary {
    
    @try {
        
        if(successDictionary!= nil) {
            
            priceArr = [[NSMutableArray alloc]init];
            NSArray * price_arr = [successDictionary valueForKey:kSkuLists];
            
            for (int i=0; i<price_arr.count; i++) {
                
                NSDictionary * json = price_arr[i];
                [priceArr addObject:json];
            }
            if (((NSArray *)[successDictionary valueForKey:kSkuLists]).count>1) {
                
                
                if (priceArr.count>0) {
                    [HUD setHidden:YES];
                    transparentView.hidden = NO;
                    [priceTable reloadData];
                    SystemSoundID    soundFileObject1;
                    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"popup_tune" withExtension: @"mp3"];
                    self.soundFileURLRef = (__bridge CFURLRef) tapSound;
                    
                    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                    AudioServicesPlaySystemSound (soundFileObject1);
                }
            }
            else  {
                
                BOOL status = FALSE;
                
                int i=0;
                NSMutableDictionary * dic;
                
                for ( i=0; i<rawMaterialDetails.count;i++) {
                    NSArray * itemArray = [successDictionary valueForKey:kSkuLists];
                    if (itemArray.count > 0) {
                        NSDictionary * itemdic = itemArray[0];
                        dic = rawMaterialDetails[i];
                        if ([[dic valueForKey:ITEM_SKU] isEqualToString:[itemdic valueForKey:ITEM_SKU]] && [[dic valueForKey:PLU_CODE] isEqualToString:[itemdic valueForKey:PLU_CODE]]) {
                            [dic setValue:[NSString stringWithFormat:@"%d",[[dic valueForKey:QUANTITY] intValue] + 1] forKey:QUANTITY];
                            // added by roja
                            [dic setValue:[NSString stringWithFormat:@"%d",[[dic valueForKey:kApprovedQty] intValue] + 1] forKey:kApprovedQty];

                            rawMaterialDetails[i] = dic;
                            
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
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_SKU] defaultReturn:EMPTY_STRING] forKey:ITEM_SKU];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:PLU_CODE] defaultReturn:EMPTY_STRING] forKey:PLU_CODE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_DESCRIPTION] defaultReturn:EMPTY_STRING] forKey:ITEM_DESC];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_CATEGORY] defaultReturn:EMPTY_STRING] forKey:ITEM_CATEGORY];
                     
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:QUANTITY];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:kApprovedQty];


                        //setting available qty....
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:AVL_QTY];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:kPrvIndentQty] defaultReturn:@"0.00"] floatValue]] forKey:kPrvIndentQty];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:kProjectedQty] defaultReturn:@"0.00"] floatValue]] forKey:kProjectedQty];
                        
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:COLOR] defaultReturn:EMPTY_STRING] forKey:COLOR];

                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:SIZE] defaultReturn:EMPTY_STRING] forKey:SIZE];

                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kProductBrand] defaultReturn:EMPTY_STRING] forKey:kBrand];

                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:MODEL] defaultReturn:EMPTY_STRING] forKey:MODEL];

                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:SELL_UOM] defaultReturn:EMPTY_STRING] forKey:SELL_UOM];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:PRODUCT_RANGE] defaultReturn:EMPTY_STRING] forKey:PRODUCT_RANGE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kMeasureRange] defaultReturn:EMPTY_STRING] forKey:MEASUREMENT_RANGE];
                        
                        // adding keys
                        // added by roja on 19/06/2018....
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:QOH];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:cost_Price] defaultReturn:@"0.00"] floatValue]] forKey:iTEM_PRICE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:ITEM_SKU] defaultReturn:EMPTY_STRING] forKey:kProductId];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:kSubCategory] defaultReturn:EMPTY_STRING] forKey:kSubCategory];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:EAN] defaultReturn:EMPTY_STRING] forKey:EAN];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_SCAN_CODE] defaultReturn:EMPTY_STRING] forKey:ITEM_SCAN_CODE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:MAKE] defaultReturn:EMPTY_STRING] forKey:MAKE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:TRACKING_REQUIRED] defaultReturn:EMPTY_STRING] forKey:TRACKING_REQUIRED];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:UTILITY] defaultReturn:EMPTY_STRING] forKey:UTILITY];
                     
                        // added by roja on 30/04/2019...
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:PRODUCT_BATCH_NO] defaultReturn:@""] forKey:PRODUCT_BATCH_NO];

                        //Checking is isPacked item based on the Boolean value
                        
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
                        
                        [rawMaterialDetails addObject:itemDetailsDic];
                    }
                    else
                        rawMaterialDetails[i] = dic;
                }
                [self calculateTotal];
            }
        }
    }
    
    @catch (NSException * exception) {
        NSLog(@"-------exception will reading.-------%@",exception);
    }
    @finally{
        // requestedItemsTbl.hidden = NO;
        [HUD setHidden:YES];
        [requestedItemsTbl reloadData];
    }
}

/**
 * @description  in this method we will call the services....
 * @method       getSkuDetailsErrorResponse
 * @author       Bhargav.v
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 * @modified By Srinivasulu on 13/04/2017...
 * @reason      added comments && added new field in items level....
 *
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
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       createStockRequestsSuccessResponse:
 * @author       Bhargav Ram
 * @param        NSDictionary
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)createStockRequestsSuccessResponse:(NSDictionary *) successDictionary {
    
    @try {
        
        [HUD setHidden:YES];
        
        //Sound File Object after the Success Response.....
        SystemSoundID    soundFileObject1;
        NSURL * tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
        self.soundFileURLRef = (__bridge CFURLRef) tapSound;
        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
        AudioServicesPlaySystemSound (soundFileObject1);
        
        [sucessTransparentView setHidden:NO];
        
        float items = 0;
        
        items = rawMaterialDetails.count;
        
        requestIdValueLbl.text = [self checkGivenValueIsNullOrNil:[successDictionary valueForKey:REQUEST_ID] defaultReturn:@"--"];
        
        outletIdValueLbl.text = fromStoreTxt.text;
        
        dateValueLbl.text =  requestDteFld.text;
        
        NoOfItemsValueLbl.text = [NSString stringWithFormat:@"%.2f",items];
        
        totalRequestedQtyValueLbl.text = requestedQtyvalueLbl.text;
        
        if(submitBtn.tag == 4) {
            
            statusValueLbl.text = SUBMITTED;
            
        }
        else
            statusValueLbl.text = DRAFT;
    }
    @catch (NSException* exception) {
        
    }
    @finally {
        
    }
}

/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       createStockRequestsErrorResponse:
 * @author       Bhargav Ram
 * @param        NSString
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)createStockRequestsErrorResponse:(NSString*)errorResponse {
    
    @try {
        
        //changed By srinivauslu on 02/05/2018....
        //reason.. Need to stop user internation after servcie calls...
        
        submitBtn.userInteractionEnabled = YES;
        saveBtn.userInteractionEnabled = YES;
        
        //upto here on 02/05/2018....
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2  verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        // Reason:Making the Buttons  enable to make a call  after the Server Response....
        submitBtn. enabled = true;
        saveBtn.enabled = true;

    }
}

/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       updateStockRequestsSuccessResponse:
 * @author       Bhargav Ram
 * @param        NSDictionary
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)updateStockRequestsSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        [HUD setHidden:YES];
        
        SystemSoundID    soundFileObject1;
        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
        self.soundFileURLRef = (__bridge CFURLRef) tapSound;
        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
        AudioServicesPlaySystemSound (soundFileObject1);
        
        [sucessTransparentView setHidden:NO];
        
        float items = 0;
        
        items = rawMaterialDetails.count;
        
        requestIdValueLbl.text = [self checkGivenValueIsNullOrNil:[successDictionary valueForKey:REQUEST_ID] defaultReturn:@"--"];
        
        outletIdValueLbl.text = fromStoreTxt.text;
        
        dateValueLbl.text =  requestDteFld.text;
        
        NoOfItemsValueLbl.text = [NSString stringWithFormat:@"%.2f",items];
        
        totalRequestedQtyValueLbl.text = requestedQtyvalueLbl.text;
        
        if(submitBtn.tag == 4) {
            
            statusValueLbl.text = SUBMITTED;
            
        }
        else
            statusValueLbl.text = DRAFT;
    }
    @catch (NSException* exception) {
        
    }
    @finally {
        
    }
}

/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       updateStockRequestsErrorResponse:
 * @author       Bhargav Ram
 * @param        NSString
 * @param
 * @return
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the populating date directly to method....
 * @return
 * @verified By
 * @verified On
 */

-(void)updateStockRequestsErrorResponse:(NSString *)errorResponse {
    
    @try {
        
        //changed By srinivauslu on 02/05/2018....
        //reason.. Need to stop user internation after servcie calls...
        
        submitBtn.userInteractionEnabled = YES;
        saveBtn.userInteractionEnabled = YES;
        
        //upto here on 02/05/2018....
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2  verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}



/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       getLocationSuccessResponse:
 * @author       Bhargav Ram
 * @param        NSDictionary
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getLocationSuccessResponse:(NSDictionary *)successDictionary {
    @try {
        for(NSDictionary * dic in [successDictionary valueForKey:LOCATIONS_DETAILS]) {
            
            //if (fromStoreTxt.tag == 2 ) {
            
            if (![[dic valueForKey:LOCATION_ID] isKindOfClass:[NSNull class]] && [[dic valueForKey:LOCATION_ID] caseInsensitiveCompare:presentLocation] != NSOrderedSame && ![[dic valueForKey:BUSSINESS_ACTIVITY] isKindOfClass:[NSNull class]] && [[dic valueForKey:BUSSINESS_ACTIVITY] caseInsensitiveCompare: @""] != NSOrderedSame) {
                
                
                [locationArr addObject:[dic valueForKey:LOCATION_ID]];
                [businessActivityArr addObject:[dic valueForKey:@"businessActivity"]];
                
            }
            
            //}
            //else {
            
            //[warehouseLocationArr addObject:dic];
            //}
        }
        
    } @catch (NSException *exception) {
        [catPopOver dismissPopoverAnimated:YES];
        
    }
    @finally {
        [HUD setHidden:YES];
    }
}

/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       getLocationErrorResponse:
 * @author       Bhargav Ram
 * @param        NSString
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getLocationErrorResponse:(NSString *)errorResponse{
    
    @try {
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItemTxt.isEditing)
            y_axis = searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    } @catch (NSException *exception) {
        
    } @finally {
        [catPopOver dismissPopoverAnimated:YES];
        [HUD setHidden:YES];
    }
}


//newly added  service call to get the deatils of the request ID which is in draft status....
/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       getStockRequestsSuccessResponse:
 * @author       Bhargav Ram
 * @param        NSDictionary
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 */

- (void)getStockRequestsSuccessResponse:(NSDictionary *)successDictionary {
    @try {
        
        isDraft = true;
        
        NSArray * requestsArr = [successDictionary valueForKey:STOCK_REQUESTS];
        
        for (NSDictionary * receiptDic in requestsArr) {
            
            if ([[receiptDic valueForKey:STOCK_REQUEST_ID] isEqualToString:requestID]) {
                
                requestViewReceiptJSON = [receiptDic copy];
              
                [requestID copy];
            }
            
            //changed by Srinivasulu on 14/04/2017....
            
            if(([requestViewReceiptJSON.allKeys containsObject:DELIVERY_DATE_STR]) &&  (![[requestViewReceiptJSON valueForKey:DELIVERY_DATE_STR] isKindOfClass: [NSNull class]]) && ([[requestViewReceiptJSON valueForKey:DELIVERY_DATE_STR] componentsSeparatedByString:@" "].count) )
               
                DeliveyDate.text =  [[requestViewReceiptJSON valueForKey:DELIVERY_DATE_STR] componentsSeparatedByString:@" "][0];
            
            
            if(([requestViewReceiptJSON.allKeys containsObject:REQUEST_DATE_STR]) &&  (![[requestViewReceiptJSON valueForKey:REQUEST_DATE_STR] isKindOfClass: [NSNull class]]) && ([[requestViewReceiptJSON valueForKey:REQUEST_DATE_STR] componentsSeparatedByString:@" "].count) )
                requestDteFld.text = [[requestViewReceiptJSON valueForKey:REQUEST_DATE_STR] componentsSeparatedByString:@" "][0];
            
       
            // changed by roja on 02-06-2018....

            toLocationText.text = [self checkGivenValueIsNullOrNil:[requestViewReceiptJSON  valueForKey:TO_STORE_CODE] defaultReturn:EMPTY_STRING];
            
            if(!(toLocationText.text).length)
                toLocationText.text = [self checkGivenValueIsNullOrNil:[requestViewReceiptJSON  valueForKey:TO_WARE_HOUSE_ID] defaultReturn:EMPTY_STRING];
            
            
            requestedBy.text = [self checkGivenValueIsNullOrNil:[requestViewReceiptJSON  valueForKey:REQUESTED_USER_NAME] defaultReturn:EMPTY_STRING];
            shipmentModeTxt.text = [self checkGivenValueIsNullOrNil:[requestViewReceiptJSON  valueForKey:SHIPPING_MODE] defaultReturn:EMPTY_STRING];
            outletIdTxt.text = [self checkGivenValueIsNullOrNil:[requestViewReceiptJSON  valueForKey:FROM_STORE_CODE] defaultReturn:EMPTY_STRING];
            priorityTxt.text = [self checkGivenValueIsNullOrNil:[requestViewReceiptJSON  valueForKey:kPriority] defaultReturn:EMPTY_STRING];
            
            NSArray * items = requestViewReceiptJSON[STOCK_REQUEST_ITEMS];
            float quantityOnHand    = 0.0;
            float previousIndentQty = 0.0;
            float projectedQty      = 0.0;
            float requestedQuantity = 0.0;
            float approvedQty       = 0.0;
            
            for (int i = 0; i < items.count; i++) {
                NSDictionary * itemDic = items[i];
                
                quantityOnHand    += [[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:AVL_QTY] defaultReturn:@"0.00"] intValue];
                previousIndentQty += [[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:kPrvIndentQty] defaultReturn:@"0.00"] intValue];
                projectedQty      += ([[itemDic valueForKey:AVL_QTY] floatValue] + [[itemDic valueForKey:kPrvIndentQty] floatValue]);
                requestedQuantity += [[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:QUANTITY] defaultReturn:@"0.00"] intValue];
                approvedQty       += [[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:kApprovedQty] defaultReturn:@"0.00"] intValue];
                
                //changed by Srinivasulu on 16/04/2017.....
                
                NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc]init];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:ITEM_SKU] defaultReturn:EMPTY_STRING] forKey:ITEM_SKU];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:PLU_CODE] defaultReturn:EMPTY_STRING] forKey:PLU_CODE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:ITEM_DESC] defaultReturn:EMPTY_STRING] forKey:ITEM_DESC];
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:ITEM_PRICE] defaultReturn:@"0.00"] floatValue]] forKey:ITEM_PRICE];
                
                // added by roja 20/06/2018....
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:QUANTITY];
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:kApprovedQty] defaultReturn:@"0.00"] floatValue]] forKey:kApprovedQty];
                
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:COLOR] defaultReturn:EMPTY_STRING] forKey:COLOR];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:MODEL] defaultReturn:EMPTY_STRING] forKey:MODEL];
                
                //newly added keys....
                //added by  Srinivasulu on  14/04/2017....
                
                //setting availiable qty....
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:AVL_QTY] defaultReturn:@"0.00"] floatValue]] forKey:AVL_QTY];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic valueForKey:SIZE] defaultReturn:EMPTY_STRING] forKey:SIZE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic valueForKey:PRODUCT_RANGE] defaultReturn:EMPTY_STRING] forKey:PRODUCT_RANGE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic valueForKey:MEASUREMENT_RANGE] defaultReturn:EMPTY_STRING] forKey:MEASUREMENT_RANGE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic valueForKey:ITEM_CATEGORY] defaultReturn:EMPTY_STRING] forKey:ITEM_CATEGORY];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic valueForKey:kBrand] defaultReturn:EMPTY_STRING] forKey:kBrand];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic valueForKey:SELL_UOM] defaultReturn:EMPTY_STRING] forKey:SELL_UOM];
                
                // adding keys
                // added by roja on 26-06-2018
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:kSubCategory] defaultReturn:EMPTY_STRING] forKey:kSubCategory];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:ITEM_SKU] defaultReturn:EMPTY_STRING] forKey:kProductId];
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:ESTIMATED_COST] defaultReturn:@"0.00"] floatValue]] forKey:ESTIMATED_COST];
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:iTEM_PRICE] defaultReturn:@"0.00"] floatValue]] forKey:iTEM_PRICE];
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:kPrvIndentQty] defaultReturn:@"0.00"] floatValue]] forKey:kPrvIndentQty];
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemDic  valueForKey:kProjectedQty] defaultReturn:@"0.00"] floatValue]] forKey:kProjectedQty];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic valueForKey:EAN] defaultReturn:EMPTY_STRING] forKey:EAN];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic valueForKey:ITEM_SCAN_CODE] defaultReturn:EMPTY_STRING] forKey:ITEM_SCAN_CODE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic valueForKey:MAKE] defaultReturn:EMPTY_STRING] forKey:MAKE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic valueForKey:TRACKING_REQUIRED] defaultReturn:EMPTY_STRING] forKey:TRACKING_REQUIRED];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic valueForKey:UTILITY] defaultReturn:EMPTY_STRING] forKey:UTILITY];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemDic valueForKey:QOH] defaultReturn:EMPTY_STRING] forKey:QOH];


                
                //upto here on 13/04/2017.....
                
                //[rawMaterialDetails addObject:[items objectAtIndex:i]];
                
                [rawMaterialDetails addObject:itemDetailsDic];
            }
            
            quantityOnHandValueLbl.text = [NSString stringWithFormat:@"%.2f",quantityOnHand];
            previousQtyValueLbl.text    = [NSString stringWithFormat:@"%.2f",previousIndentQty];
            projectedQtyValueLbl.text   = [NSString stringWithFormat:@"%.2f",projectedQty];
            requestedQtyvalueLbl.text   = [NSString stringWithFormat:@"%.2f",requestedQuantity];
            approvedQtyValueLbl.text    = [NSString stringWithFormat:@"%.2f",approvedQty];
            
            [requestedItemsTbl reloadData];
            
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [HUD setHidden: YES];
    }
}


/**
 * @description  here we are handling the error response from the service.......
 * @date         21/09/2016
 * @method       getStockRequestsErrorResponse
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @modified BY
 * @reason
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)getStockRequestsErrorResponse:(NSString *)errorResponse{
    
    @try {
        
        [HUD setHidden:YES];
        float y_axis = self.view.frame.size.height - 120;
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@"" conentWidth:400 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    } @catch (NSException *exception) {
        NSLog(@"---------%@",exception );
    } @finally {
        
    }
}

# pragma  mark action used for service calls


/**
 * @description  here we are hiding the popOver and navigating to the Summarypage .......
 * @date         12/11/2017
 * @method       okButtonPressed:
 * @author       Bhargav Ram
 * @param        UIButton
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)okButtonPressed:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound(soundFileObject);
    @try {
        
        [successView setHidden:YES];
        //Navigating to the Request Summary page...
        [self backAction];
    } @catch (NSException *exception) {
        
    }
}


/**
 * @description  here we are sending the requestfor StockRequest Creation...
 * @date         20/0/2016
 * @method       submitButonPressed:
 * @author       Bhargav Ram
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */



-(void)submitButonPressed:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        Boolean isZeroQty = false;
        for(NSDictionary * dic in rawMaterialDetails){
            
            if([[dic valueForKey:QUANTITY] floatValue] <= 0.00)
                isZeroQty = true;
        }
            
        if ( rawMaterialDetails.count == 0) {
            
            float y_axis = self.view.frame.size.height - 120;
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_add_items_to_the_cart",nil)];
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        }
        
        else if ((toLocationText.text).length == 0  || (fromStoreTxt.text).length == 0) {
            
            float y_axis = self.view.frame.size.height - 120;
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_select_Location",nil)];
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        }
        
        else if ((DeliveyDate.text).length == 0) {
            
            UIButton * locDeliveryBtn  = [[UIButton alloc]init];
            locDeliveryBtn.tag = 4;
            [self showCalenderInPopUp:locDeliveryBtn];
        }
        
        else if ((shipmentModeTxt.text).length == 0)  {
            [self getShipmentModes:sender];
        }
        
        else if ((priorityTxt.text).length == 0) {
            [self populatePriorityList:sender];
        }
        
        else if (isZeroQty && (saveBtn.tag != submitBtn.tag) ){
            
            conformationAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"please_verify_zeroQty_items_are_available", nil) message:nil delegate:self cancelButtonTitle:@"CONTINUE" otherButtonTitles:@"NO", nil];
            conformationAlert.tag = sender.tag;
            [conformationAlert show];
        }


         else if (!isZeroQty && (saveBtn.tag != submitBtn.tag)){
             
         if(sender.tag == saveBtn.tag) {
         
         conformationAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"do_you_want_to_save_this_indent", nil)  message:nil delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
         conformationAlert.tag = sender.tag;
         [conformationAlert show];
         }
         else {
             
         conformationAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"do_you_want_to_submit_this_indent", nil)  message:nil delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
         conformationAlert.tag = sender.tag;
         [conformationAlert show];
         }
         }
        else {
            
            // Reason: Disabling the Buttons to avoid duplicate transactions...
            submitBtn.enabled = false;
            saveBtn.enabled = false;
            
            [HUD show:YES];
            [HUD setHidden:NO];
            
            float  totalRequestAmount  = 0;
            float estimatedCost = 0;
            
            // changed by roja on 29-06-2018...
            float requestedNoOfItems = 0;
            requestedNoOfItems = rawMaterialDetails.count;
            
            NSMutableArray    * tempArr = [NSMutableArray new];
            
            for(NSDictionary * locDic  in rawMaterialDetails){
                
                NSMutableDictionary * temp = [locDic mutableCopy];
                float  totalAmount  = 0;
                
                totalAmount = [[locDic  valueForKey:iTEM_PRICE] floatValue] * [[locDic  valueForKey:kApprovedQty] floatValue];
                totalRequestAmount = totalRequestAmount + totalAmount;
                [temp setValue:[NSString stringWithFormat:@"%.2f",totalAmount ] forKey:TOTAL_COST];
                
                // estimatedCost added by Roja on 28-06-2018...
                estimatedCost = [[locDic  valueForKey:iTEM_PRICE] floatValue] * [[locDic  valueForKey:QUANTITY] floatValue];
                [temp setValue:[NSString stringWithFormat:@"%.2f",estimatedCost] forKey:ESTIMATED_COST];
                [tempArr addObject:temp];
            }
            
            NSMutableDictionary * stockRequestDic = [[NSMutableDictionary alloc]init];
            
            stockRequestDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
            stockRequestDic[REQUEST_DATE_STR] = requestDteFld.text;
            
            NSString * deliveryDteStr = DeliveyDate.text;
            
            if(deliveryDteStr.length > 1)
                deliveryDteStr = [NSString stringWithFormat:@"%@", DeliveyDate.text];
            
            stockRequestDic[DELIVERY_DATE_STR] = deliveryDteStr;
            stockRequestDic[REQUESTED_USER_NAME] = requestedBy.text;
            stockRequestDic[SHIPPING_MODE] = shipmentModeTxt.text;
            stockRequestDic[SHIPPING_COST] = @0.0f;
            stockRequestDic[REMARKS] = @"";
            stockRequestDic[TOTAL_STOCK_REQUEST_VALUE] = @(totalRequestAmount);
            // added by roja on 29-06-2018...
            stockRequestDic[NO_OF_ITEMS] = @(requestedNoOfItems);
            stockRequestDic[REQUESTED_BY] = requestedBy.text;
            
            if(sender.tag == 2)
                stockRequestDic[STATUS] = DRAFT;
            
            else
                stockRequestDic[STATUS] = SUBMITTED;
                stockRequestDic[PRIORITY] = priorityTxt.text;
                stockRequestDic[STOCK_REQUEST_ITEMS] = tempArr;
            
            //changed by Srinivaslulu on 19/01/2017...
            if ([requestViewReceiptJSON.allKeys containsObject:REQUEST_APPROVED_BY] &&  ![[requestViewReceiptJSON valueForKey:REQUEST_APPROVED_BY] isKindOfClass:[NSNull class]])
                stockRequestDic[REQUEST_APPROVED_BY] = [requestViewReceiptJSON valueForKey:REQUEST_APPROVED_BY];
            
            if ([requestViewReceiptJSON.allKeys containsObject:REASON] &&  ![[requestViewReceiptJSON valueForKey:REASON] isKindOfClass:[NSNull class]])
                stockRequestDic[REASON] = [requestViewReceiptJSON valueForKey:REASON];
            
            // added by roja on 04-07-2018...
            //  [stockRequestDic setObject:zoneIdTxt.text forKey:ZONE_Id];
            
            if (isDraft) {
                
                if(businessActivityStr != nil){
                if ([businessActivityStr caseInsensitiveCompare:@"Warehouse"] == NSOrderedSame )
                    stockRequestDic[TO_WARE_HOUSE_ID] = toLocationText.text;
                else
                    stockRequestDic[TO_STORE_CODE] = toLocationText.text;
                }
                else{
                    
                    NSString * toLocationTypeStr = TO_STORE_CODE;
                    
                    if([requestViewReceiptJSON.allKeys containsObject:TO_WARE_HOUSE_ID] && ![[requestViewReceiptJSON valueForKey:TO_WARE_HOUSE_ID] isKindOfClass: [NSNull class]])
                        
                        toLocationTypeStr = TO_WARE_HOUSE_ID;
                        stockRequestDic[toLocationTypeStr] = toLocationText.text;

                }

                
                stockRequestDic[FROM_STORE_CODE] = outletIdTxt.text;
                stockRequestDic[STOCK_REQUEST_ID] = requestID;

                NSError  * err;
                NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:stockRequestDic options:0 error:&err];
                //NSString * updateString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                //NSLog(@"--%@",json);

                
                WebServiceController * webServiceController = [WebServiceController new];
                webServiceController.stockRequestDelegate = self;
                [webServiceController updateStockRequest:jsonData];
            }
            else {

                // changed by roja on 02-07-2018...
                if ((businessActivityStr.length !=0 ) && [businessActivityStr caseInsensitiveCompare:@"Warehouse"] == NSOrderedSame )
                    
                    stockRequestDic[TO_WARE_HOUSE_ID] = toLocationText.text;
                
                else
                    stockRequestDic[TO_STORE_CODE] = toLocationText.text;
                
                if (isHubLevel) {
                    
                    stockRequestDic[FROM_STORE_CODE] = fromStoreTxt.text;
                }
                else
                    stockRequestDic[FROM_STORE_CODE] = presentLocation;
                
                NSError  * err;
                NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:stockRequestDic options:0 error:&err];
                NSString * updateString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                
                WebServiceController * webServiceController = [WebServiceController new];
                webServiceController.stockRequestDelegate = self;
                [webServiceController  createStockRequest:updateString];
            }
        }
    }
    @catch(NSException * exception) {
        
        //upto here on 02/05/2018....
        //changed By srinivauslu on 02/05/2018....
        //reason.. Need to stop user internation after servcie calls...
        
        submitBtn.userInteractionEnabled = YES;
        saveBtn.userInteractionEnabled = YES;
        
        [HUD setHidden:YES];
        float y_axis = self.view.frame.size.height - 120;
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request",nil)];
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        NSLog(@"-------exception will reading.-------%@",exception);
    }
    @finally {
        
    }
}

# pragma  mark action used for service calls

/**
 * @description  here we are sending the requestfor StockRequest Creation...
 * @date         10/11/2017
 * @method       didDismissWithButtonIndex:
 * @author       Bhargav Ram
 * @param        UIAlertView
 * @param        NSInteger
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (alertView == conformationAlert) {
        
        if (buttonIndex == 0) {
            
            saveBtn.tag = conformationAlert.tag;
            submitBtn.tag = conformationAlert.tag;
            [self submitButonPressed:saveBtn];
        
        }
        else {
            
            saveBtn.tag = 2;
            submitBtn.tag = 4;
          
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        }
    }
    else if (alertView == delItemAlert) {
        
        if (buttonIndex == 0) {
            
            delItemAlert.tag = 4;
            [self delRow:delrowbtn];
        }
        else {
            
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        }
    }
    
}





#pragma -mark action used in this page

/**
 * @description  Deleting the item from the cart based on the index position..
 * @date         22/12/2017
 * @method       delRow
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)delRow:(UIButton*)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if (delItemAlert == nil || (delItemAlert.tag == 2)) {
            
            if (delItemAlert == nil)
                delItemAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"remove_this_item_from_the_list", nil) message:nil delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
            
            delrowbtn = sender;
            delItemAlert.tag = 2;
            [delItemAlert show];
        }
        
        else {
            
            delItemAlert.tag = 2;
            
            if(rawMaterialDetails.count >= sender.tag) {
                
                [rawMaterialDetails removeObjectAtIndex:sender.tag];
                [requestedItemsTbl reloadData];
            }
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [self  calculateTotal];
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
                
                float y_axis = self.view.frame.size.height - 120;
                
                [self displayAlertMessage:NSLocalizedString(@"please_select_atleast_one_category",nil) horizontialAxis:(self.view.frame.size.width - 360)/2  verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
                return;
            }
            
//            //Recently Added By Bhargav.v on 26/10/2017....
//            if ([rawMaterialDetails count]) {
//
//                [rawMaterialDetails removeAllObjects];
//            }
//            //up to here By Bhargav.v on 26/10/2017....
        }
        @try {
            [HUD show:YES];
            [HUD setHidden:NO];
            NSMutableDictionary * priceListDic = [[NSMutableDictionary alloc]init];
            
            priceListDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
            priceListDic[START_INDEX] = NEGATIVE_ONE;
            priceListDic[CATEGORY_LIST] = catArr;
            priceListDic[kRequiredRecords] = ZERO_CONSTANT;
            priceListDic[kStoreLocation] = presentLocation;

            priceListDic[kNotForDownload] = [NSNumber numberWithBool:true];
            priceListDic[LATEST_CAMPAIGNS] = [NSNumber numberWithBool:false];
            priceListDic[kIsEffectiveDateConsidered] = [NSNumber numberWithBool:false];
            priceListDic[kIsApplyCampaigns] = [NSNumber numberWithBool:false];
            priceListDic[BONEYARD_SUMMARY_FLAG] = [NSNumber numberWithBool:false];
            priceListDic[kBarCodeType] = [NSNumber numberWithBool:false];
            priceListDic[kZeroStockBillCheck] = [NSNumber numberWithBool:false];
            priceListDic[ZERO_STOCK_CHECK_AT_OUTLET_LEVEL] = [NSNumber numberWithBool:false];
            
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
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
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
 */

-(void)dismissCategoryPopOver:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    @try {
    
        [categoriesPopOver dismissPopoverAnimated:YES];
        
    } @catch (NSException *exception) {
        
    }
}


/**
 * @description  Yet This Feature is yet to implement..
 * @date         29/07/2017
 * @method       moreButtonPressed
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
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"currently_this_feature_is_unavailable", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}


/**
 * @description  we are calling the super class.......
 * @date         20/0/2016
 * @method       cancelButtonPressed:
 * @author       Bhargav Ram
 * @param        UIButton
 * @param
 * @return
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the populating date directly to method....
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)cancelButtonPressed:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound(soundFileObject);
    @try{
        
        [self backAction];
    }
    @catch(NSException * exception) {
        
    }
}

/**
 * @description  Displaying popover for the locations.......
 * @date         20/0/2016
 * @method       populateLocationsTable:
 * @author       Bhargav Ram
 * @param        UIButton
 * @param
 * @return
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)populateLocationsTable:(UIButton *)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound(soundFileObject);
    
    //warehouseLocationArr
    toLocationText.tag = sender.tag;
    //fromStoreTxt.tag = sender.tag;
    int count = 5;
    //if (sender.tag == 4) {
    
    //        if( warehouseLocationArr == nil){
    //            warehouseLocationArr = [[NSMutableArray alloc] init];
    //            [self getLocations:selectIndex businessActivity:@""];
    //        }
    //
    //        if (([warehouseLocationArr count] < count) && [warehouseLocationArr count]) {
    //            count = (int) [warehouseLocationArr count];
    //        }
    //    }
    //
    //    else
    
    //if (sender.tag == 2) {
    
        if(locationArr == nil){
            locationArr = [[NSMutableArray alloc] init];
            businessActivityArr = [[NSMutableArray alloc] init];
            [self getLocations:selectIndex businessActivity:@""];
        }
        
        if ((locationArr.count < count) && locationArr.count) {
            count = (int)locationArr.count;
        }
    //}
    
    PopOverViewController  * customerInfoPopUp = [[PopOverViewController alloc] init];
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, toLocationText.frame.size.width,count*40)];
    customView.opaque = NO;
    customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    customView.layer.borderWidth = 2.0f;
    [customView setHidden:NO];
    
    locationTable = [[UITableView alloc] init];
    locationTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    locationTable.dataSource = self;
    locationTable.delegate = self;
    (locationTable.layer).borderWidth = 1.0f;
    locationTable.layer.cornerRadius = 3;
    locationTable.layer.borderColor = [UIColor grayColor].CGColor;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        locationTable.frame = CGRectMake(0, 0, customView.frame.size.width, customView.frame.size.height);
        
    }
    
    [customView addSubview:locationTable];
    
    customerInfoPopUp.view = customView;
    
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        
        if (sender.tag == 2) {
            [popover presentPopoverFromRect:fromStoreTxt.frame inView:stockRequestView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
        }
        
        else  if ( sender.tag == 4) {
            [popover presentPopoverFromRect:toLocationText.frame inView:stockRequestView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
        }
        
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
    
    [locationTable reloadData];
    
}


/**
 * @description  displaying popOver for the shipment Mode.......
 * @date         20/0/2016
 * @method       getShipmentModes::
 * @author       Bhargav Ram
 * @param        UIButton
 * @param
 * @return
 *
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the populating date directly to method....
 *
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
        [shipModesArr addObject:@"Rail"];
        [shipModesArr addObject:@"Flight"];
        [shipModesArr addObject:@"Express"];
        [shipModesArr addObject:@"Ordinary"];
        
        float tableHeight = shipModesArr.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = shipModesArr.count * 33;
        
        if(shipModesArr.count>5)
            tableHeight = (tableHeight/shipModesArr.count) * 5;
        
        [self showPopUpForTables:shipModeTable  popUpWidth:(shipmentModeTxt.frame.size.width)  popUpHeight:tableHeight presentPopUpAt:shipmentModeTxt  showViewIn:stockRequestView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
    }
}


/**
 * @description  displaying popOVer for the priority List.......
 * @date         20/0/2016
 * @method       populatePriorityList:
 * @author       Bhargav Ram
 * @param        UIButton
 * @param
 * @return
 *
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the populating date directly to method....
 *
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)populatePriorityList:()sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        priorityArr = [NSMutableArray new];
        [priorityArr addObject:@"Normal"];
        [priorityArr addObject:@"Low"];
        [priorityArr addObject:@"Medium"];
        [priorityArr addObject:@"High"];
        
        float tableHeight = priorityArr.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = priorityArr.count * 33;
        
        if(priorityArr.count>5)
            tableHeight = (tableHeight/priorityArr.count) * 5;
        
        [self showPopUpForTables:priorityTbl  popUpWidth:(priorityTxt.frame.size.width)  popUpHeight:tableHeight presentPopUpAt:priorityTxt  showViewIn:stockRequestView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

/**
 * @description  here we are showing the calender in popUp view....
 * @date         26/09/2016
 * @method       showCalenderInPopUp:
 * @author       Bhargav Ram
 * @param        UIButton
 * @param
 * @return
 *
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the comment's section....
 *
 * @return
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
            
            pickView.frame = CGRectMake( 15, requestDteFld.frame.origin.y+requestDteFld.frame.size.height, 320, 320);
            
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
                
                [popover presentPopoverFromRect:requestDteFld.frame inView:stockRequestView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else
                
                [popover presentPopoverFromRect:DeliveyDate.frame inView:stockRequestView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
            catPopOver= popover;
            
        }
        
        else {
            
            // customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
            
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
 * @description  here we can clear the  date from the text field...
 * @date         26/09/2016
 * @method       clearDate:
 * @author       Bhargav Ram
 * @param        UIButton
 * @param
 * @return
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)clearDate:(UIButton *)sender{
    //    BOOL callServices = false;
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        [catPopOver dismissPopoverAnimated:YES];

        if(  sender.tag == 2){
            
            if((requestDteFld.text).length)
                // callServices = true;
                requestDteFld.text = @"";
        }
        else{
            if((DeliveyDate.text).length)
                //  callServices = true;
                DeliveyDate.text = @"";
        }
        
        //
        //        if(callServices){
        //            [HUD setHidden:NO];
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


/**
 * @description  here we can populate the date from the text field...
 * @date         26/09/2016
 * @method       populateDateToTextField:
 * @author       Bhargav Ram
 * @param        UIButton
 * @param
 * @return
 * @return
 * @return
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
        //        [requiredDateFormat setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        requiredDateFormat.dateFormat = @"dd/MM/yyyy";
        
            dateString = [requiredDateFormat stringFromDate:myPicker.date];
        
        NSDate * selectedDateString = [requiredDateFormat dateFromString:[requiredDateFormat stringFromDate:myPicker.date]];
        
        // getting present date & time ..
        NSDate * today = [NSDate date];
        NSDateFormatter * f = [[NSDateFormatter alloc] init];
        f.dateFormat = @"dd/MM/yyyy";
        NSString* currentdate = [f stringFromDate:today];
        //        [f release];
        today = [f dateFromString:currentdate];
        
//        if(([today compare:selectedDateString] == NSOrderedAscending)){
//            
//            [self displayAlertMessage:NSLocalizedString(@"selected_date_can_not_be_more_than_current_data", nil) horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:self.view.frame.size.height - 150  msgType:NSLocalizedString(@"warning", nil)  conentWidth:390 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
//            
//            return;
//        }
        
        NSDate * existingDateString;

        
        if(sender.tag == 2) {
            if ((DeliveyDate.text).length != 0 && (![DeliveyDate.text isEqualToString:@""])) {
                existingDateString = [requiredDateFormat dateFromString:DeliveyDate.text ];
                
                if ([existingDateString compare:selectedDateString]== NSOrderedAscending) {
                    
                    [self displayAlertMessage:NSLocalizedString(@"request_date_should_be_earlier_than_delivery_date", nil) horizontialAxis:(self.view.frame.size.width - 250)/2.5   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:420 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
                    return;
                    
                }
            }
            
            requestDteFld.text = dateString;
        }
        
        else {
            
            if ((requestDteFld.text).length != 0 && ( ![requestDteFld.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:requestDteFld.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    [self displayAlertMessage:NSLocalizedString(@"delivery_date_should_not_be_earlier_than_request_date", nil) horizontialAxis:(self.view.frame.size.width - 250)/2.5   verticalAxis:self.view.frame.size.height - 120  msgType:NSLocalizedString(@"warning", nil)  conentWidth:420 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
                    
                    return;
                }
            }
            
            DeliveyDate.text = dateString;
        }
        
    } @catch (NSException *exception) {
        
    }

}

#pragma mark textField delegates:

/**
 * @description  it is textfiled delegate method it will executed first.......
 * @date         26/09/2016
 * @method       textFieldShouldBeginEditing:
 * @author       Bhargav Ram
 * @param        UITextField
 * @param
 * @return       BOOL
 *
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the comment's section....
 *
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (textField.frame.origin.x == qtyField.frame.origin.x || textField.frame.origin.x  == appQtyField.frame.origin.x)
        
        reloadTableData = false;
    
    return YES;
    
}

/**
 * @description  it is textfiled delegate method it will executed after execution of textFieldShouldBeginEditing .......
 * @date         26/09/2016
 * @method       textFieldDidBeginEditing:
 * @author       Bhargav Ram
 * @param        UITextField
 * @param
 * @return       void
 *
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the comment's section....
 *
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)textFieldDidBeginEditing:(UITextField*)textField{
    
    @try {
        
        if(textField == searchItemTxt){
            
            offSetViewTo = 120;
        }
        
        else if (textField.frame.origin.x == qtyField.frame.origin.x || textField.frame.origin.x  == appQtyField.frame.origin.x) {
            
            [textField selectAll:nil];
            [UIMenuController sharedMenuController].menuVisible = NO;
            
            int count = (int)textField.tag;
            
            if(textField.tag > 9)
                
                count = 9;
            
            offSetViewTo = (textField.frame.origin.y + textField.frame.size.height) * count + requestedItemsTbl.frame.origin.y;
        }
        
        [self keyboardWillShow];
        
    } @catch (NSException * exception) {
        
    }
}

/**
 * @description  it is textfiled delegate method it will executed after execution of textFieldDidBeginEditing.......
 * @date         26/09/2016
 * @method       shouldChangeCharactersInRange:
 * @author       Bhargav Ram
 * @param        UITextField
 * @param        NSRange
 * @param        NSString
 * @return       BOOL
 *
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the comment's section....
 *
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.frame.origin.x == qtyField.frame.origin.x || textField.frame.origin.x  == appQtyField.frame.origin.x) {
        
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
 * @description  it is textfiled delegate method it will executed after execution of textFieldDidBeginEditing .......
 * @date         26/09/2016
 * @method       textFieldDidChange:
 * @author       Bhargav Ram
 * @param        UITextField
 * @param
 * @return       BOOL
 *
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the comment's section....
 *
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)textFieldDidChange:(UITextField *)textField {
    
    if (textField == searchItemTxt) {
        
        if ((textField.text).length >= 3) {
            
            @try {
                
                if (searchItemTxt.tag == 0) {
                    
                    searchItemTxt.tag = (textField.text).length;
                    
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
            searchItemTxt.tag = 0;
            [catPopOver dismissPopoverAnimated:YES];
            
        }
    }
    
    else if (textField.frame.origin.x == qtyField.frame.origin.x|| textField.frame.origin.x == appQtyField.frame.origin.x) {
        reloadTableData = true;
        
        NSCharacterSet * whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString * trimmedString = [textField.text stringByTrimmingCharactersInSet:whitespace];
        
        @try {
            NSString * qtyKey = QUANTITY;
            
            if(textField.frame.origin.x == appQtyField.frame.origin.x)
                
                qtyKey = kApprovedQty;
            
            NSMutableDictionary * temp = [rawMaterialDetails[textField.tag]  mutableCopy];
            
            [temp setValue:textField.text  forKey:qtyKey];
            
            if([qtyKey isEqualToString:QUANTITY]) {
                
                [temp setValue:textField.text  forKey:kApprovedQty];
                
            }
            
            if( (textField.text).integerValue >[[temp valueForKey:QUANTITY] integerValue] ){
                
                NSString *mesg = NSLocalizedString(@"approved_qty_should_be_less_then_or_equal_to_requested_qty", nil);
                
                [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 500)/2   verticalAxis:(searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height + 100)   msgType:NSLocalizedString(@"warning", nil)  conentWidth:500 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
                
                return;
            }
            
            if (trimmedString.length == 0)
                trimmedString = @"0";
            
            [temp setValue:trimmedString forKey:kApprovedQty];
            
            rawMaterialDetails[textField.tag] = temp;
        }
        @catch (NSException * exception) {
            NSLog(@"---%@",exception);
        }
        @finally {
            
        }
    }
}

/**
 * @description  it is textfiled delegate method it will executed after execution of textFieldDidBeginEditing .......
 * @date         26/09/2016
 * @method       textFieldDidEndEditing:
 * @author       Bhargav Ram
 * @param        UITextField
 * @param        NSRange
 * @param        NSString
 * @return       BOOL
 *
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the comment's section....
 *
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [self keyboardWillHide];
    offSetViewTo = 0;
    
    if (textField.frame.origin.x == qtyField.frame.origin.x||textField.frame.origin.x == appQtyField.frame.origin.x ) {
        
        NSCharacterSet * whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString       * trimmedString = [textField.text stringByTrimmingCharactersInSet:whitespace];
        
        @try {
            
            NSString * qtyKey = QUANTITY;
            
            if(textField.frame.origin.x == appQtyField.frame.origin.x)
                
                qtyKey = kApprovedQty;
            
            NSMutableDictionary * temp = [rawMaterialDetails[textField.tag]  mutableCopy];
            
            [temp setValue:textField.text  forKey:qtyKey];
            
            if([qtyKey isEqualToString: QUANTITY]) {
                
                [temp setValue:textField.text  forKey:kApprovedQty];
            }
            
            if( (textField.text).integerValue >[[temp valueForKey:QUANTITY] integerValue] ){
                
                NSString * mesg = NSLocalizedString(@"approved_qty_should_be_less_then_or_equal_to_requested_qty", nil);
                
                [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 500)/2   verticalAxis:(searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height + 100)   msgType:NSLocalizedString(@"warning", nil)  conentWidth:500 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
                
                return;
            }
            
            if (trimmedString.length == 0)
                trimmedString = @"0";
            
            [temp setValue:trimmedString forKey:kApprovedQty];
            
            rawMaterialDetails[textField.tag] = temp;
            
            //}
        }
        @catch (NSException *exception) {
            NSLog(@"---------%@",exception);
        }
        @finally {
            if(reloadTableData)
                [requestedItemsTbl reloadData];
            [self calculateTotal];
            
        }
    }
}

/**
 * @description  it is textfiled delegate method it will executed after execution of textFieldDidBeginEditing .......
 * @date         26/09/2016
 * @method       textFieldShouldReturn:
 * @author       Bhargav Ram
 * @param        UITextField
 * @param        NSRange
 * @param        NSString
 * @return       BOOL
 *
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the comment's section....
 *
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma -mark start of UITableViewDelegateMethods

/**
 * @description  it is tableview delegate method it will be called after numberOfSection.......
 * @date         26/09/2016
 * @method       showCompleteStockRequestInfo: numberOfRowsInSection:
 * @author       Bhargav Ram
 * @param        UITableView
 * @param        NSInteger
 * @return       NSInteger
 *
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the comment's section....
 *
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == productListTbl) {
        
        return productList.count;
    }
    
    else if (tableView == requestedItemsTbl) {
       
        @try {
            
            return rawMaterialDetails.count;
        }
        @catch (NSException *exception) {
            
        }
    }
    else if (tableView == shipModeTable) {
        return shipModesArr.count;
    }
    
    else if (tableView == priorityTbl) {
        return priorityArr.count;
    }
    else if (tableView == locationTable) {
        
        // if (fromStoreTxt.tag == 2 ) {
            return locationArr.count;
        //}
        //else{
        //return [warehouseLocationArr count];
        //}
    }
    else if (tableView == priceTable) {
        return priceArr.count;
    }
    
    else if (tableView == categoriesTbl ) {
        
        return categoriesArr.count;
    }
    else
        return false;
}


/**
 * @description  it is tableview delegate method it will be called after numberOfRowsInSection.......
 * @date         26/09/2016
 * @method       tableView: heightForRowAtIndexPath:
 * @author       Bhargav Ram
 * @param        UITableView
 * @param        NSIndexPath
 * @return       CGFloat
 *
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the comment's section....
 *
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (tableView == productListTbl || tableView == locationTable ||tableView == shipModeTable || tableView == priorityTbl  || tableView == categoriesTbl ||tableView == priceTable) {
       
        return 40;
    }
    
    else if (tableView == requestedItemsTbl){
        
        return 38;

    }
    
    else
        return 0.0;
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
 *
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the comment's section and populating the data into labels....
 *
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == productListTbl) {
        
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
            itemPriceLbl.numberOfLines = 1;
            itemPriceLbl.textColor = [UIColor blackColor];
            
            itemQtyInHandLbl = [[UILabel alloc] init] ;
            itemQtyInHandLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            itemQtyInHandLbl.layer.borderWidth = 1.5;
            itemQtyInHandLbl.backgroundColor =[UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
            itemQtyInHandLbl.textAlignment = NSTextAlignmentCenter;
            itemQtyInHandLbl.numberOfLines = 1;
            itemQtyInHandLbl.textColor = [UIColor blackColor];
            
            itemColorLbl = [[UILabel alloc] init] ;
            itemColorLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            itemColorLbl.layer.borderWidth = 1.5;
            itemColorLbl.backgroundColor =[UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
            itemColorLbl.textAlignment = NSTextAlignmentCenter;
            itemColorLbl.numberOfLines = 1;
            itemColorLbl.textColor = [UIColor blackColor];
            
            itemSizeLbl = [[UILabel alloc] init] ;
            itemSizeLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            itemSizeLbl.layer.borderWidth = 1.5;
            itemSizeLbl.backgroundColor =[UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
            itemSizeLbl.textAlignment = NSTextAlignmentCenter;
            itemSizeLbl.numberOfLines = 1;
            itemSizeLbl.textColor = [UIColor blackColor];
            
            itemMeasurementLbl = [[UILabel alloc] init] ;
            itemMeasurementLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            itemMeasurementLbl.layer.borderWidth = 1.5;
            itemMeasurementLbl.backgroundColor =[UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
            itemMeasurementLbl.textAlignment = NSTextAlignmentCenter;
            itemMeasurementLbl.numberOfLines = 1;
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
                itemMeasurementLbl.frame = CGRectMake( itemSizeLbl.frame.origin.x + itemSizeLbl.frame.size.width, 0, searchItemTxt.frame.size.width - (itemSizeLbl.frame.origin.x + itemSizeLbl.frame.size.width), itemDescLbl.frame.size.height);
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
    
    else if (tableView == requestedItemsTbl) {
       
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        static NSString *hlCellID = @"hlCellID";
        
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
        
        if ((hlcell.contentView).subviews){
            for (UIView *subview in (hlcell.contentView).subviews) {
                [subview removeFromSuperview];
            }
        }
        
        CAGradientLayer *layer_1;
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                       initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            
            @try {
                layer_1 = [CAGradientLayer layer];
                layer_1.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
                
                layer_1.frame = CGRectMake( S_No.frame.origin.x, hlcell.frame.size.height - 2,actionLbl.frame.origin.x+actionLbl.frame.size.width-(S_No.frame.origin.x), 1);
                
                [hlcell.contentView.layer addSublayer:layer_1];
                
            } @catch (NSException *exception) {
                
            }
        }
        
        @try {
            
            UILabel * itemNoLbl;
            UILabel * itemSkuIdLbl ;
            UILabel * itemDescLbl;
            //added by Srinivasulu on 11/05/2017...
            UILabel * itemUomLbl;
            UILabel * itemGradeLbl;
            
            UILabel * itemPriceLbl;
            UILabel * qoh_Lbl;
            UILabel * prv_Indent_Qty_Lbl;
            UILabel * proj_Qty_Lbl;
            
            
            UIButton * viewStockRequestBtn;
            
            UILabel * itemsCostLbl;
            
            itemsCostLbl = [[UILabel alloc] init];
            itemsCostLbl.backgroundColor = [UIColor clearColor];
            itemsCostLbl.layer.borderWidth = 0;
            itemsCostLbl.textAlignment = NSTextAlignmentCenter;
            itemsCostLbl.numberOfLines = 1;
            itemsCostLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            /*Creation of UIButton's used in this cell*/
            viewStockRequestBtn = [[UIButton alloc] init];
            //viewStockRequestBtn.backgroundColor = [UIColor blackColor];
            viewStockRequestBtn.titleLabel.textColor = [UIColor whiteColor];
            viewStockRequestBtn.userInteractionEnabled = YES;
            viewStockRequestBtn.tag = indexPath.row;
            
            //populating text into textFields....
            [viewStockRequestBtn setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0]forState:UIControlStateNormal];
            [viewStockRequestBtn setTitle:NSLocalizedString(@"more", nil) forState:UIControlStateNormal];
            viewStockRequestBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
            
            [viewStockRequestBtn addTarget:self action:@selector(moreButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            //upto here on 11/05//2017....
            
            
            itemNoLbl = [[UILabel alloc] init];
            itemNoLbl.backgroundColor = [UIColor clearColor];
            itemNoLbl.layer.borderWidth = 0;
            itemNoLbl.textAlignment = NSTextAlignmentCenter;
            itemNoLbl.numberOfLines = 1;
            itemNoLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            itemSkuIdLbl = [[UILabel alloc] init];
            itemSkuIdLbl.backgroundColor = [UIColor clearColor];
            itemSkuIdLbl.layer.borderWidth = 0;
            itemSkuIdLbl.textAlignment = NSTextAlignmentCenter;
            itemSkuIdLbl.numberOfLines = 1;
            itemSkuIdLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            
            itemDescLbl = [[UILabel alloc] init];
            itemDescLbl.backgroundColor = [UIColor clearColor];
            itemDescLbl.layer.borderWidth = 0;
            itemDescLbl.textAlignment = NSTextAlignmentCenter;
            itemDescLbl.numberOfLines = 1;
//            itemDescLbl.lineBreakMode = NSLineBreakByWordWrapping;
            itemDescLbl.lineBreakMode = NSLineBreakByTruncatingTail;

            
            itemUomLbl = [[UILabel alloc] init];
            itemUomLbl.backgroundColor = [UIColor clearColor];
            itemUomLbl.layer.borderWidth = 0;
            itemUomLbl.textAlignment = NSTextAlignmentCenter;
            itemUomLbl.numberOfLines = 1;
            itemUomLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            
            itemGradeLbl = [[UILabel alloc] init];
            itemGradeLbl.backgroundColor = [UIColor clearColor];
            itemGradeLbl.layer.borderWidth = 0;
            itemGradeLbl.textAlignment = NSTextAlignmentCenter;
            itemGradeLbl.numberOfLines = 1;
//            itemGradeLbl.lineBreakMode = NSLineBreakByWordWrapping;
            itemGradeLbl.lineBreakMode = NSLineBreakByTruncatingTail;

            
            itemPriceLbl = [[UILabel alloc] init];
            itemPriceLbl.backgroundColor = [UIColor clearColor];
            itemPriceLbl.layer.borderWidth = 0;
            itemPriceLbl.textAlignment = NSTextAlignmentCenter;
            itemPriceLbl.numberOfLines = 1;
            itemPriceLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            qoh_Lbl = [[UILabel alloc] init];
            qoh_Lbl.backgroundColor = [UIColor clearColor];
            qoh_Lbl.layer.borderWidth = 0;
            qoh_Lbl.textAlignment = NSTextAlignmentCenter;
            qoh_Lbl.numberOfLines = 1;
            qoh_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            prv_Indent_Qty_Lbl = [[UILabel alloc] init];
            prv_Indent_Qty_Lbl.backgroundColor = [UIColor clearColor];
            prv_Indent_Qty_Lbl.layer.borderWidth = 0;
            prv_Indent_Qty_Lbl.textAlignment = NSTextAlignmentCenter;
            prv_Indent_Qty_Lbl.numberOfLines = 1;
            prv_Indent_Qty_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            
            proj_Qty_Lbl = [[UILabel alloc] init];
            proj_Qty_Lbl.backgroundColor = [UIColor clearColor];
            proj_Qty_Lbl.layer.borderWidth = 0;
            proj_Qty_Lbl.textAlignment = NSTextAlignmentCenter;
            proj_Qty_Lbl.numberOfLines = 1;
            proj_Qty_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            qtyField = [[UITextField alloc] init];
            qtyField.borderStyle = UITextBorderStyleRoundedRect;
            qtyField.textColor = [UIColor blackColor];
            qtyField.keyboardType = UIKeyboardTypeNumberPad;
            qtyField.layer.borderWidth = 2;
            qtyField.backgroundColor = [UIColor clearColor];
            qtyField.autocorrectionType = UITextAutocorrectionTypeNo;
            qtyField.clearButtonMode = UITextFieldViewModeWhileEditing;
            qtyField.returnKeyType = UIReturnKeyDone;
            qtyField.delegate = self;
            [qtyField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            
            qtyField.textAlignment = NSTextAlignmentCenter;
            qtyField.keyboardType = UIKeyboardTypeNumberPad;
            qtyField.tag = indexPath.row;
            qtyField.userInteractionEnabled = YES;
            
            appQtyField = [[UITextField alloc] init];
            appQtyField.borderStyle = UITextBorderStyleRoundedRect;
            appQtyField.textColor = [UIColor blackColor];
            appQtyField.keyboardType = UIKeyboardTypeNumberPad;
            appQtyField.layer.borderWidth = 2;
            appQtyField.backgroundColor = [UIColor clearColor];
            appQtyField.autocorrectionType = UITextAutocorrectionTypeNo;
            appQtyField.clearButtonMode = UITextFieldViewModeWhileEditing;
            appQtyField.returnKeyType = UIReturnKeyDone;
            appQtyField.delegate = self;
            [appQtyField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            appQtyField.textAlignment = NSTextAlignmentCenter;
            appQtyField.keyboardType = UIKeyboardTypeNumberPad;
            appQtyField.tag = indexPath.row;
            
            if (!isHubLevel) {
                
              appQtyField.userInteractionEnabled = NO;
            }
            
            delrowbtn = [[UIButton alloc] init];
            [delrowbtn setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
            [delrowbtn addTarget:self action:@selector(delRow:) forControlEvents:UIControlEventTouchUpInside];
            delrowbtn.tag = indexPath.row;
            delrowbtn.backgroundColor = [UIColor clearColor];
            
            itemNoLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            itemSkuIdLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            itemDescLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            itemUomLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            itemGradeLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            itemPriceLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            qoh_Lbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            prv_Indent_Qty_Lbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            proj_Qty_Lbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            qtyField.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            appQtyField.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            itemNoLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemSkuIdLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemDescLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemUomLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemGradeLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemPriceLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            qoh_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            prv_Indent_Qty_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            proj_Qty_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            qtyField.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            appQtyField.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            //upto here on 11/05//2017....
            
            [hlcell.contentView addSubview:itemNoLbl];
            [hlcell.contentView addSubview:itemSkuIdLbl];
            [hlcell.contentView addSubview:itemDescLbl];
            [hlcell.contentView addSubview:itemUomLbl];
            [hlcell.contentView addSubview:itemGradeLbl];
            [hlcell.contentView addSubview:itemPriceLbl];
            [hlcell.contentView addSubview:qoh_Lbl];
            [hlcell.contentView addSubview:prv_Indent_Qty_Lbl];
            [hlcell.contentView addSubview:proj_Qty_Lbl];
            
            [hlcell.contentView addSubview:qtyField];
            [hlcell.contentView addSubview:appQtyField];
            
            [hlcell.contentView addSubview:delrowbtn];
            [hlcell.contentView addSubview:viewStockRequestBtn];
            
            @try {
                
                NSDictionary * temp = rawMaterialDetails[indexPath.row];
                
                itemNoLbl.text = [NSString stringWithFormat:@"%li",(indexPath.row + 1)];
                
                itemSkuIdLbl.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:ITEM_SKU] defaultReturn:@"--"];//ITEM_SKU
                itemDescLbl.text =  [self checkGivenValueIsNullOrNil:[temp valueForKey:ITEM_DESC] defaultReturn:@"--"];
                
                if ([[temp valueForKey:SELL_UOM]isKindOfClass:[NSNull class]]|| (![[temp valueForKey:SELL_UOM]isEqualToString:@""])) {
                    
                    itemUomLbl.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:SELL_UOM] defaultReturn:@"--"];
                }
                else
                    itemUomLbl.text = @"--";
                
                if ([[temp valueForKey:PRODUCT_RANGE]isKindOfClass:[NSNull class]]|| (![[temp valueForKey:PRODUCT_RANGE]isEqualToString:@""])) {
                    
                    itemGradeLbl.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:PRODUCT_RANGE] defaultReturn:@"--"];
                }
                else
                    itemGradeLbl.text = @"--";

                itemPriceLbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[temp valueForKey:ITEM_PRICE] defaultReturn:@"0.00"] floatValue]];
                
                qoh_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[temp valueForKey:AVL_QTY] defaultReturn:@"0.00"] floatValue]];
                
                prv_Indent_Qty_Lbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[temp valueForKey:kPrvIndentQty] defaultReturn:@"0.00"] floatValue]];
                
                proj_Qty_Lbl.text = [NSString stringWithFormat:@"%.2f",(qoh_Lbl.text).floatValue + (prv_Indent_Qty_Lbl.text).floatValue];
                
                qtyField.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[temp valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]];
                
                appQtyField.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[temp valueForKey:kApprovedQty] defaultReturn:@"0.00"] floatValue]];
            }
            @catch (NSException * exception) {
                
            }
            
            //setting frame and font........
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                //changed by Srinivasulu on 14/04/2017.....
                
                itemNoLbl.frame = CGRectMake(S_No.frame.origin.x, 0, S_No.frame.size.width, hlcell.frame.size.height);
                
                itemSkuIdLbl.frame = CGRectMake( skuId.frame.origin.x, 0, skuId.frame.size.width,  hlcell.frame.size.height);
                
                itemDescLbl.frame = CGRectMake( descriptionLbl.frame.origin.x, 0, descriptionLbl.frame.size.width,  hlcell.frame.size.height);
                
                itemUomLbl.frame= CGRectMake( uomLbl.frame.origin.x, 0, uomLbl.frame.size.width,  hlcell.frame.size.height);
                
                itemGradeLbl.frame= CGRectMake( gradeLbl.frame.origin.x, 0, gradeLbl.frame.size.width,  hlcell.frame.size.height);
                
                itemPriceLbl.frame = CGRectMake( priceLbl.frame.origin.x, 0, priceLbl.frame.size.width,  hlcell.frame.size.height);
                
                qoh_Lbl.frame = CGRectMake( qohLbl.frame.origin.x, 0, qohLbl.frame.size.width,  hlcell.frame.size.height);
                
                prv_Indent_Qty_Lbl.frame = CGRectMake( prvIndentQtyLbl.frame.origin.x, 0, prvIndentQtyLbl.frame.size.width,  hlcell.frame.size.height);
                
                proj_Qty_Lbl.frame = CGRectMake(projQtyLbl.frame.origin.x, 0, projQtyLbl.frame.size.width,  hlcell.frame.size.height);
                
                //upto here on 14/04/2017....
                qtyField.frame = CGRectMake(qtyLbl.frame.origin.x + 2, 2, qtyLbl.frame.size.width - 4,  36);
                
                appQtyField.frame = CGRectMake(approvedQtyLbl.frame.origin.x + 2, 2, approvedQtyLbl.frame.size.width - 4,  36);
                
                viewStockRequestBtn.frame = CGRectMake(actionLbl.frame.origin.x,0,actionLbl.frame.size.width-30,40);
                
                delrowbtn.frame= CGRectMake(viewStockRequestBtn.frame.origin.x+viewStockRequestBtn.frame.size.width,5,35,35);
                
                //upto here on 14/04/2017.....
                
                //setting font size....
                [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView: hlcell andSubViews:YES fontSize:16.0 cornerRadius:0.0];
                
            }
            else{
                
            }
            
        } @catch (NSException * exception) {
            
        } @finally {
            
            hlcell.backgroundColor = [UIColor clearColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            return hlcell;
        }
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
            NSDictionary *dic = priceArr[indexPath.row];
            
            UILabel * skid = [[UILabel alloc] init] ;
            skid.layer.borderWidth = 1.5;
            skid.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            skid.backgroundColor = [UIColor blackColor];
            skid.textColor = [UIColor whiteColor];
            skid.textAlignment=NSTextAlignmentCenter;
            
            UILabel * mrpPrice = [[UILabel alloc] init] ;
            mrpPrice.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            mrpPrice.layer.borderWidth = 1.5;
            mrpPrice.backgroundColor = [UIColor blackColor];
            mrpPrice.textAlignment = NSTextAlignmentCenter;
            mrpPrice.numberOfLines = 1;
            mrpPrice.textColor = [UIColor whiteColor];
            
            UILabel * price = [[UILabel alloc] init] ;
            price.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            price.layer.borderWidth = 1.5;
            price.backgroundColor = [UIColor blackColor];
            price.textAlignment = NSTextAlignmentCenter;
            price.numberOfLines = 1;
            price.textColor = [UIColor whiteColor];
            
            // added by roja on 30/04/2019....
            UILabel * productBatchNoValueLbl = [[UILabel alloc] init] ;
            productBatchNoValueLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            productBatchNoValueLbl.layer.borderWidth = 1.5;
            productBatchNoValueLbl.backgroundColor = [UIColor blackColor];
            productBatchNoValueLbl.textAlignment = NSTextAlignmentCenter;
            productBatchNoValueLbl.numberOfLines = 1;
            productBatchNoValueLbl.textColor = [UIColor whiteColor];
            //upto here added by roja on 30/04/2019....

            skid.font = [UIFont fontWithName:TEXT_FONT_NAME size:14.0f];
            mrpPrice.font = [UIFont fontWithName:TEXT_FONT_NAME size:14.0f];
            price.font = [UIFont fontWithName:TEXT_FONT_NAME size:14.0f];
            productBatchNoValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14.0f];
            
            skid.text = [dic valueForKey:kDescription];
            mrpPrice.text = [NSString stringWithFormat:@"%.2f",[[dic valueForKey:SALE_PRICE] floatValue]];
            price.text = [NSString stringWithFormat:@"%.2f",[[dic valueForKey:kPrice] floatValue]];
            // added by roja on 30/04/2019..
            productBatchNoValueLbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:PRODUCT_BATCH_NO] defaultReturn:@""];
            
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            hlcell.backgroundColor = [UIColor clearColor];
            [hlcell.contentView addSubview:skid];
            [hlcell.contentView addSubview:price];
            [hlcell.contentView addSubview:mrpPrice];
            [hlcell.contentView addSubview:productBatchNoValueLbl];
            
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
                    
                    skid.frame = CGRectMake( 0, 0, descLabl.frame.size.width + 1, hlcell.frame.size.height);
                    
                    mrpPrice.frame = CGRectMake(skid.frame.origin.x + skid.frame.size.width, 0, mrpLbl.frame.size.width + 2,  hlcell.frame.size.height);
                    
                    price.frame = CGRectMake(mrpPrice.frame.origin.x + mrpPrice.frame.size.width, 0, priceLabl.frame.size.width+2, hlcell.frame.size.height);
                    
                    productBatchNoValueLbl.frame = CGRectMake(price.frame.origin.x + price.frame.size.width, 0, productBatchNoLabel.frame.size.width+2, hlcell.frame.size.height);
                }
            }
            
        }
        @catch (NSException *exception) {
            
            NSLog(@"%@",exception);
            
        }
      
        return hlcell;
    }
    
    else if (tableView == shipModeTable){
        
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
    
    else if (tableView == priorityTbl){
        
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
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            
        }
        
        hlcell.textLabel.text = [self checkGivenValueIsNullOrNil:priorityArr[indexPath.row]  defaultReturn:@""];
        hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        hlcell.textLabel.numberOfLines = 1;
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return hlcell;
    }
    
    else if (tableView == locationTable){
        
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
            
            //if (fromStoreTxt.tag == 2  ) {
                
            hlcell.textLabel.text = [self checkGivenValueIsNullOrNil:locationArr[indexPath.row]  defaultReturn:@""];

            //}
            // else{
            
            //hlcell.textLabel.text = [self checkGivenValueIsNullOrNil:[[warehouseLocationArr objectAtIndex:indexPath.row] valueForKey:@"locationId"]  defaultReturn:@""];
            //}
        } @catch (NSException *exception) {
            
        }
        hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        hlcell.textLabel.numberOfLines = 1;
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return hlcell;
    }
    
    else if (tableView == categoriesTbl){
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
            
            if( checkBoxArr.count && categoriesArr.count ){
                if([checkBoxArr[indexPath.row] integerValue])
                    checkBoxImg = [UIImage imageNamed:@"checkbox_on_background.png"];
                checkBoxsBtn.userInteractionEnabled = YES;
            }
            [checkBoxsBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
            checkBoxsBtn.tag = indexPath.row;
            [checkBoxsBtn addTarget:self action:@selector(changeCheckBoxImages:) forControlEvents:UIControlEventTouchUpInside];
            [hlcell.contentView addSubview:checkBoxsBtn];
            checkBoxsBtn.frame = CGRectMake(selectAllCheckBoxBtn.frame.origin.x, 7, 30 , 30);
            
//            // added by roja...
//            if(selectAllCheckBoxBtn.tag == 4){
//                [selectAllCheckBoxBtn setBackgroundImage:[UIImage imageNamed:@"checkbox_on_background.png"] forState:UIControlStateNormal];
//            }
//            else{
//                [selectAllCheckBoxBtn setBackgroundImage:[UIImage imageNamed:@"checkbox_off_background.png"] forState:UIControlStateNormal];
//            }
            
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
    return false;
}

/**
 * @description  it is tableview delegate method it will be called after willDisplayCell.......
 * @date         26/09/2016
 * @method       tableView: didSelectRowAtIndexPath:
 * @author       Bhargav Ram
 * @param        UITableView
 * @param        NSIndexPath
 * @param
 * @return       void
 *
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       changed the comment's section....
 *
 * @return
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
        
        searchItemTxt.text = @"";

    }
    
    else if (tableView == shipModeTable){
        
        shipmentModeTxt.text = shipModesArr[indexPath.row];
        [catPopOver dismissPopoverAnimated:YES];
        
    }
    else if (tableView == priorityTbl) {
        
        priorityTxt.text = priorityArr[indexPath.row];
        [catPopOver dismissPopoverAnimated:YES];
    }
    
    else if (tableView == locationTable){
        //if (fromStoreTxt.tag == 2  ) {
        //
        ////   toLocationText.text = @"";
        //fromStoreTxt.text = [locationArr objectAtIndex:indexPath.row] ;
        //[catPopOver dismissPopoverAnimated:YES];
        //}
        //else{
        //fromStoreTxt.text = @"";
        toLocationText.text = [self checkGivenValueIsNullOrNil:locationArr[indexPath.row]  defaultReturn:@""];
        // added by roja on 02-07-2018...
        businessActivityStr = [self checkGivenValueIsNullOrNil:businessActivityArr[indexPath.row] defaultReturn:@""];
        //}
    }
    
    else if (tableView == priceTable) {
        
        //added by Srinisulu on 14/04/2017 expansion handling....
        
        @try {
            
            transparentView.hidden = YES;
            
            NSDictionary * detailsDic = priceArr[indexPath.row];
            
            BOOL status = FALSE;
            
            int i=0;
            NSMutableDictionary *dic;
            
            for ( i=0; i<rawMaterialDetails.count;i++) {
                
                dic = rawMaterialDetails[i];
                if ([[dic valueForKey:ITEM_SKU] isEqualToString:[detailsDic valueForKey:ITEM_SKU]] && [[dic valueForKey:PLU_CODE] isEqualToString:[detailsDic valueForKey:PLU_CODE]] && [[dic valueForKey:PRODUCT_BATCH_NO] isEqualToString:[detailsDic valueForKey:PRODUCT_BATCH_NO]]) {
                    // PRODUCT_BATCH_NO included by roja on 30/04/19..
                    
                    [dic setValue:[NSString stringWithFormat:@"%d",[[dic valueForKey:kApprovedQty] intValue] + 1] forKey:kApprovedQty];
                    [dic setValue:[NSString stringWithFormat:@"%d",[[dic valueForKey:QUANTITY] intValue] + 1] forKey:QUANTITY];
                    
                    rawMaterialDetails[i] = dic;
                    
                    status = TRUE;
                    break;
                }
            }
            
            if (!status) {
                
                NSMutableDictionary *itemDetailsDic = [[NSMutableDictionary alloc] init];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:ITEM_SKU] defaultReturn:@"--"] forKey:ITEM_SKU];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:PLU_CODE] defaultReturn:@"--"] forKey:PLU_CODE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:ITEM_DESCRIPTION] defaultReturn:@"--"] forKey:ITEM_DESC];
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:cost_Price] defaultReturn:@"0.00"] floatValue]] forKey:ITEM_PRICE];

                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:QUANTITY];
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:kApprovedQty];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
                
                //newly added keys....
                //added by  Srinivasulu on  14/04/2017....
                
                //setting availiable qty....
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:AVAILABLE_QTY] defaultReturn:@"0.00"] floatValue]] forKey:AVL_QTY];
                
                //setting availiable qty....
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:AVL_QTY];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:kMeasureRange] defaultReturn:@""] forKey:MEASUREMENT_RANGE];
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:kProductBrand] defaultReturn:@""] forKey:kBrand];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:EAN] defaultReturn:@""] forKey:EAN];
                
                // added by roja on 30/04/2019...
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:PRODUCT_BATCH_NO] defaultReturn:@""] forKey:PRODUCT_BATCH_NO];

                
                //upto here on 13/04/2017.....
                
                [rawMaterialDetails addObject:itemDetailsDic];
            }
            else
                rawMaterialDetails[i] = dic;
            
            [self calculateTotal];
            
            [requestedItemsTbl reloadData];
            
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
    else if (tableView == categoriesTbl) {
        
    }
}

#pragma -mark calculationTotal

/**
 * @description   Here we are calculating the Totalprice of order...
 * @requestDteFld 27/09/2016
 * @method        calculateTotal
 * @author        Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)calculateTotal {
    
    float quantityOnHand = 0.0;
    float previousQty    = 0.0;
    float projectedQty   = 0.0;
    float requestedQty   = 0.0;
    float approvedQty    = 0.0;
    
    for(NSDictionary * dic in rawMaterialDetails){
        
        quantityOnHand += [[self checkGivenValueIsNullOrNil:[dic valueForKey:AVL_QTY] defaultReturn:@"0.00"]floatValue];
        
        previousQty    += [[self checkGivenValueIsNullOrNil:[dic valueForKey:kPrvIndentQty] defaultReturn:@"0.00"]floatValue];
        
        projectedQty   += ([[dic valueForKey:AVL_QTY] floatValue] + [[dic valueForKey:kPrvIndentQty] floatValue]);
        
        requestedQty   +=  [[self checkGivenValueIsNullOrNil:[dic valueForKey:QUANTITY] defaultReturn:@"0.00"]floatValue];
        
        approvedQty    +=  [[self checkGivenValueIsNullOrNil:[dic valueForKey:kApprovedQty] defaultReturn:@"0.00"]floatValue];
        
    /* // Tax Rate calculation...
        NSArray *taxArr = [dic valueForKey:TAX];
        
        float itemTaxAmt = 0;
        float itemPrice = [[dic valueForKey:kPrice] floatValue];
        float itemTotalPrice = [[dic valueForKey:kPrice] floatValue] * [[dic valueForKey:QUANTITY] floatValue] ;

        for (NSDictionary *taxDict in taxArr) {
            
            float itemTaxRate = [[taxDict valueForKey:@"taxRate"] floatValue];
            NSString *itemTaxType = [taxDict valueForKey:@"taxType"] ;
            
            for(NSDictionary *saleRangeListDic in [taxDict valueForKey:@"saleRangesList"])
            {
                if ( ([[saleRangeListDic valueForKey:@"saleValueFrom"] floatValue] <= itemPrice) && (itemPrice >= [[saleRangeListDic valueForKey:@"saleValueTo"] floatValue]) ) {
                    
                    itemTaxRate = [[saleRangeListDic valueForKey:@"taxRate"] floatValue];
            }
            }
            
            if ([[dic valueForKey:@"itemTaxExclusive"] boolValue] && [[itemTaxType lowercaseString] isEqualToString:percentage]) {
                itemTaxAmt += itemTotalPrice * (itemTaxRate/100);
            }
        }
        */
        
    }
    quantityOnHandValueLbl.text  = [NSString stringWithFormat:@"%@%.2f",@"",quantityOnHand];
    previousQtyValueLbl.text     = [NSString stringWithFormat:@"%@%.2f",@" ",previousQty];
    projectedQtyValueLbl.text    = [NSString stringWithFormat:@"%@%.2f",@" ",projectedQty];
    requestedQtyvalueLbl.text    = [NSString stringWithFormat:@"%@%.2f",@" ",requestedQty];
    approvedQtyValueLbl.text     = [NSString stringWithFormat:@"%@%.2f",@" ",approvedQty];
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
    
    //play audio for button touch...
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        PopOverViewController * categoriesPopover = [[PopOverViewController alloc] init];
        
        categoriesView = [[UIView alloc] initWithFrame:CGRectMake(selectCategoriesBtn.frame.origin.x,searchItemTxt.frame.origin.y,300,350)];
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
        UIButton * cancelBtn;
        
        headerNameLbl = [[UILabel alloc] init];
        headerNameLbl.layer.cornerRadius = 10.0f;
        headerNameLbl.layer.masksToBounds = YES;
        headerNameLbl.text = @"Categories List";
        
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
        selectAllLbl.text = @"Select All";
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
        [okButton setTitle:@"OK" forState:UIControlStateNormal];
        okButton.backgroundColor = [UIColor grayColor];
        okButton.layer.masksToBounds = YES;
        okButton.userInteractionEnabled = YES;
        okButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        okButton.layer.cornerRadius = 5.0f;
        [okButton addTarget:self action:@selector(multipleCategriesSelection:) forControlEvents:UIControlEventTouchDown];
        
        
        cancelBtn = [[UIButton alloc] init] ;
        [cancelBtn setTitle:@"CANCEL" forState:UIControlStateNormal];
        cancelBtn.backgroundColor = [UIColor grayColor];
        cancelBtn.layer.masksToBounds = YES;
        cancelBtn.userInteractionEnabled = YES;
        cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        cancelBtn.layer.cornerRadius = 5.0f;
        [cancelBtn addTarget:self action:@selector(dismissCategoryPopOver:) forControlEvents:UIControlEventTouchDown];
        
        [categoriesView addSubview:headerNameLbl];
        [categoriesView addSubview:selectAllLbl];
        [categoriesView addSubview:selectAllCheckBoxBtn];
        [categoriesView addSubview:categoriesTbl];
        [categoriesView addSubview:okButton];
        [categoriesView addSubview:cancelBtn];
        
        headerNameLbl.frame = CGRectMake(0,0,categoriesView.frame.size.width,50);
        
        selectAllCheckBoxBtn.frame = CGRectMake(10,headerNameLbl.frame.origin.y+headerNameLbl.frame.size.height+10,30,30);
        
        selectAllLbl.frame = CGRectMake(selectAllCheckBoxBtn.frame.origin.x+selectAllCheckBoxBtn.frame.size.width+10,selectAllCheckBoxBtn.frame.origin.y-5,95,40);
        
        categoriesTbl.frame = CGRectMake(0,selectAllCheckBoxBtn.frame.origin.y+selectAllCheckBoxBtn.frame.size.height+10,categoriesView.frame.size.width,200);
        
        okButton.frame = CGRectMake(selectAllLbl.frame.origin.x,categoriesTbl.frame.origin.y+categoriesTbl.frame.size.height+5,100,40);
        cancelBtn.frame = CGRectMake(okButton.frame.origin.x+okButton.frame.size.width+20,categoriesTbl.frame.origin.y+categoriesTbl.frame.size.height+5,100,40);
        
        categoriesPopover.view = categoriesView;
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            
            categoriesPopover.preferredContentSize =  CGSizeMake(categoriesView.frame.size.width, categoriesView.frame.size.height);
            UIPopoverController *popOver = [[UIPopoverController alloc] initWithContentViewController:categoriesPopover];
            [popOver presentPopoverFromRect:selectCategoriesBtn.frame inView:stockRequestView permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
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


#pragma -mark used to move the slef.view when keyBoard apperace

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

/**
 * @description  method to move the view up/down whenever the keyboard is shown/dismissed
 * @date         04/06/2016
 * @method       setViewMovedUp
 * @author       Bhargav
 * @param        BOOL
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

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
        NSLog(@"----exception while changing frame self.view-----%@",exception);
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
            
            if(searchItemTxt.isEditing)
                yPosition = searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height;
            
            
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


#pragma -mark actions with service calls


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

            for(NSDictionary * newSkuItemDic in [successDictionary valueForKey:SKU_LIST]){
                
                //checking priceList is existing or not....
                if([[newSkuItemDic valueForKey:SKU_PRICE_LIST] count]){
                    
                    for(NSDictionary * newSkuPriceListDic in [newSkuItemDic valueForKey:SKU_PRICE_LIST]){
                        
                        BOOL isExistingItem = false;
                        
                        NSDictionary * existItemdic;
                        
                        int i = 0;
                        
                        for (i= 0; i < rawMaterialDetails.count; i++) {
                            
                            //reading the existing cartItem....
                            existItemdic = rawMaterialDetails[i];
                            
                            if ([[existItemdic valueForKey:ITEM_SKU] isEqualToString:[newSkuPriceListDic valueForKey:ITEM_SKU]]) {

                                [existItemdic setValue:[NSString stringWithFormat:@"%d",[[existItemdic valueForKey:QUANTITY] intValue] + 1] forKey:QUANTITY];
                                [existItemdic setValue:[NSString stringWithFormat:@"%d",[[existItemdic valueForKey:kApprovedQty] intValue] + 1] forKey:kApprovedQty];

                                
                                rawMaterialDetails[i] = existItemdic;
                                
                                isExistingItem = true;
                                
                                break;
                            }
                        }
//
//                        if(isExistingItem) {
//
//                            [rawMaterialDetails replaceObjectAtIndex:i withObject:existItemdic];
//                        }
//                        else{
                        
                        
                       if(!isExistingItem) {
                            
                            NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc ]init];
                            
                           // added keys....
                           // added by roja on 06/07/2018
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:ITEM_SKU] defaultReturn:EMPTY_STRING] forKey:ITEM_SKU];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:PLU_CODE] defaultReturn:EMPTY_STRING] forKey:PLU_CODE];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:ITEM_DESCRIPTION] defaultReturn:EMPTY_STRING] forKey:ITEM_DESC];
                           
                           [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:cost_Price] defaultReturn:@"0.00"] floatValue]] forKey:iTEM_PRICE];
                           
                           [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:QUANTITY_IN_HAND] defaultReturn:@"0.00"] floatValue]] forKey:AVL_QTY];
                           
                           [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:kPrvIndentQty] defaultReturn:@"0.00"] floatValue]] forKey:kPrvIndentQty];
                           
                           [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:kProjectedQty] defaultReturn:@"0.00"] floatValue]] forKey:kProjectedQty];
                           
                           [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:QUANTITY];
                           [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:kApprovedQty];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:COLOR] defaultReturn:EMPTY_STRING] forKey:COLOR];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:MODEL] defaultReturn:EMPTY_STRING] forKey:MODEL];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:SIZE] defaultReturn:EMPTY_STRING] forKey:SIZE];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:SELL_UOM] defaultReturn:EMPTY_STRING] forKey:SELL_UOM];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:PRODUCT_RANGE] defaultReturn:EMPTY_STRING] forKey:PRODUCT_RANGE];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:kMeasureRange] defaultReturn:EMPTY_STRING] forKey:MEASUREMENT_RANGE];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:ITEM_CATEGORY] defaultReturn:EMPTY_STRING] forKey:ITEM_CATEGORY];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:kProductBrand] defaultReturn:EMPTY_STRING] forKey:kBrand];
                           
                           
                           [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:QOH];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:TRACKING_REQUIRED] defaultReturn:EMPTY_STRING] forKey:TRACKING_REQUIRED];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:UTILITY] defaultReturn:EMPTY_STRING] forKey:UTILITY];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:EAN] defaultReturn:@""] forKey:EAN];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:ITEM_SKU] defaultReturn:EMPTY_STRING] forKey:kProductId];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:kSubCategory] defaultReturn:EMPTY_STRING] forKey:kSubCategory];
                           
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:ITEM_SCAN_CODE] defaultReturn:EMPTY_STRING] forKey:ITEM_SCAN_CODE];
                           
                           [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:MAKE] defaultReturn:EMPTY_STRING] forKey:MAKE];

                            //Checking is isPacked item based on the Boolean value
                            
                            float qty = 0;
                            
                            if (qty == 0) {
                                
                                BOOL isPackedItem = false;
                                
                                int minimumQty = 0;
                                
                                if ([newSkuPriceListDic.allKeys containsObject:kPackagedType] && ![newSkuPriceListDic[kPackagedType] isKindOfClass:[NSNull class]]) {
                                    
                                    if([newSkuPriceListDic[kPackagedType] boolValue]){
                                        minimumQty = 1;
                                        isPackedItem = true;
                                    }
                                }
                            }
                            
                            if ([newSkuPriceListDic.allKeys containsObject:kPackagedType] && ![newSkuPriceListDic[kPackagedType] isKindOfClass:[NSNull class]]) {
                                
                                [isPacked addObject:@([newSkuPriceListDic[kPackagedType] boolValue])];
                            }
                            else {
                                
                                [isPacked addObject:[NSNumber numberWithBool:FALSE]];
                            }
                            
                            [rawMaterialDetails addObject:itemDetailsDic];
                        }
                    }
                }
                else {
                    
                    BOOL isExistingItem = false;
                    NSDictionary * existItemdic;
                    int i = 0;
                    
                    for (i = 0; i < rawMaterialDetails.count; i++) {
                        
                        //reading the existing cartItem....
                        existItemdic = rawMaterialDetails[i];
                        
                        if ([[existItemdic valueForKey:ITEM_SKU] isEqualToString:[newSkuItemDic valueForKey:ITEM_SKU]] && [[existItemdic valueForKey:PLU_CODE] isEqualToString:[newSkuItemDic valueForKey:PLU_CODE]]) {
                            
                            [existItemdic setValue:[NSString stringWithFormat:@"%d",[[existItemdic valueForKey:QUANTITY] intValue] + 1] forKey:QUANTITY];
                            [existItemdic setValue:[NSString stringWithFormat:@"%d",[[existItemdic valueForKey:kApprovedQty] intValue] + 1] forKey:kApprovedQty];

                            rawMaterialDetails[i] = existItemdic;
                            isExistingItem = true;
                            break;
                        }
                        
                    }
                    
//                    if(isExistingItem) {
//
//                        [existItemdic setValue:[NSString stringWithFormat:@"%d",[[existItemdic valueForKey:QUANTITY] intValue] + 1] forKey:QUANTITY];
//
//                        [rawMaterialDetails replaceObjectAtIndex:i withObject:existItemdic];
//                    }
//                    else{
                    
                    if(! isExistingItem) {

                        NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc ]init];
                        
                        // added keys....
                        // added by roja on 06/07/2018
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:ITEM_SKU] defaultReturn:EMPTY_STRING] forKey:ITEM_SKU];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:PLU_CODE] defaultReturn:EMPTY_STRING] forKey:PLU_CODE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:ITEM_DESCRIPTION] defaultReturn:EMPTY_STRING] forKey:ITEM_DESC];
                        
                       [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:cost_Price] defaultReturn:@"0.00"] floatValue]] forKey:iTEM_PRICE];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:QUANTITY_IN_HAND] defaultReturn:@"0.00"] floatValue]] forKey:AVL_QTY];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:kPrvIndentQty] defaultReturn:@"0.00"] floatValue]] forKey:kPrvIndentQty];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:kProjectedQty] defaultReturn:@"0.00"] floatValue]] forKey:kProjectedQty];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:QUANTITY];
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:kApprovedQty];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:COLOR] defaultReturn:EMPTY_STRING] forKey:COLOR];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:MODEL] defaultReturn:EMPTY_STRING] forKey:MODEL];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:SIZE] defaultReturn:EMPTY_STRING] forKey:SIZE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:SELL_UOM] defaultReturn:EMPTY_STRING] forKey:SELL_UOM];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:PRODUCT_RANGE] defaultReturn:EMPTY_STRING] forKey:PRODUCT_RANGE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:kMeasureRange] defaultReturn:EMPTY_STRING] forKey:MEASUREMENT_RANGE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:ITEM_CATEGORY] defaultReturn:EMPTY_STRING] forKey:ITEM_CATEGORY];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:kProductBrand] defaultReturn:EMPTY_STRING] forKey:kBrand];
                        
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:QOH];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:TRACKING_REQUIRED] defaultReturn:EMPTY_STRING] forKey:TRACKING_REQUIRED];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:UTILITY] defaultReturn:EMPTY_STRING] forKey:UTILITY];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:EAN] defaultReturn:@""] forKey:EAN];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:ITEM_SKU] defaultReturn:EMPTY_STRING] forKey:kProductId];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:kSubCategory] defaultReturn:EMPTY_STRING] forKey:kSubCategory];
                        
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:ITEM_SCAN_CODE] defaultReturn:EMPTY_STRING] forKey:ITEM_SCAN_CODE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:MAKE] defaultReturn:EMPTY_STRING] forKey:MAKE];
                        
                        [rawMaterialDetails addObject:itemDetailsDic];
                    }
                }
            }
            
            float y_axis = self.view.frame.size.height - 120;
            
            if(searchItemTxt.isEditing)
                y_axis = searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height;

            NSString * mesg = [NSString stringWithFormat:@"%d%@",totalRecords,NSLocalizedString(@"records_are_added_to_the_cart", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@"CART_RECORDS" conentWidth:400 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
            
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
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getPriceListSKuDetailsErrorResponse:(NSString *)errorResponse {
    @try {
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItemTxt.isEditing)
            y_axis = searchItemTxt.frame.origin.y + searchItemTxt.frame.size.height;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@"" conentWidth:300 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [HUD setHidden:YES];
        [categoriesPopOver dismissPopoverAnimated:YES];
        
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

-(void)showPopUpForTables:(UITableView *)tableName   popUpWidth:(float)width popUpHeight:(float)height  presentPopUpAt:(id)displayFrame  showViewIn:(id)view   permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections {
    
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


/**
 * @description  here we are closing the price View...
 * @requestDteFld         27/09/2016
 * @method       closePriceView
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)closePriceView:(UIButton *)sender {
    transparentView.hidden = YES;
}


#pragma mark action need to be implented:

/**
 * @description    here we are displaying the popOver for the sumary Info...
 * @date           27/09/2016
 * @method         populatesummaryInfo
 * @author         Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)populatesummaryInfo {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    
    @try {
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
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
        
        if([checkBoxArr[sender.tag] integerValue])
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





@end




