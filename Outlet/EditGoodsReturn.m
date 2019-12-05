//
//  ReceiptGoodsProcurement.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 2/19/15.
//
//

#import "EditGoodsReturn.h"
#import "RawMaterialServiceSvc.h"
#import "StockReceiptServiceSvc.h"
#import "StockReturnServiceSvc.h"
#import "ViewGoodsReturn.h"
#import "Global.h"
#import "SkuServiceSvc.h"
#import "SupplierServiceSvc.h"
#import "purchaseOrdersSvc.h"
#import "OmniHomePage.h"
#import "GoodsReturn.h"
#import "RequestHeader.h"

@interface EditGoodsReturn ()

@end

@implementation EditGoodsReturn

@synthesize soundFileURLRef,soundFileObject;
@synthesize returnID;


/**
 * @description
 * @date
 * @method
 * @author
 * @param
 * @return
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 */
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
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
    
    //Show the HUD...
    [HUD show:YES];
    [HUD setHidden:NO];

    
    //creating the stockRequestView which will displayed completed Screen.......
    goodsReturnView = [[UIView alloc] init];
    goodsReturnView.backgroundColor = [UIColor blackColor];
    goodsReturnView.layer.borderWidth = 1.0f;
    goodsReturnView.layer.cornerRadius = 10.0f;
    goodsReturnView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
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
    UIButton * summaryInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *summaryImage = [UIImage imageNamed:@"summaryInfo.png"];
    [summaryInfoBtn setBackgroundImage:summaryImage forState:UIControlStateNormal];
    [summaryInfoBtn addTarget:self
                       action:@selector(populatesummaryInfo) forControlEvents:UIControlEventTouchDown];
    
    UILabel * fromLocLbl;
    UILabel * toLocLbl;
    UILabel * shippedOnLbl;
    UILabel * shippedByLbl;
    
    //column 1
    fromLocLbl = [[UILabel alloc] init] ;
    fromLocLbl.text = NSLocalizedString(@"fromLocation", nil);
    fromLocLbl.layer.cornerRadius = 14;
    fromLocLbl.layer.masksToBounds = YES;
    fromLocLbl.numberOfLines = 2;
    fromLocLbl.textAlignment = NSTextAlignmentLeft;
    fromLocLbl.backgroundColor = [UIColor clearColor];
    fromLocLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    toLocLbl = [[UILabel alloc] init] ;
    toLocLbl.text = NSLocalizedString(@"toLocation", nil);
    toLocLbl.layer.cornerRadius = 14;
    toLocLbl.layer.masksToBounds = YES;
    toLocLbl.numberOfLines = 2;
    toLocLbl.textAlignment = NSTextAlignmentLeft;
    toLocLbl.backgroundColor = [UIColor clearColor];
    toLocLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    shippedOnLbl = [[UILabel alloc] init] ;
    shippedOnLbl.text = NSLocalizedString(@"shipment_on", nil);
    shippedOnLbl.layer.cornerRadius = 14;
    shippedOnLbl.layer.masksToBounds = YES;
    shippedOnLbl.numberOfLines = 2;
    shippedOnLbl.textAlignment = NSTextAlignmentLeft;
    shippedOnLbl.backgroundColor = [UIColor clearColor];
    shippedOnLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    shippedByLbl = [[UILabel alloc] init] ;
    shippedByLbl.text = NSLocalizedString(@"shipped_by", nil);
    shippedByLbl.layer.cornerRadius = 14;
    shippedByLbl.layer.masksToBounds = YES;
    shippedByLbl.numberOfLines = 2;
    shippedByLbl.textAlignment = NSTextAlignmentLeft;
    shippedByLbl.backgroundColor = [UIColor clearColor];
    shippedByLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    UILabel * goodsIssueRefNoLbl;
    UILabel * dateOfRetrnLbl;
    UILabel * shipmentModeLbl;
    
    goodsIssueRefNoLbl = [[UILabel alloc] init] ;
    goodsIssueRefNoLbl.text = NSLocalizedString(@"goods_issue_ref", nil);
    goodsIssueRefNoLbl.layer.cornerRadius = 14;
    goodsIssueRefNoLbl.layer.masksToBounds = YES;
    goodsIssueRefNoLbl.numberOfLines = 2;
    goodsIssueRefNoLbl.textAlignment = NSTextAlignmentLeft;
    goodsIssueRefNoLbl.backgroundColor = [UIColor clearColor];
    goodsIssueRefNoLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    goodsIssueRefNoLbl.hidden = YES;
    
    dateOfRetrnLbl = [[UILabel alloc] init] ;
    dateOfRetrnLbl.text = NSLocalizedString(@"date_of_return", nil);
    dateOfRetrnLbl.layer.cornerRadius = 14;
    dateOfRetrnLbl.layer.masksToBounds = YES;
    dateOfRetrnLbl.numberOfLines = 2;
    dateOfRetrnLbl.textAlignment = NSTextAlignmentLeft;
    dateOfRetrnLbl.backgroundColor = [UIColor clearColor];
    dateOfRetrnLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    shipmentModeLbl = [[UILabel alloc] init] ;
    shipmentModeLbl.text = NSLocalizedString(@"shipment_mode", nil);
    shipmentModeLbl.layer.cornerRadius = 14;
    shipmentModeLbl.layer.masksToBounds = YES;
    shipmentModeLbl.numberOfLines = 2;
    shipmentModeLbl.textAlignment = NSTextAlignmentLeft;
    shipmentModeLbl.backgroundColor = [UIColor clearColor];
    shipmentModeLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    UILabel * returnByLbl;
    UILabel * goodsReceiptRefLbl;
    UILabel * timeOfReturnLbl;
    
    returnByLbl = [[UILabel alloc] init] ;
    returnByLbl.text = NSLocalizedString(@"return_by", nil);
    returnByLbl.layer.cornerRadius = 14;
    returnByLbl.layer.masksToBounds = YES;
    returnByLbl.numberOfLines = 2;
    returnByLbl.textAlignment = NSTextAlignmentLeft;
    returnByLbl.backgroundColor = [UIColor clearColor];
    returnByLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    goodsReceiptRefLbl = [[UILabel alloc] init] ;
    goodsReceiptRefLbl.text = NSLocalizedString(@"goods_receipt_ref.", nil);
    goodsReceiptRefLbl.layer.cornerRadius = 14;
    goodsReceiptRefLbl.layer.masksToBounds = YES;
    goodsReceiptRefLbl.numberOfLines = 2;
    goodsReceiptRefLbl.textAlignment = NSTextAlignmentLeft;
    goodsReceiptRefLbl.backgroundColor = [UIColor clearColor];
    goodsReceiptRefLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    timeOfReturnLbl = [[UILabel alloc] init] ;
    timeOfReturnLbl.text = NSLocalizedString(@"time_of_return", nil);
    timeOfReturnLbl.layer.cornerRadius = 14;
    timeOfReturnLbl.layer.masksToBounds = YES;
    timeOfReturnLbl.numberOfLines = 2;
    timeOfReturnLbl.textAlignment = NSTextAlignmentLeft;
    timeOfReturnLbl.backgroundColor = [UIColor clearColor];
    timeOfReturnLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    UILabel * shipmentCarrierLbl;
    UILabel * remarksLbl;
    
    shipmentCarrierLbl = [[UILabel alloc] init] ;
    shipmentCarrierLbl.text = NSLocalizedString(@"shipment_carrier", nil);
    shipmentCarrierLbl.layer.cornerRadius = 14;
    shipmentCarrierLbl.layer.masksToBounds = YES;
    shipmentCarrierLbl.numberOfLines = 2;
    shipmentCarrierLbl.textAlignment = NSTextAlignmentLeft;
    shipmentCarrierLbl.backgroundColor = [UIColor clearColor];
    shipmentCarrierLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    
    remarksLbl = [[UILabel alloc] init] ;
    remarksLbl.text = NSLocalizedString(@"remarks", nil);
    remarksLbl.layer.cornerRadius = 14;
    remarksLbl.layer.masksToBounds = YES;
    remarksLbl.numberOfLines = 1;
    remarksLbl.textAlignment = NSTextAlignmentLeft;
    remarksLbl.backgroundColor = [UIColor clearColor];
    remarksLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5 ];
    remarksLbl.hidden = YES;
    
    
    fromLocation = [[CustomTextField alloc] init];
    fromLocation.placeholder = NSLocalizedString(@"fromLocation", nil);
    fromLocation.delegate = self;
    fromLocation.userInteractionEnabled = NO;
    [fromLocation awakeFromNib];
    
    toLocation = [[CustomTextField alloc] init];
    toLocation.placeholder = NSLocalizedString(@"toLocation", nil);
    toLocation.delegate = self;
    toLocation.userInteractionEnabled = NO;
    [toLocation awakeFromNib];
    
    shipmentOn = [[CustomTextField alloc] init];
    shipmentOn.placeholder = NSLocalizedString(@"shipment_on", nil);
    shipmentOn.userInteractionEnabled = NO;
    shipmentOn.delegate = self;
    [shipmentOn awakeFromNib];
    
    UIButton * selectdateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage * deliveryImg = [UIImage imageNamed:@"Calandar_Icon.png"];
    
    [selectdateBtn setBackgroundImage:deliveryImg forState:UIControlStateNormal];
    [selectdateBtn addTarget:self
                      action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    
    selectdateBtn.tag = 1;
    
    
    
    shippedBy = [[CustomTextField alloc] init];
    shippedBy.placeholder = NSLocalizedString(@"shipped_by", nil);
    shippedBy.delegate = self;
    [shippedBy awakeFromNib];
    
    issueRefNo = [[CustomTextField alloc] init];
    issueRefNo.placeholder = NSLocalizedString(@"issue_reference_no.", nil);
    issueRefNo.delegate = self;
    issueRefNo.userInteractionEnabled = NO;
    issueRefNo.hidden = YES;
    [issueRefNo awakeFromNib];
    
    dateOfReturn = [[CustomTextField alloc] init];
    dateOfReturn.userInteractionEnabled = NO;
    dateOfReturn.delegate = self;
    [dateOfReturn awakeFromNib];
    
    
    UIButton * selctDateOfReturnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [selctDateOfReturnBtn setBackgroundImage:deliveryImg forState:UIControlStateNormal];
    [selctDateOfReturnBtn addTarget:self
                             action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    
    selctDateOfReturnBtn.tag = 2;
    
    shipmentMode = [[CustomTextField alloc] init];
    shipmentMode.placeholder = NSLocalizedString(@"shipment_mode", nil);
    shipmentMode.delegate = self;
    shipmentMode.userInteractionEnabled = NO;
    [shipmentMode awakeFromNib];
    
    UIButton * shipmentModeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *shipModeImg = [UIImage imageNamed:@"arrow_1.png"];
    [shipmentModeBtn setBackgroundImage:shipModeImg forState:UIControlStateNormal];
    [shipmentModeBtn addTarget:self action:@selector(getShipmentModes:) forControlEvents:UIControlEventTouchUpInside];
    
    returnedBy = [[CustomTextField alloc] init];
    returnedBy.placeholder = NSLocalizedString(@"returned_by", nil);
    returnedBy.delegate = self;
    [returnedBy awakeFromNib];
    
    receiptRef = [[CustomTextField alloc] init];
    receiptRef.placeholder = NSLocalizedString(@"receipt_ref_no.", nil);
    receiptRef.clearButtonMode = UITextFieldViewModeWhileEditing;
    receiptRef.autocorrectionType = UITextAutocorrectionTypeNo;
    receiptRef.delegate = self;
    [receiptRef addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [receiptRef awakeFromNib];
    
    timeOfReturn = [[CustomTextField alloc] init];
    timeOfReturn.delegate = self;
    timeOfReturn.userInteractionEnabled = NO;
    [timeOfReturn awakeFromNib];
    
    shipmentCarrier = [[CustomTextField alloc] init];
    shipmentCarrier.placeholder = NSLocalizedString(@"shipment_carrier", nil);
    shipmentCarrier.delegate = self;
    [shipmentCarrier awakeFromNib];
    
    remarks = [[UITextView alloc] init];
    remarks.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;;
    remarks.layer.borderWidth = 1.5;
    remarks.font = [UIFont systemFontOfSize:18.0];
    remarks.backgroundColor = [UIColor clearColor];
    remarks.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    remarks.textAlignment= NSTextAlignmentLeft;
    remarks.text = NSLocalizedString(@"remarks", nil);
    remarks.delegate = self;
    remarks.autocorrectionType = UITextAutocorrectionTypeNo;
    remarks.hidden = YES;
    
    actionReqTxt = [[CustomTextField alloc] init];
    actionReqTxt.placeholder = NSLocalizedString(@"action_required", nil);
    UIImage *actionImg = [UIImage imageNamed:@"arrow_1.png"];
    
    actionReqTxt.delegate = self;
    [actionReqTxt awakeFromNib];
    
    UIButton * actionbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [actionbtn setBackgroundImage:actionImg forState:UIControlStateNormal];
    [actionbtn addTarget:self action:@selector(showNextAcivities:) forControlEvents:UIControlEventTouchUpInside];
    
    //allocating work Flow view for the next activities.
    
    workFlowView = [[UIView alloc] init];
//    workFlowView.backgroundColor = [UIColor lightGrayColor];

    searchItem = [[UITextField alloc] init];
    searchItem.placeholder = NSLocalizedString(@"Search_Sku_Here", nil);
    searchItem.delegate = self;
    [searchItem awakeFromNib];
    searchItem.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchItem.autocorrectionType = UITextAutocorrectionTypeNo;
    searchItem.borderStyle = UITextBorderStyleRoundedRect;
    searchItem.textColor = [UIColor blackColor];
    searchItem.layer.borderColor = [UIColor clearColor].CGColor;
    searchItem.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    searchItem.font = [UIFont fontWithName:TEXT_FONT_NAME size:22];
    [searchItem addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIImage * productListImg  = [UIImage imageNamed:@"btn_list.png"];
    
     selectCategoriesBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [selectCategoriesBtn setBackgroundImage:productListImg forState:UIControlStateNormal];
    [selectCategoriesBtn addTarget:self
                            action:@selector(validatingCategoriesList:) forControlEvents:UIControlEventTouchDown];

    stockReturnScrollView = [[UIScrollView alloc]init];
    //stockReturnScrollView.backgroundColor = [UIColor lightGrayColor];
    
    /*creation of UILable's*/
    sNoLbl  = [[CustomLabel alloc] init];
    [sNoLbl awakeFromNib];
    
    sKuidLbl  = [[CustomLabel alloc] init];
    [sKuidLbl awakeFromNib];
    
    descLbl  = [[CustomLabel alloc] init];
    [descLbl awakeFromNib];
    
    eanLbl  = [[CustomLabel alloc] init];
    [eanLbl awakeFromNib];
    
    uomLbl  = [[CustomLabel alloc] init];
    [uomLbl awakeFromNib];
    
    avlQtyLbl  = [[CustomLabel alloc] init];
    [avlQtyLbl awakeFromNib];
    
    priceLbl  = [[CustomLabel alloc] init];
    [priceLbl awakeFromNib];
    
    returnQtyLbl  = [[CustomLabel alloc] init];
    [returnQtyLbl awakeFromNib];
    
    valueLbl  = [[CustomLabel alloc] init];
    [valueLbl awakeFromNib];
    
    reasonLbl  = [[CustomLabel alloc] init];
    [reasonLbl awakeFromNib];
    
    actionLbl  = [[CustomLabel alloc] init];
    [actionLbl awakeFromNib];
    
    // added by roja
    batchNo = [[CustomLabel alloc] init];
    [batchNo awakeFromNib];
    
    expiryDate = [[CustomLabel alloc] init];
    [expiryDate awakeFromNib];
    
    scanCode = [[CustomLabel alloc] init];
    [scanCode awakeFromNib];
    
    
    submitBtn = [[UIButton alloc] init] ;
    submitBtn.backgroundColor = [UIColor grayColor];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 5.0f;
    [submitBtn addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchDown];
    submitBtn.tag = 2;
    
    
    cancelButton = [[UIButton alloc] init];
    [cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchDown];
    cancelButton.layer.cornerRadius = 3.0f;
    cancelButton.backgroundColor = [UIColor grayColor];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelButton.tag = 4;
    
    submitBtn.userInteractionEnabled = YES;
    cancelButton.userInteractionEnabled = YES;
    
    skListTable = [[UITableView alloc] init];
    
    // Table for storing the items ..
    cartTable = [[UITableView alloc] init];
    cartTable.backgroundColor = [UIColor clearColor];
    cartTable.dataSource = self;
    cartTable.delegate = self;
    cartTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    cartTable.userInteractionEnabled = TRUE;
    
    //Added By Bhargav on 25/10/2017...To Display the  total values of quantities in cart...
    
    returnQtyValueLbl = [[UILabel alloc] init];
    returnQtyValueLbl.layer.cornerRadius = 5;
    returnQtyValueLbl.layer.masksToBounds = YES;
    returnQtyValueLbl.backgroundColor = [UIColor blackColor];
    returnQtyValueLbl.layer.borderWidth = 2.0f;
    returnQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    returnQtyValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    returnQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    totalvalueLbl = [[UILabel alloc] init];
    totalvalueLbl.layer.cornerRadius = 5;
    totalvalueLbl.layer.masksToBounds = YES;
    totalvalueLbl.backgroundColor = [UIColor blackColor];
    totalvalueLbl.layer.borderWidth = 2.0f;
    totalvalueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
    totalvalueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
    totalvalueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    returnQtyValueLbl.textAlignment = NSTextAlignmentCenter;
    totalvalueLbl.textAlignment = NSTextAlignmentCenter;
    
    returnQtyValueLbl.text = @"0.00";
    totalvalueLbl.text     = @"0.00";

    //creation of price view..
    
    //creation of price view..
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
    priceView.layer.borderColor = [UIColor whiteColor].CGColor;
    priceView.layer.borderWidth = 1.0;
    
    transparentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    transparentView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6f];
    transparentView.hidden = YES;
    
    descLabl = [[CustomLabel alloc]init];
    [descLabl awakeFromNib];
    
    mrpLbl = [[CustomLabel alloc]init];
    [mrpLbl awakeFromNib];
    
    priceLabl = [[CustomLabel alloc]init];
    [priceLabl awakeFromNib];

    @try {
        //setting the titleName for the Page....
        self.titleLabel.text = NSLocalizedString(@"omni_retailer", nil);
        
        HUD.labelText = NSLocalizedString(@"please_wait..", nil);
        
        headerNameLbl.text = NSLocalizedString(@"edit_stock_return",nil);
        
        sNoLbl.text = NSLocalizedString(@"S_NO", nil);
        sKuidLbl.text = NSLocalizedString(@"sku_id", nil);
        descLbl.text = NSLocalizedString(@"item_desc", nil);
        eanLbl.text = NSLocalizedString(@"ean", nil);
        uomLbl.text = NSLocalizedString(@"uom", nil);
        avlQtyLbl.text = NSLocalizedString(@"avl_qty", nil);
        priceLbl.text = NSLocalizedString(@"price", nil);
        returnQtyLbl.text = NSLocalizedString(@"return_qty", nil);
        valueLbl.text = NSLocalizedString(@"value", nil);
        reasonLbl.text = NSLocalizedString(@"reason", nil);
        actionLbl.text = NSLocalizedString(@"action", nil);
        
        // added by roja
        batchNo.text = NSLocalizedString(@"batch_no", nil);
        expiryDate.text = NSLocalizedString(@"expiry_date", nil);
        scanCode.text = NSLocalizedString(@"scan_code", nil);
        
        //priceList Labels...
        descLabl.text = NSLocalizedString(@"description", nil);
        mrpLbl.text = NSLocalizedString(@"mrp_rps", nil);
        priceLabl.text = NSLocalizedString(@"price", nil);

        [submitBtn setTitle:NSLocalizedString(@"edit",nil) forState:UIControlStateNormal];
        
        [cancelButton setTitle:NSLocalizedString(@"cancel",nil) forState:UIControlStateNormal];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    
    
    
    if (currentOrientation==UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            //setting frame for the main view..
            goodsReturnView.frame = CGRectMake(2,70, self.view.frame.size.width - 4, self.view.frame.size.height - 80);
            
            //setting frame for the headerNameLbl..
            headerNameLbl.frame = CGRectMake( 0, 0, goodsReturnView.frame.size.width, 45);
            
            //setting below labe's frame.......
            float labelWidth =  180;
            float labelHeight = 40;
            
            float textFieldWidth =  180;
            float textFieldHeight = 40;
            float horizontalWidth = 25;
            
            //first Column.......
            fromLocLbl.frame =  CGRectMake(10, headerNameLbl.frame.origin.y+headerNameLbl.frame.size.height,labelWidth, labelHeight);
            fromLocation.frame = CGRectMake(fromLocLbl.frame.origin.x,fromLocLbl.frame.origin.y + fromLocLbl.frame.size.height-10,textFieldWidth,textFieldHeight);
            
            
            toLocLbl.frame = CGRectMake(fromLocLbl.frame.origin.x+fromLocLbl.frame.size.width+horizontalWidth, fromLocLbl.frame.origin.y, labelWidth, labelHeight);
            toLocation.frame =  CGRectMake( toLocLbl.frame.origin.x,fromLocation.frame.origin.y, textFieldWidth, textFieldHeight);
            
            shippedOnLbl.frame = CGRectMake(toLocLbl.frame.origin.x+toLocLbl.frame.size.width+horizontalWidth, fromLocLbl.frame.origin.y, labelWidth, labelHeight);
            
            shipmentOn.frame =  CGRectMake(shippedOnLbl.frame.origin.x,fromLocation.frame.origin.y, textFieldWidth, textFieldHeight);
            selectdateBtn.frame = CGRectMake((shipmentOn.frame.origin.x+shipmentOn.frame.size.width-45), shipmentOn.frame.origin.y+2, 40, 35);
            
            shippedByLbl.frame = CGRectMake(shippedOnLbl.frame.origin.x+shippedOnLbl.frame.size.width+horizontalWidth, fromLocLbl.frame.origin.y, labelWidth, labelHeight);
            
            shippedBy.frame =  CGRectMake(shippedByLbl.frame.origin.x,fromLocation.frame.origin.y, textFieldWidth, textFieldHeight);
            
            
            returnByLbl.frame = CGRectMake(shippedByLbl.frame.origin.x+shippedByLbl.frame.size.width+horizontalWidth, fromLocLbl.frame.origin.y, labelWidth, labelHeight);
            
            returnedBy.frame =  CGRectMake(returnByLbl.frame.origin.x,shippedBy.frame.origin.y, textFieldWidth, textFieldHeight);
            
            //column 2
            
            goodsReceiptRefLbl.frame = CGRectMake(fromLocLbl.frame.origin.x, fromLocation.frame.origin.y+fromLocation.frame.size.height+5, labelWidth, labelHeight);
            
            receiptRef.frame =  CGRectMake(goodsReceiptRefLbl.frame.origin.x,goodsReceiptRefLbl.frame.origin.y+goodsReceiptRefLbl.frame.size.height-10, textFieldWidth, textFieldHeight);
            
            dateOfRetrnLbl.frame = CGRectMake(toLocation.frame.origin.x, goodsReceiptRefLbl.frame.origin.y, labelWidth, labelHeight);
            
            dateOfReturn.frame =  CGRectMake(dateOfRetrnLbl.frame.origin.x,receiptRef.frame.origin.y, textFieldWidth, textFieldHeight);
            
            selctDateOfReturnBtn.frame = CGRectMake((dateOfReturn.frame.origin.x+dateOfReturn.frame.size.width-45), dateOfReturn.frame.origin.y+2, 40, 35);
            
            timeOfReturnLbl.frame = CGRectMake(shippedOnLbl.frame.origin.x, dateOfRetrnLbl.frame.origin.y, labelWidth, labelHeight);
            
            timeOfReturn.frame =  CGRectMake(timeOfReturnLbl.frame.origin.x,dateOfReturn.frame.origin.y, textFieldWidth, textFieldHeight);
            
            shipmentModeLbl.frame = CGRectMake(shippedByLbl.frame.origin.x, dateOfRetrnLbl.frame.origin.y, labelWidth, labelHeight);
            
            shipmentMode.frame =  CGRectMake(shipmentModeLbl.frame.origin.x,dateOfReturn.frame.origin.y, textFieldWidth, textFieldHeight);
            
            shipmentModeBtn.frame = CGRectMake((shipmentMode.frame.origin.x+shipmentMode.frame.size.width-45), shipmentMode.frame.origin.y-8, 55, 60);
            
            shipmentCarrierLbl.frame = CGRectMake(returnByLbl.frame.origin.x, shipmentModeLbl.frame.origin.y, labelWidth, labelHeight);
            
            shipmentCarrier.frame =  CGRectMake(shipmentCarrierLbl.frame.origin.x,shipmentMode.frame.origin.y, textFieldWidth, textFieldHeight);
            
            //goodsIssueRefNoLbl.frame = CGRectMake(fromLocation.frame.origin.x, fromLocation.frame.origin.y+fromLocation.frame.size.height+5, labelWidth, labelHeight);
            //issueRefNo.frame =  CGRectMake(goodsIssueRefNoLbl.frame.origin.x,goodsIssueRefNoLbl.frame.origin.y+goodsIssueRefNoLbl.frame.size.height-10, textFieldWidth, textFieldHeight);

            actionReqTxt.frame =  CGRectMake(shipmentCarrier.frame.origin.x,shipmentCarrier.frame.origin.y+shipmentCarrier.frame.size.height+5, textFieldWidth, textFieldHeight);
           
            actionbtn.frame = CGRectMake((actionReqTxt.frame.origin.x+actionReqTxt.frame.size.width-45), actionReqTxt.frame.origin.y-8, 55, 60);

            workFlowView.frame = CGRectMake(0, receiptRef.frame.origin.y+receiptRef.frame.size.height+5, actionReqTxt.frame.origin.x  - (receiptRef.frame.origin.x) , textFieldHeight);
            
            searchItem.frame = CGRectMake(receiptRef.frame.origin.x, workFlowView.frame.origin.y+workFlowView.frame.size.height+5, actionReqTxt.frame.origin.x+actionReqTxt.frame.size.width-(receiptRef.frame.origin.x+80), textFieldHeight);
            
            selectCategoriesBtn.frame = CGRectMake((searchItem.frame.origin.x+searchItem.frame.size.width + 5),searchItem.frame.origin.y,75,searchItem.frame.size.height);
            
            //Frame for the StockReturnScrollView....
            stockReturnScrollView.frame = CGRectMake(searchItem.frame.origin.x,searchItem.frame.origin.y + searchItem.frame.size.height +5,searchItem.frame.size.width+150,350);
            
            //Frame for the CustomLabels
            sNoLbl.frame = CGRectMake(0,0, 50, 35);
            
            sKuidLbl.frame = CGRectMake((sNoLbl.frame.origin.x + sNoLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 100, sNoLbl.frame.size.height);
            
            descLbl.frame = CGRectMake((sKuidLbl.frame.origin.x + sKuidLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 140, sNoLbl.frame.size.height);
            
            eanLbl.frame = CGRectMake((descLbl.frame.origin.x + descLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 100, sNoLbl.frame.size.height);
            
            uomLbl.frame = CGRectMake((eanLbl.frame.origin.x + eanLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 80, sNoLbl.frame.size.height);
            
            avlQtyLbl.frame = CGRectMake((uomLbl.frame.origin.x + uomLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 80, sNoLbl.frame.size.height);
            
            priceLbl.frame = CGRectMake((avlQtyLbl.frame.origin.x + avlQtyLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 70, sNoLbl.frame.size.height);
            
            returnQtyLbl.frame = CGRectMake((priceLbl.frame.origin.x + priceLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 90, sNoLbl.frame.size.height);
            
            valueLbl.frame = CGRectMake((returnQtyLbl.frame.origin.x + returnQtyLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 80, sNoLbl.frame.size.height);
            
            reasonLbl.frame = CGRectMake((valueLbl.frame.origin.x + valueLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 135, sNoLbl.frame.size.height);
            
            // added by roja on 23-07-2018...
            batchNo.frame = CGRectMake ((reasonLbl.frame.origin.x + reasonLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 130, 35);
            
            expiryDate.frame = CGRectMake ((batchNo.frame.origin.x + batchNo.frame.size.width + 2), sNoLbl.frame.origin.y, 130, 35);
            
            scanCode.frame = CGRectMake ((expiryDate.frame.origin.x + expiryDate.frame.size.width + 2), sNoLbl.frame.origin.y, 130, 35);
            
            actionLbl.frame = CGRectMake((scanCode.frame.origin.x + scanCode.frame.size.width + 2), sNoLbl.frame.origin.y, 55, 35);
            
            cartTable.frame = CGRectMake(0,sNoLbl.frame.origin.y+sNoLbl.frame.size.height + 5,actionLbl.frame.origin.x+actionLbl.frame.size.width + 120 -(sNoLbl.frame.origin.x),stockReturnScrollView.frame.size.height-(sNoLbl.frame.origin.y+sNoLbl.frame.size.height));

            stockReturnScrollView.contentSize = CGSizeMake(cartTable.frame.size.width,  stockReturnScrollView.frame.size.height);
            
            // upto here changed by roja on 23-07-2018..
            

            submitBtn.frame = CGRectMake(searchItem.frame.origin.x,goodsReturnView.frame.size.height-45,140, 40);
            
            cancelButton.frame = CGRectMake(submitBtn.frame.origin.x+submitBtn.frame.size.width+30,submitBtn.frame.origin.y,140,40);
            
            returnQtyValueLbl.frame = CGRectMake(returnQtyLbl.frame.origin.x+5,submitBtn.frame.origin.y, returnQtyLbl.frame.size.width,returnQtyLbl.frame.size.height);
            
            totalvalueLbl.frame = CGRectMake(valueLbl.frame.origin.x+5,submitBtn.frame.origin.y, valueLbl.frame.size.width+5,valueLbl.frame.size.height);
            
            //frame for the Transparent view:
            
            transparentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            
            priceView.frame = CGRectMake(200, 400, 490,300);
            
            descLabl.frame = CGRectMake(0,5,180, 35);
            mrpLbl.frame = CGRectMake(descLabl.frame.origin.x+descLabl.frame.size.width+2,descLabl.frame.origin.y, 150, 35);
            priceLabl.frame = CGRectMake(mrpLbl.frame.origin.x+mrpLbl.frame.size.width+2, descLabl.frame.origin.y, 150, 35);
            
            priceTable.frame = CGRectMake(descLabl.frame.origin.x,descLabl.frame.origin.y+descLabl.frame.size.height+5, priceLabl.frame.origin.x+priceLabl.frame.size.width - (descLabl.frame.origin.x), priceView.frame.size.height - (descLabl.frame.origin.y + descLabl.frame.size.height+20));
            
            closeBtn.frame = CGRectMake(priceView.frame.size.width+165, priceView.frame.origin.y-38, 40, 40);
        }
    }
    
    [goodsReturnView addSubview:headerNameLbl];
    
    [goodsReturnView addSubview:fromLocLbl];
    [goodsReturnView addSubview:toLocLbl];
    [goodsReturnView addSubview:shippedOnLbl];
    [goodsReturnView addSubview:shippedByLbl];
    [goodsReturnView addSubview:returnByLbl];
    [goodsReturnView addSubview:goodsIssueRefNoLbl];
    [goodsReturnView addSubview:dateOfRetrnLbl];
    [goodsReturnView addSubview:timeOfReturnLbl];
    [goodsReturnView addSubview:shipmentModeLbl];
    [goodsReturnView addSubview:shipmentCarrierLbl];
    [goodsReturnView addSubview:goodsReceiptRefLbl];
    [goodsReturnView addSubview:remarksLbl];

    [goodsReturnView addSubview:fromLocation];
    [goodsReturnView addSubview:toLocation];
    [goodsReturnView addSubview:shipmentOn];
    [goodsReturnView addSubview:shippedBy];
    [goodsReturnView addSubview:returnedBy];
    [goodsReturnView addSubview:issueRefNo];
    [goodsReturnView addSubview:dateOfReturn];
    [goodsReturnView addSubview:timeOfReturn];
    [goodsReturnView addSubview:shipmentMode];
    [goodsReturnView addSubview:shipmentCarrier];
    [goodsReturnView addSubview:receiptRef];
    [goodsReturnView addSubview:remarks];
    [goodsReturnView addSubview:actionReqTxt];

    [goodsReturnView addSubview:selectdateBtn];
    [goodsReturnView addSubview:shipmentModeBtn];
    [goodsReturnView addSubview:selctDateOfReturnBtn];
    [goodsReturnView addSubview:actionbtn];

    [goodsReturnView addSubview:workFlowView];
    [goodsReturnView addSubview:searchItem];
    [goodsReturnView addSubview:selectCategoriesBtn];
    
    [goodsReturnView addSubview:stockReturnScrollView];
    
    [stockReturnScrollView addSubview:sNoLbl];
    [stockReturnScrollView addSubview:sKuidLbl];
    [stockReturnScrollView addSubview:descLbl];
    [stockReturnScrollView addSubview:eanLbl];
    [stockReturnScrollView addSubview:uomLbl];
    [stockReturnScrollView addSubview:avlQtyLbl];
    [stockReturnScrollView addSubview:priceLbl];
    [stockReturnScrollView addSubview:returnQtyLbl];
    [stockReturnScrollView addSubview:valueLbl];
    [stockReturnScrollView addSubview:reasonLbl];
    [stockReturnScrollView addSubview:actionLbl];
    // added by roja on 23-07-2018...
    [stockReturnScrollView addSubview:batchNo];
    [stockReturnScrollView addSubview:expiryDate];
    [stockReturnScrollView addSubview:scanCode];
    
    [stockReturnScrollView addSubview:cartTable];
    
    [goodsReturnView addSubview:submitBtn];
    [goodsReturnView addSubview:cancelButton];
    
    [goodsReturnView addSubview:returnQtyValueLbl];
    [goodsReturnView addSubview:totalvalueLbl];
    
    //adding price list view for the Stock Return View...
    
    [priceView addSubview:descLabl];
    [priceView addSubview:mrpLbl];
    [priceView addSubview:priceLabl];
    
    [priceView addSubview:priceTable];
    
    [transparentView addSubview:closeBtn];
    
    [transparentView addSubview:priceView];
    
    [self.view addSubview:goodsReturnView];
    [self.view addSubview:transparentView];

    [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:16.0f cornerRadius:3.0f];
    headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
    
    submitBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
    cancelButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];

    @try {
        for (id view in goodsReturnView.subviews) {
            [view setUserInteractionEnabled:NO];
        }
        
        submitBtn.userInteractionEnabled =YES;
        cancelButton.userInteractionEnabled = YES;
        stockReturnScrollView.userInteractionEnabled = YES;
    }
    @catch (NSException *exception) {
        
    }
}

/**
 * @description
 * @date
 * @method
 * @author
 * @param
 * @return
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 *
 */

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    @try {
        
        [HUD setHidden:NO];
        
        rawMaterialDetails = [NSMutableArray new];

        [self callingGetStockReturn];
    }
    @catch (NSException * exception) {
        
    }
    @finally {
        
    }
}


#pragma mark Methods..

/**
 * @description
 * @date
 * @method
 * @author
 * @param
 * @return
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 *
 */

-(void)callingGetStockReturn {
    @try {
        
        [HUD setHidden:NO];
        
        
        NSMutableDictionary * stockReturn = [[NSMutableDictionary alloc] init];
        stockReturn[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        stockReturn[kReturnNoteRef] = returnID;
        stockReturn[LOCATIONS] = presentLocation;

        stockReturn[START_INDEX] = [NSString stringWithFormat:@"%d",startIndexint];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:stockReturn options:0 error:&err];
        NSString * quoteRequestJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.stockReturnDelegate = self;
        [webServiceController getStockReturn:quoteRequestJsonString];
        
    }
    @catch (NSException *exception) {
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2  verticalAxis:y_axis   msgType:@"" conentWidth:300 contentHeight:40  isSoundRequired:YES timing:3.0 noOfLines:1];
        
    }
    @finally {
        
    }
}

/**
 * @description    calling the products
 * @requestDteFld  06/10/2016
 * @method         callRawMaterials
 * @author         Bhargav
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void) callRawMaterials:(NSString *)searchString {
    
    @try {
        [HUD show:YES];
        [HUD setHidden:NO];
        
        //productList  =[NSMutableArray new];
        
        NSMutableDictionary * searchProductDic = [[NSMutableDictionary alloc] init];
        
        searchProductDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        searchProductDic[START_INDEX] = @"0";
        searchProductDic[kSearchCriteria] = searchString;
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
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2  verticalAxis:y_axis   msgType:@"" conentWidth:300 contentHeight:40  isSoundRequired:YES timing:3.0 noOfLines:1];
        
    }
    
}

/**
 * @description  calling the products
 * @requestDteFld         06/10/2016
 * @method       callRawMaterialsDetails.
 * @author       Bhargav
 * @param         Skuid
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
        
        //getSkuid.skuID = salesReportJsonString;
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.getSkuDetailsDelegate = self;
        [webServiceController getSkuDetailsWithData:salesReportJsonString];
        
    }
    @catch (NSException *exception) {
        
        [HUD setHidden: YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2  verticalAxis:y_axis  msgType:@"" conentWidth:300 contentHeight: 40 isSoundRequired:YES timing:2.0 noOfLines:1];
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
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timing:2.0 noOfLines:2];
        
        NSLog(@"---- exception while calling callingCategories List ServicesCall ----%@",exception);
        
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
                
                [self displayAlertMessage:NSLocalizedString(@"please_select_atleast_one_category",nil) horizontialAxis:submitBtn.frame.origin.x + submitBtn.frame.size.width+ 10 verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil) conentWidth:260 contentHeight:100  isSoundRequired:YES timing:3.0 noOfLines:1];
                
                
                return;
            }
            
            //Recently Added By Bhargav.v on 26/10/2017....
            if (rawMaterialDetails.count) {
                
                [rawMaterialDetails removeAllObjects];
            }
            //up to here By Bhargav.v on 26/10/2017....
        }
        @try {
            [HUD show:YES];
            [HUD setHidden:NO];
            NSMutableDictionary * priceListDic = [[NSMutableDictionary alloc]init];
            
            priceListDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
            priceListDic[START_INDEX] = NEGATIVE_ONE;
            priceListDic[CATEGORY_LIST] = catArr;
            priceListDic[kRequiredRecords] = @"0";
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
            
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2  verticalAxis:y_axis  msgType:@"" conentWidth:300 contentHeight: 40 isSoundRequired:YES timing:2.0 noOfLines:1];
        }
        
    } @catch (NSException * exception) {
        
    } @finally {
        
    }
}

/**
 * @description
 * @date
 * @method
 * @author
 * @param
 *
 * @return
 *
 * @modified By Srinivasulu on 02/05/2018..
 * @reason      added the exception handling
 *
 * @verified By
 * @verified On
 *
 */

-(void)submitButtonPressed:(UIButton*) sender {
    
    //Play Audio for Button Touch.....
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        Boolean isZeroQty = false;
        // added by roja
        for(NSDictionary *dic in rawMaterialDetails ) {
            
            if([[dic valueForKey:QUANTITY] floatValue] <= 0){
                
                isZeroQty = true;
            }
        }
        
        if([sender.titleLabel.text isEqualToString:NSLocalizedString(@"edit", nil)] ){
            
            @try {
                
                for (id view in goodsReturnView.subviews) {
                    [view setUserInteractionEnabled:YES];
                }
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                [cartTable reloadData];
            }
            
            [submitBtn setTitle:NSLocalizedString(@"update", nil) forState:UIControlStateNormal];
        }
        
        // added by roja on 24-07-2018...
        
        else if(!rawMaterialDetails.count){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"alert" message:NSLocalizedString(@"you_cannot_update_an_empty_list", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (isZeroQty && submitBtn.tag == 2){

            conformationAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"please_verify_zeroQty_items_are_available", nil)  message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"CONTINUE", nil) otherButtonTitles:NSLocalizedString(@"no", nil), nil];
            conformationAlert.tag = 1;
            [conformationAlert show];
        }
        else if (!isZeroQty && submitBtn.tag == 2){

            if ( (actionReqTxt.text).length > 0 ) {
                
                conformationAlert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Indent will be %@",actionReqTxt.text ]  message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"yes", nil) otherButtonTitles:NSLocalizedString(@"no", nil), nil];
                conformationAlert.tag = 1;
                [conformationAlert show];
            }
            else {
                conformationAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"do_you_want_to_update_this_indent", nil)  message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"yes", nil) otherButtonTitles:NSLocalizedString(@"no", nil), nil];
                conformationAlert.tag = 1;
                [conformationAlert show];
            }
        }
        // upto here on 24-07-2018 by roja
        
        else {
            //changed By srinivauslu on 02/05/2018....
            //reason.. Need to stop user internation after servcie calls...
            
            submitBtn.userInteractionEnabled = NO;

            //upto here on 02/05/2018....
            
            [HUD setHidden:NO];
            NSString *updateStatuStr = [updateStockReturnDic  valueForKey:STATUS];
            
            if(![actionReqTxt.text isEqualToString:@""] && (actionReqTxt.text).length >0){
                updateStatuStr = actionReqTxt.text;
            }
            updateStockReturnDic[STATUS] = updateStatuStr;
            updateStockReturnDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
            
            NSMutableArray * locArr = [NSMutableArray new];
            
            locArr = [rawMaterialDetails copy];
            
            updateStockReturnDic[STOCK_LIST] = locArr;
            updateStockReturnDic[kShipmentMode] = shipmentMode.text;
            [updateStockReturnDic setValue:shipmentCarrier.text forKey:kShipmentCarrier];
            [updateStockReturnDic setValue:shippedBy.text forKey:KShippedBy];
            [updateStockReturnDic setValue:firstName forKey:kUserName];
            
            
            NSString * timeOfReturnStr = timeOfReturn.text;
            if (timeOfReturnStr.length > 0) {
                timeOfReturnStr = [NSString stringWithFormat:@"%@%@",timeOfReturn.text,@" HH:mm:ss"];
            }
            [updateStockReturnDic setValue:timeOfReturnStr forKey:kTimeOfReturnStr];
            
            NSString * dateOfReturnStr = dateOfReturn.text ;
            if(dateOfReturnStr.length > 0) {
                dateOfReturnStr = [NSString stringWithFormat:@"%@%@",dateOfReturn.text,@" 00:00:00"];
            }
            updateStockReturnDic[kDateOfReturn] = dateOfReturnStr;
            
            NSString * shippedOnStr = shipmentOn.text;
            if (shippedOnStr.length> 0) {
                shippedOnStr = [NSString stringWithFormat:@"%@%@",shipmentOn.text,@" 00:00:00"];
            }
            updateStockReturnDic[kShippedOnStr] = shippedOnStr;;
            
            if ([updateStockReturnDic.allKeys containsObject:DATE_OF_RETURN] && ![[updateStockReturnDic valueForKey:DATE_OF_RETURN] isKindOfClass:[NSNull class]]) {
            
            [updateStockReturnDic removeObjectForKey:DATE_OF_RETURN];
            }
            
            if ([updateStockReturnDic.allKeys containsObject:TIME_OF_RETURN] && ![[updateStockReturnDic valueForKey:TIME_OF_RETURN] isKindOfClass:[NSNull class]]) {
            
            [updateStockReturnDic removeObjectForKey:TIME_OF_RETURN];
            }
            
            // keys added by roja on 20-07-2018...
            [updateStockReturnDic setValue:roleName forKey:kRoleName];
            [updateStockReturnDic setValue:fromLocation.text forKey:kFromLocation];
            [updateStockReturnDic setValue:toLocation.text forKey:kToLocation];
            [updateStockReturnDic setValue:returnedBy.text forKey:kReturnBy];
            [updateStockReturnDic setValue:EMPTY_STRING forKey:REMARKS];
            
            if((issueRefNo.text).length > 0){
                updateStockReturnDic[ISSUE_REF] = issueRefNo.text;
            }
            else {
                updateStockReturnDic[ISSUE_REF] = EMPTY_STRING;
                
            }
            if((receiptRef.text).length > 0){
                updateStockReturnDic[kReceiptRef] = receiptRef.text;
            }
            else {
                updateStockReturnDic[kReceiptRef] = EMPTY_STRING;
            }
            
            NSError * err;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:updateStockReturnDic options:0 error:&err];
            NSString * updateStockReturnJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"---%@",updateStockReturnJsonString);
            
            WebServiceController * webServiceController = [WebServiceController new];
            webServiceController.stockReturnDelegate = self;
            [webServiceController upDateStockReturn:jsonData];
        }
        
    }
    @catch (NSException *exception) {
        //changed By srinivauslu on 02/05/2018....
        //reason.. Need to stop user internation after servcie calls...

        [HUD setHidden:YES];
        submitBtn.userInteractionEnabled = YES;
        
        //upto here on 02/05/2018....
    }
    @finally {
        
    }
}



/**
 * @description
 * @date         24/07/2018
 * @method       didDismissWithButtonIndex:
 * @author       Roja
 * @param        UIAlertView
 * @param        NSInteger
 * @return       void
 * @verified By
 * @verified On
 *
 */
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    
    if (alertView == conformationAlert) {
        
        if (buttonIndex == 0) {
            
            submitBtn.tag = conformationAlert.tag;
            [self submitButtonPressed:submitBtn];
        }
        else {
            
            submitBtn.tag = 2;
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        }
    }
}



#pragma mark Handling Response Methods
/**
 * @description
 * @date
 * @method
 * @author
 * @param
 * @return
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 *
 */

-(void)getStockReturnSuccessResponse:(NSDictionary *)successDictionary {
    @try {
        
        NSLog(@"%@--- available Records",successDictionary);
        
        updateStockReturnDic  = [[NSMutableDictionary alloc]init];
        nextActivitiesArr = [NSMutableArray new];
        updateStockReturnDic = [[successDictionary valueForKey:STOCK_RETURN_LIST][0]mutableCopy];
        
        fromLocation.text = [self checkGivenValueIsNullOrNil:[updateStockReturnDic valueForKey:kFromLocation] defaultReturn:@""];
        
        toLocation .text = [self checkGivenValueIsNullOrNil:[updateStockReturnDic valueForKey:kToLocation] defaultReturn:@""];
        
        shipmentOn .text = [self checkGivenValueIsNullOrNil:[updateStockReturnDic valueForKey:kShippedOnStr] defaultReturn:@""];
        
        shippedBy .text = [self checkGivenValueIsNullOrNil:[updateStockReturnDic valueForKey:KShippedBy] defaultReturn:@""];
        
        issueRefNo .text = [self checkGivenValueIsNullOrNil:[updateStockReturnDic valueForKey:ISSUE_REF] defaultReturn:@""];
        
        dateOfReturn .text = [self checkGivenValueIsNullOrNil:[updateStockReturnDic valueForKey:kDateOfReturn] defaultReturn:@""];
        
        shipmentMode .text = [self checkGivenValueIsNullOrNil:[updateStockReturnDic valueForKey:kShipmentMode] defaultReturn:@""];
        
        returnedBy .text = [self checkGivenValueIsNullOrNil:[updateStockReturnDic valueForKey:kReturnBy] defaultReturn:@""];
        
        receiptRef .text = [self checkGivenValueIsNullOrNil:[updateStockReturnDic valueForKey:kReceiptRef] defaultReturn:@""];
        
        timeOfReturn .text = [self checkGivenValueIsNullOrNil:[updateStockReturnDic valueForKey:kTimeOfReturnStr] defaultReturn:@""];
        
        shipmentCarrier .text = [self checkGivenValueIsNullOrNil:[updateStockReturnDic valueForKey:kShipmentCarrier] defaultReturn:@""];
        
        remarks .text = [self checkGivenValueIsNullOrNil:[updateStockReturnDic valueForKey:REMARKS] defaultReturn:@""];
        
        for (NSDictionary * dic in [updateStockReturnDic valueForKey:STOCK_LIST]) {
            
            NSMutableDictionary *itemDetailsDic = [[NSMutableDictionary alloc] init];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_ID] defaultReturn:@""] forKey:ITEM_SKU];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_ID] defaultReturn:@""] forKey:ITEM_ID];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESCRIPTION];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:UOM] defaultReturn:@""] forKey:UOM];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:EAN] defaultReturn:@""] forKey:EAN];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:QUANTITY] defaultReturn:@"0.00"] forKey:QUANTITY];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kPrice] defaultReturn:@"0.00"] forKey:kPrice];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:VALUE] defaultReturn:@"0.00"] forKey:VALUE];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kComments] defaultReturn:@""] forKey:kComments];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kReasonForReturn] defaultReturn:@""] forKey:kReasonForReturn];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kReturnNoteRef] defaultReturn:@""] forKey:kReturnNoteRef];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kBrand] defaultReturn:@""] forKey:kBrand];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:MEASUREMENT_RANGE] defaultReturn:@""] forKey:MEASUREMENT_RANGE];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];
            
            // keys added by roja on 20-07-2018...
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:UTILITY] defaultReturn:@""] forKey:UTILITY];
            [itemDetailsDic setValue:EMPTY_STRING forKey:ITEM_SCAN_CODE];
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:TRACKING_REQUIRED] defaultReturn:ZERO_CONSTANT] forKey:TRACKING_REQUIRED];
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:RECEIVED_QTY] defaultReturn:@"0.00"] forKey:RECEIVED_QTY];
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:AVAIL_QTY] defaultReturn:@"0.00"] forKey:AVL_QTY];

            [rawMaterialDetails addObject:itemDetailsDic];
        }
        [cartTable reloadData];
        
        // showing the next activities
        
        if([[updateStockReturnDic valueForKey:NEXT_ACTIVITIES] count] || [[updateStockReturnDic valueForKey:NEXT_WORK_FLOW_STATES] count]){
            
            [nextActivitiesArr addObject:NSLocalizedString(@"select", nil)];
            for(NSString *str in [updateStockReturnDic valueForKey:NEXT_ACTIVITIES])
                [nextActivitiesArr addObject:str];
            
            for(NSString *str in [updateStockReturnDic valueForKey:NEXT_WORK_FLOW_STATES])
                [nextActivitiesArr addObject:str];
            
        }
        //upto here.....
        
        if(nextActivitiesArr.count == 0){
            [nextActivitiesArr addObject:NSLocalizedString(@"--no_activities--",nil)];

            submitBtn.hidden = YES;
            cancelButton.frame = CGRectMake(searchItem.frame.origin.x,goodsReturnView.frame.size.height-45,140, 40);
        }

        UIImage * workArrowImg = [UIImage imageNamed:@"workflow_arrow.png"];
        
        UIImageView *workFlowImageView = [[UIImageView alloc] init];
        
        workFlowImageView.image = workArrowImg;
        
        [workFlowView addSubview:workFlowImageView];
        
        NSArray *workFlowArr;
        
        workFlowArr = [updateStockReturnDic valueForKey:PREVIOUS_ACTIVITIES];
        
        workFlowImageView.frame = CGRectMake(workFlowView.frame.origin.x+10, 5,  workFlowView.frame.size.height + 30 , workFlowView.frame.size.height - 10);
        
        float label_x_origin = workFlowImageView.frame.origin.x + workFlowImageView.frame.size.width;
        float label_y_origin = workFlowImageView.frame.origin.y;
        
        float labelWidth =  (workFlowView.frame.size.width - workFlowImageView.frame.size.width)/ ((workFlowArr.count * 2 ) - 1);
        float labelHeight = workFlowImageView.frame.size.height;
        
        if( workFlowArr.count <= 3 )
            //taking max as 5 labels.....
            labelWidth =  (workFlowView.frame.size.width - workFlowImageView.frame.size.width - 380)/ 4;
        
        for(NSString *str  in workFlowArr){
            
            UILabel *workFlowNameLbl;
            UILabel *workFlowLineLbl;
            
            workFlowNameLbl = [[UILabel alloc] init] ;
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
                workFlowLineLbl = [[UILabel alloc] init] ;
                workFlowLineLbl.backgroundColor = [UIColor lightGrayColor];
                
                [workFlowView addSubview:workFlowLineLbl];
                
                workFlowLineLbl.frame = CGRectMake(label_x_origin,(labelHeight + 4)/2,labelWidth, 2);
                label_x_origin = workFlowLineLbl.frame.origin.x + workFlowLineLbl.frame.size.width;
            }
            
            NSLog(@"---------%@",str);
        }
        
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
 * @author
 * @param
 * @return
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 *
 */
