//
//  ReceiptGoodsProcurement.m
//  OmniRetailer
//  Created by Chandrasekhar on 2/19/15.

#import "GoodsReturn.h"
#import "RawMaterialServiceSvc.h"
#import "StockReceiptServiceSvc.h"
#import "StockReturnServiceSvc.h"
#import "ViewGoodsReturn.h"
#import "Global.h"
#import "SkuServiceSvc.h"
#import "SupplierServiceSvc.h"
#import "purchaseOrdersSvc.h"
#import "RequestHeader.h"

@interface GoodsReturn ()

@end

@implementation GoodsReturn

@synthesize soundFileURLRef,soundFileObject;
@synthesize selectIndex,returnID;


/**
 * @description
 * @date
 * @method
 * @author
 * @param
 * @param
 * @return
 * @modified BY
 * @reason
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)viewDidLoad {
    //Calling the super class method...
    [super viewDidLoad];
    
    //reading the Device Version....
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
    
    fromLocation = [[CustomTextField alloc] init];
    fromLocation.placeholder = NSLocalizedString(@"from_location", nil);
    fromLocation.text = presentLocation;
    fromLocation.delegate = self;
    fromLocation.userInteractionEnabled = NO;
    [fromLocation awakeFromNib];
    
    toLocation = [[CustomTextField alloc] init];
    toLocation.placeholder = NSLocalizedString(@"toLocation", nil);
    toLocation.delegate = self;
    toLocation.userInteractionEnabled = NO;
    [toLocation awakeFromNib];
    
    UIImage * locationImg  = [UIImage imageNamed:@"arrow_1.png"];
    
    UIButton * selectLocationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [selectLocationBtn setBackgroundImage:locationImg forState:UIControlStateNormal];
    [selectLocationBtn addTarget:self
                          action:@selector(populateLocationsTable:) forControlEvents:UIControlEventTouchDown];
    
    shipmentOn = [[CustomTextField alloc] init];
    shipmentOn.placeholder = NSLocalizedString(@"shipment_on", nil);
    shipmentOn.userInteractionEnabled = NO;
    shipmentOn.delegate = self;
    [shipmentOn awakeFromNib];
    
    UIImage *deliveryImg = [UIImage imageNamed:@"Calandar_Icon.png"];
    
    UIButton * selectdateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [selectdateBtn setBackgroundImage:deliveryImg forState:UIControlStateNormal];
    [selectdateBtn addTarget:self action:@selector(showCalenderInPopUp:) forControlEvents:UIControlEventTouchDown];
    selectdateBtn.tag =1;
    
    shippedBy = [[CustomTextField alloc] init];
    shippedBy.placeholder = NSLocalizedString(@"shipped_by", nil);
    shippedBy.delegate = self;
    [shippedBy awakeFromNib];
    
    issueRefNo = [[CustomTextField alloc] init];
    issueRefNo.placeholder = NSLocalizedString(@"issue_ref_no", nil);
    issueRefNo.delegate = self;
    issueRefNo.userInteractionEnabled = NO;
    [issueRefNo awakeFromNib];
    [issueRefNo addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    NSDate *today = [NSDate date];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"dd/MM/yyyy";
    NSString* currentdate = [f stringFromDate:today];
    
    dateOfReturn = [[CustomTextField alloc] init];
    dateOfReturn.text = currentdate;
    dateOfReturn.placeholder = NSLocalizedString(@"date_of_return", nil);
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
    
    UIButton * selectShipmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [selectShipmentBtn setBackgroundImage:locationImg forState:UIControlStateNormal];
    [selectShipmentBtn addTarget:self
                          action:@selector(getShipmentModes:) forControlEvents:UIControlEventTouchDown];
    
    
    returnedBy = [[CustomTextField alloc] init];
    returnedBy.placeholder = NSLocalizedString(@"returned_by", nil);
    returnedBy.delegate = self;
    returnedBy.text = firstName;
    returnedBy.userInteractionEnabled = NO;
    [returnedBy awakeFromNib];
    
    receiptRef = [[CustomTextField alloc] init];
    receiptRef.placeholder = NSLocalizedString(@"receipt_ref", nil);
    receiptRef.clearButtonMode = UITextFieldViewModeWhileEditing;
    receiptRef.autocorrectionType = UITextAutocorrectionTypeNo;
    receiptRef.delegate = self;
    [receiptRef addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [receiptRef awakeFromNib];
    
    
    // getting present date & time ..
    NSDate *time = [NSDate date];
    NSDateFormatter *hours = [[NSDateFormatter alloc] init];
    hours.dateFormat = @" HH:mm:ss";
    NSString* currentTime = [hours stringFromDate:time];
    
    timeOfReturn = [[CustomTextField alloc] init];
    timeOfReturn.text = currentTime;
    timeOfReturn.delegate = self;
    timeOfReturn.userInteractionEnabled = NO;
    [timeOfReturn awakeFromNib];
    
    shipmentCarrier = [[CustomTextField alloc] init];
    shipmentCarrier.placeholder = NSLocalizedString(@"shipment_carrier", nil);
    shipmentCarrier.delegate = self;
    [shipmentCarrier awakeFromNib];
    
    ReceiptID = [[UITextField alloc] init];
    ReceiptID.placeholder = NSLocalizedString(@"Search_Sku_Here", nil);
    ReceiptID.delegate = self;
    [ReceiptID awakeFromNib];
    ReceiptID.clearButtonMode = UITextFieldViewModeWhileEditing;
    ReceiptID.autocorrectionType = UITextAutocorrectionTypeNo;
    ReceiptID.borderStyle = UITextBorderStyleRoundedRect;
    ReceiptID.textColor = [UIColor blackColor];
    ReceiptID.layer.borderColor = [UIColor clearColor].CGColor;
    ReceiptID.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    [ReceiptID addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
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
    
    //Allocation of receiptIDTable...
     receiptIDTable = [[UITableView alloc] init];
    
    //Allocation of issueIdsTbl...
    issueIdsTable = [[UITableView alloc] init];
    
    //Allocation of skListTable...
    skListTable = [[UITableView alloc] init];
    
    // Table for storing the items ..
    cartTable = [[UITableView alloc] init];
    cartTable.backgroundColor = [UIColor blackColor];
    cartTable.dataSource = self;
    cartTable.delegate = self;
    cartTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    cartTable.userInteractionEnabled = TRUE;
    
    submitBtn = [[UIButton alloc] init] ;
    submitBtn.backgroundColor = [UIColor grayColor];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 5.0f;
    [submitBtn addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchDown];
    submitBtn.tag = 4;
    
    saveButton = [[UIButton alloc] init] ;
    saveButton.backgroundColor = [UIColor grayColor];
    saveButton.layer.masksToBounds = YES;
    saveButton.layer.cornerRadius = 5.0f;
    [saveButton addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchDown];
    saveButton.tag = 2;
    
    cancelButton = [[UIButton alloc] init];
    [cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchDown];
    cancelButton.layer.cornerRadius = 3.0f;
    cancelButton.backgroundColor = [UIColor grayColor];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    
    submitBtn.userInteractionEnabled = YES;
    saveButton.userInteractionEnabled = YES;
    cancelButton.userInteractionEnabled = YES;
    
    //creation of price view..
    priceTable = [[UITableView alloc] init];
    priceTable.backgroundColor = [UIColor blackColor];
    priceTable.dataSource = self;
    priceTable.delegate = self;
    priceTable.layer.cornerRadius = 3;
    
    //Creation of Location Table..
    locationTable = [[UITableView alloc] init];
    
    //Creation of shipModeTable...
    shipModeTable = [[UITableView alloc] init];
    
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
    
    @try {
        
        //setting the titleName for the Page....
        
        self.titleLabel.text = NSLocalizedString(@"omni_retailer", nil);
        
        HUD.labelText = NSLocalizedString(@"please_wait..", nil);
        
        headerNameLbl.text = NSLocalizedString(@"new_stock_return",nil);

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

        [submitBtn setTitle:NSLocalizedString(@"submit",nil) forState:UIControlStateNormal];
        [saveButton setTitle:NSLocalizedString(@"save",nil) forState:UIControlStateNormal];
        [cancelButton setTitle:NSLocalizedString(@"cancel",nil) forState:UIControlStateNormal];
        
    } @catch (NSException *exception) {
        
    }
    
    
    [goodsReturnView addSubview:headerNameLbl];
    
    [goodsReturnView addSubview:summaryInfoBtn];
    [goodsReturnView addSubview:fromLocation];
    [goodsReturnView addSubview:toLocation];
    [goodsReturnView addSubview:selectLocationBtn];
    
    [goodsReturnView addSubview:shipmentOn];
    [goodsReturnView addSubview:selectdateBtn];
    
    [goodsReturnView addSubview:shippedBy];
    
    [goodsReturnView addSubview:issueRefNo];
    [goodsReturnView addSubview:dateOfReturn];
    [goodsReturnView addSubview:selctDateOfReturnBtn];
    
    [goodsReturnView addSubview:shipmentMode];
    [goodsReturnView addSubview:selectShipmentBtn];
    
    [goodsReturnView addSubview:returnedBy];
    [goodsReturnView addSubview:remarks];
    
    [goodsReturnView addSubview:receiptRef];
    [goodsReturnView addSubview:timeOfReturn];
    [goodsReturnView addSubview:shipmentCarrier];
    
    [goodsReturnView addSubview:ReceiptID];
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
    [stockReturnScrollView addSubview:cartTable];
    // added by roja on 23-07-2018...
    [stockReturnScrollView addSubview:batchNo];
    [stockReturnScrollView addSubview:expiryDate];
    [stockReturnScrollView addSubview:scanCode];

    
    [goodsReturnView addSubview:returnQtyValueLbl];
    [goodsReturnView addSubview:totalvalueLbl];
    
    [goodsReturnView addSubview:submitBtn];
    [goodsReturnView addSubview:saveButton];
    [goodsReturnView addSubview:cancelButton];
    
    //adding price list view for the Stock Return View...
    
    [priceView addSubview:descLabl];
    [priceView addSubview:mrpLbl];
    [priceView addSubview:priceLabl];
    
    [priceView addSubview:priceTable];
    
    [transparentView addSubview:closeBtn];
    
    [transparentView addSubview:priceView];
    
    [self.view addSubview:goodsReturnView];

    [self.view addSubview:transparentView];

    if (currentOrientation==UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            //setting frame for the main view..
            goodsReturnView.frame = CGRectMake(2,70,self.view.frame.size.width - 4, self.view.frame.size.height - 80);
            
            //setting frame for the headerNameLbl..
            headerNameLbl.frame = CGRectMake(0,0,goodsReturnView.frame.size.width, 45);
            
            float textFieldWidth = 180;
            float horizontalGap  = 25;
            
            fromLocation.frame = CGRectMake(10, headerNameLbl.frame.origin.y + headerNameLbl.frame.size.height + 10, textFieldWidth, 40);
            
            toLocation.frame = CGRectMake(fromLocation.frame.origin.x+fromLocation.frame.size.width+horizontalGap, fromLocation.frame.origin.y , textFieldWidth, 40);
            
            selectLocationBtn.frame = CGRectMake((toLocation.frame.origin.x+toLocation.frame.size.width-45), toLocation.frame.origin.y-8, 55, 60);
            
            shipmentOn.frame = CGRectMake(toLocation.frame.origin.x+toLocation.frame.size.width+horizontalGap, fromLocation.frame.origin.y , textFieldWidth, 40);
            
            selectdateBtn.frame = CGRectMake((shipmentOn.frame.origin.x+shipmentOn.frame.size.width-45), shipmentOn.frame.origin.y+2, 40, 35);
            
            shippedBy.frame = CGRectMake(shipmentOn.frame.origin.x+shipmentOn.frame.size.width+horizontalGap, fromLocation.frame.origin.y , textFieldWidth, 40);
            
            //column 2
            
            receiptRef.frame = CGRectMake(fromLocation.frame.origin.x, fromLocation.frame.origin.y+fromLocation.frame.size.height+10 , textFieldWidth, 40);
            
            issueRefNo.frame = CGRectMake(fromLocation.frame.origin.x, receiptRef.frame.origin.y+receiptRef.frame.size.height+10 , textFieldWidth, 40);
            
            dateOfReturn.frame = CGRectMake(toLocation.frame.origin.x,receiptRef.frame.origin.y , textFieldWidth, 40);
            
            selctDateOfReturnBtn.frame = CGRectMake((dateOfReturn.frame.origin.x+dateOfReturn.frame.size.width-45), dateOfReturn.frame.origin.y+2, 40, 35);
            
            shipmentMode.frame = CGRectMake(shipmentOn.frame.origin.x,receiptRef.frame.origin.y , textFieldWidth, 40);
            
            selectShipmentBtn.frame = CGRectMake((shipmentMode.frame.origin.x+shipmentMode.frame.size.width-45), shipmentMode.frame.origin.y-8, 55, 60);
            
            
            //column 3
            
            timeOfReturn .frame = CGRectMake(dateOfReturn.frame.origin.x,issueRefNo.frame.origin.y , textFieldWidth, 40);
            
            shipmentCarrier .frame = CGRectMake(shippedBy.frame.origin.x,shipmentMode.frame.origin.y , textFieldWidth, 40);

            //column 4
            returnedBy.frame = CGRectMake(shippedBy.frame.origin.x+shippedBy.frame.size.width+horizontalGap,shippedBy.frame.origin.y , textFieldWidth, 40);
            
            remarks.frame = CGRectMake(returnedBy.frame.origin.x,shipmentCarrier.frame.origin.y , textFieldWidth, 40);

            //receiptID frame:
            ReceiptID.frame = CGRectMake(issueRefNo.frame.origin.x, issueRefNo.frame.origin.y+issueRefNo.frame.size.height+15, returnedBy.frame.origin.x+returnedBy.frame.size.width-(issueRefNo.frame.origin.x+80), 40);
            
            selectCategoriesBtn.frame = CGRectMake((ReceiptID.frame.origin.x+ReceiptID.frame.size.width + 5),ReceiptID.frame.origin.y,75,ReceiptID.frame.size.height);
            
            //Frame for the StockReturnScrollView....
            // width value changed by roja
            stockReturnScrollView.frame = CGRectMake(ReceiptID.frame.origin.x,ReceiptID.frame.origin.y + ReceiptID.frame.size.height +5,ReceiptID.frame.size.width+180,380);
            

            //stockScrollView.contentSize = CGSizeMake( tableLabelsHeaderView.frame.origin.x + tableLabelsHeaderView.frame.size.width, stockScrollView.frame.size.height);

            

            //Frame for the CustomLabels
            sNoLbl.frame = CGRectMake(0,0, 50, 35);
            
            sKuidLbl.frame = CGRectMake((sNoLbl.frame.origin.x + sNoLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 100, 35);
            
            descLbl.frame = CGRectMake((sKuidLbl.frame.origin.x + sKuidLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 140, 35);
            
            eanLbl.frame = CGRectMake((descLbl.frame.origin.x + descLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 100, 35);
            
            uomLbl.frame = CGRectMake((eanLbl.frame.origin.x + eanLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 80, 35);
            
            avlQtyLbl.frame = CGRectMake((uomLbl.frame.origin.x + uomLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 80, 35);
            
            priceLbl.frame = CGRectMake((avlQtyLbl.frame.origin.x + avlQtyLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 70, 35);
            
            returnQtyLbl.frame = CGRectMake((priceLbl.frame.origin.x + priceLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 90, 35);

            valueLbl.frame = CGRectMake((returnQtyLbl.frame.origin.x + returnQtyLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 80, 35);
            
            reasonLbl.frame = CGRectMake((valueLbl.frame.origin.x + valueLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 135, 35);
         
            // added by roja on 23-07-2018...
            batchNo.frame = CGRectMake ((reasonLbl.frame.origin.x + reasonLbl.frame.size.width + 2), sNoLbl.frame.origin.y, 130, 35);

            expiryDate.frame = CGRectMake ((batchNo.frame.origin.x + batchNo.frame.size.width + 2), sNoLbl.frame.origin.y, 130, 35);

            scanCode.frame = CGRectMake ((expiryDate.frame.origin.x + expiryDate.frame.size.width + 2), sNoLbl.frame.origin.y, 130, 35);

            actionLbl.frame = CGRectMake((scanCode.frame.origin.x + scanCode.frame.size.width + 2), sNoLbl.frame.origin.y, 55, 35);
            
            cartTable.frame = CGRectMake(0,sNoLbl.frame.origin.y+sNoLbl.frame.size.height + 5,actionLbl.frame.origin.x+actionLbl.frame.size.width + 120 -(sNoLbl.frame.origin.x),stockReturnScrollView.frame.size.height-(sNoLbl.frame.origin.y+sNoLbl.frame.size.height));
            
            stockReturnScrollView.contentSize = CGSizeMake(cartTable.frame.size.width,  stockReturnScrollView.frame.size.height);
           // upto here changed by roja on 23-07-2018..
            
            
            // frame for the UIButtons...
            submitBtn.frame = CGRectMake(ReceiptID.frame.origin.x,goodsReturnView.frame.size.height-45,140,40);
            saveButton.frame = CGRectMake(submitBtn.frame.origin.x+submitBtn.frame.size.width+20,submitBtn.frame.origin.y,140,40);
            cancelButton.frame = CGRectMake(saveButton.frame.origin.x+saveButton.frame.size.width+20,submitBtn.frame.origin.y,140,40);
            
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
    
    
    [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:16.0f cornerRadius:3.0f];
    
    headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];

    submitBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
    saveButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
    cancelButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];

}


/**
 * @description
 * @date
 * @method
 * @author
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

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    @try {
        
        if (returnID != nil) {
            
            [self callingGetStockReturn];
            
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        if (rawMaterialDetails == nil)
            rawMaterialDetails = [NSMutableArray new];
    }
}


/**
 * @description  here we are calling searchSku.......
 * @date         01/12/2017..
 * @method       callRawMaterials
 * @author       Bhargav Ram
 * @param        NSString
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

-(void)callRawMaterials:(NSString *)searchString {
    
    @try {
        [HUD show:YES];
        [HUD setHidden:NO];
        
        //productList  =[NSMutableArray new];
        
        NSMutableDictionary * searchProductDic = [[NSMutableDictionary alloc] init];
        
        searchProductDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        searchProductDic[START_INDEX] = @"0";
        searchProductDic[kSearchCriteria] = ReceiptID.text;
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
        
        //float y_axis = self.view.frame.size.height - 120;
        
        //NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        //[self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:400 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    }
    
}
#pragma -mark start of handling service call reponses

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
        if (successDictionary != nil && (ReceiptID.tag == (ReceiptID.text).length) ) {
            
            
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
                
                [self showPopUpForTables:skListTable  popUpWidth:ReceiptID.frame.size.width  popUpHeight:tableHeight presentPopUpAt:ReceiptID  showViewIn:goodsReturnView permittedArrowDirections:UIPopoverArrowDirectionUp];
            }
            else if(catPopOver.popoverVisible)
                [catPopOver dismissPopoverAnimated:YES];
            ReceiptID.tag = 0;
            [HUD setHidden:YES];
        }
        
        else if ( (((ReceiptID.text).length >= 3) && (ReceiptID.tag != 0)) && (ReceiptID.tag != (ReceiptID.text).length)) {
            
            ReceiptID.tag = 0;
            
            [self textFieldDidChange:ReceiptID];
            
        }
        else  if(catPopOver.popoverVisible || (ReceiptID.tag == (ReceiptID.text).length)){
            [catPopOver dismissPopoverAnimated:YES];
            ReceiptID.tag = 0;
            [HUD setHidden:YES];
            
        }
        else {
            
            [catPopOver dismissPopoverAnimated:YES];
            ReceiptID.tag = 0;
            [HUD setHidden:YES];
        }
    }
    
    @catch (NSException * exception) {
        
        if(catPopOver.popoverVisible)
            [catPopOver dismissPopoverAnimated:YES];
        ReceiptID.tag = 0;
        [HUD setHidden:YES];
        
    }
    @finally {
        
        
    }
}
- (void)searchProductsErrorResponse {
    
    @try {
        
        
        [HUD setHidden:YES];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"message", nil) message:NSLocalizedString(@"no_products_found", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
        [alert show];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}


#pragma mark calling search SKU Details:

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
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.getSkuDetailsDelegate = self;
        [webServiceController getSkuDetailsWithData:salesReportJsonString];
        
    }
    @catch (NSException *exception) {
        
        [HUD setHidden: YES];
        
        float y_axis = self.view.frame.size.height - 120;
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:400 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    
    //[HUD hide:YES afterDelay:1.0];
    
}

- (void)getSkuDetailsSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        if (successDictionary != nil) {
            
            priceArr = [[NSMutableArray alloc]init];
            NSArray *price_arr = [successDictionary valueForKey:kSkuLists];
            
            for (int i = 0; i<price_arr.count; i++) {
                
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
                NSMutableDictionary * isExistingItemsDic;
                
                for ( i=0; i<rawMaterialDetails.count;i++) {
                    NSArray *itemArray = [successDictionary valueForKey:kSkuLists];
                    if (itemArray.count > 0) {
                        NSDictionary * itemdic = itemArray[0];
                        isExistingItemsDic = rawMaterialDetails[i];
                        if ([[isExistingItemsDic valueForKey:ITEM_SKU] isEqualToString:[itemdic valueForKey:ITEM_SKU]] && [[isExistingItemsDic valueForKey:PLU_CODE] isEqualToString:[itemdic valueForKey:PLU_CODE]]) {
                            [isExistingItemsDic setValue:[NSString stringWithFormat:@"%d",[[isExistingItemsDic valueForKey:QUANTITY] intValue] + 1] forKey:QUANTITY];
                            
                            rawMaterialDetails[i] = isExistingItemsDic;
                            
                            Status = TRUE;
                            break;
                        }
                    }
                }
                
                if (!Status) {
                    
                    NSArray * itemArray = [successDictionary valueForKey:kSkuLists];
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
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:RECEIVED_QTY];

                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:VALUE];
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:QUANTITY];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:EAN] defaultReturn:@""] forKey:EAN];

                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];

                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];


                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];

                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kBrand] defaultReturn:@""] forKey:kBrand];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:MEASUREMENT_RANGE] defaultReturn:@""] forKey:MEASUREMENT_RANGE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kComments] defaultReturn:@""] forKey:kComments];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kReasonForReturn] defaultReturn:@""] forKey:kReasonForReturn];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kReturnNoteRef] defaultReturn:@""] forKey:kReturnNoteRef];

                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:TRACKING_REQUIRED] defaultReturn:ZERO_CONSTANT] forKey:TRACKING_REQUIRED];
                        
                        [itemDetailsDic setValue:EMPTY_STRING forKey:ITEM_SCAN_CODE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:UTILITY] defaultReturn:@""] forKey:UTILITY];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
                       
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:SELL_UOM] defaultReturn:@""] forKey:UOM];


                        [rawMaterialDetails addObject:itemDetailsDic];
                    }
                    
                    else
                        rawMaterialDetails[i] = isExistingItemsDic;
                    
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
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:400 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:1];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
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
                            
                            if ([[existItemdic valueForKey:ITEM_SKU] isEqualToString:[newSkuPriceListDic valueForKey:ITEM_SKU]] && [[existItemdic valueForKey:PLU_CODE] isEqualToString:[newSkuPriceListDic valueForKey:PLU_CODE]]) {
                                
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
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:UTILITY] defaultReturn:@""] forKey:UTILITY];

                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:TRACKING_REQUIRED] defaultReturn:ZERO_CONSTANT] forKey:TRACKING_REQUIRED];
                            
                            [itemDetailsDic setValue:EMPTY_STRING forKey:ITEM_SCAN_CODE];

                            // added by roja on 20-07-2018..
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:RECEIVED_QTY];
                            
                            
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
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:TRACKING_REQUIRED] defaultReturn:ZERO_CONSTANT] forKey:TRACKING_REQUIRED];
                       
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:UTILITY] defaultReturn:@""] forKey:UTILITY];

                        [itemDetailsDic setValue:EMPTY_STRING forKey:ITEM_SCAN_CODE];

                        [rawMaterialDetails addObject:itemDetailsDic];
                    }
                }
            }
            
            float y_axis = self.view.frame.size.height - 120;
            
            if(ReceiptID.isEditing)
                y_axis = ReceiptID.frame.origin.y + ReceiptID.frame.size.height;
            
            NSString * mesg = [NSString stringWithFormat:@"%d%@",totalRecords,NSLocalizedString(@"records_are_added_to_the_cart_successfully", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"cart_records", nil) conentWidth:400 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:1];

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
        
        if(ReceiptID.isEditing)
            
            y_axis = ReceiptID.frame.origin.y + ReceiptID.frame.size.height;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@"" conentWidth:400 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
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
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:400 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
        
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
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2  verticalAxis:y_axis  msgType:@"" conentWidth:400 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
        
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
        
        categoriesView = [[UIView alloc] initWithFrame:CGRectMake(selectCategoriesBtn.frame.origin.x,ReceiptID.frame.origin.y,300,350)];
        categoriesView.opaque = NO;
        categoriesView.backgroundColor = [UIColor blackColor];
        categoriesView.layer.borderColor = [[UIColor whiteColor]colorWithAlphaComponent:0.6].CGColor;
        categoriesView.layer.borderWidth =2.0f;
        [categoriesView setHidden:NO];
        
        
        /*Creation of UILabel for headerDisplay.......*/
        //creating line  UILabel which will display at topOfThe  billingView.......
        
        UILabel  * headerNameLbl;
        CALayer  * bottomBorder;
        UIImage  * checkBoxImg;
        UILabel  * selectAllLbl;
        UIButton * okButton;
        UIButton * cancelBtn;
        
        headerNameLbl = [[UILabel alloc] init];
        headerNameLbl.layer.cornerRadius = 10.0f;
        headerNameLbl.layer.masksToBounds = YES;
        headerNameLbl.text = NSLocalizedString(@"categories_list",nil);
        
        headerNameLbl.textAlignment = NSTextAlignmentCenter;
        headerNameLbl.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
        headerNameLbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gradient.png"]];
        
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
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:400 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @finally {
        [HUD setHidden:YES];
        
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

-(void)getCategoryErrorResponse:(NSString*)errorResponse {
    
    @try {
        
        [HUD setHidden:YES];
        
        //float y_axis = self.view.frame.size.height - 120;
        
        //NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        //[self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2  verticalAxis:y_axis  msgType:@"" conentWidth:400 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
        
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
                
                [self displayAlertMessage:NSLocalizedString(@"please_select_atleast_one_category",nil) horizontialAxis:(self.view.frame.size.width - 360)/2  verticalAxis:y_axis  msgType:@""  conentWidth:400 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
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
            
            //float y_axis = self.view.frame.size.height - 120;
            
            //NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request",nil)];
            
            //[self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:400 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:1];
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



#pragma mark calling get locations

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

-(void)getLocations:(int)selectIndex businessActivity:(NSString *)businessActivity{
    
    @try {
        [HUD show:YES];
        [HUD setHidden: NO];
        
        locationArr = [NSMutableArray new];
        NSArray *loyaltyKeys = @[START_INDEX,REQUEST_HEADER,BUSSINESS_ACTIVITY];
        
        NSArray *loyaltyObjects = @[@"0",[RequestHeader getRequestHeader],@""];
        
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
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

-(void)getLocationSuccessResponse:(NSDictionary *)successDictionary {
    @try {
        for(NSDictionary *dic in [successDictionary valueForKey:LOCATIONS_DETAILS]){
            if (![[dic valueForKey:LOCATION_ID] isKindOfClass:[NSNull class]] && [[dic valueForKey:LOCATION_ID] caseInsensitiveCompare:presentLocation] != NSOrderedSame) {
                [locationArr addObject:[dic valueForKey:LOCATION_ID]];
                
            }
            if ([locationArr containsObject:presentLocation]) {
                
                [locationArr removeObject:presentLocation];
            }
            
        }
        
    } @catch (NSException *exception) {
        [catPopOver dismissPopoverAnimated:YES];
        
    }
    @finally {
        [HUD setHidden:YES];
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
        
    } @catch (NSException *exception) {
        
    } @finally {
        [catPopOver dismissPopoverAnimated:YES];
        [HUD setHidden:YES];
    }
    
}


#pragma mark Calling Stock Return Details...

/**
 * @description: Calling This method if the Return ID is in Draft Status so that user can submit it to continue the next flow or else he can save
                 the Stock Return even after modifications at item Level....
 * @date       : 19/07/2018
 * @method     : callingGetStockReturn
 * @author     : Bhargav.v
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
        [HUD show:YES];
        
        NSMutableDictionary * stockReturn = [[NSMutableDictionary alloc] init];
        stockReturn[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        stockReturn[kReturnNoteRef] = returnID;
        stockReturn[LOCATIONS] = presentLocation;
        stockReturn[START_INDEX] = [NSString stringWithFormat:@"%d",startIndexInt];
        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:stockReturn options:0 error:&err];
        NSString * quoteRequestJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.stockReturnDelegate = self;
        [webServiceController getStockReturn:quoteRequestJsonString];
        
    }
    @catch (NSException *exception) {
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:400 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:1];
    }
    
    @finally {
        
    }
}


/**
 * @description we are handling the success response to the selected Return ID..
 * @date        19/07/2018
 * @method      getStockReturnSuccessResponse
 * @author      Bhargav.v
 * @param       NSDictionary
 * @return
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 *
 */

-(void)getStockReturnSuccessResponse:(NSDictionary *)successDictionary {
   
    @try {
        
        isDraft = true;
        
        NSMutableDictionary *  updateStockReturnDic  = [[NSMutableDictionary alloc]init];
        
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
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:QUANTITY] defaultReturn:@""] forKey:QUANTITY];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kPrice] defaultReturn:@""] forKey:kPrice];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:VALUE] defaultReturn:@""] forKey:VALUE];
            
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
            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:RECEIVED_QTY] defaultReturn:@"0.00"]  floatValue]] forKey:RECEIVED_QTY];
            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:AVAIL_QTY] defaultReturn:@"0.00"]  floatValue]] forKey:AVL_QTY];

            [rawMaterialDetails addObject:itemDetailsDic];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [HUD setHidden:YES];
        [cartTable reloadData];
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
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:400 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:1];

    }
    @catch (NSException *exception) {
        
    }
    @finally {
        [HUD setHidden:YES];
    }
}