-(void)getStockReturnErrorResponse:(NSString *)errorResponse {
    @try {
        
          [self displayAlertMessage:errorResponse horizontialAxis:(self.view.frame.size.width - 360)/2  verticalAxis:self.view.frame.size.height - 180   msgType:NSLocalizedString(@"warning", nil) conentWidth:260 contentHeight:100  isSoundRequired:YES timing:3.0 noOfLines:1];
        
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
 * @author
 * @param
 * @return
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 *
 */

- (void)searchProductsSuccessResponse:(NSDictionary *)successDictionary {
    
    
    @try {
        
        //checking searchItemsFieldTag.......
        if (successDictionary != nil && (searchItem.tag == (searchItem.text).length) ) {
            
            
            //checking searchItemsFieldTag.......
            if (![successDictionary[PRODUCTS_LIST] isKindOfClass:[NSNull class]]  && [successDictionary.allKeys containsObject:PRODUCTS_LIST]) {
                
                
                for(NSDictionary *dic in [successDictionary valueForKey:PRODUCTS_LIST]){
                    
                    [rawMaterials addObject:dic];
                }
            }
            
            if(rawMaterials.count){
                float tableHeight = rawMaterials.count * 40;
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                    tableHeight = rawMaterials.count * 33;
                
                if(rawMaterials.count > 5)
                    tableHeight = (tableHeight/rawMaterials.count) * 5;
                
                [self showPopUpForTables:skListTable  popUpWidth:searchItem.frame.size.width  popUpHeight:tableHeight presentPopUpAt:searchItem  showViewIn:goodsReturnView permittedArrowDirections:UIPopoverArrowDirectionUp];
            }
            else if(catPopOver.popoverVisible)
                [catPopOver dismissPopoverAnimated:YES];
            searchItem.tag = 0;
            [HUD setHidden:YES];
        }
        
        else if ( (((searchItem.text).length >= 3) && (searchItem.tag != 0)) && (searchItem.tag != (searchItem.text).length)) {
            
            searchItem.tag = 0;
            
            [self textFieldDidChange:searchItem];
            
        }
        else  if(catPopOver.popoverVisible || (searchItem.tag == (searchItem.text).length)){
            [catPopOver dismissPopoverAnimated:YES];
            searchItem.tag = 0;
            [HUD setHidden:YES];
            
        }
        else {
            
            [catPopOver dismissPopoverAnimated:YES];
            searchItem.tag = 0;
            [HUD setHidden:YES];
        }
    }
    
    @catch (NSException * exception) {
        
        if(catPopOver.popoverVisible)
            [catPopOver dismissPopoverAnimated:YES];
        searchItem.tag = 0;
        [HUD setHidden:YES];
        
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
 * @return
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 *
 */

- (void)searchProductsErrorResponse {
    
    @try {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis   msgType:@"" conentWidth:300 contentHeight:40  isSoundRequired:YES timing:2.0 noOfLines:1];
        
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
 * @return
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 *
 */

- (void)getSkuDetailsSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        if (successDictionary != nil) {
            
            
            priceArr = [[NSMutableArray alloc]init];
            NSArray *price_arr = [successDictionary valueForKey:kSkuLists];
            
            for (int i=0; i<price_arr.count; i++) {
                
                NSDictionary *json = price_arr[i];
                [priceArr addObject:json];
            }
            if (((NSArray *)[successDictionary valueForKey:kSkuLists]).count>1) {
                
                if (priceArr.count>0) {
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
                
                BOOL Status = FALSE;
                
                int i=0;
                NSMutableDictionary * existingItemDic;
                
                for ( i=0; i<rawMaterialDetails.count;i++) {
                    NSArray *itemArray = [successDictionary valueForKey:kSkuLists];
                    if (itemArray.count > 0) {
                        NSDictionary * itemdic = itemArray[0];
                        existingItemDic = rawMaterialDetails[i];
                        if ([[existingItemDic valueForKey:ITEM_SKU] isEqualToString:[itemdic valueForKey:ITEM_SKU]] && [[existingItemDic valueForKey:PLU_CODE] isEqualToString:[itemdic valueForKey:PLU_CODE]]) {
                            [existingItemDic setValue:[NSString stringWithFormat:@"%d",[[existingItemDic valueForKey:QUANTITY] intValue] + 1] forKey:QUANTITY];
                            
                            rawMaterialDetails[i] = existingItemDic;
                            
                            Status = TRUE;
                            break;
                        }
                    }
                }
                
                if (!Status) {
                    
                    NSArray *itemArray = [successDictionary valueForKey:kSkuLists];
                    if (itemArray.count > 0) {
                        NSDictionary *itemdic = itemArray[0];
                        
                        NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc] init];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_SKU];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_ID];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESCRIPTION];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:kPrice] defaultReturn:@"0.00"] floatValue]] forKey:kPrice];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:SALE_PRICE] defaultReturn:@"0.00"] floatValue]] forKey:SALE_PRICE];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:COST] defaultReturn:@"0.00"] floatValue]] forKey:COST];
                        
                        //setting availiable qty....
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:AVL_QTY];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:VALUE];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:QUANTITY];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:EAN] defaultReturn:@""] forKey:EAN];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:SELL_UOM] defaultReturn:@""] forKey:UOM];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kBrand] defaultReturn:@""] forKey:kBrand];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:MEASUREMENT_RANGE] defaultReturn:@""] forKey:MEASUREMENT_RANGE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kComments] defaultReturn:@""] forKey:kComments];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kReasonForReturn] defaultReturn:@""] forKey:kReasonForReturn];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kReturnNoteRef] defaultReturn:@""] forKey:kReturnNoteRef];
                        
                        // added by roja on 20-07-2018...
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:RECEIVED_QTY];
                        
                        [itemDetailsDic setValue:ZERO_CONSTANT forKey:ITEM_SCAN_CODE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:TRACKING_REQUIRED] defaultReturn:ZERO_CONSTANT] forKey:TRACKING_REQUIRED];

                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:UTILITY] defaultReturn:@""] forKey:UTILITY];

                        [rawMaterialDetails addObject:itemDetailsDic];
                    }
                    
                    else
                        rawMaterialDetails[i] = existingItemDic;
                    
                    cartTable.hidden = NO;
                }
                
            }
            
        }
    }
    @catch (NSException * exception) {
        NSLog(@"---exception will reading.-------%@",exception);
    }
    @finally{
        [HUD setHidden:YES];
        [cartTable reloadData];
        
    }
}

/**
 * @description  in this method we will call the services....
 * @method       getSkuDetailsErrorResponse
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

- (void)getSkuDetailsErrorResponse:(NSString*)errorResponse {
    @try {
        
        //added by Srinivasulu on 13/04/2017....
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        [self displayAlertMessage:errorResponse horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis   msgType:@"" conentWidth:300 contentHeight:40  isSoundRequired:YES timing:3.0 noOfLines:1];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
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
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2  verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil) conentWidth:300 contentHeight:40  isSoundRequired:YES timing:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}


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
                            
                            if ([[existItemdic valueForKey:ITEM_SKU] isEqualToString:[newSkuPriceListDic valueForKey:ITEM_SKU]] && [[existItemdic valueForKey:PLU_CODE] isEqualToString:[newSkuPriceListDic valueForKey:PLU_CODE]] ) {
                                
                                [existItemdic setValue:[NSString stringWithFormat:@"%d",[[existItemdic valueForKey:QUANTITY] intValue] + 1] forKey:QUANTITY];
                                
                                rawMaterialDetails[i] = existItemdic;
                                
                                isExistingItem = true;
                                
                                break;
                            }
                        }
                        
                        if(isExistingItem) {
                            
                            rawMaterialDetails[i] = existItemdic;
                            
                        }
                        else{
                            
                            NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc ]init];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_SKU];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_ID];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESCRIPTION];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
                            
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:kPrice] defaultReturn:@"0.00"] floatValue]] forKey:kPrice];
                            
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:SALE_PRICE] defaultReturn:@"0.00"] floatValue]] forKey:SALE_PRICE];
                            
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:COST] defaultReturn:@"0.00"] floatValue]] forKey:COST];
                            
                            //setting availiable qty....
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:QUANTITY_IN_HAND] defaultReturn:@"0.00"] floatValue]] forKey:AVL_QTY];
                            
                            //float Value = [[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:kPrice] defaultReturn:@"0.00"] floatValue] * [[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:QUANTITY_IN_HAND] defaultReturn:@"0.00"] floatValue];
                            
                            //[itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",Value] forKey:VALUE];
                            
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:VALUE];
                            
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:QUANTITY];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:EAN] defaultReturn:@""] forKey:EAN];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:SELL_UOM] defaultReturn:@""] forKey:UOM];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:kBrand] defaultReturn:@""] forKey:kBrand];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:MEASUREMENT_RANGE] defaultReturn:@""] forKey:MEASUREMENT_RANGE];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:kComments] defaultReturn:@""] forKey:kComments];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:kReasonForReturn] defaultReturn:@""] forKey:kReasonForReturn];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:kReturnNoteRef] defaultReturn:@""] forKey:kReturnNoteRef];
                            
                            // added by roja on 20-07-2018...
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:RECEIVED_QTY];

                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:TRACKING_REQUIRED] defaultReturn:ZERO_CONSTANT] forKey:TRACKING_REQUIRED];
                            
                            [itemDetailsDic setValue:EMPTY_STRING forKey:ITEM_SCAN_CODE];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:UTILITY] defaultReturn:ZERO_CONSTANT] forKey:UTILITY];


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
                            
                            rawMaterialDetails[i] = existItemdic;
                            
                            isExistingItem = true;
                            
                            break;
                        }
                    }
                    
                    if(isExistingItem) {
                        
                        [existItemdic setValue:[NSString stringWithFormat:@"%d",[[existItemdic valueForKey:QUANTITY] intValue] + 1] forKey:QUANTITY];
                        
                        rawMaterialDetails[i] = existItemdic;
                    }
                    else{
                        
                        NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc ]init];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_SKU];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_ID];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESCRIPTION];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:kPrice] defaultReturn:@"0.00"] floatValue]] forKey:kPrice];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:SALE_PRICE] defaultReturn:@"0.00"] floatValue]] forKey:SALE_PRICE];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:COST] defaultReturn:@"0.00"] floatValue]] forKey:COST];
                        
                        //setting availiable qty....
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:AVL_QTY];
                        
                        float Value = [[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:kPrice] defaultReturn:@"0.00"] floatValue] * [[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",Value] forKey:VALUE];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:QUANTITY];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:EAN] defaultReturn:@""] forKey:EAN];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:SELL_UOM] defaultReturn:@""] forKey:UOM];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:kBrand] defaultReturn:@""] forKey:kBrand];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:MEASUREMENT_RANGE] defaultReturn:@""] forKey:MEASUREMENT_RANGE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:kComments] defaultReturn:@""] forKey:kComments];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:kReasonForReturn] defaultReturn:@""] forKey:kReasonForReturn];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:kReturnNoteRef] defaultReturn:@""] forKey:kReturnNoteRef];
                        
                        // added by roja on 24-07-2018...
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:RECEIVED_QTY];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:TRACKING_REQUIRED] defaultReturn:ZERO_CONSTANT] forKey:TRACKING_REQUIRED];
                        
                        [itemDetailsDic setValue:EMPTY_STRING forKey:ITEM_SCAN_CODE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:UTILITY] defaultReturn:ZERO_CONSTANT] forKey:UTILITY];
                        
                        [rawMaterialDetails addObject:itemDetailsDic];
                    }
                }
            }
            
            
            float y_axis = self.view.frame.size.height - 120;
            
            if(searchItem.isEditing)
                y_axis = searchItem.frame.origin.y + searchItem.frame.size.height;
            
            NSString * mesg = [NSString stringWithFormat:@"%d%@",totalRecords,NSLocalizedString(@"records_are_added_to_the_cart_successfully", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2  verticalAxis:self.view.frame.size.height - 140   msgType:NSLocalizedString(@"cart_records", nil) conentWidth:400 contentHeight:60  isSoundRequired:YES timing:3.0 noOfLines:1];

            [self calculateTotal];
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
        [cartTable reloadData];
        
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
        
        if(searchItem.isEditing)
            y_axis = searchItem.frame.origin.y + searchItem.frame.size.height;
        
        
        [self displayAlertMessage:errorResponse horizontialAxis:(self.view.frame.size.width - 360)/2  verticalAxis:self.view.frame.size.height - 140   msgType:@"" conentWidth:300 contentHeight:40  isSoundRequired:YES timing:3.0 noOfLines:1];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [HUD setHidden:YES];
        [categoriesPopOver dismissPopoverAnimated:YES];
        
    }
}

/**
 * @description
 * @date
 * @method
 * @author
 * @param
 * @return
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 *
 */