#pragma mark calling StockReceipts:


/**
 * @description   calling the products
 * @requestDteFld 06/10/2016
 * @method        callRawMaterials
 * @author        Bhargav
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callingStockReceipts:(NSString *)searchString {
    
    @try {
        
        [HUD setHidden:NO];
        
        receiptIDS = [NSMutableArray new];
        
        NSArray * keys = @[REQUEST_HEADER,kReceiptLocation,START_INDEX,kGoodsReceiptRef];
        NSArray * objects = @[[RequestHeader getRequestHeader],presentLocation,[NSString stringWithFormat:@"%d",startIndexInt],searchString];
        
        NSDictionary * dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.stockReceiptDelegate = self;
        [webServiceController getStockReceiptIds:salesReportJsonString];
        
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
-(void)getStockReceiptsSuccessResponse:(NSDictionary *)successDictionary {
    @try {
        
        [[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:kTotalReceipts]  defaultReturn:@"0"] integerValue];
        totalNumberOfStockReceipt = [[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:kTotalReceipts]  defaultReturn:@"0"] intValue]  ;
        
        for(NSString *receiptId in [successDictionary valueForKey:kReceiptIds]){
            
            [receiptIDS addObject:receiptId];
        }
        
        if(receiptIDS.count){
            float tableHeight = receiptIDS.count * 40;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = receiptIDS.count * 33;
            
            if(receiptIDS.count > 5)
                tableHeight = (tableHeight/receiptIDS.count) * 5;
            
            [self showPopUpForTables:receiptIDTable  popUpWidth:(receiptRef.frame.size.width * 1.4)  popUpHeight:tableHeight presentPopUpAt:receiptRef  showViewIn:goodsReturnView permittedArrowDirections:UIPopoverArrowDirectionUp];
        }
        else
            [catPopOver dismissPopoverAnimated:YES];

    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [receiptIDTable reloadData];
        [HUD setHidden: YES];
        
    }
}

-(void)getStockReceiptsErrorResponse:(NSString *)errorResponse {
    
    @try {
        
        [HUD setHidden: YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(ReceiptID.isEditing)
            
            y_axis = ReceiptID.frame.origin.y + ReceiptID.frame.size.height;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:400 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        receiptRefNo.text = EMPTY_STRING;

        [receiptIDTable reloadData];
        
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
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */




-(void)callingReceiptDetails:(NSString *)receiptIDString {
    
    @try {
        
        NSMutableDictionary *receiptDetails = [[NSMutableDictionary alloc] init];
        receiptDetails[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        
        receiptDetails[kGoodsReceiptRef] = receiptIDString;
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:receiptDetails options:0 error:&err];
        NSString * getStockReceiptJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.stockReceiptDelegate = self;
        [webServiceController getStockReceiptDetails:getStockReceiptJsonString];
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
}




-(void)getStockReceiptDetailsSuccessResponse:(NSDictionary *)successDictionary {
    @try {
        if ([successDictionary.allKeys containsObject: kReceipt] && [[successDictionary valueForKey:kReceipt] isKindOfClass:[NSDictionary class]] ) {
            
            NSDictionary * locDictionary = [successDictionary valueForKey:kReceipt ];
            
            if ([locDictionary.allKeys containsObject: kIssueReferenceNo] && ![[locDictionary valueForKey:kIssueReferenceNo] isKindOfClass:[NSNull class]]) {
                
                issueRefNo.text = [locDictionary valueForKey:kIssueReferenceNo];
            }
            if ([locDictionary.allKeys containsObject: kShippedFrom] && ![[locDictionary valueForKey:kShippedFrom] isKindOfClass:[NSNull class]]) {
                
                toLocation.text = [locDictionary valueForKey:kShippedFrom];
            }
            if ([locDictionary.allKeys containsObject: kShipmentMode] && ![[locDictionary valueForKey:kShipmentMode] isKindOfClass:[NSNull class]]) {
                
                shipmentMode.text = [locDictionary valueForKey:kShipmentMode];
            }
        }
        
        for (NSDictionary * dic in [successDictionary valueForKey:kItemDetails]) {
            
            NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc] init];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_SKU];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_ID];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESCRIPTION];
            
            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:kPrice] defaultReturn:@"0.00"]  floatValue]] forKey:kPrice];
            
            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:QUANTITY] defaultReturn:@"0.00"]  floatValue]] forKey:AVL_QTY];
            
            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:kReceived] defaultReturn:@"0.00"]  floatValue]] forKey:RECEIVED_QTY];

            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:COST] defaultReturn:@"0.00"]  floatValue]] forKey:COST];
            
            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:kRejected] defaultReturn:@"0.00"] floatValue]] forKey:QUANTITY];  // rejected
            
            float itemTotalValue = [[self checkGivenValueIsNullOrNil:[itemDetailsDic valueForKey:kPrice] defaultReturn:@"0.00"] floatValue] * [[self checkGivenValueIsNullOrNil:[itemDetailsDic valueForKey:QUANTITY] defaultReturn:@"0.00"] floatValue];
            
            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",itemTotalValue] forKey:VALUE];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:SELL_UOM] defaultReturn:@""] forKey:UOM];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:EAN] defaultReturn:@""] forKey:EAN];

            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kBrand] defaultReturn:@""] forKey:kBrand];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:MEASUREMENT_RANGE] defaultReturn:@""] forKey:MEASUREMENT_RANGE];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kComments] defaultReturn:@""] forKey:kComments];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kReasonForReturn] defaultReturn:@""] forKey:kReasonForReturn];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kReturnNoteRef] defaultReturn:@""] forKey:kReturnNoteRef];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:TRACKING_REQUIRED] defaultReturn:ZERO_CONSTANT] forKey:TRACKING_REQUIRED];

            [itemDetailsDic setValue:EMPTY_STRING forKey:ITEM_SCAN_CODE];
           
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:UTILITY] defaultReturn:@""] forKey:UTILITY];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];

            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];

            [rawMaterialDetails addObject:itemDetailsDic];
            
          }
        [cartTable reloadData];
     }
    @catch(NSException *exception) {
    
    }
    @finally {
        
    }
    
}