-(void)upDateStockReturnSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        [HUD setHidden:YES];
        
        float y_axis;
        
        if (successDictionary != NULL) {
            NSDictionary *json = successDictionary[RESPONSE_HEADER];
            
            if ([json[RESPONSE_CODE] isEqualToString:ZERO_CONSTANT] && [json[RESPONSE_MESSAGE] isEqualToString:SUCCESS]) {
                
                y_axis = self.view.frame.size.height - 120;
                
                if(searchItem.isEditing)
                    y_axis = searchItem.frame.origin.y + searchItem.frame.size.height;
                
                NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"stock_return_updated_successfully",nil),@"\n",[successDictionary valueForKey:kReturnNoteRef]];
                               
                [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis   msgType:NSLocalizedString(@"SUCCESS", nil) conentWidth:400 contentHeight:60  isSoundRequired:YES timing:3.0 noOfLines:1];

                
            }
        }
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
 * @return
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 *
 */

-(void)upDateStockReturnErrorResponse:(NSString *) errorResponse {
    
    @try {
        
        //changed By srinivauslu on 02/05/2018....
        //reason.. Need to stop user internation after servcie calls...
        
        submitBtn.userInteractionEnabled = YES;

        //upto here on 02/05/2018....
        
        [HUD setHidden:YES];
        
        [self displayAlertMessage:errorResponse horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:self.view.frame.size.height - 140   msgType:@"" conentWidth:350 contentHeight:40  isSoundRequired:YES timing:3.0 noOfLines:1];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
    }
}