-(void)getStockReceiptDetailsErrorResponse:(NSString *)errorResponse{
    
    @try {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(ReceiptID.isEditing)
            
            y_axis = ReceiptID.frame.origin.y + ReceiptID.frame.size.height;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:400 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}



#pragma mark populate the methods:

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
            
            [self showPopUpForTables:locationTable  popUpWidth:(toLocation.frame.size.width *1.5) popUpHeight:tableHeight presentPopUpAt:toLocation  showViewIn:goodsReturnView permittedArrowDirections:UIPopoverArrowDirectionUp];
        }
        else
            [catPopOver dismissPopoverAnimated:YES];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
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
-(void)getShipmentModes:(UIButton*)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        shipmodeList = [NSMutableArray new];
        [shipmodeList addObject:NSLocalizedString(@"rail", nil)];
        [shipmodeList addObject:NSLocalizedString(@"flight", nil)];
        [shipmodeList addObject:NSLocalizedString(@"express", nil)];
        [shipmodeList addObject:NSLocalizedString(@"ordinary", nil)];
        
        float tableHeight = shipmodeList.count * 40;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            tableHeight = shipmodeList.count * 33;
        
        if(shipmodeList.count>5)
            tableHeight = (tableHeight/shipmodeList.count) * 5;
        
        [self showPopUpForTables:shipModeTable  popUpWidth:(shipmentMode.frame.size.width)  popUpHeight:tableHeight presentPopUpAt:shipmentMode  showViewIn:goodsReturnView permittedArrowDirections:UIPopoverArrowDirectionUp ];
        
    } @catch (NSException *exception) {
        
    }
}

#pragma mark Service Call for Creating Stock Return:

-(void)submitButtonPressed:(UIButton*)sender {
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
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:400 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:1];
        }
        
        else if ((toLocation.text).length == 0) {
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"please_select_Location",nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:@""  conentWidth:400 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:1];
        }

        else if ((shipmentMode.text).length == 0) {
            
            [self getShipmentModes:sender];
        }
        
        else if ((shipmentOn.text).length == 0) {
            
            UIButton * locDeliveryBtn  = [[UIButton alloc]init];
            locDeliveryBtn.tag = 4;
            
            [self showCalenderInPopUp:locDeliveryBtn];
            
        }
        
        else if (isZeroQty && (saveButton.tag != submitBtn.tag)){
            
            conformationAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"please_verify_zeroQty_items_are_available", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"CONTINUE",nil) otherButtonTitles:NSLocalizedString(@"no",nil), nil];
            conformationAlert.tag = sender.tag;
            [conformationAlert show];
        }
        
        else if (!isZeroQty && (saveButton.tag != submitBtn.tag) ){
            // added by roja on 20-07-2018...
             if(sender.tag == saveButton.tag) {
             
             conformationAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"do_you_want_to_save_this_indent", nil)  message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"yes", nil) otherButtonTitles:NSLocalizedString(@"no", nil) , nil];
             conformationAlert.tag = sender.tag;
             [conformationAlert show];
             }
             else {
             
             conformationAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"do_you_want_to_submit_this_indent", nil)  message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"yes", nil) otherButtonTitles:NSLocalizedString(@"no", nil), nil];
             conformationAlert.tag = sender.tag;
             [conformationAlert show];
             }
        }
        
        else {
            
            @try {
                
                //changed By srinivauslu on 02/05/2018....
                //reason.. Need to stop user internation after servcie calls...
                
                submitBtn.userInteractionEnabled = NO;
                saveButton.userInteractionEnabled = NO;
                //upto here on 02/05/2018....
                
                [HUD show:YES];
                [HUD setHidden:NO];
                
                NSMutableArray * locArr = [NSMutableArray new];
                
                locArr = [rawMaterialDetails copy];
                
                NSMutableDictionary * stockReturnDic = [[NSMutableDictionary alloc]init];
                [stockReturnDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
                [stockReturnDic setValue:fromLocation.text forKey:kFromLocation];
                [stockReturnDic setValue:toLocation.text forKey:kToLocation];
                [stockReturnDic setValue:returnedBy.text forKey:kReturnBy];
                [stockReturnDic setValue:shipmentMode.text forKey:kShipmentMode];
                [stockReturnDic setValue:shipmentCarrier.text forKey:kShipmentCarrier];
                [stockReturnDic setValue:shippedBy.text forKey:KShippedBy];
                [stockReturnDic setValue:EMPTY_STRING forKey:REMARKS];

                if (sender.tag == 2) {
                    [stockReturnDic setValue:DRAFT forKey:STATUS];
                }
                else
                    [stockReturnDic setValue:OPENED forKey:STATUS];
                
                [stockReturnDic setValue:firstName forKey:kUserName];
                [stockReturnDic setValue:roleName forKey:kRoleName];
                

                if((issueRefNo.text).length > 0){
                    stockReturnDic[ISSUE_REF] = issueRefNo.text;
                }
                else {
                    stockReturnDic[ISSUE_REF] = EMPTY_STRING;

                }
                if((receiptRef.text).length > 0){
                    stockReturnDic[kReceiptRef] = receiptRef.text;
                }
                else {
                    stockReturnDic[kReceiptRef] = EMPTY_STRING;
                }
                
                NSString * timeOfReturnStr =timeOfReturn.text  ;
                
                if (timeOfReturnStr.length > 0) {
                    timeOfReturnStr = [NSString stringWithFormat:@"%@%@",timeOfReturn.text,@" HH:mm:ss"];
                }
                [stockReturnDic setValue:timeOfReturnStr forKey:kTimeOfReturnStr];
                
                NSString * dateOfReturnStr = dateOfReturn.text;

                if(dateOfReturnStr.length > 0) {
                    dateOfReturnStr = [NSString stringWithFormat:@"%@%@",dateOfReturn.text,@" 00:00:00"];
                }
                stockReturnDic[kDateOfReturn] = dateOfReturnStr;

                NSString * shippedOnStr = shipmentOn.text;
                if (shippedOnStr.length> 0) {
                    shippedOnStr = [NSString stringWithFormat:@"%@%@",shipmentOn.text,@" 00:00:00"];
                }
                
                stockReturnDic[kShippedOnStr] = shippedOnStr;
                stockReturnDic[STOCK_LIST] = locArr;

                // added by roja on 20-07-2018...
                if (isDraft) {
                    stockReturnDic[kReturnNoteRef] = returnID;
                }
                
                NSError * err;
                NSData * jsonData = [NSJSONSerialization dataWithJSONObject:stockReturnDic options:0 error:&err];
                NSString * createStockReturnJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                
                NSLog(@"%@--json Request String--",createStockReturnJsonString);
                
                WebServiceController * webServiceController = [WebServiceController new];
                
                if (isDraft) {
                   
                    webServiceController.stockReturnDelegate = self;
                    [webServiceController upDateStockReturn:jsonData];
                }
                
                else {
                    
                    webServiceController.stockReturnDelegate = self;
                    [webServiceController createStockReturn:jsonData];

                }
            }
            @catch (NSException *exception) {
                NSLog(@"----exception while we are creating the Stock Return  %@----",exception);
                
            }
            @finally {
                
            }
        }
        
    }
    @catch (NSException *exception) {
        //changed By srinivauslu on 02/05/2018....
        //reason.. Need to stop user internation after servcie calls...
        
        submitBtn.userInteractionEnabled = YES;
        saveButton.userInteractionEnabled = YES;
        [HUD setHidden:YES];
        //upto here on 02/05/2018....
    }
    @finally {
        
    }
    
}