#pragma mark popover methods..

/**
 * @description
 * @date
 * @method
 * @author
 * @param
 * @return
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 *
 */
- (void)showNextAcivities:(UIButton *)sender{
    
    
    AudioServicesPlaySystemSound(soundFileObject);
    @try {
        int count = 5;
        
        if (nextActivitiesArr.count < count) {
            count = (int)nextActivitiesArr.count;
        }
        
        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, actionReqTxt.frame.size.width, count * 40)];
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
            
            [popover presentPopoverFromRect:actionReqTxt.frame inView:goodsReturnView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
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
        
        [nextActivityTbl reloadData];
        
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
 * @return
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 *
 */

-(void)getShipmentModes:(UIButton*)sender {
    
    AudioServicesPlaySystemSound(soundFileObject);
    
    shipmodeList = [NSMutableArray new];
    [shipmodeList addObject:NSLocalizedString(@"rail", nil) ];
    [shipmodeList addObject:NSLocalizedString(@"flight", nil) ];
    [shipmodeList addObject:NSLocalizedString(@"express", nil) ];
    [shipmodeList addObject:NSLocalizedString(@"ordinary", nil) ];
    
    int count  = 5 ;
    
    if (shipmodeList.count < count) {
        count = (int)shipmodeList.count;
    }
    
    PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, shipmentMode.frame.size.width,count * 45)];
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
        
        [popover presentPopoverFromRect:shipmentMode.frame inView:goodsReturnView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        
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
        
        categoriesView = [[UIView alloc] initWithFrame:CGRectMake(selectCategoriesBtn.frame.origin.x,searchItem.frame.origin.y,300,350)];
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
        headerNameLbl.text = NSLocalizedString(@"categories_list", nil);
        
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
        
        
        cancelBtn = [[UIButton alloc] init] ;
        [cancelBtn setTitle:NSLocalizedString(@"cancel", nil) forState:UIControlStateNormal];
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
            
            [popOver presentPopoverFromRect:selectCategoriesBtn.frame inView:goodsReturnView permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
            
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
 * @description
 * @date
 * @method
 * @author
 * @param
 * @return
 * @modified BY
 * @reason
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
            
            pickView.frame = CGRectMake(15, dateOfReturn.frame.origin.y+dateOfReturn.frame.size.height, 320, 320);
            
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
        
        pickButton.frame = CGRectMake( (customView.frame.size.width / 2) - (100/2), 269, 100, 45);
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
            
            
            if(sender.tag == 2)
                [popover presentPopoverFromRect:dateOfReturn.frame inView:goodsReturnView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else
                [popover presentPopoverFromRect:shipmentOn.frame inView:goodsReturnView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
            catPopOver= popover;
            
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
 * @description
 * @date
 * @method
 * @author
 * @param
 * @return
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 *
 */

-(void)populateDateToTextField:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        [catPopOver dismissPopoverAnimated:YES];
        
        //Date Format Setting...
        NSDateFormatter *requiredDateFormat = [[NSDateFormatter alloc] init];
        //        [requiredDateFormat setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        requiredDateFormat.dateFormat = @"dd/MM/yyyy";
        dateString = [requiredDateFormat stringFromDate:myPicker.date];
        
        
        NSDate *selectedDateString = [requiredDateFormat dateFromString:[requiredDateFormat stringFromDate:myPicker.date]];
        
        NSDate *existingDateString;
        /*z;
         UITextField *endDateTxt;*/
        
        if(sender.tag == 1){
            
            if ((shipmentOn.text).length != 0 && ( ![shipmentOn.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:dateOfReturn.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    shipmentOn.text = @"";
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"delivery_date_should_not_be_earlier_than_request_date", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                    [alert show];
                    return;
                }
            }
            shipmentOn.text = dateString;
        }
        else if (sender.tag  == 2) {
            
            if ((dateOfReturn.text).length != 0 && ( ![dateOfReturn.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:dateOfReturn.text ];
                
                if ([existingDateString compare:selectedDateString]== NSOrderedDescending) {
                    
                    dateOfReturn.text = @"";
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"request_date_should_not_be_earlier_than_present_date", nil)   message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                    [alert show];
                    return;
                }
            }
            dateOfReturn.text = dateString;
            
        }
        
    } @catch (NSException *exception) {
        
    }
    @finally{
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

-(void)clearDate:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        [catPopOver dismissPopoverAnimated:YES];
        
        if(sender.tag == 1) {
            if((shipmentOn.text).length)
                //callServices = true;
                
                shipmentOn.text = @"";
        }
        else {
            if((dateOfReturn.text).length)
                //callServices = true;
                
                dateOfReturn.text = @"";
        }
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        NSLog(@"---- exception in StockReceiptView -- in  -- clearDate() ----");
        NSLog(@"---- exception is ----%@",exception);
        
    } @finally {
        
    }
}



#pragma mark textField delegates:

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    
    if (textField.frame.origin.x == returnQtyTxt.frame.origin.x  || textField.frame.origin.x  == reasonsTxt.frame.origin.x )
        
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
            
            if(textField == searchItem){
                
                offSetViewTo = 120;
            }
            
            else if (textField.frame.origin.x == returnQtyTxt.frame.origin.x || textField.frame.origin.x  == reasonsTxt.frame.origin.x) {
                
                [textField selectAll:nil];
                [UIMenuController sharedMenuController].menuVisible = NO;

                int count = (int)textField.tag;
                
                if(textField.tag > 8)
                    
                    count = 8;
                
                offSetViewTo = (textField.frame.origin.y + textField.frame.size.height) * count + cartTable.frame.origin.y;

            }
            
            [self keyboardWillShow];
            
        } @catch (NSException *exception) {
            
        }
        
    } @catch (NSException *exception) {
        
    }
}