-(void)createStockReturnSuccessResponse:(NSDictionary *)successDictionary {
    
    float y_axis;
    NSString * mesg;
    
    @try {
        
        [HUD setHidden:YES];
        
        
        y_axis = self.view.frame.size.height - 120;
        
        if(ReceiptID.isEditing)
            y_axis = ReceiptID.frame.origin.y + ReceiptID.frame.size.height;
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"stock_return_generated_successfully",nil),@"\n",[successDictionary valueForKey:kReturnNoteRef]];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"SUCCESS", nil)  conentWidth:400 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @catch (NSException * exception) {
        
        mesg = [NSString stringWithFormat:NSLocalizedString(@"stock_return_generated_successfully",nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:400 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @finally {
        
    }
}


-(void)createStockReturnErrorResponse:(NSString *)errorResponse {
    @try {
        
        //changed By srinivauslu on 02/05/2018....
        //reason.. Need to stop user internation after servcie calls...
        
        submitBtn.userInteractionEnabled = YES;
        saveButton.userInteractionEnabled = YES;
        [HUD setHidden:YES];
        [self displayAlertMessage:errorResponse horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:self.view.frame.size.height - 140   msgType:@""  conentWidth:400 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];

        //upto here on 02/05/2018....
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        [HUD setHidden:YES];
    }
}

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
        
        PopOverViewController  * customerInfoPopUp = [[PopOverViewController alloc] init];
        
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
                [popover presentPopoverFromRect:dateOfReturn.frame inView:goodsReturnView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else
                [popover presentPopoverFromRect:shipmentOn.frame inView:goodsReturnView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
            catPopOver= popover;
            
        }
        
        else {
            
            //customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
            
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

-(void)populateDateToTextField:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        [catPopOver dismissPopoverAnimated:YES];
        
        //Date Format Setting...
        NSDateFormatter * requiredDateFormat = [[NSDateFormatter alloc] init];
        //        [requiredDateFormat setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        requiredDateFormat.dateFormat = @"dd/MM/yyyy";
        dateString = [requiredDateFormat stringFromDate:myPicker.date];
        
        
        NSDate * selectedDateString = [requiredDateFormat dateFromString:[requiredDateFormat stringFromDate:myPicker.date]];
        
        NSDate * existingDateString;
        /*z;
         UITextField * endDateTxt;*/
        
        if(sender.tag == 1){
            
            if ((shipmentOn.text).length != 0 && ( ![shipmentOn.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:dateOfReturn.text ];
                
                if ([selectedDateString compare:existingDateString]== NSOrderedAscending) {
                    
                    shipmentOn.text = @"";
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"delivery_date_should_not_be_earlier_than_request_date", nil)  message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
                    [alert show];
                    return;
                }
            }
            shipmentOn.text = dateString;
        }
        else if (sender.tag  == 2) {
            
            if ((dateOfReturn.text).length != 0 && (![dateOfReturn.text isEqualToString:@""])){
                existingDateString = [requiredDateFormat dateFromString:dateOfReturn.text ];
                
                if ([existingDateString compare:selectedDateString]== NSOrderedDescending) {
                    
                    dateOfReturn.text = @"";
                    
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"request_date_should_not_be_earlier_than_present_date", nil)   message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles:nil, nil];
                   
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
    
    
    if (textField.frame.origin.x == returnQtyTxt.frame.origin.x || textField.frame.origin.x  == reasonsTxt.frame.origin.x || textField.frame.origin.x  == batchNoTxt.frame.origin.x  || textField.frame.origin.x  == expiryDateTxt.frame.origin.x || textField.frame.origin.x  == scanCodeTxt.frame.origin.x )
        
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
 */

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    @try {
        
        @try {
            
            if(textField == ReceiptID){
                
                offSetViewTo = 120;
            }
            
            else if (textField.frame.origin.x == returnQtyTxt.frame.origin.x || textField.frame.origin.x  == reasonsTxt.frame.origin.x ||  textField.frame.origin.x  == batchNoTxt.frame.origin.x || textField.frame.origin.x  == expiryDateTxt.frame.origin.x || textField.frame.origin.x  == scanCodeTxt.frame.origin.x) {
                
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
            
            NSLog(@"---- exception in texField: shouldChangeCharactersInRange:replalcement----%@",exception);
            
            return  YES;
        }
    }
    
    return  YES;
}

- (void)textFieldDidChange:(UITextField *)textField {
    
    if (textField == ReceiptID){
        
        if ((textField.text).length >= 3) {
            
            @try {
                
                if (ReceiptID.tag == 0) {
                    
                    ReceiptID.tag = (textField.text).length;
                    
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
            ReceiptID.tag = 0;
            [catPopOver dismissPopoverAnimated:YES];
            
        }
    }
    else if(textField.frame.origin.x == returnQtyTxt.frame.origin.x) {
        
        reloadTableData = true;
        
        NSString * qtyKey = QUANTITY;
        
        NSMutableDictionary * temp = [rawMaterialDetails[textField.tag] mutableCopy];
        
        float price  = [[self checkGivenValueIsNullOrNil:[temp valueForKey:kPrice] defaultReturn:@"0.00"] floatValue];
        float quantity = (textField.text).floatValue;
        
        [temp setValue:[NSString stringWithFormat:@"%.2f",(price * quantity)] forKey:VALUE];
        
        [temp setValue:textField.text  forKey:qtyKey];
        
        rawMaterialDetails[textField.tag] = temp;
    }
    
    else if (textField.frame.origin.x == reasonsTxt.frame.origin.x) {
        
        NSMutableDictionary * temp = [rawMaterialDetails[textField.tag]  mutableCopy];
        [temp setValue:textField.text forKey:kReasonForReturn];
        
        rawMaterialDetails[textField.tag] = temp;
    }
   
    // added by roja on 23-07-2018..
    else if (textField.frame.origin.x == scanCodeTxt.frame.origin.x) {
        
        NSMutableDictionary * temp = [rawMaterialDetails[textField.tag]  mutableCopy];
        [temp setValue:textField.text forKey:ITEM_SCAN_CODE];
        
        rawMaterialDetails[textField.tag] = temp;
    }
   
    
    else if (textField == receiptRef) {
        
        @try {
            if ((textField.text).length >= 3) {
                
                [self callingStockReceipts:textField.text];
            }
            // added by roja on 25-07-2018...
            else {

                  [rawMaterialDetails removeAllObjects];
                  [cartTable reloadData];
                }
            
        }
        @catch (NSException *exception) {
            
        }
    }
    else if (textField == issueRefNo) {
        
        @try {
            if ((textField.text).length >= 3) {
                
                [self getStockIssueIds];
            }
        }
        @catch (NSException *exception) {
            
        }
    }
    else if((receiptRef.text).length>0)   {
        receiptRef.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
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

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [self keyboardWillHide];
    
     offSetViewTo = 0;
    
    if (textField.frame.origin.x == returnQtyTxt.frame.origin.x) {
        
        @try {
            
            NSString * qtyKey = QUANTITY;
            
            NSMutableDictionary * temp = [rawMaterialDetails[textField.tag] mutableCopy];
            
            float price  = [[self checkGivenValueIsNullOrNil:[temp valueForKey:kPrice] defaultReturn:@"0.00"] floatValue];
            float quantity = (textField.text).floatValue;
            
            [temp setValue:[NSString stringWithFormat:@"%.2f",(price * quantity)] forKey:VALUE];
            
            [temp setValue:textField.text forKey:qtyKey];

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


/**
 * @description  Returning the Textfield After the TextField Execution....
 * @date         12/012/2017
 * @method       textFieldShouldReturn
 * @author       Bhargav.v
 * @param        UITextField
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}



#pragma mark textView Delegates:


/**
 * @description  it is an textViewDelegate method it will be executed when user interaction........
 * @date         16/09/2016
 * @method       textViewShouldBeginEditing;
 * @author       Srinivasulu
 * @param        UITextView
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    return  YES;
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
 
        if(textView == remarks) {
            //offSetViewTo = 260;
    }
       [self keyboardWillShow];

}

/**
 * @description  it is an textViewDelegate method it will be executed when user interaction........
 * @date         16/09/2016
 * @method       textViewShouldBeginEditing;
 * @author       Srinivasulu
 * @param        UITextView
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)textViewDidEndEditing:(UITextView *)textView{
    
    @try {
        
        [self keyboardWillHide];
             // offSetViewTo = 0;
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

#pragma mark Table View Delegates:

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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if(tableView == locationTable|| tableView == skListTable || tableView == receiptIDTable ||tableView == shipModeTable || tableView == issueIdsTable || tableView  == priceTable || tableView == categoriesTbl ){
            
            return  40;
        }
        
        else if (tableView == cartTable){
            
            return 38;
            
        }
    }
   
    return 40;
}


/**
 * @description  we are Returning Number of rows in  a section....
 * @date         18/12/2017
 * @method       numberOfRowsInSection
 * @author       Bhargav.v
 * @param        NSInteger
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == locationTable){
        return locationArr.count;
    }
    else if(tableView == skListTable){
        return rawMaterials.count;
    }
    else if(tableView == cartTable){
        
        [self calculateTotal];

        return rawMaterialDetails.count;
    }
    else if (tableView == receiptIDTable) {
        return receiptIDS.count;
    }
    
    else if (tableView == shipModeTable) {
        return shipmodeList.count;
    }
    else if (tableView == issueIdsTable) {
        return issueIdsArr.count;
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
 * @description  Here we are Returning cell For Row At Index level....
 * @date         12/12/2017
 * @method       cellForRowAtIndexPath
 * @author       Bhargav.v
 * @param        UITableView
 * @param        NSIndexPath
 * @return
 * @verified By
 * @verified On
 *
 */

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
                itemMeasurementLbl.frame = CGRectMake( itemSizeLbl.frame.origin.x + itemSizeLbl.frame.size.width, 0, ReceiptID.frame.size.width - (itemSizeLbl.frame.origin.x + itemSizeLbl.frame.size.width), itemDescLbl.frame.size.height);
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
    
    else if (tableView == locationTable) {
        
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
            
            hlcell.textLabel.text =locationArr[indexPath.row] ;
            hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:18];
        } @catch (NSException *exception) {
            
        }
        
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return hlcell;
        
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
//        itemDescLbl.lineBreakMode = NSLineBreakByWordWrapping;
        itemDescLbl.lineBreakMode = NSLineBreakByTruncatingTail;

        
        itemEanLbl = [[UILabel alloc] init];
        itemEanLbl.backgroundColor = [UIColor clearColor];
        itemEanLbl.layer.borderWidth = 0;
        itemEanLbl.textAlignment = NSTextAlignmentCenter;
        itemEanLbl.numberOfLines = 1;
//        itemEanLbl.lineBreakMode = NSLineBreakByWordWrapping;
        itemEanLbl.lineBreakMode = NSLineBreakByTruncatingTail;

        
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
                
//                delRowBtn.frame = CGRectMake(reasonLbl.frame.origin.x + reasonLbl.frame.size.width+10,2,35,35);
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
                
                itemUomLbl.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:UOM] defaultReturn:@"--"];
            }
            else
                itemUomLbl.text = @"--";

            itemAvlQty.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[temp valueForKey:AVL_QTY] defaultReturn:@"0.00"]  floatValue]];
            
            returnQtyTxt.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[temp valueForKey:QUANTITY] defaultReturn:@"0.00"]  floatValue]];
            
            itemPriceLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[temp valueForKey:kPrice] defaultReturn:@"0.00"]  floatValue]];
            itemValueLbl.text = [NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[temp valueForKey:VALUE] defaultReturn:@"0.00"]  floatValue]];

            reasonsTxt.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:kReasonForReturn] defaultReturn:@"--"];
            
            // added by roja on 23-07-2018...
            batchNoTxt.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:PRODUCT_BATCH_NO] defaultReturn:@"--"];
            expiryDateTxt.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:EXPIRY_DATE] defaultReturn:@"--"];
            scanCodeTxt.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:ITEM_SCAN_CODE] defaultReturn:@"--"];

            
        }
        @catch (NSException *exception) {
            
        }
        
        hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
        hlcell.backgroundColor = [UIColor clearColor];
        return hlcell;
    }
    
    else if (tableView == receiptIDTable) {
        
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
            hlcell =  [[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:20];
            }
        }
        hlcell.textLabel.text = receiptIDS[indexPath.row];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:18];
        
        return hlcell;
    }
    else if (tableView == issueIdsTable) {
        
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
            hlcell =  [[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                hlcell.textLabel.font = [UIFont boldSystemFontOfSize:20];
            }
        }
        hlcell.textLabel.text = issueIdsArr[indexPath.row];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.textLabel.font =  [UIFont fontWithName:TEXT_FONT_NAME size:18];
        
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
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
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
 * @description  we are Selecting the Row At index Path....
 * @date         12/12/2017
 * @method       didSelectRowAtIndexPath
 * @author       Bhargav.v
 * @param        UITableView
 * @param        NSIndexPath
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
   
    if (tableView == skListTable) {
        
        //Changes Made Bhargav.v on 11/05/2018...
        //Changed The Parameter to Plucode While sending the RequestString to SkuDetails...
        //Reason:Making the plucode Search instead of searching skuid to avoid Price List...
        
        NSDictionary * detailsDic = rawMaterials[indexPath.row];
        
        NSString * inputServiceStr = [NSString stringWithFormat:@"%@",detailsDic[SKUID]];
        
        if (([detailsDic.allKeys containsObject:PLU_CODE]) && (![[detailsDic valueForKey:PLU_CODE] isKindOfClass:[NSNull class]])) {
            
            inputServiceStr = [NSString stringWithFormat:@"%@",detailsDic[PLU_CODE]];
        }
        
        [self callRawMaterialDetails:inputServiceStr];
        
        ReceiptID.text = @"";
        
        
    }
    
    else if (tableView == locationTable) {

        toLocation.text = locationArr[indexPath.row] ;
    }
    else if (tableView == shipModeTable) {
        
        shipmentMode.text = shipmodeList[indexPath.row];
    }
    else if (tableView == receiptIDTable){
        @try {
            receiptRef.text = receiptIDS[indexPath.row];

            [self callingReceiptDetails:receiptIDS[indexPath.row]];
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }
    
    else if (tableView == issueIdsTable){
        @try {
            issueRefNo.text = issueIdsArr[indexPath.row];
            [catPopOver dismissPopoverAnimated:YES];
            [self getIssueDetails:issueIdsArr[indexPath.row]];
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }
    /// Code for priceTable
    else if (tableView == priceTable)    {
        
        @try {
            transparentView.hidden = YES;
            
            NSDictionary * detailsDic = priceArr[indexPath.row];
            
            status = FALSE;
            
            int i=0;
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
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:kPrice] defaultReturn:@""] floatValue]] forKey:kPrice];
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:SALE_PRICE] defaultReturn:@""] floatValue]] forKey:SALE_PRICE];
                
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:COST] defaultReturn:@""] floatValue]] forKey:COST];
                
                //setting availiable qty....
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[detailsDic  valueForKey:QUANTITY] defaultReturn:@""] floatValue]] forKey:AVL_QTY];
                
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

#pragma mark closwe transparentView

-(void)closePriceView:(UIButton *)sender {
    transparentView.hidden = YES;
}




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
            
            saveButton.tag = conformationAlert.tag;
            submitBtn.tag = conformationAlert.tag;
            
            [self submitButtonPressed:saveButton];
        }
        else {
            
            saveButton.tag = 2;
            submitBtn.tag = 4;
            
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            
        }
    }
    
     if (alertView == delItemAlert) {
        
        if (buttonIndex == 0) {
            
            delItemAlert.tag = 4;
            
            [self delRow:nil];
            
        }
        else {
            
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            
        }
    }
}



#pragma -mark delRow method

/**
 * @description  we are Deleting the item from the cart...
 * @date         4/12/201
 * @method       delRow
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @modified BY
 * @reason
 * @return
 * @verified By
 * @verified On
 *
 */
- (void) delRow:(UIButton *) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if (delItemAlert == nil || (delItemAlert.tag == 2)) {
            
            if (delItemAlert == nil)
                delItemAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"remove_this_item_from_the_list", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"yes", nil) otherButtonTitles:NSLocalizedString(@"no", nil) , nil];
            
            delItemAlert.tag = 2;
            [delItemAlert show];
        }
        
        else {
            
            delItemAlert.tag = 2;
            
            if(rawMaterialDetails.count >= sender.tag) {
                
                [rawMaterialDetails removeObjectAtIndex:sender.tag];
                
                [cartTable reloadData];
                
                
            }
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [self  calculateTotal];
    }
}