/**
 * @description
 * @date
 * @method
 * @author
 * @param
 * @return
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 *
 */
- (void)textFieldDidChange:(UITextField *)textField {
   
    if (textField == searchItem) {
        
        if ((textField.text).length >= 3) {
            
            @try {
                
                if (searchItem.tag == 0) {
                    
                    searchItem.tag = (textField.text).length;
                    
                    rawMaterials = [[NSMutableArray alloc]init];
                    
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
            searchItem.tag = 0;
            [catPopOver dismissPopoverAnimated:YES];
            
        }
    }
    else if(textField.frame.origin.x == returnQtyTxt.frame.origin.x) {
        
        reloadTableData = true;
        
        NSString * qtyKey = QUANTITY;
        
        NSMutableDictionary *temp = [rawMaterialDetails[textField.tag]  mutableCopy];
        [temp setValue:textField.text forKey:qtyKey];
        
        rawMaterialDetails[textField.tag] = temp;
    }
    
    else if (textField.frame.origin.x == commentsTxt.frame.origin.x) {
        
        
        NSMutableDictionary *temp = [rawMaterialDetails[textField.tag]  mutableCopy];
        [temp setValue:textField.text forKey:kComments];
        
        rawMaterialDetails[textField.tag] = temp;
    }
    
    else if (textField.frame.origin.x == reasonsTxt.frame.origin.x) {
        
        
        NSMutableDictionary *temp = [rawMaterialDetails[textField.tag]  mutableCopy];
        [temp setValue:textField.text forKey:kReasonForReturn];
        
        rawMaterialDetails[textField.tag] = temp;
    }
    
    // added by roja on 23-07-2018..
    else if (textField.frame.origin.x == scanCodeTxt.frame.origin.x) {
        
        NSMutableDictionary * temp = [rawMaterialDetails[textField.tag]  mutableCopy];
        [temp setValue:textField.text forKey:ITEM_SCAN_CODE];
        
        rawMaterialDetails[textField.tag] = temp;
    }
    
}

/**
 * @description
 * @date
 * @method
 * @author
 * @param
 * @return
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 *
 */
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    if (textField.frame.origin.x == returnQtyTxt.frame.origin.x) {
        
        
        @try {
            NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
            NSString * expression = @"^[0-9]*((\\.)[0-9]{0,2})?$";
            NSError *error = nil;
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
            NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString options:0 range:NSMakeRange(0, newString.length)];
            return numberOfMatches != 0;
        } @catch (NSException *exception) {
            
            //            NSLog(@"----exception in GoodsReceiptNoteView ----");
            NSLog(@"---- exception in texField: shouldChangeCharactersInRange:replalcement----%@",exception);
            
            return  YES;
            
            
        }
        
    }
    
    return  YES;
}