#pragma -mark calculationTotal

/**
 * @description  here we are calculating the Totalprice of order..........
 * @requestDteFld         27/09/2016
 * @method       calculateTotal
 * @author       Srinivasulu
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

/**
 * @description
 * @date
 * @method
 * @author
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


#pragma mark Reusable Method:

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

-(void)displayAlertMessage:(NSString *)message    horizontialAxis:(float)xPostion  verticalAxis:(float)yPosition msgType:(NSString *)messageType   conentWidth:(float )labelWidth contentHeight:(float)labelHeight   isSoundRequired:(BOOL)soundStatus  timming:(float)noOfSecondsToDisplay noOfLines:(int)noOfLines {
    
    
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
            
            if(ReceiptID.isEditing)
                yPosition = ReceiptID.frame.origin.y + ReceiptID.frame.size.height;
            
            
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

/*
 * @description  removing alertMessage add in the  disPlayAlertMessage method
 * @date         18/11/2016
 * @method       removeAlertMessages
 * @author       Bhargav Ram
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
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


-(void) getStockIssueIds {
    
    @try {
        
        // [HUD show:YES];
        [HUD setHidden:NO];
        
        issueIdsArr = [NSMutableArray new];
        
        NSArray *headerKeys_ = @[REQUEST_HEADER,START_INDEX,kIssuedTo,kGoodsIssueRef];
        NSArray * headerObjects_ = @[[RequestHeader getRequestHeader], [NSString stringWithFormat:@"%d",-1], presentLocation,issueRefNo.text];
        
        NSDictionary * dictionary = [NSDictionary dictionaryWithObjects:headerObjects_ forKeys:headerKeys_];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * getStockIssueJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.stockIssueDelegate = self;
        [webServiceController stockIssueIds:getStockIssueJsonString];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}
-(void)stockIssueIdsSuccessResponse:(NSDictionary *)sucessDictionary {
    @try {
        
        
        for(NSString *issueId in [sucessDictionary valueForKey:ISSUE_IDS]){
            
            [issueIdsArr addObject:issueId];
        }
        
        if(issueIdsArr.count){
            float tableHeight = issueIdsArr.count * 40;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                tableHeight = issueIdsArr.count * 33;
            
            if(issueIdsArr.count > 5)
                tableHeight = (tableHeight/issueIdsArr.count) * 5;
            
            [self showPopUpForTables:issueIdsTable popUpWidth:issueRefNo.frame.size.width  popUpHeight:tableHeight presentPopUpAt:issueRefNo  showViewIn:goodsReturnView permittedArrowDirections:UIPopoverArrowDirectionUp];
        }
        else
            [catPopOver dismissPopoverAnimated:YES];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [issueIdsTable reloadData];
        [HUD setHidden: YES];
        
    }
}
-(void)stockISsueIdsErrorResponse:(NSString *)error{
    [HUD setHidden: YES];
}

-(void)getIssueDetails:(NSString*)issueId {
    
    @try {
        
        // [HUD show:YES];
        [HUD setHidden:NO];
        
        issueIdsArr = [NSMutableArray new];
        
        NSArray *headerKeys_ = @[REQUEST_HEADER,kGoodsIssueRef];
        NSArray * headerObjects_ = @[[RequestHeader getRequestHeader],issueId];
        
        NSDictionary * dictionary = [NSDictionary dictionaryWithObjects:headerObjects_ forKeys:headerKeys_];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * getStockIssueJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.stockIssueDelegate = self;
        [webServiceController getStockIssueDetails:getStockIssueJsonString];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}

-(void)getStockIssueDetailsErrorResponse:(NSString *)error{
    [HUD setHidden: YES];

}

-(void)getStockIssueDetailsSuccessResponse:(NSDictionary *)sucessDictionary  {
    @try {
        if ([sucessDictionary.allKeys containsObject: kIssueDetails] && [[sucessDictionary valueForKey:kIssueDetails] isKindOfClass:[NSDictionary class]] ) {
            
            NSDictionary * locDictionary = [sucessDictionary valueForKey:kIssueDetails ];
            
            if ([locDictionary.allKeys containsObject: kIssueReferenceNo] && ![[locDictionary valueForKey:kIssueReferenceNo] isKindOfClass:[NSNull class]]) {
                
                issueRefNo.text = [locDictionary valueForKey:kIssueReferenceNo];
            }
        }
        
        for (NSDictionary * dic in [sucessDictionary valueForKey:kItemDetails]) {
            
            NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc] init];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_SKU];
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESCRIPTION];
            
            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:kPrice] defaultReturn:@"0.00"]  floatValue]] forKey:iTEM_PRICE];
            
            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[dic valueForKey:COST] defaultReturn:@"0.00"]  floatValue]] forKey:iTEM_PRICE];
            
            
            [rawMaterialDetails addObject:dic];
            
        }
        [cartTable reloadData];
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






/**
 * @description     here we are handling the resposne received from services.......
 * @date            20-07-2018
 * @method          upDateStockReturnSuccessResponse:..
 * @author          roja
 * @param           NSDictionary
 * @return          void
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

                if(ReceiptID.isEditing)
                    y_axis = ReceiptID.frame.origin.y + ReceiptID.frame.size.height;

                NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"stock_return_updated_successfully",nil),@"\n",[successDictionary valueForKey:kReturnNoteRef]];

                [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width-360)/2 verticalAxis:y_axis msgType:NSLocalizedString(@"SUCCESS", nil) conentWidth:400 contentHeight:60 isSoundRequired:YES timming:3.0 noOfLines:1];
            }
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
    }
}


/**
 * @description     here we are handling the resposne received from services.......
 * @date            20-07-2018
 * @method          upDateStockReturnSuccessResponse:..
 * @author          roja
 * @param           NSString
 * @return          void
 * @modified BY
 * @reason
 * @verified By
 * @verified On
 *
 */

-(void)upDateStockReturnErrorResponse:(NSString *) errorResponse {
    
    @try {

        submitBtn.userInteractionEnabled = YES;

        //upto here on 02/05/2018....

        [HUD setHidden:YES];

        [self displayAlertMessage:errorResponse horizontialAxis:(self.view.frame.size.width-360)/2 verticalAxis:self.view.frame.size.height - 140 msgType:@"" conentWidth:400 contentHeight:100 isSoundRequired:YES timming:3.0 noOfLines:1];

    }
    @catch (NSException *exception) {

    }
    @finally {
    }
}


@end