/**
 * @description
 * @date
 * @method
 * @author
 * @param
 * @return
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 *
 */
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [self keyboardWillHide];
    
    offSetViewTo = 0;
    
    if (textField.frame.origin.x == returnQtyTxt.frame.origin.x) {
        
        @try {
            NSString * qtyKey = QUANTITY;
            
            NSMutableDictionary *temp = [rawMaterialDetails[textField.tag]  mutableCopy];
            [temp setValue:textField.text  forKey:qtyKey];
            
            rawMaterialDetails[textField.tag] = temp;
        }
        @catch (NSException *exception) {
            NSLog(@"---------%@",exception);
        }
        @finally {
            if(reloadTableData)
                [cartTable reloadData];
        }
    }
    
    else if (textField.frame.origin.x == reasonsTxt.frame.origin.x) {
        
        @try {
            
            NSMutableDictionary *temp = [rawMaterialDetails[textField.tag]  mutableCopy];
            [temp setValue:textField.text forKey:kReasonForReturn];
            
            rawMaterialDetails[textField.tag] = temp;
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            if(reloadTableData)
                [cartTable reloadData];
        }
    }
    
    // added by roja on 23-07-2018...
    else if (textField.frame.origin.x == scanCodeTxt.frame.origin.x) {
        
        @try {
            
            NSMutableDictionary *temp = [rawMaterialDetails[textField.tag]  mutableCopy];
            [temp setValue:textField.text forKey:ITEM_SCAN_CODE];
            
            rawMaterialDetails[textField.tag] = temp;
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            if(reloadTableData)
                [cartTable reloadData];
        }
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark Table View Delegates:


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if(tableView == cartTable|| tableView == skListTable||tableView == shipModeTable ||tableView == nextActivityTbl||tableView == categoriesTbl || tableView == priceTable){
            
            return 40;
        }
        else
            return 0;
    }
    else return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    if(tableView == skListTable){
        return rawMaterials.count;
    }
    else if(tableView == cartTable){
        
        [self calculateTotal];
        
        return rawMaterialDetails.count;
    }
    else if (tableView == shipModeTable) {
        return shipmodeList.count;
    }
    else if (tableView == nextActivityTbl) {
        return nextActivitiesArr.count;
    }
    else if (tableView == categoriesTbl){
        
        return categoriesArr.count;
    }
    else if (tableView == priceTable){
        
        return priceArr.count;
    }
    
    else
        return false;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == skListTable) {
        
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
            
            if (rawMaterials.count > indexPath.row){
                NSDictionary * dic = rawMaterials[indexPath.row];
                
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
                itemMeasurementLbl.frame = CGRectMake( itemSizeLbl.frame.origin.x + itemSizeLbl.frame.size.width, 0, searchItem.frame.size.width - (itemSizeLbl.frame.origin.x + itemSizeLbl.frame.size.width), itemDescLbl.frame.size.height);
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
    
    else if (tableView == cartTable) {
        
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
            
            layer_1 = [CAGradientLayer layer];
            
            @try {
                
                layer_1.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
                
                layer_1.frame = CGRectMake( sNoLbl.frame.origin.x, hlcell.frame.size.height - 2, actionLbl.frame.origin.x + actionLbl.frame.size.width - sNoLbl.frame.origin.x, 1);
                
                [hlcell.contentView.layer addSublayer:layer_1];
                
            } @catch (NSException *exception) {
                
            }
        }
        
        UILabel *itemNoLbl;
        UILabel *itemIdLbl;
        UILabel *itemDescLbl;
        UILabel *itemEanLbl;
        UILabel *itemUomLbl;
        UILabel *itemAvlQty;
        UILabel *itemPriceLbl;
        UILabel *itemValueLbl;
        UIButton* delRowBtn;
        
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
        
        itemEanLbl = [[UILabel alloc] init];
        itemEanLbl.backgroundColor = [UIColor clearColor];
        itemEanLbl.layer.borderWidth = 0;
        itemEanLbl.textAlignment = NSTextAlignmentCenter;
        itemEanLbl.numberOfLines = 1;
        itemEanLbl.lineBreakMode = NSLineBreakByWordWrapping;
        
        
        itemUomLbl = [[UILabel alloc] init];
        itemUomLbl.backgroundColor = [UIColor clearColor];
        itemUomLbl.layer.borderWidth = 0;
        itemUomLbl.textAlignment = NSTextAlignmentCenter;
        itemUomLbl.numberOfLines = 1;
        itemUomLbl.lineBreakMode = NSLineBreakByWordWrapping;
        
        itemAvlQty = [[UILabel alloc] init];
        itemAvlQty.backgroundColor = [UIColor clearColor];
        itemAvlQty.layer.borderWidth = 0;
        itemAvlQty.textAlignment = NSTextAlignmentCenter;
        itemAvlQty.numberOfLines = 1;
        itemAvlQty.lineBreakMode = NSLineBreakByWordWrapping;
        
        itemPriceLbl = [[UILabel alloc] init];
        itemPriceLbl.backgroundColor = [UIColor clearColor];
        itemPriceLbl.layer.borderWidth = 0;
        itemPriceLbl.textAlignment = NSTextAlignmentCenter;
        itemPriceLbl.numberOfLines = 1;
        itemPriceLbl.lineBreakMode = NSLineBreakByWordWrapping;
        
        returnQtyTxt = [[UITextField alloc] init];
        returnQtyTxt.borderStyle = UITextBorderStyleRoundedRect;
        returnQtyTxt.textColor = [UIColor blackColor];
        returnQtyTxt.keyboardType = UIKeyboardTypeNumberPad;
        returnQtyTxt.layer.borderWidth = 2;
        returnQtyTxt.backgroundColor = [UIColor clearColor];
        returnQtyTxt.autocorrectionType = UITextAutocorrectionTypeNo;
        returnQtyTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
        returnQtyTxt.returnKeyType = UIReturnKeyDone;
        returnQtyTxt.delegate = self;
        [returnQtyTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        returnQtyTxt.textAlignment = NSTextAlignmentCenter;
        returnQtyTxt.tag = indexPath.row;
        returnQtyTxt.userInteractionEnabled = YES;
        
        
        itemValueLbl = [[UILabel alloc] init];
        itemValueLbl.backgroundColor = [UIColor clearColor];
        itemValueLbl.layer.borderWidth = 0;
        itemValueLbl.textAlignment = NSTextAlignmentCenter;
        itemValueLbl.numberOfLines = 1;
        itemValueLbl.lineBreakMode = NSLineBreakByWordWrapping;
        
        reasonsTxt = [[UITextField alloc] init];
        reasonsTxt.borderStyle = UITextBorderStyleRoundedRect;
        reasonsTxt.textColor = [UIColor blackColor];
        reasonsTxt.keyboardType = UIKeyboardTypeDefault;
        reasonsTxt.layer.borderWidth = 2;
        reasonsTxt.backgroundColor = [UIColor clearColor];
        reasonsTxt.autocorrectionType = UITextAutocorrectionTypeNo;
        reasonsTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
        reasonsTxt.returnKeyType = UIReturnKeyDone;
        reasonsTxt.delegate = self;
        reasonsTxt.placeholder = NSLocalizedString(@"reason",nil);
        reasonsTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:reasonsTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor whiteColor]colorWithAlphaComponent:0.4]}];
        [reasonsTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        reasonsTxt.textAlignment = NSTextAlignmentCenter;
        reasonsTxt.tag = indexPath.row;
        reasonsTxt.userInteractionEnabled = YES;
        
        
        // added by roja on 23-07-2018...
        batchNoTxt = [[UITextField alloc] init];
        batchNoTxt.borderStyle = UITextBorderStyleRoundedRect;
        batchNoTxt.textColor = [UIColor blackColor];
        batchNoTxt.keyboardType = UIKeyboardTypeDefault;
        batchNoTxt.layer.borderWidth = 2;
        batchNoTxt.backgroundColor = [UIColor clearColor];
        batchNoTxt.autocorrectionType = UITextAutocorrectionTypeNo;
        batchNoTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
        batchNoTxt.returnKeyType = UIReturnKeyDone;
        batchNoTxt.delegate = self;
        batchNoTxt.placeholder = NSLocalizedString(@"batch_no",nil);
        batchNoTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:batchNoTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor whiteColor]colorWithAlphaComponent:0.4]}];
        [batchNoTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        batchNoTxt.textAlignment = NSTextAlignmentCenter;
        batchNoTxt.tag = indexPath.row;
        batchNoTxt.userInteractionEnabled = NO;
        
        // added by roja on 23-07-2018...
        expiryDateTxt = [[UITextField alloc] init];
        expiryDateTxt.borderStyle = UITextBorderStyleRoundedRect;
        expiryDateTxt.textColor = [UIColor blackColor];
        expiryDateTxt.keyboardType = UIKeyboardTypeDefault;
        expiryDateTxt.layer.borderWidth = 2;
        expiryDateTxt.backgroundColor = [UIColor clearColor];
        expiryDateTxt.autocorrectionType = UITextAutocorrectionTypeNo;
        expiryDateTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
        expiryDateTxt.returnKeyType = UIReturnKeyDone;
        expiryDateTxt.delegate = self;
        expiryDateTxt.placeholder = NSLocalizedString(@"expiry_date",nil);
        expiryDateTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:expiryDateTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor whiteColor]colorWithAlphaComponent:0.4]}];
        [expiryDateTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        expiryDateTxt.textAlignment = NSTextAlignmentCenter;
        expiryDateTxt.tag = indexPath.row;
        expiryDateTxt.userInteractionEnabled = NO;
        
        // added by roja on 23-07-2018...
        scanCodeTxt = [[UITextField alloc] init];
        scanCodeTxt.borderStyle = UITextBorderStyleRoundedRect;
        scanCodeTxt.textColor = [UIColor blackColor];
        scanCodeTxt.keyboardType = UIKeyboardTypeDefault;
        scanCodeTxt.layer.borderWidth = 2;
        scanCodeTxt.backgroundColor = [UIColor clearColor];
        scanCodeTxt.autocorrectionType = UITextAutocorrectionTypeNo;
        scanCodeTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
        scanCodeTxt.returnKeyType = UIReturnKeyDone;
        scanCodeTxt.delegate = self;
        scanCodeTxt.placeholder = NSLocalizedString(@"scan_code",nil);
        scanCodeTxt.attributedPlaceholder = [[NSAttributedString alloc]initWithString:scanCodeTxt.placeholder attributes:@{NSForegroundColorAttributeName:[[UIColor whiteColor]colorWithAlphaComponent:0.4]}];
        [scanCodeTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        scanCodeTxt.textAlignment = NSTextAlignmentCenter;
        scanCodeTxt.tag = indexPath.row;
        scanCodeTxt.userInteractionEnabled = YES;
        
        
        
        
        delRowBtn = [[UIButton alloc] init];
        [delRowBtn addTarget:self action:@selector(delRow:) forControlEvents:UIControlEventTouchUpInside];
        UIImage *image = [UIImage imageNamed:@"delete.png"];
        delRowBtn.tag = indexPath.row;
        [delRowBtn setBackgroundImage:image    forState:UIControlStateNormal];
        
        [hlcell.contentView addSubview:itemNoLbl];
        [hlcell.contentView addSubview:itemIdLbl];
        [hlcell.contentView addSubview:itemDescLbl];
        [hlcell.contentView addSubview:itemEanLbl];
        [hlcell.contentView addSubview:itemUomLbl];
        [hlcell.contentView addSubview:itemAvlQty];
        [hlcell.contentView addSubview:itemPriceLbl];
        [hlcell.contentView addSubview:returnQtyTxt];
        [hlcell.contentView addSubview:itemValueLbl];
        [hlcell.contentView addSubview:reasonsTxt];
        [hlcell.contentView addSubview:delRowBtn];
        // added by roja on 23-07-2018...
        [hlcell.contentView addSubview:batchNoTxt];
        [hlcell.contentView addSubview:expiryDateTxt];
        [hlcell.contentView addSubview:scanCodeTxt];
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            if (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight) {
                
                [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:16.0f cornerRadius:0.0];
                
                itemNoLbl.frame = CGRectMake(sNoLbl.frame.origin.x, 0, sNoLbl.frame.size.width, hlcell.frame.size.height);
                
                itemIdLbl.frame = CGRectMake(sKuidLbl.frame.origin.x, 0, sKuidLbl.frame.size.width,  hlcell.frame.size.height);
                
                itemDescLbl.frame = CGRectMake(descLbl.frame.origin.x , 0, descLbl.frame.size.width,  hlcell.frame.size.height);
                
                itemEanLbl.frame = CGRectMake(eanLbl.frame.origin.x , 0, eanLbl.frame.size.width,  hlcell.frame.size.height);
                
                itemUomLbl.frame = CGRectMake(uomLbl.frame.origin.x, 0, uomLbl.frame.size.width,  hlcell.frame.size.height);
                
                itemAvlQty.frame = CGRectMake(avlQtyLbl.frame.origin.x, 0, avlQtyLbl.frame.size.width, hlcell.frame.size.height);
                
                itemPriceLbl.frame = CGRectMake(priceLbl.frame.origin.x, 0, priceLbl.frame.size.width,  hlcell.frame.size.height);
                
                returnQtyTxt.frame = CGRectMake(returnQtyLbl.frame.origin.x + 2, 2, returnQtyLbl.frame.size.width - 4,  36);
                
                itemValueLbl.frame = CGRectMake(valueLbl.frame.origin.x, 0, valueLbl.frame.size.width,  hlcell.frame.size.height);
                
                reasonsTxt.frame = CGRectMake(reasonLbl.frame.origin.x + 2, 2, reasonLbl.frame.size.width - 4, 36);
                
                // added by roja on 23-07-2018...
                batchNoTxt.frame = CGRectMake(batchNo.frame.origin.x +2 , 2, batchNo.frame.size.width - 4 , 36);
                
                expiryDateTxt.frame = CGRectMake(expiryDate.frame.origin.x +2, 2, expiryDate.frame.size.width - 4, 36);
                
                scanCodeTxt.frame = CGRectMake(scanCode.frame.origin.x +2, 2, scanCode.frame.size.width - 4, 36);
                
                // changed by roja
                delRowBtn.frame = CGRectMake(scanCode.frame.origin.x + scanCode.frame.size.width + 10, 2, 35, 35);
                
                
            }
            else{
                
            }
        }
        else{
            
        }
        
        itemNoLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        itemIdLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        itemDescLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        itemEanLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        itemUomLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        itemAvlQty.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        itemPriceLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        returnQtyTxt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        itemValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        reasonsTxt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        // added by roja on 23-07-2018...
        batchNoTxt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        expiryDateTxt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        scanCodeTxt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

        
        returnQtyTxt.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
        reasonsTxt.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
        
        // added by roja on 23-07-2018...
        batchNoTxt.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
        expiryDateTxt.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
        scanCodeTxt.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;

        @try {
            
            NSDictionary * temp = rawMaterialDetails[indexPath.row];
            
            itemNoLbl.text = [NSString stringWithFormat:@"%i", (int)(indexPath.row + 1) ];
            
            itemIdLbl.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:ITEM_SKU] defaultReturn:@""];
            
            itemDescLbl.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:ITEM_DESCRIPTION] defaultReturn:@""];
            
            
            if ([[temp valueForKey:EAN]isKindOfClass:[NSNull class]]|| (![[temp valueForKey:EAN]isEqualToString:@""])) {
                
                itemEanLbl.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:EAN] defaultReturn:@""];
            }
            else
                itemEanLbl.text = @"--";
            
            
            if ([[temp valueForKey:UOM]isKindOfClass:[NSNull class]]|| (![[temp valueForKey:UOM]isEqualToString:@""])) {
                
                itemUomLbl.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:UOM] defaultReturn:@""];
            }
            else
                itemUomLbl.text = @"--";
            
            itemAvlQty.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[temp valueForKey:AVL_QTY] defaultReturn:@""]  floatValue]];
            
            returnQtyTxt.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[temp valueForKey:QUANTITY] defaultReturn:@""]  floatValue]];
            
            itemPriceLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[temp valueForKey:kPrice] defaultReturn:@""]  floatValue]];
            itemValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[temp valueForKey:VALUE] defaultReturn:@""]  floatValue]];
           
            reasonsTxt.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:kReasonForReturn] defaultReturn:@""];
            
            // added by roja on 23-07-2018...
            batchNoTxt.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:PRODUCT_BATCH_NO] defaultReturn:@"--"];
            expiryDateTxt.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:EXPIRY_DATE] defaultReturn:@"--"];
            scanCodeTxt.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:ITEM_SCAN_CODE] defaultReturn:@"--"];


        } @catch (NSException *exception) {
            
        }
        
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        hlcell.backgroundColor = [UIColor clearColor];
        return hlcell;
    }
    
    else if(tableView == nextActivityTbl) {
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (hlcell == nil) {
            hlcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
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
            hlcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
            hlcell.frame = CGRectZero;
        }
        
        
        if ((hlcell.contentView).subviews){
            for (UIView *subview in (hlcell.contentView).subviews) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:20];
            }
        }
        
        hlcell.textLabel.text = shipmodeList[indexPath.row];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:18];
        
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
                
            } @catch (NSException * exception) {
                
            }
            hlcell.backgroundColor = [UIColor clearColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            return hlcell;
        }
        @catch (NSException * exception) {
            
        }
    }
    
    else if (tableView == priceTable) {
        
        static NSString * hlCellID = @"hlCellID";
        
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
            
            UILabel *desc_Lbl = [[UILabel alloc] init] ;
            desc_Lbl.layer.borderWidth = 1.5;
            desc_Lbl.font = [UIFont systemFontOfSize:13.0];
            desc_Lbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:13];
            desc_Lbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            desc_Lbl.backgroundColor = [UIColor blackColor];
            desc_Lbl.textColor = [UIColor whiteColor];
            desc_Lbl.textAlignment=NSTextAlignmentCenter;
            
            UILabel *mrpPrice = [[UILabel alloc] init] ;
            mrpPrice.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            mrpPrice.layer.borderWidth = 1.5;
            mrpPrice.backgroundColor = [UIColor blackColor];
            mrpPrice.textAlignment = NSTextAlignmentCenter;
            mrpPrice.numberOfLines = 2;
            mrpPrice.textColor = [UIColor whiteColor];
            
            UILabel *price = [[UILabel alloc] init] ;
            price.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            price.layer.borderWidth = 1.5;
            price.backgroundColor = [UIColor blackColor];
            price.textAlignment = NSTextAlignmentCenter;
            price.numberOfLines = 2;
            price.textColor = [UIColor whiteColor];
            
            desc_Lbl.text = [dic valueForKey:kDescription];
            mrpPrice.text = [NSString stringWithFormat:@"%.2f",[[dic valueForKey:SALE_PRICE] floatValue]];
            price.text = [NSString stringWithFormat:@"%.2f",[[dic valueForKey:kPrice] floatValue]];
            
            
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
                    
                    desc_Lbl.frame = CGRectMake(descLabl.frame.origin.x, 0, descLabl.frame.size.width+2, hlcell.frame.size.height);
                    
                    mrpPrice.frame = CGRectMake(mrpLbl.frame.origin.x,0, mrpLbl.frame.size.width + 2,  hlcell.frame.size.height);
                    
                    price.frame = CGRectMake(priceLabl.frame.origin.x,0, priceLabl.frame.size.width + 2, hlcell.frame.size.height);
                    
                    [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:16.0f cornerRadius:3.0f];
                }
                else {
                    //skid.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:22];
                    desc_Lbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:22];
                    desc_Lbl.frame = CGRectMake(5, 0, 125, 56);
                    price.font = [UIFont fontWithName:TEXT_FONT_NAME size:18];
                    price.frame = CGRectMake(130, 0, 125, 56);
                }
            }
            else {
                
                desc_Lbl.frame = CGRectMake(10, 0, 100, 34);
                price.frame = CGRectMake(120, 0, 90, 34);
            }
            
            hlcell.backgroundColor = [UIColor clearColor];
            [hlcell.contentView addSubview:desc_Lbl];
            [hlcell.contentView addSubview:price];
            [hlcell.contentView addSubview:mrpPrice];
            
        }
        @catch (NSException *exception) {
            
        }
        return hlcell;
        
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    //dismissing the catPopOver.......
    [catPopOver dismissPopoverAnimated:YES];
    
    if (tableView == skListTable) {
        
        //Changes Made Bhargav.v on 11/05/2018...
        //Changed The Parameter to Plucode While sending the RequestString to SkuDetails...
        //Reason:Making the plucode Search instead of searching skuid to avoid Price List...
        
        NSDictionary * detailsDic = rawMaterials[indexPath.row];
        
        NSString * inputServiceStr = [NSString stringWithFormat:@"%@",detailsDic[sku_ID]];
        
        if (([detailsDic.allKeys containsObject:PLU_CODE]) && (![[detailsDic valueForKey:PLU_CODE] isKindOfClass:[NSNull class]])) {
            
            inputServiceStr = [NSString stringWithFormat:@"%@",detailsDic[PLU_CODE]];
        }
        
        [self callRawMaterialDetails:inputServiceStr];
        
        searchItem.text = @"";
    }
    else if(tableView == nextActivityTbl){
        
        @try {
            if(indexPath.row == 0)
                actionReqTxt.text = @"";
            else
                actionReqTxt.text = nextActivitiesArr[indexPath.row];
            
            [catPopOver dismissPopoverAnimated:YES];
            
            
        } @catch (NSException *exception) {
            
            NSLog(@"---exception changing the textField text in didSelectRowAtIndexPath:----%@",exception);
        }
    }
    else if (tableView == shipModeTable) {
        [catPopOver dismissPopoverAnimated:YES];
        shipmentMode.text = shipmodeList[indexPath.row];
        shipModeTable.hidden = YES;
    }
    /// Code for priceTable.......
    
    else if (tableView == priceTable) {
        
        @try {
            
            transparentView.hidden = YES;
            
            NSDictionary * detailsDic = priceArr[indexPath.row];
            
            status = FALSE;
            
            int i = 0;
            NSMutableDictionary *dic;
            
            for ( i=0; i<rawMaterialDetails.count;i++) {
                
                dic = rawMaterialDetails[i];
                if ([[dic valueForKey:ITEM_SKU] isEqualToString:[detailsDic valueForKey:ITEM_SKU]] && [[dic valueForKey:PLU_CODE] isEqualToString:[detailsDic valueForKey:PLU_CODE]]) {
                    [dic setValue:[NSString stringWithFormat:@"%d",[[dic valueForKey:QUANTITY] intValue] + 1] forKey:QUANTITY];
                    
                    rawMaterialDetails[i] = dic;
                    
                    status = TRUE;
                    
                    break;
                }
            }
            
            if (!status) {
                
                
                NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc] init];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_SKU];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_ID];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESCRIPTION];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:kPrice] defaultReturn:@"0.00"] floatValue]] forKey:kPrice];
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:SALE_PRICE] defaultReturn:@"0.00"] floatValue]] forKey:SALE_PRICE];
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:COST] defaultReturn:@"0.00"] floatValue]] forKey:COST];
                
                //setting availiable qty....
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:AVL_QTY];
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:VALUE];
                
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:QUANTITY];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:EAN] defaultReturn:@""] forKey:EAN];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:SELL_UOM] defaultReturn:@""] forKey:UOM];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:kBrand] defaultReturn:@""] forKey:kBrand];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:MEASUREMENT_RANGE] defaultReturn:@""] forKey:MEASUREMENT_RANGE];
                
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:kComments] defaultReturn:@""] forKey:kComments];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:kReasonForReturn] defaultReturn:@""] forKey:kReasonForReturn];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[detailsDic valueForKey:kReturnNoteRef] defaultReturn:@""] forKey:kReturnNoteRef];
                
                [rawMaterialDetails addObject:itemDetailsDic];
                
            }
            
            cartTable.hidden =  NO;
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
            [self calculateTotal];
            
            [cartTable reloadData];
        }
    }
}

#pragma -mark Del Method..

/**
 * @description
 * @date
 * @method
 * @author
 * @param
 * @return
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 *
 */

- (void) delRow:(UIButton*) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    @try {
        
        if(rawMaterialDetails.count >= sender.tag){
            
            
            [rawMaterialDetails removeObjectAtIndex:sender.tag];
            [cartTable reloadData];
            
        }
        
    } @catch (NSException *exception) {
        NSLog(@"%li",(long)sender.tag);
    } @finally {
        
    }
}

/**
 * @description
 * @date
 * @method
 * @author
 * @param
 * @return
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 *
 */

-(void)closePriceView:(UIButton *)sender {
    
    transparentView.hidden = YES;
}

#pragma -mark calculationTotal

/**
 * @description    here we are calculating the Totalprice of order..........
 * @requestDteFld  27/09/2016
 * @method         calculateTotal
 * @author         Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)calculateTotal{
    
    @try {
        float returnQuantity = 0.0;
        float totalAmount = 0.0;
        
        for(NSDictionary *dic in rawMaterialDetails){
            
            returnQuantity +=  [[dic valueForKey:QUANTITY] floatValue];
            totalAmount    +=  [[dic valueForKey:VALUE] floatValue];
        }
        
        returnQtyValueLbl.text = [NSString stringWithFormat:@"%.2f",returnQuantity];
        totalvalueLbl.text = [NSString stringWithFormat:@"%.2f",totalAmount];
        
    } @catch (NSException *exception) {
        NSLog(@"------exception in while calculating the totalValue-----%@",exception);
        
    } @finally {
        
    }
    
}

#pragma mark keyBoard Delegates.

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
 */

-(void)setViewMovedUp:(BOOL)movedUp {
    
    @try {
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3]; // if you want to slide up the view
        
        CGRect rect = self.view.frame;
        
        //CGRect rect = scrollView.frame;
        
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
        //scrollView.frame = rect;
        
        [UIView commitAnimations];
        
        /* offSetViewTo = 80;
         [self keyboardWillShow];*/
        
    } @catch (NSException *exception) {
        NSLog(@"----exception while changing frame self.view-----%@",exception);
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
        
        [self displayAlertMessage:mesg horizontialAxis:submitBtn.frame.origin.x+submitBtn.frame.size.width+10 verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil) conentWidth:260 contentHeight:100  isSoundRequired:YES timing:3.0 noOfLines:1];
    }
    @finally {
        [HUD setHidden:YES];
        
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
        
    } @catch (NSException * exception) {
        
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

#pragma -mark reusableMethods.......
/**
 * @description  Displaying th PopUp's and reloading table if popUp is vissiable.....
 * @date         21/09/2016
 * @method       showPopUpForTables:-- popUpWidth:-- popUpHeight:-- presentPopUpAt:-- showViewIn:--
 * @author       Srinivasulu
 * @param        UITableView
 * @param        float
 * @param        float
 * @param        id
 * @param        id
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
        
        return returnStirng;
    }
}



#pragma -mark method used to display alert

/**
 * @description  adding the  alertMessage's based on input
 * @date         18/11/2016
 * @method       displayAlertMessage
 * @author       Bhargav
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

-(void)displayAlertMessage:(NSString *)message    horizontialAxis:(float)xPostion  verticalAxis:(float)yPosition msgType:(NSString *)messageType   conentWidth:(float )labelWidth contentHeight:(float)labelHeight   isSoundRequired:(BOOL)soundStatus  timing:(float)noOfSecondsToDisplay noOfLines:(int)noOfLines{
    
    
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
        userAlertMessageLbl.textAlignment = NSTextAlignmentLeft;
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
            
            if(searchItem.isEditing)
                yPosition = searchItem.frame.origin.y + searchItem.frame.size.height;
            
            
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
        
        NSLog(@"----%@",exception);
        NSLog(@"----%@",exception);
        
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
            
            //ViewGoodsReturn *home = [[ViewGoodsReturn alloc]init];
            //[self.navigationController pushViewController:home animated:YES];
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


/**
 * @description
 * @date
 * @method
 * @author
 * @param
 * @return
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 *
 */

-(void)cancelButtonPressed:(UIButton *)sender {
    @try {
        AudioServicesPlaySystemSound(soundFileObject);
        
        [self backAction];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

#pragma -mark superClass methods....

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
